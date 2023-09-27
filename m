Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5448E82CAE
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Sep 2023 16:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026BF10E56F;
	Wed, 27 Sep 2023 16:40:36 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDF1310E56F
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Sep 2023 16:40:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPmSTBvA0XUgkXSiy2SRT1Uh6Cq5cqgxU/gyqWvVc24hAILX/JwucQvFnzo44j+MqQXDu6Z8eniH/T91Lo3aT9P6xgZcLYQOOXwO8BxX1kXGL3qtaDx9i/4ZydZc1hwGQrID6JhMLrVPLhA2KClh5rfGBCXEH1sy0G9kRwumc6LRx1AXTl023MnF2ycgP7K6TYa8noTRv6S3YMAt7UJv8iVyeso7SRoKUAP+Mjfmtbd6Qrn0q+L+fts+XCULnVFrTW2jn7+XGQ3Oz+SFp1s5I9VQqHJgGR17Jan2dRKb70vJrUqmxoS7CPJvXlwVDc9djhtkTjNy5EFvu6Z7jGEoaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9KKmryrmvOZccdcN6eWt7hO8uO790hX1UM6qzGNfNg=;
 b=UXqN9kX1x0EhoaiGRt1w2+tFThwJZaeFOth0QxJ/DvkVvzq6fqaxysvttYmKjtSZXQ9aiqKMTkC/DKbA8V/joYRSgTNYhbipaUnpTKJJKZ6EcPW3DNBtTpqWS0BnUSvalVyfiBkvYngSJ0YwQJodk4USVXQGUj4Kjv6tqStBUnjxcuO2zF7R8nhkN4usH8Iv9WTti6tgorSBnGZLXl2xE4TMjESXlO5kO8GNwTny+gsIbTTScYvdiwt6P0RkK2B5nRPZKVu/Lf9XaAGjlTd8dgoaHFDOG44ZGecL5fkn47lQGp2ENNYEESZHfmcPp5K5bKlxktigt5FpTXGo0diHCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9KKmryrmvOZccdcN6eWt7hO8uO790hX1UM6qzGNfNg=;
 b=21rInGLB9z+nWsYFQRzA+3raJY0EmiN7HUT5zS3JXRQqS/vyYAZJot3/JY5jGkPXrJTzKy1zgd1mEW8PrYb/CqcdIv0qg2RToGUHOX3HoLbns/5aF7SISgA2XAygQHmdEYTXv6MOzV2vEgUC4YuJegUQ36zlnjAYz+KPDKLQA7k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA0PR12MB7602.namprd12.prod.outlook.com (2603:10b6:208:43a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 27 Sep
 2023 16:40:30 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.016; Wed, 27 Sep 2023
 16:40:30 +0000
Message-ID: <9890fe1c-0fcc-440e-ae82-c69388b7e79c@amd.com>
Date: Wed, 27 Sep 2023 12:40:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdkfd: reduce stack size in
 kfd_topology_add_device()
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230926163938.1013775-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230926163938.1013775-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0224.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA0PR12MB7602:EE_
X-MS-Office365-Filtering-Correlation-Id: 32d8bc44-1ce8-414b-c8bb-08dbbf7875ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXbYdMwnjg4zA2npJBgQm0OdYfB5VEsyAu3Ur8Inr/DGQR6ysO+CPYMS4IpzSmKCPmcvuA8+0urdyhU7HQ6RPpPc4Ki6YygSL5LQOuMioy7Qz2kYjTfVPot++YBqnu4q4C81jwpFIXlcJZsGjcsU0abSID/KDgZgtWBpF9dUjVTqUygXxUKJ6MICPw8VUKedA1E0lxHvgFXSYrXF7nQM69GFeaIIntIIVr9oyUwEh4SZnF/imM91S3W6q3ZLKc/wPGMnwaeEYw8rzRFlJ78cGG1HoU89f0hvJIKchq+Vo5gXoaPS2GvktxIBHNcmqFBNQn1hTsXmz6LuowlqJuOSvrBgv353m9eBCEjU9vtiZPYJjLx/cv3UhKYZlKQ/3kuKYXDP3Efuz3fyp87ozlmJvX4TwwcZcCq3s3K3LNvBUeqxPJvnBWujK+4AU8T3vswiIzJXCopAIr+7xsVRMZmda/vPzJCrVNTVdMxJIu6rH5NHhQUY8SOL+e6nOvL1Lk6ba/Bj87wkaYMu4J4vioY64m8vmil1F1BI/46gkqUnArdb7GQxQpDco37C3grm5AvOCZuYryLwV3Wsdpd2CeEL1LdCRIrQ81o4PgO68VXAWdQOZ1oaNxyVLyx0axYTdHzU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(230922051799003)(1800799009)(451199024)(186009)(31686004)(53546011)(478600001)(6506007)(4326008)(36756003)(6486002)(83380400001)(38100700002)(86362001)(2616005)(31696002)(2906002)(26005)(6512007)(966005)(8936002)(8676002)(66946007)(66476007)(44832011)(66556008)(5660300002)(41300700001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFMwQjYyZUpZa2ExR3A3cEoxWHAvVGg0cGYzLy9CNVdNS1V2ZzR3cUNacm9m?=
 =?utf-8?B?akFacG1TajdKcUJ1WmVXY0x6ZHk0UE5VN3ZkcFd3UmIxWXVDRW5Hbm0vNURT?=
 =?utf-8?B?bFNibWc0TWg0UVRsdm1MWFF1NFNDeFpnSlBhSVNNWTdlQ2pLRWFtWXgxVGpN?=
 =?utf-8?B?TnFCUERvNFFCT04vTDIzSGtLN2p4dDRiSlhFRC9vUUxtdHZkTHRtSGN3VkM3?=
 =?utf-8?B?MHhwM3dGK3BmN1o0NUk2Z2FLUXpMVTdCN3IyenhpT0lZZm5aZFVoN0tLSzZv?=
 =?utf-8?B?bGxlMDErc201Y0NoZ056ZnpIUnVZNlVsQ2pzWDJldHljZjVkRnFpb0lrWDFP?=
 =?utf-8?B?cVVxL2NxcFhXcVZkeGNVQTI4b0NmZTRuT0RsRDcydjdHbXNuaHlFbUUyZWlj?=
 =?utf-8?B?SVFwbjdUYzlqL3dhTHZ3VTR1eWdRVCtHTDYrdS8ycUZBRURnQ0tWVlNaZ2Mr?=
 =?utf-8?B?WWVyb2dHNnpKU3BaUmJIUkdCeUtHQktaOEVoT1IwbEZ6TkxValQvemlmTkEz?=
 =?utf-8?B?Q2doeGdxK1MxNXgyUzhTQjBpZmRaK0c0NTY3RHNkRzMvUjFBL3lieWZVWjAv?=
 =?utf-8?B?RWJ4NVBaTU92eG5lNnFHcFF1WmdiS0lpOU1rWXN5V3RHbnArZnMzNzBjOHJI?=
 =?utf-8?B?NzFsUHRjdGtCY0xKakQ5L0ZLaFV1eXpFbnpxeStZYkFmTXF1T09GTCtTK0o1?=
 =?utf-8?B?RlJ5T0s0bTUzZTE5cEVkc1J6YVV2YWtUZVZaRk9Ud3Rqamp6YXBmd1JENFRz?=
 =?utf-8?B?Nmxkb29uT2JXMkVYVnV6RFpQOExPYll6L1ZSWG9Vd0V2WW9YV1VDaGhKUE9T?=
 =?utf-8?B?SE5lU08vVGFRaXVxWkorZEVxS2Y0ZmQ0L1htOHVPYXpVd084VVhvSkZMQzR5?=
 =?utf-8?B?d0dyRHphUXg4VjdiTHZwbVhhMUVhUUlYdEdISHV4bjlrQ25qR001ZXY4RzAy?=
 =?utf-8?B?alBFMEdleWtsVXR1cFRXUWJEN3VaQnlESGFtRE10Qk5lTWl6WFB2UkJOalhu?=
 =?utf-8?B?VU1xNXZvaVAvdXk2bFJycUx4azBSM2RnMUh2NldEUDdYZ0c1em9XUkV3cGJz?=
 =?utf-8?B?L3d1dzlEMWpIc3JodXoyUHRFeVZCTmNYUHF2Y29hSVpsdnZUUzVCMnAxdFlF?=
 =?utf-8?B?TFZDY2RRYW5ocjdrMFVwWnV1SDNTY1JxWmtrajhiT2RFUFVMRE4zQ1l0NXI1?=
 =?utf-8?B?eEpFc21YbGRlcWt4Z3VmZCtBeFdQV0sxYTVNWWNEZHZ4M3RuZ01pSFMyRHlw?=
 =?utf-8?B?OFUweE1ab0IzWDFnbWtOU0N1a0dFSlBDT3VvNXAyQWZEb3k0azA0aVc1a29B?=
 =?utf-8?B?b1pRNmUrc005UVFkODQ3aC9RU09nWnNFMCtjYVo2Q3pqb0NIMDdRRk9xQ3JU?=
 =?utf-8?B?L0xYam5MNlVZTUJFSDNJVmxNUkhqMXkwb2hkcmZ6RVIwOHREREdrbFlJQ05Z?=
 =?utf-8?B?Z0crTGsySi9mT1BnMS9vM0xlcWJvd3d0WC8zOFJDTDdmRjRlay9HOVB5Q1ll?=
 =?utf-8?B?allXZTF2N2ZBRk1qWjlxaFVWMHFtQ2g4VjdhaGZ5YnUzbDZIWWhSR214R2NI?=
 =?utf-8?B?aTA5WGlCZTl6Z3l6TUxiUlEzdVBuVnk4K2VUSXhrV1VBYzhUcXkvR1J1UW9q?=
 =?utf-8?B?OE4yZDM0ZVlyQVlXR2NwT1hsRjhRaU15UzVpK1NsdTBuTzRGeDQwWjE5aHF3?=
 =?utf-8?B?c0gzNXN2alo5N0szVlg3OHUvM3hhVUFvdmYrUHNTSEpvaDZHem1uckFNSWEr?=
 =?utf-8?B?d0ZiaHUzS1MvQXhyRXlPc2pZYUE4K3M4K3BNVHVncGFQcUorbWZpc3VqUmFk?=
 =?utf-8?B?eVFyY1V5aDR0d0crZ2NHYUFpZEZHSmEyNTM0NFFaVDdJSGhHVTVFUHlhV1pJ?=
 =?utf-8?B?Y0tocm9jWTJnZXlIN2xTUWNEdWJpVzY2NWZJZWl1VVpFL3FESVNjUmRpTXBM?=
 =?utf-8?B?WnVYbHRDZVBjRGdxWm1paHRXUW9kb1loUkZlc1cvT3FCd2F4RmhFK2VFRGhB?=
 =?utf-8?B?OFpoSG4ycnlaQkhISkNxUjM2dTkvTkRHUmxXZ0NaT1U5NUlkUk5UT1VUMlFL?=
 =?utf-8?B?RG9vU21XaWlpWmcwMHVHVG42SEJiMTBsRVJESE9vRTVXOHNSeUJzMGJqWkw0?=
 =?utf-8?Q?9w2slVlJQh9KfES5TTkY40Z26?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32d8bc44-1ce8-414b-c8bb-08dbbf7875ff
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2023 16:40:30.0862 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GOe/fo8kuBgdqqtcyNtShB2Zf42mN1TRwM/nCjw/XlF4zP0yyT0fLdXhwyVSpSP37AMP1TILxnH2GZyBHmOE3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7602
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
Cc: Arnd Bergmann <arnd@kernel.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-26 12:39, Alex Deucher wrote:
> kfd_topology.c:2082:1: warning: the frame size of 1440 bytes is larger than 1024 bytes
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2866
> Cc: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 13 +++++++++----
>   1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index c8c75ff7cea8..3f9f882d3f5c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1918,7 +1918,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   {
>   	uint32_t gpu_id;
>   	struct kfd_topology_device *dev;
> -	struct kfd_cu_info cu_info;
> +	struct kfd_cu_info *cu_info;
>   	int res = 0;
>   	int i;
>   	const char *asic_name = amdgpu_asic_name[gpu->adev->asic_type];
> @@ -1959,8 +1959,11 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	/* Fill-in additional information that is not available in CRAT but
>   	 * needed for the topology
>   	 */
> +	cu_info = kzalloc(sizeof(struct kfd_cu_info), GFP_KERNEL);
> +	if (!cu_info)
> +		return -ENOMEM;
>   
> -	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, &cu_info);
> +	amdgpu_amdkfd_get_cu_info(dev->gpu->adev, cu_info);
>   
>   	for (i = 0; i < KFD_TOPOLOGY_PUBLIC_NAME_SIZE-1; i++) {
>   		dev->node_props.name[i] = __tolower(asic_name[i]);
> @@ -1970,7 +1973,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	dev->node_props.name[i] = '\0';
>   
>   	dev->node_props.simd_arrays_per_engine =
> -		cu_info.num_shader_arrays_per_engine;
> +		cu_info->num_shader_arrays_per_engine;
>   
>   	dev->node_props.gfx_target_version =
>   				gpu->kfd->device_info.gfx_target_version;
> @@ -2051,7 +2054,7 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   	 */
>   	if (dev->gpu->adev->asic_type == CHIP_CARRIZO) {
>   		dev->node_props.simd_count =
> -			cu_info.simd_per_cu * cu_info.cu_active_number;
> +			cu_info->simd_per_cu * cu_info->cu_active_number;
>   		dev->node_props.max_waves_per_simd = 10;
>   	}
>   
> @@ -2078,6 +2081,8 @@ int kfd_topology_add_device(struct kfd_node *gpu)
>   
>   	kfd_notify_gpu_change(gpu_id, 1);
>   
> +	kfree(cu_info);
> +
>   	return 0;
>   }
>   
