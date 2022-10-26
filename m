Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9927C38A2D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Oct 2022 09:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0762510E495;
	Wed, 26 Oct 2022 09:03:52 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2056.outbound.protection.outlook.com [40.107.212.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3446B10E495
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 09:03:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YaFw0Apf4FlEBZtZCJ4uvI+v5yKcLN8O4UwxYlDpxHzZaKMyBvy1yM2J/WnQRbzp96+04e675scPkjcpUEDNU9arVzaUAUgyMEXlFKPtLQ8FBplWsJYKf2TaZqzeoVUVEUmF63o3uL4FSYeIA4c8A17EKSVt0G/Cyf08k5GfQiCrpb2h5RpKdFMpJVV6brTHy6EM2VmtadaVy1NXEEImAGCp79V4jOZ5gVl4OF/GunkY2CutA2JHwHnMMWhVhIVNW5G+VvemYgP/8VuJK9tRG/E5e0XylA974985f6nFHwF/fvbIQshgHO4DI3YokbMOMfj/30xKuc/R31oXloNpRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCe2HDTM6wnqLstqKxGGQe7LGuBhAChbc+Kzmw8E5Vc=;
 b=dfHN2kjkiCVRrgoQe156hD5ryP1XqEqn6gE0iaqbb8ZazLGqWpgmlAS6xiV3iDCAUSo9Upowhix9WiEjEqEgrIGwGhaS+a6RDRMOzBjo6AXHJf/4jCmHixXZo4nyFKHWUcUTQVJWU8K4VWmkr24j6auCn0b6NX7wfBcvphZioBsqilmIHIlidvHnFflrjazypNl4CnsgWA++xFWD+Vp1tGp9+unAVi4L1umCoiUcSry9MO4vsaZAGQks+M1SRuStcFSDFOz90SvTZIjmAPW3Ya4gMHwnQT/T9GXkODp2M/zV92RnyAhW/pPX/V66QPvST58l9b4poKcDaw9fZ0hOgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCe2HDTM6wnqLstqKxGGQe7LGuBhAChbc+Kzmw8E5Vc=;
 b=Wtp/QoRkSlQp1zuCXe/lRru0I6QNkTUfcBeWDEbcIAq0HIawXVAwzR5oco8lU9sHiSHPR1936893jNsIeZBLjEVQTqEYZo9/2aCAa6lBobZzGYLZJFxtw0qll6LNJNn0L9mnjjvVnwGzUvg+ZiaaujOnA5WiaHDpFRuvU/Por/A=
Received: from MW4PR03CA0260.namprd03.prod.outlook.com (2603:10b6:303:b4::25)
 by CH2PR12MB5515.namprd12.prod.outlook.com (2603:10b6:610:34::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Wed, 26 Oct
 2022 09:03:45 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::12) by MW4PR03CA0260.outlook.office365.com
 (2603:10b6:303:b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Wed, 26 Oct 2022 09:03:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 26 Oct 2022 09:03:44 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 26 Oct
 2022 04:03:42 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: Init the base cu processor id
Date: Wed, 26 Oct 2022 17:03:12 +0800
Message-ID: <20221026090313.4117136-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT044:EE_|CH2PR12MB5515:EE_
X-MS-Office365-Filtering-Correlation-Id: 91e110c6-66c0-4f0a-ccc7-08dab730fca7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdsylGT953J6X5P/Zc7A+hTRT9QLhxbQtchaDyUNsJH+eqFi7OkCiIpHV//GEDJBiP2rLjk3fVPStErxWvml5JBwH2aLS+q5aQ7T8AfFeaFq3PrJkU5dJBFNX0eol1qymQ1s+Sq2hozNN2FvsU7G4Ntsekt5oEaGr5zLT6BM/eydhx4oCkz1C1LzCvC+EwdO4nlSoDTPTCeJKLUcwfAl9LS7ES1djZKy7M6LANJTH4tcQ13j+71ZxjtDwRv6IS4iC9KkXpufdPRXdje2K/ioszsnaKqn+g78MApBNXGKGOaiiuHPrdaVe9HFDXFUEerLRX0+1i+3xohqwZV+WO+wYOPVXjDFlni6xA0KmUAThGsbsaXo9/yezs4DfCWNzusimYiuzAX5B8ABrX6vVxvUnZfeiY6LM5hqw2xoe6mNepQBr8m/F/OVVMgY5eogTYQbaAnrdFRXteyz/XqSGf7OfvR5Y41TwQgn2BCmImkyz/5x75N0bI4iMO0+i9dqtLUioYdMQZD9r5UK8lZSQocQyHfDOOGAInsokMI0tIgldtFRjtA9b1zWEp1G79zZ/PggRUP6xy+Zso+vAhj/lFkIPTRBagBtulsKGURJRpP5gDUcz2sGGC6cEcul/siZIrO+oRC7aKrzVf7QTXee0iC1Bxn3awYFfp3bbypEC3Wqsp/wuHbhmYo1p/ZUA9gTktc96Ujqcr0U5U8kTX9X6xM6m3UarwWP4NOYzQ38oxrQ6RHvCph4VWjkcSN/Eqc7Xm0REqcUtxqSGcPPuAWJS21943YSsexvLhcMxRF1zeGNJNYL0jPbDlkiAnmgZsAib8aN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(451199015)(36840700001)(46966006)(40470700004)(86362001)(83380400001)(478600001)(356005)(82740400003)(54906003)(41300700001)(5660300002)(110136005)(426003)(40480700001)(47076005)(6636002)(82310400005)(8676002)(4326008)(7696005)(1076003)(70206006)(2906002)(16526019)(2616005)(70586007)(81166007)(26005)(36756003)(316002)(336012)(40460700003)(6666004)(186003)(36860700001)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2022 09:03:44.9796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91e110c6-66c0-4f0a-ccc7-08dab730fca7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5515
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
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 20 +++++++++++++-------
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h |  3 +++
 2 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index d25ac9cbe5b2..35d09e29aafb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -41,13 +41,18 @@ static uint32_t gpu_processor_id_low = 0x80001000;
  *	@total_cu_count - Total CUs present in the GPU including ones
  *			  masked off
  */
-static inline unsigned int get_and_inc_gpu_processor_id(
-				unsigned int total_cu_count)
+static inline void assign_gpu_processor_id(struct kfd_dev *kfd)
 {
-	int current_id = gpu_processor_id_low;
+	struct amdgpu_device *adev = kfd->adev;
+	unsigned int array_count = 0;
+	unsigned int total_cu_count = 0;
+
+	kfd->processor_id_low = gpu_processor_id_low;
+
+	array_count = adev->gfx.config.max_sh_per_se * adev->gfx.config.max_shader_engines;
+	total_cu_count = array_count * adev->gfx.config.max_cu_per_sh;
 
 	gpu_processor_id_low += total_cu_count;
-	return current_id;
 }
 
 /* Static table to describe GPU Cache information */
@@ -2223,7 +2228,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	struct crat_subtype_computeunit *cu;
 	struct kfd_cu_info cu_info;
 	int avail_size = *size;
-	uint32_t total_num_of_cu;
 	int num_of_cache_entries = 0;
 	int cache_mem_filled = 0;
 	uint32_t nid = 0;
@@ -2275,8 +2279,10 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	cu->wave_front_size = cu_info.wave_front_size;
 	cu->array_count = cu_info.num_shader_arrays_per_engine *
 		cu_info.num_shader_engines;
-	total_num_of_cu = (cu->array_count * cu_info.num_cu_per_sh);
-	cu->processor_id_low = get_and_inc_gpu_processor_id(total_num_of_cu);
+
+	assign_gpu_processor_id(kdev);
+	cu->processor_id_low = kdev->processor_id_low;
+
 	cu->num_cu_per_array = cu_info.num_cu_per_sh;
 	cu->max_slots_scatch_cu = cu_info.max_scratch_slots_per_cu;
 	cu->num_banks = cu_info.num_shader_engines;
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

