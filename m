Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A122CD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADDDF112DBE;
	Mon,  1 Jun 2026 05:51:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hMqr7/he";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E766C112DBE
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:51:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKilUVuvZkmtQfN6M7oJY+hSmefErPw5EzIlwTJpZ0fuF7w6x20EHmr92UEhg1JEZYnSKP7Pyw1tH0QJKRk4VIPNUQo6Ia3VEJNJFtwXzXxgutPsFJZYmZO5G3hNwHmXUSdo3YBeVI4Zppu4OgNe1EBekuei++u1HNH/lLUiDk79sY95mbrzuVUuLG2UE/03hl/o4wKKjxTKds3eXLrpO/QyQTFo22/XgC3S4BLcjcLT4pWhqSH9EtKYHFFqj1pEXk/DqkbFABy+8xq9v1Bhj5CTgCmkwzhTd6zFzqtwpHGrvVNnkzi7X79gitCVytVk1RZZ1kN4EW2UGkubdzwUWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyJa1gRCVpSkr/kbb7bPITJ1n3AKu3ZpO63EqZlBvnk=;
 b=QuY3oZCJAbDspHXQSrx+z5YkfxLWSMOYXpry6qm32zbknV8VW9J9olMKhxx7jRIkMzhIhGJh8+CYCUh2dMWCmQWWUBu8SS/lJ/Ck1x5Inl6g7pzgZMCIPjNc8bLWHysiuIW8ylUl8xOD3rg/ey4lDeNwrISNYrN8nV9gdR+GonxUA6k+k94hSnV5+LoOHPekB1vogS+E56Z2bU9pqS1Wh5lX5yimGdkEwZT81/so6LfWMLUGloUCJS2Tmoi7+U0uOchSCk/sJKvD3tTNkxF8JGpIW8Af3wMpZGTlxpap/GPYoPlYKUEO9S2c7U0Rd6z/0B2zwj0NJWdUmLy9Cx0CMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyJa1gRCVpSkr/kbb7bPITJ1n3AKu3ZpO63EqZlBvnk=;
 b=hMqr7/heqcsRi/iQ4LfjD0jnPV+cByTWzbSuBhjbpvo8Sn9Tb/jXSDMlpoaVR4Gvp1+2onfJJrYv4Ot+HzwssFo6i5/9/8DFtG10J6drTKB5ZxBc16Iq8pow4RacpnNrZ1N34mLWGEQSLGfxTpe+XSgdIVqtkTIfWnyyUoezwp0=
Received: from DM6PR05CA0057.namprd05.prod.outlook.com (2603:10b6:5:335::26)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.11; Mon, 1 Jun 2026 05:51:22 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:5:335:cafe::31) by DM6PR05CA0057.outlook.office365.com
 (2603:10b6:5:335::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.6 via Frontend Transport; Mon, 1
 Jun 2026 05:51:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:51:22 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:51:21 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:51:15 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 07/42] drm/amdgpu/sdma: handle pipe reset more gracefully
Date: Mon, 1 Jun 2026 13:48:53 +0800
Message-ID: <20260601055034.3700921-7-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d35f65d-5625-4a43-dd09-08debfa1cf81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7zLMN7mU9J8fYY9rrowHoOnWvxHC6m77/XqhWOOLEmgM1zNqXauI6LbcRiUKkt5ugNS8nah8VECmyMN7yojq5204L7cECCKZQ1ivQp78UgezJb10CFZv+E5IAzqM3+2lhZV3ro4Eqmzmx9At9+nqF/CEwIs8KuHXE7Pzv+A6e6ZD//yWsgPqzeIuyvZPNx0HCUWr44MYgmUr5+Ethqj1mkTUTFFaXC99LBlf93uFqeVAMmR19o9vXh+LXYaHFqmLL6nvsNxtLntwqyOdvzYe/mSshLx/cLv17a/AJA1nIRAIXqfK9rnXxz/r6YFA1p/gfZ8tUrpHG7U0iFO0GlDP3w1PyxLf16CYo7rmFRzdQyvQ6Os6lVFOFMFM0a3VmUPpgOIuAnZnLd2+nbeisE0iZUDGbiROzBKT1W8mjGwtmxTSgDTQtpfhgaaPoSUkcqpsdtsJAo20/xmRUj3A9u0BTx6l51cwZAvTWNfOvB6aBu7yHeLLL56d2RrFSEdFg9k8TOGiy38iMnLEBAcHx+5tN9muHHmsXTqvnNpvcA1o+V7H/t5QKOnbNJNEq7f34OgJN5ZKW8mwM/MyUXKv40E9LibXntUJQGWPl4kMW+JejZ7m0gfK6aKSC4elRuqhoEjWgXARsiGGd3ZH2MvWxGnMp5TFF7chy0LNNBqiaMGSEHeRXhdxFmUXqEv7d4Y2biSaimuv1vQTq0r3o+VYv2QEC4JXBhhyeATyXHsYPn8NhR8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Xk/6f2mXM0y2brZFwzaUEsAmCqpAinIJU/IFhrNchriGsLC4AcM4R5vMuXU34sLiy78dwH/crU8RnNzfmZ56egFiOb6b5pgjnAYbpiadSnxtIZo2QIKOeK420xRRiRmuTtkW7oAGodkN09SIlEqUlWMh0vevGFL1/7ydp0iYKiq5Uz0u5Nq92jYZtQhkB9zqj39yk4Qpe61ozw4Rqa1RfF3hXqLhJzhr22a9DNcWRpct1T/u1t4P/L5xBZxH8Jm7Aa4EOiHO23AQJYRCmqJZ4eF6pSYPOiyPf4KKx9CQ6cr1EaVUMTlOh0GfGKe1uv3ALnsy5sGRilMDVPTWH2CwzuXNsXEyNXcVuFv2P0q42OsscwROfgHAVxqQt7K6WHrnaW2ggb/posQQ01horEf9tNAf3MAN+GM0xXSiA2Zx5jskhvgziPA/GEclq2F57FUi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:51:22.4466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d35f65d-5625-4a43-dd09-08debfa1cf81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559
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

From: Alex Deucher <alexander.deucher@amd.com>

Save any unprocessed work in the queues using the
new ring helper.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index fcd81242059e..fbac732f3e01 100644
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
2.49.0

