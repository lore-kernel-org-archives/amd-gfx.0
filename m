Return-Path: <SRS0=E5im=JG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0111BC433ED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 14:52:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A66A861001
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Apr 2021 14:52:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A66A861001
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B42D6EC34;
	Fri,  9 Apr 2021 14:52:41 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC4BB6EC34
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Apr 2021 14:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PX4RkDnM4cPn4oyYqKZKOL22cpWDVgNOlTcTfUdl5mbzQA2wNg3AF7bqAYQ8pPs88Kcw/re8nsA0jyxa9xwvKDqktUPvE/UxGQQP043OVPbuchvtS6ZAFMAH5bpZdgNLAz3jHG2BOwPiJGGUSbwkpnuohMprymo1KG7XhBsz49RmEMOkaVM0aTTys0zIiB+dud0zp/jt3nCY90BwMs7ABidDY35lAZcIZvs7tDrRYH0+yOHBE7DWtJfOg0wGBunzolnELo3QoMPYM4L4hU4bB9h+OTa9PbtyNQGAcKWaP9jD+pcLn30NplDDV23zKv3T8A6MX6TR3jF6llY3rlCikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu6ym5SkzU1pDcw/i1jljjXhQwZatkvBPByfH8buZNc=;
 b=gjmo1IH8UonsPnLUF2h9/dIoJ7I/fVr7QR69v7RFsYu2KgFW4GfK+YfbgMpzoSLE+sgya+SFDYmdnw1i/nlbR0Wrayn4vUijIh4yDPgbAfRnLWWzka+K3kvx7mSh3op2/BjS6+lzD8haQe2aQOv/ZNHYSxytoIBUGnB9mSQovWcx63bFnqscjwH3BjZp4sMl2EBcOEa/Hs6AdRsIbyVRSI6wTeNTUbilGn1iZKD0/i+zEiow9JVM8ZD3BxFYueSNaPEdObpP+c7sqfwJuDomWwqkndikBTc6ciKa3vNnyYsmg1/CrD0PBMxdXkY4Be+Pn6j465UdUg7KGM0HLPxE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mu6ym5SkzU1pDcw/i1jljjXhQwZatkvBPByfH8buZNc=;
 b=aztBJkBRvczezTGleCB81sY6wMV5GQkIXl0eq5yYo+Fk8+p7u4lfg5BdSHlMHE7H0DniWWpe8Wk6VQMI1dSZg7NXKGoBYDMLaceHRaWwxs3yyyS1vPBonqXWb2Y0hcQqKex5pJ483BH3hpnZuU6xgYndpp2sOqzHNu1HLDq1fsE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2761.namprd12.prod.outlook.com (2603:10b6:5:41::27) by
 DM6PR12MB3994.namprd12.prod.outlook.com (2603:10b6:5:1cd::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.28; Fri, 9 Apr 2021 14:52:37 +0000
Received: from DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136]) by DM6PR12MB2761.namprd12.prod.outlook.com
 ([fe80::c5db:878f:cbb4:f136%7]) with mapi id 15.20.3999.033; Fri, 9 Apr 2021
 14:52:37 +0000
From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: Calling address translation functions to
 simplify codes
