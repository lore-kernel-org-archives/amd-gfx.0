Return-Path: <SRS0=j5hG=ET=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F60C63699
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05C952224D
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Nov 2020 20:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uF7y0T6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05C952224D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A19546E849;
	Fri, 13 Nov 2020 20:58:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2066.outbound.protection.outlook.com [40.107.223.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF8FC6E848
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Nov 2020 20:58:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkCW97GYi41UwkvC733EeH2iOfTJKN2vPlIDfWVymy3g4GkB5jRb2s8qFW83R7d8lCu4mxmQtzRZoaQkRNjYbrB9bN5b31NWNHWT4dWyd3xte24VPzlpqhC0I9s1O/qpZgiaW2uOuIjen9KF6AfTX825RM02bSbnxL9BsyNWFoXXyqo3zFDombHcmWo3MMks3J8bwRtM+/qB0ylWXCxbrniF5i683r9GUaxxOjnUN5tttBppj9xK4U1oCxKgIruJXLc8FxZ43hTWPqKGfeXMADRCjQO15Cjr1lyXRTwNCi+hEVzTgOIKmB7mH9hlGSuYPKdI0tWtRdjITHwlVo/B2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BikHatjTHEpapVx0Pd8Xg+dY5gHaF5nwoHNaVaitD5A=;
 b=CTNRgLnBT28ry6vvk5JFkes6W71oH6ZNtcY3+VmMCGakmVAh0IND3jCWCG/UTT5WiB+qe4uY8fYhcA1//ZmZXWhohYBgbdo0X9jmEhR/KAjwb91foGn1B12dBXJaK9BK/kkDN60i3RV8n9V0DdBDtfQTzFK3rqeyPL4uoDi2VIl1InOCEGYfGiKp3601xr+IwwImCxexYLcKbEHSR6hIsNHRtSXulJT0yzkMyJWFPyNFQrGz20+HAJTX4UHP1u0nbgum+5Js/bFhWPnyhCRN18+K29zI3AqkZlVNp3ghfzjB3y8B9XfhgL/Bewus2Y2lYU13mVMEpVLBncR6IvEuWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BikHatjTHEpapVx0Pd8Xg+dY5gHaF5nwoHNaVaitD5A=;
 b=uF7y0T6lYnrl02R0gwO4qSTYzLh1QobpR3JcLO5O+CGjB+WNBZPbNBMsIXQ98NNg66P2Nb18QezU2UiA01IgvuvOYeHqWdmClp7tXkNi2pEynVW7/V3ulE7pvs/S5PhvMMn5iaueMy+F8f+kCoVZRPJswjDf+pGmLUtPiRvdhZk=
Received: from MW2PR16CA0025.namprd16.prod.outlook.com (2603:10b6:907::38) by
 MWHPR1201MB0061.namprd12.prod.outlook.com (2603:10b6:301:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Fri, 13 Nov
 2020 20:58:13 +0000
Received: from CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::f7) by MW2PR16CA0025.outlook.office365.com
 (2603:10b6:907::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 13 Nov 2020 20:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT047.mail.protection.outlook.com (10.13.174.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3541.22 via Frontend Transport; Fri, 13 Nov 2020 20:58:12 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:12 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 13 Nov
 2020 14:58:11 -0600
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Fri, 13 Nov 2020 14:58:10 -0600
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/17] drm/amd/display: Increase sr enter/exit in rn ddr4
 watermark table
Date: Fri, 13 Nov 2020 15:56:44 -0500
Message-ID: <20201113205645.640981-17-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113205645.640981-1-bindu.r@amd.com>
References: <20201113205645.640981-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29bea60d-f0a6-4ff5-225d-08d88816d5d3
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0061:
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0061A883D77A0D7E9CF23952F5E60@MWHPR1201MB0061.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y5Xi1AKK4xoKos2tMkhNCD+Og/uBFMQCWEH/7Uqc8VG3PhThrMw90+Fg2zLSiIM3Fuv85ibW+r31n/CeOdh8Q6Gr4GWRPeEbEoZdbgWamcOFckDl9xksbZ221To9I7ycjMC1CkCINVAFGS+JsdJnSdnurxDpoT82lqM6zC5bf8A9H+wKHdqpccqkhat7wmWPsip5UZ1HAkZkHttwuSdq8V2XbkrcoPYziI5gvshvQdHLoZX5jUN27P9Dx8jN4nJeyftxm8Px3uSHKt2X8FFvkLuPXMNBX8a5QMEhZc4NTQbx3SITV+C+5UL+blhZTeFXVE88X7IVQYL3YFtxdOjIHJ2KtyaOJ+ut5DVRz2E55xppgOrJ9xIVoYWkxQiykowl2iMMnLMAZyTC3ulhk9f4Pg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(376002)(396003)(346002)(46966005)(81166007)(186003)(6916009)(82740400003)(356005)(26005)(86362001)(70586007)(47076004)(6666004)(5660300002)(1076003)(82310400003)(4326008)(2616005)(8676002)(336012)(36756003)(70206006)(54906003)(478600001)(2906002)(7696005)(426003)(83380400001)(316002)(8936002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2020 20:58:12.9298 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29bea60d-f0a6-4ff5-225d-08d88816d5d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0061
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Aurabindo.Pillai@amd.com, Wyatt Wood <wyatt.wood@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wyatt Wood <wyatt.wood@amd.com>

[Why]
After removing added latency for HostVM by default, DDR4 sr exit
latencies were no longer large enough for some panels and caused
underflow.

[How]
Add 1us to sr enter/exit watermark.

Signed-off-by: Wyatt Wood <wyatt.wood@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index 8d8ee4b9fee1..458dab9e813b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -618,8 +618,8 @@ static struct wm_table ddr4_wm_table = {
 			.wm_inst = WM_A,
 			.wm_type = WM_TYPE_PSTATE_CHG,
 			.pstate_latency_us = 11.72,
-			.sr_exit_time_us = 6.09,
-			.sr_enter_plus_exit_time_us = 7.14,
+			.sr_exit_time_us = 7.09,
+			.sr_enter_plus_exit_time_us = 8.14,
 			.valid = true,
 		},
 		{
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
