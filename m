Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F92ECE589
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Sep 2024 20:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5070210E69A;
	Mon,  9 Sep 2024 20:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KBethYcl";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2086.outbound.protection.outlook.com [40.107.94.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6628A10E697
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Sep 2024 20:07:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yX7hz44A0oi4e70vXdCAzfrFGeggb/vc6b0Yrq8wE/dILAgVvX6UNHLD6A0mahWVSQ1JHDF8Kz6y+fGV3MfU3XN0m71mPzQPbYtuLSiRpxdVsdQi3kg7853DcPnaZ5yGufSrMdqjwbVfUm3ruc3/MHMMeGUUUvu2LzPDeyP2UuN1/xtuI4myHny3zh/kvijdJrlrT9TGm4KjA7sH1BFEZFIj4IFlzfcHHYFaeoCH0xW1BqMOuiammQbzpI9eKVd1HXNgDLSUC2MN+yEkXNtgzbvnprNcW+YdoR9l0M0sRh+UH4dKL/ZuvQ18TBhOZpr3A3vUcjhjVMg9HiEGBFXrsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QqJAnrFBiYhRHv08IxdGnevTP+/W9384gDqXMR1nPE=;
 b=YTlXI1tBZJQ+u0bTuRj25sgBdMDGa/zq6g//mAT2oZYavzobCgWA36hxFthlitvVsyRIRF6aHn6kkhhPRW3/QXapTJkaqss4Skd8lvvZZr7kiBoZG66Svk28Uj2LU60BYNei8tacI+izc4tBMB7s/htgKvHwAR0p3HosvBctzp1nJ2iK7hf3Mp75s6mCCo8L6HtYiaX1CjWLVu9SHQN5Okyd6EBiWR3+O0cuK0YGazPH7WWlkmSsx+SdfpBVKVTb+YBV87me7gDetJk3YA6/OsaKeC3g6cdPy5xOff50zKf1v+6dQRnxJEBar9hTDTxg9ECGHmUaz6xgvC9i2Odz4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QqJAnrFBiYhRHv08IxdGnevTP+/W9384gDqXMR1nPE=;
 b=KBethYcl5QIQYtBzGXW9Z3NxB1oJMyzboInPOI61q9liLfER/BLgfpwESioSXjQ37LmAeZQmi+zRz74OZ4BCORq64vu9ZJ8ffEkqUiPssCdZ3+BdcWic0RsWDoTAMQX5e2oYM7K/yBP01q9Hdwlc2M8WXKfzQy1ckG4RUV0DKDg=