Date: Fri,  9 Apr 2021 10:47:32 -0400
Message-Id: <20210409144734.1591798-2-Harish.Kasiviswanathan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409144734.1591798-1-Harish.Kasiviswanathan@amd.com>
References: <20210409144734.1591798-1-Harish.Kasiviswanathan@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22)
 To DM6PR12MB2761.namprd12.prod.outlook.com
 (2603:10b6:5:41::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from harish-base-compute.amd.com (165.204.55.251) by
 YT1PR01CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3999.32 via Frontend Transport; Fri, 9 Apr 2021 14:52:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d2a7c83a-a067-4bd3-537a-08d8fb671a8d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3994:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3994DB6AFDE28FE85DB6A9548C739@DM6PR12MB3994.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:72;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: w+amt+vHb9Y7X0CzJ4aaycfPsQ/WwhDJ0lYCKqGD0njHXiQlFDAkpCbdK9jnbwzqJAIcaRyuRMw439l6gcSKyfG8X/VfcqL7Z1ewDeO6kqtNgChaZbEThZ0v+ReSqlUFV1YZSQjBUANWYP35CH8q8F0TT695eAHzEZVxQTRX1XDk8enswb9X6HepvWEStJZX+QKhZLmGNIwg+F4IRhuwV87GZ/47m4NeiF3aziyCdYq/izuhtDxqB96MfyG2Xbo/sc1tS80OkD5n/1lLBjfFgKEHf8AllVSAlV4kcWrd5h46XGgHemXCRRRYYUTZ4rZ8Tw3azlGGCddPKJy9PNAO/9Pd7zTx5AYSirfTMMoMwuKkM1snTczPADj460Hcy6vRFt0yLykVFW2rhmBWILkRPJjkZnu3KxGpIY1M2yAvravWOB33LqBfhWVmTmF4GqCksSiYwzA2pBJEGhiR31PDlua02AfY9s0iyilL224jhqig4GGi6nZGCOiuashQxx8LZ2WcoSxmPwhjsGfHgdg1WclJ+amOPkNcDM4+RKIx1ymEzppEKnfN78WQDG7wBHa1coKbq/FRAG3fSkNrXZshfWg62qq1b8QwZyCLd7NOhGaK+DrBm1HAv9ZpVmeE1zN+kxHKUOGFZS6pexbpX/YzsZpvqliBGr7LfvXLboR2KLiZsTrrW/SjaiHEqohub7RV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2761.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(36756003)(1076003)(478600001)(4326008)(8676002)(38350700001)(186003)(83380400001)(38100700001)(26005)(16526019)(2906002)(6916009)(66946007)(86362001)(8936002)(2616005)(956004)(5660300002)(316002)(52116002)(7696005)(54906003)(66556008)(6486002)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?1xWs9x6JeWAQ7I8Itd6vSKrIiA8S3xyOcmdqQ9+y3aMshGPIruboCAzXZFTk?=
 =?us-ascii?Q?Y9uaE3HSvJLRqA2ZjGHrr7XiHlpm6O/0rb+jPdwsBpykLFmn2GWb8bI6IZKl?=
 =?us-ascii?Q?Oh1odfCxTLUiqH4AnpOlG1bGMrTpf1RnrASTDVXDjh+iBey3TLcW1NDBXDSw?=
 =?us-ascii?Q?XAhDsY6AwL+Wg5i2lzfA43RKAH7cfTdN9ituCSrMWibGt/Gqu+MUp7PMLo7S?=
 =?us-ascii?Q?UUHSHWAhZ44K87tP2XWniVlmtSUD2K2xuUAp7HPpilndifBAiydDqexWNAUt?=
 =?us-ascii?Q?Ar40FUH4RZIvQD9cCMR8do9DysH0tQBnJws3DP1XeUpZAzOlIitTwoKQBRvI?=
 =?us-ascii?Q?FpfCCAsxT0ET4y5agu5gYTke7lV71Tghlybab0akrhosrl/DRYPiQl9TJiIH?=
 =?us-ascii?Q?IlKojb/R/Tz/0qizNnTd6oArn6p0fAtEQbFNgAdxCga2hGFFUmE2PQBMcF9e?=
 =?us-ascii?Q?nOE4VefevPucTS6IQZU38jumWEffvJIzZd060EKah+ntOx3XInlZ1PNWdmfx?=
 =?us-ascii?Q?GkGhy6O+SSLIlSTBqW5WVpvTLuYNgeEiE5FpS6Wkg/Cw3H9ppje2WG7ZA/EK?=
 =?us-ascii?Q?XV1TyH0UAv1FF69vD3l5mPzYS5y5MYPPuvkUtSDcdSBINBdLZkfoHY9nb+JU?=
 =?us-ascii?Q?7sSOjipc7p77Y8TnAIe5jdrgxC/C28byv7vvcfRLLRQOV/ugSh6ctqeD1qQc?=
 =?us-ascii?Q?UrY3vLuSdoppYUq6se4Qlm4yO8lYbvS0CGEnpGUObawm3QDzyEbMIiqAPSMr?=
 =?us-ascii?Q?qQJTaykeBe8aIxvCwE37TfZi65a6sXlY7L1j6wp47qjUqG2m33JixSl7UBgS?=
 =?us-ascii?Q?+jWCRGjMIW49DtdpyEUKK6i7N//OMQsxQp5R1gsCAKe9mMsO4EMA97NKn/8S?=
 =?us-ascii?Q?9gkdN8Kboet13GpJH0Mb1QfAk3QkkThlVYOfYiBdHxbFdGB57P+z+vgjfPFa?=
 =?us-ascii?Q?vyHiDwUm4ew0QGwHqlS1hQ/DKt1/F1GMLkUbm3TCWn+JlWWWK/rWDIoCzsIQ?=
 =?us-ascii?Q?n+V0k+dc3Mbi02pw7ZlabSyM+7r7i5OPz8ryF3kE67pm0gIjV5amcAwO1qHa?=
 =?us-ascii?Q?yaexbABF6SYjUVeWU+3wwmPMqxoN68BP07Iordvv733CH3tVUWhCHbRpRpIA?=
 =?us-ascii?Q?lSwWiGuAmQ68yYLlUeTN2GZljjOLclnL8trRJ3W5OcxhXIvaBhDRyAFjiP2A?=
 =?us-ascii?Q?Jo91tLyJUzgF0/K0NEGJnbZTegqcff53cDkmBqUdSHN4YCZW1WgnAefyUYWh?=
 =?us-ascii?Q?MSgTQm9LcbkZTkcui9pspbrfM+aMUmeE/PmsUV7EA/kuGTKdxacwziDC9yxJ?=
 =?us-ascii?Q?FUbmAV3Cwpjs/K6IIyoV6y67?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a7c83a-a067-4bd3-537a-08d8fb671a8d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 14:52:32.0726 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJmNk3pxY/TGis2paqYtx586NAeUyYGNpHcjem4M3eBVGCygz+0AOMlX9vOPCBMmYcjZp4+9hR63rWwIxqsupw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3994
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
Cc: Oak Zeng <Oak.Zeng@amd.com>,
 Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

Use amdgpu_gmc_vram_pa and amdgpu_gmc_vram_cpu_pa
to simplify codes. No logic change.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
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
index 4c5c19820d37..4f10c4529840 100644
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
index 559582fac35e..1197f49eda18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -661,8 +661,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	u64 vram_addr = adev->vm_manager.vram_base_offset -
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 	u64 vram_end = vram_addr + vram_size;
-	u64 gart_ptb_gpu_pa = amdgpu_bo_gpu_offset(adev->gart.bo) +
-		adev->vm_manager.vram_base_offset - adev->gmc.vram_start;
+	u64 gart_ptb_gpu_pa = amdgpu_gmc_vram_pa(adev, adev->gart.bo);
 
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
 	flags |= AMDGPU_PTE_WRITEABLE;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 5bb9856bd8a9..f0f7025bf322 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -120,8 +120,7 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 				max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-			adev->vm_manager.vram_base_offset;
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			     (u32)(value >> 12));
 		WREG32_SOC15(GC, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 2aecc6a243e8..14c1c1a297dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -165,8 +165,7 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 			     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-			+ adev->vm_manager.vram_base_offset;
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
 		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 			     (u32)(value >> 12));
 		WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 410fd3a1a388..41807817de7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -164,8 +164,7 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start
