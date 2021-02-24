Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A149BC433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6202864E05
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6202864E05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 862F16EB9E;
	Wed, 24 Feb 2021 22:22:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC6E76EB92
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:22:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYcIYtwNtNtT5sEu2Rvr+t5TgmdDXZ9xKHrJmNQAwUE4uJ720alfL0n1PAPVVyOqBDffoZtOMuvgKsuIS0AlrI99qZ10dDAY0yjceRtiOlsAvC79nu6efBVslci2G4lhd+XsIDWCy6SEzyPuLAJt9dhDNhqwWIzqgdjIh6Q0VUT5WVuxe0rKlAkGH0I5oktWl8PcZVlGvdMoMz09xM4rpovtXrXQCfS2rGmNgwgq/+17ri3GlNPj9U9eJZ1RcG3s3t5sqPMsn7AyUvC5UZtA4qdrP6haeC9gw4POjjPJWx8MZlH9NAi5UlO6+UVG8vO2MGQCvEnW3+CbYfwtg+m+2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqCC1nTPWXjCPlAqA/rTebNnNI6EtQWr3A5OyHqvjZI=;
 b=BwI8IZYwPjHSPhjltZihvlm4+hBq+CML00IN5BXMwvEriwvkNMRos8npmdK05YWI+Hyfoh1z7szHabPxKZ56vu/DD9Z4kkCzvo7tFXDOhkXX1Y0XEYSacX19f4aXtJNJBT7QCf5mOFHH3jg0/jS9NudyWHinHka+N4WOkvs1ebGtNjmhAIw5Pop8cE78gWHQECAyZyQVeye3INKj1Bfve4B+PSsKnGwuUgFvv4HpkLUhB7hqjhx9CqQNNQlxiI7cbkNyjfJiOCOXfagqWWDvkJtb7FLMlaB6CTaD22QthI58RgJ9FzDqU9KbHNo2lBwWybgbyyxnpvb5v0LkFGtqTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqCC1nTPWXjCPlAqA/rTebNnNI6EtQWr3A5OyHqvjZI=;
 b=C9etD59oobsrFyAwpBucVEgKh6PBlwAb9+5mBo5uFdjE+3hRm78dTWqPKxZ9t27nDvQM7gwfLw8FmV6IJgdShpJwRKn+hD1NLGlbMhtPNeHWfPq4/i0MD9tkcgqEU+580knu04Zs1BJp2YOnofdimGviEXExL50WUnWA8kSEXAU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4503.namprd12.prod.outlook.com (2603:10b6:208:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.30; Wed, 24 Feb
 2021 22:22:28 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:22:28 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 132/159] drm/amdgpu: Add function to allocate and fill PDB0
