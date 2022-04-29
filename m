Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D7F0C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AD5710F52F;
	Fri, 29 Apr 2022 17:47:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 195CD10F354
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9wJwO2zyN8v/M+wLUlo2vKPlR2dIh9aQhDVRFcyQS2mpQQOUFUjG4FuvDjyoEm22+o8HIbK2+lOnvfSMmvzkLYe6TpYlIovFoECxKqLOUrWc10A7vg0B48hbdTfNkiZ2RRzwA7pT+tlZCVykzfAZuC+l803m4Sq+T5EtzvBpUOmEPLaqwpeiX419ccYyIXG7mn6XOAZedDWvovmoywiSHTHSEFeSfGLZjF0L0J78sOjkDVXCCGcF6vCcXsbrHTr3dTgrmYq+myJ60x3YcoUHB2awVJkV4g32BGehA1CeGu5CXgQqm1hwEdkqjNHIr9Pwl9EeGL2BkmWlsuCXydcKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UkSMZA0pGrGGFrbMnoLZM2YdXR2quIefBZRPIhyWFuA=;
 b=Y8MVDUVEVQD7P1azCqZZEj+ICwDf+hDuGFPwyE3dklyhBNqtbdMFuQM1y3k2EZUTdI/vqQUoHC1S8LrAumsznS1cqHU9dUcYYTCWMESGsErIuLtxggarjlolsGbdf/swvW/JjQpsSF3taoMwQ5GGwjbllVzC4/gMLB6ebrRVE06i45QtQhmyLps75m7WMSXLSWyUYSDZ2pxjAt7RJWU55LSZ9SY2PpRX1DISJjBHBdAkB1WhnvjOUwF0A7Hn6h9HWZUAfdKm5JVH24Tq89kAjuSBZIgzpZmnGwCBiQ2vb7P5+nz9t8LKK/TalCszkkKu3+96vrbVZ0OphPxEI23H4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UkSMZA0pGrGGFrbMnoLZM2YdXR2quIefBZRPIhyWFuA=;
 b=vMzuOa2Y3NTIBvpauZgLrSENgsXVa8mxl1CgoURFlW1BAXFi0MUqb4LUQdtnaiFcbgk6l01zFna8/3vY9JYhHNXrzPJBLkAPClhk9fMs5ssyEaJCZGn5RFuM/nVU27RN2Owimdk91Te8dTcwAavVIHnqKjn/DG7UIRCQd21gUOY=
