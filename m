Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0867EE7718B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jan 2025 18:16:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3AFA10E0B0;
	Thu,  2 Jan 2025 18:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gdzHlBAZ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4424D10E0B0
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jan 2025 18:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqhKYNXNnCHwPDqEze0heIG0FMZxL3uszMM1S1RyT7JgHqXk7bcY9E5OaUoQFB0vzedblQvYpq+h4skIthA/yCQJcv6DpJmt2LE14ZKAwI9CTBg28WNwCmWJsA5YlOncbxYHCOnBBNZEfTsEZcvirHjw1f9dNzoVSifmA0kEzzFj0Aw+5lMHhiQEsezf68V99i6vXCp92pl8WhFzDdx3s/+S7pbYP+lOeGHnBrVgtHuIzkouxdkWR4VwO5199co8CerOJvAnqg2h5Lh5SriaPkF7YN5YTT8jPXooY4Dz6OQnO8+XNh3PHZIAQNxzmtwve/H4anU8HfXyvqigOpnROA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byglUEUqavFGA88zDcdML7O5wvVJ6/ZDWy5xNFh1xk8=;
 b=O06IH8sFeL/rJAnzdpo0YvQhlVgyejC5mCdZ5jazhD231Ydh70bQq0rPKDPFSuc/I16oonN1xTMEP7AIN+Uu05EEDybCJnRJKS9/SBhZFCNysUeOt9J09yl1Q48IYuHorPGVbLxtSYIyAKRp3peIiqrzm+zdggxYLaHMbc6Yi74zs7cb+8VoM0O9+cC0XXNrHAyIYDJOCfRktfT215furPXNt8V9df+YyeUiBf6M8iAmcyhC2WFLP7mS0FgOWMZTIZM7El8z80wWWVeUNmJqtEJJGbkA1aLdezsfQWJ1YGjNjMYc9CryTwLae3KzjlmopG5hWVV8HsXonbrmwZ+x8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byglUEUqavFGA88zDcdML7O5wvVJ6/ZDWy5xNFh1xk8=;
 b=gdzHlBAZghjvwwC7NlRV+hxF6mbJo9qfywlH4kX+LbfjxOUPiFIvLH3TFZWCDs2Y3z4lpm+EgeuHaCyrs2UfbK+sC2tvem7fcADiuwNSPHQGGefcZr+dkHq1n4z+mUcV6G5kKfV6MhOuH6UYNOfkLNeV4XRChsshCDv+j3rkJWg=
