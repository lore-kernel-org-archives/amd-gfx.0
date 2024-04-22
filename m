Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A216AC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D51A112BE8;
	Mon, 22 Apr 2024 15:30:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AN1cRjGp";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06DD112BE8
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCjaag8mjSsJSVQsrpLkr1S9odqctlf6PBPnlNBPmD+pgJScBIW73JDb8s3ZQ0nT/1ly6kjC42Aj7OlbTuJXtHGkDR5i0WGItbRXSV0TdW61rbaQosaSWS7ufygyiUoEgeIzFbykXBihICtIJoj+ssNoWfdz/InkkWnaTQkitIfLDPRppCPVjb4BvZtSVM+tJmTUpTV8FlWnkED3Z1wECS22qT+P777yPrH+gVeCYeA9iyB0J5QjWw8v8Zgg+3+inQGwn8Dyacd8Tt3lWHC/78Qq+PV2O8zEARupflaKSNhMH2oGANoCn1kLdCH2xLWxcT874LfehSTP5jyVig0KbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1jozawhXR7fN5+7TLhvts9ydA92LUohWZVOQlqI9vI=;
 b=IrILTza1uyW/Fjhaz0jR8gEu4Sx6BDX/MSvWi5g3jxuhQOrj2D7z5X10sovI2VRR4jiRI72q2q6s8i3OQF/ED5w1DUnlIGR+XqMmuQjDIi6yPOAOhZm5UWkAsii9W+U6I0AVfTCcQqv+NBxgvdhXBFqUwTjVap9k/UO5rBLxB3aimLa0zkXCX6mopnG9aO3T3j6/9wVtbcPzECg5VB9t3nxer4Hmte6j5IQSvPLNUbqjuWa/4TUom1Tz4gbQeoQGwZmikx6nUCfjm7/kWM9O9/YuCLN4EwGu6jRsl9eGA0XxcbnuSsIobOd8Zm20eyOSzWLBfyxNdX/EQNMa/8W1OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1jozawhXR7fN5+7TLhvts9ydA92LUohWZVOQlqI9vI=;
 b=AN1cRjGpjfQqK4eX+ocbUvfXLgqSe5I8PmQO/dZpsaBi8/BqCWEe0CEixMLdYbL2FhKJTdZxdZ1+7Ck2a4px2ebXryIxlX0ZSBdEGQk2PpYxvFB/uawD9F7ezbPUZE1niBxhgElebcasmeZpWdMFO9VaHxrPwoEWEghR43XzBw4=
