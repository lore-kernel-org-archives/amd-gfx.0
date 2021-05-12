Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53219C4363C
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3B4261417
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 17:31:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3B4261417
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37AAE6EC67;
	Wed, 12 May 2021 17:31:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AD16EC65
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 17:31:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqp4odfA5IYOCDfaW3i1+2rVzexuRip/YX1C3xIDRpxwfsiMnE7xqIUzGlZTqyqsuUG1UJcArNeK8q9tJHvHfX3KbQZ4R6dkQ9jVBcBnnUDYGJ/QqfJNtHal+OknlnyEKFJSLeZd/8QrB7JxpwHfkwQT5lSt6O5WaMzCNX6tRuRSP420ltgM8UVb9juYpWRGwrs42xLc6+xtGIjTlDzsRN7gfTDpVWtLCQXmAlTnbCRQHWOCsugZYj9fCMGhQVknuJqnmJo7JroigNyQCqQ12jDW9TqbyBRMIMo4K755JfJuagjBpDAWLRvGGCzQr3HuYi0rxmVAvIX98uDfkL1RdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLiIFL2UZ/T5jgdgtNTCoxhv2O0vCDBTsLx+HlhtB2g=;
 b=hdeRJltJO2RQfas3bGoSDbwtT1tWZoFh7h2O9RGvskPA7cDYcepEUB4VS7XZZq0S6UX98LO+adY6wUXr7r/V8kZTGhtk90OdgXIx2OjjZwwRyCgU+MkkRQrczh0VLmRGm7k4Giy2CvjA6CLTNpLNSHVI4gbJzQ8OVqOfJIMx5BWBgvesnVNSOBON6F7CGyx1MXvLbK27XMEWEfRmdacfCLjta2ZyvLWH/oQwntePpvdiYVu81Vupv4Ggu/3QMcIQwJxy8DKpcZCgtUlH5s2HSRv1Olq2dZQ9+ep4R36s2QI3FQ10mD2810TkscijwpS5UoXfSyuRdskWpNjbIW74FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wLiIFL2UZ/T5jgdgtNTCoxhv2O0vCDBTsLx+HlhtB2g=;
 b=yIXV03hxQl/QSlSlmeZN3HfrkHDgTtODAoDevjX4+GQh+bxnJN664G8tzv9RovmHeCJD+omhvk7NxPa/Bwi88i7kcNzbW0t+6bvVtaBEMu8bIv4yTebKRFdTh7Sx55MZSH6vn5B2e91PHtdt3hH8p4iD2fs+sT+LAaUUiSrsYd4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Wed, 12 May
 2021 17:31:18 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%8]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 17:31:18 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/49] drm/amd/amdgpu: add common ip block for beige_goby
