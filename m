Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B4E6E74AC8
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 18:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD9CB10EAF4;
	Tue,  3 Dec 2024 18:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dtWacoHh";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9B1910E497
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 18:14:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W7tT1qCHX4xkxMEpkRFx7R0nHBwjhmgpI4Spz+XudY1Y+7pEywF1M6TWC1du3H44o1mDHiSveDtF/3ekV6UYvrOP2isk+DZcx2YdsMRUVuHEH/BRHOVufX0JWpRS4h0OU7q4Cqed1uGWP7uwIrbE0BuC4iNZawfqy6Z7lUACVckuTHiOyoaxR1Aq0Zc8rKt8UAN2hcFjII7wBP5Jtp94UMFWxvqgBYkPK4Jwy0H0Bu4G28UyvmcG+cl0AhmpqktXnCjqqFSOXG+xzSEj/W6pALp+3zzWb1Z5Vv3iZXURGeGjTGeDXAajn8VAha3XUZQSAL4Z+tP/qIJb143ZdUXaaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fpaaMRm6D4U2UjhiGM16X69otQ7kOE8uaeKFixXmF8=;
 b=w1QGK/NPDk2QAgYTWvXBwCp94HRRK2aPD4veZ9q/VOToBEA0cgsHXBzbKcWWu/PC+1Y2wvskkt55ue53vkaX+j5H/6VIe5AiC+zvfB0sXUXJVGFjdX8b4W8QsOu/fXQ2xmz1nr7N6EdL/xkdesFtrYodEupnVNs52GBjvezG3/AUvSAZd2LEO7QbM6kXzHYo+YzsnOPyDJOFztJa1bC9wZv3iTIL4epQ8CMsKqK7LIdlbgtwuLuac7dd4LKioQLEWPkOz03b1OmGs20EbbEgHi+/Y4aj3uoklcPZ9T0Nth9cRTdKjn0lDl/zWEqFMqkdH9eCK+jDAKcZXaJfHxfOOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fpaaMRm6D4U2UjhiGM16X69otQ7kOE8uaeKFixXmF8=;
 b=dtWacoHhguJXYbEQJVJyRhdMBIMIfB0tWfJTbX45F5qUWxuZ45UBXKFaxUHof0sqs1lfTWvzL1HVjDcYVeB2WrCu144kvnZaOIgoQSRAGDWfs41OEGwm+hlBmaj4KwhOe9JHeWvn6HMBJZLnDShCb35utHayybDkiNgKNtzJAfk=
Received: from MN2PR19CA0039.namprd19.prod.outlook.com (2603:10b6:208:19b::16)
 by DS7PR12MB8372.namprd12.prod.outlook.com (2603:10b6:8:eb::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Tue, 3 Dec 2024 18:14:22 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:208:19b:cafe::f8) by MN2PR19CA0039.outlook.office365.com
 (2603:10b6:208:19b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.16 via Frontend Transport; Tue,
 3 Dec 2024 18:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 18:14:22 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 12:14:21 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH] drm/amd: Add the capability to mark certain firmware as
 "required"
