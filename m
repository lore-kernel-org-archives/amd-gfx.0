Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C8AC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 15:01:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A6EE60F6F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 15:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4A6EE60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB1028972D;
	Tue, 24 Aug 2021 15:01:50 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2051.outbound.protection.outlook.com [40.107.95.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAD8B8972D
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 15:01:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/BiC8f2rlKyiv9VuhVlxjdPOj5A7O0PzK3jq9O97I9/F00ltOyKmhuK7s2PgdR7JxHVGjZ5Grek/a7deGorrVfsTImN0qTTL9k2HyFcawBz0XTzZvx/xThM2KPanAmn85wFSjbamMRGQIp7b5CMeGbjYZt2/pp6oKtcDAfl9sYbvGNqpA8+eYqV5Iutbpz20SYfRq17zhXxcuFDrzOTXxPna8JFw2io8CgLnZ0nzGQOLatIi1qGpxfor/f26yiFPFHJ6wZhYckKckRkkg+DQDbnDdKO9qfd0bJhY589P3QRw6lD2s1BPbkLBjV3MQbcilLfSCKqTI+wQuBwjILVmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gO+7k3BvRcpZInFjHc6C7hXTrf2nO1Mi30q8G+/kos=;
 b=DqymlLuO7YczTb5YbGPmwiho3DZWgDSczBam9AbosteV3ve/sOzid4FWN821d+YZE0N9yap353tgn1ahwJKslRaqrXXovCrawYNJUkGrAMzW73CgqkGn54WSzFCCmHNydUccC9vETD4IK1v5F5e/Meq7c5fojCDHak2Uh7NFCp1+D5pTJ+pIHAfBJHuspa0puo9zy7DWYkn1aW9A/zWAvEYj2fRrVRBTLVUqQIlOvPhHk4uhaxXb6U52FBLM+Q824StY6/SvCDiusdEtertdCTdpKEd8W/1d8H3HoAE41eZqTCQsJqWXBqDh7IUGPnIq0MVccY675hTeP+eoSYd3Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gO+7k3BvRcpZInFjHc6C7hXTrf2nO1Mi30q8G+/kos=;
 b=KAOwDyKYKi7fa5QDwqI7G0+FPagnYT5+ne7B6NwYBzsqy5OjOIk/sEMNFEjjcGzXXj2b01KVJeTOpGAz2fo70sDW3wEYW14pln8IvkwgvljB2jlZ3zEZo/gIhkpLrw1SinzmC+lEbdSsWUpFrxf+4iJvSDEpjtK5gowTmouWQy0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SA0PR12MB4448.namprd12.prod.outlook.com (2603:10b6:806:94::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 15:01:47 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::17c:7262:446:f400%5]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 15:01:47 +0000
Subject: Re: [PATCH] drm/sched: fix the bug of time out calculation
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1629798692-21361-1-git-send-email-Monk.Liu@amd.com>
 <c83ad5a4-0adc-3940-ff86-b9e194235604@amd.com>
Message-ID: <ad3529fd-0a9c-e095-6cce-8063072f43be@amd.com>
Date: Tue, 24 Aug 2021 11:01:44 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <c83ad5a4-0adc-3940-ff86-b9e194235604@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0062.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2e::31) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:61c9:4593:6778:84a7]
 (2607:fea8:3edf:49b0:61c9:4593:6778:84a7) by
 YT1PR01CA0062.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2e::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4457.17 via Frontend Transport; Tue, 24 Aug 2021 15:01:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 408a8d55-765b-4160-5a1e-08d9671017ba
