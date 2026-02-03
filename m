Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C45E8783D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 15:13:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FED510E6A0;
	Tue,  3 Feb 2026 15:13:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qB4mK71f";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010029.outbound.protection.outlook.com [52.101.46.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA6AC10E6A0
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 15:13:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qpLatdnd6QzLPogw15wPv0Gr2WAM2BTPNFyYyA9uo3XaqxDnQHpta26BsFLNKgcGjzf92i1OVg1Ma1uk2BttEFC/ikA2dKlzO8YxZf/EzMH+rLpj2YeyV9f3TaOGRGwbQtuQaJawxzIv56Xff9NeuZ42TZUnsUv4Wf+LJ6+W+nzIb82lE459j/wElbZAEdUXNwllQAz7aT2N0BAGBTu65si8nzCofJBQ0ZM1B4+Cafc1SVrqofOBOPzOmlj6iW9DpONaCWXvCVi/r6W43skfWR0WW0lGZhshXC1H/Cs8v4SYp0wWuYfTl4VYVgjeN6dpILXJsgqcUnfanxsQcAo/5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIWFVSFgXoHU31mvo6KvsHe6bshlMnJEnssXDW18Who=;
 b=BVhWO0X2RlDqWVMJun6x/U0wgEnL/ENjFLrMoWW1TgwkOP6VZGy5sJeg6SnBM1rTE74BhWK5AknmaFG3wzkjihXBbj78Kek7BfpJ9WsYpmuUbLc4Go0kCqXFI9mfDRHtth6/6FU9r84Sz8vRNrAtc+dEgKu3CSTcdOxabolnW1P0KcPy/5sz5zX7NDp5vc6MRzSVtsXbsLrLYqC840hxsiJN2NmiUAP6p+64MGev8nFdfSF3Z0nIjgmt3LJnAKMOR8N7oF+1g3/IljpYgW3nCv2k5K2xAxGzemYY/cOe5tMsg58gp7ttSpUP9HU8UayVNKuJX+zA3uDdFwr7ExyMpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIWFVSFgXoHU31mvo6KvsHe6bshlMnJEnssXDW18Who=;
 b=qB4mK71f9/LhEZzq/jv/c2uvtrvkqNdfdzrZVIxP6kpQlgnletMuJOsdENFEDRq2coAO5a1KPuXYbbQtyH5pocmAYjdd+dc2vML9AQj949mRUvRvU1FwZpEO3ALwczX+vYJ1juA9jMCWsRfYBNui03/vtwaUpJl3lEW/e2bHbRk=
