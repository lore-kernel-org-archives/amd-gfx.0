Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AB5C6379F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C26A710E8AC;
	Fri,  3 Feb 2023 19:09:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C5A210E8A9
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=abqo31Io5jxKpwjlPnurbJO+JXx2aDK76noXrEPXg60w9vLzwCvxHK0XiuEJFqXIkrQ7qXaIX5dHTQAKe6pQKOCM2A3zgusztAcWNrsZxnWvLW2qE1/1TvK9E5ydfXMdgydo4xLBNZDZDeZ2e2g53zhSYahpfOb2BZuD+yamCvZ9J4lufWAnoXuZPHPZwtBfeJdDFmHb9gATgbed3tT7VVR8aaYi/m6010itAjFgz6UpwEQs4HIMczq76i0rz611GEzsr2C0mSg0AITqBFjLvZ++wXWX3yYxuJ0a7hofpjz1NKB6zKq4wLP5uEk/N/7ALPxM8KwNrV2dDKLhPJzNCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gTs1ErLyvLZci068pwT0elV8YqdmG8grg8fGJlKfFrM=;
 b=Dca4LZYMduh6skRzE2fhtDhsXz7CE+cm+zVmW8G4jhY5T1WoqZyZ2kB3zn+h4V7yw46+Moze0ugTloC8mTW5nLeeBy5HApz7gZaa+ePlirI3lPHsyM7XrfsXef+UDl5rQVyVbNtBk+mv1SjvcTTQ97y/FAAfE1HdAFzPOBV9rNEoTymzg1QlTYdMh//pnVVPCqweRevKOktijunlXSPS2IRnKA0+2mTkLb7xSxzoSt17eZhiownQgBcR2HHQzXCQWoe+Dpw3aq0c3ZWnUcC2dP3mTJWcLnrMePKNFj21sGtfedolJi3hXfmgNIH4t4NMVs01GxBwBSgECZ/MqPcXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTs1ErLyvLZci068pwT0elV8YqdmG8grg8fGJlKfFrM=;
 b=arPYAXAEPQLIV7OhO2qf87SnHxII1T/FNlBWw0PS2dmd+S7wmK5wrV8Lkp0a6geRVmN16SrRXjZZzMy+gpwthi3dRBlsLA1MQssJdCyII2DGustocGeByxWGkqstJ9sEIGGTjju0oBn7HxyTrRgXNsBC+lVixEp/Y3/dXLiXH7Y=
Received: from DM6PR12CA0021.namprd12.prod.outlook.com (2603:10b6:5:1c0::34)
 by DM4PR12MB5721.namprd12.prod.outlook.com (2603:10b6:8:5c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.27; Fri, 3 Feb
 2023 19:09:33 +0000
Received: from CY4PEPF0000B8E8.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::13) by DM6PR12CA0021.outlook.office365.com
 (2603:10b6:5:1c0::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.29 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8E8.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:33 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:31 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amdgpu: add domain info in bo_create_kernel_at
Date: Fri, 3 Feb 2023 20:08:32 +0100
Message-ID: <20230203190836.1987-16-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8E8:EE_|DM4PR12MB5721:EE_
X-MS-Office365-Filtering-Correlation-Id: f16e6dde-0a5c-4b1d-c71f-08db061a2f40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pMQMdott0ZrqU/gaGBeD9mqfptCqsGRq0xhnzqOgJRPSquvQeg9YIj9JdqdrDxhMKcit/fC0QugkJGGv0IAkTL4s5AkV7h0lqOvz3jJe68sfzBpOLUqRKIBkCrC2Bah980rB1jGQpT7IUAJSqHUZu1sxs6GjYztFBHx+GUXXDXu05DWJrqQJ2XyHCHjucTjRq2EQxwxvXtQ+XgjGSp9g6FT5HG6X0fc7Oht5EK/voZihd60N/UiigsMWe1oYJNgZQpQ35ldTXzUoSJXZKM9kdopAi2Pa9LPJkZ71rQe2gR2AAnF8sgVJe9SeNUPjHORt+jeeysitqvdD/TIhuw6OBnh9JzZgn/UwaC9gYfSMjsINi2mwbIjSROJJedO95+LoEpBpLg0AJfE7/BHpGTLrW3UmpipXYRKLArMNhccoKJ8do23VvpBlrFHYT+PAj4vFEs47lTaK+GQI+MNGjzqmH+1gn6dFfr25QnjZDM6FexZ/iRFF0sx/ENUl7r2A0Lueciz/IAwS+9TxwLB9EobdzXYdWXErk6Ocnd+28pdUPWAe3Bvb4s1RjoatOJay2RhQtpaRsXjKKlyb0LztOSS7owsAdd3j6EQwH8dtxz086AYRHHZgnBLPq5XRF87S/v/eoWyWQKls2d0rOvxPRBggEggBYK3pfjRFb/TE/Z5UFo1WtpZm3TSnBsB3phDAdxm3JzIW3YkSYiXmPexBtoLgF9jgeaD7HDeTcRA93YFHsVg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(136003)(346002)(396003)(451199018)(40470700004)(46966006)(36840700001)(82310400005)(186003)(16526019)(1076003)(82740400003)(36860700001)(83380400001)(336012)(44832011)(36756003)(2906002)(40460700003)(26005)(478600001)(7696005)(81166007)(70206006)(70586007)(426003)(86362001)(47076005)(41300700001)(2616005)(8676002)(6916009)(356005)(40480700001)(4326008)(316002)(54906003)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:33.3654 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f16e6dde-0a5c-4b1d-c71f-08db061a2f40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5721
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
index ef1f3106bc69..dec391fa42dc 100644
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
index 08355f981313..4cec90debe46 100644
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
@@ -1816,18 +1820,21 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
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

