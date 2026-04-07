Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91402FF5136
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 20:05:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2657D10E4A7;
	Tue,  7 Apr 2026 20:05:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qd0hN6Fs";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011014.outbound.protection.outlook.com [40.107.208.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91BD010E4A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 20:05:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=knPg1ZoPMJQGcQ8gthcH/d0FQiNOHUPmqdfk7++tC/SMGT+CJ+GxHQJn08kA+lMO21TyLZzOMXuBbUPfFkiOy87UBnJx3rngOiPY3uAHVfCVEDpomt8hISJ+VR+LF1J+HRVuPR/LJJRahuGVAAU1MuaEpffwpKHDZmUsEiBDuKk6VZy1FE9du7KqLR4rA1biWnprlSrDN+bbdp31EK1n/2xx4SsTDXbQPcU12M5nhG4oqZSr00OpLuVHzZwTX/+Wux3yuZIZoWC6+Docg4kjPj0t6o1TmNlaE8lONXojRYQO7gpbciUmyxc8mBVLxBFjzttayOiFEX1kke8PPh3pmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VdUSNx/z1m0o4wQEk/Il1ASFwSKBUM5WRDXDaGdSUc=;
 b=vg+2Wjc4JDxuv8zzAIdciqUK0v0S4Y48KxKGmLlA57xpJFreL8W+9xlaGwH2TFofbby82AJnFjHnEUF0+HQXO5lgbYMyJ/5EwXwTZFAMQwPpD1b/CWizKulzi0tuUFqWkp4iq2+Aa6smS1S11dzFCtJVD+rBydjbg00EK9nD2y5lzEqUp5jNmIOzhdpr63AV+Cs7Z4AHtQpjAlL7XvLoAfxA9vgvhAqv1E5p+R6DtvLR14IpyKHe+Npj3UOKedRy1T2fCfrC9/Ic+WTWrJpTnEXtR7aTz9fersrz09uD5sVQKEAJczRtrrv/eeHPmcm/XqWBoxNAAV/ayImx09Buew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VdUSNx/z1m0o4wQEk/Il1ASFwSKBUM5WRDXDaGdSUc=;
 b=Qd0hN6FsHDnnp4DJ7/ClZW6OgNEDtXqFvCU/epyzjPaj6ZTi6NknTMiUAeUFoZgFC/HAlAnXzUO/yxaQGnCl9pVmKOvwPqMPHlbvUnEJ5dy1JyMhfDlPMpUkfBg/Az8hdzsV/sieVqu0sKFu5kvlDWPk6eAifKe+sRfbafZb6a0=