Received: from CH0PR08CA0008.namprd08.prod.outlook.com (2603:10b6:610:33::13)
 by DS7PR12MB8232.namprd12.prod.outlook.com (2603:10b6:8:e3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 18:16:37 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::18) by CH0PR08CA0008.outlook.office365.com
 (2603:10b6:610:33::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Thu,
 2 Jan 2025 18:16:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:16:37 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 12:16:37 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Jan
 2025 12:16:36 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 2 Jan 2025 12:16:36 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <sunpeng.li@amd.com>,
 <aurabindo.pillai@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Optimize cursor position updates"
Date: Thu, 2 Jan 2025 13:16:31 -0500
Message-ID: <20250102181631.601338-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|DS7PR12MB8232:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2631d4-329c-4238-5c9e-08dd2b599929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sgYXbKnjJMPB8TWpkJU99g/FcQ4tZje7bmgIXcYni+wI1fc2z3NYKwOPvOdn?=
 =?us-ascii?Q?LWIk+WAN9ENPEFoB04VsIO1haiNfomd5ml7yZ3ymK6BzLI3f/adUXG71VTiA?=
 =?us-ascii?Q?oM+myYsqXKVXfNCYTO2KGNoDl8vvxTvi9z13RyDnI4h7KVoRw9cRpZ+W/uVx?=
 =?us-ascii?Q?Fe4rPIqbzaSg0cetLtF0C8Emk5xkkK6e1ZTOHCjvX61wve1utSgwibSZZnpv?=
 =?us-ascii?Q?LvbsYjvqoX7AfL3RmQLmpkys3a8RJXG+fZ/bA6zTkAJFajU7r+f34ycg304J?=
 =?us-ascii?Q?7y+8q5MH4KHZs0AyuDYWvOOARZ9sFsthgQ/eo5LFdpQCkmpQ8don/7UF80ee?=
 =?us-ascii?Q?Ikgm5G+xNH7RkUG+QUIzmlWkUuqIKgLn4ucaDfKjvkI2CrgxzA4Kj/CUUb5w?=
 =?us-ascii?Q?gIGhsUInNmDLLnzK42jkk9xKqxHgrLL+gRKE5NtbxDLmWw286nwTji24lM/Z?=
 =?us-ascii?Q?FzCNa+6ov7k2O8FhqPjQbmbZ35rFadyB7W6lPnFscsOrn+/6RTVojrg7YDwm?=
 =?us-ascii?Q?ErGVU/ELAxUpbW2E50RbEds8NCaOqb9Qkpf1Ee2GhmrueIljG6njEo4noq6v?=
 =?us-ascii?Q?Y57HMX23FF7nmNxJUpulWh6AAt/DeBeFKSzusnFtegdEOeXgS3VbpiJLKCkX?=
 =?us-ascii?Q?IOUaEOLoJoJs1f2FMhOrVeldywz54ZANl3JKxF4ydvwUhUnbuHhdA9ENnbLg?=
 =?us-ascii?Q?RY5YAOugTsoXkyN13tupEZ+29wUcrrZUOb88iLxA+c2KOp25tW893TAOW89n?=
 =?us-ascii?Q?2oqA7SxX5muAPnXN2DimcN19aON3JoV6NEpEK2yRjaOx6uSXjxda5iwuoe9g?=
 =?us-ascii?Q?PegeJ3p/q8NTUxjZGTquj46KrO428Fn0utUO9kDCYpw03ftMMjaTX5NV1+7X?=
 =?us-ascii?Q?b5CIO3Xgx1qmTQQhl6qUrjGuljFlX8+BU9L/rfykKRZdhNffpzumWu7gntC9?=
 =?us-ascii?Q?f/rPmT7Vew6wTqpjZ+dbR9s3AL1f4SvMWij3WxMt/MwLIa9Rua/9ywO+2MwB?=
 =?us-ascii?Q?0GXeuMOk79bP8FhZfgYXfCLb51T0muQ5zWae2UessNBDDuxIl9OXy/icuwlz?=
 =?us-ascii?Q?f0QkLGSY0NwHcMwUpUhwhvYiku91Csfpev20yHP0e47Hnzwj1sIzPAKKP5Zh?=
 =?us-ascii?Q?/ZhwULHidQEV7ITk53SAkYslxdlRFN0QnbtWY/AAHH2OR4C5jed8J59VVwdf?=
 =?us-ascii?Q?21ChuytEWjo7xZ5y/rVIn+nEUkqI9Vg2U4dnrFjAGivc0eYDfyNhR9pQ9JjT?=
 =?us-ascii?Q?AE4viXMvx7a+56MjvthjSjQzconPE6lDEelcL6IiecBcwpnD7k2olefAP8Q6?=
 =?us-ascii?Q?mzRtqCJSaYW5H4C27mCa13bOTssX8ZuIcliffXC/mayR2Wt0E0nAHGRjb8bV?=
 =?us-ascii?Q?eE70S8kk1U7nNxXnPQCT+sulp34qsYhg1SsCBBeqFsZnjZC43fPHASDLS8Yi?=
 =?us-ascii?Q?OwPA/1vC6d0AbANyegwteMqr/uX5a9IfVDqoJx9xK31NqOhUdJphny8IgWT1?=
 =?us-ascii?Q?Phgn+Bkt87ta+xM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:16:37.7249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2631d4-329c-4238-5c9e-08dd2b599929
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8232
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

This reverts commit 742d670b416b272e42f6674e30e393bbb8ffa6d1.

SW and HW state are not always matching in some cases causing cursor to
be disabled.
---
 drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c   |  7 +++----
 .../gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c  |  6 ++----
 drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c |  8 +++-----
 .../gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c   | 10 ++++------
 4 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
index 8f6529a98f31f..e1da48b05d009 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
@@ -480,11 +480,10 @@ void dpp1_set_cursor_position(
 	if (src_y_offset + cursor_height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
-	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
-		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
+	REG_UPDATE(CURSOR0_CONTROL,
+			CUR0_ENABLE, cur_en);
 
-		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
-	}
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
 }
 
 void dpp1_cnv_set_optional_cursor_attributes(
diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
index 1236e0f9a2560..3b6ca7974e188 100644
--- a/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
+++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c
@@ -154,11 +154,9 @@ void dpp401_set_cursor_position(
 	struct dcn401_dpp *dpp = TO_DCN401_DPP(dpp_base);
 	uint32_t cur_en = pos->enable ? 1 : 0;
 
-	if (dpp_base->pos.cur0_ctl.bits.cur0_enable != cur_en) {
-		REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
+	REG_UPDATE(CURSOR0_CONTROL, CUR0_ENABLE, cur_en);
 
-		dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
-	}
+	dpp_base->pos.cur0_ctl.bits.cur0_enable = cur_en;
 }
 
 void dpp401_set_optional_cursor_attributes(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
index d537d0c53cf03..c74f6a3313a27 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn20/dcn20_hubp.c
@@ -1058,13 +1058,11 @@ void hubp2_cursor_set_position(
 	if (src_y_offset + cursor_height <= 0)
 		cur_en = 0;  /* not visible beyond top edge*/
 
-	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
-		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
-			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
+	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
+		hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
 
-		REG_UPDATE(CURSOR_CONTROL,
+	REG_UPDATE(CURSOR_CONTROL,
 			CURSOR_ENABLE, cur_en);
-	}
 
 	REG_SET_2(CURSOR_POSITION, 0,
 			CURSOR_X_POSITION, pos->x,
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
index 3595c74a3a2fb..d38e3f3a1107c 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn401/dcn401_hubp.c
@@ -730,13 +730,11 @@ void hubp401_cursor_set_position(
 			dc_fixpt_from_int(dst_x_offset),
 			param->h_scale_ratio));
 
-	if (hubp->pos.cur_ctl.bits.cur_enable != cur_en) {
-		if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
-			hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
+	if (cur_en && REG_READ(CURSOR_SURFACE_ADDRESS) == 0)
+		hubp->funcs->set_cursor_attributes(hubp, &hubp->curs_attr);
 
-		REG_UPDATE(CURSOR_CONTROL,
-			CURSOR_ENABLE, cur_en);
-	}
+	REG_UPDATE(CURSOR_CONTROL,
+		CURSOR_ENABLE, cur_en);
 
 	REG_SET_2(CURSOR_POSITION, 0,
 		CURSOR_X_POSITION, x_pos,
-- 
2.47.1

