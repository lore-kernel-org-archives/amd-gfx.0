Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD50DD10F36
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Nov 2024 04:34:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 655B210E259;
	Mon, 18 Nov 2024 04:34:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fx2xlvA2";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B162910E259
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Nov 2024 04:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZpxUyre6BybNFrDRvWCYgUgjAbjs0//LRB+sfBHSb0y/ye3bpI3+/vG0cBAK0WLUPdlsGBWSRw2tICiMrCTFaQZNW287gr5UlBXSon+HDkz6SYb3EcQdqT3VN1iphRTJfYPAep7rxJ0U9kBTl/ipR2fUsfDOj0eEk/wvl6KdtVJLOCbvLoMMSqUXmFkFRhPcaZmaaeLGOJo7qZMhoIM68x7/znq7WkALhzQa7EV7BJk8Ph/tyg4nmIDdRuP1l+YezTB3+GzFcKoHFNT5wP8Y1OGU2oMfWRM78C0T6cnTvjmvGzInzk8yB45kEVzTK50+cvRF+uUupOwF/0eJt/jk4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq+zNIB0jxn9StolteKaSDoyupx0vEFjbd87/o9Gv1w=;
 b=DGBoAi39IQjva7hNbgkvCL3W/uOXJsFs0l52rehba3dixOzIfbZSC5qcs3giPJgcHjANmDXBpmmDwu9KRW8RlhC4brx0DrnI43d2e2fKkhSanUZvRRS+ZqXn2UvecDRcJLdHHSey4YpFVyA7krJXON/hstXvFw63y2ps/Bi2YJOmUR5mF5VJZcXEOBBfwsRVZ78rFU+MfAPk+6wyOf9QTinZzLmJ9xxUAGQLmDWetkyzr9LTgpP8whIPjzKS7lJskg6sAKihi7F5qR//OKvuChCb90O0ccdoTU4jsH9eew+BWDqKivpDlyO1TbE4H04jR1wxWaJQa03w8+VCJaF1Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq+zNIB0jxn9StolteKaSDoyupx0vEFjbd87/o9Gv1w=;
 b=Fx2xlvA2kHhZViVznLTvIdECVhClsf7tfoDi+3k7Gbc2W/izpNnhQQW679ZzOLUcBW5dXXBEE373jFZEfV/ANv7jUjaJbioSTZcOXsKU77AfPFRcrpZYOOHi/qtDQ3v0F3JYLt7KVifOyu5WwBMld6m+VcvD/g1X0mC6MvK2qz0=
Received: from SA9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::14)
 by DM4PR12MB9070.namprd12.prod.outlook.com (2603:10b6:8:bc::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 04:33:56 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:806:25:cafe::85) by SA9P221CA0009.outlook.office365.com
 (2603:10b6:806:25::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 04:33:56 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 04:33:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 22:31:49 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 17 Nov
 2024 22:31:43 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Sun, 17 Nov 2024 22:31:36 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <vitaly.prosyak@amd.com>, <Tim.Huang@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 2/3] Revert "drm/amdgpu: fix warning when removing sysfs"
