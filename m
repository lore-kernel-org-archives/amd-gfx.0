Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B60CC3ABAC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 16:05:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22EF210E326;
	Wed, 30 Apr 2025 16:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="twCuukUm";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2082.outbound.protection.outlook.com [40.107.220.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E69010E326
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 16:05:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlkyTrtbPe9TVuAoXlAzy6T63TbT4oNmWPC/JhSNfEjWcyAZ0Kv4znwVFojqqVZW6z9xM5tWL09mlV4HzRip3zUbBuKLwT0Ej1s8EHRaFhuVeoMIB271oec9Jc23Olcak2RU0tjCMYz3FH8WfubA1pBg95ICGeFTOaQ7VGJRChPiqUX7T0TSKgY8um0rRpjst+9T4jNMcDCUyOwgAULS4mOLOvFMoRaWh+KdZ+HLZ510PyrjaO1yJVaz5/F2/O1VCeHrwQIq9lKGFIc9Y/IomsLE0NubR7/HrrkUHk5wX5cWD4fmd3A+DS7vnZ2AxBU+Jiwas/PeO9/ERiPydofMPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3T2445tp17fG3NVGsmKWUFoDMGuE+TqwxmMyaGw6Rc=;
 b=VdfEgIbc+dfAsdmmgLckja7XXVWCEQXTpn9i8o5NUU9Lou5b6izAG7J+fCbXQbFAGWQNB4AUGyZRafpm67S3yHn9tbD+rZXbaaANCKTxtHXc0/gOu0cq0Wf8PqFT91kmVc0b9J6OTYh5jsRe0v09Zj92st06MpSihdVUIsSIFA5Xeewx+LPQ2cwMfBN5vVdD79da1lUcwUcrcBPxcoABBuxF5ohiA+lyw/5OGVewZqDvv8CcUe9pZEcxM9yMm0vHSOTveC0sKWKzF9rvclicFNtZiQRFbN9pcCTA/sM030svrJ9KW3fbYfN/ZHyPjWO7QeQ5ClRcZcB44I+flV4mjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3T2445tp17fG3NVGsmKWUFoDMGuE+TqwxmMyaGw6Rc=;
 b=twCuukUmygNUDj+6zdkJIAWjJJIhycw7NFXAuDZlb/9UPq1pR6EbQ326e0hJ7/xll7ol0HOaM8w5MO4AfMjArgsm9slp/i3GCfH/9L+3lcwuGVkcTADvIgaBX0Nhq0T8/E0roe1omXEwL6gu34E+Vp7q4/mc8Qt0x6xJVb52ri0=
Received: from MN0P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::33)
 by LV3PR12MB9093.namprd12.prod.outlook.com (2603:10b6:408:19d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 16:05:44 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:208:52a:cafe::a3) by MN0P221CA0019.outlook.office365.com
 (2603:10b6:208:52a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Wed,
 30 Apr 2025 16:05:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.2 via Frontend Transport; Wed, 30 Apr 2025 16:05:43 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 30 Apr 2025 11:05:40 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v4 1/2] dma-fence: Add helper to sort and deduplicate
 dma_fence arrays
