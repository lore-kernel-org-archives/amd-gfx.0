Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747ABC33CA2
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A14E2075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="aZSui1h0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A14E2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F26D06E988;
	Fri, 10 Jan 2020 00:43:50 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C945D6E95A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:43:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTmp1AYiPRT4iCpcUIsxY6oturd4+u2QVj8YMSUbRWWTxoHec58UcOgWmpokZQ9YGq+KWyObZELiR6uMECzsowynklVcgORYxHH8U4KOzAi+NG7UtjSvd4hke9KbmeiC4wkPvBGE1Zpi5FqKqBVFRCYHotWQNyALQbtMRHvmdCwnwdvhm3uM6KyDnEDPe09xYAUS+c+mNjWSXbiQp6r7CVD2QqhynjVDv0snKsL8sBklDJCgDhMKCvlIWhz715HabrXbYvF8pci0SHo/8UuHYrw1C3fYFnuu4JerQt6kKZkMScUL8JDI/UUnYbLk2sGWlri39iRJknbMKPfaaf4HZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KManVB3R9zHxPdcNeSz5b1v8eGn/AONC/ukShEdLOfc=;
 b=Fv9V61+DQkYz3IdvwwNEAhQxCR1vDJgpbnjS20FbGGELveUthXJbZNMhjO7hKrTsBpHvUu4N5G6mIN7/eD38Y5i6i2t498hFZcLNjL2giTrPEbqSKsBEnfmyN2BsVmTTq578fARWoVZjwhGf0+SPx+0ki6Ow8q7+cj4nZoN/CRsYe09gumfoJjGkc+TCiy3Y+/sDZGO8eCD60Hkc6AP5vKAZcKLKGsnOGLeG/PwJpc2jWkJYmwhGXc/NrVOOMUx9UPiP+Flums9DySc4Hob7HypVGUM6RTwfFoC3jjQqx+1PjfJMv5QeKAzx/8Ju3h5TlDwX96qocixf2OknI2YhUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KManVB3R9zHxPdcNeSz5b1v8eGn/AONC/ukShEdLOfc=;
 b=aZSui1h0Y0mICEYwauJitrwEU1wQnT8ZMW6vabaAmfD75iU+0LLPYrclxrofbI7vbB/b9KiCiRjJAeN125smU7479Y1DlwiGvicQeKDywIvyrZm7DXa8SLE849frMOY9Qis89s76Gc625wxVSvYGU0mJ6Zyheew5KadlaACVIZQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2672.namprd12.prod.outlook.com (52.135.103.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:43:48 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:43:48 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/8] drm/amdgpu: export function to flush TLB via pasid
Date: Thu,  9 Jan 2020 18:43:29 -0600
Message-Id: <20200110004335.113095-2-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110004335.113095-1-alex.sierra@amd.com>
References: <20200110004335.113095-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:805:106::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.4 via Frontend
 Transport; Fri, 10 Jan 2020 00:43:47 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 4e62c020-8fd2-4066-ae59-08d795662794
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:|SN6PR12MB2672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2672AEFA95823253AC62A865FD380@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(30864003)(8936002)(26005)(5660300002)(7696005)(316002)(86362001)(1076003)(186003)(2616005)(16526019)(956004)(44832011)(2906002)(36756003)(52116002)(66556008)(478600001)(66476007)(6916009)(6666004)(6486002)(66946007)(4326008)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2672;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/4HJB9R+fmeL84FtCdPEZqrMY/CVGcb8W8Oo9/0/Nr9c+0dy123CHDUQhK0qkttXk2mv8yzSQQG56t4mNjMdmGIk9FOR5wxJiYRsgvLJbOYVoj3LfirVPPU1qow3uKB1BLHqZ3B3f4kxlC4j8QBvPEkonPUlvBPjfAbxIo8JeGf3o+MtKr22aouH0ph8vrcF2bjpbsoGcZNeLemO2MHwHdoIuJaIvhWrtV810cMa3I3qNAqIBxDqQ7UQmpwkr0wEqXRnZHzZXOAYPJ9baor9nNlTHiIJbQCHYWDv15cvxn6RGzqWV3589moNioF/HBHjQn1x2XIt+FHAG/VvQN1gji4GZqNUFLOcUqeewryTuMrZd8j8vXDuZOd+o7A6aFgj+GXqRlsVXUhDL58t+ujJw2LJirntI2Y/AwLnkJSSoZzBBzQ19vps8ZJ+1SN1thp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e62c020-8fd2-4066-ae59-08d795662794
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:43:48.1511 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PfKQd0wKwUoyrtFmy1bRsJUZkrLFtCWVoe/EIIH6GXQ/l2pVkQvBtq0W5rFIndPf5Mpru4BW2/nwfz3rxIR+HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
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

