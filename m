Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17F4C433EF
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 07:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 127D110E202;
	Thu,  3 Mar 2022 07:25:26 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB03910E1F5
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 07:25:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiHM69zHStQ1YlUuIOS3154JP/o7M5Y0oI5qjNCEUjUCzzHA16Y7r414m0hkaqQ8d3zl6sdxNw+eELlyj6chVPHqLDto70yLUBVjdE8ZXlbpEIDQnTGetTaA1ye0PnYx6v98nADMzlpAo4TjsLlWfVCg4UEDV5a20cLXrKYME9GqMQ3Ih2ESxbT56w+zo7Uomk8M75YOEjQVnsln4Y9JVbE+Iz9Mj/VLYfJd2koJTMvuvv5zFxoJKokkPXOo/3QlJIsI6QeXQOmKov+jWxU8esTuPnFfgVtVJRJrNR7jE5j4IfqDPR6ccsk54Snp35udUOGAh1xqVlmWndfytQRSQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRq/IV5/mOFsYazkBeYVxRmtWQ8tNZpB4soiVMG2FxM=;
 b=N6j8Hzja4MScgNvZW9XIwJnSXo3RgfDhwwxuKEV6nM1LexuJReYmJuFYP9kL6WdRphcTU3y2H5pECkLS1KlUyThnV4LipATCOD9N8wAeBKBvX1ONuDyimMC0Ly3oS11M5FGAgWTOyNGHeGI+hPjPbE7BWQ0jMuKmu0CCQXaiU99RqFqlFHYTFrxUWnsXdl1Sl92O8IU0gTZKwiztvoEZgNs7q6Msb+cvzx4oewhRKDCZaUvZo2JqMqK/Qzb/GApXw2nOB5CybQfVxojSuLNwWnWJlRg1Bumcfmnbs87EAIB5eNs6Q8UNxRZvAumdmY+aW6rUtQ7nFvcAk0GwA+n1+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRq/IV5/mOFsYazkBeYVxRmtWQ8tNZpB4soiVMG2FxM=;
 b=HcDcRg+RtUfo3YVcVnHY6OPZO8D7kRx2yCruQRfR6FwVWwihDPrRyGDrWnrYpIYHPlDY54qTIVjJyw57TzLH/xG+cFldV/3Ae23aUZCUVSAVYZ6+BmZTXdehCGQtyb3jRfz/3PtsRi1h9eyICI0iJ6OJe70XXeWPSSgUGBtFcqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN6PR1201MB2513.namprd12.prod.outlook.com (2603:10b6:404:ae::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 07:25:22 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::e03f:901a:be6c:b581%6]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 07:25:22 +0000
