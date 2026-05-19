Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99821CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 14:06:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3624A10E113;
	Tue, 19 May 2026 14:06:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2qr20l31";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011019.outbound.protection.outlook.com [40.107.208.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC92410E113
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 14:06:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oc5XYQ88Iq1jwxiuTWmyxZTJkqz/crg7MJadZWYxqf+NCebBaSz3Kl+qucgHNqSlY8gSXkSMZdHEaSdvJX07qL01wYeI+d6MP6OFoZODQ9ZDulwCaU+Qr5i8e1l9QfVcP6f6xAXHlI6sh0a07TWpPUdNiuXczttd5jJUbdP7lWEEQzaVwifWnYCPLhWh4HoMbr3nnuNyPTq0+hrknjvR861bmUxBUOMdudzq5LXp8/lyO4kh0FYgeIW1NlfuD50sQq9yj2avkVI+2vmjqHcXO0+d2RkdnDyWvIb6/TtUWgEgDcS9ScJuukEbR9rQe8nCqKeU9nCyNlMgTBj2LFa3xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a3I6Wek1vCZPKXgz1DgdZDW04WeC/9RA4ujsYkRcgao=;
 b=KOCGVGHS96ftRjXKOc6H+aFuSMqnJr3i/rG8anulqaTI9lNYcB/CvOnW6xKNHtiYUBmdaTXt028OIQ52VC2K8InpyIPZ+KEewh9HtfuGlgJF/cYx5evK5457cMcQTBHwVfLEQShFtqXNOP23nepbnXbLhemzfR3j4OOEnVX2hmWQsJ/C6mvApzTygRhz2iGtzM4sRwnaFCMiHo2hSSzXYEGa3x/tjB0cF71TWgt6S45/bAg2+tBmR3FM4ASJmGGAHxsxlT43i0qF1kihouia8B8vp1w4DaDycpHZNMSovSo4r4GTQq9WBggieKUcQ6CrIQEvh4CP+2ngfSqkPhNcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a3I6Wek1vCZPKXgz1DgdZDW04WeC/9RA4ujsYkRcgao=;
 b=2qr20l31yrNwZd4VtbucxC5OOAy+2BFREk331a687/EisWym/hBh8RkxTPlEh2lk4qzctjHdifclnGikkmnU9EVxs20vPzbd4D6CEc9zRygc/lmcv6kAOuByVJgP1zQHWXGsimrSMIsYC5DBv7TaSywMC9KtsART9zoM5vPThbk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB7590.namprd12.prod.outlook.com (2603:10b6:208:42a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 14:06:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 14:06:22 +0000
Message-ID: <1554081e-6322-49f8-8b17-381877ba9082@amd.com>
Date: Tue, 19 May 2026 16:06:19 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] drm/amdgpu/userq: user array to store userq vas
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-8-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519111801.1435954-8-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0450.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB7590:EE_
X-MS-Office365-Filtering-Correlation-Id: 5205d6e8-e16a-413f-7bc5-08deb5afceaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: Who+prNjoWNh4DIsa881bfhjmzYFx0ddLQMOqHowkg2mz30M2B/AKEy9NIbFwcD7PffupAciOOG+1fcGEv5k88jh5oWNo8NZZemmrr4OkXpAVoG4OhKi/SpJChIVrxWWRKuo6BBQ6WV71+JMLUykUTiaWoK1LWuUOic3ZY2RIm3n6rQfnATCKehNd3q5JNoKp6uv9doME5psw7PPkAl4akoK33ZWMK1d18nY5lcCY55NS0g/fHLSSV464kFTneX5ORY44Lc62hwrGiBUIeu/8Cgv05Rum//5fMpQ675MFksKh9njU/mu5JV+t7QMOYe6GAziYXvd9H3mnxsoP16C7TTpFanphjEYZ5pbIK5hT9MuPJYEtunoSJo+cfWiuiMYCgDxm2QKDl55kLJwn6C3mIWfFQH94Ab//DGqfUU2MwXTRK2j6z7h1e0CAfxFiWjcZi3p/YEc/M1a5cmaiyQv8RKr6ZvK0dTo7s/YAg3Ya017KdW/Sp9Joly5yXwX0D4b8c9fg0I6ibEUvfHVLssJVbXmXGqHobHzkSL/ctHzp080eDIkPPpD+UzOiP7jNfNbOtM/xlC6HBT/DVgDrSRh6RXWrsdEjd0KA6k4puJErhM6YzAcRvsc12rxyecpVtDzfGNym6KW29pSImYCFu/kMuNz5i62fb/V8iXRbDTF4B817goBov38sIufF+ugXRJF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHFMK3oxTGhNUTRoWDd5VHFzbkRDNVVIV3prRmlmZ1lSQlpIZ1l0am10VUJM?=
 =?utf-8?B?Y00ybVV0ZTNYTDIrRllHekFvWkM4ZjN1NVp4SjQ0NUplVU9rdWl3amlJODBV?=
 =?utf-8?B?SWxvY1NtRCtDclpsL3ZjaFVLSnNyQmI0cHg3Zi9vOUJTRUw1RldmdklsMHRC?=
 =?utf-8?B?RHhtZTMreDI3MEpNZVA1a2RiRGVTZWZUYmswR1NTT3dCbE53MU51bnhzcExZ?=
 =?utf-8?B?Nmc2WDI3dnJlZktzeVdiNy9rK1FoWVd1Q0htcmVpa3M3eW9KbWRzdStibkFn?=
 =?utf-8?B?cXc1aFNpeUd3VGRDaFFrMmxaalBSRW96a0VFMngyOExsZjFFaUhEZmJvdUdm?=
 =?utf-8?B?NEhKZVBTMkltN0V1cnlMQVFvVmVHVDJhOGtLbVBSSThRZisrZ0tteGFWQlg5?=
 =?utf-8?B?aUs5czg2bVhsWWJKd2JKN2phdlVuVTlWWGQyYUlvclNERERQZUFIWG4xOGFs?=
 =?utf-8?B?d3RtZEtybWR6ekEwTzh4Vjg2c3VvODRnbTlNRWRVS2g1N1hwanJ0VTB6TW9v?=
 =?utf-8?B?WVpvbFpGT0M2c3RlcGJKQ09rak55LzZZelczMzhIZ0NhdlhQdzNHZlhRS09N?=
 =?utf-8?B?a2V6R0Jsc3lpbm9GLzBEcTZrc3dkcElzOXcrNWpLYkhmQXlWYnd2QUorc2pa?=
 =?utf-8?B?dFUwTU9XdFFxWmN4Nks3dmlDR0hTMS9zWldINWdwUTdqUC9RTzdDK2VsSTQ2?=
 =?utf-8?B?bjR5NmhOYWYxN2creURCOTVFNGRTRk9ydkJrenlZQnVLaVZKRFpWUEJrZDhS?=
 =?utf-8?B?eXZlNlFrbm1nQUVqNGNLcUZPWTFjdEZ2dnJPT1UvTCs0b2h3YlpNcSs1SHJ0?=
 =?utf-8?B?TzV6TVE5ZkZyOEtydUEvVlFiVElBNklvVlhuWU9xTjZyS3RrUGpmWWV5bEUz?=
 =?utf-8?B?U0p0OEwwbFY0L3BNUGFJbDlIVVdoc2FHaERIbFFXY2JFQlk5SGZIRytnR0hw?=
 =?utf-8?B?cU9wNVJSU2JKSVN4RWlOeEdwVXExdW5La2t0a1V4OW40RHJOd2kvSlVXR1NQ?=
 =?utf-8?B?THRCa3JSZ00rdHB6cGNSOStzODQybmRGTmdTYnNmL255UkZMbWRyL2ZZaCth?=
 =?utf-8?B?K0ZFS2VWVVkrTmhVMzcraTJOQ0xNWm9uWHZMNmRIeFZSVzRDeFloZkRyQWNL?=
 =?utf-8?B?ZkxSQkVGenJmZkdJMzVRQmdpb2tnK1ZSbmV1WVlDM2lQMktYTUpsNTYzMjdh?=
 =?utf-8?B?UG9EdTEzWm41NTI5ZC9tZjlIWTRrTTNUUllhOE9oUThEQ2NUL1BqdTJMWjd6?=
 =?utf-8?B?R2o1dXNnZWlrQ0RDbTBmRllUd2tTb2RaM1l3aGZIRzVDRVloOVpMOWFVTGM5?=
 =?utf-8?B?czg4WEo3WVZnR3FXUGdjUUVNN1gzWHpGY1djZm1kcnhRMFRYcHpUTWFUNzZo?=
 =?utf-8?B?Wk96VkgxY3ViaUpuVEJudTlXZ0hVOVFWcXVDUHBPYWg0SFhjN0NwT1RlL2wy?=
 =?utf-8?B?bEhyd2xNVHZTVTdNMDhPelA4dnNtUUlEYmpGZjVsN2NpNjAwemg3R3hTNm91?=
 =?utf-8?B?dlJGQ2dIaGE3Y21RL3BMV1pHaHpUUVRkVHR2ckVVS0VjSlVTemJ5TXRSUlRw?=
 =?utf-8?B?b0Qya0NNdHlsNFp0RmtHSGpSb2JVbEo1SFRGQUxIS2QzL3F0U1hxdzdwSjVk?=
 =?utf-8?B?czlSbmhNTjR5Q2t4SFB4dEhaZktPcFQwaHFXSGVSb2hqL1NWRWQ4b1owSDZY?=
 =?utf-8?B?UG91Rk9nQzZ4ZGlNTVJIQUxYSUJ5QUIrVzVxM3I0bDhjM1Z3bmpFMkVRZ0J3?=
 =?utf-8?B?S0RHb0VZMjVmbm52dElzU1hPazE2cjVubTFhWjd6RGpzOVNmWVdzVG4rNk0r?=
 =?utf-8?B?UVphVU9hMDRuVStYak9qMkhCRk1lVzdLZDZtVHg0RXBtSkR4WldHL296WGJB?=
 =?utf-8?B?YzFGZGt4MytMSlJQTzl5SGxnREhQRU9tdVp0VUE5TE1wV1JTVitpNlhLc1p6?=
 =?utf-8?B?cklFMmkxSXRwVnhmRXVjNkdJdFdJS052MlViZUQ1NHhrTCtGRGllcllZSEVj?=
 =?utf-8?B?ZFJtV3A3MElycmxYL0xrdXViNkkwQkw1ZFAxNFNMbkpIK0RsNWRsOCtvSUNs?=
 =?utf-8?B?UkdGbGpMcUlmR2hVOXFpVzRDcmRWWHc2K2l1ZnF3Z0tiMGExMkxxUzg3SCtq?=
 =?utf-8?B?cS9HMHdVUFltL1c0Q1VxWkh2Y1FoZDhBTmthNkdPNm4rbGVWV2kySUo2b0tX?=
 =?utf-8?B?V25sNU1xT0JGV0s4LzlWRlN5N0tSU2RCa2lvWWtWeVVtM0RZSkljVTVWUnpm?=
 =?utf-8?B?UTFHK2RPVDNBWG9wNzFYRWRwZGRjZUEzUGNhOE42MTU5dklVdlJsSnRrd1FX?=
 =?utf-8?Q?8CKhwjG7aslnbMyOHX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5205d6e8-e16a-413f-7bc5-08deb5afceaa
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 14:06:22.6779 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dJizWzr2ab2src61B1qqGwekqRJLkjPsoq3cUJ1oKATA41Blc/izfZ00Fz0Rs3J
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
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

