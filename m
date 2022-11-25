Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD82C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Nov 2022 08:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD07B10E08B;
	Fri, 25 Nov 2022 08:33:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DD7910E08B
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Nov 2022 08:33:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H32ZqQaCOXX3msNQXmc6U09b4FRxGZq/K9BjXAs8Abu5Puw5B22Oi7O0jDPR/VgfQHFnKwv67fJ3oROcwcPidpeTYhBmOyhLAUG2QVWDGynVGklfXblnddgvMgGM65yKZYJlqp08u/BJ6ouaWODrq9dUOlJGLQhNfNVnrjVMDmC6K8P4MznsAUqw1BaIdNki/miAuxGIAKstXyXUcEOFcIPQfCyX/gMCzo0gqnJAAsfFr51J317wh+7ofLBVNuTz4gYDxVlV+FQgqls5cDAvnxE7NsGpQaLYn7wQnxJQ06UvcSIwlbFOWHlymXJI8j8o4NLizjES/MqEKK3093fwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0reQrTXBQfyYZnSnW/vOeFGSDEqX083hUa2dBvlLINo=;
 b=CNiAlnWAQQ1+CDbCW2wy0YFAhvP6tI/UlWbtE5wQ8DBMAIrwyhlIznMxFwS863yqi2/koPnFgyIvOZf2XA4/Wdl2RbQmj+t3Tbiqq9XuVHlrBv/3LxyId8vZqLq3piEQ1B+mLh83LfTb3JgHpuMjAtYlGcQdX55qccNH0tXNPn1db0l8M+vSYCIjiQVKsl8Jt6OCAk0baHv/MbQWCq1YlrxpMmDL3VF7CRdbTf/2tedVSpy9zJbSKYDANR30SpYXUFt+i3pZaiFPkwh2LIo52feI4D9YQBNl7J8z2AzLxPHFx03PLpgtuI4N9xryZQEGS8LHNIBTrt4dEnQCMRstSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0reQrTXBQfyYZnSnW/vOeFGSDEqX083hUa2dBvlLINo=;
 b=Zeiih3A/hYcS6jr2G/Sg1xwQXmGpOXmlrVk1ZboRCt5JRvakoN4Ytu8+9uGXDayYNX0FryDCAY8yhqosJuVFubPveKXOrxqEQuz9+kKxVzOKDJRpjrG07/OJudw43/fdS3bE5DJd7gT7Jk85k90bQaQewJmRsJqLAV2G7jEktmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3370.namprd12.prod.outlook.com (2603:10b6:5:38::25) by
 CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.20; Fri, 25 Nov 2022 08:33:38 +0000
Received: from DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178]) by DM6PR12MB3370.namprd12.prod.outlook.com
 ([fe80::2fd1:bdaf:af05:e178%3]) with mapi id 15.20.5857.018; Fri, 25 Nov 2022
 08:33:37 +0000
Message-ID: <52eed51e-e234-aa36-3d74-3a4f39bb1dad@amd.com>
Date: Fri, 25 Nov 2022 03:33:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] drm/amdgpu: Fix minmax error
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 AMD Graphics <amd-gfx@lists.freedesktop.org>
References: <20221124211956.264282-1-luben.tuikov@amd.com>
 <3333dfb6-cc7b-ff6b-e416-62c07cf62740@amd.com>
 <5319277f-5841-4051-2684-93b3a985197a@amd.com>
 <fc5238a2-b30d-579e-ec7d-3686238f8b12@amd.com>