Received: from DM6PR02CA0081.namprd02.prod.outlook.com (2603:10b6:5:1f4::22)
 by DM4PR12MB5263.namprd12.prod.outlook.com (2603:10b6:5:39b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 29 Apr
 2022 17:47:02 +0000
Received: from DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1f4:cafe::28) by DM6PR02CA0081.outlook.office365.com
 (2603:10b6:5:1f4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT054.mail.protection.outlook.com (10.13.173.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:02 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 38/73] drm/amdgpu: enable mes kiq N-1 test on sienna cichlid
Date: Fri, 29 Apr 2022 13:45:49 -0400
Message-ID: <20220429174624.459475-39-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 79dc7008-2dd8-484e-843d-08da2a084467
X-MS-TrafficTypeDiagnostic: DM4PR12MB5263:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB526365AEA36A61CA4770621CF7FC9@DM4PR12MB5263.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/C8wWWxBYSwq+JBExkAsUYNu04vyoPZ9hDEl09tPp6BIpdq+ti6ZAPJjCaKRdaF2+fqd4NEjHfZeQUhpaEZ7TXkgPSKu4lSH6TeAasjBSviwBhpShJciilPZvwAQ7OKxN/COFQ3IT0m1N+pEH16SyBLNkDFjmr0bwrVYFP9cDKXLw162Ib8duK3WPE94v2D+k+a4wHKicw+sROT2rf4TIBwrrs/tTodZfa/jA8uuuw6tWnmf0d45j4BeT1RZTibYs+wddFAGMPHcnyfbGHegPIYcWuzoWelTM563j2V/OdxYh1EFO2PAm6MEz1UC7clsLc/dsXxI1FHPc9Eq+uyd5IDGf0UIuFlrHDsgjbuICk2Y0t+yEHskJfl7EbtqRgDrdAmg0m8RfsZr0a0yx0CKm8TsofuGtvOjR4B9CvRR3Z4lgVLUKBM6OS86cFWB35/bcUVnmLR+U1QcWbuWPQ+0/f6J1E8Qzu6uMedaHgRsLC0v3H50c3uFvb1GLKubjrR8Glgk4KxWxbn5731QTnyIrtXCAxomA3ddB0Ry7FTfmx2H8r8osk1ZXb/MOPoKBhGpRwucMTJCY7Z9OhM0uS5hrPJsDNWNgBDfBEj1OcxUcu21ETjvr5qfWiGDqTY/KC67yNRouLJNFpVw029xp5C3EEm6IQa8y/ysFSYCZP8hZfYzdcrjtLsL4nKwSJ9KvMzzKActN89ibF3xUw3gBhDdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(30864003)(82310400005)(2906002)(508600001)(4326008)(8676002)(70586007)(70206006)(356005)(40460700003)(316002)(54906003)(5660300002)(36860700001)(81166007)(8936002)(83380400001)(26005)(86362001)(2616005)(36756003)(186003)(16526019)(1076003)(7696005)(47076005)(426003)(336012)(6916009)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:02.0992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79dc7008-2dd8-484e-843d-08da2a084467
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5263
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

Enable kiq support on gfx10.3, enable mes kiq (n-1)
test on sienna cichlid, so that mes kiq can be tested on
sienna cichlid. The patch can be dropped once mes kiq
is functional.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c |  32 ++--
 drivers/gpu/drm/amd/amdgpu/mes_v10_1.c | 202 ++++++++++++++++++++-----
 2 files changed, 184 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1208d01cc936..9042e0b480ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4897,16 +4897,18 @@ static int gfx_v10_0_sw_init(void *handle)
 		}
 	}
 
-	r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE);
-	if (r) {
-		DRM_ERROR("Failed to init KIQ BOs!\n");
-		return r;
-	}
+	if (!adev->enable_mes_kiq) {
+		r = amdgpu_gfx_kiq_init(adev, GFX10_MEC_HPD_SIZE);
+		if (r) {
+			DRM_ERROR("Failed to init KIQ BOs!\n");
+			return r;
+		}
 
-	kiq = &adev->gfx.kiq;
-	r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
-	if (r)
-		return r;
+		kiq = &adev->gfx.kiq;
+		r = amdgpu_gfx_kiq_init_ring(adev, &kiq->ring, &kiq->irq);
+		if (r)
+			return r;
+	}
 
 	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct v10_compute_mqd));
 	if (r)
@@ -4958,8 +4960,11 @@ static int gfx_v10_0_sw_fini(void *handle)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
 	amdgpu_gfx_mqd_sw_fini(adev);
-	amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring);
-	amdgpu_gfx_kiq_fini(adev);
+
+	if (!adev->enable_mes_kiq) {
+		amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq.ring);
+		amdgpu_gfx_kiq_fini(adev);
+	}
 
 	gfx_v10_0_pfp_fini(adev);
 	gfx_v10_0_ce_fini(adev);
@@ -7213,7 +7218,10 @@ static int gfx_v10_0_cp_resume(struct amdgpu_device *adev)
 			return r;
 	}
 
-	r = gfx_v10_0_kiq_resume(adev);
+	if (adev->enable_mes_kiq && adev->mes.kiq_hw_init)
+		r = amdgpu_mes_kiq_hw_init(adev);
+	else
+		r = gfx_v10_0_kiq_resume(adev);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
index f82a6f981629..fecf3f26bf7c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v10_1.c
@@ -33,11 +33,15 @@
 
 #define mmCP_MES_IC_OP_CNTL_Sienna_Cichlid               0x2820
 #define mmCP_MES_IC_OP_CNTL_Sienna_Cichlid_BASE_IDX      1
+#define mmRLC_CP_SCHEDULERS_Sienna_Cichlid		0x4ca1
+#define mmRLC_CP_SCHEDULERS_Sienna_Cichlid_BASE_IDX	1
 
 MODULE_FIRMWARE("amdgpu/navi10_mes.bin");
 MODULE_FIRMWARE("amdgpu/sienna_cichlid_mes.bin");
