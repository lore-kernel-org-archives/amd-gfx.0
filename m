Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0AA4EB64D8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jun 2023 21:11:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF5110E68C;
	Fri, 16 Jun 2023 21:11:18 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A81DB10E68C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jun 2023 21:11:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ekk/24rJyEJ2yKYV6WA0Oo1Re4WQoioWiZNbaA86IUoV/sadDnGYP2nC3zVpRxBv6qdb5HTiUTcKTz6ePApHp/V5DcpfvGmdEnjj7gNQkAIGczAZGDN62+SnBz9L3LR1IYE6nPP7bhlzuQ46O2xoyXtdqbiFsbgi6/aInQTewuvNyAc2Uy/EUg4o9wf98lXgoJ3PlfrjyCY1IHG8qkA7J2QXE3vbSpWJFEMvaB9Bk1FPEPsg6YIeDrTEHG6wV+fu1qvwNAANZvK28vBMbUxYoB4l7ryM2lL2jnwyve3Hd4VTcIrbKlps2cUriXcBE26T7pKePb8Oo0oPxAZnRAfb7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so0I8w/qpPparwa4e2n8nP7bASoKt9d86zXrp1KT2ds=;
 b=lnKzcvjf6p8mL3DoN88XphtXrFbPJUE4eC39JZeJDSG2KkNGRdWWqNvHiQVjRhwX2+prthocs3t39R+j/bhX9YvcQxbqMZr/Iwdsa1Dp38hUM4SQ+qOFYiFhiFu3iUjC37o66gi9s6TQziFtUKX4rCf6V9OgMqWoSCeHv2P6nFRNac9Y8ViXRwLX+8DiP3tIx2SKmYRJbDhi345KJzsqj+5SFU10HYXp++vVQnDMYzLGh93Bua2fSdrmY9Ts38iwrxYTs5Vm4vXFRPHNm0rdk0sWjR7T4rDeUhk+gdXI8Isf7MBDQTPC5phMw6dsMBaN+tc1lIakibME/pdQ/wAVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so0I8w/qpPparwa4e2n8nP7bASoKt9d86zXrp1KT2ds=;
 b=r/ktLhyMqqzLFem8hlYaCt9ETtOV5dx+NCBmsgY0CuUxDR9WQF9kyl09n8hp7RCjK1dwd6s+LyV5EtdUKx3dfJsYRkDESNYEF99wd5BCwEzq2qLz95PF295ePv2MWGaCTJdvtRh7+JRkOH4T+hgix+Tj7ncwh3njQt29pvBDaxg=
Received: from DS0PR17CA0022.namprd17.prod.outlook.com (2603:10b6:8:191::21)
 by DM4PR12MB5373.namprd12.prod.outlook.com (2603:10b6:5:39d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 21:11:11 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:8:191:cafe::92) by DS0PR17CA0022.outlook.office365.com
 (2603:10b6:8:191::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25 via Frontend
 Transport; Fri, 16 Jun 2023 21:11:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.211) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.27 via Frontend Transport; Fri, 16 Jun 2023 21:11:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 16 Jun
 2023 16:11:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu: enable mcbp by default on gfx9
Date: Fri, 16 Jun 2023 17:10:11 -0400
Message-ID: <20230616211011.31578-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230616211011.31578-1-alexander.deucher@amd.com>
References: <20230616211011.31578-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|DM4PR12MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: e8598df6-9901-4a86-010e-08db6eae35ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jEt0MDXWRfZ1DNBQMLkBkq0YbymvxuOeZ7kZGC5THaRW7l5ofNR1xsOFyqOTvwr8OsfwBJoO6PfI3yVvRrlCcVB/PSJxNQ5OmCjJYkpdHhLzliMWbwwyz1h7tsdfoY0nuwGWAoFiBlC0UMAH3k7UslAiC9537Zwl0HPSzeLsdZoJn3hO7KZVsGKW/zeBTryWC5s8D8b0oB8Ol+eLCgvr12nWkS52imiltOCCWhvFfSNV6DerYpDWtOGZmtETzqaO2tGN4IxNd89dG/IS37Myedny8jtOSNYnXrg8nwthhI25EkNIX4AVA0RPeV9Lg3bNxmzFsAKOmgP7HmDhET/y9EAMxdCXkTRBQTVJNtdkMLB6DMo3B6N6I7BwOOsTyAIJ57i0zX4EkRUu9PsggQmuqStSz+2IHnfnbFHywVEFeCYSTcH2LPMAmxLQWYQEgbszRWI8Ty37XDGWzdMmt6+mywIet2Yk0D315NKhswy9bOPHTnCsV3BBmrE9Emwr63bT5/w4R9G6vI6qCtM/ADAT3y0hqeyU92ShJptqPk/8s9tT9CuJWDGk7Cq4cNTUz+0zW7b9st4tuPfK/Fsy0l/uWr5o7jZpi2M4F74Fc/s/UecbJcKk6Vbb2Ba3b9IPVVE/OZk92V6NCN6dgh3UEl8picz4TLJUUJwmJaSrMC/O/SLhG5OXPZkN+xGwxqEKS12IW7YjD/kzTYMiOOzL7GiDzq/zej19wt+7GJYijOG1INs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(26005)(1076003)(6916009)(4326008)(316002)(70586007)(70206006)(16526019)(426003)(2616005)(47076005)(336012)(83380400001)(186003)(36860700001)(7696005)(966005)(356005)(81166007)(40460700003)(478600001)(82740400003)(40480700001)(8676002)(8936002)(5660300002)(41300700001)(86362001)(82310400005)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 21:11:11.0340 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8598df6-9901-4a86-010e-08db6eae35ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5373
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

It's required for high priority queues.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2535
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 6 +++---
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 78c6265fe79b..3eb370b77ad9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3677,6 +3677,11 @@ static void amdgpu_device_set_mcbp(struct amdgpu_device *adev)
 	if (amdgpu_mcbp == 1)
 		adev->gfx.mcbp = true;
 
+	if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(9, 0, 0)) &&
+	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 0, 0)) &&
+	    adev->gfx.num_gfx_rings)
+		adev->gfx.mcbp = true;
+
 	if (amdgpu_sriov_vf(adev))
 		adev->gfx.mcbp = true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 03874371af60..308149dd7d00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -180,7 +180,7 @@ uint amdgpu_dc_feature_mask = 2;
 uint amdgpu_dc_debug_mask;
 uint amdgpu_dc_visual_confirm;
 int amdgpu_async_gfx_ring = 1;
-int amdgpu_mcbp;
+int amdgpu_mcbp = -1;
 int amdgpu_discovery = -1;
 int amdgpu_mes;
 int amdgpu_mes_kiq;
@@ -635,10 +635,10 @@ module_param_named(async_gfx_ring, amdgpu_async_gfx_ring, int, 0444);
 
 /**
  * DOC: mcbp (int)
- * It is used to enable mid command buffer preemption. (0 = disabled (default), 1 = enabled)
+ * It is used to enable mid command buffer preemption. (0 = disabled, 1 = enabled, -1 auto (default))
  */
 MODULE_PARM_DESC(mcbp,
-	"Enable Mid-command buffer preemption (0 = disabled (default), 1 = enabled)");
+	"Enable Mid-command buffer preemption (0 = disabled, 1 = enabled), -1 = auto (default)");
 module_param_named(mcbp, amdgpu_mcbp, int, 0444);
 
 /**
-- 
2.40.1

