Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2252EC433ED
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 02:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB39F6121E
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 02:23:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB39F6121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A898800A;
	Fri, 21 May 2021 02:23:15 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D346F5A8
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 02:23:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLcNi96d0Nu1OwKTzmyIgy75w6BJ7mVCrEExMbIDW/e863jqmieDA6KnQEUeX4AMwkYSBZTT70tyBO5WRUD/0hMuqosnp2oMtTOeVafS/X2LtOWsWMQUSpCEl8GCgFKZWDazZokYSMBa2gAx3DhilyELx6F/lDq+fJCHxkx9WnXswGQl7eFfY/7c1kbbkKHhOLCyFAIkvVR9Qvf9u/+RJZ8dN7uOBEcSH5PGJ3VE/7j/M8Is/A59VYsMpyMKcDmuY52dNQsPew8bJ0zx+3svWdL7JLAmrLHS8cMbELkq5i72E/4VHg8sF8FVJdMr0Lu20T6LUsjT8FsWEdMJzDRY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Kyqy77reJ5Bb4y+8xZCF4MaurANxQ3+pXKLISNN6Uc=;
 b=DQvIO9SYxFiV5j/hOtRQqLEmX7/Fy8/kF6U0zSjLn4ZWaw4gjw+KIbJ6Rp7FKs4xXZfP0Z3MqptgN+dQCaaJebne41d5HwRPQXguCYQSKQCNOCtMe51VTyfTg15uuNCUc55NXbfnBQ2hUDMn0y//AurDEn16X2vi+x21oe9DuoQPdD6/FjrTfP9Ye51fu8fv9bdkNLFzELq5BfvovPmZAwNLFbZ166ADhg9AKmMKut+QcSfBabMZCfF0xIP61TuE4KXPFSGQxhADSm9xph9uTQfPp+idFiD/5r1nndOYEGxN4w1VaY0dUAo7WxKeupTjHTLDK/btA8DFJ/VFZah18A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Kyqy77reJ5Bb4y+8xZCF4MaurANxQ3+pXKLISNN6Uc=;
 b=ZJCfeuPWTkZW7IjrvkP9udU9DepNXykp/QbaZwfPD7cQ/hAdMSrUyR/9ClZ2pyuUn3blUCvZdvHMbPnxcZfwPpAtNFtGb7H8eJj7rEQEruRp6EE146jpsh+Nv8pq55SIefSM66TZnFurFKCrcgFfJBQ9Vf8j7hi+zzcLPoQLQTE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 02:23:12 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4129.034; Fri, 21 May 2021
 02:23:12 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 2/3] drm/amdgpu: Use preemptible placement for KFD
Date: Thu, 20 May 2021 22:22:55 -0400
Message-Id: <20210521022256.14184-2-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210521022256.14184-1-Felix.Kuehling@amd.com>
References: <20210521022256.14184-1-Felix.Kuehling@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::15) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTOPR0101CA0038.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.30 via Frontend
 Transport; Fri, 21 May 2021 02:23:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68201d05-74a3-4442-8eaf-08d91bff61ed
