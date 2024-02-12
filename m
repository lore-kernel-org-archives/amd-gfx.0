Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E1CC4829A
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Feb 2024 08:24:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B0B310E00A;
	Tue, 13 Feb 2024 08:24:49 +0000 (UTC)
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CC010E3BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 18:37:14 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-1d751bc0c15so30863165ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Feb 2024 10:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1707763033; x=1708367833;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=klANY2AestKCsO2hbd/KM2UTkPXuILSbr/nui60CUUE=;
 b=ClbO9BHVSZjWn1Ou1kINw2c1Idp15ZpxZ35EDGBOBwWew5qBVmOodBnMLTCbJn9Fue
 ev5+Zwg5CSLwuOJI7lhqx466wDfx/EEEuBAwtgymVVMxHSvVeoiKWFvuumqaOW9mYeGr
 C2HdYtux/faibsW4oq2XWAVauNXBBZYhkoeW4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707763033; x=1708367833;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=klANY2AestKCsO2hbd/KM2UTkPXuILSbr/nui60CUUE=;
 b=uPyH86pkV7mFOhSg12uuizh/04ELUBwnrxS+faC6UMYRdBO5O2rhLEml+A/uwplJIl
 RW6JwZQ9/snH4Bwc8DmykcU+zjA+qnCNRFAbXWyYuX6Dar5LSZ6Jp17Fz2qxf/1UTNLz
 CZT+kjz1nySxQH25w1Vdd+kDwwVm5DeyBVtdwYJVdWiPODH9YSK7yZS8k06OUVaPWZVF
 npyHRawjXAC4bhFeph+JBbya/V3ODA0gprAFAHmOSAaqc8y3s6v2pHABRH84RNhfECYg
 uHb1b6q2QgTfap4QVBazc0bfp1cBBp6qdrodYn/W5UZFsc3ua3pDFwsDJVfcuLygKCAO
 Ix0A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDWJ/rvVJh8QVAcNoPvmuosE7GwtLwstRMVQAv7gYuSpdADyiYReECgac5H3sS6Pd8v3GdHlPkUzkYktItUmBLHnJ8cw8ULIOR5gMA8A==
X-Gm-Message-State: AOJu0YzNBZmrRDj0Y8oaMh3xQHIycrGiox0ZwEVj/UfUmUfjx2TFTZrP
 WKN6HV+CLxfSoe8BYQkqE84MM1bF/PnZW/b0J4fqPZCnr2aTdq5vdqW6WlmQ6g==
X-Google-Smtp-Source: AGHT+IFsRltH+M2u2OT1/3RFQjisTUhBMz5asNG2KLMOsHYsh8347oYvK1nExw/q7icJoQZ784m9HA==
X-Received: by 2002:a17:902:c40c:b0:1db:28bd:2949 with SMTP id
 k12-20020a170902c40c00b001db28bd2949mr1547470plk.0.1707763033703; 
 Mon, 12 Feb 2024 10:37:13 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVvfXKGuW6T8cdIcv8zZV/sIGuY91oBaoUVsU75uqguwQtzyDcqP3H1j3XbrMykDQOHQS/tkFBloBdoLIMzKDNuoUIZaodBtV/UACH+z27doQLLTX41w65dvbq0nFYW41SF4jvAWdk7IjrD2HJalLyhTiT3QgPA5llSqfL33qa9z0qpqYN6bQbRtYogE/9CJNgCZOQ=
Received: from www.outflux.net ([198.0.35.241])
 by smtp.gmail.com with ESMTPSA id
 x20-20020a170902e05400b001da34166cd2sm650982plx.180.2024.02.12.10.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 10:37:13 -0800 (PST)
Date: Mon, 12 Feb 2024 10:37:12 -0800
From: Kees Cook <keescook@chromium.org>
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Yongqiang Sun <yongqiang.sun@amd.com>,
 amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/amd/display: Add NULL test for 'timing generator'
 in 'dcn21_set_pipe()'
Message-ID: <202402121036.F9F6B82F@keescook>
References: <20240131032820.699251-1-srinivasan.shanmugam@amd.com>
 <20240201095845.1171852-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201095845.1171852-1-srinivasan.shanmugam@amd.com>
X-Mailman-Approved-At: Tue, 13 Feb 2024 08:24:48 +0000
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

On Thu, Feb 01, 2024 at 03:28:45PM +0530, Srinivasan Shanmugam wrote:
> In "u32 otg_inst = pipe_ctx->stream_res.tg->inst;"
> pipe_ctx->stream_res.tg could be NULL, it is relying on the caller to
> ensure the tg is not NULL.
> 
> Fixes: 474ac4a875ca ("drm/amd/display: Implement some asic specific abm call backs.")
> Cc: Yongqiang Sun <yongqiang.sun@amd.com>
> Cc: Anthony Koo <Anthony.Koo@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
> v2:
>   - s/u32/uint32_t for consistency (Anthony)
> 
>  .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 24 +++++++++++--------
>  1 file changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
> index 8e88dcaf88f5..8323077bba15 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
> @@ -206,28 +206,32 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
>  void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
>  {
>  	struct abm *abm = pipe_ctx->stream_res.abm;
> -	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
> +	struct timing_generator *tg = pipe_ctx->stream_res.tg;
>  	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
>  	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
> +	uint32_t otg_inst;
> +
> +	if (!abm && !tg && !panel_cntl)
> +		return;
> +
> +	otg_inst = tg->inst;

Is the "if" supposed to be using "||"s instead of "&&"s? I noticed
Coverity complained "tg may be NULL" for the "tg->inst" dereference...

-Kees

-- 
Kees Cook
