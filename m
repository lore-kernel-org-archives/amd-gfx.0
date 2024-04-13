Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E59AC4345F
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Apr 2024 23:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FA110E56C;
	Sat, 13 Apr 2024 23:31:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="G3yMzgVV";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3109110E3F2
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Apr 2024 23:31:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c16yXGr8cUiRx2nBUcsusAWk7WsTldkp1Giocn4xG8JF/+JSUuddsDhZ7iXcVX/XtsKXFB5GEpCvbp2m3Bp4XvkIlJZAQEW8oNkVX2OPoj21DPN7Ef54RjtOcwAt8cTkw1NLYa2g5qjoBBh/kUoPOpcx2W/JJsRzCpixgba2oiCbjtS1VRKxdgl4UImUc/ZY7E/48+Bzpq3DoRX0NbKoz3KawzEZT5iSvzCCXs/F49FGYmK1+PVLzN2BNCJpmbBTspLDWFnJbdQsYjEXOwVkXOVyXdgUcKa7k9p8xp6OdQE+5/0u6MGj5WoZzDJhmd7A22RTkK/VBqbYx5xdGzSN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=15wXJ4iP1VO8iYrctLpu49rh/KC4RCzubykKikoJbA0=;
 b=KSrAAjGFauuSJXFIhe2lO3vxZgF3/T81JGYgVqTY1jT4F1/+lflIo3TPSJm7xqbdxyY9cfKk+ZSnWOQzo+1nkmZkiwNC0I8C9oeA5XnJXEJ6/44qZJu8qPI4HXZvo1Jr8kx1oPtZf8HRIp864xIpk2XfJ5TZ5iOoLhxpnOc3Y7FFdHuCLxjejCGPnHtqR5iggmzt/Gipm+j9h35NauknCM1J12vSKgozIH8B6U+iT5mHsefHwgeyH0h80XDG2OXgrerzfDudfgAERDg3dvYyiEJWNDEHuOC5PbdaPpSMLFkeUkJMMdRUU5rSouPGWsq44LaxEAkL8J2WgUQZ6SIJSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15wXJ4iP1VO8iYrctLpu49rh/KC4RCzubykKikoJbA0=;
 b=G3yMzgVV3v8DPDrFfUL4ivWwIkY5BgDont1RH8gbwkWB//Ce+Au0zWcryL1igGkUCUSfpKUCK61ZpTFCB6N4gSlMm02Me3C4vR2MuLWX37CQ50O6o+awWjrn0ceoV97YzND3gvQkWK/mdw8Pi/WCXLSzK07Pkd9T/kH+o8AqECM=
