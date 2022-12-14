Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346CDC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 09:06:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E87E10E394;
	Wed, 14 Dec 2022 09:06:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A8D810E394
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 09:06:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7U4LPrYd7cWD/x4xRA6IBHmV3HA5YFxonMnbL3gqf16Rgfk2XJMAZjVwTmjn2NGWMgM4H3Ql80lPvoNS/4cr5wGY+NdrM8tpS+Wdj2KRZ+aqxiKPDJPqtHwBCr5uSSOobYmoOcR11dD1C6bi3I2V+5ItDlX68sB9ETc/WMzZf8GtpiGMy40IS9M4maGbsSjKUfZXU8chEgyYCJlRgoujOEii6gEuFBm8boHq4VNXuwDir433rphGBS3NLx607J6LbrxqgMfR3RWeL6S5X5/uNsPNkBAZCgzjtEQ+gW2gJR4ayU7W7F/4irJGAqN+chNFqY2CGIiW1a+BNDo2aX1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5xjTkyIIfrgNG/Gsi0fSk85STsDicQwqj1uSLiWjns=;
 b=KfnCyqn8afi267naa4zLFk6BIp8IPTuVVDD0gt8u289stU8Jlao7nmB95YoI1kzCv7nSFMTZHh7mae9OwkzwA+FoJAcQdRmo8U+kkluggQcjcu/bJN121rrtWJ6/4nmB93MHp9GB55rQaE3+HxDvQz9VaVzBbXW+S1SAhorjJ6x/Ch8pKiSc+bDQ0fuWZthjCEMRMRF3sY+YnvOk2ywqO0zrge+NrH51jfrLZy96qzQxJABTdW7os0ns0V6MKhtaa+ltJwQ2E547YjXiRGI7BVZdopYflsA9aE/smQW/qRP7t5wnDEbkYEsSP7q4WP9qquCUQ+miL+Fe7Is3/Zxu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5xjTkyIIfrgNG/Gsi0fSk85STsDicQwqj1uSLiWjns=;
 b=3CX6sRUYGZQKVUHhRVq/wu91TO9fw3oZkndYy2zjUzk1Qu0k0V43OmV5XQD8o9js8iEblOthF4YJdY0OwYBKuLiSYf8Mt8HJSivOLO4HghCo4F93N47zlrdDaBJiqrCAVnfFDhjBPRpas4PTkSUh/qAAaw1AFBH4dXXn7W3jjZg=
