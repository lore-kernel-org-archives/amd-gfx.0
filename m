Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEC0AC369C2
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CC1710E7C4;
	Tue, 15 Apr 2025 14:59:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V8RGICAG";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3A6810E7BF
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0w9ay4ZX2wcDxJX7TatDouUN0aBp356iJ5E/0je/LLLgMrdI8+9z/MoaXAiUctDydNM0fpdVjL56bzhO1AINsgges6Ij0xH6GkOV5Gj6Q0DmV3aFS4VgiM3/h4sm2DPvMl1E1LV3krg3lv7W5Qw8ZMPALiCe4yEL9B2GEwuHPLI1FaPwtksNAlXhOU5qc3ex5cex7eDniv2L9x8wqyHRBaYqkdkaukeWolj6b8ILP3Dbh9CH1XKjaq7+mN6FdcLd88xth2pLN9eihyApQYfEBZA9s4ab3j2ltnw/+RLnI2dOTks2Zx3F77NlX0fYwkSaT2c/oDwbMkkp7RhWTt4Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHeoKUO/NPwsEFneuegOkebN8TywzkX62fqG9fQEx2I=;
 b=t6zDGkquk9N0TpnF9qPoKTWUxdx7UQkpKgM6iGHeOSNcl1bwsEwRiV1AH+VeiVGt1a/a4+0DgmZKFn8Mr9czvnk2S5djfJmvacNZQy4NncQ32YB7UtjHMxW4gp//EyPXkpVrftmmwDJdSNG3iQnXN0pvZRiTVlkD8UsolDRsZzJt1mG9T7phvjDsoA/HqsxezS7SgcNPs9chUdfcJqgvS389cquUUPOnHtvdeGmevhE903uLGYOTHti6MHtUi2OjT2LcDwXQCZ+dz/YimH4iun3Vh9Rsu5pgxbPBYi/i88l/Ye5CquunlOzoaGDZfRc8qgDY4VELA+Z5MEBwo1d2pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHeoKUO/NPwsEFneuegOkebN8TywzkX62fqG9fQEx2I=;
 b=V8RGICAGFfMSMLEUR4MkN+SddG/8DDTUL/JugzyUrriD7Q/JAB8uiBR3TyhIaIykgbFbwWVLlYbxDgfGJOaYd6ZvJ6WsaAHZLyAfklbf30T743J6Wg+J8350RYVl0XHBWwPktd+U8jvGzR44c8K/+wEIpvJp5o3mmNeUGjPI0ec=
