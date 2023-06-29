Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F072CEB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 16:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5841510E3E2;
	Thu, 29 Jun 2023 16:10:06 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2059.outbound.protection.outlook.com [40.107.212.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6820410E3E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 16:10:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E5A1UU3FidnQYv8i2+JvWqFBYpctX5Xa2o+jnFqBZ+0dQhQJd0W3ztPvtqBCmmqcr+TBZX8BNOKeoDVvuNS5XhwjS5zxoXAjsQDeI2zT5onY6s1EW/CZj42R1b47+7nqU9/TjRBMzU7F7k7bPrLvU/2495XlGjH4NoNSgKBQ5nhuyX/Hkrsjc5Fcyzb/MMMK6WsqnXCQ2zUKXv504g8Ng57uI9T3RsLh/CaCzn7T1Gw1ugc6cgGhabA66xvu1uhUBPzO3U11+/E279J1P2SboWT8JHqJ7CgSdpksZnWttmR7sIfp+os9o0D34+EKdcj6dro6OERB+ldF0uDSLPIgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVgp+nSHTLNPzUtodNrQLFQodP/2XEL13J53j4UEHv8=;
 b=jyqjMQaRCSYdPNqmlf8yM/sJ1AoRHoafLHdJdr4MxOtHfQDczJXeCkzGNvkRZvMBUHAZuEDSRlzPl64w/zPwFPZIBk+5Kko7HiJL0uJTiuMHf9uRQ2MgcvbHjgpq1GBykK2APxBSTLkLv3MdCxU7+cqVRRreKsj78MTOfoZJclxMo5kgVDBewbLgFJcsNzHXZulax0bg/t+K9N/4jGCHmnC8JzqlswDJY3wvxkN9vU/VaDX+owBVFHafSfplvCs3uc5igiH3g2IhygebVHhByYnL543Won9pU1hGy+wVIvzIv0TTY+ieTHsY/HfZSV8Be4vpDE41VdyCbvAAc/17JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZVgp+nSHTLNPzUtodNrQLFQodP/2XEL13J53j4UEHv8=;
 b=LD5LZ+l3YHLhnuqD/zHG5A45jT5EuY9n1u1xpkY9sN3xgR31fRwNKHyMIH1jubiX+3y/Wfpvq8XYmBJJ/pCksVaGWVBQfzUcj14EtnGt+yZwoUJ9liVsyhFiyZJcKAaDwgsFFkptDFSQKvqs/JbTQBgpekRb2kVT+gHjwJXJY14=
Received: from BYAPR07CA0068.namprd07.prod.outlook.com (2603:10b6:a03:60::45)
 by PH7PR12MB7872.namprd12.prod.outlook.com (2603:10b6:510:27c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.19; Thu, 29 Jun
 2023 16:10:00 +0000
Received: from DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:60:cafe::bc) by BYAPR07CA0068.outlook.office365.com
 (2603:10b6:a03:60::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.22 via Frontend
 Transport; Thu, 29 Jun 2023 16:10:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT087.mail.protection.outlook.com (10.13.172.150) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.49 via Frontend Transport; Thu, 29 Jun 2023 16:09:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 11:09:59 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 29 Jun
 2023 11:09:59 -0500
Received: from Xiaogang-ROCM-Dev.attlocal.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.23
 via Frontend Transport; Thu, 29 Jun 2023 11:09:53 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: have bos for PDs/PTS cpu accessible when kfd uses
 cpu to update vm
Date: Thu, 29 Jun 2023 11:09:27 -0500
Message-ID: <20230629160927.1044392-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT087:EE_|PH7PR12MB7872:EE_
X-MS-Office365-Filtering-Correlation-Id: f525e5e1-5ff8-4265-8b04-08db78bb4a13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PXMoy9QjZevtzmd8gdwRXKCLZ4wogumLj7SYFAAsC7v7iMbO/ePgrLEINzRFeOxTDkg/VTRX00EV3jmwt7exPUfyR20QXR3b7E4zR+TejsPMWJJdEHYUDLljReU9NZ0T0F5UOqBx5lzTGALEdyJTyn2UXqJR0Jxa2UwHKGOJwwbhqNuB+T7MGZxYTRNw+PoBKS0KLEzFOgsbD7n19o557rfJTSXHCGUOgFS+oKytstUTMEmiQ9wxsqqCg9ycQWdOEOOy1ehBzFDFSxJmhuPN3qRN+Rw547tB+eJgRKZg+O33SklkyzffR1IWJz2EQgyFz8TtNvAX9dkEOt9Sro5Gyu6d6Z/aD/qrwar7zUbb8NYGnycSxL+B9pNoWEJR8+sZYN2QndS9RhU5XNhlhjNK4DXSPV4M6O9TVbtUfZvKa/fta4uHxUGIkzEoUlYk4vp7vc35QyDs3BB0eZTrDKCwhTBz+OU0Sebfjh0aEJ2kk4N5GS9lq1OLj4j3t2j8D6o2fNuoC9WJfLzUmRgvJDEnpw8buhNEFNN5jf02NNA+578YPopxVbSV8cjfS47MZ3ZmYAYwE3mQN571o11yHvP8AD6zal1P2dX2tcyc+jqSxHLv5kT4UEuqJslvFOu30vpdU7xUz+1y1g0LNwtaDn+1bnOCPHnyf3Z2SN63uTxI+CCvtpeBR4Vvlelr53SNbiP887HvJs5BSB6r2Uszv6wl1dJvaJT1eLYLlkbUjQFVrK/h8HYVlyvSRPa4ooMZSCc7b9fFESFC/bk6lXFhlCzFvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(6916009)(70206006)(4326008)(70586007)(478600001)(316002)(8936002)(82310400005)(8676002)(41300700001)(54906003)(5660300002)(81166007)(356005)(15650500001)(2906002)(6666004)(86362001)(36756003)(82740400003)(83380400001)(426003)(1076003)(26005)(186003)(2616005)(36860700001)(336012)(40460700003)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 16:09:59.9288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f525e5e1-5ff8-4265-8b04-08db78bb4a13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT087.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7872
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
Cc: Xiaogang Chen <Xiaogang.Chen@amd.com>, felix.kuehling@amd.com,
 Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Xiaogang Chen <xiaogang.chen@amd.com>

When kfd uses cpu to update vm iterates all current PDs/PTs bos, adds
AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED flag and kmap them to kernel virtual
address space before kfd updates the vm that was created by gfx.

Signed-off-by: Xiaogang Chen <Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 11 ++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 28 +++++++++++++++++++++++
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 291977b93b1d..dedf1bf44dc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2278,17 +2278,14 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 		if (r)
 			goto unreserve_bo;
 
+		r = amdgpu_vm_pt_cpu_access_root(adev, vm);
+		if (r)
+			goto unreserve_bo;
+
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	} else {
 		vm->update_funcs = &amdgpu_vm_sdma_funcs;
 	}
-	/*
-	 * Make sure root PD gets mapped. As vm_update_mode could be changed
-	 * when turning a GFX VM into a compute VM.
-	 */
-	r = vm->update_funcs->map_table(to_amdgpu_bo_vm(vm->root.bo));
-	if (r)
-		goto unreserve_bo;
 
 	dma_fence_put(vm->last_update);
 	vm->last_update = dma_fence_get_stub();
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 9c85d494f2a2..9b3e75de7c5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -491,6 +491,8 @@ void amdgpu_vm_pt_free_work(struct work_struct *work);
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
 #endif
 
+int amdgpu_vm_pt_cpu_access_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+
 /**
  * amdgpu_vm_tlb_seq - return tlb flush sequence number
  * @vm: the amdgpu_vm structure to query
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index dea1a64be44d..a08742191b7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -1044,3 +1044,31 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 
 	return 0;
 }
+
+/**
+ * amdgpu_vm_pt_cpu_access_root - have bo of root PD cpu accessible
+ * @adev: amdgpu device structure
+ * @vm: amdgpu vm structure
+ *
+ * make root page directory and everything below it cpu accessible.
+ */
+int amdgpu_vm_pt_cpu_access_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
+{
+	struct amdgpu_vm_pt_cursor cursor;
+	struct amdgpu_vm_bo_base *entry;
+	int r;
+	struct amdgpu_bo_vm *bo;
+
+	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry) {
+
+		if (entry->bo) {
+			bo = to_amdgpu_bo_vm(entry->bo);
+			entry->bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+			r = amdgpu_vm_cpu_funcs.map_table(bo);
+			if (r)
+				return r;
+		}
+	}
+
+	return 0;
+}
-- 
2.25.1

