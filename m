Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41804606A333
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 13:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=cywqU3Ae
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7841123CA;
	Thu, 19 Nov 2026 13:35:49 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012013.outbound.protection.outlook.com [40.107.209.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D49551123CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 13:35:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZobyXKjPlDGx6UBVaXTcl+s6d2iwCtsRnxIGNX2M/LJEoWZgnWxwDHrImRgIIbw00iQhgVWFu0g2jTSDaVBKyT7sWzokCHVEq3s7ooYRaDclFok+T46rYLZBFfSgHfmdr7n7Ou2Rd0EpMhDD3Vv/1wfaqGKuxZ0RFNhwY95FoiQmioA4vO2jvA8HEtKbzVrnpU0JTHB8S91jhrueBZgP5Dzo8sp09zHcM3yjCjbn+ODh9qJ7N9cSr+WKqXJlBYWcNbIEPoYoIaMpTbwG86VbA8rbcG/xlhsDnGrfTJtDTlKHqGyH9NGZH/4RK9pM9gEYIWV0OLLilbGRRBZ5SfeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1vEtebCuhU3vMYCOwBntnMMEaB9AKx23TRWXxkbrUOU=;
 b=a8N2Pf02bQ+ci0si0pVPwyKksKjxchnjZyAuV60OMHBmtITR7msJCnsEIM/qvtr9ZJRuLmeHyazyXdEfap5grs7NVnbTtQMePEUuVFawasqoWiKZ6GQWCspOXEyP8cirfhhWGUj45PxrS/EOdG8hAvlHtxtPipdkZUbsoY3we2NsAotlOp64A0O+qAeAMBE+HdRqrANtQCNUksl9XanxDS5uceuqdDK71njkTR19MvHrKMkGCZtaTfw5PeAHXRK4iaPAFAumv7SFLqu2bHusF47HsMFgM026zoUqDyDrxkGgMTQdQ01pBgILl/LUTw9iEGYCPDZq0LU66YIe/AqzDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1vEtebCuhU3vMYCOwBntnMMEaB9AKx23TRWXxkbrUOU=;
 b=cywqU3AeY9Ascy3mojikdt8TX0SzTYd2nb+9KFGQw56F/QGm8tS2183bM4EDoWrW9y7e8AsjwjNRWyyeberrzqzU/NEG+Dt608mSz8diEObpmam2fRHmzt/g51g/GVIqLlu+bK5dzYNPoJ8dw8Bsh6iNsTD/kTF1LKjN9l0huY4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.10; Thu, 19 Nov
 2026 13:35:34 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 13:35:33 +0000
Message-ID: <45f84bc0-8d9c-44d8-b70b-e188f5fe210b@amd.com>
Date: Thu, 19 Nov 2026 14:35:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] drm/amdgpu/userq: remove extra fence request when
 locking PD
