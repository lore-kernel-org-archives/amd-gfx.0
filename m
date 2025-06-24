Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62338C77B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 15:18:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F043A10E5FB;
	Tue, 24 Jun 2025 15:01:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mH9BqeW8";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8354D10E5F6
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 15:01:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YM8Hx/RybXqvVV7sBSgg9SR4F0SIuwB3tLgDK510MtX0lQ3FwVw3bTUDnZX/egCnvGLNMJjjyntNrpn71DwNUSUY4GjrmrWGgAfMUha9XHpdLnMeVgkLSuD1omreBKCW0cApk/1aGfHRVensDOAHJeGHuQ8krs4s3CN5WHfpi345DeLgJ3osYjCYIRhAV+5rPI52sHfutabZkXNHOTlKCk1JY5Gk56ze++SjY0DaqFHLd0pJKSJKLzkbORDA4ehHRtsf7sfjuVHur6+arnJ4pl4YE64Oc/+yybsBhUCnFOA3D8RddT9U/G21d9dI/DrlJIYJLbz+XeruNRpQtJETPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Amp53B662nscmXMPo3LnW+YF8+sEts0O3C6aM7Pt+Ho=;
 b=JfvgJKNWEpnmxreyGLf/dNLo9ckQ12OTR2OmXxLdYFSa+db9C5D7AVIw6C4LsqQ16OvVRbHKCl7Kzey4nM1s4ReFoz705n160G9CVrhbt7Fkj0hl3xGcKVEaEL7zY5Age/P+EIWqaHZUpbgzL+KjsHuNeT81fSkylVeehsccf2YyTEZXi7tnw1WluuwrC31ODynoLRUin1+gIA6GwiTlqUIFGbYPjhosGRifaWonp9EuuViHeZGbHC8A4vbt6hwcCjWAboVr6c2opVw0+UH8iI/yxNKYW8PywcIWUnNVDU0+QzWRwmKLpbMm9uElcf3Le2GPgpLXUvcQlEd86Flokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Amp53B662nscmXMPo3LnW+YF8+sEts0O3C6aM7Pt+Ho=;
 b=mH9BqeW82kMMediP+fWz5HJ26FJihtCla/Iy2OWGCIbV70cPvP02MhKo7hi1rSjh5TOmRntlinOaSpOGXTpjWoCvyGgiDgTWdCIjyCp3/O9jxMclHdHi8PMaPdn9SQn/6utjDCOBjSNqoEo+JKh5CBWeoUqybUQ2j7xuMh3EAp0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.22; Tue, 24 Jun
 2025 15:01:01 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::36fa:deca:aaeb:75da%6]) with mapi id 15.20.8880.015; Tue, 24 Jun 2025
 15:00:59 +0000
