Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F23E0CFD65D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jan 2026 15:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F1910E62D;
	Wed,  7 Jan 2026 15:58:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SvaAcBdQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE55610E62F
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jan 2026 15:58:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMtOg5cxCYDy29CjmHrZoOXm52dRrALGys7YhBrmB0m/rhawWxZwuxSVMcaeAV0GFRz8Fyc9FelIIbXK6bQ1wPu8kzppvJhrXHvd3opEU7ba06AbtBoI7lpqQr14DKD4wiefSfFnRENCx8x7lk87Ol7AXB9UUPtejC3HwVHnUwEMQRJfmql5bKf+zUelnuniallmY+dhc2osZ0M3W1nOxBaL3AdFFb+XCGAM8PozlV43ROIR8etFBBrfwDrbbXNecD8w3SrlmzXefLqaYIzy20wuLKcgZ5QiSv2AsHYdL0cI3EGw+TsEAlWCs2gx5KJZSOW4mSaeeJQNmVtbkRwRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8GXswdvmk9DiLt5ZSbrik9c1Y4UnpGVy4UMsvhhx1ho=;
 b=rCwUfX5b3KCxzqFChrgNMfwZPb+wpKRuI4jKd7GQ0+xV6WjlgLltDoO53Ni36/w2tKcexQ1+3yIs7pPtNuoMARKw5wX3Zg6SdoLGNEpqerL54v/wvWkhbeu+zUkhlm2tlN2MB0F0muvO1Ug/3epJmvl6Ef7Ixk0IrnE00RIA2LqX/4/8RhX51jbyB5b93XQn5ATdI4kk4F1zGmLp7IQNqW8Sjf56Zy0Jk/Fw7wQG+Wg4DyENwseAQH5Gp5wqZS7tP8qkitYGzz7aP6bTOs2fFJywI9C5Oi1bgdm4jWypNFnWvY/f1++I1dtMzHPyMt4a87Et/WndPHPCz9wfmkqnSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8GXswdvmk9DiLt5ZSbrik9c1Y4UnpGVy4UMsvhhx1ho=;
 b=SvaAcBdQgijAk7m4/J4c4G4cHQWVm9Z33XAqHpicztEh3YyA20JzIM1FW3ZzWMSeqLV6HVj3YByXmdLewCfwjBcC6t7P2btADVHafCN0WqfLotj8ipBqNBdOzJXJFZeqbWCqHJbsXVIuVJY4Ooxj6/1vsnKKZy5DW3IQY1TgbN4=
