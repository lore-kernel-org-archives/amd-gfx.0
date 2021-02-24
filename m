Return-Path: <SRS0=z84W=H2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907D9C4332B
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5807964E09
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Feb 2021 22:20:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5807964E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2716E6EB45;
	Wed, 24 Feb 2021 22:20:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2042.outbound.protection.outlook.com [40.107.220.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA02A6EB3E
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Feb 2021 22:20:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyQGzdtFv1YCWU8s60DhHoTOfou2cbdwAKg6gGCW8rwI6EJWAfVH1jbel44f2Ftvvvfhxi+4tVoIHHY7BZAbJN09AAFlCupwQxtyiWrp+IEvG32yeqpdQuUvbNfYX7G5YpQC0hXMq+fxQy8TnhFU6n8oeOSQgZkHJakiXa5mVhmaI2dLmUkzYv/r5RSAI7mamhlOGIra9cZ7OGlxEo2BG7fWYZM+BhFsWiiZPPzy+HxvxHe22fjh5IVJVsRIpFWWotvmDidXuscjOE5P2c5Hfgs5m7YMyN4NQ8yadQwlO449TjWdA8+cJCa6ATgVN8wmhh4t7cYxIn9HJUlm3jwH8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuJj249kkPzLY667k1IGh+rQGc3tUeLhKFk+gb8GjgM=;
 b=WVdgU/MH+ycd7EBm2YIfetdEzcR8XRyCzJ851rD/ZBCTA8DBWA934jy5A5vsSm3Ko6yiR5m/p7zECh0pRAPtcjZmm9HXbnenZ6DBPhYGG9CQTBLyT/+DxFavMngBbbRI9TtPaUJKkvDR0WCddzQNnuHkMVi26S94k4cufOMw5bs4f973SUa8WGa7DGcFVSXYbctgkv4kGmyyew2kl0ZRe2WhNQEX18Lgf5bLPcp6HJX3A04K2LrX7EOg+whLUw2cIlzZjuE1W8YSCy7L3+552ONjsWzzA8apuatei05C7g0MFECcNJDTWaXhTT460aQyTZ8F++XMxNkU2dAIidRpQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KuJj249kkPzLY667k1IGh+rQGc3tUeLhKFk+gb8GjgM=;
 b=Ju1HjfwyZpz4ABmYKMdVVrdcT24MGx85fXIizdtEomPGlbaPyUv2lKKMh6V6qdhBwk+GPQxFy/7v9B8p4vdSzKfbkbmGT5zCsooFm5oqtYXjctTBW5yzJpEFO6BPEFyjBv3TRg4uFrntFy12J/Rp6L7boH/BbIpjJNRdmTANNy8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB4865.namprd12.prod.outlook.com (2603:10b6:208:17c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 22:20:20 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::b0c4:9a8b:4c4c:76af%7]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 22:20:20 +0000
From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 048/159] drm/amdgpu: new cache coherence change for Aldebaran
Date: Wed, 24 Feb 2021 17:17:08 -0500
Message-Id: <20210224221859.3068810-41-alexander.deucher@amd.com>
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
 Transport; Wed, 24 Feb 2021 22:19:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70cf9b6a-a618-4b17-7edf-08d8d9124ee0
