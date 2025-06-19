Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF50C71157
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 01:32:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9F1410E4F5;
	Thu, 19 Jun 2025 01:32:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tTJQkVDK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E1E410E4F5
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 01:32:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dnjBXsYYoLbKjNUB5QXj8xJjS1BT2G6euYPap54EiAblu4syEBxLBMJha9iLq30lKbQs9yp2C43R6KS5VmyJc2I+f20vrcdwVvMkag+ZbiMLdLgNeIJeGOB9IRm3a6/EIKntesAlQnxzLj+u+8nvhaDx1DM8bvQJZ38ctqCJZcRZEIApB2/bquK2W2QiPOT0DXBRzEIrwXAfpfy/aGSGmi2gZpABPu9sy7bFJQ+7byTUhvK4k0wig2i/z7bjjX/BvChfOjasdKc2yjz0DLQzf4e9rDTlNkQR43aYqEKaNmjFH659evwVZnMMI9xyGlDDSKcicl/2UQwv7T30jixFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o94D7r2LN380hfbwQ8F14093nlHV61JVsZ16dIjXoQA=;
 b=TKlt7fz4sK5X5IpiWRgCPqqH8ow8WD2ogn1lpSxZ1481yYKOibfSaXA736Hmae63NTZS7StKAYTIPSbfi8lQ+v39Uq7FK34kYLb5BDonlq8aGyxFZJcNdg3P5RD5cTlyp7wOYYvuHXxm84EE1UdfJMh11WUgwknvj9bdymcJUtRA2yNQznACXt9lUiX6Jd5Mum59C5/gXrRdBE4cuyrazaXmsUU1+0oj2m8uh63vCngtpdWINypKBnXhySUJQSll3OrdzDnbAC6x9dBnZ229EXLHcHEwBKZoA0DAo8u0CsuHQuTCuI3jF26Ixenxa+ja+yv4+R7jCAN0Zz3UNrWigA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o94D7r2LN380hfbwQ8F14093nlHV61JVsZ16dIjXoQA=;
 b=tTJQkVDKPtTCaeQUOMvJ3WhdvwybZ82yc/8Eh4qmmhVF+BL+5TgURCWqOd/86mEh4wpWEPpiPRXcvwwqhsUEVJl170OY5HI9XqfjgzAZwX5cbRIAL8HTLgoJ2es5fa+FQd6crvv7hdWA5CE1WqUKMoxKMOleXMMrXqChPV+/O0Q=
