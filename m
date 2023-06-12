Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D7CC7EE2F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 16:31:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDAD510E18D;
	Mon, 12 Jun 2023 16:31:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9710610E18D
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 16:31:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nW+Sn31uRkEdj2dJgfvoGq5ZiUCa4c/y0fIXizzSya88CmiEQ6qJjjJT3nMnGjLpHGGnGg69DYI/8xXLBah2GpETuhDRV30keWvbMTGID3HX4XGbgg2P4cYCqOfzyTtwzcXdliFtoaj93ds5R7dPZKVo2oh4cyHxSJ1D86vg9DBFh57/t56o1XJX1txUmc5rOVM/V1XMHP23xYk8bxuxrEgS7qkJq4a/ZiPv/SAYisywSTbStBf+JLQGHCSwx+uZvg+I1KQHJxJnzuh1iGK4vYvHKcgbvz5NQgjMn/qbPcnp0GqXa2apLC4SzOEROxyuPTOAj+m0serbg0TLGlmLiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nufbUMIOpTJQ/q7D6RvEgdL/Daq1duuFKFvarQC5exk=;
 b=ETyg5Ob5JU3mu3j7LjMTK0J+YnJ1+7K+9aYLGWcsBkbFw/6/GPy7YGKTdnpZT49FHhSx76s0rzcIf4Nj/PPizWmu/CkDOtTv7mCVhyDYKRLcDV7hha1Bgb40PAwpwUUgeQk8RC6U98tsaAu5K5tVgM/vm0swhOI6ybLEny9uoYXeTsH6aC95WVuF72iVovvF8Vhr6bCVOLutnYJ4eolIY6kEq4mefXmcj9GIhyKFxSBTkBp0W1xXyPqRBOiNds30tnAXvMIPyIxnL43OVjDrvrIlWWwPfJg2Syy6uBTx5lzXlaMUj7NTDJlIhoApV3deA77h6YWS/eNBkaNYSMn4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nufbUMIOpTJQ/q7D6RvEgdL/Daq1duuFKFvarQC5exk=;
 b=no2W9tniW7MKMsXDVShuGCTKtcpT1hPohyF4Z/Ms3A3Cd7Ppt18f6oe0eRFStOUcWlcny6Dc/fdb0uBhiTsZ3M6UNQXkXjirN8VvlswZCful5HdDq4b0ZSviwhikYiFQefr1RChq/jXwurwhYj6/DY6R88fJRipSEBoB3l6/68w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB8278.namprd12.prod.outlook.com (2603:10b6:208:3dc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Mon, 12 Jun
 2023 16:31:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 16:31:29 +0000
Message-ID: <64505e39-d9e2-26ea-f380-53b408bed6ef@amd.com>
Date: Mon, 12 Jun 2023 12:31:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>, "Zhu, James" <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230608170705.2271276-4-James.Zhu@amd.com>
 <20230609204350.2352248-1-James.Zhu@amd.com>
 <3380071c-2673-8e2b-762b-51c2b66baa72@amd.com>
 <DM6PR12MB50214C152AF8F6E2F6F626B09554A@DM6PR12MB5021.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <DM6PR12MB50214C152AF8F6E2F6F626B09554A@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB8278:EE_
X-MS-Office365-Filtering-Correlation-Id: 49d4f7a0-c138-4bf6-f841-08db6b627997
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: If17hcYNCnsmRi2+9FMbTw/HAnwbvFo8GK2iv372uzuw7OiydxGSFXVyPg3gSc8n4350cnXU3pr9ZDAUVc0ZIfkqoqIS/oe4pAJfA8ESkdTeX4vEtrwpCrXACAXNN8cAxoAUybPI09wGAxfMi8zsI3zud37U0Y9eguoPnqn17OFQKtwbpjlWP7GpzFJ9E5J99UcgToGgTFOAtMBmCv7qSuKizmHyzjy/CbqaDU3eENvUspeI5cU3qz8bDNgZ+9xYiOZ9TaP3EqvKMCdyGbpmE3jSyxL7ebZqejBfMc/4rEnWgiTZ2FiutbGPyKj4OvVGhSCOwYdTwr5pBvBGjr3FT6y6h5LqjTl0y64GGI27rR3LVOpmaJnxMhco3LLgxLRmX/3/aiUMp2GQnNUYKbOYayo8t8V9BGWCpXocmV00fAWN7eo4dLdU2z87xol5UYn+efbh4U2qJnBPqHFW6ujKtyo8JZ92SJ2I9O781sGuEl2VqUwMFU8w4+Gm535du7Ox641D+2nUF1fWfe3iUyq59gzuFS9nDr94gwNFJ9grSJWsx718gEptmlrY8vtfGmVFI2ckyxDVCFRdxz6Jf5J4VTlcm2NQRe5JtLNpXgMceWGYENffbLEbRDgccBTpQSJudeBbMPng6bWQgF+W/l8PKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(136003)(366004)(346002)(376002)(451199021)(6486002)(6506007)(36756003)(26005)(83380400001)(186003)(5660300002)(6512007)(41300700001)(53546011)(110136005)(8676002)(38100700002)(478600001)(8936002)(66476007)(66946007)(66556008)(316002)(31696002)(86362001)(2906002)(44832011)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1JMdXhEOW1xV1FsbHhDa1FGNEV2akN2SmpPaDZvWXl5aVhmTy8ydWxwKzRG?=
 =?utf-8?B?UVpUQjlieVhEalp0dmJhdVNjNG9sdHU0QWpUNXFLand0aHcvbkVvRjhqMHl4?=
 =?utf-8?B?c1BFTGhpWE5xcnlVdEoyRWRkazhyUEZFb283UHptcnhpZDM4K1BVckVsTG84?=
 =?utf-8?B?OW5jS1VCamIrQ3N6RnhQYm96eHRzeFBOOStEdGNqNW1vU3d6ZGNxMVV2ajF4?=
 =?utf-8?B?Sy9ZRUZydEFqSG55M2oyRmozSHJZZnZEaFFSdEZacUIrOFpxRnJMVlZPbGlQ?=
 =?utf-8?B?ZWtEUGNybEZrNE5TejIzMkFyUkhBeUxSc3pldGxZVzlYcFNhY2JjZ3VLK0JD?=
 =?utf-8?B?RmtxcHZwYS9OWVdVaFRXRnNBdDlUNTdXbFdnUDVKOU1SaUNma1FqZUpyOWwz?=
 =?utf-8?B?ZDRXYm1tZFFTSTFwVTlBeUhEVUtMd01zUlNPYnBDZjhrUnl0ZHB6R1VqcVA1?=
 =?utf-8?B?Y3REVStFVjhFRy8vclorNk0vbkk4NnJQUjNxQkRsS2xqdGNmWEh5SUxvSWRJ?=
 =?utf-8?B?YUxvY1o5RE5OUmFKdU0wdkgwcUJoMlRQbjlLanlDU0lxbzdTTEhlWEhGeTk5?=
 =?utf-8?B?cGRqVG1nYmpvRmJnMll1UTJkVDNaRVdCbGt1MmJWSGI0bnZSa3pDV1dnS21L?=
 =?utf-8?B?STI5a2RQR2xESHJUNTRiVXZMRWgyRzZpb0szSVlzK2ZBZ3Z2Nzk4dkIwTzNo?=
 =?utf-8?B?TVBpREwrb3RvZU9iWGZiRFNka3VyTUNBbFB5Qm4vUEJnekwwNVNDT1JRLzR4?=
 =?utf-8?B?Y3NrZElvTTd1blRDVXl0ZEFmWjhPSkZOOXlEQUZFS3ErUlB2SFdLQThkRnhP?=
 =?utf-8?B?T1Z5SEpjcDZxQ1k0MDJ2cHBidWNNSmxTSFRTRnhOb1p1TllIRURLa3FzUnhD?=
 =?utf-8?B?ZTQ0azNoY05JMS9qMGZpc2tOSFNWSmpmRFhzVHVpN1c3aWl1T0F6MDQxMm55?=
 =?utf-8?B?WHBtV1BickltNDlscm9aTW1xVlpNQ21ubk1wZ0gzRVkyZjZqNjRyT3d1UGZl?=
 =?utf-8?B?ZDk4eUpMLzJwRTUranoyYWtlV1gzaEV6RDhVN2c3Zzk1VlNZZlNuMTVKY3hH?=
 =?utf-8?B?YXh0aUJjdElxN0JBeHp3Q1g0OVpNOGNiMXVMU2d6V2RaaWhSdEVLTVVKYU12?=
 =?utf-8?B?a2FrN3JHT1E4TmRINm5YbGZPeWdBbklNTlBhMXNVL2JuVURPNTk2WHJkc3RX?=
 =?utf-8?B?U3lZWVFUU0FtMnRDZHNkR3l3bXNQNisrS1BJV2RUZjVRRk1XdVhFcjQ1N3Er?=
 =?utf-8?B?V1hKZWc5bXdtcmFBMnIwb3NUSjBsQ0hEUTZadDZBWVdsQWM0WWNoa2pyZnVI?=
 =?utf-8?B?SGNQR0VLcXM2N0RMT1ozcDdOZXlyNnRGc2dxU2pVNlI3cmpQUCtaNjU4YWdx?=
 =?utf-8?B?NlYzVXBlSzhVc3VGbW5vdVRSUlR3UGg2bGVLcjZQY0xBQnJJWFZZaEJyUXFs?=
 =?utf-8?B?RmxYRlVTOFVJN0s1Sm5iMjdwaDhWMDk2aEhabUpkYlVZTGJGRytQL0xkSklX?=
 =?utf-8?B?TU9EUzZuZjhUWDBtSW45aGVuUEJOZDhGYVJnV1pibGphK3dPZnE0OGtnTzRv?=
 =?utf-8?B?bU9JN2ZDWjZEdHBUak03aTdnOXo5TkJ3Z3hVTm9ZODQzdUhmZTBVY1kyQzFN?=
 =?utf-8?B?RXpqK2VaN2dNekEwQVhKOW1JWkwrTEdGUnhoUzRyWkx2MGtpOUNHdzhuVlBR?=
 =?utf-8?B?WGlxYnNkRFhmMlZGQ3loL1VWT3JzUWh4SW0rZ2Q1bVEzUFJzQWRyekF0cTZr?=
 =?utf-8?B?NzBEQTFYMHA4NEVnTVp6VW14UmxjdXlHcy96NUJUK0NGTHpwMnJrc1MyNVh6?=
 =?utf-8?B?TE1ybkVvK3dMcDQ3N1U1Z3h4U2grTy9Jb2tqeU5DSDNDN2JpaVhveXcxZFhK?=
 =?utf-8?B?OGJrQVYvQ0N6d2tuV0swV1VoNkJ1d2tSbDg3TzFrOHA0YUhKS2JjZElBb1BD?=
 =?utf-8?B?RHJNMjQ1ZE56aDRtcVhIZVN3TWtnMjhRZFlKT3JLQ1hCSCtFOGVOZU4vWjJ4?=
 =?utf-8?B?WTVtd1NDOUZIUHdzaUZNYjg4NzB1OExNWkpMQzJMelhqR1RlREVqQUR1cjRC?=
 =?utf-8?B?NE1tZzVVV3B4ZE1WUDdWRG1CMG4yemZydEZPNm1VS2IxSUcwMmRvRVRVTW9D?=
 =?utf-8?Q?b3QGOPhMKvpUNc8PO+ZGbd7y5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d4f7a0-c138-4bf6-f841-08db6b627997
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 16:31:29.5913 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y705Kvlo2IY3ADMcNfXfkXGpNIjB/b+pZj9vBVu8CwefrGT8U7AAF54/Te9cTDWLZ4gbKdUPXOoxjLy61AP9NA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8278
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

Testing for intermittent failures or race conditions is not easy. If we 
create such a test, we need to make sure it can catch the problem when 
not using the event ages, just to know that the test is good enough.

I guess it could be a parametrized test that can run with or without 
event age. Without event age, we'd expect to catch a timeout. Not 
catching a timeout would be a test failure (indicating that the test is 
not good enough). With event age it should not time out, i.e. a timeout 
would be considered a failure in this case (indicating a problem with 
the event age mechanism).

That said, I'd feel better about a ROCr test that doesn't just cover the 
KFD event age mechanism, but also its use in the ROCr implementation of 
HSA signal waiting.

Regards,
   Felix


Am 2023-06-12 um 12:19 schrieb Yat Sin, David:
> [AMD Official Use Only - General]
>
> The current ROCr patches already address my previous feedback. I am ok with the current ROCr patches.
>
> Currently, there is no ROCrtst that would stress this multiple-waiters issue. I was thinking something like the KFDTest, but with by calling the waiters from different threads. @Zhu, James Would you have time to look into this?
>
> ~David
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, June 9, 2023 6:44 PM
>> To: Zhu, James <James.Zhu@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Yat Sin, David <David.YatSin@amd.com>; Zhu, James
>> <James.Zhu@amd.com>
>> Subject: Re: [PATCH v5 3/5] drm/amdkfd: set activated flag true when event
>> age unmatchs
>>
>>   From the KFD perspective, the series is
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>> David, I looked at the ROCr and Thunk changes as well, and they look
>> reasonable to me. Do you have any feedback on these patches from a ROCr
>> point of view? Is there a reasonable stress test that could be used check that
>> this handles the race conditions as expected and allows all waiters to sleep?
>>
>> Regards,
>>     Felix
>>
>>
>> On 2023-06-09 16:43, James Zhu wrote:
>>> Set waiter's activated flag true when event age unmatchs with
>> last_event_age.
>>> -v4: add event type check
>>> -v5: improve on event age enable and activated flags
>>>
>>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdkfd/kfd_events.c | 17 +++++++++++++----
>>>    1 file changed, 13 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> index c7689181cc22..b2586a1dd35d 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>>> @@ -41,6 +41,7 @@ struct kfd_event_waiter {
>>>      wait_queue_entry_t wait;
>>>      struct kfd_event *event; /* Event to wait for */
>>>      bool activated;          /* Becomes true when event is signaled */
>>> +   bool event_age_enabled;  /* set to true when last_event_age is
>>> +non-zero */
>>>    };
>>>
>>>    /*
>>> @@ -797,9 +798,9 @@ static struct kfd_event_waiter
>>> *alloc_event_waiters(uint32_t num_events)
>>>
>>>    static int init_event_waiter(struct kfd_process *p,
>>>              struct kfd_event_waiter *waiter,
>>> -           uint32_t event_id)
>>> +           struct kfd_event_data *event_data)
>>>    {
>>> -   struct kfd_event *ev = lookup_event_by_id(p, event_id);
>>> +   struct kfd_event *ev = lookup_event_by_id(p, event_data->event_id);
>>>
>>>      if (!ev)
>>>              return -EINVAL;
>>> @@ -808,6 +809,15 @@ static int init_event_waiter(struct kfd_process *p,
>>>      waiter->event = ev;
>>>      waiter->activated = ev->signaled;
>>>      ev->signaled = ev->signaled && !ev->auto_reset;
>>> +
>>> +   /* last_event_age = 0 reserved for backward compatible */
>>> +   if (waiter->event->type == KFD_EVENT_TYPE_SIGNAL &&
>>> +           event_data->signal_event_data.last_event_age) {
>>> +           waiter->event_age_enabled = true;
>>> +           if (ev->event_age != event_data-
>>> signal_event_data.last_event_age)
>>> +                   waiter->activated = true;
>>> +   }
>>> +
>>>      if (!waiter->activated)
>>>              add_wait_queue(&ev->wq, &waiter->wait);
>>>      spin_unlock(&ev->lock);
>>> @@ -948,8 +958,7 @@ int kfd_wait_on_events(struct kfd_process *p,
>>>                      goto out_unlock;
>>>              }
>>>
>>> -           ret = init_event_waiter(p, &event_waiters[i],
>>> -                                   event_data.event_id);
>>> +           ret = init_event_waiter(p, &event_waiters[i], &event_data);
>>>              if (ret)
>>>                      goto out_unlock;
>>>      }
