Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63647606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VgxLqt7U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DAAC910FD9D;
	Wed, 18 Nov 2026 15:11:07 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 472CD10FD9D
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:11:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHPK9hrQ8BMN2EoFG2/n7kX4x8IKIpSqbfgTNKUUZxMecdd6sma2eFw9jOEcIXE6sEUakrS09rZa5EyVKdnFTVPxx0bqtHdEshpLTIyZ7D7Oa/DT7lNwit2iM+nTDF+BCW2O+EAcTACwnGoVMhV2bEYpliYpRhOIGT4FSU4uWODPatLcc/mNRd8mkIUHWrFgcJcgkYG7QB1dxANcndo1XU3bGz56ObiCiBZQ+dmv8RsMw5DQqRKsOikHbYR9VF4TRQZyNrKE5EhWhJhTJjhmNTYwFVIwj8cYw82C0ARRKkfmq52jUpGyoeFDFTlWDiujiDwrdw7RYKTUncjRt1imyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e6NCoKDSBORvimb4zAOtCzjzau7bue83n2bwD01Z3iI=;
 b=YnzpKgsWuA0C03/HCzvOUbaf/77V+jLSFtI8DrOp9RSgyfzymHHPjq0AMkbHABP0Y8xt5BTVkinrAajb+2Yb+NQ+gC9iGKuN3bzVAnKsBPgvmiJpRUx2sYejTb/FF/k4cpB4FAtNKlaYzFQxfwc3O9/DmUvcc23QXlUu+NKJsLFcBdPhzTM7E4KcMgEVovwlCewIKxy+1XQRccQWploTpXpMUMbNoujXxo91SVtdsfuoSqpZ/jKT2Up0iA4fNcvL1T+w2R45AT/MFg8mg59bdj3QCS7NCkJ46B9SSe99ZsHL64wC+DdRQz7PY6qiOi8wMb8u7y2yDoeIA9YnO0M8Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6NCoKDSBORvimb4zAOtCzjzau7bue83n2bwD01Z3iI=;
 b=VgxLqt7Up7veqMJIrfA0SfihzlTf2fgvU+9vx5i52IHYUZv0NIB+NQYqEjs2SLHctaRzypcdbyERwePazaLx9HMj2+glosn6J8IoUAklJe+whQlmjvqlPvLU/nSpZTGM1IWThvZVPXQ7PlBLs5gkEtIFJuXeUIS9unbW6Pk3CDE=
