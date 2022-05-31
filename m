Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3FC6C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 31 May 2022 08:34:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E95810F9D7;
	Tue, 31 May 2022 08:34:50 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9EE6610F9CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 May 2022 08:34:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6YbPrldlayjaRGqufAocD1ODNjMz0XYdS94DQqyOkq1pGJhmbycaQ2dngTThHymtv5swzAvCLdxX5KtiyIioGU0sBAJpTPPKL9c1KoQ6sIOLpdHVhfXTecxSRNbmIqQ6R67t2a3XUiCC4p8xKX+Std5bBIM3eH1CE4f4Fefc5yXKiPNltC7kpsvCf2OA0Xh7Kkh24dQDqa4l4FWiZQwtyjqObOuN6Rq55wzEzAD7Lvwmv/A+ToRuiba6ESwNsk6j/CjeF8Ryf1vs8LVjF4NK/RkNt5cq95anZy5PHj5zf5NRz5UgpGNOkbyY+clzTMdMPjXcmoje1ZA/mwYVd2DTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LKsQyorirMA+kAxIIzP4AGTrh8rWG7jwiKB+0x7XsM=;
 b=BUxilPhxj9yah6s0O8t5Da5i8qp592w93ZAnFM5Ii0M4kWLUxb0+HjaIJ1GSnzRRvd+iJ7BgTLUcDEy40Hp9vNJuU6TYxERTXz3EtTM7WvVet7bB0TzkCRGa78F8qok7qQXnGtEyX2k3mcKPFBeR70fpU0o7In1yODXyv5dJG6Xdsfcez226M0oP3HJPrpEBpbuOwKnjc7Kd/rwJE76LxIcFzgCurQRM5Zf40dBb8/s2Z5Uzt5nIU6hfam1JzOYhFft41ZDGMOMmpwC9Y6Wh0Eff3CBAFCXcQSHe39sZXVfkpgOrAO/XG1RQemwocxrH6wxH5Svofh0PKZ7ippY72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LKsQyorirMA+kAxIIzP4AGTrh8rWG7jwiKB+0x7XsM=;
 b=REgoSqMOnr0f/iDKErkT+juxUrKFg0MbnJ4rmB6ix2PnNybYmECUdv/rta/8xgR2NdWUWVrij3JnL9ykClLp7O8lCS1dq1crnqAPnQUuOKKxfbzrdcyNyVcyN83NTo+n4O4NsyK1Xt+DUHAwxMVs2AGxlBjx77Phr1wNa8RigUA=
Received: from DS7PR05CA0076.namprd05.prod.outlook.com (2603:10b6:8:57::13) by
 BL3PR12MB6643.namprd12.prod.outlook.com (2603:10b6:208:38f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Tue, 31 May
 2022 08:34:45 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::f6) by DS7PR05CA0076.outlook.office365.com
 (2603:10b6:8:57::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.5 via Frontend
 Transport; Tue, 31 May 2022 08:34:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Tue, 31 May 2022 08:34:45 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 31 May
 2022 03:34:43 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: add pinned BOs to kfd_bo_list
Date: Tue, 31 May 2022 16:34:21 +0800
Message-ID: <20220531083421.1670792-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e8676edc-15d7-4a7b-f55d-08da42e06aae
X-MS-TrafficTypeDiagnostic: BL3PR12MB6643:EE_
X-Microsoft-Antispam-PRVS: <BL3PR12MB66433293FBBEF40296E0303DFBDC9@BL3PR12MB6643.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbc6kLQ+z8IuaiOPK11+9DkWFzFq9Cm8iaORgDoXvYPeZH/z4CuDe8mIA5UjClgSlQFcRwZQX3rxH5zrKvP5NHl/FD3gdEhdedB+HcM/VbyZeEbd+gHszEpCivlINF70EulTabbNtYuLQJYp8/2++QAWTvi1bcGV78GHx6LJ3TqY/zU/tk/Xt3bCE8+FSgljFBt5b01fGQ79RxvVgh51To7qM4HT+ScVep2X/Y4psvupaFJDF+GtFpGbfc0Py5F6ZXE324pz8v6KZiSxXB3XGBfQfdQebbOAa2KwxA77HAGap3nrMQyiOalu4Juej7/TYVNcwzY9fxCBjkyr8Vk6FAljYxoYc+6/kFQT9NKxeF/53EcMdChtP4n4bQGi9OpNLM0U++1ATch3hg0YF3hSzIErkH6lheVGIjRZ0uymevQmXNHKqcp9YxajCKx+Obc+vFBC31R9Jeu6K3lzuH6lmTD9YbbPJUBmkuwtuiH5MXoUqiwA5oDt5wr0EzlI4ZfQGQVtN31QL6cZdhEK7N4wfQltwPc6wLLaYf1TBQWxqxuU7mff0B0RgVYugytFhs2NaPfrMEj3L81sFTUyqY8qKJXJdpynRmySjEj7Q6Zg+QsHBudnot9CJ2WQv+VZY+ZQap1wO9libdddoG/oQ5BPx2b/WkuIl/AuqMeNeH8E6E1Jr6+VFmnMWBz05eb7dIG9OJ8Okxau+HddkYGzM8TLdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(8936002)(86362001)(1076003)(26005)(5660300002)(83380400001)(508600001)(2616005)(40460700003)(6666004)(336012)(2906002)(7696005)(186003)(16526019)(81166007)(426003)(47076005)(70586007)(70206006)(82310400005)(4326008)(8676002)(36756003)(36860700001)(54906003)(356005)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2022 08:34:45.5055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8676edc-15d7-4a7b-f55d-08da42e06aae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6643
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Huang
 Rui <ray.huang@amd.com>, Lang Yu <Lang.Yu@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The kfd_bo_list is used to restore process BOs after
evictions. As page tables could be destroyed during
evictions, we should also update pinned BOs' page tables
during restoring to make sure they are valid.

So for pinned BOs,
1, Don't validate them, but update their page tables.
2, Don't add eviction fence for them.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 34ba9e776521..67c4bf1944d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1953,9 +1953,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 		return -EINVAL;
 	}
 
