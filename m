Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E66EC001B0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Jul 2023 19:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89FDB10E771;
	Thu, 13 Jul 2023 19:05:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBF5810E770
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Jul 2023 19:05:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YFGSz68hg8Vtp4/rPiX6/sMlE5KNLBTSanNDXq9LRm0tMD7gYfJlDH5wZL4HZ5+7/T86sR2423Duj4a6QjHgh+k27IgRnXOPTpLWLTqtkCVFcgQ/Nd1c/uvKC7YprfhmRhGmk3bsNpHfT1xRhqtfYscbBdRQt033WemWNLxEN71msUe8CLoi+2usGHk4OM0Z7j4WqhrAAAJiCUa/SB6l/Avv91XjiGnaJ8ukzzVIUC23oClPErlFWWtwpQumiHEPn4MQnxXx4L8Gt0sQL+A7ZDjMsP+hnTNIy16avsovrnKrxG6kU9OECPOBpFeqBvUCBKCavLsvx1aogazD2tV43g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOyskfeODogHRb2i5ewjHN69DePq4L5Xic2h1YW3cCg=;
 b=nRb72GEEEKlo6QV6XbxkxeBIBWJQbnSwqiCso23z2od/bhsxF+PxnWbXsSDEXXwjkNq46ek4RRDmcI2DRbgxa8KR4kiMLhRBJt8L8DcM642uOUkT2B8EDZnx39MwPOD/L5WifOXWKRHNoqJ/WuVmHwmlwgTORft5J2tCsGFHJXfrgw9o8jr675l7jOzzFaWizbDjPn3C3mI5X4e5/LTN1iKwJgHLBJ0EPOlRcNCHLX1POEbYlsW2QzvQKknxWbmnkuHhO7zkiF4XP5EthY7PwRLfWBevDX27uEySmFhTKw53Mba8GrIcPZJF2gpHLbWvfnCn2MGF80Y6KKOVf+Nefg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOyskfeODogHRb2i5ewjHN69DePq4L5Xic2h1YW3cCg=;
 b=BxdZaeM7ohH9Y5THQouIsfgCby5sqKukDKSuyqi4Pi3YfV2VQE0OAR/a5whkhGuGOO469IFc/aQ89o0QJrbaRpIO0JPel6jUwyySiJ044L4X5iZWTXoL4dHEMoRIfmBiwiubvgbU0+ypiwKVrU+D+SIQhWLPUv+N7MeBrtUSz3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7364.namprd12.prod.outlook.com (2603:10b6:930:50::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Thu, 13 Jul
 2023 19:05:09 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%7]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 19:05:09 +0000
