Return-Path: <SRS0=ZMUS=IX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12D3C433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:38:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A309619BF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Mar 2021 16:38:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A309619BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36CD16EB70;
	Thu, 25 Mar 2021 16:38:49 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 948666EB7C
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Mar 2021 16:38:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVr2dFWImzBAwOA05UwvpBo++2RFwdeL2d/QdPBLi3djr4RK1RzWoDhUCMJiLV740alzHg1hwA2oq97vSZkNzdJtFzTLvyes+sPOSPve3F22q0uZTnfkMvmmlcc9uguhrQ1npV6WFcKNPlF24HnZ+sFKMq6Tre+aPhZ5sLuFWCfiMEsBgUVDGmhqI8FQoNCivw6UAaxMiKrcMcJ9kL3btTVuIQpXbaRtOcPBDYwcVxl+nqOBd09AYWevgzURaLqbKiNk3iNcNZZJJm0dVfFHvPWyj6JaC61bDuZZ4ZYbEcekfKnpYKBq6/nhtv2sPKD28Act67S1kyyMXLaxKwsmiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoKKecE6USLz4Ih90tK91tO+RY7RQH4fCedLiwc+0GM=;
 b=VcCXJFVRDNFGNaN0cgiznUPkjhdQgl1yzDgPyEvmAlDsW5X70lSH+pjiQ1PnT8IyF29GuZLYmosn4zdfqO8g3zvC2sNKRtscHUTJ3gmwt0Wzl3MVmHdXCnQHa4uX6/JsO4qHSd2mm8nkh624JD0CaaEim9Whc6ySXXibDPT5Lu2EoaeaEdarxAPIXSPvonf1fLou/ItkjMSZVnq/JkZ1IXLo+lmcNt46bxmo7N/jrAFixkBg7ZDnfjrBnxjiOSlhytvJ+lZGqk/Uea0Nw7dm25y8vQWoUatfv+o7QyhstdJIDLknkZIyLEbI7vxqJOeNaGaIgHLoUULb96rukbhylA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zoKKecE6USLz4Ih90tK91tO+RY7RQH4fCedLiwc+0GM=;
 b=yV6zB7nULcrY3dPg64LoTYp1Dd6JZGj5dRUMO+XATlnAy4BVmSqAFpUeGrbSXBOjOHOsBC16wDdo+x5sQZf35PBX9r84QZx2HzhLUFLtL81VfWo1f0btlPjtvQOqNcdI49eUA9rYmedX6nrB0Mvz+0Fy5BUAcO7tkOY2NYxy/LE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4732.namprd12.prod.outlook.com (2603:10b6:5:32::25) by
 DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.26; Thu, 25 Mar 2021 16:38:46 +0000
Received: from DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4]) by DM6PR12MB4732.namprd12.prod.outlook.com
 ([fe80::f40e:1245:84b6:e2a4%3]) with mapi id 15.20.3977.026; Thu, 25 Mar 2021
 16:38:46 +0000
