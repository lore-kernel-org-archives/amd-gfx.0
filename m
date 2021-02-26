Return-Path: <SRS0=SLyk=H4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4252C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5435264EE4
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Feb 2021 04:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5435264EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D06316E8DC;
	Fri, 26 Feb 2021 04:24:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C2A6E8DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Feb 2021 04:24:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BYtSieVfaFDlZQOwj0ctydKf47ynyV39FXe4NGV5QTYhfJv/EIeU7XYB65dXlJAmDzmOsu2QJng2L70GbkuFk5nJeBCgR1jz970XHEvn0rKbKbturGQSjyh5NbTFrEMQTd7UMvV5r/OcbPrNdeN0mez5NNSUesFTDTWIlnZRl9ftIqNRcbLVCgQd7qXJ6P3dSnL4NKfls8SgLCTIGKH0Pwd7lkyvC7IIDD9I/8sdpTCbfQ58a5s9IRbOkxo9K0lJtMHDZzVFbyEgya5FI4vRtUsbbacd87MYcMYJTflOH1TMjrst2sPOi9QT0kI86UvcGwJz3I6I6C8O9wUcP2mjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUHibzxi+DwnSGrfxyT9+M2ietjIKQUoDhvURvhCuf4=;
 b=JGos4OKE/cdxfSn3Fll91VtF67rYkaIwby3f4bJiQUSZklmGTtzIUrN3WrhFWhXEt+saf0XPZorxnDJ2BjM1mTIthFOMc0tbll/H02IC4BexNt8ipFwtygH6Vlu6q3SXIxZsXYu2RaWvfz2CkgEfkwNvUZjxMOtpyaCyj3xM6YcDu7UOs9vxfEW6gxvdJfZXwcc2rILAQCeBy4Egpk0V35UxLzyMFpDauoHPaWecJpa8FTZn2JK5QYdNXcUsmTt6tUHAFOXgJ3kr2k5JSBz6Nzts7ftqKhTZVNPUe1rrASYpHbZ5hJglfAKWk778jaDNDXJOEJPDg++n60NDsuwszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUHibzxi+DwnSGrfxyT9+M2ietjIKQUoDhvURvhCuf4=;
 b=AXtF91lMl3jrQ6mZSVZuVfofTsTOX+/ALjMgMJiAkRdwFbeSWauXcUV6UlJCURBa2GjzNxXu3X2UxJxXbKg9Q9YlWFyZwGkaZzWdbnOxKWw0JowOtPZY5z1/Jw7qLh2aTa2fBserHHE+x1LdaPJlmbsuYoLXOhPSYabAx5sUoiA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3022.namprd12.prod.outlook.com (2603:10b6:208:ce::32)
 by MN2PR12MB2893.namprd12.prod.outlook.com (2603:10b6:208:107::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.33; Fri, 26 Feb
 2021 04:24:29 +0000
Received: from MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554]) by MN2PR12MB3022.namprd12.prod.outlook.com
 ([fe80::49f7:4979:3a0a:4554%6]) with mapi id 15.20.3890.020; Fri, 26 Feb 2021
 04:24:29 +0000
