Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05F24C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 May 2022 19:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5939B10E3C0;
	Wed, 25 May 2022 19:05:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D538710E3C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 May 2022 19:05:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q+4WEeuetOQVdrXBRJat8O5n1k1j7PNGu+klMJdVJhhoSlYB4D2J8lncskU4ADmvz8LFuXiZTjr0e9+6tlXjvJrL9UumaKFi1rpTD+xcGo8PTr0yQaoJZRoYsdKcgX0rs3Vil3iAvuMz7sES7mDUlxctK8fGZL45p1eHKsoEIVppsJuLrLxDyB+ZjLocnP0AnfPQ0bbaYtgkgVtfZ632r+ZOJYDXwVXAaVQCJxYXpzTKobjPO8eYtgvXs2rYWXhwTsUjH5PjLYFL2YuC3oXfeiHh1wqh0DixypjrEL1S31f2FiAH8NhYmjPvVMTlSqsPo5/BZOTazL/FaNbDmT5ofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zozolg9LImf8qWRvoLikhVDhPu9E/r3azFhA8fPFTd0=;
 b=Uq5Ly/+RIz/FiiIYpueqrOucKTl1Syy+3em8xWgpFu+HHRPBryNJMXEDLSjtkniSDESEvlJHvpl9R42QGGwY6r9lvc/6LgvcEFj9N/7hSyltylNxSGnN8gJkQG5bFQ3cMT4wfylzKf96hnVP7rYLV0A1YUuCZ/IA0FRMVPhH/kxNihmBJkB2NNq8ck0/9RkWJncrKXUUzn7uXm1/UNnD0i34nUGqt2hxENcPaR2D7ndyvQfOwofpw9UOtbWj1ig10Gchot9L61CeE3FndggOF4UqGvbwcODblYkBGjREPh01MWBm7IPM9DnCE00XEcPV8+5l7v8SuKNvlAGLue1T4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zozolg9LImf8qWRvoLikhVDhPu9E/r3azFhA8fPFTd0=;
 b=MdkmSL6PG+T0VD9INa7ugVmdMUsej9ld6m1AbYPGttU+28D6QpEwyAnab/+8ZO+AqEZ4xI7rH7dg+8JsHwRGoqS+3lRQs33Y18wxZueIuFmZd4BTIFf0Z/pKMYlGYrbZwDg/fs0Xup+pggG7C0IiWIrJMaTu+HBqDgsLKGsHVlQ=
