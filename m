Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B43CD98CC
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 22:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EC1910F1DA;
	Thu, 11 Jun 2026 22:58:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xP9tlh0G";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010018.outbound.protection.outlook.com [52.101.46.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4F9510F1DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 22:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPOCwkwrAuPaJFC8waz0Rd5N53A72if6FrYzwXctfPg2E9f1RjhN0aYWLgR0DI/kUp0/17Od8eIDdKgRu6RHDGXOIhsTFQGMHGlk70BMsvhMS1w6fROSFre8vLsrMVo+AQnNtrTHnm2b9suKoFxTrsH7G4j2JYsPLIh8X7DTbLFRh/8Am3zsib8OH0cdEFt//A91p8Avu75VIL6sRDEnKiVlZQkButsdvwpHQqhiF4qaoMP8KgstSNuQKwz6l+XbH2Ji8GwamZEk+Cot1RyNFbpauyjXPgte9s2VqAW9YRbKtB1uikskMDuLiQb6iVeuiYLZFqNjlpf5bcCEgO+9YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXnv0Ee9f25OxdwlnJFnrmKY+V+w133vC1hXSgAxqFU=;
 b=QHJxeIB/yUtk/FmTmauTHJkcQvCV/ASaOqE0+waiyovpfWJ0y2ySibvCESthBEeDRCo6WSaI2CurmNfpWKBaLfnubLIgQtjmPVkpjT5+dlKUob83ytbBo6xA8xlFyGKJXsGfVK/0+z771TGSMtSuoeO5XT54T/S0oGTRoeHOhk6Ww7pmn5mIk0bbrRwhWIJbSgiPwzzwavIbxqrSGTQH2x5z0E5NDe2ILrR8PL47yZQTlECuqGMuPlX1amKzx6t2h2dP10vu4MANpE2mZ9DM6hA4c2W48IX2/kBq7qXI1YYycwUP12YcXI3lJXjzYocZbcpTaYy00f3DZFn9cw7shQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uXnv0Ee9f25OxdwlnJFnrmKY+V+w133vC1hXSgAxqFU=;
 b=xP9tlh0GxcIyq4n7GK82dsYbzKB0vpWGXs3Nf4fMnddV5i6icB4Nu34HA9zBLA/nxfMPXdbsCIQJnAmdXF38xzZVn3O3PN5jgacjas90iV7fhzRetGkfTCqHw10ciiaeBv7SMeH7VOYvFBcYbID901P9QBxNrumnQT+sQEGTuHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by CH3PR12MB8354.namprd12.prod.outlook.com (2603:10b6:610:12f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 22:58:31 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%5]) with mapi id 15.21.0113.013; Thu, 11 Jun 2026
 22:58:31 +0000
Message-ID: <e3382f7f-dfc9-4215-abcc-98215fe962e2@amd.com>
Date: Thu, 11 Jun 2026 17:58:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdkfd: Use memdup_array_user to copy data
 from/to user space at kfd ioctls
To: amd-gfx@lists.freedesktop.org
References: <20260528184656.123149-1-xiaogang.chen@amd.com>
 <20260528184656.123149-3-xiaogang.chen@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20260528184656.123149-3-xiaogang.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0257.namprd03.prod.outlook.com
 (2603:10b6:610:e5::22) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|CH3PR12MB8354:EE_
