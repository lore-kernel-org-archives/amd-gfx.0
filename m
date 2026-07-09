Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B4EC44507
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:01:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FAC110F6BC;
	Thu,  9 Jul 2026 21:01:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S7Y6LcZf";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5FADC10F6B7
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:01:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LP1T2+71op5eAtN99Bqk12UYn/ekC5OvHBtbZ/uVOt7JwjxQ6vARCnOSXlbr1xh0G9+A8EUQMGtzMnQ5cLIXDTyLVkkaz0A3p9mhVqPPLzuzU1H2HTtZi2RCoY6DBRXReYVADM2izmqbfgFjHV+TLzv1AoqoAmgFI8tloMcWb/2GGFQiudvYr6tNV2EosT+Fj3tpKLN85nM4odHhGw3MIFIXDJfp+vpayxFdBTAm9EVgX7sNyQBxe35TURbGIk9ix3U/HpN53JtjPhgtliACac2KwbJWdj7X3cZYo6uCpZ3Om896pfZRVa0u6wL7nPGa1mTYrJne0ZjeEqlYqJSanA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vrNKEuH+HepJSM9mVJsjlQEtzGfRn+WNnNncnhhjVh8=;
 b=Gw2IFRoQ08SIY0GZ7uQQM74f07hOdwWFq45n8APujVkHorHUVJ0J5WffJCUk955+NsUJ/RKapnHxfxlrdKczjM0m9waWaCIME7ySKPh67a/67x3Kl5rH3xehQm9xHlZ/hWfSecS371eKEqz9OqfNWcR+rADfbETpvuGQq8aReQE8NFzfoXtGgZ/Dii4SR5uOHfzGb0Dv0qgV0EVEcduBYlN9xVQmDqu+mKtu5yTiYbP4f8nA+niSN+8LCNPZDIzlrlkA2rv4lNjuT46HOKLHzdNxa8uorF2d/G9mhffKM1tZ11eenHTe8pv4eL41xTseBlbGGNAqCzMJ5NDkvHKKfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vrNKEuH+HepJSM9mVJsjlQEtzGfRn+WNnNncnhhjVh8=;
 b=S7Y6LcZf4C4SFmDvWnhgm16Q542yMaaqR4udjuHVL73fD0ujB5pqHa/EzhUR9q0NlBAUDUEJAVs8nCCAjYzVK9vuQ+2pD4mhrTnTUE6wpAx8h0GMWOJRC5WjyjLpHPO4pKTvKxcecKGj2Z7FMIARbO74PYyYVzXXBjbgatMdE2M=
Received: from PH7PR10CA0009.namprd10.prod.outlook.com (2603:10b6:510:23d::29)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 21:01:49 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:510:23d:cafe::96) by PH7PR10CA0009.outlook.office365.com
 (2603:10b6:510:23d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 21:01:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:01:48 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:01:45 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 14/80] drm/amd/display: Add Debug Option To Enable Per-DPM
 De-rate Usage
Date: Thu, 9 Jul 2026 16:47:42 -0400
Message-ID: <20260709205936.5719-15-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d2436c-ee21-4d97-f2d2-08deddfd4b28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: SD37ZnbmVbUeo4HSJRESc3YMo88ZrvAuJP5Ndc/eMLoERRZbesxh4h69MXX+GaE0jPzkPe2MM+VZxGQrJKRTsf1JOE0jZgO7ujg03IOWzlpjyvQTtXybHVhwi/mwGI170nazsz8zJZKjOKyUHdSuHVvXpgDlkfvJ5JAfi3zIZiDtKfgjUw6G7GmK+wh+PLTguBsyKd6fandnYTbb3RRTI/+9R7rOk7UIYqUp9j2STlTlt2dQDIHI5u8qo4/63wJiPbrkdG2AoDOhteN+V7QKEfopvmtUDvA/J1xHRfHEMC3GSAjXqJq2Svm6ahHcZNDoc034nfLvq7skSw4utOFUZYb1KglQ7548ZccHRqk1MeB5Pl3/o5SFI/qzuf9qnOsCxyKlSfFsC/uQTmfXlmmVSExASi8HNKyzAKuqQWnW70h4rNS1fl545RRrNMzsATM5ZMoLzT8LG4S/t8wu/gZ8fiaPhB1S7zZSl2NjOC6BSnSjDpHEXktBj5HKchi+bFYmdAjSyXsZkez/T5oRQ4zyZwvrezlJLokpQv0Et9jIFLOkQPvd5Eu2Drtp3pXR7WKQ1X0U2b9+nJwrI0l5snJ4o9h2xuFp6/glGme8nRmDipxqv9g/gMcstlzpM6Qwh7F5DUWZ/zyXqVmAsAp+mPNfrNM8UC8gBVCZzhARg7MkFhb1iUHW9+zy5SaZIIzMaJX59BV3zWrfBh8F9V5XSOpQOA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l18BoZeYht6fDJRWwRsFInVxXiLsY7ALeQKy8q3tSEVEH9H/LP4+MQSj0K2MykK6qt5cuRsPh/FUku1DZqY8ri8fgPs8SVid8VaNdAUlWkM0duRI0OSHc4hpJN71o4OgVic6ETXOgmKFflrAeaP8Gi6tq9VOMq3ONTxU8iUeT7lzr5nCHt0Rb4g89Y3Z8YjNEaGVDjkBlafUpg+XWIV2xo4QNN26mJ5uuZ8AWIz/f79sTEY8JplR9YQz0IA8frGuTUmBHtXObDKyc/BxxJI4mJ+RT6+FjAEC5rfW1dkTB4oFr4mxsktyoI3o/dQHoNyy3f495XhMYAUOLYojG4qf2zSnW4w/0SB2VtGMZ4pffAUzQzQ0+K0iM2ukFhnwPxq4eEe8v3qtdu1nZrh2hiOqwSe0qYhXwH+psnXjlyRVTm/lyLtjyLdQUVQZ5Sds3Fj7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:01:48.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d2436c-ee21-4d97-f2d2-08deddfd4b28
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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

