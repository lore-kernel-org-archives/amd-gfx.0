Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 647EBC28D13
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Aug 2022 18:01:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EFC32BFE8;
	Mon, 22 Aug 2022 18:01:08 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA14190843
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Aug 2022 18:00:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5xcakqaie8QViin0gT271aT5SgFlEZ+2vKfHW/X94utmg9T1vLljWrFABEwrY4+KJBfFynVWmCEa7COpObEJq23ozI++W+TCMaqbilssXjpCad0tJ29VazG8J5F7JpmIPZyPKuV+PWd4YsLghAS9LfshrJpjAq46rd8V/1rs7CsaiCZKtEOkIZk7zWHd+JJKj353B1uNBI9Yc9GESSd1SjF+UoMRj7nRB+nix+h89t5W09Mcy9K8z7lWEjaoE+5MSV3T2uM0tunieDbPsXe3y9oc8CrIA9/1pfJ1wpgCSjKmwj0vKJd/9xbp4bzfu+oPdl+mOvGv5gS6QzLkgwtnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dc1Gqlo4+gpQfju3NyQX+F3noi/8oJh4IHNPh1OAva8=;
 b=JlH9N6nOIFxoRkAN/tb1VyJDeIS7E1XoMr8WbLy69QNu3DyiXeuyrO/nMlsTvnyISXHciinffm2D6wie2nQbmdWKTzmu8CaClMc54SvR0M0VoZfK1/jEgkNGOuhPnYtDgTsOykFXFpB1C7WOsxezaAqQZm55pWJr6diComQzlyo+TbTR+fYQZmy+ANlV5CVDBHRdmOpHPDOESiG8SSB2s4JFe1iHdSY/kPW76oMB03rDLU+GcBj3olfMmBdi3wAv03oxGBjlBgKUCM1QcFHhaSOUQ7ZZcXbF8JahmY7FPLd1SmRqC8TZeMhbPi4ill2wnBZqhwj/tv0E4bNa4B++hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dc1Gqlo4+gpQfju3NyQX+F3noi/8oJh4IHNPh1OAva8=;
 b=Ro+wjoCWo+5IIeqwPMSn74w8c0mB4Te3Qnnn36MyKzzGvlSodAtgXIcXrnFqfk0w3tvBCHaA+XvgKPJs95D1Udg4OX6DCRzhiKWhK3uF2zBTG5e8DUJyY/7/t+z1H3iay55xl5sY0QwZH47qxHJ3zN8hrpp355c9978yFElpeA4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SJ1PR12MB6218.namprd12.prod.outlook.com (2603:10b6:a03:457::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 18:00:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::406d:afb5:d2d7:8115%6]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 18:00:49 +0000
Message-ID: <2e82aaf8-c36c-dc3c-8165-f10833bfa8a3@amd.com>
Date: Mon, 22 Aug 2022 14:00:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Use kfd_lock_pdd_by_id helper in more
 places