Received: from DM6PR03CA0003.namprd03.prod.outlook.com (2603:10b6:5:40::16) by
 SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 01:32:28 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:5:40:cafe::bb) by DM6PR03CA0003.outlook.office365.com
 (2603:10b6:5:40::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Thu,
 19 Jun 2025 01:32:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.0 via Frontend Transport; Thu, 19 Jun 2025 01:32:27 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 20:32:27 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 20:32:26 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c
Date: Wed, 18 Jun 2025 21:32:06 -0400
Message-ID: <20250619013206.123183-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 6251711e-ca2a-43cb-634c-08ddaed1269a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bisrWmdza0txdkkyVXJMNlZVSmtIWHYvKzNTdjRLcXY2anF6aXA5ZkFrazh2?=
 =?utf-8?B?dFY1MWU0a1BFS1V0bmExRlE0a0ZPWGpuajlUbVJneG9YbDJYSzM1K2I2bHln?=
 =?utf-8?B?NlZ1UHRQMjI0NXdkU2F6SjRHcWVHNzBJTGdDMHZnZUozUUdXK2YwNVZBb1JD?=
 =?utf-8?B?VWVIRmZoSGhuVTVQUkE5NFZGTEtNQnVub3djdnYvdjRJdTJoemVOSUdGUjhB?=
 =?utf-8?B?QmxQV2RkbFBIY25GSWRCMjNUNTQvakovL1NyYjVVaXhlRTdCTEpNVnpHVUY0?=
 =?utf-8?B?bkFNdTlwZ0VKcEQwcTVVRzRVc0FjcDlBRlEydGdFOTFHMVR1bitjNlFDY1Nw?=
 =?utf-8?B?V2JQeE9ZVGxWcjNsd0tqMzI3eGcvVVdjcDU2OXFEZ2dZSEl6YlcwaG5kVlFB?=
 =?utf-8?B?LzQzRHR6VlVyWWpCUXg1NGdqUzJYVXVkN2tMU0hUYThVT1BNSmY0M05YSkM4?=
 =?utf-8?B?M1c4eGg2SjdJK05uQU5pY3BNemI5dmlFOWlJV1ZrdWZGYzRFU3ViT25xdmly?=
 =?utf-8?B?dHplUkxXT2cvWFdFR1FnMVk1VmM4T2NUVHM2RkZUSzZCOWNsaWRXV3RrekUr?=
 =?utf-8?B?aDhnWEY0bE40elgwaEs1RFZLSWNFdUp6QTNwSkFCMytmMWhLN1FJRVJNTnow?=
 =?utf-8?B?c1E5cUhBZTViVk5hTmQwTVd0WnlDK3Vua0NDTHdDWEhjK1Q4TkQ0eEg3SkM3?=
 =?utf-8?B?cTRweE1aanQ5QVNscmlpSWdHcTlteVNIdEFjd3RONFcxNnBtZXBHZWRDc3Bh?=
 =?utf-8?B?ZnZOaERPZU5MTzgwT3hPelBRZXltRlZ4a0Q4MWRVbHNjOUN4K0tZd3p1MXNz?=
 =?utf-8?B?Y0lScVh2RitIYzFPLzBYSnRRTXF5UjY3SktyY2JMZ0FIT1oySmN3SXBNaEd4?=
 =?utf-8?B?b1hJUDNxU0Nrb1dMdFNlQjJEN3NRUURSMXVORTUzaDlxUE50TEZ2Wlg5M3Jt?=
 =?utf-8?B?NXozWkNaVDVOOGFqNCtCd0hFMkM2NkJZYzAvcmwvcEFpSENPUmhPWmdxZG4y?=
 =?utf-8?B?Z0FubzFib3NnQUwwRzN0THVGU3VmVW94QldJYUt3RDQ2R1BmSDZNS0hnUmFV?=
 =?utf-8?B?QTVuQ21QUC9LQTJYTmYrVHc0SUJNQjBaT21ZU0VadlJPaUJvbDNpbmxnL0o4?=
 =?utf-8?B?S2pycVQ1elJQQmVYQmZUOUh3U2lxeFlTZDcrWWJmWlZsYTBiWEZsVkZYcWU3?=
 =?utf-8?B?akZpd0RpakwzaXphWERUS3VpTDRGdUxqNC8zL0t3cy9MYVkzZUlkeCtzUGZi?=
 =?utf-8?B?QzIwb3lRUkRkOFZ3OWFSOVY5aG5WSFlTT0YxN2x2em9adm5pK2xvbG1hRlda?=
 =?utf-8?B?WDh3WWtiZVJnc2s2TWorYTZmamFZNXU3Q0RTeVZXQytpOU5QOUNKSHJDYnE1?=
 =?utf-8?B?NGhBc2NDZU5SVE5QeHluWjAvUEVtSjAwcjFYeFQvY2w2WDl4WnpYQ2FOWjdY?=
 =?utf-8?B?OWtuV0FkR1RXb0ZFWDdGem90a3pzWWtScXJneFRNUnVFUnQ1Um4rZzRGZEpF?=
 =?utf-8?B?U2dFUEtSRWZ0UmxuejRETWJwcktaRVZORWVrTDg5TmkxeTFQQTJseWZwZTFS?=
 =?utf-8?B?NytqcHMyTkt2dVE2K2FwSTI5SXdHZnp0a093Q3VmYXQ0YkhjMFdDaW9OSklJ?=
 =?utf-8?B?Mk9NVkNvVXZTWWhWT1ZaeHBkQUN0K0gyZEk2SVZWN1drNTUydGo0Qm5mUEZE?=
 =?utf-8?B?c3ZhaS92dmwyZHV4NmtxY0VFTXFFREZKSzJHdnBBSUtTMk93R2s1ckhDMS9N?=
 =?utf-8?B?bTU3WjNlb3MzbXdaZ0dJRm5sVVVadElWYkt0eldTWUxHVzZJUUd4TkxkNXFy?=
 =?utf-8?B?dlJtSHplRkk5QlpaWHhFNC8rTU5LUmZMTDZxa00xY3h1bC92S05qU2ptS29R?=
 =?utf-8?B?T0xrSHpoMk1jeWk3WCtOdzdXcWNDak9XTnBsTlpsSHE1YXY1Zk5yVVlyaGJi?=
 =?utf-8?B?UXNjUnFEOXBzZmRVNHAzL1A0VEQ0SUw0WHJhWDJTV0FVRVhpT1lseXdidDlT?=
 =?utf-8?B?cWxXMXJ4M29lbWN1bUYzN243YnpObmtwYzYyMG1zd0MxMmhyLytDZXBBMnJU?=
 =?utf-8?Q?dtcU9v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 01:32:27.4978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6251711e-ca2a-43cb-634c-08ddaed1269a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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

The issue was reproduced on NV10 using IGT pci_unplug test.
It is expected that `amdgpu_driver_postclose_kms()` is called prior to `amdgpu_drm_release()`.
However, the bug is that `amdgpu_fpriv` was freed in `amdgpu_driver_postclose_kms()`, and then
later accessed in `amdgpu_drm_release()` via a call to `amdgpu_userq_mgr_fini()`.
As a result, KASAN detected a use-after-free condition, as shown in the log below.
The proposed fix is to move the calls to `amdgpu_eviction_fence_destroy()` and
`amdgpu_userq_mgr_fini()` into `amdgpu_driver_postclose_kms()`, so they are invoked before
`amdgpu_fpriv` is freed.

This also ensures symmetry with the initialization path in `amdgpu_driver_open_kms()`,
where the following components are initialized:
- `amdgpu_userq_mgr_init()`
- `amdgpu_eviction_fence_init()`
- `amdgpu_ctx_mgr_init()`

Correspondingly, in `amdgpu_driver_postclose_kms()` we should clean up using:
- `amdgpu_userq_mgr_fini()`
- `amdgpu_eviction_fence_destroy()`
- `amdgpu_ctx_mgr_fini()`

This change eliminates the use-after-free and improves consistency in resource management between open and close paths.

[  +0.094367] ==================================================================
[  +0.000026] BUG: KASAN: slab-use-after-free in amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
[  +0.000866] Write of size 8 at addr ffff88811c068c60 by task amd_pci_unplug/1737
[  +0.000026] CPU: 3 UID: 0 PID: 1737 Comm: amd_pci_unplug Not tainted 6.14.0+ #2
[  +0.000008] Hardware name: ASUS System Product Name/ROG STRIX B550-F GAMING (WI-FI), BIOS 1401 12/03/2020
[  +0.000004] Call Trace:
[  +0.000004]  <TASK>
[  +0.000003]  dump_stack_lvl+0x76/0xa0
[  +0.000010]  print_report+0xce/0x600
[  +0.000009]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
[  +0.000790]  ? srso_return_thunk+0x5/0x5f
[  +0.000007]  ? kasan_complete_mode_report_info+0x76/0x200
[  +0.000008]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
[  +0.000684]  kasan_report+0xbe/0x110
[  +0.000007]  ? amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
[  +0.000601]  __asan_report_store8_noabort+0x17/0x30
[  +0.000007]  amdgpu_userq_mgr_fini+0x70c/0x730 [amdgpu]
[  +0.000801]  ? __pfx_amdgpu_userq_mgr_fini+0x10/0x10 [amdgpu]
[  +0.000819]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  amdgpu_drm_release+0xa3/0xe0 [amdgpu]
[  +0.000604]  __fput+0x354/0xa90
[  +0.000010]  __fput_sync+0x59/0x80
[  +0.000005]  __x64_sys_close+0x7d/0xe0
[  +0.000006]  x64_sys_call+0x2505/0x26f0
[  +0.000006]  do_syscall_64+0x7c/0x170
[  +0.000004]  ? kasan_record_aux_stack+0xae/0xd0
[  +0.000005]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? kmem_cache_free+0x398/0x580
[  +0.000006]  ? __fput+0x543/0xa90
[  +0.000006]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? __fput+0x543/0xa90
[  +0.000004]  ? __kasan_check_read+0x11/0x20
[  +0.000007]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? __kasan_check_read+0x11/0x20
[  +0.000003]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? fpregs_assert_state_consistent+0x21/0xb0
[  +0.000006]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? syscall_exit_to_user_mode+0x4e/0x240
[  +0.000005]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? do_syscall_64+0x88/0x170
[  +0.000003]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? do_syscall_64+0x88/0x170
[  +0.000004]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? irqentry_exit+0x43/0x50
[  +0.000004]  ? srso_return_thunk+0x5/0x5f
[  +0.000004]  ? exc_page_fault+0x7c/0x110
[  +0.000006]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000005] RIP: 0033:0x7ffff7b14f67
[  +0.000005] Code: ff e8 0d 16 02 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 73 ba f7 ff
[  +0.000004] RSP: 002b:00007fffffffe358 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[  +0.000006] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ffff7b14f67
[  +0.000003] RDX: 0000000000000000 RSI: 00007ffff7f5755a RDI: 0000000000000003
[  +0.000003] RBP: 00007fffffffe380 R08: 0000555555568170 R09: 0000000000000000
[  +0.000003] R10: 0000000000000000 R11: 0000000000000246 R12: 00007fffffffe5c8
[  +0.000003] R13: 00005555555552a9 R14: 0000555555557d48 R15: 00007ffff7ffd040
[  +0.000007]  </TASK>

