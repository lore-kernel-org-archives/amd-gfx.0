Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3141FD0E6F8
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Nov 2025 14:57:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E7710E426;
	Tue, 25 Nov 2025 14:57:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t3It2wVc";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15C8210E422
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 14:57:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhVeNpu1JUpjgx0OFtd2m0fYIHlMSKrUwr8cTEfj+9badjAUf2oqYSYHXh1wUhS8SXkgvQQjIAmkjRF4zrSZ9gRK/CzTlC8+SLnKDg+cAE1I5YdOyyecdQLBlpOn5lfZDIf7PKYREAuGrU6oFd/qCN/VQuNmCn/1gcT8E1LsXMUFFhJksvFv2ZyEEuMv+lnT9E3u4OUMsssF9J7GZk8pPmyMDylC2GzugoxR3xn81qZEHQAzqwrL7HNjpdATrv76T/cK7v8DyOfIR7YEu67qX6a/UTZLjK0lT9UgnrOONrG4uLpkzqG+PtORbBbdhMAyQ3fhWVpLIcg+KvfoqcyqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E6ByHSzWZEguz3s9L/yzv8RN/Z4kgjlHGZFzUt02uaA=;
 b=KetGfUd8RAqG0DpbHIHSO+41d920Mb01kTQuuq3XKFK35dEcLm32fO03j17rvZVFQ39e9Kst4namEgiRKJnjl5gK2IchflitfvUKpGtd/d2xvbOwBdluxENROnOxrQfueJiiB7TeR+mCOiM82LV1jeYlcIPW7ox4xZ15FM8IfgdaXefSELEl2T8X655clofETxoxDT/cqKBV8GRKuN/E1IihPl0LTWQ5kHcDr0i86MYU4afWVg0cL6OMsdQ2K/M2QgomX3TZNsORsvvGrcNJoCGf/JOG/N4b3u4Rv59UEe+SexWbjbaQIIdx3/M6NHac5ohXFcM3UTBoBYdrVUVQ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E6ByHSzWZEguz3s9L/yzv8RN/Z4kgjlHGZFzUt02uaA=;
 b=t3It2wVc2YaDNpFfonb98Ok1OrB0/opvaVbfqj/3Z4Q2mhN8gSoIruTT50/BAW51qasVKEqqAOuwOCAxEw0205SAO90yjSRNdSCPI+ADgrRKFPyvPFNOxTbJMLIAMm5lcFXgjluPCXD5ot636IvGO0H0MJM5KML0jWMeHnVfQKM=