From: Oak Zeng <Oak.Zeng@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/4] drm/amdgpu: use macros to simplify codes
Date: Thu, 25 Mar 2021 11:38:36 -0500
Message-Id: <1616690318-3555-2-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
References: <1616690318-3555-1-git-send-email-Oak.Zeng@amd.com>
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::29) To DM6PR12MB4732.namprd12.prod.outlook.com
 (2603:10b6:5:32::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ozeng-develop.amd.com (165.204.55.250) by
 YTXPR0101CA0016.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3955.24 via Frontend Transport; Thu, 25 Mar 2021 16:38:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eadac44c-630c-4980-e253-08d8efac7562
X-MS-TrafficTypeDiagnostic: DM6PR12MB2636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB26365BBC28F4C2B602141E4580629@DM6PR12MB2636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:119;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C+OJfo76kPyIF2oZ6hL4a/+f1mWP9R//dK3bdb43Qy+A6e+jbb0bkraaK4DB8jo69jFjGMRfP28hLm1sKpMBlg+cEkRQGiUWh4E0wiIgA9aaZl7l/A9XNTzQATXIpNaJF/Uu7TzCJ0KxV9n9xShHEs4EyOF9HUJXn2nYsfCf76/WRCRKx/DbLfZmGSQPeSn1DmqPvVmNircKKp3z6P13qVlDEY3Va9q7Bhz0edHJwkaeEFKzPs9cmFLaE92kAvMIZvGGyjVGnqhp1JiR47+k6Yr+VUzmYZVw7hyHNBTpTY/S/KO+Rd2YSddtZkDs1tYKxFY481HOpeTdrUSQwkRL8dlXf3miShmg5pSu1/6olB8cD/G467FNTK9BqvnNjGzgaraOMXRWlsiO4ccyWfBFPAgsjKEEKoaiBv95L7vtp0Z9q+SBb2/KEJQjY7fzmt9S0RfGGdn+LXHaDlrJr+AJnvw9uWAqUEr10mKvuNFm9QeWyHqydkL3jSLsrT5zQf0mVFWi7WecChn0SVVGQafyE4UnBtFqIgOlK6VWqbnVYj9I39J8M0BuAfH50GdjYIb5vrwfvs+KENitfHjvN8w9lg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4732.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(8936002)(316002)(4326008)(478600001)(2906002)(86362001)(6666004)(6916009)(2616005)(8676002)(16526019)(30864003)(7696005)(956004)(38100700001)(186003)(66476007)(52116002)(66556008)(36756003)(83380400001)(66946007)(5660300002)(6486002)(26005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?J852T1Dik0fuzIWv0wNsk3HwzKV0CSmQzNK5O+SQ0aTOo29Y1iGtx4FU22/s?=
 =?us-ascii?Q?R0F1FcBGtGkKaRH3CceBnbfPbg48rWKeHug951rehknvQntprfFUdRZNESeY?=
 =?us-ascii?Q?P7CtHIC7H0OtJ42yfLKM4UegTeif8KKsorCQJHHmKDt0h1iZsQviyZUq9XRZ?=
 =?us-ascii?Q?rzK4q1/sdJifVBuILDWjbDpj5rNhE1wEmq+QMq6Wji6tC6n09iC7lC77gHng?=
 =?us-ascii?Q?ArLetTSNd/mV0Xo6nIjQs4weI+8T3gM6FqEqLS1/KX72yFtNKM09SaFigHgU?=
 =?us-ascii?Q?pfwBJHcSaPRjUqhm/MWesE322levpFhSzI+XyQEUHLBpVOfqRwo5T+LHLI9i?=
 =?us-ascii?Q?ZXJcXtyQF0GbzDNG+e468XIHNVCKMnHEBEZFaZx5UlxVjQX06/ykH5RphdVa?=
 =?us-ascii?Q?/nrX/wmvmx1LnSsyEP2E464aPchyDxhg9gCoWPujIz+yS1+vYjr0CqzYT8Uv?=
 =?us-ascii?Q?jjaYgFFLLCR4kmaEbc3OwMuYYbFhAwMkWsMeNCCkqOw8zurddITIvG4giwnb?=
 =?us-ascii?Q?lmPs/pT4vV1WzzV0A2AcBlaQM7r8DSYgLbblOkgLQxHTFVvF+4FdJxKd4JDb?=
 =?us-ascii?Q?abYtyHh6c/a3agGDvf28RfBg6j3gdsLS1PEMFkh+NHK6F6j3Ye3Ywy7XkmG8?=
 =?us-ascii?Q?syUKfqRgQrl25BPTaL/lVLAPi3BJUtWI5iLYO3ZlIIBuCNx6wEHX9EyDwyRT?=
 =?us-ascii?Q?BWaP+So7TCIvZJgKhD382fcUO4kjcuo08eVVwORqJv+TdvQL6vQi7+R9PSXu?=
 =?us-ascii?Q?bimY8pHiOsOeiNtemSFp3RKTCph5Hbs/YuLbOe+WCg71Q8CZt3zBec3lfEFF?=
 =?us-ascii?Q?Gy7GJb4+0/rRToY+1Grxqxv0HxumHj2J+n1rq+CLFmDWuVLg2oClZTNBbd5P?=
 =?us-ascii?Q?nwTf34NQKB29WjguDxizkNbmFw8tJnLlZf/9KZY75/C/AMJseCf+FpCCswhi?=
 =?us-ascii?Q?7TdrJ1jM0h7TBiGhGcuw55Q9nGPDSF3wIyez7zxB766TV+HxDYrE3U6/wlsM?=
 =?us-ascii?Q?FMl03xNST1CQhUo+zBJES52YaAn6dcTfawuGDiAHVyyLjTUWP3y5MZ/JiApH?=
 =?us-ascii?Q?yAYdhP6ZTpOdDdQeNZ5VOx+0xTobFOTosiglm7T++m0FDGEMl3rKOEFbjCbz?=
 =?us-ascii?Q?jESXT6rCy7fRuUUR6Ev6J0K2Ksqz5EOGYcsoAdFEwLFs5FaPX+ZL4JpbiDXe?=
 =?us-ascii?Q?HWipeWjbeiSfSItl2l6VlruL5V8qZxydEKzs9YwfQHhoHk0BEAhaQRMAhy/k?=
 =?us-ascii?Q?a/OvsYeY2WtYbt4z9W7HBUZ3XQUgG6pHyDtkeaSt6V0II3UuKkk2l4RU0eDs?=
 =?us-ascii?Q?o7mbEOa6jz8i7YobpDg4SZeM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eadac44c-630c-4980-e253-08d8efac7562
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 16:38:45.7402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mi8qJ50mgze5iKReCA4aWNBc28UkAXQ64WlQrB3CIKqRqZjg8SbE4Etq/YHYxEf2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c           | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 4 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c          | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 4 +---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c         | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c         | 3 +--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c         | 3 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           | 3 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c          | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c          | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c          | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c          | 3 +--
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c          | 3 +--
 15 files changed, 15 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7357c1e..33581ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1831,8 +1831,7 @@ static int get_sg_table(struct amdgpu_device *adev,
 		goto out;
 
 	if (bo->preferred_domains == AMDGPU_GEM_DOMAIN_VRAM) {
-		bus_addr = amdgpu_bo_gpu_offset(bo) - adev->gmc.vram_start
-			   + adev->gmc.aper_base + offset;
+		bus_addr = amdgpu_gmc_cpu_pa(adev, bo) + offset;
 		aper_limit = adev->gmc.aper_base + adev->gmc.aper_size;
 		if (bus_addr + (chunks * page_size) > aper_limit) {
 			pr_err("sg: bus addr not inside pci aperture\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
index fd04a3a..dbeb774 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fb.c
@@ -211,7 +211,6 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 	struct drm_gem_object *gobj = NULL;
 	struct amdgpu_bo *abo = NULL;
 	int ret;
-	unsigned long tmp;
 
 	memset(&mode_cmd, 0, sizeof(mode_cmd));
 	mode_cmd.width = sizes->surface_width;
@@ -252,8 +251,7 @@ static int amdgpufb_create(struct drm_fb_helper *helper,
 
 	info->fbops = &amdgpufb_ops;
 
-	tmp = amdgpu_bo_gpu_offset(abo) - adev->gmc.vram_start;
-	info->fix.smem_start = adev->gmc.aper_base + tmp;
+	info->fix.smem_start = amdgpu_gmc_cpu_pa(adev, abo);
 	info->fix.smem_len = amdgpu_bo_size(abo);
 	info->screen_base = amdgpu_bo_kptr(abo);
 	info->screen_size = amdgpu_bo_size(abo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 46a10c1..391d41f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -475,9 +475,7 @@ int amdgpu_gem_dgma_ioctl(struct drm_device *dev, void *data,
 			r = -EINVAL;
 			goto release_object;
 		}
-		args->addr = amdgpu_bo_gpu_offset(abo);
-		args->addr -= adev->gmc.vram_start;
-		args->addr += adev->gmc.aper_base;
+		args->addr = amdgpu_gmc_cpu_pa(adev, abo);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index e6344a8..f02143a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -671,8 +671,7 @@ void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
 	u64 vram_addr = adev->vm_manager.vram_base_offset -
 		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
 	u64 vram_end = vram_addr + vram_size;
-	u64 gart_ptb_gpu_pa = amdgpu_bo_gpu_offset(adev->gart.bo) +
-		adev->vm_manager.vram_base_offset - adev->gmc.vram_start;
+	u64 gart_ptb_gpu_pa = amdgpu_gmc_gpu_pa(adev, adev->gart.bo);
 
 	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
 	flags |= AMDGPU_PTE_WRITEABLE;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index d1211ef..9c18e00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2234,9 +2234,7 @@ static int amdgpu_ssg_init(struct amdgpu_device *adev)
 
 	init_completion(&adev->ssg.cmp);
 
-	res.start = adev->gmc.aper_base +
-		(amdgpu_bo_gpu_offset(adev->direct_gma.dgma_bo) -
-		 adev->gmc.vram_start);
+	res.start = amdgpu_gmc_cpu_pa(adev, adev->direct_gma.dgma_bo);
 	res.end = res.start + amdgpu_bo_size(adev->direct_gma.dgma_bo) - 1;
 	res.name = "DirectGMA";
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index 0cf9937..7beef4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -134,8 +134,7 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
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
index 7dfe58b..5c569d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -571,8 +571,7 @@ static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				 uint64_t *addr, uint64_t *flags)
 {
 	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = adev->vm_manager.vram_base_offset + *addr -
-			adev->gmc.vram_start;
+		*addr = amdgpu_gmc_gpu_va2pa(adev, *addr);
 	BUG_ON(*addr & 0xFFFF00000000003FULL);
 
 	if (!adev->gmc.translate_further)
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 90ed7089..3f488f7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1067,8 +1067,7 @@ static void gmc_v9_0_get_vm_pde(struct amdgpu_device *adev, int level,
 				uint64_t *addr, uint64_t *flags)
 {
 	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = adev->vm_manager.vram_base_offset + *addr -
-			adev->gmc.vram_start;
+		*addr = amdgpu_gmc_gpu_va2pa(adev, *addr);
 	BUG_ON(*addr & 0xFFFF00000000003FULL);
 
 	if (adev->gmc.zfb_size > 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index c3f962b..bda510f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -132,8 +132,7 @@ static void mmhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 8ea3b22..8862ac2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -157,8 +157,7 @@ static void mmhub_v1_7_init_system_aperture_regs(struct amdgpu_device *adev)
 		return;
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, regMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 637d734..a636b2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -209,8 +209,7 @@ static void mmhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	}
 
 	/* Set default page address. */
-	value = adev->vram_scratch.gpu_addr - adev->gmc.vram_start +
-		adev->vm_manager.vram_base_offset;
+	value = amdgpu_gmc_gpu_pa(adev, adev->vram_scratch.robj);
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_LSB,
 		     (u32)(value >> 12));
 	WREG32_SOC15(MMHUB, 0, mmMMMC_VM_SYSTEM_APERTURE_DEFAULT_ADDR_MSB,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index 79ac6d7..ab09663 100644
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
index b5f0eca..78728da 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -165,8 +165,7 @@ static void mmhub_v9_4_init_system_aperture_regs(struct amdgpu_device *adev,
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
