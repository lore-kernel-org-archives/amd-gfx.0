Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D1BC5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 16:41:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A57610E38D;
	Tue, 27 Aug 2024 16:41:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YM0Ks6hi";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF7E010E38C
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 16:41:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ve73jybcPa+FurkOrRPOyDGBjG8ALGOXoynoEU1WxH9Cw9YHe+5eIrd87QIbMKZM4AVb9cqHNDbx+6v5RyELznSgCWF5HCsIvM/WYEKxNOvT2Sq73hyMlASkdrmux8QMYEKcXblYEqJPLl6GyqnbHqB+sbvSVthTcrH1KKN2H6Phd4AO/ossHDDXY9QBIOGn7M3jQO1jTmPoJvRSukYG1f5hPu7VKCw6x0VEqSka4HJdu0dvrUMemi+NtoGhNTwWRWjZHdIIvxKRbtg6WJ1tVrksGiqCCcDqxLsSMVS9FJCrYrXWePy1qktOnKUIPv94OGw3JeEic1+bVZSHbQEe7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTJj+XXXXrkkymsT6Sod28LHaRDxwXTpzcMHaqmr9qo=;
 b=oWz61TktFIJzxEVOzvyfP6QwQL03E2dQH2GeURtm2Pu2ahHDxN8NOUA9RFbLR76lgnKnzDlKsNqvHeCaAmZ6UMxCQK90z7oSXsOgoddSHvzDOCLFdbcIbNTlXSI0ZkSn1niJxT6wpWOLMF2DVg1hnVPOzLHz2RMeqjIcYPbERc2OGK93kn3LZIfLIeplxd4IrTXhDNuLZkUh638DmcWcOuOPEAXVq5YT0kvchs6zcSRdqY0c5dISseQtpimifK0JPi3PxhGQhTfXWQNvebd06gxrkMzE1MI2OM2lST1xvRXYklGYoiTQAaF4C2DPq/tuMkutqxfQkiEAvVbWrxc2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTJj+XXXXrkkymsT6Sod28LHaRDxwXTpzcMHaqmr9qo=;
 b=YM0Ks6hiZI5BDjmZ/U5rt+73c44sgNNLQor/7u2mFMK6FJ8/TqLdiPf9ibRE5rLq3otjbahYz020IgHCimHXqE66TmW/YDAmb0/Se1xQyEnKmPKUiKNui3IiR7xBLI78f7MKZ4nuVk0CRxefltI7w2GaXLdgeUuakBMe+sJ0MDM=
