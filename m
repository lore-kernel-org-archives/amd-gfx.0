Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CEBC02194
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Feb 2025 10:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5393D10EAA4;
	Fri,  7 Feb 2025 10:34:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4RKrqLl7";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDAD10EA98
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Feb 2025 10:28:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naYBN6jJYU575AqTCwL0pkx6TSp7PNQO3i1tlKwjlR6RGU+8jI9lX9CbunS8e2xQlnIhjOjaAPxH7ZMYcwcKXNifx7r9LQcE9gcLPrlvPh/5E4UDqGmh92Ezg2Gv+NvhLsxkVQZ7+42R4VD/puNVqe7CDUOXnm5yUgt+hKiQT+czNXZhygwKdiTUA+VeC8neQvb0SiU0qSae6LQGnjWmNcl6sNqodJM6x6WLFEvmuXOU/JULrdGqdsY41oL0Db4s4l4Ud2QGo2TUDjpyTB63YeXrTWFfiSukoW1G7+sLLWbSXyhFe4fp4TvLAWiW55TzCi9MAorecm5XQHnDzofv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWeItVxUCJPXjj9hV0sMWXZa7ks5VbQNp+XzBaWYrCc=;
 b=hLG5Vcjv2z8adGiXDqfro+FnWC/kF+TnJBAdtQWhhLXnWkMu0UCgsOxwbnOERgLIInB06umBgOGP6qFsuXkPaNF68MFEbbdqWCOoIy7fvHWmQ/4LWXwYvGMvZiasaYbc8Qn+x99RAC29E7tvjrCQIr0bM83h3dDCNNCZVyzyOA90YRD3nbpersWUcdeDXdZ/pHe2Xdm+QCelpWnOGDJiJpMcyg7Kx3I1P5uM/UVfIirsSoPdiArNXnt+U0C3eD4nwSxoyVA5KocOC/DwQIDzfKqfHzJMPiRqmJWiQ3RVHqBzLL0tBDcdRuYcCp2UpWHTjGNHHlXmYm+a85y88od+tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWeItVxUCJPXjj9hV0sMWXZa7ks5VbQNp+XzBaWYrCc=;
 b=4RKrqLl76zmqXZcTOR1/X/vorpA87FnGTfqPRS6ck5i0Ypmx7xHF6ZgDFxvLa81lMcpsuJAKXvpRKGLL0kVVEeJLew1sHlcz+9J6bWJCOrQIVCcPwH1H8VDxhTzaSXUvMIOf3fWI54ctcfWxN0eOMBL2gNU9kzNGXP9gjbp9Thw=
