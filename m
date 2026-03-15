Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C598F4643A
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 09:35:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A0F10E390;
	Mon, 16 Mar 2026 09:35:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IvV6NnLz";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C69A10E1E0
 for <amd-gfx@lists.freedesktop.org>; Sun, 15 Mar 2026 05:03:30 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-b6ce6d1d3dcso1443690a12.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 14 Mar 2026 22:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773551010; x=1774155810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=k/FxsTE4U3c+f1UME/XsJwTGOpHZKh8kTk9la6YsYPk=;
 b=IvV6NnLzhCn23sZCTWNPPweNc1LW7vCxg50pOGQjzUaYCZwAnLtk8uvwe46kjnleoH
 Upr7J78uLmGNFyqFu8fvm5/d97S+55fnx1gZ7BggbR9+sfBHB9clfEQnkXMCRdigY2j3
 ARR1O00SJQojHEU2Z8GOiCx2m9I8D5K/DtQ8OFA4/2MVT0grc5chj7E9bWdylFIIsbyo
 5ibcSYTe7qbBC5R5sxOdbAWcvdDzUZllFdQI+tPAHDk3kby67szjJk9ZwGkCW+EVf7wx
 GmDlQCOrsR1hfdt8Q9WxhmicFuSXa5BR7twXoK8bkfAHxZJi1deoagGNUVTna8f+3WrA
 3W9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773551010; x=1774155810;
 h=content-transfer-encoding:mime-version:references:message-id:date
 :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=k/FxsTE4U3c+f1UME/XsJwTGOpHZKh8kTk9la6YsYPk=;
 b=bek3qNILyGyFra8Qv6vlXK8ARdR1fuugIZ93o1tddaIpl0ZT0n4RTnC2eYsL+KoaGE
 Jz+h17RzDbDKS3W0RVFTcMOsdnA21lZ5IHZ1pGZc2hx2WSWxPIlFepkooXFkQ6cX6O9P
 WHq0N4CoSorbMzxwQdceuUyL4c+KjG6HnUQuxgkrtPijFwGk04n3hlgLt2NNTXhJ4d44
 vQXSFmgT6xn/RL6x4rEJrHePcHBp1tsr4Ye3W6hGWEOUkBDTQOtJeCtt//3s/0IurZxp
 himWgtFlK0g52JYY4CGO26XOhJWSx2tPcvOjDXCQJlrESWJ+nbYTAgx7UVCRQSpikiA6
 iMdQ==
X-Gm-Message-State: AOJu0Yz1FvggaMcS/06PPA5s952qldoeF7vlv6aC3w/VR0mhVNJTE9Uf
 q2QSNPPW7vEHjWfi/YulXQA5XylAf9pC05T3vN32mlbeNUSh799A3LpN
X-Gm-Gg: ATEYQzyTW6KV9oovas14ndGsZBx6xXuyLHbdmGiyB58b64vNbcaZJPCkFatZkvNAQAi
 JqedV2WsrYL/bLI96wjOSgdz1QW5BzOO5vHxoDcRmLGQbM1bsKbVFcHQ938J/emf8vo0esAolcZ
 TrQ3h0C8FK1ST/uUHyKibQ62UqvwT7yi/NR8CVUrkjQVFjo5Z0M9zbUgAQw9wXGlbhheOEWc6Xf
 xMLg7V9iPuW5ZMEjf4fAv8wnBTU2OBQipAjL/Nst0Wjknmj0KLDkEV+XE1qKbObDYGjD0Emczk4
 qPjN+X5l43Ym5vs70bU543w655a4x/JMN5UVV1FPLh39J3N58NqZabYFIeNXu5bsn3ASen1BHCr
 YrnnDETgpZmnsdmRlLrvxvLs6NB4rs6o8cDesHhEq8ZMSxOvwpddGpxPiqitHZ2kkOxfAvYWXX/
 uS8vA8ctT26yTQctorKTstLQ==
X-Received: by 2002:a17:902:f683:b0:2ae:467f:11d8 with SMTP id
 d9443c01a7336-2aecaa52b09mr93743015ad.30.1773551009493; 
 Sat, 14 Mar 2026 22:03:29 -0700 (PDT)