From: Luben Tuikov <luben.tuikov@amd.com>
In-Reply-To: <fc5238a2-b30d-579e-ec7d-3686238f8b12@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:84::26) To DM6PR12MB3370.namprd12.prod.outlook.com
 (2603:10b6:5:38::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3370:EE_|CH2PR12MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b6a4a4-17b4-47ba-b143-08dacebfbf96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EKI0DaK6gBkAdZPAm1BSrQvyLJv70p5+ISX6cd/Ue5cunF+PFngRE/jmznkIvNkPxeaaHgzip3O9lc96bxlZ1R7+OsyzbqUfgAKA9FzecvgaGegORsSZ3B51vz5vNgt59KKTt69TdxTnp7UBX5Jvqwwc2s1u2GQep00eOmgMppgRqosb6BRqQo5hJI+l72fmje97Z8/ogl1FaU/Y1491Hv6whQ35yQXTzGfJechhLn56gJNrxadyK7zLZCKC8A4oeakjt1uRni9tX3f7K5zjM50uRj1J40veU9zUPUmQKHm01xl/uF622qS3VkU+K6goWsskVeXlL0e0X53rbN5r1J0FjQbT0QYyMEPF3eqcjEQlpD+tyPfdIy1CpjPbmODOW4Lt20d9b4qHUsnDskC+V+x70y0aaPWlcdP6qi2FGBFZMDHfhI/oL42g1r5/5/FeK1FjPvuq+t/3HUIQO6UFi9WrvBDioWol4dSjH2lmFIY/MgQL1wkGbrX+5SPpa7oZJzwQ0jQvVESxvQIGtQrGNK6XA5FLppJsiiT0gSoelER5KP/3NcKC8VFnHGYTgu3n05CBa9qZzXyd/GeHJz1CFi5CpzIfhKJF27AZ6vv3pnbDEr/fHm6OQdc+SJgcMUpQEoi7xeX0f95BsUjn/u1g6RWa0z9+Yz41Qny/2dN0FG0Pz8yXFz0ihMi3qUtm8IKxCVPaq63xOf285NssIKZpdpOYQKOBwi57FvkiPtcKthI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3370.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(451199015)(36756003)(6486002)(478600001)(26005)(38100700002)(66946007)(66556008)(66476007)(4326008)(8676002)(31696002)(41300700001)(86362001)(4001150100001)(110136005)(316002)(54906003)(44832011)(5660300002)(8936002)(186003)(66574015)(2616005)(31686004)(83380400001)(6512007)(6506007)(2906002)(53546011)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkVONTlsRS9jSFpPUTUzYzV5c2pBTDFDM2F3K3pMeXY3NWlBN1poUFdPZFV3?=
 =?utf-8?B?VXB0Mlk4bWRDQUl6bHRRc1daNGNZU0h6MnNBaTFaaFdkRllTU2NFUnBQbTc1?=
 =?utf-8?B?dktNTldwQ1puaitLY2w0eVZ0NGhjUHJJYmJGT1NTaU5Ta1BDN2ptaDJnZTJ1?=
 =?utf-8?B?a2RuUHRtVzBvNzNRZERvWEZmN0tiZU10OU15Y2JPeDNzRC9hb2M5SDhVSkQ1?=
 =?utf-8?B?TEdtZk9ucXVzemoySURNbi9ZajB5ZjFWOXVZY1g3ZXRpOXpjU2FwNDdaWTJs?=
 =?utf-8?B?RzR1ZDNyWEZHamtaQ3ljbDk3RklvbWdHZC9OQXI1b2o0YjRiM2RUMW9KUnJL?=
 =?utf-8?B?RUY0dWhHbGRvaDFrZEVOREt3dlN3WDV0c3RhdTcycmtWS2dKektteW5xeEN4?=
 =?utf-8?B?UGlubHlxa2FlOEtnd2xmZG4wRm1wNTBSTVN3ZVl6RVhlbmFjSm9pbEFNWllr?=
 =?utf-8?B?b1hsZFR3SU9MS3JBM0g5MDNvVG1hWHZ2V2lCS1B1c0gxK3FhV3UvWGlOdjZR?=
 =?utf-8?B?aHk5OFMvSkVuTlNDdVRUVjloclN4N2RzSGlCdzRCY0JMelY5NVNIVEdia1dE?=
 =?utf-8?B?SW1TZTJJYmFkNWlHMk9uR2V6VnRMYWNhNkh1Vk0yZktlUEVVRDZ5YjI3QXNq?=
 =?utf-8?B?a1FBbDV1ZWdCMDBQNjVxdDk5aXVlMHQvQ3A5T0ZkRmh1Z0x4TzZPYkdKK001?=
 =?utf-8?B?UkswNStEWDdnUG0wcmVnanMxczE4Q042aWsxbjdYaStoeVJMZkZQZGNTYXZm?=
 =?utf-8?B?Ym9YQktLYktkQWN0Z0Nra1p1OGxjcTZOQjd3NFA1QW5tRTQ5eUd6S2dsSGlC?=
 =?utf-8?B?Z2RCN1FlKzR2RXk2N1YzU3RPMjBqOTAxeGNwZ0l2TFpoQzN0b01LampYYzZm?=
 =?utf-8?B?WWdCeGYwWnhrSFZTTmorTnhUUHpBZVhqaVhqTXNDU1hPUWxTbElTQ2IzdzNx?=
 =?utf-8?B?T3hNVU9KSitMbmRqaDRLUjY5RjhrTHZyZkZSKzhSelU1MmRaNGdrQmt6ZldN?=
 =?utf-8?B?bStLMWFqTXo0dkJvT1ZBN0FuR2VMN1FoS1lpUFZ6Z25sbDF5UzRmYzdTSVpi?=
 =?utf-8?B?UXZEOWVXanZPL0xMUHZwZTBBUjM5aHNSWmpUWXhEWXRxbmZNUmNkUm1lcVZG?=
 =?utf-8?B?Zlg0bkwyVjhEVTlTeFBTeGdCbkVWNWYwSUlsc0F6ODBRb2JRNFhzdDBwc1Fv?=
 =?utf-8?B?Wi9UalkzZDI5cWVCd2pmL0dxZnZaalZIN1kwc1J5T2srcTlHaGo3NHVkcHZD?=
 =?utf-8?B?NWdpT1NCY3B6dCtTNmlWRzFRbUYyTDV1UE1qQ2NxRWg4YkFGNnVFZGVjdW1s?=
 =?utf-8?B?SEE5dVRMNS9XeTF0eGljeTUzVXNjM1ZMQk0vUUNzQ2NBNXpWSWlNdjN0d1Rw?=
 =?utf-8?B?Zis2YVoxR0ZzM2pQcmNsakxUa05VN0FkdWlTL1dxMlhmZkJCNGN5QktRT296?=
 =?utf-8?B?bDUrR2d0ZG4vcGlEZHU1L24wbFIwbndaaVVSSm9YaXF6MFZIVWxiSVVUdjUx?=
 =?utf-8?B?bDdSUGNPT1hoby9oeG9qWGJxMDM4QkZuL3NkZVJ0VEpFVUVISnhhUjg2ZVdG?=
 =?utf-8?B?QWNWbklYRTRHeVgrVGxXc3FJUWwwcVVYQy9tOWlxWjFYWlA3aVZ3TTBrM3ps?=
 =?utf-8?B?elZZaDVZaDdodERCOVZYWUtCblZkbzh0b2pKbWhLdEpkNWNqdlljV3dtY2cx?=
 =?utf-8?B?NE5tTThOVDh4N1RNcFBUM3BhVEZLd3FpQ09MSDd1T0NYTkRUMUNCdGx1RzBl?=
 =?utf-8?B?OTFyMHQyYlk5UHcrYmV5U0VsOU9VUytrN2JiTkY2SjQyYm5QY3hsNFM0bWJa?=
 =?utf-8?B?ZHJyS3JHdUxoSEI0ckNPVEk3Z2U2SW5NMWNOeFMvWGdyQlZReWJWNGxGOUVB?=
 =?utf-8?B?VGNIUDdka2RsV0t6MjBQMVhMOFMyWkNtWmdGYzhlNFdUVktnb0dCQ0psally?=
 =?utf-8?B?Y0p4cEdyU1ZOQ1dvaWYxVFhhbGtwQWhSTDRkUEdYOExZbEh3MnQxbnpBMEF3?=
 =?utf-8?B?cStxWGM1TWNuLzF5SEZvZEJFY2hWSEpyNHFXVHRGb2tKdzFFWjZjRjNMaHNW?=
 =?utf-8?B?TFB4U1ZhNlBKanNzV1QrQ2lGZSsyWUJmeWZYNVVManNJeU9HQnBuckxRMThu?=
 =?utf-8?Q?0BN4xPaJxh4686KQjYn5tRU+9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b6a4a4-17b4-47ba-b143-08dacebfbf96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2022 08:33:37.5839 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJkEgjgatefBDiqQaiE/WJabQ65D/b6CNLhZ3eOpfvjwu2s05su6XKt46crFjG8I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908
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
Cc: Felix Kuehling <Felix.Kuehling@amd.com>, James Zhu <James.Zhu@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-11-25 02:59, Christian König wrote:
> Am 25.11.22 um 08:56 schrieb Luben Tuikov:
>> On 2022-11-25 02:45, Christian König wrote:
>>>
>>> Am 24.11.22 um 22:19 schrieb Luben Tuikov:
>>>> Fix minmax compilation error by using min_t()/max_t(), of the assignment type.
>>>>
>>>> Cc: James Zhu <James.Zhu@amd.com>
>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> Fixes: 58170a7a002ad6 ("drm/amdgpu: fix stall on CPU when allocate large system memory")
>>>> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
>>>> ---
>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 10 +++++++---
>>>>    1 file changed, 7 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> index 8a2e5716d8dba2..d22d14b0ef0c84 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>>>> @@ -191,14 +191,18 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
>>>>    	hmm_range->dev_private_owner = owner;
>>>>    
>>>>    	do {
>>>> -		hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
>>>> +		hmm_range->end = min_t(typeof(hmm_range->end),
>>>> +				       hmm_range->start + MAX_WALK_BYTE,
>>>> +				       end);
>>> Since end is a local variable I would strongly prefer to just have it
>>> use the correct type for it.
>>>
>>> Otherwise we might end up using something which doesn't work on all
>>> architectures.
>> They all appear to be "unsigned long". I thought, since we assign to
>> hmm_range->end, we use that type.
> 
> Mhm, then why does the compiler complain here?

Right... so MAX_WALK_BYTE is 2^36 ULL (diabolically defined as 64ULL<<30 :-) ),
and this is why the minmax check complains.

So, since the left-hand expression is unsigned long,
i.e.,
	hmm_range->end = min(hmm_range->start + MAX_WALK_BYTE, end);
is,
	unsigned long = min(unsigned long long, unsigned long);
The compiler complains.

I'd really prefer MAX_WALK_BYTE be less than or equal to ULONG_MAX,
and be defined as <literal>UL. I mean, why is everything in struct hmm_range
"unsigned long", but we set a high limit of 10_0000_0000h for an end, and
compare it to "end" to find the smaller? If our "end" could potentially
be 10_0000_0000h then shouldn't the members in struct hmm_range be
unsigned long long as well?

And for the timeout, we have the (now) obvious,

	timeout = max((hmm_range->end - hmm_range->start) >> 29, 1ULL);

and I don't know why we necessarily need a "1ULL", when 1UL would do just fine,
and then compilation passes for that statement. I can set this to 1UL, instead
of using max_t().

Regards,
Luben


> 
> As far as I can see "unsigned long" is correct here, but if we somehow 
> have a typecast then something is not working as expected.
> 
> Is MAX_WALK_BYTE maybe of signed type?
> 
>>
>> Would you prefer at the top of the function to define "timeout" and "end" as,
>> 	typeof(hmm_range->end) end, timeout;
> 
> Well for end that might make sense, but timeout is independent of the 
> hmm range.
> 
> Regards,
> Christian.
> 
>>
>> Regards,
>> Luben
>>
> 

