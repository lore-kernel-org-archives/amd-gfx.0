Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84FFC6FD18
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Mar 2023 15:18:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3448E10E8E2;
	Tue, 28 Mar 2023 15:18:51 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9947110E935
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Mar 2023 15:18:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nwTTje+Hl2ecb26xbkLNnIC4hqnRdL8JtbjjhuhYvB4FQsn5XVQcRiEtZJKVJBhnOo8GptCQYzoRqIpXrVvB41FfXKV3dhoxTPtaPR80sJBnFXGO2l8/prlC98F0FOL+0dd8GOIZqHA27GOoRb859V4Uuebovvyf1jv746k7ItghIx5c0JiVZC7bpoKrgjDBkz8yYkn9fCJgeuhUz99q3nsnhNbmBka2txy/sZgCDuqUk6WvnsJMNgO+KlekdDyUB4OCo/O1whJJsXbKFRQwZSx9YzJnCz1XzgHgK69YKFgVgLvGbM1H6I4D2Cheehuqu4HWC0/sW6+nt8+ePmBPqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5HWvuEJtD+b4falaLlNeFI/WbkpxAsxB5iAstl2nbA=;
 b=lQAF1tP3HIz+jwRW1U4oN6URFDcGIdAEgX7IYnh3NQ11dZ3KB2HDVyoBFp4EvlX41fNsNeyTrb6et8xhy9fz3WCeYJRrq9IA1BkboXFP46ZILIWyb2spai/FpDghCF1rPSeHj4dBdQnqPQLfNcOZOtaabQEzoujEDYgntjAJOkQLOQ4C+Kaw14XBEobTzSQqmAo37eJjqwd/RW6S3bQjZ25D/H8wTwAsn5BJlJiFxDKDLaEo00HMu8/oSsfxneYJevQNcEJA5wcuNihXt2ylXhhCBhE7nrlzHgkrPgWnLwIPni9BLQZgyxsW+eWmAFkmaMf0BbAREme1w/pO6j9J7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5HWvuEJtD+b4falaLlNeFI/WbkpxAsxB5iAstl2nbA=;
 b=HOi3uGzkBrgSxGsN+ZkwaKL14AXNPvO30Tkv/VgyOwc65oCj9VkmZRsES9ZqkSNC1F8QJDdUNnzqK4oUDhxiUvzac9xEePbzaCwvENl4BYz2pQx/R7/ICYTF9tFRt01WVecqXZmIv1340pUlk6JG1ZlNIkOzYvhzq9XG8F9QhZM=
Received: from BN0PR08CA0027.namprd08.prod.outlook.com (2603:10b6:408:142::25)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Tue, 28 Mar
 2023 15:18:42 +0000
