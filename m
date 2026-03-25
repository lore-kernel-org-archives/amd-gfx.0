Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E570210A3D8E
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 12:50:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E00010E90C;
	Thu, 26 Mar 2026 12:50:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k5dCxAcc";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EF5B10E28B
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 17:48:12 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-82c20b9fb16so61968b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 10:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774460892; x=1775065692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i+6XwSK5H5qgv00vvEDadVF3Hm2TplkNoSLsjeJsXPE=;
 b=k5dCxAccvAKsPrMZuSAUKR6bdVcVR+cBW0po41V3NuDqyYs6Cf6gFiYyIP9uxUHsp1
 pbjlv1bkAd05N6xoJBPS6lK/TrLSmtzLX4/SjhvdrLT0bR84xTD8Mn1oVf8ydmHpXMjb
 jdc0YwF9oFTDzD3wpONKJPNwb28ia/E6A4WYatxJrj0AmefXUcPcK/EcYdrjlngO/JLX
 u77bKuE/iU6FziHLVSrr7TyvHWu8ma62GX2AMcVp2T2lafWkSdDX1wWkJD79hNPTMIf/
 GdyXhoMA30Iax2UpGui4qyfCO2ZbwzKy9h+wJQQT4w2FBFA/U7qJDFmRfobkAXbKRxNo
 4+iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774460892; x=1775065692;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i+6XwSK5H5qgv00vvEDadVF3Hm2TplkNoSLsjeJsXPE=;
 b=gS/DRkbjkRwB95GxbQCOyIEsJpwNy1yOa/+QroYuqEwltzy+7csL9k+BaIJive3PLB
 ZhKZfjsJ9t5X6sESReC7IHpyjofRSEBDOBRyzf17DQKE5TXJh1YdcFuF/tGEXlN9i+6J
 CYgVoR/aLgnHKcmHXUmWW6fq/guoiaovZBrJyy0mhKYjXoLe58pQjEeOvJWcFwOYJChZ
 6+Upv2CGfPezgBaRfci8CpfwTk3ubuBfl6vu8P0aVTwBW8CeeUHv2BpicHcbL5rhOSyo
 CtdWB2Fcg+ofP6TW3MuPHu2PqNrw1vY6qsm12ZpiKdxQngGlqmO8Q3p3txsCuCuw2sJg
 tUQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhCj7zvPORCbcfkC/vFvEUgHicjkDrO/enlEbcxA+WLUzBUPYcsy5V29srD8Qod7N+AfM6t+sU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxQM64ZU8tmuBYcec4sNMYAMX5l5FmfuWTYCt8U9bquaCszTFKK
 WBIto+u8w2l7UTNP6JAiEENSlf8TENAPTpZXmUzqnmW4tDzp0J76ezW4
X-Gm-Gg: ATEYQzz4aCHqSpw9rXub9uY7cGIctbxLjGWRf/zFlJxUup56zY7dv4nS4q72jq/xZCA
 m9///S4HP1JPeTOOLbuQH1hFvI3/LUt0GhfRzEMwWwryybY+9o8/B80oCfVFPOBys4uXg3NUfir
 TGQrBW67ITlTcgndTWZBfMwzerg5Az64Yn3R8t+bqKDQ17fAHP9Hy/vP5v7QakcRRpW+s56fL8x
 EYOg0SZdb9yZcezptyU5Ua7IFsLy5dvAaiUm1rwg1UjVwAtSY7Z398um8vmc8WaMxPmp/JhV65o
 6U0oiYvXZbaDtyft2grIGWv8KaAYzpKB2Z28lH/DJvZmcx7hduAAmvRHlwO6CubJufRf0Zu+9Ih
 aNlHBHiMKFZQgRm+8aO+HLVVAO+f8XnImdwEQcGDPfgRTYU9bEHh69oA9SiMnhkkgSRuCcOhJMv
 cf9kSR06wEcZe6s6Vpobvh0Q==
X-Received: by 2002:a05:6a00:c95:b0:81f:17b:c70f with SMTP id
 d2e1a72fcca58-82c6df62c67mr4543895b3a.29.1774460891508; 
 Wed, 25 Mar 2026 10:48:11 -0700 (PDT)
Received: from pve-server ([49.205.216.49]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d1e63c7sm388961b3a.2.2026.03.25.10.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 10:48:10 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, Dan =?utf-8?Q?Hor=C3=A1k?=
 <dan@danny.cz>
Cc: linuxppc-dev@lists.ozlabs.org, amd-gfx@lists.freedesktop.org,
 Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com>
Date: Wed, 25 Mar 2026 23:12:16 +0530
Message-ID: <341nolfr.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
 <1phlu3bs.ritesh.list@gmail.com>
 <20260315105021.667e52d4a99b154ef1e6aa34@danny.cz>
 <da93575e-92ad-4a7b-83df-1cb956bd2bc2@linux.ibm.com>
 <5x6knm5q.ritesh.list@gmail.com>
 <2d5fd6ec-003f-4d24-aa2e-06ba94d6cba4@linux.ibm.com>
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

> Hello Ritesh
>
> I think, what you are proposing to add dev->bus_dma_limit in the check 
> might work. In the case of PowerNV, this is not set, but 
> dev->dma_ops_bypass is set. So, for PowerNV, it will fall back to how it 
> was before.
>
> Also, since these both are set in LPAR mode, the current patch as-is 
> will work.
>
> Dan, can you please try Ritesh proposed fix on your PowerNV box? I am 
> not able to lay my hands on a PowerNV box yet.
>

It would be this diff then. Note, I have only compile tested it.

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 73e10bd4d56d..8b4de508d2eb 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -67,7 +67,7 @@ bool arch_dma_unmap_sg_direct(struct device *dev, struct scatterlist *sg,
 }
 bool arch_dma_alloc_direct(struct device *dev)
 {
-       if (dev->dma_ops_bypass)
+       if (dev->dma_ops_bypass && dev->bus_dma_limit)
                return true;

        return false;
@@ -75,7 +75,7 @@ bool arch_dma_alloc_direct(struct device *dev)

 bool arch_dma_free_direct(struct device *dev, dma_addr_t dma_handle)
 {
-       if (!dev->dma_ops_bypass)
+       if (!dev->dma_ops_bypass || !dev->bus_dma_limit)
                return false;

        return is_direct_handle(dev, dma_handle);
