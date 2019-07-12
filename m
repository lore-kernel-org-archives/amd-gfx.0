From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm/amd/amdgpu: hide #warning for missing DC config
Date: Fri, 12 Jul 2019 22:22:03 +0200
Message-ID: <CAK8P3a3wqWxPvDDYSQXBTgr335ONZ3beztoANO0hMcnWPFr0Aw@mail.gmail.com>
References: <20190712094118.1559434-1-arnd@arndb.de> <CADnq5_McVegix-m87OwHUvk80NdsFZPQ7d0X8qQtUf84h+Fg1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_McVegix-m87OwHUvk80NdsFZPQ7d0X8qQtUf84h+Fg1A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Jack Xiao <Jack.Xiao@amd.com>, Kevin Wang <kevin1.wang@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Xiaojie Yuan <xiaojie.yuan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Jul 12, 2019 at 8:02 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Jul 12, 2019 at 5:41 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > It is annoying to have #warnings that trigger in randconfig
> > builds like
> >
> > drivers/gpu/drm/amd/amdgpu/soc15.c:653:3: error: "Enable CONFIG_DRM_AMD_DC for display support on SOC15."
> > drivers/gpu/drm/amd/amdgpu/nv.c:400:3: error: "Enable CONFIG_DRM_AMD_DC for display support on navi."
> >
> > Remove these and rely on the users to turn these on.
>
> Is there some sort of informational message we could use instead?
> Unless you are a server user, most end users want this option enabled.

I don't think any compile-time output is a good idea here, a 'make -s'
build should really have no output whatsoever (and usually does).

I see that DRM_AMD_DC is already 'default y', which I would hope
to be sufficient. If you want something stronger than that, you could
make hide the option and leave it always-on unless CONFIG_EXPERT
is enabled:

diff --git a/drivers/gpu/drm/amd/display/Kconfig
b/drivers/gpu/drm/amd/display/Kconfig
index 2cfbbf3b85dd..9862a193349a 100644
--- a/drivers/gpu/drm/amd/display/Kconfig
+++ b/drivers/gpu/drm/amd/display/Kconfig
@@ -3,7 +3,7 @@ menu "Display Engine Configuration"
        depends on DRM && DRM_AMDGPU

 config DRM_AMD_DC
-       bool "AMD DC - Enable new display engine"
+       bool "AMD DC - Enable new display engine" if EXPERT
        default y
        select SND_HDA_COMPONENT if SND_HDA_CORE
        select DRM_AMD_DC_DCN1_0 if X86 && !(KCOV_INSTRUMENT_ALL &&
KCOV_ENABLE_COMPARISONS) && !CC_IS_CLANG
