Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFFFC433F5
	for <amd-gfx@archiver.kernel.org>; Sun, 13 Mar 2022 05:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C43610E073;
	Sun, 13 Mar 2022 05:29:51 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70A7A10E073
 for <amd-gfx@lists.freedesktop.org>; Sun, 13 Mar 2022 05:29:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3vQ34/Sk1RShOq5DTouZ/MSIUD+HW6glW/0MMH1pXB1ZMf5r61QiwM7pbj7lkYigdAsO8LSOSQXk1elXRXIWEqvkioSX2QkvxYWGkyMQMblg0AqaixphkSZ8MbM4uN5uP/iJQv1GLMjuyxxCcA19wvbhUwrMsOPSet5/FlCpVpPhBYvyOeqNZ0antVUCVW/QKg+RR4mf7MnkIMrDldu1KTqS6G5eA8o87t5jCCp4RWqpLSw8K5GskUpIljzSFTQsXID40jZcH5v5LBLEP981WED1CSZf0ybl4WJwujdFNxuk3wLeUzeDC+e1TMMtUnRXgKVTLI4xS2AQ/qPbxyGzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RudLwc9Ab6OrjNPXwggKEYqPilyEPHsfZyK2Lt9fh+A=;
 b=k0RocRz0g3waWqFXXqe52l9x9tCkEpx2GlDOt5sOMMyozQswDC3572GKRXKIUNOdMuwqYBlr6lCPbPZQJ9wJzWS5fs5SU/4Uu6x13n2/EEigMW7AXWV7mYbljN4xzMfoGVmpT4Ai/lJ5oWyNoOCXzag4pew0mf9jI9oS88TD4ZB98pLwP/DSq2K6qnvv2BWHK9kByiPkWi1reZ3yiQf7MFRcY3OiHu6ff2nJoEPJF5Z/EupuJViilWd3V/mqDGBWV1MB6cCyHm2PZqdWVsmNcfNXPhnX1KwEIRWu+rEWdxY7Eq7GYIAUq5uatzcywSaInT0whugh3f/VRt7ETQNnjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RudLwc9Ab6OrjNPXwggKEYqPilyEPHsfZyK2Lt9fh+A=;
 b=V7lCPnuRlM5HE9y3zcnLKMo5W5ZWfjf1wVCX2jr9GkijuVwOG6pOq8L6FDSvDAVgBHJz4vGQ/HRb6gWNEu/B6WiVg4rQALH1NJ0EUKsoYEu1kho7+rG9aqMrdhCKe7CC7fc4UiGHlbR/xt/GtSsaqNhQYO8Zt7QDvjMCJQxpOEU=
