Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347A3C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 23:12:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4D72218AC
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 23:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ONEv7gwX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4D72218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6976EA9E;
	Wed, 18 Dec 2019 23:12:37 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49AE26EA9E
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Dec 2019 23:12:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m6Yp+b5My1bc5jVFYPrN9wPLFEuqC82Fw6mruRzOKg0G2+0fvHGmdK+hYyTnf5oZpHaR/BcNq3KVpwgAKr2yQatUZIOsOJUPssAoTrdu/ACq1fIYcf80tbp2Ah41bO5TLBkkaeDMeS8++CRf3wtQ2QXWcd7xQHNIEvyRXaCfNWAlP4Ev69KZFkU5pbR9BnQZnckLDVgmxATcyA1M/huQi3R9z4+8ZcsvbG1h/fBOorycWIZZtGlrKbH4rbwP/XDN3HiS88puPm4gh2Y16UCSQ7ZmWPjZJnIKZqbm1ZjCSsJI/RsdtFKcgQGZn5Xt/P1OkSQCwdrew5hXtDZFE7rtMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ale3esIUnlkSdsbj5kRCQrSmykGTFcOMeLnV70mErLg=;
 b=UMNJq0xBNBzhxW9UpKrscrd9C0BOqkBN+wfHoahO3fgA+4lmu1gcIWSegMa/Cz8yLH6+nctqvfVUWjp+/FAcTleqE3NB8V61r8iLPw3fVPLZ11MSUlmN9PcfUqgnGG3Q3y6/YIFgY+VZcCWkLmf+C8HvxTuz05Ng01qpWvI2nKNaVMtbZ/WcyMcN5xsgOwe23ss06C6Ze4JdSuOyDS03YKIWVnDFRQPUUGrla/qiVyD15xBAm532XRYNMiGOPec/zjnSLKEQl+k3DUelgDROUBLDuamI6JSsi3tu4qUlxEaglAZQYz8WiQibgeJ6ghldV4Fc4OIil6wZoN9kAy0VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ale3esIUnlkSdsbj5kRCQrSmykGTFcOMeLnV70mErLg=;
 b=ONEv7gwXCDgxGSR0slRm2zKVUyOl5JNg3swaEqc+SWcws19uvUHNdG71sLDGb0qaQmhWqUTOQ6+KuDJrU00EdqZG2t03DwozI3QSGj7g/ZwllS+t1MuIMbIJJVy8kEeLndjbUaZWGClP4b8fnh7yoDCSdYxPrjkzTTSLcHmoRsY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Luben.Tuikov@amd.com; 
Received: from DM6PR12MB3355.namprd12.prod.outlook.com (20.178.29.90) by
 DM6PR12MB3019.namprd12.prod.outlook.com (20.178.199.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.13; Wed, 18 Dec 2019 23:12:33 +0000
Received: from DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a]) by DM6PR12MB3355.namprd12.prod.outlook.com
 ([fe80::799b:b372:6589:c8a%7]) with mapi id 15.20.2538.019; Wed, 18 Dec 2019
 23:12:33 +0000
