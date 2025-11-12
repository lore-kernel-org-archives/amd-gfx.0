Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D785CD3438
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 19:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DCA5D10E1CC;
	Wed, 12 Nov 2025 19:16:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2sh3H75L";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011040.outbound.protection.outlook.com [52.101.52.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2FB10E1CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 19:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=orZgcDpxj6qJmP9VsKjRxlgs2Q0D653yyDZjhvz7B/zEYPS6OHs/G3ewJ9GpcoaEhFGwBW1QdhLyVGIXrOidynXf23/6U/EbX+s5C25Yxj0PNEeFwe7aelhhYyufdKz/S2F7XJR97mUwTrjpIKlKL7EEFIbLovyDQFHI5uJjWVbkZH3zVvE2h2xl7tmbTWFsMeeoeKJTz7MOpblfS8TR/5zQUO2CsNVYbhivqcjbKebxet7d0Iez99jhlJZWvdnE79SoVGwOY+gwM4sYxeMbhVEls5PFFxgu5oqRxojonxxl0VDxNeeWlDtGbmEMUT3IjYl/FxJ2A8cz5bTL/0XBTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWEOih5cabkU7+EeGAkSpi+S73036TEqRjEdaiPGMd0=;
 b=gto9jmejPWPcPta2cnCIFvc5E6rC6EQSsvfw6j4V6dg5oNziPljDy6PZMA8Mml+yO0iDRJ1SyXVqJqH3QzGmRVjtiYh3xGV/JSf0ix0SRP+fl8Rrv3pRAV073xukDAEOdZAzJF/OoOPRkfXxf0RG+XyHmgTxVRRyCufR47IFCcj7HwXdeMzf4QRjf+c25m7Zf5jB4bnZ4ifpTI7gu7IbMPYVZU2TbmWkwFPRB1Y5fHEXvBda5Gz45Z3yaO0nLOYK7ajOgqvR72ikIdYwgmbHszm+b2zLAaughfeE+CjawtDcv+MEywSruwv2lVXcwhsY7VmSY4UYhdfDi3BQtHGPjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWEOih5cabkU7+EeGAkSpi+S73036TEqRjEdaiPGMd0=;
 b=2sh3H75L2gV5LdxLkGSlUtCbxbX/8MfHhBjkWPG0O949kVUC/NMBPElXZi3YDxX8hJXgGmi1YO86hjMI+6wfYAe/lWIEBPslNXELuS2yRjVd4ivSvPHVrlrl+hBnaUT2CC6sZ/SGakx6J0KlIciihoGCVae6M1nqKBcN0JeWTys=
