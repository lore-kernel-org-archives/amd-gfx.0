Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB77ECAAD3
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Sep 2022 08:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B24D10E14D;
	Thu, 15 Sep 2022 08:17:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50FA310EAC4
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Sep 2022 08:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSFcw7LsALPbhIGhbDn4vR31POvacPJPdPD03lxWr9iOLPyvJ1ui+/1L6gdSdHcCpKFkN2C8LHp3mqUKv4BZ6romrUjDsQhNdETOyjKh0bzd2TnZCzIotTNVTecSwOn1JiDT7XXbUo5QehCrahkoIYfzBv5UNYaJUpeGszvDMiGLRx1hw4O2dTaeL5fDEbxG6Pthw2vwAOt7k+phn1mhrP3MNOYXhMYs0hAFchYzjMlUtTsT32n7PJnAKbf7tCz3V1Vzz69W1zzbCz/qFa7njouIHA0YgSF46ojHIzWO8KU8NiCg0IyJlyIF4F6+1OaCFIePzYUMhTTfHcuYU4iCxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC4luXG8nAmsxPz/kg1bmxBjkkskOXPhuBRJMbk+xTU=;
 b=RNkus/HffmlShRKTeXYKFVzfXj7W7JMcM1Ly3tQ9U5pf5YOVpiskw0ZqNEaVBmdyIC2KZsKWBevVmzNMyXV04JefH+4aHxvJblU3x9u4AuEOrOboMtudcjhzekXLtuXne+8NAYEq0J6hVzgjhVk3KMc7vO08fG79+O9+rWIuKW+LZrXr8nSpN5tBSQBT69zc8GQU9h+mNdnfKOaKVt1Z/ioiJL8mTsNFUzKdt7AmAHgTBrS38qWiMgYB2EE3XZTUbV8a1S0XUhHHJnCh62HWw7X+lET+7ULCKVSqUzxsyjNSdRf15GOgCTGVqLxBI9jsFSKMUor68jB23tPsDSJ5HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC4luXG8nAmsxPz/kg1bmxBjkkskOXPhuBRJMbk+xTU=;
 b=5Atuuk4nnSmdRZyBYdcLyG3Cb515KFTXSBL1uSjDOILsFLxWkKeppROSOh+AzVzIPpbSZq0X0SgQLPLKw1R8UVNUKWbyd9YR+5zl2gBTRwt+bl0t+tPBB0xUz4yVp+OkR4Vb/uDVTirn22ixA7opQN2f53O82R1w11tupBC6O88=
