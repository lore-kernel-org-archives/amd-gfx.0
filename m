Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 583BBC282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 18:45:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08A6F10E228;
	Mon,  3 Mar 2025 18:45:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zBla0Z5u";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD48D10E228
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 18:45:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAqlufnPGe4QLmkxmMAtFMNaybSfKYNdMulCWmGYY5BmcUg0yT8rBGD6sGTfKR3dUp2kGGQfZ4XTfA6yPk2m6Lkd4BcTRh+QfNrwraGP31jk9RcIhHPNkIJ9WrS+pA+g9VQ4mb14rnaiNmWBJPKcgNs7a9fO7dRPeBdCMJETfdTZIdACDvZJz9KqClyvbIiSIiYXQzhe32HJeLYHBO3jbC0SUEmXqIUT/B7kiaU1vTGmLyU2PF9C/FxLF/ICRICEzywi/mtCVM05IIIVDyIwFZ7oJfw6uUQ8obMeGnJeBoGju2f/rVWJ1IEk2lojxCXOJBwpkGltUwSQ0sMnMRFeEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWNxLOFurnQ7Flh403/KifckH1FbtqlVNCmbG2zhgoE=;
 b=ehosZmkeSKZucvRtpuRwXjPUIASNKdyaSUcQmNXVwoYyDC30u/IW93zl7iG2eeFxN6/OFBSuHcuM8Y30msnHHpJrgxpfZn1oaTrRdqcpgEtw1cnRjNJrlw72+lTrpWH9/KGm3VmXFQ5J7ktoonEQuIil6KK4UooWDt3/eALs2HehwoSDGeI/XkfwvxzVFZqO79Gp9VLqw0UGTFXzqB2e4o51SfAVHSpurzQTFOZyXr1GXJNX4CX+J76H7Zf+ME/IVL6LSYkLMCY0izPVXlhx/xqo+Nmh4HSghQR8fGyIFO2q6KakL88nbOMYtii5svSJGoSasEaM+ifTYK9+00pNWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWNxLOFurnQ7Flh403/KifckH1FbtqlVNCmbG2zhgoE=;
 b=zBla0Z5uR6O9cAIRikQHLEMlDsRtmpsoftzeILdCdNl9WWeR5hbKEixmHjJZZUHelF85zUYkoq9ZZrfAxbMAcuNcA2Q129pIjHjdvx2hc/PvFwSqlkZtpln5JJ95C6qC8JWh18fYZEORYPdYPFwOMNNMIorOoQUakiz/ZXn6LQY=
