Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 338C8CF855B
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Nov 2025 08:34:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D602710E049;
	Thu, 20 Nov 2025 08:34:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rHnVAiC/";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010000.outbound.protection.outlook.com [52.101.201.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A03D910E049
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Nov 2025 08:34:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QM/bbcYPOFSdZtrK9YMbxrnnWRTAkOQUAScWMDu2hKHqEisRa3CLhVmOPBGkmYTCjIoaPc2YVkTFnLtJyY0xuNL/Og9fkkTzgPR7StpVHp04+7a0B0jx42WGSC+mrZ5WrfJaS7vpl5BLPAM4s8qFl5MseRpDIPmR36Wfr7UePTZokzxfMP28KryTMd2e7SOjdTiLqL4InIbGl0ZcMw0llpkgNIM2CVsEuPeR70EakBvweZEVj3OcJHEkUkVaZFpVPXU154t5iQlY29fWFaF7QszOzdKAcLTpN0Hq5UhG9NVBRqebgJOj4fpjAx1HRAY2BdMqKLYpJMtwIeCB+8OOmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kESMTn9wm/XS4mUskqjgEzsq8lxWhHFIX6OmIyKuLJY=;
 b=qwtsApSzkpgFT3f5vZhVZk9Mm5JH2oVzbFvpHrWp8mf6uvQR6Hi9zkmj4+3uyP2Yqc5A6mN16L5inz9xyLLaENULTkieVvmOGUoAWd4uaSwZcSjybqsMXr68+APQR23li9kHIJGOb+czpJmVElISajuCesHahqVgtuxLK1t0JO8lv0uXL5dpr6WkZfn1Mkm8u4V9QUH0Er0dp4NvifD/eXhE7S6UPssRcg5Wy+lEpvthXGL6NReeAMSR5Ufgiatd4ohLNfF5+OrjKkNIg10ORC+7YejJaWNyPWiB3byYFKtMNAu/aU93wdr1PSK14Qxf1cX4fhRNwcSYjK9RFZCG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kESMTn9wm/XS4mUskqjgEzsq8lxWhHFIX6OmIyKuLJY=;
 b=rHnVAiC/iFgtZbkSLAXXvT/alWDkC1XKRJuQslKxLXmbxO+A64Jtzm5blBKpssbGqrjkohitwPt2Z7d5E9Hm0zg/Ze45luF0NqYIoWre1SI0dtnqTkdVL4kA/3MSGS57xb4ZlOtU69t17YmJmtFeHtg2WlaPyXxivf0V73X3uC4=
