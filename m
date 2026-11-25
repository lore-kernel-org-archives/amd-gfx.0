Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E40606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=medichon.fr header.i=@medichon.fr header.a=rsa-sha256 header.s=ovhmo3801317-selector1 header.b=mph41XFg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C187811210E;
	Thu, 26 Nov 2026 08:09:50 +0000 (UTC)
X-Greylist: delayed 35999 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 02:50:16 UTC
Received: from 1.mo582.mail-out.ovh.net (1.mo582.mail-out.ovh.net
 [46.105.56.136])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4233210E191
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 02:50:16 +0000 (UTC)
Received: from director10.ghost.mail-out.ovh.net (unknown [10.110.58.226])
 by mo582.mail-out.ovh.net (Postfix) with ESMTP id 4jZPrw3K5Yz5xpZ
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 16:14:40 +0000 (UTC)
Received: from ghost-submission-7ccd8bbbb6-gbzqj (unknown [10.109.231.29])
 by director10.ghost.mail-out.ovh.net (Postfix) with ESMTPS id E9F96C1531;
 Wed, 25 Nov 2026 16:14:39 +0000 (UTC)
Received: from medichon.fr ([37.59.142.101])
 by ghost-submission-7ccd8bbbb6-gbzqj with ESMTPSA
 id KAVmL28JB2va7xAA6gsS9A
 (envelope-from <abo@medichon.fr>); Wed, 25 Nov 2026 16:14:39 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-101G004353983fd-9bae-4eb3-a465-d7af331b23b8,
 7DE1F8E91E93E4FED769CE8C88DE2ED5D32FAA0F) smtp.auth=abo@medichon.fr
X-OVh-ClientIp: 88.190.90.129
From: Arnaud Bonnet <abo@medichon.fr>
To: christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	Arnaud Bonnet <abo@medichon.fr>
Subject: [PATCH] drm/amdgpu: fix function parameter documentation warnings
Date: Wed, 25 Nov 2026 17:14:17 +0100
Message-ID: <20261125161417.214372-1-abo@medichon.fr>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
x-ovh-tracer-id: 680043545294102110
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: dmFkZTGaE4s7hjrizI8grAG99y+sLA33f9wdGxKid9mi4n4XAkiAESSEU87iz+4Ny6vp4SGO51JeZTbw0j6f06Nyt2ujiWeE2pyd95G0rU1DELZeOcEVTK+zOvOmGc7bsQY3JxYS/nJnuysB1u0qqUsdiRgoyRH/8gWlWqhxPoY/F5LY2R1xKUWl3Gso5HxBhhn1+dGC3QFAb0xnhNA99bs4hXd8+K+L2lDMCFN9Qrg9Y2n5nkcV0VUrieA6/LacIz90WX6Ez5FCbwOu3wIfsPM7ckP/x7yWNUDPELJHATy9wK7sO1vaFXDZdXvc/P+q56k5uUL8k0bkPCb9dQCZwhLkl6qCSJ7RZgUU/tJFA0aB1Bj3gFyhZiSP5OREZnmRvTMq7XFVkBpm+4ee4ze60/NClTHffOTnkgOUNRz8VK43y7eARKVhYPsIXlkG4yk5MKfE7aGxBm+n2ApQaC6IvF7sv8FaZLhu2n1pBE2+YUcoGv0IG2rJ9rwONqWznpRiYrVSylN+G12yTGO9dhsXm+kAPXKmu1dIOzvkk0DKY/gRkGE7mEn71AlvXaM6JZ9zXT695SbuNW1T10LyWIxtlhS4r38outNkmU8ruDbdNqx6KcohmbDmz/k7KBUT6aV+mEHXtM001FJVrau0Kve8L84skedPZXnWz8mmPiHrzaPDsArN0w
DKIM-Signature: a=rsa-sha256; bh=deDwTD+MrY6yiqGJzngEBk47iMMDhBHBcV2T2JtXtDA=; 
 c=relaxed/relaxed; d=medichon.fr; h=From;
 s=ovhmo3801317-selector1; t=1795623280; v=1;
 b=mph41XFgIlKwD+D45kStWAV4buFhI583b/gC4h93kocNWykRzFP2eTHAZmN9ETGnOliyB5y6
 NM6rzIDr1yqEeMN//97d5/dlmkn3ObMOSy4Nvi7gxgG+8qOIVOgUaPFIxr4vCA+ElqoMjZJuBrY
 NVoeSDixefz5EXOECiseeaSAlG1nP+XHorb9SKB2iaNaZM5srXQyu01mVXylESQtnmF8paVNYyL
 dSZqyvcDNXmumgZrDZJOXb2fuAQMJdxaJVwtCtRAXa0xe1rrfUmWKSLsaeptv1TmmhNDkHEHC27
 ugmheCKcAjfY5/jFrYRPHFJZ/VDHe1MMEnQmNFQps2iXA==
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Fixes several kernel doc warnings not deserving of their own patches.

In file sdma_v4_4_2.c:
Commit 0518c66cf841 ("drm/amdgpu/sdma: Fix executing duplicate commands
after recovery on SDMA v4.4.2") removes the restore boolean parameter
from sdma_v4_4_2_page_resume() without removing it from the
documentation, leading to the following warning:

	Warning: drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c:758 Excess
	function parameter 'restore' description in
	'sdma_v4_4_2_page_resume'

Remove the restore parameter from the parameter list.

In files jpeg_v5_0_2.c and vcn_v5_0_2.c:
Functions jpeg_v5_0_2_start_sriov and vcn_v5_0_2_start_sriov take the
struct amdgpu_device but do not add it to the documentation block,
leading to the following warnings:

	Warning: drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c:433 function
	parameter 'adev' not described in 'jpeg_v5_0_2_start_sriov'
	Warning: drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c:724 function
	parameter 'adev' not described in 'vcn_v5_0_2_start_sriov'

Add the standard amdgpu_device pointer parameter description to both
functions.

Signed-off-by: Arnaud Bonnet <abo@medichon.fr>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 1 -
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  | 2 ++
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index af1feba68dc3..a1a319a00b1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -429,6 +429,8 @@ static void jpeg_v5_0_2_init_jrbc(struct amdgpu_ring *ring)
 
 /**
  * jpeg_v5_0_2_start_sriov - start JPEG block under SRIOV env
+ *
+ * @adev: amdgpu_device pointer
  */
 static int jpeg_v5_0_2_start_sriov(struct amdgpu_device *adev)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index b99fbad2ea01..6135c6bf54ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -750,7 +750,6 @@ static void sdma_v4_4_2_gfx_resume(struct amdgpu_device *adev, unsigned int i)
  *
  * @adev: amdgpu_device pointer
  * @i: instance to resume
- * @restore: boolean to say restore needed or not
  *
  * Set up the page DMA ring buffers and enable them.
  * Returns 0 for success, error for failure.
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index 2f4aed8cd1ea..c8bb6ecd5bff 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -719,6 +719,8 @@ static int vcn_v5_0_2_start_dpg_mode(struct amdgpu_vcn_inst *vinst,
 
 /**
  * vcn_v5_0_2_start_sriov - VCN start under SRIOV env
+ *
+ * @adev: amdgpu_device pointer
  */
 
 static int vcn_v5_0_2_start_sriov(struct amdgpu_device *adev)
-- 
2.53.0

