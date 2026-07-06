Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5404EC43602
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 20:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFD4E10EAAA;
	Mon,  6 Jul 2026 20:06:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bc2ISLTq";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010061.outbound.protection.outlook.com [52.101.85.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7ED910EAA9
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 20:06:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UIEUVwAlFk9EfIUe/12OwzW/rX86mkh1rMFs/cq53tC72u31eDQ8UZS64K31K3XIQsx1vjc/FcIvvNhBZI0UlNc4n8R/bWMROSLa9bthvizsAXHq2bUlLoZ7tFoElxybQp4kPgCApO4w3h/2zSsdsUwgWq+AxkkwEwRvvKld7x2m9znfujy2XSRfB1iwLDegwWPGDoiNfH0A9CVnWSv4+K4oYHwHT0mHMRE+WidCAYsW/fkNomswUbodQjME0o8xqyHpT7meIXkER2us6EdW/6dsuCm8MiVVBXPQPvPbysTbcIyV6ppyBXO0HTD6Zh7xEeCot0/olv3Qsbn50ZaoOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EavqPT1Pg7fASU1jzjdxbHxmdeXnHfMJmvICytfLpxs=;
 b=X0QjxwUtdyWf5UYagi+5BfTUPxOkkLhrYufH+q6LoqZL9m+GQJwBvHLse6JoTQWFfhigrw51VsRNEJrZflT4CXlateWYR0jWl1QoQZhQUSFXtYVRr4PQwHaguSePWzfZpre+OLOjhqi9QKiXpDLvZ1F30jv185aTWraPGD8g6UbUUj96HgMsBlscn0afllPSQRvwohdB1s9J49506B7txAjjY+76n75J0bNoNVs8clTHIpzh3w3jlVJHdXObAFbVwTf23bQEsatMVBDBW4Ap0iLLVKeB/83EvtisiK5jIcPdlbyFcWjRAfFSHtrj8FA1UK8gxgXGqQg+ZFpFTXuw9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EavqPT1Pg7fASU1jzjdxbHxmdeXnHfMJmvICytfLpxs=;
 b=Bc2ISLTqSgFLpAfn6EoHMg2USs3lnQJ753NsPQe56Qq8mukcCrdmVZfhL4g9zDYv0aB1l5/ShOEMsLgUvqaRhtfJQ8JFuNmzeTtVDY6hQ3XJVRFlTkGI7gmvmx+HixFez8KTCsh5l3uTqreA64cOiwMKPHjzj+Dr38Q0jYL96c8=
Received: from BN9PR03CA0853.namprd03.prod.outlook.com (2603:10b6:408:13d::18)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Mon, 6 Jul
 2026 20:06:13 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:13d:cafe::5b) by BN9PR03CA0853.outlook.office365.com
 (2603:10b6:408:13d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Mon, 6
 Jul 2026 20:06:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.0 via Frontend Transport; Mon, 6 Jul 2026 20:06:13 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:12 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 15:06:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 6 Jul 2026 15:06:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/7] drm/amdgpu/sdma7.1: don't do MMIO in MQD init
Date: Mon, 6 Jul 2026 16:06:00 -0400
Message-ID: <20260706200600.15071-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706200600.15071-1-alexander.deucher@amd.com>
References: <20260706200600.15071-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|PH7PR12MB8056:EE_
X-MS-Office365-Filtering-Correlation-Id: 5508ffb6-ee9a-4be9-5808-08dedb9a0798
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nYCVE92DxFxCRCktShLeBIhJ9q73ezwev3noCqtv2NnVKb7FwuWIwCKPgp7vmAoxSuPcaFzZ527c0+UZB+4oczJEm8r6HGsSy5FNfeLBtelpCYFFxkXcT3P4OTKxd1lG+JM4s+VN93hSIQTbb79P2FpKd+6raweFofIGYoj6g5Zwctlp+ZPEURzEqCexGGz9RJbyxo5STj2UiXlBbWbwyUjYah6yT3XYfMZ7STgqubMCbI5Ke3SZ7vpXgY5/GMq5CLTOZrtzipes1HbQpPxcijp3i2+Zl2hhWbfkzIkmLwq4O7JkVkE4eqrgNwYV30mScQCEodPN6g3G5y3GvV6aXxPxjpKzA96lGGhSV5hkpsBLom2RlVJNn7ymcgn4uoSA612ZUKwjUoizCKsrpcHTbBwoY9BkBMmtKVqy+vZmtZ4P2O0qfCZPGvivgc/GeD1xP4n0Wj7rfGxlSZu7FDS/nSuFn1S5LDL/ByHmPO85TkGl69La9zxU0ybUMhpdUV1vOIBxf/wnd5NL+PX2iuqRpyaFR6TuxQEU7PWh/fkuocXFxUseDAb8glhwg3s1GG66Gugnq+XEHKsQWCsLecwTAJGIC5V9780vhG+/yMy/ISohbTJuXKVLy6UW3JVv7uBANnzCOpFumdsvrK/Tw6L8iv2R+dwbatQo3x6XGFZXd0Oxkda1RDx8RtQ5ZCWNyB1Qwu0RnPV+ExKSk8GB8qid3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4DafY0+EcVkk2qvfpfkCXbPqVBlz69psho656iC8mDBWGp6Fmzg+qdKlLRzz26KkrWWcpQcgoTbXpbWhnbbxSpwVSH21AXR6xmnADIC94wcQ4fEg36YaaP66IZk8/QXvB4/1OweDgBMeoeyEv12oBxEnWL805VUMQjkPyS//tFDGQEIpVm64XEixpgyCTYCg6iZ8ot/DKFwDUdj2fRjUJR8VTH/aTDUTvzz8hTeZbCH0YqJ5ctB6ZpgLJTVJBlJ3d3hE8tEUPiIO4ZpeF6TcLe+fZ5XbPAZHt/G/gqu/J6CGeO15kVpqSGGQc4iZg2TJ8axZKeTsBZG+BdUtzxlTE42uF+TlJw8IdRHFiLz/6dloBbm2wkA1LRY/ZXMZrmRSAsV5kfMJT83F1pR456zIhpfvT2yxFOYw9rORH4XxNSqNifbl3bCh7YzjapzGbMyI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 20:06:13.1609 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5508ffb6-ee9a-4be9-5808-08dedb9a0798
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
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

There's no need to read the register, just use the default
value.

Assisted-by: Claude:claude-opus-4.6
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
index 18366e16ef3fa..b71b8b0275ccf 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
@@ -871,8 +871,7 @@ static int sdma_v7_1_mqd_init(struct amdgpu_device *adev, void *mqd,
 	m->sdmax_rlcx_rb_rptr_addr_lo = lower_32_bits(wb_gpu_addr);
 	m->sdmax_rlcx_rb_rptr_addr_hi = upper_32_bits(wb_gpu_addr);
 
-	m->sdmax_rlcx_ib_cntl = RREG32_SOC15_IP(GC, sdma_v7_1_get_reg_offset(adev, 0,
-							regSDMA0_SDMA_QUEUE0_IB_CNTL));
+	m->sdmax_rlcx_ib_cntl = 0x00000100; //regSDMA0_QUEUE0_IB_CNTL_DEFAULT
 
 	m->sdmax_rlcx_doorbell_offset =
 		prop->doorbell_index << SDMA0_SDMA_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-- 
2.54.0

