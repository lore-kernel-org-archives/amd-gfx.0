Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D2FCC6B12
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:25:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81C2610F5ED;
	Tue, 13 Oct 2026 08:25:26 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010000.outbound.protection.outlook.com
 [40.93.198.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DFE10E75F
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:25:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E6tZ1nEQBbUcMJBHa1deYTa2FQJ5taXptqIBC28xtCePbSInM2emcCV7/3htawahYCFXRRIgW8F7iD8XLowGQlpvE8RtB6SYAd1RZhL3v8EaM29njHuNWIK+ZgcNuG2yXQ6fzqxBrt4a0ZYWgg3k7hhpICyoECRc14MQTt9axSU/FJNNRQZotNP+XII0DTZAbbGIHwaNuGTGlBKzHlWt03AksQEEyGowRMu74yGFfejnG2GhIQsgfUt1af1MAwi2kSZh2HK+8OfB2LI0vRXf/cox0OPRJ5d4pNFzubrc12C0OyYKnIihfT9cfObcfWv31VDbU/PoI9oWchHwlR/7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jp0/rS8+FqNIqfYeMLWfK1u0enAngucl2EcqA9/BUmo=;
 b=hd2gOApaHCJFk4AFqmpoLEOMKZadXs82e1Gl+TOi4hoM/vQ30oz9OKs+MzsSkfnVhWeYlZj8omoxgUE74357nA/bH5gFYhIf3vH+RqLa6arq3MmWQ3AVUe99ouH+Ep/BuGev1/Dofhfs2d8oVBsXW7TLJDz3Akx9m9SHWqKpbYUQXSzZyc1OlVC+iaHq/9ceByO3QxC9/nlnFtuIfPWEvIKS1tdogNZdPNHB/OGMoNNFfeEDW6/RN355aZnQxRIjnkR/HCws4x0F9rXAFqa3rp/I7CUHMv09IJEZJhuTByr4YL3rfQRqZyh0l/CUncQTw/JVIhNnD8UVVI9WnXluPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jp0/rS8+FqNIqfYeMLWfK1u0enAngucl2EcqA9/BUmo=;
 b=ocZdEOdhMqhkMeGVsiKI0pU5Eba5IKW7ypKAKsjE2oCdeQHAgcaDe/346IZg/f7OvxRNheZyT/6c/opaHKGFxTVBeQeCZ40nEgQfv3aZ7wzfMqfA5Gewuf0BrBZ9YIpQT/otM85tWpGb/PZS5zZS07XJ0FqQiZNk35Klu1EoKtw=
Received: from DS7PR03CA0229.namprd03.prod.outlook.com (2603:10b6:5:3ba::24)
 by DS7PR12MB8348.namprd12.prod.outlook.com (2603:10b6:8:e5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Tue, 13 Oct
 2026 08:25:12 +0000
Received: from DS1PEPF00053450.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::70) by DS7PR03CA0229.outlook.office365.com
 (2603:10b6:5:3ba::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 08:25:12 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00053450.mail.protection.outlook.com (10.167.23.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 08:25:11 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 03:25:02 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: defer GPU recovery after userq eviction
 failure
Date: Tue, 13 Oct 2026 16:24:49 +0800
Message-ID: <20261013082457.2492273-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00053450:EE_|DS7PR12MB8348:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dfd446-a0c1-4cd3-10e7-08df29038010
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|11063799006|56012099006|10067099003|18002099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Bs/8WavQr4q/ER5ObBeqMccLfib1eHx5uxxCfRPaN7emXPIGky2Ecy8r8rkWWsM84QgGyf+yGC18wxEETIvWgcQwyfDFzJiVQYnZcUZWB9c1Jx1iicoGLm/qO0IlbsYEJKjote1KEbIV7bELnCQBvFaDzH66+uC2vY49gwZjpyRU5R45W76ANUYr64Cv5qb7cdR7JLYuoKrEppsfxLizGChpkzBYAMaytzWnGpOLKiSL7ffDMvs8UvcH8piL/xAMcs9qHxNGomyz2wDqHRkamP6qwLgeieUDgCSZBrWnNB7RSbfm5sUxP2FAPZK2MkUxdKZZE42QhYK8P4XvkYqkL1jBTXI7sXdAUZmekravBIbP2Eg9oy/ycen/8dnCYjAbXJ7B+PZV3+tC0QXPLx2VAO6DgRE3duxGvnO7RfZtlx5OAMyrCeWTdd8n1ecrSH4+/FgCfk5JTz7KKkTsMez9RO6eoX6OAv3xNi2ua6UnX68OFI/+IWg/OXeB4mJHrXoidVerBKzcFOj9X3hFQLpC4as0TvYYMhyaJdxPrFCx3gOsalkw1FkrxFpuaAo0Uoi5gWxEu7jSy/XAlPBnk16f/oRigo80Sbekl52tguDwWuaKlgFNzcV9Iz0zjvI/kLy5N65GGeQA2bPcVASGrLF8mxixZcu9fQf/FxhBr45qX6EtbxwFoAG6iMzJXEKjak1YWjQs2F6rCJnX3Tz9vhujMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bZxsH52foc3yRwl8c625NlW+8Tr8IKybn6y5PdppxMiqAjNcLws/TT68POyyyHBbN2lqjChaMO6BumqV/VPGuFAm28Iuc14sckTkvO2cu6ux3PH0hluSrs+DmCVKWt8IX2xaCg2FphQ6aBqnXwUrTgheoLJzCNt4zW54dJtIq6Bu3s9XW5/uxujOKGub10BqWVcf2IBOK9gl3SFTth9JrMyMpniI5zTNqzWFQoc62NnE/kgg4oIZnAdYYvUukJ0W+1sX31pfPVYLUEIWa2+SM5QAqkfYUHeoX9RFd6vOX9gNUtHGileVTqjewL1aUos1OqjLEq5xyz2TF3L1LIrPz3diFfx4/XL6jvrqgzQehuViK1UqdfhYUCnOtx+9DahdtwT41YS7Jh6Ef5gpkQThwkL/keohtTsSgDhHwcqjUjUQmZL6SL31HBfgcssNLdim
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 08:25:11.9256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dfd446-a0c1-4cd3-10e7-08df29038010
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00053450.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8348
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

On userq eviction failure, the suspend worker waits for reset_work
while holding userq_mutex and inside a DMA-fence signaling section.
This makes eviction-fence completion depend on GPU recovery finishing,
although recovery can itself require memory allocation and eviction.

Fixes: c8ed2de0f2ee ("drm/amdgpu: rework userq reset work handling")
Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 12 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c          | 10 +++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h          |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 082d045edf45..c2d1bc7decba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -65,6 +65,7 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
 	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
 	struct dma_fence *ev_fence;
 	bool cookie;
+	int r;
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
@@ -79,21 +80,26 @@ amdgpu_eviction_fence_suspend_worker(struct work_struct *work)
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
+	if (r)
+		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
+					     &uq_mgr->reset_work);
 }
 
 int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3fe91fdafe55..5fef0cc7703c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1308,13 +1308,9 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 			ret = r;
 	}
 
-	if (ret) {
+	if (ret)
 		drm_file_err(uq_mgr->file,
 			     "Couldn't unmap all the queues, eviction failed ret=%d\n", ret);
-		amdgpu_reset_domain_schedule(uq_mgr->adev->reset_domain,
-					     &uq_mgr->reset_work);
-		flush_work(&uq_mgr->reset_work);
-	}
 	return ret;
 }
 
@@ -1334,10 +1330,10 @@ amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
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

