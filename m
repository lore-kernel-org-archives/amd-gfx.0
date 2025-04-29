Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E360AC369DC
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 15:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73F8310E0A5;
	Tue, 29 Apr 2025 15:25:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oeapiYjl";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3D2910E0A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 15:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzJZBrqfzAC97mEFv9n48ZsRcqSegJaev4k7dNrsO5B2SnxV5PtgnMZGPrqArCY/yxQx1sEWywhPp4OVAleupw4S3wBhgpTeu2DhXjLnyx36778tDuD9zSgWqKd0bB5dm14oTqlUhe6uzsY/ZX/2Pdig2m75ul+kWaUV5jUDof8jX2i1ablSDUOuYBZtSWqLfjDuinlJUnPY15TU9MthaVdEgGLe2NXC+DL9Mv4Q07jj/tZxcNnGVIqRI+sZISN30tScIIqxjX6BXzicF/loV5bw2lJRfqgoLOlHXCwVcvPrVxGq6oQ0xqxE1eEvRfGczVwekSXwUGCdIeVMCBJ3yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZrzrTIlAK2Oof6+b9mGdeqElKrJRtcDgRgTbTGyizs=;
 b=IaLdHj/E28mNc/EPo3PV9LO7/DphIQFxN2tOqZtQGGb72TIFyQZAxmYdFDqP/FXs4ufxR96nfQXdpchzIE7/7826vwXXKw9w2iv0FJd/hSA7iGZ1NTHTjNmu3UH+LXBW5DEizrRGjq1aVPERi4mPzKyAYh7BPWw8nMRniGwMp39z5xvmiTCu1TJLkWqADzAcdOuKKimuj21BGLsvRk8J7edq3Op97ZEKCV8dbptrBgblH0iFhxO9ht/5OqSfiW/5eGdfcbJb3lehpfqtCLU3xi8RqNT3//kslhijNUgIphkShQ5Y3PSotkJAr6K4P9tw88Q0lsYYDLbiIr5lSSPBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZrzrTIlAK2Oof6+b9mGdeqElKrJRtcDgRgTbTGyizs=;
 b=oeapiYjl+0X3GF6exDLMZmDIGbMpb1kl6b2sw1UqZ/UEsHqfA0GYEiP/U7nS2JsCYwYNbFPtFvcYE3LIs4MxpeaLKaE2S5htTR4YCkSDFbWe1loJYk169reZpjUrm1rlhWeL1bN+iznyCXlvq5FpDstpc+EWiAvey8MdZ2kuVZU=
Received: from SJ0PR13CA0114.namprd13.prod.outlook.com (2603:10b6:a03:2c5::29)
 by IA1PR12MB9521.namprd12.prod.outlook.com (2603:10b6:208:593::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 15:25:19 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::91) by SJ0PR13CA0114.outlook.office365.com
 (2603:10b6:a03:2c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.12 via Frontend Transport; Tue,
 29 Apr 2025 15:25:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Tue, 29 Apr 2025 15:25:18 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 29 Apr 2025 10:25:14 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v3 1/2] dma-fence: Add unwrap mode enum and macro for in-place
 deduplication
