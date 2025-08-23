Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78574CA0EE4
	for <amd-gfx@archiver.kernel.org>; Sat, 23 Aug 2025 07:20:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FC610E1C7;
	Sat, 23 Aug 2025 07:20:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SryMHDDn";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A344B10E1BD
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Aug 2025 07:20:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZWNvoAa5xgEAGgzJBJOvi+l8aUAvwqbfeRAlx93i26wKuoO0L+l/iW32IXsb+3uIsTLk1+6moZveY7qE6qPUx0KNFsYZjIQfQ0jmrczgUrd7wAnVRGLe8gsKAWq/ifgE/jqSQRtxMWTJYLyxH67AtkLAyi9wICeqXvuViwHbSA1t9Qj0TLeLHyM1Vv/HRQLU+h2GqODCkmwjOZlbTVbPXb5j6mLz70wO5bnXprn49pM5nNChpsLg4qjqUbAA5ykAFMCAvRpKSqtEQPA4udOuGH8RHn2bgZa//Wmo2YBzxArWCs2wEvxTygIKLU2BMYiNkbnL1bjz2fiaXnqPjLv/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeUUZKOtJrw8MkbVAfdzMg3OxZNGcRsoJG0hAOO5Mtk=;
 b=WQBnDecJ9QBGd0+s7t3yW8Quo7AzAPttu6ZoTh5AeTX/8hOw0pPuaU8GTo6Y6Oel1pb/tfELG3AYfcjcjALnRH4ZpvpEvUc2WtfkQxZaWB1tJCdrbZkqx5zRd44vEpDVYtV42fNrYDu2gYlFbkPY9EZCedY9cutZJUSGme9TfkXj+Lz3GPU1hOD5U8peRmRuDn1l47Il8WFiNPNVfdC7mQJjBbVyRCsGyXXXHgUNrMyARuB4OrmGHtoafHk5Cv5VZSo0yOHw2wKOhW15BVEUcg/T4eDoSbosd9TrTsjcqtdm5EJHz5ngMvFlCS0+eWmGG9j9l6tUbHzOTJ5IRVzyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeUUZKOtJrw8MkbVAfdzMg3OxZNGcRsoJG0hAOO5Mtk=;
 b=SryMHDDnjFgJ51bDoZzn/8THE+kuPCC06E8l808iAupthYno0XKMmTZxHcuehHpVs2BrYRNkhwOPYiaN/zeZr/TVAncqM2u2ZD6tsMTp/7tVPmlLYu0WTeZZV29HY+G6dw+u5PXwM8RWIDJDsNk/rApAhJYKeNpR9eWDtL/vJBU=
