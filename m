Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFA3C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 18 May 2022 06:04:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6004510F6CC;
	Wed, 18 May 2022 06:04:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5726210F6CC
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 May 2022 06:04:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U1OyZ/b8DCheq/b4mqSKZIc56Y+Xitqt1DB/qJUH87Vtpw+WhQaP5KvNvmqFQ4fCfIsm1t9OvKzhB8SxdzLaaDgMuDdXtVqG1t9KzWfUKKYqTZmFTv1yYcWNl62UYgO1eXURuqYiELYzLNI1dnKK0CcBG47YhtPONJnkxxPC67bxNxhqWcVonC2eOZ9tCLGrjfwUlje6cp7iPnBl2MbnUwS4AZMSw9EWnauU5WK/oGAwLUEOuy8CwLRDHiPtfZL6X+w7Al5Zy9GdiYty1NMWx8bZzqp67UZzFTleP1TLgTBKvVVgjkOXBGl1zFkraky8KrLpJfbDZblHeP4yWQLKag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WrHK0gusVp1+TlQVuoWKjMOk3Eu796QsWKpoyRy3Pwc=;
 b=mpYwclJn5nvhNT0/xWFM7Ea9ck6ZCn/ByIgJlsT+LZZY/S9hv3GVyzQ5qjk8BGC3dP2RCudoeIRbOSminfyPMH61q2CBFdKGgV8/DooqxpnlWxVIQmU/i/d0wkReLMWd56S9X9lfznvPHaTsTKzavyvbWYP46P8yGWsQ1v2TvGTniL/fJ/CpT4pcB5VDzZmaRI1BfBevJUkeE/+QY8CiJLCM0gSxVUTcB2GePSEIZnJrmeKglLzv/ofupdoJZ3yoaeF2x+nJIUovkslQMcf239dqSGJy/vmLErm1qrPB9ggabbELq2CI3fy4j6qrr2/QOk1v93g9pkA3NaAm91c5Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WrHK0gusVp1+TlQVuoWKjMOk3Eu796QsWKpoyRy3Pwc=;
 b=cS7aBR2H2XGpCdBiyxPRIgpQA7FXH6yCj/GEWw04sAgb6zR7uICNJDT4La9eV20yIN9YbiPMP1N6TDL5HnWJYeGHyJG72M0YuRYR9majkQrk0ekM3XoI9erVq0mqiRXnptsHquIqOrF+h9zQu7UaZ5BRWM7b2rvy4jERFyRdii8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by DM5PR1201MB0250.namprd12.prod.outlook.com (2603:10b6:4:54::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Wed, 18 May
 2022 06:03:59 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7146:65ee:8fd3:dd03%4]) with mapi id 15.20.5273.014; Wed, 18 May 2022
 06:03:52 +0000
Message-ID: <378a0de0-64ae-5ab3-4b68-b53ab65350eb@amd.com>
Date: Wed, 18 May 2022 08:03:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 2/7] drm/amdgpu: Switch to delayed work from
 work_struct.
