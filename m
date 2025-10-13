Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC809CCA476
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 06:23:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508B310E3C5;
	Mon, 13 Oct 2025 06:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UFVdldkW";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010023.outbound.protection.outlook.com [52.101.56.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED3F910E3C5
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 06:23:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjBUYhR+VY/JTlwSqFYv9X1tIjI3y7hLUffPQp5AubmlkgDgHXoUUUh4fLlfQDyzHx8v9rAEdqhz5VNoV03KVww5cz0nvRXgiQaqlLHAGGXiZImW+EEWLk6TC1zb6yW/0Gb3pLsvPpUcdyPdShk84MBNpEE8tqqadqXk/BDSPCFmnQVCCYob9sreH/lGLm59hAm7u77HwFNJbQ/OOJh1DFkbhc6GwQ01fdVnsLDB7lTZiJxaqgsXbslHDthv1EirLobseh0Y8bkLMRCprsFAKCI6kU8JP/2/AjcUq160hRKaWjnzNJQqYn8KmC7PyXeVS+vgRgAjjdNpsRunaXHtOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5KXa7H+prjETHdqLmQAws8O30L36QkGtZj4TSd5nVg=;
 b=fw6mEw5vPr5JBx9LN96QkDdOA/e6Kz58YT5BxhjKWe6hsUve921Xe5a1hUa5XXINZe0OEDgRQ+TjtczP8PFXELHqHJYfZTKcUYBp4J/dIYq8hbJ3c/H4w7Ny72VfFZEiqpc9UkfNKLsA0ZLr9lqpMRwPdWnWelPhogmnGohe0BxCmlk59C+O+BRKc84yP9DLd0nsgTDGKBKxv52yg4DMKip7d3KZgkUIaXTRt+CMA0TswJtboNgW9ypW/WfvA0FpN8eEtLv2avUNAVrW0NoZdbMYT3kIg/QocxE/M1kxyG4yUcVutPMjJHTkob6kkcIGB42W7rM228uxyDkBO0RAoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5KXa7H+prjETHdqLmQAws8O30L36QkGtZj4TSd5nVg=;
 b=UFVdldkWFrrv2C4gFUdAyKbVBpfpQcg8f6EtfQboZp0wABRyUo4q7lddSS7nuk8zAsqtsZPZCk5jOlCRonu/DR6S+269f+IhATwBcF9HNNsdppLfaY3o5bNfoqXbQ1wI6ADOuUKCWtOVK579u+13HcG9z3o8X0E3PA+9AIRK+r8=
Received: from DM6PR21CA0021.namprd21.prod.outlook.com (2603:10b6:5:174::31)
 by CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 06:23:46 +0000
