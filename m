Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97ADEC76195
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Mar 2023 19:46:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C71610E73C;
	Mon, 27 Mar 2023 19:46:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E3A110E736
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Mar 2023 19:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7NQXafESUAe46XuWRw7vpyXFiqIOopcd++E0haoUkAHSaVVPzGTvsRho3MQv6bUJo5LVnyF5/MVhz1O2BtR4URfJYB1w7WygHk+F/YgsXp6EcBlcW6anK9D3b84wuXoDUWLWWwadjkXh25T3gQmQgJeW5TlevHMo4wDwGmF/nhj0aDw0Fbl32QLolflD2NA67gtgpQ5aLFV3XkVNxvIfY3hTKCML0FuCI31F5MSP1oVmZ41JBDO0YFbGyHHPoT7h/B3dPw7V1S/32tkT1DOPewuGomp3s7Hp48bIg7yiAK9KatMRH2fYNHPMc5ChEzv+rHHekTlsVRselr0oZMKYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2j48nDy1ElD6oGMV8QEIbG7a+hOTEuvJb9fpNICo6vY=;
 b=k5CyFlY/qfo627UMEO82CSBe1lJ/k9DY5uUBPcmPlzlJmdzwlqpfAaKivFzZ6VEpfioQ79kJmSxFD9THtDNMiY05AyX3VVdyB3qR/+0F+BYD1GS3YDGB7HG6nmBcUNrjdDbU8rLxO2XSlqCsANYBVla4r9HEXPqVuMarJLzTV4ZD/z3isk2jP3g+Lxrf8+1v+/SNGVuXQJPWcCZGHzyCslqFkzFYBVixq4Qs7Z1pM6Iye5rjq4zF0+N16pMCCIO2X3D605xdANGlHq3XWFvae3p0tRo2bYDMfoLtging+1Xxi7Mtue9vkp3u+FXbFRZ975Vm+/sgIUEggWqiu5ywTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2j48nDy1ElD6oGMV8QEIbG7a+hOTEuvJb9fpNICo6vY=;
 b=1Uw1vumgMQRtmY2pNheisOx8bt3FQew/yQRR285Z4yRCuV/aRFiZKa9+aiHu86eJya8hj4G21ctfCKX8fNbv6RJNZ4XwRcFNMjfFLicVRZH3egfU8be4fdnJwTWcbMKuxWF2OFDcLOySIRElkZ6x7iLs09GX+go/W3q5Otfw44I=
Received: from DS7PR03CA0194.namprd03.prod.outlook.com (2603:10b6:5:3b6::19)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.31; Mon, 27 Mar
 2023 19:46:43 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b6:cafe::89) by DS7PR03CA0194.outlook.office365.com
 (2603:10b6:5:3b6::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.43 via Frontend
 Transport; Mon, 27 Mar 2023 19:46:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Mon, 27 Mar 2023 19:46:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 27 Mar
 2023 14:46:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/11] drm/amdgpu/jpeg: add multiple jpeg rings support
Date: Mon, 27 Mar 2023 15:46:21 -0400
Message-ID: <20230327194622.8109-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327194622.8109-1-alexander.deucher@amd.com>
References: <20230327194622.8109-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT050:EE_|SA0PR12MB4398:EE_
X-MS-Office365-Filtering-Correlation-Id: f2d467a1-b36b-4d07-b8ab-08db2efbfe2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbye9z8hZOkAnf3VTezYfFkflcCy+uz+L1Acp4QaKZINpdr+dw3c1om4lUJgI5FHj0yqcREhaQSS4CjWyYa8icL6Vq8O5UEf9BZVy1ORjnaLqXpmUMDjAu7v/60OWMY2WR6ESeiHHYed992a4HYkQjSClWqsZzH110T+X/7mJJ0Jps4mAK+Bfqf7uq69/4Yrnh4GU+OzbPycl9eqZT3DWFcpsBCvWUCjboLguaWwzHDSaFdOSOO9mXeIzd+dhIWjIZBD+XziVLqgp93RkqXAaMR84TfBrjN13C1yFqkG+SbuXz/TTLFyNkL/WC8/mQLtVA5MLaEw2x3/c/Py162hUEj2HquoyilfUplAsXUDmntr54XuXZwp7UL07QXEUHVlbu75+pHxDKZxjuGgzwblBaGxjWxPPnyIXUpKrr8PWLSV6YtqVqL8CHmeK35rqQlcfoENMNHMpy3z5Y4hw9Opcoxbtp0j8py98mwuBJ0mH934h24n/frixK5yaohlP6ySA+zVSWv7f8R3nKItTE5UDB1ojZnzTCXyCcTYb5IYeUz+XxWAKALpJnqzuruatzGpP9YP5ZriNIztmOsB5SxnbbigGKJoUpons6NtCeP6rP6HpjXlL3YfRhBjg6TUlZZRkZNKHmdB+RO7fUOKTVCNbMRVhWIbqlSHeuUFsGttWehRPL83zrW/EievsB6T+4XL+ItTlRQeZZ9qnzHa2EzZdQjtTXKEPTwLwnY05Pr2m+w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199021)(46966006)(36840700001)(40470700004)(478600001)(70206006)(41300700001)(4326008)(54906003)(70586007)(8676002)(6916009)(316002)(8936002)(82310400005)(5660300002)(81166007)(30864003)(356005)(7696005)(426003)(336012)(40460700003)(82740400003)(83380400001)(36756003)(2906002)(16526019)(1076003)(186003)(26005)(40480700001)(2616005)(36860700001)(47076005)(6666004)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2023 19:46:43.8354 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d467a1-b36b-4d07-b8ab-08db2efbfe2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
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

