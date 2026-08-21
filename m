Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC50DC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:10:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35AE510F362;
	Fri, 21 Aug 2026 16:10:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H8EUZptB";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013041.outbound.protection.outlook.com
 [40.107.201.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61C4810F367
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:10:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nr7eDYkq0gjIV7nssdp2LeJz7YA6vcGHLr3rN2UCwsyM3I+lnO0DauA+g6j5K2Ig3HfC3Z4xuBX8Ak/BqdMdUX0lGrR5K2tfeDUTTvGaZTF6Kek2WAKUardIgBhD7rez8GbGPYVMJbg2Pq+MNvieNrQzuVWdOhT2o5REBZt3GgMmLrKlhJ1xKPcwHXKuuKK7PiICnfH/cbgYC9cTJ1pF/JkJnMfz+ce5Q0MgJH4v+/0NRkbf9U7YqQcDPbQ+b91TgOFjir1obWZxQK0Kve8g9/cTLRmSt+C9rQF/GRpRgIUxo1DmbM4QfH38+UtzjIGbyxUJbYlmMcpmowJn9Aqkrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IafphT0DIWbXs2qPRXS1Y7k1UwpQDkwn5eG4l1Pf1f8=;
 b=L/Glp9SPPlkiQW5Id6EPyUGFjZiaKKbXR9r3YuZtrbYygRVqHjsVt3QHCc9m1US3Y2wcyBomE9j5WBRxbszHp+spWeO+DwpYQ9n3b9VAGYCXywXSLG1pg4FCrpGdeD7gdRzulSb4kj4Ks3vLqwuW3wlg9tGN9n1pddOzepyDUTbuxe+h5es+VK1Xujs/NRAmMi+hAHX5kHi18zUTECEOsnzLOfrUb51B0sWxGK3XCebqqgdKfpAqPlAg19JCVlbqt90n6hPOY3+Mex90dBr8pY8nVfaLxI0+vH3xSF6pZ04Yqx3vxBsbxaFGqiyIDlczs7wqZUVW/Ud6LzNnj0+g2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IafphT0DIWbXs2qPRXS1Y7k1UwpQDkwn5eG4l1Pf1f8=;
 b=H8EUZptBpCMRNSsGej0ERVy0L/xJoNYeY1XNODnUnE5XvjbPxnGO1p/JdTeCHcRNsLF2VLDuyl3oJ0DiIpVrZ4VTDZZXBvZ2/RJeI5DfhK+zT2wcYoefubeMvOtE5YCyr5YzeH/hVYred6Cejo/380V7ubgIgc9jGszsMat1LYk=
Received: from CY8PR12CA0005.namprd12.prod.outlook.com (2603:10b6:930:4e::13)
 by PH7PR12MB6564.namprd12.prod.outlook.com (2603:10b6:510:210::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:10:15 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:4e:cafe::27) by CY8PR12CA0005.outlook.office365.com
 (2603:10b6:930:4e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:10:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:10:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:13 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 07/13] drm/amd: force remote MTYPE_NC on GFX12.1 mtype_local=0
Date: Fri, 21 Aug 2026 12:09:52 -0400
Message-ID: <20260821160958.753063-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160958.753063-1-alexander.deucher@amd.com>
References: <20260821160958.753063-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|PH7PR12MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: d113ba0b-0e9a-472b-6c73-08deff9eafb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QDJ9q1GA3UkEIo5RCwkpj3vDO4XtszQomsb+TiUPg2k6AHyc1rjsqnn9vbxknv2FT0xPlx3+Gu5QGPSond3qHjuKuxE992yXczJGASn6ecCCvkF/6qPXn9fr7ElnePae+o8Qi9/GxbT72b4LBpGWLaEax3XqsytglGvgALjhRXY9vTCnn9HFbYNg6aLJoojOynr1nQBN8OEfMSGhFNdWeYPTb24U7gkwmEWULVz2tk6LGtNtGkMmSFfWmrUYaH5haENmivKHUKW49LirjraADvzb9QShdf/0i6vqz4eeURV8RDKqUnL0OMGvytzz05bU1XNyNo1Ew7U7d5+SAS3q1XKF9XV8cQrLM4J1RNJDF5Vh9SNB+Pm3evm2mgCST39Ut9W+0+q91wB7uiiVpXn3gQ5MdEFJj5Vc8LQakVKBoyAufh0mAlyWrHfMuTj7FEBSJYMAZ3cDRduPYlb9bboKGQCDF9AuIIN9+BlroMTe+QXM9Eo8JmRBTQsfyPvG053ZSQywo1ob0smA5C2RK1JyPXi5q5Mw/T+pJbeUeXDnYpQZ1VULiRZqzRJntKEKa8OkkmDe7pOMkvbjqjlBgQypbfo1sDOoxIAp/a/j95pbdHuOSOpoAs0di6ccj+b3RHS9JNBvVjrF4zIwqqru7bIH+FevTGGpKoNaSSW2epTLXeW7DIIrBsNzWGyGSALvo6I55w9X4eCMplMSUPtZ2ZJjXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KK4iQ0EyKCDMOMgCXvihhDl5X2cv57OOkV9gsn3xDPIhFPbG7tleHwAreCfKVtAPuMLBSgAEakAkvlxzBliuUbwP/lUXEkXjOobwln2YwKfin1b2O77Wf4NOPj3LbEj88W1rHKqGO9SVjmoFId1bGHI1Q9/Sdvtv8LRO6Eda9WL0lakwN9Dxa5rKDSwYYgqvJ4JRirOr+ie27v0H2IixpMpEoLSgS00mzWEDSFxUhOIJKh8uVLsm5CaAF7162Hiq3llZ5dcENOWne9v6XsSoIk1FCtXJGMYKWzyFYIWok1KRVZAZh3mXpRzQ1W7CrCZ+87QsDsiGUUMlPXo/qGZ5FSwGMEtCZb5hSgYNTjlSPiuHQdMCv648mNkCjgJy8JiLHpJb7N72J+xK1Qr77+5BF+auTp9Oo+3JvKqdVLwBgdNlq0nfUtBikGd9NB/FZjE5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:10:14.2624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d113ba0b-0e9a-472b-6c73-08deff9eafb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6564
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

From: Alex Sierra <alex.sierra@amd.com>

Work around this in both the amdgpu GMC and KFD SVM paths by explicitly
selecting MTYPE_NC for remote memory when amdgpu_mtype_local is 0. Remove
this once rev_id-based AID detection is reliable.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
index ecd17ee160194..0d89cae582a8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_1.c
@@ -617,8 +617,9 @@ static void gmc_v12_1_get_coherence_flags(struct amdgpu_device *adev,
 		mtype_local = is_aid_a1 ? MTYPE_RW : MTYPE_NC;
 		mtype_remote = is_aid_a1 ? MTYPE_NC : MTYPE_UC;
 		if (amdgpu_mtype_local == 0) {
-			DRM_INFO_ONCE("Using MTYPE_RW for local memory\n");
+			DRM_INFO_ONCE("Using MTYPE_RW for local memory and MTYPE_NC for remote memory\n");
 			mtype_local = MTYPE_RW;
+			mtype_remote = MTYPE_NC;
 		} else if (amdgpu_mtype_local == 1) {
 			DRM_INFO_ONCE("Using MTYPE_NC for local memory\n");
 			mtype_local = MTYPE_NC;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fa4054d51f606..fb5eca38e6a93 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1348,7 +1348,8 @@ svm_range_get_pte_flags(struct kfd_node *node, struct amdgpu_vm *vm,
 		mtype_local = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_RW :
 				amdgpu_mtype_local == 1 ? AMDGPU_VM_MTYPE_NC :
 				is_aid_a1 ? AMDGPU_VM_MTYPE_RW : AMDGPU_VM_MTYPE_NC;
-		mtype_remote = is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
+		mtype_remote = amdgpu_mtype_local == 0 ? AMDGPU_VM_MTYPE_NC :
+				is_aid_a1 ? AMDGPU_VM_MTYPE_NC : AMDGPU_VM_MTYPE_UC;
 		snoop = true;
 
 		if (is_local) /* local HBM  */ {
-- 
2.55.0

