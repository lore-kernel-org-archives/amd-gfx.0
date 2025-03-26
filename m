Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13916C36014
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0C210E778;
	Wed, 26 Mar 2025 19:53:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="biPcB8sW";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3307110E1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Speape3cKKM5aXC6jk66yXmwAbzMVaMzlEfCkRlnlU0vTqTh5PHS49/eAdnOSsBeRicmbphJMu2KeJpZSgHnpzbH0UpHNgPwoSdcPKrhnw4cbsKRwpYuuRlfLs31xj7+Q8UvvUF98f+B71X6Ysu0KvuGcEBk1RBAGXjk1/7D2zG3L6/lPr/6P9nRd+fEP2cp/oRmgNjxk+Ka9PE3QvhRS4Mqo/qYL5hw5CENf2y/v0c/o4pzXqOgxJVD8dkGALuT8lQu1MVgwfVmkkB082rvDM6LGnID5th0AVTT+OG/y3naY/wzwYLP4r6H678DxCb4FrRq9HR1mXkf8iBSxng1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DwDgL6bFLJOouRSdR05HN6J7XbWR/oqlo0AUz4AqlI=;
 b=PDgnJCF14/4IvczR79TV2mS1Xeew//fxUt+SBFfyso6EHA8eq+WtFRm3mE7X4HCU90YKqe+lmASGaNdw2G4A4naqcduPhKl2MG1yrA49eLZCbdt6jOXKuHKb1kPLmE737ckznp9H2yY+N9b1LxxuWAnjRqw4ssPDPKzJRo2XKu3ThWNd7l493+Cl+ozl9URjGsTqi/Xoo3NFe1YetBnSdRonQ7DRnavVITSDlhAWLSACd/0QNZcH+bik4Prn1oeUDYdOTORe9I/Fpc+FUnwwmVihjwJB3vJGJ8c1O6kXC2pVpL7JkeGcFdBESEgqy+JsY579tfFL6euOcrjbpGrbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DwDgL6bFLJOouRSdR05HN6J7XbWR/oqlo0AUz4AqlI=;
 b=biPcB8sW6jFrrLa2/kb1rzia8/ZvAn9yx6xbIC3ukibU1UiBYXpinYQdeo6nGlrY+rzCwl8+bijMpT7n2Mb2PeSKZ5KIEGmiPQZ/Ez/9yiJFm5eT3Lj1wOvDPcLtSx3Rq8cI8BDz1sr0on/lmL9rgfBrW1TqUrdsky9LYotffcs=
Received: from SJ0PR13CA0153.namprd13.prod.outlook.com (2603:10b6:a03:2c7::8)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:16 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::a5) by SJ0PR13CA0153.outlook.office365.com
 (2603:10b6:a03:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.26 via Frontend Transport; Wed,
 26 Mar 2025 19:53:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:15 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:12 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:12 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 09/17] drm/amd/display: use drm_info instead of DRM_INFO
