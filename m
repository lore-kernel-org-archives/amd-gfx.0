Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E44551088E70
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 04:15:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B46D10E851;
	Thu, 19 Mar 2026 04:15:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pQNuS3XQ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011013.outbound.protection.outlook.com [52.101.57.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F3E310E851
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 04:15:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZnxYJzJoraBtrHyfG1dJgSXybwlUtttGAtUglwgPQRTH+I6NZFJ/YAxPVSkgdcJf1YbKyAeF6yGSGdLAt/kbZ0mZp4TPV6Mf+rrFX70ndMj0YnrDqqFAeVkFfCaTsLne9gVGn6LbX17LLrNwalRnr93nLbjjGjPD7xqwpIgDLTYGg3fEOdq8cFZDhsiK4+K/h8qJ2OeK2F6i+55prCjLO/fJM3qMS7j3x+n4IEU3EOQ6tHhFrxGb3TqBtSssyWBCp0U/aSLUvBs4yGb2NRYkAusbnFtzBy3h0BcU9k1OfoWinXOZS7gsUT/f7AHFYrZ6wc1C1DJOg6LLFLx+G5lCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxcv0+t244DlTiNo9T9s2N1M3DtfAG6HiKFzHr0r4jQ=;
 b=UAMm19QekQBeQ88EcxtcVmuCnLRi1f3g00EJ6smGtoym+MXLkCW23M3APkMnKudd7le88jo39D45ue2olaP2JJgG5Cn9Uv+6flST27oVukIqYBvcctH44PKF4aoGuESO7nDFn72NFaKHPMgEgE/XfDCFP4M9lX9i5x3KG3lKU8GuoBr1HgmbpUzLpj5yTZGIo/NPM86s3SoCFSLxfLEPNFQzNOJ/iFtZ3AHWLzQdLUDrU6PGeXuWkEf9EOOyaQFm5cdj60btG+rTXdT3KMRY+BgDVQsrce3x+arpb9TCit6i8k1pb3THAeNnHcmfW9mss3C8vEMWGk2Ny3YoPkUExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxcv0+t244DlTiNo9T9s2N1M3DtfAG6HiKFzHr0r4jQ=;
 b=pQNuS3XQqXf/I2aoKQO+QCJr2PfWyBWBjRM0ThroVEK10qXLs2AosJPQvkoPtAav8QFLkxaVlb7QJUnvKGjdkQF5qkilwcYWzbXA9rX+phSPtm7e2Z2l8J+DXHzoU4l/J4kdn80esB6GvRuOxWigtNkWKxgB5w/MA/pDgvw24hw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Thu, 19 Mar
 2026 04:15:37 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 04:15:36 +0000
Message-ID: <01fbbf0b-72ba-4df9-a3cc-d0bce429a5be@amd.com>
Date: Thu, 19 Mar 2026 09:45:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
 topology coredump path v3
To: "SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>
References: <20260318103059.1976682-1-srinivasan.shanmugam@amd.com>
 <edc9d882-76f3-4d1a-a9a5-698752984716@amd.com>
 <IA0PR12MB8208A7A18B8626B723B2D5FD904EA@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <IA0PR12MB8208A7A18B8626B723B2D5FD904EA@IA0PR12MB8208.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4P287CA0105.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:276::8) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: 57efd703-06c6-48fe-93dc-08de856e2bdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: v98vaLXcg6UKuYQ0kYI1D9ZrM34fqHt5/dRAwtFtv1xpYkNBmYf4T/PIzFhYMPZIvPMNJ6x0i3tsytWuDEoJOfl5jepYvK75rqYh4dk2mCYgSkcbGKA7pc1yqwJZdO1YxKnyXAcl3980KF0B+94JF9H8Hevx22tdRTu8lkhrwWgEeHw/hvIWdaYHfOo6LMGUgOLkuRGDBdWEiJrgCOTK4lPD+UWbRNlo+0XokW9SoRXYKQK48BzUydu9m4CIex/JOGtpHetF170NoL+q6jxPMpnbNHxzyI//C5sr45+LCyYFZTTDdsP33CMgVRsCuvY7qty+NuFUcPQLkb0j9cSPiMtAVqWoVUf4PlrqM8mD2RI7KIWoI+Vt9EOaJfj5g2F1SPkfwFajHGd2xgWvMpx/XRQ/llsH2kZabozICKzd9bwjApMYYz8Q3oXVztrKnzl+Hj+ZNAVKYJvG0IB+kA0bnD8poR+JM+PtDd93Zk2u2epF7y5r93kzV+gY5ZcnK73RO4s9j8gs1ZAALKmtGIU68EvbWJYpu8fCZwfYJXDhuZ4wVMvPDpUZ15J2lr8mgHcj62jOn8bHIh8Xow8wFBfJ2TqC6zS1TkGsq5rb6WpJvTdlxzZcMpU3TYp4bXColdO9sbOE0a86Qde0QnPNZWgMALbiglNLptGTz+tINt+7G/gOsOsZmPE71Uhn6R9ZZMWoiRggC6P+mIkzFbgdep7CYiBZ6HjmLkxo7VNB07paS7g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmpzN3pkajlXd2pzVDUzeWtRTnMvNzh2Y0ZVYjlFKzV6RDNKZDdXOU1YOFFr?=
 =?utf-8?B?TlJ4RWhsN1VXQ3ZsMjBiUVVRcjVRTmQweHhyWFBqOWp0dnA5YTFobG12aWlT?=
 =?utf-8?B?NlFKYXNqUXVneWsyNVFUTEgyQm9HZ05nd3FWNWxUNDRvQ3hjWmhyenVGbGNh?=
 =?utf-8?B?aERvNU1FanM0NUx5Tk9RSjUzdER4N1UyaVFqV3ZqOGt1YWQyT0NrcFZCNGlS?=
 =?utf-8?B?WnFkZ0pCQ21OTC9WdEJwY2Q2YlpzRkJmcExCU3pTNWRVUlFrNSt1RWNPUlEr?=
 =?utf-8?B?akFMV3FjZC9JR0hFdC9hNUJNWlBzK01HTWVrekl1ckRvVlVJMHdIaVpva0lO?=
 =?utf-8?B?NVRILzRrcDFOWklyOEkzT3F0UTRZU0c1OE01OEdQaTVGdXBJeXpRTS9mN1BP?=
 =?utf-8?B?M1pmUDd1NEFVN1VKV3dyTW1iQXhMd0F5SzZsalF1blRQOEVxSjZMM1lTbXdn?=
 =?utf-8?B?QjlaZjJsWC9yVWxNQzZBQ1ZBMTVycWNySktsc21JdXlYSjFNSWtZUGxpRC81?=
 =?utf-8?B?bXJXNGVRRklUdkVvYlhNLzZFaHl6UE9WNUp1RVdtREZuL3JzT0NnNnRDYmpL?=
 =?utf-8?B?YWh5Q0paem1QU3dHRGptVVFHdEZjNTgvaXhKS0JkdU40U1FJK3QzOFZmQzdq?=
 =?utf-8?B?WkFoeUV5OVJIdW8zVnhyL1YxUHpvS3o3LzlVdHpJQmRjVjdrZXp4YXhJMm1v?=
 =?utf-8?B?LzZ3dHBNemFlbzc3dkZBOVpJUENHZ0JOK2Z3aVYrUGQxRTh0MDRTWDVuN0JT?=
 =?utf-8?B?RDFHZUtHR0l1bndKWHQ5dUdOVHJNVmpoeGJJcko4SmFqcHZlVjZWTjNOR1hl?=
 =?utf-8?B?SStNR1Fwd0FSMytwTkpDTW5ROVhKZm9FMkZObHl6STdEUVJZbkc2eTZzOGZU?=
 =?utf-8?B?T2hUbU1XOUpqZE16NmJHcVRpMU9LRUFRNlRkZFN5OHcvODZiZjFRb2ZlYzlP?=
 =?utf-8?B?bkhKUHVlTk5vME1oY2pBY08xQURUWk1DUG9QdDd0TGVMTzVydWIxQ0lEczls?=
 =?utf-8?B?bTY3RzJRMWV5UWZaZDZaRFlBOXdjcGxxVmdhM2lPRjk3anRpQjJDL3RsWFov?=
 =?utf-8?B?WXB5UnB3M21JT0txRmVYalhFTWZod0UvYm83d1pKbjZ6c1NqM04rUHNaRm1a?=
 =?utf-8?B?S0IxSXM4bFdqa0JUTnVVLytIU1EwU0tXdUllOTZnRStDWVRRQmRJWHk4Mmo4?=
 =?utf-8?B?QmN1bjVESjd5OUR5dnpUVEhvK3RkUlZKajVqa1pKK2htR0pOaS9IaUxLRFM1?=
 =?utf-8?B?Y09VdXI3UWxMTHNidGZLQm9xTUU2REE4MDNERUp0NDZ1WVVKVFNUL0VNUmNL?=
 =?utf-8?B?VGlrMGpkU0p4WUhGb0IzbkxmSHdWNWVFWGFDY21mVVovQUcvcnhIUU9hRlhx?=
 =?utf-8?B?VTU2MmIyOXc5NStwVmJ5NmhZTzljWXFiSVRBcHJRUlZoSVM2M1EzSVIwVmRC?=
 =?utf-8?B?bDVnVFE3MHdFQXZJUlcxYTZzVFBvQTBEek5yZHNnMnR6MVBZSzN3Q0w4c0xJ?=
 =?utf-8?B?TTN5WXpRUXIrMVZxNVV0bHQ0KzdIeFBmbTV0dGRWNjNQZENFN0xaMW9lVmor?=
 =?utf-8?B?VTJPY3BCYkJvZkRhTCt4Vy93Sk9MbjNZNHpvVnkrVEhzYUMxU2xwdzA1MGcy?=
 =?utf-8?B?Y2Vmb2JPcVRJbVMxeEdJTkVjdVFmZVBENExYOWM2K1AyY3NrUzUxR0xJajlk?=
 =?utf-8?B?dTZ2ZVFob0xMSDZmTk03UFFpeFd6L2F1UnFBc2ZPcUNpaXRDWFZDMCs4L0pJ?=
 =?utf-8?B?cFF1aXQ1QWNJZno0YmRNQ3pKTStoNFRyTkU0ejMyWnRKQmJJTHErdXRLbkth?=
 =?utf-8?B?d0hHT0h2cVJWRzM1d29MNEx2WDBTVm02NjNveUZsaW5Mc0RPaGdMd0ZHVm0y?=
 =?utf-8?B?TXFNMm1BM3BuSHFXV01Za0ovZDlqb3BJdC92bzFaN3Jpa3creEZja3pMb0xW?=
 =?utf-8?B?bDlwUk5WVzl6QzhVU2xyV0xFd3pJTDZreVFtL2RUVXV6REEyQzh2V3lmbThN?=
 =?utf-8?B?dkh4TFVpYUFyVS9tL2x5SHVCdGhPeEZ4V2dPR3hUZXFBeXF4anBTVkhDUy8v?=
 =?utf-8?B?cEFvVnkyanh1aGpGYWJvNXQrV3NWU0NOY1dkRncrVXJRR2ZTR3FKanZoaXRs?=
 =?utf-8?B?UnlTYW1LY1dLendEeUQ0MVpybGpjM3AzdGI5OVdmZ3dXNk5uK3NhMzJlTnho?=
 =?utf-8?B?ck9XTkhRQkFobFQwd1JRdnphY0t3Z2tKcHVOK0tHcnZDT0N0aXlQdFhiemJK?=
 =?utf-8?B?WjRZcTBhSjNhVkJBNFZ6dk1OUjRYQ2VrR2plekdzYjh5YlNWYllKREpsUDRU?=
 =?utf-8?B?YWJaaW9XeTBnbFVFK3VocTdWWUEvTGR1VEpGbFZqdjFDOG1vcnBCQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57efd703-06c6-48fe-93dc-08de856e2bdd
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 04:15:36.6811 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wfvPPOhyS8NaMis8pIGT9PBhLE5gw+OETqBnp2yXUzgkw/a5ddAM9lXYlVPEspTv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320
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



