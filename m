Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFE6FC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:58:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D15760FDC
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 14:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D15760FDC
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06DF06ECE6;
	Wed,  6 Oct 2021 14:58:25 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A82326ECE6
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 14:58:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZKW00joOdWFCJ2GhUHedfOsBjf1vQN1QPUTUeLUj820DpUPtu3NTLmJE/Q9h4R7eM5BUEzuaFSCjuegoYJPtKO3eS+EaEj8sfpMueWd0mh/TWUfpqGfvIWedi4G9K9NLQaJY5y8wVQJVoyY2rQvXe/W6GKMG0JcM5lDDomQhg6d24pTxRfi1LjLZNe10ckIrj5UaDWBzbQfu74pgfjfIx34pdO2BBONkJHIA2fNNORAMMszRj0rMuoFFNfmKduEKS/oHiGU5/7uHHZKauJp4divVzq5A5E2/2otRCNXJqmi3gtjQb0gXlrNUlUQDW9M86IB41KbprpJeDCYlZjjuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chFVtM/I/xzTBG7axw10uULTpnB/krrlrY9vV87LkVI=;
 b=atlwcjFgFGj8sj+slq7amtLdT9Kudp+QaxxyxPAA3/E0AMhF966Y184dQoY+Zr/ZXH+irIS8no3++DFUAKOOZTNVy5PROk68sJ3Ey3OnNXjj1HXv+TYvTSK+5+UnQVnTFQebl2tQeYOiXyRnNai/wnrJc8lwlmtleK5dhFVsOYepljnAsBTiw4ewFSO1hkLMN0HZd3HdyJny6jvojMGBSiOeTtQXCeg3bxfiRbpP+gzyvAJSS0TTMLaFoCA2caDEn2xBgiIRa6LFIFEJFAWwMkxXe8DpY73lHjiGx7YXTsD8c/iv0La2IzvluDA82gy96hYmn4gyfG/JDTXPiMYIxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chFVtM/I/xzTBG7axw10uULTpnB/krrlrY9vV87LkVI=;
 b=yJEwIDDSBptez93FMjYS7waeKMXtizbIk0tW6ZTFM2j0KdjQ6WOOcJrCQXg1ea77aFK3xX2MQUJI3DSs0oCY8XbiBz5YaKB6LYyE8inH7X4IdsxlkdgQ+mr8bnCZFc1v8RsZTPj35/vXqMqv3JH3atjIDYMfniRmyXPTwXZuQPU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14) by MW3PR12MB4410.namprd12.prod.outlook.com
 (2603:10b6:303:5b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.19; Wed, 6 Oct
 2021 14:58:15 +0000
Received: from MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a]) by MWHPR1201MB0192.namprd12.prod.outlook.com
 ([fe80::55c7:6fc9:b2b1:1e6a%10]) with mapi id 15.20.4587.018; Wed, 6 Oct 2021
 14:58:15 +0000
