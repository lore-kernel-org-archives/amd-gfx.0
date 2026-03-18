Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30B40107BCF2
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 10:39:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31D910E7BA;
	Wed, 18 Mar 2026 10:39:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D3SPGEu6";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010039.outbound.protection.outlook.com [52.101.61.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF4B10E7B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 10:39:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZAVENWgrvlu+V/HwLtkiXHTfLezVoQEwSnhxlP1RiEPxgBtAZ3WST0z/AG0nO7URMHPA0zGw7sikXO6JuR6cKrD9FrwVINUNJHqeSZ1G2xJ7f6zBhmBz+/BbUknX6MVebvsY3+wDey+i+2FEz1GtyLj0UeX70aCK+haitIfDklgRt37fuykraoZaydGyfnEhXNR3xQ/UOKot3CUm+OirdOC0XAuy3FttaeefozJ88PVPCmms+jkaGLzMciF0loSCK+jA57GqimUdME7cg+9VRVP1dPJQChGskzwKw5LS854f4Z8fdexrB+9wzTYnc7DACxDmVy6wgofJq6HrLUmkAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xVEj7SAf5/73R7+QRJUOD9Fhjz4eQgwqJkb5q3sTEEE=;
 b=Mt+klQ/FeEREt/SW3bZzqUcK8zS0mCMa3RZjmBosQvRaDNyVzPz3sPYEiEsL8xVhFL0twwt6sqJuiha7DpGl1dfuOVkNo6SlK2yp1BVZftntiG9JKuRQ/u/nh7fQuCMq9FhPy5VdHniv3KyDESwqXX6XKAVn3znY+gHFx3nSUkcibA89gokA8G+JWEKfJ1mExergLI0kYdeVIyfc57g7Bktcvm6/1zqfnooZPw/MGVzW63qBWtA0t1gZptmDeUJmuUIZKiz4AC5HqbvXSU4NDv9SkqqQsYZKy4aoaSYfW0VAe+pJHQdxoo/v+N0C6JrW7aRyvW3SP+ozbpKLzwMcLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xVEj7SAf5/73R7+QRJUOD9Fhjz4eQgwqJkb5q3sTEEE=;
 b=D3SPGEu6tqLV02FiH3OMyw/n1Y+noBDhWKHjPG6b2Fkhfh4Y7h2h/Zy12FnTUbJZ66ebPZt6VGe4psY6ll+ys2aRb2YdLfG5zyfZzZ+Rb9hT5RV11atn1FePtb9wvmT7d/C5gcheOJiO/bNdW+n4StWMl2dZMb1rKIyspkxeD2U=
Received: from BN0PR04CA0140.namprd04.prod.outlook.com (2603:10b6:408:ed::25)
 by CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 10:39:32 +0000
