Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCF21073CBA
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 13:51:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5DD710E66A;
	Wed,  8 Apr 2026 13:51:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G8Lkq2n1";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011039.outbound.protection.outlook.com [40.107.208.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90CC910E66A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 13:51:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bSqaJNg0QbcyKCFn4c/E38dt8w8WbyWCEKmS+hE06EyUagswvNeV/dRhwbsqlw784j80p+Y82Cd+ywbbmnSJHJnZOmHdBCJaPxgVrmDm7KfF2xtloVDR4BjqJqY0M/N2XGTLLKe7mo+0tYP7OFwA2PAE3RAsx0lTwO+5ikl7K4S8S1AvWgxJSpmbnS733NO3H5KG+/GPLBzESlKPo8s6S1HAK3z1qqdgcqPxwWpJ/fs90Q6cVQ5e/szdYTrJvNMA8ZIjNH5R2a6tOICnL1m6xpMSJ24j+gX8YEfAsbBa95AXdYifKUQWGi5Ofy92V73JpsvRi4IckVZUfOzwjrEElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qR0Jo+04ef3Mx83hGVhTjuTXs5Wx5o4fbHIKaGe4suk=;
 b=S5vKJiPdxzz7DvaSwUKuE9wIzJUZ6ey0uicGYXFL+mo/Rchy7JwQ9Md9E6EWy6BNAAF4LlQrOcEONYk/fiaurS6TX8t9CFmlantHGQXnCCwsZQCl2LmmrJ2UNIforQz8q5PX3PzrWeGu/Ivifo2ORLrQcxFZW9D+wHL6VBHyevlxNiTIVmqGlREBj3Hk+IBwg+cz6BpA96q/2SXKC+6GWaoAgw+J4l+QvzM66jbnnIlBMf8H4GjM2Ylbivus1CyA1wDFqgMi+GlmJXA4wAoM3ZD/CbYT/rAeSBjEG/7w9wBsQtkmvLYax7mME/QpJAdD8l6WVtmHwhKCT2niVkvFBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qR0Jo+04ef3Mx83hGVhTjuTXs5Wx5o4fbHIKaGe4suk=;
 b=G8Lkq2n1CQPwd7+GCWf9/xNLNxcvzRfvmEknK/vUUIhRVPFuiWeLr8D+y6lBi3npBhBWOCS7TXtZgkPh5KMhfJIIGePgIFGQf2Yx/2iWV/yBXOMtqWIaFI7VPAoTDwyh5PV55nIPQb7FIYGMSpNDMbr8E0XnyJyDWdhmK5wsAPg=
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by DM4PR12MB7526.namprd12.prod.outlook.com (2603:10b6:8:112::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 13:51:16 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::63) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.38 via Frontend Transport; Wed,
 8 Apr 2026 13:51:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 13:51:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 08:51:15 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 06:51:15 -0700
Received: from bencheng-dev (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 08:51:14 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v4 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Date: Wed, 8 Apr 2026 09:50:57 -0400
Message-ID: <20260408135057.2133928-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408135057.2133928-1-benjamin.cheng@amd.com>
References: <20260408135057.2133928-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|DM4PR12MB7526:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e981e1-6744-4e4a-a9cd-08de9575e76b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: 2lP+4pSIyCp8AxutApm6a+42W60CsD72i5pIbRzgddtsSk7uEiO3KbbJMWTGzZj3G5HGcoc2rTgORc8CNRHiCozgMNIqZQzu6dLoUwIFbq8TN63nlPM7/GvWMhXIRLmuBmUbNRhVi8m5Vlkyib4Z0h3aIQeyA4bmU+H5wfQSmRvS3vCeHoGyd6NWJqfmmQ2U5l4ARdt0f4/bSJy0kxVR0QA5dfzAfzef/ZjTeMVRJBW2G7ulTKUXCMb3FSt1wvW6G6GdVviJ0cV5cI/h+WDklAMaU3Qet7urZpWKwt7d8Kd7Pz/vySVHIcn+9shq0KzmiF1NXKtByrkOqM3zMx/TQ49D2K+S4D2v/1gdfFdI+11XthV5oe/m7iMejJ5eHLg2oBGJ6N1HgIz6Y9EEcPSfVI+6bElD7E4IEI2532AETtLHZVJc9tMB4nXM8z5fgJ0FnXG/50kmCZvnidRGdio8LmaKnc7hYyUxamdYIdaPn8kipP3K1FkHNkbp2xlj7DAGelMwdVM6vnuU5g5JTuzpHopNyCuwTd0m2BcHXD+OQtPkajpHIC/nDPQRpzdjdAHEwmn6Ex2ZQGY0DIslls/nEU3Nibj1ZpiAjNFfiqy4MUGH00LMDHuK49D2A5Iy02I/q0ulyEXabKpA9YhDozPB9U0aJ5tCyEWvTmXh1yxtcN0Kn8OfrCa0gcfDZR7C03pZ9bXIor3nqcZSWrgE/TlGQAfrypviJtiwRvRRXbvSEOD35ENHdNFtrHbbnbEuN3zGcVY1VXhIHz2BQJCdleRmPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rDXfrFlxf62sFhToPmy68e5shHVVNorORT57xEAiX9OwbvfvEfOd7J22V1154/YLJcqHLXLKZFc9Nh0GLsOAQ6sXiRv23xTGK2mk9t2zmQZgaBDDoF0du0jTfdbTzqPuOgKPVkCHHsaHxm9l5fguuVOZ1+TJc4TtDQgE/saQ9AHjanqAvCpGh9fR2FeIbTC1ufpWwNhS9mnXWjkirkEz7ykwn++tL8Dh4Z9dM356ETTLvQk0MnkPsF7IXgxKa61snzbL3YG32UmTDZJiv2eSSOlbjIGyUFo226IUUPfMDbKlugpje3HXbn3vJzKJexR8oSSJv1Ve+hTewtZroep0VobPHNQhZzevOaNZ34tSr8SF+29jsqphWm5qVqvUWCu8M38RIC10CN+gqUBpuqbNyOBE0GI84In2aCiGsxbIvfGpv+TgXhlECNBxNEtMZWGP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 13:51:15.8134 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e981e1-6744-4e4a-a9cd-08de9575e76b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7526
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
Reviewed-by: Leo Liu <leo.liu@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Ruijing Dong <ruijing.dong@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 100 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |   5 ++
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 102 +-----------------------
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 101 +----------------------
 4 files changed, 109 insertions(+), 199 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 03d95dca93d7..10aff7da52b6 100644
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
+	if (msg[3] != VCN_DEC_MSG_CREATE)
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
+		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
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
index 71a098d1eb8b..6c18368d007f 100644
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
index 64531ad56c48..38a4fcf5872e 100644
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
-	if (msg[3] != VCN_DEC_MSG_CREATE)
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
-		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
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
index a89e316a4add..41215ad7dfac 100644
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
-	if (msg[3] != VCN_DEC_MSG_CREATE)
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
-		if (msg[0] != VCN_DEC_MESSAGE_CREATE)
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