Received: from BN9PR03CA0392.namprd03.prod.outlook.com (2603:10b6:408:111::7)
 by SN7PR12MB7250.namprd12.prod.outlook.com (2603:10b6:806:2aa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:30:14 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::2d) by BN9PR03CA0392.outlook.office365.com
 (2603:10b6:408:111::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.24 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:14 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:12 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:06 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Michael Strauss
 <michael.strauss@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, "Aurabindo
 Pillai" <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 20/37] drm/amd/display: Add delay to improve LTTPR UHBR interop
Date: Mon, 22 Apr 2024 11:27:29 -0400
Message-ID: <20240422152817.2765349-21-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SN7PR12MB7250:EE_
X-MS-Office365-Filtering-Correlation-Id: 35b8e8aa-9b25-4da4-51aa-08dc62e11b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aZSRgcDarxKlBmyBLwFyYzRCmwWZ5qEKacq0agHoO/5CAwpn+ek3HHFZ578i?=
 =?us-ascii?Q?4+RkLCEjrmF4IVicwhgf79hPpv5+OWBvGdl3+fWaFuWhIMagHoKo27bT5tZ9?=
 =?us-ascii?Q?/pSBVgbOEooQpurOvTyY4EvXAjUya7Cyv9aLP3myzw/v+F8adxftcNVAL6E3?=
 =?us-ascii?Q?rnTxT4YZpGYEBizac7Gzm+2tgKggemnX70keTi1PTRbORivCrFknbBOBwT3n?=
 =?us-ascii?Q?Qi98OieK/d7SuiomEjaIH1K4nWV+H+1vZ09xADE/tRzkhPDrlItWXxWvnqUg?=
 =?us-ascii?Q?ubHFBqXH0NgIdqGbZi0bOEOzhMkmQMEoSouuyLG4dUIq/zOXlSdnX1AOv6Z+?=
 =?us-ascii?Q?2hrDgziGcy4dzcNkAKta/RVSoCfUGHW7FeEzMHOKfhusNidZSt6VBLCjkbWt?=
 =?us-ascii?Q?XkWfBewEz+F8YO3hg8I6Od5yJ70gTUdh1JfD/SEMCQwaP1mv/JnlDIPN+u0H?=
 =?us-ascii?Q?TsoW1m/1g0HhOCwQTr3Lfrg9QXSu/xzBufwnzOsPBbkVHGI0qmSoy6us7Cnx?=
 =?us-ascii?Q?NkvSMBK41xSRFiw8TKPs1TfL3XInYekU+AmYJw8NnGAZWBGvAfBnZ0VvjNxv?=
 =?us-ascii?Q?wtO1HXtq22xqB8zeaegm3uEOFocE9meBHVEjHrr5EtFzFZRzhaYWf/dIUGIG?=
 =?us-ascii?Q?RodU6T36d9vAi+Hoamgsg6mj6osI2wrU8zUfTYa41g2Lluk5GqvL5ooaKNEu?=
 =?us-ascii?Q?FPryni0a1bppVCjb4A4uRnd011cQtbbszfNfzalEdgirEsxwc3O/rPakuoV3?=
 =?us-ascii?Q?W2kzaamKjp9MFmBKkLL8s345+CLyKIr+vjccLDhChhwLu6espmkAtiR6HOfH?=
 =?us-ascii?Q?aRLJNesXYOj9tAEBJFP/R8kEqtNzKoRPO9u34K7TOLeFy2G6GePW+aJpl0Qg?=
 =?us-ascii?Q?lhefSBSQY+OAa6BbXk2lper0GWHfOrp5DighWAcyvamyphGeV3o5iHAaLEgB?=
 =?us-ascii?Q?64IDBjejVEqJij9ajCnvM4DKjb3gYfZoxc7+0JgtOcbxQ5qKvknEbtVFUwm2?=
 =?us-ascii?Q?L4MCyi8IkoW0X4xGB+kXUnl+CP6CkQzPu6YjSD9U18a0CJwO9D7agCsbvVYt?=
 =?us-ascii?Q?k6AvOAhtCsQlOH6lsDYdTC2gNrl4CeSGpiWMoZ4z4W5t64bsBP5ZydisM9BX?=
 =?us-ascii?Q?yM5aQgrsybdzl36vs7XXzrQ+2NakzzWe/Pa2zvSXN+b6lds88BykotBvBYTZ?=
 =?us-ascii?Q?VWGc2RxJdHhpIAzmEu4AG0zp6vB5R7R9+yrTHT9vC2JXp0HkVLKQXRwkFmEl?=
 =?us-ascii?Q?iYUYN7DV2QADYWWrwfR+udZcstLWo9hRh6S/enSxpERKB5H178bG62z3byCy?=
 =?us-ascii?Q?/xadRrPcT6oPnWVDOwguSLeYSrYHDqVHvGyswhXdtlD1bEd92no0xODEoeLI?=
 =?us-ascii?Q?cA6jgXuUmnE5yucff8z19aZpRUDD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:14.0254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b8e8aa-9b25-4da4-51aa-08dc62e11b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7250
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

From: Michael Strauss <michael.strauss@amd.com>

[WHY]
Avoid race condition which puts LTTPR into bad state during UHBR LT.

[HOW]
Delay 30ms between starting UHBR TPS1 PHY output and sending TPS1 via DPCD.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Michael Strauss <michael.strauss@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c      | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
index 3e6c7be7e278..5302d2c9c760 100644
--- a/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/hwss/link_hwss_hpo_fixed_vs_pe_retimer_dp.c
@@ -165,7 +165,12 @@ static void set_hpo_fixed_vs_pe_retimer_dp_link_test_pattern(struct dc_link *lin
 		link_res->hpo_dp_link_enc->funcs->set_link_test_pattern(
 				link_res->hpo_dp_link_enc, tp_params);
 	}
+
 	link->dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
+
+	// Give retimer extra time to lock before updating DP_TRAINING_PATTERN_SET to TPS1
+	if (tp_params->dp_phy_pattern == DP_TEST_PATTERN_128b_132b_TPS1_TRAINING_MODE)
+		msleep(30);
 }
 
 static void set_hpo_fixed_vs_pe_retimer_dp_lane_settings(struct dc_link *link,
-- 
2.44.0

