Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7174CC4708C
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:49:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F2C261278
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 20:49:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2C261278
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE4906F62C;
	Fri, 28 May 2021 20:49:50 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FBD6F62C
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 20:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=noT639mCYoWr9MSpHNiOuyg64K9MnPHsN14v3vEjELo4Wv1xHBeQrBLQvXFrgJvlMzZO7+u5dsRvm9P1WtH5UepHsXrOwY4C9diKCEthPgLOQsBffdMWnOxm8i+xCZe2DMKXxgjrHVyCiG7h49N82M7FOiIMwPGCCnQJCUBcbP5gR90I96217U5dqLzThkb7qfq8ogYe86lgq+M9WYJ4aViU3B03+zaZVgoB951W/7p76Ph5+c/Yo4Vh2aNxaIQcih6zPaN1ZMTVR+gULdlP/j3VnXypsv+XVHBQH0E+hZjYzxAUWEXIJhav37Moa7r5F4PdDWgF70wqg7D5MyZXww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSXPmPuYp9fuGOr8KvsjG2D0Lvr6QZILTksnggAb5lc=;
 b=HAwa/erY/rGHzHR2DsJT0v/g91MLNf5GcfqQaDwuiNAPvG7qTZNGIObB3xqfNp9FGLdzQYMrAtcEavcdsuc3eZ+Kgvy3G2CcC/UbjgXl78RcooENfWF/Y/mWIIzQW4w9oroJgaRK5fhtw1qrIh9m2YAG/LIafL5zx00X+jsacmQz5gXTfefuse9ZzegDcnmaUwI3pMwgOX9pcWSsn4eskp0apKIIMMB1PSqSH/SJQHyPTSwrrseN721L0YUJ5qFU+rXqK8yiVP+rwOE/L9c4t4YbB+ks7BQiJfQ2tfbE87mB1L1a0K0Yf4lN/h6ax8Wm3PLSRqf+GyHMFmyro0U8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dSXPmPuYp9fuGOr8KvsjG2D0Lvr6QZILTksnggAb5lc=;
 b=unKo/RrFZMyt7NfbfaneWUdp16i5wT979PKAh85tz2H4P9bSNRCkgmAXVpjfyCNLOr6rWgc0pDJjb2GbO5sIC/XuawISVU/RLAszNHd/Kix7OF18+p5+wMtvzsc19NIT9ZHURSJO/goT2HvkaHGA2nMd8JqJorP2xoIRCRmkOX8=
