Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F40ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:18:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86B1010E84C;
	Wed, 14 Sep 2022 05:18:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19ED710E84A
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:18:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LsCsuUysHZfTuSkVcgAMIF4fcC1V7nhmt3xO+rm7ANpbILVyojvYC1wFyfT3cfU0leRJt/ValSlqcRUjmZdD2Kt7kCHkyHBhq4g/iBGlUtFoMQUhoYFKTsvvgNpfC5/8Gho+MQZI0erx7fPULwh+G3M6UZK3dhfdnFS9w/HrpWq8zjKmSas+u0OhTsKS2JH0wxMQ8bo0v+Ic11Asukd3jop7jU+YMgYOxyQ296Frx92WeCF827f4Lua8DOK2pE2XRj+lXkETr9q/Xehwl6dng8A39DrCGbiWi/iW9iuM32lw3xfKBr3UgTlWG1UkbcDepJIvlOuz8Ugxuv7gzwv6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxXoIZjR0MG8hoA5R2lrcy+ti4Zfe0rP1tg8BCv5dCU=;
 b=bsvZ/JH/nkIFDCp3NK7xm+lBttrwaeGxlhCfWAh+3AmhAKG3Ui3eJeAtkajQDaDLTUHUqtwzfQpQbyagK5Udah48sl0fWsEWKwWizCsHhLb3HX0Nr3JjdflPoK3xKDjnXvNRwKjRlOuweR3CEPFU/YaoWjPNRflxEzPfl/wXeAQAPc7zYVbE+7o2qlLhFDf5BqwR4HxS6xzVBIUvv7jaMqDOsVr+MJhXrcIrbThdHIfHw6Ma3pUOtKQr4UnpIrRn9/DuGalzlr+AKXA7UBeQEM8we7NiYWR7xd8m/U+B/An5WJKHimCSEExsG2urRFzebTSDugBZH0PTUB16yqQdSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxXoIZjR0MG8hoA5R2lrcy+ti4Zfe0rP1tg8BCv5dCU=;
 b=M+xtfp2CTM+py/aQ5lbkq8v5ep7JQW5RTlRzwXVUK6mV9gTZeh7jd6K5Q05x/RQHtENVCs/RgiZ8hyTtqEx2cfVvM6TWH+RKWvB1TK5G5uvnBetYoiMhhfKI2McNaIKJbu3biN+J9jgEvdOkAtfT+6OiSAwfniKjBFhBQfiZSWM=
Received: from SJ0PR03CA0364.namprd03.prod.outlook.com (2603:10b6:a03:3a1::9)
 by MN2PR12MB4552.namprd12.prod.outlook.com (2603:10b6:208:24f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.19; Wed, 14 Sep
 2022 05:18:20 +0000
Received: from CO1PEPF00001A5F.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::7c) by SJ0PR03CA0364.outlook.office365.com
 (2603:10b6:a03:3a1::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:18:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5F.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Wed, 14 Sep 2022 05:18:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:17:26 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:17:21 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 32/47] drm/amd/display: Ignore k1/k2 values for virtual
 signal
Date: Wed, 14 Sep 2022 13:10:31 +0800
Message-ID: <20220914051046.1131186-33-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5F:EE_|MN2PR12MB4552:EE_
X-MS-Office365-Filtering-Correlation-Id: 31c6cf1a-e055-4a3e-f63d-08da961089ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7JNb7xrjjSzfmKU33s7QU/s/yGP3jHTupk3NARoUQo1GjPJ/8MVLVfL1tKnkuAkxASfWGjSsa/I8FaIRYfGoXcjmZhUCbhJzDVLop/KUfCciWbXCtCtL0zErtrVKuFltwX7BrrciepWUEXW9VP/9S08nPpxLwhRICGVuNk3RmFyjd6UWtR2hoM+XzA+te0eUqpkG3+i7toO3C6fhivKSQfJAZtvpdR0Wg3dPh8JclJPMut8slW50If1bAu6zS7U2A19aVRMabTMN6Je4XP76Ex4WjSfe07qc5yK2sAJVzy49xK4FYncm9EJcy91Waea8Iz8MRAzirVeQC6o+2hV0Z0L0AKbKIwZMnVMbZQRYhpzV2xNB9/GiZAS4gX4d1ikwoQWqc05Jo2Ri2uHnOtmJ8+6eNVNFKAEfPG3mje94yYSpfh72suYnCKJ3Sk9ptVdmfN1LpcLGGmVtGXqAXHHxxWCzLTuItHEQ6zZSlfHghJqlWOKUYA6FgBlZ7brN1xHrMlMnokTUjkO9RbqCRTCGBj+lMYIEFDrywwIL6pBxGhhazOoi0vT6hHEnE1W5TeFSQHnvfxgdtAu5WT6w+1TX6ofKmUjYN1M6TP6ZM2XJaxPhpdB4xvKeO7R4u/qex+VqV5k3V+M+Srk+wj0qHPKk663IUmdjqIA1eOekAF7i1jIPnLcek5WiAjcWLNYh9x21ZRL5f0llEvGj0PJBbodkn3T0yxkAF7oaDncSsV51Kq6K7Ke7T+1SULRrZE9RRlw3j8G/D2XLwmjneU+Y+OjxrFxTA07s97p4Bpbzpdp+CQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(396003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(6916009)(316002)(82310400005)(41300700001)(54906003)(70586007)(2616005)(7696005)(336012)(36756003)(40480700001)(4326008)(40460700003)(478600001)(186003)(70206006)(2906002)(6666004)(426003)(8936002)(356005)(5660300002)(86362001)(82740400003)(47076005)(1076003)(26005)(8676002)(81166007)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:18:19.7706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31c6cf1a-e055-4a3e-f63d-08da961089ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4552
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

[Why and How]
We are hitting k1/k2 assert when we are using a virtual signal in the
test; as a result, we are failing some automated tests with a false
positive. This commit addresses this issue by ignoring the assert
condition if we use SIGNAL_TYPE_VIRTUAL.

Reviewed-by: Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c | 3 +++
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c   | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
index f4d1b83979fe..588c1c71241f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_hwseq.c
@@ -348,6 +348,9 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_VIRTUAL)
+		return odm_combine_factor;
+
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
 		*k2_div = PIXEL_RATE_DIV_BY_1;
 	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 931dcf3e5ada..c1261cb0e001 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1184,6 +1184,9 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 	two_pix_per_container = optc2_is_two_pixels_per_containter(&stream->timing);
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_VIRTUAL)
+		return odm_combine_factor;
+
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
 		*k2_div = PIXEL_RATE_DIV_BY_1;
 	} else if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal) || dc_is_dvi_signal(pipe_ctx->stream->signal)) {
-- 
2.37.3

