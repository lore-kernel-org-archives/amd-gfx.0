Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10914EB64DD
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Aug 2023 06:03:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AA8710E658;
	Fri, 11 Aug 2023 06:03:42 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646B110E658
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Aug 2023 06:03:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PKj9OXTZ/P+Wd/NM4q0JHXzBe58pa/kWUNkUtvq07HPP9SCspFwryEpYKNFrN66EcQHujzDa2fJ20ia8tsgWSu0qJCeBnwx3NEK2kBVTkUF9BiaQGg+IwEENNHSrlj1CqXCcetJYEFz7VgIdSjE1Ne48zkwOV7Ahg9OSyMBsvK55zS8wJhPncEEKqMIRw/Y3Mtqck6il5ioxsc9B9Exn1v0cAoB/aoMttrwfLBVcNRDDwOUvOAOUiElKJwmryo1Bh0v3ZD8pvrr7DRtcXcA8iVNeXHuqljU9kgnA814FSqPckBYgux29GfWuWqR1KMXfaUcgw4Ge9Kqa82j58A5OQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WtVlllZ873zkL1JoGX9ZMqQjJEDUPJ3xEJ5IaJ+efl0=;
 b=fu3d4J1B9ML19kH/4yAdS1dJjlT3hZiv8iu3N3pynkwwwyOwy6jKrutD539HqfCig1yu6pZvo0mpHRlPLogxAalsvsB4Q0D2+TMrP8n0F7sdVILjjA9EfaDLXHX7vdtyMKPZ/xqYO14l0s0CYwzjyiREJpJ1dr1Q0e2KHE2qytH0Ew+L+QtxACu4wCxT7tE7UbN5d8dXm6raLGRUXQ7rEcPvl+MM/zaZbrf92eRyzR/7Jjgm3j4s67Ok/EFWbb+YMTT1TuowTsh+A6529oZb7ni1Vf5Ih+qHBMmWVy3fY6D6+dgnR56rXNw0NZcAwuaTcNx4x4b54gBGSMIrr55zow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WtVlllZ873zkL1JoGX9ZMqQjJEDUPJ3xEJ5IaJ+efl0=;
 b=C6kEuEiG+o/H0aRGrIUVgcMDZ3Q6SveisfAAEB/X9WWGGh7UshVc5ma85KhPm8kmiLR0+eLyppHv0wYBoA8MCdvKwDR29d8lc/Bm6WLhLCB1H3i4Hf+TC8SP+mqcT2fA+rXOIDQ9wG0XScIqTE5bNxpsiQe6Gm/wSTmTw4KrWwQ=
Received: from MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM (2603:10b6:303:80::6) by
 PH0PR12MB7983.namprd12.prod.outlook.com (2603:10b6:510:28e::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.30; Fri, 11 Aug 2023 06:03:36 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:303:80:cafe::2a) by MW4P223CA0001.outlook.office365.com
 (2603:10b6:303:80::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.31 via Frontend
 Transport; Fri, 11 Aug 2023 06:03:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 11 Aug 2023 06:03:35 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 01:02:53 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/5] drm/amdgpu: Move to reset_schedule_work
