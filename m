Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3882AC369AB
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Apr 2025 22:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE5410E4B8;
	Mon, 21 Apr 2025 22:18:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="NdY+CyRw";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0F0910E4B8
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Apr 2025 22:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kd9oIWQqcxS+JPXI0ys1qBUAxcPHx6ODFGvXarKkHPw=; b=NdY+CyRwlLVOXbdVjY5sRb4GBV
 Mcf3lbPziDXbile4XR5YefkmVrlndR5/UTdHq1SHh+mNzTWu/7xfO6kA+pZ5m63GrwEk6CXRU6TpQ
 qY3TvOIe+JwAAAoTCNuoipHqQP8rkSQxHhG8/IYeUtboNjhuTvHrdS82e00kqBPsbdIuKNrLkCDyr
 UNxDo7ysis5aiAL1Jky6BcmVlKE+2GoGbAIuZe6Pa+Uj87ou3bOWLRF6aNnYcxP+uZkwu9v3FXK5r
 nNJyr/GMmgFvz6tzf2+mEZNgnrTv3Fs1tlmLA78d/TCJgsaXET8H+G3aGlakOCEdaaEOnHm6VPX7T
 hfLijTiA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u6zTR-006CMY-ST; Tue, 22 Apr 2025 00:18:46 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v3 9/9] drm/amdgpu: Add documentation associated with CSB
Date: Mon, 21 Apr 2025 16:12:26 -0600
Message-ID: <20250421221616.387927-10-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421221616.387927-1-siqueira@igalia.com>
References: <20250421221616.387927-1-siqueira@igalia.com>
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

Add a description for the get_csb_buffer callback, update the glossary,
and add some extra information about RB, which is associated with CSB
configuration.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst |  6 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      | 43 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h      | 14 +++++++
 3 files changed, 63 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 080c3f2250d1..8e6af7cc76c2 100644
--- a/Documentation/gpu/amdgpu/amdgpu-glossary.rst
+++ b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
@@ -33,6 +33,9 @@ we have a dedicated glossary for Display Core at
     CS
       Command Submission
 
+    CSB
+      Clear State Indirect Buffer
+
     CU
       Compute Unit
 
@@ -134,6 +137,9 @@ we have a dedicated glossary for Display Core at
     PSP
         Platform Security Processor
 
+    RB
+      Render Backends. Some people called it ROPs.
+
     RLC
       RunList Controller. This name is a remnant of past ages and doesn't have
       much meaning today. It's a group of general-purpose helper engines for
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 9187b0b3bff6..08f268dab8f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -170,10 +170,46 @@ struct amdgpu_kiq {
 #define AMDGPU_GFX_MAX_SE 4
 #define AMDGPU_GFX_MAX_SH_PER_SE 2
 
+/**
+ * amdgpu_rb_config - Configure a single Render Backend (RB)
+ *
+ * Bad RBs are fused off and there is a harvest register the driver reads to
+ * determine which RB(s) are fused off so that the driver can configure the
+ * hardware state so that nothing gets sent to them. There are also user
+ * harvest registers that the driver can program to disable additional RBs,
+ * etc., for testing purposes.
+ */
 struct amdgpu_rb_config {
+	/**
+	 * @rb_backend_disable:
+	 *
+	 * The value captured from register RB_BACKEND_DISABLE indicates if the
+	 * RB backend is disabled or not.
+	 */
 	uint32_t rb_backend_disable;
+
+	/**
+	 * @user_rb_backend_disable:
+	 *
+	 * The value captured from register USER_RB_BACKEND_DISABLE indicates
+	 * if the User RB backend is disabled or not.
+	 */
 	uint32_t user_rb_backend_disable;
+
+	/**
+	 * @raster_config:
+	 *
+	 * To set up all of the states, it is necessary to have two registers
+	 * to keep all of the states. This field holds the first register.
+	 */
 	uint32_t raster_config;
+
+	/**
+	 * @raster_config_1:
+	 *
+	 * To set up all of the states, it is necessary to have two registers
+	 * to keep all of the states. This field holds the second register.
+	 */
 	uint32_t raster_config_1;
 };
 
@@ -221,6 +257,13 @@ struct amdgpu_gfx_config {
 	uint32_t macrotile_mode_array[16];
 
 	struct gb_addr_config gb_addr_config_fields;
+
+	/**
+	 * @rb_config:
+	 *
+	 * Matrix that keeps all the Render Backend (color and depth buffer
+	 * handling) configuration on the 3D engine.
+	 */
 	struct amdgpu_rb_config rb_config[AMDGPU_GFX_MAX_SE][AMDGPU_GFX_MAX_SH_PER_SE];
 
 	/* gfx configure feature */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index fce22d3f816b..c210625be220 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -237,6 +237,20 @@ struct amdgpu_rlc_funcs {
 	void (*unset_safe_mode)(struct amdgpu_device *adev, int xcc_id);
 	int  (*init)(struct amdgpu_device *adev);
 	u32  (*get_csb_size)(struct amdgpu_device *adev);
+
+	/**
+	 * @get_csb_buffer: Get the clear state to be put into the hardware.
+	 *
+	 * The parameter adev is used to get the CS data and other gfx info,
+	 * and buffer is the RLC CS pointer
+	 *
+	 * Sometimes, the user space puts a request to clear the state in the
+	 * command buffer; this function provides the clear state that gets put
+	 * into the hardware. Note that the driver programs Clear State
+	 * Indirect Buffer (CSB) explicitly when it sets up the kernel rings,
+	 * and it also provides a pointer to it which is used by the firmware
+	 * to load the clear state in some cases.
+	 */
 	void (*get_csb_buffer)(struct amdgpu_device *adev, volatile u32 *buffer);
 	int  (*get_cp_table_num)(struct amdgpu_device *adev);
 	int  (*resume)(struct amdgpu_device *adev);
-- 
2.49.0

