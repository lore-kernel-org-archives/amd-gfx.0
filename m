Return-Path: <SRS0=770C=P7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8480BC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B82561213
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Nov 2021 00:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4B82561213
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4B1D6EAC9;
	Fri, 12 Nov 2021 00:55:49 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C8C6EADE
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Nov 2021 00:55:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xeeu3EbrKocKN0U+TIq8iCyBNKgBC9Xv0nPeOzY3N1/SdeRgE6j8gcoqLxmWN8zq2z+LsSPRhv/iYZWU2R8+4irkojnyFWqS2DHtKV/K9m+hX1s6I9SuwweIfCjsSnFXpUKIM2GfvttwsRMqbq0LfJOAdIhgm633jZhL4UdCGrcSYVxuWpkhzoBwQfm7xiIij6KXtM7Lv6udipKE2lBAw7R9O/LSLGRroKpxI8S0LKyV5c1SNkynQOL/1IdusM8T11V/PqkoQG2ZXe50LSXZH0amjnDd0b5+xyhFOGDyclHntmWiyqLwlvUu7Ioal0s9h04VCG8wWXFv5wm/I67fFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CmAUpZjUygx28rmMguY+VseWFXztTV9zKOD9OxjZMiA=;
 b=KBZDSbMBsyHzyy9YZdVbo8ulenTxIKneYvTXti1gX9ijuCfMrFu82APt0vD1r3RgiiGNK27RTWy8m3LUU1hJnXBsga7Lj5bV1ueu4J0Ml9EdzAezLKSepS+nI6PTa23Rwc6VbZj/qAscgRdr/ujIxmGkAInMB826h8p+D3C1nJDtEFHuwWoGPmUZeD7LZFdks7akO/6PSd51QoEu7S8e6/PYDnNoGa8l8WDUbI7+jugXrmfDU950YMLFQK6Ivf5Z2jVL2EHsZUpS05XA0pTS7Evvcwu4l9hVmgb1riwJ9EvNQz+R0DAHlOUqw2qOi6CfcW1EAGuK5gVejT2BDMDEGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CmAUpZjUygx28rmMguY+VseWFXztTV9zKOD9OxjZMiA=;
 b=1Vw0TIS/p7lz4aNx2swrDQ78ftgjzHyoR1FuEO1aT/MhmkVNAeY/q6soskxWhGe0A1JqQ/fmGDWvrFdAoPoLDMPxik7gNwNVVzsmp9+PmDltZpvfHU53AtMSiBwY8TyVXHhQUF01ezpJ9kgAQK/hZZTXbvXFNYWeUnpBMWgrqpg=