Subject: Re: [PATCH 1/1] drm/amdgpu: add and use amdgpu_bo_evict_gtt
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211006144529.61208-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <631488c1-9ae4-ba4d-b825-999bef07e5e8@amd.com>
Date: Wed, 6 Oct 2021 16:58:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211006144529.61208-1-nirmoy.das@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR0202CA0006.eurprd02.prod.outlook.com
 (2603:10a6:203:69::16) To MWHPR1201MB0192.namprd12.prod.outlook.com
 (2603:10b6:301:5a::14)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:9a36:299c:ad6f:f465]
 (2a02:908:1252:fb60:9a36:299c:ad6f:f465) by
 AM5PR0202CA0006.eurprd02.prod.outlook.com (2603:10a6:203:69::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.18 via Frontend
 Transport; Wed, 6 Oct 2021 14:58:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62292111-b5e6-4117-12be-08d988d9b9ae
X-MS-TrafficTypeDiagnostic: MW3PR12MB4410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB44102E8CB371D5AC701A0DAA83B09@MW3PR12MB4410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZkoNj0gXolpTeFv6M5WsiqtslZ3Dgh4KxOXRiQUpCpNAZrF24A3CqnARncaLLZMfQe1X7m5GxRnqmfvefjpR55AdEagtlMB7FK/mRFe+8mNm97pcmwfGWSnw5tE3Kx/vkj593HGvqexk4+HNDr6wicbvPgbZGPYfbpLnu9dMTGLV+KVdSWPsIrehJD+nvSXj0H4ePWWKrHT2dftYp9VGCr9UGUCidHTw/1eZqqCwGZ4/aVYBNpgxxWvVxYAFgV6JND20LN2tdADeBPAAhB+T4Zh2ODMN+vZ4zTSi7BCy7xxKaoU31MleLvnqgcvtiD2/irkggZi+oO0JSS0AQTBhj+kT9YyiOpBv6JYyqns26+PLrXW4ydbUQrkKJWJN3S8h0uf6coxvsK4T14T3qunI49IDY/trLQTN0Yb3u+CEyjAjSiYSRy84f5/kdgGwuYFTA3CzHBavVxgb/p1uqDrn3iJ9GyP3NVgCRasS4RwTm1wGMxySakugOK0wsFD/ymMr787WWF4WwGXRi8jwyBICUR/j7qB9ZHK1U2Pqf6HbUeRHlPlf0+07fDChYimSIUK+MBTjfv3JIlWOt39OnQeCYGXBBk0jWOD9nfYIbKnQ+PmJP5b8jQBiESDD5oMScsodVUO55/DIDfKqLSMOU3xdL/VjL91/I6BiilDaeVF2YPqtTF8JVzdReJe8MUr0aLjOlduDlg35d4MmFfoL/lKtsmNmirH3fK68BI5fkqJrlU0bcp0n8VNUOi00JUjK6NZi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR1201MB0192.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6486002)(186003)(5660300002)(31696002)(508600001)(31686004)(6666004)(316002)(36756003)(83380400001)(66476007)(66556008)(66946007)(2616005)(2906002)(8936002)(8676002)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUJxbmczR3lidVI1eC9HVVBES25xNWFVN0NBbjVTMEpUdXNrMnM5TTZCNStm?=
 =?utf-8?B?Rm9HVml5WnZSRndJTXhRckVuaW5vVlcyYjFabzJTUTlxZnl2WXhLbFNrZVlh?=
 =?utf-8?B?Rk8xK0xZa3JvOXQ5NzRHQnQ0N0pYbWVqZGZscUdma1l1aEs3SldJbGZSaEZl?=
 =?utf-8?B?Y1Q4OURMNlBrMmprVCtaMy9BUHR3R2FQQjBLTC95L3NIRXFWSnZtTEdORzR5?=
 =?utf-8?B?dFhoemJIK2l6NmpZeitKQy9PWE9QQXFIOCtvR0RobWNBL1U5TXpJcVhQRFRW?=
 =?utf-8?B?SDVhTXFTM1A1V1d1dm5Tbmt6VE4zdzNaWU9qdlR5OGJIaGp6cFZ5bnlMZm52?=
 =?utf-8?B?WDlVKzZ0RGlQbGxQRmlrd1Qwb3h1Wk5DZGlPcjcyQlBVU24wKys4Zzg4aTZJ?=
 =?utf-8?B?M3J2dDhRdTg0Sk5NNHNVdm9BSjdqNG4rUGdoaW45L2NQaEVJYzJNT0RMK3F0?=
 =?utf-8?B?dGo4TWhqcU5qaEdDb1paaUh4VnVqRjF6NEhxbGk2YkR5aFNXNXVxcm9nUGVo?=
 =?utf-8?B?SEZFUW1rYTJIMFdzTDJpYnVvWHhTMjg2WjNnY0hrK2MrbzRmb05xbTdjbFJl?=
 =?utf-8?B?a0FCNHNjdVJDVm1BOU5MZUpqaWd0SEtxbEVxRVhqVzh2MC9IVXowRlRsQzh6?=
 =?utf-8?B?dVJlR3dCRE4ybkdqN08yMGs3S2JYNTh4TUg4aG9sMDFYV1N4Uk1Ebnhxd3Vy?=
 =?utf-8?B?UWl3b1R0ODhxbVNqS0hSU0grSHY5eHNzYmlPOVd0U2w2alNMdmZWVXhFeG9o?=
 =?utf-8?B?cldXckZuNE8vblo5bzgrZGN0bmRYQzdGd0pTUVdkd3YwNTh4WUl6bzFLdldn?=
 =?utf-8?B?UGlSUUNvWDdPN25PbG10S2FYMmpKTm9iQjFKNXdEbDZ0b2dMdXl5MGVUNkl3?=
 =?utf-8?B?d2VhMzdiTXhuNmVGeStoRlVCVHNuQmY2aHI4K1JnS3JKWlFPTlpzM1BGd2s1?=
 =?utf-8?B?ZHBiN00xOEx2NWRhUzlzemlFalJJMGgzemY3cjdCWHlaUmY5L1JVRS9rcHJ3?=
 =?utf-8?B?NW5ySWhBR2t1QVlaQ3gvTi83dmI2UXMwb0RpeFo2b2Z5RmxIZlBoRHMxL1RD?=
 =?utf-8?B?bWRPNXAzZnFGMHlkdm5ZcjVVTXljc1NSaUlTTHBiVUxFM05jdXlOMzNTaVpl?=
 =?utf-8?B?aXZ6MndlNGxmSkVjVWhCM3gxa2pRa1RzQkZUNGVjaVBxOTkwSnVRdlB4ZXIr?=
 =?utf-8?B?NWMvUjFaVmFubjVsb1FzWHFIbWxDNG52a05LT0h0aldKL0NERFR3N3o0QXVv?=
 =?utf-8?B?ZnY2aTIvZk5UZytRTzA5K2I3citRTnRVdi9UMTJmQjNrd2tiKzFVQlNIZmVn?=
 =?utf-8?B?SXJNcFR2aG9RTDBBZldtNWg4cUhvSWY0WTFKVFRBREtBZG1xQ3VZOVRPaHg4?=
 =?utf-8?B?T2x3dzBTNXdtakJveG9VZ3dIMTY5V2xMWTJubkRmdHNMZ2pvMHFCNVZjOVgz?=
 =?utf-8?B?RzBFUXREVTIyemVxcGRuU1h4MVZSTm5QZExCY0ZPQndtUnFYaHhaOE5hU0Vx?=
 =?utf-8?B?R3hFeEVqZE5kUHJKMCtJZmhHbnVRS0IwRWtXM0J2bjc2a1Q4OFJRK2oxS1lu?=
 =?utf-8?B?ZElMa0xSQm95UEdHOGl3UEptSDNUU2FNeERyYjVxN3JFOTdsTDE4b2Q5OU9O?=
 =?utf-8?B?dEc3d0lsUDJEa2cwaFNJbnlzcnlsUjFnQVZBc0FQcDduY2FNcVU5QjlIbUJL?=
 =?utf-8?B?bUYwdnkvNHQ4TkJ4ZjFTa3ROMm9sekN2RWViK2xORStEVmJ3eWRoSFhHSHRp?=
 =?utf-8?B?U3V5dmdXdFJYbktTR0M5bjlENGJTczdENXA4RkttbERYYnpQeDNwNWp3ZHVr?=
 =?utf-8?B?RjJWQUxRWkNLTWFScFRDdm5hS1BoR2VZSnJLK3Y0Wk9Ha2M1Mkx0eDE5U2dB?=
 =?utf-8?Q?7NWzszKEk+4xe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62292111-b5e6-4117-12be-08d988d9b9ae
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB0192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 14:58:15.6308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B2vRM1d/aieMBZJEkp27+i+8VeqsyDQfYV5pZiIrPfw2/Z8G7Ur//AUGzbE6a/FL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410
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

