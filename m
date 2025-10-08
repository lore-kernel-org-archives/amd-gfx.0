Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72180CAC5BB
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Oct 2025 18:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAF810E89A;
	Wed,  8 Oct 2025 18:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FB9ZpNzI";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A6C9F10E89A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Oct 2025 18:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TDVlPIeBae38RjYBPtaER0MNem8EeXVWF6p8ecP31miYiSXYSIHwmwJuGOMxY4fAvfC1p5qdqF4YRjqciI6Hot7hICZtvjCWeZcKAFJi7nMFQdavgPkZEb2pRCJYYWWxuZ2qQ/tvr7bpU4tY+oTh1btovePTDC6hgTfT+XT85inYQlm/oS+FQgLg62gDbHjpwpn3k3OtcaV3Nf4h0wiT6RkJ9Z/sX8HZ2k9yblqswzXb0X6NEwcDCOmz1X00ckjpZIUeDz2zt3B4OvkrUyHNXV9+zZ+rbDRR0+E9gekJlkxKhLqXXNnPL2Ip7SEKv14BiTwWS3HzqQX4K0QljHBTUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AqeacKkoOT5w0e/P4nrVnBStbfcRs02RGauNuadTNVA=;
 b=Ku5ScCo+an6Y6O7ay4TKjCc/oqUywayAqou+8k3D+4qG6djL/5OqU4dYcSdx+3xC+rPOkUu+vStcMtWfukQ42Nbz+iVl60OF/F/uDMA9C2AqkBIGYO7H8mrrbmSCLc0eoo82HHS1My8T+11oM4KbcM2agv56SjSBm193XFTvA7HY5uRC+4S8QCBIUjy8tDOfJkiz4kt7tv/wMbTV3ljnqAPUdirFzd7Q8pTtE1oKMtnGYHD8pjbfyWCa9Di3A43oof5f0Vy1cVIHux6D9VyoPz0wt+oUZlv6NMQ96ZUjOs7GvPJWJsPhWBSKhlx/wqbkpJg06VOosZRGLMt3JD2y+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AqeacKkoOT5w0e/P4nrVnBStbfcRs02RGauNuadTNVA=;
 b=FB9ZpNzInehCeTW/v/w9wPGmtjG5MYUkqmVmnADpko9muwSM3rRjRODEcWl0eTHBXDdzhYvqTiBQA2kYWaRU/EaHo7h1wHEA1R0VpwKhm/l4HFWeIsZnH/SM+7KE0WliJZykarM8F3QKfkAMBQ9MQsg4CmETE5WkRHX95H6tapQ=