Received: from BL1PR13CA0118.namprd13.prod.outlook.com (2603:10b6:208:2b9::33)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 15:58:15 +0000
Received: from BL6PEPF0002256F.namprd02.prod.outlook.com
 (2603:10b6:208:2b9:cafe::23) by BL1PR13CA0118.outlook.office365.com
 (2603:10b6:208:2b9::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Wed, 7
 Jan 2026 15:58:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0002256F.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Wed, 7 Jan 2026 15:58:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 09:58:10 -0600
Received: from mkmmattstew-dt.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 7 Jan 2026 09:58:09 -0600
From: Matthew Stewart <Matthew.Stewart2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Matthew Stewart <matthew.stewart2@amd.com>
Subject: [PATCH 18/21] drm/amd/display: switch to drm_dbg_kms() from
 DRM_DEBUG_KMS
Date: Wed, 7 Jan 2026 10:48:10 -0500
Message-ID: <20260107155421.1999951-19-Matthew.Stewart2@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
References: <20260107155421.1999951-1-Matthew.Stewart2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256F:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c028795-e38f-4a78-4e7f-08de4e059115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ic0SQ+6lLanxXcqwpWDf0ahSbegAtY5MQI48MtGE/2Hzll96mI7F6Mu3rrzw?=
 =?us-ascii?Q?jcvu4eWDbzqBIIWD9Tk0w3dSogYf50l/qbei2cZWZyx9GDyMc1aTX5vmBnfZ?=
 =?us-ascii?Q?SKZ5z9ZWG1tJWg8jg/FR9xP1gLxSIbIGeUY5e4djdODpQBbH41xq76J6kttJ?=
 =?us-ascii?Q?8dQrsk5EjbYsI4cQueSGMdppXeBFd9iaRANSRent0l2b4wTNl60WFMqHaCAg?=
 =?us-ascii?Q?3F5Yvq7gRyXi7R4DSu5h3gqn2ThBp6dgBLdV7OOvF/Su83ZRLHOFLfL8xImx?=
 =?us-ascii?Q?sj+LBQQ5FYo+6HG4PDmhC4MI7Pwa9Qwy8J54dhOt3Cn7MPNs5UoIkhoWmYSt?=
 =?us-ascii?Q?tSNNTnfiP/tt5SEsO9ciKEe4Oqmnt0jvVKuDfF8Nu1Fmx5sYr6IisjdIoX/6?=
 =?us-ascii?Q?0dZhWSA4Vi6n8k8O5mzV+eDcsQjGx1rmgLjTR9RHt+ir+otIY+tdnoF5xXDP?=
 =?us-ascii?Q?0jnXRtUcyrqC2306RqVJxE3ZHevM4RQ6gqEvcogedWBzp1jWm2VEbQ4OdNKg?=
 =?us-ascii?Q?ERlwk1x5HHMmztCVvBiytboreWl/HDuSs9hnRtnOJINBZzindO6dZygKYxnC?=
 =?us-ascii?Q?rbbdU6QxIBGhUSCQ3uNWpXzAmblRc2Oy/qj4N3OehQlSppcDCPNfUZ94i95U?=
 =?us-ascii?Q?Hy1w8PDrE1cccYcTlzWfRGTF93K8vFJwma3CIZ29OfnaSKDdy2BlfuIZ7l2F?=
 =?us-ascii?Q?IQ0dCQJ7qywrfjqr04GMmSjKdJJCCcihbJnu7Kx8FkoOE5tI/0wkuNXniN4J?=
 =?us-ascii?Q?WjoTJaCmAPdCZm5xzT0J8Eto//xMCWxEGHC5iuDs8QP9UE9w4GWE3fnrDzYl?=
 =?us-ascii?Q?ZGL0Zdt56/RCEPgNzhliCthD07JFvUwbrD5aAViCr60v2u0CpdLknSozbQAP?=
 =?us-ascii?Q?TI/Ux5BylZgnx/+Kt3X7aNnZ0icxOlTIt+5C8hZ8RcmAp1x7mtSCYCdGF6mw?=
 =?us-ascii?Q?UUoVATnYOXk1QUUznFoOjOS6GnsqdWhST6/Fhe4g8PWchvZEGjvtrW0hFZYK?=
 =?us-ascii?Q?87j1ge5gkSKjzpv7dbZRIzMDmc376A+N77rUA4RFb29ad+ZqT9dxTL2wf7GX?=
 =?us-ascii?Q?Nze42LDoNSUyus+x6aTvKbURMMh0vvRCqOmhcKDi2qStJyPCwENneZsS/TLj?=
 =?us-ascii?Q?taYpuGtWBlrIJz85dmX/gRb7afS8/SyFkpPDzsW+KXmxUkN5QVyoePPjGQKi?=
 =?us-ascii?Q?pgSLUmcTzSmAa7ip9lQ8O0seo5/sdldw4kCkDcshmrQ7W5KBDnz/iU6h398e?=
 =?us-ascii?Q?+sHI1zSzsXxG4ZxbulP3VLN5VRa9Bjc5Hgv/lX5xUGevU5mQg414BIy4tsMK?=
 =?us-ascii?Q?u6qI3X1mFDHwklg5NnURAlOavaw63cagNBNniC82dK1zPEfoIscubhcJovw6?=
 =?us-ascii?Q?2kZV+hDCw1Wbd7uDef3z7OnfrAnwa+yzZdl27luaiO2H4JJB5ZHmM2jo21Sa?=
 =?us-ascii?Q?4f3PiLlebAbe5d80VjoEi2mNQ9JKZhgQOoVZzoOc7eOjam+TpPMJ3R4AVahA?=
 =?us-ascii?Q?qHxLOqvgQugiMWCh977rAPpdrcx0v8sx4zn3lt5dt05cYx3R3kSMF1dotUmH?=
 =?us-ascii?Q?s5+7SaH0OcgmsYXlWCQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 15:58:14.8653 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c028795-e38f-4a78-4e7f-08de4e059115
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0002256F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445
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

DRM_DEBUG_ class of macros are depricated. Recommended drm_dbg_kms() has
the advantage of being able to distinguish the logs from devices in a
multi-gpu environment.

Where a pointer to struct amdgpu_device is available, use that to get
the drm device.

Reviewed-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Matthew Stewart <matthew.stewart2@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 2963c75ca18a..ecdf4e44bae5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1137,7 +1137,7 @@ static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
 
 	mutex_unlock(&adev->dm.audio_lock);
 
-	DRM_DEBUG_KMS("Get ELD : idx=%d ret=%d en=%d\n", port, ret, *enabled);
+	drm_dbg_kms(adev_to_drm(adev), "Get ELD : idx=%d ret=%d en=%d\n", port, ret, *enabled);
 
 	return ret;
 }
@@ -1231,7 +1231,7 @@ static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 	struct drm_audio_component *acomp = adev->dm.audio_component;
 
 	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify) {
-		DRM_DEBUG_KMS("Notify ELD: %d\n", pin);
+		drm_dbg_kms(adev_to_drm(adev), "Notify ELD: %d\n", pin);
 
 		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
 						 pin, -1);
@@ -2377,7 +2377,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 	}
 
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-		DRM_DEBUG_KMS("dm: DMCU firmware not supported on direct or SMU loading\n");
+		drm_dbg_kms(adev_to_drm(adev), "dm: DMCU firmware not supported on direct or SMU loading\n");
 		return 0;
 	}
 
@@ -2385,7 +2385,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 				 "%s", fw_name_dmcu);
 	if (r == -ENODEV) {
 		/* DMCU firmware is not necessary, so don't raise a fuss if it's missing */
-		DRM_DEBUG_KMS("dm: DMCU firmware not found\n");
+		drm_dbg_kms(adev_to_drm(adev), "dm: DMCU firmware not found\n");
 		adev->dm.fw_dmcu = NULL;
 		return 0;
 	}
