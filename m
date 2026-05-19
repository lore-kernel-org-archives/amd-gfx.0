Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD523CD5BA4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 12:40:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449C810E5FB;
	Tue, 19 May 2026 12:40:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="t4Yfssbr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6309610E5FB
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 12:40:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AhRD/wCsTTcKgzMfgTlqJiuNhRD35QSBqChl4gkyRRlHks6pHKbgD3q8pSGJOtbphAy+bYOPYCtIzhaMOjxaH9fWdohouXVd2JKOFDKrkLCEC83qmQBnu7DQx6gFqqbxgAgANJsbECFTEESiHvaDb7xG1vu7sQNVSBrkGoZ8epuEvvOO6AiYdAydZXkPi+vGnQzV04RHXErKWu7aQtNXrDZwB0WDuzzlkQBSUl4HeMbl+40iw9IMD3fU8adl0myELnZU1aNNvm1o57C014b3X958QivjpQnj8kaX4yFOggjETNaM8It7X9bONlGzqqqgvY40Koa758HZDiA7JnQKpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kUc+e+FiskOYhn35KekbdwDHE27HCmUR5u0MJtwTt7s=;
 b=PvsFoKthpUMC8eajRwDv9fOA1D0GbBEiV+fWfTHulLKL0yhQtAzzjukh3N5fTCgbhteD72QdxSNBh3UmGQ5L1Qz/TRykJxdKzBY3vOYyWb6BedCGUWumebdZlrjKAcPxPGg632gMjgF/7KAuqfnH3f1Xl9i2c/B93zSqGvQUMeoiy5EdtPqraQ7mlQ9R6Fk8eUl1dkUANGgDqq4ADT5InlmohCvjLUTH2q0skFWUvjK55xzxWb9nwPs3zfgsqleZjbVYz3/23I0/NIetlr6eDZJnW3rtGJMA59s9/XiVOTOKIjl5nBb9yvTjVRJ83W//GQpJ/E1Z4uKJA2OwxMCpmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUc+e+FiskOYhn35KekbdwDHE27HCmUR5u0MJtwTt7s=;
 b=t4YfssbrugKgZn6WhxVf1oLW5Ily8xqsBP5xrln+QNOB9JBICftKMm005/2xosrIinJn8t7FCGxC4Pf1VQmvWrDAmfNMWZcBsBQ3wDIEweD1+E2w/97uAVhWEWzmJCZN/vyiLLzIia4jOp9qqFU1VF8TjehVVnP1YTWiXH8rQbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB8817.namprd12.prod.outlook.com (2603:10b6:806:347::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 12:40:02 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0025.022; Tue, 19 May 2026
 12:40:02 +0000
Message-ID: <53d1d9bf-4abc-48e0-bc1c-71cb19abd0c0@amd.com>
Date: Tue, 19 May 2026 14:39:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/8] drm/amdgpu: simplify return value in
 amdgpu_userq_get_doorbell_index
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260519111801.1435954-1-sunil.khatri@amd.com>
 <20260519111801.1435954-3-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260519111801.1435954-3-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::11) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB8817:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f38880f-5108-4032-9163-08deb5a3bf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|18002099003|22082099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: 3gi+1tTDbrVS7bMgFC2WXcg+n9u93JDZPb8lEm9JY2GSptFrjeAvBbuFC0RweS1ufVspzkG19aTtk/oAXF5CIvZfHatYvX6wS4NrkO1H0sJ3s6m8cJDaSvy9opIGq08vS+xDmy59f0hI6SkTGNksWYk8AXdxrw/W0dZDMtIM6KIfD1qzd/Uo8U/shOShkSbgQ4HWnQoI6e1Ll8YTHB16mx47RAJ/KSwHRd6IBvIBDZ3wgwpFw5tMPvxRUt+TtvUmIgqi8tQYFWQR1skO3MnwjYTBvtD60iCIOIcjVpxWf/xJOL/IPCznjUVxvdLe7puhvL7o1mDHy25gAcZiiC5Q8mZLoKh6nksNLru+l6ZxuTfyZkliZ2xxJWl46X1JdtTfR8NVhNPfn7ENCz1gMCT2omHPQzy1rJttlsNviiZTJiv9BNNb0yTCH9dT0JGpVDProd/VJBL7fDjUaN6OszNNCCChVcaOzo9R+rtBbV8cl9FwrMggj8A/US8TNXxFV3G3KLBO0C9KLkaUzXWnbNama1iv7WNi7p1JJy/Ag1+FPk8Y6JR5zZ+AnTCM4yoTQewSpTKOK7RIlLXtxPA7HFLbczx+rxvmSNr7QoWKOdrs919ZJmGGetjDCGmHq8OdaQIBdRvaIhiU0s0naQ5dL5lcLHW2ghXENSynfV/zrX5Ba2TU0hg36duBEYva4EosGJHc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(18002099003)(22082099003)(56012099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJsVndWc1Q1eC94UzhFdjF6SCtJYisrSFlTR0t3dlBWNkhmNmRTdkFXeHpu?=
 =?utf-8?B?NzJ6RyswZnY2eGZsVFIvZE5LTGM2Wk1kaVV0Rm53eXJ5VE56eEZvQkNLd3RU?=
 =?utf-8?B?dUUxeDZpN0ZtV1JJN1VIaFNjUDNhTzJ5UjcrMEVkcERVcHdUcXFCempBWkFw?=
 =?utf-8?B?WjVrbXBBdjA1dEdCKzcvS1JrMkZ2c0xReHVzbWN6VDNsNW44R3dWa2xaQ2pB?=
 =?utf-8?B?L0pucDBFVVVpRlZXRmYzRGh5djhkN1FmcXlBRWY5ZTVzSVVxaXZqWEN3WWVn?=
 =?utf-8?B?YVVYQ3daTUphYmlGNDRXc0hyajFCZ2gyK3Y3QUgxblVSOWlWb1h5c0NsZ1lD?=
 =?utf-8?B?bmhFem9CUHJjRVJiZ1FEY3liQXZ3cG41UGJ4Y28wbFdibUFnaGcveWdUL3Ay?=
 =?utf-8?B?VUlNWThrRE1pd0F5c3FjOEJQY1d3OUdkMUpoWXQ3NDkxejNlb1BEeDdjRks0?=
 =?utf-8?B?TzRJYWpBaVJwNnN6SDFIdUNPWk5XOC9Oa0NFano2b0NUdUJrdGo3NU11bk54?=
 =?utf-8?B?ajVnZlhSTXBUYkEzUmxDa1dwYkphRitQd2t5UjFmaWhESUZ6cmpKaTVZaHUz?=
 =?utf-8?B?azlHVGJYY0Q4TDZLcjhxQWRJOTczZXBDMlluUE42MFRURnZRMHc4UlREV005?=
 =?utf-8?B?YlJmWm1SRFZ2a1plMTJtc3daT003aGJ6eDdLRGxNTTJSOEx3YWxBZzdHakZ1?=
 =?utf-8?B?U2JOY3lrZEJka0ZGd3AzMVZSelhtalhNUitidHFNa2pUZUpiZjUrUEpWMkJS?=
 =?utf-8?B?cGJTV1hvcmRUKzVzOC9rV3dlN0xCU3FaTCt4SWdtbnJ6T2s2UVRvNkZGM0Rt?=
 =?utf-8?B?TFpRdlRnUkU4dUdXR0x6cjZHYzIxTk5aNDJZUFptd0lQenZSdDZZS1oxdmV6?=
 =?utf-8?B?MmcwWDNvYzRvd3NYK1VqRzB4UlJMVXBjNkQ2NjN5WVZtZjBZRzRRMXJ0NUJD?=
 =?utf-8?B?QzQ5RGxTZ3EvekhjQnM5NGF1QjZTdEZwOWUzcWNKV011SFJOenJpaUFCTEhj?=
 =?utf-8?B?bUJuajNpUmhNeDVBNWVmekkvM1FZZHVHdlBVWWJlamNOdFJPUDJFb0NCMnZ3?=
 =?utf-8?B?bFhVdzlyb1JRbjVoNS9XZGxid1lCVDd5ck9GUm83Wi9VbXJNSll2NTlURVhw?=
 =?utf-8?B?RkRYb2FVbWVtN1M5aVQxZW51TXMzNkV1MEs0bmZCTFcxdTBBenpkKzFVcTZP?=
 =?utf-8?B?cGxBV2xBQ1NaeWhRdkUzdHlqVHdRRkZsTzFFWllFZGJKeUZuVW16VWplS0ZO?=
 =?utf-8?B?MytIblJyZGNuLzg3L3g5OHowTFQzUjF6NU1NS0ZVS3o3WTRNN0llcGxmWnRw?=
 =?utf-8?B?TEE0cjc1OGkzWTBVZHpJN3dYNFRiZ3czYU00bzRqUHZDaXNBOWVhcDZsY1lM?=
 =?utf-8?B?ODRncEF4Nnd0Q1BkNEZhUUJ4d0ZNQVQxZ1RCK2lsRXVpeExnK0lUNnZRT3ZG?=
 =?utf-8?B?akVUODlaR2VtdXdTd1JtYmZVaVpRM3NyUGVFa015djFaUmR5SDg0cEdtWDZO?=
 =?utf-8?B?VENTN0tlNWxVL0ZKTHVWV1BDWCtmY0lnNk9NYWJzWDZ5Vk1zSU5USUdmVExV?=
 =?utf-8?B?akUydFJJODc3ejlFR0taZ3loeFNDWVp5c0h6MEtRZGI3cldsQ1poWEFPaTJL?=
 =?utf-8?B?SnQwUEFCYUorcHBCdlF2Y2VGMENvaGp2K3hDT3FzMm02Y0daTklGWHF5dHVZ?=
 =?utf-8?B?L3EyMG1IQXpaSHZWK1lQQ0Ywd0UyTS9ReUhnNXJkdVFpRlNtUFJkY3BwMjA1?=
 =?utf-8?B?L1hiVUdOY0JwNGtYdGl4ZEdKNUJ5bXljMnhCdDBRYXFtUG5keXlOb2hBNXdk?=
 =?utf-8?B?NzVTU05DR3FVSnNNODU2T2RKdjhJN0s1ak1wN2Z4QlRSMDh0ZHc5bXQxYWZr?=
 =?utf-8?B?K0JpdlhIYVFzekVGNFhQaUNBbXRsMDhDWm5teHR4TlpkQUt3b090V0QxZHlk?=
 =?utf-8?B?WGpMbUJ5SUFoaDdrZy9kY3Zhait1UFpLam9nTnZEM2I5cWpsaCtmeStYbXRG?=
 =?utf-8?B?UTVGazMwWXJqSG1Mem9pV2RwcEdiOXlWaDlzcFVkbjlVYjM3U3lFRWNHMnZT?=
 =?utf-8?B?eUptYUZybk5QUWRXZ3poeUdHTTdORlFScmhCWVNqbVdvdDNtZmVrc05tTmFZ?=
 =?utf-8?B?MGQxRWlRMXFtQTBGbE1JcUdwVVBnbjFzUkFPYUhLM0hWczZYTGxQblBrc1pX?=
 =?utf-8?B?U3k1YjlSK2VveEtQN0g3aXIxdTlyWUVYMlBsY0oyUXlZckp2SVVlazU4TVhF?=
 =?utf-8?B?Y3dUQ1VRdit4TVNKelFuUW52dEFYejM3YU5RN2RlMEJPSDZydFJyN1B4R0c1?=
 =?utf-8?Q?6pTfAOg6DQI9E3edMf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f38880f-5108-4032-9163-08deb5a3bf22
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 12:40:02.6372 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QE+YEzDguBYP9LQlzO7ZM9gqAdxHk4u/DV+DK2EgdjuSn4SgeGYKczxhksNOHEit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8817
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

On 5/19/26 13:17, Sunil Khatri wrote:
> amdgpu_userq_get_doorbell_index returns a uint64 type index
> as well as a int type failure values. Simplifying this and
> using a int type return value and getting the index in input pointer
> of type uint64 type.
> 
> Also since it's used at once place making it static would be better.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19 ++++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  4 ----
>  2 files changed, 10 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 3bfb9ae2cb3a..0737636fac43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -536,12 +536,13 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
>  	amdgpu_bo_unref(&userq_obj->obj);
>  }
>  
> -uint64_t
> +static int
>  amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  				struct amdgpu_db_info *db_info,
> -				struct drm_file *filp)
> +				struct drm_file *filp,
> +				uint64_t *index)
>  {
> -	uint64_t index;
> +	uint64_t doorbell_index;
>  	struct drm_gem_object *gobj;
>  	struct amdgpu_userq_obj *db_obj = db_info->db_obj;
>  	int r, db_size;
> @@ -588,12 +589,13 @@ amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
>  		goto unpin_bo;
>  	}
>  
> -	index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
> +	doorbell_index = amdgpu_doorbell_index_on_bar(uq_mgr->adev, db_obj->obj,
>  					     db_info->doorbell_offset, db_size);
>  	drm_dbg_driver(adev_to_drm(uq_mgr->adev),
> -		       "[Usermode queues] doorbell index=%lld\n", index);
> +		       "[Usermode queues] doorbell index=%lld\n", doorbell_index);
>  	amdgpu_bo_unreserve(db_obj->obj);
> -	return index;
> +	*index = doorbell_index;
> +	return 0;
>  
>  unpin_bo:
>  	amdgpu_bo_unpin(db_obj->obj);
> @@ -776,10 +778,9 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>  	db_info.doorbell_handle = queue->doorbell_handle;
>  	db_info.db_obj = &queue->db_obj;
>  	db_info.doorbell_offset = args->in.doorbell_offset;
> -	index = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp);
> -	if (index == (uint64_t)-EINVAL) {
> +	r = amdgpu_userq_get_doorbell_index(uq_mgr, &db_info, filp, &index);
> +	if (r) {
>  		drm_file_err(uq_mgr->file, "Failed to get doorbell for queue\n");
> -		r = -EINVAL;
>  		goto clean_mapping;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> index 49b33e2d6932..033b8a0de6b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
> @@ -163,10 +163,6 @@ void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr);
>  void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
>  				  struct amdgpu_eviction_fence_mgr *evf_mgr);
>  
> -uint64_t amdgpu_userq_get_doorbell_index(struct amdgpu_userq_mgr *uq_mgr,
> -					 struct amdgpu_db_info *db_info,
> -					     struct drm_file *filp);
> -
>  u32 amdgpu_userq_get_supported_ip_mask(struct amdgpu_device *adev);
>  bool amdgpu_userq_enabled(struct drm_device *dev);
>  

