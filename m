Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F06C6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:21:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4477A10E8F3;
	Tue, 28 Mar 2023 15:21:09 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2052.outbound.protection.outlook.com [40.107.100.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A899E10E1BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:21:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WfkIrutO4bWIfZwkjyzP8z91u5B3M7JnlgerWB0eRvS1I79Q5YMJcnPfXSp+im/QhXa7El4/gBNQ08C2sM1MJlaPYnuqTjLGP2b/zOMgbbPIboj5ghyi58OElJoNJFiabwYh93fLsUicE5mw8dgho9+eSW0kYFzQFhvHGqnY44L135chrsLqV5P6ce//ncMqse6DZlko4bwxnF6i+FO+ttV2TKrXHPI3NWLrVx/YlZpkH8OQwraH8KSPqqKaWGlNoJM+hoWf7rUsziQiA536uZOdKg2Mwyf6sb44iOC6SokbchmISWZXp4vCLHq/T7YO2AskHIGTop2aUfVfv1ptwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xpvjutz+24J2o79pjr8eY/UdzUc9HiboIKrC9uKVaLM=;
 b=ki7DKXxT8/IVovLLQRKMRZCjG54OoiYTKw1GiYc/tMl3J7AklBvm5rnT5Ip8e6KQkuxQmCPQdiHYBV2oI3z9MApHSNRuqGgRlTa6RpyHusHiJ7ig+dTCGIV0jSyTp/vUVIU3sKQMpYSGfhbcJoHa3htURBwIVP+099BnlNyf8Gys4W1f16veSHL/FocBp6pSN51rbC+8oIY3/te04fYTlf7OHD6bDJaKYlThdu/p9OWS3CJKS/JRkjciZVl6WNrQ9UW2JgVkISqGoHEUnp5KFgs33wDFTaE8jVeADSdAPUMIL+QmKntbItLOcnxk12YQjhZD+X7cpW2FWiLPgAVe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xpvjutz+24J2o79pjr8eY/UdzUc9HiboIKrC9uKVaLM=;
 b=4aZI1FnUeTyItHWB41Z4fN/NhqlnLB4dgyEr9xHi3qZhcgvpJQb+Qx9Uyxis/13HwlNCEHZ3MSOEpBGb6HJYMbCjclVUT43mxaWbSqdTG59uzrhxmjPtZi0rq7CpPAz+vrtnYtImOCrQJ9pOJ60OFyYa/rT4OIpz/kd1x7rBZQA=
Received: from DM6PR02CA0076.namprd02.prod.outlook.com (2603:10b6:5:1f4::17)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.36; Tue, 28 Mar
 2023 15:21:02 +0000
Received: from DS1PEPF0000B078.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::ce) by DM6PR02CA0076.outlook.office365.com
 (2603:10b6:5:1f4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Tue, 28 Mar 2023 15:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000B078.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.26 via Frontend Transport; Tue, 28 Mar 2023 15:21:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:20:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/7] drm/amdgpu/vcn: update amdgpu_fw_shared to
 amdgpu_vcn4_fw_shared
