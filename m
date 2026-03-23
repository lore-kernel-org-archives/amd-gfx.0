Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A385D58CBE
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 03:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09A4010E354;
	Mon, 23 Mar 2026 03:51:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="00vVZAUL";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013045.outbound.protection.outlook.com
 [40.93.201.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4857510E354
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 03:51:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gj72CHTTtHAOmRBulee3tcJRYPUCGycOavXM/thM0lzwTpXVtOMIwONKJENPi1QHLsrblFZXL71UhAtZNxjeuL1xjmnoc0t6ONHoSK7MO6QzX6N95xqlNM+BaOxeRfQeJKzV5UC+2C9kFQkSe2uGlhgWK/A7Pwq/7FSgAo0iVnMjbXEGVWAgpWVKdUsbYAeP/+2KccJoBHuZssBbzQDXE3C+ntL1BUM0CX0TJm0CIjIWuekrH/mn6h5hXGOOOlp3TGHZjwGEmp6eqPaQlh7rUhlNRyAwb0f5dwRwImLuYWLQ8DwQEbc0ckC5/xgXLOEcOOkDtQ/emFbvbFviwvlSug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QXwgTfMZMuPmz4C2/6+7dvZySN+hevW/O6eSpS4yiPA=;
 b=gxvkuQo5bpxq0BvE+uewuBnT9zALJcbWUeqdjiJF6c5WEbRbWWcBz3GmMcuDpn6+mqInRKq7b0OKPUmjDtsezK8uyxUfDl5Any1xEvcFs8SASjsNsAGgyP1Doj9exw1coSdR4n8OZvdy5gs77CddK5Q+lfSSj0C6gA8nkajgF6UtsQRabz4nYdolggGaotPA6Ah+Kyetwvmw8I0LF0bu57AYRqxFCEkLXArCO3QUUcWoQb8KMaQ74Gks1stEdaz0S9/Pdb3ziLU6mgySx/aF1hx4oL5jY1y9OfpxEakwD23DCgTST9zot4WxTz4W431GomOIolY0Cl0PNNsi9xz1KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QXwgTfMZMuPmz4C2/6+7dvZySN+hevW/O6eSpS4yiPA=;
 b=00vVZAULiysuWbkU6kpn1ffkdvhDDFGNXSHLVrZ04sZTj8igfm2pAOGuIQgvCD02COVWUpCQLjejaw/BYJe1oie0NnBUa2bVjOl7OS73/OQr8Qq/bXPZAr66qJxHrZVn1x8dWdZVzblagJ5FYe2rXJ/neaxW+s2HPxaASDPyoEc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by IA1PR12MB6257.namprd12.prod.outlook.com (2603:10b6:208:3e7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 03:51:10 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 03:51:10 +0000
Message-ID: <085b6901-d6cd-47a6-897a-c549276c1e94@amd.com>
Date: Mon, 23 Mar 2026 09:21:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: guard atom_context in devcoredump VBIOS dump
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260323030606.381915-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260323030606.381915-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0193.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1aa::7) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|IA1PR12MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: a400c578-0156-4943-8906-08de888f6bb4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6/wT1raZk4YO4c2cUyLEADMQvUGcjI2RQ3xXPC7S3dPS/l+1E21pkZoYoMxCxcdIhdzqfwoVNdmWqdsLmADNOzUxlZbGr1jodjgkW+VGqP4LBb3CFzF3/77MaUy9z1eNuqBHNMPEFcfW1Wh9IpIQqZKlZju+RcoTeYp+jjZo8es4A+WrqerbPXAo3Eogf2d1iiB7Nb1cqW7lujHQxDuLyrxq28EXkOSKNCXeJbisTZcZzNgwNfhFz4PaIEsjpVjW1pwCipQgpmGz3FEoR5no6+imVlEiABxCKqt062h9rQWaMH/VihmRIlGpuSCPfGp/pAfqhelBvt/XeUPNyP+eUVeq6EokQl3ZxkRdcHcB/2dH0mCRuXxZ8G9wafDAhuYJUdIl0OllmNbmsh8g8B282bw5WSdElv4eShVo06bvLlChZS0kh7qk8afGF9eLoFjh1hTZBhLw9GaUE2GuE2pTltNcyuMQkDeb7aYAChL0wFHYaeKxfHdYV8ixOWzyl5SwwrhK1K8Qd1yztAdX5uxnPZmliX9XRN6HXLu5cwUgauKk1v8VTyx0wi+lTjBCgQaFsTnTKj2mA3WSb/E3w2YZMHJQaNvO8ztJY5Rpd09ynoyXJlPsPz6za7+BG6ROdGzy+1vg4T4x4KdWxOOoSZN06B5vMTfQq1SOvPy0Cz0ktTpny93FHVc2uNPAvzjDLH/4AM5FRubSsVS3srte/ljxA8jUqF1IAEGN3FIge1t3GPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDJ1eitobkJwMUhLZ3ErSnk0S0N0VFRvNlRwenlrNHRuM25nMVc2bkNpWHNC?=
 =?utf-8?B?Vm00RktOZFhDZU9XNklrMURLM2UrTUI2T1hudFVhVll4RW96eWJraHh0V0w4?=
 =?utf-8?B?Tncyd3JOMVlvd0o3cjc2M29WQXhlMktjMVVXUzk5aC9POWZ3TkJhdzR5REto?=
 =?utf-8?B?eGdCMlBQc0N1bzFBT2ZmTEdQck50NHZjeTk1SThJUTd6QUs2M3lNWTg0UjB3?=
 =?utf-8?B?bkxVRDJGaGFnQ2RJQ3dYZmg2YkEwbnVQMEg0eVdCb3BONDNPUC9ZVjM4b2FR?=
 =?utf-8?B?MTBId2lTNU5mNU5oRXVLYlQwZE15TjRvYmZCY2NRMUlLeEhjSFI5L3ZqdlYr?=
 =?utf-8?B?YmlqelZSU1BaL2NGeUc1NXZxVVFqMVlmMFNrMlhGVEJSSS9Fb0pVc2E5MkR1?=
 =?utf-8?B?aXBSVUxKWlNwUTZXcnJaSkszdWEycHZMUUgzdGpOWjRBTnB3TWR1d0NIZW9N?=
 =?utf-8?B?Qlg4SysycmJKYmN6ZnNTOUsvRVpRbGpTaks2Z28wWWNXZUZNSEJrWndQc3pE?=
 =?utf-8?B?bWtsQmcrRXgwZ3pJa0hreWNFTUVoU20vWGNxS0NudlVYbWhsU3FBdkZ6SUxS?=
 =?utf-8?B?ZE8yTU9UZFUrclhDNkJ6ckdqMHg2cDFWdjlPdWU5T1FjYkUrR0FzVnNHeHZU?=
 =?utf-8?B?cVZLZmJWZ2IwaFVqcVFlUHVjODB1WjlkbW9CajhyTTRLMlYrNkpyL0M3T3U5?=
 =?utf-8?B?alYweVNBYmUrOTdCeXpjeTNJaitWdkpBNjhEclFWdFIzT3NRN0dIRXpZdlVi?=
 =?utf-8?B?blJpQWpNdzFoYnYwZGVUUElWa0ZQTzJWQXRzSkZLaXBkUGoySDJhZmpKWGVL?=
 =?utf-8?B?ME9xQlNCWFlIcjR0aEFic1V4M3pQaFR0ZzFLV2paZllJSHg0NTR6ckFsWmk1?=
 =?utf-8?B?RTBBMC9ycXR6eko5azk3Q1dIR0o1WjVQcVZIdGlkMjRkTzNGbExKRXVyOGE4?=
 =?utf-8?B?RjhaS3AvbjRYd255NFRPU3dzMFo5dHRpMWJYVXRIeWFjMlh1MnRiUjlDZmJO?=
 =?utf-8?B?QlZnVllBa1VFM1ZCTkJqTG43UnZieERGS1M2SnNxUmMyQ080NmF5UmFzZHlp?=
 =?utf-8?B?bzZxRjA0MUJKTjUxL3dxRVpycWp0SC9IbU9kTEZJZFVHNEhnZU9BcktpOTJG?=
 =?utf-8?B?OHFxMVF0NHZralNnb2k4aTVhSWZ3MHYyd2ZYSEdCQmEyRmNtNE5WeXIvc3ZM?=
 =?utf-8?B?UXdaK0JCWS8vNURHWlVCL2R1Q2hPWS91SFNTQjBBOFNrOXZYMmdVaWsxS3ZW?=
 =?utf-8?B?aXY2SllucCs1N0Z0ZzJpZ0x5Q1M1dVU4Z2xscHJ2TmVtKzB5QUtKTnY0QVFn?=
 =?utf-8?B?eTZxUnNueGhlZTZZVnZYbUdoUks5S3JyYVhrVzlBa25JVEovbzRJUEwvZ044?=
 =?utf-8?B?MDdlODJNK3BQS1Yxb2UycityWmdTZWFkdDhMc0g0UWJGZDB4N1ZObW5WN3N2?=
 =?utf-8?B?YThnVHZTTkVPL3RCSHc0ZDFuZzFtclA4M0tDWWRpSWxwcTNkK3BuZjE0a21r?=
 =?utf-8?B?TFJONUh2bnZBWXBLbVQxNWN5YVBWVWRKbEdWZkQ3ZWxFMWgwSzkvYW1Lc0ht?=
 =?utf-8?B?cEx2V2s2WUJDVzA1VXhnUnlybG5ORGpjbWJia1VpQktFWUlFOWc4dHpMUTFk?=
 =?utf-8?B?cXlnUUNWWnBLZ3pNWURyYVoyOEZxdEhiM1Q4eWY2dEpaSWxnOCtuOFdMYTJl?=
 =?utf-8?B?TVEvTXI0UVZtN2lVQUZRNGZ3R1M4cmZHRWlSNXFsVUVRZHM0VjhDRnhhRTla?=
 =?utf-8?B?ZHFyTC9YZy8vbXpvUGcwK3JYY0NVYUVTU1dGczZXVUNmb0E1S090K2p3Q1JF?=
 =?utf-8?B?Sld6aUlIUThVSTR6ZE1TK1B4c2hSTVEvSWVsY0t4c1JMY1lEU3pLTUx1MG9Y?=
 =?utf-8?B?L0JYdG5leWpXL3hRS2N2dkQvTGFLanJFaFpKSEttdy94N0w5M1REaVQ2Wkhz?=
 =?utf-8?B?SUpNWmxjdE0zNmlSc2hwc2R0MmhNUnh4Q25LZ2lkWVc2SFBkbVl1dWJJUCtD?=
 =?utf-8?B?eVEyRm54dmpPTml2RmdCQ3RJUlIxbG4vTHdDTzdDaXFneDU4cWY0bkxQR3dC?=
 =?utf-8?B?T2M4cmhxVThpS0NoMVNoQU0wV2Z2emM1Y01OaEtJVW9sS2QxU2F4c1dTZ01X?=
 =?utf-8?B?V1NXUGJ0aGpGZGs4OHJTNDdsSHJVWXRtSU5tREtVOFVlQ2FYV250cWpNZkNL?=
 =?utf-8?B?Q0llVTR6QW5od2ZWR1FVVE54QS9pMDdOMjdaZFQrVS9FZGtlbEtrTUFaakZv?=
 =?utf-8?B?Z0dQQTFpcHRPcTNlNGdIbnVRVmxrQ29hMWU0RHp5SCtva1pPMGlWMHE0SzRQ?=
 =?utf-8?B?QkQvK1M0aFNsaGcxNElnMlFOYWNvVnVycHhZdFcwd2VDR3A2R3B4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a400c578-0156-4943-8906-08de888f6bb4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 03:51:10.5255 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hcKfyYOgkq3/GWZ7XCEd3BogSsbROo4UunXd32k3qNdSzv1TvZwgc/kzGzz11SvS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6257
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



On 23-Mar-26 8:36 AM, Jesse.Zhang wrote:
> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
> dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
> paths this pointer can be NULL, causing a kernel page fault from the deferred
> coredump workqueue.
> 
> Fix by checking ctx before printing VBIOS fields:
> 
> if ctx is valid, print full VBIOS information as before;
> otherwise print a fallback line:
> vbios info       : unavailable (atom_context is NULL).
> This prevents NULL-dereference crashes while preserving coredump output.
> 
> Observed page fault log:
> [  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
> [  667.941517] amdgpu 0002:01:00.0: Dumping IP State
> [  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96 7a
> [  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
> [  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 0000000000000000
> [  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 000000000000a999
> [  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085
> [  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 00000000000048e0
> [  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
> [  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 0000000000000000
> [  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) knlGS:0000000000000000
> [  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file has been created
> [  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 0000000000770ef0
> [  668.008035] PKRU: 55555554
> [  668.008040] Call Trace:
> [  668.008045]  <TASK>
> [  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/card16/device/devcoredump/data
> [  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
> [  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
> [  668.031950] amdgpu 0003:01:00.0: Dumping IP State
> [  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
> [  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
> [  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
> [  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been created
> [  668.095863]  process_scheduled_works+0xa6/0x420
> [  668.095880]  worker_thread+0x12a/0x270
> [  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/card24/device/devcoredump/data
> [  668.107441]  kthread+0x10d/0x230
> [  668.107451]  ? __pfx_worker_thread+0x10/0x10
> [  668.107458]  ? __pfx_kthread+0x10/0x10
> [  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, signaled seq=9, emitted seq=10
> [  668.118630]  ret_from_fork+0x17c/0x1f0
> [  668.118640]  ? __pfx_kthread+0x10/0x10
> [  668.118647]  ret_from_fork_asm+0x1a/0x30
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index bbb5afd67b49..7896ddf46ae0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> @@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
>   	drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
>   		   adev->vpe.feature_version, adev->vpe.fw_version);
>   
> -	drm_printf(p, "\nVBIOS Information\n");
> -	drm_printf(p, "vbios name       : %s\n", ctx->name);
> -	drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> -	drm_printf(p, "vbios version    : %d\n", ctx->version);
> -	drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> -	drm_printf(p, "vbios date       : %s\n", ctx->date);
> +	if (ctx) {
> +		drm_printf(p, "\nVBIOS Information\n");
> +		drm_printf(p, "vbios name       : %s\n", ctx->name);
> +		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> +		drm_printf(p, "vbios version    : %d\n", ctx->version);
> +		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> +		drm_printf(p, "vbios date       : %s\n", ctx->date);
> +	} else {
> +		drm_printf(p, "vbios info       : unavailable (atom_context is NULL)\n");

There are platforms where vbios image is not available. For this to be 
really treated as an error case, you may also check !adev->bios (which 
is not an error case). Otherwise, skip the print altogether.

Thanks,
Lijo

> +	}
>   }
>   
>   static ssize_t

