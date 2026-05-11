Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E95CD4842
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 12:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B23110E561;
	Mon, 11 May 2026 12:29:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F1R+TDIU";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012048.outbound.protection.outlook.com [52.101.48.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4126F10E561
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 12:29:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDEhfBAJ84evyXBpkF7PzAkziWUaPSlIFwhX0Y4BizJtY3vLO5/HoA1OA27oNg7UtMg7Vlhti6zu2ihzRij/HbpVHwq4pNG166jkt7h5sQM0EQ6uGkRmZqbj274QlacndZPbmQm0REtwIp3Ol7L1m9ZBdLtNVo4yZBGY9EPvzXwjUMoKeOlb0YuTRw/xlAoHpoNL/1sywdTCvO0BldmBDnoGm8kfimBkQ+Bl7L2VYDL9Y8cjqJvkQg31k8AOhdsbTniBRyeJ6JPtkuJVLeVhSQdImjAkrkSPhVgX3fnmfXRxWyqyswbATRjrtmDy8IhaDOg5rhcaQQRVIzK3qOO14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xq+1CTepVM1oWpO5vESeRsT5mm0LB2frN1ZDYodBuK8=;
 b=dOgkDPqrOHFxtQz7sY8dTzBaBijtizoW0YveEo58QyCV+VBikDx4LqNRwYPe8WSMN3PO6NjoLGMd/OovRoIacOrH1bTwelBItuafpoA8xo2Fs44YwBY7dx8Yaq/KX97+89U2mq06PaVe8LQxjZa3k28UfJe1YW0LVFkrG0RlBweNUW9WxMBz5MM5AhNKhkJRZ8gZotuHNuIhFDoTx68lnL5M45RWUsnt7ko2za95DLaEz3Ayzu3PtCpEkQZgksRzeCGbs3KZtDnNfJCnKnoIe9wjvZtZ5/j2/jUzFuJHpc2YKcjRzRqn5rM1vMOEgrdfsb585UjUUaespfmp7ZP7ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xq+1CTepVM1oWpO5vESeRsT5mm0LB2frN1ZDYodBuK8=;
 b=F1R+TDIU0HFnvtWwaUfECWMt/+tye/q3bf/+gjWU2WSUu7DENLybFJyvq+9EZ3ye5FASBCFhoMZAeL3ad1EnHNeECQzRN5VixShsOc1z6uhsByEZJjc+jidq9lyHjUgfSCxUVMfgFynoK12r5ijpDLbwFWFF4On3UXngXixlHRA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7779.namprd12.prod.outlook.com (2603:10b6:8:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Mon, 11 May
 2026 12:29:49 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 12:29:48 +0000
Message-ID: <b0ad7d53-88ac-4244-833d-0b6098a4a5f7@amd.com>
Date: Mon, 11 May 2026 14:29:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu/userq: use drm_exec in
 amdgpu_userq_fence_read_wptr
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260508103910.2442183-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260508103910.2442183-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7779:EE_
X-MS-Office365-Filtering-Correlation-Id: 8205c947-6b98-4212-e5f0-08deaf58fda0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|11063799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: J/SNuxk6fGxuJ5o/14vueYglBDvdEawGAMmyx/Jlq+cIjl8Jr/s6vyqRhfifYNlUiBsx4+eLJ3FD4HJpDuzVYDBH96AXpcS9YYgqAcnf5E/Mwc1tY/+mic5mQz+suF1ccPyLDUMF2Kzu5dzs7W6Fe/IB+gZWpwwXslgQ/I2LnCkNm3NiewrLBoSAiGp/OWem85rNbVXf6fwt8ACMTxizdt/7ni1w7nAyrPRToUZ+ufEpmDrTU+HpjcZ6rv4/f/wRVoSgMEg/yEBJ2omWnrIb0Vn8Ykql5hlZQ9NUu5Rb7eON1r0igXCDaGZ2svNjglw+EpxYnlkB8oEjMicbKaeZYRxjT3zu9PDdBjcj1z088DCsWv1zClo7v3cqihz2Sq9wOFycnTVdrz698+JDtRwsZkWoTlYrnHAPOh369gs65ZfF79skfGwKR6nHslEug/4uEKsw6tzKqf/3d/hT7fcRMgKJBMgqKlTy6ZKLVwqXHn85EUCGE53z2VGh17+F+3JZriGJ6rMCV76vbgi6ZGmv9xC+DOis42cUcg4U8y/11GvAAJIQMp73naWPCcraRT0dLilMFQYBOytqP01JSCu+3AvelmqTwtXxKx5KXXAtnCCoHzX2/yyYyKB+oXssXMsOwiFLeDXJqPGR3DIBFCYEkJtuP+g+a+uLRUDi97WRshl35pja3ts7BCJOkGOVL9ju
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(11063799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJiV0FqV3AyR3ovcGVFL1M3MnRZdVpPSFFEMHhXL25JbkY0ZHdBUE5zYTRr?=
 =?utf-8?B?Zmh5T1MzK3ByU0xaOUcyZ3ZJRE9Yd0VtOXFOVXpJTmNLcHNKbloxSFRUSWh3?=
 =?utf-8?B?WHk5YU5scElHZXpkVEo4ckVXNVpEemw0WmY5VmRFVUNocGVaZUNFQWk2dkNx?=
 =?utf-8?B?WHlQMXNxK3kxMmhMVXNNQ2hPRi92aE9YOW9SVERjR0NYQTY1RFBIUW5SYnQw?=
 =?utf-8?B?eVJQdXp1TWRRbC9uZDA4eGQ2NVJ5bFBRaHlvTFNucjY3dVRmRkhqbmhaRmhh?=
 =?utf-8?B?RElBeVpFNTI1Tm9maXVQUG8zNjd6L2VRZmN5RzBJSkdwbGNtUEdqa2ZoaGlF?=
 =?utf-8?B?RVZoQ0EyU0Y2NlMxa3gvRE83c1hUa3o4WmszS0FIL21GUlhERnFlR3E2YnJ4?=
 =?utf-8?B?dnZiaER2aHFhM3ZuY08xamhTeU9YZmwraE83c3VaNTRrUVVweXJ6aVdDc1JC?=
 =?utf-8?B?SWRJZVlrODduWldkeFRpMGUwWHVYY2cyQi9KY285SCswdUNLMW9FYjVkN01z?=
 =?utf-8?B?TStXWTZkZmNIZGt0SU4xdGtXek4yUFdibC90U0hsVDNWSWFlTGhISUdnd2NS?=
 =?utf-8?B?UXR3T0syWUticlNiTHpjWG5wbHJOSnFpYm1BVnYwZGNtVWU2RXQ3cWZ5OFFX?=
 =?utf-8?B?QnNET1ZnVzRJT2NtWWl1OGtZa1FFaEVRd09EWTlkcGtxUlQrZkhENDR5VTVR?=
 =?utf-8?B?U0Z2RjlDeXQvdElwSWJ6RGhVbHFxMXNvNDlHc1JYYWJoRmh1UUIraU5LWFRI?=
 =?utf-8?B?dnRISmRUOWJCYzg1YXVLRnl2NzZNOFdHMmxjOUk1aDdNYjRHTzJ1QmJRcDBv?=
 =?utf-8?B?WjBmTEhnUEYyc2ZBT3BTV2lEaU9MbWVKQ2lEc0RlVDhqMXZPTGFBdTdxd0dw?=
 =?utf-8?B?M1I1Q04yS0xCdm8xdUIrNkVXdGkxZlZyajJtcXhFZURPZFM4QXBQcGxoZkNT?=
 =?utf-8?B?NGdnRFlXMTN0S1VZQjRWWUR6SXpKdENEck1BRVh3RVVxQWxXeTRtOG9MVVkr?=
 =?utf-8?B?TWNJL0xxRDR6Yk5EcnJlZyt3a2ZBbHlGRXo0UWtGODNucWcvSlV6UktheUUx?=
 =?utf-8?B?dk5PUEIxOVZ5NG5OenF6TDFJVFNicXBhY0tycWZkekR2bW9RbFBwclNQQXI2?=
 =?utf-8?B?bERwRmpMTUpsQmY3VzNTdWYzeXVqeXNsZHE2aUpwOUwwMW1tY3plNHNjUjF3?=
 =?utf-8?B?ak9McE52bnhDSXkrZEdUdHNlWHhNTE5aZDFqOFNWRDVsa2g2TFB3cWJOVWNM?=
 =?utf-8?B?VnVndFo2Q0kzMS9WR3FBTXlTVmZXUGNlbGVCQVVONlRVWFFxc0tKeGpOczJC?=
 =?utf-8?B?dGZvMC9WY3Vqam5xaUFQWVY0MGJhQnE0QlNLak5pRXNtK1RsUkJnL3ZyZk8y?=
 =?utf-8?B?LzB4c2RObzVRSWRXS01wd2NRSGNUMU1JQmI0ZFlxVnJVdDRHNkFCK3dkMGo5?=
 =?utf-8?B?blh3N2dYZENLVXdkT3I3eXVuSlFJOSsxc2g2N3JnREFoNUhVejV6bHpITFVi?=
 =?utf-8?B?aWoyZmd3alZOWG9vRFVlMHdiWG5NbVNjV3JhVHBJTlhMTHBZOXVBRllPaWg4?=
 =?utf-8?B?ZHViUzFHTjVSdkpBelNRNGxYUUMyWFZIQUpxTlYrSnd1T1l6MTRmYlhRb05R?=
 =?utf-8?B?dHAxWFpaenJaSXN5TlRBZUlNUUZoaHozaHdxQWFuNmxxVE9hLzBxRk4vVlU1?=
 =?utf-8?B?M0VYWGRWckNTalVRdTBzWmR4M1FtNGJVV3haZTgrMW5OeGVuQVlQOGxGWUNr?=
 =?utf-8?B?QlhsdFRXbzNGTXM3UjlLM3Y0NHpOWWl4dzYxNmd0N0xxYmlVTHdnMkJDdTZp?=
 =?utf-8?B?NzFNSnFOcnFiM0hQMTlYTFJzZmJLa25mNjVEelFwSzBDRytZMjVkRkM2R1B2?=
 =?utf-8?B?cHFUVVFQWUxSNkVHa0xCZTN2VlVhMi8rclJ5V0pGT0t1YnVhK09zZHkyVzNL?=
 =?utf-8?B?d3RVek1rcHUzNGNJNkhQckUxbytaNGxMMCs3WVg2M210dlZyamhjcmUzMlNi?=
 =?utf-8?B?d0NyUUZYQ25IdGt4Z0F4U1I3V2paWDBpTkF4Q1d5bkdJUzFlUnV5S2FvMjY1?=
 =?utf-8?B?dUZ5Wm9kZ2dXWWZnL1I1NzRtdkk5UUVkMG1CUTZFb3M1eFpUQ1B3VWNobmFQ?=
 =?utf-8?B?YWRKcVBsb3RqdksvbUx2SUZZUVJBdWpoY2JXRTZWWlZ2VlNFekRBeXowU0hX?=
 =?utf-8?B?NmtFWVFWcHZFMi9vM083cktCRk5MU0wwNFlTYVM0QTBTYnpKeHloV3BKbDhG?=
 =?utf-8?B?eEJ5Q050d1l6RFd4VklIQjhDU3pTZ3QwWWx0RTlhbjVSelVwVzNFTlk5QW44?=
 =?utf-8?Q?H+FkBR64zLYigfDqXt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8205c947-6b98-4212-e5f0-08deaf58fda0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2026 12:29:48.5524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /+x/OSqCMbAXVJ9ul2TwRCdAj8jXlwGKhgp/c4Hk7ARFlxJ8lgOLbKQB+mwMz9st
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7779
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

On 5/8/26 12:39, Sunil Khatri wrote:
> To access the bo from vm mapping first lock the root bo and
> then the object bo of the mapping to make sure both locks
> are taken safely.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 55 +++++++++----------
>  1 file changed, 26 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 369914cab555..008330a0d852 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -370,51 +370,48 @@ static int amdgpu_userq_fence_read_wptr(struct amdgpu_device *adev,
>  {
>  	struct amdgpu_bo_va_mapping *mapping;
>  	struct amdgpu_bo *bo;
> +	struct drm_exec exec;
>  	u64 addr, *ptr;
> -	int r;
> -
> -	r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> -	if (r)
> -		return r;
> +	int ret;
>  
>  	addr = queue->userq_prop->wptr_gpu_addr;
>  	addr &= AMDGPU_GMC_HOLE_MASK;
>  
> -	mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
> -	if (!mapping) {
> -		amdgpu_bo_unreserve(queue->vm->root.bo);
> -		DRM_ERROR("Failed to lookup amdgpu_bo_va_mapping\n");
> -		return -EINVAL;
> -	}
> +	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 2);
> +	drm_exec_until_all_locked(&exec) {
> +		ret = amdgpu_vm_lock_pd(queue->vm, &exec, 1);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto lock_error;
>  
> -	bo = amdgpu_bo_ref(mapping->bo_va->base.bo);
> -	amdgpu_bo_unreserve(queue->vm->root.bo);
> -	r = amdgpu_bo_reserve(bo, true);
> -	if (r) {
> -		amdgpu_bo_unref(&bo);
> -		DRM_ERROR("Failed to reserve userqueue wptr bo");
> -		return r;
> +		mapping = amdgpu_vm_bo_lookup_mapping(queue->vm, addr >> PAGE_SHIFT);
> +		if (!mapping) {
> +			ret = -EINVAL;
> +			goto lock_error;
> +		}
> +
> +		ret = drm_exec_lock_obj(&exec, &mapping->bo_va->base.bo->tbo.base);
> +		drm_exec_retry_on_contention(&exec);
> +		if (unlikely(ret))
> +			goto lock_error;
>  	}
>  
> -	r = amdgpu_bo_kmap(bo, (void **)&ptr);
> -	if (r) {
> +	bo = mapping->bo_va->base.bo;
> +	ret = amdgpu_bo_kmap(bo, (void **)&ptr);
> +	if (ret) {
>  		DRM_ERROR("Failed mapping the userqueue wptr bo");
> -		goto map_error;
> +		goto lock_error;
>  	}
>  
>  	*wptr = le64_to_cpu(*ptr);
>  
>  	amdgpu_bo_kunmap(bo);
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> -
> +	drm_exec_fini(&exec);
>  	return 0;
>  
> -map_error:
> -	amdgpu_bo_unreserve(bo);
> -	amdgpu_bo_unref(&bo);
> -
> -	return r;
> +lock_error:
> +	drm_exec_fini(&exec);
> +	return ret;
>  }
>  
>  static void

