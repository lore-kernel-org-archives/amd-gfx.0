Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E95BC83F22
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Jul 2025 11:00:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C313510E791;
	Wed, 16 Jul 2025 11:00:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OtwIY4KW";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDFA10E791
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Jul 2025 11:00:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuyP1XHWwrP956nxAD8v8mXIsvW+MsR494IGqkWB9WjnDImJlDBWA1qQFhY3gecFEyeNlJno+7BgFundaALmTgNEaJVNeKXH7kMsYGMWI/5Ks7myd2R9CUPofs1wKGQ5vz/47jL16GcJ2GLeuK/xkEWVf064VFoB+LNK9Zi4BIAvWaK/iSc4aROreuUYR20mm5ksDe23CqE5ckxV3Dfo4sQ0wy7o15xhsiK3D9kBuCR2Emihr9N0NyB+DW+RMi8PV4e/sKaiL2kwjksnfYHTr8pDuP9D1Cshrdn/9efI9QXX+qmYPII7beVHPqeh/c3TGesh0yEQ6+OEhU8aYIh/2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUoDHx0cVofIQNR1IDtsSww1wAw8vwLB3+eNbLieMV8=;
 b=F1zG41IEMZEC2GwKoou71G4+wnw9LD4w8Ie2CFPZ4sOJvv5sP45e5ehR5xIbkAn4LSpnQ6Ntru8uqOMYls1zFhyf9tk8EpdbJ8lms6UmXmx2tHhq+JxYF0lYG1sDCkzUR+dv4RI4UHzdO7JC8zZ4eH4I0T2ta43TZ/9UKEdmVXnwkA8izllU2hjL4H5W2jJMa9HbLQqHtAXL4NvBO+2+kkzOckfwkhf5nErqyl848NfvRIrAeE9wHW1WS8lkvgGdZ0tV7BtGEVHJozpUxryJUc8x0kvXLCUbfkuXXPL0ZXMxgRgqk8XqNxaYcLI1nPIaTGy+VLLaJf4rHeYbL3BclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUoDHx0cVofIQNR1IDtsSww1wAw8vwLB3+eNbLieMV8=;
 b=OtwIY4KWZgT7IfNq0uDXUW2iePmo6ch1/BaU2IQJkc8ADOsVfFvFt52js7buu8nc6+8Qn5aY+i6pgNVegpAIovw3DFK/CSVXxiPryJu1lAG8duFA9J5sjzxqzrDtYLqILewC6Bkfm7IMRIA8qEirEj65KGMW52gBAg8DqtlkJhQ=