Received: from PH8PR22CA0024.namprd22.prod.outlook.com (2603:10b6:510:2d1::15)
 by DM6PR12MB4434.namprd12.prod.outlook.com (2603:10b6:5:2ad::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Sat, 13 Apr
 2024 23:31:51 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::1b) by PH8PR22CA0024.outlook.office365.com
 (2603:10b6:510:2d1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.32 via Frontend
 Transport; Sat, 13 Apr 2024 23:31:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 23:31:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Apr
 2024 18:31:48 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Load ipkeymgr drv for psp v14
Date: Sat, 13 Apr 2024 19:31:33 -0400
Message-ID: <20240413233134.3989380-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|DM6PR12MB4434:EE_
X-MS-Office365-Filtering-Correlation-Id: 9602ef36-e04e-4440-b443-08dc5c11e4b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxuWGWrz9K9Qc/XEugJV+sDcFK3yKmomKHxFOAvnwfNYzkYYyKqyzqEieXT1LlozomkPMQVWQtUDYL8P0GvBcuJKeHID1fl8N/N3ZvZq//KvHrNLpbUTJqwCPjm13LkdhVXxOo/YPvBgzKVcNPjr4vMQg0c2T7oAh2Ruuv7MsT1dRKlFJHdOv2ytZFYh1a66I2wnt7Cwd2iRYJYN2c+aZQkWe+STxYP1RKGoYZP//Fn8O6aH9uZ9xu3dPYuWmaPF8SYUxRpYtgJHic9TEtkyOnMEnfh8uiNligo76kmwNWZ31Ih4Gbrhe1HmHWGg0lulmOoJ3KHXhoxUE5TnhPKASLTQYydXcvxqRS5iepnJT6V2mx10aZftadgwrIyQK+lAC65y0h+N81VpH6+B8QKzwefbBk8vrUX/l2EhDFgo3GOKVjqWHMdHMy/Iy9ZaoFZR3aqwoWCIXc2RD5mvgXaDge1db2BZar91ajvuNVmJoNS1gw80cZiNzpuGCbW34zfvMHvC6jYwaH1PBHCoJd29w4u3R1Zg5YLHJ/BUy4AmhCgjaJW4UL3JKEf8msKKhGOMJIjvgIO/c22vClyQMDeH2i06/wPpeo24V3MDP0s4AbUSKofD7SNJCKqGRm7XJn+g9zLTr4DkuayrIPlJBDcqMFKewGU6mdoSvT1pT5Wb9Ui1PxsCGdRyvCZxMN5KTWraI63p7iYoSBiEqKtdzonx88OOVit1v7BwYoiUMV1IDllDiMJDQ94heMO03pjCQiL4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 23:31:49.9877 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9602ef36-e04e-4440-b443-08dc5c11e4b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4434
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

while DBG_DRV is renamed to HAD_DRV for psp v14,
part of its APIs/functionality is moved to a new
component named Ipkeymgr_Drv.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c   | 15 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h   |  8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_v14_0.c    |  5 +++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index edae581059af0..4bd4602d11b1e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -2265,6 +2265,15 @@ static int psp_hw_start(struct psp_context *psp)
 			}
 		}
 
