Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5FF9F532D4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 06:38:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3522110E29F;
	Tue, 24 Mar 2026 06:38:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vve5xQD1";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B0FE10E29F
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:37:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xAJfvI2XjCeoP35t/P7iHx7pF0rMne9V4wiXqgA5GlciAuTrijxGgLAe/2Aq4qQB18i8mOkgeRy8/acdp3mvncSBqw8mvptKYFzBtrTiIQLTnSKiQjy7F5myYUwA9yMhAdYkUoMpVFMvbpilXxK244hfTYUhkI52dVEdHg4ZgPhq3gM84ljI7W5iJlWvY24JRfmCapODG/RxfRmhoGH/HagpwqRqMliQ2gFlyU+b98OLKU+74CIkgPUPtjn4U6Ka0r+Xufcw3WnL3c7gUD644vwWDkMbKUaleKaZCPTJ9JG8NftFAN+m3Osx4KCdGmHDcPy7mHku9h1SJ8pEnzlnIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+GpVY+9KR2W0DvAcQ7th2b3tL4mtCpjD51TjvYK5qU=;
 b=OiXOVYQIeRzOswS9hDJg/OEOrWMf797ibiZJgSzIr8N3MIpigZ5t0Sg3iUhjQwoiB421uHFrzyupWrSjz8hNWmY+1zhl4APrcEHxObvGV2jYJ84tS+zM0aMicMgTySDnJvgDyGLSCaVt4h/S9HJlf06I6aOQXf5VAIfOTc5wJmtWYk9K7/Y4xZkJLMbM0CHjGhvEJVQsvTw+gKui5krF7VMZn+d1s1i4FKP/uAvDuHSQUSDUB0SRFf9Ibm6SvkatB7xiMvF02vWlwiZOgWNUREY0rjWRP3rDJLGEA22glULRInOSo9XFsX3WgOcctbAaHuN/9ixVSzSCURufRtamHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+GpVY+9KR2W0DvAcQ7th2b3tL4mtCpjD51TjvYK5qU=;
 b=Vve5xQD1PLwNHIFWyIMq6TyUGaXOKmk+2OGCGiH6f6wCvZdQhz8HCBWYI++/Ky3ViipMUYCx06Qu4nnJm8FveZSB2njiIUcwoS5bpIW8zDRwNVXvRI+ymYJldq5BENxQActjKiZVu9glTt2zTZjQZ9/JsAEG1u1I8BuSmJlIYD8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by CY8PR12MB7122.namprd12.prod.outlook.com (2603:10b6:930:61::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 06:37:56 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 06:37:56 +0000
Message-ID: <166b70d9-3049-4c69-b8cc-7863238e9617@amd.com>
Date: Tue, 24 Mar 2026 12:07:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>
References: <20260324012618.626710-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260324012618.626710-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0102.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d4::6) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|CY8PR12MB7122:EE_
X-MS-Office365-Filtering-Correlation-Id: 555e9437-fab8-4703-9123-08de896fe20d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: sJx4WrNDJ0Yb6hCRTAlgA4JV8wuKWnYEjBvhAKPrAAHV6Szujh1e4gfLcRhTRSzhq36UzW4sv9VrK0Qc2M1gLwUczxuIUGg/J0YoQenODMZIOYz5Q9ZV3br9eDMrvAev9gNsARTqj9lENtUtpcVHIBMkWXHEyUlwLmRsAzm6C/jzUpmIDaGJWh9UQolhLtMF8O+qM8cTyH0JGF9qFqOpME/o1V8J66BnOQw8aCN1goaGVyiS/XUXOheTAXUHYF7vXvPUqIcOYrpe7qh6z0k8csRK6s82hx+75raxmzlcO9rnjs3yMymCuMrtIUTegHlKAolC4Bjis8b5kEjj8+pCdJsaGF5UcNriFG4UFcfnee2qegIFYzFrCvsA8wATucAm75yGlDBB+Xj1ewApxcUD6ruwYkTUkS/vi909l5cvChnkZY+IoPGVsZx3uZfATWwCLrvrb+R3MMatJMXDVHFKX5lsOxtJOnWydMW/0tcDCYytMxwarWHbC5nft5EBjk0TOO/VNnSN27MQ/U9jXfSq7Yih2QT8hDJZCoL0G818akOLo4JCQbi9yNGrtq4YZ29o/8Vtp7Xytfx7uwuiS/f+kFdTpBoSujW+L7hopBuu08H/uHyTW8HJj7QabkT+uMSXXRuT7wzSW+3MhKdPU3XGVBrvQXHfry6/DIVON+wMflHCCjrnd3wB3AH0MpjsIiNyXf5FW+zUu3fbLMRV1l+VbkKPl310f5bFiDZZNVL5sMQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0pLY2FxelB5SXBMbGNHY004NTNpMHpzU2hGV0QvZStZVFBBeTg4ZGRzc1BN?=
 =?utf-8?B?NitMdVZnMGFIaXNVSis3K1pPVDl4Zkh1d0NVKzFOUGR6Y0RPVTVGbWxON0ZT?=
 =?utf-8?B?eTcvZTlGZnVnNHpSeDF0NjZpRTZaS0ZvTTd0N295aGN0WElUaDlOcWsvVWR1?=
 =?utf-8?B?cERGd2lZRUN6WWhOODNsZ1NNVWV4Y2dodzBFRk94L2hDdW9sSjRmMXpZcXUr?=
 =?utf-8?B?V09QUTBaTDNtbWRzc1hFK2o5VndNd3lWUktwUlFWb2RkWjFOMnJMWUhBMWpm?=
 =?utf-8?B?V2lrVDYwbjlwaGhra0JNd2NXcFhucU1hcFB2a3p6QUw4bEM2bVhWcWV6aUVP?=
 =?utf-8?B?b1hvSGZJYmJoeTl5eENKOW9kQlpkQlJTMWp0TzNNeEN6U2dpUXVCcm54UFdV?=
 =?utf-8?B?cXF2c21MVDZJWTdkdmhRL3pQZ1JXOHRqRzBNTm5HY2ttS05XOXo4MjdvZDVB?=
 =?utf-8?B?WVp5N3dVc1FsOVBYL2Zmbk8wZjFyY3d1YlJNcGFGTU5abDNwYlMzSmpsUUs2?=
 =?utf-8?B?OTNjaFFDSU9naDBwaGVPOTZ5MUtNb3dlMXZnZkhaTXVscmgxdVl2UzlMRlVH?=
 =?utf-8?B?SFc0L2JJSUo2QjVsNUNIcEgza1NVRzJYVW9IckRlYWVMSGxRYVRkQ2NpOXFZ?=
 =?utf-8?B?ZDBFVVF6aDBXOENydjFrZG1ydFJiMUI0TkQ4dXJ1ZEoreDBZanYvNHFCWjQy?=
 =?utf-8?B?V09MOXB1aTNQZFZ4dUI1T2I1aEM2aXorbUwwcTd6OCtwQjZ3SndZSXNFLzlC?=
 =?utf-8?B?ME9pblhkUDF3SlRjNWFOenFvcS9lV21yOXp5RUVaNlNKMm1xU2o3TDFhZTBn?=
 =?utf-8?B?UmRBbFhlcWU1Zzd2WmQzOWNielB4QkFyWi8zbGtlSFFyMDVaNnZVOVBUSUN5?=
 =?utf-8?B?K1J5VVNGRC9RU0diU3BTRUkwbFcxUXRKOTJ2UnZYcitvZnNoTGEyKzF4Z1VJ?=
 =?utf-8?B?OUtFOWQvR25sVFl0S013L2FhL1ZkSHR3ZmxnVGZFZ2h5bS8yZU9EL1Y4SmFs?=
 =?utf-8?B?dGJGV1lxcWhIdzhTQi9IMWczdFhoYXg5Q25zWUFpNW9McXpZdzNQdy9QTlo3?=
 =?utf-8?B?c2h2N2FNWnBpMjhWWk9aZUhBSVZSUUR0SHNkc0pIZW5oOW9FMzdHSXdwMnV1?=
 =?utf-8?B?ZWNvdGFybmRRL1dtbkluU2ZRcVo3MHdxSU9JK1ZmUnBOVUxJaHhaNEZJWFFK?=
 =?utf-8?B?MTUvZDBPVUs5YzZvNlB2ekNsRGY1azUxY1E2TU9aVHlOS3lWbDhZQ0p5U0ZU?=
 =?utf-8?B?RE9uZDN3T2V5bTNYV0ZvQ0VIZzFCVnhvUXVPZGVWQnNmaUtZQUJKbG5BV1Rh?=
 =?utf-8?B?WlZudkFiN0tUS1U3alJLM3p5ZTZRM0JuQWFLYlZNRUFnOEM4U2w1MXVEbkJZ?=
 =?utf-8?B?THMxOVhQcVFXYjR5Sm9QZCtWeDEzZFhkVzlYaHJxUGMxQmcxVENxRVh3R1RE?=
 =?utf-8?B?L3JpMFB0RC8rZ205NlFFekdsZmorN2Y5RVZTY2FQaWpYUEZWVkk2aHNXbmVY?=
 =?utf-8?B?L2VGZDNpMTlZdHBxRXlDb3ZYWU95a21LMHVObmptUUhLemhwZnhzWGt0aTNK?=
 =?utf-8?B?VDcrTU9nNkdEK2RvY3FUL2IvZjYwb1h5MTErbitHRUY3YlNtMTBkOXlpOHN1?=
 =?utf-8?B?Y0xGZi9qd1k0amxPQmd1Q3RQMnJuNkFPU084RVE1bndHK3NuT1Y2K2YzcVVa?=
 =?utf-8?B?R0ltVHM5cm5uZWFjQjNYeTR2QnZvMVVDdjhLVXN3Y3U0UDRFNDFpWSs0VkRu?=
 =?utf-8?B?V09nQnJoRHBWd0RXUGNSMGFhNEY1YjNXYUdlZXlJOStMUWFJbXpBL0wwSXVs?=
 =?utf-8?B?YnVvZEFtOTZ2aW5jTndEOXBuMUN2bVgvTjdTWTJFSXNRQUFnZUs2eHpqNmRl?=
 =?utf-8?B?RjF0MFRZaDVYbFNKK1JrYmZrbnFock1PeEZIT2x6V256dkovdzdvRXR5YnJ3?=
 =?utf-8?B?OWJqb1pueTQ2V2w1U0toTmVGdHI1QkoweWdGaHg2NG9kZ0hDVlFtSTE4c3BZ?=
 =?utf-8?B?R0JMeHczWkR3bndoZUZPWnkwOW5lUms1Uk12U2hwdEZmN2J1Y285ejRyMjVk?=
 =?utf-8?B?OWF5Qjcxc3FEemVxRmhsYWxjK3N0NENvWGlicjZNeitOang4eWNaeFJ3MnBK?=
 =?utf-8?B?dll1RlpXWHpZOWRJVVZzVCs2TURYNWhCdkZzSkUyVFFscUZWWEVQZE1hWlRo?=
 =?utf-8?B?T2dFNWNPWEV2eUV6c29nbHd2RlAvaUhZa2ZWWkhRRThCNXkzL3A1aHdyYWdl?=
 =?utf-8?B?WHdvdkV2WWhXdS80dUsrc3FCUGMvL0ZFeHYxVXcveFJkYWdSbW4vdktCbGYy?=
 =?utf-8?B?bkJWeHl2cWpQRVJWODhXeExQQ1djSGxTQWI3TmcrbVIyR3diRjlUdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555e9437-fab8-4703-9123-08de896fe20d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 06:37:56.3907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kzKth7TvcNOpS92Z0W540ISb4Ejg6ipv3+shumSGTooKvzD1doLl/HZFHXEZ6Vby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7122
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



