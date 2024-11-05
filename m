Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 930EED36136
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Nov 2024 20:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4455510E605;
	Tue,  5 Nov 2024 20:24:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0akwd55l";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2053.outbound.protection.outlook.com [40.107.102.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A106310E605
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Nov 2024 20:24:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/nwOJdRl0KCRlYEKST2Bec4Ql3aDeUA1Z+4oeqiac9G2ebbct8tEGow9bxL7bH6QZ1u/cRAI/SOJBbSz4KzwTKVOyjujLcVFGKOT3J0aKw2XwTbN/EM9SaaJMzrS22S8AbHk2NrwFExk11z24qmOeORPnQeXUjZWMC/EUcpLRlvbu/XtGrcwhO2xMF3b8LT3t7e5crRCjs6931IBjCRc3V61aARzpXzEYbrEx28rx1WRK5yIIeD5oEd3vsygfdTgRZIfpjhMeNwaiuGzt1vyBddjwl//9511C2tt91tjDeA4IbW6JLscWgS2Bz214CzH8JPtBcwM5xGsls9HKfGOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F1Tu2Mg3fmvAJ6DSPkfMWsFPpWYiekA2OuIukj0XVHY=;
 b=aOlpX/mbJ9g0UidNuP5HYt9CnjLln5z14nWTfd+x3oUeUSIWJY+Uunv3z99Jgq/iKYlsDfd032IKWpVLozzY7vbJLGQexnrs9r1Hw/6Vit9gaV9butoBKeIEQVOlPWvfQO9NjKoPjPXIRgcGPpaVGFJOMAOtIvFzd03oIZbDIc7kwzABPnPqxhhlUVawPiBtivg5hKjX+17gTmcCmWauyE0I3cUV0/8NyxfJnsJI4NDu1xOFOWzagqIe/AW1MX2Qrtwaf/68mXI1cDaxIAqpWz73rHZnkPRnP3wI/oiuNnfuF5V0jzRlxS9w7uyWYiuLc5Rw8vQD19VxAlnl31r0GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1Tu2Mg3fmvAJ6DSPkfMWsFPpWYiekA2OuIukj0XVHY=;
 b=0akwd55lkafixGkRfR0+3BaLRSa2IBCma5zEnFnSVilOhAvGnmcDfCtGRBt1fZd9ZOJ+CSQX2CFh8+i7yplZA6yIslcDliha1CKVhKlUJcAcbuD/+l7DGNisgQ5f0utuUGom0GUeOdT51ihOvSQ1zd8Fm3UUrWuZBCs1dH2N5Uk=
Received: from BN9PR03CA0246.namprd03.prod.outlook.com (2603:10b6:408:ff::11)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.30; Tue, 5 Nov
 2024 20:24:12 +0000
