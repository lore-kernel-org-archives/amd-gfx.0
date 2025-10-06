Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9636CCA471
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 14:17:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7AF3810E0F5;
	Mon,  6 Oct 2025 14:17:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TcthvynA";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D3A610E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 14:17:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlklPAGxJj8CDyek31tDv35Y89oFgEF0Z+whWUva7uX9G+p2xCJ5potcvy53Kgxvtj9gV97d7aIzjt+3/u8n/1nx89kGeRwZm9r49tIo/yzChsIX0Fdk/SuFHjx8e+jpcm8geAymC1cj99bkGoqv6Q7cdI/bxfW7hBfkcKZrEsEEg8qfQWXp6wA30A8Is7H2ce8s8lEzph3GoOF0gLKm/h1Be+f+0pxyBVCHLV+FE+mrJ1Wmmznoz27150GOQg/EkdFD2VqzlDkxjS1Bb79pn4NTiSj+wMYEUajJF3Oy8ZrIMRpeWt+3uW87cZngmkK6lETeNOD9O+TFXriN2L5KEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Paqi7RRwS0dyMOGovPZPtftq0j2nRVVtaXj2JHH4ctc=;
 b=ALwW6JE89f3P4EXQew0CZCxmNLFhF5jVmAMJXRb5dyBLuxnFy3Y9VIcyw+QJFvygxTmt84q2eUHwHmlLP8/oUXazw6T7jqIXyWB+7sJi/zpoN/J+R03RG3K8oBub+3uP2xbqQQelRzz/FEgFkaZPW2pLctrvAUa3T+NLaV0YY/gxcdFIu/BZzDzPfVM76O0uvNr758qNzcxP/JMd8J3JsuMJFHVZ+MNJGPLa7VYCq+2U8QOXTwP9bm1mHZg4qlElQBJ3WL46DRI8lnubJrVeXeQfZ5xNw3LDp1HJ1ctINJYL5pDW3al1pmPKplMttFD5JM4C96xW1Qv/ZOe+yo2flg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Paqi7RRwS0dyMOGovPZPtftq0j2nRVVtaXj2JHH4ctc=;
 b=TcthvynAZkuFXqMQ2prIIQ7LB+LlbEa9ovoTkwYMVnnaQM01+K5LhDl9hPi03FE9nylY+gImfsIGURKKAYGFN1VELDKffK8E0ryn2xtf9wG7FgROdMU8fORLd/1u+vlZveAgEcL/MRjfcS6aJ4dx//JHQEYeinhPvc/yxh6+EMw=
