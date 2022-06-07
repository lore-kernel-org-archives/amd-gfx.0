Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9227CC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 09:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2753B12AFDC;
	Tue,  7 Jun 2022 09:41:34 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4102712AFDC
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 09:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oR3twoO+g8NAeS0si8a7OEvb+EbrieCfQhYX2NXkqvdvsPMO8rb9K/NRrL9zrDqj7lVtvgEGSeFJ78bBwvzEilPFv1PlGhqgHZA4EalaG/0ER56jhXSzflZq0tWZ2MgYqMw8A3359+e8JxA1YoAGSjXcTMdhjB0QDJwaULew7bnMOITJnVFZQ5ftkF+hvCxWYWppObaMp5mwu0EJfHzjfdGdjmrjvdJBUUheTp02MF9NCYlSRDPHdCnXPZIf5fyn/O44VbPcHhwV2lWiqiCsGtwm7RRcmJ1HRrMUAWvfDIqQC60f6rlOkMqTo3M1zlFXnf+Bej2PDCoZpUqHyO6r7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aLpsb3k5Fi5rHlbFyOreFNCaxC4U8eyiOcnMj/7m7M=;
 b=UF5fg2cZiRuLaYXyQHHF2PCGUb9Mb+vTh9dilNLDWXeinuiD4EiD8lwKrQkmvSt1RQLxWmCWiE84c62OpKBOsJgNrvE5x9pQohy1cLHP9alI4rTghbbA0I2caNpPCIPHa9VzQ88gCr3iHe9NWyLVWQyn2yTNImIrpiPTyQDXdIGxI1DhDFTR9ZMBFNx5q5QIRrX8Rj6ztFDYBoJhflcTvVPw0pVKRRKdBQkmMRhZUAR7EdLxGAsxCE5WORHHUru1TeV1ecfygiRZCDaSx4r8um1csD27THKUBttjjoGcbCoit3m9qkjw42ivBkFd2OhhX5URmfA9PEcAzFtvOw3iMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aLpsb3k5Fi5rHlbFyOreFNCaxC4U8eyiOcnMj/7m7M=;
 b=NpQ1MAUf6anCcJ5kyZ28v5JqxDDoio39D94nAIF7MsPhFgpt48VX4r68fNjjzjZTThf+bHzgviMoEPMIE0PH6Ze1ttkn3aq7WE9hCNxyjtx6LNCNkYF1qsCFadX7dsmETmJ52beT0IxFunxiGrP1nTsdXuOADa7wR+kPWF3LjeU=
