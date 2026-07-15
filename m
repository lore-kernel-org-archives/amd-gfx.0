Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD20BC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 16:01:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DC0E10E0E7;
	Wed, 15 Jul 2026 16:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VuuwZcws";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93EBB10E0E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 16:01:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFTgUAa9h/ZFLd9l921opFoGUUpu7DXnYNmP0vOxlPrUIoB1zN4MIzoCWxn5EAc0eO3SvKA+QJISsluUx1So0XJqIQVdDEzbrdhW88ezxjb/KzPtchkNnsX9HEzIngQFNGlvSSJweX96Osh/EZsi/mXFQS1NNfC4dwRUA+NZrfT7wtfQA16WOHzxTUcjpihF4T07QCV/7C17MRTy/IRh0h9oMYU/nvYD6DSANjy53DMtdSdPFQTS1eIoLu0KHU7E5vj7dkMlMBTAoFis/6/DU/UJ4PvAwshURCBfYEpG+ULpwKE2TlX+45kDAYgz5P2raptJYfPbTgL1o1QtqkWwXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jX+msuBJ4wz2XoFP7cJ+Y2xPqsOn9DYvkiJlGca4HnI=;
 b=nzIsvV8o4MnZE/6Y/u4nCO3zacygOjxnK62U7h0Gws/wBhOIcHXgz1n5siz+xjmg83MGHOgFmxjIc38c6OkIWqzoi8HUNORIcEOoMJN/CC9xuv0/pYaz/9onlIBL7HBCk5+3LgjVykOEwawJ3tprY6xJOUXHaBZV9FomlsU45F+13fbdjlO/6YzLJ03j8lEjoBHg0Ktul/Sqb35ZF/iT8qckD4NOYYR+pb9nwMDKxBTqCwjW7fCfenJxHyIpFnYOIuMJteW7OHXnIZVZOIJyVLlv1zgv8q05lBiYlghxpJYafPhSLZRrZCLO0QgFB+TDeH9NkQweSIm6+uOax4Gpww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jX+msuBJ4wz2XoFP7cJ+Y2xPqsOn9DYvkiJlGca4HnI=;
 b=VuuwZcws6xV0T5WcxdPHiUZn7pKhXX01qZeFRkDkSHadWMxa824JNUQAvQ6dgc+0EWnISLiqqjkVC+7pUJ4sXSqGfkWHdXmyWQZKrksBIq74k7LJbDLXR4UqVSylEzYS33vFStF9+8JDEgkUFAE1xEu8n8kFSc5uT131ZfN1YgY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7782.namprd12.prod.outlook.com (2603:10b6:806:31c::18)
 by LV8PR12MB9644.namprd12.prod.outlook.com (2603:10b6:408:296::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Wed, 15 Jul
 2026 16:01:06 +0000
Received: from SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3]) by SA3PR12MB7782.namprd12.prod.outlook.com
 ([fe80::a9df:115c:2208:56f3%5]) with mapi id 15.21.0223.008; Wed, 15 Jul 2026
 16:01:06 +0000
Content-Type: multipart/alternative;
 boundary="------------dtDI9D7pHmh5y0Mx83NAWaWT"
Message-ID: <a965a413-19ea-46c0-a092-faf6f6b1de2c@amd.com>
Date: Wed, 15 Jul 2026 21:31:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: dont pin wptr bo instead use eviction fence
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260715142444.53373-1-sunil.khatri@amd.com>
 <b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com>