+MODULE_FIRMWARE("amdgpu/sienna_cichlid_mes1.bin");
 
 static int mes_v10_1_hw_fini(void *handle);
+static int mes_v10_1_kiq_hw_init(struct amdgpu_device *adev);
 
 #define MES_EOP_SIZE   2048
 
@@ -278,11 +282,11 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev,
 	const struct mes_firmware_header_v1_0 *mes_hdr;
 	struct amdgpu_firmware_info *info;
 
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 1, 10):
 		chip_name = "navi10";
 		break;
-	case CHIP_SIENNA_CICHLID:
+	case IP_VERSION(10, 3, 0):
 		chip_name = "sienna_cichlid";
 		break;
 	default:
@@ -293,7 +297,8 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev,
 		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
 			 chip_name);
 	else
-		BUG();
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes1.bin",
+			 chip_name);
 
 	err = request_firmware(&adev->mes.fw[pipe], fw_name, adev->dev);
 	if (err)
@@ -326,7 +331,8 @@ static int mes_v10_1_init_microcode(struct amdgpu_device *adev,
 			ucode = AMDGPU_UCODE_ID_CP_MES;
 			ucode_data = AMDGPU_UCODE_ID_CP_MES_DATA;
 		} else {
-			BUG();
+			ucode = AMDGPU_UCODE_ID_CP_MES1;
+			ucode_data = AMDGPU_UCODE_ID_CP_MES1_DATA;
 		}
 
 		info = &adev->firmware.ucode[ucode];
@@ -439,6 +445,8 @@ static void mes_v10_1_enable(struct amdgpu_device *adev, bool enable)
 	if (enable) {
 		data = RREG32_SOC15(GC, 0, mmCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
+		data = REG_SET_FIELD(data, CP_MES_CNTL,
+			     MES_PIPE1_RESET, adev->enable_mes_kiq ? 1 : 0);
 		WREG32_SOC15(GC, 0, mmCP_MES_CNTL, data);
 
 		mutex_lock(&adev->srbm_mutex);
@@ -462,13 +470,18 @@ static void mes_v10_1_enable(struct amdgpu_device *adev, bool enable)
 
 		/* unhalt MES and activate pipe0 */
 		data = REG_SET_FIELD(0, CP_MES_CNTL, MES_PIPE0_ACTIVE, 1);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE,
+				     adev->enable_mes_kiq ? 1 : 0);
 		WREG32_SOC15(GC, 0, mmCP_MES_CNTL, data);
 	} else {
 		data = RREG32_SOC15(GC, 0, mmCP_MES_CNTL);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_ACTIVE, 0);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_ACTIVE, 0);
 		data = REG_SET_FIELD(data, CP_MES_CNTL,
 				     MES_INVALIDATE_ICACHE, 1);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE0_RESET, 1);
+		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_PIPE1_RESET,
+				     adev->enable_mes_kiq ? 1 : 0);
 		data = REG_SET_FIELD(data, CP_MES_CNTL, MES_HALT, 1);
 		WREG32_SOC15(GC, 0, mmCP_MES_CNTL, data);
 	}
@@ -525,8 +538,8 @@ static int mes_v10_1_load_microcode(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, mmCP_MES_MDBOUND_LO, 0x3FFFF);
 
 	/* invalidate ICACHE */
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 3, 0):
 		data = RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid);
 		break;
 	default:
@@ -535,8 +548,8 @@ static int mes_v10_1_load_microcode(struct amdgpu_device *adev,
 	}
 	data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 0);
 	data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, INVALIDATE_CACHE, 1);
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 3, 0):
 		WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid, data);
 		break;
 	default:
@@ -545,8 +558,8 @@ static int mes_v10_1_load_microcode(struct amdgpu_device *adev,
 	}
 
 	/* prime the ICACHE. */
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 3, 0):
 		data = RREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid);
 		break;
 	default:
@@ -554,8 +567,8 @@ static int mes_v10_1_load_microcode(struct amdgpu_device *adev,
 		break;
 	}
 	data = REG_SET_FIELD(data, CP_MES_IC_OP_CNTL, PRIME_ICACHE, 1);
