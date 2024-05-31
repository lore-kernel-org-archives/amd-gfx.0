Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AD2C27C4F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 May 2024 16:53:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35AE510E471;
	Fri, 31 May 2024 16:53:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7Ul8H0m";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2082.outbound.protection.outlook.com [40.107.212.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CF3710E471
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 May 2024 16:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G19ESVxMCfL1KPucoKUGnsl9cF+RH33XHVdgZrOnynAMuyS7dLwlekmEvDY7RbzT0JCEu2bGfuix1AX4gKF/2RC9kZjh28wJqRiJfIsJkLw6FM1+o706O0+UpjhXEuZzlwNMFMMrUH8++1HYvQ43/sH6fNIY9ADkdAkVFTdsqagX2EKbtnk180fAHkjJ6V82UvbS/VPFLusBoiGOIru0QrSWGP3g3Smfycd+PETVPIdVllO6XWebNrlVd+slEfAvck3jESuOIl515drX+fvMBxBkFcQP/UOLOwx0g/q2bNUtZkfZQGQ0pq+kGpbM307Nyeoy5ye8VkwzgH/0v6H8TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2zhrQpbOnnhjHAsx4DOWL3qKrCxQ9jqEKxFhwkDYqg=;
 b=eTGMKJ9V2IMPrs3/kEGUIF71FkVfg5xQbjfN1zkvmwVu2z3tBonovC1ftlFhjQNn8PlEWkq6kJiWGZsGbm6hrx1yozJlonhLg8NR+UfYeLZ3goStyD1oAwQhlApk7tdTkws2rUhN0aGu3tlfBXjBcZmjy6ITmdmphxfjJaIFAjfFl1Y4qcm5wqfnPb/PLz5mAudK6xqlHRk0EW2kTOW/GNty1t+z0lH/MCdgUEA9rUt6ovOW1nyGUIoDLfC/Ktt7v5rvGCP1QxBsahllpCSNaf43S/r2tYvsT0Dq01l3qIQDEC+xAlsTkupElx1GX2O6Piv3yX0+D54g1K56ZSZdzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2zhrQpbOnnhjHAsx4DOWL3qKrCxQ9jqEKxFhwkDYqg=;
 b=E7Ul8H0mYJU5yj8O8BI0M5u7yzRYFhdNGE3PiNg03fZDqbNJM472s1eiwQyyFElLa4HMdqTXLEcIiO2pTWvkfxO5Hu0QKyzS2bk9+qOLCeLS5L5kFLWDu26iO8vXtTP/ICQbAmf7jUBoV5gkcbByUHUhTccnxQz7AkQCwSm/r4U=
