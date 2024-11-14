Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F17CDD637CF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 01:43:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9675610E027;
	Thu, 14 Nov 2024 01:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nQ4YLKaq";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCD3E10E027
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 01:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLC5mo7xEe0yAt/6yj71Jym46O0qzaSKNvkHYXQdScURauM7aGUxR+Wh4bzPefMIL5lz0+egzOUEfuxPbqVch9QfE/feD0oIDIfWwvT1fnNhPJ8K27YYmsUg7vrGFrQdDgZumzc3PNitTh/VjH0m0/F6JxmoCgrHBL42c4Qmago26Z4u8YRNyrsr9rg+AqOc2ofJdgTqtasOtGlkXina6moh1/+ne/wmo9n8rMrmST7FIrd+osGlpUi0JVID08B0Sy2AEKg5/3g2YCAU2z91CMVEwlT1dje+XS3R96pH3zDuv6jpIQspWj3ZU2SSaOKq1/J4z8NFXPpfOaadH4l0Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBmQ7oWJld4fM9RWJTFbJX+pcu3VAnPkdK7NKePOMXo=;
 b=gK43sJmfvESa3XDfGbwTTs5IIb6LJQK9cnsKpq6wJ5x8GAz8RChQZ0KEhkk/Ld33ELuDsDxZZ6Z9KDA2vjOSpyDhmCa8+30vURqCeyMPc8szHQxcoqcWSlmZeGJnyJ3MOKlKi/bIWjWxas6EveJ8Zi09zRD/T+SNf0G0TYVAsFt/VNMxiFjo6DAGroqJ0dwhUL86Lro3yEOAMyALHxWXkh0R+pvRW2aTKJqptzafvmVUMw2YKqzo6uTi8pzwd1nQLLuCa/WYMhvFCMb4k0vZvxdFq4kPmPMuzv/z97cMwnEs41OyQQ85D5yYOIpxpzT/MrTHlAtl+W7DFk/l698sog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBmQ7oWJld4fM9RWJTFbJX+pcu3VAnPkdK7NKePOMXo=;
 b=nQ4YLKaqIHzn82SA7XBCsYWjgmbEUETqmevoKCAcYBjmgN79PShxHQ7OJnvB017oWcurAr30entgMHRyj7rpKq5Ivyuvqdk36UdjOP8sqg1aBnyRuXfIzo7L1qzViTPpfYa8BC9t1yoPUB8qbq18+uYJAXjZbz23Jxss3gqQgLw=
