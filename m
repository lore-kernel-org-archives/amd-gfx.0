Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FB4C47258
	for <amd-gfx@archiver.kernel.org>; Wed, 31 Jan 2024 03:28:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D01010E393;
	Wed, 31 Jan 2024 03:28:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C578110E393
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jan 2024 03:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EZg/xhyPufovdMP+x/yGWzUY+ZCz76yuYZ6juokZL33mwc9xzuIpFsOskDcc+QpyM1eqGfldsWtcj+Sz6WFAyCp1RS+rF0QpsKZUBUs2eM8UrcyCOxsBE1stq3td8FQR2eEcwexKBN8BYNSG95v8vqk96hBT5FblszJbT6RZYtE/Kmgf7tBCGyoEAGdbw4HeHX9ZeutN4zwfu615HgLNfSBwlmRTUNl6qUx3eIOchQzqrMJXY39re44EUavFjeu8gGE0yYsh0yXpIbFnpkQqvqRzc1MtsZSnckJOYr8juTeSvaYwoRsgGo9njSsZmhWks9tKdHVrvzdl1eqqY5hf+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMe88iTCx/fuscZWLsozonmhZDXzirm0iMtQztO12XE=;
 b=YizkqmyJ05IoPyMRzI/yxYQdepaZzP01+HsyllNq6ZjE+eKlQTku6dFEnB3/6UOq/h/kZUxVsc1fcEmb8HqKNFkfoCmqXRzAtiGclqvQ2po0LCUTVey5ulT0L17r7dlzT/2zzVFbm3FQss0RlCNIFiPdMc9aRv/hqHI3VoHDskAhcWksZ2kO+U2rAlUFqxXiwtI6pCkWjhSbzY1xlp/E2fGy0qwaLZIekvdKMowiPwrkMG3mXX0i/O9TiksVR7wj2+quX9jo0F6v53DmJa7v03FgOtOLUV4+yqACEhOQFpPYyq+oWG99VKlPHQxth3jvc0mGwAgh9XZSDLOvebx9RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMe88iTCx/fuscZWLsozonmhZDXzirm0iMtQztO12XE=;
 b=aKo0lAEtRD3eoJ6jHIc9zVVfn0fatZh9sxz0US+MNEum03un83rRzGCW8HAC3G/r+h91aumYPHYETkb2KJNRxszzOcDUkj4fBwnyxgfsCggpjcbcDmxbALWBonRtLfu6c7nYpHITOH7u8Ae2BxmYVsOX04FYUjzKFTk4KIEVsOY=
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 03:28:36 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::6e) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22 via Frontend
 Transport; Wed, 31 Jan 2024 03:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 31 Jan 2024 03:28:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 30 Jan 2024 21:28:33 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL test for 'timing generator' in
 'dcn21_set_pipe()'
Date: Wed, 31 Jan 2024 08:58:20 +0530
Message-ID: <20240131032820.699251-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5664f2-6eda-45e3-2642-08dc220cb571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6PKEW0L0kyPuLQdqSBuz/k3slva7seCaoWrYWjTLPZC2V5HEMmePU4PRfZTkrt9YcUHe9gqFGWK7u6EYp70VPoj7BPfvQJducuRX9sMjxYQZg1ClhIagukYqGZ84q/c2qbeRmmZspGVJNbqdmNUWsrwlAkbGtaTdBCiSjP+aVS5SA6VJdCU2uZzN2XuSCU2M6zo9TFjO8zb261/4o0zhbaq4VD/uamYE1CRHr9Fl/1BLZk0R/2IsHTxd8rBOPkge/sXfX1eCpR7rwjlkFckit+XADF8FiDHjImcaiiRjjGgoLOUP5tN3LadeXnDxnTORf3Uafuo5mi1j8/ZVvA4NKOvwQ5f5EcaupIODUZdGDgZFMKGRgbXNgoBK6CvjRaBqXdQjb8cF9Lb+TQTek1087pxjtj1kMMil5s/K6SJQ5us5ysoxL1hr/Gq03seRbPZi8oE0cDW0zREbG9DSYpr4PY+4pET69tHI4Iqq+wSzvajCLx1rN+7wEKGdb3V0HlalApPBzmMjb1WDmRwlUyKaoqUvfLqb7trPMFzDSeIKsOER431R1z3MSYzCA/aOf4YAoDZatCcz78V4uunNBT/Qu21+Pzduc3YmLddNfxYJnHIztSB/A3G4fLAdGPEQjyt0gRNhCD6rSEGomLODFmzVQhlLHnIbuJvRmha4DTpbBCeYnhtht3co8EEv2Sb76rty3q/MStj3GWpnQvWw89wnZwxu9OzTnpdlL1OaKq37GfJd7Fz6cP7dPFRi/xfEkCkuCQf94k5j20UlKLtHd1ljg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(36860700001)(478600001)(110136005)(356005)(86362001)(44832011)(2906002)(81166007)(54906003)(70206006)(36756003)(70586007)(6636002)(316002)(4326008)(8676002)(8936002)(5660300002)(82740400003)(41300700001)(426003)(7696005)(336012)(40460700003)(40480700001)(83380400001)(47076005)(2616005)(16526019)(26005)(1076003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 03:28:35.8029 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5664f2-6eda-45e3-2642-08dc220cb571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   | 24 +++++++++++--------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_hwseq.c
index 5d2d8fd64d98..4e21af0942ea 100644
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
+	u32 otg_inst;
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

