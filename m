Return-Path: <SRS0=ZiRI=4T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AA5C3F2CD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA33221D56
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2020 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eBLSzMr6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA33221D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 255136E5C8;
	Mon,  2 Mar 2020 16:48:03 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750089.outbound.protection.outlook.com [40.107.75.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFB4A6E5BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2020 16:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPCD/b57vcgHtbTC0NnDWkN5DsYofQTT+jkxMQaoBx0W5dasBXybSxW0hs6/9Sm+o/8KDCzYuOxHCpDHQ2BwGGawzdbb/gBeproNzETRLF2mvH6ihsUJOvEPevXRf4FPgmJ38u492zsf4G5WXD0Ip+74GLa25YypqoQmQnv2Q9frUl6kx00ZkuWllO63yiB/Z1aEWXiOlgJQ+FftQyZI/+gYJjQAbzv0ww5rXl1HU4g60cPvo1G3bcemThTWpWENOWp4qSlIDq1+nH53M9riuphYZnKcqRQOktEmnHIzc8MqtaZKHRvjsygt4PbmWJXI+TqeatWymxziHYu3bsWshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcSNYTAjCs/oQ2N2DkpMMjL2F6HNv5IC7RAea5gsw3g=;
 b=he4cHqlrWf/DHq9yZkXkeXoSx3GwEhIyIW0ZL2pMHxRyB6UoObChHSYX+Rlizp6PMa9IMg1C1R722ti+obj/qWLcav7Un7Rtev+85vBHOaoNXz5vrbwvXXDdrH1GCKIZBWFVrNB+3Gy+tw5ibwQKkPSQ+kgunG/ULMslztvQEFoyPIAiktb7lKDHgBjHVR60oz/cmTiJSRMTJ0ZpmGL06SGOf1yzswjpOjfKfNV1jRSfn+vEF/xoJNJXECEAypjbxNbkDzbb9/X9eRPkI1dS+IuTHKcRpgtQ9kBYtY6XZiH7jyTKMEP0rX0uZznMcfIDJxaZbWFFdPUxA+6uD0OtkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcSNYTAjCs/oQ2N2DkpMMjL2F6HNv5IC7RAea5gsw3g=;
 b=eBLSzMr6hkjmN03Erd+QnVvns/uzTITzx7v28J11S53nRahIke4cM/1bJfm2LY+rde0zHX8Jq7eZBMSTjNYHOVqKCrUeD8HiVpGUTrQb1ToDBorFhNnDADNCEQxI7wwDcp4L74cn9xkdEL31Q9qnBPGCTOgxkJiBbLowrZmnDLY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (2603:10b6:907:9::27)
 by MW2PR12MB2411.namprd12.prod.outlook.com (2603:10b6:907:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.19; Mon, 2 Mar
 2020 16:48:00 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::91a7:e6f7:b17a:bfa5%6]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:48:00 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/22] drm/amd/display: Workaround to do HDCP authentication
 twice on certain displays
Date: Mon,  2 Mar 2020 11:47:25 -0500
Message-Id: <20200302164736.89429-12-Rodrigo.Siqueira@amd.com>
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
 15.20.2772.14 via Frontend Transport; Mon, 2 Mar 2020 16:47:59 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: acd6ac34-27f0-4de7-4abd-08d7bec97795
X-MS-TrafficTypeDiagnostic: MW2PR12MB2411:|MW2PR12MB2411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB241172364B5BEFE988B50BE698E70@MW2PR12MB2411.namprd12.prod.outlook.com>
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
X-Microsoft-Antispam-Message-Info: Sq4KX7LN7iYtG+zxmIn2C9QZO96I2a8kxk1ROZ+Hh8OUruKjLxU5eNSeYJr/afOBl8D+8m6l3/VBQf3XlMeoR4pSmUkEW64IxrRJskWYQUBzejdlyZm3mv2SHBIdoGBTy5AccuBKQJPaunc7i76OotYV7741S2ymDy5NIcfyefGbSdGSpzCoKjhZOGsLE4vUDoCmcvnP6XZUoxPo0XmMcxXHxI4lco3Hgm5BvDzpC64VxzSSgb+88kzdkpMkZV1IVthm6KBudERkieqlDsq5J5GsknLk1EDLSsmQ3M+Q99U4w8nQUvdvk2N8VAk8mGw59DmQAB8xrikIRbyraQ+h+jkWs/7+l1fYwfIN/7TsloOYSya47c9rgOdV6uGPh5uTDcnU+Dg3qoyap/4Cvs7zSnha6o5/+Egcbc95fcAvOtVHZatw+DWoNDJv2lrT7bLY
X-MS-Exchange-AntiSpam-MessageData: ZfV2XeyLIkSAldiV40ZFRh4tzFO/7DNtrf9CwH04HovxwowKjoxM5RwFPnj1iQrH1y+n+vUK62QHz/JbTkZYd+0VWcOTyzDRhOnO5KkFB52vuvB/oZRGfotutNm0TJt1PD+xKd1p4r9dSojj6wKwFg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd6ac34-27f0-4de7-4abd-08d7bec97795
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2020 16:48:00.2859 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xEoF2D7hOTV7CXGb2tSnVK+53WGfo0hXOLNj02C6pnHNcbrRP49ttuFDWdT9zmmgyLYtPHRdjsuNTcuTbxXvg==
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
 Wenjing Liu <Wenjing.Liu@amd.com>, George Shen <george.shen@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: George Shen <george.shen@amd.com>

[Why]
When transitioning from SST to MST, the HDCP repeater in some MST
displays will enter a bad state. The HDCP repeater is recovered after
failing and performing authentication again.

[How]
Add monitor patch to trigger HDCP authentication failure after
encryption is enabled and re-authenticate.

Signed-off-by: George Shen <george.shen@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c | 3 +++
 drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h          | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
index 5bc6706d2af7..f3711914364e 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_transition.c
@@ -230,6 +230,9 @@ enum mod_hdcp_status mod_hdcp_hdcp1_dp_transition(struct mod_hdcp *hdcp,
 				(!conn->is_repeater && is_dp_mst_hdcp(hdcp) && input->stream_encryption_dp != PASS)) {
 			fail_and_restart_in_ms(0, &status, output);
 			break;
+		} else if (conn->hdcp1_retry_count < conn->link.adjust.hdcp1.min_auth_retries_wa) {
+			fail_and_restart_in_ms(0, &status, output);
+			break;
 		}
 		if (conn->is_repeater) {
 			set_watchdog_in_ms(hdcp, 5000, output);
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
index 891bca555e17..bb855ea5d5a3 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_hdcp.h
@@ -157,7 +157,8 @@ struct mod_hdcp_display_adjustment {
 struct mod_hdcp_link_adjustment_hdcp1 {
 	uint8_t disable			: 1;
 	uint8_t postpone_encryption	: 1;
-	uint8_t reserved		: 6;
+	uint8_t min_auth_retries_wa : 1;
+	uint8_t reserved		: 5;
 };
 
 enum mod_hdcp_force_hdcp_type {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
