Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BE6C04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 07:40:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BE4411331A;
	Fri, 26 Apr 2024 07:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="z3WtAC+Q";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9157811331A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 07:40:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E13RwNpsFDQvgHawEVh3pYdyxuZaSSIw6OC3UnGG0dx1urn9lbirMnBU4Kvws/OcvTjn2noqmUeRNJBYzkUwFxFPNOhhhJ8ayiBOlvD5dv5udoAvXUeUD15ElAMwsm1B6DiMnw0uIi81eS7koe4Vfyr42kxrO7j5EJk8OfCyYiTziD7WSg4M64KHSV73wQSGD2WYHvB8HevCMBtAIokMaULJ6whOiHU6CCxzvPEhHOV7gult3GDH6peLK0YarTFYuY5s7g1sOus6RtzXOgKuP+cbvwySaVOKG5RM/gpIGVT+Ejq/W2BD1fVgS3wuS3vM9sQjNu5AORaQ4P/ekA51dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF7pdZG+2Vqwm0BGJr1Osld5Gy3wmDsvR+9uW8dhxIw=;
 b=I8gon1k27DaArWnf1bsz4gxwkJ4D20XvCBYDlCuxhBJ6U9SZj033Y4YRxNvER1EThyw3X6HYwQqJbAembooJBt1Tn27kHWqize7DelR91sZp8ocqlUKKFr4S58Qg9zl9Pkkip33djFNjC8+AMT28OEsXbW7lNN9RnXnXpYHHC2rI6htHgD+F/yiclAbuKfUDSk5GUfyhwQW6P9/QDQITh9ESgISelRdurD4PZm+U2Z3o2taa6EX65LMXfdWtGn0UWNCNNZxxfueOpIka2JnVrIipQxc2w5V02YPs1I2eo4HSZxErQJdyW/xa+rubeQjo8UpfFh03ni2dhe2wMDsOWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF7pdZG+2Vqwm0BGJr1Osld5Gy3wmDsvR+9uW8dhxIw=;
 b=z3WtAC+QdPF4oXn695J80hoXeDcIAPzT3+l/0WJlhm46ncLdqWhgEUHCp4bOTMfVAcfqcBOcSb5QL8yRKByia23/2CLPVmajZyFbGhXYKEBFt6cdHKnczUYLrT/EXBaa/cifO+c5YlMfbD4q5xgwi2U8+Sh1mfZvAVKIVCd4AEE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6832.namprd12.prod.outlook.com (2603:10b6:a03:47e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Fri, 26 Apr
 2024 07:40:43 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7519.021; Fri, 26 Apr 2024
 07:40:43 +0000
Message-ID: <b0f50b85-8104-4736-9934-7cc07301eaa0@amd.com>
Date: Fri, 26 Apr 2024 09:40:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] drm/amdgpu: Fix amdgpu_device_reset_sriov retry logic
To: Yunxiang Li <Yunxiang.Li@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, lijo.lazar@amd.com, felix.kuehling@amd.com,
 emily.deng@amd.com
References: <20240426035742.90560-1-Yunxiang.Li@amd.com>
 <20240426035742.90560-3-Yunxiang.Li@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20240426035742.90560-3-Yunxiang.Li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0172.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6832:EE_
