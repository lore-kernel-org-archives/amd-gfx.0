Return-Path: <SRS0=ZeSq=BX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE27C433EA
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC64720768
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2020 21:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qOpS2HV/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC64720768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAABD6EA20;
	Thu, 13 Aug 2020 21:35:40 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2080.outbound.protection.outlook.com [40.107.92.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3248D6E261
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7EBQ45Q+PE9b99btCaQn8jLBNS7AQDmAjZ4CzWneEbnfqEDXux35hzicfYoTToxKWdEMwHQ60wozzFhXsV0o5nRNNtqqjlbxGOHYOnj6eabe5xTGyfvH252t4aBeSJ6kZrPMkMELo6mjt4LiOG4XUoGwQkc81Q17MV3yEf5Jrt/FnvGwCFkX8fNLAc/rbtvdD4xJ2OimM+uIdlxud3r2fSLijzEy3XJji0u2qihttZdOjfT95o0bzUkdkbQaEZynRZYlhRiyOtiucxmKsfY+8tR8+i0xH3MCELKVmXiCejyCqbaCCKJF34NkvCdgIkS2knl8BEmLALVbN4n78Qavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsW30lCA4W8E3TQ0YaoKP5hjdhafH8Wcf+mF1klQ1gE=;
 b=Z52kQMrYwR8mbCBl2G3cq5QS8pDYWx06FChy+xGya///cluVkYOxmJHahVSURxCmwVVGEcEWGJ1Uj4C3Y98LvdfMRhv9irl9bVtbTMmYTGBNtHKNtGXRmRwAXrvuxIPFWA4d7ylTYjkh1jkH3zJmsMidBRvce0pIwHDvQx0kXdXnA/qF4smpSL0c0uz/urEqaWGhpvK8n4j9KPSLJv/P//u0Ar1rZd2CESSMRmvoxu1qSdZ/ejPspt5UMcpMQJi3GyVylJ4RAmpKGWjzWfEcryjnHh9JGw6r8bjuBTr7KaX/9eU/V1ASfDTKhrXj/hYnKdihLXX6gJn9/uK+2zYKfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZsW30lCA4W8E3TQ0YaoKP5hjdhafH8Wcf+mF1klQ1gE=;
 b=qOpS2HV/RSAPDqC0zVCB5boCfo63MjjO5/l1CUGYlk6f9TuDQ0YDXatGKpNacB6sa5kSvmxnXJaDDFrIFvAP3ujQDDZocpCVRAj7DEB6Z9FXN1khGdGzMUj7BJezEry7cB7Er8vvpT1kFEAhINlEKVuCzJZEWKzfYwIkWQPtpHk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20)
 by DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.19; Thu, 13 Aug 2020 21:35:36 +0000
Received: from DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7]) by DM6PR12MB4124.namprd12.prod.outlook.com
 ([fe80::75f2:ebaa:bca6:3db7%9]) with mapi id 15.20.3283.016; Thu, 13 Aug 2020
 21:35:36 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/17] drm/amd/display: [FW Promotion] Release 0.0.29
Date: Thu, 13 Aug 2020 17:33:56 -0400
Message-Id: <20200813213356.1606886-18-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
References: <20200813213356.1606886-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::18) To DM6PR12MB4124.namprd12.prod.outlook.com
 (2603:10b6:5:221::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from atma2.hitronhub.home (2607:fea8:56e0:6d60::2db6) by
 YTBPR01CA0005.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Thu, 13 Aug 2020 21:35:36 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [2607:fea8:56e0:6d60::2db6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9b8e31a4-dff3-47a1-1132-08d83fd0d104
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13550AE43780E34259799DFA98430@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bNmvsIzdORqVUieLykpyksSl3pnBK9exCz6jBnaeG7qwItLgHjVg26Vxgf6VSBs6WIqOgUinr7smAk+0of5aRnVZppwfdh21dwL0a51MeES34WZ9rTUsaBLwCXRKmISrgNx+gUC51MpQSzxIV9Ps2iasGv4YUb4iMhV/AV/vO+Gplub7+gXO5rLahYMypDL3/tydqV2LbeKp1u5ro/QJNEAIJ6laLl2QkZ7S84lCHEV1/rw+jCIh4tGyP0b77HO0vuIWFrhgqG42AxhzzLupSnqtSgHauT/waUECtuIcjZGpWzenmzQj1FXHPCIwuamxD3usb5ZwxkCeiwZ8tQ6VHA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4124.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(346002)(376002)(396003)(136003)(2616005)(6512007)(83380400001)(6486002)(4326008)(316002)(478600001)(1076003)(6916009)(66476007)(66556008)(36756003)(52116002)(66946007)(2906002)(6506007)(8676002)(6666004)(16526019)(8936002)(5660300002)(186003)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: n7pFlzWZG6kaYBDfYzZZ6dZL+33vK0D5B/BFnibzpaCKHc9XKKgpCUu8HoRvKM/8DiyssIjrVtNZSTW+zfaySLK4ManqliP1ub1aoWjjXCMZayPtOtL2uEjhjXgwkdBKWJt1rXNk42G7ziKIEG58kYEMXj/WcKp2Fep+HzY3svKdpnywk9262SHbFha365+Hdd0Uau/+Z4amcKrwbQOX5YzSm4bncxjok6Pa9XDEZ/U3c6by+SmsfIbetRxbt4s6xlOU1fn5PVRIwutnWFLEiOqJqZsDdodDkegHJuQ69gLv5xK9MOAvOmNNmka1GDcu/QFCgD/QtYU6yGK2LQNAASZU89blZ0FsYE9ZYmGbv4BGo9wfx7p6Qt7sQkS1A2PNmA3rL6PRsA8MhxyL38kpBvUy3L4b2+gg6m4TaV5bmnOPepj7C8YMNliG4l15qqQgnBtOGX2X1Eha+9bbOLp0PSwSgJ1I440b3gHdiJJWOSO5P4WaO+JZ9N9Wica+EUVg2fK5qXvRawUCs3msJv51IRqSlDaYecxYi6DkxZ8RCp3Gs4zb48wZEgQJ69JPftNypSvMvS+x7KelqXvJE+tEv/Y0851ymrdHZ4tyhDUhNyxwh4vWYS03ZqHY1RnrqkriObgLsjfHgvxNqr9J2toWqeEyWJgvDYrUUICLPMjfLnQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b8e31a4-dff3-47a1-1132-08d83fd0d104
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2020 21:35:36.7468 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5/0YL+WWvN79iRkdOsLdUv6G7y0wmCSm3hy6uwBdH1Pw4P7DIfU5PQZ9PbqIUwbzmzkYFg0amYlBTptoL1x6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Header Changes]
 - Add command for panel power seq control

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index b58ed6538eab..d7e7f2eda92f 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -36,10 +36,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x3f7e3738b
+#define DMUB_FW_VERSION_GIT_HASH 0x4e5b2f46f
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 28
+#define DMUB_FW_VERSION_REVISION 29
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -213,6 +213,7 @@ enum dmub_cmd_vbios_type {
 	DMUB_CMD__VBIOS_DIG1_TRANSMITTER_CONTROL = 1,
 	DMUB_CMD__VBIOS_SET_PIXEL_CLOCK = 2,
 	DMUB_CMD__VBIOS_ENABLE_DISP_POWER_GATING = 3,
+	DMUB_CMD__VBIOS_LVTMA_CONTROL = 15,
 };
 
 //==============================================================================
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