Date: Wed, 30 Apr 2025 21:35:20 +0530
Message-ID: <20250430160521.35670-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|LV3PR12MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 83809df6-52ca-47da-5660-08dd8800dc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2e4iJfcEWtCjsplifrbG9960Vmb9cxPzXyv/5JnMEwB/4S54c6btkr2BQNte?=
 =?us-ascii?Q?pFO8fipuBOz89WGN6DnwDQF96OTVmzv6rifu7H8HG0btOsb5nl1g566KokF+?=
 =?us-ascii?Q?nOftQZmmGEeod8Ah+vbhCTQ6mFlNEB9gni2ZUiELBC+47NQFafrXrNNGu46o?=
 =?us-ascii?Q?pwAFuvdJslYk8LtFsm0hWdwiq9fBiLmPSumoDyd6GsIsnmlhjvQGftKEdite?=
 =?us-ascii?Q?UeIMPpIkh2ta/73aUh99a9fpsNPlcSmVkegP90OruOA07mE2sQJNnv5ro1/X?=
 =?us-ascii?Q?ihYTAYxNlQJ2ovDP5hJGTE7X51SBGbBxHCgdL0G1GM/eCrDothEBToUZj2xJ?=
 =?us-ascii?Q?7+d9lzIj65665SrFJpUkPO3JGs5KVZI9X+tVGt5eZUC7fL+8r8vKx12Ts1NF?=
 =?us-ascii?Q?CKrVCH4FzMXCbUtvSsp02LICbFdahC4p2asgClunjDC/O4kfjNP/1ouNXCbs?=
 =?us-ascii?Q?oZnGA6IatuMFt/EixEhWvQ+K0oHHQ/Fr4CB23b0p8jvUvDFe7UhQ6rgnewH9?=
 =?us-ascii?Q?fnVJo6KvYBeKIChFhFTGvtpt6psOX63OWPg0uMbFByeU8GwKiez/HCeFPI2A?=
 =?us-ascii?Q?cLPlvYVziGVmWkP0EoWR59U2wSjzpwSUsX2UDDHLDr0Ttg/lgMN3Bc3/jzjR?=
 =?us-ascii?Q?NQ15gZFp1ghfnTPohGfFSDk8hqB+mFpfVNtQ9W/+tvBMyXQG7/n0FtRj9/S0?=
 =?us-ascii?Q?WyJ7Y8BFOjDDLMou/hUJ/ccmFs6hHXVngDuSyXNBUmNXgbIB09yO5EYM4Pmf?=
 =?us-ascii?Q?CWycS2PlyEWwrSdZqd3TglX97e5QKwKV85sG+GVJrdfpeQwc5kUiHUy3TCSq?=
 =?us-ascii?Q?lwESHo2vdX2h68B2gkvtbfRpFSeLUlXDCi6I0rgG08yXlVrV/WeamMVq/wPG?=
 =?us-ascii?Q?IbhTwu333nVuTr35nB1DdzOM90So7GB7mDcgWp/QRuj0HWv5a24VaH32lfGB?=
 =?us-ascii?Q?QwPjyktf6LYy2LTgwROUBQ6bRX7rkh3HBW+0CABxiAI8de6b134D9oGaYuDd?=
 =?us-ascii?Q?v0GcqbhvmLybmhBEuzT4M4RJDu1u0jpG32N6GgNMpqSniRp944tYF5ts1i3o?=
 =?us-ascii?Q?bkEW1xq2eftxzCRSOl+SPp8BNu3uFZnAlDP6eLxHEewHo/CHksY5tfiBJSja?=
 =?us-ascii?Q?1IqzJWeqvBoP2zUuUCgDay3MN3qpUA1x1tjEMaOg/Yplnfz5e9puUoNWfSlC?=
 =?us-ascii?Q?Qe9I4tToO9yVRaba0geQhGNjTyCxwv1v6F5kxMu1Zmg0DYc9JYusymLqxu1f?=
 =?us-ascii?Q?O8wOvtw7BMhXniw7aqTPDSH9P2NOkaXr2sl+xmOOx29JjX3nhZ7DJyr63io+?=
 =?us-ascii?Q?46+mHLW3wLrS8R54ZffMK+VCRdd7cFqHbY4vWytCW8bggSbiymSWgJBnQggQ?=
 =?us-ascii?Q?ZbLNXlkp5ZwEpnff3CQ7+PBML3UL7mNannBq0rTyWJwr6G/wclF02oAINF7l?=
 =?us-ascii?Q?HYoWCXDTPZayso8u09+80l/BqQdwQilct425yLI6CvWu5TTczFNDUf3H+FDp?=
 =?us-ascii?Q?ocH6X+TwYvkLdt64gUSjDlDdlEIps/kI6qcv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 16:05:43.0796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83809df6-52ca-47da-5660-08dd8800dc24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9093
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

