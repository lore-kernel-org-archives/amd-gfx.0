Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3CDDC0218F
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:23:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83B5610E378;
	Fri, 31 Jan 2025 16:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ieq/lFMS";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A44810E378
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoCHnbRR1dhqQSUPe4i5bDXJn6rubgNoD/eoIQxEkhZKhA0PFukqw2Bvem7kMrbMFp2jaJP13zuQhl5YLeQ1epv8xV4KrENXscr+I+uJcDJIWq9lu8vImL30vCb5OVWc7rUCsRfbi0fAr5VoCjZQXHL7VRdTOpEdGtSKeVDIEbrfua30NpC7nIdEIOlT6qd2exWXtNIqJkvozcSLabE+LCf07bhZDjQqXF224VgUD84x1GXsKbiOqxFrGInvJGo9ZSHMTagTAvRRZfFhN6aGGUUrmOxXUhSUdu8UiSCQswcdXEqVMpRvnpABo4zxTn4Y6o86FmzQXXTt/NBhYz1dFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvMSYoGpK4Dl14vZonknKWpZy70o2R+mc1SPwaub+HY=;
 b=rujZtcydF7nLMyBamR9Q1m6Lp5Zbr/mYaocQno23AEPYk3thUBv/kRk9c8KFFDPrfQcdCLfTmlj0rZVR8thV69rEDbbovGkxTckwtLEJgwCtr6yWNvXIg+XrPqBYxIn/yWizGKIgd2mEf3rZ2gP8R0EPvVy1XS8JuLkQ8W9aB15Ao20jESWw1HHRNEff2d+WfGsrgZg7hclDDsxDTWMn9xVqUR2poXBiI5xrOpM/vrGc5OuiFsb56NROIcaXj/SWetChHu7LxkksNegqr62UBvMhlz/+q9cCobFa5fVAx4cb3o9vwPyo7pqyCZLjn8FyaaaJPRm1tolNyAp9t5Ox/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvMSYoGpK4Dl14vZonknKWpZy70o2R+mc1SPwaub+HY=;
 b=Ieq/lFMS3OXNVX9kTj6LUIaSFr6lp6nu/ws2upj5nr2EFZGI3ZPNLxY2ATnSWbGqgz9IdMz0nY/GdUnUaA/PXeq+NYqNM1nm0JlLWc4PEo22SVerO8pEswS5SQH346IWGXGtiFRbYP4yv0cYa9pEtyqs9NpRWOZvZoPuzf+f9ZA=
Received: from DS7PR03CA0272.namprd03.prod.outlook.com (2603:10b6:5:3ad::7) by
 CH2PR12MB4134.namprd12.prod.outlook.com (2603:10b6:610:a7::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.18; Fri, 31 Jan 2025 16:23:54 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::86) by DS7PR03CA0272.outlook.office365.com
 (2603:10b6:5:3ad::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:23:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:23:54 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 31 Jan 2025 10:23:51 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 1/7] drm/amdgpu: Per-instance init func for JPEG4_0_3
