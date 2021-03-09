Return-Path: <SRS0=7mEa=IH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55209C433DB
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 13:17:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7A6F614A7
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Mar 2021 13:17:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7A6F614A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 833B56E4AE;
	Tue,  9 Mar 2021 13:17:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2849C6E4AE
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Mar 2021 13:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IXE6f9tfNs3mdvNEX587NVMih/Ddu5l8KA/hroWcWbw75qA4ni2Ns0TB5bLsaFmyQRRhEcxe0dWqG0sOGXIf3AWWaPW3UJM9Y4uBVkl4O/4ew45g/SChva9CUn4zYA/T/wVuOpxVSHJNToDsMAF+x5iN98WRkp6NuEDAsgMQfeO18Qf8iHuT5khq/d0rmwwsIDKSmRwyO1cAlMunkI7bUgL5v74hePqvLQINfpSKmCme7Lhw2qQQXhnnsOvxic+u8e6THZkdwPb/psQvKxvxNaFeufW+7VeEnh8Re32/FjOiEaztOegGcy4/sc/DKUGswzAebbbK/fXvTB5XMd2D7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjTSdMpuBqgjB5Cr1i4iR2WGdJFTZ1noKcFRx3t+aBA=;
 b=Z6mxNbQ93E1pgsLfIvzjxU+vKE6cOrZ/O4ZT75rKjabToxTvP3WAzv9JVi/Wa5OxrvVw+F9g+Kv2ZCig0DEdSISTDxF8W+fE54CEwl4TYrQ+snUGy3sFBRbPo8umDSZO7tAVPJ/CBXJgMhKVnnXpneDutV+iAQJMf75f57qrMmTgWdhwTWTJ8dD2BC1DXaMxXpWBoF9TZnIARmvG5RoILJNgsKwy36P6tnGjGzDAGeCpKclXx33WWrYL+V/DQkUwF0puFVjwKkV8q8vF8EcBGNrOBCWuUA2DWm4Y/clLI9U3Ovwt9EeEJbyNop0Eul6BDXFZH3aw+TcRL4IC9cAwzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tjTSdMpuBqgjB5Cr1i4iR2WGdJFTZ1noKcFRx3t+aBA=;
 b=ca+eMdG7r/yQKv9whtX3q8KhjCjJeUwrXdFN05Iv2sY9Cd8Sr6lmPgITKLJqIc5A86I/hwwIk9C7lDe5p88U3nVDFkAHImNWWjJjZX8A6F/pkWOfKRoH38AeRzTyh/fQD4CZ4z1TG5xzz2yCQl3YKD11BvZgbRro8VbXKVIo4w8=
