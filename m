Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89445C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 268EE12A903;
	Thu, 30 Jun 2022 19:14:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB3412A8EE
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:14:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h/rBR35yBxgQyYkX4XqpdFAo3QScYkPGNON4dLg0N5jFLtRP9zvli5ura0piim85A6PpfRCqsXWe2Mg70UAh1MyJ23hQXyoKw4zLJ48NiP5nACN/0wd+3xS2/n9/6/xd3rJ9zm5/NB3n96chS1GAHZt4zzWaqyP0rfO2lWPTg49/A4vpDfzAiZohwMv/D/4c/2SPwgw3C+iIDhppfMopNQXcnETwuVa/KUGKOjWlvlIMN4ITRk0z8Km5JRFo7bilACJU/x7sszoCcc5UvUI0Ve8kSKi4CmIeVVem2QEoFzHFdiDfcbhdTHpPUNUCzsJsHTyG+gP6LoAOFlt6DHh6wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ED1ns8M5Z7RudeQSNNOGRKt4qop8rE3h/pWa26CSflw=;
 b=SwlBeMihM4NYpeziq2722p2rffQR/Qhzyeq+km5EG2G23LM68REImGdwuVlorDybqtjU+i1ybeHAet50625m5w0VTh5Z50LRWu9YHm9PuirCvpqkuEHuV2v4zegCrZHuQg+glz/VD1gx2u9QLDM60g7cyAZ2fhciKTsw9fUPNwz/1Sx+V78ghIdpJvy+fq0DAl+/QAR53K9qIOoTmaJz/pdrS17NRXK8NYFlYyCk/Fcan5k6dsXiQhVWf+sqCfeW553UbF+cEfGmtZzg0u1laCc8/sfN2G++qqTakbzdRGkPoR0TsM+ffTyT0wr9kBl2fENfzyeTHoGHLgafkGd29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ED1ns8M5Z7RudeQSNNOGRKt4qop8rE3h/pWa26CSflw=;
 b=1cpjLg1P959OUuGtzv7RYMvktjvlnXyMbaSKOKNuWEu7hK3YPC/Uj2hv3Po0JWFR2rYQWQgdXHtLaUeyDiSlBVp7Jpx9HmOsLINlcjuCuBdl7DZ3yOQmaOBy55rG0Kl7Iiu1Ri6A1d6XOiTRlwoHH60Vk52DuzScmweBPyZSTC4=
Received: from BN0PR04CA0135.namprd04.prod.outlook.com (2603:10b6:408:ed::20)
 by DM5PR12MB1721.namprd12.prod.outlook.com (2603:10b6:3:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:14:27 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ed:cafe::7) by BN0PR04CA0135.outlook.office365.com
 (2603:10b6:408:ed::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:14:26 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:14:25 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 37/40] drm/amd/display: enable PCON SST support for newer ASICs
Date: Thu, 30 Jun 2022 15:13:19 -0400
Message-ID: <20220630191322.909650-38-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 138fe969-0204-49c2-1a4f-08da5accc02b
X-MS-TrafficTypeDiagnostic: DM5PR12MB1721:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: brqP610cV4y0Xv+PuWjbjo7nGea8ik4/fhEmh+vUswMoC5cWW4TC+c9DE3AkiEjcnh1466xHCuVnKaggD8/2me42CEtXoGF6aAOTb6kKRSGBqB5c4ki+aNonrw5f/1qytxnDT8Du6aI5rL91a1O5HUFgsrTdujrj0STcATwrkeBM89YioGdIEG3G0RRA447MLNxqwTiqCekn14cwjtprNw2daH53wQLTl2rd1aGxynExGUtb5jHTOKtWqyNf2JptdW5Ar+jiJlDxBMHpcUHy5KmbD4WgjtEr4oamJUSsfyzZJswBdNjHcfa6f/jYuTxL62gps7qKU0sAEluziUU+H++8Ct5oReS5oZZ3jpG6LTIDkRH0fv4VpmyrqzohN5KXAHaq0yK1Y1Uoa6OKMPdhDudR9QuGsej2jCCn1omFSdSMwytYSN3qm+GsKSzuvd9ZEsD56EFh+3xHeEgoCncf3f/GF2j/sQZAuItFTGPFYSfTRj82MnQdwV6tdEVYBPs4njqy7uHJxboGI3/yQ+33LSLCsbTxhk7xdYYD70Ftq0AUVYerIOoGCFtg3bfNWDL65gTxV0dlfHLdcdLMqGkhqeqVcKhCPuTL7Tilc25nHiE34YW+4wZpSiisksMB4RkR8V78MbF3FozD4Pvv9MxbUxKEZkB2SOfFKwhSLsKj/YgE3N61H3zdmcmEcpmmuHMhBabGzVXBZ2qKa0eSUuzoujbAxJikSXL0daYIEbvgkA1xxUmEMsZItjw82/TnEJQVPfS9APNCL3iw4uaKvsuFZSuizF9/kd3VG6ePdHuoJs14LmWdAuv2uhTVsNqcAnGXZx+XogaZZQdYJ22WmaDQGe1k75LmoWgBMB/1VXKmaQU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(40470700004)(46966006)(36860700001)(36756003)(316002)(40480700001)(54906003)(16526019)(186003)(2616005)(81166007)(82310400005)(47076005)(426003)(336012)(1076003)(26005)(8936002)(40460700003)(4326008)(2906002)(5660300002)(478600001)(70206006)(70586007)(8676002)(7696005)(356005)(6916009)(41300700001)(6666004)(82740400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:14:26.9443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 138fe969-0204-49c2-1a4f-08da5accc02b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1721
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
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

Generic PCON SST support already exists and works for newer ASICs. So,
enable it by default.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c   | 1 +
 drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 4f45753484fe..e346a00f395f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -1768,6 +1768,7 @@ static bool dcn315_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
+	dc->caps.hdmi_frl_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index f9cee05aeccc..1b170e2d546b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -1770,6 +1770,7 @@ static bool dcn316_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
+	dc->caps.hdmi_frl_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index e9ecc27a51de..65de38b96312 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -4010,6 +4010,7 @@ static bool dcn32_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
+	dc->caps.hdmi_frl_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 81027b780d15..f38b16335086 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -2305,6 +2305,7 @@ static bool dcn321_resource_construct(
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.dp_hpo = true;
+	dc->caps.hdmi_frl_pcon_support = true;
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
-- 
2.25.1

