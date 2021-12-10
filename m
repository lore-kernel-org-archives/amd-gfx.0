Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17D19C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Dec 2021 23:30:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D53C10E55E;
	Fri, 10 Dec 2021 23:30:49 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2051.outbound.protection.outlook.com [40.107.96.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C63F410E55E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Dec 2021 23:30:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQrjI8RK2uF6ItTSduguqQyO4kTPn92ivXPAHUH2Kh2axAo9UWUEAB0jztqR9r+CNAo7tA4jm9MnxFTeFpZh7k+g7xl4AFI6NJylOdVZ8eRTdr7NBQT67gl4hiqNB1TTFTo8i9ZXyyEVVSNKH0sULnFWXnfOSlSbueBCkxQ3tI5FBxGhyMsovGet99dkPzKey//ufSiyiKsuhfpUk4iPvtJcH6Ol/rprgaZUh2aRLkBZSFBfOR+xTX5hb+PtKLkfokByFFBCNdOOsLaQmzHrjO1kn0bsgNgIvGyx2lzTDI/y5has1fY+y5x7CU26ac4I088rufCRxGGlTpltiFAZfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGYQHmtUEB1PZxqqlyrGtDkBSP2nzg7MKIJ9Hpl76fA=;
 b=JEsv2Mq8OQ5k8Xs9Vu/FQLtORfChiq83Kdo1QkwbzvjwEltGWbXTTeGyhrcXTgH15490qREiZp6XYU8FVihn5BXBga3KXyW3isUUn0KpKJuTpLsygIJXc9lCvojZFQAt3oG0K8BC0PDpmbubXJOWXzUc9n/q9XF0a+Y153hePTJ6wdaQB+LTjt2e15kU4C9qmyjFf9hPeF3KPM+O7a6SjzlKO2aet2ZSMjEkVbJj/JhcXYcJGIrefAotvs9qWSU5PHBHa/Kz5yhRsjOYPV1dBOXIL714VDmEgNyzQnuj/a+fnC6ownasqY2T0BYtqiFIwZYealj8jOOLL6GOSmx7oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGYQHmtUEB1PZxqqlyrGtDkBSP2nzg7MKIJ9Hpl76fA=;
 b=reLEIAaCcv5XDzuaSF3smX/qH9MJiRh3bjcRti2wiDmYtW40fMW7Mr2K3c07HwCjHfWGwfyFapFM3Pv8dA5WEcwMInPor1Prvtw9g4fD2W2EukylvxZQm/i9hZGtXI55x52OjqrHhPpN+bwiGcV/x0uztQEz6PvchxUp/KsTF+s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5178.namprd12.prod.outlook.com (2603:10b6:408:11b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 10 Dec
 2021 23:30:44 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%7]) with mapi id 15.20.4755.022; Fri, 10 Dec 2021
 23:30:44 +0000
Subject: Re: [PATCH 3/3] drm/amdkfd: reset queue which consumes RAS poison
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org,
 hawking.zhang@amd.com, stanley.yang@amd.com, thomas.chai@amd.com
References: <20211210111502.17384-1-tao.zhou1@amd.com>
 <20211210111502.17384-3-tao.zhou1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <60d4937e-a416-5f02-3c71-476b6f73d50e@amd.com>
