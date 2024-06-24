Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5D8AC2D0D1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jun 2024 13:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C30B10E457;
	Mon, 24 Jun 2024 13:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Uhewgvqc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48DBA10E457
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jun 2024 13:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ryb+eNLTbCqzmRo8zXKqR+ewR0QfexO6XDuV9vz0m6ZR50hR3iLRPDBOS40Zuse5xiuqwwnHTccDvb1AyAzJtqQjZhb4cNf3Rn5dTw7n7Gnc9fID6adpbqYSRM9/nuYmJ5BJUX/CcigzU1BFOtHZ0BXFzPw9+NbmB0t08itCUmaRQnbQ9jMLmklMm+41swDKdz6w+Rp8gUlTPh+tzNQrXpoXVGe5fYVs8JO1X4otDoFlQys5RuG6X5ufPkz415bZrjhdTxi7kdPnsSPhIgUv4a9ML29AhIfy0QfXa7p0ZOZfsKyUvIBfvgUO0CZUmqH5w4iZjvzaSzrJBOYxmmivVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyZ6UltZrJSUqjiOxOroi6iwXstcWncniIq10ixTmZ0=;
 b=Mnf8rm6v5zfCHB0Uj/i3IgsZJLqUfHE7h/tIUGjEne+Er7Kvto7ro44/FYLTb+DpC3NYbAluTTwIecfQLtY26R2t3CEtrs1REJ3Daj2ibHvd+mCLLlNJwJyp+hhlLLlhTm62blEgvbMXMa5vlYjbqVJf2eM08J3cDICeXFgv4fXspCuU7P7Y5Nj9qlgegrvbsw95YDmY/DbbLGb16hD5z0ps8UgpFK4kD4MvB9OKTRiXQ3X1EyPnxMbvDgxJ5hckGKcW8iEx3iJM/x32tGNDUHAzk1h5Anb8iSndEu3dW5odLE+GEpK52NvKAIIrlHmhUZ+06fM9j0kRiRKRFQtt+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyZ6UltZrJSUqjiOxOroi6iwXstcWncniIq10ixTmZ0=;
 b=Uhewgvqchh+DzxmDksn+6G9Bg5Xn/y8JB33dK7NtjV5UkZffwqxuqJmmLAahBkvnWOgMGAUMF8nuC37f4ocrJNgC/vmP3kdIOm8+nzE3yHtemCsyxBESWppkrQZhxEwgYM+tqYfXA/pEXWcU7C9eqkAkizCTQ+PrxrodcnegokI=
