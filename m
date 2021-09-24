Return-Path: <SRS0=WCud=OO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55879C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EAA661250
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Sep 2021 19:09:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1EAA661250
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0E716E20B;
	Fri, 24 Sep 2021 19:09:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E045F6E20B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Sep 2021 19:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/vFePiBJUCRcPnB02w4Uflh+FHe4TjnwD/YiHPgdC5Uv5j1GT58/oxfvnFP3zWnxQvuZ1GPhVjCRFsKpDJy4KPdFmGVN2W519amK2P4aZCNBYR7Bpg1DW79mx+eiONKmY4fLhrM1j/4D30jupeGYB6ab4Fi3jIeTiKl2DFKatoMvRIwk3aOQK0zc8c/5dEKZ9uDrT/9/4KPUVnC5v/IpaZutZx9YA53GwJDruQlP21xHocaBSVwdvLF6itJWGb/zsYpXpaE7tBKbF7lhpNypaj2gI2AYHHsLnzLSrzDPPkRGIEheDIap/yDU9N6H8FsrTs9lIo2Fx0U3sa7Lg8lcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=EpNoN+a6Y2xpv4s0vxRuSSKn3rpKPyWm2VLtJMOXb9Q=;
 b=fR17VdlEKBcVoLeVwxt99iMykhqIZKe6z2U5+yhmPhKUxPMU6lL3/FJM1oufWWANbjBrLG2PAEucPVjM+z5cwiLiRNuG35Bl7XHjC1KKMfFqkAGWZ7zUAqI/nHLh4ACo8EHAkhGuiAbOpfuVQv9urWact0+rTfNvIp68AyFMmjXTQ6Hs33QMNfyX8EDp7bv0Bf1VNVSnCMT0D1gG5N8Qc3qnJNhy0ozXWYv+4y8DSAtguvDYm44da8iBIPtlLUaXPoT0n8UXPGVSnoWdqxKO0USaNIBazrbuytpGVquYgTbuUieOJZiE2uyCAyEWXRBhDFlXA/s6o/ju4ScDjAUOaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EpNoN+a6Y2xpv4s0vxRuSSKn3rpKPyWm2VLtJMOXb9Q=;
 b=VGuOSowiT9lVHk/3D83Bo/ITV5nquz42B6wIiWsiGjj2k8ABTGLABPXsxcOaRW2W3BdhlL+dKA3UkAcgsP5O0RsDS4YKtD3jJRz5ySd8+H3UObDR/sF5PeMBjn1BH7nsp9YoQwnWteX9+NElRRc0aEWwh5JoU9TwYr5yNlP+XeI=
Received: from MWHPR22CA0072.namprd22.prod.outlook.com (2603:10b6:300:12a::34)
 by BY5PR12MB4885.namprd12.prod.outlook.com (2603:10b6:a03:1de::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.15; Fri, 24 Sep
 2021 19:09:49 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::1a) by MWHPR22CA0072.outlook.office365.com
 (2603:10b6:300:12a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14 via Frontend
 Transport; Fri, 24 Sep 2021 19:09:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4544.13 via Frontend Transport; Fri, 24 Sep 2021 19:09:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 24 Sep
 2021 14:09:46 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Fri, 24 Sep 2021 14:09:44 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <qingqing.zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <roman.li@amd.com>, <Anson.Jacob@amd.com>, <wayne.lin@amd.com>,
 <stylon.wang@amd.com>, <solomon.chiu@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Michael Strauss <michael.strauss@amd.com>
Subject: [PATCH 01/24] drm/amd/display: use correct vpg instance for 128b/132b
 encoding
Date: Fri, 24 Sep 2021 15:09:11 -0400
Message-ID: <20210924190934.1193379-2-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210924190934.1193379-1-Anson.Jacob@amd.com>
References: <20210924190934.1193379-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27faeeae-6c61-4fee-9274-08d97f8ee16c
X-MS-TrafficTypeDiagnostic: BY5PR12MB4885:
X-Microsoft-Antispam-PRVS: <BY5PR12MB4885E4796E14677B2874A4E0EBA49@BY5PR12MB4885.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b5163r8kDUNJS0lqp0HP64CnQkz15hMTKopi5uVi/3ZnJfZPZjR+r8H/4VlwjnWMZky0k1Im3N3asMRR85zHfgZmwnXKyVwbGRClWwTderCXKcWwy3d4p2oTZjsrAv1cfCP5nT9klyNPovbgrS0NMpJt4hZ87477DNdZtTraXO4/2pgGC9iHeSac0GcuVQkaMjK9MwP+wG/RqZSg7tG8zEiGyd3RJ7PcLSnjKUBcRGCjXqc0b8ok+V+Da3Rpvikbsg5wvO5anxJFPyhNSgR1Qt02RnIDnw96JzhcI7f+fiKntWQGev6vNjphxgi/aVtKD8Z+emAuk+Ppkg/dnrj16Xjd3hJNJST4+NqLDwrP4Tp/mZZbUf0aPLApSUO51s5+s0edO8NNqLWJNgrABEKj4860drflxENkCAkPcoorrhLDgI9DDG9qdzeZ4wM8s7EnLiJV3zkVB3H/JuMaE0knLa+wMDc5qgiq4RxKWfvITtKzCG9pU5RMYbjUdLkypmWgRecjbIuh3aYyivLOY1o2yodaPWgcoYq5lwklnQhS324yqItD+kP8/FEYOTzyW+JLI5yo7TcNxGAonTaH+FrfJ37lNN3hZULsApe/xsbDK8cm0ctx1N2InjkRlQQxlXrk4LgY4rYeeSsqWWekUCexTr2GdPH14/KAMdemX4D4iL3GgEQ4OVxxVirziTC2SzwejlQeTftHH2J+DK/FfaG7DghF1fiRZp5K+zpu39t16vc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(36860700001)(316002)(70586007)(186003)(508600001)(8676002)(54906003)(81166007)(36756003)(26005)(4326008)(2906002)(1076003)(336012)(356005)(7696005)(6666004)(6916009)(5660300002)(426003)(47076005)(2616005)(8936002)(82310400003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2021 19:09:49.2179 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27faeeae-6c61-4fee-9274-08d97f8ee16c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4885
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
128b/132b uses the vpg instance assigned to hpo dp stream encoder.
The current vpg used is assigned to dio stream encoder.
This is incorrect and cause display black screen because the
actual vpg is powered off.

Reviewed-by: Michael Strauss <michael.strauss@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 2bd38d19a447..cab7993b4cc5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3608,6 +3608,9 @@ void core_link_enable_stream(
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
+
+	if (is_dp_128b_132b_signal(pipe_ctx))
+		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
 #endif
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
@@ -3853,6 +3856,9 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->sink->link;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	struct vpg *vpg = pipe_ctx->stream_res.stream_enc->vpg;
+
+	if (is_dp_128b_132b_signal(pipe_ctx))
+		vpg = pipe_ctx->stream_res.hpo_dp_stream_enc->vpg;
 #endif
 
 	if (!IS_DIAG_DC(dc->ctx->dce_environment) &&
-- 
2.25.1