-	/* delete kgd_mem from kfd_bo_list to avoid re-validating
-	 * this BO in BO's restoring after eviction.
-	 */
 	mutex_lock(&mem->process_info->lock);
 
 	ret = amdgpu_bo_reserve(bo, true);
@@ -1978,7 +1975,6 @@ int amdgpu_amdkfd_gpuvm_map_gtt_bo_to_kernel(struct amdgpu_device *adev,
 
 	amdgpu_amdkfd_remove_eviction_fence(
 		bo, mem->process_info->eviction_fence);
-	list_del_init(&mem->validate_list.head);
 
 	if (size)
 		*size = amdgpu_bo_size(bo);
@@ -2481,24 +2477,26 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 		uint32_t domain = mem->domain;
 		struct kfd_mem_attachment *attachment;
 
-		total_size += amdgpu_bo_size(bo);
+		if (!bo->tbo.pin_count) {
+			total_size += amdgpu_bo_size(bo);
 
-		ret = amdgpu_amdkfd_bo_validate(bo, domain, false);
-		if (ret) {
-			pr_debug("Memory eviction: Validate BOs failed\n");
-			failed_size += amdgpu_bo_size(bo);
-			ret = amdgpu_amdkfd_bo_validate(bo,
-						AMDGPU_GEM_DOMAIN_GTT, false);
+			ret = amdgpu_amdkfd_bo_validate(bo, domain, false);
+			if (ret) {
+				pr_debug("Memory eviction: Validate BOs failed\n");
+				failed_size += amdgpu_bo_size(bo);
+				ret = amdgpu_amdkfd_bo_validate(bo, AMDGPU_GEM_DOMAIN_GTT, false);
+				if (ret) {
+					pr_debug("Memory eviction: Try again\n");
+					goto validate_map_fail;
+				}
+			}
+			ret = amdgpu_sync_fence(&sync_obj, bo->tbo.moving);
 			if (ret) {
-				pr_debug("Memory eviction: Try again\n");
+				pr_debug("Memory eviction: Sync BO fence failed. Try again\n");
 				goto validate_map_fail;
 			}
 		}
-		ret = amdgpu_sync_fence(&sync_obj, bo->tbo.moving);
-		if (ret) {
-			pr_debug("Memory eviction: Sync BO fence failed. Try again\n");
-			goto validate_map_fail;
-		}
+
 		list_for_each_entry(attachment, &mem->attachments, list) {
 			if (!attachment->is_mapped)
 				continue;
@@ -2544,10 +2542,13 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence **ef)
 
 	/* Attach new eviction fence to all BOs */
 	list_for_each_entry(mem, &process_info->kfd_bo_list,
-		validate_list.head)
+		validate_list.head) {
+		if (mem->bo->tbo.pin_count)
+			continue;
+
 		amdgpu_bo_fence(mem->bo,
 			&process_info->eviction_fence->base, true);
-
+	}
 	/* Attach eviction fence to PD / PT BOs */
 	list_for_each_entry(peer_vm, &process_info->vm_list_head,
 			    vm_list_node) {
-- 
2.25.1

