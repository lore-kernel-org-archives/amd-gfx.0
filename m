Return-Path: <SRS0=Oizy=I4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94302C433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 19:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD256199A
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Mar 2021 19:35:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD256199A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C006E08E;
	Tue, 30 Mar 2021 19:35:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FBA66E08E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Mar 2021 19:35:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+El+QwRBBcY9o3bTljKkEXBkyckrV7AGVwNTpSvDjwYa2u+5dtGbB6DOUARkWd82D56VbqGutioQOF6aamuw4//5mdtTyaWHg3Lv2XenAw94Cr+F+kzMukkLj5p7ODQVBE4EbZxomt01XIVTbNvUzhEs9+DpP6lgeCEIXwhuuZu7Cmuh2KvfCEhh7VXRD82Hu2qoEJk/N0kc870qBmSWcJPjFFWOiRCeMTC3G/E++NGBjfS/ODVOdGAoObZ9FXJJKW7cCRiBcuw5Bdgzw1cilxYvgM9USM4WIXfetqvHW1F9do946Ki4A/KConLa4+cQfWlCDMY1JmsPX1gjv06SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejI2HJ7dQbbXI2/pmTsSByZJH5kMMfLJzzQcLOm8Ozk=;
 b=F+xhffmqXFKtMMXHAIjgWVEKG+bp2srpLpWQzWYFohuR9C3BoRd5rItKPo4sWCRHu2A73uojXu7sa5EEN0RHr11UhM7FFcDV9PkLbe7s1X7SCzhnUNzqsJIbGbkei4jUq+9IcAAuDXXt0GvP/O5kTVZqFnES0LN0lb0v/QF8yjOhTzCDv2u0NmUEiXTnOGE3TEzynE1022qPFO9jdJvNp9EkdnegL095IxNigs4il58oO/ZViEx/R2yp1K+QdI9aj0eIjFx1urPpTz5jNCWJUCr1UWiQ18wwUaGocEIk4ewPnZ2O7iTpIiYBpMHcJHRKAv0xfNVb6Tw33y3BrtMAhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejI2HJ7dQbbXI2/pmTsSByZJH5kMMfLJzzQcLOm8Ozk=;
 b=CI/CUV84G1TyqitnVx90ZpStG7cMo5lwuTSpYIbdd+f7PHBn0CWbnuNqSyfPTkygHPn4U01gjRYBMHA/BpB3jGxUUBaIMNsQznC9FC8TJ/4btxjT78Mf5E36CVlqB1GK1Qna8oArBphgtQLH4vzwAYvGpcJ1NI+EhOKbvsdNUx4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB3787.namprd12.prod.outlook.com (2603:10b6:5:1c1::29) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Tue, 30 Mar 2021 19:35:41 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 19:35:41 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: use macros to simplify codes
