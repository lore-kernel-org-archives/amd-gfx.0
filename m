Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7889FC43603
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C07321D7D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 06:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="w/P1RJ+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C07321D7D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3865B6EBD2;
	Fri, 20 Dec 2019 06:25:14 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2065.outbound.protection.outlook.com [40.107.236.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 445526EBD2
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 06:25:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSLJx+4BdT5Ss4yZYinZlEeKGpiDlBlNUcC4IDeTdqIIQJSv8CkdieZpbmufde/y5eJ+PhdCcq8TwixgHqJAHbZlrXfM5sSWW+OqXfOAkUC/MUfw3+yhCpLKlJ/f51vDvDIdQ2hss5OQ0Vy3RggatO+ebvlj4bRuz2kQXqqBVxdI3vHZZmrZjQiKfivizJnfhdVoKKbGbT1tsVmPQG0GDnHC6P1k1Zt2qBzqWGxwujzilUKYnSsHf4bm33a3hRgE0paieFQnpVcFay+ZYFn55tWdyfRPJOUcD4H6LUrwqtDSyUYuQs7vzDj13tg6Enf0+z006SxwxAXhwjwYh7x7Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOFf9S4Jc75mgOoKg6OVwYiyesqU2fHU6+vf6MoIZRQ=;
 b=LKkJf1/TfAIdphTU6y1t3U5kntqdtWAmy8bm9AevLAmqsz63YyiV/at1YL4/hIEOonMeV+hOKvFxlN5O8EMzs7r1y58XNF8ySvoY4+Gk5UHfR+thtcVDlTnXDg7EqTXL/MJNOPfZAjKLxc7edB/qXaGmuNjNzr+J+1e2qkwl/EHr17Q/wT3ER61Lfw+Y+smhEevjTLkrncUwleWQAse0SMzL+yZABc58DraAXLAzThSWSmiDFLFPC16WUclih0sNv/prmP8h7RVHEBDf7JgjNOOOubPbMinzi+ShgpVmj2U237RnQfZDiOjkZoUjeGdDlbKSvZOoDZmICkABUEULOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sOFf9S4Jc75mgOoKg6OVwYiyesqU2fHU6+vf6MoIZRQ=;
 b=w/P1RJ+BYwtqSTQjhhPyXUBY9fZNqf2973Ea6h7GOwWqQMOx2LYWAOfvCwGzykrg35adVQlVZGx4hcIBfA5mO6Z6+psOX3Jsn/rEYJTLfvdEJr4H0txoTp3hLcRk8aZ6i5WpLkVwCA4ZKplUwYdAGZBc6ywaDL5foY/DW+lqBMM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from BYAPR12MB2616.namprd12.prod.outlook.com (20.177.124.144) by
 BYAPR12MB2775.namprd12.prod.outlook.com (20.176.255.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Fri, 20 Dec 2019 06:25:10 +0000
Received: from BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e]) by BYAPR12MB2616.namprd12.prod.outlook.com
 ([fe80::39fb:deaf:bb2f:420e%7]) with mapi id 15.20.2516.021; Fri, 20 Dec 2019
 06:25:10 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/5] drm/amdgpu: export function to flush TLB via pasid
Date: Fri, 20 Dec 2019 00:24:39 -0600
Message-Id: <20191220062442.33635-2-alex.sierra@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0aa129d-11ce-4621-8603-08d785155c7c
X-MS-TrafficTypeDiagnostic: BYAPR12MB2775:|BYAPR12MB2775:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB27759718438669103026E5D1FD2D0@BYAPR12MB2775.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:758;
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
X-Microsoft-Antispam-Message-Info: 3EKeCtriBMeahzF80r30LAruK42NpchryhMjVpXGF8jcT/nJxpE01Ky6n3Mq0LD2FkeCObTnHHzZuvmbBDa1aZnBLfcuMHLo/j7lOI14kjsjwzAoKSU5gHLPko6Lm4B+ohtxSeM9yfJFPVXZaSKZwPA7X3VuSPSK1GdsVy/M338kOdO5N2v4s2aRohEy0QhD2tJL7AePRze0rsqGMVGg4bBBUrjp30KzXZFD7baaJUdBm6Zq0jA1VOLmt+L/2gy6IZUrg19hWNUh8o4RmvrDBeB00gkQeWWYoxOFztv9zr7gLuaDFihU39BeQ9MPO2m/dq4UQIFMc9lvkzHpMa5huJjH58VP+u9gLRTYImV/b1Alxvff5g7jlS9qFDmmbhLX33yq64ZspNFCNcg9PZBUZyiBbDBTHnNYMytnWec8U3cUs5tDM2IxKhk3Pc8SFWgb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0aa129d-11ce-4621-8603-08d785155c7c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 06:25:10.8255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewyHgWoS9zjVogu6qhL+7ExZ2beBgvf38QKd/aC/JCQiGWTYH69OHE+zn5mZGhRIi1aooEaDOCO/zfepW4HocA==
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

This can be used directly from amdgpu and amdkfd to invalidate
TLB through pasid.
It supports gmc v7, v8, v9 and v10.

Change-Id: I6563a8eba2e42d1a67fa2547156c20da41d1e490
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 81 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 33 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 34 ++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 84 +++++++++++++++++++++++++
 5 files changed, 238 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index b499a3de8bb6..b6413a56f546 100644
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
index f5725336a5f2..b1a5408a8d7e 100644
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
@@ -380,6 +425,41 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
+	int vmid;
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
+			amdgpu_gmc_flush_gpu_tlb(adev, vmid,
+					AMDGPU_GFXHUB_0, 0);
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
@@ -531,6 +611,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 
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
index fa025ceeea0f..eb1e64bd56ed 100644
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
 
@@ -434,6 +436,47 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
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
@@ -532,6 +575,46 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
+			for (i = 0; i < adev->num_vmhubs; i++)
+				amdgpu_gmc_flush_gpu_tlb(adev, vmid,
+							i, flush_type);
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
@@ -693,6 +776,7 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 
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