Date: Tue, 3 Dec 2024 12:14:03 -0600
Message-ID: <20241203181403.23515-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|DS7PR12MB8372:EE_
X-MS-Office365-Filtering-Correlation-Id: 07237b4d-a0e0-48aa-7529-08dd13c64ff8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?A/abH/CYf0SRtY6jXyh4L1u4y7sc2fuz0tJsBfCd0jGyKB+ko0ZxVG8nQ3tr?=
 =?us-ascii?Q?/Fc6BAf9qOhjWoOIPC+152FJNWHyMK1RzUmHO/9FbC+p79JVGjoiGgQJvDjj?=
 =?us-ascii?Q?ZxqIZ27NlB1KK1Yn+evIyb83OXlMh1xyOg5hhZe4JLTbpVngonOfMK5teJGZ?=
 =?us-ascii?Q?c0rql2/g00Edb+ynV/qTEHyvpFwTEtDmZrRHjUE4tr4j/UtratUBCrKIWja6?=
 =?us-ascii?Q?nw1pu1Cwg93eIQUBF1Yd0vEj66HqYt9c6kcneSOtN1t5HuSVnEpxWcQkZyfy?=
 =?us-ascii?Q?gFGVLYAUeeBq7xBZpr02t5D2OA5SuxOUyOoPE86Ds+nyaYQgLUhAhfEUukUO?=
 =?us-ascii?Q?CMTcp1n4PQd8wqdrDN/HHFUOBmwa8G50eJkrtoMQ3u7yMtpHeQuCkTE0r6Oc?=
 =?us-ascii?Q?z96F/aPrlTQUMawz8ZjNwtjB/irLlusVbegJeq2CfpaEkbH/3Pjqs5TGPFub?=
 =?us-ascii?Q?cs4buewRdgM4HyJkOQYqc154Rb8zwg1VPyijnOUEe5szxT+KKWToxrAepxf9?=
 =?us-ascii?Q?/Muisma9wZrKahNlFBV0DUW/2UJ9gJM6kLKKLweXmx1zsh2bIHcbmvQ4gUJm?=
 =?us-ascii?Q?bO/yp27fc1GrX2RBNgaNGryJMG3A21PKVrndTcrfftxKTXp724SokJvkQJCr?=
 =?us-ascii?Q?VFjM5mZaH18/F79mRdNEgnXlwGW6yMtB4ariLeKb5x1LLRPL82MvY8I5UaCT?=
 =?us-ascii?Q?loBou49eyVwXz9Z+7ehPBsak0C3xlgVSXH6sC/PbteUuL25iDDgmNk1SbnrW?=
 =?us-ascii?Q?xHHH+NdOvqTUZvy5zmYn2obRC/fqSeXvOdyif0U+reOFEYYgNlyRMVR2Ay8I?=
 =?us-ascii?Q?31O1euyZ/OmOU70Vxo7F5bf29sQkOh4Fr2Sq+26eAwHapKpd+escqDPjOxiM?=
 =?us-ascii?Q?Y4Jdd/eNEgl/HFnddmbg4SYx9C2eDgqMyyBcK2AYHHVWE2qSkZGin3hNHyty?=
 =?us-ascii?Q?yDZy1cjyghecHV0r4vklDoAKxNwbjvAlruE/YJmPc+Y0wS/x6TP6VILhqNDG?=
 =?us-ascii?Q?xtz9ZlBE86KkjVPFPt/UqlbnnLXbyC0JV0aFvvelJQjZ+AFB2W5plgbMeX5A?=
 =?us-ascii?Q?XHSEDZr/YBEK1dYN+PpezjsawgRKcOWQqK3Jmtvn2Z55KfGImU0gbDrs49Sr?=
 =?us-ascii?Q?COFwA7jVMXOugOnLMzTB1T4eta47DWLzMTOA/oY30nTHkPYy5WZWHzfzP7V6?=
 =?us-ascii?Q?XMryNECTHJnRis9wd2XDXsA7Dc44NGhzvHeF+8/vIAQa0flNI+Zm93XhzavR?=
 =?us-ascii?Q?AsH63J+iHlNDjNoeTk/eOBj9MQxrTHI9z6JrLRrsbnq/XZewFnHtEgnuj1ll?=
 =?us-ascii?Q?glHsJZM/9fxO8LQlKXaUAuBzfh4se0nhjdE2qqyd4Ao+j1Jv6P0jpE0EW7h/?=
 =?us-ascii?Q?AtCJZ2sXpa+VxEL7YxoH7G73qYNRiBv5u2B2gVKDacHQvmsnvgxbtVMc2riB?=
 =?us-ascii?Q?tnMUZF2Rd+DQv8LzYoQ6IJfHdA8vCigX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 18:14:22.1988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07237b4d-a0e0-48aa-7529-08dd13c64ff8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8372
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

Some of the firmware that is loaded by amdgpu is not actually required.
For example the ISP firmware on some SoCs is optional, and if it's not
present the ISP IP block just won't be initialized.

The firmware loader core however will show a warning when this happens
like this:
```
Direct firmware load for amdgpu/isp_4_1_0.bin failed with error -2
```

