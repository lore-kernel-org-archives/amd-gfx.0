Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 763AAC47077
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jan 2024 20:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E58710E552;
	Tue, 16 Jan 2024 20:35:19 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DD8C10E552
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jan 2024 20:35:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lUK2obYgT4FvNxV+vLtRHq2By7bkEQ3tAOAgtE8EMgIqkW5g3g8/ZBuRu0R4GbZjvfIDqHXnFEm/d7UWkFyTt9yTRAPwxHJtSoHOGCzmRLW2uOHsv/YidiETv8QFx0WaRt9GpzKvOsScuyvZI0YfPw4GzHrhLbGfHHyI6aSVHDsBJvriXimpDvs0mx7wb61idfdx2H1PHd5Z1fL39XnJZLwTgKiPZkCENsrZ236o2tEeoYw0WtCufJX05lPRBVGfnWKFvCDSIT7+pYgT/oOIM3UOjpaZXytmb/yEVlKOW7jxnwWZZ/lYZmbLZQLf+6vaRI+/ooyd/PV9RqBUq8fFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ftS6BL2kCgLRQ4dUfg7tUqUh/Lc19yDu4m73mAyZeFM=;
 b=IxQDpvPfdCgVsdBeb4x5VXM/Sk6+HYMNGQLDZGgvNAvzSS8Z0zlcYuha9ToWxs4zWdsjRLu4wvExhfaNCtI3u3JWKdaHt04/Jg1wmOUtMEmb0tcwYf8ioAXrhlAh4qkVNiSYiNF+Qr3sXYzJJJi49wgOwXGCIP1A52I8jno+uHcBZ3YGzdBJ16g/vPVdn3/juG7tT5OJBf5aKGyfMyWA3vDOWYSjYbMTst8KsGRfQ6SG4SKpkeeSHO/lQOuv5sFsQi8669uj8BepGyokRqxMWhbtdaTEUzS2cR+VcIQjBbIdy/5lfEAS1waJhK1SuudjxmIX93qplHf1zFdu2Nqg3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ftS6BL2kCgLRQ4dUfg7tUqUh/Lc19yDu4m73mAyZeFM=;
 b=SDsUOYEyCj28sA7FWjnscGZyh/wJ8RA7KC6Z2gCbNzOpLZJWKnyBAT4ypZ6VxyhJNUpfbKeYZjGqhRHpnhZEjSfcw+da6se0Fs6Rq36338TJwhgNlvjDJIFw1qKZGy6AXsemKf2De6VsYFBcTT417QrNHKhVeWre7qfO5/OKkuQ=
Received: from DM6PR13CA0050.namprd13.prod.outlook.com (2603:10b6:5:134::27)
 by PH7PR12MB5927.namprd12.prod.outlook.com (2603:10b6:510:1da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18; Tue, 16 Jan
 2024 20:35:14 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:134:cafe::54) by DM6PR13CA0050.outlook.office365.com
 (2603:10b6:5:134::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22 via Frontend
 Transport; Tue, 16 Jan 2024 20:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 20:35:13 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 16 Jan 2024 14:35:11 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v8 2/9] drm/amdgpu: Add mqd support for the fence address
