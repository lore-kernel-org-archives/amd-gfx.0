Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07127CCD195
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Oct 2025 07:31:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A163D10E6DD;
	Wed, 22 Oct 2025 07:31:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yf6eSwN5";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBDF110E6DD
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Oct 2025 07:31:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SJwX1zFjeudh8OSy92VV1GYq1IcXSr/hDbnlaEpGdhMaUfrmV79uo6Fpd/eN9p2fdPSRP44zK5t0OyGDHvh3N09DF2adAEUf2R89Rj/J41hLig80u6d9LjycFHO6R2TYyJTJ/jZcuI4lFnLGIRlbpMxZMKvvNP+cS6Dl0jCHFunwZD2PhKQ/KNxz2nLCwuj8PTMLRgIrDz+0DkW303zbss085v6w3LeoujUaFw8mlJAARChi6LblLUL9pSeDc8b24bY8Vpb3vazsV3suUHblXLUw4LNRzl530l1D/9n6Skgb3PXH8265sOOrJYrdH1yY2WRm9W2eZOb/jr+H5Q2qSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+oYYGch2MWJip9jWEmiEMPkHlBPoNwI2M7hOS6kcXtQ=;
 b=efVBMqN+zpu2OjRjS4Ya+Mp99SKKYUK0MvMHH/imvJKVPntG4I1pkFuOnaGtTyrv7Zx3TS2TkGyp3ZtL4gTKyNtFVEGZTfb/afuQUtsKTRCfSnCiPWNv0SjUUyEHPFonDs+20+R7v+/ApGkKRzga0NsfKEKFbYCIgWKDBC3ZB2SxmiQU6c1xdpgJXW3W25swIAB4Q2I3Ds9BTyyzijbZXbtvth+NTIY/LyykU33aiB9iwYnprhnWj3FFJnfF725mYsPn51+eJOz+PRnzTHk/1VD4jQrkEkOOMNHi10Xkg3S+fygt7R3U0q9IXbi36/8c3yWYcg3LSDX92uMgp3rfKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+oYYGch2MWJip9jWEmiEMPkHlBPoNwI2M7hOS6kcXtQ=;
 b=Yf6eSwN5S+cD6FnuqU+7Je5IJ7YcnTEqg5W58eEMRbvEz2XEjKX61/+OTsy8f0k9QouuYBO4yS+ozumyPs8l13Yo3H1yQuYQwnlXY/Z5aOnUBjM3gDJwkPFWwdJesH3hLVQk1qebhvsah7HZnNCGH6aCZ7CR4PANsntbYJzNh0o=
