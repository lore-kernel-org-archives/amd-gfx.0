Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454E0C624DB
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Sep 2026 10:06:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B465310E5D8;
	Sat,  5 Sep 2026 10:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C89akD7A";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012070.outbound.protection.outlook.com [52.101.53.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B29210E5D8
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Sep 2026 10:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VOIGVwj0em6zNU1QY4nMMcejGE7kZL2XI46yeuoYyTLxf4SDnU9llX7+Nvg/Yw3kwPeJ0n96rZnAuo/Du19Ic9u8xh1e1sEXtMp1ySjvkeZmoCkwOhYRt/Uup/2kT4+cayKXPNWmUVip6mgdQrtaoUSRgODlGWd7CCDeIh8v3diMx9K/X9k2VYeOBjRypHMqP7X+ydDUouXi5rfWGgYkbRn1y19k1LVQ8g0ChuRRhNex85/OWEKTuCy1LWpsQQOiLlKnTs9eogccz7F5KC3MBmdHV3B3ZUOCDNTIxHlsGaiK0kbeNL6AyN4NuOfzztu+3szQd62Ykm+9arJ2o/VhPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LebVh6tnPSXjin1zVSy5XWOf6lr5mhuSIJB8edHLajg=;
 b=TNzFkfdbNEK+/lGjfdQ0Z5zUcaTR+w+LblZhVPTiTXP1DBR7J6zHaYwYFRQy/1J+1HYKhTPz4v88Un1SBcholsvah/RnG7ALyvg+1kP24ZdQ17hsCUpamLO44AlzKu3N6yG4AJfI5Yy09k4Ev6oyHaABEdEQp12+PzMXkNQsTNQ0pIZhZ9gznwdq5hMTSgvEj61tYXmZPlEymJlXJ+UI77nQ6IK3+LhHnTphaw74pQjMe5Q4thqMuOEfLmmRZsyMp5TLkG6f3gWkmTmZBbwE3lPg+QBtAhoKfW0JuL2KT852avVB0N5ysjw3su4abHcoTguJiN70MxXGMIOCXB6GuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LebVh6tnPSXjin1zVSy5XWOf6lr5mhuSIJB8edHLajg=;
 b=C89akD7AMoLAIVx05xMEaXg+tixYVg4C3O7b5pXunVsmNBUeVaHv+MHlFk8RcXj7TpI6gMiEcb2rlbYeydlMUwjv5usSr9iqfBQGsrNVuiTVczPdTG8o7CRHMR6cZMTAQtyLARH/Rl5GRIW1jPcK2ueMoiyVNGkSlkiWqJkiH3Q=
Received: from DS7P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:25e::10) by
 PH7PR12MB6908.namprd12.prod.outlook.com (2603:10b6:510:1ba::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Sat, 5 Sep
 2026 10:06:13 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:8:25e:cafe::16) by DS7P221CA0029.outlook.office365.com
 (2603:10b6:8:25e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Sat, 5
 Sep 2026 10:06:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Sat, 5 Sep 2026 10:06:12 +0000
Received: from hawzhang-System-Product-Master.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sat, 5 Sep 2026 05:06:11 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Likun Gao <Likun.Gao@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH 05/13] drm/amdgpu: Use common doorbell helpers in nbio v4_3
Date: Sat, 5 Sep 2026 18:05:30 +0800
Message-ID: <20260905100538.12877-6-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260905100538.12877-1-Hawking.Zhang@amd.com>
References: <20260905100538.12877-1-Hawking.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|PH7PR12MB6908:EE_
X-MS-Office365-Filtering-Correlation-Id: 9736c2ae-d6f0-425b-a12c-08df0b3550e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: xPl7LqYlAXZoUSY5DG+DiPCQEVvHz88n8aniU1lK22ZnHQekJgu1j/MemTu2sy1bMlabu/KnYryBI081N12+Ourv7BAjsSEc/LHiMLhYhKntxn2xD3LCUH+df6J1HAUwNAOf0hdllZppCxDSLsBuCfT4K6zapXWF1FG+UonXmuX6QHmRqLMuMM//qpIDtTrEpAV9NlwSwXhL/Fc25cVDsVumg6oxIjKZsxT2W3wEJx4JhNWI8J+AQzWStYUAOG6MLy6HOBQeNv8z2DgfsDtBZNwrJKTxtjtdUm8j2IR+XlCEFVJJAYERc5t4aI0VpXlztPR/+5anbZhK87A0ntESeB8bHYURj3a/W7equpFtl3oqS/LvsfsEH0G6iWbK7W9KFNpoqG9cz7KhynJnuo4tNVoB+DTRTAjPstsWXnkIc7Y0hwuriWnSILO4vHpmwbj2B18Dp6L491hMSmxa0hQf6UrS2Yep5JimNSM8rMEq9L9avgL5DNs0ywNdrQnH/Axl/godF5jfV4qaFxcqakXEyE5RTX1bftLQh5y44wPanCcsgaNp7P5cDvxipngV+KvvwxlXtc31BA5zTJhNJfbz5EiZgn1QcZYrp6qrq50gEzN6MetS78T4X4+18W6tvozm9NdexEfAnE+maOPw46K9ABI8VwiIvTfetQb3pMMPXoq6hVrEgJrTpQ2t9zugA/T7qJUmjf5XASG76pihsOGfXg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8WET4Li5R05WwC02NpxxqQ/2JU167VWy69vO1dXpDk6Jiua9Okn02j5xRTc0edZXb7mqfqAZUqxB7hLVDgz/UOblO/Lmzw/3cRiFUUNm5v4Tu/nWefi5cReR6UVJq2xlcGs/18CkOSc+Saw+OUCCCZMVmVZ1oznDXzH0hB2uIhI5YrR8E9npNNSImEUZl2F40a/XDtPa0BHzSrkoq4KQchMmXDG7Jl/zm84qC0X4aBrZK9UUuSZqZMGzq7MLVDTtijJD2/5Nh+aznS0f0b0Zmxpdg5gnHFljdV2WNt8CVK2xOVFE8f/YP2k1kcp2Qst1OtYVPJ4F838SOc6sMS8S/WRBf4iWOtfUmBgiugJBmOh18h5Fth9wCRgjVIFvRgSdvjslWnA2n3jx8nE8WOe878CzjEB14p+elUa02I7OGT+5rDeuMtOFyu25cQoJtaEQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2026 10:06:12.7841 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9736c2ae-d6f0-425b-a12c-08df0b3550e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6908
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

