Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECA4CC30658
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jun 2024 15:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3340410E908;
	Wed, 26 Jun 2024 15:04:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WnWJ7dhg";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C8210E901
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jun 2024 15:04:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TfNoNoonlYIYTa3nuEUO5qhFEaq1fc99mRiOpqo6dQFjMQZDTNt1nBY5Ue7HbTT7iXOHhYBDLo64rSjwUTO7Vzx4DGXicyZik/ZV9W/TjUaDytIdNr010qk/R9+Nqae/KlpCjynY33X7kI1hVhIwJdPCAEmJCkpnKSLxlP8iGtukdVt0OJb1OrnfafULvQX9FelNwaoSGA+CSFx13hKFWhSBdlhejtH2whJb6xDV5dIxxCEf9Vt9JVqn+Romht8pfsjuqFUYxDOwLIh8LeM+Z54OgqPWmT+ilzLY2bJCAMAUN3B6nkIzvWCaYOzgCTJjzzwoJ+M/EJ8TWjOGEQ5L9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+k70GiWumo9tOcTjvcq8E0o2Y1Ue6uFT3Jpa0I1QlFE=;
 b=P9LYrmN8LiW8LUwAmAuCAlTsRWndu7YyhiSxgkCuc8+PERRObJfR+UBCeb/ZT1zOTq+G76OP/U3DHkfcAU7gSxMY26jf4EoKTUO0MnNegUWlQIEM7Lvru1TzVlIvK6b4EQAWEYQZeXnjtUEN+ynOWYJ3DK1WqQZX10Rks9JHz7GKp4dUHiOGqyvbNuA5TDrHSU+7z4ju623XxNRwTesHWy7divX9xY0lhx/QacnAsc3QICLxA0BPsGgsNxwZoeJP6oFmFRpjlinOgDcQc/XDbzxckHs70fJ8mR4qCMbSHFXPias3V7a7iqTy1ToVtkh2R5htGs/6ID+Ex+egPIcqDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+k70GiWumo9tOcTjvcq8E0o2Y1Ue6uFT3Jpa0I1QlFE=;
 b=WnWJ7dhgHIPadqgySMib+Ofv0ZoCxCVd9q8REEpk0qFt5BYBA+OBS8UkrEXfGFqWSXheEutuHvib1bsgOH6kzeQHI2ZCwoTk5yTLSPuwAwkL2WmaG2zVyIdHbG1COToeFRN/90Czqtm2S19y0PGydmAihc9u2t98EFPqVUACL7A=
