Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7B50C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Apr 2022 19:01:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78A110E145;
	Mon, 18 Apr 2022 19:01:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0752610E145
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Apr 2022 19:01:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nview8NSfWYDedPDM68oYU/4+Q6IVFhtghRiEPixkzDeWERfNSrkqvsafP7A81yu3NGPAaZ0fYzqiN0xwJJZ1s1PKwbrLzloVU1e78qLle89DVoeeLjhrtNSmbU1ERybWh3tZzMzHqM7mgYJanqB3qfNjU7GbgEi6agWhfFFdi7mp0UKJtSJvvQs0oIQkssdmxeIAoM7tEqgbBXx6JM8cTQchg6fkdx9Gr3OEAKM7pQTK/vsqq7xGgdmUtGzMMQezQn0qxbN6A/vKRpPN15Gbr3ekSzjfjQvt4M+vsdz1s+JhravM8Jsv/ETLlZSvbeT8uIok+TZ8op1714oWlqVkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26K3OKZCG+Kep87bveaGEdUC9AB7k5A3S1BodudHteU=;
 b=SzkT3ykU8+t9l7wgaW8sycTnGqa3xLMMYy7RXRXJdH2DsQQZr+JBoNUUmATdZozAZs0tjwRmQvWgJyRFNOpjXrvFP72o2UAVADq0GeQsiookcsLdkQyPraueSGbAisYRhbkwyigq8lpLP35QYa69QW5OJRbTqsbpSu3rKPkC79LEPPV4dpAhM06gwoAWdZj6y0y9XewcBse3yuuV3o+G0jDFsPtoftfNyLoqublA+hDXf6rOiF4lvFTxbQEgUkJG5h0FNPG8/ZBv1CD2sXMSzMNNxFnM8a9UmRdZayrjOOKdXX9r70MExfGWD/Z0fmyPnCQvNRbuIbFyBlXC38JLUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26K3OKZCG+Kep87bveaGEdUC9AB7k5A3S1BodudHteU=;
 b=42KA3OTlMneaGUz85W6JA4EnDVER+h7uJEzL4tk+/zBL6yBO3lb6xjriYSFc/8CFawZJ0B1RDwqQmI4ifUg4zqTbBCrirFgOldRJeyYzYXn0xOTu0aCssSoHiAd3HzaWio9Llr8Td/nqM9npSl9/4bSA75dAMZB5dYnE6eWiAs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW5PR12MB5599.namprd12.prod.outlook.com (2603:10b6:303:194::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 19:01:22 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6070:7681:db0e:7702%9]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 19:01:22 +0000
