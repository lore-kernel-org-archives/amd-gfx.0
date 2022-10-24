Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8828ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Oct 2022 11:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD25E10E3BE;
	Mon, 24 Oct 2022 11:27:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74C6710E3BE
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Oct 2022 11:27:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAQQgtLekTDnCE0ZE5vBGShn8t1yJLdrtZJsH7VJx3Wrpkl2xgq50a6VKDef99Q4aITrB4Vz7Iyhw1cJg5CxQfc6/m+GMiWsBLmfj2i1ZctktJExtuCAVtC+TjLQwD90kLBZMbpqA5AwhOWqGLvir0mhvECpgHLlylqs33BxBouepSm1ArBHF7CPoj5dJlZInF8E2PgbaTST2qw8ywJAo+oOF43BV/TixIp4YtqGnDxy5P07APWQLbaqIgp59J+e/OVs0hEcGnBpxydfedHzilScuvGHQMCiGPGzl/zG1P9di5keAijWXEIKWegEcECkZnv/71tJAKpzbeypdmoV/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fkwHOyVV1ficPTEVW1ebpWVhWeTndbHFvZpDxq2hbS0=;
 b=NB8R7Q+5bV3ZCr5C4QFqjgtBiMsq3TLnxOFjWGzPb2gFkzMYnM1tcCptRg56Y0NbUxu36yl03NUn/1hOCyjEKqhbervKMlYpHq2gCXSQmATchxZMogcH3aGRGaTUeuMMKiTWYUdZ9SCrMyPB/klN6iFtdYo+DlKycwWWqaYgQI0JgyyqTzgo1Xr9z2gb8Odusg/PeCXnCRvIhDB+1iiOv9DckahWCP5wU5s75LErSeFve7rQI6SFSISeikA7iTdNEPbh4QO0I61AjxeLFcAWLpN+BNE3GcjQ2KlTbnAnrvbAzGiLeyPMLChfqcsRfyjL9tA6TJyLKGUJ4vP1D7FodA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fkwHOyVV1ficPTEVW1ebpWVhWeTndbHFvZpDxq2hbS0=;
 b=Ko4bZKl04qkOzCe5pP8eeHtbVjL85lB8G5StjixTCSrfs5gkM0e7DVKKVD/upGp644pXxhxhMPgtuKD7EJO9Nkol/DgT31+zOZsCd4EXYsXRgVO8s+DCLPUfzZ4kwx7W/TK56RrU07XwuH5IDIPS54NnvnElOIIajerBZkWWDj8=
Received: from MN2PR18CA0030.namprd18.prod.outlook.com (2603:10b6:208:23c::35)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Mon, 24 Oct
 2022 11:27:13 +0000
