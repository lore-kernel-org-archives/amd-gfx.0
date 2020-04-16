Return-Path: <SRS0=B7jy=6A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76304C2BA2B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4701021841
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2020 23:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B9q5vy9I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4701021841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AAE56E35D;
	Thu, 16 Apr 2020 23:41:58 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 007F76E365
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2020 23:41:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JMXk5kSKXTPQqXFL36WNXPgyXdwOhIoDgP0haUkbRlWzX4v9GOX0DHoyNwcbjnqrdEHNzh2Gx1yipsZsG2iYtFTVZWU2fhKxefd83DPDl4xWGPeeoDDviIa7scH0Fp/qYqCaCxp1juJLglB4T1Bqa495/qWEc6biZXt55JQuq3ofGU1ADEuVFtQJY/xGHgg30ZwNnaL6EF2oIxSLIQfx9udvUCU0PKuZpaXqnkXlfSziOobfxcc877JbihP24dIO6O/MpQ/97FVgXboG5t8oBFInCcr8Fjb2A9+bx8vMwDtw/odWYTVcwvuam8NbrAshmAM+RHa1EH39qk1KLFC2xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SveugjNRxUBvN/5pqcC4rI21xRXEuTnVpSfkFdzvnsA=;
 b=OJRE6T8qdLGQr7h8E+8SPRVu4maM/dIdz3cCyZfv2zSL0OCkEMMg3sI8CbkLBPvT7NGL/ayJYbmIL7S9w3IG+usB0arLF+puIry5+m1z74g/jKEusKrADOvsRWDnZr5uxGp/pzVLDCffyWl+IZqdoqjwS9lnv2TC0qjEshmGk1qrpSoIZkrjczJFG7Fr92RL9oSm4mrFskzQnI90Ds6KhLgn0MRhKpebem1gA9JxF1iAHBbk3mBa4euXjOsv0tLsrJoVUxmRWLaQD+3VxJZQYGQ/07ZnSV2EZcTnq9E1726nsahTzUaGnaH/J696omefqJ93bMTuCUv4+8YXlrGYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SveugjNRxUBvN/5pqcC4rI21xRXEuTnVpSfkFdzvnsA=;
 b=B9q5vy9I75fO9UdW91d5Syj26sWCRmjO5I510Wo8D0Mab/vcW7bccjq9OC5CfS4JYKNoloM+MyTdg6MxB73+CJbF+bTs7XB4CRibpgvssDUOovKNhAbduPLNU6ZUhuLFjfIey2vFAisjrdEIfKuRPDdJi8zQzWE7XGBotisoqjw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2459.namprd12.prod.outlook.com (2603:10b6:907:c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Thu, 16 Apr
 2020 23:41:55 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2921.027; Thu, 16 Apr 2020
 23:41:55 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 32/35] drm/amd/display: blank dp stream before re-train the
 link
Date: Thu, 16 Apr 2020 19:40:41 -0400
Message-Id: <20200416234044.2082886-33-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
References: <20200416234044.2082886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: BN8PR12CA0012.namprd12.prod.outlook.com
 (2603:10b6:408:60::25) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56a0:11a1::2) by
 BN8PR12CA0012.namprd12.prod.outlook.com (2603:10b6:408:60::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.25 via Frontend Transport; Thu, 16 Apr 2020 23:41:53 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [2607:fea8:56a0:11a1::2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c287b942-f430-44ac-7f8a-08d7e25fbec7
X-MS-TrafficTypeDiagnostic: MW2PR12MB2459:|MW2PR12MB2459:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB245940F9FFE799AB4E40CDDC98D80@MW2PR12MB2459.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-Forefront-PRVS: 0375972289
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR12MB2524.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(316002)(2906002)(54906003)(36756003)(6916009)(6486002)(1076003)(478600001)(6666004)(86362001)(81156014)(8676002)(8936002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(16526019)(186003)(6506007)(4326008)(52116002);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9CSYFuKF15lRKbIDF6dxA1fjmxWEGMDo1AKiZikSFuNj+JY+/5FXIGeMnnnHtMHZbC/1VKqGJNBtcSQbZYH06JnfFT+ystYaElSNC0T5y6Mw+XfBJh+Qb+uTiWDTWfuYrUyflAJLsp6RIC3kXGOVvQwAPOiMLnVXFDDFy+o6jB34cZZXd17iNL7CRTcIygeZswoJN3KQYyo3t16ZzH84UtrYlLyp7JF1Fb1rreuf/s21h5bGe55S1nx2a9EmMXN5kUWf2yYG7g/c0w7L38m4dJkcPUuULPf4pYxL+GpipBVVZ/m45HZYrOgxeHtyNwHukALeUyOQudm8/2ax+7w6Hel5BsxOqymTZZVMpWz+A3vdEBB3CzvZgK3Th/FRUnHFPSgZmNtrGl3PjWtLiUzVKCgW4fq0wMUS8DPimogkVCSqyb/W0jtSYCh1g6bVuVcN
X-MS-Exchange-AntiSpam-MessageData: TJWUnwncFGwMAiTyAK4f1DPDg6pMTkgZzbP5JfeoMsPm9p3lrfyhOVdLhcHiQ+HO/Xq6e7BR1F/aPUeXZ7IgM29BB/fgFMdw7wYp+5ly+IS7sveVerxI7xviLFVeTJe89wvrrytbw12D8DhkLSjhSveMA4KHpJaYtgONUnYnCaE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c287b942-f430-44ac-7f8a-08d7e25fbec7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2020 23:41:54.9268 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tlkoD4HO5s9Gq5YBSCRf32iFBx7KDtkvshX4pKe5C82aDBAvGrkKm3VqG4r4LrIqv9r104aQJcNuxWATtIpiXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2459
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Xiaodong Yan <Xiaodong.Yan@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaodong Yan <Xiaodong.Yan@amd.com>

[Why]
When link loss happened, monitor can not light up if only re-train the
link.

[How]
Blank all the DP streams on this link before re-train the link, and then
unblank the stream

Signed-off-by: Xiaodong Yan <Xiaodong.Yan@amd.com>
Reviewed-by: Tony Cheng <Tony.Cheng@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 5d2ae2fb7e45..a87302f729c7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2899,6 +2899,12 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 					sizeof(hpd_irq_dpcd_data),
 					"Status: ");
 
+		for (i = 0; i < MAX_PIPES; i++) {
+			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link)
+				link->dc->hwss.blank_stream(pipe_ctx);
+		}
+
 		for (i = 0; i < MAX_PIPES; i++) {
 			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
 			if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link)
@@ -2918,6 +2924,12 @@ bool dc_link_handle_hpd_rx_irq(struct dc_link *link, union hpd_irq_data *out_hpd
 		if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
 			dc_link_reallocate_mst_payload(link);
 
+		for (i = 0; i < MAX_PIPES; i++) {
+			pipe_ctx = &link->dc->current_state->res_ctx.pipe_ctx[i];
+			if (pipe_ctx && pipe_ctx->stream && pipe_ctx->stream->link == link)
+				link->dc->hwss.unblank_stream(pipe_ctx, &previous_link_settings);
+		}
+
 		status = false;
 		if (out_link_loss)
 			*out_link_loss = true;
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
