Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC46DC3DA5D
	for <amd-gfx@archiver.kernel.org>; Sun, 21 Jul 2024 06:22:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CF7B10E19A;
	Sun, 21 Jul 2024 06:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="m9MDO+KF";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00ADE10E19A
 for <amd-gfx@lists.freedesktop.org>; Sun, 21 Jul 2024 06:22:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3t3QvxFye9oqjZtcPHZeeOrmGY/3DKKBa1LgX++3RLSjjeDk19AV8KezzYgE5tjA1qkRzMKNrSbAF4wqs0qI+qw1w+NQmgmSw54Yc+bM8a13SO3DMXx4cKmtk3gMjcWXslHbMcCNNY3iN86/6W0M0GHuFBHR1HNhuJ936atzpYyjayzER7Fzf/Wkx7l7KVjtgDhjYztnQUqXDetNX86pnOlWvmhLo8BXlarUyNcm5THPFDo3Mr97bVkAKkOdINEA3dtOQ4X0LsPYI43A+Po2EqcKhvqorQJJ8orfY44iA+gMt2VUPojq6ucA31kB15A40vHnsEQ57iAwMs4ph+72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBvlxfPWdG0uPrMGxQqSbaxsMm7/2+saQ5yblUIWD8s=;
 b=oRKUmnaS/Ui8nyYWS9F68spETs/OjVe05o0qqphUBKwzDjAAMvc46ixN+Jd7H0V0r0gRaYAnr3Hj5lOXSjo+8T2UlNi3SjpAO6413pFR4C5XpksTeDEgTHABtNKZUOM1fIYEagurSygmLqrrGSmT7RSUh9gVNgGQeG8KLGqmcSO8RWoqGpUdzNTMDB3HaNCZwflre2I62uT0VRtNt2XkqbV/7a+p5ojRprbw4qfYaxLX5gJd2LMdm+FqagsScg8zkQW90fhXMGKSunD2JDGqNy66Ec2SR5yJ0gn469xHt+KKGdyxNPkgvbLwXt7fwoWgZ8sKNrJtyZxVzTQeR74ekA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rBvlxfPWdG0uPrMGxQqSbaxsMm7/2+saQ5yblUIWD8s=;
 b=m9MDO+KFowAWi0BFQ6ZQ2DMWCQO8yuI8elSjdpnXVy1UxU4LoqXm0HFIln0UZ8li1+ze7Aq6tb/TDqrVP7Yyb9idS7esCCGL2x4Bqa5jScCU5dqi/mDH4dK+H5AVcHIglPggv6DuA/xaua4sCoGUfqbM1h/LjPM2GvETTUaLM/w=
