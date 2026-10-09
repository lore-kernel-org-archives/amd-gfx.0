Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695FFCA5FED
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2026 06:35:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0959210FEAE;
	Fri,  9 Oct 2026 06:35:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HOzH3+s5";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012031.outbound.protection.outlook.com
 [40.93.195.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B166410FEAE
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2026 06:35:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o1u2212MsugZJLLwel9+HeENN0Qtym1AyxXlptjr7WjWFxfOZGkK6SwMAuPiPnKBC0jE8SKWDlN4ZZU4WzG3C1jG/VK0Mr06Mtz+/TQfYlJb1tEkxyYGw4Nqyuk5JlMJf54yEbEkQP/XiR+j6D20Vqr9FRCCeig94s98USsdRS5/itMhKTuO+y6AROy2MKfgqXjFQQQogRNB1zXCZPCWSRvhtbFLDhDm0nTC75ZSkzdNObuWjMBfYez8MA6s4QLYIzy2wRThA1dSrzzK0v1kkwiuK22phnCNmNCfSOExDTTvHbzeh79WoVtT9Xkhk3t/BsuWWfqOYtIamXfgNoX6zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K55TOKvVKg7ASzwKKz6iD8YWsxG/0+AXZhgqRZiX42Y=;
 b=vd8oyw1zWoBb/sVlIBK5RDLZTvxarZ8m5YwDLmFYphYjqgymNxw8/BBTaCxJvB1PE0PgjL6B+Bqfte9HbMzRli5gDHz7dBNECUgADtmWg3OFRuduVOEzFsliH6Ppc/66qOuYC2SF/Qx8Qm9UsmtTgPFvQJy0W1QtiqgmyevJB2SPcl0B+k0fqDIW8Zd8BRQz5eYKV9oBG7cFLzoxvWHXFurNiST3QL0aAt0rrqSDqcQ/SBnwRxAGr6Y/rA5FL/s2g50nB5LrJnQKb4q+AlylTBpPkvc7nKUKBjc/CxabnUFwkNGwZ3GBo7Uoru5H/k7ay35y8bnJWZoWNLC0wR/pyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K55TOKvVKg7ASzwKKz6iD8YWsxG/0+AXZhgqRZiX42Y=;
 b=HOzH3+s5Ly6vAtjLqLLqfXqU4nbUROFpTbxM98iSXMgMpVmsawonLCvGieKa9JN0PcxD56MBAjuyLZFVLIYkY+DMZjNnaua4uNOyyWjhyzcI3/HAphb70FUNCRsqahjIkB0IGFcrz9ZtAcq7dh+NNP0fH7f1mhwiPncE7SuAQ6c=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SJ5PPF3487F9737.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::990) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Fri, 9 Oct
 2026 06:35:53 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0472.015; Fri, 9 Oct 2026
 06:35:53 +0000
Message-ID: <f9e33a65-c069-433a-b69e-f2df1e54518b@amd.com>
Date: Fri, 9 Oct 2026 12:05:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
 GPU reset
To: "Liang, Prike" <Prike.Liang@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>
References: <20260929034650.2393125-1-Prike.Liang@amd.com>
 <20260929034650.2393125-9-Prike.Liang@amd.com>
 <0375ebd0-df28-437c-b6b4-47f06d4d1a24@amd.com>
 <5ff3175a-a8fb-49d4-b40a-36ab460f8ca0@amd.com>
 <PH7PR12MB6000ADDBADE18139E2B7401BFB932@PH7PR12MB6000.namprd12.prod.outlook.com>
 <PH7PR12MB600066077324CFC6B1BAA16FFB922@PH7PR12MB6000.namprd12.prod.outlook.com>
 <7f51bd62-7a74-4cbc-95d1-5c31d52fde31@amd.com>
 <PH7PR12MB60004BE15CAB1279EFDEBEC0FB922@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <PH7PR12MB60004BE15CAB1279EFDEBEC0FB922@PH7PR12MB6000.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::15) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SJ5PPF3487F9737:EE_
