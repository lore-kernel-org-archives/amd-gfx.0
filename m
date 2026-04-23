Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9593F589D4
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 13:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28B3C10F137;
	Thu, 23 Apr 2026 13:35:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YBmEz4h6";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5BF10F137
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 13:35:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVk7L6eqPM4EDiEAt/94ntmGB7ub9tHKV33esjL3XxUk1w/DsL/NrzhzIxmkZuOhanKx3MwiosOeDRmEvH4+1S7SF+iDhtDqTKd5OJFV319Kt0c/Rys+lhtu8yPCF6hlV3Ji2jXC5Cj0RoJpPdIe7wW7mhGna/5J585fI/Cpl2w4WgsNGCz4O7MENrM4WVUW0B+r82Dk+EQhNSDlpaE3DZNN7AOQreoW25X7xiK2pORGfzxTNVtNP27tXKzd61L/16XNcIEWC/7fCenkRKdDT8grpXQ2KHCYz4BGFy6FBgWlVsmXktCVOAezFK9YaB1L3wxQSgLXe9giXSMEuyzvPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eaf+T8psP9hQkk3m0owOJJ+91WHq2qV6JT//6qAumZQ=;
 b=E6S2rXTijMxtgdzqxlvopO40Q4aQ5wui8IfI4sC2N3/QQeICWnJupyDue/eREUlm13GRfI8ZCH6QOwm664p0GMCVLsYXCItWZ1yo/SRonMzGFsd2VSOYvpCgluBEc9j4qUhQzMnb8TLcujc6P2A3pOiH/deeMimO72vsvt+mHtiUVPg+aEBMMbZhs+TfZ0qUNvxhN1EBQyQtvHENwoNBa2WqbBl+APcdhVZiKhoCWwbhdb1SjpandWRLTrBOGiw5T9GcxDkdDEXtdgThgafszVUGDee8RyajbdDgjaJEtJZVs3XiRuIf5hZK9H15gvjvJLcYCPf5txsJ+soHIdtSEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eaf+T8psP9hQkk3m0owOJJ+91WHq2qV6JT//6qAumZQ=;
 b=YBmEz4h6r9UV4NOpVok4cawJ21HtnUNv60rQGWA54DJZQMH7ZJ++En0rS/Oy9C6Fcim74hLdXT3cn39O47b4RnOYknJ63oIqy8kpnlHjZvg1DBiypktF6SJmnd4ZTrDa4vA96mYV5Wl55xeg1XKAP1XruGRgl5wY/T97Vu/pWEc=
Received: from SJ0PR03CA0192.namprd03.prod.outlook.com (2603:10b6:a03:2ef::17)
 by SJ2PR12MB8690.namprd12.prod.outlook.com (2603:10b6:a03:540::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Thu, 23 Apr
 2026 13:35:02 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::49) by SJ0PR03CA0192.outlook.office365.com
 (2603:10b6:a03:2ef::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Thu,
 23 Apr 2026 13:35:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 23 Apr 2026 13:35:02 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Apr 2026 08:34:59 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Dillon Varone <dillon.varone@amd.com>, Gaghik Khachatrian
 <gaghik.khachatrian@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH] drm/amd/display: Fix unsigned underflow in SubVP vblank
 schedulability check