X-MS-TrafficTypeDiagnostic: BL0PR12MB4865:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB486569F19FF0A8157428D75FF79F9@BL0PR12MB4865.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:935;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BQ4tZ5dS7SAmB5Bnmom6X72N8uixbga1BS8XqMqWHAnKQD26usElqpIFe628UqDyn2ckHhJt4js/5lGm2vAWfEUiEYpHoVg6K+GSTONMKOryahjNpGt97SKt6pZj7LPbQAzmcUPQs2cFHFDAhDChKVuMFZ7XWmHOaFFUzrZaF2yI1/AaUffLlDie5PAZIYxoaPksqnvihMAGxnZ5bPAkg0VY5GYzwUPqxt1iURzs5KJKDeFodoKVdTW4NS1BxoKu7ssVhMeZmNv1WmU08KhY5lWl1l0BDpTiKAG/fsvOXGVRBSB9qCLw3EKL0fY+oBE0yobDLNVk5K47KInFuKJLB73RDhiXN1nQ9UoaxpdG9HaUqgb80desaJnDpe8x/W+0iUXiOjofK+spKVpAQpdkGMXwAgP44zB8cpJ1XMeV+SrxuGWkCpExRCRghk0idrD0fyrIx0EPfgRmiv843E9aoRaWZideUQ7xPFs7yQerZH7H9FcDJsWsAJ0zoUNbOK6VXHOtr1LJhd7Qy9Senf2yMS1+eNpxZZcYO0SE2IkhlfyNG+XPc2qvsjRK4mCQ1NprAmz3UWRDXfHdTdWxh+YFgw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(6506007)(478600001)(316002)(66476007)(66556008)(86362001)(2616005)(5660300002)(6916009)(8676002)(956004)(36756003)(1076003)(2906002)(6486002)(6512007)(26005)(4326008)(52116002)(186003)(66946007)(69590400012)(54906003)(8936002)(16526019)(83380400001)(6666004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mKG3uZRjEH/S7WSwE8pHsTNzHDyBErDi8SymznuHQQvFqZwhioRtgTywMM9W?=
 =?us-ascii?Q?vwF7b0fElKu4qclj/nGFhYf9F4Lm75T6hBnmjvC1RNyKyDd226LujYCkMNcG?=
 =?us-ascii?Q?BQKUcm4yBL3+3XCZJdh/+/QseHPeXdcF67e/ZMLevPlNqYx8Si7HAuEtBjgn?=
 =?us-ascii?Q?rZUdKgxigp0XZpJFMDIsXsbXWwNuqP/elTGtCXTRkxXtKRnrJurTnaO+twcN?=
 =?us-ascii?Q?+/a0fqJKmLS93dQWuztCMNcuip6oz0HxEOP9NDyUkZUiORyo7B5c3XeP9OgF?=
 =?us-ascii?Q?Fh6I7ncH6o5nkjygaLl+Q+RPiwyqu+MqQaIJ6oGCxIG/x9XaFRmyEfQm+Txv?=
 =?us-ascii?Q?ANI5Ymyy+uZUB8WOZqOsvLO63awSEhaBIGCR4W4d7ctIqfxkN7YmdpuNyc5Q?=
 =?us-ascii?Q?el4O/pz9QY86aP28wVOPRNv/qjb1buEwYL9uA+HHDjkruf6KoYJ161C5103a?=
 =?us-ascii?Q?cDVRHvjhWPTUvPqOc8aM4+pezLWbAFCDHW6blJrJfysmx85BvwvI4D3+Sgad?=
 =?us-ascii?Q?0JE3zQvBiLQ/oXuypLEMRLfzwHIFqbmesz8gJN7WZh9nSD6rI+DlVIw4nTpe?=
 =?us-ascii?Q?x/XvVOEKSNasuwnBMMFTJ6i6dwpdUEWuuOqxwMe0BpFfh2mThUaPX6BIz6G/?=
 =?us-ascii?Q?RfNrhA91MuUQonsYlz7UfCXC7xLGlYZdzcPGE7VOfWJh/aDVTrWILofQQLG8?=
 =?us-ascii?Q?tKCKxPXPigghKfnoiVtKbGesR0+eaAzRkKc0deqvwFWHibq8W9iSAsi1OGDV?=
 =?us-ascii?Q?fGXs6VraYuHao9JgWwo6rv+3rb7/oxA4HmBiEj0Igv2hLoLosZ2tz8+qjuOi?=
 =?us-ascii?Q?XAJo8YwXyZIfl6y/48x6T26P+6dOzOyJQ1RVDlQuAcZ8C25AfumDMseIMa3/?=
 =?us-ascii?Q?oqSKWAU+aU93iD1+kBRUcb068tdkB7hPQrex0vauTfi9EYN8oRFB2mCWnMfF?=
 =?us-ascii?Q?sxtgwywLqrsLeKpJy3u5N8eIcq8rhmEUdCwQWvOpPI63nAB76F6elLF9Wwqx?=
 =?us-ascii?Q?5EJ+5lbrd01/3Yu7A07ZWeHPzY/26cIUIUXg2Syrq2HreJQpi6mQ1QJKJXfr?=
 =?us-ascii?Q?aQEtv1BwdaYfsBD1EjmyvbXELyfiNhgdLX1fAJIHvyQDFBf/etv3ANROjF6f?=
 =?us-ascii?Q?Wsu+DC6ABCb41vdufDCIbMpV81ZTd8lCc7CZw0Y7PCGAyDkAr+K5UgF37iEf?=
 =?us-ascii?Q?9JggGf7pwonkFkb8+bMSn+v9gzXL7LUoIGJUR/SUuEG/4f6a27pfZ58j1GQY?=
 =?us-ascii?Q?aJfiuOHjK21oU5LbIMNIPaQJbW+pPgVdJZTN16Hj5shKR23r7QupcIAXQDlv?=
 =?us-ascii?Q?asDWUv3NjGcXoU8MQiDTiq7s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70cf9b6a-a618-4b17-7edf-08d8d9124ee0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 22:19:53.0731 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y278N5AJWh6GqTURebj0HCbR1bnYcUrqsGJrQOZPx2KVme23YkB5wfoLpSNeI9ljLF/0eqrVkBspgfMVmVgyHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4865
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
Cc: Eric Huang <jinhuieric.huang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Oak Zeng <Oak.Zeng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Huang <jinhuieric.huang@amd.com>

To support new cache coherence HW on A+A platform mainly in KFD.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
Reviewed-by: Oak Zeng <Oak.Zeng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 30 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c         |  3 ++
 2 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 8781051afb69..30e41d1b3256 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -30,6 +30,7 @@
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_dma_buf.h"
 #include <uapi/linux/kfd_ioctl.h>
+#include "amdgpu_xgmi.h"
 
 /* BO flag to indicate a KFD userptr BO */
 #define AMDGPU_AMDKFD_USERPTR_BO (1ULL << 63)
@@ -404,6 +405,8 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(mem->bo->tbo.bdev);
 	bool coherent = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT;
 	uint32_t mapping_flags;
+	uint64_t pte_flags;
+	bool snoop = false;
 
 	mapping_flags = AMDGPU_VM_PAGE_READABLE;
 	if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE)