To: Benjamin Cheng <benjamin.cheng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Shahyan Soltani <shahyan.soltani@amd.com>
References: <20261118185225.1857845-1-benjamin.cheng@amd.com>
 <20261118185225.1857845-6-benjamin.cheng@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261118185225.1857845-6-benjamin.cheng@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0213.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: bb4aa56a-1480-4edb-a792-08df4641fcc1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|10067099003|56012099006|11063799006|4143699003|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261022075727099003|261022105027099003|261026140227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: mk7JaWnSU6msqLz0s0TA9QYqE/csKyb4krMcfB1UG45nr0/5p6pbRBGB9ngQrAIbfNgA9PWZi3VD3UCcBlyyFJuwilKWxSx+WA4mVhS88qw5lwhJ0OF16JdJCtWGnbCffR0yj/bcNGxUeKZE18vrcjzIPEWZUO2vUG3F7l9TUzgrv1xLWawGF+9UwBrx29qQR/4kzc8jLjq8PMkFnZBq27jR/jDeyCJOcl5MzWnQ+u1CBTqM0df3A1w+AQZSUDyf9xtQSCZ9YFs7QFQgQl3JudBNUog0EAS2YIhT2OLxQ8BL//RG7aGpkv3Lxe8HOA7ayctVnals6psF9hS06SkaBvOmj/H0uuK+s2gszBTafaeNrDMGmzT3MBnrqR3rRKEGy/NAoXyN3Vnw6L2xT9ZGBE3bIpq5BTh8r/nKJD9V3t5Fnac5uZFm1upuzq3j2rVnBNZkVdL7ggX1lh5fuDvQltwyueaDegoVxT+Imrqlow5Vi3U7WDTPXtbLdHTPXKhh8eSqWj9SbmcTIYI3ImlM0d9cR+mVE1yB76HfI4bMoaujuxI0t7Xpc7Z3/EmlQnaKgRU17W98G6t1OcJgx8nn5QTABiMP7gvATheSowFz3w84iikmbi/LbQXSmoqWhTM3rahCBkCesgaebCu+isIC/rD/6YXcomZ2DBZsWUpHPTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261022075727099003)(261022105027099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1pCVjl1NE53VDFnQXlab3dPb0pCRW1keVdxU2tzMGhVSWRoK05Ud0N1VlBq?=
 =?utf-8?B?NGxsSGdhVG51NjR4bjVvYjR1d0I1eG5reTg0aHpDT1FhS3pNNmdEdUhQWTgy?=
 =?utf-8?B?WjYrLzJCclQ1Ry9rWjdPU2E2bFNPOUhmQVk2QW43T1lqWWZDVzcvSlNnblNp?=
 =?utf-8?B?Z0g4djFGZE5aQlBUUXNvaUhsWmxCekpKVTZGdWJRSU9sMWZnRkZSNnJxVCts?=
 =?utf-8?B?K0dMQWpZb3YwRnRMS3hTbitDMFlhWDREYUQxakVmY2EvMmhpVjNkenltQy9w?=
 =?utf-8?B?ZWxiNGlnODNmamROZldNSmJMVUxMOEJUWlRmMXg2RjMwZU1FT1VtQUljeUFq?=
 =?utf-8?B?OFJvM1REU2V2WWZucStEZFRnZGsvMVlYSUhuQ1U3Uk5JazAzZ2VwMjNDYmNP?=
 =?utf-8?B?WVRhc0w0d2t1empFQUxMNFMrVm5KS3A2cDhIajRyamEzVmFmMzloNzdrenFL?=
 =?utf-8?B?TElITkp3MVZzNnM0d1A5dDNQbXN2UDdhM05VRFNPMlFTdTdURUFBY3QwUnpC?=
 =?utf-8?B?bnVST0JacTI0c0txM3hBakoxVGZiT1grZy94MDM1WlcwU1dDaFVvSTRhOElm?=
 =?utf-8?B?VFFOaW5HRUVtcUNnc1paNFBDUnBFWCtyNEYva0NqUFdkK29DaUw0bncyYk1u?=
 =?utf-8?B?a3RPN0JCTDV0MVJma1l0Tjl3NkNScTBzUng4V3NDbXh1dVBjN3NURFJkaXJK?=
 =?utf-8?B?TmgzenordzUzaUF3M0dUYWFUNklOZkNneExYaTh4U3k4Zzh4clBEZjZNQkhP?=
 =?utf-8?B?L0UwRTIwVXFtSWprQlIyNWZSUFhFenBqQmVVQnRvZnh0YzIzMGxGRDNKTG9n?=
 =?utf-8?B?aVpFMVhWWnVuUzl3Q1FubnArQ3JTQ0tPV25DOTZYOG41VERKeG96TU96WGJF?=
 =?utf-8?B?TlNqSjh1RitBS1Fabm5qVHY5NUIrRW5YK3hYbWo0K2h0dTA1cTBabUNvR0dq?=
 =?utf-8?B?V3BHVjBjZkZVUmU1U1R2TU1lV0VCZ1NhS0Z4NU5wZy9kV2w0SVkwUEk4djdh?=
 =?utf-8?B?cE01dU16dUt6R2U2alR3MUVXVnU1dHRta01XcHRWa0Z2TnhhVDN3Q2YwL3po?=
 =?utf-8?B?NGpqRGhIREdWek1iVE9jdDNmTVJxTXZHSFlMZHg1aFdDZHNZcTZDRk4xL0g2?=
 =?utf-8?B?aTVCYlh5aCt6UFdMTWhmZm91SWRGK2s4N0RhQk5pUGpoQlo1MW9weEZVUXJx?=
 =?utf-8?B?N2tKQm0xWUJDUVhCVjRBckxZQ09zQU42eUp1WXB3ZWw3VUN0VzdNSUNrbVlt?=
 =?utf-8?B?QW9oWkNPSk84WHNidzh0R3o2bHBBZHAvTVZnNXlOakJQV3RDWXhaV0hid1Z5?=
 =?utf-8?B?RStrazBpeDloaWJjeWR3TG1MNUQvMVZtOHBqVkRTVmJTRm82MXhGcEYzR0FR?=
 =?utf-8?B?dE1tWmp1VStVRkUyME55SnNjUloyTFd5YW90TnZraTIySzg1WjYxc0dGRXhk?=
 =?utf-8?B?dC9EQmVuZFpiMlRYWE1jRXZLYStZelJHVDgyRUtWa1RrZ2swZ3MxODZrakpx?=
 =?utf-8?B?VEZueXhQUmQ0U25vMVBtTFdncy94MlBxaldLeXJrMGgxM0xLazN4QURFdE13?=
 =?utf-8?B?NHp3WnczazVDdnlseGJXbDVMd2dxMHlDdy9UQ0ZtTkNFeVlCVmw1TDZsMFFD?=
 =?utf-8?B?Q0hCT0pxeVVWNDJ3L1RKWThvOTkzeEFCTWc3eUxyMlJMRW8vL0g4V0wwK0dU?=
 =?utf-8?B?UGp1MCtsVkFDSG1rclo0N0V5VWZiN2dhajRSdWhJTGNEUXdvZUhsTlpoTEta?=
 =?utf-8?B?YUphNklqVkZRV1RkVmpyYWRxOXpDRDU3VDUycisyLzNhUFNya1dubWpwekQ2?=
 =?utf-8?B?YTFVcE51VFhWVy9Ec1BEcTk5QVBNTGhOOW1jUVZRbVEvNFhmSEpiM3RWeTZL?=
 =?utf-8?B?azNROWR2dzFSRmM1LzZ6V2doYmhOdnVrODBwL1VCTFBrZGJUVnhPVVExeUs1?=
 =?utf-8?B?dnZRQjZUQy94WVpBTDVuejJCWlB1VXM5TThiK3ZqNG9TZTlaZ2F4emkrNDFk?=
 =?utf-8?B?MkV5VXpSNWZRMlVEcGVUdUNzVUtKamN4TVkrRnZWREltU0lGS0Q3dFRORkU1?=
 =?utf-8?B?NlcxQ0tpcW02V29uUG9DVHZxcWlVZU5KRDVJRTRndXJpYjgzMUVYOHN2RU9E?=
 =?utf-8?B?bkZvOS9pemFZTUNhN1p4ZEFNalIyYW1MWjlhcmNYNDA3d09FMWJQTFNmQldD?=
 =?utf-8?B?NVF6TEN6SlFPUGdpSTB3dHF6NTdxSW1XODM5anRBNmJXdTVzQXhyZHpsdHg3?=
 =?utf-8?B?OGlSa0RvaXJ3RWR6OTFmNVZaN0hyVFFsek1lUlg0cG9oWnh6eHNEd1Y0TVBL?=
 =?utf-8?Q?fjnT0lG9ZNl5TlcROc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb4aa56a-1480-4edb-a792-08df4641fcc1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 13:35:33.8773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCP0P8JPYIwmhKiFW1rmmlPbPZYzqL0bYMR14XSDvQgTTtuF9J8SW2L9N17Cn7rF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/18/26 19:52, Benjamin Cheng wrote:
> These two fences are never used, so just request no fences (lock only).
> 
> Signed-off-by: Benjamin Cheng <benjamin.cheng@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c      | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index dd976a50e053..855e521eb201 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -382,7 +382,7 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>  
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
>  	drm_exec_until_all_locked(&exec) {
> -		ret = amdgpu_vm_lock_pd(queue->vm, &exec, 1);
> +		ret = amdgpu_vm_lock_pd(queue->vm, &exec, 0);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto lock_error;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 7abb9d95ef59..8b07e21d2686 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -48,7 +48,7 @@ mes_userq_create_wptr_mapping(struct amdgpu_device *adev,
>  
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
>  	drm_exec_until_all_locked(&exec) {
> -		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
> +		ret = amdgpu_vm_lock_pd(vm, &exec, 0);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto fail_lock;

