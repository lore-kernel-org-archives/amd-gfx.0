Return-Path: <SRS0=Wekg=IG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1E7C433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:46:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E146E650DC
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Mar 2021 20:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E146E650DC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EFF76E887;
	Mon,  8 Mar 2021 20:46:12 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3AC76E887;
 Mon,  8 Mar 2021 20:46:11 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FCF164DF5;
 Mon,  8 Mar 2021 20:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1615236371;
 bh=fJsMy6YyZc0GKNaInkxN1wNn9x/iFUp/YIamYo3r9jI=;
 h=From:To:Cc:Subject:Date:From;
 b=GstGoT78JFxcmwrLZvbduyxRkkzi3fBn4/2ug3/IqmAiiXC/qScbn1IB1l4LQTSe3
 BhDMTGvLDckABUwk1+MnssjPMYdAkU0PTrrmwQhtkyw+r1qbuJM6NSejids/mj5rAi
 Kiq+/4VbA0+8LDY5mhc1/LZi9wwCa1w+ge388GTUqcIL3yH3YGjPL48trvXCRQPzUR
 qRO6rLigtFBI3biLv9xYgKuqbQv3cpF271T/R8oj0piQYywprrJ3OYm5/mhf0HkJmU
 FAP4uGMpwOwnkIwV3GWJflWEa8TVwjW9EE8m0hQtYUvsVXpFxZOwL1W8Vc9waTyYN0
 +6L6Qlp6gZrag==
From: Arnd Bergmann <arnd@kernel.org>
To: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] [variant b] drm/amdkfd: fix build error with missing
 AMD_IOMMU_V2
Date: Mon,  8 Mar 2021 21:45:49 +0100
Message-Id: <20210308204606.2634726-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
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
Cc: Oded Gabbay <oded.gabbay@gmail.com>, Philip Yang <philip.yang@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

Using 'imply AMD_IOMMU_V2' does not guarantee that the driver can link
against the exported functions. If the GPU driver is built-in but the
IOMMU driver is a loadable module, the kfd_iommu.c file is indeed
built but does not work:

x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_bind_process_to_device':
kfd_iommu.c:(.text+0x516): undefined reference to `amd_iommu_bind_pasid'
x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_unbind_process':
kfd_iommu.c:(.text+0x691): undefined reference to `amd_iommu_unbind_pasid'
x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_suspend':
kfd_iommu.c:(.text+0x966): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0x97f): undefined reference to `amd_iommu_set_invalid_ppr_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0x9a4): undefined reference to `amd_iommu_free_device'
x86_64-linux-ld: drivers/gpu/drm/amd/amdkfd/kfd_iommu.o: in function `kfd_iommu_resume':
kfd_iommu.c:(.text+0xa9a): undefined reference to `amd_iommu_init_device'
x86_64-linux-ld: kfd_iommu.c:(.text+0xadc): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0xaff): undefined reference to `amd_iommu_set_invalid_ppr_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0xc72): undefined reference to `amd_iommu_bind_pasid'
x86_64-linux-ld: kfd_iommu.c:(.text+0xe08): undefined reference to `amd_iommu_set_invalidate_ctx_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0xe26): undefined reference to `amd_iommu_set_invalid_ppr_cb'
x86_64-linux-ld: kfd_iommu.c:(.text+0xe42): undefined reference to `amd_iommu_free_device'

Change the 'imply' to a weak dependency that still allows compiling
in all other configurations but disallows the configuration that
causes a link failure.

Fixes: 64d1c3a43a6f ("drm/amdkfd: Centralize IOMMUv2 code and make it conditional")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpu/drm/amd/amdkfd/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/Kconfig b/drivers/gpu/drm/amd/amdkfd/Kconfig
index f02c938f75da..d01dba2af3bb 100644
--- a/drivers/gpu/drm/amd/amdkfd/Kconfig
+++ b/drivers/gpu/drm/amd/amdkfd/Kconfig
@@ -6,7 +6,7 @@
 config HSA_AMD
 	bool "HSA kernel driver for AMD GPU devices"
 	depends on DRM_AMDGPU && (X86_64 || ARM64 || PPC64)
-	imply AMD_IOMMU_V2 if X86_64
+	depends on AMD_IOMMU_V2=y || DRM_AMDGPU=m
 	select HMM_MIRROR
 	select MMU_NOTIFIER
 	select DRM_AMDGPU_USERPTR
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
