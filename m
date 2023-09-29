Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAA2AE728F3
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Sep 2023 20:54:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4EDA810E143;
	Fri, 29 Sep 2023 20:54:31 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::61f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1CCB10E13D
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Sep 2023 20:54:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6/T6PTk2Fxj2VkYq0lhd9uaROlBgJgMkuykVhEjjPMZqVg9l8Li6un/XquH28PX8UOKRNRuzgN7bxsu46Oo3VSckHtfwxr9sZpRkKtrFQneDT21NQodoLTP89Ngad7yEMz/upjAc4MM3SgO7ZXFAD5ihU+F+QzN7BQB0qjYHNIGzoa7zY6qKHooJypzZTKeeMRu+Qz8KkY7+i4PeEfpaSjxaBmDMm6Szd5HCSSAZWkTBZn0s/oT4xeKjPDsqAR+FYUSM+ySXtxhypkySLZVffrRsRu4RyF0++dDtDCP/kMh6ikC08xJpuqoVgIkFLH5e/J17nShk9rETBymvcP9fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7n9/8Is18W8PM949I0RSHjDtfIhpa73EihhRE4395+E=;
 b=aB60AHMIg8kJda5upj+JfIRYimFbvczU7s5uuSCReoMPzWAoOYW3LdBEzS95SlkoRK4EtVGRMMgz/3qxxN/3BNv8R2jboKG1boTIMKodhXqIBsqkwSoCUdxXj/VI39uctlm0xvi7H5GUc/90DWPPQhTOaKUtwkpa97IpZzq3BPXkGviFC19/OXiRo8oAkHPKCcBsxkzscDF3OkdOjN0c7IzGXij0y1zrfLh3cRh/si4h78yOcYuqfJNRDyoAin5So9guGmbcQ2Z+nTfDGGcB6jwP7zxAfY6sIB+s5HBGOJHSW3SuAJ74iHhcL3YKj3KE2pvRJlXwFekc2J3K4dfb+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7n9/8Is18W8PM949I0RSHjDtfIhpa73EihhRE4395+E=;
 b=ldQ1mROc4NTL2DD+73bwIKfdAo/Vcjr5F11E2/xY3dK+f++ESyNju+XkbqJvthTHTWhfvDdASdMvyI0Tgnish99q8hDJ7SfLaw4oUEKLrxHNn/PHE67DsKnYPl4VPDqGaj9KFDP21gFlpW7XMoErxo4MHriB6yoj3yF9poF0EbA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN0PR12MB6247.namprd12.prod.outlook.com (2603:10b6:208:3c1::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 29 Sep
 2023 20:54:27 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6838.027; Fri, 29 Sep 2023
 20:54:27 +0000
Message-ID: <2bb14825-e0fe-83a8-bbf1-143529490408@amd.com>
Date: Fri, 29 Sep 2023 16:54:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] drm/amdgpu: Rework KFD memory max limits
Content-Language: en-US
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20230929181856.2311515-1-rajneesh.bhardwaj@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230929181856.2311515-1-rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0104.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MN0PR12MB6247:EE_
X-MS-Office365-Filtering-Correlation-Id: b8c7ac32-3824-4dbd-180e-08dbc12e44ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F/2+LEbAKt9vm2i+gU75zrH87xarDoYKf5OmGTLQMbxxrEaVAzyVjIDgJ4BhjObSvxu9HGB6ja50dyhSfvM9mZ/u/dlwLYkcb+k9q2uZmSFNwrcLjr+xiNYvGSsD1HkocYtihTvKTGVl+QskZOEGWGUQTZ3kRSyWVvSpkx6f0iKH7PptgJu8fkMu6GZJyqWN+7g2Ah4T3QnhpgIx3tdOPi5519c6NWzu9C1d0u9eZDZdrlFt+NYIBnppq7xCXpLtt8O1ZU7SUJeiJnqhmpnT2andRUjgOyMi+dLpV8bZjmq23OXjK/w+1HW987KN4VIHnnTQxtZ6XOM13xT3BwAZwFPRw+JWaKoA8X+Msatg0TRRaLZZLpeJV32T9u5BuJ/kUypseYkltrq/Vpr0RcYsIPQm4wgWfINmltbe1Z0Dgx6F7gaNH+UEfhQ4dAPYnHNODJknwYZwcMGY7ujdezh87c/nK+si+TNpNR3FXnXVNqsIklUy4IIfHqYKIOPC2OAxjhnL/JrCY++jhAjxFdNwUEoHlvLFVwl7DmnK0pLKtR6PXZp/IwbAuCUa9UlXmyiRHqP1XHxBLlLCXMZLroY7zp8Q0y+4rpSBSha42KWtOQm2jFiDbAW13oL0nn09MOzbwScRTwxV5sh7fAxCVEwSDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(86362001)(5660300002)(4326008)(36756003)(44832011)(26005)(6512007)(8676002)(2616005)(41300700001)(8936002)(38100700002)(31696002)(83380400001)(316002)(2906002)(478600001)(53546011)(36916002)(6486002)(6506007)(66556008)(66476007)(66946007)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVo5RXkrdmRva1FCVjFnd21ZckowTnJaL1Y4dGc3TXgxSDJEWGZweDI4eWJW?=
 =?utf-8?B?UEljTjV1aTVVK1RuOG1EemJtb2pNcXQzbHYzdFdjUTFjZkt1RHZKNDljZTAw?=
 =?utf-8?B?WEIyS2V5WU9KeTgxcjcrZVdWZHJtT0JyR0NWWUpEVTJldzdnZWR6cVlISkFW?=
 =?utf-8?B?V204N2FzQ2R5OW82QmdQNE5nL05jYjhLNStRd3VpcXN0VmNyTVFXeWhRVE9J?=
 =?utf-8?B?MUprekJiZjVyY1hNVjA5UWgxa3NYOEVDS3RqODQzMklHT1lEVE1oeW43L2F1?=
 =?utf-8?B?ZElQYW0rckszYjNQelVQRENVa0VqWVhkaFRYVXpGdjNFcnJJT3BvZ0w1RHBl?=
 =?utf-8?B?d2VGT2tzZnh1cUtvRzRMOUFrd0F3K0dRNUh5eS9ibXJhMEJjc2k0bDFNLzNt?=
 =?utf-8?B?RHR1VnFMSWQ3MDZMUkhEU3JvVTU3cHlHSjhRb1hhWVBJekp6MlZHN2UzbGdn?=
 =?utf-8?B?VUVxRU9SWVpkQnZjYkpvTGpCZlAxYldvcG10NVFGMElhSTB3UkgrYU5qd2t6?=
 =?utf-8?B?WDhNVlpjcHVkK1h0Mnc5eDBlNjl0MzJrME9nT2RtVXUrQWsyZ1hMZkUyWXVS?=
 =?utf-8?B?R3A1ZDMvV3RrLzhGM1dRUGw5QUlIRG9Jbmx5TDBIUkQxUlFlcUhNdVM2NGZN?=
 =?utf-8?B?eTdlbU9aaGg5b1hSa25WNkw5S3ZhTi9zZGJCWjdWNjRNK3lJaWh6bmpPenhz?=
 =?utf-8?B?aFZQL3BQbTNxODlOMDJvc3Buck1JUFFPTTNQTkxnSGFmNFQ1YUhSdlRzZHd2?=
 =?utf-8?B?WVpwZS9hWVFPRXJiWE81b0h2UDJYMWhXSjVMYjJlZDhoUWxweUo3SEhBbm4z?=
 =?utf-8?B?UXpmVGZNQVRRSER2M0xaemNTbG00cDM3U2g2elg5ODBFQURqdDRVYmVVQTNp?=
 =?utf-8?B?MjJNSklhM3AyMmVMREo1d3VNeGU2c2VkUHVMV3dRTGZzeUZLZEJjK3BPZ3Nr?=
 =?utf-8?B?Ym83aGI3QjRRNnFDNzhHMG15ajRXU1BVUHhiZk5LVHlHREQvNzdYWkhIZzRE?=
 =?utf-8?B?cCtkSHZjVDJtc0JsWm12eERXcnVrM0Fmc0ZkSWJiMjQ4NklhWWRYK2cvWU1X?=
 =?utf-8?B?WnRjUVpKWjdqL21BMW14NWFiR3NqNDYvZGt4QjVKWFNXSVptRW53ODhoNHhP?=
 =?utf-8?B?RDJtbGxzN1dxRVNDN1hUMjRhSjZYbU5jUG5MNjY1Y1RvcWxZT0RmTlBZTlVT?=
 =?utf-8?B?Uys5ajBrbDRKL21SeXFlYWR2T01FRk4vK0hCYWJvNDc0WXZ5dXhwL1JVM3ZL?=
 =?utf-8?B?enZGdWlrRzJUKzhrREoyVG1UZmN6TlV6K2xDNGE1RFdzdlNudFRnNGYxRzBu?=
 =?utf-8?B?OVVlb3BhSnNyakJId1dkTGkvSmZqL2c1cVVseVQvUm0vTGk0STdmZUFTUk5V?=
 =?utf-8?B?dWdkZU5Xd0tRZWtHZE1CZlNTMXJqdkUrL2hSR0RnbVVGVW9vMDl6c3hWdGw5?=
 =?utf-8?B?KzZtUm5VUndwZG42b2J2anVmaS9yTUlXTzhWNDNYVFVBSDBVV2w4d01DUExI?=
 =?utf-8?B?Z2Q2WEd6anNQdHNrWk4xRmlmK2hnTjV0TGYzYkt3OXd1R0NDYWRRc2NDU2kz?=
 =?utf-8?B?T1RYK2pXMnBNNWdNTmRWTHluNmpPVTVjK3hjK0xHL1pMRWY0TVFzTGtwN0Ev?=
 =?utf-8?B?dGdyWVVMclUyb1IrTzlQQXNDVkdxQi9pczZubVZBaE9NV01nZXhXWURFejFa?=
 =?utf-8?B?WXJ6UlgvNUhBRFFiVGZ0MzlYWnVjOThlazdNTUZTd05TMkljNytHQWlmWm5H?=
 =?utf-8?B?MklTcHVRamMrZyttOGZGS2UxZGY0V3RMazI0YnNWUUhMaHVDb21SN3lweWFP?=
 =?utf-8?B?N285L1dUaHFzNWZ2ZHVEMVZIc21RRnRrWTRrWXZTTEsrSENpUnZOamhFaUsy?=
 =?utf-8?B?bVJrL3ZSTEZFZTJIa2I3WVdpbkhYalJNRGZWTi95R0tuOG9DeFYrOFo1cVhx?=
 =?utf-8?B?QVMwVTlkU1Q0SXR4aUdqVmpyRWMvc3I0MXN1N2ZhY3Nha3dENFc2TU1YOTZW?=
 =?utf-8?B?aUdubEFFaVlQL08rc3NUT1pkRTdINHBqUjQ2VVVOdmUweFBZM1V4YjN0dm9Z?=
 =?utf-8?B?QnQ3Rk80SUlvN0huZUZuVnVnSlcrOXhKd04yWUVjMTQ3WGZncHBUL3QrNW1W?=
 =?utf-8?Q?S9n5UH36orKMFpb0/7eQzYDd5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c7ac32-3824-4dbd-180e-08dbc12e44ce
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 20:54:27.1422 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQDCANVy/4eHmybrQLroPZT3cdgVv+CxN5ewOGCrQKd7z0OZpEWimSRGR83UCxMnVz0Da1oEYQp00bBlvey69g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6247
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
Cc: philip.yang@amd.com, lijo.lazar@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2023-09-29 14:18, Rajneesh Bhardwaj wrote:
> To allow bigger allocations specially on systems such as GFXIP 9.4.3
> that use GTT memory for VRAM allocations, relax the limits to
> maximize ROCm allocations.
>
> Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>

