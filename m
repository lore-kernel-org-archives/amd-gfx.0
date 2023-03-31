Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA6F7C76196
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Mar 2023 08:26:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4EC10F11A;
	Fri, 31 Mar 2023 08:26:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35C9F10F11A
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Mar 2023 08:26:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OjcNhwGKlPEM4brB4ZM8zwSJWFzZIfUXNOt9qKI5+rRN9qZGnN5UgAtZOezjKMDLsI+r6kadtc+eWjaqKgE2c7yv/kbplIEzE1346IedOgrGCtBqaKPHQTQnjZus4E6Od1u1OWEE5UCneADgrC+MNjSGipXa0GtwZTwbnb6qyg8vEj/obLUwx9Gb6DcOayysAFUlvG99uloE8VKk4VVpMtyTut+UyoGzlRvI8OWlhVimqm2L4q8xIpIk6WAVz17kMN8kFtg7EwRLAoSDGyUfR0hLRdvNsj+id46UkE5fuG6wXnXf1qvj1NbP9N0jjt4bgUPhJtPdAPOW4Z/a0Q4o7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXPaAoBQWxSmcY9BvN+pMLOWvbdhuJrGwoXOQt0aOd0=;
 b=IghYSdaYXPi7yqzZeZMl/V1eaObSBF4dt7rnBVY81GyfIFVWr8kwcPWJ1fgjjYxqD4brO0GuA2Er0eF1IZA4z7mAnV/iHa0jYNmk3OUkjDpAE7roLXW6ledjWSXr1jFOQoagnC5+g6AtJxWHd8O0qdkiuTv7XEZLCnsbfi8eueRBl+YjD6lanwBnb6PFWXGrOf421/rDkXXzsokn6QDob/xGVwDPdEEKW/Y7Kmvs2XysKdTHmGbkLAiZcLf0MzWJDN8KDBgDX9Zz8JObbLjPxGox3hBkdpTWDkWVyDoIIW5ouwA0RWST/Gxa05cYzi65sxnCdDifFncH7fluxM3AHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXPaAoBQWxSmcY9BvN+pMLOWvbdhuJrGwoXOQt0aOd0=;
 b=CC+B0cnnNOTpBttN1VkI1igwxta0y5bhgxNJQIO+BiOaSHuVE2u08J9S+OPWbubOjTwWCj1M9Uxfl1BMoiGjCf24lutgMiAbKmiu17jgBpEEf6vpFZOXLv8Zb+peTOve+qh2Z5ODKhIkPE32MdwBxP5hLs52JPkx0A3nui/IwcU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW5PR12MB5652.namprd12.prod.outlook.com (2603:10b6:303:1a0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Fri, 31 Mar
 2023 08:26:39 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::755d:fed:c4a:bf05%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 08:26:39 +0000
Message-ID: <ad722b47-16ca-458e-8419-41ed2698faae@amd.com>
Date: Fri, 31 Mar 2023 10:26:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 07/16] drm/amdgpu: add helper to create doorbell pages
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20230329154753.1261-1-shashank.sharma@amd.com>
 <20230329154753.1261-8-shashank.sharma@amd.com>
 <d03dba54-9f68-60ef-67ab-0d58245632d6@amd.com>
 <128791c7-2b84-386d-cb65-55cae5f5c835@amd.com>
 <cd1ca61d-c31b-4e91-9fa3-c41f3f8339e4@amd.com>
 <de8de75c-d561-7d53-e042-a1f4f8eef837@amd.com>
 <CADnq5_O_rJYcUXhf+tDaeog2cEZLvDnzz5d=AJ5pTHcWvyrdCA@mail.gmail.com>
 <8dca209b-e508-5e4a-d72f-7090fa99519e@amd.com>
 <CADnq5_OeDEvSwm+oJB-hAWdxpj_mNK9dRrtf1hE6DMaiPMd-rg@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_OeDEvSwm+oJB-hAWdxpj_mNK9dRrtf1hE6DMaiPMd-rg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0222.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW5PR12MB5652:EE_
