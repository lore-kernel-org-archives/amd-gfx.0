Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D61FCD5BCF
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 07:20:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D44DE10E512;
	Tue, 26 May 2026 07:20:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ymv993te";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012058.outbound.protection.outlook.com
 [40.107.200.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFE5C10E512
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:20:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bFA49+u6GTOj62k2VPhwAH4fEMV+pk7QenU/VQJ6mtemSqYNxcsoBJ3TOma7E8ZdFlGygWXGZirrw5CkLRT+xhRVspg8nbqSpGpuKhb6nXVYs2ILRyKu/PFPL2kRjMCkWEjAGBc88lem0oBk6WcYl2rQiGhDjKVln1LZM8hlgUxkdWV3mjQv+UsEh4OeUTpqcW2qaDFy+j0oJnM0psqODiEjnFhxEGrFkkB02xCYaPVMy3FaBDarEIvHxd2WBG20SSUdc9CGlTy4M/JCIfr7mxynxVl2GcfnMKVy9ZSJXeO/aqdKjAXu9lqXi2PSzjfsdF263bz9ExqdDXz4/P3j9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAtuUi2RNRjf8frmiUr6QkYGklGI1tcysYE49Ailat8=;
 b=SQ0SIwsHKyChZN6KQitdMceHR4/TSN75LgWW3MVQTFr32PPIx06V2/dWA4yDkiXb8U4W8H1IQq8Kyrby8tCLS4f80gpE+4OUE0/c23fDyok9yI+KUm4pmiB8Lvmyk0GyXIkN323GM/x+g5hkKF0jwB/jzdR136vSvwACqy4pKD6KdFeXb6WcZouKqb3mW5YUqfomwstMm7J2ha5hPHPEjMcjzUrLWVhNoXSXF6lZBLzcl2VhJ1teRXTt80KVDAIrnHpv+RfFZPzVn6c/dXJkvtd57Rr/0MIGCPiOOuDtXpsYdKFlfMra0g8UgsPezZ4b/2CyLhMKbUtXzMBPzbJm4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rAtuUi2RNRjf8frmiUr6QkYGklGI1tcysYE49Ailat8=;
 b=Ymv993tepZU0h9DrMBrHb14Qx9FS0RjC5S7UdSrwpPrX3ak0/Jt8zMrGVuJWf4gl6DkwcGAOxxUXlYl1Xe0D9jREBBwxkfdbPvrEuWtCLNIwHtpFMrc0M02XLxSefjp2xWFgk76ziUYWhNrMYzOO3UTfmW67SBmP0U6Uwl5iZTA=
Received: from BL1PR13CA0090.namprd13.prod.outlook.com (2603:10b6:208:2b8::35)
 by SA1PR12MB8965.namprd12.prod.outlook.com (2603:10b6:806:38d::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 07:20:34 +0000
Received: from BL02EPF0001A102.namprd05.prod.outlook.com
 (2603:10b6:208:2b8:cafe::c) by BL1PR13CA0090.outlook.office365.com
 (2603:10b6:208:2b8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 07:20:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A102.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Tue, 26 May 2026 07:20:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 02:20:29 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 26 May
 2026 00:20:29 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 26 May 2026 02:20:21 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 38/41] drm/amd/display: Enable DCN 4.2.1 in amdgpu_dm
Date: Tue, 26 May 2026 15:02:01 +0800
Message-ID: <20260526071413.2181251-39-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526071413.2181251-1-ray.wu@amd.com>
References: <20260526071413.2181251-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A102:EE_|SA1PR12MB8965:EE_
X-MS-Office365-Filtering-Correlation-Id: 239d53e1-1744-4910-9e30-08debaf746b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|56012099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XIWXsi3uj+1Ydg9sg68woJsCQWr/kIKbqMDpA8Xh31CCPrOCKp95OfRCQvfjoxmibWyxYIp1VgZV6bhyy52WI5IJWk6jP+bONvh9oaU9ciI6235TBWrxg8HR7WkbkngNz/f7dj+1/FPZjWn3/ArnKXcy5LewlZDgM0xYigfV+FKsaroxZUMzDsAfnSoqMCKMyFH45FZ1qY0vPk3NbzkO929zMzaK7uo4gIRV5uAAbJleY5z6Rs/pRX5kHBHKsXWjqFHIJ/+0xP8Z9bzVICsh1jTL1owNJOTWClcgsRegtk5JoELad9m0rBIePZCO+uag4Iv/f9xFTGrixfRq5SwlBUmycIbbHIdWvTABh+KnJLHnkoCxeYkNaLx7CmByoSaTUwE96ocp4wn0aDnHcmIUU46GHETOqmfmBBA6IVnqncgeT6doGs3CGLme4G/itN1a7szBBS7/mKtWDpU+dx47TUUExeDuLAScYePBvbWE2w9WAJCxC5uxWOV4FbrNfr3dHo+XQaTGfK16h6qGFl1wOhzb99GFJvmPuoY6UnW1FNT6OPamoUlrcy+4qb4LQ4iEh9MN/aEgr2UrFrOcXPojbBKLS3a6Tdnlv9NArIboR4rtUmUdWG0VAM9ZO0GbzP7fytOoY2FOFWqHXSVPm7rDRe7qA4TvJ/APImoX5dxMwwy+nDlFsLvaQOBgA4I3HqyBpmnZ7yKyTcjrwmEd7+/L/iH/7hAyos4JeNGeeONAo2Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(56012099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0c4oTtmczASxv7sqv3y8aFdcTasDD38uGFNzGC+hwexvurgPtSolHMbzgdRsV4iEF71e61WWc0h7ZWuIivtpBhWiyTKfBdoeOr5DKfNeea/6pxbX6kd6JtiO3XUyNpXXYsOoA++JMVqJvjUP78flPM8eSXfWC0fcjW1Fb0skJQIpvO4xs0Rwr7RuDWzeoRFyzjlcC7AZ927oVnDR0PNdLa3XZlmV0vww9USoAhIatIAFNd7fjXVlQmYFaRGwWf1B6Q1VH2WhuyYab+XSThRsF8Vwp7Vxl7n0ndiwuAZK1cLrQsdfVi555MexHCCMrFeS4N1wONLBJnQADrBaJpfqXfQmBNJKHieq6OiofvW+5vvvAZpzLMoXTH1kItdeyEruI6KekbYXf/96zeSEoG8tYL0c4Ut1pC/5nTTM5G+7v7VHwZGWt5XNkBHOWoSdB1bt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 07:20:33.8486 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 239d53e1-1744-4910-9e30-08debaf746b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A102.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8965
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

From: Matthew Stewart <matthew.stewart2@amd.com>

[Why & How]
Add checks for IP version 4.2.1.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 29 ++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d6eba4c37647..92d0eabc5881 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -158,6 +158,9 @@ MODULE_FIRMWARE(FIRMWARE_DCN_401_DMUB);
 #define FIRMWARE_DCN_42_DMUB "amdgpu/dcn_4_2_dmcub.bin"
 MODULE_FIRMWARE(FIRMWARE_DCN_42_DMUB);
 
+#define FIRMWARE_DCN_42B_DMUB "amdgpu/dcn_4_2_1_dmcub.bin"
+MODULE_FIRMWARE(FIRMWARE_DCN_42B_DMUB);
+
 /**
  * DOC: overview
  *
@@ -1372,6 +1375,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	case IP_VERSION(3, 5, 1):
 	case IP_VERSION(3, 6, 0):
 	case IP_VERSION(4, 2, 0):
+	case IP_VERSION(4, 2, 1):
 		hw_params.ips_sequential_ono = adev->external_rev_id > 0x10;
 		hw_params.lower_hbr3_phy_ssc = true;
 		break;
@@ -1820,6 +1824,7 @@ static void *dm_dmub_get_vbios_bounding_box(struct amdgpu_device *adev)
 		bb_size = sizeof(struct dml2_soc_bb);
 		break;
 	case IP_VERSION(4, 2, 0):
+	case IP_VERSION(4, 2, 1):
 		bb_size = sizeof(struct dml2_soc_bb);
 		break;
 	default:
@@ -1867,6 +1872,7 @@ static enum dmub_ips_disable_type dm_get_default_ips_mode(
 		ret =  DMUB_IPS_RCG_IN_ACTIVE_IPS2_IN_OFF;
 		break;
 	case IP_VERSION(4, 2, 0):
+	case IP_VERSION(4, 2, 1):
 		ret =  DMUB_IPS_ENABLE;
 		break;
 	default:
@@ -2480,6 +2486,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
 		case IP_VERSION(4, 2, 0):
+		case IP_VERSION(4, 2, 1):
 			return 0;
 		default:
 			break;
@@ -2618,6 +2625,9 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 	case IP_VERSION(4, 2, 0):
 		dmub_asic = DMUB_ASIC_DCN42;
 		break;
+	case IP_VERSION(4, 2, 1):
+		dmub_asic = DMUB_ASIC_DCN42B;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
@@ -5737,6 +5747,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 	case IP_VERSION(3, 6, 0):
 	case IP_VERSION(4, 0, 1):
 	case IP_VERSION(4, 2, 0):
+	case IP_VERSION(4, 2, 1):
 		if (register_outbox_irq_handlers(dm->adev)) {
 			drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 			goto fail;
@@ -5762,6 +5773,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
 		case IP_VERSION(4, 2, 0):
+		case IP_VERSION(4, 2, 1):
 			psr_feature_enabled = true;
 			break;
 		default:
@@ -5780,6 +5792,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 5, 1):
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 2, 0):
+		case IP_VERSION(4, 2, 1):
 			replay_feature_enabled = true;
 			break;
 
@@ -5941,6 +5954,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
 		case IP_VERSION(4, 2, 0):
+		case IP_VERSION(4, 2, 1):
 			if (dcn10_register_irq_handlers(dm->adev)) {
 				drm_err(adev_to_drm(adev), "DM: Failed to initialize IRQ\n");
 				goto fail;
@@ -6092,6 +6106,9 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 	case IP_VERSION(4, 2, 0):
 		fw_name_dmub = FIRMWARE_DCN_42_DMUB;
 		break;
+	case IP_VERSION(4, 2, 1):
+		fw_name_dmub = FIRMWARE_DCN_42B_DMUB;
+		break;
 	default:
 		/* ASIC doesn't support DMUB. */
 		return 0;
@@ -6220,6 +6237,7 @@ static int dm_early_init(struct amdgpu_ip_block *ip_block)
 		case IP_VERSION(3, 6, 0):
 		case IP_VERSION(4, 0, 1):
 		case IP_VERSION(4, 2, 0):
+		case IP_VERSION(4, 2, 1):
 			adev->mode_info.num_crtc = 4;
 			adev->mode_info.num_hpd = 4;
 			adev->mode_info.num_dig = 4;
@@ -12651,7 +12669,8 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 	 * as previous DCN generations, so enable native mode on DCN401/420
 	 */
 	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1) ||
-	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0)) {
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
+	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1)) {
 		*cursor_mode = DM_CURSOR_NATIVE_MODE;
 		return 0;
 	}
@@ -13087,9 +13106,11 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 			continue;
 
 		/* Check if rotation or scaling is enabled on DCN401 */
-		if ((drm_plane_mask(crtc->cursor) & new_crtc_state->plane_mask) &&
-		    (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
-		    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1))) {
+		if ((drm_plane_mask(crtc->cursor) &
+		     new_crtc_state->plane_mask) &&
+		    (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 1) ||
+		     amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 2, 0) ||
+		     amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1))) {
 			new_cursor_state = drm_atomic_get_new_plane_state(state, crtc->cursor);
 
 			is_rotated = new_cursor_state &&
-- 
2.43.0