Date: Fri, 31 Jan 2025 21:53:15 +0530
Message-ID: <20250131162321.563314-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
References: <20250131162321.563314-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CH2PR12MB4134:EE_
X-MS-Office365-Filtering-Correlation-Id: 327fc487-d330-41d8-f6a1-08dd4213a7d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGllTm1LUlV0UU1wTkIySWpkWVZ3REY1SzFBeVoramdqZUhlRFg2UFMwMFov?=
 =?utf-8?B?c3kyVkpJQ0E4cnlFek9mcXpLeGJHOHUvc1ZSbnNNL2t3Vm9YRGkvN2Q1d2lw?=
 =?utf-8?B?QndlSUNkVFJnWlhQUWJZZEZ2TmhwTjhjcHJXTXI1dmIxWVpNekxET2lTbFJh?=
 =?utf-8?B?TzZmdzEzT3hpaGJVNW5PWjVCY2YvNEQ2anBVU0crOWJqUjZ5WjVBWjhiblZB?=
 =?utf-8?B?U2x2Zi9wbnZIazhZbC8wWndBeExML09kVFdKRHlnNkJRZXpzOUVGdUlsS3Aw?=
 =?utf-8?B?ckU5bzRyUTJTL1JNNjZHNXJwM1o3ck1xdzFHdzZBa0RoM2RubGxEQ0lYcDM2?=
 =?utf-8?B?TzJyOHUvb0xLaGk0eWV0ZmxuY1lBYkU0alVjRFNvS2NUWGlLMFQyRlExcS9x?=
 =?utf-8?B?eG0yOTZmd0RXdGdRYWZnWHFBbWJ0V0JRZGQ2amVmNUFCR1FLUmkwajZ6bDdn?=
 =?utf-8?B?Q0h1bnVzWXB6ZGVoR3VEZllCMmJidEc1VEpnd1F6djdiZk1uamxsaXpDZmha?=
 =?utf-8?B?TkRvc1N1cUg2dTlXQ0dibXdCNldFL1FSdEhhdUVqcWNQQ3JXMVpHRmRZR0oy?=
 =?utf-8?B?WDVPdDdTaVdKVGxFUUlCVXJ6UjN4ZERidUoydTNlTzFnZmM2eHZic3RCKzZz?=
 =?utf-8?B?UGRydUxOZ2NLWEIwVTFNeTRUd3EzcUVBcXF0M3hoT3BHMW9VU29PY1B1SG8w?=
 =?utf-8?B?b3Z3TDNqeWJaaXBVSG02ZkltYW8zcSsrM1NPVWE5ZkFHNllpNE9VY0ZVaG44?=
 =?utf-8?B?V3pnQ0l2NEZURE5hUnpSUE1BRHhFSElsL28vaTZsRU5MVGgwOUtrRk43OHBM?=
 =?utf-8?B?cUNDVzJjRDNoaWRsY1BPcFZHYW9XcXNBUDRkemhPakRtNzNUQXlwOEIyNzQr?=
 =?utf-8?B?bDJrRkIxc29HN0MzME9lcDRMZmRCYTltZy83SGRoUHdZQ0liQzNmTnV0RGFK?=
 =?utf-8?B?RjgySDAzdmdTSjVsSWhQTW9veDMreWNGL1M4b0J4VmUyOVFsbm40QUhyZzFF?=
 =?utf-8?B?a09HQ3pZWXZWU0ZQNE43TXRhVU5ScU9CaWpxOTg5MzFTNVJsZXBoZFF2ZEtO?=
 =?utf-8?B?bHBodlVPNlB4V0U0OXQ4b2JLenA2Qm15YURKMXZVYkNWM3NPeHBwRjZ4eHNM?=
 =?utf-8?B?aHNGTCtQQzM0a01sRVZiR0JvdStneG9BOTUrVnpBTHVzTjROWGp6SE85dFJt?=
 =?utf-8?B?MU5wN0M3bkhsdm1xbS9hYjVQNFp5bjBvT0pZOGdVMHJMWCtkK0RWeVRWL2RS?=
 =?utf-8?B?eGlyZnIvREM1cGN1RTRncmdwdmtHV2d6TFdPQVpBaTBacm9ZU3ArNGduSFZh?=
 =?utf-8?B?SHdxWnBNR0NmZDBPL2puSzV6VXJId3NjWnJaRmFiOFY0dm1Pa0M5Z2lpUW5p?=
 =?utf-8?B?SU8zRGNJalhZSGdkZmdTVVdoU0lOamJZMWd6NXE1V3o1cUd5TVNyQlZHdnR3?=
 =?utf-8?B?SHFXSXhISVRiRHFBbytMSjJpSTJXZjNrSU1lV21xb0s2NGFLdTEwWEorVklj?=
 =?utf-8?B?QjI0RkExT0FRaVR4ZW1XME05VzhvWWRKamwzK2NJOWwrYk9zeDdvVVlNYW1i?=
 =?utf-8?B?K3BwUW8vUm1HalVTeWlkUTlIYU0yQUxhcXVoaDRwc0J2V0VscU84ZTROcmd4?=
 =?utf-8?B?djI2WW9US3FDL2c1OFgrU0FTZEFOWmRVWGRlcy9mckZwckRQRVp2MkZzdUtP?=
 =?utf-8?B?eWx2K2VCU2JXMUFZUlJLdWU2bFQyS2VaWVpGV1dWak9VUkcyNFJsbXdYVlYw?=
 =?utf-8?B?T3p5NzN0ZXJpc09MT2JCRndpRWxMdEtIVlRoR1BuQjFFYXpNZkpIWXc2U2xx?=
 =?utf-8?B?TVVFOTB0WDQ5UEljTCtlY1BLMC9hRGpRTjVDSkxVcGo1T0JjTW5SSkRaK2x4?=
 =?utf-8?B?RGRXakh4WVYxMnczaTJaTmhjK242YnVGNHJBUkZoNE95NDVKRDNsMmpDMGhI?=
 =?utf-8?B?Yk1pbDF6SUZjRjZ3YmVwTmJzek9ZaUV0VGxCcjNseXJpT3llcFRaOEk3enB5?=
 =?utf-8?Q?65EyKMBlucdijMZ6FLq9lHt568oknA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:23:54.3079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327fc487-d330-41d8-f6a1-08dd4213a7d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4134
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

