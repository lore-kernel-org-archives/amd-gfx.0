Return-Path: <SRS0=tzQw=ER=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DD0C388F9
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C104208FE
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2020 22:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GFU1+fJH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C104208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62ED26E0C4;
	Wed, 11 Nov 2020 22:28:06 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A43116E0C2
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2020 22:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FVFtJrgkUFFuD/zqJxnQGBLTTv1qizdP3Pg4xhsgBHtn7F+lMQuRtvkX7J4iRiUXoCWXdt67IvneiYWRsjX5CG4asK6IdFyUz9ohFgzWOTaVPi9953YKl+UevUs3U2kPn3AQBdmZ7I31pMUdJ1aq8L/N9E5dYdDm89Oh8D9gMF3h+ynX9fNxPL29GktliE6hYmXuKV27hHwEZJO0zA2vECmEf3OEiftFVIwpITwn26cMrmc08ApjktIlVwL+VS1WAKQDACSkY9LpB4h3kgqoeCTmfDDDR7F2fJpzw3d40ZoM+XhTZoscA6h2Nx4QCiw8wIYb2Zztp/3gXS92OB9FEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJEGkuVOtTPM7B2YRUrh53vHoTrR7HScYciWIthoAVI=;
 b=Own7H6t/pjXVa4S7swJd8t6fqSLHlB9rs3Pa81ypLVaNWcn6+YxRAxf3F4QljfbK1Y6GnGcCxVrRuzitbHqFzjOU+D0NncV7QierYcx3cl0cEj2SHcphu6cCWZgvQdkdbWIJnxMbPJrONOikcKvk8xnbbGDviyGuAyelFqJxE54e0ClRBMCKKbolCsOXyCAujGP2rQGf9URg2UbUfsbemeFpKNZP30kqQcwGOYXzlcj+K2raCXa8b3M5uwNGMbveokorNRUiDE56t5Gv+h1n/RnczXctfI+tp1cmoccE3YhCE52rBhG1lukBbcXvGFpQPpfHk2Pua3hfCt6JyRgP2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJEGkuVOtTPM7B2YRUrh53vHoTrR7HScYciWIthoAVI=;
 b=GFU1+fJHXy6ljsqhGZXuhOgN0LK0ijzg+F8JtwH2x0jSeM9cT9JNfXOuqjxzmGdvDRkcjfP7ACBHITu4ypnGMKV5h1oeR20qE0znL8bq3FZgsyf1fNGRJ7z5VH7rXb/dfUvQ+8Y5zbUTxX4vzTT6pPuYnvjldwE+IZmR2Kexhnw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR12MB2517.namprd12.prod.outlook.com (2603:10b6:4:bb::13) by
 DM6PR12MB2746.namprd12.prod.outlook.com (2603:10b6:5:41::24) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.21; Wed, 11 Nov 2020 22:28:03 +0000
Received: from DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a]) by DM5PR12MB2517.namprd12.prod.outlook.com
 ([fe80::1059:3b25:8f54:5e5a%7]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 22:28:03 +0000
From: James Zhu <James.Zhu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/5] drm/amdgpu/vcn3.0: add dec software ring vm functions to
 support