Content-Language: en-US
To: Daniel Phillips <daniel.phillips@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220822153003.6349-1-daniel.phillips@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220822153003.6349-1-daniel.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0280.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::29) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7724acf9-5562-41f1-3b7c-08da84683f21
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6218:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vxdobM2ptSLF1nZ2gbmhQGfMnS3x68bXXtLYfAtL+J7vD/wBLxqA45CQ0P3X2Yd0FMpzp4v3qcRWO+JwgqJZInp39DcA5wZRFTsy6Uav/yFmwi67OtnQTsvTfmN0wawFdn9wBNZ+OyjnX36HceUpSsGe+xkcGYgPVBxZcH6QrA1B7uwR36L0sLSmpUFhP1aAO2pM62LVIl0HYEDRCPaAIjrOG9usEEq5dcZz27tmIBx9frCRjm49nWNvA8elKVKrdPcAMR7XJNN+IwkKqGMW2wgXZiMxspL81QjD40mAzlBz+iYTjIZUQ4eM3F+Axzc0zIrZmapQG2/UzEepsOQ4mAmHJF6SQ/y60bSPNzXRXvlOgXen+wxJYG0z6sADhWJml0XyIbwc55C8uSIrBwki+Fu8EM7/GFH5VeIQTe8iB+plViihRrPE94kbOLh7wS12RMq0qLOYJ2SySb8cRWZCn0Ir8JwzNiLaJGoJzzT2BkYHKyrrFBFMLHoBUYQAwYycrKbsrJ2xIya/oUjBi3keL3Xs8fM12zQzXG67DL6D6v08nbaJW7ID6c9zn6Spqn5SWvv1o4YZRcBfOizOjAYekh7BZRbknEZ437UoOeAGs8U7LA6p2+6ZT2hsES216/oMlKgwxx4DvJ8H+GnCAdM57Q6bJJwaDqx4c15ekkct3RjiQXkk4nYJPq2RjtATZNG1a0p21gRRmFRJ1PXS0JJ12r4ovTd00NA7pYf1Lb2DOBzJh731e/EIhRiHi/qCeMPBXM9I/nsOBO3wJ/9pwg0BggxLDJwz7ifUEmau55tTikM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(39860400002)(366004)(396003)(136003)(66476007)(66556008)(8676002)(66946007)(86362001)(36756003)(38100700002)(31686004)(31696002)(83380400001)(186003)(6512007)(8936002)(26005)(6506007)(41300700001)(478600001)(6486002)(316002)(2906002)(2616005)(44832011)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RW9XRTJDWlNjOUxlMDFudkhjZzN3dG1WM21ySVU1N05NOWJqWnhEUjdJZjJi?=
 =?utf-8?B?THZnTEtobnM0QlN1SlZvQTNmUDJGYjBBazh0UStIUlBKV1AzWjVpVXl0UENI?=
 =?utf-8?B?RFRFRGZPNExyazJDYncxN0ZpY05FbzZubnBhZ1g1d1pjYlV2WFNQZ0crTHV2?=
 =?utf-8?B?dCtpc0JsNU5XYlE2S2EyN2pCak5VbTdibkN1L2N2OFgvQ3ZELzhFdXBhR3ZL?=
 =?utf-8?B?ZFJWRUcxL0NZQkRjbjhnb0lwRmk2RVBVVnorLzF4eDdtb2ZNR1JmdUs5WkVk?=
 =?utf-8?B?c3dJRDc2aGlNTnFnRTlkT2FYMDE5dzlJK3F6Zi93blE3M0hiWDY5dHFKSWwz?=
 =?utf-8?B?ZzdMOVBvVDhpb1N6bkhsOEUrVTNIc2RWZ000b3dQZ0NqUlA2dDRzT05mUkNI?=
 =?utf-8?B?eEt5VDRNOWo3VW5FVDUzVHpucUtTaG9YY3NyNWpIbXMxWEQxSVo1bGdiZ2Ji?=
 =?utf-8?B?S01tSm9aeFgyU2d2blBUQ1M0RlZ0UGkvVTlYV1ZCaUlYSW1VYWF4cGpBbWp6?=
 =?utf-8?B?UTFWRVFxbU5GY1EwbXMvUzdzbU1ZYXc1Tm9lSG9CRE9LQ3RyOWhxWDhVUnB4?=
 =?utf-8?B?c2xsYlZPZ2xDVTdiRjd1eXhkaDZGMEVycjQ1ZzJ4YmJFalhsZEVhVVhVNE5k?=
 =?utf-8?B?d1RJblhLbXM1YS9RMjdSeHZ5YmpOYnhjS3RxZG9zNnpsV3o2TUd5SEVCS2JM?=
 =?utf-8?B?S0txWEd3ajhvNnlSa2VranZyeHNoNUJtS1I3c0E0TDQ4eEtrMmh4Q2VJVTVP?=
 =?utf-8?B?WFRlSnpEQkNiaER2ZUFNY1BwZXA1cTZxNzN5UHFVQ2lWZnRHN2FNeFM1d3Rx?=
 =?utf-8?B?alhrcTJLcjg4UG4zdUQ4M0x0K0dPdGN6T3VYd2hzNnVSRDdWOUtaWjB6aUxo?=
 =?utf-8?B?U2tLN0pKUTF3L2lNeUJWUTdsS3ZQNkQ2bHp6SWFma0luK2w5Sk0zd084c2pW?=
 =?utf-8?B?NVY5SzJtU2pTNU4xcnRwd2h0bHc2RktVZFVMNGtEcVJqNVFad3c4WCs5Z0V1?=
 =?utf-8?B?bTNMb2w0Vjd0OVp5d0FFZjh6RHRLeUNsQm95K3gzZWdtMTZ5aGJ6Z01VMUJP?=
 =?utf-8?B?K0kzbXZiMllzeTVzVTBVMC9JdnZnQTVqQmZzUDVmRGZkOXhVWks5cTBXMzhJ?=
 =?utf-8?B?SjZBM3JqdkwxTlFmTVozOE5iS1JReUlNT3hRVXk0Rnd6Z0Z6SDNxcDF3b2Fp?=
 =?utf-8?B?bkMzblRGZ1RrNnJTcy8zdnpoOXlFU0VDOGx2WFhzalVpalNZR0RVTVB4RkIx?=
 =?utf-8?B?WmxTY3gwVzFGc2wrUlNRMlRnWGd1NHcxMlZqQnRDWms2dlB1L0ZXc0krRFlo?=
 =?utf-8?B?Y1hpaDFkYjdoTWRUb1JIUG12SzlwVTh1Z1M3dFphZkFLSmlFVXd1TkxlV1U1?=
 =?utf-8?B?KytGa1laM2VEanJpUnZsVzdJK0sweWRCMUVSck5ZRzdZeVJYa2gyb2ZhOVBH?=
 =?utf-8?B?WkY2THphajMwR2E2Q2dYdXFMNmQwUU43REFDanRxUE1uT29GQk0xSXdPUFNU?=
 =?utf-8?B?NHhTTzZTMkxHYks0RFNOcnhyZlR5UFBWMDk5TFVwZXREQnE2ODF5VzJIN3JT?=
 =?utf-8?B?NUdQdzhKTjFGNnE1Q2pvM1dWZWQxS3VhWC8rU0dnTXorbEZXVGI5K1pTVWw4?=
 =?utf-8?B?VWtIWDE4dFk3SGI5QUhob1ZUd2s2c1FFRkR3bDFpeEo1ZzVwcjhjU3U2NGU2?=
 =?utf-8?B?NzYwR1g1L1JjUytzd29uV1AwU0t1TGY5NTdGZGNNR2tZTTNzSmM5WXdKQ210?=
 =?utf-8?B?UkZVUzcybnJJNXBOTGhLeFdTbm5DSUZZVFBKL2dBK0EvQjVRRXhhcUc4TnZT?=
 =?utf-8?B?eFFqR3puTkpWWm9ycUxTQjlzdEVRR1RiZWZRbTJNa054VzVSYVIxQUUza3o4?=
 =?utf-8?B?VGJHc2F6OTUvNjdydytLcTgvcE9NWHd6aG05TVh5M3ZtcGIvYmpEV2szZm93?=
 =?utf-8?B?SG1mWUVnSjE5UEN4Q3ljTys2WVhFcEdHUVdpaTM5dkkxZVNLK3RZRGtmSWlC?=
 =?utf-8?B?M2gvQ1lSZjgzQ2dnVUJFYUFUQnRrbkV5N3VFQkt5MXU3QlFNWHVXOUpKRnY3?=
 =?utf-8?B?VklXV1BUUy8zUTk4czJLb0c0NGw5MWxqeVUwUFF3dHBzbUg1VEhDNG1xTzFN?=
 =?utf-8?Q?iRwupYTRSZLYsKiMkMh4cuKpC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7724acf9-5562-41f1-3b7c-08da84683f21
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2022 18:00:49.8204 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2dnOOiUOvM9bImBZrw/9D98xpHawajSK0ijuezWHVixYIfmPOugD+EvHLFgwtLubpjF4PQe3zdQ0WagdVNI3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6218
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

