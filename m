Return-Path: <SRS0=JmOw=7V=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE27C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 916E920801
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Jun 2020 04:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eJHmnOOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 916E920801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53DAE6E4A1;
	Mon,  8 Jun 2020 04:59:58 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FB716E48D
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2020 04:59:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7bqVDNoCQ7oQt8mc51l4rTAJH0ml+1t7/eFN+ximd3I8yKhR5ZO69AktbDQaKbgH5Gsz6y8a5zAlFOd/0h1dp9//mIapBQj4OQA00NsOTNZiIer4iRaGv79Auq8PcEXU5FH4SDjfLDZ7SGCGLa8A2Kkzj+l1WCX4fP7gY3uwwwp53SNwKNCr+YelPuHFsFVeBHMDoQKdtfOSnVDVxs/dY7DFg90DiqZEd4W/oM2+O0F9CN77MvBcRtjy64UsX5U4/K/3eOsn65drDveHlq0Aj4qazyK3/eT5qjFIdcN1SDG0QWT85S5a9rSu7a8LVU+h8KTYiW9B8HeyGx2FmINhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYs0IeKlgG72YSPkjNgwMMUC3soyI2C0AK2jqE+Datw=;
 b=WARWHGhZIERPnJlSlfwpRfPHTiHGGxSCLv4J1+8bEdcw4LH0+PxRCK4w/JX2NDiYB7Vvwpzzg1rB8gm1M1hZFd2TwAmDHE0ukRZEGqVYZo7rVcV3Ln18yi25cA4WaPVvPSS0RVeD1vLEXNlX8vBerfv8DHx89mZTkoT8p3O83i9TzSSO54m/Gstpqup2Q2Eujfza/dxhIZtz5MSxBkvAjJ2ZDSO4zHwd6nViYACzQKydSJrPwAL1cCGbLjFFHeRMocuxSDpi6Edi/Dn88Wvmj26b9wiWGwUpIsGJkdvZ1syURJBmtYFXoQ5vYN/8kkR+Wo35UrilwQYM5t6EvDnxrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYs0IeKlgG72YSPkjNgwMMUC3soyI2C0AK2jqE+Datw=;
 b=eJHmnOOa+uYBoGuK4LxlABu/siAZWD/Ef0yJZNK/PZsYvbpCxLaG3yuS1DE76bcQkKc7pT6bP90lobicOoAUKAQdhP+51Nzm4Lbli5tdJaKZcJZg2WEPssYfWSDqdOZQiqBmHC7b6tAZd+vRUS56BZAnhFtnVT+Fv819rKlX3Co=
Received: from DM5PR1101CA0024.namprd11.prod.outlook.com (2603:10b6:4:4c::34)
 by CH2PR12MB3799.namprd12.prod.outlook.com (2603:10b6:610:21::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Mon, 8 Jun
 2020 04:59:48 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4c:cafe::5a) by DM5PR1101CA0024.outlook.office365.com
 (2603:10b6:4:4c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend
 Transport; Mon, 8 Jun 2020 04:59:48 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3066.18 via Frontend Transport; Mon, 8 Jun 2020 04:59:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:47 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Sun, 7 Jun 2020
 23:59:47 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Sun, 7 Jun 2020 23:59:46 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 24/28] drm/amd/display: Disable pipe split for modes with
 borders
Date: Mon, 8 Jun 2020 00:59:22 -0400
Message-ID: <20200608045926.17197-25-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200608045926.17197-1-qingqing.zhuo@amd.com>
References: <20200608045926.17197-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(346002)(376002)(396003)(46966005)(36756003)(86362001)(83380400001)(316002)(426003)(336012)(82740400003)(70586007)(1076003)(70206006)(47076004)(6916009)(81166007)(5660300002)(356005)(82310400002)(478600001)(186003)(2616005)(6666004)(8676002)(8936002)(4326008)(2906002)(44832011)(26005)(54906003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9127f966-277e-4ad0-c543-08d80b68c500
X-MS-TrafficTypeDiagnostic: CH2PR12MB3799:
X-Microsoft-Antispam-PRVS: <CH2PR12MB379957713131B8163BAAA9E8FB850@CH2PR12MB3799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 042857DBB5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eBl8dtTKBxesfMqA/eb+C5G5zl59uAYkeoVNFYZtbSGpbV11QVnyxLYZ5Jn/b9xQgtdmShIuspy9jugL3ymGHe6cHhvvploHiKei5hDywLydlwwC5QKk83WcUptMfgj55Hdu7opECvtJRuf2JxU63CTGY00kLZQOPA1wtyXAjTUYQGvBp5FGCd+a0y1gPIa9f8samuU8IrtoIfT3Zwfmkm6pKkzoje1TFLDtacTuXvr13Hza244+BS712jEuCItI9xGYvP++1r1Z+uhFH0zBLAMjPB2bl6ZKUVESwHIpnBQednHsdyU+6Xki/MZpUUA2AMqT+fhA1CdMNhWXvA6y6bgcH5VIs5EpwUQc5QYzedRD/Wb6JBpGJN+YcVlGMOSg1TUqPgfHTeZtSBGlJnACg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2020 04:59:48.0512 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9127f966-277e-4ad0-c543-08d80b68c500
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3799
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Dale Zhao <dale.zhao@amd.com>,
 Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dale Zhao <dale.zhao@amd.com>

[Why]
For some special timing with border, like DMT 640*480 72Hz,
pipe split can't handle well. Thus, it will be black screen
for these special timing.

[How]
Disable pipe split for these timing with borders as W/A.

Signed-off-by: Dale Zhao <dale.zhao@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_resource.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index afa99f967558..fb167393b8fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2666,6 +2666,23 @@ int dcn20_validate_apply_pipe_split_flags(
 	if (plane_count > dc->res_pool->pipe_count / 2)
 		avoid_split = true;
 
+	/* W/A: Mode timing with borders may not work well with pipe split, avoid for this corner case */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct dc_crtc_timing timing;
+
+		if (!pipe->stream)
+			continue;
+		else {
+			timing = pipe->stream->timing;
+			if (timing.h_border_left + timing.h_border_right
+					+ timing.v_border_top + timing.v_border_bottom > 0) {
+				avoid_split = true;
+				break;
+			}
+		}
+	}
+
 	/* Avoid split loop looks for lowest voltage level that allows most unsplit pipes possible */
 	if (avoid_split) {
 		for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
