Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DB37C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A063E21D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:47:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="A0KR2QPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A063E21D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43ACF6E5B9;
	Mon,  2 Mar 2020 16:47:54 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750074.outbound.protection.outlook.com [40.107.75.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A2976E5B6
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:47:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSMA3+PQ3N0YX+nz+scy06mMEvKm+1ttpNIc50K5I358ckqzWdJQBPa6VgqZBKahqcJHvQMTHsXAJT8eQHH5ckBJ2bQYfc5h3In5unCAGzFmsf6PzXrJgJXoFyiGpudaOEIJCG5O2W1JXIyOAO9dLBtosEl+WHl2dVGka1LKNVFwofor788sMjamufh/WmwB4W0lQYMQ/ICgcI3hp0SuQQu+A3uAGnpHxYCREt6KTiiJNhgYigJmHY6ybqoZuJKpl5jAaWxTPP4jFik7CSFUwcegt0UpyhNUINmgecvp8h3E7C/wsIJge0PAletxUZpEvuaGCKjCXgBpT/7E0kh/JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Goe1XO0DCg3YO21xfqVktBWFHVDLpUjS9C7X0sUFUGw=;
 b=myFCebG1Xpau+ut1rDz4PRR1bX10o0BGjHyy5z4M4lRIBDhWggfDHXwsBIohS+9uM1sx59pOfWjBAIe5BOR+uzwjB3FthPoZpv23eQ7OxUYpQ61jBnOxgA1zFxxRLLFmxtp1NzYn5dIuqmM7kfEF2MSxpGU7fLZBYqY0TXzFwQLOR1OpDiTX9aKePFfnZMTsR+QTW+iD9039jp3BgjFH/I36UfWj37Q7ZG3o164dM+2GaZ07POvd9QMdtnfAVH1s4Hu9Zb8R5pDp3edYlWFtOfcU0BSlVOh70A8sY24Z98BZcZTpdpqBWP2p7A3hT+fFbX43ZIVBshLBnivE/8/vqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Goe1XO0DCg3YO21xfqVktBWFHVDLpUjS9C7X0sUFUGw=;
 b=A0KR2QPAcMDAAG/l31f2FX8BSsxnfGK/MaHjnFn0aE5acQdtNxE/2IfO87sXEBrs96YJpov2ECqmM7uy59JSQQDs2ktIAI38m94kWfCKSyk2Cc3AbGNGuN6tSNgngrTSPnJNpQma4umYjynzZwGJCecQL6TTaHvtlD6QkKajovw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:47:50 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:47:50 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/22] drm/amd/display: Link training TPS1 workaround add back
 in dpcd
Date: Mon,  2 Mar 2020 11:47:15 -0500
Message-Id: <20200302164736.89429-2-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
References: <20200302164736.89429-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::34) To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.amd.com (165.204.55.250) by
 YTBPR01CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a70f2922-85d8-48c1-6836-08d7bec97192
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2411BE926685DF25853EF00D98E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 033054F29A
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(199004)(189003)(66946007)(6916009)(6666004)(54906003)(8676002)(316002)(4326008)(66556008)(478600001)(36756003)(66476007)(8936002)(2616005)(1076003)(956004)(81156014)(186003)(81166006)(16526019)(86362001)(2906002)(52116002)(7696005)(26005)(6486002)(5660300002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2411;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XtH19L/gwTNlu4UGOmlFX1zFsnq1KYcmF7FpmhVG8tGctGQMCmHkpf8zMn+OqW2x6Lxy2TDO2qIkz0ssX1tkfgcTxYlo/QCnjwe7BxgfxwSTow8zFQHplc9AfEVW7mcgG45Za63p1euB9g0V7+LMEOD7wqNzpp4SOYuNLeUCQUeJYvuceOlH/W25RfLtMLmuCnWlTfg1orMnp+59+z/mgaSFJODpPkcfiXz/U2wNDwGUQgqRiCUdDGWycdFiQOQFknUoahvYQijPiy5HPgWoOVC9VnqEjjBGa2USpOOv5JGgsy2+Kr0iixgwOh3VEDSIxk3ZC9oAoGaffNKBWoYnc2bptOLvVnqGDoYL1wnpblyBg33i1y7YCb+aOL0BO+XTK/ypL/PZMtAvOPcF5KpQ5OL0iTmz1quqKhxIoLN+0S6OxwJOcGcmCgsmjzKh/lVX
X-MS-Exchange-AntiSpam-MessageData: tKJdBoRsqIFAornTCO1V7qvBnKnIe8h0wm2z5lmLJsoWokS07eLNgF/sChfwaIPLvgyLfZG7VQVXxGEP6BYWNU0nNSZuTF0SA+38dWYeMgoWYn7WkOMO3BUL/B+71zpXMN52QZWcAukYRMBe49Z4NA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a70f2922-85d8-48c1-6836-08d7bec97192
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:47:50.2227 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpsN0tt9RMuBX7Ri6mJHlosQwqWkhC8+hQuSOzOKovFQaPVytem6VhWNUFX6WMAWysX6pBEf+A1xTQbvfO0gHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2411
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
Cc: David Galiffi <David.Galiffi@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Martin Leung <martin.leung@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[Why]
Previously implemented early_cr_pattern we mistook dp_hw_link_settings
for a redundant call of dpcd_set_link_settings

[How]
revert the changes to dpcd_set_link_settings calls for this workaround.
Do not need to revert the entire change since it only affects patched
case

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: David Galiffi <David.Galiffi@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 93127bc90f3c..5aa3de9644ea 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1446,11 +1446,11 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&link->preferred_training_settings,
 			&lt_settings);
 
-	/* 1. set link rate, lane count and spread. */
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
 		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
-	else
-		dpcd_set_link_settings(link, &lt_settings);
+
+	/* 1. set link rate, lane count and spread. */
+	dpcd_set_link_settings(link, &lt_settings);
 
 	if (link->preferred_training_settings.fec_enable != NULL)
 		fec_enable = *link->preferred_training_settings.fec_enable;
@@ -1669,11 +1669,11 @@ enum link_training_result dc_link_dp_sync_lt_attempt(
 	dp_set_panel_mode(link, panel_mode);
 
 	/* Attempt to train with given link training settings */
-	/* Set link rate, lane count and spread. */
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
 		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
-	else
-		dpcd_set_link_settings(link, &lt_settings);
+
+	/* Set link rate, lane count and spread. */
+	dpcd_set_link_settings(link, &lt_settings);
 
 	/* 2. perform link training (set link training done
 	 *  to false is done as well)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
