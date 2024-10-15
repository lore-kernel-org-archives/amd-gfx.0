Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85727CFC273
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 07:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 014CB10E51C;
	Tue, 15 Oct 2024 07:43:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D9Vzc4Mm";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12C410E51F
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 07:43:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqZXPENwSYUtlyhhaApggYmR/L/sGXuwRaTPaaDcSrnh0ATbijTIJjkGuIjnw9ykqVefMqABOqZ4hlGr1eb3uCYQHYjFZHznT/Y8QSUsdVPa/zcg7Zeo3frPj7jsNRRrf/un2+iN4JtkIKE/TdoBiyhrAHqcNZTps24JS6Ph4j8i9L2e6btDAEMUETVW3sv8Okovvry85DSKJjF6KCNeFVS7fkYerWhYAxU1zk3EQt7dZ+yG8NfhVM+SYfSPSPGCiT0ZtAQHk7GEHDu3/tDcvzYM1StvpukjJoNjQy7lppkQSAxhJVfv2HyGWT0AZAkmU0BQCQG0qqK043vhv8dyew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4z5yyNRRujdA655UH3V9xgsy+ne7Uww/6Q540H9x3kI=;
 b=EDtQ2wHkABygZk1uTlvXuews6iLb0mxl+NxPUPRS4we/Xo96LYQUXRjtLvQiqTnJErsOa+0tLasRP9BBVeKW3JO9yIvnN7609rkHhRu4HbBmX4n7wmh5LBZZAz39md+B4gY2zJcTrk5fZkVX2nqLdGrzYZ8157dywS+O2rG7UovvV5mjzhQfoZgbBSr2rFYldt42/6amRD1PnJU48YVLFVqSqt1TV4D6L9Gr2pacirUkIsVoAXFIUI9GFrrj2vkSo5ko74gC7Ku2/YcK9JrLcafxsqWHDqtladJAaaD2z1ZoqSi1zXyM59Cf9XK3Tn1TKwbity49dXkOnUQGRsVVdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4z5yyNRRujdA655UH3V9xgsy+ne7Uww/6Q540H9x3kI=;
 b=D9Vzc4Mmat+9FQ24vCGm7BPoaRgTKnGOPE6xJmHlBjUAWS81v6fWAgpC3kspf/Tx3rzHwGkonvgoobsLhUiRSGLtxBJ4a5H4gPPqhAoRB7E9QKYX2xWpUxX5Yxpkb1UOo086b0pwCrPLTDdmYyBo9g/Bv4/iV7e+rxHtB0PYz8A=
Received: from BN9PR03CA0625.namprd03.prod.outlook.com (2603:10b6:408:106::30)
 by IA1PR12MB7615.namprd12.prod.outlook.com (2603:10b6:208:428::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Tue, 15 Oct
 2024 07:43:36 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::d4) by BN9PR03CA0625.outlook.office365.com
 (2603:10b6:408:106::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 07:43:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 07:43:35 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 02:43:33 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v4 02/09] drm/amdgpu: screen freeze and userq driver crash
