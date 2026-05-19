Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C56CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 18:30:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 920E510ED08;
	Tue, 19 May 2026 18:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P3ddqAUN";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011054.outbound.protection.outlook.com [52.101.62.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E580910ED08
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 18:30:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yw8Z95O8KIhlhKIA2NefFZFlwNc4HIAZGZ6SMzoReTlmucAJe8evzxZULA/JIpuGIzRSEkRHajxGa39UAvEPfBFysmD7p9Q/PXy8flQEgkorL5vwl4cHEI+fWoGxRHWc5X08a+YUhC4upET+Da0ihbykZVm90oe1GrrHbRKerO0mQs66T3pLkGmdKUlrhBEWkK8jHBg0BnAzoM7alO/LANzuFo04VohkYeLwluNwUH3lMGzZTu0FhbrTRnp2gBdgCXeMCpp/+yzpcOnZFVsW0HUMkX9DFNWM2+vtlhz9xXfVaS9QtHC848zxvp7jsYJb+miuVa9nrKH8W5Sj9YLyjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKa0QkzJ0NT+lXwPtRx7Zof7WWCLLUnKviDIBzMkCNE=;
 b=DDwoLAB/LddOrRUWLV4othnu4AOEVMc6b1Zttj9RS5e55JshHYLBHXkW3ihNWwBkDQxyJhT1gdKIfta7kiwJMNV8kqb7N2+YUiwqzETsR4h/xGja1WO2T9HXBL4uuie0D9PoZvm4NGQVTABzBMFD3Mi+Ey4GbA+wLnwyQaBCqMG9eIEuLYZAs2ZM3ccVWmd+WEjlDVgHHUnUNufo2NLjw69hGoHuU8dTs3nVwo/sf3DhYc8cy3ohIBB10UNGLYcKPFVhPvgz7nLdF5IOrvt4mhel5K5eYducq8VOtr+LtNA/lCoIM+O0jybgzfTifz6TiuVvo0wLxU6ItJEVHm+8Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKa0QkzJ0NT+lXwPtRx7Zof7WWCLLUnKviDIBzMkCNE=;
 b=P3ddqAUN7tepgN67U0l8t7Qe8x3Wvll700f1w28qyo8O6NuHrRHI41b5uMmz+F1DKkCzdERbPj4HIpYRyZg3YdVulK4gJc1toqwAtCJXRtOwC8b07y4N5Wt4YGC1I90mghWaiFisVsf2PPqnGKBzsDlWp9X26exyIO73hzfOXd8=
Received: from SA0PR11CA0144.namprd11.prod.outlook.com (2603:10b6:806:131::29)
 by SN7PR12MB7977.namprd12.prod.outlook.com (2603:10b6:806:340::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 18:30:09 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::ca) by SA0PR11CA0144.outlook.office365.com
 (2603:10b6:806:131::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 18:30:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 18:30:09 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 13:30:02 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 19 May
 2026 11:30:01 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 19 May 2026 13:30:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/6] drm/amdgpu/sdma: handle pipe reset more gracefully