Received: from MW4PR03CA0306.namprd03.prod.outlook.com (2603:10b6:303:dd::11)
 by SA0PR12MB4462.namprd12.prod.outlook.com (2603:10b6:806:95::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Mon, 9 Sep
 2024 20:07:28 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:dd:cafe::bb) by MW4PR03CA0306.outlook.office365.com
 (2603:10b6:303:dd::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 20:07:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7982.0 via Frontend Transport; Mon, 9 Sep 2024 20:07:27 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Sep
 2024 15:07:25 -0500
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Arvind Yadav <Arvind.Yadav@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <Christian.Koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>, Arvind Yadav
 <arvind.yadav@amd.com>
Subject: [PATCH v11 26/28] drm/amdgpu: fix MES GFX mask
Date: Mon, 9 Sep 2024 22:06:12 +0200
Message-ID: <20240909200614.481-22-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20240909200614.481-1-shashank.sharma@amd.com>
References: <20240909200614.481-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SA0PR12MB4462:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ac085d7-b9d1-4e17-61cf-08dcd10b078b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aTd0aDJXVHFSalppSkN0T3V3Mkd0bE13SmJ6UUxsUUxFN0hsSlpmMzVyQkpi?=
 =?utf-8?B?cHE5VU5ncndjRXYzQnpBVW1FdW9ORzJ4b3ZmMmVHR3hua3Rhb3hCV0lqTXF4?=
 =?utf-8?B?Nk9iN0VYTzB2SW91ZXdnWlFzb0RmRjAzKzdYY0lrOEgyR0dkRzZnR00ycFpi?=
 =?utf-8?B?cUd4YlVoOGExM1dBcmNaNVRGa0xGWkJVMFIrSEtOOXFmeTB1YzBZeVgvZTZ4?=
 =?utf-8?B?aGJCeExDNW1tSjlKOGZQVk9rd0VQNXF1d3Y1cm9uc1JaaXhJMXh3U1pkeTFO?=
 =?utf-8?B?d3poSXVaRXNMR3JPNW1XTC81bzFMNHNYTk5jLzEvZnVWWDNUa1pvR0VSSU9o?=
 =?utf-8?B?TW9jU2RZem9mMDQwaUxkUGtCL3VhZmc0UDVZbGNVdkpWYXgxelZsMTE1dkxv?=
 =?utf-8?B?SFlJZnVUUjlVY1J0SjgydHBkZ0lrNUdHSGNIaElYeW9hS1pzMlBoNVIxRG9X?=
 =?utf-8?B?U2Zob1o1V3VmVUNjWW5lVzJJR29zVTk1a1JEWEI4WE54eVVVSHlSaDJSRXhY?=
 =?utf-8?B?UlViZU84dG9TN1VWakZEcENLVGVJNCt6eHRIN0trY1diSnVUVGdVVmVKNHZt?=
 =?utf-8?B?QnlreUhwZDNLNEJCd1RnRER4ci9tMkxTWnVNZDJIWGY4MzlDUzdhUC9TVDdO?=
 =?utf-8?B?eEp5SE5uNUR0ay9GbVpmdWZyQzNNVTNCTDNoOG0zOVhyQkk1YWFxZU9Ed2VV?=
 =?utf-8?B?TXNJc3NHR3lIRkJBRXhyMUdXTGVlTTJGcUhKWXFzNlFLUzgyMXdnWW5tb3JL?=
 =?utf-8?B?OUFQZXhnNDhrV1pQK0xQL1l4aHc5eVBQLzRTbHJjZUJPT0UrU3R5OG53SERV?=
 =?utf-8?B?ckZsZUtwb3VRTHJKc095N3diekV4K2p0UkVoN05xeGN6eVczcVJFY3JWVVYy?=
 =?utf-8?B?KzBzUEpmZXBLempQWUd6bklPaTAwUnp4WS94bk9UL3NCL1hSSVYvMEdGbkRo?=
 =?utf-8?B?QjhiM1ROa2oybE4yNXVtbWJEd0h0Y3Q3SUZUZ3g4eDVxTXFWclcxNjM5aStN?=
 =?utf-8?B?dTFJakpHbTkvc0pLdkpLbHFITTg4aXA0eUtXeTFGRjFRSENDUnFUVU50NUhG?=
 =?utf-8?B?MlA4TGEvQ2o2UmtocE03dUorblF4Yy9WdmY5RHRNblRSK3N1SjBRMzF6WkRU?=
 =?utf-8?B?bDBPdjM0ekRaVHoycU51bUREUk52ZGczSXg4aStzVnJuRXMyNjFsQTlWdXZP?=
 =?utf-8?B?MDVpdnRFd0tISVc3alhxWHAyTkk5cVlLUUt6VjFETmUxdHZLMlVwUGpIUk9s?=
 =?utf-8?B?U0lmMzRsVG1IM0IzRUpiRXBMY3pYblFRa1pDL2dQS2twT1VRWG9hVFZPaitu?=
 =?utf-8?B?bDVxQUtLc3hvc0FQbEpRRXVjSUZaUGhzcDhONUcrcXQ4UnlrajEyWHg1Z2pK?=
 =?utf-8?B?TFNvVmZMTlZXenBKZEMvWFNwS3BlOGVJczNZTThVK1J2NjFPQnY3TG1tMmpM?=
 =?utf-8?B?Vnk5M1F2dksrclpENFhiU2hXbWwxenRxRFJoaXVFdVgyWFhYd2c4aWlrZ2U5?=
 =?utf-8?B?TlNFVTRqSXNUSXgvODc0dldaTGZvc1lya3VBN0ZvVkxuOEd0YlFqSHc4Vnhz?=
 =?utf-8?B?UG42K2hzRDlxSXFBa2V2MWxyZThINTBkYXViZkIySXk1TXlwanIyL1lTWXR3?=
 =?utf-8?B?dkYxRjAxNlFpZkRWaHRnV1FHRlBNV1NxWTZwNlEvZHBBd1FEL3lldktqakFD?=
 =?utf-8?B?dXNUOFZ3eldVZ3lVdzRKM2IxL1l3MVZ0M3dkSVZDSXFKWUlNV1k4SHgyRjVm?=
 =?utf-8?B?K0JGNEc5ODVFTmVNY3g1TGJuNzNqK0ppSFdjVVhXci9OekNmNjA5ZUlzZTBu?=
 =?utf-8?B?dFZ2T2lQQVpKaWNLVldXV1c5L0FON2R1a3Y4ZUxSQTJtV0d6TVBBTFlNSzJi?=
 =?utf-8?B?Q0VVbGVySVhlblJNYjRzSFd4bkZOemRyMU1MVjlCR2JVMkpHNk5CRDJZOTRR?=
 =?utf-8?Q?TDVtuDyQbIFi3k2wSToRpLiC8SjXkH34?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 20:07:27.9625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac085d7-b9d1-4e17-61cf-08dcd10b078b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4462
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

From: Arvind Yadav <Arvind.Yadav@amd.com>

Current MES GFX mask prevents FW to enable oversubscription. This patch
does the following:
- Fixes the mask values and adds a description for the same
- Removes the central mask setup and makes it IP specific, as it would
  be different when the number of pipes and queues are different.

Cc: Christian König <Christian.Koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
Change-Id: I86f5b89c5527c23df94edc707c69c78819f4c8cf
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 3 ---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 9 +++++++--
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index f7d5d4f08a53..dbf19122dfc3 100644
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
index 96788c0f42f1..45e3508f0f8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
@@ -109,8 +109,8 @@ struct amdgpu_mes {
 
 	uint32_t                        vmid_mask_gfxhub;
 	uint32_t                        vmid_mask_mmhub;
-	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
 	uint32_t                        gfx_hqd_mask[AMDGPU_MES_MAX_GFX_PIPES];
+	uint32_t                        compute_hqd_mask[AMDGPU_MES_MAX_COMPUTE_PIPES];
 	uint32_t                        sdma_hqd_mask[AMDGPU_MES_MAX_SDMA_PIPES];
 	uint32_t                        aggregated_doorbells[AMDGPU_MES_PRIORITY_NUM_LEVELS];
 	uint32_t                        sch_ctx_offs[AMDGPU_MAX_MES_PIPES];
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
index 2911c45cfbe0..d2610a664b2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -653,8 +653,13 @@ static int mes_v11_0_set_hw_resources(struct amdgpu_mes *mes)
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
2.45.1

