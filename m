Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CAC7C6FA82
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Sep 2022 09:06:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C08710E675;
	Tue, 13 Sep 2022 09:06:54 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8AD3B10E664
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Sep 2022 09:06:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5HoIDXz/JgMwiwpL8Af8DOzL6MDFORstGxycy655IUJhMn6xW/7PtazWeBFGirsB63HaftUxkHOKTTh89dzGPfA5N+JW4bBppMMedWqrTA8cXkaVxG4qZPjugzQSMC2TDPlDZD0MhMjamAVx4IvuPEI7luxM7CtTtcuumupPpNC1mDHNFjblnuwKEji8ioFMesnQGjMgXEhejihHNu2w98VS6UwQw5RQzoc+0tgcAG2pIOsxg4Jt38xuUMbK4HRr7SObj5vayAC3zyP6wmWyDHi5FiHFF0jY+nVrz4mZrD2txkCp1b/iSqoueeG8SShCy6cxFvODQwgFHbpfgvKgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VqDBxFLf4lESV+8KDh5qg0EcqoP6ic2G2/WoCC4ZxWk=;
 b=S8i9JUmPIuc3bGuBecKF2vH55cFrCWQubwmQJNiLhyg/35U/zZyYqxC9C0YMZguRrf3zC8QV2wwqFeCrZoLo+gVhMXUQIz/ffahjTIdAH/Wu5PuUAMUNUzeRDKOiRe9+F3USZZn+kQh8T5yHI/ymJe/ETupzC+O9yPIfr/oHjpTJAlcy/P4Uprpf8ypZH7z1jM0jGVQzBXPA0CXEoV9uxbfdwtnr9kYQtNus4APHXaigfSoCUMZD4OPC2Ahcn5LICWS+cAk9vfYVdffDWJkf9mBewsegK+KAErlFcAZft+j6VJ+u8HYSPIjSY/hmqaEJH+UyFBkqyoiHDXjAxA69mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VqDBxFLf4lESV+8KDh5qg0EcqoP6ic2G2/WoCC4ZxWk=;
 b=GJxwDaRfAG+jz4J6CT0l3S1HNvuzcVgFo4xP4jQFPthL46NN0notmUEDfTSYN1vqf1xpe5AWrjP8lKVrK1Jq43wrXcEeuPQpH1VbCTVaUqUrx8sjq26a9r+2SiGyI7GznAjKbYW8+UtMLgkHhhBh4eTGrvPPWvxjIvBte6FwEws=
Received: from SJ0PR13CA0155.namprd13.prod.outlook.com (2603:10b6:a03:2c7::10)
 by IA1PR12MB7568.namprd12.prod.outlook.com (2603:10b6:208:42c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18; Tue, 13 Sep
 2022 09:06:46 +0000
Received: from CO1PEPF00001A5D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::6c) by SJ0PR13CA0155.outlook.office365.com
 (2603:10b6:a03:2c7::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.12 via Frontend
 Transport; Tue, 13 Sep 2022 09:06:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF00001A5D.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.12 via Frontend Transport; Tue, 13 Sep 2022 09:06:45 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 13 Sep 2022 04:06:22 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v4)