Message-ID: <41594465-765a-4bb6-68d1-b7ae3635e37b@amd.com>
Date: Thu, 13 Jul 2023 15:05:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 09/12] drm/amdgpu: use doorbell manager for kfd process
 doorbells
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230620171608.2131-1-shashank.sharma@amd.com>
 <20230620171608.2131-10-shashank.sharma@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230620171608.2131-10-shashank.sharma@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::9) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7364:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b510c4a-23a4-4f72-32cc-08db83d413bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lKG3Y565ooNp1ep+m2fya3Dz2hPE03b1P7OCKjGIUvVHe2/GJ/vWjGqm5YG7cX3vczv9bTdjcqcnARUHL1iKXZRSmuKEW5nqHc9z2OfuddiQursNLU4bi6obPB368gjnh4kEm2GGWrCP3/t2Rvj7hanaiGo77eETPq7/RoU/PP9xFZqLxISSqbYct32XX0+AP/EN5c/sxsCcOI96+HdgIByCMMA7x6CyMeWJcJ7tD6PSJhBVcofvOsK2iFx0oorFoYyruK0xD/3chXT1zVFHvI3Oi5KEvU9XugCgjwDK6J5FaeO+nsFcu63YLrjZ4eGt8OWVDQrTvNExcaT8RzdqMI4jugkiBvPydGCxQozCBiOJ9cqFN/3Y+K9uaFnNcEo9nIAAzEcWQdw+QK7Ji+CFhI3YLJFT6StN/ZYUhPldu2wPq9LJ2fRhSexyC0QHPo3FulzU6O3/jAnNh1FLJSYd4xax7e6oB4YogQ2SLMZnd0DoL7ABl14mkmuz/RDmhmDC9EOyQzw5GCJhaDgUjjPd123mIVv4VrtN6xRu4WZgO2NoNFYAI2ja7KCdpv/kw8g+m16tOh2SIeBx3hV/oMtu3yMDphNMgbBiYABChbCW0euLqOT0/Y0biT8ZfNk7k/as+tfc8zJPgiwFXqKmFsnlsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(451199021)(54906003)(36916002)(6486002)(478600001)(26005)(53546011)(186003)(6506007)(6512007)(30864003)(2906002)(66946007)(41300700001)(66476007)(316002)(44832011)(4326008)(8936002)(5660300002)(66556008)(8676002)(38100700002)(36756003)(31696002)(66574015)(2616005)(83380400001)(86362001)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WThXeWJCekRRS0pJMGRJSkk1UkdXaUdDRW5Gci90aU5JaVI3T1BCcEd6bUxK?=
 =?utf-8?B?c1BTUTJ6UjNrd3IwcTJXUWxybHRBZlVtbmwzZDlkcDNpcDhrMkZFZFB5RkFQ?=
 =?utf-8?B?ZTRwWHZsQldTbUJBMHNTOWdMQUsySFpvOURIQkc3Sjh1UWQ1eXdZK28rYUZj?=
 =?utf-8?B?WHk1a21uWmY3dGJ0NDc0S0tYdEprbGNaR0RRY1pnVmVLaUlqVCtrZTlLb1Z5?=
 =?utf-8?B?NndxNUNud2tSdEoxaVJJZlZTUVJ5S0NWbVl5MU8zVzFjZVdYYjA2QlJid0h3?=
 =?utf-8?B?SW5oR0tlTGNkdmZMTEZYS1BQby8raDFpT0dhc1NHV0Zic3ViK29SWUFwRlhi?=
 =?utf-8?B?NXRIYUdadnd3cXlFc2cxRHc5S2dhbXdPVDlYbVZDQmdiSHJMWVJab3ZHVU5Q?=
 =?utf-8?B?ZzZCUkRIeDRHRmhGd3cweWN0K0tzbExMeGJoUXNwNEV5bkJycFRQMitPSU9V?=
 =?utf-8?B?N2RWK01PdzJWUjRvTGVaTkFsNWhCVkkzU1JEYUV5R0pPajkvRDUvYXprNEYv?=
 =?utf-8?B?NWR1WGVwMmlkS0k1OGNFRjY3NnJKUXUzSEJmbWxTc2lScEF0b0orMGFYVHVT?=
 =?utf-8?B?MHVmREJFZFNiYlBNYlhKeUJCbjdOVFppNHhDbVpVTmd4TXQ0dWZKbnR1RVlG?=
 =?utf-8?B?KzNFdnd0TVVKVlh5VDJXZUpidmVJL01XUFpKSVRzcitPSEV0VnFtcUhVYXVj?=
 =?utf-8?B?VGptd2tWc0txb3VBWDlRTE45a3c3VGgvcU96dkVrQWtFQVc0eGFFWEMzR0Vh?=
 =?utf-8?B?M2wvemVPREtQUVBZNkc4NitRQjAvZ2hwVVBNcllNTkVhSzZZakpYdjdBZENn?=
 =?utf-8?B?VGNHVU1tczlsQlIvQ2pQMS9HQkNRWWNpMDA0UGQ0V3RTUWVZdXN3bjJDbE1U?=
 =?utf-8?B?eDdoN0hFV3hTRXN2Y2szdXovK0twZkh3cGxNL2FQVVZUZDFSRVd6QmtZaUg2?=
 =?utf-8?B?YUU5eldZYkRhdmVwZHBvWUt2NGlHM1pBWmRxcllPSzAwc0p2NjRDS01tYlI5?=
 =?utf-8?B?TVkxWXgxaGR3RHNhUGVJMktTM0FIWERCbjlrT2pieWlQSEJZMGU4SEthaUJx?=
 =?utf-8?B?SE0ybnZQc2hRL2RWdDZESTE1UGxFOFNGSGdXeUJTWkMzQnliOG5SdzBkckxJ?=
 =?utf-8?B?QkRmWjJRdU5GRXVmcFc2clh2VDlHa1lqN2tMOGhoU0NOQUFlU28zeHo2d0hN?=
 =?utf-8?B?NyswSUYveGhYRFMzN1ZmZmk1NXF2L2luVURsdVhUcXB6M1JPV3ZVd1E1anYr?=
 =?utf-8?B?YncvWklSZVZxVHFhMUpmdjljS3kyQ1F2dUsvOGZDRjZ3a0J4U1AxYTc5SFhI?=
 =?utf-8?B?dzl3REZhQnR0RjhJc3lTWnltSEhqeFVoWEMyUFI1aDJvNjFnU0IvN0c0RGlk?=
 =?utf-8?B?bll2cFNZRlBqSDlHQVBJQnVoYjQ1OXdlUEgxNHdPaWl1aFR4clpFRk9icFNx?=
 =?utf-8?B?Q0hqMnlsMUhDTUJEczlmV2daVnptRElMbDlUWENINmNGejUwK2crejIzU3RL?=
 =?utf-8?B?QXVnRUhjVHYrcy9MYXpBTE9RSlVmU1ZMLzFwVk9hSGxiZ3pHTGRtcit0RnBk?=
 =?utf-8?B?dm82bVlvekVScjRNRjBjSjZ3RldwKytjSVhsdnFjUm9iSjVoSHBIcjdwWm0z?=
 =?utf-8?B?aEJRTG5MbkZWZjNQS0NXYTFkc3k2bjRBS2JjaWIxTnZBanpaazRvNWh2VCsx?=
 =?utf-8?B?NmV5TXRkQ3U3K1pWOCthd3E4ZVl0M0U0MVhucEFtOWNDblN1bUFpN3BDb2pm?=
 =?utf-8?B?TXAwKy9RSXhSelNHS1owc253VjczaS9TRDlKandENHhZZm5nYTRVWExtbXBy?=
 =?utf-8?B?YW1aR1p4OGxDemtJS2pVQWRHYWFRYzQxVkl2VmJnRGttTkJNdEZsanRKRjZh?=
 =?utf-8?B?WUhkbUkzRGtmOWRXeFJiYU9yZFkvcVh6eUMwM3Mwc04zYjYyTGdINWFwRWd4?=
 =?utf-8?B?VEcxZ0Q4RVBVK0lxalRCWmlhS3Rac2dBb0RrdXg1YklCU2dPL0dPS21LYjBP?=
 =?utf-8?B?aCtya3liSkZac2Fxc1BwVE9XOW1hM01XMEhGMWUzYTI1SlFhYzFSWEdZZGM0?=
 =?utf-8?B?R3pTbjB1b2trWTQ5YWR4UFA0UU1MR0dnVS9FRnM2Uzg1YkJPZGlESytCS1ZG?=
 =?utf-8?Q?I4CVYmsaCtM00JzBasX2F+WHQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b510c4a-23a4-4f72-32cc-08db83d413bd
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 19:05:09.1593 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+VWXb37uQ7Yagxuo6mT5rzdFpGfpVVC+PSuDalrJJS7BhwamEyoCXUNJ7HkCGOeKtWL/iHTblr4rXcAGnJyKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7364
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, arvind.yadav@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-06-20 13:16, Shashank Sharma wrote:
> This patch:
> - adds a doorbell object in kfd pdd structure.
> - allocates doorbells for a process while creating its queue.
> - frees the doorbells with pdd destroy.
> - moves doorbell bitmap init function to kfd_doorbell.c
>
> PS: This patch ensures that we don't break the existing KFD
>      functionality, but now KFD userspace library should also
>      create doorbell pages as AMDGPU GEM objects using libdrm
>      functions in userspace. The reference code for the same
>      is available with AMDGPU Usermode queue libdrm MR. Once
>      this is done, we will not need to create process doorbells
>      in kernel.
>
> V2: - Do not use doorbell wrapper API, use amdgpu_bo_create_kernel
>        instead (Alex).
>      - Do not use custom doorbell structure, instead use separate
>        variables for bo and doorbell_bitmap (Alex)
> V3:
>     - Do not allocate doorbell page with PDD, delay doorbell process
>       page allocation until really needed (Felix)
>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>