Date: Tue, 15 Oct 2024 13:13:02 +0530
Message-ID: <20241015074309.2484264-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241015074309.2484264-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|IA1PR12MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: a8fe98df-4667-46ae-1f64-08dceced137f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eSs3cUExVGJHdlNKdnNoaVNsRTlFVUFOTW9BeGpxMTRkalMzVTlqVTZCNm5L?=
 =?utf-8?B?b0FqaTYzRnRiM3BYWExzcVpoSm1sK1dZQVNDUmZiZ2pNRzR1cTBrM0k1TWxO?=
 =?utf-8?B?VzJiUXhtVkJoUTdINlFNSUNnNlBZNjFpK0hzY3doTXlVbmlSMlhmRGlIRG5P?=
 =?utf-8?B?dDREUWNrMVdRekN5UVhPMktvR2ZRUFRJcjcySXpOSDU3QXdpRzV5c2VrS0li?=
 =?utf-8?B?Y3cweGJBSTdGeis3c2E1dmVTNW9qakNhcWw4bys3cWdEQ01CRDVoMDV2YmtW?=
 =?utf-8?B?dzhMM25vUHh4c3VuR0VBcXROWEcyaklLTXo4VlVYTnowTGxwMDJwZEoxLzht?=
 =?utf-8?B?SUIxbDZEV1FvaDhjdW9TY3E5bHp5b0NvWTkzOFN1bko0bU13d0t6ZlRVRUhr?=
 =?utf-8?B?aVdwODlWbFh2SSsvTFhMOWxMTEd1ODFIME9relRTTG5CTTQ5SHZMYnNGWE13?=
 =?utf-8?B?cnR6VnBiY3ZjbXNhNVY0b0NDWjNVaWlJdlpjajZYWWZvUG9yKzU2NExmR2pG?=
 =?utf-8?B?S0piS0hPMEVXcjVMdkJrOW80Y3FINUdpdENZN2FzdzFXczlnTHZnbjBBWWRh?=
 =?utf-8?B?RGtWcE9YQUp0VS81RTAwSGFIcndIQ05HZDBmYkxNVDBGejdsa21kTUlsalZS?=
 =?utf-8?B?WlFubEY3QUpWRmZFZ1pPNnR0OTYxQlJ2a2lXU0ZEbDM1cE8rSjduWGRsZFps?=
 =?utf-8?B?cDFKbm5FQzV3V2F6MGwrZjhRWGhSQVgvUndwTFhqRG10aW1wSjhGbURtU0Np?=
 =?utf-8?B?cnlqSVEyQWdlNDVaTTdybFBBYVFNR1J1Q21ReTh5S0dJQ0U0YWJVSklJSHd6?=
 =?utf-8?B?a2c0NldiN25mZGpWeDg4MHRLMy9xZVNyV1JuUGVNVkNKOXZxQitmangzakhL?=
 =?utf-8?B?MDRLaVltQldqM0JQcEZsdVhwNGVEYXhWL1dhck8vWkJBN1BUOS92KzUwbG1P?=
 =?utf-8?B?ZklNaFZHZ3ZqOHp4Z0NseUxONDZiaURjWmc4NHpvekJHRW1xUk90RSt4Wm53?=
 =?utf-8?B?TU1pT0lXbGdjWE50UDZJK2JmVHMvMlBTaWlPcDk1S1lDM0tTS3JIa1hWb3Ny?=
 =?utf-8?B?SWJBZ3k2VXlybEFBakFQc21pbFFiS1h0K0FQVGEzZWhNZzhGbG5TVlpaN0ZW?=
 =?utf-8?B?Ym1xUkJ3aUhSZjJvQThhSCtYTmVHUXRlMkh0SFF5YTdLanM5MG03Zkkxc1dv?=
 =?utf-8?B?aDFlUnowWEQxQitRRmRGZnhMRTZYa0NJQllhQkhhOElUWXl0K3lHbUVyVHVS?=
 =?utf-8?B?aUovMm5abVR3c0I4VGtaY05sSmxxcVBKc0l2NDRUYkUrZTR0QTdKTEFZR1gr?=
 =?utf-8?B?OHFHamM1cUhOM2JUTUZ0L2wrcy9lcEcyUWV2SzFhOHgrZEd3L3hJQlNTamlp?=
 =?utf-8?B?ZXN0TFdrTllNY1krT3lXR0xoUHBDMFhJZkxRaUF0NHY3U2U3cU8reWZmV2Za?=
 =?utf-8?B?cFN1dXE5bEYzblhXZ1JMcGVObEVMMUYxTzU2RnBHQXFHclFCSHRtSk9VNGhz?=
 =?utf-8?B?Snp3dy82eTk4bEhiY0Jjc3dKUVlyS2tKNlAzV042bE1kSyt5VnhNanIzemRY?=
 =?utf-8?B?VWc5ekczcm1MWXNZSGxxNlRIM0FEUFdDSy9JVzNsVjAxenJsRVcxeUp2Rzhh?=
 =?utf-8?B?d29sUkhhRXp5K1NWN1Z5V2ZyUzRPaExMMFNJbnM3Zlg5MmdVWHVjL3F1MlU0?=
 =?utf-8?B?d09ZbDQ5b3lNVmRmQ3FBODJUMWNJT05UdWNHM0RPSFRiaWxVQk9CdFFlMEVi?=
 =?utf-8?B?bnR6TUd2SzVLL2dGN3RMUEpEVjlyQjQvMTZhVFRzZFNtK2o4SzdYeEhJL1Nn?=
 =?utf-8?B?aGxRd0R6SEdNQ2FtdEpzWkU1bVpOK2l5d01FQmxoL2ZsZm02STRYMFdMb05I?=
 =?utf-8?Q?J/Bab2/M+4jTO?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 07:43:35.7489 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8fe98df-4667-46ae-1f64-08dceced137f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7615
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

Screen freeze and userq fence driver crash while playing Xonotic

v2: (Christian)
    - There is change that fence might signal in between testing
      and grabbing the lock. Hence we can move the lock above the
      if..else check and use the dma_fence_is_signaled_locked().

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 95f232ad4a3d..8f9d2427d380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -185,6 +185,7 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 	struct amdgpu_userq_fence_driver *fence_drv;
 	struct amdgpu_userq_fence *userq_fence;
 	struct dma_fence *fence;
+	unsigned long flags;
 
 	fence_drv = userq->fence_drv;
 	if (!fence_drv)
@@ -232,14 +233,14 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		userq_fence->fence_drv_array_count = 0;
 	}
 
-	spin_lock(&fence_drv->fence_list_lock);
 	/* Check if hardware has already processed the job */
-	if (!dma_fence_is_signaled(fence))
+	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
+	if (!dma_fence_is_signaled_locked(fence))
 		list_add_tail(&userq_fence->link, &fence_drv->fences);
 	else
 		dma_fence_put(fence);
 
-	spin_unlock(&fence_drv->fence_list_lock);
+	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
 	*f = fence;
 
-- 
2.34.1

