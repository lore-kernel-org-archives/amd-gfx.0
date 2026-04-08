Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 791711073CA5
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:25:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DBDF10E456;
	Wed,  8 Apr 2026 12:25:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="intZ+9Qq";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012036.outbound.protection.outlook.com
 [40.93.195.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993C310E456
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:25:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LB+HQyr7AuMZZR5QcEJ1UC7wsCVGMEcSDnrz/k4m+gyN6ntvUyQgr4RV6VGuDt6y4TwBFObGsUNke3v6pXk0PybkjKnDDMdnkquyMsq0E7QE8AEbOEKsJND2iZvetepH+4KOSKcc0J3TtzoULrRGCZ+ec8KkWk6b8epbYjeGSHgad5l00vhFTNhrrZbZvnAdd3HSeRpm0Ydrg57OU5G9o9moDzQVQecF7bCsraCDy9xcmNcm9bxkCDPF6slu/0QjGwscSEYdj9QbWK4pC6Y6vU12ONF4cmYhTKmVgv9+P1HJGQMWu4FIjEiLw56KBUadi9oso+9Z3Q5NfvsYIf7DUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIYe4Wz4DwRNKeaVVrEvmIJAHw1Q8JhX0XEWme2O0bo=;
 b=WJ6fb/sOlbRjdIIu1wu7rEDCrmP1aEl6qWRKalsWcb2/19EmxgNafrnaEjh4WF3LaTtVPRNrXryoLR4+e09yQXwqUteT5APz3t8m7hNhPBdxZSO2RboHGRromq/PK5WvEdsAsMVKZpDI2ZmlF5UaT9XEBdJqCIxv3bMrx/Pdf8z4WgOgjiKzLw3nl4pB6Kufz5enCJwOQahW9EXnFnBAogXnlFd/lyZrEj4dMbXvKU/G9YqwLAEILBWA15ixisAkKDy0OiqENvGCp9q4SU3mBU7yrjwgWENKEcG9vGly1vP3Wp9oereKGbMZ0dZkiFM4ftSRsR9AlSpgXvcTgnOotQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dIYe4Wz4DwRNKeaVVrEvmIJAHw1Q8JhX0XEWme2O0bo=;
 b=intZ+9Qqybm1zUKav458y5zMuM5UJEy0luk3NBPmd6VBPgx9L9JneKQVjOpNlLia2Wp/1vj2oAZNf+mZlxub5nhFyMkZPNYOijP6pR40FcfZcEWbFaJyY71OaH+YvO8MjOZK4ipdLI+3fIWdEYKf2A5+ur/rJ28cgrAEDszmV1w=
Received: from CH5PR03CA0001.namprd03.prod.outlook.com (2603:10b6:610:1f1::29)
 by SN7PR12MB8171.namprd12.prod.outlook.com (2603:10b6:806:322::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Wed, 8 Apr
 2026 12:25:14 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::ae) by CH5PR03CA0001.outlook.office365.com
 (2603:10b6:610:1f1::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.37 via Frontend Transport; Wed,
 8 Apr 2026 12:25:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 12:25:14 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 8 Apr
 2026 07:25:14 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 8 Apr
 2026 07:25:13 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 07:25:13 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Date: Wed, 8 Apr 2026 08:24:56 -0400
Message-ID: <20260408122456.1787039-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408122456.1787039-1-benjamin.cheng@amd.com>
References: <20260408122456.1787039-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: benjamin.cheng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|SN7PR12MB8171:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d01cffe-a3d7-4e67-6012-08de9569e30d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QgxCxD65gdoY4w9rzNKkiw8SyvZdW9d4es6R3qCoVtT4ZqIqQrHcBu8NnEz252gIQGGJXRoe+28wXf2z2iMO3hJ0QhcUB1WkiMpZojlvtQgI6hYaoIOHjqvYHzakAuJSy0H0yyLXcgxFqnUGxJTG1liWLRKnotAGJxlSvMmBAcitv7vBIz8S0luPHtTExZbExDQymECaUHnObDSYAuK8KpvTGWi5HdD9LDLzmqbF0HTjPi5Dxlc4jH81OzlYvCKbF47H/GQzx0bm4vg//a6hbcWgHMA2zkBDdGt+NVmvSrCCC1eQds78dIRc7y40XzmWf2GDpuowj42kWm5OOsyQK1RDVDUQgQSDYGE6BgehfPMV+WnO8vp7+FRltMVF3VkI5+8gobTQoxZm/fuAJqifUhNN3okl3sk3ZyNLr8uky1PdhHW488VnG/4j39Gro3XRaBHS+rfDJcXWh6eQoiz+wTFeWxC3ZEEIJMDSdhIF3d2v2NtuYxZS8pSQugesU34DHb4d/9XxOB7G32CsSSnvVFVCgLoZ2mrRagiBs3MbJ5drfWIe3cZoDTxxlSTD80U5rw29RcKzUaxQygafxQX1QzW5phCpWsSYXASwFp+tYM0ykVm1BKbVJYniwrlaFTWejNPwkG7oLEImAQ9mjaKyiv0GWlmLdZfo1gd0rfjXucoJHRIviNgHxJw0RxiJxBnUXeopwzEtZGVEWFPCGCq+rIe8rFtNY5Q8IVtZ9o0lAodX8joSx1SYQQNUiPi6iXU7wfXDnHCMjN4dizg4Dy2Dzw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: k+OsE16rHKLf0zCGEDfdBNN80nUGW4DuhTw4MxFk7PALEsYRcWed1IVzi1beikC+qPhszxGwlpsBTKauoYvr2i1Mm2knQ2FC1WYbg5mk4Nl6m6HaKHI5c75B9CVjPtRJWiiuA3UnMj3rp6Ybjwp77A0Zn93jAb5sWCpHY9TcPtZaxSwjQdPg6t3Ogy0ApfHhAK6wN/7zaF34dxhN6c5WBxTPvPouPiwMrT5dAoc2Q9HIsPYgtMrz9GURqJeZ4Uu8gAlfmMuDvc0s3EeROPglycIvYn13Wl01LGnGe/mQixQFgrFJ2KjoFH6J6xd4tBRf8JvIL/OC3Vvae0Zev3W8VJc1mXtXuBux3wCh4GJEjMXcIaZYAuIH9bOsDSvHz+SJAcRmgxp2Xf65MOHBO5ZgQaOjax4zy4pV3BWwPZ/kN4h39ybKwqJEEHxJEQ0OGYVF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:25:14.6045 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d01cffe-a3d7-4e67-6012-08de9569e30d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8171
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
v2: Moved RDECODE_* defines to header in patch #1.

 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 100 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   5 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 102 +-----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 101 +----------------------
 4 files changed, 109 insertions(+), 199 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 03d95dca93d7..76d6b0071bd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1641,3 +1641,103 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_prin
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
index fd9657ae6c37..29ddd7bbc835 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -573,4 +573,9 @@ void amdgpu_vcn_print_ip_state(struct amdgpu_ip_block *ip_block, struct drm_prin
 void amdgpu_vcn_get_profile(struct amdgpu_device *adev);
 void amdgpu_vcn_put_profile(struct amdgpu_device *adev);
 
+int amdgpu_vcn_dec_msg_limit_sched(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
+				   uint64_t addr,
+				   int (*limit_sched)(struct amdgpu_cs_parser *,
+						      struct amdgpu_job *));
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 0e8eb4f671c0..38a4fcf5872e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1900,104 +1900,6 @@ static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
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
@@ -2021,8 +1923,8 @@ static int vcn_v3_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
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
index 00abac9c7fd7..41215ad7dfac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1817,104 +1817,6 @@ static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
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
@@ -1957,7 +1859,8 @@ static int vcn_v4_0_ring_patch_cs_in_place(struct amdgpu_cs_parser *p,
 
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

