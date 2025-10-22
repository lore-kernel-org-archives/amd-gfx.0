Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58621CCD1AB
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 14:21:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB6A10E7C5;
	Wed, 22 Oct 2025 14:21:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yBFSMHhn";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010001.outbound.protection.outlook.com [52.101.61.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B1CB10E7D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 14:21:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNlslK0sNXD1GY+vNOnQa2sC55XrxwFSQTvpXeUiq/21IoSvteKyiNXGCT9kEmVn19e9gYJfBfdUoWnFlRp6pAGce+OKmkpy8ds/wHBmD8teKTJ3EBnAMr8/7VAhNA2R3G+NMNyDGk/Z8Umo1kc7yOXDV8ywZkseduXvj2Tg2pEXwo6m6LoHjpBnoZKEId4PIWcAaunsXAoZjoTty2AQSTxlAEJmWv8Dxh6Hjk+mRhGC2TxPj00nYsl3kSAcBIQRT2y68PHB6qkMTBDmYuIrPGP/WMHJF7s6qHfu9w1Sa6yPeIGVMZwqYMyPJBDQv4Oe5Rm24Q6lf1CzpKc1yWZUDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+z67yfzOVoyRC/jojlCMMFGK0SCmaMtTwA1FZXcrr0=;
 b=nNfjpSLN71sF1s85heHnTZ6FQ0KsdgPckFaTVv27hiWy38EC0ljCAyBbGmdMRem/zRk4X3JsacwqbhveewiiPK9tgSujn6tkICprMHeR1YfenlfDGAObZNEAdwObUI8pCFajpOizbIdM8L7fodRe2vyIbXbi0NaOX5h0WrBkN/16joeI8XNzAxqq6SGGFVjHRhhq6a3DUpeVOAhOE1SrKQ1OUrwcaRtg1vkiNr9g3s2AoA5qnnaBw5dXiPjGqzjRlaVXpePeROvyHA9t+uH9khpBRo5LhorVC0xGYftZIebPRk9MxHMrznvbuV+MZfArDuz/eLBQECpUf6c2Yg7Mzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+z67yfzOVoyRC/jojlCMMFGK0SCmaMtTwA1FZXcrr0=;
 b=yBFSMHhnS8Lrp6kC+Q3I0Czmf8VFvJHJiggRZRISr0QA3mJvLfI0ZXH4krLIERJb6RcAX+G/RhIa54QvmqQYeHxRdJi9Wgcfpfp9LjmylMf9N8r3+kMO522dKFxDf0Jb8s6QSu+/cS2HMhRQMFCmdxMwAeOBdYCpCLqvq1vLS7Y=
Received: from MW4PR04CA0343.namprd04.prod.outlook.com (2603:10b6:303:8a::18)
 by IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 14:21:41 +0000
Received: from CO1PEPF000042AC.namprd03.prod.outlook.com
 (2603:10b6:303:8a:cafe::f) by MW4PR04CA0343.outlook.office365.com
 (2603:10b6:303:8a::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 14:21:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000042AC.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 14:21:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 22 Oct 2025 07:21:39 -0700
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v2] drm/amdkfd: Fix use-after-free of HMM range in
 svm_range_validate_and_map()
