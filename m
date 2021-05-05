Return-Path: <SRS0=nRto=KA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD874C433ED
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 21:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7528861042
	for <amd-gfx@archiver.kernel.org>; Wed,  5 May 2021 21:50:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7528861042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 730F56EC71;
	Wed,  5 May 2021 21:50:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52AA46EC5A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 May 2021 21:50:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zaql98i5KGAmgq30vvwx76/go8I57CdI6SZYN4s13KVitVKiBzoctnxwBMrXmvenQtlwxNGOd/r9ajf9u3AtS0AGny70GEgkx8Nn6SlJnsID8yMIRoY+jOn0o/H1QLtj+lZu5SxsPIdH4jvJSbI3mijXY5h2sDN570+bO9LDTjeT92I7Tcn0xb9ggz4DzX5Kf6la9ayllomyoSumW3RpOJMMGZv4oPVfz4FbCxUVUmj7eAwbWo6DxP0I8Ilzba0900e7HbI4UvXWqtwxGl8raLltp5d5B7ptWNYReuaDUD1FFUrfHTDA+8IiZh54g3ulbSo21z/IyXCThf+rOy6uEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEUoldA4JbZGfcE1etn1Xf7/BUiDSmTqIkU6I2WaFqs=;
 b=a5l4qwFz1ShvPCF76Uy4UWqdEoY/LgNxfGriVA4fhLXIQes9U9dd0oDgDEYDVDKE04Peusls8pm8pnAmvinTJOYwDQz3sBs/YBwY0AC63wWPcUgLIVFQuKdePjF0tHQKRP57iTnnnVtWnhqoUY5ozVurnMCBv3+L9Fj0zMAbdPceA/69A12XmOoFff8TiwoKWNnl4f9fExg1nPjXqqeiPRp95ONTrqfqyqAX16mewcI5OQN4sycFWXbwaqxWk2CjUOqIvrzpVrVej1Xj0NJnnqZW/lBtWLj4OT9i0y11leNhg5JcdDjFFJYc97oH7JNS27xo/VKNV4ZkbrQ4kkBmdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEUoldA4JbZGfcE1etn1Xf7/BUiDSmTqIkU6I2WaFqs=;
 b=Vp8xHfZD2VVebGrGk3gd7fA9Ni/bepmD3OIt+ApGjosji08djOtqDWb4Hw0vwnjIjUlJlrk9YsRu6dqee9t9p8e2tnV7nNKDegaJfDOMmpu6h//nFASs03mfVovdZXY8HUw22JfFtQfsiwR4VXY72K/uLzPX6Kio+/l0/UOGXZo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.41; Wed, 5 May
 2021 21:50:30 +0000
Received: from SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121]) by SA0PR12MB4430.namprd12.prod.outlook.com
 ([fe80::31de:f08e:20b2:d121%9]) with mapi id 15.20.4087.044; Wed, 5 May 2021
 21:50:30 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdkfd: classify and map mixed svm range pages in GPU