Received: from BL02EPF0000C405.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::e7) by MN2PR18CA0030.outlook.office365.com
 (2603:10b6:208:23c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23 via Frontend
 Transport; Mon, 24 Oct 2022 11:27:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0000C405.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Mon, 24 Oct 2022 11:27:12 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 06:27:11 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdkfd: Init the base cu processor id
Date: Mon, 24 Oct 2022 19:26:38 +0800
Message-ID: <20221024112639.3440664-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0000C405:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: 64413115-1fc6-4bf5-ed82-08dab5b2b26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SmIUKcK6wLBrxXhm51EUedtHr3+8NjpcLu5nQSzCXB0MKPNlqiXoymm2cywMRBGXMC3e9otpX5u1WG8poS2UrxfK6lcmRf5vh+wOfS/emAs4dZ9cS6SYmwK4pc7z5IfU3Rsrn4ruD3ioO48HfuwhIKypAgCsIgD2LA4XImyTl40RkKzO2qzkQ/jOn2iUMjhSh4E2MRhqeuennVofVrjY8gAxojhfrhbiA9nguRoLs/x1+mIguCyDYO2E4ofa0KGGW2eEPpDtE/1U/yVABrE2rvrT49EhvFHwjpEs61ftfwuNy+8Kw2cZPj6duJNwspgzWkGnkLT8PcMF0CCJ09ONFk3s+UJPeDHYR93KJlAYJCKl965VsYGrONn3S+VrvrgTSqbC+AEgSU0odcVeJyTNpCvnJxn8xC3+GJ/Vv90+v9qDmxNRo0IYyZqNxVBks80A2Xeo3m944fNQqWKean85w1rNJLa1umJA1UL4UQWamDZXss0jLzM/MaX0UH7C6VQQ+Bcc4e7HsQXO7RKoX4V6ZvocFvi+s9m92d59T70DijKDa1GZ/TaoyVq1+qiS3ctAJ0WHbZ0Y+ENknSfqlBjg7kMfWWF8UMy51mMceCISxbCHXeRMVzzvfj1vchmfhjlmSGTBC1lO4T6UKaC0iel0Kvx5SI7EtgpdFiznYelOWcEmg20Pk/fKehc7NAnAY5o26l915UdXNwOwIN5YKo00NsXkLRjMMFyfdgciI7PzDF0LdpGxxWIKwIG8tTuUNG9Y/CXqPimshHq2E7cVyaonOE5kBahFOgX7iHwKG+QaHUK5EGlvVTQLAJVm1jI90DhQ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(346002)(396003)(39860400002)(376002)(451199015)(46966006)(36840700001)(40470700004)(8676002)(41300700001)(5660300002)(82740400003)(8936002)(4326008)(1076003)(82310400005)(26005)(426003)(36756003)(70586007)(478600001)(70206006)(16526019)(336012)(2616005)(7696005)(6666004)(47076005)(86362001)(40480700001)(186003)(81166007)(2906002)(36860700001)(316002)(110136005)(83380400001)(6636002)(40460700003)(356005)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2022 11:27:12.8323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64413115-1fc6-4bf5-ed82-08dab5b2b26c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0000C405.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Init and save the base cu processor id for later use

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c   | 24 +--------------------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c | 28 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h   |  3 +++
 3 files changed, 32 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index d25ac9cbe5b2..4857ec5b9f46 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -30,26 +30,6 @@
 #include "amdgpu.h"
 #include "amdgpu_amdkfd.h"
 
-/* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
- * GPU processor ID are expressed with Bit[31]=1.
- * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GPU IDs
- * used in the CRAT.
- */
-static uint32_t gpu_processor_id_low = 0x80001000;
-
-/* Return the next available gpu_processor_id and increment it for next GPU
- *	@total_cu_count - Total CUs present in the GPU including ones
- *			  masked off
- */
-static inline unsigned int get_and_inc_gpu_processor_id(
-				unsigned int total_cu_count)
-{
-	int current_id = gpu_processor_id_low;
-
-	gpu_processor_id_low += total_cu_count;
-	return current_id;
-}
-
 /* Static table to describe GPU Cache information */
 struct kfd_gpu_cache_info {
 	uint32_t	cache_size;
@@ -2223,7 +2203,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	struct crat_subtype_computeunit *cu;
 	struct kfd_cu_info cu_info;
 	int avail_size = *size;
-	uint32_t total_num_of_cu;
 	int num_of_cache_entries = 0;
 	int cache_mem_filled = 0;
 	uint32_t nid = 0;
@@ -2275,8 +2254,7 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	cu->wave_front_size = cu_info.wave_front_size;
 	cu->array_count = cu_info.num_shader_arrays_per_engine *
 		cu_info.num_shader_engines;
-	total_num_of_cu = (cu->array_count * cu_info.num_cu_per_sh);
-	cu->processor_id_low = get_and_inc_gpu_processor_id(total_num_of_cu);
+	cu->processor_id_low = kdev->processor_id_low;
 	cu->num_cu_per_array = cu_info.num_cu_per_sh;
 	cu->max_slots_scatch_cu = cu_info.max_scratch_slots_per_cu;
 	cu->num_banks = cu_info.num_shader_engines;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index ae1f0be3f3a1..099df4598a42 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -38,6 +38,32 @@
 
 #define MQD_SIZE_ALIGNED 768
 
+/* GPU Processor ID base for dGPUs for which VCRAT needs to be created.
+ * GPU processor ID are expressed with Bit[31]=1.
+ * The base is set to 0x8000_0000 + 0x1000 to avoid collision with GPU IDs
+ * used in the CRAT.
+ */
+static uint32_t gpu_processor_id_low = 0x80001000;
+
+/* Return the next available gpu_processor_id and increment it for next GPU
+ *	@total_cu_count - Total CUs present in the GPU including ones
+ *			  masked off
+ */
+static inline unsigned int get_and_inc_gpu_processor_id(struct kfd_dev *kfd)
+{
+	struct amdgpu_device *adev = kfd->adev;
+	unsigned int array_count = 0;
+	unsigned int total_cu_count = 0;
+
+	kfd->processor_id_low = gpu_processor_id_low;
+
+	array_count = adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
+	total_cu_count = array_count * adev->gfx.config.max_cu_per_sh;
+
+	gpu_processor_id_low += total_cu_count;
+	return 0;
+}
+
 /*
  * kfd_locked is used to lock the kfd driver during suspend or reset
  * once locked, kfd driver will stop any further GPU execution.
@@ -656,6 +682,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 
 	amdgpu_amdkfd_get_local_mem_info(kfd->adev, &kfd->local_mem_info);
 
+	get_and_inc_gpu_processor_id(kfd);
+
 	if (kfd_topology_add_device(kfd)) {
 		dev_err(kfd_device, "Error adding device to topology\n");
 		goto kfd_topology_add_device_error;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 182eb67edbc5..4c06b233472f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -370,6 +370,9 @@ struct kfd_dev {
 
 	/* Track per device allocated watch points. */
 	uint32_t alloc_watch_ids;
+
+	/* cu processor id base */
+	unsigned int	processor_id_low;
 };
 
 struct kfd_ipc_obj;
-- 
2.25.1