Message-ID: <0212b140-0c83-71e2-a0ab-f925b2125e98@amd.com>
Date: Tue, 24 Jun 2025 11:00:56 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: Don't call mmput from MMU notifier callback
Content-Language: en-US
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Felix.Kuehling@amd.com
References: <20250623165936.6178-1-Philip.Yang@amd.com>
 <77dbf577-d767-48e6-b087-61dfcc478c22@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <77dbf577-d767-48e6-b087-61dfcc478c22@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::18) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: c227fe40-234e-47f4-1893-08ddb32fedbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TE1BUHNhd0J4TjdRQnNvQlJMcS9DcmMzV210SU1EU1FIemt5VUp3M3hneWk4?=
 =?utf-8?B?R2Rmd29uK2w2QmxJaURLK25Sb0UrMDY5L3BCbExnNllPQ2FkMkdsbW1KOGFz?=
 =?utf-8?B?dXU1VXdEMkJ5ejhkUmVtZDFZUUdXTlg1VGNTeXVOaVIxSHFDd05qVHh5UWdt?=
 =?utf-8?B?bWFNME9DUld0N0J1QjVkd1Z2ZEpOdjh4TFhCTjN2QUE4LzJFSThyVTJWUU1n?=
 =?utf-8?B?eEZ1Y2xaVjF5YW9LdXhDSnBvRythT0M3MkcvZ0VoUGVjbW9sRE05YUFScEhW?=
 =?utf-8?B?NUQwSXlvU1JzMUdiR0tMdHoyelIvdUNrOUxZMm1JWm1rL3dtMThLZnJhLzkr?=
 =?utf-8?B?b1FETG9EeWgvMU0zdFVNMXpET1ZIb1h3dndEQXZacXJib2ZsNWw5aVQrVCtS?=
 =?utf-8?B?UkxQcFVrY3ZaYWcrOWtTaUVwRlVmcTg3Z1Q3a2g3SUR3eDVJbmo3eVIzTU9s?=
 =?utf-8?B?dzhjUHBQeEFRcEZWL296QWRYNjBoL3FzbXUxVWljVEIzQnAxczRYY3loUEZt?=
 =?utf-8?B?U0xYbEZDSFlodkJNREVISTVELzFEY0RIdDl3UFo0ZDdlZ1JNRkk2T2UyUkJr?=
 =?utf-8?B?b3pmdGRCVzE4dnd1eDhENFg3bUxCaVk5eXVrRWNTWEZ5ZXp2UnExODRoV0pK?=
 =?utf-8?B?bVI5bytpTitac0gzWUFwVjBGYWRXa25jMmN1emp0a095cFlWaEdwVVFJT0pF?=
 =?utf-8?B?UXZJb1lPcWRVSEg2WXVIK0w1UFZpR05FQ2ZjT2VocTRBZTBQNEdwU0FxcTRl?=
 =?utf-8?B?bjQ2clRleG9CRENQR2taSzlTK3NxSXlxUkk0NlJpN1c3M0VONW5xRFNQKzFu?=
 =?utf-8?B?aDNDV2Q3aXRQY08wM2tCSXROM1dpY3R1WEN5Rzh4WExiSHczaFFibHFpZFVM?=
 =?utf-8?B?bk91MEFwQWh3cmF3SjdwME55TEZLRWw4VzFNM3JXTUNnZ2d3K2JiaTdkVzdO?=
 =?utf-8?B?aVErbERCWWYwTCtJRGU5Y0p1YkNmRDZqalFzZkxRMTdqbG9BdjdhQlE3MkFW?=
 =?utf-8?B?cGMrb2JMTG5MSEpuU0hUUnJlamg2ckZsaEdQYWkxRDUvSXp5MktWL2xzLyt5?=
 =?utf-8?B?bnhwR0FYVEFPVDlOS05Bb1MvZG82MHlqdHNGaTVFcnpuM3N6ZCt3T24vaE5x?=
 =?utf-8?B?ZzU0akJXaGJWZVZQTVVmMld0WnV6alRKOHd5em56UVdSWlJ5ckgvd1ZtS3ZD?=
 =?utf-8?B?R0hqb2VWMmZVRm9OQTFzcTlBWkdGdTd1N3RrMExXNGpseE1MaDA3N1IyY0Uz?=
 =?utf-8?B?MXhmV0ZpT3RZeGo4TEdsNlFPdnZVL1JCNXJzU0lkaFJYK29xNXF6RTZHeThn?=
 =?utf-8?B?dWZGYVBYKzEvUzVEWHllY2hGbDVMWTM4ZVl2UHBydnFpbndJTmYrN1ZCcy9E?=
 =?utf-8?B?ZFh6cDMyRW1QWFFCTW5RcTRHSGZTajllekUvUTJNUTlZcjMvaWdtekZMV2pq?=
 =?utf-8?B?UnQxSXV1dGsweEZtSXZ2UmZlK2psWGNZZXV4SkdlbDd2OWZuUldLU29pZ1la?=
 =?utf-8?B?UzlTc1ZJMkd4YmIvNWVjTDdNQnc5Uk1lME02Q3dlUXRxZWFkM3NkU01YZ1Za?=
 =?utf-8?B?YXIwNmkzRDdpOFpjbG5MSHNhc0hzT2R0bjhvVmhyRjJsYkFwSWg2SktCck1C?=
 =?utf-8?B?UWQ3L1QxRVV6c2xERG9LRkZENFFoZE8zQXlyaEo0NWZ3VUdJcC9tUzMyY1pI?=
 =?utf-8?B?WUlOZ2RMeXRlSXhSd2lPSkszSVExQkVieS8wbnZOVVBQN2l0QXBjVVpoUXlD?=
 =?utf-8?B?OWVKd1dWU1hHRkRZTnVnYUp5aWoxSVpiclFXK3VqNDhVRE5DQkk1ZkhzNldv?=
 =?utf-8?B?MXloeEtJRHlxOVpUeWFLcXhyeXBVT2d6ZCt2UnlrbWl2eVZ5WFFKR0FQbU40?=
 =?utf-8?B?dE1GWUxRUUdFZGlQbnZKaE81cFF6NTVhWklQNlIrT2FjNzBkRUROakk4cHc4?=
 =?utf-8?Q?/jkzDCTOS3g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkJvMVY4ODQzY01GSnNqSERNd29rR1ltNGY3VHpxNk14aHl2MmU2R1ZyQ0o2?=
 =?utf-8?B?NEZwZ091cUlpanBTMTZpWVF6MExCVmcyd3IxRmVPSFI1RnFMQTc1U1N3ckNm?=
 =?utf-8?B?UTdqSDZaUFZrdndIM2VJYnpMN21iNjFFQzhpR1ZyM1UxaGd6MWFQcjQyT256?=
 =?utf-8?B?V0VlY2pPT2VuY2lkRG5PZzVIUndXSmQwcmo3UVFVczF6V1l4TVdHT1ZqREtq?=
 =?utf-8?B?UGxFc3Jic283dTIzODZsbWZsUWppS2NYRDJqSU9UZ2RHUzJMZjlvKzNyckZI?=
 =?utf-8?B?Z2U4Ri9Lem1oUTBqL0dVcGtzNHloZkpkcDdwR0NwWFcvcXFUL3R4eWtld3E2?=
 =?utf-8?B?RFFDVytpdzJYKy9iRDZTMXdLZS9MNkJGVFBqc2VYeEJOcFNLMm40UTVncERq?=
 =?utf-8?B?RjFnb3ZodmNybEZTR0NpZ1MyWHhrUlJyMnlvMkQxM1BmV1h5TUtOVnFLV2Va?=
 =?utf-8?B?VGd0aGZGak0wNDZRMWRiaU5TbzJIK3VaMTJTbG9aTzY4WXJVdllGaE9TMHZQ?=
 =?utf-8?B?WXZLdU5kaGFlbTNyU08yYm5uanN6UGVQVVRiT1dRTzdlTHVCN01MU09ObFNv?=
 =?utf-8?B?UnVBN1pYL0pJL244WjV0SzRXd0FvRGUwaHJZMVFwSDRmZ2ZrWXQyTWxYWkdB?=
 =?utf-8?B?QTR0WUlCSVYvZ0tEZnZyZjd6VkRWY1UrbjZBSVVlbFI1Q000WWY4c0R2NHE4?=
 =?utf-8?B?RWtBRy9tS09UY2dPL0dTWi9PNEQzUEx1YUlLeUMvV05VZFRKeHA2NlEvS1Mw?=
 =?utf-8?B?WUwveTA4ZTZNOXhIbGhndlh0RktaZko0OWx1aUF4dVFwbVRMWS9DQ1BZdFpG?=
 =?utf-8?B?aDJTZndVY0RXalV6R0w5amcwdUNnQUJ5T2RrRlMzT2VHRGJaZkxSQUNSejNr?=
 =?utf-8?B?NytUUTBwNFFNYVJ2TEpHUWVyYVloQ3I0R2wzUmV0RGJRVjNtNDZWcmJxaVNy?=
 =?utf-8?B?ZVVidWNXL3I5c3NObkhXWFEvUjQyTWd6YzR2Y2tKcFp5THNoekZ6QlBGeXV3?=
 =?utf-8?B?cTJPYzlETjNudE9nQ0NxSkNJUUpwanNRTG13ZkFubjUwR01GQzRqOUdFeGRh?=
 =?utf-8?B?dlFKUlZaNWpiV29KRjdMb1d3czhZSVR6VFk1OXlocExoR0JqQno0eTN3aWJP?=
 =?utf-8?B?UEh5ODUrL0c5NjZXTTVSbndvUXdtRmhSSmM1Tk9sRGhiUHFpaGE0TUE5QWdR?=
 =?utf-8?B?bVBnVmNXMnd3bDhXQ1dCVFIyeml4SHBwRWNCeVZpaVdXV0F1K3BuVkw5dlMx?=
 =?utf-8?B?ZU51dUlLM05HYjlRZVZoMDNIemhYYmFDdWpKbFhZVW9FNDJOdGZSTHc1Sm4r?=
 =?utf-8?B?aWJOTGhqNGhqWkpPSCtONEdLcm9OUU9OY0hPdXFLVlBkRVQySjZOMUl4dHFP?=
 =?utf-8?B?ZXUzVEtNZHFDRTQxM2RlVEhGMHFWODVETkhSQnI1ZHlCdmxhKzlzTnBTMUFQ?=
 =?utf-8?B?U2NTbnBaVGgxcHJIQS8wRFN6RnpPS2ZWK1RKWVVyT2gxMHNNcmdycEVrdEJT?=
 =?utf-8?B?Qk5JQ05jb3VjN2R4NGJGOVVaY0luZUNheitlRURrV1pMbWg1N2VHQ2Jlek9j?=
 =?utf-8?B?dW5YR1FIbjJZblZBZnQ4R2l4ZnhNUmFid1AzejdTb29Qb3huaWovRUdJeURR?=
 =?utf-8?B?Ri9ZWXdEUVI2UWJQRDZ1TkRKbU1MRW8rNXNOQ0plU2JJcDNsVHZHay9hMEZP?=
 =?utf-8?B?ZjBneVg5NVc1d2xaK1ZibFVLMmo0WjZBU2pZeXRkMC90OVN1NmtHUkxZOUti?=
 =?utf-8?B?cmNTMnBKR1BIVnlxSm1wTDVNMEtVUmxvN3NSc1ZIUmxPa2F6UmtYRllWOWc1?=
 =?utf-8?B?Z0xWMVhtR29ndkVIZ243bUZyeVBhbFM2R2UzclJJeFZkVnJKdXRuVzIvZkhK?=
 =?utf-8?B?VUl6UnMvbnZqTEV1c3N2YUttMmxCTGhITGFYeW5hejlvN3B1R3BDWlE3RG8z?=
 =?utf-8?B?N3k0c2tUd3djYUVPQS9zdW44aTZuRWNDaDZJU0xUbFdObzRaYzgvcU1jWVBr?=
 =?utf-8?B?US9qOEVCUW82WEQwVUpCc3B4QkFHRjlETkVwRVRhQkFNY0MxRWtLSWNKd1VX?=
 =?utf-8?B?UG5jaWc3WVZyQmRVaS9QSFZzemlGSnJjelo3aWM4L0tjMXFib3RaM3ljc0FM?=
 =?utf-8?Q?XtEU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c227fe40-234e-47f4-1893-08ddb32fedbe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 15:00:59.1625 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZFoBuihyBAl7M0mqx1gARvz8V6jVlmNFG+JXyyZiewHz1geNsig1go1fJxwAUhC0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568
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


