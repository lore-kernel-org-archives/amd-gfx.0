Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80688606A326
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 08:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=h9qf2GU1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D45B10EBDE;
	Mon,  2 Nov 2026 08:06:54 +0000 (UTC)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0251A10E025
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Nov 2026 01:25:30 +0000 (UTC)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-93f36c18b75so105630385a.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Oct 2026 18:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793496330; x=1794101130; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=U5YuqJ1RNYNIpnrJqD32N6NRCNjg2qumNEcRV0y+9+A=;
 b=h9qf2GU1MUqBXQ0oEv95oTNjKEj2wcpL/LC8aGucUBeznIEPh34gU/eWX+PcG1fJVJ
 Jryv3NA6NECFQ0E5Vk+0OVNxiPKwPiP7QgSJQ8DUHW1dchNYUq6OFtkbBouB4+qCxiOn
 KZouIxv7uzP5DpjLtDaVzP2I6uGq/7VF18niDIQxvib0wWKm6bYWXCHLcNv+to327fCY
 p17pDI9GYd0ifs9A1TK/ckBi+2+1cBKRWHBvid2uWSI/cfSC8CYbsxLKw+Vmp1JbJIKI
 i3r/sLKHbJGyy2+oihvs9YSTzASu4O2F0JqvanbJQJOBC4PHxCxNjPD7jaUFbWJKL9rs
 Mh0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793496330; x=1794101130;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U5YuqJ1RNYNIpnrJqD32N6NRCNjg2qumNEcRV0y+9+A=;
 b=FBfh1BF0fiivhVGl/DN2m83SueVW0e0q8CH4J0kWALD+4DUbkPOSW5tXImJrqsPCRb
 IgpSaVJ7/svvFp5V4RarewU7HWvjvCyZWMgksXBimQTQk1a+jUsti5YhhdKe9jWBeHOY
 C4/l2axiqjQr+UiVjWYF7qUp022IswCyqG/YmIer0P1HZ40fglo8Thao2D7JMlfBxoQZ
 I8ctw22I/1XmE3QAQUXyeYbwuOfSqVI3YVoSiYWKWgxNWYux84cjJk4YsGfbUEekSGSZ
 TyViBrdbs4tglN88O2xhGduAXnFEiIkZd2AUYF3OUA6BmgyS5pmfQ16NYpK8f1jOcKfW
 O5Lw==
X-Gm-Message-State: AFq9FYIxxuP8yUblp/a1FRGxO8DNm8pcmNpjN9McGrnZhcOpLeVcDRWe
 y4Mc/USQJWoSWbvY5TbEgmH+NldBzsigpgKoZD4zdnAzy6sD+vZCYFWt0ZE3OYhW
X-Gm-Gg: AYBFou0AWfs+/mQUZGckioml3aSyo40ZaYVbOgx7VBBiYA0bCsM/EqZgEqtFNs9Z5N+
 wxs1ywC37x34UMrOMFat0mvU1jWo9LtUlWJhb+Tklgd5lvPr7mOAoEP7b8yN980MiLOqIYXBN/g
 LC99VeQJWFYSFVEDJWNTtInvV5UyK+L2wuzCtE9J/QUf7vyQES+F+KCo1iJtdPSW9YCfDpOVQ/L
 lV+aBDnIW9z4KR7bBDXNOpOaizEHKGIPJ7t75p7kDsSy5y+5Xo3ifv5Jv+gOzhyypV7TbRHx3KI
 qD9aA+5Tpqpo5Jq7P3shu4stjV4p9tlYFiMkeA2KCsRaDV9TieP09EqjdtK32KZzavMclgfov9H
 rP4yb3Ncyof47aCyT5sC9M0vRiU0rj0bSciHM4X0NomziUNqCJLhGOsKsvSPbxVdULfXFfaDyjL
 G4iRzR78QMLFWvMbJo7Vjj6cvr10CZBJ+jAybukTmyANnhHGtbWKy3aG7Ao014sSi1Bl09Qv01B
 FTusu/m3erXPziSLdkcz2vuc9pfwnETmlOfjYvu9C6HFqaQgR0FFTBf90tJrICQWaReAl1FgKWI
 5tWsHYuE/h3ebvOERsJJJvVyG0urBmB62W0X6n5hzlzUlkAvTAPRc06rW5RkkKbNQkLYipIDkXV
 HiL5sAbsnB3xlAZPr/LoFvT6QeFJIyGEVqiPr
X-Received: by 2002:a05:620a:3188:b0:943:ff70:dc00 with SMTP id
 af79cd13be357-9442174fc9emr1039734385a.56.1793496329626; 
 Sat, 31 Oct 2026 18:25:29 -0700 (PDT)
