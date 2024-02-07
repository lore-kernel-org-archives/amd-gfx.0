Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A9FC4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 05:38:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B8F010E1EC;
	Wed,  7 Feb 2024 05:38:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h7qKg38d";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92BF810E1EC
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 05:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CyEhKF45oRl1MkbJ0DBtWePuZ1DnFjqBod8uYEmMX4EFJYOYnzAie2CvB8RmtFlUQCskI0/W5XhqAtaQSDdK8WWC5wmD6dRbXIrKYbBopmoLzYzwZAoQKEfkpA7o2CfBmTFgeNnOKeo9MfBYhFgLcB764HBNmNYg1DTcbQGBgKmVvVsBVLGNZ23mBbMMSMBmik7GntkoMpnS9jY+Fj1UPTcGPWpTVQEt8CGJdAP4p5yhZdHCl5VFA7uYSHMW8vjqWACR5CFseBwcSo7GlhHrGppN1/0RC+7C4l4io+TICHA+tByI8clc56O4RE1wh25NY6dWiK3XA5ER04Bkn6YlxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucCEjLMaZQ2/zYgBpEwKdshgArPpA7zaG6FHLLc7cvM=;
 b=Cuc8TtOxEIvjNDVBlnY27+1CYP9G2jCqw2FcQ1SralfZsgpiuY0Vjnps8nd0nlbwJQOisvyB3ViFjGxez3Nn3BbtHh2Gjim+Dc0IDBEFzc0dJk7kcmt4tCjQs1aps9ggobdLxHLDVCs4y6YjjdDoxSc3N1wioPhWLeFv68xoWxdRJpINEyEvNgpbEbodvDr8HXjaSwH702Ki+QqDPqQO/o8S9AmIxmW/60FTBKPHuzG/nvNwz31Rk3LH0bbC7d+3ZkYZK6HrOfwcbmCNKBIwrbNQrKiq5akI1S851d6RaLSGsevtHOQ+nSg4W/pqp+j4wp2IYG9lSDbVSk/kGMmk9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucCEjLMaZQ2/zYgBpEwKdshgArPpA7zaG6FHLLc7cvM=;
 b=h7qKg38dW5h19AYmbNYU4JWxJA2NVl3GNt2ZDSCfXNc15VL1d8P3GzFhdIUKbFpBe/YtmVTiCCEbJigE+vQ1nfkc718GA9vwbRDwHsvNKQswxWqcTkrtTkmbyoTysRUVzhFJMu1ZcsxpHZ0Z5mjT+tDPKxs6fC457kmOchLqyu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6235.namprd12.prod.outlook.com (2603:10b6:208:3e5::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Wed, 7 Feb
 2024 05:38:25 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7270.012; Wed, 7 Feb 2024
 05:38:25 +0000
Message-ID: <2ad2d30c-49e0-43bc-839b-ad7b3d831734@amd.com>
Date: Wed, 7 Feb 2024 00:38:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: Initialize kfd_gpu_cache_info for KFD
 topology
Content-Language: en-US
To: Joseph Greathouse <Joseph.Greathouse@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <d4f0a9e8-54df-42d8-b130-e1b2977b8bde@amd.com>
 <20240207053200.2903401-1-Joseph.Greathouse@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20240207053200.2903401-1-Joseph.Greathouse@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:7e::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6235:EE_
X-MS-Office365-Filtering-Correlation-Id: 02010725-b5ed-4ccb-da84-08dc279f0145
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CZEW5SI1I2hMpKWOJawUA4FQJ6jEZEcIStFC7JY9vYK2k22i6+WZu6mJNYv2eCRZ16lXDgrA6kMfxerWgPDQdQH4wjcgE07OMQjmQpaXNnkCpoufVbO+u7cla2wSWJtd3ETbtbrMwyuGCnFatPevJp55MdG5NUSi2ajRhe34Pnx7fhbtipnJbWktwXGFCZoXjaK2b7tkvA9JmYcobi9CCT4FcKzP71pq+kE4FrHfstX9UL1lUv4jkq64KaNtyf4b1BGdoDT6i51i7Jpp7QRrCdbttXIFwLXr2/FjpEVadD+Ft1+NO1DC00SuXMzCJuL7cAjZMJx98B+zAkTGwQUhjuFqodrjRjaPeqEnurw/kOtmujXUIjSccsonyRgyejPlpGwtbhR2SGk89F5jtnp9AtBN7SX5UteopUv64d/u9yc4xyR2L4XjsSiKK+kmuvn26+92z3VGTF673uispoxfBP3SuEJquCbIJFeujxM+x9j9gJr3nv5a46bBUKekJ5sfS7uYwrco3aQ++xLG1kEUytOjSAYJiNsW7ZB+6bU+UIH96BEiF8+pti+bu4SBmUiciP8/riR6uINMmQYqoEk1VQTH2vHqbZ+7BDEWQ4MZ42cUlV4XhiKKkD130Z6a57OWDRKun7Y8qJNn5eb7bBsV3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(39860400002)(366004)(346002)(376002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(6486002)(26005)(44832011)(6506007)(4326008)(66946007)(8676002)(53546011)(6512007)(478600001)(31696002)(5660300002)(316002)(2616005)(38100700002)(66556008)(31686004)(86362001)(66476007)(2906002)(36756003)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVpGRGp2NjRCYUZtOCtrZFoyYnM1TE9VajFtVUxrazV3bkozQ29kYUZrYWtU?=
 =?utf-8?B?dEd3cUorSHB2aDlYMnZWYXJqQmtCQ21ZRnJJbUgwZ1k3eG9haGVrS0I1alY3?=
 =?utf-8?B?N0NsTkhTSnoxUlRJY2F5bnpMbDdvZkxTNHhaUTdYcmpVaXFzOEVQV05CWE45?=
 =?utf-8?B?ZFk4UVBpV21tcEQ4azN5YXZWSk5uRjlFR1p5SW9mZ3RSSElvYUdOSnFZSnZi?=
 =?utf-8?B?SGM5TnZDeWdqaU0zUEE2eitBY01ZMnZ2Zks2Tmk3a2R1Q1BlTFlMN1N6MlFS?=
 =?utf-8?B?TW1nRTEyRENsSXlZd0tMSmFtUkczb2FzYVVxUWlIQWlkUTdpc0xJOHkySHJj?=
 =?utf-8?B?SHpCWThLZWV1QjVUdnhRVlIrdmhGZE9SUm9ORVpvRDdPTmJBaUZVVkZrbzlk?=
 =?utf-8?B?dEUwK3ZPMytUMGlPbElkRm5NOE1PUzI5UENrZ0NhQ3JXcWxoRzFMelo3MU5I?=
 =?utf-8?B?bUdFeUFQSEJuSCtXV1hFVmVxYUV5QTF6Z3VkbmpldVRFc0VQWVNtQ3ZZTzlF?=
 =?utf-8?B?N0RkWG1vL1pkeTl4YUJJZlRMVHRQUnJOblk4aU0zejB4eW96bXFBd1h6NG1N?=
 =?utf-8?B?MGhrYUdTaU1laWgvVDRubnVpMlZVVU9FeGtnSHp3cEF1QVgySUZxdkxuazdt?=
 =?utf-8?B?MWJtSU5wY093QjVQMU5hb2xUYTlsY255WjNYSUUyTi95QmZwMlE2TUFjS21w?=
 =?utf-8?B?MXNYZUI1Y2kyY0Z3VGlrN3EwZHZweWhyd0gzVFN4bXRxbFdxTVBxR3pad2l1?=
 =?utf-8?B?QmJCczI4YkVUMFowYkhFQWovSEFURk5yV1NVZFNWR2gvbFNiMTFGcFR1Skpu?=
 =?utf-8?B?UDR6Y21oNjlROFV3eEx3Vi9FaCt6OXJWZWVnV1Vpb01OZ0lLMHl1Z29JVG1Q?=
 =?utf-8?B?amJvT1JvbkJpM1B0Z0UrVFdtUmF5eDVEbFYxOXROMERKL1dPWU13bHlPNmh3?=
 =?utf-8?B?TVB1RWtlWGhHTi9iMWdVYUdoSHFHSHg0YW5tUUp4Zi9sN3lJWE9KaU9mL1hl?=
 =?utf-8?B?clB0YzhPOGZiTlJxSG5RYkV5TUlJWWp3a1RTR0U4SitVdSs0b2liNnFTSkFI?=
 =?utf-8?B?dVMwTm00UGdVbUtrVkJlemJGUzllMlBoSlduVFZMdzFOd3RaYWxNQWx0RTI1?=
 =?utf-8?B?VDhIdGFnVEdvZnhDYktsdFpJOGtiZllrV2NqdXpFMTFhdGNOYVo5dmN1eHJR?=
 =?utf-8?B?T3RYUFNvVURMV05mZ2Q2aDU4TSs2ZmtHYmNoYjcyV1hkMjRHaTREK1duKysv?=
 =?utf-8?B?WkQzUFZ0Ymg5ajdTRjJWMFZVU2E4VzNVOGVKdW1TVnRhU05TdEZhd215MzFG?=
 =?utf-8?B?djlVZXNtSUFnMm5WUHcvUnBQbEhRMDdBZnNGdVFSeU0rTXIzcXVzMVBEc2NF?=
 =?utf-8?B?VFJuam5BUkYreEdxbUI2dVZQN0FYamFKaE1Yb1VzekFhMEM3ZkpQRHNCcytN?=
 =?utf-8?B?M2crNFpPenFmNnZwOHJ3ajdLN3dOaEFHeDdabHh3WjhEVnl4T1gyNW5Ebzlz?=
 =?utf-8?B?NTFzUTBPOHNJUkVmbFhsTTdpSzg4cHp3MDBVYnVBc25nNDY0bHhtYXkxUTds?=
 =?utf-8?B?b21JaUVaaE1PNnNSb0wxa2w4dlRqZWJzdVlITVFBV2ZaTE50ZFc5MDRMa2xY?=
 =?utf-8?B?TkluNGFLQWt1UGpnbEFtcG5VMWpaRGNWaTkzVmpwdXF2TU91ZHlRakFwcDBO?=
 =?utf-8?B?VFgwbG1OOGd4VDhlMHBIK2lOdk1nQWY0Vm03NWovazBGOE9ZL0hFZEhjaEQ2?=
 =?utf-8?B?U1ZVcmtUUW1CQmdCSDFaeFIrTmc4M0Q0TTMzWDVpMy9ZdkJ1TWlCdXlWK0RF?=
 =?utf-8?B?QW5Bb2tHaFo0ZnZOS3FLR09PaXZVWVhyTHlwYndaaFVpZzZ3ZVZtaFg2U2tm?=
 =?utf-8?B?Y2xZazhyL05xdW5tU2FxQXZabUUvMHNCRE9acUROeHJ2dWx5MncwLzJnT05T?=
 =?utf-8?B?UjVLbDcxSFZiR2lodUxIYzNuckZEdTR6Z3pFcUVGdzZzbGtMUlRVQ2c4TmEy?=
 =?utf-8?B?anlPeHlOWGhNdGlTdkJJVXVOMEgwNUxrOHFZcjhIUTdBUDZLdjNOWGF4ai8r?=
 =?utf-8?B?YjhSOG5oalFjMjZna21pRldnY2pnR2FaRFJYTkNyZnFnT3lpWTdJMGRCOHVk?=
 =?utf-8?Q?bv/lhgOUaZwScoThpuJop/2uK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02010725-b5ed-4ccb-da84-08dc279f0145
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 05:38:25.5917 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BIiC7nyrSg7vbcfMjUBCUk9mMME4cBOMgeINi2QeQuavLggnYawm73iebRBEM9H32yboZ7GxLgo78J0kNN18Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6235
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

On 2024-02-07 0:32, Joseph Greathouse wrote:
> The current kfd_gpu_cache_info structure is only partially
> filled in for some architectures. This means that for devices
> where we do not fill in some fields, we can returned
> uninitialized values through  the KFD topology.
> Zero out the kfd_gpu_cache_info before asking the remaining
> fields to be filled in by lower-level functions.
>
> Fixes: 04756ac9a24c ("drm/amdkfd: Add cache line sizes to KFD topology")
> Signed-off-by: Joseph Greathouse <Joseph.Greathouse@amd.com>

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 3df2a8ad86fb..5cb0465493b8 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1707,6 +1707,7 @@ static void kfd_fill_cache_non_crat_info(struct kfd_topology_device *dev, struct
>   
>   	gpu_processor_id = dev->node_props.simd_id_base;
>   
> +	memset(cache_info, 0, sizeof(cache_info));
>   	pcache_info = cache_info;
>   	num_of_cache_types = kfd_get_gpu_cache_info(kdev, &pcache_info);
>   	if (!num_of_cache_types) {
