Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7CC4C7EE2E
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jun 2023 22:44:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D0F510E029;
	Fri,  9 Jun 2023 22:44:36 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0570F10E029
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jun 2023 22:44:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1shXk+I/B50jD+EjmkCuj/jnMPD418PoZ9jZKNZq10SjlmuRcLtVFOby9sYdzQ8znTv6AXApfuy+Cbv9E6DamRE5KdwAJjEsL9C6BFX5PPjPBodPN1uwHjnsQgWMsGTd+DuBgECSToTkmE9LVaASzSUM1EMpLKKwb+LB4QsZ6C9cl2qnsSMOzUGMOGYHJDaRf8wZ1nVLrUopVID2MXpgkL9SQhJwnVGICOw10X5bVhtBFdk/ZT6Yat3/PFAn9EzqViDhT2oaSOQIzETowDcXWNfWd6DMAzuHNwvD6oSenHypHL9en15xtZaPDpGWTgIeSEtyD6I0rR2LEU3qfRw5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEtyND8cdGk66oizeZOB8UW0+o1cyrcoZpGsqjWM4X8=;
 b=N2lvsyRboxx73Va3nnAlt+Vy0Zr7LS0PYBn5rFNrUesA7L209cWOXz3udnDbFVqv89J3gnghH1UCW8gcQMf0+JPuwn9QPqfNkU6tOOby/dwpcUFV/OLX/gM14EbJvmkZe1Eb8M6u0rVsPd6AfHkjLZCa9s7OwXHdJGTOtM3272acZEClapy+IudEB1otUdoP+IZDkWPYRWrQtij6IoC2ilf87sjfTCyYw+N/zzLcpFn0tV2bpacfpAneVxzPz9ZMpaDxxHEiRiyFEFyZhN7oxaK3tVZpWrBXqZ6LsMaMDqAnAo+zli5P7xWtSdQep6PFxBpeRO+P7WkW9D4W68h4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEtyND8cdGk66oizeZOB8UW0+o1cyrcoZpGsqjWM4X8=;
 b=tv1trHxpMTe9pD6LpV3dnutgHDSEgSSelFVUOyIGwubZTgxCd5Mh3WUwdvDRpWbkJjRVrYam0s26nQzCkipOJ8RTQhbO6HjP28fkmL83oxEEJqKeqxE7hZwQA6V9Zd+gjrRm0RgaGqT6aPSYPogVlpIdnTS4f9sk9S//HbSnCwY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW6PR12MB8836.namprd12.prod.outlook.com (2603:10b6:303:241::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 22:44:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 22:44:30 +0000
Message-ID: <3380071c-2673-8e2b-762b-51c2b66baa72@amd.com>
Date: Fri, 9 Jun 2023 18:44:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 3/5] drm/amdkfd: set activated flag true when event age
 unmatchs
