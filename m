Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85109C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 19:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A7310E6D8;
	Fri,  9 Jun 2023 19:47:57 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39D3810E6D8
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 19:47:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F4W/P4CaljCx0orhv/ls4Ub+J0S/2wX9UAlWzgKwMLrAhFagoam770YusjFthNPWlYzoE8haLN8OeB6fq5Hzsu32piQZRBNGSU0bO95PZTtinb28JbbW5xiTITb+iOHKUTeyRqSaKn9nz2dTzTVJWgIAzMk0mUbUOotddVF8qNipJvconcK3681GUIm75CA8f+OO2HkRIBH/Un4ue1OpVXrIuSk7/Vc/StT/RBzE1//jhmeV41UxfKNddkglFORUmgJx9EL6pJZU+WqU5Yg82+uwBiaQHGUcaI38OgY0iwHvOivszBIszE+tgw5o6CMxKfas7kVx8roLc+IX3t8QnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjrHyBjr6wh8WBjcrI3w1RzsynIp84tZvcnNHeBuxOw=;
 b=h9dFQWoQjo3I9NlOm/77DC6qsMBCVMW9SApS/QqKbd75zSTjXGUUkCzd46CfGHhAX5XUkiAVMRLw40OGF0oAzJCgRepFBDokbSvrKlUoU3ThaNhume4m2nCCuvHgzZg4vx4COmV4HlSazDhxWv3TMGdMCfDu6PeFHA5Gx6SonpPrxUw0sIOxcbY4otS9oG6PeTcBcBFWYSy+9iP8qbtE+Hfitm956obGbOg5NB7SltMOZgTlYl2B9EgQjGx8uVdEvkukJA6tka500D8ZOOuX0A+SUHq9XW6k3d/uk6nNNW2yZoHogAUDDnlWv50L62hvhmBTBFGzQcxU3ZmNJtU8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjrHyBjr6wh8WBjcrI3w1RzsynIp84tZvcnNHeBuxOw=;
 b=op6c5Od+GhaDkJEuqQxS++YiHevvAqmlA+QyRvhNLNTalrcorT305DzLtJeAlqCdRNndmEb+OoMwt8rybDCW8zR9qSo2bYoldLnkCW/i+OhDKg1DVjMiOkAwe/Ek7v9AqJZ6C4gGt4WpG+AOe4v0FlEN1klmk2TPQd+lzMQayPU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Fri, 9 Jun
 2023 19:47:52 +0000
