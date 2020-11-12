Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E52AC388F9
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 01:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CDE020678
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 01:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wBhybYAt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CDE020678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81C06E0D0;
	Thu, 12 Nov 2020 01:01:19 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 303816E0CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 01:01:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAlNS5r21LlsVfiBXBh0lO9q/j2rN9Oq7vjaKEhAeTqFmbPINh0ig+/1kmB7154Zxr1lmJzcwK+C4uwEvgJEORxZoQJctmZKvdljHosRvNIlGAwYM0zDJS6eXODRpH/xX2yrsYuGJ2Hjh0l6iWafRaQNhwX19uck1J6Nk3SAXYiLhJ3nQM7Hf8Za5fVx4uhNXvbr7c+34pcPqdkqCuBEoAagmvqSbrhVK4pvYuIIKF3oUvkdPgW0wARqC+VNuYkyN59sQdMi5gWvJC9LOoyTIwctJ9/Gyxe+nrSxJuLwPJs37Tq2qltgNxmxp009oajQla9cC8DtV2u/IlNj/7N5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcCQJVA6uWr4Bb6k9xpQIE6kKI2dphnjuNhLMcYUVII=;
 b=fu4jP65IxOYLmwckJBu6eLP6FdKP5f7vjAg0YswbR46FrC2McajuZs5SFnHoLGryrDRpphwyzJId4D5o7RAU/zrP5jPsIuHNiPsAcnlh1NLJRbv7RJT07o6dyMgsWvAnqf+8+ozhgVSzzLnkENtHi9QvhnoNBCKB5aR1xcDjOUXwjppcZzfiypD6eNcziyvm0lnqmP0jwYiuquxJy3jJ0f3Rcj1t6zRt9t1NBuez9hqKbgdrVjuXdC+SuT1ekfBlSQdrWkOBClVWwfW0kDafQL03nr2W0VKlngKFlI9mdhi2EKkbP1XLlEYpJ3Dj4DkxXl4U85WF5Lhq2b2NiN26ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcCQJVA6uWr4Bb6k9xpQIE6kKI2dphnjuNhLMcYUVII=;
 b=wBhybYAtJz0U8z3yxlVt9pxqdG5ULJdfPER6vc3qpUfy6y0dswLLuoPYGbHih1IplTbjjKc2Mzs+BbsEf+bzP3AyQ14Cb2trHV3no8Zj29fW8CYDLi1Nq+h+uxt8CMlS7GtfGobnqQPczLR1+fUHtCtMtCkPCx8PYGPjumc3fdA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB3786.namprd12.prod.outlook.com (2603:10b6:5:14a::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.29; Thu, 12 Nov 2020 01:01:15 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 01:01:15 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 3/5] drm/amdgpu/vcn: add test for dec vcn software ring
Date: Wed, 11 Nov 2020 20:00:40 -0500
Message-Id: <1605142840-2035-1-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605133674-21093-3-git-send-email-James.Zhu@amd.com>
References: <1605133674-21093-3-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::17) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTOPR0101CA0004.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend
 Transport; Thu, 12 Nov 2020 01:01:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2b3b108-a6cd-4622-b38b-08d886a674b8
