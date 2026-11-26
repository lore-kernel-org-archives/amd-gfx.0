Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634E4606A332
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 02:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Rid9u1q9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6AF710E924;
	Thu, 26 Nov 2026 02:11:48 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010002.outbound.protection.outlook.com [52.101.56.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8610110E924
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 02:11:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxiOHjl0AYw8eU6r0CsR7RjB7pTwENz0bsutWNoXDmSgzvjmfLDOjLZ/fh+WdEw9rARQomnUaKOu+mFpPP4u0YZ4jbeKA7N4hZiRzwjpp9Vew0yA7hQ6cXjpaZC5IbI8XNCv4AZvtEQD93ryfpiPfUPRA0Bqc4hgCcU76azUmR7eJSdZvVIGM1nYVgwb1cAfJjH/r/MdpljamRK7SzJtRBzgupHuM2LfPkozb7ZmoyN/6E355ds1jzCX/LDuhKBF5w0oJWIx9n72e6maO+ddTWoj1WIIvMUMyFO/4xXmyi/kgIuJ5nRyMWJanYejEqzfXXn+OvHkwLzVKyV9JFBjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBTKIbP6LpIOYVD9fKlAzvNVYdrb93yFSwMeMJnqLBk=;
 b=ezUQbMynvDwatBRJAjPyvNQDuI3c3PU1n450SxptYQXkgSRo3q9SPIO4GEROH3J2tcbvMXieeUG6qpl/LOkSw4Cud5cF+enylL6RxXOk/6Baw7sLpSvmo0/opzcUvWwO9Y5BkWasRPhK7uOxocXneZhODcwMBY7jfCwQfMT2zrqUTUZ1HzggPCOHdNv2Y95fxA+weoQpzeqjZZRTVgIkuWO6hmLvB7/yeo9Dv/YnzhP+qLFPeKz7rkfkUKFwRXN33OuAELAGxT9K5WBPynl9CddoY7ZDrVwfMI9htdXwsVOGr2cutQym1fhAvDm5QDF5DXS3OOA6AstJdbW+Rz2FlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBTKIbP6LpIOYVD9fKlAzvNVYdrb93yFSwMeMJnqLBk=;
 b=Rid9u1q98JwT0bW7ruN8MeQ4O+ziZ91Nm02BjpneJVzdjYlFIS0jIPieNuvEbUTFe6eyEs65IaJWY62MnormkLrv9d+xj3VZv5wpG03EWSvgc2jupLJIsrgvGdiv9rsjHwXP1it8sbk12yVP18ANpEWHGztfkcaMxj336CwfRnQ=
Received: from BN9PR03CA0733.namprd03.prod.outlook.com (2603:10b6:408:110::18)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Thu, 26 Nov
 2026 02:11:36 +0000
Received: from BL6PEPF0006C3DD.namprd02.prod.outlook.com
 (2603:10b6:408:110:cafe::6e) by BN9PR03CA0733.outlook.office365.com
 (2603:10b6:408:110::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.6 via Frontend Transport; Thu, 26
 Nov 2026 02:11:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0006C3DD.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.688.5 via Frontend Transport; Thu, 26 Nov 2026 02:11:33 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 20:11:32 -0600
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 20:11:31 -0600
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3 2/2] drm/amdgpu: reject userptr BOs at address 0
Date: Thu, 26 Nov 2026 10:11:03 +0800
Message-ID: <20261126021124.3809452-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261126021124.3809452-1-Jesse.Zhang@amd.com>
References: <20261126021124.3809452-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DD:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a9e71ac-5c5d-4b03-b6cd-08df4b6297a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|22082099003|18002099003|11063799006|261026121527099003|56012099006|261021123027099003|261021121427099003|261102123227099003|261009221727099003|261009223327099003|261009221227099003|261009220027099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: dgcYwozAl6XhzWT5exY/48C259Vsghd/9iJIKKg9bnN6KtLTWnEjg4JkpOGR/rK2/zPdGuwA5vq0090QyfWheTDw5UveRHlpPllD5C2/3Np1iYoAzeUnesJe9vNRdyr8Jga29CoJNg13P563ZUgftqNZOvVV3fNqtZUyK2+i7/k4LAJCeW/uVAA0M2yopctWPx8V6ETAkos+ESJ+AQZ86agfV8b6FK6Nbn2pqitHfvlMkS5A/o0KFh35o/Q6bA9Zm3EJzCgWstsvkucMKraRIn1tFNq5rFY5TjweInUPqurYgT9kK1W4fwPQI9m0EqDhROAn9OSSHyqta0DxJZ3IyEo4GNWuRz2O6epuwNRRZQ1FZa+2LoXCwzPN+Z1nQ0IUhtJv4QgPnwRKpy7xWkavL27XHW6Mu29iRnP4TXUpkrC9U3NoTHKgbvKUiNGFel+P7shinfU+nMq9yllWZY+/2opRuYWFp0lpXWOXYdHF43uV3uYosNiAMv7WF2GRRTEEMLrec3/QJ51ekG0Thp+JIP/ZomSG5Gfjfajjf9hqcx4sWAimJv+LVHiau2/8AK7WuB06yLCneuJDcVcRacNTGdfKb93y4SlOkHghVLuA5SQ+UIVlpQU0RKBShwxSNWk+9Xak+N4G1lkkuZBp/lkBO6xA9qZ1Nc1KvQAnvAvyxth2SDG+G0n0TQN9WyDEFpmt6nYfGc8WMX0d+C9IQRqBhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(261026121527099003)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261009221727099003)(261009223327099003)(261009221227099003)(261009220027099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XptPSwGqsGGcwm8nUWorgLPsJ70yNkr6srYkGIoa4NKKzXXK+DFLF9wvVCgoKnsSeGXb7kIxuwrmu/6BxYERVlx+miU/Sk6kw1Exw6uh9XVk4fY3jxeH+JonqBEYHo8o/yJRmutmaKuFeGFq+7z6kdzM1sfd81+TiDMTiQi4MY/ahZKn24yVCj9ZN8r7BIUvus7fQT/lLCt5s/l2lunaft7dsrlMd1uzRI/6yD5p2Grt57GrvENmqnbsNvFMwRHaHMhukIgAL8fHJhe76aTclO92HSNHP5yvJO9CftOQx8M19Do+Tf7hLT8DZzREFlUnKYZQe4NQC4OTa7rxs8YZTaODMV39Hb3UaCwnzBspydvLuFRtaXfNe9jtCMp9NYujMdr+nB3m0+sYnJFrTTJBuaKm7zrFJ/YZpVayUsy5y8NFkY/HJDrNOwvcnTbxVzoM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 02:11:33.2750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a9e71ac-5c5d-4b03-b6cd-08df4b6297a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

amdgpu_gem_userptr_ioctl() accepts a userptr at address 0 and registers
the MMU notifier for it, but the rest of the driver treats
gtt->userptr == 0 as no userptr. amdgpu_vm_bo_del() then frees its
bo_vas without the notifier_lock:

  BUG: KASAN: slab-use-after-free in amdgpu_vm_bo_needs_update+0x5d9/0x6a0 [amdgpu]
   amdgpu_vm_bo_invalidate
   amdgpu_hmm_invalidate_gfx
   __mmu_notifier_invalidate_range_start
   madvise_vma_behavior
  Freed by:
   kfree
   amdgpu_vm_bo_del
   amdgpu_gem_object_close
   drm_gem_close_ioctl

Reject address 0, as KFD already does.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index eb7473ed9e0e..67b2bba3d9e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -571,7 +571,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 
 	args->addr = untagged_addr(args->addr);
 
-	if (offset_in_page(args->addr | args->size))
+	if (!args->addr || offset_in_page(args->addr | args->size))
 		return -EINVAL;
 
 	if (!access_ok((void __user *)(uintptr_t)args->addr, args->size))
-- 
2.50.1

