load(
    "@org_tensorflow//tensorflow:tensorflow.bzl",
    "tf_copts",
)
load(
    "@local_config_cuda//cuda:build_defs.bzl",
    "if_cuda",
)
# load(
#     "@local_config_rocm//rocm:build_defs.bzl",
#     "if_dcu",
#     "if_rocm",
# )

def disc_cc_library(copts = tf_copts(), **kwargs):
    """Generate a cc_library with device related copts.
    """
    native.cc_library(
        copts = (copts + if_cuda(["-DGOOGLE_CUDA=1"])),
        **kwargs
    )

def if_platform_alibaba(if_true, if_false = []):
    return select({
        "//tensorflow/compiler/mlir/util:is_platform_alibaba": if_true,
        "//conditions:default": if_false,
    })

def if_cuda_or_rocm(if_true, if_false = []):
    return select({
        "@local_config_cuda//cuda:using_nvcc": if_true,
        "@local_config_cuda//cuda:using_clang": if_true,
        "//conditions:default": if_false,
    })

def if_patine(if_true, if_false = []):
    return select({
        "//tensorflow/compiler/mlir/util:is_patine": if_true,
        "//conditions:default": if_false,
    })

def if_blade_gemm(if_true, if_false = []):
    return select({
        "//tensorflow/compiler/mlir/util:is_blade_gemm": if_true,
        "//conditions:default": if_false,
    })

def if_mkldnn(if_true, if_false = []):
    return select({
        "//tensorflow/compiler/mlir/util:is_mkldnn": if_true,
        "//conditions:default": if_false,
    })

def if_disc_aarch64(if_true, if_false = []):
    return select({
        "//tensorflow/compiler/mlir/util:disc_aarch64": if_true,
        "//conditions:default": if_false,
    })

def if_disc_x86(if_true, if_false = []):
    return select({
        "//tensorflow/compiler/mlir/util:disc_x86": if_true,
        "//conditions:default": if_false,
    })

def if_torch_disc(if_true, if_false = []):
    return select({
        "//tensorflow/compiler/mlir/util:is_torch_disc": if_true,
        "//conditions:default": if_false,
    })

def if_tf_serving(if_true, if_false = []):
    return select({
        "//tensorflow/compiler/mlir/util:is_tf_serving": if_true,
        "//conditions:default": if_false,
    })