Received: from BL02EPF000100D0.namprd05.prod.outlook.com
 (2603:10b6:408:142:cafe::95) by BN0PR08CA0027.outlook.office365.com
 (2603:10b6:408:142::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.42 via Frontend
 Transport; Tue, 28 Mar 2023 15:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000100D0.mail.protection.outlook.com (10.167.241.204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.30 via Frontend Transport; Tue, 28 Mar 2023 15:18:42 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 28 Mar
 2023 10:18:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 6/6] drm/amdgpu: Change num_xcd to xcc_mask
Date: Tue, 28 Mar 2023 11:18:24 -0400
Message-ID: <20230328151824.1934600-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230328151824.1934600-1-alexander.deucher@amd.com>
References: <20230328151824.1934600-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000100D0:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 33dd78ef-e3d5-485c-d1fe-08db2f9fb715
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iIzOpg6TuMDECgrQrTwJJN8w6FTgk3aFyggSWWELu1UGFdwAijkzSD1/ItBO5cQ4V6treAPafn9K1VVHG46bT96CUaqEM8BCJHUZm7RIXGwzO9IN8adHPw/Ay8zbptsfGIP+qtFpddYZYkyKRo7tWICncXrVKKINZJn8gT/I7og7Ldws+cFlCdFxRznI5RhZ7JRHRLeQabOi4fY8i/vDA0aIDHazo7SlWLm9nqOq6Pio1sRZnDdfSJiJay4Kt1xulKwhwh0cI0c6c00Meent/ziH/uSWV1XB9OcMYfwifTk7LNYODtf3mpiPAecyHz0FIZBEM+dBqlboVRbDXqRmR/K3w3gt8PhjFdYlhEOzs7JgKGUNk98PgxEtDehIC+2f4R6EoGChWUqoZ8I0mQn1yuCfTuIFQU7qrvywF3jMmULhYAseY+wvGelMJiV4j5fHLclN22GEB6HLox9KG+r59kujib6xTRrh20ofNETe4g8vfik8lsCB6GHNlrzCm6fFrTcuHRFZgYdiEi0pyhxr5Lm88N5XAPROXbo/euhRLDhCvUnluwGK9bSwf5F5mk7+/lOBo5I95DnEAGfuulqgjiZyBMeSkFiRBnnI7Apbt8oTD8tlXxZYMBtZrizxU6mxEAm+KM5bwri2vte2boQ1YpXMcVg4z3D5x1Au9xvuydSbUHNwOBN6ETGD/uZ1T8Y9uAoy5n+XZeQiVAqKWSiMUbM3h9or9bqXiTcxZRHPCTs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(82310400005)(356005)(186003)(47076005)(478600001)(40480700001)(26005)(1076003)(7696005)(36756003)(83380400001)(86362001)(16526019)(41300700001)(70586007)(8936002)(316002)(5660300002)(36860700001)(70206006)(81166007)(30864003)(6666004)(82740400003)(336012)(4326008)(8676002)(6916009)(426003)(2906002)(2616005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2023 15:18:42.0554 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33dd78ef-e3d5-485c-d1fe-08db2f9fb715
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000100D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <Le.Ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Instead of number of XCCs, keep a mask of XCCs for the exact XCCs
available on the ASIC. XCC configuration could differ based on
different ASIC configs.

v2:
	Rename num_xcd to num_xcc (Hawking)
	Use smaller xcc_mask size, changed to u16 (Le)

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <Le.Ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  |  21 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  |   4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c  | 133 +++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c |  67 +++++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  |  10 +-
 7 files changed, 141 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 77a42f73c3de..2a781d3dcc05 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -209,12 +209,12 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 	int max_queues_per_mec = min(adev->gfx.mec.num_pipe_per_mec *
 				     adev->gfx.mec.num_queue_per_pipe,
 				     adev->gfx.num_compute_rings);
-	int num_xcd = (adev->gfx.num_xcd > 1) ? adev->gfx.num_xcd : 1;
+	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
 
 	if (multipipe_policy) {
 		/* policy: make queues evenly cross all pipes on MEC1 only
 		 * for multiple xcc, just use the original policy for simplicity */
-		for (j = 0; j < num_xcd; j++) {
+		for (j = 0; j < num_xcc; j++) {
 			for (i = 0; i < max_queues_per_mec; i++) {
 				pipe = i % adev->gfx.mec.num_pipe_per_mec;
 				queue = (i / adev->gfx.mec.num_pipe_per_mec) %
@@ -226,13 +226,13 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 		}
 	} else {
 		/* policy: amdgpu owns all queues in the given pipe */
-		for (j = 0; j < num_xcd; j++) {
+		for (j = 0; j < num_xcc; j++) {
 			for (i = 0; i < max_queues_per_mec; ++i)
 				set_bit(i, adev->gfx.mec_bitmap[j].queue_bitmap);
 		}
 	}
 
-	for (j = 0; j < num_xcd; j++) {
+	for (j = 0; j < num_xcc; j++) {
 		dev_dbg(adev->dev, "mec queue bitmap weight=%d\n",
 			bitmap_weight(adev->gfx.mec_bitmap[j].queue_bitmap, AMDGPU_MAX_COMPUTE_QUEUES));
 	}
@@ -1129,23 +1129,24 @@ static ssize_t amdgpu_gfx_set_compute_partition(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	enum amdgpu_gfx_partition mode;
-	int ret;
+	int ret = 0, num_xcc;
 
-	if (adev->gfx.num_xcd % 2 != 0)
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	if (num_xcc % 2 != 0)
 		return -EINVAL;
 
 	if (!strncasecmp("SPX", buf, strlen("SPX"))) {
 		mode = AMDGPU_SPX_PARTITION_MODE;
 	} else if (!strncasecmp("DPX", buf, strlen("DPX"))) {
-		if (adev->gfx.num_xcd != 4 || adev->gfx.num_xcd != 8)
+		if (num_xcc != 4 || num_xcc != 8)
 			return -EINVAL;
 		mode = AMDGPU_DPX_PARTITION_MODE;
 	} else if (!strncasecmp("TPX", buf, strlen("TPX"))) {
-		if (adev->gfx.num_xcd != 6)
+		if (num_xcc != 6)
 			return -EINVAL;
 		mode = AMDGPU_TPX_PARTITION_MODE;
 	} else if (!strncasecmp("QPX", buf, strlen("QPX"))) {
-		if (adev->gfx.num_xcd != 8)
+		if (num_xcc != 8)
 			return -EINVAL;
 		mode = AMDGPU_QPX_PARTITION_MODE;
 	} else if (!strncasecmp("CPX", buf, strlen("CPX"))) {
@@ -1175,7 +1176,7 @@ static ssize_t amdgpu_gfx_get_available_compute_partition(struct device *dev,
 	char *supported_partition;
 
 	/* TBD */
-	switch (adev->gfx.num_xcd) {
+	switch (NUM_XCC(adev->gfx.xcc_mask)) {
 	case 8:
 		supported_partition = "SPX, DPX, QPX, CPX";
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 0cf3591c13b2..8741f8c30ce0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -64,6 +64,8 @@ enum amdgpu_gfx_partition {
 	AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE,
 };
 
+#define NUM_XCC(x) hweight16(x)
+
 struct amdgpu_mec {
 	struct amdgpu_bo	*hpd_eop_obj;
 	u64			hpd_eop_gpu_addr;
@@ -385,7 +387,7 @@ struct amdgpu_gfx {
 	struct amdgpu_ring_mux          muxer;
 
 	enum amdgpu_gfx_partition	partition_mode;
-	uint32_t			num_xcd;
+	uint16_t 			xcc_mask;
 	uint32_t			num_xcc_per_xcp;
 	struct mutex			partition_mutex;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 118b1592211a..032f9fbd1a23 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4503,7 +4503,7 @@ static int gfx_v9_0_early_init(void *handle)
 		adev->gfx.num_gfx_rings = 0;
 	else
 		adev->gfx.num_gfx_rings = GFX9_NUM_GFX_RINGS;
-	adev->gfx.num_xcd = 1;
+	adev->gfx.xcc_mask = 1;
 	adev->gfx.num_compute_rings = min(amdgpu_gfx_get_num_kcq(adev),
 					  AMDGPU_MAX_COMPUTE_RINGS);
 	gfx_v9_0_set_kiq_pm4_funcs(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index d103832630f3..d248c4f2e2c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -182,16 +182,19 @@ static const struct kiq_pm4_funcs gfx_v9_4_3_kiq_pm4_funcs = {
 
 static void gfx_v9_4_3_set_kiq_pm4_funcs(struct amdgpu_device *adev)
 {
-	int i;
-	for (i = 0; i < adev->gfx.num_xcd; i++)
+	int i, num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++)
 		adev->gfx.kiq[i].pmf = &gfx_v9_4_3_kiq_pm4_funcs;
 }
 
 static void gfx_v9_4_3_init_golden_registers(struct amdgpu_device *adev)
 {
-	int i;
+	int i, num_xcc;
 
-	for (i = 2; i < adev->gfx.num_xcd; i++)
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 2; i < num_xcc; i++)
 		WREG32_SOC15(GC, i, regGRBM_MCM_ADDR, 0x4);
 }
 
@@ -504,7 +507,7 @@ static void gfx_v9_4_3_mec_fini(struct amdgpu_device *adev)
 
 static int gfx_v9_4_3_mec_init(struct amdgpu_device *adev)
 {
-	int r, i;
+	int r, i, num_xcc;
 	u32 *hpd;
 	const __le32 *fw_data;
 	unsigned fw_size;
@@ -513,7 +516,8 @@ static int gfx_v9_4_3_mec_init(struct amdgpu_device *adev)
 
 	const struct gfx_firmware_header_v1_0 *mec_hdr;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++)
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++)
 		bitmap_zero(adev->gfx.mec_bitmap[i].queue_bitmap,
 			AMDGPU_MAX_COMPUTE_QUEUES);
 
@@ -688,23 +692,24 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 						enum amdgpu_gfx_partition mode)
 {
 	u32 tmp = 0;
-	int num_xcc_per_partition, i;
+	int num_xcc_per_partition, i, num_xcc;
 
 	if (mode == adev->gfx.partition_mode)
 		return mode;
 
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
-		num_xcc_per_partition = adev->gfx.num_xcd;
+		num_xcc_per_partition = num_xcc;
 		break;
 	case AMDGPU_DPX_PARTITION_MODE:
-		num_xcc_per_partition = adev->gfx.num_xcd / 2;
+		num_xcc_per_partition = num_xcc / 2;
 		break;
 	case AMDGPU_TPX_PARTITION_MODE:
-		num_xcc_per_partition = adev->gfx.num_xcd / 3;
+		num_xcc_per_partition = num_xcc / 3;
 		break;
 	case AMDGPU_QPX_PARTITION_MODE:
-		num_xcc_per_partition = adev->gfx.num_xcd / 4;
+		num_xcc_per_partition = num_xcc / 4;
 		break;
 	case AMDGPU_CPX_PARTITION_MODE:
 		num_xcc_per_partition = 1;
@@ -717,7 +722,7 @@ static int gfx_v9_4_3_switch_compute_partition(struct amdgpu_device *adev,
 	 * Stop user queues and threads, and make sure GPU is empty of work.
 	 */
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	for (i = 0; i < num_xcc; i++) {
 		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, NUM_XCC_IN_XCP,
 				    num_xcc_per_partition);
 		tmp = REG_SET_FIELD(tmp, CP_HYP_XCP_CTL, VIRTUAL_XCC_ID,
@@ -841,7 +846,7 @@ static int gfx_v9_4_3_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 
 static int gfx_v9_4_3_sw_init(void *handle)
 {
-	int i, j, k, r, ring_id, xcc_id;
+	int i, j, k, r, ring_id, xcc_id, num_xcc;
 	struct amdgpu_kiq *kiq;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
@@ -849,6 +854,8 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	adev->gfx.mec.num_pipe_per_mec = 4;
 	adev->gfx.mec.num_queue_per_pipe = 8;
 
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+
 	/* EOP Event */
 	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_GRBM_CP, GFX_9_0__SRCID__CP_EOP_INTERRUPT, &adev->gfx.eop_irq);
 	if (r)
@@ -882,8 +889,7 @@ static int gfx_v9_4_3_sw_init(void *handle)
 
 	/* set up the compute queues - allocate horizontally across pipes */
 	ring_id = 0;
-	for (xcc_id = 0; xcc_id < adev->gfx.num_xcd; xcc_id++) {
-
+	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
 		for (i = 0; i < adev->gfx.mec.num_mec; ++i) {
 			for (j = 0; j < adev->gfx.mec.num_queue_per_pipe; j++) {
 				for (k = 0; k < adev->gfx.mec.num_pipe_per_mec;
@@ -935,14 +941,14 @@ static int gfx_v9_4_3_sw_init(void *handle)
 
 static int gfx_v9_4_3_sw_fini(void *handle)
 {
-	int i;
+	int i, num_xcc;
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	for (i = 0; i < adev->gfx.num_compute_rings *
-		adev->gfx.num_xcd; i++)
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < adev->gfx.num_compute_rings * num_xcc; i++)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	for (i = 0; i < num_xcc; i++) {
 		amdgpu_gfx_mqd_sw_fini(adev, i);
 		amdgpu_gfx_kiq_free_ring(&adev->gfx.kiq[i].ring);
 		amdgpu_gfx_kiq_fini(adev, i);
@@ -1055,9 +1061,10 @@ static void gfx_v9_4_3_init_gds_vmid(struct amdgpu_device *adev, int xcc_id)
 static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 {
 	u32 tmp;
-	int i, j;
+	int i, j, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		WREG32_FIELD15_PREREG(GC, i, GRBM_CNTL, READ_TIMEOUT, 0xff);
 		gfx_v9_4_3_setup_rb(adev, i);
 	}
@@ -1069,7 +1076,7 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
 	mutex_lock(&adev->srbm_mutex);
 	for (i = 0; i < adev->vm_manager.id_mgr[AMDGPU_GFXHUB(0)].num_ids; i++) {
-		for (j = 0; j < adev->gfx.num_xcd; j++) {
+		for (j = 0; j < num_xcc; j++) {
 			soc15_grbm_select(adev, 0, 0, 0, i, j);
 			/* CP and shaders */
 			if (i == 0) {
@@ -1097,7 +1104,7 @@ static void gfx_v9_4_3_constants_init(struct amdgpu_device *adev)
 
 	mutex_unlock(&adev->srbm_mutex);
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	for (i = 0; i < num_xcc; i++) {
 		gfx_v9_4_3_init_compute_vmid(adev, i);
 		gfx_v9_4_3_init_gds_vmid(adev, i);
 	}
@@ -1155,8 +1162,10 @@ void gfx_v9_4_3_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id)
 static void gfx_v9_4_3_program_xcc_id(struct amdgpu_device *adev, int xcc_id)
 {
 	uint32_t tmp = 0;
+	int num_xcc;
 
-	switch (adev->gfx.num_xcd) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	switch (num_xcc) {
 	/* directly config VIRTUAL_XCC_ID to 0 for 1-XCC */
 	case 1:
 		WREG32_SOC15(GC, xcc_id, regCP_HYP_XCP_CTL, 0x8);
@@ -1293,9 +1302,10 @@ static void gfx_v9_4_3_enable_gui_idle_interrupt(struct amdgpu_device *adev,
 
 static void gfx_v9_4_3_rlc_stop(struct amdgpu_device *adev)
 {
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		WREG32_FIELD15_PREREG(GC, i, RLC_CNTL, RLC_ENABLE_F32, 0);
 		gfx_v9_4_3_enable_gui_idle_interrupt(adev, false, i);
 		gfx_v9_4_3_wait_for_rlc_serdes(adev, i);
@@ -1304,9 +1314,10 @@ static void gfx_v9_4_3_rlc_stop(struct amdgpu_device *adev)
 
 static void gfx_v9_4_3_rlc_reset(struct amdgpu_device *adev)
 {
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		WREG32_FIELD15_PREREG(GC, i, GRBM_SOFT_RESET, SOFT_RESET_RLC, 1);
 		udelay(50);
 		WREG32_FIELD15_PREREG(GC, i, GRBM_SOFT_RESET, SOFT_RESET_RLC, 0);
@@ -1319,9 +1330,10 @@ static void gfx_v9_4_3_rlc_start(struct amdgpu_device *adev)
 #ifdef AMDGPU_RLC_DEBUG_RETRY
 	u32 rlc_ucode_ver;
 #endif
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		WREG32_FIELD15_PREREG(GC, i, RLC_CNTL, RLC_ENABLE_F32, 1);
 		udelay(50);
 
@@ -1382,11 +1394,12 @@ static int gfx_v9_4_3_rlc_load_microcode(struct amdgpu_device *adev, int xcc_id)
 
 static int gfx_v9_4_3_rlc_resume(struct amdgpu_device *adev)
 {
-	int r, i;
+	int r, i, num_xcc;
 
 	adev->gfx.rlc.funcs->stop(adev);
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		/* disable CG */
 		WREG32_SOC15(GC, i, regRLC_CGCG_CGLS_CTRL, 0);
 
@@ -1960,10 +1973,11 @@ static int gfx_v9_4_3_kcq_resume(struct amdgpu_device *adev, int xcc_id)
 
 static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 {
-	int r, i, j;
+	int r, i, j, num_xcc;
 	struct amdgpu_ring *ring;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		gfx_v9_4_3_enable_gui_idle_interrupt(adev, false, i);
 
 		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
@@ -2027,12 +2041,13 @@ static int gfx_v9_4_3_hw_init(void *handle)
 static int gfx_v9_4_3_hw_fini(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int i;
+	int i, num_xcc;
 
 	amdgpu_irq_put(adev, &adev->gfx.priv_reg_irq, 0);
 	amdgpu_irq_put(adev, &adev->gfx.priv_inst_irq, 0);
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		if (amdgpu_gfx_disable_kcq(adev, i))
 			DRM_ERROR("XCD %d KCQ disable failed\n", i);
 
@@ -2075,9 +2090,10 @@ static int gfx_v9_4_3_resume(void *handle)
 static bool gfx_v9_4_3_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		if (REG_GET_FIELD(RREG32_SOC15(GC, i, regGRBM_STATUS),
 					GRBM_STATUS, GUI_ACTIVE))
 			return false;
@@ -2189,30 +2205,30 @@ static void gfx_v9_4_3_ring_emit_gds_switch(struct amdgpu_ring *ring,
 static int gfx_v9_4_3_early_init(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int num_xcc;
 
-	/* hardcode in emulation phase */
-	adev->gfx.num_xcd = 1;
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
 	adev->gfx.partition_mode = amdgpu_user_partt_mode;
 	/* calculate the num_xcc_in_xcp for the partition mode*/
 	switch (amdgpu_user_partt_mode) {
 	case AMDGPU_SPX_PARTITION_MODE:
-		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd;
+		adev->gfx.num_xcc_per_xcp = num_xcc;
 		break;
 	case AMDGPU_DPX_PARTITION_MODE:
-		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd / 2;
+		adev->gfx.num_xcc_per_xcp = num_xcc / 2;
 		break;
 	case AMDGPU_TPX_PARTITION_MODE:
-		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd / 3;
+		adev->gfx.num_xcc_per_xcp = num_xcc / 3;
 		break;
 	case AMDGPU_QPX_PARTITION_MODE:
-		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd / 4;
+		adev->gfx.num_xcc_per_xcp = num_xcc / 4;
 		break;
 	case AMDGPU_CPX_PARTITION_MODE:
 		adev->gfx.num_xcc_per_xcp = 1;
 		break;
 	default:
-		adev->gfx.num_xcc_per_xcp = adev->gfx.num_xcd;
+		adev->gfx.num_xcc_per_xcp = num_xcc;
 		break;
 	}
 
@@ -2410,14 +2426,15 @@ static int gfx_v9_4_3_set_clockgating_state(void *handle,
 					  enum amd_clockgating_state state)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	int i;
+	int i, num_xcc;
 
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (adev->ip_versions[GC_HWIP][0]) {
 	case IP_VERSION(9, 4, 3):
-		for (i = 0; i < adev->gfx.num_xcd; i++)
+		for (i = 0; i < num_xcc; i++)
 			gfx_v9_4_3_update_gfx_clock_gating(adev,
 						state == AMD_CG_STATE_GATE, i);
 		break;
@@ -2745,12 +2762,13 @@ static int gfx_v9_4_3_set_priv_reg_fault_state(struct amdgpu_device *adev,
 					     unsigned type,
 					     enum amdgpu_interrupt_state state)
 {
-	int i;
+	int i, num_xcc;
 
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		for (i = 0; i < adev->gfx.num_xcd; i++)
+		for (i = 0; i < num_xcc; i++)
 			WREG32_FIELD15_PREREG(GC, i, CP_INT_CNTL_RING0,
 				PRIV_REG_INT_ENABLE,
 				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
@@ -2767,12 +2785,13 @@ static int gfx_v9_4_3_set_priv_inst_fault_state(struct amdgpu_device *adev,
 					      unsigned type,
 					      enum amdgpu_interrupt_state state)
 {
-	int i;
+	int i, num_xcc;
 
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
-		for (i = 0; i < adev->gfx.num_xcd; i++)
+		for (i = 0; i < num_xcc; i++)
 			WREG32_FIELD15_PREREG(GC, i, CP_INT_CNTL_RING0,
 				PRIV_INSTR_INT_ENABLE,
 				state == AMDGPU_IRQ_STATE_ENABLE ? 1 : 0);
@@ -2789,8 +2808,10 @@ static int gfx_v9_4_3_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    unsigned type,
 					    enum amdgpu_interrupt_state state)
 {
-	int i;
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	int i, num_xcc;
+
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		switch (type) {
 		case AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP:
 			gfx_v9_4_3_set_compute_eop_interrupt_state(adev, 1, 0, state, i);
@@ -2848,6 +2869,7 @@ static int gfx_v9_4_3_eop_irq(struct amdgpu_device *adev,
 			/* Per-queue interrupt is supported for MEC starting from VI.
 			  * The interrupt can only be enabled/disabled per pipe instead of per queue.
 			  */
+
 			if ((ring->me == me_id) && (ring->pipe == pipe_id) && (ring->queue == queue_id))
 				amdgpu_fence_process(ring);
 		}
@@ -3062,9 +3084,10 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ring_funcs_kiq = {
 
 static void gfx_v9_4_3_set_ring_funcs(struct amdgpu_device *adev)
 {
-	int i, j;
+	int i, j, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		adev->gfx.kiq[i].ring.funcs = &gfx_v9_4_3_ring_funcs_kiq;
 
 		for (j = 0; j < adev->gfx.num_compute_rings; j++)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 1bb17d95f720..e35365ab3f1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -43,9 +43,10 @@ static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
 					 uint64_t page_table_base)
 {
 	struct amdgpu_vmhub *hub;
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 		WREG32_SOC15_OFFSET(GC, i,
 				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_LO32,
@@ -56,13 +57,14 @@ static void gfxhub_v1_2_setup_vm_pt_regs(struct amdgpu_device *adev,
 				    regVM_CONTEXT0_PAGE_TABLE_BASE_ADDR_HI32,
 				    hub->ctx_addr_distance * vmid,
 				    upper_32_bits(page_table_base));
+
 	}
 }
 
 static void gfxhub_v1_2_init_gart_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t pt_base;
-	int i;
+	int i, num_xcc;
 
 	if (adev->gmc.pdb0_bo)
 		pt_base = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo);
@@ -74,7 +76,8 @@ static void gfxhub_v1_2_init_gart_aperture_regs(struct amdgpu_device *adev)
 	/* If use GART for FB translation, vmid0 page table covers both
 	 * vram and system memory (gart)
 	 */
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		if (adev->gmc.pdb0_bo) {
 			WREG32_SOC15(GC, i,
 				     regVM_CONTEXT0_PAGE_TABLE_START_ADDR_LO32,
@@ -111,9 +114,10 @@ static void gfxhub_v1_2_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
 	uint32_t tmp;
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		/* Program the AGP BAR */
 		WREG32_SOC15_RLC(GC, i, regMC_VM_AGP_BASE, 0);
 		WREG32_SOC15_RLC(GC, i, regMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
@@ -177,9 +181,10 @@ static void gfxhub_v1_2_init_system_aperture_regs(struct amdgpu_device *adev)
 static void gfxhub_v1_2_init_tlb_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		/* Setup TLB control */
 		tmp = RREG32_SOC15(GC, i, regMC_VM_MX_L1_TLB_CNTL);
 
@@ -202,9 +207,10 @@ static void gfxhub_v1_2_init_tlb_regs(struct amdgpu_device *adev)
 static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		/* Setup L2 cache */
 		tmp = RREG32_SOC15(GC, i, regVM_L2_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 1);
@@ -249,9 +255,10 @@ static void gfxhub_v1_2_init_cache_regs(struct amdgpu_device *adev)
 static void gfxhub_v1_2_enable_system_domain(struct amdgpu_device *adev)
 {
 	uint32_t tmp;
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		tmp = RREG32_SOC15(GC, i, regVM_CONTEXT0_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, ENABLE_CONTEXT, 1);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT0_CNTL, PAGE_TABLE_DEPTH,
@@ -266,9 +273,10 @@ static void gfxhub_v1_2_enable_system_domain(struct amdgpu_device *adev)
 
 static void gfxhub_v1_2_disable_identity_aperture(struct amdgpu_device *adev)
 {
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		WREG32_SOC15(GC, i,
 			     regVM_L2_CONTEXT1_IDENTITY_APERTURE_LOW_ADDR_LO32,
 			     0XFFFFFFFF);
@@ -295,7 +303,7 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 	struct amdgpu_vmhub *hub;
 	unsigned num_level, block_size;
 	uint32_t tmp;
-	int i, j;
+	int i, j, num_xcc;
 
 	num_level = adev->vm_manager.num_level;
 	block_size = adev->vm_manager.block_size;
@@ -304,7 +312,8 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 	else
 		block_size -= 9;
 
-	for (j = 0; j < adev->gfx.num_xcd; j++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (j = 0; j < num_xcc; j++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		for (i = 0; i <= 14; i++) {
 			tmp = RREG32_SOC15_OFFSET(GC, j, regVM_CONTEXT1_CNTL, i);
@@ -362,10 +371,12 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 static void gfxhub_v1_2_program_invalidation(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
-	unsigned i, j;
+	unsigned i, j, num_xcc;
 
-	for (j = 0; j < adev->gfx.num_xcd; j++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (j = 0; j < num_xcc; j++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
+
 		for (i = 0 ; i < 18; ++i) {
 			WREG32_SOC15_OFFSET(GC, j, regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
 					    i * hub->eng_addr_distance, 0xffffffff);
@@ -377,9 +388,10 @@ static void gfxhub_v1_2_program_invalidation(struct amdgpu_device *adev)
 
 static int gfxhub_v1_2_gart_enable(struct amdgpu_device *adev)
 {
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		if (amdgpu_sriov_vf(adev)) {
 		/*
 		 * MC_VM_FB_LOCATION_BASE/TOP is NULL for VF, becuase they are
@@ -413,9 +425,10 @@ static void gfxhub_v1_2_gart_disable(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
 	u32 tmp;
-	u32 i, j;
+	u32 i, j, num_xcc;
 
-	for (j = 0; j < adev->gfx.num_xcd; j++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (j = 0; j < num_xcc; j++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(j)];
 		/* Disable all tables */
 		for (i = 0; i < 16; i++)
@@ -449,9 +462,10 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 						 bool value)
 {
 	u32 tmp;
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		tmp = RREG32_SOC15(GC, i, regVM_L2_PROTECTION_FAULT_CNTL);
 		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL,
 				RANGE_PROTECTION_FAULT_ENABLE_DEFAULT, value);
@@ -490,9 +504,10 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 static void gfxhub_v1_2_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
-	int i;
+	int i, num_xcc;
 
-	for (i = 0; i < adev->gfx.num_xcd; i++) {
+	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
+	for (i = 0; i < num_xcc; i++) {
 		hub = &adev->vmhub[AMDGPU_GFXHUB(i)];
 
 		hub->ctx0_ptb_addr_lo32 =
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 7d2d1d4a6e38..bf19f17c18e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1716,7 +1716,8 @@ static int gmc_v9_0_sw_init(void *handle)
 		adev->gmc.translate_further = adev->vm_manager.num_level > 1;
 		break;
 	case IP_VERSION(9, 4, 3):
-		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0), adev->gfx.num_xcd);
+		bitmap_set(adev->vmhubs_mask, AMDGPU_GFXHUB(0),
+				  NUM_XCC(adev->gfx.xcc_mask));
 		bitmap_set(adev->vmhubs_mask, AMDGPU_MMHUB0(0), adev->num_aid);
 
 		amdgpu_vm_adjust_size(adev, 256 * 1024, 9, 3, 48);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 1b4f3d34731b..1a482f0855d2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -584,6 +584,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 	struct kfd_node *node;
 	uint32_t first_vmid_kfd, last_vmid_kfd, vmid_num_kfd;
 	unsigned int max_proc_per_quantum;
+	int num_xcd;
 
 	kfd->mec_fw_version = amdgpu_amdkfd_get_fw_version(kfd->adev,
 			KGD_ENGINE_MEC1);
@@ -593,16 +594,15 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			KGD_ENGINE_SDMA1);
 	kfd->shared_resources = *gpu_resources;
 
-	if (kfd->adev->gfx.num_xcd == 0 || kfd->adev->gfx.num_xcd == 1 ||
-	    kfd->adev->gfx.num_xcc_per_xcp == 0)
+	num_xcd = NUM_XCC(kfd->adev->gfx.xcc_mask);
+	if (num_xcd == 0 || num_xcd == 1 || kfd->adev->gfx.num_xcc_per_xcp == 0)
 		kfd->num_nodes = 1;
 	else
-		kfd->num_nodes =
-			kfd->adev->gfx.num_xcd/kfd->adev->gfx.num_xcc_per_xcp;
+		kfd->num_nodes = num_xcd / kfd->adev->gfx.num_xcc_per_xcp;
 	if (kfd->num_nodes == 0) {
 		dev_err(kfd_device,
 			"KFD num nodes cannot be 0, GC inst: %d, num_xcc_in_node: %d\n",
-			kfd->adev->gfx.num_xcd, kfd->adev->gfx.num_xcc_per_xcp);
+			num_xcd, kfd->adev->gfx.num_xcc_per_xcp);
 		goto out;
 	}
 
-- 
2.39.2

