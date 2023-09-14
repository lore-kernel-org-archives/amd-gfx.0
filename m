Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F78EEAA60
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 18:22:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 342BE10E2AB;
	Thu, 14 Sep 2023 18:22:28 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06AFC10E2AA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 18:22:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gzYSBmp9ZVFvPk1IfnBkIpOlzDM6rmMyOtwpysef4l8qpras6HSnIQdGJ/L65saPD7+BK5Z4igNrrA55IX1VjWscuI4WJxKZegIOBRucRiA5mW5oT2TVrmBEq0OAi5bNuvtTZtzuEwE1jnG5sRBWjoDUg37YqIKUaa24AUg7DWYMkiCS+Fk9s4q4ioERrxX3rfv4ByMNgZ8m9to3CZgqncNfEcsswdQdIWSAmP7NxDvjN4zYp6s1QDA0NSUgJGPzPvtFPNgqNU07LNOO+yqEzM45GvfCGxVs24VQQQ+KaQTVisHgFC/u/TwGvzI95w+/MmBnRL0xaKgepGNX/1QSZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAsZ/B8lTrWnlRB03y3BHCOo5Nx/4OpyfjfoGQ5rzaY=;
 b=JkfuycTMhU0+ypp0n2ZDx61VGjC6eRV3JQcRt+fcMXSo/TNyyX80PRe4wxEccfsyg2CzWNBl7cg+AwNOeeVAGYSOFhIyk6sqPIL7MbOh/ok5hv99Kq0smWfQxYkfLJcA41bnaFqLA2rGspDyGofU2ooudupx5fluA7HTbYa7h/B6znkzPxYY0Z0rFY+HZdmdXv+fgthJ79P5kM45IjplD/wpj5Qp10o+RMwV36FrMErbbBrW2Cacn4QXA3oICW5qhDs9W8zQuIVr5Xz9W6gCBY4mqGasTILzgbzAt9h6rrXIbBez6Kn3BIlPrp2Qn00FaGvTE3SgNcsUH66+4bzUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAsZ/B8lTrWnlRB03y3BHCOo5Nx/4OpyfjfoGQ5rzaY=;
 b=Xg3nATd+OJ5L2K/vd//PUeF8YR2NQUiga+M9rQyTG/65jQxquF66Aku7+WUAQNl/UI9WBAqymPdVpnyr9PKxV39ZxF6/4n8wwDjWXaSUR2h+6IjM4rpGxpPsbbxPYC5JEMwJHItFfEh7u/54WaJHv1wxQc6B2ccOwkYoS6adnBY=
