Return-Path: <SRS0=l6GN=4A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60C7AC2BA83
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 14:39:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CEB920724
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2020 14:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ReyjZWxS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CEB920724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8DB96F50B;
	Wed, 12 Feb 2020 14:39:40 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690087.outbound.protection.outlook.com [40.107.69.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 864096EAB6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2020 14:39:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gi3ZrjwCBWhuCbjgHiKeuQBSvDkey5m5A5pIvIbwpk7VVgIGBePfC6vtrO2lAxkEj9w3vHPCWIPKoYi39WhLunX9jQj0ycO9jIuq4bgBUoCVep24RYDBDaBjA38pVGqY2fpfvkAQgRfpdrovXTpbblLWY1BXi4uqvxq+jRuDSm6lpK06GQ2peroxqiF1jrzJgQz5kYrKSOR7HFGzVHZrqeqRaumduvqydYEOnsDcitj23vEcTqU0NbGojaIx9TjSPhJB498B7WUcLLD229Er5THXqnBW5iEss8MhEFOfQY4K17jTschpd80ort+CbXTZiD2xj2lH58rv92hmQHbZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBySE8trXuVDcRqpEpbqwOPcuUgilx7I2UqWLhZEFcA=;
 b=Lr7bsPf/W0eM+xjXuflkKFuKneo6mmVDVJaQJ+WNURmiNUvIezvlMhBURDz6lrKcvriO2eegJ9wvFSZR+3BUdph8kcbwjfiVPUFjTxXimQcwYLFAmCebwlsrbGQzsppYk5akSw9F7yzYNHRgo4r7mRDdcfxyB3ITLT7/MqF1IqwbPYwJEn0CquYlvXxSIGoblL6dckXq5rwMbJCBEMRTPpAzdvVVcKfmJLAvAY/cRnJpMOhTL7yV0ces8pR8E+BLWfESCxPqAfzxT/rvtBFI5tK/UeZsgzQlZEYvvgjLwnGmf6doxDArYuBX+6Ii98gUyRDqgPopw7yyDaj7zbTdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBySE8trXuVDcRqpEpbqwOPcuUgilx7I2UqWLhZEFcA=;
 b=ReyjZWxSqLT5cWqJDf2eZ0XEYEp1TJtORwAV3r2V+8pYGxjv1gLPk/SAYQZO52cU95DKGv/kRWT3PMUAP0AHxFuQFP/jDadf1kpIL5EVt4fyc+NyD0pvB6QNWSeucoQeO8o/2tw5t+BgbKNIn44hzROpqDKRH7TM3KGWPB82ey8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Kent.Russell@amd.com; 
Received: from BN6PR12MB1316.namprd12.prod.outlook.com (10.168.227.7) by
 BN6PR12MB1570.namprd12.prod.outlook.com (10.172.18.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Wed, 12 Feb 2020 14:39:38 +0000
Received: from BN6PR12MB1316.namprd12.prod.outlook.com
 ([fe80::9ca:8201:570:9323]) by BN6PR12MB1316.namprd12.prod.outlook.com
 ([fe80::9ca:8201:570:9323%8]) with mapi id 15.20.2729.021; Wed, 12 Feb 2020
 14:39:38 +0000
From: Kent Russell <kent.russell@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/powerplay: Ratelimit PP_ASSERT warnings
Date: Wed, 12 Feb 2020 09:39:28 -0500
Message-Id: <20200212143928.6308-1-kent.russell@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTXPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::45) To BN6PR12MB1316.namprd12.prod.outlook.com
 (2603:10b6:404:1c::7)
MIME-Version: 1.0
Received: from krussell.amd.com (165.204.55.251) by
 YTXPR0101CA0068.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::45) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.23 via Frontend
 Transport; Wed, 12 Feb 2020 14:39:37 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1dd1fd46-d031-4a21-e7ab-08d7afc962f7
X-MS-TrafficTypeDiagnostic: BN6PR12MB1570:|BN6PR12MB1570:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB157022DA82DA8ADD66329F2F851B0@BN6PR12MB1570.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-Forefront-PRVS: 0311124FA9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(376002)(396003)(189003)(199004)(2906002)(6916009)(5660300002)(66946007)(6666004)(6486002)(4326008)(66556008)(66476007)(8936002)(36756003)(81166006)(81156014)(1076003)(16526019)(8676002)(186003)(26005)(7696005)(44832011)(52116002)(956004)(86362001)(2616005)(316002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BN6PR12MB1570;
 H:BN6PR12MB1316.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y9d3IImfzwofUo4KIcIf6a6e95hIBL9SbAmF9tHO7I4EZr4M3SvRUp5mRveWKrNz2UOaSTRUysMrwUdTwbkFa2+6zFlO0Mb/SOUaq1sMn8FnOrIeg/6C5xznsVTh11WJUtmglE0JlfRMnU4Zxqvgji89kNz01DzovGxEEdar+09lWgz+RxEYPVaACB2JNhgFGmp0DGN4We/mLXC9a8VuGF8RwguKcl3WX7BiJ7+hFE6POYExbxtiLPGPXd9c1t7AauAPPgoxnhKx1fzYDj1PxetvPJlowbhzgMssdST0abOPOCDkQevWes4Pjqkvo3dXsesXwnuEgRWP81dnBuw0qWDJxHHqB/F2ooHZlTiRhbMPwGsNsPKEsroahd2x4f7mwg2bCCe+FLbm0xpJcL5RM7+WUkT4Qal1HinW5ZHmbOK/R7OQVVBYZkmfP/oNsB7o
X-MS-Exchange-AntiSpam-MessageData: AqHChqvdCGSuWlBVipnp8VzQt0aGQi67yXwyhWK67dOIYCQwuWc0DVCP6Esd7L/kBwvmcxIFItx9SH6sv1IcsXO7/KUcf+FlyU4FIIPrCqCGs9o/gooPzpFk4P5E52CzuXhLJodJnOZCCfE3wetxFA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd1fd46-d031-4a21-e7ab-08d7afc962f7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2020 14:39:38.3204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoVYBL19CNpQAdQBJhDfojQCGVSvy768D9AI6MIEnLfjWfQdUMZXdCSr03j/v3xq4LOPFaboeNittlklTocjnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1570
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
Cc: Kent Russell <kent.russell@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In certain situations the message could be reported dozens-to-hundreds of
times, based on how often the function is called.
E.g. If MCLK DPM, any calls to get/set MCLK will result in a failure
message, potentially flooding dmesg. Ratelimit the warnings to avoid
this flood.

Change-Id: Ib817fd9227e9ffec8f1ed18c5441cbb135bc413b
Signed-off-by: Kent Russell <kent.russell@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/pp_debug.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
index 822cd8b5bf90..cea65093b6ad 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/pp_debug.h
@@ -37,7 +37,7 @@
 #define PP_ASSERT_WITH_CODE(cond, msg, code)	\
 	do {					\
 		if (!(cond)) {			\
-			pr_warn("%s\n", msg);	\
+			pr_warn_ratelimited("%s\n", msg);	\
 			code;			\
 		}				\
 	} while (0)
@@ -45,7 +45,7 @@
 #define PP_ASSERT(cond, msg)	\
 	do {					\
 		if (!(cond)) {			\
-			pr_warn("%s\n", msg);	\
+			pr_warn_ratelimited("%s\n", msg);	\
 		}				\
 	} while (0)
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
