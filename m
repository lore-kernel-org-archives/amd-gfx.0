Return-Path: <SRS0=HxPN=NY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0555DC87FF1
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 16:25:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 688AC613CD
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Sep 2021 16:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 688AC613CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D4E496E5C5;
	Thu,  2 Sep 2021 16:16:24 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE8E6E5C5
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Sep 2021 16:16:22 +0000 (UTC)
Received: by mail-ot1-x32e.google.com with SMTP id
 o16-20020a9d2210000000b0051b1e56c98fso3178045ota.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Sep 2021 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ExTDRBB/fl/KS4ztNzSxXpEOWf9Q7DgWWeGbJw8/eFk=;
 b=byUBFbluhb3tqH6+tg0Ly3AALxwoVYkmrauP5iRiojYC0HQKFS6GBfI8uaj8t0IZl1
 GaTYbWrpqV4WR0QRZvZR5R2DhrIar3jiQLiAYxippE1TXzKLoM+RmGiY+F2BKCfAKGKX
 OEM+veRp7VSfecZfvXH/jJFWVMxnIjJQRSIPBFiGyDulIR+GnDoiIdCjM/M3VyBA1jq+
 PvVDphccsrCn3SNoppNaPEwaunHxfdWxfyHokf0IZemihwH/1I3gbsidWMH81mZ637Kq
 i73deeI8VSb1ora4KEZA0GRD14t6/Uzj2CmdU2rrL4I9DIGsx755P9N0wxNYHipQv5im
 aisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ExTDRBB/fl/KS4ztNzSxXpEOWf9Q7DgWWeGbJw8/eFk=;
 b=dCB4nWYo6qxQcHrl/5qWU4ALwEv6B6/P2/qfjZHUN9d8Wux+QI23VNaDVv2fcF+yUJ
 Ozw5F90l8hHJFIkRmqvPvnxEyylijW8Je5wtUA6IU8pNPxgbKMqR7FWtQDTW4D4enVh6
 nR09vqtmLbhzAj7JLhNotnxMHQJDwzbIYh24hkgmVDPX+TKkNcBP1vmh+rUUu2/KDfky
 rQHRyUKfiYw2l9h6wyXA/fMyWvZRebjkmNxgGrvltrAR8grjQB9pWCN9nMGTAO+t/JG0
 y8zOBsE7nOcsvdDXB2u5WCweZv1G9z4uMXTFHTxiPQgqSUHqhMeKX9qjR+hj6UB0TUoW
 iZ+w==
X-Gm-Message-State: AOAM531S2hqjBoJ4Xkm7tiE1aGGQ28FSN55OMSYoMaMTKiESz/tG1fHM
 OXC92U49mlxtzYwi8jUspuVfu2jwfFxy9lKRXrg=
X-Google-Smtp-Source: ABdhPJxqfFrKC1Z1jN1xE5+4Yf73vLZLQTzWvMgE3SaVSj8/FoPsiCD6+s88F82l6ZEtZ3/xHwvxmJxfmHX6OL6RkDU=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr3332187otp.23.1630599382288; 
 Thu, 02 Sep 2021 09:16:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210902075027.8155-1-ernstp@gmail.com>
In-Reply-To: <20210902075027.8155-1-ernstp@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 2 Sep 2021 12:16:10 -0400
Message-ID: <CADnq5_P6KQLqX0eD5_kQKNmtpwWZAANDG-jyoLomnZyvXUkg1A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Increase HWIP_MAX_INSTANCE to 10
To: =?UTF-8?Q?Ernst_Sj=C3=B6strand?= <ernstp@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Applied.  Thanks!

Alex

On Thu, Sep 2, 2021 at 3:50 AM Ernst Sj=C3=B6strand <ernstp@gmail.com> wrot=
e:
>
> Seems like newer cards can have even more instances now.
> Found by UBSAN: array-index-out-of-bounds in
> drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c:318:29
> index 8 is out of range for type 'uint32_t *[8]'
>
> Bug: https://gitlab.freedesktop.org/drm/amd/-/issues/1697
> Cc: stable@vger.kernel.org
> Signed-off-by: Ernst Sj=C3=B6strand <ernstp@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/am=
dgpu/amdgpu.h
> index dc3c6b3a00e5..d356e329e6f8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -758,7 +758,7 @@ enum amd_hw_ip_block_type {
>         MAX_HWIP
>  };
>
> -#define HWIP_MAX_INSTANCE      8
> +#define HWIP_MAX_INSTANCE      10
>
>  struct amd_powerplay {
>         void *pp_handle;
> --
> 2.30.2
>
