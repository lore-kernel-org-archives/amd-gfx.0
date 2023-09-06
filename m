Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63BC7EE14A5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 15:47:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F12C810E6A5;
	Wed,  6 Sep 2023 15:47:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32A9C10E6A3
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 15:47:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzV8EhGSIwk2x1mdv8CMageICxm1HpX5QziY89TFWlWHwrEYFF/Cyx1YxDMgSDaTROg4Yd+UC7A4RdXyoEs0GbjgPDJ/4R8xYBz1MMKNT04HWmLwTl5uxTKKhRYXvBPiDjbiB67zb/JTDlOX8FOEx46Uc5W93Mnjh+BU2k83Mxnz91v7gTylN9qxGUVx0r263wlDaA+5hRDKczFc47zJX/DkeJWyYfQcutKk2FZllN7egoWtOKykQC2BvK8O+fsbHRwRUPH/4qrB+MFHp1JCoK6W4n/lt5otf00J6zMc2nYlMDbh9khtYKDxZDu54keSPPAOUu8mapNR7mQLzGSrRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbPgih/5p8dSIa6Y6HnP0A6dfp4910wE6dLNLAVc2tE=;
 b=B/cS4cea+JDpEP1mylYE3O7x5Ho/r3o4gl7Id6bhn7MHzHfjhqKBLibYzhtiIHop5GDY2gjwFD8V35R6PVTs8fpHImumFUuSESwuIrCKPKHNqzCdQSC5FpXHr1kVmTd2vp2ouuzdEbUC27kM83UTmgy2yHKmO0Uci/EHDUVAsRqk1G5GobVvvqvpfPePZ8KLg13hlxg1hUN/NEQ9RMKypibWqDfvEst4esS7kI7vVjl3RsC18w8ZlsW4imB1DOIRzm/pB0Ai28uQWlkCwCCCC9cNaSTCq8X6y0tWx0bTU5keQ8HiRjhIY/BAOUg8uUPxAMHzd+QPSZ5x2T/h4uzI6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbPgih/5p8dSIa6Y6HnP0A6dfp4910wE6dLNLAVc2tE=;
 b=TtVZ3ByN82XYg/S8YBo5CZA5UBH8UQ6k907AZoQT0xADkrnDRaXzeu98Mp7CE5YWrMQT6TG/EsP620odHnepSQ28VSPnHFT08HKglsuhRJB8kVvES1IUPyV7ZGsxQFvd7CVo9EKQ4hRL/MXuOzK//mw6UFgmVc3GB3ZFKgEu9f8=