X-MS-Office365-Filtering-Correlation-Id: 26db249f-4eb1-4098-b9e9-08db31c1a660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PWq56tXu9WdJI9jm1LzmHRI0bFAuINSIeCAqdTeEPBqPp0Dh31RryLQF7gP0dwjNgrM6dDY2nxXc9JtwklXJ2Ta8mjavaBbfCHDdvLrkDVDC+JzNk0IQdRPiKXGNHZvVSQTjx43jtFXqu97Tp7zBdh+IfssD9PVgsNJijrd3pBi1A9y76rZDynKbppzs4m3Nc24D0vc1pMo20J8DqToNjHStzgV2OQEhfV81qmvU9nv7eyAMdwayX/RruwFhpZXxx+qhhdU7xdEOvw3oh35rInf6ZeyE6KQxu6+MjI813tCyFgh+PwKSS9zRsaMOA0e32KeeNOAhbiWUMCZrZkXmK218VjlICQtnuQpHTFRvvBVPnFSPMciMAFI+buXGZKYmGUj26j5pPSkjVKnR15ApK5uKfasvEybsdRvTYP18O/WXiqOWZq1bHCfsuJ67OZh/cUGoi81p7JTe++S5tkJ9chEcI1pl5c7Qp+T6++cK2IMzwm4qHZvZA+XH+0bZ0XteyBLyC/tm62j+J8wjFW7lOkuE+yk7KTnbKq7IV30QnSFtFYBnVBjIZTfJCbh16gUvvPROmYmP6vhoR1tW+LQ6tMRUOedsVykhEqtCYodjejeelj2zYmoMYTn6fGPVZiw39sMPwe5guRlIrsBVY24DfQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(66476007)(186003)(4326008)(6916009)(66556008)(66946007)(8676002)(2906002)(44832011)(36756003)(8936002)(5660300002)(83380400001)(41300700001)(2616005)(26005)(54906003)(478600001)(86362001)(31696002)(6666004)(38100700002)(6486002)(6512007)(6506007)(31686004)(53546011)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OGpUKzVWNFZMMTNscVVjMTJxM0JIN0JZekRpTEdPQ1ViYy9Oc2t0RzhuS0pR?=
 =?utf-8?B?eElDcVFDenVzZDBvc1p3V2NvaVhXaTFaSCtxb0Y3MENVMG43Zi9LMzc4VkNj?=
 =?utf-8?B?OHhId0hjYmF2U0pPRmhZWWpzZ0hmMlJsOEJNSXdHRGhidzQ1Vmlibm1RUlhQ?=
 =?utf-8?B?S2lVK2FHWGZFY0pwc2k2NjBEYjd3ZXNmNUVySDQ5TXdneDdGN1RHRXI2S0RG?=
 =?utf-8?B?S2ZseE9LOEp1cDFVZWZXNFlNMGxJcFJ2a0h2Q2tGVThjOUVKZksrOEVwTFcw?=
 =?utf-8?B?NFdwSkRyelpudUpVR1dBbGJLa2Fmc2lWSVBZY2JBVmpQdk5ydmVUTmJtb1Zq?=
 =?utf-8?B?RnJ1U2tzMVE0MUNHeGVJeTZ5R3MrcXN1WWJUVW40VDUrOHNSczk1NUJ1MDFr?=
 =?utf-8?B?T2RKYnd0Q1Zzc3JzSUZwVit0eHFHSENFVlRYb09BL05YQkQyYU9Dc1FQb2Rz?=
 =?utf-8?B?STd2SnQyZVQ3Tk9UN1hEYmx3Q3AwUXhLeWlpNjk2UzBZMzljeWZ3aGFiTW5V?=
 =?utf-8?B?eWxkeU91cDh6R2cxeVlOYjBHU3hKdGt5VWllV2VoMGI4alJKODdGa1NnMHNG?=
 =?utf-8?B?cDd0OS9GWTJyTCtobEhGTDZVdWozVVB5UzNrOXpJaHNMZ0RVdmlWdkN6TytT?=
 =?utf-8?B?cGdEZ05QQnZRRG5KWEp6RXFYUm5BUTErdjBMbDZ4bUkzSzk5aHNlZmg5U1N5?=
 =?utf-8?B?RTNGU1lxdnJJYUhwYm1QYmtkNTFRdzZ6bFFQZlh6L3E0dFdHYVcrR3lIMVBy?=
 =?utf-8?B?V2J2d0NIZENOcHRRVHczSzBrLzlDSzZBZ0llNEF4Nk8zR2ZRQW9CcXVaY2c3?=
 =?utf-8?B?cElmaXd6RjYwcXM1SUI1czFLakI4dlpJT05Ua3gwVndMdVhTeVhWYS9NVStT?=
 =?utf-8?B?YTZya29UNVMrNWdGVFcxeVlqNnUvOHhSaXRJT1VFY1dib3hrNDgyYlNZV3JD?=
 =?utf-8?B?SzhnZDZ2Q0c3L0ZBKzZ2QjJ4R2grNWc5dko1YVhVbVBHbm5jbVVqOGlzV1ZM?=
 =?utf-8?B?VHFZK3FwNXpWUVBPT0kwR3NKamkxaDJtZXpxVWlVWTVONDlQeURtUG8vazYz?=
 =?utf-8?B?TzhxckVmVlc0cUlVdFhBcEh4bE1MZS96TXd5b3RpK0NjdEFQZmp1SlpJN2xN?=
 =?utf-8?B?YmM5QW4wU2lsVWNWMmM5c0M0Y2RldCtmUytBTnl1bXU3c3JHY1AwYVh3NXRh?=
 =?utf-8?B?R2xFTEcyeFFtcVV1bkRDbjBSQlE3eGZWTGZYNFgzb2JyQXRlQkszRlpHOXV5?=
 =?utf-8?B?T0NXZGxudmtGOHJEaThrNE0yL0s3djVBU044QnJsSnZ6OXl0NWlZWHE2cS96?=
 =?utf-8?B?N084YmVCY1JzVTlMUUJIMHBKTFgyR0Vyb3REQW9hUlRxWk5DZUlZZEtqd1Rs?=
 =?utf-8?B?U25wVldTa0VuM0J4NXpQYjY5VlpSQ3VONE5LNHp1cmEwSk0zTTJTWWdSU0hh?=
 =?utf-8?B?cEcyVEx3UkQvcUNpSk1iUWF1aGxDTHhEVFZ2cUlJdDdjQmE1eWd1K2M1VjB3?=
 =?utf-8?B?RTBwQytPTllEVjNZWCtzT1dKMmtheHpLOXlSOHp1ZFVsNGhDSCtMRXAzLzZs?=
 =?utf-8?B?R0MvcVkyc09leklVRlhNT0gvZUtIakJLWEZGWW9EOXZoeUtPMjl3eG5QNEcr?=
 =?utf-8?B?TmU1bzhtQys1cGNEVmU2a2tRNW1YSkNzanJyeWNnc05jSG5EaDUwcGE2Q2Fv?=
 =?utf-8?B?eGl4MEtsTDJPdmhTVHBFcnF2bno2Zm5wdlQzSDd1dThWN2N2elBIM3VhZ1VE?=
 =?utf-8?B?ZlNhV25mNXJ4dGdVOVowR0VtSTlRU1N3VjVyYWNnVENvVEZoZStvK1huMTNU?=
 =?utf-8?B?TExvTmdBenhmMzdVbTVuS0JZalVHSmJsY2ROTS81VzgwQTZlcXd5YjNRWkRH?=
 =?utf-8?B?NGxOVS9ONWRlOE1pU3BmNVBnOU9zU3V1QXV5VHBQVlJaek0vMmNPVmo4elJX?=
 =?utf-8?B?S2crK3pwSDBNMkVZY0w1ZFN5NnV3MUQxR2NmZDRKbjB6L2JQVktwSnA2QzJG?=
 =?utf-8?B?dEpUelBaNkk4elRlSU1icmoyVEZBK1l5ODFoNHJ6bmpScmF6ZlFhcGEvd2hC?=
 =?utf-8?B?Z2JQV01zZnFiWnRkMUhSWmtVdzBZMzVtK1NpVjZ4OTNuVnpjelVzZTlqNmda?=
 =?utf-8?Q?Io8B5sCHDyqawhzprUsZcsY9R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26db249f-4eb1-4098-b9e9-08db31c1a660
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 08:26:39.5906 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4ZKP1rxVVM4pdBtqspD6ZMrfHRa5GTKzmoLaIL/yjBY4oI0RnjGomdy6kOGjqnw3WmJLUHo60ccSHf/Yi5CnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5652
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling <felix.kuehling@amd.com>,
 amd-gfx@lists.freedesktop.org, Luben Tuikov <luben.tuikov@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Shashank Sharma <contactshashanksharma@gmail.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 30/03/2023 22:35, Alex Deucher wrote:
