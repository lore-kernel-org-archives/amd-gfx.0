Return-Path: <SRS0=uqvu=KN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4966FC433B4
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 03:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E953860FE9
	for <amd-gfx@archiver.kernel.org>; Tue, 18 May 2021 03:01:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E953860FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 450846E5B6;
	Tue, 18 May 2021 03:01:06 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B089B6E5B6
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 May 2021 03:01:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GejTcejwdzxZCvykEy55H5gyx3uyaCyfJIljHUsXGUm5SI4BzZT4j+IzGkB/f5VX+BR4LDT7AKIIrkEa3P+D1+bRYci2CLan7paBqLibeSRystST8+F0vZ3fhBpX3by5+ylNzqZ0e3pSaqpTllw9sxr1oBIKMCl27+rhO7EQTEZr+dfZVvooxj5vtcZpo4/hPBDtWES8dJi1/lIPtGx6MemyM3EbIPxy79RgI5eIcmECuYKnEJ5XWlDuekkZg7MPSw1jdE6DzPOLiy55EipNtu/2K60bZ9h3aAnHcdjqusE0xfPEX2UMkiQeSYA85bFgUOJneAYR8daR7hxcQ+/OzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kksvRII4JesYcSvd8zm1CjwYJr/ePl7yrEMr61EuwN8=;
 b=k2OWlkxfullIxpjUpucd3wAz/GEfPTtGId8AZdWoYORxNT7by6y4sXqUCaCkk4/8lB+y98V5aLCr8nuu+cdJb6OSQOX1JOFboFhu1M/H0B8r3JKnk75mgBSMhLpaiJVtJqP2pWtH44Z/7/63Ff9tS7abhGAqFMY5Hnvp0PUpO2JbOD9BRdDLKC6T/5UVuVJlCRWn+PbBKP6WWdz3T7hrrJa06/BBuIe6joptPWVSjbMre4+EXxN+rzDPTGZ7ifLX0+jAXE1pcJ2shw+gfA5sAP4Y+CBA5qUjs+WHuxj3SgwZk6uix2BCyCThXp37Exfc9abn18YsX+FC1oGPUrosNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kksvRII4JesYcSvd8zm1CjwYJr/ePl7yrEMr61EuwN8=;
 b=TlMUWB/NCS+ozqXJ9uu1JddrtOgZl85ZYX486jPG83VD/bUiB9vD3gPjonuLIYW/X/APQF436va5mdegzJbyjxki25mmBTO1PSkKxNplPrYJBSipAzLmyi2imIY1w97+ad/pGtrGYlkai+kP75y3KqssrpnqZ6vNXJp+3HK8acU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5165.namprd12.prod.outlook.com (2603:10b6:5:394::9) by
 DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.28; Tue, 18 May 2021 03:01:02 +0000
Received: from DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d]) by DM4PR12MB5165.namprd12.prod.outlook.com
 ([fe80::4543:6802:6acc:c92d%5]) with mapi id 15.20.4129.031; Tue, 18 May 2021
 03:01:02 +0000
