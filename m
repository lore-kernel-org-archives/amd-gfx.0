Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0799CA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 12:47:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6078B10E0E1;
	Wed, 27 Aug 2025 12:47:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Xw4Y+X5P";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04D6E10E0E1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 12:47:29 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2445813f6d1so9319425ad.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 05:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756298848; x=1756903648; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pCYbNaA88HQ7muzzm9LKhMwHeinz3YdbJCNiE2xXTVg=;
 b=Xw4Y+X5PibmToUpkyuAA25PKFPyjdga4t6V6s/YjtTPHUpsc1FVqOE7Puj1vcIjW0q
 qB1EsLB7XULGzABXusPMuB6ZXesApG0OhhD5J3KYsYL3ZjIy9mXFUSI+SRwvrobvAZ3r
 CJhbdBj9Pi5f6Q60w0V+V3S538Q4k26F0EW8Q+Cv+ZufWf9OsiEpgBL4436okhM5iA+8
 hYrnvVa5z1JDx/2BCD3fmP9GgPRF4v3XxE8Ser3LIgGe6AFaMGCWSCDFynAcHVLTBNYD
 +7oeCLl7Zd3esNM3jdi9O1cJ7L89Ckw6sBu1xjN9t8fjOm2RdZs1IMsHn8OruEzSlQos
 7fHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756298848; x=1756903648;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pCYbNaA88HQ7muzzm9LKhMwHeinz3YdbJCNiE2xXTVg=;
 b=Q/LxnbB2Ej1r0NoU51GI859oZzmEvqKvAz4JYj3lWjkNTaoDrYsHcF0SLn5mmMNyz3
 eD3/Z7radmvcjKQlj/Ela8Dp8d8dfWdNOhL7aTvEsGowSS0ktaBAw3SxgdKMab85vxMX
 3cciR7kei7cXci/tFKjI11kX1RZmTDTbQtB/MOHnWbTVlP0JRnXkB7khWIYjYliaqPWk
 Bwn5/EzGLKAyj9xY1o277h85WlXomDKW32FW1YA5leUNBcHUetXlQo7SQiy5gBQKRVtU
 bRGMjUSxeBGmyveSPkbFJOY9r2/dp3Wf9Ont3f6BgeT9Ua7U97D7a/BwnTA8FoHwvpUq
 jCwQ==
X-Gm-Message-State: AOJu0YyJWwpGRbBpm1S32/0fcs15rGIRMtzy7b0+N3vTzpQaTxYI/9KR
 Aa6JHwN0Vaj2cRu3zRKn6SoaUmds7PyOgkDAzQMJjkUd9kfDld+Qa91aGjvAz5rK+js165oAx1f
 DNAh1d68XApcig3NuJs4sqJ+8MF+4By1bY6jx
X-Gm-Gg: ASbGnct7Zq1PlGArCSQv6OuvySEWzlznVicSp7k/GpX6ujIgIaXXEQDxzdLcDd+2o4f
 I3G1iYfAEHCa2Q18vMK6Y3tQrmC3GqZiCwH39iHijXXlyTJNxbNUmslcDO3ydFgirxDhtQMZhyA
 Oat7/3TUlDoLZM0YHuyuKwaM3q1Kq2cG96VGlfyLRLpR2mIYLnIRK4p6aN2vR9klaws0lCC7aYr
 P+mesm2ah7HqlRPCTbYY7VhlRfc
X-Google-Smtp-Source: AGHT+IGiD4V2wFKDgtjFgXL88dfBYbTq7AwHPnE+LSrxIsCan6i76kk1AwuuYDA/y/eQ7HKyerxqpApu3jCB6tVs1YA=
X-Received: by 2002:a17:902:d492:b0:246:c7dd:8d93 with SMTP id
 d9443c01a7336-246c7dd93b2mr82181775ad.1.1756298848402; Wed, 27 Aug 2025
 05:47:28 -0700 (PDT)
MIME-Version: 1.0
References: <c285c72e-08de-46f9-b30a-a938c722d3ad@gpxsee.org>
In-Reply-To: <c285c72e-08de-46f9-b30a-a938c722d3ad@gpxsee.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Aug 2025 08:47:15 -0400
X-Gm-Features: Ac12FXzP2FR25845m61Qqym-VIxz2-PJpisBeNQRvjOGvjmAjpoTB79UG0wLu0w
Message-ID: <CADnq5_PBSKT8=9JTpiSF1ygpys6J_L7P8brwn9EyQtovaXD=7A@mail.gmail.com>
Subject: Re: radeon module hangs boot on HD 7450 and Linux 6.17-RC1
To: =?UTF-8?B?TWFydGluIFTFr21h?= <tumic@gpxsee.org>
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

On Wed, Aug 27, 2025 at 3:57=E2=80=AFAM Martin T=C5=AFma <tumic@gpxsee.org>=
 wrote:
>
> Hi,
> While working on our mgb4 driver with the "next" v4l2 git
> (https://git.linuxtv.org/media.git/log/) branch my machine with a Radeon
> HD 7450 hangs during boot and the monitor looses signal. If I disable
> the radeon module, the machine boots fine (to some kind of VGA
> fallback), so I suspect the bug is in the radeon module. With the Arch
> distribution kernel - 6.16.3 - the machine boots fine.
>
> The media.git "next" branch identifies as 6.17-RC1, so it may not be the
> latest radeon code available. If the issue has been fixed since than
> sorry for my spam, otherwise please provide some info how I can help you
> to debug the issue.

Should be fixed in:
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/comm=
it/?id=3Dc0a8e4443d768e5c86ddb52a3a744a151e7b72b0

Alex

>
> M.
