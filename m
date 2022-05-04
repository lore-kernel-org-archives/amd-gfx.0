Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 882C3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 13:23:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12F810EA71;
	Wed,  4 May 2022 13:23:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2075.outbound.protection.outlook.com [40.107.96.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98C3F10EA0C
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 13:23:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWIhHLuFesQKpRmAREAg912mbcZxBcDrno+TTvXUZpisscrwygqi0vKAJJYcocUoALVzmfZPoxGEc7On4suK6SyE5+EiPGZmWl4yVjIDyFM/YT/SCMp8yPnDwHBj2PnLfHXnCxfCaJLvRMibqdNAKo8SKsQcQ60bJ+CtKbpT+S1H/Jipfzo77wxzdCbCe4tQJW1MhUhxByHTqYm0ftdlnDWRFhfFdmxBlqeDLFbYvcjhcS48DOOAd7WOWBtNMS81VeBMpWfpxf7+nTIc6IbluCXy5GaATiGyJgod6lBN9nH335k1LnWv64o/DN3i4Ui4bMRpc5Dt/ZtZ2pEU8FN3tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gx9SVV7Zoe5ioOG3uh0HqnHGhMajW+ktbwAoCwCmtDc=;
 b=B/4glwY7NdGgTHMo9ljIfZ7rpACk3VpAoMuMJERECklkw3gbQloGEousPdOXey97leComMCemYqorNqigMot95uEiUGUxIJqL9T3mBussbfrvv13mw7DowRNm8/mSb3Nzlf8lr6ilYFqQZAxvAzyVrcWizN1nwb2kbukcmCTQ3uoblflPZTuauRDHXCW9tbCkF7OwrbqgrizFNewobQeveyrpIpCi/I/js3h2YX74wljQ9PwGmdmWLtCbcQChbmtlmDEvQQxXBho/YFvKTypQvQ52CuxDWPg6ZvYzoLYpRQ2NHBl+LPF//XEZmDXL5FSDI6B2zmFml0iTHoNL3Nd5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gx9SVV7Zoe5ioOG3uh0HqnHGhMajW+ktbwAoCwCmtDc=;
 b=tXIHUdQ3aNxj6zp9qpfG7g73b6RwDZWFSPj4dRNdvtxOtZdbSQ4+yY3kLu4Wn56aNUSxiReOi1wcE5clamvkp2/YsBeMDPrQQ8uzsokzBUNisrrVtq3B78LupBPZjeifBzT+fWQmK3GauLSNJp9Toi+RUUuWT2z2sZBRHI/9xnI=
Received: from MW4PR04CA0161.namprd04.prod.outlook.com (2603:10b6:303:85::16)
 by BL1PR12MB5924.namprd12.prod.outlook.com (2603:10b6:208:39b::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 13:23:43 +0000
Received: from CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::4a) by MW4PR04CA0161.outlook.office365.com
 (2603:10b6:303:85::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24 via Frontend
 Transport; Wed, 4 May 2022 13:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT048.mail.protection.outlook.com (10.13.175.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 13:23:42 +0000
Received: from jz-tester.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 4 May
 2022 08:23:41 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdgpu/vcn: add common vcn sofware ring decode
Date: Wed, 4 May 2022 09:23:24 -0400
Message-ID: <20220504132326.629117-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1993f8ac-b5f4-4370-4270-08da2dd14f39
X-MS-TrafficTypeDiagnostic: BL1PR12MB5924:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5924788983597589DCD922BFE4C39@BL1PR12MB5924.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x6F17OSZQXRh9hhOh9AuseqdGV/0Lawi0DPTNX7PEqaNlAjc443pNQ2kuy3Tr0wMd+HbelKGeCxKLNbb9Tfnj26PaIidwxYBcKwS6gC0erj6NZG4Hmr/spMxR4bvxEeT1DwSDQ7nYfZfx0qzaYyg/sX70P3vmBZsuZ89HT1sPwFDjvNh2OmQVkQpsyR0bfeXskAmjWzboZNIs40WiSLWHtbLKIkAJUf+/LiZuaAkDNJKPxxs3M76vcb0kag1CLUTaaMQXbPD6A9otkDyOLDqkZiecTlxp9/PpjInETNQV2FAanhRW3MsnQ77oJKiodEQ+dOHEvTtKRtwkg1E5BmJT1tkR56Tc+D+j0LCIOOaFNOhsIc4ZKOw28VVUMYjz1NS0dlWjIl5qLBRUGQA5J7zYmFGhR+N/V1V5j96s/vcRjRb6FSi2BRM2CaisEdMUBncyet4aNnfbEUtGSoNWZLIe7ks2hhAaVel/wSzI8eFhBkZBNehTJHYVA/b0eiDa9wNqCgIq9lVjmALaJcIfp5j06JVvYTJpYbJ/EKPtG8TKLfaCK+k1o5p1F/0xpfRApBvhZY14yGPD3PYbePvFdQGzyBP2qxlSLkvwU2EOd9sbEhXD8u6UP8CtlwZAy/JokX6Pw7In2ec+pYlYx7qeMyExyD8gZazgVaKKL0zrmGtS41Fvtsia/J9gGTzlUUicy12P4IOtW8x/qJEingnQA9Eyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(86362001)(508600001)(426003)(5660300002)(336012)(316002)(36756003)(47076005)(70206006)(40460700003)(8676002)(70586007)(8936002)(6916009)(6666004)(356005)(2906002)(7696005)(82310400005)(26005)(186003)(16526019)(1076003)(2616005)(83380400001)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 13:23:42.5039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1993f8ac-b5f4-4370-4270-08da2dd14f39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5924
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add common vcn sofware ring decode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 85 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.h | 39 +++++++++++
 3 files changed, 125 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 99a4cddd93e6..93a1ea676962 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -171,6 +171,7 @@ amdgpu-y += \
 # add VCN and JPEG block
 amdgpu-y += \
 	amdgpu_vcn.o \
+	vcn_sw_ring.o \
 	vcn_v1_0.o \
 	vcn_v2_0.o \
 	vcn_v2_5.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
new file mode 100644
index 000000000000..e020fd97aa2c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
@@ -0,0 +1,85 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu_vcn.h"
+
+void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+      u64 seq, uint32_t flags)
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
+void vcn_dec_sw_ring_insert_end(struct amdgpu_ring *ring)
+{
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_END);
+}
+
+void vcn_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
+        struct amdgpu_ib *ib, uint32_t flags)
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
+void vcn_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+        uint32_t val, uint32_t mask)
+{
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WAIT);
+	amdgpu_ring_write(ring, reg << 2);
+	amdgpu_ring_write(ring, mask);
+	amdgpu_ring_write(ring, val);
+}
+
+void vcn_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
+        uint32_t vmid, uint64_t pd_addr)
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
+	vcn_dec_sw_ring_emit_reg_wait(ring, data0, data1, mask);
+}
+
+void vcn_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
+      uint32_t val)
+{
+	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_REG_WRITE);
+	amdgpu_ring_write(ring,	reg << 2);
+	amdgpu_ring_write(ring, val);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.h b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.h
new file mode 100644
index 000000000000..603e2be346b7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.h
@@ -0,0 +1,39 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __VCN_SW_RING_H__
+#define __VCN_SW_RING_H__
+
+void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
+      u64 seq, uint32_t flags);
+void vcn_dec_sw_ring_insert_end(struct amdgpu_ring *ring);
+void vcn_dec_sw_ring_emit_ib(struct amdgpu_ring *ring, struct amdgpu_job *job,
+      struct amdgpu_ib *ib, uint32_t flags);
+void vcn_dec_sw_ring_emit_reg_wait(struct amdgpu_ring *ring, uint32_t reg,
+      uint32_t val, uint32_t mask);
+void vcn_dec_sw_ring_emit_vm_flush(struct amdgpu_ring *ring,
+      uint32_t vmid, uint64_t pd_addr);
+void vcn_dec_sw_ring_emit_wreg(struct amdgpu_ring *ring, uint32_t reg,
+      uint32_t val);
+
+#endif /* __VCN_SW_RING_H__ */
-- 
2.25.1

