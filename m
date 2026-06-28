Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48364C43458
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jun 2026 15:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D59C810E63B;
	Sun, 28 Jun 2026 15:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n+qeTAKn";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19D4710E63B
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jun 2026 15:12:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qr2W1h6bZ51CtQlYeeWsOTPXByJn62RfQxe41xgzwE0E8iWD5QZAF3lH/TMwuNrmNI9Pc3bJC538YjC3xMVfzd1r8AyfR3iL0HvVcVrwMDjCKleSiLNN2qFKNQXUShJxWa48GPFS+LvqtX3fVEhTMuA6xBWU6Rwf2XlzvPhxaYQwwdfX8TWBPZJFMJ1+IIvGfkd9xTBN0HF0vqPuZfyV8TM7rhwfIgO1aq4nadxSFz0ErXh1h7bHHanrMbHw7prB9oLHQcRy6JOHMsiYAuEqslzg77S6n418ne/K8swKDcpRc++4/6ek4SAEHxqDm+O2F41l4I2VWh10+fqt61Z4bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gPR9N714+/GQo/3bfFpwDklXFiP6DN6MadqsbaVQB8k=;
 b=niodj1sVYHZjYb6ZbB9Itd9Yg2uBCjl/6StTIPDxV6OrP0fWxfqFS/+aouAHI9hnxDpAJ1Q8CN8/FwarM3S7CgrDrjSn6pScJ9M4mUE5aJa3y8jipXUSBqp0TqvxIR7m7wm3Iu4+2G2RJzTfVC99qvqL6ZxjMtvCxuCpGpneN/PUweKmLNB0uYbGblXsynsqjznfK6ccXWdzL7rGpT2N4yFyNgjhIAZUR73vn+8kF5VxRtTUUQsY+KqEILzH1Dp+a+YYl9nFqHjaxueaFhAutumGwiI4HXHkChMBMiVL0QddTxakGjJofqHlZ9GRvl7RMWy1h4hXlzhxGENVKvdzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gPR9N714+/GQo/3bfFpwDklXFiP6DN6MadqsbaVQB8k=;
 b=n+qeTAKnVJuRIo12Vd7yvznHMV5pz338W+4AO00uetDou3h0kKFujSxN+HIu0iQKy+vqMZ36HakSNCEq9lsW5Xxr62OT1xzojv5r3OlAUMIlwBbORvX9nXHzaF3dx5kEAHRK3zWUcqt/H2Bq0sHhSnzzbZ3ZBZSf02jmrt4IarE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Sun, 28 Jun
 2026 15:12:01 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Sun, 28 Jun 2026
 15:12:00 +0000
