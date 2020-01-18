Return-Path: <SRS0=udmR=3H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D9EC33C9E
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jan 2020 01:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C65521D56
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Jan 2020 01:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qeUTFlVz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C65521D56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFBA6F98F;
	Sat, 18 Jan 2020 01:38:21 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E6236F98F
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Jan 2020 01:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S55bwFaN33nHE5mqR0f9Brb7inBBTAq/ySdymG9rvnWgyxF37lvy6JTQpPQ8bWuJnR/bjmhrS1kEY6Khzfpow8dAwhzqGqITNveKTNh0Ixxa7szM2jSdzwaKfWlVTTOb2XcAI8YvlVMLi6aI8cu3UVu4jlH0a5Vg/O7y9N3VZHTGiGyMw3kcOII/CMU5QIlmL2K1I1xiXqSnuu0Fgh512Sttvsca3by8jw4ET6/AX+/0369JmI0wEI3xYbSSzMBVPuQ7HvQ/zfIWYey/q44P6RRTrKDa7RK+CksMSRvSkDmSiekuvdOnQYi9leXfVf2bp4Q0JxQQtdR+C2XpNuyluA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+Q6K5gg5/8c5Qh4SeZRehBX9dRxgfI107xDad8nwis=;
 b=OfZVsok6dfBNT0IFi/NkeY+ffNZJ3S6necBbkvG6GxAJ1af4U3S+7bsvgmcPHwikQl3rfzAaCuriJRapZYqXo19OltI2cGMADZF3BQxrv6HMuw95Qp7Vu+Nh0CS8TNg208xNYFLhwK7tmXpHFcj+1kzVG/fO3/vgSoC5eLYxGh4bevAx/M/PzAPNj+mNDaeQ60Zt0ARk17o8A2x9Xpy47JpVzrhTkjz39JD75HvsvtxzbbbICGh/rrib3zDey34uHWntFrFtPTrwmNvqDLXiDt4jVhJ6hPJ2zFpFrMB8+X3Snd+YR6L3/wlEYVfaRvQS2jNqnUzYaOcei9XWNOKPhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+Q6K5gg5/8c5Qh4SeZRehBX9dRxgfI107xDad8nwis=;
 b=qeUTFlVzeYjLFjgxwkUs+CfPGGxRsrxh34iDuA8e84ULWQ6wYiWQXkdzS0j0sLsUsdI4CNy4tseuuyWml96t0WjQ9aX2IDBhewS2/Ho4lQagA/3296FpnJRF0OtCQ9OiIr2gR18Pc1MoN5caOdikv0aziDu+0gZ1frmx9t3PMGo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com (10.174.105.140) by
 DM5PR1201MB0009.namprd12.prod.outlook.com (10.172.85.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.23; Sat, 18 Jan 2020 01:38:19 +0000
Received: from DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c]) by DM5PR1201MB0090.namprd12.prod.outlook.com
 ([fe80::7119:ff0:b3eb:619c%4]) with mapi id 15.20.2644.023; Sat, 18 Jan 2020
 01:38:19 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: Improve Vega20 XGMI TLB flush workaround
Date: Fri, 17 Jan 2020 20:37:35 -0500
Message-Id: <20200118013735.19361-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200118013735.19361-1-Felix.Kuehling@amd.com>
References: <20200118013735.19361-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::25) To DM5PR1201MB0090.namprd12.prod.outlook.com
 (2603:10b6:4:53::12)
MIME-Version: 1.0
Received: from Harpoon.amd.com (165.204.55.251) by
 YTOPR0101CA0048.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.18 via Frontend
 Transport; Sat, 18 Jan 2020 01:38:19 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e299d40a-933e-4796-bd2f-08d79bb718a6
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0009:|DM5PR1201MB0009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB00098506F8A12858046DA0D792300@DM5PR1201MB0009.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0286D7B531
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(189003)(199004)(5660300002)(1076003)(2906002)(4326008)(6666004)(316002)(6486002)(86362001)(6916009)(478600001)(36756003)(956004)(8676002)(7696005)(52116002)(2616005)(66556008)(16526019)(186003)(66946007)(66476007)(81156014)(81166006)(26005)(8936002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR1201MB0009;
 H:DM5PR1201MB0090.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c7BHdluJc+7TiAXUXvLcx8e0zN56jMSsVHcwWgQ3ghAMR3bloMC1twoEanhN2kpCz18kJHZ2iu7NNeYles3fDtGM7Gri0cLmHarPG4Ki4fjr4o8/yphC0dKbMcvRfP5NadLIz53CHJsjHCB5OLcg0DqmBOmPiMUoPznpvZSxvVNCsF4yWKfiomdjSo850giVD7+M5EOLL7Ef+TplGRZWRz+EmGQvFO6p5JUoVdNa28ybjbgs6GuiipYAPxYVrE+d0qlMhILC4TNU/XNqg0j1cgTQF3E06UgtS/FKjY4Xbo40JDh+678a0zC0hCShRXbNiL0Q9UKD2utJ5+w55ftetuwBgvbDyeU8vk1c5iWIADG7mYB7w5ZdHKYnJc0JWADiO5SFI3xripAO2RtDshCkPg3rTYOOIa70RbKOHM6trs+VTOWZ99V+lIVLIlkHvjPw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e299d40a-933e-4796-bd2f-08d79bb718a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2020 01:38:19.3554 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3aYUy0ixHo6eWwsi0bRMteMrDYMUMFcBdlfUpy6m58w/h4QTfSmQx1rIEIgfv/MyiH20iGxONZboQcx1XyDDGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0009
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
Cc: shaoyun.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Using a heavy-weight TLB flush once is not sufficient. Concurrent
memory accesses in the same TLB cache line can re-populate TLB entries
from stale texture cache (TC) entries while the heavy-weight TLB
flush is in progress. To fix this race condition, perform another TLB
flush after the heavy-weight one, when TC is known to be clean.

Move the workaround into the low-level TLB flushing functions. This way
they apply to amdgpu as well, and KIQ-based TLB flush only needs to
synchronize once.

CC: shaoyun.liu@amd.com
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      | 68 +++++++++++++++++-----
 2 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 8609287620ea..5325f6b455f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -647,13 +647,9 @@ int amdgpu_amdkfd_flush_gpu_tlb_vmid(struct kgd_dev *kgd, uint16_t vmid)
 int amdgpu_amdkfd_flush_gpu_tlb_pasid(struct kgd_dev *kgd, uint16_t pasid)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)kgd;
