Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1E7C63777
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EC692463B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="U43UkleI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EC692463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E12086E452;
	Wed, 18 Nov 2020 16:24:14 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F3F76E450
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 16:24:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T8FwV2A/+9oOo6xejFnQ8g+xyNTeVpHOJ+1cYmdvjrbD+sIDWGjVdRo/YFZFSUXy0ZFZ3wbomnA/24DOGYzTgksh+M9f9A8XfvfF2L5hozZDhVnX1mDL1n4GBWPsNwJy7dars40ra+g9D1NYmIKAiJCibmoxewSQmKB7i1pljoMkW3+sp3yvvgyy2MqugG82qu9n/cTBXzeKa1jgl7O74uLOJ5nfv5Fy8IHLP4tln+4mjDazqUDpJs2li5fuKJiEXKqlqs7Q9ZIXUCeUb5onHI9098sRR4k9PSIUF5Bd/h3PzfobntXVtUw5QP1gBcQHacaI6QPstcqt80pzEogT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFCo2HtTNvvIX6xI82+TOJgJ3Gve13ST5H4xgLN58LI=;
 b=HtonbtO+a09ut8EHSxc6Xo5hYxTx+sMM0rTjZwaphKW+W8p4fj+iBw9SEYIQEfbHfMV3Gx12FynjpqYIOEfwWf5jehJbcJCfIWkzZrxnAkxQTGEeZG0TrxW/idLa38u9tIPLgDW4jrUfnWdORwV/EKVWV/1xdG9CWefmFe2nlMkzf0CxnpsE78W46YnaYzCVT2rsy1paizCmBKLdADR/k+7u9nn1sCIAiX4EH7/r8XgeJd2GTYe5HE+SqcftEp8igF9PQ4B202qDreIwhCY+koSGtCrEAXKv4qNkBNZnlOEkF6mUXsAhF4VZq1FGDh/NI0afmmFndn4hPnML0IUcLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EFCo2HtTNvvIX6xI82+TOJgJ3Gve13ST5H4xgLN58LI=;
 b=U43UkleIxzy1cyrQKNytxOdOu+NVr5JWo3ch2pi+og173zmSO11ytBsfnFNDDyUqTwlOascTFY9r77z0J1ix3SJ9mThBuiFZb/boAJ9i0nwSDif7Ekz9aJMLXNGlap2vLOJ0qSG8Tol3Zi99WWj3iKh7v8VzMwdcts38TnZ5Jzg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB4314.namprd12.prod.outlook.com (2603:10b6:5:211::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 18 Nov 2020 16:24:11 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3564.026; Wed, 18 Nov 2020
 16:24:11 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 3/5] drm/amdgpu/vcn: add test for dec vcn software ring
Date: Wed, 18 Nov 2020 11:23:59 -0500
Message-Id: <1605716641-22176-4-git-send-email-James.Zhu@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
References: <1605716641-22176-1-git-send-email-James.Zhu@amd.com>
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: CH2PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:610:4c::38) To DM5PR12MB2517.namprd12.prod.outlook.com
 (2603:10b6:4:bb::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from work_495456.amd.com (165.204.55.251) by
 CH2PR10CA0028.namprd10.prod.outlook.com (2603:10b6:610:4c::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 16:24:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 907025bd-f7c2-4b10-2bef-08d88bde6175
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB431494EC6611CDD4949972E5E4E10@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eh4khPsv4lvPSt7DMz6K4xAU2b4hiSv8vquEWfN06P/PEiEQq0I+44QPk/VvHwxyju2fdwqypGPBITqFdaCfluKn7TmwKGNvP7MjPCQG0fcksRH9lp/xCfpkWR9j/ZSs5i498vHOe2PDMnErQpCJf+4tNUXorpV2y3eBa6dedAWDNw5rvy8Y5dA5ba55rlLZhEGPhoklF4Xzx0zqEpOX5oQd5eoW/zkg+M2OvdIlLLbUoKsk0ajaTwsZDrGgA0qfO07MgVUM2JoEVOzJlAdcDUArDGHYqZD0aMFNXf9M3wgK0RaCNgyH6RsVVaZVFHAOg33+9RWIyCNBCNx9GvKQLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(6666004)(478600001)(36756003)(6486002)(26005)(16526019)(52116002)(86362001)(186003)(316002)(7696005)(2906002)(2616005)(4326008)(956004)(8676002)(66476007)(66946007)(66556008)(8936002)(5660300002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: ArXJsiINkxz/wjVO2jXu0dyBCf1CiU8XG+b1deRLzmKewB2R/B8QPNjK5t74M0QgrwwMY5GFl6pLTzHCuF/wqi0f9uitwJfpBswSJB2HiJU9kBSoijEHeKVJGIkM8MNW/wI0zTDc6b8wlcWF7vbRhU2nelRF+0Z0jYCc5Rm9gfGP9kBwyFx1WVL84k1jYpROOG9x89B399+K6Xkz4vKQpYk/RtMPU6lDqUeZhjzr76SjhvAg+K/9uLnaZq/DjHgm3kduRx9GzK4d/jyfKwyENQWddwwBPMhU8oM9JOOHgbu4Z9luEsW3Z7LfWJjPzdCcX+8Po3rjxIEg3C9RI1gbD05InWDH8krM9CST7wbayiU58NiXp15DkTuL/0s/iKYXB9Ud1DZiVEvIGLUGkhoZGGmZHhiSQ8vl5MaZnWpc/iHEdmu38WCRmRJYTsjoC4Gc+AkV7TsFKzOprwL/PVcuh5kBjWHTgqM0jyD2MQjJsR0LzLcb1mODiZ0GuuuEboDr0qlr0kGm0qMDLoqs4u6ZqHsyWBHbt0fSu9vd2d8sEFCEXqi+OOnQKqWBydMtSZebiz7flXMnork1oLPpHn+Lwr3VyUU3w1vp7HNGQePRGFBjbkMx6ubdT6MUMJEePXoK9AUXxxl+qbVnv6pHnmnnOiNxoL0W42Rv7Vk9vtvh6kjDDzagnbeYcpEBkyuY/NsTtMm+k6tRyALLi4ZNYm+LWV8TBEc1gfev5XQha7HHX2uZv/KCzqiO2ukZj7nSfHkIncLq0B9Vf0lQD97VE6BSSHrZXU7HJwYIApE6YTsrJ4JfvKc/TOq+7Cj6Bvgqq8C/qNjnwXwEidYMZ05+4/+qT1s/FVNT36MbYPf+FzAUoLSdSakVWIEOKH/JMIRcUoITAN4Ueka9KK5uI85FY6M1IQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907025bd-f7c2-4b10-2bef-08d88bde6175
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 16:24:10.9213 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SwhbPt2gNiVDw3hrpTyCDiIbTlHCCgNjn2SMraO7qk4WGKCibm/O1zOaWQKLyyTk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4314
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
Cc: jamesz@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add vcn software ring decode ring test and decode ib test.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 121 ++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 32251db..1c97244 100644
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
@@ -601,6 +632,96 @@ int amdgpu_vcn_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	return r;
 }
 
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
+	struct amdgpu_bo *bo;
+	long r;
+
+	r = amdgpu_vcn_dec_get_create_msg(ring, 1, &bo);
+	if (r)
+		goto error;
+
+	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, NULL);
+	if (r)
+		goto error;
+	r = amdgpu_vcn_dec_get_destroy_msg(ring, 1, &bo);
+	if (r)
+		goto error;
+
+	r = amdgpu_vcn_dec_sw_send_msg(ring, bo, &fence);
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
 int amdgpu_vcn_enc_ring_test_ring(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
