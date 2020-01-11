Return-Path: <SRS0=NqWJ=3A=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2626C282DD
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:40:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CAF0F20866
	for <amd-gfx@archiver.kernel.org>; Sat, 11 Jan 2020 18:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jgFvVZQo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CAF0F20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02D1C6E241;
	Sat, 11 Jan 2020 18:39:59 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2087.outbound.protection.outlook.com [40.107.236.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A57F789DDF
 for <amd-gfx@lists.freedesktop.org>; Sat, 11 Jan 2020 18:39:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCZP+0qtRnm2/zPjQK+5xlB7JjQn3JfJYieg/enVWiUYHRbd3cYVgBUlVsXB+V300XFLegyPvYvYKhYeIiouOUcvwPxFEsqT6v1l5ZSCscRCTeye1xG7FFI1b5oAopxG/l66QZI2YpnN4q0hq+RrJ4gHEX6mnp8Fm8UlFtRnZbpSfjZObZ+S4+5UouDr2MSBTYSw3vSRBWzg01vLiS0ohaC8qVqNw6JepZV+Adqjl5btWwfaS6NLERFdCNw7sKINLsBHzFIuJ7ayObVD7ju4LuDXcwDK0gAkQXy0vD3sRggfEyjeJuYOPKaJvyKd4kZ/jSb97pTkH6HUYBJnYF6g5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejpLYrfbefTjy8NHIkDjBPk6M3P+azwuWhYEiTf6ps0=;
 b=dQUxTMOflizvaKT7yps2ldssyhNI6qKSxSZ+H098LUm9LigNrxL1zT1l7LBbg68NADG6eCuLFo37picrTm5IDt0xqSCGHK08cTKOk1f2Fyaa9VEqUjgCGPfZMtaPnZ+6AmVOyZ3kJwg/JydhqbPn0aVTL+LHXCUU0EZDmWOsOBnuu4iKwf3+kWFMvZXYUKaHbxFJlIWqdpIueu4s/M52OSIjZKaKjxru+gmLs0bXK7R9QDvRG9DMX/j4TqMLvFWo4kJDFxbGBUdBnV/dpPdRFj6nBvjFuMT4I0o0vsVsGqmUdpxbHq+tNf6uLWbrB2MN9+HQzoO7rbBCDgC6jFaxFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejpLYrfbefTjy8NHIkDjBPk6M3P+azwuWhYEiTf6ps0=;
 b=jgFvVZQoPt1qHya/eo/HbBA6ug7PG9KJ7f1ifYbNKrMoMtKX+rJMEW0TGpK/SB1As7jvI4epRqKyIJRgTGbNKrApNEw3Yw7kX5TBWlKmb9dKGDPWpixEIwY5g2rl4VWP6IX1cLWbdM4ojKZ8l6ozlEu1xD+abdf0WJq5OEI6I+g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2814.namprd12.prod.outlook.com (52.135.104.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Sat, 11 Jan 2020 18:39:55 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.014; Sat, 11 Jan 2020
 18:39:54 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/7] drm/amdgpu: replace kcq enable function on gfx_v9
Date: Sat, 11 Jan 2020 12:39:35 -0600
Message-Id: <20200111183938.126310-4-alex.sierra@amd.com>
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
 15.20.2623.13 via Frontend Transport; Sat, 11 Jan 2020 18:39:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e220679-9162-4f86-6fb0-08d796c5a62a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2814:|SN6PR12MB2814:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2814E2B6AD090B2A7C683E1DFD3B0@SN6PR12MB2814.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0279B3DD0D
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(199004)(189003)(66476007)(26005)(66556008)(66946007)(16526019)(186003)(7696005)(52116002)(6916009)(86362001)(478600001)(4326008)(36756003)(5660300002)(6486002)(8676002)(316002)(6666004)(956004)(8936002)(2906002)(81166006)(81156014)(1076003)(44832011)(2616005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2814;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKsIF5LbE7Lh+UEqPYUoOdmzmA5lOVPIxu/oOZXT3GY2XvQ6ZOFrR4fPCrOqlVBa2noQewROnnrOCVMZ0C6IK6Tb75Um1X5HL5fXhdePO2ylcHiDDiCoZvcctoG1XS8ryjR5Qb0lWPvEWGyklVm75FSuljSzxIzH9SS4CRJe/vyS5xy6Orm2NAGWnMM3HGyx9LooZlVkLPtyJ7C3qhlEL+jIBraxYSqv82uTlnFQGqlV192K5F5IBCTOA+QQaJjYqx+Uq+oSLbKoGR1epO7eOoF6lehG01F+E+Wxc9w0apbbh5kAwDietuO4ODgfDz9Dw8DbbcIQrDMUF1xmTjZ9UzeZ+7CvLfeoepFpJ84OQv8q71iTmaPoA7svRAB3R7aIpi5zuIdDyHgHR0uHcmZ/k3UsoXigu/ttrYGpB7udUuQ3T2TTj4AjhefqVg4QRP3r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e220679-9162-4f86-6fb0-08d796c5a62a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2020 18:39:54.2523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Dp/VyIZSLlQYAwBvJnGbpHhox9I/ODBLYFO/Z9XGQWGn6VBeyz7P6HRCnFoxz3Ld+dEidmI6W15FqL1qgNNnQ==
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

[Why]
There's a HW-indpendent function that enables kcq. This function uses
the kiq_pm4_funcs implementation.

[How]
Local kcq enable function removed and replace it by the generic kcq
enable under amdgpu_gfx

Change-Id: I7709bdba93742c234941a5936c82eb67e346077c
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 70 +--------------------------
 1 file changed, 1 insertion(+), 69 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5be6fab55b73..7219eacad9ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3252,74 +3252,6 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_ring *ring)
 	WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
 }
 
