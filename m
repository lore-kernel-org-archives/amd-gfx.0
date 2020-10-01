Return-Path: <SRS0=OkES=DI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3A2C4727C
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 14:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AD820872
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2020 14:05:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iN41Aado"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AD820872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96D256E15A;
	Thu,  1 Oct 2020 14:05:29 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1326E15A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2020 14:05:28 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id e2so3253514wme.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2020 07:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=w3QVRT/jOOAq5ZMDxd7abgDmidUjV54yxotdkWQACvo=;
 b=iN41AadoYyiL2k6h/OTKkRNPeByAwBmWbJyLRLjWYNFVVD8SxC6zPS0Tt9A49v65L8
 mvKdqtRpXURUZ5FVmOgY3LFMD2bNEyZraKCvS8uVnZnDX3czYtf5bJcqixyC7HhXFW5i
 701t5cehleEkwTHc+OW+wfZA0SJjv+HxF26kUP2X98jGTI2kP75QwOHcwQXjlH+w8B4i
 kgrZUCjcSoS4z9AoO73Hh9acdtbd7bbkSpLFFyCVPNU9xpeM6HpTeAA2HIFWy4cAiXcR
 4RSxoBKJlJw54BPb2yInaPbc8bdqwitlPQOYkbbwc87/W4od128pVonguMBdFo/AZ5Vd
 n1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=w3QVRT/jOOAq5ZMDxd7abgDmidUjV54yxotdkWQACvo=;
 b=WG/A731Q7CA1Wv2SHClsMppz2z1VW9YGZnahxwU0W4hAmvUmUth5s1Fl5G08zRvJ93
 CrVa9vW1RPZIHv7qAa++2tdtr6N+pzzZK+WuKkFf6xsm2+ywIEECap8J5sayF6+Uillz
 PrWIAtWFNMko+aDTcsqUB7Pfa89r0eaTbclnMmAfQtc6kWSCk/evjHcX25+cQuwcB4SE
 C3EQygirEWypZdMILtLgjRaEcD2uFrRGX6aa1lxihp5e76+tUxUoo2/mBa4Aq6kXC2zw
 RcjdrqB8P+IbQBrMK1U3eA7OcHonLlINQlWOUpzxpKPcaatiXNmbec//nJLUZfSIRET4
 /9zg==
X-Gm-Message-State: AOAM5336GkaZgbTMUC36SDxFsHqLE7ZqfP+KK+3oZl1a4rXJEbMpmfqB
 gyw5NjlQgbv1aGmOA3Fkl1pGsSJzfHaLPXy/tD8=
X-Google-Smtp-Source: ABdhPJwosbQT4PVtn88XFzi7q/IHiboixcUsoO78LhaeO+AX0pxipGsBjeL77hjCzfCm5W3xTDrV+e6fNdJIlPTjUKs=
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr201432wma.70.1601561126918; 
 Thu, 01 Oct 2020 07:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <ghmu1758gs.fsf@gouders.net>
In-Reply-To: <ghmu1758gs.fsf@gouders.net>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Oct 2020 10:05:15 -0400
Message-ID: <CADnq5_OOL3UZXKXEKU8VzkZAkOnk9HM8m=nEwywoQPm4GXs0rw@mail.gmail.com>
Subject: Re: BUG: amdgpu: NULL pointer dereference introduced in 5.9-rc1
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
Cc: LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Sep 30, 2020 at 4:46 PM Dirk Gouders <dirk@gouders.net> wrote:
>
> Commit c1cf79ca5ced46 (drm/amdgpu: use IP discovery table for renoir)
> introduced a NULL pointer dereference when booting with
> amdgpu.discovery=0.
>
> For amdgpu.discovery=0 that commit effectively removed the call of
> vega10_reg_base_init(adev), so I tested the correctness of the bisect
> session by restoring that function call for amdgpu_discovery == 0 and with
> that change, the NULL pointer dereference does not occur:
>

Can I add your Signed-off-by?

Thanks,

Alex

> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index 84d811b6e48b..2e93c5e1e7e6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -699,7 +699,8 @@ static void soc15_reg_base_init(struct amdgpu_device *adev)
>                                          "fallback to legacy init method\n");
>                                 vega10_reg_base_init(adev);
>                         }
> -               }
> +               } else
> +                       vega10_reg_base_init(adev);
>                 break;
>         case CHIP_VEGA20:
>                 vega20_reg_base_init(adev);
>
> Dirk
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
