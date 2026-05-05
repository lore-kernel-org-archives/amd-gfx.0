Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1174CD13DA
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2026 07:29:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B7210E9A8;
	Tue,  5 May 2026 07:29:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EqoshNGW";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012043.outbound.protection.outlook.com [52.101.43.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D68B10E9A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2026 07:29:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8BWorRk4ZTYOS5mLK++JVeWDr3pSzQYoyQ9otNrNP18GLMQNfb+SZtPX+QenCuZV/oILcEpRolYJBJiQShMUq/4R3DjwI2aKuZvzmyLGUyXqt26VaFkAB8WWIN+2NDxYT4vIkWjzaDLHsTGRNEq5ecTxyx0HJEuNYyU2LwCYzOWvTK4CFVkF+j0z3HsCh/3LQHDoOwcyoNLjAbLoMKqU/RqJ9B6vFluvfRzJSw5gadPmjW1La41WoqdQsl7mJLbxWV/XkiRaqDKXkbr/WBivrkjf/1AaVbsswsDyvXExKDsNOdD0m0sOH5WnnssEP3Scb6IpPXe1jkepZEpeQWXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vi8fAEkMjE54weqZxqaXYu3yEJ/c4tRVI/quwFOOcyY=;
 b=K+DALi12KdOTbLcbz8KtvefjMlnL/O9XJxr3LmQyD4P2/aXexuMBmUYi5aTde9ogFN/9nLQfuX4SSWRoIF22rN9XO92o2HlQ2SdrFhYpwRRmTKJ8m/HbAgqozbn+wN0hRuqqXYjMYTMogALnWyn0WixB5mrWDzEaIak3vIdI1qi/Y1uy/vgp8Wq/xbwsuYztGetG41laEIaTNMhx3yAQMV3XVUawfbjWDa3G5fmdQU/dKeh9RBSH4O4V6FTcAD5JLTJrQGtgTpU/1JD5oU8MLO8N6ftfCBIovEUHGAxKO8ot9EfNTbGmtZCaBMcp/Zh+4QQ0vazhGIHCbzx0HtvzyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vi8fAEkMjE54weqZxqaXYu3yEJ/c4tRVI/quwFOOcyY=;
 b=EqoshNGW4qiHuipmdao9SGJhZ72G9NM7gxvaxWbe19MiSDZxoSXmA95waz34Vr+0RejWID2Ky4GG8E0X5xKhAYgu74kGN7QMoq8QnQV3mpgQUuUFx1dbqZLKcAYSBiOhFF1qAa40ZQ/E02Pepk2vd886v55vzAbeM20932ySeOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by DM6PR12MB4140.namprd12.prod.outlook.com (2603:10b6:5:221::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Tue, 5 May
 2026 07:29:42 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.20.9870.023; Tue, 5 May 2026
 07:29:42 +0000
Message-ID: <e9078a36-09fb-4a99-ae56-d513fa787b40@amd.com>
Date: Tue, 5 May 2026 12:59:37 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: fix access to stale wptr mapping
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260504125645.91836-1-sunil.khatri@amd.com>
 <ff00838c-128b-40be-b215-4f21012376cd@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <ff00838c-128b-40be-b215-4f21012376cd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA1P287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:35::33) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|DM6PR12MB4140:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ea5e84f-c4f8-456f-3fc5-08deaa7812bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 8p9scVN7oJ1epIc9bpgKZz8iRi2LHGXuQoIa9i1n8P0dIGPBxir3h22AAvBvXjGUjpVOZeHydHkyXa/s/09zsj0a42vBeSmOxq5gxC/oaHez3pesWi3+zKEkj46X/FnB5PfHcvVm+Q+Jh4eWBS9Ts00D8zhcPTH2odhIBFo7C1eAj28ZxmoOW2wLdoTGTW4Gd8k1mIkfh0vOy9ihqCKJtonjpYVtpmjN6Kx5PaH21m7Zrr3pvwfY9kNfSAsTDzyyE9u4wNycTzGO7MUTrqUy44RjkK8aqqDE6Jc5gepRUD6oKH1iwKKAe0HjlpJxoJWuVKimV7kodc4AGgUg8W6Uk5ybvaetx80PxLsBhux1KjhOmvHSFdiB7mrlAorIBAwt2cvAq73yyJXJjTt8zWLI1slICvkJDPEfZZ1GeAJftUV65SCtowJ9B+kDMDOpHZR7x206k9g+6JZIyBBojBTvKdyFDXMvDmsPbUffglUsoaiIBqlVX71QSjtyxq7dwC4OoBjX8TiuTLlIdugheNjyPxwYtBRhF4r9brd/WaOkimLEJd5rZEhHi2cSYrlcDqdOVvfEgtZwLrDOW40JL7fp27aBwZM/AjSIA7N8AwR7kGJxoT7x81NFbZ+6LkVMNfdwjULyTaDp8/NbFqysM2SnOATCu+QWnrMaF2Cdr8PklzXyXOyugf//lT2x0QAzhfgi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGp0ZTBodE1DbDVzU2Fsd1pKUFFhQThZT3I0czFKOTV4Q1drKzFHVk1SUTAz?=
 =?utf-8?B?UDlOSTF0NzZiMlNJMVFNdE9TZU0zOWFYdEx3YldCbFNkcm1sc3RlUXYxZDY5?=
 =?utf-8?B?QjdBMzJIWHpVcGowekZ6ZVBoaTlpamwraFNVQWdTMFVDM2xiZEJ3bE5TQjFP?=
 =?utf-8?B?TnNRVENFK3JpaUNsMHRoQ3R6Njk1WDFCbXhPY3JpbEk0cjJrS09zUW4zK3Z0?=
 =?utf-8?B?Z2lqNmkwSkd3Z0VSeWlGQit6Smw5Y1dtTExUU0grYmlXV0tFaWpRbjkrdEtP?=
 =?utf-8?B?NysvMS81aU4vMFFCZnBMNDVCNjZrdWhGMWV0bk43MGVxM2R5Z3hiaEJybEgy?=
 =?utf-8?B?cWJnTS9LenpHeWFla01ITThydW1XcXRxcm13aHVGd2tVVnlObzJhRVV6SFVa?=
 =?utf-8?B?S25HdnlhWC92SWljVkMzK1JFcDZENTBvQmo1YytPWENuSGM3WS9DbGNKRTNu?=
 =?utf-8?B?R3pHUzl0RGlLemZ6MWFVWHB5N2prL3EvemZYWmtGd01tYmtmVUNpQ0V6bjkv?=
 =?utf-8?B?TC9FeUJ1TGpIUG5LWTRLbytuZEtiOGtvMmxjOGtoVWFadVd3ejVoUWxGdVJY?=
 =?utf-8?B?R09HbysyYkp0cEFndGEwb0Y4ZC9BYnl0RnpyeXUzcDg1SzFMY3JtOFBud2w3?=
 =?utf-8?B?VUU1UVU0bE5oaUdoSldVY002eE1TblkwRXY4Wm9OeWdMMVFET00zTmhDU25K?=
 =?utf-8?B?bjBPQnp4YnFPcUVkbEFHVzdRK1J2SmZiS3VmbS9scFIrYUQ5alc4OURISGIz?=
 =?utf-8?B?ZzZIczRLU3pETXpZOGM4bUtTRUpiRlJ5U2pIMlNaSklVaGc2eWk2NUNaNU9G?=
 =?utf-8?B?Y01MRVVIVVMwT3czRzBFRXNmbUpIK3Z3dzNTTTJROWlBRVF5d1pNZHpQc1kr?=
 =?utf-8?B?dTNmYWFrUy93dTI2Rjk5YWN3aGFPRFBIaEdQcWxHQTljbXhjYURja3poWnR3?=
 =?utf-8?B?cWY3V2g1SW1iemtmZmpmcDk0SEgvS3RGbUNYRTZLVTNkV0d5MlRwdTJmWjk0?=
 =?utf-8?B?WTNGeXpNd0k0eDFJdzYxazRYREtheVJiZWhQUkl0WHhWdVNkdFRIWEhzYWp5?=
 =?utf-8?B?SkRZb2NxNFN6RlAvSGE4dG43dytoanJtbnJmUkxsb3UzbHJWWGl1MWF6dklr?=
 =?utf-8?B?SnJWa3FuelZGVDBidmd1ZHdBU255U1loWGNKb1NEM0JNcnNqcWduWWx6NUpx?=
 =?utf-8?B?ZzU4RE1DYjczQldQVUI1aEVHeXBKU0F5L3VWQW5GS2hhSjBqaVRITHBSSTE5?=
 =?utf-8?B?RUUvOFR5eGVvM3FkNU54eG1ncThiQ0pIL1V0N3R3SUdOdzBpYkJIOWw4MGps?=
 =?utf-8?B?SUFzNVEwTExMckZLRVhycTY0OHUxV3hDNm94VGJLM284Q1JpcVN4S0pMRDd6?=
 =?utf-8?B?c2V1TUt6dWw2QjIxRzRIUWd6b0RzbGZGdlVPL1AzSHovdms5Vmk4MWdOUlZX?=
 =?utf-8?B?T1g0QnBxMXoweEI5emUwWW5kTWF1ZHVua3FJeitWa0pSNFRIVTJwYjBGRVF1?=
 =?utf-8?B?WFVoSlRYVjRmZitQY0dZbkgzVW9DdXhhdWFUZ0YyQTRQRy9aR1RrZzZFMmRR?=
 =?utf-8?B?aVFOeEtjTjB0K3M4cy9KVFB3T01OOTU2c1NVa1IwZVg4VWwzYXNTUGkwSUla?=
 =?utf-8?B?eDZkYVNyS2RGa0FXZFN4OXhkQjdRbER3MmRTZ1JMVHVHRE5RSHk3am9Kb0xz?=
 =?utf-8?B?ZG5WQjMzN1o2dHRGaHpMTHk5STVxaUFmNWtrZGp2RGI5S3piV0FzNVVwS0Np?=
 =?utf-8?B?TDNUTkJLbU9qYXZ3bytnNnpCV1U2NVdSd1k4Q1NlVERDZ2ZHL3ZoMHlTZTl1?=
 =?utf-8?B?OUovaHFaemJBTE9rdFJUUHd0NUREMlU4cTNVWWJWcFd1ZGpWQU0xckxDS0M4?=
 =?utf-8?B?bmlkMFRzdEZuT0lUVE1ZNWphcXFnQmJOY04rdkNhUTVtUVZEb2NrRWZ2Yzc3?=
 =?utf-8?B?MW9TdTJKMmVodGM3L1NQdjBhb0lVQisrSVFEbmFHZUh0WFRSazZRck9DUFlR?=
 =?utf-8?B?cVd5U3NIQXIxU2dlWHRscFBvV2laTkFGTHdNWjhkd1FKVnpOVTBycC9HYXhY?=
 =?utf-8?B?UEZ5SldySlVCUzhpNENXY0RHWmh0eUUzYkJTZ1VVU2xZQkVBYlNZWkxZdnNy?=
 =?utf-8?B?ZDlLaFRTN3V6UkNqVlM5cEk3ODFkNytRR0tnNndBcFUrcGhxZ0F4ZFlHQksy?=
 =?utf-8?B?NWpUVnFEaGkwd1VKME1PZlBQUTlNaXlvYldQYVBROFo2UmE5Z3FianJzeWFp?=
 =?utf-8?B?cHZYMUl4MGs1UWkyMlVyWmxNMUtLN3FZVEdSeVI2NTRWZHViL3Y0MkZYTkdD?=
 =?utf-8?B?bVorUHlidXcyTWIzdHdNRmc5S3ZTRmVVSUdvRk5UZGxudDdlbEtNQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ea5e84f-c4f8-456f-3fc5-08deaa7812bb
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2026 07:29:42.4262 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QN7eUBITB07dAfHjVps4dwsPqWWKDmznPAMooFqdwGR4Em8VvYeeKSTK1CIsTS1UiRNMiYLlqKoIjjVJ4jakjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4140
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


