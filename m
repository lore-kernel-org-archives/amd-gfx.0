Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35DECDB481
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jun 2026 14:27:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F4010E084;
	Wed, 24 Jun 2026 14:27:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3duJHSy";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012003.outbound.protection.outlook.com
 [40.107.200.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E118F10E084
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jun 2026 14:27:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EShdjIbBslsKPgys1969tsxAbmz2USqKdNYogdrlovTt4BBV5nt9ZlSKy9GPjHDXYFlvPZ2aKiUzWdaB/COeFdH3Ib+XsIaRU39fOcesEJJcKuRKVNS0DXyU3fZn3P+J90EasUOTIcqeehAAhzN+2Wy2MtiPlTHEn4M6R3Tw4g480u0e/3abuHWSRDoSkFyGpQpREvWXe3Rgi7PDCMBpZ0cjtrPyJrD6dOxXbv8K+0YrjfhOarijZUFfj6s1RogIXWSlrxq0Nq/nPZykjFyklJGEfCVyarm2LJETA+wV7ZlZRR/4I32t4fgmtZLLZ78qi1ZkX3qDF5nBhgOGeRiKyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2fGGffBPYzryf3vbEMVGRgeF11CtDIrEDSCj3fG0wo=;
 b=o4SkEAWg8kFvpRwSfoM7cuHMNo8UbFfaqYXwtteitrUq4Bsk7etsiKB3hotd64tkwPdsJNkNv6LTk964zUJYSna8TMZz9pdxDIi7/HMPuQ3Hw3nK7mi0eCgypNrUf3Dv0sZhBHtreKCn47aZdEgvZdLtoq66HLAdOwYsvqO3gqlG+nGGncW18Hvav+AjV+1Az4fovs/ljk86QNc7liMFsSDWY0S8iru1pUhk8erc6arZ5JUKj/Orn4eQMRg3lIvnAY15FEPEocHiZ97zjoIiYE63s+P+DYVS27cPzMYaCFZedJF1zKvAF73RXX2D/qK7fB65EBI2nwVHctHeGHnVSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2fGGffBPYzryf3vbEMVGRgeF11CtDIrEDSCj3fG0wo=;
 b=D3duJHSyfbQFz96ou4+Wc6h3douCKb2hxKiW8Qc2tP+QKhOQedniLD5MiP6Lw5g5UFA6EKgi96QclhKdYdXf9ygf1Gdjip5HGUvPWO5Y9q5zz1lTyG8rnpHhWsfD1ZM2ZTxXCpXSngC5CEA3RcyXpRxTHt32JazqaZNexziM6c8=
Received: from CH2PR10CA0024.namprd10.prod.outlook.com (2603:10b6:610:4c::34)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Wed, 24 Jun
 2026 14:27:55 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::2b) by CH2PR10CA0024.outlook.office365.com
 (2603:10b6:610:4c::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 14:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 14:27:54 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 09:27:49 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <philip.yang@amd.com>, <Hawking.Zhang@amd.com>, <Bob.Zhou@amd.com>,
 <Harish.Kasiviswanathan@amd.com>, <jamesz@amd.com>, Vladimir Indic
 <vladimir.indic@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: move DGPU TBA/TMA from system to device
 memory
Date: Wed, 24 Jun 2026 10:27:27 -0400
Message-ID: <20260624142727.1946258-2-James.Zhu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624142727.1946258-1-James.Zhu@amd.com>
References: <20260624142727.1946258-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ada38b-1411-4cca-1817-08ded1fcc7ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ipCACkrMw2/dSf1dzeSqj4cR4WrO8CbI3HvMZ6QvPQG8lAsqLUYoDVYdxji9CZgPYi7srbyTAvUjcuSf6cnDKZE6cuMn+vRK/JAi78QN9DcTGCsROVcgnRBCHcxcRMrQw9Jgf0a49CaqtCVRPCTxNLhMRn21/Tfaf92lc3+4TCvEDdWaG2r0qx8qawZVpiYJ2QtiXyzVR+tAMjs8M9k3M7yfqDrs3DNTaD0LgYkxbxICDqYS6gWmIgrHLbRFR6OaJIKbCzijTwKxa55n1eGcrwyDq0Tl5k+kLJ8ftCBNqKMWTZAEU1PwXh2nGrNdVVBGB/b1sjE+cVG1WZF/iBRIpX1hQat0e2fG0QP4YGprQL2whxNEVfnzln4joAmBpDh9YAcrWFAAevrgYOghuHnPJqHc/rXEq5RcLX7fP5cml+bdk1ZW4E7KVJ/GzOTxA5ExKanpJ0zMZoiJeKLt4oEFBgrETGsWNqXpgEN47IyjuguTkE48CWOtSipJA4Xlmoiji9f68mX1+jSVWzsx41ol/v3sbOR0Tyh6ytt2TUvbTV2GQWhsMrIWXyCdcJIcscaLqkMDEQ95LemISSILCqNbxe6tAAZt9PybzdV+ngism+XqzfZIZYx8a1Pb4MqO87YrVWRhDyJ6X5iIwGnJaKL/iiYEeMuVJZzPg8RasYr6IuNwz1QVYa/FABYqaLsm6IJSDvHMKul+mTwjN6JpCQMj5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aRG8ehpHtOWVhuwqm46JJReV1i2Rws5Y6fY7XHgRMPLcR45hnzleoOpUUcuHWjKdYcIhSXzTOxD4+KVdLGyh6s5fSOKApx9eLp3u+jkOHs+VNNeYVPqlzbE1SJhVidoWh6D4I2HlNE8QLRdVO7AV0XDxnii+TJ6Yq1+S7Ovb7HIY0l6pMuAEPNxuBX8PgUfzqWVxAMOMK84MZTx3qyMo5Asw7/Is+asLJfW5pEsWZ/19WjAHnEpZgHS8HgStWKqo6YAxE2guLPIepPDxLvrfBtCadsqPj+kIoqYzmixZ9/vTu4MX8BxPIkTbH8MQFLyD9PzjD5Jdw+PH0H/Bz+jpfEIhEpY/E3hPFjMeAmxCD0ucQh4UAGLFC2ikHhoIwD9wlM25NHaeOMX6ITlXC76nTh/wZkIWD5tJMOCKZQ7ZFPUf+0orwEF6auDYBVBp+euy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 14:27:54.8738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ada38b-1411-4cca-1817-08ded1fcc7ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
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

for GFX9.4.2 and above.

-v2: keep APU with GTT allocation

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Vladimir Indic <vladimir.indic@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 21a90fc3adff..a69e278f7aee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -776,6 +776,12 @@ static int kfd_process_alloc_gpuvm(struct kfd_process_device *pdd,
 	}
 
 	if (kptr) {
+		uint32_t domain;
+
+		if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT)
+			domain = AMDGPU_GEM_DOMAIN_GTT;
+		else
+			domain = AMDGPU_GEM_DOMAIN_VRAM;
 		err = amdgpu_amdkfd_gpuvm_map_bo_to_kernel(
 				(struct kgd_mem *)*mem, kptr, NULL, domain);
 		if (err) {
@@ -1489,8 +1495,7 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 {
 	struct kfd_node *dev = pdd->dev;
 	struct qcm_process_device *qpd = &pdd->qpd;
-	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_GTT
-			| KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
+	uint32_t flags = KFD_IOC_ALLOC_MEM_FLAGS_NO_SUBSTITUTE
 			| KFD_IOC_ALLOC_MEM_FLAGS_EXECUTABLE;
 	struct kgd_mem *mem;
 	void *kaddr;
@@ -1499,7 +1504,13 @@ static int kfd_process_device_init_cwsr_dgpu(struct kfd_process_device *pdd)
 	if (!dev->kfd->cwsr_enabled || qpd->cwsr_kaddr || !qpd->cwsr_base)
 		return 0;
 
-	/* cwsr_base is only set for dGPU */
+	if (KFD_GC_VERSION(dev) >= IP_VERSION(9, 4, 2) &&
+	    !(dev->adev->flags & AMD_IS_APU))
+		flags |= KFD_IOC_ALLOC_MEM_FLAGS_VRAM;
+	else
+		flags |= KFD_IOC_ALLOC_MEM_FLAGS_GTT;
+
+	/* Allocate CWSR TBA/TMA buffers */
 	ret = kfd_process_alloc_gpuvm(pdd, qpd->cwsr_base,
 				      KFD_CWSR_TBA_TMA_SIZE, flags, &mem, &kaddr);
 	if (ret)
-- 
2.43.0

