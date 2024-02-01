Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9D8C47DDB
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Feb 2024 09:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C9C210E421;
	Thu,  1 Feb 2024 09:59:05 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD9710E421
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Feb 2024 09:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PcEhDuFBDDxFzgsMMVtOhE+X6V0TfHgkP9SaqNQObH9urB4NMcJFBu43ZgYAHVj25BtBai0SluYCf3eg23xC2K7v1ZBV+r5TT9qXfcqgwQZsgUN7fc4eQA/oelzgxDO60IvG0VbYcqPXpkXiU75sdH+6XY0ZGbB1gjveTDv2kYc1XkAxpkgyn7pTFSX4sU4pbO3gtynA8/pKN4IPN9SoVYrcH4UROCh6gJ6e/fUkRtcxScGHnRCXVhx7+Kn9qCVz5CERG6rRyVo0k56YH4TABDaVbG4prbg1gLspe2Nz4k1l1siWBEleQuHAQrxlGLXBVIUl7zk/8VUU6a0dnfbK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1AhmJj7UquPY3m6nsPWceh4+UIPM1ae5JK5z+TCGrU=;
 b=BwzoEE1E2p763QuM3L9PfhJbSskYE9L+C+2md9GtKxlTExwG2ejSe8HTZN2IY40B879B3wMteOEg3ww66cqgqj0F+Y/xGb9Zc6zWkh8dZa+gZ/L7k0+i0D+X/CFmxdUjxAphWk/+wiX4b0AJDiLm5D/mAXIHnrEBimTmgoE1W/o6vN7ixC9I7FsGLecem5EEYwGPyiTtVS1qEIGx8sve3looU+v2q3NLAgZgGnE6CRl3/qST2TGwJp8hncDBaHbeMyWc8fotnaJJ/anYoCfk65+7M0lapLBgtKs0KacMFpSRKnBjgXRyjjjWkAv4Cb/M0PAzy1TguCyp1xNT6YCVCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1AhmJj7UquPY3m6nsPWceh4+UIPM1ae5JK5z+TCGrU=;
 b=Q/Q44887Fl0oDWcaNImGptb5hSGfYlbt7vJC7UGvjCIRwTatMv3u8HksMx2LF9HWB95znXJAfUTFMDDpnFkRkqzf30hTK5SKp4bCg+NMZZ3w6L0qboxz3bG1kCj9fBNdbHIhf7HzuV1u/KM/UuOR1trQCgg/SwcsbyZux5760gA=
Received: from SA9P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::25)
 by DS7PR12MB6119.namprd12.prod.outlook.com (2603:10b6:8:99::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Thu, 1 Feb 2024 09:59:00 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::8d) by SA9P221CA0020.outlook.office365.com
 (2603:10b6:806:25::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24 via Frontend
 Transport; Thu, 1 Feb 2024 09:59:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 09:58:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 1 Feb 2024 03:58:55 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH v2] drm/amd/display: Add NULL test for 'timing generator' in
 'dcn21_set_pipe()'
