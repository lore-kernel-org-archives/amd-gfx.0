Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AF99CD4F3C
	for <amd-gfx@archiver.kernel.org>; Mon, 18 May 2026 06:59:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D215810E683;
	Mon, 18 May 2026 06:59:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i5cbDJha";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010023.outbound.protection.outlook.com
 [40.93.198.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A862F10E683
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 06:59:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C1QXILCmpKFvfZ9YFH3HmAEuZtEJKfXQ1Y/fIMqH9wWIePRRpNKSU2Pzopgh0xREGgfVis47OdbDDzISYOax8+xnWn4+2dJvG3xiXKFVfNe99D1Gki5eID2awWh84MGVq9eXyK8e4N5zN4sDV0CvBY8XCpZAI1OaMedWudt/3Nwa6AmvB8jVAwfMhqC7jLSagTOCrsH/bDMJrajD7/0AmYdXqzoc+D/eLoYCPD8jDsVqUr/ZMUvE1e4Z3aZfMVFOnd38edBeASIVnsfyZjdyOxjKD9ZmjHY7YO/vvib5GzasAL2Pymw+Yj/c/1QYNxVBeK9l2RQ8+eKZ+MQYt9GjAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=InnnDzpzgEsWd+7wKZjGX173YwkutLXScVyGDnsEUUE=;
 b=gNqVJKveDHLuqDysr8yM2PTrq7XNl64dQ5U19JX/jgALUG6zR5iU5NGISh3SbR/CBS17Zukced8fZd8IXRVMn4kne91M18NMOHmhEqSv000uxmthnQ8Y7nSjfN6/FNs/1NpMCRE4ZczTk6Qxu4Iz12NKljGdlc1tXe0JH41JltLYNXJl5R3MXvjSYKL40waTNxP1wh63XoqY/BFd1r07caIe4xkuJNON/kse0sca0RSW+L81UVLlt/Y812GmvHx1ZLbRJ/104gL2iNe6uMuTh1kBC/vQ1CWFHRtIecMiO6iHdQClhtknWx50qNeiBxCwanyYRXe3qJm7z3iJgjFmzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=InnnDzpzgEsWd+7wKZjGX173YwkutLXScVyGDnsEUUE=;
 b=i5cbDJhasZbSI3Q69hsF2LjMob19oUBCUBAC6aabluFGrSr8C72rr9F1T0Y9JXHOHekHAKZb9rDjfx3lAxs06GL0ha0fsdvu1BvfQlDtCkcZ9EXNmGhDDE5Vicc2jqpF6+pHS4GDNvZO4l3f01C09uhlaCvryXCP3gq8P9wtdCA=
Received: from CY5PR15CA0088.namprd15.prod.outlook.com (2603:10b6:930:18::29)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.19; Mon, 18 May
 2026 06:59:26 +0000
Received: from CH2PEPF0000009F.namprd02.prod.outlook.com
 (2603:10b6:930:18:cafe::2) by CY5PR15CA0088.outlook.office365.com
 (2603:10b6:930:18::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Mon, 18
 May 2026 06:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009F.mail.protection.outlook.com (10.167.244.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 06:59:25 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 01:59:23 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <stanley.yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH v1 2/2] drm/amdgpu: Fix memory leak of i2s_pdata in ACP
 initialization
Date: Mon, 18 May 2026 14:59:15 +0800
Message-ID: <355e38deb2eec64909f771db7a9e9abfc832fbcd.1779087459.git.cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1779087459.git.cesun102@amd.com>
References: <cover.1779087459.git.cesun102@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009F:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: b36d4a83-65c8-4f4a-e9a1-08deb4aaff95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|3023799003|11063799003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: QS1Qeeg8L/JzmWTurCcVYksqh+9Bgfp3R49pMlYsg4J4VEdD9Gzdgt3jET9WJN2UYLD/LA4WGDeWVgoh6X0z4FiEPnPB19HDFUWNqTILx72vraoHFJ4hvYlQ8RvvLib29DP+ycM13PBm4gEHwwAzJq/Kdc/bThIDwuDh3Xy+YUv798rHh8FDdyp+JtZfBpZFbWwKDsfyjfk81wQl7gwglCEQbIexTbFW1p0CuRXc2NkefFVREYQz1VRh7P4DIZKr+WCTjIKUs4J+mIc8+Ll2BPiRQdQ/pzBOOeTamrbdkZ7B77Vebfg8EJ5LT9kvIvTEvoG8vr80TYlSiFz9UUupyrZX3sBgYGTyYwR/FBDmGsCTkm3o1PEZSPuNUnvPGDs3tWwsw/X8HnaswPNWaURizh88mCBW/XdX+c2QTSLCmYTYSenEYcW4BfdiPwOH1dVoRhLbTYykplFNphER7qcewnNvuyVQOp03vtlzRXki/+LwhyEsBufPUBFysGaaB7nu3itsz68OmerzPZ++d8+cAEcpk8QtUtUk/4gS7GXtH9Kj/9NQstcvueWTzgm46DspVi+MXLg80U8kbpmpDBvZRIrEHXAQPCX6fUOhSsMo0giedrpP2UV467rfmx98TZkWvmRJBv3BGG/QAWUvXHNy+7dHsV+MTNlegfVReYmF4eGcjutkIImsH1YKhsCM9yNGLDaARdRDjQuLncXMktAFlvaR3tZ7xodgKeg2fHebzj4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(3023799003)(11063799003)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /QVVb5e3AY001t+9my2GQjV+nyg9TpmfeErl9vGwqCmUqX6imjDT4K4BqszLSVIvBek9mhQwIuOJx/BiO4ujLVLx4+DmM2viTToKEcSR9FQk5Qr84i29Kggwemh/kP2ax3HFNuMO2RI2TIBDBmSlyK5kNDX2E4oBP12f0QZ5Vie/odKf1fsC6uDkLtBxE47j0tVONNA/h2VsZEeprXbLyDzMlFWtXU4L0AWJStQX+Mie+1fgEgliWYckVA0dbvwxiB3eeo2aaDlXj4OktR96FAP4oia3PdE8VwKjoTi874+8uUKIR+P/skUN5+Vbnb5AbI92xEADrn5zk8j7jJqPifFD4GBVKriNkCR6fhQl/9Q3u+M0/ydZAs9TMbLY6gf3BcbHmM+BCm7//vplPDYSfhPm8U8tlOrkl601cYg8l3/t8/4X9Pg3mNAPCYyi/7B9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 06:59:25.8367 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b36d4a83-65c8-4f4a-e9a1-08deb4aaff95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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

Currently, the i2s_pdata structure is dynamically allocated in
acp_hw_init() but never freed in both the error handling path and
the acp_hw_fini() cleanup path, causing a permanent memory leak.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 76 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h |  1 +
 2 files changed, 39 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 381ef205b0df..c1307dfccf92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -228,7 +228,6 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 	u64 acp_base;
 	u32 val = 0;
 	u32 count = 0;
-	struct i2s_platform_data *i2s_pdata = NULL;
 
 	struct amdgpu_device *adev = ip_block->adev;
 
@@ -273,18 +272,18 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 			goto failure;
 		}
 
-		i2s_pdata = kcalloc(1, sizeof(struct i2s_platform_data), GFP_KERNEL);
-		if (!i2s_pdata) {
+		adev->acp.i2s_pdata = kcalloc(1, sizeof(struct i2s_platform_data), GFP_KERNEL);
+		if (!adev->acp.i2s_pdata) {
 			r = -ENOMEM;
 			goto failure;
 		}
 
-		i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
-				      DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
-		i2s_pdata[0].cap = DWC_I2S_PLAY | DWC_I2S_RECORD;
-		i2s_pdata[0].snd_rates = SNDRV_PCM_RATE_8000_96000;
-		i2s_pdata[0].i2s_reg_comp1 = ACP_I2S_COMP1_CAP_REG_OFFSET;
-		i2s_pdata[0].i2s_reg_comp2 = ACP_I2S_COMP2_CAP_REG_OFFSET;
+		adev->acp.i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
+						DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
+		adev->acp.i2s_pdata[0].cap = DWC_I2S_PLAY | DWC_I2S_RECORD;
+		adev->acp.i2s_pdata[0].snd_rates = SNDRV_PCM_RATE_8000_96000;
+		adev->acp.i2s_pdata[0].i2s_reg_comp1 = ACP_I2S_COMP1_CAP_REG_OFFSET;
+		adev->acp.i2s_pdata[0].i2s_reg_comp2 = ACP_I2S_COMP2_CAP_REG_OFFSET;
 
 		adev->acp.acp_res[0].name = "acp2x_dma";
 		adev->acp.acp_res[0].flags = IORESOURCE_MEM;
@@ -312,7 +311,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		adev->acp.acp_cell[1].id = 1;
 		adev->acp.acp_cell[1].num_resources = 1;
 		adev->acp.acp_cell[1].resources = &adev->acp.acp_res[1];
-		adev->acp.acp_cell[1].platform_data = &i2s_pdata[0];
+		adev->acp.acp_cell[1].platform_data = &adev->acp.i2s_pdata[0];
 		adev->acp.acp_cell[1].pdata_size = sizeof(struct i2s_platform_data);
 		r = mfd_add_devices(adev->acp.parent, 0, adev->acp.acp_cell, 2, NULL, 0, NULL);
 		if (r)
@@ -338,53 +337,53 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 			goto failure;
 		}
 
-		i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
-		if (!i2s_pdata) {
+		adev->acp.i2s_pdata = kcalloc(3, sizeof(struct i2s_platform_data), GFP_KERNEL);
+		if (!adev->acp.i2s_pdata) {
 			r = -ENOMEM;
 			goto failure;
 		}
 
 		switch (adev->asic_type) {
 		case CHIP_STONEY:
-			i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
-				DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
+			adev->acp.i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
+							DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
 			break;
 		default:
-			i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
+			adev->acp.i2s_pdata[0].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
 		}
-		i2s_pdata[0].cap = DWC_I2S_PLAY;
-		i2s_pdata[0].snd_rates = SNDRV_PCM_RATE_8000_96000;
-		i2s_pdata[0].i2s_reg_comp1 = ACP_I2S_COMP1_PLAY_REG_OFFSET;
-		i2s_pdata[0].i2s_reg_comp2 = ACP_I2S_COMP2_PLAY_REG_OFFSET;
+		adev->acp.i2s_pdata[0].cap = DWC_I2S_PLAY;
+		adev->acp.i2s_pdata[0].snd_rates = SNDRV_PCM_RATE_8000_96000;
+		adev->acp.i2s_pdata[0].i2s_reg_comp1 = ACP_I2S_COMP1_PLAY_REG_OFFSET;
+		adev->acp.i2s_pdata[0].i2s_reg_comp2 = ACP_I2S_COMP2_PLAY_REG_OFFSET;
 		switch (adev->asic_type) {
 		case CHIP_STONEY:
-			i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
-				DW_I2S_QUIRK_COMP_PARAM1 |
-				DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
+			adev->acp.i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
+							DW_I2S_QUIRK_COMP_PARAM1 |
+							DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
 			break;
 		default:
-			i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
-				DW_I2S_QUIRK_COMP_PARAM1;
+			adev->acp.i2s_pdata[1].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET |
+							DW_I2S_QUIRK_COMP_PARAM1;
 		}
 
-		i2s_pdata[1].cap = DWC_I2S_RECORD;
-		i2s_pdata[1].snd_rates = SNDRV_PCM_RATE_8000_96000;
-		i2s_pdata[1].i2s_reg_comp1 = ACP_I2S_COMP1_CAP_REG_OFFSET;
-		i2s_pdata[1].i2s_reg_comp2 = ACP_I2S_COMP2_CAP_REG_OFFSET;
+		adev->acp.i2s_pdata[1].cap = DWC_I2S_RECORD;
+		adev->acp.i2s_pdata[1].snd_rates = SNDRV_PCM_RATE_8000_96000;
+		adev->acp.i2s_pdata[1].i2s_reg_comp1 = ACP_I2S_COMP1_CAP_REG_OFFSET;
+		adev->acp.i2s_pdata[1].i2s_reg_comp2 = ACP_I2S_COMP2_CAP_REG_OFFSET;
 
-		i2s_pdata[2].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
+		adev->acp.i2s_pdata[2].quirks = DW_I2S_QUIRK_COMP_REG_OFFSET;
 		switch (adev->asic_type) {
 		case CHIP_STONEY:
-			i2s_pdata[2].quirks |= DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
+			adev->acp.i2s_pdata[2].quirks |= DW_I2S_QUIRK_16BIT_IDX_OVERRIDE;
 			break;
 		default:
 			break;
 		}
 
-		i2s_pdata[2].cap = DWC_I2S_PLAY | DWC_I2S_RECORD;
-		i2s_pdata[2].snd_rates = SNDRV_PCM_RATE_8000_96000;
-		i2s_pdata[2].i2s_reg_comp1 = ACP_BT_COMP1_REG_OFFSET;
-		i2s_pdata[2].i2s_reg_comp2 = ACP_BT_COMP2_REG_OFFSET;
+		adev->acp.i2s_pdata[2].cap = DWC_I2S_PLAY | DWC_I2S_RECORD;
+		adev->acp.i2s_pdata[2].snd_rates = SNDRV_PCM_RATE_8000_96000;
+		adev->acp.i2s_pdata[2].i2s_reg_comp1 = ACP_BT_COMP1_REG_OFFSET;
+		adev->acp.i2s_pdata[2].i2s_reg_comp2 = ACP_BT_COMP2_REG_OFFSET;
 
 		adev->acp.acp_res[0].name = "acp2x_dma";
 		adev->acp.acp_res[0].flags = IORESOURCE_MEM;
@@ -422,21 +421,21 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		adev->acp.acp_cell[1].id = 1;
 		adev->acp.acp_cell[1].num_resources = 1;
 		adev->acp.acp_cell[1].resources = &adev->acp.acp_res[1];
-		adev->acp.acp_cell[1].platform_data = &i2s_pdata[0];
+		adev->acp.acp_cell[1].platform_data = &adev->acp.i2s_pdata[0];
 		adev->acp.acp_cell[1].pdata_size = sizeof(struct i2s_platform_data);
 
 		adev->acp.acp_cell[2].name = "designware-i2s";
 		adev->acp.acp_cell[2].id = 2;
 		adev->acp.acp_cell[2].num_resources = 1;
 		adev->acp.acp_cell[2].resources = &adev->acp.acp_res[2];
-		adev->acp.acp_cell[2].platform_data = &i2s_pdata[1];
+		adev->acp.acp_cell[2].platform_data = &adev->acp.i2s_pdata[1];
 		adev->acp.acp_cell[2].pdata_size = sizeof(struct i2s_platform_data);
 
 		adev->acp.acp_cell[3].name = "designware-i2s";
 		adev->acp.acp_cell[3].id = 3;
 		adev->acp.acp_cell[3].num_resources = 1;
 		adev->acp.acp_cell[3].resources = &adev->acp.acp_res[3];
-		adev->acp.acp_cell[3].platform_data = &i2s_pdata[2];
+		adev->acp.acp_cell[3].platform_data = &adev->acp.i2s_pdata[2];
 		adev->acp.acp_cell[3].pdata_size = sizeof(struct i2s_platform_data);
 
 		r = mfd_add_devices(adev->acp.parent, 0, adev->acp.acp_cell, ACP_DEVS, NULL, 0, NULL);
@@ -493,7 +492,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 failure:
-	kfree(i2s_pdata);
+	kfree(adev->acp.i2s_pdata);
 	kfree(adev->acp.acp_res);
 	kfree(adev->acp.acp_cell);
 	kfree(adev->acp.acp_genpd);
@@ -558,6 +557,7 @@ static int acp_hw_fini(struct amdgpu_ip_block *ip_block)
 			      acp_genpd_remove_device);
 
 	mfd_remove_devices(adev->acp.parent);
+	kfree(adev->acp.i2s_pdata);
 	kfree(adev->acp.acp_res);
 	kfree(adev->acp.acp_genpd);
 	kfree(adev->acp.acp_cell);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h
index a288ce25c176..13b48c582314 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.h
@@ -35,6 +35,7 @@ struct amdgpu_acp {
 	struct mfd_cell *acp_cell;
 	struct resource *acp_res;
 	struct acp_pm_domain *acp_genpd;
+	struct i2s_platform_data *i2s_pdata;
 };
 
 extern const struct amdgpu_ip_block_version acp_ip_block;
-- 
2.34.1

