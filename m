Return-Path: <SRS0=nJCL=JS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06435C433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 16:36:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909116140F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Apr 2021 16:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909116140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D47116E9CF;
	Wed, 21 Apr 2021 16:36:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 953476E9CF
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Apr 2021 16:36:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4WrhuSB/crmGwj+2I7VALCfg+CT8251vOvF6URu/ePZVI14RXikWCWl92ejyvL/Qx/Joq/6W45RR17573NHza2V+A+WNspcguOvZPpPrHzE57xQq7vhP4S+s9mv5yXDlOM+0uOoHrfjY23lHCxXZemFAnn3WJAnlThjve3qqEq7Iasd1moFxR6ogGt5ZL1tt0dfEYCba7XgQVkXb1x4rTzi1wr78I57sss9S4vxBW7mXk6NKl6hniTX5i20PMaDcbhw3vSWNF8iByofkO/b9jSLnLnJPm0pO7DcgWgXf05UiDs1Zn3ntpMT6FdZRcuOgtyQb9lWHeQkZ0XSozgndw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItPdi2+c+Z8uU3FpsIR/msd9AeTGTqNQmzZw7K2eOik=;
 b=UvSlFQBkz4d27bPyot1WfDPDskDGC2/agTQQr3L9H4dce7xFCZQg2ahQBtW8Y/lJmsVDtnvxpe4007IZ9DMiRG48qk/meTfEyXgUmXJVfh/6VWAj+JkfYuYbMu0q7ZWpnGpkkqRQiRU40PK5UTWBwrQPn8v3sW5mmxUQUwLkzwUl2WQV3rcmA3SSGx05VP3FjqRwp0xQqoo9M2pAqEqJRlqFL2zPHLjxL85ATmKx4kTZroc/nA0D0Ri8E7d1ny6jiFxpsI/U/C6ecqV1eOBaXbZTZ2QkEVfBuWc7CJL/+y9V6U1O7VHf0doDXzrrVBreUk3kpwNM8lWNFfFb7MRVjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItPdi2+c+Z8uU3FpsIR/msd9AeTGTqNQmzZw7K2eOik=;
 b=vqPcCIOgRItFEpOS3MJCxnI2K472EoPOIzzzygalcRk9gneeUJTTh7QOOURj3lQoRTnBAMAJyK4uhW+2w6NJvrQfxmMbCCxANMli17iqB3A0K8inwSQToTMJz3NdbFLpwEDbd7weESrxwQI/Mj6HGWOTnsnAELAKKT/YHVYEedY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1576.namprd12.prod.outlook.com (2603:10b6:910:10::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 21 Apr
 2021 16:36:02 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::a457:1047:3886:4630%9]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 16:36:02 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/4] drm/amdgpu: expose amdgpu_bo_create_shadow()
