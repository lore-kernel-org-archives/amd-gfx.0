Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9CEC9832A
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 03:47:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40A7F10EC88;
	Tue, 29 Sep 2026 03:47:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kJK0k7gA";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E609C10EC88
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 03:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IcK0pxjVUHA3/dpTwHRIeRX4I/o0ASE+nklUupZAW3Tx0Yn3f5dXltvcpU3rhUVaAfNwIN6ukN0f+q0Y5ARnxroA1xcOcWrlCXjpJEY1m0AvDUfBkenYplzcksfjDFKKAHMErEJZ3A+hQyZft9Qx1S8QSOAEHJ1XM8A9JRGpwdf4zjkWFlPJqE6M6BPpvz1QOQ1PAVwv0qDnROZJYl0Ljroaa+oi4d3FnzaCziKEY54ESykhsUi5s6ZAEmd7X9m58jUptmNr6N1F3NSK7hXlD+DkHnn3MV9GyNKWb9H4CkJDRlfW4WitPj+txOLgQ3lHe3Ny3Tl/jK45dscHvH59hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NHbcyphq+5sPmVc4ukTCakS/qWtHEbD+Wf1Nikv7yJo=;
 b=mdM0XMOK+ClgK4JIU39Tp7efz+AFAo5HpUI3p9eBqkzednFDHwwjhzK1essViYdep+i5oHwd5YOnaDCavT2NVuaoYiF+AbZR5F/HvEgR/BZh9LP8RsHCx25AQ52YTcfw0UaFJ1DgFed1uv0omj/8r/pIssK4vsufXgYG6OpTrEBT9jekM+OIZkp8bH83pZbVjlE3dWTgBFuaUMOWb2OBFLN7gpHGjf95T9+6xEzXV73+FHLXn++A5WGdEMB2FMbQCVWYxk+k36OEmMScHPIVE0XQoPtvPWE6cTNMEvV9o5qUQH5KJTgQ0V86dVvkGMPTk48qisSpvS+LJRBD8xWohg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NHbcyphq+5sPmVc4ukTCakS/qWtHEbD+Wf1Nikv7yJo=;
 b=kJK0k7gA79oOAXUuQQPLErHXIs1okbxzF2cCVqjnOZ+zHDtho/w2E/Ty5Ozo+nMKzabW2dR0xyLO69iSzRwNPJMDEZKn1ukrbX7yvpTSxFVg/jFwWKjQ3j/vsCKK6KrP4ANFIEsJmGIHFe20lNJTteRinKH2mOuAhuhjAK7cmY8=
Received: from BN9PR03CA0073.namprd03.prod.outlook.com (2603:10b6:408:fc::18)
 by DM6PR12MB4337.namprd12.prod.outlook.com (2603:10b6:5:2a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 03:47:01 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::32) by BN9PR03CA0073.outlook.office365.com
 (2603:10b6:408:fc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Tue,
 29 Sep 2026 03:47:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 03:47:01 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 22:46:58 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH v2 01/14] drm/amdgpu: defer userq reset after eviction failure
Date: Tue, 29 Sep 2026 11:46:37 +0800
Message-ID: <20260929034650.2393125-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|DM6PR12MB4337:EE_
X-MS-Office365-Filtering-Correlation-Id: 303b7cdd-dee3-433f-5c57-08df1ddc51c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|56012099006|10067099003|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: 2eSGMpTJ5UxNyLBD13/zKtpoqQAXOVVqxqUlKuWZSAKvfw9wdkSPbF95nJY6jaFkIIunqjk6aQfqVOKuBz30pGM0aEbBaf/DXCA22TmWZjFPUNHsUY1xQ3oDAM1Xc2ZBVsTottSGbbe++cIk9Nu4PlKVawrX1iFtjQE27Qp+2ikdKr+bfyYAllH/5ASztUxUTfvJQXiSythIZ0TLgBbo3ZM0HRddhy55PPvEfXup+2OIzDaBwVCXLfJFJlZAsrBrIYCrE3wBq+A7mcCGE933Ogg2jxcuw0S/Qqr7Ah4yt2NMd7/MVD5rRg7v0p4yOCNcu4qTSVLI8zEf2MfmLx3Nh+/O8b1hkAzx3+XFSjK9FMaA7Eqwdq7ZlOCXXnPhny7hDIJcTEcz5ShunAhp2MzjGnmT5JFM1dLA3F4n3ReYK7FWWLiH2Vh4Q03kv5oyhP3iBfkjAPRrH0mUp+DXwIZA4lUk0eXBKkh4EIaKofHTuL5hQuCIWqqJVE4DaujMAFcIGvh+2exdpgbHbd2XfZNRlpMqUj4lKjID536by3yIex8FvYgbPeWtyPTIbjiLKUIWOZo6/m12NiABxYZBi2t+go/yrCySicEAjyqwTqdiW+lbagDgPDV63o2zQY4xTwZjN/dnFuCNDkQdmwIpiG56S1ACxY6K63LDB3p1IJi1QMbDLfVkw1zvNF9xTNYrny7zPtF46xsX7BYzmhS3JGMQUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CoTEnaZFAdbrheIRSpJrR6twrJBi7vJT6Jvh9zOn4aN4ODDwZg7x31U1l1tqPQNzEtCGi1opEebYS/owFuxEtqveHGQxesghFCSYSB3cG/K/vrMiUEmNB/N0UhehUTSXSRIvPrIhJ8Q8wb2TpErhJv15NaV1fJzkoUMWHUbvYAgSGcS7WjxbZRqDLJ6vglt+m0CErM3y83upwBpD7PsT+8pPv77sUzwE0Oc7quXD5soand1+2rTIVKPZfCWAWd+XpMrXPppEW3ryWQH84I4Fkq1T7EDhfGRHPHZrqTTfMs/fKa6Euj+E/dAyRxOUgm+bJlrOhNv9DDvbIhIzNVHaZYeHeQh9XqiiP7sNh1X5IaLA2FohE/ni1B9pJYRQ0C0/1ZAQinQ+H6GVs2vSavkQETO9IHFFLnuELWz2ORqh9QcORBsHhDLs2vZ4Xb+X2t5s
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 03:47:01.1159 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 303b7cdd-dee3-433f-5c57-08df1ddc51c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4337
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