Date: Thu, 1 Feb 2024 15:28:45 +0530
Message-ID: <20240201095845.1171852-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131032820.699251-1-srinivasan.shanmugam@amd.com>
References: <20240131032820.699251-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DS7PR12MB6119:EE_
X-MS-Office365-Filtering-Correlation-Id: fa7963ef-e445-4f12-1ea2-08dc230c69a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBnJP66KhtBfTzLhPjGhM6wtI9LfhmKGAFe3lXEJfgUSGRLzjS+it44j3S+tM+bmldoplux1ZXJX+4nXQRQ4yTfi/vxdclJssMigyPTeyba30mAuK9jwYmj84PFGXUC8fZC1t/sbdu97QdepnwPBdQ0M0WWUUQe2/vjeddmzF7uMV66Dw9BqBhtC02bYhyBaT3BihI3DSsMsuCoDaMFJX/7mAn7ncQeu2VLuyToE5xtxHAPSB5Af77FyKWVT65kJ4hU7kt7E/T0bHCSVJhhbuhEISLEYYR0DAV8zfNlLTxNbEz1Y97Q1pbt7OQ0lUYgYbaUGvhURO7lXJwG6S7jKoeb8JHV0DY9tAV9AcTYfYaf8YrRK71UHqpe8iZpkdz8d0aH77rZwLf9LR6EwUpk0MGgv/JrSaG7G8jI+ePxgksMeD/NfPL7u/LfA7QO6YqNjKnpDT3AalVIPig9V5P4HhvUmQ/+X8KI6P/UBEznQrwIZ0ZMQNPRzlgwlADm0Tnlfu4rRT+8Rpsud/HUxzW/e1A8ujsRWENYR5TOld9MQB6v0FKOJAv+Bgq9yKHyYrxW4AHct8Neuoa6wcFMtStOzLCGwf2vafzgY0ex6/EgZB1tVjrnWd6x/4/pnii01tYd3hdT4OeWp9MeYXyfhXhMbsqIc+PY4vQ2GHKTbH+cnGNHgz5/k6hInxcR73vqWX0Dli176+rRxr7mbHPkjnZnHioEn+TpmVt+GcJCt+1p/wTLGzUyJngts0Krt8hyoSy1r0obOSNNp98kB+lXblmaAbA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(8676002)(4326008)(2906002)(86362001)(44832011)(70206006)(5660300002)(8936002)(70586007)(110136005)(6636002)(54906003)(83380400001)(47076005)(316002)(36756003)(36860700001)(82740400003)(81166007)(356005)(478600001)(6666004)(7696005)(1076003)(336012)(426003)(2616005)(16526019)(26005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 09:58:59.7823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa7963ef-e445-4f12-1ea2-08dc230c69a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6119
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
Cc: Yongqiang Sun <yongqiang.sun@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In "u32 otg_inst = pipe_ctx->stream_res.tg->inst;"
pipe_ctx->stream_res.tg could be NULL, it is relying on the caller to
ensure the tg is not NULL.

Fixes: 474ac4a875ca ("drm/amd/display: Implement some asic specific abm call backs.")
Cc: Yongqiang Sun <yongqiang.sun@amd.com>
Cc: Anthony Koo <Anthony.Koo@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
v2:
  - s/u32/uint32_t for consistency (Anthony)

 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 8e88dcaf88f5..8323077bba15 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
@@ -206,28 +206,32 @@ void dcn21_set_abm_immediate_disable(struct pipe_ctx *pipe_ctx)
 void dcn21_set_pipe(struct pipe_ctx *pipe_ctx)
 {
 	struct abm *abm = pipe_ctx->stream_res.abm;
-	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
 	struct dmcu *dmcu = pipe_ctx->stream->ctx->dc->res_pool->dmcu;
+	uint32_t otg_inst;
+
+	if (!abm && !tg && !panel_cntl)
+		return;
+
+	otg_inst = tg->inst;
 
 	if (dmcu) {
 		dce110_set_pipe(pipe_ctx);
 		return;
 	}
 
-	if (abm && panel_cntl) {
-		if (abm->funcs && abm->funcs->set_pipe_ex) {
-			abm->funcs->set_pipe_ex(abm,
+	if (abm->funcs && abm->funcs->set_pipe_ex) {
+		abm->funcs->set_pipe_ex(abm,
 					otg_inst,
 					SET_ABM_PIPE_NORMAL,
 					panel_cntl->inst,
 					panel_cntl->pwrseq_inst);
-		} else {
-				dmub_abm_set_pipe(abm, otg_inst,
-						SET_ABM_PIPE_NORMAL,
-						panel_cntl->inst,
-						panel_cntl->pwrseq_inst);
-		}
+	} else {
+		dmub_abm_set_pipe(abm, otg_inst,
+				  SET_ABM_PIPE_NORMAL,
+				  panel_cntl->inst,
+				  panel_cntl->pwrseq_inst);
 	}
 }
 
-- 
2.34.1