@@ -413,7 +416,6 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 
 	switch (adev->asic_type) {
 	case CHIP_ARCTURUS:
-	case CHIP_ALDEBARAN:
 		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
 			if (bo_adev == adev)
 				mapping_flags |= coherent ?
@@ -425,12 +427,36 @@ static uint64_t get_pte_flags(struct amdgpu_device *adev, struct kgd_mem *mem)
 				AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 		}
 		break;
+	case CHIP_ALDEBARAN:
+		if (mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_VRAM) {
+			if (bo_adev == adev) {
+				mapping_flags |= AMDGPU_VM_MTYPE_RW;
+				if (adev->gmc.xgmi.connected_to_cpu)
+					snoop = true;
+			} else {
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+				if (amdgpu_xgmi_same_hive(adev, bo_adev))
+					snoop = true;
+			}
+		} else {
+			snoop = true;
+			if (adev->gmc.xgmi.connected_to_cpu)
+				/* system memory uses NC on A+A */
+				mapping_flags |= AMDGPU_VM_MTYPE_NC;
+			else
+				mapping_flags |= coherent ?
+					AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
+		}
+		break;
 	default:
 		mapping_flags |= coherent ?
 			AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
 	}
 
-	return amdgpu_gem_va_map_flags(adev, mapping_flags);
+	pte_flags = amdgpu_gem_va_map_flags(adev, mapping_flags);
+	pte_flags |= snoop ? AMDGPU_PTE_SNOOPED : 0;
+
+	return pte_flags;
 }
 
 /* add_bo_to_vm - Add a BO to a VM
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 94552048aada..32b552e54e77 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1040,6 +1040,9 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 	    !(*flags & AMDGPU_PTE_SYSTEM) &&
 	    mapping->bo_va->is_xgmi)
 		*flags |= AMDGPU_PTE_SNOOPED;
+
+	if (adev->asic_type == CHIP_ALDEBARAN)
+		*flags |= mapping->flags & AMDGPU_PTE_SNOOPED;
 }
 
 static unsigned gmc_v9_0_get_vbios_fb_size(struct amdgpu_device *adev)
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
