Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507EDC28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 04:05:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC8F510E97B;
	Fri, 28 Mar 2025 04:05:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PtTXR/PZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80C2C10E97B
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 04:05:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHO+RYtQYzyMmgDVyO5IzTS+GAlXoZRGhcdoO0uhpmUvlwK4g4HkpjzPjuxZfGuilrfG+ACm3ztEUXgkTl3/OmhjlxP3Nfyq7CLvS+WPq1/NgaKS0rWuBLkjE2vvDBSSfGfA10B6HTV2XOi2iKE3RmLy5CNMdqXJ2nLjrAst5oVsu5wSDH4jhsCKs25LxMC3vlNwswvvaEOaDIxrAmURjxjvSzYypLK1hTz97hbzDmLfOb5UWrdiGrxAPcW14yeBBD4Y005/tMedw3oVPHEeN6P2psn0IuWtP+qbdk/SesRf5JExYsKzG7Jk5XQ0CZG4NEOq4p3JmoFJ6uuwuxYz0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOdMTkOeIzCVyOgPcy/RGW6WCyvaALfUZY2yvS0iEik=;
 b=mRfWJ6tGY8uCmFfbDZBKyj/3kqZrQmXNOTg1t726m3Mk40UpFgZdeBrnFWT7EsgmeCWtsMOU1erF2WCwi/PTU1TR+z61vBSwSVfZnTFu38STEZE5iBLIhOj4b7bUwH3iaFZ/+FoFHD2+ovCZlzfLV5/b8Wy34oOvPi2RZlqJx45Aowxfw+rO/ohm/qgv+Gb7t6Vk/2KJRVM6gfxX+wF5bNIHKxlgQ/8NrU/1MsrmXoQksXOs/DmwqxIkyqM1rtFBLcJ2/wOCdRVaA9rZJj2Ebldz2Jog48J8s2G9QWvQzdJx2yld+zAdGgSH4/OSAlqNe2QYXTc6Ga/B9Urp35DspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOdMTkOeIzCVyOgPcy/RGW6WCyvaALfUZY2yvS0iEik=;
 b=PtTXR/PZWNWFT3/EIoNt1a7UCszhV16RuJAdCtPBg2sTiXz15Ec/+cEQYpokpvOft32GMb9unrUq0XIBc70jPIbBMShjQwVbfyrqSzBISvCxFPZ6CnLvmCGV3u0tLYMZkER4gef/SLDpGXs2FxTEsLOLPDXh6wkDFucb9aP+I2w=