Am 06.10.21 um 16:45 schrieb Nirmoy Das:
> Unify BO evicting functionality for VRAM and TT memory
> types in amdgpu_object.c. Use amdgpu_bo_evict_gtt()
> for evicting gtt memory similar to how we do that
> for amdgpu_debugfs_evict_vram().
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  6 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 52 +++++++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
>   3 files changed, 50 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 5497e2d31d1a..67045983d63d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1341,17 +1341,15 @@ static int amdgpu_debugfs_evict_gtt(void *data, u64 *val)
>   {
>   	struct amdgpu_device *adev = (struct amdgpu_device *)data;
>   	struct drm_device *dev = adev_to_drm(adev);
> -	struct ttm_resource_manager *man;
>   	int r;
>   
>   	r = pm_runtime_get_sync(dev->dev);
>   	if (r < 0) {
> -		pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
> +		pm_runtime_put_autosuspend(dev->dev);
>   		return r;
>   	}
>   
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> -	*val = ttm_resource_manager_evict_all(&adev->mman.bdev, man);
> +	*val = amdgpu_bo_evict_gtt(adev);
>   
>   	pm_runtime_mark_last_busy(dev->dev);
>   	pm_runtime_put_autosuspend(dev->dev);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 4ec904f36ceb..3b8c9cf44d74 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1005,10 +1005,37 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>   }
>   
>   /**
> - * amdgpu_bo_evict_vram - evict VRAM buffers
> + * amdgpu_bo_evict_memory - evict memory buffers
>    * @adev: amdgpu device object
> + * @mem_type: evicted BO's memory type
>    *
> - * Evicts all VRAM buffers on the lru list of the memory type.
> + * Evicts all @mem_type buffers on the lru list of the memory type.
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +static int amdgpu_bo_evict_memory(struct amdgpu_device *adev, int mem_type)

That function should probably be inside amdgpu_ttm.c instead.

> +{
> +	struct ttm_resource_manager *man;
> +
> +	switch (mem_type) {
> +	case TTM_PL_VRAM:
> +	case TTM_PL_TT:
> +		man = ttm_manager_type(&adev->mman.bdev, mem_type);
> +		break;
> +	default:
> +		DRM_ERROR("Trying to evict invalid memory type\n");
> +		return -EINVAL;

At least in theory we could do that for OA, GWS and GDS as well.

> +	}
> +
> +	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
> +}
> +
> +/**
> + * amdgpu_bo_evict_vram - evict vram buffers
> + * @adev: amdgpu device object
> + *
> + * Evicts all vram buffers on the lru list of the memory type.
>    * Mainly used for evicting vram at suspend time.
>    *
>    * Returns:
> @@ -1016,17 +1043,32 @@ void amdgpu_bo_unpin(struct amdgpu_bo *bo)
>    */
>   int amdgpu_bo_evict_vram(struct amdgpu_device *adev)
>   {
> -	struct ttm_resource_manager *man;
>   
>   	if (adev->in_s3 && (adev->flags & AMD_IS_APU)) {
>   		/* No need to evict vram on APUs for suspend to ram */
>   		return 0;
>   	}
>   
> -	man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> -	return ttm_resource_manager_evict_all(&adev->mman.bdev, man);
> +	return amdgpu_bo_evict_memory(adev, TTM_PL_VRAM);
> +}
> +
> +/**
> + * amdgpu_bo_evict_gtt - evict gtt buffers
> + * @adev: amdgpu device object
> + *
> + * Evicts all gtt buffers on the lru list of the memory type.
> + * Mainly used for evicting gtt buffers through debugfs.
> + *
> + * Returns:
> + * 0 for success or a negative error code on failure.
> + */
> +
> +int amdgpu_bo_evict_gtt(struct amdgpu_device *adev)
> +{

I won't add a wrapper for that. This looks like misplaced and overkill.

Christian.

> +	return amdgpu_bo_evict_memory(adev, TTM_PL_TT);
>   }
>   
> +
>   static const char *amdgpu_vram_names[] = {
>   	"UNKNOWN",
>   	"GDDR1",
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index 8ff61bad4138..5e9b7710b8e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -306,6 +306,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
>   			     u64 min_offset, u64 max_offset);
>   void amdgpu_bo_unpin(struct amdgpu_bo *bo);
>   int amdgpu_bo_evict_vram(struct amdgpu_device *adev);
> +int amdgpu_bo_evict_gtt(struct amdgpu_device *adev);
>   int amdgpu_bo_init(struct amdgpu_device *adev);
>   void amdgpu_bo_fini(struct amdgpu_device *adev);
>   int amdgpu_bo_set_tiling_flags(struct amdgpu_bo *bo, u64 tiling_flags);