Received: from BN8PR15CA0022.namprd15.prod.outlook.com (2603:10b6:408:c0::35)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Fri, 7 Feb
 2025 10:28:33 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:c0:cafe::27) by BN8PR15CA0022.outlook.office365.com
 (2603:10b6:408:c0::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Fri,
 7 Feb 2025 10:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 7 Feb 2025 10:28:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 04:28:32 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 7 Feb
 2025 04:28:31 -0600
Received: from emily-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 7 Feb 2025 04:28:31 -0600
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdkfd: Fix the deadlock in svm_range_restore_work
Date: Fri, 7 Feb 2025 18:28:23 +0800
Message-ID: <20250207102823.1565467-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: d325f1ad-7192-4711-f620-08dd47622c1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TTCByH1zwFIQOWIbiMpK6IFlexAI7bsUw7/49qRCcsmWsxyGfxALwyx4lNsc?=
 =?us-ascii?Q?xdcdk/U/nenTRoaqGuxFqiEDCek7Ud1S9G2YYaWA+OTR9bFhkF6djChYuUIX?=
 =?us-ascii?Q?rhhAAEtipO213g8e9o4UjDRD1SiwXWzWCiXs0bwg3ZQGslLDmyf2TsRcMG1b?=
 =?us-ascii?Q?2AnwfZjyf8wwo95QynCMq5SrN6qGsLNECpwY3dddH54d6pI//wI1lfM3pI2U?=
 =?us-ascii?Q?oWX7HCmvz6q9RFvyqDgZU/Iy6OqQpSJejWzZ32p928lX+UMEu84nk/IHXIsM?=
 =?us-ascii?Q?wi6l7nXcKHTxI1E/KGU+ItKmQyt37FLUdTalNJdlCUlW8GCzVNoC0ia/cJWM?=
 =?us-ascii?Q?I/2sBua5+txEsc8pXZQO/UbuCEQhZnTd6br5TiXasqbfofJe1InswO5NIB2a?=
 =?us-ascii?Q?AGZX5hDtjab/9PXml3Z9ibXRp74Cxmlq2+PI645HjRESPi0jNzSdQ/gVTE0L?=
 =?us-ascii?Q?hmrdCFtD3dNGE7o07VgHFfn2airlWzs6PkuKiMl1dyhuHRwEctsNM3xyQuwn?=
 =?us-ascii?Q?jfqsekU33j2hXD8BM4lm4vOoxKIWxCxh44x8FR93Zmz+Tvxnta6Ycn8Sr/yM?=
 =?us-ascii?Q?5SwCzrJpA7RHcUNE4hXoswxduokoLJAzP+h0hIUdT74Ki2iny+Iz2MpSI/BZ?=
 =?us-ascii?Q?P/4D6Q9kVPltKmzweV8YvoeYpkKfzJYarea1ZAZX9hpi1OWkVMgMVYdtmgi3?=
 =?us-ascii?Q?gQBsEnS3bqjCCvEiKMdfpukNFcf+cqSb5GhdoucKDKhajAZW/bXw1XPyTHe5?=
 =?us-ascii?Q?p6Q94QNdZLg4h6AI5JvbOwHm/hoUaErr2s1WAwrwI9cGTta4uvYiMmPYNkkp?=
 =?us-ascii?Q?UtAEYjvr7PkYcr1WsIu2iOei/QcelV9A/k4qTQhLKnB7cI/nT2D4EGzuDT1q?=
 =?us-ascii?Q?nPqoBItYwFr0h2eg/SBnI5JTmHn6guNJu4ipOMWMd6AAnXwbNVLuGUPjmkl+?=
 =?us-ascii?Q?d1ivS7/mBF/AwAjEuKmexSCWS0UlAt9Txd/YazpTDapDX7LLxEB+9mUCNvqD?=
 =?us-ascii?Q?zBmFuBTgP3tT57jN+Tn2bM7bTGOCLXEcMUXALvbfDXhxOz+hUd5SGAA/+w3C?=
 =?us-ascii?Q?9Bfbp0z0oCPa1yJKtc+K82q/6j9f4oBuW3rlstbB668lzm58lJgDGYGPuRu1?=
 =?us-ascii?Q?V2woSsI1xeWJuKx+oKPoRJZ/9AizcBmdImLkqak7oN7tVUQliENpEdLJ0QrV?=
 =?us-ascii?Q?x8gwYlDK4eMbJUpVeXBsRa5aNLkveAQRmjw0ZbYD4TO+dHt/ENqGL5OaTBIt?=
 =?us-ascii?Q?vsxWwbG9W9p/2e3fal24o7+lqxmHyWL2Y+oKZ9LrngqQ32NCy2zM/xuahBxp?=
 =?us-ascii?Q?m//7sGHXlHzE4imV02qjgJIE7DVHrSsiO77IcdUlLf3RET5dBaPQIdvaEeQ7?=
 =?us-ascii?Q?1ZNWzYZyDYdZPTMu5ZlAK+OFwQU/ZsTisLyL43T3kmgnGZtAVj/eK1QtSXJi?=
 =?us-ascii?Q?TJOawyIgxbMVyjEFGzKMJ9k4ovWgEI9nlKx6R4O/n9CN38JKRB22NKuPfrno?=
 =?us-ascii?Q?dSNsweDinnGFTJM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 10:28:32.8250 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d325f1ad-7192-4711-f620-08dd47622c1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849
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

It will hit deadlock in svm_range_restore_work ramdonly.
Detail as below:
1.svm_range_restore_work
	->svm_range_list_lock_and_flush_work
	->mmap_write_lock
2.svm_range_restore_work
	->svm_range_validate_and_map
	->amdgpu_vm_update_range
	->amdgpu_vm_ptes_update
	->amdgpu_vm_pt_alloc
	->svm_range_evict_svm_bo_worker
	->mmap_read_lock(deadlock here, because already get mmap_write_lock)

How to fix?
Downgrade the write lock to read lock.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index bd3e20d981e0..c907e2de3dde 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1841,6 +1841,7 @@ static void svm_range_restore_work(struct work_struct *work)
 	mutex_lock(&process_info->lock);
 	svm_range_list_lock_and_flush_work(svms, mm);
 	mutex_lock(&svms->lock);
+	mmap_write_downgrade(mm);
 
 	evicted_ranges = atomic_read(&svms->evicted_ranges);
 
@@ -1890,7 +1891,7 @@ static void svm_range_restore_work(struct work_struct *work)
 
 out_reschedule:
 	mutex_unlock(&svms->lock);
-	mmap_write_unlock(mm);
+	mmap_read_unlock(mm);
 	mutex_unlock(&process_info->lock);
 
 	/* If validation failed, reschedule another attempt */
-- 
2.34.1