X-ClientProxiedBy: MA5PR01CA0224.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1f3::7) To SA3PR12MB7782.namprd12.prod.outlook.com
 (2603:10b6:806:31c::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7782:EE_|LV8PR12MB9644:EE_
X-MS-Office365-Filtering-Correlation-Id: bd9cbd22-970b-425d-33c7-08dee28a46e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|4143699003|5023799004|10067099003|56012099006|8096899003|11063799006;
X-Microsoft-Antispam-Message-Info: M9Vn0gWqH21nXY7TbcSDAJHvkNDffAGc4RGMB06/pDePqfJrn5CG1Hq6pfnbUnu4NW099OLW1xaZtQzi+qQAbU5aTz87koe5VVg8IikRHsXbYDo9tskfgGZj9fKoMAwXXo//XFHDdSNjV9xTdPExQYQ9z5NMRcCQwQvEjf9s1F1tUGgvYBdIrGBbM5dpfmowqkePl3wL9gc3MUQRF9T0iwP8GkpGUaMxoAjrrwwR9gabW2Vucw+jxStkqSPdUPB/SzFgtp8lP3x8FMcaSYFzExGPsgVp8yFIcoRDsqB3zn8AatAQ7+/d7TaYR9if7o2Vv873qjgOwbX9T5v1y1B304RX0vo50dNHMMSgPXUYQ9KaKw0QvdlNTHqXd50d64kxSRaowARtYGRyR5la5wwI0IbfSVyRkYrONgC6uawT704acTdigDeiu38ojG4atuuXfB6zIHpCuvOGwKJD8CQF/fCSKCT6BNcViOrHGNkf8O8T0s+tbqc9H43Tp9ddoLQ6glYgX2dUwPuPFql2GcF7AJfXdMHsuTXx1lIdwWZKTRRcpldXDp254FbwnxNrBIp3yxLqP0MCFeaVdGd5nbZiyh3sks2BX1/l/nEzr2RYL1Pv8cpwvwyq8OHNBrlht8Wtp2NbYn4IuYy82ynK9AcOyR0Gw7okJ4MUIudao//sCAA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA3PR12MB7782.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(5023799004)(10067099003)(56012099006)(8096899003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dElFVTRkc0R1alYxblhldFUwcmVkRzRSL25FVTl6Wi84M2haMDFEV1F3eEY4?=
 =?utf-8?B?L0FSd2V0TWpDVFlYOHpGQVpVTXk2T21QZHBvbFpiL2gyL0NGMFlDNHV0RUlx?=
 =?utf-8?B?ZGRvRGVHMWZ2VHgrR256T1J5ak5Ud3FLTTMvSmUwUTBZVGZIMFVkN0tIYzJk?=
 =?utf-8?B?ZnN6N09rWGFCVTIxY0dZa1pGTEF5SGMyQUhnU3BxMEllSkRleHpMWlVTUENH?=
 =?utf-8?B?aUFTYmFIS2dPSnptczRSTGtXRGh5RUp6Z2FOTVl6NCs5YjNjUEhkUk5RVlZI?=
 =?utf-8?B?RXRJa2ROK0hFS1BaaElWUWZ2QTFhUDBkd3R1emlobXJCbXJkS1JQM2VKeUYy?=
 =?utf-8?B?S0JlQWtPbUJ6bW1ZZ1ZEaVdvcEg1QUs3dU9YbmN6cHRCcnRBZGMxU3FlcXpX?=
 =?utf-8?B?MTdtYUFtOU9YQlZTaDJHNHB5eEo3bnMyZlk5OGVyVm1jWnJDVWtkMTBRZlZN?=
 =?utf-8?B?VHE5SFkvM2dRNVVlMkM3clFieTVrNXU1c1JGSzNHclFDSVp5NEMwTXpJNnR1?=
 =?utf-8?B?UXlYK0ErN1NBbzU0NXZyTGFCYXkxS2tSbGJjeEZNUk54OUdHUXpJN0o2SFNO?=
 =?utf-8?B?RHJUREhJM1BVSEF4Zm44OG9tRnpNOGlXdmc2VmN2LzhlRkt2NmdEWFp5OU8z?=
 =?utf-8?B?VUtsajRMaTM4UVRtN1pZVnlxMzVFcFhKU1dqR1g0M1VOQlhWTjYrUU1jcWhi?=
 =?utf-8?B?TTE0R0dTbmo3TjNmNmhxRUw5SFkyTXptL0RUcUZRWTJzQm1DWUdQZHFyV3FJ?=
 =?utf-8?B?UzdEY0F1YWtyUk5hWGlkNmhtMkMyUTE1S3pnV2M2eGxsTGhja2YwUUlQMndJ?=
 =?utf-8?B?TlZXOHZ6MDhiZmM2ZVREYktBV1ZDT1d1WVhZUDRPNnhJT1pwa2JoOGg5dkgr?=
 =?utf-8?B?b2tSb0srR1pOM09vcXVXYUxHNkV4NnlwNzhFODVJL2ZyK3VsR01iaWp5Y2dB?=
 =?utf-8?B?WmJTT0h1OGwwZWd1dkZuNncvM2FGMTVobHFvWVpZRDA2eVNaQWRNV2laaE9N?=
 =?utf-8?B?ajhXWmFka1d0a1NRUGFMTWU0c3luZmJKc1drR1RBVkNJVVpYNkwwSVBEZU5i?=
 =?utf-8?B?Q0RIOWpmdFlMYUxwVHgycmhoNmlwSkRXOFBvUVIraHlWUlhQZWJ5OFhVaVRV?=
 =?utf-8?B?ODJJTXlndGdWbTJMVmw2Zm8rU3p0TWZNNzEvUmJlRFBFYnFXVmh6TERWOFNt?=
 =?utf-8?B?QVZEQXFLU0pkb3RXMzVVOUFJRGN6a29EVzZIenVxWVp2MTQxSTNIZE0wYlBy?=
 =?utf-8?B?ZHJEV24vRmQyTC9EbmdrdzlYQkFVV2krb2N2WEVCa2IvTmNGL3B6KzJYMWpi?=
 =?utf-8?B?MFRhTWdCZWw0WFhRWmtEc3BwYXhaZU5SRGpIcTF0azcrM015QWxoUFE2ZVI0?=
 =?utf-8?B?NGtjV2JKRW1qYk1qWDlPektEdGdlbFMyZ0hUdE9sUHNkV0IwTkhOZlJ0WXh5?=
 =?utf-8?B?WUlHL3haQ2QzdDFSb2ZaN3lCRjZVTjVrQ21JeE53eVc4aFdDT01ibDRsSFRG?=
 =?utf-8?B?N05CUDRvb3ZaNkJYMnowQjZPRStlNHZmWXlLU1I3OUVUOFlaQ3VSeUplUHh2?=
 =?utf-8?B?Z2E3NWdhUWRMdWVZcmhGR3dOQ3lUVWg5N3dEdy9JY2J4endWZnVqblBWZlFv?=
 =?utf-8?B?M3JGZ2VWbU9mUGZ2Tm1LZE5YZ1F4YXhGejNOd1BLTW9mRHdRQ2kvclllWExs?=
 =?utf-8?B?YTNzQnJCS1NEaHhSZTB0YVNPaFJNY1QzSUtRK3pVTmpibUIrZWdYZEpROFda?=
 =?utf-8?B?YVpOYnhkNVYrU05hbnFaSGl6Wm5IQ0pNS2hkSWlob240c0JWR0ZMK0ZXbVpG?=
 =?utf-8?B?Y212M2IrcEJjQngxd1NzSktlOWs4K2NwZ0pzM2EvL3d0T21WUmZwQjhWdW9Z?=
 =?utf-8?B?Yy9ydUhldWhDNkdjL1lQNzVGQWsrSTZnbEJmSGZrbEtGcjM3ak1jVmJYSTUr?=
 =?utf-8?B?clJneVNtTVNzblY4T0V5Tnl0ZFREd1l0SWJwK1JEYlRqK1pBa1FWSWlSbGUr?=
 =?utf-8?B?TFQ0Zi9GRS9qbWw1UklrOFFGMVhkWTljVHZtNWtYbzNJZXdEODNDVGF6OEl5?=
 =?utf-8?B?bEF4c0pIakJraWczeUJENmV1a0xmTGlqWkVMeFAxaytCa0dwejFtQjZha2h3?=
 =?utf-8?B?MXl2T3FTYUJ6dXYxTExGcSs0UnN0TnM5MERvcXRLUFdnMGx0UXhWTEliSlEy?=
 =?utf-8?B?bFNUWDVFTTVBMVNRTW5jYndXTVFIYm5GL0VGZVFkdklOWWhZZko0UTRqRHJ1?=
 =?utf-8?B?MDNYcHRuK0tZTkVQUlNXLzFJMTVwSWwyY1NrQWkxWFJGc0FtMXpNSzJkd1pi?=
 =?utf-8?B?T0dnVU9neUZFQWZYdE90SGo2Mkd3L0g5SnhvQTJSWkNoOGNVSzNJdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd9cbd22-970b-425d-33c7-08dee28a46e1
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7782.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 16:01:05.8865 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ie+2K2D0UiZiu8oxQT5c/bBygS7AZ5GCBfuSp7JBJdrbpMsTact66PooSINV4vcBrqKdGdcS233KvMtCYmbl/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9644
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

--------------dtDI9D7pHmh5y0Mx83NAWaWT
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 15-07-2026 08:30 pm, Christian König wrote:
> On 7/15/26 16:24, Sunil Khatri wrote:
>> Instead of pinning the wptr bo attach the eviction fence to
>> the bo to make sure it remains valid all the time.
>>
>> Signed-off-by: Sunil Khatri<sunil.khatri@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 34 ++++++++++++++++++++++
>>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 17 ++++-------
>>   2 files changed, 39 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 911fb325c70c..e1eb689710c8 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -936,6 +936,29 @@ static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
>>   	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
>>   }
>>   
>> +static int amdgpu_userq_validate_wptr_bo(struct drm_exec *exec,
>> +					 struct amdgpu_usermode_queue *queue)
>> +{
>> +	struct amdgpu_bo *bo = queue->wptr_obj.obj;
>> +	int ret;
>> +
>> +	if (!bo)
>> +		return -EINVAL;
>> +
>> +	ret = drm_exec_prepare_obj(exec, &bo->tbo.base,
>> +				   TTM_NUM_MOVE_FENCES + 1);
>> +	if (unlikely(ret))
>> +		return ret;
> The WPTR BO should already be locked and prepared with fence slots by the caller, doing that here again can cause problems.
>
>> +
>> +	ret = amdgpu_ttm_alloc_gart(&bo->tbo);
>> +	if (ret)
>> +		return ret;
>> +
>> +	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(bo);
>> +
>> +	return 0;
>> +}
>> +
>>   /* Handle all BOs on the invalidated list, validate them and update the PTs */
>>   static int
>>   amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>> @@ -988,6 +1011,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>>   	struct amdgpu_vm *vm = &fpriv->vm;
>>   	unsigned long key, tmp_key;
>>   	struct amdgpu_bo_va *bo_va;
>> +	struct amdgpu_usermode_queue *queue;
>>   	struct amdgpu_bo *bo;
>>   	struct drm_exec exec;
>>   	struct xarray xa;
>> @@ -1094,6 +1118,16 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
>>   	if (ret)
>>   		goto unlock_all;
>>   
>> +	xa_for_each(&uq_mgr->userq_xa, tmp_key, queue) {
>> +		ret = amdgpu_userq_validate_wptr_bo(&exec, queue);
>> +		if (unlikely(ret)) {
>> +			drm_file_err(uq_mgr->file,
>> +				     "failed to validate wptr bo on resume, qid=%lu ret=%d\n",
>> +				     tmp_key, ret);
>> +			goto unlock_all;
>> +		}
>> +	}
>> +
>>   	/*
>>   	 * We need to wait for all VM updates to finish before restarting the
>>   	 * queues. Using the idle list like that is now ok since everything is
>> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> index 19c3cb61929c..ab8baaa83e60 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
>> @@ -71,27 +71,23 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>>   		ret = -EINVAL;
>>   		goto fail_map;
>>   	}
>> -
>> -	/* TODO use eviction fence instead of pinning. */
>> -	ret = amdgpu_bo_pin(wptr_obj->obj, AMDGPU_GEM_DOMAIN_GTT);
>> +	/* Keep WPTR BO under eviction-fence control instead of pinning. */
>> +	ret = amdgpu_evf_mgr_attach_fence(&uq_mgr_to_fpriv(uq_mgr)->evf_mgr, wptr_obj->obj);
> The eviction fence should already be attached to the WPTR BO when it is part of the VM.
Sorry i dint understand. From amdgpu_userq_create, sequence is like this 
uq_funcs->mqd_create(queue, &args->in) -> mes_userq_create_wptr_mapping 
(This is where eviction fence is attached)

