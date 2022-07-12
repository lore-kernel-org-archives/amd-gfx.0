Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22AE4C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jul 2022 15:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E83A10FA3C;
	Tue, 12 Jul 2022 15:23:18 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A8810F5C4
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 15:23:16 +0000 (UTC)
Received: by mail-ej1-x62d.google.com with SMTP id b11so14890076eju.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jul 2022 08:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=O20xsyS6DgecFcSjP009N0V3mqy3LYMj0u78ZsJcpbY=;
 b=PGyfXIRtHpU6PXqnGxqtCb8PXSx/JRb8is19TDUfCau8bhle3Tyzg4RLcIY+Zys2fS
 iPYRReXRQW9A+aEnPqpK8xWURKTQ2CxjoySkf3ME8jQNX7PXLnmhGE5s9zM8TCu1TwZ8
 /sCumjAxhRBGaoSRZqm35N67FJtRfXzHW5T4xT890wH0My16wzJzye1O6u3JiM6kgGzM
 qlr95324wzkcc9ilGafv/TCznsIXbp7L6DOTjryUhWmV2IeuSS1Zp/5YRZ0Pzs5mjzyd
 U5Ea3O8Dd4CvfgZTrC7XaQEVpuRJvoGm/0ool/HfMaMKLP3js2b9iqmuJxJBFelNsr4f
 zUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=O20xsyS6DgecFcSjP009N0V3mqy3LYMj0u78ZsJcpbY=;
 b=n9NoPCHS4x1K0lF132xbPwU+UCQ+mHcGHayupqzP/AmnV1N3POoGxNWY4WZVndcMHL
 wFcZSR9lCeSXnMVkzGuSh6AjLjx8DA3Ygblx+I2aDahbP87KgyDqzKZywfGq/Jr0BMYJ
 pRlfQLyTBhmXkoSqI0iBiR1bz1TVytkntHW34hqGuVqO4QHz9k892q6GMSjEqauhqD11
 vWEHZU17+7kkmResu/NoDLSVE9Lb4p/fcvlqEZs8zP6UxE7fhkMLuuNgEUnd6DVxNvgY
 YSVn7Qc7kJdDRMIxQKnEyv6UpaetiWCkq9TpIaNDleAlCyXkdWse70JKf8aiIIFL6xh/
 09ZQ==
X-Gm-Message-State: AJIora9Mtw9qF6mEVcdO3v7wOPNYA3NtWA8+db3fogAmiEloWGPTb7Cf
 P3nac5UeocPc2ujobnNaYcHNSWsa99aXaH6Yj5YeF8g7
X-Google-Smtp-Source: AGRyM1tcAuA5qU3V/EFI1vRqrXwRliPfbnkOONytztwVgSV7VQ+v6kAF7OveQ1/au9ATuMo9OlNNt+0IhwXcBNqxKJU=
X-Received: by 2002:a17:907:d22:b0:726:dbb1:8828 with SMTP id
 gn34-20020a1709070d2200b00726dbb18828mr25202275ejc.722.1657639394826; Tue, 12
 Jul 2022 08:23:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220711145131.712825-1-michel@daenzer.net>
In-Reply-To: <20220711145131.712825-1-michel@daenzer.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 12 Jul 2022 11:23:03 -0400
Message-ID: <CADnq5_PhLo4wX8vT3ZddxJ5qL0WonxOVRgou+12XtWpiM4Kwrg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Ensure valid event timestamp for
 cursor-only commits
To: =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel@daenzer.net>
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
Cc: Dor Askayo <dor.askayo@gmail.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Jul 11, 2022 at 10:51 AM Michel D=C3=A4nzer <michel@daenzer.net> wr=
ote:
>
> From: Michel D=C3=A4nzer <mdaenzer@redhat.com>
>
> Requires enabling the vblank machinery for them.
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/2030
> Signed-off-by: Michel D=C3=A4nzer <mdaenzer@redhat.com>

