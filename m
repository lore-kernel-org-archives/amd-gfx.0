Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E6DC4361B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3659523B1A
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 17:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3659523B1A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB6816E037;
	Tue,  8 Dec 2020 17:31:31 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 375DC6E037
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 17:31:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SY42u4OZslIYkbOSM2yOYSCZDf39i4xS8dPkBOYjFtcRrs9A72DSmnjEvC9MbTQjmJ63LUB/2to5ITa9jNMYz7uT6oSvZ7iyv2e2nQvyA+rPoI46vaZW36rfov8n6kKAfMtMBTziTPi+LA6JMVUwQneXyHTlQp5ZTpbTv+lBihkVb3iXcYs1MRpIabEwn1BTgaa3PNa/RAvvI+XMW3NqicG/YVZCT4HS4aVwEuW02BirKjpyWOXEjVk1J3okTM3N01wS7rbHby0kl0tkm9uzpi8KAO+vKTHh7YwBHN+U3FDTsmxdqtrKZXLpZ5p3SqkWmNVAkuVB3IDHcCzcLC4pcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD0wTg87Yno26hq5/D1IGQg8Y+J+V2AFDLjl14f0pHg=;
 b=YrvtZnXrVTuH/ISoF7aKHooKs7cSz+Y/15n+gmuCenYHbTHbyUM3FAlBHjqkhL3+RqCtnIoiHRNcgsDnncc9bCJL9Celf0sY2QuG1d/R2SJroQ3hwC9IzAus87FRzR1RSlcO4xKB+jIJzBtZc1s6q+XvhdOyf759xHiemjLiPwSQZVMSBEn1O07NMf675cDtTZdKRxOSmfKLLVGdxXoyxq4yz33WaoC5S83tdSJlVcr3162J7Luw4TuKSpSbUGBpacLezCazeExIqW3RQuKcT+6JbNaVHViKgEisllIPZAtSg6igiPINGJq4UH45dzc9kvh9hPClRFGzdY+hnS5p/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WD0wTg87Yno26hq5/D1IGQg8Y+J+V2AFDLjl14f0pHg=;
 b=AZ9EvEiVlsrbJFaUusWsCkGjXauuMXpT7eBBMO/k2ehxxBKNGKQpjJBwbZjqaXonihCQeZK+BbShmKk7ft01FvNZ2OMsgGEWOX2Jl83iqAaBOD0Z05PpaJJhkTTEJ1iKY2Ibp1J7efSdidPXQfey5TOIZOG0zK4W9m9yBx9XjTw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4955.namprd12.prod.outlook.com (2603:10b6:610:68::22)
 by CH2PR12MB4972.namprd12.prod.outlook.com (2603:10b6:610:69::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 17:31:29 +0000
Received: from CH2PR12MB4955.namprd12.prod.outlook.com
 ([fe80::5115:94f1:ed86:fcee]) by CH2PR12MB4955.namprd12.prod.outlook.com
 ([fe80::5115:94f1:ed86:fcee%9]) with mapi id 15.20.3654.012; Tue, 8 Dec 2020
 17:31:29 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdkfd: Fix leak in dmabuf import
Date: Tue,  8 Dec 2020 12:31:13 -0500
Message-Id: <20201208173113.465-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To CH2PR12MB4955.namprd12.prod.outlook.com
 (2603:10b6:610:68::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.12 via Frontend Transport; Tue, 8 Dec 2020 17:31:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 916e7dd4-5831-4aba-3dea-08d89b9f192b
X-MS-TrafficTypeDiagnostic: CH2PR12MB4972:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4972CBD7276DB18FC58D5AC892CD0@CH2PR12MB4972.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Je9GVNApBcYIdg0+WpeA4ufWDN5vwuWp8sxmnXik5gJWz7cIvg4KICJ0o/4QD+N4BN1EpZp6FGUBSdoM3VRCpQ9EhXosZ+mU+g90Ta1cv454055lVgB/9iPuYcjY/x99JyKTWWhkxGyfnNqjKty96GN1oqQlIWxrKXLyT5rGNGA82CVivpU/lW/D2ShippN035EvtIhcGdiUsD/7+7604UEi4f+gELwTda4soAQXjXb9Ar1B3DZPLJkF3ksw1s7zezKo6fvquzOC7RfDhH2KnfRo3/kCEPkIvsuRm54VCj0uSXzme8Qih5V89CZwE7Pv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4955.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(136003)(366004)(39860400002)(396003)(346002)(1076003)(26005)(66476007)(4744005)(478600001)(2906002)(66556008)(5660300002)(6486002)(2616005)(16526019)(86362001)(6916009)(6666004)(52116002)(316002)(66946007)(956004)(8676002)(36756003)(186003)(83380400001)(8936002)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HcBHuWTTvdfCOEqljX5NbhGHJhPsJySra/uZwrkTUB3v9l/21lddVcScuj2x?=
 =?us-ascii?Q?Zp8Sv0K9YkTQCI5nlH9Tmeo8WkvzjakSRzP8ndTR9Kc6MPm+BinyVHUxYNGY?=
 =?us-ascii?Q?CLVLCukGB5cONVlmiToHm8JeRaD04vbq0XNDmXIXU+gZHXK1Y5qMumpmoh1h?=
 =?us-ascii?Q?/ikaw2/ce4e+p6ObYrq3W9/izoQBCawltSilXvJNUCDo9dzTCZd47G5xtK9u?=
 =?us-ascii?Q?l0uz9ONmt2FjgHA1YqJF4j+egk+RHngJUHzwbbCSgp9vIY6PoBOXf2SiSdZt?=
 =?us-ascii?Q?chcLrg/o+AjoswGQ8dMw0tWXDcy/yr0gVRTeeJ0C/r8Pc+heBAnlI5289F4L?=
 =?us-ascii?Q?H3eOyCwAFVZQf4lfb5pEQf9EmSzb8uvpVtjTXr+e/ZPBXnvnvtdNEx2wWrKp?=
 =?us-ascii?Q?7rAuqbu7hBR2z0s6JEyCwx1DwIiaC93Oo5jiIJJqmsVIk70rmwLdG3BWLpm9?=
 =?us-ascii?Q?wVLShHDabdrryecZIPdYHHxEySGinhxmkclxnY/N8GMqZxrhHk0iAyyepMtc?=
 =?us-ascii?Q?q0igTjcK07NJKlrmjsHl/AZ9AMlhEw7UZFnmhUuTsJeoTredhBL6zABTRS6h?=
 =?us-ascii?Q?ULlcfmG9K8p+AGvGjFvJbnoptbKSv+560yXt7Jeetn6ZZJA3GiKXW6W0ef4d?=
 =?us-ascii?Q?+vRwJ05fPnfjW8qidXCn8cve1G+G9HciN8XaL6u2ZlZ9ilXTt2GHROH4I8nD?=
 =?us-ascii?Q?I68lh18B6eP7AVhMebCJLUn2R2j6/nt6Xy7xl2ZsfjFzK0XUP5ecjYK/PsLJ?=
 =?us-ascii?Q?m1pcDe/rk6AeHlwYPKMgGgLFizrTHMqZVR0lJhUPpHy1pltpYycBk9GWIBMC?=
 =?us-ascii?Q?+nPEY1Fz0s5RuR3jqrsTfC9b+sV4VbpLpD5oz4ZCInsOHGL2LmO+Y38rmkVV?=
 =?us-ascii?Q?H5JitLp0ja7ZYqQeJqfg0sjyeOd++hAeEzf6uhfdEdNFczNrw42XVaL5cdBh?=
 =?us-ascii?Q?1zOAs34p26BKmKcV1nejbrjX+yfigVEgz+hRhrbScJJ7moimANUt0UBr44cZ?=
 =?us-ascii?Q?ch45?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4955.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2020 17:31:29.5801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-Network-Message-Id: 916e7dd4-5831-4aba-3dea-08d89b9f192b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hUdsQi7dYTJXIwyKN3HAhxUEGAcjRAoKmIIwKxQFB8ewyNXrHU3AYq59mW4j9pzvHr2fLoVHG6Xm9lrh2wSfEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4972
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Release dmabuf reference before returning from kfd_ioctl_import_dmabuf.
amdgpu_amdkfd_gpuvm_import_dmabuf takes a reference to the underlying
GEM BO and doesn't keep the reference to the dmabuf wrapper.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 222f1df1a6b6..8cc51cec988a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1736,6 +1736,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	}
 
 	mutex_unlock(&p->mutex);
+	dma_buf_put(dmabuf);
 
 	args->handle = MAKE_HANDLE(args->gpu_id, idr_handle);
 
@@ -1745,6 +1746,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
 	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->kgd, (struct kgd_mem *)mem, NULL);
 err_unlock:
 	mutex_unlock(&p->mutex);
+	dma_buf_put(dmabuf);
 	return r;
 }
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
