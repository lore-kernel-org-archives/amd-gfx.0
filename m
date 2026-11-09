Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA4960A2606
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 18:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=DOdH/uol
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F4F110E833;
	Mon,  9 Nov 2026 18:47:11 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013006.outbound.protection.outlook.com
 [40.93.196.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85E6910E5E3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 18:46:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZeF9vb8EGv0UYi7Dk2sHWM6h2XGhIXDOwRGe9xggIdD3vCmp9Oq7oXTw4f5G/Fc7C93A56GxnP7GMB6QzjWHSHrH4AA9tX0VhZaFJDOyhSUT2dB+MLEABHjnmVhGLCmZNIgLiobpHS/Y2x2QwQPIS3bMETC/5JAw4jtCIdi2QGD+eTFBEMxuufzb/zv48tZdWG0FrW8f8piROhn3zcA0a63oOAajtdM29bO8BiQLATBkfampsom1f2oYmk/tUU4w0sdQWSOTFJAAdxJlpK8evOKHAuZF7AldWJ71Dj2Sg/gbexj4q7KxPGTR877NucT2V1MOmJja02Jm1B6oGkAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ysBMvIIgwdMBVsaOHynr1dj+zSgla5R3KkHbzkjBYpw=;
 b=uOwRS74PoJjQDcA/O1gHVMInaqKSzGWg9ettZudXXPx79U8c2wzTHbw+EErIk2XTWLTi8n2REz5p//Tzkr0jsax8b3/lS/B3JlnNpFDLQSHpIMh538/yGnOfQKp5bh+VHU4kqfiw3Nzo/wsPtwDsb299X0vh26sDlvOH69IoR6XXP5Ceu0pKdE+akxwbQunESOm0ntD3upH6tddadFalbUQef+pxNfPKDsZ+3jt5Rgbue8DZ6jetXevGVe+uv46PS8h7Ic9LMiKrS3WU9GcHMNpRIO1QZr9cbGVB9oPmkyb0nr8rZFfIlaCA7gG/27OWqahcufzNNvFcyqCYFE42oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysBMvIIgwdMBVsaOHynr1dj+zSgla5R3KkHbzkjBYpw=;
 b=DOdH/uolXO9rnWOIdfyHzau9FkfMjIuHb5bWK/DChVDb/E8Z4E73riKya/EWD8vQPrEsJgxNFS1MyM7SjT8I55A6BHAGZRhsxi2HQl48u869TAVzjbxncIflRqYoLrgKK2ag4S5QwazS6vGXj4OKO+2DUDsoHIXqXgorYObIzVg=
Received: from SJ0PR03CA0034.namprd03.prod.outlook.com (2603:10b6:a03:33e::9)
 by DS2PR12MB9751.namprd12.prod.outlook.com (2603:10b6:8:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 18:46:54 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::48) by SJ0PR03CA0034.outlook.office365.com
 (2603:10b6:a03:33e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Mon, 9
 Nov 2026 18:46:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 18:46:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:52 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 12:46:51 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 12:46:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 7/8] drm/amdgpu: add support for gfx 13.0.4
Date: Mon, 9 Nov 2026 13:46:39 -0500
Message-ID: <20261109184641.3656885-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109184641.3656885-1-alexander.deucher@amd.com>
References: <20261109184641.3656885-1-alexander.deucher@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|DS2PR12MB9751:EE_
X-MS-Office365-Filtering-Correlation-Id: dd01730f-5ebb-41f7-df7f-08df3e91d340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|22082099003|18002099003|10067099003|11063799006|261102123227099003|261009223027099003|261021121427099003|56012099006|261021123027099003;
X-Microsoft-Antispam-Message-Info: OtbwiimK1lr6n7hBXonWKFejWti9q+aRGlkE2MW+8zI9bNTMeR+zQD5SMwABHX8ydtKM7ykEoOt5WX77h1uw3p3HpNIaJr8sCOhkgikDrCaLDB6Gct57sigLftcHAsemtUlFikwCgo53EgLa/owRjzw4PHE+JiKM8I5KY8Zgd4Oq2tjFmZ7djQpS473SkLmAgnV4RSsATihXIUVd+07N+QC8WWQVzS/iZpOaKjT2k5J8gc9tbT67qLWZiHtbMCLpYPVllz9zWIS6g3l9Gg3JJ7vxA8QkZV4ySJuLozrDY7rdBOltSUzZnD2WqM6NpBWxXI8qrie/62AXmxJUGRMacvXrmBH17J/wGuKbaAcbvOPyXn4PQR9XeoYJSs6hQ/ojr6hF34oLQlinam/KiO50tL/Z/nGj2CGbuwShkkiK/RID26r2pT92vWNlu6yI3qagO8+IhqccbP5f6BT0uhesrnoY/7VjDV6lFAuu0kyuFkMDNTYlAjPNf82np8x3poiDSPp8dBMZWEYXthrlBrhQR2vVcE0WverZRMONSGZh3mBee1AwS7OWDr4GZpjU2+xv5FbrfHBFZrOznFyrMivfryH9tnXrfhExkuhvSsroKCF5b4TH7DjRksRV9gvFyWYP3PmPPzRvqPq4u/WdF8Lq54CMJl03kd4kvwyps+aboij6NoxWrjZntdtC4ouHnuupHzIKsPA7qbVurPKVC5zwMw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261102123227099003)(261009223027099003)(261021121427099003)(56012099006)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RfdfldL8tM8naCFCOnbusKX4zxn24aL6jeETFTFpTmaK2whdhyo4K5QOHYgCxYbbeWDU8Sanm9jQRXAf4VPlVjC8eJgEO8sVaK1FapwlJ04nn1mP0uxi5DQaXntSXf02qnmmxbcNeWigHACdrvmitwQX+PNdG6XvHbKOHzeIB4g9G9BYIyD+cY9wEy3+Qvj3GE55W/zni0sNj7OrXZiVfi1SG+bG1vxS2YvbfEWFV34+Im39VUESU1k0IZIdXxwWQSMIHL/z/DNr1fa0/U4SqeciQYVrgjcl0L3eCDp19vu8zhaFwPPI5PdhQAxK4eH6oWKE08q13VF2N/p4KfQx3v/x2RvFLlUVHYdYGnQZJxWQ8WYlg0WOkgCGtlfXfdIWZm2niOxGkLI3pNFDRx5TOs86/Llry7GvYjSdj4u+CS/VWbzToWHoQdG64r5vsYHh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 18:46:54.4039 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd01730f-5ebb-41f7-df7f-08df3e91d340
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9751
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Frank Min <Frank.Min@amd.com>

