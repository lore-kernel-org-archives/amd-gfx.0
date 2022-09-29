Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380DBC07E9D
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Sep 2022 09:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5732D10E4F7;
	Thu, 29 Sep 2022 09:08:21 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C9EB10E4F7
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Sep 2022 09:08:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdHLLLnW8pvbXyu2sUELf9pFDuDGWg36sc0fa8HTFFEviLVobuGtGfrPMbSWDHh6+kx8MztlOw0OiBSTOzuymdWZnatWQ60h3pggTJ3CyvC/K6wz36F7X2KS/1U+qmytbELTwBLmxUmPhSJ6GK7D9Xy3nHp9vvn/MZRWHgtTSuj+QmD4vs7MG4H3ohqMWd1ruLQquDweXxcq1wRseF530mDnUsZP9Y7USLayDtdAlKHgf8AoUmawe3OrdIEAz1Ax1UVQ23yiOetime3xkPeh4zxI4hAJEU1PT4BCJZnpVs95c7eQeWYytWe69QQmmWDYtRquu8D7i/mFhASEBV1MfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2EQhR3zl18UpjnyQzI1U2h5ouNrJLdkxusfTCjq1IA=;
 b=k5qBnRvzmlwLiKd7NvXlzsV61FIz4/nP3AwV/9/nhbX0pekzwa6py/EEXXyPqgzlWTNWTJo1GHLpRp4VKVcL2pftsAKMdX+6E48olv3bOYCkFtYgDme9SozixiCSchsXAxQ8/+Nd3GX7pC4DejMDk++noA69Zx7sU5GDrdc4cSS/+x320xRtEKne+9jPMZiBd/AKO5hyoO6MENQfzq7h5EIydPggh6lKzFssEcE4Xn8S5WLIDf1Chge4B/v+rWLfGQMnWpThBQlz+yYLQ15gKKX2ZvoejkOSbaoBoxOpxyo6P+FqWmkr2vX8itVXR1dJ5n8wldwO5vIxVXT9SHauSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2EQhR3zl18UpjnyQzI1U2h5ouNrJLdkxusfTCjq1IA=;
 b=YHW6Yo7kwv6gVTWST8aBed/O4iGXBoohfMOUD1K5E4/eMx6fJSJfDw4upCPyhRKwlAdkvh7LEXJtuXMI2lQI3GtdqKTQ0uWi0hgwSXa1l0kgcpGiMEBgoyF5GXjh05UnUzo7Kkgxo8ki25AwNFb9g4CkuSHxcHgmfYBbPDCT228=