> On Thu, Mar 30, 2023 at 11:21 AM Shashank Sharma
> <shashank.sharma@amd.com> wrote:
>>
>> On 30/03/2023 16:55, Alex Deucher wrote:
>>> On Thu, Mar 30, 2023 at 10:34 AM Shashank Sharma
>>> <shashank.sharma@amd.com> wrote:
>>>> On 30/03/2023 16:15, Luben Tuikov wrote:
>>>>> On 2023-03-30 10:04, Shashank Sharma wrote:
>>>>>> On 30/03/2023 15:42, Luben Tuikov wrote:
>>>>>>> On 2023-03-29 11:47, Shashank Sharma wrote:
>>>>>>>> From: Shashank Sharma <contactshashanksharma@gmail.com>
>>>>>>>>
>>>>>>>> This patch adds helper functions to create and free doorbell
>>>>>>>> pages for kernel objects.
>>>>>>>>
>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>> Cc: Christian Koenig <christian.koenig@amd.com>
>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>> ---
>>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h  | 41 ++++++++++++++++
>>>>>>>>      .../gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c  | 49 +++++++++++++++++++
>>>>>>>>      2 files changed, 90 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>>>> index f9c3b77bf65d..6581b78fe438 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell.h
>>>>>>>> @@ -27,6 +27,24 @@
>>>>>>>>      /*
>>>>>>>>       * GPU doorbell structures, functions & helpers
>>>>>>>>       */
>>>>>>>> +
>>>>>>>> +/* Structure to hold doorbell pages from PCI doorbell BAR */
>>>>>>>> +struct amdgpu_doorbell_obj {
>>>>>>> In the comment you say "Structure to hold ...";
>>>>>>> it is a C structure, but then in the name of a function we see "obj".
>>>>>>> (Object is something which is defined like in memory, i.e. it exists, not
>>>>>>> something which is only declared.)
>>>>>>> This is just a declaration of a structure, not an object per se.
>>>>>>> I'd call it "struct amdgpu_doorbell_struct" or just "struct amdgpu_doorbell".
>>>>>> It is similar to struct amdgpu buffer object (struct amdgpu_bo), and
>>>>>> many more existing structure.
>>>>> The amdpgu_bo is very different than a structure describing a doorbell.
>>>>> The doorbell description isn't really "an object". I understand
>>>>> the enthusiasm, but it is really not "an object". It's just a doorbell
>>>>> description. :-)
>>>> amdgpu_bo is page of ttm_memory with additional information,
>>>>
>>>> amdgpu_doorbell_obj is a page of ttm_doorbells with additional information
>>>>
>>>> (it is not just one doorbell description)
>>>>
>>>> I don't see a problem here.
>>> I find the new API confusing.  I would expect to see
>>> amdgpu_bo_create_kernel(...DOORBELL...), amdgpu_bo_reserve(),
>>> amdgpu_bo_kmap(), etc.  That makes it consistent with the other
>>> resource pools that we manage in ttm.
>> I am assuming here you are talking about why do we need
>> amdgpu_doorbell_page_create()/free() API here.
>>
>> The wrappers here allow us to do additional book keeping work.
>>
>> For example:
>>
>> - We need to validate kernel doorbell writes, which means we need the
>> range of kernel doorbells.
>>
>> - There are 3 kernel doorbell pages, for KGD, KFD and MES. These are non
>> consecutive pages.
>>
>> - While we do doorbell_write in kernel, we need to check if this index
>> is correct, which means:
>>
>> kgd_doobrell_min < index < kgd_doorbell_max
>>
>> kfd_doobrell_min < index < kgd_doorbell_max
>>
>> mes_doobrell_min < index < kgd_doorbell_max
>>
>> - which means we need start/end limits set at every object.
>>
>> - we have to either do this work at each place where we want to call
>> amdgpu_bo_create(DOORBELL)
>>
>>     which means KFD, KGD and MES all places (which will look irrelevant
>> in the context)
>>
>>    or we can do this in one place, which is the doorbell wrapper API.
>>
>>
>> Please see patch 10 for this range check.
> I don't think we need the range checks for anything other than the
> KGD.  The MES stuff should just use the same allocation as KGD.  KFD
> has their own mapping in kfd_doorbell.c and they don't use the
> WDOORBELL[64] macros.
>
> Alex

