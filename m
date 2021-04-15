Return-Path: <SRS0=drzA=JM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848DEC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 21:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AB60610CD
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Apr 2021 21:43:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AB60610CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EE16EAB9;
	Thu, 15 Apr 2021 21:43:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA0C06EAB9
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Apr 2021 21:43:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJRm6A7Cko+iULgNAvf85zm98nMRI945fyafwV8z8nMknvDD7pBw4cfozqmjVw8wLicRC+hxIMCJf7MxFWqFMj/MvXpswx90EGZGwEX4gtoEIbbo98AXJq5W7Ve3Nrm5nhG4gCK7giYTllV6oD/FSilTWQrAsKiehgwQ5qjLmdUeWHgNbICvWFzw6FVEzCqtzCijzBq6nPCTodTb7ZlOZb5ZZ7udaKn3SzEiXqp0gSLhWnDKAxGcV6N4opMsal9YM/h5KX1fbtN/D8rbCbpxC8xaHm/7M040c7iVJx1jsygFA9TqK0iCS66jubmAvhDccOy3+pqpdziis3xzrSsENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggnLaxm6T2eSUhvmsDMFDtbRVmhlkV7qb9uj3XctDnM=;
 b=TOvof1hbgMYcrai2tA/x2CBkh4o0jzwr1aGolGSJnKlhczdD7Op/+eC11YQ2Vi4wPfDZdnLDB0uVdt4hOKjuvUIZDD9GwHuArb9/2MN+5Ojb3FjY14MZ3qSVetRzj3qcTb8sTTY+W+dZABELn+9ajeP5AjGicaifUuA3C15c2laa0joIznJJzZmvSWZ8Is9mx/1G7ZC+TAZUhSdHDtnuIvxikTxRPsLdVDHX+LSxe1S1RdqHWQySuoOy1qo6KN2JoJCXcKorfbzw2TEQFs2P123iMBDzWhhbcHZ8RPdBkE4dr6TjKkO4Jekr4lAuCvIAzpdkhbIhK7J0wPfNCADrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ggnLaxm6T2eSUhvmsDMFDtbRVmhlkV7qb9uj3XctDnM=;
 b=M2uZv2jFhEDjzMAVaebDFz3S8W50I6X94ERH9AcAmo+FrWroSyfrCypKDDQZdAJSWXusmwT6hs4cq3CMl5wdV/tHMULO8B72wd3L9HzNvz4zLR4ImMR+k7QsGC1O/naaGWQqLG38cMrd9rVniznwkf1FeSLFAqDeUt7u5leE/zA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4340.namprd12.prod.outlook.com (2603:10b6:5:2a8::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21; Thu, 15 Apr 2021 21:43:47 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4042.018; Thu, 15 Apr 2021
 21:43:47 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: set memory limit to avoid OOM with HMM enabled
Date: Thu, 15 Apr 2021 17:43:32 -0400
Message-Id: <20210415214332.9631-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0113.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::22) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0113.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4020.21 via Frontend Transport; Thu, 15 Apr 2021 21:43:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d137b27-6965-4aa4-39e5-08d900578c79
X-MS-TrafficTypeDiagnostic: DM6PR12MB4340:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43407E29CAC261A92C3359C4E64D9@DM6PR12MB4340.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AjV3uX/vD8DPO/l1wUdADWplrlb9I6kwhad3tuh+6QJ8gnKO3EvQ3GcvWM3ysoTs3fp2105CNqPRUrQfoXI1iT/2fm6KWVLgw5RXrQSQZNH1g/0YXyVLVOY4JpyXKYCCu590NwIOwEJUipKTFe+UsEFmq5MTPqkBbt0UHBKAWzLYON4JGYTIQJ0WT5PtGMjJI7YsdguCnnAOG2gMNi16CT411yTcYBEw92+BWan+Lj6j0+hePAzx2LtQNGIVGWvHmTLTmP8BV/lenz3HOewx3OVGumRYt5mDrE0comr/HqT7AOPRVVgqkIRPekYTO0UgsGo/PCZfebr4TlKNdZdDGhcj1vi6Ryva+cAB6SdKz/Ww08YSVA1j82EE/MvhF7MI3+WUvvNzwfFTtQrRwctxKyuCeFsJtnBkA3lBH/OtgpxjFzaZXAhb9wQC5u3IcLQNzrMJtKDlTuNsfyUqRZbKbg8DuFy3svzrhFCxRCgFJbSsKwTV4A81gm22ML3+0c1RAlk5IASHs7VlEHZ1NUXHxyHGCyQpT8EliiB9zcEeMtyyJpiYDvjIZJchlPJoUVAKP/z0+XL2ayqjn1iFQ0Sp1L7s54W3Z9AGK/zFtNeiELOPohFcnuTL1dyRlDSOCEXVRUwprJS+98hY3VfoH81DUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(36756003)(86362001)(83380400001)(6916009)(186003)(6666004)(5660300002)(8676002)(7696005)(2906002)(1076003)(16526019)(4326008)(6486002)(52116002)(8936002)(38350700002)(38100700002)(66476007)(66946007)(316002)(66556008)(478600001)(26005)(2616005)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?kOdiR4DV8MZNJel830RNMeIP47GFmzOICKnFW2QYmrK1wz+yX+KCMdX2Ht8g?=
 =?us-ascii?Q?sxoaMGDdFT0yW1ByW8jINFiucUrKbfhbgFjjARVi+6KPCViXQdsli5E96JrR?=
 =?us-ascii?Q?V2iWNqPc1cYz55ci1XDnh5rF8yfYln1pj8gLIEBDCpuNb4APoypieDmVl3QJ?=
 =?us-ascii?Q?a/KFn/A+Q2RjntBeaD53lm7dO0m+4dSDvK9FE+P0bTmO04uJ6wCo4NCxbRdA?=
 =?us-ascii?Q?dOes7w87ogPg6yNoX5uheMHQuEKJPae1zFc1YZhn0Nfuml5vfaKm+TDXstBX?=
 =?us-ascii?Q?ZCwaXZMl9SVHCOpLKfBxcRnQYSxdyTtL12Dsit6mPGH/ig9rDigNrkTvp00B?=
 =?us-ascii?Q?cugTol2+h/FFN+imyW20R/s+zZK5BC0x7queQSELfuLBfboW22SWEHVpiNjk?=
 =?us-ascii?Q?xh9+ynUDcE0w10rG08lbAXUjJyi+0U/M45PY0XFpdPI7an/ckJIbKkS+PA9O?=
 =?us-ascii?Q?83ctDXFpYTeu1II4zfYOGfml2Er4ZIXg2Ip/R1DTd7fUSXu8dM069vS7HEKP?=
 =?us-ascii?Q?MuwaFnnZvLDlc/ElOXfYf2QJdsU3AlEF7VcTm4fKgh6iQWV4yXROH+P3o6uk?=
 =?us-ascii?Q?1T8D+V+0ORExRbyvwkjsicWdLJRXo593F8mwn60k6wlIOZs1iq0Adyiqj9o7?=
 =?us-ascii?Q?dZhZQ68FsBcXMbWFmWHelqKUQ3FEUN1xcnDVDg9XxJWm1cb+uaCO+ck0a/14?=
 =?us-ascii?Q?u6ZqT0oGSgMc06aB8bkZcjxC+qV2KuhnPze+ex1Tn11Ya6Php1bh5pTQ4GFq?=
 =?us-ascii?Q?TruOBAKW07HEog0Cq/BWZ9fshBkMyMRjbSTIFPeL99BhB09yIxWiRqAp+jwK?=
 =?us-ascii?Q?1tY4ZCAiIsVxA84Fxv6+QrBJN08jm7Nav2Op9qjGBaBlCEL/vgfT3psk1wov?=
 =?us-ascii?Q?+M86ev6ZdJuF2WejW6ddBqw26BQ0spAtY9LgEvUHuzSO0v5G/OgHZGy9Yw8y?=
 =?us-ascii?Q?am6htR5SBzfMAloJ4YuTxywjubEa6x//Rpo/K/QGrQIIQOzQpm7C8Ba3S1h7?=
 =?us-ascii?Q?pE0KSZFjFYxDaBhUUb34bOSnZWmX1usVXmrWcQXhpXbVZuItiUh1P3GOtdTy?=
 =?us-ascii?Q?6EVnvtrxUf5y0jM7KwWmab5v4ZLs3KmGUmxLDNIer+3FLr3Fkh7MSooA0Uux?=
 =?us-ascii?Q?+k2klxlSlNvCNSHAUeyYaXbEv0ezsUnVabaSx4J9O2VvvjRrwQR/do3/04IU?=
 =?us-ascii?Q?jHJ1o8iSxNpyQ7xWgtc6BR/QE2iq0ORCopByJxMtGMEYmoB/mwXGRuFspPyR?=
 =?us-ascii?Q?62DyQzEpPBu1bJypt5Mt/+9KbNx5p0HFWjMG9cNcQ0g1h+cJ+noK14NXT9P1?=
 =?us-ascii?Q?MtodIG1LCnLXy9pNwQALpTDE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d137b27-6965-4aa4-39e5-08d900578c79
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2021 21:43:47.1443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzOxwCdNTLk+iDnMi/0pgLt694R0ynnUYym80XlyFVX08LW3oMq3h+Zr2APfpIck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4340
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

