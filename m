Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63303D637CF
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Nov 2024 01:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02BAD10E2B0;
	Thu, 14 Nov 2024 01:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wsVZF2j8";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2063.outbound.protection.outlook.com [40.107.244.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EB2210E2A8
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Nov 2024 01:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bKYzpLOz/r+HvwsEt+3IwUsgfWrZeAihrRONu0n79Q+0VJdMhdu16V7FUO/P38EI8Mo2BtZWgGfKKpHF0HCJCku4wGifsU59OEkj63u1c1vLJ90fZ7WjAfcA1fOGU7xmp0VJjWk2ozkAF3uxIHiLvDUXIXd9L9ogGy7ggkZPIBUUD5cC1DkXUczwdEw/Ah/pch6wH0aGBOYu7XO+t2aD10U2eFXWa7OFkpIrdgLaa3s0USKRyigYHeR7BO/utBzt5UyHq+bzmg0jqd0QLVjDYFf9rO9RCpRDEDhVt4xGxHx+2QaKMLWSx2wbLn05AcYUcGDMydKKBnA/QtJaF25Onw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBmQ7oWJld4fM9RWJTFbJX+pcu3VAnPkdK7NKePOMXo=;
 b=FScvgMWCcXbzr9XcsTwS1aFnSpkThjiVpZlT9quzQAWht+MwxHnWmNSoLFZezf5aEpLzHEMr9XtTMlqLSg7FTnaKsmQVaEhTDajCh9ukkAIob697IUol3rcH9zb0gp3/HlUZN3PAkricEJPqkmRUR1MnbiH1epwSV40SsYpXoy6Gc17IpRDYT66NVaCN6Q0L0rXQUuZ2mRyLe5xPq37n3fvD7nydV9cgD1UtzQj04EoLZ5wUWE9thSNIujXZH3IwUZr8gNtARjLN+zM9IHUf7D+XXECLW8outLRpb6U/48R+agN0Iaj1cfYUBOLX+x6ETwYZ18COjYOV/UX2g3zVJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBmQ7oWJld4fM9RWJTFbJX+pcu3VAnPkdK7NKePOMXo=;
 b=wsVZF2j87IG35Bc+bC9JOykCQpi7rlXrgCN3B3fRYNPQlQl9b9rTgHu2gEx6iqB25O831J9Si4AZT7CL55z60pX5fwe8urKJSS+QQr/6cDA1YU6m2gcCoHG132Ft7BnOfCh5t1JHzxZF0yU6MKKaUKzm9eWlkwsXorZbtoZ8DnY=
