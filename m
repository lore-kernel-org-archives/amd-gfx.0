Return-Path: <SRS0=/n0Y=HD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7537C433E6
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 10:39:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93EEC64E99
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Feb 2021 10:39:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93EEC64E99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C791899A7;
	Mon,  1 Feb 2021 10:39:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 617D3899A7
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Feb 2021 10:39:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpl1tvVW8JPC04X4yCDb9IzJ/I5CnNgeqC7Y8cyKtWVrc/EpMTqQBJ8aNKnxRA8owChzFzgmkTbpm1pPoceQrcuy9UbNpa5V6LKO3jMBTe1DUk9gz7+QoEUn0Z/2j+8Px+Z2/40kRkakhF5fDTgVBDRJ9tQpyIBgoAqg8ZbxfHiN21UgRre+WBUKzOh3mDwn5YeQpLHuTOurCOuhffxG5DWmQaaa6ahjhlScin/vOYL3uQ6zgVIU4jR+JQAW5o3Rok1beI/4XG572ZDraHMoVQn/Bh90qDeDjYfuOsMLnLe7C4wBjW9vH3JSFUctaaPJB5sBgl9ks/Xn6BFgUzUt6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msl0f2m1U/KAhLLeSEEjWkuDGNVIPTEs3Ht8GmJECis=;
 b=NyITtaaDPJsW3+YmTySixgEMsQdgF5wlqnLzvK8Mt6tQMWBrJYQ2Oaec5WEiPU4tac9Bjx6xoBpAh+Wb0fmg13ojJiuanZRZcqOt7T5uQQs+iiT7BwQlDaBAr2Yqi5R4IuSgTMUW5+hGmwvH8OQYI/t+ndL7afmNTxhZ6oACRb2r/sK996kRZsLIOd/viH+jq0uL9KT06KWrRLtvLnvCKlGn882HbCWtidq0du4CZ7ocNH+AoOypaicrNBJqrV9saQc6AcoHs+zwx1d+K5V0T2JWHNCUQGZsrjcI44X4y/OUqGjDGq0vjPvgO1nFE7yiHKAL5RSKbns8et0dErvwsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=msl0f2m1U/KAhLLeSEEjWkuDGNVIPTEs3Ht8GmJECis=;
 b=IH3g2Q7dHkVk+07diuaYuxfROg19XfCjlPr2ptb6UdosXASRxmwMYSvmGDKd7cNSa7rugd0by3H4FYdW+B65CQokdczZ4NvE6g1vdXP4ELmMXZF6LdCrF1lyyxGVfn49lcryawQXjjkuuneIqNN1ojF8SVF51IfIrcx+ZR4Xtnk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1742.namprd12.prod.outlook.com (2603:10b6:300:112::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Mon, 1 Feb
 2021 10:39:41 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::8c0d:7831:bfa8:d98%6]) with mapi id 15.20.3805.026; Mon, 1 Feb 2021
 10:39:41 +0000