To avoid confusion for non-required firmware, adjust the amd-ucode helper
to take an extra argument indicating if the firmware is required or not.

On non-required firmware use firmware_request_nowarn() instead of
request_firmware() to avoid the warnings.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c        |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c        |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c        |  4 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c        | 18 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c       |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c      |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h      |  9 +++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c   |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c        |  8 ++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c        |  3 ++-
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c          |  2 ++
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c         |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         |  5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c          |  4 ++++
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c          |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c          | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c          | 12 +++++++++++-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c        |  7 +++++--
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c          |  3 ++-
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c         |  3 ++-
 drivers/gpu/drm/amd/amdgpu/imu_v12_0.c         |  3 ++-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c         |  2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c         |  2 ++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  6 ++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c     |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c |  3 ++-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c   |  3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c |  3 ++-
 35 files changed, 136 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 16153d275d7a..68bce6a6d09d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -414,7 +414,9 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				return -EINVAL;
 			}
 
-			err = amdgpu_ucode_request(adev, &adev->pm.fw, "%s", fw_name);
+			err = amdgpu_ucode_request(adev, &adev->pm.fw,
+						   AMDGPU_UCODE_REQUIRED,
+						   "%s", fw_name);
 			if (err) {
 				DRM_ERROR("Failed to load firmware \"%s\"", fw_name);
 				amdgpu_ucode_release(&adev->pm.fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 16b9b3c4190c..83f0de30317e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2483,6 +2483,7 @@ static int amdgpu_device_parse_gpu_info_fw(struct amdgpu_device *adev)
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->firmware.gpu_info_fw,
+				   AMDGPU_UCODE_NOT_REQUIRED,
 				   "amdgpu/%s_gpu_info.bin", chip_name);
 	if (err) {
 		dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
index d52f18393970..56cc179fca26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_isp.c
@@ -77,7 +77,8 @@ static int isp_load_fw_by_psp(struct amdgpu_device *adev)
 				       sizeof(ucode_prefix));
 
 	/* read isp fw */
-	r = amdgpu_ucode_request(adev, &adev->isp.fw, "amdgpu/%s.bin", ucode_prefix);
+	r = amdgpu_ucode_request(adev, &adev->isp.fw, AMDGPU_UCODE_NOT_REQUIRED,
+				"amdgpu/%s.bin", ucode_prefix);
 	if (r) {
 		amdgpu_ucode_release(&adev->isp.fw);
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index a67e6a52347f..bb946fa1e912 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1438,10 +1438,12 @@ int amdgpu_mes_init_microcode(struct amdgpu_device *adev, int pipe)
 			 pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
 	}
 
-	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], "%s", fw_name);
+	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], AMDGPU_UCODE_REQUIRED,
+				 "%s", fw_name);
 	if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
 		dev_info(adev->dev, "try to fall back to %s_mes.bin\n", ucode_prefix);
 		r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
+					 AMDGPU_UCODE_REQUIRED,
 					 "amdgpu/%s_mes.bin", ucode_prefix);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 12832fd834fb..3043ec5d3a31 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3290,7 +3290,8 @@ int psp_init_asd_microcode(struct psp_context *psp, const char *chip_name)
 	const struct psp_firmware_header_v1_0 *asd_hdr;
 	int err = 0;
 
-	err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, "amdgpu/%s_asd.bin", chip_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.asd_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_asd.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3312,7 +3313,8 @@ int psp_init_toc_microcode(struct psp_context *psp, const char *chip_name)
 	const struct psp_firmware_header_v1_0 *toc_hdr;
 	int err = 0;
 
-	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, "amdgpu/%s_toc.bin", chip_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_toc.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3475,7 +3477,8 @@ int psp_init_sos_microcode(struct psp_context *psp, const char *chip_name)
 	uint8_t *ucode_array_start_addr;
 	int err = 0;
 
-	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, "amdgpu/%s_sos.bin", chip_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.sos_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_sos.bin", chip_name);
 	if (err)
 		goto out;
 