Received: from DM3PR12CA0073.namprd12.prod.outlook.com (2603:10b6:0:57::17) by
 DM5PR12MB2519.namprd12.prod.outlook.com (2603:10b6:4:b5::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20; Fri, 28 May 2021 20:49:46 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:0:57:cafe::37) by DM3PR12CA0073.outlook.office365.com
 (2603:10b6:0:57::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 20:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 20:49:46 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Fri, 28 May 2021 15:49:45 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amdpgu: add a function to get vm page talbe entry
Date: Fri, 28 May 2021 16:49:04 -0400
Message-ID: <20210528204906.245661-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b7931ed-a49b-4653-12f0-08d9221a20c4
X-MS-TrafficTypeDiagnostic: DM5PR12MB2519:
X-Microsoft-Antispam-PRVS: <DM5PR12MB251986B71C497787F7379F4D82229@DM5PR12MB2519.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:284;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wwTwZBPWcAiL2uWwtVeDaMI1BXgN2GcmUOo/O/a0/ZzMbMO+y8ABXTj2B5CQUZz0sZAuXJWRg4WxlPqycXLL5M7ezk5RrIg8hiJnUZLSfVkwVXFIi1Ww1RI1vsUQuoCSZ2i2rclpuVqq/tak+dng6r1BHmWJRWSJOB6iGlMT0EgTpf9GT+r/9M3s21V/RYrLUw8GSd1Frg9ubimLPIRf9sgmM8hs4vwMjntYKEmy4W9gu0kvI7/WaYAGc8G/Tte2sz3c05wREHX5bjNiyfVtXDd/uA8rMQCUIaPU1EXv2fZDao5tB1jdeZDdAqORZyD+RujUWWc3itoXy5OSvb1sbproBoMssfrbM2whdHjvOH8s5XUjCDa6pPQPHJtJs77hYmf5lMKEkhi1pdGmi7XadpPKATwRzghrGDmTXOiZw78x0V5JBwzDr9fM59LER2AQcyu6U9/R/PT+3r89qPKXddrh3Z/8n9WzYwpZ0qTNip0G/5Q2VYbj6/3+6eZbFM/pzCrKATx2Cjv9AhyzEzDU5MeUOVBZx6hYA2871VTXXB04vbj/5cUa2XksysT4CZzj1KGPyKoFswle13T7M5TMzHUoEDjhnJdFUxvHa63N4ahdDJmfOgf+n6d1We8OBbCwEjMsFMDu/e0DbR8UxfMvzDsPm+9Y/co0DgjlaFH3N59f9OC+kej11j1eQJ2YwDjN
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(36840700001)(46966006)(82740400003)(81166007)(82310400003)(70206006)(83380400001)(186003)(70586007)(16526019)(1076003)(86362001)(5660300002)(2906002)(6916009)(36756003)(356005)(7696005)(8676002)(4326008)(36860700001)(6666004)(478600001)(47076005)(26005)(316002)(8936002)(336012)(426003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 20:49:46.2851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7931ed-a49b-4653-12f0-08d9221a20c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2519
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
Cc: Eric Huang <jinhuieric.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

it is for large bar/xgmi which has cpu update function,
for small bar that has sdma update function it will be done
later.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  | 21 ++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 10 +++++++++-
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 67bba8462e7d..8a23de0e0abc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -247,6 +247,7 @@ struct amdgpu_vm_update_funcs {
 		      unsigned count, uint32_t incr, uint64_t flags);
 	int (*commit)(struct amdgpu_vm_update_params *p,
 		      struct dma_fence **fence);
+	int (*get_pt_entry)(struct amdgpu_bo *bo, uint64_t pe, uint64_t *value);
 };
 
 struct amdgpu_vm {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index aefb3d2927d5..8a68a5c6326c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -116,9 +116,28 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 	return 0;
 }
 
+static int amdgpu_vm_get_pt_entry(struct amdgpu_bo *bo,
+		uint64_t pe, uint64_t *value)
+{
+	int r;
+
+	if (bo->tbo.moving) {
+		r = dma_fence_wait(bo->tbo.moving, true);
+		if (r)
+			return r;
+	}
+
+	pe += (unsigned long)amdgpu_bo_kptr(bo);
+
+	*value = *((uint64_t *)pe);
+
+	return 0;
+}
+
 const struct amdgpu_vm_update_funcs amdgpu_vm_cpu_funcs = {
 	.map_table = amdgpu_vm_cpu_map_table,
 	.prepare = amdgpu_vm_cpu_prepare,
 	.update = amdgpu_vm_cpu_update,
-	.commit = amdgpu_vm_cpu_commit
+	.commit = amdgpu_vm_cpu_commit,
+	.get_pt_entry = amdgpu_vm_get_pt_entry
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index a83a646759c5..d8871fbddc76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -274,9 +274,17 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 	return 0;
 }
 
+static int amdgpu_vm_sdma_get_pt_entry(struct amdgpu_bo *bo,
+		uint64_t pe, uint64_t *value)
+{
+	/* TODO */
+	return 0;
+}
+
 const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs = {
 	.map_table = amdgpu_vm_sdma_map_table,
 	.prepare = amdgpu_vm_sdma_prepare,
 	.update = amdgpu_vm_sdma_update,
-	.commit = amdgpu_vm_sdma_commit
+	.commit = amdgpu_vm_sdma_commit,
+	.get_pt_entry = amdgpu_vm_sdma_get_pt_entry
 };
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