Add multiple jpeg rings support.

Signed-off-by: James Zhu <James.Zhu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 21 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  6 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  |  5 +++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c   | 12 ++++++------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 18 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 14 +++++++-------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 16 ++++++++--------
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 12 ++++++------
 10 files changed, 69 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index b07c000fc8ba..388466a5f730 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -45,13 +45,14 @@ int amdgpu_jpeg_sw_init(struct amdgpu_device *adev)
 
 int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 {
-	int i;
+	int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
-		amdgpu_ring_fini(&adev->jpeg.inst[i].ring_dec);
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j)
+			amdgpu_ring_fini(&adev->jpeg.inst[i].ring_dec[j]);
 	}
 
 	mutex_destroy(&adev->jpeg.jpeg_pg_lock);
@@ -76,13 +77,14 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 	struct amdgpu_device *adev =
 		container_of(work, struct amdgpu_device, jpeg.idle_work.work);
 	unsigned int fences = 0;
-	unsigned int i;
+	unsigned int i, j;
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
-		fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec);
+		for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j)
+			fences += amdgpu_fence_count_emitted(&adev->jpeg.inst[i].ring_dec[j]);
 	}
 
 	if (!fences && !atomic_read(&adev->jpeg.total_submission_cnt))
@@ -122,17 +124,17 @@ int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	WREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch, 0xCAFEDEAD);
+	WREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe], 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r)
 		return r;
 
-	amdgpu_ring_write(ring, PACKET0(adev->jpeg.internal.jpeg_pitch, 0));
+	amdgpu_ring_write(ring, PACKET0(adev->jpeg.internal.jpeg_pitch[ring->pipe], 0));
 	amdgpu_ring_write(ring, 0xDEADBEEF);
 	amdgpu_ring_commit(ring);
 
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch);
+		tmp = RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe]);
 		if (tmp == 0xDEADBEEF)
 			break;
 		udelay(1);