Reviewed-by: Felix Kuehling <Felilx.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  20 ++--
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c |   8 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c     | 103 +++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |   9 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  40 +------
>   .../amd/amdkfd/kfd_process_queue_manager.c    |  23 ++--
>   6 files changed, 108 insertions(+), 95 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 1b54a9aaae70..5d4f4fca793a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -327,10 +327,12 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		goto err_bind_process;
>   	}
>   
> -	if (!pdd->doorbell_index &&
> -	    kfd_alloc_process_doorbells(dev, &pdd->doorbell_index) < 0) {
> -		err = -ENOMEM;
> -		goto err_alloc_doorbells;
> +	if (!pdd->qpd.proc_doorbells) {
> +		err = kfd_alloc_process_doorbells(dev, pdd);
> +		if (err) {
> +			pr_debug("failed to allocate process doorbells\n");
> +			goto err_bind_process;
> +		}
>   	}
>   
>   	/* Starting with GFX11, wptr BOs must be mapped to GART for MES to determine work
> @@ -410,7 +412,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   	if (wptr_bo)
>   		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>   err_wptr_map_gart:
> -err_alloc_doorbells:
>   err_bind_process:
>   err_pdd:
>   	mutex_unlock(&p->mutex);
> @@ -2239,11 +2240,12 @@ static int criu_restore_devices(struct kfd_process *p,
>   			goto exit;
>   		}
>   
> -		if (!pdd->doorbell_index &&
> -		    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> -			ret = -ENOMEM;
> -			goto exit;
> +		if (!pdd->qpd.proc_doorbells) {
> +			ret = kfd_alloc_process_doorbells(dev, pdd);
> +			if (ret)
> +				goto exit;
>   		}
> +
>   	}
>   
>   	/*
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 7a95698d83f7..834f640cf807 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -371,7 +371,7 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>   			unsigned int found;
>   
>   			found = find_first_zero_bit(qpd->doorbell_bitmap,
> -						KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
> +						    KFD_MAX_NUM_OF_QUEUES_PER_PROCESS);
>   			if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
>   				pr_debug("No doorbells available");
>   				return -EBUSY;
> @@ -381,9 +381,9 @@ static int allocate_doorbell(struct qcm_process_device *qpd,
>   		}
>   	}
>   
> -	q->properties.doorbell_off =
> -		kfd_get_doorbell_dw_offset_in_bar(dev, qpd_to_pdd(qpd),
> -					  q->doorbell_id);
> +	q->properties.doorbell_off = amdgpu_doorbell_index_on_bar(dev->adev,
> +								  qpd->proc_doorbells,
> +								  q->doorbell_id);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> index f7d45057ed32..c9ca21e1a99a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
> @@ -232,48 +232,97 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd)
>   
>   }
>   
> +static int init_doorbell_bitmap(struct qcm_process_device *qpd,
> +				struct kfd_dev *dev)
> +{
> +	unsigned int i;
> +	int range_start = dev->shared_resources.non_cp_doorbells_start;
> +	int range_end = dev->shared_resources.non_cp_doorbells_end;
> +
> +	if (!KFD_IS_SOC15(dev))
> +		return 0;
> +
> +	/* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
> +	pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, range_end);
> +	pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
> +			range_start + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
> +			range_end + KFD_QUEUE_DOORBELL_MIRROR_OFFSET);
> +
> +	for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
> +		if (i >= range_start && i <= range_end) {
> +			__set_bit(i, qpd->doorbell_bitmap);
> +			__set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
> +				  qpd->doorbell_bitmap);
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd)
>   {
> -	if (!pdd->doorbell_index) {
> -		int r = kfd_alloc_process_doorbells(pdd->dev,
> -						    &pdd->doorbell_index);
> -		if (r < 0)
> +	struct amdgpu_device *adev = pdd->dev->adev;
> +	uint32_t first_db_index;
> +
> +	if (!pdd->qpd.proc_doorbells) {
> +		if (kfd_alloc_process_doorbells(pdd->dev, pdd))
> +			/* phys_addr_t 0 is error */
>   			return 0;
>   	}
>   
> -	return pdd->dev->doorbell_base +
> -		pdd->doorbell_index * kfd_doorbell_process_slice(pdd->dev);
> +	first_db_index = amdgpu_doorbell_index_on_bar(adev, pdd->qpd.proc_doorbells, 0);
> +	return adev->doorbell.base + first_db_index * sizeof(uint32_t);
>   }
>   
> -int kfd_alloc_process_doorbells(struct kfd_dev *kfd, unsigned int *doorbell_index)
> +int kfd_alloc_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
>   {
> -	int r = 0;
> +	int r;
> +	struct qcm_process_device *qpd = &pdd->qpd;
>   
> -	if (!kfd->shared_resources.enable_mes)
> -		r = ida_simple_get(&kfd->doorbell_ida, 1,
> -				   kfd->max_doorbell_slices, GFP_KERNEL);
> -	else
> -		r = amdgpu_mes_alloc_process_doorbells(
> -				(struct amdgpu_device *)kfd->adev,
> -				doorbell_index);
> +	/* Allocate bitmap for dynamic doorbell allocation */
> +	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
> +					     GFP_KERNEL);
> +	if (!qpd->doorbell_bitmap) {
> +		DRM_ERROR("Failed to allocate process doorbell bitmap\n");
> +		return -ENOMEM;
> +	}
>   
> -	if (r > 0)
> -		*doorbell_index = r;
> +	r = init_doorbell_bitmap(&pdd->qpd, kfd);
> +	if (r) {
> +		DRM_ERROR("Failed to initialize process doorbells\n");
> +		r = -ENOMEM;
> +		goto err;
> +	}
> +
> +	/* Allocate doorbells for this process */
> +	r = amdgpu_bo_create_kernel(kfd->adev,
> +				    kfd_doorbell_process_slice(kfd),
> +				    PAGE_SIZE,
> +				    AMDGPU_GEM_DOMAIN_DOORBELL,
> +				    &qpd->proc_doorbells,
> +				    NULL,
> +				    NULL);
> +	if (r) {
> +		DRM_ERROR("Failed to allocate process doorbells\n");
> +		goto err;
> +	}
>   
> -	if (r < 0)
> -		pr_err("Failed to allocate process doorbells\n");
> +	return 0;
>   
> +err:
> +	bitmap_free(qpd->doorbell_bitmap);
> +	qpd->doorbell_bitmap = NULL;
>   	return r;
>   }
>   
> -void kfd_free_process_doorbells(struct kfd_dev *kfd, unsigned int doorbell_index)
> +void kfd_free_process_doorbells(struct kfd_dev *kfd, struct kfd_process_device *pdd)
>   {
> -	if (doorbell_index) {
> -		if (!kfd->shared_resources.enable_mes)
> -			ida_simple_remove(&kfd->doorbell_ida, doorbell_index);
> -		else
> -			amdgpu_mes_free_process_doorbells(
> -					(struct amdgpu_device *)kfd->adev,
> -					doorbell_index);
> +	struct qcm_process_device *qpd = &pdd->qpd;
> +
> +	if (qpd->doorbell_bitmap) {
> +		bitmap_free(qpd->doorbell_bitmap);
> +		qpd->doorbell_bitmap = NULL;
>   	}
> +
> +	amdgpu_bo_free_kernel(&qpd->proc_doorbells, NULL, NULL);
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 42c215782d72..d0abfaccf8c1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -664,7 +664,10 @@ struct qcm_process_device {
>   	uint64_t ib_base;
>   	void *ib_kaddr;
>   
> -	/* doorbell resources per process per device */
> +	/* doorbells for kfd process */
> +	struct amdgpu_bo *proc_doorbells;
> +
> +	/* bitmap for dynamic doorbell allocation from the bo */
>   	unsigned long *doorbell_bitmap;
>   };
>   
> @@ -1013,9 +1016,9 @@ unsigned int kfd_get_doorbell_dw_offset_in_bar(struct kfd_dev *kfd,
>   					unsigned int doorbell_id);
>   phys_addr_t kfd_get_process_doorbells(struct kfd_process_device *pdd);
>   int kfd_alloc_process_doorbells(struct kfd_dev *kfd,
> -				unsigned int *doorbell_index);
> +				 struct kfd_process_device *pdd);
>   void kfd_free_process_doorbells(struct kfd_dev *kfd,
> -				unsigned int doorbell_index);
> +				 struct kfd_process_device *pdd);
>   /* GTT Sub-Allocator */
>   
>   int kfd_gtt_sa_allocate(struct kfd_dev *kfd, unsigned int size,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 07a9eaf9b7d8..bb1281a4feef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1037,10 +1037,9 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
>   			free_pages((unsigned long)pdd->qpd.cwsr_kaddr,
>   				get_order(KFD_CWSR_TBA_TMA_SIZE));
>   
> -		bitmap_free(pdd->qpd.doorbell_bitmap);
>   		idr_destroy(&pdd->alloc_idr);
>   
> -		kfd_free_process_doorbells(pdd->dev, pdd->doorbell_index);
> +		kfd_free_process_doorbells(pdd->dev, pdd);
>   
>   		if (pdd->dev->shared_resources.enable_mes)
>   			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
> @@ -1496,38 +1495,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
>   	return ERR_PTR(err);
>   }
>   
> -static int init_doorbell_bitmap(struct qcm_process_device *qpd,
> -			struct kfd_dev *dev)
> -{
> -	unsigned int i;
> -	int range_start = dev->shared_resources.non_cp_doorbells_start;
> -	int range_end = dev->shared_resources.non_cp_doorbells_end;
> -
> -	if (!KFD_IS_SOC15(dev))
> -		return 0;
> -
> -	qpd->doorbell_bitmap = bitmap_zalloc(KFD_MAX_NUM_OF_QUEUES_PER_PROCESS,
> -					     GFP_KERNEL);
> -	if (!qpd->doorbell_bitmap)
> -		return -ENOMEM;
> -
> -	/* Mask out doorbells reserved for SDMA, IH, and VCN on SOC15. */
> -	pr_debug("reserved doorbell 0x%03x - 0x%03x\n", range_start, range_end);
> -	pr_debug("reserved doorbell 0x%03x - 0x%03x\n",
> -			range_start + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
> -			range_end + KFD_QUEUE_DOORBELL_MIRROR_OFFSET);
> -
> -	for (i = 0; i < KFD_MAX_NUM_OF_QUEUES_PER_PROCESS / 2; i++) {
> -		if (i >= range_start && i <= range_end) {
> -			__set_bit(i, qpd->doorbell_bitmap);
> -			__set_bit(i + KFD_QUEUE_DOORBELL_MIRROR_OFFSET,
> -				  qpd->doorbell_bitmap);
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>   struct kfd_process_device *kfd_get_process_device_data(struct kfd_dev *dev,
>   							struct kfd_process *p)
>   {
> @@ -1552,11 +1519,6 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   	if (!pdd)
>   		return NULL;
>   
> -	if (init_doorbell_bitmap(&pdd->qpd, dev)) {
> -		pr_err("Failed to init doorbell for process\n");
> -		goto err_free_pdd;
> -	}
> -
>   	pdd->dev = dev;
>   	INIT_LIST_HEAD(&pdd->qpd.queues_list);
>   	INIT_LIST_HEAD(&pdd->qpd.priv_queue_list);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 4236539d9f93..5eff74015d51 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -344,17 +344,20 @@ int pqm_create_queue(struct process_queue_manager *pqm,
>   		goto err_create_queue;
>   	}
>   
> -	if (q && p_doorbell_offset_in_process)
> +	if (q && p_doorbell_offset_in_process) {
>   		/* Return the doorbell offset within the doorbell page
>   		 * to the caller so it can be passed up to user mode
>   		 * (in bytes).
> -		 * There are always 1024 doorbells per process, so in case
> -		 * of 8-byte doorbells, there are two doorbell pages per
> -		 * process.
> +		 * relative doorbell index = Absolute doorbell index -
> +		 * absolute index of first doorbell in the page.
>   		 */
> -		*p_doorbell_offset_in_process =
> -			(q->properties.doorbell_off * sizeof(uint32_t)) &
> -			(kfd_doorbell_process_slice(dev) - 1);
> +		uint32_t first_db_index = amdgpu_doorbell_index_on_bar(pdd->dev->adev,
> +								       pdd->qpd.proc_doorbells,
> +								       0);
> +
> +		*p_doorbell_offset_in_process = (q->properties.doorbell_off
> +						- first_db_index) * sizeof(uint32_t);
> +	}
>   
>   	pr_debug("PQM After DQM create queue\n");
>   
> @@ -858,12 +861,6 @@ int kfd_criu_restore_queue(struct kfd_process *p,
>   		goto exit;
>   	}
>   
> -	if (!pdd->doorbell_index &&
> -	    kfd_alloc_process_doorbells(pdd->dev, &pdd->doorbell_index) < 0) {
> -		ret = -ENOMEM;
> -		goto exit;
> -	}
> -
>   	/* data stored in this order: mqd, ctl_stack */
>   	mqd = q_extra_data;
>   	ctl_stack = mqd + q_data->mqd_size;