Date: Tue, 19 May 2026 14:29:53 -0400
Message-ID: <20260519182953.21967-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519182953.21967-1-alexander.deucher@amd.com>
References: <20260519182953.21967-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|SN7PR12MB7977:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b2d0f5-6b5c-4665-19b2-08deb5d4a847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 47CWN22UKMy1gdFK+YJBnCk+B1WRmy1D3pxotiSa8cWKqfrx0he2HfuAdAcX9ZgOWfV63gLOGYJhJR1fEihxRf8mIwq6Ooq7rsxAN4VBavWBUttNFwecoMIbQOgwYD17tfctc0UmJjomiU/W/rUdAKYjl+zxxkq2VV41n3AMDRMCvLyMLKg2A131zPWY0YzFhUfRqqPRwtKou1SFVFviwEFGhXkZau0uzvbRDSw0PH7mTo5lApQdyIPNLi4G6gjFiUhvCRU+j3ZAfJjGXk5P08hPap8gwL0L8UQuSTMkqOTgrMcbjQDxSCYB7y2pkH8DvCY+C8sF3E2b/WXd5+5xH8V6RfoXH2btenOKP0PBsiKMtgMaJ9e0spPkFtDagXxWW7o9cGXM95eNA0C5MxT+rgjzqqg5AfsMmBECXmRUdkw0tnNVS8eSQ1eU49f2/mT7I61f4gJ7szMH3mhqHVno8tdA3PiJ3pFNJKnYT5rXKgCiegS1IK1KpqkSVl8OrIaMGpnmlZvIMA13LYj8A8zfcRfvulugEaBMmPopgEKGA8vVTHFDzppRPcF9Y/3tPOVoSftw1RElJ+JYk8aLyCwin6B04KkvSw2M2z8unYXfrKgYAkBIulIsEd668nnP1FfD0nKYmqPuOZ6DluwDHYWVjo+pFvNdxH94nCCC6+vXURL+0lukNTS/kT0ZfRHdqmRHu+m7CNebKtJQtWCXSYRka2CE8ySQt//CizbLEKoWxTI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MAUWlHMtDpmiwH+n57d/PKJC+/No+Tt/6hVG0gj13N0XMzGyYYXF2y6ZNsbKPx+CUQAE5MF9u4mL+A6Ta1milDFg3H4Fmk7ShR15kwWfji+beBPf+U45LftWqPvvY5COLGo0DZ4bJVCCwMESe3QY1RNndqnWE7E2ZnQmM+1MB8CYz7laAa2+e2W1zPQj3/4PZN5GFWXbfUO2A1TkZFL+apNln0H/PGSsuTDCjetLZ6uWROIHD9jOesyAHb9Fs9el58TZr+V1V7tNMUUkOZL2Z2WOuyJqlZqWfUlU2FKvjsJq1Wv41a+6IHibMAOaqYaf47O0+F+nZ/9aInAD/Oi1tykl/OPe0cXZnpQPAK9kriYDhhtW2ziWAKn3/sCBQtjU2xkQRNOA7K2/kOipWYSeskOPHnwCcoDCwxMEA9RcKetejzcE6Yk6CQSAYnj1O5B0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 18:30:09.3754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b2d0f5-6b5c-4665-19b2-08deb5d4a847
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7977
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

Save any unprocessed work in the queues using the
new ring helper.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fcd81242059e6..fbac732f3e01a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -553,10 +553,11 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 			     bool caller_handles_kernel_queues)
 {
-	int ret = 0;
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
 	struct amdgpu_ring *page_ring = &sdma_instance->page;
+	struct amdgpu_fence *gfx_fence, *page_fence;
+	int ret = 0;
 
 	if (amdgpu_sriov_vf(adev))
 		return -EOPNOTSUPP;
@@ -569,9 +570,14 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		 * the reset is in progress.
 		 */
 		drm_sched_wqueue_stop(&gfx_ring->sched);
+		gfx_fence = amdgpu_ring_find_guilty_fence(gfx_ring);
+		amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
 
-		if (adev->sdma.has_page_queue)
+		if (adev->sdma.has_page_queue) {
 			drm_sched_wqueue_stop(&page_ring->sched);
+			page_fence = amdgpu_ring_find_guilty_fence(page_ring);
+			amdgpu_ring_reset_helper_begin(page_ring, page_fence);
+		}
 	}
 
 	if (sdma_instance->funcs->stop_kernel_queue) {
@@ -600,14 +606,19 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 		 * to be submitted to the queues after the reset is complete.
 		 */
 		if (!ret) {
-			amdgpu_fence_driver_force_completion(gfx_ring, NULL);
+			ret = amdgpu_ring_reset_helper_end(gfx_ring, gfx_fence);
+			if (ret)
+				goto unlock;
 			drm_sched_wqueue_start(&gfx_ring->sched);
 			if (adev->sdma.has_page_queue) {
-				amdgpu_fence_driver_force_completion(page_ring, NULL);
+				ret = amdgpu_ring_reset_helper_end(page_ring, page_fence);
+				if (ret)
+					goto unlock;
 				drm_sched_wqueue_start(&page_ring->sched);
 			}
 		}
 	}
+unlock:
 	mutex_unlock(&sdma_instance->engine_reset_mutex);
 
 	return ret;
-- 
2.54.0

