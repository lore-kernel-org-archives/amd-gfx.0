Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9310C71136
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jun 2025 03:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B10B10E009;
	Thu, 19 Jun 2025 03:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4sITWcet";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1496210E009
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jun 2025 03:58:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zc0aiaK6DtFsGGhxCUTeiqrr6HpDAnuVAYp0dywtybUx0/AFK8AYffJc3VEFJwYxTNezwP5WVV/3OQ+AACKw8gT477RZu4A7hn4c+VurIWHF0X1v+W/H9FsqfEsFgz9e6kmnHxHXqX0FQswSsEDl0UkQlN/SmxKnxeL5nfqhCwNXp/NG/KsSyoSfcNzC+lHIwuE0EVGRpZ1ncnOyYjCfgrhzV6yIGgh6EoYFuRomSE05r5kHJezllLnuWw/Z6f6R0ylq5z8XscIPf7GEZZfpE14qcZj8kgJbO1m1ge2hPShC3ZzwzvbWDoUlsNus2lX6wYOx+IqltVxR0i+uReWagQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPR0+BeqS7KLB0pcgV205fTmDRp8Br/w1ts2qAGc9tM=;
 b=vdMBpfnopEuyzqQSe9QPrpBw86AV82uHElLhHN5M11RCDcrW65mDwulNQODCplokNbbdmWmc7sev6DaulJc5PGgkj8RPptyc7U9CKfSCGqUhdbl5Rzv+1t17E6AhK7CQVLKh59AZ5vRmMhZUq1y6sk0xcH2AFvEGaB2Fm249rkmAzYo5y8wLpwSMbvp7mLe1fDmkYGp9GDli4IAc5+Gsci6DGD33u/uHSTrCnMlxsvlpv28i4cz9C1IIinrPdnpY0pWdmDHTIt+on6KYfQVONgdrgTJqNo8Zzo25b04lLkuI9TEQi/OJnWKymrU9vcN3FiBueWUoJjC6lNKpAcgT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPR0+BeqS7KLB0pcgV205fTmDRp8Br/w1ts2qAGc9tM=;
 b=4sITWcetMtZnDXY1pPdR04QkTeJGdKpenIKww6aFWNFz37ONLXpMNRbwI2nJKoHYHlTFHGdotQlTDNpILhjcj5XKg+j6q5WoSjuNlL+r4e4DiVWD+GSfMBrMJPV94Hjl0b69Jdc4dNu0U6Zzs+uwHhfWx3oapI17bQmud25FhSw=
