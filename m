Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5850D6DDD7
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 06:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A32A10E39C;
	Fri, 15 Nov 2024 06:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ynxsQ2K/";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F07010E39C
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 06:09:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQDaPRmJVOTgiCDKyo7oHwfIypeuufycCYL+dVtHNPJm20abjN6tIljXSnMD8Z0fv0VAk1aRifTyt0bOpjBXOrceMl/R0wfGCrVKdr4B82o2xyYh7nfFiXbOWCLJAmHzBadnOwpWP67pPV4pkIatkQQwUMbOQvvc676eAQr22QBXYAczscwvGq0gcIRht9sXRtW0/TrAWv3hiLE2mo1DRaKChbP8hdctn35zyql5bn7W86P9PDebZhcjjsl5LKmojSPEU25phe4HkbsN2c5B4J99eW7FomxDsNGpM4aEmpkk6jhfId2PU7O0fZosP+KO8bVnzYWg6WALOWE6XeYd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qkHFXVjhUqGhGcmzBnqrNiBqCom80DD/jbaHGNuE2W4=;
 b=A4jScngH7INj7UE2a/BYmtJmR46c22XYHjflJX6QuBnpkNZWIRJCbR5RyxLaXuvTnBsFapKogt/dCdfYNeRtWVoLbCnIY9tmicpvz7oTjQxcgn1kjAVI3oPgnzW7du7MUuIQ475M9eSmbgjrA4kKPMtcz88vgT+VE35TajM9EM/SyP3SeZXU+3siCdCZxLOe6dc5V1DYd3Jq36gNUn1/G7SGAY28Adcsu9m5iDt7SpPIUQDyMIpo/U2oh+978P6kXMMZZEF40uW8bVjlUQbwtO5MKlBK4/p5hsMN9mzclcE6alLM8DQn46Gvb2SxwRx7p3/gPy/VNnNPWCmwdUSZoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qkHFXVjhUqGhGcmzBnqrNiBqCom80DD/jbaHGNuE2W4=;
 b=ynxsQ2K/f8gnJCJaIL/hCnlpYiKiokSYJCWA560G9RZlEaVygq+d9m2LZuIX0MtCmxw3pvu3gles/v4XM9wYI7d+y7ayjJcbv0rCD1p1hL59oO4NLixPTWNP/MK5ZfC0bSLzJVxb/les/9vQRcSu//O+mOJoaBie4GFKrA6veCQ=
Received: from SJ0PR13CA0120.namprd13.prod.outlook.com (2603:10b6:a03:2c5::35)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 06:09:44 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::98) by SJ0PR13CA0120.outlook.office365.com
 (2603:10b6:a03:2c5::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 06:09:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 06:09:44 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 00:09:39 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 5/5] drm/amd/display: Make DMUB auto-load failures fatal
Date: Fri, 15 Nov 2024 00:09:24 -0600
Message-ID: <20241115060924.1805-6-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115060924.1805-1-mario.limonciello@amd.com>
References: <20241115060924.1805-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 62576914-31dc-4fe5-52b0-08dd053c1a08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ssgNusTqHUwv0oPMucrgXdRBSNv5UXPe8SiJNjutB/5ugAk5ksOnTsQn0OqP?=
 =?us-ascii?Q?FKh+3stHNQm3a1h9jkP13K71F7lT7USZAcTIbBXGe7r1ihNxzz4r7Fy8MxpZ?=
 =?us-ascii?Q?wcvwFnOgBEkikmsb/GcezoNQCRUIVCa4UP/57YmWxIdtMoZ3Ck9RCmYnKKwd?=
 =?us-ascii?Q?JqZQEDzQL/LlPIPZv3I3qUO8CsLcR/mM0AKwibGm1LfdWfCHsGTa0oSN8TJZ?=
 =?us-ascii?Q?DAano0Q0cV6lNV/NaEaLfqF8Mu7h9i1NT8he8cD9zJ54LPuGjGbk+DwZYbzE?=
 =?us-ascii?Q?K25yYU7l46ZYosSIQopyg8UrGqaoCd3v9B/JH8FSD2cVy8eX70wdUHDDg+un?=
 =?us-ascii?Q?eZi6+4D/dW8m3xnrtCnWdehKXs2Svs+iNmq/Ir+iVJruIQgcMFfN9vcVaMe1?=
 =?us-ascii?Q?k/a+8FFdZkbhQpskfOupbpfv/ZRT+c5mD84HKuRcd91DMNPjLivVs7+wPqDC?=
 =?us-ascii?Q?kW6jkEA+zdf179amFSYXCZjxzJXr1yQ0cHR+HzsIibyjQbovv29Iy9iQnL1z?=
 =?us-ascii?Q?F6waAej/zFx5gygQ7sMRpC3J/KVCLLhlAAEJrBwObmTgenVMUt85594zPxM6?=
 =?us-ascii?Q?7EGRPQtEwdtQWY3yU0deAf8GXYu1JeOhccQio/7Gln+QRq2TUTMSLKBiISnM?=
 =?us-ascii?Q?cwpt65Xb9F3iHlp2VIuthg5a6XzvNpfOkPiyVpEBgEoZdcLp/ZNPLPYbO6bZ?=
 =?us-ascii?Q?EIL6wB/AG9eiENuSlPBURqJvbYa7w0xPWf83OPBgcMYLPxesrvjoKg/lbhqg?=
 =?us-ascii?Q?Bzb9/amc7H5+2HKG1KE3GlcCWJ5jtSKcAHLDfkW0m37hY8w/ZXPx5l8ut+2A?=
 =?us-ascii?Q?IWQ4bUUp6fupfui4ACMNxpd69BLOCqOjM9uGGKRg4gex3It0xpkYT5rA9DhO?=
 =?us-ascii?Q?y4Ty2itgtgo5uaX0jzWWDrRlAO3MVo5ID3/Oz1H42nhEbHPZ9a8cG/wyWiB9?=
 =?us-ascii?Q?oOOShB7PeISg+CxZKuCcM5e4bX+ajTTMkTkppTjtD2AkyKTQDxxATp07l5lV?=
 =?us-ascii?Q?N374JD3acVbG7BFP1yORNPzD/JGm9B9SCqK67UXTnHp9A3QXqBnypmSB5bzM?=
 =?us-ascii?Q?KZwkQvdS6uHPRIDv5Fz5kS+W99c6ly8U1l1OXSZdOScOSmvlcOa5SjG2lkM2?=
 =?us-ascii?Q?tN994USQlnVIeLC67ViFRteAH0kjRJHKqSctIo+emUUsqsnz7o2YriDRvQOa?=
 =?us-ascii?Q?c9LRZFZEKYMQvMHRwQv98kShrIHCCNQCnEVSrj/YZbhy+Vskl9ikBJVnfo5X?=
 =?us-ascii?Q?0YcvoT8pRXt/Dbm0xXpr1Tr5MIoDU3I6N9w4dUq7DfiVpWAm6xfCt0pFlsiM?=
 =?us-ascii?Q?lzd2pfABifjyMCQEMSa3avN/8B5kBIMr8UfyOhGMe31afltyXwONbIBWcLdn?=
 =?us-ascii?Q?Gl1zpE7h//aYSYinwv3grHNo3jvn7ct2u1RKBUJfVrZeMegkCQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:09:44.6283 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62576914-31dc-4fe5-52b0-08dd053c1a08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033
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

