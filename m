Return-Path: <SRS0=Kf1d=AM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255EAC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 03:16:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC32120724
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2020 03:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcEjtlj2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC32120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A94D26E5B9;
	Wed,  1 Jul 2020 03:16:52 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1886E5B9;
 Wed,  1 Jul 2020 03:16:52 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id a1so22893717ejg.12;
 Tue, 30 Jun 2020 20:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=vHvPmDVPXPDOyelV25pCVRevm6sheLB3OzUfc/QjcKo=;
 b=fcEjtlj2QgY8bW6XtCn5WhzBlRBlvIK1F78qcrgcdC64eJ9ZSMrjZ2R265ZGXZCPGJ
 7QLD6JN2qiLCRDiqwfC0XwROsZ7svbtpjamgVCk1BOQXKDSpKOnnJ0+TyBEfkUFeJSIr
 kqWBoc9Y0NvGuMZyyp9sTYpAk+cBhSWSUIy2Tff0BZBfvX2Np90v4q0H9578ehXr7Ykj
 w1FMqACKfvmNraBhI35Nn5s24gin++E/oMrVlvaaA1J9jIlCXLK5UCD2/KDd2XmvyFRI
 tKlYdJHImkuqn8B2zq4cRZr+LGfu18vtp1636ETRa9dRtRbGsXE1+oJYZscUs5OCRb/Y
 /A6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=vHvPmDVPXPDOyelV25pCVRevm6sheLB3OzUfc/QjcKo=;
 b=YUmie6/eo3MWv76Xnw4+wGWpmJkdEaJl5IQ+Y+9nSW8lnXPme1H1/u8p3ST6tIHnZr
 A/DkuP0vD7kUBAlVSKubZS2JnQv6HsOjfqPd/fEIRs9EfWRHZCM/Po0sHJbXoSxzpVIa
 IF6nRHu03Hp7DXP+I7WnwPaPatr913EELx9/MKPkltjcBe5ygTbIfBHlv59c0JWVFet7
 mFfPEQBE6Sm1enzKenKf0NX94UrdIoPLPjXl5EEj73QC7K90y0k2y6TEuScr6H/5XL2C
 UwqeTQ3pJgJqrw4RYvCggoVeC6hj3S0Lkl6h/DLL9g2zDqo56VKj9a5MN0GBsnGKmVJ1
 p+8g==
X-Gm-Message-State: AOAM532RnRKKGfXZhfWxkQ84Zz11TZcF6J9RVJl4pPW/uhMnzxt/sje6
 2grrtnORc9unJQfX7dIZLy1vbgLFo7lEO50TW2M=
X-Google-Smtp-Source: ABdhPJzHagPNP106Rloab5Vruvnzdq7SXzd7+lylfQoTPVVfJ6REKZpByRR5eGL4vukJO/iO7r6Cvf7pRDAmZJZNb/4=
X-Received: by 2002:a17:906:dbed:: with SMTP id
 yd13mr20484670ejb.419.1593573410817; 
 Tue, 30 Jun 2020 20:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200626214415.4397-1-alexander.deucher@amd.com>
In-Reply-To: <20200626214415.4397-1-alexander.deucher@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Wed, 1 Jul 2020 13:16:39 +1000
Message-ID: <CAPM=9tyRu0xq60uYhSomAg+NTGO0EDnhfY9A7_iN96Yuesguww@mail.gmail.com>
Subject: Re: [pull] amdgpu, amdkfd, radeon drm-next-5.9
To: Alex Deucher <alexdeucher@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

commit 5fa689e66bf406ef3a1afe03d0139d90b0b13773
Author: Likun Gao <Likun.Gao@amd.com>
Commit: Alex Deucher <alexander.deucher@amd.com>

    drm/amdgpu/powerplay: add smu block for sienna_cichlid

    Add SMU block for sienna_cichlid with psp load type.

    Signed-off-by: Likun Gao <Likun.Gao@amd.com>
    Reviewed-by: Jack Xiao <Jack.Xiao@amd.com>


Spot the missing signed-off-by. (hint dim warns about these generating
pull requests :-)

Dave.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
