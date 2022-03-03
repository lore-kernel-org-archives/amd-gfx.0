Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3B43C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 15:32:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58CB910E4CF;
	Thu,  3 Mar 2022 15:32:01 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0DA810E4CF
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 15:32:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+xUTlL9g84pRu00/zCue68b2ZSnNmFFZDuhqXLeORXoe1S3Bp3FiLvzmbzhn2GbPFX7j3DixR/lfINgRR+mrpJNTqTD25aQLQfyqcROwDi9H4MA07HlerKgvRLEt6N5l/a3N7Wl/Sr36cZBgyyLrvHTsvYlHPVbSHnfw8tLv4FPwacm8fuO2Bwz3iUUBQ16w2l02SjJzWwG5aFc8U+QAO9YDUKsa/RTTNngj65tRyN52eryalsM2D0/Iv6PTHLO6EMffj8W8QyIG3Rxh6UQ9gopavxhx0r2NOAIvnHj9SsBEVa4Pt03D4jYdIYbRRcSE6CLNmF/D4AsuFwJmUPvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asOYOmPXsnoC33rZ70+oskyL0SNDmmNIwSV9BDDiiB8=;
 b=bHHI4DBvLCbc5cSQEqVdTKpcZgqmF+E6tiJS9bYa468b3MZi4nq7RnMY0rC9C/nI+7eTK6SbVuiSGEPGK6nYBIaiOxLYQ1DSRIsnQNgL2KVByU3f6UnH1db/n3BkQMoNV5Tw46kjS58OlwXo0MEZWZZATWvyWqoCosOyN8+vO8Cs0mfO5ZSdl3fPiD/UmybigXdCzuYr/EZJbue92jHmbPXvzm542ngB00+nEjPtW8Doz3t8kK8PLNMtEiOYDmozmob31IHTkacDuRLcG1Rjt/ZaSWD5ERmvU2/gveyCtH4IsIzRPa/XaZibvb2aUP8NwBz/YL3alnyvacN7HkJrnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asOYOmPXsnoC33rZ70+oskyL0SNDmmNIwSV9BDDiiB8=;
 b=LZzXHb3KXkLOkR5t64oHwYNZsDjE0iuQ4fRe36rNJV8eKoomjjausC4tpgH5nBJhygElu01a1fMvcm4yfgxbekO/HqKYOdDzKZeCznodSpDlnL4p0ByTPgW2Fc2E+LCX63O903M5xFQ9FdnrbBuHnwEljJ+bQWMIGKiwb1pe9UY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5150.namprd12.prod.outlook.com (2603:10b6:5:391::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 15:31:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::b030:b1ba:4eb2:7fb7%6]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 15:31:57 +0000
Message-ID: <bc98ad9b-d9ab-a529-6089-70470df1d390@amd.com>
Date: Thu, 3 Mar 2022 10:31:55 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Improve concurrency of event handling
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220302200614.2439019-1-Felix.Kuehling@amd.com>
 <a09270d0-54b5-364d-fd0a-53f4fd746f25@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <a09270d0-54b5-364d-fd0a-53f4fd746f25@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0132.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::11) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e95319fa-0f18-47f0-6b32-08d9fd2af3e4