@@ -161,8 +163,7 @@ static int amdgpu_jpeg_dec_set_reg(struct amdgpu_ring *ring, uint32_t handle,
 
 	ib = &job->ibs[0];
 
-	ib->ptr[0] = PACKETJ(adev->jpeg.internal.jpeg_pitch, 0, 0,
-			     PACKETJ_TYPE0);
+	ib->ptr[0] = PACKETJ(adev->jpeg.internal.jpeg_pitch[ring->pipe], 0, 0, PACKETJ_TYPE0);
 	ib->ptr[1] = 0xDEADBEEF;
 	for (i = 2; i < 16; i += 2) {
 		ib->ptr[i] = PACKETJ(0, 0, 0, PACKETJ_TYPE6);
@@ -208,7 +209,7 @@ int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	}
 	if (!amdgpu_sriov_vf(adev)) {
 		for (i = 0; i < adev->usec_timeout; i++) {
-			tmp = RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch);
+			tmp = RREG32(adev->jpeg.inst[ring->me].external.jpeg_pitch[ring->pipe]);
 			if (tmp == 0xDEADBEEF)
 				break;
 			udelay(1);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 0ca76f0f23e9..cb6c127ab81d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -27,16 +27,17 @@
 #include "amdgpu_ras.h"
 
 #define AMDGPU_MAX_JPEG_INSTANCES	2
+#define AMDGPU_MAX_JPEG_RINGS		8
 
 #define AMDGPU_JPEG_HARVEST_JPEG0 (1 << 0)
 #define AMDGPU_JPEG_HARVEST_JPEG1 (1 << 1)
 
 struct amdgpu_jpeg_reg{
-	unsigned jpeg_pitch;
+	unsigned jpeg_pitch[AMDGPU_MAX_JPEG_RINGS];
 };
 
 struct amdgpu_jpeg_inst {
-	struct amdgpu_ring ring_dec;
+	struct amdgpu_ring ring_dec[AMDGPU_MAX_JPEG_RINGS];
 	struct amdgpu_irq_src irq;
 	struct amdgpu_jpeg_reg external;
 };
@@ -48,6 +49,7 @@ struct amdgpu_jpeg_ras {
 struct amdgpu_jpeg {
 	uint8_t	num_jpeg_inst;
 	struct amdgpu_jpeg_inst inst[AMDGPU_MAX_JPEG_INSTANCES];
+	unsigned num_jpeg_rings;
 	struct amdgpu_jpeg_reg internal;
 	unsigned harvest_config;
 	struct delayed_work idle_work;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 0efb38539d70..75d4d080cc52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -462,8 +462,9 @@ static int amdgpu_hw_ip_info(struct amdgpu_device *adev,
 			if (adev->jpeg.harvest_config & (1 << i))
 				continue;
 
-			if (adev->jpeg.inst[i].ring_dec.sched.ready)
-				++num_rings;
+			for (j = 0; j < adev->jpeg.num_jpeg_rings; j++)
+				if (adev->jpeg.inst[i].ring_dec[j].sched.ready)
+					++num_rings;
 		}
 		ib_start_alignment = 16;
 		ib_size_alignment = 16;
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index 71fe7f6f9889..1c5b60604a19 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -437,7 +437,7 @@ static int jpeg_v1_0_process_interrupt(struct amdgpu_device *adev,
 
 	switch (entry->src_id) {
 	case 126:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
+		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
@@ -484,7 +484,7 @@ int jpeg_v1_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	ring = &adev->jpeg.inst->ring_dec;
+	ring = adev->jpeg.inst->ring_dec;
 	ring->vm_hub = AMDGPU_MMHUB0(0);
 	sprintf(ring->name, "jpeg_dec");
 	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq,
@@ -492,7 +492,7 @@ int jpeg_v1_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->jpeg.internal.jpeg_pitch = adev->jpeg.inst->external.jpeg_pitch =
+	adev->jpeg.internal.jpeg_pitch[0] = adev->jpeg.inst->external.jpeg_pitch[0] =
 		SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
 
 	return 0;
@@ -509,7 +509,7 @@ void jpeg_v1_0_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_ring_fini(&adev->jpeg.inst[0].ring_dec);
+	amdgpu_ring_fini(adev->jpeg.inst->ring_dec);
 }
 
 /**
@@ -522,7 +522,7 @@ void jpeg_v1_0_sw_fini(void *handle)
  */
 void jpeg_v1_0_start(struct amdgpu_device *adev, int mode)
 {
-	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 
 	if (mode == 0) {
 		WREG32_SOC15(JPEG, 0, mmUVD_LMI_JRBC_RB_VMID, 0);
@@ -579,7 +579,7 @@ static const struct amdgpu_ring_funcs jpeg_v1_0_decode_ring_vm_funcs = {
 
 static void jpeg_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->ring_dec.funcs = &jpeg_v1_0_decode_ring_vm_funcs;
+	adev->jpeg.inst->ring_dec->funcs = &jpeg_v1_0_decode_ring_vm_funcs;
 	DRM_INFO("JPEG decode is enabled in VM mode\n");
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 3a43e42f4834..3aeeceae34a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -83,7 +83,7 @@ static int jpeg_v2_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	ring = &adev->jpeg.inst->ring_dec;
+	ring = adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = true;
 	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
 	ring->vm_hub = AMDGPU_MMHUB0(0);
@@ -93,8 +93,8 @@ static int jpeg_v2_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->jpeg.internal.jpeg_pitch = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
-	adev->jpeg.inst->external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
+	adev->jpeg.internal.jpeg_pitch[0] = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
+	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
 
 	return 0;
 }
@@ -129,7 +129,7 @@ static int jpeg_v2_0_sw_fini(void *handle)
 static int jpeg_v2_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
@@ -312,7 +312,7 @@ static void jpeg_v2_0_enable_clock_gating(struct amdgpu_device *adev)
  */
 static int jpeg_v2_0_start(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
 	if (adev->pm.dpm_enabled)
@@ -729,7 +729,7 @@ static int jpeg_v2_0_process_interrupt(struct amdgpu_device *adev,
 
 	switch (entry->src_id) {
 	case VCN_2_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
+		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
@@ -791,7 +791,7 @@ static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 
 static void jpeg_v2_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->ring_dec.funcs = &jpeg_v2_0_dec_ring_vm_funcs;
+	adev->jpeg.inst->ring_dec->funcs = &jpeg_v2_0_dec_ring_vm_funcs;
 	DRM_INFO("JPEG decode is enabled in VM mode\n");
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 259b7ba6a842..b79edb12b90e 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -125,7 +125,7 @@ static int jpeg_v2_5_sw_init(void *handle)
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
-		ring = &adev->jpeg.inst[i].ring_dec;
+		ring = adev->jpeg.inst[i].ring_dec;
 		ring->use_doorbell = true;
 		if (adev->ip_versions[UVD_HWIP][0] == IP_VERSION(2, 5, 0))
 			ring->vm_hub = AMDGPU_MMHUB1(0);
@@ -138,8 +138,8 @@ static int jpeg_v2_5_sw_init(void *handle)
 		if (r)
 			return r;
 
-		adev->jpeg.internal.jpeg_pitch = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
-		adev->jpeg.inst[i].external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_PITCH);
+		adev->jpeg.internal.jpeg_pitch[0] = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
+		adev->jpeg.inst[i].external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_PITCH);
 	}
 
 	r = amdgpu_jpeg_ras_sw_init(adev);
@@ -186,7 +186,7 @@ static int jpeg_v2_5_hw_init(void *handle)
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
-		ring = &adev->jpeg.inst[i].ring_dec;
+		ring = adev->jpeg.inst[i].ring_dec;
 		adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
 			(adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 8 * i, i);
 
@@ -326,7 +326,7 @@ static int jpeg_v2_5_start(struct amdgpu_device *adev)
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 
-		ring = &adev->jpeg.inst[i].ring_dec;
+		ring = adev->jpeg.inst[i].ring_dec;
 		/* disable anti hang mechanism */
 		WREG32_P(SOC15_REG_OFFSET(JPEG, i, mmUVD_JPEG_POWER_STATUS), 0,
 			~UVD_JPEG_POWER_STATUS__JPEG_POWER_STATUS_MASK);
@@ -591,7 +591,7 @@ static int jpeg_v2_5_process_interrupt(struct amdgpu_device *adev,
 
 	switch (entry->src_id) {
 	case VCN_2_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst[ip_instance].ring_dec);
+		amdgpu_fence_process(adev->jpeg.inst[ip_instance].ring_dec);
 		break;
 	case VCN_2_6__SRCID_DJPEG0_POISON:
 	case VCN_2_6__SRCID_EJPEG0_POISON:
@@ -712,10 +712,10 @@ static void jpeg_v2_5_set_dec_ring_funcs(struct amdgpu_device *adev)
 		if (adev->jpeg.harvest_config & (1 << i))
 			continue;
 		if (adev->asic_type == CHIP_ARCTURUS)
-			adev->jpeg.inst[i].ring_dec.funcs = &jpeg_v2_5_dec_ring_vm_funcs;
+			adev->jpeg.inst[i].ring_dec->funcs = &jpeg_v2_5_dec_ring_vm_funcs;
 		else  /* CHIP_ALDEBARAN */
-			adev->jpeg.inst[i].ring_dec.funcs = &jpeg_v2_6_dec_ring_vm_funcs;
-		adev->jpeg.inst[i].ring_dec.me = i;
+			adev->jpeg.inst[i].ring_dec->funcs = &jpeg_v2_6_dec_ring_vm_funcs;
+		adev->jpeg.inst[i].ring_dec->me = i;
 		DRM_INFO("JPEG(%d) JPEG decode is enabled in VM mode\n", i);
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 07251dc8607d..9394312cd90d 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -97,7 +97,7 @@ static int jpeg_v3_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	ring = &adev->jpeg.inst->ring_dec;
+	ring = adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = true;
 	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
 	ring->vm_hub = AMDGPU_MMHUB0(0);
@@ -107,8 +107,8 @@ static int jpeg_v3_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->jpeg.internal.jpeg_pitch = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
-	adev->jpeg.inst->external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
+	adev->jpeg.internal.jpeg_pitch[0] = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
+	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
 
 	return 0;
 }
@@ -143,7 +143,7 @@ static int jpeg_v3_0_sw_fini(void *handle)
 static int jpeg_v3_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
 	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
@@ -329,7 +329,7 @@ static int jpeg_v3_0_enable_static_power_gating(struct amdgpu_device *adev)
  */
 static int jpeg_v3_0_start(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
 	if (adev->pm.dpm_enabled)
@@ -526,7 +526,7 @@ static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
 
 	switch (entry->src_id) {
 	case VCN_2_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
+		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
 		DRM_ERROR("Unhandled interrupt: %d %d\n",
@@ -588,7 +588,7 @@ static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
 
 static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->ring_dec.funcs = &jpeg_v3_0_dec_ring_vm_funcs;
+	adev->jpeg.inst->ring_dec->funcs = &jpeg_v3_0_dec_ring_vm_funcs;
 	DRM_INFO("JPEG decode is enabled in VM mode\n");
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 2398e23a7d52..d20b2b852899 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -105,7 +105,7 @@ static int jpeg_v4_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	ring = &adev->jpeg.inst->ring_dec;
+	ring = adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = true;
 	ring->doorbell_index = amdgpu_sriov_vf(adev) ? (((adev->doorbell_index.vcn.vcn_ring0_1) << 1) + 4) : ((adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1);
 	ring->vm_hub = AMDGPU_MMHUB0(0);
@@ -116,8 +116,8 @@ static int jpeg_v4_0_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->jpeg.internal.jpeg_pitch = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
-	adev->jpeg.inst->external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
+	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
+	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
 	r = amdgpu_jpeg_ras_sw_init(adev);
 	if (r)
@@ -156,7 +156,7 @@ static int jpeg_v4_0_sw_fini(void *handle)
 static int jpeg_v4_0_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
 	if (amdgpu_sriov_vf(adev)) {
@@ -363,7 +363,7 @@ static int jpeg_v4_0_enable_static_power_gating(struct amdgpu_device *adev)
  */
 static int jpeg_v4_0_start(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
 	if (adev->pm.dpm_enabled)
@@ -441,7 +441,7 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device *adev)
 
 	table_size = 0;
 
-	ring = &adev->jpeg.inst->ring_dec;
+	ring = adev->jpeg.inst->ring_dec;
 
 	MMSCH_V4_0_INSERT_DIRECT_WT(SOC15_REG_OFFSET(JPEG, 0,
 		regUVD_LMI_JRBC_RB_64BIT_BAR_LOW),
@@ -678,7 +678,7 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 
 	switch (entry->src_id) {
 	case VCN_4_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
+		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	case VCN_4_0__SRCID_DJPEG0_POISON:
 	case VCN_4_0__SRCID_EJPEG0_POISON:
@@ -744,7 +744,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->ring_dec.funcs = &jpeg_v4_0_dec_ring_vm_funcs;
+	adev->jpeg.inst->ring_dec->funcs = &jpeg_v4_0_dec_ring_vm_funcs;
 	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 1fc72f9b52ed..784c83994ca1 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -85,7 +85,7 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 	if (r)
 		return r;
 
-	ring = &adev->jpeg.inst->ring_dec;
+	ring = adev->jpeg.inst->ring_dec;
 	ring->use_doorbell = false;
 	ring->vm_hub = AMDGPU_MMHUB0(0);
 	sprintf(ring->name, "jpeg_dec");
@@ -94,8 +94,8 @@ static int jpeg_v4_0_3_sw_init(void *handle)
 	if (r)
 		return r;
 
-	adev->jpeg.internal.jpeg_pitch = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
-	adev->jpeg.inst->external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
+	adev->jpeg.internal.jpeg_pitch[0] = regUVD_JPEG_PITCH_INTERNAL_OFFSET;
+	adev->jpeg.inst->external.jpeg_pitch[0] = SOC15_REG_OFFSET(JPEG, 0, regUVD_JPEG_PITCH);
 
 	return 0;
 }
@@ -130,7 +130,7 @@ static int jpeg_v4_0_3_sw_fini(void *handle)
 static int jpeg_v4_0_3_hw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 	int r;
 
 	r = amdgpu_ring_test_helper(ring);
@@ -254,7 +254,7 @@ static void jpeg_v4_0_3_enable_clock_gating(struct amdgpu_device *adev)
  */
 static int jpeg_v4_0_3_start(struct amdgpu_device *adev)
 {
-	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	struct amdgpu_ring *ring = adev->jpeg.inst->ring_dec;
 
 	WREG32_SOC15(JPEG, 0, regUVD_PGFSM_CONFIG,
 		1 << UVD_PGFSM_CONFIG__UVDJ_PWR_CONFIG__SHIFT);
@@ -675,7 +675,7 @@ static int jpeg_v4_0_3_process_interrupt(struct amdgpu_device *adev,
 
 	switch (entry->src_id) {
 	case VCN_2_0__SRCID__JPEG_DECODE:
-		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
+		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
 		DRM_DEV_ERROR(adev->dev, "Unhandled interrupt: %d %d\n",
@@ -737,8 +737,8 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_3_dec_ring_vm_funcs = {
 
 static void jpeg_v4_0_3_set_dec_ring_funcs(struct amdgpu_device *adev)
 {
-	adev->jpeg.inst->ring_dec.funcs = &jpeg_v4_0_3_dec_ring_vm_funcs;
-	adev->jpeg.inst->ring_dec.me = 0;
+	adev->jpeg.inst->ring_dec->funcs = &jpeg_v4_0_3_dec_ring_vm_funcs;
+	adev->jpeg.inst->ring_dec->me = 0;
 	DRM_DEV_INFO(adev->dev, "JPEG decode is enabled in VM mode\n");
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index f877c39c7cdd..16feb491adf5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -211,7 +211,7 @@ static int vcn_v1_0_hw_init(void *handle)
 			goto done;
 	}
 
-	ring = &adev->jpeg.inst->ring_dec;
+	ring = adev->jpeg.inst->ring_dec;
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
 		goto done;
@@ -1304,7 +1304,7 @@ static int vcn_v1_0_pause_dpg_mode(struct amdgpu_device *adev,
 							UVD_DPG_PAUSE__JPEG_PAUSE_DPG_ACK_MASK);
 
 				/* Restore */
-				ring = &adev->jpeg.inst->ring_dec;
+				ring = adev->jpeg.inst->ring_dec;
 				WREG32_SOC15(UVD, 0, mmUVD_LMI_JRBC_RB_VMID, 0);
 				WREG32_SOC15(UVD, 0, mmUVD_JRBC_RB_CNTL,
 							UVD_JRBC_RB_CNTL__RB_NO_FETCH_MASK |
@@ -1802,7 +1802,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		if (amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec))
+		if (amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec))
 			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 		else
 			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
@@ -1810,7 +1810,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 		adev->vcn.pause_dpg_mode(adev, 0, &new_state);
 	}
 
-	fences += amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec);
+	fences += amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec);
 	fences += amdgpu_fence_count_emitted(&adev->vcn.inst->ring_dec);
 
 	if (fences == 0) {
@@ -1832,7 +1832,7 @@ static void vcn_v1_0_ring_begin_use(struct amdgpu_ring *ring)
 
 	mutex_lock(&adev->vcn.vcn1_jpeg1_workaround);
 
-	if (amdgpu_fence_wait_empty(&ring->adev->jpeg.inst->ring_dec))
+	if (amdgpu_fence_wait_empty(ring->adev->jpeg.inst->ring_dec))
 		DRM_ERROR("VCN dec: jpeg dec ring may not be empty\n");
 
 	vcn_v1_0_set_pg_for_begin_use(ring, set_clocks);
@@ -1864,7 +1864,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 		else
 			new_state.fw_based = VCN_DPG_STATE__UNPAUSE;
 
-		if (amdgpu_fence_count_emitted(&adev->jpeg.inst->ring_dec))
+		if (amdgpu_fence_count_emitted(adev->jpeg.inst->ring_dec))
 			new_state.jpeg = VCN_DPG_STATE__PAUSE;
 		else
 			new_state.jpeg = VCN_DPG_STATE__UNPAUSE;
-- 
2.39.2

