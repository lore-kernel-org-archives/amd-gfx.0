Return-Path: <SRS0=r+dW=DG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3263C4727D
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F621206B7
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2020 14:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cnkUy/PE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F621206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 785B289E33;
	Tue, 29 Sep 2020 14:00:11 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A641789E33
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 14:00:10 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id t17so2285800wmi.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2020 07:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=8tzcEt+qhg8yUqs5+4X7vttv8Wttqj6vWby5fIGme78=;
 b=cnkUy/PEX0S4dUzjyn+q86h9XVio0eUu09w/YhWeZVLE9VGqo4kIVrvZ2nnXTc2tGW
 90Uv0e17mVL32GL8DeyKEs0Uo2hB2l50X6YmEdokWFiXZcE9jMoJFlgECK1eVgHFRXef
 FccKRIEaz0wLBJGoZOMdwJLZ52h8NunjW6G+2kIw/HdttY4sYXUrjjjDCnghvWvcPs5g
 E5nPt/1m4v9KtjCGch/gUzBhPHUWn7gHBVUnm7YD/rpVrdwAgdmiGRkCqcUoj67YO9Wy
 FngQXU+qdW7EvvOndy3AoxIFxY3nERhVMPFctlX5IDbKwCn9Uebd8i+AO30y9ec5M/lf
 qreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=8tzcEt+qhg8yUqs5+4X7vttv8Wttqj6vWby5fIGme78=;
 b=bHdl2NpQ3ZWG53LqJ3VVv6sOS/6ocFNOzVQoBACIwroTvBxUQlMh6yWiphPZvXWNwd
 ZuU3DYANiyEz7CpPqJV3JA0qIa+jfF/TYWVe5l++KZObcsUsqYvQuYMNh9CtGpQzvbOy
 5MXPfJSJrTBro0ahZU7NHDcrVttdZlfVEeR74Fd0TpPou33wDJdr3zDTTvTiPrdhyagY
 VwGd7FOcbZFqhPmzOrMXR2S54XSJ7ef5cBVbmE1R8DpuJ4mlgL7pSxM9gks3LzWW+Jju
 T34u5Yeu7bzR7F+AiM0jhuoeXF/CHdY9oOSnxFXRAE5S9826IBcIBru3UmE44slF/TT8
 x2wA==
X-Gm-Message-State: AOAM531ORXtb4qc6rNH7eXWzEs5xEppkdkSGzfyKVeKzfNIVE1k+lUg0
 3sHvq4Q08xmdhFea/cLnQLyYq0qgq9VIHwr34gHM9Hug
X-Google-Smtp-Source: ABdhPJx1flOM1X1RrnCcYqbze4cF8P30Iwlz0dprbWPEHlAixrLAGJbf5NKzIyw3aAcL5bBqzEM942YRgWSaNWrWgHI=
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr4855833wmj.79.1601388009239;
 Tue, 29 Sep 2020 07:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <ghwo0fzegq.fsf@gouders.net>
In-Reply-To: <ghwo0fzegq.fsf@gouders.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 29 Sep 2020 09:59:58 -0400
Message-ID: <CADnq5_Mw6hc2kv6tQMs+rfxczF6OfwFJBuBV=UzY+Vr=rCBKsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate call to
 rn_vbios_smu_get_smu_version()
To: Dirk Gouders <dirk@gouders.net>
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
Cc: Sung Lee <sung.lee@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Yongqiang Sun <yongqiang.sun@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

Alex

On Mon, Sep 28, 2020 at 3:07 AM Dirk Gouders <dirk@gouders.net> wrote:
>
> Commit 78fe9f63947a2b (drm/amd/display: Remove DISPCLK Limit Floor
> for Certain SMU Versions) added a call to
> rn_vbios_smu_get_smu_version() to set clk_mgr->smu_ver.  That field is
> initialized prior to the if-statement, already.
>
> Fixes: 78fe9f63947a2b (drm/amd/display: Remove DISPCLK Limit Floor for Certain SMU Versions)
> Signed-off-by: Dirk Gouders <dirk@gouders.net>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Sung Lee <sung.lee@amd.com>
> Cc: Yongqiang Sun <yongqiang.sun@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> index 543afa34d87a..21a3073c8929 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
> @@ -783,7 +783,6 @@ void rn_clk_mgr_construct(
>         } else {
>                 struct clk_log_info log_info = {0};
>
> -               clk_mgr->smu_ver = rn_vbios_smu_get_smu_version(clk_mgr);
>                 clk_mgr->periodic_retraining_disabled = rn_vbios_smu_is_periodic_retraining_disabled(clk_mgr);
>
>                 /* SMU Version 55.51.0 and up no longer have an issue
> --
> 2.26.2
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