@@ -3751,7 +3754,8 @@ int psp_init_ta_microcode(struct psp_context *psp, const char *chip_name)
 	struct amdgpu_device *adev = psp->adev;
 	int err;
 
-	err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, "amdgpu/%s_ta.bin", chip_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.ta_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_ta.bin", chip_name);
 	if (err)
 		return err;
 
@@ -3786,7 +3790,8 @@ int psp_init_cap_microcode(struct psp_context *psp, const char *chip_name)
 		return -EINVAL;
 	}
 
-	err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, "amdgpu/%s_cap.bin", chip_name);
+	err = amdgpu_ucode_request(adev, &adev->psp.cap_fw, AMDGPU_UCODE_NOT_REQUIRED,
+				   "amdgpu/%s_cap.bin", chip_name);
 	if (err) {
 		if (err == -ENODEV) {
 			dev_warn(adev->dev, "cap microcode does not exist, skip\n");
@@ -3909,7 +3914,8 @@ static ssize_t psp_usbc_pd_fw_sysfs_write(struct device *dev,
 	if (!drm_dev_enter(ddev, &idx))
 		return -ENODEV;
 
-	ret = amdgpu_ucode_request(adev, &usbc_pd_fw, "amdgpu/%s", buf);
+	ret = amdgpu_ucode_request(adev, &usbc_pd_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s", buf);
 	if (ret)
 		goto fail;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 113f0d242618..b3c032f249f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -219,9 +219,11 @@ int amdgpu_sdma_init_microcode(struct amdgpu_device *adev,
 	amdgpu_ucode_ip_version_decode(adev, SDMA0_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	if (instance == 0)
 		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s.bin", ucode_prefix);
 	else
 		err = amdgpu_ucode_request(adev, &adev->sdma.instance[instance].fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s%d.bin", ucode_prefix, instance);
 	if (err)
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index d3cd76c6dab3..ffbb3377e0f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1434,6 +1434,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
  *
  * @adev: amdgpu device
  * @fw: pointer to load firmware to
+ * @required: whether the firmware is required
  * @fmt: firmware name format string
  * @...: variable arguments
  *
@@ -1442,7 +1443,7 @@ void amdgpu_ucode_ip_version_decode(struct amdgpu_device *adev, int block_type,
  * the error code to -ENODEV, so that early_init functions will fail to load.
  */
 int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
-			 const char *fmt, ...)
+			 enum amdgpu_ucode_required required, const char *fmt, ...)
 {
 	char fname[AMDGPU_UCODE_NAME_MAX];
 	va_list ap;
@@ -1456,7 +1457,10 @@ int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
 		return -EOVERFLOW;
 	}
 
-	r = request_firmware(fw, fname, adev->dev);
+	if (required == AMDGPU_UCODE_REQUIRED)
+		r = request_firmware(fw, fname, adev->dev);
+	else
+		r = firmware_request_nowarn(fw, fname, adev->dev);
 	if (r)
 		return -ENODEV;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
index 4150ec0aa10d..827d75185d83 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -551,6 +551,11 @@ enum amdgpu_firmware_load_type {
 	AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO,
 };
 
+enum amdgpu_ucode_required {
+	AMDGPU_UCODE_NOT_REQUIRED,
+	AMDGPU_UCODE_REQUIRED,
+};
+
 /* conform to smu_ucode_xfer_cz.h */
 #define AMDGPU_SDMA0_UCODE_LOADED	0x00000001
 #define AMDGPU_SDMA1_UCODE_LOADED	0x00000002
@@ -604,9 +609,9 @@ void amdgpu_ucode_print_rlc_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_sdma_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
-__printf(3, 4)
+__printf(4, 5)
 int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
-			 const char *fmt, ...);
+			 enum amdgpu_ucode_required required, const char *fmt, ...);
 void amdgpu_ucode_release(const struct firmware **fw);
 bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
 				uint16_t hdr_major, uint16_t hdr_minor);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index bd2d3863c3ed..dde15c6a96e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -587,7 +587,8 @@ int amdgpu_umsch_mm_init_microcode(struct amdgpu_umsch_mm *umsch)
 		break;
 	}
 
-	r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, "%s", fw_name);
+	r = amdgpu_ucode_request(adev, &adev->umsch_mm.fw, AMDGPU_UCODE_REQUIRED,
+				 "%s", fw_name);
 	if (r) {
 		release_firmware(adev->umsch_mm.fw);
 		adev->umsch_mm.fw = NULL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 31fd30dcd593..30e9869a0584 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -260,7 +260,7 @@ int amdgpu_uvd_sw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	r = amdgpu_ucode_request(adev, &adev->uvd.fw, "%s", fw_name);
+	r = amdgpu_ucode_request(adev, &adev->uvd.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_uvd: Can't validate firmware \"%s\"\n",
 			fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 599d3ca4e0ef..65387f6943b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -158,7 +158,7 @@ int amdgpu_vce_sw_init(struct amdgpu_device *adev, unsigned long size)
 		return -EINVAL;
 	}
 
-	r = amdgpu_ucode_request(adev, &adev->vce.fw, "%s", fw_name);
+	r = amdgpu_ucode_request(adev, &adev->vce.fw, AMDGPU_UCODE_REQUIRED, "%s", fw_name);
 	if (r) {
 		dev_err(adev->dev, "amdgpu_vce: Can't validate firmware \"%s\"\n",
 			fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 05f01f50194b..2455cc126e59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -99,9 +99,13 @@ int amdgpu_vcn_early_init(struct amdgpu_device *adev)
 	amdgpu_ucode_ip_version_decode(adev, UVD_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	for (i = 0; i < adev->vcn.num_vcn_inst; i++) {
 		if (i == 1 && amdgpu_ip_version(adev, UVD_HWIP, 0) ==  IP_VERSION(4, 0, 6))
-			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s_%d.bin", ucode_prefix, i);
+			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
+						 AMDGPU_UCODE_REQUIRED,
+						 "amdgpu/%s_%d.bin", ucode_prefix, i);
 		else
-			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw, "amdgpu/%s.bin", ucode_prefix);
+			r = amdgpu_ucode_request(adev, &adev->vcn.inst[i].fw,
+						 AMDGPU_UCODE_REQUIRED,
+						 "amdgpu/%s.bin", ucode_prefix);
 		if (r) {
 			amdgpu_ucode_release(&adev->vcn.inst[i].fw);
 			return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index 83cb9f565fe5..2c12840ea444 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -236,7 +236,8 @@ int amdgpu_vpe_init_microcode(struct amdgpu_vpe *vpe)
 	int ret;
 
 	amdgpu_ucode_ip_version_decode(adev, VPE_HWIP, fw_prefix, sizeof(fw_prefix));
-	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, "amdgpu/%s.bin", fw_prefix);
+	ret = amdgpu_ucode_request(adev, &adev->vpe.fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s.bin", fw_prefix);
 	if (ret)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 1563e35da0fe..a5cd950c94be 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -133,9 +133,11 @@ static int cik_sdma_init_microcode(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
 			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_sdma.bin", chip_name);
 		else
 			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index f1b35b4a73ff..c4e15418e187 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4138,18 +4138,21 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_pfp%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_me%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_ce%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
@@ -4173,6 +4176,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_mec%s.bin", ucode_prefix, wks);
 	if (err)
 		goto out;
@@ -4180,6 +4184,7 @@ static int gfx_v10_0_init_microcode(struct amdgpu_device *adev)
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1_JT);
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_mec2%s.bin", ucode_prefix, wks);
 	if (!err) {
 		amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index f63a06661f86..67cd42031571 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -641,6 +641,7 @@ static int gfx_v11_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 	int err = 0;
 
 	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_toc.bin", ucode_prefix);
 	if (err)
 		goto out;
@@ -690,6 +691,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
@@ -707,6 +709,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_me.bin", ucode_prefix);
 	if (err)
 		goto out;
@@ -722,9 +725,11 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 		if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(11, 0, 0) &&
 		    adev->pdev->revision == 0xCE)
 			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/gc_11_0_0_rlc_1.bin");
 		else
 			err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
 			goto out;
@@ -737,6 +742,7 @@ static int gfx_v11_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_mec.bin", ucode_prefix);
 	if (err)
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index ebb09c363803..d0697b0869e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -539,6 +539,7 @@ static int gfx_v12_0_init_toc_microcode(struct amdgpu_device *adev, const char *
 	int err = 0;
 
 	err = amdgpu_ucode_request(adev, &adev->psp.toc_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_toc.bin", ucode_prefix);
 	if (err)
 		goto out;
@@ -568,6 +569,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_pfp.bin", ucode_prefix);
 	if (err)
 		goto out;
@@ -575,6 +577,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_RS64_PFP_P0_STACK);
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_me.bin", ucode_prefix);
 	if (err)
 		goto out;
@@ -583,6 +586,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 
 	if (!amdgpu_sriov_vf(adev)) {
 		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_rlc.bin", ucode_prefix);
 		if (err)
 			goto out;
@@ -595,6 +599,7 @@ static int gfx_v12_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_mec.bin", ucode_prefix);
 	if (err)
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 81c185a8b3a0..1b4c0dcee7e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -337,6 +337,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
@@ -345,6 +346,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.pfp_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
@@ -353,6 +355,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.me_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
@@ -361,6 +364,7 @@ static int gfx_v6_0_init_microcode(struct amdgpu_device *adev)
 	adev->gfx.ce_feature_version = le32_to_cpu(cp_hdr->ucode_feature_version);
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 60931396f76b..17a07e1adffa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -934,33 +934,39 @@ static int gfx_v7_0_init_microcode(struct amdgpu_device *adev)
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
 
 	if (adev->asic_type == CHIP_KAVERI) {
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_mec2.bin", chip_name);
 		if (err)
 			goto out;
 	}
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_rlc.bin", chip_name);
 out:
 	if (err) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index f15beb217b48..a2a45be68c24 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -982,13 +982,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+					   AMDGPU_UCODE_NOT_REQUIRED,
 					   "amdgpu/%s_pfp_2.bin", chip_name);
 		if (err == -ENODEV) {
 			err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_pfp.bin", chip_name);
 		}
 	} else {
 		err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_pfp.bin", chip_name);
 	}
 	if (err)
@@ -999,13 +1002,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+					   AMDGPU_UCODE_NOT_REQUIRED,
 					   "amdgpu/%s_me_2.bin", chip_name);
 		if (err == -ENODEV) {
 			err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_me.bin", chip_name);
 		}
 	} else {
 		err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_me.bin", chip_name);
 	}
 	if (err)
@@ -1017,13 +1023,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+					   AMDGPU_UCODE_NOT_REQUIRED,
 					   "amdgpu/%s_ce_2.bin", chip_name);
 		if (err == -ENODEV) {
 			err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_ce.bin", chip_name);
 		}
 	} else {
 		err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_ce.bin", chip_name);
 	}
 	if (err)
@@ -1044,6 +1053,7 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 		adev->virt.chained_ib_support = false;
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
@@ -1093,13 +1103,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 
 	if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   AMDGPU_UCODE_NOT_REQUIRED,
 					   "amdgpu/%s_mec_2.bin", chip_name);
 		if (err == -ENODEV) {
 			err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_mec.bin", chip_name);
 		}
 	} else {
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_mec.bin", chip_name);
 	}
 	if (err)
