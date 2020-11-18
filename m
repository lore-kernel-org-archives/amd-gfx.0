Return-Path: <SRS0=Rejl=EY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2674C5519F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 461472463B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2020 16:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XvEsoPkx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 461472463B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE666E450;
	Wed, 18 Nov 2020 16:24:13 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A5E16E44D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2020 16:24:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cWX3fXimI5+Lu3jOnJo5V8Jhmb2IRAICp4piCAfMkG5/OwU9qH4lkqTUGBHo8p4p/Rhdyn28VzMU5ghUO70vjP4H79LW0AaWsBHqcsjN0dBfqe+euTZ4ZkbkXJpXeImvK/ncIq03uDlQYWUST/DwRAZ8tOnqC4NXRxbrCCZPCvCZJht7ibTHwNpsX6acaMtEBTu6seFt8XyzEMh0OVVa5pYDW8nwOivbX/xuaQPYcNcUmmH9j+Uxn9nnEUTFZQSTXQItkhjxEpGb0ajeMtY7ANLKYEC6SkHxbwPEGxgMa6Wf/1iGFqWDdTupOEQ/jJF0WRBdDX6AIxfAvtbQoXhnpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISJRqPJnrWlFfPkxhzaG5BaQP6+0Dt3Cx0bi40MJ+4w=;
 b=c4diCpcExFwfqRpDAG5TL8bncbT5+6F4o8grxx5BfbXXfO8no6xSIJ9XjWo+IXYK6I3zK3JjKkc4YbQkEO2pK3hbTikRLJas6Z7m9UYQ5rTkueomZhdmQVHd/+tGEgYrejQQB9NG5aR5KAvNevgpbAOr8NQ9D52hsiBq/1h7Nwf3klgK9SjVX+NqAUsnkM4Bmo9e6czi/KIi6dqWrRmoyeBoU0iOnUf2WqMo225oO81ZrOM0bXF/vZQTKjhdXNY7JCcCQI3kN+PCiXTpmhRg0xg63OTBFLxkozQSjf2ZGD/aed0GgE1AMPaoRTC35e5AQH3zW6ulR5boCZe4d9wpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISJRqPJnrWlFfPkxhzaG5BaQP6+0Dt3Cx0bi40MJ+4w=;
 b=XvEsoPkxGkVXuYJZ+GADWqYZOjW7/O32zMFx7xmZ7df0LEpZiVCMZnnNE+vQrX1X5t6bxsKWG+06E771kOGjPTbhhBm3l4GUfhoFSSB1IubVOTLH0NANBgyijP07gaBgCE1Xi5KGUBoYt2SXrcvSY5+fWUtrSaIjyl10jRHlh9Y=
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
Subject: [PATCH v3 4/5] drm/amdgpu/vcn3.0: add dec software ring vm functions
 to support