Received: from SN6PR05CA0022.namprd05.prod.outlook.com (2603:10b6:805:de::35)
 by IA0PPFB6B4D32F9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 14:59:49 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:805:de:cafe::b9) by SN6PR05CA0022.outlook.office365.com
 (2603:10b6:805:de::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.12 via Frontend Transport; Tue,
 15 Apr 2025 14:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:48 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:46 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, "Nicholas
 Susanto" <nsusanto@amd.com>, Charlene Liu <charlene.liu@amd.com>
Subject: [PATCH 10/22] drm/amd/display: Enable urgent latency adjustment on
 DCN35
Date: Tue, 15 Apr 2025 10:58:56 -0400
Message-ID: <20250415145908.3790253-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|IA0PPFB6B4D32F9:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ee75135-5678-40c6-07f3-08dd7c2e2afc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SWMamvNm7ivgOEdoEcp4dpqLohzD8lgkxIFotlcDHac1K9SEXqZutBCIyKMF?=
 =?us-ascii?Q?GOdycxivZrnWXRj46uRq/JKWROqC/IJ3ePJZ2HZ0YvnbaRTvz7vezdv/6TSD?=
 =?us-ascii?Q?paRMrdX3BD4uT+Kq21+BnW6x9UMPvsg/8TN8AH2+9FIG1ypU1obp/ogviY8J?=
 =?us-ascii?Q?05r4cGdvpunQ1Faba4egOLbPZIWxKk2sfVFhYgn1Kee+maExFLF4CfyT8noQ?=
 =?us-ascii?Q?0+zpMQP3gXwnYZ6JKn0NRCghBo3wg5XmFXK2Xd+rL7MeYrNmyhX5erp+OxFT?=
 =?us-ascii?Q?Q5SMM3mizwlY3vt0dWZrk+kGerTi63k/ivUXgCpiuUVQJjCoduUdSw2OHnKP?=
 =?us-ascii?Q?/A/NOSw6MSE/C4TCR6mTCfCD+yROT5mnGfzYNhRF/4h4MowykW6ncnnim/Iz?=
 =?us-ascii?Q?7IxBkTm8x/y0g2ceU5Z16mhbCvstKZD/UvjEK6JyNT6qd83CIkCdCYt0X1t1?=
 =?us-ascii?Q?z8OZuxxxtOsuiTOKYnif2t3PTOay8oCmpE2vm5PjB3AS6TX9jBKlNDzi52AL?=
 =?us-ascii?Q?6Nj59HMFLAn85HlkHaAWUK1LvRd5YsOvv/5DdvB7UDMhCCpEq9JrHbbClg7u?=
 =?us-ascii?Q?ljtm/s46fyp3yh3wTW3ufXe1TvY/njn4aaqMzLGmpqDDew3kMONmHUNVDJHn?=
 =?us-ascii?Q?1R/d73r159gaVDYKk5CVR1IpOIYxQCPpHGObSS1WiyqbATVSXlNpDK3dFK7b?=
 =?us-ascii?Q?tm6tnHbwdSzBoaHniFzQOjYZNZ4ZDRe8oHkvTix+a5cMgCQQN8yGSJ9Q1/XC?=
 =?us-ascii?Q?9fz35Lt0pSkZ/uT+Ylj9sJxD2L1Gy44vBl89Tve5GcZ2+YBxC/IVeYIOj34i?=
 =?us-ascii?Q?jXjVZe1b1gIGS9RutQtPQQx4SFvi8M0kkzkdp873RGyFycrQRYOSydjCosdW?=
 =?us-ascii?Q?Rs++F5X2AU0y4T0Hb27VFC0qSmL9z7RWtIUV5OoDfC05MEX33zb00RxP4A2G?=
 =?us-ascii?Q?OxPUShBeWzU6FaNtbFIYkPBfDR0VpPg2PYxozzeKO1kie2v/IVCZY/NxwvpS?=
 =?us-ascii?Q?MGFNT33C4/UNNuS1IV51mCt66k2gWG4OmEGE6NNj8vd50HwE4l7UaVoAgTzV?=
 =?us-ascii?Q?PVe3qhW7VxW1k962BmxCvUWYlw7VNqtp9hp+FhVsjWuqScV8PjE8GVzB69Vq?=
 =?us-ascii?Q?6sB20nEjjS4QYhAKDAu827V9uZyFVyWJBn1rt8vM2YnxWOMLxJnCN84QfX97?=
 =?us-ascii?Q?ORw/ShwlskTDw0FW5fgHE7LCF1yO3JGl+3M6VVmiYjEenIOlls8Zfo0uifH+?=
 =?us-ascii?Q?6CeHQcKOBBN38y9POzpksHYf0SSgsaBAIj6Br/JdKifyUkETPKeyf6zu3MIx?=
 =?us-ascii?Q?7ozH85n5DTlcsFcKNt2WWzkv/lv6lG07Ii/Tk9u+V8FXc1rIsMQaAivFUxdd?=
 =?us-ascii?Q?kXx2jvyPYJDeHAAiZD2UD7gqItCYpxVbU0L3RC9qd6pgsBqjAfHMMCvungn4?=
 =?us-ascii?Q?8FD4LR3l1IPMLpSagV0YRDQD5nFahHRGIZKt8CzeRzuB22sJcSS0NrJm7tQp?=
 =?us-ascii?Q?GebLE/VycWdkXZyqSNtHaRyh1VjbqAREBC6o?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:48.7509 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ee75135-5678-40c6-07f3-08dd7c2e2afc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFB6B4D32F9
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

From: Nicholas Susanto <nsusanto@amd.com>

[Why]

Urgent latency adjustment was disabled on DCN35 due to issues with P0
enablement on some platforms. Without urgent latency, underflows occur
when doing certain high timing configurations. After testing, we found
that reenabling urgent latency didn't reintroduce p0 support on multiple
platforms.

[How]

renable urgent latency on DCN35 and setting it to 3000 Mhz.

This reverts commit 3412860cc4c0c484f53f91b371483e6e4440c3e5.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Nicholas Susanto <nsusanto@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 92f0a099d089..d9159ca55412 100644
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
2.34.1