[  +0.000286] Allocated by task 425 on cpu 11 at 29.751192s:
[  +0.000013]  kasan_save_stack+0x28/0x60
[  +0.000008]  kasan_save_track+0x18/0x70
[  +0.000006]  kasan_save_alloc_info+0x38/0x60
[  +0.000006]  __kasan_kmalloc+0xc1/0xd0
[  +0.000005]  __kmalloc_cache_noprof+0x1bd/0x430
[  +0.000006]  amdgpu_driver_open_kms+0x172/0x760 [amdgpu]
[  +0.000521]  drm_file_alloc+0x569/0x9a0
[  +0.000008]  drm_client_init+0x1b7/0x410
[  +0.000007]  drm_fbdev_client_setup+0x174/0x470
[  +0.000007]  drm_client_setup+0x8a/0xf0
[  +0.000006]  amdgpu_pci_probe+0x50b/0x10d0 [amdgpu]
[  +0.000482]  local_pci_probe+0xe7/0x1b0
[  +0.000008]  pci_device_probe+0x5bf/0x890
[  +0.000005]  really_probe+0x1fd/0x950
[  +0.000007]  __driver_probe_device+0x307/0x410
[  +0.000005]  driver_probe_device+0x4e/0x150
[  +0.000006]  __driver_attach+0x223/0x510
[  +0.000005]  bus_for_each_dev+0x102/0x1a0
[  +0.000006]  driver_attach+0x3d/0x60
[  +0.000005]  bus_add_driver+0x309/0x650
[  +0.000005]  driver_register+0x13d/0x490
[  +0.000006]  __pci_register_driver+0x1ee/0x2b0
[  +0.000006]  xfrm_ealg_get_byidx+0x43/0x50 [xfrm_algo]
[  +0.000008]  do_one_initcall+0x9c/0x3e0
[  +0.000007]  do_init_module+0x29e/0x7f0
[  +0.000006]  load_module+0x5c75/0x7c80
[  +0.000006]  init_module_from_file+0x106/0x180
[  +0.000007]  idempotent_init_module+0x377/0x740
[  +0.000006]  __x64_sys_finit_module+0xd7/0x180
[  +0.000006]  x64_sys_call+0x1f0b/0x26f0
[  +0.000006]  do_syscall_64+0x7c/0x170
[  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000013] Freed by task 1737 on cpu 9 at 76.455063s:
[  +0.000010]  kasan_save_stack+0x28/0x60
[  +0.000006]  kasan_save_track+0x18/0x70
[  +0.000005]  kasan_save_free_info+0x3b/0x60
[  +0.000006]  __kasan_slab_free+0x54/0x80
[  +0.000005]  kfree+0x127/0x470
[  +0.000006]  amdgpu_driver_postclose_kms+0x455/0x760 [amdgpu]
[  +0.000485]  drm_file_free.part.0+0x5b1/0xba0
[  +0.000007]  drm_file_free+0x13/0x30
[  +0.000006]  drm_client_release+0x1c4/0x2b0
[  +0.000006]  drm_fbdev_ttm_fb_destroy+0xd2/0x120 [drm_ttm_helper]
[  +0.000007]  put_fb_info+0x97/0xe0
[  +0.000006]  unregister_framebuffer+0x197/0x380
[  +0.000005]  drm_fb_helper_unregister_info+0x94/0x100
[  +0.000005]  drm_fbdev_client_unregister+0x3c/0x80
[  +0.000007]  drm_client_dev_unregister+0x144/0x330
[  +0.000006]  drm_dev_unregister+0x49/0x1b0
[  +0.000006]  drm_dev_unplug+0x4c/0xd0
[  +0.000006]  amdgpu_pci_remove+0x58/0x130 [amdgpu]
[  +0.000482]  pci_device_remove+0xae/0x1e0
[  +0.000006]  device_remove+0xc7/0x180
[  +0.000006]  device_release_driver_internal+0x3d4/0x5a0
[  +0.000007]  device_release_driver+0x12/0x20
[  +0.000006]  pci_stop_bus_device+0x104/0x150
[  +0.000006]  pci_stop_and_remove_bus_device_locked+0x1b/0x40
[  +0.000005]  remove_store+0xd7/0xf0
[  +0.000007]  dev_attr_store+0x3f/0x80
[  +0.000006]  sysfs_kf_write+0x125/0x1d0
[  +0.000005]  kernfs_fop_write_iter+0x2ea/0x490
[  +0.000007]  vfs_write+0x90d/0xe70
[  +0.000006]  ksys_write+0x119/0x220
[  +0.000006]  __x64_sys_write+0x72/0xc0
[  +0.000006]  x64_sys_call+0x18ab/0x26f0
[  +0.000005]  do_syscall_64+0x7c/0x170
[  +0.000005]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

