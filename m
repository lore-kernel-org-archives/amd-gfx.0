Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D53ECD6E6D
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AB88112845;
	Thu,  4 Jun 2026 14:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n/OYrWMd";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B871B112842
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWsaTdg6bmxg85EtFUAnQEmWONVzRPGEIJ1yyL7kR0zDs0Y8WS4vRYRJUGupw0VA1GWGYHn/gqM+1QPxKWwG9dDpwGL0XUgIpX5786Q+7vRXxfb8igygyaASsE21hbtLVbmafCH5e+zoSCuFYrFNNVqEAHt/ZWoVv05Tr477u8BBsHUNWhmmup1bA82xme6Ed8Y5yMLjeQaCwT20IIXrEdz++oVIEVivHX1YJiCwa3JZR8aFFUr49eVaMMGamZC6jgVqtF43PVT+R3OMwzdnfQbXSL5mo6EK8EMg1s0H8nDIMMW018ZN8ImAebVqJ0EMVhYiDqpbEKcrevXgNM8eiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UaDGogBtI3fghB+4gJ1qE4sEC3UgiHh0FSLgdrLV8Ps=;
 b=ELaYeoRGgzx6CGrFu3+wwB0JlBZx+FOkv4NcU/IdHwxicWdpFNtR2RNjN3yfPGtbrs43iT79ixcos3K9YXOGYL1efNRRrvdUgLkd8piwxCsGyrS4HZRr3vmUYWEkmTThl9wAOsrPhGMGCH7jcjMsDP+7vBXTXo1mxp67H7IcclsfhJnMKA7cXNb7l24DCcodxml3O1G+0t/6MgwyebujKkBb62vhKLDBqYNsWHFX1gceMNQuqqAEaZiTf8JxpgsGeC6TB0BZISrdXlcy0Ie35j49RpjDaSJ+nyB35LlbwjQ4UPs+fSOi74Q+cl5gHgTlJ9V6XDqEWDihSw27vMPfdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UaDGogBtI3fghB+4gJ1qE4sEC3UgiHh0FSLgdrLV8Ps=;
 b=n/OYrWMdd6uZvYquphAbRhDpxw48ZyZngh1Esj8rnHIataCkxxOcRpyJysuGlcP6TRft4CpHMtRzSxff1yVXD4HacyzuIxJiyEqI4dRqaSQ7c0CnZnswZH2upGqo05wZ1LbOI/B0bLkxo0HrOauZnBKPh82CTFSRKh2SpT7GFGc=
Received: from BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::18)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.8; Thu, 4 Jun 2026
 14:54:56 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:5b6:cafe::a1) by BL1P223CA0036.outlook.office365.com
 (2603:10b6:208:5b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:54:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:54:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:54:55 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:54:49 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 08/24] drm/amd/display: remove redundant code in
 amdgpu_dm_replay
