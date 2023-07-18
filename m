Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5236CEB64DC
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Jul 2023 05:14:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D848C10E2CD;
	Tue, 18 Jul 2023 05:14:29 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::618])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A271F10E2CB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Jul 2023 05:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImXVOOQ0ceBdutcZfpGe0sbTMmwDCkmqrz7nNuczHutw0SB+9jxi8rI1/FDCG0D7izYkHq8v2oKHSc4qA8pfB0s6OUpZDrGwWpLFijpH8PgI1bYGpphMcjdyf9dpJC7nuoFlIp0zEuqBiXBTs/U4d03VWcIYSCtgP4Qz/Vm5QFi+Df77YC6CovnGACiI0pHnJetUf+9IdwshWh3RqqLWcU/duMxPFHlCEJV+xzZTJSXGWoJHEm7tmy8GH3iOdPrQu8O8GTTxx2BP9xbk3xTiZUesezm5/AFK+oHgXGCC4moz0RSM3t10ANPfavIyGJbi0T+YX+eyAe1WepR7K7wHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fsKDuUByngHP2oAuaieVLx4dijdp9+3BKQBndhF4tas=;
 b=RDH2nxDRvY4PKnWLSFp1g82pTZsi9pxGA+6N0A38aNyZ70WpGV8gc9bOxc7aOEMmchbZOHx2Fwi11zAkiVhN+DHDMMmkU+bLmUg/XfQNo2XGvbhJ4gU/KAENvNLb/KZl0fA19FWGVT0h7i8T+wtrWoxfRmCRvDO5q5wjd/UP0zrSIuOys7aoVEfhuZcGBUOCs6IZlHTvDisbs9ohEnELXu4LpZnorubjGJ1du+kQltbgOsqQvXAA0ZmmgHA3jVHs9KQ73JFLySFshtwF34TuuO9L0eeDi5rC6RoGVFnJ+tHuBxyjt9/V1/pEPSFfUxd6LdCdfNV/PTZPiBR6RjkdkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsKDuUByngHP2oAuaieVLx4dijdp9+3BKQBndhF4tas=;
 b=ugoXoIhk2+FqML+iY8PkFkcfAWrL70qygEhVo+Z75uOysW1gC2sao3vZlCauFCsssie3Ow89JYE+nJWP/p36hnf3yTG2MxPdEqYcSG3jxjGF0jDjyMHWxf+0BfVUCS8AYaWqL1YEqTdy26PBo6CmfMKbPR+EvuHSQoWwUyP8Nec=
