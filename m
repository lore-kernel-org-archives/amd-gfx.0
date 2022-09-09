Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7EEC54EE9
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 01:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BEA710E9D2;
	Fri,  9 Sep 2022 01:51:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E8510E9C3
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 01:51:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gVZDPdiHdsMtfzNxzoXcuanKLXUA85S8J+SHINHNkS/QJbQI2+CRF21YBI26ZL/zKXUrJtUoH7vtYGnX8ZbfTbMnuPyO7bwxUMu4wMBgA3ZGP9CGXt5NXWcnBkI1EzfipEBLXiksMPmGr5C0gj8nZuCMQKfhJ/v/ZtFtTmlAIj0Hc7+edJPai/Ba75ebmrT8AYNhZlORi50FSXbtXlznnYuxdeNDOfB+6STw0g0sgrflNzZ6RvCULJloKZi3Nw5QSUlz81W9pxn5430iMprgnMMHw1cc00ffQBTQEvZ5vxXjDK+WPBEZVXp2oL7vrwb5Ug4rvce/6Xq6/qi6wjkl3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iqsXQBMn9lcAt7B45/JlzXj3vayEht+eVu7m7WW/9uc=;
 b=Chs5s+M6LD6ba5AHHw/tjLTSDoxMWT8sDascbWUQpkDrhGG0s/9QOfYwl0J7EF/WYe3a7ItG3bJRz+3WQGPU71K3Ukjv6rGcql7szgg2fpf1+HB5oFmlEO2UKuHJQtCkAmjfsV6QQw4z/TGIlAXsuO3OpNCdzS5xfXaCbl2gAbx1TGyeOY4aG5vVaNhK2gL4XAGrMufyfCbNxnNvzTGnGd58n71ThSnuSrjCJUWrmLRvx64UEO8MeqeyhMeY8XEb3YHiWGHE0Ubqih724d5LFTvwUXWsFRP4amZKna3e+CHsaV7C642RDip4OsmqWRVL4yRpUy1LVpgaroWxcGajwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iqsXQBMn9lcAt7B45/JlzXj3vayEht+eVu7m7WW/9uc=;
 b=wqfvbzhzIU5SfFcpSD1ShmU6ua79KLuY70Z2Ncdkd9JLJZBTZi5OSNeJsnwB2S5Hhs8OVkvTBuVFohXzghz0v+tpdVRhGknFstRUqSGQnId0uX5sgOje17mAPuznL5EIuGPMmcjDvNMJpFr8EiCAnX4bcEof1Zgp2imjKDQRibU=