Received: from CH0PR03CA0391.namprd03.prod.outlook.com (2603:10b6:610:11b::10)
 by CY8PR12MB7340.namprd12.prod.outlook.com (2603:10b6:930:50::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Wed, 16 Jul
 2025 11:00:21 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::b1) by CH0PR03CA0391.outlook.office365.com
 (2603:10b6:610:11b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 11:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 11:00:20 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:20 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Jul
 2025 06:00:20 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 16 Jul 2025 06:00:18 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [v4 02/11] drm/amd/amdgpu: Implement HQD PQ address retrieval for
 GFX12
Date: Wed, 16 Jul 2025 18:59:22 +0800
Message-ID: <20250716110011.1670654-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
References: <20250716110011.1670654-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CY8PR12MB7340:EE_
X-MS-Office365-Filtering-Correlation-Id: 483201d2-1ed5-4ef0-fb4b-08ddc457f4fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OCUh76Z44FsXwPp6+2X7rt+0+oVxNw9Ird+71JZMqBWw/WyzEdec89C0pqOW?=
 =?us-ascii?Q?ZjvoFdkLI9KrN6bl2bLzfKT5jakcv06KxsZaVooQdm8RRxWoPNPDs/RAWMwr?=
 =?us-ascii?Q?EU54E8CJHnLVHp/xUNAM2O2wcG3Ff9XI5kl7WwwxtkVEpDS/2MrAjIMPIgJh?=
 =?us-ascii?Q?ZsfVEdUStbxC/rtbdR9P/9xBntMMo6xYeiBVkNrrTINAw449QZ4IjgOGDghJ?=
 =?us-ascii?Q?cHWDJBMg9KeKPANAoiRjMV7+Qj/xerWwzkbS6bvtP1/Ri4IA2GTX14keurTI?=
 =?us-ascii?Q?EQ6lV4OCp4whDVAvn53Lzm36X27OUA0S/gAeyXmekV5UEgDcwd7WxtZZfQZL?=
 =?us-ascii?Q?NiQVyHLYJDWFgV2qi0GT71IF317hLIGhQuQsqGk+HvUQziRQkWgbv61D5q3Q?=
 =?us-ascii?Q?DduC9v1xLMJA2IVlTKxuLvau2z9BGlADFeu6bLKR8Jl6g7+Zxm6BZD95PKgh?=
 =?us-ascii?Q?KNXsS/EhI+zNsS0VpiFFQMWgAeVlrNl28rGR/yCGb/bhL8eXjRQxBoK4Pwdv?=
 =?us-ascii?Q?hgVaLgAzMSrWmEHEU96gKKYACSmBRA85dxwwa3NjygbuvAz/tAFj1gcQyhx/?=
 =?us-ascii?Q?mG/qj+LqxGe/Fyc6bfH17XxuzlBo1aRa5lH2zwldscaG2zBcElqHHhwIFicv?=
 =?us-ascii?Q?pyh+MFrMy1uFE4InpGIhmypuUP8rEz+AyiX2uj86M7L+C6PmZwlBh6Yo1+QR?=
 =?us-ascii?Q?8U3TgbqiLLVlnchYxTeRohBMq3UAn/NU7mOerHLAoqjHjLvvyMQb7AyVLOia?=
 =?us-ascii?Q?54W41SgQV2WVy95rkzLVxQFXAUGvbJL/LVPpaax2KSEbLPDKKVWVKLxjYr6q?=
 =?us-ascii?Q?iOxj9s3bLNC8CXfft7QMDuVaEg0cuabrv07ghldDnnazYQcRfnmtT9PZfi1X?=
 =?us-ascii?Q?SOgxqxBVucov0JCWWVgDjuhbduAj5RugKSHJ063o54Y24GexZaUPyn01OqEe?=
 =?us-ascii?Q?Ea2MP12wTk04lbxGbL5SzshaBH8F3ERjKpCeRukyFSRc5sDFgMI+nTyqyEtv?=
 =?us-ascii?Q?MPd5SJgogb1ZI4ISZS21x3+7HLIIsiz0dDrx5QFOPaJ7rXOqitWEg4HTpivH?=
 =?us-ascii?Q?7YkMHcPgIxz3mk9jhcATPb8BBjJx6lAUVCUStfH8Nu4x4MP5RC5VjbXx1Po2?=
 =?us-ascii?Q?CsjPeFJVswThOkucMpsfBI6AoQIThxmXmBKZggjkbsgvP699uVQgguoXK1z2?=
 =?us-ascii?Q?PZNCntYr/zA6u7mUe2KYSpiipgwQQRChWYxgvjhvIHPimBdfWnSsvatnKont?=
 =?us-ascii?Q?xKy7Hx39DGgNiuckkqbg4z7B/hFefKtwARn2x0qOzPbjfwq9lERdInc0sPSW?=
 =?us-ascii?Q?b1Q7srYoBNbL4/iRgCVVydXgMjiD8GRNb3fYybW52LeohQfbPkl/+MIzAqt5?=
 =?us-ascii?Q?nSbdQtiYx2YqIAOFG8SebE68yurnTYNtFTKbKvSMGaUJ5lnxFr2j4KLAgUmk?=
 =?us-ascii?Q?FkVzcUmXp3SrjXHlXpCi2h3BwmENGcIyzmTxyIKGohirMuQ9GfL+PFWMK/ux?=
 =?us-ascii?Q?nE6y0xwa36zozyUKDg3aGYBpztkHB2XazDxy?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 11:00:20.7123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483201d2-1ed5-4ef0-fb4b-08ddc457f4fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7340
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

This commit adds HQD PQ address lookup functionality for GFX12.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 7220ed2fa2a3..f213eb5c6694 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3051,6 +3051,51 @@ static int gfx_v12_0_gfx_mqd_init(struct amdgpu_device *adev, void *m,
 	return 0;
 }
 
+static uint64_t gfx_v12_0_hqd_get_pq_addr(struct amdgpu_device *adev, uint32_t queue_type,
+                    uint32_t me_id, uint32_t pipe_id, uint32_t queue_id,
+                    uint32_t xcc_id, uint32_t *vmid)
+{
+	uint32_t low = 0, high = 0, active = 0;
+	uint64_t queue_addr = 0;
+
+	mutex_lock(&adev->srbm_mutex);
+	/* Enter safe mode to safely access HQD registers */
+	amdgpu_gfx_rlc_enter_safe_mode(adev, xcc_id);
+
+
+	/* Select the specific ME/PIPE/QUEUE to access its HQD registers */
+	soc24_grbm_select(adev, me_id, pipe_id, queue_id, 0);
+
+	if (queue_type == AMDGPU_RING_TYPE_GFX) {
+		active = RREG32_SOC15(GC, 0, regCP_GFX_HQD_ACTIVE);
+		if (!(active & 1))
+			goto unlock_out;
+
+		*vmid = RREG32_SOC15(GC, 0, regCP_GFX_HQD_VMID);
+		low = RREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE);
+		high = RREG32_SOC15(GC, 0, regCP_GFX_HQD_BASE_HI);
+
+		queue_addr = (((uint64_t)high << 32) | low) << 8;
+	} else if (queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+		active = RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE);
+		if (!(active & 1))
+			goto unlock_out;
+
+		*vmid = RREG32_SOC15(GC, 0, regCP_HQD_VMID);
+		low = RREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE);
+		high = RREG32_SOC15(GC, 0, regCP_HQD_PQ_BASE_HI);
+
+		queue_addr = (((uint64_t)high << 32) | low) << 8;
+	}
+
+unlock_out:
+	soc24_grbm_select(adev, 0, 0, 0, 0);
+	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	return queue_addr;
+}
+
 static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 {
 	struct amdgpu_device *adev = ring->adev;
@@ -5694,11 +5739,15 @@ static void gfx_v12_0_set_mqd_funcs(struct amdgpu_device *adev)
 		sizeof(struct v12_gfx_mqd);
 	adev->mqds[AMDGPU_HW_IP_GFX].init_mqd =
 		gfx_v12_0_gfx_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_GFX].hqd_get_pq_addr =
+		gfx_v12_0_hqd_get_pq_addr;
 	/* set compute eng mqd */
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].mqd_size =
 		sizeof(struct v12_compute_mqd);
 	adev->mqds[AMDGPU_HW_IP_COMPUTE].init_mqd =
 		gfx_v12_0_compute_mqd_init;
+	adev->mqds[AMDGPU_HW_IP_COMPUTE].hqd_get_pq_addr =
+		gfx_v12_0_hqd_get_pq_addr;
 }
 
 static void gfx_v12_0_set_user_wgp_inactive_bitmap_per_sh(struct amdgpu_device *adev,
-- 
2.49.0