Message-ID: <a09270d0-54b5-364d-fd0a-53f4fd746f25@amd.com>
Date: Thu, 3 Mar 2022 08:25:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdkfd: Improve concurrency of event handling
Content-Language: en-US
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220302200614.2439019-1-Felix.Kuehling@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220302200614.2439019-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0009.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::19)
 To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527c5810-06eb-44ed-3d7d-08d9fce6fa23
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2513:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1201MB2513025D0D24F097D1DC0D2483049@BN6PR1201MB2513.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YjtvJY3VvXa/eiCyMdlHuXRT80b83NGXjIP/E1uchbtHLW211piEFaqpFL2GPL7TdfILZKZt+7V6jiU6v5ih+ItyfUyqmv1PK96ZRdQTcDApybBm7LtCXpT2pl3qhWt7/Ta7VEmZdUxHcLu0KnvTrW5hgbGw+dufhxy49HlPsngQPSrKcOp2VzN19n670Cxt+gwcE0HyCdtGzMILVdE+wwyyrNxSN1OXwdKm6aK+uyU3ZOL5gcKQldJbRiVMDCPciKMN0lt4teSfiVp8xJOzKrTiE0xRgfO31Tph2hl9xhQHn3h0itzTMHbDlJ2RNlQcsk2WT2IHphF+mbEXxstt3suHf7DADBLgHlDlkTqS9eXGs2WcbIo7HGTxPIs9/MREuZelORlXzRe0M+K1FdWyF1UCtE6/zD3E1hddLZ6E5V87zyhXu1/fZLrWxWeDbV47f2Wp6WfXY+RF3WVE95oeKE0ALhj1RAlDfbjPoXChX2CKJ0yCRb1YBdj55HhCLvBuZyjfKJ1An3qCZ1u98RLL/vJl3k2bmZMn65hR/I3jDtheDhyJJ7oLiFsbNh722Ijkzjxz7mRPHp2tFx7HPJVB/ZZhMca/Pjdi/yfcyayB68SitVAeMfrUTdK0CQKzPICArQgNI/DIGajcVoIKtNXrVaysbOQ1eMlqJEqBPpPNc0RO0n5g70SoVcGyzkU9Vu9D3w7hsiC4E6z8VTUtf40rHlXnNtAjDE63Zu21uVvIvrmHH8ToU5IaAgN7QDczuaHq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(38100700002)(31696002)(4326008)(66556008)(66476007)(8676002)(5660300002)(66946007)(316002)(36756003)(31686004)(8936002)(2906002)(30864003)(6512007)(6506007)(26005)(6666004)(186003)(2616005)(508600001)(6486002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0xTaDBNbEJCdEp1K21ESVpOdFpzMTZGbHZWbGFSK3Q5Wm9takp1dEF2VEJM?=
 =?utf-8?B?QU56ei9UdUtNd25nMkhWMkRCZ2NyeXlqM1ZTeDc4cEdybHJBRWJnRlFrMGYw?=
 =?utf-8?B?MUYxbWJjOFZ3QWppeE9GTHRRbUxRODZkVkQySVdNWGNraTdva0xya0F2c3lK?=
 =?utf-8?B?bHZHRHNkNWFQZUZKZ0pIMlZWQzArSFNYR3Q1MWUrLzMvdW53YTREZlYwSHcx?=
 =?utf-8?B?a1pseEM3WGIybW9nNDYwWnBaUk50aC9JRnNhdHdJZEhzeGFpZjlZNjUxcTN1?=
 =?utf-8?B?TkJXWDN2NmxYazdKaXM1amdPNy9zZmtxTm9HeVdhVjRGUHlwS0R6bVZsdmpD?=
 =?utf-8?B?K3MwQm9UNURBTTUyeXNTUFcwc0U3bDFVS2ZnamhqbXovOEZNQXZnZXV4bGMy?=
 =?utf-8?B?aUpmZzZCYmNJWkZUN1VORHRJdURXUyttVk9pcEJWTFZSYmVjbEpwM3VzaDJj?=
 =?utf-8?B?alNYNEVVQ0JHZmZ4SzVudzR0UHVwZHFXcmRmNnhtQjVQVnExb1kybDIwSVk1?=
 =?utf-8?B?ekhOUHU1Q3lsMVcySEtBK2Y0M09uVFROR0NGUWlwcEIyWE5JK0VLNUpkMWF3?=
 =?utf-8?B?alduV3RYbElDNWE5L3hOMlAzMmxVWks5VXRNcjhtd1NNMjJFSnVEMFRaRnQr?=
 =?utf-8?B?YU5ZcHhISkZrRGxoUlB2OVdiWTIzTEQ2QWFoYnBubE9pcmhXV014WDIwbzRQ?=
 =?utf-8?B?L084enpNWll5SklaL0h2TkdyRitFNHdlbEhIRTZ0STBCS0pZRlJLaEUvSk44?=
 =?utf-8?B?blR1ZnpOd0xQbGk1cnZTYitBWnFmL0RrQUFmYjkxZGNEanhhY2ZScG13NWVu?=
 =?utf-8?B?RFh3UGR1TkNDTWRtUmhyb0phcml6MTc3RzRBWXV6b0JmcGg1eU5xSnRGYTdZ?=
 =?utf-8?B?eURPMWpLTnRoT241YVQrNlVFaEprcFgxZHZKQTROeUg0TWhLeHE2ck85OVhO?=
 =?utf-8?B?NmNqR2YwMFp3OVRhOW5mTk5JWm5XeXlhKzN0NFNpMU1SOHczNUxlZUtvdDdh?=
 =?utf-8?B?bk5oRWlFQWVOaUR3TmJqMHB6bTdIZ1l2VFp3WkRXdWNyekZSYlpMSk4rMk9u?=
 =?utf-8?B?QjVpZ0d5Tldta0xZMXpTSU1oNTRvWWkrQS9CZ3dsNWFnQitpNkVyR0drYUU4?=
 =?utf-8?B?Rnk1TXIvZmw1NXdqN0ZySEgrTXdUV1VDSHU1VmVFbzVPeVluSWJrYXYzQjJo?=
 =?utf-8?B?dTdlWUtNNjFQMU50OVRrYU1GYmxrMlJVNURrSittcGhOZ2RQSVRPdnJMT1Az?=
 =?utf-8?B?akEweXBIQlRaU0l6RWdsOWdlM3N5U3FwcnV6N1BIL0lmSGJJTklWNXRQbzF2?=
 =?utf-8?B?blFHU3ErcmNvVzgyK0xGSTJXb25jTzd0VFQyY1Z6RVQ4S1h6cmxtZWFweHFj?=
 =?utf-8?B?TCs2QUJoV2taKy84QmxkcStycG03eDN6YXB5Yzc3WkE0SXRBVDhoT1JNZk42?=
 =?utf-8?B?R2kxNHZUa2hjQ3BCU2xXQWZ5bGhTdFBZbWFNUUR6NFFiOWtmbzlROVNkSXZq?=
 =?utf-8?B?VElIWmQ1WXZTdFdUc2RNMzN2bUV0WWZ0TGxSWE4vME1XcUxZM0RQTy9yb1Q5?=
 =?utf-8?B?RDhZbFZTOHJmUXk5VGhFQ2EyYXdnWEd5Nk5xUFVZdHRQNWF2SWhpZk9id2pv?=
 =?utf-8?B?TjgzMHpMUm1PUHRqKzlsWk5HdFhjMFViTkM1Y1ZHOEliVTgwcmZKbDVSUWU1?=
 =?utf-8?B?KzM2SS9waHViaWttZmFQM3gwbytLWW9sNXlWTFJaNWpSc3JPRXhkTVRWUmo5?=
 =?utf-8?B?emFjK05IelpXczM3NEhtUm1CSDFobUxyOTgzYUtpQUpBZmxvRVpsT0tZOW1s?=
 =?utf-8?B?THprL0FDU0tNSUo1QlRNaFYwOVc4LzNLZDBYZmxEUXhZK24xRVN6V01YbStw?=
 =?utf-8?B?N2N2cWdkYURFbEpZVFoxclFhKzBKeHVGZlFsVWhuVXBxZ2t2T2cxZmI3bnpZ?=
 =?utf-8?B?UFg5dmg2c2ZqNEkvTGFROE5DK29ONmk1ZnZubnhiVTNBa1d6ZFJjQkZGK0hN?=
 =?utf-8?B?ZXdtWHZjNUpXUEpxS3VndDAyRE5URXNUQVRqQ0pORUlDa2xBcmpjeHNDdlcx?=
 =?utf-8?B?OWp4eVB6dzFiUHVPUEhIRnhOR0JMSXVmVVVYUU9TS1kzWjdsTTBQOEIzVDht?=
 =?utf-8?Q?wd2o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527c5810-06eb-44ed-3d7d-08d9fce6fa23
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 07:25:22.1114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cqXGoMcIiJui76AXO44WicBFlIbUSRWlZNwiBSv/ftCDhLNS8W+z39ED4QmR7XMb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2513
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

Am 02.03.22 um 21:06 schrieb Felix Kuehling:
> Use rcu_read_lock to read p->event_idr concurrently with other readers
> and writers. Use p->event_mutex only for creating and destroying events
> and in kfd_wait_on_events.

That might not necessary work as you expected. rcu_read_lock() does not 
provide barriers for the CPU cache.

> Protect the contents of the kfd_event structure with a per-event
> spinlock that can be taken inside the rcu_read_lock critical section.

That helps to prevent problems for the ev structure, but it doesn't 
protect the idr itself.

BTW: Why are you using an idr in the first place? I don't see the lookup 
used anywhere.

Regards,
Christian.

>
> This eliminates contention of p->event_mutex in set_event, which tends
> to be on the critical path for dispatch latency even when busy waiting
> is used. It also eliminates lock contention in event interrupt handlers.
> Since the p->event_mutex is now used much less, the impact of requiring
> it in kfd_wait_on_events should also be much smaller.
>
> This should improve event handling latency for processes using multiple
> GPUs concurrently.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 119 +++++++++++++++---------
>   drivers/gpu/drm/amd/amdkfd/kfd_events.h |   1 +
>   2 files changed, 78 insertions(+), 42 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index deecccebe5b6..1726306715b2 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -128,8 +128,8 @@ static int allocate_event_notification_slot(struct kfd_process *p,
>   }
>   
>   /*
> - * Assumes that p->event_mutex is held and of course that p is not going
> - * away (current or locked).
> + * Assumes that p->event_mutex or rcu_readlock is held and of course that p is
> + * not going away.
>    */
>   static struct kfd_event *lookup_event_by_id(struct kfd_process *p, uint32_t id)
>   {
> @@ -251,15 +251,18 @@ static void destroy_event(struct kfd_process *p, struct kfd_event *ev)
>   	struct kfd_event_waiter *waiter;
>   
>   	/* Wake up pending waiters. They will return failure */
> +	spin_lock(&ev->lock);
>   	list_for_each_entry(waiter, &ev->wq.head, wait.entry)
> -		waiter->event = NULL;
> +		WRITE_ONCE(waiter->event, NULL);
>   	wake_up_all(&ev->wq);
> +	spin_unlock(&ev->lock);
>   
>   	if (ev->type == KFD_EVENT_TYPE_SIGNAL ||
>   	    ev->type == KFD_EVENT_TYPE_DEBUG)
>   		p->signal_event_count--;
>   
>   	idr_remove(&p->event_idr, ev->event_id);
> +	synchronize_rcu();
>   	kfree(ev);
>   }
>   
> @@ -392,6 +395,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
>   	ev->auto_reset = auto_reset;
>   	ev->signaled = false;
>   
> +	spin_lock_init(&ev->lock);
>   	init_waitqueue_head(&ev->wq);
>   
>   	*event_page_offset = 0;
> @@ -466,6 +470,7 @@ int kfd_criu_restore_event(struct file *devkfd,
>   	ev->auto_reset = ev_priv->auto_reset;
>   	ev->signaled = ev_priv->signaled;
>   
> +	spin_lock_init(&ev->lock);
>   	init_waitqueue_head(&ev->wq);
>   
>   	mutex_lock(&p->event_mutex);
> @@ -609,13 +614,13 @@ static void set_event(struct kfd_event *ev)
>   
>   	/* Auto reset if the list is non-empty and we're waking
>   	 * someone. waitqueue_active is safe here because we're
> -	 * protected by the p->event_mutex, which is also held when
> +	 * protected by the ev->lock, which is also held when
>   	 * updating the wait queues in kfd_wait_on_events.
>   	 */
>   	ev->signaled = !ev->auto_reset || !waitqueue_active(&ev->wq);
>   
>   	list_for_each_entry(waiter, &ev->wq.head, wait.entry)
> -		waiter->activated = true;
> +		WRITE_ONCE(waiter->activated, true);
>   
>   	wake_up_all(&ev->wq);
>   }
> @@ -626,16 +631,18 @@ int kfd_set_event(struct kfd_process *p, uint32_t event_id)
>   	int ret = 0;
>   	struct kfd_event *ev;
>   
> -	mutex_lock(&p->event_mutex);
> +	rcu_read_lock();
>   
>   	ev = lookup_event_by_id(p, event_id);
> +	spin_lock(&ev->lock);
>   
>   	if (ev && event_can_be_cpu_signaled(ev))
>   		set_event(ev);
>   	else
>   		ret = -EINVAL;
>   
> -	mutex_unlock(&p->event_mutex);
> +	spin_unlock(&ev->lock);
> +	rcu_read_unlock();
>   	return ret;
>   }
>   
> @@ -650,23 +657,25 @@ int kfd_reset_event(struct kfd_process *p, uint32_t event_id)
>   	int ret = 0;
>   	struct kfd_event *ev;
>   
> -	mutex_lock(&p->event_mutex);
> +	rcu_read_lock();
>   
>   	ev = lookup_event_by_id(p, event_id);
> +	spin_lock(&ev->lock);
>   
>   	if (ev && event_can_be_cpu_signaled(ev))
>   		reset_event(ev);
>   	else
>   		ret = -EINVAL;
>   
> -	mutex_unlock(&p->event_mutex);
> +	spin_unlock(&ev->lock);
> +	rcu_read_unlock();
>   	return ret;
>   
>   }
>   
>   static void acknowledge_signal(struct kfd_process *p, struct kfd_event *ev)
>   {
> -	page_slots(p->signal_page)[ev->event_id] = UNSIGNALED_EVENT_SLOT;
> +	WRITE_ONCE(page_slots(p->signal_page)[ev->event_id], UNSIGNALED_EVENT_SLOT);
>   }
>   
>   static void set_event_from_interrupt(struct kfd_process *p,
> @@ -674,7 +683,9 @@ static void set_event_from_interrupt(struct kfd_process *p,
>   {
>   	if (ev && event_can_be_gpu_signaled(ev)) {
>   		acknowledge_signal(p, ev);
> +		spin_lock(&ev->lock);
>   		set_event(ev);
> +		spin_unlock(&ev->lock);
>   	}
>   }
>   
> @@ -693,7 +704,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>   	if (!p)
>   		return; /* Presumably process exited. */
>   
> -	mutex_lock(&p->event_mutex);
> +	rcu_read_lock();
>   
>   	if (valid_id_bits)
>   		ev = lookup_signaled_event_by_partial_id(p, partial_id,
> @@ -721,7 +732,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>   				if (id >= KFD_SIGNAL_EVENT_LIMIT)
>   					break;
>   
> -				if (slots[id] != UNSIGNALED_EVENT_SLOT)
> +				if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT)
>   					set_event_from_interrupt(p, ev);
>   			}
>   		} else {
> @@ -730,14 +741,14 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
>   			 * only signaled events from the IDR.
>   			 */
>   			for (id = 0; id < KFD_SIGNAL_EVENT_LIMIT; id++)
> -				if (slots[id] != UNSIGNALED_EVENT_SLOT) {
> +				if (READ_ONCE(slots[id]) != UNSIGNALED_EVENT_SLOT) {
>   					ev = lookup_event_by_id(p, id);
>   					set_event_from_interrupt(p, ev);
>   				}
>   		}
>   	}
>   
> -	mutex_unlock(&p->event_mutex);
> +	rcu_read_unlock();
>   	kfd_unref_process(p);
>   }
>   
> @@ -767,9 +778,11 @@ static int init_event_waiter_get_status(struct kfd_process *p,
>   	if (!ev)
>   		return -EINVAL;
>   
> +	spin_lock(&ev->lock);
>   	waiter->event = ev;
>   	waiter->activated = ev->signaled;
>   	ev->signaled = ev->signaled && !ev->auto_reset;
> +	spin_unlock(&ev->lock);
>   
>   	return 0;
>   }
> @@ -781,8 +794,11 @@ static void init_event_waiter_add_to_waitlist(struct kfd_event_waiter *waiter)
>   	/* Only add to the wait list if we actually need to
>   	 * wait on this event.
>   	 */
> -	if (!waiter->activated)
> +	if (!waiter->activated) {
> +		spin_lock(&ev->lock);
>   		add_wait_queue(&ev->wq, &waiter->wait);
> +		spin_unlock(&ev->lock);
> +	}
>   }
>   
>   /* test_event_condition - Test condition of events being waited for
> @@ -802,10 +818,10 @@ static uint32_t test_event_condition(bool all, uint32_t num_events,
>   	uint32_t activated_count = 0;
>   
>   	for (i = 0; i < num_events; i++) {
> -		if (!event_waiters[i].event)
> +		if (!READ_ONCE(event_waiters[i].event))
>   			return KFD_IOC_WAIT_RESULT_FAIL;
>   
> -		if (event_waiters[i].activated) {
> +		if (READ_ONCE(event_waiters[i].activated)) {
>   			if (!all)
>   				return KFD_IOC_WAIT_RESULT_COMPLETE;
>   
> @@ -834,6 +850,8 @@ static int copy_signaled_event_data(uint32_t num_events,
>   	for (i = 0; i < num_events; i++) {
>   		waiter = &event_waiters[i];
>   		event = waiter->event;
> +		if (!event)
> +			return -EINVAL; /* event was destroyed */
>   		if (waiter->activated && event->type == KFD_EVENT_TYPE_MEMORY) {
>   			dst = &data[i].memory_exception_data;
>   			src = &event->memory_exception_data;
> @@ -844,11 +862,8 @@ static int copy_signaled_event_data(uint32_t num_events,
>   	}
>   
>   	return 0;
> -
>   }
>   
> -
> -
>   static long user_timeout_to_jiffies(uint32_t user_timeout_ms)
>   {
>   	if (user_timeout_ms == KFD_EVENT_TIMEOUT_IMMEDIATE)
> @@ -872,9 +887,12 @@ static void free_waiters(uint32_t num_events, struct kfd_event_waiter *waiters)
>   	uint32_t i;
>   
>   	for (i = 0; i < num_events; i++)
> -		if (waiters[i].event)
> +		if (waiters[i].event) {
> +			spin_lock(&waiters[i].event->lock);
>   			remove_wait_queue(&waiters[i].event->wq,
>   					  &waiters[i].wait);
> +			spin_unlock(&waiters[i].event->lock);
> +		}
>   
>   	kfree(waiters);
>   }
> @@ -898,6 +916,9 @@ int kfd_wait_on_events(struct kfd_process *p,
>   		goto out;
>   	}
>   
> +	/* Use p->event_mutex here to protect against concurrent creation and
> +	 * destruction of events while we initialize event_waiters.
> +	 */
>   	mutex_lock(&p->event_mutex);
>   
>   	for (i = 0; i < num_events; i++) {
> @@ -976,14 +997,19 @@ int kfd_wait_on_events(struct kfd_process *p,
>   	}
>   	__set_current_state(TASK_RUNNING);
>   
> +	mutex_lock(&p->event_mutex);
>   	/* copy_signaled_event_data may sleep. So this has to happen
>   	 * after the task state is set back to RUNNING.
> +	 *
> +	 * The event may also have been destroyed after signaling. So
> +	 * copy_signaled_event_data also must confirm that the event
> +	 * still exists. Therefore this must be under the p->event_mutex
> +	 * which is also held when events are destroyed.
>   	 */
>   	if (!ret && *wait_result == KFD_IOC_WAIT_RESULT_COMPLETE)
>   		ret = copy_signaled_event_data(num_events,
>   					       event_waiters, events);
>   
> -	mutex_lock(&p->event_mutex);
>   out_unlock:
>   	free_waiters(num_events, event_waiters);
>   	mutex_unlock(&p->event_mutex);
> @@ -1042,8 +1068,7 @@ int kfd_event_mmap(struct kfd_process *p, struct vm_area_struct *vma)
>   }
>   
>   /*
> - * Assumes that p->event_mutex is held and of course
> - * that p is not going away (current or locked).
> + * Assumes that p is not going away.
>    */
>   static void lookup_events_by_type_and_signal(struct kfd_process *p,
>   		int type, void *event_data)
> @@ -1055,6 +1080,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>   
>   	ev_data = (struct kfd_hsa_memory_exception_data *) event_data;
>   
> +	rcu_read_lock();
> +
>   	id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>   	idr_for_each_entry_continue(&p->event_idr, ev, id)
>   		if (ev->type == type) {
> @@ -1062,9 +1089,11 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>   			dev_dbg(kfd_device,
>   					"Event found: id %X type %d",
>   					ev->event_id, ev->type);
> +			spin_lock(&ev->lock);
>   			set_event(ev);
>   			if (ev->type == KFD_EVENT_TYPE_MEMORY && ev_data)
>   				ev->memory_exception_data = *ev_data;
> +			spin_unlock(&ev->lock);
>   		}
>   
>   	if (type == KFD_EVENT_TYPE_MEMORY) {
> @@ -1087,6 +1116,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
>   				p->lead_thread->pid, p->pasid);
>   		}
>   	}
> +
> +	rcu_read_unlock();
>   }
>   
>   #ifdef KFD_SUPPORT_IOMMU_V2
> @@ -1162,16 +1193,10 @@ void kfd_signal_iommu_event(struct kfd_dev *dev, u32 pasid,
>   
>   	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 1, 0) &&
>   	    KFD_GC_VERSION(dev) != IP_VERSION(9, 2, 2) &&
> -	    KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0)) {
> -		mutex_lock(&p->event_mutex);
> -
> -		/* Lookup events by type and signal them */
> +	    KFD_GC_VERSION(dev) != IP_VERSION(9, 3, 0))
>   		lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_MEMORY,
>   				&memory_exception_data);
>   
> -		mutex_unlock(&p->event_mutex);
> -	}
> -
>   	kfd_unref_process(p);
>   }
>   #endif /* KFD_SUPPORT_IOMMU_V2 */
> @@ -1188,12 +1213,7 @@ void kfd_signal_hw_exception_event(u32 pasid)
>   	if (!p)
>   		return; /* Presumably process exited. */
>   
> -	mutex_lock(&p->event_mutex);
> -
> -	/* Lookup events by type and signal them */
>   	lookup_events_by_type_and_signal(p, KFD_EVENT_TYPE_HW_EXCEPTION, NULL);
> -
> -	mutex_unlock(&p->event_mutex);
>   	kfd_unref_process(p);
>   }
>   
> @@ -1229,16 +1249,19 @@ void kfd_signal_vm_fault_event(struct kfd_dev *dev, u32 pasid,
>   			info->prot_write ? 1 : 0;
>   		memory_exception_data.failure.imprecise = 0;
>   	}
> -	mutex_lock(&p->event_mutex);
> +
> +	rcu_read_lock();
>   
>   	id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>   	idr_for_each_entry_continue(&p->event_idr, ev, id)
>   		if (ev->type == KFD_EVENT_TYPE_MEMORY) {
> +			spin_lock(&ev->lock);
>   			ev->memory_exception_data = memory_exception_data;
>   			set_event(ev);
> +			spin_unlock(&ev->lock);
>   		}
>   
> -	mutex_unlock(&p->event_mutex);
> +	rcu_read_unlock();
>   	kfd_unref_process(p);
>   }
>   
> @@ -1272,22 +1295,28 @@ void kfd_signal_reset_event(struct kfd_dev *dev)
>   			continue;
>   		}
>   
> -		mutex_lock(&p->event_mutex);
> +		rcu_read_lock();
> +
>   		id = KFD_FIRST_NONSIGNAL_EVENT_ID;
>   		idr_for_each_entry_continue(&p->event_idr, ev, id) {
>   			if (ev->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
> +				spin_lock(&ev->lock);
>   				ev->hw_exception_data = hw_exception_data;
>   				ev->hw_exception_data.gpu_id = user_gpu_id;
>   				set_event(ev);
> +				spin_unlock(&ev->lock);
>   			}
>   			if (ev->type == KFD_EVENT_TYPE_MEMORY &&
>   			    reset_cause == KFD_HW_EXCEPTION_ECC) {
> +				spin_lock(&ev->lock);
>   				ev->memory_exception_data = memory_exception_data;
>   				ev->memory_exception_data.gpu_id = user_gpu_id;
>   				set_event(ev);
> +				spin_unlock(&ev->lock);
>   			}
>   		}
> -		mutex_unlock(&p->event_mutex);
> +
> +		rcu_read_unlock();
>   	}
>   	srcu_read_unlock(&kfd_processes_srcu, idx);
>   }
> @@ -1320,19 +1349,25 @@ void kfd_signal_poison_consumed_event(struct kfd_dev *dev, u32 pasid)
>   	memory_exception_data.gpu_id = user_gpu_id;
>   	memory_exception_data.failure.imprecise = true;
>   
> -	mutex_lock(&p->event_mutex);
> +	rcu_read_lock();
> +
>   	idr_for_each_entry_continue(&p->event_idr, ev, id) {
>   		if (ev->type == KFD_EVENT_TYPE_HW_EXCEPTION) {
> +			spin_lock(&ev->lock);
>   			ev->hw_exception_data = hw_exception_data;
>   			set_event(ev);
> +			spin_unlock(&ev->lock);
>   		}
>   
>   		if (ev->type == KFD_EVENT_TYPE_MEMORY) {
> +			spin_lock(&ev->lock);
>   			ev->memory_exception_data = memory_exception_data;
>   			set_event(ev);
> +			spin_unlock(&ev->lock);
>   		}
>   	}
> -	mutex_unlock(&p->event_mutex);
> +
> +	rcu_read_unlock();
>   
>   	/* user application will handle SIGBUS signal */
>   	send_sig(SIGBUS, p->lead_thread, 0);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> index 1238af11916e..55d376f56021 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
> @@ -59,6 +59,7 @@ struct kfd_event {
>   
>   	int type;
>   
> +	spinlock_t lock;
>   	wait_queue_head_t wq; /* List of event waiters. */
>   
>   	/* Only for signal events. */