Received: from BN6PR19CA0074.namprd19.prod.outlook.com (2603:10b6:404:133::12)
 by MWHPR12MB1887.namprd12.prod.outlook.com (2603:10b6:300:111::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Sun, 13 Mar
 2022 05:29:46 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::5b) by BN6PR19CA0074.outlook.office365.com
 (2603:10b6:404:133::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26 via Frontend
 Transport; Sun, 13 Mar 2022 05:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.24 via Frontend Transport; Sun, 13 Mar 2022 05:29:45 +0000
Received: from dapowell-ubuntu-200400-1.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 12 Mar 2022 23:29:42 -0600
From: Darren Powell <darren.powell@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] amdgpu/pm: Implement emit_clk_levels for vega10
Date: Sun, 13 Mar 2022 00:28:39 -0500
Message-ID: <20220313052839.5777-3-darren.powell@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220313052839.5777-1-darren.powell@amd.com>
References: <20220313052839.5777-1-darren.powell@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75cdd90d-7788-46e2-716b-08da04b27bb6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1887:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB188753D71F81B72F81E09FA2F00E9@MWHPR12MB1887.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZrIW9I/U7bO78XRDbY0zr6ZWPPnlzshA+qgW0HjBA2gbDE7ENj5LQyg5lbaGcOKC15x23THdF4u5O/zuplCNysotoBuolrngqtd73YTs7xVCLm5VGOOfiKuCvQVWZppYL6O0KLe/0zI+tH2xVRjGPeinqaqInj8qJl4J1BIHfZgzb5gujvB5+1Benv+K5AilMC1/yibpqcEapA+Hj4GHQ1Jt0t3VJG6mgn73L2k8hvuMUzK+zx/RZgLd7Ss4aziVIL82M25U9En4HfAIT1u0bnYsRR5REKA0KvjwGvAq34iLcR0rnr1PysInQPNn8p3jga0AyBlsVVEkjdypmmn0lKIhHxwTWFER4Oab773wnlwLu5KH5TErFLymnwHlxVSipT5olEhvtM0npfKUPnC1PJ4w41hjag0s48dYFouCY9icpRWEV6JPlHppA7WoDkx03D5cKZaIR9aLs2+rsYIy+KOkCToWobiSO4zr9HGRo8AfgBvG6A8B3FfleC4iADS3SiLazPKvwO61CUUiLRj+MZs7+6S7YDJBd6NnxzyA6LkKHWzz7QhS4PJFI+3BLgrhtcbcLSFiYVg2rBVBrnZSAn0cE9VAkRDg8ulYQZNJm4joD3INyoP2Ir5CUjhBTMfaOuUW2qkoAhLDGbGm91k8MaJQzvOqkCRHTUIlstjbS2P/mME+Q7wcgtQZYBv44ndgk4RgPQqBYR7Gkx1t/XlHNolCivquw/bsX9UhH6DMayo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(70206006)(508600001)(316002)(86362001)(47076005)(6666004)(16526019)(8676002)(4326008)(6916009)(82310400004)(36860700001)(70586007)(1076003)(186003)(26005)(426003)(40460700003)(7696005)(81166007)(356005)(83380400001)(2906002)(36756003)(2616005)(5660300002)(44832011)(8936002)(336012)(21314003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2022 05:29:45.1496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75cdd90d-7788-46e2-716b-08da04b27bb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1887
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
Cc: Darren Powell <darren.powell@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

   (v1)
     - implement emit_clk_levels for vega10, based on print_clk_levels,
       but using sysfs_emit rather than sprintf
     - modify local int vars to use uint32_t to match arg type of
       called functions
     - add return of error codes
     - refactor OD_XXX cases to return early with -EOPNOTSUPP if
       !(hwmgr->od_enabled)

Signed-off-by: Darren Powell <darren.powell@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 147 ++++++++++++++++++
 1 file changed, 147 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 3f040be0d158..a25b984fceb5 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -4625,6 +4625,152 @@ static int vega10_get_current_pcie_link_speed_level(struct pp_hwmgr *hwmgr)
 		>> PSWUSP0_PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
 }
 