Received: from SA1P222CA0060.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::10)
 by BN3PR12MB9572.namprd12.prod.outlook.com (2603:10b6:408:2ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 14:17:14 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:2c1:cafe::e9) by SA1P222CA0060.outlook.office365.com
 (2603:10b6:806:2c1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 14:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 14:17:13 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 6 Oct 2025 07:17:11 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu/ttm: Pin 4K MMIO_REMAP Singleton BO at Init
Date: Mon, 6 Oct 2025 19:46:53 +0530
Message-ID: <20251006141654.32291-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251006141654.32291-1-srinivasan.shanmugam@amd.com>
References: <20250912111148.833465-1-srinivasan.shanmugam@amd.com>
 <20251006141654.32291-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|BN3PR12MB9572:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e76bacd-2757-441d-c3e1-08de04e30bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZHU3OGx2VGEyaS9uQlFCd1g0aHYzQXp0OFpnb3BIQ21DQllDdWZKbUUyYmpi?=
 =?utf-8?B?Ky8zWS9jY0tqMCtjRElJR1hMellVNHZmdSttbm5ZNFVSZlVOUlRPU2c1WWNM?=
 =?utf-8?B?MkdHQzZIZFpSYXh2SXVFS2JMd2dCb3RZQmhhZktyS2FBM2VXMml0SVVIMEFF?=
 =?utf-8?B?NkFtSVN3cDNCTzd0RmptN1JjMnU1aGZ3YTNTaytjSWNDWkRqTW9EOSs2Mk1k?=
 =?utf-8?B?WjBCUC9GMU5xZ213dXU3Si8rWlcvdTZya2txWFFLZzhDcXU3UFlpWkplQ2RL?=
 =?utf-8?B?cWtDdTUvVzBoWitVTXorUm4wUEw2UU02MVZ4NzJQb0hsbGhaRExHOUlRMVRV?=
 =?utf-8?B?N0NPWHNpZ1pZN05HeTE2VVBKQVlyWGFad1lMYzdJbEtQOTlZZmJuQ3BrSDJE?=
 =?utf-8?B?bzdiV0c0YUNwK3E3V3FnTDd5d25yYkZ6MmozOGY1SVNyMzdpdmRGK0x1WExj?=
 =?utf-8?B?Uk4wYUhXM0tKVUJrSVBFZGZTeEo4OTFRelhMK1ExYVc5a2tKK04vclkrcGcx?=
 =?utf-8?B?NUVrQ1B5d0V4NzczS3pqL0dmM29kNmhGdEhuTzZqd1NUMUhQbnd2c2haV09O?=
 =?utf-8?B?bDN6Q0M2NXdYKzFtdGNEblVWTFZWbnM1dDl3cHZJKzZPTWE2dWpZbFBLUCt1?=
 =?utf-8?B?QkQ3Q3hRWUNudldIblR2OW5XYzRMazkzOHFGcnEyNThEdFRKeFpXblNXZFhu?=
 =?utf-8?B?TCtUeXI2WGNMMWJ5VDRHSmpsenZqLy9leHFEazJrVzhETWczM1BrekxjemNh?=
 =?utf-8?B?eWFFQ0M2VzFoaE5JOTVlcUVwOVQ1UW9KVGQwU3hXaUwrLzR6djdYRzBjUWJl?=
 =?utf-8?B?dEI1L1JySDJ1SlZZQWlhWUFjck50RnNKc1FPZkxKWFlhbk5FdittQlRpT1Q0?=
 =?utf-8?B?Q1FvaTdETjZPa0lrZXlSdk5NNFZpTStpSG54QXZkNUFibGFIbHZzNExWbmZx?=
 =?utf-8?B?YWFSM25ZK1I2b3lyaUZLdVoyeHFObXB4cEJPcm5BMHlTTmx3eENiL05kWFdN?=
 =?utf-8?B?TXJxZ0Nwc0crRWppajJtdGpxRjhYUXBUU3ZFK1Myd3BvRXBwT1RDd0J1TCtx?=
 =?utf-8?B?dkIxUFYwWC9TS0FYbjA3T3lHZ3h2M3YwTjl0VWZKdUFqZlpQbHNzdms3eFZX?=
 =?utf-8?B?cDdkVEd5cTlZcVFERXNHUHR5RDFzM1RxeHhpOGVFTS8yTDJGUjhCOUl1RllL?=
 =?utf-8?B?K1UyWHRyeDNSM2JHTzFPa0hjT3RBVEc1aFBvM0NzaWxqR3NpM3ZmUGdqQXlj?=
 =?utf-8?B?OGJYakcxZ0Z5bjc5dEdSMGlBUlUxSDZpUzliR3V3UDBvbWNnL1hMa3d1ZC9X?=
 =?utf-8?B?K0FPT2k2bVh3STB4U3lrb2tQMFg1SGQ4SDlRcXBVU1dRNVQ3QVBBb1c0NTZ0?=
 =?utf-8?B?cTU4WUpLZjdIN3hUNi94VVl2eGRaRi82YzB2cjUxVHU2cm9GUllRdjlLYXFB?=
 =?utf-8?B?RHFESWllSWhqanh2Y3pQN2YySnlRa2cya0dGRzJCUG5lU29BSjd0YjdVcVJO?=
 =?utf-8?B?V2VQQitlanZReHFhdENmK0xsYlBnRDZCMmF1Zk5wdFJEd0RYcml4VDhKbFVa?=
 =?utf-8?B?bW1taktEeHFhZVRyRHVRRk9iWHM5cnZrZlUreWxLY1lWeVBSVkZHNUhjQ0dG?=
 =?utf-8?B?ZlJDbEhMOGtLdmNQeXB1V0hOY29NVXJsVUVvbTJLZW8rcFptYjd5WE1UcFli?=
 =?utf-8?B?cnlpb0xVM1RuanZYNkxBMDc2cXdMMTVLdFRXVll1YWZiM2gzakNSMHlhanFy?=
 =?utf-8?B?bmp6TW1kVUhvVWtCYjBKM0VKNEt1bmRpeG5jU0d1OUNEVXRJZnRpMzErUlZW?=
 =?utf-8?B?bE5BTndPbG9aUjdxMzN1QTd6NlhCeldwbWhaZXd3RHhsay8yWG9pa3NjQW8w?=
 =?utf-8?B?aS9yaTdBaUMzYU5TNy9nb1Rmd3FnZFZCL1ZpOG5TV0hQdVlja1NMQ3pEcU5G?=
 =?utf-8?B?M3dVZVRQbFFkVFZOTXo3aktoa1VXREVDUGZLNU92N2k1YkE4WTVHZThvRWJw?=
 =?utf-8?B?VDdPWGNrVEVtMXRPLzZocjU2eGNWYmtYRTVlazdxZ0huWUpoOG5MZjYxalQv?=
 =?utf-8?B?dVB1ZFgyQ2NaOVFPNUFOTms1Vk9MeTh5dFd3SXU3U0ZoakczQ1M3THlSRXNC?=
 =?utf-8?Q?vKCU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 14:17:13.7028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e76bacd-2757-441d-c3e1-08de04e30bf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR12MB9572
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

MMIO_REMAP (HDP flush page) is a hardware I/O window exposed via a PCI
BAR.  It must not migrate or be evicted.

Allocate a single 4 KB GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP during TTM
initialization when the hardware exposes a remap bus address and the
host page size is <= 4 KiB. Reserve the BO and pin it at the TTM level
so it remains fixed for its lifetime. No CPU mapping is established
here.

On teardown, reserve, unpin, and free the BO if present.

This prepares the object to be shared (e.g., via dma-buf) without
triggering placement changes or no CPU-access migration

Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 26 +++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 046ff2346dab..d4c93c78b80a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1861,6 +1861,10 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
  * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
  * GEM object (amdgpu_bo_create).
  *
+ * The BO is created as a normal GEM object via amdgpu_bo_create(), then
+ * reserved and pinned at the TTM level (ttm_bo_pin()) so it can never be
+ * migrated or evicted. No CPU mapping is established here.
+ *
  * Return:
  *  * 0 on success or intentional skip (feature not present/unsupported)
  *  * negative errno on allocation failure
@@ -1889,7 +1893,25 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	r = amdgpu_bo_reserve(adev->rmmio_remap.bo, true);
+	if (r)
+		goto err_unref;
+
+	/*
+	 * MMIO_REMAP is a fixed I/O placement (AMDGPU_PL_MMIO_REMAP).
+	 * Use TTM-level pin so the BO cannot be evicted/migrated,
+	 * independent of GEM domains. This
+	 * enforces the “fixed I/O window”
+	 */
+	ttm_bo_pin(&adev->rmmio_remap.bo->tbo);
+
+	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
 	return 0;
+
+err_unref:
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	adev->rmmio_remap.bo = NULL;
+	return r;
 }
 
 /**
@@ -1901,6 +1923,10 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
  */
 static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
 {
+	if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, true)) {
+		ttm_bo_unpin(&adev->rmmio_remap.bo->tbo);
+		amdgpu_bo_unreserve(adev->rmmio_remap.bo);
+	}
 	amdgpu_bo_unref(&adev->rmmio_remap.bo);
 	adev->rmmio_remap.bo = NULL;
 }
-- 
2.34.1