Date: Tue, 28 Mar 2023 11:20:36 -0400
Message-ID: <20230328152036.1934902-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328152036.1934902-1-alexander.deucher@amd.com>
References: <20230328152036.1934902-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000B078:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: b93f3f8c-aab3-476e-7900-08db2fa00ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KiHHds2Xr3FgIwhcQ0zUw+BMu2jq8gj2GhNwG5MHtZz2QyAMMGhz+2AXhamIkwiALhDOOQym3k9/bwZFd9iIU7cmz94PgBKIG/e7oKEq1B53E3Lv+pn6Vub22YcqG83VWM4U0wsR91/NC5dlqgvcKU7qJo+1jMfJg1KdMhJ0d4WFNYjkGVrLVreR/GTm4wOpGoGcbNCd7jrP+QYH0JkjeCj77T5K83KEFY+4yjCsDtNVREjMI3FGV2LE11lAt2iF76L0LB8vuTdSbzQ/2GuQTkiF8gJ4IYCwpmdcdqvhl8VHX+IyfqXTNE0EGRMBg8rid7x/MTcSmbKUyAsyhZoLH790jBXxM3YQaTxgwgFrcIZCLhnJJPfmCjh7J7ohMdKLyvXL4ydIVwN30GOugto6PRbHgzPIWtC3QvSb1aUrw/fjB+ddWXFrXMH08ElwvQNkamVf/n1XBZLpzHwx3tkZyD5m/C0Lzcs2Qmf/oA+Y91N0HTdBpzFYFPRUBk0Sd3h78amcarc6kIWZWIzqv+hU5CvfxzpYneBn3fXfPvXU3F2Nl7zLkdWievek1ymR8/mL0Bj6pQdPPCjXXbzKQXGWWi0r4qCmeuUwRLcxZWA3tuPxoVGTg40cEqs1iKZiW+qhuTPT7876bHdQz7mYTruD1aOSgB3AryDq5YlIFHkJsnU93H50V47tsG/gD/DDn+WrClf1szQ9Th/dDiyqyr4r3vLtSPcklt8aJuhmFJODnqY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(356005)(82310400005)(336012)(1076003)(26005)(81166007)(478600001)(426003)(186003)(16526019)(36756003)(40460700003)(83380400001)(47076005)(86362001)(316002)(8936002)(4326008)(7696005)(2906002)(54906003)(40480700001)(5660300002)(6916009)(82740400003)(2616005)(6666004)(41300700001)(36860700001)(70206006)(70586007)(8676002)(15650500001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:21:02.4131 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b93f3f8c-aab3-476e-7900-08db2fa00ac3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000B078.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: James Zhu <James.Zhu@amd.com>

Use amdgpu_vcn4_fw_shared for vcn 4.0.3.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Acked-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 40 +++++++------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 93c18fd7de77..0b2b97593bac 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -79,7 +79,7 @@ static int vcn_v4_0_3_early_init(void *handle)
 static int vcn_v4_0_3_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	volatile struct amdgpu_fw_shared *fw_shared;
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	int r;
 
@@ -111,10 +111,8 @@ static int vcn_v4_0_3_sw_init(void *handle)
 		return r;
 
 	fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
-	fw_shared->present_flag_0 |= cpu_to_le32(AMDGPU_VCN_SW_RING_FLAG) |
-				     cpu_to_le32(AMDGPU_VCN_MULTI_QUEUE_FLAG) |
-				     cpu_to_le32(AMDGPU_VCN_FW_SHARED_FLAG_0_RB);
-	fw_shared->sw_ring.is_enabled = cpu_to_le32(true);
+	fw_shared->present_flag_0 = 0;
+	fw_shared->sq.is_enabled = cpu_to_le32(true);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		adev->vcn.pause_dpg_mode = vcn_v4_0_3_pause_dpg_mode;
@@ -135,11 +133,11 @@ static int vcn_v4_0_3_sw_fini(void *handle)
 	int r, idx;
 
 	if (drm_dev_enter(&adev->ddev, &idx)) {
-		volatile struct amdgpu_fw_shared *fw_shared;
+		volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 
 		fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 		fw_shared->present_flag_0 = 0;
-		fw_shared->sw_ring.is_enabled = cpu_to_le32(false);
+		fw_shared->sq.is_enabled = cpu_to_le32(false);
 
 		drm_dev_exit(idx);
 	}
@@ -304,7 +302,7 @@ static void vcn_v4_0_3_mc_resume(struct amdgpu_device *adev)
 		upper_32_bits(adev->vcn.inst->fw_shared.gpu_addr));
 	WREG32_SOC15(VCN, 0, regUVD_VCPU_NONCACHE_OFFSET0, 0);
 	WREG32_SOC15(VCN, 0, regUVD_VCPU_NONCACHE_SIZE0,
-		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)));
+		AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)));
 }
 
 /**
@@ -407,7 +405,7 @@ static void vcn_v4_0_3_mc_resume_dpg_mode(struct amdgpu_device *adev, bool indir
 			VCN, 0, regUVD_VCPU_NONCACHE_OFFSET0), 0, 0, indirect);
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
 			VCN, 0, regUVD_VCPU_NONCACHE_SIZE0),
-			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_fw_shared)), 0, indirect);
+			AMDGPU_GPU_PAGE_ALIGN(sizeof(struct amdgpu_vcn4_fw_shared)), 0, indirect);
 
 	/* VCN global tiling registers */
 	WREG32_SOC15_DPG_MODE(0, SOC15_DPG_MODE_OFFSET(
@@ -612,7 +610,7 @@ static void vcn_v4_0_3_enable_clock_gating(struct amdgpu_device *adev)
  */
 static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 {
-	volatile struct amdgpu_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 
@@ -702,7 +700,6 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 				(uintptr_t)adev->vcn.inst->dpg_sram_cpu_addr));
 
 	ring = &adev->vcn.inst->ring_dec;
-	fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 
 	/* program the RB_BASE for ring buffer */
 	WREG32_SOC15(VCN, 0, regUVD_RB_BASE_LO4,
@@ -728,12 +725,8 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
 
 	WREG32_SOC15(VCN, 0, regUVD_SCRATCH2, 0);
 
-	/* Reset FW shared memory RBC WPTR/RPTR */
-	fw_shared->rb.rptr = 0;
-	fw_shared->rb.wptr = lower_32_bits(ring->wptr);
-
 	/*resetting done, fw can check RB ring */
-	fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+	fw_shared->sq.queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
 
 	return 0;
 }
@@ -747,7 +740,7 @@ static int vcn_v4_0_3_start_dpg_mode(struct amdgpu_device *adev, bool indirect)
  */
 static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 {
-	volatile struct amdgpu_fw_shared *fw_shared;
+	volatile struct amdgpu_vcn4_fw_shared *fw_shared;
 	struct amdgpu_ring *ring;
 	uint32_t tmp;
 	int j, k, r;
@@ -878,7 +871,6 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	ring = &adev->vcn.inst->ring_dec;
 
 	fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
-	fw_shared->multi_queue.decode_queue_mode |= cpu_to_le32(FW_QUEUE_RING_RESET);
 
 	/* program the RB_BASE for ring buffer */
 	WREG32_SOC15(VCN, 0, regUVD_RB_BASE_LO4,
@@ -902,8 +894,7 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	WREG32_SOC15(VCN, 0, regVCN_RB_ENABLE, tmp);
 
 	ring->wptr = RREG32_SOC15(VCN, 0, regUVD_RB_WPTR4);
-	fw_shared->rb.wptr = cpu_to_le32(lower_32_bits(ring->wptr));
-	fw_shared->multi_queue.decode_queue_mode &= cpu_to_le32(~FW_QUEUE_RING_RESET);
+	fw_shared->sq.queue_mode &= cpu_to_le32(~(FW_QUEUE_RING_RESET | FW_QUEUE_DPG_HOLD_OFF));
 
 	return 0;
 }
@@ -1075,15 +1066,6 @@ static uint64_t vcn_v4_0_3_dec_ring_get_wptr(struct amdgpu_ring *ring)
 static void vcn_v4_0_3_dec_ring_set_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	volatile struct amdgpu_fw_shared *fw_shared;
-
-	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
-		/*whenever update RBC_RB_WPTR, we save the wptr in shared rb.wptr and scratch2 */
-		fw_shared = adev->vcn.inst->fw_shared.cpu_addr;
-		fw_shared->rb.wptr = lower_32_bits(ring->wptr);
-		WREG32_SOC15(VCN, ring->me, regUVD_SCRATCH2,
-			lower_32_bits(ring->wptr));
-	}
 
 	if (ring->use_doorbell) {
 		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
-- 
2.39.2