Date: Fri, 10 Dec 2021 18:30:42 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211210111502.17384-3-tao.zhou1@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: MN2PR12CA0035.namprd12.prod.outlook.com
 (2603:10b6:208:a8::48) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [172.27.226.80] (165.204.55.251) by
 MN2PR12CA0035.namprd12.prod.outlook.com (2603:10b6:208:a8::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.20 via Frontend Transport; Fri, 10 Dec 2021 23:30:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a39f9a8-d4e6-43a7-c70d-08d9bc351619
X-MS-TrafficTypeDiagnostic: BN9PR12MB5178:EE_
X-Microsoft-Antispam-PRVS: <BN9PR12MB517879632EF7AE83E912479D92719@BN9PR12MB5178.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1468;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z3XZsT+p/wYJIs19ydbe35ATluolDHOqjewXnKyug0n9jDQ/USrwL7+JAjZeB6aDwrUE9u/KCesu6+e8uHNMYEVFKR3bwyzX1q3F1lW6Li6smfg8lVJeY0LpdglMJKyFSUw4NV0OngtfGkrFD/Px+ulk5k+D+qp2vQZ47gZ0AroGH3W1heifHgc62A+433xw5QYLwSuRSeeNlMvyOX/5lA7rIRk1YA+ylHJxRzyMuJ3js3Eg/PwWIzCUZ1oK+NeLCFGf7p1U8bV9CR2OdR69l7/+pow6WsuwNezxC25JteeE2Ln4Qij6WHOqBppnf/G4AJQ63waC90MyUFgNaPJ3Sux/VjSrDKM8W4gHUP3G3fnK9kstkp351yuszoXxg1jbQEdzjy7dl+QVF24IDmRCHpnkGR5XgtJ/w8JatjVOuFg77Jacba8LEiucYoey24/FTOhl60B823Hp4F0KGTfVoX7FfMyGxkjcSRCrYfGi+OhyAPgiyrQkL5YuhBxxgUTykIeW2gaxT8UV4oOTD3Fj8q1JMWww9gnrU2JFZGVRLtxTgfqppNqy1sdfr08VSJa+XB0wgDT/F/MKi/bBoWtvGXpcfKyBv817gNnbR8lEK7dwTf1tRsCItf0vb5YSWpQztx7lZO74/wLi6haHmQveuJjs0qUmlOKgHKXEnU79B1WgC1WXJMEY79vgynInFrJ9lsuA/bsmrJlbV9gHyWAmbTcND3LYsF9/b6jgn519QKJyZCThrCp7PN4dJ2NEiUhK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(508600001)(83380400001)(956004)(66476007)(36916002)(2906002)(16576012)(6636002)(66946007)(66556008)(316002)(31696002)(2616005)(26005)(31686004)(186003)(8936002)(86362001)(5660300002)(4001150100001)(36756003)(38100700002)(53546011)(44832011)(6486002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjJzNnRlS05OTjljdzU1OThacjBGMjVvbzFCRkFWZ2VMcE8yQllYdG5iYlQ1?=
 =?utf-8?B?czRoNERjWGlJYmttaURwTTZVV05hN3k1dzkzdzRuaGFQdFRlRVdxMDVsL0Zu?=
 =?utf-8?B?cFBmcUxFRlAzQ1kyNzFkT2JtNGFmNndnZGh0NkJieklidUJzU2JhbGIxaUFl?=
 =?utf-8?B?cEhSRkF4bjBSamEvdDIvZG1OYVdpRXFaY2dYUlU4NExydzJMajNrczdwbDRt?=
 =?utf-8?B?dmQzdEkyUjNvOFpubEN3bm9QQm5rMmg2U2NLc2hFWkNFbUs5SDFmRmRuN1Bl?=
 =?utf-8?B?bkpvVEdBZGozTmUzbnRKSytLNEdkQjZ4bmZNWnVFd0t2a2VyVldNNURkZEcw?=
 =?utf-8?B?Q3IyelI5OTN1OTFiNTdpdFhqUk9aUDhKUVFRMTFveWVlbEpyR1lES1BGVURo?=
 =?utf-8?B?T1ZPMUxyUUxXT25vRXRWOWV1SSt2RzREZXRKRWxqQmNWMUU2TmdMZThiazVi?=
 =?utf-8?B?S2lwNGsxcW9LMFNxWU9aakYrbGhNZytLZFA5Q0d4Nmh1TXk4c0FrMUo4ME9l?=
 =?utf-8?B?Z0NBVkZrUUtBLzBYSVh5TkM5Tnp0S1luaHhhRjJrR0dOWEdmNHZ2RzNzMDZj?=
 =?utf-8?B?akMwUDVDbjIvbHd4NzlkTTdFT0x2dkV6LzRRMUF2RzBYMnMvend6RTF5cWVR?=
 =?utf-8?B?KzA5M2J2WnQzKzQzVkFONmNIWTFHVHdZWUFiT045SytnbTQyUUhZd21Edytp?=
 =?utf-8?B?WE9pOXhCTXREdWRSekNMbzgzOURTVTlPREFRMTBETUdGZEtteE44MU5CUkJY?=
 =?utf-8?B?b1JBaHhMVWpSRmFZWk53dVJlNDdYanFjdjhmUkQrbjBaV1NrcEQwbGQ5amRl?=
 =?utf-8?B?ZnpVWXExWlJSVGM4YzJ3UnFHZG93ZStTYTVDcDhXTGQ3MnIrUGE1NUVhSEFN?=
 =?utf-8?B?V2t6SUpIYisrRTlZOXh3akZHNTc0QysyY3NYZThrKzU4M3pKS1F6dU9LVGkv?=
 =?utf-8?B?eVFqMFhyN1FURXJ0Nm8rOTZZamZrMkdtN25tQzZVN3dqamxRNERaQ0dLMFY4?=
 =?utf-8?B?dzFqeHBYR1RLbnh0WnJ3aldjSlBMaTI3RVIycXFZdUpxYkEzYmQrOVdJWlVJ?=
 =?utf-8?B?WWg4SisxTU83ZU5pb1BPMjUxSW1yWXlKSnNqQmpFL2NmMnBmc2FpRUd1SGlT?=
 =?utf-8?B?MnlVRmlZSWxhaS9sVlRlNVBMZEljRjllcEdvTFN3MGlrM3k4c3c2UkhLbVYw?=
 =?utf-8?B?QjNIeEh1YkJyMEJ5Vm9ZRm9SdlVwTzhjS3JzSXpvVTNycjZ5OEtvWUN4MjRr?=
 =?utf-8?B?WFhKTVZrdW9uYUJyQ2pTWG92akdTQ2VJN1h2ejhzbWl0Z0hIalpsNXVYTWY4?=
 =?utf-8?B?UnNHbk1mQVdiY0M3OVFtZFYvci9vS3RMWE5xNlFWdVlGczJUMUswZ0JVR2M1?=
 =?utf-8?B?UXp3SHphbHV6UnUwaGpmajZXYVpZaFlxaXN1bGRjRGlFSGNWSW5WeUkrNjBm?=
 =?utf-8?B?YitvVnRlM3VIU1FMcnd1TmlaQnFyTzBHZjc2YlFYY2NRcmV3THVQVFZrYzg0?=
 =?utf-8?B?b3NFUWUzZ0ZURzJvekV0K3ZhRXFqa1dUbHBLQU10dFprbmtRWnN2Zit5OW90?=
 =?utf-8?B?MTdWKzNsT2VFSzYxSGJUMWdTd3hnMjFYcnNmcEMxYTNRd2o4L3Y2Ull3QTFu?=
 =?utf-8?B?b0R3N2VlOWZ5OUtzdnA3UHdTb3Y2UjlsM2tCNkZ4Q3JXRkhkTUtJeS9MaUY0?=
 =?utf-8?B?M1RINE9yQlVIcG9VUW9veEg3Qk01a1NhRm52Q2RTN0dVZ2NsNkh3NGkyRFkv?=
 =?utf-8?B?SHVwQ3c2UUxTVURadHlxU3pHbWRtbDZXcXQ1YUVOUThzcUpFSFRPalk3UUZW?=
 =?utf-8?B?YW5kUDIxcVpkdEU3NC9MZ2Jsd3h0cXRwbCtBbU1PUU85aE5YSzkvQS9WSnhE?=
 =?utf-8?B?S2x2bXhWSzhXVDFQdWIzaXh3UDJod2FKV3lEVm04OGpQN3h3akltTk1qVER5?=
 =?utf-8?B?VTBTNnk3TGhmaHNqSEhhRkdpVFhsamFxQWIvbzEwVnIyK0Z4MnZQWlA3RHF4?=
 =?utf-8?B?QVltVGZCLzV2TWZFYXIxMlJuMFA2YzVHbzZlOHFaM1p6bzM0UW0zSUU5Vmda?=
 =?utf-8?B?NlYrSVNNbHFZZmV0Sjk4N1JGUzJVOVFxNUlCc0MyWlRQdjVpNWREZFg5MlNL?=
 =?utf-8?B?Smx4dGdoM0hXYnRJZ1ErbHN5ZjM3ZWsvYzB0WlNPbitIb3JXeUEwT25DSmtD?=
 =?utf-8?Q?bgjLT1UGfCGLxC5VR/dGBZw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a39f9a8-d4e6-43a7-c70d-08d9bc351619
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 23:30:44.1594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ONp2BYYg8FmZ1eXpIR5cKLlgjTpvskydDTe13KNmZk9HTEuor/AFuAFu2Z06Pi/elGVTJkFT3MPUN7/2GqCwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5178
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


On 2021-12-10 6:15 a.m., Tao Zhou wrote:
> CP supports unmap queue with reset mode which only destroys specific queue without affecting others.
> Replacing whole gpu reset with reset queue mode for RAS poison consumption
> saves much time, and we can also fallback to gpu reset solution if reset
> queue fails.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  6 ++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |  3 ++-
>   .../drm/amd/amdkfd/kfd_device_queue_manager.c | 14 ++++++++++
>   .../drm/amd/amdkfd/kfd_device_queue_manager.h |  1 +
>   .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   | 27 ++++++++++++++++---
>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 ++
>   6 files changed, 45 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 46cf48b3904a..0bf09a94d944 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -721,13 +721,13 @@ bool amdgpu_amdkfd_have_atomics_support(struct amdgpu_device *adev)
>   	return adev->have_atomics_support;
>   }
>   
> -void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev)
> +void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bool reset)
>   {
>   	struct ras_err_data err_data = {0, 0, 0, NULL};
>   
>   	/* CPU MCA will handle page retirement if connected_to_cpu is 1 */
>   	if (!adev->gmc.xgmi.connected_to_cpu)
> -		amdgpu_umc_process_ras_data_cb(adev, &err_data, NULL);
> -	else
> +		amdgpu_umc_do_page_retirement(adev, &err_data, NULL, reset);
> +	else if (reset)
>   		amdgpu_amdkfd_gpu_reset(adev);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index fcbc8a9c9e06..61f899e54fd5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -296,7 +296,8 @@ int amdgpu_amdkfd_gpuvm_import_dmabuf(struct amdgpu_device *adev,
>   				      uint64_t *mmap_offset);
>   int amdgpu_amdkfd_get_tile_config(struct amdgpu_device *adev,
>   				struct tile_config *config);
> -void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev);
> +void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev,
> +				bool reset);
>   #if IS_ENABLED(CONFIG_HSA_AMD)
>   void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>   void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 01a2cc3928ac..095b2e0822aa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1476,6 +1476,20 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
>   	return retval;
>   }
>   
> +int unmap_queues_cpsch_poison(struct device_queue_manager *dqm, uint32_t pasid)
> +{
> +	int ret;
> +
> +	dqm_lock(dqm);
> +
> +	ret = unmap_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_BY_PASID,
> +			pasid, true);
> +
> +	dqm_unlock(dqm);
> +
> +	return ret;
> +}
> +
>   /* dqm->lock mutex has to be locked before calling this function */
>   static int execute_queues_cpsch(struct device_queue_manager *dqm,
>   				enum kfd_unmap_queues_filter filter,
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> index 499fc0ea387f..c52869133159 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
> @@ -219,6 +219,7 @@ unsigned int get_queues_per_pipe(struct device_queue_manager *dqm);
>   unsigned int get_pipes_per_mec(struct device_queue_manager *dqm);
>   unsigned int get_num_sdma_queues(struct device_queue_manager *dqm);
>   unsigned int get_num_xgmi_sdma_queues(struct device_queue_manager *dqm);
> +int unmap_queues_cpsch_poison(struct device_queue_manager *dqm, uint32_t pasid);
>   
>   static inline unsigned int get_sh_mem_bases_32(struct kfd_process_device *pdd)
>   {
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> index deb64168c9e8..2863bb9e5bca 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
> @@ -89,6 +89,27 @@ enum SQ_INTERRUPT_ERROR_TYPE {
>   #define KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000
>   #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
>   
> +static void event_interrupt_poison_consumption(struct kfd_dev *dev,
> +				uint16_t pasid)
> +{
> +	int ret;
> +	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
> +
> +	/* all queues of a process will be unmapped in one time */
> +	if (p && atomic_read(&p->poison))
> +		return;
> +
> +	atomic_set(&p->poison, 1);

You're not checking p != NULL here.

You also need to release the process refcount before this function 
returns. Otherwise the process resources will be leaked. You can see 
leaked processes in /sys/class/kfd/kfd/proc. That directory should be 
empty after all KFD processes terminated.

Other than that, the series is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +	ret = unmap_queues_cpsch_poison(dev->dqm, pasid);
> +	kfd_signal_poison_consumed_event(dev, pasid);
> +	/* resetting queue passes, do page retirement without gpu reset
> +	   resetting queue fails, fallback to gpu reset solution */
> +	if (!ret)
> +		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
> +	else
> +		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
> +}
> +
>   static bool event_interrupt_isr_v9(struct kfd_dev *dev,
>   					const uint32_t *ih_ring_entry,
>   					uint32_t *patched_ihre,
> @@ -230,8 +251,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   					sq_intr_err);
>   				if (sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
>   					sq_intr_err != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
> -					kfd_signal_poison_consumed_event(dev, pasid);
> -					amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev);
> +					event_interrupt_poison_consumption(dev, pasid);
>   					return;
>   				}
>   				break;
> @@ -252,8 +272,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
>   		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
>   			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
>   		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
> -			kfd_signal_poison_consumed_event(dev, pasid);
> -			amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev);
> +			event_interrupt_poison_consumption(dev, pasid);
>   			return;
>   		}
>   	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index 0c3f911e3bf4..ea68f3b3a4e9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -856,6 +856,8 @@ struct kfd_process {
>   	struct svm_range_list svms;
>   
>   	bool xnack_enabled;
> +
> +	atomic_t poison;
>   };
>   
>   #define KFD_PROCESS_TABLE_SIZE 5 /* bits: 32 entries */
