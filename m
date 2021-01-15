Return-Path: <SRS0=jp5v=GS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74461C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 10:47:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CAF123603
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Jan 2021 10:47:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CAF123603
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F5EC89911;
	Fri, 15 Jan 2021 10:47:46 +0000 (UTC)
Received: from NAM04-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr700078.outbound.protection.outlook.com [40.107.70.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FBD989911
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jan 2021 10:47:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KUJxiV4wVYfw3XYphqlZfkDRb0wwLoqh/QKMqCQ2oVxckDHkpN1qEdX/KAuSQppK8hxwvRWqB0S3n6Vq/LRaZGu+mwFVl2OKZ460UeRsWpjsVC9lBJcoLpFHxTifykvTEYVWSBQo0JhkZRc+KkcqEdhO3ffmb7H4lBgb1SPcceZHqRCdvW7C/89sWl2CgJhRt9GNGOf9PtLWAwSGDrLKIFfy9wg5zVO7SQDUnldY7HTUjwhhKQKOWPhfzG7N0GmCmkvLxOs7a3mc311deF2dG9CZdA0lDyaU0Qbk0+MJup8eXU1lUf5vcwPa3P35t6gtb2Y48DqykXz5UEm0Gl2wMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcVHt8tBMxq2pz76gWLZM6HUn4/K6oklvdqpu/ziWnk=;
 b=D+ONIiW5bxudnWn37cyPZAePUDoN5/XwGFnzQdDchFCzlPbG9/gL+kkmBiVGo7eMvt3M6bq9mrli+0OtIkjXy4jnFN6c9yaZwqhpzS8B/+yrrMFxf4f+cDokIq0O+d9RdnspTcRq7onefYajawpRgl3tPYuVrdvS5wBZI9TGtrZtQ0BcS4gdMKm1m4PIzi8RXyQcm2Mnw4IfOeAg23WEDdQr4J/lnH5vkAzBdgQa9OkwWbxsGcAd2DBdYCF1lSqyz95dlddB4G1H4GezGzLsIxNbK5m/N8XPN0Q1QLdOe/JNnFWWOko7Y3AnxS7anOoBdxb5wKodJStnFibYWixTNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QcVHt8tBMxq2pz76gWLZM6HUn4/K6oklvdqpu/ziWnk=;
 b=24pIrgFiO2/K3XOGbz12m1fLzJo9zhDo9tG+8B2Z1beHwBLgSB1XUcEZpujcpZtNHthW3UWpwdLg2tcIMkvP5Nx/OtuhRaSkPlAQ87a9W/qfDsyiIa9lTpO6XIMzolsNHuzn9IwWuVYINnn6Qi0b1pTsZrxnIydM0sQsRnam9x4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MW3PR12MB4571.namprd12.prod.outlook.com (2603:10b6:303:5c::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Fri, 15 Jan
 2021 10:47:42 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3763.011; Fri, 15 Jan 2021
 10:47:42 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: fix the system memory page fault because of
 copy overflow
Date: Sat, 16 Jan 2021 02:46:58 +0800
Message-Id: <20210115184658.513045-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.245]
X-ClientProxiedBy: HK2PR04CA0057.apcprd04.prod.outlook.com
 (2603:1096:202:14::25) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (58.247.170.245) by
 HK2PR04CA0057.apcprd04.prod.outlook.com (2603:1096:202:14::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.10 via Frontend Transport; Fri, 15 Jan 2021 10:47:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e73d35ff-6db5-4b20-9a35-08d8b942fbbd
X-MS-TrafficTypeDiagnostic: MW3PR12MB4571:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB45711222B2AEAB607735BCDDECA70@MW3PR12MB4571.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B3rUx4W2nhrZNRNFc4YlW2Rhrqy0BYLuiTugz3NUsXKdnNhDPkPmXeK6XxapEjPGiQm+DPU0g74OkvxKCvPnWvkTHu3+aN8WTbJPuW8GUGxYMRSHGCaQfrX9KYJ1av6izbUc8Ba04e7iJ4yJ21sWdQO9RRfcNJ/0xikln/qsdM/vddDe6Z22PfoYGoJDnVvgxCuovpy1IReF1j3EpnyskUTYGj7S0sKEikjVOwsUvaZ8+m8VRVqlA3RW21enfWEJB375hWVpNsZQ7Kf+m4gJ3Z9nJHNCvSaWlIzPTziDAy3vobSyKi0rvWXksw15cBxR7WIkROfpiVNtc6yUecNDL4TDdnIAVMCM2bahKPRMEKTozPB1CCPqD6EURtzmktFHnrP1pM0H3ZlEFl+ttroLxQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(5660300002)(4326008)(66476007)(86362001)(2616005)(7696005)(66946007)(16526019)(186003)(2906002)(66556008)(52116002)(54906003)(26005)(478600001)(6666004)(83380400001)(1076003)(8936002)(8676002)(956004)(36756003)(6916009)(316002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?IfVStkrgEJkIxpJfI3ZkcXOUU1v/KM6xPC8ADmpGG68bZa8ZqCc+Phzv11wD?=
 =?us-ascii?Q?vhUrrvulHUMESJYP9O/+zk96djojJs7D9MIn2AU3tL0fETJ9cJxsfZTCTIcc?=
 =?us-ascii?Q?TA5a4Yyxu1K+YQnvmcnU/1DvhEUJ/WHCcRmObxQcJfIxs5jvAhnXstJ2NzO/?=
 =?us-ascii?Q?/07ppu0pXQdLtTQSDICQRmYSguCeHo86SL1HGaSOq88xDb9AWfNWS+6odIa/?=
 =?us-ascii?Q?w7TUGK6HcVGZNR3bfvIgYo5z8/DrqBs1MbA2jzkxwBUmFlqJUilF0YITtXM4?=
 =?us-ascii?Q?ZmEqUNWGuwZl/x1XKPtKl0w25xMy9r+91sLAK82AKY3/e3zQhJguss/tStWq?=
 =?us-ascii?Q?dilWJbtf/okyCGYpkGGgkD9nxzoMltheVpTGJGevW8zyLH8vJCh7bxzIh9Sz?=
 =?us-ascii?Q?hk0n91Tt+eO9RIZC0FaKH4tXDlrveTcRXqwCpneSlzt7ieaTr2m9tz5YYC9M?=
 =?us-ascii?Q?HCqCu0MFVdpp+L3zYaop/no7TvsYhWnLZufEr+6Xlub1sWAvPqWzP0K0LsCb?=
 =?us-ascii?Q?AQ/+hwUJpDZJms7e50ywZUzaxmQFx3AfXpPD2EGw+F2R8FrwE4otYz3itnkl?=
 =?us-ascii?Q?KtB5+Ua3zxPfyfoI9NBucRVYVwqfZsZ+OBW6DYc+ffK0Yay/+I+Mav61ACgj?=
 =?us-ascii?Q?gTSp/PvS47PBh9JFGlSb+3fRC/Wbpq4MblmDgg/a0MThEyJI0NU+VxfQZf5R?=
 =?us-ascii?Q?YgV8JfxqWQlpZT/Z2yjZBHCPcNGTJ1gd6D6Gj3yOEndaFPOUT53FnvH98uaj?=
 =?us-ascii?Q?+xV/Q2+ByTTvClGPqyfxRNAq65SYitaHrR6dOLwIKdMLLZusgJh4hAUxM6qe?=
 =?us-ascii?Q?oQlJA3F5lLSoVy7TBT1z9v4oZGXVI/qjZYzpLwSwuT+afmS8M+sAb3lPDVf9?=
 =?us-ascii?Q?SYuKOcJLOeqDuvwJlxY3jAxNmN2ULYJskhWT3pcy+sGyhoN+ccTkUeoKUdP1?=
 =?us-ascii?Q?6DtWPVA4+QYNYcjY4pGmZfx4cBEe9kblFbXtvpt3zwbJsGK+E99mSYSG0AW+?=
 =?us-ascii?Q?cHHV?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e73d35ff-6db5-4b20-9a35-08d8b942fbbd
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2021 10:47:42.0240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1CLNxObyqiG0DTaLkpY5Qd0rLDxAiBrGTD0QWlOGKu19MLlJOE0twRVNccNlX/RhfpVk9D0a1dUQ0pGV4gaiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4571
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jinzhou Su <Jinzhou.Su@amd.com>,
 Huang Rui <ray.huang@amd.com>, Lee Jones <lee.jones@linaro.org>,
 changfeng.zhu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The buffer is allocated with the size of pointer and copy with the size of
data structure. Then trigger the system memory page fault. Use the
orignal data structure to get the object size.

Fixes: a8e30005b drm/amd/display/dc/core/dc_link: Move some local data
from the stack to the heap

Signed-off-by: Huang Rui <ray.huang@amd.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 69573d67056d..73178978ae74 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1380,7 +1380,7 @@ static bool dc_link_construct(struct dc_link *link,
 
 	DC_LOGGER_INIT(dc_ctx->logger);
 
-	info = kzalloc(sizeof(info), GFP_KERNEL);
+	info = kzalloc(sizeof(struct integrated_info), GFP_KERNEL);
 	if (!info)
 		goto create_fail;
 
@@ -1545,7 +1545,7 @@ static bool dc_link_construct(struct dc_link *link,
 	}
 
 	if (bios->integrated_info)
-		memcpy(info, bios->integrated_info, sizeof(*info));
+		memcpy(info, bios->integrated_info, sizeof(struct integrated_info));
 
 	/* Look for channel mapping corresponding to connector and device tag */
 	for (i = 0; i < MAX_NUMBER_OF_EXT_DISPLAY_PATH; i++) {
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
