Return-Path: <SRS0=FlJ6=I6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFE5C433B4
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:36:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59A1F6108B
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Apr 2021 19:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59A1F6108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0F826ED02;
	Thu,  1 Apr 2021 19:36:53 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680071.outbound.protection.outlook.com [40.107.68.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D617F6ED02
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Apr 2021 19:36:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frwaCAeTHROPupu79mhmc7+b/lThQk/Y3g2Cspig5zrQmXTaHuXnK2aHL54+t18SIlRmSiHHaoXtOdFTryGw8N/qyXnJNJql+AN8jvIdq0DXNYDK21nezSVaijCM9l8W3jW6EHvXgA7QOQkgbklsREs2PYiJLRIyLwr927VqPLUpgduFAzuSGuDen8Bw8QJRnKyAkki2WEwe0KC3u6whY5yRAtXeb0sCwhFAvQ08baFZhcZ6n2u3lSBZw8ag++7RL1LD8oZZlCwXDbgGRE0tpbjZHbSDBzBJfPOm4aYe+jIVyK6amUu9Zx+fMjp0JKQXs2qGd2SWZUKsvr2yQnWPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHTp2OL9myD73lwYz2pwNsl6v/br2jSoklsANxlyvQw=;
 b=W7f3EdkoZjnBAyYV3zZ6ioraBku2CKSeCoRDT4wuqphXIHcXvb1TdzLkQl8f9at2/gt0R1/RNMtg8hW6RLFKotXrs436PCdu5w7sQnlzE5FpDngPh0PEAURYZBppCrsyzRi7gXswMp0nvrSxGEqNqNIMOLBhUF0OdqSP1UH6T+zCVgEb50pUy14MdNbH4kA9PGanyvCNmyp86pEgDbkBd0RUWE+RwgYFzHo6O94dnDfaPI/2h7S1+vdfVb4nCnTjOgoim8SBqOlAut5nBEWGiDiM1ZPdfe79v764/W91AtlQPk0pYCq7nn9GhTiImnQf+c4Cw1p41QVWWYDhBGSgvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHTp2OL9myD73lwYz2pwNsl6v/br2jSoklsANxlyvQw=;
 b=Rr1haQUPw4TnGngZACWIdNZ3C93L7/KDAUTf1fZiq8D4nRAlx2v2UCorKKFveGjnBHt9XA3/KjK9MZNRlFqDjXezMU+PZUnZvEvCfIShZKHPF1O0ygShiTXAJOqZTHhPbF6ITOKJ/iMOSVgvWBu+opxE2HZQju/0KqO7a5yvMUE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB4203.namprd12.prod.outlook.com (2603:10b6:5:21f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.27; Thu, 1 Apr 2021 19:36:51 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 19:36:51 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: Calling address translation functions to
 simplify codes
Date: Thu,  1 Apr 2021 14:36:41 -0500
Message-Id: <1617305803-5767-2-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1617305803-5767-1-git-send-email-Oak.Zeng@amd.com>
References: <1617305803-5767-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::22) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YT1PR01CA0143.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3977.30 via Frontend Transport; Thu, 1 Apr 2021 19:36:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4df0a347-7fdf-4fa8-0e0e-08d8f5457f55
X-MS-TrafficTypeDiagnostic: DM6PR12MB4203:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB42033321DCB9842DE6797825807B9@DM6PR12MB4203.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:72;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j50EpvlVn3LTbdpo+dLbsJWoWdMokcqeuL/Az09cJZ8ejOCN1PFIUuAqv0Agc9WJaqrVaI4vnP7B1cFaGRUR5qgrt36ReH/trZIjyY2AtwFm0i/PuAUqLEbv+HJXZnENzclzgO+9mPB8HZ/Aa2wLLvSd2duRvhfcS1WvzTcQOjXR167m3GweIL48nVniBJWKI432UwLWZemlKp5b7uoI5W9/Qm/CZFG/isEy5aO6AygclBe0yr5efJMC4Yh1TSsU1z/ZAr12dInNHKwbcyszHg1QAexVKI2qGeBEFsZWeSNYO6PNZiM3tXCAUFAqqzNjb3lxShNG/WL7KKy4OeomqPSMvn6eiQ8zh1ExvDBGYewD3fR8xOFIaiudOM0WIOAZ/Z7smTFUC9i+Ybo0EzK7bf61AW1DNLoWqyRysuWyqZmN5ALlb+//P962pggZfS/PbvMPIG1sDx6n70LS3ECgveMXpoDZgPhWg38vGV+YT8/5VzBM+9JttGyJHM2himzRqKar/88zis8XGpngCmWkZwxH3AFrch9QToX3DnPNoRu2sMMeLOgTPDbhPVhaDFvaRWpFKeNlbn+Na4YPjoxbMvZ3S0XdeD77nEtcbbBBTphR/42UpYiyNXTmk482IpPD6ca9eZrYdHH3YKTlzHR1H9L0iPhQrGg/Oja7UbFDxc4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(346002)(39860400002)(136003)(376002)(38100700001)(66476007)(66556008)(6916009)(66946007)(26005)(52116002)(16526019)(186003)(6666004)(36756003)(8676002)(7696005)(86362001)(6486002)(83380400001)(2616005)(478600001)(956004)(316002)(5660300002)(2906002)(4326008)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?Rzri1ur6cafW74e8eYmYKfF2cxgQEa8UYg40FmAk9xbgxEnw5Bfb+hTuVvkU?=
 =?us-ascii?Q?RA8UA91bxo37pLAbI0rbmyruqcytHi/pJO1BGF3h6l93esRlnxcrEOJth2iB?=
 =?us-ascii?Q?PC07NLQFr1dLtnHPhZGOUccVZnXHAIV/1n7KD3kPIc1RqdJp1ZAQY6wWHECZ?=
 =?us-ascii?Q?JynQp3wGgCOxpFvJaYU3v2NQNWq+hWfZgNXBevdODYTRrVNQiCNd3ZG8sjXH?=
 =?us-ascii?Q?6FwAOJzcccURBUo59sNvmnQ8K95MPf1zUzL1UlQLFLtV4iruaqFWzjL4ZwRw?=
 =?us-ascii?Q?gPfANT8+/4crxoaAc3fgctnrvoyN1BXFX9t68vMD+nofzea/+PR/jAd54pcJ?=
 =?us-ascii?Q?3KtIuTw9p88G3Yxej3DyA5/E/E2A0xrbtOMdHhKRNaiJw0kYaP4w9HF5GAs5?=
 =?us-ascii?Q?+g88QfBEP5gGekQirB6FRIGdO84y96uMqr7LYkaPmLg0o+PQp8HFSHBg5CmP?=
 =?us-ascii?Q?xKl6lKMsXMi7Vaa4qysR13lOpbY1n+mMTrqIJ8RxOxM5A+qZcIH1/ELhMHLY?=
 =?us-ascii?Q?8/5fjHIcu+j8yB32+fmOB+CtbxD5c36bIlfG7xptecL0/YTxZVydGwpA5dtd?=
 =?us-ascii?Q?ri0i504UM4GiA8weS9VPhmQhSkmY6ll/tnarO+R3qQ1XgzKs7JBt/4PglwZx?=
 =?us-ascii?Q?42AjCeQGRZ8u92DI0YuaLwEg7tFt4D9H9AezeYkX2KoOLoAr6GWBZaoa9+Dc?=
 =?us-ascii?Q?m9h+VIZevKC881vQ7jSRW0hjJ/U2CqDrm+FylaBOy3mvbEDpzL1Xszf6x6L5?=
 =?us-ascii?Q?aBJ9uMtEYjrD12AvbPBJFDmUMcWEvZ2qXb34R1vj2Z+ukY0Pced1m8+rMDQ7?=
 =?us-ascii?Q?42Jv1/Df3lD90k+AFtau0KplrpPo3uHPkdN+8aH+VvpQjRbsi7AL2XKrjXlo?=
 =?us-ascii?Q?zjGzzcMTwJw87yiTp9sLZf8Oblb7Zi9eiiINUyUEM//2VY005FQoLuD+YjMG?=
 =?us-ascii?Q?DlGVsQKazptwAqnjyxTzGxvYp9Ggqf7zRaNoaL9dOdvGAKgjT5QH35+IJZnT?=
 =?us-ascii?Q?tD1+0BYq7h2inIPgHpSdxhOE9Nn6HhEE8J9cuWRAfkM/nGV3mMQL3kKIUOre?=
 =?us-ascii?Q?TmXawHYx9So7yB6qyngDedoweoUpMAHiImmzz6/FQ2DjM+mXiJT0V72MMD3e?=
 =?us-ascii?Q?n9NmrVVI+t1fvNsAyAL8Soa5Zc0VHZ/ZgxYVRLHy4ZLVNF4Xoa+BzlIsmvjA?=
 =?us-ascii?Q?D62TWYg6XT25SYLdUwZVXCm5rDPb8TY813IWcr520XbwAjAjEL2nr6J7kXNz?=
 =?us-ascii?Q?ZvHFmMXaRjRv31/OLPDEL6/ffE2P/MPAzMmDMlc54XVKXEhq3dX4JkLb5r8s?=
 =?us-ascii?Q?NJO4FmXntq18mBiUGI83o+UR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df0a347-7fdf-4fa8-0e0e-08d8f5457f55
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 19:36:51.2973 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IfjRCB7NIQc7tGOWKgybiKFMoYDo2JTO7LQkTHKKHyRwaLNvUeE4HBgbiaczX/v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4203
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

Use amdgpu_gmc_vram_pa and amdgpu_gmc_vram_cpu_pa
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
index 4c5c198..4f10c45 100644
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
+	info->fix.smem_start = amdgpu_gmc_vram_cpu_pa(adev, abo);
 	info->fix.smem_len = amdgpu_bo_size(abo);
 	info->screen_base = amdgpu_bo_kptr(abo);
 	info->screen_size = amdgpu_bo_size(abo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index ca16649..238082f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -641,8 +641,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	u64 vram_addr = adev->vm_manager.vram_base_offset -
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 	u64 vram_end = vram_addr + vram_size;
-	u64 gart_ptb_gpu_pa = amdgpu_bo_gpu_offset(adev->gart.bo) +
-		adev->vm_manager.vram_base_offset - adev->gmc.vram_start;
+	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
 
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
 	flags |= AMDGPU_PTE_WRITEABLE;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 5bb9856..9b78891 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -120,8 +120,7 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 				max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-			adev->vm_manager.vram_base_offset;
+		value = amdgpu_gmc_vram_pa(adev, adev->vram_scratch.robj);
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			     (u32)(value >> 12));
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 2aecc6a..ab41c8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -165,8 +165,7 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 			     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-			+ adev->vm_manager.vram_base_offset;
+		value = amdgpu_gmc_vram_pa(adev, adev->vram_scratch.robj);
 		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			     (u32)(value >> 12));
 		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 410fd3a..4badd73 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -164,8 +164,7 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 33e54ee..4e801c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -568,8 +568,7 @@ static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				 uint64_t *addr, uint64_t *flags)
 {
 	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = adev->vm_manager.vram_base_offset + *addr -
-			adev->gmc.vram_start;
+		*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
 	BUG_ON(*addr & 0xFFFF00000000003FULL);
 
 	if (!adev->gmc.translate_further)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1567dd2..3ee5ed0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1047,8 +1047,7 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				uint64_t *addr, uint64_t *flags)
 {
 	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = adev->vm_manager.vram_base_offset + *addr -
-			adev->gmc.vram_start;
+		*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
 	BUG_ON(*addr & 0xFFFF00000000003FULL);
 
 	if (!adev->gmc.translate_further)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 0d5620c..1a37485 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -114,8 +114,7 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 29d7f50..d341d17 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -135,8 +135,7 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index f107385..2e1af97 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -210,8 +210,7 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index ab9be5a..21504d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -162,8 +162,7 @@ static void mmhub_v2_3_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 74c784b..4aa97fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -136,8 +136,7 @@ static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *adev,
 			max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-			adev->vm_manager.vram_base_offset;
+		value = amdgpu_gmc_vram_pa(adev, adev->vram_scratch.robj);
 		WREG32_SOC15_OFFSET(
 			MMHUB, 0,
 			mmVMSHAREDPF0_MC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
