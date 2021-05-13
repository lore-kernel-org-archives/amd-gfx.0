Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D7D4C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:58:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A4476121E
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 16:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4476121E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CEFB26ED74;
	Thu, 13 May 2021 16:58:29 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A7D6ED74
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 16:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M91mPqcOxbs1zjBEanIrnwabCYn1XjTolYPjqOUMXvgFhnuj1u541sPsjh7ewqcx34Y0k7doY55JfNeHjnGeqhOLUYrWbtlDvFHHBzGlHyeeELQPsakFsGM4zdiWaqH+YPLxoMiEV5nQiMTRW94f+N7u+NkPHSTAnZJHn1Mbmf9CTzSsRa495UlFUDXziwZSlvZagCWvLqDs2J52LUhd2DXoOBpZlY5AQeKBauMYUT2PXTfx+A4b+dZTKKkdW92K23WnM3xkWQmvyW3PkS8G4i2jM1L0p+rb+p1gPsPEht2puPA4YkuyWtbvtDd8SLsWIzBMArARE6Id/3sxUGT8iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XBJ9/8ToXZCHfy0E7gwO7ljX8NwmBC4Ldm8/YpfQNg=;
 b=Mz/myck2b7M1r3JHV/h7YarNxFzS6LN7iHla3fa3rvVmym6pnlYVnOfTvny1gG1ks5HCxm5EN5CxjzHWaGXsWLTgUoiIuu6auWJkAmflFR+oIunHVzvlmMWfHKrQ+dIi6TFs1TAyUrd6CXvL1ZaYEZQ/+Q4iC0TjvuvBduX/B5xvYTBcEwHYIkmdoYbwITEOOt8grwNrhd9f5dBgIAVDRyGjxIuqPbgPn0TUIFJunXKZVcYMtrUVlm4rFJFZM/+Px0bb1e9awstGKE7gnbn8JbexPrlUgjiuLFXf0/FVBiMZ2bgeun+w66TmPsoJcdJcvugN9tiZHL63ldFnxWwfSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XBJ9/8ToXZCHfy0E7gwO7ljX8NwmBC4Ldm8/YpfQNg=;
 b=H0IvUwuhkOvPq+OEDZpeEtcQpvnOYmmeUxCo9yh0dsVwkWHe/LgpQS64965lb6ce3I7Jn+aVS8rYrWYw7ITdKE+bYuqX9rIE+9H9Se3z0Jmle73zYKgPZ4O6uWdH9npLtAwnU1ErzcVGHoHj0mzy/Lb+sUFkh7kres9DyUVkAGU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2583.namprd12.prod.outlook.com (2603:10b6:4:b3::28) by
 DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4129.26; Thu, 13 May 2021 16:58:27 +0000
Received: from DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa]) by DM5PR12MB2583.namprd12.prod.outlook.com
 ([fe80::d568:cff1:dc2a:5baa%3]) with mapi id 15.20.4108.032; Thu, 13 May 2021
 16:58:27 +0000
From: Philip Yang <Philip.Yang@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdgpu: flush TLB if valid PDE turns into PTE
Date: Thu, 13 May 2021 12:58:09 -0400
Message-Id: <20210513165809.16198-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512123451.25900-1-Philip.Yang@amd.com>
References: <20210512123451.25900-1-Philip.Yang@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::44) To DM5PR12MB2583.namprd12.prod.outlook.com
 (2603:10b6:4:b3::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Philip-Dev.amd.com (165.204.55.251) by
 YTXPR0101CA0067.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::44) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.31 via Frontend
 Transport; Thu, 13 May 2021 16:58:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9386efb2-599a-41c4-85a7-08d9163053cd