-	uint32_t flush_type = 0;
+	const uint32_t flush_type = 0;
 	bool all_hub = false;
 
-	if (adev->gmc.xgmi.num_physical_nodes &&
-		adev->asic_type == CHIP_VEGA20)
-		flush_type = 2;
-
 	if (adev->family == AMDGPU_FAMILY_AI)
 		all_hub = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 90216abf14a4..e2a5e852bdb0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -476,13 +476,26 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
 	const unsigned eng = 17;
-	u32 j, inv_req, tmp;
+	u32 j, inv_req, inv_req2, tmp;
 	struct amdgpu_vmhub *hub;
 
 	BUG_ON(vmhub >= adev->num_vmhubs);
 
 	hub = &adev->vmhub[vmhub];
-	inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+	if (adev->gmc.xgmi.num_physical_nodes &&
+	    adev->asic_type == CHIP_VEGA20) {
+		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
+		 * heavy-weight TLB flush (type 2), which flushes
+		 * both. Due to a race condition with concurrent
+		 * memory accesses using the same TLB cache line, we
+		 * still need a second TLB flush after this.
+		 */
+		inv_req = gmc_v9_0_get_invalidate_req(vmid, 2);
+		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+	} else {
+		inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+		inv_req2 = 0;
+	}
 
 	/* This is necessary for a HW workaround under SRIOV as well
 	 * as GFXOFF under bare metal
@@ -521,21 +534,27 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
+	do {
+		WREG32_NO_KIQ(hub->vm_inv_eng0_req + eng, inv_req);
 
-	/*
-	 * Issue a dummy read to wait for the ACK register to be cleared
-	 * to avoid a false ACK due to the new fast GRBM interface.
-	 */
-	if (vmhub == AMDGPU_GFXHUB_0)
-		RREG32_NO_KIQ(hub->vm_inv_eng0_req + eng);
+		/*
+		 * Issue a dummy read to wait for the ACK register to
+		 * be cleared to avoid a false ACK due to the new fast
+		 * GRBM interface.
+		 */
+		if (vmhub == AMDGPU_GFXHUB_0)
+			RREG32_NO_KIQ(hub->vm_inv_eng0_req + eng);
 
-	for (j = 0; j < adev->usec_timeout; j++) {
-		tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack + eng);
-		if (tmp & (1 << vmid))
-			break;
-		udelay(1);
-	}
+		for (j = 0; j < adev->usec_timeout; j++) {
+			tmp = RREG32_NO_KIQ(hub->vm_inv_eng0_ack + eng);
+			if (tmp & (1 << vmid))
+				break;
+			udelay(1);
+		}
+
+		inv_req = inv_req2;
+		inv_req2 = 0;
+	} while (inv_req);
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore)
@@ -577,9 +596,26 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 		return -EIO;
 
 	if (ring->sched.ready) {
+		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
+		 * heavy-weight TLB flush (type 2), which flushes
+		 * both. Due to a race condition with concurrent
+		 * memory accesses using the same TLB cache line, we
+		 * still need a second TLB flush after this.
+		 */
+		bool vega20_xgmi_wa = (adev->gmc.xgmi.num_physical_nodes &&
+				       adev->asic_type == CHIP_VEGA20);
+		/* 2 dwords flush + 8 dwords fence */
+		unsigned int ndw = kiq->pmf->invalidate_tlbs_size + 8;
+
+		if (vega20_xgmi_wa)
+			ndw += kiq->pmf->invalidate_tlbs_size;
+
 		spin_lock(&adev->gfx.kiq.ring_lock);
 		/* 2 dwords flush + 8 dwords fence */
-		amdgpu_ring_alloc(ring, kiq->pmf->invalidate_tlbs_size + 8);
+		amdgpu_ring_alloc(ring, ndw);
+		if (vega20_xgmi_wa)
+			kiq->pmf->kiq_invalidate_tlbs(ring,
+						      pasid, 2, all_hub);
 		kiq->pmf->kiq_invalidate_tlbs(ring,
 					pasid, flush_type, all_hub);
 		amdgpu_fence_emit_polling(ring, &seq);
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