Received: from BN1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:408:e2::23)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 15:13:24 +0000
Received: from BN1PEPF0000468E.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::5c) by BN1PR13CA0018.outlook.office365.com
 (2603:10b6:408:e2::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 15:12:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF0000468E.mail.protection.outlook.com (10.167.243.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 15:13:24 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 3 Feb
 2026 09:13:24 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Feb
 2026 09:13:23 -0600
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 07:13:15 -0800
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 07/16] drm/amd/display: Make GPIO HPD path conditional
Date: Tue, 3 Feb 2026 23:01:49 +0800
Message-ID: <20260203151229.3673042-8-chiahsuan.chung@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468E:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: f232e1b4-310d-4131-695f-08de6336c688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EBkdu1BqNcatNVInAOvyGzfAVoeJYIpjABSpC2BoFrPnl+d0qT7F9LTGQdja?=
 =?us-ascii?Q?Pj5P5KXAnnLGvRTWqw95lmwbqP/u48ixbAsHUCNQUuQf2itCRYi3lMCvz4Co?=
 =?us-ascii?Q?pIjk8FsA4GD7+qmKa/pO/TSuTrc3C/+dBME9K3nezl4iRT0DubQ4iZjTD936?=
 =?us-ascii?Q?iZ55nb3P4u/S7r69R22S8ybdcOVcYuUgLm9VW6JmjOyW2Ua1qSUBUBrWZ6Tl?=
 =?us-ascii?Q?jlkXBO5XZEoGngCVl4vkNWQEhcygm1k4Zmo8Z5xq0w8IoBZbZToHvcZUT9Uq?=
 =?us-ascii?Q?cag2uBUhHg5O7wPEgX2XnHZ6W/XNWZ4EhDT7R140//mox/6EL4piG54Nf2yg?=
 =?us-ascii?Q?BoYsJFFKQ/Gh30VkJ+iV+d7PqB6V85+T0vcyQMf6YsAOoQIeVZn1nCIC4+GI?=
 =?us-ascii?Q?gErS9mjAIggoDgEN2KCAOFcdmm4sKo26A4rfVK+8g2cmeVB+8m2VABecmbof?=
 =?us-ascii?Q?ZmCF2l+dmIfCHikKONFePYNIzHREiZ/xtfYVNPmqKOWNCEdf164kJveaUBWQ?=
 =?us-ascii?Q?rJ721ExyPFXPRWzDd/9BnMNMgAVARl3e0XNz+AktIdPXsGm1P81ngZnmIDZ6?=
 =?us-ascii?Q?ail6MC/zSXmB7vL2B1Z64KFaa4yau2PFg6q07vUFxyfWgJP8RW6L37IAAQzP?=
 =?us-ascii?Q?olbL+Ug2471UfPypNH22Pofl3oyvFWZ9DCX/2mjHlOa93fl2DynXdqvoxooi?=
 =?us-ascii?Q?wwnUE6bNZI/nxn+YEG529naowESd9C0ov7WFVBI8EyqJ26lEniRj0pHa3va8?=
 =?us-ascii?Q?+3mfutKyEQjU2SSyhXsCQ9hVAIUmg0lo95ZHSqS7z2o6XIzXtayfoDVBKbE6?=
 =?us-ascii?Q?EE+tS3rSIUzTdU7LlkJSE4bTWSMHWRiSwp8PWhE8WWK888fFdXMtHJ42KG3v?=
 =?us-ascii?Q?u41POVKHvHtWQKRKYLVitAJk6EliY+mz7TVLk8RRJgaac1mtvKflaXxh2Wpw?=
 =?us-ascii?Q?X7Uh9H5D40QtSk9neUsSBswd4oxLCU/C0vwe17QIgMLDkmZ1KSiYjXaPxOvb?=
 =?us-ascii?Q?c+QeWdCPsqUCT3YXNjmATn9k3OhaRex5PWRIfAQD4euqhP6Mn5lU/3YvOhAa?=
 =?us-ascii?Q?argf5I+K8YRejW8qHDaeHuqj/ybmUIbBW/e7vL/BGDvIz13soIv995a73cb3?=
 =?us-ascii?Q?B2OksaBHR7aV8/sBr049dLeXqleRwVsWkSNe1XoUaVn5NabcgdMHW2mabBpV?=
 =?us-ascii?Q?22sNWC+71CJoN8HWfeDW7E3PWz06U3pNkLGgCvmd8But7+G9vDFMGeCq++es?=
 =?us-ascii?Q?l9eQ0ZJmGFJ3lcGdXXa4u3DBeLFshOy7dk3xGuj1lh4jUKahzb2ndyjxSmdu?=
 =?us-ascii?Q?Q26UdEJQCDHO9cgFmjsXnrmnDOvQJUcDEFHJAnkH9lrcmpKAnGQXyF24Pjyq?=
 =?us-ascii?Q?KMABXnHiG6b7JYzJ+k15uvtS+twbCgCIS47z9tHk9QgOjTdq0IvmiDUbPttU?=
 =?us-ascii?Q?Lu76gkE4Ybon21IcC0+8xpUd661O9wbCYCjxKJoeG/di8r2stUNax2LAAwIP?=
 =?us-ascii?Q?rWNNsDXisYQvgivKyK4pYHyp1pIdxrW5LgCsrMYAuKhFBvxuHalQ2cKazSUO?=
 =?us-ascii?Q?b2DdvW17kyMF5y6LGOsr3ZdtmW3cwERa/f2oTAAwywNgPJrYTIaZ8j9QBQsR?=
 =?us-ascii?Q?tYi7s7eSEV1nNu8pF+Y+Y0kDrb7udxx9r073er9V2F1LfVfQMvyk5wm8RKI9?=
 =?us-ascii?Q?1GNxNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AIjPtFno/e/Y+WQ6DGtCw75nt0C6bF5KIv1S7Mk5FL3IKyyOwFSC+YSAP4Svw3z824H/fiXu24vAkVD5DMxJnFO5JWWU/7ETSxAO/Ix7FDdMiqlIqm2UGY+nzWNqCMw3rWAETkNMV1Wtj34iRcNdKa/bKepJ1T9pbY90iqcIxatcy4mmE7MNp6K9+Nc/jgqf2qc51XxBSuj2RJkTNmB2QjZzGK+YQQZ/KFM8Gr6qDY7D4vTQKSCIkR3ThX67E8UM8++WzpmDVYreyidqdDvHChGfakJHWpOVOpnQOfB9PI3vVxirT4jDA23UbwqD/xTtb2P+akBFfKCZJq1JcCXF1VKbj5QhSqPoF8NkBi70iZQTU6nKpt6ZuxpxkUMrvgPxGtQ3EEVASn7m3fcfgrCLxy1+FJtCWIg0IrSUSKQ0t30rhU1aoIie0FvAAsrQXw9q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 15:13:24.2982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f232e1b4-310d-4131-695f-08de6336c688
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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

From: Roman Li <Roman.Li@amd.com>

[Why]
Avoid unnecessary GPIO configuration attempts on dcn that doesn't
support it.

[How]
Conditionally use GPIO HPD detection or rely on hw encoder path.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c       | 8 +++++---
 drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c | 9 +++++++--
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index 5fbcf04c6251..6f4c3c73e113 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -564,9 +564,11 @@ static bool construct_phy(struct dc_link *link,
 	enc_init_data.analog_engine = find_analog_engine(link, &enc_init_data.analog_encoder);
 	enc_init_data.encoder = link_encoder;
 	enc_init_data.analog_engine = link_analog_engine;
-	enc_init_data.hpd_gpio = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
-				      link->ctx->gpio_service);
-
+	if (link->ctx->dce_version <= DCN_VERSION_4_01)
+		enc_init_data.hpd_gpio = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
+					      link->ctx->gpio_service);
+	else
+		enc_init_data.hpd_gpio = NULL;
 	if (enc_init_data.hpd_gpio) {
 		dal_gpio_open(enc_init_data.hpd_gpio, GPIO_MODE_INTERRUPT);
 		dal_gpio_unlock_pin(enc_init_data.hpd_gpio);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
index 29f3a03687b2..b157d05b67ad 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_hpd.c
@@ -136,8 +136,13 @@ enum hpd_source_id get_hpd_line(struct dc_link *link)
 
 		hpd_id = HPD_SOURCEID_UNKNOWN;
 
-	hpd = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
-			   link->ctx->gpio_service);
+	/* Use GPIO path where supported, otherwise use hardware encoder path */
+	if (link->ctx && link->ctx->dce_version <= DCN_VERSION_4_01) {
+		hpd = link_get_hpd_gpio(link->ctx->dc_bios, link->link_id,
+				   link->ctx->gpio_service);
+	} else {
+		hpd = NULL;
+	}
 
 	if (hpd) {
 		switch (dal_irq_get_source(hpd)) {
-- 
2.43.0