Received: from PH8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:510:2cd::10)
 by SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 19:16:50 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::2) by PH8PR07CA0021.outlook.office365.com
 (2603:10b6:510:2cd::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 19:16:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 19:16:48 +0000
Received: from amartin-dev-ubuntu.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 12 Nov 2025 11:16:41 -0800
From: Andrew Martin <andrew.martin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Andrew Martin <andrew.martin@amd.com>
Subject: [PATCH v2] drm/amdkfd: Ignored various return code
Date: Wed, 12 Nov 2025 14:16:29 -0500
Message-ID: <20251112191629.803174-1-andrew.martin@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SJ0PR12MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: dbc32eec-6466-463b-dfc3-08de2220070d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0GPWOY9IFNq22dciviYRe+Se6SD68GixM1x/IH2lklaIUq+BmK717ukND0ok?=
 =?us-ascii?Q?9oXvaTJUslzGT52xRHlu4cFWlH2d5285Y+RuNBrby2uciYPEy970NxUKdvT+?=
 =?us-ascii?Q?gKbiYdp2NfGlA2iBaaenMKJy9E8g2kdiGyuaAxdt0uwE8mISslmtvF6xUUDd?=
 =?us-ascii?Q?wT2QxL2zmiIUU0pl+kQsUSf3OeHh73XsCGdL4JIsqz2SiZoJybfFJPyJRx3o?=
 =?us-ascii?Q?6+bHwOzexhYJPTPPxixMFa5Cg34InjndM9SFOKCfoUhSl3yh7ZQpRdjRxtIe?=
 =?us-ascii?Q?N/OjRbVHyBuG6FTC7BGjVw5hqOUlZGUvYN9RDEjW/o4u0QpArJn8NRJevv2P?=
 =?us-ascii?Q?WchxMsJw5l+bB1hj8d8tRRm6iuvgIZPBX0417CtcpPVi7pXa+g6TollKkXnt?=
 =?us-ascii?Q?hfdIpqIGCaw+KLh57aKy5nBAx2+Do0QjM3Jb8iFXRsDYxls0Y18qP0qRYGc2?=
 =?us-ascii?Q?/6Q73UgO4oXqE3QVtHc9c9lw+AgrnT9LaZIShlffAEBT9B+ByLK597AboPYf?=
 =?us-ascii?Q?cCxRYG+wplX/mxf2twX/+I9I2Qdmvlp8xQH58Nl+wh6aerpgnB+N1M9/OQBE?=
 =?us-ascii?Q?T6H+LR+4ziseZh/NFdbt+RlB32PloHVvetYEd2CzJY9yNjqdzlJDtTBoq1SU?=
 =?us-ascii?Q?RKWwcTM9op89385huTZH9jUPa6vgOBRb/Om28eKr7qxJkhsdNHejVFKBH4gb?=
 =?us-ascii?Q?6bn7L0B3XKylhDOJ2w77C/Xxv9vU28sVTH5G9ChZ/CxRvC3vdktoy94l8XEc?=
 =?us-ascii?Q?8npJ32q51CPvRO21Fl56ayUw02PvG3eoPO2VOqNkqqGmJQFWq+fZenqdnFQ5?=
 =?us-ascii?Q?f1Yoz9Ho11pmzLFQqRjDxgMQ3tVnFgm2pdeqtwsnx7P3mITCPxfAwpLGqH5r?=
 =?us-ascii?Q?zVxKj7umAhOwKuvQu0t3gJehY73s9OIzQJct4zMutT2kE2qMYYF8JpU515aM?=
 =?us-ascii?Q?rKKMxsDEFWR8ZSiWAeibEh+FbDhLL6mLYkw5XqjcRBIS9B0FRW9s0Aa3/b5T?=
 =?us-ascii?Q?tVWXlCZ09HnCP31kUGh5R0VGnWGQ246uNI11hvAHiQPSu9anWBhbLdRKIhlZ?=
 =?us-ascii?Q?SgwejfYyTXdCRka+tujnw0oK0KXuuozNqoVsVQVZDSs9HlG5aM622d3DMfnt?=
 =?us-ascii?Q?XnOJtiHm/bS3YNW7FCUKNNEuTuOIfQ9iHTC+yvCfrHHG7SPRM3qmYYUP7vlo?=
 =?us-ascii?Q?eS3k3zjZeVnD+4anXCeP/bk3HP1bKUsNOX1XgOe4+c4qrhtcHdHIV2uL+0y7?=
 =?us-ascii?Q?jko4A1EDeigFD2rCPy6eKqmgqR3M+QyWO1TKN20Bx16QMmxKymeMIsVG8kp2?=
 =?us-ascii?Q?5E7WpRNoPN5Pv8oAnjMVHw/1wLR6oV6kLhLQxCyU38DqnvPTC4UaNJTesTh6?=
 =?us-ascii?Q?zD3e/ZVQikRJlx5Qjn9XaWdTApVz4sR079Y50FjIEAKeDgv/xmMhU6Z2yeOq?=
 =?us-ascii?Q?BUcGP11SRCxb1B6AQh2GoT2a78ySrrRC+WGORaZ2v0dJ6OwkvajX0ry7kVve?=
 =?us-ascii?Q?v9v8/hVOCpkLDrznKtfBmAfWXjR1CoPw1bzKbclfFTlqCJZ1uFIQOUdPqzSo?=
 =?us-ascii?Q?IUZeU6qPJr0rR65Sy94=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 19:16:48.5216 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbc32eec-6466-463b-dfc3-08de2220070d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5633
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

The return code of a non void function should not be ignored. In cases
where we do not care, the code needs to suppress it.

Signed-off-by: Andrew Martin <andrew.martin@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c          | 13 ++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c            | 10 ++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c              |  9 +++++----
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c   |  6 ++++--
 4 files changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 652389d0d4e6..ab701590c5e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -288,8 +288,10 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *adev)
 void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
 {
 	if (amdgpu_device_should_recover_gpu(adev))
-		amdgpu_reset_domain_schedule(adev->reset_domain,
-					     &adev->kfd.reset_work);
+		WARN_ONCE(!amdgpu_reset_domain_schedule(adev->reset_domain,
+							&adev->kfd.reset_work),
+							"Failed to queue work! at %s",
+							 __func__);
 }
 
 int amdgpu_amdkfd_alloc_gtt_mem(struct amdgpu_device *adev, size_t size,
@@ -690,9 +692,10 @@ void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device *adev, bool idle)
 		if (gfx_block != NULL)
 			gfx_block->version->funcs->set_powergating_state((void *)gfx_block, state);
 	}