Received: from DS7PR05CA0012.namprd05.prod.outlook.com (2603:10b6:5:3b9::17)
 by SA1PR12MB6872.namprd12.prod.outlook.com (2603:10b6:806:24c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:47:40 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:3b9:cafe::bd) by DS7PR05CA0012.outlook.office365.com
 (2603:10b6:5:3b9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.27 via Frontend
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
Subject: [PATCHv2 3/4] drm/amdkfd: Update CU masking for GFX 9.4.3
Date: Wed, 6 Sep 2023 11:44:28 -0400
Message-ID: <20230906154429.216489-3-mukul.joshi@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|SA1PR12MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cc46cc7-3864-4455-6b33-08dbaef099ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KgNVVO1AQArYRg8klwGhjeJNExIC38huUD+sVcsbi97iUWy+62jnChhDlCicNnVheonoLkh6Nv0S37bdstmbDmm4KopRmY8BbdvfF997eRk0sh3FSLqmY8ZXwKEe2hND6FZGjOx5FO6h9WYBkKgbchOMZqqpJ2M+OrKU9580smJBQ7wfuUtM0hFCeQb7S3++NpIAkPflGGnu33MG4w2CglzOqQjMFxBRyiFMs0jPrvcSbJdPSxYZtsMoO6S+TQo+Y9TvW0CuT7f5ENTs4nadbijMML5kduV2dFFN9BVBBhX4+yRKmHIeWVE1fuIlB5/CrllSRX5y7aJU2HLgZ934N+QhzuQXwHEIW/MpI7aiKYx5fZGcLO/BsB8jIkEriKIWldwEqycwYLsx74CQqFCm64o4DPquESuOzDVRu+3qYCRDphVNNyZwLC+uTXe8Q0mdXsKIOeuvO+emlSjNR4YI+qj5UUQnGulDIOqP/h4BsfZCwOzeHd4a+ta4zhqQQ7+tEU0/Ns8URIlUdW+yKeDc2XIQ6Y43RIQaU14cW9DD0cS/k59NptBo1JyD0OkRAgygrCUSxxtGb1WGEtv5ZbEfKpjNKchwg/mF7ecb1MAK5sfSPWDPxxXUsWvZD0qGsyQyknnbMu9gjELJRIBLlvyFWT/tjEo1GaHM4uvUCmPPuwzCnAY75HdwpIAMjYHe+DbG8/8M1bMaUSwLSm//AHbYS/rSViImgJlRU4LFQ+WyEtgtIRqXuu0p95mHvC7D+c2KedRMfsy3gbd381xqOwW4iA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(36840700001)(46966006)(82740400003)(2616005)(40460700003)(26005)(81166007)(16526019)(356005)(1076003)(7696005)(47076005)(36756003)(36860700001)(426003)(336012)(83380400001)(40480700001)(4326008)(478600001)(8676002)(15650500001)(8936002)(70586007)(44832011)(70206006)(5660300002)(54906003)(86362001)(316002)(6916009)(6666004)(2906002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:47:40.0199 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc46cc7-3864-4455-6b33-08dbaef099ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6872
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

The CU mask passed from user-space will change based on
different spatial partitioning mode. As a result, update
CU masking code for GFX9.4.3 to work for all partitioning
modes.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
v1->v2:
- Incorporate Felix's review comments.

 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c  | 28 ++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c  |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c   | 46 ++++++++++++-------
 .../gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c   |  2 +-
 7 files changed, 56 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 763966236658..447829c22295 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -97,14 +97,16 @@ void free_mqd_hiq_sdma(struct mqd_manager *mm, void *mqd,
 
 void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		const uint32_t *cu_mask, uint32_t cu_mask_count,
-		uint32_t *se_mask)
+		uint32_t *se_mask, uint32_t inst)
 {
 	struct kfd_cu_info cu_info;
 	uint32_t cu_per_sh[KFD_MAX_NUM_SE][KFD_MAX_NUM_SH_PER_SE] = {0};
 	bool wgp_mode_req = KFD_GC_VERSION(mm->dev) >= IP_VERSION(10, 0, 0);
 	uint32_t en_mask = wgp_mode_req ? 0x3 : 0x1;
-	int i, se, sh, cu, cu_bitmap_sh_mul, inc = wgp_mode_req ? 2 : 1;
+	int i, se, sh, cu, cu_bitmap_sh_mul, cu_inc = wgp_mode_req ? 2 : 1;
 	uint32_t cu_active_per_node;
+	int inc = cu_inc * NUM_XCC(mm->dev->xcc_mask);
+	int xcc_inst = inst + ffs(mm->dev->xcc_mask) - 1;
 
 	amdgpu_amdkfd_get_cu_info(mm->dev->adev, &cu_info);
 
@@ -143,7 +145,8 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	for (se = 0; se < cu_info.num_shader_engines; se++)
 		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++)
 			cu_per_sh[se][sh] = hweight32(
-				cu_info.cu_bitmap[0][se % 4][sh + (se / 4) * cu_bitmap_sh_mul]);
+				cu_info.cu_bitmap[xcc_inst][se % 4][sh + (se / 4) *
+				cu_bitmap_sh_mul]);
 
 	/* Symmetrically map cu_mask to all SEs & SHs:
 	 * se_mask programs up to 2 SH in the upper and lower 16 bits.
@@ -166,20 +169,33 @@ void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 	 * cu_mask[0] bit8 -> se_mask[0] bit1 (SE0,SH0,CU1)
 	 * ...
 	 *
+	 * For GFX 9.4.3, the following code only looks at a
+	 * subset of the cu_mask corresponding to the inst parameter.
+	 * If we have n XCCs under one GPU node
+	 * cu_mask[0] bit0 -> XCC0 se_mask[0] bit0 (XCC0,SE0,SH0,CU0)
+	 * cu_mask[0] bit1 -> XCC1 se_mask[0] bit0 (XCC1,SE0,SH0,CU0)
+	 * ..
+	 * cu_mask[0] bitn -> XCCn se_mask[0] bit0 (XCCn,SE0,SH0,CU0)
+	 * cu_mask[0] bit n+1 -> XCC0 se_mask[1] bit0 (XCC0,SE1,SH0,CU0)
+	 *
+	 * For example, if there are 6 XCCs under 1 KFD node, this code
+	 * running for each inst, will look at the bits as:
+	 * inst, inst + 6, inst + 12...
+	 *
 	 * First ensure all CUs are disabled, then enable user specified CUs.
 	 */
 	for (i = 0; i < cu_info.num_shader_engines; i++)
 		se_mask[i] = 0;
 
