Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4767CD6E57
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 14:50:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82E3410FF87;
	Wed,  3 Jun 2026 14:50:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jl8JVuMz";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010019.outbound.protection.outlook.com [52.101.46.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EA3F10FF87
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 14:50:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hkKetdPSQWAtGIHu5WMo1+GfpZt89QHI33SnBGr4snkIyhqnlm9RifFIIRYdChceadoxh1XGemS0/mvlFr6liK4j4sFFVTpI3O24CDAkLVYhUeDzBxXWTzcwqrANMv9fAckJrUXdu6xcBFp0ygCgnpZIwLJ+zo2yUoBgOx99DnenskIrnaoDkpwbHHxaH3mBqKIJjiTx4hY5fhDq8ie2J+5yzNylMJqYAm85Hb1JnvG/hRixaBYsK0hHDxkwAcO4I8yR5quDRRcIKi1wSHOYrMXcWf1M1A1Excv37Wb5KYqrfx3a5ibNTF4ZsJNkT9j0OM+r98hxwvpsfVMUIiBLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCwvcAJe7PLqfN9o1q3XLClggqkDu5CSrDaY3VAZe1g=;
 b=BlBRKpJBpgvbf6zupr7dCA7ktajeJ0yBYa6Mz6tT0lwqSJWRkkfG47ZHRJAIv2DyKsXCSr8bNWUt3/84S5Gj7QEuige/t5Mi4f/ymym/eTAjk92sAXLSwCGHUF89udfMusfKpPPg1nuBcQsselsYwjMgA4/YiBZGCo8eF7tjhgOkjXhx4k7Bi3bwjIU281Hac1Sb32w1VrjRM2y8XZ0sCdswASHNJGqn6RjY2cPrmQqVkclnMZYeWkgXxKv2OukXrcUbVyxpjuRmLm7pbdrtYgCmDV0ZOQgtPUvu24FtmQ30bOitNe7DgbhkEWBhl2/oLJQgT4NxRtygZ+nzg1EXmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCwvcAJe7PLqfN9o1q3XLClggqkDu5CSrDaY3VAZe1g=;
 b=Jl8JVuMzbTzJB5d/TWpd90iD2NWaRYPnIyFa8H9ApB4aL1ayep50FZ8IhayMDSSGYN7PuzzwJI8tmfHtANzk5R1kqR2Z+PZrgC0Lcn3wTiWrGisWVJcdB4sHHf1CORbE6XkHCdFt+D6PUCJmMxV645wHpvToYrpbZkekyyNzq0Q=
Received: from BL1P223CA0036.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::18)
 by SA1PR12MB5671.namprd12.prod.outlook.com (2603:10b6:806:23b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Wed, 3 Jun 2026
 14:50:07 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:5b6:cafe::a4) by BL1P223CA0036.outlook.office365.com
 (2603:10b6:208:5b6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 14:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 14:50:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 09:50:02 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 3 Jun 2026 09:50:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Matthew Stewart
 <Matthew.Stewart2@amd.com>, Harry Wentland <harry.wentland@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH] drm/amdgpu: Add missing license to new header files
