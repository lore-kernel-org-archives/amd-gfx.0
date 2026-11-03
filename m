Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F354B606A324
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 06:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Lx61yoYZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FCB010E37B;
	Tue,  3 Nov 2026 06:34:59 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 695AC10E37B
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 06:34:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QO7cffH1LamJnmFQTv8sT6SExGCoVQVbzJQdDUX6Zag3Bqb3C8osvr39ls5DmmNh/e1eQLULaSaCKsCH/ko9CsdvrDeCKzb5dGadJ7zDipC/ZGLu9sC03Y8rJg3XgT3Nc9dHP/TWgGrVGk5u9QnnRSHWjdE/Nyj6+numZpxOqg7bmLI9wkIlYXWUCfV7iJgbrwGbYvso0gGAYhoYxspjj/tyoDge3Svx2qAR8IU5OHpP+VZyfFnHDX8nhhHMMTz8JB7VH8nMrYzWtCqOocpXdBZTR/Q3ECeq+b2OtwKtG4Wb+D5QvMZMfE0fEawDI25VXGveLwMaD2/NAJ4fjh7HeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v5XWDyJ6tWMLEh3k7CrwG5B6SUEDFFenHn8xpZwfxec=;
 b=f8g9k6ywRMstweqAqqRoaxXqgLC5pI5Bc3poymo9y+EYRQbo6Q9o3SRrbrDl5xdUCqem9GdcehPhAkEiKizF+LUiDz5sT2RfMwLFeHf89nl68d04WnYe/p3dApinF+GkPgqVcbCyLsY5EP4S9SFmFcjT9DdwOVDjNzfO+4PChDb2I37jn2zF6Ebajmykb0+Sy3QUqlzUVUSxOoE+tTEG9ca184w/1RCe9M/ThR7TVchUWYgS3GLIHDqIiKtXdjwfNJ3QtSDoLZUTBXEGDff79+wiZ698SGd+qZUhEza1ZNR1DF8kDku8UufrkW8MJLpcQAUMVZkfgApJDJoUL5pd6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v5XWDyJ6tWMLEh3k7CrwG5B6SUEDFFenHn8xpZwfxec=;
 b=Lx61yoYZ2+i0kJWquH6SxVJYcTQ7bEWYihkL9YWWxMAXZZLbpzB4pr6VcPQusizjuunyC7HuXaRP8i/Prse6qYvPd/Kg+ZuImS57ELzicZkQRkHbnreidWMSsnaLUqqQo7aCqXJEJlghdE9KGG7kFlCVkq2s8F2u5yaIAv6lsck=
Received: from BLAP220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::15)
 by MN0PR12MB5763.namprd12.prod.outlook.com (2603:10b6:208:376::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:34:47 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::2d) by BLAP220CA0010.outlook.office365.com
 (2603:10b6:208:32c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.10 via Frontend Transport; Tue, 3
 Nov 2026 06:34:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.0 via Frontend Transport; Tue, 3 Nov 2026 06:34:46 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 00:34:44 -0600
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Vitaly.Prosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>, Leo Liu
 <leo.liu@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH] drm/amdgpu: stop GPU recovery wait for the JPEG/VCN idle work