Date: Mon, 18 Nov 2024 12:31:27 +0800
Message-ID: <20241118043128.3834919-2-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241118043128.3834919-1-jesse.zhang@amd.com>
References: <20241118043128.3834919-1-jesse.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|DM4PR12MB9070:EE_
X-MS-Office365-Filtering-Correlation-Id: f77370a5-6bbb-4a0b-39d0-08dd078a367e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NkhBd0FuajVmaHUvZW40ZU1neVZUbzArbHVYaEd5clk4L1RzSDhCbmFJR1E0?=
 =?utf-8?B?ZjliS0lyKytaWjEvZ1NOQmRsSUVMbkMzYlhNWEFoTEgwSFFwVW5mVlBYV1N1?=
 =?utf-8?B?ZXg0dUZRVG1KTE9TTlFDMTJScnZ2bGJJMmhQNzQvNDRYYnp1RXpLN3lrRllz?=
 =?utf-8?B?N0NqUlNtRE4zcklXaUtQcFpoa3lyTkg3dVltV0hPamlLKzNpUlkvMVVOYzZl?=
 =?utf-8?B?LzVMZDNPbFNyWEdaMllvVHRsQUdxTSt2OTZBbmk2ZU0wK2VUTE92WXQ4dXRt?=
 =?utf-8?B?TXArZmR6aTY4Nk5tS2h4ZGgxemRSRUdWUmJCaTczb2c3c1VPT2llV3pmN004?=
 =?utf-8?B?WVhCU1RFaVlsbDFwNUVUaXhVTTlCNS9jSDljQzRnYVk2cm5YMHZHV25ZQUNa?=
 =?utf-8?B?Ni9sWVFEclVWekVMUy9HZjZLQktFcTNWbUhVcUFtVzVjVDEvb0tITmZvaXl3?=
 =?utf-8?B?TFhBRXRkamJGakRxSURhbFB3c3VjdTVvYnBkMHZaMHgwdEFRRW5Hckc0UFpJ?=
 =?utf-8?B?YjhHMW4wbEtpL2NSSFFWTHBlUjJieXBuNkY2dVJuSHNxeFJkTDZKa1YyOEpC?=
 =?utf-8?B?L3drc3ZIVWw1SW1ueEc2RW5mS3BYTEpGdzNNTEhOTHZqam9PSkc4endXQjcv?=
 =?utf-8?B?UklVSmFOd3ZkaW45UkplNmdrWG8vazdTaUwxL3Nxay9VbEgrR3RpVjdycTBP?=
 =?utf-8?B?cDBQMGNMdG5oaGt5V24wRzhEWTdmS2VPMWpPNGo3UG5qb1hlRU1PT3RGSUxM?=
 =?utf-8?B?bUpiWDA2YVZjaXB0OTFTeTd2bFJ6WVJ5azdLWGZwWnQyUWhpMTh1L09yQkpn?=
 =?utf-8?B?dG5sc2VKSG0zMFR0M3IvS2phL3M0RGM2QWZMRDFwdTBRdjcySkpvVGp2WTF0?=
 =?utf-8?B?TWR3UVZscllEa0FBYXNxbUFGVU4xRk5MNWlRMlQ3Qks2bThpMjJ4WkEveDNi?=
 =?utf-8?B?ajFlQkd6ZnE3WmJzT2V3YUg0MlYzRCtqUVNyOWxaYzUwdFZhUHJGTWI1d1A1?=
 =?utf-8?B?Ym1iR2xycFNlc2NRZEtmcHJ6ZTZpc0lpRG03UzBCWERwNzl6TUowSy9JYXVU?=
 =?utf-8?B?KytuakRjQmJ1M2NCNXRFUy81RDdtSWE0Y2ZVT2xWaXg4N2pOOXJudS9TVlk0?=
 =?utf-8?B?LzNDbGxiN3VsangrK3ZPNENONHpmanByR08yejhIT09IZThZZ2R6aUJpQ2p4?=
 =?utf-8?B?eGR4Y1dBWmprbXlJOWNPNm9rcTlkY3FPREkvVDZWd1QvOHZoMWxNQ21DWVhl?=
 =?utf-8?B?MFZUMi9vNlc0RkJWR2xWNWM5Vm9hMHZ5cHdETVM5N3FRTTU0bExHTGM3ZnFW?=
 =?utf-8?B?QXUxRFFhK0dCczNneHUxN25MaDZ6b0ZOTXVaTUU2dy95RkFObEZqK2ZxeWtK?=
 =?utf-8?B?R2I3L043Si9aOTFQcnd5b0xHZEZZbGFFNlh1L0FyVXZka1p5a3JkNmFJZjFJ?=
 =?utf-8?B?bXVCUnVYZUVUQTN1VWhxNEk2bktJdUloRzFON2MrcU5NVnFnbXJuR1lUQWlX?=
 =?utf-8?B?dndybEJqZUVOODhnTFRRMHBKa0s4WWQzZzZ0M2tSSXlxdjJEdUpBNUVZZzFo?=
 =?utf-8?B?dE1wSEt4cFRwOU1pS2xIWTVGWEdsQS90bXVlS3BteG1YMCtZRFE2S2wrTGhD?=
 =?utf-8?B?RGR6ODl1dk1hZ1RTY3F5Skx0aC9haFlTQ0FCNVhmMXRsVktBOTVYUDFWQjg4?=
 =?utf-8?B?VWdWdm44c3BOMVZqWG0zSDU5aWdzSFZveW43eFQzbTNvZGxuazZ1bDNKOExW?=
 =?utf-8?B?cXl6c0t5Skx5bC9JNDRQUW9YNjZqcE9vajloM2pRMGtxSnJUOTVpRitDZW1G?=
 =?utf-8?B?ZkVCNW5NUGxSMVNtU3pIMU4yMnFFSEtyZVE0dlV2YURUejQwb3g3OGNUeXRx?=
 =?utf-8?B?aUd5Q0pyQ05QcFBYRmVwNnFIOWVtRVgweW1VL3M1UDMvOGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 04:33:55.6820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f77370a5-6bbb-4a0b-39d0-08dd078a367e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9070
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This reverts commit 330d97e9b14e0c85cc8b63e0092e4abcb9ce99c8.
the dev->unplugged flag will also be set to true ,
Only uninstall the driver by amdgpu_exit,not actually unplug the device.
that will cause a new issue.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c         | 12 +++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c        | 10 ++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c |  8 ++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c        | 10 ++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c         |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c         |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/df_v3_6.c            |  8 ++------
 7 files changed, 15 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index c65feb97167d..3c89c74d67e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -25,7 +25,6 @@
 
 #include <linux/firmware.h>
 #include <linux/pm_runtime.h>