Received: from CH0PR04CA0068.namprd04.prod.outlook.com (2603:10b6:610:74::13)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Thu, 14 Sep
 2023 18:22:22 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::57) by CH0PR04CA0068.outlook.office365.com
 (2603:10b6:610:74::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 18:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 18:22:22 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 13:22:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amdgpu/gmc: add a way to force a particular placement
 for GART
Date: Thu, 14 Sep 2023 14:21:57 -0400
Message-ID: <20230914182200.679059-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: cd4fb18c-0148-4fb3-c5a8-08dbb54f89ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cM5rwasS1RQLRyr07NCx9OLka9HSaOnHHRSefG0Jr+h2I2SGLVXr5rs0nNuEkFuTr1eLXHrxW5OmWp8MptbUQTQTEg5+Ujf6vvo7hMEIoZvqjC/NJ1GoXFW+qywvwDgeODf1z8U+S7CbU4KltulJzdq4vwypzFwu5E/efpybuR4O+bGp3gYtTyxYh0K4ihSPvSfF5Jhmf8oktzNUShQZaoX1eJCAUZAxBqxLIuioZezsR1XIeHLXwJmiQ3xS/DQKq3X7IwPLVRwWfOefrfO29g90ZlVkul63DtuMWMaKc7vxVfN6lSpgIUp2zrOJ1Z7vIYHPIim62xyXRXcNCWBselQov555ubYEouGFn+GYoiIHHjpZH2jVPM+IItPqT6FznHF/jzeYvj2x0eb5KA1gfGCijl5/5ultgrD+jQKFNKeEzN3ex1VHpg9qq8xrgyJZXEwWDPt5xG/IdRd0S/kOio8UQF0Bk4AXhWiMD5ZhMfiWhgUcBN/OZvOF0fIo2hvwUi9Q8N0KxMBBM3ZKfeKg0SDKIhI909o7wlhHe3Cy2XsU0kshUbLdXJdE/2o6Mr9oRAN4813dtRrC8Wbz1ASe3v6teNlnstTSPzpGcwoC7+Qjle8dVg1ngT1Ot+7FVMqAQtChpBglPwcO1pI/QHF+2tYOiOE4DXw1NpBN+YZyGkaAvAUE6glswRKJU6BonrO84GvWfnImwxctz7SaO36x3e9SMILriqY0YoIWguayBEMESkZbVDKNLOQLlYjJE64LV/Juw9wFGPoF/tTJxmbbwqbZvCX1uPY6O6iAVUJqqho=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(136003)(346002)(186009)(451199024)(1800799009)(82310400011)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(316002)(6916009)(478600001)(81166007)(70586007)(70206006)(2906002)(86362001)(36860700001)(8676002)(41300700001)(8936002)(4326008)(5660300002)(83380400001)(47076005)(82740400003)(6666004)(1076003)(336012)(356005)(7696005)(2616005)(426003)(16526019)(26005)(36756003)(43043002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 18:22:22.3380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd4fb18c-0148-4fb3-c5a8-08dbb54f89ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We normally place GART based on the location of VRAM and the
available address space around that, but provide an option
to force a particular location for hardware that needs it.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 +++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  7 +++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c7793db6d098..c41321c456fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -286,11 +286,22 @@ void amdgpu_gmc_gart_location(struct amdgpu_device *adev, struct amdgpu_gmc *mc)
 		mc->gart_size = max(size_bf, size_af);
 	}
 
-	if ((size_bf >= mc->gart_size && size_bf < size_af) ||
-	    (size_af < mc->gart_size))
-		mc->gart_start = 0;
-	else
+	switch (mc->gart_placement) {
+	case AMDGPU_GART_PLACEMENT_HIGH:
 		mc->gart_start = max_mc_address - mc->gart_size + 1;
+		break;
+	case AMDGPU_GART_PLACEMENT_LOW:
+		mc->gart_start = 0;
+		break;
+	case AMDGPU_GART_PLACEMENT_BEST_FIT:
+	default:
+		if ((size_bf >= mc->gart_size && size_bf < size_af) ||
+		    (size_af < mc->gart_size))
+			mc->gart_start = 0;
+		else
+			mc->gart_start = max_mc_address - mc->gart_size + 1;
+		break;
+	}
 
 	mc->gart_start &= ~(four_gb - 1);
 	mc->gart_end = mc->gart_start + mc->gart_size - 1;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index fdc25cd559b6..caa15639d3d5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -197,6 +197,12 @@ struct amdgpu_mem_partition_info {
 
 #define INVALID_PFN    -1
 
+enum amdgpu_gart_placement {
+	AMDGPU_GART_PLACEMENT_BEST_FIT = 0,
+	AMDGPU_GART_PLACEMENT_HIGH,
+	AMDGPU_GART_PLACEMENT_LOW,
+};
+
 struct amdgpu_gmc {
 	/* FB's physical address in MMIO space (for CPU to
 	 * map FB). This is different compared to the agp/
@@ -333,6 +339,7 @@ struct amdgpu_gmc {
 	u64 MC_VM_MX_L1_TLB_CNTL;
 
 	u64 noretry_flags;
+	enum amdgpu_gart_placement gart_placement;
 };
 
 #define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
-- 
2.41.0

