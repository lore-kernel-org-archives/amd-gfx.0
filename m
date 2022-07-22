Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE274C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 07:35:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CA3D10E3B3;
	Fri, 22 Jul 2022 07:35:09 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 064B710E323
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 07:35:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=brJgRYCMeA7vCRoqyncvV4J7klLKD08cOQ+unIW0OUZzCjW1/d1cv3PZ83UvdFvIdkMWv1oe0wWeR3ULiGQAjML1vGrqqjyMNAKrghQmQbVDNaHdAoJ0ptLLbhGIIMD9qxVsJrErag3OHBYWQMWUMGkf3OqCPRvZ8bzuAZPWZt5u88LQgDY4rlddotv9m1qWZPnDq9sdYHgt3orPi57Di30ijIHPubU6ijrGq0cDG+tB+/dqkfSmZJUGYkZTXP780NsQWhMD31v8E6btZaEZzXoLr2BXVhUmLZzBIYHl2YhqrH1h0Pwh9dzZAh3dqR8CXQFxs5HSMdESK4dnIL/jog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=57gJ3ZHGEMyBvUdBGtqYeMK35XCwUtRyl3to8kR0hqI=;
 b=i9jOxmjSRYGKz2+0VBAG/MS5cB3czu0I62QYlZskYj6dguSGC9rdLaN/HHX1b3RH22Tqua/Cao0YC0OGsh4iSryLVx3bgMmDY90uHKx2TYACfjC6beDkpgVsNlz8u+VDGFT13WfKS+jSSMZTkG1nXsVNCBpNP/NO0kpf0/+OywbS3Ar3htKF1cZOy7t7lH3Dqk6FvOChE/BqwaGEgMLJnENfAeZLKkl4/M82f2ifH/T3Lj92XZViLPLvwmoXUt/N8KYGzksRswKoLrQLu6dnkWwSF5AISILf7NiX9kRNIVLlHi4OpDQvev694UMjYiR7+F8OkPryvhhAAbNOmW3cpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=57gJ3ZHGEMyBvUdBGtqYeMK35XCwUtRyl3to8kR0hqI=;
 b=ttwLAngq779DSe6J4YSndgJKloU91IqjXCEvtbLrwX/F08e9bjlCv00W1+fXU/xSsOycAsc7LGcpRBphYIRu+Jioi1E1Wvd23K2f3AYYIdOQv/2jB8YLgXJ0YpBDxV9icw/W7V5I+7518gYlAeStjwwiz/TvHXGKjnXF5m22yrQ=
