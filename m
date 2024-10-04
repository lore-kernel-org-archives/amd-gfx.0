Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A0FCCFA777
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 12:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4C210E2A8;
	Fri,  4 Oct 2024 12:56:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aHtdko+N";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED38710E2A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 12:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=e2K6IzgHmrcOW8o3PamM8gJG1kvUnTuf6XNzrhMhK2c=; b=aHtdko+N6UVnJG/gV9qbBoDZvz
 p//vpHTIhyRgU3w4WiKAwXvOjRpe+qLwMFstFhKBfoVp6bLDuEni+6gnm49g7qRHNG9POGxWY/oRk
 rkATgj8Y8ebGPFZjD5G8gq68tI72BdZo48ABBqphOs1ZUEvnpUf7LTJfMP16+q+rgFb/Zh+yHn0Du
 o+huDbrxzPLNoSAlA8Bwjc1xAHXQkRKl674H7FQzegcMSXtSWKoQjgfQRcA/iG8ItAn4E0yeWgpM5
 SOauEpUaqEyuwkNrqh+6XfWvX7wkGROHARtZUzpnd8sEk29vKN/CVX6LMcFtPp0WBfH9OavnmGZ3n
 JXQpJH0g==;
Received: from [189.6.17.125] (helo=[192.168.0.55])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1swhrQ-004q7J-DK; Fri, 04 Oct 2024 14:56:44 +0200
Message-ID: <cee2e5fb-793a-4f4e-8314-a0d875ba2dde@igalia.com>
Date: Fri, 4 Oct 2024 09:56:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/26] drm/amd/display: Clear update flags after update
 has been applied
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Josip Pavic <Josip.Pavic@amd.com>,
 Aric Cyr <aric.cyr@amd.com>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
 <20241003233509.210919-14-Rodrigo.Siqueira@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20241003233509.210919-14-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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




On 03/10/2024 20:33, Rodrigo Siqueira wrote:
> From: Josip Pavic <Josip.Pavic@amd.com>
>
> [Why]
> Since the surface/stream update flags aren't cleared after applying
> updates, those same updates may be applied again in a future call to
> update surfaces/streams for surfaces/streams that aren't actually part
> of that update (i.e. applying an update for one surface/stream can
> trigger unintended programming on a different surface/stream).
>
> For example, when an update results in a call to
> program_front_end_for_ctx, that function may call program_pipe on all
> pipes. If there are surface update flags that were never cleared on the
> surface some pipe is attached to, then the same update will be
> programmed again.
>
> [How]
> Clear the surface and stream update flags after applying the updates.
Hi,

Just to let you know: this patch fixes artifacts when transitioning from 
2 to 3 planes with dynamic pipe split policy on DCN301, as reported here:

https://gitlab.freedesktop.org/drm/amd/-/issues/3441

The problem was first seen in kernel 6.5, when multiple features were 
enabled (plane color mgmt and zpos properties) and minimal transition 
state was reworked.

Should it be sent to stable too?

Thanks,

Melissa
>
> Reviewed-by: Aric Cyr <aric.cyr@amd.com>
> Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
> Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/core/dc.c | 45 ++++++++++++++++++------
>   1 file changed, 34 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 981d9a327daf..7b239cbfbb4a 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -5129,11 +5129,26 @@ static bool update_planes_and_stream_v3(struct dc *dc,
>   	return true;
>   }
>   
> +static void clear_update_flags(struct dc_surface_update *srf_updates,
> +	int surface_count, struct dc_stream_state *stream)
> +{
> +	int i;
> +
> +	if (stream)
> +		stream->update_flags.raw = 0;
> +
> +	for (i = 0; i < surface_count; i++)
> +		if (srf_updates[i].surface)
> +			srf_updates[i].surface->update_flags.raw = 0;
> +}
> +
>   bool dc_update_planes_and_stream(struct dc *dc,
>   		struct dc_surface_update *srf_updates, int surface_count,
>   		struct dc_stream_state *stream,
>   		struct dc_stream_update *stream_update)
>   {
> +	bool ret = false;
> +
>   	dc_exit_ips_for_hw_access(dc);
>   	/*
>   	 * update planes and stream version 3 separates FULL and FAST updates
> @@ -5150,10 +5165,16 @@ bool dc_update_planes_and_stream(struct dc *dc,
>   	 * features as they are now transparent to the new sequence.
>   	 */
>   	if (dc->ctx->dce_version >= DCN_VERSION_4_01)
> -		return update_planes_and_stream_v3(dc, srf_updates,
> +		ret = update_planes_and_stream_v3(dc, srf_updates,
>   				surface_count, stream, stream_update);
> -	return update_planes_and_stream_v2(dc, srf_updates,
> +	else
> +		ret = update_planes_and_stream_v2(dc, srf_updates,
>   			surface_count, stream, stream_update);
> +
> +	if (ret)
> +		clear_update_flags(srf_updates, surface_count, stream);
> +
> +	return ret;
>   }
>   
>   void dc_commit_updates_for_stream(struct dc *dc,
> @@ -5163,6 +5184,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
>   		struct dc_stream_update *stream_update,
>   		struct dc_state *state)
>   {
> +	bool ret = false;
> +
>   	dc_exit_ips_for_hw_access(dc);
>   	/* TODO: Since change commit sequence can have a huge impact,
>   	 * we decided to only enable it for DCN3x. However, as soon as
> @@ -5170,17 +5193,17 @@ void dc_commit_updates_for_stream(struct dc *dc,
>   	 * the new sequence for all ASICs.
>   	 */
>   	if (dc->ctx->dce_version >= DCN_VERSION_4_01) {
> -		update_planes_and_stream_v3(dc, srf_updates, surface_count,
> +		ret = update_planes_and_stream_v3(dc, srf_updates, surface_count,
>   				stream, stream_update);
> -		return;
> -	}
> -	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
> -		update_planes_and_stream_v2(dc, srf_updates, surface_count,
> +	} else if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
> +		ret = update_planes_and_stream_v2(dc, srf_updates, surface_count,
>   				stream, stream_update);
> -		return;
> -	}
> -	update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
> -			stream_update, state);
> +	} else
> +		ret = update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
> +				stream_update, state);
> +
> +	if (ret)
> +		clear_update_flags(srf_updates, surface_count, stream);
>   }
>   
>   uint8_t dc_get_current_stream_count(struct dc *dc)

