Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11946C4167B
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 00:44:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C301A10E401;
	Wed, 30 Nov 2022 00:44:23 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2051.outbound.protection.outlook.com [40.107.100.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 498F810E3F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 00:44:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f2N+vsrQEg3MCoWjzRj8XKp6DbD5tK0mRoWxLt5ghNbJtwNSP9qWCvSnZVMVLrwh7uiX1Gbes3iq3vlLDbJLpz6SdLLIhtRyWzo4fa+8YGOrZG7xCw5yuSmeUUgfc9KWB/NYbP8zXqyNbfVg9l0NbMrXlaYVW/YA98u0+xAV/pFMo4Je8Hx1Wzxb6a4Zeb8kIsq6E/DO4SWn+dSxDXEmZ/r6onZtS4FOxe/A2/EERtEFCppIsy/EZoxiyKiwHZ2GsVrP3s0fNzxNhIxYuFyER41mWh75Bq619noFPE8lwRkDhpRTfinVJLRRgDRNEMlWxfDgbdW8NDlR7dH/K5ZDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zyuTzMpDLjsmdEitnNenseFfK+RXTyRKUQu0VmCFfMw=;
 b=UfUfKe59PfyHB8694JgtwU3MymMrMoIBPVXRf4p6hCCZTu3Mt+bTvGF2GTsaqeriZQFMCtRrs3Z4ARUhrDOKDmXGYuDO5/LhVUP2tZA7Nd2m5yRbEWDSJk5xFRXRHNVRv9ZBuWlEVNDU8cQJBy70+LI+/QQUqkxApbw3BoXFHfjHn0SfWASSj9+KcZbiKmiC75YrNpDZRlXeAckVkhs5StwktK1sINfWM9MN+7twb8/b+sT5LZSRmlPCbF3jMfT3N7vTIdV9ve0Kja+piNmDAg2WU69eqOQGUtn4JeAtOw87ZTRfizx1oslH2fI+A/1gDdVcfLdsJIEV6+Iu6jv7uQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zyuTzMpDLjsmdEitnNenseFfK+RXTyRKUQu0VmCFfMw=;
 b=DO81G7LpP+QzVUAVD8RlIJbpHJsqd4P5YNBHqzhfeSluz1IUeAmYxQnVaT4BG0+tXK5iDxrI3+BwaORGWi+DONboHzhZppBvRkmyFeFNhr7lS4cquoPmQJ1i2LMw6aN/AUyzSv2d5u5VKudK6jRs4itMyXiWGO/SISC+Pbp/C20=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM4PR12MB5296.namprd12.prod.outlook.com (2603:10b6:5:39d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 00:44:12 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5857.023; Wed, 30 Nov 2022
 00:44:12 +0000
Message-ID: <5c12d631-3026-d906-10bd-a8fa98e0979d@amd.com>
Date: Tue, 29 Nov 2022 19:44:10 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 25/29] drm/amdkfd: add debug query event operation
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221031162359.445805-1-jonathan.kim@amd.com>
 <20221031162359.445805-25-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221031162359.445805-25-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0026.prod.exchangelabs.com (2603:10b6:208:10c::39)
 To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM4PR12MB5296:EE_
X-MS-Office365-Filtering-Correlation-Id: d31b5c65-f38e-4977-f6fd-08dad26bffba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WtFkhxvBOzi93q8K05LBTbHl3fhhTSY7P1wo8ziK56Um3zz8ot5LCgY5YIcbAWtq+sOlCjd2J5EqhzqeSu9U2ogtPnJiOPUNDJrch4i5E7cPJz+KsZpI0LH1Oco3eQ97ybZW8U4yllKNPMbAe+OB3dAqlljH8qqRgaAWq9msbu43qutERPfqKxSyp3S1f8uQ3v88hibpaHQ3Jhx6tcwU++KWrefcTCqwF16XvObZ3LisKjJvIGUSEslHRfpHr0D+wOVg4uDWOZzZfDjfp+SPvbYsM/fCt+BIwHGiAlMm2Xdtg28P7uTaKl4dSMVoIUroDXudYsYCILtJyN/z9P7TXN86Pu1XpJM9djjyYfOMOR49BT19lF9IfPqe0KC22gwOl1HE07G2+x9wU+w6tXpJnm/yYXZ8HXd4kFVpIbW28ftp0GE4WkTSgbr5eYfG2nmjgfM0MWIWqVKmTzFSvBOFcjzKzie0Bkf+9TTQ03RZazBa6GYOWbqiPi3LCLcR5jbPd1laXsg0W9UBpr/aaMBLyeAUpE/ZEIBak21tuTaZto1vMgIDk/8jmxUr6nCjN4y4U3M6JjTbSntuWH2rmMemcg7RqFa6mJnabzQDWQZTKzb7guBvZFQfoden5Rr8iy53QDmJj6A4rG/0BVWS/A4vrOjU0FoMZAU6pMHVxtQHWtFWJ1YDZpnbLy44UWJuoUu+XBkrjpacv+F0TolBy7MGr9yvHm8963gLMhaetXHFtUQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(346002)(39860400002)(376002)(136003)(451199015)(26005)(31686004)(31696002)(86362001)(66946007)(41300700001)(66476007)(66556008)(8676002)(2616005)(316002)(6512007)(8936002)(6486002)(36916002)(6506007)(38100700002)(44832011)(4001150100001)(83380400001)(2906002)(5660300002)(53546011)(478600001)(186003)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1Evb2JVN3BBYzM4SnVmYlJReExSekhQb25aY1Vsb000MW1abTFjU1VrM01y?=
 =?utf-8?B?RUU5R1lOUy83SVpCR0kzazNWN1g2allzR3JXWlBlR1Q5NGtMeTRqYlAyejVa?=
 =?utf-8?B?Q25Ma1hhZ0ZhU2hIcVB6RnVodHdjODBWcnJSRDM5NHl2RUVhS09KdFBqSWxz?=
 =?utf-8?B?WWxZSzZDM0l0WXBKdjFramZEQStOaWdoWkRDQzhFZlp1QXRUa2ZKbE1veU1y?=
 =?utf-8?B?OEhrN3JHaUlqYWs5ODRqR0syT2xYRUFyR1N2KzNTMzAwa0J4bThmZkZRcHMz?=
 =?utf-8?B?NHlsNUpzSEkyTFZCbmFPU2tDWk8raERBK256OEc3OCttYS8vU3dkREVrajdD?=
 =?utf-8?B?VTJyWng2UWFRcTdlVlIzZmQyb0VkeGNYZ0ZyV3JOU3JBbG9wa0h2dUlHWGNI?=
 =?utf-8?B?MlhnVTBLZ1ZXZ25KS1N3ME5MeFhKUUVRMnczRWdvcy93NnZTQSsydkxIR3Vj?=
 =?utf-8?B?NUgwYjNRMUQ2SzR0azAvWHJ4WWNaeHgxVkFlT2FyR0NTRXlBKzhmclV6UGpX?=
 =?utf-8?B?RnM5bHFEYmd3Y0VUWHBIbEJ5bmNMcmFpWWkrQVhra1hYSlh6aUZaUTNCeUUw?=
 =?utf-8?B?SU52WEE3SGs3dzZpU3hxN2piNnU5eEtwaGJqR3pmSm9UQUVjYTgvUjJjSERt?=
 =?utf-8?B?NlpZUHZaVmt4bUtlM050TVJJdHZXZU9hT21OMVlsVlB2OVo2c29XTDVQcDJx?=
 =?utf-8?B?WVU4NmljdmlZeENmYzJiQWk3SURidHdCM1F2N2RNYTJ1RU1tbkJubEZKY2Ix?=
 =?utf-8?B?YkhPQ0twWGhpbm1ocllOdTNZZWZLNlNsUllIV2VmK0ZiWTVock1NNURaK3hF?=
 =?utf-8?B?Vk5jRVFNYzlhWHY4bzA3TUw2VmRmTGpjUTRNZitXSFpDbUFabCtFR3k4K0FL?=
 =?utf-8?B?ditmZmovSDdxT2pXYVFHeklmRzAvSWxlMzRYcG5iR0tna0JuQWRvczNNeDV0?=
 =?utf-8?B?dHdiR0FTTnlGbTFLSGNqdzJPZm9lV3M3djA1SlBYZDhaeFFOcjRRZWhVLzFL?=
 =?utf-8?B?c2lNS1BNQjB5UUU1MGxRaWp1a3Z6aFRPZW1rMmwvV01aVUF0aE54cjdXNm1W?=
 =?utf-8?B?ckZZa2pmRHBCWVdMRHlSeWJDdDlhbnRzaHJwYlJXa0JFL2hFMUwvTzlNeEJR?=
 =?utf-8?B?bFc5QzJMMDAzbmd0SmJuc1RCdUpHTmZia0Y5VGRDZG1RSTl4SHloYmo4ZVRX?=
 =?utf-8?B?TktsUlN2K3ZEZUJ2U0FQNlliRmt2OW1LNDhWK1ZaM3lYenRXS09Iai82YnNI?=
 =?utf-8?B?TFdweFRMK1lIeE8xWDNzSWtFeGdqNnlMRTM4TXlobzZUdTRqZEg2ZklZYnFM?=
 =?utf-8?B?NVUwUldhZm5IcCsxZUJCRnVDZDNwZWZpbzFHTFAzT3RqZ01welhtaDFoZjhw?=
 =?utf-8?B?Tm9jdXJQTjcwdjJlSkpXTzdqOW4vVC9TcHVQRWUzS1o5Tjh5U3F1Rk1tdGVu?=
 =?utf-8?B?eEREY3BCWkVLeHdodE5NN2ZaaUhZYXpILzNlUzk4K0pTMjlDVWJ4R1R5eFVW?=
 =?utf-8?B?TXFZQlZUR3QwL1NYd1ZBS0ZUOEJGWUVuRmxiemU1b2llNEY0YjZrYWloeDhC?=
 =?utf-8?B?a01RM09vWmxoTUtkTWlCK1dHVnpJWk1sSXBIN1J2MUJlbnlXMTUza3NqUGR6?=
 =?utf-8?B?MmNTSkJmeXdER1hkOVlHc2Rnd1BGaTY2cTFnNllseGJKcDlZTXBIeUZjN0gr?=
 =?utf-8?B?MjVLMmFEaUg3OWQ5QlUveFFLeGl6WXMrd09yQnNNWGt0TTVycXZvT1NTY2k2?=
 =?utf-8?B?bHd1VHFYMStDNTFaWHhheVBzVHFZdFc3akhlQ1FFaE9xZDFESkYzenlLcjRX?=
 =?utf-8?B?bWZBbjNpUjRkL0NmN2pzY3B1YmlhRlJlNWl4TG8rcndhdjNwbCtHTXpweHh4?=
 =?utf-8?B?RDd1Q2N0Zm1ubkowTS8ycElBYmw2TVBiMGwrRDNwMmlFMXJaVTVEQThURFlI?=
 =?utf-8?B?UTFNTWRUcFRIRitOa3NhY2EwU21zQXZZMmxrbmZnb3dVUFZiTzdCWEdVVW9D?=
 =?utf-8?B?UXhNZXdCU1RYb2lJT2tZWnhyTis2TjF6L2oremxQYit0Z3hrYXJXZ1hGZG5M?=
 =?utf-8?B?TVlsK2hLTEV5NWtlYUwzdXlOMDRJOGJybUgvY0NwVkNtWGlQOXBxUCtrWUV1?=
 =?utf-8?Q?LyhyfDkI8F8rvS7kB2LWAMl5f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31b5c65-f38e-4977-f6fd-08dad26bffba
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 00:44:12.1841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xFFv74bIwbwyPOoVoyVB8JSt2PHetvbMaE1xavTTUSraHmsswHVluWL62jhHxV1MQ9Doyqqj2Wi4JCzE8QvmSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5296
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
> Allow the debugger to a single query queue, device and process exception
> in a FIFO manner.

The implementation is not really FIFO because the order in which events 
are returned is independent of the order in which they were raised. Just 
remove the FIFO statement.

Other than that, this patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> The KFD should also return the GPU or Queue id of the exception.
> The debugger also has the option of clearing exceptions after
> being queried.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  6 +++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 64 ++++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |  5 ++
>   3 files changed, 75 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 200e11f02382..b918213a0087 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -2946,6 +2946,12 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
>   		r = kfd_dbg_trap_set_flags(target, &args->set_flags.flags);
>   		break;
>   	case KFD_IOC_DBG_TRAP_QUERY_DEBUG_EVENT:
> +		r = kfd_dbg_ev_query_debug_event(target,
> +				&args->query_debug_event.queue_id,
> +				&args->query_debug_event.gpu_id,
> +				args->query_debug_event.exception_mask,
> +				&args->query_debug_event.exception_mask);
> +		break;
>   	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
>   	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
>   	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 1f4d3fa0278e..6985a53b83e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -33,6 +33,70 @@
>   #define MAX_WATCH_ADDRESSES	4
>   static DEFINE_SPINLOCK(watch_points_lock);
>   
> +int kfd_dbg_ev_query_debug_event(struct kfd_process *process,
> +		      unsigned int *queue_id,
> +		      unsigned int *gpu_id,
> +		      uint64_t exception_clear_mask,
> +		      uint64_t *event_status)
> +{
> +	struct process_queue_manager *pqm;
> +	struct process_queue_node *pqn;
> +	int i;
> +
> +	if (!(process && process->debug_trap_enabled))
> +		return -ENODATA;
> +
> +	mutex_lock(&process->event_mutex);
> +	*event_status = 0;
> +	*queue_id = 0;
> +	*gpu_id = 0;
> +
> +	/* find and report queue events */
> +	pqm = &process->pqm;
> +	list_for_each_entry(pqn, &pqm->queues, process_queue_list) {
> +		uint64_t tmp = process->exception_enable_mask;
> +
> +		if (!pqn->q)
> +			continue;
> +
> +		tmp &= pqn->q->properties.exception_status;
> +
> +		if (!tmp)
> +			continue;
> +
> +		*event_status = pqn->q->properties.exception_status;
> +		*queue_id = pqn->q->properties.queue_id;
> +		*gpu_id = pqn->q->device->id;
> +		pqn->q->properties.exception_status &= ~exception_clear_mask;
> +		goto out;
> +	}
> +
> +	/* find and report device events */
> +	for (i = 0; i < process->n_pdds; i++) {
> +		struct kfd_process_device *pdd = process->pdds[i];
> +		uint64_t tmp = process->exception_enable_mask
> +						& pdd->exception_status;
> +
> +		if (!tmp)
> +			continue;
> +
> +		*event_status = pdd->exception_status;
> +		*gpu_id = pdd->dev->id;
> +		pdd->exception_status &= ~exception_clear_mask;
> +		goto out;
> +	}
> +
> +	/* report process events */
> +	if (process->exception_enable_mask & process->exception_status) {
> +		*event_status = process->exception_status;
> +		process->exception_status &= ~exception_clear_mask;
> +	}
> +
> +out:
> +	mutex_unlock(&process->event_mutex);
> +	return *event_status ? 0 : -EAGAIN;
> +}
> +
>   void debug_event_write_work_handler(struct work_struct *work)
>   {
>   	struct kfd_process *process;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> index 12b80b6c96d0..c64ffd3efc46 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
> @@ -27,6 +27,11 @@
>   
>   void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count);
>   int kfd_dbg_trap_activate(struct kfd_process *target);
> +int kfd_dbg_ev_query_debug_event(struct kfd_process *process,
> +			unsigned int *queue_id,
> +			unsigned int *gpu_id,
> +			uint64_t exception_clear_mask,
> +			uint64_t *event_status);
>   bool kfd_set_dbg_ev_from_interrupt(struct kfd_dev *dev,
>   				   unsigned int pasid,
>   				   uint32_t doorbell_id,
