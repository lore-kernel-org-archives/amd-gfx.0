Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B075C8303D
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Jul 2025 04:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2254010E1A4;
	Sat,  5 Jul 2025 04:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aTRbgiV/";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 204C010E17E
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Jul 2025 04:25:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rFYuLRBPai0FKlbKkLiF1Pq5a7gYOHUiqwMx11tNtyrH/bjuU2mf1SVQXrEbuJinQ5MptmkDjk1gmHUj8+53S9ts4yW2UsLUN7J8btQnBz20mMfH2WQfSp2vhIiNOkfA3nzeNQ2m31yokLBiYOAs9gmAVfshS1RSAR0c1gOaxiQsPlS3fWHD1FrZ3qp6i8UhgOx+53+gf1QTk9NhTdlHUicFiwhn25Odsp6sD8wDsnrq3rhi0ww0mg6xRmQMNkuJ6c8pb88pPijTgrWTRI6RGYRwuQvIagM5/2BBPAFdGW8g/RCx792yi8KPgY4X0quLmYk+tvHFCLI8KCxJpW/qew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3FFI1+Lz5uT7JUbSkhSxPrg4C6gJs6t2H70ZUcBwzRo=;
 b=S67C1TvWl6cLMZ3qjDLpS9yA8sM3RSG1BQTDUd93ynmsxpdYpHV+rUxuDMJYWWTnMFkxBm1ftn9N5kEJMbbD8ixtpCKHNMpEcxfMgqO53SNwwiX0IPeP8ZAXYZD4Ut5F6s+GSJ1x1lCY7IdzCW5WfxOjnzazA6nGfHY3BDPsnoWWGXtQn/EDUgQ7uUFNGQdnDRdflyK7143gHo16hGcfvfPYDV46DogwE9uKHsNMZjE1q/tBmq/6w5cEIioeUNoTd2lRHBmjjxDNFWteXUgaIBGDf3jRf1x4463vKjuI4GJ7IEmkGzmVYoU2HBwfSJFxEWtES3rVvwI5GbwBQ15BzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3FFI1+Lz5uT7JUbSkhSxPrg4C6gJs6t2H70ZUcBwzRo=;
 b=aTRbgiV/IX4Kkdle+da3PQr0Z5jpo1aciqahIv3pEqKPfGrR+WptUbsSOnxIoZd1ducOrmkCleo7SwUDam+KkKgPazaob415Rlrd8BZhj5iBWdFieOA/0sQsIQRfRuHrXAK75JgQVnVS7sP1/IivN3N+iNS7MAnZ79vR9PkmcHo=
