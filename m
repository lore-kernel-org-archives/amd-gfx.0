Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A8B8C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 14:26:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 302B310E55E;
	Mon, 10 Feb 2025 14:26:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jJZYtG6O";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2054.outbound.protection.outlook.com [40.107.95.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C62D10E55E
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 14:26:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4VkMdf1fTXjZYmS0/QBoFy3NivUC7amcHOyXWEp34yIOaGKISBIwxqBj/XO8OiejTOdiNH5lSoPQsYEAsgawcXP1s0fPSVtbyM9RBP2z72viTJHZJTiA8tFMmMdokAYP/uHvyKX3GAtcurjT9sj2GiLRBu7gdRxKCXrKh7Ph+ofgH4BJMzUZqqj5UJlbe69WNoxM8HuTnBy4dklyvVr1vKPuVigK1dwyPmHk4gjei5wgZCtcGsOgAQM1TTu5cJx1BtFfiDePthMWwYdmj2eOvw2oG12uQNw6nCYz/Y87DoA3Ok9Qeic+ln+otoKCgFxMtqb5DykQPmtm88RQB+dSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZvMSYoGpK4Dl14vZonknKWpZy70o2R+mc1SPwaub+HY=;
 b=LmunOr/kTCGaR7loGugCFF9zhpPfo33wfBG0drM+w0dsFlNJqWCNlhU54D3EUeHKW5gwhAodghNpuD4+ZDVWIxv8eyVSw1HzOHU8ZPMtbOFYwGnDQldLznoimQFU4VmR/3ie2ehEHegTuFTEvnqAH6+Js8JXK7NCHUd+aMmQs6m6msZvKbYMcMDo4mQVjC36iEjrL9ICFA5JKcXswd6hDwr1VLnfKpP278CJY/x+HQENzdVbpVzuchwRK6YozMCoItM4Q3g4P/QENRHNPQLxIG4j+tMEbeqjotuxMG4YhMIJ/4OtajlwE1lFY76+IQbhIahpOrlUAE/UOp/OkTG21w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZvMSYoGpK4Dl14vZonknKWpZy70o2R+mc1SPwaub+HY=;
 b=jJZYtG6O6+kG88Z68yKtFE9PkleouSl5RvQEeid4nqUZpG9WiG9KXStIYj/P2pAR0JiT1H4cG+TBduXG6unLTjEPaJsILAGCO3ZErnN9QbRT6/L+SrLY5TIJlKuAemur6NG/uKpKuaNvK56SLOQYNIGJsActrvNMwiiPcPrAQuE=
Received: from SJ0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:a03:39e::28)
 by SN7PR12MB6909.namprd12.prod.outlook.com (2603:10b6:806:263::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 14:26:19 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::a0) by SJ0PR03CA0293.outlook.office365.com
 (2603:10b6:a03:39e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 14:26:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:26:18 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Feb 2025 08:26:15 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 1/7] drm/amdgpu: Per-instance init func for JPEG4_0_3
