Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BA4E6B27D
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Nov 2024 13:50:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6112C10E9CE;
	Fri,  1 Nov 2024 13:50:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nVfWTz8F";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39CDF10E9C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Nov 2024 13:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loCJS0Be0vvfZLTtMONJPBZHH275jl56J9PfixeVf1ldzEtzPHfrAafXkjLSgFYFHumpQphluldDKqt6KUQk8lYcAO8NhwDBr60tUEDYH59IvctNpHFtwvcjKrx580uT8vwVcOUCokN41sWxPvvGGUX7PEPgc1Cwkwvhx3eVcPDBi2ZVzmGLtGLkEWGdqnlDAZHXh9YI8Ku8KLefvmS7R2mEFac0a0/TYNOEr9VZXos4rsMMpW0GhO6lZx7E0umox/ZzuAi/wRtOxlNK1TNWLWU/5DxciYq2QY3+Yh058/yIEf+dl5W64QIR5YYKeD5G9v5w/jBhI6Dd/W19rg5Zag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csz/T4HZIbtc8tbx1q3seIBd5M993t6vAxzmtU8AceY=;
 b=CaTJ86eUlLUL82Qcgk1BR26bbOioVDWBx662E9GgHeEZTY0bjxuf9oKFaOVgV07m6+70IvpjMOG4O30sEBBJ9PQKuNTNkPX3P/pyNlZeWWnZy+fz3b3Iu2yYKzIfC760j8n3eyGIr4/tgq+9qQf597kYu55P7olNahMwnTerzYg4P/KXhXQS3FZPxETHwrh47IdDVttDAaHnmhl+am2QNmUkoU75gl2ojWedMGHqfecpEq9V800rP6B4VUS9xaz3elaRQMkHQ6i/GS+58/2GbhKvtpmoF47R7bw9qeIZZkv/iq5wk/jRhrpuSeBiPq+alt2F+pE0Hj0aOB+1kBVwig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csz/T4HZIbtc8tbx1q3seIBd5M993t6vAxzmtU8AceY=;
 b=nVfWTz8Fnrwz/V8aS7grhMLAuN8o5YdSGez/bTMXFsc+1vg2RJymgRTeKaw+LUAj6LwSXmcRZvS5MwjoHqniSnoK/xLV+PtL1e5xJEznds4at0wzhGiokruUbODyTzZJbX1hpI/Ar+73f6BhtjjKJZRVRs67Sa1Bx3rYrcDbFOQ=