This can be used directly from amdgpu and amdkfd to invalidate
TLB through pasid.
It supports gmc v7, v8, v9 and v10.

Change-Id: I6563a8eba2e42d1a67fa2547156c20da41d1e490
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 87 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 33 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 34 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 89 +++++++++++++++++++++++++
 5 files changed, 249 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index c91dd602d5f1..d3c27a3c43f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -92,6 +92,9 @@ struct amdgpu_gmc_funcs {
 	/* flush the vm tlb via mmio */
 	void (*flush_gpu_tlb)(struct amdgpu_device *adev, uint32_t vmid,
 				uint32_t vmhub, uint32_t flush_type);
+	/* flush the vm tlb via pasid */
+	int (*flush_gpu_tlb_pasid)(struct amdgpu_device *adev, uint16_t pasid,
+					uint32_t flush_type, bool all_hub);
 	/* flush the vm tlb via ring */
 	uint64_t (*emit_flush_gpu_tlb)(struct amdgpu_ring *ring, unsigned vmid,
 				       uint64_t pd_addr);
@@ -216,6 +219,9 @@ struct amdgpu_gmc {
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
+#define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub) \
+	((adev)->gmc.gmc_funcs->flush_gpu_tlb_pasid \
+	((adev), (pasid), (type), (allhub)))
 #define amdgpu_gmc_emit_flush_gpu_tlb(r, vmid, addr) (r)->adev->gmc.gmc_funcs->emit_flush_gpu_tlb((r), (vmid), (addr))
 #define amdgpu_gmc_emit_pasid_mapping(r, vmid, pasid) (r)->adev->gmc.gmc_funcs->emit_pasid_mapping((r), (vmid), (pasid))
 #define amdgpu_gmc_map_mtype(adev, flags) (adev)->gmc.gmc_funcs->map_mtype((adev),(flags))
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 5ad89bb6f3ba..8cf34c7bd416 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -30,6 +30,8 @@
 #include "hdp/hdp_5_0_0_sh_mask.h"
 #include "gc/gc_10_1_0_sh_mask.h"
 #include "mmhub/mmhub_2_0_0_sh_mask.h"
+#include "athub/athub_2_0_0_sh_mask.h"
+#include "athub/athub_2_0_0_offset.h"
 #include "dcn/dcn_2_0_0_offset.h"
 #include "dcn/dcn_2_0_0_sh_mask.h"
 #include "oss/osssys_5_0_0_offset.h"
@@ -37,6 +39,7 @@
 #include "navi10_enum.h"
 
 #include "soc15.h"
+#include "soc15d.h"
 #include "soc15_common.h"
 
 #include "nbio_v2_3.h"
@@ -234,6 +237,48 @@ static bool gmc_v10_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 		(!amdgpu_sriov_vf(adev)));
 }
 
