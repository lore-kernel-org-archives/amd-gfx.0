Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05E3E81E1F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Oct 2023 18:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1190210E558;
	Fri,  6 Oct 2023 18:51:05 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B1E810E55B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Oct 2023 18:50:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gw/mX3n2ekE5Gkx44ZmokJ6UmfT7Sm8RZ6qMwQ/maElrCJl2VoQyVoQs+eK/jwygihvyYCnsmNV+eJgD4Iub+3gemVpRM3TWJiyZDjoEiyoUeJvBeRN4xiufiVHYSJc2QNDpsK7n0LSUva+jUoQ414X8f91CwJrAaRaBw5OV2KdOJ8I4Wj6c5fXQ2vPCQX9rPuPHfth1LE9Hwk+3mZYj1R7BIVuNJHgPdSZm5AJ4xc0N7qDsYkjiFwcfjdfwONBCiDzncHoAR3yHvLMH5bqh4jvR9B3O+HBjFnOhmC7tAnXtN1omE991hdvG6wrw7B42NsqCz2C98kUO9i6zcFNdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g5sq+j7gDEsaKG7i4yvF+hKAMnDW7c/O6v7POaAtqc4=;
 b=GtXgO3P1nH/1zKioKGV0mJiG+VzV/9x4SpjTjFHL+IJt/0cl7pO8S8wy6C5GEUmicB+dIJ7K+P+q8Wotg+24wV7cnhaZ0xe4/fNvLc3VaUCQVYxAfBupG3EAYHO5xQXCwstysGVMyvGq+JpQ1eqrw6GQ0BMFHN8530K1ZYLP/F2SVIBrtWmTugUtvyX/q88pfvT+rpcgKu4s0wLc8eyJnQE5dT5cgRAidgno1LiYhy1sCmRlobhxuDioc/uhBZ4cNSqa7knikKrtQytRm08vraGrm0HhH556ofhjQpLvVt+oo7diocB/TK8izkg6zlxU++6o3vl4nridG7bUssdmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g5sq+j7gDEsaKG7i4yvF+hKAMnDW7c/O6v7POaAtqc4=;
 b=IVj1Lmt5BgGn6eEYpcev0Ly4GTy9d49phtZXeGikew3d/dLXsPpOBXIWYmsH6PprDyBwPyVVtESCGCn32s3DJUlxQ8UWmha6LD1t2oyl0LZNJ0My05kGn5nj4hsxTqO27hhRWu1dZHINZ61xkAHbPm2ENyhohVbs5z2EcyT9xCY=
Received: from BL1PR13CA0256.namprd13.prod.outlook.com (2603:10b6:208:2ba::21)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.36; Fri, 6 Oct
 2023 18:50:54 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::6) by BL1PR13CA0256.outlook.office365.com
 (2603:10b6:208:2ba::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.29 via Frontend
 Transport; Fri, 6 Oct 2023 18:50:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 18:50:54 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 13:50:53 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v5 3/7] drm/amd: Split up UVD suspend into prepare and suspend
 steps
