Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B7F3C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 10:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3581823109
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 10:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3581823109
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 923836E1B2;
	Tue, 12 Jan 2021 10:25:30 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB4A6E1B2
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Jan 2021 10:25:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fxzUjyO0wcfUkK/6Iey8WXY7FTCDoRkIvrDFaxPn4CYI+vgssxiyhzxGGDRoQfWGxdDGYxOMv8CeQhm3pfpuZQOoXf8qKVGLSvsw4EfnqjT8xzkHH53AksXQs5heRXhjNz62tULt+ek5REuW1N2koFY9UU9JHDOmwKiHmZ/xfAs1r5pWA0r0gJCIZU54Nq560pdMH7Z21Le0uirCT+UfOSGMsRmvDcZGEXuWj67QOHsJQuM+qxxPkl8pagLY8fUiX8+9FTlbRS1TEahrIPuQFI8vGVB5DrbhYqaJqKiJFg/PfIkpf4j+ObA1iHzpOaP+IAPoD/6ZppGTRbFP7Ny3rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBhVutRnLfg6CTJ2721wO6WKqZbND5f4SUU1oopvbjg=;
 b=VKscsobiKzDn3+blxImf1vUiyl2X/S0a4n6VbX0evyPVX7CvWAnZ6977IKsMsAPwiieUYnymezp3bkQ9eLYP/kc5OKYjIxtNWHiOxYvDWpABJ1WR0Jogz5zWMTSTrZBFVrmH8ytpoMWkEF9EwUzxO9aVDx0zAzyEVJs1ShhHkarqLyt7UvKx105uR8RBpsgwAJqgaI8tBi6BgDI5rTWzRS5nXL0FtzcemmXT5n700ROC94MSGzP5gJheYsr5Q84s9VDY2L+vJ6vMayI0AZFbnt9Cd/8pB8BKmX94xsSlS1WfaLO/x/EVmbzzOMUTTPsNC2xW6eLdblX8h2C4Uc5WlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBhVutRnLfg6CTJ2721wO6WKqZbND5f4SUU1oopvbjg=;
 b=47BedQ5e1s3qnalZYOm2xk4kIHQiRlJ/Amnok1zNe7yyEj+qgwXtOJ1UWtVFb2WRwjZ8JYp/HziU5bDqkAwStHjhF0XAbe5lELEn3wQnmv5mf7DL+AAy/spQGzKDqdkzTWK8HC2WsGw0PVMu+MvRhvopzWbJ6Nzj+YabEt5+Ndk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1182.namprd12.prod.outlook.com (2603:10b6:300:b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 10:25:27 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 10:25:27 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/pm: fix the return value of pm message
Date: Tue, 12 Jan 2021 18:25:08 +0800
Message-Id: <20210112102508.82417-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HKAPR03CA0022.apcprd03.prod.outlook.com
 (2603:1096:203:c9::9) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HKAPR03CA0022.apcprd03.prod.outlook.com (2603:1096:203:c9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Tue, 12 Jan 2021 10:25:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c775c69c-7bdb-4530-61dc-08d8b6e4615a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1182:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1182E97290FB5B2BCDC8D4EAECAA0@MWHPR12MB1182.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ndn55+AqcbktaNgua2tFnt+WqdvpIdzAcWzRyBhZ+xeu1SC0K+DWG/3sG8zFsnAmJqtPPvDMAisecx2tOL+SNf80y72E0+T+9KKraQFthi8Fr3SwQs1uiI3MHXa4s/y/AWxkt8NvbWtoyqUeK9wPMDExv8KDZRaN+6ifIDZE8frhp9nHdEkMGik9P/PkQPvxJbEf95tIUHR/CPYXGKi01j4tO1unihWv8yeQ+C/xZuje5Yh7+E4CLq4/66PArRVmoyEiBYjJEYzTAS0uiIXZQNlpdHDX8CIHvq3VaIVniEB730WHTSFLO6CxVg3bCAqNBl7Gy3up/ZeOZMuN1hy1CrJjoUlGm9T4NJkWTZxGOMukSMNO95SEErC0CgrhLQOw/Cx0olpPaY0dPN/LWujaFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(366004)(136003)(6666004)(2906002)(2616005)(54906003)(1076003)(4326008)(186003)(6916009)(66946007)(86362001)(956004)(36756003)(5660300002)(66476007)(26005)(478600001)(4744005)(8676002)(6486002)(16526019)(8936002)(316002)(15650500001)(52116002)(66556008)(7696005)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?aqePhJBSZPDnCUmXqZaJuovJPGoCWmDKRRu6RZMBk6GLkJuZD71/pjPYKVsZ?=
 =?us-ascii?Q?7k1VzTkuTpdJKXvInclCMq2aHqg4cATm42+3fopAhPNpQpdT5ELXJ3qi5xsj?=
 =?us-ascii?Q?CizIDIQTqkAF8IoEWRss4APo5fBV//ab+ud8XBJjdv5duAPfTEuo1bqmOgz0?=
 =?us-ascii?Q?ckNuJtTXO/F8cPmd8yLh4RHGKGwCrcm4EuVEZ91OMMWqkphmW4KGLGwlNh1h?=
 =?us-ascii?Q?pkwslF5xfZXFG2zxRfw3RFfaZ9BDOghufcjG925WzlkjqE7FC0xxm2HXJ+av?=
 =?us-ascii?Q?vK5Yf84IhtzzdqjnZEuv/4im9iv7n9OxQn1sI7S0WYJsgTojFfQ/gDCvkN7k?=
 =?us-ascii?Q?HC7Fa0kN3uw6CHR5FnE0OyQiMz+btCIzap47M6VWpITCUokT0jj8/YhqFxW1?=
 =?us-ascii?Q?9x2SAPS6Q3y+xJFH+EzIu91sxD59BNDIMQLiSVU1TV5CNK9JjSlupJbOQ9BJ?=
 =?us-ascii?Q?Rtq3s/5UJSAQztbuF2Zbiw2qT6GouNnKCWjvWq9AREwIyBQ7IHejob/MjMWS?=
 =?us-ascii?Q?C+DLThd3FGi1X6AVH9riBVYczmeoSK3ErosFItV5j3UAQx+/tYGIGlr5zMHu?=
 =?us-ascii?Q?io15RleYTrCzuTT5mEiX6Pd/huFWO9uwUlAWy4/h+qJcofdZYbzhd3uLensE?=
 =?us-ascii?Q?6GkWNkTcG0vFXCACYbSbnuwL4xlBtj90+i1VBVJp/GbCB3Wl+pG/IUd0g3zL?=
 =?us-ascii?Q?8hvRblZTP78eY2huigWsHTC1/YD9oTKbus65jjamv76l0/ywaEy1xlnPJdE9?=
 =?us-ascii?Q?6CxEluWfEscUXM2240jQb9wiaNvTRTuNr/2ueXRL8DueNK/Yo49ZkbKeG47J?=
 =?us-ascii?Q?SqXhDAam7wJ+ljfwXO4hcjCQDQ0Pmy2cFCOqT27LxTiMYe2Ps8Ev5F0g9pM4?=
 =?us-ascii?Q?nKcxzLpZ5CyweRCytu7uaj+5Pj/G7XqYbPrdqZPijedKMuFr7i9SnW7HQPOV?=
 =?us-ascii?Q?OftytoNtHZHxyTSr3rYlCfE3yBINQKXSPVk3+REg59sRcUFyF51vR3oOhXXK?=
 =?us-ascii?Q?J1yH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 10:25:27.2728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: c775c69c-7bdb-4530-61dc-08d8b6e4615a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61aNEdyRi+Sn5q4mY/Lrsujx/woQSqRt8DQQFu/ldR9KB3jdP7iYF12O+G4vhmUnXcQefeEdhfzRzdxcXb5PYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1182
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
Cc: Xiaojian Du <xiaojian.du@amd.com>, Huang Rui <ray.huang@amd.com>,
 Aaron Liu <aaron.liu@amd.com>, Xiaomeng Hou <Xiaomeng.Hou@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

0 should be right driver return value, 0x1 is the right firmware
return value. So switch to 0 at last.

Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index d7d86fd79e1f..41d5c65a2f21 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -149,6 +149,7 @@ int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
 	if (read_arg)
 		smu_cmn_read_arg(smu, read_arg);
 
+	ret = 0; /* 0 as driver return value */
 out:
 	mutex_unlock(&smu->message_lock);
 	return ret;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