On 5/19/26 13:18, Sunil Khatri wrote:
> Add per queue array to store userq vas and keep
> size to accommodate vas of all types of queues
> i.e gfx, compute and sdma.

Yeah that's a start, but I think we should go a bit further.

> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 36 ++++++++---------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  4 ++-
>  2 files changed, 16 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 7354c51ae83d..9ac7f18c903f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -218,18 +218,11 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
>  static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
>  					   struct amdgpu_bo_va_mapping *va_map, u64 addr)
>  {

Completely nuke that function and it's caller.

> -	struct amdgpu_userq_va_cursor *va_cursor;
> -	struct userq_va_list;
> -
> -	va_cursor = kzalloc(sizeof(*va_cursor), GFP_KERNEL);
> -	if (!va_cursor)
> +	if (queue->userq_va_count >= ARRAY_SIZE(queue->userq_va))
>  		return -ENOMEM;
>  
> -	INIT_LIST_HEAD(&va_cursor->list);
> -	va_cursor->gpu_addr = addr;
> +	queue->userq_va[queue->userq_va_count++] = addr;
>  	va_map->bo_va->userq_va_mapped = true;
> -	list_add(&va_cursor->list, &queue->userq_va_list);
> -
>  	return 0;
>  }
>  
> @@ -284,14 +277,13 @@ static bool amdgpu_userq_buffer_va_mapped(struct amdgpu_vm *vm, u64 addr)
>  
>  static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>  {
> -	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
> -	int r = 0;
> +	int i, r = 0;
>  
> -	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
> -		r += amdgpu_userq_buffer_va_mapped(queue->vm, va_cursor->gpu_addr);
> +	for (i = 0; i < queue->userq_va_count; i++) {
> +		r += amdgpu_userq_buffer_va_mapped(queue->vm, queue->userq_va[i]);
>  		dev_dbg(queue->userq_mgr->adev->dev,
>  			"validate the userq mapping:%p va:%llx r:%d\n",
> -			queue, va_cursor->gpu_addr, r);
> +			queue, queue->userq_va[i], r);
>  	}
>  
>  	if (r != 0)
> @@ -303,19 +295,19 @@ static bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_usermode_queue *queue)
>  static void amdgpu_userq_buffer_vas_list_cleanup(struct amdgpu_device *adev,
>  						 struct amdgpu_usermode_queue *queue)