X-MS-TrafficTypeDiagnostic: DM4PR12MB5150:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5150E82A80C235E4D446481B92049@DM4PR12MB5150.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hX0y0kzJhEOmmP0cv4TNJEdT0snmtFRJlkxcQkeTVj59czW52N/NS6RERP3K9TNB5oS7PXi+0E5JkwOUTA4jYMxR2/um5a+NjFzpS/qRpaMYP+oLEa4O9LiwYVx9jdP6OHCK7jW1C5wFrsMJ6DCaLMmFArzuIdfTu0sxEnUtrSp5U1mP/N7MqQOl5QKzTRh9lrNB3ljzWQjpm7IR/q/AlG15xAxYDFI65RsH6tGRh+8WIpBvw/2trWOqwP+NRz38UQ5JuvInSV4jsCwNCsyaosmbaVITjHEeVIGEe9ijL7nuboMQbN+cg9019xBmJuperLq1LIlvmnh/1FapswAlziv6yyhr4PQe//3PkZvUoAxea2S8FltTIzjPG/OPEm9ovIdS3XRPqmKDde3ir+H1PP+PJvf0Wk1CswZM/kHMCOTzd28R7T+eWiEuQR2DkTM4Ud9Hr3DRyrB7mzKLH+YPFIywCJIvTmnWVgXLi7Tnbd2MNHezgzsqzyPdNbMEwWwY1kpKsiJlcySzGFof9c1Rllxc2is70lhndaWohu6sARuscsZbXC/hEJjnvvQezgxwMR5mcaMTbN/Cuqft1PgYoS5M24iIodONmpeequf4Jr2D9UUaHOLrgItOtwAHdEnjZrsunYIjtmRfdmnejqALdhH5GqxsYuY5/5wgIAvK8/BJT6qQ9k++eWOazD/b7CIBCr/vhKuikkNf5v4j3HYAUprf84mbtQgdbeCVHDRQM0G0Ob2Ajx+NgM2YBzNvxt8N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(66946007)(2616005)(26005)(38100700002)(186003)(2906002)(6486002)(316002)(6506007)(6512007)(83380400001)(31686004)(508600001)(5660300002)(31696002)(44832011)(36756003)(30864003)(8936002)(8676002)(4326008)(66476007)(66556008)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHNmamI4YjJsMlQyVExLUDNoaFNPU1lOU051UG5IZXJ1RU1lWnZYL1hMb28x?=
 =?utf-8?B?QmFkSWtQNW4wRXBwQnBuZ0lqNmRJQmxJV1h6V0IrdEZXdjhVVG5BbkpxYU5V?=
 =?utf-8?B?ZkZFd2JvRFNBSTIxQUtwZmk0cjkxRG1YSVNwVmsrejB4QXJMcG9IemJrV3VY?=
 =?utf-8?B?cTh0Ym0xNVB1QmJWOCtzQ3RlZFNpSkFORFpheGhXdmllbkU1RHZIeklkRFJN?=
 =?utf-8?B?NFlsSFh0WHdLQ1p1cjEzNmwzUWFSbVBBT0tBRS9FM0ZHb1NibzdFUlBqS3do?=
 =?utf-8?B?SXVPenpERGVjdHlMc3BjamdobUpKVjVObGt2UDJMc3hmRjdNTmRuWGVBQllI?=
 =?utf-8?B?NS9IemlKYTFxVnhMU3VDamNnaEIySlZmKzhxSSt4VktseHh4UW1DNlE2dXE2?=
 =?utf-8?B?ekxEUm40YjZSaTZBdU5GR3FWSDdoRE16bWVQb01EN3FVWFBYRUppcnVLTkI1?=
 =?utf-8?B?bmFEZWova2NPa01XTEdKWkhldndHSm1FVkZ1MVhDalB1T2MyQ0U0MS9PWkhw?=
 =?utf-8?B?aDVzdGZPWFdyVm40UHo3MEkrTDU0S1hMSzZVMytHRzZsQWNJTmlicGphNEhD?=
 =?utf-8?B?MEI4YTViNENjNVVxcGJ6UVUvVjZEMStCdkc3dHY3SEgwZi9zZDRKZ1Z3R2RG?=
 =?utf-8?B?bjE2NXNxY2lCbzVpNWdoNi9JVlZ4cllDUk5ONEpDNlNVdGtYRjJrKy9KV05H?=
 =?utf-8?B?QktwNFg5b1lwNnFXelFnYWZZNkx0VG5NQVhTSzRweWxFMXdnUXQzSytoa0Fj?=
 =?utf-8?B?SlVhY0xHMFhCM2tyZ2k1S0xnakwrQXFab0JaNWJsb1ViWHVoalRtNVpheW43?=
 =?utf-8?B?OElGRmszRVR5OThwWEZmL25NYndmRkNUbzJ2QmhJRFlzZkFZT3hUbDlBc1ZB?=
 =?utf-8?B?eStPV2RqZlBTeVlxNzFWOGFralQvOG1sYmp0SnlMYXhTTnhhdnZPeGowMWZD?=
 =?utf-8?B?a0pzaWFWRlJncmd3YktDQ1hUWllCeXljUmkvNVdNZlpWekZ0V3gxZWlwUys4?=
 =?utf-8?B?dG5WcWVKalF4MkFvb1diV1pBOXBwNmRYVHluTVl1QzQzWm45NEZ0TFNBekIv?=
 =?utf-8?B?OVU1SnV3Z3RqWTZmN01NSGkxNHZaOEt1b016RDVPcDF1NkpKTzdPMkhwdWhl?=
 =?utf-8?B?d29lMFdGOEIwc0VwOXdSZGE3WnVzSFdBbmNyL1B1czV3aU53cy8wSU5FeDhT?=
 =?utf-8?B?UjdHZ3JXZHR5RFc3a0tRMWhmeGQ1MHZNM0NqeFlIK1FQODhBblltMUR0bFU2?=
 =?utf-8?B?cEtnTXJxWWFtaWFyY3ZKNVdBNXViK1JmRmdJdllHd096NnFLRWR2SkkvNDZo?=
 =?utf-8?B?QmhOSmVoaDB6cmpqd2d5VFVaZlRSUDBrekxsd2JBRUtmS3ArVEJiZkU3SUoy?=
 =?utf-8?B?Yzl5YVR6dEpkdGhlZzdHOGVXekFjU2wrSmYxQk1aaE8zVldtTERsWVk0Vjgr?=
 =?utf-8?B?UFNXa2xnZm85RTM4bGdFdDU3M01zYTFvdkFXVW52NjlWZlZERXNWVVk2WXAz?=
 =?utf-8?B?QnpYSlFHWnF3K29GalZBa1hubytTSkpOekFQWW1hVjFVSW4ydzZHTmFBM2Nm?=
 =?utf-8?B?TGRGUEVERUNoY1FCUE1nV2pUbHJYWlErTDc2R3NUYWE2eU56MnNNZytlSlU3?=
 =?utf-8?B?QXl3eTdlSHR2UE5CdjlYZGE2VTEzYjljakVuRzBYUUpDY2Q0aEpSQ0hpS0Mw?=
 =?utf-8?B?WFkwZkdHaDNqemcyazVLNlh0ZlB5WjJ4U1lLWWcyc3UrRmJwRk5uNkxZd0tP?=
 =?utf-8?B?cHIyVzVFYVNlQ01vQ2tHaTJxNWV0QjlyTHE1a25kYm5GcjlCUmIzUVY4ZGJk?=
 =?utf-8?B?U0xLTC9Femg4MXBDaGU1NHNNYnUxZ3ZCbVBVOVV3R0FqNnNtU293WTB6SUdB?=
 =?utf-8?B?NVYvYVlIRWxjZHJIQU82b2haSm1vdXBSbCtSblliTnM2YWtTdEFTanNJcC9Q?=
 =?utf-8?B?RytyaWdWeWZBcDNCbENrY0F3RlNPVHBTZE5KQ0hOVFVuMm9YQ3JpUWg0NWFN?=
 =?utf-8?B?VlhZeHV1MlRHOWd3MVpRYU5KK0ZsMVF1Q3QzWVI3Q1M2bGdBTU5yRjEwSVo4?=
 =?utf-8?B?anM4TGRuSFBWeG5SczB1Znp6SHkxcWdocVE3SXdEZkgrcjBYRjR2cTBPYVZX?=
 =?utf-8?B?UzNGSWRQMVF5b0NrNEUydlFyNDdpTW1OQ3VaQlc0TDYwcGk3STdhbVRmV0Ji?=
 =?utf-8?Q?OOCRRLNasAYKx/4V48Jiy0E=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e95319fa-0f18-47f0-6b32-08d9fd2af3e4
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 15:31:57.4747 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2J4A/bsqS0RSWwjQALPW3T6oIGA3wl2YB+enF6pPHiOdTInGOLNjnh4TlD528itIIVCIUHh2QsmvMuuQyVB0kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5150
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
Cc: sean.keely@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