Received: from BY3PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:39b::34)
 by MN2PR12MB4470.namprd12.prod.outlook.com (2603:10b6:208:260::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 7 Apr
 2026 20:05:33 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::30) by BY3PR05CA0059.outlook.office365.com
 (2603:10b6:a03:39b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Tue,
 7 Apr 2026 20:05:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 20:05:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 7 Apr
 2026 15:05:32 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 7 Apr 2026 15:05:31 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Date: Tue, 7 Apr 2026 16:05:18 -0400
Message-ID: <20260407200518.911117-1-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|MN2PR12MB4470:EE_
X-MS-Office365-Filtering-Correlation-Id: 025f4fef-7fa5-4406-eec1-08de94e106a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: EWU1Mqgn+/TjXj14BHfFEK6DBiJcxnacKcy12RtlVfDxfrIXpAgXDFwcHeuz9K2EuLrL/dOQ2JWQek/SrwFua8GD7qvJjAD0BVyraVurBz3ULiBiUNteTU3Y4YNcwcJULV9gF4tIooDwqO/buy2Ho5Y/fNVaXwAgh71d2P/cYIDJ0icaQJB86ZJL9CQ5KGb/dK89m868VQZwsfM4REeevbECXW2/XfH7dzGM6ETNE9tUhBKm5GyWCFlDHBF/cz0gkVgiY3mnjpqIKjUsJ1dlfJ3AoQs83fVXAAV6810SSiMkQ6ijIBY8pD6gOA4VgqNmqoCQG45w5rONqQzJrHkpUa/9ukIAy1cNs4OkFdE/A53Lb+mYelCzYMXA6G7PQRktdCm3b/p02B5nVod4WsgVT94U/+DMLLZorJQoQFmJuCePSHDWSNrNrwYvaWdHtNGlkOooi1UXv8BB9VcNatqNaIQ4wKoK5XKUBR3xoB34zPjjL7S2fbynaBMc9VjcXbsrrqjWdq1FB59XR8hbDMnXW+3xXgPDRlBHcYuCHNWe7uqqkkhbCPfVm7GPyDMNkMzTzG7L3Fvn6FG0G9uCZF1HEkOZOvHjahjIb5u9n88vxjVlWC7IX/nVrn2+z2mZax6oBsuZcMswWcXDnTA7r8TZXNYhZSdnUSy+vDRavzS9ORYXlBZGKEsvTUD7trnNC8VGyZbYGzJp/i72AZBG4PSJP/LE2dsS5JgdhcMJ6ziIm1b5ghUsaIq7ejYcnJyWlEvoVka5Hjk7UyMtlcnijfP1gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dj2Dh0RWU/kjG0e2nk4iIHkg9dakk8pobnGjD2n6/qxcBANeHmN7Tyl3VB9kR8w21v5EX6me68VETbkgUxEHkmNXJ7RvVCRl5Du7HaacxobIJbXOUjHmvXMtkgkXsVMrsk5p8EH2yPnKOf8O64dbgpdMJdOgDqV0Z0rArxgANiDLk/lYGcxGe2r70GM530ktXAa2CY1D25Pnya/PfVn0WjEzAjUlpt6rvi6cHUBeMf3DloZs0L8FokftJv9wa/qZHUTmK+4jwuaMccN9vxwLZdeyRuzwTv3oqlQ0CwjoAB8p5WrK7xu5GLqMHN13hAJpyIy2zBcFyG2DFPKYZTDhFAgF4V9d8L5wmrXfvKgm3UwywriBwbVTXeDVbEOuPglSMmY4HXOED+sXbfIr48wJMLlhQ+fKAQiEFOOFT8wwd0cL5pda/CjooIM2T3RfU5ef
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 20:05:33.1761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 025f4fef-7fa5-4406-eec1-08de94e106a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4470
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

Both vcn_v3_0 and vcn_v4_0 use the same interface, so unify the code.

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 103 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   5 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 105 +-----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 104 +----------------------
 4 files changed, 112 insertions(+), 205 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 03d95dca93d7..910dd5bd1ab6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -36,6 +36,9 @@
 #include "amdgpu_vcn.h"
 #include "soc15d.h"
 
+#define RDECODE_MSG_CREATE		0x00000000
+#define RDECODE_MESSAGE_CREATE		0x00000001
+
 /* Firmware Names */
 #define FIRMWARE_RAVEN			"amdgpu/raven_vcn.bin"
 #define FIRMWARE_PICASSO		"amdgpu/picasso_vcn.bin"
@@ -1641,3 +1644,103 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_prin
 		}
 	}
 }
