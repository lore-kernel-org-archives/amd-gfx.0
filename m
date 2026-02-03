Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B352DE8783D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45CC310E6A9;
	Tue,  3 Feb 2026 15:13:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zTj3FH1b";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013032.outbound.protection.outlook.com
 [40.93.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 03ED310E6A9
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6a6aKGJtSorv54Ll5abYvKeI2n1d0JVjG23PJQ391nq4/36iBJD4WQeW6zeJzSChmRxfd4PzBHILHrRLo1VTo1/ZzKQTqUXZXTRq0amgxNgqEWMjlFR8mblHdz0tykLKzD2H2eehab1Jhsg7Gk32oqrIw8Fu8syNma/zd9uYlWdK6LTUebZDgZu/GxfPPmpP/SEauNLwjbKOLA1LBR94iLYXU1HT0MO614B+3rEIVIFRm5Y2TR6DG8t+P56u1bPow/QsiYgnVI5ooNNtKi0XmXU6iz8mjVmq1mJ7NNJ/0xNqMkVxCRAJFcFxE618jPl311nMaBMl7K8q6Y+xbOZcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kPnY+6bXrzx4WBDcp3FX1YlhWCENqMBjn/aRA984oDY=;
 b=Q8pf7tex0xouyiD1AOuSTZwLbo5OjSVl+f46NLpd4vaz4NjJ1l+mgtAYFfuN+2N0kLDX9Yv4Rom9yD3cKbyTBr/D6VXvBaoJHG7z+Wu4fm8zKmtEG3Z8EyurJiiByLjzGNNqNdHBYKZrX0cfUvcUBLd9httsHBKUfOl47T1IUq+rtYBRaFBjqYyLQ1hXOdBN2xq9OB+fifIoDOPbWwpufuJI7ZcZPD3Q9nndfa9LG1u5dzFionpV+3KOgUua8fHhUBbu9rUE0z4hMwzau1BE5GFOIqZn8sUiktj2dRBqQjnGZaXrkDjW96j/pjDf4CaMnk4+HT3tCQRYO1LRzTWIUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kPnY+6bXrzx4WBDcp3FX1YlhWCENqMBjn/aRA984oDY=;
 b=zTj3FH1bU60OmQh9ejFXwMx7XShll25PCkM5Xm1KOay3e2nrzXXwL+mWSBsMowy7uxUKamxLUQ/LFHsweWSBwsuT2qtmli+XP4Y9vDwPwSQSM/vKaYuRvlmqiOUzwcOWtTztrVP7x/08RuyR+VxkJoEpl9CHlFPuZM2XGhTIM9M=
Received: from BYAPR11CA0077.namprd11.prod.outlook.com (2603:10b6:a03:f4::18)
 by SJ2PR12MB9211.namprd12.prod.outlook.com (2603:10b6:a03:55e::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:25 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:f4:cafe::18) by BYAPR11CA0077.outlook.office365.com
 (2603:10b6:a03:f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:13:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:25 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:15 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 09:13:15 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:11 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [PATCH 06/16] drm/amd/display: Increase DCN35 SR enter/exit latency
Date: Tue, 3 Feb 2026 23:01:48 +0800
Message-ID: <20260203151229.3673042-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
References: <20260203151229.3673042-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|SJ2PR12MB9211:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dbd204e-d266-43aa-ef88-08de6336c779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s2or3kso9pDBy9+SMU2/LCLQGRN6vbdf//5zH4VinY1PQ7rxTjxC7wwV1sD1?=
 =?us-ascii?Q?bMQ1/5U046u06yok3AQLtLapGHa1GkQepXwRw6bTAWeu0kATitM+1Z+2r8Ul?=
 =?us-ascii?Q?/EJt+pg6Kc2ZZlZObQZiUJw9sXL24Frj0TRCgBXDo+0f6mfik134ANiZRRIB?=
 =?us-ascii?Q?3FeaqSsrnxK2Hd+hXGpoz1O9NIWfRB4YqK2Hcs+RPbPHsryiyJxgEfJtnnE6?=
 =?us-ascii?Q?KVESLLfDM6VjBJ6zW7U4RGFQKQJgalg+zu+9czjiKe4x2TBuBuvWIkcBQmqt?=
 =?us-ascii?Q?/Esg7ft2PDIa934rx+xfGRdd7yVgbQZhk04ZVaYr82E6So44NKBSPpNMFTGC?=
 =?us-ascii?Q?Pv35XouCiFkAkQKMaoky6Kzkb1JmZoOM4M9F5dnhM8IvjdcMqO05w+8ndVjz?=
 =?us-ascii?Q?7GVTkDJ9k4neb5fGdDmXaLXIXsg9XiAi6uHo0hDzHjMELogXLy3ZJbr4WltY?=
 =?us-ascii?Q?pBu7SnBOYn4ZZlSAXjzqj14etvhST16kEwSYgmMHW3pO4SWpWjJNEBflDcIs?=
 =?us-ascii?Q?L1UPbhAIxOv6LHWyyCrEPkl9x8J9oDOodYSYI+kjKClQbGVVcFg0Wknkf1fR?=
 =?us-ascii?Q?Avy8jQ24iduyQhNpqAcwT+RN6uJAiCzKyGxhAmikmPulw3u5cfSupZtOVl80?=
 =?us-ascii?Q?fTj/w89DSCby1Bc5XELaWwjXMu+kubIITEMw/sCh7pmq8em0qp58amBekCfu?=
 =?us-ascii?Q?eN4BCVIy49zgjLVhAViYvRqQrfvrRRrijk8D/mgiR3rJdHHftCoOERwdfWPB?=
 =?us-ascii?Q?My8r4dTcuqZi3zv2VAS7mp98lg1sEYj54A8f1+gr3iqshCwqeeBG1vSoPonP?=
 =?us-ascii?Q?fVjH8zBnZmOPY/vwZR5Le8UQFQMGk0TMe0Ocr5r/sNYeBCykjDUxLC9I6uXm?=
 =?us-ascii?Q?bZ8Q6zebCJx/4qK+7wlYBtYwb1T7v62hF0xHRNlMNKGw2Z2BMW2I0oEYEpgv?=
 =?us-ascii?Q?CZoT0lTo9khdI4oI1e87FrJ1yTZekUN+EHETcJHEjUpWnpHCPzJDHh5B1C17?=
 =?us-ascii?Q?Ac/UyYP7vkBq2pRfRvH7VxslCo0n9SHs7lDEfbczMmWmsvh7pmnA6DSZVlQd?=
 =?us-ascii?Q?n0fOkX36jzZ70O79R1aF/2gj2JzLGlDRlJFmfebmr1G6dqwJgFDQCFhOKH49?=
 =?us-ascii?Q?SMmVdv1CHsGgk+HnsGh8ttyJbuMpIQNFRt44+GZSTpXK7wuIwbNfVkPULo2u?=
 =?us-ascii?Q?yQiBG0xkcrR+Cm/GMVcLtgGGp3K4Afr6hQDgA/YafXymdKGwQVwNACBkjng4?=
 =?us-ascii?Q?WhWQ3oawr2yyQpFBVHMi9rujIWshu8SalPR6Z2tgkQuzt00haj9oteqwiRPe?=
 =?us-ascii?Q?1ODTdVjb2xIwEmpWTCJPH8vFAfPNF3IZotoS6jQpL08/ShqvVWC2bB3ITG1Q?=
 =?us-ascii?Q?cibxwEMt8DuwUtZPQc7PxEOgBPLffELmEwK1jy+Zn00mLLnk5BFyFCiUpHyt?=
 =?us-ascii?Q?psJCcCzu9qkmbXv90/72pqT/AlAaygNhX2Qz6bkac8/x3cJwQgJgXSbEa2g5?=
 =?us-ascii?Q?ppySS6CdxwfHIeNgfaGBpzpllKLiW58WwyYBWK/bcEOlO+uqPymhK9Taac1N?=
 =?us-ascii?Q?Wk613vPq6/AVKi+lXmb9cPLXjYuzUR0q3YV+ZddXd6k93LVAVUoK7OwZrlgE?=
 =?us-ascii?Q?4Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7cbd/sWMWZpivQSztn4g3h1SOr53cCwJjiZAQnVC11blTGepUO6s8VDmVFBI3+t8mI29QBHjcmFjxkPzf3GPYfwvf+MroTXgmBrdvYQR43lz9CHVvfTzpZJhvP+MoDPi4TTKubEqBG4YSynSpJeVDsB3E9yPXx+ZflEciwYOE2DK2u25p89Yw2ma0wAKbq1c770PzJuSDUD1Gx/mamK73LC363ItF/zFqEPU+8YX0pTbTzdBjfbi/ICMsSMay2TjbCUU6crVV61WArV+nxWSeAwYeyb89aBx7v96PXuWPwlv9mrz+BxDZK3nGc1qw9Tv2+KzEJEmkeDvyN3JXDIqH44Q4qkv0uzgSO2u6vJKtdEMgi857U8LyQ9nhMpWSa+0Xsw+gkMehzrDOKUrdjnNT2P4cTNHenfp4TQsX9aeOd8OCgqxOrJC3sSE/FAs8SC2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:25.7874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dbd204e-d266-43aa-ef88-08de6336c779
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9211
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

From: Leo Li <sunpeng.li@amd.com>

[Why & How]

On Framework laptops with DDR5 modules, underflow can be observed.
It's unclear why it only occurs on specific desktop contents. However,
increasing enter/exit latencies by 3us seems to resolve it.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4463

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c | 16 ++++++++--------
 .../gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c |  4 ++--
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 7abe6811e4df..6fc524752613 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -766,32 +766,32 @@ static struct wm_table ddr5_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
+			.sr_exit_time_us = 31.0,
+			.sr_enter_plus_exit_time_us = 33.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_B,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
+			.sr_exit_time_us = 31.0,
+			.sr_enter_plus_exit_time_us = 33.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_C,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
+			.sr_exit_time_us = 31.0,
+			.sr_enter_plus_exit_time_us = 33.0,
 			.valid = true,
 		},
 		{
 			.wm_inst = WM_D,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 28.0,
-			.sr_enter_plus_exit_time_us = 30.0,
+			.sr_exit_time_us = 31.0,
+			.sr_enter_plus_exit_time_us = 33.0,
 			.valid = true,
 		},
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
index 817a370e80a7..8a177d5ae213 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -164,8 +164,8 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
 		},
 	},
 	.num_states = 5,
-	.sr_exit_time_us = 28.0,
-	.sr_enter_plus_exit_time_us = 30.0,
+	.sr_exit_time_us = 31.0,
+	.sr_enter_plus_exit_time_us = 33.0,
 	.sr_exit_z8_time_us = 250.0,
 	.sr_enter_plus_exit_z8_time_us = 350.0,
 	.fclk_change_latency_us = 24.0,
-- 
2.43.0

