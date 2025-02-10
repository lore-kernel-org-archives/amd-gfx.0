Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74866C02198
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Feb 2025 14:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26FE610E56C;
	Mon, 10 Feb 2025 14:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eDNYTt1B";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0451B10E57C
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Feb 2025 14:27:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpmqAe0NLWRts2UfjX3Uf2d1DuapRJrnnJxhPmr5/Ef9o6f7LBqQAac16fACfd27gN5xWxFQG0/q9q4aq7UVKlPHptOH9ApTXc9zNo++PqVvSsJtbScioEQVjiZ8Cjt1GcD3jQiiL5PHTIiOLj8p/zkfR6/F4ulfVcYJ6p3uhQRQ1FWzNlcugovpnWuNbVJRfhd0o4nEo2pWPhdyR9rBSAwIQqX5BKTEF7oF3DwK9L0rBdxtSHFnPVII3jCXNNyUyYuyTN5kq1JIz6D3Hr0kVLhBTyBPP10SE60XTt2uFW5uNVRTXTqEdxPmIZgOcx60xJFPNp2vJFppBuE/K4JxOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3YeDErUlmIwKnv51U733FB4WH48vOZL/UoyH5nijlVw=;
 b=Bz4iUxtAt1drkf8M6gKnwn/SdyZApJqUo/N2+u11XMHwucFbfEl5BLU30uIxt7NP2A76+p/u80oHJYmmqk3ldfJjFOYQhhuXC5j+xYeEmmzp6I72brZO/Nwj3ylVWMOdl6KVMCXWHScKKrwXVynLNWYDfGKbdimqKu1RiGWLs0DPdcnAYNzpOVmRx/usO1nSMbfhAs5y5dKWW59vuE9D9QkVr3mDyzeAEa1yor36yHUNCxRLVQ6/Sp/vbwXofWxMvWDjAnKgZrBD3H/+nOs1MsfFPwiiqk0VrRjLNNGSCHg8o1HKMtb+B5hUOMxPWFUeMfiVBbvPeJnEl7FgqjG45g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3YeDErUlmIwKnv51U733FB4WH48vOZL/UoyH5nijlVw=;
 b=eDNYTt1B/iowoROtlrTGR82zbqQUQ0vHREk1yU2FbEqlmkcfIqkIZOzpUU87bxkoGDV+jaIWuB0d7fSx/nbdfCf6vt4dMO/GcpKq13GyQkjDM3yauGEnagkmOkSG8H2Pwhe6kRpt0iRm4UXLeYZVZ84oO1GtL6Wg7YOf6peLhX0=
Received: from SJ0PR05CA0201.namprd05.prod.outlook.com (2603:10b6:a03:330::26)
 by SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.17; Mon, 10 Feb
 2025 14:27:30 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:330:cafe::68) by SJ0PR05CA0201.outlook.office365.com
 (2603:10b6:a03:330::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.10 via Frontend Transport; Mon,
 10 Feb 2025 14:27:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 14:27:30 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 10 Feb 2025 08:27:27 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Alexander Deucher <Alexander.Deucher@amd.com>, 
 Koenig Christian <Christian.Koenig@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH v2 5/7] drm/amdgpu: Per-instance init func for JPEG2_5_0