Date: Tue, 3 Nov 2026 14:34:34 +0800
Message-ID: <20261103063434.3102634-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|MN0PR12MB5763:EE_
X-MS-Office365-Filtering-Correlation-Id: daa94c06-d16b-4320-31aa-08df39748db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|6133799003|10067099003|18002099003|261102123227099003|3023799007|13003099007|56012099006|261026121527099003|5023799004|11063799006|261022075727099003|261022105027099003|261021121427099003|261009221227099003|261009220027099003|261009223327099003|261009221727099003|261009223027099003|261028144727099003|261026140227099003|261021123027099003|260925022911599003|260925021911599003|260925021311599003;
X-Microsoft-Antispam-Message-Info: 4gk4MVfNvDlyBlJ0Cp7RQOp44jzmLufch9sdTYQiO1RKqY1qeI+ofWe+tuCDoTQP/GreoHSiyMpmy/kdLw50Int6awAv2cYQ+xcL7aye5ax1tlzfC187qSccuZRNXZvZj8AEGaYSYyLK7B16jJIIGrITkhQfbaoJJYFqPSxczt8pMUo1wgL9oKhzeyPLp2UfUco0GRUckkxb5ueWSLGBZaGpzLC1m1iDtYS147NT2Y/zY9UaQTKzmicLt69l8/FEHB/z+fDjn11QiH60KaDgm4lac8wdPJcCv81O81CL0k5EH/VKmYkvMrj61YG+d5Eq7fWgd4o6boKmgYR4P02RZQUrShThmDp639aNjUWQLMhV5BNAlFGrW2x01XrAwlX1H7vggyMU+6mNcHRlixzysR0Y3HzADnXlkHMs+rXpqnOmEGdlsZh8aM4C8mNiRpB0yRDfw1Gtfww4vt18yPZvLX4ic83Md/VxzCEWyj1hzuNgVACgP2ViJ8SI0tjHuQqdzHttfODU6K8DXc6KIaXb+GVT0MC9eKqQQHhoR5ybXSv5abLm3mX0zsw4EPI+KR+YS6yv0SfozJ9iuaLwa2RomThwG3ED7SbgFbGg1TMBkj6WidGXqjb2rpANnmOdD2vXEfCJlDgig1ECdqtgqNLhmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(6133799003)(10067099003)(18002099003)(261102123227099003)(3023799007)(13003099007)(56012099006)(261026121527099003)(5023799004)(11063799006)(261022075727099003)(261022105027099003)(261021121427099003)(261009221227099003)(261009220027099003)(261009223327099003)(261009221727099003)(261009223027099003)(261028144727099003)(261026140227099003)(261021123027099003)(260925022911599003)(260925021911599003)(260925021311599003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pNuH9/ZbCPatpENcAjuFAOxuEnNGA6t22meSlCOPiHwh8eSFlZTattzKp+0jBbEiZ0GU/FX/imEIdrJ/abd1x6ueJpf9I0hYbNuRXdMZBt1K0qWAiFtVlOKIVtfl3tHAzGzVErDliShXHhgZSr9l073FtOcyalbKA9o1dKclZDJL7C05O/IH06ILM9PiWwTkepPTdmjuJzM3vNdWvBREkp7BRl1GQaYsT9PKzbvmHEPFylvNo3JOzrBdT6VvFArr06AphOQDEF8UUGZaJQKzhMTm5pPw/tqS8/OK/Ev74npiKKx/mQAPOZsu6pgsdVTiiD4v/K24Jn32O4X1MNqMOTihoVRyE/RIIMqa1dvkL1lDWT5CsVzEOPvq9W3bgECyeH9JlNpM8cVfJy3+zkDrCGLL8oO425iltf4/ALt/ucaPSTJTbYKPXqfU1yAtpKao
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:34:46.6123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: daa94c06-d16b-4320-31aa-08df39748db8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5763
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

The common JPEG and VCN idle workers program power gating and DPG pause,
so they must not run while a GPU reset is in progress. Recovery must not
wait for them either, since everything the workers depend on then
becomes a dependency of GPU recovery.

Make the workers take reset_domain->sem for read, so they wait for a
running reset instead of touching the hardware. hw_fini/suspend, the
hw_init error paths and begin_use, the latter for the IB tests, run from
GPU recovery as well, so only skip waiting for the idle work when the
reset itself calls them. The reset holds the semaphore for write and
would otherwise deadlock on a worker blocked on it. Outside a reset the
cancel stays synchronous as before.

A device can also be torn down while a peer in its XGMI reset domain is
being reset. hw_fini then doesn't wait for the worker either, and is
skipped entirely if the peer's reset has already suspended the device.
Cancel the idle work synchronously in early_fini, which only runs on
teardown and before any hw_fini, so the worker is done before the
hardware it touches is torn down.

Teardown has drained the rings before early_fini, so nothing queues the
work again and hw_fini only cancels it outside teardown, for suspend and
GPU reset. The JPEG suspend and sw_fini callbacks no longer cancel it a
second time; replace amdgpu_jpeg_suspend(), which only did that, with
amdgpu_jpeg_cancel_idle_work() as on the VCN side.

Update versions:
v1: https://lists.freedesktop.org/archives/amd-gfx/2026-October/155441.html
v2: https://lists.freedesktop.org/archives/amd-gfx/2026-October/156119.html
v3: https://lists.freedesktop.org/archives/amd-gfx/2026-November/156456.html

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Cc: Leo Liu <leo.liu@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 25 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 36 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h  |  2 ++
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c   | 23 +++++----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c   | 24 ++++++----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c   | 23 +++++----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c   | 24 ++++++----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 23 +++++----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 23 +++++----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 23 +++++----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c | 24 +++++-----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c | 24 +++++-----------
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c | 23 +++++----------
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    |  7 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c    |  4 +--
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c    |  7 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c    |  7 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c  |  7 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c  |  7 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c  |  7 +++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c  |  8 ++++--
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c  |  8 ++++--
 24 files changed, 179 insertions(+), 187 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
index 2b0e658b63b6..ec3833c79a01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
@@ -95,13 +95,27 @@ int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev)
 	return 0;
 }
 
