Return-Path: <SRS0=awHg=KH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C1BC433ED
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 12:35:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43F5E613CA
	for <amd-gfx@archiver.kernel.org>; Wed, 12 May 2021 12:35:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43F5E613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE166EB83;
	Wed, 12 May 2021 12:35:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77FF66EB83
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 May 2021 12:35:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsiLTZr+AeIlxPDyZf3xqSFMlvxqSLsUKI44yayVJQS8vVUaYZgqPv5dGAkfmFmKdBzj/QFMhygKbU6UVx8t9McxhfHsDw2j1R+d/qi1CdbCgVBe9Tq57iFTD3wH48FsWWUtBl3uQPjl7qiVtTs5wVHBYOS4i9mXRWUYzoAJeZmRdzCmAmlCwiXY2hTLbUtJeT/ZI+onfZyCb49f46HdnQ0k4i7Zxrj2m3SCzd95/9HURSVpxNaKCmvV8+cvudbApluSWecucXLDWw+oS03k8RskCo95rpWm4bnWXppnS2J+WSzOtAtIsyNlheJwTb5MdrrchnyomVQgAaenBQJggw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZS86rN9FlBmf7p3JAdbHe75EP6R2FYpqxfkmXTSZRQ=;
 b=Dk+xdIBPCcnbNVy51OvoVMVEW5Qje7nNg1ElzTpuqgYci46LjCHG9sZwqvEz+qpaxi5TBdRBXzqCMwu43FTb19a7LqyK5XYcEyxIGQoByPSyZZgooigiLysguPRgF82HcA+u2B7BkM0pvvubsXYmuj3XF6Ffe2S14viVBKMq9Ff60/4kRvoN08cRNh5Ea549a0K8XdkKo4oX/OBOl3uiNXVc/YFoh8V+Icduc0lRrxIlX9UnSVvCWecEdo9DEAcryuGiQ90tHC5SG8Wm48LHZiROkNsuF9jvi0mskY6L2W55Y9pGaliYEs7IEDpnY+SLYLSQWWkA3g34qbf51ZVV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tZS86rN9FlBmf7p3JAdbHe75EP6R2FYpqxfkmXTSZRQ=;
 b=oxZaCi7YXMTpizYhpjrW1AZ4JRo5EdLXZy5eVUM0zKasM7oeNDDGZkpPhZxe8dI20qKovhGlrO3jkHb6yYTvWlMMMd0N9Ld97fsuA801kcZTNFokDQU7v5K+Ccxd4285nw3VKDl344+cIVLmfKigQvyy9HMjsjVqO6fimSfHRmc=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4636.namprd12.prod.outlook.com (2603:10b6:5:161::32) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.25; Wed, 12 May 2021 12:35:06 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.032; Wed, 12 May 2021
 12:35:06 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: flush TLB if valid PDE turns into PTE