Date: Tue, 16 Jan 2024 12:34:36 -0800
Message-ID: <20240116203439.802772-2-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116203439.802772-1-Arunpravin.PaneerSelvam@amd.com>
References: <20240116203439.802772-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|PH7PR12MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: ec121d6e-2ea4-4212-0f8b-08dc16d2a488
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaHftIozeT3Atu4mzB1zFHWaOdmo16FFvculwntmMwpcLm46RrDzcT/9PEAST/2fqdcFIHfaWX8ZqlvQw7tZKlvGDrMFn5gyOPmaFB+IJXtLP3hM4zjqO1wzrbpduj+Xn7WM/PcEHKBBLsGSpwZIGbE6c8X9FYwUiGJas1A7q0KQybzX7Ps1gCKKXKYJFWk3R3vPSBTvfjKi7HCuovlyZUh44Bv+PYGYgbpB1903pzP7vdbYRyOiCwlhOYX22ls77qHtn6xUPGw+yrSRX3x859QJzhZ8J0DUR+0eYtFD+bWH7pVXJzNtAP0aF/vr9nTQlK4kED49t0P3ZUg4xAMvNy5KQLqi7kqU4anadwcPnRIWCfJakKP/hU3+9umNiLYApOrR5Fkz9gnXAEt6VcIo1PYCdFl0tT8KUaeMM4wxOKtuUky0Jbrdvma24YhXpPUplvmaF43OrtJB9iBhPYnNoVMJT/ewVxT/bZvWG1zYvd92q4CaWRbe68sppu/oc6gJgPwUTr6RBmiYJoZzunGa7wWuXRMoZfr8BC9QGr8AtDDVolYKrRY9E1++9fWxC/MViw/UnIXAzBILbwZVyBA2Sddfw8m87WWWRg125RmDEAPB/TEGB4r+5dWwklFJm2vJjtrLTc2nnSmCJPb2S+KGxLtSh0qi9rJEctCd4ovZGGhiED3lMkFGe4TKIUxM+fPI9fmG+HUfBQB4EHK9lhvflEgK0H4kQ/nVVfmRL7KWcYWaEbUnylX8CqU0Q/JzJXKQDty6ojU9QntFDRyp70qVRw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799012)(40470700004)(36840700001)(46966006)(47076005)(82740400003)(5660300002)(6666004)(16526019)(26005)(336012)(426003)(70206006)(2616005)(1076003)(8676002)(4326008)(54906003)(478600001)(6916009)(2906002)(7696005)(8936002)(36860700001)(70586007)(36756003)(41300700001)(316002)(83380400001)(86362001)(356005)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 20:35:13.8153 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec121d6e-2ea4-4212-0f8b-08dc16d2a488
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5927
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arunpravin
 Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

- Add a field in struct v11_gfx_mqd for userqueue
  fence address.

- Assign fence gpu VA address to the userqueue mqd
  fence address fields.

v2: Remove the mask and replace with lower_32_bits (Christian)

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 11 +++++++++++
 drivers/gpu/drm/amd/include/v11_structs.h |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index bb9450e0a613..4bdcf46a21a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -50,6 +50,7 @@
 #include "nbio_v4_3.h"
 #include "mes_v11_0.h"
 #include "amdgpu_userqueue.h"
+#include "amdgpu_userq_fence.h"
 
 #define GFX11_NUM_GFX_RINGS		1
 #define GFX11_MEC_HPD_SIZE	2048
@@ -6545,6 +6546,14 @@ static int gfx_v11_0_userq_create_ctx_space(struct amdgpu_userq_mgr *uq_mgr,
 	return 0;
 }
 
+static void gfx_v11_0_userq_set_fence_space(struct amdgpu_usermode_queue *queue)
+{
+	struct v11_gfx_mqd *mqd = queue->mqd.cpu_ptr;
+	
+	mqd->fenceaddress_lo = lower_32_bits(queue->fence_drv->gpu_addr);
+	mqd->fenceaddress_hi = upper_32_bits(queue->fence_drv->gpu_addr);
+}
+
 static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 				      struct drm_amdgpu_userq_in *args_in,
 				      struct amdgpu_usermode_queue *queue)
@@ -6601,6 +6610,8 @@ static int gfx_v11_0_userq_mqd_create(struct amdgpu_userq_mgr *uq_mgr,
 		goto free_mqd;
 	}
 
+	gfx_v11_0_userq_set_fence_space(queue);
+
 	/* FW expects WPTR BOs to be mapped into GART */
 	r = gfx_v11_0_create_wptr_mapping(uq_mgr, queue, userq_props.wptr_gpu_addr);
 	if (r) {
diff --git a/drivers/gpu/drm/amd/include/v11_structs.h b/drivers/gpu/drm/amd/include/v11_structs.h
index f8008270f813..797ce6a1e56e 100644
--- a/drivers/gpu/drm/amd/include/v11_structs.h
+++ b/drivers/gpu/drm/amd/include/v11_structs.h
@@ -535,8 +535,8 @@ struct v11_gfx_mqd {
 	uint32_t reserved_507; // offset: 507  (0x1FB)
 	uint32_t reserved_508; // offset: 508  (0x1FC)
 	uint32_t reserved_509; // offset: 509  (0x1FD)
-	uint32_t reserved_510; // offset: 510  (0x1FE)
-	uint32_t reserved_511; // offset: 511  (0x1FF)
+	uint32_t fenceaddress_lo; // offset: 510  (0x1FE)
+	uint32_t fenceaddress_hi; // offset: 511  (0x1FF)
 };
 
 struct v11_sdma_mqd {
-- 
2.25.1

