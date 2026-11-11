Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C410E606A324
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZMKfHIgF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E19D10EA60;
	Wed, 11 Nov 2026 15:16:10 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012050.outbound.protection.outlook.com [40.107.209.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51AE710EA5D
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 15:16:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w4I8yrm8afAk+yhBDz7c8yLp5FSPixC1JYyjMEyGBld08PDC+FUFsXZYINpLnAf82P0NCI/CGWwOaA/3PUDaosfq175QRVJIbwkeK2irvQK6YUGff+Jbzdan8vLQn+ATLaGnLKoRv65O5QsO9qU/fwySX+MCR9AHMj51kGtQhAV8+dE4UoFyxfdQCZs2qODHD5dQkV8raORw7dVN6oJ8csmGTJF/7vAqG/W99IaAqaNcF8L2Z5u1dpP3nxJ71clwmCECSyFDRY009SsggpaXAZsnk5BLlaadrruGvEQ1kWSGMRVHkuwJbM4akIajKLU5wvzwLhD6c/EYS/5EDrtNYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwyLWCfLF8m7h0jEcVzhYmy479ETe+daPtUwHGzUOGg=;
 b=jolCfDQyAeOw0gRRqnj1pBfnMAZC4Glnx/dA1/6r2j0m/q8eORY93tO1mYksJfpyCRn1zLZQ5lS+bwwvlYfzr0yBSG6LuAIGkju7FKSKbbSYsn5Yv93xSgVtFC1fJZknOjVnaYYaaJVCHy0X/aKiyI0Nk8s7t1vlLlxvSSl6vABZEoSZ2Qffv+wanXmheIikj41HQl38jZpAr9pbrKdk5KDu9nKoTq75b8/lPVpjpZ+Ng/KzYwHTwCrUFTYcoPMNqjvIbQm8r4Qa5g+9zl4vTqActZci7FV4jlsl07PjRL/PthOOXs/HFh/2i73FBNiBW8IWTbpOZFwSo2FHP5eHwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwyLWCfLF8m7h0jEcVzhYmy479ETe+daPtUwHGzUOGg=;
 b=ZMKfHIgFF6vKqjZSR1xn1yqUqebeZqgWc2u97EXsky0jrZscpwcKLiP76B5RfKcoH65cw1OnhvQsAMv1M9RFuEjMHs2ZYv13VHWibXavX76KRlXf9AVkqS/bPYeupAm6WDIqxUDvdUyhDDwE6SNwjb7PLEn2eaDJwo2guZEgF8A=
Received: from CH2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:610:5a::38)
 by IA5PR12MB999276.namprd12.prod.outlook.com (2603:10b6:208:60b::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 15:16:00 +0000
Received: from CH01EPF000BE943.namprd02.prod.outlook.com
 (2603:10b6:610:5a:cafe::25) by CH2PR08CA0028.outlook.office365.com
 (2603:10b6:610:5a::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Wed,
 11 Nov 2026 15:16:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH01EPF000BE943.mail.protection.outlook.com (10.167.244.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 15:16:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 09:15:59 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 09:15:59 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 11 Nov 2026 09:15:59 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <tzimmermann@suse.de>,
 <timur.kristof@gmail.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: fix audio parameter documentation
Date: Wed, 11 Nov 2026 10:15:39 -0500
Message-ID: <20261111151546.3105062-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111151546.3105062-1-alexander.deucher@amd.com>
References: <20261111151546.3105062-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH01EPF000BE943:EE_|IA5PR12MB999276:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c696cc6-513f-4c90-d16e-08df4006b19b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|18002099003|22082099003|10067099003|11063799006|56012099006|261102123227099003|261009223027099003|261021121427099003|261022075727099003|261021123027099003|261026121527099003|260925021311599003|260925022911599003|260925021911599003;
X-Microsoft-Antispam-Message-Info: x7eCFApgPvlCTtBvvmYIAncpXdnU3CPhjodU6akz/bmkan5+YVFch9Nz26odboC2RTUkaWY1W0/IS+imcgHv2QTh7TZ/Ch3HWmhMj9aDK0n/xq2BCk216DOQDHGy5qjVRf/fWlkNv4aITQURj80t34O9Q2z8RNnBf/no23ehBIZilkXk9AhhjwZaGhyBlYpncD/i98H4gH3TEqUtKx5+sbZ7Nw8xvYznGpNtrmQ7rRY0CO60r8brM2ndqdcSDIIZ0dRIea3Bt/oMMoWyX5dw/+hSbi1Hm7qyUz47a1ifxX+Qhgptzqz5/jYRi4QxFIoCC9QHDJriTVmV/q4ERwaIsHlniLr388c+Hb2evqEKysVXSZv5uDErkIp4IPolJY7VFDps/5PUvL+XLUw9c7dCj5EVm6jCAB/FMCDdtnvy9+GPcJRecfv4eyHxViqqpR+vFI/23SXJ6rFbyKxRpL01XSSYXZDW4QQxVK8dlU89pBIzLSzw6io27wf3rC6IYPuGp4Puq4FXsb50DLMETn2DI8liyeOyL2X/69KAFrSKLIn4CBcYVhpouLimt7Z3OTZ6QLhSQ4NznWYd6taipp+OHCfjCI812f2xdKR3Izj+wFVa6ggaZiJpUPEYjUi71tXMKxavYzXK6lszr8Cyz2CSWsRhvM/sZaRlvKlvj+8xcpUTQUfbi3Ls3JSu+pKvF14SNidP/P0JEuwx8uStAK74Wg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(261102123227099003)(261009223027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261026121527099003)(260925021311599003)(260925022911599003)(260925021911599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1wOV+/v6p5LJY+2ntip5jglYkBWuz7Ad294SPYktyv8Q+nrMIRQPyTS3I9BFAs2i35fsE9zdq08UDpV1C7UZ7WA2krD/VFzmgFVD7A/zT0qQwORT0zSrGOjp/ONS0J6U9Rw7SVIc3I9SuaTvBN8OKoB2o547reoTFB2lys6n71MVP2aS+hmyh4ZH6wdwhwQJVHKKSyKNt33/KI8xBbiHMNT9ZXDzkb8du6zW22MovBlAlyp5i6NdKWWEQXJp3sldu2DeKCloE3+wAB3cQucP5hut3amif5MFrQR+JaWhSfryMXTppCBKGxf4cyY1nkwfaT1OTxjVgJmeVouW30tL+DxR1qHsAZzlaQwLdh3r3dhFJ7C+D7TIcWrZh1ZiQQDzDqQ2EmBigqu6HIkzqJ3n+iAH8HTaw+DgpP8ShoxtU0yJyHLf3pnpCBjaWq0p3Xe5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 15:16:00.3097 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c696cc6-513f-4c90-d16e-08df4006b19b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH01EPF000BE943.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA5PR12MB999276
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It applies to DC as well.  DC disables audio via this
option.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 72b3710462824..39a4b434e99f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -318,9 +318,9 @@ module_param_named(moverate, amdgpu_moverate, int, 0600);
 
 /**
  * DOC: audio (int)
- * Set HDMI/DPAudio. Only affects non-DC display handling. The default is -1 (Enabled), set 0 to disabled it.
+ * Set HDMI/DPAudio. The default is -1 (Enabled), set 0 to disabled it.
  */
-MODULE_PARM_DESC(audio, "HDMI/DP Audio enable for non DC displays (-1 = auto, 0 = disable, 1 = enable)");
+MODULE_PARM_DESC(audio, "HDMI/DP Audio enable for displays (-1 = auto, 0 = disable, 1 = enable)");
 module_param_named(audio, amdgpu_audio, int, 0444);
 
 /**
-- 
2.56.0

