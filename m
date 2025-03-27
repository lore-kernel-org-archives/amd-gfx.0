Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 027BEC3600B
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Mar 2025 20:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CFC910E950;
	Thu, 27 Mar 2025 20:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aMruUuK1";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB86D10E944
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Mar 2025 20:39:17 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 209CB61143;
 Thu, 27 Mar 2025 20:39:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2E20C4CEEB;
 Thu, 27 Mar 2025 20:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1743107952;
 bh=pJuylnnzVPVRP+f6YYUOl6Dvh7Ry0UffO2/iSTffZhg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=aMruUuK1u6OLKuLrWUFTTd/vWePAU+0/gMNNw3JHBFPyVU+LIi24Qdpq4wFjLywwE
 7KdJWh7MVQaMVxxnFnRsemW559BX0L4I44sxj8XoH7PtuwBIsag/iSiOaNc8v05T0b
 nn8O3uWjWPFWhZT79nYFcejfPnlsRNbC4zqQccOkqTRuE8EGvSCu95H8D8Xa2gGA2U
 T6gXzfLnN5qo7n3gr7svSYK4hg6Yx3jduAQZ2bzLc+RPVluI8aprAAj/eb4hdgE19R
 xgJvzVTQKMW8qv565g9k8Hi8dpZ5UIBHYBJZEc7MdgwlFu3sEt13ksDE/xeQjQrc/d
 i6NdM/e8PLtpg==
From: Mario Limonciello <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 06/14] drm/amd: Drop prototype for amdgpu_ucode_print_imu_hdr()
Date: Thu, 27 Mar 2025 15:38:50 -0500
Message-ID: <20250327203858.3796086-7-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250327203858.3796086-1-superm1@kernel.org>
References: <20250327203858.3796086-1-superm1@kernel.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

There is no matching function for amdgpu_ucode_print_imu_hdr().
Drop the prototype.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4eedd92f000be..e7fe4fd25e601 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -604,7 +604,6 @@ struct amdgpu_firmware {
 
 void amdgpu_ucode_print_mc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_smc_hdr(const struct common_firmware_header *hdr);
-void amdgpu_ucode_print_imu_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_gfx_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
-- 
2.43.0

