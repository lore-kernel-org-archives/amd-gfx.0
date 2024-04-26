Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E3AEC19F4F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 13:49:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D185112413;
	Fri, 26 Apr 2024 13:48:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zYyVRVxU";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88C8311240F
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 13:48:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYwhyUdv+GI/4/mapqfPsuuaolIgL3xTlLH/yZGabct2I10KxYFiHuNa7l9pAcvxMEZpU2gF1DC4X215QbvF614ekQon6UFvZA5ih24rTFqragcalN5QMkpmSzKsSm2XOAvErPa4X31jiUQeLdln+1SJUEixY+xB6Ll1H789dDahDjnU6jrbU9VhGg44Ylk4mp4nBQb5YoP9qg1IMqv6IJUTtM7IFsbhG8JsrAIALZcU4IAC1GR1n84I8pRohuwf1U7/REbJobQsWTlq9a3GXvuhSNErGqo+0XVVZNWQ++TSFG/Zbe5UhdNXCiq8e83mojNU+rcl6Bzj/Kp03a6ELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDYJZvjb81gZr6199cgoWH5dIEkUm4ESdnE6sWajxJA=;
 b=eYTLqMXUKQjiKS/J+FhhPk09Eoy+syF6ucg+QtMTXWuRa4fiAnuN1mbPoKIg63cb3zlKf/Huf1GOecizjajg2TtQJeoCK4dyZcvYAZNeSRwiaTdQGiOJiSjFAGzTW5tMCZS7NCHyGPusVHOE1i0kIVi2B7IMjGxPrCsTxYydNX0v2xS7DOpI4SFLgpI9rk2An3ttx/YTU3CfGZznlNjm5a+zWoeSYxO49AT6dusn/JmgW4vCehMcuM23OHXAARTrHVH02OaBlbcP7TDXDZ657+PWLdgLyvWUCnCez9Ac2agUQC/VlYji/t7HvJ/LxQMylFFwtF252N/DuN9MlHydrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDYJZvjb81gZr6199cgoWH5dIEkUm4ESdnE6sWajxJA=;
 b=zYyVRVxUzVDQXsjnips2hXhUeZcocJQPl0TAJJUmCBQ53h2IG64rAJ974J6Bgm1cgaleiEXO5ARRxmqjFuyFm7kpH5qtkQda42WL6vA4LJrjRiUYAtFdTAKXMSIo9SnCPXA9OhevX3gj5rxUBPW4Y6bKRVjSeqZCmHU8PDG5/0M=
Received: from CH2PR20CA0007.namprd20.prod.outlook.com (2603:10b6:610:58::17)
 by BY5PR12MB4179.namprd12.prod.outlook.com (2603:10b6:a03:211::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Fri, 26 Apr
 2024 13:48:55 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::8e) by CH2PR20CA0007.outlook.office365.com
 (2603:10b6:610:58::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.26 via Frontend
 Transport; Fri, 26 Apr 2024 13:48:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 26 Apr 2024 13:48:54 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Apr
 2024 08:48:53 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <arvind.yadav@amd.com>, Shashank Sharma
 <shashank.sharma@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <Christian.Koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v9 11/14] drm/amdgpu: fix MES GFX mask
