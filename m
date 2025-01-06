Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95598E77188
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jan 2025 20:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40D9F10E0F5;
	Mon,  6 Jan 2025 20:33:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cuZH+9o2";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1734610E0F5
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jan 2025 20:33:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lj4DRvB1lttF3VSU4gjPM5jq0xAAKo326HqixQwKNBEuS5wwWYGUd4Q5V5HppGP7nS4BbR/6075IPTEPOpqFNJ+Yp316O1d6voUyZ+AdCpMOAJPIXzPNRb2jb9PIJaIqtPL7BgxvULnyLRZ1Z5yiI0rOqLKoRJib3Yy1HqB7pnem4odrwc3NWDCAA/otJtg4PGA8/sX8guC1hF27HmpOSqZiEGtuzIdyjT5Phwa7Vg9GEWdnwj3KMEeRhhySFCkE/oQCnPeqLgbKj2U3q2geQBJXwSaSm1NQNo4249HqrGLwMbyzsgR6QNyh0Bca3zwNNf7gGb6A9uS0BvNeUZrJZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b8Jj4FN2Qo7b43nlbQiWT8RfziA50wuFb+RtnQQ6T2Y=;
 b=Nn8pXqRFzv9NOjlNz5VspCxSkz8Uj1Uo5JiYMlbHxrH8Tjsp0B0QJ9y8RTbTEJ+tXQGJ2Qzj66A5rnb06OGHy9HBQ3/AfOmeY9lRwRG9bfxIQTZhymHvogAflBmMfIJOU37HXoWy1KPJ4JWY6CxkHadQ43EhRzrJ8lQA2YwXbP02zfvQp7TkS/dF3qE8wcGdC4uMIgoqkobAlx1qakHvlo9uQ5yjoUEbyUmga8AARWGKdBAQShCzO7+AO9mKvz/RXz+K36bmjLoWyN6W9ZvBy0/j992rWatwfb4z4kichLUDGqgvYI4MGiGN0qhyS9SgOdrLYJSUUUdKbhR/D3pV/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b8Jj4FN2Qo7b43nlbQiWT8RfziA50wuFb+RtnQQ6T2Y=;
 b=cuZH+9o20tQ10zvoUxxjNGAXqfLgKzfHVHG8czPqUIYKgsi4giBZSjvC2FRIdlFIrYq7hEOTrU5wc98vb8ACvamsO4g7k0rL7IBmG5YsnsGjf4GqN4pjkMC4VLHnXVhamuHGH/cMw4Dp945fmT/AT4tsgZi5ogX3fwzEz9PAAik=
Received: from CH0PR08CA0023.namprd08.prod.outlook.com (2603:10b6:610:33::28)
 by SA3PR12MB9227.namprd12.prod.outlook.com (2603:10b6:806:398::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 20:33:33 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::b7) by CH0PR08CA0023.outlook.office365.com
 (2603:10b6:610:33::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Mon,
 6 Jan 2025 20:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Mon, 6 Jan 2025 20:33:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Jan
 2025 14:33:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 10/10] drm/amdgpu: add OEM i2c bus for polaris chips
