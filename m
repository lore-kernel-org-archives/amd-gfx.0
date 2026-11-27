Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9C6606A31E
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 10:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cH0YfBK5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370BC10E57F;
	Fri, 27 Nov 2026 10:19:30 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6540610E698
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 10:19:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pgum6OK8/hMejvrMdiwW5NeP2ZLCPz+waV/cn2Qo6AcDms4gO5leTrZQ4Z24hzuolDw0d0TEVvM7kfD+V7edPbn9fgS+ypN2OLxmIY4D7A3hdCQv2su8Sxo7K8p0PlUOGuv9uUTV5sK2jQxOlv1XiXSXUZ+QvPXMs1AcPgg8ioeX3+a3kahc6D1OfapXjvmTQUZmnC+eZiRIe3VfWU9p8xuX4SwGGuol054DgJX1RxY5V9CF+oCwwKFuPYpNWvVIVFQuUHLqAVKJZCCu4CQ2XjU+yoeeqw8acalwQyubMA4DlsyEx7YPSi1C+eGc/cnYpMsDv0YM3HM97A4Zdjviwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XxT1/thzARcTH8u+Go1jOaUfZAVTx1SVsRZwt9acrjQ=;
 b=OEt00wN7I84BfhtHVKeiNirwN1EAmEIaogSVc+5hYZDRP9ukrzfFzwn1McL9kIInrTdJw/n6B3icIPe6nzecGUkWCrn/C3pfIq9V9uzWrIwL0b4fC1JNEaiEw6xhBsj99tHFjOUKAGUUxyMOmML8bZd8AHqMyzZeazAFIuS798PFZkfGKkL54p+DgLykpqdcVhDSdUqbdG0gaPRUtve2JR+yne/I+3dQb74EwdPXlpvbk85gXbahao+pwBjVJ88kRFP47kkIrauKd8f6DpL+3tUSdilWtDl9idkAOpKQj8+d2TRPnh/u/MaDv+Hjo9VKmiYTUjUDtyCkG2dD4t6t8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XxT1/thzARcTH8u+Go1jOaUfZAVTx1SVsRZwt9acrjQ=;
 b=cH0YfBK5m9o443UaUs/P1gHJS447qH4qRK4fDPcFP9TwZscwdG5YBQk8L79GPZIh2OSw84yH+bZuoso6Ojyqu65ZKZDJWtbEhswtI4U3uCI+EuaTM0Gj3imNMB7XUfQMDqeyTY5r7ekowcqspA8GSOtyA/qK19H6VUhBw3lpErk=