Drop that whole function.

>  {
> -	struct amdgpu_userq_va_cursor *va_cursor, *tmp;
>  	struct amdgpu_bo_va_mapping *mapping;
> +	int i;
>  
>  	/* Caller must hold vm->root.bo reservation */
>  	dma_resv_assert_held(queue->vm->root.bo->tbo.base.resv);
>  
> -	list_for_each_entry_safe(va_cursor, tmp, &queue->userq_va_list, list) {
> -		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, va_cursor->gpu_addr);
> -		if (mapping)
> +	for (i = 0; i < queue->userq_va_count; i++) {
> +		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, queue->userq_va[i]);
> +		if (mapping) {
> +			mapping->bo_va->userq_va_mapped = false;
>  			dev_dbg(adev->dev, "delete the userq:%p va:%llx\n",
> -				queue, va_cursor->gpu_addr);
> -		list_del(&va_cursor->list);
> -		kfree(va_cursor);
> +				queue, queue->userq_va[i]);
> +			}
>  	}
>  }
>  
> @@ -633,7 +625,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>  	amdgpu_bo_reserve(vm->root.bo, true);
>  	amdgpu_userq_buffer_vas_list_cleanup(adev, queue);
>  	amdgpu_bo_unreserve(vm->root.bo);
> -	list_del(&queue->userq_va_list);
>  	queue->userq_mgr = NULL;
>  
>  	amdgpu_bo_reserve(queue->db_obj.obj, true);
> @@ -738,7 +729,6 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	}
>  
>  	kref_init(&queue->refcount);
> -	INIT_LIST_HEAD(&queue->userq_va_list);
>  	queue->doorbell_handle = args->in.doorbell_handle;
>  	queue->queue_type = args->in.ip_type;
>  	queue->vm = &fpriv->vm;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 033b8a0de6b1..fdf4d878c894 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -93,7 +93,9 @@ struct amdgpu_usermode_queue {
>  	struct delayed_work	hang_detect_work;
>  	struct kref		refcount;
>  
> -	struct list_head	userq_va_list;
> +	/* User to store core bo's va addresses */
> +	u64			userq_va[5];
> +	int			userq_va_count;

Make that look like this:

union {
	struct {
		u64 queue_rb;
		u64 wptr;
		u64 rptr;
		....
	} va_names;
	u64 va_array[];
};

Unused entries should simply be zero.

After amdgpu_userq_create() fills in the different VAs we just call amdgpu_userq_buffer_vas_mapped() to double check that they are valid before mapping the queue.

Regards,
Christian.

>  };
>  
>  struct amdgpu_userq_funcs {

