Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C65DC433ED
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC0CC613E1
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 20:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC0CC613E1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 519BC6F4A2;
	Thu, 29 Apr 2021 20:13:42 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8659B6F4A2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 20:13:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGVJoL8iyZj29eoM3iBalQVl1KgsfpLazEYayc3RKKr3KUVOu6yWuSJyGNYRGdjllyX3/SBXjbV01SKvw873QWsY3mHouAHOtzggqIKoV9sSr1VKnYTMSKzU5qgSeVrJCMq70R1C970kBI8BGOvM1DJuh+ny0zlnGfADDqyJMs8er+DgMwNJIWnw2ZT2TL9Z/ZHTUAn+vWXg8eXk/EzdrSql50/vtxqbMdtBVrKdv+nABrLqmdlr/PCAor/lPED5VMSCn0bZj8IDB7FMT/9sY+dj3zVGZP3uH7N0Ua5oYbb1iCNi2aEgP4X9K/KLUgL+nGA9r2XqjSjIOmwVin9vmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00IGI/VJ4gN8WYEv7rJ5Cwz9yj11NAkR0nOuqwy/qzQ=;
 b=B3Qjk7c02Fv9jYcbWygKSGzLlf7BfMkNfGYV13LyB9kUKhyuXLW6bAWcyNDf2lcJHtVkNOHc2ZWw8MuXKvlVv0GxZXniIkUaCL6Rgczr3MTgucwPaq/BjIXI29wkDsu071eOfHsZkfh3yrQKONVRTyHI2Sv8PYK5ZgA7L4YagSE8olDY7jVoBsKa6tAnpPcmTvXoqmCzGRswkSNlHfgrGTu1cNRMJs7HXS7urvWHI34sClLrnXtIQvMlswgRtQuzB3ebWYLlC+L5RIzSqpY2/r8Ms0fUIqJCH86IBeh8msXxduFuEHrZvmJt3E6zMmHdwxkjAFi2Z3RzHD8D8qM78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=00IGI/VJ4gN8WYEv7rJ5Cwz9yj11NAkR0nOuqwy/qzQ=;
 b=mUfoLVRAlsncJz9y5qPt1zAr9zhbRajwkDTiNn9WgDOFO8DjnYUIxH3YmCUahB7a9JPt8ZusZ8s70WRS80bVrFJyRf6IwjEvCgAtSQolWJzN06c2ht31PEavf6AclalyQKJ+u0GBbB4Db6E/UFDU/lL9iVPOlzJOqZi+P3wIBYs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31)
 by DM5PR12MB2438.namprd12.prod.outlook.com (2603:10b6:4:b5::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.25; Thu, 29 Apr
 2021 20:13:39 +0000
Received: from DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e]) by DM6PR12MB3308.namprd12.prod.outlook.com
 ([fe80::e944:a64c:ce89:112e%7]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 20:13:39 +0000
From: Zhigang Luo <zhigang.luo@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdkfd: Add Aldebaran virtualization support
Date: Thu, 29 Apr 2021 16:13:11 -0400
Message-Id: <20210429201312.10498-1-zhigang.luo@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::16) To DM6PR12MB3308.namprd12.prod.outlook.com
 (2603:10b6:5:182::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Zhigang-WS.amd.com (165.204.55.250) by
 YT1PR01CA0137.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.25 via Frontend Transport; Thu, 29 Apr 2021 20:13:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 564fc447-4687-4f14-fb99-08d90b4b46d5
X-MS-TrafficTypeDiagnostic: DM5PR12MB2438:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB24382A387CF9DC6C3C469308F15F9@DM5PR12MB2438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:361;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bjx1edTx5RNu/fdQb8/rs7EWQ77+p4UfHW5SiA3giIrZ7U8hncVCjohvThFK3sQhppTvDEUJLMQxibGPyn732ydhoMAo71VS/SuCyg50HQgRt1zyk9pDfxAjdbg051oebG8SwoGhUiNYJPoC9Sowjq/+yJAKxPM9t8TQrQ6Jn1Xgf7jLmPJnigU+j0j/zpSMjtrEbMvwXFJ8hkgfBiTAy7v3TEv4sdJ8/WbCOvlMycZKl02LbJqshHbbiPFz9grTzx7XJw0BrDcG8OWaABPm9OQNPuCaciZeyV8vmJppwu/M4MFW5pM+0KjSg5KET0dWtjJ2R4wOJBuNf3qGM4DYof4vbdhWp1X4VaPkU9Sk/ctU7EPmGofrdnkuWcSBDamN4ofz/6I9NMY9y0x3wI2DTDyk8w1TQV3KGMdbYuEjsQg3YaD+O91htKvkAD0c+qgVa4rsy7XybT2GbjljIBEA3/2uNHlGXpGUl/fd5zSYDEoVxfAIb/2kHvNZ0t/MGDCh8wNQjp8CwZkZjQd/YeWPRUTMiDEy9OJnirtS2EPmMm0skeFhK952hMbaS8N/koA4EMiojunIpyoSM8tJYmuVkjrLiTe3laIminpbxl8ccSisFCTcM/U5bT6LoMJqLP2m7plt5IZo9n1HiBj5wav/0hW15HUMd4/oxb4VDNY7x/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(346002)(39850400004)(44832011)(8676002)(38100700002)(6666004)(1076003)(4744005)(4326008)(956004)(38350700002)(16526019)(7696005)(66556008)(8936002)(2906002)(66946007)(86362001)(52116002)(83380400001)(186003)(26005)(5660300002)(316002)(6916009)(6486002)(2616005)(478600001)(36756003)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7axxEs6F6GQDyDRlIjNnTQVKN/4MYT6UbUbsbT8QfuI3UEO0zAdYG1VVfzh3?=
 =?us-ascii?Q?wYa/6OPX7+AfHXr6Qip3vHxlbeVlFOYLbuUzNC6IUX+pbT5pJuz/k34arwXo?=
 =?us-ascii?Q?v/E3yf9OqBg4+kdJQ/zwIPHfMDSARkAkyTIpa2+E68E1sRyBaidi1ULJGDig?=
 =?us-ascii?Q?yA9YVQPoRIck1EQH/idrIuzcXUJk2OUct8MEVdPlO4bdCs14g9r8kVt5AslI?=
 =?us-ascii?Q?x9KCPOt3QP2XyYWGYJgxoDfp7Wsu0jdujQ8G38FiRfsj6KqSZya6BaCoMhLn?=
 =?us-ascii?Q?1M2aORVROE3F5R4vnXLQJR4+i7qR/4byAuKfObO+tC0hQdC3UxIhqUodR8oP?=
 =?us-ascii?Q?Wy25edrBZbJmJSRslKD+C7+ez9Qj102ef3X8a0WRupcyDWo7PZiCJms140q5?=
 =?us-ascii?Q?c0MKx7ODFhcq2UxVNF+mn6NNdZkyPj7IhGjrzcdvkrxiiDeFKv0WXXSYepag?=
 =?us-ascii?Q?agO0PDMIOAGw0UMxpnEk3WTVRCgxjMbqzvGAbwojkwntfMuEdbcWpGfbXo4Y?=
 =?us-ascii?Q?rckg34Ncazt536j4/1S+KLXbFPoaReo6lLFpMgzKAvmYvcPArOYgLGKTa/Bv?=
 =?us-ascii?Q?puZkole9sHq3yME3es9uzYpzf5596+58Fc52MRppYIJ+msRe8g+Rv2xf9ddE?=
 =?us-ascii?Q?lmAHzvVoC6KU7bWqI44QkduIxubJdh7LS/E8lAQhxjW9F8R5qc5jPkITP56i?=
 =?us-ascii?Q?EOZ66cJMJS0Bd03MOav5Qtl54b3iYtANrYLHqEolMOG7IGi1bDNPz9iF9e+e?=
 =?us-ascii?Q?Uo4sH+WiAZp8o/CnNa4SYAAuGHsAo6bJaA1NQJd9T0naGynV6P9yTOKb/Z0c?=
 =?us-ascii?Q?FZOdXa0v1mgabi98zjlqQvcNCAND2kgv4KuFd/XtVM2rhfCRu94CfLXQGRl3?=
 =?us-ascii?Q?tzXlfS359SiQR+jLdqjA3ysH+3WTHxm8tVbn+VyI5P2B6iNuA7TnE+lW8OZs?=
 =?us-ascii?Q?naB+atYEV1K/mhqFpFjqIN3ohl4a5TbHoO5Yn84Vsxglj9SNjnyKhESi3gfS?=
 =?us-ascii?Q?T8vK2PvPFnkdQWIWI9c8AO2iEzgAztwRrC3zV6g+jMQtaa7VOSW5CDcijtZx?=
 =?us-ascii?Q?TlpDWI062XrUQyU+WPoJOj0lWXFX14pRhT+Nw0WAu7ARcYOQmXZk2WGJW+VK?=
 =?us-ascii?Q?ExT9DfpEa0ncp/vbz9PsFlEQ5l6uNDTogqyQtVkbEq3qdAt/NZWh8xf8CGJ2?=
 =?us-ascii?Q?Jb2Uz/gtHsxRlE09qe9S+OOy81uqiqgBLN/kGoGyIzoaL6I8+aUMlLOXtS2Z?=
 =?us-ascii?Q?hwSJXRdN+zQtULD3KU+ZFnfrjJ1CxDWRUHdZFIjbDYIwa0m7MCnNKqdIa1Hf?=
 =?us-ascii?Q?cxiTc3vvFhMlvV4f1QLpZQf3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 564fc447-4687-4f14-fb99-08d90b4b46d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 20:13:39.1115 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ETqAuaZD199SaYZ5XSCCVf3cKt1oOa2ry+C/Iz90wok9WZ7sDV3HK0JN4IUhnQyI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2438
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
Cc: Zhigang Luo <zhigang.luo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update kfd_supported_devices to enable Aldebaran virtualization support

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index ae3cabb47a26..dedb8e33b953 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -578,7 +578,7 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
 	[CHIP_VEGA20] = {&vega20_device_info, NULL},
 	[CHIP_RENOIR] = {&renoir_device_info, NULL},
 	[CHIP_ARCTURUS] = {&arcturus_device_info, &arcturus_device_info},
-	[CHIP_ALDEBARAN] = {&aldebaran_device_info, NULL},
+	[CHIP_ALDEBARAN] = {&aldebaran_device_info, &aldebaran_device_info},
 	[CHIP_NAVI10] = {&navi10_device_info, NULL},
 	[CHIP_NAVI12] = {&navi12_device_info, &navi12_device_info},
 	[CHIP_NAVI14] = {&navi14_device_info, NULL},
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
