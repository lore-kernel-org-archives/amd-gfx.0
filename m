Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B866C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:06:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2DC010F34A;
	Fri, 21 Aug 2026 16:06:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bX+MWBo3";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013053.outbound.protection.outlook.com
 [40.93.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80D0E10F34A
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jw/oLJaseVMyaSMwAtyVXN0yUQfbZL65xBd5c15+CbzXhnSuHQET44CUMcnTCHGzxu7ExsGamwUPqH8xGBsPdgcCaaLyf4giuGqvzW/mt+7LMA9iXmjN2MDyFPCiCqqE21z7iWosOWswHz1U04Pzz8HbtIgMZvCtERW1PzP//vnflMrDg2UKU7KXx+l7Eidbj6asN+9k0x5DvFZsXrK9Z477ju1VSVep0C1UMgcpNfzfoLfJwiSPBNSYtZJ9WSsRN8NE/GnvMSC39xEf6O6FWFeqXb++cfVZaEK9hEyXaC3Ay6KNQmXb6YwLTIbv2dPC3nfSXAVp/8MW9GSn/yrYEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKm71ES0JIvhzon+5flM52u8o7z3BjZk5+EyuMpq4Ds=;
 b=WuPQVioHuGSJVs9Ytj/UIApyE+v29yeai88MohETgyIYGfI70LJl2Nsmqvvj/ByNPApXyq5PNihEcjC2rQ1wjgPuGf7iTVKmRcvDIM4OEF+dWmZHtkkEcweV5IGsUp3u+v8hvrcndXoiKJdf4tIzPzw4MqV8ammqlnEeBv1MIa/Uhp8oWS0Q0Smx+vQ1UE2zLH/OsOj6nfEqfvhOZVj6JQIWKij4xOdEoKomrF7H4jGYKgScMYeRiz1DZykbj98DQmnaus91gkQG9hBWE1GAg2FAHFV9UZYVt5Tqoxsr5y0EKRVR4BxQhmn61bcIwrRbU/twbtOlpClrxEl2H93Axg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKm71ES0JIvhzon+5flM52u8o7z3BjZk5+EyuMpq4Ds=;
 b=bX+MWBo3ZS95XUUqsLeb1Dj23Is6kCVDwgMW8u2sQIEHtkbvQ6L35iz0quyuMD8wUFwQTP21krOXV9EGWTAB7tRSxhq5w9CPQ6+LCDn4j00iQnJDx7Nu8Q7lW4tMRYHhrUlVRuyuWmXEc8U6vNX0PcmNN5an9UBijC9nEhUrjOg=
Received: from MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6)
 by CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:05:51 +0000
Received: from SJ5PEPF0000020A.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::1) by MW4P220CA0001.outlook.office365.com
 (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.12 via Frontend Transport; Fri,
 21 Aug 2026 16:05:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF0000020A.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:05:51 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:05:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:05:49 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5/7] drm/amdgpu: Use partition switch shadow register
Date: Fri, 21 Aug 2026 12:05:39 -0400
Message-ID: <20260821160541.752029-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160541.752029-1-alexander.deucher@amd.com>
References: <20260821160541.752029-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF0000020A:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: f4fbacdc-5dac-4976-c996-08deff9e1260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|11063799006|18002099003|22082099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: pAdpwumCbxU+pXzhh35uumifc8Z/KAn8oITcDe6txuLAqrjEeu/gDqqO+x6NOeTLo3ogeWSvEmBTvuqVzfU9ln6ZnNLve0MXx58wHk5rOBMVuqsHTHwoEbcfofhZ4qHZ20Ho2PPp4H9qEcXkU/4B5u7IBFxl870b+PfUxG6BcN+zsWwJTqFc4EkZC1oz4eHVRFRsdxcy91qpyfNVIUMHI0GB+ZOi2s+obPictT5jYqCoYpmFMrsYbatO77bjvyjlQOKucxMURwq9GaIuBijwaVxLXLXPuueRlMK+3cy6YKbU53TXm7SVCLt5HMy1uq+GuicIkkEGGUQcD6nmfMIKH9kwDdNhHjMogCGyw70+mXOv3DiCDXvLnxqyVg50a1JBeVubY0/k15eIe26Tp9QIHfpNP8raBTBYbfWE85bFxKd09SbU5Ilw61jdUN+Nm6ZPNoxgG9WEpGfXrU6C+UKCDGSIGPi1a3qp8J7eVjSbcWTZ6JWA78BKgXckMJddjKh8ES6AWNhN+7Oxyr1VItpKtOACN/pTkMc0sBOHxjM7cWzCZggeLyPMVO/Fq4NrD0OVTRtXwMjjFDYTFrHxZrf5Tgg2xz3HiLw08oQwKXoSK8GMirMfVV80nQIsglrXI+VGMlOFZCtA5Zx5w8v0k9zp8yoS40QOrfeYpN1t9Dh75L8l++gHYxxBRDTA+O0YoFg7RhzFNRwAg9AkHLqWxQODnw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(11063799006)(18002099003)(22082099003)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q4fgIrdyuz8d6vZJPxZdtMOKeec3vT3w9J1KhQrXh7JnoBuzvszMM3R8rO6uXEdoLu/hpZF1MeZzQSJURPtgy4Y2Rnbyfy0go6u/lm4F08xEdg4YFtkLt1Al3LEY+pYK43XzXa5mIH2kFbSPd2qk78gtkwqC9MKg0FgRwM2+yqJgUKvxImh791CBOk0b6i3utdUrpNfBe3irlfzq5RbP6C/jo7/7nYRw9j2TkoIvguF3cHRyKbUO9eOewqBSIfyVP1+qZP+kitXlPayMyEj7feor/zd2Nm2xJ/SI9LzFJ0EgCL2kiPkM0WedL+ruxRrBsq5RYo1V9OJf2WnnoCUKjSd8QwNze//NuhTDsjnxZIg6u35tnMRELPpnJGZ8RkJbJilDm7mw+DCsHNdlskbX+dBv/LR6fAa5lptQb3olf2ckK1pPqR/Kz5qCvXd7dAAW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:05:51.0182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fbacdc-5dac-4976-c996-08deff9e1260
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF0000020A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669
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

