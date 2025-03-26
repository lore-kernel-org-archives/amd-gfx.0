Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89287C3601B
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA59310E783;
	Wed, 26 Mar 2025 19:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3LtILWyB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CE3F10E1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1sFmp4cOilCMWOrQcCdJv6r8ReKQ4ynuM/AgO8CjXUwDFAW36NXxlcJrGN9JEnsx1QLt4JyvFHUIxjWNzyU/2KmXX4aiIqY+ABKij/WOY1KIN9URuMjAenYa/V6rvi4+Whrl6Mc/9Ub6sHCMGmoyBeGi2PNMLMdHKHn4UOKiFe8/RW3Fwnjfbne8f3OAXYMwstGARUalFgm4mLbsTOIeKdhuWx/GBq+4jl5S7cGAX5k/wl/PF6nlXuMwDvyLLnW/DqIAnJl5gc3nrbemt+LNU4BqEho0zoqY5F2nNC0xf4GAebtEKwI3oG8LTpyKKUAnKtlHbbz4mbDD/JJ6azwnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2mUTYjU171clcPKKiTqVUuq9MS55VTx8KVDQUM2iMQ=;
 b=UdjBJKetSNgic9YvAgEjClMzvvf22Fd37DQ6BWyP4FovQzykKA4uqBQaH3zmdpFz/LRaFgO6rmqaYjegN+4psfN1RtYHMB8KQ2LNl3jo/oXO9GFXJ1xCehS78QyjY4G5zD+17zMCm7cb1F7BE7hLWDHj5OTtJmXeYTnxW1T1WvZaIYaDl7rD32lZwlIKerIo7TZVyKlWh28ZQgKQ6Ok+xPUN+9edKHgaQvl/bS+M+ngClUu3YvE21V42QiS/0fGcqbBy56/Kdil+gSGQyR6SlNM0L2ML68PnP6vDNIyRlHqyfLPh8k3VFuO99jWA7SKEhzjO4MLfDT8rnOgwWIm1QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2mUTYjU171clcPKKiTqVUuq9MS55VTx8KVDQUM2iMQ=;
 b=3LtILWyBFtOmzv+Nt2UfUbCOAklJVaMFVowA2Afxk29LAvm7Dzt+PFBZVXSSNlhKP0pkF39yVtNWRdWT2lQID/+Xr/KXiKO8JdWdhdBU6ZnzxUIbajlsp+yTe3FIfpIIsrMY29Wb8evjRTfqv4xuzwr4R2za2Eioi5Cgkk6tLnc=
Received: from MW4PR04CA0249.namprd04.prod.outlook.com (2603:10b6:303:88::14)
 by DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:15 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::3d) by MW4PR04CA0249.outlook.office365.com
 (2603:10b6:303:88::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.43 via Frontend Transport; Wed,
 26 Mar 2025 19:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:13 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:13 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 10/17] drm/amd/display: use drm_warn instead of DRM_WARN