Received: from BN8PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:d4::34)
 by MN2PR12MB4111.namprd12.prod.outlook.com (2603:10b6:208:1de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15; Thu, 15 Sep
 2022 08:17:33 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::1b) by BN8PR04CA0060.outlook.office365.com
 (2603:10b6:408:d4::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Thu, 15 Sep 2022 08:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Thu, 15 Sep 2022 08:17:33 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 15 Sep 2022 03:17:30 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Implement OS triggered MCBP(v4)
Date: Thu, 15 Sep 2022 16:16:55 +0800
Message-ID: <20220915081654.876586-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT079:EE_|MN2PR12MB4111:EE_
X-MS-Office365-Filtering-Correlation-Id: b375d181-d005-4d33-a37a-08da96f2bde7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gq4NcNRxgsMlnHFVOGGD2ghol/6pf7zsVa/EV5sbPq4SUSJkGfWPAt7rE6Pr4OqSpHojdbQl8hgl2CnpzukgfAqrTEheRWmJsQNlS/CgQG32+ex7kpIFi25rRh1tTH5y2s9r7CZT9bP55qPlNkJB1c+z+3vtCUs3Z+nrR92pKqItN/ciZM+qIgpCGDDPFSu2GCe6oflGexh6YIpRPiHQhD0jl1US2iu8YnS5ZgJTtHhNt2Fh+2QiBTW6Gf0LEcYh716XuNx2L0l4A9EpriWIEgunb2TOJXpvCoy2c4MniNvSYYJh108pfmREfHHCDcFF1NEc550qPI2m4+ML/fJpmz00mHQZQzldLK//KkCNvkM7rqouzJRDESyzG3JAoGP36Ek/6X1YdeBQy0tFl6XmKaedYqHdPCKVP7xOV8GGCoOl2z+Unmm5O8k+xgR/FfmMSL/pAU819uDY3OEmzwLGyk+/LHl7rhhAw9nwZKtafCqnZV7HOBNivts1lIJuHJWYA/LFnS+KxdPDBhEeB+QaNPN/h+OUr0ubupVKwkjqPB6f/x6bRSeY4MqJ6iRS016J0gZ1rXaRPSq4SLaRNm/msUW8FbWoyn2QNQ99L7uFytz7ZBvc3y6b7YnD2d315/RsUExI3+uUuHuP02jvNQNrU39myHOJtYKkTJA68X46dIBdC0mg6A0Y+sIazB5t1b0gjlrRULG1CKz/v9PO+e1EeytaCe0VpMXiC4pP1BPTTjlBZVapvTjnZFt9LWFzesuF0WwxuiluAcduTfaHDF069kcSFbliLvUXn4f8XH2g+MlKPdr7/jdZW+0QJiATXBcN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(83380400001)(36860700001)(66899012)(336012)(426003)(1076003)(356005)(81166007)(82310400005)(41300700001)(40460700003)(478600001)(8936002)(36756003)(2876002)(2906002)(2616005)(16526019)(186003)(82740400003)(6916009)(54906003)(7696005)(5660300002)(40480700001)(30864003)(8676002)(70206006)(70586007)(4326008)(6666004)(26005)(316002)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2022 08:17:33.7891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b375d181-d005-4d33-a37a-08da96f2bde7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4111
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
Cc: Luben Tuikov <Luben.Tuikov@amd.com>, "Jiadong.Zhu" <Jiadong.Zhu@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

Trigger Mid-Command Buffer Preemption according to the priority of the software
rings and the hw fence signalling condition.

The muxer saves the locations of the indirect buffer frames from the software
ring together with the fence sequence number in its fifo queue, and pops out
those records when the fences are signalled. The locations are used to resubmit
packages in preemption scenarios by coping the chunks from the software ring.

v2: Update comment style.
v3: Fix conflict caused by previous modifications.
v4: Remove unnecessary prints.

Cc: Christian Koenig <Christian.Koenig@amd.com>
Cc: Luben Tuikov <Luben.Tuikov@amd.com>
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c       |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c     |  91 +++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.h     |  29 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c     |  12 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 153 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  22 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  27 ++++
 9 files changed, 340 insertions(+), 1 deletion(-)
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
index 000000000000..4b0aae1a7ad6
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mcbp.c
@@ -0,0 +1,91 @@
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
+	spin_lock(&mux->lock);
+
+	amdgpu_ring_preempt_ib(mux->real_ring);
+
+	ring = NULL;
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		e = &mux->ring_entry[i];
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
+	if (atomic_read(&ring->fence_drv.last_seq) !=
+	    ring->fence_drv.sync_seq) {
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
+		ring = mux->ring_entry[i].ring;
+		last_seq = atomic_read(&ring->fence_drv.last_seq);
+		seq = READ_ONCE(ring->fence_drv.sync_seq);
+		if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
+			return 0;
+		if (ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT && last_seq < seq)
+			need_preempt = 1;
+	}
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
index 4eaf3bd332f7..94362c39b73e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -574,3 +574,15 @@ int amdgpu_ring_init_mqd(struct amdgpu_ring *ring)
 
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
index aeb48cc3666c..36726c28a806 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -312,6 +312,9 @@ struct amdgpu_ring {
 #define amdgpu_ring_preempt_ib(r) (r)->funcs->preempt_ib(r)
 
 int amdgpu_ring_alloc(struct amdgpu_ring *ring, unsigned ndw);
+void amdgpu_ring_ib_begin(struct amdgpu_ring *ring);
+void amdgpu_ring_ib_end(struct amdgpu_ring *ring);
+
 void amdgpu_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
 void amdgpu_ring_generic_pad_ib(struct amdgpu_ring *ring, struct amdgpu_ib *ib);
 void amdgpu_ring_commit(struct amdgpu_ring *ring);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
index 5e9c178f358b..4f52b706b659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -24,30 +24,59 @@
 #include <drm/drm_print.h>
 
 #include "amdgpu_ring_mux.h"
+#include "amdgpu_mcbp.h"
 #include "amdgpu_ring.h"
 
 #define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
 
+static struct kmem_cache *amdgpu_mux_chunk_slab;
+
 static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
 	u64 s_begin, u64 s_end);
+static void amdgpu_mux_resubmit_chunks(struct amdgpu_ring_mux *mux);
+static void amdgpu_mux_resubmit_fallback(struct timer_list *t);
 
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
 			      unsigned int entry_size)
 {
 	mux->real_ring = ring;
 	mux->num_ring_entries = 0;
+
 	mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
 	if (!mux->ring_entry)
 		return -ENOMEM;
 
 	mux->ring_entry_size = entry_size;
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
+	timer_setup(&mux->resubmit_timer, amdgpu_mux_resubmit_fallback, 0);
 
 	return 0;
 }
 
 void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
 {
+	struct amdgpu_mux_entry *e;
+	struct amdgpu_mux_chunk *chunk, *chunk2;
+	int i;
+
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		e = &mux->ring_entry[i];
+		list_for_each_entry_safe(chunk, chunk2, &e->list, entry) {
+			list_del(&chunk->entry);
+			kmem_cache_free(amdgpu_mux_chunk_slab, chunk);
+		}
+	}
+	kmem_cache_destroy(amdgpu_mux_chunk_slab);
 	kfree(mux->ring_entry);
 	mux->ring_entry = NULL;
 	mux->num_ring_entries = 0;
