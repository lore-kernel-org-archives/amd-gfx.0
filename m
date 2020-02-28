Return-Path: <SRS0=XGul=4Q=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDB0C3F2CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 22:23:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C23FD20637
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Feb 2020 22:23:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rx2MB5km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23FD20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EE636F50F;
	Fri, 28 Feb 2020 22:23:32 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4066F503;
 Fri, 28 Feb 2020 22:23:30 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id m10so10305689wmc.0;
 Fri, 28 Feb 2020 14:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=l0tnqF1kF4eV88+pytdt7G0UCu2eYAnWTlo0vU6Ilok=;
 b=rx2MB5km/YacdI2Ik586qXT79BmH9inBN4Wr/FzXSkLEdCiD2qvcO0iAKj9tpQ+b9o
 eOeaFT6z59c5C0MsNLQwZ4xpyNKXhwR0lmawmtkSmRVSMz8Eid82tOPKKAPIXsWSEmPO
 Ep/yg49pHIyYKQxIIiLHvDXaUEXUnNW+U3feVaDyfzT23aHcA8UhPV6aT0NAAh/89pqB
 eB2nOJ1Tvki+g1Ln2H2lw0bGMtIO7tCudthpjoOXIjruVzC5tRzp02rzEMxz6zvu2n4A
 FBY4s5HMJuKX9X5EozOrjx4WHKC5nIP+3kvr7DTnr//RJjzch83DK72/3FTplxOQCMzA
 taXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=l0tnqF1kF4eV88+pytdt7G0UCu2eYAnWTlo0vU6Ilok=;
 b=sX4TvLNTypy1dp/lsDNlY0kQSvGNVOwPBE5xr18hgPHgjbDFvvZfzcd5KY4XZxFmzg
 +JBtMz+OeeoHE60cStT5j04dFh1YzPvonyVEa4ZLTYuJldJSQ3V8TBkT2Kv9kWzClnt5
 vi5lxZ1dnE5WAfPUHRmfUkmo3lQSeLP1WOjVtY/WJ6Y0qUQGAnaqiFUZdi4k1xI0pZGc
 CbxvztFfFhqUQR/cD9krpQdnY11GbXh6AWxNIY4ABjgP5oEEdNnh4xjHfZC5ZvXOVefq
 BRPlCuiSgy0xYGCxzt91seCFecjnBwhSqeuYp/ej5Ck3fBmogUgBIUl9FJH2yVe1GHB/
 32eA==
X-Gm-Message-State: APjAAAWPWofZM018BG5hJQGuNxoo2hfNQ6g+5Ve5QXvHid7jvUcj8UwN
 HWQNmn0ZP+DFLtg/kA+5C78aLRa2TMKu3KIbXSc=
X-Google-Smtp-Source: APXvYqxGoW/yNi+W5fE8+pSSWwKJBYHjV6hCLJqWEKQbGLWYXEA4cWY6XIX6tGqrsg90SouTwiQNSl6JXdhDeNKvtZ8=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr6822036wme.56.1582928609436; 
 Fri, 28 Feb 2020 14:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20200228131606.65041-1-colin.king@canonical.com>
In-Reply-To: <20200228131606.65041-1-colin.king@canonical.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 28 Feb 2020 17:23:17 -0500
Message-ID: <CADnq5_M17_MMfy8YqK-wn_aew1ZG2zZtsj7kaK5eM3=Em2zzzA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: fix indentation issue on a hunk of
 code
To: Colin King <colin.king@canonical.com>
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
Cc: David Zhou <David1.Zhou@amd.com>, Leo Li <sunpeng.li@amd.com>,
 kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 28, 2020 at 8:16 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There are multiple statements that are indented incorrectly. Add
> in the missing tabs.
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.  Thanks!

Alex

> ---
>  .../gpu/drm/amd/display/dc/calcs/dce_calcs.c  | 46 +++++++++----------
>  1 file changed, 23 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> index 5d081c42e81b..2c6db379afae 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/dce_calcs.c
> @@ -3265,33 +3265,33 @@ bool bw_calcs(struct dc_context *ctx,
>                                 bw_fixed_to_int(bw_mul(data->
>                                         stutter_exit_watermark[9], bw_int_to_fixed(1000)));
>
> -               calcs_output->stutter_entry_wm_ns[0].b_mark =
> -                       bw_fixed_to_int(bw_mul(data->
> -                               stutter_entry_watermark[4], bw_int_to_fixed(1000)));
> -               calcs_output->stutter_entry_wm_ns[1].b_mark =
> -                       bw_fixed_to_int(bw_mul(data->
> -                               stutter_entry_watermark[5], bw_int_to_fixed(1000)));
> -               calcs_output->stutter_entry_wm_ns[2].b_mark =
> -                       bw_fixed_to_int(bw_mul(data->
> -                               stutter_entry_watermark[6], bw_int_to_fixed(1000)));
> -               if (ctx->dc->caps.max_slave_planes) {
> -                       calcs_output->stutter_entry_wm_ns[3].b_mark =
> +                       calcs_output->stutter_entry_wm_ns[0].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> -                                       stutter_entry_watermark[0], bw_int_to_fixed(1000)));
> -                       calcs_output->stutter_entry_wm_ns[4].b_mark =
> +                                       stutter_entry_watermark[4], bw_int_to_fixed(1000)));
> +                       calcs_output->stutter_entry_wm_ns[1].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> -                                       stutter_entry_watermark[1], bw_int_to_fixed(1000)));
> -               } else {
> -                       calcs_output->stutter_entry_wm_ns[3].b_mark =
> +                                       stutter_entry_watermark[5], bw_int_to_fixed(1000)));
> +                       calcs_output->stutter_entry_wm_ns[2].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> -                                       stutter_entry_watermark[7], bw_int_to_fixed(1000)));
> -                       calcs_output->stutter_entry_wm_ns[4].b_mark =
> +                                       stutter_entry_watermark[6], bw_int_to_fixed(1000)));
> +                       if (ctx->dc->caps.max_slave_planes) {
> +                               calcs_output->stutter_entry_wm_ns[3].b_mark =
> +                                       bw_fixed_to_int(bw_mul(data->
> +                                               stutter_entry_watermark[0], bw_int_to_fixed(1000)));
> +                               calcs_output->stutter_entry_wm_ns[4].b_mark =
> +                                       bw_fixed_to_int(bw_mul(data->
> +                                               stutter_entry_watermark[1], bw_int_to_fixed(1000)));
> +                       } else {
> +                               calcs_output->stutter_entry_wm_ns[3].b_mark =
> +                                       bw_fixed_to_int(bw_mul(data->
> +                                               stutter_entry_watermark[7], bw_int_to_fixed(1000)));
> +                               calcs_output->stutter_entry_wm_ns[4].b_mark =
> +                                       bw_fixed_to_int(bw_mul(data->
> +                                               stutter_entry_watermark[8], bw_int_to_fixed(1000)));
> +                       }
> +                       calcs_output->stutter_entry_wm_ns[5].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> -                                       stutter_entry_watermark[8], bw_int_to_fixed(1000)));
> -               }
> -               calcs_output->stutter_entry_wm_ns[5].b_mark =
> -                       bw_fixed_to_int(bw_mul(data->
> -                               stutter_entry_watermark[9], bw_int_to_fixed(1000)));
> +                                       stutter_entry_watermark[9], bw_int_to_fixed(1000)));
>
>                         calcs_output->urgent_wm_ns[0].b_mark =
>                                 bw_fixed_to_int(bw_mul(data->
> --
> 2.25.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