Date: Fri, 6 Oct 2023 13:50:22 -0500
Message-ID: <20231006185026.5536-4-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006185026.5536-1-mario.limonciello@amd.com>
References: <20231006185026.5536-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: fc9d487b-f8e9-45ab-cd09-08dbc69d2b99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ki7TX00SR6NurMGEHw4EdK99zpJP74WAJ5qNtIPKPFmeNEVypPrXVZOh7gmbMmulZ8+yXuzuiLux6JdmFsSvuVsTkcMi+JaZ00TFaqGR8B97P2wESVVPH8KylFIraYtYHVLZvOgt6abqZHpi1z4XixV+DrwrxeAH7gIiNR5eOqnkQgjRkUr+Du/8zU7oEN/G0V9VP9+O0P4Lkt/Pq4//+wFj6FyjNdBLUmz7cR5uEpCcsHCHXYBG9SBinAhmkLFjeZoL7Ayw/3+pov98J3nSMhy5kKzAElfmuSIZtIbfMtl575T7Ha0FPiAkvmV8XcAnvHfCgQpGnAOJXsL4h1oU2P1jacE69VgGdj7N5bk22xCCy/ria56y59DVXQaCP4PKnidNV6Ab57I6yKqzO8EZfhVWSNEo/fR9WgYeCdj50i1gjYr5k3/iJrdI1Bu/3HSHx5Rm0ZgFMWEdfCnLByBBm/Ky2ggyLoNCYaG9LwDVLI2RJlNX0b+zMo0523/wkgBAwjkzMezF8Bx18HkqQkbLieH2QfjS5rKdkkfpqLEVGM0mnJgluHXlbZ3ncDJZa07BTQnOLP5ccyOwI1svDqzwNsl3WtD+W+6ppnyRMBSxvTFSWy0VTubHKvPmvgvqq8GFuLqJ0VJ+y02wuISBaRk1AOpvn/QdwUi2sMLut1P21x3V+J7IW5vjimOFfoS1VpyEAHVVMjx9Z2/R7PsLSbjGphS2D7des1/LjGXAkCkbwIlP6KkacNILdeb1rU+U3rYp0b3JhBvgcUyQKX9YeNmqqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(64100799003)(451199024)(186009)(82310400011)(1800799009)(46966006)(36840700001)(40470700004)(83380400001)(336012)(40460700003)(40480700001)(6666004)(7696005)(478600001)(86362001)(36860700001)(47076005)(82740400003)(356005)(81166007)(15650500001)(2906002)(41300700001)(316002)(426003)(2616005)(1076003)(26005)(16526019)(36756003)(54906003)(44832011)(5660300002)(6916009)(70206006)(70586007)(8676002)(8936002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 18:50:54.6253 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9d487b-f8e9-45ab-cd09-08dbc69d2b99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

