Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF77C5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59D4810E7D9;
	Fri, 30 May 2025 07:55:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OO74GLw4";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA36110E7CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:55:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyijJK+NeEXHqM3hm16Te6x6B7z7YwwRttyZpqvi0skCMbph6fmYwYqRKBHe+5xFWqQAqM3nD5qx7zp27alRFJ/A026am2BvFH1iVlHQP6GmM7rE3gpSyQ4BXXBQJrVgZttNL2HE9B7t7CE7Oe6+Mk7dm1Pleym8TQsIO75tUQFTtFtaEq/Src6hlATo2ehz/ANN1BSTWE+aVg0UTDuCfHYGflEGH+6uGz4cgE/1rbu1GxRRWZIrmMfn52ngS65a6ZVFXJll6p7Ii4pZ56slRuWSsE/KGprR+pDV9YmmSslqvxJNfTcImGVUcbFoIEodNSakRcyHHAPeMBKZXlpd3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPvRcwGIWj/kLAeFAKow5K9+nGuEftqpEqb323wE0RA=;
 b=DJ8Tt1bh8nPE0H4n3t7YiIQn1jBDafJmGL2jA41PPIZ2SFKJwRLet3RVMWLuku2tztKvA+cMymF7Qkl8fOPCEOVADgzqEXUVUzKNm0vglCouPRU9bG84Kh7b1S0u3AxZDr/6xeuUunWjIpvWpFs9AtEU4aqwREZibldt/i7ZLAI6BqnY3VvE+tiKXqLhuXhOErE0X8ujE++3Cegc5Hw5NA7QkSN6E23lPiuB05lmchGQy0zYsRTueqdw0+CxSiOX+BBakqWjKHBgfYGeHZtx0bgeh377g/C/q7rV+w2yRM9Aho7KtEqKVvf3yMJOZNsAbH2qP0QYd0eIMDR4ETdumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPvRcwGIWj/kLAeFAKow5K9+nGuEftqpEqb323wE0RA=;
 b=OO74GLw44FE0G6hA4+ADRwuQF6Mhyzl5lo/XdBpTtDPoJ6eUyvwDon4Xm5p8o+pIqJ85UedSrI6jns3V4emDGSDVLd4RdnpoAldoGvtGIhxX0cL0//1ApRlqNsXe5NtMVJ+cZKFPAmAHX85AFRErcPn337Fj5VAdHk2Cv/DzD/0=
Received: from MW4PR04CA0169.namprd04.prod.outlook.com (2603:10b6:303:85::24)
 by SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.24; Fri, 30 May
 2025 07:55:22 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:303:85:cafe::4b) by MW4PR04CA0169.outlook.office365.com
 (2603:10b6:303:85::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.22 via Frontend Transport; Fri,
 30 May 2025 07:55:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 07:55:22 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 02:55:19 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 3/9] drm/amdgpu: wait for the user objects done before
 destroying