From: Luben Tuikov <luben.tuikov@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: simplify padding calculations (v3)
Date: Wed, 18 Dec 2019 18:12:17 -0500
Message-Id: <20191218231217.204500-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.24.0.390.g083378cc35
X-ClientProxiedBy: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To DM6PR12MB3355.namprd12.prod.outlook.com
 (2603:10b6:5:115::26)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0.390.g083378cc35
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aec4355e-59dd-4b08-a56b-08d7840fc358
X-MS-TrafficTypeDiagnostic: DM6PR12MB3019:|DM6PR12MB3019:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3019B4437B23E1CCC212089D99530@DM6PR12MB3019.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0255DF69B9
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(366004)(39860400002)(346002)(376002)(199004)(189003)(44832011)(86362001)(81156014)(6666004)(5660300002)(66946007)(478600001)(1076003)(4326008)(6512007)(52116002)(316002)(8676002)(6506007)(2906002)(36756003)(8936002)(186003)(2616005)(6486002)(26005)(66556008)(81166006)(54906003)(6916009)(66476007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3019;
 H:DM6PR12MB3355.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ygzKAgF4rxNJPBlHEZJcohx5rsGIq7FUHLlPO6Wl54RVG9ir2fMpOYPKf9I+flcFKA9yWJYt+tiEmBRVGWi8pVd80UTMdmzGzxI2dOZC2/TYJYymKr8etkXgLz2zJkoPvVogo7/uLQYP/Kbe5pSrwBYpSL9BlHOKervOwycY7VL5nDBvqjsNoEmYaQbIqW/cn2bqPIvj0n+lOpt2XNRnD1VAHiKjL9Arksn7Y772HiSq/9jojmKo4B/E9ssoo2uLsdOJ+WHKfQaOz8KHZJrAIIeDuYkh4EmAewwR2McWk6onhvgKutaF27aAyyekUQadwfJNw445H9MDalQDpBiYBVjem4ByMPO3XSvc+QT8+6tXu7mz+DxOBZDz7WQIABtr4HX2wT+bc5bvYP88SkvnRFtS2tPz7NWjFk/k9ZyjRw2/qWBkNaM70LnDf7sqiy12
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec4355e-59dd-4b08-a56b-08d7840fc358
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2019 23:12:33.4965 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ljtV/JtN8UkC/Anhwk/a0kE5Vbt8i1MaeeFcwJOKF6VDUp8afmaVkYsXAjPi/pAh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3019
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
Cc: Alexander Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Simplify padding calculations.

1. Taking the remainder of a binary value when
the divisor is a power of two, such as,
a % 2^n is identical to, a & (2^n - 1) in base-2
arithmetic, and so expressions like this:

(12 - (lower_32_bits(ring->wptr) & 7)) % 8

are superflous. And can be reduced to a single
remainder-taking operation.

2. Subtracting the remainder modulo 8 out of 12
and then again taking the remainder modulo 8,
yields the same result as simply subtracting
the value out of 4 and then taking the remainder.
This is true because 4 belongs to the congruence
(residue) class {4 + 8*k}, k in Z. (So using,
 {..., -12, -4, 4, 12, 20, ...}, would yield
 the same final result.

So the above expression, becomes,

(4 - lower_32_bits(ring->wptr)) & 7

3. Now since 8 is part of the conguence class
{0 + 8*k}, k in Z, and from 1) and 2) above, then,

(8 - (ib->length_dw & 0x7)) % 8

becomes, simply,

(-ib->length_dw) & 7.

This patch implements all of the above in this code.

v2: Comment update and spacing.
v3: Add 1, 2, 3, above, in this commit message.

Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c  |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 17 ++++++++++++-----
 5 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 1f22a8d0f7f3..4274ccf765de 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -228,7 +228,7 @@ static void cik_sdma_ring_emit_ib(struct amdgpu_ring *ring,
 	u32 extra_bits = vmid & 0xf;
 
 	/* IB packet must end on a 8 DW boundary */
-	cik_sdma_ring_insert_nop(ring, (12 - (lower_32_bits(ring->wptr) & 7)) % 8);
+	cik_sdma_ring_insert_nop(ring, (4 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PACKET(SDMA_OPCODE_INDIRECT_BUFFER, 0, extra_bits));
 	amdgpu_ring_write(ring, ib->gpu_addr & 0xffffffe0); /* base must be 32 byte aligned */
@@ -811,7 +811,7 @@ static void cik_sdma_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 	u32 pad_count;
 	int i;
 
-	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
+	pad_count = (-ib->length_dw) & 7;
 	for (i = 0; i < pad_count; i++)
 		if (sdma && sdma->burst_nop && (i == 0))
 			ib->ptr[ib->length_dw++] =
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 606b621145a1..fd7fa6082563 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -255,7 +255,7 @@ static void sdma_v2_4_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
 	/* IB packet must end on a 8 DW boundary */
-	sdma_v2_4_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) & 7)) % 8);
+	sdma_v2_4_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -750,7 +750,7 @@ static void sdma_v2_4_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
 	u32 pad_count;
 	int i;
 
