Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E55CA0FFE
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Sep 2025 03:36:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01BD910E561;
	Tue,  2 Sep 2025 03:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kDZ5I9Pf";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6042610E560
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Sep 2025 03:36:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StCDaOfOV+/o/va4dSgE7VBG3sjflpQS+xO3je2lnotWn1Jwb9j8GpK02lFaXkYobwvVpMnb+G37HYmJmAIy7HVu2Fy2HRjR+piExneWWZJ+Ex6Ee79OCrCcpsFEXjWPib6EmVOMAKC1QyA6kfIjMWkBOMsoSdAosktvll0r0iCb4q/nK2ZsQu82LF015MAgPvX6jc03N24M0hD3/NRmDY4kxTeeGmzJzIWLaknVYf8aKGEZldahNunNxTbE07zOrOI+OIrqeIx3jhLrA+8pGnQxLbltg/e7ZTjTjiOdgHx6CsU22oQPlasDxzuZ/CrgIl5whV3mvq959Bo3uQ25rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pPn5YMS7oNbnzySnktduM/Y+F46hAuXBvYWO0Sj4leU=;
 b=dzR39HS0lhARtVmDWhGCdlxM59MAsKIjCbq0Pl2JIbfCFWhrsnsD+Pf4Dv+Cxz9D5GXht3XDmxfGD66UylobZxmTJW2PowjgAIr9dcJLEoL9nmbbSM+5ln8nuHLM8o39uGfDoRLVEeGgDZeESxqjlDyImDh+Pw7cVTDsBmh0KDTuSoDneBj3Hl+aCabPhoR/ysAs123IJJd+Pc6CCfbjQCdk7zvoIfVgDW9GjSU2didHbX6SyojSlVOJIlWdyYNnv59sFw6qxPlvhieINcpQOGl1Bnw1+r2TBvE+4UETRuUuCSn+q2yWejMCvzrm79Cwc8xPCWLsI6U90bqJjkHr4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pPn5YMS7oNbnzySnktduM/Y+F46hAuXBvYWO0Sj4leU=;
 b=kDZ5I9Pfrnas6f4vcALqnib7looxFq+bt2VJ6neg7XjNH2NJQzC/oHgjfnsUBXlMPPpHZJ33Qkb7IPrqpTer9qr1FGxnEcv2OTxW1RAOWN812kxHc3TmiL16Rv4kKAXquXJ+UmCC9GIGwKZnmUVeSMGM440gWHV9YB2V6+aoZgI=