Message-ID: <3c7ad377-c03d-312a-a791-119cbcfdaaee@amd.com>
Date: Mon, 18 Apr 2022 15:01:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/2] drm/amdkfd: Fix GWS queue count
Content-Language: en-US
To: David Yat Sin <david.yatsin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220418164437.1875319-1-david.yatsin@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220418164437.1875319-1-david.yatsin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e4b6347-aa84-4222-86ef-08da216dd432
X-MS-TrafficTypeDiagnostic: MW5PR12MB5599:EE_
X-Microsoft-Antispam-PRVS: <MW5PR12MB5599E193D6D95803E948B23A92F39@MW5PR12MB5599.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tbag24+Z91FjYFipRjg9CAbZS+K3K3JsywYyhqSRRU6LquwjaIRaOLsqG0S0CnVJt7IekLGLTic4/Tt/Hvlw/7DByIkjmrjF63NCIPutreMBwN03SrseVoVsCms3C4A04cP7cV7j/wQckHR/DroIlE7vf22nuHErLI2/UElMgLDPt7+YiUjqur9S15tOTSG4x/Cpwvxv9LLeajndjXWTOcu9fUT1kxuPZHfKlhTK0Xh//vkA0SqG50LIo23EN3mwZU13xDqP46PigxTjV18yg/6/mgdz4iUlRHzv82Kalwqlp3GZMsbC+uFQt6bIC739kzkOnsY2Wgg1C0yJ+yKX6ScZGAEGgQLkXCZRnoahTHHIvFRTzOGZVBvjohXR8sNe8ndPWY9AeKVWBI3OKz/LJemlC4gHohMp5EHTPq4uyIVoIsr7Cok4NFhuMZ7mPkjd5/hU/nmN282Fb89Z6KuXk6IVUWHatY2PQGBD41ewlxDFcd9HbQV8XJlA/fWyj6fpvOM7lkJ5vA1dweJez2UFrrYhwfzrR+Gv7yU7d+5JHucNaJQDoinBC+nnU99TKF3RkL5pnR0uZRuHwr+dFlfwAc3uUJ+u4XW/FEBbCd119cDLgGSqD4OsJFjj35nOLzPRc4uErLEYp3l+kfQShq7V2lT9Y/HmTokDUTb3Os1ofE9jqgYfKmrMmeel1/AWHIIhIB3HEmyt+vfrV61Uad/KnZLxbhmInVdbnruy2ducunabECrCXC3yH0/BCe9WBscA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66946007)(316002)(66556008)(66476007)(38100700002)(8936002)(8676002)(2906002)(36756003)(44832011)(31696002)(31686004)(86362001)(6506007)(83380400001)(5660300002)(508600001)(6486002)(6512007)(2616005)(186003)(26005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2FlMGhsOFpWQ29rTXVPZlg1Zy9DZlFiMDg0WDZ0b3dnOCtWNUFmTjdxeHRl?=
 =?utf-8?B?M2FIZm1NR0N4MUNLNklTSDd1SmRvaXVPRjk4M1BRWVJVZXplQXRmbHVuNUZX?=
 =?utf-8?B?WDh1TWVuVDlRcTlsTVZLMThFTWphVVVmamUzL2xUMklvUFo3V2tZYVdNNnNx?=
 =?utf-8?B?U0M3Ukt6Qkt0aXZ3d1pLVHZsVEpJSGtqOHd3TDlmYTFyODFLWXg0bUxxNVV5?=
 =?utf-8?B?eFBNTVN4Q1k1RWNMdER3TWxTQi90eWs2VjBsMFV0Q0ZSVGtKSkNOYUZoWE50?=
 =?utf-8?B?eWptdXJEUFhQR2crdGFkWTdDWW8xY283SEY4M0JTK1hVR0VISTNab3J4U1dJ?=
 =?utf-8?B?ZWQ4S251eUN4YjI1cXBlSTdGdXdGaG02blpOWUd4MEZrTi84T1BjZHVQZXlD?=
 =?utf-8?B?VkwrZWNscUhHT1ZEanNYbHNFS0doazZjOTQreGtDN09DME5sZXFPY2RWNXdl?=
 =?utf-8?B?cDNiZzh2aVQrRnh0Q05PS085V05mVEFML3JYb0htK1dWOGIwZlRhYzF1TDBQ?=
 =?utf-8?B?eXdTK0pVU3BCaTdWaFU0K21vZ2FuUEk5TWZKK085RDlnOWpTNlVwTUxHd0t4?=
 =?utf-8?B?Mi9iT2FzaFYrSVE5alptSzkwcDhQa2ZCUEl2YTdrYVJiMDlBTlNpSG5yeVNh?=
 =?utf-8?B?d3R6azZ0UzlKa3Nid08vaUZCNXcyS0xhZzBDUERCYlBxZjc3YU1iandrdDFV?=
 =?utf-8?B?K0l2SHcvSEYyWkw4L2dkVFFFVjBNRGtaMTNMRFBIYVBhWFVHaHNpMWFYdDF6?=
 =?utf-8?B?ZEZtMDhRYXZwTUN0aDZQYkpsTGtvSUJoK1F3SHB0ZXFVaWo1TzJONEN1WnVa?=
 =?utf-8?B?NjFhL3hFVmxTQVIyZnQ5Q2ZhQUZhRVcyQm95dWx0dzlvZ1h6ZG5GQmFmaDc4?=
 =?utf-8?B?ZzcxYmpZdFJCU1VkQTQ2eWkzU3VCK3g4OGFyUy8xOXFLS0VNbGxPKzk5VGht?=
 =?utf-8?B?K2sxdmdNR3V6Tm4vQnQwMXppNU5Ua0pSMXphd3RscHJudUV2OUg2K2V3ZXdD?=
 =?utf-8?B?UXcxSk94U3ByYStoNTdoRTFRYlB4T2RKQXhtd0RURXp5dlByWTlRTW1VTlJM?=
 =?utf-8?B?eWtWMktYUzB0Sjlibm1HQk81QXZmYkhIZzRvRUpndmhvQ0ttVzdEMkFjbXVa?=
 =?utf-8?B?cW1DWlV0Vys0ZmNuRTc1eHYyRkVlRGFnYWNVT2VDcUYwN01JSTRVREM0U1ZP?=
 =?utf-8?B?bE9RUUpvcXNFQnVVL0ZLZGNkZkNwdFJqRng5RDVidHVSa3ZENnY3c1ZCbmpu?=
 =?utf-8?B?cWR0Y0daeWNKcVEyOWFuc1cydnAvWEtPUlluTlFPaVVLSkRiWHRUNG55dnNQ?=
 =?utf-8?B?V2V6bTRnYjFLVmRORFVRajRpS2VLdVhCNm0wMjZqUHhKdEk4N2tYRUxySEQx?=
 =?utf-8?B?LzMxdGlWemJFbVRUZWNBRmdEU1lTcTdLZVVBWGNxMmJTQ1Zqc3lDd2l6QSt0?=
 =?utf-8?B?aStoRnFuaU8vZFlXMm1kNTQvcHRrR0swaHFPR3BIK3BsN3JDS2NIZDRBQkVH?=
 =?utf-8?B?bjRlYmdjMjZIaEc3NS9ZTEpyUzlFT1V3TGI4c1g5d3l3N2lTU1VIandQR3RU?=
 =?utf-8?B?QlRHRFpPbFd0akd6WFZETWU0TlgxRmh5cmtWK0tlV2J4Z2pUV0FQTVd0SzRy?=
 =?utf-8?B?STZycXJLTEFJcncyQW5KdWFreVRvam5YQWl5KzhaRUlkTG1XVHJiQXg3Wk02?=
 =?utf-8?B?WEQ5MERodk1FOXBrdC95dHpwVVV1cGJ3VHMxNHdXT0xYTTErS3E2Y2VkWis1?=
 =?utf-8?B?dE9ZaUE1ZDNjNzVKMnJxVnBSVUkzY0ZRUXNKdk9sOXltYkIxS0NsSzhuY1dT?=
 =?utf-8?B?ZnVkVzRBRndKSGpKRktUaUQyTDhSTjBZNmRkSlBNYkVuUTZranp5dXdWb0xM?=
 =?utf-8?B?Vm8wZDMrUk55TUVlMlRrSEsvYXI3aVdNVzArbW83NUhBNFhDK1JOOUQ2MS9G?=
 =?utf-8?B?ZEhWT2YrTWFvWmlvRG9zKzlPdjgzYUJzaUtWcStNT2dYTWhXa0czMHVhL1J5?=
 =?utf-8?B?c0FnRlJOYjUwQUROSHB4UFozVzJMNTY5ckt2MXJhenhUOXg2c3RKOGNjYjM5?=
 =?utf-8?B?ZS9rZSsySUcrblVqaWxHejhpUk4zcWt5RzdiQUJxd21sbGpQZFBlTmVhT0Jl?=
 =?utf-8?B?MXFXQ0FtZmhEY0VXa04vZlYxMzRNaTlhNXdoU0JHQTNvK0tOd2lVcXVPV3Y1?=
 =?utf-8?B?LzZiVysxa1Yzc2FXdVYrYzlYdWpGb2tsaFdjVCsrWWM5aHVSa1F4cDRZYy81?=
 =?utf-8?B?NG5HejFxNVdJR29sSU5OS01idVl1T24vdkhoTExkaHVRbmdsSmF2WDVmS0Js?=
 =?utf-8?B?cTdyQkxxcC9lcDhGWGZRajBJSXQ1Z3NSZTNPcG94VythTUt6Y3pxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e4b6347-aa84-4222-86ef-08da216dd432
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2022 19:01:22.3297 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eDxK7I72JiVn3CZheKPIn/UV/wyHyA5JSFV0RMi66I8zocrAQnc3m7ReATdLA8im7zjI6yfQ9zg7vlZsnvegzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5599
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