Content-Language: en-US
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220517192102.238176-1-andrey.grodzovsky@amd.com>
 <20220517192102.238176-3-andrey.grodzovsky@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20220517192102.238176-3-andrey.grodzovsky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9PR06CA0256.eurprd06.prod.outlook.com
 (2603:10a6:20b:45f::7) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b75e2b30-e0e1-4054-51ba-08da38942d49
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0250:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1201MB02506DC7F4A03E28381A6ED183D19@DM5PR1201MB0250.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8vdM1CpX6yy3hyPAxsvwowrTIA9gHtcNp2P2f6dSnIVJMKS1NHoSJZCmvXm2RGydARvlUoUDLiUEBEO8jTy8tIFoCFvkRms1BKi7EIk9t3m73zWyGr7p9H5uyW2n7KWH2k7I2bl6tG+rfQCmCdlYTujSMSYxLI60FyH/Oi85fVPIOniDddFUgcYQwV/yLckVqFCEv4+C0iJz9Flr5kIz2i0HWu/rH2/7t4UJQ1K1Qc1JYj9TYZHUICEjIT48IAKlxpkAVWlI5KC5U5tkHd+BR5g9XJVzq9s9E+GoEgepT7I7YG2wpjT19iBUIZLswnfnGPOd/wp0KBrIMB5ZmSmUi/Ira/fpQpE3bAtpci5cBuFVcqwhf2/5fx7F9gTe1Dy93tNAywP3/wR+UPnuqvQdgXOOio6GL7T3q7bjO+CnOuNqZxjriA+u8ImJ6q/12DAPm6172zABRdqT/6hyru7y1gaIaDcu+QY74zmtvHZMGZ1yjb5JlLROZT59eZdW2VeHYK4+ySGW5li8/tdNcACbA7wfpoGP4LhWL5E2WA/bmScUO9dWw49f48NJgY+psSbedGVU23uVvLon7aMj1/TKwhEb27oYAWR5qTqGjoafzPnCxyyKz3yxgIUwjS4KYcbZp+w2wEUPnJSJls6hYMqvrwAFib72OH3PhFblELFPUA4cLKbGOwy8gt+qZ+15nuFKTbIGbDnRwulCItCjAQkF6QLMko/H+FXrfhGlmRB1/JgpNXb3/RAq3DqdKwZTKao5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6506007)(316002)(6666004)(36756003)(6512007)(31686004)(86362001)(186003)(8936002)(4326008)(8676002)(2616005)(6486002)(508600001)(66556008)(66946007)(66476007)(38100700002)(26005)(2906002)(31696002)(83380400001)(5660300002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K25HUDJpZHBPMUhnOFcrWVVUWmluQlRCUEdYWDNUeDhiMStMc3FwV0doZUxh?=
 =?utf-8?B?L0hzVTBoT3FYSjZ1eldySFFlamZRK0lHaEEyMkhYdmRBS2FBSnJuVFA1Y1dn?=
 =?utf-8?B?RnpnSVlRSXF5YldFYWQ2MnJHczVyL2NjdnN1cWJIcDVJa0ZoV01mcjk1clln?=
 =?utf-8?B?N3NDRDJVWW5JVEF4T1FGTjBnT2dUVWIyVWRERFdyUnhnRnE3S3RCNmROU0hm?=
 =?utf-8?B?UXpqY3pIcjVsc1BHRHlTaWhKVkdFY3d1eklpdWFWWmthNThVeHFoM0lvWXFK?=
 =?utf-8?B?cVFVWmEzQXNGUEpjbTljekZDSnduNkNIbHZmZTU5QUx6L0FOc1JYdi9IVWor?=
 =?utf-8?B?YWJEVys5WWgzUUFQeHZFOUFpZmVweUxRcUtObTgrTGhpMS9lNTBsQW1VTEtV?=
 =?utf-8?B?N2RweVNjaEhNME1Vd2pwKy81clRBdVF3Mmt3TTRoZ2hQMmg0bGhQZmd6dDhn?=
 =?utf-8?B?YVVtV3NRNG94M0dUeG5LWVcxaVhQN1JhR0plWC9HSW15d1I2bGNhb0JSMlAx?=
 =?utf-8?B?R2hJakV5TTZCN2JPNkM0b0kyUThWbHFSZGlXMTFENzhUU2QwOWVZK3ZDSTBz?=
 =?utf-8?B?NnZSeEloMko5RTQzODRDOE1ZWGhDTVZ1dVQvY1YvRlVncklWRnM0SS85ZFdh?=
 =?utf-8?B?ekFhSWJqZTh1N0RZdHRWWXNxRzJQSnlPWHZtVEdTZTJwdjdIc0NnSHZ1dm10?=
 =?utf-8?B?OGVOZ3hjZ0RrNFpabUtkWEk3L1J4T3JEMU9tT3VoK1VwTTQvd2Y0TUd4eC9z?=
 =?utf-8?B?NHlXVmZZTzQxZFd2ZlVLRnVVclJpZEZSRjFVaUVaZUJBblJGMlo1dTF0NDg2?=
 =?utf-8?B?bGFvVEl1Ty9pVitvczB0ZDZ0eG82TlZVUFdjQUZURlVQd2ZjdDhpUThSelJW?=
 =?utf-8?B?UWs1TUNqZnRVMmk0UCtEa0JWTXBRTVZrNFg0K01Xa21CQVY3NlpSL3JCcGFS?=
 =?utf-8?B?TXVIMnB0azVld0hkdDN5U0FhSVlkS2xGemxEZVgrL1BxTTVWN3ZFUXFaK0hl?=
 =?utf-8?B?UzMyV0lqdDh6ZldURXBRY3gyVTZSeXFqY0xJdnNScTJDd3VHVzA5U0RQbmZM?=
 =?utf-8?B?Q3ZtSlhkUnd0RDltMWgydG1CWllvWXh0ZVJ5a0I3NUFDMk0xd0NadHh4WDFZ?=
 =?utf-8?B?Sng3eVExOHR0L3hzK09FYXlNSTJLaEQ4VC9QelhhcTJFbC9icGx0TjdPdXdv?=
 =?utf-8?B?TkZ1ZUYrNmpoalhJZGJjdHhjY1loVkdsTXV6VC9TVG1MSjArTnJySWN3Smlz?=
 =?utf-8?B?SmJaNVdKMGRubnlORVNocGRFSE9BUDdiVE9xelJONFQydHJGQ0VLK1lUcDRp?=
 =?utf-8?B?YnEwQ2Z3WVcyenBEbjBoZHlEVEllNEFaRkhxU2tBbVJYamhQQkdSbmVxazcw?=
 =?utf-8?B?Qm14SmQwaWEvS0R5amx3aXpqRmNvRXBXS2xGc1dQdDJFVDJQeGJVTGUxd0Rj?=
 =?utf-8?B?V3lJSjB6R2IzWXBhQVhzcnZya3dObW0zdUNkRXR6Nnh5MUN2NzVZellNakhz?=
 =?utf-8?B?ak9jcEF3NmcvRE5mK0RJV1NWeXZ4dEprblM4bWZYZkR3dGNoV1g1TmhFU2FW?=
 =?utf-8?B?N0QrRFhOSCt6bmZ3T0NNZitqc0k0RHRVemNOekxMbWxvMVFseU01TUNUcUpX?=
 =?utf-8?B?dUhMT3Y4Yllna0JQeUo5VlFEWk9DeldEa01lQi93OWN4WmxvS1lJaVV6V1dK?=
 =?utf-8?B?akdqQTI3cFBCdDJ1c2dwU3JSeVBMT0c0dVg2cHc3U1lKZEI2WjB6VHl3aWdV?=
 =?utf-8?B?RmhXYzhmT1lNdWREL3FUeVQ2eGZCQTVjTEZ6RmVLYjZWUTMwZXFUZG9NYUJ2?=
 =?utf-8?B?aG5YdURPTUN5SGNpeWVmMi91ZE12T2o5MUlianlkckNBK3pPcXNXWlNXOFY2?=
 =?utf-8?B?T0RUUlNTbXA3VlhJaExsbnU3TlE3c1dQQjREcW40VXgyTUJUWm9DaTBiclZm?=
 =?utf-8?B?UUUvdTNHRDlxM1d6bURhTHY3WXlVcUhWSWlzTklCSkFiUDFHc1YyL1hpZXdX?=
 =?utf-8?B?L1E0MEpmSzE2c0JvTHgrYUdxaElVV050Zm1XU3pXR01GNTc2UlNJYnpFRWEz?=
 =?utf-8?B?cnhqRVVGUXhwM1krQm5VMTkyUUdVNnNvT0t5VXJpRWkwdkxlNTA1bjc0UE0v?=
 =?utf-8?B?bE5yN3BmMkNLN1U4Q094UVNucXkyOVd3YTl5TlA0RWV4Q0pPb3Y0UUZ2OWVL?=
 =?utf-8?B?T2IwMWd6TUtoV0VlMGNsUXRJUTJVTkZ0UGVKOWd0SitOZ0luSWE4Y0Q3L3hw?=
 =?utf-8?B?anlwYVlLbGprRDdDY05QTUhNUXVWcmpub29YZytFL2EvQWdlbld6R0R2MkJD?=
 =?utf-8?B?NmZQK1NIWnUzYk5mMkVNRUN2d0JFVGJvR1YrdXdvMTU1NjdhNEVHZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b75e2b30-e0e1-4054-51ba-08da38942d49
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2022 06:03:51.9783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GkAEcPHAJHtB/mnzoUESmk6cQ/shCQWRczysNsWlMfLGxG6sG/X9LmD6FSykRy3/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0250
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
Cc: Zoy.Bai@amd.com, lijo.lazar@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 17.05.22 um 21:20 schrieb Andrey Grodzovsky:
> We need to be able to non blocking cancel pending reset works
> from within GPU reset. Currently kernel API allows this only
> for delayed_work and not for work_struct. Switch to delayed
> work and queue it with delay 0 which is equal to queueing work
> struct.

Ok well that needs further explanation. Why should this be used exactly?

Christian.

>
> Signed-off-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h   | 2 +-
>   drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c      | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c      | 4 ++--
>   6 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 3948e7db6ad7..ea41edf52a6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5309,7 +5309,7 @@ int amdgpu_device_gpu_recover_imp(struct amdgpu_device *adev,
>   }
>   
>   struct amdgpu_recover_work_struct {
> -	struct work_struct base;
> +	struct delayed_work base;
>   	struct amdgpu_device *adev;
>   	struct amdgpu_job *job;
>   	int ret;
> @@ -5317,7 +5317,7 @@ struct amdgpu_recover_work_struct {
>   
>   static void amdgpu_device_queue_gpu_recover_work(struct work_struct *work)
>   {
> -	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base);
> +	struct amdgpu_recover_work_struct *recover_work = container_of(work, struct amdgpu_recover_work_struct, base.work);
>   
>   	amdgpu_device_gpu_recover_imp(recover_work->adev, recover_work->job);
>   }
> @@ -5329,12 +5329,12 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   {
>   	struct amdgpu_recover_work_struct work = {.adev = adev, .job = job};
>   
> -	INIT_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
> +	INIT_DELAYED_WORK(&work.base, amdgpu_device_queue_gpu_recover_work);
>   
>   	if (!amdgpu_reset_domain_schedule(adev->reset_domain, &work.base))
>   		return -EAGAIN;
>   
> -	flush_work(&work.base);
> +	flush_delayed_work(&work.base);
>   
>   	return atomic_read(&adev->reset_domain->reset_res);
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 9e55a5d7a825..fee9376d495a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -114,9 +114,9 @@ static inline void amdgpu_reset_put_reset_domain(struct amdgpu_reset_domain *dom
>   }
>   
>   static inline bool amdgpu_reset_domain_schedule(struct amdgpu_reset_domain *domain,
> -						struct work_struct *work)
> +						struct delayed_work *work)
>   {
> -	return queue_work(domain->wq, work);
> +	return queue_delayed_work(domain->wq, work, 0);
>   }
>   
>   void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 239f232f9c02..b53b7a794459 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -230,7 +230,7 @@ struct amdgpu_virt {
>   	uint32_t			reg_val_offs;
>   	struct amdgpu_irq_src		ack_irq;
>   	struct amdgpu_irq_src		rcv_irq;
> -	struct work_struct		flr_work;
> +	struct delayed_work		flr_work;
>   	struct amdgpu_mm_table		mm_table;
>   	const struct amdgpu_virt_ops	*ops;
>   	struct amdgpu_vf_error_buffer	vf_errors;
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index b81acf59870c..aa5f6d6ea1e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -251,7 +251,7 @@ static int xgpu_ai_set_mailbox_ack_irq(struct amdgpu_device *adev,
>   
>   static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
>   {
> -	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
> +	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work.work);
>   	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
>   
> @@ -380,7 +380,7 @@ int xgpu_ai_mailbox_get_irq(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> -	INIT_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
> +	INIT_DELAYED_WORK(&adev->virt.flr_work, xgpu_ai_mailbox_flr_work);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> index 22c10b97ea81..dd9f6b6f62f5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
> @@ -275,7 +275,7 @@ static int xgpu_nv_set_mailbox_ack_irq(struct amdgpu_device *adev,
>   
>   static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
>   {
> -	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
> +	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work.work);
>   	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
>   
> @@ -407,7 +407,7 @@ int xgpu_nv_mailbox_get_irq(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> -	INIT_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
> +	INIT_DELAYED_WORK(&adev->virt.flr_work, xgpu_nv_mailbox_flr_work);
>   
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index 7b63d30b9b79..b11831da1b13 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -512,7 +512,7 @@ static int xgpu_vi_set_mailbox_ack_irq(struct amdgpu_device *adev,
>   
>   static void xgpu_vi_mailbox_flr_work(struct work_struct *work)
>   {
> -	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
> +	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work.work);
>   	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
>   
>   	/* wait until RCV_MSG become 3 */
> @@ -610,7 +610,7 @@ int xgpu_vi_mailbox_get_irq(struct amdgpu_device *adev)
>   		return r;
>   	}
>   
> -	INIT_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
> +	INIT_DELAYED_WORK(&adev->virt.flr_work, xgpu_vi_mailbox_flr_work);
>   
>   	return 0;
>   }

