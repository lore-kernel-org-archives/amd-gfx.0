Return-Path: <SRS0=9SYE=DH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E14BC4727C
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 18:07:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE99D2076A
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2020 18:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtQj5m7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE99D2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F2C689C86;
	Wed, 30 Sep 2020 18:07:49 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E73389C86
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 18:07:48 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id s13so428771wmh.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2020 11:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=FvhCtb7lAgWTsRuVN987vq22qrUey87DJKLHGBJY6Ag=;
 b=NtQj5m7lyi1TYp/iIUV3/sIjIb9nQyb6LgWDJWbZfcUMafDRggL8yiQYtoJs5m18dd
 BhN49VywBpfKLB6x17uhRtkkyF4l5MiMgf3INBqvBpOBp1ZER+pCheVycn+sm820I282
 x4aTbHRjl3sUYqGb9Q/GTme5LCTwnQCa41FuKO2b2nC9/eZ6Djpeijd+AmOd2+rFyC6q
 n9ehHZl5kQPsGEH++A3hgcC5oEeOXTrF3SeHeoM9w6Ix9xYUsW/BrVcGHs2SYvpJe5e8
 d6t1/aD/NHYZRbh4dbDGIqygyS/8vDSbbSbnf2bAKXBFESJXZ0rqS86EIdBZ7iJSdFzU
 oAfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FvhCtb7lAgWTsRuVN987vq22qrUey87DJKLHGBJY6Ag=;
 b=BpVtUcDa+BEeuYzy5XoIQOSqZsmFW6SbxdWfOO9PIB2clrvnGv4v+KCYruNz2Nac3Y
 kFz3d4qjA7wzl2w7bJ285z+weCc1RhGjYIprW7pumXzKtKYbkGnrraHtd1NV06h9lELE
 jSLIOELRrqy1Syokd/R8fDncvmTeFs8G+oAwHZ8mU9QeEe0psH4/HTHwha7Gh8GUgexT
 sA7RxYbUJmdgmos1cbZ/Q4fS4rTzocPx5/RO06TddqiYn3D2b2m4JuITMcuCj7w40Sgs
 lDJ+QGWhMzuogntRKpjSdFYh1CC4gdVBgMptPD7ud1mNxp5WZj1w8lLGLrhJaHVdQFIf
 1cMA==
X-Gm-Message-State: AOAM531nciPgsKSt/MzOEzAumiosDks5G1fOGBAX6T90jbf28GzRlf8H
 LnMBbcugUrR2tBiKtdf7yPN9BRtxYabzzyw6k+A=
X-Google-Smtp-Source: ABdhPJxMcbdMcFONoXfMCYjWQIauqpapIJQzQW7My3FTK0lQ1QAzEhte4gxpVvi7LOarTvPXNcDwFervEXtmayI4sJU=
X-Received: by 2002:a7b:c3c5:: with SMTP id t5mr4430354wmj.79.1601489266995;
 Wed, 30 Sep 2020 11:07:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200925201029.1738724-16-alexander.deucher@amd.com>
 <20200928201828.1018587-1-luben.tuikov@amd.com>
In-Reply-To: <20200928201828.1018587-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 30 Sep 2020 14:07:35 -0400
Message-ID: <CADnq5_Paa-ieSLkQGJyNdz9n4=V7X8WNUcKY2m3XK4LcVS0LZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix perms of gfx_v10_0.c
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Huang Rui <ray.huang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Sep 28, 2020 at 4:18 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> Fix perms: a+x --> a-x.
>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> old mode 100755
> new mode 100644
> --
> 2.28.0.394.ge197136389
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
