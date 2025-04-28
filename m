Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 308EFC36005
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Apr 2025 06:29:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEB710E37F;
	Mon, 28 Apr 2025 06:29:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FtReA2dU";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2049.outbound.protection.outlook.com [40.107.243.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EA5010E1D4
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Apr 2025 06:29:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVxeL+QnBsrEhe086GnFx171HcYUmES2hatUITbWuRU58APhqqoDM2Z1l97WKD+JTtam3Xdcf8RDG2ryzazrrtzzuzMv1dOqa/fAHiigC2IR20DFTDkKNd1xCvWlQLhODP2nJjF6uZIZBpQvGWzLXalBMytWawFUr6jCajaDisNE0+xeLS+RMw5qV4J20p0Lv/QGjI918f4eh7Caw9rq+Pw8R/5N9bHhVEi7nl8KXg/NxXoBqGoUTD14jDdiYffnUTyL0910XziW1rT1tH3dZpL2cMwZuwCjtJEriDw8UN9eKjcoVrLShk9/ajoVNzGFpWIntlBxXPYuRjUicIG/pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jze4coWsdkgemP8BFZkfloNqg1gYonz2PCIloet2NUg=;
 b=d9G1a8YWMKz8wmCx5t6FOZaRpK4E5/9noi4svCgwj/lj6VeDVpKsbjJwDwwxk8bNquwK71lVM7vCA3yTrruySlMfAGrgjkCDrJMasgkwahJ9TC5hHym86xLgjE/wNmBmc1dcCDW0ZtNwuHgokunLRGkh2O178i4lZktzkg1SVaMY/tGabwSIv17kj1HfcbSVt7Ac9y/KLeWcidHxpXK2ujd6KDsCQC+KM/EapF+SHFS4eYXxzTr5t2YmQ+qiQx0ie0tNnyxy/OHa0FYZ5SMIKt6bPcgRTH1jVt1zY8maZe088+4QPKf7JjOKlRsieKtBoolaeqYbirFD9B0EaPTLXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jze4coWsdkgemP8BFZkfloNqg1gYonz2PCIloet2NUg=;
 b=FtReA2dUdxXE4fPswERmdMxAL+lmclCqsYTRWfcweSIpPMh98GIAu6+RPwUokQaYtX1AAs5lu2/9FRRf+ypOxuylY3OA7WJQhRcVuTln5UgsT8yf9vNnarkWkKpUYlAleXQ6fzv+xn02p6awhelTlSNLkz/SK7kYUfwJtlIReFw=
