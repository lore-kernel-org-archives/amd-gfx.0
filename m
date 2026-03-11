Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6E6103E2E7
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Mar 2026 21:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D68110E336;
	Wed, 11 Mar 2026 21:20:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iF2Ue6Fl";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010056.outbound.protection.outlook.com
 [40.93.198.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C5A710E180;
 Wed, 11 Mar 2026 21:20:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ucE/LXqruV0dsV261Cwrnpk6dVLlTY9XQWwKRJhfsToJb/WeatZ5mHszhhCMcFB5mbiVkjlA8XmDERwZ/6tDhwfWDr1fuvYC6qY3qpcYOid0aix71pR4vzFTg7N+IaQ/R79qPL5GniRR9EfokDCjdMrVddL2hzL3ayDpXteYfiJ//kulVtwFvuiljMIKbfieap0TqMCowC2yuPZ+cl0oDXlb8Oj2IXxUruUDsxhX32sRNtxh20dZcZurnJvipYyL+p3kG5P5NnKOdmnbVfeu0itMfB/Z9aQVsE1fBRXvyZwbpfTOpHqxTT2Fe67rbwM4jbMBvligwtCW1fmYGM8IfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZ8gy3KM1pW8ZXT/JdXfXDUs2rFWVy+AR7pILRXqCfE=;
 b=vdiFL4aTZ7jUwwFEAbAmhc1Eh3kLJYUx/RaydiD9kn4jfLkVWBFdEzLMbzYyFYJ0DPqrp0UbkxZVFArJCax32Q83eUlpD5/K1CZIQgcc0shYJ38WIcH25JJjBrmZObEubmvtwoEiSpOThIhiaA3Fs6ePMyuKZA8wb0BRPFUjyrWCBTx22MW7vemzhKPVOxZbFPz8h5O3Q995tbTQtIjU+UdFQ5vbDys8c+kiKSyaPr6NpRAFORSyosvi/XSCmC3HD0qytUeGwnz1TQWwEnqpvVYI8bj7TdNDrffPWSxu6iqr1bCFaWyNu5GWJk/H6rO2BTmCmD5TEFl4Cv31Gq+SQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ8gy3KM1pW8ZXT/JdXfXDUs2rFWVy+AR7pILRXqCfE=;
 b=iF2Ue6FlUgYt3A542LV1Svc4f/ygPl0M+EvmSMBcJe7b9C/ziP9wvaLnZfGCTIuuWHmM6wWqaa11TLoqJqpgCrY7ywD063VC/nAgF5/UmG7v4+OCZUFXXhz+ROFlJrvor1JnTLbaZ9WSytQIWgdxOfc48iblmEFdOqJ2ggj/2Is=
Received: from BL1PR13CA0317.namprd13.prod.outlook.com (2603:10b6:208:2c1::22)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.7; Wed, 11 Mar
 2026 21:20:05 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c1:cafe::4d) by BL1PR13CA0317.outlook.office365.com
 (2603:10b6:208:2c1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 21:20:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 21:20:04 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 11 Mar
 2026 16:20:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <harry.wentland@amd.com>, <sunpeng.li@amd.com>,
 <alexander.deucher@amd.com>, <christian.koenig@amd.com>, <airlied@gmail.com>, 
 <simona@ffwll.ch>, <alex.hung@amd.com>, <contact@emersion.fr>,
 <daniels@collabora.com>, <mwen@igalia.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
CC: Xaver Hugl <xaver.hugl@kde.org>
Subject: [PATCH] drm/amd/display: Fix gamma 2.2 colorop TFs
Date: Wed, 11 Mar 2026 15:18:37 -0600
Message-ID: <20260311211837.2482799-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ce66bb-5f60-443f-bdec-08de7fb3f6b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|921020|13003099007|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: kWMj3DtToNvEOKKxvKCkmGwstfZo3+xB7q3u9FG2uW1LXXAhs1SKAaoy9fbeWUAwPjXLBG+RAgnm6+wkf7loLbBWjMeRGEFTuMPRFGPo2kR0iOJnc3Qc1+7qXdz11kSk9l/WDc8pGxolhdJxOmTpgrYbGbFXYfhAdf+K/fPVZVJ/1wJZ8SfwuES7kRu3WJwzo2Ib8GyJ1re092IZs/FEZTliY24pfx7C2YF7RGejHGzdw1eLJOeWi3JCB0tVXY8YUlc2lFTVEZu3Vv1bfqthjJXkfOjSoAHHIfqJSc+6I/cdPIpdOhVYf9eJh75hfmmJjvJ1FnjpBbSIQCYSZ0n20u4QTG/3s76/KJxpR8T2qDgRF74xIdOokizMQQoAe0PNNepZFpGNz7JNgHJizw0YItcLljSwheXSuyGQ6IJh8QQU/zMRJdnndgeO6zjnXB8m7Bg/DmygXZpBRj8VYRtSUN5vR6Hbdi4W713y1DmleB4jm2tOejFAtt8PvwHyvyujSmPimZTX/YAGymlw4Nrvk+xgjFjGcEVwzIXvHU03P9j9EjQlh+ttouYuxEGDUtC88Orr5uiGTcfjeVcB+jzK2I+UzyRnoqZc+WJczshbjBhFgmq+/GHRRBCKuA94nxg0uiffoRA+6CDFcoqDGuKXhsnfU2CjWPUk6xd1zs3nMMv64uuqx6Ahp96uYMdOk6S819LZ27T1iBRCEwxfPLpDwSSglPTZ0OV2Z6c7AhB+jMxeLIEkAtFkAMt+IqJLnpYcS+C2tLRPzW8uVBhgqWKMTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(921020)(13003099007)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nFEdXOO5qiogz/jIRN+ch67fbH8F47/r6CCGusOpo2BuOppb/Q2yRptElbX2zFRMjE6Oagfl53hef8g4u7zLipRVF12Ss0f7jsC2uREXojWHIyY9KiL879TnEHdIvvx7Llsod/sufZRVod7gOphxJzcv8D1hCYVKML+PdSc/4ojA7PbTWjLVLktT3F16r6jqgSRyGEN6D+IrVFoB9xUnaSBzd6nZSh5v7v4fnBDha17vqajlZLhgqOt9U4Q8F8cuVVITSAMf6Y+00rLI126d9BAW9yhZBt1VR8JelHQuq6yRkHpMYCioWFhQGWDi7A2A4lyDM0AIXQRSEWRE9Wakx5EZ5uKUckCjvPHMVNbKddPzUNq9HqfwZwCD/LIoBnolLJVlut5uxCm7kzzT7jUHigy1l3zPH9dmgjAFI63MSkyxtqLgudMkJyDTzHrqZoWp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 21:20:04.7785 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ce66bb-5f60-443f-bdec-08de7fb3f6b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
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

Use GAMMA22 for degamma/blend and GAMMA22_INV for shaper so
curves match the color pipeline.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5016
Tested-by: Xaver Hugl <xaver.hugl@kde.org>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
index d59ba82d3d7c..aa4658867e55 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_colorop.c
@@ -37,19 +37,19 @@ const u64 amdgpu_dm_supported_degam_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
 
 const u64 amdgpu_dm_supported_shaper_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_INV_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_OETF) |
-	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
 
 const u64 amdgpu_dm_supported_blnd_tfs =
 	BIT(DRM_COLOROP_1D_CURVE_SRGB_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_PQ_125_EOTF) |
 	BIT(DRM_COLOROP_1D_CURVE_BT2020_INV_OETF) |
-	BIT(DRM_COLOROP_1D_CURVE_GAMMA22_INV);
+	BIT(DRM_COLOROP_1D_CURVE_GAMMA22);
 
 #define MAX_COLOR_PIPELINE_OPS 10
 
-- 
2.43.0

