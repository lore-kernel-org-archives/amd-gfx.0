Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80FF1D3E774
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Dec 2025 20:15:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCA210E27D;
	Wed, 10 Dec 2025 20:15:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SWDKlCry";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCEF510E776
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Dec 2025 20:15:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 849F54429B;
 Wed, 10 Dec 2025 20:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E286C116B1;
 Wed, 10 Dec 2025 20:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765397723;
 bh=ESOLllE61PG8BSajocIOUAscIoTSq6ib/Cl1TPCKnQU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=SWDKlCryjXaHIp808M9JUFi5P3KrOdMsxGW2+6JoGnwdxPzqks6djZiTXm6iMGqmu
 g0hilD337/3H4lvtEE257zczx8JKagYq9FmyWP2giiEBEvG5tkLLOLncYtInjQgq/D
 9NJhF2tjzoJ2Bd3biiqmWHSMI34Blc/7qFvBf4f9AmwxetGp2CTNW3C75DDogPMtxI
 wShazjOx7E8smLFbk6YpjbpJClKuJLW6kB4vWLnvv3lFhqHRPUdIxplG8UrBS2pCi1
 bEtBRjCFeakRNK0pCE8StIK163STEh3TsBuWntz2O4jR2j4yIvHD9ESkKaoth+AQ4K
 QyQKU+C3VbbAA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Kent Russell <kent.russell@amd.com>
Subject: [PATCH v2 1/3] amdkfd: Only ignore -ENOENT for KFD init failuires
Date: Wed, 10 Dec 2025 14:15:08 -0600
Message-ID: <20251210201510.3000-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251210201510.3000-1-superm1@kernel.org>
References: <20251210201510.3000-1-superm1@kernel.org>
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

When compiled without CONFIG_HSA_AMD KFD will return -ENOENT.
As other errors will cause KFD functionality issues this is the
only error code that should be ignored at init.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 16adeba4d7e68..e804461e5f272 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3169,8 +3169,10 @@ static int __init amdgpu_init(void)
 	amdgpu_register_atpx_handler();
 	amdgpu_acpi_detect();
 
-	/* Ignore KFD init failures. Normal when CONFIG_HSA_AMD is not set. */
-	amdgpu_amdkfd_init();
+	/* Ignore KFD init failures when CONFIG_HSA_AMD is not set. */
+	r = amdgpu_amdkfd_init();
+	if (r && r != -ENOENT)
+		goto error_fence;
 
 	if (amdgpu_pp_feature_mask & PP_OVERDRIVE_MASK) {
 		add_taint(TAINT_CPU_OUT_OF_SPEC, LOCKDEP_STILL_OK);
-- 
2.43.0

