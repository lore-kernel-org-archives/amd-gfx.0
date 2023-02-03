Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90999C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06DC110E8AB;
	Fri,  3 Feb 2023 19:09:41 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20602.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::602])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50B3F10E8AC
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhHVmUYwqTJ1GOFKqOG0hfWNiU3opbjYGWoZB5YVu9AWoJERyvzGoyKBQOGFYdljNn86rDfmSm2t14OLK+9UPRh/P1vVe6fcm1j1O52Dx0ic6HxKTmoEQzYDqb8IyI00nAMnb9vLH4CLYhj70SqYwBkPF5Gvr+F+NGuMd826Y+usMOgxR2IZytWzo1wEIWMxpVgWFMXGBnSynfJeoVpaU/0sUMpgEICFDfwHdjez8Lp9ay/xofTkStL6qY+23K9/jq4f38Ldozkc00nwUxdBKyWDek4VmlQTHvKbhizc0mulr2nqySmCOUHZ78ECeUAe6/rvSnf9SE4rp2uTnwuXCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKJutw2GA66HRLnkSgXjiusWsof8iVgNbpa/pFsk71Q=;
 b=IaDui7lwzlJs+lhAEstZ83U4LiePGlIUGnzZD43lT0pbz6PnLk60Ody9CQCZmYfGgeLlMczGHFoLCcm8odR0KKBAVnSDglLOmoIqZxYhmVs0Yhr7RorKjdns8I+e3oZbJKaUXcjGvNv1AcXPPNmWoNyngompBns0ivKiXeTEGvt5vy3RhSi81sGfQl1cWTbTqOYL5dxDA2KaciDLPBS1U/yhIQ4PqhzHu1nybK6pjnpB0a+OvDxmMCoauPu2Ct0MPGTiMoP8CyGHy/9JGpLEHIPxCEAmsD+RsOgUloeIG/WbNI+HY+AWipWZNMcEg82gMXRSCiN4Nk1EnX8KZWKMLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKJutw2GA66HRLnkSgXjiusWsof8iVgNbpa/pFsk71Q=;
 b=m7UHbm8MjC2GKXE23xSOqFj0yL2utTxkYAT3dteF6gkXgY8pd9BBsX6b5u1VXvp+QQyc+ERz2gWJj63SOdF4S941edraNw5tA4mDBQNM34u3L5xDzwFYhuFtTpfDFrfgPPliwLmmox9RXM3O3WZE41XRqHEi4rVXyIZth3V1+/4=
Received: from DM6PR12CA0003.namprd12.prod.outlook.com (2603:10b6:5:1c0::16)
 by BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31; Fri, 3 Feb
 2023 19:09:36 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::28) by DM6PR12CA0003.outlook.office365.com
 (2603:10b6:5:1c0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:35 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:34 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/14] drm/amdgpu: add domain info in bo_create_kernel_at
