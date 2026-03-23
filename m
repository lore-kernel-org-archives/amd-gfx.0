Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19594EC01C5
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 10:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EC4F10E4D7;
	Mon, 23 Mar 2026 10:33:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3LOTKwZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 175EB10E4D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 10:33:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZuCcO8UQKykXe2i20YfuJsMCN7EYr2HxlzbxTHqIIYNP+COMwVv08D5npydMPxwr8hgdsBiFNpw2H0sIc9G1WTy1GewXCf4z5h5sGJcSJ5tr81/Pmgf8Hnp0ASuNu+SjLOs0skqKqouuufTGqTsbJjwFzVMdqrXd0KlFb4cvUtfuBmrSiwISVuzOK9EORGf8UYkL2ITO/mLmBeA7uGazwXcqrPgTUun/epSnLoT36YG97Y9pchw7P+yImipro/phJ1+FH9eZMLWHFbEYOCGHl18Qk3gyXnKlvxuUoupORhPNrVtVfDwLXWlehcqSJcisgY7HGYNNv6f8M08GYUhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7LcXLPdpN2SXXYR0MX3iQaKuilj6eyISBJxVbQSE+CM=;
 b=E9IxrtpL+y09FAYY7qJ9bTJ9CPqQauYObl5d+i+VXF3IkzUxhwxvNSi2rNWwoPP+pEWh3wde4IP8K9wiDeebyJF3ISQmOFS4ZjX+bs1vzTQWQafs9raD8TzFS+AtvApyYuIv7Kv0XqYbqnvTmZ7vabDtCTRMN+M3PhkCH0e4BeEBudoIQDcqz5TobdaXahAkQ5UIowmcZmbUQe0hechNlfWWFDwYpwk0RP8CdtMldtPCHj/L4j8Eh3gZnRPvkfa5ihu4LwlGcXdW6xO+w2+DSunT8WWnatsWm3aN+9x7KZOZtCsE76ZvcXl12Npehu7PYqhEUHAXLh8Mvf6hJyPkbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7LcXLPdpN2SXXYR0MX3iQaKuilj6eyISBJxVbQSE+CM=;
 b=C3LOTKwZSKj93mDaIAdu8pcJyKEOToI8iqzthEWqEWdkx9DnUJ/MFOHrzGiqxw5V3jhvkNtrNCrcCfwdObCEZXqYEDeTl31ZML9ktZsHUJmCwApKoz1WhQ11DpiGcCFBU5opYOVTo4mFhTwaf9tSkaRpDXprkoxbA5OCPQk/LO0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ2PR12MB7920.namprd12.prod.outlook.com (2603:10b6:a03:4c6::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.14; Mon, 23 Mar
 2026 10:33:31 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 10:33:31 +0000
Message-ID: <a9d1d92f-fd10-4c32-a1f1-aaf9febeebfc@amd.com>
Date: Mon, 23 Mar 2026 16:03:25 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: guard atom_context in devcoredump VBIOS
 dump
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260323065621.554621-1-Jesse.Zhang@amd.com>
 <08cef5ab-1874-4f34-b9b6-a4355bdcef58@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <08cef5ab-1874-4f34-b9b6-a4355bdcef58@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0047.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:279::9) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ2PR12MB7920:EE_