Received: from BN9PR03CA0988.namprd03.prod.outlook.com (2603:10b6:408:109::33)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.19; Thu, 29 Sep
 2022 09:08:16 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::3a) by BN9PR03CA0988.outlook.office365.com
 (2603:10b6:408:109::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.17 via Frontend
 Transport; Thu, 29 Sep 2022 09:08:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5676.17 via Frontend Transport; Thu, 29 Sep 2022 09:08:16 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 29 Sep 2022 04:07:36 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring (v8)
Date: Thu, 29 Sep 2022 17:07:19 +0800
Message-ID: <20220929090722.1846736-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: 140ab7bc-b9df-474d-9b81-08daa1fa2527
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mN5i2BsHJbJE0c+jadOzfmmjaTbkjCxDVXxiM3YsEnXbdv/PUcoJeAnB2DTtJnsyjkhGSehm1i49VSfiJ6mUMvv5XiuY0Rde/4YpluI8gQ0oPQs9hABl1PwN90lHoG807She5kB/MOGcxxnhYmXq1w0kMCdOdjj7ZjtJGAxgTpvmSOLXKLyZEDsJL1m4EoSA9Szr19Ec0qEOJmkNWIcoXKveTRvHyDRXChp4cOplaFrThYZvtYO22byQyLILL8cGduO9zzX2bXtgw0/lAMWDI7PX02THTRqjR+/9OS0DlKrz9LM78KjbK9mTLcRt4TTPNl5cEokCMh5/OrncXZafFel5bf60qNAg1DeTxcBMbnZl94DzGUvhL3XN8dDsySWIbkYPXgNmrwMWYDJmK1PjPmBzLygDXvvZhEPjsVY6YvN6Ohx0TI69sTdcjU2ujDMJJ45B6K4KkI15E+LZ7rsbi+xfcoTC1wK45P/NuE0DiHpssovG8FD7iabb/1EkPWz6+MQcURxP9DKADfLAr2XiAJvwkv3twBIvRFS1z6xgl17Z7aKfB1Rmb56P8Jom1g/dAm4/3Ydz3TqckNC/1/0XlxNOeuYj2mjqSaWUOYVYOKrighJoJA2l1WayAI1JMDIdaN4L7atjh6L3KnDFCryIsi53aUKSrlz/t+9rOVWz1cToY6X7IrOcBupi7zk/F8Lxt9ilDhzijbzuwqqnSADekglfDJna58+QE9C6f/JKaCt5Ct53Afd7wk92RxAASvhWIBVYDJMkHeUJ+QvpGOS+vx00Kbf69cAnhl610kD94JU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(346002)(376002)(451199015)(46966006)(36840700001)(40470700004)(36756003)(40480700001)(1076003)(186003)(2906002)(336012)(316002)(26005)(54906003)(7696005)(6666004)(2616005)(2876002)(86362001)(6916009)(8936002)(8676002)(4326008)(36860700001)(5660300002)(41300700001)(356005)(40460700003)(83380400001)(66574015)(47076005)(426003)(70206006)(70586007)(82740400003)(81166007)(30864003)(16526019)(82310400005)(66899015)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2022 09:08:16.2970 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 140ab7bc-b9df-474d-9b81-08daa1fa2527
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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
Cc: Luben Tuikov <Luben.Tuikov@amd.com>,
 =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>,
 "Jiadong.Zhu" <Jiadong.Zhu@amd.com>,
 Christian Koenig <Christian.Koenig@amd.com>, Andrey
 Grodzovsky <Andrey.Grodzovsky@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Jiadong.Zhu" <Jiadong.Zhu@amd.com>

The software ring is created to support priority context while there is only
one hardware queue for gfx.

Every software ring has its fence driver and could be used as an ordinary ring
for the GPU scheduler.
Multiple software rings are bound to a real ring with the ring muxer. The
packages committed on the software ring are copied to the real ring.

v2: Use array to store software ring entry.
v3: Remove unnecessary prints.
v4: Remove amdgpu_ring_sw_init/fini functions,
using gtt for sw ring buffer for later dma copy
optimization.
v5: Allocate ring entry dynamically in the muxer.
v6: Update comments for the ring muxer.
v7: Modify for function naming.
v8: Combine software ring functions into amdgpu_ring_mux.c

Cc: Christian Koenig <Christian.Koenig@amd.com>
Cc: Luben Tuikov <Luben.Tuikov@amd.com>
Cc: Andrey Grodzovsky  <Andrey.Grodzovsky@amd.com>
Cc: Michel Dänzer <michel@daenzer.net>
Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   4 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 217 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  76 +++++++
 5 files changed, 302 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3e0e2eb7e235..add7da53950c 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -58,7 +58,8 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
 	amdgpu_vm_sdma.o amdgpu_discovery.o amdgpu_ras_eeprom.o amdgpu_nbio.o \
 	amdgpu_umc.o smu_v11_0_i2c.o amdgpu_fru_eeprom.o amdgpu_rap.o \
 	amdgpu_fw_attestation.o amdgpu_securedisplay.o \
-	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o
+	amdgpu_eeprom.o amdgpu_mca.o amdgpu_psp_ta.o amdgpu_lsdma.o \
+	amdgpu_ring_mux.o
 
 amdgpu-$(CONFIG_PROC_FS) += amdgpu_fdinfo.o
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 53526ffb2ce1..9996dadb39f7 100644
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
+	struct amdgpu_ring_mux          muxer;
 };
 
 #define amdgpu_gfx_get_gpu_clock_counter(adev) (adev)->gfx.funcs->get_gpu_clock_counter((adev))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7d89a52091c0..40b1277b4f0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -278,6 +278,10 @@ struct amdgpu_ring {
 	bool			is_mes_queue;
 	uint32_t		hw_queue_id;
 	struct amdgpu_mes_ctx_data *mes_ctx;
