Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE23C433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  4 May 2022 15:04:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9F5110E47D;
	Wed,  4 May 2022 15:04:30 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B9B10E47D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 May 2022 15:04:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQgmRURsAgCr0nKdlfcY5YJFg4ckv9gcE8BkGHAEisWYH1p4OHx9tx0VbQZr+EEzkzgeW0T+Xwo7JsbAHkPvTinZAge9lugXDuUesiIRP2tKSMrsC6Gfue5R0yNh347+rOSuAsydZNwKsKJraJolYsjlj3FNlPkULzDS6mE67e/glPTmA33OgJAyV2W2JMcygMPBVxFls4f1fvSD0jkqfU6f+eUO94IlPLxT0/Bk6mGVRgSuTgCoQyhBIkOAKRby7Z5ftCGxqY3uyAmKpHLtOKxMh7DJxUADR3CmVKvTVALnpT4FedmeHyY7uMEatKsU25fN1mj7pXQcigYZp1Kp5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZf2jq3c2BGCAbatQhn05VmlzRzZp2KRg6zPUUTfu/A=;
 b=GdT+jFrZCZDnPL7xCAnTc2y0qKwKLIPx7SNMQO7FMFWtPIx6ujjxntR93hUWfZxa8D39BiUkXr6/a9lmk5O7qR5trT7sb5NVuFQKgiA8IJ5opaYBj0o28UUZ2aqbPXtY/COSUsSpbJ13Pf8JSPqEo/aISvSPeafWUu1AkYBcv9xEjZOFeJQNPrhFSszW6mjhWmQO0ry9x+Vf+m0nC2ZIKOP0crRIxhoeuiteOk157LAsyVaM31mxIVaVbcqrHEyLZh9hiwGvbEBm7bs7mTBee0LLOoD2pvAk00HDyEOybk/I+DwqATLAOfMuQVP1B3bLxbgGSVQKr1+5V8KESsFz5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZf2jq3c2BGCAbatQhn05VmlzRzZp2KRg6zPUUTfu/A=;
 b=Zp28cenREV3ej7BEO8RAvksvFyKlVpn4afLmSbwFSXImXNlsBYsi5zdHm2WIPb8HUqhcRqSQ/v+Jdgm2GpUYBkHmbJsd93/UMyaLoTdzevuYlWayF/SMOGFvl6XmoVUVyTj0A+bfZmo11AE3thpUVGQVM43/RF3hDrWLBeh6D0M=
Received: from DS7PR03CA0287.namprd03.prod.outlook.com (2603:10b6:5:3ad::22)
 by IA1PR12MB6332.namprd12.prod.outlook.com (2603:10b6:208:3e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Wed, 4 May
 2022 15:04:28 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::6b) by DS7PR03CA0287.outlook.office365.com
 (2603:10b6:5:3ad::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23 via Frontend
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
 2022 10:04:26 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amdgpu/vcn: add common vcn sofware ring decode
Date: Wed, 4 May 2022 11:04:13 -0400
Message-ID: <20220504150415.667764-2-James.Zhu@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1f1db2c3-a828-47f9-29d5-08da2ddf62a6
X-MS-TrafficTypeDiagnostic: IA1PR12MB6332:EE_
X-Microsoft-Antispam-PRVS: <IA1PR12MB6332FFB6247FD3013E2A1374E4C39@IA1PR12MB6332.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0y0wW0avhijAqa7e8abeB73JV3o/7bchJlRAxJ8vtsppdo8OGmPaTafayksOkVk/4vs3rDVLBE8MTsaMVKD/xvrLZgIKYgTH2KQ9W/MLH8nq2GJnwbxCfrPVThnZ/0MBthg8REPK03aTeT+jwlfOfF+w8WYqIzaQcY7dzWZnsVUgZX08BJXzIAZc/Ebqtt846csNAhCnjmzuIzcH76/Au4ASLB5mOy/EdSTJo7o86k3AeLKVsNol736pU6ka+YDYa2XsnPaeJ8OcwsLLsGDtupjUkQTMqCHZkh2/wd2Peb6fIjqucSI69vXz5Z+Jhao9L0ygVYYCTaCcVBzCuNBsx5rgEv/8qSAeEnNNr2w/VF490JleW3o/qGlFZY2D+lYGSpjCwQlF8EwSCZf97culZNSDW4/k6G7HY/SkV+e6bkqhWPCEA+xH7tYQE04ra86a9njIu1SvCWhaxyCPukT3l2640QpbD+mnL0QolHyguj5OU4M6cANIGWyJnJkR5aA0/NgesDrVJX1sUitD4SAwb7Y46iZ49ny+gnaG9phdaV153hygvCUTobFVMHxu7WBcnCj7HHRcVzLhLZseArhC/mwFXr6+Ik3Cbq5p6uJ2lT5EN35eJKz1WV5bDFcs6hGd53uuZ3g2KB3Sr4tg2rBOHHK0YkAlIcq2JWNJLLtxfR7NpYirZ3ehptDdPX9+GLh9B0xTtpjoZUB9gUHbsJ5YRQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(6666004)(8936002)(86362001)(26005)(2906002)(5660300002)(508600001)(356005)(4326008)(7696005)(81166007)(83380400001)(36860700001)(2616005)(1076003)(40460700003)(426003)(16526019)(47076005)(186003)(336012)(82310400005)(8676002)(36756003)(6916009)(316002)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 15:04:28.1422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1db2c3-a828-47f9-29d5-08da2ddf62a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6332
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

Add common vcn sofware ring decode.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Christian Koenig <Christian.Koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 85 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.h | 44 ++++++++++++
 3 files changed, 130 insertions(+)
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
index 000000000000..d87645e91cd7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.h
@@ -0,0 +1,44 @@
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
+#define VCN_SW_RING_EMIT_FRAME_SIZE \
+		4 + /* vcn_dec_sw_ring_emit_vm_flush */ \
+		5 + 5 + /* vcn_dec_sw_ring_emit_fence x2 vm fence */ \
+		1 /* vcn_dec_sw_ring_insert_end */
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