Am 2022-03-03 um 02:25 schrieb Christian König:
> Am 02.03.22 um 21:06 schrieb Felix Kuehling:
>> Use rcu_read_lock to read p->event_idr concurrently with other readers
>> and writers. Use p->event_mutex only for creating and destroying events
>> and in kfd_wait_on_events.
>
> That might not necessary work as you expected. rcu_read_lock() does 
> not provide barriers for the CPU cache.
>
>> Protect the contents of the kfd_event structure with a per-event
>> spinlock that can be taken inside the rcu_read_lock critical section.
>
> That helps to prevent problems for the ev structure, but it doesn't 
> protect the idr itself.

idr_find can be used safely under rcu_read_lock according to this 
comment in idr.h:

  * idr_find() is able to be called locklessly, using RCU. The caller must
  * ensure calls to this function are made within rcu_read_lock() regions.
  * Other readers (lock-free or otherwise) and modifications may be running
  * concurrently.
  *
  * It is still required that the caller manage the synchronization and
  * lifetimes of the items. So if RCU lock-free lookups are used, typically
  * this would mean that the items have their own locks, or are amenable to
  * lock-free access; and that the items are freed by RCU (or only freed after
  * having been deleted from the idr tree *and* a synchronize_rcu() grace
  * period).

It was introduced by f9c46d6ea5ce ("idr: make idr_find rcu-safe") in 2008.