after mqd_create we are checking if the ev fence is signalled or not and 
based on that we are again going ahead to attach new ev fence if 
signaled to all bos.


>
> The problem is more that the function is called at the completely wrong time. See amdgpu_userq_create():
You mean to say mqd create is called at wrong place ?
>
> And BTW why do we have the abstraction of uq_funcs? That doesn't seem to make sense.

I also need to check that.

Regards
Sunil Khatri

>
> Regards,
> Christian.
>
>>   	if (ret) {
>> -		DRM_ERROR("Failed to pin wptr bo. ret %d\n", ret);
>> +		DRM_ERROR("Failed to attach eviction fence to wptr bo. ret %d\n", ret);
>>   		goto fail_map;
>>   	}
>>   
>>   	ret = amdgpu_ttm_alloc_gart(&wptr_obj->obj->tbo);
>>   	if (ret) {
>> -		DRM_ERROR("Failed to bind bo to GART. ret %d\n", ret);
>> -		goto fail_alloc_gart;
>> +		DRM_ERROR("Failed to bind wptr bo to GART. ret %d\n", ret);
>> +		goto fail_map;
>>   	}
>>   
>>   	queue->wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj->obj);
>>   
>>   	drm_exec_fini(&exec);
>>   	return 0;
>> -
>> -fail_alloc_gart:
>> -	amdgpu_bo_unpin(wptr_obj->obj);
>>   fail_map:
>>   	amdgpu_bo_unref(&wptr_obj->obj);
>>   fail_lock:
>> @@ -520,9 +516,6 @@ static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
>>   	amdgpu_bo_free_kernel(&queue->mqd.obj, &queue->mqd.gpu_addr,
>>   			      &queue->mqd.cpu_ptr);
>>   
>> -	amdgpu_bo_reserve(queue->wptr_obj.obj, true);
>> -	amdgpu_bo_unpin(queue->wptr_obj.obj);
>> -	amdgpu_bo_unreserve(queue->wptr_obj.obj);
>>   	amdgpu_bo_unref(&queue->wptr_obj.obj);
>>   }
>>   
--------------dtDI9D7pHmh5y0Mx83NAWaWT
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 15-07-2026 08:30 pm, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com">
      <pre wrap="" class="moz-quote-pre">On 7/15/26 16:24, Sunil Khatri wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">Instead of pinning the wptr bo attach the eviction fence to