X-MS-TrafficTypeDiagnostic: DM6PR12MB3786:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3786EBE322FA5351C4EAA415E4E70@DM6PR12MB3786.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yBptL+vOws/RlK0sRAgpi4xTa7xFKCy8ZXWslABFZcbYal6eqof9XNTEHBOEdoqdwIijlQGZzg215N9+qxgtDvQach55ul7Vp/KHNLg88AEwlsmyY5Rzv87HKKFW7U23/cslx8H+6yKKHPdqyJBTrwLHaII/FoMUAS4wfcPBVEg3imQPKSMqfiym6Fl/Q10HB44nJqthRn9iqGlaforiTyzR/KS4o/D7cL9mQ9iPHY+MSURBEGtujb+9QmJD5vx0BXKMVEJooOOnVmQOiPCR+FFw0P7pXOjrKYbCeSxFvAw4k5VAstxSuwmuWATlVlk8lD7u76ny0yfiNGt5Td7gUA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(376002)(346002)(136003)(396003)(478600001)(66476007)(8936002)(6666004)(956004)(5660300002)(7696005)(26005)(52116002)(2906002)(8676002)(66946007)(6916009)(83380400001)(86362001)(186003)(2616005)(66556008)(316002)(6486002)(16526019)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Pon+ZqWyKg3NNgl7jQzly/6mg9ERo3QRPw81s7Lv0Djml2tVUFThd4WbVIjoMNvDzNlUX4gqaQcUf7XtkMPQiU1kKhrso9kLpj7hYncmdhPRKT9VPBI3ZmIMUQoDMp3XuMMDREXPX3+ZxexQ3tMPqZnDKoCJRQoKIU9IrGtkQQxBis/EixZPo5JMWfDtZQDI8FuVP5Wo2lUBJ3xPAaXlIDrygVLmgLjzBFfqw7GMEe5VT2SxEKGTjLN2fptG7KdSDk5sBS6C1IGk7Rar9F36EUf4D7zTrbmIc7HTes+XVgzUdT4dZXqDH+7Lit1YtLon8KxDyoTIVK5GMAE29DQLXfi3q9I9Jvd53xLMhQcVq9Ixj7pRrz3HGsvv0I2NMhSYh2fV6jsrW3iariHHhG0VtT5a0i1bxeZe+KdWfcCv7keqaymrh1nsbbkEw2TZk66nEOlmihh/7DWNvOhpDoA3NJ7JfmVQ+HXYlEMCG2Yoqls3+W3wS2txZFEi/HOy5+9CxZrjVO8BDxa4FoNSXjM/HLz6cXVNl6fovrsU6NIoyMw3PtQiJ6oU4FILDywyt/lPAa9tIEMLXAvlVoptD5iTAAZzlHHkPSp1lrPIvvjaTAPhG7BrGqpD02wmB/gWy/alaletFCsrdPmk5GYAfr4Z6naPS+znpw11AnhhbaaRMxSfqDP9Ifcg3KRlZzG4tUT3iYNiunXF7Lcusjg/BkQD4+B8GeQQKGG8p7EXwbBGJxJjq3DepONw64/8yQVcNqUOPj6YFp++JSotWeUdSXnSqDst2+77hXfQCvczU0gYS/G/XDt/msVw15fixkab8P+Y+3GVcFjpVIYNruMm7NV10OajCJnGVUQ2BYlUE0CZd6SlQ0WuHvsc9K2nB73+G045jVkuFTQGvbgyYF3fEEPKrw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2b3b108-a6cd-4622-b38b-08d886a674b8
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 01:01:15.5918 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1dDmYQ515PkERc9oJJ1U1zviUx743xKKDr84suXP7HMldg35DfGFfq2iJu1GD9dI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3786
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add vcn software ring decode ring test and decode ib test.

v2: clear compilation warning.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 135 ++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 7e19a66..cbd8b5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -456,6 +456,37 @@ int amdgpu_vcn_dec_ring_test_ring(struct amdgpu_ring *ring)
 	return r;
 }
 
+int amdgpu_vcn_dec_sw_ring_test_ring(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	uint32_t rptr;
+	unsigned int i;
+	int r;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	r = amdgpu_ring_alloc(ring, 16);
+	if (r)
+		return r;
+
+	rptr = amdgpu_ring_get_rptr(ring);
+
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
+	amdgpu_ring_commit(ring);
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		if (amdgpu_ring_get_rptr(ring) != rptr)
+			break;
+		udelay(1);
+	}
+
+	if (i >= adev->usec_timeout)
+		r = -ETIMEDOUT;
+
+	return r;
+}
+
 static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 				   struct amdgpu_bo *bo,
 				   struct dma_fence **fence)
@@ -510,7 +541,10 @@ static int amdgpu_vcn_dec_send_msg(struct amdgpu_ring *ring,
 }
 
 static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
