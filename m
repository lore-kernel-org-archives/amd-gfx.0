Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03B0CD98DE
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2026 05:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 304E310EC8B;
	Thu, 18 Jun 2026 05:38:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kz339A+6";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011054.outbound.protection.outlook.com
 [40.93.194.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4E5E10EC8B
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2026 05:38:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVOjOsRvDACkRNiX55AF3d/cOBR3Eu+eQ56flGAJeG1ABoMyODFCtdgiEZZWIdDQ58D7KVSwgq0/l24Soxz4m7l/vlY6eQOfsUYR6CzbTCm2LVo74VYlBbg9MrVJ3vCByOvSbATnlWrX2MCdw/aXvzXfsXsBFiSpNWwGm+n+1NzJmFu07qPnLM1hIJ0z0p/2InG1CJznzb846yUoi45Mo+Hn2WytTL/sm0BjjYRNgb/kziVQ2lCdXxU1TrDCeC+e7INOXnkxNKUJg0fdyU5qSROPiLi0foqy/o3DD8AkufcVszBIwY1eMYu0KGwh/bdLzaP5r5pMqwzsp0IED0CjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=prZyQNue6iZxQLYrrWt8ekD+zf6sf+oyUFg/fUNcrac=;
 b=WCj8nfzk6RTqFIiv06kw8COI2cLkIgSIhi/pGebgfDgeZqgwnxVMUxrOsDnXRYNcYsbb+3OrEtOr/7Yy4BX0z4t4Jvz6L3WsFRvhTb9/B4+yrxZ2VeQlXsIqYwAv8dmW33UenVk4gyL2m5DZg3fk6RiIstXQx5WNyik2ZSShCWwRLzdMWa/BFLQRrxSaRbKhmasXB+IUu9M5N2uXeXUgzMtArFEvDceNljnu9aPfu4ZAj2p56nKy7KSHhyK0O5uNzcx3YajazZDYhLMTyE/VWTmqPQ2mvbtiBIcR25cg79aH2Xllvqqsl39hiiZ+IP5NX58Y3BiEPYsz8QJswPsxnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=prZyQNue6iZxQLYrrWt8ekD+zf6sf+oyUFg/fUNcrac=;
 b=kz339A+6VD3hOx1CvippEeOz5Q24XGbaAAB5H0M9/dJ5CxVy/qZBueQDU917AwhV5vpfmhwYEqbHKVoW/ufWmmCzmvNDXpeoRAguBD/wbLENoyzJKKElEKZf7g6PpMBWY7Fx1rY4LjYWHkCOD4PYPsLJoORPJN3K8/+5UFYkezI=
Received: from MW4PR04CA0111.namprd04.prod.outlook.com (2603:10b6:303:83::26)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 05:38:25 +0000
Received: from CO1PEPF00012E7D.namprd03.prod.outlook.com
 (2603:10b6:303:83:cafe::17) by MW4PR04CA0111.outlook.office365.com
 (2603:10b6:303:83::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Thu,
 18 Jun 2026 05:38:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E7D.mail.protection.outlook.com (10.167.249.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 05:38:24 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 00:38:21 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v3] drm/amdgpu: guard zero divisors in soc_v1_0 partition code
Date: Thu, 18 Jun 2026 13:38:09 +0800
Message-ID: <20260618053809.3138747-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E7D:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: ddac1d37-6c8e-48ae-5e3a-08deccfbd123
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: i4r7zygNxrAOyTuexpDBpm5B3QD9GgxztXIDzmtlj4oTqvcls0cAlfp06CT3GBQgDQcMLTnRijHoFn9Ppj/D5UEGFF8wJE8U59lHV4A0bCSU6pU+HrZHA3BL1y+YJuhHoBwHZvThihg2RDQpOk9aZtqERz1lDFgX53OIZDObbSNkt+ahbI4eUyaOKOldk5tmfCXtCExTO7/EU7/uWfWLaoV4OHuxLLVDjULl3OWcOeuUrlpcOrro6jkcwJZ7bXB5TP/lFEhBVNWtGP/Aq96Qml/nUMBs9/igef72qPOzaF2gdEAeG+DILVQtzEhoMsjB1LOtZF19j4U3+wjXsSGWNz3U7n0j5NN5OFpVRsJFLQoBIWv5djbIi4Zyy1LmYs5yyBKlTQyfrOUtQW8/fZh1MsknGvPkwCDae0jEuH/le+NhdHDhzk8kRSnOio9pAyvgDbtD2I/8lbciUQblWywxocdjwl/BwMobCpJcQHLmM9o3uNPxR9JcUDFaAZ/U3YpDxY5mZrSLyRqYryIMqEMvvJzEiqjsp8nLoMKUFz24HVUzeXtXpkJHmiT7i1ZfdHn9AXLxvDRaMsWvtr7XnL+ijtQqUQfuI5n0eJb6s6zYQNavzw1ZZDTnQHL938lFXeJNkKlPHtLJOVUaq8bMXtIf1Xu+gYOFRz0TWnjATvWsWNJf13bGwGCm32JXaIL4BkDpyMNc0G+FbVeYY42ifuMCg+Hfxw48g23gtsyX+dDe6OE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TjRIjtaw1gH7ChN1D2ypG/gIMsIqKAXkLMNx6y9WCRhtkXSXWPZQ8vU0rx15EKkzhfaDaYD3ZHlJbFsXQBD+dtudqnn3cvhJrNo9qkz8Gb8UqfG8SNlzRB92AlwBbvGxr1pcW8b7e/VpI4UYjbTDsCYCpiVGTO4zWRamnM2UHsaEENmfp10UWx72mJW9w3ysY3KsqWml3wwgE1TTmcVepqWIAUlbupxCvPTxFM1U2Wj3qM8pmXPkTBi2RVDD4CQK/vgXNu+9JgVCqEx4kH2o1p2/dV4YD9LqesioAdQ5tgbM/9Wr6vDnz+rtYzGhZPzm0HyzWlkJgNzLuvp+/JZMJWk0bM4Y1QBdudazX2PMR9rlAoiR8MKf62dhA9ccCx9qKv2csME1ZnGD4mVfgyJ63MbSuw/65pkADBVLt/aGfY+GOuQ57mDHrY/ck6Wzv21C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 05:38:24.9461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddac1d37-6c8e-48ae-5e3a-08deccfbd123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E7D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267
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

Abort driver load when num_mem_partitions is zero since operation is
unreliable without valid memory partition info. Skip absent resources
in soc_v1_0_get_xcp_res_info() to avoid divide-by-zero on firmware-
reported zero instance counts.

v2: Remove redundant checks (Lijo)
v3: Return error instead when num_mem_partitions is zero (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/soc_v1_0.c   | 4 +++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 2b557c9096df..8bc347b75de0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1762,10 +1762,15 @@ int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev)
 		valid = true;
 	else
 		valid = amdgpu_gmc_validate_partition_info(adev);
-	if (!valid) {
-		/* TODO: handle invalid case */
+	if (!valid)
 		dev_warn(adev->dev,
 			 "Mem ranges not matching with hardware config\n");
+
+	if (!adev->gmc.num_mem_partitions) {
+		dev_err(adev->dev, "num_mem_partitions is zero\n");
+		kfree(adev->gmc.mem_partitions);
+		adev->gmc.mem_partitions = NULL;
+		return -EINVAL;
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
index 5f05c8e68297..f3f3fac435d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v1_0.c
@@ -600,8 +600,10 @@ static int soc_v1_0_get_xcp_res_info(struct amdgpu_xcp_mgr *xcp_mgr,
 	xcp_cfg->num_res = ARRAY_SIZE(max_res);
 
 	for (i = 0; i < xcp_cfg->num_res; i++) {
-		res_lt_xcp = max_res[i] < num_xcp;
 		xcp_cfg->xcp_res[i].id = i;
+		if (!max_res[i])
+			continue;
+		res_lt_xcp = max_res[i] < num_xcp;
 		xcp_cfg->xcp_res[i].num_inst =
 			res_lt_xcp ? 1 : max_res[i] / num_xcp;
 		xcp_cfg->xcp_res[i].num_inst =
-- 
2.46.0

