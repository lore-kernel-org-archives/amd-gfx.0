Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756B1C27C75
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jun 2024 16:52:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF4B310E6DA;
	Tue, 11 Jun 2024 16:52:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="u+J3+9AR";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6414310E6CA
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jun 2024 16:52:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JoqkKY1N5ZyxOCeLy09+ub8wOnAAGq//CNCbrS/zrDPgw2XQP3JLIkeTGwJxilsXXGwvCsBeOD/N4Rfwum/ghCptU6CW0Qb0trZoJaPiwVWJ4TwUHbEKcd0JtLNLIMGJ+LEiKedF2oayB1rFatZ6UxEgk4LjVKX8pQLFXcgUH4Pj5yb0Z0j31yE9DIubJMUb6IMy37/jKCt+XYtG/Ei7iuBwLq5X2/Bpp1DyZ0fAWY7k9YL2mg/E8iUXFzDJqM6rip2uatZ2OKG7WjViDdFla3T8OpvOnmqLD2VW7ED5q9tNIkqtpsrgTYjMlqZJ/QwJFCD/T1ywSROttKpLpVsaNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yzDhwY84+HRTLsGz3W0LaUcWNTAmMBks1hY3273I880=;
 b=ldgn/dJ3ygPbA+fojIAd6Ra8r7hdUNYeiOOunl/SdOBA3RnbBjrsjWc06++wWpdONEIg9J/f0MNIrBMym4LJnG7yc+oOOW+D+OoOAgus8h86M1oOchsz1Bl3Iq7ewwRqTDJIzU4B3O9YE7RyT570WwejWkgMrhBHiAo7Lz3Q3OuCKOyx9OslDQN/C1XDCtPupJJRHrsodwVqB408a+8/qucLmLmFD2T+6C732rKLEg5T/gQ7MoOKMP8NnpDjWkPNeXYXMyoY5rbt2rJWyYGVfe/idjYhHQ/JOLUYwqI8BsanLWnglJ6xWYn8mN8umWRiQAWnyhemUiqtwh7g+vRT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yzDhwY84+HRTLsGz3W0LaUcWNTAmMBks1hY3273I880=;
 b=u+J3+9ARsjKw5f+2zOAwrBADMC5xDcYyyE2bkj1wrHPSc/rSzI5v4WOz7Xz5qwU6b4DBiQCtY2FlJry5qn/AprrqKTPcYvyshQmuIi/IFjH5TOb+7TP/NhwtP1E8f9e1JqHxjAOmTC911YQAcO0RjvFlV0VBUQZ2ZXzwgDE3GfY=
