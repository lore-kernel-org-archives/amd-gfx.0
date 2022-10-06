Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58AEC4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC9BA10E8C3;
	Thu,  6 Oct 2022 21:28:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0687F10E8BA
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTx5IUZL23qq+yH/ChusHbDlOoTlcN2P77R1y60koFSe41tRiWmme7WhLpcz9XjkmiwRtm3ViaduPfazSin97K2EOndYi8YU/aV+nD35n1RSL/w7bWkDVR/bHeLBCKtAx3XoYlV2o+WNMW8BcNd3m6AI6bPVEnzQnKzI/ccxyvOAzyJQsee45pOWGnHSE9HAhEJg2ObssXg9f6iB8Skjbd8VAi2DFbDWKFAz00lKMgnzZsw0qgDULZAIGyZrHIAXA3PZ6ASasJCSsvnJMih5Lhbvw049bbpZm97FU/fgDe5wEDb9IS3BULPW9XWKaIMbWLUSy6y4Qiu7jFsovhVPQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oL4DA+3o4FvcEkpJ8QRLyBLWz5VkLM7tPDaxY45gBTk=;
 b=kh3Ne1G1MLTTicx/DzpNuYreB8BAqSpJW9pjyqkZJSZqpxzF4NkPc//MvwJFkTEpYNgfOvr65bPG7+/HDQEDeuQFqOQqac5UrBOHgFegvYiVUtVKB1mGlarBlyNWAhWN2CTqR29D6hhCT+m6y9/U9aIR7Eq4+Tt5HN1WhLGdYty3aZfCaWn1qum3Y6Hg3FhOWhaZZ66TQ0SmkvAdh4yH/8H198cJQhtMHil9vR5E18lFpM1Q9RKb+tawlL+vJ76z+geEsjW/HWtA7Jy1iOxTgN6bRnTYEet+QnCvUX23M9UwvfUaJcBMtkHxrsQwc4z0m8oAo/u2RgtTc8WgsKo7WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oL4DA+3o4FvcEkpJ8QRLyBLWz5VkLM7tPDaxY45gBTk=;
 b=TQoO1NRIlbhDexJCmYEygGucNkO1gy0Ix/bM4wvtTb2TLf55ugGAnnLM9L/11qNfQv1nWUlku6+T1LypUEWkNwL988QvNGT0W0TgFr1cLsATBAXqNREowir6Zc4KbSES4sYDkvRSL/QZf20Zth6Sv70pSMDq5nzK6MJgSDU+D4A=
Received: from BN9PR03CA0278.namprd03.prod.outlook.com (2603:10b6:408:f5::13)
 by IA1PR12MB6651.namprd12.prod.outlook.com (2603:10b6:208:3a0::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Thu, 6 Oct
 2022 21:27:55 +0000
Received: from BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f5:cafe::2f) by BN9PR03CA0278.outlook.office365.com
 (2603:10b6:408:f5::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT078.mail.protection.outlook.com (10.13.176.251) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:55 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:51 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/23] drm/amd/display: Drop uncessary OTG lock check
Date: Thu, 6 Oct 2022 17:26:46 -0400
Message-ID: <20221006212650.561923-20-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT078:EE_|IA1PR12MB6651:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f1a3c80-dfe9-4ee5-06f4-08daa7e1a22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L74ejEWkMWpr1QXfLMWEHnshHSxasygMsyzDeEcKLR2iqrYX/hF1ihemHkzQtxxKyxFFSPWJ0oKlTAt3FrWbxOpTEZJHXBaMXWzHmXVE2OOBkxk7UrIhDvPsJcoFJQvT6vjCLwkr5Y5Xh202IFU2TtEhpd0we38FJgyEpYMvw3v8LoG068KQbCFh9J961WS3ytyarc791KMjvCemdl3ZG6ByRhvpxIwsNS1kC+Dh5CLvN6uSABWINyamU9SSrdJPKXlQmhBwrI8avbSB6iBcztE8/U/fz6a0oJNhTa/b+xSkXkqu7YHDyEdz4en73wiCgaXCYSHV1b0ckYOo1iuVqbT6peEyMJiO2wrhVxbt4a/5UchjFu3MXrgkX/npYWDvFB+rUTFD/feUQHI4oOPXeSQJIVH77SlQzzDJqzDSwxNGSRBjs42NiqC53KzxF0HIsBcv+QVEdvrVO2GV7J0/3Gtv6h/CHeJ+PInuwv5gCN8vQm9WaAQr18FFNopUzV5doAiiu5UW5+6ex1aBPzlq0eZPpRTiRyIwgAP3+5vUBH9LYjSwbTdlwWXk4rncNtx0TJPEyEh5o1y2ZE6vtWkC2vCZA5VvcB3A8lm64CKbOaH5vkVmrq5FAnzhIhzayV6eA9SpwREG88ajZEUKR4cOtjiuneGuHnp/Fyaj2o9ZHk+6AsfLZkyO1ggUsPJTAJ1EfxBh/EvMlr+QGSHDzBglG2wQRtSSZXrjctXaP2l/R+EJkb9Bq4yT9+EK7Mw5DXqXx+bZ/YoyWlSR2P7RPdWMqQNrX6hEkYvN9jkTgL7OxoXkxBd6qbJ6U+umS0kOW6IE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(39860400002)(396003)(136003)(451199015)(40470700004)(36840700001)(46966006)(478600001)(2906002)(44832011)(41300700001)(5660300002)(54906003)(70206006)(426003)(82310400005)(186003)(36860700001)(2616005)(1076003)(356005)(336012)(16526019)(36756003)(8676002)(70586007)(4326008)(40460700003)(6916009)(81166007)(6666004)(8936002)(316002)(26005)(40480700001)(47076005)(83380400001)(86362001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:55.5502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f1a3c80-dfe9-4ee5-06f4-08daa7e1a22e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6651
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

The OTG_MASTER_UPDATE_LOCK_SEL is used for
GSL and OTGs in the same group for selecting
the OTG_MASTER_UPDATE_LOCK from the same OTG. At
some point, it a check was added to see if
OTG is running or not, which is not necessary,
and for this reason, this commit dropped that check.

Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
index dca8a1446120..33d780218790 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_optc.c
@@ -646,13 +646,6 @@ uint32_t optc1_get_vblank_counter(struct timing_generator *optc)
 void optc1_lock(struct timing_generator *optc)
 {
 	struct optc *optc1 = DCN10TG_FROM_TG(optc);
-	uint32_t regval = 0;
-
-	regval = REG_READ(OTG_CONTROL);
-
-	/* otg is not running, do not need to be locked */
-	if ((regval & 0x1) == 0x0)
-		return;
 
 	REG_SET(OTG_GLOBAL_CONTROL0, 0,
 			OTG_MASTER_UPDATE_LOCK_SEL, optc->inst);
@@ -660,12 +653,10 @@ void optc1_lock(struct timing_generator *optc)
 			OTG_MASTER_UPDATE_LOCK, 1);
 
 	/* Should be fast, status does not update on maximus */
-	if (optc->ctx->dce_environment != DCE_ENV_FPGA_MAXIMUS) {
-
+	if (optc->ctx->dce_environment != DCE_ENV_FPGA_MAXIMUS)
 		REG_WAIT(OTG_MASTER_UPDATE_LOCK,
 				UPDATE_LOCK_STATUS, 1,
 				1, 10);
-	}
 }
 
 void optc1_unlock(struct timing_generator *optc)
-- 
2.25.1

