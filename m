Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1666AC7EE2C
	for <amd-gfx@archiver.kernel.org>; Tue, 30 May 2023 15:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2526890FE;
	Tue, 30 May 2023 15:08:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B9DD10E3A4
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 May 2023 15:08:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DQHnHGOvybImX9KaWfosfY0CzUNUXvejh45T89kdvZiSZmNFH/f5raq+l8QOBDVmc9vh8bmlriOkYfcYxVbt2+2a7MAeuBiSPMEoHA5+AxEjmRRXhggFgi6pYSzNwdk4mJihB2x4m3uDowIWQ7Z34raNEOuLpi7HpOfDlB8lnIVto2Ik7G6EsiqQhPh8sG0ZONh9zPkKYPon8I1CNxWC1PIXrgx0Mjso6fixFJX7CWSXWyyh3tynZ8M9ischUGx9LSFt/Zbc9FQ28zHhGw12O2cFLi+vT4B3nc7Fvbfto4vQh7aWDnNH9N66WnwfXK1j5ZZDcHlo6nGlDqqXOT1ojA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+ejXVvCH+X3FFE05ahN1PzwzFqOocTR7/rVvFvrf7w=;
 b=hpcHc++45gcQYYt3362FLVCHjkMMuZrGAq7E7mTY4rRMmhJS7/F636AL0ttEVfR95p1BLQN4dgyO3c3CU/Zvco0C2kqrKNZ7WP+WpV16yGRpL73kfdkt0Jnd+FrOJcEaaQZA6LqWFTFJEVzqhKZGqRfuADwG+v9nlBskBHWwfjiImgxl+sq6877+ACFr8AHlPVauXH2HfqNu9o1k+das0Yh+ekNoOepNmn9epgmYwIIC3kAm4RUR2UuBiFLzLbVFpAxg40F6UG68pxRMDLH8fye5eNZQEGQBuzqBrYXGDfeguyjgg265MyW9+QuwwXbKI+GRRv4Ib49c+FJurSV/MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+ejXVvCH+X3FFE05ahN1PzwzFqOocTR7/rVvFvrf7w=;
 b=ogsaWRV1bz8tmuxRVFLzOB9NLfckSTVHd5nhZSX8g51MJ9ACEW++II+1vKt1ymcFVue/HOhUKnzJwCt44F6L0EFq3Jr/5MS0xRr81XiajkGesi6ml6OGAIHEe9Gb6KWTmzY/ZLR7VlPG9nf1WKYibN7WByOAhup4JsBtMAdCezg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Tue, 30 May
 2023 15:08:21 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::943e:32fb:5204:a343%3]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 15:08:21 +0000
