Return-Path: <SRS0=KrIT=45=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF7CC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73EBB20650
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2020 14:21:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1GGPGY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73EBB20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 443F86EAD0;
	Thu, 12 Mar 2020 14:21:43 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AED56EAD0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 14:21:42 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id l18so7678912wru.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2020 07:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XJG/XwUiq1n4axSZ1ZF7zkNZoQCEEbC5EZjNTBUv+jc=;
 b=k1GGPGY5/DNbDGMl3hFlWPe536Ta4D+hqwRNWxaKIWqzDzVKI9Suk16VDOLFcYBUqu
 +w3LNEq2zhvvVT3jhVYgu2mi3tAH9iSjkrGdAd7ecJjhN1e01/JEsBz2z48JSiB2j2Yr
 SiZq3QxR4qlcW3PaZktP0rqxWF8uzVCmH9dedAqYXJBmEf/BaV5BrwOCUIoD/HTZW9YX
 8hmpwDf8BRy1TKGaYOfcWBERQxdIgwmT050Qfdt6PnZRDhYUmGJ/t794trjGuwXmLrPC
 pSexWoRk0+M8OIsvuuxUkEVBha8EYQAX7Ytq9Y/to/kfoNU3ZKGnNccHjACgFDwkGtgi
 0J8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XJG/XwUiq1n4axSZ1ZF7zkNZoQCEEbC5EZjNTBUv+jc=;
 b=RXEaXcyLNSZHadSn8K9/RxIMQlp1PtsFNAVDygiMhQiFLCoCEKrbzN86GDETvpr1Co
 zxA14g/iFQ/CGRDXwEHGam7UkVidhUhHt1Abk6n4n7Bo3SqPEI/0ejEyw7qWlLc1Y9Y7
 mXsfa20Eal/bfckyXgnjFuFr97/x+wTBXQFyRP/LzbBuPh0HMQ68EmHUtXsBOirKqS7f
 sWModecDFX9GME16mWphd1f1U2Ergev3ELm7w0394YlvnDgKLbEGgEI1/ez52IBSEHW8
 I0tttqMcRtU9JiodHzz7v0XPNNWpI89ZI8e15CWUbb312ejYKrfGE3yBmxjbUb+UZMAb
 7lsg==
X-Gm-Message-State: ANhLgQ16eBK1l9COgHfVAyCVrdJDe3ZbIlNbJmfYtGx7cnzK/r6JpRJl
 KRbkS8ezQ8DPgbrH2gspJLkHd2IjX3sDr6k2bQo=
X-Google-Smtp-Source: ADFU+vs4nsgFtOGVuH12c8H+kSgKm+ZH6oPkKk7v/hngJMd62YHERJwnmbDbSOhCtMIS4LfxCObxTPc6wxOB84rkztQ=
X-Received: by 2002:a5d:5446:: with SMTP id w6mr11767349wrv.419.1584022900733; 
 Thu, 12 Mar 2020 07:21:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200312113231.GD20562@mwanda>
In-Reply-To: <20200312113231.GD20562@mwanda>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Mar 2020 10:21:29 -0400
Message-ID: <CADnq5_O8CCdXR0LRfe5_Y_asydv0zDetWdYAteLt9=jw6DuVTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: clean up a condition in
 dmub_psr_copy_settings()
To: Dan Carpenter <dan.carpenter@oracle.com>
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 kernel-janitors@vger.kernel.org, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
 Wyatt Wood <wyatt.wood@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 12, 2020 at 7:32 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> We can remove the NULL check for "res_ctx" and
> "res_ctx->pipe_ctx[i].stream->link".  Also it's nicer to align the
> conditions using spaces so I re-indented a bit.
>
> Longer explanation: The "res_ctx" pointer points to an address in the
> middle of a struct so it can't be NULL.  For
> "res_ctx->pipe_ctx[i].stream->link" we know that it is equal to "link"
> and "link" is non-NULL.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> index 9c88a92bd96a..bc109d4fc6e6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
> @@ -134,11 +134,9 @@ static bool dmub_psr_copy_settings(struct dmub_psr *dmub,
>         int i = 0;
>
>         for (i = 0; i < MAX_PIPES; i++) {
> -               if (res_ctx &&
> -                       res_ctx->pipe_ctx[i].stream &&
> -                       res_ctx->pipe_ctx[i].stream->link &&
> -                       res_ctx->pipe_ctx[i].stream->link == link &&
> -                       res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
> +               if (res_ctx->pipe_ctx[i].stream &&
> +                   res_ctx->pipe_ctx[i].stream->link == link &&
> +                   res_ctx->pipe_ctx[i].stream->link->connector_signal == SIGNAL_TYPE_EDP) {
>                         pipe_ctx = &res_ctx->pipe_ctx[i];
>                         break;
>                 }
> --
> 2.20.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
