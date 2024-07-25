Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC696C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 18:03:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FFD810E2F5;
	Thu, 25 Jul 2024 18:03:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yPuVGw6b";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8C8110E313
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 18:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TwYNh5zcseFkG6AIDVIRNAv2o3p2h3rw8nSA2DjCn/Vf0E5jWwoRntzO1DbR4lr7qsTK4BZzMNpkVxC8e2bqEYPW7XepkefoE0Nb+yXB6cz1L7DobSAezdDGzPnqFGbxXae2pvIT//S+CccsxhHfG6hCkO1wGKBX236fv7/InNBnL/ZuKeiCIzd2Nn6Wxslvi0FldP92ZoDqV697HIWF3QCngy47n6KIoQ1B4bJzkzL9nUSg8Km/pvDYlTwXR/OD6h0XfayCED7YmVvY6hI95Y/gdhR6mICtC7ylrTbZDp+sXxhsIqdH2295cNmvHKfLw6x5MEE+iDUE0nLJF/cm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X7Ny8j8muubjCp37M4EV4MyC5yOwdav5IFUEeo3F/7k=;
 b=D8nmU+gkkE+H9lDwEIgFGJTjuogVevNDWwMawDu1UgtBi/UEt22UCvyJOm++pYH8WPEGgtVPo/sAWY5N2QYpV1/hy8Y8fo1i+cdm3ZxszjnrlErEi8XDNvMtJTApbYvWGJhUkrb8a+4mQIYByWYiPfF89fx95l+SJJfYkOpahRLtr1KpH/Wz4bYHRRnC2gut9Az4pDdGNDWi61Np0UA6FuqW3gEUaIuWhSvH+rQYvoSTL9mIijYt1cjypWoS4FRZ0idvKrPN1o3Rova2Szz6ySZh3u7YQ/x/PfTssnTr+K7mcrBCr2o3By9Vi6rpheiPdlZbwQpqNKs+Kyx7j+QAqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X7Ny8j8muubjCp37M4EV4MyC5yOwdav5IFUEeo3F/7k=;
 b=yPuVGw6bM9Wau45dFoevoBzlR5c5imtsaZyCNBFeMil1ite370nsxef2kPbssmDxlKNVKmFbR90GUrs/9jMJ3W7a4K86rivKjWgv3q064WRgOwpII32D90SQM07JRcEsORqLezAIxajMFKg0VEUalbUbb1O3mCf5IkknuThOvts=
Received: from CH0PR03CA0197.namprd03.prod.outlook.com (2603:10b6:610:e4::22)
 by SA1PR12MB5638.namprd12.prod.outlook.com (2603:10b6:806:229::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Thu, 25 Jul
 2024 18:03:47 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:e4:cafe::bb) by CH0PR03CA0197.outlook.office365.com
 (2603:10b6:610:e4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.20 via Frontend
 Transport; Thu, 25 Jul 2024 18:03:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 18:03:46 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 13:03:44 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Bhuvanachandra Pinninti
 <bpinnint@amd.com>, Martin Leung <martin.leung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 06/39] drm/amd/display: Refactor for dio