-int amdgpu_jpeg_suspend(struct amdgpu_device *adev)
+int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block)
 {
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Called on teardown even if sw_init never ran */
+	if (!ip_block->status.sw)
+		return 0;
+
+	/* hw_fini may not wait while a peer in the reset domain resets */
+	cancel_delayed_work_sync(&ip_block->adev->jpeg.idle_work);
 
 	return 0;
 }
 
+void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev)
+{
+	/* The reset mustn't wait for the idle work, which waits for the reset */
+	if (amdgpu_in_reset(adev))
+		cancel_delayed_work(&adev->jpeg.idle_work);
+	else
+		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+}
+
 int amdgpu_jpeg_resume(struct amdgpu_device *adev)
 {
 	return 0;
@@ -114,6 +128,9 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 	unsigned int fences = 0;
 	unsigned int i, j;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1U << i))
 			continue;
@@ -129,6 +146,8 @@ static void amdgpu_jpeg_idle_work_handler(struct work_struct *work)
 		mutex_unlock(&adev->jpeg.jpeg_pg_lock);
 	} else
 		schedule_delayed_work(&adev->jpeg.idle_work, JPEG_IDLE_TIMEOUT);
+
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
@@ -136,7 +155,7 @@ void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 
 	if (!atomic_fetch_inc(&adev->jpeg.total_submission_cnt))
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	mutex_lock(&adev->jpeg.jpeg_pg_lock);
 	amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_JPEG,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
index 05d58e6bbfab..9c4f251e03f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.h
@@ -156,11 +156,12 @@ struct amdgpu_jpeg {
 
 int amdgpu_jpeg_sw_init(struct amdgpu_device *adev);
 int amdgpu_jpeg_sw_fini(struct amdgpu_device *adev);
-int amdgpu_jpeg_suspend(struct amdgpu_device *adev);
+int amdgpu_jpeg_early_fini(struct amdgpu_ip_block *ip_block);
 int amdgpu_jpeg_resume(struct amdgpu_device *adev);
 
 void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_jpeg_ring_end_use(struct amdgpu_ring *ring);
+void amdgpu_jpeg_cancel_idle_work(struct amdgpu_device *adev);
 
 int amdgpu_jpeg_dec_ring_test_ring(struct amdgpu_ring *ring);
 int amdgpu_jpeg_dec_ring_test_ib(struct amdgpu_ring *ring, long timeout);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
index 34e1242d66ea..6c12d8aa3c76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
@@ -299,6 +299,26 @@ void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i)
 	mutex_destroy(&adev->vcn.inst[i].vcn1_jpeg1_workaround);
 }
 
+int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	/* Called on teardown even if sw_init never ran */
+	if (!ip_block->status.sw)
+		return 0;
+
+	/* hw_fini may not wait while a peer in the reset domain resets */
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->vcn.harvest_config & (1 << i))
+			continue;
+
+		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+	}
+
+	return 0;
+}
+
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev, enum vcn_ring_type type, uint32_t vcn_instance)
 {
 	bool ret = false;
@@ -459,6 +479,15 @@ void amdgpu_vcn_put_profile(struct amdgpu_device *adev)
 	mutex_unlock(&adev->vcn.workload_profile_mutex);
 }
 
