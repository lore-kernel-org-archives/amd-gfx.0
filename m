Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA987CA1016
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 23:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDBE10E215;
	Mon,  8 Sep 2025 23:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="TzM7cAcs";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3EBB10E2AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 23:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4v85Qhf/VpVJKbDnXR/zywQVjZ9KGXM9Y/B0SKiJ2vI=; b=TzM7cAcsrnwDizG1B4ZZHRbqLq
 E4h8eVrd8d2vlgoOKnhcFw20aK9jhVT9QUN9ZfR8zWkvORUBNaMEgJvDfHAssVsQeO29cM0ZE7ZuT
 9nYEScRJfsHOiM2guc7IpeOgh4Nu9wRQaLcU2Zp3p3UrkSVPY2jA9bTZCzMGkfSlZZ90+y2Tb9KWQ
 S54rDnhUkeHBA+hnP+Wm/RbzwABEneT2nvu69iDV2MNlgYyRWr4eYDI1QOzW/oRUm5rcSCpbSd7wu
 +YTOjIoBcpWv/yBbS9YgA5qmwFQcWyz/TqNiiuYF+4v2dYfhFeodrknRuqxqEbgpDxqwpuRdenb6m
 O3AJ7WzQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uvlBd-008iqD-Hy; Tue, 09 Sep 2025 01:22:13 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 2/5] drm/amdgpu: Remove volatile from RLC files
Date: Mon,  8 Sep 2025 17:15:37 -0600
Message-ID: <20250908232134.2223198-3-siqueira@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250908232134.2223198-1-siqueira@igalia.com>
References: <20250908232134.2223198-1-siqueira@igalia.com>
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

The RLC uses volatile with some pointers that are not directly related
to any of the situations where volatile is advised to be used [1]. For
this reason, this commit removes all the volatile occurrences associated
with RLC.

1. https://docs.kernel.org/process/volatile-considered-harmful.html

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
index db5791e1a7ce..5aa830a02d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.c
@@ -89,7 +89,7 @@ void amdgpu_gfx_rlc_exit_safe_mode(struct amdgpu_device *adev, int xcc_id)
 int amdgpu_gfx_rlc_init_sr(struct amdgpu_device *adev, u32 dws)
 {
 	const u32 *src_ptr;
-	volatile u32 *dst_ptr;
+	u32 *dst_ptr;
 	u32 i;
 	int r;
 
@@ -189,7 +189,7 @@ int amdgpu_gfx_rlc_init_cpt(struct amdgpu_device *adev)
 void amdgpu_gfx_rlc_setup_cp_table(struct amdgpu_device *adev)
 {
 	const __le32 *fw_data;
-	volatile u32 *dst_ptr;
+	u32 *dst_ptr;
 	int me, i, max_me;
 	u32 bo_offset = 0;
 	u32 table_offset, table_size;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
index 0f2647d099b2..2ce310b31942 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
@@ -275,7 +275,7 @@ struct amdgpu_rlc {
 	/* for power gating */
 	struct amdgpu_bo        *save_restore_obj;
 	uint64_t                save_restore_gpu_addr;
-	volatile uint32_t       *sr_ptr;
+	uint32_t		*sr_ptr;
 	const u32               *reg_list;
 	u32                     reg_list_size;
 	/* for clear state */
@@ -287,7 +287,7 @@ struct amdgpu_rlc {
 	/* for cp tables */
 	struct amdgpu_bo        *cp_table_obj;
 	uint64_t                cp_table_gpu_addr;
-	volatile uint32_t       *cp_table_ptr;
+	uint32_t		*cp_table_ptr;
 	u32                     cp_table_size;
 
 	/* safe mode for updating CG/PG state */
-- 
2.50.1