X-MS-Office365-Filtering-Correlation-Id: 5efc0833-5e13-4453-ec11-08dc65c42d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUFlSjJUNkt2YktvbWVwbHV2aXIyVStzNlJ6NnZYRmtlVlJnY2RUcW5neWFW?=
 =?utf-8?B?UFFOVFhiM1BNSHg2N09NbzdwWUZIUnMvMGFLSzgyWWRiNUNSUjc1U2RpN1dS?=
 =?utf-8?B?dFQxT3ExdFZYL2FJVTY4eUg2TmJJekY5bFVaSVZwNHRhVFJXdWYvNnlORkY1?=
 =?utf-8?B?Mm53dUtZZHVrczBGMjZSWSs0NTc0cXRPZmEwKzZEME9UOEUyOTJZaEpjZkl1?=
 =?utf-8?B?NFpJZUJTRUtMaVNaZHphQ3hkVFBJMTFra0dQellEd0VsanFPeThsWXkyMlVw?=
 =?utf-8?B?dVJBSVg3UTg1WFVzMVp3T1hTMkc0NWx4M1lwc0M2WlkwRXhlSy9wL3BNV1dK?=
 =?utf-8?B?aHNBbEt1KzdrUThRQXdvQ3hnTlVFQmtsWkxUL0J5YzRoSldEb0VnZGpFcmtS?=
 =?utf-8?B?Vk04SzdFcGs5aXQzeDRySFAxVHB0NjlLVzhtOXM1Z01pelJLWGZtS0JvUzVo?=
 =?utf-8?B?NEpMdElFWE5PbjJhcWNRcXhlMXA5MUN6MFB0L2RwZ21yZ1VzcFo2R0FRVkRH?=
 =?utf-8?B?Mk05TFFUL1MvbUlWQ2NOR0RpcFdkOXZWeVR1aWpEbGZIY3dDSkZNZmwwS0lC?=
 =?utf-8?B?VDNFemJWWk1Ma2cwWUJrZEtDRlJ5UzhtTTFaa0gzc1VtTEQrcHhyWVNDVG9w?=
 =?utf-8?B?S25ZQlhRdUVPd3hlYy9uelhCeCt6M1FSTVRudk9ORW56SnpjeTRnZUlZelFT?=
 =?utf-8?B?bXZoSVMvK1Z0aWFhOXF2YkZsTlduUkNsaHhGZzVXN2I2alh5TDVkaW9OVlBK?=
 =?utf-8?B?Z3p6UUMxOFpxVllmVVVJUkdGUGNoZ05XdTBrcEk2N01sazlGd1hKZERxdENk?=
 =?utf-8?B?UW1pWjJJTmhyMGx3ZDdOSUlVWGhzZVp3OHVmRlR1aGdBV0ZDWjUya0wvaTFq?=
 =?utf-8?B?alE4Z3RpMnpBQUl4QmRjSTN5b3ZIekR6eE15dG9ROWwzWDBUdDdJb0VQSFZN?=
 =?utf-8?B?QmlsMk9vMGtMc2RXeTc4RkJNZTZNeXZOKzFlVHdJK01TTWpML2pWcmhITEV6?=
 =?utf-8?B?a1E1M3hrN0ZRUTZGUldwUlpBWGQ3QnhSM0tiZnFIczR5MlFZc0NuUmI4QnMw?=
 =?utf-8?B?eGMzZ3lsMi9RaG9YN1h4RWNrbFNJMFY4YnhNbEdzalE5Z3p2L1F2SmtCWXdS?=
 =?utf-8?B?bmtSaHJOajEyc2NpQ1dGbk9RTnk3d1B6cHRnMkdBbzIzc0lkN1NEVnhKZXdm?=
 =?utf-8?B?Mk1KaGRsUnRLTlgvdkdzSytYQ3V6ajR5RDltTmVGbGJDSUFSNGttaGMrVkUr?=
 =?utf-8?B?RmowMGN3ckpPZHRqalRpQ0RPbURMSFhWaktHMmtPTzlESjBNRmhkek8yWnV3?=
 =?utf-8?B?aUtwVERPNnk4TysrNlpFRHpYRHJUbW1BY3dRaG1ienprRUFrUmVJdU50dklW?=
 =?utf-8?B?cWlIZVRvNUdEVmNndXlBOHJuVTB2aUFnQTloL1REeEF1R0hSRHJoZXZGRWRX?=
 =?utf-8?B?OGxQc3BvWVg3QnVHWDFvelZpSkxodGUyYkoySjg1d0QwcVVaQzdsS0xhWXh2?=
 =?utf-8?B?M1RZbnM2MitELzZpVkM4eWsxM1g5VFhvSVcrTnpseElBOElYTlpOem9BVTRX?=
 =?utf-8?B?THVVU0YrNnUrSFRNMWpiWERROXMrQU9sZFJYL3IwVlVIQzUvam8yS3g4aEFP?=
 =?utf-8?B?K3hSSU9qd0dsQ05aZTFMbTZVSVVJWVBadDdDaVUwUGNKVTIwY3VkV0srYWVB?=
 =?utf-8?B?b0Z0aEFXS3BVV3RJN1AxM2hPYmNDZGx6SXBWVnFsWG8vbHd0Yllya3hBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(366007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWhCalQ4L1RKZW9SZWVIUWFzWldZd1hGMVRPNmJhaHpxRGRIUW83SmhRN3NB?=
 =?utf-8?B?ZFo3cEk5ZVVBNDRWNXNPcldMYXFZWW5OaTdvdGZIU3JSYWhNOGh0bFVpcEIz?=
 =?utf-8?B?VVl1TmJaNndmYnRvYXFjeG5jU0xuZjVmT2NDL2RWTTg1cDRwYy9ORzhBak5O?=
 =?utf-8?B?S2JTc2c1TXhGVVNlMVlDNU5XUkhCbWowWUM1aVlYWThaU051WjU5M2U3a0tD?=
 =?utf-8?B?aHBvbVdpWXZLK1lZK0tYVmlyNjJDTVJvZjlFMTB6ckJmc3N0R0hFQlpCcEVE?=
 =?utf-8?B?QmszVExCZFczdWo3Nlp3REo5WlJZL1V6dExDazVxNGhUUUhPeGhwenEzWGtF?=
 =?utf-8?B?Q0RvOUhTVkNiT2RqTks5NEl4SlNBeFhURnhacTBvUXNYa25ETzJYVllpdmJX?=
 =?utf-8?B?N0hIRWpMM3lSM0xUL25DYUZJL2dDbDdjRlRlY2xUN3dyWHBhY2J5Yjd2Z2Rm?=
 =?utf-8?B?YmlZdERYOU1Xd3ZnM2xCRG1xOFdhaTRHY2JRZFFlOEVnMEVHQUI4L3hLYW1v?=
 =?utf-8?B?NjdXcWRRUWNwalY1OC9kdEhRMlNmSFhEVVBTL2YrbjMzWmxhOWNtRU9Ia2ox?=
 =?utf-8?B?b1ZPMzBBVlNCZDZXMU1uTkw2VlJQbnhTQ2tiTjF6aG1Gc2gvZklOdGNyeHNt?=
 =?utf-8?B?dy9XcE1QNG5KT2FkUVVnU09JYzJQY0R5eUl3ZEdaKzkrQi8zT2ZzTndOWEhI?=
 =?utf-8?B?TXRmQzFmK08zZm9wVGhuZm84SHNySkRqMXdJN2xOMFB0MDZUajcvdUtQdi80?=
 =?utf-8?B?VUNOdEJOSFZiQTI2aHRhNGVLMkFKY01ZSGlHbHExUjFQN2xvdHlocnZoN1Zk?=
 =?utf-8?B?d0tFS0RUMDEyazJnSndFUy9aWWxnUkE3QSswdk0vL1BRTDBjbHNrd2pxbkxi?=
 =?utf-8?B?Y2tHRGxjVUFPa1FJdFUyNG9IVThxbThlUEFWYXErdjA5WXFpN1ZkSGNRRFVE?=
 =?utf-8?B?dDJxeXRXTExrMUV0bVo1WUtPNkEvVWdjUzQwVlpHNXRLWWlyQXMyZ3NGeDFw?=
 =?utf-8?B?a0FXSWlIL2ZmeSt3MFFOaitwNGVncWRITGRhN1ByRDhLbndaRXdVZHFST0N3?=
 =?utf-8?B?eGF0WlJWZ2FEbCthZkpzdzI4S1EvSXJ1QmxSbEZndFVsdGR3YmlmS21uUWJa?=
 =?utf-8?B?Mm9qa2xjNWt6M25tU1JoL3BUZFpUUjBLTjhlODV5aXNVU1F1Qnk3Y1ZpOFpu?=
 =?utf-8?B?ME5HL0E4dFRucXRrVnhIM1JBbzZCNjE0NWNEYTcvQkpNWTRNT3puNTZWdVV3?=
 =?utf-8?B?Uy9Gci8vZUJ6T0N1T3JSUnNHZmlmYlFod205KzgvSjZRRklvMzFvUlhpbk5W?=
 =?utf-8?B?N25jNGhTM3crVGs1WjhaRzVScUpLVkl6ejZEb0c4TG9rcXE0MlZxRElyVzBi?=
 =?utf-8?B?VlBBU1dOem04MDJUdVdlRmNybGdRTHphdnRuMGRMU2dyTDEvUy85dWd6RFlx?=
 =?utf-8?B?SDZOaWh0RUNLaVcwL1A2MHNmUTh4QTFWQXdZbWZvSEpUMzBwNXlTaVl1ZlVq?=
 =?utf-8?B?ZEZoeHk0dEkrQjZCQjJyNTJqZGFDMno2T25EUjBVYUN5YTR6NXpRY2ttR3Y1?=
 =?utf-8?B?VnpUYnJiZ2ZaV2hWdkJNeVlnOEFMRGIrQjh6TUhLYTdReVNQNzRNN2Y3Y2xE?=
 =?utf-8?B?WXhRWTIweFJMdmlSQ0YzeSsvNS9xQ0NjbE0zQzZsK3kzbU5mUGt0TCsxa2Nz?=
 =?utf-8?B?ZnhmaytGSVRJN1JSSnBkZlowL2k3WGFCTTk0b3NVaGMyOFhtNGFMRVpiaGw0?=
 =?utf-8?B?UFBhRzJRaUJZdE1hWjBWcWFwWlA4YTNKWEZLNllUcE5Ea0hONzl3a2NGUzdu?=
 =?utf-8?B?ZEtoS1drd2tIOEtEdFlpN2ZzVXJ6WDFoV2RwTmc3NDlvaEczODhxVGVNQ2FV?=
 =?utf-8?B?WmlzekkrV1BIWU5vNFBhMElmeVdrcGdIR0JIVGNMRi9GK0VWWEpNWHhxV3BH?=
 =?utf-8?B?ZW9MYktwc01ia3pOODlQcUtNdUVOSHFLdnEzbFhyaUE0ZnFvNzlLM0haa1hO?=
 =?utf-8?B?RDNxZys3VENPYkR1NWtLOWFKdVBTRUZHaTNYSUlGZzV2dk1Ga05rRzVFbWdX?=
 =?utf-8?B?QkhWZHpBWGFWdW5NSndjTXY1Mis2MHZpOG00dWZUengrV3RyZ0d1eDg1eG9s?=
 =?utf-8?Q?53DqSM49SzTvGl1qLBxYX603M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5efc0833-5e13-4453-ec11-08dc65c42d54
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 07:40:42.9583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnoO0zUiH+c8p1s9cb11HlQWWpj5uvEJqSIouVD9Z+jxdkUVIMvfu3r1PgozIaAC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6832
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



Am 26.04.24 um 05:57 schrieb Yunxiang Li:
> The retry loop for SRIOV reset have refcount and memory leak issue.
> Depending on which function call fails it can potentially call
> amdgpu_amdkfd_pre/post_reset different number of times and causes
> kfd_locked count to be wrong. This will block all future attempts at
> opening /dev/kfd. The retry loop also leakes resources by calling
> amdgpu_virt_init_data_exchange multiple times without calling the
> corresponding fini function.
>
> Align with the bare-metal reset path which doesn't have these issues.
> This means taking the amdgpu_amdkfd_pre/post_reset functions out of the
> reset loop and calling amdgpu_device_pre_asic_reset each retry which
> properly free the resources from previous try by calling
> amdgpu_virt_fini_data_exchange.
>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 50 ++++++++++------------
>   1 file changed, 22 insertions(+), 28 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1fd9637daafc..3c4755f3c116 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5063,19 +5063,14 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
>   static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   				     struct amdgpu_reset_context *reset_context)
>   {
> -	int r;
> +	int r = 0;

Please don't initialize local variables if it isn't necessary.

As far as I can see that is initialized below and will generate a 
warning from automated checkers.

Regards,
Christian.

>   	struct amdgpu_hive_info *hive = NULL;
> -	int retry_limit = 0;
> -
> -retry:
> -	amdgpu_amdkfd_pre_reset(adev);
>   
>   	if (test_bit(AMDGPU_HOST_FLR, &reset_context->flags))
>   		r = amdgpu_virt_request_full_gpu(adev, true);
>   	else
>   		r = amdgpu_virt_reset_gpu(adev);
> -	if (r)
> -		return r;
> +
>   	amdgpu_ras_set_fed(adev, false);
>   	amdgpu_irq_gpu_reset_resume_helper(adev);
>   
> @@ -5085,7 +5080,7 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	/* Resume IP prior to SMC */
>   	r = amdgpu_device_ip_reinit_early_sriov(adev);
>   	if (r)
> -		goto error;
> +		return r;
>   
>   	amdgpu_virt_init_data_exchange(adev);
>   
> @@ -5096,38 +5091,35 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	/* now we are okay to resume SMC/CP/SDMA */
>   	r = amdgpu_device_ip_reinit_late_sriov(adev);
>   	if (r)
> -		goto error;
> +		return r;
>   
>   	hive = amdgpu_get_xgmi_hive(adev);
>   	/* Update PSP FW topology after reset */
>   	if (hive && adev->gmc.xgmi.num_physical_nodes > 1)
>   		r = amdgpu_xgmi_update_topology(hive, adev);
> -
>   	if (hive)
>   		amdgpu_put_xgmi_hive(hive);
> +	if (r)
> +		return r;
>   
> -	if (!r) {
> -		r = amdgpu_ib_ring_tests(adev);
> -
> -		amdgpu_amdkfd_post_reset(adev);
> -	}
> +	r = amdgpu_ib_ring_tests(adev);
> +	if (r)
> +		return r;
>   
> -error:
> -	if (!r && adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
> +	if (adev->virt.gim_feature & AMDGIM_FEATURE_GIM_FLR_VRAMLOST) {
>   		amdgpu_inc_vram_lost(adev);
>   		r = amdgpu_device_recover_vram(adev);
>   	}
> -	amdgpu_virt_release_full_gpu(adev, true);
> +	if (r)
> +		return r;
>   
> -	if (AMDGPU_RETRY_SRIOV_RESET(r)) {
> -		if (retry_limit < AMDGPU_MAX_RETRY_LIMIT) {
> -			retry_limit++;
> -			goto retry;
> -		} else
> -			DRM_ERROR("GPU reset retry is beyond the retry limit\n");
> -	}
> +	/* need to be called during full access so we can't do it later like
> +	 * bare-metal does.
> +	 */
> +	amdgpu_amdkfd_post_reset(adev);
> +	amdgpu_virt_release_full_gpu(adev, true);
>   
> -	return r;
> +	return 0;
>   }
>   
>   /**
> @@ -5686,6 +5678,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	int i, r = 0;
>   	bool need_emergency_restart = false;
>   	bool audio_suspended = false;
> +	int retry_limit = AMDGPU_MAX_RETRY_LIMIT;
>   
>   	/*
>   	 * Special case: RAS triggered and full reset isn't supported
> @@ -5767,8 +5760,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   
>   		cancel_delayed_work_sync(&tmp_adev->delayed_init_work);
>   
> -		if (!amdgpu_sriov_vf(tmp_adev))
> -			amdgpu_amdkfd_pre_reset(tmp_adev);
> +		amdgpu_amdkfd_pre_reset(tmp_adev);
>   
>   		/*
>   		 * Mark these ASICs to be reseted as untracked first
> @@ -5827,6 +5819,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>   	/* Host driver will handle XGMI hive reset for SRIOV */
>   	if (amdgpu_sriov_vf(adev)) {
>   		r = amdgpu_device_reset_sriov(adev, reset_context);
> +		if (AMDGPU_RETRY_SRIOV_RESET(r) && (retry_limit--) > 0)
> +			goto retry;
>   		if (r)
>   			adev->asic_reset_res = r;
>   