Date: Wed, 3 Jun 2026 10:49:49 -0400
Message-ID: <20260603144949.3796019-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|SA1PR12MB5671:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c5e335e-ccef-4285-ea36-08dec17f66ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|11063799006|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: ce1Yumc+/34kNAaRenUG/4X9dMVcKlMB0irsVTC71sbKdqVpnrXplQAKQblpY397DwCd68jy9amG+Lh68MT685FUAtNcbcjNQX3joxejbvPUX5VpcDhpH9esoNAPIVSBaeHTwY41QNvfv53jk+/HrCMjk+Df9sLDEp2qbX1YHyMuHBP9Lj2OxJEzlaoB4deqcISb6AWzMIuYdScIWPI4HZl3RS+9s4Hlwq/VVm86CpzDVQqTYCxPPn0hqhGMM8sK//Og3DDeQnrJqOXcFLnbbtmHPhKGhXW6FVdy1QthEghkqA7kpYvd/eR0HuQrMghlaNA/XVFUVOQSmiKtQ1Kyfbm2VKBPObNEGPjpSK1nWuLgn+OfVhj2wuZtxnqaIBzLufzLV4JeKQOkKWQqTQWzMyT6bmilbbo7D3+yHjfNaMxW6Iah3i2ibDzhyn+To1sTm0CLt1dHM+soxE/HL0irqsa5NmOd9prjC/GxvbUrgrb5DrJoHZdwWgpbVzLEAMabNuc4MW+iJ1jvAr0UUEzZ7esN985In+XYfOpWTPaeKvZxsG7IA1WiCfRsEpa0jSM7DrplvHOjANxQBBD5b9KDXUlhosAURNW0w7rzmuDwa91fNijV4e0h20P8d0rfHZHAJmjK4JgPqu6sgV4WChZRs+lbGJ9Ur4GLtWgRyjznmxd9NKIwym0PKtiOAspwWV3p/RQ9uSKKMyEfv620ftbFnGUnV99NovzaaDxCvcnU3yw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(11063799006)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MFxLF4M72MGNkJwGqo8rDKiX1mc2EiyJUGr7G7SNEaQoutczPuk0eS7Nfq6rFpwJDUrTvjiTkgu3EUknsZ5tTeSj7b4RY5MNkihNPWQ39MMpe3mmyMbb7PVvlCIis5Q+qst2xJ9esvP5Ag771xG3jxNpPdkMkqNDCTXbD8qzBq2HJ7qYBqlxiU0IiYaaeGqkrj9wKgUeLbqsiG0Zr26YCDrKf+DLvGQV9m4huc+LBEkbmRPnVWIU2WaDZ1vTpqqYHf3tor6ka4erXljnAO+HajLvs4AaTWtlaAuJuhUe7bHqL6mq7pu+OuB7ZvX5fnTUBN9LDsqOjPPTcFo9m1mPhfsmkQxHDvyW4fjQ3ySsCudlUNN+7L1YnkHAWqkXYPPABUbNMNKMAdnUu5ekgKFMc5h5i5pOVurnEhnuE2NNCfUcIlGDb5HDnta14Edwwhf2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 14:50:06.4557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c5e335e-ccef-4285-ea36-08dec17f66ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5671
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

Missing MIT license.

Fixes: c942ccaadec8 ("drm/amd: Add register header files for DCN42B")
Cc: Matthew Stewart <Matthew.Stewart2@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_offset.h   | 1 +
 drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h  | 1 +
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_offset.h    | 1 +
 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_sh_mask.h   | 1 +
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h  | 1 +
 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h | 1 +
 6 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_offset.h b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_offset.h
index 328c296e425a1..064a4090ecbd7 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_offset.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 // Copyright (c) 2026 Advanced Micro Devices, Inc. All rights reserved.
 
 #ifndef _clk_15_0_5_OFFSET_HEADER
diff --git a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h
index 1b98cfcf33649..6fc290c16a0f1 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/clk/clk_15_0_5_sh_mask.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 // Copyright (c) 2026 Advanced Micro Devices, Inc. All rights reserved.
 
 #ifndef _clk_15_0_5_SH_MASK_HEADER
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_offset.h
index 3751054e25f2e..7edc672240d67 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_offset.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 // Copyright (c) 2026 Advanced Micro Devices, Inc. All rights reserved.
 
 #ifndef _dcn_4_2_1_OFFSET_HEADER
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_sh_mask.h
index 71c74962147e6..0d6e618c1cc1b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_2_1_sh_mask.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 // Copyright (c) 2026 Advanced Micro Devices, Inc. All rights reserved.
 
 #ifndef _dcn_4_2_1_SH_MASK_HEADER
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h
index b004c80774bd5..4f993a73c417b 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_offset.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 // Copyright (c) 2026 Advanced Micro Devices, Inc. All rights reserved.
 
 #ifndef _dpcs_4_0_1_OFFSET_HEADER
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h
index 06e650b3dcc1d..8cb810a242484 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_4_0_1_sh_mask.h
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 // Copyright (c) 2026 Advanced Micro Devices, Inc. All rights reserved.
 
 #ifndef _dpcs_4_0_1_SH_MASK_HEADER
-- 
2.54.0

