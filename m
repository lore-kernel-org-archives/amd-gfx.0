Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A289ACD5BD2
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 07:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D05ED10FA13;
	Fri, 29 May 2026 07:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1VghlT8";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0895210FA12
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 07:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=enryIUTjMDhp3DRFsOOtfHXxN/LsVsVPluXji9bBcvvrc3eYaUfPgfg6xf7/nT6wu5euT7BkyHdLvyq5P8JDOV+kPGO+Q0Tu6Eykw4j9dBcZymwk/vM9pIkWDrX+5JId8ifD5rqbLtmRmj0/pDxz6gdkJwKQ4hNqC9I/yszSPtN6XwBDf37YygWDmL5TMlBs9kZ9rtDkJDdVn9OBoJMIlnUCPFVgcdVcjiwgbrEMZvabTKIbTQX/vuNCP7lkZ/YJ0YDmxHnDpiPm8oxRj72vAa5k9nw/CvvAW6kACG495tjBfTabPQ6LVtszmZmmw9JnbIBFnzUS+9Tab1YxcSu2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QlQ2429PFH1GOhxHJhudlRPzBk5JJBbj/eWZu4KVdds=;
 b=lUJfvuPOTx7eOegyNTRd+HwYm0lv8PmZuXx+XWnvAX1ntOnifC9cHJhl7nFaNi/EYcSj5fbSRnTSqIR4D+5Qi33rl1EeUCRntJiFKH83ioKQpaKSLeVDHDaVWnuvV4ApY6u4CE18yX2Epphv1joK30IR8hEO0bN8qqxo7x2RHIJMBFA28VM/fH3qoKWT385Tu+u6ql+vUlBsZ47Q8k/rdcBynYsR8a5bRZ0dDEt3Tpns2Wws2M0Q3siq3egOG6uLPXPXs/MlnI8X0TiV0qJf7Ub0r7ASgLxCih56HK84DxABe+1VzLPPbhLFll8Jwn/Mmoxf3pcp97VqsDj/SNBNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QlQ2429PFH1GOhxHJhudlRPzBk5JJBbj/eWZu4KVdds=;
 b=v1VghlT878PqfL51OkGwlAr2APT+rgDKYa69LbKAN3UNogoywHN8xXl3RJJgNfUXMAhbuzeIVwgyRVVVupxTgjbZ7ws0yty2P6hjdoXyPrafE+wlSqpN4YhEBHMwywYS+M63yC89i2UNChvkmvs7uTp2jsfPejxWO/uVbh+5j70=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10)
 by MW3PR12MB4411.namprd12.prod.outlook.com (2603:10b6:303:5e::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Fri, 29 May
 2026 07:33:59 +0000
Received: from IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2]) by IA1PR12MB6435.namprd12.prod.outlook.com
 ([fe80::8b77:7cdb:b17a:a8e2%5]) with mapi id 15.21.0071.011; Fri, 29 May 2026
 07:33:58 +0000
Message-ID: <c7494996-2b7c-42a3-9b08-04d8a6eb1175@amd.com>
Date: Fri, 29 May 2026 15:33:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [V2] drm/amdgpu: drop retry loop in amdgpu_hmm_range_get_pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Ray.Huang@amd.com, Vitaly.Prosyak@amd.com,
 Jenny-Jing.Liu@amd.com
References: <20260529022745.552737-1-honghuan@amd.com>
 <00bc6d0e-678f-46a6-b0e2-eadd48be2f19@amd.com>
