Return-Path: <SRS0=JNIh=LB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95711C47082
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D51760FE5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Jun 2021 16:48:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D51760FE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22E746E939;
	Mon,  7 Jun 2021 16:48:38 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2057.outbound.protection.outlook.com [40.107.95.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA246E939
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Jun 2021 16:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSWpNH8UOp7JQxvaFkdLrfnwoXbujNNLeYLECdAXmdDGTmaZRGwWFk57S1XCOpkKnB6DCgSDsGEL7yt8EsvGouiomsL2nDDGit/JdDCkfXXHSSmrnFqmAyGgwen/pwt1Bu96z05LNIbg5SZJM/HMuEqCpIDsk44oHNJ3Ue8MpEyaPWJAsTD4jXOcBdXeSTMEhbQhFpdRWOzBlba/zbyggakdCUZfWFIDUM5Y8UEkjDxa2sxkML3arlJ5PeLZ4qWbJToPx4UoRk35xcIsHudjo6BIDa48ZpgzdT8qOdfCNE4x2CYpOKfR92N5xTxcSITX/YY15qhyrE2XKCsO9cHJHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKZhbE0LjtvMtpIb3csv9juNDflk6wO5gJx6DSiRaH0=;
 b=LSOmzcIYUfyS5rBJ5rV8qu2Il7aZ7QqllVz3w3GHrQ9OuL2aQ1IMStRUM/ZjaR0ymDbMHbSETer0y6wmEh3UUo80d8dGY8ffy0im7Y5O/mMEzZlg7pQTaworvQKsrWp774UH+CdUZBPQ2W7Bz7WlpN2wUO0ZGEPzHXwrmk2DBwTx14uWdHIfhzQy25IFxfsJmbBI00Nv/rK/GvDoxA+mrJA2u19EuTv/kqGisZSlikgcu0T76Hq3TskLC89R2idk6dHT0DwGdT+zTpR4vQUmJQjxV8/LjibqUqgSkcdPZIFjQIvJN+GbT9L3c72hPqImNfiv4u2P/ry1c1EFbNvh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKZhbE0LjtvMtpIb3csv9juNDflk6wO5gJx6DSiRaH0=;
 b=PCwwmrlxEumew/7TZV3YoX/06WugniQg10QwQmE6dlipFsR2AMpDCH9iusSz7AY45GzJnQeMn0/0cRG/BRN8tP65ZnsbMwO+5L033A22FvDgjsby/y6OVruBCQIDy/JVGvM4lxPTfd66IUXXm3C7eI4gYOLNKVrpp4OrGdtf7+U=
Received: from BN6PR13CA0038.namprd13.prod.outlook.com (2603:10b6:404:13e::24)
 by MN2PR12MB3949.namprd12.prod.outlook.com (2603:10b6:208:167::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.25; Mon, 7 Jun
 2021 16:48:34 +0000
Received: from BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:13e:cafe::af) by BN6PR13CA0038.outlook.office365.com
 (2603:10b6:404:13e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Mon, 7 Jun 2021 16:48:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT058.mail.protection.outlook.com (10.13.177.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.22 via Frontend Transport; Mon, 7 Jun 2021 16:48:34 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Mon, 7 Jun 2021
 11:48:30 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/30] drm/amd/display: Enable PSR Residency for multiple
 panels
Date: Tue, 8 Jun 2021 00:46:58 +0800
Message-ID: <20210607164714.311325-15-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210607164714.311325-1-stylon.wang@amd.com>
References: <20210607164714.311325-1-stylon.wang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07ee1da4-373f-4361-7ebe-08d929d416c0
X-MS-TrafficTypeDiagnostic: MN2PR12MB3949:
X-Microsoft-Antispam-PRVS: <MN2PR12MB394971A5FDF1598AF300E056FF389@MN2PR12MB3949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rm/J2UclI/b54FMH8Oun0iyNa5nmuRGLT4xd/LoC8zMTWbNhuzR5Y5nkz/jkArLMlnKZekUggLvScRZ9menbEQjwvQYW8j4h1fOpSRCPaHQ+nPUsyvcXUArKD4JOub70khd4KW+TBcCnkgHwtbLRgKIHmpweYdBQIMud7Nu8ywvbzTZ0788o5o/tb/G9lqr05vSxXa42rnv8ZRX7SysOxOR1A8jRQ8PnFOMDtKyfianZkVuBgwhW1Wlm65SWvCYXR1X08/2MntkrCYkTZ3Tgywo7f2dI4lpO09wdn14YjmGiJ5OoQrbFLX3BTFA8Wye+KrI/RKrhE19yr4bN239tYuAG9U57pZ1BRN60RUSzC3bNXgHrFBaowrwiycr5wkMXM0bYHRrkWozNjbS36TA+EFGHQLNcWwxq2y9ajouoET+UZ5Qkf0iRACCaSptBkbQwkrnlhbBGaSzbj4dqFJPv35h9dwu+t1+GuguDVYUzLgw+jwuVXRXaHq716Q+jQ0GDaYtus66tmMaalr3/B/xvmGCRICSBMCMS/inrLgMb6HCNXzaS6ty6bBnRkZg41mOuRWiXzAKgfXDRGHNmhL91VFWgmpPTRf1aDLrsMe63L8bvTc+UIBS/wSIuPtFKavItndvX2wIWZcxXRMGTu/nxu57Jl2/TzxQiOVkGVn423Wfj7vmluLYIXbUjUV7N4pWf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(36840700001)(46966006)(36860700001)(1076003)(83380400001)(8936002)(2616005)(70206006)(82740400003)(336012)(6666004)(8676002)(82310400003)(26005)(16526019)(186003)(70586007)(2906002)(81166007)(356005)(6916009)(44832011)(316002)(54906003)(36756003)(478600001)(7696005)(86362001)(47076005)(5660300002)(4326008)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2021 16:48:34.0715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07ee1da4-373f-4361-7ebe-08d929d416c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT058.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3949
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
Cc: Stylon Wang <stylon.wang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mikita Lipski <mikita.lipski@amd.com>

[why]
Allow specifying which panel to take PSR Residency
measurements from.
[how]
Pass panel instance to DMUB through GPINT in the upper
8 bits of the parameter.

Signed-off-by: Mikita Lipski <mikita.lipski@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 8 ++++++--
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c | 7 ++++---
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h | 3 ++-
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index ce637bf0cb81..d1ade55a8d47 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -2928,10 +2928,14 @@ void dc_link_get_psr_residency(const struct dc_link *link, uint32_t *residency)
 {
 	struct dc  *dc = link->ctx->dc;
 	struct dmub_psr *psr = dc->res_pool->psr;
+	unsigned int panel_inst;
+
+	if (!dc_get_edp_link_panel_inst(dc, link, &panel_inst))
+		return;
 
-	// PSR residency measurements only supported on DMCUB
+	/* PSR residency measurements only supported on DMCUB */
 	if (psr != NULL && link->psr_settings.psr_feature_enabled)
-		psr->funcs->psr_get_residency(psr, residency);
+		psr->funcs->psr_get_residency(psr, residency, panel_inst);
 	else
 		*residency = 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
index c41db6d4e794..10d42ae0cffe 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c
@@ -327,12 +327,13 @@ static void dmub_psr_force_static(struct dmub_psr *dmub, uint8_t panel_inst)
 /*
  * Get PSR residency from firmware.
  */
-static void dmub_psr_get_residency(struct dmub_psr *dmub, uint32_t *residency)
+static void dmub_psr_get_residency(struct dmub_psr *dmub, uint32_t *residency, uint8_t panel_inst)
 {
 	struct dmub_srv *srv = dmub->ctx->dmub_srv->dmub;
+	uint16_t param = (uint16_t)(panel_inst << 8);
 
-	// Send gpint command and wait for ack
-	dmub_srv_send_gpint_command(srv, DMUB_GPINT__PSR_RESIDENCY, 0, 30);
+	/* Send gpint command and wait for ack */
+	dmub_srv_send_gpint_command(srv, DMUB_GPINT__PSR_RESIDENCY, param, 30);
 
 	dmub_srv_get_gpint_response(srv, residency);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
index bf73c7edbd9e..9675c269e649 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h
@@ -44,7 +44,8 @@ struct dmub_psr_funcs {
 	void (*psr_set_level)(struct dmub_psr *dmub, uint16_t psr_level,
 	uint8_t panel_inst);
 	void (*psr_force_static)(struct dmub_psr *dmub, uint8_t panel_inst);
-	void (*psr_get_residency)(struct dmub_psr *dmub, uint32_t *residency);
+	void (*psr_get_residency)(struct dmub_psr *dmub, uint32_t *residency,
+	uint8_t panel_inst);
 };
 
 struct dmub_psr *dmub_psr_create(struct dc_context *ctx);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