Date: Thu, 25 Jul 2024 12:00:50 -0600
Message-ID: <20240725180309.105968-7-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SA1PR12MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 26ce5faa-5214-41b5-7809-08dcacd4211a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VVkxSDRQYnBmTmhwWnh3b1JTbnNtZUdoUEg1bnhaNDZ2emNkT2NIZnNuUmkz?=
 =?utf-8?B?VXZUZTRyV3pKTHZFL2VZTmY3Y25QQ3hadjRlTlk3MmdNMWIzajFVSmhIaWpq?=
 =?utf-8?B?VlR1bFIwNGFHT2hPdUlxUjZnRkc1K2psOHdWL3N4bU1TMjBOOTdhbXZFM3ho?=
 =?utf-8?B?TjFuaTk1QTk4YTNPdEE0ZWZleTNlR3djR29Vem51a0hGUEpHN3p2ZzY3ZVp2?=
 =?utf-8?B?R005UjlWenFpOVl2MUtiOEl1c01EbmtOTlVMYVp5bUlZMkNuaGR2SzRiUnU4?=
 =?utf-8?B?bmJudWhpeVVYWkU5QzU2WEZ0K1MrM01ibjc1MkQ5UGxvaFVPVWNHRmtmeEtK?=
 =?utf-8?B?YU1hemo4Rkphbjdkd0xaRUxRdTYrcGhOaVNlZElsVTVlZGR5SlFidW5SN2Z2?=
 =?utf-8?B?UTMzUVFtdTYyb1RabmNRZy9VaWtmNnpVN0kwMm0wZVRrMlhxZURsOVRJdnht?=
 =?utf-8?B?aDBvbW1PNmFXYkNJMnZOYXMrM3hld2hUTVh0RGdtQlRzcVhDZmZOcGlMRGZQ?=
 =?utf-8?B?bWgxMitsUVJpUVVKbXZSaHpCY0tieHFKMWN1ZnF1cEttdEM2MVRwMFBEMFR1?=
 =?utf-8?B?MitEOUtYZ29DaTBKdkpMdXhIU0pWdnpUdmcrUVgyNEJUUGkzKzlsS3BjWS9Z?=
 =?utf-8?B?R1hGc0JOdTloMGxUeG42MW0xVnBBQmhmdk5kWGFnY282Q2dBQ1Q3NXd2K0s1?=
 =?utf-8?B?OXAxT2x5VDE0KzNGdHdpNlVRdHJENCt6b21SdHVITGRGWXFzSldsUXdhSHpK?=
 =?utf-8?B?cFdNSkV3eVQzZ1ppN2dBTVJRVm9LYUMvZWQ2elZPSm9tcVVBYUhCUGNXTHJG?=
 =?utf-8?B?bnJmQjdSSGNmcmxadmhHbG9KUTltVmtMRXRpUzh0UG9XODJXM0M5TlA5SWtJ?=
 =?utf-8?B?eTBjS1hwWHhjSUpUcFRTN3NYN0pBaVd6ZjhENEhNM0d1ZzZtN3ZMVzI1RGF0?=
 =?utf-8?B?TjJkWWFhMU9zbTRXcXpERUZhcUJCQ2lLRWlwNW1oSDc4N01QNnhiQUVWcXdF?=
 =?utf-8?B?WVdyOEZ2VUJZTzFVdlI3RTBZVXhMcVZkck1IQ085U0IvaHh6dWN3NHRITGNX?=
 =?utf-8?B?RmhWZmtRSWV3NEh6bkFHbEdLT1psYXdqZzZRbXdHL0IxN2lVQk9pdit1Vk1N?=
 =?utf-8?B?NEdyZWRiaUhkYXV0c1ZtdEVQREd6RVpsQTRGTVB1K21EQ3Z4ZUNHZjFzVktJ?=
 =?utf-8?B?Qy9jMEo1eTY2UWRzQW94dHg4UVAvYVpxblB3Q0tEdjdxZEFEcWNnTms5aXFO?=
 =?utf-8?B?TDA5M05qQkpSOURVa1B1K1BJcTNPUWswVzZQZ212TVdReStxU05Qc21GQ0xu?=
 =?utf-8?B?Ym9aTlllWE9XUmtDYnlDMGZjdkJnZVpmbUZZeG9uMXgxWERMdEd6ZXJvd1hR?=
 =?utf-8?B?OGhqd05oeDBJTTJGRVErOVVaWmtiSDRMelBuZmNyWnpjTm1tbEhLOVBqTUZP?=
 =?utf-8?B?SkU4NzdZOFV5d0hCOW9JL0d6c0xGOUtLSytycDBUTUlORnlVSVUrVVFMak9j?=
 =?utf-8?B?bi95THYrTDBzb0FUZUZpSWJ1UTFTb1RWV3QyZmN3ZjVhS1I5cnVQbENhUmJw?=
 =?utf-8?B?ZlcwZ2pMRTBnTy8wTXhxTEZ4TExRZVJKQlB2OGNNS2ZrVEwwUkdJOERNWk14?=
 =?utf-8?B?QjNkTUV0Z0JMeUVUQXBKVHF1UHV6RlRXNU9UZy93bVdidGJiMk5MYm9GT2Z4?=
 =?utf-8?B?ckE1ODVLejZkNkR4cW1ZRDBsakhLckNPbFZjNGRlQWk0RnB6UThpTm9RTVRL?=
 =?utf-8?B?bjdqdzBJZHhQbWUzRlVMRVJGdklzUjhiVGV5eCtIR2oyeS9BdzhVNGtRYVMy?=
 =?utf-8?B?VVVzM0tHcm4zS1ByUGtJS1laR2N0Wkwwcm4rMWNidU4venBRbU92Y3ZBR1BL?=
 =?utf-8?B?V1dMWFNGOTM5YWlWVndPUGtOWGF2R0R1OUttSnExTTIrL1R1QTRZejNXZlY0?=
 =?utf-8?Q?L1UKkcpvwBfQvMENV/8oPd04JTrTRP9p?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 18:03:46.5695 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26ce5faa-5214-41b5-7809-08dcacd4211a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5638
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

From: Bhuvanachandra Pinninti <bpinnint@amd.com>

Moved files to respective folders to improve DIO code.

