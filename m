Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6BF1073CA6
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Apr 2026 12:54:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1611210E642;
	Wed,  8 Apr 2026 12:54:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YrBTkZ3s";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A780410E641
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Apr 2026 12:54:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvUviUq3Ljteat9TazPdT8BrFFlY5g11KdeVXkgsPV3Cd39O2gqCeode+dmLs0d8QYofagblmRzUDsXQc1PmDflfywxfFKLes3lYY7lhL3AHmZYP0IvjXEiL4XPyQjFcWbj+9GoZ1OTq+R5NeYbZP792MSmfZMkcea0af47LN30Cu6AshIYos0fuifLg93NwmZkPW6121fPH6J9FXZ4A1U441eKGq+QqghmdJEqmY6RYWKPl1NkJWxDNmLTnNNFLLaXYJdSBONrlOf7x0ZRcnJ9Nyg9cyjgtJ8HvX2MUweMUuUlwYBB2xv50v/cZ85s3L4uY1mXyg48NrqyAgN3J5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtAaqcb5ZS2JL3bPm7D4WU+bWLatV3LsPIgUAks3L1c=;
 b=rtq7cdJiLzAjGmiudnCc50xcBmoyYn1g46Qs8lmujCKK3k2KvW/167xzTMqiq8vvnEYuOm1dle77o7IwnpsTU+dC70gdHxBAag4VM83037gIV89MGOoETZXOvzQ+9YUjpdWeSUG32hrdD4OlbdnUmM+rQlocn+WB5aic6UlrZVw/c2MUGmPp+YUncYPPDmG1FvrtWnrl0t9kTn7Rr9DCrTPWKNoduvTkeKjdR0afU0yWUhO3UgEuVnhlMhvvgrBwh6lGwBf0ErgXVDsTeWMSznlnWmvLseJe3rNNNNFogyrj9D+xV35nQmVAT63ZjQAMd9mAoYMsjw5LPGqWQ0UEiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtAaqcb5ZS2JL3bPm7D4WU+bWLatV3LsPIgUAks3L1c=;
 b=YrBTkZ3so1PRpCCi1ViB+4ZfeBQVtsUEJLdwdO50EcJbEKX0nGk+PM6X/BTl5eK+a8M1HerdTo2AUF1MxzODZjbT13KNxdeHWf5lr+WDydS6gZyMAriQFzB2MKQBSWwt0rjwCxTYkr22xtHfOK/+LY32TjEerO4HQwGcrME6NiM=
Received: from CH5P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::18)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Wed, 8 Apr
 2026 12:54:41 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:1f2:cafe::f1) by CH5P221CA0024.outlook.office365.com
 (2603:10b6:610:1f2::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.33 via Frontend Transport; Wed,
 8 Apr 2026 12:54:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 8 Apr 2026 12:54:41 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Apr
 2026 07:54:40 -0500
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 8 Apr 2026 07:54:40 -0500
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Leo Liu
 <leo.liu@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: "David (Ming Qiang) Wu" <David.Wu3@amd.com>, Ruijing Dong
 <ruijing.dong@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v3 3/3] drm/amdgpu/vcn: Factor out vcn_v{3,4}_0_dec_msg
Date: Wed, 8 Apr 2026 08:54:26 -0400
Message-ID: <20260408125426.2118644-3-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408125426.2118644-1-benjamin.cheng@amd.com>
References: <20260408125426.2118644-1-benjamin.cheng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 735f92c6-64ba-4da6-ed46-08de956e0031
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: S0qrBoCoVJEu5YuqnoDMmwsGK+vBF75+3dm3NEdq8auP5WWW9CVFGA0Nc5JTZcWOAiTAxFEpM4u9rEac2mqTFM91bxsQx2rhAZ8h7aShecKs4RlMZunUcpHaywxtr1Y05g82Mh29dfTiBnZLs3oVN5w08GGUrb2oIRfI2/dNV4UNqqnyE0AIOnOGD5yuJ2s48gmR9QAooxnn/reTxoD0Vqep7O1qCH6EnAYkbhdzQNpHS10oF5uNQIdPlHxykh7MslR1sEqoSkrESmnJgbzAYt7Fkt18pm9UW3Z4T8SqzGZhqhhtY03m7PPFSysSQVao6nIsoVVYi3XopT1JrNYMzeUw4UjEbxGohQpjwX40ECtOgMf9rCaowa8QYjJSqrUKFpGICXzuR6kZ3Fta+7nXO+7Aa/WGj8Lbq2bGEIYAeGlx4y4iABC7fibp+39Vr9sL12WknD5jDO+Mm934q4X6k7EnM68eJEsOuv3LCdHGmOP6hq26JhdJcuVj0iokpl0VruTGzkRhBu33mdoH2iikgM3G1xvRsm2Pz23xumSrT/WYZ/RWh/Qb+w70XWEf0Mjzuh4bVRIlDcQImiV8b/vgWoG/AWaSpwRnXeqRou2rMPh931DRJoNGiuRqn3ySNh3KhIf3wLT5di5E4Oq7nxqkwFvuzZOhc3fUPxiNuwQyQtKkT+w/Dgr0T0XfhFgWHqzNmHPrWeYzuuGhKXkowwxpEyFWpIFxiUYtZCKe0EusJfw0SbhmhwM8jViHCb5iDIb9cQhV+ILnpoTns5ytfbpLWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fG9TMWoDDcz9kiCdRX1Hz55QttZjaZ6wzOkbMA8LmUmF8+Hlv4F0kElp1exct77M5NrCFQFnskPjfohW1NCgL0rTggltRcGolYJjGwlC+ivYiS+CijNWT0OMVj+4fqLDt7I3KldQgqrZCyjiO6jnddvxGqMvUZ5KH1Yo7pjQq5AO5jZzluR8QJQyvI2qGwihy1Fn6xB/TieEhWHboPxbABH8X9L0ySfPVfWHDNKSiJVw+fwCKoJhIC+Vw5k4nIDmqEGU+/Rb/Q71vq1nvAMi4N3tIO/U4QJeKw2njOTY+oyXprTy6CICk9xGv7siVIBuN8YlwgY4pd6HdrHkX2u0ONXfO1Aso5L8z91A2Msz39K7cvrWUTn8uCd99YE5HanwYjsm0EyvFf/8taAwwyjA9OjWXtJnrRdIO00sWrJ6LaG0th9NVvU45VWd5Gp4X+K8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 12:54:41.4866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 735f92c6-64ba-4da6-ed46-08de956e0031
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813
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
index e72687246235..ad6ca7aa74bd 100644
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