Export a new helper function `dma_fence_dedup_array()` that sorts
an array of dma_fence pointers by context, then deduplicates the array
by retaining only the most recent fence per context.

This utility is useful when merging or optimizing sets of fences where
redundant entries from the same context can be pruned. The operation is
performed in-place and releases references to dropped fences using
dma_fence_put().

v2: - Export this code from dma-fence-unwrap.c(by Christian).
v3: - To split this in a dma_buf patch and amd userq patch(by Sunil).
    - No need to add a new function just re-use existing(by Christian).
v4: - Export dma_fence_dedub_array and use it(by Christian).

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/dma-buf/dma-fence-unwrap.c | 51 ++++++++++++++++++++++--------
 include/linux/dma-fence-unwrap.h   |  2 ++
 2 files changed, 39 insertions(+), 14 deletions(-)

diff --git a/drivers/dma-buf/dma-fence-unwrap.c b/drivers/dma-buf/dma-fence-unwrap.c
index 2a059ac0ed27..a495d8a6c2e3 100644
--- a/drivers/dma-buf/dma-fence-unwrap.c
+++ b/drivers/dma-buf/dma-fence-unwrap.c
@@ -79,6 +79,41 @@ static int fence_cmp(const void *_a, const void *_b)
 	return 0;
 }
 
+/**
+ * dma_fence_dedup_array - Sort and deduplicate an array of dma_fence pointers
+ * @fences:     Array of dma_fence pointers to be deduplicated
+ * @num_fences: Number of entries in the @fences array
+ *
+ * Sorts the input array by context, then removes duplicate
+ * fences with the same context, keeping only the most recent one.
+ *
+ * The array is modified in-place and unreferenced duplicate fences are released
+ * via dma_fence_put(). The function returns the new number of fences after
+ * deduplication.
+ *
+ * Return: Number of unique fences remaining in the array.
+ */
+int dma_fence_dedup_array(struct dma_fence **fences, int num_fences)
+{
+	int i, j;
+
+	sort(fences, num_fences, sizeof(*fences), fence_cmp, NULL);
+
+	/*
+	 * Only keep the most recent fence for each context.
+	 */
+	j = 0;
+	for (i = 1; i < num_fences; i++) {
+		if (fences[i]->context == fences[j]->context)
+			dma_fence_put(fences[i]);
+		else
+			fences[++j] = fences[i];
+	}
+
+	return ++j;
+}
+EXPORT_SYMBOL_GPL(dma_fence_dedup_array);
+
 /* Implementation for the dma_fence_merge() marco, don't use directly */
 struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 					   struct dma_fence **fences,
@@ -87,7 +122,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 	struct dma_fence *tmp, *unsignaled = NULL, **array;
 	struct dma_fence_array *result;
 	ktime_t timestamp;
-	int i, j, count;
+	int i, count;
 
 	count = 0;
 	timestamp = ns_to_ktime(0);
@@ -141,19 +176,7 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
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
+	count = dma_fence_dedup_array(array, count);
 
 	if (count > 1) {
 		result = dma_fence_array_create(count, array,
diff --git a/include/linux/dma-fence-unwrap.h b/include/linux/dma-fence-unwrap.h
index 66b1e56fbb81..62df222fe0f1 100644
--- a/include/linux/dma-fence-unwrap.h
+++ b/include/linux/dma-fence-unwrap.h
@@ -52,6 +52,8 @@ struct dma_fence *__dma_fence_unwrap_merge(unsigned int num_fences,
 					   struct dma_fence **fences,
 					   struct dma_fence_unwrap *cursors);
 
+int dma_fence_dedup_array(struct dma_fence **array, int num_fences);
+
 /**
  * dma_fence_unwrap_merge - unwrap and merge fences
  *
-- 
2.34.1

