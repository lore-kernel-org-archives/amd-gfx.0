Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C604BC369B9
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 20:22:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CABCB10E3F5;
	Sat, 12 Apr 2025 20:22:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WUrufMEE";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4689F10E3F4
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 20:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X2G+CkHO5cGBPv2izOHtMkfwdF9b7q6L1ZuqUx2VD+0=; b=WUrufMEEWkbZi2PAF9GSe6otNu
 XL0lnDn6MHYdkLz0qJE6FuLMFgtvAH/h1cDFn7xkLiBvKaYdgJUBfQf7AY3Mpzgy3l5U1eF+A03iS
 YLUhyvmRVql2WErK877aVDSyuKyTWxOKe9W+6iLc8bGyLcVQTsdwujU/0PJgH3jiWTr2PlH/8q4xZ
 2r3c8mKXlOKKsnIbTV9SH4SuB8YIpe0IjfiSNcPE2Zl95KSkmsIVpl4SnTE/jJx/sNYvqfh4I0pq8
 IRH9TCSQp5OEzi2/FvyNJHQYQvHXTROq5VJN8cDSppqVCfJEBQOOGqxC6BWxCvUuzfB7J95n9Xw8D
 kuWGKUpA==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u3hMX-00Fepq-8l; Sat, 12 Apr 2025 22:22:01 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH v2 9/9] drm/amdgpu: Add CSB documentation
Date: Sat, 12 Apr 2025 14:21:14 -0600
Message-ID: <20250412202134.3025051-10-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250412202134.3025051-1-siqueira@igalia.com>
References: <20250412202134.3025051-1-siqueira@igalia.com>
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

Add a description for the get_csb_buffer callback and an entry for CSB
in the glossary.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 Documentation/gpu/amdgpu/amdgpu-glossary.rst |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h      | 14 ++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/gpu/amdgpu/amdgpu-glossary.rst b/Documentation/gpu/amdgpu/amdgpu-glossary.rst
index 080c3f2250d1..8fb5f6de4df3 100644
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