Received: from BN9PR03CA0218.namprd03.prod.outlook.com (2603:10b6:408:f8::13)
 by MW3PR12MB4508.namprd12.prod.outlook.com (2603:10b6:303:5b::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Wed, 25 May
 2022 19:05:17 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::a5) by BN9PR03CA0218.outlook.office365.com
 (2603:10b6:408:f8::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13 via Frontend
 Transport; Wed, 25 May 2022 19:05:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5293.13 via Frontend Transport; Wed, 25 May 2022 19:05:16 +0000
Received: from agrodzovsky-All-Series.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 25 May 2022 14:05:15 -0500
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 5/7] drm/amdgpu: Add work_struct for GPU reset from kfd.
Date: Wed, 25 May 2022 15:04:45 -0400
Message-ID: <20220525190447.239867-6-andrey.grodzovsky@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
References: <20220525190447.239867-1-andrey.grodzovsky@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 34d08f61-492e-4f82-1311-08da3e81817e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4508:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB4508EE37154ED750786DDE0DEAD69@MW3PR12MB4508.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9B9DN5mFCBzspGP8eQ6MRGh0T14zXUGqxlBC4soUqH8oq5QYOZjWdA8vJdWy7pJX39+QJd5wAa8gmnMHYvNpdpEJ7HZpGgA6OdM2Me2dbDdsGXBIz7uyG2KdqPoXrJd2jioyl0k/BvojEgg2kradx+ce6FMTeTp39lm3h0iGwkhEVCpI/8etrSQaunuG4xEVYp2x9NZikSEbuTAFuRja8HLyaLWp+X2piqALj2lWHEYBVNSai1Bs9mcCNjbtwD341BcDQZacgQSlwDjMck/WI+ThcqGGvvdc3Bbt8Ed9DJLnTWZe1zIK8P0z3nkW2phSwTzL+koThaSbYOVHSv/aJwgINTvpK9i2gKEE0HYNZPyJi5/KTG6coCsibkxpXkzUDZBVTz4vR7o6dQjCiPR9OYXI/WfgUmNL6gMWWkTxE8NMz7dq9sbc4M7WDB09UPVQXjssxeYAzmNRQyz1UcCmqADvurFwOtshMOu0yAoCbAOv7yV5KwEDFUoV86bspgRPbPmKqkyPolqwEOElZexbemICn/nftCcei8E6N+mFJ8rZOhkqD734W/7LQBwkHdiOHRJmLrfWOJY/KQ+QffNkEVmKkH7WxZT8tuGt9WCaGg35jXv2ZV+SLNDs7hKwIi2HQHzsPKAV7zd4SXo0gDABwKphUd1flHzHiJtituAJn6SNRHVYWaBwib1veUKGLVqul9h0rw4URkYuuEc6ijpqbQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(16526019)(186003)(1076003)(2616005)(36860700001)(40460700003)(83380400001)(82310400005)(47076005)(2906002)(36756003)(44832011)(8936002)(26005)(5660300002)(70206006)(54906003)(6916009)(8676002)(316002)(4326008)(70586007)(81166007)(6666004)(508600001)(426003)(86362001)(336012)(7696005)(356005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2022 19:05:16.9948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d08f61-492e-4f82-1311-08da3e81817e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4508
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
Cc: Zoy.Bai@amd.com, Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 lijo.lazar@amd.com, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

We need to have a work_struct to cancel this reset if another
already in progress.

Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 15 ++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 31 ----------------------
 3 files changed, 15 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 1f8161cd507f..a23abc0e86e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -33,6 +33,7 @@
 #include <uapi/linux/kfd_ioctl.h>
 #include "amdgpu_ras.h"
 #include "amdgpu_umc.h"
+#include "amdgpu_reset.h"
 
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
@@ -122,6 +123,15 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 	}
 }
 
+
+static void amdgpu_amdkfd_reset_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  kfd.reset_work);
+
+	amdgpu_device_gpu_recover_imp(adev, NULL);
+}
+
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 {
 	int i;
@@ -180,6 +190,8 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
 						adev_to_drm(adev), &gpu_resources);
+
+		INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
 	}
 }
 
@@ -247,7 +259,8 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
 void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
 	if (amdgpu_device_should_recover_gpu(adev))
-		amdgpu_device_gpu_recover(adev, NULL);
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+					     &adev->kfd.reset_work);
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index f8b9f27adcf5..e0709af5a326 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -96,6 +96,7 @@ struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	uint64_t vram_used;
 	bool init_complete;
+	struct work_struct reset_work;
 };
 
 enum kgd_engine_type {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bfdd8883089a..e3e2a5d17cc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5312,37 +5312,6 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
 	return r;
 }
 
-struct amdgpu_recover_work_struct {
-	struct work_struct base;
-	struct amdgpu_device *adev;
-	struct amdgpu_job *job;
-	int ret;
-};
-
-static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
-{
-	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
-
-	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
-}
-/*
- * Serialize gpu recover into reset domain single threaded wq
- */
-int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
-				    struct amdgpu_job *job)
-{
-	struct amdgpu_recover_work_struct work = {.adev = adev, .job = job};
-
-	INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
-
-	if (!amdgpu_reset_domain_schedule(adev->reset_domain, &work.base))
-		return -EAGAIN;
-
-	flush_work(&work.base);
-
-	return atomic_read(&adev->reset_domain->reset_res);
-}
-
 /**
  * amdgpu_device_get_pcie_info - fence pcie info about the PCIE slot
  *
-- 
2.25.1

