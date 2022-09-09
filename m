Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99909ECAAD5
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Sep 2022 01:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E9B10E9C3;
	Fri,  9 Sep 2022 01:51:37 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 07D4C10E1D1
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Sep 2022 01:51:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBj+i18YWhMUIevNEkubmYy1PlA7RHXSCqemW/6WGkrFn/U8oBz/wuyNjV0P/nNcy+pDDtZxSns+4E6QwpyqiS/7UmQJklIEGfYAxi/NKX1eWXwZPI/uTpfoP11K/kc+J3iwmynztZz4AO5fKnBKlG+pG3uPFFaBxWrplkOo2v/NRZ0c1VjvF/+Xc0w0W5149EiH2TE6e9H867Gm3AO5f0s50x57uw4EwsJg+isWuaDRMDXn62Njau/1wLo3pt61vpplotqQDkE48yQmZ/uCKOkmkLWMqVBBy3Stu7dqr9pVawt+aH9LAXsuBJn92WvtBeDL5WLwVI1kmYRciz05Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2luTQ4lcUJGmHZ4GIbMUTnQRN2Hw5a4KaPFUdNSewdY=;
 b=I1EvBXqW0lhyzmgMGz12yS/txeRHgjlaJHDpQOmjR/lXktHyrn2rB0kLB8bYnFXuAYIaMYryWFYPL6/Dc5evWZ6YbXz3tSphKUVEJv2h4QbbHzUcjOwfJ/yuOcDzGhZ095/8X91uekPHR7lGO0+KkRiqATIltgiTEPiYlwWp4hdC1z+Y1Wg3cB8ywi597owAa/RXCuZ2KW++6F0cdoUp4sCrWqRZEtd93+4ma4OFYmAOieGTFvxQzZ7ZC+ZmDNg8Uz/uX8wfGVQbFp3JPkplOnZvTV1z3i8hgnuAyYXLVC5yNCyPlvdEexb9P3gkc2jioHpUfIeK723PYN+jbSyAQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2luTQ4lcUJGmHZ4GIbMUTnQRN2Hw5a4KaPFUdNSewdY=;
 b=otAIpkmi9KVqtMh/6DktYbpQSIWZUyGVd7x+D0GpMVq0FWl9b2hdoLN2AKCeUzcuJAKSIUiS8PCMNXZy9pmfn8gbb+93RnEyXtqtZMVngZbTKfCCCVymHGsCwJ58T6rP/TNXX3Xz/y+fYkrnxvzBgLjojMmzXfkiRDXYbtE43/I=
