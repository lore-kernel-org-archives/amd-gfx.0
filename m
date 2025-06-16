Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE09C71155
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Jun 2025 14:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0647610E3B9;
	Mon, 16 Jun 2025 14:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KiSluUgp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91AB510E3B9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Jun 2025 14:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NbpcdcUCncWzEe0TjGNdYeo+QFtva0BhmFkAbxGG82F8lmqJxQGupmoN1FGCRQElHMgaLv5WqMzBig2V/tfv6UdzI7iabC0geYWH9iGKVuGAjeaHo3pIof7APHvTWHTQWA8N8OD2/hFa9ZAj7+PBYX5yCUeHLgq7qv4SwhORxzWNTswRI04sHxgI7m/40qi04N7k7IBos0wx7yVLtNjgMEVvvoGwe6joezxg2qJa5MXuijuNzg9z5/hetnAJAe02sOqlDwjPND5avcrfzAPdqNqsqiXUsRz96Lr89LoEHGtn+Qd5NfNsqZWhQXtAUndtQNNYowpdGdONF3zRQJWHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ws3gMK2rBeG+Oo0Y0PXKe5xoGlnZPKOYYgNIfxxkDN0=;
 b=ZSv5RRNBhNrsuZDVpyP1TbDWJaA+G2f+O2qeE5H9G9bp/4fWtzCslGug0tXFYG8PEByOuJbQoG8ZwcOMNljsORhEO4FqJ0BwffXbcgfjXTepFluvRoJTt0ADk7mTvUPUsSoWB3uedJVrQyZC442XKMHY3k9GaoFBYkl9o96OZNUup1m6HoSWV5Q6TcmtW5TaJX2Jg8ewq0VYmzDFPxAufguUvyrcTz23/gUtdsWY9iVE9i0ozqsPt7J7GC1os4dn7QqnKUnPFUqBsH6IfkrPUINItbiOsLSKTk2TZWpIbTe/xzlN84Z4adgjl4aqakD4MMiGv+/Xxx9wnfcXmfVsNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ws3gMK2rBeG+Oo0Y0PXKe5xoGlnZPKOYYgNIfxxkDN0=;
 b=KiSluUgpt/TrOfcL+aMvE6j4rDK+hic4zM06Rr5VblMKHuCdsZOtcpN6b1O66O0JaKC7zGiWDP3mSC4U4ExbTeuaMQSE1DsnHKi3B5qltJUVbPVVaWwL7J7a8N16Vlg2ySZ9XhqmYaLUYMNW26qK+obD6p/prXfUg11aoiCo7vw=
Received: from BN9PR03CA0746.namprd03.prod.outlook.com (2603:10b6:408:110::31)
 by MN2PR12MB4223.namprd12.prod.outlook.com (2603:10b6:208:1d3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 14:40:38 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::9b) by BN9PR03CA0746.outlook.office365.com
 (2603:10b6:408:110::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Mon,
 16 Jun 2025 14:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 14:40:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 09:40:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 09:40:37 -0500
Received: from jessevm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 16 Jun 2025 09:40:31 -0500
From: Jesse Zhang <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <jesse.zhang@amd.com>, Jonathan Kim <jonathan.kim@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V2] drm/amdgpu: Fix SDMA UTC_L1 handling during start/stop
 sequences