Received: from SJ0PR05CA0003.namprd05.prod.outlook.com (2603:10b6:a03:33b::8)
 by SJ0PR12MB7068.namprd12.prod.outlook.com (2603:10b6:a03:4ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 01:41:30 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::33) by SJ0PR05CA0003.outlook.office365.com
 (2603:10b6:a03:33b::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Thu, 14 Nov 2024 01:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 01:41:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 19:41:28 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Nov
 2024 19:41:28 -0600
Received: from desktop-host.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Nov 2024 19:41:27 -0600
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <--cc=christian.koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: WIP fix usage slab after free
Date: Wed, 13 Nov 2024 20:41:12 -0500
Message-ID: <20241114014112.394505-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: vitaly.prosyak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|SJ0PR12MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 371a4c5f-6fa7-4927-ca3f-08dd044d768b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bjkvZWR4cUcxTGdQMEh6KzVFMlNlaEU2U1NVZXB1OTFvc0QyRzRTWTZmYWhv?=
 =?utf-8?B?Y2hvWVBjSWpmcXlyc3RJOVg2ZWpSN1NYZ202eW9ibmI1ckpocUlkVmhPTGpI?=
 =?utf-8?B?b0EySjlUQWtRcjQ1L3FVcnRQVExyQ0V1bFdRYTBEdDFFcmY2WkZhMXdkcGJn?=
 =?utf-8?B?amJHZm1iMzFjd2tFdjRwaktLRGE1NU5UUElza1lmaklhMVZFMTRKM2c2Ymty?=
 =?utf-8?B?K2VKUGhvUjRRbnpPNEFpYlhBbVNDdUNWQ0hpV2hwa2RMSlpaVkl6K090N0FF?=
 =?utf-8?B?TFF5c0NYOVYvUDd3dUFrbXNBK0pNeVA4WEt3dWhyNnZUc3Z5Nko1dkkyd244?=
 =?utf-8?B?MHNoSTdrZ3pJN2FUbmg3TVRlUTlPYyt2YTNJNSttZWtBSUFRWFNKWTdzVmQv?=
 =?utf-8?B?bGl6WDVRNVYyV3lOSWpZM3lVTExBTkhQOWVUUkxVTTh3dHJub3V3bUQwUC9n?=
 =?utf-8?B?Njc2M1FncFJCamxzelUwYkJvMnNHUWpGMGhRRkppZmhNbWJxVExUSGdYYWEx?=
 =?utf-8?B?bFpFNDJpZTBhQndsU0paeVE5QmdRZkFrQU93U0Urc3NrR0drNDlTbXl1bHNC?=
 =?utf-8?B?TW13VHR6ZDZMSTQyK3pzMG9mVGtaVWh6c3RuVXhPTi8vN3NUWGR4cDdodE1F?=
 =?utf-8?B?RGhFWXgrcjJocnV4MjlUcjhuTlN0aTVOQ2dSMFptSDgrUFY3ajQrVWZBZTR1?=
 =?utf-8?B?Zmk5UmJubndiTGRlbW4xT2pKQytJVzhFV25xMEpwOUNMQ1NEN3VpTXJ6Y2ti?=
 =?utf-8?B?YkoxWWJmdTErUmkwUGw0anpWL1BkU01nakNnYmRsUjRzV0R1TzRCazhWN1Yv?=
 =?utf-8?B?YXl2Rkt1YVFPWTNxeWgyajcwdFFIRWR2Y2M4UjRNVktwcUNuZmpDL0d2Wmlz?=
 =?utf-8?B?WmZTeXpSaGlpeGVoN3ZVVyttK1ZoSGQ5OVFmRXpEVFFiSTRlOWZwQi9mT0Fw?=
 =?utf-8?B?bW5qbkpCdWh5VUR2NHI1QnZTL0Z0UVRKalVKdnhCUHJkOHNsQkxpTk9rZFN2?=
 =?utf-8?B?YSt4LzVIdTZ6Z29JUzBCQXhNcTVxTUV4K3NpNVB2QmpkWEN6NXRGVVI3VXAz?=
 =?utf-8?B?L1FuNUFZTG54amp3L2h5TElxZC9oVFlFbUFZcllGZjZXOXZJWXEycWVuZzNh?=
 =?utf-8?B?R2NBc2VuR25KNmwwYU1uM1pSTUNWMlQrZ2JGTGsvN3Rya3BYRFUvRmFsOTVz?=
 =?utf-8?B?SHBGeXNzL1dEbENBUjNYS1lFNG11TlNpbDZONVBYWERzZVVIWCtLVXNPOGc4?=
 =?utf-8?B?SE1BV05OQmxCT29qR0x6RE5lTkZVSXV6TlhPdDlFL25JSnZqYjNIbTYrMHh6?=
 =?utf-8?B?OW94UGp4YTZTRHdCYzcrbnFoUnMybHhMRThzNFBkVldwaXhCVCs3eCs3em1B?=
 =?utf-8?B?RVI1Z2lpSmFnTWVMNWxsRGR0ZThXdUNKRkppZjZUYm0vMHZBMUtFYkI5amRP?=
 =?utf-8?B?ek84azk3VGtReGd4dFN4SVZvQzdNMkszRWIwNWR5eHEvYlpyVlhnVXNrRXU4?=
 =?utf-8?B?VzdraFAwT2RubVg4RFJTdFBaYTU4UHk0dGd1TWNLOGd5ZTdlRGZKMFk3VlB0?=
 =?utf-8?B?SHRLUittNHZ2RE93MXorQUkwRmthaGNSalhzdHpWNGFRVkp4Y1VCdE01RUkv?=
 =?utf-8?B?ekQyNHd3YjExaFk3eUpCWG9SS0kxTVF6WHY5NFp3MENFSjlUVWRJaGk2cHVt?=
 =?utf-8?B?KyttSHE0N2QwdDhPTDB6L2x1TkdXNTJIdldZTENmZ1lMM01tVUN2WTF5KzRu?=
 =?utf-8?B?OVY4ZjErY0x0bXA4L2s1bWwrVnNNazZNcG1jM1MxaUtKcS8yNXlRU2FZSGZq?=
 =?utf-8?B?eWZmZEVDS1RvdHVXN1o5dk1NVzJvc3NhR0R2eGlCYnFRM3JBbC9WL0hJSFpB?=
 =?utf-8?B?Mk5haElnV2kxSzBObXJBR3dyMVEwVjVwcUxuK0RYazE5NEE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 01:41:30.0750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 371a4c5f-6fa7-4927-ca3f-08dd044d768b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7068
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