Am 2022-04-18 um 12:44 schrieb David Yat Sin:
> dqm->gws_queue_count and pdd->qpd.mapped_gws_queue needs to be updated
> each time the queue gets evicted.
>
> Signed-off-by: David Yat Sin <david.yatsin@amd.com>
The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 83 +++++++++----------
>   1 file changed, 37 insertions(+), 46 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index acf4f7975850..198672264492 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -130,19 +130,33 @@ void program_sh_mem_settings(struct device_queue_manager *dqm,
>   }
>   
>   static void increment_queue_count(struct device_queue_manager *dqm,
> -			enum kfd_queue_type type)
> +				  struct qcm_process_device *qpd,
> +				  struct queue *q)
>   {
>   	dqm->active_queue_count++;
> -	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> +	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
>   		dqm->active_cp_queue_count++;
> +
> +	if (q->properties.is_gws) {
> +		dqm->gws_queue_count++;
> +		qpd->mapped_gws_queue = true;
> +	}
>   }
>   
>   static void decrement_queue_count(struct device_queue_manager *dqm,
> -			enum kfd_queue_type type)
> +				  struct qcm_process_device *qpd,
> +				  struct queue *q)
>   {
>   	dqm->active_queue_count--;
> -	if (type == KFD_QUEUE_TYPE_COMPUTE || type == KFD_QUEUE_TYPE_DIQ)
> +	if (q->properties.type == KFD_QUEUE_TYPE_COMPUTE ||
> +	    q->properties.type == KFD_QUEUE_TYPE_DIQ)
>   		dqm->active_cp_queue_count--;
> +
> +	if (q->properties.is_gws) {
> +		dqm->gws_queue_count--;
> +		qpd->mapped_gws_queue = false;
> +	}
>   }
>   
>   /*
> @@ -412,7 +426,7 @@ static int create_queue_nocpsch(struct device_queue_manager *dqm,
>   	list_add(&q->list, &qpd->queues_list);
>   	qpd->queue_count++;
>   	if (q->properties.is_active)
> -		increment_queue_count(dqm, q->properties.type);
> +		increment_queue_count(dqm, qpd, q);
>   
>   	/*
>   	 * Unconditionally increment this counter, regardless of the queue's
> @@ -601,13 +615,8 @@ static int destroy_queue_nocpsch_locked(struct device_queue_manager *dqm,
>   		deallocate_vmid(dqm, qpd, q);
>   	}
>   	qpd->queue_count--;
> -	if (q->properties.is_active) {
> -		decrement_queue_count(dqm, q->properties.type);
> -		if (q->properties.is_gws) {
> -			dqm->gws_queue_count--;
> -			qpd->mapped_gws_queue = false;
> -		}
> -	}
> +	if (q->properties.is_active)
> +		decrement_queue_count(dqm, qpd, q);
>   
>   	return retval;
>   }
> @@ -700,12 +709,11 @@ static int update_queue(struct device_queue_manager *dqm, struct queue *q,
>   	 * dqm->active_queue_count to determine whether a new runlist must be
>   	 * uploaded.
>   	 */
> -	if (q->properties.is_active && !prev_active)
> -		increment_queue_count(dqm, q->properties.type);
> -	else if (!q->properties.is_active && prev_active)
> -		decrement_queue_count(dqm, q->properties.type);
> -
> -	if (q->gws && !q->properties.is_gws) {
> +	if (q->properties.is_active && !prev_active) {
> +		increment_queue_count(dqm, &pdd->qpd, q);
> +	} else if (!q->properties.is_active && prev_active) {
> +		decrement_queue_count(dqm, &pdd->qpd, q);
> +	} else if (q->gws && !q->properties.is_gws) {
>   		if (q->properties.is_active) {
>   			dqm->gws_queue_count++;
>   			pdd->qpd.mapped_gws_queue = true;
> @@ -767,11 +775,7 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
>   		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>   				q->properties.type)];
>   		q->properties.is_active = false;
> -		decrement_queue_count(dqm, q->properties.type);
> -		if (q->properties.is_gws) {
> -			dqm->gws_queue_count--;
> -			qpd->mapped_gws_queue = false;
> -		}
> +		decrement_queue_count(dqm, qpd, q);
>   
>   		if (WARN_ONCE(!dqm->sched_running, "Evict when stopped\n"))
>   			continue;
> @@ -817,7 +821,7 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
>   			continue;
>   
>   		q->properties.is_active = false;
> -		decrement_queue_count(dqm, q->properties.type);
> +		decrement_queue_count(dqm, qpd, q);
>   	}
>   	pdd->last_evict_timestamp = get_jiffies_64();
>   	retval = execute_queues_cpsch(dqm,
> @@ -888,11 +892,7 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
>   		mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
>   				q->properties.type)];
>   		q->properties.is_active = true;
> -		increment_queue_count(dqm, q->properties.type);
> -		if (q->properties.is_gws) {
> -			dqm->gws_queue_count++;
> -			qpd->mapped_gws_queue = true;
> -		}
> +		increment_queue_count(dqm, qpd, q);
>   
>   		if (WARN_ONCE(!dqm->sched_running, "Restore when stopped\n"))
>   			continue;
> @@ -950,7 +950,7 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
>   			continue;
>   
>   		q->properties.is_active = true;
> -		increment_queue_count(dqm, q->properties.type);
> +		increment_queue_count(dqm, &pdd->qpd, q);
>   	}
>   	retval = execute_queues_cpsch(dqm,
>   				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> @@ -1378,7 +1378,7 @@ static int create_kernel_queue_cpsch(struct device_queue_manager *dqm,
>   			dqm->total_queue_count);
>   
>   	list_add(&kq->list, &qpd->priv_queue_list);
> -	increment_queue_count(dqm, kq->queue->properties.type);
> +	increment_queue_count(dqm, qpd, kq->queue);
>   	qpd->is_debug = true;
>   	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
>   	dqm_unlock(dqm);
> @@ -1392,7 +1392,7 @@ static void destroy_kernel_queue_cpsch(struct device_queue_manager *dqm,
>   {
>   	dqm_lock(dqm);
>   	list_del(&kq->list);
> -	decrement_queue_count(dqm, kq->queue->properties.type);
> +	decrement_queue_count(dqm, qpd, kq->queue);
>   	qpd->is_debug = false;
>   	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES, 0);
>   	/*
> @@ -1467,7 +1467,7 @@ static int create_queue_cpsch(struct device_queue_manager *dqm, struct queue *q,
>   	qpd->queue_count++;
>   
>   	if (q->properties.is_active) {
> -		increment_queue_count(dqm, q->properties.type);
> +		increment_queue_count(dqm, qpd, q);
>   
>   		execute_queues_cpsch(dqm,
>   				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
> @@ -1683,15 +1683,11 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
>   	list_del(&q->list);
>   	qpd->queue_count--;
>   	if (q->properties.is_active) {
> -		decrement_queue_count(dqm, q->properties.type);
> +		decrement_queue_count(dqm, qpd, q);
>   		retval = execute_queues_cpsch(dqm,
>   				KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
>   		if (retval == -ETIME)
>   			qpd->reset_wavefronts = true;
> -		if (q->properties.is_gws) {
> -			dqm->gws_queue_count--;
> -			qpd->mapped_gws_queue = false;
> -		}
>   	}
>   
>   	/*
> @@ -1932,7 +1928,7 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   	/* Clean all kernel queues */
>   	list_for_each_entry_safe(kq, kq_next, &qpd->priv_queue_list, list) {
>   		list_del(&kq->list);
> -		decrement_queue_count(dqm, kq->queue->properties.type);
> +		decrement_queue_count(dqm, qpd, kq->queue);
>   		qpd->is_debug = false;
>   		dqm->total_queue_count--;
>   		filter = KFD_UNMAP_QUEUES_FILTER_ALL_QUEUES;
> @@ -1945,13 +1941,8 @@ static int process_termination_cpsch(struct device_queue_manager *dqm,
>   		else if (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)
>   			deallocate_sdma_queue(dqm, q);
>   
> -		if (q->properties.is_active) {
> -			decrement_queue_count(dqm, q->properties.type);
> -			if (q->properties.is_gws) {
> -				dqm->gws_queue_count--;
> -				qpd->mapped_gws_queue = false;
> -			}
> -		}
> +		if (q->properties.is_active)
> +			decrement_queue_count(dqm, qpd, q);
>   
>   		dqm->total_queue_count--;
>   	}
