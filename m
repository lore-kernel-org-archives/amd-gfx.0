Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF253C67871
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 08:14:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 113A210E377;
	Thu, 27 Oct 2022 08:14:52 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F26ED10E377
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 08:14:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MtQ4iYiXOu5CWEaSivamVNwEEcD0vF7++11zIy1QrJAkh+ltXi2K5R+/bl1WCZZ1xudYGzwxoxv619P9PJF/xxV5du6W1ZDpqehNtmc9L5osQBU2OH7uAnma3+Kzu0xDIVCL2hbcnQPfyMnvR1VfCuJRy9WUPJtpQ+EU6w2AJ4Tv24iK6b8OwBQafa5YzNq3wCZXcZ8X6RrqqXyvO4u7laA/pzyukSoqvnTURCQv4zD8DBnAHxwcckNr/TBltspEFrNWp1hQC1p6QJ8J7/yN/yRBbpgO0enu7Cyt6i/w7cT6Tj0epvzXuvGf+Y0FHUIQvcugbXihQ3/fd1BX24hpYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SNzTf1n3QSTdHMWUlQykw+bTQu3AaTEQ/hO7c+YhjM=;
 b=C9p9F8mF4OOtNQcvhrVB2LV+MsMOalPhFmas3nIhkmvndLCQvC4Ig3AFmliiDBUZVpI8CxTKmdj+tJ5iaJN67I4+wBK/fNwPRX2Juc62c75vO4WpKKE3UX8lcp8PTz/7y3Yo3OgbrD6wgF63CFaoQ8pO7d9e3OnI44lSi9zBu9ZrMJs6zSn2kVfvd55PUofVFegai/iXWbbfkylHYmMeubrt7Orf2pDHHxJz9PJQLGJ/zuUgO05yW9Axh960yvDEs/FAWNmwVhtFmziWaP47Q3BKSEvsEb1btGlZ42LkCCxEnH+WqrApCuCdwfFLTHxwn3bcXg2vpITN3A0eXkOfgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SNzTf1n3QSTdHMWUlQykw+bTQu3AaTEQ/hO7c+YhjM=;
 b=dDh0qiFwFXjpXzVXi6GaFWudsc/cFTCNbcDMNZgHhzMVy14tfrIODjgQ7753TOREktzN1KtzjyNy5hsfQRvpMS81dp4z5vdqYqj12mQN1rStpaoDNGJGuNYmi+ftWKFbEebtTIxJSS9xAUeWK9wYrTFY9R9+2rUsEAx96KP2huw=
Received: from BN9PR03CA0232.namprd03.prod.outlook.com (2603:10b6:408:f8::27)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14; Thu, 27 Oct
 2022 08:14:43 +0000