Content-Language: en-US
To: James Zhu <James.Zhu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230608170705.2271276-4-James.Zhu@amd.com>
 <20230609204350.2352248-1-James.Zhu@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230609204350.2352248-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0266.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::31) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW6PR12MB8836:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b7f26af-3e69-4431-1e06-08db693b1663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ioo11xGlMzjclFtcjD7n2r9DmNtgGQU/AFDmp3c70MIXpklDMkP8Zp3iOdw3WaXXNJp8Hg7IQl57P30JQzPJpMQ/At0dkuwW34ELhlQl45tqFWamYgO+D9OdyxVsYPstAIWS0uVbrtltrFmv+hz03UPg4xvHZa5/TRvHNyHaS2pX5eZnlcpGRMqiuLLTac8lWlbpA0TEd4x+1E6Di2nM9ob4MXe1AyRrKSv/uTeORWJEyyKQwNZes923o+t5zerQhij/mVXWr465V5lI6pe0GaYICrsHRss6rAU/YHVbVA8+zZdnkwPs6Xehwtl31j4AWOBinKQJcBptM+QLt2rSkGUmQ/aK8YDkt7/k0Wct6IvwhFqLw/+T7hWSN11CNzLxkch+7kJ7HFXsbM1HPOjwfpAxn8Mah9qzpJfGnHEJqmVEOUS96ePrvIly7jdjVfEKqv8FPsbQ++InWX03Z4EqURHxnIjIPpYy6c44z/WJDVCGF505Fq9tjG+GPbkP1fzNYLXrSkHHIeIS7c7KTxAoLBNS0mJ30S2svtbBdBZztlJzqO68sKdAQNpSMjR7hRlMpU1KlVz2W+0heaw7OoGKHORUtXkttw85QOKIFuYoW1AysFa0p/xL/tq/fvnYOl6SGTUIugAicuByUvLlgBL2PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199021)(186003)(26005)(6506007)(6512007)(2616005)(31686004)(53546011)(83380400001)(36756003)(6666004)(6486002)(2906002)(36916002)(8676002)(41300700001)(8936002)(44832011)(478600001)(31696002)(4326008)(5660300002)(38100700002)(86362001)(66476007)(66556008)(316002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnhyV1FYSmJraENHZ0prVG1LYUx3V3FDaTNaaEM2NUtXbzB4L09mNm13d1RH?=
 =?utf-8?B?Qzl0NW1teXA4WEtRSi9Ra0gwVXdMaUxCZlozSDliWjhRT2k4SUFORmRYakt2?=
 =?utf-8?B?K2RKaENpNDdQYjVlNzdkNFhmSXVYLzJFZjZCZ2RScVJ2eUt5L0Z1QmUrMnhn?=
 =?utf-8?B?bmpwUWl4SEcrNVZjNWNtZkRvd0lueDJkM0dyeWNpY1RUQkowb2poZVU5a0hY?=
 =?utf-8?B?NUZKNVhlNEhUNFlDL0thdXQvcStsSDdjVEREbWdRN2Z5amJ1SVpQREliQnZJ?=
 =?utf-8?B?T1lPTDZaTWwxRUo3Tk0zaW1yUTdkMCtxU2JCdmR3c29zTStnQS9MNlBaVGVU?=
 =?utf-8?B?YWgvLzBUZ2h4SFd6MVNKY3V1Y2o5TVlVZ2lWYUlOMDZ4Zy9tTjB1Y0xFSGta?=
 =?utf-8?B?aktiYmlqbW5LWmQyZE93R1hQM3lEdWFReElXMitTcDdSc2FZNTVLVmpiR1lz?=
 =?utf-8?B?Ym5mVVJPQnJVcEx2WVJnODBBQmMwRDlDSnpwYnF4QVhRTDA0UjdkQlVJRWgz?=
 =?utf-8?B?MkIwd3ZJeS9USXVZdWhsTVVlSmk3Mzk2K2ZxWFBRTEJTZENKSFJROTZudy9N?=
 =?utf-8?B?TXVyczNOTEt4NnFUeDFWM2pPWUJwU2Q2QzViS1JDUnBtRUw4Q2pKMDhiejVl?=
 =?utf-8?B?Ynlrd2JOZkJPVzQxdXNVZGZZRElpNFVpUzdaaXphN091b1hTNFdNeWlqN0Ey?=
 =?utf-8?B?dVFMcnJqWnZBQWpCWDVUNVhvM1ZPMHFUUXplRlZJbURRQTA5TXhpL1ZWVXR0?=
 =?utf-8?B?c0F0ZHJsNjViSDgyd2tkbHkzTkpBTHZ6Rkk2VzM1cFF6SDR5RGVvOXltZVJV?=
 =?utf-8?B?Zms4anZ2RjNaRytXT3ZacWZqWEJReThEZ2pxRGhLbW9ySnZKZ0tTdEo2bkEv?=
 =?utf-8?B?OU9RV09SNC9LdE43cTlISE9tcUo1SVgwUEVBWnJpckRFZ3IyWllKb2lJazhF?=
 =?utf-8?B?Q1ZBODBsS1NZSEdGc29CZXVja3hGc1E0ZUxHWFBwOSswd3NSVTh4SUl3Y3dH?=
 =?utf-8?B?VjBSUURVcVdIS084VEd1OVN3c2R1c3Q5UTBKOHpFYzU3ekpXVCtZRERlK3pa?=
 =?utf-8?B?b29Cc0J5Q3dUaU8wbSt2M0kzWWVSWGZrY1ExT1V0bkJlWitucm5HaG5Fa29E?=
 =?utf-8?B?VUgyVUVFTk9jYWNrcWN0SUVEbEh2dEhXRFFwVFRKQjk1TGM1L3NUT3RLYlV1?=
 =?utf-8?B?Tjk3V2JDY1AzN3lTZ0VjSnpwbGZ2Uld4Sjk2aDdtWjdtM2VKWlhaSXNQNlZD?=
 =?utf-8?B?Vyt1V28yRUZHQVVPeDYwSndxeXI3Y3dwV0t0dmVwS3RxTWpFUzhtWWJkSlFr?=
 =?utf-8?B?ZnBySk5uOTFpWWNLcFRrNjFmZFdFd0dKY1I3blhhcXlLSDh3M1JaVXR1enlJ?=
 =?utf-8?B?R2cwWUYwMTJRL2RXN0ZjTWhwbnJsbHpvTlFXdVRMT0g5Z0xVWTVTTVZVVGY4?=
 =?utf-8?B?OHE3V2hPMk84WmVmUmdQU1lxcVBJcDFleFlCcGtpL2NJVWdCWE9lWGhBZ3B6?=
 =?utf-8?B?bW9ScWtsWUQrUkVaYlhCMS8wRnYzVlRNV1BVaDExRSttQ0x0amNlci9pM0Nw?=
 =?utf-8?B?VUNzbkNrN3N4K2RweDlkeFFpNWI0YjFRaUljZHh0TytCRzZtWlNxQnJOcHdS?=
 =?utf-8?B?cUJlQVlTZ3FEdEdIdVZ6VGY1TUhYOGZZRDROR2NHaE5tL1BuZDZKYktWN2Ez?=
 =?utf-8?B?bi9veTNHQ0JwV3h5T3oyZ2w1OWJxM0IwRTRqanU3Q0p0SW1tblpqUDRrNWtY?=
 =?utf-8?B?VU54NWk4ZGMrbnJOMVpvc29kT0MydWxYdUIrekZwVzcwZE50b3I3Ym9mRnZt?=
 =?utf-8?B?Ry9OM0pYaXJkNW42UlQ5VFFsc0NpN3lzU0N0dFYwNy90dmVBNjZSbnNmQWl6?=
 =?utf-8?B?VEVjV1VtMkxDeXdhQ1JBNFp3czlGbXh4Z2t3cFpyVFVUVzYvYVE4ZHlJZWQx?=
 =?utf-8?B?czNGbjYzMzIrd0NKQytoTUEza1J6cllzZzgxeVZUQ0xTazEvRWhlWlpEMTJp?=
 =?utf-8?B?emJXRGpZeTJ0dTFCQVBnQ0V5ekVLRlQ2K3FwTWIvajJEKzBZcGltcldBUUdt?=
 =?utf-8?B?ejErbFFIYit0amJ0TFhOVHEyb2NlK3ZMTjduR2JKaUZOMEt3d0l4Ti9Mamhq?=
 =?utf-8?Q?PgL03WlbstsfQ7XMaAugyrEDP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b7f26af-3e69-4431-1e06-08db693b1663
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 22:44:30.4964 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DAUbtSlRx4raSmcWok3cCiEecBc4zPwKGr7AEAaJVe7suD11skdLW25OegZbeCY4wbpL//Zn3fZQXkasa8pWjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8836
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

 From the KFD perspective, the series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

David, I looked at the ROCr and Thunk changes as well, and they look 
reasonable to me. Do you have any feedback on these patches from a ROCr 
point of view? Is there a reasonable stress test that could be used 
check that this handles the race conditions as expected and allows all 
waiters to sleep?

Regards,
   Felix


On 2023-06-09 16:43, James Zhu wrote:
> Set waiter's activated flag true when event age unmatchs with last_event_age.
>
> -v4: add event type check
> -v5: improve on event age enable and activated flags
>
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index c7689181cc22..b2586a1dd35d 100644
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
> @@ -808,6 +809,15 @@ static int init_event_waiter(struct kfd_process *p,
>   	waiter->event = ev;
>   	waiter->activated = ev->signaled;
>   	ev->signaled = ev->signaled && !ev->auto_reset;
> +
> +	/* last_event_age = 0 reserved for backward compatible */
> +	if (waiter->event->type == KFD_EVENT_TYPE_SIGNAL &&
> +		event_data->signal_event_data.last_event_age) {
> +		waiter->event_age_enabled = true;
> +		if (ev->event_age != event_data->signal_event_data.last_event_age)
> +			waiter->activated = true;
> +	}
> +
>   	if (!waiter->activated)
>   		add_wait_queue(&ev->wq, &waiter->wait);
>   	spin_unlock(&ev->lock);
> @@ -948,8 +958,7 @@ int kfd_wait_on_events(struct kfd_process *p,
>   			goto out_unlock;
>   		}
>   
> -		ret = init_event_waiter(p, &event_waiters[i],
> -					event_data.event_id);
> +		ret = init_event_waiter(p, &event_waiters[i], &event_data);
>   		if (ret)
>   			goto out_unlock;
>   	}
