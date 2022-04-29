Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C02C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68A2610F140;
	Fri, 29 Apr 2022 17:46:45 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEC8210F126
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:46:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cSf6Ee+L7aq6nF1KW38GrWgUYMnRzdPILfHQN92XUBGDvkEi6P4f72bczksWVc80+BRItnAMVpb+O9/R5IM7Cr+Y8PXfvADwd5p1XwrEhdU56m668q3AabCXx8yRXdPC6qBjcGUBlD8untXHSHrDXvZe2M5onOC3q9MvVLSrEbjA7EN4Zba37P6tr675Cgm0nskD+ssGtGTzz5dI81Z8fAmPYXjJ2zvsLLBBMvz4nSA/3Ri5srhXK/a7CRSl7q4/HCbj+Xz6u7S49o5yAhGx6NyZ9lQTHbx61bVOCmo4TJTKyHk8Vs08DprBeXNTDS7fy/NBQ4XFzbgyYK9otIA9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6jWxGlgEfKoy8s4YZysoGHr+qy4GvagyKQmrMiWEng=;
 b=eJ3URco/OA1CihT0vYzSGrNxYTHVG2ZftWt9JMOVWN7Mx859AaKYdDgFBiU8e3NCfI/xGC+g4OCMP1x0IKHjN+2wOw8QhRhNulP/uNj0xA6jif/N8FE+2DsCIOythcVQ3CYvoxvojn9D5CUPV1pL3u4Wtvqsbcuce3+i/REf5uJmu4r+TmtCY/23h+PUd6uv/U/JlN/Rs0A1oWSenabCnX/QfXbV2wwzUHY8aTW1XG1Fu4Fr13Qji5cI7MU+6sCXZdw49X643CylHIEE2gyhLfqYe/BdOWLS6cT4hvRxmaEArWJWDDbYaXJUSJ9u8hRKy+n22e0qTVaHydn8dL+nqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6jWxGlgEfKoy8s4YZysoGHr+qy4GvagyKQmrMiWEng=;
 b=f8y7e4WMCSgy5s5V7z+aLjcrpSzu2/JUGP4+2k5k5HLPMC/OX2hiGWRQyKcvpfYUU13/ivnhuN5wOV3UKg6qzZ3OYDd/KqyN3MznzUpaj68uUSJu2C58Z1Te6z7U2zDbAHNu9LARwWJpJifPUQKTPV0x1Pit6OADewLGObkTdJw=
Received: from DM5PR08CA0026.namprd08.prod.outlook.com (2603:10b6:4:60::15) by
 DS7PR12MB6168.namprd12.prod.outlook.com (2603:10b6:8:97::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 17:46:39 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::37) by DM5PR08CA0026.outlook.office365.com
 (2603:10b6:4:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:46:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:38 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/73] drm/amdgpu: add the per-context meta data v3
Date: Fri, 29 Apr 2022 13:45:14 -0400
Message-ID: <20220429174624.459475-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35d3332c-b651-40fd-d03e-08da2a0836e6
X-MS-TrafficTypeDiagnostic: DS7PR12MB6168:EE_
X-Microsoft-Antispam-PRVS: <DS7PR12MB6168A188178ED8C1F0C8E46EF7FC9@DS7PR12MB6168.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GQrOyYjJHXZyNBHjqKlafAcnCJB2b6J20cKqBQ83oHhsiP8YxkNA36j8ZnkghPyGkyHbdYkNtmz+mhgxf0KWDH5YIjX8+ztQx0ZMyHzLtpJsMQm6oQkMzRA/cKOvSe1z4/PJ+60KThyJrIuiB3OBooT3hMGfSOwmOZHmO4ex/BJhfc/lglc0zzqIr/Eap3XCxRJWgEDUUWDOuRkBOqzwwXfTN7PIiH5jr+YgwBi3f5RVcsDkXZE66X2yj3iDpkLqobhRRMkkW4geB77/RNtbokxuaj2d9ZjWoKBcxsHx6zEgGMErB4dFp4ZD02pNyF8j6HbA4M8mkmLvPx55KcZGANC+fAo9QsCXfTP/ELMdRY1uehTHIprp4bBXU2iZVZbCiDm8yl/oOzzq+sHwvxDAgeiFnLTGcdXJMMD1h6j/sJimYuMwhBoF/ijYRBeW6GvmKK0JesEI/tpRwhJDmm39oqGajfJK+sXWDAQXcaz7HoYZeLtCu0YqXbmxnEcGSAihXCQ53/GBXiuq74Owv6ujrfGPE+ELV9IV4fIk6egRVRX0dUUlmh6XGhbdE2W0QCit8F9yLvUIZLEOV4+3PLOOvbgL61hCy3hm5Z5ziWsErXUNfArO9hg2qiwDIUA5TldMSIdcur62+v4gdcIJ8oel2SVd1DJC9xxHED5oa7WvY3EFhIDXvFVmoAG/hdPRfNAjmduHR07Jc42qmM6jYFbJSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(36860700001)(5660300002)(8936002)(2906002)(508600001)(40460700003)(82310400005)(54906003)(36756003)(66574015)(47076005)(316002)(83380400001)(336012)(6916009)(426003)(4326008)(8676002)(2616005)(6666004)(1076003)(186003)(70586007)(70206006)(16526019)(86362001)(7696005)(26005)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:46:39.4297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d3332c-b651-40fd-d03e-08da2a0836e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6168
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

The per-context meta data is a per-context data structure associated
with a mes-managed hardware ring, which includes MCBP CSA, ring buffer
and etc.

