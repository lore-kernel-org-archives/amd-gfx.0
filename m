Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CE0C32771
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Sep 2022 19:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5986710E78C;
	Wed, 28 Sep 2022 19:02:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F90F10E7F4
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Sep 2022 19:02:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GROeLeHjBgE1KvYJ8H5I5CbaVNdw2YgPZ9vpeSXBx3WMVeyEOBeeAvdQ0UI6a3vUHeIqrn1weavADZLuZq0xAzpbq40Yhn9g8Od0gmq4totAi5eSX6lCzjXKXbQmtbL5y0owlWpfk9o4AGGKmRv5XHri7exeNDBGg8gAaIqGmfwU8BQpuzvKpbHrCM/wZ0AcnaY6vaHFy/UDOQUZG37c7M4zl6CpXDaKRp46iYP+HyHHlASpk2GfhUOWDjrU2i/hayL8G/6pDEY5cfAQSH6PxxJRVdHMOFh84Fck5FhzYqw6mS/NqgDCTEH1hLORX8M0n/r6y3Gu96tJ9JVq8UaREA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XeOm2DUQVLBCZmlVQ0qLk7DEAo2dpWDO0wNZmc6G36g=;
 b=eBLWOFPL+XNbbN3SstlKzI4kglQMyuP6Tzf3WOtlWwu2TxYqnlfHIfukrQf5S9LI1QRfVHjHo/OFEvx9ob0/fi3qLikN5mbG7/I6lE+3VwiL+2f5964cia3zOgTu5GMHxGsvZro065jB8EtczvpiD9Kj8pd2BQzt3HM5YvJhJccbQp2cEncOcdGS81OXIoJ0dfdYOEg3vdKPt1TIJZ7OCQpvuwOYxyd6gWVqzuNRsPS5e/aDH73bLx08+DZKLOxG3IHTbZKFwigyeF+mEzlY3xqFNdZAydIfbUcE781LB38Qz2Gc1ROg7Zq+I0hhPsrspwfUyfJoSH7JVrqx6W5h/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XeOm2DUQVLBCZmlVQ0qLk7DEAo2dpWDO0wNZmc6G36g=;
 b=0PW/oDMF9LujWeUEO/D5dL6Q9vD02JLnVpSvI3N2TVw2p29AJuH/mSXgJ4Glv8eg+Mn44WJb79Cbu1NYtDcijSWHeorZ0YkMcIguHvP+/br5jkGB/Tr4QW+OYPtK72hzpqkexLypyQv+IwyRhT2qPtwVC9jX+M0bnyc0o7Zwg5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Wed, 28 Sep
 2022 19:02:49 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.017; Wed, 28 Sep 2022
 19:02:49 +0000