+		if ((is_psp_fw_valid(psp->ipkeymgr_drv)) &&
+		    (psp->funcs->bootloader_load_ipkeymgr_drv != NULL)) {
+			ret = psp_bootloader_load_ipkeymgr_drv(psp);
+			if (ret) {
+				dev_err(adev->dev, "PSP load ipkeymgr_drv failed!\n");
+				return ret;
+			}
+		}
+
 		if ((is_psp_fw_valid(psp->sos)) &&
 		    (psp->funcs->bootloader_load_sos != NULL)) {
 			ret = psp_bootloader_load_sos(psp);
@@ -3280,6 +3289,12 @@ static int parse_sos_bin_descriptor(struct psp_context *psp,
 		psp->ras_drv.size_bytes         = le32_to_cpu(desc->size_bytes);
 		psp->ras_drv.start_addr         = ucode_start_addr;
 		break;
+	case PSP_FW_TYPE_PSP_IPKEYMGR_DRV:
+		psp->ipkeymgr_drv.fw_version         = le32_to_cpu(desc->fw_version);
+		psp->ipkeymgr_drv.feature_version    = le32_to_cpu(desc->fw_version);
+		psp->ipkeymgr_drv.size_bytes         = le32_to_cpu(desc->size_bytes);
+		psp->ipkeymgr_drv.start_addr         = ucode_start_addr;
+		break;
 	default:
 		dev_warn(psp->adev->dev, "Unsupported PSP FW type: %d\n", desc->fw_type);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index ee16f134ae920..66b3f88fbecdd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -74,7 +74,8 @@ enum psp_bootloader_cmd {
 	PSP_BL__LOAD_SOCDRV             = 0xB0000,
 	PSP_BL__LOAD_DBGDRV             = 0xC0000,
 	PSP_BL__LOAD_INTFDRV		= 0xD0000,
-	PSP_BL__LOAD_RASDRV		    = 0xE0000,
+	PSP_BL__LOAD_RASDRV		= 0xE0000,
+	PSP_BL__LOAD_IPKEYMGRDRV	= 0xF0000,
 	PSP_BL__DRAM_LONG_TRAIN		= 0x100000,
 	PSP_BL__DRAM_SHORT_TRAIN	= 0x200000,
 	PSP_BL__LOAD_TOS_SPL_TABLE	= 0x10000000,
@@ -117,6 +118,7 @@ struct psp_funcs {
 	int (*bootloader_load_intf_drv)(struct psp_context *psp);
 	int (*bootloader_load_dbg_drv)(struct psp_context *psp);
 	int (*bootloader_load_ras_drv)(struct psp_context *psp);
+	int (*bootloader_load_ipkeymgr_drv)(struct psp_context *psp);
 	int (*bootloader_load_sos)(struct psp_context *psp);
 	int (*ring_create)(struct psp_context *psp,
 			   enum psp_ring_type ring_type);
@@ -336,6 +338,7 @@ struct psp_context {
 	struct psp_bin_desc		intf_drv;
 	struct psp_bin_desc		dbg_drv;
 	struct psp_bin_desc		ras_drv;
+	struct psp_bin_desc		ipkeymgr_drv;
 
 	/* tmr buffer */
 	struct amdgpu_bo		*tmr_bo;
@@ -424,6 +427,9 @@ struct amdgpu_psp_funcs {
 #define psp_bootloader_load_ras_drv(psp) \
 		((psp)->funcs->bootloader_load_ras_drv ? \
 		(psp)->funcs->bootloader_load_ras_drv((psp)) : 0)
+#define psp_bootloader_load_ipkeymgr_drv(psp) \
+		((psp)->funcs->bootloader_load_ipkeymgr_drv ? \
+		 (psp)->funcs->bootloader_load_ipkeymgr_drv((psp)) : 0)
 #define psp_bootloader_load_sos(psp) \
 		((psp)->funcs->bootloader_load_sos ? (psp)->funcs->bootloader_load_sos((psp)) : 0)
 #define psp_smu_reload_quirk(psp) \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 6194457600372..105d4de0613af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -125,6 +125,7 @@ enum psp_fw_type {
 	PSP_FW_TYPE_PSP_INTF_DRV,
 	PSP_FW_TYPE_PSP_DBG_DRV,
 	PSP_FW_TYPE_PSP_RAS_DRV,
+	PSP_FW_TYPE_PSP_IPKEYMGR_DRV,
 	PSP_FW_TYPE_MAX_INDEX,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
index 78a95f8f370be..241d5ff2ef3cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v14_0.c
@@ -177,6 +177,10 @@ static int psp_v14_0_bootloader_load_ras_drv(struct psp_context *psp)
 	return psp_v14_0_bootloader_load_component(psp, &psp->ras_drv, PSP_BL__LOAD_RASDRV);
 }
 
+static int psp_v14_0_bootloader_load_ipkeymgr_drv(struct psp_context *psp)
+{
+	return psp_v14_0_bootloader_load_component(psp, &psp->ipkeymgr_drv, PSP_BL__LOAD_IPKEYMGRDRV);
+}
 
 static int psp_v14_0_bootloader_load_sos(struct psp_context *psp)
 {
@@ -653,6 +657,7 @@ static const struct psp_funcs psp_v14_0_funcs = {
 	.bootloader_load_intf_drv = psp_v14_0_bootloader_load_intf_drv,
 	.bootloader_load_dbg_drv = psp_v14_0_bootloader_load_dbg_drv,
 	.bootloader_load_ras_drv = psp_v14_0_bootloader_load_ras_drv,
+	.bootloader_load_ipkeymgr_drv = psp_v14_0_bootloader_load_ipkeymgr_drv,
 	.bootloader_load_sos = psp_v14_0_bootloader_load_sos,
 	.ring_create = psp_v14_0_ring_create,
 	.ring_stop = psp_v14_0_ring_stop,
-- 
2.44.0