Message-ID: <fe5c55a5-a800-86d5-990a-619879b63510@amd.com>
Date: Tue, 30 May 2023 11:08:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: Fix up missing kdoc parameter 'inst' in
 get_wave_count() & kgd_gfx_v9_get_cu_occupancy()
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20230530124817.2753759-1-srinivasan.shanmugam@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230530124817.2753759-1-srinivasan.shanmugam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0103.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::28) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: b5aec506-ff06-4a98-5247-08db611fb530
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nXaOlOUX3jFH61NvgN1/+mKHv6Yrjypp6XrFRszmtV7i8pXLWq9kEvlhygSVR72ihvdXTlljN0gA5THZEWlNwmL7LPc+r0h9RhUphwan2/F3ck+xc6FWQS78QopxNV3/84rV5wP23t09sN8XsAQXgg9N+TD81AZyjXF1oP0DDcIs8nDOrc8OCLzS78DeoGxQY4q48TUDQRSuHkml/8yX2GhNTbOLOIOvBgWwAmVRqM7gz+6U6Mna3Xslg6om/BVrqk+SN7Zp8a9WwREGpBhMevVQl17tnUYEM8j9TL7RKDsbW6DwS+HRBcBf37LTWXZckJ9NYvjhZyss9h82Tn+RyapywzApLcuXs8MOumGVExLd98vt7M/gw0CL+u+Qbn2E6zpe9wZweKOrKo1t+u2DIyznmFg1VGgTHAIBj/W1yE/b2bXhq3hMcYfqmpZUI6A0STt/Sazqu2VyR7osJNCKoDaw/18C9MpRkBHj9FooIELkmiHNuyHxVbuTm/qUmMWgLn2EVlJ0Zzw9cYSmyMOEAVDm0kSWNageW+onw1mGXg+vP6yj49ccoxmB19xZ+FtXBVHlAkJndB+XilgkoN76ae4iMZcxgWUDGFnvRw4zX81jGxTEmwawUA3cW1zgMfLJ/0+YEbwkvPP3vfyKqekzqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(478600001)(110136005)(8676002)(8936002)(44832011)(5660300002)(36756003)(31696002)(2906002)(86362001)(66476007)(4326008)(6636002)(66556008)(66946007)(316002)(38100700002)(41300700001)(2616005)(186003)(6506007)(26005)(6512007)(6486002)(66574015)(83380400001)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnVTcTdpNExsMTlMYVltK1Mvai9RUlhwTDJhbVhCdFlqVjlZWFVzMTFSd05T?=
 =?utf-8?B?MTVReFM5RDM2bGxDZnBHY1pSTVNkNjMzalROSzcyTzB0QmhScDZ6Si9kRlht?=
 =?utf-8?B?bkQ1d3JDM2d4WC9DZERUZDJTWU1PUTdRV1FmQkRidUNEbGQxS1E4TFlHWm0w?=
 =?utf-8?B?WDRYWVVPY2dNN25pc01qbWJVVnRmMjZ3VTAwTndDYk9NNjB0NEswWE1OMFlm?=
 =?utf-8?B?ZEZwZzBDR0ZCcEtHYktvR0FnM0piSmJlNFJZL1crbzF0a3JONjdYdGJyUm9F?=
 =?utf-8?B?U3J6M0RzQy9wWVZGZXFUNTVhWWk2ZWtrQjREaVhZdkFya01pUzRxY1BkdlFF?=
 =?utf-8?B?U21haGdadjMxQ3Z2eEI1NFU4M3ZMQ2o4Y1hmVHRPT3ZrZDlhaU41QmZFUXB3?=
 =?utf-8?B?Lzd2WnJKV1p2dm9PN01tY0EzaVowMEwrQW1DNlBLbXdGNVRvQnRERDhaaWdn?=
 =?utf-8?B?SnJHQW1HQ0hrTDc4V2M4bUV3Z1BGUXVIMW9xSVVwWUFpT0xETnNaV0hGWGFs?=
 =?utf-8?B?c2lKNGdSZVJYU24waWZGWlJGVnJPQmgvQ3E1T2ZSOERtMzJiM1RWcTBqSTBX?=
 =?utf-8?B?OFlzL20wUkxXMnQvSUl0R2ZwdkNzYXhHQTZ4TStwZjh4TGl4Z3kwSWFmaTdq?=
 =?utf-8?B?L3JwWUMydEo1eVRVeTNLTGpLZmpJMFVaeG43WUVCOXFUanE2alB3Q2QxZ3dC?=
 =?utf-8?B?aGl0bmhnZklFSWVyZ1JReExGMDIxWHJYc3hVTHZiczljWHdPN2ZsT1ZBRCtP?=
 =?utf-8?B?OGMzV2UrT2t1djFzOGxKRXpDcDlqbVh1YkI3RG5YZTVzMTFQeVVJNm5UQWhO?=
 =?utf-8?B?alNZVzVIM3NJWjVwcW5LYW1BMFViYU1GYVllaW9ndzNZV0gvRlBmVDQ3WTZ3?=
 =?utf-8?B?ekF2ak1hK3pNMkFqWXlFajEwRmp6TEpDZnJtSy9KbmNJM0o0dFk1b2kveVlI?=
 =?utf-8?B?REZ5ZlJBZSsyMVVib3NqK256SGVnbXhtU2tFSk5kdWNhblJOOGpKT0JScWNl?=
 =?utf-8?B?ZmRtajRkV3h1NzB4anJMdHlieWtmbmlmaGw1QlUrc2FKR3RmTHFwaHdRTFNN?=
 =?utf-8?B?ditlbm1PaVl2ZkVEdWJrdnpYU2d0RldHU0J2UmhPTmFsR1BZUkg3WERscU8v?=
 =?utf-8?B?SXI4bU02RlpoMFgvdkMwU2tRckhEZFY3NmREbmgrRDd5NFU3NjBWUjY5YkFs?=
 =?utf-8?B?VUIzR29MUHJZSUpHbVk2MU1vL0JhZ2VXVlR2aHZyNksvMGxIZ010VVFuWUtI?=
 =?utf-8?B?Z0I4a1Q3Q2h0bVRNQzhzODZkTFJEbUxFYmE3S2kwRGdCRzRqVVQ0OWJNdy8v?=
 =?utf-8?B?cWR6Z1pVeE1ibWN6WmsyMlh4ZjRJZS9oZUpvYlVRU3Q2NlBTS1dxRWkxZTJM?=
 =?utf-8?B?UFhmVml4T1puWTZZSG1WL2N0MzUrcWlFS3dRQlBRSkhGSFhxWXJYRndQdXoz?=
 =?utf-8?B?bTRCWnRFTmdCSUpUVERCTDUybFcvRE5sNXNZcVpTQXFaV1F0WjZqbGVaV0hm?=
 =?utf-8?B?Q3pIcFFaV001Z2l2TFhCK3dOS0RBUWhBd0VyN3JzWWRVMTdXN0E2R1ZpM2lU?=
 =?utf-8?B?UjVnaU1NK2NxdjNIdkxXYUZIb2I3UEhxcWlXZXdGYlVPTnFiNDB3bGg0c0k0?=
 =?utf-8?B?dDFsWlFCR1dQTGtJYjcvazNMNTlMN2d5MXdabGFyemdpL2krSGVSNCsrWGNO?=
 =?utf-8?B?aGxOT0pvUUNINlorWVl1UzV4TmJvTCt4ZWdqUHQ1alhBK0dyaTJ0U1FnSVJo?=
 =?utf-8?B?UXFuU1FnRzZhWVlKT05DMlBPb1I5bWJlZ1dHcDd6NjdDT01yNkpVNmlVWVMz?=
 =?utf-8?B?Tys5VjllYzliU2NoN1VJdStUL1p1OHlFZUVFd1NkT1dINGExVDNwQXVPT0c1?=
 =?utf-8?B?VTFwbi9kbFhYNFBhZEpwQUFCYngyUEdJYUxBZXhrSi8zbG1Md2g3aGQ2bVJp?=
 =?utf-8?B?Z0ZSOXFwZUdtQ0gxVHJKWHNBWXk4dnQySzRIZXdmbU9DeHM0SXk2UU9tM09B?=
 =?utf-8?B?V3FsblRURzd6b2lPNlhTTEk4SG5scDIrRGhVbXF3UVpPMXNwMlZQcnBKaWJx?=
 =?utf-8?B?RCtWOUwxTXNXTUVKMGFwOE1rcGx0TTA4ZHFpalk1QkpVT1ZZbEtRbEJ1M3Vk?=
 =?utf-8?Q?foTLVggLxOXIbqxAHl6cFq8CQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5aec506-ff06-4a98-5247-08db611fb530
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 15:08:21.6172 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MKV4RfzDrE6blgMfxH9v+Bd+j1G5II46Z3qnchXMe62e7QM6mNp5cpqn+2TlIqtUJcpX+iQFqLJLojPuhn3szw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-05-30 um 08:48 schrieb Srinivasan Shanmugam:
> Fix these warnings by adding 'inst' arguments to kdocs.
>
> gcc with W=1
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:692: warning: Function parameter or member 'inst' not described in 'get_wave_count'
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c:763: warning: Function parameter or member 'inst' not described in 'kgd_gfx_v9_get_cu_occupancy'
>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 9fa9aab22fe9..34bf030f3137 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -685,7 +685,8 @@ static void unlock_spi_csq_mutexes(struct amdgpu_device *adev)
>    * @queue_idx: Index of queue in the queue-map bit-field
>    * @wave_cnt: Output parameter updated with number of waves in flight
>    * @vmid: Output parameter updated with VMID of queue whose wave count
> - * is being collected
> + *        is being collected
> + * @inst: xcc's instance number on a multi-XCC setup
>    */
>   static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
>   		int *wave_cnt, int *vmid, uint32_t inst)
> @@ -721,9 +722,10 @@ static void get_wave_count(struct amdgpu_device *adev, int queue_idx,
>    * @adev: Handle of device from which to get number of waves in flight
>    * @pasid: Identifies the process for which this query call is invoked
>    * @pasid_wave_cnt: Output parameter updated with number of waves in flight that
> - * belong to process with given pasid
> + *                  belong to process with given pasid
>    * @max_waves_per_cu: Output parameter updated with maximum number of waves
> - * possible per Compute Unit
> + *                    possible per Compute Unit
> + * @inst: xcc's instance number on a multi-XCC setup
>    *
>    * Note: It's possible that the device has too many queues (oversubscription)
>    * in which case a VMID could be remapped to a different PASID. This could lead
