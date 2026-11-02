Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C5A606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 09:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SpfJT48o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA0EE10F4A7;
	Tue,  3 Nov 2026 09:36:52 +0000 (UTC)
Received: from mail-pz2-f8.google.com (mail-pz2-f8.google.com [74.125.228.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B19210EF7C
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 15:02:48 +0000 (UTC)
Received: by mail-pz2-f8.google.com with SMTP id
 41be03b00d2f7-cd5cd8e8104so552451a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 07:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793631767; x=1794236567; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HTYnB64kl/8K8S/l1jw09tVmV1tXPpdfAcVOVpBhqUg=;
 b=SpfJT48o3RTkxqfrRsZhJ/95X7sIS/1MnPr2h6xr0Tsr6nDYKUVy5j3rrSwbBjnd9m
 fanixpZsLfumy1W2xIp81Ey+EETCF3f/RyxX5fBbNawHaJkE7Pv7OCwQpMLijVm48bXG
 QdJ7gV4mV5uAzHz5rv3y9XGsqkapdWYUmhi2Z8UglyHDhmgofcWMnEIO+8/nzHzxhkQG
 G52nKQ0PVfiyeWM/l2h68w2o90Nd4WhsRo7w0H9GWAGytGRIpjdXGSNe4ss/2belp4fw
 HpQcxMLgEEqQb343nuRCkuYBLHTIc0gnrzX7u+ozkVw2Hb7DxBeMwpECtzJIioZjhCgO
 OXhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793631767; x=1794236567;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=HTYnB64kl/8K8S/l1jw09tVmV1tXPpdfAcVOVpBhqUg=;
 b=HS3POhZC4seppYZWlY8JRnk/WwB2sXNJTlgNxmEq3HHlxDl72ZzGqNR5qYo4x6bJUH
 uuQdizm6bCc0yMOR+MYd7hy/gHsphuFqrGzEPDd5QfYHb2M+PjjAcAYEvou5hFshSQCG
 8gK1zjpPT4h7e15YrAkhNDBTmmkA0TF0NWgcmhtZEqRX5YSlH2vt01Jg0yL1V04Y9UQw
 PQ0Wn7N9sFpMILtFQllY6Kt6dZbDdE3iA5jfWOxq5PY4adkXlF5B3EanRoo5GNintVSc
 bcgJBWoTz5Qt6rOGVz0nXsDwpm+Nh2vpBpLCLq0tf0XyahZlcsHq8G2K7UHa71hifd9y
 GGyA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhtNxfVUt32lyWfPmrp36i0fGVpZs4IXn79U1CVo2mRGcA7vhMneHskoxevvENvV6k6qBaIFPu@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJxibwpUw1BvIwKovUBwAkDAZ6F9AErB8wh9T43wbcSBMDfPKFU
 B9GEcDK6OE7Oe5ZvVp18Y8ALtHKYq284IH8iGGrHCCRpqM1fkJVdcA6L
X-Gm-Gg: AYBFou0Y0qsihHdKIadeSbycYRNIMZhy7HC0URFvRhrKCHGgQUwBB6dZdwJYjXPonbe
 igq6DeN+T3/GzAACupp+ZcXcqlbZIK6l8Y6gbpG7Cu48vD3map2Dj9MXjkyMe7iavhgY9j6b2lh
 2DS+bsTnU9/aFKuEMIZquyJPpZe1E+5BreuESmugMRjdezm/DXSL2hJqtpOuqCR9Pr9uQKuW/tG
 wzbyGFQxH784Pkygw0kaif4b3KMlaLUump4EnI98WR6doNibtt0CpydA6qx9uzY+3cQIy/08zup
 KqMfP4+mNRRH+I9v2QX3Mym0Y23NuwXC5bPnRFuaxp4yXwMqi6Rddxl2XAKT1pJFHFewi5mBsXF
 3TeYilb2ugim/YXObdkQ7fZcPF9sZtP1pnzYoxoDhQvi39x97v+lhhbG5B14PMlyBd8Qo4yEeoP
 qYT9fTWzMZUidxyaS8eG1kK2S9zz7TrgKV/N11ZUqyDXj2CpJDjStqLFT/ac8zhcMAstolpy1B9
 9NiDzAw7xoZymhHRD1sz7gMhQu0+WpNZXbNvGwbe5EWiVuJUneHemVy6kIGD8JK55F/mfwWST7p
 RU0shqa1kqN088Xq9sFQNdcBOYkTp/eV8f07cYi61dIvaZckO/LtE36/Ug4FclfUlYsz/wrQWa8
 gVogJ523ctSvXpRHNYWOeq4RB5p+a8PEf
X-Received: by 2002:a05:6a21:4994:b0:3e0:b71b:a8ec with SMTP id
 adf61e73a8af0-3e928c9f5e6mr7089810637.21.1793631767479; 
 Mon, 02 Nov 2026 07:02:47 -0800 (PST)
Received: from [10.131.7.109] (n106-71-19-159.sun21.vic.optusnet.com.au.
 [106.71.19.159]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb09800dc1sm3490669a12.22.2026.11.02.07.02.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 07:02:46 -0800 (PST)
From: Aveline Noir <jm5905938@gmail.com>
Date: Tue, 03 Nov 2026 02:00:19 +1100
Subject: [PATCH] drm/amdkfd: reject foreign device pages in
 svm_range_dma_map_dev()
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-kfd-svm-foreign-vram-20261103-v1-1-d6282053cad3@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32MywrCMBBFf6XM2oGkpYr+irjIY9KO0lRmtAil/
 26i4NLlufdwVlASJoVTs4LQwspzLmB3DYTR5YGQY2FoTbu31nR4SxF1mTDNQjxkXMRN+HuPgcz
 B9J3pU4TSuAslfn3658uX9emvFB41Wg3vlNCLy2Gs0/98lWHb3r0d7Zm2AAAA
X-Change-ID: 20261103-kfd-svm-foreign-vram-20261103-9ce0705305fd
To: Felix Kuehling <Felix.Kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alex Sierra <alex.sierra@amd.com>, Philip Yang <Philip.Yang@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Mailman-Approved-At: Tue, 03 Nov 2026 09:36:47 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

svm_range_dma_map_dev() converts every zone device page returned by
hmm_range_fault() to a VRAM address using prange->svm_bo, and
svm_range_get_pte_flags() takes the VRAM node from prange->svm_bo too.

The dev_private_owner passed to HMM is per device or XGMI hive, not per
process, so HMM can also return pages of another svm_bo. For example,
after fork() the child shares the parent's VRAM pages, and validating
the child's range returns them. If the child's range has no svm_bo,
prange->svm_bo is dereferenced as NULL. If its svm_bo is on another
device in the hive, the address is computed with that device's VRAM
base and pgmap range instead of the page's.

Fail the mapping with -EFAULT for zone device pages outside the pgmap
of the svm_bo device. Clear the entry before returning, because its old
DMA mapping, if any, has already been unmapped and must not be unmapped
again.

Fixes: 1d5dbfe6c06a ("drm/amdkfd: classify and map mixed svm range pages in GPU")
Signed-off-by: Aveline Noir <jm5905938@gmail.com>
---
Found by source review. Compile-tested only (W=1, no new warnings);
not tested on AMD hardware, so the fork case has not been reproduced.

KFD SVM is being moved to drm_gpusvm, so this is only meant as a small
fix for existing kernels.
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index ed5e3318877b..6e9b9dcaa136 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -181,7 +181,21 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
 		if (is_zone_device_page(page)) {
-			struct amdgpu_device *bo_adev = prange->svm_bo->node->adev;
+			struct amdgpu_device *bo_adev = prange->svm_bo ?
+				prange->svm_bo->node->adev : NULL;
+
+			/*
+			 * The pgmap owner is per device or XGMI hive, so HMM
+			 * may return a page of another svm_bo, e.g. one shared
+			 * with another process after fork(). The VRAM address
+			 * below and svm_range_get_pte_flags() assume the
+			 * svm_bo device.
+			 */
+			if (!bo_adev ||
+			    page_pgmap(page) != &bo_adev->kfd.pgmap) {
+				addr[i] = 0;
+				return -EFAULT;
+			}
 
 			addr[i] = (hmm_pfns[i] << PAGE_SHIFT) +
 				   bo_adev->vm_manager.vram_base_offset -

---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261103-kfd-svm-foreign-vram-20261103-9ce0705305fd