X-MS-Office365-Filtering-Correlation-Id: 4425323a-dfd1-49a8-6f9b-08dec80cf52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: yLtiADVDEF9l3awyBUVpHSd0am2gcTHPyMPco2DneEmoU26aotBpDrvE81C7J3W7XXLaLFe7Snn+UpnV0A2A7NETiSVMFgmG6eSB5jFENjZ2+yVg1tyJnyD0YihMx0Ne2qDpQjtQca0mYYl8NodLsjGwnL7tzh/1TSh5xZUdn6+5hW7WQugNHWGQ7/CFbax244Tn/S+vk8/TwjSiav6TloiHJ5fOlzkhRJhC4JQxlSwTxsFciXpkUhemOjye9NoqaqNDsmIZYt6NuFAc2PosUMH5jN8cYDAx7VpUWUVP4lCXxlU80k8Ri1OdTezSe867IfSQhimAHiPOSmHK9VL340hhe7r3M5Pb4msASJqPKiphLtYa+u8Vbjd7y3SymybuB6CDe9aAXDmLEO8+J0KD39OGLGro6EwgYV1EyiX6K7CBtM3Ouv2S38spjK/LCCPxKhv/CAjnd4C0P8vs6zg7hnCIHVIQ2iohTP9DD4Ui1upGL71U+NgGrxWEL1MNEVPQ+7KUCpa8LtFERVS3DUx4AIrnl9VwbqQUVBPFU5rhM7dUlRCZHio5pIVoFYTOQP6Y+iFCxOcxnOtlkfo2YEVtuz+yDvf99NB17xYZuT84bGqasOl1GV5zo2WCf6Y699jciWrqUqFxT4lIjX3HcWmMKct2DH8/Dv98Lvexy7/uBcfFckx9NZMZAlvXo4mVVfUL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aC9OZG9sTDlqYXJrMEg5ZWwzeW94QllTZjNiTFU2VEE0QjN5M1VlZm9FdnhE?=
 =?utf-8?B?eTVJNlFIMjl4RmRBQlYrdnB0YTRZck5pS0FLeFdjL0VBTnZ5UWxMVy9hQTFh?=
 =?utf-8?B?ZXRDQUhxcDJqdEw4SE56S2c5UUFCZDBURGVJcG1QU1Fob0pSeFM4WFFSTlNy?=
 =?utf-8?B?M3lZVXZqbVo3dzdHNXdjQndHYnROS0ZjekJFcVNCbmxOTnUzTGhEWlNKWTJO?=
 =?utf-8?B?ZnN2ZTN6VmlJRWYvYThLOEt1UGlnRDNBZjgyc0hpQnpMS2lLRjd4cy9ueXZv?=
 =?utf-8?B?QUsxblpxQUxibk8yMXhmcGY4alIyaW4rNXJZQThuR0ZKUW1aYmZVcUZMcnBz?=
 =?utf-8?B?RjI2TFV0Vm5RbFdubndKdDAvdVp1T2FvNVcvMDUrUXhwaU53K0tEaWZFbzZU?=
 =?utf-8?B?dkNZMlhnUVdlVkhNckFYQUVkbnhFZDJVZlFSU3FKOStDcmNoaEVNdnl6NXFW?=
 =?utf-8?B?djd3akZSTlo1U1FBZmhTcFlTdkVrY0xIUHpKSWJENzhpZDFXbTREQjNSaktm?=
 =?utf-8?B?WjlPOWJFRzdnUTJzMEUwRDV3M2hOclJ2TWh5UG1CWXBldS8yWmllVUkrTi9B?=
 =?utf-8?B?RWx5ZC96OXNkMEtjM2tYdElVbXppb0tuaFN5NTFxbFFFVWY1eUtCT01SdHJj?=
 =?utf-8?B?VDZ0d09YU0R2TThCQlFUR3BiNGM0eGVrMDI5dnhPNzNFM1hNQU5PZUhWYWti?=
 =?utf-8?B?bzcxMnRJZE5WN0NRUVlzQURvSkFnSG9sanY5WHMzb1pyMEF4UFZLelF1UUcv?=
 =?utf-8?B?T0dBR0lWOFJ0NXQrbVN4dytLdXZJeDVBSzBpcDJSaDZGUmZHVDUzRTFiZG1K?=
 =?utf-8?B?eXpIUjJkRUJpUkRhSHhrVnowbWRqVzIwZEZOMkplcHl2b2JEQi9zc2lGcFJN?=
 =?utf-8?B?cHFVRER6cVVtUlpoQVpFZkNaZzdYU3pwYVBiaVdWSkY1cTJqbnFKRFRJc1NR?=
 =?utf-8?B?UmEyL2NaM0t4SmJKeUREYjRTSlFVL2ZRSElobXMyTzgwTm1Ld0RtYThkL0dh?=
 =?utf-8?B?NzBsa3VtVStwS1pzcFZEa2hUWFlGSmdGTlNGQStYWmtNZU9SSmxIUFhZb1ZF?=
 =?utf-8?B?Y3AxczEzTXRzMkZJQ1ZXYXJXSUJaY2dONm12RXN6MldSRnhxVitqS2NJYkZV?=
 =?utf-8?B?ajNRbWpxSzFpcUk3SXFyVzVGVzVYRnRlY1pzaEppMjlRc2JTZW5rTjNKWnVt?=
 =?utf-8?B?RWNFdUtjS0pnOHZvbjRPakhFNGtJWWUzZlg2ZTdGZmhDSDN4UkV5cUthaWlR?=
 =?utf-8?B?bHJHMDN5djNrRVpZVzNSejI2Y3RaSmdYYUgxcVJKWG4vWncvWnFYM3MvV1ZU?=
 =?utf-8?B?UUFNYkRvbU9nR2N2VTh0RHFIQjNUcVZncmF2MDB3OEY4ZkZJWVR3VnJNN256?=
 =?utf-8?B?NTFuSDNESmxKZGEyNFFaWlhmV0ZNR1ByMWFHWERMSE9FM1FKT0tmZFd4Rk8v?=
 =?utf-8?B?UFdHQzY0MGcydm5VT3JaZTY3azRmbjBKYkhlQkEwWE9qaEhaTFp0clhaMW1G?=
 =?utf-8?B?YS9lOGxvb3FBdXdqYTdHN1h6cHJ0VGtXa1pLbGFFVWQ4ODk0cTl5cXYvQzNz?=
 =?utf-8?B?MW14UkpBaUIrWGpDM3dJQVRvTjljdW1xVy9uai9xSmpzLytEeEtqRmljMzEx?=
 =?utf-8?B?TGxqNzNwWlZqTUFmWnpXMDBxZ2hXd2RUWHNzd0UvNkNNb0VGaTdoTFNpVGNj?=
 =?utf-8?B?cFFMam9wVzJ1SWZXRnRvQnVhaGZYVldwWmJ5L0d5L2ZDMkJMR29IWTM3UVA1?=
 =?utf-8?B?RG5SVzJsR3FTTUprRHdoMGFXK3Mwc1MzYjI1ZVpKcWZmeXU2T3J0MzFiRlRP?=
 =?utf-8?B?SVg4MERMSU9YK2RkVHV6YkN1bEhtbVFzZU5uUjlVdjZFM2JlTnNQcU1aTlRQ?=
 =?utf-8?B?RC8vcmtQbU82blFMdjBOQVh4RlRXN1J3WnBVK1V1ZU93ODRvRHdiTUR5Rmp4?=
 =?utf-8?B?NlY3UENsb1dVSWpJUG54OFF4U2FTTS9paFdpazNFTWJ0OFVOZ1RBV2hGaS9H?=
 =?utf-8?B?Wjk4SVByd2tad20xaC9sdHUxZG5MZVZrZk5EM1U4TERGWVN6WUw5UHAzRFNZ?=
 =?utf-8?B?M1B1WTRwNk9MMHpkL2crNUkzMWIxL3VHY1VkKzFaYW45YmpjMVgvSDZqTGJP?=
 =?utf-8?B?aVlEWmdJbWpTcTVrd1BUbXhtYXNFbHJZS2t4c2JkZVZON3k4NjRlbzhkVTJM?=
 =?utf-8?B?UFJXQy9KMWp4SW9ZdytGL3RnZlZ6d0UvRDBsNzB6dHNzT0pPQU1qSDJKdHFE?=
 =?utf-8?B?QTRUTXFEVGt3MHdWUGVIbFY3SnA2QTJXbjVVT0Z1amJNZDFMNkFrVGs1ZXJX?=
 =?utf-8?Q?h111sxKJOWRXlbJ4Fy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4425323a-dfd1-49a8-6f9b-08dec80cf52a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 22:58:31.3331 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G7eaqHVeokeYkcuTelgr6T/VRms8DaAuqh3lAH9tqiQqhcmoZZjlB0y2yYSgot/7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8354
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