X-MS-Office365-Filtering-Correlation-Id: 8261aec4-2172-4aad-ef93-08de88c7a0cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 4mFK52oV/lsSyT65sLUou8hxTkY6erUyiWBQOXPpxrRcWgYQ3YWq9h31mtX1elHCf6c20EMVwRdgoilumd+k0Ff/+/Wz/6sHGMP0+nlnJqYeMKCRGa5t9xXgwot6OMMCbjaD4uaTbP+43ExmaHlNIqz3O5v27jrSZBjuHolVaNpTkUAZq0BfL1ZZ79PzogOktFdWXBTY40oT++NRtTN+bA66/ewSJkDcRu3xK17oOa81YDBnH4aGeU1P86Xx9rH3cS5CTYzCLOtIhOnOyKBMZVFx/Ec7iBGL8Y9XudRcrTMb3+zG32WRXfzCECPNAth6Hs3etWn/hz5VvpMPRyTCnX80BQwFmLcOD2MIanibbvRmoNoaJ/o4ZOokE4vAElw0LnY3bHaKkP+77f6oGOLlMuVqcaYBC27W6qNfsK50/RoUau9tU9PEWKavWry+dE0+Qs72EHPjlLfKU5xhdLsPy/NVwKWmVlgHni0lVqoWsNjrb6CTkxcZfh1sAQfCwtYG+VlvTa3hwdXnVrEqv4hy8OoEKNlZ0S4h7GqYt81rky5e9aviaNN4GpM5vl7952V+0sdytYGTKtEW3fXkJsrn7jWKxVhbtFjACYLzqk3M4LPY6YBWAHUMZRcoeXKMrqXab0ycdRrqagTscTYnnpL0cYlJhdWf1gj4Mn7sWzF5tcRZsCvmsJdHnAWi7dywSEkdwOkAs1VXDGyFJL9kvOFfIol4RpTGvf8DQ0dwpu/+5I4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?THRqVEkyUzRjaEY3cnNBWENZaGg2NkZwRnVPaE1CSDFudW9VbVF6S0pvazJP?=
 =?utf-8?B?SDdlY1kvbEpHaDduaEhUNG9KcTl6SXlMMGdKMTFLaHdRNys3bTZDZ3JjWjNM?=
 =?utf-8?B?U0lPWDBvdVBZZWtkV3pCVytBNWRia1JqaGhGS2RtOXAwK0xHUVNDWUVvaTBG?=
 =?utf-8?B?M0poeDBCZlNabTBXMXgzMWJNK1ZoMGZUcWVXZUYxRFZIM1c5ei9KMUc3Z1M3?=
 =?utf-8?B?TGFqQWJiaU1rYk9wSWNHQ0JkTzFTb1dicW5QY0taeS9xRm52dGgrVVAzc0wz?=
 =?utf-8?B?RytrVXRrTURaQVZTOFpJbnFjdGFSTHl5N3dad1lkRUQ4UVp5NU5UN3pjR2k2?=
 =?utf-8?B?Nm8xUFVCcThQR1lNSkNjSmJDQXZROXFnd241bVExMHBNTGh1YlpVOXRqRGpU?=
 =?utf-8?B?dm5iYnFsUnBTMWw3ZlI2NnJOcllrSTJ5c2FGcnYzaGsxd1ZqSEgxZTJ0b0Er?=
 =?utf-8?B?b3VOZDFDSG02c1lhM2pUeXk1U3EvVWV6SVRYUDFUWEVmdGd4eDRBcWdDUEVz?=
 =?utf-8?B?RklpdmhjYVVvSnhEYzlMS3pkUmNldDdEQVJYRHRBdTZJRDlaMDhjMlRXSEtj?=
 =?utf-8?B?d2FtbGNyTldwTXF0OE9VbG5vaG9YdFQ5V2JQQWp0dTF0cGVPeThENkF2bENI?=
 =?utf-8?B?N1BPUnhyOFJnS3p3UVpIbkNnamRiRXRaanM4WE92MzBFVWR1Ris4dmY5MVk5?=
 =?utf-8?B?MWV3TmR4RHBlZzNnUHdGSGc3QksxZU0yQkk1d0Q0ZXdHS1BKRko1eE5rTnhC?=
 =?utf-8?B?MURtSm8zR3kzQUxMbW10TUM1QnQ5VGhQRW42eGk5aW9aZDRPMnlsQm1xNG1l?=
 =?utf-8?B?bkdKa2U1L0Jqc2ZhY3F3M2FwTFFzWko0SUdmS1phTEJmZGpydUNNY09DOW1a?=
 =?utf-8?B?cGdESnphNDdZZGJINTRRV0pxRGliOXRSMkM3NkVRNXI0MkFNeWwzd1RjVytP?=
 =?utf-8?B?cmYxb01md3JMRnRwbnlTc1BhNjdxYXp6dUVUU0swZ25KeTR1eStiU0hrV3RX?=
 =?utf-8?B?dnYzMjUwbUFFZ1NRV3hXRWM1SmVYcFhwcmdaTDI5eGRJMENRcDZHODZBWm9E?=
 =?utf-8?B?cStYU1pJU21XaEN0ZlRPK1pGVWgxYThPL0REZjhaN1E3cmpZRFlRdTRDMjVh?=
 =?utf-8?B?UkJRQ0NWSkYwYmdidlFjTW5hMWgxQVdVbGpGQ3M2d1dDV21RZGZjZTdkc0ZH?=
 =?utf-8?B?R2ZCUmhXVy9RMWFyUUhHTTdyUkFtanUwb09nVlJDUFp3ZXZiaGpNTFhYU2Qr?=
 =?utf-8?B?eEJ0ZHI0b1ZXa2d5Q1hmcjM3VFRQQjlBTUpjQ1JJdHRuZEc1UlJ6MGJrRTFs?=
 =?utf-8?B?dm1ubXJRZ0lUQmUyRFR4U0JPRjU4clE1c2hzK1NpWTBoZFFFc2J2ZzNOVUt4?=
 =?utf-8?B?Rk1SZHlDVjRza3FQWkhpOGZMemFoTjJIVUZ5NDdHbjZHckUyeWNDbmM0T1Ex?=
 =?utf-8?B?THRQU1VicEZvbGF3Ry9OclkvSDhOTHo2RVQ5ZXdEM3FnNDNlK2t0cVpoZVp6?=
 =?utf-8?B?MWR2K0JPaW5YWnBTWlRpSzRTYVo5QmR0dEt3QWl1bi94SGdualFWeTdTTWtC?=
 =?utf-8?B?amNlbTFIR3UzRng0UFpHL3Z4aEx3ZGNEQXEvbC9PaENaSlJVSmM4b2QvQ3M5?=
 =?utf-8?B?MWloRzR4UGlvdkt4NUlSdmxoWnllWjQvZXJ4WnJCVk1xV0xzS2E1MFJoTTRz?=
 =?utf-8?B?eEFtTmo1TWl6WDExZDFCNThSWnVwVktxYnpVTVBuWlc5R3hld0FGd0JkSEts?=
 =?utf-8?B?QXJMeFFqYnhvR2xiZUUrS29pL0hIYmVoeU1yM2hHYTQ3RFF6Q2ZkZXpyS09Z?=
 =?utf-8?B?MXRDRDdKMHEyRENDbjluMHQ1d1FVU3Y1NmpaSUxxWE5oSkVXT1FzZnUyNnRq?=
 =?utf-8?B?ZnJ1WVRzaFA4d3BjczZQb09KNTFuOE82M013T0xuMjBPNDRUSXZUU0xjeTls?=
 =?utf-8?B?WTFtdW9Vb2ZTMVlpZ2F6S2hIaXBHaGdXOE00UitBd3NmNnR4L1kvMGJmVEdO?=
 =?utf-8?B?YTkyTVVZYjhvSkxYRkdnbmZwTkN1dTM2ZVBrbXpWWGZkVzJsS1dqbGZvQzZx?=
 =?utf-8?B?TndmbERnS0tuNmlpU1plWGtnSENidktBYlpBMTQ4alB3QWhMc2JGRWRYZDBL?=
 =?utf-8?B?Uk9xa2NtTmVEbGF2dk84TFNLOXlBVEtjem9jcU5jekIrZml0OWRHbUduaWZ3?=
 =?utf-8?B?R1g4OTB5eUEwSXpYdnNJbTk0TUpMQmM4VHNON2JzVC8rU2xDUkRqeXdiNFNm?=
 =?utf-8?B?QWlHSkQ4QkdLNDhUcDd3YUJpdEVCRFZHMVc4NE1LTFYvanFMbFZ1NGJlV1Fm?=
 =?utf-8?B?a0ZrV3Z1UmpwT1AvN2RseGFtUStWK3VnZGFCaHFubjR1RXM2aG5YUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8261aec4-2172-4aad-ef93-08de88c7a0cf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 10:33:31.4497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bcv6n1W32Vwi4xeYHgRdTVM53FVjk9es7d3LP20v9swT9OSuDv4UG/tTPn90Ra1X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7920
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