Date: Mon, 16 Jun 2025 22:40:30 +0800
Message-ID: <20250616144030.3497914-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|MN2PR12MB4223:EE_
X-MS-Office365-Filtering-Correlation-Id: 813e2e19-52a9-4603-a9a5-08ddace3c311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N3fr2YXibpdA9UREBrr1T+4UbMrjAwGPhabf8dw/+YKOrA/P/c34/qvRPj9h?=
 =?us-ascii?Q?jLNsB7YNeRTWmGxq9iVgduHed2D6ZhIeXxsqfv+ZcWJTlcs0YuQNtiHKPa1E?=
 =?us-ascii?Q?Gz/67jge4bWyaFOjam2SRoFAxLG1rlehziXCYq8Ie2N45pudjoP8sxzmVyqC?=
 =?us-ascii?Q?fSyqj68A05eRAs0KnEh2CVJNLPpDhYZKDz3HVKWwZCnDyqtLLzlt/L4MSEli?=
 =?us-ascii?Q?tWwvX8MID5ZRQyUoUEHB+bWMXYFje2El8jkEg5NNK0IXrEA00g6Si6uQzx2D?=
 =?us-ascii?Q?RM6eRf0oipwwEHsFLJ/zmDRUfImnGkMtkfQ0/jJCjT6V97dwJZterNNNDx9l?=
 =?us-ascii?Q?2P5knRaOM+1OBw03ItTQRJtGdvKpsLJ2u5MYaC4vVralODKozlrp5P1de9OL?=
 =?us-ascii?Q?4+FbIuy6G7EfoDmp7h6q2sEnGl2owOFQZNX8O9HFc4mLKTjoOXBdj/1ZdYiv?=
 =?us-ascii?Q?NFbqE8iXoAb6xBolBjK+1IVmZ8ID/TB1eVWXI/z8IxryhSKq78nmkJ7PaASl?=
 =?us-ascii?Q?XKwbs4hRDvbgxTIjpK7C+nsLIP5fyPxou9zvTlTl0UDehfRUm7N/JlAY6vZ/?=
 =?us-ascii?Q?PNrudjhQf7JtJ80vihdN2sk+XGp7gAA1geHGQxTRzTVgQlYawKOftzE8RxTY?=
 =?us-ascii?Q?F3QnPKGidPHQbLw6jUIQa4OXmAKsw0kGOTNfKqXSq7u76mnTvvOBFdyQpJwR?=
 =?us-ascii?Q?/PKT8xG1yaHil0mFepAhLjA9IVXwR4n57neBmUi2U+Hkc0imC8cbCBs+30rt?=
 =?us-ascii?Q?Fa21cwxtIaH6qFGBw1NpgsPNs/3d0dcfh86ylmkawLpO5cDRs1jglqdaa/JJ?=
 =?us-ascii?Q?EBv5s6bB5NgjO5lcSoD9cI24jw3YM4WVrngobSjlDyB9An4WPN5p3OfzqbMz?=
 =?us-ascii?Q?ojc4JAIAWMiRbhrmcEaYvOtbaiD22EBu6JAVBiCMpJ5souBGD5HDRdM8Lhkh?=
 =?us-ascii?Q?NAbxtKPzZVzMr0zLbG8Pb8l6EJoPKGp4iLTQAXqI+a74AjvFdU8/GIRyWzST?=
 =?us-ascii?Q?sNs53eqMPz8hp9VPrAocv5/8NJOgSitOG0kRGaD3CIe5Bq9v9XpwCOMJyr8K?=
 =?us-ascii?Q?jpZyZY8sdB3xMRCQa34eZFjGLBQLtKkzs+w1+CjDUjr99GAaYW6X7tfWKFhn?=
 =?us-ascii?Q?8dbySqbfCHfue3xHZc2TAHWuuysVMRbfltOZFZ2mLZHBWCXpvSxjSnRbjAmx?=
 =?us-ascii?Q?poo9ObTmzIRCqNZDwxrm8pSorXw/W8G/TG8FOwJ5KbaQPG+ADWMj77fdn0i+?=
 =?us-ascii?Q?9VblsWK5uC4E48ciUtXiI4AOYHhZRsdHqUr3NVbHtmSl5N1oMnXZO3V4A/qO?=
 =?us-ascii?Q?+CG2L9pryXhMFe5GXWF/jnhlivB/TzMGs6mABtxcEU8+WsbeS5Wj+Xs1JJsS?=
 =?us-ascii?Q?gdSLfq9SA1dwh3KGc3KjQHbD1V7kbH4i14+JiUtB7cv/WywLPMvCs2z42WQN?=
 =?us-ascii?Q?UrOqPYOz/mhxsQQCsahuPISgxi2efXXAPe4cj2M2PzMrXfL/xSS52sKPKkje?=
 =?us-ascii?Q?DcrCzPcDnpRhSZXh8kIbkSbt+Q91sP9Bsbvl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 14:40:38.6311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 813e2e19-52a9-4603-a9a5-08ddace3c311
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4223
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

This commit makes two key fixes to SDMA v4.4.2 handling:

1. disable UTC_L1 in sdma_cntl register when stopping SDMA engines
   by reading the current value before modifying UTC_L1_ENABLE bit.

2. Ensure UTC_L1_ENABLE is consistently managed by:
   - Adding the missing register write when enabling UTC_L1 during start
   - Keeping UTC_L1 enabled by default as per hardware requirements

Fixes the commit 7f03b1d14d51 ("drm/amdgpu:
Remove sdma halt/unhalt during frontdoor load") by maintaining proper
SDMA controller state during initialization sequences.

v2: Correct SDMA_CNTL setting (Philip)

Suggested-by: Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index e6af50c947a1..52157acab55a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -492,7 +492,7 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 {
 	struct amdgpu_ring *sdma[AMDGPU_MAX_SDMA_INSTANCES];
 	u32 doorbell_offset, doorbell;
-	u32 rb_cntl, ib_cntl;
+	u32 rb_cntl, ib_cntl, sdma_cntl;
 	int i;
 
 	for_each_inst(i, inst_mask) {
@@ -504,6 +504,9 @@ static void sdma_v4_4_2_inst_gfx_stop(struct amdgpu_device *adev,
 		ib_cntl = RREG32_SDMA(i, regSDMA_GFX_IB_CNTL);
 		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA_GFX_IB_CNTL, IB_ENABLE, 0);
 		WREG32_SDMA(i, regSDMA_GFX_IB_CNTL, ib_cntl);
+		sdma_cntl = RREG32_SDMA(i, SDMA_CNTL);
+		sdma_cntl = REG_SET_FIELD(sdma_cntl, SDMA_CNTL, UTC_L1_ENABLE, 0);
+		WREG32_SDMA(i, regSDMA_CNTL, sdma_cntl);
 
 		if (sdma[i]->use_doorbell) {
 			doorbell = RREG32_SDMA(i, regSDMA_GFX_DOORBELL);
@@ -997,6 +1000,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 		/* set utc l1 enable flag always to 1 */
 		temp = RREG32_SDMA(i, regSDMA_CNTL);
 		temp = REG_SET_FIELD(temp, SDMA_CNTL, UTC_L1_ENABLE, 1);
+		WREG32_SDMA(i, regSDMA_CNTL, temp);
 
 		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) < IP_VERSION(4, 4, 5)) {
 			/* enable context empty interrupt during initialization */
-- 
2.34.1