-		+ adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
 	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(GC, 0, mmGCMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 2bfd620576f2..498b28a35f5b 100644
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
index 321caf77b0a2..521a137ba37f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1048,8 +1048,7 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				uint64_t *addr, uint64_t *flags)
 {
 	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = adev->vm_manager.vram_base_offset + *addr -
-			adev->gmc.vram_start;
+		*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
 	BUG_ON(*addr & 0xFFFF00000000003FULL);
 
 	if (!adev->gmc.translate_further)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 1a0bb9b1c25e..b3bede1dc41d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -114,8 +114,7 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index d0f41346ea0c..176331587f98 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -135,8 +135,7 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index da7edd1ed6b2..ac76081b91d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -210,8 +210,7 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 1141c37432f0..a9899335d0b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -162,8 +162,7 @@ static void mmhub_v2_3_init_system_aperture_regs(struct amdgpu_device *adev)
 		     max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 4e2c5f117cef..36d5b8a78ee6 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -136,8 +136,7 @@ static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *adev,
 			max(adev->gmc.fb_end, adev->gmc.agp_end) >> 18);
 
 		/* Set default page address. */
-		value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-			adev->vm_manager.vram_base_offset;
+		value = amdgpu_gmc_vram_mc2pa(adev, adev->vram_scratch.gpu_addr);
 		WREG32_SOC15_OFFSET(
 			MMHUB, 0,
 			mmVMSHAREDPF0_MC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
