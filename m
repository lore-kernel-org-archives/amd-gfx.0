Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FEAC47422
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 15:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0478F10F93B;
	Thu, 25 Jan 2024 15:55:53 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48B9510F93B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 15:55:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OqVPsN/VAcb1qa5NsPZPdaYVuZbMUaqwjL4po45SCKU/UZ25c+Jz/Azy6SQA485OOjTaAq6TFgGh22wxYY8XVB2aLZNB9CNFgIG+um5bJUf6hYslPhixCcY2jQe43VG82fRf1F3UC9Y9Z8vdCtxiWUw6tfa4R/1QJxjYxjTlc+P+7qQ6+SArzC3R9ql0Hoy937tjgNWdqohGlW+J9vLjs+NoB+cZh6jEmzEO1lHGhS5B/zD3GWbgUCKQZ+sMpsO52bKGOUNUCjF61DKoaEYQDmm0baL+zPwnKKeRqoY0vkg3enB8utgygt9o+Hd7MfzfstrRCoF3DX7pfj9l5Bgxng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whP9JhutUf6l2pItQtSauy9Kx3G7yTqqSwOJTsfuJvI=;
 b=RhrrKlesxtwpr/LmY7b/qF7SERaQZlkS5LJC0MnggwUME0qkVewlIZgVUce2jLRuWCbH9MQ+6ks8GYomNX99UP2kZmoq1rOxZL5VJLTGk/DSW0Bhr+jq6HBZi4oE8NAeUaZ1OM8mRwFCGmaDYln+JFOfCDjK0TBLGy5nDezF9P8rYt6XIqCmEnve2kzc90H9GOjnLaVIlrEaT5xzQcrvxBFaF67r94dOq31DHfCPDT9ysAm3H69Xpurcpq0KUdHymxtZV/Z1NmQhX+V8udB5Tcl1qYZJvOExXWRbBcmqQqdIOSs4bRUdBkMKCLGy6csOj4dgmUPFww5v6Pc0kf+07Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whP9JhutUf6l2pItQtSauy9Kx3G7yTqqSwOJTsfuJvI=;
 b=cBVy2I86dhvW/EyS73jux0ztDH+xwedyJtxBamAnCjtb3cWSvIaeopjJoEUg5Xn60jDoDtnMymX69jrSKDiEfVABfRlZOTTdWfutE9Pkcg3rBxrlsTwUinXtt2PvIYs8FSdJT93nO6RtOyOH5W1uEB6RiN5AtBwkLDXQTmJuLVo=
Received: from SA9PR13CA0032.namprd13.prod.outlook.com (2603:10b6:806:22::7)
 by PH7PR12MB6636.namprd12.prod.outlook.com (2603:10b6:510:212::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 15:55:32 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:22:cafe::af) by SA9PR13CA0032.outlook.office365.com
 (2603:10b6:806:22::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.19 via Frontend
 Transport; Thu, 25 Jan 2024 15:55:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 15:55:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 25 Jan 2024 09:55:26 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd/display: Fix potential NULL pointer dereferences in
 'dcn10_set_output_transfer_func()'
Date: Thu, 25 Jan 2024 21:25:05 +0530
Message-ID: <20240125155505.1258618-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|PH7PR12MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: d4c8ed1f-b4c5-4ece-2505-08dc1dbe0dda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkdJHWsdd+avDy9Yx+UtB9wAgwicH4qfjyVr82TVzIOV8EEX+OtYmgMhsPh/TG0r7oMZ87VUCoMdwqyOodC3eiL2L+IiDEAIXBWyMnVPw/01fLgE+InGIX0OhKhhtQLA9BlvOofkIDQWHhh+3yHRrf5eXAeaMA4QzKh62VjtYPyrcHHwnevy+CEsJut0Elpf8/OfRXbsF9vnEEdoGGcU8V8pREBiDLcMfbdPt/rloQy2Nb4rQAJRtDJ1d9TgyV0tu3467zHRdpFLLhOTp5bDx1HqQbjhW8zGjamb/OATkVsKJQfggRy5cKnNGAoLlR1pGUw6zZDLbUSpCnUfT8LmQ8jd38zfHJCGn3XTDY00ggODyM0HjviEMmzLD9VGqjiATkC9TyAF9CIDNNuVCrHdHCBYhKQQJzQXxwB2Fx4scrQUNa7o0YN3XSqm41ikj3weNq3vQOWPWOhUZ0u/fZOEfJpRnw9zuGm67fdMzwt/8zw3K7rdKfIEAi74GG1K7hd9U8EXv35TaJnS3ILlrBj+SiIvBF5mHuYEDFiSR8K2QFFD9FpI1gRcd6FG0lwZ0r1OyRD8xMMwuEUoTKWrY1tqFl4tHu0gtk+2A+YZUABgWcSQZVeKUYsdvGn2zeHw4v4mp5MZAlYoE6S1/YE/+wew/GK0IiLQwY+K1edXscp1Pce2MGLTmN8Yoenlwp5F1lDUeKVsEuZbe1B/GEa7FdWmqHC2axN0nyJ2AyrI7/ftkXQ0GnOkNO2VgfEjLxtwX7EdUmw0AAD065z4ee0I8+kspw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(39860400002)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(82310400011)(40470700004)(46966006)(36840700001)(5660300002)(41300700001)(2906002)(36756003)(6666004)(2616005)(26005)(16526019)(1076003)(7696005)(83380400001)(426003)(336012)(86362001)(316002)(110136005)(70586007)(6636002)(70206006)(54906003)(40480700001)(40460700003)(478600001)(356005)(81166007)(82740400003)(47076005)(36860700001)(8676002)(4326008)(8936002)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 15:55:29.2378 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4c8ed1f-b4c5-4ece-2505-08dc1dbe0dda
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6636
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
Cc: Anthony Koo <Anthony.Koo@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org, Wyatt Wood <wyatt.wood@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The 'stream' pointer is used in dcn10_set_output_transfer_func() before
the check if 'stream' is NULL.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/hwss/dcn10/dcn10_hwseq.c:1892 dcn10_set_output_transfer_func() warn: variable dereferenced before check 'stream' (see line 1875)

Fixes: ddef02de0d71 ("drm/amd/display: add null checks before logging")
Cc: Wyatt Wood <wyatt.wood@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index d923d8d915f9..22cce2b58f95 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -1890,6 +1890,9 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 {
 	struct dpp *dpp = pipe_ctx->plane_res.dpp;
 
+	if (!stream)
+		return false;
+
 	if (dpp == NULL)
 		return false;
 
@@ -1912,8 +1915,8 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	} else
 		dpp->funcs->dpp_program_regamma_pwl(dpp, NULL, OPP_REGAMMA_BYPASS);
 
-	if (stream != NULL && stream->ctx != NULL &&
-			stream->out_transfer_func != NULL) {
+	if (stream->ctx &&
+	    stream->out_transfer_func) {
 		log_tf(stream->ctx,
 				stream->out_transfer_func,
 				dpp->regamma_params.hw_points_num);
-- 
2.34.1

