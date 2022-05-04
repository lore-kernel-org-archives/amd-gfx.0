Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DC3C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 15:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B63D10E8ED;
	Wed,  4 May 2022 15:04:33 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 968C710E8ED
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 15:04:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QGtoPQeNEcgEJMrMl8kSFTZvfizG+KY7bShCwWWEU/iD2uvJ9b3ltNYTe/5T16t39wnlqK+qcCfmk0ZbT9/1gVEkJrHjRAxwhw2xXF8ugRirdUu244mqf1Uo2qcviYLVn1pgudyHn0O8ovatVWFSxRpo2Nqd3bown7CksAxQJ6af3H8rFgbPmAshsTnCI5d9YcOrqZGFi38LES3L9pVR+jxI6XeTDo1OLRN0QlLFXcVW8PZjKkJSMz/jjNpsLVPyw7HB5Lux7mR1rpQQ5i/ub1kjLsBIop5VrdqTRU8IUDP6UIJBKXKkWafvTDhPNOpjKt/0pXwALglSN4RYDYqidg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XpOxYp4j79Blw0T/oE5H+S4ORFfGsPWBvaMCh37kOiE=;
 b=Q1BCQHKe0X7vaFAt0QwXkEHPFZWModSRwWh2FtW1pShpkaeGS+ZiLfBf5433sDFSNszSxvotZs/3niFnr/Zc5l47QI9vSArmKPRky37D3WVVtwdQ6Vmh6bfQeo8koYcxkRohc+pYRULiFKk3XcjEQ59AK0RhZLWV5dSQDTPkbFpJC10DJlg1LfBQdQ36ekb0cMHu+wu/bu/X3Zi9UZUsGKfRZqECip1JZvU/vsM6D1+rO1WzNN+r65dZ4VvvQZ4gMWk9ptsrFR3TbHQ+FMiWhf7g8ysGe+4rvyrrrQtRRD9X0SBrwZl6mddBC2aOwYcoAR38s4mLEpXAtRthXwPGeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XpOxYp4j79Blw0T/oE5H+S4ORFfGsPWBvaMCh37kOiE=;
 b=NHco/E+Q2KYShYyIIMkxNCNzULZpczV5UOQP2sZkprW+lDONf4kuiCx+KHiN+4bPG4/LbtAqdV5qtSyIpo3JefBXSp66wnoccLXDFw6FUQ03czkwcu0tOzureNMKSybRuCJ8TWN59WufxI3TXfAetY/1VUkej1DnP9/A4ykF5h0=
Received: from DS7PR03CA0295.namprd03.prod.outlook.com (2603:10b6:5:3ad::30)
 by MWHPR1201MB0190.namprd12.prod.outlook.com (2603:10b6:301:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Wed, 4 May
 2022 15:04:29 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::9e) by DS7PR03CA0295.outlook.office365.com
 (2603:10b6:5:3ad::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Wed, 4 May 2022 15:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 15:04:28 +0000
Received: from jz-tester.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 10:04:27 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/3] drm/amdgpu/vcn3: replace ip based software ring decode
 with common vcn software ring decode
Date: Wed, 4 May 2022 11:04:14 -0400
Message-ID: <20220504150415.667764-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220504150415.667764-1-James.Zhu@amd.com>
References: <20220504150415.667764-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4138d70b-e46d-419a-aeec-08da2ddf62ed
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0190:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1201MB0190750A0978A67959254CFCE4C39@MWHPR1201MB0190.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jgwYym9AJlsqbLeGAW2oZjMPwu159Q7dCRLQV3HBcLs+VvnA6FgRVynWcFQudcbd+cuo/4ri5j1VamEIwZeng3jVDDKilvSnHUtTvs8wMu3o0cDyrSpB+MKeM1E6LGk9qxudkTIOf7NZYDqwn02gOKK4Z2Mw+537tfQg+Z5OzlZKmOlUMQ/xCdFXRA8JTTO6A0R2v7aVWzdVIZSRxmfrvNMsE++X4Hwui9dGd8OfzDP9/6NiuvL8SQt0sPC7ZDaE6KYcImDAuUrAWKn8KcD5NTaVFDuCZakeoeI3MxDGL7PwZT+wLPjY+mRGLA6pZcwciUjzIEAqTiizGBND1cnbL0yopgLwxWPERks1RL7Yxn0ODRFp9kfKdT3jruagdV7UroDr1vNwtNEv7WGioqfvFyNXyDWFnn71R56CM+cLZ3lsN+BgnBmiXaY9rVVwHkOMdHWaPbi4SrG7z0ZPg6Ek0sTGLDJyqlJ7QtKddVDwQ6bgsVfTezQeNlds6LZTooEQeDniK45GzhbVAEnJxcSzVZP/bkDUnH0kxgRTZTaCQTb8N0rxLQGBRz/AQ0vBJ1nmPok3p0cuh3bmCSY94wN1JfIeA8+2Cl5gMLjhhFugH19ipC2Htrn+V1IdohNeZREpc++IVe1FYMeWNtRn1yWb6mfhLT6+6R8qOD87jPvJk3Zpv/skYDEN6KdatdCMC5z/rGt9r8/9XzfxKdWtwxIQHw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(4326008)(70586007)(8676002)(70206006)(6916009)(316002)(82310400005)(86362001)(2906002)(5660300002)(8936002)(2616005)(26005)(1076003)(7696005)(426003)(336012)(186003)(508600001)(6666004)(81166007)(36756003)(356005)(36860700001)(16526019)(47076005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 15:04:28.6109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4138d70b-e46d-419a-aeec-08da2ddf62ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0190
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace ip based software ring decode with common vcn software ring decode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Christian Koenig <Christian.Koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 80 +++------------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h | 12 ----
 2 files changed, 9 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index c7280ca5e836..3cabceee5f57 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -30,6 +30,7 @@
 #include "soc15d.h"
 #include "vcn_v2_0.h"
 #include "mmsch_v3_0.h"
+#include "vcn_sw_ring.h"
 
 #include "vcn/vcn_3_0_0_offset.h"
 #include "vcn/vcn_3_0_0_sh_mask.h"
@@ -1731,67 +1732,6 @@ static void vcn_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
 	}
 }
 
