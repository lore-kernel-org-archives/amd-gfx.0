Return-Path: <SRS0=Ny8F=5J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB03C43331
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 16:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B871206F6
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2020 16:59:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="i+xU4e06"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B871206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30DC6E4CA;
	Tue, 24 Mar 2020 16:59:41 +0000 (UTC)
X-Greylist: delayed 433 seconds by postgrey-1.36 at gabe;
 Tue, 24 Mar 2020 16:59:40 UTC
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D4766E4CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2020 16:59:39 +0000 (UTC)
Received: from conssluserg-02.nifty.com ([10.126.8.81])by condef-09.nifty.com
 with ESMTP id 02OGm8XB005491
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2020 01:48:08 +0900
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48]) (authenticated)
 by conssluserg-02.nifty.com with ESMTP id 02OGljqZ016633;
 Wed, 25 Mar 2020 01:47:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 02OGljqZ016633
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
 s=dec2015msa; t=1585068466;
 bh=4nGjHOPn1Qdp00y4tfz/8sjCtUPREPQ1cB4wp92G+Go=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=i+xU4e061XbZEPioDSUPsgzKIthqclxHFXo1j4yUVASbGKS00sS7mN0dbzrlGZuIT
 Lt0PpDUtLZTV8hf9V6BjXNlOFvFgkhbMet/YSVVWckEHGB0UQufM5duFUonjXRS8ow
 KBrxmwNE1qLHzzuP5IlOmGGOMl1C5mamEQvoasTI/ymMnvAn6LKbVcuv9RuIrPvjJd
 vbSIflnmVZQnwvKt4iOar5Fu3KG2odXAsxVtC5HNWvxsybPPmadBqTSsjfGnw0zc6O
 851IfrugrDZNwwEc/UN4yvqy8IeqPayxY2mscJBiYfCTs1jcJkPx2okN4fgnZyFutL
 Aa1jHd1z4T+zA==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id o16so6568750uap.6;
 Tue, 24 Mar 2020 09:47:45 -0700 (PDT)
X-Gm-Message-State: ANhLgQ3KPHleLH7csstcXGRGJ8/1Da3b0Hnk2QoQfq0Ch6WzMG20igGn
 oDl4e90/xD/tXaLBqwdCsYTqSQqvy90jMgQo6/k=
X-Google-Smtp-Source: ADFU+vtGiho80TDqAX96Yus6mxMxFu6xRjT221tw+EdgnOczkcdQo8Ti4tq0HKei8/xRnz73F3jsLDM/saoD+O6lBls=
X-Received: by 2002:a9f:32da:: with SMTP id f26mr18821086uac.40.1585068464826; 
 Tue, 24 Mar 2020 09:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200213153928.28407-1-masahiroy@kernel.org>
In-Reply-To: <20200213153928.28407-1-masahiroy@kernel.org>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Wed, 25 Mar 2020 01:47:08 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvxFk=ct9AoRLwjZ9cKRsA_bjiLaq0di12TRe5+fpmGA@mail.gmail.com>
Message-ID: <CAK7LNARvxFk=ct9AoRLwjZ9cKRsA_bjiLaq0di12TRe5+fpmGA@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/radeon: remove unneeded header include path
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?B?Q2hyaXN0aWFuIEvvv73vv73Dk25pZw==?= <christian.koenig@amd.com>,
 David Zhou <David1.Zhou@amd.com>, amd-gfx@lists.freedesktop.org
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
Cc: David Airlie <airlied@linux.ie>,
 dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi,

I think this series is a good clean-up.

Could you take a look at this please?



On Fri, Feb 14, 2020 at 12:40 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> A header include path without $(srctree)/ is suspicious because it does
> not work with O= builds.
>
> You can build drivers/gpu/drm/radeon/ without this include path.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  drivers/gpu/drm/radeon/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/Makefile b/drivers/gpu/drm/radeon/Makefile
> index c693b2ca0329..9d5d3dc1011f 100644
> --- a/drivers/gpu/drm/radeon/Makefile
> +++ b/drivers/gpu/drm/radeon/Makefile
> @@ -3,8 +3,6 @@
>  # Makefile for the drm device driver.  This driver provides support for the
>  # Direct Rendering Infrastructure (DRI) in XFree86 4.1.0 and higher.
>
> -ccflags-y := -Idrivers/gpu/drm/amd/include
> -
>  hostprogs := mkregtable
>  clean-files := rn50_reg_safe.h r100_reg_safe.h r200_reg_safe.h rv515_reg_safe.h r300_reg_safe.h r420_reg_safe.h rs600_reg_safe.h r600_reg_safe.h evergreen_reg_safe.h cayman_reg_safe.h
>
> --
> 2.17.1
>


--
Best Regards
Masahiro Yamada
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