v2: fix typo
v3: a. use structure instead of typedef
    b. move amdgpu_mes_ctx_get_offs_* to amdgpu_ring.h
    c. use __aligned to make alignement

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h | 118 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |   9 ++
 3 files changed, 128 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2eed9479e854..24bce7e691a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -91,6 +91,7 @@
 #include "amdgpu_dm.h"
 #include "amdgpu_virt.h"
 #include "amdgpu_csa.h"
+#include "amdgpu_mes_ctx.h"
 #include "amdgpu_gart.h"
 #include "amdgpu_debugfs.h"
 #include "amdgpu_job.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
new file mode 100644
index 000000000000..f3e1ba1a889f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes_ctx.h
@@ -0,0 +1,118 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_MES_CTX_H__
+#define __AMDGPU_MES_CTX_H__
+
+#include "v10_structs.h"
+
+enum {
+	AMDGPU_MES_CTX_RPTR_OFFS = 0,
+	AMDGPU_MES_CTX_WPTR_OFFS,
+	AMDGPU_MES_CTX_FENCE_OFFS,
+	AMDGPU_MES_CTX_COND_EXE_OFFS,
+	AMDGPU_MES_CTX_TRAIL_FENCE_OFFS,
+	AMDGPU_MES_CTX_MAX_OFFS,
+};
+
+enum {
+	AMDGPU_MES_CTX_RING_OFFS = AMDGPU_MES_CTX_MAX_OFFS,
+	AMDGPU_MES_CTX_IB_OFFS,
+	AMDGPU_MES_CTX_PADDING_OFFS,
+};
+
+#define AMDGPU_MES_CTX_MAX_GFX_RINGS            1
+#define AMDGPU_MES_CTX_MAX_COMPUTE_RINGS        4
+#define AMDGPU_MES_CTX_MAX_SDMA_RINGS           2
+#define AMDGPU_MES_CTX_MAX_RINGS					\
+	(AMDGPU_MES_CTX_MAX_GFX_RINGS +					\
+	 AMDGPU_MES_CTX_MAX_COMPUTE_RINGS +				\
+	 AMDGPU_MES_CTX_MAX_SDMA_RINGS)
+
+#define AMDGPU_CSA_SDMA_SIZE    64
+#define GFX10_MEC_HPD_SIZE	2048
+
+struct amdgpu_wb_slot {
+	uint32_t data[8];
+};
+
+struct amdgpu_mes_ctx_meta_data {
+	struct {
+		uint8_t ring[PAGE_SIZE * 4];
+
+		/* gfx csa */
+		struct v10_gfx_meta_data gfx_meta_data;
+
+		uint8_t gds_backup[64 * 1024];
+
+		struct amdgpu_wb_slot slots[AMDGPU_MES_CTX_MAX_OFFS];
+
+		/* only for ib test */
+		uint32_t ib[256] __aligned(256);
+
+		uint32_t padding[64];
+
+	} __aligned(PAGE_SIZE) gfx[AMDGPU_MES_CTX_MAX_GFX_RINGS];
+
+	struct {
+		uint8_t ring[PAGE_SIZE * 4];
+
+		uint8_t mec_hpd[GFX10_MEC_HPD_SIZE];
+
+		struct amdgpu_wb_slot slots[AMDGPU_MES_CTX_MAX_OFFS];
+
+		/* only for ib test */
+		uint32_t ib[256] __aligned(256);
+
+		uint32_t padding[64];
+
+	} __aligned(PAGE_SIZE) compute[AMDGPU_MES_CTX_MAX_COMPUTE_RINGS];
+
+	struct {
+		uint8_t ring[PAGE_SIZE * 4];
+
+		/* sdma csa for mcbp */
+		uint8_t sdma_meta_data[AMDGPU_CSA_SDMA_SIZE];
+
+		struct amdgpu_wb_slot slots[AMDGPU_MES_CTX_MAX_OFFS];
+
+		/* only for ib test */
+		uint32_t ib[256] __aligned(256);
+
+		uint32_t padding[64];
+
+	} __aligned(PAGE_SIZE) sdma[AMDGPU_MES_CTX_MAX_SDMA_RINGS];
+};
+
+struct amdgpu_mes_ctx_data {
+	struct amdgpu_bo	*meta_data_obj;
+	uint64_t                meta_data_gpu_addr;
+	struct amdgpu_bo_va	*meta_data_va;
+	void                    *meta_data_ptr;
+	uint32_t                gang_ids[AMDGPU_HW_IP_DMA+1];
+};
+
+#define AMDGPU_FENCE_MES_QUEUE_FLAG     0x1000000u
+#define AMDGPU_FENCE_MES_QUEUE_ID_MASK  (AMDGPU_FENCE_MES_QUEUE_FLAG - 1)
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 20dfe5a19a81..112c2b0ef0b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -364,6 +364,15 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
 	ring->count_dw -= count_dw;
 }
 
+#define amdgpu_mes_ctx_get_offs_gpu_addr(ring, offset)			\
+	(ring->is_mes_queue && ring->mes_ctx ?				\
+	 (ring->mes_ctx->meta_data_gpu_addr + offset) : 0)
+
+#define amdgpu_mes_ctx_get_offs_cpu_addr(ring, offset)			\
+	(ring->is_mes_queue && ring->mes_ctx ?				\
+	 (void *)((uint8_t *)(ring->mes_ctx->meta_data_ptr) + offset) : \
+	 NULL)
+
 int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
 
 void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
-- 
2.35.1

