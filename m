Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF1E6CA0EED
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Aug 2025 05:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D24D10EB38;
	Fri, 29 Aug 2025 05:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NBRdMqmR";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2088.outbound.protection.outlook.com [40.107.100.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258A810EB38
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Aug 2025 05:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fD/p8Ji/PDYoHw8jY8bNe2Nz3oTmYztZFH1AGIpuNInoQ6gaUJ6QeaBNjdfw/Sf5rSfU1GU9XSUqt3AT0Y5iiEOkSwYEpQFqFB65i3e/37KDwVWoO8f3hcZUjwaMHtl1WBgRhhHsJDSgR1FF7kg/YEJ4SwIIBYolzkPNYBYkqeU3QGEoDMBpigze1rZktpy8M+D4zWu34fv04yN+JckoLkWkTbiRB1N0GwgdIjrBgymsqyUae/qtigVejDDVegkGz/WQo7jr3bZJr6aiFwhjyJypXEBd2Clw9dIuyr1wMpHtbuq1KwEre8fvYA4m4n+Py7EFQGvIBbuQh2abbDSOkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVf2V/5090SK2/YrdFtrxCDce+pQHKnYArwBjjo6f0c=;
 b=WfYez6qt9Pl7C4M78mtogM+VtMdtyzWHoa3p8j/nwjNRGl8QG2gJk67+1nb19ieiGexblPKLRh9cjY+P/IvG3YGdcjD3qeyVlDjBzyCelZnoGlsvJaRU8KttknfBfu0kxLaLaUiFs/pLtyf0M2MbVoXEDMIRu4ptGeveu8kQJRirBRDpLMDoBvfo/tF3KcUVE5wn8glkhqcpG9GQYVMnUmfVGG2NAbnaA7bnYPX/n/ETdKNLxNNqTeLavu6+Gow1sfiWxUwWBRILYuxpPiotJqyaOU4AoJt0X8VPZASGm4nMQIhiiAJTU08HWrCNkXEKhcUnezA4srRo7myCQ3fuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVf2V/5090SK2/YrdFtrxCDce+pQHKnYArwBjjo6f0c=;
 b=NBRdMqmREbwiLxgkjLwcd+SnNLWBT63mDnaQX7qo5ilh/3+vqIFDz9YAruetIkDMqMoRR+kT7WqiB4TGhd7CjTxbAWWGKi69uGE3kyzE/2MKsRYWwlE+5yh7ydRjl2Bas5kv+UAxjs7QKxvdEigmGMXjCP0ZO+vkb8mVe0jMHt0=