On 04-05-2026 06:35 pm, Christian König wrote:
> On 5/4/26 14:56, Sunil Khatri wrote:
>> Use drm_exec to take both locks i.e vm root bo and
>> wptr_obj bo to access the mapping data properly.
>>
>> This fixes the security issue of unmap the wptr_obj while
>> a queue creation is in progress and passing other
>> bo at same address.
>>
>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 122 ++++++++++-----------
>>   1 file changed, 57 insertions(+), 65 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 501e2e10b4a6..3d4f83015488 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -30,34 +30,6 @@
>>   #define AMDGPU_USERQ_PROC_CTX_SZ PAGE_SIZE
>>   #define AMDGPU_USERQ_GANG_CTX_SZ PAGE_SIZE
>>   
>> -static int
>> -mes_userq_map_gtt_bo_to_gart(struct amdgpu_bo *bo)
>> -{
>> -	int ret;
>> -
>> -	ret = amdgpu_bo_reserve(bo, true);
>> -	if (ret) {
>> -		DRM_ERROR("Failed to reserve bo. ret %d\n", ret);
>> -		goto err_reserve_bo_failed;
>> -	}
>> -
>> -	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>> -	if (ret) {
>> -		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>> -		goto err_map_bo_gart_failed;
>> -	}
>> -
>> -	amdgpu_bo_unreserve(bo);
>> -	bo = amdgpu_bo_ref(bo);
>> -
>> -	return 0;
>> -
>> -err_map_bo_gart_failed:
>> -	amdgpu_bo_unreserve(bo);
>> -err_reserve_bo_failed:
>> -	return ret;
>> -}
>> -
>>   static int
>>   mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>>   			      struct amdgpu_userq_mgr *uq_mgr,
>> @@ -65,55 +37,75 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>>   			      uint64_t wptr)
>>   {
>>   	struct amdgpu_bo_va_mapping *wptr_mapping;
>> -	struct amdgpu_vm *wptr_vm;
>>   	struct amdgpu_userq_obj *wptr_obj = &queue->wptr_obj;
>> +	struct amdgpu_bo *obj;
>> +	struct amdgpu_vm *vm = queue->vm;
>> +	struct drm_exec exec;
>>   	int ret;
>>   
>> -	wptr_vm = queue->vm;
>> -	ret = amdgpu_bo_reserve(wptr_vm->root.bo, false);
>> -	if (ret)
>> -		return ret;
>> -
>>   	wptr &= AMDGPU_GMC_HOLE_MASK;
>> -	wptr_mapping = amdgpu_vm_bo_lookup_mapping(wptr_vm, wptr >> PAGE_SHIFT);
>> -	amdgpu_bo_unreserve(wptr_vm->root.bo);
>> -	if (!wptr_mapping) {
>> -		DRM_ERROR("Failed to lookup wptr bo\n");
>> -		return -EINVAL;
>> -	}
>>   
>> -	wptr_obj->obj = wptr_mapping->bo_va->base.bo;
>> -	if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
>> -		DRM_ERROR("Requested GART mapping for wptr bo larger than one page\n");
>> -		return -EINVAL;
>> -	}
>> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
> This should probably be 2 instead of 0.
Noted
>
>> +	drm_exec_until_all_locked(&exec) {
>> +		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
>> +		drm_exec_retry_on_contention(&exec);
>> +		if (unlikely(ret))
>> +			goto fail_lock;
>> +
>> +		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
>> +		if (!wptr_mapping) {
>> +			DRM_ERROR("Failed to lock up wptr bo\n");
> Please drop that error message. It can spam the logs when userspace intentionally gives incorrect values.
Noted
>
>> +			ret = -EINVAL;
>> +			goto fail_lock;
>> +		}
>>   
>> -	ret = mes_userq_map_gtt_bo_to_gart(wptr_obj->obj);
>> -	if (ret) {
>> -		DRM_ERROR("Failed to map wptr bo to GART\n");
>> -		return ret;
>> -	}
>> +		obj = wptr_mapping->bo_va->base.bo;
>> +		ret = drm_exec_prepare_obj(&exec, &obj->tbo.base, 1);
> Using drm_exec_lock_obj() should be sufficient.
>
> We don't need a fence slot for this use case.
Sure
>
>> +		drm_exec_retry_on_contention(&exec);
>> +		if (unlikely(ret)) {
>> +			DRM_ERROR("Failed to prepare wptr bo\n");
> Same here, that this can fail is normal handling. The worst case is OOM and that is already printed in the logs.
Noted
>
>> +			goto fail_lock;
>> +		}
> We got all the locks now, so the drm_exec_until_all_locked() loop can be closed here.
True, Noted
>
>>   
>> -	ret = amdgpu_bo_reserve(wptr_obj->obj, true);
>> -	if (ret) {
>> -		DRM_ERROR("Failed to reserve wptr bo\n");
>> -		return ret;
>> -	}
>
>> +		/* mapping now should be stable since both the locks are held */
>> +		wptr_mapping = amdgpu_vm_bo_lookup_mapping(vm, wptr >> PAGE_SHIFT);
>> +		if (!wptr_mapping) {
>> +			DRM_ERROR("Failed to lock up wptr bo\n");
>> +			ret = -EINVAL;
>> +			goto fail_lock;
>> +		}
> Doing that again is unecessary. We are holding the VM lock above while doing the lockup.

First time we had mapping at time we did not had wptr object lock. Isnt 
it possible that either mapping is changed/updated or the bo is freed. 
At this moment we have both the locks and we

should be having correct mapping.

>
>>   
>> -	/* TODO use eviction fence instead of pinning. */
>> -	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
>> -	if (ret) {
>> -		drm_file_err(uq_mgr->file, "[Usermode queues] Failed to pin wptr bo\n");
>> -		goto unresv_bo;
>> -	}
>> +		wptr_obj->obj = amdgpu_bo_ref(wptr_mapping->bo_va->base.bo);
> That is now unecessary as well.

We are holding the reference in original code and freeing it in destroy. 
Dont we want to hold any reference now, how do we make sure that its not 
being freed in between?

If we dont need a reference then we need to remove from the destroy path 
too. In amdgpu_userq_destroy we are doing unpin and unref both db_obj 
and wptr_obj.

>
>> +
>> +		if (wptr_obj->obj->tbo.base.size > PAGE_SIZE) {
>> +			DRM_ERROR("Requested wptr bo size is larger than one page\n");
> Same, please drop that error message.
Noted
>
>> +			ret = -EINVAL;
>> +			goto fail_map;
>> +		}
>> +
>> +		ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
>> +		if (ret) {
>> +			DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
> That error message is useful.
Got it.
>
>> +			goto fail_map;
>> +		}
>> +
>> +		/* TODO use eviction fence instead of pinning. */
>> +		ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
> Oh! The piun needs to come before the alloc_gart! That's wrong in the existing code as well.
Got it.
>
>> +		if (ret) {
>> +			DRM_ERROR("Failed to pin wptr bo. ret %d\n", ret);
> That error message makes sense.
regards
Sunil Khatri

>
> Regards,
> Christian.
>
>> +			goto fail_map;
>> +		}
>>   
>> -	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
>> -	amdgpu_bo_unreserve(wptr_obj->obj);
>> +		queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
>> +	}
>>   
>> +	drm_exec_fini(&exec);
>>   	return 0;
>>   
>> -unresv_bo:
>> -	amdgpu_bo_unreserve(wptr_obj->obj);
>> +fail_map:
>> +	amdgpu_bo_unref(&wptr_obj->obj);
>> +fail_lock:
>> +	drm_exec_fini(&exec);
>>   	return ret;
>>   
>>   }