Received: from MW4PR03CA0002.namprd03.prod.outlook.com (2603:10b6:303:8f::7)
 by DS5PPF7B9F1F8E0.namprd12.prod.outlook.com (2603:10b6:f:fc00::656) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Sat, 5 Jul
 2025 04:24:57 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:303:8f:cafe::78) by MW4PR03CA0002.outlook.office365.com
 (2603:10b6:303:8f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.21 via Frontend Transport; Sat,
 5 Jul 2025 04:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Sat, 5 Jul 2025 04:24:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 23:24:52 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Use cached partition mode, if valid
Date: Sat, 5 Jul 2025 09:54:35 +0530
Message-ID: <20250705042435.1359695-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|DS5PPF7B9F1F8E0:EE_
X-MS-Office365-Filtering-Correlation-Id: 1367a2cc-b5bc-4644-7076-08ddbb7be574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?7NsT9ZloLgRs7pQieCP7MiHp0QC86BKqXq+pMYrPIb9MaolHtAo3UFyfJDce?=
 =?us-ascii?Q?g2Ggf7/3Qextpg6be1zT+2XZG+aVWvG2G+7pnbbH8QxiG0B+2qY+2y5VhsKU?=
 =?us-ascii?Q?9YCXgy87xrZ/onm8aILc/lGAWm7+JSExCEgFdDF9rdEF4C8Ft/mRne/tZKwp?=
 =?us-ascii?Q?44uSuS/N2y1tFET118xBVB24zADLzdb2i+toLh6AXyjGknEVIKC4ewYQWoVU?=
 =?us-ascii?Q?cIEbrL2vcOeJyqGBnmtYvbZ8O3kAzATVUYTbwoMcwJN/Ys35yd4f1gTHWIIV?=
 =?us-ascii?Q?ohOyTxU759zDHcY+jANRHkCrQ7yVYZ8qIEn2PS4pBzVZDNZC0qnM6qX8Ztc8?=
 =?us-ascii?Q?zEuDhN6Sj/IVlP4/lznD8MM8NbwkspxzB5BtC45pe78mbB3qp51UxqNMcdHR?=
 =?us-ascii?Q?RlrXXZaoylXCrbS+8Bk9vc2jxm1nX635kPvTfTWf1WBR2GmnNOiSl5dQ89Gc?=
 =?us-ascii?Q?rUQuxfpE/CmxkxnjVYNI1hGAcwlUpCBKD/y1raEreRKxEcYGqB+1V4DvjqmM?=
 =?us-ascii?Q?RgqyxuAor3PKeuaqeMmHCHs9DZbplfFVPl2QWahttkjyMPrH0hPQ4II4/tts?=
 =?us-ascii?Q?nnRh/bq/lZDEF7+Amk1WGS1RHBujuMRJZadHq/iAkIAtK7y7C5VI3bBnuDwU?=
 =?us-ascii?Q?Ohu1E0K+EDd9DHP++ilQ/IDhHzC1U3q2rzJPK67TkhqkhXaueQT5V8BaKMTZ?=
 =?us-ascii?Q?ND7DpXSDBhdXyJpLb8DMjQLkrjj25t0Sk5lJWprQGQsZG91dLGZzBzGB+Nps?=
 =?us-ascii?Q?XT/vqkCQinUTLzs3wXSwPCptGMm6m7F0EB/2m3iem+2JTVeUhFEkxtUDdv6D?=
 =?us-ascii?Q?ypaE1jG9kIK8u56bcFYMDphZCYF3QaVps2UGG/XPuAfQX5MyW4iznlLfin6N?=
 =?us-ascii?Q?CI4onqMlLknxxUYSlCqChFfp0NK1ufQ4BsmL2RCdJfaJJIeuoMuArVDZ+eyj?=
 =?us-ascii?Q?s0s67ayd1kwCkCtYjki1vwxneUwbboRx1lMIMuD4dF36voiKkph+tVYGITDV?=
 =?us-ascii?Q?iHo+HlCffAkEw9Vq9G/6GMRWBm7+rQStbWCgFmVgECo7f6+pCOUseu6znp1A?=
 =?us-ascii?Q?UFDpRxC5Z4pdmSdMfjCVby9ajP8xr4ZxEhnOjmF269GgKiXoQ9YcimZ9DXGR?=
 =?us-ascii?Q?wx6wu9EFkc8IvMMI/sxiZVWA4x3qKlyUCgx16G1vLkd+AIfHiCkoEdgs+lGv?=
 =?us-ascii?Q?+5O2f26IcVCDlby3d9zYDWpsTfRSoAxuRaiZ1wJNis+HQVY1Yz4JQZJUnRQC?=
 =?us-ascii?Q?3bVcMGnQG4tqbpxaGZHkkaK71Dc5slrwVKzDjXAvbDsLmEtc+vD/dvU1tbQW?=
 =?us-ascii?Q?AZ1aJ9h/T+lirjfByaPuab0mouIoTMY26Z64PwO+vNvQ1r6sxEwsmtS+Edka?=
 =?us-ascii?Q?kGa9DfxGBoZUeea5X+5NNhvt3zzz7d1HHcX1rSWebqo85rtFGcsMc1Bc9P91?=
 =?us-ascii?Q?flIxvjA5IvEKuPL8OgDxH00yODpizHkzEnAvaSE69NorLS26scI0IJ/8QhJa?=
 =?us-ascii?Q?H2Itu9/YwfIskvxs0igUglCVhcyL5wQO+jme?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2025 04:24:56.0109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1367a2cc-b5bc-4644-7076-08ddbb7be574
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF7B9F1F8E0
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

For current partition mode queries, return the mode cached in partition
manager whenever it's valid.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index c8fcafeb6864..c417f8689220 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -218,15 +218,27 @@ int amdgpu_xcp_restore_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr)
 	return __amdgpu_xcp_switch_partition_mode(xcp_mgr, xcp_mgr->mode);
 }
 
-int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
+static bool __amdgpu_xcp_is_cached_mode_valid(struct amdgpu_xcp_mgr *xcp_mgr)
 {
-	int mode;
+	if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
+		return true;
 
 	if (!amdgpu_sriov_vf(xcp_mgr->adev) &&
 	    xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
-		return xcp_mgr->mode;
+		return true;
 
-	if (!xcp_mgr->funcs || !xcp_mgr->funcs->query_partition_mode)
+	if (xcp_mgr->mode != AMDGPU_XCP_MODE_NONE &&
+	    xcp_mgr->mode != AMDGPU_XCP_MODE_TRANS)
+		return true;
+
+	return false;
+}
+
+int amdgpu_xcp_query_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr, u32 flags)
+{
+	int mode;
+
+	if (__amdgpu_xcp_is_cached_mode_valid(xcp_mgr))
 		return xcp_mgr->mode;
 
 	if (!(flags & AMDGPU_XCP_FL_LOCKED))
-- 
2.49.0