-void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
-      u64 seq, uint32_t flags)
-{
-	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
-
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
-	amdgpu_ring_write(ring, addr);
-	amdgpu_ring_write(ring, upper_32_bits(addr));
-	amdgpu_ring_write(ring, seq);
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_TRAP);
-}
-
-void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
-{
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
-}
-
-void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
-        struct amdgpu_ib *ib, uint32_t flags)
-{
-	uint32_t vmid = AMDGPU_JOB_GET_VMID(job);
-
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_IB);
-	amdgpu_ring_write(ring, vmid);
-	amdgpu_ring_write(ring, lower_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, upper_32_bits(ib->gpu_addr));
-	amdgpu_ring_write(ring, ib->length_dw);
-}
-
-void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-        uint32_t val, uint32_t mask)
-{
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
-	amdgpu_ring_write(ring, reg << 2);
-	amdgpu_ring_write(ring, mask);
-	amdgpu_ring_write(ring, val);
-}
-
-void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
-        uint32_t vmid, uint64_t pd_addr)
-{
-	struct amdgpu_vmhub *hub = &ring->adev->vmhub[ring->funcs->vmhub];
-	uint32_t data0, data1, mask;
-
-	pd_addr = amdgpu_gmc_emit_flush_gpu_tlb(ring, vmid, pd_addr);
-
-	/* wait for register write */
-	data0 = hub->ctx0_ptb_addr_lo32 + vmid * hub->ctx_addr_distance;
-	data1 = lower_32_bits(pd_addr);
-	mask = 0xffffffff;
-	vcn_v3_0_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
-}
-
-void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
-      uint32_t val)
-{
-	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
-	amdgpu_ring_write(ring,	reg << 2);
-	amdgpu_ring_write(ring, val);
-}
-
 static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_DEC,
 	.align_mask = 0x3f,
@@ -1804,22 +1744,20 @@ static const struct amdgpu_ring_funcs vcn_v3_0_dec_sw_ring_vm_funcs = {
 	.emit_frame_size =
 		SOC15_FLUSH_GPU_TLB_NUM_WREG * 3 +
 		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 4 +
-		4 + /* vcn_v3_0_dec_sw_ring_emit_vm_flush */
-		5 + 5 + /* vcn_v3_0_dec_sw_ring_emit_fdec_swe x2 vm fdec_swe */
-		1, /* vcn_v3_0_dec_sw_ring_insert_end */
-	.emit_ib_size = 5, /* vcn_v3_0_dec_sw_ring_emit_ib */
-	.emit_ib = vcn_v3_0_dec_sw_ring_emit_ib,
-	.emit_fence = vcn_v3_0_dec_sw_ring_emit_fence,
-	.emit_vm_flush = vcn_v3_0_dec_sw_ring_emit_vm_flush,
+		VCN_SW_RING_EMIT_FRAME_SIZE,
+	.emit_ib_size = 5, /* vcn_dec_sw_ring_emit_ib */
+	.emit_ib = vcn_dec_sw_ring_emit_ib,
+	.emit_fence = vcn_dec_sw_ring_emit_fence,
+	.emit_vm_flush = vcn_dec_sw_ring_emit_vm_flush,
 	.test_ring = amdgpu_vcn_dec_sw_ring_test_ring,
 	.test_ib = NULL,//amdgpu_vcn_dec_sw_ring_test_ib,
 	.insert_nop = amdgpu_ring_insert_nop,
-	.insert_end = vcn_v3_0_dec_sw_ring_insert_end,
+	.insert_end = vcn_dec_sw_ring_insert_end,
 	.pad_ib = amdgpu_ring_generic_pad_ib,
 	.begin_use = amdgpu_vcn_ring_begin_use,
 	.end_use = amdgpu_vcn_ring_end_use,
-	.emit_wreg = vcn_v3_0_dec_sw_ring_emit_wreg,
-	.emit_reg_wait = vcn_v3_0_dec_sw_ring_emit_reg_wait,
+	.emit_wreg = vcn_dec_sw_ring_emit_wreg,
+	.emit_reg_wait = vcn_dec_sw_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
index 7a6655d3b79d..31683582d778 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.h
@@ -26,16 +26,4 @@
 
 extern const struct amdgpu_ip_block_version vcn_v3_0_ip_block;
 
-void vcn_v3_0_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
-      u64 seq, uint32_t flags);
-void vcn_v3_0_dec_sw_ring_insert_end(struct amdgpu_ring *ring);
-void vcn_v3_0_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
-      struct amdgpu_ib *ib, uint32_t flags);
-void vcn_v3_0_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
-      uint32_t val, uint32_t mask);
-void vcn_v3_0_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
-      uint32_t vmid, uint64_t pd_addr);
-void vcn_v3_0_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
-      uint32_t val);
-
 #endif /* __VCN_V3_0_H__ */
-- 
2.25.1