>
> BTW: Why are you using an idr in the first place? I don't see the 
> lookup used anywhere.

lookup_event_by_id is just a wrapper around idr_find. It's used in 
kfd_event_destroy, kfd_set_event, kfd_reset_event and 
kfd_wait_on_events. lookup_signaled_event_by_partial_id also uses 
idr_find. It's used in kfd_signal_event_interrupt.

Regards,
   Felix


>
> Regards,
> Christian.
>
>>
>> This eliminates contention of p->event_mutex in set_event, which tends
>> to be on the critical path for dispatch latency even when busy waiting
>> is used. It also eliminates lock contention in event interrupt handlers.
>> Since the p->event_mutex is now used much less, the impact of requiring
>> it in kfd_wait_on_events should also be much smaller.
>>
>> This should improve event handling latency for processes using multiple
>> GPUs concurrently.
>>
>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 119 +++++++++++++++---------
>>   drivers/gpu/drm/amd/amdkfd/kfd_events.h |   1 +
>>   2 files changed, 78 insertions(+), 42 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> index deecccebe5b6..1726306715b2 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
>> @@ -128,8 +128,8 @@ static int 
>> allocate_event_notification_slot(struct kfd_process *p,
>>   }
>>     /*
>> - * Assumes that p->event_mutex is held and of course that p is not 
>> going
>> - * away (current or locked).
>> + * Assumes that p->event_mutex or rcu_readlock is held and of course 
>> that p is
>> + * not going away.
>>    */
>>   static struct kfd_event *lookup_event_by_id(struct kfd_process *p, 
>> uint32_t id)
>>   {
>> @@ -251,15 +251,18 @@ static void destroy_event(struct kfd_process 
>> *p, struct kfd_event *ev)
>>       struct kfd_event_waiter *waiter;
>>         /* Wake up pending waiters. They will return failure */
>> +    spin_lock(&ev->lock);
>>       list_for_each_entry(waiter, &ev->wq.head, wait.entry)
>> -        waiter->event = NULL;
>> +        WRITE_ONCE(waiter->event, NULL);
>>       wake_up_all(&ev->wq);
>> +    spin_unlock(&ev->lock);
>>         if (ev->type == KFD_EVENT_TYPE_SIGNAL ||
>>           ev->type == KFD_EVENT_TYPE_DEBUG)
>>           p->signal_event_count--;
>>         idr_remove(&p->event_idr, ev->event_id);
>> +    synchronize_rcu();
>>       kfree(ev);
>>   }
>>   @@ -392,6 +395,7 @@ int kfd_event_create(struct file *devkfd, 
>> struct kfd_process *p,
>>       ev->auto_reset = auto_reset;
>>       ev->signaled = false;
>>   +    spin_lock_init(&ev->lock);
>>       init_waitqueue_head(&ev->wq);
>>         *event_page_offset = 0;
>> @@ -466,6 +470,7 @@ int kfd_criu_restore_event(struct file *devkfd,
>>       ev->auto_reset = ev_priv->auto_reset;
>>       ev->signaled = ev_priv->signaled;
>>   +    spin_lock_init(&ev->lock);
>>       init_waitqueue_head(&ev->wq);
>>         mutex_lock(&p->event_mutex);
>> @@ -609,13 +614,13 @@ static void set_event(struct kfd_event *ev)
>>         /* Auto reset if the list is non-empty and we're waking
>>        * someone. waitqueue_active is safe here because we're
>> -     * protected by the p->event_mutex, which is also held when
>> +     * protected by the ev->lock, which is also held when
>>        * updating the wait queues in kfd_wait_on_events.
>>        */
>>       ev->signaled = !ev->auto_reset || !waitqueue_active(&ev->wq);
>>         list_for_each_entry(waiter, &ev->wq.head, wait.entry)
>> -        waiter->activated = true;
>> +        WRITE_ONCE(waiter->activated, true);
>>         wake_up_all(&ev->wq);
>>   }
>> @@ -626,16 +631,18 @@ int kfd_set_event(struct kfd_process *p, 
>> uint32_t event_id)
>>       int ret = 0;
>>       struct kfd_event *ev;
>>   -    mutex_lock(&p->event_mutex);
>> +    rcu_read_lock();
>>         ev = lookup_event_by_id(p, event_id);
>> +    spin_lock(&ev->lock);
>>         if (ev && event_can_be_cpu_signaled(ev))
>>           set_event(ev);
>>       else
>>           ret = -EINVAL;
>>   -    mutex_unlock(&p->event_mutex);
>> +    spin_unlock(&ev->lock);
>> +    rcu_read_unlock();
>>       return ret;
>>   }
>>   @@ -650,23 +657,25 @@ int kfd_reset_event(struct kfd_process *p, 
>> uint32_t event_id)
>>       int ret = 0;
>>       struct kfd_event *ev;
>>   -    mutex_lock(&p->event_mutex);
>> +    rcu_read_lock();
>>         ev = lookup_event_by_id(p, event_id);
>> +    spin_lock(&ev->lock);
>>         if (ev && event_can_be_cpu_signaled(ev))
>>           reset_event(ev);
>>       else
>>           ret = -EINVAL;
>>   -    mutex_unlock(&p->event_mutex);
>> +    spin_unlock(&ev->lock);
>> +    rcu_read_unlock();
>>       return ret;
>>     }
>>     static void acknowledge_signal(struct kfd_process *p, struct 
>> kfd_event *ev)
>>   {
>> -    page_slots(p->signal_page)[ev->event_id] = UNSIGNALED_EVENT_SLOT;
>> +    WRITE_ONCE(page_slots(p->signal_page)[ev->event_id], 
>> UNSIGNALED_EVENT_SLOT);
>>   }
>>     static void set_event_from_interrupt(struct kfd_process *p,
>> @@ -674,7 +683,9 @@ static void set_event_from_interrupt(struct 
>> kfd_process *p,
>>   {
>>       if (ev && event_can_be_gpu_signaled(ev)) {
>>           acknowledge_signal(p, ev);
>> +        spin_lock(&ev->lock);
>>           set_event(ev);
>> +        spin_unlock(&ev->lock);
>>       }
>>   }
>>   @@ -693,7 +704,7 @@ void kfd_signal_event_interrupt(u32 pasid, 
>> uint32_t partial_id,
>>       if (!p)
>>           return; /* Presumably process exited. */
>>   -    mutex_lock(&p->event_mutex);
>> +    rcu_read_lock();
>>         if (valid_id_bits)
>>           ev = lookup_signaled_event_by_partial_id(p, partial_id,
>> @@ -721,7 +732,7 @@ void kfd_signal_event_interrupt(u32 pasid, 
>> uint32_t partial_id,
>>                   if (id >= KFD_SIGNAL_EVENT_LIMIT)
>>                       break;
>>   -                if (slots[id] != UNSIGNALED_EVENT_SLOT)
>> +                if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT)
>>                       set_event_from_interrupt(p, ev);
>>               }
>>           } else {
>> @@ -730,14 +741,14 @@ void kfd_signal_event_interrupt(u32 pasid, 
>> uint32_t partial_id,
>>                * only signaled events from the IDR.
>>                */
>>               for (id = 0; id < KFD_SIGNAL_EVENT_LIMIT; id++)
>> -                if (slots[id] != UNSIGNALED_EVENT_SLOT) {
>> +                if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT) {
>>                       ev = lookup_event_by_id(p, id);
>>                       set_event_from_interrupt(p, ev);
>>                   }
>>           }
>>       }
>>   -    mutex_unlock(&p->event_mutex);
>> +    rcu_read_unlock();
>>       kfd_unref_process(p);
>>   }
>>   @@ -767,9 +778,11 @@ static int init_event_waiter_get_status(struct 
>> kfd_process *p,
>>       if (!ev)
>>           return -EINVAL;
>>   +    spin_lock(&ev->lock);
>>       waiter->event = ev;
>>       waiter->activated = ev->signaled;
>>       ev->signaled = ev->signaled && !ev->auto_reset;
>> +    spin_unlock(&ev->lock);
>>         return 0;
>>   }
>> @@ -781,8 +794,11 @@ static void 
>> init_event_waiter_add_to_waitlist(struct kfd_event_waiter *waiter)
>>       /* Only add to the wait list if we actually need to
>>        * wait on this event.
>>        */
>> -    if (!waiter->activated)
>> +    if (!waiter->activated) {
>> +        spin_lock(&ev->lock);
>>           add_wait_queue(&ev->wq, &waiter->wait);
>> +        spin_unlock(&ev->lock);
>> +    }
>>   }
>>     /* test_event_condition - Test condition of events being waited for
>> @@ -802,10 +818,10 @@ static uint32_t test_event_condition(bool all, 
>> uint32_t num_events,
>>       uint32_t activated_count = 0;
>>         for (i = 0; i < num_events; i++) {
>> -        if (!event_waiters[i].event)
>> +        if (!READ_ONCE(event_waiters[i].event))
>>               return KFD_IOC_WAIT_RESULT_FAIL;
>>   -        if (event_waiters[i].activated) {
>> +        if (READ_ONCE(event_waiters[i].activated)) {
>>               if (!all)
>>                   return KFD_IOC_WAIT_RESULT_COMPLETE;
>>   @@ -834,6 +850,8 @@ static int copy_signaled_event_data(uint32_t 
>> num_events,
>>       for (i = 0; i < num_events; i++) {
>>           waiter = &event_waiters[i];
>>           event = waiter->event;
>> +        if (!event)
>> +            return -EINVAL; /* event was destroyed */
>>           if (waiter->activated && event->type == 
>> KFD_EVENT_TYPE_MEMORY) {
>>               dst = &data[i].memory_exception_data;
>>               src = &event->memory_exception_data;
>> @@ -844,11 +862,8 @@ static int copy_signaled_event_data(uint32_t 
>> num_events,
>>       }
>>         return 0;
>> -
>>   }
>>   -
>> -
>>   static long user_timeout_to_jiffies(uint32_t user_timeout_ms)
>>   {
>>       if (user_timeout_ms == KFD_EVENT_TIMEOUT_IMMEDIATE)
>> @@ -872,9 +887,12 @@ static void free_waiters(uint32_t num_events, 
>> struct kfd_event_waiter *waiters)
>>       uint32_t i;
>>         for (i = 0; i < num_events; i++)
>> -        if (waiters[i].event)
>> +        if (waiters[i].event) {
>> +            spin_lock(&waiters[i].event->lock);
>>               remove_wait_queue(&waiters[i].event->wq,
>>                         &waiters[i].wait);
>> +            spin_unlock(&waiters[i].event->lock);
>> +        }
>>         kfree(waiters);
>>   }
>> @@ -898,6 +916,9 @@ int kfd_wait_on_events(struct kfd_process *p,
>>           goto out;
>>       }
>>   +    /* Use p->event_mutex here to protect against concurrent 
>> creation and
>> +     * destruction of events while we initialize event_waiters.
>> +     */
>>       mutex_lock(&p->event_mutex);
>>         for (i = 0; i < num_events; i++) {
>> @@ -976,14 +997,19 @@ int kfd_wait_on_events(struct kfd_process *p,
>>       }
>>       __set_current_state(TASK_RUNNING);
>>   +    mutex_lock(&p->event_mutex);
>>       /* copy_signaled_event_data may sleep. So this has to happen
>>        * after the task state is set back to RUNNING.
>> +     *
>> +     * The event may also have been destroyed after signaling. So
>> +     * copy_signaled_event_data also must confirm that the event
>> +     * still exists. Therefore this must be under the p->event_mutex
>> +     * which is also held when events are destroyed.
>>        */
>>       if (!ret && *wait_result == KFD_IOC_WAIT_RESULT_COMPLETE)
>>           ret = copy_signaled_event_data(num_events,
>>                              event_waiters, events);
>>   -    mutex_lock(&p->event_mutex);
>>   out_unlock:
>>       free_waiters(num_events, event_waiters);
>>       mutex_unlock(&p->event_mutex);
>> @@ -1042,8 +1068,7 @@ int kfd_event_mmap(struct kfd_process *p, 
>> struct vm_area_struct *vma)
>>   }
>>     /*
>> - * Assumes that p->event_mutex is held and of course
>> - * that p is not going away (current or locked).
>> + * Assumes that p is not going away.
>>    */
>>   static void lookup_events_by_type_and_signal(struct kfd_process *p,
>>           int type, void *event_data)
>> @@ -1055,6 +1080,8 @@ static void 
>> lookup_events_by_type_and_signal(struct kfd_process *p,
>>         ev_data = (struct kfd_hsa_memory_exception_data *) event_data;
>>   +    rcu_read_lock();
>> +
>>       id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>>       idr_for_each_entry_continue(&p->event_idr, ev, id)
>>           if (ev->type == type) {
>> @@ -1062,9 +1089,11 @@ static void 
>> lookup_events_by_type_and_signal(struct kfd_process *p,
>>               dev_dbg(kfd_device,
>>                       "Event found: id %X type %d",
>>                       ev->event_id, ev->type);
>> +            spin_lock(&ev->lock);
>>               set_event(ev);
>>               if (ev->type == KFD_EVENT_TYPE_MEMORY && ev_data)
>>                   ev->memory_exception_data = *ev_data;
>> +            spin_unlock(&ev->lock);
>>           }
>>         if (type == KFD_EVENT_TYPE_MEMORY) {
>> @@ -1087,6 +1116,8 @@ static void 
>> lookup_events_by_type_and_signal(struct kfd_process *p,
>>                   p->lead_thread->pid, p->pasid);
>>           }
>>       }
>> +
>> +    rcu_read_unlock();
>>   }
>>     #ifdef KFD_SUPPORT_IOMMU_V2
>> @@ -1162,16 +1193,10 @@ void kfd_signal_iommu_event(struct kfd_dev 
>> *dev, u32 pasid,
>>         if (KFD_GC_VERSION(dev) != IP_VERSION(9, 1, 0) &&
>>           KFD_GC_VERSION(dev) != IP_VERSION(9, 2, 2) &&
>> -        KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0)) {
>> -        mutex_lock(&p->event_mutex);
>> -
>> -        /* Lookup events by type and signal them */
>> +        KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0))
>>           lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_MEMORY,
>>                   &memory_exception_data);
>>   -        mutex_unlock(&p->event_mutex);
>> -    }
>> -
>>       kfd_unref_process(p);
>>   }
>>   #endif /* KFD_SUPPORT_IOMMU_V2 */
>> @@ -1188,12 +1213,7 @@ void kfd_signal_hw_exception_event(u32 pasid)
>>       if (!p)
>>           return; /* Presumably process exited. */
>>   -    mutex_lock(&p->event_mutex);
>> -
>> -    /* Lookup events by type and signal them */
>>       lookup_events_by_type_and_signal(p, 
>> KFD_EVENT_TYPE_HW_EXCEPTION, NULL);
>> -
>> -    mutex_unlock(&p->event_mutex);
>>       kfd_unref_process(p);
>>   }
>>   @@ -1229,16 +1249,19 @@ void kfd_signal_vm_fault_event(struct 
>> kfd_dev *dev, u32 pasid,
>>               info->prot_write ? 1 : 0;
>>           memory_exception_data.failure.imprecise = 0;
>>       }
>> -    mutex_lock(&p->event_mutex);
>> +
>> +    rcu_read_lock();
>>         id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>>       idr_for_each_entry_continue(&p->event_idr, ev, id)
>>           if (ev->type == KFD_EVENT_TYPE_MEMORY) {
>> +            spin_lock(&ev->lock);
>>               ev->memory_exception_data = memory_exception_data;
>>               set_event(ev);
>> +            spin_unlock(&ev->lock);
>>           }
>>   -    mutex_unlock(&p->event_mutex);
>> +    rcu_read_unlock();
>>       kfd_unref_process(p);
>>   }
>>   @@ -1272,22 +1295,28 @@ void kfd_signal_reset_event(struct kfd_dev 
>> *dev)
>>               continue;
>>           }
>>   -        mutex_lock(&p->event_mutex);
>> +        rcu_read_lock();
>> +
>>           id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>>           idr_for_each_entry_continue(&p->event_idr, ev, id) {
>>               if (ev->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
>> +                spin_lock(&ev->lock);
>>                   ev->hw_exception_data = hw_exception_data;
>>                   ev->hw_exception_data.gpu_id = user_gpu_id;
>>                   set_event(ev);
>> +                spin_unlock(&ev->lock);
>>               }
>>               if (ev->type == KFD_EVENT_TYPE_MEMORY &&
>>                   reset_cause == KFD_HW_EXCEPTION_ECC) {
>> +                spin_lock(&ev->lock);
>>                   ev->memory_exception_data = memory_exception_data;
>>                   ev->memory_exception_data.gpu_id = user_gpu_id;
>>                   set_event(ev);
>> +                spin_unlock(&ev->lock);
>>               }
>>           }
>> -        mutex_unlock(&p->event_mutex);
>> +
>> +        rcu_read_unlock();
>>       }
>>       srcu_read_unlock(&kfd_processes_srcu, idx);
>>   }
>> @@ -1320,19 +1349,25 @@ void kfd_signal_poison_consumed_event(struct 
>> kfd_dev *dev, u32 pasid)
>>       memory_exception_data.gpu_id = user_gpu_id;
>>       memory_exception_data.failure.imprecise = true;
>>   -    mutex_lock(&p->event_mutex);
>> +    rcu_read_lock();
>> +
>>       idr_for_each_entry_continue(&p->event_idr, ev, id) {
>>           if (ev->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
>> +            spin_lock(&ev->lock);
>>               ev->hw_exception_data = hw_exception_data;
>>               set_event(ev);
>> +            spin_unlock(&ev->lock);
>>           }
>>             if (ev->type == KFD_EVENT_TYPE_MEMORY) {
>> +            spin_lock(&ev->lock);
>>               ev->memory_exception_data = memory_exception_data;
>>               set_event(ev);
>> +            spin_unlock(&ev->lock);
>>           }
>>       }
>> -    mutex_unlock(&p->event_mutex);
>> +
>> +    rcu_read_unlock();
>>         /* user application will handle SIGBUS signal */
>>       send_sig(SIGBUS, p->lead_thread, 0);
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
>> index 1238af11916e..55d376f56021 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
>> @@ -59,6 +59,7 @@ struct kfd_event {
>>         int type;
>>   +    spinlock_t lock;
>>       wait_queue_head_t wq; /* List of event waiters. */
>>         /* Only for signal events. */
>