Noted, I will remove the book keeping and the wrapper.

- Shashank

>>
>> - Shashank
>>
>>
>> now kfd is setting start/end limits by calling
>> amdgpu_get_doorbell_index() function.
>>
>>> Alex
>>>
>>>> - Shashank
>>>>
>>>>> Regards,
>>>>> Luben
>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>> Then in the definition, you can call it an object/objects, if you'd like,
>>>>>>> like "struct amdgpu_doorbell *doorb_object[];" then you can say
>>>>>>> "db = doorb_object[i]";
>>>>>>>
>>>>>>> Regards,
>>>>>>> Luben
>>>>>>>
>>>>>>>> +  struct amdgpu_bo *bo;
>>>>>>>> +  uint64_t gpu_addr;
>>>>>>>> +  uint32_t *cpu_addr;
>>>>>>>> +  uint32_t size;
>>>>>>>> +
>>>>>>>> +  /* First index in this object */
>>>>>>>> +  uint32_t start;
>>>>>>>> +
>>>>>>>> +  /* Last index in this object */
>>>>>>>> +  uint32_t end;
>>>>>>>> +
>>>>>>>> +  /* bitmap for dynamic doorbell allocation from this object */
>>>>>>>> +  unsigned long *doorbell_bitmap;
>>>>>>>> +};
>>>>>>>> +
>>>>>>>>      struct amdgpu_doorbell {
>>>>>>>>              /* doorbell mmio */
>>>>>>>>              resource_size_t         base;
>>>>>>>> @@ -328,6 +346,29 @@ int amdgpu_device_doorbell_init(struct amdgpu_device *adev);
>>>>>>>>       */
>>>>>>>>      void amdgpu_device_doorbell_fini(struct amdgpu_device *adev);
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>>>>>>> + *
>>>>>>>> + * @adev: amdgpu_device pointer
>>>>>>>> + *
>>>>>>>> + * @db_age: previously allocated doobell page details
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>>>>>>> +                          struct amdgpu_doorbell_obj *db_obj);
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>>>>>>> + *
>>>>>>>> + * @adev: amdgpu_device pointer
>>>>>>>> + *
>>>>>>>> + * @db_age: doobell page structure to fill details with
>>>>>>>> + *
>>>>>>>> + * returns 0 on success, else error number
>>>>>>>> + */
>>>>>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>>>>> +                          struct amdgpu_doorbell_obj *db_obj);
>>>>>>>> +
>>>>>>>>      #define RDOORBELL32(index) amdgpu_mm_rdoorbell(adev, (index))
>>>>>>>>      #define WDOORBELL32(index, v) amdgpu_mm_wdoorbell(adev, (index), (v))
>>>>>>>>      #define RDOORBELL64(index) amdgpu_mm_rdoorbell64(adev, (index))
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>>>> index 1aea92363fd3..8be15b82b545 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_doorbell_mgr.c
>>>>>>>> @@ -111,6 +111,55 @@ void amdgpu_mm_wdoorbell64(struct amdgpu_device *adev, u32 index, u64 v)
>>>>>>>>              }
>>>>>>>>      }
>>>>>>>>
>>>>>>>> +/**
>>>>>>>> + * amdgpu_doorbell_free_page - Free a doorbell page
>>>>>>>> + *
>>>>>>>> + * @adev: amdgpu_device pointer
>>>>>>>> + *
>>>>>>>> + * @db_age: previously allocated doobell page details
>>>>>>>> + *
>>>>>>>> + */
>>>>>>>> +void amdgpu_doorbell_free_page(struct amdgpu_device *adev,
>>>>>>>> +                                  struct amdgpu_doorbell_obj *db_obj)
>>>>>>>> +{
>>>>>>>> +  amdgpu_bo_free_kernel(&db_obj->bo,
>>>>>>>> +                        &db_obj->gpu_addr,
>>>>>>>> +                        (void **)&db_obj->cpu_addr);
>>>>>>>> +
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +/**
>>>>>>>> + * amdgpu_doorbell_alloc_page - create a page from doorbell pool
>>>>>>>> + *
>>>>>>>> + * @adev: amdgpu_device pointer
>>>>>>>> + *
>>>>>>>> + * @db_age: doobell page structure to fill details with
>>>>>>>> + *
>>>>>>>> + * returns 0 on success, else error number
>>>>>>>> + */
>>>>>>>> +int amdgpu_doorbell_alloc_page(struct amdgpu_device *adev,
>>>>>>>> +                          struct amdgpu_doorbell_obj *db_obj)
>>>>>>>> +{
>>>>>>>> +  int r;
>>>>>>>> +
>>>>>>>> +  db_obj->size = ALIGN(db_obj->size, PAGE_SIZE);
>>>>>>>> +
>>>>>>>> +  r = amdgpu_bo_create_kernel(adev,
>>>>>>>> +                              db_obj->size,
>>>>>>>> +                              PAGE_SIZE,
>>>>>>>> +                              AMDGPU_GEM_DOMAIN_DOORBELL,
>>>>>>>> +                              &db_obj->bo,
>>>>>>>> +                              &db_obj->gpu_addr,
>>>>>>>> +                              (void **)&db_obj->cpu_addr);
>>>>>>>> +
>>>>>>>> +  if (r) {
>>>>>>>> +          DRM_ERROR("Failed to create doorbell BO, err=%d\n", r);
>>>>>>>> +          return r;
>>>>>>>> +  }
>>>>>>>> +
>>>>>>>> +  return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      /*
>>>>>>>>       * GPU doorbell aperture helpers function.
>>>>>>>>       */