Signed-off-by: Bhuvanachandra Pinninti <bpinnint@amd.com>
Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
---
 drivers/gpu/drm/amd/display/dc/Makefile        |  1 -
 drivers/gpu/drm/amd/display/dc/dcn301/Makefile |  2 +-
 drivers/gpu/drm/amd/display/dc/dcn314/Makefile | 10 ----------
 drivers/gpu/drm/amd/display/dc/dio/Makefile    | 18 ++++++++++++++++++
 .../{ => dio}/dcn301/dcn301_dio_link_encoder.c |  0
 .../{ => dio}/dcn301/dcn301_dio_link_encoder.h |  0
 .../dcn314/dcn314_dio_stream_encoder.c         |  0
 .../dcn314/dcn314_dio_stream_encoder.h         |  0
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c    |  1 -
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c    |  1 -
 10 files changed, 19 insertions(+), 14 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/dcn314/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn301/dcn301_dio_link_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn301/dcn301_dio_link_encoder.h (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn314/dcn314_dio_stream_encoder.c (100%)
 rename drivers/gpu/drm/amd/display/dc/{ => dio}/dcn314/dcn314_dio_stream_encoder.h (100%)

diff --git a/drivers/gpu/drm/amd/display/dc/Makefile b/drivers/gpu/drm/amd/display/dc/Makefile
index 80069651def3..8992e697759f 100644
--- a/drivers/gpu/drm/amd/display/dc/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/Makefile
@@ -35,7 +35,6 @@ DC_LIBS += dcn201
 DC_LIBS += dcn30
 DC_LIBS += dcn301
 DC_LIBS += dcn31
-DC_LIBS += dcn314
 DC_LIBS += dml
 DC_LIBS += dml2
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index dc37dbf870df..fb4814ab3f05 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -3,7 +3,7 @@
 #
 # Makefile for dcn30.
 
-DCN301 = dcn301_dio_link_encoder.o dcn301_panel_cntl.o
+DCN301 = dcn301_panel_cntl.o
 
 AMD_DAL_DCN301 = $(addprefix $(AMDDALPATH)/dc/dcn301/,$(DCN301))
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile b/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
deleted file mode 100644
index 15fdcf7c6466..000000000000
--- a/drivers/gpu/drm/amd/display/dc/dcn314/Makefile
+++ /dev/null
@@ -1,10 +0,0 @@
-# SPDX-License-Identifier: MIT
-# Copyright © 2024 Advanced Micro Devices, Inc. All rights reserved.
-#
-# Makefile for dcn314.
-
-DCN314 = dcn314_dio_stream_encoder.o
-
-AMD_DAL_DCN314 = $(addprefix $(AMDDALPATH)/dc/dcn314/,$(DCN314))
-
-AMD_DISPLAY_FILES += $(AMD_DAL_DCN314)
diff --git a/drivers/gpu/drm/amd/display/dc/dio/Makefile b/drivers/gpu/drm/amd/display/dc/dio/Makefile
index 67840e474d7a..0dfd480976f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dio/Makefile
@@ -51,6 +51,15 @@ AMD_DAL_DIO_DCN30 = $(addprefix $(AMDDALPATH)/dc/dio/dcn30/,$(DIO_DCN30))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN30)
 
+###############################################################################
+# DCN301
+###############################################################################
+DIO_DCN301 = dcn301_dio_link_encoder.o
+
+AMD_DAL_DIO_DCN301 = $(addprefix $(AMDDALPATH)/dc/dio/dcn301/,$(DIO_DCN301))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN301)
+
 ###############################################################################
 # DCN31
 ###############################################################################
@@ -60,6 +69,15 @@ AMD_DAL_DIO_DCN31 = $(addprefix $(AMDDALPATH)/dc/dio/dcn31/,$(DIO_DCN31))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN31)
 
+###############################################################################
+# DCN314
+###############################################################################
+DIO_DCN314 = dcn314_dio_stream_encoder.o
+
+AMD_DAL_DIO_DCN314 = $(addprefix $(AMDDALPATH)/dc/dio/dcn314/,$(DIO_DCN314))
+
+AMD_DISPLAY_FILES += $(AMD_DAL_DIO_DCN314)
+
 ###############################################################################
 # DCN32
 ###############################################################################
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn301/dcn301_dio_link_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn301/dcn301_dio_link_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.c
rename to drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.c
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.h
similarity index 100%
rename from drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dio_stream_encoder.h
rename to drivers/gpu/drm/amd/display/dc/dio/dcn314/dcn314_dio_stream_encoder.h
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
index 05783daa62ac..2ed382a8e79c 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn321/dcn321_dio_link_encoder.c
@@ -23,7 +23,6 @@
  *
  */
 
-
 #include "reg_helper.h"
 
 #include "core_types.h"
diff --git a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
index fcc88ef83e6a..19e50fbf908d 100644
--- a/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dio/dcn35/dcn35_dio_stream_encoder.c
@@ -22,7 +22,6 @@
  *
  */
 
-
 #include "dc_bios_types.h"
 #include "dcn30/dcn30_dio_stream_encoder.h"
 #include "dcn314/dcn314_dio_stream_encoder.h"
-- 
2.43.0

