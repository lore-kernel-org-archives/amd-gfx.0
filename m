Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B2C61DD3
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 20:11:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 609BE10EF16;
	Tue,  1 Sep 2026 20:11:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X21g5w9R";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013015.outbound.protection.outlook.com
 [40.107.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1894810EF16
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 20:11:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KWjVsGARQiagSAtIBkZieWbXakwpKuD1NEmGmk31UhyPwOZ6vPEFdb/puQTB5oeZ7I3frwC8yczyuwK/LmtHuGqRQl6YjgC8J+dLHM8VrUUEDH0v51bG2Su+NZXoxydO+aXW8d+PyL5aPKzkR/7UPDOLDUPcQhskubNQargUPuteYXWR0MRTTwJhsVAaocq/3JlawXLopYguxcYVgB/ir7p5w7DhWP0iRKbJvo9fLefy6Mf9mulSAsLe5Zz6dm5+C3JYN7bc27xUdp4jcQm0HzGcy9BEDRbvBHQu9gQ+MSt3b8EGnPGiWLFOuMe5wRYdrq6vhLAP2FjotK8SZ27s3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHbtdImXLTnInaSdVmWa+i9DUhd6N53xKkBOSoL4J0w=;
 b=TwmqNNAx1iaS42khMeUy2CyMM2XZXXM2vN0pkqOWscXSRjJhSRzyfu5V5Yu2SARQArb5iI4xD/9XkIKY4jo2Rhg49okuQz4pbc6ARLp3iFFpC658VDiV+U0KSbQn5S+aNtcCPh//KJUOtGdDjMSm5HOCjcBjySj50Tt8utnEMCJDdnx5Bs6P27fqLlHVL06b+gE0vn++XMdt/P7kTTZX6wO3Gr2jbTvBxbZzOTX4VYSKYiaE6PK1STiSbEXsMOcXB+D0ELh9vVVsqx1hYXdh1/TeXZJmb1lL9rYBc+B8XYzSlW1C/VidbnhBtyekvaByoLV+w0HyZ5c1xJ28sdkhAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHbtdImXLTnInaSdVmWa+i9DUhd6N53xKkBOSoL4J0w=;
 b=X21g5w9RzzRGqjUDmLQKKJ7KRJ1L5lhIHlSMP8BN2ZOxALTw6SyRKmCuLNx+nPdTdSeeegW3MU6jGE8ZZnIwVxALg901yZBqiXd9283a6sBP7th0J8iFXHtwOaNQQMi+KA0xImFbv9U6OuX4ggT/UkHpJ0QHXgI6A+83VZtglB8=
Received: from CH0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:610:b2::11)
 by BN5PR12MB9485.namprd12.prod.outlook.com (2603:10b6:408:2a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.12; Tue, 1 Sep
 2026 20:11:13 +0000
Received: from BL6PEPF00022572.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::14) by CH0PR13CA0036.outlook.office365.com
 (2603:10b6:610:b2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 20:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00022572.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 20:11:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 15:11:04 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 15:11:03 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 30/31] drm/amdgpu/gmc12: drop MES tlb inv in gmc callbacks