-	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
+	pad_count = (-ib->length_dw) & 7;
 	for (i = 0; i < pad_count; i++)
 		if (sdma && sdma->burst_nop && (i == 0))
 			ib->ptr[ib->length_dw++] =
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index a559573ec8fd..4a8a7f0f3a9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -429,7 +429,7 @@ static void sdma_v3_0_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
 	/* IB packet must end on a 8 DW boundary */
-	sdma_v3_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) & 7)) % 8);
+	sdma_v3_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1021,7 +1021,7 @@ static void sdma_v3_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
 	u32 pad_count;
 	int i;
 
-	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
+	pad_count = (-ib->length_dw) & 7;
 	for (i = 0; i < pad_count; i++)
 		if (sdma && sdma->burst_nop && (i == 0))
 			ib->ptr[ib->length_dw++] =
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index bd9ed33bab43..c69df0cb21ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -698,7 +698,7 @@ static void sdma_v4_0_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 
 	/* IB packet must end on a 8 DW boundary */
-	sdma_v4_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) & 7)) % 8);
+	sdma_v4_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1579,7 +1579,7 @@ static void sdma_v4_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
 	u32 pad_count;
 	int i;
 
-	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
+	pad_count = (-ib->length_dw) & 7;
 	for (i = 0; i < pad_count; i++)
 		if (sdma && sdma->burst_nop && (i == 0))
 			ib->ptr[ib->length_dw++] =
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 119364293cec..3912937f878f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -382,8 +382,15 @@ static void sdma_v5_0_ring_emit_ib(struct amdgpu_ring *ring,
 	unsigned vmid = AMDGPU_JOB_GET_VMID(job);
 	uint64_t csa_mc_addr = amdgpu_sdma_get_csa_mc_addr(ring, vmid);
 
-	/* IB packet must end on a 8 DW boundary */
-	sdma_v5_0_ring_insert_nop(ring, (10 - (lower_32_bits(ring->wptr) & 7)) % 8);
+	/* An IB packet must end on a 8 DW boundary--the next dword
+	 * must be on a 8-dword boundary. Our IB packet below is 6
+	 * dwords long, thus add x number of NOPs, such that, in
+	 * modular arithmetic,
+	 * wptr + 6 + x = 8k, k >= 0, which in C is,
+	 * (wptr + 6 + x) % 8 = 0.
+	 * The expression below, is a solution of x.
+	 */
+	sdma_v5_0_ring_insert_nop(ring, (2 - lower_32_bits(ring->wptr)) & 7);
 
 	amdgpu_ring_write(ring, SDMA_PKT_HEADER_OP(SDMA_OP_INDIRECT) |
 			  SDMA_PKT_INDIRECT_HEADER_VMID(vmid & 0xf));
@@ -1076,10 +1083,10 @@ static void sdma_v5_0_vm_set_pte_pde(struct amdgpu_ib *ib,
 }
 
 /**
- * sdma_v5_0_ring_pad_ib - pad the IB to the required number of dw
- *
+ * sdma_v5_0_ring_pad_ib - pad the IB
  * @ib: indirect buffer to fill with padding
  *
+ * Pad the IB with NOPs to a boundary multiple of 8.
  */
 static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib)
 {
@@ -1087,7 +1094,7 @@ static void sdma_v5_0_ring_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib
 	u32 pad_count;
 	int i;
 
-	pad_count = (8 - (ib->length_dw & 0x7)) % 8;
+	pad_count = (-ib->length_dw) & 0x7;
 	for (i = 0; i < pad_count; i++)
 		if (sdma && sdma->burst_nop && (i == 0))
 			ib->ptr[ib->length_dw++] =
-- 
2.24.0.390.g083378cc35

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