Date: Fri, 11 Aug 2023 11:32:31 +0530
Message-ID: <20230811060234.663789-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230811060234.663789-1-lijo.lazar@amd.com>
References: <20230811060234.663789-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|PH0PR12MB7983:EE_
X-MS-Office365-Filtering-Correlation-Id: 58004c7d-b3bc-4886-6b0a-08db9a30b356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +CaUAT+dY1OrwzUBou8QZfZFVDycxixVm3JwLT6QTsYlcAp6mvSFVkFEUa1bTd75DnbjpCo15oYTdKWIv365bJKc4cLg3HckW2qxryv74ITb0xfIcl3UlwzxZUWMTe39CYNS2W+iB01knBlXkFp77fbFOf/yNnp3GNoXuCo0s8WEyap2Fegv9NqQr1s9lL4zD9HAAyLRa242tCKxzr3TllejZcpE/DX/i0mpf0dlwsulIqqmRky0guU0LFmjuqOP/Yt7mB6yqq0gRAu8SC4Fn5EcpqivuZV5F7RgR9ifDmdb3eB1uoahrxmYuz1uPsgDoxMDSmlFh4UARydlZ5EaHk+PqIZNWAhMAqgWq7NEUOZp4tRP9w5w4QA0+lf4w6KGqLC44OJDLDf8SDYrjgWaFql5OxUCcemg+D3NUrCAAs5tprZBVJzaHg+rHUp1LcW1Qd4HHs9IBVyL8jratHgeQkHn34xYEobTNJoWeiih7Zbon5zU/uaak2b+CujmfHyGJ0wfap5yxMEFEaHnY+mnsH4l1+g/1nl0KuBB9BHUZe9UzwB+3escCMa4FGhHjo5CArTL1OV8Anu7XZ/r+mUzxaqjzRH/0MNjIjSZo1M0iO8QWfQynZIlGR0ZeM8d3VNHsRnhx/rddvYA0jencfzn2OJtE+RC70GberopanDE0b/1jl5VHT/lFRbEvpXMOFcbl5ijVSE52GG528e8I34mUI7+DonPVeelRbFhbSs3oIVx1X//aia+7iClDVBxErxf9wE7iHf/V+s8FvEeP2iNUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(82310400008)(1800799006)(186006)(36840700001)(40470700004)(46966006)(40460700003)(40480700001)(54906003)(16526019)(70206006)(6916009)(1076003)(26005)(336012)(478600001)(6666004)(70586007)(36756003)(86362001)(83380400001)(426003)(47076005)(2616005)(36860700001)(7696005)(41300700001)(316002)(44832011)(4326008)(2906002)(81166007)(30864003)(8676002)(356005)(82740400003)(8936002)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 06:03:35.7825 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58004c7d-b3bc-4886-6b0a-08db9a30b356
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7983
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
Cc: Alexander.Deucher@amd.com, Asad.Kamal@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move recovery handlers to schedule reset work. Make use of the workpool
in the reset domain and delete the individual work items.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 32 +++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 -----
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 40 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c    | 71 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   |  1 -
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 38 ++++++------
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 44 ++++++--------
 drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 33 +++++-----
 10 files changed, 118 insertions(+), 159 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 2e3c7c15cb8e..4186d8342a15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1096,8 +1096,6 @@ struct amdgpu_device {
 	bool                            scpm_enabled;
 	uint32_t                        scpm_status;
 
-	struct work_struct		reset_work;
-
 	bool                            job_hang;
 	bool                            dc_enabled;
 	/* Mask of active clusters */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 629ca1ad75a8..e4c5e8f68843 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -120,21 +120,10 @@ static void amdgpu_doorbell_get_kfd_info(struct amdgpu_device *adev,
 	}
 }
 
-
-static void amdgpu_amdkfd_reset_work(struct work_struct *work)
+static void amdgpu_amdkfd_reset_work(struct amdgpu_reset_context *reset_context)
 {
-	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
-						  kfd.reset_work);
-
-	struct amdgpu_reset_context reset_context;
-
-	memset(&reset_context, 0, sizeof(reset_context));
-
-	reset_context.method = AMD_RESET_METHOD_NONE;
-	reset_context.reset_req_dev = adev;
-	clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-
-	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+	amdgpu_device_gpu_recover(reset_context->reset_req_dev, NULL,
+				  reset_context);
 }
 
 void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
@@ -200,7 +189,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
 
-		INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
 	}
 }
 
@@ -268,9 +256,17 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
 
 void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
