Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE353C9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:12:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F3AD10E415;
	Wed, 23 Sep 2026 15:12:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aNVFzANm";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012066.outbound.protection.outlook.com [52.101.48.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4482F10E415
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:12:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FSJa5D/FuAtJPLzIHcsRVamCXj4JmImDtdMo9HS+ntwDOnKUD267he17wmiQvHMJW4I5OAY2FIiE88j42wvd6bIbV0fGSHO3r/NCeWEembbiPqDE++qcApwVSq3Z0o7BBrTIcSmbg0rVDgZVfMbT9J0COfc+0CyV9L4hT50EkVaIt+ostlFcpIr/LZj47ZQdWZXhgRM9SYgDTt2m3QG0cnbza0ovs6wMrCrdrdexhfECpfGW0C+BLkW8XjFB/rqQtWtvlnD0Tvx+ejTtYNVj4QwX3cBV1hZulXxq+jEYpoO5Ie1shMYkjlB5xSI0Ywb8ZDqq7Ke1qiBdmwbM3hk/Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yD9Za6sZDE8A6n/L8kg0PlPGSDXlpdhHHHrKgnBreC4=;
 b=mlVJbqV69aeukUXWwViJvpzEkUxNQd9vL1ZOr0rTZeFHsgbNTIfPn4ZA7EvsJdHrcGb6pfjXbC4HKs427GXe2VsIQl01MEgo3OuA4+skVhf6XI64ZkDHUn3koYJvY5DaPcZfDzjRZH44yySyJiYWOG/yCRWMm3Vvaos1uGcDnWD2qECJ8eswTmxhBYXIM7dTwNbjDOZPWCeyJm4qd+Quyvtxum9aXJXLAJnQZjX8dYTWBbd42f/fTYJZagYQk/+OAK3HmFM/3bKApYgpZLWUG7/iiRO801fEmfyhDtmKEeTJ1rC21n9fyXjHGnMaiggkqkt+c9rmRFsNt0YEIWnSxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yD9Za6sZDE8A6n/L8kg0PlPGSDXlpdhHHHrKgnBreC4=;
 b=aNVFzANmMueJySoyTJ4Gm3k5sKbhv0y/OoYiEzRdndFVYppGneKtxSqOaHZVmWoXfjWMQVOODimxLsiNkJ9Bm4qTj6u+9Yz6iF19cvL7tb3YomWefdNMQ/uXk1i0dGrp4mzHrtQZ4pjtxwpGoh/fxg6aOC5dw0QB1kueyYq4108=
Received: from PH8PR02CA0008.namprd02.prod.outlook.com (2603:10b6:510:2d0::17)
 by LV0PR12MB507217.namprd12.prod.outlook.com (2603:10b6:408:3b7::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.17; Wed, 23 Sep
 2026 15:12:48 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::45) by PH8PR02CA0008.outlook.office365.com
 (2603:10b6:510:2d0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.16 via Frontend Transport; Wed,
 23 Sep 2026 15:12:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:12:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:12:40 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:12:39 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lin Cao <lincao12@amd.com>, Yifan Zha <Yifan.Zha@amd.com>, Yiqing Yao
 <yiqing.yao@amd.com>, Frank Min <Frank.Min@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 09/12] drm/amdgpu: add new MEC2 firmware loading framework