-	switch (adev->asic_type) {
-	case CHIP_SIENNA_CICHLID:
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 3, 0):
 		WREG32_SOC15(GC, 0, mmCP_MES_IC_OP_CNTL_Sienna_Cichlid, data);
 		break;
 	default:
@@ -883,13 +896,40 @@ static int mes_v10_1_ring_init(struct amdgpu_device *adev)
 				AMDGPU_RING_PRIO_DEFAULT, NULL);
 }
 
+static int mes_v10_1_kiq_ring_init(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+
+	spin_lock_init(&adev->gfx.kiq.ring_lock);
+
+	ring = &adev->gfx.kiq.ring;
+
+	ring->me = 3;
+	ring->pipe = 1;
+	ring->queue = 0;
+
+	ring->adev = NULL;
+	ring->ring_obj = NULL;
+	ring->use_doorbell = true;
+	ring->doorbell_index = adev->doorbell_index.mes_ring1 << 1;
+	ring->eop_gpu_addr = adev->mes.eop_gpu_addr[AMDGPU_MES_KIQ_PIPE];
+	ring->no_scheduler = true;
+	sprintf(ring->name, "mes_kiq_%d.%d.%d",
+		ring->me, ring->pipe, ring->queue);
+
+	return amdgpu_ring_init(adev, ring, 1024, NULL, 0,
+				AMDGPU_RING_PRIO_DEFAULT, NULL);
+}
+
 static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 				 enum admgpu_mes_pipe pipe)
 {
 	int r, mqd_size = sizeof(struct v10_compute_mqd);
 	struct amdgpu_ring *ring;
 
-	if (pipe == AMDGPU_MES_SCHED_PIPE)
+	if (pipe == AMDGPU_MES_KIQ_PIPE)
+		ring = &adev->gfx.kiq.ring;
+	else if (pipe == AMDGPU_MES_SCHED_PIPE)
 		ring = &adev->mes.ring;
 	else
 		BUG();
@@ -918,22 +958,34 @@ static int mes_v10_1_mqd_sw_init(struct amdgpu_device *adev,
 static int mes_v10_1_sw_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int r, pipe = AMDGPU_MES_SCHED_PIPE;
+	int pipe, r;
 
 	adev->mes.adev = adev;
 	adev->mes.funcs = &mes_v10_1_funcs;
+	adev->mes.kiq_hw_init = &mes_v10_1_kiq_hw_init;
 
-	r = mes_v10_1_init_microcode(adev, pipe);
-	if (r)
-		return r;
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		if (!adev->enable_mes_kiq && pipe == AMDGPU_MES_KIQ_PIPE)
+			continue;
 
-	r = mes_v10_1_allocate_eop_buf(adev, pipe);
-	if (r)
-		return r;
+		r = mes_v10_1_init_microcode(adev, pipe);
+		if (r)
+			return r;
 
-	r = mes_v10_1_mqd_sw_init(adev, pipe);
-	if (r)
-		return r;
+		r = mes_v10_1_allocate_eop_buf(adev, pipe);
+		if (r)
+			return r;
+
+		r = mes_v10_1_mqd_sw_init(adev, pipe);
+		if (r)
+			return r;
+	}
+
+	if (adev->enable_mes_kiq) {
+		r = mes_v10_1_kiq_ring_init(adev);
+		if (r)
+			return r;
+	}
 
 	r = mes_v10_1_ring_init(adev);
 	if (r)
@@ -949,43 +1001,115 @@ static int mes_v10_1_sw_init(void *handle)
 static int mes_v10_1_sw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int pipe = AMDGPU_MES_SCHED_PIPE;
+	int pipe;
 
 	amdgpu_device_wb_free(adev, adev->mes.sch_ctx_offs);
 	amdgpu_device_wb_free(adev, adev->mes.query_status_fence_offs);
 
-	kfree(adev->mes.mqd_backup[pipe]);
+	for (pipe = 0; pipe < AMDGPU_MAX_MES_PIPES; pipe++) {
+		kfree(adev->mes.mqd_backup[pipe]);
+
+		amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
+				      &adev->mes.eop_gpu_addr[pipe],
+				      NULL);
+
+		mes_v10_1_free_microcode(adev, pipe);
+	}
+
+	amdgpu_bo_free_kernel(&adev->gfx.kiq.ring.mqd_obj,
+			      &adev->gfx.kiq.ring.mqd_gpu_addr,
+			      &adev->gfx.kiq.ring.mqd_ptr);
 
 	amdgpu_bo_free_kernel(&adev->mes.ring.mqd_obj,
 			      &adev->mes.ring.mqd_gpu_addr,
 			      &adev->mes.ring.mqd_ptr);
 
