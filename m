Return-Path: <SRS0=iyzK=O7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0263FC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 13:01:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B938C60EE2
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Oct 2021 13:01:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B938C60EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5248A6E4AA;
	Mon, 11 Oct 2021 13:01:22 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20::231])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB0326E47A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 10:20:15 +0000 (UTC)
Received: by mail-oi1-x231.google.com with SMTP id o4so23968800oia.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Oct 2021 03:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=UgTh+Pd4KBKIkRlPzvMUAxKYgzh6qBN0XBGwuvG+9rI=;
 b=FzEn9NCeJUAKPgz3QfSMbc1vH8GH2moLVGgpXAee4H6+6tPflspwOjia2BE7zdoEKZ
 bdJcDqp72C2P50sN6bLY/+qwdr1u3CDaziXw+mwzQ0f1GSCcn5ujiOAyy0PemJbE+Rpf
 1tWzaSkha7GMeb2ZuR2KuWmndkrCgaliss/87qyaBR8xQZYKIOpsDGHg0aXhyB+X5rxJ
 S0p49NA7gPq9exHnFIDA/+ymP3Ho9kClSQbjVc7Zo/ojFQB/vjX8+J1uAdt3rNNmuxuu
 1nYwQiBzt/B7GUsAZXxO4Tx4pzJj8TPoaoIy13OfZA+od29Av52m50AqJZ2Jmb3sNnEs
 Dq3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=UgTh+Pd4KBKIkRlPzvMUAxKYgzh6qBN0XBGwuvG+9rI=;
 b=CU3UXNz0xTELRkvt6fIOHZv26feOfegxCrUnmk0erJ72QSIUHkz+YYmvoTwDyRBvP1
 uOGD8TbHeOVAkmzrFUW20JLJ7CgVZ/MUDNxbScmmHn7QJjyoLNUggtJJMVYXJvlCkv0m
 ocGoP3HD1Ox4O3GMK9mjgLUypBk6GbV1rbhxM8bIgYo5a7hOwF09f1lIrpP0Pxqnb2wH
 5IjxUc47TUrGme2ofh4UPbbT/tCNA9GUQ/hBnDxFv1nIQevsHKbbOancDX0hr2QGKkZ9
 TE+jZLSRFG/6UW3YopZG8wS3AoAEtBT8iqCzD+n79qzxI3AJeO1YIGg+BJp3N+pe6HFB
 c/DQ==
X-Gm-Message-State: AOAM533nP3NCBxkpuBN3g+IIJY+nQdzgBaJTvtbWq51WfSFn0DhcBE+O
 l5Hlt2lTrJzW+U8ovSLv/Qum94765lv3z+2t0ns=
X-Google-Smtp-Source: ABdhPJzAY0Vu7CKq3ubRG0UZFVAHUldzqPy0KYKt/K6UthU/fx6FFuCNbYsegHH2eCvOWN9YXzxThHaWaDGnDalRJQA=
X-Received: by 2002:aca:30c3:: with SMTP id
 w186mr13343178oiw.171.1633947615161; 
 Mon, 11 Oct 2021 03:20:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:705e:0:0:0:0:0 with HTTP; Mon, 11 Oct 2021 03:20:14
 -0700 (PDT)
In-Reply-To: <BN6PR12MB1187E3D949682D0714EA6253C1B59@BN6PR12MB1187.namprd12.prod.outlook.com>
References: <20210928082819.205231-2-yifan1.zhang@amd.com>
 <20211011061326.13718-1-youling257@gmail.com>
 <CAOzgRdaG2Zo-_kDGo2d-AZ0zoSHHW5T_dh9HFrk46i3kXiMitg@mail.gmail.com>
 <BN6PR12MB1187E3D949682D0714EA6253C1B59@BN6PR12MB1187.namprd12.prod.outlook.com>
From: youling 257 <youling257@gmail.com>
Date: Mon, 11 Oct 2021 18:20:14 +0800
Message-ID: <CAOzgRdZmOcg19wL00u-S6MSCwBufJBzpVDo2mQYKiReF7JE0Zw@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>
Cc: "Kuehling, Felix" <Felix.Kuehling@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhu,
 James" <James.Zhu@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 11 Oct 2021 13:01:21 +0000
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

test this patch can fix my boot and suspend problem.

2021-10-11 18:03 GMT+08:00, Zhang, Yifan <Yifan1.Zhang@amd.com>:
> [Public]
>
> Hi youling,
>
> Would you pls try this patch ?
>
> BRs,
> Yifan
>
> -----Original Message-----
> From: youling 257 <youling257@gmail.com>
> Sent: Monday, October 11, 2021 2:18 PM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
>
> drm/amdgpu: init iommu after amdkfd device init but CONFIG_AMD_IOMMU=y
> CONFIG_AMD_IOMMU_V2=y
> [    0.203386] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [    0.203387] AMD-Vi: AMD IOMMUv2 functionality not available on this
> system
> [    7.622052] kfd kfd: amdgpu: Allocated 3969056 bytes on gart
> [    7.622128] kfd kfd: amdgpu: error getting iommu info. is the iommu
> enabled?
> [    7.622129] kfd kfd: amdgpu: Error initializing iommuv2
> [    7.622430] kfd kfd: amdgpu: device 1002:15d8 NOT added due to errors
>
> 2021-10-11 14:13 GMT+08:00, youling257 <youling257@gmail.com>:
>> my kernel config CONFIG_AMD_IOMMU=y CONFIG_AMD_IOMMU_V2=y.
>> linux kernel 5.15rc2 "drm/amdgpu: move iommu_resume before ip
>> init/resume"
>> cause my amd 3400g suspend to disk resume failed, have to press power
>> button to force shutdown.
>> linux kernel 5.15rc5 "drm/amdgpu: init iommu after amdkfd device init"
>> cause my amd 3400g blackscreen when boot enter my userspace.
>> i need revert "drm/amdgpu: init iommu after amdkfd device init" and
>> "drm/amdgpu: move iommu_resume before ip init/resume" for my
>> userspace, running androidx86 with mesa21.3 on amdgpu.
>>
>