Date: Wed, 23 Sep 2026 11:12:23 -0400
Message-ID: <20260923151226.2778589-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923151226.2778589-1-alexander.deucher@amd.com>
References: <20260923151226.2778589-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|LV0PR12MB507217:EE_
X-MS-Office365-Filtering-Correlation-Id: 005fe9b2-796c-4229-5a52-08df19852076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /H6BhZRwJ5h4vj2XaOYBhDacooEuYq89YkgEYulchMYq/M7BF6a6Wfv0vFXaVWjCYVYFe/Ab8ND66m9a/P2FOcSmUc9QC/q4Mk7jEGPCQQAywoi8Al1hz/MCOG1X5Tpx7KXz0EjLTSVGv6igIpeLhH6ji8kukEGaCwMHB+w1xYfwAhI8X8D9wyzu4YzsLCahiGAJkFfac8/ylWQxLbo59qNyWAw0v6b5hFUuRqNHNccJJl+HsCrzpNlIvzILOFA3MnTFqKgeKt5T9wl5hKiOKYKE22bjb0fZzKTlFrCaSpgetlyTlahfNVBWUPmmAdk9bgAsCL3Zh3LiOduteakma0o1SVDOnT898kG5+Tc7Pft9iZgxGwAIUQfKFAUmAMqWFW9LnSAs4PeQHtqh5mmVYHl79zz5RJyNdNaYwBIt6E2/VOp/72gPmB8/1fme8khOxY/jfviSYouUEcacrcHZRuTWVzA10YcCUZh7OLf+iDI2VWC3m9yc+wa8wX4fpJmIT3U+fpgi47vSnIr3kjkc5w3uDL3k/JRhvfzSyAzN1w5YVfz29KJF8hlf3sII84+bEVnXF1RUJnRzcdw5zmmRbEIPaOv8r1E+lS/kyp9m2pvp0mQnTzI47S8UT7LJLCawNnVwLMfKyd7gZWnVn4BhNuNlbQSUURLaCdWt+LQzXoVmvTv97pTidkc+SUX84n2ie9rf1h4KggGyfq5VAZK/Ug==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GkAEMDfy04oq1JFvXwjH9kONW9oeFUr56tKmKgEA6xjrzlm2Xa7Vq/UShlXszaznJ3BmLWBZxSPHg+GjPvaIqOO95bkOAb/xtamTzOGEXePOGzkiD6NosikfsrLzKRIlH+uKbDwTxcOzW96G/mk7TRoKycEnJnrojhuAJE2RpvUP5idMEtQwIiSTpkK+iMvkAl5aP3uIi2Ykcmzq1Z5HAWQUFTfQ/E7BiQ5ierhK0OCihe9bcz6cqXjuJSj+VDhznORaaCeNKdhkk7BoArkaku3OG85VR4JZGg2v813yUDXwnVGVfRqmuAUt9ugM6+ckBbE0dRrDmpa46J05PaphNEr/qNNQ4q+H0Jq+rWQ3AEwn/LsFxZyxlw+XyH5z0pHEIf5I+cUfCB/ytcKoMoMd1XlwcgsnrjL/wzQTkXrtF18Ik/Kpu6Dp78jpSbEZSuul
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:12:47.5211 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 005fe9b2-796c-4229-5a52-08df19852076
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR12MB507217
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

From: Lin Cao <lincao12@amd.com>

Add ucode loading support for MEC pipe stacks P4-P7:
 - add GFX_FW_TYPE_RS64_MEC_P4..P7 firmware types
 - add AMDGPU_UCODE_ID_CP_RS64_MEC_P4..P7 ucode ids
 - handle P4-P7 in ucode name/init, psp fw type