Date: Wed, 12 May 2021 08:34:51 -0400
Message-Id: <20210512123451.25900-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::8) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YT1PR01CA0069.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4108.30 via Frontend Transport; Wed, 12 May 2021 12:35:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 555fd54b-7d26-4493-414a-08d915425f14
X-MS-TrafficTypeDiagnostic: DM6PR12MB4636:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB46368474773EE978E3B6A831E6529@DM6PR12MB4636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MBweDu6uClP2yMikf4h5sZcBauY0cXwEZg3FraQCaE+b5La66hSn0ajWlkqv9gM7hM4jWvku38vLVqwThJgTsS9VV07GMnRcUzLi/Jgi+jwDlXiNd5boW7NM0EWT+L9XNuLX8kCsw+kjHVYyfWrrycgDh37GAXdjH6eoZFfVmVW85PMX2ABp+tR+fRimCWCV6S3xaIwT6I3u8AYvWwuoadOSyNslJ5XzQiXMYraDdyBnmQriogMYEIHhQoLLgw7v4OpgLTZRhEgmR04Ms0PBA73VqbE8f1AccjvszDbhvJrLfXIsup0OA29cA3Vbdm8djtgoKWDYzdvu58sFlT/TGdn4SBDjAHPcithLaAE26vlPx6sdCfI4E6MwuqA4GevS/EovAYzD60poG5FU7IbWsML05hD44itRPRvHO98UtLL08Z1ywpS1CS6Ab6GhQ19HzIdUbLdwn0/sP4R13OMQEVDLjW9nfHT9BeFQU8YBj9E1x0VITQhEkd8GiA0F7C59ofjxM25JHxMVVGFKoaWNZxZxqnxZUHjlPIVx09JTYb2EmWu3lPEQ6tkVQ5AUrK5oW3Whd4bsqheDZX0YBgdbylDN/jbimJxNlRDih/nKnZHM+H/h4bXqp0b65UAJABMUjwhQSgXwTxXDjbCiYi+OVzlo38ssbO5Pk3rPipaw2kI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(366004)(376002)(396003)(8676002)(86362001)(66556008)(4326008)(66946007)(6486002)(36756003)(26005)(66476007)(316002)(478600001)(2906002)(6666004)(6916009)(5660300002)(1076003)(83380400001)(52116002)(956004)(8936002)(38350700002)(38100700002)(186003)(2616005)(16526019)(7696005);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?HGDjkSP1fpWrag5PXBrFdmotEveYCvsF6Oui9HJdLU6+HxGgqZUoEXY7c2Ow?=
 =?us-ascii?Q?nYPA5CRjKNlE/t8Ix287YDiMr1Wd4uvHtp6t0NIcc6QL8OXOAnx1fPCnsn1W?=
 =?us-ascii?Q?8O+6t3QuvgfH6Wzcts61ykT1ArmRoNJ2TmmJmEcNZ5TtPROK6R6+1k2BhhDT?=
 =?us-ascii?Q?zpI7e1DMjTtpPLtwHVSXRR7kwbsHAox12eJd6wR8duD3955oqplHzlZJuM2M?=
 =?us-ascii?Q?RT8G89YgiJENF6j7J6bzJZdb5ltRRxC7fVhBjzhRl/u5Z6WgRiTaNiDITPu0?=
 =?us-ascii?Q?yFLeUbF35DApzCmgDz98p/OkpfyI76Za/DBwVa8uNEG35Zf2drqUdK8vcPTv?=
 =?us-ascii?Q?FTp63GwVF0XPnt21UkhT5oaEZwjNH+6aTfI8A+eoYPArS0qcGJVZy8xg6KSo?=
 =?us-ascii?Q?PazFxT0cD+e+qNQRFsVntDYkTwy8rIu8VDstphmVnCjfdmRpn8XaQxhEMWqQ?=
 =?us-ascii?Q?i/Tmj7rPnfO2PYfyAs4gPYN9sgagwCm2zrsIuzXYLD0F402AhrregaTG8QNX?=
 =?us-ascii?Q?dVGFc3BRNtArqAEwojobY3yHIleMEqD0RizSZK+2vEUt/cUTK0Z5mUtt2RUy?=
 =?us-ascii?Q?NPfRq1tUdH7AcA1qHFnjgiInk6xx9oB1Q5fzYbmos+myFBSWJHG9beV2dt4v?=
 =?us-ascii?Q?xu6dBgOTjdQWGsifaFs2cM2zpybmeu0caiqgB3ZJNymWejtfeArTexak0+ZI?=
 =?us-ascii?Q?kIMzuXrc6V7XwQ4sHO/h7iThiwI7ftRUtoQKK0IpyUHQC4wn8+oJ7NqaU9bb?=
 =?us-ascii?Q?xCFy9YOOirXQKMdUIm1HNzghqqLVM+9LRL5FVWIPZ7CLLnZpKmHaBs6mVOaY?=
 =?us-ascii?Q?NkY9B1IDX6hprqKXsimx3PJA8lONwAfkI29y2DG1eHJERGmQ8gZxlcgjFF10?=
 =?us-ascii?Q?LIHRj2LadigPIpNjTE8LdVmB6wrlAR09rmguhFD0Efdk4oKH1jStEwQU4rfw?=
 =?us-ascii?Q?KpJkJiMmHZpaWMi6oUYs3jNZTItDwLIQwZRbJ6IvR6+pjORmtfyzuDkdBCZX?=
 =?us-ascii?Q?ayqtj8x4X49/otwWKxsjyaCQOBNai7SNo3oHRU4zW3dMEKMMfxGMZZyeYiGZ?=
 =?us-ascii?Q?2FXRszMlkZeR/aXpwb+bBsgD4CIWY+MNiYo8wv2cxVNUvHl7fgE3BHzI0HUc?=
 =?us-ascii?Q?qyygdd/Pg+mFM4VbL4gpXJDprqf7VUM6POjI+OESqoruRivXHikKEp8DdnAW?=
 =?us-ascii?Q?IsQG2TrOJjpi5ytMTC7HPfHtpbXMGWGSN8D7wg80TSceo9VKlwvJdtgcDUQo?=
 =?us-ascii?Q?5IzNHPt06TJvkbHGBr/B5oyIM1lAlma4fJKmnqbkCBIvqfTMDu5DgxoWjD8h?=
 =?us-ascii?Q?WJbdP7PdUjB9LzcCLQ+WrgVZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555fd54b-7d26-4493-414a-08d915425f14
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 12:35:05.9502 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jkk01WaJno07cMFUaDGWkgyjH8IS5IO98SZPSus/0aHo67U4U5M/A9ofBRtLFHRD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4636
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Mapping huge page, 2MB aligned address with 2MB size, uses PDE0 as PTE.
If previously valid PDE0, PDE0.V=1 and PDE0.P=0 turns into PTE, this
requires TLB flush, otherwise page table walker will not read updated
PDE0.

