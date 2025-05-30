Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2751DC5B552
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBEC610E825;
	Fri, 30 May 2025 09:04:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EEIsOfOK";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2052.outbound.protection.outlook.com [40.107.236.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ED7410E802
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rT6PJ7UZMaInFeVPcgVwyvcgHkuxEJ1aBjTkR83JgPDElw/KSg1pFl0Pwb5iqS6+OXkkzRiGQJ+NLGHJ3pT9pmX/3RBJU/79h4POsV4ASaL+UP5F06Y7211E7yRQR5ajAPngcSmvh8G+Fy8pHrmW+ETle5itfG8Li905+QYdbK1WSXc2rn+q1aoL1d//8nLKAIIkC1qyPlv5IWCgxNeU6GGgKSoDQTbvrsAFlZ0SOGgXtWBIKG/JMLRKRj+5uDHheBr9JgG2xYKdgyspHR3ixdnc8rjolQi3UG3TUVh/OtYFXX10fCG8ETTB4rLCs/wrRxM+UDvPvuw28mUG3RXr/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5qWxEAjW57/VMzKOWjY2lSeADpXtLAKVc17buSg6sA=;
 b=pkjkIftS5GtHIO1qk9mOnbJ6VaynnRODGua0yivQyGzQ+2L0AvmqEi0Q5v6xD0imemxdhj6/wOCtYzZ5owUDbYEtos2wOwruu5V+yl/tjB1VvrtNjUMSn8w30tjgJ/7LOKTdGB37Tj9qmcKg4HciSBQ5T1U4WZW24mDRkez6nVQ6PU+vWtu6YFoP2TTolw5iI6c2U5h1qMBc8aAHa1ShpjfABmWeLZj0VrV90vjcvzXAik/7grB6uiVxqPOwC6oZMNuSXyTkBi29P4f/wYnsMUuSx8kH7P+rWgJUSAvoYs3c8xNz6CgnbFAL51OAwl6DFqd/AFCpvfXrzdGVWbMcvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5qWxEAjW57/VMzKOWjY2lSeADpXtLAKVc17buSg6sA=;
 b=EEIsOfOK7Z5nMjQBCQIA0yL/d8hpJNV21vqtM/AAA0zFCyC5X3FO1JM7zGuTWNQjs83kBslzz1BVYf9f3VGA2gN2m6N+yAHStGAo58MyhC+CQjCb0sx7fjV2Y7G13qZjWNgi0yt/X6r9cjvADpxw6KZqVfxVXQbBFb496tl6Bpg=
Received: from BL0PR0102CA0055.prod.exchangelabs.com (2603:10b6:208:25::32) by
 DM4PR12MB6230.namprd12.prod.outlook.com (2603:10b6:8:a7::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.27; Fri, 30 May 2025 09:03:58 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:25:cafe::98) by BL0PR0102CA0055.outlook.office365.com
 (2603:10b6:208:25::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.29 via Frontend Transport; Fri,
 30 May 2025 09:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:03:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:03:57 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:03:56 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:03:50 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 05/14] drm/amdgpu/userq: implement resets