Date: Thu, 23 Apr 2026 19:04:45 +0530
Message-ID: <20260423133445.2442894-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|SJ2PR12MB8690:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a166a9-12e1-491c-6019-08dea13d1f8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: YEpJ6T752oew8zOt/PZ5+xBOgCXzfDOs8lCC2/RfI0Vd+7l3N4dd2y1J8CZdlm1NtWeiLdw9e96XH7UP+x6j48LEwKr8kNXn4jDQPGv738kLo4ElyLZf6EJCs3QIvy+yv8/hsRYd2X0WNFGMnLex1v5+sOejZVYfDY1Lc/oPbBmzCVQplXng3GxuMBiw64rsbSHO8LURo+GHopTrhsWclxnJY5GIzwDyRWyGYsnQ3wsFzLRuLanp+uBMOOKZeTSOIrzcYf7EI24IwYJcVEaxrUWvlyJm18rI9EyMOMoSx9igtNBLPNkZf7DeBZIIIsmuKLkbQWqdt5MKdCq8ys5r/ALg2PXlyi1/buhA5/S7tqoZ8ahBL7whyrNhplh3ivBWHBlz2S0hQs6Gj3028X9KgNrGDL00/HaaIc4GQbnOA4RoxYl3XMRZ8noXsys57HWXVdh76VTrpmo3KC/cYXuy7iUo9ujWdogQE81P/HK6I2t7O1k8RiuCX4psCZ0GRYsmP9IQFCktpDY6keejg+7wfPcWiidUiCyRO6A1rM343A8194X7elf+WYYLFmXu3Xwosgs9SNts453a9ZFsB6/5qOMs+LRIUyVBomJl4GRlas3LmVn00EOCvcJu2QfC/BWAbKLZn49yJ0MjUn3qHCC6rcPn2FohCtp0MO79+RXS9eABCCewpLMLItKhoMsZFgyXbnk20roxJ/QH1B+JOO+Pg1B0n8aeBulZ/tY6bnALjSfDaw5qAyKqqnjVwzyXfzOiJBZDwBSBZWFpzFPy9hfU3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZwXffM/Xjyy4JN/uCDOGV3YTDIGFFcrL2/Uiqh34P/88BEB0CSVcwDWFOJzExcWmhOEpNLQtqFJ7h/dstG62VRmP0H7nfCrf7MVAHCzPJm5qf1QbVaaIYLoKwKamXoCnbxBXF6+oIaGHMgnl2lccP1TZVxC9jtHozHv7fOHLVLU2bLvkFPvv77QE07pHSEj1s9hkeVMnettpgYLhvu+/4tFdCpvvRqmhPk6yoLX4tE8EqULtNpm2q+IRnUeuARoOQkRdzsJmScZCj21Be5m1Rz1UX12d2Vk/l7wSCGhJwQLGMbr8wGOtzMNIrflvnF96TfKzNXrzSl/fzIg8OvKp8PN2xTBa9Z+Czu3x3DEN50G+Srofv2JspeXC0dfNnnIc4F8MjK9HhE8ZrXGPV1oJ7cyshdDVBPtUAQEUo4YxfbY9AcxTuLQCiJFctZcNQGiF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 13:35:02.6444 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a166a9-12e1-491c-6019-08dea13d1f8b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8690
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

subvp_vblank_schedulable() checks whether the SubVP active region can
fit the prefetch time, vblank frame time, and the larger of the vblank
blanking time and MALL region.

Commit 06503cda03a3 ("drm/amd/display: Fix dml2_0 narrowing boundaries")
changed the intermediate timing variables from u16 to u32. After that
change, the schedulability test:

	subvp_active_us - prefetch_us - vblank_frame_us -
	max_vblank_mallregion > 0

is evaluated in unsigned arithmetic. If the required time exceeds the
available active time, the subtraction can underflow and wrap, producing
a large positive value instead of a negative result.

Fix this by comparing the available time against the required time
directly, using u64 for the accumulated required duration.

Fixes: 06503cda03a3 ("drm/amd/display: Fix dml2_0 narrowing boundaries")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Gaghik Khachatrian <gaghik.khachatrian@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
index fe667aea6ec8..3213914f2840 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_mall_phantom.c
@@ -532,6 +532,7 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 	uint32_t subvp_active_us = 0;
 	uint32_t vblank_blank_us = 0;
 	uint32_t max_vblank_mallregion = 0;
+	u64 required_us = 0;
 	struct dc_crtc_timing *main_timing = NULL;
 	struct dc_crtc_timing *phantom_timing = NULL;
 	struct dc_crtc_timing *vblank_timing = NULL;
@@ -598,7 +599,9 @@ static bool subvp_vblank_schedulable(struct dml2_context *ctx, struct dc_state *
 		// Schedulable if VACTIVE region of the SubVP pipe can fit the MALL prefetch, VBLANK frame time,
 		// and the max of (VBLANK blanking time, MALL region)
 		// TODO: Possibly add some margin (i.e. the below conditions should be [...] > X instead of [...] > 0)
-		if (subvp_active_us - prefetch_us - vblank_frame_us - max_vblank_mallregion > 0)
+		required_us = (u64)prefetch_us + vblank_frame_us + max_vblank_mallregion;
+
+		if ((u64)subvp_active_us > required_us)
 			schedulable = true;
 	}
 	return schedulable;
-- 
2.34.1