X-MS-TrafficTypeDiagnostic: DM6PR12MB4943:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4943178841CA6FC61919EC71E6519@DM6PR12MB4943.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:983;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QpcVSUlzpAwOWPJUMjdb2lcK65jO0yXBByQwnqDca5NPRgvT6f50IaTILQIzQQoa6voRN6k032SwZLDDWU5O1rdoD/Uj+1RfYnrKP/7Ev5yKuEKLh79JZRJjTgdRMpbM0l+EISQhytkyk9Q4UYWuMRLi6ZLQ/B+EcZvmMOb0OH5kK2d5VbUkBoAPGy5LLv9HDLufW+Y+EsLYH3hGSZMA5bPwOUvUQEBhWV0h05ZJEu6X44wVN6STDV+/xrv+qXjnCremtg+hDtohTBu5hj86IaGI1lCCYKKUu28TQN8qP8K26nu9P/hzMfYVzeAg+md/TJOSU+jQ4PgUewR995j4eghDh2d+h+TO8+J1CZLMtuVaUfA5BzbZLwUZLscVPrICxqbG7Vx2/86Bysl9BYe2otY1HahS09npYKFuSxckt4/3918ZiA3TIVoG+AeAWQsx3VskuIg2yYhOf/3Mh4DQ6kPbriSaapVpcItHDdvwxSq376UKXP3XOkfl/jlhZHfXI+vxAMJRROQlKXfJ/7s08XMqdmw0mVKPBztXEMioqcss/ACgIU4fEe+2bTZpEAuF9Pni6amK8k13WJYHMSPU7nDSGR5mJkgd71+wZMtKzGq1p9r7KjeyQXwnb02kFN+iIVgeEuroAOakDZmyo2KmiMDXVoofhPtXPF7QRg3wtU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2583.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(366004)(36756003)(1076003)(4326008)(5660300002)(2906002)(478600001)(86362001)(38100700002)(956004)(2616005)(52116002)(186003)(16526019)(6916009)(6666004)(316002)(83380400001)(66556008)(66476007)(6486002)(26005)(38350700002)(8936002)(7696005)(66946007)(8676002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zpgwokVfZucj1c5asA1ow0v9BzUIKeO0NCarvEWagqgMN2xlRZHKx2wcYRt5?=
 =?us-ascii?Q?h1BLa/vhR/FRGbiOcA2KcrtjSqCn9w3mfNv2+yeLFjQeAEsN8OSKjvqVmUTn?=
 =?us-ascii?Q?ButncFlKLoh4Qalq6vS9dAyBQzXdp1YjUek6CbOSSMEpyv4hJv1nrCa4fMtj?=
 =?us-ascii?Q?yvDvELsx3mEM2ggWWnZ67gzmEhNM08P6Z1mPkecpVYnGJL7AllkKWmYG6wlD?=
 =?us-ascii?Q?lG7fMKi6fQxos6/b9C1psWdRf6FqP7L9MlwbKeOUbFzvlINTdSQK0OMb6TOr?=
 =?us-ascii?Q?Lv3/VNG83Cdz+u8qIo8A4v7aWkkOOQ/6eSZCvZjGTn9AQz/CZqPtSqLoyoyq?=
 =?us-ascii?Q?LFRCRDcecGoansV6cAJB5MZNRM8VrRJyuIg9E5torZOSHUrPJKR8Fb0dU5sV?=
 =?us-ascii?Q?Lo28dZfBaBPM9flHdYcm74t2Lu2VsOysAFrmoV8Q8+2TmjWc+wa27Ckt5YBT?=
 =?us-ascii?Q?GWEnc2dy/9cg8At4QymV+fnu3TJXPxDKJMVVmsj7L8kAOktBAK4AXFDZTMvp?=
 =?us-ascii?Q?cH6j3CTeYvSSqn62CtXtPCYVWto+Qy957PlRY/fakN9NuYiWckWfgiO/2oF1?=
 =?us-ascii?Q?wGmuirVX1upaCa9b5OkrzeWwg4VvZlNTgF/jl7SmzB6MPABTuguugTNSVDIp?=
 =?us-ascii?Q?n5U2yQJ0P46UJMzytavv0hVQwcnJyPHqL99WlHzG4Pp5EKRDyRY7mGZcHbik?=
 =?us-ascii?Q?h0A4HZEuHmQh0f9CU1BtrOJ/Gd6OcvszldT4LOXLCj5+MQg86E0v28jUunmc?=
 =?us-ascii?Q?NScy9RDLtybV1ZZpRN5kN5CEwvSyEs+Wj6FlsTVv68HG9o9+TXuSNv21i6Nr?=
 =?us-ascii?Q?poWBQDMlW0liG9mAAVyR1ZgmzrSDMnajCeekRx+ML3XDtnrjB8ei4A9uV1b+?=
 =?us-ascii?Q?VxStfep1Ljd+Llgt2bfzYmE9XG9/UG25nItI+/O0s6Syc6dMihoxopjDb+Pr?=
 =?us-ascii?Q?BEboSCE2uJxAUggc+xWV9lmiEET4xmLdEyn/ILJGQYqBCxo9611/FL26euMq?=
 =?us-ascii?Q?L1c3kCsGVbGRAvnJiPJ4PoZkaxboqzLfyWvMs2G2YIItQeBR6sxhK6s0uWyC?=
 =?us-ascii?Q?QR18bh65Occ/6pZ99msvlNDyyakSAGQE9+05nvQNOdfTXV1dvpmnMvILEv/h?=
 =?us-ascii?Q?H+3ZCdurkUNRDpTYC7R+uIoF58born7wX7gMy/rFJCACXd+GHJ9JNTdoeEYl?=
 =?us-ascii?Q?gIeaDvbuvycp9L/qFFoGmqeBLXctypG4eeV9Jo+p7b+cxHMYxHIdTNN/jB4f?=
 =?us-ascii?Q?SumFGFAR8cKw4mFvlx2bqGAgqhVv21tCZXxg+agrWvgQfD+rfiuJOFLD3Y8s?=
 =?us-ascii?Q?8+wcUKyiHd7FNEpPNoFOWLlF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9386efb2-599a-41c4-85a7-08d9163053cd
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2021 16:58:27.3762 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 252UZkwVIIlY265kUGtwJpI45t4wC1mIfCpPaL7Srn6cjGAWdCaKE5Qt3g/PO3Aa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
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

Change page table update mapping to return table_freed flag to indicate
the previously valid PDE may have turned into a PTE if page table is
freed.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 14 ++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  7 ++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 13 +++++++++++--
 3 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3dcdcc9ff522..7e4c60a90eee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1583,6 +1583,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 			while (cursor.pfn < frag_start) {
 				amdgpu_vm_free_pts(adev, params->vm, &cursor);
 				amdgpu_vm_pt_next(adev, &cursor);
+				params->table_freed = true;
 			}
 
 		} else if (frag >= shift) {
@@ -1610,6 +1611,7 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
  * @nodes: array of drm_mm_nodes with the MC addresses
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
+ * @table_freed: return true if page table is freed
  *
  * Fill in the page table entries between @start and @last.
  *
@@ -1624,7 +1626,8 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct drm_mm_node *nodes,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence)
+				struct dma_fence **fence,
+				bool *table_freed)
 {
 	struct amdgpu_vm_update_params params;
 	enum amdgpu_sync_mode sync_mode;
@@ -1736,6 +1739,9 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->commit(&params, fence);
 
+	if (table_freed)
+		*table_freed = params.table_freed;
+
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	return r;
@@ -1879,7 +1885,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping->start,
 						mapping->last, update_flags,
 						mapping->offset, nodes,
-						pages_addr, last_update);
+						pages_addr, last_update, NULL);
 		if (r)
 			return r;
 	}