Signed-off-by: Yifan Zha <Yifan.Zha@amd.com>
Signed-off-by: Yiqing Yao <yiqing.yao@amd.com>
Signed-off-by: Lin Cao <lincao12@amd.com>
Reviewed-by: Frank Min<Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 12 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 28 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  4 ++++
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h   |  4 ++++
 drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c  | 12 ++++++++++
 6 files changed, 64 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 7a132e6d7e429..4e38285e90676 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1599,6 +1599,10 @@ void amdgpu_gfx_cp_init_microcode(struct amdgpu_device *adev,
 	case AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK:
 	case AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK:
 	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P4_STACK:
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P5_STACK:
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P6_STACK:
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P7_STACK:
 		cp_hdr_v2_0 = (const struct gfx_firmware_header_v2_0 *)
 			adev->gfx.mec_fw->data;
 		ucode_fw = adev->gfx.mec_fw;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 5db568fc24218..56116bcd0a3a8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3726,6 +3726,18 @@ int amdgpu_psp_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
 		*type = GFX_FW_TYPE_RS64_MEC_P3_STACK;
 		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P4_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P4_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P5_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P5_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P6_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P6_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P7_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P7_STACK;
+		break;
 	case AMDGPU_UCODE_ID_VPE_CTX:
 		*type = GFX_FW_TYPE_VPEC_FW1;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index e5d47f08715f3..d2ce526dd95cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -751,6 +751,14 @@ const char *amdgpu_ucode_name(enum AMDGPU_UCODE_ID ucode_id)
 		return "RS64_MEC_P2_STACK";
 	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
 		return "RS64_MEC_P3_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P4_STACK:
+		return "RS64_MEC_P4_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P5_STACK:
+		return "RS64_MEC_P5_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P6_STACK:
+		return "RS64_MEC_P6_STACK";
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P7_STACK:
+		return "RS64_MEC_P7_STACK";
 	case AMDGPU_UCODE_ID_ISP:
 		return "ISP";
 	case AMDGPU_UCODE_ID_MP5:
@@ -1094,6 +1102,26 @@ static int amdgpu_ucode_init_single_fw(struct amdgpu_device *adev,
 			ucode_addr = (u8 *)ucode->fw->data +
 				le32_to_cpu(cpv2_hdr->data_offset_bytes);
 			break;
+		case AMDGPU_UCODE_ID_CP_RS64_MEC_P4_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_MEC_P5_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_MEC_P6_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
+		case AMDGPU_UCODE_ID_CP_RS64_MEC_P7_STACK:
+			ucode->ucode_size = le32_to_cpu(cpv2_hdr->data_size_bytes);
+			ucode_addr = (u8 *)ucode->fw->data +
+				le32_to_cpu(cpv2_hdr->data_offset_bytes);
+			break;
 		case AMDGPU_UCODE_ID_VPE_CTX:
 			ucode->ucode_size = le32_to_cpu(vpe_hdr->ctx_ucode_size_bytes);
 			ucode_addr = (u8 *)ucode->fw->data +
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 83e5f0627369d..35277b240f25a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -503,6 +503,10 @@ enum AMDGPU_UCODE_ID {
 	AMDGPU_UCODE_ID_CP_RS64_MEC_P1_STACK,
 	AMDGPU_UCODE_ID_CP_RS64_MEC_P2_STACK,
 	AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_MEC_P4_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_MEC_P5_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_MEC_P6_STACK,
+	AMDGPU_UCODE_ID_CP_RS64_MEC_P7_STACK,
 	AMDGPU_UCODE_ID_CP_MEC1,
 	AMDGPU_UCODE_ID_CP_MEC1_JT,
 	AMDGPU_UCODE_ID_CP_MEC2,
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index d54b9edcd5394..612d532494764 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -322,6 +322,10 @@ enum psp_gfx_fw_type {
 	GFX_FW_TYPE_VPE                             = 102,
 	GFX_FW_TYPE_JPEG_RAM                        = 128,  /**< JPEG Command buffer */
 	GFX_FW_TYPE_P2S_TABLE                       = 129,
+    GFX_FW_TYPE_RS64_MEC_P4_STACK               = 133,  /* RS64 MEC stack P4        ATx     */
+    GFX_FW_TYPE_RS64_MEC_P5_STACK               = 134,  /* RS64 MEC stack P5        ATx     */
+    GFX_FW_TYPE_RS64_MEC_P6_STACK               = 135,  /* RS64 MEC stack P6        ATx     */
+    GFX_FW_TYPE_RS64_MEC_P7_STACK               = 136,  /* RS64 MEC stack P7        ATx     */
 	GFX_FW_TYPE_MP5                             = 158,  /* MP5 ucode    */
 	GFX_FW_TYPE_MAX
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
index cab3bec1e5127..33662a1aad16c 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v15_0_3.c
@@ -746,6 +746,18 @@ static int psp_v15_0_3_get_fw_type(struct amdgpu_firmware_info *ucode,
 	case AMDGPU_UCODE_ID_CP_RS64_MEC_P3_STACK:
 		*type = GFX_FW_TYPE_RS64_MEC_P3_STACK;
 		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P4_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P4_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P5_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P5_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P6_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P6_STACK;
+		break;
+	case AMDGPU_UCODE_ID_CP_RS64_MEC_P7_STACK:
+		*type = GFX_FW_TYPE_RS64_MEC_P7_STACK;
+		break;
 	case AMDGPU_UCODE_ID_VPE_CTX:
 		*type = GFX_FW_TYPE_VPEC_FW1;
 		break;
-- 
2.55.0