Received: from DS7PR03CA0064.namprd03.prod.outlook.com (2603:10b6:5:3bb::9) by
 SJ1PR12MB6362.namprd12.prod.outlook.com (2603:10b6:a03:454::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 09:06:15 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::56) by DS7PR03CA0064.outlook.office365.com
 (2603:10b6:5:3bb::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 09:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 09:06:14 +0000
Received: from localhost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 03:06:12 -0600
From: Luben Tuikov <luben.tuikov@amd.com>
To: AMD Graphics <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Remove unnecessary domain argument
Date: Wed, 14 Dec 2022 04:05:24 -0500
Message-ID: <20221214090524.126956-1-luben.tuikov@amd.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-check-string-leak: v1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|SJ1PR12MB6362:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e712b43-7e1b-4dce-6970-08daddb27426
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /N8gc0hYxWt+zQghuP2HGRzLxuadN23OWbESXFmc2LPf2O8pBP6HNkNKJXnEAveXj4edsonKSczeJGuaVchfkUL8bBz5XRznnZXHktDaj0KYOJ674hvGNScNdLrd2fjNiDJDF1svHG7xbnDjetshKzCc6U/q9N3j3/KyWBN6L8rxVMQObecszkJ+VGLSMjiAzmJBbfC9ODR1R7kfBTJGabn+MVfarMMHbr7lxOVOJn+WaB7ripS+Yx3y4poQNfiZuTsI/Vflk1/M7VwjNTQl3qjB9mJe1ZI0Vff9wXrXcYLBN/sIxTi+D4GYIx0FLpY7ICB7fglmsn/yjUexyyZao8Z0cTl6gQpEUS0TjMW1enIrmZLjCI98dexmqAN8nj3Zc/kGdQ/nGQ6D3qxSU1gBzIbkHQtTxKbLlhvbt7jpsOa+v6gmfqIeBHMjckyiiKjp/505X5GUmi3o32HLo59Qm06R/FiHJ1adJ7kYCWQUyWmffcYk2OqsMAOD/lcarjszmMYSiNZsu4XovAHmJ6akSEAxJ8ckMkHVhH3U3iQTPdN3LDz6QM9A82QbnqMX4wxbbyOnPIBJ+QN8vO5aTDdggiVOgehRTOJiNQFoHycFbr8Ug2OB/UJrZYHwHQ2rBClNDpYRMJ+5SwtAEWXyugS9B4nAAcyNGAetPiVgUtFvCSitSOMbK4O2X/lNLfchkBjHtv0hjPgIsqJHUDMu+d9cb9XC0iznJOM47SewXWbOvM8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(82310400005)(86362001)(36756003)(5660300002)(40460700003)(7696005)(426003)(2906002)(6666004)(47076005)(41300700001)(4326008)(70586007)(36860700001)(83380400001)(8676002)(16526019)(316002)(54906003)(6916009)(70206006)(40480700001)(336012)(186003)(26005)(356005)(1076003)(2616005)(81166007)(8936002)(82740400003)(44832011)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 09:06:14.8156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e712b43-7e1b-4dce-6970-08daddb27426
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6362
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
Cc: Alex Deucher <Alexander.Deucher@amd.com>,
 Luben Tuikov <luben.tuikov@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Remove the "domain" argument to amdgpu_bo_create_kernel_at() since this
function takes an "offset" argument which is the offset off of VRAM, and as
such allocation always takes place in VRAM. Thus, the "domain" argument is
unnecessary.

Cc: Alex Deucher <Alexander.Deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: AMD Graphics <amd-gfx@lists.freedesktop.org>
Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  7 -------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   |  1 -
 4 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fd3ab4b5e5bb1f..72b7429e63ab20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -346,17 +346,16 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
  * @adev: amdgpu device object
  * @offset: offset of the BO
  * @size: size of the BO
- * @domain: where to place it
  * @bo_ptr:  used to initialize BOs in structures
  * @cpu_addr: optional CPU address mapping
  *
- * Creates a kernel BO at a specific offset in the address space of the domain.
+ * Creates a kernel BO at a specific offset in VRAM.
  *
  * Returns:
  * 0 on success, negative error code otherwise.
  */
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
-			       uint64_t offset, uint64_t size, uint32_t domain,
+			       uint64_t offset, uint64_t size,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
@@ -366,8 +365,9 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 	offset &= PAGE_MASK;
 	size = ALIGN(size, PAGE_SIZE);
 
-	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE, domain, bo_ptr,
-				      NULL, cpu_addr);
+	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
+				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
+				      cpu_addr);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 147b79c10cbb6b..93207badf83f39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -284,7 +284,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 			    u32 domain, struct amdgpu_bo **bo_ptr,
 			    u64 *gpu_addr, void **cpu_addr);
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
-			       uint64_t offset, uint64_t size, uint32_t domain,
+			       uint64_t offset, uint64_t size,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
 int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_param *bp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5c6fabaa444494..74b3e824807f71 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1601,7 +1601,6 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 	return amdgpu_bo_create_kernel_at(adev,
 					  adev->mman.fw_vram_usage_start_offset,
 					  adev->mman.fw_vram_usage_size,
-					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.fw_vram_usage_reserved_bo,
 					  &adev->mman.fw_vram_usage_va);
 }
@@ -1627,7 +1626,6 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
 	return amdgpu_bo_create_kernel_at(adev,
 					  adev->mman.drv_vram_usage_start_offset,
 					  adev->mman.drv_vram_usage_size,
-					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.drv_vram_usage_reserved_bo,
 					  &adev->mman.drv_vram_usage_va);
 }
@@ -1708,7 +1706,6 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ret = amdgpu_bo_create_kernel_at(adev,
 					 ctx->c2p_train_data_offset,
 					 ctx->train_data_size,
-					 AMDGPU_GEM_DOMAIN_VRAM,
 					 &ctx->c2p_bo,
 					 NULL);
 		if (ret) {
@@ -1722,7 +1719,6 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	ret = amdgpu_bo_create_kernel_at(adev,
 				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
 				adev->mman.discovery_tmr_size,
-				AMDGPU_GEM_DOMAIN_VRAM,
 				&adev->mman.discovery_memory,
 				NULL);
 	if (ret) {
@@ -1823,21 +1819,18 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * avoid display artifacts while transitioning between pre-OS
 	 * and driver.  */
 	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_vga_memory,
 				       NULL);
 	if (r)
 		return r;
 	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
 				       adev->mman.stolen_extended_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_extended_memory,
 				       NULL);
 	if (r)
 		return r;
 	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
 				       adev->mman.stolen_reserved_size,
-				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_reserved_memory,
 				       NULL);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 15544f262ec15b..2994b9db196ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -395,7 +395,6 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 		 */
 		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
 					       AMDGPU_GPU_PAGE_SIZE,
-					       AMDGPU_GEM_DOMAIN_VRAM,
 					       &bo, NULL))
 			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
 

base-commit: 84abaa3a855571ebd4e57a7249b867a2fa3763da
-- 
2.39.0