Received: from BN0PR03CA0051.namprd03.prod.outlook.com (2603:10b6:408:e7::26)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Thu, 14 Nov
 2024 01:42:56 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::10) by BN0PR03CA0051.outlook.office365.com
 (2603:10b6:408:e7::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 01:42:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 01:42:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 19:42:54 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 19:42:53 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <--cc=christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: WIP fix usage slab after free
Date: Wed, 13 Nov 2024 20:42:43 -0500
Message-ID: <20241114014243.395493-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ddcc6d6-53d0-43a5-b01b-08dd044da953
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlVaV1pBWkZTaHlsVjIvT3NaSWRHRUFXRThzY1dTN0I4alFuKzlwQUlSNU5y?=
 =?utf-8?B?NGhPQTdmK3dPZjc1Ylg3OEh2TjBGOGp3N0luSTRBa0lCOXIwYlZ4cW9uWWli?=
 =?utf-8?B?djAyaW9UOGhrVVd4dXdDMC9mZ1ZmUmpGdGZ5QWZhMENiZ1E5c2w5STRneDdB?=
 =?utf-8?B?dEpUZitkTjYyNVNrdXQ2c3VMeUU1d0tKTVYrREJVZUIxQW9xR3I3MHltZzYy?=
 =?utf-8?B?UktOb01vbThZeTIxY3Q1TFhRajFwbXh2MFNKU2lHMWgvbmlSUmxJWkNFWjJI?=
 =?utf-8?B?WjhqVzVnWklUZ2FOQUJJQkFEL09NWHNnMnAzQUlYRU5MeW9ocDhaSGtJZlpX?=
 =?utf-8?B?SkNkeEdkKzNXbDlQSktIdHRsTnU2WEtNZzdabXVNMVZ2NFNIOXJNQVgwaEQ3?=
 =?utf-8?B?U2k3UlpvNGQ5RllGUE4zMHZzd3BLcU5qTWkzSFJwYkxnMGV0ZTFkc2w1a0R2?=
 =?utf-8?B?T2tTR3JJNUI5ODNpWDVnQ0w4d29sck9tdzNiekxkR0daYSsvTlR2Ly9tczVM?=
 =?utf-8?B?YkNwTFBzQUhtNWVXL0lxWmVDRlR0SzZvQS84T2VSL0tVWnFMeXg1VVk5VS8y?=
 =?utf-8?B?NVpoTzByUXJhcXo5NWY0RlRncVkwaXc5cUVjUlF1cXd6dGQrSW5tNUZTeFF6?=
 =?utf-8?B?SFZnbHU4ZnZ5R1VYejk0aFBaWFd0b0hlTUtsa1JhTXJZbWo0RkNManA5bVF0?=
 =?utf-8?B?eW02UWUxWG5uQ3hLbTJTNFFhVTdmemk3UzFxVHBkNVpVRHRtQVN1bmZ0Ykxl?=
 =?utf-8?B?M2ZuK0JiU3FZVTk5UHNCQkV3MXJTa3pia25tYTNHMjhqSlB4d051SWZCd2do?=
 =?utf-8?B?eHNJQkhBZlVBU0gwM1FkalhqNkNpOGlVR2Nab2lFbm9oMVJncE4vSXFKVkZG?=
 =?utf-8?B?WUcwSVI0ZjhFQ25tRVFNUW5PK1drUkh2NWFlamNlZk5ENkd3TmNZSU0vcGhz?=
 =?utf-8?B?ODJIYWY5dklNeU5LSkw2WkYxeG5lSkl1NlhTOHkvNExLSDVRR0MyUHVLNUxY?=
 =?utf-8?B?aEZUeGw3M0lURVVNZVRqOWhOeDZLM2dld1dlMCthWTRESjdOMlFPemp5dGEz?=
 =?utf-8?B?YS9YbUFWNEh1RnRGWmM2djQ1K1ZCUVR6ZmU4d1UwUDk5eXBCZS9HUHowODlW?=
 =?utf-8?B?NEFSSjlNamdKUWdDdm91Yk1oV2JMWURacDBUdFlabWpBUDBMNFJ5dU1rRm5G?=
 =?utf-8?B?eXFPR0pjd1R2Wnh6bHhzUGMrSDJyeE52cGRqREUzbUZ3UnB3cENIK1F6cndj?=
 =?utf-8?B?bkc0OVJ4SlRxNzd2OUZhRzMwdzhYTXN0enhmMUt3T0UrY2ZKcms1bzI4WEhF?=
 =?utf-8?B?eXgxVTlDb1hDTHhGcjFIK2Q0WVBJV2l2RFc4RjdiTVdjKzd6NGsrN0VwSjFP?=
 =?utf-8?B?MFEyVGJxRGpSb0pvUndsc0JmeWRyOWpVdHlTck42Rmc0LzE1a014R2JRcVdO?=
 =?utf-8?B?MHdndVV6bzFjRzJ2TVZzTVB1L0JpR2ZuZHRLWDQ5UDV0ZHRRWlVNUW1QSnBn?=
 =?utf-8?B?Z1FYSG1Ud2hzY0NkQyt6NE1CZmRtdTR4djgrMW5JbDZBekZ4L0pwWWRqVzVQ?=
 =?utf-8?B?d2ZscEVsNFNtYnBIbHR5SFlQeXdBUkRONGlOUDN3M1VpQmJzbXRXdUJYWEc4?=
 =?utf-8?B?cG9RNytqM3dRSVJ5aXVGeUNsak5RaGRYdndlMHZZbSsvMStEQTFQdlRWbU1i?=
 =?utf-8?B?RWtma0VLaThXcmpWYkhwb0krcVlWK01vS2VBTGc1cVFEWkREbERETVMxNEZl?=
 =?utf-8?B?Z3FZaUthM1V5N3RiemZzS0Mxc0l2TlQ5R3c0TEM2Q0EzRVRVZ2RSU3IvSm1P?=
 =?utf-8?B?NGNLS0xTNGcyajRaOG9kM2RhNnVPRUhlSVJCcm1YUnFvRG5hZExzRlEvZFVC?=
 =?utf-8?B?NENxazZMTkFsWVY0dTc5YmtOWndlYmNRMFhuUUtKZUVGbmc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 01:42:55.3805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ddcc6d6-53d0-43a5-b01b-08dd044da953
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

[  +0.000021] BUG: KASAN: slab-use-after-free in drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000027] Read of size 8 at addr ffff8881b8605f88 by task amd_pci_unplug/2147

