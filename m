Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70FD606A31B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=CQDGTLBh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A0D710E3A3;
	Wed, 21 Oct 2026 20:15:26 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013043.outbound.protection.outlook.com
 [40.107.201.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB4410E2FD
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 20:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whovuhHnf9lC4YhZJjq95aLsknPC+k9+rVFhElWHGvIGsdgj+l0+sZR0AGvEh0lnt7qb/geoInWoOQjlvvHozlEq6a4UgcTLDgz5I84vcFIvM3Xfj0Od+EQU+4/fpWZAp/jqhMY3nKHLM9AChOijTyOOQ73i/FQjrQzEntLge2DOvLkcXE9y7TCNqhIuv58anpCSmREeh/95ofRaypKUvVaDMOu5moPOyry22WQ4y2B/8TRWfFVdLQniGWVn4lDl7G4BfD/hw8xWeVhxTXwTRNqr4rJ6VB4SNHqs30ZZ+mMHQ/DfiuLKxQztHpFGrfx/Bz0XHhETn9qR9cZeNHHXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASdOQZ0HjydUafiPIKAVKkv2uAT4vIpRH1E8juH839A=;
 b=Xn/0L8McIpmstCGjOmjbpRGy+e5pN2r+kQY7ScYBxFIinsfB4oqGSrVmxviQIiBINhr8zTkBW3Bwb0ZAWAWcujTIOej20QOKZVmcW4PygVX4FrusebDnAx+vOFHMJLQya3gEfjqBv1tjLJHUDS7w2Fd7lquK7mkGFBG8uvibYRqH4lI4hqxJrfloX8cmumvsWDUVmClmxlyDC/B66HNfLsJv0CmdZoZwIvvnwzzBcjXweUBfIXxBk7Pv3QcMQUNhi9iK4hBiB+9AQ55m6b7VaPsBKiNM0cxwraP7gVhcpl5sgmxmLFoIeHYhziRtGbHgNmDib9Djur4VFZISJNn/fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASdOQZ0HjydUafiPIKAVKkv2uAT4vIpRH1E8juH839A=;
 b=CQDGTLBhRmlFaJlD2a/PPJCFYKd7Bh/ytzDIK3Kd7sDmnN7iBGYU3087qTHyzUdCdV+Vr5WqkkYAu5dNkqz7xN9YFQYIWbDdiXAHylOA6vOFJTRtTEgqWvjrumbpmYmtc4Z4EzvPyXAb0Xcf5eQJ7+HAiDRCrRL88LfdRemYjVE=
Received: from BL0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:91::22)
 by SACPR12MB056849.namprd12.prod.outlook.com (2603:10b6:806:543::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Wed, 21 Oct
 2026 20:15:14 +0000
Received: from BN3PEPF0000B373.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::5b) by BL0PR05CA0012.outlook.office365.com
 (2603:10b6:208:91::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Wed,
 21 Oct 2026 20:15:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B373.mail.protection.outlook.com (10.167.243.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Wed, 21 Oct 2026 20:15:14 +0000
Received: from amd-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 15:15:09 -0500
From: Shahyan Soltani <shahyan.soltani@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH v2 2/3] drm/amdgpu: clear vm pts upon a vm->generation mismatch
Date: Wed, 21 Oct 2026 16:14:58 -0400
Message-ID: <20261021201459.715423-3-shahyan.soltani@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261021201459.715423-1-shahyan.soltani@amd.com>
References: <20261021201459.715423-1-shahyan.soltani@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B373:EE_|SACPR12MB056849:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbf8eb5-8c00-4c7b-62fc-08df2fb00435
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|36860700016|376014|22082099003|18002099003|261021121427099003|261021123027099003|261009223027099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: izNisJgWCtkwAbOVK5QpLOzDe0d4/25CFM+ALWvOXZbkcgSjPL6/o9UvCeOnEYJlWdCfCUv5GUN2sDwFRd5zbyEwwz6RUrCczvEz3HuUL7jhJILSEDfNhY4GXxha1TRT0Su1KBdMeXqtPhSfGHG5YOdfKln3sRoe6tqRoet3plOtTMt/qbIMm32RzlS7qNAIUIR8i8o7Ljm7jAP9CSItV7ykqEXzFgjnK9o1jtaKqV5Z6P3lA0RuKOZuoEaZvV0YzcR3Cetj00Kti0GmHuU0ZJhguifvslrE6OfoI+l4T/3HX/Zk1Wwhie3627J+Aig1lAyFzFHgl/LqYCJpLj7gjEhKmm0eJgbW0oDgilruK8RJHrzMSfhsv95U3dChQ8bjRKTwRdKvt8TN+ADx/tq2VYAz1KmdBVmYMfWgkLkfjroIDBZ9i8TlLsZQOtCCv5s0Y2wTfQk4bfq0kKz9p0LY42B7cHNEIKVJoqwyJPvIcy7BGbhDIAE9pCZAtHmqGqrrUdTQUEroU/UsfJ+ikRDtt9l2y9UlArUKh3TlmOboTpYDYYZbv3FcyR/aBTk6MNg5eHTnshVfSzvvLaUFCPR9ErJ5K0rLB29KJgMgNiMAbj7+wzkTcHhRJKQk7DxiQk8Z89ceFrXy6K1avwkSgGqSztDmEZBNu00jB2Gnr/w8xwVYXDPKYM0Ho5hTdCou8pqTzqQxOfsYgqpz/YcOgj+a7A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(261021121427099003)(261021123027099003)(261009223027099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RWqxtoGibv5y3ABkjY0Scs9tthlAL/r6GopsXVSPJm4QiPXna1AwjkO2ONGqTE1h/xeLEyu7xupgUyjuJ15SOIFH68XWZaoKhiWAYSzcdAOXe25jukXK60OZXTqRZTRpgwlWqFJo/IQXtUS32E7AK2DLSbrJ0on8pDTBjvmPMN2T7cEcfMDKEylksV3flCG66ybf+Mapj6OSIHKDRaicifh0f1gYJHVe8FXwOpYaONStxx/ktslwtvQkGPSRkQCKMM2Y6SdXpYlMEHOCcYGsEJkg2qMRuezP9ZFGR4QjJQaXpbP8mNZV0Yqq4a7TbMXz556yHzUvZ0/YU75wSdx7VC7nR07sVYiR4FvYTnBaP5hOMc8SJa/LwGNILoGP2JGl+Fp/l1/Px/D6Xwx6tGMFoKLBhowN+fHYNmUftLUE6VBEwDsKJngEB/T0N4BZWFd6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 20:15:14.0837 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbf8eb5-8c00-4c7b-62fc-08df2fb00435
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B373.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SACPR12MB056849
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

[Why]
Upon a vm->generation mismatch, the evicted pagetables are iterated
through, resetting their state, and moved to their preferred domain.
However validation doesn't process the necessary step of clearing the
pagetables' garbage data.

[What]
Clear the vm page tables through the kernel.evicted loop upon a
vm->generation mismatch. This ensures any garbage data is wiped. The new
vm->generation value is assigned after the loop.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 1843b9d7bbf9..961557997cd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -630,7 +630,6 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 	if (vm->generation != new_vm_generation) {
-		vm->generation = new_vm_generation;
 		amdgpu_vm_bo_reset_state_machine(vm);
 		amdgpu_vm_fini_entities(vm);
 		r = amdgpu_vm_init_entities(adev, vm);
@@ -645,9 +644,18 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
 		bo_base->moved = true;
+
+		if (vm->generation != new_vm_generation) {
+			r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(bo_base->bo), false);
+			if (r)
+				return r;
+		}
+
 		amdgpu_vm_bo_needs_update(bo_base);
 	}
 
+	vm->generation = new_vm_generation;
+
 	/*
 	 * As soon as all page tables are in place we can start updating them
 	 * again.
-- 
2.56.0