Received: from BN8PR03CA0023.namprd03.prod.outlook.com (2603:10b6:408:94::36)
 by BN8PR12MB4980.namprd12.prod.outlook.com (2603:10b6:408:a8::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Tue, 9 Mar
 2021 13:17:32 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:94:cafe::5) by BN8PR03CA0023.outlook.office365.com
 (2603:10b6:408:94::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Tue, 9 Mar 2021 13:17:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB01.amd.com;
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3912.17 via Frontend Transport; Tue, 9 Mar 2021 13:17:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Mar 2021
 07:17:29 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 9 Mar 2021
 07:17:29 -0600
Received: from kenneth-u1804-kvm.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.2106.2
 via Frontend Transport; Tue, 9 Mar 2021 07:17:28 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: bug fix for pcie dpm
Date: Tue, 9 Mar 2021 21:17:45 +0800
Message-ID: <20210309131745.3866-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6dfab0a2-2420-4859-7084-08d8e2fdb1d1
X-MS-TrafficTypeDiagnostic: BN8PR12MB4980:
X-Microsoft-Antispam-PRVS: <BN8PR12MB49809AC58D3881B17FDC306B8E929@BN8PR12MB4980.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5Qh2ctIMG0pFpMDqAMf4VqZKBJhre2HVA8Vsa+r6ItJtnBvEF7UHTKpUSRuaGSROuozh2jXH/X8MP8wN8oBnrWU5b4ARpwHOWR9B/bpx46JWH4wX8TccAEosufbinVk5s/kacVxIEWg6XahDSEqF5oshaMiidazVj2ShWrt032QBIfixT60KvxBF9NnX9rl/d10323L+Sc6e2OknA398mZr+7tvoEadmbWL3+DIBoCNAbQAREc/7h/O6JYif2ojl8zN24dCREcMmM670+drciBMcdlIfJCdA2cPVAYwa0f9tr8e8iv4PHydNV0C2Uz4roh+Dz+xleDKVPPGN4ozX6AKsVannm3qAz/TKICvr3rymm+Z7HHnuxl0KsWHhbrins/tk41d7qNxsiyBUMxpxwDcJ54p57CJUIfzLHDABu1NDrCsEZK90dxM96N5JRSmGhuKOhjLP72b3Co5lg3QwiLxAcVI/6EC8RQIep8p6OmqaKeGJsQNyUvqrXpZs0t3y+hXlsfRShcFEqOzhORabH5ffYZBL19i9JPmoe/4ng54qTO/su+qxhZXFuvswuqnhyJnK2sfuaatB0rxa0Q775nYkX1JBZn7l9DJD/NzO0IpUEsonYT5XecRgL/KUiyI79U/jouCQ1ybvPQecGCG5GiGD168+wO4PV2WLZAkdU9iVGbn9gNlbjvl1558sjEU
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(36840700001)(46966006)(82310400003)(2616005)(336012)(426003)(70206006)(83380400001)(70586007)(7696005)(1076003)(8936002)(8676002)(186003)(86362001)(2906002)(478600001)(26005)(36756003)(356005)(6916009)(81166007)(6666004)(36860700001)(82740400003)(44832011)(316002)(4326008)(5660300002)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2021 13:17:31.0381 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dfab0a2-2420-4859-7084-08d8e2fdb1d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB4980
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently the pcie dpm has two problems.
1. Only the high dpm level speed/width can be overrided
if the requested values are out of the pcie capability.
2. The high dpm level is always overrided though sometimes
it's not necesarry.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 48 ++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c | 66 +++++++++++++++++++
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 48 ++++++++------
 3 files changed, 141 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 5e875ad8d633..408b35866704 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -1505,6 +1505,48 @@ static int vega10_populate_single_lclk_level(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static int vega10_override_pcie_parameters(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	struct vega10_hwmgr *data =
+			(struct vega10_hwmgr *)(hwmgr->backend);
+	uint32_t pcie_gen = 0, pcie_width = 0;
+	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
+	int i;
+
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
+		pcie_gen = 3;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		pcie_gen = 2;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
+		pcie_gen = 1;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)
+		pcie_gen = 0;
+
+	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+		pcie_width = 6;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
+		pcie_width = 5;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
+		pcie_width = 4;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
+		pcie_width = 3;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
+		pcie_width = 2;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
+		pcie_width = 1;
+
+	for (i = 0; i < NUM_LINK_LEVELS; i++) {
+		if (pp_table->PcieGenSpeed[i] > pcie_gen)
+			pp_table->PcieGenSpeed[i] = pcie_gen;
+
+		if (pp_table->PcieLaneCount[i] > pcie_width)
+			pp_table->PcieLaneCount[i] = pcie_width;
+	}
+
+	return 0;
+}
+
 static int vega10_populate_smc_link_levels(struct pp_hwmgr *hwmgr)
 {
 	int result = -1;
@@ -2556,6 +2598,11 @@ static int vega10_init_smc_table(struct pp_hwmgr *hwmgr)
 			"Failed to initialize Link Level!",
 			return result);
 
+	result = vega10_override_pcie_parameters(hwmgr);
+	PP_ASSERT_WITH_CODE(!result,
+			"Failed to override pcie parameters!",
+			return result);
+
 	result = vega10_populate_all_graphic_levels(hwmgr);
 	PP_ASSERT_WITH_CODE(!result,
 			"Failed to initialize Graphics Level!",
@@ -2922,6 +2969,7 @@ static int vega10_start_dpm(struct pp_hwmgr *hwmgr, uint32_t bitmap)
 	return 0;
 }
 
+
 static int vega10_enable_disable_PCC_limit_feature(struct pp_hwmgr *hwmgr, bool enable)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index a827f2bc7904..196ac2a4d145 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -481,6 +481,67 @@ static void vega12_init_dpm_state(struct vega12_dpm_state *dpm_state)
 	dpm_state->hard_max_level = 0xffff;
 }
 
