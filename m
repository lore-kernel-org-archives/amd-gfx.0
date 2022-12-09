Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B285C04FDE
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Dec 2022 21:33:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D563B10E080;
	Fri,  9 Dec 2022 21:33:13 +0000 (UTC)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B86710E080
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Dec 2022 21:33:09 +0000 (UTC)
Received: by mail-ot1-x330.google.com with SMTP id
 m6-20020a9d7e86000000b0066ec505ae93so3573811otp.9
 for <amd-gfx@lists.freedesktop.org>; Fri, 09 Dec 2022 13:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BSDm5lKUnPjqd+yJe6eyG5AGVpipyrTBq2knLCWCgxs=;
 b=jeuycRO4qnQVED1Hdrz/rUUoS5qUGb46UytUufhaKgECLBGf4AQI0IzCIq/JqnFakc
 OxiTgvXc7LU4ySecTTDEgCDEsVxJZcEGfsBxC4s6xvUU3HA3GrAk4hRJIt8S7UrqphVb
 SPzUaOJG7MwxC8KLUcI7xtIL0XWZCfjPdCK28WdHTH9nwdoWyuSdkMNr9LNC207JrgoK
 la8JKfXDkecGe1VCxPLCoJsktV8uzQ7GMxis4JjAZER4qqSxup+WHTFqrH4AVnYvbm4p
 8Uh7u3a3Z9/UAfAfAtLJ3ZXRBMpuK1L3T3rdio8uZkyCvy9s5NJfgT92gWRFTokudHEA
 c2SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BSDm5lKUnPjqd+yJe6eyG5AGVpipyrTBq2knLCWCgxs=;
 b=H1oy8QUkyO1kPEfVGxRC9NSkihMXCxGEjv/WZoFP7VwGDIjDYLpiPV5z82wzq7DN9u
 lEtz5rw5hFiGdg6FEiOI/dLODiIqMJtDAgfV1Zrsrm4IWV5mFTr+axO0DIaH3k+DwdH4
 HvghBiN3uuhDmxXubxCPNJLIeRBv6FHhIIq+dX7MW2bD3td2/crPEhIdKGBqCrptUgB8
 hCFHxK/DqvultV6mFaO0+WkgtkwXgFoxa2lxp3M8xHShD+aA6uPnMv55AghNJTlt1CVr
 kDSSA5a8aots+BkmB5XnzbInI/fuGaTYZc2OJ6g1DXpYouwrKL0qd7hjOrNeASB2e2Uv
 tmnA==
X-Gm-Message-State: ANoB5pn7KXSLCvk4mKgRItX2UnHkk5J+PRrTVnFSjhcZ/kf7BvM2DGaL
 6Zv5sq2BAM91Yf2CHatLGGtKb1sPjhBZpzTcOZqqGlgV
X-Google-Smtp-Source: AA0mqf5fLnSYTZxOyAFCyXZX8PZtvA8DeRYDTBHgnnbydjPlVLgxXeDaVRQpf3y/tJW2G1y1kPl7s37wijIxjA35HI4=
X-Received: by 2002:a9d:628b:0:b0:66c:6afa:5006 with SMTP id
 x11-20020a9d628b000000b0066c6afa5006mr41632845otk.233.1670621589109; Fri, 09
 Dec 2022 13:33:09 -0800 (PST)
MIME-Version: 1.0
References: <20221209163647.25704-1-jdhillon@amd.com>
 <20221209163647.25704-11-jdhillon@amd.com>
In-Reply-To: <20221209163647.25704-11-jdhillon@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 9 Dec 2022 16:32:57 -0500
Message-ID: <CADnq5_OFDampu1A78BPMTiXpa4=V7cbpiCpbR=1C_uKCs=Q+zw@mail.gmail.com>
Subject: Re: [PATCH 10/23] drm/amd/display: phase3 mst hdcp for multiple
 displays
