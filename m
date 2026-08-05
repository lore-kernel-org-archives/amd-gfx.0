Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B4EC55174
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 08:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A33710E1B2;
	Wed,  5 Aug 2026 08:14:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Z4q9+UaA";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012050.outbound.protection.outlook.com
 [40.107.200.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 576F510E1B2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2026 08:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IUiFlUB6+/4yb6nq6JX14FdWb42y4ykpTQT6GFTSrAnDaNEV7mDSaVoW7UEZeBRRUhfG90l2hoIwpCYcT41i2LCVvdNVr68ngHOH9dIvuvUeZmjINo5vl0PwNMNql0GwqwT9yCAaDFwW3pMGanheuDC4IOUo6WfW10XNhm2fYTUm6+DV+aBlsRTMqpp0bn59nfwGu99C+ahRZVURH/MEtnhxNgkFUHvlNw0lzxMU82gfX24qZIyggGMUBe/69YnP7McP96Piu5VtE2urtA3TijajNJOTJHCmY71sdxx8q3gak14dajJROERs+HMDNa6p1IZBunfZYORoIwAj4Ar6WA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xetjFBDSOHcWZkTfA233hz+mR7+2I3zrmANh804/L3E=;
 b=MVLYgi821cuBsxQxzfi4SUp7mnKuOppN3tsjE3EPs+JQUwHXL1d9yuxYqCOYlhlyUxt+6WaYuXOxnLm87odIdZPtSHFVlw3CfaAy0yaaYyTGdl1xz1pSkyRPdL9URdQ/q7vpNne5Qk3mVRV+3E7NUS9OXavlyQnVG0mrClVyvyJ9NnqGGTg+F41ZBv20f1G1bSgKnpnOpY6NeRiC8OTLGIW0yx9DblBgTqO2p6chf+qvqW7m1ZClODhvWGrl4XA3gs1vDwrL4xTX6H+2VMQK2NmBS0VEEBORl5S5MI+vb2AtM1GmNOZCmx68B798z/LIrDPvCermyf9mHteqgCxADQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xetjFBDSOHcWZkTfA233hz+mR7+2I3zrmANh804/L3E=;
 b=Z4q9+UaAoN75Z/UIbY8nVRKbVgzEAuEpqGVCmJSUoEXxkhEasd8vhhc4/+rd95h0T61rP867+sYiX9Lz97r7DxufpvN095nijUdIEHFO/uAOaCMu7ffsUZpNsSs91PxeB4YI88uCwUFZWZPfDb1WleYIPDuGIgucppbAEw0/lP4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB9794.namprd12.prod.outlook.com (2603:10b6:8:2a7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.15; Wed, 5 Aug
 2026 08:14:16 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 08:14:16 +0000
Message-ID: <e0966ada-3d85-41df-897a-81287ff00ae4@amd.com>
Date: Wed, 5 Aug 2026 10:14:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: skip BOs being torn down during GTT recovery
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com
References: <20260728054000.443371-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260728054000.443371-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0053.prod.exchangelabs.com (2603:10b6:208:23f::22)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB9794:EE_
X-MS-Office365-Filtering-Correlation-Id: bdb6f304-5ce0-42d1-d995-08def2c98a7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: L8vtMsk8M5gfo32xifaRenPiUV5wZgy2Sg/HOC3jtZB2UsIeEnlxmf1vC5pg0jCdOB6ecquucqifP/knFx9bf8wW+u3BoQw8cntC10KBzmhtsRIvtBNlYqQK50YkJAIbjPUrLWB3XqBRhfq2FwDqf0djQvC586b7JhWU6JHLZXpKG7R/rzabUE72pwr8fi1Rc+OT7NDKi0Vf7ec2tchTM3KQ8gXEYSXZy+Bv1zbamNcL8txW2vUWG5889e2HlufQIJg8vYS0OQW+VlTgDYvKxNo9ecKjRt1TeS8Xrh6g++TfJd0WEY3pPTRm1jdjGQZ6CJF9InHxjAW7BNUOUA7MGbKhPvkF3B3y4Qc+h2f6zqNH5ZZAfVzSAOYaQuHV000K/NE3tCf837wFR+QUHsafIp/66R5xOXIpCtXI9x2oxHKzMK4s/SR1ci58C+/ZxI2k1HnMOH+VcBz2rYgwxbl9iQl4O01AqVNhws8VX6V+dVsfD4eSO0aj5xSNLt8MnCcHBdOpSFG2YbGgUipVPqP1v/7+BwsbpNdH8stotwalcLIqpGw5ndpUOuK1nfgGZcWjkbvNxIXY6t5pzf0O0o2NHxC6lYl+ga3L/uph3ygr9qVTnRiA48+VP4tzPN3MKCd5VVqO0O6vUzyROBZn8O+VNA1Bu6qSZ2OxEkHBUn45oGA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUNrNFFZL2pVaGtMSGg5QjU0UEFZUmgzUER4dFZOR1IwV2YvVGFVcitsNis1?=
 =?utf-8?B?N25tOWNVZkdwU0Uxa0x5VWwvc2xQYjRlOTZSeXM4bS91YmkvbUFSVDFlK2ls?=
 =?utf-8?B?cit5aDFlVURZMmU2NGdtUk9Na0RSMHlpdFpZWVArMDQyeWFmc093Yk1Zbmll?=
 =?utf-8?B?YWVScUZaZHRRVGwvOG5lM3dVZkMyZHNmT3BndmYwdURjTkorUGtDZUZodkdo?=
 =?utf-8?B?b1VtWWhKQWh6Vkk5cHBzQUtUTWNrK1hLQk4zeUozVDZIUyttckt0ZDJob0lT?=
 =?utf-8?B?MGVtMjVJQ2dXU1dDdEdoRk0yRC9CYXFYSFFQRFNncGczV0NCWWFXcmVCYW1P?=
 =?utf-8?B?Z21GTlpSdDR2SHk2NXRGNjJvcXFuZ2NhYUxhSVQ3R0ZtZGhybmpBU1VnWmNs?=
 =?utf-8?B?OW5BMXUxaE9VN25MZ3JFSW54TVVJZCtUU2w1VTZnL1F2U0VRMlk3QTR2a1E1?=
 =?utf-8?B?akRndWNBaXo4bU5JWlk4VlJRcUpmeGYyelNqWS9LalpTaERGTE9EdEhpd1Vt?=
 =?utf-8?B?TkZLY2xnTTBkZWlQVjlEZDNBelFxdUlVL2xMUVdTenZCR3JJVDdEYzBROExr?=
 =?utf-8?B?SzRBRC9zZ2tNQXRPWFdBQjN5dWEvVUlDTmtadTNYa2tNc1lwR2ptajgzcVIw?=
 =?utf-8?B?K1NadHppVWFJYWFkZVlYSGRHMjI3REFKZ0ZsT1J2L0JwNysxT3pPWlQrck84?=
 =?utf-8?B?ZUZJdy83TkpBKysxOFZMYUw1MW5YK1R5ckdOSHBsUG5JNDVFRzFjUG41N1Rj?=
 =?utf-8?B?QUdxSFlvQTFyUDZHTXIrYzcxd01rcnl2R201T0Znc083bVBwZUJjMGk1MXNY?=
 =?utf-8?B?UkhxUTJQcnpsTC9PdFNhcmgxbmd1aEd5bDAzV1pmRHRxRW5LeG5uY0h6Lzk4?=
 =?utf-8?B?SExoanllczhqMEprQ3RMbXRHRFh2WlFnaCtCWGpEcHFPZGp1VkVkKzh4ZEpD?=
 =?utf-8?B?YU5YOXZFcEc4bkFWcXduTzlhaitiTThEOWh6UjlybEI4c1JidGhjaWdxdWtN?=
 =?utf-8?B?NHJ5eDZQbWJNVkl0WTZSR2Y0b3kxdEIzeGRFWCtKYm93SE42a0xFUUVVUEZ5?=
 =?utf-8?B?NTBrWWMwbVIra1dCejIrU1gyVFEzOHUxbzFaNzhIWlFHRWFCZVlkNjlpczd4?=
 =?utf-8?B?azY3bXN3OGtQcXoxSERoVlIzaTZuQUpndzY3NGpYcEp1bEU1YXBsTFBMWXBv?=
 =?utf-8?B?azcwaXhFeWV0ZnFnT1Z6R2lOMFowT3ZGcitucWVnc0h0R2ZZajVXTHl3MUo4?=
 =?utf-8?B?UU9tWE9NVURLR3ZVbEVHdC9JZGNCMHBTakZ5S0tIZGdKUCtHbnZkZGVwUXdr?=
 =?utf-8?B?VURVKzFvL1BML0dzTDJSUjJ3cTk5eEpnNHlkL3pIT21xOGhSWlhqRE5WcVd3?=
 =?utf-8?B?eEVrbUE1cGFSYnRLYkdzU1NiNVl6QVBtRVZQdXd2VWRzWkhoOFNNR25lck1k?=
 =?utf-8?B?OXBjdUxqb1gyVUpoUzl1SHROSFJTTkd6L2w2OUhLQVRIRlJFL2g0UXFlYW5w?=
 =?utf-8?B?MjJMRTVZOFNpb2FNWEs2bTNtQ3ltbENXSE9UWXNmTUczVjlsRjZaTXVJc3NW?=
 =?utf-8?B?WkdjY0hubjJGeHRjZlRQZ2czTFhweEk4VmM0Yzd4eXMyaVFzUDZEMzBwVHcy?=
 =?utf-8?B?OXIxSXN4Q25yM1V4eENhNVczTnY0VlBRQjZvYkVheE04Y3VHUHhnSEhZbEVD?=
 =?utf-8?B?bldKRm5oY3AzalBtOXhObWpOaHplRUw5WHJKcGFyMXdDUDNnVDVqNTlSSFUw?=
 =?utf-8?B?MklQV1dUR1JMVFQ5ZDU1RURJS3hjSURjQWNEVHFRQWVyb1R3SVlqZVFBSkpM?=
 =?utf-8?B?ODdFVDU3S2NBanpMZkhaRmF4SFFjc211WEkvMlZ5eUVwaWgzUkRKUjdLOTdS?=
 =?utf-8?B?VzNsTlQyVXR0bHUzY2tCMnhGcjh1eEt6NzhoOGZTblNsR3dYOUZVUUt3L0dH?=
 =?utf-8?B?aUxsNjlWVks4ZG5ncjVnWFpyVDUyQ1MySCtsNm9WSFl4WGI1QjNTdGtBaVBW?=
 =?utf-8?B?bCsxZk5VSEllTDFKQjRXNXJsc0dvN3pwTkhrT0hiQkxWWkF6Zi9seml1eFZZ?=
 =?utf-8?B?N0Znbk9EeTRxSFRXd2c0ZkxaSlVVWGR2Q1FxN0VxTXljOWMrQ1RPZHhRYkdh?=
 =?utf-8?B?YWdVRHRPQ3NxZUh0dmZUeHRzc0dxN2FNTC9iWXlLanJrSWYzMi84Z055bHdh?=
 =?utf-8?B?M1l1WWJpM1Q1eVd0YzlqVkpWdC9qcm12eEZqaU1tTm9UR0c4aTNUQ3B0cGdE?=
 =?utf-8?B?dmNJczZKNURST1VaYVhFbXdkTjhpa1VNaU1VZEJSeUcySllteklTRHB3bjNz?=
 =?utf-8?Q?588ZZvGMqRgn6iO8ue?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb6f304-5ce0-42d1-d995-08def2c98a7c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 08:14:16.1039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qYLnH0MAXJ0MpOeVGTpivyXmlVrt4HJexoaUD0AfvSytkjlQDRH7E2rpqhrxy4Mb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9794
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

On 7/28/26 07:40, Yifan Zhang wrote:
> A GPU reset can race with BO teardown after the BO's GTT resource has
> been marked for deletion but before its drm_mm node is removed. In this
> window, amdgpu_gtt_mgr_recover() can treat the node as a live BO and try
> to restore its GART mapping while its TT backing is being destroyed.
> 
> Mark the GTT node with a dedicated teardown color from
> amdgpu_bo_delete_mem_notify(). During recovery, process only nodes
> colored as live BOs, leaving both teardown nodes and nodes without BOs
> untouched.
> 
> This prevents reset recovery from accessing a BO whose backing storage
> is no longer valid.
> 
> kernel: amdgpu 0000:a3:00.0: GPU reset succeeded, trying to resume
> kernel: BUG: kernel NULL pointer dereference, address: 0000000000000000
> kernel: #PF: supervisor read access in kernel mode
> kernel: #PF: error_code(0x0000) - not-present page
> kernel: PGD 62256dd067 P4D 0
> kernel: Oops: Oops: 0000 [#1] SMP NOPTI
> kernel: CPU: 378 UID: 0 PID: 3775143 Comm: kworker/u1536:4 Tainted: G        W  OE       6.17.0-35-generic #35~24.04.1-Ubuntu PREEMPT(voluntary)
> kernel: Tainted: [W]=WARN, [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> kernel: Hardware name: Supermicro AS -4125GS-TNRT/H13DSG-O-CPU, BIOS 3.8a 11/01/2025
> kernel: Workqueue: amdgpu-reset-dev amdgpu_debugfs_reset_work [amdgpu]
> kernel: RIP: 0010:amdgpu_gart_map+0x60/0xc0 [amdgpu]
> kernel: Code: 71 98 c3 48 89 45 d0 31 c0 c7 45 cc 00 00 00 00 e8 25 4b 9e c1 84 c0 74 39 48 89 d8 48 c1 e8 0c 89 c3 45 85 e4 74 23 41 01 c4 <49> 8b 0e 4c 8b 45 c0 89 da 4c 89 fe 4c 89 ef 83 c3 01 49 83 c6 08
> kernel: RSP: 0018:ff4f7e3af8a1fb18 EFLAGS: 00010206
> kernel: RAX: 00000000000002b6 RBX: 00000000000002b6 RCX: 0000000000000000
> kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000000
> kernel: RBP: ff4f7e3af8a1fb58 R08: 80c0000000000073 R09: ff4f7e4ad6b00000
> kernel: R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000002b7
> kernel: R13: ff2209225a000000 R14: 0000000000000000 R15: ff4f7e4ad6b00000
> kernel: FS:  0000000000000000(0000) GS:ff22098108562000(0000) knlGS:0000000000000000
> kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> kernel: CR2: 0000000000000000 CR3: 00000064b7011002 CR4: 0000000000f71ef0
> kernel: PKRU: 55555554
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  amdgpu_gart_bind+0x1a/0x50 [amdgpu]
> kernel:  amdgpu_ttm_gart_bind+0xd8/0xe0 [amdgpu]
> kernel:  amdgpu_ttm_recover_gart+0x5f/0x80 [amdgpu]
> kernel:  amdgpu_gtt_mgr_recover+0x43/0x70 [amdgpu]
> kernel:  gmc_v12_0_hw_init+0x46/0x160 [amdgpu]
> kernel:  gmc_v12_0_resume+0x14/0x40 [amdgpu]
> kernel:  amdgpu_ip_block_resume+0x24/0x80 [amdgpu]
> kernel:  amdgpu_device_ip_resume_phase1+0xce/0x180 [amdgpu]
> kernel:  amdgpu_device_reinit_after_reset+0x13d/0x340 [amdgpu]
> kernel:  amdgpu_do_asic_reset.part.0+0x56/0x1b0 [amdgpu]
> kernel:  amdgpu_device_asic_reset+0x426/0x640 [amdgpu]
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  amdgpu_device_gpu_recover+0x260/0x410 [amdgpu]
> kernel:  amdgpu_debugfs_reset_work+0x68/0x90 [amdgpu]
> kernel:  process_one_work+0x18e/0x3e0
> kernel:  worker_thread+0x2e3/0x420
> kernel:  ? _raw_spin_lock_irqsave+0xe/0x20
> kernel:  ? srso_alias_return_thunk+0x5/0xfbef5
> kernel:  ? __pfx_worker_thread+0x10/0x10
> kernel:  kthread+0x10a/0x230
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x121/0x140
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork_asm+0x1a/0x30
> kernel:  </TASK>

Please drop the full backtrace from the commit message, that is superflous.

> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 36 +++++++++++++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
>  3 files changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> index 0ea32561c4bc..1f9063b30526 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
> @@ -26,7 +26,9 @@
>  
>  #include "amdgpu.h"
>  
> +#define GART_ENTRY_BO_COLOR		0
>  #define GART_ENTRY_WITHOUT_BO_COLOR	1
> +#define GART_ENTRY_BO_TEARDOWN_COLOR	2

We don't need a separate color for this.

>  
>  static inline struct amdgpu_gtt_mgr *
>  to_gtt_mgr(struct ttm_resource_manager *man)
> @@ -102,6 +104,35 @@ bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *res)
>  	return drm_mm_node_allocated(&node->mm_nodes[0]);
>  }
>  
> +/**
> + * amdgpu_gtt_mgr_mark_bo_teardown - exclude a BO from GART recovery
> + *
> + * @tbo: TTM BO whose TT backing is about to be destroyed
> + *
> + * Keep the GART range allocated until the resource is freed, but prevent
> + * reset recovery from using the BO after TT teardown has started.
> + */
> +void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
> +	struct ttm_resource *res = tbo->resource;
> +	struct ttm_range_mgr_node *node;
> +	struct amdgpu_gtt_mgr *mgr;
> +
> +	dma_resv_assert_held(tbo->base.resv);
> +
> +	if (!res || res->mem_type != TTM_PL_TT)
> +		return;

That check should be outside of the function in amdgpu_ttm.c

Regards,
Christian.

> +
> +	node = to_ttm_range_mgr_node(res);
> +	mgr = &adev->mman.gtt_mgr;
> +
> +	spin_lock(&mgr->lock);
> +	if (drm_mm_node_allocated(&node->mm_nodes[0]))
> +		node->mm_nodes[0].color = GART_ENTRY_BO_TEARDOWN_COLOR;
> +	spin_unlock(&mgr->lock);
> +}
> +
>  /**
>   * amdgpu_gtt_mgr_new - allocate a new node
>   *
> @@ -137,7 +168,8 @@ static int amdgpu_gtt_mgr_new(struct ttm_resource_manager *man,
>  		spin_lock(&mgr->lock);
>  		r = drm_mm_insert_node_in_range(&mgr->mm, &node->mm_nodes[0],
>  						num_pages, tbo->page_alignment,
> -						0, place->fpfn, place->lpfn,
> +						GART_ENTRY_BO_COLOR,
> +						place->fpfn, place->lpfn,
>  						DRM_MM_INSERT_BEST);
>  		spin_unlock(&mgr->lock);
>  		if (unlikely(r))
> @@ -248,7 +280,7 @@ void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr)
>  	adev = container_of(mgr, typeof(*adev), mman.gtt_mgr);
>  	spin_lock(&mgr->lock);
>  	drm_mm_for_each_node(mm_node, &mgr->mm) {
> -		if (mm_node->color == GART_ENTRY_WITHOUT_BO_COLOR)
> +		if (mm_node->color != GART_ENTRY_BO_COLOR)
>  			continue;
>  
>  		node = container_of(mm_node, typeof(*node), mm_nodes[0]);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5fe29e4972d8..6fa8301b8ddc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1676,6 +1676,7 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>  static void
>  amdgpu_bo_delete_mem_notify(struct ttm_buffer_object *bo)
>  {
> +	amdgpu_gtt_mgr_mark_bo_teardown(bo);
>  	amdgpu_bo_move_notify(bo, false, NULL);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index ff9e2e346609..af1e7fcc7175 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -145,6 +145,7 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev);
>  void amdgpu_vram_mgr_fini(struct amdgpu_device *adev);
>  
>  bool amdgpu_gtt_mgr_has_gart_addr(struct ttm_resource *mem);
> +void amdgpu_gtt_mgr_mark_bo_teardown(struct ttm_buffer_object *tbo);
>  void amdgpu_gtt_mgr_recover(struct amdgpu_gtt_mgr *mgr);
>  
>  int amdgpu_gtt_mgr_alloc_entries(struct amdgpu_gtt_mgr *mgr,