Date: Wed, 26 Mar 2025 15:49:06 -0400
Message-ID: <20250326195202.17343-10-Jerry.Zuo@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 87929a28-ba7f-472f-45ae-08dd6c9fd934
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XmKJRRlxZc2b31aFxx/GIEpxzCe6BlYBneRfP8KXjkloe/uD7u5jE2g7WU3i?=
 =?us-ascii?Q?MA5MRXZbKGZtEvnGM711K26f0uUoK1e4GqW93+OPHCdjP2+hnTvRp+tjlRHW?=
 =?us-ascii?Q?sO4c5ZohNLEPANwaOkKd5O2f2AigzBV7qTeS57/Q3wdJPa4qg9gRb2/qcRku?=
 =?us-ascii?Q?Z/kPK5oaKiiILNybTwhiVf7eCLgPyrZLOhv2w4amI+50rpuejUAQLw/4non1?=
 =?us-ascii?Q?1dgM56vy50TqhkyMnccVzu1N1f4ziMjNKP1xw2/JdJIrLsWhQI5oSBjZrhs3?=
 =?us-ascii?Q?gu1wq7+fszeSBGkBIx99MHA+yXUGdJkQ7geOZR2zfKN8nk19l8E7eKHELJ1N?=
 =?us-ascii?Q?vzPo/93hvw1r+9i2QAKW5IEkK0tg9z82fOJR1n/AuDuzCkryCOCQ4Nf7kCQ2?=
 =?us-ascii?Q?zddZE/ARg1GA4imNqE49mlRn7Hz9PsQ2h+6npH2OLcRs5CINz4Hzu3zpWUnt?=
 =?us-ascii?Q?c+kVgMP4gK3ByR5toYuHOIhrQj4BSGYsrap2Mb3RJoQfI5UltnMaCZBeVxnM?=
 =?us-ascii?Q?mKr1joPDIOTKVoKrA5/1IFWWj7R+aLHBXtD0EjAykMvajvNiFCHdBurz3OLa?=
 =?us-ascii?Q?pjce+70Vkk8TRVrxvF1TtNLro3ywQPApbiuwUJ+y9IxU6qeBoKhG8CceFYvp?=
 =?us-ascii?Q?C2o+8iHeuyvX0A4vcejUuZJag7YTNfMR1ugZnJRNXp+YcPeGGITiRn3026A5?=
 =?us-ascii?Q?ULPmltguKRfFP7KuyxVZvfZkXuDZ/6JhlH4bs1vDQolsWkBI+jEu/SH7urYR?=
 =?us-ascii?Q?DTG8Qby+UZFKnohXZhwJvNpUKI1aLvEjO3B7k6XrOKd3zOv9p40dr6v30AQc?=
 =?us-ascii?Q?uePSt+xdRdC3nXV009A9oxtWfJFinaIulZ4M656F4/gteo0qbVb4G0wcMq2v?=
 =?us-ascii?Q?615RdgUvi5lEpukVBx3Jj5fczF51Sa/g9W0JU+O9RlbI4ArR0k8AI4oeRtLP?=
 =?us-ascii?Q?bL3ErIISF6FuLol2QJTc+WEHEuFVj/px0gbMCnXyZzeBtFHXlcRmS3eRfueb?=
 =?us-ascii?Q?vbO4xpw+Pcg0E1lZMlzea30EEubKFWxOFQR7Vel01yYh4azNYrOtVE1JJCbW?=
 =?us-ascii?Q?jhccBmcC+wxhY8CppZwBN1YcFaHqf4sDBHB3eYVzYjOfK23Xh8sHb0oyTskq?=
 =?us-ascii?Q?H3E65BJSFkAsGv2v9XCUA+yV1V9ImJSNumDzJI87YC7F5QS6l5ZH3YGSoH1O?=
 =?us-ascii?Q?0WfJfKA2vmRH7BIPxkqkzHXsdJjfr7rvlIgFRM5a6cLpimiOcwxIshWJEXou?=
 =?us-ascii?Q?tP+MNceOAbf+bxnwNlEL2DPoEfmYVCIZwV9etSay7MOwkjA36quzm+UMil9V?=
 =?us-ascii?Q?pGAy3K1T8Vq0bZHoJk9ks1AFN0vHasC5Hmu3T2HjNlCVL4EfsfCH7Jcaa+gg?=
 =?us-ascii?Q?jPzFg749BrRCw3TTWAcGLXcrpIJA3Ie4cp1bHI97fQ0r9sze+RkrJqlK399h?=
 =?us-ascii?Q?xlwp1kMpz7idS7peGI4IQlq0qlWCUfBORVXW5vB7DgeInpRqEdRL/PxRwNGF?=
 =?us-ascii?Q?z46VV65DSRdLpSI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:15.5534 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87929a28-ba7f-472f-45ae-08dd6c9fd934
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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

drm_info prints the drm device instance which is helpful when
debugging multi gpu issues

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0f65766261cd..eb24d8c6e210 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -782,7 +782,7 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 
 	/* Skip DMUB HPD IRQ in suspend/resume. We will probe them later. */
 	if (notify->type == DMUB_NOTIFICATION_HPD && adev->in_suspend) {
-		DRM_INFO("Skip DMUB HPD IRQ callback in suspend/resume\n");
+		drm_info(adev_to_drm(adev), "Skip DMUB HPD IRQ callback in suspend/resume\n");
 		return;
 	}
 