Received: from DS3PEPF0000C37E.namprd04.prod.outlook.com
 (2603:10b6:5:174:cafe::6c) by DM6PR21CA0021.outlook.office365.com
 (2603:10b6:5:174::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.1 via Frontend Transport; Mon,
 13 Oct 2025 06:23:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37E.mail.protection.outlook.com (10.167.23.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Mon, 13 Oct 2025 06:23:46 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sun, 12 Oct
 2025 23:23:45 -0700
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Sun, 12 Oct 2025 23:23:44 -0700
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH V3] drm/amdgpu: Fix NULL pointer dereference in VRAM logic for
 APU devices
Date: Mon, 13 Oct 2025 14:21:43 +0800
Message-ID: <20251013062343.1550737-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37E:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7058d759-db03-4869-78ae-08de0a2110c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVNiRVlxM04rRXBTaGV3VlRuN0Zuc2Z5T0o2UytFelNPSVdvTUx0WjFhQ2ZY?=
 =?utf-8?B?K1o2ZU5aTXc4d05va1A2NVNFSG12bXZ1TXJTWnF0YWtiWnRqTWlydjdyTk9N?=
 =?utf-8?B?VkhXRGc2ZHBNc1FBN1Y1Mzl6L0M2L1Y5Rk5sdy8xU25BeUNpUGZJUUt1R2ZU?=
 =?utf-8?B?QjdaU1VBRnJtckdIOXBpUTRTWXhJRGdFMjYxVzZISStKbjhHOVFHYmRFVkJR?=
 =?utf-8?B?d2FWUzIvVzdSRk81Si9WbnhaU1dzd2NxeXV5eWhGdzAzeHZPQmU4Q2FRaVh0?=
 =?utf-8?B?OXhxOFMvbDdmNjV4Q000WGFKNzJYeDRic2ovN1FGRXVvVDBVTTJMcFpMU2dQ?=
 =?utf-8?B?TU1JRzFwNVNoTzFldE9GNmU1bERSeXFDSU45bFhRbU9ObEQyWjBGREJKeU5D?=
 =?utf-8?B?SzJjdnNKOXM3Ym1VcGRzd2JpYkkySkZ1WDFnSVI2ZUhUYWJvemdhZVV3THp6?=
 =?utf-8?B?VkdJMUx5dUhQUnlzclJ4bnhaK21ybFJaeWxUc3piSk5TeFQ5RnBTUzR1bUp5?=
 =?utf-8?B?UUZSay9QV1diSjZZNTdXU0FITjZIK2NWcXZBR2MrUHByTEtFQ1hGMHhJTG8r?=
 =?utf-8?B?YXVvaUJLSHFBVmVxVTR0bVV6TXZ5MFBSSkVuR1ZHaG94OUFuM2RGSkVSMWdS?=
 =?utf-8?B?NEFibTZ3NlhyNldpdTlUMlNNNjdURU5JMTBBUnR5akVrN3Y4dmZNNEROUXJ0?=
 =?utf-8?B?MFBaRlFndGM1ZU9PWnhxeUVJL3VRV05LTzlCZ2VCYVNyS2JtRU9IZUFpNkox?=
 =?utf-8?B?QVg3clN4SnB0VG5vc0RHL0VpYlpKWHlKMks0anhvU1c3QlVwYngzWU9vSTNy?=
 =?utf-8?B?Q2hTTERlSnltaUt3ZUNYcjJtc2xENGxlZzFLNiswQVBTUFVMMGs4VXlsTEpM?=
 =?utf-8?B?V0lxQVdRdUZ4cThtUkdvRWppd2tLTnBnYjlUREhvZWpQMC92NDV5RzdSeTV3?=
 =?utf-8?B?ZVFaM3Z4cmpISmZ5cHRXMytGbXc1bDBxNnk0OG5QTjA2NlZpWVVUOFhqOEth?=
 =?utf-8?B?emZHWmJGR0poUzAxWmZ2U1V5Z2VUT1ZRemsyckpvNGZBZW4wYnFTSHdQT3Nw?=
 =?utf-8?B?U1FwZXpxdnBiVkZhYzZYd2Jrb1k1QnBFK1dpN0hielgxT3lLdkU5aW1vN2Uy?=
 =?utf-8?B?Ui9UeFBhOENjRzhZMkQrdmJLcVFuUzd4MEZPbGRSMUJZemZ1ZElHcmJEanF0?=
 =?utf-8?B?OVRLZGEvSjdFSllnL1h0amNmdlYyVW95WEtCWEJxUktpZmlaY2lxL2loZTJw?=
 =?utf-8?B?S3lReDg0QzY3Sk9NL2N0LzJNZjZFYTdranBCN3dUQnhLQ0JwcThiWTdPTFA4?=
 =?utf-8?B?VFdMdkdOMjRibUlYTng5dnVteGx4Y21sU25CUzZWMklxb29IRHFETDhQR0Jw?=
 =?utf-8?B?QWVCVVdxaHVwR2xHakh2b3d0cSsvakVRSDlUSlByMzNrcGFyUVBzOXYxWHNF?=
 =?utf-8?B?ZlA1WFI3Q3hKa3daN0FZRHpUZWJxcEV2cUM3NHp1TU5kTCtXd2NPWGN3V0I0?=
 =?utf-8?B?RmFyWTBESVIrNEdMbkNsZTJUY0x2OFY5TnBkb0xtRmNHek00KzJOTmlhZHRB?=
 =?utf-8?B?RVVHQmFhR3EwckQ3dHN2NndPK2QrNlRMenF2cE15YVU2OTRidW9FeW1TQTVk?=
 =?utf-8?B?RTVkdmg5ZDRFYUFwT0xIaWp2VG95d2FxWVZhM1NMVktnYWYvc3lpLytRNHJD?=
 =?utf-8?B?YjlkZmZ2VUNYTHBtSWpKaXFXU1pJSGdWdGxHRmx4WTlRUGl2YXZFWkVKRFc0?=
 =?utf-8?B?bVZHcXN6MERhM0Z6bHgxeHNPbGNwTEhDNCtLVk9zVm03dkdGd21nNjc4bU5S?=
 =?utf-8?B?bFh0UWV6c1VKcFVXcE1qUlFUTUdpQlljOEJpTzRTeEVMNVhod3Y1b3RNZS94?=
 =?utf-8?B?V21IRC9zaXhzd3MrWG9pMVVON2ZlcWxiYW1LeXlRUkI2WXNXemJENGFkQWNF?=
 =?utf-8?B?R0d4SGxLMTVEaXZnbjVDZ09DMkhJaEJES2dUMWpvS09MQTlVaWVNWVFEYzZx?=
 =?utf-8?B?ZmRzcDF5akNGQVF0eDlhaXVRNVN3dy9aSW9iQTdHTUVFT00rZUNkUEFqL0xQ?=
 =?utf-8?B?amZIK1ZmaU5PaktQTWhvc29qUzFhS0hLZVpGNUJPUE50T2EzUVBtRHNjRmVy?=
 =?utf-8?Q?TpUU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 06:23:46.4028 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7058d759-db03-4869-78ae-08de0a2110c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840
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

APU platforms (identified by `adev->gmc.is_app_apu`) do not initialize dedicated
VRAM management structures (`adev->mman.vram_mgr.manager`) because they rely on
system memory instead of discrete VRAM. Accessing this uninitialized structure
via `ttm_resource_manager_usage()` triggers a NULL pointer dereference (typically
in `_raw_spin_lock()` when trying to acquire the manager's lock), leading to
kernel OOPS—especially when tools like rocm-smi query VRAM usage or during
power/VM operations.

Fix this by adding explicit APU checks in all code paths that access VRAM
manager structures:

1. **amdgpu_cs.c**: Extend the existing bandwidth control check in
   `amdgpu_cs_get_threshold_for_moves()` to include APU devices. Return 0 for
   migration thresholds immediately, skipping VRAM-specific logic that would
   access uninitialized data.

2. **amdgpu_kms.c**: Modify the `AMDGPU_INFO_VRAM_USAGE` ioctl and memory info
   reporting to return 0 for VRAM usage on APUs. This avoids calling
   `ttm_resource_manager_usage()` with an invalid manager pointer.

3. **amdgpu_virt.c**: Skip VRAM usage calculation for APUs when writing vf2pf
   (virtual function to physical function) data. Use 0 for `fb_usage` since APUs
   have no discrete framebuffer memory to report.

These changes ensure APUs never access uninitialized VRAM manager structures,
resolving the NULL dereference while preserving correct behavior for discrete
GPUs (which retain full VRAM usage tracking).

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c  | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5f515fdcc775..d80414b32015 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -709,7 +709,7 @@ static void amdgpu_cs_get_threshold_for_moves(struct amdgpu_device *adev,
 	 */
 	const s64 us_upper_bound = 200000;
 
-	if (!adev->mm_stats.log2_max_MBps) {
+	if ((!adev->mm_stats.log2_max_MBps) || adev->gmc.is_app_apu) {
 		*max_bytes = 0;
 		*max_vis_bytes = 0;
 		return;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index a9327472c651..e6bf9f6a2713 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -758,7 +758,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		ui64 = atomic64_read(&adev->num_vram_cpu_page_faults);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VRAM_USAGE:
-		ui64 = ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);
+		ui64 = adev->gmc.is_app_apu ? 0 : ttm_resource_manager_usage(&adev->mman.vram_mgr.manager);
 		return copy_to_user(out, &ui64, min(size, 8u)) ? -EFAULT : 0;
 	case AMDGPU_INFO_VIS_VRAM_USAGE:
 		ui64 = amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr);
@@ -805,7 +805,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			atomic64_read(&adev->vram_pin_size) -
 			AMDGPU_VM_RESERVED_VRAM;
 		mem.vram.heap_usage =
-			ttm_resource_manager_usage(vram_man);
+			adev->gmc.is_app_apu ? 0 : ttm_resource_manager_usage(vram_man);
 		mem.vram.max_allocation = mem.vram.usable_heap_size * 3 / 4;
 
 		mem.cpu_accessible_vram.total_heap_size =
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 3328ab63376b..5ff856bef199 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -599,7 +599,7 @@ static int amdgpu_virt_write_vf2pf_data(struct amdgpu_device *adev)
 	vf2pf_info->os_info.all = 0;
 
 	vf2pf_info->fb_usage =
-		ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20;
+		adev->gmc.is_app_apu ? 0 : ttm_resource_manager_usage(&adev->mman.vram_mgr.manager) >> 20;
 	vf2pf_info->fb_vis_usage =
 		amdgpu_vram_mgr_vis_usage(&adev->mman.vram_mgr) >> 20;
 	vf2pf_info->fb_size = adev->gmc.real_vram_size >> 20;
-- 
2.49.0