Received: from BN9PR03CA0531.namprd03.prod.outlook.com (2603:10b6:408:131::26)
 by CH0PR12MB5042.namprd12.prod.outlook.com (2603:10b6:610:e1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Fri, 9 Sep
 2022 01:51:34 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::4f) by BN9PR03CA0531.outlook.office365.com
 (2603:10b6:408:131::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12 via Frontend
 Transport; Fri, 9 Sep 2022 01:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 01:51:34 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 8 Sep 2022 20:51:32 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Implement OS triggered MCBP(v2)
Date: Fri, 9 Sep 2022 09:50:22 +0800
Message-ID: <20220909015022.557099-4-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220909015022.557099-1-jiadong.zhu@amd.com>
References: <20220909015022.557099-1-jiadong.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT037:EE_|CH0PR12MB5042:EE_
X-MS-Office365-Filtering-Correlation-Id: 0016b28b-b4c4-4836-dfee-08da9205d32c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0eOpJSgBWmdlkxLr0bcYjCq/Y4sbSQqIsVK9neiuQl82kcUmwHMEiZgR+Kles3jOfhHUn0+kfN/+QrNvA0doHWhZlc+66YAZCwCxxdElWlmPRshkrrj2RHff4jXpSXVnUwtS+QKgRckHv8olv3Q9RYnljcLZJjTYrqn+s2waoXUXRrWLnH1VxjwhCJdnVpdgkvIA8oFLXoPaIbjQXKM+ucrLYxNIqxccEKBzVJp4ph1wromxDiznwPHTJMmeOLkXuKQzLj27eQ0ji0kyxLposELXzPh3TRU/5B5PImwTqulX4U8AtJGPoq1Ez0XkXIeEdVVG5g8yF4T9qTZnjtBIB0ZnL0voIEKeHvJjiOyv1x8kd2lBtD86Uoi12UW8tzGmfMC7y9VBioGY8+0OEt00gqkgDJB3KvkAnJRQBZ5bR6D+8Pl9rwCG6kCWW5CgM6/e3fHwkTg9APHFYgHiGyVpoz6QDAGpuN++WTA/6bMPq/qIzFGbpBa35czoqqsnmVnVGEn4G5k1FTFwTSqJuG2yEVEGxQ512pgLw8J/YwwXEBi9gcGiwRx+zYJfDSayU5QDl8kTVhwgLr9axHlyE1M6u8zHvARqggq4uC6UmF0J/DU/b5qDe9EAvCT6xZg/A0GM+rWc88J9t7Qam19TtmJmjwjxbBVjMl5LX/HGBy6L3Lry/pqu+oRvSpdxxtwQa8hBu4k06yy1YjUrKaei7/hzTbXg3cec9eseLyuVMwRIR92Un08vRMbeqwP0NrUoKZIhIfhXQXR4B06Pr61ypZHfNBUll5oviIZmW5upH3mRyrLHrElKQYSGKUx8mr86F16O
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(36840700001)(46966006)(40470700004)(7696005)(356005)(26005)(82310400005)(86362001)(6666004)(478600001)(41300700001)(2616005)(40460700003)(36860700001)(336012)(81166007)(16526019)(47076005)(186003)(426003)(1076003)(83380400001)(82740400003)(70206006)(2876002)(70586007)(40480700001)(36756003)(8676002)(4326008)(6916009)(54906003)(5660300002)(30864003)(8936002)(2906002)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 01:51:34.1146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0016b28b-b4c4-4836-dfee-08da9205d32c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5042
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
Cc: Ray.Huang@amd.com, "Jiadong.Zhu" <Jiadong.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

Trigger MCBP according to the priroty of the
software rings and the hw fence signaling
condition.

The muxer records some lastest locations from the
software ring which is used to resubmit packages
in preemption scenarios.

v2: update comment style

Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c     | 101 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h     |  29 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 163 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  16 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  26 +++
 9 files changed, 351 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 85224bc81ce5..24c5aa19bbf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -59,7 +59,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
 	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
-	amdgpu_sw_ring.o amdgpu_ring_mux.o
+	amdgpu_sw_ring.o amdgpu_ring_mux.o amdgpu_mcbp.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 258cffe3c06a..af86d87e2f3b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -211,6 +211,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 		}
 	}
 
+	amdgpu_ring_ib_begin(ring);
 	if (job && ring->funcs->init_cond_exec)
 		patch_offset = amdgpu_ring_init_cond_exec(ring);
 
@@ -285,6 +286,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
+	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
new file mode 100644
index 000000000000..2a12101a7699
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
@@ -0,0 +1,101 @@
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
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/firmware.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <drm/gpu_scheduler.h>
+
+#include "amdgpu.h"
+#include "amdgpu_mcbp.h"
+#include "amdgpu_ring.h"
+
+/* trigger mcbp and find if we need resubmit */
+int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux)
+{
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_ring *ring = NULL;
+	int i;
+
+	DRM_INFO("%s in\n", __func__);
+
+	spin_lock(&mux->lock);
+
+	amdgpu_ring_preempt_ib(mux->real_ring);
+
+	ring = NULL;
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		e = &mux->ring_entries[i];
+		if (e->ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
+			ring = e->ring;
+			break;
+		}
+	}
+
+	if (!ring) {
+		DRM_ERROR("cannot find low priority ring\n");
+		return -ENOENT;
+	}
+
+	amdgpu_fence_process(ring);
+
+	DRM_INFO("after preempted ring_prio(%d) last_seq(%x) sync_seq(%x)\n",
+		ring->hw_prio, atomic_read(&ring->fence_drv.last_seq), ring->fence_drv.sync_seq);
+
+	if (atomic_read(&ring->fence_drv.last_seq) !=
+	    ring->fence_drv.sync_seq) {
+		DRM_INFO("schedule resubmit\n");
+		mux->s_resubmit = true;
+		amdgpu_ring_mux_schedule_resubmit(mux);
+	}
+
+	spin_unlock(&mux->lock);
+	return 0;
+}
+
+
+/*scan on low prio rings to have unsignaled fence and high ring has no fence.*/
+int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux)
+{
+	struct amdgpu_ring *ring;
+	uint32_t seq, last_seq;
+	int i, need_preempt;
+
+	need_preempt = 0;
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		ring = mux->ring_entries[i].ring;
+		last_seq = atomic_read(&ring->fence_drv.last_seq);
+		seq = READ_ONCE(ring->fence_drv.sync_seq);
+		DRM_INFO("ring(%p) prio(%d) last_seq(%x) seq(%x)\n",
+			ring, ring->hw_prio, last_seq, seq);
+		if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
+			return 0;
+		if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
+			need_preempt = 1;
+	}
+
+	DRM_INFO("%s return %d\n", __func__, need_preempt && !mux->s_resubmit);
+	return need_preempt && !mux->s_resubmit;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
new file mode 100644
index 000000000000..0033bcba8d03
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h
@@ -0,0 +1,29 @@
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
+#ifndef __AMDGPU_MCBP_H__
+#define __AMDGPU_MCBP_H__
+
+int amdgpu_mcbp_trigger_preempt(struct amdgpu_ring_mux *mux);
+int amdgpu_mcbp_scan(struct amdgpu_ring_mux *mux);
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 5b70a2c36d81..6d7f8a40e308 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -583,3 +583,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
 
 	return mqd_mgr->init_mqd(adev, ring->mqd_ptr, &prop);
 }