Date: Wed, 26 Mar 2025 15:49:07 -0400
Message-ID: <20250326195202.17343-11-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM6PR12MB4250:EE_
X-MS-Office365-Filtering-Correlation-Id: 41033e2f-969a-489f-8af9-08dd6c9fd8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?67uNRJu5u7gMFxU5KPCLMGnVKaL5gnri++7C6wWO/JwYchE5Wr0MNElVc3Xi?=
 =?us-ascii?Q?JmJNnwMEyuZJLM5PYIRZs+jOdp/epn/q+5SWrTn61dB4GjSPxuhDg/ATgNyu?=
 =?us-ascii?Q?uTzsRjfDRZ6kgj9KU4Vfhn+YA4uHoQpnplkvmv7dLewzzTLRmcYEoerbZl2e?=
 =?us-ascii?Q?wVP+fJYiLTXDqplMKd2mOpDsY8Dr3JcxyJraXDb1gmWTQfzhYtYdGfaLYaXd?=
 =?us-ascii?Q?bdzWgLjn0abMkjq1gH3sV7qg176PjlpjM8lSxLzr+1gzKTD1Q4U4U0jOx4u+?=
 =?us-ascii?Q?XLifdzIYGEf+SKVtemdFWN/fZ7Rw6iePZUmUYSxvfkQLDk55fgQv+VjRb33z?=
 =?us-ascii?Q?4u0Nm6RI+4AnQmm381RIClB7af6tN18psfe1pBw/vXgIiHRQ4p4CKzpBTd3i?=
 =?us-ascii?Q?KM8A89MgjCDEMkCTsDnWdo30y8qqSI/EejjwQEakDs8R5R/M0/tzd6GE2oLZ?=
 =?us-ascii?Q?4VJoFmI/cXL9V07e4Yuo0W1Jjc/jsF0gb68ukGH2MGdimbCmRnfUcPURElR5?=
 =?us-ascii?Q?CMv1hChXTF1mjBWKN4ycwYGqvm1NMPU2L9UZKj5CA5JIxz36KFiSzlAIy1+o?=
 =?us-ascii?Q?X5q6LJiUV2xY0fUoekNNMCYnuKmXUtpolCg+fzbDK9a/CoIQy4KSEIiHJQYS?=
 =?us-ascii?Q?WgBXfOeLHLKOy7mjI0kEdt4RkuZfnafWbSNSPCKuYP+HTpocM+fFwy9fHr1C?=
 =?us-ascii?Q?dlx17nci3Zy03iikYTJEsJjSIXa+AYT/OH3W08foi+6CVxclLudXM72D+BIE?=
 =?us-ascii?Q?okNN/VmAYir8KeDAj74LHNHYl8gSdkZZO7FTpr4ZwdtTl4Hd/5TWNtLahaqd?=
 =?us-ascii?Q?v3AD4cLbfkHkupUnZFA+h5bJS+dYFl7rQJUiEUr5WJbbgYcwI9W7CbyBTA45?=
 =?us-ascii?Q?0D95+YsdsyX82AqRbYDJDdL3zFNG/BpT3IvgHIe5jhIjjF1A5kQ2jHAln6ay?=
 =?us-ascii?Q?WHH0YyO0Z0fjzb/L65vG0JzlzmXw6DrcS9e3+FpQ7a0q4R+p+EihfInvVmvI?=
 =?us-ascii?Q?f5jiAL4N0fTEP1pyxGaiAoOh0swGrIrTZr/V95ygcTeBd2fTA9IAh0nFPirr?=
 =?us-ascii?Q?Chq49fZk7tguLjqcyOVxKo7k7z0Ru3+IU4E4kwXoFdR//jglKND95KrFtntg?=
 =?us-ascii?Q?6OTOTMUZTt2+0klFlPO83kJ6prcSp5S6uRTtdWIjW01MKW9L4YqAtiGTFDfc?=
 =?us-ascii?Q?sJb8BhN+PRBy7agGjUjPm0n+Hu68Z5C71Sby0fUZEUMXGZP6gPahC/1am5iq?=
 =?us-ascii?Q?a+SAySpcbKqDhSAgUBY4oOPvZODbfudKlJSA84MwVGwbx8ZhlffYByE+N8qa?=
 =?us-ascii?Q?ZZU7QYb7/MuPHbOPfaxcnGG5VUW6IRAOHKmNrorQfgETGM9KSgLiAwNrQfck?=
 =?us-ascii?Q?VSmVmkj9U1lBpsVnqD67Xktfu93NfaiFIaa9LlvOkkxGjtePdwslDxSL2QZE?=
 =?us-ascii?Q?AWEAaV04ex7ZF/08M/1snVP+hCbvoWFhjEpSMfxKnbDRNOr3tx9zGmZMm1bN?=
 =?us-ascii?Q?kUowOaJ1jVLvWcg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:14.9921 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41033e2f-969a-489f-8af9-08dd6c9fd8ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4250
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

drm_warn prints the drm device instance which is helpful when
debugging multi gpu issues

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 26 +++++++++----------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index eb24d8c6e210..867999cf49e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -803,7 +803,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 			else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
 				drm_info(adev_to_drm(adev), "DMUB HPD RX IRQ callback: link_index=%u\n", link_index);
 			else