Date: Fri, 30 May 2025 17:00:06 +0800
Message-ID: <20250530090322.3589364-5-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DM4PR12MB6230:EE_
X-MS-Office365-Filtering-Correlation-Id: d2b970b9-22b6-4c9a-3f81-08dd9f58e99f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTVIMlp4eHBhVG00bWRVQUt5bGw5dnUycXU5eUs1T0psYXVwMS9ZNis0UzA0?=
 =?utf-8?B?RU44b1NQYzVYMmY5MkNaWW1USXZtWDg2bmVmbENGVUZaOGdKb3QxRHpyTUV5?=
 =?utf-8?B?bU5RTUNWYU9FR0xJYVo0K1BDdnZsTlpZZUdxUmhVclVHM29KTXM0dWJRc2hi?=
 =?utf-8?B?YVZ4SmM0RHdBYjAxMFpCUzgyaXBmeXI4ZWYwT2Via3llckFlZlkwUC82NWVS?=
 =?utf-8?B?aEd1NVBsZmx4YTZlNk1zaXpBR2wwUDJNTXFmNkVGZGlYU3lWSGJjY0ZwK0Fa?=
 =?utf-8?B?WE5HdzVObnNVcGMrU3JWS0NEWWo2cGtqWURvUDNERFpkUFg0UFh6dmNGODgy?=
 =?utf-8?B?d3pvUnlwVGJ2ODVWSXNaWWIzbWNMZkxYbU1Cdmg1Zi94a3grZXp6elRzc2FU?=
 =?utf-8?B?akRrT1hZcGFja08vVU1CeGYzUk5pbnZDQVBZZDlwVHBLVGQ1SDN3Z2piOUVj?=
 =?utf-8?B?aGZ0WGFmcVp1TnhjYy90eW95dTdCenlUYU5zQ2NGSUJGaldSdHEyUElRNTBj?=
 =?utf-8?B?VG9rU0o0YzhxS0tQOWJsZ05yclRnN25yVlExdk43N2dXNFJZVXh2dzRLcS9O?=
 =?utf-8?B?OU96b0RUSmxNQ29UNi9kaElma3VBQko1RFhDUHZOd21BMzZMNDFiL2cyY1BN?=
 =?utf-8?B?T2JTU3ZTM2FERWxacDNickVWU1djOEZieXVsNzluc0NPamtNU2taNlFRSXk1?=
 =?utf-8?B?dnRsTW5qZU5nenBiM0RiRXc1MXhZbXd3NDlJZWJuaTlJMEVmOHZtbmdOelZO?=
 =?utf-8?B?aVdtOG1qMGFlcGpkQkwzN2ZlQUNyYTJ0WUF6ak5PbTZQV3puN3k2ZEF1YWdp?=
 =?utf-8?B?bVkvMHdQNkpJZ1ZWQ0RSYTMzQ0tLMWg2WE12WHFWclFIM25MN2gybzhYR3lU?=
 =?utf-8?B?czd0WFZ0MWZWU1Aya0JSYnVROVk4bHBoYW02K2RHR2JGTjNQN0g1Y3g5WXAy?=
 =?utf-8?B?dlRLL0FYaEF3VVQ4U05HQ3lWSnM5OStXWnN6UjllRmJPZHNuSkpZWmxVYy9s?=
 =?utf-8?B?dXRjWjZ3MUhxQnUyRnY4Z01pNGxzQVY0TWFLd0lZZVc1MU1HaHltYlF1Ukh6?=
 =?utf-8?B?VnBWQUpMeHVaTC82a3p2cGtaZDZIK2FwWnE4Q1dKY1ZNQ0g2YTVKUVRWNk5R?=
 =?utf-8?B?MUxGamN3Y0U4OFBqZytDb2lNMFJjeHcrVnF0QnVRTkZ2dllXaEZhdG5iKzBQ?=
 =?utf-8?B?QmhEYjcrU2ozME9tbkVGa1lLTW4yM1kwNURFbVpSbTZrSW13WHRpZmV4L3ov?=
 =?utf-8?B?ekFIQVdmRG9JaThuMXNqSmNwTGF1TTJqcXBNSUZBYzdaajYrcnlveitLK2FZ?=
 =?utf-8?B?T1krTVkvTitGWVVJTFpVT2gyN1JibHljWEkyMVpyQk1sTVUvN091WlFsREhJ?=
 =?utf-8?B?NUFUVDY4SGQ4MUZrclJ6a3VCQ01CZ3N1TWloZ1M0Y2RQOHNJQmZFWGlkNCtB?=
 =?utf-8?B?czJDQ2hIU0N0aElFa1cyRWF6K1hmVVZVc1NXVDAveksrdnE4QnAvRzdsLzdw?=
 =?utf-8?B?OXA1bnR5dEI3bHZnZEo5NDgzTDhpZ21WUzZHd251WU54akpoK0JiZFZCZDRu?=
 =?utf-8?B?bFQxUzZSVmJZaWJEMk5OU2RoRi9LUVFFU0VXV29FSlBpa1pRMnQrRlNWaGQ2?=
 =?utf-8?B?UTJ0NFVCQStIRXcrd3p3MUkrZi92RjZxOTV3Z294WFFUM1FMdUN0ZmE1S0lw?=
 =?utf-8?B?NmhqWXZES1ZFc214cjA4NURhMXMwVEhMU2N2YmlBS3JyWm01c2s0dzFKU28y?=
 =?utf-8?B?TVl0TWtFMWFSKzYrZkxPakpBdFdNZUMxL1I2MngveXBTL0ZHSmZhbmE1RTdl?=
 =?utf-8?B?MElDYmRYQzdRWERUOTd0dGJWZUU3djBEMGJSL3lEeU1xbVdjYTRTeVEwTGJo?=
 =?utf-8?B?NTZoY1p3Z1p1bFJOSEl5d294b3VoWVlDSVpxOFlLaW5wbXpBeXE2WlBHY2lx?=
 =?utf-8?B?OUYxWnY0cE1yZ0ZVK3E2L0NzZ3VDbzFqNExZcU9yeFhzOEVxd3dRTUc4MW4w?=
 =?utf-8?B?VVF1NUhhYllGbEtYNWNuUUtnMWJrdDJ6c0Z5NWcyRmdTOTF3OHFyYzA0UEpQ?=
 =?utf-8?Q?estua3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:03:58.1521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2b970b9-22b6-4c9a-3f81-08dd9f58e99f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6230
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

