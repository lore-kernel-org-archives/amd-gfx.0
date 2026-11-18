Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BB960A260B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=BM/Xj1Fw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 673CF10FF9D;
	Wed, 18 Nov 2026 19:08:04 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012012.outbound.protection.outlook.com
 [40.93.195.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D66510FF8F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 19:07:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tCGzly+cDYNzdfmA3p2zipvJjuZyS3C9xDiXZlM63aIrlwQ7mSDJa4eGB2U9bhBp5wqdWA3PdMQrqGiBjKtcTZlmK3r+p4mUW6/LQ7Zsz+hFI45KpxHq+Y/OCcSs6+3MFlF6pNRJEaVR+mvNQt77mq13oRO9PsvDX4o8wN+cIBKffEhFJofq7dtEzT7/nPgpqSNwcskmLQD0XUOD8Ef3NvGbSa2pvZGOVwVgojeE22gcT0ogVZ0MBkwlhx20AhMjaNsBuHNdLTM64oH8VdGCrUqDHRGScBI9Tx4zPwdvF2Kg31mVragAVdAxUff/t+gbbloJjhWQnxq4bW2lQQ5STA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9DCpykIF44W9wffxBwwkbZZIfU2HIFDyIL+aZ9IEgcA=;
 b=u5xCDaTxx1dEvWnjbOXoSFqiL/yIaeXnjRBvOh/+U+mTm1x7HC1Q87vdIa8oH0rix1poWS2rfWlvAWOc1Dm2E2Mi42ff61+7xhml8li7bvFT2cBxwEcdr0/c1r7W9NJAKbHS/9hzHtqjZ5s30+APWcdhqpYv51psl9nr7FH2IN1PA5woDZGL4Q/i6tlcy3pMLBkxgwfCXLn5YGRybi0Tq2R0EBycSITOAn3/KiDUSWXvlRtYHKGcgAfEWb6JJh6GDMaZtd3Q4d1BfOif51Fn1+nu4GyiNaD4NrEYJFNbQtiQ1JAXzJiAJxpV4laf27pAJChtgt8A7R5lASHkISu1yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9DCpykIF44W9wffxBwwkbZZIfU2HIFDyIL+aZ9IEgcA=;
 b=BM/Xj1FwogdJYUMORyEl/zA60LsjMI0k8ijEWphoEeaRGwGMKVgtXFPaSb1JEr/W0zPEK9hETIzDTyLA1IMvK0fqMYDUCbbmbJwX2tZLQ8TcF1n8WeGZEI5he0GCTJj6Wwmkvhrwy9PKTy37dFNmxHSgMU4vOU085nrZzX1sQys=
Received: from PH8PR05CA0011.namprd05.prod.outlook.com (2603:10b6:510:2cc::28)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 19:07:47 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:510:2cc:cafe::42) by PH8PR05CA0011.outlook.office365.com
 (2603:10b6:510:2cc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.8 via Frontend Transport; Wed, 18
 Nov 2026 19:07:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 19:07:47 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 13:07:43 -0600
Received: from bencheng-dev (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 18 Nov 2026 13:07:43 -0600
From: Benjamin Cheng <benjamin.cheng@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, "Shahyan
 Soltani" <shahyan.soltani@amd.com>, Benjamin Cheng <benjamin.cheng@amd.com>
Subject: [PATCH v2 07/10] drm/amdgpu/userq: remove extra fence request when
 locking PD
Date: Wed, 18 Nov 2026 14:07:32 -0500
Message-ID: <20261118190735.1863676-8-benjamin.cheng@amd.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118190735.1863676-1-benjamin.cheng@amd.com>
References: <20261118190735.1863676-1-benjamin.cheng@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a70a744-db04-428e-9c77-08df45a73bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|10067099003|56012099006|261026140227099003|11063799006|261028144727099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003|261102123227099003|22082099003|261009223027099003|18002099003;
X-Microsoft-Antispam-Message-Info: UF1/n+lmhg5wXhjTlLG0/4O2CXPFwnP8eMnfTREl3U7803BX03LQCRPqv301GvJJIM/Ro35bY53Zes9/msT5NTDteClTxDowoU6JBq3Ycf06xoErytx83UL9O2GHUHEFJT9CxexZrkKbvNRAl+lWSsevl741wnXB37pRGKBnuq2wzv5S0swrpY03rWTXOu39Ysc2jE5plqAzSuxFOYnjijh7NyFtljCAiGpVoFsEO+E1KMYvCakiQP6YswsKN/46FCHGGq93IHYR9rQG55ksRH6AptHeRhp23YUA4K1xtRokU9wc9bl4bollMGDolVyhHtgtoMwcqjullEcHWhyfO7DfpEIS2v32EcvnuMVQ9tAe1r47Ka1BQQxSSPTdWLgnxH5HaLp03oSXbNzNZBJR28sNnebQpx6aiEkZ9TWdyEIs0aBiyRAU74h/0B+LMw3s/hnh8+GFFyVkYYs0Xib0xSyohDPzhs7HFy7dj5c+pcHdSCkH8jtLnZk5iC/O+8VBTrK6M3DP9PIEnOHJlvyJPvDm/ZId4Nb86P5t9waksCF0auA4IZzSggrl2kVQU7bb+B0JYXsnnkQPbN6+Dr4+8BRdSxEXfonws4moQd6o49tp5HUa+QMXwcn2y9Y7lq7yufsIvNopuBVrR5nCPvHMXb7KqxnFjJEv4KcUwzLzoNSA5mT9eJS0vaYTDdMiJJBryKcdTO/dX8zaeezwSApIfw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(10067099003)(56012099006)(261026140227099003)(11063799006)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(22082099003)(261009223027099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +bw2vG5WPsMUVPwWzzxgx486jtHGhuZS+UcURXSpJ5n31pY97OMHnqEPElnTasBJD0hRmdlQLWFyxJUEnfxj9/SqhyJOIk8cKxaK6WTbxCPtSrbw41qH+v9+VwZMjuAV1dppq+xFS+Ovjs0iUiVjc/yQUOuHg3wrFL2ZF1oShTrhFF8SLXwwPHBVa6RrCL0ZfFjtFQbh7VhDYMzkX1SH3WKrUnmh0YdJEFS4Xp5PDhs8SDFqyAbcN0mdrmPMrm0IC+6dAOJQtBWgClmvxC0wiB7LgLTd9bS7hlxj0/BOZncE+q/eAsBw2wSx4mEMa5hDzy1cTr5bZVgA43ucOdVVEz6ZEP9EfsvZSQptZn4ZvmG1WRPnYbHRq7e1OzHzQcgRy4K+pZlab/5GhGhGws57j+llDxhvzRVlvTLKkvyD4wc/+65cg0CHrbQCMKUI+wrH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 19:07:47.2033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a70a744-db04-428e-9c77-08df45a73bab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954
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

