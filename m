Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD836C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Oct 2022 10:55:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F266210E214;
	Thu, 13 Oct 2022 10:55:18 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2042.outbound.protection.outlook.com [40.107.212.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE17310E214
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Oct 2022 10:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwcHiszrsXmP8T29MHLiJM/zIyltxgucL55IuSZ7DiS3oFz3Dtj3kQiyGAOKmGiwtEtz77g+QnLrc0HH/n21/yTR8FnFcv1t/lwmTE8R11Shdr+y3kON913J1l+ccaCMU9kaJqsvLOlzLb8b8mysEpNB/BAEkvtKk2hP5ByxWq1z3nckgE6c2vpZqGO2uf82rEuNK3noEGwSFLf6eCSPYhhtgX8Tu+Rg910Nc/8b0EJFc8Ma8rKM39AjT0fkBhnO5kUwov9bYguPIUmwHi5SizcSfZreMMMWThWD7WICjhlQE60hJp8Xq2nnsHk1VFjEeK9sEmq4FIEnVV5i3ig9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrxVf4EQ4+RbyIuxPLfalxZuBIvXv7dLKbibXPoM5LU=;
 b=BgSyRiTQ1Wjcf5daK1AP5RcX1eifvDkclNGTZoHeO2VXSWEUZZq2IAIg/fLXb5oZOBER0Bpj/6xpkO7jxJXZBGq6t96KUn9sA+og/FCFVVNRrx3WcAQQmT5aYGzw1T0mlp8cNejtUJQxW+N08beURCWf4J+AqKQ5D2ZQrNuJ8hrBJWuzBMkMV/4wzVo96D/Y+FJYtDiVmRz4hsmm1yCqk6uItiUj/QrGZtE1fPshQoh4Ofkw1diXUaZuM3u0I6E4jiCO4XTF0uQYccy22S3Mw+RN0htbjFBmCuEqncbWIwqb+qCG88Xgixxfgh9jUoU/3aI+7RWnj8yzQA5Vhh0Zug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrxVf4EQ4+RbyIuxPLfalxZuBIvXv7dLKbibXPoM5LU=;
 b=LUDJSukvVPr92rDQ0P0ma1AO2CMhMJuO67iI1VjEkCQOemarhaH3R1CsIGuBs+nPj9UupY/OSncQHITJxnAQh9LM9LtNY+MuIorEr5rK8KvdODYbEylF2QegwiQC15TcDPFLJ+/4UwmSMTnr0SlGN07XsOgaJzUh4rfG4iW6O1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by CY8PR12MB7634.namprd12.prod.outlook.com (2603:10b6:930:9d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 10:55:13 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::805b:58b6:1f27:d644%6]) with mapi id 15.20.5723.022; Thu, 13 Oct 2022
 10:55:13 +0000
Message-ID: <bbf15262-0065-c77a-d280-882f174359a0@amd.com>
Date: Thu, 13 Oct 2022 12:55:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2] drm/amdgpu: dequeue mes scheduler during fini
Content-Language: en-US
To: YuBiao Wang <YuBiao.Wang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221013103858.2966780-1-YuBiao.Wang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221013103858.2966780-1-YuBiao.Wang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR05CA0057.eurprd05.prod.outlook.com
 (2603:10a6:20b:489::35) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|CY8PR12MB7634:EE_