+
+int amdgpu_vcn_dec_msg_limit_sched(struct amdgpu_cs_parser *p,
+				   struct amdgpu_job *job, uint64_t addr,
+				   int (*limit_sched)(struct amdgpu_cs_parser *,
+						      struct amdgpu_job *))
+{
+	struct ttm_operation_ctx ctx = { false, false };
+	struct amdgpu_device *adev = p->adev;
+	struct amdgpu_bo_va_mapping *map;
+	uint32_t *msg, num_buffers, len_dw;
+	struct amdgpu_bo *bo;
+	uint64_t start, end;
+	unsigned int i;
+	void *ptr;
+	int r;
+
+	addr &= AMDGPU_GMC_HOLE_MASK;
+	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
+	if (r) {
+		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
+		return r;
+	}
+
+	start = map->start * AMDGPU_GPU_PAGE_SIZE;
+	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
+	if (addr & 0x7) {
+		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
+		return -EINVAL;
+	}
+
+	if (end - addr < 16) {
+		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
+		return -EINVAL;
+	}
+
+	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	if (r) {
+		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
+		return r;
+	}
+
+	r = amdgpu_bo_kmap(bo, &ptr);
+	if (r) {
+		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
+		return r;
+	}
+
+	msg = ptr + addr - start;
+
+	if (msg[1] > end - addr) {
+		DRM_ERROR("VCN message header does not fit in BO!\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	if (msg[3] != RDECODE_MSG_CREATE)
+		goto out;
+
+	len_dw = msg[1] / 4;
+	num_buffers = msg[2];
+
+	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
+	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
+		DRM_ERROR("VCN message has too many buffers!\n");
+		r = -EINVAL;
+		goto out;
+	}
+
+	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
+		uint32_t offset, size, *create;
+
+		if (msg[0] != RDECODE_MESSAGE_CREATE)
+			continue;
+
+		offset = msg[1];
+		size = msg[2];
+
+		if (size < 4 || offset + size > end - addr) {
+			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
+			r = -EINVAL;
+			goto out;
+		}
+
+		create = ptr + addr + offset - start;
+
+		/* H264, HEVC and VP9 can run on any instance */
+		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
+			continue;
+
+		r = limit_sched(p, job);
+		if (r)
+			goto out;
+	}
+
+out:
+	amdgpu_bo_kunmap(bo);
+	return r;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index 82624b44e661..64f27de1a6f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -570,4 +570,9 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_prin
 void amdgpu_vcn_get_profile(struct amdgpu_device *adev);
 void amdgpu_vcn_put_profile(struct amdgpu_device *adev);
 
+int amdgpu_vcn_dec_msg_limit_sched(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
+				   uint64_t addr,
+				   int (*limit_sched)(struct amdgpu_cs_parser *,
+						      struct amdgpu_job *));
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6fb4fcdbba4f..38a4fcf5872e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -58,9 +58,6 @@
 #define VCN_INSTANCES_SIENNA_CICHLID				2
 #define DEC_SW_RING_ENABLED					FALSE
 
-#define RDECODE_MSG_CREATE					0x00000000
-#define RDECODE_MESSAGE_CREATE					0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_3_0[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, mmUVD_STATUS),
@@ -1903,104 +1900,6 @@ static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
-			    uint64_t addr)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	struct amdgpu_device *adev = p->adev;
-	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers, len_dw;
-	struct amdgpu_bo *bo;
-	uint64_t start, end;
-	unsigned int i;
-	void *ptr;
-	int r;
-
-	addr &= AMDGPU_GMC_HOLE_MASK;
-	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
-	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08Lx\n", addr);
-		return r;
-	}
-
-	start = map->start * AMDGPU_GPU_PAGE_SIZE;
-	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
-	if (addr & 0x7) {
-		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
-		return -EINVAL;
-	}
-
-	if (end - addr < 16) {
-		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
-		return -EINVAL;
-	}
-
-	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
-	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (r) {
-		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
-		return r;
-	}
-
-	r = amdgpu_bo_kmap(bo, &ptr);
-	if (r) {
-		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
-		return r;
-	}
-
-	msg = ptr + addr - start;
-
-	if (msg[1] > end - addr) {
-		DRM_ERROR("VCN message header does not fit in BO!\n");
-		r = -EINVAL;
-		goto out;
-	}
-
-	if (msg[3] != RDECODE_MSG_CREATE)
-		goto out;
-
-	len_dw = msg[1] / 4;
-	num_buffers = msg[2];
-
-	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
-	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
-		DRM_ERROR("VCN message has too many buffers!\n");
-		r = -EINVAL;
-		goto out;
-	}
-
-	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
-		uint32_t offset, size, *create;
-
-		if (msg[0] != RDECODE_MESSAGE_CREATE)
-			continue;
-
-		offset = msg[1];
-		size = msg[2];
-
-		if (size < 4 || offset + size > end - addr) {
-			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
-			r = -EINVAL;
-			goto out;
-		}
-
-		create = ptr + addr + offset - start;
-
-		/* H264, HEVC and VP9 can run on any instance */
-		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
-			continue;
-
-		r = vcn_v3_0_limit_sched(p, job);
-		if (r)
-			goto out;
-	}
-
-out:
-	amdgpu_bo_kunmap(bo);
-	return r;
-}
-
 static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