+void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst)
+{
+	/* The reset mustn't wait for the idle work, which waits for the reset */
+	if (amdgpu_in_reset(vcn_inst->adev))
+		cancel_delayed_work(&vcn_inst->idle_work);
+	else
+		cancel_delayed_work_sync(&vcn_inst->idle_work);
+}
+
 static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 {
 	struct amdgpu_vcn_inst *vcn_inst =
@@ -470,6 +499,9 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	if (adev->vcn.harvest_config & (1 << i))
 		return;
 
+	/* Nothing holding the reset semaphore waits for this work */
+	down_read(&adev->reset_domain->sem);
+
 	for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
 		fence[i] += amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
 
@@ -499,6 +531,8 @@ static void amdgpu_vcn_idle_work_handler(struct work_struct *work)
 	} else {
 		schedule_delayed_work(&vcn_inst->idle_work, VCN_IDLE_TIMEOUT);
 	}
+
+	up_read(&adev->reset_domain->sem);
 }
 
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
@@ -507,7 +541,7 @@ void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
 	struct amdgpu_vcn_inst *vcn_inst = &adev->vcn.inst[ring->me];
 
 	if (!atomic_fetch_inc(&vcn_inst->total_submission_cnt))
-		cancel_delayed_work_sync(&vcn_inst->idle_work);
+		amdgpu_vcn_cancel_idle_work(vcn_inst);
 
 	mutex_lock(&vcn_inst->vcn_pg_lock);
 	vcn_inst->set_pg_state(vcn_inst, AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
index bea95307fd42..509c83799a8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h
@@ -522,10 +522,12 @@ enum vcn_ring_type {
 int amdgpu_vcn_early_init(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_sw_init(struct amdgpu_device *adev, int i);
 void amdgpu_vcn_sw_fini(struct amdgpu_device *adev, int i);
+int amdgpu_vcn_early_fini(struct amdgpu_ip_block *ip_block);
 int amdgpu_vcn_suspend(struct amdgpu_device *adev, int i);
 int amdgpu_vcn_resume(struct amdgpu_device *adev, int i);
 void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring);
 void amdgpu_vcn_ring_end_use(struct amdgpu_ring *ring);
+void amdgpu_vcn_cancel_idle_work(struct amdgpu_vcn_inst *vcn_inst);
 
 bool amdgpu_vcn_is_disabled_vcn(struct amdgpu_device *adev,
 				enum vcn_ring_type type, uint32_t vcn_instance);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index f03c1a37c8dd..2f1ce3096020 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -131,17 +131,13 @@ static int jpeg_v2_0_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v2_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 
 	r = amdgpu_jpeg_sw_fini(adev);
@@ -166,7 +162,7 @@ static int jpeg_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -181,7 +177,9 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
@@ -199,15 +197,7 @@ static int jpeg_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v2_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = jpeg_v2_0_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(ip_block->adev);
-
-	return r;
+	return jpeg_v2_0_hw_fini(ip_block);
 }
 
 /**
@@ -792,6 +782,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 	.early_init = jpeg_v2_0_early_init,
 	.sw_init = jpeg_v2_0_sw_init,
 	.sw_fini = jpeg_v2_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v2_0_hw_init,
 	.hw_fini = jpeg_v2_0_hw_fini,
 	.suspend = jpeg_v2_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
index 46293664fd28..966a8a7f28ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_5.c
@@ -181,17 +181,13 @@ static int jpeg_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v2_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 
 	r = amdgpu_jpeg_sw_fini(adev);
@@ -227,7 +223,7 @@ static int jpeg_v2_5_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -243,7 +239,9 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
@@ -269,15 +267,7 @@ static int jpeg_v2_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v2_5_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = jpeg_v2_5_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(ip_block->adev);
-
-	return r;
+	return jpeg_v2_5_hw_fini(ip_block);
 }
 
 /**
@@ -665,6 +655,7 @@ static const struct amd_ip_funcs jpeg_v2_5_ip_funcs = {
 	.early_init = jpeg_v2_5_early_init,
 	.sw_init = jpeg_v2_5_sw_init,
 	.sw_fini = jpeg_v2_5_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v2_5_hw_init,
 	.hw_fini = jpeg_v2_5_hw_fini,
 	.suspend = jpeg_v2_5_suspend,
@@ -681,6 +672,7 @@ static const struct amd_ip_funcs jpeg_v2_6_ip_funcs = {
 	.early_init = jpeg_v2_5_early_init,
 	.sw_init = jpeg_v2_5_sw_init,
 	.sw_fini = jpeg_v2_5_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v2_5_hw_init,
 	.hw_fini = jpeg_v2_5_hw_fini,
 	.suspend = jpeg_v2_5_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index 361d0f4b4bc7..d7b664e25202 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -146,17 +146,13 @@ static int jpeg_v3_0_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 
 	r = amdgpu_jpeg_sw_fini(adev);
@@ -181,7 +177,7 @@ static int jpeg_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r)
-		cancel_delayed_work_sync(&adev->jpeg.idle_work);
+		amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -196,7 +192,9 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
@@ -214,15 +212,7 @@ static int jpeg_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = jpeg_v3_0_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(ip_block->adev);
-
-	return r;
+	return jpeg_v3_0_hw_fini(ip_block);
 }
 
 /**
@@ -564,6 +554,7 @@ static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
 	.early_init = jpeg_v3_0_early_init,
 	.sw_init = jpeg_v3_0_sw_init,
 	.sw_fini = jpeg_v3_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v3_0_hw_init,
 	.hw_fini = jpeg_v3_0_hw_fini,
 	.suspend = jpeg_v3_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 4e8eed2b62db..6dc01f57847b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -157,17 +157,13 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
@@ -210,7 +206,7 @@ static int jpeg_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -225,7 +221,10 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
+
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 			RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
@@ -246,15 +245,7 @@ static int jpeg_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = jpeg_v4_0_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(ip_block->adev);
-
-	return r;
+	return jpeg_v4_0_hw_fini(ip_block);
 }
 
 /**
@@ -748,6 +739,7 @@ static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.early_init = jpeg_v4_0_early_init,
 	.sw_init = jpeg_v4_0_sw_init,
 	.sw_fini = jpeg_v4_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v4_0_hw_init,
 	.hw_fini = jpeg_v4_0_hw_fini,
 	.suspend = jpeg_v4_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index 9f298c4ea8ff..0997c949c125 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -248,17 +248,13 @@ static int jpeg_v4_0_3_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v4_0_3_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 
 	r = amdgpu_jpeg_sw_fini(adev);
@@ -443,7 +439,7 @@ static int jpeg_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -459,7 +455,9 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
@@ -481,15 +479,7 @@ static int jpeg_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v4_0_3_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = jpeg_v4_0_3_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(ip_block->adev);
-
-	return r;
+	return jpeg_v4_0_3_hw_fini(ip_block);
 }
 
 /**
@@ -1227,6 +1217,7 @@ static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
 	.early_init = jpeg_v4_0_3_early_init,
 	.sw_init = jpeg_v4_0_3_sw_init,
 	.sw_fini = jpeg_v4_0_3_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v4_0_3_hw_init,
 	.hw_fini = jpeg_v4_0_3_hw_fini,
 	.suspend = jpeg_v4_0_3_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index a1496412810c..11718e3f19a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -191,17 +191,13 @@ static int jpeg_v4_0_5_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v4_0_5_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
@@ -238,7 +234,7 @@ static int jpeg_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -254,7 +250,9 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int i;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
 		if (adev->jpeg.harvest_config & (1 << i))
@@ -278,15 +276,7 @@ static int jpeg_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v4_0_5_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = jpeg_v4_0_5_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(ip_block->adev);
-
-	return r;
+	return jpeg_v4_0_5_hw_fini(ip_block);
 }
 
 /**
@@ -807,6 +797,7 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 	.early_init = jpeg_v4_0_5_early_init,
 	.sw_init = jpeg_v4_0_5_sw_init,
 	.sw_fini = jpeg_v4_0_5_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v4_0_5_hw_init,
 	.hw_fini = jpeg_v4_0_5_hw_fini,
 	.suspend = jpeg_v4_0_5_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 1a4594d5d952..88e78dc498bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -135,17 +135,13 @@ static int jpeg_v5_0_0_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v5_0_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
@@ -178,7 +174,7 @@ static int jpeg_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -193,7 +189,9 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC_STATUS))
@@ -211,15 +209,7 @@ static int jpeg_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v5_0_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = jpeg_v5_0_0_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(ip_block->adev);
-
-	return r;
+	return jpeg_v5_0_0_hw_fini(ip_block);
 }
 
 /**
@@ -683,6 +673,7 @@ static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 	.early_init = jpeg_v5_0_0_early_init,
 	.sw_init = jpeg_v5_0_0_sw_init,
 	.sw_fini = jpeg_v5_0_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v5_0_0_hw_init,
 	.hw_fini = jpeg_v5_0_0_hw_fini,
 	.suspend = jpeg_v5_0_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
index efdc537ec81e..f666b48e34c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_1.c
@@ -240,17 +240,13 @@ static int jpeg_v5_0_1_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v5_0_1_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 
 	r = amdgpu_jpeg_sw_fini(adev);
@@ -314,7 +310,7 @@ static int jpeg_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -330,7 +326,9 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
@@ -352,16 +350,7 @@ static int jpeg_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v5_0_1_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = jpeg_v5_0_1_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(adev);
-
-	return r;
+	return jpeg_v5_0_1_hw_fini(ip_block);
 }
 
 /**
@@ -887,6 +876,7 @@ static const struct amd_ip_funcs jpeg_v5_0_1_ip_funcs = {
 	.late_init = NULL,
 	.sw_init = jpeg_v5_0_1_sw_init,
 	.sw_fini = jpeg_v5_0_1_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v5_0_1_hw_init,
 	.hw_fini = jpeg_v5_0_1_hw_fini,
 	.suspend = jpeg_v5_0_1_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
index eb3dc9558e0d..af1feba68dc3 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_2.c
@@ -206,17 +206,13 @@ static int jpeg_v5_0_2_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v5_0_2_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 
 	r = amdgpu_jpeg_sw_fini(adev);
@@ -287,7 +283,7 @@ static int jpeg_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -303,7 +299,9 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	int ret = 0;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		if (adev->jpeg.cur_state != AMD_PG_STATE_GATE)
@@ -322,16 +320,7 @@ static int jpeg_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v5_0_2_suspend(struct amdgpu_ip_block *ip_block)
 {
-	struct amdgpu_device *adev = ip_block->adev;
-	int r;
-
-	r = jpeg_v5_0_2_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(adev);
-
-	return r;
+	return jpeg_v5_0_2_hw_fini(ip_block);
 }
 
 /**
@@ -871,6 +860,7 @@ static const struct amd_ip_funcs jpeg_v5_0_2_ip_funcs = {
 	.late_init = NULL,
 	.sw_init = jpeg_v5_0_2_sw_init,
 	.sw_fini = jpeg_v5_0_2_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v5_0_2_hw_init,
 	.hw_fini = jpeg_v5_0_2_hw_fini,
 	.suspend = jpeg_v5_0_2_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
index 0cbb2b8a7e78..71011c5e2adb 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_3_0.c
@@ -118,17 +118,13 @@ static int jpeg_v5_3_0_sw_init(struct amdgpu_ip_block *ip_block)
  *
  * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
  *
- * JPEG suspend and free up sw allocation
+ * Free up JPEG sw allocation
  */
 static int jpeg_v5_3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
 
-	r = amdgpu_jpeg_suspend(adev);
-	if (r)
-		return r;
-
 	amdgpu_jpeg_sysfs_reset_mask_fini(adev);
 	r = amdgpu_jpeg_sw_fini(adev);
 
@@ -161,7 +157,7 @@ static int jpeg_v5_3_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	amdgpu_jpeg_cancel_idle_work(adev);
 	return r;
 }
 