Received: from BN0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:408:ee::28)
 by CH3PR12MB7644.namprd12.prod.outlook.com (2603:10b6:610:14f::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Fri, 9 Sep
 2022 01:51:29 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::96) by BN0PR04CA0023.outlook.office365.com
 (2603:10b6:408:ee::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Fri, 9 Sep 2022 01:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Fri, 9 Sep 2022 01:51:29 +0000
Received: from jenkins-jiadong-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 8 Sep 2022 20:51:27 -0500
From: <jiadong.zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu: Introduce gfx software ring(v3)
Date: Fri, 9 Sep 2022 09:50:19 +0800
Message-ID: <20220909015022.557099-1-jiadong.zhu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT045:EE_|CH3PR12MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7889a7-b979-499d-9056-08da9205d041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZjXKgZBBnlQiQMZw4bwyHy7G3/UNMioXGaXL+lr6MbRUyIcCTIkWABWRBS/Mt8tndpMX5PBVzKTqlsflzzzhEkIsbzlkFjjOLclgSqwqSNB1DxgI+UY90261xsTeNDpD5frYrZlVTAiwfWf5h1Yi+qZTWxTru2omnvFAWgNwKruMqE8yENn9xEYGtDwrdkZkk+anrGNM3Srepl7WloTH5Em2p8NJzO0evc4z/PgHCykQdcC+ZelwMH7Q2HhXZhxlhISwIzQS7i08NngN3mDP+zI78fyizM0xZ7paz0oXNXPZbcEqUEdcGsaLlwbyPzUuURUuDlfPs/xz8rd8OIw+lu6KIOs1VvasO1MIeHZzV8rEvKxNY10FErJPB7XID6DAXsQ7sHgBCe9tGmpWzF4Pj+6d/yY2zWbQT/iFXv4+9baemas3WU4c4oWJHHAfAwBJq7gkyutmlnA7QmpH9vhJLtTGUPIBr9jRSywruQB9YqFzSU+ouHvYtQhEi1/VNqBssm34dd0578YesSA/BYIugt93ab/h018UHYlMLFR4bb6Op3HfzS6lgbqXQiNtb4st/n9Sl9wYrZQocWWLJV5WSa7q3zBn3CqSzV6Xm0awhiM/o2Oqm6ZGBwMKsdkAGIivb/9JUlOtS56Y8gK6LTP/nrFBcW+W6SBj16j8cK7CnY4aXOhOjAbxbQIRGjpkEsEyBzGWnVltkH01kPqpoiqsuct0B5HQQq7nNFLy7wXg4j19SP2GBnPVa0esmP2xQe3SWlEP7LpyqAOEiM74PoTua/cQnGHTtS4hWL+C1bCC4Ic=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(346002)(39860400002)(136003)(376002)(36840700001)(40470700004)(46966006)(8676002)(41300700001)(4326008)(2906002)(6916009)(40480700001)(70206006)(8936002)(54906003)(316002)(70586007)(30864003)(5660300002)(2876002)(82310400005)(36756003)(478600001)(6666004)(86362001)(426003)(16526019)(336012)(7696005)(1076003)(186003)(26005)(83380400001)(2616005)(47076005)(36860700001)(40460700003)(81166007)(82740400003)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2022 01:51:29.2014 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7889a7-b979-499d-9056-08da9205d041
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7644
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

Signed-off-by: Jiadong.Zhu <Jiadong.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile          |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h      |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h     |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.c | 182 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring_mux.h |  67 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c  | 204 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h  |  48 +++++
 7 files changed, 509 insertions(+), 1 deletion(-)
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
index 000000000000..ea4a3c66119a
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
+	u64 r_rptr, r_wptr, offset, start, end;
+
+	e = amdgpu_get_sw_entry(mux, ring);
+	if (!e) {
+		DRM_ERROR("no sw entry found!\n");
+		return 0;
+	}
+
+	r_rptr = amdgpu_ring_get_rptr(mux->real_ring);
+	r_wptr = amdgpu_ring_get_wptr(mux->real_ring);
+
+	if (r_wptr < r_rptr)
+		r_wptr += mux->real_ring->ring_size >> 2;
+
+	start = e->start_ptr_in_hw_ring & mux->real_ring->buf_mask;
+	end = e->end_ptr_in_hw_ring & mux->real_ring->buf_mask;
+	if (start > end)
+		end += mux->real_ring->ring_size >> 2;
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
index 000000000000..452d0ff37758
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.c
@@ -0,0 +1,204 @@
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
+#define amdgpu_ring_get_gpu_addr(ring, offset)				\
+	(ring->is_mes_queue ?						\
+	 (ring->mes_ctx->meta_data_gpu_addr + offset) :			\
+	 (ring->adev->wb.gpu_addr + offset * 4))
+
+#define amdgpu_ring_get_cpu_addr(ring, offset)				\
+	(ring->is_mes_queue ?						\
+	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
+	 (&ring->adev->wb.wb[offset]))
+
+
+int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
+		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
+		     unsigned int irq_type, unsigned int hw_prio,
+		     atomic_t *sched_score)
+{
+	int r;
+	int sched_hw_submission = amdgpu_sched_hw_submission;
+	u32 *num_sched;
+	u32 hw_ip;
+
+	BUG_ON(!ring->is_sw_ring);
+
+	if (ring->adev == NULL) {
+		if (adev->num_rings >= AMDGPU_MAX_RINGS)
+			return -EINVAL;
+
+		ring->adev = adev;
+		ring->num_hw_submission = sched_hw_submission;
+		ring->sched_score = sched_score;
+		ring->vmid_wait = dma_fence_get_stub();
+
+		if (!ring->is_mes_queue) {
+			ring->idx = adev->num_rings++;
+			adev->rings[ring->idx] = ring;
+		}
+
+		r = amdgpu_fence_driver_init_ring(ring);
+		if (r)
+			return r;
+	}
+
+	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
+	if (r) {
+		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
+		return r;
+	}
+
+	r = amdgpu_device_wb_get(adev, &ring->fence_offs);
+	if (r) {
+		dev_err(adev->dev, "(%d) ring fence_offs wb alloc failed\n", r);
+		return r;
+	}
+
+	r = amdgpu_device_wb_get(adev, &ring->trail_fence_offs);
+	if (r) {
+		dev_err(adev->dev, "(%d) ring trail_fence_offs wb alloc failed\n", r);
+		return r;
+	}
+
+	r = amdgpu_device_wb_get(adev, &ring->cond_exe_offs);
+	if (r) {
+		dev_err(adev->dev, "(%d) ring cond_exec_polling wb alloc failed\n", r);
+		return r;
+	}
+
+	ring->fence_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->fence_offs);
+	ring->fence_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->fence_offs);
+
+	ring->trail_fence_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->trail_fence_offs);
+	ring->trail_fence_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->trail_fence_offs);
+
+	ring->cond_exe_gpu_addr =
+		amdgpu_ring_get_gpu_addr(ring, ring->cond_exe_offs);
+	ring->cond_exe_cpu_addr =
+		amdgpu_ring_get_cpu_addr(ring, ring->cond_exe_offs);
+
+	/* always set cond_exec_polling to CONTINUE */
+	*ring->cond_exe_cpu_addr = 1;
+
+	r = amdgpu_fence_driver_start_ring(ring, irq_src, irq_type);
+	if (r) {
+		dev_err(adev->dev, "failed initializing fences (%d).\n", r);
+		return r;
+	}
+
+	ring->ring_size = roundup_pow_of_two(max_dw * 4 * sched_hw_submission);
+
+	ring->buf_mask = (ring->ring_size / 4) - 1;
+	ring->ptr_mask = ring->funcs->support_64bit_ptrs ?
+		0xffffffffffffffff : ring->buf_mask;
+
+	/* Allocate ring buffer */
+	if (ring->ring == NULL) {
+		ring->ring = kzalloc(ring->ring_size + ring->funcs->extra_dw, GFP_KERNEL);
+		if (!ring->ring) {
+			dev_err(adev->dev, "(%d) swring create failed\n", r);
+			return r;
+		}
+
+		amdgpu_ring_clear_ring(ring);
+	}
+
+	ring->max_dw = max_dw;
+	ring->hw_prio = hw_prio;
+
+	if (!ring->no_scheduler) {
+		hw_ip = ring->funcs->type;
+		num_sched = &adev->gpu_sched[hw_ip][hw_prio].num_scheds;
+		adev->gpu_sched[hw_ip][hw_prio].sched[(*num_sched)++] =
+			&ring->sched;
+	}
+
+	return 0;
+}
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
+
+void amdgpu_sw_ring_fini(struct amdgpu_ring *ring)
+{
+	BUG_ON(!ring->is_sw_ring);
+
+	/* Not to finish a ring which is not initialized */
+	if (!(ring->adev) ||
+	    (!ring->is_mes_queue && !(ring->adev->rings[ring->idx])))
+		return;
+
+	ring->sched.ready = false;
+
+	amdgpu_device_wb_free(ring->adev, ring->cond_exe_offs);
+	amdgpu_device_wb_free(ring->adev, ring->fence_offs);
+
+	kfree((void *)ring->ring);
+
+	dma_fence_put(ring->vmid_wait);
+	ring->vmid_wait = NULL;
+	ring->me = 0;
+
+	ring->adev->rings[ring->idx] = NULL;
+}
+
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
new file mode 100644
index 000000000000..c05d8a94ad0c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sw_ring.h
@@ -0,0 +1,48 @@
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
+int amdgpu_sw_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *sw_ring,
+		     unsigned int max_dw, struct amdgpu_irq_src *irq_src,
+		     unsigned int irq_type, unsigned int hw_prio,
+		     atomic_t *sched_score);
+void amdgpu_sw_ring_fini(struct amdgpu_ring *ring);
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