Date: Mon, 10 Feb 2025 19:55:46 +0530
Message-ID: <20250210142548.2321625-6-sathishkumar.sundararaju@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 19bc124f-51f3-400e-c824-08dd49df0d1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VWNreHNQNytiemVtL2R1NkpsU0ZHOG1kdXlVMGlhNExTbVJROWk2b0huZVJa?=
 =?utf-8?B?VDNUTVR4d3VjZDcvd3hyR3NKUG1PZzE5ZUJZU2Q1WlFFVlJsamcwTlA5WWpo?=
 =?utf-8?B?RjJ5SGZ4N3dHWEN3MWtrNzlGYTR5b2VpQzU1bmx3QjJMK1JVOVJKWE9CeUc3?=
 =?utf-8?B?d1VlZG9tYmZaeTRJQkpvK3lNb29WaFN0bXVmMWtrNkVQeTl5N055akQrWkFM?=
 =?utf-8?B?NVUwRG91MWFxbDdBS0liRzA5NVZ5YkJySVNuVWZ0ay9xTXBpUE5hazRTQzVu?=
 =?utf-8?B?V1JJZnV0dnljektYS25iQnVJQ3EzaW5Xb3E5d29wa2I0RFA0aEFKYW10cjBw?=
 =?utf-8?B?dUxMWGJUcTdxSklicU8yL1ZtMDVQUi9GblV6UU5BMHVrVDN0R3BVeW9HM1J0?=
 =?utf-8?B?cmQzVUQ2VTlHK0ZEK1ROQVNHKzVqeW5hcEpka3RQaFdCVlpaYUttTXZSb0Vs?=
 =?utf-8?B?dkwzMDBiWTFGWUo5TDdRMXVjYzJNdGhrdTVrNHpOMzA3VnNjcTNKL29RZnlj?=
 =?utf-8?B?cENqS3hINkF4REE2TWZYek96ZWdYU2FNeFdCTGNxYXpSYXR6Z1V0b3FnUUFN?=
 =?utf-8?B?Sy9BVk4rT0J6S1RxSStDN3lwdElFZk84MFF5TEVRdTZzeVU1ZDV3aFJ5Mjhh?=
 =?utf-8?B?bHZRMVRIMTBGTEhwNWRjQUluaEpNaFBCb21jeXFjS0gwMzJ3SjJVNWh1QVVr?=
 =?utf-8?B?bGlQeXR0MFg5aXFCeEVrK2pURmpGZlhXZmtYL3VpeFZVVkpWZkg5UjlhUmpW?=
 =?utf-8?B?SkttZ2tONVFrY3Fabm5SOU1welpZU2tqRUYrNjAvdUIyNUNyaE15ZmV0R1ly?=
 =?utf-8?B?Z1dyRnorQ0hIRmt2WVhCR1ZudkNpZmFQTEJRMzVyc1BqM1BaTDJ5Q0VjbXJa?=
 =?utf-8?B?cjV5U3pESUdZalJ6N3B5NnpTbkFVUHdMMFhWRDhqZENuK1ZNdm8zZUdsaDVW?=
 =?utf-8?B?USs2ZUlqM2xxYnRZY0F6dFE1K3Bnb0JJdUJ5YUowK2cvSnlKOTkxK3ZmTWpx?=
 =?utf-8?B?OVVQVlFYbzJzcTZxY2lRMjdmb0FBWEJvTzRTTUJQYW1abXVOTGlZd2M5WDYx?=
 =?utf-8?B?NitRZE0zWnB0N28vb2VwK3VGbDdZL0FtRWtRRVA0Y3ZpQVBNbjhROG1nR2tw?=
 =?utf-8?B?aGtJYWsxbFJ0WnV1ak9TS05QRlVLOUM3dXI2NFBYdUQ5N1E0eDlFalI5cmxy?=
 =?utf-8?B?RTlpejVLQktjbXdWbGs0K0thVTJTSFg3S3l6dmFMWWJRby9KbG9kTTZld2Vj?=
 =?utf-8?B?Nnh0ODhtMkI5WEJjYXF5T2hFYTVNUVVWU01pcmt3dUVleFh3NnQxZXQ5dUFr?=
 =?utf-8?B?WGs5VklXWkxLa0c1N2EyQUV5a2JUZmRGNnkvTEVIQVdEdkE0WTJCM0FYRGRu?=
 =?utf-8?B?MDZPTHJBSUFpalFWQ1BaazBkZTZkWENYNXRwUUpRdmxOSk1NNG1pb3hMdHBN?=
 =?utf-8?B?L2dHeDVnN1lxUWR1SFgvQVVmdHc1b0UyVkZCbTNXaFhYYUlxMDc0UCtiOE5N?=
 =?utf-8?B?Uk1DZURrVTJhaElZTUNqN0NrbTVLQ0xiK2lPRFdVM2laUDl1NkJkUmdHQzRM?=
 =?utf-8?B?dlJ5K2o4KytxK0pwcWZVRkFTOFIvUU1TSzE2VFM1NmRuVlRCRTdXSGljdWdT?=
 =?utf-8?B?S0FFVUtlNXhLb1I3VkpCVTlTUkNIaUl0UDJ4S2dsNDFoSVhadWJrNldMRStn?=
 =?utf-8?B?cnhoK05wazMrdEphZ01Kenh6MmhYQ09ucGNzdmNjZFZhc2dpU3Z1eVdPaTIy?=
 =?utf-8?B?Y1d0aWQ4Q2hqZDhXM2tKbzFDTXB5NGFkR2xRS2o2Tis5WDRnb3kyeUFzalBy?=
 =?utf-8?B?Qm5GRXFrZ3FYcVpFTVA2NXZVNTNnQWtFc21uYTVoQTQ4MFVrdU85LzJVRUx1?=
 =?utf-8?B?NllPOUp4RWdNUThEYzU3UE11MlRjeWZLaWVBNGdrUkhXbW9wQ0U5NHJ4SVZn?=
 =?utf-8?B?Z0xnYWdvYU5EVFFmaGNlZXh4c0JxaHUwWnIxT25TTUtYaW9xR2VqWU5rRjFP?=
 =?utf-8?Q?7eGERrbdOyhEUmgoQfMWKzEEQFc3i0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 14:27:30.1103 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19bc124f-51f3-400e-c824-08dd49df0d1e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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