Date: Fri, 26 Apr 2024 15:48:07 +0200
Message-ID: <20240426134810.1250-12-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240426134810.1250-1-shashank.sharma@amd.com>
References: <20240426134810.1250-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|BY5PR12MB4179:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4b6b07-5bca-414f-9902-08dc65f79d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|1800799015|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0RLRDVaR1ZONUl5dTJXamJVMzRIdWxZdU1xOW5JQ3l6MkJ2UVVoc08wYTBZ?=
 =?utf-8?B?NTBsaVFGVU9KUHBBQ2xtKzN2SHhuT0NnK1pnd0V2b2I4WEZRdTNzT21lUmkz?=
 =?utf-8?B?N1pQL09HT1V5N1k3c0NFckJIMVVRK1NaTk9PUHdrWm5ZRGh6b29oNEE2Tnp3?=
 =?utf-8?B?dmhGLytoTkt0M0pBcEdYMTZ5RU0vSFVGUkpRQmJVM2Fwbk40aUdPM1hmeXdQ?=
 =?utf-8?B?eHQ0bDBCVWwrN05qZmxya0syblNyR1ZTNVMyUVA1WGxaNGF4Wm5jOFNkZG12?=
 =?utf-8?B?Q1Zha3UzbXF0WlR6eE9iV1NrNVIvSDVwRUloSk5FUVFkT3RzTjQxbWNzMTEz?=
 =?utf-8?B?MjA4am42blZXTUpkSUR5UGtabmd1ODdaWVBOUlFiNWZuMitmMVpMUTNRNGlP?=
 =?utf-8?B?ZzJOOFZGenNGd09CbnZZcHRjS0NIVkt1bzlhMkpyYXVuQ0hQYXRxSHBtZS8y?=
 =?utf-8?B?cFBrbk15UVZHYzNBM29hYk42emlkUlM3ZzR2aER6N1IyRUt0S0krWEJaejNs?=
 =?utf-8?B?dU5ZRDlmdVlSQmFmQ3RXanEramVKVVFqL2hHU3JJdU4zejR3WG9zemhXUXdn?=
 =?utf-8?B?Z1FNbVFJVVFOY2dSeTN2VkUwU08zcCtGNUxPem9jbGVKQ1N5aEhpQStnSitZ?=
 =?utf-8?B?dSsxcXUrMTVsRUhCZ3ZCQklxazFIUy9HNm9FTW00Ykptd1k3eDk2UERGNm9W?=
 =?utf-8?B?MEVxL3B2TmRrTTl3Znh6bVg3ZVFkUWNvVGljSVlkdmM4NVFSR2xHNExienpD?=
 =?utf-8?B?QzhOTU5oU05IY1pxL2VmbFVPVm9acm81Q2trMEg1RVdVQVBIMCs3VUhYSGMw?=
 =?utf-8?B?UDZjb2l1MzFJZURqNFhxdU04Q0ozUkxTMzlrUm5nbFoxWUZZSlJ0Y2UzV0ZG?=
 =?utf-8?B?Um93MlBFT0FVdXNDemk0bXdLanVLSGtMVXVJWDNvR0JRb2hWOHJuM01HN2Z1?=
 =?utf-8?B?U0o3WnpIL1UyWlVza0NremZZUVg0U2krcThvVE9kZ0krQmFxR3daNjB2aExW?=
 =?utf-8?B?ZGU2RDgwSk1SQytRVHBmcitpeS92YTBDcEh2eGlPMEdDOUNJMlN4S3hFeEJr?=
 =?utf-8?B?ME9oV1BRM29rbUJHUjFxSlFLMlVNUmpicTRXT0ozMU9BOEZRVElNWEcrOTNy?=
 =?utf-8?B?cjV0aWpkL3VYcFB3SnlmL0hKdGs1RXhtYUVReSthZWU1VjFsSlAyZmk4TmNI?=
 =?utf-8?B?MFJDcTNUd0hUOTdjZFlSQ3RhOXAreFNPRyszaTJoTE5wNlB1SXF1cnUwY21a?=
 =?utf-8?B?MlZBZDVhenk3eWh6Rm1ZeVAvMTg4Um5tZU5SazVzYXg1Z0NBYW45dVJ6SVhI?=
 =?utf-8?B?WFZZSHd4OE4xYWZUN2VNZXc2ZTZlMDVKc3dXaEoxVXNEYTl4OGhuSjI2RHVr?=
 =?utf-8?B?SVprcXpocXhRek1yS09yR1FzMDU4WDdzTVZMQTFVc1JWYTk2YlVaYkJlT2xi?=
 =?utf-8?B?YXA5YmhhUnQxRDEzMDNjN0RMZ1BhN0E2bkdDNHNmby93VXpVNHdCdkVFa1lS?=
 =?utf-8?B?YUpiajBUQ2x6RlZaZkxYUlpNUlZTbVQrSzY4V0FSYk5vb2RPMkhEZnJ5Mzl1?=
 =?utf-8?B?cVlVaXNLaENYQzdCOE5RSjJrZHNQSGUwWDdiZThiajArQWswVm9tcW8zRW1G?=
 =?utf-8?B?WmtLZkZ5aWlJWkdRRkJRbm8rNUYzUWEzZFIwOGFKTmIxa0dVdEhuTVY2V1Y2?=
 =?utf-8?B?UmNzNlJUSFpzZEFGMGlXYzVmdUR5NXVueGhLV0RSaGFiaGp4NzNVR2w0N2hF?=
 =?utf-8?B?dGkwbkduL1pwZldDcnM3VnN2K1VrVDdKN29QaWZta0JncysyK0tBcG5yVDdM?=
 =?utf-8?B?Lzk1dDZ2TkgrMDNPQ1dXZHhWUUJlUDFyL0ZiOHRKV2RiNmJ6S0NWbTlTLzFN?=
 =?utf-8?Q?81WER9xJ88rFB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 13:48:54.8388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4b6b07-5bca-414f-9902-08dc65f79d42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4179
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

