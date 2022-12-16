Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE68C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Dec 2022 10:45:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2C6910E5AC;
	Fri, 16 Dec 2022 10:45:52 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACB910E5AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Dec 2022 10:45:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exZDu5yd+EolZ1G8Bcg0XPq5jVo/JQvc7gjEtkDvnSOAaWPYTVNDWIddAC5ILUW3r0vgmsAavRHHserbFKHEUMXEBYPCTLHhEo9hfPxaUQ1LbeEqUd4gAalHajU3BI1cv6cQTl5EcxEw6pOf25mbGy7zNayeRx1lmVFHQ3/Q0T+GQkVTWUwtW8mUFmdk1TKxjwI1KYnrD+aAXP4h/J9cAoZLxMMYyBIW3afzSlEDbzY9PaYt8mpY3bTPA5gmYpVmc+sfiCk53Y5Dv0psYdvapwz8Befb7IpI2vx6eFaAdFd8yiduljNODWAR+tt3eiPrj8H+9Pg+kXbMaB5kON+bIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iLBD85f3JfVGDoFvAlRJw12bHAtBGvqdaO3GLhQGFt4=;
 b=fTV2eT2Br8XntDl5jlGLQnqpALRyRPna+7pZ+fTgkJFfma61TPK2DhI9uu4QsNLTG00AzmF7I0unEUz+K6XkkkxiNmqDATjbSsG0F2zHl/qfAWcpKGnqdfxrDuJNW6akyQiMTJglqzJuUu0wD5OXM8GJa6iniBJZKSd+uIa46IP5clukCu+VzxdGxX240At5vkbkjuoM8LUylKQLZgebC46ZxmtB/4bkQSOs1jDvkgMlQT2negkxLkslqPL8oA+Q0I7Wwwoc8oNT89gwZBpfiAt/+eVaGLR8qfb31Qsgg+38lkbt5jjL5ZHdgfBfOurCdz8ZCiMlNeODXXjRWXlWyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iLBD85f3JfVGDoFvAlRJw12bHAtBGvqdaO3GLhQGFt4=;
 b=uIY1qW9MGvuQDXbdBDEHWOfGo+cDdepiqmyZlKbPLuTLztyfL2j/Uib9OrJ4DZ13ArmOwJAum4roRvtEKgsa4Kc11Zm/Vgkfl2lZfuNK11NElhw6wkB8OXGKG4kFD+c6VqkjR7ICUPx15bZRi2oJCEeHhRlwLLIWAXO5YNAdN74=
Received: from BN9PR03CA0362.namprd03.prod.outlook.com (2603:10b6:408:f7::7)
 by DS0PR12MB7510.namprd12.prod.outlook.com (2603:10b6:8:132::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Fri, 16 Dec
 2022 10:45:42 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::63) by BN9PR03CA0362.outlook.office365.com
 (2603:10b6:408:f7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.15 via Frontend
 Transport; Fri, 16 Dec 2022 10:45:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.15 via Frontend Transport; Fri, 16 Dec 2022 10:45:42 +0000
Received: from pswarnak-Sharkstooth.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Fri, 16 Dec 2022 04:45:40 -0600
From: Praful Swarnakar <praful.swarnakar@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Remove redundant logs from DSC code
Date: Fri, 16 Dec 2022 16:05:18 +0530
Message-ID: <20221216103518.308578-1-praful.swarnakar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT050:EE_|DS0PR12MB7510:EE_
X-MS-Office365-Filtering-Correlation-Id: 6681c159-71d4-40a7-0941-08dadf52adea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vCC9Kkzt3KNR/3hX5KcPzjhNZiKeAE4wt1zB4T4GNWOCQo/pmIzDWgPv3KcX2tkAwEknB1sKCyWPKM7u8kANTHvpbqK7H9GSM/6ceKCH+7XgB+AFbbRog3V3j7fB5u7NAptCVjFh3A4YwsB9UdV4WlfslQlHSnX6qGMAgaRqoeiwtvZxPGJFCSffylMyh3m84MkjJ4DF0Ks9+cVUQAvw7ICqw9xxBZhXqqQAdu5ADrGL+q7hlu8Xv4nDh9V1D7u6SFfm8vYGmQXRQqw2mJbQ+lxUbJw0OANwTAIVNe7tQRk03AUV+QsGYvI+WUcBElsbvYA0+h9JIiboD6EwVPvm9LjJMWsrgJAnBFjaE6qZySMF9MRu/lRJcE+MUThy6jFt4Qwbg+VAC7M9xYyDKFeSwQ4FVEoaGzPIjdZ34UnitGzEqMZxpipg7jBbl1v+KJPE4V9UKl92G6/dPO+T4W6Va56CNvvnCD+HDA46gitbbfeX/luJeDxJQCf1ELXbdtMxN09pEkG47X4hM5GzsClDPThlRhyDm10k+k+QPCSm61jOsmuU+2VFISL3NN5mu/zGuWq/zTGWdoi4uM16HsKUa9+vYlXgjtlW9udJ2PEhVM8Ijr2rP4fHkncLlIwI91uxbLbsuXyXpbtLkoh3s0ffLLsfvSeBb6o5LvEDOCKGESvKvYOBBzYdwj56klMqBXM4FhdEq0safinrM4xnDIrXw5+ZrpBrtlgs2rX2/vhwlo8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199015)(46966006)(40470700004)(36840700001)(86362001)(2616005)(36756003)(54906003)(40460700003)(6636002)(83380400001)(336012)(1076003)(16526019)(47076005)(110136005)(426003)(356005)(82310400005)(478600001)(26005)(6666004)(186003)(7696005)(82740400003)(70586007)(4326008)(2906002)(40480700001)(8676002)(41300700001)(8936002)(5660300002)(81166007)(316002)(44832011)(70206006)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 10:45:42.4142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6681c159-71d4-40a7-0941-08dadf52adea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7510
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
Cc: Praful Swarnakar <praful.swarnakar@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
Remove redundant log in DSC that just add additional blank prints

Signed-off-by: Praful Swarnakar <praful.swarnakar@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 1 -
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index af9411ee3c74..f2b6d40e4f5c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -7510,7 +7510,6 @@ bool dp_set_dsc_pps_sdp(struct pipe_ctx *pipe_ctx, bool enable, bool immediate_u
 		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
 		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
 
-		DC_LOG_DSC(" ");
 		dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
 		memcpy(&stream->dsc_packed_pps[0], &dsc_packed_pps[0], sizeof(stream->dsc_packed_pps));
 		if (dc_is_dp_signal(stream->signal)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
index 784a8b6f360d..c08c01e05dcf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c
@@ -200,7 +200,6 @@ static void dsc2_set_config(struct display_stream_compressor *dsc, const struct
 	bool is_config_ok;
 	struct dcn20_dsc *dsc20 = TO_DCN20_DSC(dsc);
 
-	DC_LOG_DSC(" ");
 	DC_LOG_DSC("Setting DSC Config at DSC inst %d", dsc->inst);
 	dsc_config_log(dsc, dsc_cfg);
 	is_config_ok = dsc_prepare_config(dsc_cfg, &dsc20->reg_vals, dsc_optc_cfg);
-- 
2.25.1