@@ -67,6 +96,7 @@ int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring
 	ring->entry_index = mux->num_ring_entries;
 	e->ring = ring;
 
+	INIT_LIST_HEAD(&e->list);
 	mux->num_ring_entries += 1;
 	return 0;
 }
@@ -174,3 +204,126 @@ static void copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_rin
 		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin], end - begin);
 	}
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
+		if (mux->ring_entry[i].ring->hw_prio <= AMDGPU_RING_PRIO_DEFAULT) {
+			e = &mux->ring_entry[i];
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
+	if (seq != last_seq) {
+		/*resubmit all the fences between (last_seq, seq]*/
+		list_for_each_entry(chunk, &e->list, entry) {
+			if (chunk->sync_seq > last_seq) {
+				copy_pkt_from_sw_ring(mux, e->ring, chunk->start, chunk->end);
+				amdgpu_ring_commit(mux->real_ring);
+			}
+		}
+	}
+
+	spin_unlock(&mux->lock);
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
index 0f6430fe16b3..116ca95864a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -35,6 +35,7 @@ struct amdgpu_ring;
  * sw_cptr -- the begin of copy pointer in sw ring
  * sw_rptr -- the read pointer in software ring
  * sw_wptr -- the write pointer in software ring
+ * list -- list head for amdgpu_mux_chunk
  */
 struct amdgpu_mux_entry {
 	struct                  amdgpu_ring *ring;
@@ -43,6 +44,7 @@ struct amdgpu_mux_entry {
 	u64                     sw_cptr;
 	u64                     sw_rptr;
 	u64                     sw_wptr;
+	struct list_head        list;
 };
 
 struct amdgpu_ring_mux {
@@ -53,6 +55,22 @@ struct amdgpu_ring_mux {
 	unsigned int            ring_entry_size;
 
 	spinlock_t              lock;
+	bool                    s_resubmit;
+	struct timer_list       resubmit_timer;
+};
+
+/*
+ * amdgpu_munx_chunk -- save the location of indirect buffer's package on softare rings
+ * entry -- the list entry.
+ * sync_seq -- the fence seqno related with the saved IB.
+ * start -- start location on the software ring.
+ * end -- end location on the software ring.
+ */
+struct amdgpu_mux_chunk {
+	struct list_head        entry;
+	uint32_t                sync_seq;
+	u64                     start;
+	u64                     end;
 };
 
 int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
@@ -63,4 +81,8 @@ void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring
 u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
 u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
 
+void amdgpu_ring_mux_start_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_end_ib(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_schedule_resubmit(struct amdgpu_ring_mux *mux);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
index ec50793aa54d..4809ecf76180 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
@@ -26,6 +26,7 @@
 
 #include "amdgpu_sw_ring.h"
 #include "amdgpu_ring_mux.h"
+#include "amdgpu_mcbp.h"
 
 u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
 {
@@ -58,3 +59,29 @@ void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
 	WARN_ON(!ring->is_sw_ring);
 	amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
 }
+
+void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	WARN_ON(!ring->is_sw_ring);
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
+	WARN_ON(!ring->is_sw_ring);
+	if (ring->hw_prio > AMDGPU_RING_PRIO_DEFAULT)
+		return;
+	amdgpu_ring_mux_end_ib(mux, ring);
+}
-- 
2.25.1