[  +0.000023] CPU: 6 PID: 2147 Comm: amd_pci_unplug Not tainted 6.10.0+ #1
[  +0.000016] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
[  +0.000016] Call Trace:
[  +0.000008]  <TASK>
[  +0.000009]  dump_stack_lvl+0x76/0xa0
[  +0.000017]  print_report+0xce/0x5f0
[  +0.000017]  ? drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000019]  ? srso_return_thunk+0x5/0x5f
[  +0.000015]  ? kasan_complete_mode_report_info+0x72/0x200
[  +0.000016]  ? drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000019]  kasan_report+0xbe/0x110
[  +0.000015]  ? drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000023]  __asan_report_load8_noabort+0x14/0x30
[  +0.000014]  drm_sched_entity_flush+0x6cb/0x7a0 [gpu_sched]
[  +0.000020]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? __kasan_check_write+0x14/0x30
[  +0.000016]  ? __pfx_drm_sched_entity_flush+0x10/0x10 [gpu_sched]
[  +0.000020]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? __kasan_check_write+0x14/0x30
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? enable_work+0x124/0x220
[  +0.000015]  ? __pfx_enable_work+0x10/0x10
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? free_large_kmalloc+0x85/0xf0
[  +0.000016]  drm_sched_entity_destroy+0x18/0x30 [gpu_sched]
[  +0.000020]  amdgpu_vce_sw_fini+0x55/0x170 [amdgpu]
[  +0.000735]  ? __kasan_check_read+0x11/0x20
[  +0.000016]  vce_v4_0_sw_fini+0x80/0x110 [amdgpu]
[  +0.000726]  amdgpu_device_fini_sw+0x331/0xfc0 [amdgpu]
[  +0.000679]  ? mutex_unlock+0x80/0xe0
[  +0.000017]  ? __pfx_amdgpu_device_fini_sw+0x10/0x10 [amdgpu]
[  +0.000662]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? __kasan_check_write+0x14/0x30
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? mutex_unlock+0x80/0xe0
[  +0.000016]  amdgpu_driver_release_kms+0x16/0x80 [amdgpu]
[  +0.000663]  drm_minor_release+0xc9/0x140 [drm]
[  +0.000081]  drm_release+0x1fd/0x390 [drm]
[  +0.000082]  __fput+0x36c/0xad0
[  +0.000018]  __fput_sync+0x3c/0x50
[  +0.000014]  __x64_sys_close+0x7d/0xe0
[  +0.000014]  x64_sys_call+0x1bc6/0x2680
[  +0.000014]  do_syscall_64+0x70/0x130
[  +0.000014]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? irqentry_exit_to_user_mode+0x60/0x190
[  +0.000015]  ? srso_return_thunk+0x5/0x5f
[  +0.000014]  ? irqentry_exit+0x43/0x50
[  +0.000012]  ? srso_return_thunk+0x5/0x5f
[  +0.000013]  ? exc_page_fault+0x7c/0x110
[  +0.000015]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000014] RIP: 0033:0x7ffff7b14f67
[  +0.000013] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
[  +0.000026] RSP: 002b:00007fffffffe378 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  +0.000019] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffff7b14f67
[  +0.000014] RDX: 0000000000000000 RSI: 00007ffff7f6f47a RDI: 0000000000000003
[  +0.000014] RBP: 00007fffffffe3a0 R08: 0000555555569890 R09: 0000000000000000
[  +0.000014] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffffffe5c8
[  +0.000013] R13: 00005555555552a9 R14: 0000555555557d48 R15: 00007ffff7ffd040
[  +0.000020]  </TASK>

[  +0.000016] Allocated by task 383 on cpu 7 at 26.880319s:
[  +0.000014]  kasan_save_stack+0x28/0x60
[  +0.000008]  kasan_save_track+0x18/0x70
[  +0.000007]  kasan_save_alloc_info+0x38/0x60
[  +0.000007]  __kasan_kmalloc+0xc1/0xd0
[  +0.000007]  kmalloc_trace_noprof+0x180/0x380
[  +0.000007]  drm_sched_init+0x411/0xec0 [gpu_sched]
[  +0.000012]  amdgpu_device_init+0x695f/0xa610 [amdgpu]
[  +0.000658]  amdgpu_driver_load_kms+0x1a/0x120 [amdgpu]
[  +0.000662]  amdgpu_pci_probe+0x361/0xf30 [amdgpu]
[  +0.000651]  local_pci_probe+0xe7/0x1b0
[  +0.000009]  pci_device_probe+0x248/0x890
[  +0.000008]  really_probe+0x1fd/0x950
[  +0.000008]  __driver_probe_device+0x307/0x410
[  +0.000007]  driver_probe_device+0x4e/0x150
[  +0.000007]  __driver_attach+0x223/0x510
[  +0.000006]  bus_for_each_dev+0x102/0x1a0
[  +0.000007]  driver_attach+0x3d/0x60
[  +0.000006]  bus_add_driver+0x2ac/0x5f0
[  +0.000006]  driver_register+0x13d/0x490
[  +0.000008]  __pci_register_driver+0x1ee/0x2b0
[  +0.000007]  llc_sap_close+0xb0/0x160 [llc]
[  +0.000009]  do_one_initcall+0x9c/0x3e0
[  +0.000008]  do_init_module+0x241/0x760
[  +0.000008]  load_module+0x51ac/0x6c30
[  +0.000006]  __do_sys_init_module+0x234/0x270
[  +0.000007]  __x64_sys_init_module+0x73/0xc0
[  +0.000006]  x64_sys_call+0xe3/0x2680
[  +0.000006]  do_syscall_64+0x70/0x130
[  +0.000007]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000015] Freed by task 2147 on cpu 6 at 160.507651s:
[  +0.000013]  kasan_save_stack+0x28/0x60
[  +0.000007]  kasan_save_track+0x18/0x70
[  +0.000007]  kasan_save_free_info+0x3b/0x60
[  +0.000007]  poison_slab_object+0x115/0x1c0
[  +0.000007]  __kasan_slab_free+0x34/0x60
[  +0.000007]  kfree+0xfa/0x2f0
[  +0.000007]  drm_sched_fini+0x19d/0x410 [gpu_sched]
[  +0.000012]  amdgpu_fence_driver_sw_fini+0xc4/0x2f0 [amdgpu]
[  +0.000662]  amdgpu_device_fini_sw+0x77/0xfc0 [amdgpu]
[  +0.000653]  amdgpu_driver_release_kms+0x16/0x80 [amdgpu]
[  +0.000655]  drm_minor_release+0xc9/0x140 [drm]
[  +0.000071]  drm_release+0x1fd/0x390 [drm]
[  +0.000071]  __fput+0x36c/0xad0
[  +0.000008]  __fput_sync+0x3c/0x50
[  +0.000007]  __x64_sys_close+0x7d/0xe0
[  +0.000007]  x64_sys_call+0x1bc6/0x2680
[  +0.000007]  do_syscall_64+0x70/0x130
[  +0.000007]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000014] The buggy address belongs to the object at ffff8881b8605f80
               which belongs to the cache kmalloc-64 of size 64