-	amdgpu_bo_free_kernel(&adev->mes.eop_gpu_obj[pipe],
-			      &adev->mes.eop_gpu_addr[pipe],
-			      NULL);
-
-	mes_v10_1_free_microcode(adev, pipe);
+	amdgpu_ring_fini(&adev->gfx.kiq.ring);
 	amdgpu_ring_fini(&adev->mes.ring);
 
 	return 0;
 }
 
-static int mes_v10_1_hw_init(void *handle)
+static void mes_v10_1_kiq_setting(struct amdgpu_ring *ring)
 {
-	int r;
-	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	uint32_t tmp;
+	struct amdgpu_device *adev = ring->adev;
+
+	/* tell RLC which is KIQ queue */
+	switch (adev->ip_versions[GC_HWIP][0]) {
+	case IP_VERSION(10, 3, 0):
+	case IP_VERSION(10, 3, 2):
+	case IP_VERSION(10, 3, 1):
+	case IP_VERSION(10, 3, 4):
+		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid);
+		tmp &= 0xffffff00;
+		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
+		tmp |= 0x80;
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS_Sienna_Cichlid, tmp);
+		break;
+	default:
+		tmp = RREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS);
+		tmp &= 0xffffff00;
+		tmp |= (ring->me << 5) | (ring->pipe << 3) | (ring->queue);
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		tmp |= 0x80;
+		WREG32_SOC15(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
+		break;
+	}
+}
+
+static int mes_v10_1_kiq_hw_init(struct amdgpu_device *adev)
+{
+	int r = 0;
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
-		r = mes_v10_1_load_microcode(adev,
-					     AMDGPU_MES_SCHED_PIPE);
+		r = mes_v10_1_load_microcode(adev, AMDGPU_MES_KIQ_PIPE);
+		if (r) {
+			DRM_ERROR("failed to load MES kiq fw, r=%d\n", r);
+			return r;
+		}
+
+		r = mes_v10_1_load_microcode(adev, AMDGPU_MES_SCHED_PIPE);
 		if (r) {
-			DRM_ERROR("failed to MES fw, r=%d\n", r);
+			DRM_ERROR("failed to load MES fw, r=%d\n", r);
 			return r;
 		}
 	}
 
 	mes_v10_1_enable(adev, true);
 
+	mes_v10_1_kiq_setting(&adev->gfx.kiq.ring);
+
+	r = mes_v10_1_queue_init(adev);
+	if (r)
+		goto failure;
+
+	return r;
+
+failure:
+	mes_v10_1_hw_fini(adev);
+	return r;
+}
+
+static int mes_v10_1_hw_init(void *handle)
+{
+	int r;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	if (!adev->enable_mes_kiq) {
+		if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+			r = mes_v10_1_load_microcode(adev,
+					     AMDGPU_MES_SCHED_PIPE);
+			if (r) {
+				DRM_ERROR("failed to MES fw, r=%d\n", r);
+				return r;
+			}
+		}
+
+		mes_v10_1_enable(adev, true);
+	}
+
 	r = mes_v10_1_queue_init(adev);
 	if (r)
 		goto failure;
@@ -1013,8 +1137,10 @@ static int mes_v10_1_hw_fini(void *handle)
 
 	mes_v10_1_enable(adev, false);
 
-	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT)
+	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		mes_v10_1_free_ucode_buffers(adev, AMDGPU_MES_KIQ_PIPE);
 		mes_v10_1_free_ucode_buffers(adev, AMDGPU_MES_SCHED_PIPE);
+	}
 
 	return 0;
 }
-- 
2.35.1