Date: Tue, 29 Apr 2025 20:54:47 +0530
Message-ID: <20250429152448.205212-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|IA1PR12MB9521:EE_
X-MS-Office365-Filtering-Correlation-Id: 341fa07b-3fc1-4442-10ed-08dd87320c7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UcHBYqeGaFQmFSYoKGQH3Gy2srSS9zcodb13QZtTO7aqz7nSQnoRZZWAOdVf?=
 =?us-ascii?Q?809pOD8XQmXk3Yd3ueifUVNkkdaJbc6e4C2l5yOeXOWUb10atOV6HYq+5xNc?=
 =?us-ascii?Q?K4NxlAYqaw4/vDDKYK+0855F2j/dbVeh9jFHsWvRFwLwi5/3aPVwx1D3KCEr?=
 =?us-ascii?Q?ncczv8RK4nA4W2L60cPWa83nmxq0ZXzV4ofTNeV8Ev5tt5GQrcfrJIIyaM/4?=
 =?us-ascii?Q?U6KWiE2R+JeBl690DO7keBEqjBusUt0++/5zHGQ7XEIqQto4qVxIIhEsVpVc?=
 =?us-ascii?Q?iMz8gYENKyD2ZhxVpjnTaDfcWGnc3c62/iZ8jDC8/TbLLLonntVlrh1e5WPA?=
 =?us-ascii?Q?oGVN0J2BiUy6DqmaMNhwpmrbutcCMYLHq/K4S0l6PAtu//gLCRYUTW9OJlDg?=
 =?us-ascii?Q?ze4Pwo+0gNwYEh2XBjTQSY2cZvtYZFi6NgfLEqaHOzMOu/UvtMa0RMHWGYig?=
 =?us-ascii?Q?tNpqbF0YwMD3xP8TtVzt2yCKWhdF9/X6Q2vzYwsDVfaaohSigC1Zg5sJfnkt?=
 =?us-ascii?Q?O7RA87A9VVx3eZPfrgk6O3tVTkzUe0nDJT4ZaX87LjBdiwqek99Mmwtzx4pb?=
 =?us-ascii?Q?YuXDi+0oYWIB3LGhAVPO/AVlvlVa5pLqdbLZa34+uDfUEpPV0lxWEg0MJurl?=
 =?us-ascii?Q?n6/KvKizZ5xtfidlB7Bd4UdoPy8pPY9ADibvjm0InVzQ6dieVhKVqcJ0ikFR?=
 =?us-ascii?Q?wFi1CpCtKlAR5TySBQuDWROA9yvF4DaL2Z1aKeQ0/2/gdUldHxo1LyC074mB?=
 =?us-ascii?Q?9KfKkUFcnfM6GqsT1YBweMsj+90I+RxwTz2liPL0jsCrPI65thI8gOQFZ+Pz?=
 =?us-ascii?Q?0zGcOWra+WTY8lVcszacTFW1p/lJIOYdC7gqalCzsx5kwsR5qisKp+iryZcW?=
 =?us-ascii?Q?bPFJ4NVApJwwRws+s+ZS3F4w+Z+5liwc+EIVOaB0n1uHchxwdZd9qJ1ocxGt?=
 =?us-ascii?Q?Deyh2QSzA62PREhKt7L1qTyajCC1dk2qDiYmwsVFD/P/6+LJeCP06z9kV9i6?=
 =?us-ascii?Q?PaQrsTBwCaVBBiZ3Ev9DCEGxXOxGdD4vpYn9yF8xtgJnC1S94a/H0D4uM3re?=
 =?us-ascii?Q?cTUpkgFwN5NslsN8CWcPjQYydu0QWNatImxVwBFrBFmmQycpnQ8Hqvao6ftr?=
 =?us-ascii?Q?pJHrO8q8dYzIXJ26QFYg/FmmHCXYtj/A4BHhbnOt3nTltV9Y6sSG9iLGX0cH?=
 =?us-ascii?Q?K1hOALy5hySiE1lYEHgHrggFJKYTQphQqzrpwro5chYFdL/iVOJZYP9Glp46?=
 =?us-ascii?Q?ATSKXDBwvx7geHvZezZDuCNz4dO8n4lv2xWMhm1a21sHGrMz65afD3Ybv/JJ?=
 =?us-ascii?Q?ZL/0zTlIeclZM4bS3XsNruleqt2nyykigCzO2jEWeKZxnV28/c3sIhidYOK+?=
 =?us-ascii?Q?K2GCdCn7g9k7t0s0k744u91fRktGWa2amK09HrBQhGOI/cXHMHzP5QYl9Q/c?=
 =?us-ascii?Q?aC+NjEqNyLJG4NyXQwIWdgZILVWY1iocr07MbhLeSx2eTqYjU0rl6NojlcDM?=
 =?us-ascii?Q?0CsPyknjMSVTTIyZdTfc8finRSc0y7GGWCWE?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2025 15:25:18.2709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 341fa07b-3fc1-4442-10ed-08dd87320c7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9521
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce a new `enum dma_fence_unwrap_mode` to support multiple modes
of fence unwrapping and merging behavior. This lays the groundwork for
more flexible and efficient fence operations.

Add a new macro `dma_fence_unwrap_shrink_array()` to allow callers to
unwrap, deduplicate, and sort dma_fence arrays in-place, avoiding
additional memory allocations. This mode filters out already signaled
fences and keeps only the latest fence per context.

To support this, refactor `__dma_fence_unwrap_merge()` to handle both
merge and shrink modes through the new `dma_fence_unwrap_mode` parameter.
The sorting and deduplication logic is extracted into a new helper function
`dma_fence_unwrap_dedup_sort()`.

These changes allow clients to efficiently compact arrays of fences with
minimal overhead, improving memory usage and performance in common
scenarios like command submission or dependency tracking.

v2: - Export this code from dma-fence-unwrap.c(by Christian).
v3: - To split this in a dma_buf patch and amd userq patch(by Sunil).
    - No need to add a new function just re-use existing(by Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/dma-buf/dma-fence-unwrap.c | 54 +++++++++++++++++++++---------
 include/linux/dma-fence-unwrap.h   | 44 ++++++++++++++++++++++--
 2 files changed, 81 insertions(+), 17 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 2a059ac0ed27..f389c37a0eb5 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -79,15 +79,51 @@ static int fence_cmp(const void *_a, const void *_b)
 	return 0;
 }
 
+static void dma_fence_unwrap_dedup_sort(struct dma_fence **array,
+					unsigned int *count)
+{
+	int i, j;
+
+	sort(array, *count, sizeof(*array), fence_cmp, NULL);
+
+	/*
+	 * Only keep the most recent fence for each context.
+	 */
+	j = 0;
+	for (i = 1; i < *count; i++) {
+		if (array[i]->context == array[j]->context)
+			dma_fence_put(array[i]);
+		else
+			array[++j] = array[i];
+	}
+
+	*count = ++j;
+}
+
 /* Implementation for the dma_fence_merge() marco, don't use directly */
 struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 					   struct dma_fence **fences,