Received: from DS7PR05CA0103.namprd05.prod.outlook.com (2603:10b6:8:56::18) by
 CH3PR12MB9025.namprd12.prod.outlook.com (2603:10b6:610:129::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 06:29:09 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:56:cafe::92) by DS7PR05CA0103.outlook.office365.com
 (2603:10b6:8:56::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8678.23 via Frontend Transport; Mon,
 28 Apr 2025 06:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 06:29:09 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 01:29:04 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add user queue vm identifier
Date: Mon, 28 Apr 2025 14:28:52 +0800
Message-ID: <20250428062853.4057900-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|CH3PR12MB9025:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d59008-468c-4d1b-5943-08dd861dfbd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?becjnYpSpzup5X6ZBXGUgu4Kap743nmRbXe4FabcHG+JUv7Iyz7gexTAXeKa?=
 =?us-ascii?Q?OTa95CZnneN7fA6xjbOMnssd5ZJmkTcAAtZv8d4Ne8aQcqVldImHjB57mBE2?=
 =?us-ascii?Q?SCKETcv2Hzi0jXoYyA8XdspI0e/3ZyQ0bTevHycNh3aLxHirSo+0sdU8CxdM?=
 =?us-ascii?Q?2pALVU7ugTXUe3jU5O+GTnYLisEiCzVgXNGeI85LhGbhMkcxQ4i2AY2ZupsX?=
 =?us-ascii?Q?DcxmObyVhWai7Va1aMwrN1bRKHlh5YPCz542Hwl1Q/sXfI38WtlBn+yE75XP?=
 =?us-ascii?Q?OqAeNBD4WdvzBqk7zbE6MXxYC4dBmFEURbx+CCntxsSAHEQLoNidiBByrTx0?=
 =?us-ascii?Q?94bB5w7XjqMvT3/pTUEyjr2RoUBvZayCUYh9DFw11Y3lrJwW+jKlDDzMRiUE?=
 =?us-ascii?Q?dsQKDt0RZ7NbPKl6bw4eyjytizuhUnYvY865MC958d0c+Edno8pKK/C+N80a?=
 =?us-ascii?Q?n4g1JUAX7eTvX2YGlybqunSidsPTrLCBP/rK/7mUrxbjMVypH6/azmYHS6TQ?=
 =?us-ascii?Q?A1rhJw9xa0+JJsho/UGG/8sTHD9HLisJ8wp5Rd5OpX+3KVw+RujPGUQI5OzG?=
 =?us-ascii?Q?usGNNkefROuaAbGIbyVswdpr+ZRl0MZJzhSpq1IaKMYAm5o077pbsbzqA46d?=
 =?us-ascii?Q?L8K6cXEIB+qedUSNbF+RCnTjnXgrcw6gdUDdNpqHEE0Wc+l9H444MUNxY8jO?=
 =?us-ascii?Q?bKcR9bhkAjleeesGoV3fpo0Q+5Ao5k1V7q21K3Pvq5FevMqoVubgXkjKZkTJ?=
 =?us-ascii?Q?1JTkYFG8CDUcmX978A7e04tZ9V/SIPH5z4+wsRr0oAfpSzlSbAMxkcx4JVQ9?=
 =?us-ascii?Q?s1s3VHFW47WtxGSArUNU6qVyngN+9Wcvlj4861K2y+Z4g6uvlMh1K1TtAha/?=
 =?us-ascii?Q?jUkIfSPtB6swEdZByPFaXleusVwL4bvH9n57nR7lVj+hpODqZvzfQxHg3e3C?=
 =?us-ascii?Q?f+yFKdVcv3BBCbfe+DaGwc4OAN298BVfVwPX3P4usmYG3hJy3QWHhEKDg6dY?=
 =?us-ascii?Q?/nAVylhi3sqcNQwuW0OOPNSDJ69yXFLuvMjTu7j+IiEGACcUgBj/j787XBCx?=
 =?us-ascii?Q?F/8t9PkIKKQs7jFHtdqfIIOpmXE24VynKd8sPzBz7LGX97K8S+OdWWDsHOhK?=
 =?us-ascii?Q?xZzbIijIzMEACzAomsM3konNKQXYXtPoWOTPBdBXjaUhj5SYfmo0cEbe2/4k?=
 =?us-ascii?Q?VYP6AkIp8uPYzzdU7K0j9jGMaLLbx7OvB2bFwUwg/DoKpJu2ube9dgCjM54R?=
 =?us-ascii?Q?bd5U8AsXWuJJPhWfMF3ruJ4tcTFXUAGByoBa4vr1TJU1tRVls3S6YuhVbYD7?=
 =?us-ascii?Q?efu6xemFAQ6fdHZ5OT78APAieFK+NzQYLPQpneE/1hmPFwfiMCJ+YrXzfRCG?=
 =?us-ascii?Q?rwA44CxJipJ7XEvQmHqM76UO2EGWJ1rxpa9tnVx/uWtWX3PxtKYZSA6gkrth?=
 =?us-ascii?Q?lSR4l4WlwWfxGEMnhEzrRtTem7kxtcazkPXx0RPErWkVb9YuLy1Hu5oOYNpe?=
 =?us-ascii?Q?isgTQ7vKmhG2TOZ3vJIqBDzG2HghL9QV2GIg?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 06:29:09.3064 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d59008-468c-4d1b-5943-08dd861dfbd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9025
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

Add a user queue vm identifier for each userqueue
kms opt accessing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 451890ee3fb7..845051816af6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,6 +319,8 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
+	fpriv->vm.is_userq_context = false;
+
 	return r;
 }
 
@@ -361,6 +363,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		return -EINVAL;
 	}
 
+	fpriv->vm.is_userq_context = true;
+
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3911c78f8282..5e075e8f0ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2560,7 +2560,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	vm->is_compute_context = false;
-
+	vm->is_userq_context = false;
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..1e3c0f85c98e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -422,7 +422,7 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
-
+	bool			is_userq_context;
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
 
-- 
2.34.1

