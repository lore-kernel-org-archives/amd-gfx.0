Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9141C4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 23:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC48610E00B;
	Wed, 30 Nov 2022 23:55:18 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1ADC010E00B
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 23:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BfDJypeWvxZ1dhUPu143sM4rcAhG/z3v6I2zOwHR2lqPaGO+gTnQHBeyTqy6LRy+XQV5NUtxpSsGnjLbl9+selN0Zeu3Dh9ngFoM5G6TKVlH+VDVtNv9EdYMmLJBM57sGv/4kmjD6E2Rlkepv5zhbqLgye8yX35BXaqrTCMQDWfm7yBz2w8IbeQjIRsV9r/rBGnrL9BKGUrtBwd6nQFklcr2FbgDZh5RQ85mMVjpvl6od6Q1BazENe3m864Sceb1idHbXkeymQpQrnxBTweEcU8Is37Cb44A6LznjZaigPp+If9594B0pJVD0a/b0Z9UIyIOlhSYtAhv1c8st73dXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCK25V1u9qaKEsSSiWy9D+AmkIGX07Kv1Xmp2Gb6bZc=;
 b=ZrhDy3VyWaYDclaJ+SP4EdDNgXrJBL8gb6g7CpIzY8JSGJusEfkvrYyLJWkYEr/1ktikqrYUdsxYhJayZOGORIJ+feODLan5rR4vytizoB0VAYgxXnpOWi02Dts5jywwfKqeSa0STBnxnRLVgjaP/ifapvAkJljce8P6TbHwojhPIU9w/IbaMyFEbVIGgW2TpUtZSuPEaMlHQjoiyveQXANzbYaZXbSiMSwE9AQntEoDlyj35BFGDuTRBzxFumq5T1ZW5ExcgImg/8grkC7BB2zLGl73x3NAz6zOt610yNS7xN/+fxfpN5y41y1IjPvssOsGr5wIW5VP+NCAdpZCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCK25V1u9qaKEsSSiWy9D+AmkIGX07Kv1Xmp2Gb6bZc=;
 b=bZhmxlj1bs3NkmnCIAXjeDi/4EF9L6/zDDA9BmGKflVn3wG5pHG2jLbbBe1hhiWfTaurhIT7+vpb6hfG+rC3924jMQ7bPnUQFgrBylVrXPMmLZQp7c9P0H1ZKHM9OzSuiK/RjLiGSDKTUj4U1K5n+weT3+hqyslv6C+ytSPAO7c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.21; Wed, 30 Nov
 2022 23:55:10 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 23:55:10 +0000