Current MES GFX mask prevents FW to enable oversubscription. This patch
does the following:
- Fixes the mask values and adds a description for the same.
- Removes the central mask setup and makes it IP specific, as it would
  be different when the number of pipes and queues are different.

V9: introduce this patch in the series

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 1 -
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c  | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 9 +++++++--
 4 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index a00cf4756ad0..b405fafc0b71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -151,9 +151,6 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
 		adev->mes.compute_hqd_mask[i] = 0xc;
 	}
 
-	for (i = 0; i < AMDGPU_MES_MAX_GFX_PIPES; i++)
-		adev->mes.gfx_hqd_mask[i] = i ? 0 : 0xfffffffe;
-
 	for (i = 0; i < AMDGPU_MES_MAX_SDMA_PIPES; i++) {
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) <
 		    IP_VERSION(6, 0, 0))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
index 4c8fc3117ef8..598556619337 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -110,7 +110,6 @@ struct amdgpu_mes {
 	uint32_t                        vmid_mask_gfxhub;
 	uint32_t                        vmid_mask_mmhub;
 	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
-	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
 	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
 	uint32_t                        aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
 	uint32_t                        sch_ctx_offs;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index 1e5ad1e08d2a..4d1121d1a1e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -290,8 +290,13 @@ static int mes_v10_1_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	for (i = 0; i < MAX_GFX_PIPES; i++)
-		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
+	/*
+	 * GFX pipe 0 queue 0 is being used by kernel
+	 * Set GFX pipe 0 queue 1 for MES scheduling
+	 * GFX pipe 1 can't be used for MES due to HW limitation.
+	 */
+	mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
+	mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 63f281a9984d..feb7fa2c304c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -387,8 +387,13 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
 		mes_set_hw_res_pkt.compute_hqd_mask[i] =
 			mes->compute_hqd_mask[i];
 
-	for (i = 0; i < MAX_GFX_PIPES; i++)
-		mes_set_hw_res_pkt.gfx_hqd_mask[i] = mes->gfx_hqd_mask[i];
+	/*
+	 * GFX pipe 0 queue 0 is being used by kernel
+	 * Set GFX pipe 0 queue 1 for MES scheduling
+	 * GFX pipe 1 can't be used for MES due to HW limitation.
+	 */
+	mes_set_hw_res_pkt.gfx_hqd_mask[0] = 0x2;
+	mes_set_hw_res_pkt.gfx_hqd_mask[1] = 0;
 
 	for (i = 0; i < MAX_SDMA_PIPES; i++)
 		mes_set_hw_res_pkt.sdma_hqd_mask[i] = mes->sdma_hqd_mask[i];
-- 
2.43.2

