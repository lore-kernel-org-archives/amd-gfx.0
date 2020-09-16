Return-Path: <SRS0=J3+H=CZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD44C2BB84
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEFA9208E4
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2020 19:42:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="e4ka4V+Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEFA9208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3F596EB0B;
	Wed, 16 Sep 2020 19:42:34 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E0BB6EAD9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2020 19:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWkV19kl5VuZCNjQZP1K7Q01rjxabzohPLalLIV5CSkZz1CEF/u7YjV6Hog70sAD0E+q2Spyv2scOWs1DEzHG0Vma85ifBeXB6Ywsi7oQqUyVcKfSU5CT/5aQvUgsKB9nP4NHpl2xccGLIF7QGTevDpgV5NNVoymQPzB2wtWu0ovCRHkMqDpl9qm7wE+caoUGX3XYrgWsqQXnaCY83ll3OQEVucZZ6t/NxDxhssJ3/PdZRb7G4+Lf9L+WvA0qcW6fD39tDQMTi8GExAq14sYOIAJ8DySfGef0bThOfqSTTPxdaRRItNx29bn0ZZT2enRsP7xC6SJt0RGrlrrmVNLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sdOxQ3hMalXU46lZ1vCqsvbd+T1iTIkR/WMnW5Qq+k=;
 b=MXEF6c/ZLcvEA15HIwxMSQVh8IKnIri5IhjFtGngWRE0pd8WbVWEsFschYxOQU8sIv5JqQllXlICarb2eAuJBRhlE8zSdrX1l/lvyDv5vMwoLzhwnuv8dSTeDdU4AvTqqgBx/x+2MVwd7K1EtdBwNcJys/MX33Vj2LV8K6yMMYdHuBc9wExJhk98k9xnh6oOs79pabkV5Y+YggaGXYBBBuk8e9dPU7s4LkJxrHCnHt8ONJKQWqV2gQE58bXl/LjEkmrFbBj5tyFZ3bXBRaZM2oTVfREW/VoHv4lMbSTZvl02a/OasUBNKuwy5HSA0yMG92uqq4R1X4W/IiPZE3InXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2sdOxQ3hMalXU46lZ1vCqsvbd+T1iTIkR/WMnW5Qq+k=;
 b=e4ka4V+Q9EFcVw/nAqGyDscAOEM38Zo0x4ANupfrEKZkim4Ac5h2ByERIkrDa6o270Sho8dBmx+rTfiU1ttZkNGU80g9hklA4LXmRyU9XzW2lMG0wFvQmWBuhDNB9cuPvbQ9bgoMM9ricSxHDe3KWVbAnq6NCN6++xl8aRrvWcI=
Received: from BN6PR03CA0115.namprd03.prod.outlook.com (2603:10b6:404:10::29)
 by SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.18; Wed, 16 Sep
 2020 19:36:40 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:10:cafe::13) by BN6PR03CA0115.outlook.office365.com
 (2603:10b6:404:10::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 19:36:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3370.16 via Frontend Transport; Wed, 16 Sep 2020 19:36:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:40 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 16 Sep
 2020 14:36:39 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 16 Sep 2020 14:36:39 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/15] drm/amd/display: eDP intermittent black screen during
 PnP
Date: Wed, 16 Sep 2020 15:36:26 -0400
Message-ID: <20200916193635.5169-7-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200916193635.5169-1-qingqing.zhuo@amd.com>
References: <20200916193635.5169-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa639acf-5a3c-42c4-4d92-08d85a77d5b1
X-MS-TrafficTypeDiagnostic: SN6PR12MB4719:
X-Microsoft-Antispam-PRVS: <SN6PR12MB47194D3E9A98161FCF7F0680FB210@SN6PR12MB4719.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x+t2teKAmRnUYQ0yvVM/QiblfZ/ZiGW4RNl34i6GJI9dOakYGfAPyFzzQ3qi/Huu/9T3326YAF0Lfy9n4L8Y3sp0FaApZZ8IdittRcI7hFJi6VlgVYLffAP65WzP0OI4HrsYY+tmARgWXqfBHnqywrslHY9FfmiTCh/4/mtSRop2dqMFH8qvFfHS7iRpOG02WWHE0bnyUqYwCFeLH1EDFhmqIem3R51F9amR+0BCmHzlsiiyA6S0uecN+ox0fUGdnvIfPRWz7fpDlVbyOozIS1PDzVzioEV5QpB0aU1Q0PTegH6NWzQh++coXlATMqGozMzeoagysaLRPlOPRw7zdTDBXM1ld4NmuWMfYRrNsJ5aeLf4Dd6swZtwZhf6fvfaCLfspv5KnnEhICGkd32aTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(46966005)(70206006)(8936002)(6916009)(70586007)(47076004)(86362001)(316002)(5660300002)(478600001)(6666004)(82740400003)(8676002)(82310400003)(186003)(54906003)(2616005)(44832011)(4326008)(336012)(426003)(2906002)(36756003)(81166007)(26005)(1076003)(356005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 19:36:40.5260 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa639acf-5a3c-42c4-4d92-08d85a77d5b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4719
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Peikang Zhang <peikang.zhang@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Peikang Zhang <peikang.zhang@amd.com>

[Why]
We dont's turn off backlight before power off eDP (VDD),
which is a violation of eDP specs.

[How]
Power off eDP backlight before power off eDP

Signed-off-by: Peikang Zhang <peikang.zhang@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c          | 2 ++
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 1 +
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c           | 1 +
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c           | 1 +
 drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c           | 1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c           | 1 +
 6 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 81c026319ccd..dba338c88256 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -229,6 +229,8 @@ void dp_disable_link_phy(struct dc_link *link, enum signal_type signal)
 		dp_receiver_power_ctrl(link, false);
 
 	if (signal == SIGNAL_TYPE_EDP) {
+		if (link->dc->hwss.edp_backlight_control)
+			link->dc->hwss.edp_backlight_control(link, false);
 		link->link_enc->funcs->disable_output(link->link_enc, signal);
 		link->dc->hwss.edp_power_control(link, false);
 	} else {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 1002ce9979dc..27a1262a20f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2890,6 +2890,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.setup_stereo = NULL,
 	.set_avmute = dce110_set_avmute,
 	.wait_for_mpcc_disconnect = dce110_wait_for_mpcc_disconnect,
+	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
 	.set_cursor_position = dce110_set_cursor_position,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index a1d1559bb5d7..b24c8ae8b1ec 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -66,6 +66,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 966e1790b9bf..072193c5ffe6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -68,6 +68,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 2ba880c3943c..2b7396c9fcb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -69,6 +69,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 19daa456e3bf..7c90c2222506 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -69,6 +69,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.get_hw_state = dcn10_get_hw_state,
 	.clear_status_bits = dcn10_clear_status_bits,
 	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.edp_backlight_control = dce110_edp_backlight_control,
 	.edp_power_control = dce110_edp_power_control,
 	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
 	.set_cursor_position = dcn10_set_cursor_position,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