Date: Wed, 12 May 2021 13:30:14 -0400
Message-Id: <20210512173053.2347842-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512173053.2347842-1-alexander.deucher@amd.com>
References: <20210512173053.2347842-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.245]
X-ClientProxiedBy: BL1PR13CA0159.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::14) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.245) by
 BL1PR13CA0159.namprd13.prod.outlook.com (2603:10b6:208:2bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend
 Transport; Wed, 12 May 2021 17:31:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7ba4b37-8224-434a-dfa4-08d9156bc081
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB23709A7467F12F71BC6D0BE5F7529@BL0PR12MB2370.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAXFlQNkrb/3yWBtrtMKuY0QWxg3B3GwBjhKRyhPBSt8DL8l/1yllWjcBXOyrwiOGLIJpqBPDZxwkzUIKuQ36vKXp5Jk+S/ECcxF9emch3dTg+4T2IbgucvpUZuelBdbj4NBmzyLFxJJwD8DbHdFDYBCRwxWGjpM7FmlyvH1akToHxcq5pNmaTSVmxnMD1PtuArSogMZEWIdT9dK9x94hZNTUA5f68IKpgtpSB0HoPKXbEgYv8jhchcyUmb0HhLqMGV3axAsRVZwgY5LpwEbaGsZh9CgiIFcJQZrfzywH2LrLutht0ZAtAO+164yb8bqHNM0+uzBlMwdrnahmiQXqn9RrL6YhtTUVcdA3n2TffSjgROId077as5dwR5sWo4Zm39czLBT2anTUmqlB4p60lBzw1QPG4Qr3Dht3TQ/p/sBaoVde7hv/Vduf+koVzXiiBMgBQTAlasOmpb6CC+M1TOnnOMmn8bMMM1nB4vT1G1iTTX/K3cbp8p1jfefKs158YwKgBsZmiOGXfG2dHsiw4XXzDE6JgRHdAh+qde64dc7pVUMeggJDqKk8CkeAjGmHc/cYtXbAs6VdjZFwS1JY+SKwTolf+JUxD8yHhSB4c8lEzMIE7+xo2itvXj1afxBgIiWlvyxH2td0HtyA3ctCNrysIISv9EfHYtNls+M9BReZDZWb+QMF1ipIG5AieYG
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(2616005)(956004)(4744005)(6512007)(26005)(1076003)(66946007)(4326008)(8676002)(478600001)(316002)(54906003)(66476007)(2906002)(8936002)(83380400001)(6916009)(52116002)(6506007)(186003)(6666004)(16526019)(66556008)(36756003)(38350700002)(6486002)(86362001)(38100700002)(5660300002)(69590400013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GM/R8UGuudAGghytDvJLDVc7AzZg5fJchoGP1hi0LpSmu/jafoNXBA43l8Sm?=
 =?us-ascii?Q?5J02+DKRTHhImMYjIKvBDLu0ShhGPg0ycF0p0pPmbYkL8XQomyIChnVneWok?=
 =?us-ascii?Q?xdQYZ+SG3L0oQmA21cEJVPrApbU5izNeuEPPWjlNBmbVecLiZ2603+ZiYmI8?=
 =?us-ascii?Q?bnbKmo5yx59eQMiV4RYdLmdqtBM4TDf3r53vqTLbcrOGbyvj+x7R18PS4nOA?=
 =?us-ascii?Q?w1eIlqwlUPyAna/CGdvtUbgI9R1qLrkOCgBAMiIPcgl8QSCrrrBnUk2kq5/I?=
 =?us-ascii?Q?2VsiuSkRZgBRHh6Ld6sStj377JoOBOdjZjk28JK6Q2oMue8LQR4KqRlp0FnW?=
 =?us-ascii?Q?YrXZqkUS0GIUFHD4D1vEI/VjYKyCOW0+qamZPFBL7OX8Xvj88PtXkDxOJ5d6?=
 =?us-ascii?Q?caGEaX4IpKKH+mvOZRbYviC19bTW+buA9b4Y5+Whx/MMNKlNFDlbmOVIul4r?=
 =?us-ascii?Q?KC/bW7eD6bo0wzGWWB990zQ3t1HQo4Xe4e7A2nqHn01fwnKrKUO1keTIrx04?=
 =?us-ascii?Q?JxBn1aa7X7ZpY6ZCgOynujcJeQhIKSFLvlfbmluqa64Hb+34pv7X30ddJEJk?=
 =?us-ascii?Q?bKejsL5frMgziG3AWoMsRLC0x3AJd2zQFZXK3UMPYkWdS6wAQSOwkzMZl7mf?=
 =?us-ascii?Q?yd25TF0RISwxm62RIYjPkpGammoxzqCsHEnXBRJ542A43Q4GcY6Nt00/pxT8?=
 =?us-ascii?Q?ORlzj8H/07fa7dgqes6LcDhZumSFBEaHQs+4Q2VJVI8LEnxq0Mo7QoedzC0K?=
 =?us-ascii?Q?qiEtluJPSi7UVsVONIgkfRFBvpBsvIS5yhB0LGJLLqiZnXaejbgNJoEPNG4R?=
 =?us-ascii?Q?Sh+fkxaZsbolhAHkV5IumxoyAYWqm92BCLBVE9pph4NzA5MtmNk4G9UaFK7f?=
 =?us-ascii?Q?MMRg9jyqIlGne2UqDCs8Z9PBot/FPxM3KCmcAyZgifgaoxIeKxf7ZAncZwec?=
 =?us-ascii?Q?EC54liQd2It704h4XcGNUPIFNlc58sMMTZWrqPs3IfD+p7+96Zfxc1z0zbEa?=
 =?us-ascii?Q?hpA36ekcPkSqJmMsZX8y9+KFL0sx4qfBh3FQLAdKsKQtF5sl6STP64dJ6QGE?=
 =?us-ascii?Q?ltVAT8g4YyuDLoQ3U9AgC+/B4gsxRS7aU1hc1WDIBcodeo0PIkXiYZLXgYoB?=
 =?us-ascii?Q?gT2WpKN6DDVJDcAFsqJiCLWrssXb9LkYlrkzxPQx529NRMxNwO7jueU72yOU?=
 =?us-ascii?Q?fHbOYmTceVfO2L1WO6yfT9IamtbeEUjQFf5p6kYcjvXPKjHiFyXeODqHRkPb?=
 =?us-ascii?Q?cChM49z7QrMpfKcWJLattXfOyuuLHdqrg9XV29f7BiKivRY2CV5toiRhc16A?=
 =?us-ascii?Q?ydc4k5WGTg0bhP6Sjmm/JYgT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ba4b37-8224-434a-dfa4-08d9156bc081
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 17:31:18.6719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h08WIP01I9PXEiAAbnU3Fqlpd3auuS/QwBXekH4iGDZcrnRdZcoRP3LFdLfh3i3a/hU/ldWQJ67hfuixiWTBAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2370
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Chengming Gui <Jack.Gui@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chengming Gui <Jack.Gui@amd.com>

Same as dimgrey_cavefish
v2: fix comments typo

Signed-off-by: Chengming Gui <Jack.Gui@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index d227264a0bda..2ed7f26023bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -845,6 +845,9 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &vcn_v3_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &jpeg_v3_0_ip_block);
 		break;
+	case CHIP_BEIGE_GOBY:
+		amdgpu_device_ip_block_add(adev, &nv_common_ip_block);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
