Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C82ED2F7F3
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 06:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1C8A10E7B2;
	Thu, 17 Oct 2024 06:49:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sdUD5GDi";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C92910E7BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 06:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Upaz4jC31Y2T1KZNYkgWzBDpoX26cTB6atXYuo0GxnSEiGcMCDUWx0/30hQgo8FdHo/c9DjKL5h6eraKzCU+zvBc26A05UPJzd+qZxXG3RLhaH3N+d/JpEaBgGcx2IMHJvdiZkDp1YwMprf+uesv88VBWjz/iyOfViZ71fiRImUQRVK9Vqld+kKeScDQfqDKZ8AUbkNz5e9Thgl0NvYpNAS4AUQ60aJPEfTsNY9KinTY5ZszMpeLXRjwZQYmw+5WYMKYTA3iBqtb0ZcYTlbja20pUVt9+rVccttW4FDN/ldGRDEYFXQRX/0UlzbqAzTqfFlze862ViF0Pdactt4I4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDxHFYDSGPmYHxrLE2NClvh4Uk7wQfvc9PzUXPF980U=;
 b=yrZpFPgQ6zzZbFMHANmDZ3Mj99BLlwPEjWO98XIpzfplNx5aCfK5btGE3X6syQd/KX0lM9VQuMb7hCkV8KRPGtmkfi5eg4R2M05O5YbTGgXhxHTROtDhn/q75LDCOZGVpgg+vSYVq57Oje80rdGPX4q9HXIP3KsHUAg+3vzJPSKdgip+XBWp0XCGcqrvJbh868K6zrnfIsrJmF+2yfKfi+Jx4eKPsPJ17Y0GfWfa7mmz/703ltpBXAx56u2KGEye0FJugMaTfhfm862a96ECepfSq/Ne/phM85XNBa+D1UxJsJRjiGSxMzB0a3lf6ideU9N+7WMqF12vlvM6TW8wYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bDxHFYDSGPmYHxrLE2NClvh4Uk7wQfvc9PzUXPF980U=;
 b=sdUD5GDiogsBOPfA3/ItPgNUGmuPu7WGjYZonjmAdNpIZQrz1hRC6FM3fVpj98kBomfnXVfZ1ruhB1PEauRKP+Jsay3/vMiUUI8Q5u3jhQPpKNtHgoCC9WnlPjrAyITc0+bs7sCuYbwa1CzUucvbVqoW5+t6WheIoA7cvcscVKc=
