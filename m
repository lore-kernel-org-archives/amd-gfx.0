Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11F04C3ABB8
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 21:48:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6579010E034;
	Sun,  4 May 2025 21:48:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KJLveLQm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEB9C10E034
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 21:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=N1hLba7vIkWXacy63AXwit4LVRNl38iWbZj3McuVxMI=; b=KJLveLQmLgdBbEbpSzDdq05AVj
 haFIomp/4LBUCwdXvtG/qbXi1QbrDoS+lVQfuVS4cuaSyEc3DldSrw4wpp+OxfGyTEylS1Mzagpqk
 bYX4TXU12tPyf/FUCfwJW7VVYmUw5xCFgm8tafQcupC3LLBHImeH2bYh82q+Ct75W2//NJ9E+0xW9
 t6ruOXh4Odme0oEfglw+iGEgPTHcOxFxWY0G6AHLWNmUH/0HLxdnJ05m8VXoCK9hgpzrjK8dRusjM
 meax4EaSdpYIZJffLx0yC6IcNOvky0RtoryrabHH1qiiQA2B9NMXk9Fy1or/dt13omT+/LwCA2Dqy
 0AJSNksg==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBh9E-003PPH-4Z; Sun, 04 May 2025 23:48:15 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/6] drm/amd/amdgpu: Add a helper to copy the CSB buffer into
 the ring buffer
Date: Sun,  4 May 2025 15:47:34 -0600
Message-ID: <20250504214801.406245-2-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504214801.406245-1-siqueira@igalia.com>
References: <20250504214801.406245-1-siqueira@igalia.com>
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

In the GFX code, there are multiple parsers of the CSB buffer, which can
be avoided. This data is parsed via get_csb_buffer() in earlier stages,
and the result can be checked in "adev->gfx.rlc.cs_ptr". To avoid
re-parser the CSB buffer, this commit introduces a helper that copies
the CSB buffer into the ring buffer.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 21 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 8f1a2f7b03c1..dfd48670a0bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2323,6 +2323,27 @@ void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count)
 	buffer[count++] = cpu_to_le32(0);
 }
 
+/**
+ * amdgpu_gfx_write_csb_to_ring - Write the CSB buffer into the ring
+ *
+ * @ring: Ring reference.
+ * @csb_buffer: CSB buffer.
+ * @csb_size: CSB buffer size.
+ *
+ * Usually, the adev->gfx.rlc.cs_ptr field is filled in earlier stages via
+ * get_csb_buffer(). This function just gets the CSB buffer and fills it in the
+ * ring buffer.
+ */
+void amdgpu_gfx_write_csb_to_ring(struct amdgpu_ring *ring,
+				  volatile u32 *csb_buffer,
+				  u32 csb_size)
+{
+	int i;
+
+	for (i = 0; i < csb_size; i++)
+		amdgpu_ring_write(ring, csb_buffer[i]);
+}
+
 /*
  * debugfs for to enable/disable gfx job submission to specific core.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 08f268dab8f5..ce684c3d3d89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -646,6 +646,10 @@ u32 amdgpu_gfx_csb_preamble_start(volatile u32 *buffer);
 u32 amdgpu_gfx_csb_data_parser(struct amdgpu_device *adev, volatile u32 *buffer, u32 count);
 void amdgpu_gfx_csb_preamble_end(volatile u32 *buffer, u32 count);
 
+void amdgpu_gfx_write_csb_to_ring(struct amdgpu_ring *ring,
+				  volatile u32 *csb_buffer,
+				  u32 csb_size);
+
 void amdgpu_debugfs_gfx_sched_mask_init(struct amdgpu_device *adev);
 void amdgpu_debugfs_compute_sched_mask_init(struct amdgpu_device *adev);
 
-- 
2.47.2

