Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BD3BCFB43F
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Oct 2024 13:06:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECB9E10E388;
	Mon,  7 Oct 2024 13:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gwmail.gwu.edu header.i=@gwmail.gwu.edu header.b="OHEHAO5r";
	dkim-atps=neutral
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com
 [209.85.210.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C17CC10EA5A
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:20:24 +0000 (UTC)
Received: by mail-pf1-f195.google.com with SMTP id
 d2e1a72fcca58-71793afc07bso287444b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Oct 2024 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gwmail.gwu.edu; s=google; t=1728066024; x=1728670824;
 darn=lists.freedesktop.org; 
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=SoGAZIU5Lyc6A4+tnt6D5VON7IKbopZSScnnux0+cO0=;
 b=OHEHAO5r1d5b4pWKfBldTaY81GQfHRyp4BLe71VGtznGglwoP8Nspg3xd66O/Q9gml
 xK5pnyIO8V1r8S5PvDYdasNNX7QPSifaJgKevAKk0OGjnmsxpm3QTMTn39PyhAXa2Vq+
 2T3T6cpazpoYAgpyYGc0MbUaNAoIE/G+0N81tz/G116nLgi+OHt3Rg591cqzTiZciEsm
 jXiFxgh8yES89B+wLCFpsYYGdJApDiQ9zbzPqSQ2qroYVOjLjuXcsdHYvfa4j3BUmPht
 uxIHmZmfdnuLj9vOKv2rpGJa+tqBIeI8FepWEvsdse6GCduTixeOstgqDSVL2gmFeaJf
 Oi8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728066024; x=1728670824;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SoGAZIU5Lyc6A4+tnt6D5VON7IKbopZSScnnux0+cO0=;
 b=aIZU/F3vzaVFBhGWnYzI5X15+xoufDTxCNLqhUx1N0zK3arc/oUvr+4dTDd/cNG8d0
 +sRGt1LL4eOYUIrZtxfmeJlLlNU6WT/Si17agUXSNHzMyC9IFPPGAtpiwx9E37GYGHLd
 LkRO0i06EHk60XHec0P1DV6GIoZYfh3MKwDrF0D9Xt92R8sXCSSc+KGfDrLnI42i09Xc
 TeJsTFOIgrsRZQZnYjsHR0iva7b21njZ/65wJmxzWh6RQfZgZHbFjpVjdKzTiP0ZTdYa
 I/ESjUhRRiOQNs+0H5F5mgoIWufNgRicj9RgW33rzYHRB6orOjvdIsaD2XPlh6JFxAWy
 V+Bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUb2vbxhuDWhcndPphD4RtH8MPJFm6P0ixCmsauhhzWr059eyONdu3vluPrPhkL8mIQaMunNH0q@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuoA3BxZDXZl6UbNfwXZL6+W99thR8Pg6Nk2+pZJmTIZ7d4GVZ
 1M1m8MFm3gqxAZa1+31QgRq8zrzwRjjHlFV8fKuc62yaBR1JtoRQbZdMwbC3yA==
X-Google-Smtp-Source: AGHT+IH1m5PyiOreIRJ/nQ4GUuid0vEYFhSrwVunVSBHeMWEbhbknYuTiLrD11z571HSzM07Y/Uxpw==
X-Received: by 2002:a05:6a20:2453:b0:1cf:2be2:6526 with SMTP id
 adf61e73a8af0-1d6dfaea5f0mr2370139637.12.1728066024038; 
 Fri, 04 Oct 2024 11:20:24 -0700 (PDT)
Received: from threadripper-arch.router92d9be.com
 (syn-172-115-017-107.res.spectrum.com. [172.115.17.107])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71df0d67d26sm153586b3a.181.2024.10.04.11.20.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2024 11:20:23 -0700 (PDT)
From: Matthew Schwartz <mattschwartz@gwmail.gwu.edu>
X-Google-Original-From: Matthew Schwartz <matt@gwmail.gwu.edu>
Date: Fri, 4 Oct 2024 11:20:08 -0700 (PDT)
To: Melissa Wen <mwen@igalia.com>
cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Hamza Mahfooz <hamza.mahfooz@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, 
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, 
 Solomon Chiu <solomon.chiu@amd.com>, 
 Daniel Wheeler <daniel.wheeler@amd.com>, Josip Pavic <Josip.Pavic@amd.com>, 
 Aric Cyr <aric.cyr@amd.com>
Subject: Re: [PATCH 13/26] drm/amd/display: Clear update flags after update
 has been applied
In-Reply-To: <cee2e5fb-793a-4f4e-8314-a0d875ba2dde@igalia.com>
Message-ID: <036f3bc1-bd00-00ec-87ec-be17bca675c4@gwmail.gwu.edu>
References: <20241003233509.210919-1-Rodrigo.Siqueira@amd.com>
 <20241003233509.210919-14-Rodrigo.Siqueira@amd.com>
 <cee2e5fb-793a-4f4e-8314-a0d875ba2dde@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Mailman-Approved-At: Mon, 07 Oct 2024 13:06:21 +0000
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



On Fri, 4 Oct 2024, Melissa Wen wrote:

>
>
>
> On 03/10/2024 20:33, Rodrigo Siqueira wrote:
>>  From: Josip Pavic <Josip.Pavic@amd.com>
>>
>>  [Why]
>>  Since the surface/stream update flags aren't cleared after applying
>>  updates, those same updates may be applied again in a future call to
>>  update surfaces/streams for surfaces/streams that aren't actually part
>>  of that update (i.e. applying an update for one surface/stream can
>>  trigger unintended programming on a different surface/stream).
>>
>>  For example, when an update results in a call to
>>  program_front_end_for_ctx, that function may call program_pipe on all
>>  pipes. If there are surface update flags that were never cleared on the
>>  surface some pipe is attached to, then the same update will be
>>  programmed again.
>>
>>  [How]
>>  Clear the surface and stream update flags after applying the updates.
> Hi,
>
> Just to let you know: this patch fixes artifacts when transitioning from 2 to 
> 3 planes with dynamic pipe split policy on DCN301, as reported here:
>
> https://gitlab.freedesktop.org/drm/amd/-/issues/3441
>
> The problem was first seen in kernel 6.5, when multiple features were enabled 
> (plane color mgmt and zpos properties) and minimal transition state was 
> reworked.
>
> Should it be sent to stable too?
>
> Thanks,
>
> Melissa
Hello,

I wanted to confirm that this patch also fixes artifacts when utilizing 
windowed MPO ODM on DCN32, as I originally reported here:

https://gitlab.freedesktop.org/drm/amd/-/issues/3616

I bisected this as a regression in kernel 6.9, where I noticed my 7900XTX 
started to display almost identical artifacting to the issue on DCN301 
that Melissa linked. As this commit seems to resolve the regression, a 
submission to stable would be greatly appreciated.

Cheers,

Matthew
>>
>>  Reviewed-by: Aric Cyr <aric.cyr@amd.com>
>>  Signed-off-by: Josip Pavic <Josip.Pavic@amd.com>
>>  Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
>>  ---
>>    drivers/gpu/drm/amd/display/dc/core/dc.c | 45 ++++++++++++++++++------
>>    1 file changed, 34 insertions(+), 11 deletions(-)
>>
>>  diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c
>>  b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>  index 981d9a327daf..7b239cbfbb4a 100644
>>  --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
>>  +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
>>  @@ -5129,11 +5129,26 @@ static bool update_planes_and_stream_v3(struct dc
>>  *dc,
>>    	return true;
>>    }
>>
>>  +static void clear_update_flags(struct dc_surface_update *srf_updates,
>>  +	int surface_count, struct dc_stream_state *stream)
>>  +{
>>  +	int i;
>>  +
>>  +	if (stream)
>>  +		stream->update_flags.raw = 0;
>>  +
>>  +	for (i = 0; i < surface_count; i++)
>>  +		if (srf_updates[i].surface)
>>  +			srf_updates[i].surface->update_flags.raw = 0;
>>  +}
>>  +
>>    bool dc_update_planes_and_stream(struct dc *dc,
>>      struct dc_surface_update *srf_updates, int surface_count,
>>      struct dc_stream_state *stream,
>>      struct dc_stream_update *stream_update)
>>    {
>>  +	bool ret = false;
>>  +
>>     dc_exit_ips_for_hw_access(dc);
>>     /*
>>    	 * update planes and stream version 3 separates FULL and FAST updates
>>  @@ -5150,10 +5165,16 @@ bool dc_update_planes_and_stream(struct dc *dc,
>>      * features as they are now transparent to the new sequence.
>>      */
>>    	if (dc->ctx->dce_version >= DCN_VERSION_4_01)
>>  -		return update_planes_and_stream_v3(dc, srf_updates,
>>  +		ret = update_planes_and_stream_v3(dc, srf_updates,
>>    				surface_count, stream, stream_update);
>>  -	return update_planes_and_stream_v2(dc, srf_updates,
>>  +	else
>>  +		ret = update_planes_and_stream_v2(dc, srf_updates,
>>    			surface_count, stream, stream_update);
>>  +
>>  +	if (ret)
>>  +		clear_update_flags(srf_updates, surface_count, stream);
>>  +
>>  +	return ret;
>>    }
>>
>>    void dc_commit_updates_for_stream(struct dc *dc,
>>  @@ -5163,6 +5184,8 @@ void dc_commit_updates_for_stream(struct dc *dc,
>>      struct dc_stream_update *stream_update,
>>      struct dc_state *state)
>>    {
>>  +	bool ret = false;
>>  +
>>     dc_exit_ips_for_hw_access(dc);
>>     /* TODO: Since change commit sequence can have a huge impact,
>>    	 * we decided to only enable it for DCN3x. However, as soon as
>>  @@ -5170,17 +5193,17 @@ void dc_commit_updates_for_stream(struct dc *dc,
>>      * the new sequence for all ASICs.
>>      */
>>    	if (dc->ctx->dce_version >= DCN_VERSION_4_01) {
>>  -		update_planes_and_stream_v3(dc, srf_updates, surface_count,
>>  +		ret = update_planes_and_stream_v3(dc, srf_updates,
>>  surface_count,
>>    				stream, stream_update);
>>  -		return;
>>  -	}
>>  -	if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
>>  -		update_planes_and_stream_v2(dc, srf_updates, surface_count,
>>  +	} else if (dc->ctx->dce_version >= DCN_VERSION_3_2) {
>>  +		ret = update_planes_and_stream_v2(dc, srf_updates,
>>  surface_count,
>>    				stream, stream_update);
>>  -		return;
>>  -	}
>>  -	update_planes_and_stream_v1(dc, srf_updates, surface_count, stream,
>>  -			stream_update, state);
>>  +	} else
>>  +		ret = update_planes_and_stream_v1(dc, srf_updates,
>>  surface_count, stream,
>>  +				stream_update, state);
>>  +
>>  +	if (ret)
>>  +		clear_update_flags(srf_updates, surface_count, stream);
>>    }
>>
>>    uint8_t dc_get_current_stream_count(struct dc *dc)
>
>
>