From: Kevin Wang <kevin1.wang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: add RAP TA version print in amdgpu_firmware_info
Date: Fri, 26 Feb 2021 12:23:59 +0800
Message-Id: <20210226042359.39108-1-kevin1.wang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK0PR03CA0111.apcprd03.prod.outlook.com
 (2603:1096:203:b0::27) To MN2PR12MB3022.namprd12.prod.outlook.com
 (2603:10b6:208:ce::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kevin-ws.amd.com (58.247.170.245) by
 HK0PR03CA0111.apcprd03.prod.outlook.com (2603:1096:203:b0::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3890.20 via Frontend Transport; Fri, 26 Feb 2021 04:24:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4f79c978-f8ad-4114-97af-08d8da0e6849
X-MS-TrafficTypeDiagnostic: MN2PR12MB2893:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB2893E8357819A85640B3E955A29D9@MN2PR12MB2893.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:139;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xg9RKQBPA1GI2Wt9SYc+EGlybfhF5MOhiaXbSFdn0Ss1NUQrm9Uh3wdCwVQd8BAlQcNwY+olpynposTXF1sX5Q5kHrtZD/qrhiOVma7G3P+NfmMO2zHz9iq5QWe8z6t41GeuzpaabNYpDLQbZdAJKSqSB/22Z8V+m00q7+eGpTV/opJEe7P4zm2T2qW3wFwbh/pkZhRbWvmRZdCe14N7KVidrZE/eCwgXBgUmNQq/DMskEv3XujV2L2/Lth5ojIn0hN9I7O+85lGmuxN4S/qmeCWHfX+UGzVCCNL969vYac8cKHALmLlNyZ15I1FI6dJrvwJUYTN8fshXh2l6OoyqDGCqpH0YY736zmJA9OgbFqE+xcYdUoCNdiKv3adGZufIDHv2sbPJUAf5oxoz+zfO2rAqCqRAskiJLJTnG8VJ/fFnZwaM3ACoZiL+KjpGKjvkaJ0MIt5AVmimygVQKFz6PFPHkddPO1lDe0q7V54YWOYC5lxhzxLib9ncfbUWJUs7gIpl6DP67+PheBw5gjd1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3022.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(4326008)(16526019)(52116002)(6486002)(186003)(36756003)(316002)(1076003)(6916009)(2616005)(86362001)(478600001)(66556008)(66476007)(2906002)(7696005)(5660300002)(8676002)(6666004)(26005)(66946007)(8936002)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?6zszyAKuhsLDS9Pht9O/WPSH8Ycgml298d0aDyXL2zFFqkd5vz0EvDTSt+Zi?=
 =?us-ascii?Q?HpxPnEB9iF4HFQs30rE1UBGwA2d7S2n3+mpphatjQzfSO9O5J89GOG3pGAec?=
 =?us-ascii?Q?1aGhRG350Y8PlKhqNi6GACg/b5iJZLg3ckcU2bYj1aJZ7zv33YWkNkbGBeDt?=
 =?us-ascii?Q?fTz8oZXYWSKpzL9uROeCD3cmA/yGZGGo+sAvgIGaWqellx4u2Cm5SwQdHw03?=
 =?us-ascii?Q?vZKoQtPqQ0ZyU5oVPjC4WuAdOzMUTgIzzanYbtGiBVzzsrWvVMMS73rmJptC?=
 =?us-ascii?Q?G5or86cOnJkN2VWHmgAaXkHwlfrddg9I9CXgoLoG98aTP3yCXDg/eigEoijl?=
 =?us-ascii?Q?Q2GuLKLPCKkwcRLAZIH69ilv00U4i/ZVOv4NGxeB0VuCKdhD80NRpDv+5fVO?=
 =?us-ascii?Q?jAvDNZk53O6WyKKLF+lfwvX+ZvSIqFTnWu9Pml+yUcWDg3y8Ga1pbvjFldEC?=
 =?us-ascii?Q?mUG60dbI+GT1WWCyAB4V5gxPM9ntiIWhUYhZVqGiOt9e52htvhQ90SGQmR3H?=
 =?us-ascii?Q?GDAql3IGISDTcR9EVIHXD2wmFv3dzLv0QEoEoRmOtch8gWTkrwODT91qwPuE?=
 =?us-ascii?Q?LLB3awZZKT16Cg7v3gg8NG1oba0pa+KHNvAkXha5GEWmydqsJHReyKiuWDE9?=
 =?us-ascii?Q?gmq+vN5Kch8LCc7Nfk4XQLYBPwxYFQ86wQuQQc6Rim9pwUZ0ngckfty4DjLU?=
 =?us-ascii?Q?ySQIX/JxqFAZpVoHbozLG/+wTrr0+3iQMIfk3sLuNXosUIg+7VppI4NkOhgi?=
 =?us-ascii?Q?7r1zbNZYgdjK0EQAMI3CKFLcVgyZdnf76LfuxD8rLaZIkEWo8YfCJaR/Nhdk?=
 =?us-ascii?Q?H+o28KPN0rpjEzmKhwN2PKUNvSSvHy6vFY4QQ0FRev4eF0EMsaYJVS+BqSYG?=
 =?us-ascii?Q?IzCU+pHFExlI368ub3Ib2NiKnUxqX4URmCdArcFMqAO5tuO+VRwtHmTZXc+R?=
 =?us-ascii?Q?b6k5Hl1tbaK8Hwt+ydaJvBcKhT9Y6I6fe97qTXQpaaN0WwVRsq5zflknSgG+?=
 =?us-ascii?Q?07xuL88MYHIrjBhAzRfGwfdMyoZxIsrQiI5huabZGorOHMe058uZvonKqpiy?=
 =?us-ascii?Q?7th9GCeZiohU7LI4YscnsHHXGQ7kLHL+D5m3oYgh8YxfNbRtni65MNbkj1gO?=
 =?us-ascii?Q?8lmUErqy5pF8Ik13SxK747YUeUAZytaPvxqtmCjt4B0+TvHh5zqm/5H23LDU?=
 =?us-ascii?Q?ESA2kIbVECcCzakfWPY6QYCkhSbExPKCQVcZFaWUGnf65fw5bejsFjuwyBt3?=
 =?us-ascii?Q?VcrXq+LYU2tsQLHnFIMcvkbgBDDRV8WtgdP59vSqTsa8XbX8lhoFUbUqkIwg?=
 =?us-ascii?Q?tfJ2UncVVC29KROwxE+iNr8v?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f79c978-f8ad-4114-97af-08d8da0e6849
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3022.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2021 04:24:29.2752 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iyt2/G/AIXivWpLlRczXo0rRHagIi38HFYy5dkjWac52ISFxMqjDUUU3hCyUXFcT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2893
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
Cc: candice.li@amd.com, Kevin Wang <kevin1.wang@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

add RAP TA version print in amdgpu_firmware_info.

Signed-off-by: Kevin Wang <kevin1.wang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index ce031a77cda5..a5ed9530f542 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -305,6 +305,10 @@ static int amdgpu_firmware_info(struct drm_amdgpu_info_firmware *fw_info,
 			fw_info->ver = adev->psp.ta_fw_version;
 			fw_info->feature = adev->psp.ta_dtm_ucode_version;
 			break;
+		case 4:
+			fw_info->ver = adev->psp.ta_fw_version;
+			fw_info->feature = adev->psp.ta_rap_ucode_version;
+			break;
 		default:
 			return -EINVAL;
 		}
@@ -1490,6 +1494,10 @@ static int amdgpu_debugfs_firmware_info_show(struct seq_file *m, void *unused)
 			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
 					"DTM", fw_info.feature, fw_info.ver);
 			break;
+		case 4:
+			seq_printf(m, "TA %s feature version: 0x%08x, firmware version: 0x%08x\n",
+					"RAP", fw_info.feature, fw_info.ver);
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
