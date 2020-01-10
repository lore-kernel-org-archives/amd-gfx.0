Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C75FEC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990482075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mM4TiW7Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990482075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD1F6E97C;
	Fri, 10 Jan 2020 00:04:32 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 686096E97C
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mRAdW2mSR97V7PCIUo5q3zuH8dn9BgqJX+eSLfv6Yv1ej3nDVVN8aqBNnq6eWkkyhjeLep0QS82VWW9B8LgCvGFrZa524kZzCVDMY3WQUUkVl//+UB3YVEEg5hA+A/y4pPdCluAw1cYHWK7XZywOM4GFAO+caZZYNmXRz0d/2CirwZeKbFqZ7kuAvX1MdEy87QaVzkU31w6FWXJP+s6zNiceU9oYs4dgRAsz95Gz4KaDemTF34hyYUoVvnIPZ+yKdvfiou/o3jZO4HymUPtO3vWiZNUr+ISauYnhUpXHrCbfZFIzLxhMnDSXfLSYHpZPefaGm0lpXNav7WTXuSGBjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33eQl4wi/zTsVeEhQeWK0lIvCIkvvFoT6vT/3UgR5LE=;
 b=I0PWx/tKtnZkLxqhCs4FF4BFszl/B6qxahj/geho327oeaS2vlsffqX/IUasWXZfICWlvE6WF59I1j/wBXT9YKIfIDrf8AlGmiLnRNqtICRMZCuKj88r5FpXuU1DdXkCTf6v8fFbbXPMdABUm/2auDC3dPoceQqNGml30H9jzPDT24us4V5z+3QUOyOklfdhKvAKC2PBucQT/bGn7fDO936KdD7NHwhC8PSCU1LprW9UTjE0wQVUmJUEXq/cSpXbhcc2XZHILHgLn+hGRz5CejM8cxKL0m4jrN2/ABi+KRBVTJ4h2m/Rt8CxHDHV4bvzn2YF+V3QOsmPtlBJAFx9oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=33eQl4wi/zTsVeEhQeWK0lIvCIkvvFoT6vT/3UgR5LE=;
 b=mM4TiW7Zj4KPFixa9M/YKWfvBjRjL/pWiaBO5yPry+NjUIbFFaWRJ4yPH2C6If7jQfCBIzwnxnNFkI2uZmueY885Ap4LzOX5sHAplFEMfz3aIaRr/zEOChPqUcOyY3oRaWyWki2V8L1qycwzD+bI2UmGNk233RkAiaI/v4OKz30=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2720.namprd12.prod.outlook.com (52.135.103.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:04:28 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:04:28 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu: implement tlbs invalidate on gfx9 gfx10
Date: Thu,  9 Jan 2020 18:04:11 -0600
Message-Id: <20200110000412.66930-6-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110000412.66930-1-alex.sierra@amd.com>
References: <20200110000412.66930-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15)
 To SN6PR12MB2621.namprd12.prod.outlook.com (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN2PR01CA0005.prod.exchangelabs.com (2603:10b6:804:2::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.8 via Frontend Transport; Fri, 10 Jan 2020 00:04:28 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fadc842-21d0-4c61-5421-08d79560a90c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2720:|SN6PR12MB2720:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB272089936E884FD1A3B56A72FD380@SN6PR12MB2720.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:243;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(366004)(136003)(396003)(346002)(376002)(39850400004)(189003)(199004)(26005)(316002)(36756003)(52116002)(16526019)(186003)(956004)(86362001)(1076003)(44832011)(5660300002)(6666004)(7696005)(6916009)(2616005)(81166006)(66476007)(66946007)(6486002)(8936002)(66556008)(4326008)(2906002)(81156014)(8676002)(478600001);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2720;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XJddJ8dwcybssll8Ko+kUUO9vqrl1XxB/v69DXV9AR1j+Fp14IoZ2bWKRQMrVm5SAEg7KOYBW0aTZhk6jKk8bMykiXyH+1OBR368e799dnT9QpANF+35Dpm22Z1poSBfqqjMeDFeRCcWM+pqsNM60zAiXB7JAbxO5CyuoB7EGSaVsa6WWmXm8pVCTWNoX1imtXsVpqqDnQCzjCYyAsIT3AitCcezhyQjoePezbZpm+ftva/IuDlC1sdy3aeg2sE0ryWO+6tKlAr7OsIrxGy4YItW1ckQAo3nDhREEA8h1vbm4ayclPeFJUVp9SACp+fIuYGy7LT6tkZVtIxS+s4n67BvbCIqb0ekdmT5OgonkEdx3hNH3J2w28+um2UZ9E000x313x7eZ7Xyl92n5z43qTpm979WELRjx5/On0lh4n9bJEsVRhCNEJRg8Dae2kVA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fadc842-21d0-4c61-5421-08d79560a90c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:04:28.4029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8h1z4gtYqMUDh0nbPEKp7TD6vsgk9EoZJT7G35o+CpNQDI/7H9iQBPTUGbQH+Y9HAD+bxomJ8h3pmbuUPTzTXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2720
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

tlbs invalidate pointer function added to kiq_pm4_funcs struct.
This way, tlb flush can be done through kiq member.
TLBs invalidatation implemented for gfx9 and gfx10.

Change-Id: I1b77b364f3ae0038ff3e70e869be5f2ef6e6d293
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 +++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 33 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 32 ++++++++++++++++++++++++
 3 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 8e88e0411662..2927837bd401 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -76,11 +76,15 @@ struct kiq_pm4_funcs {
 					struct amdgpu_ring *ring,
 					u64 addr,
 					u64 seq);
+	int (*kiq_invalidate_tlbs)(struct amdgpu_ring *kiq_ring,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub);
 	/* Packet sizes */
 	int set_resources_size;
 	int map_queues_size;
 	int unmap_queues_size;
 	int query_status_size;
+	int invalidate_tlbs_size;
 };
 
 struct amdgpu_kiq {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 379e46c1b7f6..2e82213f57eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -40,6 +40,7 @@
 #include "ivsrcid/gfx/irqsrcs_gfx_10_1.h"
 
 #include "soc15.h"
+#include "soc15d.h"
 #include "soc15_common.h"
 #include "clearstate_gfx10.h"
 #include "v10_structs.h"
@@ -346,15 +347,47 @@ static void gfx10_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
 }
 
+static int gfx10_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub)
+{
+	signed long r;
+	uint32_t seq;
+	struct amdgpu_device *adev = kiq_ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+
+	spin_lock(&adev->gfx.kiq.ring_lock);
+	amdgpu_ring_alloc(kiq_ring, kiq->pmf->invalidate_tlbs_size);
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(kiq_ring,
+			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
+			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+	amdgpu_fence_emit_polling(kiq_ring, &seq);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+	r = amdgpu_fence_wait_polling(kiq_ring, seq, adev->usec_timeout);
+	if (r < 1) {
+		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 static const struct kiq_pm4_funcs gfx_v10_0_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx10_kiq_set_resources,
 	.kiq_map_queues = gfx10_kiq_map_queues,
 	.kiq_unmap_queues = gfx10_kiq_unmap_queues,
 	.kiq_query_status = gfx10_kiq_query_status,
+	.kiq_invalidate_tlbs = gfx10_kiq_invalidate_tlbs,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
 	.query_status_size = 7,
+	.invalidate_tlbs_size = 12,
 };
 
 static void gfx_v10_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d48bfae3e083..c726aa454bca 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -837,15 +837,47 @@ static void gfx_v9_0_kiq_query_status(struct amdgpu_ring *kiq_ring,
 	amdgpu_ring_write(kiq_ring, upper_32_bits(seq));
 }
 
+static int gfx_v9_0_kiq_invalidate_tlbs(struct amdgpu_ring *kiq_ring,
+				uint16_t pasid, uint32_t flush_type,
+				bool all_hub)
+{
+	signed long r;
+	uint32_t seq;
+	struct amdgpu_device *adev = kiq_ring->adev;
+	struct amdgpu_kiq *kiq = &adev->gfx.kiq;
+
+	spin_lock(&adev->gfx.kiq.ring_lock);
+	amdgpu_ring_alloc(kiq_ring, kiq->pmf->invalidate_tlbs_size);
+	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
+	amdgpu_ring_write(kiq_ring,
+			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
+			PACKET3_INVALIDATE_TLBS_ALL_HUB(all_hub) |
+			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
+			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
+	amdgpu_fence_emit_polling(kiq_ring, &seq);
+	amdgpu_ring_commit(kiq_ring);
+	spin_unlock(&adev->gfx.kiq.ring_lock);
+
+	r = amdgpu_fence_wait_polling(kiq_ring, seq, adev->usec_timeout);
+	if (r < 1) {
+		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
+		return -ETIME;
+	}
+
+	return 0;
+}
+
 static const struct kiq_pm4_funcs gfx_v9_0_kiq_pm4_funcs = {
 	.kiq_set_resources = gfx_v9_0_kiq_set_resources,
 	.kiq_map_queues = gfx_v9_0_kiq_map_queues,
 	.kiq_unmap_queues = gfx_v9_0_kiq_unmap_queues,
 	.kiq_query_status = gfx_v9_0_kiq_query_status,
+	.kiq_invalidate_tlbs = gfx_v9_0_kiq_invalidate_tlbs,
 	.set_resources_size = 8,
 	.map_queues_size = 7,
 	.unmap_queues_size = 6,
 	.query_status_size = 7,
+	.invalidate_tlbs_size = 12,
 };
 
 static void gfx_v9_0_set_kiq_pm4_funcs(struct amdgpu_device *adev)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