Date: Wed, 11 Nov 2020 17:27:53 -0500
Message-Id: <1605133674-21093-4-git-send-email-James.Zhu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: ac403d0a-3993-40d9-7336-08d886910da4
X-MS-TrafficTypeDiagnostic: DM6PR12MB2746:
X-Microsoft-Antispam-PRVS: <DM6PR12MB2746A8BAC9B3D2680CAE5676E4E80@DM6PR12MB2746.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r7f9+tZYmTD53ogVjW0IVo9hy+bxpXGhwU8cWaPP8MTESkKVOm7kfXTDAhpe/EdwMf+ah6b5VukQjDpOPj/s2BETAr1MPVSLD+nkhjKhE8NoszoIgukASWNj/SZfHW/m/DKE3wdXR3Y4wmoYO8cbHKHtvuEzDbsngtzN9Cpp9pH5Fz9DZW46m0mhNkVjrzDElbVMV5eyn4gisXRMLXtJtIs4p+ZBw5CSJYG8G0Mu2qTpSxf9FPL0VY2pfQBXiKTuQVNWprW5NPlXaZJ2xZY1xVKMKFuf6ukBC7tFo2BZHXiA4ZGe+Lqn7ttmL4qusd3PlJ9uOi7rRkOrV6j/tZ04U30XlxE21J+CgaaIc3Pc0BuiB9XWbqCWHwWJUlPMdz49
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(66476007)(66946007)(8676002)(6666004)(8936002)(2906002)(316002)(83380400001)(52116002)(478600001)(86362001)(6486002)(26005)(7696005)(66556008)(2616005)(186003)(956004)(6916009)(16526019)(36756003)(5660300002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 5FYk6DInP0ThjVymtkMwzY1oOOh8Tsn5YvTYhvPrEYgo8QB8JRLvRy6gtYyhzPIVGAV5eB7fdArfDAewf6f5lfD7adhPBqLfgZyr1En3xGmOvpkxCAabciA0Lre9bTx96oTjmNLoymSRrE/3j5ROYIsWOjeUYjt1QC9YxIVPVTKzF6fkwRQAlFYi4e/s3lpDNLtTrciTshlPM6MspNyHDuuCDVOo2MP2B6u51YH9dAz85eD07aX5AKhPCU/R7aEZgKRNvO6C3DSNlLYcZYeMI8ytG4mVjjq7FTgAisYPJDsNgOh7abhhgmQWBLiNBdpxlgLIArqYXtsIUL+WH9JkLwt8NZKdIFGJF5lbFLiwjkcMFrbmkRPKRZWq0TWd2GGeks9PpUNiNanhwaR0d3bh49KW9KNW+mdJyvYWczIeO1aHOyjuwg3+ziY7JrsRvM1QITxt7UOvT39nLBLJ/NHmmtP999JJub7fmYVMBPVKdYA4IqNMNKeSXnszwmTrIpS5Jvl1Xy9w5duJDX3MBzONrlU2xIfzfpu1gtdchG7vh6AiH47kUchxpSWU0viJNmizMWSOUqvo393rOx/c+7Sm1mKYpYro0zG8Yumip0Vsz6hgVDO7oSLAe+l5Jk1cZ5rOx/8YeC07yd12DkC/aFx8kW0IYs2P0TE5odubuQD1Q+z4ejAGq0mApS0RgDVw78z6LCwmf5E8JsGMRudCDHyVH9mWVIaweNUD7XtFsQ9I/0YJfemPsa5gbDG+JmW/5qWQ4SGCEPTkfOQMoRpyZ9yHsrQkWDDsAEje+Zd12/Pp9Jx00uzLH0xxHEYHBIsEt/HFSqI3PAeehEf4mpGsmz94K/PW3H/xG2akySbSv+ttjwMy8uVLwwjsepcXZAi8IQrFKMbvYH8ppiFJoPk071SXCQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac403d0a-3993-40d9-7336-08d886910da4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2020 22:28:03.1915 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mn9EdVddI5m12UUwk5q+gMfc4dv2VsLeOU5Vd4F7rj8+RlmibMgnJOkHnTzg5oX/
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

Add dec software ring vm functions to support.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 100 +++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c5e0a53..9d3c902 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1673,6 +1673,98 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
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
@@ -1810,9 +1902,13 @@ static void vcn_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
+		if (!amdgpu_dec_sw_ring_enabled)
+			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_ring_vm_funcs;
+		else
+			adev->vcn.inst[i].ring_dec.funcs = &vcn_v3_0_dec_sw_ring_vm_funcs;
 		adev->vcn.inst[i].ring_dec.me = i;
-		DRM_INFO("VCN(%d) decode is enabled in VM mode\n", i);
+		DRM_INFO("VCN(%d) decode%s is enabled in VM mode\n", i,
+			  !!amdgpu_dec_sw_ring_enabled?"(Software Ring)":"");
 	}
 }
 
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