Change page table update mapping to return free_table flag to indicate
the previously valid PDE may have turned into a PTE if page table is
freed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 17 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 12 ++++++++++--
 3 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3dcdcc9ff522..27418f9407f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1457,7 +1457,7 @@ static void amdgpu_vm_fragment(struct amdgpu_vm_update_params *params,
  */
 static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 				 uint64_t start, uint64_t end,
-				 uint64_t dst, uint64_t flags)
+				 uint64_t dst, uint64_t flags, bool *free_table)
 {
 	struct amdgpu_device *adev = params->adev;
 	struct amdgpu_vm_pt_cursor cursor;
@@ -1583,6 +1583,8 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn < frag_start) {
 				amdgpu_vm_free_pts(adev, params->vm, &cursor);
 				amdgpu_vm_pt_next(adev, &cursor);
+				if (free_table)
+					*free_table = true;
 			}
 
 		} else if (frag >= shift) {
@@ -1610,6 +1612,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
  * @nodes: array of drm_mm_nodes with the MC addresses
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
+ * @free_table: return true if page table is freed
  *
  * Fill in the page table entries between @start and @last.
  *
@@ -1624,7 +1627,8 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct drm_mm_node *nodes,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence)
+				struct dma_fence **fence,
+				bool *free_table)
 {
 	struct amdgpu_vm_update_params params;
 	enum amdgpu_sync_mode sync_mode;
@@ -1721,7 +1725,8 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 		}
 
 		tmp = start + num_entries;
-		r = amdgpu_vm_update_ptes(&params, start, tmp, addr, flags);
+		r = amdgpu_vm_update_ptes(&params, start, tmp, addr, flags,
+					  free_table);
 		if (r)
 			goto error_unlock;
 
@@ -1879,7 +1884,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping->start,
 						mapping->last, update_flags,
 						mapping->offset, nodes,
-						pages_addr, last_update);
+						pages_addr, last_update, NULL);
 		if (r)
 			return r;
 	}
@@ -2090,7 +2095,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
 						resv, mapping->start,
 						mapping->last, init_pte_value,
-						0, NULL, NULL, &f);
+						0, NULL, NULL, &f, NULL);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -3428,7 +3433,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
-					addr, flags, value, NULL, NULL,
+					addr, flags, value, NULL, NULL, NULL,
 					NULL);
 	if (r)
 		goto error_unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ea60ec122b51..f61c20b70b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -404,7 +404,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct drm_mm_node *nodes,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence);
+				struct dma_fence **fence, bool *free_table);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b665e9ff77e3..4f28052d44bf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1084,7 +1084,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, true, NULL,
 					   start, last, init_pte_value, 0,
-					   NULL, NULL, fence);
+					   NULL, NULL, fence, NULL);
 }
 
 static int
@@ -1137,12 +1137,15 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
 {
 	struct amdgpu_bo_va bo_va;
+	bool free_table = false;
+	struct kfd_process *p;
 	uint64_t pte_flags;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%lx 0x%lx]\n", prange->svms, prange->start,
 		 prange->last);
 
+	p = container_of(prange->svms, struct kfd_process, svms);
 	if (prange->svm_bo && prange->ttm_res) {
 		bo_va.is_xgmi = amdgpu_xgmi_same_hive(adev, bo_adev);
 		prange->mapping.bo_va = &bo_va;
@@ -1159,7 +1162,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 					prange->mapping.offset,
 					prange->ttm_res ?
 						prange->ttm_res->mm_node : NULL,
-					dma_addr, &vm->last_update);
+					dma_addr, &vm->last_update,
+					&free_table);
 	if (r) {
 		pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
 		goto out;
@@ -1175,6 +1179,10 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (fence)
 		*fence = dma_fence_get(vm->last_update);
 
+	if (free_table)
+		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
+						  p->pasid);
+
 out:
 	prange->mapping.bo_va = NULL;
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
