Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EAA5C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 14:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F34076E1E6;
	Tue, 23 Nov 2021 14:41:09 +0000 (UTC)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3BB06E284
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 14:41:08 +0000 (UTC)
Received: by mail-ot1-x329.google.com with SMTP id
 n104-20020a9d2071000000b005799790cf0bso13533746ota.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 06:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Ps5fqs+41W7vTg9K5HRwN+8eYoqvzN7+yEyYpZypROo=;
 b=dGSZPYDc/5qtPkSpnOYHj1e46M/B+g5feCa3hC4LD77UJZxzyUVpReqZHrX3lCLkgW
 SGcRLfSkOFlHDOEEL37t2OeHGpsyy1fHHjdeLD3Df9x+BzZGMDi4dXV0aQiqoEIgcHtm
 /Ss4uvZuVBACXBL2o7eTuJXMiZ7WQCf7Mf9cmxw9sJJgEVmHYJ+bmAfsVXvphivki5AD
 7hs1TOmkd6Gh07/na7xOO4D6sJw8yo9u7sEPZimj/Uu9ivFNpvw2xUMT9QnGWtcIQ4up
 OkBA6Gr6MITD7WjfXYoT3T13qj4yf5HbJowzbPPXWjVrNY/mb+jhWfCPd5D3e2/acG7q
 whQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Ps5fqs+41W7vTg9K5HRwN+8eYoqvzN7+yEyYpZypROo=;
 b=TmeuI5EVkph2y1ZYFKYSOoNQfZ8nsfXpuMEHTliyEcYcyFEgjF+/yD6tMbfFtR8/yw
 yggVmkpFqQOf++q2ySzgD+uaG+5FAN1BVutdHJUOVR0hSu1ewYN1hbilNfn2D3xl9OQ0
 22ZxpYtSnPOGp1uAvvUZeb1l1/WEqdkeqa2rGoVoBwPCeddJ0oKok2Sj4hXR179KJ0VO
 7G2yUokWZg9i8v3EgTTc32pBfVShBVX8jmEwzfjQYJRcClHF21VZQ0exWdzh+uh/1+dj
 4jHBKgk26XM/noT+FzU/NlL94GOaNutgIb6+25sxUGzzUBzfPbCY/C/tQ47w1ef5CFSQ
 d5ZA==
X-Gm-Message-State: AOAM532tqIDp/JmYILcu+gy5KIPr0dJdaO1rjXe59IiEUU8ITVSYc5tg
 GGHTxbc/vDYrvhCxZ/NOKgmJVbrZmwx/QOwD4Ec=
X-Google-Smtp-Source: ABdhPJxwG22hzFvSVtv862MOd8mr+SGM25GfGdRjaWFHHBBFZJg+T7zgQ8nf5CKuljYheQ6SXb3k6umWGXpkRXGpfQY=
X-Received: by 2002:a9d:6855:: with SMTP id c21mr5017209oto.357.1637678467885; 
 Tue, 23 Nov 2021 06:41:07 -0800 (PST)
MIME-Version: 1.0
References: <20211122090353.1399178-1-flora.cui@amd.com>
 <DM5PR12MB2469709B28E24F1C8FCB573EF19F9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <BL1PR12MB51440B523B58CA96EA7BC0C0F79F9@BL1PR12MB5144.namprd12.prod.outlook.com>
 <DM4PR12MB5118A3B5FE4D3271F5793057FA609@DM4PR12MB5118.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5118A3B5FE4D3271F5793057FA609@DM4PR12MB5118.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 23 Nov 2021 09:40:56 -0500
Message-ID: <CADnq5_PrfOYKitfkFC0resAZS=SV=5UqtRtC8gke7sdbDF0r0A@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
To: "Cui, Flora" <Flora.Cui@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Chen,
 Guchun" <Guchun.Chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Nov 22, 2021 at 8:59 PM Cui, Flora <Flora.Cui@amd.com> wrote:
>
> [Public]
>
>
> Modprobe -r amdgpu get oops in amdgpu_vkms_sw_fini()
>
>               for (i =3D 0; i < adev->mode_info.num_crtc; i++)
>
>                              if (adev->mode_info.crtcs[i])
>
>                                            hrtimer_cancel(&adev->mode_inf=
o.crtcs[i]->vblank_timer);
>
> adev->mode_info.crtcs[i]->vblank_timer is not initiated as vkms init its =
own amdgpu_vkms_output-> vblank_hrtimer. This patch drop amdgpu_vkms_output=
-> vblank_hrtimer and try with adev->mode_info.crtcs[i]->vblank_timer to ke=
ep align with amdgpu_dm & dce_vx_0.c
>
>

