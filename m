Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EBCC19437
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1475023B86
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 19:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1475023B86
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4362E6E9C4;
	Tue,  8 Dec 2020 19:29:08 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2077.outbound.protection.outlook.com [40.107.223.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B50AB6E9C4
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 19:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGBxs8N5OFU6AqpiMQFGaF6aNxanpkhtVl9Yq0dnQw77Kimi5ifXD47K1gJ8uAXhINYxEL6+xM2lWzdntL6dHcF0mTUYi0YVl5rl30jhPfPyrQD8EKHbUXOMWVW5lmshLROH5Zcgso1Qo6LuwOt9PDp7kxzV4SHMzS4Ylm0ZYLr86+fplIKcQrqLWtXxKhPOiDk5V+krMYucMHH+y8pBY5Uk5yVMzdUepS2k1fbsNmi3uA/CM6FR2qtko1q702NrpTUoI0LYmZMOXozNMdAejQcaks9joNFhBUZafWMZX38z6I66N4iqoikrahOyQY5pq7lFrqIC7YEqiYvvSvJ8ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGhgSEBLuGNRc2MaNck+nTgsZNN8K6VNEA3kQihZvdo=;
 b=lLUj2KAhZNUEHuejpDkhviu4QtpCpxrtPshy98nv5SPdUEBAtHyDpMoMJa3xdzUSfxe0LslsPQok14Zc7jUfrrc4VgJi4zcbtSH5uOeWA5pr6YvpQlXK/8YsOgVq7kBrbn9uqKePCv4Zp1W6g88PTFFXIMR++AlW4mAM/YGck9BwxaBXwTvjdDbcs8WlETZ1XLztvOrpMl91C0IUnGDY095BAJrWKD0iN/2uub8wy/HhNebrJ5F+yaP/sxvp9f9QyW0TKxwkWgv1v5aFaqwc65Ig1mgfV+mZ9KYMtLeCmdTIhaMPyxkWBF4g1jKHu71L5/KBGAbKDdz+QucuUprfCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jGhgSEBLuGNRc2MaNck+nTgsZNN8K6VNEA3kQihZvdo=;
 b=T4Rp0RDCaZ0k135UQKjKxXdxWucv+141ne9XZL5Aa6i0bXp8NCIuVDm6sWqlVEr1vGb0fFeW6kf57utoLOlZw8Y1lgMvM7u1aKy/qEzLML/4+o+cozq//ipvmCQxoNkbeu7ADNucAMgRvVxpKW9s/XuhtB5BOeJYOqcADgz7yPU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2939.namprd12.prod.outlook.com (2603:10b6:5:18b::24)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 19:29:05 +0000
Received: from DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853]) by DM6PR12MB2939.namprd12.prod.outlook.com
 ([fe80::3893:44ae:a31:6853%6]) with mapi id 15.20.3632.023; Tue, 8 Dec 2020
 19:29:05 +0000
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/13] drm/amd/display: 3.2.116
Date: Tue,  8 Dec 2020 14:28:44 -0500
Message-Id: <20201208192844.23580-14-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201208192844.23580-1-qingqing.zhuo@amd.com>
References: <20201208192844.23580-1-qingqing.zhuo@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::32) To DM6PR12MB2939.namprd12.prod.outlook.com
 (2603:10b6:5:18b::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (165.204.55.250) by
 YT1PR01CA0123.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 19:29:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3c78ef61-0e41-4559-8cc6-08d89baf86e0
X-MS-TrafficTypeDiagnostic: DM6PR12MB4388:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4388B8BCD42CC05D82A47C26FBCD0@DM6PR12MB4388.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:296;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZL/Y+KjIaRlcXhbqNBh/rexKwLuBLchbEEsEcStWLbFxyvIAZQyzTczoK0EPTrDlYKMwkUp2eRuWzk0ocTrI4SdHkWLDHKNrVMACjMvg0koLgf32Pke2uBLvIRXIvyIF1YtbfhxM0HdnDJWu/E+O6hNa104kRQVi3lfFxvpVHXoLgPSV8KISXOhhiqBwrJKw1NZ2eoGgUMrdFeb3YuaXSjRov+t4JeFQwTx/yQRN7YBzSP4Ek1QeXhGnWFoRLSVPFpkQ0kSu1g7+4GQ/ubeJ5WSdRGm7+nehq6c76s0l0dn7763NWuZLa9c8SeiFZImypnjSQj0ilPTdTo8CZiJC/HSeTwrvLOQh0BgPpIsN5tjTt2RHHr2F0ntg/lYZJxHcX4I6l/XEusTfPkNEMTBlX/bZpWcvV/VsBQtKZ+IV89U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(376002)(6666004)(86362001)(83380400001)(34490700003)(6916009)(44832011)(8936002)(956004)(2616005)(186003)(6506007)(36756003)(52116002)(66556008)(26005)(6486002)(5660300002)(16526019)(66946007)(4326008)(2906002)(66476007)(8676002)(1076003)(6512007)(508600001)(4744005)(69590400008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OUJBGxVK334h01g886A2epprjEdsBDlpYe7HMxo1MrYT4QZfny6n4nhxyh2h?=
 =?us-ascii?Q?vLtNfR+z6GQK/1Kd/G/L/WU3Q1RvQ83Lys5LHXURcCs9FQt6nBvZdMu3G4mk?=
 =?us-ascii?Q?naw1JQl6yHH2GaCVvY6GcPS8/q6GGhdua/U08I87e3XnBtwmUsv5Cu03gD4M?=
 =?us-ascii?Q?tFfEJd4hDQ9EIIO+Okxuk4/GHQ5tdC2ZfaZbKmWxNyzAVmPWwMha2zDCrjEU?=
 =?us-ascii?Q?65ze8I5JMpvdxyUI/jnN4kmvIVjs4NTFP/AVBjFWulO1kcClaRYjBr9DnTIA?=
 =?us-ascii?Q?pRYByx8S6NohqW2uuJmWJqt19E24dy7DI1d1PJvd3oO7KhulnJNophaCGwjv?=
 =?us-ascii?Q?NyOhHRBK71PyadpUGpndGtT5jO5idsoL7fEqt5LbLAyP372zX+sJT63+NjhW?=
 =?us-ascii?Q?+WSwv7q/QY+HA6f+MyBSTvnrZ6/fI63xZ+JfeKRvgTnXiQp/CUKWphYMFb24?=
 =?us-ascii?Q?vuLGUYqXpP0wALWeRGwnJV1+I79otKTM7zzjWKWKaUL1ZRrM1LV8yLNsOuAP?=
 =?us-ascii?Q?9n8JRHbpGAgi92OEFG74zs5CrASigiM5I1L9XvzNCopm6Max8/USEXbZXwAL?=
 =?us-ascii?Q?XApPyhg03NguHr42hZwUxFDvMKZhKyOk9AbdcnerSUBtDU+mQm8AT4WWKu61?=
 =?us-ascii?Q?PGVyvfj2OS6TPQNSekwFdVpFBvKdeXldZT8hwT7AVBjzpgrIEmM/W9l+Jy91?=
 =?us-ascii?Q?2DF2liEUhyiXtDfQdpGKqezkiuGGBCSf9+AetpnuhQRO0nSzfLBiTSB+dAAo?=
 =?us-ascii?Q?9+JDfRmIsFvqTgVB4aeZbFyhQ2DCPp3J+gfgoNbCNr+yrkRgpKS+22H82KUW?=
 =?us-ascii?Q?c6oXGIWUBd3RiBrKIHIovNEfMHwE4nZhxJFOEM39VSIJRyx/kvFmKaME7f2J?=
 =?us-ascii?Q?psaHwuNfaUi44HUV90oWnR9PRzo0ojmenkxzhi7VLLAX/Qbi8/IOqCK6ZKa1?=
 =?us-ascii?Q?F05UlFIYmDwEqa+zVGM0j++7aLRi7FLxEyyZTExjTTODSvGAHXiJBmO86W1e?=
 =?us-ascii?Q?3H4i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 19:29:05.2663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c78ef61-0e41-4559-8cc6-08d89baf86e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1IuTdHAJjtPzdX+bWf9540ccIwznmwkDMJXD+VQNYcS4W6JsLBHhOkA0tB/QFJm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b8f1e2d33423..3aedadb34548 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -42,7 +42,7 @@
 #include "inc/hw/dmcu.h"
 #include "dml/display_mode_lib.h"
 
-#define DC_VER "3.2.115"
+#define DC_VER "3.2.116"
 
 #define MAX_SURFACES 3
 #define MAX_PLANES 6
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
