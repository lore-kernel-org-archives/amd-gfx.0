Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0518C2D0C0
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6D4D21D7D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="0mE7uTta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6D4D21D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87F2F6EBD6;
	Fri, 20 Dec 2019 06:25:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221B76EBD7
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 06:25:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw0nUFf/2j3KotmA84cghXTSCl2hTPed6MvZXI/urQ5vIMfS43HBhQFuy+Qj/QC/E1aW0QQ0hnozP33WIJuMZ7UeMusJYNVl9FPYQO935s347g4GSxPinuI3jZGR6FmkC3po2xjWjdgRcJuKZr6lrdDXEV9/5roDIB0f3yAWYB5DO3t/pkJe+PEBchuDV4UfTJee73m58z+TLvv2dJivsry3/K/yWPvG/AGJ+NPLjX4I2l+kX71d7vD9zy6oAFKyuCSEIAjLPOdkhwL5pR6Aa1QJGQifIekCtHLVDYB1vI78dV8VTwL68P3maOMGtTyzyJmkox+9Mh/fy30v16rQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiCs29/QajDNAkSr72+dSlN5eMXvhKpNJS8RBy9CiBE=;
 b=c6w2R81HwpfsDyidQSb6rDZy1hv6igUsGfEbvFiDn0mHjw9056AC3KYTdL7CNzqJcOA6PSLvIJmIJ+sIV1OEFGr2RG1mtnPxfzYDBpiNJVhkG3JiYYgod5gMFVofh8wYwiPTHAuEHfVOyLJ0QGCkX2/cqI7y9ovCWixN614irVCFz/sXGOLs5Gaz1fm2RHXoCLNqPVKW2Qt0dICE8YMpxFKZ3uSTKioAwF4k8ILhIjfQ/E6qwYizfnPLOQ/QWjiSiODk0B8Jvx39DQHAh4HstpApcFveTXzl5d9gP7UeyN3SfLIgSHCb+awacmdoyhL7EamMKB2POQcYUPYHU4ed9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eiCs29/QajDNAkSr72+dSlN5eMXvhKpNJS8RBy9CiBE=;
 b=0mE7uTtaZ/3f8bT/2S12+3XzG6V+v6qE9yOtO/ZSxtVdyYdPm4JsrBSbHk0aDWj+yUEkCwmuf4aynhBGSdSkrfeSOfFGbTFNkUM3EdjjTu8yYsQTw29oBFtp2PzZPjXY0GALlD4leSlOMWIRXM1MnnShhdu/g7ZZiK/M6nYY2qk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from BYAPR12MB2616.namprd12.prod.outlook.com (20.177.124.144) by
 BYAPR12MB2775.namprd12.prod.outlook.com (20.176.255.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 20 Dec 2019 06:25:19 +0000
Received: from BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e]) by BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e%7]) with mapi id 15.20.2516.021; Fri, 20 Dec 2019
 06:25:19 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu: flush TLB functions removal from kfd2kgd
 interface
Date: Fri, 20 Dec 2019 00:24:41 -0600
Message-Id: <20191220062442.33635-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191220062442.33635-1-alex.sierra@amd.com>
References: <20191220062442.33635-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN4PR0501CA0085.namprd05.prod.outlook.com
 (2603:10b6:803:22::23) To BYAPR12MB2616.namprd12.prod.outlook.com
 (2603:10b6:a03:66::16)