the bo to make sure it remains valid all the time.

Signed-off-by: Sunil Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 34 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 17 ++++-------
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 911fb325c70c..e1eb689710c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -936,6 +936,29 @@ static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
 	return ttm_bo_validate(&amp;bo-&gt;tbo, &amp;bo-&gt;placement, &amp;ctx);
 }
 
+static int amdgpu_userq_validate_wptr_bo(struct drm_exec *exec,
+					 struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_bo *bo = queue-&gt;wptr_obj.obj;
+	int ret;
+
+	if (!bo)
+		return -EINVAL;
+
+	ret = drm_exec_prepare_obj(exec, &amp;bo-&gt;tbo.base,
+				   TTM_NUM_MOVE_FENCES + 1);
+	if (unlikely(ret))
+		return ret;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The WPTR BO should already be locked and prepared with fence slots by the caller, doing that here again can cause problems.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
+	ret = amdgpu_ttm_alloc_gart(&amp;bo-&gt;tbo);
+	if (ret)
+		return ret;
+
+	queue-&gt;wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(bo);
+
+	return 0;
+}
+
 /* Handle all BOs on the invalidated list, validate them and update the PTs */
 static int
 amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
@@ -988,6 +1011,7 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
 	unsigned long key, tmp_key;
 	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_usermode_queue *queue;
 	struct amdgpu_bo *bo;
 	struct drm_exec exec;
 	struct xarray xa;