Message-ID: <c3332376-cd3b-4a36-b89b-5b4d469e1545@amd.com>
Date: Sun, 28 Jun 2026 17:11:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix check in amdgpu_hmm_invalidate_gfx
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alexander.Deucher@amd.com, amd-gfx@lists.freedesktop.org
References: <20260626180145.6213-1-christian.koenig@amd.com>
 <CADnq5_MQfj8svtHLj5bB6R8hBnTX8tC5r1qdRn+wHH-DdfeBaw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CADnq5_MQfj8svtHLj5bB6R8hBnTX8tC5r1qdRn+wHH-DdfeBaw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 0dd148a5-62ca-42f5-06c9-08ded5279a6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|56012099006|11063799006|22082099003|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: vBZfaeDDbXgbZrfF9svzdj2fuvyhqvu+ig7pKSG2VOtHkrmRXa34TkFlbxrDFqOLdmyFAX28C4vKZ4DYuSiW3c4YWiUdpVXfyuIdkGb/4DhWRTrWKy2RadstBZA7VbtiRmVPvBYXbBLgyF3PO04OQgdB0C3MYAvWkMGmENPRUuvsnRetJp1wZMFhUpQ/CDq1O3WhVgWTCotRVaOF1IVIxSlKODu4Yc4jLwWg0LvDJ+5nigzHZvZfXUemx2SU2MO8oKBpS6dbbARKET44EA1OaT1tnqWwWRJFngnIugCsqkI/QeLJzOyJtxx0U0aJ4WEILrBjdbPVw+C8frGg/xpdGlZyRhoHOhlEXFO840qoliXqHy/WAAH3jsBgVO1IMFC+yRe1FkMvYEgq7MQQLJwCd7djwd18JygLG1g3CEMsXd9vHKNjTUueBxr9yK2cRuc5BGopN6e2WOPzvCivXByYidltTJIRNrA0O2neXPrlycG9VT8ndVdkI7bLeizREiHRxlC4WRDG97poI0i+H/bPqUsrfgqvweTEMCHZIfKnCbza2klhGFO9TCQOY2IAwYwWI4VZ2a9r9U9VmQ3Y5xj3AN/Uglvv0dG90+bVt6/lloJgZaG/ixOxH1xdcR2WGZrXvp+id3+safDtM+DFQ+mIkQL61kgmS0GOrqapkkcBQU0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkZTQW1KMElVZE1OOXFuaXcxcGtJZC85RGJWYTdsOWN5N05KK09qREJZazdW?=
 =?utf-8?B?eU9UckJmckZVcTdRRTBzNEJXd3hZaEd3akdiS1YvMXg5aVNlbzZzNTY0L2J0?=
 =?utf-8?B?Zy9hS3JvVURkQkNFUDdPSm5sYWREazhUVlZmY0VmZVBZWWp6QjlySytoSXJ4?=
 =?utf-8?B?TEFYaU4ySVFUNnNSRjNKUFFPQi9YQUxkZUNEQnl4RkFoa2xPTUlJaDZERjI2?=
 =?utf-8?B?a1ZBeXFBanZmUlNHTndPdm9xTk5QOFNJZ1loR1pMeTFXVkxYOFA5WGMyRmh6?=
 =?utf-8?B?WEwya3ZyMXJTY3BIdjV4YStZOVRlc1BIYjhzbkFabWw2VzRFcjBJOUg0WnBE?=
 =?utf-8?B?QVpFTHp1bUZ0bjdIaTg0K2xMMjFrTS9oVWxLVWFPOHlYbjN0UjlRaHRtcGtZ?=
 =?utf-8?B?VmExNTVNOVh3UTZNYytwZjhkbjM4K0hNUkhvUUVmaTlDRFpiSkNFS0wzanhn?=
 =?utf-8?B?aDVYWUFMcms1WkhKU0JOT25kZFYrTXcyT2VmanhPZTVmSlUvR0JpTnRJM2NO?=
 =?utf-8?B?RFVPYlJDQWhPZUc5UEdINzhYYnlIaG1sR0pVU3V5YVQ0bkRSMkZnNUM5a0p4?=
 =?utf-8?B?YUVPT0NvbWlMeHoxOHlLRFRZUGVibHlqeGVpNXBmS2ZGT3Q4Y1dlVmQxaDF1?=
 =?utf-8?B?bDRzbnordzRKNS91WXN3TkpXTnNWT3RlYXNDdWFkbEtBWkxkcWM5QktoSEt3?=
 =?utf-8?B?N0NJSnpWMDNNVmZpeG9rSlpJSTc0anZwbnZyZnhlNGtVR3FCbk5TQlhySnBu?=
 =?utf-8?B?ZmZxU0pOOTdNKy9KTGJhd002R3VKQUE3a1Rjbm52U0s5NGtUSktJTkYyQUlJ?=
 =?utf-8?B?N2kwRE5MMjRjMnVFNzRYN2lCQkE1U2FPcXJUWlJVRDEwWWw5by9TUnFYM1A0?=
 =?utf-8?B?NnBjS2toKzFrMU5uTHpLWWtDU0l3NlNoTnZaVkxHb28wSlExM0dLVzcxTFMx?=
 =?utf-8?B?QkRiTUN5OHNTMFNEQ1ZkbVpBQklsb1gvQi9Tdkw2WlRyc0ZxYXZYMEtDMHRm?=
 =?utf-8?B?QmVVVm1veC9HNFlPVFVYQTV4SGtsN2Z6cThYVU4xVzgvOU9iaFdMRVVLWGhL?=
 =?utf-8?B?WHN0dWYzaDdPaXN3TWNIK2tFdjJ1Uk5PWjNzVi9JSnplS1BOUlFQYzBXTWt1?=
 =?utf-8?B?anZpZWU1cDM5L01kQzRZNUVJNFQ4N1d6THhDeDdzQ0RCZC8vNEpieEZIWVhC?=
 =?utf-8?B?T1FQNk81cWNYbHVBU04yaXNwNEFvQmV6RG9iR2txVnU5T3dScjE3Y0tyelhy?=
 =?utf-8?B?NGsvaGlESml0ZGc5NFlmTzZFWkp0THVRUVkwTldFRllib3E1eTVORXFpWHly?=
 =?utf-8?B?Ui8rTUhkdFlObGNJWnk0RnJ3OGhJNVRaUloyK2NnUHRKOTVBOUFFV1RodHVz?=
 =?utf-8?B?Z3dCZnZNMlFManFZUkQ1c3R3d0l5QVNJakZlUWhHMVFrUElua0ZVdk1MZDF4?=
 =?utf-8?B?cjVwaWhwTXJ1RTlvVHZGSXQ0aWF0QUs1VW9HSGFtWVJubGlOdlV4WXRXcHUx?=
 =?utf-8?B?akc1M2swRTlleWlibzNoYVNsY2RGVkVIbGVQYzhHbFEzZUNGVGNELzdxOUNI?=
 =?utf-8?B?OEQyY3htK1ZwRFl0MXAvdHZMcmMxOGZGZC9yai9YYjdNc2RRRHZvTzVRRHpH?=
 =?utf-8?B?enBmcVE0UjJUME1kMDZTUkhKNHZwTzVKdWZFTlQyQ0M1TXgxRkVUSjJyelgv?=
 =?utf-8?B?WDVpZ2llYk9QKzBVNnZvQ3dYcDIvSWNVM2pvdVcyQTJZNTEvYlNpejcyT2tx?=
 =?utf-8?B?dFN5djhWcGlrL21IMjV6Q1FrWTUvbUtZUE5RZUl3ZjBrWWxQMFRCTktnTVds?=
 =?utf-8?B?Y2pEeHJwdHh3NHo5QzdjYTlscitVMGN5d0dHejg5S0xCOWhvOWduVmpxeGxs?=
 =?utf-8?B?YmFBZjRsVStnVWJXRnIzaEo1S3gzaURucmxlZXVNV0E3SGhnTFErUEhSR0Z6?=
 =?utf-8?B?cDV4RkUzOWIxSzZ4M0U0K0ZRTnFheklJUlk0cmo3NTVNYkg5ZldHbnVKUW5B?=
 =?utf-8?B?UWlzMS9tS1VmbExaM3RhY3NaUG1vMHNUb0swSEJxTFVjLytQbmprNTRGVmJX?=
 =?utf-8?B?NGRjdzdzQ2tKTVlBSUxpeEcwV2FEWm1YNFNDTTJ4d3BERlROREJnRC9aeTYx?=
 =?utf-8?B?ejB5bExNbzhoaUp5SlpmVE1oQ1g5dE1XTzJWdTAvOVg3a2UwTFR3M0licDYz?=
 =?utf-8?B?SmlqNHNLZHJneDQ4VDhBVllYdkJZejZML2szbkt5OG9INGorbmNGVWxBait5?=
 =?utf-8?B?TDdIWXRXbVhpc0VORkI4dWVPUnB6MlY4aXhpU2tnejRTRDRxSno0MkR2VnJn?=
 =?utf-8?Q?RzjdJgpVsSeEwBZECT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0dd148a5-62ca-42f5-06c9-08ded5279a6f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2026 15:12:00.7809 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFOtTawAT1wrbA4LJ8dmosATboqHi3dAa1l4xfw2O1qqEZjPwbeJDOmTtyPkfes2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
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