Received: from BN8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:ac::16)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 16:52:40 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::46) by BN8PR07CA0003.outlook.office365.com
 (2603:10b6:408:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.25 via Frontend
 Transport; Tue, 11 Jun 2024 16:52:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:52:39 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:52:36 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Bhawanpreet.Lakha@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>,
 <qingqing.zhuo@amd.com>, <roman.li@amd.com>, <wayne.lin@amd.com>,
 <solomon.chiu@amd.com>, <agustin.gutierrez@amd.com>, <jerry.zuo@amd.com>,
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Subject: [PATCH 19/36] drm/amd/display: Fix NULL pointer dereference for DTN
 log in DCN401
Date: Tue, 11 Jun 2024 12:51:22 -0400
Message-ID: <20240611165204.195093-20-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240611165204.195093-1-hamza.mahfooz@amd.com>
References: <20240611165204.195093-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c955b7a-e26c-43ad-1059-08dc8a36e7c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230032|82310400018|36860700005|376006|1800799016; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZdOy3VM58iivjn+NcjRIsNB5mFV/RFW7jmnhf8FBBg2bVaHyLM4sxU6Kx0/K?=
 =?us-ascii?Q?FgHBFJbAMQbVfpxsXraKOT3DVLX+KT51SirO0w1Wcl8dtyM5eZuqEZQBfzGW?=
 =?us-ascii?Q?oWvJJMgjFKJ6dWjDShQfHpMIQ/+CE+Xc4Rj5exlJQ7/gZCnIqWad9US/iyw4?=
 =?us-ascii?Q?DCbiLFfF4HXU99s4SiMOSdGA3C2hXJX9dEAT1in/zSOhl3sdskx8lRQlebqh?=
 =?us-ascii?Q?j8pUvzDwQYJYQLFypRdqRNZPj6CPErTWUIqt/hvMyQ7ePqUBnxtiu6/63Bf7?=
 =?us-ascii?Q?9XfSQRsF38Cc5Uy6UPp7eYV/hAWthXA3fxHneq3+i03Pzv8+bv2OeGIa6/i4?=
 =?us-ascii?Q?Xcp1RN9wJIG/Mz5MWAa7adKCQMBOV4nbbvGxMVe/jmooaG1V3ezjf7VpUjNS?=
 =?us-ascii?Q?aNNAx8pwZ82+rLqRsZ+uuzL6C6wmhEPcImIqFAk/s2zD4cdQiJGNaRW7TURB?=
 =?us-ascii?Q?SGM4dYcc3UUybuaDr94w1o6j/BNSYS9W7uNtxIdW0ESxRVWw3FwHdAiMbhGg?=
 =?us-ascii?Q?gBSRT5oLZHJPEcIiK1w6u/a+v1EpM5XVLMp8h7NxOxeICn5uBKAyhZ/a+uG8?=
 =?us-ascii?Q?/AQdhYIgw60dhXvuBydM8pGCBmqXQO+VlXXdS274y61IMdciBwfygpMM4dcS?=
 =?us-ascii?Q?wnY8FBnuDKQHBddHeV/XDCgnb8JQaKCwPLajzO5rLD/jd+V1Y7XsOO7XaZK4?=
 =?us-ascii?Q?kN60tHkMw5S4O+6sPLKWOuMSX6YdAkkC/Dtb1GS9elv73VG6KlC9kFkCRk2L?=
 =?us-ascii?Q?F5UMk9hGIT8mrKYhzFPexi2x5a0Au6nJaQAjh62JG0DKBi4v/YFvus6sNUbi?=
 =?us-ascii?Q?y8v6SkF7qY21kLlK4s2I684J4dUGFyiWmX3eE+aOode21klox4s0ThBRN72E?=
 =?us-ascii?Q?zSak0C+4HZEv5cW9tZkkJnBzMH/lpDZaZfSgmH+Gbnb1cGsbLMedJhitP6tb?=
 =?us-ascii?Q?u5e0GnCv6Mxm5YY9nCTKPN82gyJDu5Ba/V/z4Xvw7RYhuAXR9YiCKlR7KL9D?=
 =?us-ascii?Q?6pysR+egg9DjK1/yJR3cVhFIs4PX/0Xdz+0GyL+QcO46jZGOKzxRuJzF2VGQ?=
 =?us-ascii?Q?Bl7cgv9XWbaOYEwo3sCxS3FAMnIgR9uNfg8cHn1jjTtiGBwfedmPf7se5YcL?=
 =?us-ascii?Q?KPJEXgUW4sRMABYEEBVbKwX8HPzcPqbTaZQKxrHT+igtV8+pUacayYcH4OUM?=
 =?us-ascii?Q?sveJ/siRGplIEAJxQHCHxbbG8HQIW4yhJEnYAFYbVx8CcVofsnXzc/YDdHAP?=
 =?us-ascii?Q?3EcYlcz+Uw0jZLxjkpfIIKUKCj7nk7SrRic/7lDdrdtQw3lBr0no7Ef1jbuo?=
 =?us-ascii?Q?BtWdMshGJ9boDJ9vnoxPWgau+naahgEmAD1atk+lJGs4e3Q2Qw0uS9QKARIC?=
 =?us-ascii?Q?qtEiir+vD1hce0Q/t7eLifDdg3f+oIorKme9wpwkbDOKBsttSg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230032)(82310400018)(36860700005)(376006)(1800799016); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:52:39.9327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c955b7a-e26c-43ad-1059-08dc8a36e7c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119
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

From: Rodrigo Siqueira <rodrigo.siqueira@amd.com>

When users run the command:

cat /sys/kernel/debug/dri/0/amdgpu_dm_dtn_log

The following NULL pointer dereference happens:

[  +0.000003] BUG: kernel NULL pointer dereference, address: NULL
[  +0.000005] #PF: supervisor instruction fetch in kernel mode
[  +0.000002] #PF: error_code(0x0010) - not-present page
[  +0.000002] PGD 0 P4D 0
[  +0.000004] Oops: 0010 [#1] PREEMPT SMP NOPTI
[  +0.000003] RIP: 0010:0x0
[  +0.000008] Code: Unable to access opcode bytes at 0xffffffffffffffd6.
[...]
[  +0.000002] PKRU: 55555554
[  +0.000002] Call Trace:
[  +0.000002]  <TASK>
[  +0.000003]  ? show_regs+0x65/0x70
[  +0.000006]  ? __die+0x24/0x70
[  +0.000004]  ? page_fault_oops+0x160/0x470
[  +0.000006]  ? do_user_addr_fault+0x2b5/0x690
[  +0.000003]  ? prb_read_valid+0x1c/0x30
[  +0.000005]  ? exc_page_fault+0x8c/0x1a0
[  +0.000005]  ? asm_exc_page_fault+0x27/0x30
[  +0.000012]  dcn10_log_color_state+0xf9/0x510 [amdgpu]
[  +0.000306]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000003]  ? vsnprintf+0x2fb/0x600
[  +0.000009]  dcn10_log_hw_state+0xfd0/0xfe0 [amdgpu]
[  +0.000218]  ? __mod_memcg_lruvec_state+0xe8/0x170
[  +0.000008]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000002]  ? debug_smp_processor_id+0x17/0x20
[  +0.000003]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000002]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000002]  ? set_ptes.isra.0+0x2b/0x90
[  +0.000004]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000002]  ? _raw_spin_unlock+0x19/0x40
[  +0.000004]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000002]  ? do_anonymous_page+0x337/0x700
[  +0.000004]  dtn_log_read+0x82/0x120 [amdgpu]
[  +0.000207]  full_proxy_read+0x66/0x90
[  +0.000007]  vfs_read+0xb0/0x340
[  +0.000005]  ? __count_memcg_events+0x79/0xe0
[  +0.000002]  ? srso_alias_return_thunk+0x5/0xfbef5
[  +0.000003]  ? count_memcg_events.constprop.0+0x1e/0x40
[  +0.000003]  ? handle_mm_fault+0xb2/0x370
[  +0.000003]  ksys_read+0x6b/0xf0
[  +0.000004]  __x64_sys_read+0x19/0x20
[  +0.000003]  do_syscall_64+0x60/0x130
[  +0.000004]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
[  +0.000003] RIP: 0033:0x7fdf32f147e2
[...]

