Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF0F5C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7002461106
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7002461106
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F024673873;
	Thu,  4 Nov 2021 20:53:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2071.outbound.protection.outlook.com [40.107.102.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4050173873
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcA7dMEfREHlyQzsneVawDUc1ilu1rW56ytREkzqAf/d1ZonIkjDwY9qh91ymkJz6X1np1GMyXnZ7ArWTsJPZjrkMGepbsD9MWBLCD0wCye3hIXjji0eiTei6fqVMCl68QVdtaLdrz/d2VmCp90LEx6rP/Uf06P/rbxxJ6kRJovwo310zkKM3q4qFZkqPsAdEqKoC2F5ZBW+5n9qwoPtOgJKCg5Y4xLrDnlm2O36cHYubFrVEpwoa/bLycVkJ341LX3UpTMpR53FIP52RDMwd4P9FfHTCNx9PKKgiSK0PLvFiw2pOOIQvl+zgbPFCU3QxSYu3QQ0LeSm4xBpztSEpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/1NvVnqsWv5EK529ednsSYaVoQ8V+gW/TjCSQCYOUQ=;
 b=nK98ii/bRAOm4gTg0WqgUDp95yJT81+n/zIySI9wJX1zsLVW45ZNiRz7OOeHu3VbG3LZQvfvkpvlAwzmKF7Eavtwe2XzlwSWpG+fBXRnEx8WQ9xcSl+vAWt2oWz+pITaJUlc7KPcuSM/eXM/LTQ7ygyoHv2ov8RDnIwffD+xJVw9B3v7r5LhrDKQCSVCCeI0oMDYsafHsU+YZjQ8NIiqiwNLTK/xSQAB4JAsgS/jsZEryXduR35Snu+WMEml3yPYl6LLICYu/HIMsM6DAwhqKyjj6AxcBCVL1S4p6/bnA0RPTjL8V2rEry9ONZAw9km8MQxQK8UE/RoTAnbFebcDdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/1NvVnqsWv5EK529ednsSYaVoQ8V+gW/TjCSQCYOUQ=;
 b=LnkjC1UJPVhpNBvPPi6hURC09FJVSTqQZqq5wZCJueYlveHE+cQc+4cKpUge09vKmsrwj6YdFcER19Zenv6pNgHscPzevX2cHbHG2u1RiyOIuqQULCgDKEzRHpQDh2tdD8BS1VeXqug9GQ9doFDfbzYJj+w3HDKjoznPcy2aW0s=
Received: from DM6PR12CA0031.namprd12.prod.outlook.com (2603:10b6:5:1c0::44)
 by BL1PR12MB5080.namprd12.prod.outlook.com (2603:10b6:208:30a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 4 Nov
 2021 20:53:06 +0000
Received: from DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::87) by DM6PR12CA0031.outlook.office365.com
 (2603:10b6:5:1c0::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 20:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT049.mail.protection.outlook.com (10.13.172.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:53:06 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:55 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 13:52:54 -0700
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:53 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/22] drm/amd/display: Initialise encoder assignment when
 initialising dc_state.
Date: Thu, 4 Nov 2021 16:52:14 -0400
Message-ID: <20211104205215.1125899-22-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 184ceae8-3794-4fa3-7346-08d99fd51a0a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5080:
X-Microsoft-Antispam-PRVS: <BL1PR12MB50803F6B0E3C6F3E70D11E3AEB8D9@BL1PR12MB5080.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LMzINkiusHRwGzICkeFs4WFB1P9S8s9Prqofr2pCZ9X8kZYxtTqT+2x6UdkF87My91Wzps0pcZQePAGGzxGgMAGRVk9G6p6tBH9aSq3fUbV4juMJzB3WZAvRjaO9BSalTGimRmUnwWTS27Lbf4vxgo4XNcfq0tsCLsDlICnjpWfzDxS+iXVjz/Qd4MoMxxx7IhxJ4Xeuj1daLENCq8EHmzWddDQer3AN1w60kcK7vPf02WMC2BdfZ7ESI6+E2KdH6kqNnqwYOn1N1a1okdcYqjqp3o4vqIbgAKkDJ4eFTz0CrenLNnYgaxck+WMUj626QYFE0xQw0MZSPRwooWYbrR5FKUPC99xZRF8GHkIiKZaSgyls63mDQnFjhrD8NwhHNtkpNAci3gVZlP44UfTcFmkc+82Xn23IaFxNFnZXkboaI7DfsDAOVw6KL74qaRPO3VdFnrdJ1ybHQlKIFKTp25EcmXj951uL8BkTriMsz5pmVz5F5UyGL8IADG0A1kfp5aBNa3tuAwpx3OaqvNzzN05nchrQiJKS/M35WGokTf+OaNgKw0iCtpMEuK4JjkUdGt4wBq1WTkE1BBOEQ1DHrulRIxWDJKK7SKDs6oX2SQYLbkeE4f7/y3+yyIVFDWcPZ0jUZhepfkAFWLEcpm6W9h92ijhoSZfnu2iznoVRNBIsxOATNQBHRIW5dbAehFdJYFbVJGdKixZok0r3J+uO6zpcF5wSDqLHJ8KToVnOzao=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(186003)(336012)(36756003)(83380400001)(26005)(81166007)(2616005)(356005)(7696005)(2906002)(5660300002)(86362001)(54906003)(6916009)(47076005)(426003)(82310400003)(8676002)(36860700001)(6666004)(316002)(508600001)(1076003)(70586007)(70206006)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:53:06.2579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 184ceae8-3794-4fa3-7346-08d99fd51a0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5080
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, solomon.chiu@amd.com,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Jimmy Kizito <Jimmy.Kizito@amd.com>,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
Link encoder assignment tracking variables need to be (re)initialised
whenever dc_state is (re)initialised. Otherwise variables used for
dynamic encoder assignment (especially the link encoder availability
pool) are out of sync with dc_state and future encoder assignments are
invalid.

[How]
Initialise encoder assignment variables when creating new dc_state
resource.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c              | 5 +----
 drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c | 4 ++--
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c     | 3 +++
 drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h     | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e76a2aa65a82..39ad3854bfe4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1016,8 +1016,6 @@ static bool dc_construct(struct dc *dc,
 		goto fail;
 	}
 
-	dc_resource_state_construct(dc, dc->current_state);
-
 	if (!create_links(dc, init_params->num_virtual_links))
 		goto fail;
 
@@ -1027,8 +1025,7 @@ static bool dc_construct(struct dc *dc,
 	if (!create_link_encoders(dc))
 		goto fail;
 
-	/* Initialise DIG link encoder resource tracking variables. */
-	link_enc_cfg_init(dc, dc->current_state);
+	dc_resource_state_construct(dc, dc->current_state);
 
 	return true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
index 787aaa661a29..d3c789f26a02 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_enc_cfg.c
@@ -242,7 +242,7 @@ static struct link_encoder *get_link_enc_used_by_link(
 	return link_enc;
 }
 /* Clear all link encoder assignments. */
-static void clear_enc_assignments(struct dc *dc, struct dc_state *state)
+static void clear_enc_assignments(const struct dc *dc, struct dc_state *state)
 {
 	int i;
 
@@ -261,7 +261,7 @@ static void clear_enc_assignments(struct dc *dc, struct dc_state *state)
 }
 
 void link_enc_cfg_init(
-		struct dc *dc,
+		const struct dc *dc,
 		struct dc_state *state)
 {
 	clear_enc_assignments(dc, state);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c32fdccd4d92..fabe1b83bd4f 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2224,6 +2224,9 @@ void dc_resource_state_construct(
 		struct dc_state *dst_ctx)
 {
 	dst_ctx->clk_mgr = dc->clk_mgr;
+
+	/* Initialise DIG link encoder resource tracking variables. */
+	link_enc_cfg_init(dc, dst_ctx);
 }
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
index 10dcf6a5e9b1..a4e43b4826e0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_enc_cfg.h
@@ -36,7 +36,7 @@
  * Initialise link encoder resource tracking.
  */
 void link_enc_cfg_init(
-		struct dc *dc,
+		const struct dc *dc,
 		struct dc_state *state);
 
 /*
-- 
2.25.1