Received: from BN0PR04CA0039.namprd04.prod.outlook.com (2603:10b6:408:e8::14)
 by DM5PR12MB1276.namprd12.prod.outlook.com (2603:10b6:3:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 22 Jul
 2022 07:35:04 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::46) by BN0PR04CA0039.outlook.office365.com
 (2603:10b6:408:e8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 07:35:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 07:35:04 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 02:34:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 00:34:52 -0700
Received: from victor-test02.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 22 Jul 2022 02:34:50 -0500
From: Victor Zhao <Victor.Zhao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: add debugfs amdgpu_reset_level
Date: Fri, 22 Jul 2022 15:34:00 +0800
Message-ID: <20220722073403.5171-2-Victor.Zhao@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220722073403.5171-1-Victor.Zhao@amd.com>
References: <20220722073403.5171-1-Victor.Zhao@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74af6353-e288-402d-dabc-08da6bb4b191
X-MS-TrafficTypeDiagnostic: DM5PR12MB1276:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9I3hKy0cuwZW/6NPayJXpvMNZl6gY/rC7U3+aHw4GBZc/rkPSoTEQFMMIU/CckjNpwPn4WejY1ayEDDiHjeaBxGk/dHAl58cCJMS7EQYtwQFNg3VFd1X+6EMjh1VklL2dkqEh2VlnoktwfIXY5kKccKujTPVcoC0j6dspSyz9+KZgt0cY/kHfqXu4Gg6fmFP623nLM7xwm1kWPLV8c1jzmhHybmARbQbriDELTXzG0n7mwpRs0eilj5GYWLuYgu/ZtIQqDRkfCKenjrf2yzlzPPmjLd7vJzzrS6lfqVXXWs1llQhybFdvKwc4xf97QMHJ/B+l/iKldJQMJBzrRI9Zyghd0NRSVnT8L71fS2UiieTrmojh5lAPOVNRObDcCDda5FqrDEsHPRwOtm2fstCBUmwxPh63viGRO5Q6d6Q1pxQm/yE2kZq7QrSNRheQSWPvAbO8p6GtDSkawaHTSFURDSOaVCil1KSHV05jXkVyySxyJJCBsOOzXUS6CxZglYselYiL3Gc5Uu+d0gRZUBzGFGFqPJ7k2mB6m/LgZqi5A2p+JR3aCB8WtWZF7FF3gcTZLTXE8sSEg2hU75nP90xn8yAGID8RFIhKe4omch95YGOvz2zvgY/Ffc7d0cLKy4IS7xFrKU3iCYkWj3qDH/GErqoIOO6iD2r6tlSKkLq9yK8i7YOLakSTjqGojAxjzZDZ3oPD2wmtwP2ItM1zGA1ILpszoBxSkNbPnOv1Yy9yFKZR4Y0eIXY3rYvbXUfQD7RBa61EBA4Uvw1m77XFP3p+rNebEn1BkJ/Tw3Eoj/r6lka0+/+Q3gnvjhi2Sy/YQZJgxOrhZhvWirSN6JmPolAeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(46966006)(40470700004)(70206006)(4326008)(6916009)(70586007)(8676002)(36860700001)(356005)(316002)(426003)(336012)(54906003)(8936002)(86362001)(81166007)(2906002)(82740400003)(5660300002)(41300700001)(6666004)(7696005)(26005)(186003)(40480700001)(47076005)(40460700003)(2616005)(36756003)(1076003)(82310400005)(83380400001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 07:35:04.3132 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74af6353-e288-402d-dabc-08da6bb4b191
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1276
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
Cc: Alexander.Deucher@amd.com, emily.deng@amd.com,
 Victor Zhao <Victor.Zhao@amd.com>, Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Introduce amdgpu_reset_level debugfs in order to help debug and
test specific type of reset. Also helps blocking unwanted type of
resets.

By default, mode2 reset will not be enabled

Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |  3 +++
 5 files changed, 34 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6cd1e0a6dffc..c661231a6a07 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -238,6 +238,7 @@ extern int amdgpu_si_support;
 extern int amdgpu_cik_support;
 #endif
 extern int amdgpu_num_kcq;
+extern uint amdgpu_reset_level_mask;
 
 #define AMDGPU_VCNFW_LOG_SIZE (32 * 1024)
 extern int amdgpu_vcnfw_log;
@@ -274,6 +275,9 @@ extern int amdgpu_vcnfw_log;
 #define AMDGPU_RESET_VCE			(1 << 13)
 #define AMDGPU_RESET_VCE1			(1 << 14)
 
+#define AMDGPU_RESET_LEVEL_SOFT_RECOVERY (1 << 0)
+#define AMDGPU_RESET_LEVEL_MODE2 (1 << 1)
+
 /* max cursor sizes (in pixels) */
 #define CIK_CURSOR_WIDTH 128
 #define CIK_CURSOR_HEIGHT 128
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index e2eec985adb3..235c48e4ba4d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1661,12 +1661,29 @@ static int amdgpu_debugfs_sclk_set(void *data, u64 val)
 	return ret;
 }
 
+static int amdgpu_debugfs_reset_level_get(void *data, u64 *val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	*val = amdgpu_reset_level_mask;
+	return 0;
+}
+
+static int amdgpu_debugfs_reset_level_set(void *data, u64 val)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)data;
+	amdgpu_reset_level_mask = val;
+	return 0;
+}
+
 DEFINE_DEBUGFS_ATTRIBUTE(fops_ib_preempt, NULL,
 			amdgpu_debugfs_ib_preempt, "%llu\n");
 
 DEFINE_DEBUGFS_ATTRIBUTE(fops_sclk_set, NULL,
 			amdgpu_debugfs_sclk_set, "%llu\n");
 
+DEFINE_DEBUGFS_ATTRIBUTE(fops_reset_level, amdgpu_debugfs_reset_level_get,
+			amdgpu_debugfs_reset_level_set, "%llu\n");
+
 static ssize_t amdgpu_reset_dump_register_list_read(struct file *f,
 				char __user *buf, size_t size, loff_t *pos)
 {
@@ -1785,6 +1802,9 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		return PTR_ERR(ent);
 	}
 
+	debugfs_create_file("amdgpu_reset_level", 0200, root, adev,
+				  &fops_reset_level);
+
 	/* Register debugfs entries for amdgpu_ttm */
 	amdgpu_ttm_debugfs_init(adev);
 	amdgpu_debugfs_pm_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e8c6c3fe9374..fb8f3cb853a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -198,6 +198,7 @@ struct amdgpu_watchdog_timer amdgpu_watchdog_timer = {
 	.timeout_fatal_disable = false,
 	.period = 0x0, /* default to 0x0 (timeout disable) */
 };
+uint amdgpu_reset_level_mask = 0x1;
 
 /**
  * DOC: vramlimit (int)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 831fb222139c..f16ab1a54b70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -74,6 +74,9 @@ int amdgpu_reset_prepare_hwcontext(struct amdgpu_device *adev,
 {
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
+	if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
+		return -ENOSYS;
+
 	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
 		return -ENOSYS;
 
@@ -93,6 +96,9 @@ int amdgpu_reset_perform_reset(struct amdgpu_device *adev,
 	int ret;
 	struct amdgpu_reset_handler *reset_handler = NULL;
 
+	if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_MODE2))
+		return -ENOSYS;
+
 	if (test_bit(AMDGPU_SKIP_MODE2_RESET, &reset_context->flags))
 		return -ENOSYS;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index d3558c34d406..1ffdc050a077 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -405,6 +405,9 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
 {
 	ktime_t deadline = ktime_add_us(ktime_get(), 10000);
 
+	if (!(amdgpu_reset_level_mask & AMDGPU_RESET_LEVEL_SOFT_RECOVERY))
+		return false;
+
 	if (amdgpu_sriov_vf(ring->adev) || !ring->funcs->soft_recovery || !fence)
 		return false;
 
-- 
2.25.1

