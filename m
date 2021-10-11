Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE3AC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 07:31:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D47860F0F
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 07:31:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0D47860F0F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C4E26E434;
	Mon, 11 Oct 2021 07:31:15 +0000 (UTC)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D88A89DA2
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 06:17:58 +0000 (UTC)
Received: by mail-ot1-x331.google.com with SMTP id
 d21-20020a9d4f15000000b0054e677e0ac5so6458353otl.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 Oct 2021 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=HOb5GBtpkMGj5mJk/+j0fTFYXrncCh9Z5dTi7qCXUSE=;
 b=noVI+vNsdAc/L3WbZEMaHjxhIdmor0XcJB5W3PpTJvmhCh8XBcL0UgCpc4omUjRbI5
 eorPY0zYSSDcWv/12Z5m+/gG5Sq1woTKybitHySMdtz4DHcMKVKgVfpuav3h3EQCnKHr
 a2FiCawr3GwPigF+BX/fb4aRjzrRnH7psXNpkt3afebuSDD+Gp6fkN4Uzzr98/juY3HQ
 IIjYpoW9/CEdStqqFfMl1EXI377orkNC9Vhq8pGs1LCuTyxDRx4nFi/IEedzazhDPl2B
 Y9ilPJ5zkjDMDD1xFpsQ9pohiF2s37cd9wIv4MWEH1J0wnNTZRzBk3z7qmfeczrWnBaW
 JZ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=HOb5GBtpkMGj5mJk/+j0fTFYXrncCh9Z5dTi7qCXUSE=;
 b=icWlAfBVEk/Ngfnh7T2zrEqN3IyLGWBPLjo8VuBMnn2GdxzGFL7AaM9eIZb+Au8ZZW
 4CSlAK9hwoBbptOCSbZHt8KWTXIM3YLzxzn+3bhSnZs8pzWXfHtOvRoVc5aD2ptrCkqz
 WYzSC7YcnAyzcNYO4SY+m3DLhxYA/bm7RCzLZTLYfQR+e+7kH/do0GyK3iZ7uN7S1vG9
 T5O8WW0XR6OfHX41WYXaeBBLHT68yqZpiYY35S01Q+2A78E7xg0eq+9xsWaCmt1J4KGl
 kCBOdEl2bt85XVESdRskjNjwt8lmNJ9vPqf1IP7uuF68190c3GIwOl32g7j95SbPqHiD
 wgQg==
X-Gm-Message-State: AOAM530Tt4r4MGnNTO8Eqkk/MqKzC2DsiXb/1XkIAucsUqMRtPkLeJ9B
 6EkeNXA1BQOh2UxwHBax7DhKcswbRKexnsWUntQ9QYouZCNSPw==
X-Google-Smtp-Source: ABdhPJwIK2f4Uc7vjH09imY8L2sIHxi7rwwboAjiQ8qhTEMFiI1Cp0/qqILzu/ZlntfotppNYpjYhhfvPuXXI0okgfs=
X-Received: by 2002:a9d:2c6:: with SMTP id 64mr18821939otl.170.1633933077599; 
 Sun, 10 Oct 2021 23:17:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:705e:0:0:0:0:0 with HTTP; Sun, 10 Oct 2021 23:17:57
 -0700 (PDT)
In-Reply-To: <20211011061326.13718-1-youling257@gmail.com>
References: <20210928082819.205231-2-yifan1.zhang@amd.com>
 <20211011061326.13718-1-youling257@gmail.com>
From: youling 257 <youling257@gmail.com>
Date: Mon, 11 Oct 2021 14:17:57 +0800
Message-ID: <CAOzgRdaG2Zo-_kDGo2d-AZ0zoSHHW5T_dh9HFrk46i3kXiMitg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
To: yifan1.zhang@amd.com
Cc: Felix.Kuehling@amd.com, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 11 Oct 2021 07:31:13 +0000
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

drm/amdgpu: init iommu after amdkfd device init
but CONFIG_AMD_IOMMU=y CONFIG_AMD_IOMMU_V2=y
[    0.203386] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
[    0.203387] AMD-Vi: AMD IOMMUv2 functionality not available on this system
[    7.622052] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
[    7.622128] kfd kfd: amdgpu: error getting iommu info. is the iommu enabled?
[    7.622129] kfd kfd: amdgpu: Error initializing iommuv2
[    7.622430] kfd kfd: amdgpu: device 1002:15d8 NOT added due to errors

2021-10-11 14:13 GMT+08:00, youling257 <youling257@gmail.com>:
> my kernel config CONFIG_AMD_IOMMU=y CONFIG_AMD_IOMMU_V2=y.
> linux kernel 5.15rc2 "drm/amdgpu: move iommu_resume before ip init/resume"
> cause my amd 3400g suspend to disk resume failed, have to press power button
> to force shutdown.
> linux kernel 5.15rc5 "drm/amdgpu: init iommu after amdkfd device init" cause
> my amd 3400g blackscreen when boot enter my userspace.
> i need revert "drm/amdgpu: init iommu after amdkfd device init" and
> "drm/amdgpu: move iommu_resume before ip init/resume" for my userspace,
> running androidx86 with mesa21.3 on amdgpu.
>