From: Huang Rui <ray.huang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix null pointer panic while free buffer in kfd
Date: Mon,  1 Feb 2021 18:39:16 +0800
Message-Id: <20210201103916.3153820-1-ray.huang@amd.com>
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [180.167.199.189]
X-ClientProxiedBy: HK2PR02CA0142.apcprd02.prod.outlook.com
 (2603:1096:202:16::26) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd.amd.com (180.167.199.189) by
 HK2PR02CA0142.apcprd02.prod.outlook.com (2603:1096:202:16::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.16 via Frontend Transport; Mon, 1 Feb 2021 10:39:39 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 44f978de-7951-49eb-c77d-08d8c69daea3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1742:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB1742F4E194068025B2FFD6EDECB69@MWHPR12MB1742.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tn6TJy7814VM5+toLUCpVBMq13fqL18cwQfjd9RL4VgZYyBqwrghZbLNaSbJwUJJLw8kpKw9YfJt7EG+AlAnb9hLaNzYhGoFDOQc95an7kYdgflC3t9PUlhVk2AY/JLOhuIG2gOwZMx4kUO93AuoxcWL2oqV9XAB4epjI/kkqlUD5pIAq4sx1cwm9ug2U/9pwG1cHR3kyg/S/PbmJ7goneWq5NMbQ30DSCHzhwME3MDNaOm2QNOWUxybhrHEosN9CTmQ/gAtEWGhWiJQbePDRuew5igAq+evxiVgwHqnvo8duvae0If3xW4gFbAQpFlYGm1O2HlatjuNZEuJ5arBGoVAs6rwvIoYP6HNsfPvsJZFsAKrS9ky9AFaQeaZZVN6jYaP9EobiTuj3FudclWjuiW9XAJ8zWnWdWJmLi+Q4lW7dlDjexSHLotLWUgN1Mul/eDlokAKVP20hT4GXp9mt+vvcr8vQ0+DsMoCrEP9ATV2AkjLdQZxM4FIP+kgyqJ84Zz1vp3zL/y+F2Eakgxwow==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR12MB1248.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(86362001)(16526019)(5660300002)(2906002)(4326008)(66476007)(66556008)(956004)(1076003)(478600001)(6916009)(8936002)(2616005)(8676002)(66946007)(186003)(26005)(6666004)(316002)(36756003)(54906003)(52116002)(7696005)(6486002)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?ISqCrFhi1GOTFW5RDdCw/oww0xMTsHqPstiVoM+wFtW0niXGn+626uBXZsqd?=
 =?us-ascii?Q?IRXgjg8Q/phMdOEKN7AmdWeF2tiFkGimixjju4apkvg/yXxfRqKDXuroiZsv?=
 =?us-ascii?Q?xcmND+VkB4zkzJpi7U+pqRDnB/dig8Y59vsQGhT8KRnTfxU2eWQ8etz6laVo?=
 =?us-ascii?Q?7YRVvuvqjLeow9e0nsYI/lUE5H0cta5X7Gz3PlRha65EeZ6wfRKnBvQOjbuH?=
 =?us-ascii?Q?/Dw0Y4/iF/FJOxfrTdt18UWPK0bxlDeKH3t74UzP5zaU/ZJ3slg1Uh+I258P?=
 =?us-ascii?Q?uufadV3a2jHCQM5XHXFik3YnsIQPRRKW6KqF0wACglJ9VVa4e8ETp+JWQoMj?=
 =?us-ascii?Q?m7RfmDyVW6UJ0qO85S5tlLKFGMl5nYM1OhjsVoASVXpuPGxVxYhbyxCdE5B+?=
 =?us-ascii?Q?ATJ+Sa/X9smdlcPmmC7d89DJ4q8UyO46wR2v6fvhiZaTyZF/rXOh4Mw2QXHl?=
 =?us-ascii?Q?1OVDTPcmYU+TquoChXhoqa0PKBOGEKpj3JLU9kRxhbBbnQMmjWF4SI84Hc3i?=
 =?us-ascii?Q?D/hJUJeuS3w74my0ruiV2u/2Clzj0ZyCQrLivBSjLno8l0SuRMxLwR48tlnn?=
 =?us-ascii?Q?fMhaGYs66gEE24HNZu4AQ+RFZT4yEgaVdA3AOf1bd7iLtV/35F3vYlYrPw/Y?=
 =?us-ascii?Q?HQmC9NytybFIiHuCk4lVgi2jhyaVwdDCiqM5mV7YIU150hzU/363CWh46uBR?=
 =?us-ascii?Q?UH0Tsb6Xtbrj5lJj/eYnpSPYf4TZwK5J6qMw0sH3zPwrNQISXJCUukDP8Jvf?=
 =?us-ascii?Q?GvhywrYwyB2u8QQVfvnUmjs0D7mhI0Cf6HfA8+m4+FY0wJ1Ajlt37nHL5djU?=
 =?us-ascii?Q?XwJwH+XWbg748N7WuufrKSSDMtSmd9segggdAPRpPn4DhOxocCwXqPCac62k?=
 =?us-ascii?Q?9Vpp/07nB5COHQ5aF1feKmoOCGcoFVl18npOzFY8CZWmkCj8pE/0P+4TylOj?=
 =?us-ascii?Q?Ve1vOUFhlF6yJKN5VVndoF+TUDlQGiq/McOzcrw8008w423g5OeNhybYSDAW?=
 =?us-ascii?Q?zr8mn+RQeb358ZFMHg2a2dpYV1/Zmt98bZ/lnNBfKqa1/p0bb/z2u065gFIH?=
 =?us-ascii?Q?S5/X5H77GQtUrXfzgjlFvGc+S47dWg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44f978de-7951-49eb-c77d-08d8c69daea3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2021 10:39:41.7488 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOXxAjun0qabzLPrfeRz9/jm/70mLJUyCtjlzDH9zrhdtVZmvZvAkXxbzHYIZfGkNlWhVAgtDtXhCDmwtf8pfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1742
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang Rui <ray.huang@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Changfeng <Changfeng.Zhu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In drm_gem_object_free, it will call funcs of drm buffer obj. So
kfd_alloc should use amdgpu_gem_object_create instead of
amdgpu_bo_create to initialize the funcs as amdgpu_gem_object_funcs.

[  396.231390] amdgpu: Release VA 0x7f76b4ada000 - 0x7f76b4add000
[  396.231394] amdgpu:   remove VA 0x7f76b4ada000 - 0x7f76b4add000 in entry 0000000085c24a47
[  396.231408] BUG: kernel NULL pointer dereference, address: 0000000000000000
[  396.231445] #PF: supervisor read access in kernel mode
[  396.231466] #PF: error_code(0x0000) - not-present page
[  396.231484] PGD 0 P4D 0
[  396.231495] Oops: 0000 [#1] SMP NOPTI
[  396.231509] CPU: 7 PID: 1352 Comm: clinfo Tainted: G           OE     5.11.0-rc2-custom #1
[  396.231537] Hardware name: AMD Celadon-RN/Celadon-RN, BIOS WCD0401N_Weekly_20_04_0 04/01/2020
[  396.231563] RIP: 0010:drm_gem_object_free+0xc/0x22 [drm]
[  396.231606] Code: eb ec 48 89 c3 eb e7 0f 1f 44 00 00 55 48 89 e5 48 8b bf 00 06 00 00 e8 72 0d 01 00 5d c3 0f 1f 44 00 00 48 8b 87 40 01 00 00 <48> 8b 00 48 85 c0 74 0b 55 48 89 e5 e8 54 37 7c db 5d c3 0f 0b c3
[  396.231666] RSP: 0018:ffffb4704177fcf8 EFLAGS: 00010246
[  396.231686] RAX: 0000000000000000 RBX: ffff993a0d0cc400 RCX: 0000000000003113
[  396.231711] RDX: 0000000000000001 RSI: e9cda7a5d0791c6d RDI: ffff993a333a9058
[  396.231736] RBP: ffffb4704177fdd0 R08: ffff993a03855858 R09: 0000000000000000
[  396.231761] R10: ffff993a0d1f7158 R11: 0000000000000001 R12: 0000000000000000
[  396.231785] R13: ffff993a0d0cc428 R14: 0000000000003000 R15: ffffb4704177fde0
[  396.231811] FS:  00007f76b5730740(0000) GS:ffff993b275c0000(0000) knlGS:0000000000000000
[  396.231840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  396.231860] CR2: 0000000000000000 CR3: 000000016d2e2000 CR4: 0000000000350ee0
[  396.231885] Call Trace:
[  396.231897]  ? amdgpu_amdkfd_gpuvm_free_memory_of_gpu+0x24c/0x25f [amdgpu]
[  396.232056]  ? __dynamic_dev_dbg+0xcd/0x100
[  396.232076]  kfd_ioctl_free_memory_of_gpu+0x91/0x102 [amdgpu]
[  396.232214]  kfd_ioctl+0x211/0x35b [amdgpu]
[  396.232341]  ? kfd_ioctl_get_queue_wave_state+0x52/0x52 [amdgpu]

Signed-off-by: Huang Rui <ray.huang@amd.com>
---

This patch is to fix the issue on latest 5.11-rc2 based amd-staging-drm-next.

---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0849b68e784f..ac0a432a9bf7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -26,6 +26,7 @@
 #include <linux/sched/task.h>
 
 #include "amdgpu_object.h"
+#include "amdgpu_gem.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_dma_buf.h"
@@ -1152,7 +1153,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	struct sg_table *sg = NULL;
 	uint64_t user_addr = 0;
 	struct amdgpu_bo *bo;
-	struct amdgpu_bo_param bp;
+	struct drm_gem_object *gobj;
 	u32 domain, alloc_domain;
 	u64 alloc_flags;
 	int ret;
@@ -1220,19 +1221,14 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 	pr_debug("\tcreate BO VA 0x%llx size 0x%llx domain %s\n",
 			va, size, domain_string(alloc_domain));
 
-	memset(&bp, 0, sizeof(bp));
-	bp.size = size;
-	bp.byte_align = 1;
-	bp.domain = alloc_domain;
-	bp.flags = alloc_flags;
-	bp.type = bo_type;
-	bp.resv = NULL;
-	ret = amdgpu_bo_create(adev, &bp, &bo);
+	ret = amdgpu_gem_object_create(adev, size, 1, alloc_domain, alloc_flags,
+				       bo_type, NULL, &gobj);
 	if (ret) {
 		pr_debug("Failed to create BO on domain %s. ret %d\n",
-				domain_string(alloc_domain), ret);
+			 domain_string(alloc_domain), ret);
 		goto err_bo_create;
 	}
+	bo = gem_to_amdgpu_bo(gobj);
 	if (bo_type == ttm_bo_type_sg) {
 		bo->tbo.sg = sg;
 		bo->tbo.ttm->sg = sg;
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
