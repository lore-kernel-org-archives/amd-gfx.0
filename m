Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC9AC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B9A564E45
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 21:45:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B9A564E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0912F6EE7F;
	Thu, 11 Feb 2021 21:45:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AC16EE7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 21:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALBU3FAbele+SVXUSm56sRtTO1wTX0C5kZV/fth35eHdHgBW1LyY80PzE1MuJpxI4bmrnZKjZWJF/IB9qkJB0UXr/wtc4mtMB8bV5P1Y3dKTeAWxzcdt+DexKvTQMoGXqCzn2Py0ILlCYsdcm9+tvqFL3rfSFQLV3dDLQZoZbuwtpSlGVg4+ZEFNG+mSgQ+uqP6A0S/tPjn3O7JM1p6o6sivCarM2eUNsMDhFjhwYelLUyR5Pya9X3LvjQac8P3bnCMIMCETnO1gWiXcTuy6ztsO5qmyCpODHfTE4ek7UQWuwe8ED05mocC6C5wypG6XUFffoDR7jonBeS5GhlL4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU0DzfaMkFUObx/80mXV/aMxymgtvN9YNSxrA9VUzZw=;
 b=JepMw7aJk8U83cgp+UZuXC6wJvdFwfRzyjpkOqO5XJ1Y5MBovGkYciWaUdOoAdSYkJs2pm0jau+lHagACMXvI2RIkLR8dXaIm/S6px0tdnZqoX1Rqrr0VDALf7f4mhKo4Tf1j/GonZMygV1UYDYekLwoWAyW8yIG3W7RYnMf/Zbj+ysDilwPz4Zyngr2p2nW1v7bdkuqKJ78hfIFfD+ssb3bq9Nqa0Zl4gXMzxJ/GIEnJmLr9Zt5V35bBgPvIZrv6eg1Jv1tfuiCuBvu+UuNm64BE/VItDeudHsE6h0BYXwm/SmUyrn+77UuVQTq65Tg4Ijo1Lb7FZU6MLtBUCgBsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OU0DzfaMkFUObx/80mXV/aMxymgtvN9YNSxrA9VUzZw=;
 b=BaM2vcTZ+pZqnTM4oGOXzJznrjwjtZdoYuF6MBigw+7JoMQzJR+0n6gUQSkHzOBvtMu/pCVPWcs3gEsw5Z/B3SWPRkYqOAHUgusyTAKx1g5BMMZ9HJcWVIo53r1QiRddjkCZz0a5I7fFAM0Ro99nO5DfqO8ujuD00WjLUmgr5O0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB3114.namprd12.prod.outlook.com (2603:10b6:5:11e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 11 Feb
 2021 21:45:12 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::bcb5:dc9f:c49c:9faf%2]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 21:45:12 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/14] drm/amd/display: [FW Promotion] Release 0.0.52
