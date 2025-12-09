Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF544D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 04:46:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E29610E013;
	Tue,  9 Dec 2025 04:46:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pymJSZwH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B72810E013
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 04:46:49 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 172D943A75
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 04:46:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E34EC4CEF5;
 Tue,  9 Dec 2025 04:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765255608;
 bh=RYgzas/Ry3rmGLNTg7epIDmvgT7OQXEk4dfacvt5gXc=;
 h=From:To:Cc:Subject:Date:From;
 b=pymJSZwHU1dS67NFx7L/lf3XpaQbegF575PmhM6DtOIreC+emImlkMW2xZf9l2R/y
 haDMJTeSD+BXT7ZR7Q1QE7lMzUSGlqmy2rqK16cJNWeHFEbsyjphk5btsiIfXbj7Rw
 d3Wh563kIVqecf9zx7PCQkso6Zjkj1UYL6b4rW3Vsh8xfF1fkYiJx38l/s8/7gpE8E
 IA1ryilUXCrc5jBhPSvI0Ma96Aun2oAIY77jwQJ+Vjownyjh0zwUfh4sv9JkBEUMZ0
 b8S2AybeSt7ODT3nV72wcUQ2Nb4Y9NCP1TxazVYTA5SJ/4IVZmDQ0z0stqITWxXfox
 kvKasvMznm1YA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH] drm/amd: Fix unbind/rebind for VCN 4.0.5
Date: Mon,  8 Dec 2025 22:46:46 -0600
Message-ID: <20251209044646.345580-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Unbinding amdgpu has no problems, but binding it again leads to an
error of sysfs file already existing.  This is because it wasn't
actually cleaned up on unbind.  Add the missing cleanup step.

Fixes: 547aad32edac1 ("drm/amdgpu: add VCN4 ip block support")
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index b107ee80e4728..1f6a22983c0dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -265,6 +265,8 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_sriov_vf(adev))
 		amdgpu_virt_free_mm_table(adev);
 
+	amdgpu_vcn_sysfs_reset_mask_fini(adev);
+
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		r = amdgpu_vcn_suspend(adev, i);
 		if (r)
-- 
2.43.0