Received: from BY5PR17CA0035.namprd17.prod.outlook.com (2603:10b6:a03:1b8::48)
 by MN0PR12MB6367.namprd12.prod.outlook.com (2603:10b6:208:3d3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 18:48:57 +0000
Received: from SJ5PEPF00000209.namprd05.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::1) by BY5PR17CA0035.outlook.office365.com
 (2603:10b6:a03:1b8::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 18:48:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000209.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 18:48:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Oct
 2025 11:48:41 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Oct
 2025 13:48:41 -0500
Received: from aaurabin-tumbleweed.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 8 Oct 2025 11:48:41 -0700
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Yihan Zhu
 <yihan.zhu@amd.com>
Subject: [PATCH 03/22] drm/amd/display: add dispclk ramping to dcn35.
Date: Wed, 8 Oct 2025 14:46:57 -0400
Message-ID: <20251008184839.78916-4-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008184839.78916-1-aurabindo.pillai@amd.com>
References: <20251008184839.78916-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000209:EE_|MN0PR12MB6367:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a11b997-4113-464a-10df-08de069b55c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HcGovdV/5ksYTR0SqxbfDDrktpHThbE/SDRcyMmq4cT/44j6+KUWDOMm4mBM?=
 =?us-ascii?Q?RgxS3QSnHh83W32jPA3W/1G73TGGe17ETJ+Sst4m2KTZNXKC9Nln8IRefmbT?=
 =?us-ascii?Q?Ji9ayiKI2B9v+GhURBpIYTgePOX30eayH0o4zCO/4tEuAbCTRYkz2R3Wt0Bc?=
 =?us-ascii?Q?7BWfpVLwf9l0McpWXVGvoSM0kWZQSKidL2ATo7FwAs7e/adsdrKEj9NjYboi?=
 =?us-ascii?Q?wakb8D1wMC0wtNsKG/A9oQLaXCwnCewEVEtIU6WcLJqlyopLfBk1uN2tF5ZZ?=
 =?us-ascii?Q?CPrh8muZ17QzgTysvewUEBNu2jaoVOg9wfYwLav1f08SHWQjauOcj7ywiZg6?=
 =?us-ascii?Q?lGZUelgY25tBb8++FymBdhY9utCUE7VVl5ExUYYq65IM7HA1/16+W/mkOz6w?=
 =?us-ascii?Q?JwBuLbs65csIdXJYfE9d15YAN9Q3df8HH9b+7TXRrWG3NRieC5fj+1/ZrJup?=
 =?us-ascii?Q?yop6zsBLu4v1DPVMIN/JmBVFmFDQ5Tkj9T5rIJ1HAw65Kr9urBmLF+NWSiR3?=
 =?us-ascii?Q?MnXy0Rd2iII10JGMdHjDn2KkQ36atqeW7Jsy5GG66/MF9m5/UMPkhgM0X9FL?=
 =?us-ascii?Q?GaNn9JJxMAcE1YudFGUe84ESSOqZjt0q+GzRGOa4zB99Y9wFHHbfqzVE1jwm?=
 =?us-ascii?Q?q1UELaRrMGRabTsxiLxhXmzvlF5HtVl2ddGg34s6eo/hgaG2+saOQgTyVymV?=
 =?us-ascii?Q?SbwU/Wl1plr7cUFNzEVi42QUGDGLh275HnyIztt832aXG/CoRUxj2dL8J0In?=
 =?us-ascii?Q?MxSa4+UlV60kG9IPfw8xZAmM95cHLjwtn0gOuYglxJIDcwA3qObAIKAHFMCV?=
 =?us-ascii?Q?Y4DE3ioJYjzYfIOx+cykvdJrB+Q5ShaaVyvkNOH0Vt8uMFa2e2MybAPK/IdU?=
 =?us-ascii?Q?cMRdn3BxagYTzqP7aFftZc47SiNdXnLdggOICwAyjvIL36pI+aomod0n7212?=
 =?us-ascii?Q?2ORLXRhGvqhmOKmsza7AenvQduwH1zKglsBDLLMiAMRpvgpUpY7TOPDj6VKG?=
 =?us-ascii?Q?mYBMmX2uIRhXcSWI7nGjeJProPjmV1Ugoh6qTIv9b11Ljk/CQ+rU/jA2gUtE?=
 =?us-ascii?Q?tf4tb8/KJtj8Y0Z0MMhFnaMPhD6e1Afkb3DR6VX1A9zCBHuHFHv9j5l/43n3?=
 =?us-ascii?Q?3Vputyc1KOWQVY9Adm7X+60nFN/vvDNFoAOHTDHawaoROG5uYQqTe3+WT9wU?=
 =?us-ascii?Q?sFBE9dlCaST9DVZ2lSrZECfhCLRK/CmMzgZj/+tOm97SSt5mOw2K026Ndr9u?=
 =?us-ascii?Q?4/xlQ+yLY8lfFQ2+I6Bh+fWgPw1dhcK0AmYhNrqfzCcZxqmp/aOfAoGMp1NN?=
 =?us-ascii?Q?MinINJp7LbtoL1FdGXz2QqyyDc8f7Xv3nRxH4x6p1P0Bw964NFOqON6WDwYM?=
 =?us-ascii?Q?hBBAhVu4AeV1o3lH862SfXW4B1yNYnjfD9MR9I7tB3KsOpUAzj5wQZxpbsg3?=
 =?us-ascii?Q?LBznqblRm6RjQc1AwbWBXHRWGkwSmXDotofjqtPFbR2pODyJI8zmO5kXH+mJ?=
 =?us-ascii?Q?PmdQSOnRLelrPlvcXtUG98qtRRWtXRdTAlF7zrGckIFmcnwpfZCrvX5LPAem?=
 =?us-ascii?Q?dnsJ29D6q11Cra0xVys=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 18:48:56.0601 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a11b997-4113-464a-10df-08de069b55c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000209.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6367
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
this is a required logic based on HW programming guide.
tested/ported on dcn401.

Reviewed-by: Yihan Zhu <yihan.zhu@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
index c899c09ea31b..e097d52956b6 100644
--- a/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dccg/dcn35/dcn35_dccg.c
@@ -1114,6 +1114,16 @@ static void dccg35_trigger_dio_fifo_resync(struct dccg *dccg)
 	if (dispclk_rdivider_value != 0)
 		REG_UPDATE(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, dispclk_rdivider_value);
 }
+static void dccg35_wait_for_dentist_change_done(
+	struct dccg *dccg)
+{
+	struct dcn_dccg *dccg_dcn = TO_DCN_DCCG(dccg);
+
+	uint32_t dentist_dispclk_value = REG_READ(DENTIST_DISPCLK_CNTL);
+
+	REG_WRITE(DENTIST_DISPCLK_CNTL, dentist_dispclk_value);
+	REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
+}
 
 static void dcn35_set_dppclk_enable(struct dccg *dccg,
 				 uint32_t dpp_inst, uint32_t enable)
@@ -1300,6 +1310,8 @@ static void dccg35_set_pixel_rate_div(
 		BREAK_TO_DEBUGGER();
 		return;
 	}
+	if (otg_inst < 4)
+		dccg35_wait_for_dentist_change_done(dccg);
 }
 
 static void dccg35_set_dtbclk_p_src(
-- 
2.51.0

