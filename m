Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C01C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 19:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 831DB2068D
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 19:08:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 831DB2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C1326E99B;
	Mon,  8 Jun 2020 19:08:57 +0000 (UTC)
Received: from smtprelay.hostedemail.com (smtprelay0226.hostedemail.com
 [216.40.44.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 568DC89DD2;
 Mon,  8 Jun 2020 17:16:32 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay03.hostedemail.com (Postfix) with ESMTP id 68DFC808BEAF;
 Mon,  8 Jun 2020 17:16:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fish07_050374426dbb
X-Filterd-Recvd-Size: 4141
Received: from XPS-9350.home (unknown [47.151.136.130])
 (Authenticated sender: joe@perches.com)
 by omf04.hostedemail.com (Postfix) with ESMTPA;
 Mon,  8 Jun 2020 17:16:29 +0000 (UTC)
Message-ID: <dcce7f702c674999c31fd358c3970d5fee1a6725.camel@perches.com>
Subject: Re: [PATCH] drm/amd/display: Fix indenting in
 dcn30_set_output_transfer_func()
From: Joe Perches <joe@perches.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Harry Wentland
 <harry.wentland@amd.com>
Date: Mon, 08 Jun 2020 10:16:27 -0700
In-Reply-To: <20200608141657.GB1912173@mwanda>
References: <20200608141657.GB1912173@mwanda>
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
X-Mailman-Approved-At: Mon, 08 Jun 2020 19:08:56 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 2020-06-08 at 17:16 +0300, Dan Carpenter wrote:
> These lines are a part of the if statement and they are supposed to
> be indented one more tab.
> 
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index ab20320ebc994..37c310dbb3665 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -203,9 +203,9 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
>  					stream->out_transfer_func,
>  					&mpc->blender_params, false))
>  				params = &mpc->blender_params;
> -		 /* there are no ROM LUTs in OUTGAM */
> -		if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> -			BREAK_TO_DEBUGGER();
> +			 /* there are no ROM LUTs in OUTGAM */
> +			if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)
> +				BREAK_TO_DEBUGGER();
>  		}
>  	}
>  

Maybe the if is at the right indentation but the
close brace below the if is misplaced instead?

Also, because this code uses very long identifiers,
it would read better using wider columns as the
logic in the code itself isn't complicated but the
80 column wrapping makes it seem so.

Wrapping could be something like:
---
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index ab20320ebc99..56e91a73610f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -190,18 +190,16 @@ bool dcn30_set_output_transfer_func(struct dc *dc,
 	struct pwl_params *params = NULL;
 	bool ret = false;
 
-	/* program OGAM or 3DLUT only for the top pipe*/
+	/* program OGAM or 3DLUT only for the top pipe */
 	if (pipe_ctx->top_pipe == NULL) {
-		/*program rmu shaper and 3dlut in MPC*/
+		/* program rmu shaper and 3dlut in MPC */
 		ret = dcn30_set_mpc_shaper_3dlut(pipe_ctx, stream);
-		if (ret == false && mpc->funcs->set_output_gamma && stream->out_transfer_func) {
+		if (!ret && mpc->funcs->set_output_gamma && stream->out_transfer_func) {
 			if (stream->out_transfer_func->type == TF_TYPE_HWPWL)
 				params = &stream->out_transfer_func->pwl;
-			else if (pipe_ctx->stream->out_transfer_func->type ==
-					TF_TYPE_DISTRIBUTED_POINTS &&
-					cm3_helper_translate_curve_to_hw_format(
-					stream->out_transfer_func,
-					&mpc->blender_params, false))
+			else if (pipe_ctx->stream->out_transfer_func->type == TF_TYPE_DISTRIBUTED_POINTS &&
+				 cm3_helper_translate_curve_to_hw_format(stream->out_transfer_func,
+									 &mpc->blender_params, false))
 				params = &mpc->blender_params;
 		 /* there are no ROM LUTs in OUTGAM */
 		if (stream->out_transfer_func->type == TF_TYPE_PREDEFINED)


_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