+
+	bool            is_sw_ring;
+	unsigned int    entry_index;
+
 };
 
 #define amdgpu_ring_parse_cs(r, p, job, ib) ((r)->funcs->parse_cs((p), (job), (ib)))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
new file mode 100644
index 000000000000..43cab8a37754
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c
@@ -0,0 +1,217 @@
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
+#include <linux/slab.h>
+#include <drm/drm_print.h>
+
+#include "amdgpu_ring_mux.h"
+#include "amdgpu_ring.h"
+#include "amdgpu.h"
+
+#define AMDGPU_MUX_RESUBMIT_JIFFIES_TIMEOUT (HZ / 2)
+
+int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
+			 unsigned int entry_size)
+{
+	mux->real_ring = ring;
+	mux->num_ring_entries = 0;
+	mux->ring_entry = kcalloc(entry_size, sizeof(struct amdgpu_mux_entry), GFP_KERNEL);
+	if (!mux->ring_entry)
+		return -ENOMEM;
+
+	mux->ring_entry_size = entry_size;
+	spin_lock_init(&mux->lock);
+
+	return 0;
+}
+
+void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux)
+{
+	kfree(mux->ring_entry);
+	mux->ring_entry = NULL;
+	mux->num_ring_entries = 0;
+	mux->ring_entry_size = 0;
+}
+
+int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+
+	if (mux->num_ring_entries >= mux->ring_entry_size) {
+		DRM_ERROR("add sw ring exceeding max entry size\n");
+		return -ENOENT;
+	}
+
+	e = &mux->ring_entry[mux->num_ring_entries];
+	ring->entry_index = mux->num_ring_entries;
+	e->ring = ring;
+
+	mux->num_ring_entries += 1;
+	return 0;
+}
+
+static inline struct amdgpu_mux_entry *amdgpu_ring_mux_sw_entry(struct amdgpu_ring_mux *mux,
+								struct amdgpu_ring *ring)
+{
+	return ring->entry_index < mux->ring_entry_size ?
+			&mux->ring_entry[ring->entry_index] : NULL;
+}
+
+/* copy packages on sw ring range[begin, end) */
+static void amdgpu_ring_mux_copy_pkt_from_sw_ring(struct amdgpu_ring_mux *mux,
+						  struct amdgpu_ring *ring,
+						  u64 s_start, u64 s_end)
+{
+	u64 start, end;
+	struct amdgpu_ring *real_ring = mux->real_ring;
+
+	start = s_start & ring->buf_mask;
+	end = s_end & ring->buf_mask;
+
+	if (start == end) {
+		DRM_ERROR("no more data copied from sw ring\n");
+		return;
+	}
+	if (start > end) {
+		amdgpu_ring_alloc(real_ring, (ring->ring_size >> 2) + end - start);
+		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start],
+					   (ring->ring_size >> 2) - start);
+		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[0], end);
+	} else {
+		amdgpu_ring_alloc(real_ring, end - start);
+		amdgpu_ring_write_multiple(real_ring, (void *)&ring->ring[start], end - start);
+	}
+}
+
+void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr)
+{
+	struct amdgpu_mux_entry *e;
+
+	e = amdgpu_ring_mux_sw_entry(mux, ring);
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
+	amdgpu_ring_mux_copy_pkt_from_sw_ring(mux, ring, e->sw_cptr, wptr);
+	e->end_ptr_in_hw_ring = mux->real_ring->wptr;
+	amdgpu_ring_commit(mux->real_ring);
+
+	spin_unlock(&mux->lock);
+}
+
+u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+
+	e = amdgpu_ring_mux_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("cannot find entry for sw ring\n");
+		return 0;
+	}
+
+	return e->sw_wptr;
+}
+
+/*
+ * The return value of the readptr is not precise while the other rings could
+ * write data onto the real ring buffer.After overwriting on the real ring, we
+ * can not decide if our packages have been excuted or not read yet. However,
+ * this function is only called by the tools such as umr to collect the latest
+ * packages for the hang analysis. We assume the hang happens near our latest
+ * submit. Thus we could use the following logic to give the clue:
+ * If the readptr is between start and end, then we return the copy pointer
+ * plus the distance from start to readptr. If the readptr is before start, we
+ * return the copy pointer. Lastly, if the readptr is past end, we return the
+ * write pointer.
+ */
+u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring)
+{
+	struct amdgpu_mux_entry *e;
+	u64 readp, offset, start, end;
+
+	e = amdgpu_ring_mux_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("no sw entry found!\n");
+		return 0;
+	}
+
+	readp = amdgpu_ring_get_rptr(mux->real_ring);
+
+	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
+	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
+	if (start > end) {
+		if (readp <= end)
+			readp += mux->real_ring->ring_size >> 2;
+		end += mux->real_ring->ring_size >> 2;
+	}
+
+	if (start <= readp && readp <= end) {
+		offset = readp - start;
+		e->sw_rptr = (e->sw_cptr + offset) & ring->buf_mask;
+	} else if (readp < start) {
+		e->sw_rptr = e->sw_cptr;
+	} else {
+		/* end < readptr */
+		e->sw_rptr = e->sw_wptr;
+	}
+
+	return e->sw_rptr;
+}
+
+u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	WARN_ON(!ring->is_sw_ring);
+	return amdgpu_ring_mux_get_rptr(mux, ring);
+}
+
+u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	WARN_ON(!ring->is_sw_ring);
+	return amdgpu_ring_mux_get_wptr(mux, ring);
+}
+
+void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	struct amdgpu_ring_mux *mux = &adev->gfx.muxer;
+
+	WARN_ON(!ring->is_sw_ring);
+	amdgpu_ring_mux_set_wptr(mux, ring, ring->wptr);
+}
+
+/* Override insert_nop to prevent emitting nops to the software rings */
+void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count)
+{
+	WARN_ON(!ring->is_sw_ring);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
new file mode 100644
index 000000000000..d91629589577
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h
@@ -0,0 +1,76 @@
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
+/**
+ * struct amdgpu_mux_entry - the entry recording software rings copying information.
+ * @ring: the pointer to the software ring.
+ * @start_ptr_in_hw_ring: last start location copied to in the hardware ring.
+ * @end_ptr_in_hw_ring: last end location copied to in the hardware ring.
+ * @sw_cptr: the position of the copy pointer in the sw ring.
+ * @sw_rptr: the read pointer in software ring.
+ * @sw_wptr: the write pointer in software ring.
+ */
+struct amdgpu_mux_entry {
+	struct                  amdgpu_ring *ring;
+	u64                     start_ptr_in_hw_ring;
+	u64                     end_ptr_in_hw_ring;
+	u64                     sw_cptr;
+	u64                     sw_rptr;
+	u64                     sw_wptr;
+};
+
+struct amdgpu_ring_mux {
+	struct amdgpu_ring      *real_ring;
+
+	struct amdgpu_mux_entry *ring_entry;
+	unsigned int            num_ring_entries;
+	unsigned int            ring_entry_size;
+	/*the lock for copy data from different software rings*/
+	spinlock_t              lock;
+};
+
+int amdgpu_ring_mux_init(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring,
+			 unsigned int entry_size);
+void amdgpu_ring_mux_fini(struct amdgpu_ring_mux *mux);
+int amdgpu_ring_mux_add_sw_ring(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+void amdgpu_ring_mux_set_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring, u64 wptr);
+u64 amdgpu_ring_mux_get_wptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+u64 amdgpu_ring_mux_get_rptr(struct amdgpu_ring_mux *mux, struct amdgpu_ring *ring);
+
+u64 amdgpu_sw_ring_get_rptr_gfx(struct amdgpu_ring *ring);
+u64 amdgpu_sw_ring_get_wptr_gfx(struct amdgpu_ring *ring);
+void amdgpu_sw_ring_set_wptr_gfx(struct amdgpu_ring *ring);
+
+void amdgpu_sw_ring_insert_nop(struct amdgpu_ring *ring, uint32_t count);
+void amdgpu_sw_ring_ib_begin(struct amdgpu_ring *ring);
+void amdgpu_sw_ring_ib_end(struct amdgpu_ring *ring);
+
+#endif
-- 
2.25.1

