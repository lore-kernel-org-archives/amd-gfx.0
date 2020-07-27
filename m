Return-Path: <SRS0=eP35=BG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16157C433EA
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 15:22:20 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4D502053B
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jul 2020 15:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IhnRAsHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4D502053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96FD98994A;
	Mon, 27 Jul 2020 15:22:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BE428994A
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2020 15:22:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ide14hU4Y2AL8Z0+HDq9d+21KxUvBTjsNGBclZ8WKOWN46EPGoY4T+iljtEioEffMp+n0Kg7pXQy+wiFZo7cAUJpymdkgUZUQs3v4c5eND4KDEwFVcEDT24sIhKyGQLgSWrUlC64RV0IRLg1jcpHxa6qnWu+zrV5F3Y7ep2KF9+5ouHCoiSFoCiFLy9QITM51nYKk2u3LQp9ZhnxgzVS3FByqg4T2fRIZENzF7jMEBB2DSTTuDJt7f/XG7r+ZKjVsK5GXwTg4TEVzB9G5vMWRVdqkQZZ2DyKuh/hxRwABOy3LljippDqiOglmQ3e63BoIum1NMq6naaIUR6lD73UCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wufva8RWR+GxAVXMUFa+K+QC1Sgp6p95yHZUlmYK188=;
 b=TMQ2INuC29NjsIXKcBPFIDK6dS+rAH69xpZQl4X3WudxeM63UcE2EvdStTIGmcJPM2sJio0S7fqTNoKpVeShFXlCjszJrbQCDtTNYy+3ft8TqIb719dvzpISmB/12cklL3Yc22k1tIXy9rGrfcw87KRNpNRpZNeYtS0HKKeATLCsvq7oe3Hcpw3brQbv4bLXGuyTXN4mr0VThju8rFKUeWBtP4FKy+BRGaS9h/Ub/pFuOkcozPx1Ti4+7BfDYeAX3iOj8h0unv4i+GflS4y0IKM2gWSGfsuYOzEx6W0LPyV1oj/J4C16nDY2EPoav7afeRhqKemy/bps1ixt4uiX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wufva8RWR+GxAVXMUFa+K+QC1Sgp6p95yHZUlmYK188=;
 b=IhnRAsHbhsMz1FQUMHj/vgUveeE+j/HiPGGef9XkFBcY3dSsER7IWvj9g7MS2Ja+Z8YvzGt3Bxh7JB/ncRBY+IdTXipaXp9J8MiLtsFTknzflefIsVDPpC69EEGtEpdahhamPDNNcmhSKwcryv8ygfNaTi5bixGRcRPmD9K9yNk=
Received: from MWHPR04CA0057.namprd04.prod.outlook.com (2603:10b6:300:6c::19)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Mon, 27 Jul
 2020 15:22:16 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:6c:cafe::37) by MWHPR04CA0057.outlook.office365.com
 (2603:10b6:300:6c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.20 via Frontend
 Transport; Mon, 27 Jul 2020 15:22:16 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Mon, 27 Jul 2020 15:22:15 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 10:22:13 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jul
 2020 10:22:13 -0500
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Mon, 27 Jul 2020 10:22:12 -0500
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <nicholas.kazlauskas@amd.com>, <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: Use proper abm/backlight functions for DCN3
Date: Mon, 27 Jul 2020 11:22:04 -0400
Message-ID: <20200727152204.12523-1-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5af96e63-1ea8-4e58-0a8b-08d83240d7cb
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2985E41893F731A3EF2B71FCF9720@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:366;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q8v3HFSZsEgamuGkLtUJnYZV1CqNPpdW/+9Fiz8Kj8D8/QJcPkhZdP7uTWDyNf5lV/7uV2hanc/FVCnsyod93wPlXSMDJGhxaBcBsF5Eu08NMpbV0DfPCpWjSYSBq+vKQVt8iTxaU5o43BqJwgBcjbacY0Q6woOh/OFCTJ4o/4C7WlHsUFXHlNxpZfB0+u2sPNlrH1XJDBqQJ03PhPbNIOu+f6g5Oo/ZbjZjd2TIKrppt5ajK2SLAq7L0xyQhVNK5ev84Mdbw/YNFQfBkkqC7M6nZGaxr/iiT33h7iTaa1kf/k8TYN/A7Qi2NSnLo5wMzQpxoj2CoVPIGDcA7a0VsUhVCMdqicDQiEBdkgGEwIlZu4KB0zJl8/gR6EkmPpnE/SSGZxsug4Qr4Fi6FLKEcA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966005)(336012)(426003)(2616005)(316002)(54906003)(6666004)(86362001)(36756003)(47076004)(83380400001)(110136005)(82740400003)(81166007)(70586007)(8676002)(82310400002)(5660300002)(478600001)(4326008)(8936002)(356005)(26005)(7696005)(186003)(70206006)(1076003)(2906002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2020 15:22:15.0929 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5af96e63-1ea8-4e58-0a8b-08d83240d7cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
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
Cc: alexander.deucher@amd.com, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use DCN21 functions instead of DCE110

Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 1b354c219d0a..9afee7160490 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -26,6 +26,7 @@
 #include "dce110/dce110_hw_sequencer.h"
 #include "dcn10/dcn10_hw_sequencer.h"
 #include "dcn20/dcn20_hwseq.h"
+#include "dcn21/dcn21_hwseq.h"
 #include "dcn30_hwseq.h"
 
 static const struct hw_sequencer_funcs dcn30_funcs = {
@@ -87,8 +88,8 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
 	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
 	.apply_idle_power_optimizations = dcn30_apply_idle_power_optimizations,
-	.set_backlight_level = dce110_set_backlight_level,
-	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
+	.set_backlight_level = dcn21_set_backlight_level,
+	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