On 24-Mar-26 6:56 AM, Jesse.Zhang wrote:
> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
> dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
> paths this pointer can be NULL, causing a kernel page fault from the deferred
> coredump workqueue.
> 
> Fix by checking ctx before printing VBIOS fields:
> 
> if ctx is valid, print full VBIOS information as before;
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
> v4: fix the race concern without introducing VBIOS snapshot state.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c       |  4 ++++
>   2 files changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> index bbb5afd67b49..5aa46480f05f 100644
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
> +	if (adev->bios) {
> +		drm_printf(p, "\nVBIOS Information\n");
> +		drm_printf(p, "vbios name       : %s\n", ctx->name);
> +		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
> +		drm_printf(p, "vbios version    : %d\n", ctx->version);
> +		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
> +		drm_printf(p, "vbios date       : %s\n", ctx->date);
> +	}else {
> +		drm_printf(p, "\nVBIOS Information: NA\n");
> +	}
>   }
>   
>   static ssize_t
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index fbe553c38583..69f4549e6271 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4260,6 +4260,10 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
>   	/* free i2c buses */
>   	amdgpu_i2c_fini(adev);
>   
> +#ifdef CONFIG_DEV_COREDUMP
> +	/* Make sure deferred coredump formatting is done before tearing down VBIOS/ATOM. */
> +	flush_work(&adev->coredump_work);

Looking further into coredump, it also prints different IP states. Then 
it needs to be finished in amdgpu_device_fini_hw before hw state tear-down.

BTW, suggest to keep the flush work as a separate patch since that is 
more related to proper handling of a deferred coredump work during 
unload. No-vbios problem is different from that and it can be a 
different patch.

Thanks,
Lijo

> +#endif
>   	if (adev->bios) {
>   		if (amdgpu_emu_mode != 1)
>   			amdgpu_atombios_fini(adev);