@@ -1112,13 +1125,16 @@ static int gfx_v8_0_init_microcode(struct amdgpu_device *adev)
 	    (adev->asic_type != CHIP_TOPAZ)) {
 		if (adev->asic_type >= CHIP_POLARIS10 && adev->asic_type <= CHIP_POLARIS12) {
 			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   AMDGPU_UCODE_NOT_REQUIRED,
 						   "amdgpu/%s_mec2_2.bin", chip_name);
 			if (err == -ENODEV) {
 				err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+							   AMDGPU_UCODE_REQUIRED,
 							   "amdgpu/%s_mec2.bin", chip_name);
 			}
 		} else {
 			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_mec2.bin", chip_name);
 		}
 		if (!err) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4e27528b7e57..30d9b6dacb6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1429,18 +1429,21 @@ static int gfx_v9_0_init_cp_gfx_microcode(struct amdgpu_device *adev,
 	int err;
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.pfp_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_pfp.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_PFP);
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.me_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_me.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_ME);
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.ce_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_ce.bin", chip_name);
 	if (err)
 		goto out;
@@ -1476,6 +1479,7 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 		(((adev->pdev->revision >= 0xC8) && (adev->pdev->revision <= 0xCF)) ||
 		((adev->pdev->revision >= 0xD8) && (adev->pdev->revision <= 0xDF))))
 		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_rlc_am4.bin", chip_name);
 	else if (!strcmp(chip_name, "raven") && (amdgpu_pm_load_smu_firmware(adev, &smu_version) == 0) &&
 		(smu_version >= 0x41e2b))
