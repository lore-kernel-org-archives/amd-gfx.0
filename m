Return-Path: <SRS0=j6k1=2N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC37DC2D0C0
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:12 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD6AF206B7
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Dec 2019 15:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD6AF206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C3E56E2D3;
	Mon, 23 Dec 2019 15:26:06 +0000 (UTC)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 359AC89D5B;
 Mon, 23 Dec 2019 13:39:14 +0000 (UTC)
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 93364DCFFFF26E33927F;
 Mon, 23 Dec 2019 21:39:12 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Dec 2019
 21:39:02 +0800
From: zhengbin <zhengbin13@huawei.com>
To: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <David1.Zhou@amd.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
 <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amdgpu: use true,
 false for bool variable in amdgpu_psp.c
Date: Mon, 23 Dec 2019 21:46:21 +0800
Message-ID: <1577108781-68614-6-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577108781-68614-1-git-send-email-zhengbin13@huawei.com>
References: <1577108781-68614-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Mon, 23 Dec 2019 15:26:04 +0000
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
Cc: zhengbin13@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes coccicheck warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:674:2-26: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:794:1-25: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:897:2-36: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:1016:1-35: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:1087:2-34: WARNING: Assignment of 0/1 to bool variable
drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:1177:1-33: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3e293a3..9153b9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -671,7 +671,7 @@ static int psp_ras_load(struct psp_context *psp)
 			psp->fence_buf_mc_addr);

 	if (!ret) {
-		psp->ras.ras_initialized = 1;
+		psp->ras.ras_initialized = true;
 		psp->ras.session_id = cmd->resp.session_id;
 	}

@@ -791,7 +791,7 @@ static int psp_ras_terminate(struct psp_context *psp)
 	if (ret)
 		return ret;

-	psp->ras.ras_initialized = 0;
+	psp->ras.ras_initialized = false;

 	/* free ras shared memory */
 	amdgpu_bo_free_kernel(&psp->ras.ras_shared_bo,
@@ -894,7 +894,7 @@ static int psp_hdcp_load(struct psp_context *psp)
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);

 	if (!ret) {
-		psp->hdcp_context.hdcp_initialized = 1;
+		psp->hdcp_context.hdcp_initialized = true;
 		psp->hdcp_context.session_id = cmd->resp.session_id;
 	}

@@ -1013,7 +1013,7 @@ static int psp_hdcp_terminate(struct psp_context *psp)
 	if (ret)
 		return ret;

-	psp->hdcp_context.hdcp_initialized = 0;
+	psp->hdcp_context.hdcp_initialized = false;

 	/* free hdcp shared memory */
 	amdgpu_bo_free_kernel(&psp->hdcp_context.hdcp_shared_bo,
@@ -1084,7 +1084,7 @@ static int psp_dtm_load(struct psp_context *psp)
 	ret = psp_cmd_submit_buf(psp, NULL, cmd, psp->fence_buf_mc_addr);

 	if (!ret) {
-		psp->dtm_context.dtm_initialized = 1;
+		psp->dtm_context.dtm_initialized = true;
 		psp->dtm_context.session_id = cmd->resp.session_id;
 	}

@@ -1174,7 +1174,7 @@ static int psp_dtm_terminate(struct psp_context *psp)
 	if (ret)
 		return ret;

-	psp->dtm_context.dtm_initialized = 0;
+	psp->dtm_context.dtm_initialized = false;

 	/* free hdcp shared memory */
 	amdgpu_bo_free_kernel(&psp->dtm_context.dtm_shared_bo,
--
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
