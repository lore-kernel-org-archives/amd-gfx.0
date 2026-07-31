Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15360C55173
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:15:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98D9910E1B4;
	Fri, 31 Jul 2026 21:15:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gvuag9g5";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012034.outbound.protection.outlook.com [52.101.43.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC08E10E1B4
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:15:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WgswKF4iinPJje/Jax9JN61idB7NLE7nfD5dRunf8YXVsGbLb+W8ZQ8ZBO/LD05nP2re8ruw8uytfKzz25h/SDho81tgVYE7DJQnD19DRCga5pzD5VnXx1n94/bwNzcLYeWghBGqFaVgMfrGutfv7zs07vPrkAOqmX0LwX789Cy4aFmo88+fzb2hMBRCbwhBOPTTppEoGNT/w9SJcQJO5A8uLmPlzxgw90LVgxP54lw6zWZUnYI3uDT91LEFIezOU/AArXW+Keha4MFii9doXnRHhalwq+YwwPjgXs1trT60WMBTztyKBzA7s2/DNsIlpCH5MlXlKK7XrncFdKoEHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9M+VX3BeDzQXjHNKRl7JLhtD5g9pz8bfxXcN3lFQVA=;
 b=QC9aAGmZO+5Xl47VhPrVPGLIbxSTSho0qgSs32D3E/IdrToeRhD8LMd0KY34kjj2uwECzZ7Mh4j8YEiTA5s+CaqMZOP87VRKtFz6gOuF8LuYOgP/m54KXuzKnvcxFD6YVqGNDiREWh2HNunNeJxlSII1Uzkh5FIWMsQ87c31h+dL158Dz+SwCG3IsAW8jfxJrbFDLjiEHf1ZtXT97mV3a/Zyjt/mCkvTxy28zPdLLov8CMetBjiFFuWIc0L9aBmJoAxLYQUtoosRSjJniZtIv2jsu2OtwCQXgo/nqDLNd7cChwT1tOm3jpZZ0Y4WlCxO6cF2CoFxny2wc3vI7i7gNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9M+VX3BeDzQXjHNKRl7JLhtD5g9pz8bfxXcN3lFQVA=;
 b=gvuag9g5pXf7or3Lxxymz3AiYIY7Uls6Hpo72eEkJ69rjLJvo6J3mjuwzOjHOCzk0+KFvr+uy51O8A7IaeY1CiFzi2vkOGK3vPNmoD561Wnyiib1AZqb12fpFbWP5367l1mpR9EyEaQpyWgoQB9Vc5+t6sekwMEPw3iCjvTRvnU=
Received: from CH2PR14CA0036.namprd14.prod.outlook.com (2603:10b6:610:56::16)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:15:16 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::4) by CH2PR14CA0036.outlook.office365.com
 (2603:10b6:610:56::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:15:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:15:15 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:15:13 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:15:07 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Roman Li <Roman.Li@amd.com>
Subject: [PATCH 03/41] drm/amd/display: Enable DCN6 init
Date: Fri, 31 Jul 2026 17:12:24 -0400
Message-ID: <20260731211302.3040343-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: c098ea93-d5e0-4946-5ddc-08deef48d100
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|22082099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: Q60RD6YfqNT8RhYzzFye1VAobDRty7j2wUD6TfBPlbH3rpOoK2zmWISoWiF69mAx4zcRvEUbR/i8wmVGVqpaSeRojdgJDWi7WMERriiiCuMsdFHT12X+fUv9TvJ2FnwVkVmBadVERPb7XqkCDSaa3HD/YmWEqXMjbUlHiAI7oYgFvkjPLescxMbvLRHVKcBVsNE8kPn+XPT1tP8oCLGWCpJ2Ti1jAs/ewO0SatDwVQ/S7DGiqSX4AE2amlY1644WAKLdptcXncrs30lMSyEOE3vVQ9USAeqelJff1D1Inenty/Lt3jwuEATM5a0yR+YrkbTTa97uFvhNqVGwXRj5eBPbszYGSP+cB164Z34SrdLFHnOYvN8Jw2N3av4QUT1BUVIfpUvD+ch80K8kthnD6ek+DEbY6NRYrX1cCK++8NGZX98R64LmUDII+BN2Dw5UE9E6zxShxfwU/ckAvPxIc39J0gtuTDvjL4Xa8rg1Jg4RXgXWdDNI7rQIAKjm0sVegZuq//abC7uRlOYJCCLDeuN49MZUi9iH6JWDByKHaYhG1o+94qG8XIdn0555/0dUyEWAcKa6Fu24oZ/AjRYqdYr9UBs+4yxblL4Pcd80R47+1KJ6b3nCRe9VEBx8fk5YloxJOJvetQeaIl2JG1TPblj6ZxE+AaDCuqFtWNnxz+F2MHJ4cgn5TcOJ1V/gG93A2QIHVwlSaP3aWI4lhE95wQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aCq7HyU5hSr3NjFq9GJUW3IXndYUaVUuSJlMezqTy1gYeFqHQWVU6WNiOEQxar8INut9QL6bJwfZ8nv7bEaM9/YZY9qD9t3Ty6k6ElVTQrb4YQdO40tUeUvywD4ajYtefUK8qkMu9yUqenSXtF+pdL4gO8MFbpRrFe4rzfAiAWokKobU6PkzhnOxQbNXDYg5OoPpLlb3/GK5nP7UMDiFp/wK8ThALGWtKdgH9EtbUGjm0nHSY0HTxnjW3QQnBKoLR6ZyYYQiFFziTcW1UTJVCgGknyMaoHnbscYfmoWUQ5miMZJkfVFHJVYcY5VvVk5/T2UCB/210/XEImKOj4do+Me46AkbWoEFZojK8xbyhSkYspQjhMjy48lB4/uLV6Nxcr41A+aHHKXQUz7cztUett4O3ss545YhNZtuRf0cfO+XjsMC6K9eD89R+UYuiQQj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:15:15.6060 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c098ea93-d5e0-4946-5ddc-08deef48d100
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

Add hooks in various entry points to perform hw/sw init for DCN6 asic

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c     |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++------
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c    | 10 ++++++++++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |  1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c   |  9 +++++++--
 .../amd/display/dc/bios/command_table_helper2.c   |  1 +
 drivers/gpu/drm/amd/display/include/dal_types.h   |  1 +
 7 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index cf9c4b8df28b..45762096b20b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2658,6 +2658,7 @@ static int amdgpu_discovery_set_display_ip_blocks(struct amdgpu_device *adev)
 		case IP_VERSION(4, 1, 0):
 		case IP_VERSION(4, 2, 0):
 		case IP_VERSION(4, 2, 1):
+		case IP_VERSION(6, 0, 0):
 			/* TODO: Fix IP version. DC code expects version 4.0.1 */
 			if (adev->ip_versions[DCE_HWIP][0] == IP_VERSION(4, 1, 0))
 				adev->ip_versions[DCE_HWIP][0] = IP_VERSION(4, 0, 1);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index df6b59fb8d0d..0dcf829c1d07 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1011,6 +1011,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 1):
 		case IP_VERSION(4, 2, 0):
 		case IP_VERSION(4, 2, 1):
