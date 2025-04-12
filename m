Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31919C369AB
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Apr 2025 20:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A41F710E3FC;
	Sat, 12 Apr 2025 20:44:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="M6iPCYh9";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EC3510E3FC
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Apr 2025 20:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
 Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pTrzFGyXWztFd70XmxdZEDF0uSGLnqbExhYHgQsSG2g=; b=M6iPCYh9YkrrIpEWgy3OuK6Uf6
 C857SKNiCxUdmDxuvF1v8c4nqYo73Tmg6tLuQyyygBEpefLStTdNPhCrer24YHMt7jFU785fwUJXQ
 Pkpn5JHiLzbr4FgkNBDrj1zQxF03trihtzkCzmt0O4HMajhJJ/enVemKYRRaaVD8WSODwAW7ntS98
 OMm9qxYUC+vA08bCiZir87uf+eZ2LkvMFPAoIYNNWrY5FpSUWNgyNz0fOyh5TkP+uCds7GBY6oFNT
 eiX6AEcegSm7SfnTf7uB7oyW1jq4lfThCKeuKjuUSjEu/GLN3PyvHDvmaQ5pW9QQDT9lu/5flzVTJ
 KYRICUNg==;
Received: from d162-157-58-14.abhsia.telus.net ([162.157.58.14]
 helo=maloca.lan) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1u3hiQ-00Ff69-CA; Sat, 12 Apr 2025 22:44:38 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH] drm/amdgpu: Remove PACKET2 from amdgpu since it is not used
Date: Sat, 12 Apr 2025 14:44:08 -0600
Message-ID: <20250412204420.3027587-1-siqueira@igalia.com>
X-Mailer: git-send-email 2.49.0
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

It looks like that CP_PACKET2 is from the radeon GPU driver and was
brought to amdgpu, but it was never used. This commit removes PACKET2
and related defines from amdgpu.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/cikd.h   | 5 -----
 drivers/gpu/drm/amd/amdgpu/nvd.h    | 5 -----
 drivers/gpu/drm/amd/amdgpu/sid.h    | 5 -----
 drivers/gpu/drm/amd/amdgpu/soc15d.h | 5 -----
 drivers/gpu/drm/amd/amdgpu/vid.h    | 5 -----
 5 files changed, 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cikd.h b/drivers/gpu/drm/amd/amdgpu/cikd.h
index 8aca4f2734f2..793e072fac8f 100644
--- a/drivers/gpu/drm/amd/amdgpu/cikd.h
+++ b/drivers/gpu/drm/amd/amdgpu/cikd.h
@@ -220,11 +220,6 @@
 #define PACKET0(reg, n)	((PACKET_TYPE0 << 30) |				\
 			 ((reg) & 0xFFFF) |			\
 			 ((n) & 0x3FFF) << 16)
-#define CP_PACKET2			0x80000000
-#define		PACKET2_PAD_SHIFT		0
-#define		PACKET2_PAD_MASK		(0x3fffffff << 0)
-
-#define PACKET2(v)	(CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
 
 #define PACKET3(op, n)	((PACKET_TYPE3 << 30) |				\
 			 (((op) & 0xFF) << 8) |				\
diff --git a/drivers/gpu/drm/amd/amdgpu/nvd.h b/drivers/gpu/drm/amd/amdgpu/nvd.h
index 56f1bfac0b20..2b1cd5622182 100644
--- a/drivers/gpu/drm/amd/amdgpu/nvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/nvd.h
@@ -39,11 +39,6 @@
 #define PACKET0(reg, n)	((PACKET_TYPE0 << 30) |				\
 			 ((reg) & 0xFFFF) |			\
 			 ((n) & 0x3FFF) << 16)
-#define CP_PACKET2			0x80000000
-#define		PACKET2_PAD_SHIFT		0
-#define		PACKET2_PAD_MASK		(0x3fffffff << 0)
-
-#define PACKET2(v)	(CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
 
 #define PACKET3(op, n)	((PACKET_TYPE3 << 30) |				\
 			 (((op) & 0xFF) << 8) |				\
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index cbd4f8951cfa..e6da0ecd4058 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -327,11 +327,6 @@
 #define PACKET0(reg, n) ((PACKET_TYPE0 << 30) |				\
                          ((reg) & 0xFFFF) |				\
                          ((n) & 0x3FFF) << 16)
-#define CP_PACKET2			0x80000000
-#define		PACKET2_PAD_SHIFT		0
-#define		PACKET2_PAD_MASK		(0x3fffffff << 0)
-
-#define PACKET2(v)	(CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
 #define RADEON_PACKET_TYPE3 3
 #define PACKET3(op, n)	((RADEON_PACKET_TYPE3 << 30) |			\
 			 (((op) & 0xFF) << 8) |				\
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15d.h b/drivers/gpu/drm/amd/amdgpu/soc15d.h
index a5000c171c02..a4c49e184c4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15d.h
+++ b/drivers/gpu/drm/amd/amdgpu/soc15d.h
@@ -41,11 +41,6 @@
 #define PACKET0(reg, n)	((PACKET_TYPE0 << 30) |				\
 			 ((reg) & 0xFFFF) |			\
 			 ((n) & 0x3FFF) << 16)
-#define CP_PACKET2			0x80000000
-#define		PACKET2_PAD_SHIFT		0
-#define		PACKET2_PAD_MASK		(0x3fffffff << 0)
-
-#define PACKET2(v)	(CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
 
 #define PACKET3(op, n)	((PACKET_TYPE3 << 30) |				\
 			 (((op) & 0xFF) << 8) |				\
diff --git a/drivers/gpu/drm/amd/amdgpu/vid.h b/drivers/gpu/drm/amd/amdgpu/vid.h
index b61f6b838ec2..f20553c61ada 100644
--- a/drivers/gpu/drm/amd/amdgpu/vid.h
+++ b/drivers/gpu/drm/amd/amdgpu/vid.h
@@ -96,11 +96,6 @@
 #define PACKET0(reg, n)	((PACKET_TYPE0 << 30) |				\
 			 ((reg) & 0xFFFF) |			\
 			 ((n) & 0x3FFF) << 16)
-#define CP_PACKET2			0x80000000
-#define		PACKET2_PAD_SHIFT		0
-#define		PACKET2_PAD_MASK		(0x3fffffff << 0)
-
-#define PACKET2(v)	(CP_PACKET2 | REG_SET(PACKET2_PAD, (v)))
 
 #define PACKET3(op, n)	((PACKET_TYPE3 << 30) |				\
 			 (((op) & 0xFF) << 8) |				\
-- 
2.49.0