Received: from CH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::30)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Sun, 21 Jul
 2024 06:22:41 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::5) by CH0P220CA0018.outlook.office365.com
 (2603:10b6:610:ef::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Sun, 21 Jul 2024 06:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Sun, 21 Jul 2024 06:22:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 21 Jul 2024 01:22:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL check for clk_mgr in dcn401_init_hw
Date: Sun, 21 Jul 2024 11:52:12 +0530
Message-ID: <20240721062216.3151119-3-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
References: <20240721062216.3151119-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|BY1PR12MB8448:EE_
X-MS-Office365-Filtering-Correlation-Id: edd7bf3c-73f0-4396-cce2-08dca94d865b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VSwuO5097jQT8Vi+0TW+8F672AN2QiQdVXIY+MTOBplrLGmCRHGUihknoaWP?=
 =?us-ascii?Q?UYA6s2Ef/4Y2zA4RVSNFGHYTm/iKFG6aJHpt3Czcbb/HCsRX7x58pBcCBSe1?=
 =?us-ascii?Q?3Scmj3lAy9srcQ2Jom7C9840cfd6cXvYmLoET4gSYmvisftw/Xru9qnfHrZL?=
 =?us-ascii?Q?ZDInDmKqtsJW4+uxj0q9RHkyocDBQ/7RUxNXtC5OL6/Plspl0/HAkNcHNaD+?=
 =?us-ascii?Q?0getgJf6Jt2GW+pp50LT2jTEKlEFhjk4aXXFJYrt6A5xGJvu6Ybp+r3lIMyJ?=
 =?us-ascii?Q?1KnvPEoidIosVJ4PY2ASgUBA2fMTZ+08s48hnuBFoFvKkByTUHVHqMNzhx3J?=
 =?us-ascii?Q?y1Y3CXIAHhAcfKV4vSVIQCrX9pDI03Lr6rPI/VA54K6CVURXLU7Rk6XTfGx9?=
 =?us-ascii?Q?jO4VTdXhOYiPlM0PIFmmCZWA+E8JxoJ7mFd0De/UHD6JN92iR4Xv2BQyAt8Y?=
 =?us-ascii?Q?daQfSe9ETxiUrvk28wr2EnGglcB8B4VVl3ix3JgVeFyKCOweeZIRm7KX/Jjf?=
 =?us-ascii?Q?qVPjT/FV2oFWH0z7lDG/uN3HeZGJ8FL38xVDpCnF9JiTZjAwZWQKgB7qU1F2?=
 =?us-ascii?Q?ZSBa4FdLVg+nbkqHz6/X6pYEhazjlG7TBB2XCpWou9GbVikMBYycshhYEXPB?=
 =?us-ascii?Q?Jd3GGrokbP0hKBEYvuvQ2UosjnAlUeHk5yI15lcHadKBQYdaPnj7kze3bySx?=
 =?us-ascii?Q?i56Z6ZokbNjHVQAcM1GEx2XwanEuRQSIF9uvShHxXU8/5Y3JLuRZGL8QvHK8?=
 =?us-ascii?Q?sdm8ZzL9R328C8pEBJJNvGD5hXlo7JgaY5Qk5REsdrQgLQMfCWeEgVfp1dAX?=
 =?us-ascii?Q?MJo6IEJt3nqFUb7wObTNVl5EesC/2pdI1zx97NEeanV3Pie8XsdynmUAVT3m?=
 =?us-ascii?Q?lq19n1kFARuoYY4tQgb8gjImCtrlUYC7VJ4Z41jiNX0ifKqo8Qpshl49kGrz?=
 =?us-ascii?Q?TxSjvs30Y1ttCOk8jHVlCmdCmEWSFmulgpdKYN1N7WwnIakXhqE7y+p+2ONL?=
 =?us-ascii?Q?lumE+WHsWIe3depXUVKOZPi7aJqPZwVDQWxcK5F3dgZBw0p7lj/DLS5k1hxd?=
 =?us-ascii?Q?BdgQxMRVXEtw5VFjlBiAjWrZS8AdKCnrptJ13Stfx2XwIHisTnOtdl5U8UiN?=
 =?us-ascii?Q?argVYIzr5pgFK7ZuoGaOD/DYfUW86T2oSlGCITFg/r8pDcM4rpsqzezqS3l2?=
 =?us-ascii?Q?b+rP8WgRoUNAZtXYGKxm8720QHVDxozX7yi2NY1i7aCZncbp2qAjKzpKo3Ea?=
 =?us-ascii?Q?yKjYkQlv1PDjod1sDn40yCQgUmm1YYwr+IP/lapW89PSj14dzrp79SeT+Sgn?=
 =?us-ascii?Q?58Ljj0oPfMEctEc2TdbpeN4nShJTMDAgycmw47Ph+/ukQT5v/qqj7dXbtlkV?=
 =?us-ascii?Q?peHqzKt77X5RbsQjaulYZKArXYFVELpbpnTl5hA7D+JKNC5eB7u1h7dXcx/R?=
 =?us-ascii?Q?4W4+BQwI5NufStp9KEMr6Ka2tTEem0SK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2024 06:22:41.0725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edd7bf3c-73f0-4396-cce2-08dca94d865b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448
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

This commit addresses a potential null pointer dereference issue in the
`dcn401_init_hw` function. The issue could occur when `dc->clk_mgr` is
null.

The fix adds a check to ensure `dc->clk_mgr` is not null before
accessing its functions. This prevents a potential null pointer
dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn401/dcn401_hwseq.c:416 dcn401_init_hw() error: we previously assumed 'dc->clk_mgr' could be null (see line 225)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c    | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index f4c1547a368f..16ffb41abc6d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -413,10 +413,11 @@ void dcn401_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb) && dc->res_pool->hubbub->funcs->init_watermarks)
 		dc->res_pool->hubbub->funcs->init_watermarks(dc->res_pool->hubbub);
 
-	if (dc->clk_mgr->funcs->notify_wm_ranges)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
 
-	if (dc->clk_mgr->funcs->set_hard_max_memclk && !dc->clk_mgr->dc_mode_softmax_enabled)
+	if (dc->clk_mgr && dc->clk_mgr->funcs->set_hard_max_memclk &&
+	    !dc->clk_mgr->dc_mode_softmax_enabled)
 		dc->clk_mgr->funcs->set_hard_max_memclk(dc->clk_mgr);
 
 	if (dc->res_pool->hubbub->funcs->force_pstate_change_control)
@@ -438,7 +439,9 @@ void dcn401_init_hw(struct dc *dc)
 		dc->debug.fams2_config.bits.enable &= dc->ctx->dmub_srv->dmub->feature_caps.fw_assisted_mclk_switch_ver == 2;
 		if (!dc->debug.fams2_config.bits.enable && dc->res_pool->funcs->update_bw_bounding_box) {
 			/* update bounding box if FAMS2 disabled */
-			dc->res_pool->funcs->update_bw_bounding_box(dc, dc->clk_mgr->bw_params);
+			if (dc->clk_mgr)
+				dc->res_pool->funcs->update_bw_bounding_box(dc,
+									    dc->clk_mgr->bw_params);
 		}
 	}
 }
-- 
2.34.1

