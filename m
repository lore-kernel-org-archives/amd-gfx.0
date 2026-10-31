Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D238606A31A
	for <amd-gfx@archiver.kernel.org>; Sat, 31 Oct 2026 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lD1iLs8+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210BE10E311;
	Sat, 31 Oct 2026 00:03:00 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012005.outbound.protection.outlook.com [40.107.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DAD8610E311
 for <amd-gfx@lists.freedesktop.org>; Sat, 31 Oct 2026 00:02:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rZ8QB/XF7vjIfLo8o1tV0lgSLz28xYAzUNNhaZxef9nwt/93+/M/bA9jsqPlgc07d8OdVw8tukvlRzSAm6/RGcSM9tVUf/NT0C8FuKhUZj7g++r2ziyWXB3PIVpb1p78johAEuDT2CgIy8Za3G5TITYxxEbISgx0fyTDuNAB3fKIxNwQuw8uzYovlCoQ1TPiko3UBXgWc84nQklvqt0cWgb6NR2R8h+vYhg7BQu1g0l/viQElwCxWDCMSOHgDus55y9InSQaskT1HDvGiFaUUsUTK1oDEoJ0i0kPSDDEIq1TFD8tv9RPoc+6ABgmjn/F6HsBW4G2nWrODw8UUUiQpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7TmcOFyZ4z6V+oSUCRgAS+VPIXbGvoBdQY4ZkfO35I=;
 b=TOTNA014SAw/Bu5evj7bbBCUEtYwPDnucBTkSn0zcOXf5+mFwnsWDOlqYfxFv79Wj5o0NVWZ4PuqMRkhWK7gpIupJJVjbncx2wAfcbUhhpldLy1WIxuQOPTz/3bj9cNKCkBA9Vwhf8keUpr5u+x4TXlIKJmjH9o24/iw/GoMHyrES8AKtpqghXA7/7Sy36r1JBjCEDUxs6wgLAaQVkHCyR8FKjKPlQAbPNO8zL21nEcuwa33IGclDaxI47nG1NY6mS9Ee+WcGFWAAG2sXt27xNX1hoDMOGUS/F/NWoI+4H91PdTCav5Ft2dz7jNTY4hghkK4zkvrSBPCg3RLqtsm+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7TmcOFyZ4z6V+oSUCRgAS+VPIXbGvoBdQY4ZkfO35I=;
 b=lD1iLs8+0AfQm1hjuoIc6+KFkwSCvnkZTPMyrZ63c+EsK4NcNSmJ1wMK93IrBO+C8f6Bzm3QvGewI5jE/qjy1ZdWcu/c8mPNQ3KtcpnIoiLM3ebZJYD1cvvZvuIEoWH6gi+LxCah4a4iP8I+UQg4Er41DJZ4TSeziiUL2QjmBpA=
Received: from SJ0PR13CA0223.namprd13.prod.outlook.com (2603:10b6:a03:2c1::18)
 by BL1PR12MB5994.namprd12.prod.outlook.com (2603:10b6:208:39a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Sat, 31 Oct
 2026 00:02:50 +0000
Received: from SJ1PEPF0000231A.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::84) by SJ0PR13CA0223.outlook.office365.com
 (2603:10b6:a03:2c1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.5 via Frontend Transport; Sat, 31
 Oct 2026 00:02:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231A.mail.protection.outlook.com (10.167.242.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Sat, 31 Oct 2026 00:02:49 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 19:02:48 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 30 Oct 2026 19:02:48 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Prike Liang <prike.liang@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/userq: wait for reset before fence signalling
Date: Fri, 30 Oct 2026 20:02:36 -0400
Message-ID: <20261031000246.106812-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031000246.106812-1-vitaly.prosyak@amd.com>
References: <20261031000246.106812-1-vitaly.prosyak@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231A:EE_|BL1PR12MB5994:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fee28d1-8b49-4810-18ab-08df36e24d10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|23010399003|18002099003|22082099003|261026140227099003|56012099006|11063799006|261022105027099003|10067099003|261022075727099003|261021123027099003|261026121527099003|261021121427099003|261009223027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: jBjCEJ7o60s+Vkn6s1yP+Pyu0qxPzaoHbvcUmRxr7OrE7DQKT9/KaW8rm7PZcyv9AkqFRfCZcQc8DLF0FHZi4AGy2CbQWoXkKzrw4dpr4qXQ41+0zZFsHj56zXCzuOvP5Xk3Gw2AMknMORMsTtIzsOpzgyJ/f4PNQozuDs0LYmezqhpj7EYZxX5Vaqki7WQ4vDVBTtX6Y3QwrG1GofCexdOXU3urOviy6mgHkBdgT10xZIUNL6EwM1gzoHUOopTYrbIJPnyiJ1fCdNyZ6nj/+Z/ks0F0ZUxOJ5j3iabp/Ij6TGWxfUQlh0WMxzfrG7G4rIl8Dvm1ezAR/6zXbvCzSyOVM5IPEi1/LH2omgpSYkVWqz08u3D3yXpj84WHA53yub+6qI9xJJgkVVycxrmrQiZnyeERu42SfySAaSCURvryxD37JusLv1QerGArf7/+R2kMpRZPZIB2BRYf/ZWeBz8IcgDwT7Tkk2G/hydxzi+dDf0iZSwCC9Eufq5YCGm0oDmOVdRGnbZhN4JdxKcTCSSPTiifK3ysDMDBDSc07PwPkDGKDJ6qPSGCNX5Ev6T5IVQNkUqgxB9q+FCRJZuKe/Xm9LP0IVJBMfZutDdTYV9DswH3YubXwKpkkJVCwYZugqJq6qK4Rt/PX9JLeC4d0QsAQlbkddiuIFq8gpcGj6RhBoGm+ATBtRjYZiv9bxAr9lYxEYRyun6uEc0kkEwKKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(23010399003)(18002099003)(22082099003)(261026140227099003)(56012099006)(11063799006)(261022105027099003)(10067099003)(261022075727099003)(261021123027099003)(261026121527099003)(261021121427099003)(261009223027099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: q6YraxQTjqkkmgtHFTZMNY5LqiMOEtNjhX/xbbChEwHKiU4oHZd9+GXaci7OymWZqlF5weHuAxaYXWik/hynfLHCEkVV4nzYenl5UgZadJnOwbG8Mh881VzzNr3ITCVcVTNU5mnGhEbXoTFyb5mh0Y/Jc+lEFCdm9R3FpDD2XyY/UcyxqMpdfM6vKnrCbjUTokwCipfaRWZOfETEA4A4EvrAp8HJQ/h6EWi72qV5/pGtFgOstacYWaAEzMvoh2idvZME5y8yleIjVnXJ1Xz11bLiGLAQWXx/G8/eRtcGaU6lYlcnPFWuVOh4xVDRjakj2eD96UqoRjGfi7l5ZsmbGO+Hh+/SfffLrkOvR4NYlB7LCpDUgQcSNe+TjVL/iDe4hGYF5nWW3UlIJrCW6rjp9+xEyM4Ab9pKXY73HlxFk9T8V3YtPB9HtOBJHLZw/Ee6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 00:02:49.2289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fee28d1-8b49-4810-18ab-08df36e24d10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231A.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5994
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

The eviction-fence worker must wait for reset before unmapping user queues,
but must not wait while inside dma_fence_begin_signalling(). Keep the
blocking reset_domain->sem serialization, and perform eviction and any
required reset-work flush before entering the signalling section. Signal the
eviction fence only after that work completes.

This removes the reset_domain->sem dependency from dma_fence_map while
preserving the eviction fence lifetime and reset serialization.

Changes in v2:
- Drop the v1 trylock and delayed-retry approach.
- Keep eviction blocked until reset completes, as Christian suggested.
- Move reset-work scheduling and flushing out of amdgpu_userq_evict_all().

Fixes: aebf196c550e ("drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues")
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Prike Liang <prike.liang@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 18 ++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      |  7 ++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h      |  2 +-
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index f8652fd0525d..c53ffcb35ddd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -65,21 +65,23 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct dma_fence *ev_fence;
 	bool cookie;
+	int ret;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
 	/* Fence waits are not allowed in a fence signalling critical section. */
 	amdgpu_userq_wait_for_signal(uq_mgr);
 
-	/*
-	 * This is intentionally after taking the userq_mutex since we do
-	 * allocate memory while holding this lock, but only after ensuring that
-	 * the eviction fence is signaled.
-	 */
-	cookie = dma_fence_begin_signalling();
-
 	ev_fence = amdgpu_evf_mgr_get_fence(evf_mgr);
-	amdgpu_userq_evict(uq_mgr);
+	ret = amdgpu_userq_evict(uq_mgr);
+	if (ret) {
+		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
+					     &uq_mgr->reset_work);
+		flush_work(&uq_mgr->reset_work);
+	}
+
+	/* Don't enter the signalling section while waiting for GPU reset. */
+	cookie = dma_fence_begin_signalling();
 
 	/*
 	 * Signaling the eviction fence must be done while holding the
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index ccf0ff490ac2..9a0093bdb3be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1304,9 +1304,6 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret) {
 		drm_file_err(uq_mgr->file,
 			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
-		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
-					     &uq_mgr->reset_work);
-		flush_work(&uq_mgr->reset_work);
 	}
 	return ret;
 }
@@ -1327,10 +1324,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
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
2.55.0