Received: from MWHPR03CA0007.namprd03.prod.outlook.com (2603:10b6:300:117::17)
 by MWHPR1201MB0109.namprd12.prod.outlook.com (2603:10b6:301:52::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Fri, 12 Nov
 2021 00:55:43 +0000
Received: from CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::6e) by MWHPR03CA0007.outlook.office365.com
 (2603:10b6:300:117::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Fri, 12 Nov 2021 00:55:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT011.mail.protection.outlook.com (10.13.175.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.15 via Frontend Transport; Fri, 12 Nov 2021 00:55:43 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 11 Nov
 2021 18:55:39 -0600
Received: from wayne-Bilby-RV1.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Thu, 11 Nov 2021 18:55:36 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/14] drm/amd/display: Visual Confirm Bar Height Adjust
Date: Fri, 12 Nov 2021 08:54:33 +0800
Message-ID: <20211112005438.5505-10-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211112005438.5505-1-Wayne.Lin@amd.com>
References: <20211112005438.5505-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a3f3b0-0cbe-43c8-db23-08d9a57727ba
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0109:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB01096769B1FA846233D0DBD4FC959@MWHPR1201MB0109.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: POIWNvt5UODO0xiXEimDIPGqQvQyfjibww5XDNKf3TV86t7j4VLHqaYWfvautAXF/fcNHeV5Dl4ZkSd2LsjLmzOlf5JF+K+Y+Z2doq/20zAW68eA5nnkHz7IBVJQAdJlC7hyrF2rRUNfCnZCqAA5oj4Fy1/dCvfAM14KIvqHS4MRzobFlh7s5orIxsbU7wh5f8W03rJhUjaez4am7amHHEyFfHP+97P8xoOYvu99fj0Nug6Yxqi/3/ZC6Jtw3+Gv9FaZ36rxG9wiRono/ODrmUMAb/TWilBljjSWNm47TxnlzkD8MpNcc22MBhORLxnK4xZxFIOKUc00xj51xtx7/uhACuYR9376IQH0Z3pPDLpKoi0hHlEPGcRpKqlL/GHMjnRA2foqHbl59fB0lIUrrZfAjwBY4QZjuggwAzl6O6aFn8tzUOFwrcIRVcNlAx6OVCJ/2iKPJT/z1zSv8SzAlBwZuF/Ji3oPWQ2dyOO1+XES6pLs4mgYRd40p18tY+UiP2XLSoLDPaSKzPPATngr6ouBDguagBwtILK3ke6Jm94YMNj7V7pC5z0sAT7k/NrHJHdMKVBbKHgQ21dqF3wOlDssnCPelvZOqlkXrByAWQeJaizNwjyXBylXRFv695mvi26P0r1rkEu+8vIHd6xuBqLQugzOjJHzem/sTB2lp4YBeHM55QDGhxERamUMVuZMISXq6+5XdgTOh1idFAQl1LBdGPxoh8aLUYEYktlSIvI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(6666004)(336012)(82310400003)(356005)(81166007)(54906003)(47076005)(70206006)(8676002)(70586007)(6916009)(186003)(1076003)(2906002)(5660300002)(426003)(2616005)(86362001)(36860700001)(508600001)(7696005)(36756003)(4326008)(316002)(26005)(83380400001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2021 00:55:43.4215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a3f3b0-0cbe-43c8-db23-08d9a57727ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0109
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>,
 hvanzyll <hvanzyll@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: hvanzyll <hvanzyll@amd.com>

[What]
This change allows adjustment to the Visual Confirm
height border.

[Why]
Aids debugging and testing

[How]
Use the existing infrastructure to implement logic to
draw borders

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Harry VanZyllDeJong <hvanzyll@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                |  2 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c  | 14 +++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 764663df7887..6b4c9e9705c0 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -574,6 +574,8 @@ struct dc_debug_options {
 	bool native422_support;
 	bool disable_dsc;
 	enum visual_confirm visual_confirm;
+	int visual_confirm_rect_height;
+
 	bool sanity_checks;
 	bool max_disp_clk;
 	bool surface_trace;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
index 44293d66b46b..e31a6f1516bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_dpp_dscl.c
@@ -39,6 +39,10 @@
 #define BLACK_OFFSET_RGB_Y 0x0
 #define BLACK_OFFSET_CBCR  0x8000
 
+#define VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT 3
+#define VISUAL_CONFIRM_RECT_HEIGHT_MIN 1
+#define VISUAL_CONFIRM_RECT_HEIGHT_MAX 10
+
 #define REG(reg)\
 	dpp->tf_regs->reg
 
@@ -685,9 +689,17 @@ static void dpp1_dscl_set_recout(struct dcn10_dpp *dpp,
 				 const struct rect *recout)
 {
 	int visual_confirm_on = 0;
+	unsigned short visual_confirm_rect_height = VISUAL_CONFIRM_RECT_HEIGHT_DEFAULT;
+
 	if (dpp->base.ctx->dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE)
 		visual_confirm_on = 1;
 
+	/* Check bounds to ensure the VC bar height was set to a sane value */
+	if ((dpp->base.ctx->dc->debug.visual_confirm_rect_height >= VISUAL_CONFIRM_RECT_HEIGHT_MIN) &&
+			(dpp->base.ctx->dc->debug.visual_confirm_rect_height <= VISUAL_CONFIRM_RECT_HEIGHT_MAX)) {
+		visual_confirm_rect_height = dpp->base.ctx->dc->debug.visual_confirm_rect_height;
+	}
+
 	REG_SET_2(RECOUT_START, 0,
 		  /* First pixel of RECOUT in the active OTG area */
 		  RECOUT_START_X, recout->x,
@@ -699,7 +711,7 @@ static void dpp1_dscl_set_recout(struct dcn10_dpp *dpp,
 		  RECOUT_WIDTH, recout->width,
 		  /* Number of RECOUT vertical lines */
 		  RECOUT_HEIGHT, recout->height
-			 - visual_confirm_on * 2 * (dpp->base.inst + 1));
+			 - visual_confirm_on * 2 * (dpp->base.inst + visual_confirm_rect_height));
 }
 
 /**
-- 
2.25.1