+		case IP_VERSION(6, 0, 0):
 			return 0;
 		default:
 			break;
@@ -2410,6 +2411,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(4, 0, 1):
 	case IP_VERSION(4, 2, 0):
 	case IP_VERSION(4, 2, 1):
+	case IP_VERSION(6, 0, 0):
 		if (amdgpu_dm_register_outbox_irq_handlers(dm->adev)) {
 			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 			goto fail;
@@ -2436,6 +2438,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 1):
 		case IP_VERSION(4, 2, 0):
 		case IP_VERSION(4, 2, 1):
+		case IP_VERSION(6, 0, 0):
 			psr_feature_enabled = true;
 			break;
 		default:
@@ -2455,6 +2458,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 2, 0):
 		case IP_VERSION(4, 2, 1):
+		case IP_VERSION(6, 0, 0):
 			replay_feature_enabled = true;
 			break;
 
@@ -2617,6 +2621,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(4, 0, 1):
 		case IP_VERSION(4, 2, 0):
 		case IP_VERSION(4, 2, 1):
+		case IP_VERSION(6, 0, 0):
 			if (amdgpu_dm_dcn10_register_irq_handlers(dm->adev)) {
 				drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 				goto fail;
@@ -2829,6 +2834,7 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 		case IP_VERSION(4, 0, 1):
 		case IP_VERSION(4, 2, 0):
 		case IP_VERSION(4, 2, 1):
+		case IP_VERSION(6, 0, 0):
 			adev->mode_info.num_crtc = 4;
 			adev->mode_info.num_hpd = 4;
 			adev->mode_info.num_dig = 4;
@@ -6320,12 +6326,9 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE)
 			continue;
 