Message-ID: <65d1b014-9d27-e870-8f2b-fed9d5f02729@amd.com>
Date: Wed, 30 Nov 2022 18:55:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 27/29] drm/amdkfd: add debug queue snapshot operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-27-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-27-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0182.namprd03.prod.outlook.com
 (2603:10b6:610:e4::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: ed2989cb-2d17-4284-63ca-08dad32e4fd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fLUw9/0RSG83sVn6LclPIjj9YN8COIFXV7wR3h2mWkfIfLdveCgs3hAQp5tfWscSCtDUiIcnbPC/Kr4KrVpJ5an4Fd9AnGKFEyMbnSlczxybtmRRNNDjSLWPOjnIsp6BDJM8sZbfLcodMP8/NQapFQHLS8xOQ1P2Aze9BuqTon8MqXAxJISCufyKYtOdSf01Zqc+cRoNdhw8HYeyCid+rBMb04r2im6ArIh8BzVUakU/RuHJYmaTuEvlGs8Ef4Qdsqt9+4MWWRoMdI9sMNVCF0Uf1OXs9b0UjZHLrenC/+ORjTIGe61/h0oXXrvIe/IW+ewZSXljOnNefbn3BOfmb6vnQHOjzkWoQiM9WdmCVxGsaYxiTcQ4hxyYNi1SPfauRIki+aEyk0i6q7ZDzrjPu7xkK9nSu9Ek35epjjg4zZZixUCBqaC36+YPKPCA8VnVdLCHPO/fqcZaJuFPnrzuMeZHOx9W5ObvHqggLN8aoQAOJCRH2O3YJpnhSnznk4742HfNCEPr2Gdn0TL+5KoHeXXxVv/9m9URR0AoSmtXFUwshzBhRqlKjm8GMqKxz7i0X8MCy6G1whQ2aVU0SLX/oo0JPfPuUuIiW/2ccRSiKyao9W0mVwH4cZ5wArM+/c8kHWxi320e000d/fm9ym01Uif6ir6PEJ1iUz9rCYaeM5R4ynyQERIOEpynIuaJuIeoVigsp78A3zX8Asoqy+UylbTiks4kEF8qKovj8/hTchU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(31686004)(2906002)(38100700002)(41300700001)(31696002)(8936002)(86362001)(36756003)(316002)(5660300002)(6506007)(66476007)(66946007)(4001150100001)(66556008)(8676002)(44832011)(478600001)(6486002)(36916002)(26005)(6666004)(53546011)(186003)(6512007)(2616005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SC92V2VXbGVVSU1QSTRsNVJSTVQ0eHdQbTZpUGJ0czIraTFPOFp0WVl3NVFI?=
 =?utf-8?B?ZGRROTlvV1pqYUJ1MUVZMk9TWE95UkdZWlZKakRxWEpwbGZlSzBYclEwdEdT?=
 =?utf-8?B?Y1FVamdjY1Q1dkF3YmJyRHNpc3ZqaWlCdlcreGJWakE2eFV6NlVxa2ovRzRH?=
 =?utf-8?B?R2xuaTk2YU83V1RuMmsvM2lOWUxMQUtpOEZzMGJ3QXkrN3krV2lkbVV0UlJP?=
 =?utf-8?B?K00zZ0ttTmkwSTRLTks5QjZwRGFmWEhvbGd1VDB1eWpEZlY0bXNBWDJKYWN4?=
 =?utf-8?B?TGZoYVdxZlBIOXhpcWVtTmlKc2srdXYrTGc5L2xpNHNoMHcya3JDVWJlcHBo?=
 =?utf-8?B?c0lWYkJlaFg3UUMydTVPTlJrK3pmNnZlMVBKOTRjSFo5Q0U1SVN3TnA0bnB2?=
 =?utf-8?B?eGFkQjNjdnpGT0VDRVZpa2ttNWZUcTN1T3NWM1dnZko2MlZNWDBSekhQRkJh?=
 =?utf-8?B?YmoyMDA2ZklaOUtaaXdCdmJEYTJVbWRVa1ZweDZrWjRNSEVLZWVsRXdPNkN0?=
 =?utf-8?B?N05PMEdEUW9EakYxUkszeUpLOTJSMVNQNmJiaUxibkxnRDM5bWJpY1hQUVpG?=
 =?utf-8?B?UHRIdnAxRTA2WGZGV2FTeHZjbGl0eWk4TlEyZzA1RkxkZ0pidThqWkFsSXEr?=
 =?utf-8?B?NUdyL3hBQjNTSGZ4bWdBZENnTEJzSE9sSEZ6dHN3b0YvRVZDZWFlWmNDaXp1?=
 =?utf-8?B?Q0h5SzdTVDR4MXVTNGczOUJXZTNWbGVLNVgwM1FJa3RJZmMvL0E5R3BZQUps?=
 =?utf-8?B?Y2lwQ1IvbmdrdGh2UG5Cb1F2T2liaDNsMGFqeDFscThrZ0owTm5ONHh3RE1T?=
 =?utf-8?B?bGV6WW1lQU4yalQvb1VKMGh6cmFvZTNNMHhHa3ZkTTdCb1QzRzNzVE9VT1V6?=
 =?utf-8?B?bittUTVDOUpyTHcxdUVGZkRTQUVHL1VEYjB5alFmNVBDbFVjWHI0RWlvUHFW?=
 =?utf-8?B?TGt0aDFiZ2s5NGhtendzK0xoOE5yOE1BTTZJMFVoR0J1SGJEdEduOFVTcDZN?=
 =?utf-8?B?Z1NxbVpITmwyNCtvYmE5cWJ2R2UxZkMzUkVwQUFZcWVvSlFTZE9OWG4yekxP?=
 =?utf-8?B?WE9PalNzMUxVeFd6cDBkK1VUN1dPdGZyenB1M3prckgrQUUrN0xwS1ZsN3FY?=
 =?utf-8?B?K3c2Q0lEdmhRTWhhTVIyWURuRE1JWDU5VU9lVXRsVEQxNFpYajN2bkNtNFFD?=
 =?utf-8?B?M3pzcnNodndjME8wZy9WS1VsS1VRbWlzWThNSmZCK1pwYkk1VW9kQWFQTnVx?=
 =?utf-8?B?V0hRakJHWEZxemlXakdYSThFekxLV1pRWFMvc1pTRTFKcGVYbTVHRXhFM21M?=
 =?utf-8?B?TzgyRHRoMXQ2aVIvSTM2N3BocEJtTHAvdGZMR3dUd1FzZUpvYWFUaUlndW0w?=
 =?utf-8?B?T0lteDZidlUxYzAwS1haNFFYcWJseUVuZTBIZ0hqdXR4V2xIbm54UTNXTFJu?=
 =?utf-8?B?SmQyNjVhS3hpaWNDRHErVHNoNThoOHBmSzM4NERGeFRxUGtWb0x5T2xCc3Bn?=
 =?utf-8?B?K3hURXBiM1B4U29vZ2d1aTJmdXR6d0ZyV0MyRU1FN3dXRjUrcWY3d3ZzTXd5?=
 =?utf-8?B?UEZOemR5UGY3bHIzTjRkQUVqVFdVWDBHWHRxaWd5WnVIakRPV2g2REdmb3Yy?=
 =?utf-8?B?UXpBVWpUSUFNUHQ0cVdjVEthMEVEQ1phWjFHTkdpaTN3Ym13RXIwZGxmVWNq?=
 =?utf-8?B?cHgweTFXMk0xK0RRUm9MNzUzbEdZT2x6R2FSOFZ3ZldKRCtvbWFtY2VXZVJh?=
 =?utf-8?B?bW5aNzN0RGpidU5MamJ4eW9hWUd5R29vTFlmWXdRWm9wTitqYUZZYlZvVTdt?=
 =?utf-8?B?ZlJ3MTBHV3N4ZXYzK0taazAzZDJxNWNhaVpqdko4STB0SGJIVVZNTHhOQ0xj?=
 =?utf-8?B?ZEphaVdBUjlCeTdMcStyUzVTeG03MU9YR1p2ODdjY056QjBxcnFnbTQxTnpB?=
 =?utf-8?B?aW5CcmEwYW90cUFJYlBYNnVrQm8xT0h3WEZ6NzZBMUE4QWVqRjRpdFNGWGxP?=
 =?utf-8?B?UjVqeTlrNG9GLzZScE1yMmtBZ1BSdWF5S3gvODBhNHJtR0gzejFuWWxzVVQx?=
 =?utf-8?B?KzliVm5xWEU0WE5jc1hqTG43SDgwZWI5dUhzWEk4czNMcmY0S3NXdUdsTDFp?=
 =?utf-8?Q?OVTqkWL2LWtcJCNGwcu/ZmXuX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed2989cb-2d17-4284-63ca-08dad32e4fd5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 23:55:10.3165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/FnSRxWcgc/kMSrVFIA1TegUiYIClo0rGlUVvUZ/spWx+8T0csLyTUeXYS6acE/04Ut2eKBQZgskzaLFnpGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025
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


On 2022-10-31 12:23, Jonathan Kim wrote:
> Allow the debugger to get a snapshot of a specified number of queues
> containing various queue property information that is copied to the
> debugger.
>
> Since the debugger doesn't know how many queues exist at any given time,
> allow the debugger to pass the requested number of snapshots as 0 to get
> the actual number of potential snapshots to use for a subsequent snapshot
> request for actual information.
>
> To prevent future ABI breakage, pass in the requested entry_size.
> The KFD will return it's own entry_size in case the debugger still wants
> log the information in a core dump on sizing failure.
>
> Also allow the debugger to clear exceptions when doing a snapshot.
>
> v2: change buf_size arg to num_queues for clarity.
> fix minimum entry size calculation.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Two nit-picks inline.


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  6 +++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 41 +++++++++++++++++++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  4 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  5 +++
>   .../amd/amdkfd/kfd_process_queue_manager.c    | 40 ++++++++++++++++++
>   5 files changed, 96 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2c8f107237ee..cea393350980 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2961,6 +2961,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   				&args->query_exception_info.info_size);
>   		break;
>   	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
> +		r = pqm_get_queue_snapshot(&target->pqm,
> +				args->queue_snapshot.exception_mask,
> +				(void __user *)args->queue_snapshot.snapshot_buf_ptr,
> +				&args->queue_snapshot.num_queues,
> +				&args->queue_snapshot.entry_size);
> +		break;
>   	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
>   		pr_warn("Debug op %i not supported yet\n", args->op);
>   		r = -EACCES;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 589efbefc8dc..51f8c5676c56 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -2950,6 +2950,47 @@ int suspend_queues(struct kfd_process *p,
>   	return total_suspended;
>   }
>   
> +static uint32_t set_queue_type_for_user(struct queue_properties *q_props)
> +{
> +	switch (q_props->type) {
> +	case KFD_QUEUE_TYPE_COMPUTE:
> +		return q_props->format == KFD_QUEUE_FORMAT_PM4
> +					? KFD_IOC_QUEUE_TYPE_COMPUTE
> +					: KFD_IOC_QUEUE_TYPE_COMPUTE_AQL;
> +	case KFD_QUEUE_TYPE_SDMA:
> +		return KFD_IOC_QUEUE_TYPE_SDMA;
> +	case KFD_QUEUE_TYPE_SDMA_XGMI:
> +		return KFD_IOC_QUEUE_TYPE_SDMA_XGMI;
> +	default:
> +		WARN_ONCE(true, "queue type not recognized!");
> +		return 0xffffffff;
> +	};
> +}
> +
> +void set_queue_snapshot_entry(struct device_queue_manager *dqm,
> +			      struct queue *q,
> +			      uint64_t exception_clear_mask,
> +			      struct kfd_queue_snapshot_entry *qss_entry)

The dqm parameter is not needed. The function can get this from 
q->device->dqm. It's also only needed for dqm locking. I'm not sure 
that's even necessary. Aren't the event_mutex and target process mutex 
held by the caller enough to protect the exception_status and other 
queue properties?


> +{
> +	dqm_lock(dqm);
> +
> +	qss_entry->ring_base_address = q->properties.queue_address;
> +	qss_entry->write_pointer_address = (uint64_t)q->properties.write_ptr;
> +	qss_entry->read_pointer_address = (uint64_t)q->properties.read_ptr;
> +	qss_entry->ctx_save_restore_address =
> +				q->properties.ctx_save_restore_area_address;
> +	qss_entry->ctx_save_restore_area_size =
> +				q->properties.ctx_save_restore_area_size;
> +	qss_entry->exception_status = q->properties.exception_status;
> +	qss_entry->queue_id = q->properties.queue_id;
> +	qss_entry->gpu_id = q->device->id;
> +	qss_entry->ring_size = (uint32_t)q->properties.queue_size;
> +	qss_entry->queue_type = set_queue_type_for_user(&q->properties);
> +	q->properties.exception_status &= ~exception_clear_mask;
> +
> +	dqm_unlock(dqm);
> +}
> +
>   int debug_lock_and_unmap(struct device_queue_manager *dqm)
>   {
>   	int r;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 12643528684c..094705b932fc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -297,6 +297,10 @@ int resume_queues(struct kfd_process *p,
>   		bool resume_all_queues,
>   		uint32_t num_queues,
>   		uint32_t *usr_queue_id_array);
> +void set_queue_snapshot_entry(struct device_queue_manager *dqm,
> +			      struct queue *q,
> +			      uint64_t exception_clear_mask,
> +			      struct kfd_queue_snapshot_entry *qss_entry);
>   int debug_lock_and_unmap(struct device_queue_manager *dqm);
>   int debug_map_and_unlock(struct device_queue_manager *dqm);
>   int debug_refresh_runlist(struct device_queue_manager *dqm);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index aee4fe20e676..ebd701143981 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -1302,6 +1302,11 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
>   		       void __user *ctl_stack,
>   		       u32 *ctl_stack_used_size,
>   		       u32 *save_area_used_size);
> +int pqm_get_queue_snapshot(struct process_queue_manager *pqm,
> +			   uint64_t exception_clear_mask,
> +			   struct kfd_queue_snapshot_entry __user *buf,
> +			   int *num_qss_entries,
> +			   uint32_t *entry_size);
>   
>   int amdkfd_fence_wait_timeout(uint64_t *fence_addr,
>   			      uint64_t fence_value,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 15db83c9a585..30df1046c30b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -569,6 +569,46 @@ int pqm_get_wave_state(struct process_queue_manager *pqm,
>   						       save_area_used_size);
>   }
>   
> +int pqm_get_queue_snapshot(struct process_queue_manager *pqm,
> +			   uint64_t exception_clear_mask,
> +			   struct kfd_queue_snapshot_entry __user *buf,
> +			   int *num_qss_entries,
> +			   uint32_t *entry_size)
> +{
> +	struct process_queue_node *pqn;
> +	uint32_t tmp_entry_size = *entry_size, tmp_qss_entries = *num_qss_entries;
> +	int r;
> +
> +	*num_qss_entries = 0;
> +	if (!(*entry_size))
> +		return -EINVAL;
> +
> +	*entry_size = min_t(size_t, *entry_size, sizeof(struct kfd_queue_snapshot_entry));
> +	mutex_lock(&pqm->process->event_mutex);
> +
> +	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
> +		if (!pqn->q)
> +			continue;
> +
> +		if (*num_qss_entries < tmp_qss_entries) {
> +			struct kfd_queue_snapshot_entry src = {0};

It's safer to use memset here. This initialization may not initialize 
padding, so it doesn't guarantee that no uninitialized data leaks from 
kernel mode to user mode.

Regards,
   Felix


> +
> +			set_queue_snapshot_entry(pqn->q->device->dqm,
> +					pqn->q, exception_clear_mask, &src);
> +
> +			if (copy_to_user(buf, &src, *entry_size)) {
> +				r = -EFAULT;
> +				break;
> +			}
> +			buf += tmp_entry_size;
> +		}
> +		*num_qss_entries += 1;
> +	}
> +
> +	mutex_unlock(&pqm->process->event_mutex);
> +	return r;
> +}
> +
>   static int get_queue_data_sizes(struct kfd_process_device *pdd,
>   				struct queue *q,
>   				uint32_t *mqd_size,