Date: Mon, 10 Feb 2025 19:55:42 +0530
Message-ID: <20250210142548.2321625-2-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
References: <20250210142548.2321625-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|SN7PR12MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df5fb5e-b319-44fa-8c73-08dd49dee25a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TkxWR3hYRzVyWVFOcUNlcWJsZlhEbVlNVEhST1h3c2h4eExTWjVsUFNCOTNT?=
 =?utf-8?B?a3VYSFBqR0FyNDVYR0tBUXJtaUtoMGJEQk1OSDJLVmRmWUQvU2tmODFpQXBL?=
 =?utf-8?B?RXZjWWw2bnRVc0drejcwOHhIaUxEalJoRFJDZndrdU40ejFnYkcza0grNEtV?=
 =?utf-8?B?a0l2Sm04OWt1cUI3ZlZmeWZpSXhoUmJLd2NDOGdBZi9JRzE0dEU4ZDZwUVg4?=
 =?utf-8?B?QkFYYlUvMlVXZnhqeFV0V2dGTlhxOUQ0TklqeEVBaE0zNG94QTYzMzFzb2pV?=
 =?utf-8?B?eCt3WGlEcUIzaHM1alBEL3ZXdm5Ed0RNSFZEMXVBOWk0SllBNFJNRFRPZGRh?=
 =?utf-8?B?REQzTTU2bDhtZm9LcUFRWEc3MGNPbmpxSkw3R0dtYVJXbTduRHdrYjlHWTRm?=
 =?utf-8?B?dndQUUtmdndyRzhHbDhYVXlhUW9UUWVvdWlZRHk3UjJ2NnUrMFNmR2pjMzFU?=
 =?utf-8?B?cXpEWDE3cXBTbFhxbnlkUDd5eW50bFJXdURoL0U1S3djd1hHa0VBbXpaRDkx?=
 =?utf-8?B?Q1g4OHdYdlB4U09DMHl4ZkZsdWV6a0RZZU9hb0lTS3pCTHhQR1lRSHlkZmVW?=
 =?utf-8?B?ZkprVm9ndEtTZi9saXV6MnlNM3RnYkh5WFp0M2JaUWdpb1FPV1RkNUpRTWFM?=
 =?utf-8?B?dHYyTGtja00raFlOVUtJNmNPRXZzNjZDV3hUYjJJZlhVWUo0K2tDL2tWanZY?=
 =?utf-8?B?Sk1GZUc5QzVjTHRaRzd3bC8xWFFsODVZUjFFb3RrL0wxYU5zUStGeVBJeENV?=
 =?utf-8?B?MCtWdmJHRElRU21NTi9Db2VhRHJOVUtnb1pZbmVuc0kvdnN0T2hJQVdWRGVF?=
 =?utf-8?B?UkdCandsRFZ0eGY0ZDh1UGVONm5hMndVZG9vNm5OaXp3K096UStteS9pRVAv?=
 =?utf-8?B?V0VvZFhYbEk3Q3M1VFN1bGRBMjJWbjYzcXN5bk02RDgzaVgrVk5Ya3RZMk81?=
 =?utf-8?B?SG9PSnZad2dDSkNrSHgzQzRMbzVUby9ERnZFS0pEazlFeE5nSjdPK05kdWVV?=
 =?utf-8?B?REthZHlLcFgvMVFDdFlRL1JsQjRJcUQ1NXJpQ1hoWlhLVE54anE2bHYwRXpn?=
 =?utf-8?B?WGZPOTlnU3pMRnlTQzZCYy84WkFDUDVRZE93Y05Fdm5Hd0M1L2VqdHlkSWtD?=
 =?utf-8?B?WTFZelhaY3VzdXVwUmwzNDRYSkY4MDBjTXFkTnZwcHdJY05VN3hjSG5pRHJ1?=
 =?utf-8?B?VnhlYU5teHBZaG11TjNGWjRJbDkvL2VvTDhNMG82NU82anV4N2dUVkVIYW9E?=
 =?utf-8?B?M1BGaFlOMEM2SS9uaFVGOWpyU0w2RlZ6cExISGVnLzdReUJiQVA4UGh5SFlG?=
 =?utf-8?B?SnNaOEJzazFtd0pzK0g0dWphMDdhNXJZZCtTQlRYQVNHNHF4V2ZaMVgzbmRQ?=
 =?utf-8?B?c21EaGVXbEY3T3hIVjhOUUtuRU1abkhwMkFmdkFGRXdXU1lzODlxNC9kNC9F?=
 =?utf-8?B?T3VZUDVIZFQ5RFFXa3hQU0Y0b3FLd2lieWlLc2JzNFJ5bzduQmJUS090bGp5?=
 =?utf-8?B?ZWUyTy9MVlhuaFhuTWFnaHZSeDFJWjdmNG9FSG5yT3ZHS2k2M3d0cStBQlBQ?=
 =?utf-8?B?VG8zaTdkUCtUR2dsZGo1c2ZHRDBhTnA3OEpRQVI3MEcraHFiT0pyQlRMR0to?=
 =?utf-8?B?eFY2QkxWdUZKUWVZcmlpd0NNUTVMWktlUnQvNGphNHBIWGpSQ2QvcUVHTGJ5?=
 =?utf-8?B?QXlzY0hINFdhRy96ZEIzWGRyUnJqWVdRcWpaZ2ZkNDI1VVR1QXRTRDRPMVRN?=
 =?utf-8?B?cDFZbDhySmFBTEhtMnNBL1NZRkZNR3h5bDYyTEdUS1ZqdjZ4RTRvRmdpcnVl?=
 =?utf-8?B?Z0V2c0p5a1ltai9YY3ZOVnV5RjRkY0thS3pIRkhaK3B4N3NzLzNPcDdzUzI0?=
 =?utf-8?B?MURWTGFYcENNRll3L2UwYmsrdmxiVC9GSUtUK3kxL3pjRWx1cnNydVZoVldR?=
 =?utf-8?B?T0svY0w1bzROai9RZHNneVU5RzhBTEFuVVoxTjN4N0pqUERDYXpRbWRqNU5K?=
 =?utf-8?Q?cjQ3yKu8MpAOkWXSsRgCFXmFC1fT8w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:26:18.4068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df5fb5e-b319-44fa-8c73-08dd49dee25a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6909
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