From: Alex Deucher <alexander.deucher@amd.com>

If map or unmap fails, or a user fence times out, attempt to reset the queue.  If that fails, schedule a GPU reset.

Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   8 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 123 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   5 +
 4 files changed, 128 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index a5ccd0ada16a..7365558f47a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1303,6 +1303,7 @@ struct amdgpu_device {
 	struct list_head		userq_mgr_list;
 	struct mutex                    userq_mutex;
 	bool                            userq_halt_for_enforce_isolation;
+	struct work_struct		userq_reset_work;
 };
 
 static inline uint32_t amdgpu_ip_version(const struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 72e41781afb0..2c90a7d256e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4426,6 +4426,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	}
 
 	INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
+	INIT_WORK(&adev->userq_reset_work, amdgpu_userq_reset_work);
 
 	adev->gfx.gfx_off_req_count = 1;
 	adev->gfx.gfx_off_residency = 0;
@@ -5768,6 +5769,10 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 				if (r)
 					goto out;
 
+				r = amdgpu_userq_post_reset(tmp_adev, vram_lost);
+				if (r)
+					goto out;
+
 				drm_client_dev_resume(adev_to_drm(tmp_adev), false);
 
 				/*
@@ -5990,6 +5995,7 @@ static inline void amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
 	if (!amdgpu_sriov_vf(adev))
 		cancel_work(&adev->reset_work);
 #endif
+	cancel_work(&adev->userq_reset_work);
 
 	if (adev->kfd.dev)
 		cancel_work(&adev->kfd.reset_work);
@@ -6100,6 +6106,8 @@ static int amdgpu_device_halt_activities(struct amdgpu_device *adev,
 		      amdgpu_device_ip_need_full_reset(tmp_adev))
 			amdgpu_ras_suspend(tmp_adev);
 
+		amdgpu_userq_pre_reset(tmp_adev);
+
 		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
 			struct amdgpu_ring *ring = tmp_adev->rings[i];
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 295e7186e156..d4f807256383 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -26,7 +26,10 @@
 #include <drm/drm_exec.h>
 #include <linux/pm_runtime.h>
 
+#include <drm/drm_drv.h>
+
 #include "amdgpu.h"
+#include "amdgpu_reset.h"
 #include "amdgpu_vm.h"
 #include "amdgpu_userq.h"
 #include "amdgpu_userq_fence.h"
@@ -44,6 +47,44 @@ u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev)
 	return userq_ip_mask;
 }
 
+static void amdgpu_userq_gpu_reset(struct amdgpu_device *adev)
+{
+
+	if (amdgpu_device_should_recover_gpu(adev))
+		amdgpu_reset_domain_schedule(adev->reset_domain,
+					     &adev->userq_reset_work);
+}
+
+static bool
+amdgpu_userq_queue_reset_helper(struct amdgpu_userq_mgr *uq_mgr,
+				struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	const struct amdgpu_userq_funcs *userq_funcs =
+		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
+	int r;
+
+	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
+		dev_err(adev->dev, "userq reset disabled by debug mask\n");
+	} else if (amdgpu_gpu_recovery && userq_funcs->reset) {
+		r = userq_funcs->reset(uq_mgr, queue);
+		if (r) {
+			dev_err(adev->dev, "userq reset failed\n");
+			gpu_reset = true;
+		} else {
+			dev_err(adev->dev, "userq reset succeeded\n");
+			atomic_inc(&adev->gpu_reset_counter);
+			amdgpu_userq_fence_driver_force_completion(queue);
+			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
+		}
+	} else if (amdgpu_gpu_recovery && !userq_funcs->reset) {
+		gpu_reset = true;
+	}
+
+	return gpu_reset;
+}
+
 static int
 amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 			  struct amdgpu_usermode_queue *queue)
@@ -51,15 +92,22 @@ amdgpu_userq_unmap_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
 		r = userq_funcs->unmap(uq_mgr, queue);
-		if (r)
+		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
-		else
+			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
+		} else {
 			queue->state = AMDGPU_USERQ_STATE_UNMAPPED;
+		}
 	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
 	return r;
 }
 
@@ -70,16 +118,22 @@ amdgpu_userq_map_helper(struct amdgpu_userq_mgr *uq_mgr,
 	struct amdgpu_device *adev = uq_mgr->adev;
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
+	bool gpu_reset = false;
 	int r = 0;
 
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		r = userq_funcs->map(uq_mgr, queue);
 		if (r) {
 			queue->state = AMDGPU_USERQ_STATE_HUNG;
+			gpu_reset = amdgpu_userq_queue_reset_helper(uq_mgr, queue);
 		} else {
 			queue->state = AMDGPU_USERQ_STATE_MAPPED;
 		}
 	}
+
+	if (gpu_reset)
+		amdgpu_userq_gpu_reset(adev);
+
 	return r;
 }
 
@@ -703,6 +757,23 @@ amdgpu_userq_evict_all(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
+void amdgpu_userq_reset_work(struct work_struct *work)
+{
+	struct amdgpu_device *adev = container_of(work, struct amdgpu_device,
+						  userq_reset_work);
+	struct amdgpu_reset_context reset_context;
+
+	memset(&reset_context, 0, sizeof(reset_context));
+
+	reset_context.method = AMD_RESET_METHOD_NONE;
+	reset_context.reset_req_dev = adev;
+	reset_context.src = AMDGPU_RESET_SRC_USERQ;
+	set_bit(AMDGPU_NEED_FULL_RESET, &reset_context.flags);
+	/*set_bit(AMDGPU_SKIP_COREDUMP, &reset_context.flags);*/
+
+	amdgpu_device_gpu_recover(adev, NULL, &reset_context);
+}
+
 static int
 amdgpu_userq_wait_for_signal(struct amdgpu_userq_mgr *uq_mgr)
 {
@@ -729,22 +800,18 @@ void
 amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_eviction_fence *ev_fence)
 {
-	int ret;
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
 	struct amdgpu_eviction_fence_mgr *evf_mgr = &fpriv->evf_mgr;
+	int ret;
 
 	/* Wait for any pending userqueue fence work to finish */
 	ret = amdgpu_userq_wait_for_signal(uq_mgr);
-	if (ret) {
+	if (ret)
 		drm_file_err(uq_mgr->file, "Not evicting userqueue, timeout waiting for work\n");
-		return;
-	}
 
 	ret = amdgpu_userq_evict_all(uq_mgr);
-	if (ret) {
+	if (ret)
 		drm_file_err(uq_mgr->file, "Failed to evict userqueue\n");
-		return;
-	}
 
 	/* Signal current eviction fence */
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
@@ -922,3 +989,41 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
+{
+	const struct amdgpu_userq_funcs *userq_funcs;
+	struct amdgpu_usermode_queue *queue;
+	struct amdgpu_userq_mgr *uqm, *tmp;
+	int queue_id;
+
+	mutex_lock(&adev->userq_mutex);
+	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		cancel_delayed_work_sync(&uqm->resume_work);
+		mutex_lock(&uqm->userq_mutex);
+		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
+			if (queue->state == AMDGPU_USERQ_STATE_MAPPED) {
+				amdgpu_userq_wait_for_last_fence(uqm, queue);
+				userq_funcs = adev->userq_funcs[queue->queue_type];
+				userq_funcs->unmap(uqm, queue);
+				/* just mark all queues as hung at this point.
+				 * if unmap succeeds, we could map again
+				 * in amdgpu_userq_post_reset() if vram is not lost
+				 */
+				queue->state = AMDGPU_USERQ_STATE_HUNG;
+				amdgpu_userq_fence_driver_force_completion(queue);
+			}
+		}
+		mutex_unlock(&uqm->userq_mutex);
+	}
+	mutex_unlock(&adev->userq_mutex);
+}
+
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost)
+{
+	/* if any queue state is AMDGPU_USERQ_STATE_UNMAPPED
+	 * at this point, we should be able to map it again
+	 * and continue if vram is not lost.
+	 */
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 3cc0ad8919f4..9d62befcdb24 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -134,4 +134,9 @@ int amdgpu_userq_stop_sched_for_enforce_isolation(struct amdgpu_device *adev,
 int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 						   u32 idx);
 
+void amdgpu_userq_reset_work(struct work_struct *work);
+
+void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
+int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
+
 #endif
-- 
2.49.0