Content-Language: en-US
From: "Huang, Honglei1" <honghuan@amd.com>
In-Reply-To: <00bc6d0e-678f-46a6-b0e2-eadd48be2f19@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TPYP295CA0026.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::20) To IA1PR12MB6435.namprd12.prod.outlook.com
 (2603:10b6:208:3ad::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6435:EE_|MW3PR12MB4411:EE_
X-MS-Office365-Filtering-Correlation-Id: 01aaad92-daf0-49f5-2f25-08debd54a540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|4143699003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HkyrdbxplXr9MXeswO0Fl7JQLxy/DY6sFFa8qw/vt7bOspiwUambu3SuzIZQeh8c+GYLcbaBa4Y/ZWOPT0rwBGY7G2wYvwOw2zJDEYQ42sH+emFbBl0L9FiuzJ11z7sFQUtEsHetPMRv8i1CvTH5udzXMc/aoiLk63/qjn1nxWZyA5Vf70QzbrX2nZnp5NfwYbHwqElRlfMmaYUBtNR8usQupxNVlVrarSffsTxrGX3LEQXkZpbYtQdCfuw264+LTcjxnjPr36Pq5p/hUYB4WtftCXB0a6WlUFpereeMBkTTm9MrNhOENbrMWEbNEH2CUdTiH2WPiKyN9OZERWrPG96IejDVcgXid+GSQzNXl5znCTcLBpZuDMSBaWeNPQACoqibX4CGjOYX98Qjoj/mXwx400Wx63CSqOEAFYuvXTq5NeeRzYeKU6q9NH/QLRT7DCegiXYkorfyn1VDMcW3aFukZYj15JK93tNtfa940mwhZnSuPGL7JkkyiMc1CQRnQinJ5gc2f2F2Lz7iUGR+XRRZHqUczqD8lcILuLcCPUyvos1YMq79+S/KaIm8IKWCUlU+26mmVCDMT0TgtkgOjbJ4fhAj/Wj3E518DI8JZ6HgYVu+WO7sv3y3u78fvgvFCWGIjU6IU3R2OWfb7KO+PUI3FhO+nWZtOrzb5fLiN2jomTpX93HxmYVY/RJfDXRC2nF0YY/J1vDwegFtjlstRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2swYWd1aE10amdLZnZKbEhaOFB0SEljZDdXWUhROXltZCtQc1BDRXJQdUI2?=
 =?utf-8?B?NFdwKzdHUlBjUDZIZWZvMnFvUjMzZE9YaGxOY0FPYXJiaVZJOHIwQXY5bWQz?=
 =?utf-8?B?MGdqaUxLQjZsNWdNRlIvVE1VWmFHQ3A5MjhBeHdScTJSeEM4dUVCeE54N1VM?=
 =?utf-8?B?T3VZaWlKVFhlRi9NbUVOWFJkWTU4eWdJcnZ0UG5UOXRLMW9SeWRTeS9ISjdo?=
 =?utf-8?B?NHVEeC9sdVpzS1kvclRHUmZwUUNsZDYvRGhJV2tDV3Byckl2SHJzbm91Rk4r?=
 =?utf-8?B?VWlyWCtWSVBZMG96L3FKVEp2d2ljNUtoK2hQNVYzYjBOU0REZ0FNMWt3YStN?=
 =?utf-8?B?aC9WNVdLeWc3Yk92WjlEcnB0SUlUNERHZS9ncU93N2Y2TWNpdnF2SUdkajQ0?=
 =?utf-8?B?eWFGaXMzUkl4UnhBNUpmaWZ2ZWJnTllzUjkzL0ZIUXd4dFQ3cElIMURqNWRN?=
 =?utf-8?B?LzdvcExaODdhTFlyNjgwcUJNL0EvV3JNclNGNGtadVpiU0M2MlFuTXZtcU9h?=
 =?utf-8?B?QWVIMkFJYXFyZUFuVnhTTU0wUFdONHR5YWswOTdXT2Y3UUlmZUh3dnNYN0Rp?=
 =?utf-8?B?RnVqVlBXYUVZazR5OFI1eFgzMjZYWVlHNVNsTVFkM2NyV0ErWVBnS3ZweVNr?=
 =?utf-8?B?T20rU1l2VGJ6a3FoL2szNlRBWjd6c0d6V1FGRWZ4U29BRDVtS0RpQUFmZENS?=
 =?utf-8?B?WDlkeW10SWlONm5EVVN5eWpsYWlvaG9ybDlLSnBZNnVEdy90aTlIWEpoUmo0?=
 =?utf-8?B?WlBRUWErTVBEd2NoMEJuNVl3V1J5RlBLVExTU0pLSTl4OUxVZHp6WDNrbW5O?=
 =?utf-8?B?c2hKS1g5aTV6b2ZlTTdPOTJnYmY0OHhFTzdROFJSSjBydG1NODQ0dHJ5N2Y4?=
 =?utf-8?B?cHRmZWtpaDlsN1gzRDJnUnBvYjR0UnQ0Vk4yQThISjlyREdWR3VhMC82ajFy?=
 =?utf-8?B?MEQzZVBXbWthM3QwMi81dm1kYUlOd2FmQ1NtczVBUVd1SzB6R2NTYU00NUNP?=
 =?utf-8?B?YmNVWDMrbkdCNTlkcnhIOW4wWGdLbTcxRVdFWGN5aUZIam1haW1WbytzZGRs?=
 =?utf-8?B?QXNlcGJjbG0zRnphNTR0R2doaGcyWFM0ZDJNcEg2MzNkbFNkMlpJY0l4cWJ5?=
 =?utf-8?B?RFk2OWhkeW5kc1pXM3E2cWxmSFFCUExRRlE4VU50dHU2VGRaRHpsZFVUOFlL?=
 =?utf-8?B?SmdjS2RQZjA1WG9aU2RUYXI0MFBidC9pK0JSQS9tc1hIMmxXWHI5TE16bFl2?=
 =?utf-8?B?MDFkSktueVorVGFGaXMwYUlUOW1vMGowMUQ0YkJGaGd4bVBJd3NxdFhFOTB5?=
 =?utf-8?B?clBqbFlVaVRlcUNYYWNJeGl4UzZKTytTTFh4UnRGM1NsWVlkTlRCMS9HUE1O?=
 =?utf-8?B?TlBsN2xoNlAyZEttczYvbnRSQlJZTnptM0xyUzZaYUs1cUxSR0RNZ0xnSWw0?=
 =?utf-8?B?ZEJQQStHYTRJTEZCNkVmQklMUEtnSS9WSnZ5VmhiWXpjQVp2QXNGZnZTZnAr?=
 =?utf-8?B?bXVnNFprc3plc3BKZ3YzSE5ZRGQxRCtJMHF1aXIwdXZzUXR1TUtUeFNOblRa?=
 =?utf-8?B?SGxtaXFaTFFpSzZ4c1dyTzJsOVkwT1hEajdMSk9xcHBXZGUxd243U2pINGpZ?=
 =?utf-8?B?emdaTnk3V3d2WTJoMXJXTDBlUEdNRFhSbUpLUEs5RFg0SXVKdkFqcDNoZzcz?=
 =?utf-8?B?amFubmt0RUNXT3BsVm44N0F2czRpQkNodnNYNE5id0VWTHAvK1hsWk1Sb0tl?=
 =?utf-8?B?ak9aYjF2TVBrUTFuZDBTK2IzZnE4QVFJVXBGZ3lLYXZZK1dWVE5nZ05ydXUx?=
 =?utf-8?B?TDR5MlhPblVYUU00QWlDRnpJSmJ1dG9UTnVFNzhqeWRTQjMzajhVV0dacUh5?=
 =?utf-8?B?aTZIbUdmQkd2dnhkaEJGWE1IeGtOUmNuem9XT0E0MU0wNU1DNXV6OXd2a3BC?=
 =?utf-8?B?dmFFOU5LZkRiYnRPU0t0Sy9nSzVFYjdFYWd6S3k4WDlITXZPN3J3SHpRR2lx?=
 =?utf-8?B?RHRrb293WFhMS1ptd21WeEYzMUFaV1dia2t6ZHo5cmp6U05yN253QTZOL1V3?=
 =?utf-8?B?bElCMVFIc24vNFNPd2pOa1k4R1UyNHg2SHZ5bnNzSEU3Tk8za2FsVmhOZ29m?=
 =?utf-8?B?R2pIWEF5eFJoMDJBaS8zQllOMkpQWU0wOE9wenZvbHdVN1RCUE5pZ1I2U0F1?=
 =?utf-8?B?S1dHd0VJbzNPa2hJUEdRMFdYSFhYeGZxY1lJK1pQc0orblI2MTFuVjZTQ09C?=
 =?utf-8?B?cnRwbUNYSzBWRWFTUytqNXM1bmRJTThFQlAvUllyeGs2Vm1lKy9JRjVMOEh3?=
 =?utf-8?Q?3h7IVeYTEK9a6ODjSr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01aaad92-daf0-49f5-2f25-08debd54a540
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 07:33:58.4001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ8rsjpYrahVfx3T8ccwrv7hb/bh2GqN2iT5SvOdSKxQkhytDxAapg/DOPgtCoagcc2eop0M6IYenreznmxnMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4411
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



On 5/29/2026 3:04 PM, Christian König wrote:
> On 5/29/26 04:27, Honglei Huang wrote:
>> Since commit 144ba981783f ("drm/amdgpu: fix amdgpu_hmm_range_get_pages")
>> moved mmu_interval_read_begin() out of the per-chunk loop, the
>> captured notifier_seq is no longer refreshed across retries. As a
>> result, the existing -EBUSY retry path can never make progress:
>>
>>    hmm_range_fault() returns -EBUSY only when
>>    mmu_interval_check_retry(notifier, notifier_seq) reports that the
>>    sequence is stale. Once the sequence has advanced, the stored seq
>>    will never match again, so every subsequent call within the same
>>    invocation returns -EBUSY immediately.
>>
>> The "goto retry" therefore degenerates into a busy spin that simply
>> burns CPU for the full HMM_RANGE_DEFAULT_TIMEOUT (~1s) window before
>> finally bailing out with -EAGAIN. This is pure latency with no chance
>> of recovery, and it actively hurts the KFD userptr stack: the caller
>> ends up blocked for a second while holding mmap_lock, only to return
>> -EAGAIN to the restore worker (or to userspace) which would have
>> re-driven the operation immediately anyway.
>>
>> Drop the retry/timeout entirely and let -EBUSY propagate straight to
>> out_free_pfns, where it is already translated to -EAGAIN. Recovery is
>> handled at a higher level: the KFD restore_userptr_worker reschedules
>> itself, and the userptr ioctl path returns -EAGAIN to userspace.
>>
>> No functional regression: the previous behaviour on -EBUSY was already
>> to fail with -EAGAIN after a 1s stall; we just skip the stall.
>>
>> Signed-off-by: Honglei Huang <honghuan@amd.com>
> 
> Reviewed-by: Christian König <christian.koenig@amd.com>

Thanks a lot for the review, will respin with your R-b added.

Regards,
Honglei

> 
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 9 +--------
>>   1 file changed, 1 insertion(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index 5d72878c8..229c30867 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -172,7 +172,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>   	const u64 max_bytes = SZ_2G;
>>   
>>   	struct hmm_range *hmm_range = &range->hmm_range;
>> -	unsigned long timeout;
>>   	unsigned long *pfns;
>>   	unsigned long end;
>>   	int r;
>> @@ -199,15 +198,9 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>   		pr_debug("hmm range: start = 0x%lx, end = 0x%lx",
>>   			hmm_range->start, hmm_range->end);
>>   
>> -		timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
>> -
>> -retry:
>>   		r = hmm_range_fault(hmm_range);
>> -		if (unlikely(r)) {
>> -			if (r == -EBUSY && !time_after(jiffies, timeout))
>> -				goto retry;
>> +		if (unlikely(r))
>>   			goto out_free_pfns;
>> -		}
>>   
>>   		if (hmm_range->end == end)
>>   			break;
> 