+static int vega12_override_pcie_parameters(struct pp_hwmgr *hwmgr)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
+	struct vega12_hwmgr *data =
+			(struct vega12_hwmgr *)(hwmgr->backend);
+	uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg, pcie_gen_arg, pcie_width_arg;
+	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
+	int i;
+	int ret;
+
+	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
+		pcie_gen = 3;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN3)
+		pcie_gen = 2;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN2)
+		pcie_gen = 1;
+	else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN1)
+		pcie_gen = 0;
+
+	if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X16)
+		pcie_width = 6;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X12)
+		pcie_width = 5;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X8)
+		pcie_width = 4;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X4)
+		pcie_width = 3;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X2)
+		pcie_width = 2;
+	else if (adev->pm.pcie_mlw_mask & CAIL_PCIE_LINK_WIDTH_SUPPORT_X1)
+		pcie_width = 1;
+
+	/* Bit 31:16: LCLK DPM level. 0 is DPM0, and 1 is DPM1
+	 * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
+	 * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
+	 */
+	for (i = 0; i < NUM_LINK_LEVELS; i++) {
+		pcie_gen_arg = (pp_table->PcieGenSpeed[i] > pcie_gen) ? pcie_gen :
+			pp_table->PcieGenSpeed[i];
+		pcie_width_arg = (pp_table->PcieLaneCount[i] > pcie_width) ? pcie_width :
+			pp_table->PcieLaneCount[i];
+
+		if (pcie_gen_arg != pp_table->PcieGenSpeed[i] || pcie_width_arg !=
+		    pp_table->PcieLaneCount[i]) {
+			smu_pcie_arg = (i << 16) | (pcie_gen_arg << 8) | pcie_width_arg;
+			ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+				PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
+				NULL);
+			PP_ASSERT_WITH_CODE(!ret,
+				"[OverridePcieParameters] Attempt to override pcie params failed!",
+				return ret);
+		}
+
+		/* update the pptable */
+		pp_table->PcieGenSpeed[i] = pcie_gen_arg;
+		pp_table->PcieLaneCount[i] = pcie_width_arg;
+	}
+
+	return 0;
+}
+
 static int vega12_get_number_of_dpm_level(struct pp_hwmgr *hwmgr,
 		PPCLK_e clk_id, uint32_t *num_of_levels)
 {
@@ -968,6 +1029,11 @@ static int vega12_enable_dpm_tasks(struct pp_hwmgr *hwmgr)
 			"Failed to enable all smu features!",
 			return result);
 
+	result = vega12_override_pcie_parameters(hwmgr);
+	PP_ASSERT_WITH_CODE(!result,
+			"[EnableDPMTasks] Failed to override pcie parameters!",
+			return result);
+
 	tmp_result = vega12_power_control_set_level(hwmgr);
 	PP_ASSERT_WITH_CODE(!tmp_result,
 			"Failed to power control set level!",
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index e8eec2539c17..78bbd4d666f2 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -831,7 +831,9 @@ static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 	struct amdgpu_device *adev = (struct amdgpu_device *)(hwmgr->adev);
 	struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-	uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg;
+	uint32_t pcie_gen = 0, pcie_width = 0, smu_pcie_arg, pcie_gen_arg, pcie_width_arg;
+	PPTable_t *pp_table = &(data->smc_state_table.pp_table);
+	int i;
 	int ret;
 
 	if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN4)