Received: from SA1P222CA0059.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::11)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 14:57:44 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:2c1:cafe::c2) by SA1P222CA0059.outlook.office365.com
 (2603:10b6:806:2c1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 14:57:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 14:57:44 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 25 Nov
 2025 08:57:42 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: only set XCC 0 related reg for rlc autoload
Date: Tue, 25 Nov 2025 09:57:24 -0500
Message-ID: <20251125145725.2045485-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251125145725.2045485-1-alexander.deucher@amd.com>
References: <20251125145725.2045485-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: b1090c94-67f8-4028-6480-08de2c32fd2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jp4rrBP2CvzE4juY2N+tK4uIHtHc+2HlNQP4As8WLO7MDt/SeaLYODn7AG4K?=
 =?us-ascii?Q?DIwYs3AkKGerc5CWypFTbYlaSQv+qBW0inkRAuTkqrxbdTzDSSXxoEQkKrVF?=
 =?us-ascii?Q?3+TDereBa27uSeSCE/TebinvpZDRrD8pyA/LJHO8Mq8GxuoVcDOtXyjDbhXV?=
 =?us-ascii?Q?hRx9JwPCyC4xxw1FFRtArDjHRn0RcLug5f42IzuY64LYLy4mYMPrabVMEqtO?=
 =?us-ascii?Q?vE3uucRQrmhxZoUH5V6AqezakBYCY/JyiSL+KbUg4fh6Knpf0pABJNYxLa/c?=
 =?us-ascii?Q?aZDdlktO9sQ7Wf4xkiZW8rt6LFPPqe+bE//zV3nrNvveVycH9CWEKzicCBxy?=
 =?us-ascii?Q?i8ZvegXzVFDrJTYWwr/fLhliklz8YYYynpSGI2b5qxr6srLgNcKZR/S9mEsC?=
 =?us-ascii?Q?4nO4nXS6a2nN9SbzfHDSYDEijPKuvoGkfzM68YVMxZN08bI3+WcGjwUajSjW?=
 =?us-ascii?Q?t1lRn3DVtcXkm8fxfLMMYqtRBQYdn8Ov2Kg6a6mIra+JEx0qTga1IUNgLgc7?=
 =?us-ascii?Q?YuPEtJ7YIPUUhSy2NSJl4+stiJIFEsCABTeiF8kP+XhhhNMovCU8uYNb3TUA?=
 =?us-ascii?Q?N8J5vrSTKaODfTccAhRxe2QqydCNcc/PiuHKOhgJRX4dK5rXusum7OfrDx/K?=
 =?us-ascii?Q?ie555vWc6X0bZnqwR5AGqXMlYzWZ6eDnViQQ7xhhHqthNwGAyXPx2WU1YI+v?=
 =?us-ascii?Q?ra37UxLoRbGbOg0C1ouCR/XQSlUyO8XU/MUhIRI361zjbUmdAx+fhrGpBJoJ?=
 =?us-ascii?Q?BWKVMk1s3DMv8ybAcUvAsxnv+mQIec43Ki7A2JjXfEnUQJ8NigVyYia9MFzd?=
 =?us-ascii?Q?cPGRocaRqaflPXwSVMD9W9VgEPdU+Im7CQiXbdwN7g849cgjpu9mk9zFiI0K?=
 =?us-ascii?Q?vlo6BKlMn+5f4rA9AWXu9H4ExqArg1ru3qvG4iBaLvCT3Tt5zJV6z04XMVVm?=
 =?us-ascii?Q?Ned1xY5giPJBWm5Vr+A+BhyOaoKS/U8gf7Zbs8kSRPD1ePKbbqNI0CTGF3Rf?=
 =?us-ascii?Q?Z6VUZ8VXVur2Ysz4W3Gu0br9oSqDCg5Pg+EH3MkSQIOpMOWr4y+Ft3hvL9jM?=
 =?us-ascii?Q?zWyhw1VBwvSdA97588/KIV0m6fA+i1z0n7frFRwKWR0r0MW5VUyHTY00kzig?=
 =?us-ascii?Q?3gZ1Uw0p+rWbjv5YKohZSxIuMkqSXuG+A1rN2eDgEPXSmvuHoJTWitzd24JQ?=
 =?us-ascii?Q?A6xo4CFSerrODD2vntB0tdmRcn+EKzerbqSu6GrAv5NofzA/Yd/4rzUlqCJs?=
 =?us-ascii?Q?HnMKeoPsRvfDSjde71V5EbaZnJKRoqZqEME4n0BP1IjywEQnc30W/uR1p4aR?=
 =?us-ascii?Q?YugKUs9dy7/NibKiyYKz9wYR2x+A7JYuo1Zzu6A8xsPAJqVEtoDRh7lYv60B?=
 =?us-ascii?Q?ukTmGVV7Haq8ck3BGH4ApYKtw4kKYxevwDHVR6bAswX9iPy5cvOWERJM++1n?=
 =?us-ascii?Q?MdgMVRRsg/hjHWm/U5vaJPBDzMDtSVOrg0+VbKc63sah7Tc0JmmCw8RkRpMh?=
 =?us-ascii?Q?Ug0vyLrLlMG1T7eMhAS2T7sLYvklZkSvczSVtCjIb21FoXZPfDBlJHw70wLe?=
 =?us-ascii?Q?sSuM9atO3Fq67sPxt1A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:57:44.0056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1090c94-67f8-4028-6480-08de2c32fd2c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988
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

From: Likun Gao <Likun.Gao@amd.com>

For RLC autoload, only set XCC id 0 related register to trigger
rlc autoload, no need to trigger muti-times for muti-xcc.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 78 ++++++++++----------------
 1 file changed, 31 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index ae7e2c254da2e..96ce3f42196d9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1043,7 +1043,6 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	uint32_t rlc_g_offset, rlc_g_size;
 	uint64_t gpu_addr;
 	uint32_t data;
-	int i, num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	/* RLC autoload sequence 2: copy ucode */
 	gfx_v12_1_rlc_backdoor_autoload_copy_sdma_ucode(adev);
@@ -1055,35 +1054,33 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	rlc_g_size = rlc_autoload_info[SOC24_FIRMWARE_ID_RLC_G_UCODE].size;
 	gpu_addr = adev->gfx.rlc.rlc_autoload_gpu_addr + rlc_g_offset - adev->gmc.vram_start;
 
-	for (i = 0; i < num_xcc; i++) {
-		WREG32_SOC15(GC, GET_INST(GC, i),
-			     regGFX_IMU_RLC_BOOTLOADER_ADDR_HI, upper_32_bits(gpu_addr));
-		WREG32_SOC15(GC, GET_INST(GC, i),
-			     regGFX_IMU_RLC_BOOTLOADER_ADDR_LO, lower_32_bits(gpu_addr));
-
-		WREG32_SOC15(GC, GET_INST(GC, i),
-			     regGFX_IMU_RLC_BOOTLOADER_SIZE, rlc_g_size);
-
-		if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
-			/* RLC autoload sequence 3: load IMU fw */
-			if (adev->gfx.imu.funcs->load_microcode)
-				adev->gfx.imu.funcs->load_microcode(adev);
-			/* RLC autoload sequence 4 init IMU fw */
-			if (adev->gfx.imu.funcs->setup_imu)
-				adev->gfx.imu.funcs->setup_imu(adev);
-			if (adev->gfx.imu.funcs->start_imu)
-				adev->gfx.imu.funcs->start_imu(adev);
-
-			/* RLC autoload sequence 5 disable gpa mode */
-			gfx_v12_1_xcc_disable_gpa_mode(adev, i);
-		} else {
-			/* unhalt rlc to start autoload without imu */
-			data = RREG32_SOC15(GC, GET_INST(GC, i), regRLC_GPM_THREAD_ENABLE);
-			data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD0_ENABLE, 1);
-			data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD1_ENABLE, 1);
-			WREG32_SOC15(GC, GET_INST(GC, i), regRLC_GPM_THREAD_ENABLE, data);
-			WREG32_SOC15(GC, GET_INST(GC, i), regRLC_CNTL, RLC_CNTL__RLC_ENABLE_F32_MASK);
-		}
+	WREG32_SOC15(GC, GET_INST(GC, 0),
+		     regGFX_IMU_RLC_BOOTLOADER_ADDR_HI, upper_32_bits(gpu_addr));
+	WREG32_SOC15(GC, GET_INST(GC, 0),
+		     regGFX_IMU_RLC_BOOTLOADER_ADDR_LO, lower_32_bits(gpu_addr));
+
+	WREG32_SOC15(GC, GET_INST(GC, 0),
+		     regGFX_IMU_RLC_BOOTLOADER_SIZE, rlc_g_size);
+
+	if (adev->gfx.imu.funcs && (amdgpu_dpm > 0)) {
+		/* RLC autoload sequence 3: load IMU fw */
+		if (adev->gfx.imu.funcs->load_microcode)
+			adev->gfx.imu.funcs->load_microcode(adev);
+		/* RLC autoload sequence 4 init IMU fw */
+		if (adev->gfx.imu.funcs->setup_imu)
+			adev->gfx.imu.funcs->setup_imu(adev);
+		if (adev->gfx.imu.funcs->start_imu)
+			adev->gfx.imu.funcs->start_imu(adev);
+
+		/* RLC autoload sequence 5 disable gpa mode */
+		gfx_v12_1_xcc_disable_gpa_mode(adev, 0);
+	} else {
+		/* unhalt rlc to start autoload without imu */
+		data = RREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPM_THREAD_ENABLE);
+		data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD0_ENABLE, 1);
+		data = REG_SET_FIELD(data, RLC_GPM_THREAD_ENABLE, THREAD1_ENABLE, 1);
+		WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_GPM_THREAD_ENABLE, data);
+		WREG32_SOC15(GC, GET_INST(GC, 0), regRLC_CNTL, RLC_CNTL__RLC_ENABLE_F32_MASK);
 	}
 
 	return 0;