Received: from PH7PR17CA0047.namprd17.prod.outlook.com (2603:10b6:510:323::29)
 by SA1PR12MB5669.namprd12.prod.outlook.com (2603:10b6:806:237::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:10:55 +0000
Received: from CY6PEPF00000048.namprd03.prod.outlook.com
 (2603:10b6:510:323:cafe::5e) by PH7PR17CA0047.outlook.office365.com
 (2603:10b6:510:323::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Wed,
 18 Nov 2026 15:10:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY6PEPF00000048.mail.protection.outlook.com (10.167.247.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:10:54 +0000
Received: from alysaliu-dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 09:10:53 -0600
From: William Palacek <William.Palacek@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <William.Palacek@amd.com>, <Harish.Kasiviswanathan@amd.com>,
 <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, <philip.yang@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: drop mmap_lock between chunks when faulting
 userptr pages
Date: Wed, 18 Nov 2026 10:10:37 -0500
Message-ID: <06cc5e1afc886b72367d287a53caa92a1874637a.1795014593.git.William.Palacek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1795014593.git.William.Palacek@amd.com>
References: <cover.1795014593.git.William.Palacek@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000048:EE_|SA1PR12MB5669:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ca40c2e-5aac-4fbf-24b3-08df45862478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|22082099003|18002099003|11063799006|56012099006|261026140227099003|261028144727099003|261021123027099003|10067099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: YqH9ZbJYRdqMTiK6HV6crSw3T2G4J5ueT/D50ym9GBwpou5oLbHV1BiqoiW9LHnb+oxPAhvODaSw5WgYcUDoffw2BOMlCTmZxQ98yYjUk1wGQMMd6WI9v4SCVfH2l+T/F72httgU9vjz9ZBRnA1QqeZ02PjfxoErzR+me0GXA7z3V/gNjy1Ff+/L+DnaZqnW7PPv1YistF/ylQi1+FaBjGLewVb6ByVSMU6758JflyrSJ326zVzgGkqNMOPfG5GIePOfs7VKupeMQ7UUaY77o0GGCH1bx+8u6KitMZtNnAIRifsu/l+65F+jBI0A3Or9TfuUX16P8ryzOC/Clm3CVHaUBumHnVR8vOAjn4JxkMaLt/WT/YhVfJY0uNXzkQgVkh3EFbWEsa55zj9OotQ2t+1TQEidrU5g4SIJgyYmIXoA4PuB2HrBqMmgpDvv4Da2QeIYnHrfi2bb6P3guE444fBGObXFdiNpCOPZvlquQOyklIp+K5p61fcm/5yNUCpkjVw7dlGvzX7PceGSlzidkHypeoJf5JrDGlfgVgtaDPzrxNCcwDNFMgI2EMvrC/fekrL/RuRFB5Agb0dMgFCtrj+34sKAQFuWkG9kBV6ZuoOKVJIrAnWWEzRA/dkH9lbNHNHcdBXLGGQMLjXvNKK3Vw5FSAxYj8LfxqBzjgv7pboPsiLszOZqEBl77ik4ucj8z09Hzjt0ttKUdZKwrjyyYg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(261026140227099003)(261028144727099003)(261021123027099003)(10067099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4NT28Uyf+0USuH230fMKFHfybcBtuH5M3uADAeyvb8Asi9H6E14LHYpUzShSRP3T8t/UM1T7PStkEAhdQ0sWQTt5pIqu4wl9QZ8wtzdNYk9hPyY5cyoPnGLgvOw1P2+bEbwFwJnZr7bUbHCZeYrtaO4f9iw8LwlHvmBVT/djlhsPOvJNDF1jjKZyCVk0CK/oKhwWhRZFd5plET49y2+wtoTczwBdz1d+yizkYP9cAQQT9G6tXIVwl50//8XrceixANBA5DcA3ntkdHF9s6jDnbULHHt9U37ItfyhvgVP/nhawpGRVGryhCbsiawStBpwlDDoDcF+RJTxIyXF65zcOIWRoYyRufrpfoQ5TuUjzLRMWaH8HCGLwr1+ZrC40oOLNU9jn3DZQXlz1EFDKseBACS7f8FlN143Amgpy9L3byioyga9J3Tm32MOWf/V7CuQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:10:54.8804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca40c2e-5aac-4fbf-24b3-08df45862478
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF00000048.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5669
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

amdgpu_ttm_tt_get_user_pages() holds mmap_read_lock across
hmm_range_fault() for the whole userptr range. Faulting in a 32 GiB
range takes seconds, and every mmap_lock writer of the process (mmap,
munmap, madvise, the KFD SVM flush at each alloc ioctl) waits that long.

Fault the range in 2 MiB chunks and drop mmap_read_lock between them
when the caller passes its mm. A change to the range while the lock is
dropped bumps the notifier sequence, which hmm_range_fault() checks
before each chunk and callers check before using the pages. kfd_svm
passes NULL and keeps holding the lock across the whole range.

Signed-off-by: William Palacek <William.Palacek@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 14 ++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c    |  2 +-
 4 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index a7d13e337d84..9f80ffaa0607 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -165,12 +165,17 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
 	bo->notifier.mm = NULL;
 }
 
+/*
+ * The caller holds mmap_read_lock. If @mm is non-NULL it is dropped between
+ * 2 MiB chunks, so faulting a large range blocks mmap_lock writers for at
+ * most one chunk; the notifier sequence catches any change made meanwhile.
+ */
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       uint64_t start, uint64_t npages, bool readonly,
-			       void *owner,
+			       void *owner, struct mm_struct *mm,
 			       struct amdgpu_hmm_range *range)
 {
-	const u64 max_bytes = SZ_2G;
+	const u64 max_bytes = mm ? SZ_2M : SZ_2G;
 
 	struct hmm_range *hmm_range = &range->hmm_range;
 	unsigned long *pfns;
@@ -205,6 +210,11 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 
 		if (hmm_range->end == end)
 			break;
+		if (mm) {
+			mmap_read_unlock(mm);
+			cond_resched();
+			mmap_read_lock(mm);
+		}
 		hmm_range->hmm_pfns += max_bytes >> PAGE_SHIFT;
 		hmm_range->start = hmm_range->end;
 	} while (hmm_range->end < end);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
index 140bc9cd57b4..4d1c96ad2704 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
@@ -38,7 +38,7 @@ struct amdgpu_hmm_range {
 
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       uint64_t start, uint64_t npages, bool readonly,
-			       void *owner,
+			       void *owner, struct mm_struct *mm,
 			       struct amdgpu_hmm_range *range);
 
 #if defined(CONFIG_HMM_MIRROR)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index b0672f1747ee..fae845632169 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -793,7 +793,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 
 	readonly = amdgpu_ttm_tt_is_readonly(ttm);
 	r = amdgpu_hmm_range_get_pages(&bo->notifier, start, ttm->num_pages,
-				       readonly, NULL, range);
+				       readonly, NULL, mm, range);
 out_unlock:
 	mmap_read_unlock(mm);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3f32507e2aae..8d7de7bb39e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1892,7 +1892,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			range = amdgpu_hmm_range_alloc(NULL);
 			if (likely(range))
 				r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
-							       readonly, owner, range);
+							       readonly, owner, NULL, range);
 			else
 				r = -ENOMEM;
 			WRITE_ONCE(p->svms.faulting_task, NULL);
-- 
2.43.0

