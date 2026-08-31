Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7AFFC61DF0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 04:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64F1710E258;
	Mon, 31 Aug 2026 04:35:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VkiNlWWg";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22DE810E5D2
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 04:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbCZGrS0QebV7uIwxz2aw2BhyVPUoT4KSH9BhHDFh6K7ZD9OdtyLfJGdYlcC/YX4EfOuGEsEpqi9bJM0Q1ihhoij6nUzDID/NQZHDPSG0/Lc+Brxv1IUnIzYLVkGMPa4/A9ASQ2W0VoHIyRpngivRBHux1lZB3sHAYcgY16yW/0NmTw3pUR+ZMpQVKXh3jnDXUi+I2WWmO8RLyMGwRRrTzAw+tynWGKdRAfwwkEvlsq0TVXWvVKwvv+kNt7W39DQCfECjIIkpYo48mSAEup3oSKr287VCbMxWl02JkpQ/gPCxmnr+gKJL7XN2QTjSeZkd3B9Sc7nqDxcK8lqEfIX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y7tGCcw9+Gpe5CZJ2/f8xHUKYU86f+vgL0r63Hhjxw=;
 b=onPbqSu3FS64va/JukgL7ZRtDMIyIGv5xu/cqWTuZwhWwduGHZVX7TfTIoRuiKUsojt7zdR/KU3PYG7pi0icPgIpAH6vX7saXglnl8rfvGk0o2SolC2SKGOHV/xFw29syRoMWwowVV0ztjH3zIZZ26dXkSg8pDXv3Snso4IR0ayQERMLF9t97tk/1/SlzNGZkXC+0US/pZawTEPw1YrIi2CqD4VN8QxBjLIH8sDNsBUCwTtmMWINjz19TzPluFBaSmPmcBFkQkrHgFJdo7PoABVC8S8c//3rSv1ZXmJzXMyAiqhYxnYjPMUE9Z37l4RaSZeM+Bwx4n5OMt5Ba1ow4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y7tGCcw9+Gpe5CZJ2/f8xHUKYU86f+vgL0r63Hhjxw=;
 b=VkiNlWWgVYdjZ7AEDBXHBZuopWzsFJSaUbeC2+H17q3BBGq+radltnz2Hyuw0WV15jioxDU7gfsojZdGcVzmvWWGyhe28/gOCV4+SmXaVze6fvHM42LiF+wTULG0fwnFBnlyerf5cyxFxLNLJfkKwnQmjjZcJlNkznw6JbpQXKQ=
Received: from BN0PR04CA0168.namprd04.prod.outlook.com (2603:10b6:408:eb::23)
 by SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 04:35:33 +0000