Received: from CH0PR04CA0023.namprd04.prod.outlook.com (2603:10b6:610:76::28)
 by PH8PR12MB7446.namprd12.prod.outlook.com (2603:10b6:510:216::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 13:58:47 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::b4) by CH0PR04CA0023.outlook.office365.com
 (2603:10b6:610:76::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 13:58:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 13:58:47 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 08:58:46 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix Makefile copyright notices
Date: Mon, 24 Jun 2024 09:58:08 -0400
Message-ID: <20240624135809.3089648-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|PH8PR12MB7446:EE_
X-MS-Office365-Filtering-Correlation-Id: 653ba03c-1fd4-4c17-2949-08dc9455c495
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|36860700010|376011; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkZUQ0Q0WFIxbHlvSmx0WGpuMnVQQXBJbXpiUGJodFNPVXRtQ1EvOEN4eWtR?=
 =?utf-8?B?RzhiZStwT0dkUk1lKzFzWllXT0RuTVZuY216UmNaZjV6NXJvVnJmbVJLSEg5?=
 =?utf-8?B?OHRNT0pucy9yR2ltZmh0Q1h1cnRxSWROcUN4ckptQ21mRnJiVjdxYlVYVmV2?=
 =?utf-8?B?NDQ0VXhBTW9uR0NvU084RHJKT1MvQnlTUnlBaFlQT0ROY3lqVWVEQUFIUktL?=
 =?utf-8?B?djNvNERlenVjTkdFUHRqdDRoN01PbDlXWXowMnlGVWJaeWk0dmRJL2JKUXcr?=
 =?utf-8?B?UDVRMmg0OEpha2xHM0tlTnBYcVRrVGVLazRVQVlISkJyNXM4RkhOR1NZQkZs?=
 =?utf-8?B?Z0lBT0tMYXZtL2hXNEhQdHJlSFhBSjRham1uK1lMTVRVRzlWalJwamxkVVhH?=
 =?utf-8?B?VlBtL2FET3I2SSt0YU1QWnVDYTFTdUVXUGhMb084c1NBOGFwWi92VlIrb1Rk?=
 =?utf-8?B?MUlXenRWeHV4UGFXSElxVFdPSjZpYjNISWpPQ3FQb0hQMVcwYTR2UUdySGE4?=
 =?utf-8?B?R1lXTlZSUStTeHdpVzhicTB6ZXl1MmRXT05nblpVR2hYZ1NRNi9NNVB5SXc3?=
 =?utf-8?B?OGR4N0pETUx3elVINjZCZzROdkJmN0pGQkVQUzF2cmRDNitmY29jMzNVRE0y?=
 =?utf-8?B?WDMyMzVFK3JEcWxpU1I1V2ltUWVueFBTQ24vaWNhSUZTQTFSWkVvU01ad01L?=
 =?utf-8?B?L1dvWjFNanFqSll4QkVFOHovQ01Wb0tQdHN0aHp2NkFmd1V0RXYvN1Yyc0JC?=
 =?utf-8?B?T09FVTBRL01za3NnZlJ5UUVwVDl5Sm5IOS9ob3BsQlRYbzhDb09Sd05JeWlp?=
 =?utf-8?B?V0YvV2o2TSt0dUg3NzIwSk1PWWExRklGRUIyN2t3elgvMlVQa0FWYS95OFQv?=
 =?utf-8?B?czlLSk5GOG9lWUY0RnZ1OG1LcUF4SUIrMk95aWsvVUVOWXZrTzJ2YU5BL0VH?=
 =?utf-8?B?R1lUeVM5ZjNyVmpHNFZFemVSR3lINXUwT0QyM1U3SXpaTFJpa1NZanB5RVl6?=
 =?utf-8?B?Um94WERDNGRJNjBLakQwWG1YLzN2OVdzQXdkcGZPWEc2WERkR1lsZGxWaURk?=
 =?utf-8?B?dUh4UHNvdHNlZERIS0Jyb3grakErU0hhdHdoNG1pYVVBeVZlVHMvakJzdlZ2?=
 =?utf-8?B?b3B2UFh1L2wwaHZvWHdrdVk3bm5QQ2llK2dsb0hQUS9MUDl4aW0vb2ZUdmhX?=
 =?utf-8?B?Q1gyM2lyazlIUlpWVUZXVnlubkhNY0lWY3JaRncxNVRXL0tnTnBTdnQ3YzJ2?=
 =?utf-8?B?TkREdlY5NDNGaXY0NU9PVFBUL1hkVkxDaSt1SjV3c2tQL3ZqTzRMTnJPS202?=
 =?utf-8?B?WTlyL2IxYnBvK09WbWFnL0R5UU5XbWJFeVIrNnpMRll6WmlBczZUS2JudHdq?=
 =?utf-8?B?NkRBSW1LelUvT3V4UXJLTzUyZ1JubXZzRXlxSWNwck1BM0pCMGZjTkdrRUFw?=
 =?utf-8?B?SVQrczQ2SG81UGFVb29heTY5SzEvSzhEY3k0QVVISnJhK24yV3Q4QUtFcVJ4?=
 =?utf-8?B?RCtMMlhTRG9WSFRLNEJSU3pMbmxaTDdXb05BMkF6ZnpqOTNmNWJlWE0yZmpZ?=
 =?utf-8?B?NUtlNUl4VUxMRFhvVGs4RytzVG14RWpLbHhhN0M0Zkkwek1BeitUZEZBajBj?=
 =?utf-8?B?RFR1Nnl1a3JpNzc0SFV5dGlhNmlTMTl6eWxPNmFMMWZwYlVISlhqRURQeVZ1?=
 =?utf-8?B?ZDVZdFBsMmUrZUQxQkI2TTN1bWVtcVdNbWZrbVlvc2NuSU8vMzBVWEU2dU1o?=
 =?utf-8?B?T0x6UFViK1Y5YXlUTEZkV1VrS0RQZ2F4ZFdsV1FvdlE4L0lsNHY2M1hRRDY0?=
 =?utf-8?B?WE9DYzRzRU5yUkJHMHBFMjJuKzZoNmJocXI1elJLS1QzNnRjcEZjaExaWTBV?=
 =?utf-8?B?b0x4aENRajBEbUhlcWNQK3NhcTY4cTA5Z1BjV0lEU1p3dkE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(36860700010)(376011); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 13:58:47.0227 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 653ba03c-1fd4-4c17-2949-08dc9455c495
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7446
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

Leftover copy pasta from original code.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Harry.Wentland@amd.com
---
 drivers/gpu/drm/amd/display/dc/dcn301/Makefile | 11 ++---------
 drivers/gpu/drm/amd/display/dc/dcn31/Makefile  | 10 ++--------
 drivers/gpu/drm/amd/display/dc/dcn314/Makefile | 11 ++---------
 drivers/gpu/drm/amd/display/dc/dcn401/Makefile |  5 ++---
 4 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index fadf5e872e38..dc37dbf870df 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -1,12 +1,5 @@
-#
-# (c) Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
-#
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
-#
-#  Authors: AMD
+# SPDX-License-Identifier: MIT
+# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
 #
 # Makefile for dcn30.
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
index 62c8ab0e45aa..d9816313c3b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/Makefile
@@ -1,12 +1,6 @@
+# SPDX-License-Identifier: MIT
+# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
 #
-# Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
-#
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
-#
-#  Authors: AMD
 #
 # Makefile for dcn31.
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
index cac756c75b7f..15fdcf7c6466 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
@@ -1,12 +1,5 @@
-#
-# (c) Copyright 2022 Advanced Micro Devices, Inc. All the rights reserved
-#
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
-#
-#  Authors: AMD
+# SPDX-License-Identifier: MIT
+# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
 #
 # Makefile for dcn314.
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
index 2989e706bccf..ded1f3140beb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn401/Makefile
@@ -1,6 +1,5 @@
-#
-# Copyright © 2023 Advanced Micro Devices, Inc. All rights reserved.
-#
+# SPDX-License-Identifier: MIT
+# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
 
 DCN401 += dcn401_dio_link_encoder.o
 DCN401 += dcn401_dio_stream_encoder.o
-- 
2.45.2