@@ -1783,12 +1780,11 @@ static void gfx_v12_1_xcc_set_mec_ucode_start_addr(struct amdgpu_device *adev,
 	mutex_unlock(&adev->srbm_mutex);
 }
 
-static int gfx_v12_1_xcc_wait_for_rlc_autoload_complete(struct amdgpu_device *adev,
-							int xcc_id)
+static int gfx_v12_1_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
 {
 	uint32_t cp_status;
 	uint32_t bootload_status;
-	int i;
+	int i, xcc_id;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		cp_status = RREG32_SOC15(GC, GET_INST(GC, 0), regCP_STAT);
@@ -1811,20 +1807,8 @@ static int gfx_v12_1_xcc_wait_for_rlc_autoload_complete(struct amdgpu_device *ad
 	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_RLC_BACKDOOR_AUTO) {
-		gfx_v12_1_xcc_set_mec_ucode_start_addr(adev, xcc_id);
-	}
-
-	return 0;
-}
-
-static int gfx_v12_1_wait_for_rlc_autoload_complete(struct amdgpu_device *adev)
-{
-	int xcc_id, r;
-
-	for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++) {
-		r = gfx_v12_1_xcc_wait_for_rlc_autoload_complete(adev, xcc_id);
-		if (r)
-			return r;
+		for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++)
+			gfx_v12_1_xcc_set_mec_ucode_start_addr(adev, xcc_id);
 	}
 
 	return 0;
-- 
2.51.1