Received: from MW3PR05CA0023.namprd05.prod.outlook.com (2603:10b6:303:2b::28)
 by PH7PR12MB6396.namprd12.prod.outlook.com (2603:10b6:510:1fc::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 09:41:31 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:2b:cafe::f9) by MW3PR05CA0023.outlook.office365.com
 (2603:10b6:303:2b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.4 via Frontend
 Transport; Tue, 7 Jun 2022 09:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5314.12 via Frontend Transport; Tue, 7 Jun 2022 09:41:30 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 7 Jun
 2022 04:40:51 -0500
From: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/display: Remove unnecessary typecasts and fix
 build issues
Date: Tue, 7 Jun 2022 15:10:03 +0530
Message-ID: <20220607094004.946093-1-chandan.vurdigerenataraj@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b776cd8-8701-4c4a-de94-08da4869e6c1
X-MS-TrafficTypeDiagnostic: PH7PR12MB6396:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB63969E40BC838A9A6D3B48F696A59@PH7PR12MB6396.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KWIkKyR5bjM12AI1Q6mG0vQgDIEYp1vobORuA9FtNxJC+VwlpLfTNy8S1GmnAKr7hJ1TnK4lYAqW6II4wswYTaN1uKMGJLWrb+6gozvOPumMyoNvuYCnp4/1YBHnpsAO7f6FQx/qwN6HEnizm2m/i7FTEq3MSMblktqNAsrP9QKujAEvHXY1kqM2QOH9AGrh9QxpBLBp5XvcdfpfVU2XBxXMppw3eRCEiNV3KviweRQDRNPtTUVoQGtNrNUhHDlk562wHWL647Ne+oDeRYxg4etEnbral1oRyJ7ho0vqfQQYUOtb+nqdKC6xDj6Uiw4Zs6x2/KEyp1UaiqBHXUAwUdv5l0jltjWDKAnhntjAHrisqsZsy+zYPkSCS8BF7Yfb1dX5ttn/C9SBNggNqufiEp6yx3ZtRfeaiBje7e7ujP4SRz9h2CzA6LkPUqOcScqZXZLuAotHPcogoRCN1Q+9cTzwwfV8mb5JPHKoGbTy4D+skgH01mNQsjq4Sse7xIlbIycmLvH8mVuRoKLDgvFCyaPvPrOVSZBWOKdWpBhkP+OjLvpeJk7Pdy9g5W+cVrE8XzyHgA1kYQ8z3qWfRlLantf2FvVWaF2qXIjZIdgJWaPI9HxslC+O31OPZhAeKDsRSJWbE9pXAme1KAHbiUXOMtlhNWh2kmYrkzuU2r/y/wzyQ01vmo+cKXgfeii2i7wPdpwnSGGfIloOBdkaB631oA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(82310400005)(26005)(186003)(83380400001)(86362001)(8936002)(6636002)(54906003)(110136005)(16526019)(2616005)(47076005)(336012)(426003)(508600001)(2906002)(36756003)(81166007)(1076003)(36860700001)(356005)(7696005)(8676002)(4326008)(40460700003)(5660300002)(70586007)(70206006)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 09:41:30.4702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b776cd8-8701-4c4a-de94-08da4869e6c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6396
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Getting below errors:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1414:5: error: implicit conversion from enumeration type 'enum scan_direction_class' to different enumeration type 'enum dm_rotation_angle' [-Werror,-Wenum-conversion]
                                mode_lib->vba.SourceScan[k],
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1744:22: error: implicit conversion from enumeration type 'enum scan_direction_class' to different enumeration type 'enum dm_rotation_angle' [-Werror,-Wenum-conversion]
                        && (!(!IsVertical(mode_lib->vba.SourceScan[k])) || mode_lib->vba.DCCEnable[k] == true)) {
                               ~~~~~~~~~~ ^~~~~~~~~~~~~~~~~~~~~~~~~~~
2 errors generated.

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_util_32.c:5484:18: error: implicit conversion from enumeration type 'RequestType' to different enumeration type 'enum RequestType' [-Werror,-Wenum-conversion]
                        RequestLuma = REQ_256Bytes;
                                    ~ ^~~~~~~~~~~~
18 errors of similar kind

[How]
1. Add typecast at relevant places
2. Move the enum RequestType definition ahead of declarations

Signed-off-by: Chandan Vurdigere Nataraj <chandan.vurdigerenataraj@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
index b77a1ae792d1..5828e60f291d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
@@ -1411,7 +1411,7 @@ static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerforman
 				v->BytePerPixelC[k],
 				v->BytePerPixelDETY[k],
 				v->BytePerPixelDETC[k],
-				mode_lib->vba.SourceScan[k],
+				(enum dm_rotation_angle) mode_lib->vba.SourceScan[k],
 				/* Output */
 				&v->DCCYMaxUncompressedBlock[k],
 				&v->DCCCMaxUncompressedBlock[k],
@@ -1741,7 +1741,8 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
 	mode_lib->vba.SourceFormatPixelAndScanSupport = true;
 	for (k = 0; k <= mode_lib->vba.NumberOfActiveSurfaces - 1; k++) {
 		if (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
-			&& (!(!IsVertical(mode_lib->vba.SourceScan[k])) || mode_lib->vba.DCCEnable[k] == true)) {
+			&& (!(!IsVertical((enum dm_rotation_angle) mode_lib->vba.SourceScan[k]))
+				|| mode_lib->vba.DCCEnable[k] == true)) {
 			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
index 6509a84eeb64..07f3a85f8edf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_util_32.c
@@ -5314,9 +5314,15 @@ void dml32_CalculateDCCConfiguration(
 		unsigned int        *IndependentBlockLuma,
 		unsigned int        *IndependentBlockChroma)
 {
+	typedef enum {
+		REQ_256Bytes,
+		REQ_128BytesNonContiguous,
+		REQ_128BytesContiguous,
+		REQ_NA
+	} RequestType;
 
-	enum RequestType   RequestLuma;
-	enum RequestType   RequestChroma;
+	RequestType   RequestLuma;
+	RequestType   RequestChroma;
 
 	unsigned int   segment_order_horz_contiguous_luma;
 	unsigned int   segment_order_horz_contiguous_chroma;
@@ -5350,13 +5356,6 @@ void dml32_CalculateDCCConfiguration(
 	double   detile_buf_vp_horz_limit;
 	double   detile_buf_vp_vert_limit;
 
-	typedef enum {
-		REQ_256Bytes,
-		REQ_128BytesNonContiguous,
-		REQ_128BytesContiguous,
-		REQ_NA
-	} RequestType;
-
 	yuv420 = ((SourcePixelFormat == dm_420_8 || SourcePixelFormat == dm_420_10 ||
 			SourcePixelFormat == dm_420_12) ? 1 : 0);
 	horz_div_l = 1;
@@ -5527,11 +5526,11 @@ void dml32_CalculateDCCConfiguration(
 			RequestChroma = REQ_128BytesContiguous;
 	}
 
-	if (RequestLuma == (enum RequestType) REQ_256Bytes) {
+	if (RequestLuma == REQ_256Bytes) {
 		*MaxUncompressedBlockLuma = 256;
 		*MaxCompressedBlockLuma = 256;
 		*IndependentBlockLuma = 0;
-	} else if (RequestLuma == (enum RequestType) REQ_128BytesContiguous) {
+	} else if (RequestLuma == REQ_128BytesContiguous) {
 		*MaxUncompressedBlockLuma = 256;
 		*MaxCompressedBlockLuma = 128;
 		*IndependentBlockLuma = 128;
@@ -5541,11 +5540,11 @@ void dml32_CalculateDCCConfiguration(
 		*IndependentBlockLuma = 64;
 	}
 
-	if (RequestChroma == (enum RequestType) REQ_256Bytes) {
+	if (RequestChroma == REQ_256Bytes) {
 		*MaxUncompressedBlockChroma = 256;
 		*MaxCompressedBlockChroma = 256;
 		*IndependentBlockChroma = 0;
-	} else if (RequestChroma == (enum RequestType) REQ_128BytesContiguous) {
+	} else if (RequestChroma == REQ_128BytesContiguous) {
 		*MaxUncompressedBlockChroma = 256;
 		*MaxCompressedBlockChroma = 128;
 		*IndependentBlockChroma = 128;
-- 
2.25.1

