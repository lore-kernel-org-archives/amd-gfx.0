Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49672CF34C3
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Oct 2024 20:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9EE10E944;
	Thu,  3 Oct 2024 20:51:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1+mBVhX7";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79A710E944
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Oct 2024 20:51:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SKgMxo22ZYQYQLa6nrzi1hUrXoEEq8q76GnXN5VG5Qr3VA7OQslDlRitHHeP9l8hcRu/NvaBbSb4OPZ3kv2R05vK2CQzVHHFXMvTF1U/GmQ5DkjNN+kTVNVeFUD5NMG2SdAb/Y5Scxz47WWoHNbhASHbD9qC0EAiq9KTTxi/T23rHPDztfqI6HbfMSFFEXr3Ll9P+sHvdE0AOzKA3d+kZ4Qw3txKxrZFtIw4iVR67KZ2wdnDdQJa+dK0rkGoYbn9dUcEEEwpHTqBep0NzRUojwlBr/lASpv1KnyxJgdrsXQa8gsLb0lN0EeFl8uzEyMZyVe+/IeZuABNONI6vt67Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ax68+oV2cQ4N+7m+TkC6DHOD7PAQMuBTBESwKESJSzM=;
 b=QDeyzZE5Suho29JFzYxg9d85GtZ7gDxHAf0BHCLHHLi6GC4gkcfSJKkkk/NVaj5j7dB2OWyxbYNKXmNnlbykzcBrQhnMRaQ68Y3LeUEf882+KoKpsaMP761j/PTJLLbnS2er1T4PiNav20EfmRS9IzxbUdFWNbcE6MJyKwljzir21NtSpjh370+NnvVZIvuMiPFreZRWYDjB0jtEbOYFnAxRF4pnZHo6F3qzS1+VFPpYhO4uAo6HCc89ZWXVzEPbrrE2pZtPKNL7bcauRCiLKX9QRgN+nYZyU0nUJTFFgfnUKnkRwgy9Ouif2KpaL6M91Ydovynj4YuNXaoNrxqdIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ax68+oV2cQ4N+7m+TkC6DHOD7PAQMuBTBESwKESJSzM=;
 b=1+mBVhX7ybGpV2kqB8gvRyFTUp08pif+8z5bkG4goPZ0T73dmEJuPVdg0H3zXXbhDxyyMRjzFKJKPTjfueDGjPUF588O3+odCn0cpHZmcOqfaWEFqN2+kgktWgSjjRP6U478ioSR7gULoilSv/PBC/op6iywl3UhaIVBKG1Nt5o=