@@ -176,7 +172,9 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
-	cancel_delayed_work_sync(&adev->jpeg.idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_jpeg_cancel_idle_work(adev);
 
 	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
 	      RREG32_SOC15(JPEG, 0, regUVD_JRBC0_UVD_JRBC_STATUS))
@@ -194,15 +192,7 @@ static int jpeg_v5_3_0_hw_fini(struct amdgpu_ip_block *ip_block)
  */
 static int jpeg_v5_3_0_suspend(struct amdgpu_ip_block *ip_block)
 {
-	int r;
-
-	r = jpeg_v5_3_0_hw_fini(ip_block);
-	if (r)
-		return r;
-
-	r = amdgpu_jpeg_suspend(ip_block->adev);
-
-	return r;
+	return jpeg_v5_3_0_hw_fini(ip_block);
 }
 
 /**
@@ -671,6 +661,7 @@ static const struct amd_ip_funcs jpeg_v5_3_0_ip_funcs = {
 	.early_init = jpeg_v5_3_0_early_init,
 	.sw_init = jpeg_v5_3_0_sw_init,
 	.sw_fini = jpeg_v5_3_0_sw_fini,
+	.early_fini = amdgpu_jpeg_early_fini,
 	.hw_init = jpeg_v5_3_0_hw_init,
 	.hw_fini = jpeg_v5_3_0_hw_fini,
 	.suspend = jpeg_v5_3_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index b3e63d6e79a8..897310d04f83 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -150,8 +150,8 @@ static int vcn_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* Override the work func */