From: Austin Zheng <Austin.Zheng@amd.com>

[Why]
DML has been updated to use per-DPM derates when provided but per-DPM de-rates have not been finalized.
Need to validate to see what values should be stored in the bounding box.

[How]
Add debug options to set custom derates per DPM (starting at DPM0) and their values

Each entry in the custom derate expects the derates to be stored in the following format:
bits 0-7: dram_derate_percent_pixel
bits 8-15: fclk_derate_percent
bits 16-23: dcfclk_derate_percent
bits 24-31 are unused.

e.g. Using the value 0x414020 will set the following derates for DPM0
DPM0: 0x20, 0x40, 0x41 for dram, fclk, and dcfclk respectively

Note that global derate value will be used if the per-DPM derate is 0.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h              |  2 ++
 .../dcn401/dcn401_soc_and_ip_translator.c        | 16 ++++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2b59a0e9ca38..c78fdfc0ef4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1289,6 +1289,8 @@ struct dc_debug_options {
 	bool enable_replay_esd_recovery;
 	uint8_t iommu_mismatch_temp_wka;
 	bool disable_dynamic_expansion_for_test_pattern;
+	uint32_t dml21_custom_derate_num_dpms;
+	uint32_t dml21_custom_derate_at_dpm[DML2_MAX_NUM_DPM_LVL];
 };


diff --git a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
index 89f7ccd7f81f..0c8e652c3532 100644
--- a/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
+++ b/drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dcn401/dcn401_soc_and_ip_translator.c
@@ -269,6 +269,22 @@ void dcn401_update_soc_bb_with_values_from_software_policy(struct dml2_soc_bb *s
 	if (dc->bb_overrides.sr_enter_plus_exit_z8_time_ns)
 		soc_bb->power_management_parameters.z8_stutter_enter_plus_exit_latency_us =
 				dc->bb_overrides.sr_enter_plus_exit_z8_time_ns / 1000.0;
+
+	/* Override per-dpm derates based on a custom derate table.
+	 * Global derate value will be used for derates that aren't populated
+	 * 3 derates for a single DPM level:
+	 *  bits 0-7: dram_derate_percent_pixel
+	 *  bits 8-15: fclk_derate_percent
+	 *  bits 16-23: dcfclk_derate_percent
+	 */
+	for (unsigned int i = 0; i < dc->debug.dml21_custom_derate_num_dpms; i++) {
+		soc_bb->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dram_derate_percent_pixel[i]
+			= dc->debug.dml21_custom_derate_at_dpm[i] & 0xFF;
+		soc_bb->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.fclk_derate_percent[i]
+			= (dc->debug.dml21_custom_derate_at_dpm[i] >> 8) & 0xFF;
+		soc_bb->qos_parameters.derate_table_per_dpm.system_active_derates_per_dpm.dcfclk_derate_percent[i]
+			= (dc->debug.dml21_custom_derate_at_dpm[i] >> 16) & 0xFF;
+	}
 }

 static void apply_soc_bb_updates(struct dml2_soc_bb *soc_bb, const struct dc *dc, const struct dml2_configuration_options *config)
--
2.55.0