Date: Tue, 30 Mar 2021 14:35:31 -0500
Message-Id: <1617132933-16843-2-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617132933-16843-1-git-send-email-Oak.Zeng@amd.com>
References: <1617132933-16843-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.32 via Frontend Transport; Tue, 30 Mar 2021 19:35:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 22a14e95-7830-4acb-e8cf-08d8f3b300c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3787:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB378728D111AB3163FC30293F807D9@DM6PR12MB3787.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:72;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d2VNotsYsQ4lT4dNQbsEIiKipvhMd/V0Izkjq8K1CZHP4Mzp8ri7CdqC2HoW9JJXPDJmVcjXI0zprghLsn58ydZFCyGrlP0I390C6X6UspEklwbTPYa9GxZqTK3Rj3XHwtKNcj3azV+7XowgRiZ1jxMjrTiDCwL40Uo+FjNfhCHUNIFt3Hg8SNtpGXckmHkSZ1CXZvHxl8IbBwTrikoW+kEZaOpw7YEvEZ3MZPu+lXpLjxR/2EKrfGhxP0WqG41jcTHmIT5RFjikwp1HtLsDb03EXQenoeU0WbreSXLr+FgfE6AjQCYniNogrsnqxCBbbCu8riVi87mM80/xpxwIKkg1d7o7oL6SyJBn7tcETJ48/KX1QAzciY21hs5qEcKgfml47qLjymM7LYL4/M7fbsMJkwkFxaHsrsvY4AaiaExyrb7UvEIIlq9Qub7zTPyVHgC9duX/8H4sRF1FJXScd9jr7gYTT7YulPdPvHaDb2vl8hQ17xUqvmrpasLmDka7xaWFs+q6JpsBvwQq9RbogWcvK4tiPpTLwInNSPYQoZHW2bcwT/NUtVIz2Hkro7rzd0DiJ6EXirPNuGyjkyG8B7dcVz84i+NgVVSxu0mSmv3CYoh956bZeGOHK5Hao02c+oFrtRCBwk0LxdFWOfr0tgBhQ/F1I5Rz6IQjmHdiapo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(6916009)(8936002)(4326008)(66476007)(2616005)(52116002)(5660300002)(38100700001)(2906002)(7696005)(86362001)(66556008)(36756003)(6486002)(186003)(26005)(83380400001)(6666004)(956004)(478600001)(16526019)(66946007)(316002)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?T41FXii0S+EvbgqH2MUVFNWv8XMBUz0fPuzSOPCugm7Q++QS5Hiyf4Vn84Ud?=
 =?us-ascii?Q?EcvCLrf38Tw1+a7G2bv5j82P8wEzsdP5BQj5lH/taAYNALFaTB2qfBUK7Mox?=
 =?us-ascii?Q?YZycEI4VVz9fKkRnj4+fFIQ6Sx5SkSDeOpZ8OrCBvRy4IfbwZnzFCq1Z9SJx?=
 =?us-ascii?Q?sbxVsHI51kUVsInXC3CRFnQTue5Z5E7JKIb40aL0wdk0xc1wZDtFN1+qWKVT?=
 =?us-ascii?Q?OboOAiNbPEwdaiaBOvsAEj4wLJRfTxpnH/g/V0Y1UNDpIcKWSTBDzruexcra?=
 =?us-ascii?Q?CygM4lMUSEE8tWM2uX7zC3ubA7zpXsmL7R7yCPCxPkHpnm3Nj7yGt13AcIrb?=
 =?us-ascii?Q?LxdDf5+PXBMGfqp6CYjztElj/2nxEdtZpPbsQ6YLC9k/dbK3SAe35TCqVPCg?=
 =?us-ascii?Q?l9Tdh7nWUux0AOkAab97yYciBcij1WpW8QK9SQ4LfiicLH0xU9tYGvhXdUg2?=
 =?us-ascii?Q?C2lCrvkFuK0v+32jPRx6hGOHqi38MJqk6urwBKAnTvVKYtPrFCBp5XdgnMYN?=
 =?us-ascii?Q?l87ka/4Cu7BriAyjcCyMAVYbegfvz6RXajIqP/9+0Nn7r2vaRBGH4u+aJy4R?=
 =?us-ascii?Q?33Ew3EpBNPKdxuXA3cWpfzT5QN1TEpvT0ugeUdxUt5RoPzHoCCNp4XSE7aMW?=
 =?us-ascii?Q?HwP9I2SsdtwM4xt8KChlpN92ibwpb3XQ0H/Mu0RJLFbFGCMa4W99dHgHV4N9?=
 =?us-ascii?Q?NYtnSY3R8DoCP0IpV0Mdf6VLBVTM4U+RqHGD9L+KEqwzDEIuSaVz/iXfsn8I?=
 =?us-ascii?Q?aUN+yFgr2Bl6C264wxPc+qDKkpFn/003B17A2NTPx+wontO7+PW47Q5cxOZC?=
 =?us-ascii?Q?tGsQ7SzSkbXzttlU9qxOcT8oN7+JK7UVY1ZtyzOJrn6rz8p5h4LQptRmVEpT?=
 =?us-ascii?Q?hiaHMHLrJ1+S4q7C8OdlakrqoSvrlOlLigH/Ko123zPGua1+S/C1dKZ02iAq?=
 =?us-ascii?Q?uZ2P5PxagQrHZs9vKD+Y7nEUvecupXfyqc3MB7tXHLIMzFRIFc/zVsMwlBXj?=
 =?us-ascii?Q?XrJhOnoCwhjEocChGZq+YiB3ETngY/ElVvMrC0MBU8UWyL/Cv72an8Bs5e+5?=
 =?us-ascii?Q?bLkpjuVg+fvf/6HIIT1kKEH/LO2ko1tI/NiM7WMU45q2Sfqnm6CNIkeoM85S?=
 =?us-ascii?Q?8/Mdgih5o5uY3/KogQ6ZLdoCGUbVJay38d9cyjglGQ3QEbdRQV5raYxIabkj?=
 =?us-ascii?Q?1MNIThemRNMgX5b1m4kD556n51d/JLPmxM2NTSx8GaL9MwotvIJ5PJ06AXNN?=
 =?us-ascii?Q?53RwxSPrWpz2SGbV+hKRjAU9AcqE1iZGKv16CQpJnZzEhW/DPg34NUIZ8TzX?=
 =?us-ascii?Q?hO1A45PBJSRNEOWMsTFYUduX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a14e95-7830-4acb-e8cf-08d8f3b300c1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 19:35:41.2827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KnMVZcbRWcgPZ/Du5IwoCsoUq32xxrp4NP4nXMeQtXKCKGnliZ5ik5E0sVJWuqiB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3787
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
Cc: felix.kuehling@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Use amdgpu_gmc_gpu_pa and amdgpu_gmc_cpu_pa
to simplify codes. No logic change.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c   | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 3 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 3 +--
 12 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index 4c5c198..564446b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -205,7 +205,6 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	struct drm_gem_object *gobj = NULL;
 	struct amdgpu_bo *abo = NULL;
 	int ret;