-			      struct dma_fence **fence)
+				struct dma_fence **fence,
+				int (*send_msg)(struct amdgpu_ring *,
+				struct amdgpu_bo *,
+				struct dma_fence **))
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_bo *bo = NULL;
@@ -540,11 +574,14 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = 14; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	return send_msg(ring, bo, fence);
 }
 
 static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
-			       struct dma_fence **fence)
+				struct dma_fence **fence,
+				int (*send_msg)(struct amdgpu_ring *,
+				struct amdgpu_bo *,
+				struct dma_fence **))
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_bo *bo = NULL;
@@ -566,7 +603,7 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = 6; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	return send_msg(ring, bo, fence);
 }
 
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
@@ -574,11 +611,97 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	struct dma_fence *fence;
 	long r;
 
-	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL);
+	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL,
+				amdgpu_vcn_dec_send_msg);
+	if (r)
+		goto error;
+
+	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &fence,
+				amdgpu_vcn_dec_send_msg);
+	if (r)
+		goto error;
+
+	r = dma_fence_wait_timeout(fence, false, timeout);
+	if (r == 0)
+		r = -ETIMEDOUT;
+	else if (r > 0)
+		r = 0;
+
+	dma_fence_put(fence);
+error:
+	return r;
+}
+
+static int amdgpu_vcn_dec_sw_send_msg(struct amdgpu_ring *ring,
+				   struct amdgpu_bo *bo,
+				   struct dma_fence **fence)
+{
+	struct amdgpu_vcn_decode_buffer *decode_buffer = NULL;
+	const unsigned int ib_size_dw = 64;
+	struct amdgpu_device *adev = ring->adev;
+	struct dma_fence *f = NULL;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
+	uint64_t addr;
+	int i, r;
+
+	r = amdgpu_job_alloc_with_ib(adev, ib_size_dw * 4,
+				AMDGPU_IB_POOL_DIRECT, &job);
+	if (r)
+		goto err;
+
+	ib = &job->ibs[0];
+	addr = amdgpu_bo_gpu_offset(bo);
+	ib->length_dw = 0;
+
+	ib->ptr[ib->length_dw++] = sizeof(struct amdgpu_vcn_decode_buffer) + 8;
+	ib->ptr[ib->length_dw++] = cpu_to_le32(AMDGPU_VCN_IB_FLAG_DECODE_BUFFER);
+	decode_buffer = (struct amdgpu_vcn_decode_buffer *)&(ib->ptr[ib->length_dw]);
+	ib->length_dw += sizeof(struct amdgpu_vcn_decode_buffer) / 4;
+	memset(decode_buffer, 0, sizeof(struct amdgpu_vcn_decode_buffer));
+
+	decode_buffer->valid_buf_flag |= cpu_to_le32(AMDGPU_VCN_CMD_FLAG_MSG_BUFFER);
+	decode_buffer->msg_buffer_address_hi = cpu_to_le32(addr >> 32);
+	decode_buffer->msg_buffer_address_lo = cpu_to_le32(addr);
+
+	for (i = ib->length_dw; i < ib_size_dw; ++i)
+		ib->ptr[i] = 0x0;
+
+	r = amdgpu_job_submit_direct(job, ring, &f);
+	if (r)
+		goto err_free;
+
+	amdgpu_bo_fence(bo, f, false);
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
+
+	if (fence)
+		*fence = dma_fence_get(f);
+	dma_fence_put(f);
+
+	return 0;
+
+err_free:
+	amdgpu_job_free(job);
+
+err:
+	amdgpu_bo_unreserve(bo);
+	amdgpu_bo_unref(&bo);
+	return r;
+}
+
+int amdgpu_vcn_dec_sw_ring_test_ib(struct amdgpu_ring *ring, long timeout)
+{
+	struct dma_fence *fence = NULL;
+	long r;
+
+	r = amdgpu_vcn_dec_get_create_msg(ring, 1, NULL,
+				amdgpu_vcn_dec_sw_send_msg);
 	if (r)
 		goto error;
 
-	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &fence);
+	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &fence,
+				amdgpu_vcn_dec_sw_send_msg);
 	if (r)
 		goto error;
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