Date: Tue, 1 Sep 2026 16:10:33 -0400
Message-ID: <20260901201034.2960437-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901201034.2960437-1-alexander.deucher@amd.com>
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022572:EE_|BN5PR12MB9485:EE_
X-MS-Office365-Filtering-Correlation-Id: 646ad86b-5d1b-4828-440c-08df08652b31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|56012099006|6133799003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PgszQJMli0R6sEWd6zCjsLkHkR/IFbkHAs7KM+ssVHttCeIdr9aqGp4uK2vXueaJLD90r9xK9urfCRJYe00PoyKA15INVCehEcO81egBRgt0vd4iEOXkJZoujaunapHil1GmCA6LfEk5xSIJOaeoF73YQXNEcqs+PfTYh39UYwhuQlw6wLbZpSC6fZydFv0DEYMk15Oo3KGlkIKtET9IoAO/+2gWd9WfYrq5aZbRhwVNhL4Ok01sZVIBDovKaDMBojg+dir+cRxDyjT+fpD78n14vkYhQsVa3D3rsmh+IANIOOUDsvNDrlUxKVgDLQ96B0k7cotyBLt8zz1L/Gv5c1JZhyJPrDzG/9XQP3GmVu3hDcvuUBEFyucg+kLrvfempV5eu8IJeJkAfiL+lZgAJKXPI6Yzxl7QBIagO/grwFodG0eNbGmB1MLXukhquQObD1sGpXFNdOcgpCetpvFA+T0oEfsQsOeb/KmeXQRNjbULi15Cr7KuUCsBG574VUB+YhpftPzUREJSNllz/IDns/W3ywU1NO/hoGBRxsNL0pRoYF4x+XTm+aYt9A5jsl3a+YOmUpMoaxlk+O8fGbwauhxaarZYKs+jog6CyNc6u5ouOS1EGkkJHpIanYO1Wq/Dmy9YfdDSa/71Kal32SzjYnR6OAzo6qoTo8SJ/ngyV8dJ/C5p/KUYh5qmqgcm8jqL/xc0cfSvjEMYpxZ1mrlelw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(56012099006)(6133799003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ful5dPWeVcypYz/1g4VAlB97PyL5gFLN04Jf9BJshr0hORTjalQhyYAk+XVcMoWnL785e9r4hRjOGYNX3QRN75JeAVST/h+tWBKz4xwNQ1bKeXxtdcA3RMaFjhcb2GvPudqxvyhz5dGnhDJNL14LzZ8Xqs0J9T7XRMkS9cL5vWCVPjboh1yZT2RA16CoJxNOt32aJdChNo4n7if3O95jXYytczlIkKBi8s2ycmFr7kJAWeW6C2TyzUZFl1IYKoylhETG+aY2Uf82PLmA025XmEuGQdEYKBQMm1AuCfmgE0xvpwmjwrp3NrIQDnErsI0u0F9ujq2QNuBiB2+3sq33Hc/BuaYHoJRIx24WPUgyhFt/mXt5ocTXOCj665Igz2/N7f6E23gB0ZfevnG5wLSqoKIli2Jye86OrW2TY9dGeevKIRleN501KMWlNDZz+xaS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 20:11:11.8826 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 646ad86b-5d1b-4828-440c-08df08652b31
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022572.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9485
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

It's now handled directly in the front end functions.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 16 ---------------
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 28 --------------------------
 2 files changed, 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 67eb1b595abe0..4bb8c1e4f335b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -356,22 +356,6 @@ static void gmc_v12_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
-	if (adev->enable_uni_mes && adev->mes.ring[AMDGPU_MES_SCHED_PIPE].sched.ready &&
-	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x84) {
-		struct mes_inv_tlbs_pasid_input input = {0};
-		input.pasid = pasid;
-		input.flush_type = flush_type;
-		input.hub_id = AMDGPU_GFXHUB(0);
-		/* MES will invalidate all gc_hub for the device from master */
-		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-		if (all_hub) {
-			/* Only need to invalidate mm_hub now, gfx12 only support one mmhub */
-			input.hub_id = AMDGPU_MMHUB0(0);
-			adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-		}
-		return;
-	}
-
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index d6be7c092a22d..2c980dc02c262 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -411,34 +411,6 @@ static void gmc_v12_1_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	uint16_t queried;
 	int vmid, i;
 
-	if (adev->enable_uni_mes && adev->mes.ring[0].sched.ready &&
-	    (adev->mes.sched_version & AMDGPU_MES_VERSION_MASK) >= 0x6f) {
-		struct mes_inv_tlbs_pasid_input input = {0};
-		input.xcc_id = inst;
-		input.pasid = pasid;
-		input.flush_type = flush_type;
-
-		/* MES will invalidate hubs for the device(including slave xcc) from master, ignore request from slave */
-		if (!amdgpu_gfx_is_master_xcc(adev, inst))
-			return;
-
-		input.hub_id = AMDGPU_GFXHUB(0);
-		adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-
-		if (all_hub) {
-			/* invalidate mm_hub */
-			if (test_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask)) {
-				input.hub_id = AMDGPU_MMHUB0(0);
-				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-			}
-			if (test_bit(AMDGPU_MMHUB1(0), adev->vmhubs_mask)) {
-				input.hub_id = AMDGPU_MMHUB1(0);
-				adev->mes.funcs->invalidate_tlbs_pasid(&adev->mes, &input);
-			}
-		}
-		return;
-	}
-
 	for (vmid = 1; vmid < 16; vmid++) {
 		bool valid;
 
-- 
2.55.0