On 2025-06-23 18:18, Chen, Xiaogang wrote:
>
>
> On 6/23/2025 11:59 AM, Philip Yang wrote:
>> If the process is exiting, the mmput inside mmu notifier callback from
>> compactd or fork or numa balancing could release the last reference
>> of mm struct to call exit_mmap and free_pgtable, this triggers deadlock
>> with below backtrace.
>>
>> The deadlock will leak kfd process as mmu notifier release is not called
>> and cause VRAM leaking.
>>
>> The fix is to take mm reference mmget_non_zero when adding prange to the
>> deferred list to pair with mmput in deferred list work.
>>
>> The backtrace of hung task:
>>
>>   INFO: task python:348105 blocked for more than 64512 seconds.
>>   Call Trace:
>>    __schedule+0x1c3/0x550
>>    schedule+0x46/0xb0
>>    rwsem_down_write_slowpath+0x24b/0x4c0
>>    unlink_anon_vmas+0xb1/0x1c0
>>    free_pgtables+0xa9/0x130
>>    exit_mmap+0xbc/0x1a0
>>    mmput+0x5a/0x140
>>    svm_range_cpu_invalidate_pagetables+0x2b/0x40 [amdgpu]
>>    mn_itree_invalidate+0x72/0xc0
>>    __mmu_notifier_invalidate_range_start+0x48/0x60
>>    try_to_unmap_one+0x10fa/0x1400
>>    rmap_walk_anon+0x196/0x460
>>    try_to_unmap+0xbb/0x210
>>    migrate_page_unmap+0x54d/0x7e0
>>    migrate_pages_batch+0x1c3/0xae0
>>    migrate_pages_sync+0x98/0x240
>>    migrate_pages+0x25c/0x520
>>    compact_zone+0x29d/0x590
>>    compact_zone_order+0xb6/0xf0
>>    try_to_compact_pages+0xbe/0x220
>>    __alloc_pages_direct_compact+0x96/0x1a0
>>    __alloc_pages_slowpath+0x410/0x930
>>    __alloc_pages_nodemask+0x3a9/0x3e0
>>    do_huge_pmd_anonymous_page+0xd7/0x3e0
>>    __handle_mm_fault+0x5e3/0x5f0
>>    handle_mm_fault+0xf7/0x2e0
>>    hmm_vma_fault.isra.0+0x4d/0xa0
>>    walk_pmd_range.isra.0+0xa8/0x310
>>    walk_pud_range+0x167/0x240
>>    walk_pgd_range+0x55/0x100
>>    __walk_page_range+0x87/0x90
>>    walk_page_range+0xf6/0x160
>>    hmm_range_fault+0x4f/0x90
>>    amdgpu_hmm_range_get_pages+0x123/0x230 [amdgpu]
>>    amdgpu_ttm_tt_get_user_pages+0xb1/0x150 [amdgpu]
>>    init_user_pages+0xb1/0x2a0 [amdgpu]
>>    amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x543/0x7d0 [amdgpu]
>>    kfd_ioctl_alloc_memory_of_gpu+0x24c/0x4e0 [amdgpu]
>>    kfd_ioctl+0x29d/0x500 [amdgpu]
>>
>> Fixes: fa582c6f3684 ("drm/amdkfd: Use mmget_not_zero in MMU notifier")
>> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> index 10d1276f8e1c..5fe92f9a1ce1 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>> @@ -2392,15 +2392,17 @@ svm_range_add_list_work(struct svm_range_list *svms, struct svm_range *prange,
>>   		    prange->work_item.op != SVM_OP_UNMAP_RANGE)
>>   			prange->work_item.op = op;
>>   	} else {
>> -		prange->work_item.op = op;
>> -
>> -		/* Pairs with mmput in deferred_list_work */
>> -		mmget(mm);
>> -		prange->work_item.mm = mm;
>> -		list_add_tail(&prange->deferred_list,
>> -			      &prange->svms->deferred_range_list);
>> -		pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
>> -			 prange, prange->start, prange->last, op);
>> +		/* Pairs with mmput in deferred_list_work.
>> +		 * If process is exiting and mm is gone, don't update mmu notifier.
>> +		 */
>> +		if (mmget_not_zero(mm)) {
> If process is exiting we not need do schedule_deferred_list_work 
> neither. I think this part code need be reorganized with 
> mmget_not_zero(mm) check.
yes, that is right, we could change svm_range_add_list_work to return 
true only if new work_item is added to the deferred list, and schedule 
deferred work. This optimization could be another patch, not related to 
the deadlock issue.
>> +			prange->work_item.mm = mm;
>> +			prange->work_item.op = op;
>> +			list_add_tail(&prange->deferred_list,
>> +				      &prange->svms->deferred_range_list);
>> +			pr_debug("add prange 0x%p [0x%lx 0x%lx] to work list op %d\n",
>> +				 prange, prange->start, prange->last, op);
>> +		}
>>   	}
>>   	spin_unlock(&svms->deferred_list_lock);
>>   }
>> @@ -2568,8 +2570,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>>   
>>   	if (range->event == MMU_NOTIFY_RELEASE)
>>   		return true;
>> -	if (!mmget_not_zero(mni->mm))
>> -		return true;
>
> Why remove mmget_not_zero(mni->mm) /mmput(mni->mm) here? I think they 
> are for different purpose from mmget_not_zero(mm) at 
> svm_range_add_list_work.
>
Yes, the mmget_non_zero/mmput inside MMU notifier was added to fix 
another issue that deferred work access invalid mm, to ensure deferred 
work_item.mm hold mm reference. But in the backtrace case, mmput inside 
MMU notifier callback release the last reference and cause deadlock.

Regards,

Philip

> Regards
>
> Xiaogang
>
>>   
>>   	start = mni->interval_tree.start;
>>   	last = mni->interval_tree.last;
>> @@ -2596,7 +2596,6 @@ svm_range_cpu_invalidate_pagetables(struct mmu_interval_notifier *mni,
>>   	}
>>   
>>   	svm_range_unlock(prange);
>> -	mmput(mni->mm);
>>   
>>   	return true;
>>   }