-	i = 0;
-	for (cu = 0; cu < 16; cu += inc) {
+	i = inst;
+	for (cu = 0; cu < 16; cu += cu_inc) {
 		for (sh = 0; sh < cu_info.num_shader_arrays_per_engine; sh++) {
 			for (se = 0; se < cu_info.num_shader_engines; se++) {
 				if (cu_per_sh[se][sh] > cu) {
 					if (cu_mask[i / 32] & (en_mask << (i % 32)))
 						se_mask[se] |= en_mask << (cu + sh * 16);
 					i += inc;
-					if (i == cu_mask_count)
+					if (i >= cu_mask_count)
 						return;
 				}
 			}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index 23158db7da03..57bf5e513f4d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -138,7 +138,7 @@ void free_mqd_hiq_sdma(struct mqd_manager *mm, void *mqd,
 
 void mqd_symmetrically_map_cu_mask(struct mqd_manager *mm,
 		const uint32_t *cu_mask, uint32_t cu_mask_count,
-		uint32_t *se_mask);
+		uint32_t *se_mask, uint32_t inst);
 
 int kfd_hiq_load_mqd_kiq(struct mqd_manager *mm, void *mqd,
 		uint32_t pipe_id, uint32_t queue_id,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index ee1d32d957f2..1a4a69943c71 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -52,7 +52,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, 0);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 83699392c808..8b7fed913526 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -52,7 +52,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, 0);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
index 0bbf0edbabd4..964b5d50a77e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v11.c
@@ -71,7 +71,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 	}
 
 	mqd_symmetrically_map_cu_mask(mm,
-		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, 0);
 
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
 	m->compute_static_thread_mgmt_se1 = se_mask[1];
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index e23d32f35607..42d881809dc7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -60,7 +60,7 @@ static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
 }
 
 static void update_cu_mask(struct mqd_manager *mm, void *mqd,
-			struct mqd_update_info *minfo)
+			struct mqd_update_info *minfo, uint32_t inst)
 {
 	struct v9_mqd *m;
 	uint32_t se_mask[KFD_MAX_NUM_SE] = {0};
@@ -69,27 +69,36 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, inst);
 
 	m = get_mqd(mqd);
+
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
 	m->compute_static_thread_mgmt_se1 = se_mask[1];
 	m->compute_static_thread_mgmt_se2 = se_mask[2];
 	m->compute_static_thread_mgmt_se3 = se_mask[3];
-	m->compute_static_thread_mgmt_se4 = se_mask[4];
-	m->compute_static_thread_mgmt_se5 = se_mask[5];
-	m->compute_static_thread_mgmt_se6 = se_mask[6];
-	m->compute_static_thread_mgmt_se7 = se_mask[7];
-
-	pr_debug("update cu mask to %#x %#x %#x %#x %#x %#x %#x %#x\n",
-		m->compute_static_thread_mgmt_se0,
-		m->compute_static_thread_mgmt_se1,
-		m->compute_static_thread_mgmt_se2,
-		m->compute_static_thread_mgmt_se3,
-		m->compute_static_thread_mgmt_se4,
-		m->compute_static_thread_mgmt_se5,
-		m->compute_static_thread_mgmt_se6,
-		m->compute_static_thread_mgmt_se7);
+	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3)) {
+		m->compute_static_thread_mgmt_se4 = se_mask[4];
+		m->compute_static_thread_mgmt_se5 = se_mask[5];
+		m->compute_static_thread_mgmt_se6 = se_mask[6];
+		m->compute_static_thread_mgmt_se7 = se_mask[7];
+
+		pr_debug("update cu mask to %#x %#x %#x %#x %#x %#x %#x %#x\n",
+			m->compute_static_thread_mgmt_se0,
+			m->compute_static_thread_mgmt_se1,
+			m->compute_static_thread_mgmt_se2,
+			m->compute_static_thread_mgmt_se3,
+			m->compute_static_thread_mgmt_se4,
+			m->compute_static_thread_mgmt_se5,
+			m->compute_static_thread_mgmt_se6,
+			m->compute_static_thread_mgmt_se7);
+	} else {
+		pr_debug("inst: %u, update cu mask to %#x %#x %#x %#x\n",
+			inst, m->compute_static_thread_mgmt_se0,
+			m->compute_static_thread_mgmt_se1,
+			m->compute_static_thread_mgmt_se2,
+			m->compute_static_thread_mgmt_se3);
+	}
 }
 
 static void set_priority(struct v9_mqd *m, struct queue_properties *q)
@@ -290,7 +299,8 @@ static void update_mqd(struct mqd_manager *mm, void *mqd,
 	if (mm->dev->kfd->cwsr_enabled && q->ctx_save_restore_area_address)
 		m->cp_hqd_ctx_save_control = 0;
 
-	update_cu_mask(mm, mqd, minfo);
+	if (KFD_GC_VERSION(mm->dev) != IP_VERSION(9, 4, 3))
+		update_cu_mask(mm, mqd, minfo, 0);
 	set_priority(m, q);
 
 	q->is_active = QUEUE_IS_ACTIVE(*q);
@@ -676,6 +686,8 @@ static void update_mqd_v9_4_3(struct mqd_manager *mm, void *mqd,
 		m = get_mqd(mqd + size * xcc);
 		update_mqd(mm, m, q, minfo);
 
+		update_cu_mask(mm, mqd, minfo, xcc);
+
 		if (q->format == KFD_QUEUE_FORMAT_AQL) {
 			switch (xcc) {
 			case 0:
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 657c37822980..3e1a574d4ea6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -55,7 +55,7 @@ static void update_cu_mask(struct mqd_manager *mm, void *mqd,
 		return;
 
 	mqd_symmetrically_map_cu_mask(mm,
-		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask);
+		minfo->cu_mask.ptr, minfo->cu_mask.count, se_mask, 0);
 
 	m = get_mqd(mqd);
 	m->compute_static_thread_mgmt_se0 = se_mask[0];
-- 
2.35.1