From: xinhui pan <xinhui.pan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Fix a use-after-free
Date: Tue, 18 May 2021 11:00:41 +0800
Message-Id: <20210518030041.2228-1-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.134.244]
X-ClientProxiedBy: HK2PR04CA0070.apcprd04.prod.outlook.com
 (2603:1096:202:15::14) To DM4PR12MB5165.namprd12.prod.outlook.com
 (2603:10b6:5:394::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-server-two.amd.com (165.204.134.244) by
 HK2PR04CA0070.apcprd04.prod.outlook.com (2603:1096:202:15::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.32 via Frontend Transport; Tue, 18 May 2021 03:01:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5496e154-845a-41ea-067c-08d919a92ba3
X-MS-TrafficTypeDiagnostic: DM4PR12MB5296:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB5296A6D3D0B78108581F9120872C9@DM4PR12MB5296.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: InNRt63CexVG6Sb0RGl5gikZSiATDecrKG7R/a+sIqVTBGQzbtrn/9o+W2U0f10q+yJD45lkndQuvZc6GBT7L5lTdRavMKlXGeldmysMABXBgaSxEOFh1fWOurpJDxmGxhkfHXEsWbc0dwajgvtvXvm0k01YgkY+vWeSqcNTZTBB0FCOIyRM1CcK7BE/3aVOpsGIzdyAqC3aq5G7IEqTyRTUPd5nYNnxOmWEYs8WF+8vPkumSw1vPdLawj8pdY9F8aSkSDPTcQDw4X9+FhL23VsafZ7M70WgzDC9jD8pVCLwhwQdO5m/UoupEz5EpCIx6LJ1ChAjlDm4pNAMPmPz6zgnqOfjWX+s/glk3Z81IADB01eEhPHFEyvQzHGQwDB+rfseuFc0rQcTbQAVKo9WcklyaAWuWMnXKn3qSZUMZIgLP3JrYTtLf5u/FkA0y0erdOxXVDSIgZnKYJJTtdHShaKzPEQnR6MP6KobcJZHXwDuFTayEEroty+ZcfChOTobHO2ifIRBOSyiLOyA3ISh8iC/iSBNxIBWCXebUEWg3LPpm82jhdHv/G6pswR9vJSq7xxuiCM2d1yePSmBsnZC2JC59iHzCUEIjMNd3vTaS8C1Mafpopb7TjVTMTISEvZX+OyCCiBDAQuNERylsNAAfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5165.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(478600001)(186003)(316002)(4326008)(1076003)(36756003)(66556008)(8936002)(6486002)(6666004)(2906002)(956004)(86362001)(8676002)(2616005)(7696005)(52116002)(26005)(5660300002)(66946007)(66476007)(16526019)(6916009)(38100700002)(38350700002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?K+C8Svb0KNT7xscuTk/7LMxbWOsMi+CC0GN5ldhP1V7jhPoU9XE88Zx+S9xQ?=
 =?us-ascii?Q?a/uu7zmWq/WL3Ap/ccOYvjy5wWaUc4Ap5ET+LEYSa6cok4Txq5UUHCOKe+MU?=
 =?us-ascii?Q?yKLmFesVJdJMsx/vOCETXgVK+CkrDopQ3gzoP/s0RxVbR+YFd8IJ/AodNe84?=
 =?us-ascii?Q?yPHvnLID1Gkot2ah5kqUw4FNSeOPx8Tzqk+uIvXJrgmzpFluEVAS47jS/vbn?=
 =?us-ascii?Q?MtZQX6Zpu9hdVqsG/ThItp5AXrDD9715BiEeV9X47wPUOnqP1BitW2MIwkwo?=
 =?us-ascii?Q?+KZg0fX3v9rstzozv01leWjJDm8svxhHu7dMYEf/5GsKxdcsbKd8seX6j+az?=
 =?us-ascii?Q?iQNT6Sl+nLWKw22Y3wuWAf2/98b021CSu8E6p8OHY6KabhSLEfp+Hno4wWkV?=
 =?us-ascii?Q?5/oligsdrwvukCsIsJyvEGztpWlwKhh+E6/hL4nB0dN4t4qoxK1PrYhnSGcR?=
 =?us-ascii?Q?7nyx2gFjIEasqjSXmSfBF+8HXSIQF179y1YVr9u2FhbvZ47sWv3+ke0tyGlk?=
 =?us-ascii?Q?cMbW8O18aIhVOVIis7W71m9hOmkQKSe+fFadiCpAdhkmpD/tp/NcZKM87aOF?=
 =?us-ascii?Q?IcsXly+TX/8bntgdo0Myg3sjGU9HGQ4JTVEB7bHhwR93nLg5lGU1cEvBde3o?=
 =?us-ascii?Q?sX+Bfhq4LyfPCHwbdRtXTGw2sOD6QeE8F8z/rKw8QygzrcYD7S3XuVUpDApH?=
 =?us-ascii?Q?vWVYbHecMNj9xfYAOh/p1DEypAfjgVSay0JYe5nj+byodF89WYzCaWRBJnCn?=
 =?us-ascii?Q?iQoHZjCFd0LlBEo6vkCJhvJGlC+2XSNHeyjIxu7LN4w3vJ8QIS0mY5Lex8qo?=
 =?us-ascii?Q?+27JnSPA2LOPTRFQzavsqpghzRECnydqp4/ZYcyfBASfThcTdvX7xJrL7Io7?=
 =?us-ascii?Q?wb4XBDfVE/+TD+pE6YFaoZRBCJb47SdB7HrThMaaU69FHmElROAerqqBn5/q?=
 =?us-ascii?Q?f9Vkb2/uYjjehEk32zfRtMDg8C1hggbcmKcu5ySTd2eK0/mexk8DHflFVfT5?=
 =?us-ascii?Q?/FqxYp0BgnSnaMhzp4gRQ8PcpoAyRzrCfe06NFDxFYStBW5B2o3lJ6rYXrug?=
 =?us-ascii?Q?H4KIOtpkQjvZQCsZIP7XzKnqULiiFPFgvWrFHtyoACF9WHX7cmMxe+i28tiY?=
 =?us-ascii?Q?p+vcjP4B/kLrWO8t0hcps0uoFvxsv+W4cNXr2rc55S2keZuO7rGNYtewOnZW?=
 =?us-ascii?Q?Qz+ztdllz8/e0/oPc/NiV6WusGKzR/1ROvg8vofSJhgh2mijzcSS8tO7QUPd?=
 =?us-ascii?Q?tLOlwF4wNJZAyqZ9rk4fy+tSsCiT/ugilbMtytCvCx4daEM4JHHHLumLpf0n?=
 =?us-ascii?Q?YY1dt2Vz699ZEdabIZpJhXo+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5496e154-845a-41ea-067c-08d919a92ba3
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2021 03:01:02.3580 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1HnkuOnCqTkQToyKI6awnS0CG6uKnfT/RPgZqovyzBPndZZTjY/LspcY5K29wua0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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

looks like we forget to set ttm->sg to NULL.
Hit panic below

[ 1235.844104] general protection fault, probably for non-canonical address 0x6b6b6b6b6b6b7b4b: 0000 [#1] SMP DEBUG_PAGEALLOC NOPTI
[ 1235.862186] CPU: 5 PID: 25180 Comm: kfdtest Tainted: G        W         5.11.0+ #114
[ 1235.870633] Hardware name: System manufacturer System Product Name/PRIME Z390-A, BIOS 1401 11/26/2019
[ 1235.880689] RIP: 0010:__sg_free_table+0x55/0x90
[ 1235.885654] Code: 39 c6 77 1c 41 c7 46 0c 00 00 00 00 85 d2 74 46 49 c7 06 00 00 00 00 5b 41 5c 41 5d 41 5e 5d c3 8d 48 ff 49 89 c8 48 c1 e1 05 <48> 8b 1c 0f 44 29 c6 41 89 76 0c 48 83 e3 f8
[ 1235.906084] RSP: 0000:ffffad1c430cfbd0 EFLAGS: 00010202
[ 1235.911671] RAX: 0000000000000080 RBX: ffff93e266d2e6d8 RCX: 0000000000000fe0
[ 1235.919393] RDX: 0000000000000000 RSI: 00000000a56b6b6b RDI: 6b6b6b6b6b6b6b6b
[ 1235.927190] RBP: ffffad1c430cfbf0 R08: 000000000000007f R09: 0000000000000001
[ 1235.934970] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000080
[ 1235.942766] R13: ffffffff9e7fe9f0 R14: ffff93e20c3488b0 R15: ffff93e270bc8b20
[ 1235.950563] FS:  00007f5013ca63c0(0000) GS:ffff93f075200000(0000) knlGS:0000000000000000
[ 1235.959404] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1235.965683] CR2: 00007ff44b08faff CR3: 000000020f84e002 CR4: 00000000003706e0
[ 1235.973472] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1235.981269] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 1235.989074] Call Trace:
[ 1235.991751]  sg_free_table+0x17/0x20
[ 1235.995667]  amdgpu_ttm_backend_unbind.cold+0x4d/0xf7 [amdgpu]
[ 1236.002288]  amdgpu_ttm_backend_destroy+0x29/0x130 [amdgpu]
[ 1236.008464]  ttm_tt_destroy+0x1e/0x30 [ttm]
[ 1236.013066]  ttm_bo_cleanup_memtype_use+0x51/0xa0 [ttm]
[ 1236.018783]  ttm_bo_release+0x262/0xa50 [ttm]
[ 1236.023547]  ttm_bo_put+0x82/0xd0 [ttm]
[ 1236.027766]  amdgpu_bo_unref+0x26/0x50 [amdgpu]
[ 1236.032809]  amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x7aa/0xd90 [amdgpu]
[ 1236.040400]  kfd_ioctl_alloc_memory_of_gpu+0xe2/0x330 [amdgpu]
[ 1236.046912]  kfd_ioctl+0x463/0x690 [amdgpu]
[ 1236.051632]  ? kfd_dev_is_large_bar+0xf0/0xf0 [amdgpu]
[ 1236.057360]  __x64_sys_ioctl+0x91/0xc0
[ 1236.061457]  do_syscall_64+0x38/0x90
[ 1236.065383]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[ 1236.070920] RIP: 0033:0x7f5013dbe50b

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 89cd93b24404..754f9847497d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1158,6 +1158,7 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
 	if (gtt && gtt->userptr) {
 		amdgpu_ttm_tt_set_user_pages(ttm, NULL);
 		kfree(ttm->sg);
+		ttm->sg = NULL;
 		ttm->page_flags &= ~TTM_PAGE_FLAG_SG;
 		return;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