HMM migration alloc sizeof(struct page) on system memory for each VRAM
page, it is 1GB system memory reserved for 64GB VRAM. To avoid
application OOM, increase system memory used size based on VRAM size of
all GPUs, then application alloc memory will fail if system memory usage
reach the limit.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 5 +++++
 drivers/gpu/drm/amd/amdkfd/kfd_migrate.c         | 8 ++++++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 025e8bade8c8..2cb7f8c30b9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -272,6 +272,7 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
 void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_amdkfd_unreserve_memory_limit(struct amdgpu_bo *bo);
+void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
 #else
 static inline
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d70a21ea576d..6ea1039b08a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -105,6 +105,11 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 		(kfd_mem_limit.max_ttm_mem_limit >> 20));
 }
 
+void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
+{
+	kfd_mem_limit.system_mem_used += size;
+}
+
 /* Estimate page table size needed to represent a given memory size
  *
  * With 4KB pages, we need one 8 byte PTE for each 4KB of memory
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
index 7d8659517447..1373ce9af890 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
@@ -876,6 +876,9 @@ static const struct dev_pagemap_ops svm_migrate_pgmap_ops = {
 	.migrate_to_ram		= svm_migrate_to_ram,
 };
 
+/* Each VRAM page uses sizeof(struct page) on system memory */
+#define SVM_HMM_PAGE_STRUCT_SIZE(size) ((size)/PAGE_SIZE * sizeof(struct page))
+
 int svm_migrate_init(struct amdgpu_device *adev)
 {
 	struct kfd_dev *kfddev = adev->kfd.dev;
@@ -912,6 +915,11 @@ int svm_migrate_init(struct amdgpu_device *adev)
 		return PTR_ERR(r);
 	}
 
+	pr_debug("reserve %ldMB system memory for VRAM pages struct\n",
+		 SVM_HMM_PAGE_STRUCT_SIZE(size) >> 20);
+
+	amdgpu_amdkfd_reserve_system_mem(SVM_HMM_PAGE_STRUCT_SIZE(size));
+
 	pr_info("HMM registered %ldMB device memory\n", size >> 20);
 
 	return 0;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