Received: from PH0PR07CA0112.namprd07.prod.outlook.com (2603:10b6:510:4::27)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 04:05:45 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::f9) by PH0PR07CA0112.outlook.office365.com
 (2603:10b6:510:4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Fri,
 28 Mar 2025 04:05:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 04:05:44 +0000
Received: from jc-d.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 27 Mar
 2025 23:05:43 -0500
From: Jay Cornwall <jay.cornwall@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jay Cornwall <jay.cornwall@amd.com>, Kent Russell <kent.russell@amd.com>
Subject: [PATCH] Revert "drm/amdgpu: Increase KIQ invalidate_tlbs timeout"
Date: Thu, 27 Mar 2025 23:05:25 -0500
Message-ID: <20250328040525.3736064-1-jay.cornwall@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: a3657197-30a1-44d1-7dd0-08dd6dadd060
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+Um99AreB//FvmzZbcQiiD6CNYCTSXb65M53VeuKPQ6BeAhOPkUj7XHmXObZ?=
 =?us-ascii?Q?Q4kv3PQ2brxb94yCyFeESU95GGp0UjM3lnflNHuvpYCpWKN5UzDQ1a/gdSH4?=
 =?us-ascii?Q?K2o/J4vjNzfyVHFLyK1eu1Xh9XiSma7BKxdNxuvxrDT34vVbFunBnJwD/KAn?=
 =?us-ascii?Q?oNwAL0ZMmrEkrj8clmnUuH9n3vBLDBVmQLxiL/5qhY7a1HbbCczTdNapywwa?=
 =?us-ascii?Q?W0drVxUKO88KQBOAdQhbEXT7IcqazQI7V2zWFGUrz2sjUsnriJfB0wjQc1sT?=
 =?us-ascii?Q?sOYH4SwIRoEErfGtRR6g2PSuBVVYwHAfryLmgweDra7/Y1CDw0hqNJrqGSv9?=
 =?us-ascii?Q?dQaAJQUITDEBLH+YGJSO3y/ln7LQK3qob6gzku//FWkm+e4LvcxC0+KZuYZd?=
 =?us-ascii?Q?3+2MSiwePEr8gfJB9roYRyaoErSNdPIBZjjrWOvrEpnYJOTNjuMu6cG+xZ3M?=
 =?us-ascii?Q?nfA8gNN3kkd2jxfMKQgx6LpLZ1efGkbEkNyAJiiYOgTAwr+pVsGa1fLzgroM?=
 =?us-ascii?Q?4urqhIkNTuWJg4LEwaDfAvk8n+Elyqfqp2Wnbdpa1jWgLOiQiwW+Hmpct+fx?=
 =?us-ascii?Q?LtLcUHKUoStuwhJUjJ/qaDZ6c9sSL27quWGMDceSRALuGnKdqDwnmUqEj4EL?=
 =?us-ascii?Q?FqNC9su6rLzZtsY2EWBMIrSDfrTzkMgc949XZba/9S5CMK+aQehiVmJKpAjc?=
 =?us-ascii?Q?vlu/+UD/JfgW1cC3Yi6trTxupkCnZuIji3c0Zgh2E7c3jbkuCdm/yGNHvx+u?=
 =?us-ascii?Q?8eRqgfes/Ox5ZuHz9+jub2r9ICS/X+8Hcycy+PTtWVrR9LcZuF8diUWr8vEJ?=
 =?us-ascii?Q?PN5q6HoxJtGgmOyranI3EXs9GurxNvTxtgYh0zrntxq6N+SouQn9W34j2heN?=
 =?us-ascii?Q?+OcGEiNPkLnFV5TJ2Xmx/2J0ykoL7rNdivy8N66UErxsl3gOqUm5J8fStRVW?=
 =?us-ascii?Q?DIDkLfLUj3KDFBSoTrPSw0ZeZyCu2UevlRE8bJO42BqYW44TK1NP7omU9fAA?=
 =?us-ascii?Q?O818WoWAqprodHA9XV7Bj92RsLCVFsifhAw5obwWepRpjiuGmeej9zq+BZ8r?=
 =?us-ascii?Q?Ka61/qaCJwBIu3bIXEnJ+4gK6HKcjIMUS48s1YdXwi+hD2roW2+bIPJEr6mz?=
 =?us-ascii?Q?UP8Toofp783t0PIsvsORtc00TSvi7wSB+3ohSFpWKcQTEuTcLh/uahctvbs/?=
 =?us-ascii?Q?fiwQLqfTVD5urkI9yG+eC+hGEDJum4vV7DY7q+LmB12jIiX84HJ7AxPTkHFI?=
 =?us-ascii?Q?3gXYcJ8pHWuGgawqXPVUzrO4nHzwvcF4b2HNjKn5Z7Wnr6Ho7y9kk+5wa/IH?=
 =?us-ascii?Q?3Lek4Kx7XjYP6/DyFDDXHHTskH3cme9UJpJft6WbYxh21dXC6YdkhVL/8q9a?=
 =?us-ascii?Q?AtYKNj3S49xrT2vVCoeFowW7PW0wfoNExBWgctGrmrCBzy0sHcDmMrMVVlWo?=
 =?us-ascii?Q?7lapzR341Q8oPk+Ypxb+B+9SwZOEzgGt68BG+Z7DV9+ZRj138/n6/MT+QkPv?=
 =?us-ascii?Q?bNLPeKLwfvs3Ox0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 04:05:44.8607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3657197-30a1-44d1-7dd0-08dd6dadd060
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539
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

This reverts commit fdb90033846e2f23dfaaa01dc47fec7b94704d0e.

Reportedly causing unknown issue in memory management code:

[  128.047288] amdgpu 0000:65:00.0: amdgpu: Failed to map peer:0000:46:00.0 mem_domain:2
[...]
[  137.815340] WARNING: CPU: 81 PID: 1006 at drivers/gpu/drm/ttm/ttm_bo.c:613 ttm_bo_unpin+0x7e/0x90 [ttm]

Signed-off-by: Jay Cornwall <jay.cornwall@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 16 ++++------------
 2 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3cdb5f8325aa..ffca74a476da 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -356,6 +356,7 @@ enum amdgpu_kiq_irq {
 	AMDGPU_CP_KIQ_IRQ_DRIVER0 = 0,
 	AMDGPU_CP_KIQ_IRQ_LAST
 };
+#define SRIOV_USEC_TIMEOUT  1200000 /* wait 12 * 100ms for SRIOV */
 #define MAX_KIQ_REG_WAIT       5000 /* in usecs, 5ms */
 #define MAX_KIQ_REG_BAILOUT_INTERVAL   5 /* in msecs, 5ms */
 #define MAX_KIQ_REG_TRY 1000
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c46e36a0cd9c..464625282872 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -699,10 +699,12 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 				   uint32_t flush_type, bool all_hub,
 				   uint32_t inst)
 {
+	u32 usec_timeout = amdgpu_sriov_vf(adev) ? SRIOV_USEC_TIMEOUT :
+		adev->usec_timeout;
 	struct amdgpu_ring *ring = &adev->gfx.kiq[inst].ring;
 	struct amdgpu_kiq *kiq = &adev->gfx.kiq[inst];
 	unsigned int ndw;
-	int r, cnt = 0;
+	int r;
 	uint32_t seq;
 
 	/*
@@ -759,17 +761,7 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
 		amdgpu_ring_commit(ring);
 		spin_unlock(&adev->gfx.kiq[inst].ring_lock);
-
-		r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-
-		might_sleep();
-		while (r < 1 && cnt++ < MAX_KIQ_REG_TRY &&
-		       !amdgpu_reset_pending(adev->reset_domain)) {
-			msleep(MAX_KIQ_REG_BAILOUT_INTERVAL);
-			r = amdgpu_fence_wait_polling(ring, seq, MAX_KIQ_REG_WAIT);
-		}
-
-		if (cnt > MAX_KIQ_REG_TRY) {
+		if (amdgpu_fence_wait_polling(ring, seq, usec_timeout) < 1) {
 			dev_err(adev->dev, "timeout waiting for kiq fence\n");
 			r = -ETIME;
 		}
-- 
2.34.1