[  +0.000020] The buggy address is located 8 bytes inside of
               freed 64-byte region [ffff8881b8605f80, ffff8881b8605fc0)

[  +0.000028] The buggy address belongs to the physical page:
[  +0.000011] page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1b8605
[  +0.000008] anon flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[  +0.000007] page_type: 0xffffefff(slab)
[  +0.000009] raw: 0017ffffc0000000 ffff8881000428c0 0000000000000000 dead000000000001
[  +0.000006] raw: 0000000000000000 0000000000200020 00000001ffffefff 0000000000000000
[  +0.000006] page dumped because: kasan: bad access detected

[  +0.000012] Memory state around the buggy address:
[  +0.000011]  ffff8881b8605e80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[  +0.000015]  ffff8881b8605f00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
[  +0.000015] >ffff8881b8605f80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
[  +0.000013]                       ^
[  +0.000011]  ffff8881b8606000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
[  +0.000014]  ffff8881b8606080: fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb
[  +0.000013] ==================================================================

The issue reproduced on VG20 during the IGT pci_unplug test.
The root cause of the issue is that the function drm_sched_fini is called before drm_sched_entity_kill.
In drm_sched_fini, the drm_sched_rq structure is freed, but this structure is later accessed by
each entity within the run queue, leading to invalid memory access.
To resolve this, the order of cleanup calls is updated:

    Before:
        amdgpu_fence_driver_sw_fini
        amdgpu_device_ip_fini

    After:
        amdgpu_device_ip_fini
        amdgpu_fence_driver_sw_fini

This updated order ensures that all entities in the IPs are cleaned up first, followed by proper
cleanup of the schedulers.

Additional Investigation:

During debugging, another issue was identified in the amdgpu_vce_sw_fini function. The vce.vcpu_bo
buffer must be freed only as the final step in the cleanup process to prevent any premature
access during earlier cleanup stages.

v2: Using Christian suggestion call drm_sched_entity_destroy before drm_sched_fini.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: Icaf4adbf0b581c7194e5ec5d44b10833753f98d5
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b3ca911e55d6..dccd13277982 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4698,8 +4698,8 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	int idx;
 	bool px;
 
-	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_device_ip_fini(adev);
+	amdgpu_fence_driver_sw_fini(adev);
 	amdgpu_ucode_release(&adev->firmware.gpu_info_fw);
 	adev->accel_working = false;
 	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index a061fb8a2fcf..6a0dcafcb740 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -214,15 +214,15 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
 
 	drm_sched_entity_destroy(&adev->vce.entity);
 
-	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
-		(void **)&adev->vce.cpu_addr);
-
 	for (i = 0; i < adev->vce.num_rings; i++)
 		amdgpu_ring_fini(&adev->vce.ring[i]);
 
 	amdgpu_ucode_release(&adev->vce.fw);
 	mutex_destroy(&adev->vce.idle_mutex);
 
+	amdgpu_bo_free_kernel(&adev->vce.vcpu_bo, &adev->vce.gpu_addr,
+		(void **)&adev->vce.cpu_addr);
+
 	return 0;
 }
 
-- 
2.25.1