[  +0.000013] The buggy address belongs to the object at ffff88811c068000
               which belongs to the cache kmalloc-rnd-01-4k of size 4096
[  +0.000016] The buggy address is located 3168 bytes inside of
               freed 4096-byte region [ffff88811c068000, ffff88811c069000)

[  +0.000022] The buggy address belongs to the physical page:
[  +0.000010] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88811c06e000 pfn:0x11c068
[  +0.000006] head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[  +0.000006] flags: 0x17ffffc0000040(head|node=0|zone=2|lastcpupid=0x1fffff)
[  +0.000007] page_type: f5(slab)
[  +0.000007] raw: 0017ffffc0000040 ffff88810004c140 dead000000000122 0000000000000000
[  +0.000005] raw: ffff88811c06e000 0000000080040002 00000000f5000000 0000000000000000
[  +0.000006] head: 0017ffffc0000040 ffff88810004c140 dead000000000122 0000000000000000
[  +0.000005] head: ffff88811c06e000 0000000080040002 00000000f5000000 0000000000000000
[  +0.000006] head: 0017ffffc0000003 ffffea0004701a01 ffffffffffffffff 0000000000000000
[  +0.000005] head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
[  +0.000004] page dumped because: kasan: bad access detected

[  +0.000011] Memory state around the buggy address:
[  +0.000009]  ffff88811c068b00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000012]  ffff88811c068b80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000011] >ffff88811c068c00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000011]                                                        ^
[  +0.000010]  ffff88811c068c80: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000011]  ffff88811c068d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[  +0.000011] ==================================================================

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Lijo Lazar <lijo.lazar@amd.com>
Cc: Jesse Zhang <Jesse.Zhang@amd.com>
Cc: Arvind Yadav <arvind.yadav@amd.com>

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 12 +++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +++
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7fd233f160bf..204178d949e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2914,16 +2914,10 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 
 static int amdgpu_drm_release(struct inode *inode, struct file *filp)
 {
-	struct drm_file *file_priv = filp->private_data;
-	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
-
-	if (fpriv) {
-		fpriv->evf_mgr.fd_closing = true;
-		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
-		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
-	}
+	int r;
 
-	return drm_release(inode, filp);
+	r = drm_release(inode, filp);
+	return r;
 }
 
 long amdgpu_drm_ioctl(struct file *filp,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index d2ce7d86dbc8..195ed81d39ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1501,6 +1501,9 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 		amdgpu_vm_bo_del(adev, fpriv->prt_va);
 		amdgpu_bo_unreserve(pd);
 	}
+	fpriv->evf_mgr.fd_closing = true;
+	amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
+	amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
 
 	amdgpu_ctx_mgr_fini(&fpriv->ctx_mgr);
 	amdgpu_vm_fini(adev, &fpriv->vm);
-- 
2.34.1

