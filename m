Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED0C4C54E58
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 09:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B4A9112BB0;
	Tue, 12 Mar 2024 09:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bBxIc+uu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2056.outbound.protection.outlook.com [40.107.223.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F407B112B9C
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 09:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ac+OHf/RnMMLgR2DojEZr2Wm7wU5zdLHQRdJinVMR8OmmgNF0OK2cRdP3J5pj0BfBtUkZ08zM0Qz4i0I47vVYqmn6T9FDZaXy5CGg0ck7atL+UO3jX/rJN9yjOGSZ2AZII6q5/53ILUHH42oUC0hNJZOJSN9MAGcC8SBUnzpPpfGlknzu8nxa2taqiZsZ0f/IvDdz+HmKDx4h9NdqxYsi4q793JsKqhGeh8Ao3GyAsRVksJZ+jMytCPofhVWlJbMVlGVjUpUFX2Zh58hZVaTZWKkjeN/91Pn9dRpvnkbA3seGBrmIfJ+G78vUB4az7XmwdYIjhhEOMk3B2dJ4VresA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeEwH61QSCJrCA9n12hElk61jZH2AOFHI+cQVIZc5Us=;
 b=RahhxzWEWIxlDROKzGWAQL28aXSwtveEyUdPf2IcenQ5T4lc1jNoaTSAuDTyCYoTuifOU4a6che9PnMzwkQRWVKT22wqePggsIRTrbIeIP7XQqSyZ1yJI5IcPIf9RMKbshaNnzpREGF3u0YntDMZymGOitCQRc++5WDgh4FIX8xF10JNLIjqy7C/Grr3vlZopZcMUS6sBIigmGxQqv0+ajqY0PTCF0Z6fYGz045VUsJTbPCzixjhbNYmuf+jOSFQhQCZt7uFSsZYjZoxsvBIFt6jrABmAM1cpz+TmGKSJbJstzmls1TxVxJ3B+UZRv0buA1DxhoPmlxK2iJZulh8Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeEwH61QSCJrCA9n12hElk61jZH2AOFHI+cQVIZc5Us=;
 b=bBxIc+uuIvygeesGnDK2nalzDJYMmL9Iy28SIXqd0wyzcPIjk2JM5Ktlyz1LGL4vD1lI4/Q3rHaB35qy73Lr4IC1kmK6SH9hGp+YJeKeOlsqTyTVxN1kNq+yEnjrUpDnYvwoogqzV5YWb5hiIRhgPLti3xUY8LPYKxU7Z2gJfR4=
Received: from CH2PR15CA0010.namprd15.prod.outlook.com (2603:10b6:610:51::20)
 by PH7PR12MB6667.namprd12.prod.outlook.com (2603:10b6:510:1a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Tue, 12 Mar
 2024 09:22:55 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::60) by CH2PR15CA0010.outlook.office365.com
 (2603:10b6:610:51::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18 via Frontend
 Transport; Tue, 12 Mar 2024 09:22:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 09:22:54 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 04:22:54 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 04:22:49 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Nicholas Susanto
 <nicholas.susanto@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 19/43] drm/amd/display: Enabling urgent latency adjustment for
 DCN35
Date: Tue, 12 Mar 2024 17:20:12 +0800
Message-ID: <20240312092036.3283319-20-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|PH7PR12MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: f87fe07f-634b-4e3e-a974-08dc4275ffd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJXWhUPIUwvoIy1Od4ek1kBSucqAYWuJpasrC0401h9IWVW3k/yKwmOGQo4NA0uWIXReOrBPvZlsJeZ8X7DHvW9ItkqFXEN5MtOcaFt5C8dwCYtKWeWiumA2wqzZXVosZbHmFSdwX0UPqlTvsZ03pcKgm4RhBG4Eg3Ffzw/YX9++69Z64/QzSyD+hsve2XoUC5dXkIm10TWToPX0WwygnCpfmDdsYTV3BFiIJVBz+PNVQkPoVjGz6px/yJWlWQnttgtRLZdBDFlcshl1luL5rbjVM06HvNFOVm+SuVB0LY0y+hPmWm17V/V6Ek34GYDCq7pjM62IHFAEyq+IEFE7tBDiaHNUvvqDi0j/SK3vMnwzehElPdOHasr12uB9ZRVNRw8hgdjOOZ4nAYA2CHt3lR2l8IPARfnCjBHM9XTNGnE0O3IITO4+jwX7BLhekRyO9zx0zw3gjh4vC7EG2IH3sCGR0smqf1IjHZhtqDFqFdTkTafOMkblc6hAnUIiCzyoR+xr0r1i0AK5Rrcm4692r/+hQ5HxqdKGZwhXjS+6rkxakb8A7mDTCFPjfWJbwPCDPfqct+cd+ak8+zm0pqPrQ+o2gV3noC2l7aJHs81bhivXNAQ2TZvBwIqJwJVifUMMpPaM/XCP0tG/g2mHSKftiKIbJ8UnmQ/k1rnDbsoWUm9uYg/0BVgjJCiXDL4d8ZFeezxvuikUrWQSnxbQQHhO/K37vPNC+7l+HSLu8XujDB9lIcASZF2P0blY2dRr0E4W
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 09:22:54.9720 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f87fe07f-634b-4e3e-a974-08dc4275ffd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6667
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

From: Nicholas Susanto <nicholas.susanto@amd.com>

[Why]

Underflow occurs when running netflix in a 4k144 eDP + 4k60 setup.
Increasing DCFCLK or urgent latency watermark fixes the issue. Implementing
this workaround for now while we figure out why this is happenning in DCN.

[How]

Enable urgent latency adjustment and match the reference to existing ASIC
that also see increased latency at low FCLK.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 80bebfc268db..4d7bcda8ef72 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -195,9 +195,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 	.dcn_downspread_percent = 0.5,
 	.gpuvm_min_page_size_bytes = 4096,
 	.hostvm_min_page_size_bytes = 4096,
-	.do_urgent_latency_adjustment = 0,
+	.do_urgent_latency_adjustment = 1,
 	.urgent_latency_adjustment_fabric_clock_component_us = 0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 3000,
 };
 
 void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
-- 
2.37.3

