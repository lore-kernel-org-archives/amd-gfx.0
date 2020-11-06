Return-Path: <SRS0=h6O4=EM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87A5C2D0A3
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 477A4206A5
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2020 23:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S5JjjGvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 477A4206A5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D48976EB4D;
	Fri,  6 Nov 2020 23:19:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2070.outbound.protection.outlook.com [40.107.220.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 408EB6EB4D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2020 23:19:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ms7CVIT38sy19clQnIcxDL5+FbU1i7zNWu5XGebW/A1JDpi92xydHGzq6emUXug1YfsUWIk5COgeucezG+eHSHyaqMCAn8V+yu5LwOuAM2974rWfEM6CzWAFjpWJ9pJS0cb24/3+PxuiWD0tWLr9TYtKRbWjFSkMZsxruVYd/0qBlbGXSer0nwoxEudfNAGVXBUEZG8wN+OFcq7iPnsCY3rhnFQY+BDyYcU6NCO6WH5tdHOOwQa6MHzE2FOaKrfuElfR4R0m3NF3B1+5qwEctFKxe+eww3q3Ekc2smRI4Fl4kVOvV5VUEx/EBpWRBZKpdwa7hNhb7+nCkC4aLHdiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdciEFEJZbJsJoCze6KKY/FngEmM+m/JTvooK9O6WdQ=;
 b=ASoEZKJilJLeQsXbc9UKtSdQBGZhD4ZhmgWLMjEjjYuEcdrL32VjQxnkv6/ezDawDai9MwqUmJDFONJmB2KPZa3nkexqFnM9+V3dQDAjy6F9SRj7EEUDBJG/eL/xKPjGYofaZ63I8OPsBBKTzy3Mlg2ecGcgtOM94V1l3aeUB3IEMDSSKWssBDvWnCVo9gRIwDUuEFVfFxjF9sMlLQHnQD9ztQCfByl0f2ZOuMPt0OMoGvOyzP5CpQPEM9EH5VLyPVRsRP33UFU1RPjCwDOf6b5Q//sKdsQOM97CysMZOVJ4hdPFeoM7thcwG8WW2X/tVaXar7+UKcVfDmzR77Xofw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdciEFEJZbJsJoCze6KKY/FngEmM+m/JTvooK9O6WdQ=;
 b=S5JjjGvwkEnuzkcFXTx0jC7istkCVSBOTk5itZQdbjq7HhjGAdrpUGIN6xmV6DN1GrtyfU+SjyS0bUchk7ldgE6G2/J0w51fMxRCxAsynzZYr6DqorpN/SAcGUoJSxKJYQIhMz9AamHqehTLQ+qi+OVywIPldJyqu54FzvI/pDo=
Received: from BN8PR15CA0059.namprd15.prod.outlook.com (2603:10b6:408:80::36)
 by CY4PR12MB1495.namprd12.prod.outlook.com (2603:10b6:910:e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.29; Fri, 6 Nov
 2020 23:19:12 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::27) by BN8PR15CA0059.outlook.office365.com
 (2603:10b6:408:80::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 23:19:12 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 6 Nov 2020 23:19:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:11 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 6 Nov 2020
 17:19:11 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 6 Nov 2020 17:19:10 -0600
From: Bindu R <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: Add fallback to prefetch mode 1 if 0
 fails
Date: Fri, 6 Nov 2020 18:16:57 -0500
Message-ID: <20201106231710.1290392-2-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201106231710.1290392-1-bindu.r@amd.com>
References: <20201106231710.1290392-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2ddfc2de-8871-476d-b6b1-08d882aa5ecc
X-MS-TrafficTypeDiagnostic: CY4PR12MB1495:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1495A39868683E5A7B887125F5ED0@CY4PR12MB1495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +5tEgzzvpOyxlC1itf2QoXI2VShv4Hnf+js8E2TSh2lZo6C5Z8uqAMxeBkpf/aGY61b+tEXpR2HLohLv7Gi86M5K3ChGcxCvN1Pl79aujfRe4agy6bfQj2D2EHhRIt36FhBWdudz+VpnGLj/DhTUde5YQWAB9fB1bWjtlqb+u1GW8STVZPwBPxDVjBH3qGr5c6ttiBwISvyBf1akEo6apMP+PSVp/pWgA9qRvcS4U+Y4OI6xg3B+ik+pKKB1055cnU23OPuhrEVTLnWbBgRbieXwqmKPpayFUsO3cdVhOji5+V8r7dHEbP3GG3HD8iBqzVuTYyg+Zq1vXtkrBZykBEUYyN5HIChT2r31bN5ElhqPUaHJfeFQgQJIfqVOKXJMUM4J23XEJf2xZqZyWsTnpA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966005)(83380400001)(82740400003)(6666004)(47076004)(6916009)(316002)(336012)(81166007)(356005)(1076003)(478600001)(26005)(426003)(4326008)(8676002)(8936002)(70206006)(2616005)(70586007)(86362001)(82310400003)(36756003)(2906002)(5660300002)(7696005)(186003)(54906003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 23:19:11.9011 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ddfc2de-8871-476d-b6b1-08d882aa5ecc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1495
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
Cc: Isabel Zhang <isabel.zhang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 Bindu Ramamurthy <bindu.r@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
In some cases, prefetch mode 0 is unsupported but prefetch 1 is
supported. Due to previous change always forcing prefetch mode to 0, we
are failing bandwidth validation in cases where we should not.

[How]
By default try prefetch mode 0 but in the case validation fails, attempt
to do prefetch mode 1 to see if it is supported.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../drm/amd/display/dc/dcn21/dcn21_resource.c | 28 +++++++++++++++----
 .../dc/dml/dcn21/display_mode_vba_21.c        |  2 +-
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
index 5ae3419682c8..3d8b0875e905 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_resource.c
@@ -301,9 +301,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_1_soc = {
 	.xfc_bus_transport_time_us = 4,
 	.xfc_xbuf_latency_tolerance_us = 4,
 	.use_urgent_burst_bw = 1,
-	.num_states = 8,
-	.allow_dram_self_refresh_or_dram_clock_change_in_vblank
-			= dm_allow_self_refresh_and_mclk_switch
+	.num_states = 8
 };
 
 #ifndef MAX
@@ -1199,11 +1197,29 @@ static bool dcn21_fast_validate_bw(
 		out = true;
 		goto validate_out;
 	}
-
+	/*
+	 * DML favors voltage over p-state, but we're more interested in
+	 * supporting p-state over voltage. We can't support p-state in
+	 * prefetch mode > 0 so try capping the prefetch mode to start.
+	 */
+	context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
+				dm_allow_self_refresh_and_mclk_switch;
 	vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
 
-	if (vlevel > context->bw_ctx.dml.soc.num_states)
-		goto validate_fail;
+	if (vlevel > context->bw_ctx.dml.soc.num_states) {
+		/*
+		 * If mode is unsupported or there's still no p-state support then
+		 * fall back to favoring voltage.
+		 *
+		 * We don't actually support prefetch mode 2, so require that we
+		 * at least support prefetch mode 1.
+		 */
+		context->bw_ctx.dml.soc.allow_dram_self_refresh_or_dram_clock_change_in_vblank =
+					dm_allow_self_refresh;
+		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+		if (vlevel > context->bw_ctx.dml.soc.num_states)
+			goto validate_fail;
+	}
 
 	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
index 367c82b5ab4c..86ff24dffc3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
@@ -5477,7 +5477,7 @@ static void CalculateWatermarksAndDRAMSpeedChangeSupport(
 		}
 	}
 
-	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0) {
+	if (mode_lib->vba.MinActiveDRAMClockChangeMargin > 0 && PrefetchMode == 0) {
 		*DRAMClockChangeSupport = dm_dram_clock_change_vactive;
 	} else if (((mode_lib->vba.SynchronizedVBlank == true
 			|| mode_lib->vba.TotalNumberOfActiveOTG == 1
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