@@ -1094,6 +1118,16 @@ amdgpu_userq_vm_validate_and_restore_queue(struct amdgpu_userq_mgr *uq_mgr)
 	if (ret)
 		goto unlock_all;
 
+	xa_for_each(&amp;uq_mgr-&gt;userq_xa, tmp_key, queue) {
+		ret = amdgpu_userq_validate_wptr_bo(&amp;exec, queue);
+		if (unlikely(ret)) {
+			drm_file_err(uq_mgr-&gt;file,
+				     &quot;failed to validate wptr bo on resume, qid=%lu ret=%d\n&quot;,
+				     tmp_key, ret);
+			goto unlock_all;
+		}
+	}
+
 	/*
 	 * We need to wait for all VM updates to finish before restarting the
 	 * queues. Using the idle list like that is now ok since everything is
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 19c3cb61929c..ab8baaa83e60 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -71,27 +71,23 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
 		ret = -EINVAL;
 		goto fail_map;
 	}
-
-	/* TODO use eviction fence instead of pinning. */
-	ret = amdgpu_bo_pin(wptr_obj-&gt;obj, AMDGPU_GEM_DOMAIN_GTT);
+	/* Keep WPTR BO under eviction-fence control instead of pinning. */
+	ret = amdgpu_evf_mgr_attach_fence(&amp;uq_mgr_to_fpriv(uq_mgr)-&gt;evf_mgr, wptr_obj-&gt;obj);
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
The eviction fence should already be attached to the WPTR BO when it is part of the VM.</pre>
    </blockquote>
    Sorry i dint understand. From&nbsp;&nbsp;<span style="white-space: pre-wrap">amdgpu_userq_create, sequence is like this