Date: Wed, 22 Oct 2025 19:51:31 +0530
Message-ID: <20251022142131.247413-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251022141321.246781-1-srinivasan.shanmugam@amd.com>
References: <20251022141321.246781-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AC:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e518557-baa6-4acc-d769-08de1176523b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekt1dUFiUDlLK2pNNVZzOHVIL2tPc1FPTFNHaTZybVQ3cUhiNGprQWNjdEZY?=
 =?utf-8?B?ZmNUeVBDL1RxMlhDMTFwVGNXdlJXQ3JzZ085L3hTc3BFYnBUWTRZMVdUUHlZ?=
 =?utf-8?B?cTJYV2Q2WG9wOCtaNDlyVjRvZjRaWCtSWit2dmlFUGs4Z2E4MlN6aSsxbFIw?=
 =?utf-8?B?RVNzdytNY2dLUEhWUG5wUHNLVEtDVExxY0N0ODFsSkw0NUNrYSs1TFRsZkJ5?=
 =?utf-8?B?N0hlWHEzdnIzOXo1cWMwcEw4MW9ZMHY1NmlEZlB0TkovRERObnpuV0VFRTJh?=
 =?utf-8?B?c1ZvZTZFS3JJUSs0OHJIaWtoS2NpKzU5MncyaGJnSXBwS2Jad1pjcFg1dDBw?=
 =?utf-8?B?OTdVY2w1L3E0SDVBTDFZNHNXRmVoR3NEeFptUlVodStkc2FVVWJPeGc0L3pU?=
 =?utf-8?B?VWdUMDVtUEQyYmVxRTh4dlBCT3BUSkgzSTY0UmZlVm1jYWpJNHBSeWx2Rkc0?=
 =?utf-8?B?RjdXV1ZmMktMKzBlL01RMkJsZTRoRlZsY2JaSDNoM2xyYU5JckxnNUlUNWlC?=
 =?utf-8?B?VHpnREZiYXo5M0hBUGdJMnliVWhsQTdPbDdhbkhsS2JOYlBvZkhHTmVuNGZp?=
 =?utf-8?B?RG9HQWJJeWg3ZU9kc2JhVlBnS2xOVGlKTWk0NThsWTEyTGdnMkVNSEQyNFpt?=
 =?utf-8?B?QWZ0dkl6T0FyZ1BkUFMra1dDME4zQXZHV3hZd1ZBRDNINUdIVU5BdU0yd2R2?=
 =?utf-8?B?TThHQmFiNXF5alpBU01qNnNwMkJCUitUdTRiWVpoMFdadnk1b2tXWlJ5WHFp?=
 =?utf-8?B?dmthWDdHcWFkTjRKNUJUKzRoQWdqMys1NXFRS0R0RjJST21ZNlIzZ3o5SHNL?=
 =?utf-8?B?eGNjYXVlTWJxZ1lEeFQwWEM4SXFYKytVdmQ4SGY5VnN4c2xlb2NJaTE4bzNu?=
 =?utf-8?B?TlpCdWtJN0FkbG4ra3NVYjVjNFNPY3ZPdXZrTHJER0ZBcU1Ja2YrV1dyVjNz?=
 =?utf-8?B?eE5XZlM2S2VRV0w2VXJpWUVDNFhXdEx4MnZnSm13cWtRN0dIeHdqOXhCdWd4?=
 =?utf-8?B?eGJsa3BmZFF0VUYvWlNVZGFpdG9Fbkw1Q1VidWNJbExPamMzdC9GSml4SFRi?=
 =?utf-8?B?SjV6akpkVUJXbFBZaDRXaEpjWWNwSGJ4UC9PNEozWHRjaTVTcVlMK2MvV1dG?=
 =?utf-8?B?WkZhd3d1eUxiem16c2FZWmNmd3NXWkIrQ3d3TXNuK1lDRTJlRE9WbkM4Q3Rp?=
 =?utf-8?B?TDZKMDhRZzFCaFJ3S05rWUZ5Ny9HZVpnb0lvVlV3WVR0WE5UMzdQQy9nWWxx?=
 =?utf-8?B?VnRUZS9NbWU0blZ0NFhGTmpwdE53K1Jwc3lPdjVwRVY4UnE5OUU5MnRtN0V5?=
 =?utf-8?B?MUlpZTVjMlNVZFY3VXRrbThUS3BVdW5QeWpYSnVackpya2Y0MFNMKytyV3dj?=
 =?utf-8?B?NkxWaU1HQVZkazJldUoxTWI4eFVWUUlzUzg0TDVWZklwTXZpdm5XcmJCN2lq?=
 =?utf-8?B?ME1Yd05sQVFVTGUvdHlQcGJlREExUVRlWFJpWXJYbklFSVJtdm54ZWtUTldI?=
 =?utf-8?B?alE5cVM0MWJzQ2RQc08xUkZzWWtPd0FDMlhvT3FvTUUyYktyVGI2L1lOUDZh?=
 =?utf-8?B?Qk1SRGlXZDV5WnMvOC9QYzlOdFpkS3h4MlZtRmJEdllEQVBUYUhlY0dOemRp?=
 =?utf-8?B?QldnTXNCcFBtT1MyYkxqdDNkc21uOEVmUUpRWXBXV3d0MFc0alpXaS9aMDJa?=
 =?utf-8?B?Wjk2QVZKeGpwRkFUSDlBMWdzcDBWTmdsMm8xV0JZVVVnQkRFVVA0MXgvcW1T?=
 =?utf-8?B?ejFINnhMTkgvRUtwQjZraGtOU3pHVndVSjJhbTZMRUNUeVVRUkwrTHVEOWZW?=
 =?utf-8?B?cEozVkZVakxnckh2b1JmYUtvZGZjYmpIdkZCeFRGR0Q5aVBnOUw4MHVZaUhn?=
 =?utf-8?B?SVNZRGRWdHN6OXUrVmVoQTZVUkFIcFFtVWplcGc4ZzVZQUFoczVubkEzNGxo?=
 =?utf-8?B?OFpGbWtZOU56c0V1eDluTUdmSGlpWVlIVU5jU3ZKVVBMSDM0Rm1la05wbGNL?=
 =?utf-8?B?SHVQdElPdlZ4aFcxdkNCdGFDSjZWUzBFOEdKaUdsTEd0ZkhWUmRxSkh5QzBZ?=
 =?utf-8?B?UU56WmlsN3pITEJsNnFBQk44ZmF6SzBWa0dvQ3dOWkgxTTlyejZDcS9lK2h2?=
 =?utf-8?Q?FiGY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:21:41.5310 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e518557-baa6-4acc-d769-08de1176523b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698
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

The function svm_range_validate_and_map() was freeing `range` when
amdgpu_hmm_range_get_pages() failed. But later, the code still used the
same `range` pointer and freed it again. This could cause a
use-after-free and double-free issue.

The fix sets `range = NULL` right after it is freed and checks for
`range` before using or freeing it again.

v2: Removed duplicate !r check in the condition for clarity.

Fixes: c5e357c924e5 ("drm/amdgpu: update the functions to use amdgpu version of hmm")
Reported by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index f041643308ca..a82915fe9807 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1744,13 +1744,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			WRITE_ONCE(p->svms.faulting_task, NULL);
 			if (r) {
 				amdgpu_hmm_range_free(range);
+				range = NULL;
 				pr_debug("failed %d to get svm range pages\n", r);
 			}
 		} else {
 			r = -EFAULT;
 		}
 
-		if (!r) {
+		if (!r && range) {
 			offset = (addr >> PAGE_SHIFT) - prange->start;
 			r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
 					      range->hmm_range.hmm_pfns);
@@ -1764,12 +1765,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		 * Overrride return value to TRY AGAIN only if prior returns
 		 * were successful
 		 */
-		if (range && !amdgpu_hmm_range_valid(range) && !r) {
+		if (!r && range && !amdgpu_hmm_range_valid(range) && !r) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
 		/* Free the hmm range */
-		amdgpu_hmm_range_free(range);
+		if (range)
+			amdgpu_hmm_range_free(range);
 
 
 		if (!r && !list_empty(&prange->child_list)) {
-- 
2.34.1

