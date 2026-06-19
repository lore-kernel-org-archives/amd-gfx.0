Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526CECD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 17:04:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCAE510E0CC;
	Fri, 19 Jun 2026 17:04:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VyGBEIAf";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACD6D10E0CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 17:04:18 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-30bd960e807so160235eec.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 10:04:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781888658; cv=none;
 d=google.com; s=arc-20240605;
 b=JlYyMQ7puNEmFHBkeKUKja1pai+zaZaBZq1MgOmt2vsju2H3x4F0NVfXNlAbcEPDqE
 11xubaywXkz9PrldbCQMxYuxn6IjN9YkfvOpL5Q5O6eEQrtKhlYeEceEObGvWpWMXJy6
 lKi5kFngb/X4Yn2P357KNNpskqOqotg/hCQSlkO8D+tskvrIEceTzLQySc1VMzu8fuPU
 rhDfBys97EknWlSATf0RoW05ldZefFs3mUncBlAuuYhqhs7nmP//DE/UGKaPdoVpbLcc
 oPxTML2pxo/xNxxBLLDtSengZO7vBdttqTCi/Skm7fwA0BHt3tgfKvd5u+1TGEChBdfV
 OmoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fA+hR3P8zB+s6agAjijYe3HP4e5T6ng12R+LB2QvkOc=;
 fh=328T9GRFRZ0Ry2IYaUGQb2Y6Pxk1+sxW1A/L2dQeS2g=;
 b=BLQSZEG/l1hY+c9WgqPC2Yx0XDSkuc7NT5eK8SR7cmVNNORh7C8To7PISLOxPrxYDr
 qJOZMQ83Dsoj0p18xqlD4QoNOiH7Lz1TrvjP4nOzAaTTceZEiD2/bgT9r0wRwIla3e6W
 TWqAuWPrlDZ5fLvcARhM0erXKwQwBPrq71njW2gUJ1nKDaJ1RgamKxT3XtmG5Wn9K95m
 AH5RmHOiCX6JwpFANNT9vE5ItRulsCEiAWAK4tKDZ/9rgm4vSF1JCBLalMlTOgeHkkrt
 u/J0EckIeX9U78xyT2Ro1I9aJxbXIx4ckvKTLJ1Qytz+K6qVQfr+ERYnT6W5rzVFq3sL
 3HtQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781888658; x=1782493458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fA+hR3P8zB+s6agAjijYe3HP4e5T6ng12R+LB2QvkOc=;
 b=VyGBEIAfIII8k08QOyXhmrl3Q2Z47W9x9FaMb5E9efndlDCjou21Ea9AZCZUUtzSDP
 Q86tFHBom1XR40CLs+UjCCbu0FkXd/Zxj4EX+Y94/8xi7a1xzHOWiL1MULGuNNIYwm2k
 Z4YJNODZnq8MKl7/GDc3Pm3XeX+f5PKygNW9+fJ3IoB/jGbkMTIOX7s3XcTTwmBBgMRc
 9m8PM81K+6TWv9YQRS1WsYt4BbOZHmCDh7MfHUHcFRpDGJ75PPT7ti6JibaENAld/6uk
 BjbhXqMkVGeKZGOvre5EW/VRoxFIKyPMykjFDr7koTj3PB0AgCA1kS3eRGTgWFizXtwE
 OZpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781888658; x=1782493458;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fA+hR3P8zB+s6agAjijYe3HP4e5T6ng12R+LB2QvkOc=;
 b=L8Zt/CyUK12/ZSUxfx8Qm/s0l6aTGx8XCuT00QJ0/iiL9wVf+u1yJVlTp3KU3yF6xc
 P5rV/oqcushSrNHH1eT1E0ggpqR9cn8PLRTQMpbBHH5j9eBTv7h0WJgZhEF78CSlgyyv
 clcULDPAVvfiTW7LosKcZ/9yvecDuPjX5wLPnoe3qTTDSbYhc20HrHCav7uCMJGdfp+E
 qCQLf1GF3G9ER9FtgArG9jrDKlENCbTQwhobN6qTWztO0G4AR7E8XNALO9xKUOxHok66
 5sBoJ5mCggNI9OakJYl8n1s1qZdTLwEGjCOOxsk0wXvECFwhh43ztxmuOo7gCV+f6Qeb
 6OUA==
X-Gm-Message-State: AOJu0YxnbPS9I3wvsPiD/gzk07e9/nGMxGMDJjOKTsG1f1gsr/0TIGCZ
 Hxn8qUrILK2qygW0v0yN93OS1SPxoMiYeEbhz8SKbcorNIYDRBoX1Wboa/bryq9fXsr6IQrVWCr
 GrSKC2KbpV8sV6V//UwPWV6yNPvcv/Qk=
X-Gm-Gg: AfdE7cnAo3KLo+wA9Yn1aDfMCyDvdrOnZs0RQ38CimSNLRsnofdXoVgRanVB6b39PDJ
 j2M1/er7H0eDw9xN1ORfljcxD31qv+k3dCVXl+vYQRPuwxg+WHEBfoYFPjoFA1LPNLriHD6uaJ0
 dGFqm1snKI0C2/ZqzTQReSBpBYKGItRmJeSgC9zgPp0BCyUGbo1OCYzEI17aCWvo4IzPz5AJJJf
 TChpa5WUvcF/ocnt0xWJTJPf0v5FiT15Ix7hB9xh90kmQ3H4RgsfMwENs650ck5+bwWTYRWM9fm
 5xxYNNyssYqz0FN2N5YF3Dhyjpw/ke6aRDW46NDAYj3rFxSK4T52AojkZT4=
X-Received: by 2002:a05:7022:6096:b0:130:a479:79a8 with SMTP id
 a92af1059eb24-139aa5c63ebmr324232c88.2.1781888657755; Fri, 19 Jun 2026
 10:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260619164558.93761-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260619164558.93761-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jun 2026 13:04:06 -0400
X-Gm-Features: AVVi8CeiiqY8f_k617p-elRjJjcsoYoXobyVQZpdhKUXV38NvYR6EFoZ--QifIU
Message-ID: <CADnq5_MfG+SExQXjvHDbLocMhnOHPo-Vx9R7Sjuq5QvaEXCS4w@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: change a PTL warning message to debug message
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Fri, Jun 19, 2026 at 12:59=E2=80=AFPM Eric Huang <jinhuieric.huang@amd.c=
om> wrote:
>
> PTL is a special feature for gfxv9.4.4, but the warning is
> always appearing on other ASICs when rocprof is running, it
> causes confusion, so reduce the message's level to solve it.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_chardev.c
> index 575b13b557af..566955adb58f 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1813,7 +1813,7 @@ int kfd_ptl_disable_request(struct kfd_process_devi=
ce *pdd,
>                 ret =3D kfd_ptl_control(pdd, false);
>                 if (ret) {
>                         atomic_dec(&ptl->disable_ref);
> -                       dev_warn(pdd->dev->adev->dev,
> +                       dev_dbg(pdd->dev->adev->dev,
>                                         "failed to disable PTL\n");
>                         goto out;
>                 }
> --
> 2.34.1
>
