Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 489BCC3A59D
	for <amd-gfx@archiver.kernel.org>; Sun,  7 Apr 2024 04:53:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5751810F816;
	Sun,  7 Apr 2024 04:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d3ThXEPy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0444C10F220
 for <amd-gfx@lists.freedesktop.org>; Sun,  7 Apr 2024 04:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO2CxzTzpmbHUbCbJVN7lUr+LKqqHWe4xxE6WeUaCHk674H4VW/yjSAgfb+dXpkPnrw0JshZinkcQ522+leBA0uZQ150rumPK7Z7W0SvEWMqt8/eVB2635jTRoUCW9jMMMIW3CwA4x8N4cVTlElJbKOxqPAIybuzeTN3zkE1AVm7QpN59oMxz7uj1zMvc4gcclCKvqBhV53JJe1tV7JCVnwkNBw5CFFnXOtKoZ44M98rYERvRw+EHePMI405EdvxA+f3JI+z8pi/KKKXGblZxwPw31pqGKz03ZW0yxzPAujgOH5xV1LB+Maywld5pvMx4spx1Nm7sX9Sf29K0yjK/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmrydLWD97XJcPUY198U9Ptd0FlfwLCu5mfiuypJyBw=;
 b=ZwWiqllM5AfkBiygIvJnnlJO67EJgBYLCZixNNr1woP0cf6/yWfHqKOpszfJb0QjSIwSQ3c+U9v/zyzrPEj2V3CVpbQ932q4dU5nUgmM+Kn2p3kCew5VDnjl2XGgvUCKlJvxXw0UaF9e3G7KTyhhk1QI4efKLnxokB3JCgQ3de4nnafdx93jS8xM9HXogIr5/0rlSJGcWnyVgubwV32DGfNFiGAL1t/4cgd7nmcTw5GZ/xN8pBat+YGzPWojd0GO9kT8NeDgAN58sh+nwhZZYcP+/ktgVm9t9IHk0t4lafib0dplD0FLcCPqPzebNQy2ej9RLHmkQab47LSeQ0W6hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmrydLWD97XJcPUY198U9Ptd0FlfwLCu5mfiuypJyBw=;
 b=d3ThXEPywpWtQfRqt2RUfn501h+NPP6cN9f/YOCf7PXTuHJaMXofLYIW3uF8Z0d+JFiQ7e4loxcYZ2ggqRkva/6c+5skWHjQeUvccotnnnduXO5ckVKQSI0/XzJH1sKJIaBvG+n2BC6IlEpqh0ftt4zawPxEkYq4zs0FaIxtvvY=
Received: from CH0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:610:b3::28)
 by DS0PR12MB7849.namprd12.prod.outlook.com (2603:10b6:8:141::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 04:53:04 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::54) by CH0PR03CA0053.outlook.office365.com
 (2603:10b6:610:b3::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Sun, 7 Apr 2024 04:53:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Sun, 7 Apr 2024 04:53:03 +0000
Received: from lang-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 6 Apr
 2024 23:53:02 -0500
From: Lang Yu <Lang.Yu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Christian Koenig <christian.koenig@amd.com>, Felix Kuehling
 <Felix.Kuehling@amd.com>, Lang Yu <Lang.Yu@amd.com>
Subject: [PATCH] drm/amdkfd: make sure VM is ready for updating operations
Date: Sun, 7 Apr 2024 12:52:36 +0800
Message-ID: <20240407045236.3487634-1-Lang.Yu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|DS0PR12MB7849:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d31f4f-8711-4cfb-a093-08dc56be9bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NtMWjmBY8pX2rLOFJI1SSXTeVE+tJC/kJNAdpNRN0EGJRq+XRLrlfpffld8pTv7WURbFj4IAkXpf5MvCr2I2XprXKVfoqEdPEHDZ3YMc+jPNjw7bgpwbaoJom2ZlCu9sjkianP606c+GWb072gCmoGsjq7NYK46/vaYBBsu0yjVKJpcnf6ujCDHmI0PgsGaRY1UrV40Wq1DTboEo+igSZFVK+HZBqhBIr0MFGzGykvmtPrdvIrY6tIwvsKT6Au2xyy5ctREfIT/bkz46gkKeCz0NF7uycjHgzBZm4Fd0qcFSODH9pJpjLZ0PTwabXe9YHrfFmSEyx9UkTv/2k5gN3c+RFwTYSICIoNk/ix17B3d4lU7v/brG46BzwMNYVneHSvvnZYYENvpEEJd+RhPmGvS7hbuXw38P2Ed54O2XcfVbLU0A2pjTNBNwkkBf2obpRZ6UrNJYKyJqnZYgmkGjt0aF8o6YdJBJSbQvz84+MbAEBCOgEhGdjMT+CBI0+/0C4gqlr9wV2/Utu+7rTN4QFGGGBUD/RRdsBLxGN1QaHsksXzCWvPtveX/1iaIMYEicZqfk8uZPRbc0HKQUY2zf9nxku9WQLrafNKqMHE5wWfCgBVrDpSqzVTHYXhBBbFVmG+H3yfW0fvnA5HnCQLXVsvR5fXQgVMVQJnjzP0vNqoCBt3boOZprs3RdN/OIW4kMeQ8bjriHiPX+bJSgkeZgyQMpK09AECLgx+cG8yF1gjecOuijJoN+uPWHKG8nOz5Y
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2024 04:53:03.8893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d31f4f-8711-4cfb-a093-08dc56be9bec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7849
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

When VM is in evicting state, amdgpu_vm_update_range would return -EBUSY.
Then restore_process_worker runs into a dead loop.

Fixes: 2fdba514ad5a ("drm/amdgpu: Auto-validate DMABuf imports in compute VMs")

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 0ae9fd844623..8c71fe07807a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2900,6 +2900,12 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct dma_fence __rcu *
 
 	amdgpu_sync_create(&sync_obj);
 
+	ret = process_validate_vms(process_info, NULL);
+	if (ret) {
+		pr_debug("Validating VMs failed, ret: %d\n", ret);
+		goto validate_map_fail;
+	}
+
 	/* Validate BOs and map them to GPUVM (update VM page tables). */
 	list_for_each_entry(mem, &process_info->kfd_bo_list,
 			    validate_list) {
-- 
2.25.1