Add support for gfx 13.0.4

Signed-off-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c    | 5 +++++
 drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c           | 8 ++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c           | 2 ++
 drivers/gpu/drm/amd/amdgpu/imu_v13_0.c           | 1 +
 drivers/gpu/drm/amd/amdgpu/soc_v2_0.c            | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c            | 1 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c          | 4 +++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c | 1 +
 8 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 9b286c78454cf..818aa325ddc71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2751,6 +2751,7 @@ static int amdgpu_discovery_set_common_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &soc_v1_0_common_ip_block);
 		break;
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		amdgpu_device_ip_block_add(adev, &soc_v2_0_common_ip_block);
 		break;
 	default:
@@ -2815,6 +2816,7 @@ static int amdgpu_discovery_set_gmc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gmc_v12_0_ip_block);
 		break;
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		amdgpu_device_ip_block_add(adev, &gmc_v13_0_ip_block);
 		break;
 	default:
@@ -3158,6 +3160,7 @@ static int amdgpu_discovery_set_gc_ip_blocks(struct amdgpu_device *adev)
 		amdgpu_device_ip_block_add(adev, &gfx_v12_1_ip_block);
 		break;
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		amdgpu_device_ip_block_add(adev, &gfx_v13_0_ip_block);
 		break;
 	default:
@@ -3396,6 +3399,7 @@ static int amdgpu_discovery_set_mes_ip_blocks(struct amdgpu_device *adev)
 		adev->enable_uni_mes = true;
 		break;
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		amdgpu_device_ip_block_add(adev, &mes_v13_0_ip_block);
 		adev->enable_mes = false;
 		adev->enable_mes_kiq = false;
