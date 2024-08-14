Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCA2AC52D7B
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Aug 2024 14:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF7F10E4BF;
	Wed, 14 Aug 2024 14:43:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fwL91Ik3";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701DF10E4BF
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Aug 2024 14:43:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QvhMNM6bKDzxoKq9TfnHZgXqC5NXMaRzCDTSbzqBbUvoAaY5DFX2gFWwcUyKGtjRuzPEZocP5Gxdh0XgivKGQo/OODyERn/DGvsevUdiOttAb5xY4gQGhOWlWHg2wRdj52BSKP04H8Uf0A6qu+zJdhFwwb/9pgkbmV+8hDh/ykcI3kpVurkICHCc3QWUxNxslIBhQP8pOzyP11Yf+/WPCSPTKt+YkwRhJc5BglmUP8jr7lW9jTF5/FColfXkDTrmqo79oCaS+RKNuwy26dbiG8H7RW1x6IXCZhc3nPH0qvS0OcXqLYBZor1JbjBMaRdfHoP7XdGcogInNQeRcxEayA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgtMc6wsLhH5NtcvOIoL4g3Cwh6xpTWrxaQVgtBJTlA=;
 b=do65YyUx13jdg/HmLT7mMep4ZYlDm32M5i3R1tizsZRfWtil4vlnOYVirRFapEjjspUW/5YYwWnkDteV6F0sQvh1a3DC0xPhjFIRD3wzVnqe7GWNTx4bs08OdJ1ZOfU2Ck0RAMlSAsRnOjBTT6+qxIKmfGXJ+4vRJNkfLQcPx53aVO0P6x5FyM/UWF4s9qx6XzBjDmy0tmWi3BbHigAnjS4xP5IUk6b1hKrpvesDzhs+JIURhgQhUWmQiTVVtWAfXUznf7XEY8FHxyCueGGtGfNqSg99aMylVIciSTNiV/A9zGODWcxwtXQcBBxMtaxo6xc47EPjkcG2PHPoSJvFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgtMc6wsLhH5NtcvOIoL4g3Cwh6xpTWrxaQVgtBJTlA=;
 b=fwL91Ik3SpDJ32uwfLBuBZgZWML2U0mdD/6PM6FMim1iWHHZi4+QhxpDAWxjU6TZYwuuLhxY80W5FddyrFJJFwEsrfGnORVAefwbQ3ux6ca89BCdEHWBNG8GMiGHpsukZL9Ca1aZPKQ2TJ3OJp4Mzmp5s4Lyd/hW3EQCmVoN1Xs=
