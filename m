Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F076EE14A5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 15:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8622B10E6A4;
	Wed,  6 Sep 2023 15:47:57 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 871E710E6A4
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 15:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z84no8WUl14y73NHRjxiWN/k33n8HIxIMcmxzA3goumh7iQxbv4bVmOXeUvl+RqbeX+pMltgwpBUQLowPKPj9Chn99Iui8ILV/XkInfMWfT1zxZd1KwiVp1XhpE+t82HULmu5Z6KKSm4nXNmUe21LkgR2k+CvBV7ztRs693uxk9ytaAsT1skt6JDJIOGNGxaCTSbr/DqIl1Ju2CBx1gD9xfQjM34ZddxH6rZC9ww4+MydEqaqlUOJQa6BoJPQcGGYh+lFATx561azXWZYMH2l0kfx8DQcsFypeWynZnSOrXERPKhzeWqpn5sWGnVqeQ2KdqAAJNBxq16cfiYhF0eMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCEzyxfgfzVYsfV170ZCgzIdmw9zedNw6k7h93Mt0Ow=;
 b=O05msPcGsmZUdGxz+IAR7uh8/kLgHatGfubgqRYPAXZPShCJDlCKj6bVA0DwnY8gn+00PvGhJI/LS5EVHYINhm9tBD89ZvIUhzimGP0aE98XENiZS7Ob/LavpimPJEb5uZTpeJ9S+QzKwhowqRXIyrG2MO/aqd9+lBZ3bcfWUkEuUD0sF/Yv3nD76bcu0Ed1MS+MYH8JfFihw/K8uu8zYwyMx6sKEjZPPhy6zZ4fmPONoqPoQ8tk8lItuMb81HRjRlsG5gp2kJqENqOKWsGSz0xMYGV5oGAbdgrTbrEe0nXGduwZF2/NHoBtNEldsr6F7zlhkSoF4wF63z3tcUd4wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCEzyxfgfzVYsfV170ZCgzIdmw9zedNw6k7h93Mt0Ow=;
 b=KddpjZZX0KAzP9sj6g3PTI1+1QvKmRDUEb07SQp1e4i6UJXrNVeJLlRUpf8ISInFLHn0NEbeNHESDrngiIvtPU5EvSC0pFMh4gEVHuP1cY7MlHHLvRwvkTEKyJsvPWEE7B2MOJRN88EQkkCz8PwC/juFwTl7n6ueUEd/Vvbw42Y=
Received: from DS7PR05CA0015.namprd05.prod.outlook.com (2603:10b6:5:3b9::20)
 by DS0PR12MB8272.namprd12.prod.outlook.com (2603:10b6:8:fc::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.34; Wed, 6 Sep 2023 15:47:40 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::f1) by DS7PR05CA0015.outlook.office365.com
 (2603:10b6:5:3b9::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25 via Frontend
 Transport; Wed, 6 Sep 2023 15:47:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:47:40 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 10:47:38 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu: Rename KGD_MAX_QUEUES to AMDGPU_MAX_QUEUES
Date: Wed, 6 Sep 2023 11:44:29 -0400
Message-ID: <20230906154429.216489-4-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230906154429.216489-1-mukul.joshi@amd.com>
References: <20230906154429.216489-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DS0PR12MB8272:EE_
X-MS-Office365-Filtering-Correlation-Id: cb7b969e-6f4e-4df9-f1fa-08dbaef09a35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AqASKidcDVm4AnfKQye15Yn9YuOQp3xRlhdXRela4S+/m4x64mH2BsOXwa4UzjsFpWAWY7cOFPljtZNGBEkFQIMJkx+VhLdkUUDsEaNmmj7gr6znqymqJElZwu53Ve6nnZfbzIWQF6ljk5hjMtoijUOqoAKq40QdHKRqUzEEWZmZPmBUglAIinYuKfznbhvRxkZzJs2xq5/PncCI8RaRitn33PEaRAxRIsZ+RORDAT2lEemZWyhqTEmQ3GiDSYD+0gc9GCxfCFKV0up3DYCwFStMOUyPaHrgFCCiFbkr1EwvIDTD+ZefKrKpB7n2m19RKfHiq3jaSZ2eiiicUtaOmgLgm1sLvYn0Vp4jYB7a4moVTvx4cruw/448jV8Y85KmQLvwz5LVE8kcpOwF/GKA4tt/9wA+yFat4V/yWnKTS3bR5WGmv3Cjp7esMVskB1OnsDoU77CHotQT1uNMKQOkhoTTVgvoIlBb4o0puyQlW8IEUW+6xvI2/u1FPvwweJbwMbBXQQ2JiRA8gR6Wr4sN68nB5uXFvCevj/b8K2vMZAS0j5gsDiYbxNkAWXN/qxbLecp5eAVVU97r5eIjD3bZTa9hD4RApwOOFyh2HprGrsPLdFkKhZwBuNUuvARofW/9WQRqq4biMrROKbzt7t/o0BJi54zuVyfCYQJCzVIXXncWpRl/KN6IEiQeBV1C2QtEjODAc2enw7m6HTIFfVH6wJRcxl5Vu8uCSmdeidDd/YOTp/4izGzzKzuSUPGM2MY214H4p1k61e5XxvPM6RTmvw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(1800799009)(82310400011)(186009)(451199024)(40470700004)(36840700001)(46966006)(36860700001)(40480700001)(86362001)(36756003)(82740400003)(40460700003)(81166007)(356005)(478600001)(2906002)(7696005)(6666004)(8676002)(8936002)(4326008)(44832011)(5660300002)(41300700001)(54906003)(6916009)(316002)(47076005)(70586007)(83380400001)(70206006)(1076003)(16526019)(26005)(426003)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:47:40.4730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb7b969e-6f4e-4df9-f1fa-08dbaef09a35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8272
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rename KGD_MAX_QUEUES to AMDGPU_MAX_QUEUES to conform with
the naming convention followed in amdgpu_gfx.h. No functional
change.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c            | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c     | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h               | 6 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 4 ++--
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h       | 2 +-
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 25d5fda5b243..26ff5f8d9795 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -164,7 +164,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 		 */
 		bitmap_complement(gpu_resources.cp_queue_bitmap,
 				  adev->gfx.mec_bitmap[0].queue_bitmap,
-				  KGD_MAX_QUEUES);
+				  AMDGPU_MAX_QUEUES);
 
 		/* According to linux/bitmap.h we shouldn't use bitmap_clear if
 		 * nbits is not compile time constant
@@ -172,7 +172,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 		last_valid_bit = 1 /* only first MEC can have compute queues */
 				* adev->gfx.mec.num_pipe_per_mec
 				* adev->gfx.mec.num_queue_per_pipe;
