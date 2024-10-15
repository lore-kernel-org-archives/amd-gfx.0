Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E4D7CFC273
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Oct 2024 08:18:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFFA10E540;
	Tue, 15 Oct 2024 08:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MJ2qNGD2";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDF410E53E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Oct 2024 08:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNlgobmCzBDQpanyZToMsbYZRYbfzWUe8ZS9vvT1dv5Heo5wyF5TysGhZTQO0dAj/fGFH51MB72VSJZWr94kMeOh723chN98aZF3iHWHbUp2KsO5HGL0AkrzEx7TvLcl415tU+vwsTEzxrlCCOl7TNdNxpkUEfcVWY+c68lEzE6eI23U1Mw4BCpPb4pi5/BkM+OU3ncwnJv4tDRLzLVy4+bldwOvuniov6UdA1CEL4yU4sJpsXSbql56ZwjEkQ0KmWPkLsY4YaU+bkUrdZG3n8avhHStkNKBzEVb6Z84nZDsYULDBeZ9qiIAmyfvLDjHfzr4+kZ0DQy86JuQr7CMGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LI5Xs4a4aC1kOW+ug+GWWQ/DGiEQyF0GT56Q+IUayZg=;
 b=Ar8aiyybguBdRnXl2LL6Z/Qrqc1uz1xW2BMm0mCMOXfzk4zBvhghSCJrLQcd8LZvuKz4tPM9pDgoheakxMwFiKqtTvZ7pUoRdGa24USGsa3PT7MjEEoP2JLb108UjUP3Q+vvkpXvbJ3fY6dpvgk/DQFT0VX3rx04dr0xuCSqnlzu5IoPtTUUcSIk4pScWwMTR5iUrO7eqY7zPf2Yiez1NyoJH8N3NQqcY2/dzItfxqhapgOx+G4ftUCY+PkjRWjzFKa+yTrgHZJ31W0qvxrFI8KXJgCAIDeyM5fMDBrRACtn62twyNq8qkkFhpvSG95lls2a6kP5JU1q8HKb9UMnCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LI5Xs4a4aC1kOW+ug+GWWQ/DGiEQyF0GT56Q+IUayZg=;
 b=MJ2qNGD2ikUy5AjpOxtXOY2g9AV8QNoo01P8gpI1CLsEyLP2+axjLlF9KJUnUnrGfzmxJrU6Rg/ZNIaQ5ZXJ+xpzxDKvZcmiH9pH6jbtl1O+tcjYSY9H7RqKbaCyHpmW5+E0icmCZ0UATK4bJ5YjJYWFWhr5Pfu+/asxfj226qQ=