-	if (amdgpu_device_should_recover_gpu(adev))
-		amdgpu_reset_domain_schedule(adev->reset_domain,
-					     &adev->kfd.reset_work);
+	struct amdgpu_reset_context reset_context;
+
+	if (amdgpu_device_should_recover_gpu(adev)) {
+		memset(&reset_context, 0, sizeof(reset_context));
+		reset_context.method = AMD_RESET_METHOD_NONE;
+		reset_context.reset_req_dev = adev;
+		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+
+		amdgpu_reset_schedule_work(adev, &reset_context,
+					   amdgpu_amdkfd_reset_work);
+	}
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index b34418e3e006..c36501f9ae0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -102,7 +102,6 @@ struct amdgpu_kfd_dev {
 	int64_t vram_used[MAX_XCP];
 	uint64_t vram_used_aligned[MAX_XCP];
 	bool init_complete;
-	struct work_struct reset_work;
 
 	/* HMM page migration MEMORY_DEVICE_PRIVATE mapping */
 	struct dev_pagemap pgmap;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9061d79cd387..3e56ccb742bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5152,21 +5152,6 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
 
 static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 {
-	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
-
-#if defined(CONFIG_DEBUG_FS)
-	if (!amdgpu_sriov_vf(adev))
-		cancel_work(&adev->reset_work);
-#endif
-
-	if (adev->kfd.dev)
-		cancel_work(&adev->kfd.reset_work);
-
-	if (amdgpu_sriov_vf(adev))
-		cancel_work(&adev->virt.flr_work);
-
-	if (con && adev->ras_enabled)
-		cancel_work(&con->recovery_work);
 
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c694b41f6461..40786b135f4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -899,6 +899,14 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
 	return 0;
 }
 
+static void
+amdgpu_debugfs_reset_work(struct amdgpu_reset_context *reset_context)
+{
+	struct amdgpu_device *adev = reset_context->reset_req_dev;
+
+	amdgpu_device_gpu_recover(adev, NULL, reset_context);
+}
+
 /*
  * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover
  *
@@ -908,6 +916,7 @@ static int gpu_recover_get(void *data, u64 *val)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)data;
 	struct drm_device *dev = adev_to_drm(adev);
+	struct amdgpu_reset_context reset_context;
 	int r;
 
 	r = pm_runtime_get_sync(dev->dev);
@@ -916,8 +925,14 @@ static int gpu_recover_get(void *data, u64 *val)
 		return 0;
 	}
 
-	if (amdgpu_reset_domain_schedule(adev->reset_domain, &adev->reset_work))
-		flush_work(&adev->reset_work);
+	memset(&reset_context, 0, sizeof(reset_context));
+	reset_context.method = AMD_RESET_METHOD_NONE;
+	reset_context.reset_req_dev = adev;
+	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	set_bit(AMDGPU_RESET_SCHEDULE_NOW, &reset_context.flags);
+
+	amdgpu_reset_schedule_work(adev, &reset_context,
+				   amdgpu_debugfs_reset_work);
 
 	*val = atomic_read(&adev->reset_domain->reset_res);
 
@@ -931,22 +946,6 @@ DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
 DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
 			 "%lld\n");
 
-static void amdgpu_debugfs_reset_work(struct work_struct *work)
-{
-	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
-						  reset_work);
-
-	struct amdgpu_reset_context reset_context;
-
-	memset(&reset_context, 0, sizeof(reset_context));
-
-	reset_context.method = AMD_RESET_METHOD_NONE;
-	reset_context.reset_req_dev = adev;
-	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-
-	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
-}
-
 #endif
 
 void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
@@ -958,12 +957,9 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
 	debugfs_create_file("amdgpu_fence_info", 0444, root, adev,
 			    &amdgpu_debugfs_fence_info_fops);
 
-	if (!amdgpu_sriov_vf(adev)) {
-
-		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
+	if (!amdgpu_sriov_vf(adev))
 		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
 				    &amdgpu_debugfs_gpu_recover_fops);
-	}
 #endif
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 7689395e44fd..9e8e904434f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2011,12 +2011,11 @@ static int amdgpu_ras_badpages_read(struct amdgpu_device *adev,
 	return ret;
 }
 
-static void amdgpu_ras_do_recovery(struct work_struct *work)
+static void amdgpu_ras_do_recovery(struct amdgpu_reset_context *reset_context)
 {
-	struct amdgpu_ras *ras =
-		container_of(work, struct amdgpu_ras, recovery_work);
+	struct amdgpu_device *adev = reset_context->reset_req_dev;
+	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
 	struct amdgpu_device *remote_adev = NULL;
-	struct amdgpu_device *adev = ras->adev;
 	struct list_head device_list, *device_list_handle =  NULL;
 
 	if (!ras->disable_ras_err_cnt_harvest) {
@@ -2040,37 +2039,9 @@ static void amdgpu_ras_do_recovery(struct work_struct *work)
 		amdgpu_put_xgmi_hive(hive);
 	}
 
-	if (amdgpu_device_should_recover_gpu(ras->adev)) {
-		struct amdgpu_reset_context reset_context;
-		memset(&reset_context, 0, sizeof(reset_context));
-
-		reset_context.method = AMD_RESET_METHOD_NONE;
-		reset_context.reset_req_dev = adev;
-
-		/* Perform full reset in fatal error mode */
-		if (!amdgpu_ras_is_poison_mode_supported(ras->adev))
-			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-		else {
-			clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-
-			if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET) {
-				ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE2_RESET;
-				reset_context.method = AMD_RESET_METHOD_MODE2;
-			}
-
-			/* Fatal error occurs in poison mode, mode1 reset is used to
-			 * recover gpu.
-			 */
-			if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET) {
-				ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE1_RESET;
-				set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-
-				psp_fatal_error_recovery_quirk(&adev->psp);
-			}
-		}
+	if (amdgpu_device_should_recover_gpu(ras->adev))
+		amdgpu_device_gpu_recover(ras->adev, NULL, reset_context);
 
