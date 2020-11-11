Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB33FC5517A
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DDEE208FE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VMzBjfyD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DDEE208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE85B6E0AF;
	Wed, 11 Nov 2020 22:28:04 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B37B46E0AF
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 22:28:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJMFXvcCiC1tarLLmTcyUznqBJLPhJ6+SoZwmVqtRXfq8+AMiVhqmFqqDbjwcl4dUBzqZNvex2uXLHylm471ySLtSZ+Uks1GQ1gllJZHBqCNPY3cxb/MZeVAtNZ5YjPMB6eVpxgkPlWfNILav7BVugtEMN587zsV87gMuRDI7IUu9BCPooQqgUru1q8UI/Kj9VPx4X7EPK9qQ4i5d4I4X055dV/wBIpGscuAS/NMDgdowPZM5IiEwhlIwn/0uUB1QX+jPOP5sqqjomGFg+AqFU6DdLKu1hR6utLD9vbECvHsdf9cfP6Kj3ksGn4HIz2XOJUS//wIE7oKHtEAH3Pdcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr8Ni7OXR21kTRgmEGALTu2xH522TBf0+HRFD5pItiA=;
 b=HiUlJQb+RQ4ZLB1R9qcPHGOglBp3jml04Gf+u5LBBK6+xtfvkkB868/ktObLkZT6GPzFApYg/urbAP33Ds6BKekIyQEi3+zRO23q7fhqWMefITR/u7HV/LoyuSokm29iOIu/1F3N+Or4bhYp/DUp23WqeU+a/GDeR9DxVRXPZK5d27L1LT+z5Ei94kJ9Zt5n72JjzRDodLkmREPIoCQkt/TxK/R7NNYeZtVe0t6kHJDHfxOfhc2kQ0QFyvXlWbe3HXl6X6w6o5ZYywbG8OmCJmFFwS1PMawWqkGmkwfq1HkN8U3ZU/s7c0PY9GKFXOUiulLJtUoU3F/ytHbdIHSD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vr8Ni7OXR21kTRgmEGALTu2xH522TBf0+HRFD5pItiA=;
 b=VMzBjfyDVRE5p6TkJaNuXB8l3x2nLGOJsZYvGCL6+tNhymIKWsmjIRVqWyUX3VBiDrx75wgFBqrQ5dmuIbFUTfuzXfecD23gZFaRb6zJPfDbezzDm+5u0aXK8li6zrALjUCUJuT+bNDQnzy/3+42b7s32yergD5stX0YHT2+DTk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 11 Nov 2020 22:28:02 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 22:28:02 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/5] drm/amdgpu/vcn: add test for dec vcn software ring