MIME-Version: 1.0
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a02c4491-c8f3-476f-6056-08d785156261
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:|BYAPR12MB2775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2775C0A6D0A0DDCB2700F7F8FD2D0@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(39860400002)(136003)(396003)(376002)(346002)(189003)(199004)(5660300002)(30864003)(6666004)(66476007)(8936002)(8676002)(2616005)(81156014)(81166006)(478600001)(44832011)(6512007)(1076003)(2906002)(66556008)(66946007)(6916009)(316002)(26005)(186003)(36756003)(6506007)(52116002)(86362001)(4326008)(6486002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2775;
 H:BYAPR12MB2616.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sPSWI0PmpmyKmsMDYrwu5JYnHqIHbj7wEX2UfPiYnk3i1KiLKPgmXoXwTZKREBKw0LPXMz4fU5Ov2npoBWcu/DoLIYnmrZeVUCniGTRvqs5oRu+RB6zhEPrn3pGMtuzJQhrXKevMF3jXMTYQWU89YK7tgt9+nxcwHV/XT6T8/VXQYkjdZA1y1Fbe5NSyV7ROA03FopC3XkeTbte35Yrq19uztXLJJuEYYpPTf/zg/ZyoHmf1XVkHQm+GuiLzOhdDcfhwGTjY4v01FjbiJgPOOHB7FoDPN2aMcszfY3WRVzFBs8WL6NevOU6fbmfrEtXZwb8U4DEhV9OcfIdSbwlsywOEiwZ4a67qQo5m3PxssH+oTB8e0dj2ZByWB4oIsypIpEGI4YDq0Ru+jMKVEq/rOpU0NXO5ePSx7fnzKcfyVqsODT/kemzzMB0ScWl0YjHt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a02c4491-c8f3-476f-6056-08d785156261
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 06:25:19.5816 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z7pm5smKv7K7UHz1S07fDEwQJv5XVAJTwZoBXnocTJ895UI9U14bin+9aGjDg8Ag5OfR6zaG4Y0TA3t0ZKG/IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2775
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
kfd2kgd interface will be deprecated. This removal only covers TLB
invalidation for now. They have been replaced in amdgpu_amdkfd API.

[How]
TLB invalidate functions removed from the different amdkfd_gfx_v*
versions.

Change-Id: Ic2c7d4a0d19fe1e884dee1ff10a520d31252afee
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 -
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 67 -------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 41 --------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 41 --------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 96 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  2 -
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 -
 7 files changed, 251 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 3c119407dc34..82e80b92e6ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -296,7 +296,5 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.get_tile_config = kgd_gfx_v9_get_tile_config,
 	.set_vm_context_page_table_base = kgd_set_vm_context_page_table_base,
-	.invalidate_tlbs = kgd_gfx_v9_invalidate_tlbs,
-	.invalidate_tlbs_vmid = kgd_gfx_v9_invalidate_tlbs_vmid,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 61cd707158e4..6132b4874498 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -686,71 +686,6 @@ static bool get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
 	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
 }
 
-static int invalidate_tlbs_with_kiq(struct amdgpu_device *adev, uint16_t pasid)
-{
-	signed long r;
-	uint32_t seq;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-
-	spin_lock(&adev->gfx.kiq.ring_lock);
-	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
-	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
-	amdgpu_ring_write(ring,
-			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
-			PACKET3_INVALIDATE_TLBS_PASID(pasid));
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq.ring_lock);
-
-	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
-	if (r < 1) {
-		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
-		return -ETIME;
-	}
-
-	return 0;
-}
-
-static int invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int vmid;
-	uint16_t queried_pasid;
-	bool ret;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-
-	if (amdgpu_emu_mode == 0 && ring->sched.ready)
-		return invalidate_tlbs_with_kiq(adev, pasid);
-
-	for (vmid = 0; vmid < 16; vmid++) {
-		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
-			continue;
-
-		ret = get_atc_vmid_pasid_mapping_info(kgd, vmid,
-				&queried_pasid);
-		if (ret	&& queried_pasid == pasid) {
-			amdgpu_gmc_flush_gpu_tlb(adev, vmid,
-					AMDGPU_GFXHUB_0, 0);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-
-	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
-		pr_err("non kfd vmid %d\n", vmid);
-		return 0;
-	}
-
-	amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
-	return 0;
-}
-
 static int kgd_address_watch_disable(struct kgd_dev *kgd)
 {
 	return 0;
@@ -832,7 +767,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 			get_atc_vmid_pasid_mapping_info,
 	.get_tile_config = amdgpu_amdkfd_get_tile_config,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
-	.invalidate_tlbs = invalidate_tlbs,
-	.invalidate_tlbs_vmid = invalidate_tlbs_vmid,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 6e6f0a99ec06..8f052e98a3c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -696,45 +696,6 @@ static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
 		lower_32_bits(page_table_base));
 }
 