Add helper functions to handle per-instance and per-core
initialization and deinitialization in JPEG4_0_3.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 190 ++++++++++++-----------
 1 file changed, 98 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 2a97302a22d3..be0b3b4c8690 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -525,6 +525,75 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
 	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_CGC_GATE, data);
 }
 
+static void jpeg_v4_0_3_start_inst(struct amdgpu_device *adev, int inst)
+{
+	int jpeg_inst = GET_INST(JPEG, inst);
+
+	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
+		     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
+	SOC15_WAIT_ON_RREG
+		(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
+		 UVD_PGFSM_STATUS__UVDJ_PWR_ON << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
+		 UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
+
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
+		 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* JPEG disable CGC */
+	jpeg_v4_0_3_disable_clock_gating(adev, inst);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
+		     adev->gfx.config.gb_addr_config);
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
+		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+}
+
+static void jpeg_v4_0_3_start_jrbc(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int jpeg_inst = GET_INST(JPEG, ring->me);
+	int reg_offset = jpeg_v4_0_3_core_reg_offset(ring->pipe);
+
+	/* enable System Interrupt for JRBC */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regJPEG_SYS_INT_EN),
+		 JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe,
+		 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << ring->pipe));
+
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
+			    reg_offset,
+			    (0x00000001L | 0x00000002L));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+			    reg_offset, lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+			    reg_offset, upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+			    reg_offset, 0);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
+			    reg_offset, 0x00000002L);
+	WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
+			    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
+			    reg_offset, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15_OFFSET(JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
+					 reg_offset);
+}
+
 /**
  * jpeg_v4_0_3_start - start JPEG block
  *
@@ -535,84 +604,42 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev, int inst
 static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
 {
 	struct amdgpu_ring *ring;
-	int i, j, jpeg_inst;
+	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		jpeg_inst = GET_INST(JPEG, i);
-
-		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
-			     1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
-		SOC15_WAIT_ON_RREG(
-			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
-			UVD_PGFSM_STATUS__UVDJ_PWR_ON
-				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
-			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
-
-		/* disable anti hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
-					  regUVD_JPEG_POWER_STATUS),
-			 0, ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
-
-		/* JPEG disable CGC */
-		jpeg_v4_0_3_disable_clock_gating(adev, i);
-
-		/* MJPEG global tiling registers */
-		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX8_ADDR_CONFIG,
-			     adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(JPEG, jpeg_inst, regJPEG_DEC_GFX10_ADDR_CONFIG,
-			     adev->gfx.config.gb_addr_config);
-
-		/* enable JMI channel */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL), 0,
-			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
+		jpeg_v4_0_3_start_inst(adev, i);
 		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