@@ -2409,7 +2409,7 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 
 	adev->dm.dmcu_fw_version = le32_to_cpu(hdr->header.ucode_version);
 
-	DRM_DEBUG_KMS("PSP loading DMCU firmware\n");
+	drm_dbg_kms(adev_to_drm(adev), "PSP loading DMCU firmware\n");
 
 	return 0;
 }
@@ -4140,7 +4140,7 @@ static void schedule_hpd_rx_offload_work(struct amdgpu_device *adev, struct hpd_
 	offload_work->adev = adev;
 
 	queue_work(offload_wq->wq, &offload_work->work);
-	DRM_DEBUG_KMS("queue work to handle hpd_rx offload work");
+	drm_dbg_kms(adev_to_drm(adev), "queue work to handle hpd_rx offload work");
 }
 
 static void handle_hpd_rx_irq(void *param)
@@ -4969,7 +4969,7 @@ static void amdgpu_dm_update_backlight_caps(struct amdgpu_display_manager *dm,
 		    caps->min_input_signal < 0 ||
 		    spread > AMDGPU_DM_DEFAULT_MAX_BACKLIGHT ||
 		    spread < AMDGPU_DM_MIN_SPREAD) {
-			DRM_DEBUG_KMS("DM: Invalid backlight caps: min=%d, max=%d\n",
+			drm_dbg_kms(adev_to_drm(dm->adev), "DM: Invalid backlight caps: min=%d, max=%d\n",
 				      caps->min_input_signal, caps->max_input_signal);
 			caps->caps_valid = false;
 		}
@@ -5494,7 +5494,7 @@ static int amdgpu_dm_initialize_drm_device(struct amdgpu_device *adev)
 		}
 		break;
 	default:
-		DRM_DEBUG_KMS("Unsupported DCN IP version for outbox: 0x%X\n",
+		drm_dbg_kms(adev_to_drm(adev), "Unsupported DCN IP version for outbox: 0x%X\n",
 			      amdgpu_ip_version(adev, DCE_HWIP, 0));
 	}
 
@@ -9603,7 +9603,7 @@ static void update_freesync_state_on_stream(
 	new_stream->allow_freesync = mod_freesync_get_freesync_enabled(&vrr_params);
 
 	if (new_crtc_state->freesync_vrr_info_changed)
-		DRM_DEBUG_KMS("VRR packet update: crtc=%u enabled=%d state=%d",
+		drm_dbg_kms(adev_to_drm(adev), "VRR packet update: crtc=%u enabled=%d state=%d",
 			      new_crtc_state->base.crtc->base.id,
 			      (int)new_crtc_state->base.vrr_enabled,
 			      (int)vrr_params.state);
@@ -11549,7 +11549,7 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 			dc_stream_retain(new_stream);
 
-			DRM_DEBUG_ATOMIC("Enabling DRM crtc: %d\n",
+			drm_dbg_atomic(adev_to_drm(adev), "Enabling DRM crtc: %d\n",
 					 crtc->base.id);
 
 			if (dc_state_add_stream(
@@ -11779,14 +11779,14 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 
 	if (fb->width > new_acrtc->max_cursor_width ||
 	    fb->height > new_acrtc->max_cursor_height) {
-		DRM_DEBUG_ATOMIC("Bad cursor FB size %dx%d\n",
+		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB size %dx%d\n",
 				 new_plane_state->fb->width,
 				 new_plane_state->fb->height);
 		return -EINVAL;
 	}
 	if (new_plane_state->src_w != fb->width << 16 ||
 	    new_plane_state->src_h != fb->height << 16) {
-		DRM_DEBUG_ATOMIC("Cropping not supported for cursor plane\n");
+		drm_dbg_atomic(adev_to_drm(adev), "Cropping not supported for cursor plane\n");
 		return -EINVAL;
 	}
 
@@ -11794,7 +11794,7 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 	pitch = fb->pitches[0] / fb->format->cpp[0];
 
 	if (fb->width != pitch) {
-		DRM_DEBUG_ATOMIC("Cursor FB width %d doesn't match pitch %d",
+		drm_dbg_atomic(adev_to_drm(adev), "Cursor FB width %d doesn't match pitch %d",
 				 fb->width, pitch);
 		return -EINVAL;
 	}
@@ -11806,7 +11806,7 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 		/* FB pitch is supported by cursor plane */
 		break;
 	default:
-		DRM_DEBUG_ATOMIC("Bad cursor FB pitch %d px\n", pitch);
+		drm_dbg_atomic(adev_to_drm(adev), "Bad cursor FB pitch %d px\n", pitch);
 		return -EINVAL;
 	}
 
@@ -11824,7 +11824,7 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
 				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
 		}
 		if (!linear) {
-			DRM_DEBUG_ATOMIC("Cursor FB not linear");
+			drm_dbg_atomic(adev_to_drm(adev), "Cursor FB not linear");
 			return -EINVAL;
 		}
 	}
-- 
2.52.0