Date: Fri, 30 May 2025 15:54:59 +0800
Message-ID: <20250530075505.882004-3-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530075505.882004-1-Prike.Liang@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|SJ2PR12MB7963:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e02af8-1661-40ce-e548-08dd9f4f544d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XpvMTPAp+P3EiHKoUy0YrgoN1AGrUMDNloTvfW5Wek+LIPG/HyxvODvSnWeq?=
 =?us-ascii?Q?l6MGnd+xdYfQ62s3CiKauiq/3vzylHBYnCo2r+UPJ3k/fyq+xwjRd+USHrMx?=
 =?us-ascii?Q?FThklNyjLf1KwlBd1g93IhTk7E3qVeWQk4Vdu/p5/pCQc9vwoHvAq6CSeN6A?=
 =?us-ascii?Q?rA4Lv5tNRDhEG9dK1FnZgDr1XT2BedcRjwC1IyOArwvhbRNLLvYQq0hysH8x?=
 =?us-ascii?Q?0HnuMr/1wLIK7MD6Xq1adbG4MyZUU+v9vvmHQlshWVkv63qAvDQLH4wkAS18?=
 =?us-ascii?Q?y6LgHEP7ZfIsSHVYvAhoGtnyXe0EXKZV6CzSX2kvV8AVReGOdNGN/fUg3z61?=
 =?us-ascii?Q?4Sl3/PO6NDg7Vs9r2Y5JNkGdNsJC0bVuDBNRSafq6LmdlmbFZlu8mfQmf0Yl?=
 =?us-ascii?Q?7Hyhipgd+oZ5xOeTlr0Zgx/DXdxqwQeVPq4Giq0KNr5hbo/VmfCboV0tBtt8?=
 =?us-ascii?Q?guIfT8y6lySH7fp/K58Eq9n7AiRVtoQilmRUXmZ47mFEpFMSy3K54oWqfCcV?=
 =?us-ascii?Q?YZ6xPLqezDO6/CkkusPBbyO15Cd53tQ0cRhUe24aoBCyHkk7ItDOklstBP43?=
 =?us-ascii?Q?iQkDNIqc4p7sHJFQW/u/DbT0tGHbevPNsRxCMqVFlEj7bCB5nALnlryV46f3?=
 =?us-ascii?Q?2wbAt3XWmUUKCT00pHUkpsIWgqssvekOqdbjtI3V6kGskhmnQ/G807nbMSxH?=
 =?us-ascii?Q?phSIRDA0FjjB554wv2acToFbSYspW0tdmAoO40ChXqB/LoIblxgTSAfB+DqR?=
 =?us-ascii?Q?hiGMxS6ENS8y3/UKU3Jus7FNhUp8CR+nZ2cn5dGVSwr+3WBV2BsIDOm0Ohg9?=
 =?us-ascii?Q?n5FjPQCEkWk7Z2G8aVaN4NWaY9NENuqSngkQxgE+1Sj2SfZYqQiZrJcx6wQZ?=
 =?us-ascii?Q?ft+lqfjLweKD8f73zyUzdEQRjzRyNDDTXtTMhhoXVJbQmQ2KSXh4sNQ4gXXe?=
 =?us-ascii?Q?1NlmMJ4o2gFVG5cCIuHJENOf33qdQRjlWuj5lKuBHw9fkVe2XUfI4ATJSJP1?=
 =?us-ascii?Q?ftqNPVG99UEdotT6sacBVGUt8IIO1kJr/JyogTBfm6vIGalqlFNB+GkmSJBY?=
 =?us-ascii?Q?J11wnViHxcZwWZzC+yXc175+bcNrm5yUZpQaOkOZKBnH9pfnW5odJCxP+Q5f?=
 =?us-ascii?Q?BST3QSDHgrMT/lq/Xhgt4203msLbgdJ4sHc3k15rIXKblvgqirwDrb+1dgnF?=
 =?us-ascii?Q?q34Kx5E4nC2i2tD/Ef4Gd2/ffS88qbRNRHT5tU0gmeE7Hz07pgIU1oJ7476x?=
 =?us-ascii?Q?lGAvjLpJfveQk1X0McsC7xGbK2L2ZYBNo4WvFXmTPsuXFUciCF8EwuH+CYbu?=
 =?us-ascii?Q?9T6On3csXbHw/rwgksFKDghjU2vyqLybCBkbSrirXJ76JKHCHUkaIGlsinB/?=
 =?us-ascii?Q?tR7Gm8RUT6afvAstU+UfHaa7t08GFw2hRkC3qu6a46M5p/BVGzLhldwzSqbX?=
 =?us-ascii?Q?L6d6KwPmSiV1MI1a8VVa4GEw0TkaKvosMXIMPtLksWANcF7+rbPY2XlDfNWH?=
 =?us-ascii?Q?GWx8bop6ew+18Yuo6PyOoBzIRRoJp38nSIYY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:22.0619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e02af8-1661-40ce-e548-08dd9f4f544d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7963
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

The userq buffer should complete its attached work before
being destroyed.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 3 ++-
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 8eea0e1e1b6a..f45585bd5872 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -217,6 +217,8 @@ int amdgpu_userq_create_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 				 struct amdgpu_userq_obj *userq_obj)
 {
+	amdgpu_bo_sync_wait(userq_obj->obj, AMDGPU_FENCE_OWNER_UNDEFINED,
+			false);
 	amdgpu_bo_kunmap(userq_obj->obj);
 	amdgpu_bo_unref(&userq_obj->obj);
 }
@@ -317,7 +319,6 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unpin(queue->db_obj.obj);
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
-	amdgpu_bo_unref(&queue->db_obj.obj);
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
 		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Can't unmap the queue for destroying.\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 1457fb49a794..b46e67b179fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -336,6 +336,9 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 		      struct amdgpu_usermode_queue *queue)
 {
 	amdgpu_userq_destroy_object(uq_mgr, &queue->fw_obj);
+	if (queue->db_obj.obj->tbo.pin_count)
+		amdgpu_bo_unpin(queue->db_obj.obj);
+	amdgpu_userq_destroy_object(uq_mgr, &queue->db_obj);
 	kfree(queue->userq_prop);
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
-- 
2.34.1