Date: Thu, 4 Jun 2026 10:52:02 -0400
Message-ID: <20260604145428.809959-9-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9f8b6b-fa88-4b1f-473c-08dec2493e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|11063799006|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: LWBnIdW5rKWJIdJkcfeaTQt3wLBlWFlGk//jlTj2HD/l5HYCPPQ8ZZwsl8Zcjl5jxP5D0+01Lue7oChZZecz54103AZ/Rk1XJzTGf7GOvtYD8KdXKoIMoLXW0a+x8XWb/z3SPtpkKpQQoCkzATs0+oISUzosHSNFl4cRdsuJj+GBegfXQ7mYZgj21dsVhnqux2pQ6QOld2dhyZ+YugAvnk2wMYOw0JWVvvYEjaHQ/q8lihKH94WI4+uLj8DRxMWUvy4I0w9lmeVPyACpGko339FFfIie14YvplgsisOXHENDsjsJyJRlPAaUAUauRobXEZYOSyKYLIdjr18rmZ8yxpQyS27NS1f0gV18hmRfLbtycEFszCSe11bTfqDG9aZ4n8WgmYH2KfHLzrUKOtb90lx8/82tj1Pqq8VTi4sbFA+D2SMb4akK5J3/524VBZN8TCpyaBI5f9z5b1LN8a9wNyu0V+bZgcdA+2t4BC5d0NNm0vmq+goj9aq3FPnkg+Svj3oEIEXYLSfYBKNKkTHr66iDkCz/kj7uzHL6QbxXEcCB8ooUhAxVgfpDmj0LVwXma/xbthiKvaB0HRwXNSQrkm7DrSzBdaQNCQ0Ni91tEWDhVu5Q/c8LET8XACkfrGB4BvfYoPnVu7AyZz4gnKQRZFl7SQ60Tw1m8NhHDyrbSRkUln/eOJnbW/unEWTtPSvqIiWZg3tg6fNFwPTt5bZXXG2c4LLwxXH6JY+q6kCYH84=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(11063799006)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VaYcSjM2TemgOxwkrYbChEbf+UOW4Bf3IscMs/++iYNlID50vBDmuJT+kDYjA9UPDULh35FonNZqZ2rFJ7dfeS9qHpC446CE9aDTWuEhU1+Ba2l5N2PnNUh2ydviJOii0M9cRENox4LCR2o/d0OhecNn3/zRiTjAoYRiX15DIdnEqRXddHNHWXpsMJ3FazfKIlSwhlzhQQ0behOWvsy9RvTvLNbpxs/KaWt60fSTdWqs5MWWAyv3qc2fk5mazKfaWgQGecxBTzsedts0XeO5X9ewBcSqsmRrp/zeo93goCDcDP/7aR6GbmToXD89GJaK/ATK67v6D5+Mvxi6+eF/kaxwGsFOjnhLwDCHVFu7RLWHyaidlOZKoubb8QRhDNb8zyaWVL8jTdnjx7Z00dk3h0z7vPYMdKhF9yY3/y/NQSEFvfjyHr4V6LPp+HYcC/Ls
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:54:56.2545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9f8b6b-fa88-4b1f-473c-08dec2493e11
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815
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

From: Alex Hung <alex.hung@amd.com>

[WHAT]
In amdgpu_dm_link_setup_replay(), nom_coasting_vtotal was
used only once immediately after in set_replay_coasting_vtotal().
Inline the value directly to remove the no-op alias.

In amdgpu_dm_set_replay_caps(), replace link->ctx->dc->debug
with dc->debug since dc is already assigned as link->ctx->dc,
eliminating a redundant pointer round-trip.

Assisted-by: Copilot:Claude-Sonnet-4.6
Reviewed-by: Ray Wu <ray.wu@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
index 22aa4305d2af..f3cea2aba901 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
@@ -121,8 +121,7 @@ bool amdgpu_dm_set_replay_caps(struct dc_link *link, struct amdgpu_dm_connector
 
 	debug_flags = (union replay_debug_flags *)&pr_config.debug_flags;
 	debug_flags->u32All = 0;
-	debug_flags->bitfields.visual_confirm =
-		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY;
+	debug_flags->bitfields.visual_confirm =	dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY;
 	debug_flags->bitfields.skip_crtc_disabled = dc->debug.replay_skip_crtc_disabled;
 
 	init_replay_config(link, &pr_config);
@@ -144,7 +143,6 @@ bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
 {
 	struct dc_link *link;
 	unsigned int static_coasting_vtotal;
-	unsigned int nom_coasting_vtotal;
 
 	if (!stream || !stream->link || !vrr_params)
 		return false;
@@ -159,12 +157,11 @@ bool amdgpu_dm_link_setup_replay(struct dc_stream_state *stream,
 	calculate_replay_link_off_frame_count(link, stream->timing.v_total,
 			stream->timing.h_total);
 
-	nom_coasting_vtotal = stream->timing.v_total;
 	static_coasting_vtotal = mod_freesync_calc_v_total_from_refresh(stream,
 			vrr_params->min_refresh_in_uhz);
 
 	set_replay_coasting_vtotal(link, PR_COASTING_TYPE_NOM,
-			nom_coasting_vtotal);
+			stream->timing.v_total);
 	set_replay_coasting_vtotal(link, PR_COASTING_TYPE_STATIC,
 			static_coasting_vtotal);
 	return true;
-- 
2.54.0

