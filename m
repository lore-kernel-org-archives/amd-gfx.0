Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57C2CC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6A8210F386;
	Fri, 21 Aug 2026 16:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ddvuepgK";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010058.outbound.protection.outlook.com
 [40.93.198.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D5CF10F348
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:11:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGGq2kRoN5WuOzsGRAlmIG7bocF/QzFsFDRg63qXHoRitMSL5oXSd8D6vImp1PF4h+XT/DNIE+7Ebx3YyqovInJa2njOXhdJmyFMGUfJ1kEkcm7m2FQuQp4fUUEvhXqHeHoQG53My9ie/YCFoIVrr7ikL8T6Xmt9FqL0JbePN8PKf22zsFbYu/I04bqikBMLhSnI/yUlueHraNEdYKipn+Mogea6ga1na8enS/5eEP+R/aSueihTV58pdF1Ff1zfTGDtcaGUrqarRQn1k2DXdin1/auBY5edBeQ4XzbCbsIKKe5RYSuqL64lLE2Ma1HmjOi+qe0umavFSVlbda98PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cA2Ko9+qrWAgGBGiBnY0P5eAy//hnhCudYc+A/0hNY=;
 b=l0HPf0X8D36P5lR9QHUHUl149qBEfcqhQSF+LuZsEN5ZFBubRZ24ZEEvH8flnN/GgEXdJECgsqfwrkafuwTFAsiZRe5pqPFLPXXI6uMWBRdRMqVKLai5bNDu8SG5mw1gHKXVzHGhmnfymYqjUWj47CU0s2gJoeOfvB5f1dkATxUQOgoagYAKqC1xJaORSklVuBQgQgSfHsmemtobOkkDNsOxR4T/oCQGPtoayB4Qda46xvwgniAuhU+0c23EW0wuIwybJTHsha/vvdGUaBXyTREbes8fyFmHOj4IB04CzrSyILUH1uNlOncJQfmclbLLAO0LGIPZ0fT67ywZzLtqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cA2Ko9+qrWAgGBGiBnY0P5eAy//hnhCudYc+A/0hNY=;
 b=ddvuepgKX1tvBQo5BJBxyXr0eDirNfi+pD/tMzK0fF/i/88s2/sH2gr4SQJlrFZr9bgLEvDnJskntfHwK4k85xvFXqsoIv9VkcEpZxRDbfWsOi0W9LTehjg68nu/xXyXh7J9PwWKhOvwiTz89uek6eLFyybfCT/aCKIK5UjR994=
Received: from SA9PR13CA0133.namprd13.prod.outlook.com (2603:10b6:806:27::18)
 by IA0PPF7D094C5BF.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bd4) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 16:11:14 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:27:cafe::4c) by SA9PR13CA0133.outlook.office365.com
 (2603:10b6:806:27::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Fri, 21
 Aug 2026 16:11:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:11:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:10:55 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:10:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Le Ma <le.ma@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add get_rom_offset callback for NBIO 6.3.2
Date: Fri, 21 Aug 2026 12:10:47 -0400
Message-ID: <20260821161047.753227-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|IA0PPF7D094C5BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 521d1cf0-5275-40d7-ee6a-08deff9ed2d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: zt6zT04bDoYQCkRMVgsb0ZJneKnEN+4KQhYVwqHTbTZMr4DvCR/ncTeqDjUDyyjbRMGPo1z7qVccAqhd58woRC5T+ickvw3/dSR8gyqC7rdTtyE/hTX5EdA27rTOHep70Uqcx1OTGa49Hbp84TRfm2gW2DXtcpUd3/jjl8049IHm5iFoxn5t96NgBexVhXz6PDBVWTXwvBtwSR2X4cN/BSn3aIUd40IRUZY8/pjHjzmoJcboMsOCgViZ7DL5wF/0kHX6ZzxN3AfhH9iP1U5mZb+14dSoCCeljR9f7+b4/Op0oQ00tw0hc5wwdr+Qe0EJsSI9oiRGA65veV2yJ8kha7sO85PhOedE6rZ8buTW0/KCUd1/XU9g4UY8q023gTeA4YXTbhRy+6N52O0r65WgQze0FOL8TZh0sPrqO6NOev0IedfXx4AAuOgbIXTdcTn125JeRdxumh8JfdsU6DbLcpDd1c73iupOnDK+Zg6BpN2NEPCj12RKWeB1b37Zqz03aZYAI+Rv/B6UJsa/kpe8UBYAE+tVEWVe0QpQB8zyhG5dHj6hhOxRKO68peyJ+CIvRVc764D08pgQYIW6WDRNQzMq5ccUGuIAlxESdKc7VVLfN1dkD6A//KK6tz/SBjSwr86FO0W20tgTw49/FY5jQC/WLoRqtBBf40eUBrfM/AHlEWGrRDnhmw6DVGvQ2odBAcHOBad7ic567jzXbipaag==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pg32QxsNdtEI1NTFWZaojbCOCA1C17awxelzPXoCQB9GL8ZtoxvQX0TH8esImLstaF50/8kDrtOhGFMw7a+2wW4xV6DdVlGrlL3JV5aIb4EAEImbvFuo9b4s9A/lVz0uvodsK0XAea/zkjuAL3lIgryEUOdwCV2GWLHz8ZtJDaOTVjCDs9Iy3XRSEci2uYwMe9TNMEo+y35xMr/bI5PJbQql6LdWLPe9xmwOFfr/nNipHUleseZXcoFiYHlC1s2DNiNpYQ0Kb1zGJa/cGaTVakxSWNHCHZkbXf87T3r5BT0UAcSSqTNJ/5Iws2R6ds9NwvtEHQ6hEkfUmsdEoZqX0S9sKLjaRUfn0jSvYkxgKaJkj4yO035D4OnXjm0KuajcKzWvOTaNbSapg08I/hsm7yLsdtVTihQcq8pY70o79M+AYttyfd8++d+vyJjLmT1u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:11:13.4690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521d1cf0-5275-40d7-ee6a-08deff9ed2d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF7D094C5BF
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

From: Le Ma <le.ma@amd.com>

Add the get_rom_offset callback to retrieve the VBIOS ROM offset
from REGS_ROM_OFFSET_CTRL for vbios imaging fetching from spirom.

Signed-off-by: Le Ma <le.ma@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
index d249011b2cf77..a40a13ca10113 100644
--- a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
@@ -83,6 +83,21 @@ static u32 nbio_v6_3_2_get_memsize(struct amdgpu_device *adev)
 	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
 }
 
+static u32 nbio_v6_3_2_get_rom_offset(struct amdgpu_device *adev)
+{
+	u32 data, rom_offset;
+
+	data = RREG32_SOC15(NBIO, 0, regREGS_ROM_OFFSET_CTRL);
+	rom_offset = REG_GET_FIELD(data, REGS_ROM_OFFSET_CTRL, ROM_OFFSET);
+
+	/* Temp W/A for nbio v6.3.2. Retrieving rom_offset as 1 but vbios
+	 * image is actually located from offset 2
+	 */
+	rom_offset += 1;
+
+	return rom_offset;
+}
+
 static void nbio_v6_3_2_enable_doorbell_aperture(struct amdgpu_device *adev,
 						 bool enable)
 {
@@ -366,4 +381,5 @@ const struct amdgpu_nbio_funcs nbio_v6_3_2_funcs = {
 	.sdma_doorbell_range = nbio_v6_3_2_sdma_doorbell_range,
 	.vcn_doorbell_range = nbio_v6_3_2_vcn_doorbell_range,
 	.init_registers = nbio_v6_3_2_init_registers,
+	.get_rom_offset = nbio_v6_3_2_get_rom_offset,
 };
-- 
2.55.0