+static int vega10_emit_clock_levels(struct pp_hwmgr *hwmgr,
+				    enum pp_clock_type type, char *buf, int *offset)
+{
+	struct vega10_hwmgr *data = hwmgr->backend;
+	struct vega10_single_dpm_table *sclk_table = &(data->dpm_table.gfx_table);
+	struct vega10_single_dpm_table *mclk_table = &(data->dpm_table.mem_table);
+	struct vega10_single_dpm_table *soc_table = &(data->dpm_table.soc_table);
+	struct vega10_single_dpm_table *dcef_table = &(data->dpm_table.dcef_table);
+	struct vega10_odn_clock_voltage_dependency_table *podn_vdd_dep = NULL;
+	uint32_t gen_speed, lane_width, current_gen_speed, current_lane_width;
+	PPTable_t *pptable = &(data->smc_state_table.pp_table);
+
+	uint32_t i, now, count = 0;
+	int ret = 0;
+
+	switch (type) {
+	case PP_SCLK:
+		if (data->registry_data.sclk_dpm_key_disabled)
+			return -EOPNOTSUPP;
+
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentGfxclkIndex, &now);
+		if (unlikely(ret != 0))
+			return ret;
+
+		if (hwmgr->pp_one_vf &&
+		    (hwmgr->dpm_level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK))
+			count = 5;
+		else
+			count = sclk_table->count;
+		for (i = 0; i < count; i++)
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
+					i, sclk_table->dpm_levels[i].value / 100,
+					(i == now) ? "*" : "");
+		break;
+	case PP_MCLK:
+		if (data->registry_data.mclk_dpm_key_disabled)
+			return -EOPNOTSUPP;
+
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentUclkIndex, &now);
+		if (unlikely(ret != 0))
+			return ret;
+
+		for (i = 0; i < mclk_table->count; i++)
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
+					i, mclk_table->dpm_levels[i].value / 100,
+					(i == now) ? "*" : "");
+		break;
+	case PP_SOCCLK:
+		if (data->registry_data.socclk_dpm_key_disabled)
+			return -EOPNOTSUPP;
+
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_GetCurrentSocclkIndex, &now);
+		if (unlikely(ret != 0))
+			return ret;
+
+		for (i = 0; i < soc_table->count; i++)
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
+					i, soc_table->dpm_levels[i].value / 100,
+					(i == now) ? "*" : "");
+		break;
+	case PP_DCEFCLK:
+		if (data->registry_data.dcefclk_dpm_key_disabled)
+			return -EOPNOTSUPP;
+
+		ret = smum_send_msg_to_smc_with_parameter(hwmgr,
+							  PPSMC_MSG_GetClockFreqMHz,
+							  CLK_DCEFCLK, &now);
+		if (unlikely(ret != 0))
+			return ret;
+
+		for (i = 0; i < dcef_table->count; i++)
+			*offset += sysfs_emit_at(buf, *offset, "%d: %uMhz %s\n",
+					i, dcef_table->dpm_levels[i].value / 100,
+					(dcef_table->dpm_levels[i].value / 100 == now) ?
+					"*" : "");
+		break;
+	case PP_PCIE:
+		current_gen_speed =
+			vega10_get_current_pcie_link_speed_level(hwmgr);
+		current_lane_width =
+			vega10_get_current_pcie_link_width_level(hwmgr);
+		for (i = 0; i < NUM_LINK_LEVELS; i++) {
+			gen_speed = pptable->PcieGenSpeed[i];
+			lane_width = pptable->PcieLaneCount[i];
+
+			*offset += sysfs_emit_at(buf, *offset, "%d: %s %s %s\n", i,
+					(gen_speed == 0) ? "2.5GT/s," :
+					(gen_speed == 1) ? "5.0GT/s," :
+					(gen_speed == 2) ? "8.0GT/s," :
+					(gen_speed == 3) ? "16.0GT/s," : "",
+					(lane_width == 1) ? "x1" :
+					(lane_width == 2) ? "x2" :
+					(lane_width == 3) ? "x4" :
+					(lane_width == 4) ? "x8" :
+					(lane_width == 5) ? "x12" :
+					(lane_width == 6) ? "x16" : "",
+					(current_gen_speed == gen_speed) &&
+					(current_lane_width == lane_width) ?
+					"*" : "");
+		}
+		break;
+
+	case OD_SCLK:
+		if (!hwmgr->od_enabled)
+			return -EOPNOTSUPP;
+
+		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_SCLK");
+		podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_sclk;
+		for (i = 0; i < podn_vdd_dep->count; i++)
+			*offset += sysfs_emit_at(buf, *offset, "%d: %10uMhz %10umV\n",
+						 i, podn_vdd_dep->entries[i].clk / 100,
+						 podn_vdd_dep->entries[i].vddc);
+		break;
+	case OD_MCLK:
+		if (!hwmgr->od_enabled)
+			return -EOPNOTSUPP;
+
+		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_MCLK");
+		podn_vdd_dep = &data->odn_dpm_table.vdd_dep_on_mclk;
+		for (i = 0; i < podn_vdd_dep->count; i++)
+			*offset += sysfs_emit_at(buf, *offset, "%d: %10uMhz %10umV\n",
+						 i, podn_vdd_dep->entries[i].clk/100,
+						 podn_vdd_dep->entries[i].vddc);
+		break;
+	case OD_RANGE:
+		if (!hwmgr->od_enabled)
+			return -EOPNOTSUPP;
+
+		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_RANGE");
+		*offset += sysfs_emit_at(buf, *offset, "SCLK: %7uMHz %10uMHz\n",
+					 data->golden_dpm_table.gfx_table.dpm_levels[0].value/100,
+				hwmgr->platform_descriptor.overdriveLimit.engineClock/100);
+		*offset += sysfs_emit_at(buf, *offset, "MCLK: %7uMHz %10uMHz\n",
+					 data->golden_dpm_table.mem_table.dpm_levels[0].value/100,
+				hwmgr->platform_descriptor.overdriveLimit.memoryClock/100);
+		*offset += sysfs_emit_at(buf, *offset, "VDDC: %7umV %11umV\n",
+					 data->odn_dpm_table.min_vddc,
+					 data->odn_dpm_table.max_vddc);
+		break;
+	default:
+		ret = -ENOENT;
+		break;
+	}
+	return ret;
+}
+
 static int vega10_print_clock_levels(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, char *buf)
 {
@@ -5551,6 +5697,7 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs = {
 	.set_watermarks_for_clocks_ranges = vega10_set_watermarks_for_clocks_ranges,
 	.display_clock_voltage_request = vega10_display_clock_voltage_request,
 	.force_clock_level = vega10_force_clock_level,
+	.emit_clock_levels = vega10_emit_clock_levels,
 	.print_clock_levels = vega10_print_clock_levels,
 	.display_config_changed = vega10_display_configuration_changed_task,
 	.powergate_uvd = vega10_power_gate_uvd,
-- 
2.35.1

