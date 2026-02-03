Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444C2E8305F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 08:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC08B10E158;
	Tue,  3 Feb 2026 08:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X0qwQDtz";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010022.outbound.protection.outlook.com
 [40.93.198.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B222D10E158
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 08:57:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFsD7csOkeWSV9SvddsYY4vng4ib8y1GPDwPa/t7ArjQZz5X1+NOJfVOGs0F96vyoyL+9acLPK511Tk2cre/DxbAoxHwLZlLDa64ggBA1YI5MXJYX49korSOS24vw9OV7xh/TcDdwGe2LfvrENKf7Z0gwTqx/lv88EsOMPL9/MQ8e9YFeLnNMDraBV3Wov+zXTcUt3G+2Pp9rPNaqjKRYhDQapcVeWK/Wc9+++TwB+J0lk1LTB9eWbiztsM7qKQeKPbYPB6r+L0XvnVFMCPuXrOgE/YUyW3gQt6inkYKLca7gNLWtH0Dsf8yzNLlTAopeXnC+CiWBcHpSJRxEoMAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2iWl+5UkzAlYyZC4hU+0xIAQD4FPvrlY4Fr+lHpJOo=;
 b=JQfPQBH+QCeQK6Z6cszMO3TDsoVjQqqt/IT43iBSnN/aggfgOj8r9gpfay4afUXj5a8l83OxkR2I54+YpA2wZ5WCjdEP28Y8QmUJ0XAUIrPdaT8Npz3SVdp6Oa6I4qLs4yF+g+FV9YOvrBdEYmxYql4eViiFBHvOXo3tFA7LVn0QCnJQCOhgoRXE8cN0l6zGF1CiIma7uY7zpVsSg5nxsJ+Q0tX6TsTFyCzBhKyDRAj+mNL9BQpk2jYHFgTz9g6y8wCbHhjAve3Hal5f+vhBglPsxtrZMPkTQ0rLHCxRcmpPp3Dm75ty9b4j/k1NFX148b6IzA+MihPAoquYt5bphg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2iWl+5UkzAlYyZC4hU+0xIAQD4FPvrlY4Fr+lHpJOo=;
 b=X0qwQDtzCQPzXSBfRItrA3YGs0AwPNIxLp4d/haJGF6DdLOq2xjVBBxvl+CZ9KrTDkDJeP4GyP6y9/dQfw0C293Gf0jBHq5fObsBxP7pA9sqsfxIIyA6rpzlPGB035oSvRCcCkzrslNO6oSnJSQqgMN5XkXI2fo+7XTw6D64Zrg=
Received: from SJ0PR13CA0133.namprd13.prod.outlook.com (2603:10b6:a03:2c6::18)
 by LV2PR12MB999073.namprd12.prod.outlook.com (2603:10b6:408:352::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 08:57:16 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a5) by SJ0PR13CA0133.outlook.office365.com
 (2603:10b6:a03:2c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 08:57:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 08:57:15 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 02:57:14 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 00:57:13 -0800
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Tue, 3 Feb 2026 02:57:07 -0600
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Jesse.Zhang <Jesse.zhang@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/sdma_v5_2: update fw version check for
 per-queue reset on various ASICs
Date: Tue, 3 Feb 2026 16:56:10 +0800
Message-ID: <20260203085706.450079-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|LV2PR12MB999073:EE_
X-MS-Office365-Filtering-Correlation-Id: a87601f1-cd70-457e-8ada-08de63023a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R/BM9cZqn1DEZ0C3KLp77KT6L62czBkbr2/1G7WES5B7aNuiMgKbZ4Uyv68/?=
 =?us-ascii?Q?IE6fU9d5RrZMJvY96Kn8ydfSGB+0LOWO7TJqPu3WI9MVGyL68h218xDShKu2?=
 =?us-ascii?Q?vP3bz6zIMSx/qrQKfnbod8bWHJAPvygT7eZh/l+M+RRGV8pHZxbQHpGbhLmL?=
 =?us-ascii?Q?B9wVUE1EpokO+D/Pem6CtMIl3lQ7bNAoqH5Eldtd7N4SYWWWo35oC6iRP/B9?=
 =?us-ascii?Q?d95/qcA4mTb2A4rTIkq4TzunkOmZvPj1XPiWzLXQyxOpmNFEbfPOxA7xgw2s?=
 =?us-ascii?Q?TOr3tsFBDkjGX1+p6MmhvPYg3JsDP032SM+lQGUqlSrhzkbNSxvHEJqhIWZu?=
 =?us-ascii?Q?OKqwe4cYFgPNgSQeUQJfOcBZmnJ+F1NOvDibpnPXlGwkagbtOiGuouHeQel1?=
 =?us-ascii?Q?Xl9QKq7M/jlzPHL8iUclDWGLhIRNx+SR6YrRcErGQboMJWceYbOgbtHr5Bcb?=
 =?us-ascii?Q?cLYJruGm0x9xcn4Q8u45t2/bXNK68kDyNl436VTP0DRkGd8HqUt1Eu+plRfD?=
 =?us-ascii?Q?6b5UxPoJ17oQGtjdXC2yvbKJF7JNklSPC0aR8LCcphcCMxKtpgj9VmIHYbwN?=
 =?us-ascii?Q?i1sRhGTKVYMVL16CLwfxUlaJnW1dzmE0HDA7daIeyrnBAneZbvWD9Q+lw3tb?=
 =?us-ascii?Q?Vqo3DB7bh6f0LcSNClIrv5LBYnSg2o9Gs/acMOzA/NvH2x2REdZtElG834A+?=
 =?us-ascii?Q?xrNOw2zEHaOu5uDnWXPUi31J/hAz4fLzBBd6hzrZcps7qm8aZ+1zcnpfPM2+?=
 =?us-ascii?Q?C62izEdvhLN60ssWl3DU/OBE+CVxcmAU05COZ/4W5xkUrQgqg7TrF/aZUV88?=
 =?us-ascii?Q?wvTy/xEbKCQF3FZSnJl4aR8pg6DO0GpyTVT5E/TywzAGKmOZbfi0Zg6p6ZhV?=
 =?us-ascii?Q?f7cl55CvnIWKu0+4XJwTrvxI6QF3lcld1/O34jWP4FgZwIDEYaIRSf/sMGrB?=
 =?us-ascii?Q?kgUUOUvxoSUu0Tq5U/ETpY8X0E6b0dOZWYk8IGPytFyRaDxe5lSlZLktQp+u?=
 =?us-ascii?Q?IrjPflkcvRR3okF4QLr4WhFqw6mpGMpUguFBx90n58XeJf8ih5EsNZOy6007?=
 =?us-ascii?Q?xQhLhOSwUZ5H97VCPlfy9ZW3Y1xRw2T0nj3WnLTk/1jNomJ94+anCwZG/ic6?=
 =?us-ascii?Q?usB4B/LCiL5k8hbfk5+RjAMUcfEKySyl/vyt8jE/MdSDy1nlVpLCF2e2R0fB?=
 =?us-ascii?Q?fpjYAv4GHxkv+jWqHwaHnXWIBgvTMpZttdhC9zq3bfFTAqei7F/48s9QjNAG?=
 =?us-ascii?Q?/19C08a5+98R8otvgKnT2HqHj+1mk/nhKIvhWBOeNDpjkN/GwkIJmyfH8uNG?=
 =?us-ascii?Q?Cn6DqxrKLuHV0cTWZqsfI7d/TJtBhOpyFeag6VQKEB6WV6W7W3pQ5wloulg6?=
 =?us-ascii?Q?ePZS4zyIee8/fQqW5dK0P/6zCPfZQ5RBe4pPCRjvNoQ6QoM8Uv8K+Y7VaCr0?=
 =?us-ascii?Q?gd9bSNxAYQn23b8Guh7yZRpvDNjaZJ8Vt9j708FmVaNWERLTsqgBvrDhGsVw?=
 =?us-ascii?Q?iNsbAWkSJGjVkw5oG3CaYzDyVMiUZ/fdIGR7g3MKD26qjJw6kG10rUep9upu?=
 =?us-ascii?Q?Vuhl6GtGTbWiPue6tb89XRHbknBsFs0a3QoLDQ19D6qQduhU+wNQK3F3ZkvS?=
 =?us-ascii?Q?S1OYimsQArvvDLk9tzOdnrSuEvYqcQ7XPO8TaKdfyA/ImX4L9TU0QzfNcXqo?=
 =?us-ascii?Q?Z5+8jA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Di8jVr9aqyTydDYAYhO7Kc7uvBCebzb65mm4N4lRHoBnxp2yPZ2NG1Rxq/ZX+oXwpPNOD6tgK5CNn47azEQeJ2qwhumTOb34E8upgwCEVx7lrFCmZPRsKleTwWw9oLsBEZXL3dXDyNcjuiJiKUxT/NP25XJdc0Soo8DcbiJuZmpAcuy6auod/0V/iVoVZLjzpmbLeC7iJqcInrQodKr/8idPHKnyyqkUhhH8Eb39ku4qQhEqD8wH4xU6XQaOsq4+68OPwmYdf2JZURYaU6Kw+EucZBW0zWckTH9mUWabCfepAknbFJj/81BEPiDT1XDgDRxbaGNlqd5B7eaW5YxH3FDARRfa+bX40DDtAp9N949saFgz/Ffw6SmtSz6zyENwREaYCS5SEwczSaxguQuHta2vjgC2JaiNOXk1XpJc2DiWGCcPRhh1RZQ/WSybZF8I
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 08:57:15.0311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a87601f1-cd70-457e-8ada-08de63023a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB999073
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

Adjust SDMA 5.2 per-queue reset firmware version thresholds to match the correct requirements for different ASICs:
5.2.0: Require fw >=34
5.2.2: Require fw >=41
5.2.3: Require fw >=9
5.2.4: Require fw >=33 (from 76)
5.2.5: Require fw >=1 (from 34)

Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 5aa500fe554b..78dda51cd9e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1350,16 +1350,31 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0].ring);
 	switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
 	case IP_VERSION(5, 2, 0):
+		if ((adev->sdma.instance[0].fw_version >= 34) &&
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
 	case IP_VERSION(5, 2, 2):
+		if ((adev->sdma.instance[0].fw_version >= 41) &&
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
 	case IP_VERSION(5, 2, 3):
+		if ((adev->sdma.instance[0].fw_version >= 9) &&
+		    !amdgpu_sriov_vf(adev) &&
+		    !adev->debug_disable_gpu_ring_reset)
+			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
+		break;
 	case IP_VERSION(5, 2, 4):
-		if ((adev->sdma.instance[0].fw_version >= 76) &&
+		if ((adev->sdma.instance[0].fw_version >= 33) &&
 		    !amdgpu_sriov_vf(adev) &&
 		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	case IP_VERSION(5, 2, 5):
-		if ((adev->sdma.instance[0].fw_version >= 34) &&
+		if ((adev->sdma.instance[0].fw_version >= 1) &&
 		    !amdgpu_sriov_vf(adev) &&
 		    !adev->debug_disable_gpu_ring_reset)
 			adev->sdma.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
-- 
2.49.0