Received: from DM5PR08CA0055.namprd08.prod.outlook.com (2603:10b6:4:60::44) by
 MW4PR12MB7142.namprd12.prod.outlook.com (2603:10b6:303:220::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.16; Thu, 3 Oct 2024 20:51:54 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::c8) by DM5PR08CA0055.outlook.office365.com
 (2603:10b6:4:60::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 3 Oct 2024 20:51:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 20:51:52 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 15:51:49 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 15:51:43 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <philip.yang@amd.com>, Xiaogang Chen
 <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: not restore userptr buffer if kfd process has
 been removed
Date: Thu, 3 Oct 2024 15:55:26 -0500
Message-ID: <20241003205526.35748-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: xiaogang.chen@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|MW4PR12MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cb831ba-158f-4b7e-cd36-08dce3ed35f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CwxeJWL04CJIsjObGZUiWjqbOYrw/JbHK0DRykyd1dbofucXAH4YOKMhu5/w?=
 =?us-ascii?Q?t50Qb8ZQeABh6/IBBZD7ea9w22oQvuvlF/XNxhOClKvX2fSzNuRCLpA/MzGk?=
 =?us-ascii?Q?IWjS09/OtaA2Bjxr/f7eVNFDntOqBX/OTGlw2chLYm2bppcM75fAvbI8JSK/?=
 =?us-ascii?Q?yIAGo4siIVXUCH8dOLfiNlVD49Oz0iaqthZnsh5yooOb5Dg8N4Th3/ib9WI8?=
 =?us-ascii?Q?K3zInAv6ElZxNfJSnpzzP++50ytiSnAVr3TavmWdJfHzN68lI5WJ1UeAHgRc?=
 =?us-ascii?Q?tjd+mgGsXTMI2zWCdONg1tP774Sfkl0/oIhPUURBOPnOhqIQlyuCz36ptoXg?=
 =?us-ascii?Q?7/x5DNbH9uUZ94mFC3ahqxio4rNXLucjL8fRYuu1DKGwaKPrPQc122ejT92X?=
 =?us-ascii?Q?dw6My08FV28D2hlVYeYFuenHV+gmp/f6Zr9HsQMz7P+kB23LVW32daif0KfS?=
 =?us-ascii?Q?a1j2tac8zWciUZvKXISCQ0JCyvma0t/qa05uGKSyduVaQxZSc2hY/UwZn9Vb?=
 =?us-ascii?Q?ecNTbVske18FVP6gZs4itlFaE0oAkGpOe1EOoY0PO5uCUrOgbtST2dmlMkDS?=
 =?us-ascii?Q?TFoGq/nDUZ1gOsUaZVnNUlQciRRmI3ka8ANoyVBpB6WZelzIf0aKtw/Do/GS?=
 =?us-ascii?Q?3N/AQTzeiPGR12lQUClhWLcpsDgX0DcG/PXtOBo1JNiiSYFK2ym/eFyOCPGz?=
 =?us-ascii?Q?aRbslTSa+b2VmyyLorSDYGhFa5ebs5/QhyLgLeFsHIqA7p4i/3fomxJFS8Uj?=
 =?us-ascii?Q?iualTgocKJPCo7KLrkGZ18k6spN/44mlUsl4+l1fGBVv+gu0VEwpDPt4t71L?=
 =?us-ascii?Q?3Bvcb8f9YbpAZwMS7vajunE1SC4DQCueJNc2LPIKCfFojvUWBA22FuY065Q0?=
 =?us-ascii?Q?ij1h2wi8czfDf3fsz15CsFXLJ2GxyvlprNy1ugQy1zDzUwtIVjKRc1qp0CYL?=
 =?us-ascii?Q?ZFQsW/HsU/iYtYq1WOnI5fXXeOplGDbyobypB7GT1ihWYa7dALqYU23G5hWY?=
 =?us-ascii?Q?xaDjd8z4aJw3DmBm+d1i66AznPjIV+FeMq+RJCUxzXFJYlqG/umX54ThoRlo?=
 =?us-ascii?Q?23wJ6RTZdVT6ZkrRm1rSwYHGf0lCwKJpC7IChCOrYE/TKe4JVomA+/KWzH9g?=
 =?us-ascii?Q?YMX+gRVBLZfF79B1mXnPfFLVTL7VxiIOkZGORKA8847jHhX7b1KN4pfKId7j?=
 =?us-ascii?Q?Ru0bNdwgX9B4arpr1GpkU5z/SfCwVTkfS8gOIHeJtk3VOv7IS3MjGlSpAF1a?=
 =?us-ascii?Q?OJVrlxvJ3AAShGlRfsmrPb0MNN0q5DGChFt4YXmz/yI54DC8AVkEvHmMTDXb?=
 =?us-ascii?Q?f29Lec7QsjrRQ9CrGQy+yY/1j+jDQWKm+Qaw1hladlp8V8ckE7X0UxqKDbF/?=
 =?us-ascii?Q?FefrqUVEUjp5gGLNF6l8CP1wztm1?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:51:52.9842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cb831ba-158f-4b7e-cd36-08dce3ed35f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7142
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

When kfd process has been terminated not restore userptr buffer after mmu notifier invalidates a range.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ce5ca304dba9..1df0926b63b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2524,11 +2524,15 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 		/* First eviction, stop the queues */
 		r = kgd2kfd_quiesce_mm(mni->mm,
 				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
-		if (r)
+
+		if (r && r != -ESRCH)
 			pr_err("Failed to quiesce KFD\n");
-		queue_delayed_work(system_freezable_wq,
-			&process_info->restore_userptr_work,
-			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
+
+		if (!r || r != -ESRCH) {
+			queue_delayed_work(system_freezable_wq,
+				&process_info->restore_userptr_work,
+				msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
+		}
 	}
 	mutex_unlock(&process_info->notifier_lock);
 
-- 
2.25.1