-	adev->vcn.inst[0].idle_work.work.func = vcn_v1_0_idle_work_handler;
+	/* Own lockdep class, this work is still cancelled synchronously */
+	INIT_DELAYED_WORK(&adev->vcn.inst[0].idle_work, vcn_v1_0_idle_work_handler);
 
 	amdgpu_vcn_setup_ucode(adev, 0);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index 12ac20484396..290cd715ca32 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -310,7 +310,7 @@ static int vcn_v2_0_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 
 error:
-	cancel_delayed_work_sync(&adev->vcn.inst->idle_work);
+	amdgpu_vcn_cancel_idle_work(adev->vcn.inst);
 	return r;
 }
 
@@ -326,7 +326,9 @@ static int vcn_v2_0_hw_fini(struct amdgpu_ip_block *ip_block)
 	struct amdgpu_device *adev = ip_block->adev;
 	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
 
-	cancel_delayed_work_sync(&vinst->idle_work);
+	/* Teardown cancelled it synchronously in early_fini */
+	if (!adev->shutdown)
+		amdgpu_vcn_cancel_idle_work(vinst);
 
 	if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
 	    (vinst->cur_state != AMD_PG_STATE_GATE &&
@@ -2103,6 +2105,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.early_init = vcn_v2_0_early_init,
 	.sw_init = vcn_v2_0_sw_init,
 	.sw_fini = vcn_v2_0_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v2_0_hw_init,
 	.hw_fini = vcn_v2_0_hw_fini,
 	.suspend = vcn_v2_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 2b2abe689508..c3f2265f50fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -304,8 +304,8 @@ static int vcn_v2_5_sw_init(struct amdgpu_ip_block *ip_block)
 		if (r)
 			return r;
 
-		/* Override the work func */
-		adev->vcn.inst[j].idle_work.work.func = vcn_v2_5_idle_work_handler;
+		/* Own lockdep class, this work is still cancelled synchronously */
+		INIT_DELAYED_WORK(&adev->vcn.inst[j].idle_work, vcn_v2_5_idle_work_handler);
 
 		amdgpu_vcn_setup_ucode(adev, j);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 6543f21daa1e..2f7d5d562cb4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -433,7 +433,7 @@ static int vcn_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -457,7 +457,9 @@ static int vcn_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		/* Teardown cancelled it synchronously in early_fini */
+		if (!adev->shutdown)
+			amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
@@ -2366,6 +2368,7 @@ static const struct amd_ip_funcs vcn_v3_0_ip_funcs = {
 	.early_init = vcn_v3_0_early_init,
 	.sw_init = vcn_v3_0_sw_init,
 	.sw_fini = vcn_v3_0_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v3_0_hw_init,
 	.hw_fini = vcn_v3_0_hw_fini,
 	.suspend = vcn_v3_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 8b5646297c2e..12be9a2b2efc 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -358,7 +358,7 @@ static int vcn_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -382,7 +382,9 @@ static int vcn_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		/* Teardown cancelled it synchronously in early_fini */
+		if (!adev->shutdown)
+			amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
@@ -2287,6 +2289,7 @@ static const struct amd_ip_funcs vcn_v4_0_ip_funcs = {
 	.early_init = vcn_v4_0_early_init,
 	.sw_init = vcn_v4_0_sw_init,
 	.sw_fini = vcn_v4_0_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v4_0_hw_init,
 	.hw_fini = vcn_v4_0_hw_fini,
 	.suspend = vcn_v4_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 0c58ca25d7b5..a82607a4f847 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -404,7 +404,7 @@ static int vcn_v4_0_3_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -425,7 +425,9 @@ static int vcn_v4_0_3_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		/* Teardown cancelled it synchronously in early_fini */
+		if (!adev->shutdown)
+			amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
@@ -2035,6 +2037,7 @@ static const struct amd_ip_funcs vcn_v4_0_3_ip_funcs = {
 	.late_init = vcn_v4_0_3_late_init,
 	.sw_init = vcn_v4_0_3_sw_init,
 	.sw_fini = vcn_v4_0_3_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v4_0_3_hw_init,
 	.hw_fini = vcn_v4_0_3_hw_fini,
 	.suspend = vcn_v4_0_3_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index a6eaa57ec2ee..f5195b3ad0a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -311,7 +311,7 @@ static int vcn_v4_0_5_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -335,7 +335,9 @@ static int vcn_v4_0_5_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		/* Teardown cancelled it synchronously in early_fini */
+		if (!adev->shutdown)
+			amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
@@ -1690,6 +1692,7 @@ static const struct amd_ip_funcs vcn_v4_0_5_ip_funcs = {
 	.early_init = vcn_v4_0_5_early_init,
 	.sw_init = vcn_v4_0_5_sw_init,
 	.sw_fini = vcn_v4_0_5_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v4_0_5_hw_init,
 	.hw_fini = vcn_v4_0_5_hw_fini,
 	.suspend = vcn_v4_0_5_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 055729a42094..5ceb96228cf4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -275,7 +275,7 @@ static int vcn_v5_0_0_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -299,7 +299,9 @@ static int vcn_v5_0_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		if (adev->vcn.harvest_config & (1 << i))
 			continue;
 
-		cancel_delayed_work_sync(&vinst->idle_work);
+		/* Teardown cancelled it synchronously in early_fini */
+		if (!adev->shutdown)
+			amdgpu_vcn_cancel_idle_work(vinst);
 
 		if (!amdgpu_sriov_vf(adev)) {
 			if ((adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) ||
@@ -1476,6 +1478,7 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.early_init = vcn_v5_0_0_early_init,
 	.sw_init = vcn_v5_0_0_sw_init,
 	.sw_fini = vcn_v5_0_0_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v5_0_0_hw_init,
 	.hw_fini = vcn_v5_0_0_hw_fini,
 	.suspend = vcn_v5_0_0_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 55a4b2f9463f..e7453d98cd0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -351,7 +351,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -372,7 +372,10 @@ static int vcn_v5_0_1_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		/* Teardown cancelled it synchronously in early_fini */
+		if (!adev->shutdown)
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
+
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
@@ -1660,6 +1663,7 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.late_init = vcn_v5_0_1_late_init,
 	.sw_init = vcn_v5_0_1_sw_init,
 	.sw_fini = vcn_v5_0_1_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v5_0_1_hw_init,
 	.hw_fini = vcn_v5_0_1_hw_fini,
 	.suspend = vcn_v5_0_1_suspend,
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
index ea6cdbcb6352..2f4aed8cd1ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_2.c
@@ -266,7 +266,7 @@ static int vcn_v5_0_2_hw_init(struct amdgpu_ip_block *ip_block)
 error:
 	while (i >= 0) {
 		if (!(adev->vcn.harvest_config & (1 << i)))
-			cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
 		i--;
 	}
 	return r;
@@ -287,7 +287,10 @@ static int vcn_v5_0_2_hw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
 
-		cancel_delayed_work_sync(&adev->vcn.inst[i].idle_work);
+		/* Teardown cancelled it synchronously in early_fini */
+		if (!adev->shutdown)
+			amdgpu_vcn_cancel_idle_work(&adev->vcn.inst[i]);
+
 		if (vinst->cur_state != AMD_PG_STATE_GATE)
 			vinst->set_pg_state(vinst, AMD_PG_STATE_GATE);
 	}
@@ -1451,6 +1454,7 @@ static const struct amd_ip_funcs vcn_v5_0_2_ip_funcs = {
 	.late_init = NULL,
 	.sw_init = vcn_v5_0_2_sw_init,
 	.sw_fini = vcn_v5_0_2_sw_fini,
+	.early_fini = amdgpu_vcn_early_fini,
 	.hw_init = vcn_v5_0_2_hw_init,
 	.hw_fini = vcn_v5_0_2_hw_fini,
 	.suspend = vcn_v5_0_2_suspend,
-- 
2.34.1

