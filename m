Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8DC6EB8FA5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 10:11:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E6A710E5E9;
	Wed,  6 Sep 2023 10:11:00 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2077.outbound.protection.outlook.com [40.107.96.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA13B10E5E8
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 10:10:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NF9S9zcGLxqTfJpXRGzDROQoQScTih0wkLDRvtkocfo0/cYGD1+7GVQU7bGyustZsXjn3Qa7jxIQ0UrDAlT3VDYVme1+6kduY9vPjNSvywZO04NEMfDtnBPPvbOI672OM0wP7qRIpNjzo2WEiBFg6qPl/PNgcjF7TQ7fq/m2m8nFbCDCkSrhkYdGy56p85jvPGJXPdiAxXji0tSq4J0HHM4x5xhxrR/j2o4t4imFyB4hysaZTHEmLvZHOZw9PO/wpsq/9BJHC1V2b3CesPcMNCFC7iRV3pupmvs8pvN/2jlAKzJZdJtf+OIRN65Hh8HOwxMZSt5yqGoSO+S95zoASw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZSWVW58ojsHr0iqlWQheVlAhaaPP8VxIVVhqLNjDyvQ=;
 b=Y6URVaiVvz0jVd97N+DYeoTUoYJmFZo1hQijJZNpL/sirC6hMnw30Vtk8QryKXHIVLLXblRNFmqGqw4vnN+mUejdxsGyrjPXmIToWP1gJ/qKqOujoYCtSWZ7Xvl/s72p0jVmHwq9Jm2FxiHYShRXykREFq8zcXLjUGjXNE/Bx1oHuTrW8/IQKOynBmuj1o5ksZiwL8aCX58/9oKjuP24an9VBIw5I8sDKvrGCA4xPMDwS2ctYiiJU63sUQOXpIUHqGstubejJ6BmcdJmpU72MyYYuXG4EEekN3I+3JcOfJNrkFloTbTBz5r490HC2Xqkm76a+E7vdatSk1w4m5ms7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZSWVW58ojsHr0iqlWQheVlAhaaPP8VxIVVhqLNjDyvQ=;
 b=E3bjvKN+dx9gTrTy7t/iVoVW69ZDCU68zKehSqTte9d+ntyWG+lcnEm3e/1IO6iCOwfWLL0ABxx4uFFueEYFDUp7etbGfpFNHile/sBRDvexLblW0gyDOREiskJ3CWDDqsw3uQMDzulLkfeYhdy0zmO+kkF7Eq8HUtuQe/8iFbQ=
Received: from BYAPR06CA0015.namprd06.prod.outlook.com (2603:10b6:a03:d4::28)
 by CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 10:10:55 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::40) by BYAPR06CA0015.outlook.office365.com
 (2603:10b6:a03:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 10:10:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 10:10:55 +0000
Received: from taozhou1u2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 05:10:30 -0500
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <hawking.zhang@amd.com>,
 <stanley.yang@amd.com>, <Candice.Li@amd.com>, <yipeng.chai@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: add channel index table for UMC v12
Date: Wed, 6 Sep 2023 18:10:15 +0800
Message-ID: <20230906101016.22726-2-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230906101016.22726-1-tao.zhou1@amd.com>
References: <20230906101016.22726-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|CY8PR12MB7195:EE_
X-MS-Office365-Filtering-Correlation-Id: cdd2da2f-c7e8-48bc-8af1-08dbaec18f00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ztpuVfPJEJfgDWtFrHilWlkd+Il6HZ1gFN6RHCLqpCVDSbbmBeSmaeCDPf6QnXGcIoVucmjQYSyBsicdmfst8JNzm+LvHOa8sq3yCVJgtl2jIMb0ueM8YXniNp/RaIAu9Z5c8NuAwiCUNpZnqIQ3R3IYusRFksVXLxMFKMMkwCvbIItqISCM5rD7vN5QyxH6AAjS65P5nWHFgWKCGf/tg+8eH0aGNg8VYqvqqw4X9m/XaeNgQ5PSl9ZYYABs7NKu4Nsvjw92IuloiRkBHhhcf1tstota8WiikDfRzrdzoFBv8EEpz84g3jJyneR7D/0G0DfGQqfLD2sqtGLVhc/GY5H8n0eVMIONRz4W+uk/VNrkItGL0LmIDvXi37woywf5A8rJPLlYLs3rx0kNAD8tcsAbrllSSEdoZkSk1gxJPdgNsCCt0PQ+4ReWMscd0TavsEdxFbWh6OPoauMzilq+66U2387E0IS1UjrZYrH5w7e8qdg6YclNnE9xJ2pykDf0ZcnqFcPFf/h/DdQo/fbwTD8BZUr09LWwg+W9os2GghqWmZl1B2tb8B+M5MltrzND/6b7EVFax8Uu6rk+gjCjxuAOqpwQbKqx8YCslbckxaUmPyvSqWLpDtvYVmSrUb5EdSfO4F7PHaQ+jIhjzZ0q1spayIt354WKPXZmgZ0LwCFYpb01mAx7v8d2+Hc7j416+Y/fgCGndLYb+DJYdt4d0bqmAjd7cCD3ak5EiJFKBpLpnD0q+V62lQkPWTQgDHHX11pjVLCmm84XYfc1fMW8Qq0igcPpcdhuXJZSDIEUjf8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199024)(186009)(82310400011)(1800799009)(36840700001)(46966006)(40470700004)(8936002)(4326008)(8676002)(478600001)(110136005)(70206006)(70586007)(5660300002)(40480700001)(2906002)(6666004)(41300700001)(316002)(6636002)(86362001)(7696005)(40460700003)(82740400003)(2616005)(1076003)(356005)(81166007)(26005)(16526019)(426003)(336012)(47076005)(36860700001)(36756003)(36900700001)(358055004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 10:10:55.2749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdd2da2f-c7e8-48bc-8af1-08dbaec18f00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7195
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
Cc: Tao Zhou <tao.zhou1@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Get UMC phyical channel index according to node id, umc instance and
channel instance.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.c | 14 ++++++++++++++
 drivers/gpu/drm/amd/amdgpu/umc_v12_0.h |  5 +++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f12c6c7e6204..7af6659ca936 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1498,6 +1498,7 @@ static void gmc_v9_0_set_umc_funcs(struct amdgpu_device *adev)
 		adev->umc.active_mask = adev->aid_mask;
 		if (!adev->gmc.xgmi.connected_to_cpu && !adev->gmc.is_app_apu)
 			adev->umc.ras = &umc_v12_0_ras;
+		adev->umc.channel_idx_tbl = &umc_v12_0_channel_idx_tbl[0][0][0];
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
index 2a135fd8ec15..5f056dd7691e 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.c
@@ -27,6 +27,20 @@
 #include "umc/umc_12_0_0_offset.h"
 #include "umc/umc_12_0_0_sh_mask.h"
 
+const uint32_t
+	umc_v12_0_channel_idx_tbl[]
+			[UMC_V12_0_UMC_INSTANCE_NUM]
+			[UMC_V12_0_CHANNEL_INSTANCE_NUM] = {
+		{{3,   7,   11,  15,  2,   6,   10,  14},  {1,   5,   9,   13,  0,   4,   8,   12},
+		 {19,  23,  27,  31,  18,  22,  26,  30},  {17,  21,  25,  29,  16,  20,  24,  28}},
+		{{47,  43,  39,  35,  46,  42,  38,  34},  {45,  41,  37,  33,  44,  40,  36,  32},
+		 {63,  59,  55,  51,  62,  58,  54,  50},  {61,  57,  53,  49,  60,  56,  52,  48}},
+		{{79,  75,  71,  67,  78,  74,  70,  66},  {77,  73,  69,  65,  76,  72,  68,  64},
+		 {95,  91,  87,  83,  94,  90,  86,  82},  {93,  89,  85,  81,  92,  88,  84,  80}},
+		{{99,  103, 107, 111, 98,  102, 106, 110}, {97,  101, 105, 109, 96,  100, 104, 108},
+		 {115, 119, 123, 127, 114, 118, 122, 126}, {113, 117, 121, 125, 112, 116, 120, 124}}
+	};
+
 /* mapping of MCA error address to normalized address */
 static const uint32_t umc_v12_0_ma2na_mapping[] = {
 	0,  5,  6,  8,  9,  14, 12, 13,
diff --git a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
index c20b4b4cbfda..e8d358ed8e61 100644
--- a/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
+++ b/drivers/gpu/drm/amd/amdgpu/umc_v12_0.h
@@ -115,6 +115,11 @@
 #define GET_CROSS_NODE_ADDR(reg) \
 	((((reg) >> 32) & 0x3) ? ((reg) | (1ULL << 34)) : (reg))
 
+extern const uint32_t
+	umc_v12_0_channel_idx_tbl[]
+			[UMC_V12_0_UMC_INSTANCE_NUM]
+			[UMC_V12_0_CHANNEL_INSTANCE_NUM];
+
 extern struct amdgpu_umc_ras umc_v12_0_ras;
 
 #endif
-- 
2.35.1

