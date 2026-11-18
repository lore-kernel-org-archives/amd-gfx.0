Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE02606A325
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 18:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=QWuDatgh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46E6510FF70;
	Wed, 18 Nov 2026 18:53:01 +0000 (UTC)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010038.outbound.protection.outlook.com [52.101.201.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A471C10FF6B
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 18:52:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrDciOvXqF1BbkcRjUD+Eg6K8yP3gIM6HDMsklPceqv3ewZScilSn/4vz/GSlkMFhcyCu0m9OgFsYex8vGdVSdVa+4y5CYDQrqDIdm0/PzqtqDZhBDt4Ww7ppP+Zrqtfzt4nnDdJAUTtew9y4R4BpXACastHM84zIEvC2V8P2YJlb97X/G6JQ4FQN3nD7GTeUxURjMpeodWhB5hTWwYESp6fy+ZhJ8fpHEkf6jmX08GZh24O2MOba1uFOyF6O48Y0yzarsZT71czHZxDw4/HKhr2FgGztpGaAyTqa06GCsNTV0aWl7ZNc9en+JhcFu71zcF5I37RCaCYkxK3ZF8H/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DCpykIF44W9wffxBwwkbZZIfU2HIFDyIL+aZ9IEgcA=;
 b=zDJtkPh/khqrlFxPWdLstnwe1CH5VYzNJNebz2568cnM9PM3WVDm3aKjtvRv1LdG2rfX3IL2R7tyzKTFqibcGCR8SqJbHjkmb0u0TYnZ9KiMpxYlGvvSmXqEyHAS0pqPe+cdBtZjIiw87JgLPemQgQYFPkvJ/1Or35KhEfdxyqjCwtUCn3rPRfeuRYU3MHociArSg5NviawSsuXn3E1VreJd05ZrcpDewSI0V+VzyPZnGu+RtFOount0qZ+pIwITZxPse8D6SUHSdkxiZGlkdkTD0GAHXPk4NnzNsJn59AjdZJpY937MaIlkxeg1trKZvP4wRwhQAKBOmXAugrusDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DCpykIF44W9wffxBwwkbZZIfU2HIFDyIL+aZ9IEgcA=;
 b=QWuDatghCVJx4caJE3pPPu1ikah8zfAvVhPhoxTVAFji1cDBUHLcKEW6OsQY+CXuvmboLFEYtd9MxEn7J4LFjpaVeV5MsvxVZ1K1Ac/OjAa2zZ7dMVvXhq7Rg5NAtffSrFkJjht6R6+gHTKA86i4PtdyfT+5h1+ZxLfGcfFmuTg=
Received: from CH2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:610:50::37)
 by DS4PR12MB9657.namprd12.prod.outlook.com (2603:10b6:8:27f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 18:52:43 +0000
Received: from DS2PEPF00006E24.namprd05.prod.outlook.com
 (2603:10b6:610:50:cafe::4a) by CH2PR16CA0027.outlook.office365.com
 (2603:10b6:610:50::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 18
 Nov 2026 18:52:43 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00006E24.mail.protection.outlook.com (10.167.23.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 18:52:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 12:52:41 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 12:52:41 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH 5/8] drm/amdgpu/userq: remove extra fence request when locking
 PD
Date: Wed, 18 Nov 2026 13:52:22 -0500
Message-ID: <20261118185225.1857845-6-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118185225.1857845-1-benjamin.cheng@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00006E24:EE_|DS4PR12MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e4f838a-244b-49a5-0d98-08df45a520e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261028144727099003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|10067099003|261022075727099003|56012099006|11063799006|261021123027099003|18002099003|261009223027099003|22082099003;
X-Microsoft-Antispam-Message-Info: l3diuxX6Sf9L3VZCMGwgd9V7FSw9rCDLVHz5X0b75+gTAVTwgK91JchAkHmxqLCIVS60Cpa8Md+0z3ml0ZpCfGaWceitMs3SSbOwKqbGQHMGnId9UAszsbe+AQN52sXvOqIgJ2bCvaQf2gVWDGYKC0VItEIp+k2rEfCO2weyxYkyPSKGXXCsoQ5oqSplKRT0KFTf2j+KxUPHuHghAZkJ2xit/mcAmFYxuyRqE/enixPEIBfSCtOk8VBxt+8ex5jtSaIE6rNPRP+rXvIb1CF+5TiD3L0DwggFXydyZckvSZNVDmgVBkgn75iTIOrDqyZeK8g9kBgvM/PTOsTt9MzjcRjEfle1xhcmRN3Hz+FojVOIXvPVwhEcrS2VIeOL1qY7CFqglzxO4wbrC5jr326wa8FKkOf0BQfXdmf39w6M8xFUU18DUgsNyOrlnUp2TtfnqdHpxACCGUJS0UJLD2MHZaDbUBM99lIdY/wCpabP3FcpCf9/MEm+47AQld9sS8eYAoo7og2+05hCCOtV8eGnLu5JwHjZtbltJ/ygowFsqAP8TyISQqBUP2+3GdRGmJrzPzt5wQtTcHDMRpQ3h71/Hr/MBBcJGwXNLIqFaXXRFxhsTvXlkhiks2ILsc2XrPCqNdHSU5YpV9J7+fObfkuUUKFWLpDE+Joi1s3k2pYNFCCuShifMP1dyvkOQFe97NNEUfjX36q/kGTLKjebwn9+Dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261028144727099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(10067099003)(261022075727099003)(56012099006)(11063799006)(261021123027099003)(18002099003)(261009223027099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: R8+p/DX5fCJBoSsrpCP1+bCWC04CNH9PiCkJuC0afacrd4jCE57xcs8G1exr96m3OOcTUP2TeNZkGVbURvrHhEWtbhP64sbaOiXoUzpfpf72AIjI1aqsAIU5p+xNN4YioAQoMl15B0z4bwAThQMbjdbkX2IUB0990uAUQ1UO4UhgFgCm8sRO/aY37M+npm6ChfCE+a8vxsUprOd/l3IWKxglfnmXDkW+dDAUo5JWX/HZAzZnjAdNGYEh70JVpbTRhNen2l7iD38hsO2A6n1yV7+/00RRLcylYUifZR2nGqdMfuFzTECbktMLs9Axgjfo8NcSvviifdAL153JVmIvCMP4TxNfXupiqvQVEvtiCuv9nUJkYum91rJBPhgZ6GDFSu9QvsGHUmCJvZsCwc9dLraOp2LOJx1FO+GFyhzjQp8xP+1fL00q3N9YSga/gTKd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 18:52:43.3136 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4f838a-244b-49a5-0d98-08df45a520e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00006E24.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9657
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

These two fences are never used, so just request no fences (lock only).

Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index dd976a50e053..855e521eb201 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -382,7 +382,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
 
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
 	drm_exec_until_all_locked(&exec) {
-		ret = amdgpu_vm_lock_pd(queue->vm, &exec, 1);
+		ret = amdgpu_vm_lock_pd(queue->vm, &exec, 0);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto lock_error;
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 7abb9d95ef59..8b07e21d2686 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -48,7 +48,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
 	drm_exec_until_all_locked(&exec) {
-		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
+		ret = amdgpu_vm_lock_pd(vm, &exec, 0);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto fail_lock;
-- 
2.56.1

