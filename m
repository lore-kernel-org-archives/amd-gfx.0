Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D057CC33CA4
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:40:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACF820880
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:40:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="vTLMDKK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACF820880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69E526E243;
	Sat, 11 Jan 2020 18:40:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E92E6E23D
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 18:39:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVAYw6+hm6HpkqnKX7ep7j+OO1ThjBmbYVjFvq8NwfkyAdB+kggduzNC5hoDpVr0KCkRrrNIOi4j8esDhtRulZC8xYIZFUXMGDS05oKVsOMoXyA86B4GmlZVhTUrzfq7TAO5OIP7Qcykyb2juX4jCQ44Hd2HxwSLuZ9bVEi3am0Fmxqi0MEHIENaUmRcbNhm4GZTlA8rlfallW7TejYWyuTnVhbqBIXAKcfE3CUVbSt6FnWufq+KxCLWOQx+ZRMAePN0DofAkvsBcCEAkXcvMttf/93zyUa2M+1wYdYosCdobsks+pXhyhArR+bstZdRCl4Ycwxd78/xz0utzrtDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1va6+bXqreGqjVKkmBsZZUlhh0kwFusgEQer+MSpmCc=;
 b=l/z/tspZaRGul9RUCHAjnQAeskLgRnEtjGuckRZF1tNbRu1R0OXBAM3XBM4vt+CcvwKRALoKwxpxUGUIG57ZX351ht83FnVKatsLSnd8UNdcvJ9+B7k+yidI1lmGvt8g75NiJxinsI+g6P9ysbQHb59FHpTb+HH/k3UvKyKCZcE3Vvf2nWn9p1j/lIEb16Olxi7LSTlUTtulbJocmDuFB21dWS8Pq6C714LcQMwLqM/55e7tzTtJMD0O7CEdtGzcNQH37g+p5+QGxObWSY6bPq2dRj4uO9CSuqKYL1eQM4iwTHtFAL2N5f11FFK/HdII/Ztnx3eOvqucw4ZDFfmLAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1va6+bXqreGqjVKkmBsZZUlhh0kwFusgEQer+MSpmCc=;
 b=vTLMDKK/431xyD1Mtfk5zJRwptaJDhknmI+Z6sjU3otx+NBI5flHk0dvg/r4Y+r1y5PpFil4iMj/n49XMSfXFvCbNVbgA+YaotAwFtqjoae3PYFP7VvFVta5yjjZGpuKHXYaPHe7s7OGOOz6PXYOTJuXTf/xsqZkH1s1QvvlAJE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.104.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Sat, 11 Jan 2020 18:39:56 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.014; Sat, 11 Jan 2020
 18:39:56 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/7] drm/amdgpu: export function to flush TLB via pasid
Date: Sat, 11 Jan 2020 12:39:36 -0600
Message-Id: <20200111183938.126310-5-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200111183938.126310-1-alex.sierra@amd.com>
References: <20200111183938.126310-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR16CA0054.namprd16.prod.outlook.com (2603:10b6:805:ca::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13 via Frontend Transport; Sat, 11 Jan 2020 18:39:54 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7dd3234-c1af-46fe-4805-08d796c5a6ad
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:|SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814C157B6E31D0D1A631D45FD3B0@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0279B3DD0D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(66476007)(26005)(66556008)(66946007)(16526019)(186003)(7696005)(52116002)(6916009)(86362001)(478600001)(4326008)(36756003)(5660300002)(6486002)(30864003)(8676002)(316002)(6666004)(956004)(8936002)(2906002)(81166006)(81156014)(1076003)(44832011)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2814;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aocjgtbtotkOyq1kXCgPn2wbiEyIuA4v06NcFGmJBHBlFr20DJ0zBiUi5ztM7C2mnhMdr5+PiLKd3LR5ObSxMulX3SCvPZB7eQZ9+JN3xw10I65OHQ0UwAIFd7HEaF9HvOgoFI3llom+KgXO4BkXCsGbYG0obAgHE8PAhjC8ZHGs5eJ8HUZUYW/+LS3eKtMoOhPZWX/E/RsyWKsRAI4RZ3Oj17Oz84SSwelBpxPGlnJ9Uqg+nRznjYS5qd/OFU8X3QiHlSPF7EqOiZ04eKP9PTTvop9K05Ka9Mdv8ejVr3MbctQQoo5GxVvLy6EAYZ9jSve1R49m8If7uE7ZhOM1iImLei73LkahLsJwE3jFNcURsWeqhzTAa6m5xNyo2YXRyM+O5KoKf65VTx39iGTTQN7aur+eUeIfreOph8Jdq9BrPBbeQXQb6wKrW7brXfLa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7dd3234-c1af-46fe-4805-08d796c5a6ad
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2020 18:39:54.9349 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ss2saFRALnwDklXwVIfVzM9srX2ezRclqn3VWlg6GACcZH2R+V5/hH0p9LLALKKi/1trkEfUf/VabEw5zAU+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2814
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  6 +++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 59 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 33 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 34 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 61 +++++++++++++++++++++++++
 5 files changed, 193 insertions(+)

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
index 5ad89bb6f3ba..09408b8b390f 100644
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
@@ -234,6 +237,19 @@ static bool gmc_v10_0_use_invalidate_semaphore(struct amdgpu_device *adev,
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
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -380,6 +396,48 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+
+	if (amdgpu_emu_mode == 0 && ring->sched.ready)
+		return kiq->pmf->kiq_invalidate_tlbs(ring,
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
@@ -531,6 +589,7 @@ static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
 
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
index b83c8d745f42..95cce54999b7 100644
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
 
@@ -441,6 +443,18 @@ static bool gmc_v9_0_use_invalidate_semaphore(struct amdgpu_device *adev,
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
 /*
  * GART
  * VMID 0 is the physical GPU addresses as used by the kernel.
@@ -539,6 +553,52 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+
+	if (adev->in_gpu_reset)
+		return -EIO;
+
+	if (ring->sched.ready)
+		return kiq->pmf->kiq_invalidate_tlbs(ring,
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
@@ -700,6 +760,7 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 
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