Date: Thu, 11 Feb 2021 16:44:43 -0500
Message-Id: <20210211214444.8348-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210211214444.8348-1-qingqing.zhuo@amd.com>
References: <20210211214444.8348-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.17 via Frontend Transport; Thu, 11 Feb 2021 21:45:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 666f1213-1e01-406f-799d-08d8ced64f24
X-MS-TrafficTypeDiagnostic: DM6PR12MB3114:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3114B2D8001B5B59F890E538FB8C9@DM6PR12MB3114.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aW7IYzIneX2ZBU3ErK1LzXyYHhoROG+idFOBOsSvXc7f2AkBr72B0+afTz2a/TaS1O3cCURbH/xUPXcpElKqlnra1y9hXhn0QwSgIFry+Zp0TnYDrFC5oF8TEtlbb1r2eoDl+LoR5HOwxWD8GyCTdzx3lelcEiBetB+3w/KrmaaWh8LdTUpi5kYtDBXAS50xp6Ql1aj88GMYtvXLe+qw7tTNww0KIHgkoRw2148uUhTXluMWOypghCVpgJHn6xkY9Z1N//qvcl4tMq7lyNIYq4Ni3YMS4obEEyhUzsyqg2Lt2ZpTPMXZ7hyAxUx3a+jRKTlNKhzt7Wm5UtGOe7X2lolZ/G2eP3js7lgqcMzY8Mi91/xawcTmBU+j+WQPDhJQh+q0cPH1eJoiwhTFEnqgyHhQQd9UtyDvRiV76MvbIC507ex7EM9H1sfThgjYsVYTxUJ74oAXDcpsyNtNegusSbs3LqiCgd4VSpAZcttEOr2YjROWoxBueCA4woAkGWWxsL1SdCDnu8XBng8WjaWt3Viq3SORccLYMvUQRRIcdjPRxCh5FT41wpF6TiyTtwGWjPEG5TdjZMk5VQNTpV0GXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(83380400001)(36756003)(26005)(16526019)(186003)(6506007)(6666004)(2906002)(69590400011)(66946007)(44832011)(2616005)(8936002)(6486002)(1076003)(66556008)(66476007)(316002)(4326008)(6512007)(956004)(5660300002)(86362001)(8676002)(478600001)(6916009)(52116002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6Rdy6xzeNkCUixA7xMgQSjNqc6tp5fjXysaxVwE+d1cknpD80F3DnrKUNsB/?=
 =?us-ascii?Q?qAKVZz/nYyVuLaQpYOmyY5E25sI0228VSEj0oVYe+1Cu7mqCO/lOlLpFsC8z?=
 =?us-ascii?Q?xlB1+03jJw3b30b5buQLD3HMMrA3NNneWDXyvFFbuSh0SEG5kqweqWFZEnSe?=
 =?us-ascii?Q?bxZqwjIwBheoh+8G1bWm+3xer3/414s6HQoS4kOaaEESA38GSMiwG6ZoapVi?=
 =?us-ascii?Q?SEgcZProlkd6He3T3Zn526v9JcN5t/8vl/Li/sZGI8B0jUP0OALfLCP3k9lX?=
 =?us-ascii?Q?B3zr/pf9f8acU8YUXNqVfyYfL1cM/WwTfTV1XuPzHt67a1CJ+SWAJnamoULI?=
 =?us-ascii?Q?3sv1H2fa8u97t+ZT6pkVzibowKGL5VkbVEuIT3cznEcBGJcGNKo5bE3N0viX?=
 =?us-ascii?Q?PsuNzgtXAvYOa+ABXMjFeD5mIR0zpeuV4sZl+G3R+Z8wC7Dup6is0T/r6tou?=
 =?us-ascii?Q?Hc5iwm+LLbijz7lm+NYOIcqIOI4AtmNsEJeKVIbO5A+oWpnQdoQ+DoZeP/gD?=
 =?us-ascii?Q?+Zurah5l+T19dsg0Ix/ii9x+tlEsZFjLnt4H7weEAnJR4P5s1S3VEWTRirJI?=
 =?us-ascii?Q?Fu32qbKzHPdpsPMjBPrkgJOiWaTNnK0mWFMvmPPt4qDfNg55dAnAMVXVD3T2?=
 =?us-ascii?Q?/Q5rbBAfVHsY5tm7ZK065bm9b0iTtsK7MvIJFfYZHiTJkxGhFIRFKKn2VXg5?=
 =?us-ascii?Q?PeLPihRnClVTh9Xnc1qbnwlMx7yYbvuSMKaNA/gkYZCA39WISbnChw1IrWPX?=
 =?us-ascii?Q?SDxxw1FfYR5epDetm7p6F72sl/FqPnUHSuiIUgCzDramLq42E+e/Tp8NS/Iv?=
 =?us-ascii?Q?wzyAjMDsm7L5VlP4pdOPIqpjnc/cGB952CTMhE+on4gwIsA9+2LnxUdAFngz?=
 =?us-ascii?Q?DvNoD59G8k4nopuj6kZEsBTNSsoXSaeOZcL6rWHc1hfgDfWsO1URVx0+EqBz?=
 =?us-ascii?Q?9zkd+I27pYZNgb0nqjJ193f+kmsJjepw3v1gTCqpr9/1i93PN7A4/Z2unhfA?=
 =?us-ascii?Q?QEcXoEpLziqcg4To531PDRqP00ghyPvHMfmyur9nx1drckATbSjxlwGUAgve?=
 =?us-ascii?Q?d+ryEvcr2bSteB9MB08fi+lCXuDeqbULMxbd45/Izzey1Zrsbf16rSO7YHrw?=
 =?us-ascii?Q?mA/xCt11kXe51r8lSGu/W9uWBkf4Tcz86WoWtxRrGiswsLC5jc27Du5XQAcL?=
 =?us-ascii?Q?Ebv+L32x5/ucY02U3H0C2KJ9fFv5uXpl/axJOrsgCKA5xMFbD7MMLo1kFYc+?=
 =?us-ascii?Q?oFYQOKwyt8WTyleplMT2Nkj9rnuVnfjoXIYaxGXiqcuoBNXq+mnT3Pa9JqrP?=
 =?us-ascii?Q?GQ/pchR2T62PCndTeglXrVZy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 666f1213-1e01-406f-799d-08d8ced64f24
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 21:45:12.1057 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HIqEw66DJ4P1QwaXDfIrKUH+xz6mGMbKT2qi9kz8OmLUBiwKvKO9IQ41/iDKlrps
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3114
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
Cc: Anthony Koo <Anthony.Koo@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[How]
Add new aux cmd fields for acquire and release

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 072b4e7e624b..85d6a4849d3a 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -47,10 +47,10 @@
 
 /* Firmware versioning. */
 #ifdef DMUB_EXPOSE_VERSION
-#define DMUB_FW_VERSION_GIT_HASH 0x6444c02e7
+#define DMUB_FW_VERSION_GIT_HASH 0xb959929e3
 #define DMUB_FW_VERSION_MAJOR 0
 #define DMUB_FW_VERSION_MINOR 0
-#define DMUB_FW_VERSION_REVISION 51
+#define DMUB_FW_VERSION_REVISION 52
 #define DMUB_FW_VERSION_TEST 0
 #define DMUB_FW_VERSION_VBIOS 0
 #define DMUB_FW_VERSION_HOTFIX 0
@@ -564,9 +564,11 @@ struct aux_transaction_parameters {
 };
 
 struct dmub_cmd_dp_aux_control_data {
-	uint32_t handle;
 	uint8_t instance;
+	uint8_t manual_acq_rel_enable;
 	uint8_t sw_crc_enabled;
+	uint8_t pad;
+	uint16_t handle;
 	uint16_t timeout;
 	enum aux_channel_type type;
 	struct aux_transaction_parameters dpaux;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
