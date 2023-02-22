Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C01BDC64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51B1C10E407;
	Wed, 22 Feb 2023 06:42:37 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2074.outbound.protection.outlook.com [40.107.100.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F31A10E407
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1NeR6DxNQH+Nl609kLYn9Z4dPvaNx8koeuf7JYOKwCarJB4S2JJpIhOVj74TlvDcJLB9dK+3OmLkeRch3n0IUsHSbyCJLlu/SJhidQEE9JPR6NM7hQdOl7L92TeiGxzCom7eWwx6eqm5Y9iRurzV5pTYwcPy8GwrY6wf2qp7KLEA68jcEc/fkK8xhdDD2xpgRbJ5w/ofQ4s72QkYh+BwUOflM19qpz8fTPlXoHbYvjO+hC6H0wKgrnMyaHvjooQXrVeENTXU8fVSSJBEDtUaDSEmNU9m0RGmNhVS1mFV6JqengC98j2hvuVZpPHsq0+fjfxN9xZZf4qmf5vqQr4Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1qlK1tWrZ4kNJOajYm977tOt8qjxv2TmR6MP1uuk9t4=;
 b=JurY86H1yVXQD+dyMNArsOSSHmyL189tL8NmpA4vunJeNyRaC18fH1E/B4W/tudkzuiiusbJspa4CU7q+P++45jhDXYjQ+pRZDFKl31SIjHt+iE07Ct7TGK86/IQA9gYEp7xpmuUWjTxKbde1ACkBkDGo1HZW7tlf2kSikwNvQKwu+axHVJGylr068ZzhhJnpcBDdshifWq5/s5Uld1rKmVHwiqVN6fAX8+K3xG/UWcCcA6x7m/prNpiftQP/bgZYHWvzz2XXt/2oDVVAdqLrn6dlx7lywIKIJZf5bdnw76N64xPYqfzNlF4J6L9BvCxd3DloPMpHpn2cEprHmcGGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1qlK1tWrZ4kNJOajYm977tOt8qjxv2TmR6MP1uuk9t4=;
 b=VaG6SBs3IN0P9y/BodNMUDSDVUkz3L4BLXdjEOU4gRIzJ6W92jgXhME0Y+WJNoZ324sjW+mUTahjhUYGtPlwHiVhVjiF1pFH8vgivaJIQJEHzZxsy/hGrU6W1PbXE/t6RWZYm8Fc6sI9T9fLF3NS9mb5Zcxvkr2DYzmKnzIbIFs=
Received: from DS7PR03CA0303.namprd03.prod.outlook.com (2603:10b6:8:2b::19) by
 SJ2PR12MB8064.namprd12.prod.outlook.com (2603:10b6:a03:4cc::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Wed, 22 Feb
 2023 06:42:32 +0000
Received: from DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::c9) by DS7PR03CA0303.outlook.office365.com
 (2603:10b6:8:2b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21 via Frontend
 Transport; Wed, 22 Feb 2023 06:42:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT068.mail.protection.outlook.com (10.13.173.67) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:42:32 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:42:25 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/20] Revert "drm/amd/display: Fix FreeSync active bit issue"
Date: Wed, 22 Feb 2023 01:40:33 -0500
Message-ID: <20230222064041.2824-13-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222064041.2824-1-qingqing.zhuo@amd.com>
References: <20230222064041.2824-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT068:EE_|SJ2PR12MB8064:EE_
X-MS-Office365-Filtering-Correlation-Id: ba9360e1-79fb-4c3f-bec1-08db149ff986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+jT5RPx9G+NvXr9Bwz/CLpoXuxcDo/sp+rSGm/fwy6fLjRQbTnvsTTbQXy2e9Qamg7zkk5DVgsnfXEu0C4MBfEaBY5qCUTYonGMqvT9qW/Q664XXwp769Hw81Fb6UbQFhQgoubpXhGQGZQRZ6e/yDV83LoEKis2nb3Le8ZbR0P4d+YNdY8Y0OtuR2RTajk1ygxEZqUmha3dFgO+MgarzKgNLMQCfJpUXc1xjoPLA1grroBgOROPKYM2dF5hAp05Tfb08nWq8tmMOlnc3yaNZ0/7Yuwn5juPQvqM4fnaZsRdXzLAu75IMZOz0sZAvz+sbYW9+cPwZnbz4w3bPc77vZQy+l8Kl7iLDPm6/PCG8pV0tGL7QqUBaW8s9tLtkdQiMmvo0/wWjEwVTmWoNL+x7w7tTCJh0ZebwCTxPyNIgdUVoE9YWidr92ATIgeii0Fw6hEnGBeKb/N/xCb7By2dkDVXj3SMbyocoBKQ36MMf5Who9OIuR8zJwtv79/29DXzVzO07AdyPdCOcoPHcsu2+zuK9xDef7xUCZoFPaC+PesELpeGBVyI9PHwlnEEwqrL3JjO226l22rixuMx3BpxlfXDRHU+QzUe7P5qW4+eDYnKwRQd0JfwSnBvh29uzatumsV+T26ri5Iw0gNIq1oTSj1r0QxcTEpj1J4OHvmy/43qwJsHMeEkjhhM0utMYlgiTBcmGSGAh6Puizp4tPqySvlDDXwDPuHk4UmgfdXqbVw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199018)(40470700004)(36840700001)(46966006)(5660300002)(356005)(36860700001)(82740400003)(81166007)(82310400005)(2906002)(44832011)(86362001)(40460700003)(4326008)(426003)(47076005)(478600001)(336012)(26005)(16526019)(186003)(8676002)(36756003)(40480700001)(70206006)(316002)(1076003)(54906003)(83380400001)(70586007)(41300700001)(2616005)(6916009)(6666004)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:42:32.0988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9360e1-79fb-4c3f-bec1-08db149ff986
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8064
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

This reverts commit 768ba5d529ae198c3a7cbcb1cbacb8c99dc77f07.

[Why & How]
Original change causes black screen. Revert
until fix is available.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Aric Cyr <aric.cyr@amd.com>
---
 .../gpu/drm/amd/display/modules/freesync/freesync.c  | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 2be45b314922..315da61ee897 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -955,26 +955,20 @@ void mod_freesync_build_vrr_infopacket(struct mod_freesync *mod_freesync,
 	 * Check if Freesync is supported. Return if false. If true,
 	 * set the corresponding bit in the info packet
 	 */
-	bool freesync_on_desktop;
-	bool fams_enable;
-
-	fams_enable = stream->ctx->dc->current_state->bw_ctx.bw.dcn.clk.fw_based_mclk_switching;
-	freesync_on_desktop = stream->freesync_on_desktop && fams_enable;
-
 	if (!vrr->send_info_frame)
 		return;
 
 	switch (packet_type) {
 	case PACKET_TYPE_FS_V3:
-		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket, freesync_on_desktop);
+		build_vrr_infopacket_v3(stream->signal, vrr, app_tf, infopacket, stream->freesync_on_desktop);
 		break;
 	case PACKET_TYPE_FS_V2:
-		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket, freesync_on_desktop);
+		build_vrr_infopacket_v2(stream->signal, vrr, app_tf, infopacket, stream->freesync_on_desktop);
 		break;
 	case PACKET_TYPE_VRR:
 	case PACKET_TYPE_FS_V1:
 	default:
-		build_vrr_infopacket_v1(stream->signal, vrr, infopacket, freesync_on_desktop);
+		build_vrr_infopacket_v1(stream->signal, vrr, infopacket, stream->freesync_on_desktop);
 	}
 
 	if (true == pack_sdp_v1_3 &&
-- 
2.34.1

