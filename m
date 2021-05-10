Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B2C43460
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 23:35:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAD5E61585
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 23:35:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAD5E61585
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5BE6E973;
	Mon, 10 May 2021 23:35:55 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BF606E972
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 May 2021 23:35:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPH6mqAMQ8dRO0FgK0YpYDToCej/9S1PC6TlEZt1d/d/OyAXX7sAgwkKV8quW5lhQ+IF/+Z88KRKZUOn/X6WPKNcSejUdFmeakdBb6ytOdy7mYOV1bffOTUeG/pWyiNfPYV2uxmh6fWUi1TNv7uB2PZorNXbHC1+RzDOomWeEmbu+kz+FwE52aNjoIz4Gxeotei4NA/LQ4tNuainMc5qyfWSnqEi6H8WbdyoecFoe3NS6N75mjJqYrC8pszQieZ+xqYm9xKa9/lfClslNk5KDiDOpBsJxhe+zC+3GcQDkgVf3Ry6ilen1GiJfsD9ZYXGDiHNEirngNqZ2kNc9xziKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYsghyf4Pg/ddr0HlFEb90m/orT3noVoDIpGdiM9PP0=;
 b=oHhLUmPHR8qtEE2t+30ViGCYBFp+W+GTE+jDmNTwufj272u2d22IgFpmBEHtTSUGySniOoTl3UyvvXKrFOMwBy1qYafrQ6n7rgigD3tT0vRpaXuOThPDIsP64KSW6PUTVOU9YVZAmfVVT5i0W4T4cPMOLbuB89rHJ2Eba8T3znvvUDa9/ZrbSf3t/qRw7QaV103VlwgxqCGTSkOac4aNoFWZE2pXDpZ2lTw5jRxBqRIoDBH8pMVXHyk+4d/A93AX92GnyBAH4cdEnYz5WBdExsaDKDLmVsT6oBUNDbAOGrh3DK/HdXf9aqY13UHYskcNN+kvSUHMpFa/e5mcWo3Fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KYsghyf4Pg/ddr0HlFEb90m/orT3noVoDIpGdiM9PP0=;
 b=bVjHrLSI6pY94C0MxmtPkaCKT9hhxkYkzxb5UHTFqCQ0KqPec0ub82ZMc2IoiMuacPKfTtRoL/r6f23CvfPd+DRT5lx1D51dM9gJicntO/ltPt9TJ688iB6f1QOurRYOGfIMyXiG1txvif4Hai2PDMa4q32OxCG9TgqcJsj+7Tg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5050.namprd12.prod.outlook.com (2603:10b6:408:133::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Mon, 10 May
 2021 23:35:53 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 23:35:53 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: Albebaran: MTYPE_NC for coarse-grain remote
 memory
Date: Mon, 10 May 2021 19:35:28 -0400
Message-Id: <20210510233528.1633-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210510233528.1633-1-Felix.Kuehling@amd.com>
References: <20210510233528.1633-1-Felix.Kuehling@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::39) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTXPR0101CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Mon, 10 May 2021 23:35:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c4709bc-9108-463a-c3e2-08d9140c59f3
X-MS-TrafficTypeDiagnostic: BN9PR12MB5050:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5050998E9CD39AB2D91FEBE592549@BN9PR12MB5050.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N6zIlL0g6rPKtz30EBbFJGEzRyUKyW0hEer1Lry1oeBLPvKFrKkSPQAKQgCTo3JB40VvkkMIQiyUbIFv83yKogj0vRBmj0UNe7wcLk5paxY69GUOxJ3pLOalu81hH5Hg1VPHIZWYSVhq6xVrCGQYgLanNIzkVr2QmvPze/i/3bi8feyrnHUCc4AiEKr+05UHmm0Y1JOnKYqZ875xSCoiueHO/ekmvcDYpEJdStxh1bomp/RdWnk8SJX4SKvZcnaWNMR6jE6U/ZRo30qqQzDpavBs7tPQYRUUVijTqhdJ97kyRxrN9ClxgSEob/Cb8jjCEEpBhiQIkN2AUF+SwaPcor5b4yCpfg0NvZiP7AYuNk5bCSOGtvCvfXt1lBcNrc3lLzsk3Kp3VoF5NsMQoVrJqK5/qHTK5QTTe+nvGzqKm0X67YERxOIJzmUJSkSMH+n/E3Wbu7TNsKJIb+IlnoBtDLltLiw01T1nL+jERNzHjEq39wqr9tnjwJ3Qq8f9W/b47/PCDx+bX2GwBMm7/ujeP0nqA1PnDpUkkSMjXzBDX8aBv+BKLT0dYkunUoXF73PKDLmieNjZm3JRmORLVABIyRGPB60r3VUgXeRhK6eG4EhPc8CBvPNGTKrQPc08hbOn7x1UypeInmvDczSJTmKXnHToKu9R7yAKcdt70ZV2+wU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(136003)(366004)(346002)(39860400002)(52116002)(8676002)(7696005)(66946007)(956004)(26005)(66476007)(83380400001)(478600001)(5660300002)(2906002)(1076003)(36756003)(8936002)(6916009)(2616005)(38100700002)(316002)(38350700002)(6486002)(86362001)(4326008)(6666004)(186003)(16526019)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gB38wfSGQc0EG0QD1I9bMAKTdpXIEJUBZgGKzpxETT3SK8jRUGqRjRYeLA9I?=
 =?us-ascii?Q?nT7Hzy81zNBBajTII1XVgefbXHjZ66AHFB+pU7xav5n/XPlKWJMiYGtrbVjD?=
 =?us-ascii?Q?W0B+o36jzXk/Ic7UG5xbMZAR6aQ/WIO2jckG2HgXityGqGVSaHUiD8BiJeUS?=
 =?us-ascii?Q?mF3MrlsBsR/WyPurXfwPVlhDhQNosrCbzWRj8QGMgScG3p9Jlag7N/lH0dwn?=
 =?us-ascii?Q?qiCzbLZqa7f6HeVCuh+g4Cky1XA1VTzkp9baufyPnRm3NGtm98EBIAwum0kS?=
 =?us-ascii?Q?yKr2xkJ8DzgoafF4PmCMtfVleCJjobmAYevH2ENYvKsshaICfB0hM8nFuzOI?=
 =?us-ascii?Q?Crz3bkCAe6iNeOo6ZHW4Tjc6wPlbsWdneNl0OhI49Yd+62Zir3p2u7NtH04n?=
 =?us-ascii?Q?bS2sbmINAmTCbCDjj5JtrO+M11q++9Qn5LikBWyAVHDzI5eCYB3hNiNr2Dgi?=
 =?us-ascii?Q?L8D4bVWwtwTQok4mZ9nH2yExcdf3rs2oK9aHTk1ixXvgcEm+TF/m3QzVCMuv?=
 =?us-ascii?Q?t+Cmsrx3PpsvraRHeBXYrvkvyeTjPUBHQVPJXyUqcT3ACYl6DHCr5yOuXQup?=
 =?us-ascii?Q?rqU3kIlMErdorPrR5I62R+g5eebxJ8QcSwfZehZ7axfGE4+YlUip2XSfT/gu?=
 =?us-ascii?Q?YJeB1atHSTIjPJJ9xYMSpBhTYqTdjHoIG+npJrAuPlLVVIAaK3eVODSHNhMf?=
 =?us-ascii?Q?fcHC57VJJKgbMYH2YU0XpLlraboNOjLhbf2Bhz7yceB+96IJotEk0AzcExBO?=
 =?us-ascii?Q?UCJX0ExR2iGLQWDKH9jPPYRy/IR189FmPSETfVdmzvO6SsS8SIRbZqvcFGUF?=
 =?us-ascii?Q?r2JWaSIt5HFbRNWXWL1KKGyRbz3oUSKdv0JiBTl31H4IU6cfT4GddwuEVCU4?=
 =?us-ascii?Q?nPnxbVtbQT7BZxZNv45SZFrkgM1sslfFXoNueOH+hGFb10lbfa33ftj5fh+d?=
 =?us-ascii?Q?Y1te1INAW8T83ty6FfvJBf64EOeqbpMlSWdv/RTSRqdgAK6y93VxE/qsNtNd?=
 =?us-ascii?Q?r0qokV+QgUH8VqSYc+UUzgsvRzdzPhDno/wh/phH86FCywMIfcvDgwSMd9xd?=
 =?us-ascii?Q?trRN2l7aFyp8Ch3nKm0NWmjFDNumjcYuEfCh+tCApt8HvTqC6wQJqhdq8dL6?=
 =?us-ascii?Q?ovdzGBjb+uhwRHOKtmogKwJa1a0zoYNFsdwP7sHh8m4al9xeP3U4+yZxs2Tm?=
 =?us-ascii?Q?egBGIaZ/+fsZTwNxUOGBaAiktTdAeaXktkAS/uib5DVw6ddUo57kMv2dKb60?=
 =?us-ascii?Q?hgHmnNTkME4y9y5Qr6aWBwlBXecFaV2SJ3KPckYGl5McAT1UhaBBayHMPkaQ?=
 =?us-ascii?Q?5pQIC5b8DjwL76Gew7fnSeQ8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4709bc-9108-463a-c3e2-08d9140c59f3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2021 23:35:53.4052 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Cb4BCTt6+wRnO6zaiZhZhhAQBWvvk7Z7Qr+LecIewCkocyFeOjkSXUtbJvn0r3df/9nbuN0CIfsusB+jVBAmzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5050
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
Cc: joseph.greathouse@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

MTYPE UC was used for a specific use case that ended up not being
implemented. Use NC for better performance for coarse-grained memory where
cache coherence during shader execution is not required.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 941a204d28f5..93ee569f6a63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -453,7 +453,8 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 				if (adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
-				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 				if (amdgpu_xgmi_same_hive(adev, bo_adev))
 					snoop = true;
 			}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b11f2b364bbf..a1b1981084fa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1034,7 +1034,8 @@ svm_range_get_pte_flags(struct amdgpu_device *adev, struct svm_range *prange)
 				if (adev->gmc.xgmi.connected_to_cpu)
 					snoop = true;
 			} else {
-				mapping_flags |= AMDGPU_VM_MTYPE_UC;
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 				if (amdgpu_xgmi_same_hive(adev, bo_adev))
 					snoop = true;
 			}
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
