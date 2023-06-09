Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36ED3C7EE25
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 20:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCC8810E6DD;
	Fri,  9 Jun 2023 20:23:00 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2073.outbound.protection.outlook.com [40.107.102.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60C7210E6DD
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 20:22:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhmri5/LDCLy781DHT7VXwtjyrWV6D7qJQZ0TaPjQYLqQm3PzSte6axKtgu1kKzpmQL++trJVdsALPeZwO09tg55audbNbm7qSvYhtebfn/M8oE/6v5gCbqRBf70rHQAPweUTopnpoNrdwED9cgIcN0DQWnuYGR4ZcJ+Pqe5qIzja18rnElp3PE85JL2cxoavWxiF7j6Y7FDKuJS9x3NCWzoItEf6KVLBMii4Uc35q1bmeNes6SGdjT6wf602PA9P5QwUjJdyXuhyshQVY9DfglS1jif7K0w2qVNbCYpVroTeH7TDFVjR2ES4a7GrG49Gb1NR5fHSBaNAnAEyUqyyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SElbcp12Gb15+obrt5wpEbFwvUUR+/acqA02R9vz20=;
 b=KweR2rl1nBkuJJ1jENRn1kcBbBEJIAqSXszoK6eR9F/JkDBhmf/G5STT+PQL2VOrPvJsitSp/CDvZ9LiHwrfZwzxQx49LTPYKdY9fOjCWGJjLroa1mEcPLXqntlUM+oWZQRMsy7ArsC+LCXWIMsXnctbsj8wEnpMrtDyxhrDn5JRI3lBFpGutyGg8W+VPm51xyU0MlO1ZAfa0Zuaxekdr4FycK5ARMKeHmHwmPDDeUxRXntslQNDs6YNj7EpOqWVY0xcl9jEVtnl/+mbf9lef11g3TmKBzK9Q9UgeG8CVdJP2rq7Hin1/sLePWbCoHje/egCocHFRhVRGbE4AD6pEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SElbcp12Gb15+obrt5wpEbFwvUUR+/acqA02R9vz20=;
 b=UOxT8AcCfRcIDHZR5MVPY8/pFkUlf728YRWSDfPytQT7GCFbX5L6hsPzHoQbKWE4FgLy6ZC+AnfT8Qf0dHmbsOQUlxqYOj+vcHWjNger9l6EhVvE5rNYCx5mi61US9ht/9EtQAE5qyWR493ELzcguKccp7v3be+TdANFckcPNNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB6325.namprd12.prod.outlook.com (2603:10b6:8:a4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Fri, 9 Jun
 2023 20:22:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 20:22:55 +0000
Message-ID: <5936e919-b9b4-067e-4cdb-e818bff865d0@amd.com>
Date: Fri, 9 Jun 2023 16:22:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230608170705.2271276-4-James.Zhu@amd.com>
 <20230609201328.2350231-1-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230609201328.2350231-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0067.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::14) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ba7dd3-27a3-437e-664d-08db69274ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WOE6PNU4loqA/EvlXO/GugWZqCrJhfFo3t8wQQujR+U0wEa9S0GZDazZa3V8J/qTOCVz0UAcLJBq1j/YIVOUAgaHvW+tMjebw+AybLv3bfu52owZ3KK/KfjVAIzgh4P+jB/sztsdfzYBpkFufHgRIdjgOY2ogocaM1CSfjy2TjNJdJYDNlotidKVnYQmEsfrtdgJ8ianDMjlEukQPU7uIkpI0SEuyEYPCYEk5MYu8TXDfoE0DGr2+jTzavBoZvdU4jU0/P/rMT1SRw+iu5PhB2mRP79bFw2Eum7x6jtnOzZ15ic57Zftpomv7v6mQPOwn0DRBkDOYqwKcIwHm6OC3BFJfxuwSldQbRmjBhchGJwKfA//XbXHvD++XWPgGPh6jHFpzfIl+YQmexw3Q2xwM4rGyypijObDzka5Y35hvbw2m23sH+laGMsQyJalep1zknROsrgxlE7wkHQVD1O5WUsSlVeU0iRJ+RSXcFTbeVVhe5KOyMAGJ1WZd5EtR+84CyCMyj2Ofa6fgnV3Csy5t4D2B7G4+Abt0JXZ9Uz+22fJnXVteWtAlulkz/vXyr2f7ViFuLnxdHlg5TdIUVG9YbB1JJys5VIkPf8D6zk5+TS9EHbjsiiJEWhhZxmLvaurFe4KoChpRmPfIPrSlSd/dZJwHIXr5aFoT+Cr7b5iL90=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(366004)(39860400002)(396003)(136003)(376002)(451199021)(83380400001)(2616005)(53546011)(26005)(6512007)(6506007)(41300700001)(316002)(38100700002)(31686004)(36916002)(6666004)(186003)(6486002)(86362001)(2906002)(36756003)(5660300002)(8676002)(8936002)(66476007)(66946007)(66556008)(4326008)(31696002)(478600001)(44832011)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnFRNnE4aXo2emZEVnYvVjVZVHlyRXg2L05JMjVBdVYxWTA5TGVwcy9MaXZl?=
 =?utf-8?B?Rzg1L0FITXhva1E3eklxVHJQWExQaFZoQlNEcVRzRGtxay9xVEVCcnQxZTFn?=
 =?utf-8?B?TE81OGdsWUw0UksxeVA1OHpyTS9QZFFQWXZrOGFqaW00NlU0SHBDMktzaFVQ?=
 =?utf-8?B?R1NaQ1BSc2JWSEF3S0NJSWpnUit1VnVwNFB6U2ltcm4vYmV2akhyUG5HbkY2?=
 =?utf-8?B?TGE3aVJIRFNCS0hnd21NR2VnTi9Sd0dVdUx5Y0lPTWgxWHlsSzZUZURXV0hj?=
 =?utf-8?B?RnJwY2JobUlLRVh0MkpyZ0YwN1VZTCt6eHZYY3dCaWF1aWZrWnlKZFNpeGM0?=
 =?utf-8?B?V0VYd3pQTWdwMXVSaWt1eFNCblExcFc0MjJieXJaM0RweHBFcTBVN1pKeXhp?=
 =?utf-8?B?TGlhTDlISy9Tbmx0UFJTNkM3b2M3cldVUnBMamg3c1I2S0U2VjMzTTJyaTNn?=
 =?utf-8?B?MnVHWGREWFRmNlZLTTRLUTVqemJmVUk0TER5Ukt5dFNnUUViU0oyRXoxQmVq?=
 =?utf-8?B?N2VOakVhRzB6REVzMzdnWW9MNUpEdUlRWGlYcGROSUR0V2N6d2QzeEc4MzVW?=
 =?utf-8?B?ajk5bWJTdzRrRVJ4Y2hHSGw3Z3pVK09wZU00MlVrbVNMREpCR1BTd3dUUTFs?=
 =?utf-8?B?T3A0RHI1ajF0OGp2d2xIcm9TUG8wOG9rRFVIdFRPN0RLL0dWcytyRnB1VC81?=
 =?utf-8?B?clFMbjBKQWlYWkFhdUV3Z1FMWXdTZUhYQ3NtMFhGTjhwYXFOZ2hDZHpBaWFJ?=
 =?utf-8?B?V1VzRlYybDViemFxWHhqYS9Zd2Irak1WVU4zcWNZa21uZkxHOHp5MHdrUzJi?=
 =?utf-8?B?WlZIS3FnOU5HWks4V3VSNHBnODd3TmlhOG9CckQrN2hkdy8yUk15dGFxMWJz?=
 =?utf-8?B?NEpmNkM2Z0pnNE9xbEk5bjNxSXI2UHFBTkpOazhVOCtBV3hBUWVCeGVveDhL?=
 =?utf-8?B?RVF4cDFXMnlnYVJLRHROWGx1MnFDcWVLUmFUd0NtMjhmdTA1RzY4NGFLbVIv?=
 =?utf-8?B?bHl2dXdHMnJCNEMvaEIrZG05T21peDJSZ1J5QjNPcEpzZmcxQVZFU2FsM2Ir?=
 =?utf-8?B?VXBMZzc0N3p3UkdBWVdJMm1GSXhrajFlZHFjdkVWZW94WVRRSHhWcVdjZll6?=
 =?utf-8?B?SnFRYnVVbFpOK21qekpKdFlZcU1BV2tUYmtVTTlEWjJvamZhZHlVRm50dW1q?=
 =?utf-8?B?NFVkME9OOUtOdnIxV0ZHWHNDc0NFTWhud1NkOW1JZ1Zac2lnb0I5blJ3eSsr?=
 =?utf-8?B?cDBQSEFSaHhQTXFqN0YyVVBZRWRwZTBuR0p5bFJEUHpkRFIzLzNjbDdaS0Ur?=
 =?utf-8?B?cjVhSE5nU1NXc1FLUnhWazNhY25XOURMbm5Rd3lBdXVBK0h2ejB5Z0FIeUlj?=
 =?utf-8?B?TlA4YUhaUnRNQUlaSDF3d2xoTzR2ZzkxMlJrbktCTVhJazA5K29zalNob2VU?=
 =?utf-8?B?Mkg5bjVmRXVqY1djMzU2Y3R4dS84R3dkZThSRnh0UWREK2U0Yy96SUJ2cjZJ?=
 =?utf-8?B?MnZXOThDTGwweGRicnYyRmlFKzB0c3lqbDVXSlFPY3JuQkUycTFpaDJxMTJX?=
 =?utf-8?B?M01SVDZmdzV1M296NmJKVUJnZzEvM2d0Snp0a2JrOVhQQVM4S1dFMGlqaElU?=
 =?utf-8?B?TExBUng3OEkvbFgwZW9PL3NsQjdMZGM3UEYyRFhpcWRKMmhnK2Z2N1hIbVJE?=
 =?utf-8?B?ZjBOQkxabEFqejBZRDlHM2hXSldkSXFWOUlITGwzNVV6VWtkOGxVc29ZWEp6?=
 =?utf-8?B?bCsvOTlldlJWWHNQTHlEOGdDMnc4YW9GQnBiVmNDNDE5aTNRM2ZQbEhuZjZi?=
 =?utf-8?B?QXZjOHVvdURwUlJtNXNiYkM3SlFVektLRXhmY1YxNHZQWmFoWENDWWxrWlFp?=
 =?utf-8?B?Y2JPYmk2eU5USFZFVFNVMXNwTFpaeW11bnlhUnBPbnZtZTlwRlZhTnpPUDRI?=
 =?utf-8?B?WHJnZ0FNTkNZK3JaRGlsY1BlLytpSE5HVy9VRDVYbCtueGE0UklDQUFUeDJk?=
 =?utf-8?B?WTNLZXNzZldTVWNFNGJPdkpPSExUZnhmRWZMTnRrK1hiTno5bGVFcGtiWXl4?=
 =?utf-8?B?Szd2ejVKdWpFWU9tQjNCYkFuSDhrZFNEU1k2YkZNaW82c0c0VC82TXZZVFdE?=
 =?utf-8?Q?17WS1iTKYxwY9AB/lZCRQIYZM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba7dd3-27a3-437e-664d-08db69274ede
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 20:22:55.2230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzVHgQY6H5H6m82xxY6jEFsFPJxy13lKoejoPeQiAB3bugjxeGW7Ed4VQ2sLsyjnv3wsF2FBbw/CEWmlpLQ/3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6325
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
Cc: jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-06-09 16:13, James Zhu wrote:
> Set waiter's activated flag true when event age unmatchs with last_event_age.
>
> -v4: add event type check
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 15 +++++++++++----
>   1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index c7689181cc22..2cc1a7e976f4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -41,6 +41,7 @@ struct kfd_event_waiter {
>   	wait_queue_entry_t wait;
>   	struct kfd_event *event; /* Event to wait for */
>   	bool activated;		 /* Becomes true when event is signaled */
> +	bool event_age_enabled;  /* set to true when last_event_age is non-zero */
>   };
>   
>   /*
> @@ -797,9 +798,9 @@ static struct kfd_event_waiter *alloc_event_waiters(uint32_t num_events)
>   
>   static int init_event_waiter(struct kfd_process *p,
>   		struct kfd_event_waiter *waiter,
> -		uint32_t event_id)
> +		struct kfd_event_data *event_data)
>   {
> -	struct kfd_event *ev = lookup_event_by_id(p, event_id);
> +	struct kfd_event *ev = lookup_event_by_id(p, event_data->event_id);
>   
>   	if (!ev)
>   		return -EINVAL;
> @@ -808,6 +809,13 @@ static int init_event_waiter(struct kfd_process *p,
>   	waiter->event = ev;
>   	waiter->activated = ev->signaled;
>   	ev->signaled = ev->signaled && !ev->auto_reset;
> +
> +	/* last_event_age = 0 reserved for backward compatible */
> +	waiter->event_age_enabled = !!event_data->signal_event_data.last_event_age;

This should also be inside the "if (waiter->event->type == 
KFD_EVENT_TYPE_SIGNAL)". I'd do something like this:

	if (waiter->event->type == KFD_EVENT_TYPE_SIGNAL &&
	    event_data->signal_event_data.last_event_age) {
		waiter->event_age_enabled = true;
		if (ev->event_age != event_data->signal_event_data.last_event_age)
			waiter->activated = true;
	}

You don't need WRITE_ONCE here because there can be no concurrent access 
before you add the waiter to the wait queue.

Regards,
   Felix


> +	if (waiter->event->type == KFD_EVENT_TYPE_SIGNAL && waiter->event_age_enabled &&
> +		ev->event_age != event_data->signal_event_data.last_event_age)
> +		WRITE_ONCE(waiter->activated, true);
> +
>   	if (!waiter->activated)
>   		add_wait_queue(&ev->wq, &waiter->wait);
>   	spin_unlock(&ev->lock);
> @@ -948,8 +956,7 @@ int kfd_wait_on_events(struct kfd_process *p,
>   			goto out_unlock;
>   		}
>   
> -		ret = init_event_waiter(p, &event_waiters[i],
> -					event_data.event_id);
> +		ret = init_event_waiter(p, &event_waiters[i], &event_data);
>   		if (ret)
>   			goto out_unlock;
>   	}