Date: Mon, 6 Jan 2025 15:33:10 -0500
Message-ID: <20250106203310.3349585-11-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250106203310.3349585-1-alexander.deucher@amd.com>
References: <20250106203310.3349585-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|SA3PR12MB9227:EE_
X-MS-Office365-Filtering-Correlation-Id: c2a1317a-25cb-46a8-2137-08dd2e916361
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?J7j2wBqPm4twGCQO0qTImug9jq2hg9m/oFrBooIhl11IZKszwwtVI3eL+mVW?=
 =?us-ascii?Q?K2UzC4QMUG5q7YOvTHj61VIM+ovu/MZrZ8enJoY+EFapkPwqkTw0lnbUZOO/?=
 =?us-ascii?Q?cVh55xQBDIhoeKiPPfe8liN2VIxeI8wnGYMkOajvLpHIdJ5Qlya6mxb1Nnnd?=
 =?us-ascii?Q?15g1VjdYK2xI+NOPYnmg183hNSwXx1Fh4n53BKk/00JwBo6X/cPMbRdqh7zT?=
 =?us-ascii?Q?7+DdMWjNBo0eZoewUkRmyBQcKjiAwgZ9SMt/bihyLtKHbE+LKjFsDGUG6Ze9?=
 =?us-ascii?Q?gyQaVzmg5BhDhhHMccUtnnlKluSqFGUbUS1CiZFAbqHaMMZe9BO7Au15Mm1C?=
 =?us-ascii?Q?+RLCeQDJNCZKZqkhUPFTsg0PbhYRhpqRUZ8E2HEf7GmKHIFVUQI+on7+69lL?=
 =?us-ascii?Q?LIb26HYy3ohGEW5DzR7Rt/nFRlGTsr6+qdmg5ONFQ03xB8ZV84+5PlZbRRYz?=
 =?us-ascii?Q?kKExgqakYTZ5FSI0fWkzOtGvCPM3JfpYX2qiXrDq/8VREo+vJ/adQn21VF9d?=
 =?us-ascii?Q?h7+xEyjwRmHg8bwlyIACbtVGr1QSNM0dYnXU0ogJ71w2msXRcLpiChBhQVHs?=
 =?us-ascii?Q?mlV9TEZDIWe/ILCWTDfF/cxkxbklhRiRu5MvhPL8v7vwjpEUq1qubwxLwaOA?=
 =?us-ascii?Q?1nACjykvggpq1me/qZnxbos1fS6uZJGO+M1VkxUJvvxECnoMyaSQxrz0w6Na?=
 =?us-ascii?Q?jtSCRRNAZdTDHP/trA6F+p4tIfa93MiYitSXMezgqy62a2TYTlc/kEsXh3EB?=
 =?us-ascii?Q?UB04zm5epAN6/rfjN+ocwtmU9RgdcLsXuweCBpaZLOSxQrVN9VAefgLQahUI?=
 =?us-ascii?Q?A+PFkiTxhyDSiyNXifGc+MXspEPlqEFqMLeWOBG0JDbBbtH78rlXt307zLap?=
 =?us-ascii?Q?054onJxlyLhemMVFRVSdl5kbd95f52vGAdEt0fLNI9+Cg9kRC/g9VQwP+XNJ?=
 =?us-ascii?Q?JRRIM6S+OCqY6SbITYl82nNo547yXWK3li8swxbNjJVSR2A320SUtS4cqUDo?=
 =?us-ascii?Q?k/hi8dUGeNXBdDQ0msTLHLZv6kRIeYmU5PbwaadoW/U/Y1qebHOVEBrjamGi?=
 =?us-ascii?Q?emLyY4QSLk2duLDGLO9K4VBGc+M35QtqgN6T4HlLQEYGXyKtyOSvtDVJgeOz?=
 =?us-ascii?Q?72firVtjQ1YDjPodCpCvfm9AZVhxwG5wBEg9Kj+IssUWwc5klYcfXMJ6ddLi?=
 =?us-ascii?Q?kECJBlH534aFNuAuxQZ7bI4j3eZ23/JqO+f/htqBOaI93vv0vD7DNNdwPvM6?=
 =?us-ascii?Q?k2TD0MRLbTwkepmOCo6nWoynEuuZLRF6j9Yvi6+U4aoblkXwh8A+aCDq1eNq?=
 =?us-ascii?Q?8rfS/5B9lmIyLxWmN352aKFsY1eEh2mwspJuVR3X6ZCerUyXbdug5dmw52LS?=
 =?us-ascii?Q?q7K0vjicoXvc7ATjozN0BEFPDnu6zONAIjF4zMwxlMXsgFndJGD7vuwOV0A9?=
 =?us-ascii?Q?f2aFnReS1OXRHxkaG6/rTG8WZstlkcIqPOZlIxmS4SbG6uVqK847bA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 20:33:32.8142 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a1317a-25cb-46a8-2137-08dd2e916361
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9227
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

