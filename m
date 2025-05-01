Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE10C3ABA3
	for <amd-gfx@archiver.kernel.org>; Thu,  1 May 2025 18:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE27410E282;
	Thu,  1 May 2025 18:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RZapQ+3d";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2088.outbound.protection.outlook.com [40.107.223.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B658610E282
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 May 2025 18:04:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EAxX+UymtHmvatYrznJ5CC0/mKbp4B0fLqxxvbLuCCEHxfqWWjMl9JC+FGq1jM4tXyOAp7oMC+uMkZCdmugakIf1uAoSjgp+H8L/ITOfDND1S5QuXQ9XD7w+/dmsbE3onCIX3kKQNnldxeUwEwV+oObL5GHKIhW0wUQkdX0Y1m63xJDBN7b9zwuJkZ90tYNv/gvtmMCxmVMSxRPWM8HaRMawHhF9g5KAZmJEaKsffyRrOhjp3F4QPWxNKwKreZW0ujCM65moJE1DhrotuUI9kpdDfi+5w7rHd3O5zze3DVZASWQbQlN+UTgawa/mdimSFYPZJdrYHQfyVGEG4I5X5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oWcfVsITUyPRZXfJ6ZL+ogZfhpJlolzdhBu69b5Rjyc=;
 b=g6hk9tsu5RJ6NodV+lcl1Pe/OVOh/OFQJw8s+atVYuTgPGTixAvrOAbRBeVn6ZbmlaMWhE1fmC8LRF/MlglCcvE6sx3g/qIA63zy7FXJDFtErxDKlddqvP9kPKrEOpcVkqGMy175W2i0CvSWh+j5cbbW7c/TQezb3+GPWTQM3lVqBZ8jeQzaBbej0/BEF0m2GUY3PtVbS0v1SVpTEw5oHPNKhwfFN5EyXJ4ewWO/Ogd510hYEB8JDMKN07jlhXkgw4gAnzYJvw7jZ/LIWMOFmpL42M8YD3NwGCfQkh31XJdZZwZlrJaZKRxtTPcufe6JP1IBRTusC3fpaZe0S+pmvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oWcfVsITUyPRZXfJ6ZL+ogZfhpJlolzdhBu69b5Rjyc=;
 b=RZapQ+3di68LJVRxa+6U0+m1foXnlcG6nnucnNotKinGgIzLEjfiQcpGYs5lZj01Nz1gP1ADSeLYuChjaQfaFcouaDEHnOLFRGLLWZFsNcogXgXj3u5GKNWr/PLRweJcsCmlu7jRWkvWUpxZl4LsAQq6p0rcZWvE8VC6bZXhqbo=
