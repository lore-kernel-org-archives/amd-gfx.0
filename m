Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2DA1CCD1A4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Oct 2025 14:31:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4613210E45D;
	Mon, 20 Oct 2025 14:31:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Wvlh0WwW";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011059.outbound.protection.outlook.com [52.101.52.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 366E610E45C
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Oct 2025 14:31:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUas4iXJ9bXPSHXg7vd92MEqmm91iPfWUF9Duhd6Hc+h5iH9y1bX/zTETLLyTG2A5fqgmKL6OYF3tQcPngUyBzbAlVNAvVSxg55kEosHm+AZLRR3FFY3CgnbwOVOs+EQwIfFwkC+StSyC2ys0HtyuVd2hh9DA6WUulPURisA5Ge+d95F7TQqW17sc6FqJKrDqTEVqw90VBvycwdka8p1B7rzYSWTKqcdj40jVZfvuI1XpxW6euA37AnYc7GvMyvPAHtVWH99alLcvpdmc9p7BfuoFpBgt40mEVOfrIS5bn5rbJNsJ17CzsFs1kwf9pn3ptMKDHDYprUmpBXqyAe1Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8FsKKuCKJzifv/4oO8mpE57yRAlrR2YffHdVl3UCROg=;
 b=J5Eh0nknvjoNHzgLctPkJCcLh5z1CHDOgF3FW9t7QGb1rHXiAmPy3Uj88BoW2XreRWXgc9VGNvQd6vcHUZ8Q55HmXUzn2CDSCkza5VROkof73ZFAxzmORGC1nQ3GvcGoZX4UMBcezRoFsO1oRXvxIJApGSbkykj6G+kGT788YO0rT5wP1oll4PqSOqRuVAAppPharGic6//xuAHiEJtSrDSMnKntkhDC+EuEgWHV3tVSSK/cCA4qBGw9Z9YesCuPyIEyape4x4ocddZilfu5EThn8Ar5DgnZuDnOG6iKbfdoyPxstrDOdiuU0Eti4pqYqmlutSdj/RsxIXxsKMWQ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8FsKKuCKJzifv/4oO8mpE57yRAlrR2YffHdVl3UCROg=;
 b=Wvlh0WwWkUx73DGOjuXTjzSNlw9FZWQlfAXBsjgAHDnaXZEAA1G/SZpO0KYgpXV0VmRl2U1IFpc4Zd9q4MyZxGk01F2iNNM2Ql/e8X01A1G7RGf6yjPJtjNVIZJHQNezj9QUurfInp4cLqAOlvCUgI3I0dkat8OR4NjehiMhOlg=