Received: from MW4PR04CA0050.namprd04.prod.outlook.com (2603:10b6:303:6a::25)
 by LV3PR12MB9437.namprd12.prod.outlook.com (2603:10b6:408:21d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Thu, 19 Jun
 2025 03:57:55 +0000
Received: from CO1PEPF000044F4.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::e7) by MW4PR04CA0050.outlook.office365.com
 (2603:10b6:303:6a::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Thu,
 19 Jun 2025 03:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F4.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 03:57:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 22:57:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Jun
 2025 22:57:54 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Jun 2025 22:57:53 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, Jesse Zhang
 <Jesse.Zhang@amd.com>, Arvind Yadav <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: fix slab-use-after-free in
 amdgpu_userq_mgr_fini+0x70c
Date: Wed, 18 Jun 2025 23:57:51 -0400
Message-ID: <20250619035751.138272-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F4:EE_|LV3PR12MB9437:EE_
X-MS-Office365-Filtering-Correlation-Id: ccf8b13f-f432-462e-c309-08ddaee578c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?enExZU5iMzl3dTVBa1ZqYTl5VEdxLzJCcVdLd0VSdGZhZGk1UGdaSW5zQzRG?=
 =?utf-8?B?UkdoWGRwRVhic1dTUm14ZXRRRmNkWkJEdDd4aUR6bnhWMnc0QTZyeTl6bFFm?=
 =?utf-8?B?azE3WkV5UDM0V2xkZGN6UjhHa3U0cnd6MWNOSlpKb2FBcjlheUorY1ZpMW9i?=
 =?utf-8?B?T1dDSGVoRHRoL210K1AxRDZkVzNKczBjM09VR0ZrQkJXbWtDbTlPZi8yV2hG?=
 =?utf-8?B?cDZhNVdpUW8wYlhlemU5Y0M4WkZybXJoZ0hRRnFuOGJuRkR4TW96SDJaemNI?=
 =?utf-8?B?c3d0aXV2c3JObW5lMGdvMVZpTW0rMnpzdzdoVTUxbjNPcjZWcVFMeEtsNUN1?=
 =?utf-8?B?UklqNGIwOWtLQ0FLQk1mbDRFMkg4VHk3V0p1V1pwTUtTbkk2UnhKNGpzeFoz?=
 =?utf-8?B?b3BoQTFMRVVnTUVnYVptazZLRitIeXJhSXJMTVdjaGVsUWF3a2hXaElWaUdI?=
 =?utf-8?B?Y0FsWTRRcjdoQnhtVWlVVmE0aFNDNlBxZUpNTjhZeHpiRXJlajQ4c2NBUFJY?=
 =?utf-8?B?UTlIK052Q0lhRThtTU1yY1RZUzlVN3RmYlBhODV2RmNZOU1DOXFRaGpFdHR5?=
 =?utf-8?B?cHpVNjZlWmNvbExxcTJsN0ZDa3NxTHpUOWMrbEtSOTlFK25zS2VhdHRHL09H?=
 =?utf-8?B?d2RXSnpTWmo3eDVYSkxqL1ZiSEZpVytBWlFVQnpYbU9nUHpBcHZDN2JXZU5y?=
 =?utf-8?B?eWwvQkJzYnZ2WENndkNQZXkyR0laS0dJNGxJSFUxbEtKSWlic09mTDdRQzBm?=
 =?utf-8?B?ZDgrMzZGbTZqWVU2Y25ZUHh3bS9KQVdYNzdwN0VpMXJGTzBUTmJZM25QTXZm?=
 =?utf-8?B?cmg0ME9iMEVsWTZqZGlBeVNKZHBUcFlNS3ZYbWl5eHdtdDdaUHpEMkFabnZn?=
 =?utf-8?B?c2hKVFJFTlUzM3dZR0V5YWhXZFh0N1hsZ0ZrdnNaU0ZOUUlRRzVRZC9TUllF?=
 =?utf-8?B?b1VBelFCakJwSDExamI3NzVUVTFMSzNYZVlLeGthVkxaNUt3SGRGdWk2aHhB?=
 =?utf-8?B?b2hxSW03VEhFNWVsaUJwdmVPVzhyQ0Ntck0vdVVLaWZ5YTZqTlhqUGhqK3Rl?=
 =?utf-8?B?MExKVHlzM01DYUpIeEpLNU53ZnV4MHNzU24xSVgyUEVPV3NXUCtzcjZXSkVr?=
 =?utf-8?B?cnNHQ1d1SnNlSVNwWXV1a0NkUGFnVDRRN2xhemQwbWY0L0RGcWw3R0dnS05M?=
 =?utf-8?B?cGdDZ05EQXRLOEJ0RGx4a3l0VHlUSUFpL2RJUVdPb1JCQWYxWU9VbHFBSDhn?=
 =?utf-8?B?ejh3RFNEcmNyckE4by9ONXRjMlZncHNiOGlSeEh1MmVIUldqYTV1aWpNTXlN?=
 =?utf-8?B?cG83RS9yUzBGYXo4andwTW0vOWdiUmdVbUNhTU1acnlFMVAyWlVmUVpZemI0?=
 =?utf-8?B?WWtlT1o2Z1g3MEg5WjBpWEJ0eUs1RC9qdEkrOVRFR2FpWG4xZEQyRWljdEZj?=
 =?utf-8?B?ejFZL2cyRFMrTE80cHBTK0tpdUo3c1RtcE9DTXJ5UlY3cVFnNnNIZmg5WDdF?=
 =?utf-8?B?aUFqRjQzSGpHcTVXQjNma21nTksydU0vZ01xck1OQ1ZDYlhHcmczcjJrNm90?=
 =?utf-8?B?azNRemJFOHBXTU9TcTdlbk5ERVJUT3JwKzVpOWhEdFd4cmQ2NFdyUDRUMUlL?=
 =?utf-8?B?VmlGTVlCQml3SXhEUlJ1UkRLeFA2N0liSlBmQnExditoK3hwenlHeDFCeWx4?=
 =?utf-8?B?SkhvV3M2ZzBGMGo5Y3VwUGZPcGVycHQ1QlgvRmZldXZITnRNQnFwdGZQVG5S?=
 =?utf-8?B?RnhjWkpmUXhMNDZDQkFSdVNUd1dud1puMW90QXFyNnBKcUcvUFFsU3BrZm12?=
 =?utf-8?B?YzlMTUZrd29qZStTNlUyWWVHU25GQWZqK251Rmlkamp3TzNaYk9ENHFQeWl3?=
 =?utf-8?B?b3h0eXpURFBnUUdDSWlRT0tPUFpRa084TGdLbVVUMjk1cFNYS2lDT245Q0ZD?=
 =?utf-8?B?SXpuWnVTU0ZhNEJPdHZaM2RuWmhBSStYZGVNaUVMalJSaktZaXp2ci8velBj?=
 =?utf-8?B?NWdFdUVRc3VPY0g5Tm1yLy9aUU1SKzRzMjFKc2M0bGZKeUg3eHVXd0lraHpa?=
 =?utf-8?Q?zB/OmD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 03:57:55.1975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccf8b13f-f432-462e-c309-08ddaee578c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9437
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

v2: drop amdgpu_drm_release() and assign drm_release()
    as the callback directly.(Alex)

Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: I7ab41fd785dcd6f2651c726337ca07519ceae574
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 16 +---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  3 +++
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7fd233f160bf..818a49e69aea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2912,20 +2912,6 @@ static int amdgpu_pmops_runtime_idle(struct device *dev)
 	return ret;
 }
 
-static int amdgpu_drm_release(struct inode *inode, struct file *filp)
-{
-	struct drm_file *file_priv = filp->private_data;
-	struct amdgpu_fpriv *fpriv = file_priv->driver_priv;
-
-	if (fpriv) {
-		fpriv->evf_mgr.fd_closing = true;
-		amdgpu_eviction_fence_destroy(&fpriv->evf_mgr);
-		amdgpu_userq_mgr_fini(&fpriv->userq_mgr);
-	}
-
-	return drm_release(inode, filp);
-}
-
 long amdgpu_drm_ioctl(struct file *filp,
 		      unsigned int cmd, unsigned long arg)
 {
@@ -2977,7 +2963,7 @@ static const struct file_operations amdgpu_driver_kms_fops = {
 	.owner = THIS_MODULE,
 	.open = drm_open,
 	.flush = amdgpu_flush,
-	.release = amdgpu_drm_release,
+	.release = drm_release,
 	.unlocked_ioctl = amdgpu_drm_ioctl,
 	.mmap = drm_gem_mmap,
 	.poll = drm_poll,
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

