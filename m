Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC86310A3D92
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:50:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1875B10E90D;
	Thu, 26 Mar 2026 12:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iDhHZYPv";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7354310E24B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 13:17:10 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-c73e9e4cdf7so2048087a12.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774444630; x=1775049430; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ydE77GFQVM2//1TEIJxuqD6vop6Nou0E99kEw1kEoLs=;
 b=iDhHZYPvXqrFQuTsqBOI0JMbuiq/PNVF3m7TBnMzNG+8M1Zp0vnVXucPc+/FnlD9os
 NAKzLByZnX3/g0qvhuc3Gy2knaz/8Vfbz8mr773ppm4OOFt4inesyLlzQAv5Qi8WPAG4
 Oy/zytigEIXMabyKltgTvNwE8L0J0Pq8fIoGmB7K8d2+b45pNhOzXTkvBabqL8Y/eA3/
 37Vweaodu15yaO8V1QvFR5fGjjVQHvZ9bdAt8MBK/JxzDTWCVQWHQpIVlFTqe6hav9Dm
 PKJuYIexHovEHteBs7UQJA+KlqHBf0bGyD3K0RDDOOVr65qQyw+CBS4Iw4y9ql1x4tHx
 oA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774444630; x=1775049430;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ydE77GFQVM2//1TEIJxuqD6vop6Nou0E99kEw1kEoLs=;
 b=elHiaVAeXw8h9bwBPNLHFiFLWMoU9JExjx6P/8rA0wj3+7AFAbwX6vEC6Rg5lfUVKO
 uqtHNU6JF5fzd3vtTAxP47/a0DtZBtsy3V5UJm5MuMvv56bO+bGlPiRm+qG54kE1Wmeh
 LMmzyIPfFpm5cIdd5c1L7zoshpdLyUPPwVdVBz753TqiVUcMb4/d5BksrUMEs/djHh78
 itraMWL+Rk/hXFJtEXd5kzm5AUQgJGcxc2vDfCE+TwjRhCssX6dFaxPGKYIPQpoK/uu/
 sv2U7c6k2n9VKfODsAy/QZdqLvA540/RI62T+UGjZ6W3epXgon6I2EYnd1xYUcrQ/R2B
 QryQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtHOJPM319qGmRb91bTqal1H23YjCIpE0u0DKa7BCkDYC0Qw8pdkjw0ser1EeAbzrAnR9QMdvI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzJvOR+lfRg/181L8/EP+BZsuRUTZdriZGONjbliZUaipHIOSZx
 e3Q9/j6xEd0gWfu+WNz1h2J9BXcEgVZGHESDk35RBe5o6F9866ARQW0l
X-Gm-Gg: ATEYQzzrUtJih+1KEiQMlEze7AIkc83/XVzUskff2TTNY2C6OJEl1MUPLijJqshsMgO
 i/PuAZXEF5mhDofSacZsoYW1ZSH2HhQ6MpOi8vQIlKOuuk7H1gIt8BHIHc3Aes1AHDi9aEkcq6L
 l7aaCfcAFKYlrdHUl1AdDuS65Su5XggMamuVviGOIsmtWTxzhPshdl2Bp/5pakN+XueSpGOUI5p
 YxFA9qfElGm2YOswCAYChrJhGPMK/lEMFcqp1zuiOZeMQnADw9RS6wrpMbxcX9l+g1F9tx/THHE
 IH0JclSAkA3LcJud58gTzbeSjfr9fecjY2zXr4/FRDRKFB9EG60DWoWc+2FVdKccnRSZE61JXFx
 4eKLwAQIL9LmZJl83kKlC6zHLfIKZczaL5Y3xq3b4m9fLXo8Fynt0xLh4JtTcZmQrNllyWHa5T5
 3TW2kKE2BJ/7jUUiXgoP76JA==
X-Received: by 2002:a17:903:3c2b:b0:2ae:c816:ec5d with SMTP id
 d9443c01a7336-2b0b0a8d27cmr38475585ad.32.1774444629628; 
 Wed, 25 Mar 2026 06:17:09 -0700 (PDT)
