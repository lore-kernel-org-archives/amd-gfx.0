Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 725A7C433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 15:39:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1750E10E51C;
	Tue, 15 Mar 2022 15:39:01 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28C8110E51C
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 15:39:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ONT0UnRQ4MGeWhfjCB689Wy3m5tEfVqF/dNyUVNE8YKAbV66TOCGE/Nb77GHedmH6dUOUkyi0/efVAfNMh0wWGZh+2SpiuepM8dsdVl7KEE7MjcvCZfqrUpcbO55EffSVgDB2HcR2wpJaf49JJduQlvY0WAd+xFiUWmyneQ6QhEtf5F2BVe9KakyerQObza7KGx2rfm2Cqw3W+YBHK+6JSzxQb3nrAhbmnGsD/ZIVzvrLeW9t5E08cMHuioTfzHDlIyBA7uFsQx4tXtPVc2itnX5tUYZ3skc9RPgvWMP9ObZr722YCdUnh+jc48CXwPhYP4eKpeWeXkuqN5Dhy31nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZkmETaswMC2oyD1BR7DOI1IV/bKl2D9//Qbb0VVCIc=;
 b=gKRQdTDt0W9NsO7blZ7ZApoLy0Abmtn2CjJdVJ6vrcK/x93lGTFXdNMgE8js0nUv8akQYMbAp3qypYAIBl6gZW8941YUO5wyVZN5QEfNMKleUGSseABsYit1Z+fwbgjK0Vph4OKcaZWJDLGG9/uMK2rYOs3tlq6CrJZyvTSUzoMK8rGyI907yOMNEblqvpjFPOtwcUI2Ffc4szR51zh6+IfuxKMUXmH+q+uP3a+VQW076UFFNWfk0Ftrf+WOEUzcoRgzCkErHHFPF+MKkFTHfzgQZNvLfDjMnlozGttMB406c8DYo2KKop2zxCg0+gMe0PFBDizUPVrwjM7xgdWMyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZkmETaswMC2oyD1BR7DOI1IV/bKl2D9//Qbb0VVCIc=;
 b=2sH6rDBWjfCGZSVCPvM4AEgzEhNmOX7k/3vgKsFseFGE9feJQ++JT+lWmhaDnrn3b6qXazWlexn0IicnoHZjtg34IpYtaqq5amzwdnRRoQrVUPxoozSiYShSMLK+OrcD+bDnii0kEm8LWZTbBr+4IjvJKjkA2x0J0TFi5jWBki8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4843.namprd12.prod.outlook.com (2603:10b6:5:1d1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.25; Tue, 15 Mar
 2022 15:38:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 15:38:57 +0000
Message-ID: <edf01750-d63b-9eee-8057-0da8eebbc9dd@amd.com>
Date: Tue, 15 Mar 2022 11:38:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/2] drm/amdgpu: prevent memory wipe in suspend/shutdown
 stage
Content-Language: en-US
To: Guchun Chen <guchun.chen@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, christian.koenig@amd.com, xinhui.pan@amd.com,
 alexander.deucher@amd.com