It uses the VGADCC bus.  DC doesn't use this bus, so it
is safe to add it here.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 32 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c      | 13 +++++++-
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 263242bd7c10c..e476e45b996a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -144,6 +144,38 @@ void amdgpu_atombios_i2c_init(struct amdgpu_device *adev)
 	}
 }
 
+void amdgpu_atombios_oem_i2c_init(struct amdgpu_device *adev, u8 i2c_id)
+{
+	struct atom_context *ctx = adev->mode_info.atom_context;
+	ATOM_GPIO_I2C_ASSIGMENT *gpio;
+	struct amdgpu_i2c_bus_rec i2c;
+	int index = GetIndexIntoMasterTable(DATA, GPIO_I2C_Info);
+	struct _ATOM_GPIO_I2C_INFO *i2c_info;
+	uint16_t data_offset, size;
+	int i, num_indices;
+	char stmp[32];
+
+	if (amdgpu_atom_parse_data_header(ctx, index, &size, NULL, NULL, &data_offset)) {
+		i2c_info = (struct _ATOM_GPIO_I2C_INFO *)(ctx->bios + data_offset);
+
+		num_indices = (size - sizeof(ATOM_COMMON_TABLE_HEADER)) /
+			sizeof(ATOM_GPIO_I2C_ASSIGMENT);
+
+		gpio = &i2c_info->asGPIO_Info[0];
+		for (i = 0; i < num_indices; i++) {
+			i2c = amdgpu_atombios_get_bus_rec_for_i2c_gpio(gpio);
+
+			if (i2c.valid && i2c.i2c_id == i2c_id) {
+				sprintf(stmp, "OEM 0x%x", i2c.i2c_id);
+				adev->i2c_bus[i] = amdgpu_i2c_create(adev_to_drm(adev), &i2c, stmp);
+				break;
+			}
+			gpio = (ATOM_GPIO_I2C_ASSIGMENT *)
+				((u8 *)gpio + sizeof(ATOM_GPIO_I2C_ASSIGMENT));
+		}
+	}
+}
+
 struct amdgpu_gpio_rec
 amdgpu_atombios_lookup_gpio(struct amdgpu_device *adev,
 			    u8 id)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
index 0e16432d9a725..867bc5c5ce67d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.h
@@ -136,6 +136,7 @@ amdgpu_atombios_lookup_gpio(struct amdgpu_device *adev,
 struct amdgpu_i2c_bus_rec amdgpu_atombios_lookup_i2c_gpio(struct amdgpu_device *adev,
 							  uint8_t id);
 void amdgpu_atombios_i2c_init(struct amdgpu_device *adev);
+void amdgpu_atombios_oem_i2c_init(struct amdgpu_device *adev, u8 i2c_id);
 
 bool amdgpu_atombios_has_dce_engine_info(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
index 72f73a186dd94..8179d0814db99 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_i2c.c
@@ -228,8 +228,19 @@ void amdgpu_i2c_destroy(struct amdgpu_i2c_chan *i2c)
 void amdgpu_i2c_init(struct amdgpu_device *adev)
 {
 	if (!adev->is_atom_fw) {
-		if (!amdgpu_device_has_dc_support(adev))
+		if (!amdgpu_device_has_dc_support(adev)) {
 			amdgpu_atombios_i2c_init(adev);
+		} else {
+			switch (adev->asic_type) {
+			case CHIP_POLARIS10:
+			case CHIP_POLARIS11:
+			case CHIP_POLARIS12:
+				amdgpu_atombios_oem_i2c_init(adev, 0x97);
+				break;
+			default:
+				break;
+			}
+		}
 	}
 }
 
-- 
2.47.1

