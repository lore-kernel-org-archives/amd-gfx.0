Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12200C35656
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3052067D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="tdIdblhc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3052067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C9EE6F49B;
	Fri, 21 Feb 2020 16:03:55 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73DD06F49B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx9V+rqnBIQtSCjjsB8Vz16Ly7193xaLWGADvxYpybgpWZ+Zg3C4ubQlNrhEPhRVpehGkvVEXmIxHyiQKAR7B1WHP5HEl94AT4p6KWME2AWC5sEiS/vJdYNNar3gPNW9a30U8Vfjj4Tu4KuOiKCkenSC8ySRgeZC3Hj+RE+jZV8lzbcm+zuq6zs8jLlspKlGzEAVni+EyEMI61HinA4vzxyP4oASTalQb8PF+q5C0WcLs8Zh81UwFzsHUatMOGt/1ro1ifZ9oqEzh0F1Hoaws5HtF1PS2GTR1JYz1xvItq6R6PdpTCHOwVcn6NTDI6sDEd/lzBVduGcFZ2OHzO3bqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw/e35FHJninbxsu6vimKJRM6ozYSLG9AJBXiWEbRCg=;
 b=I+0Ogq87wil8FpC/gqxq0VITPa74SZBEAuUuSq0AnzWq+5Ku1qWvAefjhZ2ku7ZmElahEKbQC0r/UokAoLJZAzLuhHtOEhKpbhYaajRphxZZoXbhBPOZi/GZuyN8Dtyo7TrRrzmruIdDqVjNO7D6uryzJsbch0KI89GtprOktSjUp2EdiFnDDAvSF0MAMRUaFxFn/kvZ1j/MrK8vAU3h3uFOX8GukCAx687qlzTq1Zkm7ttyx+YgbPyM6wIpas0nAJBT0lmIpYkZO/QzAOY6WMVXEaxacQpxjrLfJx8W9a/8/0gc1REnUDH2zHzW21ilXj0CxLvQmrAs3AotJKEqAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jw/e35FHJninbxsu6vimKJRM6ozYSLG9AJBXiWEbRCg=;
 b=tdIdblhcexlA6unbPNjCulodC9lnLgl7aBLKz6Mvmlqa5SOtfsHhyUNZ+XLgS5RJf9vGSmmP56TJ70YP68we+3haEmpF5+mVS/+Pnn50NaGBASBYToo8OWA1Xj0cE+/5I1jg9UxM8/8IideO8t6diBExRo/LEbTZJVhLl+dtN3E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2572.namprd12.prod.outlook.com (2603:10b6:907:6::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:51 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:51 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 06/35] drm/amd/display: Disable PG on NV12
Date: Fri, 21 Feb 2020 11:02:55 -0500
Message-Id: <20200221160324.2969975-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
References: <20200221160324.2969975-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::21) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
Received: from atma2.amd.com (165.204.55.250) by
 YTOPR0101CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend
 Transport; Fri, 21 Feb 2020 16:03:47 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 63074c88-0a6a-456c-01e3-08d7b6e7a2f2
X-MS-TrafficTypeDiagnostic: MW2PR12MB2572:|MW2PR12MB2572:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB257268DF540B7AC19037F99298120@MW2PR12MB2572.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(189003)(199004)(1076003)(5660300002)(36756003)(2906002)(8936002)(86362001)(8676002)(6486002)(81156014)(81166006)(7696005)(52116002)(4326008)(6666004)(316002)(186003)(26005)(6916009)(16526019)(54906003)(2616005)(66476007)(66556008)(66946007)(956004)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2572;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0VO5tDguK1NK+Cniq8r7x0GVfqQt0caR628vUJyxSFDuTcQbcotHZ6MkmJjaLfZWowBcBxgl0ascEaCmjzQTWo26ER0yh/j0nvis/SanFBn4aTFje+7lBb6OktEH3HcWDSVAhSaPpQeNOAqLcNdZy3DzmsYXIQHaXyzFvHYsQAevKTHloimKA24M+tFtFagVvgLCjCd7lZnbUWav4C/RSkkuOgjLGNGyiTWKHpiFuOnzVR5KGdg3NofC5Orijr9zmNlNi1jSZJ8ezH77wg6nNqxWKE80srVP+ilX3rqK9AH5Ob7wIo68LtRKfU9uuNRpH1bRMwGe+c2hVE9v/Kh17nhBQRitLho0CLGXtmnM80qBGXFdwUhGbG6cC1ACFPRNmG5GqZEPEiFDJYw5ebZCkiLYwlQrtWdDzYxCvTuBohryppRsQ97ZAnSHTBZ/NOdG
X-MS-Exchange-AntiSpam-MessageData: VShMj6zMXsnUlqJP/fAjOOnTv331dG2EMEgq2bI7a4AM+vLPb0xXKMvmvGEurDEQxIjsyeK5ZakJ0tPiTJcK6EH5xxFbY3XokAgD4QfpAOrf0Wn5hnE3cQjp0GWPExxs2wO4X/5LUf8Y89Pg1rtYtQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63074c88-0a6a-456c-01e3-08d7b6e7a2f2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:48.5963 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 65hjnh4G2dOFtS0YxhME6NjFGG4Q2BA6z4aPMS7fEeZ5MJ7zOY4r/234eDH+NUifbzxFkXMQV2qLXKJ5HpCpDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2572
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
Cc: Sunpeng.Li@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Rodrigo.Siqueira@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
According to HW team, PG is dropped for NV12, but programming
the registers will still cause power to be consumed, so don't
program for NV12.

[How]
Set function pointer to NULL if NV12

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c    | 7 ++++---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c    | 9 +++++++++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 5f56cc13d6dc..113ff6731902 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1268,7 +1268,8 @@ void dcn10_init_hw(struct dc *dc)
 		}
 
 		//Enable ability to power gate / don't force power on permanently
-		hws->funcs.enable_power_gating_plane(hws, true);
+		if (hws->funcs.enable_power_gating_plane)
+			hws->funcs.enable_power_gating_plane(hws, true);
 
 		return;
 	}
@@ -1378,8 +1379,8 @@ void dcn10_init_hw(struct dc *dc)
 
 		REG_UPDATE(DCFCLK_CNTL, DCFCLK_GATE_DIS, 0);
 	}
-
-	hws->funcs.enable_power_gating_plane(dc->hwseq, true);
+	if (hws->funcs.enable_power_gating_plane)
+		hws->funcs.enable_power_gating_plane(dc->hwseq, true);
 
 	if (dc->clk_mgr->funcs->notify_wm_ranges)
 		dc->clk_mgr->funcs->notify_wm_ranges(dc->clk_mgr);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 1061faccec9c..080d4581a93d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3760,6 +3760,15 @@ static bool dcn20_resource_construct(
 
 	dcn20_hw_sequencer_construct(dc);
 
+	// IF NV12, set PG function pointer to NULL. It's not that
+	// PG isn't supported for NV12, it's that we don't want to
+	// program the registers because that will cause more power
+	// to be consumed. We could have created dcn20_init_hw to get
+	// the same effect by checking ASIC rev, but there was a
+	// request at some point to not check ASIC rev on hw sequencer.
+	if (ASICREV_IS_NAVI12_P(dc->ctx->asic_id.hw_internal_rev))
+		dc->hwseq->funcs.enable_power_gating_plane = NULL;
+
 	dc->caps.max_planes =  pool->base.pipe_count;
 
 	for (i = 0; i < dc->caps.max_planes; ++i)
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