Received: from BN0PR08CA0012.namprd08.prod.outlook.com (2603:10b6:408:142::34)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 05:14:22 +0000
Received: from BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:142:cafe::8d) by BN0PR08CA0012.outlook.office365.com
 (2603:10b6:408:142::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33 via Frontend
 Transport; Tue, 18 Jul 2023 05:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT012.mail.protection.outlook.com (10.13.177.55) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.33 via Frontend Transport; Tue, 18 Jul 2023 05:14:22 +0000
Received: from guchchen-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 18 Jul 2023 00:14:20 -0500
From: Guchun Chen <guchun.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <hawking.zhang@amd.com>, <christian.koenig@amd.com>, <Philip.Yang@amd.com>,
 <Felix.Kuehling@amd.com>
Subject: [PATCH 4/4] drm/amdgpu: use a macro to define no xcp partition case
Date: Tue, 18 Jul 2023 13:13:42 +0800
Message-ID: <20230718051342.217902-4-guchun.chen@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230718051342.217902-1-guchun.chen@amd.com>
References: <20230718051342.217902-1-guchun.chen@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT012:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: c4f8a725-75cf-4db5-ae07-08db874dd8e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YtJ5pV9wn7xdNFFDHYmZRIuFesl0tiHcvUcuKVYGizf9ofsihLy4ZoW/ZdP5SC5GI1YvKbTPuyCzkdwDGU9AOoAyVzHkEPcIDQ0khEih/paETbpSJvO/dKz0EyahcshJevztGZRb6xhmrS/KtWmW9y9fBVuGf+UWQZ82qP9EqQOpZkAMOANxly1UHWxYzscvGWX5AUC6BupqL+DVAWmOPam+FlpCHtXPFAFiRZZQu5E4Isbb+2qldsNKp9oQALt7SFKSzvA8jQCFSyxh9B0X7L70wOM5kTnePq1+3eWnZNtyUnYW2w0rLdBj5tibuhwp6uDS9go1479TRLqc1yIPTmLdVprbZ4BLxIQXlvTN6GvSd0E9KsTg7NFeOGcUf1UWmlidfDcVe3+q0hNQFdt3dqI4ztqDUFmf3/Kyi9Caa4jJecKvdYTXoQ6o+m1o63Qh8TbSq5YiiqdU90+HbwFsLiD2bAXa2HlDnJGR61SYFmoX+ONU1lgmCSzTzivJ4jFD+PkTS4ErLYkrWZPDLhYUKkClXCKcnqtIHg+2w/4z58+1rGk4FrhtIvik6ntQFVhHH525mEHYWB6Amh7tv6tsxD5WZ5v3VJXSWLomRqqZyPExd0B8wDeb0tQ/t90FiZxNFu38dUaA0qaQUmcfniHHJU2qrykfIJHq7UwXNhhh7FJP2684pNvDoKzQBdUKc0oDiejbgbhL7KJsNkcabld24z5cd5tv4LfSRpwP7JNgB8lYz8ae6/YqfZ5fVD0DdEx2bwSirBbpQMftg2LBj2w42w1enh9hzjNHBaFl8bh6pCw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(39860400002)(346002)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(86362001)(2906002)(36756003)(44832011)(40460700003)(6636002)(40480700001)(47076005)(2616005)(426003)(16526019)(336012)(83380400001)(186003)(36860700001)(66574015)(1076003)(26005)(356005)(81166007)(7696005)(82740400003)(6666004)(110136005)(4326008)(70206006)(70586007)(5660300002)(478600001)(316002)(8676002)(41300700001)(8936002)(2101003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 05:14:22.3488 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4f8a725-75cf-4db5-ae07-08db874dd8e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
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
Cc: Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

~0 as no xcp partition is used in several places, so improve its
definition by a macro for code consistency.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Guchun Chen <guchun.chen@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c          | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h          | 2 ++
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c       | 4 ++--
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a7f314ddd173..d34c3ef8f3ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1709,7 +1709,8 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
 			alloc_flags |= (flags & KFD_IOC_ALLOC_MEM_FLAGS_PUBLIC) ?
 			AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED : 0;
 		}
-		xcp_id = fpriv->xcp_id == ~0 ? 0 : fpriv->xcp_id;
+		xcp_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ?
+					0 : fpriv->xcp_id;
 	} else if (flags & KFD_IOC_ALLOC_MEM_FLAGS_GTT) {
 		domain = alloc_domain = AMDGPU_GEM_DOMAIN_GTT;
 		alloc_flags = 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
index d175e862f222..9c9cca129498 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c
@@ -363,7 +363,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 	if (!adev->xcp_mgr)
 		return 0;
 
-	fpriv->xcp_id = ~0;
+	fpriv->xcp_id = AMDGPU_XCP_NO_PARTITION;
 	for (i = 0; i < MAX_XCP; ++i) {
 		if (!adev->xcp_mgr->xcp[i].ddev)
 			break;
@@ -381,7 +381,7 @@ int amdgpu_xcp_open_device(struct amdgpu_device *adev,
 		}
 	}
 
-	fpriv->vm.mem_id = fpriv->xcp_id == ~0 ? -1 :
+	fpriv->vm.mem_id = fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION ? -1 :
 				adev->xcp_mgr->xcp[fpriv->xcp_id].mem_id;
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
index 0f8026d64ea5..9a1036aeec2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h
@@ -37,6 +37,8 @@
 #define AMDGPU_XCP_FL_NONE 0
 #define AMDGPU_XCP_FL_LOCKED (1 << 0)
 
+#define AMDGPU_XCP_NO_PARTITION (~0)
+
 struct amdgpu_fpriv;
 
 enum AMDGPU_XCP_IP_BLOCK {
diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
index 16471b81a1f5..72b629a78c62 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram.c
@@ -68,7 +68,7 @@ static void aqua_vanjaram_set_xcp_id(struct amdgpu_device *adev,
 	enum AMDGPU_XCP_IP_BLOCK ip_blk;
 	uint32_t inst_mask;
 
-	ring->xcp_id = ~0;
+	ring->xcp_id = AMDGPU_XCP_NO_PARTITION;
 	if (adev->xcp_mgr->mode == AMDGPU_XCP_MODE_NONE)
 		return;
 
@@ -177,7 +177,7 @@ static int aqua_vanjaram_select_scheds(
 	u32 sel_xcp_id;
 	int i;
 
-	if (fpriv->xcp_id == ~0) {
+	if (fpriv->xcp_id == AMDGPU_XCP_NO_PARTITION) {
 		u32 least_ref_cnt = ~0;
 
 		fpriv->xcp_id = 0;
-- 
2.25.1