Received: from olive.mynetworksettings.com
 ([2600:4040:b076:8700:60ba:f09c:358e:e7a7])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-94425ac5322sm493379285a.39.2026.10.31.18.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 18:25:29 -0700 (PDT)
From: Matthew Krebs <matthewkrebs8@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Matthew Krebs <matthewkrebs8@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH] drm/amdkfd: Only take the VRAM path for KFD device pages in
 svm_range_dma_map_dev
Date: Sat, 31 Oct 2026 21:25:00 -0400
Message-ID: <20261101012500.7048-1-matthewkrebs8@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:06:53 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

svm_range_dma_map_dev() treats every ZONE_DEVICE page returned by
hmm_range_fault() as VRAM of the range's SVM BO. KFD's own VRAM pages
are MEMORY_DEVICE_PRIVATE or MEMORY_DEVICE_COHERENT, but fsdax
(MEMORY_DEVICE_FS_DAX) and device-dax (MEMORY_DEVICE_GENERIC) pages are
ZONE_DEVICE too. They are system memory.

When a process maps a file on a filesystem mounted with -o dax and lets
the GPU access it (for example hipMemcpy() from the mapping, which
registers the range through the SVM ioctl), the range is in system
memory and prange->svm_bo is NULL, so the VRAM branch dereferences it:

  BUG: kernel NULL pointer dereference, address: 0000000000000078
  RIP: 0010:svm_range_dma_map_dev+0x13b/0x300 [amdgpu]
  Call Trace:
   svm_range_validate_and_map+0x600/0xa70 [amdgpu]
   svm_range_set_attr+0x450/0x8c0 [amdgpu]
   svm_ioctl+0x62/0x80 [amdgpu]
   kfd_ioctl_svm+0x5e/0xe0 [amdgpu]
   kfd_ioctl+0x532/0x680 [amdgpu]

The process is then left unkillable and later KFD calls in other
processes can block, until a reboot.

Even with an SVM BO the computed address would be wrong for such a
page. Take the VRAM path only for device private and device coherent
pages and DMA map every other page, as for normal system memory.

Fixes: 1d5dbfe6c06a ("drm/amdkfd: classify and map mixed svm range pages in GPU")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Matthew Krebs <matthewkrebs8@gmail.com>
---

Notes:
    Reproducer (needs a filesystem mounted with -o dax; an emulated pmem
    from memmap=4G!12G and "ndctl create-namespace -m fsdax" works too):
    
      fd = open("/mnt/pmem/file", O_RDONLY);          /* >= 64 MiB, on DAX */
      src = mmap(NULL, 64 << 20, PROT_READ, MAP_SHARED, fd, 0);
      hipMalloc(&dst, 64 << 20);
      hipMemcpy(dst, src, 64 << 20, hipMemcpyHostToDevice);
    
    An application doing this (hipMemcpy from an mmap of a file on the DAX
    mount) oopsed as in the commit message. The minimal program above was
    written afterwards and has only been run on the patched kernel.
    
    Tested on Ubuntu 7.0.0-38-generic (based on v7.0.14) with this patch
    applied to that tree (it applies cleanly), 2x Radeon Pro V620 (Navi 21,
    gfx1030), ROCm 7.14, Intel Optane in fsdax mode, XFS mounted dax=always:
    
    - Before: the application oopsed in svm_range_dma_map_dev on every
      start (3 of 3, on GPU 0 and on GPU 1); the task was left unkillable
      and a later hipHostRegister in another process blocked in
      __synchronize_srcu until a reboot.
    - After: hipMemcpy and hipHostRegister + copy from the DAX mapping,
      64 MiB and 1 GiB, on both GPUs, data read back equal; the same on a
      non-DAX file; the application (an LLM server mapping a 111 GB model
      file from the DAX mount) starts and answers requests. No oops.
    - With dynamic debug on svm_range_dma_map_dev, the pages DMA mapped
      during the copy have pfns inside the pmem region, and KFD's own VRAM
      pages in the same call still take the VRAM branch.
    
    Not tested: MEMORY_DEVICE_COHERENT systems (the GPU memory registered
    as coherent), device-dax (/dev/daxX.Y) mappings, other ASICs.
    
    A stricter test would be "the page belongs to a KFD pgmap", e.g.
    page_pgmap(page)->ops == &svm_migrate_pgmap_ops, which also rules out
    another driver's device-coherent pages. I used the type test because it
    needs no new helper; happy to switch if you prefer that.

 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e33188..354184829 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -180,7 +180,12 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
-		if (is_zone_device_page(page)) {
+		/*
+		 * Only KFD's own VRAM pages (device private or device coherent)
+		 * take the VRAM path. Other ZONE_DEVICE pages, such as fsdax or
+		 * device-dax memory, are system memory and are DMA mapped below.
+		 */
+		if (is_device_private_page(page) || is_device_coherent_page(page)) {
 			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
-- 
2.43.0