-		for (i = last_valid_bit; i < KGD_MAX_QUEUES; ++i)
+		for (i = last_valid_bit; i < AMDGPU_MAX_QUEUES; ++i)
 			clear_bit(i, gpu_resources.cp_queue_bitmap);
 
 		amdgpu_doorbell_get_kfd_info(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index 3c45a188b701..04b8c7dacd30 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -1037,7 +1037,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	int pasid_tmp;
 	int max_queue_cnt;
 	int vmid_wave_cnt = 0;
-	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
+	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
 
 	lock_spi_csq_mutexes(adev);
 	soc15_grbm_select(adev, 1, 0, 0, 0, inst);
@@ -1047,7 +1047,7 @@ void kgd_gfx_v9_get_cu_occupancy(struct amdgpu_device *adev, int pasid,
 	 * to get number of waves in flight
 	 */
 	bitmap_complement(cp_queue_bitmap, adev->gfx.mec_bitmap[0].queue_bitmap,
-			  KGD_MAX_QUEUES);
+			  AMDGPU_MAX_QUEUES);
 	max_queue_cnt = adev->gfx.mec.num_pipe_per_mec *
 			adev->gfx.mec.num_queue_per_pipe;
 	sh_cnt = adev->gfx.config.max_sh_per_se;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 0ca95c4d4bfb..42ac6d1bf9ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -43,10 +43,10 @@
 #define AMDGPU_GFX_LBPW_DISABLED_MODE		0x00000008L
 
 #define AMDGPU_MAX_GC_INSTANCES		8
-#define KGD_MAX_QUEUES			128
+#define AMDGPU_MAX_QUEUES		128
 
-#define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
-#define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
+#define AMDGPU_MAX_GFX_QUEUES AMDGPU_MAX_QUEUES
+#define AMDGPU_MAX_COMPUTE_QUEUES AMDGPU_MAX_QUEUES
 
 enum amdgpu_gfx_pipe_priority {
 	AMDGPU_GFX_PIPE_PRIO_NORMAL = AMDGPU_RING_PRIO_1,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 4170e3d32630..6d07a5dd2648 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -92,7 +92,7 @@ static bool is_pipe_enabled(struct device_queue_manager *dqm, int mec, int pipe)
 unsigned int get_cp_queues_num(struct device_queue_manager *dqm)
 {
 	return bitmap_weight(dqm->dev->kfd->shared_resources.cp_queue_bitmap,
-				KGD_MAX_QUEUES);
+				AMDGPU_MAX_QUEUES);
 }
 
 unsigned int get_queues_per_pipe(struct device_queue_manager *dqm)
@@ -1576,7 +1576,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 	res.vmid_mask = dqm->dev->compute_vmid_bitmap;
 
 	res.queue_mask = 0;
-	for (i = 0; i < KGD_MAX_QUEUES; ++i) {
+	for (i = 0; i < AMDGPU_MAX_QUEUES; ++i) {
 		mec = (i / dqm->dev->kfd->shared_resources.num_queue_per_pipe)
 			/ dqm->dev->kfd->shared_resources.num_pipe_per_mec;
 
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 3b5a56585c4b..255adc30f802 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -123,7 +123,7 @@ struct kgd2kfd_shared_resources {
 	uint32_t num_queue_per_pipe;
 
 	/* Bit n == 1 means Queue n is available for KFD */
-	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
+	DECLARE_BITMAP(cp_queue_bitmap, AMDGPU_MAX_QUEUES);
 
 	/* SDMA doorbell assignments (SOC15 and later chips only). Only
 	 * specific doorbells are routed to each SDMA engine. Others
-- 
2.35.1

