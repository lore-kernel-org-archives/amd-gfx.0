Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0423DCA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 21:23:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A519510E08C;
	Tue, 12 Aug 2025 21:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="iP77S8O/";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C14A10E08C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 21:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=K5S6VN9WPp3Eq73+IyBcZdAlbAB5KqJHdSQ9dKqyQfo=; b=iP77S8O/iR6J/HkIpm55fAEGSf
 peiNmdHRwPl3k53QOlZUapyp91E+zTfYx96GJuys89+YmHgpcC6g7vIUvdXYDhTVeZ8t8S9SmueqQ
 7U4na3e0dHKFrzFeMW6m24U3x982ZxHfXWwpezplRkSFv7TErHAwBMu6L4NH2H4lG8ghj1F0dWQ6H
 fXExGdHr+pPvYKVmeLu8xGK8SfLHnYquRDo8MdXO5hR8g8wVe/W2VTIEk8IdR5ZgyMbrz9GOrR9CE
 2ENiFECHsyggc0uj/9oENi4i+JBK2LnCd8Z8c1hUfLv7WfYp6xaWKVJ9tDwlBLTmYaOXeFXtwaIhf
 3Fj8le8g==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulwSd-00DPJ1-1x; Tue, 12 Aug 2025 23:23:11 +0200
Date: Tue, 12 Aug 2025 15:23:07 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Alex Hung <alex.hung@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 2/3] drm/amd/display: Disable VRR on DCE 6
Message-ID: <fogp2e24lg6ggop7ycjzqi3rmeyx7reib6fgxnkwrsu5drs6vb@gu3er5lb5yg5>
References: <20250802160602.12698-1-timur.kristof@gmail.com>
 <20250802160602.12698-3-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250802160602.12698-3-timur.kristof@gmail.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 08/02, Timur Kristóf wrote:
> DCE 6 was not advertised as being able to support VRR,
> so let's mark it as unsupported for now.
> 
> The VRR implementation in amdgpu_dm depends on the VUPDATE
> interrupt which is not registered for DCE 6.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
>  drivers/gpu/drm/amd/display/dc/dc_helper.c        | 5 +++++
>  drivers/gpu/drm/amd/display/dc/dm_services.h      | 2 ++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c71167ffdb76..470f831a17f7 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10689,6 +10689,8 @@ static void get_freesync_config_for_crtc(
>  		} else {
>  			config.state = VRR_STATE_INACTIVE;
>  		}
> +	} else {
> +		config.state = VRR_STATE_UNSUPPORTED;
>  	}
>  out:
>  	new_crtc_state->freesync_config = config;
> @@ -12590,7 +12592,7 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
>  
>  	dm_con_state = to_dm_connector_state(connector->state);
>  
> -	if (!adev->dm.freesync_module)
> +	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
>  		goto update;
>  
>  	edid = drm_edid_raw(drm_edid); // FIXME: Get rid of drm_edid_raw()
> diff --git a/drivers/gpu/drm/amd/display/dc/dc_helper.c b/drivers/gpu/drm/amd/display/dc/dc_helper.c
> index 51e41aed7316..5a365bd19933 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc_helper.c
> +++ b/drivers/gpu/drm/amd/display/dc/dc_helper.c
> @@ -755,3 +755,8 @@ char *dce_version_to_string(const int version)
>  		return "Unknown";
>  	}
>  }
> +
> +bool dc_supports_vrr(const enum dce_version v)
> +{
> +	return v >= DCE_VERSION_8_0;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
> index 7b9c22c45453..7b398d4f4439 100644
> --- a/drivers/gpu/drm/amd/display/dc/dm_services.h
> +++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
> @@ -311,4 +311,6 @@ void dm_dtn_log_end(struct dc_context *ctx,
>  
>  char *dce_version_to_string(const int version);
>  
> +bool dc_supports_vrr(const enum dce_version v);
> +
>  #endif /* __DM_SERVICES_H__ */
> -- 
> 2.50.1
>

This change also lgtm,

CCed other display folks.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
 
Thanks

-- 
Rodrigo Siqueira