-static int gfx_v9_0_kiq_kcq_enable(struct amdgpu_device *adev)
-{
-	struct amdgpu_ring *kiq_ring = &adev->gfx.kiq.ring;
-	uint64_t queue_mask = 0;
-	int r, i;
-
-	for (i = 0; i < AMDGPU_MAX_COMPUTE_QUEUES; ++i) {
-		if (!test_bit(i, adev->gfx.mec.queue_bitmap))
-			continue;
-
-		/* This situation may be hit in the future if a new HW
-		 * generation exposes more than 64 queues. If so, the
-		 * definition of queue_mask needs updating */
-		if (WARN_ON(i >= (sizeof(queue_mask)*8))) {
-			DRM_ERROR("Invalid KCQ enabled: %d\n", i);
-			break;
-		}
-
-		queue_mask |= (1ull << i);
-	}
-
-	r = amdgpu_ring_alloc(kiq_ring, (7 * adev->gfx.num_compute_rings) + 8);
-	if (r) {
-		DRM_ERROR("Failed to lock KIQ (%d).\n", r);
-		return r;
-	}
-
-	/* set resources */
-	amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_SET_RESOURCES, 6));
-	amdgpu_ring_write(kiq_ring, PACKET3_SET_RESOURCES_VMID_MASK(0) |
-			  PACKET3_SET_RESOURCES_QUEUE_TYPE(0));	/* vmid_mask:0 queue_type:0 (KIQ) */
-	amdgpu_ring_write(kiq_ring, lower_32_bits(queue_mask));	/* queue mask lo */
-	amdgpu_ring_write(kiq_ring, upper_32_bits(queue_mask));	/* queue mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask lo */
-	amdgpu_ring_write(kiq_ring, 0);	/* gws mask hi */
-	amdgpu_ring_write(kiq_ring, 0);	/* oac mask */
-	amdgpu_ring_write(kiq_ring, 0);	/* gds heap base:0, gds heap size:0 */
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
-		uint64_t mqd_addr = amdgpu_bo_gpu_offset(ring->mqd_obj);
-		uint64_t wptr_addr = adev->wb.gpu_addr + (ring->wptr_offs * 4);
-
-		amdgpu_ring_write(kiq_ring, PACKET3(PACKET3_MAP_QUEUES, 5));
-		/* Q_sel:0, vmid:0, vidmem: 1, engine:0, num_Q:1*/
-		amdgpu_ring_write(kiq_ring, /* Q_sel: 0, vmid: 0, engine: 0, num_Q: 1 */
-				  PACKET3_MAP_QUEUES_QUEUE_SEL(0) | /* Queue_Sel */
-				  PACKET3_MAP_QUEUES_VMID(0) | /* VMID */
-				  PACKET3_MAP_QUEUES_QUEUE(ring->queue) |
-				  PACKET3_MAP_QUEUES_PIPE(ring->pipe) |
-				  PACKET3_MAP_QUEUES_ME((ring->me == 1 ? 0 : 1)) |
-				  PACKET3_MAP_QUEUES_QUEUE_TYPE(0) | /*queue_type: normal compute queue */
-				  PACKET3_MAP_QUEUES_ALLOC_FORMAT(0) | /* alloc format: all_on_one_pipe */
-				  PACKET3_MAP_QUEUES_ENGINE_SEL(0) | /* engine_sel: compute */
-				  PACKET3_MAP_QUEUES_NUM_QUEUES(1)); /* num_queues: must be 1 */
-		amdgpu_ring_write(kiq_ring, PACKET3_MAP_QUEUES_DOORBELL_OFFSET(ring->doorbell_index));
-		amdgpu_ring_write(kiq_ring, lower_32_bits(mqd_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(mqd_addr));
-		amdgpu_ring_write(kiq_ring, lower_32_bits(wptr_addr));
-		amdgpu_ring_write(kiq_ring, upper_32_bits(wptr_addr));
-	}
-
-	r = amdgpu_ring_test_helper(kiq_ring);
-	if (r)
-		DRM_ERROR("KCQ enable failed\n");
-
-	return r;
-}
-
 static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -3726,7 +3658,7 @@ static int gfx_v9_0_kcq_resume(struct amdgpu_device *adev)
 			goto done;
 	}
 
-	r = gfx_v9_0_kiq_kcq_enable(adev);
+	r = amdgpu_gfx_enable_kcq(adev);
 done:
 	return r;
 }
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
