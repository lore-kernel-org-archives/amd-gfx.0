Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1B0D5E15F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 11:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F07A10E96A;
	Fri,  8 Nov 2024 11:14:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aNgK7iwO";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD81F10E96A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 11:14:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwmiJHwwoy5rCfBex5c0xFRw2Ekh2xc3sefAayUzkTSOIdBPb6NcbwRMVFlDeCSNmYYVuL0VVW4sirkug/abXkUITXOvqkQrjpg4phMkOQ6Aak4R4HWVqNGjReLKbym+mJ++RyqhRLahv3LjuzjO1P7AW2UsnWu53385Szjdci31xVEMoGym9Sp2+qbTTMDlHtYTXUjploUo33ggD0Ezv7ooTr0YJwqxNC3dvBUWa57MJjivQaSznVaSERMh5Z/4xI4vVYyzhL3i/MQABzVU//Artw97Uv+0iBrZ8MFB4MSiGQjiOtFjNbsW75wHbZQl35yX9O+TVY0wS77imwkpLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1EdaBB5/WjVoNMvv63dVwqdeaILVqo85OwUiYA19CE=;
 b=Mp18mI05S3InxaW/oL3B1lRqjCrVM17CiLvqlXNvu8yFJtRMUAbKwSYWTS6IytdqKXGzQLQ+v9nmFGeK7O8rjS049pZs0uJy9qMYsNHPXimeobYfWa7aKlwpGcS7RUw/Do7kb+fH3WeDcPFxzNh9LMMud0Vtlp20mMhwRW/xGEyTKlwbhnGXj6WVCIZ/8a/Coljqx/bshJsA+xa0lvWCPENWOs2A3yGcO1a/2WtCEYaLzybRsoPvyeswyL0bVJWcptcHy2SRL9ywSuL7e7BWm7ylYyuzHP23IOoj7XirEx+cG/IsfteXcjKsTdlcL3vQp3LQqvMq+hkcfn18HB6/Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1EdaBB5/WjVoNMvv63dVwqdeaILVqo85OwUiYA19CE=;
 b=aNgK7iwOR5I3RmOnQK0BvW35N6WxVVrwQGyv+SuXsquUB4AXACMqYCKB9VFnR/dAL821eRib51X3yU3bguoFPdv8AmPLp0kCsa2N1yMrhQ8ZTZk4hN3AN/s+vAIF03mCanIIhjGCLpQaA+ItA8kqxPuXp3z5SQT2P8F98flm++8=
Received: from BL1PR13CA0183.namprd13.prod.outlook.com (2603:10b6:208:2be::8)
 by CY8PR12MB7146.namprd12.prod.outlook.com (2603:10b6:930:5e::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Fri, 8 Nov
 2024 11:14:52 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:2be:cafe::3) by BL1PR13CA0183.outlook.office365.com
 (2603:10b6:208:2be::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 11:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 11:14:52 +0000
Received: from tao-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 8 Nov
 2024 05:14:50 -0600
From: Tao Zhou <tao.zhou1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 17/23] drm/amdgpu: add a flag to indicate UMC channel index
 version