-		/* Check if rotation or scaling is enabled on DCN401 */
-		if ((drm_plane_mask(crtc->cursor) &
-		     new_crtc_state->plane_mask) &&
-		    (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
-		     amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
-		     amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1))) {
+		/* Check if rotation or scaling is enabled on DCN 4x and above */
+		if ((drm_plane_mask(crtc->cursor) & new_crtc_state->plane_mask) &&
+		    (amdgpu_ip_version(adev, DCE_HWIP, 0) >= IP_VERSION(4, 0, 1))) {
 			new_cursor_state = drm_atomic_get_new_plane_state(state, crtc->cursor);
 
 			is_rotated = new_cursor_state &&
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
index 8e35d9ec22d6..9ff25bc8ee5a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
@@ -63,6 +63,7 @@ MODULE_FIRMWARE(FIRMWARE_DCN_36_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
 MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
+MODULE_FIRMWARE(FIRMWARE_DCN_60_DMUB);
 
 /**
  * dm_dmub_aux_setconfig_callback - Callback for AUX or SET_CONFIG command.
@@ -408,6 +409,9 @@ STATIC_IFN_KUNIT void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev
 	case IP_VERSION(4, 2, 1):
 		bb_size = sizeof(struct dml2_soc_bb);
 		break;
+	case IP_VERSION(6, 0, 0):
+		bb_size = sizeof(struct dmub_soc_bb_params);
+		break;
 	default:
 		return NULL;
 	}
@@ -560,6 +564,9 @@ int dm_dmub_sw_init(struct amdgpu_device *adev)
 	case IP_VERSION(4, 2, 1):
 		dmub_asic = DMUB_ASIC_DCN42B;
 		break;
+	case IP_VERSION(6, 0, 0):
+		dmub_asic = DMUB_ASIC_DCN60;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
@@ -752,6 +759,9 @@ int dm_init_microcode(struct amdgpu_device *adev)
 	case IP_VERSION(4, 2, 1):
 		fw_name_dmub = FIRMWARE_DCN_42B_DMUB;
 		break;
+	case IP_VERSION(6, 0, 0):
+		fw_name_dmub = FIRMWARE_DCN_60_DMUB;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
index c53728d1c131..31d5f8c265c0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
@@ -62,6 +62,7 @@ int dm_init_microcode(struct amdgpu_device *adev);
 #define FIRMWARE_DCN_401_DMUB		"amdgpu/dcn_4_0_1_dmcub.bin"
 #define FIRMWARE_DCN_42_DMUB		"amdgpu/dcn_4_2_dmcub.bin"
 #define FIRMWARE_DCN_42B_DMUB		"amdgpu/dcn_4_2_1_dmcub.bin"
+#define FIRMWARE_DCN_60_DMUB		"amdgpu/dcn_6_0_0_dmcub.bin"
 #define FIRMWARE_RAVEN_DMCU		"amdgpu/raven_dmcu.bin"
 #define FIRMWARE_NAVI12_DMCU		"amdgpu/navi12_dmcu.bin"
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index 0c6f0cac666e..824ef3ce5de0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -144,7 +144,8 @@ void amdgpu_dm_plane_fill_blending_from_plane_state(const struct drm_plane_state
 		 * other ASICs use an 8-bit field. The DRM plane alpha is
 		 * 16-bit, so scale it down to the width the hardware expects.
 		 */
-		if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0))
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0)
+		    || amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(6, 0, 0))
 			*global_alpha_value = plane_state->alpha >> 4;
 		else
 			*global_alpha_value = plane_state->alpha >> 8;
@@ -316,6 +317,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_validate_dcc(struct amdgpu_device *adev,
 		return 0;
 
 	if (adev->family != AMDGPU_FAMILY_GC_12_0_0 &&
+	    adev->family != AMDGPU_FAMILY_GC_13_0_1 &&
 	    format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
 		return -EINVAL;
 
@@ -1047,6 +1049,8 @@ STATIC_IFN_KUNIT int amdgpu_dm_plane_get_plane_modifiers(struct amdgpu_device *a
 		amdgpu_dm_plane_add_gfx11_modifiers(adev, mods, &size, &capacity);
 		break;
 	case AMDGPU_FAMILY_GC_12_0_0:
+	case AMDGPU_FAMILY_GC_13_0_1:
+		/* GFX13 (DCN6) shares the GFX12 tiling/DCC binary modifier format. */
 		amdgpu_dm_plane_add_gfx12_modifiers(adev, mods, &size, &capacity);
 		break;
 	}
@@ -1187,7 +1191,8 @@ int amdgpu_dm_plane_fill_plane_buffer_attributes(struct amdgpu_device *adev,
 			upper_32_bits(chroma_addr);
 	}
 
-	if (adev->family == AMDGPU_FAMILY_GC_12_0_0) {
+	if (adev->family == AMDGPU_FAMILY_GC_12_0_0
+	    || adev->family == AMDGPU_FAMILY_GC_13_0_1) {
 		ret = amdgpu_dm_plane_fill_gfx12_attrs_from_modifiers(adev, afb, format,
 										 rotation, plane_size,
 										 tiling_info, dcc,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
index 902f06ac43c6..9ae5cf42754a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table_helper2.c
@@ -86,6 +86,7 @@ bool dal_bios_parser_init_cmd_tbl_helper2(
 	case DCN_VERSION_4_01:
 	case DCN_VERSION_4_2:
 	case DCN_VERSION_4_2B:
+	case DCN_VERSION_6_0:
 		*h = dal_cmd_tbl_helper_dce112_get_table2();
 		return true;
 
diff --git a/drivers/gpu/drm/amd/display/include/dal_types.h b/drivers/gpu/drm/amd/display/include/dal_types.h
index f77fc367eab1..d67fe0a64418 100644
--- a/drivers/gpu/drm/amd/display/include/dal_types.h
+++ b/drivers/gpu/drm/amd/display/include/dal_types.h
@@ -67,6 +67,7 @@ enum dce_version {
 	DCN_VERSION_4_01,
 	DCN_VERSION_4_2,
 	DCN_VERSION_4_2B,
+	DCN_VERSION_6_0,
 	DCN_VERSION_MAX
 };
 
-- 
2.34.1