On 18-Mar-26 4:41 PM, SHANMUGAM, SRINIVASAN wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Wednesday, March 18, 2026 4:28 PM
>> To: SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
>> Koenig, Christian <Christian.Koenig@amd.com>; Deucher, Alexander
>> <Alexander.Deucher@amd.com>
>> Cc: amd-gfx@lists.freedesktop.org; Pelloux-Prayer, Pierre-Eric <Pierre-
>> eric.Pelloux-prayer@amd.com>
>> Subject: Re: [PATCH v3] drm/amdgpu: Avoid NULL dereference in discovery
>> topology coredump path v3
>>
>>
>>
>> On 18-Mar-26 4:00 PM, Srinivasan Shanmugam wrote:
>>> When a GPU fault or timeout happens, the driver creates a devcoredump
>>> to collect debug information.
>>>
>>> During this, amdgpu_devcoredump_format() calls
>>> amdgpu_discovery_dump() to print IP discovery data.
>>>
>>> amdgpu_discovery_dump() uses:
>>>     adev->discovery.ip_top
>>>
>>> and then accesses:
>>>     ip_top->die_kset
>>>
>>> amdgpu_discovery_dump() uses adev->discovery.ip_top. However, ip_top
>>> may be NULL if the discovery topology was never initialized.
>>>
>>> The current code does not check for this before using ip_top. As a
>>> result, when ip_top is NULL, the coredump worker crashes while taking
>>> the spinlock for ip_top->die_kset.
>>>
>>> Fix this by checking for a missing ip_top before walking the discovery
>>> topology. If it is unavailable, print a short message in the dump and
>>> return safely.
>>>
>>> - If ip_top is NULL, print a message and skip the dump
>>> - Also add the same check in the cleanup path
>>>
>>> This makes the coredump and cleanup paths safe even when the discovery
>>> topology is not available.
>>>
>>> KASAN trace:
>>> [  522.228252] [IGT] amd_deadlock: starting subtest
>>> amdgpu-deadlock-sdma [  522.240681] [IGT] amd_deadlock: starting
>>> dynamic subtest amdgpu-deadlock-sdma
>>>
>>> ...
>>>
>>> [  522.952317] Write of size 4 at addr 0000000000000050 by task
>>> kworker/u129:5/5434 [  522.937526] BUG: KASAN: null-ptr-deref in
>>> _raw_spin_lock+0x66/0xc0 [  522.967659] Workqueue: events_unbound
>>> amdgpu_devcoredump_deferred_work [amdgpu]
>>>
>>> ...
>>>
>>> [  522.969445] Call Trace:
>>> [  522.969508]  _raw_spin_lock+0x66/0xc0 [  522.969518]  ?
>>> __pfx__raw_spin_lock+0x10/0x10 [  522.969534]
>>> amdgpu_discovery_dump+0x61/0x530 [amdgpu] [  522.971346]  ?
>>> pick_next_task_fair+0x3f6/0x1c60 [  522.971363]
>>> amdgpu_devcoredump_format+0x84f/0x26f0 [amdgpu] [  522.973188]  ?
>>> __pfx_amdgpu_devcoredump_format+0x10/0x10 [amdgpu] [  522.975012]  ?
>>> psi_task_switch+0x2b5/0x9b0 [  522.975027]  ?
>>> __pfx___drm_printfn_coredump+0x10/0x10 [drm] [  522.975198]  ?
>>> __pfx___drm_puts_coredump+0x10/0x10 [drm] [  522.975366]  ?
>>> __schedule+0x113c/0x38d0 [  522.975381]
>>> amdgpu_devcoredump_deferred_work+0x4c/0x1f0 [amdgpu]
>>>
>>> v2: Updated commit message - Clarified that ip_top is not freed, it can
>>>       just be NULL if discovery was not initialized. (Christian/Lijo)
>>>
>>> v3: Removed the extra drm_warn() for sysfs init failure as sysfs already
>>>       reports errors. (Christian)
>>>
>>> Fixes: 7083eb8982fb ("drm/amdgpu: include ip discovery data in
>>> devcoredump")
>>> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
>>> Cc: Christian König <christian.koenig@amd.com>
>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 11 ++++++++++-
>>>    1 file changed, 10 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> index f7f37d93d0ce..6be1f971a31a 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
>>> @@ -1395,6 +1395,9 @@ static void amdgpu_discovery_sysfs_fini(struct
>> amdgpu_device *adev)
>>>      struct list_head *el, *tmp;
>>>      struct kset *die_kset;
>>>
>>> +   if (!ip_top)
>>> +           return;
>>> +
>>>      die_kset = &ip_top->die_kset;
>>>      spin_lock(&die_kset->list_lock);
>>>      list_for_each_prev_safe(el, tmp, &die_kset->list) { @@ -1419,9
>>> +1422,15 @@ void amdgpu_discovery_dump(struct amdgpu_device *adev,
>> struct drm_printer *p)
>>>      struct ip_hw_instance *ip_inst;
>>>      int i = 0, j;
>>>
>>> +   drm_printf(p, "\nHW IP Discovery\n");
>>> +
>>> +   if (!ip_top) {
>>> +           drm_printf(p, "ip discovery topology unavailable\n");
>>
>> Is this type of printing really required or just skipping the whole section good
>> enough?
> 
> 
> Silently skipping the rest may look like incomplete or missing data in the
> coredump.
> 
> Adding a one-line message makes it clear that the topology was not
> available, rather than leaving an empty section.
> 

Here is my take - Discovery is the basic requirement for SOCs which make 
use of that mechanism and it is always expected to be present for those, 
otherwise driver load will fail.

For those which don't make use of discovery, the section will not be 
present. There is no special message required for that. There is no harm 
to keep that, it only adds extra parsing.

Thanks,
Lijo

> Best regards,
> Srini
> 
>>
>> Thanks,
>> Lijo
>>
>>> +           return;
>>> +   }
>>> +
>>>      die_kset = &ip_top->die_kset;
>>>
>>> -   drm_printf(p, "\nHW IP Discovery\n");
>>>      spin_lock(&die_kset->list_lock);
>>>      list_for_each(el_die, &die_kset->list) {
>>>              drm_printf(p, "die %d\n", i++);
> 