Date: Fri, 3 Feb 2023 20:08:34 +0100
Message-ID: <20230203190836.1987-18-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|BL1PR12MB5754:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2628ef-d7dc-4cbe-2875-08db061a30ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9iUopZHvh+lORGQ2Nn6ZBKTnl410EGI8LUVrdVmZBzqjkoxPhc8Vj8fLMnBhP9qZuqYELPDWnIj8hf5T5xrrB9Y60acqK/fTZZU/TxBwqwkh8wMsI0R9k4oM+OESNdGORo5Cov163idOjDgrfFuBQSrHm8xVXPrunVAXw7X/gVtksceiNEFfIi1KjzHHhIw0eWfSm36pJj5eBMGdEjTn0soOWuzlNyhiq432Ah+98nlCeHVZ09xdlMP1fDzPPdL2J3yk88zzjNfDquLBbGHUU5LcBirtYVyrRjjU6IoH83zAWGst4bfwn/8aHyLcb+I8FE9t6H3sXbRre0MaMxNlHl+YUIXRPlvhsHbtMcSJtKbKpQ3ogTTpgkK1FwQHThFZLti/IyMURjlOEkOUZzwGgl6Vl+v0PZvG/9CUSw5m6yf+TqGKjf4oNk4kOFLZOdr+rUyqNtjMh1hSCXFUN0zQR2quHpSOPEkXJWOrovLzB36j4IlXOiqWICpH31viJ0iuUS4e1hBuMmpi7ocxvzgrYaQ1jqta6BpTw7L2X6doBKWgE8TNOZqSEgBqbb4pGGzmUrNWQ6CihKYdfBh39HGAmtExyi8QXcLIe2NN3TYcwrDSjQl9FVX3jxuS8PUx9+zBAIAYdsQEajinMTD350XdbsH57hmBlaTQfBYhTV0YrMIA2D3KNZ/zXWSPORatmxqdwfzTPlyJ7Du9tQ+zRoOdWQQe6xKwxK541NNLmHFQkS4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(376002)(136003)(346002)(451199018)(40470700004)(36840700001)(46966006)(316002)(70586007)(70206006)(54906003)(4326008)(6916009)(82310400005)(8676002)(5660300002)(41300700001)(8936002)(36860700001)(82740400003)(356005)(36756003)(81166007)(86362001)(1076003)(186003)(7696005)(16526019)(26005)(44832011)(2906002)(336012)(426003)(83380400001)(40480700001)(40460700003)(47076005)(2616005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:35.9591 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2628ef-d7dc-4cbe-2875-08db061a30ca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5754
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch adds a domain input variable for amdgpu_bo_create_kernel_at,
so that it could be used for both VRAM and DOORBELL domains objects. It
also adds supporting code for existing callers.

Signed-off-by: Shashank Sharma <contactshashanksharma@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c   | 1 +
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index d9608eee0672..51743f82ed26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -367,7 +367,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
  * 0 on success, negative error code otherwise.
  */
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
-			       uint64_t offset, uint64_t size,
+			       uint64_t offset, uint64_t size, uint32_t domain,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr)
 {
 	struct ttm_operation_ctx ctx = { false, false };
@@ -378,7 +378,7 @@ int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
 	size = ALIGN(size, PAGE_SIZE);
 
 	r = amdgpu_bo_create_reserved(adev, size, PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_VRAM, bo_ptr, NULL,
+				      domain, bo_ptr, NULL,
 				      cpu_addr);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index bf9759758f0d..b2b7e55ac486 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -284,7 +284,7 @@ int amdgpu_bo_create_kernel(struct amdgpu_device *adev,
 			    u32 domain, struct amdgpu_bo **bo_ptr,
 			    u64 *gpu_addr, void **cpu_addr);
 int amdgpu_bo_create_kernel_at(struct amdgpu_device *adev,
-			       uint64_t offset, uint64_t size,
+			       uint64_t offset, uint64_t size, uint32_t domain,
 			       struct amdgpu_bo **bo_ptr, void **cpu_addr);
 int amdgpu_bo_create_user(struct amdgpu_device *adev,
 			  struct amdgpu_bo_param *bp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 95017de6b23d..e38720b91958 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1591,6 +1591,7 @@ static int amdgpu_ttm_fw_reserve_vram_init(struct amdgpu_device *adev)
 	return amdgpu_bo_create_kernel_at(adev,
 					  adev->mman.fw_vram_usage_start_offset,
 					  adev->mman.fw_vram_usage_size,
+					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.fw_vram_usage_reserved_bo,
 					  &adev->mman.fw_vram_usage_va);
 }
@@ -1616,6 +1617,7 @@ static int amdgpu_ttm_drv_reserve_vram_init(struct amdgpu_device *adev)
 	return amdgpu_bo_create_kernel_at(adev,
 					  adev->mman.drv_vram_usage_start_offset,
 					  adev->mman.drv_vram_usage_size,
+					  AMDGPU_GEM_DOMAIN_VRAM,
 					  &adev->mman.drv_vram_usage_reserved_bo,
 					  &adev->mman.drv_vram_usage_va);
 }
@@ -1696,6 +1698,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 		ret = amdgpu_bo_create_kernel_at(adev,
 					 ctx->c2p_train_data_offset,
 					 ctx->train_data_size,
+					 AMDGPU_GEM_DOMAIN_VRAM,
 					 &ctx->c2p_bo,
 					 NULL);
 		if (ret) {
@@ -1709,6 +1712,7 @@ static int amdgpu_ttm_reserve_tmr(struct amdgpu_device *adev)
 	ret = amdgpu_bo_create_kernel_at(adev,
 				adev->gmc.real_vram_size - adev->mman.discovery_tmr_size,
 				adev->mman.discovery_tmr_size,
+				AMDGPU_GEM_DOMAIN_VRAM,
 				&adev->mman.discovery_memory,
 				NULL);
 	if (ret) {
@@ -1877,18 +1881,21 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	 * avoid display artifacts while transitioning between pre-OS
 	 * and driver.  */
 	r = amdgpu_bo_create_kernel_at(adev, 0, adev->mman.stolen_vga_size,
+				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_vga_memory,
 				       NULL);
 	if (r)
 		return r;
 	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_vga_size,
 				       adev->mman.stolen_extended_size,
+				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_extended_memory,
 				       NULL);
 	if (r)
 		return r;
 	r = amdgpu_bo_create_kernel_at(adev, adev->mman.stolen_reserved_offset,
 				       adev->mman.stolen_reserved_size,
+				       AMDGPU_GEM_DOMAIN_VRAM,
 				       &adev->mman.stolen_reserved_memory,
 				       NULL);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index fc9edc3028b6..fd1f58158238 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -395,6 +395,7 @@ static void amdgpu_virt_ras_reserve_bps(struct amdgpu_device *adev)
 		 */
 		if (amdgpu_bo_create_kernel_at(adev, bp << AMDGPU_GPU_PAGE_SHIFT,
 					       AMDGPU_GPU_PAGE_SIZE,
+					       AMDGPU_GEM_DOMAIN_VRAM,
 					       &bo, NULL))
 			DRM_DEBUG("RAS WARN: reserve vram for retired page %llx fail\n", bp);
 
-- 
2.34.1