Received: from pve-server ([49.205.216.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece7ee4a1sm87297215ad.54.2026.03.14.22.03.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 22:03:28 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>,
 linuxppc-dev@lists.ozlabs.org, Gaurav Batra <gbatra@linux.ibm.com>
Cc: amd-gfx@lists.freedesktop.org, Donet Tom <donettom@linux.ibm.com>
Subject: Re: amdgpu driver fails to initialize on ppc64le in 7.0-rc1 and newer
In-Reply-To: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
Date: Sun, 15 Mar 2026 09:55:11 +0530
Message-ID: <1phlu3bs.ritesh.list@gmail.com>
References: <20260313142351.609bc4c3efe1184f64ca5f44@danny.cz>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Mar 2026 09:35:18 +0000
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

Dan Horák <dan@danny.cz> writes:

+cc Gaurav,

> Hi,
>
> starting with 7.0-rc1 (meaning 6.19 is OK) the amdgpu driver fails to
> initialize on my Linux/ppc64le Power9 based system (with Radeon Pro WX4100)
> with the following in the log
>
> ...
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: GART: 256M 0x000000FF00000000 - 0x000000FF0FFFFFFF

                  ^^^^
So looks like this is a PowerNV (Power9) machine.

> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Detected VRAM RAM=4096M, BAR=4096M
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] RAM width 128bits GDDR5
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  4096M of VRAM memory ready
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  32570M of GTT memory ready.
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] Debug VRAM access will use slowpath MM access
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] GART: num cpu pages 4096, num gpu pages 65536
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: [drm] PCIE GART of 256M enabled (table at 0x000000F4FFF80000).
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) failed to allocate kernel bo
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: (-12) create WB bo failed
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_wb_init failed -12
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: amdgpu_device_ip_init failed
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: Fatal error during GPU init
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: finishing device.
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: probe with driver amdgpu failed with error -12
> bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0:  ttm finalized
> ...
>
> After some hints from Alex and bisecting and other investigation I have
> found that https://github.com/torvalds/linux/commit/1471c517cf7dae1a6342fb821d8ed501af956dd0
> is the culprit and reverting it makes amdgpu load (and work) again.

Thanks for confirming this. Yes, this was recently added [1]

[1]: https://lore.kernel.org/linuxppc-dev/20251107161105.85999-1-gbatra@linux.ibm.com/ 


@Gaurav,

I am not too familiar with the area, however looking at the logs shared
by Dan, it looks like we might be always going for dma direct allocation
path and maybe the device doesn't support this address limit. 

 bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: iommu: 64-bit OK but direct DMA is limited by 0
 bře 05 08:35:40 talos.danny.cz kernel: amdgpu 0000:01:00.0: dma_iommu_get_required_mask: returning bypass mask 0xfffffffffffffff

Looking at the code..

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index fe7472f13b10..d5743b3c3ab3 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -654,7 +654,7 @@ void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
 	/* let the implementation decide on the zone to allocate from: */
 	flag &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-	if (dma_alloc_direct(dev, ops)) {
+	if (dma_alloc_direct(dev, ops) || arch_dma_alloc_direct(dev)) {
 		cpu_addr = dma_direct_alloc(dev, size, dma_handle, flag, attrs);
 	} else if (use_dma_iommu(dev)) {
 		cpu_addr = iommu_dma_alloc(dev, size, dma_handle, flag, attrs);

Now, do we need arch_dma_alloc_direct() here? It always returns true if
dev->dma_ops_bypass is set to true, w/o checking for checks that
dma_go_direct() has.

whereas...

/*
 * Check if the devices uses a direct mapping for streaming DMA operations.
 * This allows IOMMU drivers to set a bypass mode if the DMA mask is large
 * enough.
 */
static inline bool
dma_alloc_direct(struct device *dev, const struct dma_map_ops *ops)
..dma_go_direct(dev, dev->coherent_dma_mask, ops);
....  ...
      #ifdef CONFIG_DMA_OPS_BYPASS
          if (dev->dma_ops_bypass)
              return min_not_zero(mask, dev->bus_dma_limit) >=
                      dma_direct_get_required_mask(dev);
      #endif

dma_alloc_direct() already checks for dma_ops_bypass and also if
dev->coherent_dma_mask >= dma_direct_get_required_mask(). So...

.... Do we really need the machinary of arch_dma_{alloc|free}_direct()?
Isn't dma_alloc_direct() checks sufficient?

Thoughts?

-ritesh


>
> for the record, I have originally opened https://gitlab.freedesktop.org/drm/amd/-/issues/5039
>
>
> 	With regards,
>
> 		Dan