Date: Wed, 24 Feb 2021 17:18:32 -0500
Message-Id: <20210224221859.3068810-125-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210224221859.3068810-1-alexander.deucher@amd.com>
References: <20210224221859.3068810-1-alexander.deucher@amd.com>
X-Originating-IP: [192.161.79.246]
X-ClientProxiedBy: BLAPR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:208:32b::32) To MN2PR12MB4488.namprd12.prod.outlook.com
 (2603:10b6:208:24e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (192.161.79.246) by
 BLAPR03CA0027.namprd03.prod.outlook.com (2603:10b6:208:32b::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Wed, 24 Feb 2021 22:20:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d0c8752-936d-43e6-76e6-08d8d9127261
X-MS-TrafficTypeDiagnostic: MN2PR12MB4503:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4503FC51699069C9C1844762F79F9@MN2PR12MB4503.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKcyvHIUTrKcOzvsChlvGEHKWMg7obbnm1an5taSppGC+EJVE1s6crbkkVC1thszg831CXDkGH0wJs0gAxizDGJMvXBhjNNcq182d3wNi+4USeMXEccIX9XCuBP4EtBRU41Uq4uU6FJQqLsZOfzERNGNLYvT4OffP/YFsu7jq+i8dbMzVpkPiRn5T5KkFELSQDAdJ8FLZZ6imGOR1o7OxL9gwApyPhSQCEs2K0zK2sScpV9NnA0xD+9REVN1LsLwePSsewHD0REd0Vb0aZaxc1HyEAMUqecGyGjNVUSn/D1fRhTQJyi9vW3KT9sn6OFclnpAjPTwsA5EX9fJiR6Tt5c8JKOcsLV+Co9466p1eCF2nIjA/2cAzD9+iseu4qX2/l6sPp18apTLx4aOZT8VcVcLsW+PEl0viCrCwJgr0a2wuk6sAhSYUubdTTFif0Y03p+DXCxR5FVA0Nz9qsZYCz+uOZGtV+TUQx8bOikCCW0Kpb19nbZx04V7vJb+1u8eUNkFuTqcH3axt0RtBRVes9vZhUeL+aIisgsp0qZjhdM8XDj5jgHVLVdwHawx4ryx3i0LhryfkBLy9Hrc/VhASw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(6916009)(52116002)(478600001)(5660300002)(1076003)(4326008)(36756003)(54906003)(6506007)(6486002)(6512007)(66556008)(6666004)(83380400001)(186003)(26005)(66476007)(8676002)(8936002)(2616005)(316002)(956004)(2906002)(86362001)(66946007)(69590400012)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?/GTYZfVmjNqTT8pgojZYTkdLLoNNO37KdMr679zQaoGocdaUkcQ4iBI2SmoT?=
 =?us-ascii?Q?wACPhkRYIhzPN85M3a5aRCP966rXrV28aYWvnGkTaU6QdSl7Xyqo9oXrDR5D?=
 =?us-ascii?Q?GnUdYXLHWyLxOH91BG6QDsYUhFlirpiFy0TG8YSPyPUjevKzDabpmXx1ECmy?=
 =?us-ascii?Q?CKV6+pFzNRnud1kJkxwwzugRL3TY8sFV0npM8WHaBpufa9HpG0oqG44lPEDc?=
 =?us-ascii?Q?7mlPKL1TTfr7p3GDNYMw1VHT34fMFPa6bsQHF7O61PzmAKm7X1kgltc6o67v?=
 =?us-ascii?Q?rF4A9Fr267l24SqFf9ozwfMnFcl/G0zfGM+nhTNpg3GayRNOaKzluVT5VYR+?=
 =?us-ascii?Q?r17otFFzW09XkOS3BeGraEUWSGka2diH0Ag7aEAsQPJbmhRM78o7JissRfnJ?=
 =?us-ascii?Q?sEM8/H7oi7+naak+QzIBBlvIwLdQlDrVJplUqlZ8X8z3/evxyU1D25kSU7CM?=
 =?us-ascii?Q?UavfrZGtvvKTpvWxIrU83Gyqo45pVWJqJBgd8RKnmURa82su8vbZ8z2HzOFb?=
 =?us-ascii?Q?vMylHuwHiPyDazkQxxJuGKwYs5iKqhg8bZ6c9Dgzg7piaxvdYEQlxt/VoOwX?=
 =?us-ascii?Q?UcV7NXjUB1i+SHqyjL0tGz4bSSih0+Pj13leFCxbngMuAg6Ex14VvMOw2emE?=
 =?us-ascii?Q?UWTwrKyW8EfJdWNak0hVEZKd+Bs0eM1K41aWFZ2AFSlkeBKLeWpxNU+lBYBL?=
 =?us-ascii?Q?rDAb7bUOjeO7UuovLYltxh/1wepvIkX1zC9D9Qrb/rPCxJ3E27LG6djJUK/s?=
 =?us-ascii?Q?/lLHdR9VQstlSO+83H6XSQjfxW38W/mNQfyT1ZEDhJi9H7ASM1MmE4up+dco?=
 =?us-ascii?Q?oPjeEeHbCIAOa23EwbmnsLnMVNA+fkylRj7SIJ501Wfgo3M4UgvyCRsBiuZc?=
 =?us-ascii?Q?ZCS1mBcZ9BHa4kKPvemDHqBg+RwZ2RKE9KSTadlD2J/M5ipr3mmzwSNG0qzd?=
 =?us-ascii?Q?nKrT9N+SoaQPsej4MJ7mMmHB6TdmzmYb0+9j6u+fc8Bd0cvtkt1WNGdrYzhQ?=
 =?us-ascii?Q?y1ur9AWU4YZgvXekSLoYpHiQIUdI4z+SS4PRYv8vqTGGHuv7PJjSbBP4nVY2?=
 =?us-ascii?Q?VyIlHhi7ScMUiTUCvzBDLTNWoK0Fo5YLPJdfjKHRm4BwGUT+eJVMczguF5gY?=
 =?us-ascii?Q?EaU9/CJBo7mnGz3b5LNncsF0xnKhFt4bbjKPYjTPxA6do/teHaIwyRbfCpED?=
 =?us-ascii?Q?qiv79KVolGDVeesYeO+JFbwmT7fbHu3CWfeYNsquOxYjSlVAJdVyRQthr+U1?=
 =?us-ascii?Q?w/av/J3kKmzkMHlhMbaJXL0OLBEPwI3qN2nuIRTOoVnUIy0b948fTjidHq4L?=
 =?us-ascii?Q?3eUmOcL3a0XPhMNzre1tWNXX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d0c8752-936d-43e6-76e6-08d8d9127261
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:20:52.6744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZQYgIVCRYSQXwt/spJ92uglQBs+oKh2mskaCZOLWHavLZw+eLAX3HWun/Xe+LawdG5aenpyLmR6umuasT7DYIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4503
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Oak Zeng <Oak.Zeng@amd.com>

Add functions to allocate PDB0, map it for CPU access,
and fill it.

Those functions are only used for 2-level vmid0 page
table construction

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 103 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   5 ++
 2 files changed, 108 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index f492ff8facd3..2be31ad8e31c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -31,6 +31,57 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 
+/**
+ * amdgpu_gmc_pdb0_alloc - allocate vram for pdb0
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Allocate video memory for pdb0 and map it for CPU access
+ * Returns 0 for success, error for failure.
+ */
+int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev)
+{
+	int r;
+	struct amdgpu_bo_param bp;
+	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
+	uint32_t pde0_page_shift = adev->gmc.vmid0_page_table_block_size + 21;
+	uint32_t npdes = (vram_size + (1ULL << pde0_page_shift) -1) >> pde0_page_shift;
+
+	memset(&bp, 0, sizeof(bp));
+	bp.size = PAGE_ALIGN((npdes + 1) * 8);
+	bp.byte_align = PAGE_SIZE;
+	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
+		AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+	bp.type = ttm_bo_type_kernel;
+	bp.resv = NULL;
+	r = amdgpu_bo_create(adev, &bp, &adev->gmc.pdb0_bo);
+	if (r)
+		return r;
+
+	r = amdgpu_bo_reserve(adev->gmc.pdb0_bo, false);
+	if (unlikely(r != 0))
+		goto bo_reserve_failure;
+
+	r = amdgpu_bo_pin(adev->gmc.pdb0_bo, AMDGPU_GEM_DOMAIN_VRAM);
+	if (r)
+		goto bo_pin_failure;
+	r = amdgpu_bo_kmap(adev->gmc.pdb0_bo, &adev->gmc.ptr_pdb0);
+	if (r)
+		goto bo_kmap_failure;
+
+	amdgpu_bo_unreserve(adev->gmc.pdb0_bo);
+	return 0;
+
+bo_kmap_failure:
+	amdgpu_bo_unpin(adev->gmc.pdb0_bo);
+bo_pin_failure:
+	amdgpu_bo_unreserve(adev->gmc.pdb0_bo);
+bo_reserve_failure:
+	amdgpu_bo_unref(&adev->gmc.pdb0_bo);
+	return r;
+}
+
 /**
  * amdgpu_gmc_get_pde_for_bo - get the PDE for a BO
  *
@@ -552,3 +603,55 @@ void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev)
 		adev->mman.stolen_extended_size = 0;
 	}
 }
+
+/**
+ * amdgpu_gmc_init_pdb0 - initialize PDB0
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * This function is only used when GART page table is used
+ * for FB address translatioin. In such a case, we construct
+ * a 2-level system VM page table: PDB0->PTB, to cover both
+ * VRAM of the hive and system memory.
+ *
+ * PDB0 is static, initialized once on driver initialization.
+ * The first n entries of PDB0 are used as PTE by setting
+ * P bit to 1, pointing to VRAM. The n+1'th entry points
+ * to a big PTB covering system memory.
+ *
+ */
+void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev)
+{
+	int i;
+	uint64_t flags = adev->gart.gart_pte_flags; //TODO it is UC. explore NC/RW?
+	/* Each PDE0 (used as PTE) covers (2^vmid0_page_table_block_size)*2M
+	 */
+	u64 vram_size = adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
+	u64 pde0_page_size = (1ULL<<adev->gmc.vmid0_page_table_block_size)<<21;
+	u64 vram_addr = adev->vm_manager.vram_base_offset -
+		adev->gmc.xgmi.physical_node_id * adev->gmc.xgmi.node_segment_size;
+	u64 vram_end = vram_addr + vram_size;
+	u64 gart_ptb_gpu_pa = amdgpu_bo_gpu_offset(adev->gart.bo) +
+		adev->vm_manager.vram_base_offset - adev->gmc.vram_start;
+
+	flags |= AMDGPU_PTE_VALID | AMDGPU_PTE_READABLE;
+	flags |= AMDGPU_PTE_WRITEABLE;
+	flags |= AMDGPU_PTE_SNOOPED;
+	flags |= AMDGPU_PTE_FRAG((adev->gmc.vmid0_page_table_block_size + 9*1));
+	flags |= AMDGPU_PDE_PTE;
+
+	/* The first n PDE0 entries are used as PTE,
+	 * pointing to vram
+	 */
+	for (i = 0; vram_addr < vram_end; i++, vram_addr += pde0_page_size)
+		amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, vram_addr, flags);
+
+	/* The n+1'th PDE0 entry points to a huge
+	 * PTB who has more than 512 entries each
+	 * pointing to a 4K system page
+	 */
+	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SYSTEM;
+	flags |= AMDGPU_PDE_BFS(0) | AMDGPU_PTE_SNOOPED;
+	/* Requires gart_ptb_gpu_pa to be 4K aligned */
+	amdgpu_gmc_set_pte_pde(adev, adev->gmc.ptr_pdb0, i, gart_ptb_gpu_pa, flags);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index d5312b8e6abf..d5f3825cd479 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -247,6 +247,9 @@ struct amdgpu_gmc {
 
 	uint32_t	vmid0_page_table_block_size;
 	uint32_t	vmid0_page_table_depth;
+	struct amdgpu_bo		*pdb0_bo;
+	/* CPU kmapped address of pdb0*/
+	void				*ptr_pdb0;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
@@ -288,6 +291,7 @@ static inline uint64_t amdgpu_gmc_sign_extend(uint64_t addr)
 	return addr;
 }
 
+int amdgpu_gmc_pdb0_alloc(struct amdgpu_device *adev);
 void amdgpu_gmc_get_pde_for_bo(struct amdgpu_bo *bo, int level,
 			       uint64_t *addr, uint64_t *flags);
 int amdgpu_gmc_set_pte_pde(struct amdgpu_device *adev, void *cpu_pt_addr,
@@ -317,4 +321,5 @@ amdgpu_gmc_set_vm_fault_masks(struct amdgpu_device *adev, int hub_type,
 
 void amdgpu_gmc_get_vbios_allocations(struct amdgpu_device *adev);
 
+void amdgpu_gmc_init_pdb0(struct amdgpu_device *adev);
 #endif
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