Received: from pve-server ([49.205.216.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083655b45sm250598065ad.42.2026.03.25.06.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 06:17:08 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, Dan =?utf-8?Q?Hor=C3=A1k?=
 <dan@danny.cz>
Cc: linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
 Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
Date: Wed, 25 Mar 2026 17:42:01 +0530
Message-ID: <5x6knm5q.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
 <1phlu3bs.ritesh.list@gmail.com>
 <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
 <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Mar 2026 12:50:40 +0000
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

Gaurav Batra <gbatra@linux.ibm.com> writes:

Hi Gaurav,

> Hello Ritesh/Dan,
>
>
> Here is the motivation for my patch and thoughts on the issue.
>
>
> Before my patch, there were 2 scenarios to consider where, even when the 
> memory
> was pre-mapped for DMA, coherent allocations were getting mapped from 2GB
> default DMA Window. In case of pre-mapped memory, the allocations should 
> not be
> directed towards 2GB default DMA window.
>
> 1. AMD GPU which has device DMA mask > 32 bits but less then 64 bits. In 
> this
> case the PHB is put into Limited Addressability mode.
>
>     This scenario doesn't have vPMEM
>
> 2. Device that supports 64-bit DMA mask. The LPAR has vPMEM assigned.
>
>
> In both the above scenarios, IOMMU has pre-mapped RAM from DDW (64-bit 
> PPC DMA
> window).
>
>
> Lets consider code paths for both the case, before my patch
>
> 1. AMD GPU
>
> dev->dma_ops_bypass = true
>
> dev->bus_dma_limit = 0
>
> - Here the AMD controller shows 3 functions on the PHB.
>
> - After the first function is probed, it sees that the memory is pre-mapped
>    and doesn't direct DMA allocations towards 2GB default window.
>    So, dma_go_direct() worked as expected.
>
> - AMD GPU driver, adds device memory to system pages. The stack is as below
>
> add_pages+0x118/0x130 (unreliable)
> pagemap_range+0x404/0x5e0
> memremap_pages+0x15c/0x3d0
> devm_memremap_pages+0x38/0xa0
> kgd2kfd_init_zone_device+0x110/0x210 [amdgpu]
> amdgpu_device_ip_init+0x648/0x6d8 [amdgpu]
> amdgpu_device_init+0xb10/0x10c0 [amdgpu]
> amdgpu_driver_load_kms+0x2c/0xb0 [amdgpu]
> amdgpu_pci_probe+0x2e4/0x790 [amdgpu]
>
> - This changed max_pfn to some high value beyond max RAM.
>
> - Subsequently, for each other functions on the PHB, the call to
>    dma_go_direct() will return false which will then direct DMA 
> allocations towards
>    2GB Default DMA window even if the memory is pre-mapped.
>
>     dev->dma_ops_bypass is true, dma_direct_get_required_mask() resulted 
> in large
>     value for the mask (due to changed max_pfn) which is beyond AMD GPU 
> device DMA mask
>
>
> 2. Device supports 64-bit DMA mask. The LPAR has vPMEM assigned
>
> dev->dma_ops_bypass = false
> dev->bus_dma_limit = has some value depending on size of RAM (eg.  
> 0x0800001000000000)
>
> - Here the call to dma_go_direct() returns false since 
> dev->dma_ops_bypass = false.
>
>
>
> I crafted the solution to cover both the case. I tested today on an LPAR
> with 7.0-rc4 and it works with AMDGPU.
>
> With my patch, allocations will go towards direct only when 
> dev->dma_ops_bypass = true,
> which will be the case for "pre-mapped" RAM.
>
> Ritesh mentioned that this is PowerNV. I need to revisit this patch and 
> see why it is failing on PowerNV.
> ...
> From the logs, I do see some issue. The log indicates
> dev->bus_dma_limit is set to 0. This is incorrect. For pre-mapped RAM, 
> with my
> patch, bus_dma_limit should always be set to some value.
>

In that case, do you think adding an extra check for dev->bus_dma_limit
would help? I am sure you already would have thought of this and
probably are still working to find the correct fix?

+bool arch_dma_alloc_direct(struct device *dev)
+{
+	if (dev->dma_ops_bypass && dev->bus_dma_limit)
+		return true;
+
+	return false;
+}
+
+bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
+{
+	if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
+		return false;
+
+	return is_direct_handle(dev, dma_handle);
+}

<snip from Timothy>

> introduced a serious regression into the kernel for a large number of
> active users of the PowerNV platform, I would kindly ask that it be
> reverted until it can be reworked not to break PowerNV support.  Bear
> in mind there are other devices that are 40 bit DMA limited, and they
> are also likely to break on Linux 7.0.

Looks like more people are facing an issue with this now.

-ritesh