+static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
+					struct amdgpu_device *adev,
+					uint8_t vmid, uint16_t *p_pasid)
+{
+	uint32_t value;
+
+	value = RREG32(SOC15_REG_OFFSET(ATHUB, 0, mmATC_VMID0_PASID_MAPPING)
+		     + vmid);
+	*p_pasid = value & ATC_VMID0_PASID_MAPPING__PASID_MASK;
+
+	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
+}
+
+static int gmc_v10_0_invalidate_tlbs_with_kiq(struct amdgpu_device *adev,
+					uint16_t pasid, uint32_t flush_type,
+					bool all_hub)
+{
+	signed long r;
+	uint32_t seq;
+	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
+
+	spin_lock(&adev->gfx.kiq.ring_lock);
+	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
+	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(ring,
+			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
+			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+	amdgpu_fence_emit_polling(ring, &seq);
+	amdgpu_ring_commit(ring);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+	if (r < 1) {
+		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -380,6 +425,47 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
 }
 
+/**
+ * gmc_v10_0_flush_gpu_tlb_pasid - tlb flush via pasid
+ *
+ * @adev: amdgpu_device pointer
+ * @pasid: pasid to be flush
+ *
+ * Flush the TLB for the requested pasid.
+ */
+static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					uint16_t pasid, uint32_t flush_type,
+					bool all_hub)
+{
+	int vmid, i;
+	uint16_t queried_pasid;
+	bool ret;
+	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
+
+	if (amdgpu_emu_mode == 0 && ring->sched.ready)
+		return gmc_v10_0_invalidate_tlbs_with_kiq(adev,
+						pasid, flush_type, all_hub);
+
+	for (vmid = 1; vmid < 16; vmid++) {
+
+		ret = gmc_v10_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
+				&queried_pasid);
+		if (ret	&& queried_pasid == pasid) {
+			if (all_hub) {
+				for (i = 0; i < adev->num_vmhubs; i++)
+					gmc_v10_0_flush_gpu_tlb(adev, vmid,
+							i, 0);
+			} else {
+				gmc_v10_0_flush_gpu_tlb(adev, vmid,
+						AMDGPU_GFXHUB_0, 0);
+			}
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					     unsigned vmid, uint64_t pd_addr)
 {
@@ -531,6 +617,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 
 static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v10_0_flush_gpu_tlb,
+	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
 	.map_mtype = gmc_v10_0_map_mtype,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index f08e5330642d..19d5b133e1d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -418,6 +418,38 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * gmc_v7_0_flush_gpu_tlb_pasid - tlb flush via pasid
+ *
+ * @adev: amdgpu_device pointer
+ * @pasid: pasid to be flush
+ *
+ * Flush the TLB for the requested pasid.
+ */
+static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					uint16_t pasid, uint32_t flush_type,
+					bool all_hub)
+{
+	int vmid;
+	unsigned int tmp;
+
+	if (adev->in_gpu_reset)
+		return -EIO;
+
+	for (vmid = 1; vmid < 16; vmid++) {
+
+		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
+		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
+			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
+			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
+			RREG32(mmVM_INVALIDATE_RESPONSE);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -1333,6 +1365,7 @@ static const struct amd_ip_funcs gmc_v7_0_ip_funcs = {
 
 static const struct amdgpu_gmc_funcs gmc_v7_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v7_0_flush_gpu_tlb,
+	.flush_gpu_tlb_pasid = gmc_v7_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v7_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v7_0_emit_pasid_mapping,
 	.set_prt = gmc_v7_0_set_prt,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 6d96d40fbcb8..27d83204fa2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -620,6 +620,39 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
 	return 0;
 }
 
+/**
+ * gmc_v8_0_flush_gpu_tlb_pasid - tlb flush via pasid
+ *
+ * @adev: amdgpu_device pointer
+ * @pasid: pasid to be flush
+ *
+ * Flush the TLB for the requested pasid.
+ */
+static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					uint16_t pasid, uint32_t flush_type,
+					bool all_hub)
+{
+	int vmid;
+	unsigned int tmp;
+
+	if (adev->in_gpu_reset)
+		return -EIO;
+
+	for (vmid = 1; vmid < 16; vmid++) {
+
+		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
+		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
+			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
+			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
+			RREG32(mmVM_INVALIDATE_RESPONSE);
+			break;
+		}
+	}
+
+	return 0;
+
+}
+
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -1700,6 +1733,7 @@ static const struct amd_ip_funcs gmc_v8_0_ip_funcs = {
 
 static const struct amdgpu_gmc_funcs gmc_v8_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v8_0_flush_gpu_tlb,
+	.flush_gpu_tlb_pasid = gmc_v8_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v8_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v8_0_emit_pasid_mapping,
 	.set_prt = gmc_v8_0_set_prt,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 26194ac9af98..7cc6f305bfa8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -38,10 +38,12 @@
 #include "dce/dce_12_0_sh_mask.h"
 #include "vega10_enum.h"
 #include "mmhub/mmhub_1_0_offset.h"
+#include "athub/athub_1_0_sh_mask.h"
 #include "athub/athub_1_0_offset.h"
 #include "oss/osssys_4_0_offset.h"
 
 #include "soc15.h"
+#include "soc15d.h"
 #include "soc15_common.h"
 #include "umc/umc_6_0_sh_mask.h"
 
@@ -441,6 +443,47 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
 		   adev->pdev->device == 0x15d8)));
 }
 