Add helper functions to handle per-instance initialization
and deinitialization in JPEG2_5_0.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c | 102 +++++++++++++------------
 1 file changed, 55 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index b19724928ce4..0490b672d8d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -330,6 +330,44 @@ static void jpeg_v2_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
 	WREG32_SOC15(JPEG, inst, mmJPEG_CGC_GATE, data);
 }
 
+static void jpeg_v2_5_start_inst(struct amdgpu_device *adev, int i)
+{
+	struct amdgpu_ring *ring = adev->jpeg.inst[i].ring_dec;
+	/* disable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_POWER_STATUS), 0,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+
+	/* JPEG disable CGC */
+	jpeg_v2_5_disable_clock_gating(adev, i);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, i, mmJPEG_DEC_GFX8_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(JPEG, i, mmJPEG_DEC_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JMI_CNTL), 0,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	/* enable System Interrupt for JRBC */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmJPEG_SYS_INT_EN),
+		JPEG_SYS_INT_EN__DJRBC_MASK,
+		~JPEG_SYS_INT_EN__DJRBC_MASK);
+
+	WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_WPTR);
+}
+
 /**
  * jpeg_v2_5_start - start JPEG block
  *
@@ -339,52 +377,33 @@ static void jpeg_v2_5_enable_clock_gating(struct amdgpu_device *adev, int inst)
  */
 static int jpeg_v2_5_start(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring;
 	int i;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
+		jpeg_v2_5_start_inst(adev, i);
 
-		ring = adev->jpeg.inst[i].ring_dec;
-		/* disable anti hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_POWER_STATUS), 0,
-			~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
-
-		/* JPEG disable CGC */
-		jpeg_v2_5_disable_clock_gating(adev, i);
-
-		/* MJPEG global tiling registers */
-		WREG32_SOC15(JPEG, i, mmJPEG_DEC_GFX8_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-		WREG32_SOC15(JPEG, i, mmJPEG_DEC_GFX10_ADDR_CONFIG,
-			adev->gfx.config.gb_addr_config);
-
-		/* enable JMI channel */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JMI_CNTL), 0,
-			~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
-		/* enable System Interrupt for JRBC */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmJPEG_SYS_INT_EN),
-			JPEG_SYS_INT_EN__DJRBC_MASK,
-			~JPEG_SYS_INT_EN__DJRBC_MASK);
-
-		WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_VMID, 0);
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
-		WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
-			lower_32_bits(ring->gpu_addr));
-		WREG32_SOC15(JPEG, i, mmUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
-			upper_32_bits(ring->gpu_addr));
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_RPTR, 0);
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_WPTR, 0);
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_CNTL, 0x00000002L);
-		WREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_SIZE, ring->ring_size / 4);
-		ring->wptr = RREG32_SOC15(JPEG, i, mmUVD_JRBC_RB_WPTR);
 	}
 
 	return 0;
 }
 
+static void jpeg_v2_5_stop_inst(struct amdgpu_device *adev, int i)
+{
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JMI_CNTL),
+		UVD_JMI_CNTL__SOFT_RESET_MASK,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	jpeg_v2_5_enable_clock_gating(adev, i);
+
+	/* enable anti hang mechanism */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_POWER_STATUS),
+		UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
+		~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+}
+
 /**
  * jpeg_v2_5_stop - stop JPEG block
  *
@@ -399,18 +418,7 @@ static int jpeg_v2_5_stop(struct amdgpu_device *adev)
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
-
-		/* reset JMI */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JMI_CNTL),
-			UVD_JMI_CNTL__SOFT_RESET_MASK,
-			~UVD_JMI_CNTL__SOFT_RESET_MASK);
-
-		jpeg_v2_5_enable_clock_gating(adev, i);
-
-		/* enable anti hang mechanism */
-		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_POWER_STATUS),
-			UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK,
-			~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
+		jpeg_v2_5_stop_inst(adev, i);
 	}
 
 	return 0;
-- 
2.25.1