References: <20220315075439.25634-1-guchun.chen@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220315075439.25634-1-guchun.chen@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0116.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::6) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5f6f639-6de1-4e02-484c-08da0699eae7
X-MS-TrafficTypeDiagnostic: DM6PR12MB4843:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4843AEBC114FC47844AC27E592109@DM6PR12MB4843.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rhgcs7EQzFpVGF9invqDCwkTw8VAG7eqgF6Xf9r1w6WlBf8C/KNX6WrtjNY9DvO+1olPVWl9bc4o2d3tBcfX9xpmNATZR7x2kJzgA78UTNtB5K6zGQi57FbIzyj5xRaWZiMNKzhUC17ZxsYZCGuhADOSBMcdp4IsdrvxzAGZpuZIVWdI8wDBB3Nyt0lLCKWk5dMbzCrPxUP06HeSMx/OEu1wKdB8Ogj44/JXPGgkZglQDdohylniPpsl2syeDi1UKvJzHA/d4ayu670igrk+9o6d8HMw7OgeYJDoNCpnZTu6+GGbcQ2qQSK1FhfFk5zOFCGUeAwg6IX0Ol0Ac9mfs4/SlaeZhzLW7MkI1pAocTHB9StqUSezxMMHFuM5/qWk6nq4MmGTwE3++0o1H9/GsANoFSPKy+4NS20Epk5usD5WCxVzzCQMo2+FNi7PDYY7aURvJ3779yuprfybm9RFiKOnWRCS09wivPRaPWwx5NhCVUQ6YYDam2uVRCx9idlyqWUOnCvTXYhdZV+nvKZVXzzJPOsbovVNw29LdGT4zz9FUsWYrM8ymSC0TTDjh9Qy0rDQ5NSc+dxucytrLtoLNYfvbGofU6CT3q1/00C3zPGzeCXiVMtuYJAUQWkWi2lpYUOR6fIjjBfF2YJt0gExl0ExchKG8r82kB+xIGw7Jnpmo8cmlPWnT2KLurWu+//uJ6c02QK7g/he2wy+HHuJOlnrqYZdrAdYSuYcsNrzOSTMFLpe08KXApzUnJqSI4uZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66556008)(66476007)(38100700002)(6506007)(316002)(508600001)(31696002)(86362001)(8676002)(6636002)(6666004)(66946007)(6486002)(66574015)(83380400001)(44832011)(15650500001)(26005)(186003)(8936002)(2616005)(31686004)(6512007)(2906002)(36756003)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE85MXFrdjV6bmNpcHZOYjc1VFFOM0d3d0VNYzFrdVZDMUh6d1JndkE3MDVY?=
 =?utf-8?B?UWYrM0w0dVl4TUI0R0s1ZkxKVkc2cEtiVkxwUGk5cEVtMlhtMVg2WE1WK1dY?=
 =?utf-8?B?TkVUS2h0UWhPNVUyVWNuL1praFdwQnNXYnBmU2NOMGdnL29LZS9GWm1NNzBl?=
 =?utf-8?B?MUgrYXdXdnFJQnNtdnhpS0NqaCtIT2E5ZWh2eFVpWU9Kb3Vja3Zqdm4zdWZH?=
 =?utf-8?B?Q0JBeVVwLzVobTYyUFF6cHR4WGVNdzdZNFNYRVlZc25DWGpuL2FYb1Jhb1NS?=
 =?utf-8?B?eGxPRGNiYmw5N1ZyZ3BiWFloWDNNK3BDTjVHRVhtRUV3Wk8wKzF4OGx5Z3NU?=
 =?utf-8?B?U2cxUXkzSEpKZ04wZ2d2akpJRHJ3TWpqTmtsU0FQRVltVjR5SmFFNDQ5cTE4?=
 =?utf-8?B?eEl4YnltZzEvNFY5b3F4aG1MT0Z0UXlEa1E5WUM1dVZLNXZ2b0lMK09Nd2ln?=
 =?utf-8?B?UEYyN2xmRGJUWkkzbmdiMWp3L21hTVhZVisrMkpLbFF2b1FkQTRxMmhXZ3pO?=
 =?utf-8?B?NVZBMTN6Z0wwbFpoYnJObHJqT2cyamtWNFRNaU5ISFQ3THBUeDJqT256Z3lW?=
 =?utf-8?B?aklQU0lLWW1SbmdOWWNJS1ZRYmJmRWh5WUxhY2k2UVFQNnYyZStOK1Z4Qytm?=
 =?utf-8?B?S09rdW9zaTBJZzMwZnZrclhsMVordGZLQTg3SXlNdDlBUkNjOUlkTVpka2cr?=
 =?utf-8?B?eVQ4Y3ZYMjZZZis3Z05uS25pK1JjdnFLcnY5blRKQVVIQnYyL0RlTHNYcUJn?=
 =?utf-8?B?b21hY0RWTDVYbkNka21WUm1NS2c5Unk3K2ZicHF6Z3I4TDZqSEpNb3VkenVm?=
 =?utf-8?B?aGNFNGxQRzcvTEhsOGpzMGlHRUpZMmJwcE5ycnZoelY3cG5rZ2FINzNUL0Z5?=
 =?utf-8?B?RW1BZFJ0bkphc3lqa1VyOXdqeVlBNnc5WXMvMWcwMGN5Uko4UEZPRVBZSER5?=
 =?utf-8?B?VzFrb1pFOSt2L0JINys5YllZRUl2ekFsVnV2cUkzZmpSR3orNHNIUnB2bk1r?=
 =?utf-8?B?bzR0QmZZRDJlT1dPOVZRaEp2T1gwTE9zenNSZDVUaUVsaER3U0M0RjhxSWFM?=
 =?utf-8?B?cUdjbVNuS3dTU3gvS3VEc1FDR1dnQjgwWGRCUGJxNks4WmNPTXQzWXlpWk9Q?=
 =?utf-8?B?ZjAvdHh2dEUyaTd2TmNPZkVLd25QV0Z1ZldvY1hwZ3RvV2FyeXcvMmJqaXRp?=
 =?utf-8?B?TFRoTlFqY3N6UWdmSFRNeWZoTmhrMkh4ZHk3U1N5ckRnc3Z2dVJYR3Rtc2pB?=
 =?utf-8?B?ZW5oUDB4WkZITDFYbGNzSnRjdXRkZE8wWjY5eEszYnc0eGhsQjEvd252eEhI?=
 =?utf-8?B?UHAwWWsxSnVKY0drSjJQNTlvTThLd3NhbkNWZHBxbUNCcklKdlI1ZkVXUXFq?=
 =?utf-8?B?Q1F2T1prV1FlWnRlMHFDbFZLQktPNlpxa2dlWTl6UEE0VFhnTW9xZ2F1QXZC?=
 =?utf-8?B?Rjk2SVRmbUFJdTN2TjdTbm1ta1kwT25rYmVRSFVKcERvNnZKMzFOMHVqcGIx?=
 =?utf-8?B?aWd1U0FneEJKamhXbzd6WHFFbmRPVHhQa1FhdnRLSHdOZnVpQzdub1dML2I3?=
 =?utf-8?B?U1UxcEhXUHoyWFJYeWJsQkFoT3VlR05DRWZhbTRUZXF3aXpnMUdFbjZKbkhO?=
 =?utf-8?B?M3FRTFExd3RkOHhXLzNNbW5CazhNM1FlMTZtWnpFUldtZFh5R2FDd0tDOEVX?=
 =?utf-8?B?Q2FTeldpbmR1ektFZkhpdFNuNkNQbVZXYXFxYi9JZHZvREI0aEcwKzVpblYw?=
 =?utf-8?B?dTdJRWtLeHE2SU9kWWRnUnlFT0JlUXI3QlNwSHZuRXFsNm5Jd2VOWENSQUYr?=
 =?utf-8?B?eDhITjZHRjhrQWFudW1HNEwwSGxQbURyQXVaTXV1dnRkL2s5R0tHWkZiMEkx?=
 =?utf-8?B?WTRGWWJDUkZSUmRER25JcUtmdjR3SWFwdk5LNkNKUWdCcFVuU1ZnZlhiSlJv?=
 =?utf-8?Q?FR40EE+moyw6GVcEUMQUkQ8WBMMu4jKF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5f6f639-6de1-4e02-484c-08da0699eae7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:38:56.9009 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gFcWjc4gakCfp9qSacM2f7ngOL2TuFYjqnk65/cOPObql3ZjJc6wSQJX0wgp8QLnTMwZrUFGP6FmMILRmegwQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4843
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

