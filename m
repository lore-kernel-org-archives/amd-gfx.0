Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90968C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Mar 2022 18:03:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9940892FB;
	Wed,  9 Mar 2022 18:03:11 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com
 [IPv6:2607:f8b0:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 849DD88284
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Mar 2022 17:54:09 +0000 (UTC)
Received: by mail-pl1-x629.google.com with SMTP id z3so2616640plg.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Mar 2022 09:54:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jBFD+wyF7mYmEIngOCI9ryayb21sPI/SwzZJFoYat4A=;
 b=HpG6HAT7j4CRo5QaoXMBfwJ9CbsmpPm5Oh0yqFSoE2aVPiXXVouxajZBHlX9hNfGrX
 qni6jA8QxlYa6Gb5L5BA1wliMbIb9kewRmKbHZrzTc3TzttWFfjEztK4kPiPxarfh/AO
 rDBKPfJIao6pKgNrvdxExjleARvY9TuxfRFDW2D1iYN7h+Kpe/j8yCMITJmcI+v/Pv8T
 rh7NSegYl2EYben7BGLOcJk7RoaX3X1jkkav522EWk6n8F3tuj6YPt2k14UZGBeg3jAK
 GbbwnrPvodYbo4RElL3bJZJ31XQSK/snaP9JYo+KDwSlspKlKoRiLWWjKMN19yCip3bs
 bykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jBFD+wyF7mYmEIngOCI9ryayb21sPI/SwzZJFoYat4A=;
 b=nKf6lqX+eEEIKWwdbu6htI7a986bg/JaMAXTImyjqN3V87Jizz08QKUX35LRlHbQP6
 UCDMukr6L1/A2ht4Zq5kcNlFQ4WwljPVoNbtHpdoPDF8fLqvMcdlpqhAg86G97xnt2pa
 Zl5ro5VFBcz9mxlS6MmJDcCEyKf4+I0nrsTqLTA5YepV4qpy+MrU0OQOU57pBlnPGlj+
 c7bli9pCNf6b3cli/WtlSgd7pDYwSNnUP7IhqBeEOrABlLF9Umbt8cJMfPGe4owlXJW1
 97WZ+y4mqsvNeN5uORiMhGwd4qTdrByw3s+HSV5q3ScAy+2/2AkW6PDp/iBIkx0DIblS
 uRAA==
X-Gm-Message-State: AOAM530AjyVm6FYx8LesRgKozoHU5noI45MfUseXBpFXzRpBGqyfn/A1
 DJtc6exyAz4XiEfjEZ2KSk5imihgWQozxyq9l7LYZg==
X-Google-Smtp-Source: ABdhPJz++9rzcp/EMrsnLAEVNW3Su4baIrLpqsj3B+niyx2zkBIeMZCIwdoBKI3B3g71igBe3JP3OoSfMoZ1GWgwEpw=
X-Received: by 2002:a17:902:e891:b0:152:c3a:a601 with SMTP id
 w17-20020a170902e89100b001520c3aa601mr736070plg.170.1646848448786; Wed, 09
 Mar 2022 09:54:08 -0800 (PST)
MIME-Version: 1.0
References: <20220309150606.1877288-1-sean@poorly.run>
In-Reply-To: <20220309150606.1877288-1-sean@poorly.run>
From: Rajat Jain <rajatja@google.com>
Date: Wed, 9 Mar 2022 09:53:32 -0800
Message-ID: <CACK8Z6GsZd5E74ZB9hRHWVov_cE0AfDNFcEvWeJHmtQAf_vz4A@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Add support for drm_privacy_screen
To: Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 09 Mar 2022 18:03:10 +0000
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
Cc: David Airlie <airlied@linux.ie>, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Leo Li <sunpeng.li@amd.com>, hdegoede@redhat.com,
 Sean Paul <seanpaul@chromium.org>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, alexdeucher@gmail.com,
 Alex Deucher <alexander.deucher@amd.com>, harry.wentland@amd.com,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 9, 2022 at 7:06 AM Sean Paul <sean@poorly.run> wrote:
>
> From: Sean Paul <seanpaul@chromium.org>
>
> This patch adds the necessary hooks to make amdgpu aware of privacy
> screens. On devices with privacy screen drivers (such as thinkpad-acpi),
> the amdgpu driver will defer probe until it's ready and then sync the sw
> and hw state on each commit the connector is involved and enabled.
>
> Changes in v2:
> -Tweaked the drm_privacy_screen_get() error check to avoid logging
>  errors when privacy screen is absent (Hans)
>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>
> Link: https://patchwork.freedesktop.org/patch/477640/ #v1
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c          |  9 +++++++++
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    |  3 +++
>  .../amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 16 +++++++++++++++-
>  3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 2ab675123ae3..e2cfae56c020 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -26,6 +26,7 @@
>  #include <drm/drm_aperture.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_gem.h>
> +#include <drm/drm_privacy_screen_consumer.h>
>  #include <drm/drm_vblank.h>
>  #include <drm/drm_managed.h>
>  #include "amdgpu_drv.h"
> @@ -1988,6 +1989,7 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>  {
>         struct drm_device *ddev;
>         struct amdgpu_device *adev;
> +       struct drm_privacy_screen *privacy_screen;
>         unsigned long flags = ent->driver_data;
>         int ret, retry = 0, i;
>         bool supports_atomic = false;
> @@ -2063,6 +2065,13 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>         size = pci_resource_len(pdev, 0);
>         is_fw_fb = amdgpu_is_fw_framebuffer(base, size);
>
> +       /* If the LCD panel has a privacy screen, defer probe until its ready */
> +       privacy_screen = drm_privacy_screen_get(&pdev->dev, NULL);
> +       if (IS_ERR(privacy_screen) && PTR_ERR(privacy_screen) == -EPROBE_DEFER)
> +               return -EPROBE_DEFER;
> +
> +       drm_privacy_screen_put(privacy_screen);
> +
>         /* Get rid of things like offb */
>         ret = drm_aperture_remove_conflicting_pci_framebuffers(pdev, &amdgpu_kms_driver);
>         if (ret)
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e1d3db3fe8de..9e2bb6523add 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9781,6 +9781,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                 if (acrtc) {
>                         new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
>                         old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
> +
> +                       /* Sync the privacy screen state between hw and sw */
> +                       drm_connector_update_privacy_screen(new_con_state);
>                 }
>
>                 /* Skip any modesets/resets */
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 740435ae3997..594a8002975a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/dp/drm_dp_mst_helper.h>
>  #include <drm/dp/drm_dp_helper.h>
> +#include <drm/drm_privacy_screen_consumer.h>
>  #include "dm_services.h"
>  #include "amdgpu.h"
>  #include "amdgpu_dm.h"
> @@ -506,6 +507,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>                                        struct amdgpu_dm_connector *aconnector,
>                                        int link_index)
>  {
> +       struct drm_device *dev = dm->ddev;
>         struct dc_link_settings max_link_enc_cap = {0};
>
>         aconnector->dm_dp_aux.aux.name =
> @@ -519,8 +521,20 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
>         drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
>                                       &aconnector->base);
>
> -       if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
> +       if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP) {
> +               struct drm_privacy_screen *privacy_screen)
> +
> +               /* Reference given up in drm_connector_cleanup() */
> +               privacy_screen = drm_privacy_screen_get(dev->dev, NULL);