Received: from BL6PEPF00020E62.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::17) by BN9PR03CA0246.outlook.office365.com
 (2603:10b6:408:ff::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Tue, 5 Nov 2024 20:24:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E62.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Tue, 5 Nov 2024 20:24:11 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 5 Nov
 2024 14:24:08 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Revalla Hari Krishna <Harikrishna.Revalla@amd.com>, 
 Lohita Mudimela <lohita.mudimela@amd.com>
Subject: [PATCH 02/16] drm/amd/display: Change parameters to fix certain
 compiler errors
Date: Tue, 5 Nov 2024 15:22:03 -0500
Message-ID: <20241105202341.154036-3-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241105202341.154036-1-hamza.mahfooz@amd.com>
References: <20241105202341.154036-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E62:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 373aac79-042b-4a8c-1d36-08dcfdd7cf82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ObizOB/SsdbVee/JzdyPjLDqTtZeaJKiRd+Zpy6s/EcD0COnzQ/cbuOcsiD6?=
 =?us-ascii?Q?ol9Lyr433/NpJBq3U1NrdE/VvrFNlilbFnmKCzwJvBt3Y8jAIN8QzqScmdY/?=
 =?us-ascii?Q?zHg5GH0cZMyUd4UPk8mARrHrgeohASWXqgqIqv9bPn/3/1Nx4oNqZ6Ep/hkB?=
 =?us-ascii?Q?XM68NJz2oDWK/1BFdXSdxCtrhLdt4DtZhZpWCHyO1gmEhWDWPn/R5PqD6tS9?=
 =?us-ascii?Q?SY1EYR8isyKzWf4QfiYLGwv77UBGNpkyIsfrPU1PiL3IgUppP2iHy+zMqWKU?=
 =?us-ascii?Q?Xv6k09mhQUhnd+Baoq4vXv1Y8xImzK/Ad+2LBkAlJ2asKQ73lMNz94IEuq8b?=
 =?us-ascii?Q?ikURz0oC3kElXhh9aefmiZmk5X2pijUDLwCElzUfHlmmDdKcRKmoPuAdKMrJ?=
 =?us-ascii?Q?/CIYwJ/2DN95jlEyytZuIu1mGt+QySNu/bUXUs3tW/r6S+94w/DI01Rz4GP0?=
 =?us-ascii?Q?YJmmiWJvsFqLxMZhREupr5oPrjgWJwERVzc1eWhTT6AJUBfOx+EoCRL7oD/4?=
 =?us-ascii?Q?aVZpaS9q84q6YJWBQUcKb0wdA4YifPKHVgDnV4mRZpd5lVKoUmDQENFhxq3S?=
 =?us-ascii?Q?OvqowIJYaN8HpOrBNqfKx10koDlOpIZkR6vNzazsSKpCjwhVyhwimJSY/fl5?=
 =?us-ascii?Q?X80NzUTNoOsye/R9H1v0xT/su4rhPnsZzL63AD20Nh7Z5xfeyE4fzlGJGUoS?=
 =?us-ascii?Q?yfwr3phrIXcGyXS5GbF1Lx3uXgIL67mFmm/hbitr0Jv4yyBRki/9Vh9P2tel?=
 =?us-ascii?Q?ddaVTnkuEqsCeDP6pFgp5UiBIouoSqm2RQUnWFYNTc8YYN8Kv9uhFfZpC6Tx?=
 =?us-ascii?Q?c2LArj7Sl0TfmCeddCiUzxWBjEgCv+EovNA3wWzKKum7nMieUsPJpYe9aQMn?=
 =?us-ascii?Q?3/ZCzquuaIjOYAe5YM7f42wYdDMWikF/f2IriCr8uFsSadCNgkGADHMAb4r9?=
 =?us-ascii?Q?c7uJGI35zZDQEA5bpmKukG7lL058NMRci3M7Wt0qslhuQG2UrQvlZwq42OaV?=
 =?us-ascii?Q?O5+Rl5fMLvP6dUHcArS/h+5SSV9t45lWBXd4bYzwdwdFqq5ixAxjxdUk/i00?=
 =?us-ascii?Q?1SPVFLof+LlVVf8kBiz2bHiFJkB3fHODD98ex4rFS/nsVHaG3GiYU/wHaVZL?=
 =?us-ascii?Q?ECjR3B3FT7VauF76mr6f5uaCWutSRITjqTOjNIxd3KsmIVExdBxgn375QHDD?=
 =?us-ascii?Q?uyNNpJzrfjosnwgO7UdLf2EgYIjypXCsm286+cPT24GLLUudQJo5ilMBLaRl?=
 =?us-ascii?Q?QIT47DaJ/XwKiUHpB6Wps98N5Y4yJvS/7h5smMGBuXlygiVmi+f2XBMFvRbV?=
 =?us-ascii?Q?yoa6p5fub0RF7zW0oyqqDuy8LcBhI9emJbHYYJZy62r+FCGPd+WZVGoJPKMa?=
 =?us-ascii?Q?lvRu2Z3TJ9AJxxwKRAH7jARmL7UD+gTPQTzblUyvewwDjXfYhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2024 20:24:11.9724 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 373aac79-042b-4a8c-1d36-08dcfdd7cf82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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

From: Revalla Hari Krishna <Harikrishna.Revalla@amd.com>

[Why]
String literals must be assigned to const char pointers.

[How]
By adding const keyword to fix compilation errors.

Reviewed-by: Lohita Mudimela <lohita.mudimela@amd.com>
Signed-off-by: Revalla Hari Krishna <Harikrishna.Revalla@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c | 2 +-
 drivers/gpu/drm/amd/display/dc/dm_services.h                    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
index 05df502a54f2..88cf47a5ea75 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer_debug.c
@@ -46,7 +46,7 @@
 #include "clk_mgr.h"
 
 __printf(3, 4)
-unsigned int snprintf_count(char *pbuf, unsigned int bufsize, char *fmt, ...)
+unsigned int snprintf_count(char *pbuf, unsigned int bufsize, const char *fmt, ...)
 {
 	int ret_vsnprintf;
 	unsigned int chars_printed;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index 9405c47ee2a9..f81e5a4e1d6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -143,7 +143,7 @@ void generic_reg_wait(const struct dc_context *ctx,
 	unsigned int delay_between_poll_us, unsigned int time_out_num_tries,
 	const char *func_name, int line);
 
-unsigned int snprintf_count(char *pBuf, unsigned int bufSize, char *fmt, ...);
+unsigned int snprintf_count(char *pBuf, unsigned int bufSize, const char *fmt, ...);
 
 /* These macros need to be used with soc15 registers in order to retrieve
  * the actual offset.
-- 
2.46.1