-				DRM_WARN("DMUB Unknown HPD callback type %d, link_index=%u\n",
+				drm_warn(adev_to_drm(adev), "DMUB Unknown HPD callback type %d, link_index=%u\n",
 						notify->type, link_index);
 
 			hpd_aconnector = aconnector;
@@ -815,7 +815,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 	if (hpd_aconnector) {
 		if (notify->type == DMUB_NOTIFICATION_HPD) {
 			if (hpd_aconnector->dc_link->hpd_status == (notify->hpd_status == DP_HPD_PLUG))
-				DRM_WARN("DMUB reported hpd status unchanged. link_index=%u\n", link_index);
+				drm_warn(adev_to_drm(adev), "DMUB reported hpd status unchanged. link_index=%u\n", link_index);
 			handle_hpd_irq_helper(hpd_aconnector);
 		} else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ) {
 			handle_hpd_rx_irq(hpd_aconnector);
@@ -938,7 +938,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 				continue;
 			}
 			if (!dm->dmub_callback[notify.type]) {
-				DRM_WARN("DMUB notification skipped due to no handler: type=%s\n",
+				drm_warn(adev_to_drm(adev), "DMUB notification skipped due to no handler: type=%s\n",
 					event_type[notify.type]);
 				continue;
 			}
@@ -1204,7 +1204,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	/* Reset DMCUB if it was previously running - before we overwrite its memory. */
 	status = dmub_srv_hw_reset(dmub_srv);
 	if (status != DMUB_STATUS_OK)
-		DRM_WARN("Error resetting DMUB HW: %d\n", status);
+		drm_warn(adev_to_drm(adev), "Error resetting DMUB HW: %d\n", status);
 
 	hdr = (const struct dmcub_firmware_header_v1_0 *)dmub_fw->data;
 
@@ -1301,7 +1301,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	/* Wait for firmware load to finish. */
 	status = dmub_srv_wait_for_auto_load(dmub_srv, 100000);
 	if (status != DMUB_STATUS_OK)
-		DRM_WARN("Wait for DMUB auto-load failed: %d\n", status);
+		drm_warn(adev_to_drm(adev), "Wait for DMUB auto-load failed: %d\n", status);
 
 	/* Init DMCU and ABM if available. */
 	if (dmcu && abm) {
@@ -1359,13 +1359,13 @@ static void dm_dmub_hw_resume(struct amdgpu_device *adev)
 
 	status = dmub_srv_is_hw_init(dmub_srv, &init);
 	if (status != DMUB_STATUS_OK)
-		DRM_WARN("DMUB hardware init check failed: %d\n", status);
+		drm_warn(adev_to_drm(adev), "DMUB hardware init check failed: %d\n", status);
 
 	if (status == DMUB_STATUS_OK && init) {
 		/* Wait for firmware load to finish. */
 		status = dmub_srv_wait_for_auto_load(dmub_srv, 100000);
 		if (status != DMUB_STATUS_OK)
-			DRM_WARN("Wait for DMUB auto-load failed: %d\n", status);
+			drm_warn(adev_to_drm(adev), "Wait for DMUB auto-load failed: %d\n", status);
 	} else {
 		/* Perform the full hardware initialization. */
 		r = dm_dmub_hw_init(adev);
@@ -3065,7 +3065,7 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 			irq_source = IRQ_TYPE_PFLIP + acrtc->otg_inst;
 			rc = dc_interrupt_set(adev->dm.dc, irq_source, enable) ? 0 : -EBUSY;
 			if (rc)
-				DRM_WARN("Failed to %s pflip interrupts\n",
+				drm_warn(adev_to_drm(adev), "Failed to %s pflip interrupts\n",
 					 enable ? "enable" : "disable");
 
 			if (enable) {
@@ -3075,14 +3075,14 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 				rc = amdgpu_dm_crtc_set_vupdate_irq(&acrtc->base, false);
 
 			if (rc)
-				DRM_WARN("Failed to %sable vupdate interrupt\n", enable ? "en" : "dis");
+				drm_warn(adev_to_drm(adev), "Failed to %sable vupdate interrupt\n", enable ? "en" : "dis");
 
 			irq_source = IRQ_TYPE_VBLANK + acrtc->otg_inst;
 			/* During gpu-reset we disable and then enable vblank irq, so
 			 * don't use amdgpu_irq_get/put() to avoid refcount change.
 			 */
 			if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))
-				DRM_WARN("Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
+				drm_warn(adev_to_drm(adev), "Failed to %sable vblank interrupt\n", enable ? "en" : "dis");
 		}
 	}
 
@@ -12318,7 +12318,7 @@ static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		vsdb->min_refresh_rate_hz = output->amd_vsdb.min_frame_rate;
 		vsdb->max_refresh_rate_hz = output->amd_vsdb.max_frame_rate;
 	} else {
-		DRM_WARN("Unknown EDID CEA parser results\n");
+		drm_warn(adev_to_drm(dm->adev), "Unknown EDID CEA parser results\n");
 		return false;
 	}
 
@@ -12730,7 +12730,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 		 * lead to this error. We can ignore this for now.
 		 */
 		if (p_notify->result != AUX_RET_ERROR_PROTOCOL_ERROR) {
-			DRM_WARN("DPIA AUX failed on 0x%x(%d), error %d\n",
+			drm_warn(adev_to_drm(adev), "DPIA AUX failed on 0x%x(%d), error %d\n",
 					payload->address, payload->length,
 					p_notify->result);
 		}
@@ -12744,7 +12744,7 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(
 			(payload->reply[0] == AUX_TRANSACTION_REPLY_AUX_ACK)) {
 
 		if (payload->length != p_notify->aux_reply.length) {
-			DRM_WARN("invalid read length %d from DPIA AUX 0x%x(%d)!\n",
+			drm_warn(adev_to_drm(adev), "invalid read length %d from DPIA AUX 0x%x(%d)!\n",
 				p_notify->aux_reply.length,
 					payload->address, payload->length);
 			*operation_result = AUX_RET_ERROR_INVALID_REPLY;
-- 
2.43.0