This error happens when the color log tries to read the gamut remap
information from DCN401 which is not initialized in the dcn401_dpp_funcs
which leads to a null pointer dereference. This commit addresses this
issue by adding a proper guard to access the gamut_remap callback in
case the specific ASIC did not implement this function.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 49 ++++++++++---------
 1 file changed, 27 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index de6ee6bf0a88..0bfab66b8038 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -289,6 +289,7 @@ static void dcn10_log_color_state(struct dc *dc,
 {
 	struct dc_context *dc_ctx = dc->ctx;
 	struct resource_pool *pool = dc->res_pool;
+	bool is_gamut_remap_available = false;
 	int i;
 
 	DTN_INFO("DPP:    IGAM format    IGAM mode    DGAM mode    RGAM mode"
@@ -301,16 +302,15 @@ static void dcn10_log_color_state(struct dc *dc,
 		struct dcn_dpp_state s = {0};
 
 		dpp->funcs->dpp_read_state(dpp, &s);
-		dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
+		if (dpp->funcs->dpp_get_gamut_remap) {
+			dpp->funcs->dpp_get_gamut_remap(dpp, &s.gamut_remap);
+			is_gamut_remap_available = true;
+		}
 
 		if (!s.is_enabled)
 			continue;
 
-		DTN_INFO("[%2d]:  %11xh  %11s    %9s    %9s"
-			 "  %12s  "
-			 "%010lld %010lld %010lld %010lld "
-			 "%010lld %010lld %010lld %010lld "
-			 "%010lld %010lld %010lld %010lld",
+		DTN_INFO("[%2d]:  %11xh  %11s    %9s    %9s",
 				dpp->inst,
 				s.igam_input_format,
 				(s.igam_lut_mode == 0) ? "BypassFixed" :
@@ -329,22 +329,27 @@ static void dcn10_log_color_state(struct dc *dc,
 					((s.rgam_lut_mode == 2) ? "Ycc" :
 					((s.rgam_lut_mode == 3) ? "RAM" :
 					((s.rgam_lut_mode == 4) ? "RAM" :
-								 "Unknown")))),
-				(s.gamut_remap.gamut_adjust_type == 0) ? "Bypass" :
-					((s.gamut_remap.gamut_adjust_type == 1) ? "HW" :
-										  "SW"),
-				s.gamut_remap.temperature_matrix[0].value,
-				s.gamut_remap.temperature_matrix[1].value,
-				s.gamut_remap.temperature_matrix[2].value,
-				s.gamut_remap.temperature_matrix[3].value,
-				s.gamut_remap.temperature_matrix[4].value,
-				s.gamut_remap.temperature_matrix[5].value,
-				s.gamut_remap.temperature_matrix[6].value,
-				s.gamut_remap.temperature_matrix[7].value,
-				s.gamut_remap.temperature_matrix[8].value,
-				s.gamut_remap.temperature_matrix[9].value,
-				s.gamut_remap.temperature_matrix[10].value,
-				s.gamut_remap.temperature_matrix[11].value);
+								 "Unknown")))));
+		if (is_gamut_remap_available)
+			DTN_INFO("  %12s  "
+				 "%010lld %010lld %010lld %010lld "
+				 "%010lld %010lld %010lld %010lld "
+				 "%010lld %010lld %010lld %010lld",
+				 (s.gamut_remap.gamut_adjust_type == 0) ? "Bypass" :
+					((s.gamut_remap.gamut_adjust_type == 1) ? "HW" : "SW"),
+				 s.gamut_remap.temperature_matrix[0].value,
+				 s.gamut_remap.temperature_matrix[1].value,
+				 s.gamut_remap.temperature_matrix[2].value,
+				 s.gamut_remap.temperature_matrix[3].value,
+				 s.gamut_remap.temperature_matrix[4].value,
+				 s.gamut_remap.temperature_matrix[5].value,
+				 s.gamut_remap.temperature_matrix[6].value,
+				 s.gamut_remap.temperature_matrix[7].value,
+				 s.gamut_remap.temperature_matrix[8].value,
+				 s.gamut_remap.temperature_matrix[9].value,
+				 s.gamut_remap.temperature_matrix[10].value,
+				 s.gamut_remap.temperature_matrix[11].value);
+
 		DTN_INFO("\n");
 	}
 	DTN_INFO("\n");
-- 
2.45.1