This looks correct to me, but it would be good if one of the display
guys could take a look.
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 43 +++++++++++++++++--
>  1 file changed, 40 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9dd2e0601ea8..b0667e2f3fdd 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -462,6 +462,26 @@ static void dm_pflip_high_irq(void *interrupt_params=
)
>                      vrr_active, (int) !e);
>  }
>
> +static void dm_crtc_handle_vblank(struct amdgpu_crtc *acrtc)
> +{
> +       struct drm_crtc *crtc =3D &acrtc->base;
> +       struct drm_device *dev =3D crtc->dev;
> +       unsigned long flags;
> +
> +       drm_crtc_handle_vblank(crtc);
> +
> +       spin_lock_irqsave(&dev->event_lock, flags);
> +
> +       /* Send completion event for cursor-only commits */
> +       if (acrtc->event && acrtc->pflip_status !=3D AMDGPU_FLIP_SUBMITTE=
D) {
> +               drm_crtc_send_vblank_event(crtc, acrtc->event);
> +               drm_crtc_vblank_put(crtc);
> +               acrtc->event =3D NULL;
> +       }
> +
> +       spin_unlock_irqrestore(&dev->event_lock, flags);
> +}
> +
>  static void dm_vupdate_high_irq(void *interrupt_params)
>  {
>         struct common_irq_params *irq_params =3D interrupt_params;
> @@ -500,7 +520,7 @@ static void dm_vupdate_high_irq(void *interrupt_param=
s)
>                  * if a pageflip happened inside front-porch.
>                  */
>                 if (vrr_active) {
> -                       drm_crtc_handle_vblank(&acrtc->base);
> +                       dm_crtc_handle_vblank(acrtc);
>
>                         /* BTR processing for pre-DCE12 ASICs */
>                         if (acrtc->dm_irq_params.stream &&
> @@ -552,7 +572,7 @@ static void dm_crtc_high_irq(void *interrupt_params)
>          * to dm_vupdate_high_irq after end of front-porch.
>          */
>         if (!vrr_active)
> -               drm_crtc_handle_vblank(&acrtc->base);
> +               dm_crtc_handle_vblank(acrtc);
>
>         /**
>          * Following stuff must happen at start of vblank, for crc
> @@ -9134,6 +9154,7 @@ static void amdgpu_dm_commit_planes(struct drm_atom=
ic_state *state,
>         struct amdgpu_bo *abo;
>         uint32_t target_vblank, last_flip_vblank;
>         bool vrr_active =3D amdgpu_dm_vrr_active(acrtc_state);
> +       bool cursor_update =3D false;
>         bool pflip_present =3D false;
>         struct {
>                 struct dc_surface_update surface_updates[MAX_SURFACES];
> @@ -9169,8 +9190,13 @@ static void amdgpu_dm_commit_planes(struct drm_ato=
mic_state *state,
>                 struct dm_plane_state *dm_new_plane_state =3D to_dm_plane=
_state(new_plane_state);
>
>                 /* Cursor plane is handled after stream updates */
> -               if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR)
> +               if (plane->type =3D=3D DRM_PLANE_TYPE_CURSOR) {
> +                       if ((fb && crtc =3D=3D pcrtc) ||
> +                           (old_plane_state->fb && old_plane_state->crtc=
 =3D=3D pcrtc))
> +                               cursor_update =3D true;
> +
>                         continue;
> +               }
>
>                 if (!fb || !crtc || pcrtc !=3D crtc)
>                         continue;
> @@ -9333,6 +9359,17 @@ static void amdgpu_dm_commit_planes(struct drm_ato=
mic_state *state,
>                                 bundle->stream_update.vrr_infopacket =3D
>                                         &acrtc_state->stream->vrr_infopac=
ket;
>                 }
> +       } else if (cursor_update && acrtc_state->active_planes > 0 &&
> +                  !acrtc_state->force_dpms_off &&
> +                  acrtc_attach->base.state->event) {
> +               drm_crtc_vblank_get(pcrtc);
> +
> +               spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
> +
> +               acrtc_attach->event =3D acrtc_attach->base.state->event;
> +               acrtc_attach->base.state->event =3D NULL;
> +
> +               spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
>         }
>
>         /* Update the planes if changed or disable if we don't have any. =
*/
> --
> 2.36.1
>