On 23-Mar-26 3:27 PM, Christian König wrote:
> On 3/23/26 07:56, Jesse.Zhang wrote:
>> During GPU reset coredump generation, amdgpu_devcoredump_fw_info() unconditionally
>> dereferences adev->mode_info.atom_context to print VBIOS fields. On reset/teardown
>> paths this pointer can be NULL, causing a kernel page fault from the deferred
>> coredump workqueue.
> 
> I don't think that this is correct, just checking for NULL doesn't fix the issue.
> 
> We should rather make sure that we don't release the VBIOS information during teardown before the dump is completed.

Atom context will be released only during software fini. A core dump 
during that process doesn't look correct in the first place.

Thanks,
Lijo

> 
> Otherwise it can be that we manage to grab the pointer but free it a moment later and then try to print freed up memory here.
> 
> Regards,
> Christian.
> 
>>
>> Fix by checking ctx before printing VBIOS fields:
>>
>> if ctx is valid, print full VBIOS information as before;
>> otherwise print a fallback line:
>> vbios info       : unavailable (atom_context is NULL).
>> This prevents NULL-dereference crashes while preserving coredump output.
>>
>> Observed page fault log:
>> [  667.933329] RIP: 0010:amdgpu_devcoredump_format+0x780/0xc00 [amdgpu]
>> [  667.941517] amdgpu 0002:01:00.0: Dumping IP State
>> [  667.949660] Code: 8d 57 74 48 c7 c6 01 65 9f c2 48 8d 7d 98 e8 97 96 7a ff 49 8d 97 b4 00 00 00 48 c7 c6 18 65 9f c2 48 8d 7d 98 e8 80 96 7a ff <41> 8b 97 f4 00 00 00 48 c7 c6 2f 65 9f c2 48 8d 7d 98 e8 69 96 7a
>> [  667.949666] RSP: 0018:ffffc9002302bd50 EFLAGS: 00010246
>> [  667.949673] RAX: 0000000000000000 RBX: ffff888110600000 RCX: 0000000000000000
>> [  667.949676] RDX: 000000000000a9b5 RSI: 0000000000000405 RDI: 000000000000a999
>> [  667.949680] RBP: ffffc9002302be00 R08: ffffffffc09c3084 R09: ffffffffc09c3085
>> [  667.949684] R10: 0000000000000000 R11: 0000000000000004 R12: 00000000000048e0
>> [  667.993908] amdgpu 0002:01:00.0: Dumping IP State Completed
>> [  667.994229] R13: 0000000000000025 R14: 000000000000000c R15: 0000000000000000
>> [  667.994233] FS:  0000000000000000(0000) GS:ffff88c44c2c9000(0000) knlGS:0000000000000000
>> [  668.000076] amdgpu 0002:01:00.0: [drm] AMDGPU device coredump file has been created
>> [  668.008025] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  668.008030] CR2: 00000000000000f4 CR3: 000000011195f001 CR4: 0000000000770ef0
>> [  668.008035] PKRU: 55555554
>> [  668.008040] Call Trace:
>> [  668.008045]  <TASK>
>> [  668.016010] amdgpu 0002:01:00.0: [drm] Check your /sys/class/drm/card16/device/devcoredump/data
>> [  668.023967]  ? srso_alias_return_thunk+0x5/0xfbef5
>> [  668.023988]  ? __pfx___drm_printfn_coredump+0x10/0x10 [drm]
>> [  668.031950] amdgpu 0003:01:00.0: Dumping IP State
>> [  668.038159]  ? __pfx___drm_puts_coredump+0x10/0x10 [drm]
>> [  668.083017] amdgpu 0003:01:00.0: Dumping IP State Completed
>> [  668.083824]  amdgpu_devcoredump_deferred_work+0x26/0xc0 [amdgpu]
>> [  668.086163] amdgpu 0003:01:00.0: [drm] AMDGPU device coredump file has been created
>> [  668.095863]  process_scheduled_works+0xa6/0x420
>> [  668.095880]  worker_thread+0x12a/0x270
>> [  668.101223] amdgpu 0003:01:00.0: [drm] Check your /sys/class/drm/card24/device/devcoredump/data
>> [  668.107441]  kthread+0x10d/0x230
>> [  668.107451]  ? __pfx_worker_thread+0x10/0x10
>> [  668.107458]  ? __pfx_kthread+0x10/0x10
>> [  668.112709] amdgpu 0000:01:00.0: ring vcn_unified_1 timeout, signaled seq=9, emitted seq=10
>> [  668.118630]  ret_from_fork+0x17c/0x1f0
>> [  668.118640]  ? __pfx_kthread+0x10/0x10
>> [  668.118647]  ret_from_fork_asm+0x1a/0x30
>>
>> v2: add check !adev->bios and chang the log  (Lijo)
>>
>> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 16 ++++++++++------
>>   1 file changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> index bbb5afd67b49..29078c08f264 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
>> @@ -192,12 +192,16 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
>>   	drm_printf(p, "VPE feature version: %u, fw version: 0x%08x\n",
>>   		   adev->vpe.feature_version, adev->vpe.fw_version);
>>   
>> -	drm_printf(p, "\nVBIOS Information\n");
>> -	drm_printf(p, "vbios name       : %s\n", ctx->name);
>> -	drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>> -	drm_printf(p, "vbios version    : %d\n", ctx->version);
>> -	drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>> -	drm_printf(p, "vbios date       : %s\n", ctx->date);
>> +	if (ctx) {
>> +		drm_printf(p, "\nVBIOS Information\n");
>> +		drm_printf(p, "vbios name       : %s\n", ctx->name);
>> +		drm_printf(p, "vbios pn         : %s\n", ctx->vbios_pn);
>> +		drm_printf(p, "vbios version    : %d\n", ctx->version);
>> +		drm_printf(p, "vbios ver_str    : %s\n", ctx->vbios_ver_str);
>> +		drm_printf(p, "vbios date       : %s\n", ctx->date);
>> +	} else if (adev->bios) {
>> +		drm_printf(p, "\nVBIOS Information: NA\n");
>> +	}
>>   }
>>   
>>   static ssize_t
> 