-	unsigned long tmp;
 
 	memset(&mode_cmd, 0, sizeof(mode_cmd));
 	mode_cmd.width = sizes->surface_width;
@@ -246,8 +245,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 
 	info->fbops = &amdgpufb_ops;
 
-	tmp = amdgpu_bo_gpu_offset(abo) - adev->gmc.vram_start;
-	info->fix.smem_start = adev->gmc.aper_base + tmp;
+	info->fix.smem_start = amdgpu_gmc_cpu_pa(adev, abo);
 	info->fix.smem_len = amdgpu_bo_size(abo);
 	info->screen_base = amdgpu_bo_kptr(abo);
 	info->screen_size = amdgpu_bo_size(abo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index b9d68fd..ca659e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -641,8 +641,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	u64 vram_addr = adev->vm_manager.vram_base_offset -
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 	u64 vram_end = vram_addr + vram_size;
-	u64 gart_ptb_gpu_pa = amdgpu_bo_gpu_offset(adev->gart.bo) +
-		adev->vm_manager.vram_base_offset - adev->gmc.vram_start;
+	u64 gart_ptb_gpu_pa = amdgpu_gmc_gpu_pa(adev, adev->gart.bo);
 
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
 	flags |= AMDGPU_PTE_WRITEABLE;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 5bb9856..8c0710c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -120,8 +120,7 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 				max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-			adev->vm_manager.vram_base_offset;
+		value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			     (u32)(value >> 12));
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 2aecc6a..c2fa371c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -165,8 +165,7 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 			     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-			+ adev->vm_manager.vram_base_offset;
+		value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			     (u32)(value >> 12));
 		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 410fd3a..9b575eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -164,8 +164,7 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 33e54ee..e7c0d1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -568,8 +568,7 @@ static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				 uint64_t *addr, uint64_t *flags)
 {
 	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = adev->vm_manager.vram_base_offset + *addr -
-			adev->gmc.vram_start;
+		*addr = amdgpu_gmc_gpu_va2pa(adev, *addr);
 	BUG_ON(*addr & 0xFFFF00000000003FULL);
 
 	if (!adev->gmc.translate_further)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1567dd2..6d6daf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1047,8 +1047,7 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				uint64_t *addr, uint64_t *flags)
 {
 	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = adev->vm_manager.vram_base_offset + *addr -
-			adev->gmc.vram_start;
+		*addr = amdgpu_gmc_gpu_va2pa(adev, *addr);
 	BUG_ON(*addr & 0xFFFF00000000003FULL);
 
 	if (!adev->gmc.translate_further)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 0d5620c..5a7e5fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -114,8 +114,7 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 29d7f50..2d8cf7f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -135,8 +135,7 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index f107385..aa1eb54 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -210,8 +210,7 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index ab9be5a..313a5ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -162,8 +162,7 @@ static void mmhub_v2_3_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 74c784b..71be550 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -136,8 +136,7 @@ static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *adev,
 			max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-			adev->vm_manager.vram_base_offset;
+		value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 		WREG32_SOC15_OFFSET(
 			MMHUB, 0,
 			mmVMSHAREDPF0_MC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
