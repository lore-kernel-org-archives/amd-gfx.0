Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 444DCEE14AC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 15:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5790910E6A6;
	Wed,  6 Sep 2023 15:47:47 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0DB210E6A4
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 15:47:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wdtx13QQk1uO4IsXbeBOPpG93uWHKWJf3hwqt8Zs5X+w0H30ImKWFCl6BtyMzyWVsG+DXVspb8KWKuNUsX/OivPgwZP2e4tUyJo9NXzOv08ZGgCEbAuBdbMVn7uJBMWQPGYV7j9SKmO/VFGKGCfsR4UZygUkn9Zfpz7tpTVzMPE+QLemkaAkjhxQZG4K3MGUkPycixstMfDHPhcgagcG6/9oSQdS4XlP+KS+woqWktEC7tZWPm5dTH9w7OSOE2Bjnb9Fp/bT2t5oIxWa9m5xvBTDRmzXw2RJ2FW5Z+jHx6Y7YSdwhgaZYLvcZOvVrNYVkzTw0t5x9ByAYVFgrMe4+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1doKCXeroajdkS+zU9gYsDaQb3GBQy5AuKo1J5VuMJ0=;
 b=OTyH/SIkA09NUDOBS60wToTvutrAKHW/QYaiNpoA2/+jTuBazT0/vXrcoM5bcQRp8QawvrjWeFtZbuTV5m37NAj5QmBjV9yprEonMCNJwe+ky7zQW9dGtzXi9JCAe2hdCrxW/DWOb7I/jTpJDJXteQpO775EP1IKQLaZVVBduvJywxWC7ZeUNWV9jc3ZhTh1pAKVxGEwMerfLor5O+fONhxTDEQy1KHHVnQK8TiBHJ3yIaM+iQKt8NU5df3lX7wxvNtOCwuxnqYR3GaOtLqoKt4ZCxj5zLmQhvxq/4ObW+flCQIzXMsrqpHYBx5lPxeqawhzZb2oqXOXm0O8vutXgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1doKCXeroajdkS+zU9gYsDaQb3GBQy5AuKo1J5VuMJ0=;
 b=P3hUlPumw0zcEMSm7pdcjqLFYfqIleiI3WYwjsQ+8iWbiMOo4EYzyrUxq4LuCOwaRbbHBPAJbUKrR8uRd6L5IocIseiCEGmui4WkhJO34Ouuv1ni5Aq0K4MUq6xT2wubFG2Li6VtyXvyvaHPZlxNxyqgMABrj6QTUYA/Dnp5bYw=
Received: from DS7PR05CA0020.namprd05.prod.outlook.com (2603:10b6:5:3b9::25)
 by PH0PR12MB5645.namprd12.prod.outlook.com (2603:10b6:510:140::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Wed, 6 Sep
 2023 15:47:39 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::8e) by DS7PR05CA0020.outlook.office365.com
 (2603:10b6:5:3b9::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25 via Frontend
 Transport; Wed, 6 Sep 2023 15:47:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 15:47:37 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 10:47:37 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCHv2 1/4] drm/amdgpu: Store CU info from all XCCs for GFX v9.4.3