Received: from BLAPR05CA0040.namprd05.prod.outlook.com (2603:10b6:208:335::21)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 08:34:41 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::f5) by BLAPR05CA0040.outlook.office365.com
 (2603:10b6:208:335::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.5 via Frontend Transport; Thu,
 20 Nov 2025 08:34:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 08:34:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 20 Nov
 2025 00:34:38 -0800
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <hawking.zhang@amd.com>, <alexander.deucher@amd.com>, <lijo.lazar@amd.com>
Subject: [PATCH v2] drm/amd/pm: adjust the visibility of pp_table sysfs node
Date: Thu, 20 Nov 2025 16:34:25 +0800
Message-ID: <20251120083425.2765422-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 68ba5f4a-c39e-44e3-ceca-08de280fa5d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PS/yhUCTYjmxDYv6BiJxHhiH3dHMxDapEQMVTaoQGvofYQG2myr63ewMOn2y?=
 =?us-ascii?Q?hotY1kBz+BdlaMwxQMPb6zrTiIbtJZZy0wnlz8S2xmfNapp65ye4VJNVm5qo?=
 =?us-ascii?Q?v6XiKG9hRJD0b3d25YYIML3jnVeUufTSRLTXG0qIMaLW995eQ1Im3O/003n2?=
 =?us-ascii?Q?/D6DDGESVZujy/E7VxBN5dMvNkyZ8ZBDROPoDqwPslF6D0iEWdvjOmpPGCwY?=
 =?us-ascii?Q?PUwwRlHlJccPuhAsePDSSj+vOp8Ev35geku3F03IfZ8wvsDyQ1mmkAE+BN1Y?=
 =?us-ascii?Q?PpSvcwdMkZ9pYI0KcVfP+07WHhbH+3wp5yh2gbWhaet+MMfpx0s+f5k46/R/?=
 =?us-ascii?Q?j18cn/AH0OJqxlsMvsoZAVXmv3HL4DgvS0h+YOkwaYkkcUbddt2/pV0aoPhD?=
 =?us-ascii?Q?SJRQHx1S4K66J6BbAlawPRB4bvDwdhW3QzhmpO+qPzhw10pLLGD4q+mkuecJ?=
 =?us-ascii?Q?6Ia+kjF9AVjREPtK3cUiCfO2Q12Qh9RdLvni5F9/U4IRC0smJejpVslSe3N2?=
 =?us-ascii?Q?R+agRb0li9vo084E1Yr8WXA/ekBy98LTtaGgGSWaY8F0CSJ7IpjpyprwtWZS?=
 =?us-ascii?Q?N0cZlspNo9uHwLEqkIIDRd0dCia0JBF8pM34jrFyc8EHkv7o4mxZsJGaRRtz?=
 =?us-ascii?Q?V5MLOL//RPvTcr86OJV03eeoFEPzIhjmRf2z4mmMhY5Pz8EIFNrPithJ6dJn?=
 =?us-ascii?Q?EuMut12I+Mvkh5xXeJgccVSifmNYDNjlDCXY1mWxHRVUKisI7GI0td0DlNuX?=
 =?us-ascii?Q?ugOPL2G+YTEODp5v4DtWuJa4/JgqxuH9xQcgSaigbclHB7WAKLM5EdZwk8Z1?=
 =?us-ascii?Q?aB+xRCEAUZ4b5eF9rGoH/Yq/KuxXQ2my3AeyWwAqt9yKMuokn9bLVXNN5O6M?=
 =?us-ascii?Q?Qz1fTyu33OYPTU1p+Na20BBUXgybO9/5/XXHRJXhdOdnlfaFXYgPPCnULX5f?=
 =?us-ascii?Q?gHNbqyKeuu1uRLNKy9a30t+5F6ddPZQKoP6MU6rvM345GOZtRltrvt85PPR8?=
 =?us-ascii?Q?tvOHv2xPmTpTGxqpv+3t6eWOHFLf/HmNvCs0hjz6TglT2Vmx6OPwo8EHmROf?=
 =?us-ascii?Q?/0iJdOK3wBr8DkDUWzcoD0tnr7XJDsuxZ90f3Bh5cF1FxoYUrSrd3J+/Nkvf?=
 =?us-ascii?Q?8rnZWuhMt2mlEuT3h0a0VS7PC0nufpYiXqAxmCEYxA6zBQwvxjn4BQh5vaT4?=
 =?us-ascii?Q?mGUE7pwR5NX36Pr13x8aBwWVfE6I6mVmFOI72zyX0JW5gidD5CMLa7T6Ci23?=
 =?us-ascii?Q?maAKZd8wc8NplKDSIW70WlrQmuwPMdVyAepBaESin3V469Pzezf6BFFBTdP3?=
 =?us-ascii?Q?Z1qxW/xZTNo7IxFqDLGOMJrazhx4E7sZzvxUD2EAKzCFLWBDPqQqFYVufE5d?=
 =?us-ascii?Q?8zMdYU/vu2P0/VtExYrplQWWbeKxwE5y8ZKoG3un4R+sPTJSmpPfgeGjhy5v?=
 =?us-ascii?Q?5KWrFZwy7bLKipcMG3JDc7/VjyvtBMhwY6+jC7gDQhqdQbfs+POfO/nv16k1?=
 =?us-ascii?Q?6l4NUjwRMF13UshLZnXi+nPdlzBMQBOM7WwU84OAC49peIuoIQGiRVmqhx49?=
 =?us-ascii?Q?1q1kbfjbYGWqXFjytxA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 08:34:40.4638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68ba5f4a-c39e-44e3-ceca-08de280fa5d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
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

v1:
- make pp_table invisible on VF mode (only valid on BM)
- make pp_table invisible on Mi* chips (Not supported)
- make pp_table invisible if scpm feature is enabled.

v2:
move pp_table invisible code logic into amdgpu_dpm_get_pp_table() function.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c | 12 +++++++++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c  |  8 +++++++-
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c6f55d3522cd..79b174e5326d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1187,8 +1187,11 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (!pp_funcs->get_pp_table)
-		return 0;
+	if (!table)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
@@ -1715,7 +1718,10 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (!pp_funcs->set_pp_table)
+	if (!buf || !size)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2a9467fe86db..cbaa6cd1a983 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2560,7 +2560,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
 			      .attr_update = pp_dpm_clk_default_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
@@ -2692,6 +2692,12 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
 		    -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_table)) {
+		char *tmp = NULL;
+		if (amdgpu_dpm_get_pp_table(adev, &tmp) == -EOPNOTSUPP)
+			*states = ATTR_STATE_UNSUPPORTED;
+		else
+			*states = ATTR_STATE_SUPPORTED;
 	}
 
 	switch (gc_ver) {
-- 
2.34.1

