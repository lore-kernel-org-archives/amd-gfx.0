Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0613BD5B161
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Dec 2025 06:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6907810E6C4;
	Tue, 16 Dec 2025 06:00:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nV72Nyrn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 123DB10E6CE
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Dec 2025 06:00:57 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 038FD6013F;
 Tue, 16 Dec 2025 06:00:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5097EC4CEF1;
 Tue, 16 Dec 2025 06:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765864855;
 bh=lGOdddNyh6HXrCriC7RNdSGzk2mc2fWZ96CcCU9HTRs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nV72Nyrn0PvLEdSiAwZs8+HcwAloZWXjImsjySJVoubbtvPmmhWQRGnDQEqcW+aWe
 Iz9dNQGLDv/xzVi+hSS3lg9slRgZH+F97IcbEpLalgB+0LvXvfHoKZMN+7sP8vgnHx
 dD1FWRel5wPoSwdBCIjGuyNPKYaB4oVERH0DvqhGMvDMWdGoLipPI8gTFR3Kl+TiMF
 BBtVAWz9Kguo7+/9xz1Zm/l++GUNY5kafVHqle2ZNgNiJ4td5Cgd+6NftzHKdny0EL
 3XC9XFClTDKRhKqXiAegk6BHuWvOBAGsSjeg2z60Q9oMQSSbhfng7dPnFQvKQAicQH
 2FRMk/vcdaOxA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Kent Russell <kent.russell@amd.com>
Subject: [PATCH v3 1/2] amdkfd: Only ignore -ENOENT for KFD init failuires
Date: Tue, 16 Dec 2025 00:00:45 -0600
Message-ID: <20251216060046.3131-2-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216060046.3131-1-superm1@kernel.org>
References: <20251216060046.3131-1-superm1@kernel.org>
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

Reviewed-by: Kent Russell <kent.russell@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 18658985a57ce..7eaea3f216fd3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -3177,8 +3177,10 @@ static int __init amdgpu_init(void)
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