-		amdgpu_device_gpu_recover(ras->adev, NULL, &reset_context);
-	}
 	atomic_set(&ras->in_recovery, 0);
 }
 
@@ -2313,7 +2284,6 @@ int amdgpu_ras_recovery_init(struct amdgpu_device *adev)
 	}
 
 	mutex_init(&con->recovery_lock);
-	INIT_WORK(&con->recovery_work, amdgpu_ras_do_recovery);
 	atomic_set(&con->in_recovery, 0);
 	con->eeprom_control.bad_channel_bitmap = 0;
 
@@ -3160,9 +3130,38 @@ int amdgpu_ras_is_supported(struct amdgpu_device *adev,
 int amdgpu_ras_reset_gpu(struct amdgpu_device *adev)
 {
 	struct amdgpu_ras *ras = amdgpu_ras_get_context(adev);
+	struct amdgpu_reset_context reset_context;
+
+	memset(&reset_context, 0, sizeof(reset_context));
+
+	reset_context.method = AMD_RESET_METHOD_NONE;
+	reset_context.reset_req_dev = adev;
+
+	/* Perform full reset in fatal error mode */
+	if (!amdgpu_ras_is_poison_mode_supported(ras->adev)) {
+		set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	}
+	else {
+		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+		if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE2_RESET) {
+			ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE2_RESET;
+			reset_context.method = AMD_RESET_METHOD_MODE2;
+		}
+
+		/* Fatal error occurs in poison mode, mode1 reset is used to
+		 * recover gpu.
+		 */
+		if (ras->gpu_reset_flags & AMDGPU_RAS_GPU_RESET_MODE1_RESET) {
+			ras->gpu_reset_flags &= ~AMDGPU_RAS_GPU_RESET_MODE1_RESET;
+			set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+			psp_fatal_error_recovery_quirk(&adev->psp);
+		}
+	}
 
 	if (atomic_cmpxchg(&ras->in_recovery, 0, 1) == 0)
-		amdgpu_reset_domain_schedule(ras->adev->reset_domain, &ras->recovery_work);
+		amdgpu_reset_schedule_work(ras->adev, &reset_context,
+					   amdgpu_ras_do_recovery);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index fabb83e9d9ae..87e0a8b918df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -237,7 +237,6 @@ struct amdgpu_virt {
 	uint32_t			reg_val_offs;
 	struct amdgpu_irq_src		ack_irq;
 	struct amdgpu_irq_src		rcv_irq;
-	struct work_struct		flr_work;
 	struct amdgpu_mm_table		mm_table;
 	const struct amdgpu_virt_ops	*ops;
 	struct amdgpu_vf_error_buffer	vf_errors;
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index 63725b2ebc03..53fdf6e70ad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -249,10 +249,9 @@ static int xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
+static void xgpu_ai_mailbox_flr_work(struct amdgpu_reset_context *reset_context)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
-	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+	struct amdgpu_device *adev = reset_context->reset_req_dev;
 	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
@@ -281,18 +280,10 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	up_write(&adev->reset_domain->sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
-	if (amdgpu_device_should_recover_gpu(adev)
-		&& (!amdgpu_device_has_job_running(adev) ||
-			adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)) {
-		struct amdgpu_reset_context reset_context;
-		memset(&reset_context, 0, sizeof(reset_context));
-
-		reset_context.method = AMD_RESET_METHOD_NONE;
-		reset_context.reset_req_dev = adev;
-		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-
-		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
-	}
+	if (amdgpu_device_should_recover_gpu(adev) &&
+	    (!amdgpu_device_has_job_running(adev) ||
+	     adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
+		amdgpu_device_gpu_recover(adev, NULL, reset_context);
 }
 
 static int xgpu_ai_set_mailbox_rcv_irq(struct amdgpu_device *adev,
@@ -314,14 +305,21 @@ static int xgpu_ai_mailbox_rcv_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	enum idh_event event = xgpu_ai_mailbox_peek_msg(adev);
+	struct amdgpu_reset_context reset_context;
 
 	switch (event) {
 		case IDH_FLR_NOTIFICATION:
+		memset(&reset_context, 0, sizeof(reset_context));
+
+		reset_context.method = AMD_RESET_METHOD_NONE;
+		reset_context.reset_req_dev = adev;
+		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+
 		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
-			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
-								&adev->virt.flr_work),
-				  "Failed to queue work! at %s",
-				  __func__);
+			WARN_ONCE(!amdgpu_reset_schedule_work(
+					  adev, &reset_context,
+					  xgpu_ai_mailbox_flr_work),
+				  "Failed to queue work! at %s", __func__);
 		break;
 		case IDH_QUERY_ALIVE:
 			xgpu_ai_mailbox_send_ack(adev);
@@ -388,8 +386,6 @@ int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev)
 		return r;
 	}
 
-	INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 6a68ee946f1c..171fe3e84ddf 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -271,10 +271,9 @@ static int xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
+static void xgpu_nv_mailbox_flr_work(struct amdgpu_reset_context *reset_context)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
-	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+	struct amdgpu_device *adev = reset_context->reset_req_dev;
 	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
@@ -303,21 +302,13 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	up_write(&adev->reset_domain->sem);
 
 	/* Trigger recovery for world switch failure if no TDR */
-	if (amdgpu_device_should_recover_gpu(adev)
-		&& (!amdgpu_device_has_job_running(adev) ||
-		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
-		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
-		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
-		adev->video_timeout == MAX_SCHEDULE_TIMEOUT)) {
-		struct amdgpu_reset_context reset_context;
-		memset(&reset_context, 0, sizeof(reset_context));
-
-		reset_context.method = AMD_RESET_METHOD_NONE;
-		reset_context.reset_req_dev = adev;
-		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-
-		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
-	}
+	if (amdgpu_device_should_recover_gpu(adev) &&
+	    (!amdgpu_device_has_job_running(adev) ||
+	     adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
+	     adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
+	     adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
+	     adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
+		amdgpu_device_gpu_recover(adev, NULL, reset_context);
 }
 
 static int xgpu_nv_set_mailbox_rcv_irq(struct amdgpu_device *adev,
@@ -342,14 +333,21 @@ static int xgpu_nv_mailbox_rcv_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	enum idh_event event = xgpu_nv_mailbox_peek_msg(adev);
+	struct amdgpu_reset_context reset_context;
 
 	switch (event) {
 	case IDH_FLR_NOTIFICATION:
+		memset(&reset_context, 0, sizeof(reset_context));
+
+		reset_context.method = AMD_RESET_METHOD_NONE;
+		reset_context.reset_req_dev = adev;
+		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+
 		if (amdgpu_sriov_runtime(adev) && !amdgpu_in_reset(adev))
-			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
-				   &adev->virt.flr_work),
-				  "Failed to queue work! at %s",
-				  __func__);
+			WARN_ONCE(!amdgpu_reset_schedule_work(
+					  adev, &reset_context,
+					  xgpu_nv_mailbox_flr_work),
+				  "Failed to queue work! at %s", __func__);
 		break;
 		/* READY_TO_ACCESS_GPU is fetched by kernel polling, IRQ can ignore
 		 * it byfar since that polling thread will handle it,
@@ -413,8 +411,6 @@ int xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev)
 		return r;
 	}
 
-	INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
index 59f53c743362..a39805bc69c1 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
@@ -510,10 +510,9 @@ static int xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
+static void xgpu_vi_mailbox_flr_work(struct amdgpu_reset_context *reset_context)
 {
-	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
-	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
+	struct amdgpu_device *adev = reset_context->reset_req_dev;
 
 	/* wait until RCV_MSG become 3 */
 	if (xgpu_vi_poll_msg(adev, IDH_FLR_NOTIFICATION_CMPL)) {
@@ -522,16 +521,8 @@ static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
 	}
 
 	/* Trigger recovery due to world switch failure */
-	if (amdgpu_device_should_recover_gpu(adev)) {
-		struct amdgpu_reset_context reset_context;
-		memset(&reset_context, 0, sizeof(reset_context));
-
-		reset_context.method = AMD_RESET_METHOD_NONE;
-		reset_context.reset_req_dev = adev;
-		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
-
-		amdgpu_device_gpu_recover(adev, NULL, &reset_context);
-	}
+	if (amdgpu_device_should_recover_gpu(adev))
+		amdgpu_device_gpu_recover(adev, NULL, reset_context);
 }
 
 static int xgpu_vi_set_mailbox_rcv_irq(struct amdgpu_device *adev,
@@ -553,18 +544,24 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
 				   struct amdgpu_iv_entry *entry)
 {
 	int r;
+	struct amdgpu_reset_context reset_context;
 
 	/* trigger gpu-reset by hypervisor only if TDR disabled */
 	if (!amdgpu_gpu_recovery) {
 		/* see what event we get */
 		r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
+		memset(&reset_context, 0, sizeof(reset_context));
+
+		reset_context.method = AMD_RESET_METHOD_NONE;
+		reset_context.reset_req_dev = adev;
+		clear_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
 
 		/* only handle FLR_NOTIFY now */
 		if (!r && !amdgpu_in_reset(adev))
-			WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
-								&adev->virt.flr_work),
-				  "Failed to queue work! at %s",
-				  __func__);
+			WARN_ONCE(!amdgpu_reset_schedule_work(
+					  adev, &reset_context,
+					  xgpu_vi_mailbox_flr_work),
+				  "Failed to queue work! at %s", __func__);
 	}
 
 	return 0;
@@ -618,8 +615,6 @@ int xgpu_vi_mailbox_get_irq(struct amdgpu_device *adev)
 		return r;
 	}
 
-	INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
-
 	return 0;
 }
 
-- 
2.25.1