Received: from SJ2P221CA0008.NAMP221.PROD.OUTLOOK.COM (2603:10b6:a03:5db::11)
 by IA0PR12MB8984.namprd12.prod.outlook.com (2603:10b6:208:492::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 10:19:19 +0000
Received: from PH5PEPF0000002D.namprd04.prod.outlook.com
 (2603:10b6:a03:5db:cafe::72) by SJ2P221CA0008.outlook.office365.com
 (2603:10b6:a03:5db::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.10 via Frontend Transport; Fri,
 27 Nov 2026 10:19:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH5PEPF0000002D.mail.protection.outlook.com (10.167.243.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Fri, 27 Nov 2026 10:19:18 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 27 Nov
 2026 04:19:18 -0600
Received: from rtgbeta01.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Fri, 27 Nov 2026 04:19:15 -0600
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, Strahinja Stamenkovic
 <strahinja.stamenkovic@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
CC: Priya Hosur <Priya.Hosur@amd.com>, Pratik Vishwakarma
 <Pratik.Vishwakarma@amd.com>, Veerabadhran Gopalakrishnan
 <Veerabadhran.Gopalakrishnan@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: bound the APU GTT pool size by KFD's
 system memory limit
Date: Fri, 27 Nov 2026 15:49:08 +0530
Message-ID: <20261127101908.8313-3-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127082854.112025-1-Priya.Hosur@amd.com>
References: <20261127082854.112025-1-Priya.Hosur@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH5PEPF0000002D:EE_|IA0PR12MB8984:EE_
X-MS-Office365-Filtering-Correlation-Id: ca37997f-3706-4494-604f-08df4c6fe5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|82310400026|376014|10067099003|56012099006|261022105027099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: yofeOpP3N91VKkqurgqlTo8UQVLDC/ra5ZW8YSFrGtPrkY4cBSDEEofcQXO83SuOFw0rOi2dWL+66HjA7+M3yQeG/4/vuebBr4dIIub4f+GhAWoQTiZoWHxJVJK76vn30leWenllF8LPvIy/1hE4/W9qjBgJG7gAEgnorVAz41KdxfQb86oozAfEnHvR8jowDh7/pXEWWQgBxwv4s6ExMCRrmUjW7P/fnJEWIMiUsI/fI4/fzvAEDM87fsfUbyMyINpQfxMpvAlIj3EsaCXg81tNPEgc71GvAxsgAlzJyvFMrkl6XGeqgWV2RL8QqPDz0InH8uMjJBFRaljxT/QNukfe+i2Wb3RBtwurwATjwneNrw/DlLCR6ej1eddzZ9HxXYTEBeCV4Yd/0rmOCZu/Gujt/r7jDBXBLPx4OJJJwij3laTjkM9Ub+oN4dvDQi+xYFpSR7qdE9ljZLnMFN5KhhRfh/YYjfVz6w9xVRVGbFBbknsUkM9bbrAGM8/WXKso9zA1Z7m810mlTqAGvU6uk7HQAwM1Y9m3NV3ATfQH9EhQegcW1kCdsvL0MSdA+jsQf1oxMAdnt+cZkSfTcu8bwAphvjniDBy3lcqpbu9QlyumLd84fgOkU8ARfk2aatc/X4ST5fuVaIOETgq1YpF99YRAs3yp9VdqMtpxoo+AWmrw/0k28v+aEf4nJBDGFLT9ulTtYCXcecpfNkbBOU/6yg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(82310400026)(376014)(10067099003)(56012099006)(261022105027099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iPdoCt7OW7P6C/rCMZYyIK5l367eNG1z9NQHE3NkXQzGxvQvFE/J+3wmij1JPAQ9L3M9nRzjvB1Gcc1shOzpNwJpXUA++NVVnomGQmbXcApD5gSaBWkfdu12mW1fpShQmfpWsJSYsNQJWnu1/9cZfrsTJYxZNrjwpn/Z7uxJbNgFUSR3gIdJ+6ROBEukklY7aEJ+ZZmAdk1XyU4SD52njhWYETKGULZxqg1J9VXZ5JG/8DWOSoeQJKhDVrpaAUJGlFDwOlh+VR9ns1ATbwq74od/i1vOloGZDGhoSPBUcg/S+5Y53UglTpR15dUNSIqP2MwU09YiEOzyqg/TFn2L2ILjwXSk/Y9hy8ea91RrcefIDJ7q8EiG+bieJndj5Zd+FiXEUV5EIOrpER9Hx32pPBZvtmLBv8eslXbHXCgLY6loKXBkFanpZ5+p1rLmjMv8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:19:18.7155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca37997f-3706-4494-604f-08df4c6fe5a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH5PEPF0000002D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8984
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With apu_prefer_gtt, KFD reports ttm_tt_pages_limit() as the local
memory size, which HIP exposes as the device's total memory. TTM may
legitimately be configured above physical memory, since it can swap
buffers out, but KFD allocations are additionally bounded by
kfd_mem_limit.max_system_mem_limit, which is derived from physical
memory. KFD therefore advertises a pool it will never allocate from: on
a Ryzen AI MAX+ 395 with 62 GiB RAM and ttm.pages_limit set to 80 GiB,
HIP reports 80 GiB total while KFD caps allocations at 59.69 GiB, so
applications sizing against a fraction of total fail.

Report the smaller of the TTM limit and KFD's system memory limit, via a
new amdgpu_amdkfd_system_mem_limit() accessor, rounded down to PAGE_SIZE
since max_system_mem_limit is not necessarily page aligned while KFD
allocations are. When no_system_mem_limit is set to allow overcommit,
the TTM limit is reported unchanged. GTT and TTM sizing are not
affected.

Co-developed-by: Strahinja Stamenkovic <strahinja.stamenkovic@amd.com>
Signed-off-by: Strahinja Stamenkovic <strahinja.stamenkovic@amd.com>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 15 +++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  9 +++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 0dab267eb382..7f6c172e7e53 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -521,6 +521,17 @@ uint32_t amdgpu_amdkfd_get_fw_version(struct amdgpu_device *adev,
 	return 0;
 }
 
+/*
+ * Size of the GTT-backed pool reported on APUs. TTM may be configured above
+ * physical RAM, but KFD will not allocate beyond its system memory limit, so
+ * don't report more than that.
+ */
+static u64 amdgpu_amdkfd_gtt_pool_size(void)
+{
+	return ALIGN_DOWN(min((u64)ttm_tt_pages_limit() << PAGE_SHIFT,
+			      amdgpu_amdkfd_system_mem_limit()), PAGE_SIZE);
+}
+
 void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 				      struct kfd_local_mem_info *mem_info,
 				      struct amdgpu_xcp *xcp)
@@ -535,7 +546,7 @@ void amdgpu_amdkfd_get_local_mem_info(struct amdgpu_device *adev,
 			mem_info->local_mem_size_private =
 					KFD_XCP_MEMORY_SIZE(adev, xcp->id);
 	} else if (adev->apu_prefer_gtt) {
-		mem_info->local_mem_size_public = (ttm_tt_pages_limit() << PAGE_SHIFT);
+		mem_info->local_mem_size_public = amdgpu_amdkfd_gtt_pool_size();
 		mem_info->local_mem_size_private = 0;
 	} else {
 		mem_info->local_mem_size_public = adev->gmc.visible_vram_size;
@@ -863,7 +874,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct amdgpu_device *adev, int xcp_id)
 
 		return ALIGN_DOWN(tmp, PAGE_SIZE);
 	} else if (adev->apu_prefer_gtt) {
-		return (ttm_tt_pages_limit() << PAGE_SHIFT);
+		return amdgpu_amdkfd_gtt_pool_size();
 	} else {
 		return adev->gmc.real_vram_size;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 74dc307e5140..f504f133f2a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -400,6 +400,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
 void amdgpu_amdkfd_account_vram_pin(struct amdgpu_bo *bo, int xcp_id);
 void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id);
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
+u64 amdgpu_amdkfd_system_mem_limit(void);
 #else
 static inline
 void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
@@ -426,6 +427,11 @@ static inline
 void amdgpu_amdkfd_account_vram_unpin(struct amdgpu_bo *bo, int xcp_id)
 {
 }
+
+static inline u64 amdgpu_amdkfd_system_mem_limit(void)
+{
+	return U64_MAX;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_HSA_AMD_SVM)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0a04516e137e..5b530ddf06b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -130,6 +130,15 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
 		(kfd_mem_limit.max_ttm_mem_limit >> 20));
 }
 
+/* Returns U64_MAX if the system memory limit is disabled or not yet set up. */
+u64 amdgpu_amdkfd_system_mem_limit(void)
+{
+	if (no_system_mem_limit || !kfd_mem_limit.max_system_mem_limit)
+		return U64_MAX;
+
+	return kfd_mem_limit.max_system_mem_limit;
+}
+
 void amdgpu_amdkfd_reserve_system_mem(uint64_t size)
 {
 	kfd_mem_limit.system_mem_used += size;
-- 
2.43.0