Am 2022-03-15 um 03:54 schrieb Guchun Chen:
> On GPUs with RAS enabled, below call trace is observed when
> suspending or shutting down device. The cause is we have enabled
> memory wipe flag for BOs on such GPUs by default, and such BOs
> will go to memory wipe by amdgpu_fill_buffer, however, because
> ring is off already, it fails to clean up the memory and throw
> this error message. So add a suspend/shutdown check before
> wipping memory.
>
> [drm:amdgpu_fill_buffer [amdgpu]] *ERROR* Trying to clear memory with ring turned off.
>
> v2: fix coding style issue
>
> Fixes: e7e7c87a205d("drm/amdgpu: Wipe all VRAM on free when RAS is enabled")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 23c9a60693ee..c712d7f5e8a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1284,6 +1284,7 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
>    */
>   void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   {
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>   	struct dma_fence *fence = NULL;
>   	struct amdgpu_bo *abo;
>   	int r;
> @@ -1303,7 +1304,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   		amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
>   
>   	if (bo->resource->mem_type != TTM_PL_VRAM ||
> -	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE))
> +	    !(abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE) ||
> +	    adev->in_suspend || adev->shutdown)
>   		return;
>   
>   	if (WARN_ON_ONCE(!dma_resv_trylock(bo->base.resv)))