I think this might be better as two patches.  The simple fix for this
problem would be:

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
index ce982afeff91..b620a6a3cb9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
@@ -504,8 +504,7 @@ static int amdgpu_vkms_sw_fini(void *handle)
        int i =3D 0;

        for (i =3D 0; i < adev->mode_info.num_crtc; i++)
-               if (adev->mode_info.crtcs[i])
-                       hrtimer_cancel(&adev->mode_info.crtcs[i]->vblank_ti=
mer);
+               hrtimer_cancel(&adev->amdgpu_vkms_output[i].vblank_hrtimer)=
;

        kfree(adev->mode_info.bios_hardcoded_edid);
        kfree(adev->amdgpu_vkms_output);

Then apply your patch on top to share more code with the existing dce files=
.

Alex

>
>
>
> From: Deucher, Alexander <Alexander.Deucher@amd.com>
> Sent: 2021=E5=B9=B411=E6=9C=8823=E6=97=A5 0:43
> To: Chen, Guchun <Guchun.Chen@amd.com>; Cui, Flora <Flora.Cui@amd.com>; a=
md-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
>
>
>
> [Public]
>
>
>
> Can you explain how the current code is failing?  It's not immediately ob=
vious to me.  I'm not opposed to this change, it's just not clear to me whe=
re the current code fails.
>
>
>
> Alex
>
>
>
> ________________________________
>
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Monday, November 22, 2021 8:49 AM
> To: Cui, Flora <Flora.Cui@amd.com>; amd-gfx@lists.freedesktop.org <amd-gf=
x@lists.freedesktop.org>; Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
>
>
>
> [Public]
>
> Series is:
> Reviewed-by: Guchun Chen <guchun.chen@amd.com>
>
> +Alex to comment this series as well.
>
> Regards,
> Guchun
>
> -----Original Message-----
> From: Cui, Flora <Flora.Cui@amd.com>
> Sent: Monday, November 22, 2021 5:04 PM
> To: amd-gfx@lists.freedesktop.org; Chen, Guchun <Guchun.Chen@amd.com>
> Cc: Cui, Flora <Flora.Cui@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: fix vkms hrtimer settings
>
> otherwise adev->mode_info.crtcs[] is NULL
>
> Signed-off-by: Flora Cui <flora.cui@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c | 38 ++++++++++++++++--------  =
drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h |  5 ++--
>  2 files changed, 28 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vkms.c
> index ce982afeff91..6c62c45e3e3e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.c
> @@ -16,6 +16,8 @@
>  #include "ivsrcid/ivsrcid_vislands30.h"
>  #include "amdgpu_vkms.h"
>  #include "amdgpu_display.h"
> +#include "atom.h"
> +#include "amdgpu_irq.h"
>
>  /**
>   * DOC: amdgpu_vkms
> @@ -41,14 +43,13 @@ static const u32 amdgpu_vkms_formats[] =3D {
>
>  static enum hrtimer_restart amdgpu_vkms_vblank_simulate(struct hrtimer *=
timer)  {
> -       struct amdgpu_vkms_output *output =3D container_of(timer,
> -                                                        struct amdgpu_vk=
ms_output,
> -                                                        vblank_hrtimer);
> -       struct drm_crtc *crtc =3D &output->crtc;
> +       struct amdgpu_crtc *amdgpu_crtc =3D container_of(timer, struct am=
dgpu_crtc, vblank_timer);
> +       struct drm_crtc *crtc =3D &amdgpu_crtc->base;
> +       struct amdgpu_vkms_output *output =3D
> +drm_crtc_to_amdgpu_vkms_output(crtc);
>          u64 ret_overrun;
>          bool ret;
>
> -       ret_overrun =3D hrtimer_forward_now(&output->vblank_hrtimer,
> +       ret_overrun =3D hrtimer_forward_now(&amdgpu_crtc->vblank_timer,
>                                            output->period_ns);
>          WARN_ON(ret_overrun !=3D 1);
>
> @@ -65,22 +66,21 @@ static int amdgpu_vkms_enable_vblank(struct drm_crtc =
*crtc)
>          unsigned int pipe =3D drm_crtc_index(crtc);
>          struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
>          struct amdgpu_vkms_output *out =3D drm_crtc_to_amdgpu_vkms_outpu=
t(crtc);
> +       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
>
>          drm_calc_timestamping_constants(crtc, &crtc->mode);
>
> -       hrtimer_init(&out->vblank_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_=
REL);
> -       out->vblank_hrtimer.function =3D &amdgpu_vkms_vblank_simulate;
>          out->period_ns =3D ktime_set(0, vblank->framedur_ns);
> -       hrtimer_start(&out->vblank_hrtimer, out->period_ns, HRTIMER_MODE_=
REL);
> +       hrtimer_start(&amdgpu_crtc->vblank_timer, out->period_ns,
> +HRTIMER_MODE_REL);
>
>          return 0;
>  }
>
>  static void amdgpu_vkms_disable_vblank(struct drm_crtc *crtc)  {
> -       struct amdgpu_vkms_output *out =3D drm_crtc_to_amdgpu_vkms_output=
(crtc);
> +       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
>
> -       hrtimer_cancel(&out->vblank_hrtimer);
> +       hrtimer_cancel(&amdgpu_crtc->vblank_timer);
>  }
>
>  static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crtc *crtc, @@ -=
92,13 +92,14 @@ static bool amdgpu_vkms_get_vblank_timestamp(struct drm_crt=
c *crtc,
>          unsigned int pipe =3D crtc->index;
>          struct amdgpu_vkms_output *output =3D drm_crtc_to_amdgpu_vkms_ou=
tput(crtc);
>          struct drm_vblank_crtc *vblank =3D &dev->vblank[pipe];
> +       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
>
>          if (!READ_ONCE(vblank->enabled)) {
>                  *vblank_time =3D ktime_get();
>                  return true;
>          }
>
> -       *vblank_time =3D READ_ONCE(output->vblank_hrtimer.node.expires);
> +       *vblank_time =3D READ_ONCE(amdgpu_crtc->vblank_timer.node.expires=
);
>
>          if (WARN_ON(*vblank_time =3D=3D vblank->time))
>                  return true;
> @@ -165,6 +166,8 @@ static const struct drm_crtc_helper_funcs amdgpu_vkms=
_crtc_helper_funcs =3D {  static int amdgpu_vkms_crtc_init(struct drm_devic=
e *dev, struct drm_crtc *crtc,
>                            struct drm_plane *primary, struct drm_plane *c=
ursor)  {
> +       struct amdgpu_device *adev =3D drm_to_adev(dev);
> +       struct amdgpu_crtc *amdgpu_crtc =3D to_amdgpu_crtc(crtc);
>          int ret;
>
>          ret =3D drm_crtc_init_with_planes(dev, crtc, primary, cursor, @@=
 -176,6 +179,17 @@ static int amdgpu_vkms_crtc_init(struct drm_device *dev,=
 struct drm_crtc *crtc,
>
>          drm_crtc_helper_add(crtc, &amdgpu_vkms_crtc_helper_funcs);
>
> +       amdgpu_crtc->crtc_id =3D drm_crtc_index(crtc);
> +       adev->mode_info.crtcs[drm_crtc_index(crtc)] =3D amdgpu_crtc;
> +
> +       amdgpu_crtc->pll_id =3D ATOM_PPLL_INVALID;
> +       amdgpu_crtc->encoder =3D NULL;
> +       amdgpu_crtc->connector =3D NULL;
> +       amdgpu_crtc->vsync_timer_enabled =3D AMDGPU_IRQ_STATE_DISABLE;
> +
> +       hrtimer_init(&amdgpu_crtc->vblank_timer, CLOCK_MONOTONIC, HRTIMER=
_MODE_REL);
> +       amdgpu_crtc->vblank_timer.function =3D &amdgpu_vkms_vblank_simula=
te;
> +
>          return ret;
>  }
>
> @@ -401,7 +415,7 @@ int amdgpu_vkms_output_init(struct drm_device *dev,  =
{
>          struct drm_connector *connector =3D &output->connector;
>          struct drm_encoder *encoder =3D &output->encoder;
> -       struct drm_crtc *crtc =3D &output->crtc;
> +       struct drm_crtc *crtc =3D &output->crtc.base;
>          struct drm_plane *primary, *cursor =3D NULL;
>          int ret;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_vkms.h
> index 97f1b79c0724..4f8722ff37c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vkms.h
> @@ -10,15 +10,14 @@
>  #define YRES_MAX  16384
>
>  #define drm_crtc_to_amdgpu_vkms_output(target) \
> -       container_of(target, struct amdgpu_vkms_output, crtc)
> +       container_of(target, struct amdgpu_vkms_output, crtc.base)
>
>  extern const struct amdgpu_ip_block_version amdgpu_vkms_ip_block;
>
>  struct amdgpu_vkms_output {
> -       struct drm_crtc crtc;
> +       struct amdgpu_crtc crtc;
>          struct drm_encoder encoder;
>          struct drm_connector connector;
> -       struct hrtimer vblank_hrtimer;
>          ktime_t period_ns;
>          struct drm_pending_vblank_event *event;  };
> --
> 2.25.1