Received: from BN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:408:e4::9)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.18; Fri, 1 Nov
 2024 13:50:17 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:e4:cafe::84) by BN0PR02CA0004.outlook.office365.com
 (2603:10b6:408:e4::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Fri, 1 Nov 2024 13:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Fri, 1 Nov 2024 13:50:16 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 1 Nov
 2024 08:50:15 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>, Charlene Liu
 <charlene.liu@amd.com>
Subject: [PATCH 10/17] drm/amd/display: Remove otg w/a toggling on HPO
 interfaces
Date: Fri, 1 Nov 2024 09:49:33 -0400
Message-ID: <20241101134940.1426653-11-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
References: <20241101134940.1426653-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ffbd40c-26a0-401a-c690-08dcfa7c1e32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uogcxW3Y2JnfnNe4nYNfACA2Cke8cbw6x44w6SxKmVCgDrD/7uliQuPzhX4b?=
 =?us-ascii?Q?Tu/1bLLnmRrKtjCj6uHUI4UszHYDqhnqaFNsHKXKmSzFBVQlNOMo8WBkZdL0?=
 =?us-ascii?Q?hAKq+j3RF+/V2Oyna+n3CVJpiGXCyW8ZtmOankGRCQCIGDms5yu+A8DpkpIn?=
 =?us-ascii?Q?ykaqa0GkQEf4x2mMJoCbk7Z1Du2IUkPsIRn2SY/UXw1WPITV31BO1n23FFdn?=
 =?us-ascii?Q?BP4GGedYlKSO/t+bB2lT9gRLFOrXx4psT0AoroJsp1CsBQi9C+GShfk55DB1?=
 =?us-ascii?Q?BXoQHttxEAyMIApeHgu/2PNZDPYxxfG20iKH8w93OU9jZ35Amugwv39rPv8Z?=
 =?us-ascii?Q?/WiUd/kiCbK8o4sdwtaYrBXAFVsyF8lOLm4aBk/zIoQwk8/SzlGyv+Awx12X?=
 =?us-ascii?Q?eb+zly1I9kJUb7B+xiT3zRF8uD7SY+uLhA7dAk3JI/PWGudSYkZnBorFOfy2?=
 =?us-ascii?Q?xESMYlmKRlVg6J7U8nsNgwwd5U8G4x+W96JT/j9R6JDguhUt9VgREQJBJ1v7?=
 =?us-ascii?Q?c/kzdOHuVE4XW3ki2oTJgB8TiQiQ7mvXeIxVNuT86RAtYBB7/srbsEpi2PUV?=
 =?us-ascii?Q?jG50TGjk0XuFevjitrz6uy7Nc+URDKV0AYqfgEq/KOndSJmS6rLiNDWiF8Tj?=
 =?us-ascii?Q?OZuL/68R3eJyXU4LXA2u0DojiHj+unxn9YXouLxjmYV6keI5oXmeR0zu2h8k?=
 =?us-ascii?Q?CUZv/iFDQDpcF53fgO9dkN9iqkl13+7ARGPgr59GNi0eVRCg8PKdOWExy4BA?=
 =?us-ascii?Q?0VFrhi0E+M5QxJdwrllHs7Z5FalA9mc5pCG/uEC47v0OHgQ++nvE2/fKDquH?=
 =?us-ascii?Q?wobM5V3BBO5claAARyMUSj2Df//eGWWQ30jWS+S2kqrhczWdhPvPVhV16MHU?=
 =?us-ascii?Q?0EQML1OkyoIAbYBE6NMzf5bBcgXk+Krb8luE+AOuT2kFScgKXNqqeeLCyT0i?=
 =?us-ascii?Q?qmtWWtLWzs9xpxc74ythQ5RfflzRqeX/XwpdK97LjEbCneiaUHlhNC3mm4TO?=
 =?us-ascii?Q?FIX/Xp7+ELQ1RGCZg4H5JchNhRy0ZN7pDU8ON1tMd4+dyF01hBD86BqH8PpQ?=
 =?us-ascii?Q?pTmYPfz0q8owFr42nShxR6WvaoIzjFX9XmhMOjD69qAhweIoj7jSrF40mmE1?=
 =?us-ascii?Q?Xbgvnf3c5+qhkDdVcZSacjTeHrIxFAZDqEXn+lRMmnRRt0BGvy7JBNUsApMU?=
 =?us-ascii?Q?rJhs03VLlXk2JFUSDKiQVSmUQXcSWMbVt0qvKZjTqy8mFJtmxqdwfK2OK1D3?=
 =?us-ascii?Q?zVW9GNWGGQkP3cDSuzM1TNavTBVvPfZHgK6AEMaw2HmtCrT9aEWwMdSwwleh?=
 =?us-ascii?Q?tq2INAPx3/S9XIJtqObwqrA0maVPdzLc1Obe6X7kvE2FtN9hEbo/bvcxRftP?=
 =?us-ascii?Q?VLbb4v2ItsmmeMEFJ7OxpmqLW34xu7D48Ml8uwDXPlgYWSQd7g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 13:50:16.8519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ffbd40c-26a0-401a-c690-08dcfa7c1e32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[why&how]
Adjust otg w/a disable condition to include HPO explicitly rather than
assuming it is implicitly used through DP2.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c   | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
index 07b49b4030f9..b77333817f18 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c
@@ -151,7 +151,15 @@ static void dcn35_disable_otg_wa(struct clk_mgr *clk_mgr_base, struct dc_state *
 		new_pipe->stream_res.stream_enc &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled &&
 		new_pipe->stream_res.stream_enc->funcs->is_fifo_enabled(new_pipe->stream_res.stream_enc);
-		bool has_active_hpo = dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(old_pipe) && dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(new_pipe);
+
+		bool has_active_hpo = false;
+
+		if (old_pipe->stream && new_pipe->stream && old_pipe->stream == new_pipe->stream) {
+			has_active_hpo =  dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(old_pipe) &&
+			dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(new_pipe);
+
+		 }
+
 
 		if (!has_active_hpo && !dccg->ctx->dc->link_srv->dp_is_128b_132b_signal(pipe) &&
 					(pipe->stream && (pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal) ||
-- 
2.34.1