To: jdhillon <jdhillon@amd.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 hersen wu <hersenxs.wu@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Dec 9, 2022 at 11:37 AM jdhillon <jdhillon@amd.com> wrote:
>
> From: hersen wu <hersenxs.wu@amd.com>
>
> [Why]
> multiple display hdcp are enabled within event_property_validate,
> event_property_update by looping all displays on mst hub. when
> one of display on mst hub in unplugged or disabled, hdcp are
> disabled for all displays on mst hub within hdcp_reset_display
> by looping all displays of mst link. for displays still active,
> their encryption status are off. kernel driver will not run hdcp
> authentication again. therefore, hdcp are not enabled automatically.
>
> [How]
> within is_content_protection_different, check drm_crtc_state changes
> of all displays on mst hub, if need, triger hdcp_update_display to
> re-run hdcp authentication.
>
> Reviewed-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
> Signed-off-by: hersen wu <hersenxs.wu@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 118 ++++++++++++------
>  1 file changed, 81 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 7affe0899418..dc23801de071 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7374,27 +7374,55 @@ is_scaling_state_different(const struct dm_connector_state *dm_state,
>  }
>
>  #ifdef CONFIG_DRM_AMD_DC_HDCP
> -static bool is_content_protection_different(struct drm_connector_state *state,
> -                                           const struct drm_connector_state *old_state,
> -                                           const struct drm_connector *connector, struct hdcp_workqueue *hdcp_w)
> +static bool is_content_protection_different(struct drm_crtc_state *new_crtc_state,
> +                                           struct drm_crtc_state *old_crtc_state,
> +                                           struct drm_connector_state *new_conn_state,
> +                                           struct drm_connector_state *old_conn_state,
> +                                           const struct drm_connector *connector,
> +                                           struct hdcp_workqueue *hdcp_w)
>  {
>         struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
>         struct dm_connector_state *dm_con_state = to_dm_connector_state(connector->state);
>
> -       /* Handle: Type0/1 change */
> -       if (old_state->hdcp_content_type != state->hdcp_content_type &&
> -           state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> -               state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> +       pr_debug("[HDCP_DM] connector->index: %x connect_status: %x dpms: %x\n",
> +               connector->index, connector->status, connector->dpms);
> +       pr_debug("[HDCP_DM] state protection old: %x new: %x\n",
> +               old_conn_state->content_protection, new_conn_state->content_protection);
> +
> +       if (old_crtc_state)
> +               pr_debug("[HDCP_DM] old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
> +               old_crtc_state->enable,
> +               old_crtc_state->active,
> +               old_crtc_state->mode_changed,
> +               old_crtc_state->active_changed,
> +               old_crtc_state->connectors_changed);
> +
> +       if (new_crtc_state)
> +               pr_debug("[HDCP_DM] NEW crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
> +               new_crtc_state->enable,
> +               new_crtc_state->active,
> +               new_crtc_state->mode_changed,
> +               new_crtc_state->active_changed,
> +               new_crtc_state->connectors_changed);
> +
> +       /* hdcp content type change */
> +       if (old_conn_state->hdcp_content_type != new_conn_state->hdcp_content_type &&
> +           new_conn_state->content_protection != DRM_MODE_CONTENT_PROTECTION_UNDESIRED) {
> +               new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> +               pr_debug("[HDCP_DM] Type0/1 change %s :true\n", __func__);
>                 return true;
>         }
>
> -       /* CP is being re enabled, ignore this
> -        *
> -        * Handles:     ENABLED -> DESIRED
> -        */
> -       if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
> -           state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> -               state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
> +       /* CP is being re enabled, ignore this */
> +       if (old_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED &&
> +           new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> +               if (new_crtc_state && new_crtc_state->mode_changed) {
> +                       new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> +                       pr_debug("[HDCP_DM] ENABLED->DESIRED & mode_changed %s :true\n", __func__);
> +                       return true;
> +               };
> +               new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_ENABLED;
> +               pr_debug("[HDCP_DM] ENABLED -> DESIRED %s :false\n", __func__);
>                 return false;
>         }
>
> @@ -7402,9 +7430,9 @@ static bool is_content_protection_different(struct drm_connector_state *state,
>          *
>          * Handles:     UNDESIRED -> ENABLED
>          */
> -       if (old_state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED &&
> -           state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
> -               state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
> +       if (old_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_UNDESIRED &&
> +           new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_ENABLED)
> +               new_conn_state->content_protection = DRM_MODE_CONTENT_PROTECTION_DESIRED;
>
>         /* Stream removed and re-enabled
>          *
> @@ -7414,10 +7442,12 @@ static bool is_content_protection_different(struct drm_connector_state *state,
>          *
>          * Handles:     DESIRED -> DESIRED (Special case)
>          */
> -       if (!(old_state->crtc && old_state->crtc->enabled) &&
> -               state->crtc && state->crtc->enabled &&
> +       if (!(old_conn_state->crtc && old_conn_state->crtc->enabled) &&
> +               new_conn_state->crtc && new_conn_state->crtc->enabled &&
>                 connector->state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED) {
>                 dm_con_state->update_hdcp = false;
> +               pr_debug("[HDCP_DM] DESIRED->DESIRED (Stream removed and re-enabled) %s :true\n",
> +                       __func__);
>                 return true;
>         }
>
> @@ -7429,35 +7459,42 @@ static bool is_content_protection_different(struct drm_connector_state *state,
>          *
>          * Handles:     DESIRED -> DESIRED (Special case)
>          */
> -       if (dm_con_state->update_hdcp && state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
> -           connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
> +       if (dm_con_state->update_hdcp &&
> +       new_conn_state->content_protection == DRM_MODE_CONTENT_PROTECTION_DESIRED &&
> +       connector->dpms == DRM_MODE_DPMS_ON && aconnector->dc_sink != NULL) {
>                 dm_con_state->update_hdcp = false;
> +               pr_debug("[HDCP_DM] DESIRED->DESIRED (Hot-plug, headless s3, dpms) %s :true\n",
> +                       __func__);
>                 return true;
>         }
>
> -       /*
> -        * Handles:     UNDESIRED -> UNDESIRED
> -        *              DESIRED -> DESIRED
> -        *              ENABLED -> ENABLED
> -        */
> -       if (old_state->content_protection == state->content_protection)
> +       if (old_conn_state->content_protection == new_conn_state->content_protection) {
> +               if (new_conn_state->content_protection >= DRM_MODE_CONTENT_PROTECTION_DESIRED) {
> +                       if (new_crtc_state && new_crtc_state->mode_changed) {
> +                               pr_debug("[HDCP_DM] DESIRED->DESIRED or ENABLE->ENABLE mode_change %s :true\n",
> +                                       __func__);
> +                               return true;
> +                       };
> +                       pr_debug("[HDCP_DM] DESIRED->DESIRED & ENABLE->ENABLE %s :false\n",
> +                               __func__);
> +                       return false;
> +               };
> +
> +               pr_debug("[HDCP_DM] UNDESIRED->UNDESIRED %s :false\n", __func__);
>                 return false;
> +       }
>
> -       /*
> -        * Handles:     UNDESIRED -> DESIRED
> -        *              DESIRED -> UNDESIRED
> -        *              ENABLED -> UNDESIRED
> -        */
> -       if (state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED)
> +       if (new_conn_state->content_protection != DRM_MODE_CONTENT_PROTECTION_ENABLED) {
> +               pr_debug("[HDCP_DM] UNDESIRED->DESIRED or DESIRED->UNDESIRED or ENABLED->UNDESIRED %s :true\n",
> +                       __func__);
>                 return true;
> +       }
>
> -       /*
> -        * Handles:     DESIRED -> ENABLED
> -        */
> +       pr_debug("[HDCP_DM] DESIRED->ENABLED %s :false\n", __func__);
>         return false;
>  }
> -
>  #endif
> +
>  static void remove_stream(struct amdgpu_device *adev,
>                           struct amdgpu_crtc *acrtc,
>                           struct dc_stream_state *stream)
> @@ -8322,6 +8359,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                         new_crtc_state = drm_atomic_get_new_crtc_state(state, &acrtc->base);
>                         old_crtc_state = drm_atomic_get_old_crtc_state(state, &acrtc->base);
>                 }
> +<<<<<<< HEAD
> +=======
> +
> +>>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple displays)

rebasing leftovers.

>                 if (old_crtc_state)
>                         pr_debug("old crtc en: %x a: %x m: %x a-chg: %x c-chg: %x\n",
>                         old_crtc_state->enable,
> @@ -8384,7 +8425,10 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>                                 DRM_MODE_CONTENT_PROTECTION_DESIRED)
>                                 enable_encryption = true;
>
> +<<<<<<< HEAD
>
> +=======
> +>>>>>>> 667f52144b9a (drm/amd/display: phase3 mst hdcp for multiple displays)

here too.

>                         if (aconnector->dc_link && aconnector->dc_sink &&
>                                 aconnector->dc_link->type == dc_connection_mst_branch) {
>                                 struct hdcp_workqueue *hdcp_work = adev->dm.hdcp_workqueue;
> --
> 2.34.1
>