@@ -1483,9 +1487,11 @@ static int gfx_v9_0_init_rlc_microcode(struct amdgpu_device *adev,
 		*SMC is loaded by SBIOS on APU and it's able to get the SMU version directly.
 		*/
 		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_kicker_rlc.bin", chip_name);
 	else
 		err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
@@ -1518,9 +1524,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
-					   "amdgpu/%s_sjt_mec.bin", chip_name);
+				   AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_sjt_mec.bin", chip_name);
 	else
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
+					   AMDGPU_UCODE_REQUIRED,
 					   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
@@ -1531,9 +1539,11 @@ static int gfx_v9_0_init_cp_compute_microcode(struct amdgpu_device *adev,
 	if (gfx_v9_0_load_mec2_fw_bin_support(adev)) {
 		if (amdgpu_sriov_vf(adev) && (adev->asic_type == CHIP_ALDEBARAN))
 			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_sjt_mec2.bin", chip_name);
 		else
 			err = amdgpu_ucode_request(adev, &adev->gfx.mec2_fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_mec2.bin", chip_name);
 		if (!err) {
 			amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC2);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 8eccb080d56f..9c146e37c55e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -545,6 +545,7 @@ static int gfx_v9_4_3_init_rlc_microcode(struct amdgpu_device *adev,
 
 
 	err = amdgpu_ucode_request(adev, &adev->gfx.rlc_fw,
+				   AMDGPU_UCODE_REQUIRED,
 				   "amdgpu/%s_rlc.bin", chip_name);
 	if (err)
 		goto out;
@@ -578,10 +579,12 @@ static int gfx_v9_4_3_init_cp_compute_microcode(struct amdgpu_device *adev,
 
 	if (amdgpu_sriov_vf(adev))
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
-				"amdgpu/%s_sjt_mec.bin", chip_name);
+					   AMDGPU_UCODE_REQUIRED,
+					   "amdgpu/%s_sjt_mec.bin", chip_name);
 	else
 		err = amdgpu_ucode_request(adev, &adev->gfx.mec_fw,
-				"amdgpu/%s_mec.bin", chip_name);
+					   AMDGPU_UCODE_REQUIRED,
+					   "amdgpu/%s_mec.bin", chip_name);
 	if (err)
 		goto out;
 	amdgpu_gfx_cp_init_microcode(adev, AMDGPU_UCODE_ID_CP_MEC1);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index 8e878ab44e76..2245dda92021 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -131,7 +131,8 @@ static int gmc_v6_0_init_microcode(struct amdgpu_device *adev)
 	if (((RREG32(mmMC_SEQ_MISC0) & 0xff000000) >> 24) == 0x58)
 		chip_name = "si58";
 
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
 		dev_err(adev->dev,
 		       "si_mc: Failed to load firmware \"%s_mc.bin\"\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 347bccd92696..9aac4b1101e3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -157,7 +157,8 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
 		pr_err("cik_mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 29ce36038b3f..d06585207c33 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -259,7 +259,8 @@ static int gmc_v8_0_init_microcode(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
-	err = amdgpu_ucode_request(adev, &adev->gmc.fw, "amdgpu/%s_mc.bin", chip_name);
+	err = amdgpu_ucode_request(adev, &adev->gmc.fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_mc.bin", chip_name);
 	if (err) {
 		pr_err("mc: Failed to load firmware \"%s_mc.bin\"\n", chip_name);
 		amdgpu_ucode_release(&adev->gmc.fw);
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index d4f72e47ae9e..aeca5c08ea2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -50,7 +50,8 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 	DRM_DEBUG("\n");
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
+	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_imu.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
index 1341f0292031..df898dbb746e 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_0.c
@@ -47,7 +47,8 @@ static int imu_v12_0_init_microcode(struct amdgpu_device *adev)
 	DRM_DEBUG("\n");
 
 	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, "amdgpu/%s_imu.bin", ucode_prefix);
+	err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_imu.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index c6af318908e4..269bf1e3337b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -145,9 +145,11 @@ static int sdma_v2_4_init_microcode(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
 			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_sdma.bin", chip_name);
 		else
 			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index d438f2f7a408..c9ad9ec48688 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -305,9 +305,11 @@ static int sdma_v3_0_init_microcode(struct amdgpu_device *adev)
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (i == 0)
 			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_sdma.bin", chip_name);
 		else
 			err = amdgpu_ucode_request(adev, &adev->sdma.instance[i].fw,
+						   AMDGPU_UCODE_REQUIRED,
 						   "amdgpu/%s_sdma1.bin", chip_name);
 		if (err)
 			goto out;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 85f21db6ef24..fff5a1cdf474 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2338,7 +2338,8 @@ static int load_dmcu_fw(struct amdgpu_device *adev)
 		return 0;
 	}
 
-	r = amdgpu_ucode_request(adev, &adev->dm.fw_dmcu, "%s", fw_name_dmcu);
+	r = amdgpu_ucode_request(adev, &adev->dm.fw_dmcu, AMDGPU_UCODE_REQUIRED,
+				 "%s", fw_name_dmcu);
 	if (r == -ENODEV) {
 		/* DMCU firmware is not necessary, so don't raise a fuss if it's missing */
 		DRM_DEBUG_KMS("dm: DMCU firmware not found\n");
@@ -5306,7 +5307,8 @@ static int dm_init_microcode(struct amdgpu_device *adev)
 		/* ASIC doesn't support DMUB. */
 		return 0;
 	}
-	r = amdgpu_ucode_request(adev, &adev->dm.dmub_fw, "%s", fw_name_dmub);
+	r = amdgpu_ucode_request(adev, &adev->dm.dmub_fw, AMDGPU_UCODE_REQUIRED,
+				 "%s", fw_name_dmub);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 2bed85ba835e..a87dcf0974bc 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7709,7 +7709,8 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
 	default: BUG();
 	}
 
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s_smc.bin", chip_name);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s_smc.bin", chip_name);
 	if (err) {
 		DRM_ERROR("si_smc: Failed to load firmware. err = %d\"%s_smc.bin\"\n",
 			  err, chip_name);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 480cf3cb204d..189c6a32b6bd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -105,7 +105,8 @@ int smu_v11_0_init_microcode(struct smu_context *smu)
 		return 0;
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index bb506d15d787..7bb45ff6d5c8 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -103,7 +103,8 @@ int smu_v13_0_init_microcode(struct smu_context *smu)
 		return 0;
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 8344f54e6674..5b86df0c8536 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -305,7 +305,8 @@ static int smu_v13_0_6_init_microcode(struct smu_context *smu)
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix,
 				       sizeof(ucode_prefix));
-	ret  = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
+	ret  = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
+				    "amdgpu/%s.bin", ucode_prefix);
 	if (ret)
 		goto out;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 4d083f7f772e..9b2f4fe1578b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -79,7 +79,8 @@ int smu_v14_0_init_microcode(struct smu_context *smu)
 		return 0;
 
 	amdgpu_ucode_ip_version_decode(adev, MP1_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	err = amdgpu_ucode_request(adev, &adev->pm.fw, "amdgpu/%s.bin", ucode_prefix);
+	err = amdgpu_ucode_request(adev, &adev->pm.fw, AMDGPU_UCODE_REQUIRED,
+				   "amdgpu/%s.bin", ucode_prefix);
 	if (err)
 		goto out;
 
-- 
2.34.1