Date: Fri, 8 Nov 2024 19:14:17 +0800
Message-ID: <20241108111423.60169-17-tao.zhou1@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
References: <20241108111423.60169-1-tao.zhou1@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CY8PR12MB7146:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c182220-fc03-46e8-f17d-08dcffe69144
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sUSOM3uO9pByc/5x7ayN/hoJ6l74/go39dVLzUSyX+ziGhN/R0+xnVmIvY/N?=
 =?us-ascii?Q?f4avUxDv9EvKu+9MlBRZciqU9ZyBRQq3LzMzSwZZ6TYAwgNWjm421A4H0ncB?=
 =?us-ascii?Q?I/c4DpVnBWGE9pUp96tYs3WH2J4ei7SMGaoz+YSlGUBqwsVLks5l9AU4D+M3?=
 =?us-ascii?Q?KDe4bIJXa1Jjgd6bM0MgO0jW9WtuntaDJw0zK7Kgkuxl4mujJf1GtZSN77kY?=
 =?us-ascii?Q?GM4CSWstRzSS3lTu6DOdLSUzIDDiUEtWDNebBobcaTJd9uExLj8dYBvH4/fr?=
 =?us-ascii?Q?Zqsf15nLnSyrOqCy8BhYQJDQCiaGJf06qfo2NCSpPRvPbX2rFTyrDQhF6iyG?=
 =?us-ascii?Q?mv9gn/k4UOCxtIMrvSzptaDPP7nyhrkduz9E91Yj2DvQTk6GSpLF1PCxjujx?=
 =?us-ascii?Q?biRyhuGqLwT5jpLOIIRWeWcOk4Z7Sv3OBVGFGdiQ7EC6Hh89ypXxxnonTYdg?=
 =?us-ascii?Q?tEoaB4e2s4By+Kd2DqmGK1vJ9fgob3KO1GLJMPQ8pZsT8ZoLuNqDday0OxPu?=
 =?us-ascii?Q?nyACDEzdSy1Ja6s3FC5pOEbvFBtgTmpn7Bl5Y628rTWdUjq8A2bpWNN7ISt9?=
 =?us-ascii?Q?YLaMCvYXrWyPT1M9oUu0BrQjiBSrHtlQkhLACq+BdA6e/LOTw4+d4eu3HlFH?=
 =?us-ascii?Q?D0qnaK4TIB6lfA7F25IgXZ4JR74THt1nfQ+9mBMwceEmwEBS+3PwuVr3N/n0?=
 =?us-ascii?Q?IOwAZL/gUBM/oyK5CRC4GIa/avofPFp9qEQ2z6eG0H+I2n8OCoYjNJQ1YiBj?=
 =?us-ascii?Q?et21sbGVsSPdFl6WxBmA3v+uj8K+gCBj8/CRWWXvXTqVUfBAWF5X79zAl7iF?=
 =?us-ascii?Q?fHm1vfCm1VLdPiFS52xaq2/yjlMplNliizAoRvsg58NbWuMAlU/NDqFF1qzq?=
 =?us-ascii?Q?b+yRwbxTUv/vMu93HU/MvVL9itvDMIRvT5eQcodbfQACUFmTxKJn6eh6TUmi?=
 =?us-ascii?Q?eYqn7DC52Hnk+qUUYGf7agAN/uC7vUlWs/16nGouLM8c/tVwS5h19z86YAR4?=
 =?us-ascii?Q?+FvknpQIlGwnIbMJeEP2ogmafpXlf02RPK6QL+7HCGBuylI3Ak2Un9Wxywre?=
 =?us-ascii?Q?atnCHT54OZmKP04z1SRjxl76nXsvqx269VLKYecy9wljPA1eLI8aowKMXLGq?=
 =?us-ascii?Q?2oezkbud8c3vFowUJ+WowH4nFs0L7Mq5+RcAUcypjU5ZjSyAeFKKfU/qg45z?=
 =?us-ascii?Q?sl8PUCyKRivxsUCMYi9y4P1rNOmsLQ/ETUDvhYrBHBg2vQeQ9YsY37OBFQon?=
 =?us-ascii?Q?WJOy7Uj5AsepUSKO7EqV27yTf8sUWtd/xo0mW8c05mfFQeh8moK2Jl8Cbg2W?=
 =?us-ascii?Q?kQvu7AgRF8I5k6rM8LgOWTxM11h3CV/mobuQq2vaSAQCRFTDRGZGLvW45B2f?=
 =?us-ascii?Q?YNKuBcdy6QOUCJuwXXYO34KO6Q9IDR+IyUEIiK4Go9Iva951NA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 11:14:52.3918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c182220-fc03-46e8-f17d-08dcffe69144
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7146
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

v1 (legacy way): store channel index within a UMC instance in eeprom
v2: store global channel index in eeprom

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h | 16 ++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index ad0fbdb01a89..bb559b521a9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2838,6 +2838,11 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 	/* only new entries are saved */
 	if (save_count > 0) {
 		if (control->rec_type == AMDGPU_RAS_EEPROM_REC_PA) {
+			/* set the new channel index flag */
+			for (i = 0; i < save_count; i++)
+				data->bps[control->ras_num_recs + i].retired_page |=
+						UMC_CHANNEL_IDX_V2;
+
 			if (amdgpu_ras_eeprom_append(control,
 						     &data->bps[control->ras_num_recs],
 						     save_count)) {
@@ -2846,6 +2851,10 @@ int amdgpu_ras_save_bad_pages(struct amdgpu_device *adev,
 			}
 		} else {
 			for (i = 0; i < unit_num; i++) {
+				/* set the new channel index flag */
+				data->bps[bad_page_num + i * adev->umc.retire_unit].retired_page |=
+						UMC_CHANNEL_IDX_V2;
+
 				if (amdgpu_ras_eeprom_append(control,
 						&data->bps[bad_page_num + i * adev->umc.retire_unit],
 						1)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
index 2f71194d5da8..f97c45b4eeb8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.h
@@ -54,6 +54,22 @@
 
 /* Page retirement tag */
 #define UMC_ECC_NEW_DETECTED_TAG       0x1
+/*
+ * a flag to indicate v2 of channel index stored in eeprom
+ *
+ * v1 (legacy way): store channel index within a umc instance in eeprom
+ *    range in UMC v12: 0 ~ 7
+ * v2: store global channel index in eeprom
+ *    range in UMC v12: 0 ~ 127
+ *
+ * NOTE: it's better to store it in eeprom_table_record.mem_channel,
+ * but there is only 8 bits in mem_channel, and the channel number may
+ * increase in the future, we decide to save it in
+ * eeprom_table_record.retired_page. retired_page is useless in v2,
+ * we depend on eeprom_table_record.address instead of retired_page in v2.
+ * Only 48 bits are saved on eeprom, use bit 47 here.
+ */
+#define UMC_CHANNEL_IDX_V2	BIT_ULL(47)
 
 typedef int (*umc_func)(struct amdgpu_device *adev, uint32_t node_inst,
 			uint32_t umc_inst, uint32_t ch_inst, void *data);
-- 
2.34.1