Received: from MW4PR03CA0294.namprd03.prod.outlook.com (2603:10b6:303:b5::29)
 by SA1PR12MB7342.namprd12.prod.outlook.com (2603:10b6:806:2b3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Mon, 3 Mar
 2025 18:45:22 +0000
Received: from SJ5PEPF00000207.namprd05.prod.outlook.com
 (2603:10b6:303:b5:cafe::c6) by MW4PR03CA0294.outlook.office365.com
 (2603:10b6:303:b5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Mon,
 3 Mar 2025 18:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000207.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8511.15 via Frontend Transport; Mon, 3 Mar 2025 18:45:20 +0000
Received: from work-495456.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 3 Mar
 2025 12:45:18 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <Felix.kuehling@amd.com>, <philip.yang@amd.com>
CC: <jamesz@amd.com>
Subject: [PATCH] drm/amdkfd: remove unnecessary cpu domain validation
Date: Mon, 3 Mar 2025 13:45:08 -0500
Message-ID: <20250303184508.2277310-1-James.Zhu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000207:EE_|SA1PR12MB7342:EE_
X-MS-Office365-Filtering-Correlation-Id: cff542a2-764f-4f82-1f93-08dd5a838d01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fB4ypSxq2TeGZ3dqCbnZAaOzQZsXs3v/OickrSmgxbSuIUefv+eUpc48cw0A?=
 =?us-ascii?Q?FFSlOYGvOZOjyeL41Hy/WkUKFWio+OyDR0NPaGK3TybdGaaLYONZqFwgmbCU?=
 =?us-ascii?Q?EpaK/6WxJDtA8I+FLfyOK+WS4hHpTwiH5wQW21JmgO78BcGqdQhQUK37sa5V?=
 =?us-ascii?Q?ukuZ+YpA1hIy5lNUv9p3rVu613CVONhHKdT8OFuhPCDnf016O94lTyQ7DgB6?=
 =?us-ascii?Q?0zL6L0FM1sLdyM0f/PduuWo74pYP/7hR+YmWtmH/WEHUmpFSdDF03kBJalnd?=
 =?us-ascii?Q?rdMvJf7+SPWxzT947KlY137YH/FJD6XZhxPcobSwA5D9TMVB3a3TGs8DPiKq?=
 =?us-ascii?Q?IVn7Dsah8m4O/6+4cpCIYyAKudgKLfGuYzU71ZdI7vx+y+1zUNePh3QYrjdp?=
 =?us-ascii?Q?NDy6rKM/uMUJId5MTQviLGimbie4V+UlMLTh0BVftyeHkoMS/6ovLliWktcM?=
 =?us-ascii?Q?I6iQbxYiqA63hjYCNXnTfqZq/urAqjOR/6apYzt7Mm2sxzzOvnFL0lluacbF?=
 =?us-ascii?Q?RjPCs4hoZy1XefmUazfpp4kFCGjA5ThUkEz8mUSQ+A08GfCHgFZSSbldBleC?=
 =?us-ascii?Q?gr5idXh4PmVO9qoM+RadHN7Dt7y6Bky4ozOTIHwEi7d6RBCmCh5xP2dFjq4p?=
 =?us-ascii?Q?BTyLiqoKWQyqtvSP6P2T3sljiQTEQwQJjpSakB2APtwkLaSI/ejPh/5ytYHn?=
 =?us-ascii?Q?Id9LeanwSgQmdvYPcFPtv5DxN/qWDe0kLG5pP9e5zVsRW+OLdgJ4bcxojtkN?=
 =?us-ascii?Q?Nx6zsuvhpy1nXdvCY3Glvj2uQTv2QzfgIjmz7W32Jr+L80JhwZm3b+GU+ZaA?=
 =?us-ascii?Q?JSbXHFp1rYgYujpuitFTWDqr9hwrRoUgGlzD5xr+x4c2FRFyES/6BWsbmKyA?=
 =?us-ascii?Q?kZBiRWjpLloXkpUIYR3TjpTJ94U+M86zyGJON0pSd1f7/vLtoMXLTyQ7yY3N?=
 =?us-ascii?Q?J1J7HRk9N+BPhrz+Q8MLP5NOM1ZMrAnMQhhpqLHBHd0gHdYrnezJxh7+53Xr?=
 =?us-ascii?Q?VAhM9U5BbG3tzZlF47stFBlCakMW3lTv+JCIpBt6p6rD6Q6AsnsvzV8gj2uN?=
 =?us-ascii?Q?//O36oaezMoSAF1jqNk8+/JDc5e3vpF8nBfbc2Yur97KhqS2Po9zFDTGegNR?=
 =?us-ascii?Q?XuJFb7RNQOCi5BHveVZNtVu+JhJlw8PVGFwE/A8mDu43FtuQPuwLsbP4Ne0c?=
 =?us-ascii?Q?7NLYnqjIirr6fpjP/Q8Wfyfs6hDq0R3KjLqqvIh5WzXoMShmQdRQqGqPPbtS?=
 =?us-ascii?Q?hv89oHGb8V3+iWIasO1nz/TYovZFAR66+tWEnPKoXPdaAJe4f0KC5Mso14Xw?=
 =?us-ascii?Q?U18AzQja8FM2MT/AX7xaN111J09JjLPxq+Gr8L/qx4YfpDtJ/wwhU1kj8tnm?=
 =?us-ascii?Q?FiGbiFokL2Lb5OpWJulf3y0AdDSXbl+Tj3WuN0E8GgRG6V3CpC3doPz7Msth?=
 =?us-ascii?Q?ggC1CKeqvXUsmfgGUsc1W+ctld+erXuIq+pHojY4PbMFt8YDgIpzJZzKzJng?=
 =?us-ascii?Q?EkaoeoHucHxtQXo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 18:45:20.7636 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cff542a2-764f-4f82-1f93-08dd5a838d01
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000207.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7342
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

before move to GTT domain.

Signed-off-by: James Zhu <James.Zhu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 62ca12e94581..2ac6d4fa0601 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -595,12 +595,6 @@ kfd_mem_dmamap_dmabuf(struct kfd_mem_attachment *attachment)
 {
 	struct ttm_operation_ctx ctx = {.interruptible = true};
 	struct amdgpu_bo *bo = attachment->bo_va->base.bo;
-	int ret;
-
-	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (ret)
-		return ret;
 
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
 	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-- 
2.34.1

