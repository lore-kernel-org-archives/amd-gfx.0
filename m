Return-Path: <SRS0=jISE=AF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C2DC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C7B42076E
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2020 14:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqDr3Bzg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C7B42076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D05D89DC1;
	Wed, 24 Jun 2020 14:20:04 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DBF189DC1
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 14:20:03 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id l10so2458467wrr.10
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2020 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/m9mp3qNHmgmGJDbfwf1dsX5+nugg5yhLn98mFrrpAU=;
 b=aqDr3Bzg+mRAgS6ce7GdEykxMqFF7kGbpkLUYnzcTQbXwwstUZlRahANdinoVVWtn6
 58TucrrmvEkqGe2xGJBqi8rwrX19xWvgjymqOMIWAO7THsXC4bZXjcC2Kxao6TEn7R+s
 y+bGbCJYFOke/YS09vgZVDE6YgnkQJWPDvpSMWbf3DYv8sBuveN5366uI50aMy9fR3X9
 LhBxXpE0/ozZk6mHrin/5oJ2NlqARcoMIUSInh3OtovTGwKC3OidSTlAhxXkmvexc+dn
 HegIuHWuMVhc34oxR9EtRrkHmegyLwJshjuZ8GHBjokry9n7kGGsaUTK7Zxz5y8t4B6h
 krUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/m9mp3qNHmgmGJDbfwf1dsX5+nugg5yhLn98mFrrpAU=;
 b=cBCDzwgmPmXFIQM0uNgQbnabMq7kTO0vj/hK2suBf9RmIhI+DFZE+0sgRL2DZ4fKD8
 /q7KKle0kWd6uAe3STaqwa82MHLUZ3bb+NVt3IlmZUSW3hLjXiIiRQ6EE0yA/PzRXKF7
 QUKp0gksnVv/RlXviifW2l2Kv0UuHjpjd4xcRfafSryPB/QK9UlD6WAkNnioQX5Er4GJ
 5JYxyEsdqHlx+ZNRapzRP8s9Fx3yavLe6341y4dsCLwgZxA2B7499UJsiVtlDkl92nbK
 vTCPHYIivsWggsLXEVjieQHz/TJ3HQ/dnGQ9aVa/iUMI6jcc38L0O3SxRW5uepINhF61
 GjDQ==
X-Gm-Message-State: AOAM530DkP05cLoyGJZcfBjlStJ9O3NaZQ+HXVjRUdbLKIEeUNlvhG92
 AZH7rBoJbHNqZljiBb+WyiRrnNepSNgVzTydeGo9PA==
X-Google-Smtp-Source: ABdhPJxfvNwQWmcLlUHinIi8KL8y53Whom2qQQjL2mCjCHAGEasPGLp0gq4ezhCvZiPDcm6sl0n5Ck/FElKiAjFuZ4M=
X-Received: by 2002:a5d:6a46:: with SMTP id t6mr4345005wrw.374.1593008401861; 
 Wed, 24 Jun 2020 07:20:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200622214113.969491-1-alexander.deucher@amd.com>
In-Reply-To: <20200622214113.969491-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Jun 2020 10:19:50 -0400
Message-ID: <CADnq5_O3hjmavJMVTCv==hMn-k3v=fiDKx7AjN3bts9Aj+=gSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make sure to reserve tmr region on all asics
 which support it
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Ping?

Alex

On Mon, Jun 22, 2020 at 5:41 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> This includes older APUs like renoir.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index f1855a8323b2..7d51768684dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1974,7 +1974,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>          * If IP discovery enabled, a block of memory should be
>          * reserved for IP discovey.
>          */
> -       if (adev->asic_type >= CHIP_NAVI10 && amdgpu_discovery) {
> +       if (adev->discovery_bin) {
>                 r = amdgpu_ttm_reserve_tmr(adev);
>                 if (r)
>                         return r;
> --
> 2.25.4
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
