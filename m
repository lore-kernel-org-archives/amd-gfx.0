Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D16C9830D
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 21:25:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D92E10F1CF;
	Wed, 23 Sep 2026 21:25:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ls87wzSb";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011007.outbound.protection.outlook.com [52.101.57.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B0E410F1C7
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 21:25:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lQWbYPwKNTcmWChGCNHlmuYzAVXno1JO0x9PcqCe5JodEOChLdLpZLjSBQNgVsd9XwVTe2lwZSXbUOzbLlIOQ6b/y7TO4ClV1x0LMJzsyBh6HYGhLqB9xPNiChu7dgLB12sBbnsPEfbF+o+hYHvhd3ruC9ucG6sRSIpA/YZeAT28GYFrboMlLwCJkSzPkR5Std9yK+gr1Yk9sM0Jp803p0LTnvm4birRyp4BBBltNqTPUe/kSxekbtmf9M8uyvvtqz/6+3WnR7kZGMF6h5cjIwe/gB0pJhoCIMXwR9d7u1eAajHd6hU/HJFkOHG9qD5AnO3hGYbTCv0qOzpL9gGV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W1CX3LN9CqpZfhXwfTLqyPMoaAY18iUJIBsoXsgA0QU=;
 b=llVxFt/69xKE2vXGoloZtbxU0ndKOYeV8KotuOpdfx6W3Gefa74Cvny5Rk+mfgBuQZsckpACQ+6Ixv3KzUs/DbRgJYFrwv0L9F/4cFniJ5uI6F6d26X/x5l4cOk9F0elhvaizuIrCfz6h/yrVumOnscuL2ZcU38PVsQD6rvl22VFfft+bTod04cgm+YMrcaZg3jte/JDQzp9vLPoV5HrfhgIkFtnk3KNNDh1h5l1pW/UwGonxaX1khCaV8cKiE4lDUOy8lwArM2b1RE12dYQeqeQkbCvI7DON+yFydSdu6UArmxzADuIdD3B/jX3f2PPmFvmyOX9696IEB6PdXZD/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W1CX3LN9CqpZfhXwfTLqyPMoaAY18iUJIBsoXsgA0QU=;
 b=ls87wzSbT52Y49v8c7Q2wqIwlfQFo7YLJ7qk/oVkAHKtcltyRmGwpaYKO3frGs6+vnxN5/vUaSHxMHoUaQwyMjxDLjueIKjMUCDdqsKUAXMtST87tu0gTADN6EyaZUW37UOsRPJkTw92JvD59nVIgJfijC955iYZbWflDrZ8bB4=
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by LV9PR12MB9807.namprd12.prod.outlook.com (2603:10b6:408:2eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 21:25:47 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::33) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 21:25:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 21:25:47 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 16:25:44 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <philip.yang@amd.com>, Mukul Joshi <mukul.joshi@amd.com>
Subject: [PATCHv2 5/5] drm/amdgpu: Fix NPA BO memory accounting stats during
 import invalidation
Date: Wed, 23 Sep 2026 17:20:03 -0400
Message-ID: <20260923212515.1420047-5-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923212515.1420047-1-mukul.joshi@amd.com>
References: <20260923212515.1420047-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|LV9PR12MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e467c7-2ebd-43af-cb3b-08df19b93bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Vqpp9JZfi4ffEKt8r4Bn10wNsxyWuMwAlQBqxf0hfJPbvhTINxtbUETCLPRSi+o6i4tiUkQlZFo2tn486Herhe20i24NqXQEN81QZtmBiy21kPlXKeP7FFbs1QNoXTcfHqU48ams50o3CLp0hwzhrVaSDIotxdeRgaMenTg2J5Nm7XvGkYE+nPLaMXu5IAHssYK6NMgh/2Jn3/LawW6U/sgsyhB/EhIYwVVx+BkNyZUNWnffQSF7AAFCiQotPBsBB4ib+DRlX6nOW+CDjECbAKH4TC+dAPqaYbd9MwLCZLoyAigii7J2SZxVnOGVRMmtxFHDxTL/YhD8Dyf6Aowqe+F5GjOiYCom9rW16UPpzt7dq+CzZQxmApO1qnsyLTySdj9b2G4tLt8XRwmZu3JL3yA2ZQ2JNMFxrPFde3J+F/u0GiXRF5HULBmVUyFgIYl/hn/GhegYk56hYDF+wm/Uf4yU/ODiybBG/sRGzN3OMjwHBPq7jx8m6JqMpKGulcGXhP/skvhqpima4zq9O7Ci/kohT+dFwzlLa2uyKsqo6GVGcwORht2kyKS3CK8c6JrSCBJOr9Zg42VlIXAmIBaDkHCSMPz/7iFmbONvT7VOX+gicsEWDYEzhceFTIi3J2EFr7csn90MGw7KQ0yNIk9dLOHHbTw8CveJeymXjxp+iCzpyYiL2AcYceTxy4+GbCtwR2c/3M9qSJx9wiwm2ZKNBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +9bQZofTolGx+ur4feFUXAzbRLN5thyWiMmAOF9MEt2DyGx0Kw6YKSwodv3JR6nW/zF2TV9G7Y6/yVe3yM1pwf3Np5nKd40zqTHhDqHrCgWK5U4MZquspPfGxnLV9a8NuJEB9EwN2hh0uS5VcsDe9hDiseuZxtt1I21wSWHQT5mt62ep6+EoWPzXBsg6qVukOOrWk0FTbjRSreayKG+C9HYg8xpcboLaoNN+HTahk9lsqStd5d8sn/ICTtH8TYz1wmtRg0CqYGtsKZ2VBa4rkKo0j63VMpTW7eJVF6zyOeVaO2y3YQy/DrC2fjETmcCYVKlVtKn0aO/h5Cr0P7dvi22TJxqTht6YJyBogp/V1NcptJKh0DvMsQ48/MD/1klkjjTNq4nrUysdhrgMiXw5GB1VFi/G5Kk9kOLOTIgnycGqGvxZqUvOVGnbA70vfjZC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 21:25:47.3721 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e467c7-2ebd-43af-cb3b-08df19b93bef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9807
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

Use amdgpu_vm_bo_move() for updating the NPA BO memory accounting stats
when the NPA BO is moved out from NPA domain into an empty placement.
Without this, when the app finishes, it spits out a warning:
"VM memory stats for proc .. task .. is non-zero when fini"

This was only affecting the memory accounting stats, we were not leaking
any memory here.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- New change added.

 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index f6ad64be4349..8fed28dc7502 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -3056,12 +3056,7 @@ static void amdgpu_ualink_invalidate_import_mappings(struct amdgpu_bo *bo)
 		}
 	}
 
-	/* FIXME: This should be after the "if", but needs a fix to make sure
-	 * DMABuf imports are initialized in the right VM list.
-	 */
-	amdgpu_vm_bo_invalidate(bo, false);
-	if (!bo->tbo.resource || bo->tbo.resource->mem_type == TTM_PL_SYSTEM)
-		goto fini;
+	amdgpu_vm_bo_move(bo, NULL, false);
 
 	r = ttm_bo_validate(&bo->tbo, &placement, &ctx);
 	if (r) {
-- 
2.55.0