+
+void amdgpu_ring_ib_begin(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_begin(ring);
+}
+
+void amdgpu_ring_ib_end(struct amdgpu_ring *ring)
+{
+	if (ring->is_sw_ring)
+		amdgpu_sw_ring_ib_end(ring);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index d3155dc86c07..399037b0d6e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -311,6 +311,9 @@ struct amdgpu_ring {
 #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
 
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
+void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
+void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
+
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index ea4a3c66119a..0c9b639b844e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -20,28 +20,60 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-
+#include <linux/slab.h>
 #include <drm/drm_print.h>
 
 #include "amdgpu_ring_mux.h"
+#include "amdgpu_mcbp.h"
 #include "amdgpu_ring.h"
 
 #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
 
+static struct kmem_cache *amdgpu_mux_chunk_slab;
+
 static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
 	u64 s_begin, u64 s_end);
+static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux);
+static void amdgpu_mux_resubmit_fallback(struct timer_list *t);
 
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
 {
 	mux->real_ring = ring;
+
 	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
 	mux->num_ring_entries = 0;
+
+	mux->s_resubmit = false;
+
+	amdgpu_mux_chunk_slab = kmem_cache_create(
+		"amdgpu_mux_chunk", sizeof(struct amdgpu_mux_chunk), 0,
+		SLAB_HWCACHE_ALIGN, NULL);
+	if (!amdgpu_mux_chunk_slab) {
+		DRM_ERROR("create amdgpu_mux_chunk cache failed\n");
+		return -ENOMEM;
+	}
+
 	spin_lock_init(&mux->lock);
+
+	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
+
 	return 0;
 }
 
 void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
 {
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk, *chunk2;
+	int i;
+
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		e = &mux->ring_entries[i];
+		list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
+			list_del(&chunk->entry);
+			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
+		}
+	}
+	kmem_cache_destroy(amdgpu_mux_chunk_slab);
 	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
 	mux->num_ring_entries = 0;
 }
@@ -64,6 +96,8 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
 	e->sw_rptr = 0;
 	e->sw_wptr = 0;
 
+	INIT_LIST_HEAD(&e->list);
+
 	return 0;
 }
 
@@ -180,3 +214,130 @@ static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
 
 	return 0;
 }
