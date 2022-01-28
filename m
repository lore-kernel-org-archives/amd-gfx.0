Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941DBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 14:05:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2153210E5FD;
	Fri, 28 Jan 2022 14:05:19 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2069.outbound.protection.outlook.com [40.107.96.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4B7089939
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 14:05:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5yGywhdQQ3DDcCzTL+tdFD9uWGqZYi+AOqz/S7F2HoOxdGzKiBZATGOHd5A1U6JLLuhwpO9HbOJ3MC7/ng8p0nMjr4BpYzPs4pVN4FRQPw2LliDEJUzNVfh0nuE0ZKlED21PhSBlWf72OmhI7AQRtcQ6cnlVGTrEQF9qWzHcl0dTp8S5E8X6evMglk88BBsIrwcMD3/XSyTXicYOP9k3DqaB9KxfTMheevAcll4SNQBNNv05fBm2V416vtAxjIXmxkHmRFc7thV2S9nnRrD/8tysDyRyH4OwLB1rn92zwj1f1fJmVS6js0boI1OTdQUTK+K5OTTQPaAeDLJkk01rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NSyC7k5uON5Fz1ld0o3lzVPAov/PDSeQfw7s/RiBj2A=;
 b=Ku5We8zT8JqFvidBeRQOWsiDbQuwSPbSSbgkyINSbGkh0v3AQaJvZUibaCGtmg7EaKINdVm1elxAn5ytYc3hYjuFz8DrUZ9QsCVQCdSJMB7c1cBQ/Cls2dMVW3Q65SO9zTD3axETnpGcZQUsTGgYPtImzPMqArvAMHif+ElHVnVig0E8ixzkhFOe0QY9H0aig0VaUaV2+A1ssvOr//8gQ9R+tWUfFrmNLRk4YAOAw3mrm30lJgdTbKJZnQK8E4sXA8PnyNRHcEfqRmzUHxhwe/5k/8Noihypvi7C9T2mHElFHqnmqaQfRLHpeAG/zKLhIHyQrbi6B2ueWUbARTo4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NSyC7k5uON5Fz1ld0o3lzVPAov/PDSeQfw7s/RiBj2A=;
 b=OgxO8lNY/nxsG0bNOQvyfY3LHhGLtcebmTV4G/oDzb4GzbkGadk8Ck4Jr5QeijGD8pKFPG2KKJMD5EQeuDnlFprJYqygd+5fd5/qE3SuayNvqKlXG1MVx7+Tb06+/bweYGaUuFgWQvEIJQ0eNsefZpgLieE+7p2tXFrNaT74P3E=
Received: from MWHPR19CA0005.namprd19.prod.outlook.com (2603:10b6:300:d4::15)
 by CH2PR12MB3862.namprd12.prod.outlook.com (2603:10b6:610:21::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 14:05:13 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:d4:cafe::c5) by MWHPR19CA0005.outlook.office365.com
 (2603:10b6:300:d4::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.18 via Frontend
 Transport; Fri, 28 Jan 2022 14:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4930.15 via Frontend Transport; Fri, 28 Jan 2022 14:05:13 +0000
Received: from stylon-T495.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 28 Jan
 2022 08:05:07 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/17] drm/amd/display: add infoframe update sequence debug
 trace
Date: Fri, 28 Jan 2022 22:03:58 +0800
Message-ID: <20220128140411.3683309-5-stylon.wang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128140411.3683309-1-stylon.wang@amd.com>
References: <20220128140411.3683309-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07b2d43e-cd77-4abb-c49d-08d9e2673430
X-MS-TrafficTypeDiagnostic: CH2PR12MB3862:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3862B69748A0E705B7C62BE8FF229@CH2PR12MB3862.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y82dPIa2RZU9FAd9TKxosFuzQApEVPLtheoRnfhS1qiLwApfasG1DFy3JMbyJeSlHcnGFkx71nZNTfAbEzAaVffqzvQAMX98QYLWCXEaYuIYqKP99Jca1eU+Nvd43yJsYzjZ/RgSrUpO7X/bW9RIsiVrD9zaFc961hyVagSzDyB8wyAm8QZlNGv4YF70Ym+3ViKrMZCEa20r6hy89bpp687cyyInPXnVtpE7kT/SO6VsatXTOJE3tqeCih3wOpyWtnYGIdTxMMvLqJslHE9kqlDqPEBwA4Z6TZeF8fGq8+xbJpFnubl/9brGnUAyHG+vmDRMd1PybNowRPZWWONDT7IQKjfd4lsXqUW8lWaf2pDhZGfh1xOtgVdWBaggri59PqOpUShKRGBuTm2xrhS+BsBmD2iTvCFHUYZGgKHnlyjIr80+RJYR2UuuZOuR2lbJagfWWUuy6ef30cekDFNPZEN42krYmFAYEKkJsUnQC7FlmLXzxBbWMMKuE8b8DmcJj1DQh1J6k5syUXspZ+U99rUyg3Q/ZKMkRf67clUyXtcoImbqM8NdtZ00TJOutv57Hi5znP4RMFRsR2QgC/WbyAwQMk/GcEY9oWk2ULyF1VfoKId+aaM/mmo2iLK+ca8wDqU/l/5BkfyiGTYJTUTKTTvYAsf6sNRwSpUHDwFIQ/xJdxM8+VzIiFFianMF3IiaGYXNLY8TGLByCmeTs8iv8A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(8936002)(508600001)(36860700001)(81166007)(8676002)(4326008)(186003)(16526019)(70586007)(2616005)(1076003)(26005)(15650500001)(316002)(82310400004)(44832011)(356005)(70206006)(6666004)(86362001)(7696005)(336012)(426003)(54906003)(83380400001)(2906002)(36756003)(5660300002)(40460700003)(47076005)(6916009)(36900700001)(20210929001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:13.2881 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b2d43e-cd77-4abb-c49d-08d9e2673430
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3862
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Martin Leung <Martin.Leung@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why]
We find some of the driver sequence debug trace for infoframe
update is missing so add it.

[How]
Add the missing sequence debug trace for infoframe update.

Reviewed-by: Martin Leung <Martin.Leung@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 417c31f51562..1d9404ff29ed 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2720,6 +2720,9 @@ static void commit_planes_do_stream_update(struct dc *dc,
 					stream_update->vsp_infopacket) {
 				resource_build_info_frame(pipe_ctx);
 				dc->hwss.update_info_frame(pipe_ctx);
+
+				if (dc_is_dp_signal(pipe_ctx->stream->signal))
+					dp_source_sequence_trace(pipe_ctx->stream->link, DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME);
 			}
 
 			if (stream_update->hdr_static_metadata &&
-- 
2.34.1