Date: Wed, 11 Nov 2020 17:27:52 -0500
Message-Id: <1605133674-21093-3-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
References: <1605133674-21093-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::17) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 YTXPR0101CA0040.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3541.21 via Frontend
 Transport; Wed, 11 Nov 2020 22:28:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b6592f3-b589-49ed-2bd9-08d886910d4a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2746DF0940C699024E002874E4E80@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DWLxhqJbjzvPb/CXOpY9rbw9sRfTsePVk6wEM3vx6Tat3lZuDYhPVRrtcaxshOfgYvOIOobnrgQEhMabwFGoTl44+7cu+v2QM67GA/6mytR5I3zsGuLGCSARG5ZobXWyfuaMZI5S0WFx2tA3HJeGcW8G9igPouVjatpGdDOj8QoesjzwZb7wdmsXsp+8vxuJkn5RYoWTzNaSnsQi6B9pthBA8ZpCESSjKrQZx2ssMhUJhzgdNH9ccGMSXXoAQGrZjb8EdaYT/dnaJrOd2FSlwAXHUq+RnBjNw7ToHpGD5U0C+J47Scs7NxTM3rn58Lv5L5ks4BIcKipUeXzna65pg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(66476007)(66946007)(8676002)(6666004)(8936002)(2906002)(316002)(83380400001)(52116002)(478600001)(86362001)(6486002)(26005)(7696005)(66556008)(2616005)(186003)(956004)(6916009)(16526019)(36756003)(5660300002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: EUNqDq1RCO9VOBJNDx2rJxspt2YBfZ4R4NGSeB/mSMkfitD5uWCsyxdLqB91XtA3PdnkYVfwj2eHrtD1eI+hKogUDEvN7z6xU6MLtEUYkdWHD0oBMTv+GaDszN3Gq/nlU9dF9059i1sZhroA3fQyHYGnz8Yr8gx4ckx9HO5c7soXWLq40X5rq4fJ4hRJNirtZDN3K/rPOTT5kVyThtt6OXwiUoHOBVR5QZO7POVjt8g5yPCrqKT8DutImu7r59uD11EI4zvlg2VybzsmkdyuCWwiXWtE6YZNcfoSke/W7bpVIZn5UjlnDpQRb3jPBcJouerBuY6QceTPRgxZYfd7i7RP+PcONVqdJc4G9bdN/j1cLwQ2WGBnm0K7iSbutTSHvN1pKxVGcJMWspRXTMvh9lPiApF9xqz95wdBWJFQC0d2I4ekEZYW83L35JXCrNW68pdqGQ61DPd6RuLpTOasQPUU9vBHo6nR/gMSzdkzgz0pgwFrA50POSYIo+nKwUhHOz6Qo3hDMxRBBbrMsGdz1IRg/Db+uV6GE1sl2nbRCm4+no6Sjhehq6rPz8ZCsYB9//oy84jthkelzh7980KX6HlfbJPo9QZZueUWJec5uRKieai5C6rkxiodI+MoL470fpw/LPhuBQN4MCsmwmO2/xZvfwzMTXcESNFyyRe2ehNTtHpe5dQYHmyYmPGAuHMWXd2o/gBu+kJutfK0m7IOSoiQKXcM8JNlBDG7+uE1QS1P4wsgdhZR8cfQsxnE7KC5Rb0rG4J7ItKv0j5KwwH9qL6nq6fiZllnQJWD0nkIj4M2X9und7Dksn+FEbJrWUXbxC+veWsBs68+OBfuRVSlFvabl46xfySJ16ZzJtMZpQmbqeyKfYCvwjN9gvYRIFJBGLCkteUyjz14zgXRhrsDFg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b6592f3-b589-49ed-2bd9-08d886910d4a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 22:28:02.6188 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44f2Qh+XCiCSo6RUGpgybuAbRcRO+Q4sbivcdZDNmjCFJZ7bwDzrybmBnq4/xp7F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2746
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

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 138 ++++++++++++++++++++++++++++++--
 1 file changed, 132 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 7e19a66..e3d54fa 100644
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
+			      struct dma_fence **fence,
+			      int (*send_msg)(struct amdgpu_ring *,
+	                              struct amdgpu_bo *,
+	                              struct dma_fence **))
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_bo *bo = NULL;
@@ -540,13 +574,17 @@ static int amdgpu_vcn_dec_get_create_msg(struct amdgpu_ring *ring, uint32_t hand
 	for (i = 14; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	return send_msg(ring, bo, fence);
 }
 
 static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
-			       struct dma_fence **fence)
+			      struct dma_fence **fence,
+			      int (*send_msg)(struct amdgpu_ring *,
+	                              struct amdgpu_bo *,
+	                              struct dma_fence **))
 {
 	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_send_msg *dec;
 	struct amdgpu_bo *bo = NULL;
 	uint32_t *msg;
 	int r, i;
@@ -566,19 +604,107 @@ static int amdgpu_vcn_dec_get_destroy_msg(struct amdgpu_ring *ring, uint32_t han
 	for (i = 6; i < 1024; ++i)
 		msg[i] = cpu_to_le32(0x0);
 
-	return amdgpu_vcn_dec_send_msg(ring, bo, fence);
+	return send_msg(ring, bo, fence);
 }
 
 int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 {
+	struct amdgpu_device *adev = ring->adev;
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
+	struct amdgpu_device *adev = ring->adev;
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
