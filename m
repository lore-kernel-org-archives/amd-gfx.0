Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F43FC02192
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 06:29:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C76E810EA27;
	Fri,  7 Feb 2025 06:29:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xz8/neLZ";
	dkim-atps=neutral
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B85410EA28
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 06:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux.alibaba.com; s=default;
 t=1738909738; h=From:To:Subject:Date:Message-ID:MIME-Version;
 bh=GP1GMqDlEqibJfwlDq712Wzo9GNWosRF9EXjeP1u3Tg=;
 b=xz8/neLZMm05FgmPz0g9D5/Q4+Pkjkeu67+LHF0cuZZvhZSyokUDLXpzDDFkXmN8Qq+jjpk8kY7jHD1bmUQVm5uKTRV1V449bqtY4QFIFqCorN03/5gu+tlHGUUuk/Nb372Pj2xSFyf63lmc6AY5CXJy5UNPoVl9J5nQEGtmvBs=
Received: from i32d02263.sqa.eu95.tbsite.net(mailfrom:gerry@linux.alibaba.com
 fp:SMTPD_---0WOyT2pu_1738909737 cluster:ay36) by smtp.aliyun-inc.com;
 Fri, 07 Feb 2025 14:28:57 +0800
From: Jiang Liu <gerry@linux.alibaba.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, simona@ffwll.ch, sunil.khatri@amd.com,
 lijo.lazar@amd.com, Hawking.Zhang@amd.com, mario.limonciello@amd.com,
 xiaogang.chen@amd.com, Kent.Russell@amd.com, shuox.liu@linux.alibaba.com,
 amd-gfx@lists.freedesktop.org
Cc: Jiang Liu <gerry@linux.alibaba.com>
Subject: [v1 4/4] drm/amdgpu: simplify invoke of psp_ta_init_shared_buf()
Date: Fri,  7 Feb 2025 14:28:52 +0800
Message-ID: <7b5e51cf56db79071e53a0ae178651fcaeb8d9f6.1738909308.git.gerry@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738909308.git.gerry@linux.alibaba.com>
References: <cover.1738909308.git.gerry@linux.alibaba.com>
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

Enhance psp_ta_init_shared_buf() to check whether the shared buffer has
already been allocated, and return success if it's allocated. So caller
doesn't need to check the initialized flag.

Signed-off-by: Jiang Liu <gerry@linux.alibaba.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 53 ++++++++++---------------
 1 file changed, 22 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 952da6c7943d..407f4a3bb3e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -1232,6 +1232,10 @@ static void psp_prep_ta_load_cmd_buf(struct psp_gfx_cmd_resp *cmd,
 int psp_ta_init_shared_buf(struct psp_context *psp,
 				  struct ta_mem_context *mem_ctx)
 {
+	if (mem_ctx->shared_bo) {
+		return 0;
+	}
+
 	/*
 	 * Allocate 16k memory aligned to 4k from Frame Buffer (local
 	 * physical) for ta to host memory
@@ -1339,11 +1343,9 @@ int psp_xgmi_initialize(struct psp_context *psp, bool set_extended_data, bool lo
 	psp->xgmi_context.context.mem_context.shared_mem_size = PSP_XGMI_SHARED_MEM_SIZE;
 	psp->xgmi_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->xgmi_context.context.mem_context.shared_buf) {
-		ret = psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context);
-		if (ret)
-			return ret;
-	}
+	ret = psp_ta_init_shared_buf(psp, &psp->xgmi_context.context.mem_context);
+	if (ret)
+		return ret;
 
 	/* Load XGMI TA */
 	ret = psp_ta_load(psp, &psp->xgmi_context.context);
@@ -1844,11 +1846,9 @@ int psp_ras_initialize(struct psp_context *psp)
 	psp->ras_context.context.mem_context.shared_mem_size = PSP_RAS_SHARED_MEM_SIZE;
 	psp->ras_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->ras_context.context.mem_context.shared_buf) {
-		ret = psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context);
-		if (ret)
-			return ret;
-	}
+	ret = psp_ta_init_shared_buf(psp, &psp->ras_context.context.mem_context);
+	if (ret)
+		return ret;
 
 	ras_cmd = (struct ta_ras_shared_memory *)psp->ras_context.context.mem_context.shared_buf;
 	memset(ras_cmd, 0, sizeof(struct ta_ras_shared_memory));
@@ -1972,11 +1972,9 @@ static int psp_hdcp_initialize(struct psp_context *psp)
 	psp->hdcp_context.context.mem_context.shared_mem_size = PSP_HDCP_SHARED_MEM_SIZE;
 	psp->hdcp_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->hdcp_context.context.mem_context.shared_buf) {
-		ret = psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_context);
-		if (ret)
-			return ret;
-	}
+	ret = psp_ta_init_shared_buf(psp, &psp->hdcp_context.context.mem_context);
+	if (ret)
+		return ret;
 
 	ret = psp_ta_load(psp, &psp->hdcp_context.context);
 	if (!ret) {
@@ -2046,11 +2044,9 @@ static int psp_dtm_initialize(struct psp_context *psp)
 	psp->dtm_context.context.mem_context.shared_mem_size = PSP_DTM_SHARED_MEM_SIZE;
 	psp->dtm_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->dtm_context.context.mem_context.shared_buf) {
-		ret = psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_context);
-		if (ret)
-			return ret;
-	}
+	ret = psp_ta_init_shared_buf(psp, &psp->dtm_context.context.mem_context);
+	if (ret)
+		return ret;
 
 	ret = psp_ta_load(psp, &psp->dtm_context.context);
 	if (!ret) {
@@ -2117,11 +2113,9 @@ static int psp_rap_initialize(struct psp_context *psp)
 	psp->rap_context.context.mem_context.shared_mem_size = PSP_RAP_SHARED_MEM_SIZE;
 	psp->rap_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->rap_context.context.mem_context.shared_buf) {
-		ret = psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_context);
-		if (ret)
-			return ret;
-	}
+	ret = psp_ta_init_shared_buf(psp, &psp->rap_context.context.mem_context);
+	if (ret)
+		return ret;
 
 	ret = psp_ta_load(psp, &psp->rap_context.context);
 	if (!ret) {
@@ -2220,12 +2214,9 @@ static int psp_securedisplay_initialize(struct psp_context *psp)
 		PSP_SECUREDISPLAY_SHARED_MEM_SIZE;
 	psp->securedisplay_context.context.ta_load_type = GFX_CMD_ID_LOAD_TA;
 
-	if (!psp->securedisplay_context.context.initialized) {
-		ret = psp_ta_init_shared_buf(psp,
-					     &psp->securedisplay_context.context.mem_context);
-		if (ret)
-			return ret;
-	}
+	ret = psp_ta_init_shared_buf(psp, &psp->securedisplay_context.context.mem_context);
+	if (ret)
+		return ret;
 
 	ret = psp_ta_load(psp, &psp->securedisplay_context.context);
 	if (!ret) {
-- 
2.43.5

