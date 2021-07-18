Return-Path: <SRS0=r+dI=MK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E59D5C636CA
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A568961182
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jul 2021 14:06:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A568961182
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2644189DFD;
	Sun, 18 Jul 2021 14:06:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B3389DE3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jul 2021 14:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R+/b44SEBrJCp/n1n6mqdg3Bp/3TJEyTbfffVJ38UdERsIzLQIrM1PWX91uOVQ5Mj9hNTztB/YdkfJn9R/r+Xjnv5s7LLa5lKs/GGeBQq1mFlObzkSRTYOvAh5m3UqnuXGISqZPMhBmpCgiHM9Jk1FQjyK8r03X9Nxxg3SeAOnaAKnj1WX5gmzr+3a0qvu6A4n0ZLoJYeU0Lptms8ORXZnJa6iHPaD9ITqfKYdUB1uTPailXYn91jeVRjQlOd9YSN6E/D42A+JbHJqZg2GgJ3ERUqTtdodpQ0bJI1v+aWh6+SSN+2XS4bAIZRbTWp6EN6MrwYc9Guw5JUxEVzr87FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RT1tzRtzELrE8JTE1Uz++ZqttY97K3YbVaHREGl7jsc=;
 b=Z2dZ0seCBnvqk3HbFWx0i7HHnI9O7IZWFwyNCt1SrFrIpEmGmCR0pw1Us3R1P8A+nhQQCttI+CebHgGxWVUnvnA6PWC6XgQY/OGVal1rDm7m82+mQHJAA+3jFWcPCmpLdAXx0fb26cx1SDL1/bjeehkPEuT0kqtoom+bRC3y8uTQGZgzfLPvNn0GvImak+lIi5vCwi0CzMU6dOf4HtpbcaYIcQ7+rD9reWi7Ym+0VyqQJ0iNMY8vOXcTn5hifcY09lORmbv8KPct2KAVRbseGNX7rvTfEMpJo8lSpYsqOWLCIeSNZyCyviKNzhs8cJ3uF+fAC05IOKVXh8mE3O1XrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RT1tzRtzELrE8JTE1Uz++ZqttY97K3YbVaHREGl7jsc=;
 b=FjSswgMz6Pn0IWACLyb0kAAfsYq8VbtYL54PEtBOEDVL6ytWc8kXAGdvBqw+2B5pJRaHf1RvUT/T6StxTPFxlSP2R4l5SOEJwzkYKO+/DgghsYOZTK2cKs7YjbjHAts6fPwLf3pMLChag8h9ETnXTsMwIeOBtnBDEFzybMVOi1A=
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by BN8PR12MB2962.namprd12.prod.outlook.com (2603:10b6:408:47::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Sun, 18 Jul
 2021 14:06:26 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::6e) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.9 via Frontend
 Transport; Sun, 18 Jul 2021 14:06:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Sun, 18 Jul 2021 14:06:26 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Sun, 18 Jul
 2021 09:06:24 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/32] drm/amd/display: Fix timer_per_pixel unit error
Date: Sun, 18 Jul 2021 10:05:41 -0400
Message-ID: <20210718140610.1584616-4-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
References: <20210718140610.1584616-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e406b322-0ae7-4109-f451-08d949f53b68
X-MS-TrafficTypeDiagnostic: BN8PR12MB2962:
X-Microsoft-Antispam-PRVS: <BN8PR12MB2962A09E5A9349B0D7174F2998E09@BN8PR12MB2962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bCcA7GlkI1v4QU8+xVh/d2L4WyaNCm44yxaDB0mptsP+AVrwpXMgkvtR8xke3gdww9zL79yllNX5Jqh0JEHujWNnnfmmE6cteFUFUx41A1NrhpN52/cqnmjkTGzO0wAgCvh6KmFUF3vyotyzLnPr19ud8jweNHjYVPXErmCyMJUtNPg3KUjzTnF5n+7dZkpjK9OXVy3z9X6v8tUvW0I19N8JkDQJ0OrO17AY+FmKZIitPCB4dDIXQ5ny1kduQKZsbwn5qJQrMc2pmopkrp31UHKTiGs/e+4lpiw6jzjnGMKn3O4oYvTXU5gDLHDhn77Mn9uGw2oxZDFnnZHbuVMtFP+6ca8SwdAvCxR6rPGnCIkQob2huTubNVkOgcm3SMD8yTB7trtqM+cgFhikJrxS+FZlkTYlQ0R8eghrzVbsXD6F9F6PqOU9/+SrWjmcGa4UgJukLEFvMbBXEcfDjRrAM8sJ5fJzXvOvL7/zZ2MALf8AWE6Jq8Tl60Bs9P2bVQ+mlm276M0qkls2HlT7k2LqW3SYDJygfQisC4VmFmLxWQO1nw95bScwktYHOkn7GQl/pco4WirCPOa6PAjMEJfdb4NLlGamEgtxPSKaUK0IUE7X0YLcL/6mWN2gUfj3WZ4tQOC4nA47OvlapsvQtmFAXmPIBkb92l4dUzEGv84j94GhkkYjHuuCQf7cKuj8ub8z3dQcUIzMNiFIVh1XRntMu4hjdmiGOSYaQqjAtxXIO1k=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(136003)(46966006)(36840700001)(1076003)(82310400003)(86362001)(47076005)(8676002)(81166007)(82740400003)(6666004)(36860700001)(2906002)(316002)(356005)(83380400001)(478600001)(26005)(70206006)(70586007)(54906003)(36756003)(186003)(16526019)(8936002)(4326008)(5660300002)(6916009)(426003)(336012)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2021 14:06:26.0476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e406b322-0ae7-4109-f451-08d949f53b68
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2962
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
Cc: Oliver Logush <oliver.logush@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oliver Logush <oliver.logush@amd.com>

[why]
The units of the time_per_pixel variable were incorrect, this had to be
changed for the code to properly function.

[how]
The change was very straightforward, only required one line of code to
be changed where the calculation was done.

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Oliver Logush <oliver.logush@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 1b05a37b674d..ac981aa92d7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2460,7 +2460,7 @@ void dcn20_set_mcif_arb_params(
 				wb_arb_params->cli_watermark[k] = get_wm_writeback_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 				wb_arb_params->pstate_watermark[k] = get_wm_writeback_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 			}
-			wb_arb_params->time_per_pixel = 16.0 / context->res_ctx.pipe_ctx[i].stream->phy_pix_clk; /* 4 bit fraction, ms */
+			wb_arb_params->time_per_pixel = 16.0 * 1000 / (context->res_ctx.pipe_ctx[i].stream->phy_pix_clk / 1000); /* 4 bit fraction, ms */
 			wb_arb_params->slice_lines = 32;
 			wb_arb_params->arbitration_slice = 2;
 			wb_arb_params->max_scaled_time = dcn20_calc_max_scaled_time(wb_arb_params->time_per_pixel,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