-					   struct dma_fence_unwrap *iter)
+					   struct dma_fence_unwrap *iter,
+					   enum dma_fence_unwrap_mode mode,
+					   unsigned int *out_count)
 {
 	struct dma_fence *tmp, *unsignaled = NULL, **array;
 	struct dma_fence_array *result;
 	ktime_t timestamp;
-	int i, j, count;
+	int i, count;
+
+	if (mode == DMA_FENCE_UNWRAP_ARRAY) {
+		array = fences;
+		count = num_fences;
+
+		if (count > 1)
+			dma_fence_unwrap_dedup_sort(array, &count);
+
+		if (out_count)
+			*out_count = count;
+
+		return NULL;
+	}
 
 	count = 0;
 	timestamp = ns_to_ktime(0);
@@ -141,19 +177,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 	if (count == 0 || count == 1)
 		goto return_fastpath;
 
-	sort(array, count, sizeof(*array), fence_cmp, NULL);
-
-	/*
-	 * Only keep the most recent fence for each context.
-	 */
-	j = 0;
-	for (i = 1; i < count; i++) {
-		if (array[i]->context == array[j]->context)
-			dma_fence_put(array[i]);
-		else
-			array[++j] = array[i];
-	}
-	count = ++j;
+	dma_fence_unwrap_dedup_sort(array, &count);
 
 	if (count > 1) {
 		result = dma_fence_array_create(count, array,
diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
index 66b1e56fbb81..b5683b024548 100644
--- a/include/linux/dma-fence-unwrap.h
+++ b/include/linux/dma-fence-unwrap.h
@@ -10,6 +10,18 @@
 
 struct dma_fence;
 
+/**
+ * enum dma_fence_unwrap_mode - Mode of operation for fence unwrap and merge
+ * @DMA_FENCE_UNWRAP_MERGE: Merge all unsignaled fences into a new dma_fence object.
+ *                          Returns a single merged fence or stub.
+ * @DMA_FENCE_UNWRAP_ARRAY: Deduplicate and sort fences in-place.
+ *                          Returns nothing, but updates the input array and count.
+ */
+enum dma_fence_unwrap_mode {
+	DMA_FENCE_UNWRAP_MERGE,  /* Return a single merged dma_fence or NULL on error */
+	DMA_FENCE_UNWRAP_ARRAY,  /* Return deduplicated, sorted in-place array */
+};
+
 /**
  * struct dma_fence_unwrap - cursor into the container structure
  *
@@ -50,7 +62,9 @@ struct dma_fence *dma_fence_unwrap_next(struct dma_fence_unwrap *cursor);
 
 struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 					   struct dma_fence **fences,
-					   struct dma_fence_unwrap *cursors);
+					   struct dma_fence_unwrap *cursors,
+					   enum dma_fence_unwrap_mode mode,
+					   unsigned int *out_count);
 
 /**
  * dma_fence_unwrap_merge - unwrap and merge fences
@@ -58,6 +72,9 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
  * All fences given as parameters are unwrapped and merged back together as flat
  * dma_fence_array. Useful if multiple containers need to be merged together.
  *
+ * Internally uses the DMA_FENCE_UNWRAP_MERGE mode to return a single merged
+ * dma_fence (or a stub if all fences are signaled).
+ *
  * Implemented as a macro to allocate the necessary arrays on the stack and
  * account the stack frame size to the caller.
  *
@@ -69,7 +86,30 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 		struct dma_fence *__f[] = { __VA_ARGS__ };		\
 		struct dma_fence_unwrap __c[ARRAY_SIZE(__f)];		\
 									\
-		__dma_fence_unwrap_merge(ARRAY_SIZE(__f), __f, __c);	\
+		__dma_fence_unwrap_merge(ARRAY_SIZE(__f), __f, __c,	\
+					 DMA_FENCE_UNWRAP_MERGE, NULL);	\
+	})
+
+/**
+ * dma_fence_unwrap_shrink_array - Deduplicate and sort an array of fences in-place
+ * @ _num_fences: Number of input fences
+ * @ _fences:     Array of dma_fence pointers to be deduplicated and sorted
+ * @ _out_fences: Output variable updated with the number of fences after deduplication
+ *
+ * This macro unwraps each fence (handling dma_fence_array if needed),
+ * filters out signaled fences, sorts the remaining ones by context and
+ * timestamp, and removes duplicates (keeping only the most recent fence per context).
+ *
+ * Internally uses the DMA_FENCE_UNWRAP_ARRAY mode to perform in-place filtering and
+ * sorting.
+ *
+ * The result is stored back in the input array (_fences) and the final count
+ * is written to @_out_fences. No memory allocation is performed.
+ */
+#define dma_fence_unwrap_shrink_array(_num_fences, _fences, _out_fences)	\
+	({									\
+		__dma_fence_unwrap_merge((_num_fences), (_fences), NULL,	\
+					 DMA_FENCE_UNWRAP_ARRAY, &_out_fences);	\
 	})
 
 #endif
-- 
2.34.1

