Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93C78C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 08:39:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6FF110E2FE;
	Mon, 15 Jul 2024 08:39:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="irAog4vX";
	dkim-atps=neutral
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com
 [209.85.161.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82E5E10E041
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jul 2024 23:46:47 +0000 (UTC)
Received: by mail-oo1-f52.google.com with SMTP id
 006d021491bc7-5cce7626c87so771692eaf.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Jul 2024 16:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720914406; x=1721519206; darn=lists.freedesktop.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qRnrCwYTglg0RDVyNL3uVDtMB/BOkr8DVD8octAZwh4=;
 b=irAog4vX8RExh9JzToyb+rw1xnVXYwYFBpv5o5jZcE8Ig8T5LcxLLNu0tef0+R+CJf
 OpC7ets0ypoZOrFr013s+GzAHpFOn9tbAgJASHRqvEET1IxPY8k/I32n4FeumosMcDjI
 d2pLfrvSjbEL6g0fTz++WXMR0U0DWKo6vhlVBdXQEdv5wSwKxSwaF1rwGPI/a2bNsJta
 FcQqxOPKj2r60tXaCNnuKTEMLcIfSaC+3VmgnH5ZHi41KURQfbphNKP0QI/PkLk9Bcf9
 tZs436Zbuufvc7DE+3MzHeYumVSD8Ss4yapSLYCSnrEfb2wuQMnUQR1pco7IoB2unjr2
 45xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720914406; x=1721519206;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qRnrCwYTglg0RDVyNL3uVDtMB/BOkr8DVD8octAZwh4=;
 b=afiZV5VFHyW1TbD7rD6SAofvPPrApipSZOeSE3QxUqNOJLi/Hk7lkzOoPbzV0vJpB1
 RMGPUQH4roHMf6gsjERA5id61chpDYwWoiKY0DbxFSYlXR7HNsvGlOEdot5r51VQHOgD
 +GreDWuLBSAxQku5AAJErX03l/u/aey1TxkYtvt1OJD8wE8XOHOI73C5FcM8W9/7pk2c
 HwNcFAYw2c+e6/+tvEZ0hcBklTca5zLHhs71Y9PZ+bcxotuzUXgiiGGwoEedc2c5EWct
 7NO2gEmK8wZIgtom8nMDwfQZIRbiUa7Y9kUXQ20KXhr3ndo53TnBNl3KFCarLqQa5TYY
 dZRQ==
X-Gm-Message-State: AOJu0YxHGMWkiOHxfiA+8d6H4lODc27odsuKSyNsbY94MYZ4FVpz2fdi
 QgOKts6ttjYtrj76FG0aC+BIu36HbgtM7/DO8Vf0MT0tDtGXUAXoB4Ul/vnwjaY=
X-Google-Smtp-Source: AGHT+IET7cR5w6H63nOzuwfq5qwI714NTqzBLAoELIEZbwDk2KDDOmDhwPOdVxM7gT2njdflFFRL9w==
X-Received: by 2002:a05:6820:2787:b0:5ce:2f7c:62d3 with SMTP id
 006d021491bc7-5ce2f7c650emr2554666eaf.1.1720914406437; 
 Sat, 13 Jul 2024 16:46:46 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700::1cb1])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5ce76ff8accsm329101eaf.30.2024.07.13.16.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 13 Jul 2024 16:46:45 -0700 (PDT)
Date: Sat, 13 Jul 2024 18:46:38 -0500
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>
Subject: [bug report] drm/amd/display: Add DCN3 HWSEQ
Message-ID: <47ffe353-4041-4714-9d73-1768009f08d0@stanley.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Mon, 15 Jul 2024 08:39:00 +0000
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

Hello Bhawanpreet Lakha,

Commit d99f13878d6f ("drm/amd/display: Add DCN3 HWSEQ") from May 21,
2020 (linux-next), leads to the following Smatch static checker
warning:

	drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c:401 dcn30_set_output_transfer_func()
	error: we previously assumed 'mpc->funcs->set_output_gamma' could be null (see line 386)

drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn30/dcn30_hwseq.c
    373 bool dcn30_set_output_transfer_func(struct dc *dc,
    374                                 struct pipe_ctx *pipe_ctx,
    375                                 const struct dc_stream_state *stream)
    376 {
    377         int mpcc_id = pipe_ctx->plane_res.hubp->inst;
    378         struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
    379         const struct pwl_params *params = NULL;
    380         bool ret = false;
    381 
    382         /* program OGAM or 3DLUT only for the top pipe*/
    383         if (pipe_ctx->top_pipe == NULL) {
    384                 /*program rmu shaper and 3dlut in MPC*/
    385                 ret = dcn30_set_mpc_shaper_3dlut(pipe_ctx, stream);
    386                 if (ret == false && mpc->funcs->set_output_gamma) {
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
If this is NULL

    387                         if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
    388                                 params = &stream->out_transfer_func.pwl;
    389                         else if (pipe_ctx->stream->out_transfer_func.type ==
    390                                         TF_TYPE_DISTRIBUTED_POINTS &&
    391                                         cm3_helper_translate_curve_to_hw_format(
    392                                         &stream->out_transfer_func,
    393                                         &mpc->blender_params, false))
    394                                 params = &mpc->blender_params;
    395                          /* there are no ROM LUTs in OUTGAM */
    396                         if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED)
    397                                 BREAK_TO_DEBUGGER();
    398                 }
    399         }
    400 
--> 401         mpc->funcs->set_output_gamma(mpc, mpcc_id, params);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Then it will crash

    402         return ret;
    403 }

regards,
dan carpenter