Date: Wed, 6 Sep 2023 11:44:26 -0400
Message-ID: <20230906154429.216489-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|PH0PR12MB5645:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0e4eb2-dae2-4b17-a122-08dbaef098a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FCC6V4zpuLlZRjSuLPRivSC+rStnt08fZ2MjtmjvOVh4AJyVKFZTZ/2u3avzhzHyZVUQLKVTlQdxmH0D6AprfxZ9C8rSQkATpYb3XDxmB3VNYOtPDlfCPma49Wr8n2b2fg1EVCopyZjWs4d6o2GMeirtCO4mNEXfoFVMpMggCgOE0gIW0ELfcviIj8D1JnxH/vMFvr/HRYlddEQjw8JFqF8gkMr6tJdx+VwcqvJ9wYBEHXbrj8gCYYYKzy4CasB38aQU8tCxCb8IUNRERkchHy4WW27v1x9RAJNU04zGO/UL/P8cpWqpildi0fwVtoAW92pgP3RyEiqhzp0tlENE0aNDQS8GegKxtNBvSMh6AlYzw24ydf/MHoQqFWawLVKgXbMStKHvWyNi77ZyJ56pZcVAKt6XkXtCS4nkJw6zSfLahRRDf0/6K8d4qEfua6XN0V3BSZlBN7RgZbXy/9tpj8FN6cTvkMZG1FpE6hHpiPcjgWquuYlbpQ0YB4pxN6ocZJGEe46ps5/BRVrTN8EfJFShF81uEYTPCkJE75WrjPxIXriKAOFQz8I123+ahHZuFmTL8O1zZHc4Bn2YhCH0UoBeadwQGvxc8D6U6Q9PmQ3sa6RHXs4Lcb+GpklZMZjFzyE/ziZxz3gqoKmH12JhhI6K4lm73JbBnggyoJtCXIGVVYgvAu4w5xp88e7P9FRe0W3arjae82SfJDHC38HdrEx8ySA7dAtWS174cl2kTXx4PJSsPqTceQFkQNLxowmvhVn2s6f99HxFOBjmDRxfpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(346002)(39860400002)(451199024)(82310400011)(186009)(1800799009)(46966006)(36840700001)(40470700004)(7696005)(6666004)(478600001)(2906002)(336012)(2616005)(70206006)(83380400001)(316002)(1076003)(16526019)(26005)(426003)(6916009)(5660300002)(70586007)(54906003)(41300700001)(8676002)(4326008)(8936002)(36756003)(44832011)(86362001)(82740400003)(30864003)(36860700001)(47076005)(356005)(81166007)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:47:37.8323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0e4eb2-dae2-4b17-a122-08dbaef098a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5645
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

Currently, we store CU info only for a single XCC assuming
that it is the same for all XCCs. However, that may not be
true. As a result, store CU info for all XCCs. This info is
later used for CU masking.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Incorporate Felix's review comments.

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  4 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       | 76 +++++++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c         |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  |  8 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c     | 11 ++-
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  6 +-
 14 files changed, 60 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index cdf6087706aa..25d5fda5b243 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -478,7 +478,7 @@ void amdgpu_amdkfd_get_cu_info(struct amdgpu_device *adev, struct kfd_cu_info *c
 	cu_info->cu_active_number = acu_info.number;
 	cu_info->cu_ao_mask = acu_info.ao_cu_mask;
 	memcpy(&cu_info->cu_bitmap[0], &acu_info.bitmap[0],
-	       sizeof(acu_info.bitmap));
+	       sizeof(cu_info->cu_bitmap));
 	cu_info->num_shader_engines = adev->gfx.config.max_shader_engines;
 	cu_info->num_shader_arrays_per_engine = adev->gfx.config.max_sh_per_se;
 	cu_info->num_cu_per_sh = adev->gfx.config.max_cu_per_sh;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 395c1768b9fc..0ca95c4d4bfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -43,6 +43,7 @@
 #define AMDGPU_GFX_LBPW_DISABLED_MODE		0x00000008L
 
 #define AMDGPU_MAX_GC_INSTANCES		8
+#define KGD_MAX_QUEUES			128
 
 #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
 #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