X-MS-TrafficTypeDiagnostic: BN9PR12MB5049:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5049AD90E63FC3C09D852B1E92299@BN9PR12MB5049.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aV3VksFZ3GhD+rNqqL7CM9/jhLfUSHkqhZbJz+90fG3WqCL1W68xD8ERyGKxCAugz45GjdsDDrIAybcxD6ZsNkdAgzOUTNYVSN22BrHaAQt31yvUxJcf8n1X/dZxDZF2WfnP4twAJGHkRTR747dCpfR+aAckveekbQiEnCpV30mNeRYd1opiCAx/91+qhNgKLC+3kejXBU48jEQsqd4zaw5g31eWzvwRWNC0qRKHk7N3m7yXLqG5af4YqTJ5YfO8wpUxF0i4IIZBmARyMtHt6ESpA5S+nvD+koxc+O+Srzq10C5jDXPqM0iFel+seKWIoCwzIk+5e0AEuGIhbHWujk167B/3v1Wnd82Hxkl/UH84yGh1NiAoBHLGdQSf6AdxTQEQTIPvBHJxZU3mC5P+1wbBHP5aAuDl++atTQADIRW5TX1tYwk/aevxdPb/VBU+eSKh+cVwMi+Wnx2qK4bVZeBxn3KVRB4K+UMQst5ik/Ny/0ayaJDFru0aCoBxRLj7Q8FeOe+BUbcR1InVWKKwOnk5qRW2RVKXgX05VJvj4mALTwxA5khm71XP9wz7JGXwXHWKJaBBs2JEdKKqWFjwzCg5ZOSEL4MWG0fyDI8oHNqACobgi/GEbDO3XuVSPXxiTihtoOLAOvc9bt5pZRJPTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(38100700002)(36756003)(8676002)(2616005)(316002)(38350700002)(956004)(8936002)(26005)(5660300002)(2906002)(6666004)(6486002)(1076003)(478600001)(66556008)(16526019)(66476007)(86362001)(6916009)(52116002)(7696005)(186003)(83380400001)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?7iMSDAf+3LNy3SrGvsmJzExH6VbR3lBdkKH176fenPx8Ntp8O9BbHCOr+DAf?=
 =?us-ascii?Q?8WLRxhWKiAdj+LEXcyns62NW8nMEfepTEGgFqnVoiBy7Cf5k9xA1JH9jkgfw?=
 =?us-ascii?Q?3NPlRtEGcUablUpqA9k4zMlk/A7VjPtRbxHhiIi5HYqI/qcnYaLi78S9nQfN?=
 =?us-ascii?Q?j/waKGYNHYNVE1rdBvMoIHZQlhE2kWSGg4LBIf1LfRqnwFLrbMcczHwx7Bkw?=
 =?us-ascii?Q?x2t03kNDdcgN3/5N/MI/hf2KQuLD/NAGkzZFesl6l38JsZHwyAO3fc+3LX2K?=
 =?us-ascii?Q?PILHernhyfM27TXUtt6YafQLE0oR9OeBXqTKNug4fO5X70esGIbRsAT7K05h?=
 =?us-ascii?Q?o8tMrb7sn8y0ZswvdrQ1zQJ8tz6u1/vFBURkvqYJ9a15Ce/fZ667oZ2D4GMK?=
 =?us-ascii?Q?6JKDQflKd3PCgLjX2bA+6s1MgpaD+GMQWWBONg8jWldXmXmF5ULnXvUlmOQB?=
 =?us-ascii?Q?6UPE/3HkNP9e0onw1Cj+5NoiOu9X7SjffqnjLPCX2FAlwRWZ3pftxd/7z6zX?=
 =?us-ascii?Q?dTogmn6jHsvV5N4+IhrzDDrCpS1FhuSFfg4WLc1AxvXDckjg3XCRsBhFDD+s?=
 =?us-ascii?Q?bafS5NG21yL2TuSReIIp70Fiy/3VGucG2D+DM19J8CIn3hfYysveOljlh4Iq?=
 =?us-ascii?Q?3ho6ERMEAHHtOd0cimVB4oWIs4S/dpxLt3OpLfoQZG8rlLK5YP/ZDAFzerQC?=
 =?us-ascii?Q?SnTosfcABrx5jejWzrElGVyNOVWw9UU9S5d1pk84tEqSsIIoAjDJCMNc4Uvi?=
 =?us-ascii?Q?mEJrQelcDVjNJVKhH72TWyQRilwXMJ0a/5m1jLJZmusxf/IzNmNs9PCmhfDN?=
 =?us-ascii?Q?oYGlpTb3MP5hk2W+so13O8Q4vg38PLTIVM3os2vCkfYyOGc9euhNJnKdtBm7?=
 =?us-ascii?Q?FUEbPswGQaeviWkOERwN/soIIfQ3x4cW0K0YSa10SAJFNCJlQZMWS7TZ7WWw?=
 =?us-ascii?Q?Sn7dv6oyGY3kBr0A3bBeuzeOXa+RMYJpFTbH0De5FP+wkCjVt3pg9ouYhB9W?=
 =?us-ascii?Q?GjOsmH7dR/JLxR5goLmKQfIAUUvmLk9tehpYf7ofykFoWU/YWyIMftBjolGJ?=
 =?us-ascii?Q?qItBKjMx5V+KHKRitJx0ZPejgwnv54BupWi+3/GfGvOnmb91AzaT86MyiCBl?=
 =?us-ascii?Q?g4AliiViR77Wz61YKqwCQHS+LWYeGG8lexaUIqUz4i9f029lwFUhnLOsOgPJ?=
 =?us-ascii?Q?HfQRIkXCcq2oo4IfxKciS7HiFq1Rr2HKmVNZnCU981lOzBk2jD2RLvoBIIrm?=
 =?us-ascii?Q?X8IPgMnl5EBGY4QcbY3pYvqmfqtwmVb9zqnZcNFdAdxjM1hq0ozu7IrhoS71?=
 =?us-ascii?Q?0fpZyqSnthI3rXIAQlUlx9xZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68201d05-74a3-4442-8eaf-08d91bff61ed
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 02:23:12.4339 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glY4gZ9dIPO7J+v71+VGlBceCLkyqO8rjTg6fwEitcRrOOALfevPqmtMkFoVbiifBFF3b2d1zDuSdruWQysCPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049
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

KFD userptr BOs and SG BOs used for DMA mappings can be preempted with
CWSR. Therefore we can use preemptible placement and avoid unwanted
evictions due to GTT accounting.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 928e8d57cd08..2b8b89535198 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -621,8 +621,8 @@ kfd_mem_attach_userptr(struct amdgpu_device *adev, struct kgd_mem *mem,
 
 	ret = amdgpu_gem_object_create(adev, bo_size, 1,
 				       AMDGPU_GEM_DOMAIN_CPU,
-				       0, ttm_bo_type_sg,
-				       mem->bo->tbo.base.resv,
+				       AMDGPU_GEM_CREATE_PREEMPTIBLE,
+				       ttm_bo_type_sg, mem->bo->tbo.base.resv,
 				       &gobj);
 	if (ret)
 		return ret;
@@ -662,6 +662,7 @@ kfd_mem_attach_dmabuf(struct amdgpu_device *adev, struct kgd_mem *mem,
 	dma_buf_put(mem->dmabuf);
 
 	*bo = gem_to_amdgpu_bo(gobj);
+	(*bo)->flags |= AMDGPU_GEM_CREATE_PREEMPTIBLE;
 	(*bo)->parent = amdgpu_bo_ref(mem->bo);
 
 	return 0;
@@ -1410,7 +1411,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR) {
 		domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_domain = AMDGPU_GEM_DOMAIN_CPU;
-		alloc_flags = 0;
+		alloc_flags = AMDGPU_GEM_CREATE_PREEMPTIBLE;
 		if (!offset || !*offset)
 			return -EINVAL;
 		user_addr = untagged_addr(*offset);
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