@@ -799,9 +799,9 @@ static void dmub_hpd_callback(struct amdgpu_device *adev,
 		aconnector = to_amdgpu_dm_connector(connector);
 		if (link && aconnector->dc_link == link) {
 			if (notify->type == DMUB_NOTIFICATION_HPD)
-				DRM_INFO("DMUB HPD IRQ callback: link_index=%u\n", link_index);
+				drm_info(adev_to_drm(adev), "DMUB HPD IRQ callback: link_index=%u\n", link_index);
 			else if (notify->type == DMUB_NOTIFICATION_HPD_IRQ)
-				DRM_INFO("DMUB HPD RX IRQ callback: link_index=%u\n", link_index);
+				drm_info(adev_to_drm(adev), "DMUB HPD RX IRQ callback: link_index=%u\n", link_index);
 			else
 				DRM_WARN("DMUB Unknown HPD callback type %d, link_index=%u\n",
 						notify->type, link_index);
@@ -1013,7 +1013,7 @@ static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 			drm_err(adev_to_drm(adev), "DM: Failed to initialize FBC\n");
 		else {
 			adev->dm.dc->ctx->fbc_gpu_addr = compressor->gpu_addr;
-			DRM_INFO("DM: FBC alloc %lu\n", max_size*4);
+			drm_info(adev_to_drm(adev), "DM: FBC alloc %lu\n", max_size*4);
 		}
 
 	}
@@ -1197,7 +1197,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	}
 
 	if (!has_hw_support) {
-		DRM_INFO("DMUB unsupported on ASIC\n");
+		drm_info(adev_to_drm(adev), "DMUB unsupported on ASIC\n");
 		return 0;
 	}
 
@@ -1316,7 +1316,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		return -ENOMEM;
 	}
 
-	DRM_INFO("DMUB hardware initialized: version=0x%08X\n",
+	drm_info(adev_to_drm(adev), "DMUB hardware initialized: version=0x%08X\n",
 		 adev->dm.dmcub_fw_version);
 
 	/* Keeping sanity checks off if
@@ -2070,10 +2070,10 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev->dm.dc = dc_create(&init_data);
 
 	if (adev->dm.dc) {
-		DRM_INFO("Display Core v%s initialized on %s\n", DC_VER,
+		drm_info(adev_to_drm(adev), "Display Core v%s initialized on %s\n", DC_VER,
 			 dce_version_to_string(adev->dm.dc->ctx->dce_version));
 	} else {
-		DRM_INFO("Display Core failed to initialize with v%s!\n", DC_VER);
+		drm_info(adev_to_drm(adev), "Display Core failed to initialize with v%s!\n", DC_VER);
 		goto error;
 	}
 
@@ -2113,7 +2113,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 	adev->dm.dc->debug.ignore_cable_id = true;
 
 	if (adev->dm.dc->caps.dp_hdmi21_pcon_support)
-		DRM_INFO("DP-HDMI FRL PCON supported\n");
+		drm_info(adev_to_drm(adev), "DP-HDMI FRL PCON supported\n");
 
 	r = dm_dmub_hw_init(adev);
 	if (r) {
@@ -2173,7 +2173,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		init_completion(&adev->dm.dmub_aux_transfer_done);
 		adev->dm.dmub_notify = kzalloc(sizeof(struct dmub_notification), GFP_KERNEL);
 		if (!adev->dm.dmub_notify) {
-			DRM_INFO("amdgpu: fail to allocate adev->dm.dmub_notify");
+			drm_info(adev_to_drm(adev), "amdgpu: fail to allocate adev->dm.dmub_notify");
 			goto error;
 		}
 
@@ -2549,7 +2549,7 @@ static int dm_dmub_sw_init(struct amdgpu_device *adev)
 		adev->firmware.fw_size +=
 			ALIGN(le32_to_cpu(hdr->inst_const_bytes), PAGE_SIZE);
 
-		DRM_INFO("Loading DMUB firmware via PSP: version=0x%08X\n",
+		drm_info(adev_to_drm(adev), "Loading DMUB firmware via PSP: version=0x%08X\n",
 			 adev->dm.dmcub_fw_version);
 	}
 
@@ -10202,7 +10202,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 				new_con_state->content_protection >= DRM_MODE_CONTENT_PROTECTION_DESIRED)
 				enable_encryption = true;
 
-			DRM_INFO("[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
+			drm_info(adev_to_drm(adev), "[HDCP_DM] hdcp_update_display enable_encryption = %x\n", enable_encryption);
 
 			if (aconnector->dc_link)
 				hdcp_update_display(
-- 
2.43.0