@@ -3823,6 +3827,7 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 		adev->family = AMDGPU_FAMILY_GC_12_0_0;
 		break;
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		adev->family = AMDGPU_FAMILY_GC_13_0_0;
 		break;
 	default:
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
index d6ae2acfdb4b3..37a0ea5172722 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v13_0.c
@@ -963,6 +963,7 @@ static int gfx_v13_0_gpu_early_init(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		adev->gfx.config.max_hw_contexts = 8;
 		adev->gfx.config.sc_prim_fifo_size_frontend = 0x20;
 		adev->gfx.config.sc_prim_fifo_size_backend = 0x100;
@@ -1415,6 +1416,7 @@ static int gfx_v13_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		adev->gfx.me.num_me = 1;
 		adev->gfx.me.num_pipe_per_me = 2;
 		adev->gfx.me.num_queue_per_pipe = 8;
@@ -1434,6 +1436,7 @@ static int gfx_v13_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		if (!adev->gfx.disable_uq) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
@@ -1445,6 +1448,7 @@ static int gfx_v13_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		adev->gfx.enable_cleaner_shader = true;
 		break;
 	default:
@@ -1551,6 +1555,7 @@ static int gfx_v13_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		adev->gfx.compute_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		adev->gfx.gfx_supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 	default:
@@ -3553,6 +3558,7 @@ static void gfx_v13_0_init_golden_registers(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		soc15_program_register_sequence(adev,
 						golden_settings_gc_13_0,
 						(const u32)ARRAY_SIZE(golden_settings_gc_13_0));
@@ -4010,6 +4016,7 @@ static int gfx_v13_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		amdgpu_gfx_off_ctrl(adev, enable);
 		break;
 	default:
@@ -4274,6 +4281,7 @@ static int gfx_v13_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		gfx_v13_0_update_gfx_clock_gating(adev,
 						  state == AMD_CG_STATE_GATE);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c
index cf76b0efe9fe1..49fee18eb5253 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v13_0.c
@@ -578,6 +578,7 @@ static void gmc_v13_0_set_gfxhub_funcs(struct amdgpu_device *adev)
 {
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		adev->gfxhub.funcs = &gfxhub_v13_0_funcs;
 		break;
 	default:
@@ -736,6 +737,7 @@ static int gmc_v13_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		set_bit(AMDGPU_GFXHUB(0), adev->vmhubs_mask);
 		set_bit(AMDGPU_MMHUB0(0), adev->vmhubs_mask);
 		/*
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
index aea418be444a0..c26c130026d82 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v13_0.c
@@ -260,6 +260,7 @@ static void imu_v13_0_program_rlc_ram(struct amdgpu_device *adev)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		if (!r)
 			program_imu_rlc_ram(adev, data, (const u32)size);
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c b/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
index 92a3965df426e..0f358dbe578e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc_v2_0.c
@@ -353,6 +353,7 @@ static int soc_v2_0_common_early_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		adev->cg_flags = 0;
 		adev->pg_flags = 0;
 		adev->external_rev_id = adev->rev_id + 0x10;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index a8fadbbbd2929..235a461fe24a2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1736,6 +1736,7 @@ int kfd_get_gpu_cache_info(struct kfd_node *kdev, struct kfd_gpu_cache_info **pc
 		case IP_VERSION(12, 0, 0):
 		case IP_VERSION(12, 0, 1):
 		case IP_VERSION(12, 1, 0):
+		case IP_VERSION(13, 0, 4):
 			num_of_cache_types =
 				kfd_fill_gpu_cache_info_from_gfx_config(kdev->kfd,
 									cache_line_size_missing,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 3a8f76909752e..2200f5c7c38d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -179,6 +179,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		kfd->device_info.event_interrupt_class = &event_interrupt_class_v11;
 		break;
 	case IP_VERSION(12, 1, 0):
@@ -479,7 +480,8 @@ struct kfd_dev *kgd2kfd_probe(struct amdgpu_device *adev, bool vf)
 			f2g = &gfx_v12_1_kfd2kgd;
 			break;
 		case IP_VERSION(13, 0, 1):
-			/* Note: Compiler version is 13.1.0 while HW version is 13.0.1 */
+		case IP_VERSION(13, 0, 4):
+			/* Compiler target version for GC 13.0.x is 13.1.0. */
 			gfx_target_version = 130100;
 			f2g = &gfx_v13_kfd2kgd;
 			break;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index 224b0e1e38ff5..8d5e26bc312b7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -259,6 +259,7 @@ static inline u32 gc_vm_fault_client_id(struct kfd_node *dev)
 {
 	switch (KFD_GC_VERSION(dev)) {
 	case IP_VERSION(13, 0, 1):
+	case IP_VERSION(13, 0, 4):
 		return SOC_V2_0_IH_CLIENTID_GC_UTCL2;
 	default:
 		return SOC21_IH_CLIENTID_GFX;
-- 
2.56.0