Received: from PH7P220CA0117.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::34)
 by DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 14:31:00 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:510:32d:cafe::67) by PH7P220CA0117.outlook.office365.com
 (2603:10b6:510:32d::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 14:31:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.0 via Frontend Transport; Mon, 20 Oct 2025 14:31:00 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 07:30:58 -0700
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>, "Felix
 Kuehling" <felix.kuehling@amd.com>
Subject: [PATCH v3 2/2] drm/amdkfd: Dequeue user queues when process mm
 released
Date: Mon, 20 Oct 2025 10:30:16 -0400
Message-ID: <20251020143016.23409-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251020143016.23409-1-Philip.Yang@amd.com>
References: <20251020143016.23409-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|DS2PR12MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: c50266b7-fd80-4734-c312-08de0fe54a79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hxfq0FJMzly+VSdpnIGqGtz5DoYZkdCtggUO6WYols6dDeOvCoLzoCgME6Ev?=
 =?us-ascii?Q?Pg9R1ryunLvxEvhmUZ+ugdUllKOHxGSLLtU8PJn8aE6adrlAPXb22n9KOYc0?=
 =?us-ascii?Q?37jlmkaUF1xN8jhBnJllUb2u/uWARcuJkqVmaLXxyRrSr+IVeQQqkG74vtr5?=
 =?us-ascii?Q?2rQg/nLLQLqRH9qVEd/7AjVXPnwPvY/c3m6c9bfWtKOnqBHbDsstTrilAMcL?=
 =?us-ascii?Q?fCPmIOPP4hN/8OKfhKA+8MRwUE7Q2ZwaqDwrn1GOUcYk0npQbWHwTHBAxm0d?=
 =?us-ascii?Q?OfaRP+Zmk9xpzr8YhhAuvnFmTBLhaduyCWHaJf1cQexoTIiqp7I7p8XmprWO?=
 =?us-ascii?Q?7D0nMMDK/ZjPSBKOzZciitZVN4Xzbxuye38Oiubd9YsBRNMqG6AU2dC0TIQS?=
 =?us-ascii?Q?wmoZ/+pbrAszhvcJKOHzIcczdi6Kfv1qQFHeHH12W9g+78UYJzbqLfi9SoZZ?=
 =?us-ascii?Q?IkWVdauH63+mVMISSdTN5LEIKklxROb1YHoviKq5EAOZuFmwtsh88U+nLAMt?=
 =?us-ascii?Q?FT4bUrqE26BHNforUel+L8khp/mwpsuVMvVoKDOxo0d8y9pGevzpysC//ScP?=
 =?us-ascii?Q?JXT5RBxBw0hWnNmR3N6o8O5JCL5wtz1DywvYVbOIv6DjVCAS6aacAX12qRVy?=
 =?us-ascii?Q?/GWFNoLtTY90w21aiEM1d58ch0U5EUTzjCh5dnhNrKotIyGjXxvslwv5Iw5Y?=
 =?us-ascii?Q?uNxw6gVVhEiOV5u4Wi8JaCRqXzMZTF3DLTODGv0hWoEPWXtjSHUt936gMavL?=
 =?us-ascii?Q?1oUb2iJt5z9V0ll50yytgHaDRi9ovHLtUmMtYWoiG3HjCDnd1yHq3Q6967UB?=
 =?us-ascii?Q?6ZqTyX+HoioNBxsaMq0kkKY5emTbv5jylRM+KLLGvsaUDwBAr6mISesuXrXM?=
 =?us-ascii?Q?88Cm/FW45kp6uVOy5T9HDDpUwwjV2K+Geb6XP9HGrF9whiBS2N5nNCWVBDK6?=
 =?us-ascii?Q?g9IG3ymJgD6d8YmZl2bkOo9A7+NSVjFgTqhYKsTnnGF+zkVDdQeIWFW3gKWm?=
 =?us-ascii?Q?Yb4dviZ5zvHGuN9ZDwTgo13jPP8TSByYB0KdKD0mmOPt4YGfqKDSxvh142As?=
 =?us-ascii?Q?ssZOQWjM2a3CmfDBXeQJOGa5xxqZ4tLQkilhddxM7Hfi5C0vWAKVFYyfBLFt?=
 =?us-ascii?Q?qx7O9BQg/2Pp7opD7wl4ZAcWI+OKEvQn1am3Qb8QVB+eJGic9tYifR7Xx7CQ?=
 =?us-ascii?Q?aaeg+d5LB9Nhv0rL9BNLBpTI2klxnZiTX9hQ45nnPhUznrcmTJ1HgCZiZKwG?=
 =?us-ascii?Q?JUFLdZdkorqHo90YbG5Fwi6hyE3+gwpIdMjTFTCwKY1LvxTKRAMHqqrU8gyO?=
 =?us-ascii?Q?lf+DOVmHFWMYazYvUdxZdhmoKAHd+hnjc9v7YRTK8TKQy835TlBJZugfl3SM?=
 =?us-ascii?Q?2qlaMci0F8FyqXGLL4/9bJ8XFoeE1JPF+LgIUFU3L2O7diFEjeslxrp6SWM1?=
 =?us-ascii?Q?xpyFnV4GN0ILUhjmk8dAwdq74EjmNkE5J1/cDgjskEVt/c5xdcVlh5ZKi+7s?=
 =?us-ascii?Q?pK5QtYqBS7ABS3499t8U/k4DMlmrm69Ma2MBG4Pn5j5VnDp52oQGaHrOw2cD?=
 =?us-ascii?Q?a6bi8B8EdjAPuXzbciI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 14:31:00.3278 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c50266b7-fd80-4734-c312-08de0fe54a79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710
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

Move kfd_process_dequeue_from_all_devices from kfd_process_wq_release to
mmu notifier release callback, do it earlier to ensure no system memory
access from GPU because the process memory is going to free from CPU
after mmu release notifier callback returns.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 849456ac498b..9080d23d22ae 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1162,7 +1162,6 @@ static void kfd_process_wq_release(struct work_struct *work)
 					     release_work);
 	struct dma_fence *ef;
 
-	kfd_process_dequeue_from_all_devices(p);
 	pqm_uninit(&p->pqm);
 
 	/*
@@ -1226,6 +1225,13 @@ static void kfd_process_notifier_release_internal(struct kfd_process *p)
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
 
+	/*
+	 * Evict and remove user queues because exit_mmap free process memory,
+	 * it is not safe for GPU to access system memory after mmu release
+	 * notifier callback returns.
+	 */
+	kfd_process_dequeue_from_all_devices(p);
+
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-- 
2.49.0