Am 2022-08-22 um 11:30 schrieb Daniel Phillips:
> Convert most of the "mutex_lock; kfd_process_device_data_by_id" occurrences
> in kfd_chardev to use the kfd_lock_pdd_by_id. These will now consistently
> log debug output if the lookup fails. Sites where kfd_process_device_data_by_id
> is used without locking are not converted for now.
>
> Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>

For consistency, you should also replace mutex_unlock with 
kfd_unlock_pdd in the converted functions.

Regards,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 96 ++++++++----------------
>   1 file changed, 32 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 2b3d8bc8f0aa..bb5528c55b73 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -75,6 +75,7 @@ static inline struct kfd_process_device *kfd_lock_pdd_by_id(struct kfd_process *
>   	if (pdd)
>   		return pdd;
>   
> +	pr_debug("Could not find gpu id 0x%x\n", gpu_id);
>   	mutex_unlock(&p->mutex);
>   	return NULL;
>   }
> @@ -311,14 +312,9 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   
>   	pr_debug("Looking for gpu id 0x%x\n", args->gpu_id);
>   
> -	mutex_lock(&p->mutex);
> -
> -	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
> -		err = -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>   	dev = pdd->dev;
>   
>   	pdd = kfd_bind_process_to_device(dev, p);
> @@ -405,7 +401,6 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
>   		amdgpu_amdkfd_free_gtt_mem(dev->adev, wptr_bo);
>   err_wptr_map_gart:
>   err_bind_process:
> -err_pdd:
>   	mutex_unlock(&p->mutex);
>   	return err;
>   }
> @@ -566,13 +561,9 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
>   		return -EINVAL;
>   	}
>   
> -	mutex_lock(&p->mutex);
> -	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		pr_debug("Could not find gpu id 0x%x\n", args->gpu_id);
> -		err = -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>   
>   	pdd = kfd_bind_process_to_device(pdd->dev, p);
>   	if (IS_ERR(pdd)) {
> @@ -596,7 +587,6 @@ static int kfd_ioctl_set_memory_policy(struct file *filep,
>   		err = -EINVAL;
>   
>   out:
> -err_pdd:
>   	mutex_unlock(&p->mutex);
>   
>   	return err;
> @@ -609,13 +599,9 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
>   	int err = 0;
>   	struct kfd_process_device *pdd;
>   
> -	mutex_lock(&p->mutex);
> -
> -	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		err = -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>   
>   	pdd = kfd_bind_process_to_device(pdd->dev, p);
>   	if (IS_ERR(pdd)) {
> @@ -626,7 +612,6 @@ static int kfd_ioctl_set_trap_handler(struct file *filep,
>   	kfd_process_set_trap_handler(&pdd->qpd, args->tba_addr, args->tma_addr);
>   
>   out:
> -err_pdd:
>   	mutex_unlock(&p->mutex);
>   
>   	return err;
> @@ -663,13 +648,12 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
>   	struct kfd_ioctl_get_clock_counters_args *args = data;
>   	struct kfd_process_device *pdd;
>   
> -	mutex_lock(&p->mutex);
> -	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> -	mutex_unlock(&p->mutex);
> -	if (pdd)
> +	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (pdd) {
> +		mutex_unlock(&p->mutex);
>   		/* Reading GPU clock counter from KGD */
>   		args->gpu_clock_counter = amdgpu_amdkfd_get_gpu_clock_counter(pdd->dev->adev);
> -	else
> +	} else
>   		/* Node without GPU resource */
>   		args->gpu_clock_counter = 0;
>   
> @@ -886,12 +870,9 @@ static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
>   	struct kfd_dev *dev;
>   	long err;
>   
> -	mutex_lock(&p->mutex);
> -	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		err = -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>   	dev = pdd->dev;
>   
>   	pdd = kfd_bind_process_to_device(dev, p);
> @@ -912,7 +893,6 @@ static int kfd_ioctl_set_scratch_backing_va(struct file *filep,
>   	return 0;
>   
>   bind_process_to_device_fail:
> -err_pdd:
>   	mutex_unlock(&p->mutex);
>   	return err;
>   }
> @@ -973,12 +953,9 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
>   	if (!drm_file)
>   		return -EINVAL;
>   
> -	mutex_lock(&p->mutex);
> -	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		ret = -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return -EINVAL;
>   
>   	if (pdd->drm_file) {
>   		ret = pdd->drm_file == drm_file ? 0 : -EBUSY;
> @@ -995,7 +972,6 @@ static int kfd_ioctl_acquire_vm(struct file *filep, struct kfd_process *p,
>   	return 0;
>   
>   err_unlock:
> -err_pdd:
>   err_drm_file:
>   	mutex_unlock(&p->mutex);
>   	fput(drm_file);
> @@ -1063,12 +1039,9 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   	}
>   	mutex_unlock(&p->svms.lock);
>   #endif
> -	mutex_lock(&p->mutex);
> -	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> -	if (!pdd) {
> -		err = -EINVAL;
> -		goto err_pdd;
> -	}
> +	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
> +	if (!pdd)
> +		return EINVAL;
>   
>   	dev = pdd->dev;
>   
> @@ -1140,7 +1113,6 @@ static int kfd_ioctl_alloc_memory_of_gpu(struct file *filep,
>   	amdgpu_amdkfd_gpuvm_free_memory_of_gpu(dev->adev, (struct kgd_mem *)mem,
>   					       pdd->drm_priv, NULL);
>   err_unlock:
> -err_pdd:
>   err_large_bar:
>   	mutex_unlock(&p->mutex);
>   	return err;
> @@ -1231,8 +1203,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   		goto copy_from_user_failed;
>   	}
>   
> -	mutex_lock(&p->mutex);
> -	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
> +	pdd = kfd_lock_pdd_by_id(p, GET_GPU_ID(args->handle));
>   	if (!pdd) {
>   		err = -EINVAL;
>   		goto get_process_device_data_failed;
> @@ -1304,12 +1275,12 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   
>   	return err;
>   
> -get_process_device_data_failed:
>   bind_process_to_device_failed:
>   get_mem_obj_from_handle_failed:
>   map_memory_to_gpu_failed:
>   	mutex_unlock(&p->mutex);
>   copy_from_user_failed:
> +get_process_device_data_failed:
>   sync_memory_failed:
>   	kfree(devices_arr);
>   
> @@ -1347,8 +1318,7 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   		goto copy_from_user_failed;
>   	}
>   
> -	mutex_lock(&p->mutex);
> -	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
> +	pdd = kfd_lock_pdd_by_id(p, GET_GPU_ID(args->handle));
>   	if (!pdd) {
>   		err = -EINVAL;
>   		goto bind_process_to_device_failed;
> @@ -1398,10 +1368,10 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   
>   	return 0;
>   
> -bind_process_to_device_failed:
>   get_mem_obj_from_handle_failed:
>   unmap_memory_from_gpu_failed:
>   	mutex_unlock(&p->mutex);
> +bind_process_to_device_failed:
>   copy_from_user_failed:
>   sync_memory_failed:
>   	kfree(devices_arr);
> @@ -1517,11 +1487,10 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   	if (IS_ERR(dmabuf))
>   		return PTR_ERR(dmabuf);
>   
> -	mutex_lock(&p->mutex);
> -	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
> +	pdd = kfd_lock_pdd_by_id(p, args->gpu_id);
>   	if (!pdd) {
>   		r = -EINVAL;
> -		goto err_unlock;
> +		goto err_pdd;
>   	}
>   
>   	pdd = kfd_bind_process_to_device(pdd->dev, p);
> @@ -1555,6 +1524,7 @@ static int kfd_ioctl_import_dmabuf(struct file *filep,
>   					       pdd->drm_priv, NULL);
>   err_unlock:
>   	mutex_unlock(&p->mutex);
> +err_pdd:
>   	dma_buf_put(dmabuf);
>   	return r;
>   }
> @@ -1566,13 +1536,11 @@ static int kfd_ioctl_smi_events(struct file *filep,
>   	struct kfd_ioctl_smi_events_args *args = data;
>   	struct kfd_process_device *pdd;
>   
> -	mutex_lock(&p->mutex);
> -
> -	pdd = kfd_process_device_data_by_id(p, args->gpuid);
> -	mutex_unlock(&p->mutex);
> +	pdd = kfd_lock_pdd_by_id(p, args->gpuid);
>   	if (!pdd)
>   		return -EINVAL;
>   
> +	mutex_unlock(&p->mutex);
>   	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
>   }
>   