On 6/26/26 21:31, Alex Deucher wrote:
> On Fri, Jun 26, 2026 at 2:01 PM Christian König
> <ckoenig.leichtzumerken@gmail.com> wrote:
>>
>> For a short moment during alloc/free the userptr BO is not part of his VM,
>> so bo->vm_bo can be NULL.
>>
>> Keep a reference to the VM root PD as parent of the userptr BO so that
>> we can always use that to wait for all submissions of the VM instead of
>> only the one involving the userptr BO.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Fixes: 5cd5f99b7b9b ("drm/amdgpu: fix waiting for all submissions for userptrs")
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5399
> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 1 +
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c | 3 +--
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> index 28f89ae8ca74..686be2bb8c37 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>> @@ -535,6 +535,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>>         bo = gem_to_amdgpu_bo(gobj);
>>         bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
>>         bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
>> +       bo->parent = amdgpu_bo_ref(fpriv->vm.root.bo);
> 
> Do you need an unref to match this?

That's in amdgpu_bo_destroy(), we use bo->parent for multiple other things already.

Christian.

> 
> Alex
> 
>>         r = amdgpu_ttm_tt_set_userptr(&bo->tbo, args->addr, args->flags);
>>         if (r)
>>                 goto release_object;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> index b38788228d0b..eaf02f90fddf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
>> @@ -67,7 +67,6 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
>>  {
>>         struct amdgpu_bo *bo = container_of(mni, struct amdgpu_bo, notifier);
>>         struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>> -       struct amdgpu_bo *vm_root = bo->vm_bo->vm->root.bo;
>>         long r;
>>
>>         if (!mmu_notifier_range_blockable(range))
>> @@ -78,7 +77,7 @@ static bool amdgpu_hmm_invalidate_gfx(struct mmu_interval_notifier *mni,
>>         mmu_interval_set_seq(mni, cur_seq);
>>
>>         amdgpu_vm_bo_invalidate(bo, false);
>> -       r = dma_resv_wait_timeout(vm_root->tbo.base.resv,
>> +       r = dma_resv_wait_timeout(bo->parent->tbo.base.resv,
>>                                   DMA_RESV_USAGE_BOOKKEEP, false,
>>                                   MAX_SCHEDULE_TIMEOUT);
>>         mutex_unlock(&adev->notifier_lock);
>> --
>> 2.43.0
>>

