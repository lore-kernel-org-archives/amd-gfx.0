Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D80C5DF93
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:05:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D139510F33E;
	Fri, 21 Aug 2026 16:05:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NsNhBzY3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013066.outbound.protection.outlook.com
 [40.93.201.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D6A10F33E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:05:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uEn14yMrVV+iAMZ3FpAheInnlr4fd2rPxdGrlgBwZiGQodaIdXxz2ZteVYyJtg2XvUtroNLj0pQJWbUvwaB9twVyBYtU2zXbFR23u8xiFZQwD2OVO9dmS2cga0UNqBYxseciFbHaidgmBj9yGm0XeL7MXzKBIAIEjOb3urolSuRKd05r41YaZKQ7b5bguOIns82btaI8eTT2cdDTQyiw+daazxCFV0gfxfI7GNnBQVOfXBMoJj/wiXi3de5zhst57dTykEPNPpX2jSs228Na2iRrXW0mDdHA12qrQkQIRzHrLhnyQt4YbhcpCQuBl3xckJyIdK7O2wah+4W+rYm2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=goAlDDfSG6JE7YT7qXdZHqvqAOKlsBpCEW3toMioRkI=;
 b=dpQoIXEX44oKqYzjsHEaMJnksDqCHqSu8nu+GFZcmU3hlZmvtpgoiUmpRL7SMIOkfY5w4hyNyFwK+0HrkSOLXH39C5ib5wF31qd91yl/EOL/biDz/yt2kKvi/u59b3KtccGaCB6qmTNxKrgZugZAr1BlP8ZGGZz8lkP+WErUHOCCy+4A6tSxnBuZ+LGf7zJSZEgBuK3AO58htdWNIrdL8z6RFIDm1q1eoxBu8zt6xCgPdNG+DHEF4V8YCieTWgvF96lM8w+qQSWZ6BnnDGNBo+8475hQrdIiWV0s+CKv9gfbgc31ZvNuQRyk5Ebit/w90TP5sIPX/dAtSYTeh8UP+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=goAlDDfSG6JE7YT7qXdZHqvqAOKlsBpCEW3toMioRkI=;
 b=NsNhBzY3QTbP9GSX3lvhJaVi9RFLPOCVH8yx2YJtE7JEFTh5sr3eX+dKA3hYp5bxQ34L2dfreWM96WT4oPWMnQ3okSy3fqPEhgWYDK1WlRATTtD32/8zpxH0ilEYcbG866tiSzdU3qbA2OOWcfGQ9OmSxIRU42fxCZPXhfUFFmQ=
Received: from MW4PR04CA0139.namprd04.prod.outlook.com (2603:10b6:303:84::24)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Fri, 21 Aug
 2026 16:05:48 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::9d) by MW4PR04CA0139.outlook.office365.com
 (2603:10b6:303:84::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Fri,
 21 Aug 2026 16:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:05:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:47 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:05:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: Init partition_mode and xcc_mask for
 GFX_IMU_PARTITION_SWITCH
Date: Fri, 21 Aug 2026 12:05:35 -0400
Message-ID: <20260821160541.752029-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: c024841c-2066-4db0-6979-08deff9e1094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: hgU5HSXK38jcNyL4MhnVBUxsUVKXjp/jap1TULyA6qMLbJ4h/uw/f8fScSDkJdUOI72lhhZmpfJkVIIRmOiwU2oYtv/m7hr3UYv2sPOGNUpIPL3WQnq9gucbI8jDMGWE7SmWUAMaDoSZWPt2rRmd1/CKpj5C8Hc+YVKZW1pZsI9WKZ5M9uNbWC9exSPZLMqqZ/3pUq2X83y2pcV17Kjh0/vek9CpsLmj8oXY9Fgp40WA8rYluwf9k7vLNmFo6S6U+xv15sd+hGSKj17bwKi1cmd/EsVf8A5juXdY29XfSnIEa0sRPNOJzOzst1R8tgDN7AfMSf26top4xWOSDBzEku057aMEnZ9VGPBgQxCXDPYu4OPjPuBj2u5brjJpITkxLWRk7WRiO3urZr6p4YfwqrAvmJV5lFiU8OOG8rBM4ARMwGUpChpua63q+T6nryQLi1uMvKur+vzOJoDupha7uy4m8ZGZpp8P2H0NmCMmT3932Y+wgb9YZkD/PO1CYiTtGBCsZ4xYOzuuCJvygAmUgbojIhxjliQwsEYcTxqcTeo4N7uCfcC3hSS/N4LfyOCFVADoEQHdQZ+p/tkOuypnJ9N3O7cHikGrV1P6BHGGRLbDsR2/eE/WbrbCbWt1qWV65RzY1OWpDmXQAkCm+wb7QCUFy3VfYC4RsUZ4aL0awF8zGS6COr3FFMqZhRpX0LHU96oTnxAa8D7S+RUJO+nwnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RgcFWwtRrMKbVRrYizCfyLZ+aLIpNxmcB9NaTwAvTSXnNJJAV178zMagYt6xcVgoxkmBD+o8YE1Kofcm3vB++X8Cd63YS01Y2LNm89vpFUmrYiYwA8TzT1sNZ11HFKIKHeXfVSiDS/eXfwMpNw/emjuAmor4v7TcXgiXRohhXBUf26vdCU1rrIumNWItjRn365C3dvue1JAPsjzb7hbkCNz/CwgoJhpxpuFvF6wUcfGf2VW0UHK+nGgJCZ/qI5263Dw4Sx7IAcCIHaCdmv8hWjR0M12M5TmjGiiKhUDv5j901AkFvThAX3XT/U8QNrKXMFvVbMwrn3z2h7rYsFB1Z7ggj0qJ4PLubh6QXKWyx6xADasKW88nURGBw13iKrNf0a6ArLW5Y17gYlCh4BxRJKJxZdzzEMkGc+pfS7RdfxJvSmuJ+g0UxA7rWwqVtcps
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:05:48.0158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c024841c-2066-4db0-6979-08deff9e1094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Set partition_mode and physical xcc mask fields in
GFX_IMU_PARTITION_SWITCH register

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/imu_v12_1.c | 48 +++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
index fe20cf2b94545..ed9c5b3f76b6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v12_1.c
@@ -133,16 +133,62 @@ static int imu_v12_1_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
+#define regGFX_IMU_PARTITION_SWITCH		0x5f8c
+#define regGFX_IMU_PARTITION_SWITCH_BASE_IDX	1
+#define GFX_IMU_PARTITION_SWITCH__PARTITION_MODE__SHIFT		0x0
+#define GFX_IMU_PARTITION_SWITCH__TOTAL_XCCS_IN_XCP__SHIFT	0x2
+#define GFX_IMU_PARTITION_SWITCH__VIRTUAL_XCC_ID__SHIFT		0x9
+#define GFX_IMU_PARTITION_SWITCH__PHYSICAL_XCC_MASK__SHIFT	0x10
+#define GFX_IMU_PARTITION_SWITCH__PARTITION_MODE_MASK		0x00000003L
+#define GFX_IMU_PARTITION_SWITCH__TOTAL_XCCS_IN_XCP_MASK	0x0000003CL
+#define GFX_IMU_PARTITION_SWITCH__VIRTUAL_XCC_ID_MASK		0x00000E00L
+#define GFX_IMU_PARTITION_SWITCH__PHYSICAL_XCC_MASK_MASK	0x00FF0000L
+
 static int imu_v12_1_switch_compute_partition(struct amdgpu_device *adev,
 					      int num_xccs_per_xcp,
 					      int compute_partition_mode)
 {
-	int ret;
+	int ret, i, num_xcc;
+	u32 tmp = 0;
 
 	if (adev->psp.funcs) {
 		ret = psp_spatial_partition(&adev->psp, compute_partition_mode);
 		if (ret)
 			return ret;
+	} else {
+		num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+		/* 00 - SPX; 01 - DPX; 10 - QPX; 11 - CPX */
+		switch (compute_partition_mode) {
+		case AMDGPU_SPX_PARTITION_MODE:
+			compute_partition_mode = 0;
+			break;
+		case AMDGPU_DPX_PARTITION_MODE:
+			compute_partition_mode = 1;
+			break;
+		case AMDGPU_QPX_PARTITION_MODE:
+			compute_partition_mode = 2;
+			break;
+		case AMDGPU_CPX_PARTITION_MODE:
+			compute_partition_mode = 3;
+			break;
+		default:
+			dev_err(adev->dev, "Invalid compute partition mode\n");
+			return -EINVAL;
+		}
+
+		for (i = 0; i < num_xcc; i++) {
+			tmp = REG_SET_FIELD(tmp, GFX_IMU_PARTITION_SWITCH,
+					    PARTITION_MODE, compute_partition_mode);
+			tmp = REG_SET_FIELD(tmp, GFX_IMU_PARTITION_SWITCH,
+					    TOTAL_XCCS_IN_XCP, num_xccs_per_xcp);
+			tmp = REG_SET_FIELD(tmp, GFX_IMU_PARTITION_SWITCH,
+					    VIRTUAL_XCC_ID, i % num_xccs_per_xcp);
+			tmp = REG_SET_FIELD(tmp, GFX_IMU_PARTITION_SWITCH,
+					    PHYSICAL_XCC_MASK, adev->gfx.xcc_mask);
+			WREG32_SOC15(GC, GET_INST(GC, i),
+				     regGFX_IMU_PARTITION_SWITCH, tmp);
+		}
+		ret = 0;
 	}
 
 	adev->gfx.num_xcc_per_xcp = num_xccs_per_xcp;
-- 
2.55.0