+
+void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux)
+{
+	mod_timer(&mux->resubmit_timer, jiffies + AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT);
+}
+
+void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk;
+
+	if (mux->s_resubmit)
+		amdgpu_mux_resubmit_chunks(mux);
+
+	e = amdgpu_get_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry!\n");
+		return;
+	}
+
+	chunk = kmem_cache_alloc(amdgpu_mux_chunk_slab, GFP_KERNEL);
+	if (!chunk) {
+		DRM_ERROR("alloc amdgpu_mux_chunk_slab failed\n");
+		return;
+	}
+
+	chunk->start = ring->wptr;
+	list_add_tail(&chunk->entry, &e->list);
+}
+
+static void scan_and_remove_signaled_chunk(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	uint32_t last_seq, size = 0;
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk, *tmp;
+
+	e = amdgpu_get_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry!\n");
+		return;
+	}
+
+	last_seq = atomic_read(&ring->fence_drv.last_seq);
+
+	list_for_each_entry_safe(chunk, tmp, &e->list, entry) {
+		if (chunk->sync_seq <= last_seq) {
+			list_del(&chunk->entry);
+			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
+		} else {
+			size++;
+		}
+	}
+}
+
+void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk;
+
+	e = amdgpu_get_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry!\n");
+		return;
+	}
+
+	chunk = list_last_entry(&e->list, struct amdgpu_mux_chunk, entry);
+	if (!chunk) {
+		DRM_ERROR("cannot find chunk!\n");
+		return;
+	}
+
+	chunk->end = ring->wptr;
+	chunk->sync_seq = READ_ONCE(ring->fence_drv.sync_seq);
+
+	scan_and_remove_signaled_chunk(mux, ring);
+}
+
+static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux)
+{
+	struct amdgpu_mux_entry *e = NULL;
+	struct amdgpu_mux_chunk *chunk;
+	uint32_t seq, last_seq;
+	int i;
+
+	/*find low priority entries:*/
+	spin_lock(&mux->lock);
+
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		if (mux->ring_entries[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
+				e = &mux->ring_entries[i];
+			break;
+		}
+	}
+
+	if (!e) {
+		DRM_ERROR("%s no low priority ring found\n", __func__);
+		return;
+	}
+
+	last_seq = atomic_read(&e->ring->fence_drv.last_seq);
+	seq = READ_ONCE(e->ring->fence_drv.sync_seq);
+	if (seq == last_seq) {
+		DRM_INFO("skip as fence signaled seq=%x\n", seq);
+		return;
+	}
+	DRM_INFO("begin to copy resubmit chunks\n");
+
+	/*resubmit all the fences between (last_seq, seq]*/
+	list_for_each_entry(chunk, &e->list, entry) {
+		if (chunk->sync_seq > last_seq) {
+			copy_pkt_from_sw_ring(mux, e->ring, chunk->start, chunk->end);
+			amdgpu_ring_commit(mux->real_ring);
+		}
+	}
+	spin_unlock(&mux->lock);
+
+	del_timer(&mux->resubmit_timer);
+	mux->s_resubmit = false;
+}
+
+static void amdgpu_mux_resubmit_fallback(struct timer_list *t)
+{
+	struct amdgpu_ring_mux *mux = from_timer(mux, t, resubmit_timer);
+
+	DRM_INFO("calling %s\n", __func__);
+	amdgpu_mux_resubmit_chunks(mux);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
index d058c43bb063..1d91c235061a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -44,17 +44,27 @@ struct amdgpu_mux_entry {
 	u64 sw_cptr;
 	u64 sw_rptr;
 	u64 sw_wptr;
+
+	struct list_head list;
 };
 
 struct amdgpu_ring_mux {
 	struct amdgpu_ring *real_ring;
 
 	struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
-
 	unsigned num_ring_entries;
 
 	spinlock_t			lock;
 
+	bool s_resubmit;
+	struct timer_list		resubmit_timer;
+};
+
+struct amdgpu_mux_chunk {
+	struct list_head entry;
+	uint32_t sync_seq;
+	u64 start;
+	u64 end;
 };
 
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
@@ -64,4 +74,8 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
 u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
 u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
 
+void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
index 452d0ff37758..143a84c18534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
@@ -26,6 +26,7 @@
 
 #include "amdgpu_sw_ring.h"
 #include "amdgpu_ring_mux.h"
+#include "amdgpu_mcbp.h"
 
 #define amdgpu_ring_get_gpu_addr(ring, offset)				\
 	(ring->is_mes_queue ?						\
@@ -202,3 +203,28 @@ void amdgpu_sw_ring_fini(struct amdgpu_ring *ring)
 	ring->adev->rings[ring->idx] = NULL;
 }
 
+void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	BUG_ON(!ring->is_sw_ring);
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT) {
+		if (amdgpu_mcbp_scan(mux) > 0)
+			amdgpu_mcbp_trigger_preempt(mux);
+		return;
+	}
+
+	amdgpu_ring_mux_start_ib(mux, ring);
+}
+
+void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	BUG_ON(!ring->is_sw_ring);
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
+		return;
+	amdgpu_ring_mux_end_ib(mux, ring);
+}
-- 
2.25.1