-			int reg_offset = jpeg_v4_0_3_core_reg_offset(j);
-
 			ring = &adev->jpeg.inst[i].ring_dec[j];
-
-			/* enable System Interrupt for JRBC */
-			WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
-						  regJPEG_SYS_INT_EN),
-				 JPEG_SYS_INT_EN__DJRBC0_MASK << j,
-				 ~(JPEG_SYS_INT_EN__DJRBC0_MASK << j));
-
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JMI0_UVD_LMI_JRBC_RB_VMID,
-					    reg_offset, 0);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
-					    reg_offset,
-					    (0x00000001L | 0x00000002L));
-			WREG32_SOC15_OFFSET(
-				JPEG, jpeg_inst,
-				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_LOW,
-				reg_offset, lower_32_bits(ring->gpu_addr));
-			WREG32_SOC15_OFFSET(
-				JPEG, jpeg_inst,
-				regUVD_JMI0_UVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
-				reg_offset, upper_32_bits(ring->gpu_addr));
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_RPTR,
-					    reg_offset, 0);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-					    reg_offset, 0);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_CNTL,
-					    reg_offset, 0x00000002L);
-			WREG32_SOC15_OFFSET(JPEG, jpeg_inst,
-					    regUVD_JRBC0_UVD_JRBC_RB_SIZE,
-					    reg_offset, ring->ring_size / 4);
-			ring->wptr = RREG32_SOC15_OFFSET(
-				JPEG, jpeg_inst, regUVD_JRBC0_UVD_JRBC_RB_WPTR,
-				reg_offset);
+			jpeg_v4_0_3_start_jrbc(ring);
 		}
 	}
 
 	return 0;
 }
 
+static void jpeg_v4_0_3_stop_inst(struct amdgpu_device *adev, int inst)
+{
+	int jpeg_inst = GET_INST(JPEG, inst);
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
+		 UVD_JMI_CNTL__SOFT_RESET_MASK,
+		 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	jpeg_v4_0_3_enable_clock_gating(adev, inst);
+
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JPEG_POWER_STATUS),
+		 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
+		     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
+	SOC15_WAIT_ON_RREG
+		(JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
+		 UVD_PGFSM_STATUS__UVDJ_PWR_OFF << UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
+		 UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
+}
+
 /**
  * jpeg_v4_0_3_stop - stop JPEG block
  *
@@ -622,31 +649,10 @@ static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
  */
 static int jpeg_v4_0_3_stop(struct amdgpu_device *adev)
 {
-	int i, jpeg_inst;
+	int i;
 
-	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
-		jpeg_inst = GET_INST(JPEG, i);
-		/* reset JMI */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst, regUVD_JMI_CNTL),
-			 UVD_JMI_CNTL__SOFT_RESET_MASK,
-			 ~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
-		jpeg_v4_0_3_enable_clock_gating(adev, i);
-
-		/* enable anti hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, jpeg_inst,
-					  regUVD_JPEG_POWER_STATUS),
-			 UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
-			 ~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
-
-		WREG32_SOC15(JPEG, jpeg_inst, regUVD_PGFSM_CONFIG,
-			     2 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
-		SOC15_WAIT_ON_RREG(
-			JPEG, jpeg_inst, regUVD_PGFSM_STATUS,
-			UVD_PGFSM_STATUS__UVDJ_PWR_OFF
-				<< UVD_PGFSM_STATUS__UVDJ_PWR_STATUS__SHIFT,
-			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
-	}
+	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i)
+		jpeg_v4_0_3_stop_inst(adev, i);
 
 	return 0;
 }
-- 
2.25.1