@@ -2024,8 +1923,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 			msg_hi = val;
 		} else if (reg == PACKET0(p->adev->vcn.inst[ring->me].internal.cmd, 0) &&
 			   val == 0) {
-			r = vcn_v3_0_dec_msg(p, job,
-					     ((u64)msg_hi) << 32 | msg_lo);
+			r = amdgpu_vcn_dec_msg_limit_sched(p, job, ((u64)msg_hi) << 32 | msg_lo,
+							   vcn_v3_0_limit_sched);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 5dec92691f73..41215ad7dfac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -50,9 +50,6 @@
 
 #define VCN_HARVEST_MMSCH								0
 
-#define RDECODE_MSG_CREATE							0x00000000
-#define RDECODE_MESSAGE_CREATE							0x00000001
-
 static const struct amdgpu_hwip_reg_entry vcn_reg_list_4_0[] = {
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_POWER_STATUS),
 	SOC15_REG_ENTRY_STR(VCN, 0, regUVD_STATUS),
@@ -1820,104 +1817,6 @@ static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int vcn_v4_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
-			    uint64_t addr)
-{
-	struct ttm_operation_ctx ctx = { false, false };
-	struct amdgpu_device *adev = p->adev;
-	struct amdgpu_bo_va_mapping *map;
-	uint32_t *msg, num_buffers, len_dw;
-	struct amdgpu_bo *bo;
-	uint64_t start, end;
-	unsigned int i;
-	void *ptr;
-	int r;
-
-	addr &= AMDGPU_GMC_HOLE_MASK;
-	r = amdgpu_cs_find_mapping(p, addr, &bo, &map);
-	if (r) {
-		DRM_ERROR("Can't find BO for addr 0x%08llx\n", addr);
-		return r;
-	}
-
-	start = map->start * AMDGPU_GPU_PAGE_SIZE;
-	end = (map->last + 1) * AMDGPU_GPU_PAGE_SIZE;
-	if (addr & 0x7) {
-		DRM_ERROR("VCN messages must be 8 byte aligned!\n");
-		return -EINVAL;
-	}
-
-	if (end - addr < 16) {
-		DRM_ERROR("VCN messages must be at least 4 DWORDs!\n");
-		return -EINVAL;
-	}
-
-	bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
-	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
-	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (r) {
-		DRM_ERROR("Failed validating the VCN message BO (%d)!\n", r);
-		return r;
-	}
-
-	r = amdgpu_bo_kmap(bo, &ptr);
-	if (r) {
-		DRM_ERROR("Failed mapping the VCN message (%d)!\n", r);
-		return r;
-	}
-
-	msg = ptr + addr - start;
-
-	if (msg[1] > end - addr) {
-		DRM_ERROR("VCN message header does not fit in BO!\n");
-		r = -EINVAL;
-		goto out;
-	}
-
-	if (msg[3] != RDECODE_MSG_CREATE)
-		goto out;
-
-	len_dw = msg[1] / 4;
-	num_buffers = msg[2];
-
-	/* Verify that all indices fit within the claimed length. Each index is 4 DWORDs */
-	if (num_buffers > len_dw || 6 + num_buffers * 4 > len_dw) {
-		DRM_ERROR("VCN message has too many buffers!\n");
-		r = -EINVAL;
-		goto out;
-	}
-
-	for (i = 0, msg = &msg[6]; i < num_buffers; ++i, msg += 4) {
-		uint32_t offset, size, *create;
-
-		if (msg[0] != RDECODE_MESSAGE_CREATE)
-			continue;
-
-		offset = msg[1];
-		size = msg[2];
-
-		if (size < 4 || offset + size > end - addr) {
-			DRM_ERROR("VCN message buffer exceeds BO bounds!\n");
-			r = -EINVAL;
-			goto out;
-		}
-
-		create = ptr + addr + offset - start;
-
-		/* H264, HEVC and VP9 can run on any instance */
-		if (create[0] == 0x7 || create[0] == 0x10 || create[0] == 0x11)
-			continue;
-
-		r = vcn_v4_0_limit_sched(p, job);
-		if (r)
-			goto out;
-	}
-
-out:
-	amdgpu_bo_kunmap(bo);
-	return r;
-}
-
 #define RADEON_VCN_ENGINE_TYPE_ENCODE			(0x00000002)
 #define RADEON_VCN_ENGINE_TYPE_DECODE			(0x00000003)
 #define RADEON_VCN_ENGINE_INFO				(0x30000001)
@@ -1960,7 +1859,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 
 			msg_buffer_addr = ((u64)amdgpu_ib_get_value(ib, idx + 7)) << 32 |
 				amdgpu_ib_get_value(ib, idx + 8);
-			return vcn_v4_0_dec_msg(p, job, msg_buffer_addr);
+			return amdgpu_vcn_dec_msg_limit_sched(p, job, msg_buffer_addr,
+							      vcn_v4_0_limit_sched);
 		} else if (val == RADEON_VCN_ENGINE_TYPE_ENCODE) {
 			sidx = vcn_v4_0_enc_find_ib_param(ib, RENCODE_IB_PARAM_SESSION_INIT, idx);
 			if (sidx >= 0 &&
-- 
2.53.0