ping

On 5/28/2026 1:46 PM, Xiaogang.Chen wrote:
> From: Xiaogang Chen <xiaogang.chen@amd.com>
>
> Several kfd ioctls need transfer array data from/to user space. Kfd driver
> uses kmalloc_array with user provided size. That can oversize alloc or 32-bit
> wrap with hostile value. Replace it by memdup_array_user that does overflow
> checking and allocates through dedicated slab caches, also physical continuous
> as kmalloc.
>
> Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 46 +++++++-----------------
>   1 file changed, 12 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index fc75d0009a57..bb4581f84f12 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1282,18 +1282,11 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   		return -EINVAL;
>   	}
>   
> -	devices_arr = kmalloc_array(args->n_devices, sizeof(*devices_arr),
> -				    GFP_KERNEL);
> -	if (!devices_arr)
> -		return -ENOMEM;
> +	devices_arr = memdup_array_user((void*)args->device_ids_array_ptr,
> +				       args->n_devices, sizeof(*devices_arr));
>   
> -	err = copy_from_user(devices_arr,
> -			     (void __user *)args->device_ids_array_ptr,
> -			     args->n_devices * sizeof(*devices_arr));
> -	if (err != 0) {
> -		err = -EFAULT;
> -		goto copy_from_user_failed;
> -	}
> +	if (IS_ERR(devices_arr))
> +		return PTR_ERR(devices_arr);
>   
>   	mutex_lock(&p->mutex);
>   	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
> @@ -1374,7 +1367,6 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
>   map_memory_to_gpu_failed:
>   sync_memory_failed:
>   	mutex_unlock(&p->mutex);
> -copy_from_user_failed:
>   	kfree(devices_arr);
>   
>   	return err;
> @@ -1399,18 +1391,11 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   		return -EINVAL;
>   	}
>   
> -	devices_arr = kmalloc_array(args->n_devices, sizeof(*devices_arr),
> -				    GFP_KERNEL);
> -	if (!devices_arr)
> -		return -ENOMEM;
> +	devices_arr = memdup_array_user((void*)args->device_ids_array_ptr,
> +				       args->n_devices, sizeof(*devices_arr));
>   
> -	err = copy_from_user(devices_arr,
> -			     (void __user *)args->device_ids_array_ptr,
> -			     args->n_devices * sizeof(*devices_arr));
> -	if (err != 0) {
> -		err = -EFAULT;
> -		goto copy_from_user_failed;
> -	}
> +	if (IS_ERR(devices_arr))
> +		return PTR_ERR(devices_arr);
>   
>   	mutex_lock(&p->mutex);
>   	pdd = kfd_process_device_data_by_id(p, GET_GPU_ID(args->handle));
> @@ -1476,7 +1461,6 @@ static int kfd_ioctl_unmap_memory_from_gpu(struct file *filep,
>   unmap_memory_from_gpu_failed:
>   sync_memory_failed:
>   	mutex_unlock(&p->mutex);
> -copy_from_user_failed:
>   	kfree(devices_arr);
>   	return err;
>   }
> @@ -2336,17 +2320,11 @@ static int criu_restore_devices(struct kfd_process *p,
>   	if (*priv_offset + (args->num_devices * sizeof(*device_privs)) > max_priv_data_size)
>   		return -EINVAL;
>   
> -	device_buckets = kmalloc_array(args->num_devices, sizeof(*device_buckets), GFP_KERNEL);
> -	if (!device_buckets)
> -		return -ENOMEM;
> +	device_buckets = memdup_array_user((void*)args->devices,
> +				          args->num_devices, sizeof(*device_buckets));
>   
> -	ret = copy_from_user(device_buckets, (void __user *)args->devices,
> -				args->num_devices * sizeof(*device_buckets));
> -	if (ret) {
> -		pr_err("Failed to copy devices buckets from user\n");
> -		ret = -EFAULT;
> -		goto exit;
> -	}
> +	if (IS_ERR(device_buckets))
> +		return PTR_ERR(device_buckets);
>   
>   	for (i = 0; i < args->num_devices; i++) {
>   		struct kfd_node *dev;