@@ -860,17 +862,27 @@ static int vega20_override_pcie_parameters(struct pp_hwmgr *hwmgr)
 	 * Bit 15:8:  PCIE GEN, 0 to 3 corresponds to GEN1 to GEN4
 	 * Bit 7:0:   PCIE lane width, 1 to 7 corresponds is x1 to x32
 	 */
-	smu_pcie_arg = (1 << 16) | (pcie_gen << 8) | pcie_width;
-	ret = smum_send_msg_to_smc_with_parameter(hwmgr,
-			PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
-			NULL);
-	PP_ASSERT_WITH_CODE(!ret,
-		"[OverridePcieParameters] Attempt to override pcie params failed!",
-		return ret);
+	for (i = 0; i < NUM_LINK_LEVELS; i++) {
+		pcie_gen_arg = (pp_table->PcieGenSpeed[i] > pcie_gen) ? pcie_gen :
+			pp_table->PcieGenSpeed[i];
+		pcie_width_arg = (pp_table->PcieLaneCount[i] > pcie_width) ? pcie_width :
+			pp_table->PcieLaneCount[i];
+
+		if (pcie_gen_arg != pp_table->PcieGenSpeed[i] || pcie_width_arg !=
+		    pp_table->PcieLaneCount[i]) {
+			smu_pcie_arg = (i << 16) | (pcie_gen_arg << 8) | pcie_width_arg;
+			ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+				PPSMC_MSG_OverridePcieParameters, smu_pcie_arg,
+				NULL);
+			PP_ASSERT_WITH_CODE(!ret,
+				"[OverridePcieParameters] Attempt to override pcie params failed!",
+				return ret);
+		}
 
-	data->pcie_parameters_override = true;
-	data->pcie_gen_level1 = pcie_gen;
-	data->pcie_width_level1 = pcie_width;
+		/* update the pptable */
+		pp_table->PcieGenSpeed[i] = pcie_gen_arg;
+		pp_table->PcieLaneCount[i] = pcie_width_arg;
+	}
 
 	return 0;
 }
@@ -3319,9 +3331,7 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 			data->od8_settings.od8_settings_array;
 	OverDriveTable_t *od_table =
 			&(data->smc_state_table.overdrive_table);
-	struct phm_ppt_v3_information *pptable_information =
-		(struct phm_ppt_v3_information *)hwmgr->pptable;
-	PPTable_t *pptable = (PPTable_t *)pptable_information->smc_pptable;
+	PPTable_t *pptable = &(data->smc_state_table.pp_table);
 	struct pp_clock_levels_with_latency clocks;
 	struct vega20_single_dpm_table *fclk_dpm_table =
 			&(data->dpm_table.fclk_table);
@@ -3420,13 +3430,9 @@ static int vega20_print_clock_levels(struct pp_hwmgr *hwmgr,
 		current_lane_width =
 			vega20_get_current_pcie_link_width_level(hwmgr);
 		for (i = 0; i < NUM_LINK_LEVELS; i++) {
-			if (i == 1 && data->pcie_parameters_override) {
-				gen_speed = data->pcie_gen_level1;
-				lane_width = data->pcie_width_level1;
-			} else {
-				gen_speed = pptable->PcieGenSpeed[i];
-				lane_width = pptable->PcieLaneCount[i];
-			}
+			gen_speed = pptable->PcieGenSpeed[i];
+			lane_width = pptable->PcieLaneCount[i];
+
 			size += sprintf(buf + size, "%d: %s %s %dMhz %s\n", i,
 					(gen_speed == 0) ? "2.5GT/s," :
 					(gen_speed == 1) ? "5.0GT/s," :
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