Date: Wed, 18 Nov 2020 11:24:00 -0500
Message-Id: <1605716641-22176-5-git-send-email-James.Zhu@amd.com>
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
 15.20.3589.20 via Frontend Transport; Wed, 18 Nov 2020 16:24:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 45a5d2e4-d7cf-46cb-916d-08d88bde61d3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4314:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB43148FC0AC5127F288D6C43BE4E10@DM6PR12MB4314.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rxtFLjrPp/JAMjVhd1ZPdnafxM+7lMI0A6F3GM1eymcuOBCV2bmKSpSVcy/80ogXN7jr4OycOLH5a/djb5wCM9sjAD1SemecaLc5ToYYEzjMbQyKvds/Hu7rnZfEsB+pVUMmysT1s6PAQ6VrUYh1PAy8LuFpVN/rIazP6YwAYI61KiY50ja+j093UCtyUlbqOrXrPHNl/K2oKKPEMrAWipyYAlv/WeNwCt951mU/Wq5z5XKveXMzLewQVrgTZwIJtJgJ/UNz2EvXrs4p/w3b42pdeaWX0aEvvk76Tl57OdBKCTOBeWwkV+n5fz/W1yb3snHTwmqBCBYR+SryrJKd5Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(6666004)(478600001)(36756003)(6486002)(26005)(16526019)(52116002)(83380400001)(86362001)(186003)(316002)(7696005)(2906002)(2616005)(4326008)(956004)(8676002)(66476007)(66946007)(66556008)(8936002)(5660300002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: xzKu+qruztYLa2hmKcV5nQNloPsGtYp2fu6h7ifk8oouQ5D/VtaKb51PtDbXGephDWj7U3TrshCafxtOQNz/+wNvdxjHWvix2Hsf2z5uBXcZxYIwHyjcmoXjB/UoIm5gI2Yzpps3LCE4W1CQkGuion3yzKDZZrubrUVa6QHnnxy51DoGwq03KBoy3XE2unIOYF36FMHJFV4Ei0nE7Vwds9ylOlAIJO4Je29WvgzTDPgis17oeyvK5oP9DgfMiUfjrPdZDNpip21NYu77J6WX6qlYkDAOaPBaQK+y0w1q3KrCSZYI+SxHsoT8YYVDmFCg+p1gsO4tQARPIGnMlEqB8Ru/xiV7Cnu42fqQiUI18Y6f7rJPyvmYyws8jBaDcsW325lIqAt2XxursIWVcJZkSmdJRD0a67ONh5z6uyMz9JD4cry/hKzdfD0xXXfbxqyoGQ9cNrxsPsxCGH5GwN1oym7tgl3F3GzVt6hVuOFgU78EN5wRt5Bfcu7RG2nUIjw7vMugP48mMNkivXoOFtyfSdds6wPOKgNO573lKAOO+0TqKHV7bkrn3EDIsn7YXt27GOYadqlIwKZ6jDOr9BZoTDR9mRCzS4aTrdwO9k80V0rFw05gPCp+oaZWvCq3XIqPsxWPe3oB2c4e+2vVSJz0onTwWnzdY2cIDTuSt70naF7K7QpReZz39XmZKznVUHyA3NgLRui3Cu7bhbN8aslIh+5CtRNvEZqO7JW5JCeYE30YH1D2wJGr09OV3PjhfVCl3TsIhg46mlCc89mXMEIHE+Q//ROYar4qV/CoywVOloLhfsm+6rQYKHWWiKabDMJ4NxnFwvmdJ7lVcowDHVj5DwC5OQhFRvKWqlzsfb7YrILDG+4hJbZ+z6lQr2TrccEo1mY9xpiZmDK202KMWYZxuQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a5d2e4-d7cf-46cb-916d-08d88bde61d3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 16:24:11.5219 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Env7PyBsdUV5pXF9vrqdK7iaUDwHKckO/gMISAIWU01Rk0XMWF7sMZRsFuzl3V7
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

Add dec software ring vm functions to support.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 101 +++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c5e0a53..a94dce4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -48,6 +48,7 @@
 #define mmUVD_RBC_IB_SIZE_INTERNAL_OFFSET			0x25c
 
 #define VCN_INSTANCES_SIENNA_CICHLID				2
+#define DEC_SW_RING_ENABLED					FALSE
 
 static int amdgpu_ih_clientid_vcns[] = {
 	SOC15_IH_CLIENTID_VCN,
@@ -1673,6 +1674,98 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
+void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+				u64 seq, uint32_t flags)
+{
+	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
+
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
+	amdgpu_ring_write(ring, addr);
+	amdgpu_ring_write(ring, upper_32_bits(addr));
+	amdgpu_ring_write(ring, seq);
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
+}
+
+void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
+}
+
+void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring,
+			       struct amdgpu_job *job,
+			       struct amdgpu_ib *ib,
+			       uint32_t flags)
+{
+	uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
+
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_IB);
+	amdgpu_ring_write(ring, vmid);
+	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
+	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
+	amdgpu_ring_write(ring, ib->length_dw);
+}
+
+void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+				uint32_t val, uint32_t mask)
+{
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
+	amdgpu_ring_write(ring, reg << 2);
+	amdgpu_ring_write(ring, mask);
+	amdgpu_ring_write(ring, val);
+}
+
+void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
+				uint32_t vmid, uint64_t pd_addr)
+{
+	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
+	uint32_t data0, data1, mask;
+
+	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
+
+	/* wait for register write */
+	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
+	data1 = lower_32_bits(pd_addr);
+	mask = 0xffffffff;
+	vcn_v3_0_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
+}
+
+void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg, uint32_t val)
+{
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
+	amdgpu_ring_write(ring,	reg << 2);
+	amdgpu_ring_write(ring, val);
+}
+
+static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_DEC,
+	.align_mask = 0x3f,
+	.nop = VCN_DEC_SW_CMD_NO_OP,
+	.vmhub = AMDGPU_MMHUB_0,
+	.get_rptr = vcn_v3_0_dec_ring_get_rptr,
+	.get_wptr = vcn_v3_0_dec_ring_get_wptr,
+	.set_wptr = vcn_v3_0_dec_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
+		4 + /* vcn_v3_0_dec_sw_ring_emit_vm_flush */
+		5 + 5 + /* vcn_v3_0_dec_sw_ring_emit_fdec_swe x2 vm fdec_swe */
+		1, /* vcn_v3_0_dec_sw_ring_insert_end */
+	.emit_ib_size = 5, /* vcn_v3_0_dec_sw_ring_emit_ib */
+	.emit_ib = vcn_v3_0_dec_sw_ring_emit_ib,
+	.emit_fence = vcn_v3_0_dec_sw_ring_emit_fence,
+	.emit_vm_flush = vcn_v3_0_dec_sw_ring_emit_vm_flush,
+	.test_ring = amdgpu_vcn_dec_sw_ring_test_ring,
+	.test_ib = NULL,//amdgpu_vcn_dec_sw_ring_test_ib,
+	.insert_nop = amdgpu_ring_insert_nop,
+	.insert_end = vcn_v3_0_dec_sw_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_vcn_ring_begin_use,
+	.end_use = amdgpu_vcn_ring_end_use,
+	.emit_wreg = vcn_v3_0_dec_sw_ring_emit_wreg,
+	.emit_reg_wait = vcn_v3_0_dec_sw_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
 static const struct amdgpu_ring_funcs vcn_v3_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0xf,
@@ -1810,9 +1903,13 @@ static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
+		if (!DEC_SW_RING_ENABLED)
+			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
+		else
+			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
 		adev->vcn.inst[i].ring_dec.me = i;
-		DRM_INFO("VCN(%d) decode is enabled in VM mode\n", i);
+		DRM_INFO("VCN(%d) decode%s is enabled in VM mode\n", i,
+			  DEC_SW_RING_ENABLED?"(Software Ring)":"");
 	}
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