Received: from MW4P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::6) by
 SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Wed, 22 Oct
 2025 07:31:29 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:8b:cafe::6d) by MW4P221CA0001.outlook.office365.com
 (2603:10b6:303:8b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 07:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 07:31:28 +0000
Received: from fedora.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Oct
 2025 00:31:26 -0700
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <felix.kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH V6 11/18] amdkfd: process pointer of a HIQ should be NULL
Date: Wed, 22 Oct 2025 15:30:36 +0800
Message-ID: <20251022073043.13009-12-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022073043.13009-1-lingshan.zhu@amd.com>
References: <20251022073043.13009-1-lingshan.zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d7e4ea8-84fd-4e82-9c38-08de113d03cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YH9yi+5uQv2q+oomQOslVEHQAPEdaXeFYuCHW8Al1JfMqCowp34hqMdR/yPp?=
 =?us-ascii?Q?ynLoITezyjkc1lEMyWUxg4/WZOpojKqNZ5PBGKhVgFJgyQQkvKyMDkkD03Ji?=
 =?us-ascii?Q?+ZXH26V38DFCdXt6v3WRpbkcVRy/V20UePg4Q9ZF+G6rQSGINa3xNT5i6wjM?=
 =?us-ascii?Q?f8AUqi90sU0csjyPLST4enW5TJyRdyAnCpmAF6VSS2V7uhsBs9h2PCerzZlr?=
 =?us-ascii?Q?+0BezJcJmI/IeHDKXwurLcuiGYWKMTVCERmAx+huxGCkC+8Hbv3k2iRL571T?=
 =?us-ascii?Q?FqDZpUQh8Z/Dsgsn0f7Zkt60+IDmRRQvGxSw6CD3NV7mLetNEGqKvNCcRzK7?=
 =?us-ascii?Q?gtIuw6CeQ6lv1Xo2ynb5uZYw6QJEwpzNMPzuI4iiODOmeueMDX/+W+rOaphD?=
 =?us-ascii?Q?VLpPeeWG3bPDRfTcVGfwYoRJ8VhpR3cS5pre6tUboxUgOTFMmDQ6bZ8KlR4f?=
 =?us-ascii?Q?bYUV0l0WvAXOlqVV9ceiKt2JeGA3HUXDi4mfIPa2RghP+c/6fOF0XPmFyOAl?=
 =?us-ascii?Q?wHLGKSBUAMNhZ3VRAgrpQFgvD0UiRSsC4agMND3iNyOT0MksyD9CwPn3GFc6?=
 =?us-ascii?Q?hGKR3lUJE+bRDpzHDr/HAKXIaNcZF6O+KeQqFQgMiOLKzrR6SZ1HQe8RAwIh?=
 =?us-ascii?Q?GNLf7USZJ+UPl0snoc3sBLBVCuH5xH6PsM88KCpXH5yw2s6mVpeLdMNGZg1i?=
 =?us-ascii?Q?N9X5NJWbnGJ2CWEk+1/sRzaZjDcERT2ZgcpMNTgINpqLk+ORBqIBo8z/gGlQ?=
 =?us-ascii?Q?IHk4CcdiFL3rhCVOCtzhWcQ+w2VBBssvjqAPCZxI7xbBuAGz9XLhD1Gu8kjs?=
 =?us-ascii?Q?C0KILMb6jWRdrQaVR0ILAoJDQ6vMRirge0dyWGZKtU9+dVqXsFtyXruprwJ8?=
 =?us-ascii?Q?up/uGVAL5slmulR4TjHbsNABPqxsVtf9/GT+KZ5O4HPf2t/BrAiERG3MxGSn?=
 =?us-ascii?Q?zPmuHHA8mkuCfwlu4bgYz7ET9NxBGuKR0btiYvTDvRoef28r8T4vD/6q2o1K?=
 =?us-ascii?Q?+HArejoNnP8gtFDW+0+K6ZkYnb7jKUHxd0T6dUPgL8JjX5kob9WVdAps4If2?=
 =?us-ascii?Q?iFLJLWQ0vFkCuPq8YsVdsvE2KGVJ2g7ugmPd/836czXxYeDK5vhK9nFrgUCi?=
 =?us-ascii?Q?nagk7XknfR2bzYZMIn2RaONljJyniSzUH9/9T41JQzZtlI5ZArrG46pqf2qd?=
 =?us-ascii?Q?LOj9q9I5fKjOS8S+vywmUTYgkZtCnInBi3bqAGxS+ogOlMD9MAqyPrjbJ59m?=
 =?us-ascii?Q?GdiAxDW5kPHgX3+7ZC/J5GBEWbrEKUQ+xCfOYvGODYDP4A3W9YCrYl9noueZ?=
 =?us-ascii?Q?rm1cGqB5ql9kCV6P+ttMmVJL+vz1FFIeHKefPKmt/wJlJ3LZ2NFo5iL7QQom?=
 =?us-ascii?Q?t6K7EDykYo8MlGbAMVdc3AtrgPqEGE61ov+Gxn36zb55+gVbxaXzu/7hG8KU?=
 =?us-ascii?Q?vlNmwet4aXw44wOJIJMHvVzencdTOC4oGohlHj5vhPIN9bhNafamA54cpN8z?=
 =?us-ascii?Q?Z/V9K3kY/DmnDKWD25xDARm/f35huSUx4FfHo+W56+KYVsuQlLF2mxAGnRVh?=
 =?us-ascii?Q?9RluRMMCyNLqBFjj7cg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 07:31:28.6196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d7e4ea8-84fd-4e82-9c38-08de113d03cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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

In kq_initialize, queue->process of a HIQ should
be NULL as initialized, because it does not belong
to any kfd_process.

This commit decommisions the function kfd_get_process() because
it can not locate a specific kfd_process among multiple
contexts and not any code path calls it after this commit.

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 -
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 18 ------------------
 3 files changed, 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 7ce4531ec3bc..19ea759568a6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -129,7 +129,6 @@ static bool kq_initialize(struct kernel_queue *kq, struct kfd_node *dev,
 		goto err_init_queue;
 
 	kq->queue->device = dev;
-	kq->queue->process = kfd_get_process(current);
 
 	kq->queue->mqd_mem_obj = kq->mqd_mgr->allocate_mqd(kq->mqd_mgr->dev,
 					&kq->queue->properties);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 8c9d02d9d437..b6ad546c400c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1059,7 +1059,6 @@ void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
 int kfd_create_process_sysfs(struct kfd_process *process);
-struct kfd_process *kfd_get_process(const struct task_struct *task);
 struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
 						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index f1e8ce61290b..6b39d6314a0d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -985,24 +985,6 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 	return process;
 }
 
-struct kfd_process *kfd_get_process(const struct task_struct *thread)
-{
-	struct kfd_process *process;
-
-	if (!thread->mm)
-		return ERR_PTR(-EINVAL);
-
-	/* Only the pthreads threading model is supported. */
-	if (thread->group_leader->mm != thread->mm)
-		return ERR_PTR(-EINVAL);
-
-	process = find_process(thread, false);
-	if (!process)
-		return ERR_PTR(-EINVAL);
-
-	return process;
-}
-
 static struct kfd_process *find_process_by_mm(const struct mm_struct *mm)
 {
 	struct kfd_process *process;
-- 
2.51.0