X-MS-Office365-Filtering-Correlation-Id: 420c027a-20c4-4fe1-221c-08daad096775
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ynbcfcZgx1YzxHgFuhwiz+96ULUuPP6ff+SsiM8W10UhinPvSgBLNc0jEuDsjFlZsYz6TZ7RNNamkVaZrd6jGdxA9mOMCkbR7DoEn1/kUZ3UmTMxs92V3Bpk+Xxj7jjJhwH83RTout2ozlbk54WG2Okk7tuZuKltYlFg91QZa0FGAo8yzC6EBUU/RmTSfeAPNGQBc/EKp4mnrOyTFofMGqvPEE2GT0nqmMooa+xRRtu+Ryylo5P2vWft6LSjaImGcT7fgwhjA8GrviFlUR4P1oV1hjHxMI2hB36xkTlQk+4ex4Sbnb5HLF7x0cG7LVFiFh/mZYOJVdBhN0NQHEDgH68qUJy/aGXWZdxK9bU43a8vHi0HPn8ZcnPtcDVVXfvy0FxsK6SjFsnzdnfeefLVsLQeuMSb+wVlZvx900T8chZLzBIQ1pPByWk1BvowDzBbsdZyDQzMiss5DPbFfPuaMNGtgxYEPbs4ZSv+NP6Oi77IysC6HC531S77FHVMZ8OiX2E5I9Bt8poHVaNNDa3ZQsO21ToZHNwx5xuTlXQkIbJI2mM9mW/m9VF6d4cXypes4oBnUIQ7YE67XPxs6bgQWYD3FtUcKnMkFu5P2cz9m14gj9rVieYDSGpJT29qcw1F5gFUWiZr51goglm9jybk9tOgEt2Lub3dWbtmyjrvCbDO35bs0ID7bmw/YjxfONat/jhs5+08Kh0JtqR/i7sXHEzF2/K0E3nrCY6LXyZloDFTzPaUmzq9Ln1SkDbUJOymKtMIObsBJgKcJBgGZx9eLd8CkorI5KCP8mJiMazStiM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(5660300002)(186003)(2616005)(2906002)(6506007)(41300700001)(6512007)(26005)(8936002)(38100700002)(31696002)(86362001)(36756003)(83380400001)(478600001)(316002)(54906003)(31686004)(66556008)(8676002)(4326008)(66946007)(66476007)(6666004)(6486002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c25KMFpYQU5wMWNGT3lqdUZ3VTBZeW9sUGtMTyt1bm1TSVRFZkl4a0pvVXJD?=
 =?utf-8?B?dTdHdU1aR2s2RFUyOHM4bEJveVYyVHhYTXgwZSsvOXpJNk05VG9JUVpPSTJN?=
 =?utf-8?B?UndCZndUb1NPWjNGZWNsekdad2YyZDRZYy9SVGNpU0gwczR4aXJPZUdvQlFC?=
 =?utf-8?B?dXVaSTF4cWVxRGg2ZmNMajVrSHRXUW5JOFpiTDcveGxYUGhRaFlBMXBOb1Vl?=
 =?utf-8?B?bGZyaGczby83dHkxNURyQkdBbnFUR2V6TkdsUTBIcHl3TDUvZlY0QVJkNHUz?=
 =?utf-8?B?R2ovTXBkTGxDYWdGdktSZlZ6ajZMU2RTL0VqZURhc2lKQmtsSnp6anlHeEo2?=
 =?utf-8?B?Z213VitRNzQrek50WDFITFVGREtENEF4aFE2ZklEdWs0OGlicVJZMHFVRUpv?=
 =?utf-8?B?ZWN4ZUNDVHRpN01LUWh5ajU3S1hibzJTWk1MbjErVU52OGh3OTFLcGxkc1BB?=
 =?utf-8?B?c0h3UWdrQlBlUUx6dWZ0b0dLWm9pUmRBa3Jib3pYTjB0WVBuM3RSaVIrWFhN?=
 =?utf-8?B?QmovTjIxa2I2WElYYXdid1lPYlBCWGZjeFRxMVNrQ20yVmNIOWJleVdQajBL?=
 =?utf-8?B?YWp5OVhScGMxU0llbmJmb0ZzZnRDek9MT2J6VTQ1MmVhUWRnbG5KTWNnRHNV?=
 =?utf-8?B?OTNCSUVSbFBrdmpKdTVoZkoxUzRKM2dDTkVPVTVRSEc4MXZEZEZNNU1tZG5v?=
 =?utf-8?B?c0VDTldLZWtJWFc0SzVVaGFndXBNWnhYUm5DbjFqTzUzS2Y1TUN0V1JRc2ZR?=
 =?utf-8?B?emkrSEIwaE9pWCtoeWFsci9PamRCWGhia0FrUTBUMk9SL08wa2xRQS9uVmhx?=
 =?utf-8?B?a1F3QSswZFZHbnRXMmFyYXlrYlgyR3lPR3RmKzRzUWFUY2FwUVlKSnZnMU1B?=
 =?utf-8?B?TVhSeGRtZmdQMGVYTThGcXlTMnNHU0xNK0hnMHdjZ0dOUXNuT2xwbm1vWHBs?=
 =?utf-8?B?dHh6NjZIdmZMMHNnby9wQ0lKMUNSZmp1RUVrMFRvenk0cVh5dFlORi9nelU5?=
 =?utf-8?B?ZWs1ampuS2ptek9wb1EyVy9SSDA5U1pHeWJXdklnS2xiNjR0YnVUQzBQQisv?=
 =?utf-8?B?N25meUJ0dnY0YzgzWWdac3NhUkxQMitYc1BRTzdOemNkQ0tFYVNtaDlOTXhV?=
 =?utf-8?B?Y0RWdTA4MFdzSDlpNUgwK3NPWEs3cUtGbVBRT3lJWmx3WDRCbENxaHBDcW5Z?=
 =?utf-8?B?RnY5aFZMZ21UWS85NTliOWsvT0ZZVW5xMVBubmlDdDBFYWxoQXRqZGh2ZzlT?=
 =?utf-8?B?ODBNSUxqaml2OC9RNWs0cVZqVjc3eXdLZTI2RmJJbi80Q2lITitNdm9MM29E?=
 =?utf-8?B?UUluVzJaM1dRL1F2K0lBcFdjZmtUb3UrVjA1V1F0UllxVjRXRUZsQnNadWJ5?=
 =?utf-8?B?L1ZTcUtJU2dickV4bFQ4TTJtTjNGSzRzb1RwMG1waGpNeE83Smp1d1F1dTJ3?=
 =?utf-8?B?elh5N2ZqcjM3MVMrbHI3SUxabHRNV3paQWNMc0JqQ3pOTzVYdmZuNDYyQzRB?=
 =?utf-8?B?WEtqWXpkT0N5VEZZU01yS1E4L1pQWUVJckFKU042czMxVDk3a0o0R1Rac2h5?=
 =?utf-8?B?K1RZZzR4b0FPbXBFcFZLcW0xMDR0eXRWaW5LeVh0UGoyTXJkOWJQdDZOQWkx?=
 =?utf-8?B?UFlSRzNPN0ROZ3g1WjcyanV6WVRob3k1NFprTzFaL2F6bVN2M1o4cXgxbWFk?=
 =?utf-8?B?bXRSVk1sSEpRMktybmJyNnJBQXB5bmVMNWswOStJakJReVJhM1g3VWt4Wnl6?=
 =?utf-8?B?WnZFVEtyQWVudXZyK0xYOTFsZWtRTzU3SlI1OEF5dHNqTk4rWE9LeWViRnEz?=
 =?utf-8?B?dHNxdmZCS1I2ZjVETXBlcFZPTy9LSVI4aUYxK3ZqL2Q0NS9ocnorTDMxNDRS?=
 =?utf-8?B?TUQxUklNbnJxckwvam9kdElsbFNpc0dOY0g3UjR0K2VteEZhaGx1TElJeSt0?=
 =?utf-8?B?NjBNZThQYUJodWpwaHdYZ09TaXhuekRHSDc0U1BJM08xcXRvTGxCMEtwZmpy?=
 =?utf-8?B?ZmhZS3ZpRE41cXVvbmtjbDFPSks0eXF3OHNjaEk2Tm94MFdLbkE5TVBhakQ1?=
 =?utf-8?B?WisrNVd5c05ZNWo5Z1MzeEJhb0tDbFJtZDZOK2hNa2NxdVM2M0RPbGNNNVJT?=
 =?utf-8?Q?oqunDUz15jKnua7X8FITjCbqn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 420c027a-20c4-4fe1-221c-08daad096775
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 10:55:13.0574 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtJhADDlRHHOgcJ5ngKhjl5IPBJJynEL6PhIkdFx06dXw7QNFU6PvBJbMRvlTmit
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7634
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
Cc: Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>,
 Jack Xiao <Jack.Xiao@amd.com>, Feifei Xu <Feifei.Xu@amd.com>,
 horace.chen@amd.com, Kevin Wang <Kevin1.Wang@amd.com>,
 Tuikov Luben <Luben.Tuikov@amd.com>,
 Deucher Alexander <Alexander.Deucher@amd.com>, Evan Quan <Evan.Quan@amd.com>,
 Monk Liu <Monk.Liu@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.10.22 um 12:39 schrieb YuBiao Wang:
> Resend to fix coding style issue.
>
> [Why]
> If mes is not dequeued during fini, mes will be in an uncleaned state
> during reload, then mes couldn't receive some commands which leads to
> reload failure.
>
> [How]
> Perform MES dequeue via MMIO after all the unmap jobs are done by mes
> and before kiq fini.
>
> Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h |  3 ++
>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |  3 ++
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  | 47 +++++++++++++++++++++++--
>   3 files changed, 50 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index ad980f4b66e1..ea8efa52503b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -130,6 +130,9 @@ struct amdgpu_mes {
>   	int                             (*kiq_hw_init)(struct amdgpu_device *adev);
>   	int                             (*kiq_hw_fini)(struct amdgpu_device *adev);
>   
> +	/* dequeue sched pipe via kiq */
> +	void                            (*kiq_dequeue_sched)(struct amdgpu_device *adev);
> +
>   	/* ip specific functions */
>   	const struct amdgpu_mes_funcs   *funcs;
>   };
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 257b2e4de600..7c75758f58e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -4406,6 +4406,9 @@ static int gfx_v11_0_hw_fini(void *handle)
>   		if (amdgpu_gfx_disable_kcq(adev))
>   			DRM_ERROR("KCQ disable failed\n");
>   
> +		if (adev->mes.ring.sched.ready && adev->mes.kiq_dequeue_sched)
> +			adev->mes.kiq_dequeue_sched(adev);
> +
>   		amdgpu_mes_kiq_hw_fini(adev);
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index b48684db2832..837ff485dab6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -44,6 +44,7 @@ MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
>   static int mes_v11_0_hw_fini(void *handle);
>   static int mes_v11_0_kiq_hw_init(struct amdgpu_device *adev);
>   static int mes_v11_0_kiq_hw_fini(struct amdgpu_device *adev);
> +static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev);
>   
>   #define MES_EOP_SIZE   2048
>   
> @@ -1078,6 +1079,7 @@ static int mes_v11_0_sw_init(void *handle)
>   	adev->mes.funcs = &mes_v11_0_funcs;
>   	adev->mes.kiq_hw_init = &mes_v11_0_kiq_hw_init;
>   	adev->mes.kiq_hw_fini = &mes_v11_0_kiq_hw_fini;
> +	adev->mes.kiq_dequeue_sched = &mes_v11_0_kiq_dequeue_sched;
>   
>   	r = amdgpu_mes_init(adev);
>   	if (r)
> @@ -1151,6 +1153,42 @@ static int mes_v11_0_sw_fini(void *handle)
>   	return 0;
>   }
>   
> +static void mes_v11_0_kiq_dequeue_sched(struct amdgpu_device *adev)
> +{
> +	uint32_t data;
> +	int i;
> +
> +	mutex_lock(&adev->srbm_mutex);
> +	soc21_grbm_select(adev, 3, AMDGPU_MES_SCHED_PIPE, 0, 0);
> +
> +	/* disable the queue if it's active */
> +	if (RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1) {
> +		WREG32_SOC15(GC, 0, regCP_HQD_DEQUEUE_REQUEST, 1);
> +		for (i = 0; i < adev->usec_timeout; i++) {
> +			if (!(RREG32_SOC15(GC, 0, regCP_HQD_ACTIVE) & 1))
> +				break;
> +			udelay(1);
> +		}
> +	}
> +	data = RREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL);
> +	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
> +				DOORBELL_EN, 0);
> +	data = REG_SET_FIELD(data, CP_HQD_PQ_DOORBELL_CONTROL,
> +				DOORBELL_HIT, 1);
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, data);
> +
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL, 0);
> +
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_LO, 0);
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_WPTR_HI, 0);
> +	WREG32_SOC15(GC, 0, regCP_HQD_PQ_RPTR, 0);
> +
> +	soc21_grbm_select(adev, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +
> +	adev->mes.ring.sched.ready = false;
> +}
> +
>   static void mes_v11_0_kiq_setting(struct amdgpu_ring *ring)
>   {
>   	uint32_t tmp;
> @@ -1257,9 +1295,12 @@ static int mes_v11_0_hw_init(void *handle)
>   
>   static int mes_v11_0_hw_fini(void *handle)
>   {
> -	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> -
> -	adev->mes.ring.sched.ready = false;
> +	/*
> +	 * Do not disable mes.ring.sched.ready here, since mes
> +	 * is still used to unmap other rings.
> +	 * We'll set mes.ring.sched.ready to false when mes ring
> +	 * is dequeued.
> +	 */

Maybe drop that comment. The driver should *NEVER* set ring.sched.read 
to false, but only to true.

The background is that this flag is used if a ring was correctly 
initialized from the SW side. It's *not* related to the hardware state, 
but only set to true after the hardware is tested.

We have gotten this wrong so many times and I had to write patches to 
remove it.

The only exception so far to this is the KIQ ring because here we don't 
use it for CS. MES might get the same exception, but not as long as we 
don't need it somewhere.

Regards,
Christian.

>   	return 0;
>   }
>   