Eviction recovery must not run while the suspend worker holds userq_mutex
or is in a DMA-fence signalling critical section. Queue the reset after
dropping both, and retry a requested eviction after successful recovery.
Meanwhile, retry and force signal the pending signal eviction fence to
avoid the dead userq attached the reservation fences forever.

Fixes: c8ed2de0f2ee ("drm/amdgpu: rework userq reset work handling")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_eviction_fence.c    | 14 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 22 ++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  2 +-
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index a0802012de49..15897c3eacb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -65,6 +65,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct dma_fence *ev_fence;
 	bool cookie;
+	int r;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
@@ -79,21 +80,28 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	cookie = dma_fence_begin_signalling();
 
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
-	amdgpu_userq_evict(uq_mgr);
+	r = amdgpu_userq_evict(uq_mgr);
 
 	/*
 	 * Signaling the eviction fence must be done while holding the
 	 * userq_mutex. Otherwise we won't resume the queues before issuing the
 	 * next fence.
 	 */
-	dma_fence_signal(ev_fence);
+	if (!r)
+		dma_fence_signal(ev_fence);
 	dma_fence_end_signalling(cookie);
 	dma_fence_put(ev_fence);
 
-	if (!evf_mgr->shutdown)
+	if (!r && !evf_mgr->shutdown)
 		schedule_delayed_work(&uq_mgr->resume_work, 0);
 
 	mutex_unlock(&uq_mgr->userq_mutex);
+
+	if (r) {
+		/* Failed removal does not establish that DMA has stopped. */
+		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
+					     &uq_mgr->reset_work);
+	}
 }
 
 int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 75d5ceaa53c6..fa8ffa060fa5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -91,6 +91,8 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 			     reset_work);
 	struct amdgpu_device *adev = uq_mgr->adev;
 	struct amdgpu_reset_context reset_context;
+	struct amdgpu_fpriv *fpriv = uq_mgr->file->driver_priv;
+	struct dma_fence *ev_fence;
 
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "userq reset disabled by debug mask\n");
@@ -112,7 +114,15 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
 	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
 
-	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+	if (amdgpu_device_gpu_recover(adev, NULL, &reset_context))
+		return;
+
+	/* Retry a pending eviction only after successful recovery. */
+	ev_fence = amdgpu_evf_mgr_get_fence(&fpriv->evf_mgr);
+	if (test_bit(DMA_FENCE_FLAG_ENABLE_SIGNAL_BIT, &ev_fence->flags) &&
+	    !dma_fence_is_signaled(ev_fence))
+		schedule_work(&fpriv->evf_mgr.suspend_work);
+	dma_fence_put(ev_fence);
 }
 
 static void amdgpu_userq_hang_detect_work(struct work_struct *work)
@@ -368,8 +378,7 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 
 		r = userq_funcs->unmap(queue);
 		if (r) {
-			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_HUNG);
-			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			/* Keep removal retryable until hardware quiescence is known. */
 			return r;
 		} else {
 			trace_amdgpu_userq_state_changed(queue, AMDGPU_USERQ_STATE_UNMAPPED);
@@ -1287,9 +1296,6 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret) {
 		drm_file_err(uq_mgr->file,
 			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
-		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
-					     &uq_mgr->reset_work);
-		flush_work(&uq_mgr->reset_work);
 	}
 	return ret;
 }
@@ -1310,10 +1316,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 	}
 }
 
-void
+int
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr)
 {
-	amdgpu_userq_evict_all(uq_mgr);
+	return amdgpu_userq_evict_all(uq_mgr);
 }
 
 int amdgpu_userq_mgr_init(struct amdgpu_userq_mgr *userq_mgr, struct drm_file *file_priv,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 488dc21d7c81..4dcf6151de6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -163,7 +163,7 @@ void amdgpu_userq_mgr_cancel_resume(struct amdgpu_userq_mgr *userq_mgr);
 void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr);
 
 void amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr);
-void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
+int amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
 
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
-- 
2.34.1