@@ -2090,7 +2096,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
 						resv, mapping->start,
 						mapping->last, init_pte_value,
-						0, NULL, NULL, &f);
+						0, NULL, NULL, &f, NULL);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -3428,7 +3434,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
-					addr, flags, value, NULL, NULL,
+					addr, flags, value, NULL, NULL, NULL,
 					NULL);
 	if (r)
 		goto error_unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ea60ec122b51..e91288d637ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -231,6 +231,11 @@ struct amdgpu_vm_update_params {
 	 * @num_dw_left: number of dw left for the IB
 	 */
 	unsigned int num_dw_left;
+
+	/**
+	 * @table_freed: return true if page table is freed when updating
+	 */
+	bool table_freed;
 };
 
 struct amdgpu_vm_update_funcs {
@@ -404,7 +409,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct drm_mm_node *nodes,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence);
+				struct dma_fence **fence, bool *free_table);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index b665e9ff77e3..a518ad26ceec 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1084,7 +1084,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, true, NULL,
 					   start, last, init_pte_value, 0,
-					   NULL, NULL, fence);
+					   NULL, NULL, fence, NULL);
 }
 
 static int
@@ -1137,6 +1137,7 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		     struct amdgpu_device *bo_adev, struct dma_fence **fence)
 {
 	struct amdgpu_bo_va bo_va;
+	bool table_freed = false;
 	uint64_t pte_flags;
 	int r = 0;
 
@@ -1159,7 +1160,8 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 					prange->mapping.offset,
 					prange->ttm_res ?
 						prange->ttm_res->mm_node : NULL,
-					dma_addr, &vm->last_update);
+					dma_addr, &vm->last_update,
+					&table_freed);
 	if (r) {
 		pr_debug("failed %d to map to gpu 0x%lx\n", r, prange->start);
 		goto out;
@@ -1175,6 +1177,13 @@ svm_range_map_to_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (fence)
 		*fence = dma_fence_get(vm->last_update);
 
+	if (table_freed) {
+		struct kfd_process *p;
+
+		p = container_of(prange->svms, struct kfd_process, svms);
+		amdgpu_amdkfd_flush_gpu_tlb_pasid((struct kgd_dev *)adev,
+						  p->pasid);
+	}
 out:
 	prange->mapping.bo_va = NULL;
 	return r;
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