Received: from DS7PR03CA0060.namprd03.prod.outlook.com (2603:10b6:5:3b5::35)
 by SJ0PR12MB6925.namprd12.prod.outlook.com (2603:10b6:a03:483::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Tue, 15 Oct
 2024 08:17:56 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::fd) by DS7PR03CA0060.outlook.office365.com
 (2603:10b6:5:3b5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Tue, 15 Oct 2024 08:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Tue, 15 Oct 2024 08:17:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:17:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Oct
 2024 03:17:54 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 15 Oct 2024 03:17:49 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>
Subject: [PATCH 03/10] drm/amd/display: Reuse subvp enable check for DCN401
Date: Tue, 15 Oct 2024 16:17:06 +0800
Message-ID: <20241015081713.3042665-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20241015081713.3042665-1-Wayne.Lin@amd.com>
References: <20241015081713.3042665-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Wayne.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|SJ0PR12MB6925:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6e646f-c39a-49a9-f9ce-08dcecf1df26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x3m44A4GuCRu0lU7XyS4gwKZJAxpnA9ey3oHXS4Tm7lxIF6g1wlfS2cmhsQM?=
 =?us-ascii?Q?pOPKEWClS7JE/MAZKrD5AZhXcee08Hg/gd3Z+bN1tEzzu3jZMgxXS9wlWDOg?=
 =?us-ascii?Q?J+P1NfA9IEbDZYJmLHF0L/nJElihSdPw7oHZQitSDWpmFmmpyTlSI1MEm5y6?=
 =?us-ascii?Q?I/HAQx3tw2iP74O+GtQU8tIiqnIwpBMGlKll6bOFKR9FRro2SL3KmttLyxtQ?=
 =?us-ascii?Q?OL8MUukxBGMG2YzhDliSuUVHaRiaAei/VZ95GFnTLMaWiO1lKTJ47vJJI4SE?=
 =?us-ascii?Q?8zkwXDew2U0T3vOnvH5Rz4lBkzt6DcGfPuu6+RjMJEup04iOfTy4t5+XgYTt?=
 =?us-ascii?Q?lLNnVkwObOtymgYxT7zvCERi29C8wUp2Tku7EgZDgemjxHUGzhW5Yoh6FdKa?=
 =?us-ascii?Q?HdAC0wLGA2ODz3udMqSd9e+X4ejvUV20f5mRXn0M2sf23PsFfdIRmJOQPqwS?=
 =?us-ascii?Q?MqHfnbsEORbMhnd0P1ZH0OxAJDBUF4QHBQjhB8uJ/brrHDmUNT4x60i+pzzK?=
 =?us-ascii?Q?wTF+MekBMRTwMniZXlmlxuXx5fOTLnzD14w1M5PilqlLRYaCK8GuFAkqHbZw?=
 =?us-ascii?Q?C4imvK3zAZryHy5Vo/ui2oy7qp9T2K44TbzUj+hP8Vyug9mlBZ8PLNUWnpqQ?=
 =?us-ascii?Q?ynt+dvzgs+LKT6kISuVuaaxPTmFHGDyrPS6OvzK54A1RRUcc9QsF+R6GxrXf?=
 =?us-ascii?Q?m5dNZEAlVRcHxVrrdB/37/vF6n+YSomKm44OAQeuasgY+2w0M6uh3fuvr2Cd?=
 =?us-ascii?Q?eUy3+0jldxEkGuQ9aEt3bV0K4YByBGYc+ALL5Rp0fMHXTG2Y7rAavP8qWcS/?=
 =?us-ascii?Q?7C4EfINp9UZEEvFPuSAJGaX5hKir7OpSqugkSQ8CXrqRxGjZ8IcupI7vZBqq?=
 =?us-ascii?Q?hL1Lssi1bbWrIrP8YVkONKltdv0Gg2WSaNTSpg1a725lXhBWKfr05BuqSRUB?=
 =?us-ascii?Q?GliHlrdDqmAyNSshsVZeA6ZXaXU6xBvw1mHALnFzn02EoOY00aMva5ps8V57?=
 =?us-ascii?Q?AfypYWwEPuLcajhwb1YVkutKDvb4DhyvyXbn9v1fTQ7qqvKoMFPC+NhmrjKC?=
 =?us-ascii?Q?4WmjDGYaHNtkzNmE4k5KotiauS8ySw5yUZL1ERb+s5xY/pCtSVHm4cJWhoTq?=
 =?us-ascii?Q?Pn1M4nRRCiuWc02e4XykhYf2zx5z3X0+R+IOyb2Y0qJwehvtUwKkT9c3UHr5?=
 =?us-ascii?Q?w2f2AWVwH6zKJzb2ZP82uXVV+rPJZ1Us5/b37ArDpecCvnRC94c8Ubfdog/H?=
 =?us-ascii?Q?D3JPcV3Ibr8zjzrAS+QUS0mktIuqYC+WbgKvSgx4vakirOrxwHfSjlDomkTE?=
 =?us-ascii?Q?gJ6PoNB5wanNgqe//XYgyDznmxZupfjZDa+GoMbNZ3ML4+SX5+z2fFdPGyhz?=
 =?us-ascii?Q?vvg4cthtTs+d1JBqv3qd+nb4GBSJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2024 08:17:55.3821 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6e646f-c39a-49a9-f9ce-08dcecf1df26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6925
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reuse subvp enable check from DCN32 for IGT testing of Sub-Viewport
feature on DCN401

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c   | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
index 46feff9348d9..b2e59e97818a 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn401/dcn401_resource.c
@@ -1579,7 +1579,8 @@ static void dcn401_destroy_resource_pool(struct resource_pool **pool)
 }
 
 static struct dc_cap_funcs cap_funcs = {
-	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
+	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
+	.get_subvp_en = dcn32_subvp_in_use,
 };
 
 static void dcn401_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-- 
2.37.3