Received: from BN2PEPF000044AA.namprd04.prod.outlook.com
 (2603:10b6:408:ed:cafe::e8) by BN0PR04CA0140.outlook.office365.com
 (2603:10b6:408:ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 10:39:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044AA.mail.protection.outlook.com (10.167.243.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 10:39:32 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 05:39:29 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH v3 3/4] drm/amd/pm: Add OD_FCLK interface
Date: Wed, 18 Mar 2026 18:39:05 +0800
Message-ID: <20260318103906.3107670-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260318103906.3107670-1-asad.kamal@amd.com>
References: <20260318103906.3107670-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AA:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: d7e53055-3d97-4180-ff2f-08de84daa401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: iEtytDvSaUkFqaS6ZZGibzZZJ1zsfyuM6B2Zz+OutidLozFC6PtMOWzaRpalM+cTXZxQGe9Gvfut61Q2Zncnh1P3AYXYROz/NO8l4YkVlPNBPYl+62pxuUCdlEZ+H9z6UaTKVEBWuQmOIuxDXDURBOoNLv3NnHLM4XVY56FSBIlM23GmW+lciNVfeMy4DxB+iHXRUn/Da7zpTb1L0XJIDsJJG0S3U3pqbx8uz/ElUjazUbmMeyu+OrHkgsn/550Nlt+jYuBYOWqtb6HoSVo2dt0kBaPnovS97TQJOSQpAFE9JWFhVXWtaalXxnv9Jr/o8l+xn2etrC2s7bvK+dr0wWTBSDoC2prgLxE/dgia+gTiYFQEThxphZAglNhIF4eVU17WoAwCGuc96Ifx1EO0eRBWfmMniRdzxOvWhWxLE35JmxC6P4QhimrvF5spYb2/7RX7wWf4hHNUFupvCxa2mHYlEYINhj33uhVej8YO8aCKuGy6lSDtoWAmiSWSin8U1JIWg1W7+e90B2Lpyn8To2rr8tP9DEWwf9ZkkqRbMVklnOICJrQixnJXc1vIn/M/wM8ImML9IbzEjL7JxyxN+oK2YmGi1anEjLcPJqK8TtLT9Il80mWd7LXl6Jr9UaKdTa2cMPMWSkMF3ejuo9kFxyEnML5WJ/zD62OU6i18m+nDCT5YEaWd/w7G9ixI81oHPNJVK7cIzxat0lVr6U6nKBvhaTNJM8MxIAaQ0nifDN5Dk1cYJFgPgaCuIio1O5gWKxglF1sTLFfOhrKGWxBlbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: E3l63+7kirwfEwdN4HcuXyvePa0gIX5/NNilJ4Sb4jmGndM2ZVXKebHvK3YQbfShNYERfHnbDBz23AKsnDHHROZryuzoboButiZSCSvGg/9pMnTHZpgz9vGb4qxwOHod3gpRUwPG1cb4+cOZCct1sGtx11hS9Oe1Gdg3ZwWORMwU5bsEpYsWKSrJ2/B+/JVtKJ/QmhRuHGXouHM1NXaqp2dvtW6rvxlXsEPuXAkPN0W+l8pQTSoZk/JQAqYG1IUBz5zd4ZugXRg3T91XKl1QxECTst8cd9WScD/E5nGX91FLijSM8Q51EJ/lVh/3YoEorZiEpSibsJAaQdllfp1smga/tnniJFxqBkRVmXnL41BxLQAoUEDQBO6CByhTbYltl0/dTDCBxSg5VdzCuftoTNeXCthb7LdllVwbIUTY/hw+btWzBa/XCGfezYtk2kvE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 10:39:32.2094 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7e53055-3d97-4180-ff2f-08de84daa401
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673
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

Add OD_FCLK interface to set customa fclk max

v2: Merge patch1 & 3, check EOPNOTSUPP for all clks (Lijo)

v3: Remove redundant check (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/include/kgd_pp_interface.h |  2 ++
 drivers/gpu/drm/amd/pm/amdgpu_pm.c             | 18 +++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c      |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h   |  1 +
 4 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index a9b73f4fd466..33a1404bb666 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -119,6 +119,7 @@ enum pp_clock_type {
 	PP_ISPXCLK,
 	OD_SCLK,
 	OD_MCLK,
+	OD_FCLK,
 	OD_VDDC_CURVE,
 	OD_RANGE,
 	OD_VDDGFX_OFFSET,
@@ -208,6 +209,7 @@ enum {
 enum PP_OD_DPM_TABLE_COMMAND {
 	PP_OD_EDIT_SCLK_VDDC_TABLE,
 	PP_OD_EDIT_MCLK_VDDC_TABLE,
+	PP_OD_EDIT_FCLK_TABLE,
 	PP_OD_EDIT_CCLK_VDDC_TABLE,
 	PP_OD_EDIT_VDDC_CURVE,
 	PP_OD_RESTORE_DEFAULT_TABLE,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 938361ecae05..01ff24880fe2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -680,6 +680,8 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  * - minimum(not available for Vega20 and Navi1x) and maximum memory
  *   clock labeled OD_MCLK
  *
+ * - minimum and maximum fabric clock labeled OD_FCLK (SMU13)
+ *
  * - three <frequency, voltage> points labeled OD_VDDC_CURVE.
  *   They can be used to calibrate the sclk voltage curve. This is
  *   available for Vega20 and NV1X.
@@ -715,10 +717,11 @@ static ssize_t amdgpu_set_pp_table(struct device *dev,
  * - First select manual using power_dpm_force_performance_level
  *
  * - For clock frequency setting, enter a new value by writing a
- *   string that contains "s/m index clock" to the file. The index
+ *   string that contains "s/m/f index clock" to the file. The index
  *   should be 0 if to set minimum clock. And 1 if to set maximum
  *   clock. E.g., "s 0 500" will update minimum sclk to be 500 MHz.
- *   "m 1 800" will update maximum mclk to be 800Mhz. For core
+ *   "m 1 800" will update maximum mclk to be 800Mhz. "f 1 1600" will
+ *   update maximum fabric clock to be 1600Mhz. For core
  *   clocks on VanGogh, the string contains "p core index clock".
  *   E.g., "p 2 0 800" would set the minimum core clock on core
  *   2 to 800Mhz.
@@ -768,6 +771,8 @@ static ssize_t amdgpu_set_pp_od_clk_voltage(struct device *dev,
 		type = PP_OD_EDIT_CCLK_VDDC_TABLE;
 	else if (*buf == 'm')
 		type = PP_OD_EDIT_MCLK_VDDC_TABLE;
+	else if (*buf == 'f')
+		type = PP_OD_EDIT_FCLK_TABLE;
 	else if (*buf == 'r')
 		type = PP_OD_RESTORE_DEFAULT_TABLE;
 	else if (*buf == 'c')
@@ -843,9 +848,10 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	int size = 0;
 	int ret;
-	enum pp_clock_type od_clocks[6] = {
+	enum pp_clock_type od_clocks[] = {
 		OD_SCLK,
 		OD_MCLK,
+		OD_FCLK,
 		OD_VDDC_CURVE,
 		OD_RANGE,
 		OD_VDDGFX_OFFSET,
@@ -857,10 +863,8 @@ static ssize_t amdgpu_get_pp_od_clk_voltage(struct device *dev,
 	if (ret)
 		return ret;
 
-	for (clk_index = 0 ; clk_index < 6 ; clk_index++) {
-		ret = amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
-		if (ret)
-			break;
+	for (clk_index = 0 ; clk_index < ARRAY_SIZE(od_clocks) ; clk_index++) {
+		amdgpu_dpm_emit_clock_levels(adev, od_clocks[clk_index], buf, &size);
 	}
 
 	if (size == 0)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 3dc917194154..a2bc1c753e0e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -3056,6 +3056,8 @@ static enum smu_clk_type smu_convert_to_smuclk(enum pp_clock_type type)
 		clk_type = SMU_OD_SCLK; break;
 	case OD_MCLK:
 		clk_type = SMU_OD_MCLK; break;
+	case OD_FCLK:
+		clk_type = SMU_OD_FCLK; break;
 	case OD_VDDC_CURVE:
 		clk_type = SMU_OD_VDDC_CURVE; break;
 	case OD_RANGE:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
index 584c4cfd0c16..8cdbaf32492e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_types.h
@@ -324,6 +324,7 @@ enum smu_clk_type {
 	SMU_OD_CCLK,
 	SMU_OD_SCLK,
 	SMU_OD_MCLK,
+	SMU_OD_FCLK,
 	SMU_OD_VDDC_CURVE,
 	SMU_OD_RANGE,
 	SMU_OD_VDDGFX_OFFSET,
-- 
2.46.0