Can we try to be more specific when looking up for privacy screen, e.g.:

privacy_screen = drm_privacy_screen_get(dev->dev,  "eDP-1");
(and then also making the corresponding change in arch_init_data[] in
drm_privacy_screen_x86.c"

My comment applies to this driver as well as to i915. The reason being
today there is only 1 internal display with privacy screen so we can
just assume that there shall be only 1 privacy-screen and that shall
apply to eDP-1/internal display. But dual display systems are not far
enough out, and perhaps external monitors with inbuilt
privacy-screens?

Essentially the gap today is that today on Chromeos ACPI side, the
device GOOG0010 represents the privacy-screen attached to the internal
display/eDP-1, but there isn't a way to make it clear in the i915 and
now amdgpu code.

Thanks,

Rajat


> +               if (!IS_ERR(privacy_screen)) {
> +                       drm_connector_attach_privacy_screen_provider(&aconnector->base,
> +                                                                    privacy_screen);
> +               } else if (PTR_ERR(privacy_screen) != -ENODEV) {
> +                       drm_err(dev, "Error getting privacy screen, ret=%d\n",
> +                               PTR_ERR(privacy_screen));
> +               }
>                 return;
> +       }
>
>         dc_link_dp_get_max_link_enc_cap(aconnector->dc_link, &max_link_enc_cap);
>         aconnector->mst_mgr.cbs = &dm_mst_cbs;
> --
> Sean Paul, Software Engineer, Google / Chromium OS
>