Received: from SA1PR04CA0012.namprd04.prod.outlook.com (2603:10b6:806:2ce::15)
 by DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.19; Sat, 23 Aug
 2025 07:20:46 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:2ce:cafe::eb) by SA1PR04CA0012.outlook.office365.com
 (2603:10b6:806:2ce::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Sat,
 23 Aug 2025 07:20:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Sat, 23 Aug 2025 07:20:46 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 23 Aug 2025 02:20:44 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [RFC PATCH v2 7/8] drm/amdgpu/ttm: Allocate/Free 4K MMIO_REMAP
 Singleton BO
Date: Sat, 23 Aug 2025 12:50:15 +0530
Message-ID: <20250823072016.1272328-8-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
References: <20250820113254.3864753-1-srinivasan.shanmugam@amd.com>
 <20250823072016.1272328-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e78796-6efb-470c-beab-08dde215943f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MFJHYTAvZ2I3eDRIMTNNd0Q0dXA0VkJSV2p1UXZRZHpiV3RlRElZY1ZkSDk4?=
 =?utf-8?B?Y0pldklrMEVlNmNnK0NLY0doWlRab0xPekFEZ1VqVHl3RHovMnlGWHRqb0RP?=
 =?utf-8?B?K0VhNEJrUVZQTjdEVUkyUFkvMitzb0xGSXp1a01jcHdjRDlTTVhKYTFhQjdK?=
 =?utf-8?B?Nmp3NnhHckZteUVQemRFWkpmQitBZ1BOYUJqS2o1TXJPeWJhanozLzhuMjBi?=
 =?utf-8?B?T2U3RzdxbC96S3dFT0FjNHovNGlJKytRa2EwMGdlZmhoLzhTRERmakpZUkdj?=
 =?utf-8?B?T1d1eS9PbWJNZWZ5TUNHd1M5RUYzMUJjNXE0U282WU5HSUhjTitHM1pGVTZE?=
 =?utf-8?B?S0NrbFQvMXJiVmdMb1Bwc01GdmRLanlFbzdrSWR5K0o5ZUpsWjlqNFNlRjJE?=
 =?utf-8?B?WE5BTzJ6NndJU01qdC93VkNPY1dFbUpHR2lBVUlWanVUTkFTVDhrWUVEc0tF?=
 =?utf-8?B?bFowN0loZml6V0kxSUJBNnNOL0h0SjNEYTBqVFJMUy9ISW9YY2ROZGlGaEla?=
 =?utf-8?B?TWJqUW42L0tuYUhWYm85Y0x0cmgrUkJWM1pZd3JmanhNcXdhL3hMUE9JMnUr?=
 =?utf-8?B?bFRmUm9UR0lZdXdDRSt5WDJrZmJQUmlFdVBBNFlpbUdMRmxMM1JNTDdtYmJU?=
 =?utf-8?B?Vk9IRkM3eEgyRFdaTy84eFlmOWgwYUorNGFTUVJNYWlTeDE4elE1ejJ3MXlY?=
 =?utf-8?B?UnQ5Wm9pUEJzNTIrYVBEUnhlMTI5Vm1NbWZlRFJvMjVNNG8rRXU2dFQ3OW5s?=
 =?utf-8?B?WHJhcElONm5XUkQ2eGVYWVdNWmIyNVo5QzQzNmpEN2hBYU1JbTBJWWpoTktG?=
 =?utf-8?B?L1g3RG02dUdhWStRRFozVnNnZ2J6eUNZYk9ZeUd1OFJRMEk2cHlabG42eS85?=
 =?utf-8?B?eVN5MUJVTHpSdFRMZFMzMXdKREFIU1NXQlRGMUJOQnh4S1k4R0R1bWhKUDJN?=
 =?utf-8?B?N0o0VXFtNE5NSTdFU0QxR3hjWUZpeGpjZVpvMHIxV1VkSnIyZGN1aC8ybUZH?=
 =?utf-8?B?cVpTNWZQOTltVXRzMjkvT0tuMkVreDlpSlFYZlFNbmxRNlQxbjFqNHlzKzEz?=
 =?utf-8?B?V3paaFk1U0FTQTY5OG9ETVAzYndLTFFjemNmTG50Z2VwQmtrMGMzdm5zTUpU?=
 =?utf-8?B?d0hFQ0JML2ZhRTFkNWJCc21tZnNnT0ZRYjhVdWkxZGxxU09DRHJwNXRiSVJn?=
 =?utf-8?B?SWpsRTl0ZjZFQldLa1U1MUdaZDcxMFpsNm00Mlp4YXVOTS9vbm9lSlVmMkFa?=
 =?utf-8?B?eTNOSFIrdjNZTXVKdjRTMVQxOUY4NWx5N2tWNUp3RTJBaVMydTZuMW41SzM4?=
 =?utf-8?B?UWIzMm41QmhUTkdhcW9HM1o2UDB5dUNhZUd3M25mYStENmZLV0tLM1ZuOFRl?=
 =?utf-8?B?THZkNk1FNjc2QWF1ZkVWU25XcVBRdkdpSDQreXhuZFlJbkRiZkR5blE3dXZR?=
 =?utf-8?B?SUVzN0xaOTg5YVNRQ1p1NENZYkVjYk9Za2l4NlE5RDArT3E5Y1luaWNGR3lv?=
 =?utf-8?B?Y3p4TEVHUVZmc2U4OVY2YS9MTStibkFmKytjZTdlMzBXcVhJQ1VIVWwrdzV1?=
 =?utf-8?B?NnI0L2FDY2R0WkpxME9SNW5xeHBBMTBWR1ZLY2RJNHVrOU0yTUM1OGVoZGdH?=
 =?utf-8?B?V1FPbHFrc08wczVGcFh5Q1I0MzR6b1VaWWVPYTAxWHZqY1RhVmNUMFc3SGpt?=
 =?utf-8?B?dU1VZ2lXMjBNTWJta09HSUV6eUJGZ2I3aGdNc2xNVjJZNXY1NFdWK2gzdnM1?=
 =?utf-8?B?WmV4ZnlYa1NuQWhZM1FhZVVrMTUyZzY4RXRRM2FBYXZRc1ViQ052bFVhL1cv?=
 =?utf-8?B?TjI4UHJqS1FadjVyMFRYbGdmOXZTTUI3NXl0Z3BoZ2NxbU1jL2RkNi9GZjBP?=
 =?utf-8?B?Wld1Zy9PeTFzTHZ0ZC9Wc0FmeGVDMWs0aXRHVHE0aHE5ck16WHdJVnA1SVpk?=
 =?utf-8?B?N0x5dTBScWFWWjF4RTRaR0x6YjFlS3R2TDFHQVA0WTVjaU9ZYi9jdnpCQlVx?=
 =?utf-8?B?YVFIUUk2UENvQjFyYnR1aWtYd1BTVDczL09ndG5ldHBQb015VURFd1NxTmpz?=
 =?utf-8?Q?NLUelC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2025 07:20:46.5234 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e78796-6efb-470c-beab-08dde215943f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
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

Add amdgpu_ttm_mmio_remap_bo_init()/fini() to manage the kernel-owned
one-page(4K) MMIO_REMAP BO. The allocator runs during TTM init when the
hardware exposes a remap base (adev->rmmio_base) and the host
PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K).