Date: Tue, 13 Sep 2022 17:05:59 +0800
Message-ID: <20220913090558.685714-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00001A5D:EE_|IA1PR12MB7568:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f38e788-6598-4fad-9ec8-08da9567485c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i6NFVyubSAqrf/LtnJVEWkDpSSgrFe8Rkv9b+RgZNQuXGZvbc9/V3OZQwFIva/tdkeCys+ZRUwZ+srMBQs6p6GXS5DFnxmNw9ADtbWu9YfhRv/VNSmFptqli0gB5z+h3lrC95ni7CsHKQjJRdUWHvVm9snjQ6eJYPx6CkkVg/lCMJb/kywhaJakSDk/k6pRedGqhQVa4ubPwvpW2q9sAy20NjjXoLpBfnETtHPn/YocgniRXQVpFbs68uE89RnyoF+mwJuBSiDdxciLbzakU2HnM4Ah9hOC62jG8DdWwe+hDLP2DJ9PnXMtLgbcFVA5QqdqH1DW/WZCmMMY7RYl6V8EvWOcqntj8hq6Je04SE/q+p3mKOZceCtS+Llybu6zRhC3ANpIPof7fqyinJ5mOBdRspL/tzM9j6O+00hDKGCudSQbBIE6ZVJ2jkXnpV9m8nfx9vRd5f/ELnLSr1/C0AVNemBztBifGJsRDi0xo0CMUHQTOF8qayv9dj38WJfury0V4oBBqSJvZP7hqqS6qBj/KD5uJcjGQ3mMRJjeKn5wV7fKp1vTbZZBgO/QRlDrBAAO7BtapuUMy861UaFngJELvm+pw1G2GGaH4F+MFbzuRlWPxO8VK+B0zX6ARq5ovdB8i949ML5dLdyVdLn/SqOCfeOgJhZoSgnw4D2XaQ1uh2549GoiU05ZLduB2GHDiRftWfrvLmw6rRI0mKzqK5Cl4VNpGjHuOIemIhm6N7ijxCH9InnLaFtcjcberZ08yBoCD3/isRvc4MBWuLMWEx5oHPgCNOEv2Pr+Pwm3cQcU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(36756003)(40480700001)(356005)(70586007)(2616005)(5660300002)(4326008)(8936002)(70206006)(30864003)(8676002)(81166007)(2906002)(2876002)(86362001)(36860700001)(54906003)(82740400003)(6916009)(316002)(47076005)(186003)(1076003)(478600001)(83380400001)(40460700003)(426003)(336012)(6666004)(26005)(16526019)(7696005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:06:45.2515 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f38e788-6598-4fad-9ec8-08da9567485c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00001A5D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7568
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

The software ring is created to support priority
context while there is only one hardware queue
for gfx.

Every software rings has its fence driver and could
be used as an ordinary ring for the gpu_scheduler.
Multiple software rings are binded to a real ring
with the ring muxer. The packages committed on the
software ring are copied to the real ring.

v2: use array to store software ring entry.
v3: remove unnecessary prints.
v4: remove amdgpu_ring_sw_init/fini functions,
using gtt for sw ring buffer for later dma copy
optimization.

Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  |  60 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  43 +++++
 7 files changed, 360 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3e0e2eb7e235..85224bc81ce5 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
-	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
+	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
+	amdgpu_sw_ring.o amdgpu_ring_mux.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 53526ffb2ce1..0de8e3cd0f1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -33,6 +33,7 @@
 #include "amdgpu_imu.h"
 #include "soc15.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_ring_mux.h"
 
 /* GFX current status */
 #define AMDGPU_GFX_NORMAL_MODE			0x00000000L
@@ -346,6 +347,8 @@ struct amdgpu_gfx {
 	struct amdgpu_gfx_ras		*ras;
 
 	bool				is_poweron;
+
+	struct amdgpu_ring_mux			muxer;
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7d89a52091c0..fe33a683bfba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -278,6 +278,9 @@ struct amdgpu_ring {
 	bool			is_mes_queue;
 	uint32_t		hw_queue_id;
 	struct amdgpu_mes_ctx_data *mes_ctx;
+
+	bool			is_sw_ring;
+
 };
 
 #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
new file mode 100644
index 000000000000..652a6d3e0ec3
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -0,0 +1,182 @@
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
+#include <drm/drm_print.h>
+
+#include "amdgpu_ring_mux.h"
+#include "amdgpu_ring.h"
+
+#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ/2)
+
+static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
+	u64 s_begin, u64 s_end);
+
+int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	mux->real_ring = ring;
+	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
+	mux->num_ring_entries = 0;
+	spin_lock_init(&mux->lock);
+	return 0;
+}
+
+void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
+{
+	memset(mux->ring_entries, 0, sizeof(mux->ring_entries));
+	mux->num_ring_entries = 0;
+}
+
+int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+
+	if (mux->num_ring_entries == AMDGPU_MAX_GFX_RINGS) {
+		DRM_ERROR("adding sw ring exceeds max gfx num\n");
+		return -ENOMEM;
+	}
+
+	e = &mux->ring_entries[mux->num_ring_entries++];
+
+	e->ring = ring;
+	e->start_ptr_in_hw_ring = 0;
+	e->end_ptr_in_hw_ring = 0;
+	e->sw_cptr = 0;
+	e->sw_rptr = 0;
+	e->sw_wptr = 0;
+
+	return 0;
+}
+
+static struct amdgpu_mux_entry *amdgpu_get_sw_entry(struct amdgpu_ring_mux *mux,
+				struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+	int i;
+
+	e = NULL;
+	for (i = 0; i < mux->num_ring_entries; i++) {
+		if (mux->ring_entries[i].ring == ring) {
+			e = &mux->ring_entries[i];
+			break;
+		}
+	}
+
+	return e;
+}
+
+void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
+{
+	struct amdgpu_mux_entry *e;
+
+	e = amdgpu_get_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry for sw ring\n");
+		return;
+	}
+
+	spin_lock(&mux->lock);
+	e->sw_cptr = e->sw_wptr;
+	e->sw_wptr = wptr;
+	e->start_ptr_in_hw_ring = mux->real_ring->wptr;
+
+	if (copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr) == 0) {
+		e->end_ptr_in_hw_ring = mux->real_ring->wptr;
+		amdgpu_ring_commit(mux->real_ring);
+	}
+
+	spin_unlock(&mux->lock);
+}
+
+u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+
+	e = amdgpu_get_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry for sw ring\n");
+		return 0;
+	}
+
+	return e->sw_wptr;
+}
+
+u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+	u64 r_rptr, offset, start, end;
+
+	e = amdgpu_get_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("no sw entry found!\n");
+		return 0;
+	}
+
+	r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
+
+	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
+	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
+	if (start > end) {
+		if (r_rptr <= end)
+			r_rptr += mux->real_ring->ring_size >> 2;
+		end += mux->real_ring->ring_size >> 2;
+	}
+
+	if (r_rptr <= end && r_rptr >= start) {
+		offset = r_rptr - start;
+		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
+	} else if (r_rptr < start) {
+		e->sw_rptr = e->sw_cptr;
+	} else {
+		e->sw_rptr = e->sw_wptr;
+	}
+
+	return e->sw_rptr;
+}
+
+/*copy packages on sw ring range[begin, end) */
+static int copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
+	u64 s_begin, u64 s_end)
+{
+	u64 begin, end, r_begin, r_end;
+	struct amdgpu_ring *real_ring = mux->real_ring;
+
+	begin = s_begin & ring->buf_mask;
+	end = s_end & ring->buf_mask;
+
+	r_begin = real_ring->wptr & real_ring->buf_mask;
+	if (begin == end)
+		return -ERANGE;
+	if (begin > end) {
+		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - begin);
+		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin],
+			(ring->ring_size >> 2) - begin);
+		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
+	} else {
+		amdgpu_ring_alloc(real_ring, end - begin);
+		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[begin], end - begin);
+	}
+
+	r_end = real_ring->wptr & real_ring->buf_mask;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
new file mode 100644
index 000000000000..d058c43bb063
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -0,0 +1,67 @@
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
+#ifndef __AMDGPU_RING_MUX__
+#define __AMDGPU_RING_MUX__
+
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include "amdgpu_ring.h"
+
+struct amdgpu_ring;
+/*
+ * start_ptr_in_hw_ring - last copied start loc on hw ring
+ * end_ptr_in_hw_ring - last copied end loc on hw ring
+ *sw_cptr -the begin of copy ptr in sw ring
+ *sw_rptr; the read ptr in sw ring
+ *sw_wptr; the write ptr in sw ring
+ */
+struct amdgpu_mux_entry {
+	struct amdgpu_ring	*ring;
+	u64 start_ptr_in_hw_ring;
+	u64 end_ptr_in_hw_ring;
+
+	u64 sw_cptr;
+	u64 sw_rptr;
+	u64 sw_wptr;
+};
+
+struct amdgpu_ring_mux {
+	struct amdgpu_ring *real_ring;
+
+	struct amdgpu_mux_entry ring_entries[AMDGPU_MAX_GFX_RINGS];
+
+	unsigned num_ring_entries;
+
+	spinlock_t			lock;
+
+};
+
+int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
+int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_set_wptr_to_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
+u64 amdgpu_ring_get_wptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+u64 amdgpu_ring_get_rptr_from_mux(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
new file mode 100644
index 000000000000..7a59e3fbb970
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
@@ -0,0 +1,60 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ */
+
+#include "amdgpu_sw_ring.h"
+#include "amdgpu_ring_mux.h"
+
+u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	BUG_ON(!ring->is_sw_ring);
+	return amdgpu_ring_get_rptr_from_mux(mux, ring);
+}
+
+u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	BUG_ON(!ring->is_sw_ring);
+	return amdgpu_ring_get_wptr_from_mux(mux, ring);
+}
+
+void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
+{
+	BUG_ON(!ring->is_sw_ring);
+}
+
+void amdgpu_sw_ring_commit(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	BUG_ON(!ring->is_sw_ring);
+	amdgpu_ring_set_wptr_to_mux(mux, ring, ring->wptr);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
new file mode 100644
index 000000000000..0a2e66318f3f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright 2012 Advanced Micro Devices, Inc.
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
+#include <drm/amdgpu_drm.h>
+#include <drm/gpu_scheduler.h>
+#include <drm/drm_print.h>
+
+#include "amdgpu_irq.h"
+#include "amdgpu_ring.h"
+#include "amdgpu.h"
+
+#ifndef __AMDGPU_SWRING_H__
+#define __AMDGPU_SWRING_H__
+
+u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
+u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
+void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
+void amdgpu_sw_ring_commit(struct amdgpu_ring *ring);
+
+void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
+void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
+
+#endif
-- 
2.25.1