Received: from SA1PR12MB8946.namprd12.prod.outlook.com
 ([fe80::7ca7:213e:8117:6920]) by SA1PR12MB8946.namprd12.prod.outlook.com
 ([fe80::7ca7:213e:8117:6920%3]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 19:47:52 +0000
Message-ID: <9093637b-5453-d38a-8911-d949aa8c5a3a@amd.com>
Date: Fri, 9 Jun 2023 15:47:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, James Zhu <James.Zhu@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230608170705.2271276-1-James.Zhu@amd.com>
 <20230608170705.2271276-4-James.Zhu@amd.com>
 <cb634cff-ccf1-1bf1-569e-c3cc503aa7eb@amd.com>
From: James Zhu <jamesz@amd.com>
Organization: AMD RTG
In-Reply-To: <cb634cff-ccf1-1bf1-569e-c3cc503aa7eb@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQXPR0101CA0041.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::18) To SA1PR12MB8946.namprd12.prod.outlook.com
 (2603:10b6:806:375::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8946:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: ac20dfa5-6b4b-4587-b95c-08db6922694e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X4+nrMeQBJLzrpX6x4vDgk5ivMFHYUlfdU8l4ldLbIRn83vHtjry+F2fsHAA/LnOPZWc/hGV50lwC3KyWBSzE8PXT4P1OTvu/NdRCRfKE/Pv/DmyzPhQGHbUUGiPl+o7uy0k+20DqVbTzHcM/nkrKTa3Dn9F6PLBDLVwWjIjxN36NMO7VW0SgIwclTssVKR2BzvFYDBySm4iXRcA2ww3b0sNn8JsnMVlICHVmzcJWKoNcX9B/77pIVtQH7OpzFRZBy9Zd+/sYuIEEqKuwdbRPKUbRMqqvzPM3DcHLuIGYBxQSgNVrpBLZU2Z5z/EbBdruH2CM7ulCBsh2THZFNwqV+lAvxrcndWJzkFpzySTBjplxBygQB7ge2VXsjl1eV0LUaQr+hpyQndljHjh6pjy3726WgaZ0M6xwccwZcKu7hOnvhStw/8wgErYyvWtmCccnWAlKTy4FvHW8mhYwlBuDYWyRXoHQac2RBaUzOxnXYqdW8hs6zOJAsjXdRRz1rZmrat4ItLUWsnFP4wsGT5jp24JIXEZOAp1sSWQM4Wx3KOdMxK06/NOjo31xYubpMOFlW6lZpeLrc2eiMmN2csIDc+vuMIYKALhdRTBDCHzS52jfWHFEu5+Jkn5KUSG584hkLRzp14G8hOl0ThiKVhmFFG+LCdDIC0J+WDc4wOMr8Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8946.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(136003)(346002)(451199021)(36916002)(6666004)(186003)(6486002)(26005)(6512007)(6506007)(53546011)(316002)(478600001)(66946007)(31696002)(66556008)(4326008)(8936002)(5660300002)(31686004)(8676002)(41300700001)(38100700002)(66476007)(110136005)(2906002)(36756003)(83380400001)(2616005)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkFnd2NRSjdLWXRMbWd5WktJOFBRRFJSK2QvRWltZ3NCSUhJa1k2WWlMOWU1?=
 =?utf-8?B?dmhHN2FMMkdFajB2Vng4QlFsZ0tTdjl5TnpBTkpvUllQZHFHK1RCMXQwZUJ2?=
 =?utf-8?B?RWtobVVodTlBK0d0eHp4VmhCcy9mYjhOSk9HTUtuUjk5Mjl2eHo5Y0dDdER6?=
 =?utf-8?B?aTFwQml4QUphc3pnSTFFbWxJbkpTeCtDYmlxNTlWbmFFTWh2a2Y4Z2ZWOUJP?=
 =?utf-8?B?ekJ1SE4wdDFCY3J5cTVpellwdU5RMUZYb2lDTlI0cnZoZEtyM09kUm92MWly?=
 =?utf-8?B?Sm9rRjRqTXVtQmNPOTQyS2tjS3NSMVhrbTR1NElRUkJCWnZ1R2JmRW83ckZF?=
 =?utf-8?B?bmd2eHJWRzlxdnI4aHRzRzFSU2ZWZFczbXVuOVh1eEhINnZxUnVMZlh5ZFFm?=
 =?utf-8?B?eU1aVXV4SVlsWnJHMzhOakxMMUlyUXJnWG1EVW90YytkRlZOeGM5MUdpcmxo?=
 =?utf-8?B?WEhPVHVVa3ppb2RVYXl0RmVIM0toZE1PNHBMQlBsbUFKNUdrRUtzVVRDbTVo?=
 =?utf-8?B?YkRwZmlPL2h3SWhCb1g1TnFiWVJQU0dsSjZSZElRRndMYUwzT1dxMlg2VWZ4?=
 =?utf-8?B?c3RJUlpMOFVhaFdYWU9LeWlVNmg1eGU2TEw3THBEVVhTZS9qbldDbUMzUllF?=
 =?utf-8?B?NEl6eG9zaEpITmhudUxtcUhwL3AwRzRybW4yTW1QRkhWaVpRSVlYZnBmQjJi?=
 =?utf-8?B?Ukl6TTBubmFkTm1TOUw2bU9rbGRoWUdkWEJhZll0dTB2dGlhc0xlaE5KRXRX?=
 =?utf-8?B?OGRzZUNwWlNFeFk1SHF3cUJxQVhVdVlXOXdNY29qMVpRUFMzdGtMZ0VqRGgz?=
 =?utf-8?B?RTN0TUwraFUwK2JzUWNBQS9sbFRQN0VmSTNaTk4rSjF6c3BsUEdxd0tNS3k2?=
 =?utf-8?B?SnpvZnQrcU5kOHV0aXpkZEcyMms4dHBwVEs5MFN1TzJMZTc4Y2RVeUFJMGpB?=
 =?utf-8?B?VTQ1eWo2UzBrVktDNTk5NnFLTXVDR0I5TDFiTWMwWlBGRU5sUlE2dWt1U24x?=
 =?utf-8?B?RWxLaFNSRWdOSkJWRnVWWXlqSDBXdWgwKzYwVFcvVlEyM3ROOGdFeEIyeDl0?=
 =?utf-8?B?eTUxL1p0cTEvNGdiQmtIMEdCT3BLcTR0RDVqQkhveTIxWVhucTRuVzg0TXNR?=
 =?utf-8?B?UHB3cDM4MGdmSWMrQzFIZzJQYTFVQWoxaU1VSnd0QjZlQkN3eDRUL05XQjVZ?=
 =?utf-8?B?QzJOL3JNSVFJMWRTN01xWUdxT0d0OHRaY2FwQUxGamQzdDJXT2VrcEVMYzZZ?=
 =?utf-8?B?bXNuN2M4U0d4bUZnbVcvVllHazlJUjhickZhaXhXU2xRbG5BMFppR25nMXZs?=
 =?utf-8?B?V2x6SkhaNHhJMzlUdGtER2RSNGJQb3RnUGxKTk02QmZtYlV4cHRsUnMzald2?=
 =?utf-8?B?NHI3NmYrdUszazlpRXo3Y3JWZTFETFJJelZxNzhGS1BnWmw4cWpweTJ6Z2pH?=
 =?utf-8?B?YkhkbHl4SHBScEk5SXVIM1I0UUJML3pLdXArSUpnVU1ONW9DVVZma3dTdnhx?=
 =?utf-8?B?NHgxWUd2WDJ6czYvR2tLL09nek9FdjB1ZWFzVGlMN3lCQXIxL2lBS1VtMTdw?=
 =?utf-8?B?eHZrcU5KZ1U1QzVyczJwaU1taW5ObUEzU3c4S1RqUzRldnpkdlRjU3AvaStR?=
 =?utf-8?B?Smsxd2VMazlrQmFRMVNIVDQ5M01vaER5c1MyUDBxZ20vZ2tsYThIWmprSURB?=
 =?utf-8?B?MEUvc25ibFhQTUxZZXBSbURweUZwUCtqbUU4WU9naENYL1VrV3Rncllpb2FQ?=
 =?utf-8?B?N0Qxd0l0OUlEcVE1eWdCYjFVQmVpOHM2ZU9EQnpoY2sweVVWdmZTNlo3cGdr?=
 =?utf-8?B?QUk5ZVBjendTV0Zpdk9Ib3dwcWpobzdCVEZyai9GK1V5TkFxVG80LzhLS2JU?=
 =?utf-8?B?V0FBMnhNRFJzMUJwZkpBcnR4LzIzMStZMEQyaGtIcXZ3VkFmU2xWZTlnWEhG?=
 =?utf-8?B?SXp3YVFkWFpxaXNKMStnMWtOOXF2Qlpqa1RRdGQ5Q3NGdlZPMlNHYmcveXEz?=
 =?utf-8?B?dXJzMWNINm5IR1lGcTJEaFRuWEdXWWl5ODliTVNYTjk2Sm12cUtjK0VMU2h2?=
 =?utf-8?B?endQT0RuZEUyY040NS9abkU4R2loZGxVUXVuT2dIZXdqT1FsMVluWHNNZzdw?=
 =?utf-8?Q?M0gn26xHYVcySl8C2blYN2RjH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac20dfa5-6b4b-4587-b95c-08db6922694e
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 19:47:52.1427 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgKwTXpyVv3z6dAaesy8GEdnD/MocwIM6NcQQIUbdrHFPzWAM7ttx3zLGlmdn7rq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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


On 2023-06-09 15:43, Felix Kuehling wrote:
>
> On 2023-06-08 13:07, James Zhu wrote:
>> Set waiter's activated flag true when event age unmatchs with 
>> last_event_age.
>>
>> Signed-off-by: James Zhu <James.Zhu@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index c7689181cc22..4c6907507190 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -41,6 +41,7 @@ struct kfd_event_waiter {
>>       wait_queue_entry_t wait;
>>       struct kfd_event *event; /* Event to wait for */
>>       bool activated;         /* Becomes true when event is signaled */
>> +    bool event_age_enabled;  /* set to true when last_event_age is 
>> non-zero */
>>   };
>>     /*
>> @@ -797,9 +798,9 @@ static struct kfd_event_waiter 
>> *alloc_event_waiters(uint32_t num_events)
>>     static int init_event_waiter(struct kfd_process *p,
>>           struct kfd_event_waiter *waiter,
>> -        uint32_t event_id)
>> +        struct kfd_event_data *event_data)
>>   {
>> -    struct kfd_event *ev = lookup_event_by_id(p, event_id);
>> +    struct kfd_event *ev = lookup_event_by_id(p, event_data->event_id);
>>         if (!ev)
>>           return -EINVAL;
>> @@ -808,6 +809,13 @@ static int init_event_waiter(struct kfd_process *p,
>>       waiter->event = ev;
>>       waiter->activated = ev->signaled;
>>       ev->signaled = ev->signaled && !ev->auto_reset;
>> +
>> +    /* last_event_age = 0 reserved for backward compatible */
>> +    waiter->event_age_enabled = 
>> !!event_data->signal_event_data.last_event_age;
>> +    if (waiter->event_age_enabled &&
>> +        ev->event_age != event_data->signal_event_data.last_event_age)
>> +        WRITE_ONCE(waiter->activated, true);
>
> This needs to check the event type. Looking at 
> event_data->signal_event_data when this is not a signal event is 
> illegal, because it is aliased in a union with other event type data.
[JZ] Sure. I will add it. Thanks!
>
> Other than that, the series looks good to me now.
>
> Regards,
>   Felix
>
>
>> +
>>       if (!waiter->activated)
>>           add_wait_queue(&ev->wq, &waiter->wait);
>>       spin_unlock(&ev->lock);
>> @@ -948,8 +956,7 @@ int kfd_wait_on_events(struct kfd_process *p,
>>               goto out_unlock;
>>           }
>>   -        ret = init_event_waiter(p, &event_waiters[i],
>> -                    event_data.event_id);
>> +        ret = init_event_waiter(p, &event_waiters[i], &event_data);
>>           if (ret)
>>               goto out_unlock;
>>       }