</span>uq_funcs-&gt;mqd_create(queue, &amp;args-&gt;in) -&gt;&nbsp;<span style="white-space: pre-wrap">mes_userq_create_wptr_mapping (This is where eviction fence is attached)

</span>
    <p><span style="white-space: pre-wrap">after mqd_create we are checking if the ev fence is signalled or not and based on that we are again going ahead to attach new ev fence if signaled to all bos.</span></p>
    <p><br>
    </p>
    <p><span style="white-space: pre-wrap"></span></p>
    <span style="white-space: pre-wrap">
</span>
    <blockquote type="cite" cite="mid:b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com">
      <pre wrap="" class="moz-quote-pre">

The problem is more that the function is called at the completely wrong time. See amdgpu_userq_create():</pre>
    </blockquote>
    You mean to say mqd create is called at wrong place ?&nbsp;
    <blockquote type="cite" cite="mid:b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com">
      <pre wrap="" class="moz-quote-pre">

And BTW why do we have the abstraction of uq_funcs? That doesn't seem to make sense.</pre>
    </blockquote>
    <p>I also need to check that.</p>
    <p>Regards<br>
      Sunil Khatri</p>
    <blockquote type="cite" cite="mid:b2d8c2c6-15bd-4733-a7fe-035dce4c674f@amd.com">
      <pre wrap="" class="moz-quote-pre">

Regards,
Christian.

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> 	if (ret) {
-		DRM_ERROR(&quot;Failed to pin wptr bo. ret %d\n&quot;, ret);
+		DRM_ERROR(&quot;Failed to attach eviction fence to wptr bo. ret %d\n&quot;, ret);
 		goto fail_map;
 	}
 
 	ret = amdgpu_ttm_alloc_gart(&amp;wptr_obj-&gt;obj-&gt;tbo);
 	if (ret) {
-		DRM_ERROR(&quot;Failed to bind bo to GART. ret %d\n&quot;, ret);
-		goto fail_alloc_gart;
+		DRM_ERROR(&quot;Failed to bind wptr bo to GART. ret %d\n&quot;, ret);
+		goto fail_map;
 	}
 
 	queue-&gt;wptr_obj.gpu_addr = amdgpu_bo_gpu_offset(wptr_obj-&gt;obj);
 
 	drm_exec_fini(&amp;exec);
 	return 0;
-
-fail_alloc_gart:
-	amdgpu_bo_unpin(wptr_obj-&gt;obj);
 fail_map:
 	amdgpu_bo_unref(&amp;wptr_obj-&gt;obj);
 fail_lock:
@@ -520,9 +516,6 @@ static void mes_userq_mqd_destroy(struct amdgpu_usermode_queue *queue)
 	amdgpu_bo_free_kernel(&amp;queue-&gt;mqd.obj, &amp;queue-&gt;mqd.gpu_addr,
 			      &amp;queue-&gt;mqd.cpu_ptr);
 
-	amdgpu_bo_reserve(queue-&gt;wptr_obj.obj, true);
-	amdgpu_bo_unpin(queue-&gt;wptr_obj.obj);
-	amdgpu_bo_unreserve(queue-&gt;wptr_obj.obj);
 	amdgpu_bo_unref(&amp;queue-&gt;wptr_obj.obj);
 }
 
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------dtDI9D7pHmh5y0Mx83NAWaWT--