Received: from BL1PR13CA0378.namprd13.prod.outlook.com (2603:10b6:208:2c0::23)
 by LV8PR12MB9714.namprd12.prod.outlook.com (2603:10b6:408:2a0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 03:36:51 +0000
Received: from BL02EPF0001A0FF.namprd03.prod.outlook.com
 (2603:10b6:208:2c0:cafe::be) by BL1PR13CA0378.outlook.office365.com
 (2603:10b6:208:2c0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.14 via Frontend Transport; Tue,
 2 Sep 2025 03:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FF.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Tue, 2 Sep 2025 03:36:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 22:36:50 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Mon, 1 Sep 2025 20:36:48 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v6 6/8] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
Date: Tue, 2 Sep 2025 08:59:36 +0530
Message-ID: <20250902032938.468332-7-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
References: <20250902032938.468332-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FF:EE_|LV8PR12MB9714:EE_
X-MS-Office365-Filtering-Correlation-Id: 62df20a2-c03e-469b-e510-08dde9d1f40b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlpLY0dsdDhKOUJudkMxWnpwc0oyQlV3RVg5cGlwUXdQaDJzdy96ZitPemRq?=
 =?utf-8?B?bVMyU2hsNXlqSlpKVmlnbDNYczNlYWtzeXJDN3FpMHVXaWYyWmpTSDV1YlZz?=
 =?utf-8?B?ckJURDIwblJZMnQwMVVlVStOZzZSaDFVbEgrZmFBZ0ZlS0tUT0I2ZlpxbEc0?=
 =?utf-8?B?RDVJMlVieklKSG5WZWd5R2RiVktBVytrYXdzbElRNU4yb21qNGJscStxdVpG?=
 =?utf-8?B?bms1Wkttc2g2V2JzQ2Jta1FRSTd1YjZoam5tcDd6eHFXbzlJWFlPZFNaWFJw?=
 =?utf-8?B?TnI3WllGQzlYUDJGOGVSdFk0S0dMRmZvNVNNL2pCNlh5SVFuWWxIVVUxaTVj?=
 =?utf-8?B?UTQvQVRvWTRKeXpZSmFIemxxdXhXM21KZkFMUlEvTmRCKzd5amR2VUY2QmNi?=
 =?utf-8?B?UTJXYXJ0UG1UZzFqbzR6SllzRE5iQlB4c0Z5UnlYZENDVm1EaVJ6bFg3Z2l6?=
 =?utf-8?B?VGttNnRVbWgwUVVPUWl2U0Rqbk5Kb1N4S3NRRUtTMk04SDV6Q1NxYzZCVmEz?=
 =?utf-8?B?SThMeXl1UktQNlRyWCtnb2hOdzEwQTE3eDhuNTR0dTd1ZnQrQkhaRXdqUWY3?=
 =?utf-8?B?MkhkVllpWEdLUVNwaDl6dy9xVjVOTGZZblhzMnBhUXdQcHhERUFtVFlJTlFv?=
 =?utf-8?B?VnRsUlgvMEFPanhtQmFpU3l0UGI0RGxTbmIzOEEyM2ExZUtCLzhhNURGL0x2?=
 =?utf-8?B?U0t5K0RIaCtqaGZSSG5rRTVGdkFudjBKckFpMC9GSjBQdmxzTktFUXA5Q3NG?=
 =?utf-8?B?aE9QamVVUDVOcysvK1BTa3VaeUxVMERPSEcvdUFQc1F1R1lxcStrbEl5WHdq?=
 =?utf-8?B?OXg2dUxiV3hZN1k2T0tBV0NIcy9OQWI1RUJnNEc3YWd6YkliNmYyZFhDSnU1?=
 =?utf-8?B?NkJJTW1RZjR2RmJJWE5nSUlsUUdHSmFJTzFlSjVnTUdoeEdVRzhSblk1UW00?=
 =?utf-8?B?SjhTMWNlcGI2L3NiTmVZNDBKMk8wbTlTc295V1J3Q09hYmoxK0hSNzRWOTZM?=
 =?utf-8?B?TlQ5eDZRNEJFV0NRT0krQTMvQTNoQmwya25nOVFOVEhYZll2Vm16ZnoyUnh6?=
 =?utf-8?B?aktvVGZvdUlxVUlMM3ZraGw3QXhPMkRNOXVzMDloWW1SVzNnWVl3bU9SZzVj?=
 =?utf-8?B?ekFxM3VSZEZQTWFnb21TZC9uNEJMZ05MSHUxUVJ0c2FWSHZ1V3BPUGtFbTFp?=
 =?utf-8?B?NlF3eEk1UUxKbVd4N3ZkZjZoWE5zcnlFYnk1cmhpMVhYSDhPZkh5aWtiTjQ0?=
 =?utf-8?B?NmhPenppZVc1S1gwUmFmTmJhMGhUQk9WYnZVUkpKR1RDbUVmdGFRK3FFTHpH?=
 =?utf-8?B?QWV5THd4ZXBsb2Eza1QzNERVOXgrL3FBNUZKUmE1R2ZLZ25ncmpxRFhMSjFk?=
 =?utf-8?B?Yk9FTFU2MDdQNGZxNFJTY1kzcTJ4NVExQ2ZBRnlrSDBsSEp4WE1FWW1GaE0z?=
 =?utf-8?B?d1VDY0RnZWV1Z1RjZXJhalloWWlTSDZOS2lMLytlMG1qdDRXNEk4NFZCQWVH?=
 =?utf-8?B?cm1JTG5xenJCYnBWUVpwM3pHU0hiRjlMWmgrZ2VDS2VJdTdpZTNLbGtXMUVu?=
 =?utf-8?B?bGt1ZEliUXBlYmFSL2VzQnlaV0V4NExFR2h2RW1ZZnhYZ1Y2a1ZqZi9nYk1n?=
 =?utf-8?B?OC91NnRhVDdHSkhkSGZkeGExOTA0blJiVWZRY2FtMXpNQmhWRisvMkxrRm1Z?=
 =?utf-8?B?VUVtdXdLeVNqdk1udjNLNlllaEkwWjdoYnlHQWcxY3dOTk03SWFPR2Jmc2xr?=
 =?utf-8?B?S1FMTjVEQXQwYW1SeWhkak5yQXVhczltSit4MlZZTDFhNlJ2SVFLMnF3aUtY?=
 =?utf-8?B?YWJrL2JVeGpMY215WmJmYU5NenJUQ3ZvZ1NlRHBPT2hXZVY4RjBPQmZyMHZO?=
 =?utf-8?B?c0t1Wlc3YnIxd09xS0ZKVEJSemdOUThNUWlUclA1c3Z1TTdpL1ZNQm9wSWNh?=
 =?utf-8?B?Z1pnVm1ZbGI4cGs4ZjVSQ3pmQWpBUFpnUFNRbVNVV1B3WnNKME1FdDd0TnNR?=
 =?utf-8?B?S21YQ3hQM2pzUllKQ1A0czRQaEZDOXN3RUp6ckpWSmVGOGpDU0VOTVhubW9W?=
 =?utf-8?Q?ODQCC6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 03:36:50.7896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62df20a2-c03e-469b-e510-08dde9d1f40b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9714
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

Add a one-page TTM range manager for AMDGPU_PL_MMIO_REMAP via
amdgpu_ttm_init_on_chip(). This only registers the placement with TTM;
no BO is allocated in this patch.

The singleton 4K remap BO is created and freed in the following patch.

This split follows to separate heap bring-up from BO allocation.

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 42f97d568059..1a68ba17a62d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2021,6 +2021,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Initialize MMIO-remap pool (single page 4K) */
+	r = amdgpu_ttm_init_on_chip(adev, AMDGPU_PL_MMIO_REMAP, 1);
+	if (r) {
+		dev_err(adev->dev, "Failed initializing MMIO-remap heap.\n");
+		return r;
+	}
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
@@ -2083,6 +2090,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
+
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
@@ -2104,6 +2112,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	dev_info(adev->dev, "amdgpu: ttm finalized\n");
-- 
2.34.1

