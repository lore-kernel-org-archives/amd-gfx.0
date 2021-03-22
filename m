Return-Path: <SRS0=Az3f=IU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E85C433C1
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 19:23:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0904C61984
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Mar 2021 19:22:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0904C61984
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D53D6E1ED;
	Mon, 22 Mar 2021 19:22:59 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D730D6E1ED
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 19:22:57 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id m13so14269814oiw.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Mar 2021 12:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jof6qy7zEYZfk42H22agIh7llEBf3/zRu4OJ8I9mE/U=;
 b=UHXYoLEjRvhDJCUg7j6ZMFZ0diQCHLRu2Pq8S+qWZM9koUxONTfAbmVoPvIOLwlq0n
 amvxr95m8q649Zg9o5Lznn5fOxTUTBvj38Xr12vo6va0hAeM8EU+1vjx0TyVXBYYSnR2
 VwLiZK6z/9j9LW1Zm8mW/oMNK8Aphp7P2duZ8dl2z7WTtZ/iqfLNITl3kf1gGtvXhHsl
 8wEJJX6EmhgPlhTABggxKg8CT4ZiUjTuRY3vMMKxxkinDWslwoqjEdlM400/RxEy256O
 lNXEka5Ab67+MZKiRklGnxpdoFjE1th1jTADShLLY4o/DlCLtxux45t9FMdeHXjILJEh
 k/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jof6qy7zEYZfk42H22agIh7llEBf3/zRu4OJ8I9mE/U=;
 b=cA9fYbtigA2rBlM1PiJAoCtPGUzL1Orm87st79Dtilru45QMYG2lsgS9SDHo4JSc9g
 IVJEFS2sz5FOuxmo/1cpnY4qXt0HTCsPGRIlTbSNEkgFiBmk2TQdf/UakbayhnbRFWcC
 ZJQQA7r5nmqBE87hprG6t+BfyNpDi+RblTOYiQYjjM9jtx2aSTEUWU+zKDtbWPtcCY3f
 koe4ArLkjStL0qG+b32wP5/DugTnuKIT0DqI6NURDwk8MebIsJedQYqk7mVHL4L4/0BV
 qnuAIUcdS4CNiJQbFjVSAydyUNcuB/6h4lQf+rfu9vlvE1B9JD7AoRGmZ2Gtxex9cSAF
 3Uzg==
X-Gm-Message-State: AOAM531xtdQ7V3I5mgkqhjLAFgbxAa6BpIAT2260wgOsl1h/7QzgZvTq
 rIi1VlZpTRaF1T1mHvpVQ+0ceTcJY83zdi6Ug3w=
X-Google-Smtp-Source: ABdhPJwA2/JimW04aD3dkOFfaxgN25cTo1LVXrv6IbPBJmMviZ9BT7yiHtFMWSkqMC6iJYGHDhdE9X8KTxKTBbwS1uY=
X-Received: by 2002:aca:4748:: with SMTP id u69mr428230oia.5.1616440977217;
 Mon, 22 Mar 2021 12:22:57 -0700 (PDT)
MIME-Version: 1.0
References: <9f9f69fa-4638-673f-6695-1171e927a80b@gmx.de>
 <MN2PR12MB4488704D527398352637AC61F76A9@MN2PR12MB4488.namprd12.prod.outlook.com>
 <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
In-Reply-To: <a8ad9295-196c-77cf-ca63-161fb97632cb@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Mar 2021 15:22:46 -0400
Message-ID: <CADnq5_Oe6PHz5rQ9u5T2M3ZKhWE+fuj5CD2ngvXRiZFeZprS=Q@mail.gmail.com>
Subject: Re: Amdgpu kernel oops and freezing on system suspend and hibernate
To: harv@gmx.de
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 18, 2021 at 8:19 AM Harvey <harv@gmx.de> wrote:
>
> Alex,
>
> I waited for kernel 5.11.7 to hit our repos yesterday evening and tested
> again:
>
> 1. The suspend issue is gone - suspend and resume now work as expected.
>
> 2. System hibernation seems to be a different beast - still freezing

You need this patch:
https://gitlab.freedesktop.org/agd5f/linux/-/commit/711c13547aad08f2cfe996e0cddc3d56f1233081

Alex
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
