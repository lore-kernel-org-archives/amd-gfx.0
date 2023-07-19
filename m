Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3CF2C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 16:26:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36D8610E4D4;
	Wed, 19 Jul 2023 16:25:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E0A510E0E5
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 16:25:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q8zKLJlxGhDRidYPv4A2Q4ha51xLWbXaHMXgRYBPB0zXxH+gfRXyjCAX4/OjaikhSKmX/+YsHun9xPGpivx8HEYLvDUYNVx/Tx6P3xzbuNIhslJRw8Jm2XMeP1O4Y7yN4WCj5qhgGE8m84IpvjOhZGzGK00cnNUgFFfUIoeKm+UGqftEYa0XG8BumFqrZq1KGd0pbNR0UFPE4oBlrZPFUVMgMHZ/lvnlZXtwN8JlPkUgWXmwFz6yl+3qnRxgxE6V5kzfGcgiTyBFy/ZCKXe3uBZCEpSSyi7dR2mv3ob7JblnJiaecZjbkHvSsLf06RH40RoGCnLT509e/i8I0/L4rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jkFdh5Fyo0TsQtcLlYm/YzLVKGFjkMwNErBHR9bunys=;
 b=jadSTd2VStFZXutbVloysTgi99VIH1aPQaJ2j/7oSalnUDz5oOgHXcjn2AYiuRmgf7Up8bWqwNVDGFnL/wKLT0KJZAjUeOxmSFdH8tkJO3KVDaO+CDwpYYO8spUzOqQiTktovXsfkQLVgKBmKdtgAeW5ZZ0jAR3BY4LtKCY93SKOZPAy21R4//1xvC13ed0JKKpI5H8PsDUeobZSBQOH8iBkHOtvI5NjEBuZEwpAHgbjXiOCaJLqKyBZzwelDBl9sOhGlZ8KuyN8ZrQ78x36hZbC26o8GJsSrqrOTpVg6/vo5E5F6t5dv04BDYfOS3Jb+pN6L4bW+Up3zaCTLfJ5Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jkFdh5Fyo0TsQtcLlYm/YzLVKGFjkMwNErBHR9bunys=;
 b=LDuGCJMMTj50rPjC/tpN1Kf0sqXyHJnusVciN9+k8hRqOU64BI05SJUtMqd0+QFO5ONTfNyeS22sV0zNeRu4+fnvDduXndnh/eKxTA6WWI+5b2CjYpADAWHFqaa3AfOpyD+C/uiEZIs2El38PSa9M9XaNfbWbgAOiWWpOnecwww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SN7PR12MB7345.namprd12.prod.outlook.com (2603:10b6:806:298::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Wed, 19 Jul
 2023 16:25:50 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6609.024; Wed, 19 Jul 2023
 16:25:50 +0000
Message-ID: <2495d0fa-dc5b-7dfa-8fd7-6dd3fd3d3057@amd.com>
Date: Wed, 19 Jul 2023 12:25:47 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amdkfd: enable cooperative groups for gfx11
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230719143609.3352043-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230719143609.3352043-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0164.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SN7PR12MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: e0915680-6605-47da-ff2d-08db8874d083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J7RmMVkYbEe+CF2RG1VwSNVTI06GvZfrZFHgShlJVZ17blM6ALS9pu0MJPao71mtce+lnNnUyqxxlFhd1s/SP1DzS7yLfDcUsrvPS8mbbOJcyjl2qPZRG1rvjBMMWIO2VuO9MVqohwrHSuUPxfC3NxKiJE8hzPKkzeRV5l4QHiaq0kYTzILVKwQ6V11R77+Kq9Ol6JwhMtjHY82Te0CFAaNpvsq7Igsb9aWP6ESRr/V/vbVz+mEx8N2Rv8b7c94IblgwzPA0Tf6oLnV3rXK23KsHPxbYpTwnN1+cqs7DwWo7hRC2uKagqvLLGB9mhyyX0w2Fe8Khrktr3aubirzaQRZvziIXRQr3+Vo/RtLy3sjG/Bzpz96Lm79BR5nZIFOpI7LkMkoiT4w4GxVimbIaXShULdiuMvvyK+tE8PSpJnEnMtzSNRRdS+GunJVUyOEmV8X6jyBpsyMz0Oz1jxEr+7wEH5PYPMK/uVq/3zVoG7MLKTeQBbO5BYvH/j1R8/ZRvZJv9ncNg03jlvv7DS2bT8Civ62MtR63FPO3MWEaHe6DNy9Zjy3chgg2Nr1MTsGl5ai7+8uFjTbxxoumt1kaQwF+luoLX4fijH7S/XRNmgPhkTfHE7VkQF3bBxT0jKEWLhW69cUui03BtGGnHlYB6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(31686004)(66899021)(26005)(6506007)(38100700002)(44832011)(478600001)(31696002)(5660300002)(8676002)(8936002)(66476007)(66556008)(86362001)(66946007)(316002)(6512007)(6486002)(41300700001)(6666004)(2616005)(186003)(36756003)(2906002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SEtqb0RKOTRKWTNGelh1aHF0V0pReDEyRFI5VFp1RUl1ek9OZG5hVmg4WjFx?=
 =?utf-8?B?MmhLUkorSU03R29KSkt2TldoNjhjL3ozNkdLNlE2SFZ3emlwOVBoaERHRGNy?=
 =?utf-8?B?Z0VNZkFlNFBZd01PK3g5TmZCcUorSHQ3RjNvZ3YxbWQrQ3FOZkVoZDNqbkps?=
 =?utf-8?B?VzEzR0hxNVl4QXdNQUVvR1RSUEdJbmNyWitLcngzeStBNHVJRDY1NS9yd01C?=
 =?utf-8?B?OENFRjg1ZlJkK1BVYlpBWmF5WUE0THcwNlJhNHNxeFFWbWtlYTREMUtoY1FF?=
 =?utf-8?B?Nzc2NjBWRHM1WVY3VjYzNnlDY0JMYXBvcjBmcnFDTjB1NXoyUUVEVC9iOFc4?=
 =?utf-8?B?VVM3TjZiN0c5U2cvMmRtRWJINmlKcDBEcWNZdE9Vc0EraVJWK1BScHdZNnFY?=
 =?utf-8?B?L2dUV0NXT1Y3N0RPUzhKZGdtOXJuZHhzbFlCMC9GTUprYXJGN2dYcU1Mb3h4?=
 =?utf-8?B?K0R2N2dQOUJuQVQ5SVZZY1RuS0kyWCtaSldrb296Skw0OHBKZDUxK1o3L0lw?=
 =?utf-8?B?YTVTTnl3eTA2N0hJRzFWYmF6dk80dlNZanErTG92bEYyQmJBaXFRZ1UyYm1M?=
 =?utf-8?B?bHFnQXhMTU16NHh5UW56bUR6M2hmenIrNkcwNDVXQjMzQ1R2blNoakNhZEFT?=
 =?utf-8?B?Nk5QY2lCNHBjVkRLQlRDUnJaSHMwRHdwRlZyaU5zT29XZTdJSHJ1RnJzL2p3?=
 =?utf-8?B?eWhtR3RpTDVWeFBpQ3R2NlU5ZGVlTkoxU2Z2cSs3TExaT0tKOThydFZPNi9I?=
 =?utf-8?B?eDVNbG1CbmY2Q0xCeHF4bHN0YkRRcGlja21YakZKVnpYQklLcG1EbDFha1Jx?=
 =?utf-8?B?VWZPM0Rpd3RuR3J1YXlBNk12SDgxQlFKbUZjUUJOUGdvV29wZmRnd2hKOWN3?=
 =?utf-8?B?YVh4ZDRiVE9Ic1N5aWZxSW4yOFZxOWhqY0lIM2c4ZE1jcDV5UjZUOS9PRmFP?=
 =?utf-8?B?VmdyOEtLT3YzS2hnUTRxU3JvV0VhQ1FmVFdFVnRzSzdJTkdXTjRPdGE3eFJy?=
 =?utf-8?B?SkNYUmI4WWdnT0M2ckNRRXdYUzh3Y0d4Ni9OZFQ3WGcraVNPYVNlNStMMmZm?=
 =?utf-8?B?enNoUURKNVo2TmErUHdVZVZzeG05d2NlSW1URG1XL1BzV1FGdGM5ME4rbFV3?=
 =?utf-8?B?ZnUzV1M3bWFvQ0Z1dEVVeWVoRmtOZmdlWUhnRjBkZTRpeXZCVk1PTVpuR01u?=
 =?utf-8?B?NHJLdHI4RC9hMCtDVE5jby9nbjhtWDJRSkx0T3FmNGtaK001V3FWK3lQcmgz?=
 =?utf-8?B?WmdqRDh0OVRJQllOZDdIZGlWK0JJdUsxTGpjdGRtQ3BSMVhtcGZFRUFtOURX?=
 =?utf-8?B?aVlLSi9INjIxSVU4YlJMU0xrVm55WWF6Z2d1S0JJdkxHcnZ5L2FpQzJOdW9q?=
 =?utf-8?B?TUUydUYyTE1vTkFlSkNlenFFRXBFcUtBVGdHNjdoblduUEwzWUJFQkNibWM1?=
 =?utf-8?B?eTRQQXlGbTVCWHlvTkZzQXVIdVlJbStjSzQzeUFVbWJUL2xnbDlnMlU1R01G?=
 =?utf-8?B?dGxVeUs1N050T3RQaE1hcmRuakxEOEx3Zi9mWE5UVkk0Q0ZuMWRWa0lzVDZM?=
 =?utf-8?B?UFlVRVM4dFNVSmFyeSsrSjRjSDJmYmhIRU5jb0MyUEJTV1dGOFBML2NuaG1S?=
 =?utf-8?B?UTdPN2Nwa2hlUERVaWNBTE5EZzI4Lys0L2NMRUYwZXBZYTlhN3RPTWVoaThr?=
 =?utf-8?B?YklldDhlNFBEbTh2WUY4b2hUam9GRlgwMHY4bDBFczYxbzRiMFF4TmhtRTg3?=
 =?utf-8?B?L3REYU13dDFMTWFKdkF2VUtwRGZ6QlRpTkx4a21OQS9CRCt2eW9Pd2cwNi9v?=
 =?utf-8?B?VkNQRFlrTisyZUZQQXZWQk1DMS9PWGNUaXQ0ZmpLMTFENGU0dXlLY3FWY3ow?=
 =?utf-8?B?ZTg1VGE1V0R1TGRvOU9vOHcwNTlLK01xRktrRU1XTmg2d1hjSUdZVHpMclFv?=
 =?utf-8?B?OGtuNUcxNjE5bXpVRkwreDdsRHVTTzQ0UXhRNUxsVy9JYWxkeTVUeUc3T3U1?=
 =?utf-8?B?d2tXOWpacWdiZjQ5Q2pMZTRDS0Q1N3k1UUlWZU1OdlQ3Tjk0OFVjVnhxRVJJ?=
 =?utf-8?B?RHNxVVhVcVZWdjFYbjllUlZSeU5vcXRVMG9xd3R1MjZGQ2poMktOVGJKTHli?=
 =?utf-8?Q?x1JzEIpSiGUp/Jtsz2EYz98uB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0915680-6605-47da-ff2d-08db8874d083
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 16:25:50.0379 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: elsU86K+UlzSpB11hP00G7rGB2MZ75+AGaFK+kXs7ixd3qf7t+rHEG5KNu41OhPn6y4La0fSiaBfvXFtjk64Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7345
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

Am 2023-07-19 um 10:36 schrieb Jonathan Kim:
> MES can concurrently schedule queues on the device that require
> exclusive device access if marked exclusively_scheduled without the
> requirement of GWS.  Similar to the F32 HWS, MES will manage
> quality of service for these queues.
> Use this for cooperative groups since cooperative groups are device
> occupancy limited.
>
> Since some GFX11 devices can only be debugged with partial CUs, do not
> allow the debugging of cooperative groups on these devices as the CU
> occupancy limit will change on attach.
>
> In addition, zero initialize the MES add queue submission vector for MES
> initialization tests as we do not want these to be cooperative
> dispatches.
>
> v2: fix up indentation and comments.
> remove unnecessary perf warning on oversubscription.
> change 0 init to 0 memset to deal with padding.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Sorry. More indentation nit-picks inline. With those fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c              |  2 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h              |  1 +
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c               |  2 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_chardev.c             |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c               |  3 ++-
>   drivers/gpu/drm/amd/amdkfd/kfd_device.c              |  6 +++++-
>   .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    |  7 ++-----
>   .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   | 12 ++++++++----
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h        |  4 +++-
>   9 files changed, 27 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index f808841310fd..72ab6a838bb6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -642,6 +642,8 @@ int amdgpu_mes_add_hw_queue(struct amdgpu_device *adev, int gang_id,
>   	unsigned long flags;
>   	int r;
>   
> +	memset(&queue_input, 0, sizeof(struct mes_add_queue_input));
> +
>   	/* allocate the mes queue buffer */
>   	queue = kzalloc(sizeof(struct amdgpu_mes_queue), GFP_KERNEL);
>   	if (!queue) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index 2d6ac30b7135..2053954a235c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -224,6 +224,7 @@ struct mes_add_queue_input {
>   	uint32_t	is_kfd_process;
>   	uint32_t	is_aql_queue;
>   	uint32_t	queue_size;
> +	uint32_t	exclusively_scheduled;
>   };
>   
>   struct mes_remove_queue_input {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index 1bdaa00c0b46..8e67e965f7ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -214,6 +214,8 @@ static int mes_v11_0_add_hw_queue(struct amdgpu_mes *mes,
>   	mes_add_queue_pkt.is_aql_queue = input->is_aql_queue;
>   	mes_add_queue_pkt.gds_size = input->queue_size;
>   
> +	mes_add_queue_pkt.exclusively_scheduled = input->exclusively_scheduled;
> +
>   	return mes_v11_0_submit_pkt_and_poll_completion(mes,
>   			&mes_add_queue_pkt, sizeof(mes_add_queue_pkt),
>   			offsetof(union MESAPI__ADD_QUEUE, api_status));
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> index 40ac093b5035..e0f9cf6dd8fd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
> @@ -1487,7 +1487,8 @@ static int kfd_ioctl_alloc_queue_gws(struct file *filep,
>   		goto out_unlock;
>   	}
>   
> -	if (!kfd_dbg_has_gws_support(dev) && p->debug_trap_enabled) {
> +	if (p->debug_trap_enabled && (!kfd_dbg_has_gws_support(dev) ||
> +				      kfd_dbg_has_cwsr_workaround(dev))) {
>   		retval = -EBUSY;
>   		goto out_unlock;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index ccfc81f085ce..1f82caea59ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -753,7 +753,8 @@ int kfd_dbg_trap_enable(struct kfd_process *target, uint32_t fd,
>   		if (!KFD_IS_SOC15(pdd->dev))
>   			return -ENODEV;
>   
> -		if (!kfd_dbg_has_gws_support(pdd->dev) && pdd->qpd.num_gws)
> +		if (pdd->qpd.num_gws && (!kfd_dbg_has_gws_support(pdd->dev) ||
> +					 kfd_dbg_has_cwsr_workaround(pdd->dev)))
>   			return -EBUSY;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0b3dc754e06b..ebc9674d3ce1 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -508,6 +508,7 @@ static int kfd_gws_init(struct kfd_node *node)
>   {
>   	int ret = 0;
>   	struct kfd_dev *kfd = node->kfd;
> +	uint32_t mes_rev = node->adev->mes.sched_version & AMDGPU_MES_VERSION_MASK;
>   
>   	if (node->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS)
>   		return 0;
> @@ -524,7 +525,10 @@ static int kfd_gws_init(struct kfd_node *node)
>   		(KFD_GC_VERSION(node) == IP_VERSION(9, 4, 3)) ||
>   		(KFD_GC_VERSION(node) >= IP_VERSION(10, 3, 0)
>   			&& KFD_GC_VERSION(node) < IP_VERSION(11, 0, 0)
> -			&& kfd->mec2_fw_version >= 0x6b))))
> +			&& kfd->mec2_fw_version >= 0x6b) ||
> +		(KFD_GC_VERSION(node) >= IP_VERSION(11, 0, 0)
> +			&& KFD_GC_VERSION(node) < IP_VERSION(12, 0, 0)
> +			&& mes_rev >= 68))))
>   		ret = amdgpu_amdkfd_alloc_gws(node->adev,
>   				node->adev->gds.gws_size, &node->gws);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 761963ad6154..71b7f16c0173 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -237,10 +237,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	}
>   	queue_input.queue_type = (uint32_t)queue_type;
>   
> -	if (q->gws) {
> -		queue_input.gws_base = 0;
> -		queue_input.gws_size = qpd->num_gws;
> -	}
> +	queue_input.exclusively_scheduled = q->properties.is_gws;
>   
>   	amdgpu_mes_lock(&adev->mes);
>   	r = adev->mes.funcs->add_hw_queue(&adev->mes, &queue_input);
> @@ -250,7 +247,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   			q->properties.doorbell_off);
>   		pr_err("MES might be in unrecoverable state, issue a GPU reset\n");
>   		kfd_hws_hang(dqm);
> -}
> +	}
>   
>   	return r;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index ba9d69054119..e8ee52d70a19 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -123,7 +123,7 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   	if (!gws && pdd->qpd.num_gws == 0)
>   		return -EINVAL;
>   
> -	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3)) {
> +	if (KFD_GC_VERSION(dev) != IP_VERSION(9, 4, 3) && !dev->kfd->shared_resources.enable_mes) {
>   		if (gws)
>   			ret = amdgpu_amdkfd_add_gws_to_process(pdd->process->kgd_process_info,
>   				gws, &mem);
> @@ -136,7 +136,9 @@ int pqm_set_gws(struct process_queue_manager *pqm, unsigned int qid,
>   	} else {
>   		/*
>   		 * Intentionally set GWS to a non-NULL value
> -		 * for GFX 9.4.3.
> +		 * for devices that do not use GWS for global wave
> +		 * synchronization but require the formality
> +		 * of setting GWS for cooperative groups.
>   		 */
>   		pqn->q->gws = gws ? ERR_PTR(-ENOMEM) : NULL;
>   	}
> @@ -173,7 +175,8 @@ void pqm_uninit(struct process_queue_manager *pqm)
>   
>   	list_for_each_entry_safe(pqn, next, &pqm->queues, process_queue_list) {
>   		if (pqn->q && pqn->q->gws &&
> -		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
> +				KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> +					!pqn->q->device->kfd->shared_resources.enable_mes)

This still looks wrong. You have pieces of the same condition indented 3 
different ways here. I'd prefer to see this (and hoping Thunderbird 
won't mess it up):

  		if (pqn->q && pqn->q->gws &&
		    KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
		    !pqn->q->device->kfd->shared_resources.enable_mes)

Everything indented to line up just behind the open ( on the first line.


>   			amdgpu_amdkfd_remove_gws_from_process(pqm->process->kgd_process_info,
>   				pqn->q->gws);
>   		kfd_procfs_del_queue(pqn->q);
> @@ -455,7 +458,8 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
>   		}
>   
>   		if (pqn->q->gws) {
> -			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3))
> +			if (KFD_GC_VERSION(pqn->q->device) != IP_VERSION(9, 4, 3) &&
> +						!dev->kfd->shared_resources.enable_mes)

Same as above.

Thanks,
   Felix


>   				amdgpu_amdkfd_remove_gws_from_process(
>   						pqm->process->kgd_process_info,
>   						pqn->q->gws);
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index 0997e999416a..b1db2b190187 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -275,7 +275,9 @@ union MESAPI__ADD_QUEUE {
>   			uint32_t trap_en		: 1;
>   			uint32_t is_aql_queue		: 1;
>   			uint32_t skip_process_ctx_clear : 1;
> -			uint32_t reserved		: 19;
> +			uint32_t map_legacy_kq		: 1;
> +			uint32_t exclusively_scheduled	: 1;
> +			uint32_t reserved		: 17;
>   		};
>   		struct MES_API_STATUS		api_status;
>   		uint64_t                        tma_addr;