Received: from SA1P222CA0160.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::6)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Wed, 26 Jun
 2024 15:04:19 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::9d) by SA1P222CA0160.outlook.office365.com
 (2603:10b6:806:3c3::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Wed, 26 Jun 2024 15:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 26 Jun 2024 15:04:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Jun
 2024 10:04:06 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 26 Jun 2024 10:04:01 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <Philip.Yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: Correct svm prange overlapping handling at
 svm_range_set_attr ioctl
Date: Wed, 26 Jun 2024 10:06:33 -0500
Message-ID: <20240626150633.157464-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SN7PR12MB6984:EE_
X-MS-Office365-Filtering-Correlation-Id: 063cb023-27b2-4af2-eb13-08dc95f14128
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|36860700011|376012|1800799022|82310400024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x29XlEqiajrazwitC2+upk//M+5yrTF+bblt39E7SijxLLIpHfBUR+9SOx2x?=
 =?us-ascii?Q?vvm//BoZMG0nVLcJ2nYZb/ZQ9I0/c33qpnsRleyCq6mJA1TKRASsbDT+OY6q?=
 =?us-ascii?Q?Nd5v7gCobgY7LgtmqMiXGDmETaZfHt0/i0nLyFS8L7hWh0MsfOv+dId/fxLU?=
 =?us-ascii?Q?ofSTlyYFVaYd2BTjvn7OzMxnct4vmwTcfopTKMuiEXNiSLDztfjJV9Tohl4Q?=
 =?us-ascii?Q?T9FULIY31z2OQ8Gx/XvEIa8YgniW9jHHC3AZyxN3aQR5e2/D3ElUbVdddmT4?=
 =?us-ascii?Q?tI9kHhxcIn7qEoVBw0v7CJLSapVRt4UG8MCdrl/S9WhDQg/b7fo65LCd7IiB?=
 =?us-ascii?Q?3X1n19y9TaCI0UsVNeaP1HuEMWt9kBNTfGyqOlL5c0WYLKllL+jKEYaEleAD?=
 =?us-ascii?Q?Gp0syP3jsk2UaoGgz9h2Cv5NUrWu1reRoqpjBGif2jGc47f8Hqh0OLFd8ddQ?=
 =?us-ascii?Q?uBg8jCNpkLD6VXMbyoxxGNYZalBRQ+aZI+VMyOHfkB71+kiAhWiW6KSd2f19?=
 =?us-ascii?Q?Tq8lFMlXh/rdA9oXiNw496sia0/d2vNyP3lpUvSFeT6aWYtJJYghRYlH34j2?=
 =?us-ascii?Q?DSFzGdkW/GQn1NYlr4CcRs/jdqcnrbekuc9BXh1mIgjf1OeFfVgtwt97MgnE?=
 =?us-ascii?Q?mZJ6ATmPa6FWQu7QHTlpOmRONSlPk6QRXONeHThgRVJFAIQ17EUUHNJJvT3v?=
 =?us-ascii?Q?p/zynvb4g3cBwjlFR1+kRfbTDMwk8GC4fpGls00d+WLuuFq/3m1sshpKtLdu?=
 =?us-ascii?Q?6JciUJJ1C+n/H+iIZ4ep/EIj8Bs77hcdunBuRHHsb6t6pkGUgMGOAg7aCgMp?=
 =?us-ascii?Q?JF8L52qdZPUyW//hyUIfeuL66+knfAl8jjE8rD6DhqoHXKM6BW0CoqBsgVoF?=
 =?us-ascii?Q?p6fQbou4rcZlQ81qpNa/atUbIbZfFp0TE6ZNc66Eyd3OaQMPAHmuPYhpNd23?=
 =?us-ascii?Q?rqYmxhNQjOmB9PuLsdvGFO38kvyaXHaaWGg3+UPYMsO8kcSPwotdRQBdy7xd?=
 =?us-ascii?Q?954IVH6i+EJFoi2+tt3Umzal+HdDP0Se+GjXxBm3BruN6kmz9xNZnJWkuTWN?=
 =?us-ascii?Q?wBk7MoBrY69oZAkDXD3zvH6eAfx+6ZjJQ0tfcjRj3JldKzTkUGmhvlhbzcl9?=
 =?us-ascii?Q?Swg9pMEylxDhZJdP74hQjKDd4R8oZ2z/VqWTNz4NCn5zVMXYukE4mBJvXE5a?=
 =?us-ascii?Q?iBQYLDEgI4C2XBUYdOq0NNI5Z6iZM9Kpz7gkps+xNm5xDYo9fc1KrJevnJ3D?=
 =?us-ascii?Q?XEvcJypDJzNjWJ6NgNTYXbD5DX+xi2GtVF+TyUrm+5MvoJ5liNyUR/tRF7zJ?=
 =?us-ascii?Q?YtP3juBBtauQ9FT5McMTF2rXHz0zYuYbZWyOvtEm+eBTCSryZ06kOgyKwxFl?=
 =?us-ascii?Q?alshsq4rh/oJIU2kIgcQpa2rPMe4W6Nig8Raqewce+EA2QOkRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230038)(36860700011)(376012)(1800799022)(82310400024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 15:04:19.0906 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 063cb023-27b2-4af2-eb13-08dc95f14128
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When user adds new vm range that has overlapping with existing svm pranges
current kfd creats a cloned pragne and split it, then replaces original prange
by it. That destroy original prange locks and the cloned prange locks do not
inherit original prange lock contexts. This may cause issue if code still need
use these locks. In general we should keep using original prange, update its
internal data that got changed during split, then free the cloned prange.

This patch change vm range overlaping handling that does not remove existing
pranges, instead updates it for split and keeps its locks alive.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 112 ++++++++++++++++++++-------
 1 file changed, 82 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 407636a68814..a66b8c96ee14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1967,7 +1967,8 @@ svm_range_evict(struct svm_range *prange, struct mm_struct *mm,
 	return r;
 }
 
-static struct svm_range *svm_range_clone(struct svm_range *old)
+/* create a prange that has same range/size/addr etc info as old */
+static struct svm_range *svm_range_duplicate(struct svm_range *old)
 {
 	struct svm_range *new;
 
@@ -1999,6 +2000,25 @@ static struct svm_range *svm_range_clone(struct svm_range *old)
 	return new;
 }
 
+/* copy range/size/addr info from src to dst prange */
+static void svm_range_copy(struct svm_range *dst, struct svm_range *src)
+{
+	dst->npages = src->npages;
+	dst->start = src->start;
+	dst->last = src->last;
+
+	dst->vram_pages = src->vram_pages;
+	dst->offset = src->offset;
+
+	for (int i = 0; i < MAX_GPU_INSTANCE; i++) {
+		if (!src->dma_addr[i])
+			continue;
+
+		 memcpy(dst->dma_addr[i], src->dma_addr[i],
+				src->npages * sizeof(*src->dma_addr[i]));
+	}
+}
+
 void svm_range_set_max_pages(struct amdgpu_device *adev)
 {
 	uint64_t max_pages;
@@ -2057,20 +2077,19 @@ svm_range_split_new(struct svm_range_list *svms, uint64_t start, uint64_t last,
  * @attrs: array of attributes
  * @update_list: output, the ranges need validate and update GPU mapping
  * @insert_list: output, the ranges need insert to svms
- * @remove_list: output, the ranges are replaced and need remove from svms
  * @remap_list: output, remap unaligned svm ranges
  *
  * Check if the virtual address range has overlap with any existing ranges,
  * split partly overlapping ranges and add new ranges in the gaps. All changes
  * should be applied to the range_list and interval tree transactionally. If
  * any range split or allocation fails, the entire update fails. Therefore any
- * existing overlapping svm_ranges are cloned and the original svm_ranges left
+ * existing overlapping svm_ranges are duplicated and the original svm_ranges left
  * unchanged.
  *
- * If the transaction succeeds, the caller can update and insert clones and
- * new ranges, then free the originals.
+ * If the transaction succeeds, the caller can update and insert split ranges and
+ * new ranges.
  *
- * Otherwise the caller can free the clones and new ranges, while the old
+ * Otherwise the caller can free the duplicated and new ranges, while the old
  * svm_ranges remain unchanged.
  *
  * Context: Process context, caller must hold svms->lock
@@ -2082,7 +2101,7 @@ static int
 svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	      uint32_t nattr, struct kfd_ioctl_svm_attribute *attrs,
 	      struct list_head *update_list, struct list_head *insert_list,
-	      struct list_head *remove_list, struct list_head *remap_list)
+	      struct list_head *remap_list)
 {
 	unsigned long last = start + size - 1UL;
 	struct svm_range_list *svms = &p->svms;
@@ -2090,13 +2109,14 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 	struct svm_range *prange;
 	struct svm_range *tmp;
 	struct list_head new_list;
+	struct list_head modify_list;
 	int r = 0;
 
 	pr_debug("svms 0x%p [0x%llx 0x%lx]\n", &p->svms, start, last);
 
 	INIT_LIST_HEAD(update_list);
 	INIT_LIST_HEAD(insert_list);
-	INIT_LIST_HEAD(remove_list);
+	INIT_LIST_HEAD(&modify_list);
 	INIT_LIST_HEAD(&new_list);
 	INIT_LIST_HEAD(remap_list);
 
@@ -2117,35 +2137,41 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			/* nothing to do */
 		} else if (node->start < start || node->last > last) {
 			/* node intersects the update range and its attributes
-			 * will change. Clone and split it, apply updates only
+			 * will change. duplicate and split it, apply updates only
 			 * to the overlapping part
 			 */
-			struct svm_range *old = prange;
+			/* prange_dup is a temperal prange that holds size and addr info
+			 * updates of pragne after split
+			 */
+			struct svm_range *prange_dup;
 
-			prange = svm_range_clone(old);
-			if (!prange) {
+			prange_dup = svm_range_duplicate(prange);
+			if (!prange_dup) {
 				r = -ENOMEM;
 				goto out;
 			}
 
-			list_add(&old->update_list, remove_list);
-			list_add(&prange->list, insert_list);
-			list_add(&prange->update_list, update_list);
-
+			/* split prange_dup */
 			if (node->start < start) {
 				pr_debug("change old range start\n");
-				r = svm_range_split_head(prange, start,
+				r = svm_range_split_head(prange_dup, start,
 							 insert_list, remap_list);
 				if (r)
 					goto out;
 			}
 			if (node->last > last) {
 				pr_debug("change old range last\n");
-				r = svm_range_split_tail(prange, last,
+				r = svm_range_split_tail(prange_dup, last,
 							 insert_list, remap_list);
 				if (r)
 					goto out;
 			}
+
+			/* split success, insert_list has new head/tail pranges */
+			/* move prange from svm list to modify list */
+			list_move_tail(&prange->list, &modify_list);
+			/* put prange_dup at pragne->update_list */
+			list_add(&prange_dup->list, &prange->update_list);
 		} else {
 			/* The node is contained within start..last,
 			 * just update it
@@ -2178,8 +2204,38 @@ svm_range_add(struct kfd_process *p, uint64_t start, uint64_t size,
 			svm_range_free(prange, false);
 		list_for_each_entry_safe(prange, tmp, &new_list, list)
 			svm_range_free(prange, true);
+
+		list_for_each_entry_safe(prange, tmp, &modify_list, list) {
+			struct svm_range *prange_dup;
+
+			/* free pragne_dup that is associated with prange on modify_list */
+			prange_dup = list_first_entry(&prange->update_list, struct svm_range, list);
+			if (prange_dup)
+				svm_range_free(prange_dup, false);
+
+			INIT_LIST_HEAD(&prange->update_list);
+			/* put prange back to svm list */
+			list_move_tail(&prange->list, &svms->list);
+		}
 	} else {
 		list_splice(&new_list, insert_list);
+
+		list_for_each_entry_safe(prange, tmp, &modify_list, list) {
+			struct svm_range *prange_dup;
+
+			prange_dup = list_first_entry(&prange->update_list, struct svm_range, list);
+			if (prange_dup) {
+				/* update prange from prange_dup */
+				svm_range_copy(prange, prange_dup);
+				/* release temporal pragne_dup */
+				svm_range_free(prange_dup, false);
+			}
+			INIT_LIST_HEAD(&prange->update_list);
+
+			/* move prange from modify_list to insert_list and update_list*/
+			list_move_tail(&prange->list, insert_list);
+			list_add(&prange->update_list, update_list);
+		}
 	}
 
 	return r;
@@ -3533,7 +3589,6 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	struct amdkfd_process_info *process_info = p->kgd_process_info;
 	struct list_head update_list;
 	struct list_head insert_list;
-	struct list_head remove_list;
 	struct list_head remap_list;
 	struct svm_range_list *svms;
 	struct svm_range *prange;
@@ -3566,7 +3621,7 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 
 	/* Add new range and split existing ranges as needed */
 	r = svm_range_add(p, start, size, nattr, attrs, &update_list,
-			  &insert_list, &remove_list, &remap_list);
+			  &insert_list, &remap_list);
 	if (r) {
 		mutex_unlock(&svms->lock);
 		mmap_write_unlock(mm);
@@ -3574,21 +3629,18 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	}
 	/* Apply changes as a transaction */
 	list_for_each_entry_safe(prange, next, &insert_list, list) {
-		svm_range_add_to_svms(prange);
-		svm_range_add_notifier_locked(mm, prange);
+		/* prange can be new or existing range, put it at svms->list */
+		list_move_tail(&prange->list, &prange->svms->list);
+		/* update prange at interval trees: svms->objects and
+		 * mm interval notifier tree
+		 */
+		svm_range_update_notifier_and_interval_tree(mm, prange);
+
 	}
 	list_for_each_entry(prange, &update_list, update_list) {
 		svm_range_apply_attrs(p, prange, nattr, attrs, &update_mapping);
 		/* TODO: unmap ranges from GPU that lost access */
 	}
-	list_for_each_entry_safe(prange, next, &remove_list, update_list) {
-		pr_debug("unlink old 0x%p prange 0x%p [0x%lx 0x%lx]\n",
-			 prange->svms, prange, prange->start,
-			 prange->last);
-		svm_range_unlink(prange);
-		svm_range_remove_notifier(prange);
-		svm_range_free(prange, false);
-	}
 
 	mmap_write_downgrade(mm);
 	/* Trigger migrations and revalidate and map to GPUs as needed. If
-- 
2.25.1

