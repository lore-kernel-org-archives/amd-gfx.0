From: "james qian wang (Arm Technology China)" <james.qian.wang@arm.com>
Subject: Re: [PATCH v2] drm: prefix header search paths with $(srctree)/
Date: Fri, 29 Mar 2019 12:01:56 +0000
Message-ID: <20190329120149.GA16140@james-ThinkStation-P300>
References: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553859161-2628-1-git-send-email-yamada.masahiro@socionext.com>
Content-Language: en-US
Content-ID: <865BFCE5FA227C4B89CF3E89C08B15E5@eurprd08.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>, Zhenyu Wang <zhenyuw@linux.intel.com>, "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Jani Nikula <jani.nikula@linux.intel.com>, Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>, =?iso-8859-1?Q?Christian_K=F6nig?= <christian.koenig@amd.com>, Zhi Wang <zhi.a.wang@intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.fr>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Mar 29, 2019 at 08:32:41PM +0900, Masahiro Yamada wrote:
> Currently, the Kbuild core manipulates header search paths in a crazy
> way [1].
>=20
> To fix this mess, I want all Makefiles to add explicit $(srctree)/ to
> the search paths in the srctree. Some Makefiles are already written in
> that way, but not all. The goal of this work is to make the notation
> consistent, and finally get rid of the gross hacks.
>=20
> Having whitespaces after -I does not matter since commit 48f6e3cf5bc6
> ("kbuild: do not drop -I without parameter").
>=20
> [1]: https://patchwork.kernel.org/patch/9632347/
>=20
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
> ---
>=20
> I put all gpu/drm changes into a single patch because
> they are trivial conversion.
>=20
> If you are interested in the big picture of this work,
> the full patch set is available at the following URL.
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git =
build-test
>=20
>=20
> Changes in v2:
>   - fix up the new driver komeda
>   - Add Sam's Reviewed-by
>=20
>  drivers/gpu/drm/amd/amdgpu/Makefile         | 2 +-
>  drivers/gpu/drm/amd/lib/Makefile            | 2 +-
>  drivers/gpu/drm/arm/display/komeda/Makefile | 4 ++--
>  drivers/gpu/drm/i915/gvt/Makefile           | 2 +-
>  drivers/gpu/drm/msm/Makefile                | 6 +++---
>  drivers/gpu/drm/nouveau/Kbuild              | 8 ++++----
>  6 files changed, 12 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/am=
dgpu/Makefile
> index 466da59..62bf9da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
> @@ -23,7 +23,7 @@
>  # Makefile for the drm device driver.  This driver provides support for =
the
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
> =20
> -FULL_AMD_PATH=3D$(src)/..
> +FULL_AMD_PATH=3D$(srctree)/$(src)/..
>  DISPLAY_FOLDER_NAME=3Ddisplay
>  FULL_AMD_DISPLAY_PATH =3D $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
> =20
> diff --git a/drivers/gpu/drm/amd/lib/Makefile b/drivers/gpu/drm/amd/lib/M=
akefile
> index 6902430..d534992 100644
> --- a/drivers/gpu/drm/amd/lib/Makefile
> +++ b/drivers/gpu/drm/amd/lib/Makefile
> @@ -27,6 +27,6 @@
>  # driver components or later moved to kernel/lib for sharing with
>  # other drivers.
> =20
> -ccflags-y :=3D -I$(src)/../include
> +ccflags-y :=3D -I $(srctree)/$(src)/../include
> =20
>  obj-$(CONFIG_CHASH) +=3D chash.o
> diff --git a/drivers/gpu/drm/arm/display/komeda/Makefile b/drivers/gpu/dr=
m/arm/display/komeda/Makefile
> index 1b875e5..a72e30c 100644
> --- a/drivers/gpu/drm/arm/display/komeda/Makefile
> +++ b/drivers/gpu/drm/arm/display/komeda/Makefile
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
>  ccflags-y :=3D \
> -	-I$(src)/../include \
> -	-I$(src)
> +	-I $(srctree)/$(src)/../include \
> +	-I $(srctree)/$(src)
> =20
>  komeda-y :=3D \
>  	komeda_drv.o \
> diff --git a/drivers/gpu/drm/i915/gvt/Makefile b/drivers/gpu/drm/i915/gvt=
/Makefile
> index 271fb46..ea8324a 100644
> --- a/drivers/gpu/drm/i915/gvt/Makefile
> +++ b/drivers/gpu/drm/i915/gvt/Makefile
> @@ -5,5 +5,5 @@ GVT_SOURCE :=3D gvt.o aperture_gm.o handlers.o vgpu.o tra=
ce_points.o firmware.o \
>  	execlist.o scheduler.o sched_policy.o mmio_context.o cmd_parser.o debug=
fs.o \
>  	fb_decoder.o dmabuf.o page_track.o
> =20
> -ccflags-y				+=3D -I$(src) -I$(src)/$(GVT_DIR)
> +ccflags-y				+=3D -I $(srctree)/$(src) -I $(srctree)/$(src)/$(GVT_DIR)/
>  i915-y					+=3D $(addprefix $(GVT_DIR)/, $(GVT_SOURCE))
> diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
> index 56a70c7..b7b1ebd 100644
> --- a/drivers/gpu/drm/msm/Makefile
> +++ b/drivers/gpu/drm/msm/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
> -ccflags-y :=3D -Idrivers/gpu/drm/msm
> -ccflags-y +=3D -Idrivers/gpu/drm/msm/disp/dpu1
> -ccflags-$(CONFIG_DRM_MSM_DSI) +=3D -Idrivers/gpu/drm/msm/dsi
> +ccflags-y :=3D -I $(srctree)/$(src)
> +ccflags-y +=3D -I $(srctree)/$(src)/disp/dpu1
> +ccflags-$(CONFIG_DRM_MSM_DSI) +=3D -I $(srctree)/$(src)/dsi
> =20
>  msm-y :=3D \
>  	adreno/adreno_device.o \
> diff --git a/drivers/gpu/drm/nouveau/Kbuild b/drivers/gpu/drm/nouveau/Kbu=
ild
> index ea3035e..4fae728 100644
> --- a/drivers/gpu/drm/nouveau/Kbuild
> +++ b/drivers/gpu/drm/nouveau/Kbuild
> @@ -1,7 +1,7 @@
> -ccflags-y +=3D -I$(src)/include
> -ccflags-y +=3D -I$(src)/include/nvkm
> -ccflags-y +=3D -I$(src)/nvkm
> -ccflags-y +=3D -I$(src)
> +ccflags-y +=3D -I $(srctree)/$(src)/include
> +ccflags-y +=3D -I $(srctree)/$(src)/include/nvkm
> +ccflags-y +=3D -I $(srctree)/$(src)/nvkm
> +ccflags-y +=3D -I $(srctree)/$(src)
> =20
>  # NVKM - HW resource manager
>  #- code also used by various userspace tools/tests
> --=20
> 2.7.4

--=20
Reviewed-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.co=
m>