-	amdgpu_dpm_switch_power_profile(adev,
-					PP_SMC_POWER_PROFILE_COMPUTE,
-					!idle);
+	WARN_ONCE(!amdgpu_dpm_switch_power_profile(adev, PP_SMC_POWER_PROFILE_COMPUTE, !idle),
+		  "(%s) failed to disable video power profile mode",
+		  __func__);
+
 }
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index a2149afa5803..a54321ba7cb7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2782,7 +2782,8 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 		 * saved in MES.
 		 */
 		if (pdd->dev->kfd->shared_resources.enable_mes)
-			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+			(void)kfd_dbg_set_mes_debug_mode(pdd,
+							 !kfd_dbg_has_cwsr_workaround(pdd->dev));
 	}
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
@@ -2874,10 +2875,11 @@ static int runtime_disable(struct kfd_process *p)
 					pdd->dev->vm_info.last_vmid_kfd);
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
-				debug_refresh_runlist(pdd->dev->dqm);
+				(void)debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd,
-							   !kfd_dbg_has_cwsr_workaround(pdd->dev));
+				(void)kfd_dbg_set_mes_debug_mode(
+					pdd,
+					!kfd_dbg_has_cwsr_workaround(pdd->dev));
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index ba99e0f258ae..cfa3f0d1888a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -565,9 +565,9 @@ int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags)
 				continue;
 
 			if (!pdd->dev->kfd->shared_resources.enable_mes)
-				debug_refresh_runlist(pdd->dev->dqm);
+				(void)debug_refresh_runlist(pdd->dev->dqm);
 			else
-				kfd_dbg_set_mes_debug_mode(pdd, true);
+				(void)kfd_dbg_set_mes_debug_mode(pdd, true);
 		}
 	}
 
@@ -627,9 +627,10 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
 			pr_err("Failed to release debug vmid on [%i]\n", pdd->dev->id);
 
 		if (!pdd->dev->kfd->shared_resources.enable_mes)
-			debug_refresh_runlist(pdd->dev->dqm);
+			(void)debug_refresh_runlist(pdd->dev->dqm);
 		else
-			kfd_dbg_set_mes_debug_mode(pdd, !kfd_dbg_has_cwsr_workaround(pdd->dev));
+			(void)kfd_dbg_set_mes_debug_mode(pdd,
+							 !kfd_dbg_has_cwsr_workaround(pdd->dev));
 	}
 
 	kfd_dbg_set_workaround(target, false);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 76359c6a3f3a..dbcb64501cfa 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1891,9 +1891,11 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	}
 
 	if (!dqm->dev->kfd->shared_resources.enable_mes)
-		unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0, USE_DEFAULT_GRACE_PERIOD, false);
+		(void)unmap_queues_cpsch(dqm,
+					 KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES,
+					 0, USE_DEFAULT_GRACE_PERIOD, false);
 	else
-		remove_all_kfd_queues_mes(dqm);
+		(void)remove_all_kfd_queues_mes(dqm);
 
 	dqm->sched_running = false;
 
-- 
2.43.0

