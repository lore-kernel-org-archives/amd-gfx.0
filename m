From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] drm: prefix header search paths with $(srctree)/
Date: Mon, 18 Feb 2019 13:42:46 +0900
Message-ID: <CAK7LNARkmkQr7Q2rhdB0GVFnvSpspRkoM1f9+=ULJ9y-aXQ3NQ@mail.gmail.com>
References: <1548906999-22143-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1548906999-22143-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>
Cc: freedreno@lists.freedesktop.org, Zhenyu Wang <zhenyuw@linux.intel.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, intel-gfx@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Jani Nikula <jani.nikula@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Rob Clark <robdclark@gmail.com>, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, Zhi Wang <zhi.a.wang@intel.com>, intel-gvt-dev@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Jan 31, 2019 at 1:01 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Currently, the Kbuild core manipulates header search paths in a crazy
> way [1].
>
> To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> the search paths in the srctree. Some Makefiles are already written in
> that way, but not all. The goal of this work is to make the notation
> consistent, and finally get rid of the gross hacks.
>
> Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> ("kbuild: do not drop -I without parameter").
>
> [1]: https://patchwork.kernel.org/patch/9632347/
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---


Could you take a look at this series, please?

Thanks.





> I put all gpu/drm changes into a single patch because
> they are trivial conversion.
>
> Please let me know if I need to split this into per-driver patches.
>
>
>  drivers/gpu/drm/amd/amdgpu/Makefile | 2 +-
>  drivers/gpu/drm/amd/lib/Makefile    | 2 +-
>  drivers/gpu/drm/i915/gvt/Makefile   | 2 +-
>  drivers/gpu/drm/msm/Makefile        | 6 +++---
>  drivers/gpu/drm/nouveau/Kbuild      | 8 ++++----
>  5 files changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
> index f76bcb9..b21ebb0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -23,7 +23,7 @@
>  # Makefile for the drm device driver.  This driver provides support for the
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>
> -FULL_AMD_PATH=$(src)/..
> +FULL_AMD_PATH=$(srctree)/$(src)/..
>  DISPLAY_FOLDER_NAME=display
>  FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
>
> diff --git a/drivers/gpu/drm/amd/lib/Makefile b/drivers/gpu/drm/amd/lib/Makefile
> index 6902430..d534992 100644
> --- a/drivers/gpu/drm/amd/lib/Makefile
> +++ b/drivers/gpu/drm/amd/lib/Makefile
> @@ -27,6 +27,6 @@
>  # driver components or later moved to kernel/lib for sharing with
>  # other drivers.
>
> -ccflags-y := -I$(src)/../include
> +ccflags-y := -I $(srctree)/$(src)/../include
>
>  obj-$(CONFIG_CHASH) += chash.o
> diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt/Makefile
> index b016dc7..a4a5a96 100644
> --- a/drivers/gpu/drm/i915/gvt/Makefile
> +++ b/drivers/gpu/drm/i915/gvt/Makefile
> @@ -5,6 +5,6 @@ GVT_SOURCE := gvt.o aperture_gm.o handlers.o vgpu.o trace_points.o firmware.o \
>         execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debugfs.o \
>         fb_decoder.o dmabuf.o page_track.o
>
> -ccflags-y                              += -I$(src) -I$(src)/$(GVT_DIR)
> +ccflags-y                              += -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
>  i915-y                                 += $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
>  obj-$(CONFIG_DRM_I915_GVT_KVMGT)       += $(GVT_DIR)/kvmgt.o
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 56a70c7..b7b1ebd 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ccflags-y := -Idrivers/gpu/drm/msm
> -ccflags-y += -Idrivers/gpu/drm/msm/disp/dpu1
> -ccflags-$(CONFIG_DRM_MSM_DSI) += -Idrivers/gpu/drm/msm/dsi
> +ccflags-y := -I $(srctree)/$(src)
> +ccflags-y += -I $(srctree)/$(src)/disp/dpu1
> +ccflags-$(CONFIG_DRM_MSM_DSI) += -I $(srctree)/$(src)/dsi
>
>  msm-y := \
>         adreno/adreno_device.o \
> diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbuild
> index b17843d..b4bc88ad 100644
> --- a/drivers/gpu/drm/nouveau/Kbuild
> +++ b/drivers/gpu/drm/nouveau/Kbuild
> @@ -1,7 +1,7 @@
> -ccflags-y += -I$(src)/include
> -ccflags-y += -I$(src)/include/nvkm
> -ccflags-y += -I$(src)/nvkm
> -ccflags-y += -I$(src)
> +ccflags-y += -I $(srctree)/$(src)/include
> +ccflags-y += -I $(srctree)/$(src)/include/nvkm
> +ccflags-y += -I $(srctree)/$(src)/nvkm
> +ccflags-y += -I $(srctree)/$(src)
>
>  # NVKM - HW resource manager
>  #- code also used by various userspace tools/tests
> --
> 2.7.4
>


-- 
Best Regards
Masahiro Yamada