X-MS-Office365-Filtering-Correlation-Id: f43e851f-3992-42fc-80d7-08df25cf90c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|11063799006|10067099003|56012099006|6133799003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wy9F61fqFJ0U3zHuyAi5X4rf/jwx/W6cn65z2tuuUcYgkMpcrtMmFlYGYY8J/9K9IJUsk1kXUE+Ain/q2D/AR4DshNgsUfU56F3uRuIa3rnyioyIok7DNj+32ciWj5zhH9jcN730A3blLfUtRfTmol3CMmxNl1qYqS2P4aEhOwNrfSJT4As5TPxeqbS299xNRrcGH/GaCXCzhVLJhqJ8/rPHYX/zNDv6foP8Xuf4sZzIcIJ83AiT7xbbKidrqlJb0mcbI1+n8Gke8ik2SFrZLbrN0JudSxFSg3A6OQaEwO6bE0aOVx+uItSRoTirETeS1xRiVzeq5e54fSlR7ULQO6qbwMAHwX2soDeZsDAOnI2hk3vsnYtekYSsP9c7lJE0DskBgvaprb593S0Vk9xR2Ou6FiNRP+ST2CT8UipkRm5UzpleTgfQCnJhk6ICQ75PXyl1e8ioSQlAFTQpdJ/vm/YltkbHJYc9A4CSFuNIAXxYJdMMhEryYjl5hDS9RWlExtbvt7es8DmdCNUDo5BhK8F3+H96T3WfOFuGGKcsVjLSjyMydb6r3xFTSQ2d2BdjKObYb4nb/6I6dwSDy1Y+v8depekd4WSdUTgG75e2LsLpXuJJ+22ac3cHyiwsy46GqGpevabXkB4L6AGSEgIIS9Snnzwv7EgyT6f7go+maEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(11063799006)(10067099003)(56012099006)(6133799003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHZlRDMvTXV1ZnJ5Q0QrNC9CWFJLYUQzZjJ2cmYyeVVkRW1YV0RjOGdQY3Uz?=
 =?utf-8?B?U2FmdW4yUjlpUmdEVWdma3RMcUgwbWFKNWlFRUV6elV6VFZBWExkTkNEemRE?=
 =?utf-8?B?YUdFL3BzeWVXZVkrUHA0ZVBtL0pndCtJWTByVlZSY2NYMFdSZU5UNHdFOEda?=
 =?utf-8?B?UGxtUU9EVklOQ2IyRmVpdnpxdW5HUmRhUVh2UHoxVCtycnRCVEZxa2VMNGxN?=
 =?utf-8?B?MDRDRm51YUEvcC9CZ2tKOHprNVlJdGVIN1RwdU5Za2RCZmo3S2EvV0Q3Qlln?=
 =?utf-8?B?QjRwMjhkcmI1WHByRkx3M2RlMjZ4UkRpUGZOY0kvOHhaK3BudytwZUpjYWVy?=
 =?utf-8?B?RjVxeXMzdm9qanJSU3NyN1ZycFhiVGVRWFRXTVA1ZHp2UExDTEtLSENpSHR5?=
 =?utf-8?B?dUF1M2dpVHR0RUdDY0FiK2VhZGlaYmxkZWo5RWI5QkY4VzZqYmNVZFlFbE1J?=
 =?utf-8?B?Vy90VGx0R2dqK2J2RFYyZkFiY01KcllGWFZpV25yeG5GcktxekgyUitPUW5h?=
 =?utf-8?B?TGFFSWdaa1lPZHRpNWkrd0h0eWdFVHREMkR6aGN0aFZpMDRXcWw4dVJMTWVv?=
 =?utf-8?B?Yyt3bzFaK2F1NVI3YzVJNnpwdjZkMStKRnkxUG9FTmR2NUlaTjdsTHR3R3J3?=
 =?utf-8?B?VVEvVVlhM0lCYkZmMGx3MHdqNzhnclFpWUZBMGsza1hNM0FkeGFhamcyZXRD?=
 =?utf-8?B?czVZdCsrbGE2cHZLaCtWSGFaNGdzMldyV2NSb3ZDREtSTnJ4SEQzMUxqaFBV?=
 =?utf-8?B?NlhzY3lVTHhxZHFxODNBY0FmenhucldacUIzN3F5RDFrbHhyTGFoMEovZjQ0?=
 =?utf-8?B?R3czb3VsQ3RjZkZMYUh0aHdIbDF1YmRMcUUyeHRNMkU3c080SHg4OTdKT1BQ?=
 =?utf-8?B?ZUQ2NkRGdnE4SVI1QUdqQnl5ZUMyU2pDeUxzUHV6SXlZMnpxS05ueE1RVWJn?=
 =?utf-8?B?NmF0cUxPQkIyTmFqYzJpM3BMWlQzQ0lJTDRxOStOdS9HVS8xSVNEd1pNNVhC?=
 =?utf-8?B?TVdaUE1MV0xNUXluWUVUcUcvRktWTGtKSzV0Ymw5OTFRUG1OTlZsTlRKZnZ0?=
 =?utf-8?B?cnVkZVlCY0pTbjMyRSt2Y1ExdXMxeUFUa3o0M0c2SFd5ZzZUSVlmaXFyWnd3?=
 =?utf-8?B?bUxGQlkveVR0U2hYVDRhNWJXV3NBUEZXam1CNlhaN2JvanZKcWxGNlErRjUz?=
 =?utf-8?B?UnlNd3RhZGFVV1FXa3R2eVgxNWxNY255Q2QvbGZKdHBuUDhsbUNFc2RhbXZ5?=
 =?utf-8?B?Y3VxVE1uM2c1NnN2ZHpFYndjZFppbUN4bVNtSVVlVWJIQ2IxczdKVjV4dlhV?=
 =?utf-8?B?M2NreFMvY1JaT21BVHk0cGgrQ2RnbDl3THVzaUlVY0dYM0crYXJKb2hIdkpL?=
 =?utf-8?B?VFk4Qkt4S1pNWkxmZ2l2NkhSNzZDUzY0eVVvcThHR3pvN3ZIbThxZWYzdWRy?=
 =?utf-8?B?SnNDeWVBZ25FYnI1R3N4SHpiNjN4QnlBbjRFZ2dCY0JDTjVxU3VBV2plN3Rq?=
 =?utf-8?B?akV1eXBlTENRTzJBNG9Td1Z5V1p0eCtRVGhROUJMaWVESks5ZkxsbXIxRGgw?=
 =?utf-8?B?N1RBM1BEdVRIMXpoNGhPZHFBMUpRVjBYTXMydlMvUUVtcjJYcStOd0cxVGR1?=
 =?utf-8?B?SVBpbkdrRG9DejV1eGp1Uyt4VGJpMjdkK2VlWEJ0RnBrdXdTYlM5MUkyNStu?=
 =?utf-8?B?SmZNWGhzMHNoU2RXUjRFcDYrWTZYZDRlSU5RSkNHN0lsbGRPNTNCRHJyN1I2?=
 =?utf-8?B?Z0RUN0x3Q2w1MUJhdzlHTkNnZjdFK0xobmtJbW5hZzFiMDNEVEYyc3dTU25G?=
 =?utf-8?B?N1drOXowZzJrZ0E3NjNyeGdBRFBCOEg4N2thV3FnbVcrLzdrQkN2Wlc3RVRz?=
 =?utf-8?B?Q1pvTkpHTVlGY0IwYnd2Q2Zpd3hhMWVKbUNUUHN5dEkvbmpZNWJLWUE2Sm1v?=
 =?utf-8?B?RE5NcXZjRnhEaXpVZHBPaFJxNktYOWpMRHdPKzFsYTFlWTg3U0YxWDFVMTl2?=
 =?utf-8?B?bG9kNWZDVkxReWxrenhkQklvNWNLUG1YR21wdVlnSGZHSEhYOVNWWlV3ckd2?=
 =?utf-8?B?QTJhbmFXZnhPYllmUklSWVV0djVyc1RET2hXazBteGZjSXhuZDNpWFEvQTRk?=
 =?utf-8?B?aHVoTktzSUFtejk5bDUvTUJUeHc2eGNVZ0x5NUxyalNKeXVoV0FQNXp0enRR?=
 =?utf-8?B?eVBmNzk1dnRlckIzUTR1WWFsWnp5WThIdVE3dUxaRUtxYmc0RjJyWXJCMTk5?=
 =?utf-8?B?RzliWVZtT3pkZXRGOS94M01mWUM3ZFpyclVVZ3k3dlFVS0xpZ0h1a2RWN280?=
 =?utf-8?Q?B8tCYj1i25P2zbVwME?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f43e851f-3992-42fc-80d7-08df25cf90c8
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 06:35:52.9767 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h4+VtTzFrqEOrPI8zFPaHA7kACovs3JdYN3Ugq60FlLua7cDP9IHJIsAaT6FciNb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF3487F9737
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



On 09-Oct-26 11:49 AM, Liang, Prike wrote:
> AMD General
> 
> Regards,
>        Prike
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Friday, October 9, 2026 12:50 PM
>> To: Liang, Prike <Prike.Liang@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly
>> <Vitaly.Prosyak@amd.com>
>> Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle work across
>> GPU reset
>>
>>
>>
>> On 09-Oct-26 9:13 AM, Liang, Prike wrote:
>>> AMD General
>>>
>>> Regards,
>>>         Prike
>>>
>>>> -----Original Message-----
>>>> From: Liang, Prike
>>>> Sent: Thursday, October 8, 2026 8:42 PM
>>>> To: Koenig, Christian <Christian.Koenig@amd.com>; Lazar, Lijo
>>>> <Lijo.Lazar@amd.com>; amd-gfx@lists.freedesktop.org
>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly
>>>> <Vitaly.Prosyak@amd.com>
>>>> Subject: RE: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle
>>>> work across GPU reset
>>>>
>>>>
>>>>
>>>> Regards,
>>>>         Prike
>>>>
>>>>> -----Original Message-----
>>>>> From: Koenig, Christian <Christian.Koenig@amd.com>
>>>>> Sent: Thursday, October 8, 2026 8:34 PM
>>>>> To: Lazar, Lijo <Lijo.Lazar@amd.com>; Liang, Prike
>>>>> <Prike.Liang@amd.com>; amd- gfx@lists.freedesktop.org
>>>>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Prosyak, Vitaly
>>>>> <Vitaly.Prosyak@amd.com>
>>>>> Subject: Re: [PATCH v2 09/14] drm/amdgpu: defer JPEG and VCN idle
>>>>> work across GPU reset
>>>>>
>>>>> On 10/8/26 14:17, Lazar, Lijo wrote:
>>>>>>
>>>>>>
>>>>>> On 29-Sep-26 9:16 AM, Prike Liang wrote:
>>>>>>> Protect media idle workers with a reset-domain read trylock. On
>>>>>>> contention, requeue the idle timeout and return without hardware
>>>>>>> access. Keep the ordinary end-use scheduling event, including from
>>>>>>> reset-time ring tests, so otherwise idle engines eventually power
>>>>>>> down and VCN
>>>>> drops its profile.
>>>>>>>
>>>>>>> A blocking read acquisition would deadlock with reset-time
>>>>>>> synchronous cancellation of these workers, so the workers must
>>>>>>> only try the
>>>> lock.
>>>>>>>
>>>>>>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>>>>>>> ---
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c | 7 +++++++
>>>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c  | 7 +++++++
>>>>>>>     2 files changed, 14 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>>>> index 9887a4f99aed..7b10260ad0d4 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_jpeg.c
>>>>>>> @@ -114,6 +114,12 @@ static void
>>>>>>> amdgpu_jpeg_idle_work_handler(struct
>>>>>>> work_struct *work)
>>>>>>>         unsigned int fences = 0;
>>>>>>>         unsigned int i, j;
>>>>>>>     +    /* Reset may cancel this worker synchronously while holding
>>>>>>> the writer. */
>>>>>>> +    if (!down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> +        schedule_delayed_work(&adev->jpeg.idle_work,
>>>>>>> +JPEG_IDLE_TIMEOUT);
>>>>>>
>>>>>> Is there any need to schedule this work here? Being not able to get
>>>>>> the lock
>>>>> indicates that a reset is in progress already.
>>>>>
>>>>> Yeah agree. We should just block for the GPU reset to finish.
>>>>>
>>>>> So a simple down_read(&adev->reset_domain->sem) should do it.
>>>>
>>>> This patch wants to schedule a delay idle work during processing a
>>>> gpu reset process, and then retry to run the VCN idle at the next scheduled loop.
>>>
>>> A potential deadlock can occur if the VCN/JPEG idle worker runs during a GPU
>> reset while performing a blocking wait for the reset to complete. This patch resolves
>> the issue by using a retry-based wait on the GPU reset semaphore within the idle
>> worker callback.
>>>
>>
>> VCN is going to be idle after a reset. The next idle worker will be scheduled after a
>> fresh job submission is complete. Why we need to reschedule idle work here?
> 
> If the VCN idle worker runs while GPU reset holds the semaphore, returning without rescheduling could leave VCN ungated if no new jobs arrive. However, blocking on the semaphore in VCN idle worker could deadlock because the reset path may synchronously cancel the worker while holding the semaphore. Using a trylock and rescheduling on contention avoids this deadlock while ensuring VCN can be power gated once reset completes.
> 

Could you clarify on the ungated part? Typically after reset, VCN 
ring/ib tests are run. After that it should go to idle similar to a 
driver load scenario.

Thanks,
Lijo

> Thanks,
> Prike
> 
>> Thanks,
>> Lijo
>>
>>> Thanks,
>>>    Prike
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>>
>>>>>> Thanks,
>>>>>> Lijo
>>>>>>
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>>         for (i = 0; i < adev->jpeg.num_jpeg_inst; ++i) {
>>>>>>>             if (adev->jpeg.harvest_config & (1U << i))
>>>>>>>                 continue;
>>>>>>> @@ -129,6 +135,7 @@ static void
>>>>>>> amdgpu_jpeg_idle_work_handler(struct
>>>>>>> work_struct *work)
>>>>>>>             mutex_unlock(&adev->jpeg.jpeg_pg_lock);
>>>>>>>         } else
>>>>>>>             schedule_delayed_work(&adev->jpeg.idle_work,
>>>>>>> JPEG_IDLE_TIMEOUT);
>>>>>>> +    up_read(&adev->reset_domain->sem);
>>>>>>>     }
>>>>>>>       void amdgpu_jpeg_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> index 17db7264269e..f851a6ecea1b 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c
>>>>>>> @@ -470,6 +470,12 @@ static void
>>>>>>> amdgpu_vcn_idle_work_handler(struct
>>>>>>> work_struct *work)
>>>>>>>         if (adev->vcn.harvest_config & (1 << i))
>>>>>>>             return;
>>>>>>>     +    /* Reset may cancel this worker synchronously while holding
>>>>>>> the writer. */
>>>>>>> +    if (!down_read_trylock(&adev->reset_domain->sem)) {
>>>>>>> +        schedule_delayed_work(&vcn_inst->idle_work,
>>>>>>> +VCN_IDLE_TIMEOUT);
>>>>>>> +        return;
>>>>>>> +    }
>>>>>>> +
>>>>>>>         for (j = 0; j < adev->vcn.inst[i].num_enc_rings; ++j)
>>>>>>>             fence[i] +=
>>>>>>> amdgpu_fence_count_emitted(&vcn_inst->ring_enc[j]);
>>>>>>>     @@ -499,6 +505,7 @@ static void
>>>>>>> amdgpu_vcn_idle_work_handler(struct
>>>>>>> work_struct *work)
>>>>>>>         } else {
>>>>>>>             schedule_delayed_work(&vcn_inst->idle_work,
>>>>>>> VCN_IDLE_TIMEOUT);
>>>>>>>         }
>>>>>>> +    up_read(&adev->reset_domain->sem);
>>>>>>>     }
>>>>>>>       void amdgpu_vcn_ring_begin_use(struct amdgpu_ring *ring)
>>>>>>
>>>
> 