Received: from PH7PR10CA0020.namprd10.prod.outlook.com (2603:10b6:510:23d::18)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Fri, 31 May
 2024 16:52:43 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::51) by PH7PR10CA0020.outlook.office365.com
 (2603:10b6:510:23d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21 via Frontend
 Transport; Fri, 31 May 2024 16:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Fri, 31 May 2024 16:52:42 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 31 May
 2024 11:52:40 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Yihan Zhu <yihan.zhu@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>
Subject: [PATCH 20/32] drm/amd/display: bypass ODM before CRTC off
Date: Fri, 31 May 2024 12:51:33 -0400
Message-ID: <20240531165145.1874966-21-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
References: <20240531165145.1874966-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 363ae974-0534-4875-549a-08dc819216df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?43yw5fTd5a9C1CimXGIflE9sqIPlSWp0b/AXXmOIDOKTvJoUDNO7Uy+jvr3M?=
 =?us-ascii?Q?y9rHVm6oED8kh+0RyJ095Q4dTz0MyOPU9we+2ik1CIwexRjzjPHAk/BT1n6y?=
 =?us-ascii?Q?tq8D+GBNGi8hOpYJH59Wxn7bnXsS6nF6SSqquK0a3zRGPtcKS2arsWbdvcND?=
 =?us-ascii?Q?Ugy82U5oO2MmmNOgMkkerBBz0ahP0pCSiFEBt1q0sCba83KvEMnhqaDLPPmu?=
 =?us-ascii?Q?UtgJH8COr83FYWDo5jRanxtXgkzqH/K2nQo9Ji8FDBOa0f50w5/9OYNymzwF?=
 =?us-ascii?Q?wAXNBfwIGsFtASg+IHAksxOkcyDeIBc4GA97HIInR3TdaP7ttTzkCB45PKYM?=
 =?us-ascii?Q?IMH/dwAN1/L2QhHgDeZbwRLoWQwbLZCc6+eVyXkLmF+9Hq1Ehub6k/CMIlsP?=
 =?us-ascii?Q?kIiCfU1JoB44ioeLVwp8dk8Kc3GNoDqqOYMYxR3DPXu6STwqzyjQhWwQ51u1?=
 =?us-ascii?Q?ZEjBMVOoQxC0vnNyD2HySasR970F+qcIEjKbnk4GCKzEDP7Mk0hNMbDxfCvl?=
 =?us-ascii?Q?OUBpL0e6bjsI5/kfXA1jsdcC0V7V2ggP6iWQt4bkt6NoGpe7jfuwGE8RsjU7?=
 =?us-ascii?Q?CQvEYzF2zO4naMdWgYuK2uTJ2CuhEf50318hn0yHOVuPuVjxamNFGUVs5Oul?=
 =?us-ascii?Q?xpJTQvzqfy0RGTA9BpLUgQPbegjIFIIh0h8nGCvxAs0qeJuEUMuiLWi/Hr32?=
 =?us-ascii?Q?4vQt28quX9SqMDe+bNU22JTlQkLbzK8JHb7NFfsw4hFfNgeW6XM1aIo5S9o0?=
 =?us-ascii?Q?7hFoT5vL6UjN4tKa/xw1TdBIAbXB5bWQtPllJDY75r/STGF6fWux29A2TPnJ?=
 =?us-ascii?Q?0oAgUILPVx5he5TsUb47DKYistlUfceZYxS/miXbCH1wq7bgfV3QfU4VHrws?=
 =?us-ascii?Q?Rglht0gwxZDM4KjgBniKtbEMHFueGg9cxuEnPFP7fxNeiz+aTMG9V8awgM/7?=
 =?us-ascii?Q?ZQ/zzSn5B5Q6beNmC7jaB1JSfzLldUn8l3yXPLgLBB0AXOClbeKcz/cPKQts?=
 =?us-ascii?Q?yJB/icepM7onw4leJQj98+hQBOMCxHwjVWMYUGbnc23MBf1ZeIWRYgE8oCpb?=
 =?us-ascii?Q?TUxoWuyu2nQCp0Sqq4I4AP6PIv35uLNCsgVS11ETXEbztwNUYRJHqFDVrN1E?=
 =?us-ascii?Q?e/acHVAKb47v3rZl7eLCh12kDLaxGOTShbYZCjNHgj//5Laq1Ht+pqI7LKuH?=
 =?us-ascii?Q?YWPunZwXJpx924efpNm+K25ul7pPQz6MCq1tRJe+er1UcGcJ8P5mycOuNjKM?=
 =?us-ascii?Q?yz6/fz04bq3Vkc77UlCz5a2vYLUafVjvbmDz68otZI/RsBldoV7guIz8Jffz?=
 =?us-ascii?Q?KNopgDQbARIoemjDpgqNDw1tk+nUDDG6mSkhTBtQv7ZMVQKRONbssVjM0p2i?=
 =?us-ascii?Q?E6ciMk0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 16:52:42.7773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 363ae974-0534-4875-549a-08dc819216df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966
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

From: Yihan Zhu <yihan.zhu@amd.com>

[WHY]
OPPs couldn't disconnect from the ODM that cause the double buffer pending not being latched due to missing VUPDATE.

[HOW]
Moving memory blanking before OTG turn off to make sure double buffer latched correctly.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: Yihan Zhu <yihan.zhu@amd.com>
---
 .../gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
index de83761edce8..6bbbf313b2bb 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn31/dcn31_optc.c
@@ -121,6 +121,17 @@ static bool optc31_enable_crtc(struct timing_generator *optc)
 static bool optc31_disable_crtc(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+
+	REG_UPDATE_5(OPTC_DATA_SOURCE_SELECT,
+			OPTC_SEG0_SRC_SEL, 0xf,
+			OPTC_SEG1_SRC_SEL, 0xf,
+			OPTC_SEG2_SRC_SEL, 0xf,
+			OPTC_SEG3_SRC_SEL, 0xf,
+			OPTC_NUM_OF_INPUT_SEGMENT, 0);
+
+	REG_UPDATE(OPTC_MEMORY_CONFIG,
+			OPTC_MEM_SEL, 0);
+
 	/* disable otg request until end of the first line
 	 * in the vertical blank region
 	 */
-- 
2.34.1