@@ -257,7 +258,7 @@ struct amdgpu_cu_info {
 	uint32_t number;
 	uint32_t ao_cu_mask;
 	uint32_t ao_cu_bitmap[4][4];
-	uint32_t bitmap[4][4];
+	uint32_t bitmap[AMDGPU_MAX_GC_INSTANCES][4][4];
 };
 
 struct amdgpu_gfx_ras {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 3a48bec10aea..d462b36adf4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -850,7 +850,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		memcpy(&dev_info->cu_ao_bitmap[0], &adev->gfx.cu_info.ao_cu_bitmap[0],
 		       sizeof(adev->gfx.cu_info.ao_cu_bitmap));
 		memcpy(&dev_info->cu_bitmap[0], &adev->gfx.cu_info.bitmap[0],
-		       sizeof(adev->gfx.cu_info.bitmap));
+		       sizeof(dev_info->cu_bitmap));
 		dev_info->vram_type = adev->gmc.vram_type;
 		dev_info->vram_bit_width = adev->gmc.vram_width;
 		dev_info->vce_harvest_config = adev->vce.harvest_config;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 6ccde07ed63e..62329a822022 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9442,7 +9442,7 @@ static int gfx_v10_0_get_cu_info(struct amdgpu_device *adev,
 				gfx_v10_0_set_user_wgp_inactive_bitmap_per_sh(
 					adev, disable_masks[i * 2 + j]);
 			bitmap = gfx_v10_0_get_cu_active_bitmap_per_sh(adev);
-			cu_info->bitmap[i][j] = bitmap;
+			cu_info->bitmap[0][i][j] = bitmap;
 
 			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k++) {
 				if (bitmap & mask) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 337ed771605f..39c434ca0dad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6392,7 +6392,7 @@ static int gfx_v11_0_get_cu_info(struct amdgpu_device *adev,
 			 *    SE6: {SH0,SH1} --> {bitmap[2][2], bitmap[2][3]}
 			 *    SE7: {SH0,SH1} --> {bitmap[3][2], bitmap[3][3]}
 			 */
-			cu_info->bitmap[i % 4][j + (i / 4) * 2] = bitmap;
+			cu_info->bitmap[0][i % 4][j + (i / 4) * 2] = bitmap;
 
 			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k++) {
 				if (bitmap & mask)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index da6caff78c22..34f9211b2679 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -3577,7 +3577,7 @@ static void gfx_v6_0_get_cu_info(struct amdgpu_device *adev)
 				gfx_v6_0_set_user_cu_inactive_bitmap(
 					adev, disable_masks[i * 2 + j]);
 			bitmap = gfx_v6_0_get_cu_enabled(adev);
-			cu_info->bitmap[i][j] = bitmap;
+			cu_info->bitmap[0][i][j] = bitmap;
 
 			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k++) {
 				if (bitmap & mask) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 90b034b173c1..c2faf6b4c2fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -5119,7 +5119,7 @@ static void gfx_v7_0_get_cu_info(struct amdgpu_device *adev)
 				gfx_v7_0_set_user_cu_inactive_bitmap(
 					adev, disable_masks[i * 2 + j]);
 			bitmap = gfx_v7_0_get_cu_active_bitmap(adev);
-			cu_info->bitmap[i][j] = bitmap;
+			cu_info->bitmap[0][i][j] = bitmap;
 
 			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k++) {
 				if (bitmap & mask) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 51c1745c8369..885ebd703260 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -7121,7 +7121,7 @@ static void gfx_v8_0_get_cu_info(struct amdgpu_device *adev)
 				gfx_v8_0_set_user_cu_inactive_bitmap(
 					adev, disable_masks[i * 2 + j]);
 			bitmap = gfx_v8_0_get_cu_active_bitmap(adev);
-			cu_info->bitmap[i][j] = bitmap;
+			cu_info->bitmap[0][i][j] = bitmap;
 
 			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k ++) {
 				if (bitmap & mask) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 5c85ac34360f..f99a3a6bfd91 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -1499,7 +1499,7 @@ static void gfx_v9_0_init_always_on_cu_mask(struct amdgpu_device *adev)
 			amdgpu_gfx_select_se_sh(adev, i, j, 0xffffffff, 0);
 
 			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k ++) {
-				if (cu_info->bitmap[i][j] & mask) {
+				if (cu_info->bitmap[0][i][j] & mask) {
 					if (counter == pg_always_on_cu_num)
 						WREG32_SOC15(GC, 0, mmRLC_PG_ALWAYS_ON_CU_MASK, cu_bitmap);
 					if (counter < always_on_cu_num)
@@ -7233,7 +7233,7 @@ static int gfx_v9_0_get_cu_info(struct amdgpu_device *adev,
 			 *    SE6,SH0 --> bitmap[2][1]
 			 *    SE7,SH0 --> bitmap[3][1]
 			 */
-			cu_info->bitmap[i % 4][j + i / 4] = bitmap;
+			cu_info->bitmap[0][i % 4][j + i / 4] = bitmap;
 
 			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k ++) {
 				if (bitmap & mask) {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index a60d1a8405d4..32a740104868 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -4259,7 +4259,7 @@ static void gfx_v9_4_3_set_gds_init(struct amdgpu_device *adev)
 }
 
 static void gfx_v9_4_3_set_user_cu_inactive_bitmap(struct amdgpu_device *adev,
-						 u32 bitmap)
+						 u32 bitmap, int xcc_id)
 {
 	u32 data;
 
@@ -4269,15 +4269,15 @@ static void gfx_v9_4_3_set_user_cu_inactive_bitmap(struct amdgpu_device *adev,
 	data = bitmap << GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_CUS__SHIFT;
 	data &= GC_USER_SHADER_ARRAY_CONFIG__INACTIVE_CUS_MASK;
 
-	WREG32_SOC15(GC, GET_INST(GC, 0), regGC_USER_SHADER_ARRAY_CONFIG, data);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regGC_USER_SHADER_ARRAY_CONFIG, data);
 }
 
-static u32 gfx_v9_4_3_get_cu_active_bitmap(struct amdgpu_device *adev)
+static u32 gfx_v9_4_3_get_cu_active_bitmap(struct amdgpu_device *adev, int xcc_id)
 {
 	u32 data, mask;
 
-	data = RREG32_SOC15(GC, GET_INST(GC, 0), regCC_GC_SHADER_ARRAY_CONFIG);
-	data |= RREG32_SOC15(GC, GET_INST(GC, 0), regGC_USER_SHADER_ARRAY_CONFIG);
+	data = RREG32_SOC15(GC, GET_INST(GC, xcc_id), regCC_GC_SHADER_ARRAY_CONFIG);
+	data |= RREG32_SOC15(GC, GET_INST(GC, xcc_id), regGC_USER_SHADER_ARRAY_CONFIG);
 
 	data &= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS_MASK;
 	data >>= CC_GC_SHADER_ARRAY_CONFIG__INACTIVE_CUS__SHIFT;
@@ -4290,7 +4290,7 @@ static u32 gfx_v9_4_3_get_cu_active_bitmap(struct amdgpu_device *adev)
 static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				 struct amdgpu_cu_info *cu_info)
 {
-	int i, j, k, counter, active_cu_number = 0;
+	int i, j, k, counter, xcc_id, active_cu_number = 0;
 	u32 mask, bitmap, ao_bitmap, ao_cu_mask = 0;
 	unsigned disable_masks[4 * 4];
 
@@ -4309,46 +4309,38 @@ static int gfx_v9_4_3_get_cu_info(struct amdgpu_device *adev,
 				    adev->gfx.config.max_sh_per_se);
 
 	mutex_lock(&adev->grbm_idx_mutex);
-	for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
-		for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
-			mask = 1;
-			ao_bitmap = 0;
-			counter = 0;
-			gfx_v9_4_3_xcc_select_se_sh(adev, i, j, 0xffffffff, 0);
-			gfx_v9_4_3_set_user_cu_inactive_bitmap(
-				adev, disable_masks[i * adev->gfx.config.max_sh_per_se + j]);
-			bitmap = gfx_v9_4_3_get_cu_active_bitmap(adev);
-
-			/*
-			 * The bitmap(and ao_cu_bitmap) in cu_info structure is
-			 * 4x4 size array, and it's usually suitable for Vega
-			 * ASICs which has 4*2 SE/SH layout.
-			 * But for Arcturus, SE/SH layout is changed to 8*1.
-			 * To mostly reduce the impact, we make it compatible
-			 * with current bitmap array as below:
-			 *    SE4,SH0 --> bitmap[0][1]
-			 *    SE5,SH0 --> bitmap[1][1]
-			 *    SE6,SH0 --> bitmap[2][1]
-			 *    SE7,SH0 --> bitmap[3][1]
-			 */
-			cu_info->bitmap[i % 4][j + i / 4] = bitmap;
-
-			for (k = 0; k < adev->gfx.config.max_cu_per_sh; k++) {
-				if (bitmap & mask) {
-					if (counter < adev->gfx.config.max_cu_per_sh)
-						ao_bitmap |= mask;
-					counter++;
+	for (xcc_id = 0; xcc_id < NUM_XCC(adev->gfx.xcc_mask); xcc_id++) {
+		for (i = 0; i < adev->gfx.config.max_shader_engines; i++) {
+			for (j = 0; j < adev->gfx.config.max_sh_per_se; j++) {
+				mask = 1;
+				ao_bitmap = 0;
+				counter = 0;
+				gfx_v9_4_3_xcc_select_se_sh(adev, i, j, 0xffffffff, xcc_id);
+				gfx_v9_4_3_set_user_cu_inactive_bitmap(
+					adev,
+					disable_masks[i * adev->gfx.config.max_sh_per_se + j],
+					xcc_id);
+				bitmap = gfx_v9_4_3_get_cu_active_bitmap(adev, xcc_id);
+
+				cu_info->bitmap[xcc_id][i][j] = bitmap;
+
+				for (k = 0; k < adev->gfx.config.max_cu_per_sh; k++) {
+					if (bitmap & mask) {
+						if (counter < adev->gfx.config.max_cu_per_sh)
+							ao_bitmap |= mask;
+						counter++;
+					}
+					mask <<= 1;
 				}
-				mask <<= 1;
+				active_cu_number += counter;
+				if (i < 2 && j < 2)
+					ao_cu_mask |= (ao_bitmap << (i * 16 + j * 8));
+				cu_info->ao_cu_bitmap[i][j] = ao_bitmap;
 			}
-			active_cu_number += counter;
-			if (i < 2 && j < 2)
-				ao_cu_mask |= (ao_bitmap << (i * 16 + j * 8));
-			cu_info->ao_cu_bitmap[i % 4][j + i / 4] = ao_bitmap;
 		}
+		gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
+					    xcc_id);
 	}
-	gfx_v9_4_3_xcc_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff,
-				    0);
 	mutex_unlock(&adev->grbm_idx_mutex);
 
 	cu_info->number = active_cu_number;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 2e9612cf56ae..950810bb5c71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -2088,7 +2088,8 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 
 	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
 	cu->num_simd_per_cu = cu_info.simd_per_cu;
-	cu->num_simd_cores = cu_info.simd_per_cu * cu_info.cu_active_number;
+	cu->num_simd_cores = cu_info.simd_per_cu *
+			(cu_info.cu_active_number / kdev->kfd->num_nodes);
 	cu->max_waves_simd = cu_info.max_waves_per_simd;
 
 	cu->wave_front_size = cu_info.wave_front_size;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index d01bb57733b3..763966236658 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -104,11 +104,13 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	bool wgp_mode_req = KFD_GC_VERSION(mm->dev) >= IP_VERSION(10, 0, 0);
 	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
 	int i, se, sh, cu, cu_bitmap_sh_mul, inc = wgp_mode_req ? 2 : 1;
+	uint32_t cu_active_per_node;
 
 	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
 
-	if (cu_mask_count > cu_info.cu_active_number)
-		cu_mask_count = cu_info.cu_active_number;
+	cu_active_per_node = cu_info.cu_active_number / mm->dev->kfd->num_nodes;
+	if (cu_mask_count > cu_active_per_node)
+		cu_mask_count = cu_active_per_node;
 
 	/* Exceeding these bounds corrupts the stack and indicates a coding error.
 	 * Returning with no CU's enabled will hang the queue, which should be
@@ -141,7 +143,7 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	for (se = 0; se < cu_info.num_shader_engines; se++)
 		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
 			cu_per_sh[se][sh] = hweight32(
-				cu_info.cu_bitmap[se % 4][sh + (se / 4) * cu_bitmap_sh_mul]);
+				cu_info.cu_bitmap[0][se % 4][sh + (se / 4) * cu_bitmap_sh_mul]);
 
 	/* Symmetrically map cu_mask to all SEs & SHs:
 	 * se_mask programs up to 2 SH in the upper and lower 16 bits.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index ff98fded9534..c54795682dfb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -450,8 +450,7 @@ static ssize_t node_show(struct kobject *kobj, struct attribute *attr,
 	sysfs_show_32bit_prop(buffer, offs, "cpu_cores_count",
 			      dev->node_props.cpu_cores_count);
 	sysfs_show_32bit_prop(buffer, offs, "simd_count",
-			      dev->gpu ? (dev->node_props.simd_count *
-					  NUM_XCC(dev->gpu->xcc_mask)) : 0);
+			      dev->gpu ? dev->node_props.simd_count : 0);
 	sysfs_show_32bit_prop(buffer, offs, "mem_banks_count",
 			      dev->node_props.mem_banks_count);
 	sysfs_show_32bit_prop(buffer, offs, "caches_count",
@@ -1604,7 +1603,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 	int i, j, k;
 	struct kfd_cache_properties *pcache = NULL;
 
-	cu_sibling_map_mask = cu_info->cu_bitmap[0][0];
+	cu_sibling_map_mask = cu_info->cu_bitmap[0][0][0];
 	cu_sibling_map_mask &=
 		((1 << pcache_info[cache_type].num_cu_shared) - 1);
 	first_active_cu = ffs(cu_sibling_map_mask);
@@ -1647,7 +1646,7 @@ static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
 				pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
 				k += 4;
 
-				cu_sibling_map_mask = cu_info->cu_bitmap[i % 4][j + i / 4];
+				cu_sibling_map_mask = cu_info->cu_bitmap[0][i % 4][j + i / 4];
 				cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
 			}
 		}
@@ -1708,8 +1707,8 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
 					for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
 
 						ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
-										pcu_info->cu_bitmap[i % 4][j + i / 4], ct,
-										cu_processor_id, k);
+									pcu_info->cu_bitmap[0][i % 4][j + i / 4], ct,
+									cu_processor_id, k);
 
 						if (ret < 0)
 							break;
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index f3f40dbb8ff7..3b5a56585c4b 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -31,12 +31,12 @@
 #include <linux/types.h>
 #include <linux/bitmap.h>
 #include <linux/dma-fence.h>
+#include "amdgpu_irq.h"
+#include "amdgpu_gfx.h"
 
 struct pci_dev;
 struct amdgpu_device;
 
-#define KGD_MAX_QUEUES 128
-
 struct kfd_dev;
 struct kgd_mem;
 
@@ -68,7 +68,7 @@ struct kfd_cu_info {
 	uint32_t wave_front_size;
 	uint32_t max_scratch_slots_per_cu;
 	uint32_t lds_size;
-	uint32_t cu_bitmap[4][4];
+	uint32_t cu_bitmap[AMDGPU_MAX_GC_INSTANCES][4][4];
 };
 
 /* For getting GPU local memory information from KGD */
-- 
2.35.1