+static bool gmc_v9_0_get_atc_vmid_pasid_mapping_info(struct amdgpu_device *adev,
+					uint8_t vmid, uint16_t *p_pasid)
+{
+	uint32_t value;
+
+	value = RREG32(SOC15_REG_OFFSET(ATHUB, 0, mmATC_VMID0_PASID_MAPPING)
+		     + vmid);
+	*p_pasid = value & ATC_VMID0_PASID_MAPPING__PASID_MASK;
+
+	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
+}
+
+static int gmc_v9_0_invalidate_tlbs_with_kiq(struct amdgpu_device *adev,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub)
+{
+	signed long r;
+	uint32_t seq;
+	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
+
+	spin_lock(&adev->gfx.kiq.ring_lock);
+	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
+	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(ring,
+			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
+			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+	amdgpu_fence_emit_polling(ring, &seq);
+	amdgpu_ring_commit(ring);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
+	if (r < 1) {
+		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -539,6 +582,51 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
 }
 
+/**
+ * gmc_v9_0_flush_gpu_tlb_pasid - tlb flush via pasid
+ *
+ * @adev: amdgpu_device pointer
+ * @pasid: pasid to be flush
+ *
+ * Flush the TLB for the requested pasid.
+ */
+static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					uint16_t pasid, uint32_t flush_type,
+					bool all_hub)
+{
+	int vmid, i;
+	uint16_t queried_pasid;
+	bool ret;
+	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
+
+	if (adev->in_gpu_reset)
+		return -EIO;
+
+	if (ring->sched.ready)
+		return gmc_v9_0_invalidate_tlbs_with_kiq(adev,
+						pasid, flush_type, all_hub);
+
+	for (vmid = 1; vmid < 16; vmid++) {
+
+		ret = gmc_v9_0_get_atc_vmid_pasid_mapping_info(adev, vmid,
+				&queried_pasid);
+		if (ret && queried_pasid == pasid) {
+			if (all_hub) {
+				for (i = 0; i < adev->num_vmhubs; i++)
+					gmc_v9_0_flush_gpu_tlb(adev, vmid,
+							i, 0);
+			} else {
+				gmc_v9_0_flush_gpu_tlb(adev, vmid,
+						AMDGPU_GFXHUB_0, 0);
+			}
+			break;
+		}
+	}
+
+	return 0;
+
+}
+
 static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 					    unsigned vmid, uint64_t pd_addr)
 {
@@ -700,6 +788,7 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 
 static const struct amdgpu_gmc_funcs gmc_v9_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v9_0_flush_gpu_tlb,
+	.flush_gpu_tlb_pasid = gmc_v9_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v9_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v9_0_emit_pasid_mapping,
 	.map_mtype = gmc_v9_0_map_mtype,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