If the new heuristic in patch 1 causes regressions, we can change 
AMDGPU_RESERVE_MEM_LIMIT to something larger, e.g. 1.5 GB (3UL << 29). 
Maybe we should start with that more conservative value to minimize the 
risk on 16GB system memory systems that have proven problematic in the past.

Other than that, patches 1 and 3 are

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index b5b940485059..b1c4e9c0e036 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -42,6 +42,7 @@
>    * changes to accumulate
>    */
>   #define AMDGPU_USERPTR_RESTORE_DELAY_MS 1
> +#define AMDGPU_RESERVE_MEM_LIMIT			(1UL << 30)
>   
>   /*
>    * Align VRAM availability to 2MB to avoid fragmentation caused by 4K allocations in the tail 2MB
> @@ -115,11 +116,16 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>   		return;
>   
>   	si_meminfo(&si);
> -	mem = si.freeram - si.freehigh;
> +	mem = si.totalram - si.totalhigh;
>   	mem *= si.mem_unit;
>   
>   	spin_lock_init(&kfd_mem_limit.mem_limit_lock);
> -	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 4);
> +	kfd_mem_limit.max_system_mem_limit = mem - (mem >> 6);
> +	if (kfd_mem_limit.max_system_mem_limit < 2 * AMDGPU_RESERVE_MEM_LIMIT)
> +		kfd_mem_limit.max_system_mem_limit >>= 1;
> +	else
> +		kfd_mem_limit.max_system_mem_limit -= AMDGPU_RESERVE_MEM_LIMIT;
> +
>   	kfd_mem_limit.max_ttm_mem_limit = ttm_tt_pages_limit() << PAGE_SHIFT;
>   	pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>   		(kfd_mem_limit.max_system_mem_limit >> 20),