Received: from BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::e7) by BN9PR03CA0232.outlook.office365.com
 (2603:10b6:408:f8::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28 via Frontend
 Transport; Thu, 27 Oct 2022 08:14:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT082.mail.protection.outlook.com (10.13.176.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 27 Oct 2022 08:14:42 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 27 Oct
 2022 03:14:35 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <felix.kuehling@amd.com>,
 <alexander.deucher@amd.com>
Subject: [PATCH v3] drm/amdkfd: Fix the warning of array-index-out-of-bounds
Date: Thu, 27 Oct 2022 16:14:01 +0800
Message-ID: <20221027081402.320626-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT082:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f87eb02-bbbf-4043-42f2-08dab7f34d49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C8rJg5+B3HoqFVL6BLLgjpq4gmsqcNzuhbufttoKhMfErsceObS5YD3gvm5ujlEdR78oxBvMSoe43WbmQRGQv1liL6mTXELjwf6P2eUPn5N9xBCdKt+ppvEyraTqZ01HAlADsg0t7BckW4wNFVTilfuCsGUbC+EPouFyEF8TKgWzOOP9ITSz0sQdhaE4J8kxW9aAYZgHaA5xU1v/llvAMaeAbhsCMzgwcj68tFVhuqAG+HLS/Cxznw2Vr/bBljwKEvMyMasnvIgxGoq5ATOxwnsjG+6q8fzAL8QWs7c22so58yP1MJjLzk5q52IlR1+XYnrtn0DlchUav1IPy5fdwD9xvZWa2myJAB6fC+Qgl39TfjiluPcrSWHEIdS6KMSNMEO/hvb7qmfZHwHyyIW3rCTqhZMCp13IgoRE7r3dJusOlsVHNq20bLIBxWO+nM7BJCvGHVp42i8Sf+wGFArzIwiNRhU8dJRf5REyMktgpB4wJqX8ztClCBrFzhvFE5TLC53mwjw66EMTKPN+5NxTAd5wamSn9hftXJ6kwaCG0IMNZA+vti1gG0NFRDozV231wFHdQWszCxf5lJe+pkfjTpVhsVB/ofFhvTaTZcfCMlj7NuK7Zz7MpYyGdma1UGpjrv66tIOS+3DzNVzn+eNY/PiqUbUHwCvqFca2SOnH2M4UghGUBvJFRppC8kHpIAIeK77eQMl+7Z/ohL7q19WoDH5whHJYYcALqNFzuDljhIUvu8HGw8w3w7bExXYKC/DRGyRqDRNgc/yQEghDgo0gaKJkvsab/8MNKTcs+jUmUzZrLYbTZy4Fxql95rhP6Ohx
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(396003)(39860400002)(346002)(451199015)(46966006)(36840700001)(40470700004)(426003)(83380400001)(47076005)(81166007)(356005)(86362001)(36860700001)(82740400003)(30864003)(5660300002)(2906002)(4326008)(70586007)(70206006)(8676002)(8936002)(41300700001)(82310400005)(7696005)(40460700003)(2616005)(1076003)(186003)(26005)(336012)(16526019)(316002)(6636002)(110136005)(54906003)(6666004)(478600001)(40480700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 08:14:42.7460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f87eb02-bbbf-4043-42f2-08dab7f34d49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT082.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
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

For some GPUs with more CUs, the original sibling_map[32]

in struct crat_subtype_cache is not enough

to save the cache information when create the VCRAT table,

so skip filling the struct crat_subtype_cache info instead

fill struct kfd_cache_properties directly to fix this problem.

v3:
- Drop processor id calc function
v2:
- Remove unnecessary sys interface "cache_ext"

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 307 +++-------------------
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  12 +
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 238 ++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   5 +-
 4 files changed, 278 insertions(+), 284 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index d25ac9cbe5b2..8b7e34b45740 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -50,16 +50,6 @@ static inline unsigned int get_and_inc_gpu_processor_id(
 	return current_id;
 }
 
-/* Static table to describe GPU Cache information */
-struct kfd_gpu_cache_info {
-	uint32_t	cache_size;
-	uint32_t	cache_level;
-	uint32_t	flags;
-	/* Indicates how many Compute Units share this cache
-	 * within a SA. Value = 1 indicates the cache is not shared
-	 */
-	uint32_t	num_cu_shared;
-};
 
 static struct kfd_gpu_cache_info kaveri_cache_info[] = {
 	{
@@ -1023,9 +1013,13 @@ static int kfd_parse_subtype_cache(struct crat_subtype_cache *cache,
 			props->cachelines_per_tag = cache->lines_per_tag;
 			props->cache_assoc = cache->associativity;
 			props->cache_latency = cache->cache_latency;
+
 			memcpy(props->sibling_map, cache->sibling_map,
 					sizeof(props->sibling_map));
 
+			/* set the sibling_map_size as 32 for CRAT from ACPI */
+			props->sibling_map_size = CRAT_SIBLINGMAP_SIZE;
+
 			if (cache->flags & CRAT_CACHE_FLAGS_DATA_CACHE)
 				props->cache_type |= HSA_CACHE_TYPE_DATA;
 			if (cache->flags & CRAT_CACHE_FLAGS_INST_CACHE)
@@ -1243,124 +1237,6 @@ int kfd_parse_crat_table(void *crat_image, struct list_head *device_list,
 	return ret;
 }
 
-/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
-static int fill_in_l1_pcache(struct crat_subtype_cache *pcache,
-				struct kfd_gpu_cache_info *pcache_info,
-				struct kfd_cu_info *cu_info,
-				int mem_available,
-				int cu_bitmask,
-				int cache_type, unsigned int cu_processor_id,
-				int cu_block)
-{
-	unsigned int cu_sibling_map_mask;
-	int first_active_cu;
-
-	/* First check if enough memory is available */
-	if (sizeof(struct crat_subtype_cache) > mem_available)
-		return -ENOMEM;
-
-	cu_sibling_map_mask = cu_bitmask;
-	cu_sibling_map_mask >>= cu_block;
-	cu_sibling_map_mask &=
-		((1 << pcache_info[cache_type].num_cu_shared) - 1);
-	first_active_cu = ffs(cu_sibling_map_mask);
-
-	/* CU could be inactive. In case of shared cache find the first active
-	 * CU. and incase of non-shared cache check if the CU is inactive. If
-	 * inactive active skip it
-	 */
-	if (first_active_cu) {
-		memset(pcache, 0, sizeof(struct crat_subtype_cache));
-		pcache->type = CRAT_SUBTYPE_CACHE_AFFINITY;
-		pcache->length = sizeof(struct crat_subtype_cache);
-		pcache->flags = pcache_info[cache_type].flags;
-		pcache->processor_id_low = cu_processor_id
-					 + (first_active_cu - 1);
-		pcache->cache_level = pcache_info[cache_type].cache_level;
-		pcache->cache_size = pcache_info[cache_type].cache_size;
-
-		/* Sibling map is w.r.t processor_id_low, so shift out
-		 * inactive CU
-		 */
-		cu_sibling_map_mask =
-			cu_sibling_map_mask >> (first_active_cu - 1);
-
-		pcache->sibling_map[0] = (uint8_t)(cu_sibling_map_mask & 0xFF);
-		pcache->sibling_map[1] =
-				(uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
-		pcache->sibling_map[2] =
-				(uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
-		pcache->sibling_map[3] =
-				(uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
-		return 0;
-	}
-	return 1;
-}
-
-/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
-static int fill_in_l2_l3_pcache(struct crat_subtype_cache *pcache,
-				struct kfd_gpu_cache_info *pcache_info,
-				struct kfd_cu_info *cu_info,
-				int mem_available,
-				int cache_type, unsigned int cu_processor_id)
-{
-	unsigned int cu_sibling_map_mask;
-	int first_active_cu;
-	int i, j, k;
-
-	/* First check if enough memory is available */
-	if (sizeof(struct crat_subtype_cache) > mem_available)
-		return -ENOMEM;
-
-	cu_sibling_map_mask = cu_info->cu_bitmap[0][0];
-	cu_sibling_map_mask &=
-		((1 << pcache_info[cache_type].num_cu_shared) - 1);
-	first_active_cu = ffs(cu_sibling_map_mask);
-
-	/* CU could be inactive. In case of shared cache find the first active
-	 * CU. and incase of non-shared cache check if the CU is inactive. If
-	 * inactive active skip it
-	 */
-	if (first_active_cu) {
-		memset(pcache, 0, sizeof(struct crat_subtype_cache));
-		pcache->type = CRAT_SUBTYPE_CACHE_AFFINITY;
-		pcache->length = sizeof(struct crat_subtype_cache);
-		pcache->flags = pcache_info[cache_type].flags;
-		pcache->processor_id_low = cu_processor_id
-					 + (first_active_cu - 1);
-		pcache->cache_level = pcache_info[cache_type].cache_level;
-		pcache->cache_size = pcache_info[cache_type].cache_size;
-
-		/* Sibling map is w.r.t processor_id_low, so shift out
-		 * inactive CU
-		 */
-		cu_sibling_map_mask =
-			cu_sibling_map_mask >> (first_active_cu - 1);
-		k = 0;
-		for (i = 0; i < cu_info->num_shader_engines; i++) {
-			for (j = 0; j < cu_info->num_shader_arrays_per_engine;
-				j++) {
-				pcache->sibling_map[k] =
-				 (uint8_t)(cu_sibling_map_mask & 0xFF);
-				pcache->sibling_map[k+1] =
-				 (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
-				pcache->sibling_map[k+2] =
-				 (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
-				pcache->sibling_map[k+3] =
-				 (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
-				k += 4;
-				cu_sibling_map_mask =
-					cu_info->cu_bitmap[i % 4][j + i / 4];
-				cu_sibling_map_mask &= (
-				 (1 << pcache_info[cache_type].num_cu_shared)
-				 - 1);
-			}
-		}
-		return 0;
-	}
-	return 1;
-}
-
 #define KFD_MAX_CACHE_TYPES 6
 
 static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
@@ -1435,225 +1311,129 @@ static int kfd_fill_gpu_cache_info_from_gfx_config(struct kfd_dev *kdev,
 	return i;
 }
 
-/* kfd_fill_gpu_cache_info - Fill GPU cache info using kfd_gpu_cache_info
- * tables
- *
- *	@kdev - [IN] GPU device
- *	@gpu_processor_id - [IN] GPU processor ID to which these caches
- *			    associate
- *	@available_size - [IN] Amount of memory available in pcache
- *	@cu_info - [IN] Compute Unit info obtained from KGD
- *	@pcache - [OUT] memory into which cache data is to be filled in.
- *	@size_filled - [OUT] amount of data used up in pcache.
- *	@num_of_entries - [OUT] number of caches added
- */
-static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
-			int gpu_processor_id,
-			int available_size,
-			struct kfd_cu_info *cu_info,
-			struct crat_subtype_cache *pcache,
-			int *size_filled,
-			int *num_of_entries)
+int get_gpu_cache_info(struct kfd_dev *kdev, struct kfd_gpu_cache_info **pcache_info)
 {
-	struct kfd_gpu_cache_info *pcache_info;
 	struct kfd_gpu_cache_info cache_info[KFD_MAX_CACHE_TYPES];
 	int num_of_cache_types = 0;
-	int i, j, k;
-	int ct = 0;
-	int mem_available = available_size;
-	unsigned int cu_processor_id;
-	int ret;
-	unsigned int num_cu_shared;
 
 	switch (kdev->adev->asic_type) {
 	case CHIP_KAVERI:
-		pcache_info = kaveri_cache_info;
+		*pcache_info = kaveri_cache_info;
 		num_of_cache_types = ARRAY_SIZE(kaveri_cache_info);
 		break;
 	case CHIP_HAWAII:
-		pcache_info = hawaii_cache_info;
+		*pcache_info = hawaii_cache_info;
 		num_of_cache_types = ARRAY_SIZE(hawaii_cache_info);
 		break;
 	case CHIP_CARRIZO:
-		pcache_info = carrizo_cache_info;
+		*pcache_info = carrizo_cache_info;
 		num_of_cache_types = ARRAY_SIZE(carrizo_cache_info);
 		break;
 	case CHIP_TONGA:
-		pcache_info = tonga_cache_info;
+		*pcache_info = tonga_cache_info;
 		num_of_cache_types = ARRAY_SIZE(tonga_cache_info);
 		break;
 	case CHIP_FIJI:
-		pcache_info = fiji_cache_info;
+		*pcache_info = fiji_cache_info;
 		num_of_cache_types = ARRAY_SIZE(fiji_cache_info);
 		break;
 	case CHIP_POLARIS10:
-		pcache_info = polaris10_cache_info;
+		*pcache_info = polaris10_cache_info;
 		num_of_cache_types = ARRAY_SIZE(polaris10_cache_info);
 		break;
 	case CHIP_POLARIS11:
-		pcache_info = polaris11_cache_info;
+		*pcache_info = polaris11_cache_info;
 		num_of_cache_types = ARRAY_SIZE(polaris11_cache_info);
 		break;
 	case CHIP_POLARIS12:
-		pcache_info = polaris12_cache_info;
+		*pcache_info = polaris12_cache_info;
 		num_of_cache_types = ARRAY_SIZE(polaris12_cache_info);
 		break;
 	case CHIP_VEGAM:
-		pcache_info = vegam_cache_info;
+		*pcache_info = vegam_cache_info;
 		num_of_cache_types = ARRAY_SIZE(vegam_cache_info);
 		break;
 	default:
 		switch (KFD_GC_VERSION(kdev)) {
 		case IP_VERSION(9, 0, 1):
-			pcache_info = vega10_cache_info;
+			*pcache_info = vega10_cache_info;
 			num_of_cache_types = ARRAY_SIZE(vega10_cache_info);
 			break;
 		case IP_VERSION(9, 2, 1):
-			pcache_info = vega12_cache_info;
+			*pcache_info = vega12_cache_info;
 			num_of_cache_types = ARRAY_SIZE(vega12_cache_info);
 			break;
 		case IP_VERSION(9, 4, 0):
 		case IP_VERSION(9, 4, 1):
-			pcache_info = vega20_cache_info;
+			*pcache_info = vega20_cache_info;
 			num_of_cache_types = ARRAY_SIZE(vega20_cache_info);
 			break;
 		case IP_VERSION(9, 4, 2):
-			pcache_info = aldebaran_cache_info;
+			*pcache_info = aldebaran_cache_info;
 			num_of_cache_types = ARRAY_SIZE(aldebaran_cache_info);
 			break;
 		case IP_VERSION(9, 1, 0):
 		case IP_VERSION(9, 2, 2):
-			pcache_info = raven_cache_info;
+			*pcache_info = raven_cache_info;
 			num_of_cache_types = ARRAY_SIZE(raven_cache_info);
 			break;
 		case IP_VERSION(9, 3, 0):
-			pcache_info = renoir_cache_info;
+			*pcache_info = renoir_cache_info;
 			num_of_cache_types = ARRAY_SIZE(renoir_cache_info);
 			break;
 		case IP_VERSION(10, 1, 10):
 		case IP_VERSION(10, 1, 2):
 		case IP_VERSION(10, 1, 3):
 		case IP_VERSION(10, 1, 4):
-			pcache_info = navi10_cache_info;
+			*pcache_info = navi10_cache_info;
 			num_of_cache_types = ARRAY_SIZE(navi10_cache_info);
 			break;
 		case IP_VERSION(10, 1, 1):
-			pcache_info = navi14_cache_info;
+			*pcache_info = navi14_cache_info;
 			num_of_cache_types = ARRAY_SIZE(navi14_cache_info);
 			break;
 		case IP_VERSION(10, 3, 0):
-			pcache_info = sienna_cichlid_cache_info;
+			*pcache_info = sienna_cichlid_cache_info;
 			num_of_cache_types = ARRAY_SIZE(sienna_cichlid_cache_info);
 			break;
 		case IP_VERSION(10, 3, 2):
-			pcache_info = navy_flounder_cache_info;
+			*pcache_info = navy_flounder_cache_info;
 			num_of_cache_types = ARRAY_SIZE(navy_flounder_cache_info);
 			break;
 		case IP_VERSION(10, 3, 4):
-			pcache_info = dimgrey_cavefish_cache_info;
+			*pcache_info = dimgrey_cavefish_cache_info;
 			num_of_cache_types = ARRAY_SIZE(dimgrey_cavefish_cache_info);
 			break;
 		case IP_VERSION(10, 3, 1):
-			pcache_info = vangogh_cache_info;
+			*pcache_info = vangogh_cache_info;
 			num_of_cache_types = ARRAY_SIZE(vangogh_cache_info);
 			break;
 		case IP_VERSION(10, 3, 5):
-			pcache_info = beige_goby_cache_info;
+			*pcache_info = beige_goby_cache_info;
 			num_of_cache_types = ARRAY_SIZE(beige_goby_cache_info);
 			break;
 		case IP_VERSION(10, 3, 3):
 		case IP_VERSION(10, 3, 7): /* TODO: Double check these on production silicon */
-			pcache_info = yellow_carp_cache_info;
+			*pcache_info = yellow_carp_cache_info;
 			num_of_cache_types = ARRAY_SIZE(yellow_carp_cache_info);
 			break;
 		case IP_VERSION(10, 3, 6):
-			pcache_info = gc_10_3_6_cache_info;
+			*pcache_info = gc_10_3_6_cache_info;
 			num_of_cache_types = ARRAY_SIZE(gc_10_3_6_cache_info);
 			break;
 		case IP_VERSION(11, 0, 0):
 		case IP_VERSION(11, 0, 1):
 		case IP_VERSION(11, 0, 2):
 		case IP_VERSION(11, 0, 3):
-			pcache_info = cache_info;
+			*pcache_info = cache_info;
 			num_of_cache_types =
-				kfd_fill_gpu_cache_info_from_gfx_config(kdev, pcache_info);
+				kfd_fill_gpu_cache_info_from_gfx_config(kdev, *pcache_info);
 			break;
 		default:
 			return -EINVAL;
 		}
 	}
-
-	*size_filled = 0;
-	*num_of_entries = 0;
-
-	/* For each type of cache listed in the kfd_gpu_cache_info table,
-	 * go through all available Compute Units.
-	 * The [i,j,k] loop will
-	 *		if kfd_gpu_cache_info.num_cu_shared = 1
-	 *			will parse through all available CU
-	 *		If (kfd_gpu_cache_info.num_cu_shared != 1)
-	 *			then it will consider only one CU from
-	 *			the shared unit
-	 */
-
-	for (ct = 0; ct < num_of_cache_types; ct++) {
-	  cu_processor_id = gpu_processor_id;
-	  if (pcache_info[ct].cache_level == 1) {
-	    for (i = 0; i < cu_info->num_shader_engines; i++) {
-	      for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
-	        for (k = 0; k < cu_info->num_cu_per_sh;
-		  k += pcache_info[ct].num_cu_shared) {
-		  ret = fill_in_l1_pcache(pcache,
-					pcache_info,
-					cu_info,
-					mem_available,
-					cu_info->cu_bitmap[i % 4][j + i / 4],
-					ct,
-					cu_processor_id,
-					k);
-
-		  if (ret < 0)
-			break;
-
-		  if (!ret) {
-				pcache++;
-				(*num_of_entries)++;
-				mem_available -= sizeof(*pcache);
-				(*size_filled) += sizeof(*pcache);
-		  }
-
-		  /* Move to next CU block */
-		  num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
-					cu_info->num_cu_per_sh) ?
-					pcache_info[ct].num_cu_shared :
-					(cu_info->num_cu_per_sh - k);
-		  cu_processor_id += num_cu_shared;
-		}
-	      }
-	    }
-	  } else {
-			ret = fill_in_l2_l3_pcache(pcache,
-				pcache_info,
-				cu_info,
-				mem_available,
-				ct,
-				cu_processor_id);
-
-			if (ret < 0)
-				break;
-
-			if (!ret) {
-				pcache++;
-				(*num_of_entries)++;
-				mem_available -= sizeof(*pcache);
-				(*size_filled) += sizeof(*pcache);
-			}
-	  }
-	}
-
-	pr_debug("Added [%d] GPU cache entries\n", *num_of_entries);
-
-	return 0;
+	return num_of_cache_types;
 }
 
 static bool kfd_ignore_crat(void)
@@ -2224,8 +2004,6 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	struct kfd_cu_info cu_info;
 	int avail_size = *size;
 	uint32_t total_num_of_cu;
-	int num_of_cache_entries = 0;
-	int cache_mem_filled = 0;
 	uint32_t nid = 0;
 	int ret = 0;
 
@@ -2326,31 +2104,12 @@ static int kfd_create_vcrat_image_gpu(void *pcrat_image,
 	crat_table->length += sizeof(struct crat_subtype_memory);
 	crat_table->total_entries++;
 
-	/* TODO: Fill in cache information. This information is NOT readily
-	 * available in KGD
-	 */
-	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-		sub_type_hdr->length);
-	ret = kfd_fill_gpu_cache_info(kdev, cu->processor_id_low,
-				avail_size,
-				&cu_info,
-				(struct crat_subtype_cache *)sub_type_hdr,
-				&cache_mem_filled,
-				&num_of_cache_entries);
-
-	if (ret < 0)
-		return ret;
-
-	crat_table->length += cache_mem_filled;
-	crat_table->total_entries += num_of_cache_entries;
-	avail_size -= cache_mem_filled;
-
 	/* Fill in Subtype: IO_LINKS
 	 *  Only direct links are added here which is Link from GPU to
 	 *  its NUMA node. Indirect links are added by userspace.
 	 */
 	sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-		cache_mem_filled);
+		sub_type_hdr->length);
 	ret = kfd_fill_gpu_direct_io_link_to_cpu(&avail_size, kdev,
 		(struct crat_subtype_iolink *)sub_type_hdr, proximity_domain);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index fbb5f6c32ef5..bfd3cdeff608 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -317,6 +317,18 @@ struct cdit_header {
 
 struct kfd_dev;
 
+/* Static table to describe GPU Cache information */
+struct kfd_gpu_cache_info {
+	uint32_t	cache_size;
+	uint32_t	cache_level;
+	uint32_t	flags;
+	/* Indicates how many Compute Units share this cache
+	 * within a SA. Value = 1 indicates the cache is not shared
+	 */
+	uint32_t	num_cu_shared;
+};
+int get_gpu_cache_info(struct kfd_dev *kdev, struct kfd_gpu_cache_info **pcache_info);
+
 #ifdef CONFIG_ACPI
 int kfd_create_crat_image_acpi(void **crat_image, size_t *size);
 #endif
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index e0680d265a66..dc231e248258 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -387,7 +387,6 @@ static ssize_t kfd_cache_show(struct kobject *kobj, struct attribute *attr,
 
 	/* Making sure that the buffer is an empty string */
 	buffer[0] = 0;
-
 	cache = container_of(attr, struct kfd_cache_properties, attr);
 	if (cache->gpu && kfd_devcgroup_check_permission(cache->gpu))
 		return -EPERM;
@@ -402,12 +401,13 @@ static ssize_t kfd_cache_show(struct kobject *kobj, struct attribute *attr,
 	sysfs_show_32bit_prop(buffer, offs, "association", cache->cache_assoc);
 	sysfs_show_32bit_prop(buffer, offs, "latency", cache->cache_latency);
 	sysfs_show_32bit_prop(buffer, offs, "type", cache->cache_type);
+
 	offs += snprintf(buffer+offs, PAGE_SIZE-offs, "sibling_map ");
-	for (i = 0; i < CRAT_SIBLINGMAP_SIZE; i++)
+	for (i = 0; i < cache->sibling_map_size; i++)
 		for (j = 0; j < sizeof(cache->sibling_map[0])*8; j++)
 			/* Check each bit */
 			offs += snprintf(buffer+offs, PAGE_SIZE-offs, "%d,",
-					 (cache->sibling_map[i] >> j) & 1);
+						(cache->sibling_map[i] >> j) & 1);
 
 	/* Replace the last "," with end of line */
 	buffer[offs-1] = '\n';
@@ -1721,6 +1721,217 @@ static void kfd_topology_set_capabilities(struct kfd_topology_device *dev)
 		dev->node_props.capability |= HSA_CAP_TRAP_DEBUG_FIRMWARE_SUPPORTED;
 }
 
+
+/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
+static int fill_in_l1_pcache(struct kfd_cache_properties **props_ext,
+				struct kfd_gpu_cache_info *pcache_info,
+				struct kfd_cu_info *cu_info,
+				int cu_bitmask,
+				int cache_type, unsigned int cu_processor_id,
+				int cu_block)
+{
+	unsigned int cu_sibling_map_mask;
+	int first_active_cu;
+	struct kfd_cache_properties *pcache = NULL;
+
+	cu_sibling_map_mask = cu_bitmask;
+	cu_sibling_map_mask >>= cu_block;
+	cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
+	first_active_cu = ffs(cu_sibling_map_mask);
+
+	/* CU could be inactive. In case of shared cache find the first active
+	 * CU. and incase of non-shared cache check if the CU is inactive. If
+	 * inactive active skip it
+	 */
+	if (first_active_cu) {
+		pcache = kfd_alloc_struct(pcache);
+		if (!pcache)
+			return -ENOMEM;
+
+		memset(pcache, 0, sizeof(struct kfd_cache_properties));
+		pcache->processor_id_low = cu_processor_id + (first_active_cu - 1);
+		pcache->cache_level = pcache_info[cache_type].cache_level;
+		pcache->cache_size = pcache_info[cache_type].cache_size;
+
+		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
+			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
+		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_INST_CACHE)
+			pcache->cache_type |= HSA_CACHE_TYPE_INSTRUCTION;
+		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_CPU_CACHE)
+			pcache->cache_type |= HSA_CACHE_TYPE_CPU;
+		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_SIMD_CACHE)
+			pcache->cache_type |= HSA_CACHE_TYPE_HSACU;
+
+		/* Sibling map is w.r.t processor_id_low, so shift out
+		 * inactive CU
+		 */
+		cu_sibling_map_mask =
+			cu_sibling_map_mask >> (first_active_cu - 1);
+
+		pcache->sibling_map[0] = (uint8_t)(cu_sibling_map_mask & 0xFF);
+		pcache->sibling_map[1] =
+				(uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
+		pcache->sibling_map[2] =
+				(uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
+		pcache->sibling_map[3] =
+				(uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
+
+		pcache->sibling_map_size = 4;
+		*props_ext = pcache;
+
+		return 0;
+	}
+	return 1;
+}
+
+/* Helper function. See kfd_fill_gpu_cache_info for parameter description */
+static int fill_in_l2_l3_pcache(struct kfd_cache_properties **props_ext,
+				struct kfd_gpu_cache_info *pcache_info,
+				struct kfd_cu_info *cu_info,
+				int cache_type, unsigned int cu_processor_id)
+{
+	unsigned int cu_sibling_map_mask;
+	int first_active_cu;
+	int i, j, k;
+	struct kfd_cache_properties *pcache = NULL;
+
+	cu_sibling_map_mask = cu_info->cu_bitmap[0][0];
+	cu_sibling_map_mask &=
+		((1 << pcache_info[cache_type].num_cu_shared) - 1);
+	first_active_cu = ffs(cu_sibling_map_mask);
+
+	/* CU could be inactive. In case of shared cache find the first active
+	 * CU. and incase of non-shared cache check if the CU is inactive. If
+	 * inactive active skip it
+	 */
+	if (first_active_cu) {
+		pcache = kfd_alloc_struct(pcache);
+		if (!pcache)
+			return -ENOMEM;
+
+		memset(pcache, 0, sizeof(struct kfd_cache_properties));
+		pcache->processor_id_low = cu_processor_id
+					+ (first_active_cu - 1);
+		pcache->cache_level = pcache_info[cache_type].cache_level;
+		pcache->cache_size = pcache_info[cache_type].cache_size;
+
+		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_DATA_CACHE)
+			pcache->cache_type |= HSA_CACHE_TYPE_DATA;
+		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_INST_CACHE)
+			pcache->cache_type |= HSA_CACHE_TYPE_INSTRUCTION;
+		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_CPU_CACHE)
+			pcache->cache_type |= HSA_CACHE_TYPE_CPU;
+		if (pcache_info[cache_type].flags & CRAT_CACHE_FLAGS_SIMD_CACHE)
+			pcache->cache_type |= HSA_CACHE_TYPE_HSACU;
+
+		/* Sibling map is w.r.t processor_id_low, so shift out
+		 * inactive CU
+		 */
+		cu_sibling_map_mask = cu_sibling_map_mask >> (first_active_cu - 1);
+		k = 0;
+
+		for (i = 0; i < cu_info->num_shader_engines; i++) {
+			for (j = 0; j < cu_info->num_shader_arrays_per_engine; j++) {
+				pcache->sibling_map[k] = (uint8_t)(cu_sibling_map_mask & 0xFF);
+				pcache->sibling_map[k+1] = (uint8_t)((cu_sibling_map_mask >> 8) & 0xFF);
+				pcache->sibling_map[k+2] = (uint8_t)((cu_sibling_map_mask >> 16) & 0xFF);
+				pcache->sibling_map[k+3] = (uint8_t)((cu_sibling_map_mask >> 24) & 0xFF);
+				k += 4;
+
+				cu_sibling_map_mask = cu_info->cu_bitmap[i % 4][j + i / 4];
+				cu_sibling_map_mask &= ((1 << pcache_info[cache_type].num_cu_shared) - 1);
+			}
+		}
+		pcache->sibling_map_size = k;
+		*props_ext = pcache;
+		return 0;
+	}
+	return 1;
+}
+
+/* kfd_fill_cache_non_crat_info - Fill GPU cache info using kfd_gpu_cache_info
+ * tables
+ */
+void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct kfd_dev *kdev)
+{
+	struct kfd_gpu_cache_info *pcache_info = NULL;
+	int i, j, k;
+	int ct = 0;
+	unsigned int cu_processor_id;
+	int ret;
+	unsigned int num_cu_shared;
+	struct kfd_cu_info cu_info;
+	struct kfd_cu_info *pcu_info;
+	int gpu_processor_id;
+	struct kfd_cache_properties *props_ext;
+	int num_of_entries = 0;
+	int num_of_cache_types = 0;
+
+	amdgpu_amdkfd_get_cu_info(kdev->adev, &cu_info);
+	pcu_info = &cu_info;
+
+	gpu_processor_id = dev->node_props.simd_id_base;
+
+	num_of_cache_types = get_gpu_cache_info(kdev, &pcache_info);
+	if (!num_of_cache_types) {
+		pr_warn("no cache info found\n");
+		return;
+	}
+
+	/* For each type of cache listed in the kfd_gpu_cache_info table,
+	 * go through all available Compute Units.
+	 * The [i,j,k] loop will
+	 *		if kfd_gpu_cache_info.num_cu_shared = 1
+	 *			will parse through all available CU
+	 *		If (kfd_gpu_cache_info.num_cu_shared != 1)
+	 *			then it will consider only one CU from
+	 *			the shared unit
+	 */
+	for (ct = 0; ct < num_of_cache_types; ct++) {
+		cu_processor_id = gpu_processor_id;
+		if (pcache_info[ct].cache_level == 1) {
+			for (i = 0; i < pcu_info->num_shader_engines; i++) {
+				for (j = 0; j < pcu_info->num_shader_arrays_per_engine; j++) {
+					for (k = 0; k < pcu_info->num_cu_per_sh; k += pcache_info[ct].num_cu_shared) {
+
+						ret = fill_in_l1_pcache(&props_ext, pcache_info, pcu_info,
+										pcu_info->cu_bitmap[i % 4][j + i / 4], ct,
+										cu_processor_id, k);
+
+						if (ret < 0)
+							break;
+
+						if (!ret) {
+							num_of_entries++;
+							list_add_tail(&props_ext->list, &dev->cache_props);
+						}
+
+						/* Move to next CU block */
+						num_cu_shared = ((k + pcache_info[ct].num_cu_shared) <=
+							pcu_info->num_cu_per_sh) ?
+							pcache_info[ct].num_cu_shared :
+							(pcu_info->num_cu_per_sh - k);
+						cu_processor_id += num_cu_shared;
+					}
+				}
+			}
+		} else {
+			ret = fill_in_l2_l3_pcache(&props_ext, pcache_info,
+								pcu_info, ct, cu_processor_id);
+
+			if (ret < 0)
+				break;
+
+			if (!ret) {
+				num_of_entries++;
+				list_add_tail(&props_ext->list, &dev->cache_props);
+			}
+		}
+	}
+	dev->node_props.caches_count += num_of_entries;
+	pr_debug("Added [%d] GPU cache entries\n", num_of_entries);
+}
+
 int kfd_topology_add_device(struct kfd_dev *gpu)
 {
 	uint32_t gpu_id;
@@ -1759,6 +1970,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 			topology_crat_proximity_domain--;
 			return res;
 		}
+
 		res = kfd_parse_crat_table(crat_image,
 					   &temp_topology_device_list,
 					   proximity_domain);
@@ -1771,23 +1983,31 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 
 		kfd_topology_update_device_list(&temp_topology_device_list,
 			&topology_device_list);
+		up_write(&topology_lock);
+
+		dev = kfd_assign_gpu(gpu);
+		if (WARN_ON(!dev)) {
+			res = -ENODEV;
+			goto err;
+		}
+
+		down_write(&topology_lock);
+
+		/* Fill the cache affinity information here for the GPUs
+		 * using VCRAT
+		 */
+		kfd_fill_cache_non_crat_info(dev, gpu);
 
 		/* Update the SYSFS tree, since we added another topology
 		 * device
 		 */
 		res = kfd_topology_update_sysfs();
 		up_write(&topology_lock);
-
 		if (!res)
 			sys_props.generation_count++;
 		else
 			pr_err("Failed to update GPU (ID: 0x%x) to sysfs topology. res=%d\n",
 						gpu_id, res);
-		dev = kfd_assign_gpu(gpu);
-		if (WARN_ON(!dev)) {
-			res = -ENODEV;
-			goto err;
-		}
 	}
 
 	dev->gpu_id = gpu_id;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index dc4e239c8f8f..3e8ac87f0ac9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -87,6 +87,8 @@ struct kfd_mem_properties {
 	struct attribute	attr_used;
 };
 
+#define CACHE_SIBLINGMAP_SIZE 64
+
 struct kfd_cache_properties {
 	struct list_head	list;
 	uint32_t		processor_id_low;
@@ -97,10 +99,11 @@ struct kfd_cache_properties {
 	uint32_t		cache_assoc;
 	uint32_t		cache_latency;
 	uint32_t		cache_type;
-	uint8_t			sibling_map[CRAT_SIBLINGMAP_SIZE];
+	uint8_t			sibling_map[CACHE_SIBLINGMAP_SIZE];
 	struct kfd_dev		*gpu;
 	struct kobject		*kobj;
 	struct attribute	attr;
+	uint32_t		sibling_map_size;
 };
 
 struct kfd_iolink_properties {
-- 
2.25.1