Received: from CH2PR05CA0006.namprd05.prod.outlook.com (2603:10b6:610::19) by
 SJ2PR12MB8944.namprd12.prod.outlook.com (2603:10b6:a03:53e::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.20; Thu, 17 Oct 2024 06:49:29 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:0:cafe::f2) by CH2PR05CA0006.outlook.office365.com
 (2603:10b6:610::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16 via Frontend
 Transport; Thu, 17 Oct 2024 06:49:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 06:49:28 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 17 Oct 2024 01:49:26 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx9: Enable Cleaner Shader for GFX9.4.2
 Hardware
Date: Thu, 17 Oct 2024 12:19:03 +0530
Message-ID: <20241017064904.3500946-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SJ2PR12MB8944:EE_
X-MS-Office365-Filtering-Correlation-Id: 600ab0ee-1c16-4d4b-c571-08dcee77d90e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkEvczNOTnRJZ21HSnRzaVhvYUc0UTRjZTBRV2ZMT2xWa1lpTk5IeXZPSHBN?=
 =?utf-8?B?UUYveEZmY3lMVGRiU0xjaGV2aXVveVZOMWZnMHN6RkxaZUVpSVBvbEhCYTlW?=
 =?utf-8?B?aHFDYTNCcDhBa3lWV1N0aTRBOEVzMEZCaDduYTY1cjBTcUthWk5iT2VHdGdG?=
 =?utf-8?B?c0xwZVdYWEQ4MXlyVXFTTGVDQmkrZ2NIRHg1STlnQjFCeEVmVWtwclRoOU05?=
 =?utf-8?B?b1ZTckJkN09UNVd3Q1dBZUo0T1FZemtrWExuajV2Qld6RnJFNFNQZitEckRC?=
 =?utf-8?B?NVFVc2l5czZqTXRrbXhESncvM01aSXpRQm9HdkxzT2hqN29SVnczTXB0bTV5?=
 =?utf-8?B?ZVlzY2VGTzBHdVhwaXhKNU1qQ2h4TVBabzZQZ3NFQW1vYUJvb1hGaytGVExl?=
 =?utf-8?B?S2s2S0NWdGhXZDMwZDRRTVo2dWEvNlFnUUtoL1hNSk1LcnR5aFh3WGVBaWJN?=
 =?utf-8?B?NFBMOXlscU1wVkxyN1VkK0ZrcE82UzR3YnRtR1A5c3lEYnl6WEMvajh4S2pE?=
 =?utf-8?B?bTAyVFNxT1NSVE02V3Z0UWdHVEZwM1N3UERKVGtBVkdCeStadklRNU4vNm5R?=
 =?utf-8?B?VS9NMVgvZ1BTem14cFJhTzBrQ2d3aXJobmllQXdQQ1JSMUdZMDIzNzNFUG91?=
 =?utf-8?B?bGozck9RbFIrZ3BWNjREaDc4Wm9BeUFRU2ZNSXNBUW5jOE5jY2JrT2I2KzhT?=
 =?utf-8?B?YmhPUnBsNUVNWDRTcXoxWXh2d3dJN2dXMExyWldBYVB6WlA2bHRNTWI1MW1m?=
 =?utf-8?B?QzR1VkFJU0hoQ2pGSlVvYlh4SG9ydGN4NWZibEZrQkNocVRuYnE1anRpNVE2?=
 =?utf-8?B?YjBjWnR0azV2a25XOE4yNUQwZTliMEo1bHkrQVR4WkoyZ01XcWFoRDczRFFj?=
 =?utf-8?B?aGNMT2haeEhBdnJrTlY4emxTaVNyM1B6aUNUTDFsenZCWjNwTW5MQlQ4eHVC?=
 =?utf-8?B?czNvSG5jZGNpTk1Sb1hDOUhQU2VUM1ppZFh6RDR4UEpnNDRTZEVFWU9iakh5?=
 =?utf-8?B?TkNsTlVUSkpZUjJFc1JmVGVaVVZkT1ZVUHl5cFNxVW8wTUdvVUk5TU12bWJ2?=
 =?utf-8?B?MzA1bzEvek1oYXRQTFMwalUvejhQNHJnZmZwREJYQnU0MktmRXFkMHhLa25y?=
 =?utf-8?B?eElqSkxXZFJGSzFDam9yQmtSMEpBeTM1T21tay9KeFRHcXZPSTJuTHFuWGZY?=
 =?utf-8?B?MlFNakNyWmVUS0NVT21QMGh4bjYwZ3JuK2RJVG1UNzZhMzlMNWNLVG5PMncr?=
 =?utf-8?B?cHRrQWFMWUtwditDRUtPZ283RTJ2TWd2Nzh0d3dQR1Rncjl2d2hub1RjckVQ?=
 =?utf-8?B?YlEvRHNHaUIxTlEwVzJyVmdOUGhmZktSZjFJNk5RVGVXQ0xQRVpEQUsxZTJL?=
 =?utf-8?B?T3d5VjJWM1d3d2Z4UXNKREVXWDlMNnRNeW5WRFNubitwOUtWcVY2Zm9iWU1X?=
 =?utf-8?B?WVJ1VDc1VFROZmVScTlwY1NWUFB1bUNOM3pidE1QMjBqRFpKV2I3TzN3aFdQ?=
 =?utf-8?B?dkUvZVFtVEFXQjNiZzJSdEVHSnVDNHlHa3B6Qk5qV0YwMUdvTFlYUEhNbTNy?=
 =?utf-8?B?WlV4RTM5aDZVWUJ5dnhzZGRyOGVka2hKa3JObVJiL2lSeTNoblcya2syUUU3?=
 =?utf-8?B?d0dDenNkSEtWZkw5Yy9JZ1lpWExIcVZLbjUzM3ZsSlFZK0VZOTdEdzRHYSto?=
 =?utf-8?B?NHJMT1FpZ1BzK0F0VmxGVUdTWGxWTWVOTlBlRG9JemVuUzExM3hsZjA2WUla?=
 =?utf-8?B?QjZyaWtTZXhURWpMb3Z1cG55VG1jcDk1OEczOUdKbjh6QXJlZE8wMzFTWWF6?=
 =?utf-8?B?Ni9jYTVYRUtJbzJyb0JrWHR2Sm16TTc2b0FZUm1RcXplZ2dqZU9FL0pvOUpX?=
 =?utf-8?B?dER1TUFGNWJyTWRuQmpEcWltOFB5K3FsYzZTYVQ0dGxmckE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 06:49:28.8973 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 600ab0ee-1c16-4d4b-c571-08dcee77d90e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8944
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

This patch adds support for the cleaner shader feature onto GFX9.4.2
hardware, as part of the leftover locals feature. The cleaner shader is
important for ensuring process isolation and maintaining KGD/KFD
serialization by clearing GPU memory before it is reused.

The patch updates the `gfx_v9_0_sw_init` function to initialize the
cleaner shader if the MEC firmware version is 88 or higher. It sets the
`cleaner_shader_ptr` and `cleaner_shader_size` to the appropriate values
and attempts to initialize the cleaner shader.

This change ensures that the GPU memory is properly cleared between
different processes, preventing data leakage and enhancing security. It
also aligns with the serialization mechanism between KGD and KFD,
ensuring that the GPU state is consistent across different workloads.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c                | 12 ++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h |  7 ++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index b4c4b9916289..66947850d7e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2223,6 +2223,18 @@ static int gfx_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 	}
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
+	case IP_VERSION(9, 4, 2):
+		adev->gfx.cleaner_shader_ptr = gfx_9_4_2_cleaner_shader_hex;
+		adev->gfx.cleaner_shader_size = sizeof(gfx_9_4_2_cleaner_shader_hex);
+		if (adev->gfx.mec_fw_version >= 88) {
+			adev->gfx.enable_cleaner_shader = true;
+			r = amdgpu_gfx_cleaner_shader_sw_init(adev, adev->gfx.cleaner_shader_size);
+			if (r) {
+				adev->gfx.enable_cleaner_shader = false;
+				dev_err(adev->dev, "Failed to initialize cleaner shader\n");
+			}
+		}
+		break;
 	default:
 		adev->gfx.enable_cleaner_shader = false;
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
index 36c0292b5110..cfb73e729b0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0_cleaner_shader.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: MIT */
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2024 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -24,3 +24,8 @@
 static const u32 __maybe_unused gfx_9_0_cleaner_shader_hex[] = {
 	/* Add the cleaner shader code here */
 };
+
+/* Define the cleaner shader gfx_9_4_2 */
+static const u32 __maybe_unused gfx_9_4_2_cleaner_shader_hex[] = {
+	/* Add the cleaner shader code here */
+};
-- 
2.34.1