-static int invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int vmid;
-	unsigned int tmp;
-
-	if (adev->in_gpu_reset)
-		return -EIO;
-
-	for (vmid = 0; vmid < 16; vmid++) {
-		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
-			continue;
-
-		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
-		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
-			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
-			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
-			RREG32(mmVM_INVALIDATE_RESPONSE);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-
-	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
-		pr_err("non kfd vmid\n");
-		return 0;
-	}
-
-	WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
-	RREG32(mmVM_INVALIDATE_RESPONSE);
-	return 0;
-}
-
  /**
   * read_vmid_from_vmfault_reg - read vmid from register
   *
@@ -771,7 +732,5 @@ const struct kfd2kgd_calls gfx_v7_kfd2kgd = {
 	.set_scratch_backing_va = set_scratch_backing_va,
 	.get_tile_config = get_tile_config,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
-	.invalidate_tlbs = invalidate_tlbs,
-	.invalidate_tlbs_vmid = invalidate_tlbs_vmid,
 	.read_vmid_from_vmfault_reg = read_vmid_from_vmfault_reg,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index bfbddedb2380..19a10db93d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -657,45 +657,6 @@ static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
 			lower_32_bits(page_table_base));
 }
 
-static int invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int vmid;
-	unsigned int tmp;
-
-	if (adev->in_gpu_reset)
-		return -EIO;
-
-	for (vmid = 0; vmid < 16; vmid++) {
-		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
-			continue;
-
-		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
-		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
-			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
-			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
-			RREG32(mmVM_INVALIDATE_RESPONSE);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-
-	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
-		pr_err("non kfd vmid %d\n", vmid);
-		return -EINVAL;
-	}
-
-	WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
-	RREG32(mmVM_INVALIDATE_RESPONSE);
-	return 0;
-}
-
 const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
 	.program_sh_mem_settings = kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
@@ -717,6 +678,4 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
 	.set_scratch_backing_va = set_scratch_backing_va,
 	.get_tile_config = get_tile_config,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
-	.invalidate_tlbs = invalidate_tlbs,
-	.invalidate_tlbs_vmid = invalidate_tlbs_vmid,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e7861f0ef415..932ae85d97e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -617,100 +617,6 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
 	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
 }
 
-static int invalidate_tlbs_with_kiq(struct amdgpu_device *adev, uint16_t pasid,
-			uint32_t flush_type)
-{
-	signed long r;
-	uint32_t seq;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-
-	spin_lock(&adev->gfx.kiq.ring_lock);
-	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
-	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
-	amdgpu_ring_write(ring,
-			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
-			PACKET3_INVALIDATE_TLBS_ALL_HUB(1) |
-			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
-			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq.ring_lock);
-
-	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
-	if (r < 1) {
-		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
-		return -ETIME;
-	}
-
-	return 0;
-}
-
-int kgd_gfx_v9_invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int vmid, i;
-	uint16_t queried_pasid;
-	bool ret;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-	uint32_t flush_type = 0;
-
-	if (adev->in_gpu_reset)
-		return -EIO;
-	if (adev->gmc.xgmi.num_physical_nodes &&
-		adev->asic_type == CHIP_VEGA20)
-		flush_type = 2;
-
-	if (ring->sched.ready)
-		return invalidate_tlbs_with_kiq(adev, pasid, flush_type);
-
-	for (vmid = 0; vmid < 16; vmid++) {
-		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
-			continue;
-
-		ret = kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(kgd, vmid,
-				&queried_pasid);
-		if (ret && queried_pasid == pasid) {
-			for (i = 0; i < adev->num_vmhubs; i++)
-				amdgpu_gmc_flush_gpu_tlb(adev, vmid,
-							i, flush_type);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-int kgd_gfx_v9_invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int i;
-
-	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
-		pr_err("non kfd vmid %d\n", vmid);
-		return 0;
-	}
-
-	/* Use legacy mode tlb invalidation.
-	 *
-	 * Currently on Raven the code below is broken for anything but
-	 * legacy mode due to a MMHUB power gating problem. A workaround
-	 * is for MMHUB to wait until the condition PER_VMID_INVALIDATE_REQ
-	 * == PER_VMID_INVALIDATE_ACK instead of simply waiting for the ack
-	 * bit.
-	 *
-	 * TODO 1: agree on the right set of invalidation registers for
-	 * KFD use. Use the last one for now. Invalidate both GC and
-	 * MMHUB.
-	 *
-	 * TODO 2: support range-based invalidation, requires kfg2kgd
-	 * interface change
-	 */
-	for (i = 0; i < adev->num_vmhubs; i++)
-		amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
-
-	return 0;
-}
-
 int kgd_gfx_v9_address_watch_disable(struct kgd_dev *kgd)
 {
 	return 0;
@@ -793,7 +699,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.get_tile_config = kgd_gfx_v9_get_tile_config,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
-	.invalidate_tlbs = kgd_gfx_v9_invalidate_tlbs,
-	.invalidate_tlbs_vmid = kgd_gfx_v9_invalidate_tlbs_vmid,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 02b1426d17d1..dfafa28b7559 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -57,7 +57,5 @@ uint32_t kgd_gfx_v9_address_watch_get_offset(struct kgd_dev *kgd,
 
 bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
 					uint8_t vmid, uint16_t *p_pasid);
-int kgd_gfx_v9_invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid);
-int kgd_gfx_v9_invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid);
 int kgd_gfx_v9_get_tile_config(struct kgd_dev *kgd,
 		struct tile_config *config);
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 2cd217e60125..a01ef836ad58 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -307,8 +307,6 @@ struct kfd2kgd_calls {
 
 	void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t page_table_base);
-	int (*invalidate_tlbs)(struct kgd_dev *kgd, uint16_t pasid);
-	int (*invalidate_tlbs_vmid)(struct kgd_dev *kgd, uint16_t vmid);
 	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
 	uint64_t (*get_hive_id)(struct kgd_dev *kgd);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