Received: from BN2PEPF0000A800.namprd02.prod.outlook.com
 (2603:10b6:408:eb:cafe::14) by BN0PR04CA0168.outlook.office365.com
 (2603:10b6:408:eb::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 04:35:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A800.mail.protection.outlook.com (10.167.245.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 04:35:32 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sun, 30 Aug
 2026 23:35:31 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH 7/7] drm/amd/pm: stage od reset for smu vega20
Date: Mon, 31 Aug 2026 12:35:07 +0800
Message-ID: <20260831043507.523599-8-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831043507.523599-1-kevin.wang@amd.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A800:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: ebbb29ac-edf5-4e21-248c-08df07194b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: NfG9bJAA659TYDqphytFQlNIRuqCCZGGvV72ELq+/Trzq1vyNkZXM0LwmL/9OQ1LNQGRWe0ezfbBKBQRTSGoP8z3leV6hIPYKvUpivZvTMdrHYaNJfXKLcnzbbz5CeJHV+RsvY361LGslfjax+aRFP512iYanIk+sYmOvX58raZUVvRe5Hz6dvE3fFuHqgMCdJkBgx05cDDSGrnMqon3foldbKHktXbMP0fstfNJVqE89oOo1WqmE1VcKmfDOKGnkKajqU1icxOQbPMdlQnQKvVd8aUdOvEkuRj2NgPQMhtKRNQvLS9D3cj7gxxHtAArvgmNKX7g4uzQ6fCcVhnKCIM2zamK/8P3S0fUk7WGEOSfANPRLenxCnHHCW8WffffQmWd/FvNzBqZkUrC7llGA1J/sGBjpDZF1obtEP5rMm3x3EDj89+Q3BrZE3mOH7IxiYZ6G4BmNhC+FT7825jEZT3yt4GalyO8MlBEZwX4XYf8c736kiIgLpcqfqKGZJwLZiIg1Lx44uHN84RdAt4iL/33DFzuvAzeMEtMBGELjrtMbchxzl5Yj2LI+yl7QvlXMFyjO2O7/qNFWmTJzPDBybqLfro9gq9GXxznoSMnodSUW7W6z4Qo+inUytQ5Iah8xkqXP1sgIO6fkHreTDSCPUlnen5xEjWntRq2k+aWLl+4kLjMqrosSexu+PQs0hZY7wUUU/majQJwa2LZdHbUsw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: m4wWG5RHKWdlTjgDBRjgSvTREbvx4kEE2Yfg45C8yFXD+NhPwT3cUDLcObl+KR1olQXXx6VrHRb2bE5kJFHOc73j4j/EBLmt5uFl/aPchZ69YByNQopQT3KOaP+NuFPuJ2llsKV16CR16FPA9dgcub2h2vr1+24wcHRbBtQSPXPoLfvJC4r2a1/+m3R/+K8blhCS2ZBY9kPZ/ddxcjmWDXJ3fg0LrFyZIgQKj797LjC1KBSSeOLeELKKxQYACGms/LqkfFslklDHRdaGupN5H+pJfo+VdyiLks2gRSGm4dHP6jucQyxULHpDoC2Vux+YQ/gJn9rsqTlqM9IZx0F2pWqYF/VymNliAODdj1r/+aj0to2ngaLiiaORIfZd6TLnfv4gN2xuQGP/iozqQsGnQnFgJVBNSBmeBN7WJUUDkxElA12muvjGk5eqnsqIEUQB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 04:35:32.7278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebbb29ac-edf5-4e21-248c-08df07194b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A800.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
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

Vega20 handles PP_OD_RESTORE_DEFAULT_TABLE by reading the current
OverDrive table from the SMU. This discards uncommitted driver-side
edits, but does not restore the boot OD settings.

Rebuild the pp_od_clk_voltage-editable table fields from the OD8 defaults
saved during initialization. Leave the rebuilt table in the driver cache
until PP_OD_COMMIT_DPM_TABLE uploads it. Preserve a pending GFXCLK/UCLK
DPM-table refresh whenever reset stages different limits, so c keeps the
driver cache synchronized with PMFW.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 75 ++++++++++++++++---
 1 file changed, 66 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index e9c194056e32..aee9a26b1809 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2948,6 +2948,71 @@ static int vega20_set_watermarks_for_clocks_ranges(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
+static void vega20_od8_restore_default_settings(struct vega20_hwmgr *data)
+{
+	struct vega20_od8_single_setting *od8_settings =
+		data->od8_settings.od8_settings_array;
+	OverDriveTable_t *od_table = &data->smc_state_table.overdrive_table;
+
+	if (data->od8_settings.overdrive8_capabilities & OD8_GFXCLK_LIMITS) {
+		if (od_table->GfxclkFmin !=
+			    od8_settings[OD8_SETTING_GFXCLK_FMIN].default_value ||
+		    od_table->GfxclkFmax !=
+			    od8_settings[OD8_SETTING_GFXCLK_FMAX].default_value)
+			data->gfxclk_overdrive = true;
+
+		od_table->GfxclkFmin =
+			od8_settings[OD8_SETTING_GFXCLK_FMIN].default_value;
+		od_table->GfxclkFmax =
+			od8_settings[OD8_SETTING_GFXCLK_FMAX].default_value;
+		od8_settings[OD8_SETTING_GFXCLK_FMIN].current_value =
+			od8_settings[OD8_SETTING_GFXCLK_FMIN].default_value;
+		od8_settings[OD8_SETTING_GFXCLK_FMAX].current_value =
+			od8_settings[OD8_SETTING_GFXCLK_FMAX].default_value;
+	}
+
+	if (data->od8_settings.overdrive8_capabilities & OD8_GFXCLK_CURVE) {
+		od_table->GfxclkFreq1 =
+			od8_settings[OD8_SETTING_GFXCLK_FREQ1].default_value;
+		od_table->GfxclkVolt1 =
+			od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].default_value *
+			VOLTAGE_SCALE;
+		od_table->GfxclkFreq2 =
+			od8_settings[OD8_SETTING_GFXCLK_FREQ2].default_value;
+		od_table->GfxclkVolt2 =
+			od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].default_value *
+			VOLTAGE_SCALE;
+		od_table->GfxclkFreq3 =
+			od8_settings[OD8_SETTING_GFXCLK_FREQ3].default_value;
+		od_table->GfxclkVolt3 =
+			od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].default_value *
+			VOLTAGE_SCALE;
+		od8_settings[OD8_SETTING_GFXCLK_FREQ1].current_value =
+			od8_settings[OD8_SETTING_GFXCLK_FREQ1].default_value;
+		od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].current_value =
+			od8_settings[OD8_SETTING_GFXCLK_VOLTAGE1].default_value;
+		od8_settings[OD8_SETTING_GFXCLK_FREQ2].current_value =
+			od8_settings[OD8_SETTING_GFXCLK_FREQ2].default_value;
+		od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].current_value =
+			od8_settings[OD8_SETTING_GFXCLK_VOLTAGE2].default_value;
+		od8_settings[OD8_SETTING_GFXCLK_FREQ3].current_value =
+			od8_settings[OD8_SETTING_GFXCLK_FREQ3].default_value;
+		od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].current_value =
+			od8_settings[OD8_SETTING_GFXCLK_VOLTAGE3].default_value;
+	}
+
+	if (data->od8_settings.overdrive8_capabilities & OD8_UCLK_MAX) {
+		if (od_table->UclkFmax !=
+		    od8_settings[OD8_SETTING_UCLK_FMAX].default_value)
+			data->memclk_overdrive = true;
+
+		od_table->UclkFmax =
+			od8_settings[OD8_SETTING_UCLK_FMAX].default_value;
+		od8_settings[OD8_SETTING_UCLK_FMAX].current_value =
+			od8_settings[OD8_SETTING_UCLK_FMAX].default_value;
+	}
+}
+
 static int vega20_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
 					enum PP_OD_DPM_TABLE_COMMAND type,
 					long *input, uint32_t size)
@@ -3117,15 +3182,7 @@ static int vega20_odn_edit_dpm_table(struct pp_hwmgr *hwmgr,
 		break;
 
 	case PP_OD_RESTORE_DEFAULT_TABLE:
-		data->gfxclk_overdrive = false;
-		data->memclk_overdrive = false;
-
-		ret = smum_smc_table_manager(hwmgr,
-					     (uint8_t *)od_table,
-					     TABLE_OVERDRIVE, true);
-		PP_ASSERT_WITH_CODE(!ret,
-				"Failed to export overdrive table!",
-				return ret);
+		vega20_od8_restore_default_settings(data);
 		break;
 
 	case PP_OD_COMMIT_DPM_TABLE:
-- 
2.55.0

