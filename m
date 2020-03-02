Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9189C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09B4222C4
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="FhQZw1BZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09B4222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A80D6E7D3;
	Mon,  2 Mar 2020 16:48:14 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750088.outbound.protection.outlook.com [40.107.75.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BDAB6E7D3
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kp5HhV+Q4wvdu81pQWgHABHQjcfdRWWIi47ZbfVEzKI78llc3SG6K76oUVGaz8hRlaHThBph5aWLjPkrj+2JxTRArUCtrgX4O/M9zuh/qOJLxieKsAb2M56hx4PCi8OVRrAHKu5sSp90Fa/D3/Al1lCUS2YWumQoOhPPP3S74Fz3CvBbozEugY+U1fTGLBhapbb4UFyQbzWD1YyqNEk+VLadFl2HYkNCnViPyW3A2+KmuquXfQx21TBnzuQ3oHop7QyH+c64nosqWzhS1fz11WdLPQr3TlDDxekEeVzzjUNKnwVpEIVScYeU6JkxOQAzYnBC5zm7GVsdZ6z2VUBzyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFkLc7dblSfzDcMS4ago9NhXynUMhZWYmQ2yEjrqO84=;
 b=JRSVg6jMtNC2iB22XtW6BdkIMem8fhtZKXN+W5tKI2jG5hdbBZSew0XyeFxLGFnnIJcJYvKMbw9Fcfbe2Ym1BJCRYLpDV6pz65h1FbB3VlwKpeYgmclRX/JILX9aqGAZsT68J+IAzSzWD+4VQYxPPcKTEL4Q/a5bGmCzTw9cIqz6Llnx8cc68UUphcV19G8xSgGQlYj4nEDbqbaQLnnqotVHpTB9r5Ti3Ut+Jvh5Ij4NrJKlX4yJ24dk++CfFbMuvgQCyq75W4Zuf9SVjFjyjf2sd8Vlg8Ev3hezTwSyc3olQrnmyp0FIbGrg2OeFWj1HL4RWiJXuNSZpTQJbC56Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFkLc7dblSfzDcMS4ago9NhXynUMhZWYmQ2yEjrqO84=;
 b=FhQZw1BZ4f65x8o/EDU8I7zDMu7SPKm4Boe7ZyMOIz790blIS1rAlLaMNBR6CfaPn5hQUy/fHR7tLogfoUMb/TaAOagB9d9b0Lxnpeb9zB6tbVbyBGYED65mXive+WBXYrZYwyj7TQ/0+wHWyQXfsUqlx+fyzMAw2buOHyy5eGw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:48:12 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:12 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 22/22] drm/amd/display: set lttpr mode before link settings
Date: Mon,  2 Mar 2020 11:47:36 -0500
Message-Id: <20200302164736.89429-23-Rodrigo.Siqueira@amd.com>
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
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:48:10 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3f228df8-6173-4bb6-1f69-08d7bec97e5e
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24113758DB785CF8BAC2DB5E98E70@MW2PR12MB2411.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
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
X-Microsoft-Antispam-Message-Info: h8KQGWxnHI3Oq9jnzoixep2+FmWwJpM8jU2Gu0ccKT45qVI6kSUcLnx/DeyrTrQ9LoffNL6pvtnkSF9dOSMIeOKJRc7OelcZ5mAb95Py0EOiCZR9brPayGd1pAxdz9d8KTazr8PRxi2OAOl5rPSI2eiijOe/iRA2H/kZLCjSU4T0xmIM21qik+V8aZr/py+1B3Z9ytL7nFxo1SbW3Bs9cUmnDOTEgkrAqJ52NtKPI/i4uksb50oQQqaZf3Auqe6BAZuXN8p99MewhXOijRwJDPBGq7nh6RNJTwsXInWJwdLHBiLfF7mlwzMRM3hmBcBoq68JizKdNyJ9auNP0oF733OFao7CSKwSn7LiTjgbdBF/cu8GIXY7/7mywwZ0V1Fbonh+cUhwp1l5nQ9fRFrsN6LWe+UqaXW5+kVdVTk1XlufBfmmJXaiwuqW2I+qGg8N
X-MS-Exchange-AntiSpam-MessageData: 8BG9YKkK4aYPuuA9GrUAmofrDyEoj2tG9JfDFeJ96zZgsYG1/rvfWc/r5+PbfCmxwx4XacS63LDxkR10aSR7YvFwqahfRUIj9GCfrJomxH2xcncfp+LSqn7QQKSGqhovOTzFpeb1sXA76VymOIwfXA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f228df8-6173-4bb6-1f69-08d7bec97e5e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:11.6724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: avzJspNsG+M9sycNJb7k/znz4UFf+++E/qucnMvIAxbNssv3xDm8IJ5gYy8f2tmePy6xSwCkv0UwlL+Ftr+nxw==
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
Cc: Sunpeng.Li@amd.com, Harry.Wentland@amd.com, Rodrigo.Siqueira@amd.com,
 Wenjing Liu <Wenjing.Liu@amd.com>, abdoulaye berthe <abdoulaye.berthe@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: abdoulaye berthe <abdoulaye.berthe@amd.com>

[Why]
Some lttpr devices do not work properly when lttpr mode is configured
after link settings.

[How]
Move lttpr configuration before lane settings.

Signed-off-by: abdoulaye berthe <abdoulaye.berthe@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index bf5406eaf7b7..fc3664dd5e88 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1446,6 +1446,10 @@ enum link_training_result dc_link_dp_perform_link_training(
 			&link->preferred_training_settings,
 			&lt_settings);
 
+	/* Configure lttpr mode */
+	if (!link->is_lttpr_mode_transparent)
+		configure_lttpr_mode(link);
+
 	if (link->ctx->dc->work_arounds.lt_early_cr_pattern)
 		start_clock_recovery_pattern_early(link, &lt_settings, DPRX);
 
@@ -1460,8 +1464,6 @@ enum link_training_result dc_link_dp_perform_link_training(
 	dp_set_fec_ready(link, fec_enable);
 
 	if (!link->is_lttpr_mode_transparent) {
-		/* Configure lttpr mode */
-		configure_lttpr_mode(link);
 
 		/* 2. perform link training (set link training done
 		 *  to false is done as well)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
