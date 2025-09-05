Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A49ECA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 13:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B83410E2DF;
	Fri,  5 Sep 2025 13:03:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=listout.xyz header.i=@listout.xyz header.b="Aiy9I0PN";
	dkim-atps=neutral
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7192A10E0A1
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 02:16:09 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cJ0M95dSYz9tZg;
 Fri,  5 Sep 2025 04:16:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=listout.xyz; s=MBO0001;
 t=1757038565;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=ocm0FbiUYOoHqiFBpqSwEbKs77Xt05F79aFj0gzRZBQ=;
 b=Aiy9I0PN/1XS59GuZkAItvXefIDBCZuAjOWqqwSQCifbGDR8ImisvoEi12WFFWBMOh2rgS
 PrIb0CgU0N5DEi9jhG/Hxr/CM1Ptzm0q5Hv8xS1Sj+Q9G0I3oJcQtZ7y5EIx0I45G8fKm8
 pIWyDYdP3fxKuFHDW2lpeF73XGtRjz5/ddXlyMvgAvbWi+tUK1aEKmRthDez5/XuJcvZe6
 dlGsIYdqBiinwRYGipAE6ozwlo9c7Eogpk0DriVsvmR6eFanJTVpDknRFj8bHD1IsIdtV+
 //uZHy0ramkxYuwH2sCMjJ4GzG4mvf283ooKy6XNz7gl5jiPgenSjXNUzet7RQ==
Authentication-Results: outgoing_mbo_mout; dkim=none;
 spf=pass (outgoing_mbo_mout: domain of listout@listout.xyz designates
 2001:67c:2050:b231:465::202 as permitted sender)
 smtp.mailfrom=listout@listout.xyz
From: Brahmajit Das <listout@listout.xyz>
To: amd-gfx@lists.freedesktop.org,
	linux-next@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, boyuan.zhang@amd.com,
 leo.liu@amd.com, davidwu2@amd.com, listout@listout.xyz
Subject: [RFC PATCH] drm/amdgpu: Fix variable internal_reg_offset set but not
 used
Date: Fri,  5 Sep 2025 07:45:50 +0530
Message-ID: <20250905021550.47459-1-listout@listout.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4cJ0M95dSYz9tZg
X-Mailman-Approved-At: Fri, 05 Sep 2025 13:03:56 +0000
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

This patch fixes build error with GCC 16, setting internal_reg_offset in
the marco fixes the build errors. Related to Statement-Exprs in GCC[0].

[0]: https://gcc.gnu.org/onlinedocs/gcc/Statement-Exprs.html

Refer: https://lore.kernel.org/amd-gfx/x4ga2sfkszmylljox3p46ryog2owghv6hffo3rjj4o6xfjy7pd@jllj3us4heso/
Suggested-by: Wu, David <davidwu2@amd.com>
Signed-off-by: Brahmajit Das <listout@listout.xyz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 6d9acd36041d..6630e5f95b7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -129,6 +129,7 @@
 			internal_reg_offset = (0xFFFFF & addr);					\
 												\
 		internal_reg_offset >>= 2;							\
+		internal_reg_offset;								\
 	})
 
 #define RREG32_SOC15_DPG_MODE(inst_idx, offset, mask_en) 					\
@@ -190,6 +191,7 @@
 			internal_reg_offset = (0xFFFFF & addr);					\
 												\
 		internal_reg_offset >>= 2;							\
+		internal_reg_offset;								\
 	})
 
 #define WREG32_SOC24_DPG_MODE(inst_idx, offset, value, mask_en, indirect)		\
-- 
2.51.0