Date: Wed, 21 Apr 2021 18:35:20 +0200
Message-Id: <20210421163523.14493-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.111.123]
X-ClientProxiedBy: AM3PR03CA0071.eurprd03.prod.outlook.com
 (2603:10a6:207:5::29) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from linux.fritz.box (217.86.111.123) by
 AM3PR03CA0071.eurprd03.prod.outlook.com (2603:10a6:207:5::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4042.16 via Frontend Transport; Wed, 21 Apr 2021 16:36:01 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff16081f-d424-42aa-08cb-08d904e38d50
X-MS-TrafficTypeDiagnostic: CY4PR12MB1576:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1576F49C18A8B35049076D1F8B479@CY4PR12MB1576.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTuWG+gVD0tiMHZZGyatR9Z/immTfB4V5Jam8PkrWvHBPBhIaepOUnrz6MS0nzZ0Jcxs2OHf2vqBJHvxfl7xd524BTrpRH53SUgPwqh7nw1mql1tG0VMxx20QogkOhxWFECoXGvLuPFVwqKEopn4NqZgbRPJsTTrorPf7NB4Wtd+2iu3SQKb3MbeTIy9J07uYk3VzdEpDDJx9YhkS90TVeP3Kb6nmh5CYNRewGHkZg4AUkO9DCdB+x+izKir0Mjb8o+io5UscwpL1yRYKRl9Dlarc/TvtCetvQhU3PWZybLwWJYe2xKwXPEjdZuPpqeON0iebTynzFeW36FO8puSawxQ3IIvSlkYhOPaS/dMM3QJ3o4/tjsYbxOW2JYGJRCGe5zJV3YekWOgXmj0xZimjN+mvbwzd/zeLCxabQyorjr818Afw++ADuWX/TO5Yj+QoUS2737+Ig+Cd+c+m06j6WovU8X2AzCHixNffDwFSGsndqqHMLOuIjnCyJWTmUOwUHVCAZP2k5Azd7dt2vKyTEzX7CY3tV7bcHug0yEot5umJza8mtUFaT+q08T6/MyUWcabnx8KiKHcdzy7J5d/6LoTSdBFYYxw+RZ2KHGNuCk3xWTK7lt0EgTiAwGLzItUffNADc4eNm5r9Nm1jXhm6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(26005)(44832011)(83380400001)(66946007)(6666004)(6506007)(4326008)(186003)(8936002)(5660300002)(52116002)(478600001)(6486002)(6512007)(6636002)(36756003)(316002)(66556008)(34206002)(956004)(86362001)(38100700002)(8676002)(16526019)(38350700002)(1076003)(2616005)(66476007)(37006003)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ZGQT93Fyhikgc5S+cmFJPXGzpO3pAfUQp1TNrup/tHO4naBNJdR8do/Vgb7o?=
 =?us-ascii?Q?B+mwAnBRb7So44dEkk+S1SaseZWoOHZXQMYP8u3Wf8B3026//XrvyUmE5Sxb?=
 =?us-ascii?Q?hXvBvheFuFvhhrsGpuD/2PTrqn0NyxscGMi8Rw3E65JUdERXdwauvvoq7Ac8?=
 =?us-ascii?Q?DqCmTY9+l6MFifb4Uxf9ZXLsxGaaSF6+ADfRVi7AJmTQmDtq5gVY7I+or4Px?=
 =?us-ascii?Q?hguwbCwIoQ7qSNp2cfSb9vTu5vQF3cIN1MZF/yGtY9EpPjEEoQV4PVtEtv4W?=
 =?us-ascii?Q?QEX10v0idBM04ezdjQ7JxjMb00BBsJhKWcOmuTsnHgZ+w8aMyOiTQ5kU7rUs?=
 =?us-ascii?Q?4mF8tYE6BpSFJJ8ZgFUcVv2QVweFbcfyy+Vw4bn+t9QWG7hHL0fTr3fBUUMS?=
 =?us-ascii?Q?Zh30rscnaYE1Npz0TdPg5gTmrrMV6k1bS5bElNliMdOMKczDV/r6a8wj868c?=
 =?us-ascii?Q?w6Cy0eFn313r9IQXEYRlw+yrv8esae0HYas4L8qg9SFTyyr/T71IuqQPxuS5?=
 =?us-ascii?Q?q30WYYqX5QmW1qY3hiV8bYhuOH0SMA/p3mrVZIXcGFS7Z1YBqexOsyS2HSHI?=
 =?us-ascii?Q?uWDlre94lHoJ2hciT/VJu4QeRUJi8n+sHyHf3PT0gSs3xxlfhazvccm+ThvT?=
 =?us-ascii?Q?e2WIUfhj8XvsUvFvL1293av+yZKLzHMzVqBpd44UCjs3pgto/tqjpxYoKvw6?=
 =?us-ascii?Q?I/F9y8EbZI4dMOfMJT7pfVWW55s9IZGQoLZdhnMlnqy4rMqbGfpuoYqAkHJ+?=
 =?us-ascii?Q?Ne2qn9de/9mlAw7cfFTBlgkHfltaYyqkow+HQMCXuR5hUl2pCmH1CPPB4dvm?=
 =?us-ascii?Q?rBfRpQTnpZltNap+7qkeIu9aJF8bRsuYmlXZF+Y19ud1hiWlwy9cJzUslLWn?=
 =?us-ascii?Q?MPIoEqu3/CZwTuQpU84yy/Aij5baD9Y+/SnJvJDPKjLmoq6EuTwz6JZXUJ4t?=
 =?us-ascii?Q?pI+ILsIryeUegnRtKJpEXAFiZir8nd3/sHDWd62Li3PxrXtLJw+Ko8S0SKvw?=
 =?us-ascii?Q?w4ygdvs5So+ZPkR8lNKLVL+JTI0T6oIsqfUbu3qR92NV18VSxlVFjAgjJVP6?=
 =?us-ascii?Q?Xis64zWds6tyJu29Aq1Ie8xXFr0OdFtqRUUxtea5EnfteBv2pHjiFqdSihsy?=
 =?us-ascii?Q?pdnABnLVwN+h3c4uQMXIvN0IJWEaNm7ioIOnB6+CzOEY2aoqQopYNaGvRGoH?=
 =?us-ascii?Q?B4TejEHfK7JvZ4ygmiht+FyePIVdwcMhVQyRnuXktz51p+gY49DeilixFQCG?=
 =?us-ascii?Q?lps7Z0HNrwHxVpqQDqNtLRthfGuZkOJ9a5Wf9FLq7Na9++V4/ngjV/NZv/lD?=
 =?us-ascii?Q?xQgwvvZgx9esznAGS56aSCVt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff16081f-d424-42aa-08cb-08d904e38d50
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 16:36:02.6265 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jDuwZIwfL36v3Y6zjlVkCpsB0PPl72Yry0YRRCBG5ZSrwkPggUrOFSsQMEoH+se2WxrISoPHx1RhbVwlmFpmyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1576
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Exposed amdgpu_bo_create_shadow() will be needed
for amdgpu_vm handling.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 3 +++
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 1345f7eba011..9cdeb20fb6cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -625,9 +625,9 @@ static int amdgpu_bo_do_create(struct amdgpu_device *adev,
 	return r;
 }
 
-static int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
-				   unsigned long size,
-				   struct amdgpu_bo *bo)
+int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
+			    unsigned long size,
+			    struct amdgpu_bo *bo)
 {
 	struct amdgpu_bo_param bp;
 	int r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 973c88bdf37b..e0ec48d6a3fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -271,6 +271,9 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_user **ubo_ptr);
 void amdgpu_bo_free_kernel(struct amdgpu_bo **bo, u64 *gpu_addr,
 			   void **cpu_addr);
+int amdgpu_bo_create_shadow(struct amdgpu_device *adev,
+			    unsigned long size,
+			    struct amdgpu_bo *bo);
 int amdgpu_bo_kmap(struct amdgpu_bo *bo, void **ptr);
 void *amdgpu_bo_kptr(struct amdgpu_bo *bo);
 void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