Date: Wed,  5 May 2021 16:50:01 -0500
Message-Id: <20210505215001.3418-3-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210505215001.3418-1-alex.sierra@amd.com>
References: <20210505215001.3418-1-alex.sierra@amd.com>
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN7PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:806:f2::19) To SA0PR12MB4430.namprd12.prod.outlook.com
 (2603:10b6:806:70::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from alex-MS-7B09.amd.com (165.204.78.1) by
 SN7PR04CA0014.namprd04.prod.outlook.com (2603:10b6:806:f2::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.25 via Frontend Transport; Wed, 5 May 2021 21:50:28 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0201d80e-19b9-4dc2-7e6d-08d9100fcc59
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4430E4F72075EABADEBFF6FAFD599@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fi82DxzlGlD6+fZV0k3I6RwnUegiyLZrZOfKUy7tcQWDGIhaWKO8cmuCjoUcW+Pd8jrdfbBSTGVJHSGkxDJ3h+PHu8JQXp8tEe7hauGye47AuuJWmPhLyovsPaial/mdFlJ9SBj3ZmGO02bWqOPtxmc2OsDWdTV0/BkLCfUD/io1WW65pwzx4ZdRnnmJtSUdJYLTiiQHrqZ6asBori3DMoENAWRCsVDFJEE85Lk/dKwDKnolcAKHxH0Z11Oi6H3cbPRYDnVGQ+AmJzcQVkBHPjoUW8R5a9tGfeOi+qFKpvR+afU998HTvCK98oCH7smTMTEZimAhl7TWi2E76Xrd6zL4Tvq8RJZxJ+uYaJLI1YADsW69AtemJDO1fiQYdEjmFLl2xcGPEIF9inCCtkphpW0p/Wdp97Nwhd5rZcJY0UwWSNtZ8IhItB7a96a4ORIQbEU/qZn522uQVBfV18pA+ogiGrMQ+fzMNpAFjgqAfRvXukX406DDuMJ1mbjrIj+sbNJxchx3UKHaTGFM4Om8YxyZr8thJqTwV9dHvF7DVo3+y7sNPwKVm0lSfqCBDLehIxrl6uH4yeGQmWivlmuW6+p0pVeFvOMqx721T6d3JYt+4NfEom/DhmduhDGhaz7opt3zT1rGx00Nvz9akjX6uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4430.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(6916009)(36756003)(2906002)(44832011)(66946007)(6666004)(66556008)(66476007)(6486002)(1076003)(52116002)(7696005)(2616005)(956004)(86362001)(26005)(316002)(5660300002)(4326008)(186003)(38100700002)(8676002)(83380400001)(8936002)(38350700002)(478600001)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gU0u6GOraDZshrqta+0vLlMyPBOvLOdT1+nzptXNxIyYXy69+PQPHIpbvFFR?=
 =?us-ascii?Q?2TeMuxgtw+Jdq6TJd9Uk6RA1VycLzIXkmOroprw3ANGxH1VLcnCtKOWlB+QC?=
 =?us-ascii?Q?gozH8KynmnrqM8S67gENwJcXMWCJhLACPLLyBnrb9LkjzWvCHzpML28SoLQW?=
 =?us-ascii?Q?MAfNyBwnGLKjP/f3K/aUUa1bS6B1uZMnZLgG4sP8CjqhABm/GumHNDtbrq/Y?=
 =?us-ascii?Q?QkAFmVqkXC9GulkToxHIjBzb7rUZbHqqoQSLfAgueZLCzeocyF+jqA4a4n7v?=
 =?us-ascii?Q?OVA82jQWllNudBkkohwwmi3WPoGubO1TDWONvWtHdTLrJrbYPz86vRY2wj1f?=
 =?us-ascii?Q?AS4mN6FT+ZNOxDLsYY37KoYyxHf4ex025RL2CGLftg9Jos1dtS4+dilryPD3?=
 =?us-ascii?Q?jU1TTqxQ5g7l2LWofKN2xRrBtknEWfzaYAey5C34yL0Gl5t/NLoEf1u7FOrH?=
 =?us-ascii?Q?hXrEOP4zMVVhkrtVp4xxPHm7sP84+BaqgkWsQugCd39pGAa001C69pb9Eqhh?=
 =?us-ascii?Q?RUK42/rwbg0MyT3JMtgQdwZw+svyTLtVSgMj+Uvbyqq6i5BTawnvOAlWFPdB?=
 =?us-ascii?Q?BARoZH/bULRmzjJkPCvMJoEzUff6vG0e4wro2hkFWB6ewI5PPQRjd6uOUR+w?=
 =?us-ascii?Q?+0OR1s+fSShNyH2EWdVkPlqJbxrjDs3nZ44qX7xW7e3aaKCYJsI0R9jwAhZW?=
 =?us-ascii?Q?n1AK+onDZIo4hMnjbQa5zbJg0WzUcpmIWRiVpZyfUhz8YcY+Dq1JFDPQh9LH?=
 =?us-ascii?Q?ElMqZOO2qpsrh0Ys+NhR5xhbACbKypTsgEqH84/WC9jNdhJ8FAb2kx6AhHI/?=
 =?us-ascii?Q?tW/Jyik/i8/MedMY8QYlrAIfFwjKP2O/TC/4HTVhDiqviE9YE2s8L0cd6wbY?=
 =?us-ascii?Q?dYmaiojUN7OcEVNaBlG0HBzJBuwDE7snyKrrKKaixpH3b0MmtrBJztKZgbvH?=
 =?us-ascii?Q?jubrgGCgQdCqlcaQmo5pw8QLNuCg4LLHFgIXKgFX1Uxg8FePiH/vd8pfZZEO?=
 =?us-ascii?Q?Ou1cPaxS73pcvY+RCYMtqR8k/gPiADeojf9xNYS7RXXUVi+LQMn+j5RihzMZ?=
 =?us-ascii?Q?kHcYfnKxRKT9RaQMnaVzXGvU5NVJfGW5LTr1WUBnoy2O26Ik1ecbaTVoGtTc?=
 =?us-ascii?Q?PsPTNH2IYWuDUFJlHYp330OfgmvRZdMscgB3QjV9jyNHYv87PZfRUOMCv3Dr?=
 =?us-ascii?Q?DYhJticFFSU+4Mss4qUzuhWUbp09um529yfQvmpvNAruQE3dy2euXQLFNVxw?=
 =?us-ascii?Q?nVN/Gjt2mrlSSz5vJpPZUf+IlQhbQYdgtoH/ViM8rpIgZ40NBXSjnTp5Sese?=
 =?us-ascii?Q?Xc2yTlSDMfh9NEvqE2qqv3L3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0201d80e-19b9-4dc2-7e6d-08d9100fcc59
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2021 21:50:29.5805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OKWGKbh851IMjfHAnA/FCDR8IPb5VX6+/qFYhjdau9OMz40HXG5cuZ1CV8df/7KnxcjvNOaHgoA79GCcRwdq3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
svm ranges can have mixed pages from device or system memory.
A good example is, after a prange has been allocated in VRAM and a
copy-on-write is triggered by a fork. This invalidates some pages
inside the prange. Endding up in mixed pages.

[How]
By classifying each page inside a prange, based on its type. Device or
system memory, during dma mapping call. If page corresponds
to VRAM domain, a flag is set to its dma_addr entry for each GPU.
Then, at the GPU page table mapping. All group of contiguous pages within
the same type are mapped with their proper pte flags.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 58 +++++++++++++++++++---------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  2 +
 2 files changed, 42 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 7683cb44cb9c..045a961f7978 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -141,6 +141,12 @@ svm_range_dma_map_dev(struct device *dev, dma_addr_t **dma_addr,
 			dma_unmap_page(dev, addr[i], PAGE_SIZE, dir);
 
 		page = hmm_pfn_to_page(hmm_pfns[i]);
+		if (is_zone_device_page(page)) {
+			addr[i] = hmm_pfns[i] << PAGE_SHIFT;
+			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
+			pr_debug("vram address detected: 0x%llx\n", addr[i] >> PAGE_SHIFT);
+			continue;
+		}
 		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
 		r = dma_mapping_error(dev, addr[i]);
 		if (r) {
@@ -1131,33 +1137,49 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
 {
 	struct amdgpu_bo_va bo_va;
+	struct ttm_resource *ttm_res;
 	uint64_t pte_flags;
+	unsigned long last_start;
+	int last_domain;
 	int r = 0;
+	int64_t i, j;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
 
-	if (prange->svm_bo && prange->ttm_res) {
+	if (prange->svm_bo && prange->ttm_res)
 		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
-		prange->mapping.bo_va = &bo_va;
-	}
-
-	prange->mapping.start = prange->start;
-	prange->mapping.last = prange->last;
-	prange->mapping.offset = prange->offset;
-	pte_flags = svm_range_get_pte_flags(adev, prange);
 
-	r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
-					prange->mapping.start,
-					prange->mapping.last, pte_flags,
-					prange->mapping.offset,
-					prange->ttm_res ?
-						prange->ttm_res->mm_node : NULL,
-					dma_addr, &vm->last_update);
-	if (r) {
-		pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
-		goto out;
+	ttm_res = prange->ttm_res;
+	last_start = prange->start;
+	for (i = j = 0; i < prange->npages; i++) {
+		last_domain = dma_addr[i] & SVM_RANGE_VRAM_DOMAIN;
+		if ((last_start + j) < prange->last &&
+		    last_domain == (dma_addr[i + 1] & SVM_RANGE_VRAM_DOMAIN)) {
+			j++;
+			continue;
+		}
+		pr_debug("Mapping range [0x%lx 0x%llx] on domain: %s\n",
+			 last_start, last_start + j, last_domain ? "GPU" : "CPU");
+		prange->ttm_res = last_domain ? ttm_res : NULL;
+		pte_flags = svm_range_get_pte_flags(adev, prange);
+		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false, NULL,
+						last_start,
+						last_start + j, pte_flags,
+						((last_start - prange->start) << PAGE_SHIFT),
+						prange->ttm_res ?
+							prange->ttm_res->mm_node : NULL,
+						prange->ttm_res ? NULL :
+						dma_addr,
+						&vm->last_update);
+		if (r) {
+			pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
+			goto out;
+		}
+		last_start += j + 1;
+		j = 0;
 	}
+	prange->ttm_res = ttm_res;
 
 	r = amdgpu_vm_update_pdes(adev, vm, false);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 573f984b81fe..bb85288cd658 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -35,6 +35,8 @@
 #include "amdgpu.h"
 #include "kfd_priv.h"
 
+#define SVM_RANGE_VRAM_DOMAIN (1UL << 0)
+
 struct svm_range_bo {
 	struct amdgpu_bo		*bo;
 	struct kref			kref;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