From: Lijo Lazar <lijo.lazar@amd.com>

Control register is access restricted. Use the read-only copy to read
the partition settings.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c                | 11 ++++-------
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h    |  2 ++
 .../drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h   |  4 +++-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 9dd7a33357199..3f757dfcd1c36 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -839,19 +839,16 @@ static void gfx_v12_1_select_me_pipe_q(struct amdgpu_device *adev,
 	soc_v1_0_grbm_select(adev, me, pipe, q, vm, GET_INST(GC, xcc_id));
 }
 
-#define regGFX_IMU_PARTITION_SWITCH		0x5f8c
-#define regGFX_IMU_PARTITION_SWITCH_BASE_IDX	1
-#define GFX_IMU_PARTITION_SWITCH__TOTAL_XCCS_IN_XCP__SHIFT	0x2
-#define GFX_IMU_PARTITION_SWITCH__TOTAL_XCCS_IN_XCP_MASK		0x0000003CL
-
 static int gfx_v12_1_get_xccs_per_xcp(struct amdgpu_device *adev)
 {
 	u32 reg_data;
 
 	/* the register data is expected to be the same on all instances */
-	reg_data = RREG32_SOC15(GC, GET_INST(GC, 0), regGFX_IMU_PARTITION_SWITCH);
+	reg_data = RREG32_SOC15(GC, GET_INST(GC, 0),
+				regGFX_IMU_PARTITION_SWITCH_SHADOW);
 
-	return REG_GET_FIELD(reg_data, GFX_IMU_PARTITION_SWITCH, TOTAL_XCCS_IN_XCP);
+	return REG_GET_FIELD(reg_data, GFX_IMU_PARTITION_SWITCH_SHADOW,
+			     TOTAL_XCCS_IN_XCP);
 }
 
 static int gfx_v12_1_ih_to_xcc_inst(struct amdgpu_device *adev, int ih_node)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
index 025e5490e6f12..dbd497d9fac15 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_offset.h
@@ -7369,6 +7369,8 @@
 #define regGFX_IMU_TIMER1_VALUE                                                                         0x40d1
 #define regGFX_IMU_TIMER1_VALUE_BASE_IDX                                                                1
 #define regGFX_IMU_FUSE_CTRL                                                                            0x40e0
+#define regGFX_IMU_PARTITION_SWITCH_SHADOW                                                              0x40f8
+#define regGFX_IMU_PARTITION_SWITCH_SHADOW_BASE_IDX                                                     1
 #define regGFX_IMU_FUSE_CTRL_BASE_IDX                                                                   1
 #define regGFX_IMU_D_RAM_ADDR                                                                           0x40fc
 #define regGFX_IMU_D_RAM_ADDR_BASE_IDX                                                                  1
diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
index 1cf890de35cbd..68dfafd8d027f 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_12_1_0_sh_mask.h
@@ -23556,7 +23556,9 @@
 //GFX_IMU_I_RAM_DATA
 #define GFX_IMU_I_RAM_DATA__DATA__SHIFT                                                                       0x0
 #define GFX_IMU_I_RAM_DATA__DATA_MASK                                                                         0xFFFFFFFFL
-
+//GFX_IMU_PARTITION_SWITCH_SHADOW
+#define GFX_IMU_PARTITION_SWITCH_SHADOW__TOTAL_XCCS_IN_XCP__SHIFT                                             0x2
+#define GFX_IMU_PARTITION_SWITCH_SHADOW__TOTAL_XCCS_IN_XCP_MASK                                               0x0000003CL
 
 // addressBlock: CHIP_XCD_gfxip_xcc_gfx_se_gfx_se_grbmhdec
 //GRBMH_CNTL
-- 
2.55.0