amdgpu_uvd_suspend() allocates memory and copies objects into that
allocated memory.  This fails under memory pressure.  Instead move
majority of this code into a prepare step when swap can still be
allocated.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v4->v5:
 * New patch
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c   |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c   |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c   |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c   |  9 +++++++++
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c   |  9 +++++++++
 7 files changed, 54 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index b7441654e6fa..a53c4ba8b3fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -418,12 +418,11 @@ int amdgpu_uvd_entity_init(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_uvd_suspend(struct amdgpu_device *adev)
+int amdgpu_uvd_prepare(struct amdgpu_device *adev)
 {
 	unsigned int size;
 	void *ptr;
 	int i, j, idx;
-	bool in_ras_intr = amdgpu_ras_intr_triggered();
 
 	cancel_delayed_work_sync(&adev->uvd.idle_work);
 
@@ -452,7 +451,7 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
 
 		if (drm_dev_enter(adev_to_drm(adev), &idx)) {
 			/* re-write 0 since err_event_athub will corrupt VCPU buffer */
-			if (in_ras_intr)
+			if (amdgpu_ras_intr_triggered())
 				memset(adev->uvd.inst[j].saved_bo, 0, size);
 			else
 				memcpy_fromio(adev->uvd.inst[j].saved_bo, ptr, size);
@@ -461,7 +460,12 @@ int amdgpu_uvd_suspend(struct amdgpu_device *adev)
 		}
 	}
 
-	if (in_ras_intr)
+	return 0;
+}
+
+int amdgpu_uvd_suspend(struct amdgpu_device *adev)
+{
+	if (amdgpu_ras_intr_triggered())
 		DRM_WARN("UVD VCPU state may lost due to RAS ERREVENT_ATHUB_INTERRUPT\n");
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
index 9f89bb7cd60b..72228425e021 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.h
@@ -74,6 +74,7 @@ struct amdgpu_uvd {
 int amdgpu_uvd_sw_init(struct amdgpu_device *adev);
 int amdgpu_uvd_sw_fini(struct amdgpu_device *adev);
 int amdgpu_uvd_entity_init(struct amdgpu_device *adev);
+int amdgpu_uvd_prepare(struct amdgpu_device *adev);
 int amdgpu_uvd_suspend(struct amdgpu_device *adev);
 int amdgpu_uvd_resume(struct amdgpu_device *adev);
 int amdgpu_uvd_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 5534c769b655..869e9948fa36 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -706,6 +706,14 @@ static int uvd_v3_1_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v3_1_prepare(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare(adev);
+
+}
+
 static int uvd_v3_1_suspend(void *handle)
 {
 	int r;
@@ -806,6 +814,7 @@ static const struct amd_ip_funcs uvd_v3_1_ip_funcs = {
 	.sw_fini = uvd_v3_1_sw_fini,
 	.hw_init = uvd_v3_1_hw_init,
 	.hw_fini = uvd_v3_1_hw_fini,
+	.prepare = uvd_v3_1_prepare,
 	.suspend = uvd_v3_1_suspend,
 	.resume = uvd_v3_1_resume,
 	.is_idle = uvd_v3_1_is_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index c108b8381795..e589c17af371 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -220,6 +220,14 @@ static int uvd_v4_2_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v4_2_prepare(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare(adev);
+
+}
+
 static int uvd_v4_2_suspend(void *handle)
 {
 	int r;
@@ -756,6 +764,7 @@ static const struct amd_ip_funcs uvd_v4_2_ip_funcs = {
 	.sw_fini = uvd_v4_2_sw_fini,
 	.hw_init = uvd_v4_2_hw_init,
 	.hw_fini = uvd_v4_2_hw_fini,
+	.prepare = uvd_v4_2_prepare,
 	.suspend = uvd_v4_2_suspend,
 	.resume = uvd_v4_2_resume,
 	.is_idle = uvd_v4_2_is_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index d7e31e48a2b8..65aa23bc2d91 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -218,6 +218,14 @@ static int uvd_v5_0_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v5_0_prepare(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare(adev);
+
+}
+
 static int uvd_v5_0_suspend(void *handle)
 {
 	int r;
@@ -863,6 +871,7 @@ static const struct amd_ip_funcs uvd_v5_0_ip_funcs = {
 	.sw_fini = uvd_v5_0_sw_fini,
 	.hw_init = uvd_v5_0_hw_init,
 	.hw_fini = uvd_v5_0_hw_fini,
+	.prepare = uvd_v5_0_prepare,
 	.suspend = uvd_v5_0_suspend,
 	.resume = uvd_v5_0_resume,
 	.is_idle = uvd_v5_0_is_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index 5fe872f4bea7..a4035aeb973b 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -542,6 +542,14 @@ static int uvd_v6_0_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v6_0_prepare(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare(adev);
+
+}
+
 static int uvd_v6_0_suspend(void *handle)
 {
 	int r;
@@ -1528,6 +1536,7 @@ static const struct amd_ip_funcs uvd_v6_0_ip_funcs = {
 	.sw_fini = uvd_v6_0_sw_fini,
 	.hw_init = uvd_v6_0_hw_init,
 	.hw_fini = uvd_v6_0_hw_fini,
+	.prepare = uvd_v6_0_prepare,
 	.suspend = uvd_v6_0_suspend,
 	.resume = uvd_v6_0_resume,
 	.is_idle = uvd_v6_0_is_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 86d1d46e1e5e..3228bf1a379c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -612,6 +612,14 @@ static int uvd_v7_0_hw_fini(void *handle)
 	return 0;
 }
 
+static int uvd_v7_0_prepare(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return amdgpu_uvd_prepare(adev);
+
+}
+
 static int uvd_v7_0_suspend(void *handle)
 {
 	int r;
@@ -1787,6 +1795,7 @@ const struct amd_ip_funcs uvd_v7_0_ip_funcs = {
 	.sw_fini = uvd_v7_0_sw_fini,
 	.hw_init = uvd_v7_0_hw_init,
 	.hw_fini = uvd_v7_0_hw_fini,
+	.prepare = uvd_v7_0_prepare,
 	.suspend = uvd_v7_0_suspend,
 	.resume = uvd_v7_0_resume,
 	.is_idle = NULL /* uvd_v7_0_is_idle */,
-- 
2.34.1

