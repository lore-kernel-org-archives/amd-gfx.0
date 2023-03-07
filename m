Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30ABC678D5
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Mar 2023 07:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0188F10E371;
	Tue,  7 Mar 2023 07:08:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::625])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C27D10E368
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Mar 2023 07:08:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRsepzd6Vhc4/x4m4RWscPytDItnbutwOq9nPeVqec5MbXslpl71URSySC29yDx/Qckgfmg0CALME2ci1TRqeQ/871PL3K8ZPaVypB4GV6e+6vn5tY7QsGBsb7z0oKrWE+6cqOf/n3CjpP0zTpkibXeya2+kI7sdJkAkKqD4zCHe4X+j8gXgNgPXCTVZn0qUAQvIaWuUq2tOMD7f6REcTW0/zHdVv6Cjm5z55bBs24I8Op81Jqn4/2dZc56jmLj/AnpN5V2W+36/gWypM3uaM2geFytf3aCjYaSDC2MUi/yVgS6E9XZn/e2z6j/0kI7nbiG3McXfkCWFm423YlnWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IoJydGSt6J4bm6At43qNo26/cj9H1VARFkvAEJ4u0gI=;
 b=PkqOoeUA7s6HBsvVyw5TmAUPwSJS38QG6izOkyyBqx22XoTCcsGIH3RRQZnKyML6KtJmWsoaOnQ41JG6KlX+I6AfxaUiZxbOI72ftYW5unNj86s40QdsRhttCLyz/eTFXqZPluqtjK0CN0GfMdeeGB+W+lRByRarjBRvKx4afgvVV4oGws1+/UV2t68hB6lPO3Iu7tuvj0kTpk56UcbaLbA6Npu/NiPocXbW/pYE4gEKsPmVsIt13Dc8n2+s0ObO9YauHpGD9bW9JyAj7okZH7gW8rwA45CjVBihQG4u+UOk4KSKbHl/4mFxfvgqMdX0/MlaDTXMtSm5j+Z3ZGuMYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoJydGSt6J4bm6At43qNo26/cj9H1VARFkvAEJ4u0gI=;
 b=Mq3/zlHr0k6IGUhhKH7EuCto9u2jH1tztHn2IpsXlOs4TNooIBpDUyudtqNpaamM9Rnz7pL5ePo0lCC0n7w10rF1RnAVsWXA/uS3g/v5U8d5RM8J4IwS5C4esqWONWn7NkrTjpQhlT11eEiUHPj0S2X8LHby7p2HQkz1X1l1wOc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MW3PR12MB4458.namprd12.prod.outlook.com (2603:10b6:303:5d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 07:08:02 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::d23f:bb1:df95:3918%4]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 07:08:02 +0000
Message-ID: <a38e637d-2cd8-caa0-e27f-4c9b8dc101d0@amd.com>
Date: Tue, 7 Mar 2023 08:07:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] drm/amdgpu: Force signal hw_fences that are embedded in
 non-sched jobs
Content-Language: en-US
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org,
 "Tuikov, Luben" <Luben.Tuikov@amd.com>