Received: from MW4PR04CA0125.namprd04.prod.outlook.com (2603:10b6:303:84::10)
 by SN7PR12MB7153.namprd12.prod.outlook.com (2603:10b6:806:2a4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 14:43:27 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::21) by MW4PR04CA0125.outlook.office365.com
 (2603:10b6:303:84::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 14:43:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 14 Aug 2024 14:43:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 09:43:25 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/sdma5.2: limit wptr workaround to sdma 5.2.1
Date: Wed, 14 Aug 2024 10:43:13 -0400
Message-ID: <20240814144313.711802-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|SN7PR12MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: bb120b0c-e712-47ce-a195-08dcbc6f7503
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dDbYzxNyizEvARSoK32y7n9Yzzx4LqE9b23v4Tg0vj2j1jFmEEJ6UxQH8aSe?=
 =?us-ascii?Q?baMXetqphk9FStMKpw7FeJp16C0UJPe59Hx9omvf3chUu8makbGn1ESwCG1n?=
 =?us-ascii?Q?yNjWyo5jvry37hAzl7M+JaG1XO5mS/tfgLKAbkqk6JHwaHFGjrFp1IXWYfZF?=
 =?us-ascii?Q?EeF4Opa368Y/07ihcXmSXo4YWsFTQPbbNEpozhbXb7jGBIXfMoc/A8UfJVMA?=
 =?us-ascii?Q?5vCEFC8Bamix6b+niekhItJuPLCjakkQVzvSH+hzZl2BYJHlDK8AfrHcKDIm?=
 =?us-ascii?Q?p0yb561OFPK4973Jqikq5egOKl4y3BWpprDxU0sbwbT4BuKeMHnYCJ72+3sN?=
 =?us-ascii?Q?s64PMN5GjswNOAxe6nLEyLO5tX8LAVFxJmCq+1jE4q61zrRnUSDvhJO57hwB?=
 =?us-ascii?Q?sS1qloVZhFGiQhKSols+qolCoJLojLW26HNsHajPyVEh9KS3XbToxNYQ7ZWE?=
 =?us-ascii?Q?nllkgshfE8LLUK8fo1mIC/w++aIAzSUxlckECVDGimEOz6RY/ggS2IVQdpDf?=
 =?us-ascii?Q?Y3edA8vhlwLnQyHE/7vOgeGfuiHNara2mMxmlltOVIAsIGKAUwB8fWBeAMNG?=
 =?us-ascii?Q?5SQyRaTDG/jfavSxfRzAGlu4VJBhCsjCVwcp1Ss4LKqCyAP+djv+IOU3pJcK?=
 =?us-ascii?Q?ZPJAskXSt67O4wf8DAh82xuYpzLM5G3XtyL/KaZYMzAdAvGL0ewYr2qSQ4zF?=
 =?us-ascii?Q?VFM8ABK4rclZKUKC/+0NK9ZawzGz8dsbl3EmH3bfbOzaosagZOC7wkIny783?=
 =?us-ascii?Q?wvLXseRH1YLB9TnF0yJOHVYFI2GEMb+l9hY95EJ9SeOs9jxO/WMkD7UDhzmk?=
 =?us-ascii?Q?HWOI3w2jcYgIaxBKND6dYIOKoIc9Zm/3XqKnr/bwxYk6f4CHI0FXRNV8DSDp?=
 =?us-ascii?Q?yEcRYP8cX13dVhgAp4KuknvzvNot11RVwWrLZUyvBuxe9vC/jOYUxEcX4+qR?=
 =?us-ascii?Q?NSfOiiGqdkMvXO/tP8eIED65kD1FYluUf4sqF27sjOvcIuL0gZukxICsGgDt?=
 =?us-ascii?Q?Yj0aLdqYEAVVJRBfSMTqd0C9MM+/UCBvX528xTxCIZi5RHD+1fsK+ltNPTWz?=
 =?us-ascii?Q?+jdlBSvVR9fdbKSy+hbYb5VhzklwWYp6CQC6nO5QMvpD9NbmtuQwZtBhZ6an?=
 =?us-ascii?Q?tX0lKw2Aa5uUz8F9Ww1Yb9W6lSN1U3STza7kwIKy+1/ocNUnM+/cnXY8StXa?=
 =?us-ascii?Q?QLCrNqwgfhogu3Lej5Gd6hy0o7js1WpZdjc8HksH8Q9jiHZmvuKzQPK/ICHG?=
 =?us-ascii?Q?ecmUCK4R1wbWotZtTQAqwN+HIdt0yxcBWvw6yoD6fsWeO7+eyhlJCHhHyh0C?=
 =?us-ascii?Q?C5ZGybQl/RuI7WYh49qLsD2yHN+yfUWQtA97ty5AIHg5mF25PwDk6DEAl2Mx?=
 =?us-ascii?Q?dLEfPFac90yRcObMg3cHi8igpUpM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 14:43:26.8613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb120b0c-e712-47ce-a195-08dcbc6f7503
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7153
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

The workaround seems to cause stability issues on other
SDMA 5.2.x IPs.

Fixes: a03ebf116303 ("drm/amdgpu/sdma5.2: Update wptr registers as well as doorbell")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3556
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index d740255edf5a..bc9b240a3488 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -225,14 +225,16 @@ static void sdma_v5_2_ring_set_wptr(struct amdgpu_ring *ring)
 		DRM_DEBUG("calling WDOORBELL64(0x%08x, 0x%016llx)\n",
 				ring->doorbell_index, ring->wptr << 2);
 		WDOORBELL64(ring->doorbell_index, ring->wptr << 2);
-		/* SDMA seems to miss doorbells sometimes when powergating kicks in.
-		 * Updating the wptr directly will wake it. This is only safe because
-		 * we disallow gfxoff in begin_use() and then allow it again in end_use().
-		 */
-		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
-		       lower_32_bits(ring->wptr << 2));
-		WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
-		       upper_32_bits(ring->wptr << 2));
+		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(5, 2, 1)) {
+			/* SDMA seems to miss doorbells sometimes when powergating kicks in.
+			 * Updating the wptr directly will wake it. This is only safe because
+			 * we disallow gfxoff in begin_use() and then allow it again in end_use().
+			 */
+			WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR),
+			       lower_32_bits(ring->wptr << 2));
+			WREG32(sdma_v5_2_get_reg_offset(adev, ring->me, mmSDMA0_GFX_RB_WPTR_HI),
+			       upper_32_bits(ring->wptr << 2));
+		}
 	} else {
 		DRM_DEBUG("Not using doorbell -- "
 				"mmSDMA%i_GFX_RB_WPTR == 0x%08x "
-- 
2.46.0

