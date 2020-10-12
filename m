Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 415CAC433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 06:14:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD13F2074F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 06:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Pg2pqkrR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD13F2074F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F0F36E07B;
	Mon, 12 Oct 2020 06:14:44 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D986E07B
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 06:14:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axQAwryvv2z+RNy6cuPdULvxEN8IF9iEOWy4170NAWWYCalOnOgGIVNhKBWrxr5n49wVMbMAzASFffhv4NXsuHMQTzK+gP13ylzvcM41iSBq8R93pHw8MVeZGAPCivM9ZcWjSSVPHcgzTMLJHgUJl5NUigwQMLgIuZEt592rodKdebtVjwjuRX2RBhvkh8En9tOYBOdKd1FkAlywdl/wv3G+1A+NNslqs7T5blqdWkCVvIroLQNmt5dLCHxutVQEmR5RdBRznkAq1ld9Hi8W/icERMv8/KA13Z6jeIlYgYakIuyF9tdd2f76aepWTKNx95qTd1q5DROcoveTTP8H9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2sg75qf6ajRUv3BYjGQSSVAPurGGvMP7ZMNrH+xf7Q=;
 b=j5983KN6VwOGSpHvNYc7bdzJLmUdK4GsTM1pbtyT/ftI54YKrO5rDPivUEsvwe860bZdBvf3YdNeUMq1uHnHgKyMh/By6CsnQNZYLIALy9SJsXLLpF8nL2nPCeHFbdk+w9deTYnuH5y5lB8x6mGrp6mz4yzSeOFPZcnbu9mGDfKV163B/wkMaAgeKmMQ39ABC9CK9CfMdGFGOpUzeWHuZ3sEs3Gd2dco6gER/hPM1mwSSMXAG5VW9+SoV2RJoxc03ZvHCTjum5HaQd0Y69PYv1Jo22nKTchq8i7fLB2aSBj/AKpa7xIJZkk0xL3STGiOuHoPHGfxW6g5QzguBXybKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U2sg75qf6ajRUv3BYjGQSSVAPurGGvMP7ZMNrH+xf7Q=;
 b=Pg2pqkrRiUUzJtoejWKduOQlxKNaXfVxciKzP0vp+5sECB3d/8dyjxcua6j29ra8gqqu8z+7aiDCEWrAdbRP2crBKjAXvXSskYV01KBdPtlujrF8p0C4pEhZHWLrcfYJ/4t/tDfay07lqIVAWeuMCcE8m8l2E8IAaqGGPefby/w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB1609.namprd12.prod.outlook.com (2603:10b6:4:10::15) by
 DM5PR12MB1292.namprd12.prod.outlook.com (2603:10b6:3:73::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.28; Mon, 12 Oct 2020 06:14:39 +0000
Received: from DM5PR12MB1609.namprd12.prod.outlook.com
 ([fe80::6490:3d53:6367:281e]) by DM5PR12MB1609.namprd12.prod.outlook.com
 ([fe80::6490:3d53:6367:281e%9]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 06:14:39 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] amd/amdgpu: Fix resv shared fence overflow
Date: Mon, 12 Oct 2020 14:14:14 +0800
Message-Id: <20201012061414.5160-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [58.247.170.242]
X-ClientProxiedBy: HK2PR02CA0182.apcprd02.prod.outlook.com
 (2603:1096:201:21::18) To DM5PR12MB1609.namprd12.prod.outlook.com
 (2603:10b6:4:10::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (58.247.170.242) by
 HK2PR02CA0182.apcprd02.prod.outlook.com (2603:1096:201:21::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 06:14:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 662e0246-1579-4702-2a12-08d86e7619a7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1292:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1292B7EAA0DA30B8C55F871587070@DM5PR12MB1292.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21H2TshHYXFXsQHo7aUwPd038Na78lOFulPaeYPsVdzr1IEzE/c9JH8zJ2u69cQ43+ncbMwbT8YV6GSVjFnWgIVXiix4yNqqhBvRjnja3uqJZyXw+B3E02C9xKjEO/ZDQPYfZGGdAqmOKTor0863MwWespvzChc8hYpJxGB16xacsC1RyT+li1tlnF+Y4ff46OFdmuC38hspK5vqLRw5H/fvhji4YyvVHZTb9Uj3tnFAqN0d9V3HXu7hZf6Iv8rcfUqHx+mva1rpojWHg7fF+Gh4/KfHTPxDmsXFHvw1wFCjwZqBBR0uUb24NamcuoRzcX8UmjyX5iM3BP3hmwtaKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1609.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(136003)(396003)(346002)(366004)(52116002)(7696005)(478600001)(186003)(16526019)(86362001)(83380400001)(36756003)(6666004)(26005)(316002)(6916009)(2906002)(5660300002)(8936002)(66946007)(66476007)(66556008)(956004)(2616005)(1076003)(4326008)(8676002)(6486002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OHbVkt5GQqFK0rqLIiKm0J91TV60T1MaP758OsB7XpabbTp1zM8FQ1gtdNjZQrxOjyy7akef6Y3U2YSECuT0VHX8RERDpi3cIUdG4P0sLtjPzbuSEBktG2oX22i4NR/lT6tzu+tBROqZRTyeoglkRof/jdOJYO9kgXgF+6sHe/IQbiQqZXlClayWYJnmovF64KWZlj2fVglGfGxs8wSlA6zYuSh5Tui1GQYVSz0a7Fgmhsu2x3ViAxG/XCTNrt6NchzntZUoIcupKIyyM4ELnbuXam6GqvUbE/M2Wpk+bmCn/XN2o3VdL/bYj8+uGBlYAcg0IBehduVGtzoJPHN2WqaWqVFzLlT83x+KfqnfNFWEwGZe6G3uSM9iu99Shf31RD8vjt3ymCWLJd5gP8uMDvDhHDpL/gYkU9xjUbKsl+27NqfhUDJ/CmiSm4Sask7klOPwvHO1usYfzWj7h9zaicVnLLGnICOvqZqvDK4RKUUdd461qeUeeVS76NH9/ZA+CPoYQ0w2cBH3gY/mSXC7XiPOeiuQFuibxoRPHUdyZ+hOYxuRkfBIMMTBYL4wD0cfP/wuVfv2FDTNPB9HGHQyDQn+4QBCfB3XNb9MD74j6nq8ySUFL4eroiXHwfVO5qLvB56b7mpkYO6xi4zEdLBnjA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 662e0246-1579-4702-2a12-08d86e7619a7
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1609.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 06:14:39.1765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuD5EXMqVpKUliM0oJWyAHYLBZNzrE8JyHA+FAEwgbk0t7NUn1Iwo0GDcfUkUbqm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1292
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
Cc: alexander.deucher@amd.com, xinhui pan <xinhui.pan@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[  179.556745] kernel BUG at drivers/dma-buf/dma-resv.c:282!
[snip]
[  179.702910] Call Trace:
[  179.705696]  amdgpu_bo_fence+0x21/0x50 [amdgpu]
[  179.710707]  amdgpu_vm_sdma_commit+0x299/0x430 [amdgpu]
[  179.716497]  amdgpu_vm_bo_update_mapping.constprop.0+0x29f/0x390 [amdgpu]
[  179.723927]  ? find_held_lock+0x38/0x90
[  179.728183]  amdgpu_vm_handle_fault+0x1af/0x420 [amdgpu]
[  179.734063]  gmc_v9_0_process_interrupt+0x245/0x2e0 [amdgpu]
[  179.740347]  ? kgd2kfd_interrupt+0xb8/0x1e0 [amdgpu]
[  179.745808]  amdgpu_irq_dispatch+0x10a/0x3c0 [amdgpu]
[  179.751380]  ? amdgpu_irq_dispatch+0x10a/0x3c0 [amdgpu]
[  179.757159]  amdgpu_ih_process+0xbb/0x1a0 [amdgpu]
[  179.762466]  amdgpu_irq_handle_ih1+0x27/0x40 [amdgpu]
[  179.767997]  process_one_work+0x23c/0x580
[  179.772371]  worker_thread+0x50/0x3b0
[  179.776356]  ? process_one_work+0x580/0x580
[  179.780939]  kthread+0x128/0x160
[  179.784462]  ? kthread_park+0x90/0x90
[  179.788466]  ret_from_fork+0x1f/0x30

We have two scheduler entities, immediate and delayed.
So there are two kinds of scheduler finished fences.
We might add these two fences in root bo resv at same time.

We have reserved the delayed shared fence slot during vm init and bo
moving.
But looks like we forget to reserve the immediate shared fence slot
during vm fault.

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3cd949aad500..a737232ceb38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3352,6 +3352,9 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
 	if (!vm)
 		goto error_unlock;
 
+	if (dma_resv_reserve_shared(root->tbo.base.resv, 1))
+		goto error_unlock;
+
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
 		AMDGPU_PTE_SYSTEM;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