-#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_gfx.h"
@@ -1779,14 +1778,9 @@ int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
 
 void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		amdgpu_gfx_sysfs_xcp_fini(adev);
-		amdgpu_gfx_sysfs_isolation_shader_fini(adev);
-		amdgpu_gfx_sysfs_reset_mask_fini(adev);
-		drm_dev_exit(idx);
-	}
+	amdgpu_gfx_sysfs_xcp_fini(adev);
+	amdgpu_gfx_sysfs_isolation_shader_fini(adev);
+	amdgpu_gfx_sysfs_reset_mask_fini(adev);
 }
 
 int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index bf4dbceb18e1..43ea76ebbad8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -24,7 +24,6 @@
  *
  */
 
-#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "amdgpu_jpeg.h"
 #include "amdgpu_pm.h"
@@ -448,11 +447,6 @@ int amdgpu_jpeg_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_jpeg_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		if (adev->jpeg.num_jpeg_inst)
-			device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
-		drm_dev_exit(idx);
-	}
+	if (adev->jpeg.num_jpeg_inst)
+		device_remove_file(adev->dev, &dev_attr_jpeg_reset_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
index 33a714ddfbbc..e8adfd0a570a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_preempt_mgr.c
@@ -23,7 +23,6 @@
  * Authors: Christian König, Felix Kuehling
  */
 
-#include <drm/drm_drv.h>
 #include "amdgpu.h"
 
 /**
@@ -130,7 +129,7 @@ int amdgpu_preempt_mgr_init(struct amdgpu_device *adev)
 void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 {
 	struct ttm_resource_manager *man = &adev->mman.preempt_mgr;
-	int idx, ret;
+	int ret;
 
 	ttm_resource_manager_set_used(man, false);
 
@@ -138,10 +137,7 @@ void amdgpu_preempt_mgr_fini(struct amdgpu_device *adev)
 	if (ret)
 		return;
 
-	if (!drm_dev_enter(adev_to_drm(adev), &idx)) {
-		device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
-		drm_dev_exit(idx);
-	}
+	device_remove_file(adev->dev, &dev_attr_mem_info_preempt_used);
 
 	ttm_resource_manager_cleanup(man);
 	ttm_set_driver_manager(&adev->mman.bdev, AMDGPU_PL_PREEMPT, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 24e9daacaabb..8c89b69edc20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -21,7 +21,6 @@
  *
  */
 
-#include <drm/drm_drv.h>
 #include <linux/firmware.h>
 #include "amdgpu.h"
 #include "amdgpu_sdma.h"
@@ -449,14 +448,9 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
 	if (!amdgpu_gpu_recovery)
 		return;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		if (adev->sdma.num_instances)
-			device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
-		drm_dev_exit(idx);
-	}
+	if (adev->sdma.num_instances)
+		device_remove_file(adev->dev, &dev_attr_sdma_reset_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 25f490ad3a85..60e19052a1e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -1310,11 +1310,6 @@ int amdgpu_vcn_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vcn_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		if (adev->vcn.num_vcn_inst)
-			device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
-		drm_dev_exit(idx);
-	}
+	if (adev->vcn.num_vcn_inst)
+		device_remove_file(adev->dev, &dev_attr_vcn_reset_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index b5f5a1a81c29..02bda187f982 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -904,13 +904,8 @@ int amdgpu_vpe_sysfs_reset_mask_init(struct amdgpu_device *adev)
 
 void amdgpu_vpe_sysfs_reset_mask_fini(struct amdgpu_device *adev)
 {
-	int idx;
-
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		if (adev->vpe.num_instances)
-			device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
-		drm_dev_exit(idx);
-	}
+	if (adev->vpe.num_instances)
+		device_remove_file(adev->dev, &dev_attr_vpe_reset_mask);
 }
 
 static const struct amdgpu_ring_funcs vpe_ring_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
index 54c05af2eed2..483a441b46aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
+++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
@@ -20,7 +20,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  *
  */
-#include <drm/drm_drv.h>
 #include "amdgpu.h"
 #include "df_v3_6.h"
 
@@ -255,12 +254,9 @@ static void df_v3_6_sw_init(struct amdgpu_device *adev)
 
 static void df_v3_6_sw_fini(struct amdgpu_device *adev)
 {
-	int idx;
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
-		drm_dev_exit(idx);
-	}
+	device_remove_file(adev->dev, &dev_attr_df_cntr_avail);
+
 }
 
 static void df_v3_6_enable_broadcast_mode(struct amdgpu_device *adev,
-- 
2.25.1