Message-ID: <cb7e741c-82ae-727d-f958-dc49cd06b7ad@amd.com>
Date: Wed, 28 Sep 2022 15:02:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 1/1] drm/amdkfd: Track unified memory when switching
 xnack mode
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220928161153.17523-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220928161153.17523-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0129.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::8) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c6871a5-146e-4af1-f1c9-08daa1840970
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PS+oeW4c/Y/nAkZsM6YntYjShxysgJnnZaI7XKnagK+apRsYLos+63Y1yhdZOffRi5d4/2hFWSfNiJaG8ZIi1mPpFdH3uVEOGva+NZsRHftc1/9l6GJQYenPckBzrdzN2t8I/OXmKTwxUl+/Y6YxheN37FAfCB8WQocoTQm/ib0BRzA8oIVztLCKGqkMMdy5n9UjMBZnCt8YUHApEIiaPy2liNNcGWIIcnnad47CEc8EDMtVtHL1GixX69m8JEUW+VLWhP6Z9FkHQMI4c9njJI0+0zY0WYJ/lEaSPV+Yrgf3KoG0xExrB7j/iyLo3PyB8sJIYkyndb21q7vtx2U42JrQsSzD7+nXOKPODJZpEpOJmcsuYJczdPiisLaiu/BfeTRlg8zSCNOPAOeTi6s+D8UTXqnP3ogAqo0eT+EdhuAiyKjlwIOP+UUVdN6SxJ9QBL6BwLTX8Y/h+T88Rjn5BVz19UWvy+aJqYVBgY4fZL23rTJeOEpONmmFhD398dX6QJOxBB9RCAxT2xqwwYPy4c6D7/gcb28FQwA6ww+uptWJKfJEZLFyJZaRSaeZGjb6ZmiELDCgWV5ar/xlAYh+SkxcEcVXJrGSZws2OrptnFXldm6FX2j+dhS6CDgT1+FDpDZo3bvisDovunIzBKZ5jZVQoEsGCQDP27dEodYN9rIJTLeHUrbr0aDT35+lrfKrMHa3W6rhBrQj5p0yGwHIvt23T1qCXcVv1PR+jl6b2khjspzaJqqoRIR1IuaFg6nzddy3vPmTszaYVczib8sWkDVOYenZ7/x0BNAUd5UZwCI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199015)(6506007)(41300700001)(6512007)(36756003)(478600001)(66946007)(2906002)(31696002)(26005)(44832011)(8936002)(83380400001)(8676002)(66476007)(66556008)(86362001)(2616005)(5660300002)(186003)(316002)(38100700002)(6486002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmo5bENLVjYvVndrMDZ5WFphczRtWjNvQzlydzNENzBIVnpsemRFeDIxRnRP?=
 =?utf-8?B?VHBRS1RNQlZpRlZoWlU5YitoNnI3N2g0SlJnVmh1NG01Ry9yZE5ldVRNVGEw?=
 =?utf-8?B?dFE0a2J0TjBaenlhN2xjcWM1RFZjN1V5clhPR1EwdTZpRi9lclBMNlJ0Ukdr?=
 =?utf-8?B?ZlhQcXQ1cUl4d1kxT3ZycmJ6ZFIzSG5pYkR6TEpUVUw5ajhONllFOGpSODY0?=
 =?utf-8?B?VXpjM3FZQzhiVm9uZk9IcExNd0YrMmN3N2JIRU5lQWJ2dDZiTU5ZS0FMU1VG?=
 =?utf-8?B?b3A1cTZDbzM4Q1FBbGV1V05nU2twd1N6cjdOUkFValUyeTByMnB1cEg2WWlm?=
 =?utf-8?B?NUJCWW5nWVlXV2tuVWxnMnQzb3FCS20yNTVvbWhFYy9VUVhualZRb1g4UUVt?=
 =?utf-8?B?enpvQm5JWFBOeVAzc21GTlF4di9ZMHZRQWJOYXlxNjhlNVFvaWdhN29rYlgv?=
 =?utf-8?B?aUcvSmdsVkIvRjI1c2g1MzRxYUVoeCszaEUrU0YzTlNjckUxdDBwYm5OQlYx?=
 =?utf-8?B?YmFLRllmZ3RiMCs2QzRWZWxKRitKU3FGL3g1NlUrd0tYTUhZUlljZ1NNUGxR?=
 =?utf-8?B?dE9XK3RFcmlISExBWC9ZR2lxQmtoMFlPZUY3azFHNFFLU0RqTTFxSndIaDZo?=
 =?utf-8?B?Z3ZRT0tDYnViRnVRRjFJSmQzRFFwUjYvMGdQTW1YKzRCSFZjNW80YlUrOVI2?=
 =?utf-8?B?bElEMzQwa1lGR3NFVkVUTlNiSHNVL2V3Zjl3L0ZOR01vQ25yYzNuOW9TVUpr?=
 =?utf-8?B?Ump5dVJnZVhRaXA2eGNzTlI3VGhwbXBqenNlUHE0dHQwWlV6SkVTNE1ScnZP?=
 =?utf-8?B?VDFQbUcvY25vYjB3YVVTaE13Rloxc3I4b2loOUVDODJkUysvM2YzWFBLVUFn?=
 =?utf-8?B?NzBMZmtFUVljRzB0WER5cDlseDJ3RGQ5RDMzZEZLbUxFci9zVktEcEV4SGJs?=
 =?utf-8?B?SzRvTnNCc3o3Z291ajdvQmszcUY0cS96NEdzYlRxNGhuVmVBUmVldTlpc1Vw?=
 =?utf-8?B?RHdUcFhvOUlQWnBSbEpUVXBiMUh2djBmQWhDeXZTbGJYUlQ5YlZhRGRRTGpB?=
 =?utf-8?B?dEQ4dUE1RUJVSWhQdGc0UkZleUhUd0VKWVpNRTU2WWhGUnZnRkd0SUxzdG5H?=
 =?utf-8?B?NHA1Z1hERHJIQjg3RWczZktzMVFZRldobWl6bmZTRHgvWFduVlJQSUZHejlB?=
 =?utf-8?B?dkNndTNJblJaa1ZwaFhjclVGb24yZjZmSS9FVnMxVGtWWlkrZTJvS0NLRUFV?=
 =?utf-8?B?ekpIY1FRZE1NWDFRZjZhSm5XZEp1Q0p2dGdqR3BhS21pSCtZaFUyR05VQlZN?=
 =?utf-8?B?NEI4dHNOSTQ1WWdYV200bFQ4YVZOZUs5bkxnSnpCYkhoV1BqYkNoRG8vMW1W?=
 =?utf-8?B?dWJLZ3lqUEhkYmJVVFJscWwxZlp2L3hEb0RNcjVFZWdoRkZGWjAxQWRla3Jk?=
 =?utf-8?B?dVpxZEdsMmNKMVgvd294WUlKZFdhWjJUQmc2UXpqN2FBMFRwTDFiMmt1WXpJ?=
 =?utf-8?B?a3VYSUVZajQydm5PUklMVGZ1QzhkamIrU2xvWC81U3VzUk9FTFBudjF1ckFQ?=
 =?utf-8?B?WDNVNG1OSExXYU9Cdmc4N01hTE5KNHk2cUdoQmRDSy9PVlRVVFFZSDFNalIz?=
 =?utf-8?B?QXBxT3VhNFlIY0ZDVWtmam9UaVcvUStiaE92VXNobGovd1hLa29xM3RHbWFz?=
 =?utf-8?B?bSt5U2RSRVE4RDEwTnFxNTdvMW5YWi9lZ1NVY1VzVnF5UnVzM2k0OUZCRnFS?=
 =?utf-8?B?TUV5c0Z0R0g3elh6bHFtR0t5YmJDNXRxWlZ0ZWNPcmQzSnQ3SVlmdVI4RTN0?=
 =?utf-8?B?N3FpY0pURDNSWS9ZRWlqdXN1K2psRFZ2SWpLaWhpWUc5RlhWUWhIYTU0RURa?=
 =?utf-8?B?c1NNL0xRU2dacENTMjZETURzNW5SVGc0VUg3dk5iaGpnNlEyS3pkK0RkaGta?=
 =?utf-8?B?ZzJCb0ZmVDVIUno4WGZzM3Z0azVJaEVOcjZzYjZaY1NVLy9pc09NVGRMbW81?=
 =?utf-8?B?ckliN2U4QjZab1B5bWsvMzl4dDhOYkFsbFNQcFc5QWttYUR5VHRpYVI1Skpm?=
 =?utf-8?B?ektxbXk4Yy9CTjFrS1hXWmtHSDZRdjNzWGsxV285Zy9XN1g4akdBdGlVSElW?=
 =?utf-8?Q?E++kyYvqv+4gDOc1W5WnKf2TR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c6871a5-146e-4af1-f1c9-08daa1840970
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2022 19:02:49.3592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YEbjtunPISYsxHdbDN5yCG7F3PiXDRL72S61ho42E8uio2QM9rhYwmkcjHvigE4jyVtMW+w/WIX3m71Yzb/OKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6165
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


Am 2022-09-28 um 12:11 schrieb Philip Yang:
> Unified memory usage with xnack off is tracked to avoid oversubscribe
> system memory, with xnack on, we don't track unified memory usage to
> allow memory oversubscribe. When switching xnack mode from off to on,
> subsequent free ranges allocated with xnack off will not unreserve
> memory. When switching xnack mode from on to off, subsequent free ranges
> allocated with xnack on will unreserve memory. Both cases cause memory
> accounting unbalanced.
>
> When switching xnack mode from on to off, need reserve already allocated
> svm range memory. When switching xnack mode from off to on, need
> unreserve already allocated svm range memory.
>
> v5: Handle prange child ranges
> v4: Handle reservation memory failure
> v3: Handle switching xnack mode race with svm_range_deferred_list_work
> v2: Handle both switching xnack from on to off and from off to on cases
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 ++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 56 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  1 +
>   3 files changed, 76 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 56f7307c21d2..5feaba6a77de 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1584,6 +1584,8 @@ static int kfd_ioctl_smi_events(struct file *filep,
>   	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>   }
>   
> +#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
> +
>   static int kfd_ioctl_set_xnack_mode(struct file *filep,
>   				    struct kfd_process *p, void *data)
>   {
> @@ -1594,22 +1596,29 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
>   	if (args->xnack_enabled >= 0) {
>   		if (!list_empty(&p->pqm.queues)) {
>   			pr_debug("Process has user queues running\n");
> -			mutex_unlock(&p->mutex);
> -			return -EBUSY;
> +			r = -EBUSY;
> +			goto out_unlock;
>   		}
> -		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
> +
> +		if (p->xnack_enabled == args->xnack_enabled)
> +			goto out_unlock;
> +
> +		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
>   			r = -EPERM;
> -		else
> -			p->xnack_enabled = args->xnack_enabled;
> +			goto out_unlock;
> +		}
> +
> +		r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
>   	} else {
>   		args->xnack_enabled = p->xnack_enabled;
>   	}
> +
> +out_unlock:
>   	mutex_unlock(&p->mutex);
>   
>   	return r;
>   }
>   
> -#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   {
>   	struct kfd_ioctl_svm_args *args = data;
> @@ -1629,6 +1638,11 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   	return r;
>   }
>   #else
> +static int kfd_ioctl_set_xnack_mode(struct file *filep,
> +				    struct kfd_process *p, void *data)
> +{
> +	return -EPERM;
> +}
>   static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
>   {
>   	return -EPERM;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index cf5b4005534c..ff47ac836bd4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -278,7 +278,7 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
>   	svm_range_free_dma_mappings(prange);
>   
>   	if (update_mem_usage && !p->xnack_enabled) {
> -		pr_debug("unreserve mem limit: %lld\n", size);
> +		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
>   		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
>   					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
>   	}
> @@ -2956,6 +2956,60 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	return r;
>   }
>   
> +int
> +svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
> +{
> +	struct svm_range *prange, *pchild;
> +	uint64_t reserved_size = 0;
> +	uint64_t size;
> +	int r = 0;
> +
> +	pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, xnack_enabled);
> +
> +	mutex_lock(&p->svms.lock);
> +
> +	list_for_each_entry(prange, &p->svms.list, list) {
> +		list_for_each_entry(pchild, &prange->child_list, child_list) {

I believe the child_list is not protected by the svms.lock because we 
update it in MMU notifiers. It is protected by the prange->lock of the 
parent range.

Regards,
   Felix


> +			size = (pchild->last - pchild->start + 1) << PAGE_SHIFT;
> +			if (xnack_enabled) {
> +				amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +			} else {
> +				r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +				if (r)
> +					goto out;
> +				reserved_size += size;
> +			}
> +		}
> +
> +		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
> +		if (xnack_enabled) {
> +			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +		} else {
> +			r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +			if (r)
> +				goto out;
> +			reserved_size += size;
> +		}
> +	}
> +
> +out:
> +	if (r)
> +		amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
> +						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
> +	else
> +		/* Change xnack mode must be inside svms lock, to avoid race with
> +		 * svm_range_deferred_list_work unreserve memory in parallel.
> +		 */
> +		p->xnack_enabled = xnack_enabled;
> +
> +	mutex_unlock(&p->svms.lock);
> +	return r;
> +}
> +
>   void svm_range_list_fini(struct kfd_process *p)
>   {
>   	struct svm_range *prange;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 012c53729516..7a33b93f9df6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -203,6 +203,7 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
>   void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
>   
>   void svm_range_set_max_pages(struct amdgpu_device *adev);
> +int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled);
>   
>   #else
>   