The helper is idempotent (returns 0 if already allocated) and only
returns an error when the actual allocation fails.

This keeps MMIO_REMAP lifetime handling localized and prepares for the
subsequent patch that exposes a userspace handle.

Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 69 +++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 58b6ab1be4c1..c76c41a312b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1853,6 +1853,68 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 	adev->mman.ttm_pools = NULL;
 }
 
+/**
+ * amdgpu_ttm_mmio_remap_bo_init - allocate the singleton 4K MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Allocates the kernel-owned one-page buffer in AMDGPU_GEM_DOMAIN_MMIO_REMAP
+ * when the hardware exposes a remap base (adev->rmmio_remap.base) and the host
+ * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). If either condition is not met, the
+ * function returns 0 and leaves adev->rmmio_remap.bo as NULL.
+ *
+ * If the BO is already allocated, the function does nothing and returns 0.
+ * Only errors during actual allocation (e.g., amdgpu_bo_create_kernel()) are
+ * propagated as negative returns.
+ *
+ * Return:
+ *  * 0 on success or intentional skip (feature not present/unsupported)
+ *  * negative errno on allocation failure
+ */
+static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
+{
+	int r;
+
+	if (!adev->rmmio_base)
+		return 0;
+
+	/* Hardware remap page is fixed 4K; skip on larger PAGE_SIZE. */
+	if (PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE) {
+		dev_warn(adev->dev, "MMIO_REMAP disabled: PAGE_SIZE=%lu > 4K\n", PAGE_SIZE);
+		return 0;
+	}
+
+	if (adev->rmmio_remap.bo)
+		return 0;
+
+	/* Create exactly ONE kernel-owned BO in the MMIO_REMAP domain */
+	r = amdgpu_bo_create_kernel(adev,
+				    AMDGPU_GPU_PAGE_SIZE, AMDGPU_GPU_PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_MMIO_REMAP,
+				    &adev->rmmio_remap.bo,
+				    NULL, NULL);
+	if (r) {
+		dev_err(adev->dev, "MMIO_REMAP: BO create failed (%d)\n", r);
+		return r;
+	}
+
+	return 0;
+}
+
+/**
+ * amdgpu_ttm_mmio_remap_bo_fini - free the singleton MMIO_REMAP BO
+ * @adev: amdgpu device
+ *
+ * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
+ * amdgpu_ttm_mmio_remap_bo_init().
+ */
+static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
+{
+	if (adev->rmmio_remap.bo) {
+		amdgpu_bo_free_kernel(&adev->rmmio_remap.bo, NULL, NULL);
+		adev->rmmio_remap.bo = NULL;
+	}
+}
+
 /*
  * amdgpu_ttm_init - Init the memory management (ttm) as well as various
  * gtt/vram related fields.
@@ -2027,6 +2089,11 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
+	r = amdgpu_ttm_mmio_remap_bo_init(adev);
+	if (r)
+		return r;
+
 	/* Initialize preemptible memory pool */
 	r = amdgpu_preempt_mgr_init(adev);
 	if (r) {
@@ -2090,6 +2157,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 
+	/* Drop the singleton MMIO_REMAP BO (if allocated) */
+	amdgpu_ttm_mmio_remap_bo_fini(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
-- 
2.34.1