Received: from MN2PR15CA0018.namprd15.prod.outlook.com (2603:10b6:208:1b4::31)
 by SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 05:55:13 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:1b4:cafe::67) by MN2PR15CA0018.outlook.office365.com
 (2603:10b6:208:1b4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.18 via Frontend Transport; Fri,
 29 Aug 2025 05:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.0 via Frontend Transport; Fri, 29 Aug 2025 05:55:13 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Aug
 2025 00:55:12 -0500
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb09.amd.com (10.181.42.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1748.10; Thu, 28 Aug 2025 22:55:11 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v4 7/9] drm/amdgpu/ttm: Initialize AMDGPU_PL_MMIO_REMAP Heap
Date: Fri, 29 Aug 2025 11:25:02 +0530
Message-ID: <20250829055502.3983562-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: eafdc548-2310-48e1-a4ec-08dde6c09f0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0twZkFEd1BRYlhyRmNSQUdwbG5PVHhaZkN3anV4L0tZMUM2SW5DZ0ovd0ow?=
 =?utf-8?B?ek1JTXdhR25nVDM2YVNzRlFMSW80TllzbkdRaU5TZERNK01qMkx5bzhHbFY1?=
 =?utf-8?B?aTBpZHhVazlBd3ZmN1BvakJPejRjckd1QWp0WHI5OEt2Mk94eG1aOG5BTEJy?=
 =?utf-8?B?NVN3Sk5DY1NLUndXZXIvR2tLalhsRFJPUWM2dmtlV3JiVUNVK0x6TFRFU0ov?=
 =?utf-8?B?WDEvUjhORmwzenEvaElsUVhtUUh1aFcyZmNJNllNdzBuUTlacjJkQWFRc3NV?=
 =?utf-8?B?TzRPNW1xemxYTmRKd3NRUStVVHR6YmJYV2dXZXhkeThPaEluQ0FsWnE2bkFo?=
 =?utf-8?B?N1RiWUhZUjhBaFJWZlUxdml4TFRuSFpDMXdBY3pKYWxLaytjU21tc0dOcXdy?=
 =?utf-8?B?VmJ6ZTNOQk0wdHduRGI0akV0ckxpT1dQblNUUG9QVmg0d0tQRDZNRXA2R0wv?=
 =?utf-8?B?WlNQK1RhMzRoUUdKWFVxRG9XK082ZlQrSU5Fcmd2bjFLTWV6NlF0TkFGR3ls?=
 =?utf-8?B?c09uSDVHbkRiQmgxNU4yMHRqYXdxTG0wbk1kbXBoV0RiUGhKeTRQeEprNDcx?=
 =?utf-8?B?SHBBdHJnUEE4UW5YUnI0NElhN0VPZ3ZkMUIxbVZsQlowSExiSU9vS3JpbVlD?=
 =?utf-8?B?WnMwcnBBZWUvbTBSbUt3QjBkd3o0MWRIMDhxcFdZaVZUTGVZTmpmdW93ekhH?=
 =?utf-8?B?dS9JYm1tVncyTlZlMnJNZTJqNGRYNHM0aVlTMzdWYjVYMHpQVlBpRlJ1bWJ2?=
 =?utf-8?B?Mmk2RUdIQmFMTnZERUJqZWZackxSYVIvWEswVVRoSHBLZVNvekMxa1gwVkIx?=
 =?utf-8?B?c0lLMUdIZWVOVERuODVDV3kzY2xWV1IzS2lXM2Y2R2szRlNEVlh0RWw5ank1?=
 =?utf-8?B?ajIxVUxTOHJKQ0VCV040TVlSQUxRT0FyVWhLRFE5Z2xnMjZ4ZUdKOFBnMEJX?=
 =?utf-8?B?QXE0SUl5cFVwdnhiUHdRcjN3MXRnWkhtRHBxeHMvU3VrZkREa2x5eU94Z1F4?=
 =?utf-8?B?YVlONHJnU1h0cjU1VE8rbkxCaEF1U2hLY0sxMTAvZnpGbWRSaUlDajY2OS9r?=
 =?utf-8?B?UFU5QzBuSVhzRU8rZDVGVi85cUZpM3hYc09NdHcxNnBCSkpueElMcEVqbkZw?=
 =?utf-8?B?dWtWdXlqVEY5ck8wQUVCLzN4U0dpWW1YZEZSSDVsNkxvcXNoTnRnVWd3bTZx?=
 =?utf-8?B?QkhCcEhQOFZxSWVWeCtqS2hLdHdUV3BaNnRtdktyaEpkb0tFaGlhOFUxbjZU?=
 =?utf-8?B?Mm5tTk85bGgwT2JOV0VhU0VYSTl0VGNVbnJORXhJQTA0Rmk0TUgvaUFKem9l?=
 =?utf-8?B?alRmbDZiU1p3bDVDRDlxbDhaV1YzZ3VsU0RrZ3BNQzhYQWRPN2FoZ1g2TzJO?=
 =?utf-8?B?a2F4enNUTFBJMWxjSDVMcWtTY2lLZ1REUWNXV2pNT3JkRmo5Mjl2VXJuK0Ju?=
 =?utf-8?B?TXR0M0dnTjRMbW1GbThpM2VMTzVyS0N5dmlCeTQ3NlU0ejFIOU9JVzY4Umly?=
 =?utf-8?B?K0JGVC82ZXZNQ1NYQVBQdE1kd0IxUmNBaStibUdBTFNIYmRWc0tZQU9UaDFv?=
 =?utf-8?B?cWY1WmNPSlF3c1hicVBUZDBXSEdPWkN1ZjM0enJOWXc4WDY5K1hMU2FSVjdI?=
 =?utf-8?B?Q01kS0lMNkZFQk1MZklFWFVvTTJpSEdTNWpvR2JXREF1SG1ZZkE3bHZhZ01l?=
 =?utf-8?B?R3R4QzJhWmJ5dDBQcTFJZ2hNR0JXakczVUNUMzlVdVlzbmszS0dCNkEvUUR3?=
 =?utf-8?B?amh6eEVmR05jejZvdjJFWmhldFAzNG1BRjZVaWhkaHBPNGJYdnRpM1pIZkVt?=
 =?utf-8?B?OU5USHlqT1I1QVAweWd1MVVCR1IrTDhGZ2lSOVJ5RnYxUGVvQnBqRGpUZ2Ju?=
 =?utf-8?B?alJKVTF3bHRlTjltcUN3Q1BMN3JIekNmYWlpeVFQU3VBS29BQWVvT1dyZ1k1?=
 =?utf-8?B?RWJNblhQOHM1dndXc3pHaG1nNzZGZzZrMG01ZDJCSENaemhUejJrRUc2RVQx?=
 =?utf-8?B?R0c5amhkREU3cmE2NVhlVVZoTzE5YlhRS3dCaEN1ckh4SHlqS1owV0tkaTE3?=
 =?utf-8?Q?Aqy9JP?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 05:55:13.2697 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eafdc548-2310-48e1-a4ec-08dde6c09f0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5f378f5c9350..7305d40a62e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2020,6 +2020,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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
@@ -2082,6 +2089,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	}
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
+
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
@@ -2103,6 +2111,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GWS);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_DOORBELL);
+	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
 	dev_info(adev->dev, "amdgpu: ttm finalized\n");
-- 
2.34.1