Realistically when these happen the driver is in a pretty bad state.
Future calls later in the driver such as dm_read_reg_func() can hang
causing soft lockups on CPUs and never letting the module load
finish.

If one of these problems happens abort the hw init or resume sequence.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 41 ++++++++++++-------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 95807d035a153..e7ebc26070d6b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1291,8 +1291,10 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 
 	/* Wait for firmware load to finish. */
 	status = dmub_srv_wait_for_auto_load(dmub_srv, 100000);
-	if (status != DMUB_STATUS_OK)
-		DRM_WARN("Wait for DMUB auto-load failed: %d\n", status);
+	if (status != DMUB_STATUS_OK) {
+		drm_err(adev->dm.ddev, "Wait for DMUB auto-load failed: %d\n", status);
+		return -EINVAL;
+	}
 
 	/* Init DMCU and ABM if available. */
 	if (dmcu && abm) {
@@ -1336,7 +1338,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-static void dm_dmub_hw_resume(struct amdgpu_device *adev)
+static int dm_dmub_hw_resume(struct amdgpu_device *adev)
 {
 	struct dmub_srv *dmub_srv = adev->dm.dmub_srv;
 	enum dmub_status status;
@@ -1345,24 +1347,30 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 
 	if (!dmub_srv) {
 		/* DMUB isn't supported on the ASIC. */
-		return;
+		return 0;
 	}
 
 	status = dmub_srv_is_hw_init(dmub_srv, &init);
 	if (status != DMUB_STATUS_OK)
-		DRM_WARN("DMUB hardware init check failed: %d\n", status);
+		drm_warn(adev->dm.ddev, "DMUB hardware init check failed: %d\n", status);
 
 	if (status == DMUB_STATUS_OK && init) {
 		/* Wait for firmware load to finish. */
 		status = dmub_srv_wait_for_auto_load(dmub_srv, 100000);
-		if (status != DMUB_STATUS_OK)
-			DRM_WARN("Wait for DMUB auto-load failed: %d\n", status);
-	} else {
-		/* Perform the full hardware initialization. */
-		r = dm_dmub_hw_init(adev);
-		if (r)
-			DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
+		if (status != DMUB_STATUS_OK) {
+			drm_err(adev->dm.ddev, "Wait for DMUB auto-load failed: %d\n", status);
+			return -EINVAL;
+		}
+
+		return 0;
 	}
+
+	/* Perform the full hardware initialization. */
+	r = dm_dmub_hw_init(adev);
+	if (r)
+		drm_err(adev->dm.ddev, "DMUB interface failed to initialize: status=%d\n", r);
+
+	return r;
 }
 
 static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_addr_space_config *pa_config)
@@ -3244,9 +3252,12 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 		link_enc_cfg_copy(adev->dm.dc->current_state, dc_state);
 
 		r = dm_dmub_hw_init(adev);
-		if (r)
+
+		if (r) {
 			drm_err(adev->dm.ddev,
 				"DMUB interface failed to initialize: status=%d\n", r);
+			return r;
+		}
 
 		dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D0);
 		dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D0);
@@ -3292,7 +3303,9 @@ static int dm_resume(struct amdgpu_ip_block *ip_block)
 	/* TODO: Remove dc_state->dccg, use dc->dccg directly. */
 
 	/* Before powering on DC we need to re-initialize DMUB. */
-	dm_dmub_hw_resume(adev);
+	r = dm_dmub_hw_resume(adev);
+	if (r)
+		return r;
 
 	/* Re-enable outbox interrupts for DPIA. */
 	if (dc_is_dmub_outbox_supported(adev->dm.dc)) {
-- 
2.43.0