Received: from DS7PR03CA0007.namprd03.prod.outlook.com (2603:10b6:5:3b8::12)
 by SA3PR12MB8045.namprd12.prod.outlook.com (2603:10b6:806:31d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Thu, 1 May
 2025 18:04:12 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::a6) by DS7PR03CA0007.outlook.office365.com
 (2603:10b6:5:3b8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.42 via Frontend Transport; Thu,
 1 May 2025 18:04:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Thu, 1 May 2025 18:04:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 1 May
 2025 13:04:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd: Stop evicting resources on APUs in
 suspend"
Date: Thu, 1 May 2025 14:03:56 -0400
Message-ID: <20250501180357.4103402-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|SA3PR12MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: d22f1bce-8d04-4c42-3c1c-08dd88da93d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C+WylxwiPiyWQRk3NLygGg0QtTM3HFxFgt+hG6pOfybfLMLjt2E5ssWmV4+E?=
 =?us-ascii?Q?vwRB/kgeRvo9bRB1k7USNQhcaFEYR957/pL4piWs3RRxX6qmRSTGw4fOf5TP?=
 =?us-ascii?Q?bDHTDgK7Ger+EAjmRPL8m/cTjRg3qHlfXL+SNO9HwvHSH6U7p/Kl8cboiypQ?=
 =?us-ascii?Q?PMaC1mHEjtBRjsLOnL8KzaIbpUm8IH7obGU1IYmIbnmHZ3ryfFMuHvaG1sXJ?=
 =?us-ascii?Q?+7AlqyVK3E4tsOypUwt54Aw07H0NEeyQj32h18Qjq63pCq4jKQaPgyBeyLjT?=
 =?us-ascii?Q?5rFwB7jfU/qK7Qnjbzp25do+/EEIgsnZ3aTYpiqyfOo52iq6C+3uH1ym0ih4?=
 =?us-ascii?Q?1Bq0HivgjIIcARrH7SOsyZjx5biYCtbsTD2mkfhSlAV4e/tvGMP5ljFhwInD?=
 =?us-ascii?Q?TnDG+9uRQZ9yKH0pwqoOAUhZBaeWzDpMvIEKtJpN4uJZb3Rkk6tjq3fMWBd+?=
 =?us-ascii?Q?7+pIJeE1L3reBGr/ee/CHu/ajyx4DyqpX02WWormU20oyjMhoG07ok3ErDiY?=
 =?us-ascii?Q?svTcOQG6BTyuNBmCLu7z0OBpQWHfYNDce9LY/wjmFDq8yitUQ69e4rUjPDjU?=
 =?us-ascii?Q?ywX+ccX6lTnhnr/43DQXI+2hkRcknVI/FxxVF8g7YUmEzhvDuPeGY2F4fSnG?=
 =?us-ascii?Q?F46P5hyZhThhSe8MUgM89jyIT9c0by5fM3B6pWTlXMKZiH4stG2J3zwIXv8I?=
 =?us-ascii?Q?uqV8lC0AL1w4+xkYn4N4Cs+JMWCWvQLa0jaeyyRzuoXT4BAh4yyBchuiONIJ?=
 =?us-ascii?Q?7wu8HR6t3jKFK1OW5HHynNfpW2qxnB6UkLJeKfA6BumaUIFbO+08I6uEud+W?=
 =?us-ascii?Q?/XMXCBgGsW3KJGYgSIA0fjH0jJJB5iuSY54R2TMUpZJOM2o9CqxydcJNQSqb?=
 =?us-ascii?Q?jM6QY0tMJQ7HwxwMh3+vnfeciup6DnHB7e9m611OVPeOXrKjpx9JTB8I4v/g?=
 =?us-ascii?Q?XmTHurQPCVkRhAW5VtsqRUt18LA14lxtCyyodnYbsSBURoIIlWKhoCSWjZb6?=
 =?us-ascii?Q?d28oGJ6V8T1YXSkmI03Yv8T6+aWwYE2pdmCE8N6pN/hXgdXrm7iCvnU5Tmc8?=
 =?us-ascii?Q?92ddRDEbGapsYa6VQLIVO8JHJS/d1IewbjXLdVLBu7tnS08vSvqdeDusxxld?=
 =?us-ascii?Q?vBzUF/ounCnWqJovePY2hoxH+umuCk7hrMsrr/N0ykIzkFlSGX/376cG6P7T?=
 =?us-ascii?Q?WRjd0ZJTJwSG1VJq/LMKLfzKugkRcnKmoSmjhhOUxMTMNjcsiD9zVfhSXr9B?=
 =?us-ascii?Q?ElYbMrobX7+4CbFWun8o0YZcbP3veIm+362wcN6ejKEFxCU1+n6wVhQ4XfWn?=
 =?us-ascii?Q?Yj2Cv58HOZMV3WBYgmgGsrc8GS80uEBrhAWYNayndhBlp3StfCIK5C/S69S/?=
 =?us-ascii?Q?nmFDDz/ArH/p1CR4RN4UoAlSRgqqibPtWRb+e565rsL6VHWhMZ+LyA6QWEAE?=
 =?us-ascii?Q?BI3MGmbZXmpPyO+OWPq8lWWgdeQs2fis2TZ4pYVycybUBnOII+b7wA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2025 18:04:11.9758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d22f1bce-8d04-4c42-3c1c-08dd88da93d9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8045
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

This reverts commit 3a9626c816db901def438dc2513622e281186d39.

This breaks S4 because we end up setting the s3/s0ix flags
even when we are entering s4 since prepare is used by both
flows.  The causes both the S3/s0ix and s4 flags to be set
which breaks several checks in the driver which assume they
are mutually exclusive.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3634
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c   | 18 ------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 11 ++---------
 3 files changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index ef6e78224fdfa..c3641331d4de7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1614,11 +1614,9 @@ static inline void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_cap
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
-static inline void amdgpu_choose_low_power_state(struct amdgpu_device *adev) { }
 #endif
 
 void amdgpu_register_gpu_instance(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index b7f8f2ff143dd..707e131f89d23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1533,22 +1533,4 @@ bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 #endif /* CONFIG_AMD_PMC */
 }
 
-/**
- * amdgpu_choose_low_power_state
- *
- * @adev: amdgpu_device_pointer
- *
- * Choose the target low power state for the GPU
- */
-void amdgpu_choose_low_power_state(struct amdgpu_device *adev)
-{
-	if (adev->in_runpm)
-		return;
-
-	if (amdgpu_acpi_is_s0ix_active(adev))
-		adev->in_s0ix = true;
-	else if (amdgpu_acpi_is_s3_active(adev))
-		adev->in_s3 = true;
-}
-
 #endif /* CONFIG_SUSPEND */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7f354cd532dc1..5ac7bd5942d01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4949,15 +4949,13 @@ int amdgpu_device_prepare(struct drm_device *dev)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	int i, r;
 
-	amdgpu_choose_low_power_state(adev);
-
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
 	/* Evict the majority of BOs before starting suspend sequence */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
-		goto unprepare;
+		return r;
 
 	flush_delayed_work(&adev->gfx.gfx_off_delay_work);
 
@@ -4968,15 +4966,10 @@ int amdgpu_device_prepare(struct drm_device *dev)
 			continue;
 		r = adev->ip_blocks[i].version->funcs->prepare_suspend(&adev->ip_blocks[i]);
 		if (r)
-			goto unprepare;
+			return r;
 	}
 
 	return 0;
-
-unprepare:
-	adev->in_s0ix = adev->in_s3 = adev->in_s4 = false;
-
-	return r;
 }
 
 /**
-- 
2.49.0

