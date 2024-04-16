Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3105DC4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Apr 2024 12:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C20ED10E54C;
	Tue, 16 Apr 2024 12:58:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dZw+73RE";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3943C10E54C
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Apr 2024 12:58:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5ZNLS4qhZKn8C/CY6rscg8UNR2zoljim5zNOUBMucoLSdWVs1KAZz6N9Xewpnx0sQxWeELFQI8Q7Opb0FhdJWSWNpQsdHhjb2ERCFKgsgcoCWwYZscmY0yG1kOv8gvSLByoOGs28aZE/eClpJph3La2MhRLBL1J0RpuAE78r2uggQvQcG+bES5NqhDPXBUKcipm4EKmLjeHKFccx5r8CWXq4prTopvU8MaN3PWyc+/i4s4I98v4rOg/lDJ6UPDIJFkRAjS+Dzz3o8kCO9Vz7fSl9y5GmYL3VdqJBGdBVz9kuXNv65gZidjAqhMExPnGer/5KuvD9sBItZH0XbxMTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnN2cSxj8xD2P6y7WPbrshY0puYCFwSS+bFzoChQ9jg=;
 b=UmmpTPZTBqsZkPps13EoZTTBWI45lZQniz7gy5JesGAhFBx9DVK9IDFb87eucQLVie5y0DXl++4f5R4fL0iMmSPDp2mhbc4nR7IWkL4mJTFnYaGIdDuo66VU+xZat6c/1DMxvvS6OUXc7zlQ2aW+mPrdNlYA1WE/oArO9K0DSwqab6bRkXdgYDBqbRJfylsw/2Tk7QRjJCNIEmci7+U4Mcfee4dksj1ZE/qWfCmiKmJt0fHxQaSpltml54Bqt9TN6ztBZUdj0BjqSfrzmHxQLrVCyE1PVsEPlC3k51M9Fy5lnW2uhBu38iwBPDgCHQ5qjZBiYaB1CopqyJ4cbRzK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JnN2cSxj8xD2P6y7WPbrshY0puYCFwSS+bFzoChQ9jg=;
 b=dZw+73REeIr5dDs+gd/1XY1/X8xtLDmBajWfm3o+wqYBOe+TMoLuywTkWdkpqD9EiAzScVsc38JgIRuRziTnR+kENwgK5CP2J8JZyb6Hz84L82/N30LOt11i0nQTLaVza6Sq+cfjDO7gg3H9W8jzODKInQkzRjx1qF5hQNt58WQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4342.namprd12.prod.outlook.com (2603:10b6:208:264::7)
 by PH7PR12MB6740.namprd12.prod.outlook.com (2603:10b6:510:1ab::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 12:57:57 +0000
Received: from MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3]) by MN2PR12MB4342.namprd12.prod.outlook.com
 ([fe80::c55f:19e:6896:cf3%5]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 12:57:55 +0000
Message-ID: <64f7ad42-12ef-40a2-bd1d-6c2468305eb8@amd.com>
Date: Tue, 16 Apr 2024 18:27:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clear seq64 memory on free
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20240415184837.299965-1-Arunpravin.PaneerSelvam@amd.com>
 <662576a5-4597-4a3e-bead-4b80852eb19c@gmail.com>
 <5383bac8-c097-4975-8022-181d1d2f0877@amd.com>
 <7e532341-cf37-42c9-97e3-41d10e7871e5@amd.com>
 <616481ae-9a79-4800-ab98-d45c7fbc3731@amd.com>
 <4d822dcf-a655-41a4-8d65-42cf2adfbed3@gmail.com>
From: "Paneer Selvam, Arunpravin" <arunpravin.paneerselvam@amd.com>
In-Reply-To: <4d822dcf-a655-41a4-8d65-42cf2adfbed3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0199.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::9) To MN2PR12MB4342.namprd12.prod.outlook.com
 (2603:10b6:208:264::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4342:EE_|PH7PR12MB6740:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cdf6cd8-37d1-4c81-0855-08dc5e14d551
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9kpq6Rf7kKI6Ek/AZeTZs1yhBfSz+5wqywHMoVT1SOzOEN63xnulz31n84DiD81MmBTDH85fClLzEh82TXK8BSzVb2GP8ViOsUqidF90dCQEXN0M5VvjRu3fpp0mc3ua1BfBgzcFInr6YiOrx8htmvvmaE9pKFmjTWGlxCz62fjwwuDFfO5l5EQI11C9pigVNkRUoXx33Egat+YlkUtaIW2Tn1bnOI7w3BMQhoy1roFDek7Z5E4sfh5lxkXw/BRQXQUhDZuplq+2jyVGkBAmJ3JyTEtVaVG7jzrO/Ow33gS79mfqFEh2ODufvTD+YCzniTunrxczeYzeQUHoU8Lg/jpLNWh8L2ZgM5LJ7pGHhrIabTDoYkIi758IhUYjvq1D+m+gRvimmQtMg0LoTcv+kS2fWIWzWTCGkAxQuRtt79WXYYPbQI1iWtOSYbnQZjoXOKtLtTvCF661iMVVcU1ipWVnllwKisC9QrNBW8yuJ4V+EhMyUuKJcV7xOtZ9gF2zN75NhnFFf8g8Z22zYYLlsIjaLtUcrz24YdNxPCbtOMMGeovlqoPuY82DbZcRTDu2Vx54UyM+Md0VkszA/E6Cl9vb5P1FlcBsTV61Ejxu7cQPUj6QtLS3nGTqUlWVQcoCvAJ3eyYrRwV+9Z6p+qq5/GKY2j/0J8zGI8kGLu7g1w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4342.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2Y3bDR1U2xwbjE3TkFVZkFGT1VMOGRvYjg4ek9UV2VXZ2hsZVQ4TjhYVHh1?=
 =?utf-8?B?ZjVlL0xQZ2JmaFVxSnNCcDcvQ1g2VEdFU1EwTEZaYS8wck4xdmFHRURlQlJ0?=
 =?utf-8?B?Z1dTNzNXbWUrU0NIQ2d5eUVNTitHQUlHTjhWZnBONkxyaEorTEJaODZBTGRE?=
 =?utf-8?B?bmR2RDIySU5UZXoxb2tZRzJTUkxVY1daV3FTRm1ic2hkWkd3SURYWGh2UVpS?=
 =?utf-8?B?dlcyVTNIQUtScGF6YzF1d3psUFcvT2duQlBpZFlRVzNRME41ZXlFV0V6Nzl1?=
 =?utf-8?B?bENFQlYrY3pJd2VRWHpNNEw3RWxGQ3MybmVJRElIZ1A2WXUwYmFEMXBxTzQv?=
 =?utf-8?B?eGFoenJISDlYOEh1YlJnTHk3K24vaHZUMFdpQ2RiVFZ4ZTRQVGNmZEN1OElF?=
 =?utf-8?B?c3VjaGlVYVplRTkyQzNrVitkWk1lZGNBTmdDNjlEMjl1aHEwNVBUTFdVRHR6?=
 =?utf-8?B?OE1zRFRBYnhYblhzb204MzdVRUFuZEtkNk9FOWYxZWwyNmxEckdDNTZmelpF?=
 =?utf-8?B?U0djSFJFT0tWUG1Jc3RXakkzK2dPRGk4ZzAxMTFHSEs0ZXl3K3NUYkxjMkRp?=
 =?utf-8?B?Rk94RDRpL25Qbi81UmozdjFIb1dUQmxXK251ZUNEV3hGTU90b0psWFZPTlJu?=
 =?utf-8?B?THNqQWFXNGNlaERVRFVWMlpJc1VHb2NaTnJFNTUzcTZRd2s4dlRxMGV3eG9k?=
 =?utf-8?B?MTRLZUU2dWlaUlgwZFpscjZwOEJpUXBlMjZnZVhtUmdiYnRhUEowREZMTjlI?=
 =?utf-8?B?ZGVuWWcxSVBZQjBmN1QyRXhxaDYzM2VibkdkRzBDeDFXdG1SNXZSQ3hJVHZI?=
 =?utf-8?B?R0NFVGJINzN0VUsvOG1XWEUwZHFtcUZTeGVZR1N6YUVJOVZTdWVwalZJZ1l2?=
 =?utf-8?B?TGNwMDVsQ01BTlNyNFpNU0tjMUJEMUNENzQ2dVRLSmxwWDlsTGkyT2trQ3ZS?=
 =?utf-8?B?YUl1dkxRWlh1dWVwQ0dyWHRnMUVWcjc5SThzZlMzN3NIUWRYWStxajhQa0lk?=
 =?utf-8?B?SWFjbXpnZWRua3JrMng4aGZ2cUdVTVpqdXpoalpUN1JUU1RqUWR3c2l0bEVC?=
 =?utf-8?B?RUE5SWJtSmo5TmhxNSsycDk4dDFNZkZ4VjFmd3Z5c3JFR2drQjBFRmxWVmVz?=
 =?utf-8?B?NlUvRFl6Z3BqUVRHZXNMc1hUL0luRGJBQlg3emlmd3c0UTlSc0xYL3JiWW0w?=
 =?utf-8?B?UnVhVFRLTGtpQ1dKYXc3cVlOdytZZXhuSng5SWhLOWpUYW5VWXorTTVtdVo4?=
 =?utf-8?B?YzEzWjNkY1laU0pmTGsxVzR4bkdSak42TFp0Q1l3ZlVxbTRnMVhmNnNCV2dX?=
 =?utf-8?B?SStvZUgrWU1ZeW9Zdm16cGJhSVVHUEpZU0FiM0c2dHAyWWVUMHNXaGtzM2JU?=
 =?utf-8?B?RmpLaHNqakFjN3ZPcXEwVWVMeFZVQUtqR0VScUUyNi9nTzJ2d3JCc1ZRbHFO?=
 =?utf-8?B?MUpPTThWTUlFYzhidzBNWmhhZ3JFKzZEcGhZSEtBOHdRdm5PSjlEc05uUFdU?=
 =?utf-8?B?YlBNNlhsQmtzaEo1V0t2WUpVZ3BVdVk0Y21PM08yL1daUlhkdjBnSDBhL21F?=
 =?utf-8?B?YXFDTlpsK3J0c1A0enJLOHJLcnRFUzRsMXZKWE9TT2ljQ3A4S1RJUCtrSmMx?=
 =?utf-8?B?QzA0Z3dUQ0R5UGo5ZkpTUWJBTkVLSmx0U2dhTWZ4RndXZ3Vsb0hvM0hEK1VF?=
 =?utf-8?B?QUpPb0FMS2VUZUI1MjAxS3p5MkdNYzR6NzVSWElyYUh1SE85OWluVnF0TWtU?=
 =?utf-8?B?YlRMajF1RnlxRHFhZFpZS00rTVRBUlcxVFdGNFVGMGs0RVMxRnltbGkvcm4y?=
 =?utf-8?B?ZHV2bFdHQmNSS2ZvaGRRbzk2dWN3L1cybFVxSUJkWlFRNTkrcHd0SlpSMng4?=
 =?utf-8?B?S0lCVmxZMEFqL2tQQzhMNU1oQ3pieWFRa1FQajFkY0Z0RVcxbVc0Q0JDYVVT?=
 =?utf-8?B?RU1OclRRc05TdGp3SXdEbmhMa3FxRUw3d3cweW9HZ2J2MklML3JKZDUyS0xY?=
 =?utf-8?B?dWJqb1MrN3FtL1JDUmJXeUg2d2JlN0JXS2hhVFQwUU9KbElxM2d6b3RMY3A4?=
 =?utf-8?B?SmJ0RXQ4RFpUSXdad1BmWlJGbVN0cS9STDJoVWtXN1Z5MVE5bC9jVHJBVW1X?=
 =?utf-8?Q?90UIfdyNfadFh9yN5AFxA2J7y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cdf6cd8-37d1-4c81-0855-08dc5e14d551
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4342.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 12:57:55.4020 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NOz+rywKP3a+1RJZJwVp+pkvH3hYSm9WzIArDILYLrTGksoRWFZSJ/vy1nerTzSnHN5jwT/ZgPcSUCB3S+/2Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740
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

Hi Christian,

On 4/16/2024 6:24 PM, Christian König wrote:
> Am 16.04.24 um 14:34 schrieb Paneer Selvam, Arunpravin:
>> Hi Christian,
>>
>> On 4/16/2024 5:47 PM, Christian König wrote:
>>> Am 16.04.24 um 14:16 schrieb Paneer Selvam, Arunpravin:
>>>> Hi Christian,
>>>>
>>>> On 4/16/2024 2:35 PM, Christian König wrote:
>>>>> Am 15.04.24 um 20:48 schrieb Arunpravin Paneer Selvam:
>>>>>> We should clear the memory on free. Otherwise,
>>>>>> there is a chance that we will access the previous
>>>>>> application data and this would leads to an abnormal
>>>>>> behaviour in the current application.
>>>>>
>>>>> Mhm, I would strongly expect that we initialize the seq number 
>>>>> after allocation.
>>>>>
>>>>> It could be that we also have situations were the correct start 
>>>>> value is 0xffffffff or something like that instead.
>>>>>
>>>>> Why does this matter?
>>>> when the user queue A's u64 address (fence address) is allocated to 
>>>> the newly created user queue B, we see a problem.
>>>> User queue B calls the signal IOCTL which creates a new fence 
>>>> having the wptr as the seq number, in
>>>> amdgpu_userq_fence_create function we have a check where we are 
>>>> comparing the rptr and wptr value (rptr >= wptr).
>>>> since the rptr value is read from the u64 address which has the 
>>>> user queue A's wptr data, this rptr >= wptr condition
>>>> gets satisfied and we are dropping the reference before the actual 
>>>> command gets processed in the hardware.
>>>> If we clear this u64 value on free, we dont see this problem.
>>>
>>> Yeah, but that doesn't belongs into the seq64 handling.
>>>
>>> Instead the code which allocates the seq64 during userqueue created 
>>> needs to clear it to 0.
>> sure, got it.
>
> Yeah, but fixing that aside. We should probably initialize the seq64 
> array to something like 0xdeadbeef or a similar pattern to find issues 
> were we forget to initialize the allocated slots.
yes, I will prepare a patch and send for the review.

Thanks,
Arun.
>
> Regards,
> Christian.
>
>>
>> Thanks,
>> Arun.
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Thanks,
>>>> Arun.
>>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Signed-off-by: Arunpravin Paneer Selvam 
>>>>>> <Arunpravin.PaneerSelvam@amd.com>
>>>>>> ---
>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c | 6 +++++-
>>>>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c 
>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>>>> index 4b9afc4df031..9613992c9804 100644
>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_seq64.c
>>>>>> @@ -189,10 +189,14 @@ int amdgpu_seq64_alloc(struct amdgpu_device 
>>>>>> *adev, u64 *va, u64 **cpu_addr)
>>>>>>   void amdgpu_seq64_free(struct amdgpu_device *adev, u64 va)
>>>>>>   {
>>>>>>       unsigned long bit_pos;
>>>>>> +    u64 *cpu_addr;
>>>>>>         bit_pos = (va - amdgpu_seq64_get_va_base(adev)) / 
>>>>>> sizeof(u64);
>>>>>> -    if (bit_pos < adev->seq64.num_sem)
>>>>>> +    if (bit_pos < adev->seq64.num_sem) {
>>>>>> +        cpu_addr = bit_pos + adev->seq64.cpu_base_addr;
>>>>>> +        memset(cpu_addr, 0, sizeof(u64));
>>>>>>           __clear_bit(bit_pos, adev->seq64.used);
>>>>>> +    }
>>>>>>   }
>>>>>>     /**
>>>>>
>>>>
>>>
>>
>