X-MS-TrafficTypeDiagnostic: SA0PR12MB4448:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4448165A5BED1636E13EF51FEAC59@SA0PR12MB4448.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vnFF3uY+JxnLGYDj/pBQUoJ1OEd9ebDXvwyd0JvXoXK3ruCDIcUNmLlYVV900nYfDOEY3oESNflRO2V1jLdSNMLd+RfYRq7zoqwILJNCh3iv546MD1Ab8r3/GL5PLLWWc77jRmtZGMVvSUrusE6yXbNEBxcW/soTyywYwUFHtqxTZ4csjjmSoJ4s96Dtr4GOBKbQcG2DTO6E8Esv0chlZfQkH+izdMfMrBaLmhfEohTXPC1oOizH01TDyWi+07ZNbdVR0pYJ8arbKH0rmVb/lwbWS7RxpEjQ+MHyPb5tbL8brF+YmLcAmIraPuNK70bypH8ZZqJ7BYS+4pjJxsAE95by48EMNkBwUopPCa97fOeA07iWvFtwdnqyG6k9rNWyf3dWWal9+/0o8DVya8RZh2AR5HSVgJ54Re6eRjuo5bePm1uJ64yoUuGnrc/G+giNP/c9U7C3yFZLFBGuKOLXAaSkK1IQo600kkciy+FDB+zfaIKaksYxomVXYN/6A8WrsxVNpiD20M3HGTc97uNjb9P0RkXKiXVbA2beBCeiFjlFI9MTIOZaiJ+NsxpgSC+nQHYK9KFWWQSP2YbiDABMR9Kp0AJ6Q0evXQzBe4No22Cq1k4MJhhYGmwdhRl28otFPOPOewllqpRHuCGwFU15Jmnyz8TKZBc5qwN8xs4IXoYEJJ76t8Uq5fzDxMCjrAZ2eL9R6oOGYrCW4ib8wIw4XJSRcaucNDlYHcDtUt8C9mSzk8ObPJePpFZFzUiV9j1CJ/2OgQgCW4+HwyMVeRI/UOf5b7NLXo5jQRSFpWq+l6ns8Utwo46vFG/KRRpAhNqm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(346002)(396003)(376002)(136003)(6486002)(2616005)(36756003)(8936002)(44832011)(31686004)(38100700002)(5660300002)(8676002)(2906002)(66476007)(83380400001)(66946007)(66556008)(53546011)(186003)(316002)(31696002)(478600001)(86362001)(966005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QnhNeE9OOW1vTFRZWFl4Y2hZYVdqSERSZHRhVmRPbW5Oc3UxMzExcDMwYXFR?=
 =?utf-8?B?TVErSjVUem1HYi9icVVoOVNKWDEyanpIRkJvVnNSOTZHM3dmNm9Uck8vZWIz?=
 =?utf-8?B?RXBBcEJLOEkwdzJsTkhISGk2RU9Oa2Nvc1crSzFJMzUyS3A5b2NSZG44aTJ6?=
 =?utf-8?B?amV3MjQ1VzE2eStWNnVyS3lGVTV1VzU2bitBQi9kYks5OHhmU0pNTHh2L3Zx?=
 =?utf-8?B?cEg5S2NkK01Md25GZDhPaVl6alRNcVNVMUNFQk5Xb1hDVzFneTVyeFdicjJ4?=
 =?utf-8?B?UUdmSlBQWXFHdjhtVXh4bDRtV3BnTVg4emZLK2pVSDhSZFJNNEZscGdkd0l2?=
 =?utf-8?B?czFJNmE3Yk53NTJ0SFRzRWN1UDRVazIySHZnbEY2S05EZTdGeklCR1ZXZXI1?=
 =?utf-8?B?ZzdSM0d5L2JtNXlQR2VvdzdvKzZWTFFvcDZIV0JxaXordjNuQ1BWMmMxWlMr?=
 =?utf-8?B?OWZyd0NOMFd4anNGbFZrbDNSWVdaTVNsWm12aThDbEpCc3ZDODBtMFpYTi9O?=
 =?utf-8?B?L0thQzRsWUxEOVRmcVp1cjFJUEMySHpSVDlzN1pEaTVRZ2V4M1V3NVQrc3Fa?=
 =?utf-8?B?NlVISlRuNnpGN0VhSXpkY1hyekZ0VlJCdkdBVm0ySkFhMFhWQkNOWTFOZDFD?=
 =?utf-8?B?RitETnMra1cwMkduenZqK1dhVTVoQ2ZVQm5EVVh1MktvTlpNcEFWY1dNVzVz?=
 =?utf-8?B?eG1WYU9wVEFrWXVveEZqQllrODZSWVdvNUkwTTB6YzNtWUo2bDNZeEJHaWJS?=
 =?utf-8?B?VDg2empxM0t2SDVlM1g1amp4NVdTK281VXJQNjhDaHlWOGdIZndKOC9aSnl6?=
 =?utf-8?B?empHYzdCbjAvWXVWZ05lZUsya2s4TGY1N2xjSWcxenhVSGNsL2g3MmdoWUFT?=
 =?utf-8?B?T0MzTDVYNkxya2laUEZoRWIwT1ozMjVaTXcrS2t6aHRBTXVrUlFOTWJHTHBn?=
 =?utf-8?B?czVqMFJUcWRoWjdBQ1paTExJaWN4UmdNZElPSXpSbVplRjZBZzZGalhEZmM3?=
 =?utf-8?B?Mlo5NCttZVIxNzRGdWptS2RhRndvZkVnZmNVT2h3dTVvV0psbk9rUUg5Yi9j?=
 =?utf-8?B?akZnL2hBZ0EzQkkrM1hqN1NleU1CeXBVVGFTcnNoS3BCU3lQRDVyK2VMbE5s?=
 =?utf-8?B?QVBxMjFUUVVQR2dWUHlnSTBmYmJpZ3BXZFVpcEpOTENtN25YRXJuL09qdVYz?=
 =?utf-8?B?MTVYa0VMNXh6V0FWZ1p5R3FrV1lwWVNPYUc2c3ZNVllQS2FDVlFMYkV2SWxU?=
 =?utf-8?B?WTVMWmlpMDR2QmRXc29hVUgySDZpMHBUcDZzdi9nMVNYTlFhVUQ2KzNQYmdn?=
 =?utf-8?B?b3FxeWl3Sjc1eHlNdHN5dEJoNmQvSU9ZeWM0QVNJNzloRFFqNjhvVzVweDdY?=
 =?utf-8?B?YUV0aGQvQUZ6S0R0MjF2a21lN01ReWpKL21aenBqV2V4OG5SUWdtOTN2Z0Ra?=
 =?utf-8?B?R3pPL29zU2MzUlpBY29WMzBISTY2VU5vSW9xekF1b2tQYnNLRHFFYUpRTU5H?=
 =?utf-8?B?cUQ4OXhXa3V5Q0ozWnZtdUZBbFMxdkd2RVBvK1kwdGw4dXNBQ2JvTkFrc3FB?=
 =?utf-8?B?UTRTdWdpUGZ5KytyTVpucnMrdS9pYytyMjdyTDI3TXh4d3VUMks3c2pwMXVq?=
 =?utf-8?B?SlF5b2xuY1lNOVJIVGhSZVZBMVZVU3YzaDZEcyt2SGNNd1hJMy9tS21ONktq?=
 =?utf-8?B?MlhuaVB1TEQ3WlVGOW84VCtWZHA5czhSVmdSQTdrVmJJNHB1QjVSQXhOOG5Q?=
 =?utf-8?B?eWNxNlZJODl0NmpwbVJHNTdmbUIvUFdIQ0N5ZUo3ZWRVYVllT3AwRWwvNTgw?=
 =?utf-8?B?cmpGTzJyUXdzbmlLTDNKczRFR2FwTThNMVlSOXJqUjBvOVpndVJRRklZczRx?=
 =?utf-8?Q?uwkSL55FtBsYz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 408a8d55-765b-4160-5a1e-08d9671017ba
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 15:01:46.6821 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IKQsuis/r1BIQjxyjLrJjgjDO9Gap8upjd4Epylhckm93XQ8nsLEo+KGBQt5iFZwHPA4DFd2L4Xy66SDn3MMBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4448
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


On 2021-08-24 10:46 a.m., Andrey Grodzovsky wrote:
>
> On 2021-08-24 5:51 a.m., Monk Liu wrote:
>> the original logic is wrong that the timeout will not be retriggerd
>> after the previous job siganled, and that lead to the scenario that all
>> jobs in the same scheduler shares the same timeout timer from the very
>> begining job in this scheduler which is wrong.
>>
>> we should modify the timer everytime a previous job signaled.
>>
>> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
>> ---
>>   drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++++
>>   1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
>> b/drivers/gpu/drm/scheduler/sched_main.c
>> index a2a9536..fb27025 100644
>> --- a/drivers/gpu/drm/scheduler/sched_main.c
>> +++ b/drivers/gpu/drm/scheduler/sched_main.c
>> @@ -235,6 +235,13 @@ static void drm_sched_start_timeout(struct 
>> drm_gpu_scheduler *sched)
>>           schedule_delayed_work(&sched->work_tdr, sched->timeout);
>>   }
>>   +static void drm_sched_restart_timeout(struct drm_gpu_scheduler 
>> *sched)
>> +{
>> +    if (sched->timeout != MAX_SCHEDULE_TIMEOUT &&
>> +        !list_empty(&sched->pending_list))
>> +        mod_delayed_work(system_wq, &sched->work_tdr, sched->timeout);


3d point - if list empty you need to cancel the timer, let the new job 
coming after that restart it.

Andrey


>> +}
>> +
>>   /**
>>    * drm_sched_fault - immediately start timeout handler
>>    *
>> @@ -693,6 +700,11 @@ drm_sched_get_cleanup_job(struct 
>> drm_gpu_scheduler *sched)
>>       if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>>           /* remove job from pending_list */
>>           list_del_init(&job->list);
>> +
>> +        /* once the job deleted from pending list we should restart
>> +         * the timeout calculation for the next job.
>> +         */
>> +        drm_sched_restart_timeout(sched);
>
>
> I think this should work, but 2 points -
>
> 1st you should probably remove this now 
> https://elixir.bootlin.com/linux/v5.14-rc1/source/drivers/gpu/drm/scheduler/sched_main.c#L797
>
> 2nd - if you have two adjacent jobs started very closely you 
> effectively letting the second job to be twice longer hang without TDR 
> because
> you reset TDR timer for it when it's almost expired. If we could have 
> TTL (time to live counter) for each job and then do mod_delayed_work
> to the TTL of the following job instead of just full timer reset then 
> this would be more precise. But this is more of recommendation for 
> improvement.
>
> Andrey
>
>
>>           /* make the scheduled timestamp more accurate */
>>           next = list_first_entry_or_null(&sched->pending_list,
>>                           typeof(*next), list);