Build and program the CP, RLC, IH, SDMA, and VCN
doorbell entries through the common NBIO helpers
while retaining the existing callback interface
and v4_3 client routing values.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c | 188 ++++++++++++-------------
 1 file changed, 88 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
index 6d12324ce663..be98fee6fbf2 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -140,87 +140,86 @@ static void nbio_v4_3_sdma_doorbell_range(struct amdgpu_device *adev, int instan
 					  bool use_doorbell, int doorbell_index,
 					  int doorbell_size)
 {
-	if (instance == 0) {
-		u32 doorbell_range = RREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_2_CTRL);
-
-		if (use_doorbell) {
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_ENABLE,
-						       0x1);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_AWID,
-						       0xe);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_OFFSET,
-						       doorbell_index);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_SIZE,
-						       doorbell_size);
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
-						       0x3);
-		} else
-			doorbell_range = REG_SET_FIELD(doorbell_range,
-						       S2A_DOORBELL_ENTRY_2_CTRL,
-						       S2A_DOORBELL_PORT2_RANGE_SIZE,
-						       0);
-
-		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awid = 0xe,
+		.range_offset = doorbell_index,
+		.range_size = doorbell_size,
+		.awaddr_31_28 = 0x3,
+	};
+	u32 ctrl;
+
+	if (instance != 0)
+		return;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance,
+			NULL, NULL);
+		return;
 	}
+
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_SDMA, instance, &ctrl, NULL);
 }
 
 static void nbio_v4_3_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
 					 int doorbell_index, int instance)
 {
-	u32 doorbell_range;
+	static const u8 vcn_component[] = { 0x4, 0x7 };
+	struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_offset = doorbell_index,
+		.range_size = 8,
+	};
+	u32 ctrl;
 
-	if (instance)
-		doorbell_range = RREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_5_CTRL);
-	else
-		doorbell_range = RREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL);
-
-	if (use_doorbell) {
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_ENABLE,
-					       0x1);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_AWID,
-					       instance ? 0x7 : 0x4);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_RANGE_OFFSET,
-					       doorbell_index);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_RANGE_SIZE,
-					       8);
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_AWADDR_31_28_VALUE,
-					       instance ? 0x7 : 0x4);
-	} else
-		doorbell_range = REG_SET_FIELD(doorbell_range,
-					       S2A_DOORBELL_ENTRY_4_CTRL,
-					       S2A_DOORBELL_PORT4_RANGE_SIZE,
-					       0);
-
-	if (instance)
-		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
-	else
-		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
+	if (WARN_ON_ONCE((unsigned int)instance >=
+			 ARRAY_SIZE(vcn_component)))
+		return;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+			AMDGPU_NBIO_DOORBELL_CLIENT_VCN, instance,
+			NULL, NULL);
+		return;
+	}
+
+	fields.awid = vcn_component[instance];
+	fields.awaddr_31_28 = fields.awid;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_VCN, instance, &ctrl, NULL);
 }
 
 static void nbio_v4_3_gc_doorbell_init(struct amdgpu_device *adev)
 {
-	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
-	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+	struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.awaddr_31_28 = 0x3,
+	};
+	u32 ctrl;
+
+	fields.awid = 0x3;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_CP, 0, &ctrl, NULL);
+
+	fields.awid = 0x6;
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_RLC, 0, &ctrl, NULL);
 }
 
 static void nbio_v4_3_enable_doorbell_aperture(struct amdgpu_device *adev,
@@ -256,36 +255,25 @@ static void nbio_v4_3_enable_doorbell_selfring_aperture(struct amdgpu_device *ad
 static void nbio_v4_3_ih_doorbell_range(struct amdgpu_device *adev,
 					bool use_doorbell, int doorbell_index)
 {
-	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_1_CTRL);
-
-	if (use_doorbell) {
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_ENABLE,
-						  0x1);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWID,
-						  0x0);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
-						  doorbell_index);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  8);
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
-						  0x0);
-	} else
-		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
-						  S2A_DOORBELL_ENTRY_1_CTRL,
-						  S2A_DOORBELL_PORT1_RANGE_SIZE,
-						  0);
-
-	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
+	const struct amdgpu_nbio_doorbell_fields fields = {
+		.enable = true,
+		.range_offset = doorbell_index,
+		.range_size = 8,
+	};
+	u32 ctrl;
+
+	if (!use_doorbell) {
+		amdgpu_nbio_program_doorbell_entry(adev,
+				AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, NULL, NULL);
+		return;
+	}
+
+	if (WARN_ON_ONCE(amdgpu_nbio_build_doorbell_entry(
+				adev, &fields, &ctrl, NULL)))
+		return;
+
+	amdgpu_nbio_program_doorbell_entry(adev,
+		AMDGPU_NBIO_DOORBELL_CLIENT_IH, 0, &ctrl, NULL);
 }
 
 static void nbio_v4_3_ih_control(struct amdgpu_device *adev)
-- 
2.17.1

