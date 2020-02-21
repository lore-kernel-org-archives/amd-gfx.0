Return-Path: <SRS0=HRUr=4J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117FEC35657
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D77A1222C4
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2020 16:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NKvJReYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D77A1222C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7297E6F4A2;
	Fri, 21 Feb 2020 16:04:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB82B6F4A1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2020 16:03:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYXc8BZXzbQmIN8UPY2xF25Qhu3VIe7Ox2E8E26sbZX8LRHwSQtQ9iwm7QWI1Kes3Y7dmn6NaLcJFjP/FqdkyPX5Mh2Ua1nznTbvWSl+3+K5UaowVZpL2tjZ3Vd7m4i2ktaS3W09vQ/YppsvWPRvz0tu2N+QY5I4xsXWnBt/tCwcIsuE9Ff5cuCEllIQHCsdxVyI6yrLg7efstPQ+jwWrbVpHZM0RKgGkHbWDblOW5zSEuvPNTEaiTdMRY3vCasEoHQZ1r9euZYo2AwihZVjhagWdb/OK3k/v448wYjMocvNn4nVdGyAX4RANgNyjrAw/d4sCBh7I9N1S9pz35v2eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OI0QAkO1+fB7r08ixdnwV57uYFqUQhfmjVsC9yO/h0=;
 b=cJvUmBvavdL6LZEmuDl9o0kAuoI+6xXNpAZBNVk1TLtuGtTSepa0ONjKV9pLWeY6Eurp6GZTZTPPyOL7yHT33l7Zv4BmSm3YUBTOsVcAuKGYPINh+mSLRbKHI6czi4e23ZHQP0r8PHFAbKSSPjURza5DjsYj+6b+hAHILlkOckEdKuK4JHzOD2t8aEM2XF/gQ2E/R9pgbdhcO0AkPeW54okbKFwTezWN+2V33qw7YluzCYuReJ80lfcqdwPuZ3OEBaD9f/JexV326CC2m93HgWpLPSaG9G1kgWQvokwojyhqAP7eIoL/1wHnlLu/dOtpAhX+Ohv6UWqGpigdwr8AQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7OI0QAkO1+fB7r08ixdnwV57uYFqUQhfmjVsC9yO/h0=;
 b=NKvJReYtOewldsPkIDp21kzWPk9UH5/TaDn2b7qetKtFivbDDugb1BZnNiLTA2NJNAFh0Rsd8qR9OR6D39GOJCKEmmMlRInLfea1o1s+3221n2E0JiV5jPWnkBThDpFc/NlVO8hGBwOFFaAvOpKrqGNgYVZt1H+Av1JnaYOe01Q=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2409.namprd12.prod.outlook.com (2603:10b6:907:9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Fri, 21 Feb
 2020 16:03:58 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::b8ff:6893:5820:420f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 16:03:57 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/35] drm/amd/display: Fix HDMI repeater authentication
Date: Fri, 21 Feb 2020 11:03:03 -0500
Message-Id: <20200221160324.2969975-15-Rodrigo.Siqueira@amd.com>
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
 Transport; Fri, 21 Feb 2020 16:03:56 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3560dae7-d7d1-4a19-b50d-08d7b6e7a7fb
X-MS-TrafficTypeDiagnostic: MW2PR12MB2409:|MW2PR12MB2409:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24093E2540B151534D5E4ED898120@MW2PR12MB2409.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 0320B28BE1
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(376002)(346002)(39860400002)(136003)(396003)(189003)(199004)(16526019)(36756003)(66946007)(66476007)(7696005)(66556008)(6916009)(26005)(52116002)(6486002)(1076003)(5660300002)(6666004)(4326008)(8936002)(81166006)(2906002)(2616005)(956004)(81156014)(54906003)(186003)(316002)(478600001)(8676002)(86362001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2409;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U1jXBx7ofnP5iAsqWLreg5BINMrTK6gljR3b1X1oK2drpSBUI6O67PvhxSGDD30E/VXLfjbSARQ3FFm1TlpeT9b4CMXpHxKD6tm953T98ZUYFv/ieOnMC0UQ3o3P8pU8wI8JGTbhR/xrWhM662TRIsciULFcT4Ln1UTJl1Muw1lp0ZqU/EBINY7Ds0xXLuhSnwIGkmCSX9uA+jWezUdHa/9hoNfNihK4I7hta/YV9N/jzdojrr3Mcczp4OV7ViOwih4kI7NvHABlfd5t4e0UUIK2Ew1+1gZAslZOlqIRHI56zBnRzfEB0h8lHJCHqbSAMxDy0/jRuqoUHcDP/Qd625EA0h80jaMTJ+Lf7LF53jE6v2MJyfQkcAI533Usz/mL4AH29uATUL928sBqLLXY107sFL4S3wnbHpqwaofRbmbJUtbw4NmWIV4L5GsNAXib
X-MS-Exchange-AntiSpam-MessageData: TGszONcJ4cv7itwP3CD2yqr/Z5hWrN3SupiDJUnfErV0iKEvR4qkmHj2YbucKzAeWvCbrP6iReFrZusOfB2YxcEdRif/c4Ssk8S48U9G8Hvpf4PjUBpD5qxElrj/aO0SiZy2HXNjDoI0hmKdgZxmEg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3560dae7-d7d1-4a19-b50d-08d7b6e7a7fb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2020 16:03:56.9815 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8Y0HeCJXV5P3XUcMEMSEyLuRZtehIDs2FoiAxRBCBE1XyPwb2JWyA4YuBbMGHCPlRnBzv30V7CvjU5ai+TCaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2409
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Rodrigo.Siqueira@amd.com,
 Harry Wentland <harry.wentland@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>

when the rxstatus split was done the index was incorrect. This
lead to HDMI repeater authentication failure for HDCP2.X So fix it

Fixes: 302169003733 ("drm/amd/display: split rxstatus for hdmi and dp")
Signed-off-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
index 340df6d406f9..491c00f48026 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp2_execution.c
@@ -34,7 +34,7 @@ static inline enum mod_hdcp_status check_receiver_id_list_ready(struct mod_hdcp
 	if (is_dp_hdcp(hdcp))
 		is_ready = HDCP_2_2_DP_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus_dp) ? 1 : 0;
 	else
-		is_ready = (HDCP_2_2_HDMI_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus[0]) &&
+		is_ready = (HDCP_2_2_HDMI_RXSTATUS_READY(hdcp->auth.msg.hdcp2.rxstatus[1]) &&
 				(HDCP_2_2_HDMI_RXSTATUS_MSG_SZ_HI(hdcp->auth.msg.hdcp2.rxstatus[1]) << 8 |
 						hdcp->auth.msg.hdcp2.rxstatus[0])) ? 1 : 0;
 	return is_ready ? MOD_HDCP_STATUS_SUCCESS :
@@ -67,7 +67,7 @@ static inline enum mod_hdcp_status check_reauthentication_request(
 				MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST :
 				MOD_HDCP_STATUS_SUCCESS;
 	else
-		ret = HDCP_2_2_HDMI_RXSTATUS_REAUTH_REQ(hdcp->auth.msg.hdcp2.rxstatus[0]) ?
+		ret = HDCP_2_2_HDMI_RXSTATUS_REAUTH_REQ(hdcp->auth.msg.hdcp2.rxstatus[1]) ?
 				MOD_HDCP_STATUS_HDCP2_REAUTH_REQUEST :
 				MOD_HDCP_STATUS_SUCCESS;
 	return ret;
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