Received: from BN9PR03CA0658.namprd03.prod.outlook.com (2603:10b6:408:13b::33)
 by CYYPR12MB8923.namprd12.prod.outlook.com (2603:10b6:930:bc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 16:41:05 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:408:13b:cafe::88) by BN9PR03CA0658.outlook.office365.com
 (2603:10b6:408:13b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Tue, 27 Aug 2024 16:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 27 Aug 2024 16:41:05 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Aug
 2024 11:41:04 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, "Aurabindo . Pillai"
 <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>, Roman Li
 <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Daniel Sa
 <Daniel.Sa@amd.com>, Jun Lei <jun.lei@amd.com>
Subject: [PATCH 02/14] drm/amd/display: only trigger BIOS related assert for
 older ASICs
Date: Tue, 27 Aug 2024 12:37:22 -0400
Message-ID: <20240827164045.167557-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827164045.167557-1-hamza.mahfooz@amd.com>
References: <20240827164045.167557-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|CYYPR12MB8923:EE_
X-MS-Office365-Filtering-Correlation-Id: c56d3ab2-8fbd-40ec-7bb4-08dcc6b70bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8nsBawBMR7ZOLOtLYmTCtWv8JfvZ5x2H3POMikIyXo6ALxn+UHePY0Y32Ekc?=
 =?us-ascii?Q?Fqc9E5tLirQ1LYjP2YYi74lGL1LKJz94SRKDMLc2d4p3X5WqQuf4gbaoDVpf?=
 =?us-ascii?Q?G0+t5Oe9VP0G5aZ0JGlv1vx2QryrLEgTu6oid+rwQKQ+/cgNAMMdUuJKqdI1?=
 =?us-ascii?Q?Bb3DQ5kDf4wr9zFHg+nr65lVuFMJRYRbhEcODwDcdQWU6FVkPAJ2CKb3f50P?=
 =?us-ascii?Q?5TGD6IgcqOOkgPasGF11/cw2d07Um67ZYHssP+nJIBTcKuQL7k1XOskW5yDq?=
 =?us-ascii?Q?kJCDyIAEuE1bQQX/07WLjys15WwpPfwshagcEoGWQP5LFQ8KGnR9ugmWlAUN?=
 =?us-ascii?Q?WVZ4cUs2T2m5xfM3/KwYBL9FhQqW/48YszEfuhbESLOxl+k6LE/yZJI1cOjb?=
 =?us-ascii?Q?nOFm75VqrQ2zmvArHAliazf1Lz/Mg1d0z81eB+l58dLA12tL5npshr5mdHOo?=
 =?us-ascii?Q?0DHyzLtf+biiijC7DLN0dY6EcDnC6YP2dtCuW106ox8Duf4FRLP7pUA7fLRu?=
 =?us-ascii?Q?KTehL3L0o7N/ldfB3118jnyEFvgdzL6DiYu96f6cVG5mFa/1p+nGnqDgSRTK?=
 =?us-ascii?Q?4gjO5zxyxAVMDPnn0+s+a3P4/BJ22y1U/99ezQMXFXTFn0AqbOf5JXTpyn47?=
 =?us-ascii?Q?XQIgHjWqfDdD0EbgmyVMjAKvUpm5zItP1dn35RiYvZGc03S1bgk5lzi9LIIU?=
 =?us-ascii?Q?k1fI+EP8jEoFQQi6bI55v7oDtXdorEbYAI/JYfMaVuL+N6lSLw2eYW4yZ61T?=
 =?us-ascii?Q?XswKeBn/eyuV6JdlzhXhzXc4/T8v5P/4ICovqLerVy4NrMo9+ZYoZB1xCMUU?=
 =?us-ascii?Q?nTZauM5JUevmuwR+3UE0IflmW6ilfdbXK3QV/qpafYIzUN/2lGLbTn4L6O6o?=
 =?us-ascii?Q?4NuznFt0yxzu190EZuRrnhew7wfU1TEcCxIHoWRXVJTJAfbyq3JxJiA2xTtP?=
 =?us-ascii?Q?zwl/QGQ7qNbVJbPQZBDSZSqN/bSHVTWc8vBxkf+en8voRTII4DEeCQOV+3cK?=
 =?us-ascii?Q?vrYBNmhu71bLwm8rrrwquafzOMXnJECbD0yPoIdr8BR0o3DayEolXSXhauD3?=
 =?us-ascii?Q?Z0JJbNb0F518WeUst31YDJqpN1yJuFHXzQiOI2eYB+1pXuIwQg0X8AxWEAX8?=
 =?us-ascii?Q?dp/7BgTpxMhbKc/rRe2HtPgCa+BT5pBAkO3Vw0d7tzYKK0DcR8mZPTzQjQnI?=
 =?us-ascii?Q?9iYtcRzmnoQ7vVaaQDgKUCpX3rTkhSHotvPRbSq7HHWuAACgoRtBjJnyEipQ?=
 =?us-ascii?Q?ex5giMK0ZhXxXr8dEya1Jp8yToydER6kCX49K4wyxETE+uBFROPdt7fj6v2j?=
 =?us-ascii?Q?jYgEG7Z++YIZYFU6OKLLgV9DhR5uI0+i3NGLQdd8+5uF93YGJHTjPx6rBtzy?=
 =?us-ascii?Q?xmWsInvtsFGx8fb9/SxuBEbaLcoDGcSAu6juzfsVi9/CjoDa+hNYhuOIEC9w?=
 =?us-ascii?Q?HJcY/py+wbkrz+ahAH8RCLWYoD/zs0rl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 16:41:05.6810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c56d3ab2-8fbd-40ec-7bb4-08dcc6b70bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8923
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

From: Daniel Sa <Daniel.Sa@amd.com>

[Why]
Some asserts are always hit on startup/Pnp when they should only be used
to indicate when something has gone wrong.

[How]
Ignore result of getting function from bios cmd table for newer asics.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Signed-off-by: Daniel Sa <Daniel.Sa@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/bios/command_table2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
index 4254bdfefe38..7d18f372ce7a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table2.c
@@ -227,7 +227,7 @@ static void init_transmitter_control(struct bios_parser *bp)
 	uint8_t frev;
 	uint8_t crev = 0;
 
-	if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev))
+	if (!BIOS_CMD_TABLE_REVISION(dig1transmittercontrol, frev, crev) && (bp->base.ctx->dc->ctx->dce_version <= DCN_VERSION_2_0))
 		BREAK_TO_DEBUGGER();
 
 	switch (crev) {
-- 
2.46.0