References: <20230307070231.3807549-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20230307070231.3807549-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::20) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|MW3PR12MB4458:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eff0c01-50ec-4e3d-ecdb-08db1edab10e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CgAojYhT5KTh1hUgK5Hj8TWtFpQzDHWKWMRUNzgjau0AHloBOCORazOn5wRlqkDRaI7w47K3uWtwlVeB7yWVhekLlsuKy2U3zqCgxPzOepljEzU4JqXKIgQHpNbg9JjPLmGU5oDpE2M294Pfa5ihvkRTum8IjOaWAM5+VKjpqPbK4PV+c4sZufwdZQESdPUvRAOVpqDGSCbh/U6GGreOCKTLj2eWMIj2dnJbCR9btOGqNk9ABIrrnUz6ReRpZmVoKRT/MScq+5W9ik0u+ZbaZt3fA64QKAW3hNxHXzU4er+Fe7yzYBnz1/44P/EH4RE3uEl9EwetHe682wextPreKLhsQzYKbjYRxqsqTGGHtz5wDxzGunHK6ilowTRvALDnmfaZWOGgdB6w4BE4cxuj3+VduR77bHuXfj+khd8CCfKSAIEW7UUIdSF+LJmaMk31yXbQk7QZsT/SGFuyaGYd9JhJGH+Fi6jnECA2p2teI81Zunpg2TvbuL5Q6o8sFBBZJ15mGpN1eU8Q5keRzhyEZGALJwuJdChv0s/Hm4/9rz+zDQausRqtHkWzRXIkw1U2tV2tFX4IUugVWhF/a0aoOa3f8ojilKy8hPR9pvO8d0VZfkc0wZiPLooX7MbKLiaouKpBzOhQU1sKiozwkhsVFEjV6u5YPL1qoPm4xr27g8UMxzyAx1AZM11fCXBgxTqn4TejVY5Hb87am+1+AckhLX+RSH83tEDkIWg9GsUDWu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199018)(31686004)(5660300002)(2906002)(8936002)(41300700001)(4326008)(66556008)(66476007)(66946007)(8676002)(54906003)(316002)(6636002)(6666004)(110136005)(478600001)(6486002)(6506007)(31696002)(2616005)(86362001)(186003)(6512007)(38100700002)(36756003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXpqeFZKOXZmNkpVRU9wZVNLMXpWOHZDbWx3UGJrTGl1YjdGTkhpdnpFMDlG?=
 =?utf-8?B?SWIvSlpvTDc4bCtWTUZYQnJJaXg0V0xvY2xBd0pxSlV6a2N4RWJYdVk1d3Fh?=
 =?utf-8?B?OGVhcmN6d1hEc2JjMURydG1lRFJJZkFUaTdpOElQeUhRZGVzTFg0OWUwd3F6?=
 =?utf-8?B?SkMzcSs4eVhoSXg2LzkxVUt4dHRvUVY2TjRyczRNaU1oZDA2MS9EY3NERjZu?=
 =?utf-8?B?YnZ6b3RZb3BlZGEyeHFNdjJ4NllPUkRMOHI3WlkraEZpVnVkcElyeXlHUFJL?=
 =?utf-8?B?THo5T2FzcG16eXpCUkFzdGRiNmdOQ214Lyt0WE5WekdSd2NlMlNjczBGYUF3?=
 =?utf-8?B?WkY0OGxERjJrZVFRMkdMMkdOK0lGeTR6eFdVVzhXQTRlckRKNFdiWlk1QVZx?=
 =?utf-8?B?eHVzaG51RGFSVHY4RVJGVzZPWDFRZ2E2ZUZYWDdKYTFjNG5YN0ptLzhBc3FU?=
 =?utf-8?B?QytqdWxETFAyUmdXY0o5S25aeFVpMXVVY1BLMVBRVGRicEVKQnhLa2ZCM21a?=
 =?utf-8?B?L0g3RlFDZXJxU2h0a05VVlRBL0Z6WFlRU2hjWXBMWnJKeDJvMllqYmgzWGYy?=
 =?utf-8?B?TFdYd2lnT21MRFlReXU5cllRNTdZT1luNEo2RG5vR1d2WTdhWFpzOFFCcGln?=
 =?utf-8?B?SW9lMCt2aE1WNGlneGZqNE5JRURuN3o3d2czOUVoRmlkaXZUeVA3ZlFnU1Zq?=
 =?utf-8?B?VG42UTB3TjJhSHduVWsvdWFFVWRtOW04cUl5MGFFTmw5K2krNmg4b3FBMUd1?=
 =?utf-8?B?VWlFbGdHM2QwVmpmdmpDUUdja1RXZkdKYTdCUzlmTjJGcnBFSUQ2ajRxbkhj?=
 =?utf-8?B?L0krdm1Gbms1U045ZHE2OWwwNVVMWENIM09YRXAwNXcxNWkvU2Z0VXpmRW84?=
 =?utf-8?B?MWRwNzB6S0ZldFFNQVhVbXFnS01hazRVWXFEQklQRmZrT045bGFOS3E5RUxv?=
 =?utf-8?B?dGg5TFZ2aXlnUHVlSFFDZ3B0LytxWlRHSFhtQVF1YmFjUG9pU2FESTBDWFd5?=
 =?utf-8?B?b1VnTDdMMFV5M20rNDBMcHBPczljODRLZlVNc09DbGNnVjJkM0RraTFuQTcz?=
 =?utf-8?B?Sy9aZEw4bUltQXh3REpkQXRRQUk3SWFkTDJsVGI0ZGdxd1BBR0tFajhWNC9L?=
 =?utf-8?B?STRvYmJQY3FEQm1ydERwalJDWmQzUFNOWFRBbSswZUxJbXdGb1BEcDhQQ1dV?=
 =?utf-8?B?eDBmQThXbEl6NDVwbktmdC9hLzBVUHcwNkhHdGQ2eU9Dd0l1SjMrNTh3aG4w?=
 =?utf-8?B?aUFodjJRUDFPWVQrYkZPMUtIRTdEYXNsR2s4SkZFeGZyQmcxS0p2c0FaMm9D?=
 =?utf-8?B?aTVHdmd4Tk0zbktOdHdTM2sxcjk2U2w3L0tlQnNrZWxmSXRoSnpvQzhJZERn?=
 =?utf-8?B?SEltbnRmZE84NmV3TmtxZ0g3ekZ1aFV1TDRCMWtYbDJkZlZkejFJZTRiMjJL?=
 =?utf-8?B?SzA0L3QxZTQwME5kQzdwMjBneUJjL1dwaFhkU3ZsTzRjcG95Z0JXUUxKRDRB?=
 =?utf-8?B?WXVvTmRjdGZFbU1GSXR0b1Izc0tTdGsyc1ZzMGtkMGFVYXRyVEZlWmxVUE1y?=
 =?utf-8?B?UlN4Mm5sU3RBSjdBUDNnTE9DMThmQkwrR0UwL2ZGZnB0anphZGEwdU45NTdl?=
 =?utf-8?B?dnczdm5UQk5BcG56RStwWU51S1JzSWFHRmZVa1IzcGl1T2IrSlcvc0lLd3RH?=
 =?utf-8?B?TzVseVhIUiswYjJmcWRFek5rL1B3UFhrQmRhcFM3amVKT000QUdCUm12Z00y?=
 =?utf-8?B?T1ZCeldQcXBUTUwyTkUvNGw3dGtNTlJvRWVUNm1iYlR5NFpEd3NYc1BkMVlt?=
 =?utf-8?B?QVE4Y2YzRVZSMlJqcUZ3b01mL2JUbXZSZVRuWTdzdjFxNXR4R2tTUUhrMEhY?=
 =?utf-8?B?bVZYc2xySGVMcEtTWjd0VTdUTEZBNTFPa09ZaCt2SHF0WWg1QmZjMk83L2Za?=
 =?utf-8?B?SGZtWmNMejZHZytrSThRUnFUZGJOVVFNako2WHRDakdxalp4RjJ2R3gwTURt?=
 =?utf-8?B?ME9NeWRpUFZ0SEhYeFFFU00xcC9EUWtxd2JCSzRORzRjdEtsQSsxcHNWVVRB?=
 =?utf-8?B?WStaNUtlRnNFNkwrTDR2WTl2MjJMNzh2enhUTkFkaXE2R0V0czFTd3R5Szh1?=
 =?utf-8?B?R1hGQnhRK1dhQjlaQzZYdjhTMDYvbnlSTGVjRE9TeTczdEdJcmxjYnJPeE1M?=
 =?utf-8?Q?smj7t+OPz14el/DGtwsYb1tZJtg+E3z3LnlTzqlt6HMO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eff0c01-50ec-4e3d-ecdb-08db1edab10e
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 07:08:02.7337 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a1tFsUBbA73rtncPWIkrKYZjbYGx+dGLTuCRs26kxWt+211b+8Y0Z1Jq3f8nCdPo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4458
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
Cc: Feifei Xu <Feifei.Xu@amd.com>, horace.chen@amd.com,
 Kevin Wang <Kevin1.Wang@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Monk Liu <Monk.Liu@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 07.03.23 um 08:02 schrieb YuBiao Wang:
> [Why]
> For engines not supporting soft reset, i.e. VCN, there will be a failed
> ib test before mode 1 reset during asic reset. The fences in this case
> are never signaled and next time when we try to free the sa_bo, kernel
> will hang.
>
> [How]
> During pre_asic_reset, driver will clear job fences and afterwards the
> fences' refcount will be reduced to 1. For drm_sched_jobs it will be
> released in job_free_cb, and for non-sched jobs like ib_test, it's meant
> to be released in sa_bo_free but only when the fences are signaled. So
> we have to force signal the non_sched bad job's fence during
> pre_asic_reset or the clear is not complete.

Well NAK for now. It looks once more like one of those not very well 
thought through changes.

Luben can you please take a look at this and double check it.

Thanks,
Christian.

>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index faff4a3f96e6..2e549bd50990 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -673,6 +673,7 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>   {
>   	int i;
>   	struct dma_fence *old, **ptr;
> +	struct amdgpu_job *job;
>   
>   	for (i = 0; i <= ring->fence_drv.num_fences_mask; i++) {
>   		ptr = &ring->fence_drv.fences[i];
> @@ -680,6 +681,9 @@ void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring)
>   		if (old && old->ops == &amdgpu_job_fence_ops) {
>   			RCU_INIT_POINTER(*ptr, NULL);
>   			dma_fence_put(old);
> +			job = container_of(old, struct amdgpu_job, hw_fence);
> +			if (!job->base.s_fence && !dma_fence_is_signaled(old))
> +				dma_fence_signal(old);
>   		}
>   	}
>   }

