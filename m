Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF3DDC77B7A
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 22:23:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DB0110E55B;
	Wed,  7 Jun 2023 22:23:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DEFA10E55B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 22:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BppLqOxLOcNNmNQWLxCn4vlUizbTHzH+kQDgcOsLcTHTHmLAQPbMxBsBISzoc2ZqKC1BEuptmN8Ke+4yGVBojvlfKU3gfNIDJ/qJ5UsDof55Dnkm+v8z4nIyfUM78cj5QYdg7odC1/L/JdTKoYE52pAf3l0ny8NeCrxSQhmAkXNqgSF+1Ia0QSEUOLsO7l6VmCX5kESx6FWKCy9w0hvxoY8x2U8L8uBjz8tXk7bwJJ9iIwJnd5nb7aXZRGRgkfqOJ4oIvGq0jVZtNMcEjX6L3FYC4iyEd4SZThRaJOIGWyXCl44qqp0YZKmmwiUqMSPKhtJJIgru+o/kfdoi9QsB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zN93wZUqgezRDXk3o+V86aHhdkDmqr+lMAFOrFQ/7mo=;
 b=FfCPZma8b9lpiaIPAOfLhJCUzVoe5OF5eWcEu3hgsExxOTO8r2P0BXES403yq57uBM+S44oZsJVSf1YSVe/opgV9HcNoYqsfDFIbf7zlRcubCETDsiN/00E1xIPOdXDgfZe8I9jti6FxhTlTLPZBcZF5H7heP2eweu802YZZBwqztDKX/S/v24RXcJKTZYR+AcrlJRMeN7mV/WQdrOP9XJKuuhMlAfuOgYZXpjLfbrty02qiXZJCCqS7MoXco/nH5kUEpHkJjJN4G9ffUfg1erVUw9W9gesTwD2zR3QJSfKg2pgDT4Jvl+pp27kWag9FJIB4ESce0ppTO0fn5VHpzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zN93wZUqgezRDXk3o+V86aHhdkDmqr+lMAFOrFQ/7mo=;
 b=ZQh1MvuBqvhMZNG4vgnRl7ejTH0pt6gNyqC79jvPsvIe0O8LkSZsXr1erOUr2v0nHGnROblplGZXWl6QSQJtYs+ZfsL97XwUdhBV/HJhJEbILko3O9V7sM58r3zDHRsTNVHq4di5nDdayRZZDL6Yyf3P0OzHCEvot62iMI7FTLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 22:23:15 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2dc3:c1:e72d:55bc%6]) with mapi id 15.20.6455.030; Wed, 7 Jun 2023
 22:23:15 +0000
Message-ID: <732d8f8e-f386-5485-c57a-d9e9bc20bb24@amd.com>
Date: Wed, 7 Jun 2023 18:23:12 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix and enable debugging for gfx11
Content-Language: en-US
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230607202002.1876968-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230607202002.1876968-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQZPR01CA0052.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|BL1PR12MB5222:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe624a3-7a81-4515-f9aa-08db67a5c989
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xLRUZoMFp1s/2T9hjqBXN8+XtBnRPUv3jK158k8gGN8HcYbtQ48BzoWLse0lsdC1q/vTPyAThEj0XKrIJG9w15tE+hZpPVxBPZDFT853jK0/aQogQMCoYg3oIJpHLnB7iC2R5nmjHMxfOsowfh01cSKKowYhcq4KyjCIdBnF6POck58mxm0Owa3ww1rKAVCRl1AlADuNA3k3V1v+H2bPBdVQXiAtwYPozBKh2I3FHeOGd+IGbR1XymPQ7PRhPsHaDP5ubCwB2Lr8yf7IKCuGDQ/Y5r1wq3QcFd5T4HURRtrCHQxV+Kvije6WHa9b52vop6GUZ7y4PWGvwiBhbz2XrKEsks2VqTb/VBk5ydTMLOsuEW6nJGKyl4rbAk3dMToSpbZrrVkqF21zFxZRnbZ8RSJBdMOnUFJNF7gbsYfWiT5UQDbIQ8aGeWJZnLCcZ+9wdlaJCfZa+wAh7T70NJ2Ys+9m4BbWkdlTNj/QhTgUo7imcmZw+BkJl6mozbnRJ5ghgMkmVxHGBE1y+9Ybap68Dop8Ug+GCShADGoJ4nvrh5IgWn4vk02jYk6GuZbjUiezryHlzIe+wO+X0XVg4PQHdZFtovS7omKEsWek460u0n+hTFGxbCFrUZJ+Ds3IdYYZN3Z4lPFEgEV1jYic6N900PEnabJqxnA4z+4SRmrbxiAUBOMmqgTEnFosbY1mCZP7
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(86362001)(83380400001)(6486002)(44832011)(478600001)(8936002)(8676002)(316002)(41300700001)(66476007)(66556008)(66946007)(38100700002)(31696002)(4326008)(5660300002)(36916002)(36756003)(6666004)(2906002)(6512007)(26005)(186003)(6506007)(31686004)(66899021)(53546011)(2616005)(45980500001)(43740500002)(309714004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5uSnZPbU9rdDllTjhKTXJ6S28rMys0MXVxTGhMUlNJWG5sQTJYa3VGTUI4?=
 =?utf-8?B?NW1UeHdsZXUvOWtKQ3dJdGlDTzdzQzByM3ZxeDdoQ0RMYy9rSTkwSG1zNERG?=
 =?utf-8?B?dFFiMEgxdVpHRWxzek9Nc2NpWVBTb2wyRm9XOVVGaFJJMUIxcUxZaFFQazJv?=
 =?utf-8?B?cTRkRFZYMWovNVdFTVhLeE9ISGtnUGZOQTc5K0N3cHBUR25LNlhmMWVNMmNN?=
 =?utf-8?B?WDNGV2M3WXJNRW9SU2JFRFE3OTFqVzNsUlpLWHJ6bDdReDVYT3Z1UUhiQUZ6?=
 =?utf-8?B?S2w5dWszeGRoK3RlRnM2Wk1kREMrbnN5MGlHaTBROGtTakxLaHN3MEZqWStt?=
 =?utf-8?B?akhEQ1NWeTlGSjZMT1hacHplT28xMjQ2czk3ZDNsT2pRbXIrL0pzVXNLeHVL?=
 =?utf-8?B?Z1lDWHNiOVVhOHlreTY2MlZvc3pkWUlla2FUTFZ3ZnAzY1RINCtvdEVrY3Zw?=
 =?utf-8?B?VUJvdVJHeDNXdksrZ3lDUllZdTdSTjkxNkw1dWVyeTVxa2NoMks1YWJlMFBJ?=
 =?utf-8?B?QVlObnZpbmk2YXJ0QTZvWVJyM3l0OVVnN2NEd1pKUGRFNUlkWDdleUZFa21i?=
 =?utf-8?B?VDh3TmZBc0NWMmFBN3ZOcmRzamo1NGdwalhSRUFndHJqc0hZQVFCSDByVGo5?=
 =?utf-8?B?UHAza3I5WCtoSEpyVlNTdnQrNzNONUhYNHpMNkhwQ0k4cnJubGQyNytONHF2?=
 =?utf-8?B?RWpkT1dCOGZEbkl4WldyUnJwbERqeEt5Z0dGQWhxdzI4Z3ZIejdOTks1Nkcz?=
 =?utf-8?B?cVpYV0ZkRnowZHZSUDlxbHliM3d5emY2TGhtUzdZa1ZVR3lSc0dGSE1SVnJC?=
 =?utf-8?B?YXc4NDBYRktwVDBhd3FHWU1OTWRoaDJIeXpkMWU3azE3NnRMek1rMlc2ZjI2?=
 =?utf-8?B?U0NzWGNxYS83U0psV2tSalJRYkdTVDNidTZPRlZNYUkxT1h4UWt4bkRyN24z?=
 =?utf-8?B?MlVQTk1yOWNlYnhLaC8yTEZUS2Q2M1h5NlFXc3hnaTM3T1B4M2dJOUxOQ3or?=
 =?utf-8?B?MU9PVkdLWWRBZW5XcHBnNDI1a0E1dnIwdEovdS9McjNXTGVQcVd3TE42QWRO?=
 =?utf-8?B?eERzRjFkU0lIbWMwNnZJWUtlWXJKd0JCeXY3S05TQ2F1TmhJb0ZrYUlCNC83?=
 =?utf-8?B?T1l3Kzg4RldvMUpycVhVRVpPSWRqek9xYUNMcTcrVHFNVmErMVdPK1JBN3FB?=
 =?utf-8?B?RVFGUlJlcUlkMWRsZ2lCZURJdVRSVHlXZFNNSjBPM0lXd01Pd1BwdGJidlBU?=
 =?utf-8?B?R2I2anhRekZwWnhOeDFZZzh3OUM1d2lsRmsrQVNDbGxraUl4eFlQVEFxelhN?=
 =?utf-8?B?VDFPUHpXZUo5NisrNUVWUjJFUnFPcnZrdXRYeGJDdnA1dUQ5VjhrbU41NVNW?=
 =?utf-8?B?Szdlc3pWNndiSUtyOW9JdDUyTzd0REtvL0VGcHdBYWQ0ZnZBc2pXRzRwYU5u?=
 =?utf-8?B?UFlxLzArTTQvUFJLeHJldE95NlVYTERlMHB1N3RpdTNtVE0zSlp0LzZ3RVln?=
 =?utf-8?B?RlkzR2RJSXE2d2pGMXpEbzVLSXZZNFh4WG56YmVTNlZzOE9ZRXNhRVRrd2da?=
 =?utf-8?B?K1pheG1UdDFzOElxbFk3N3ozOE9iZzNOTEd0RElINFQwVTFWNGVNdTdERSsz?=
 =?utf-8?B?eTh4NStCelAwb08vbE1XSGFodW5sUU9IdTUwU0ZvOTFpeEgwQncyY1Urc292?=
 =?utf-8?B?ditpaGd6dHo1ZExITjdsL1NINk5wTy9RZFQ0blBzWUI1aThIODhiY1BEM1pF?=
 =?utf-8?B?aUpqa1FxQ2VkSjl5SlZHTHk0Uy9oU00yKy9ieFI5ZnZaVkNJNEthY2RwQ2hE?=
 =?utf-8?B?ekJRdzgxT0JxdUl0bUtCc0FSL1JCVmE1dlhnQlovMThueUhVZ0szWlNJbFl5?=
 =?utf-8?B?VS91YU1xUE5LU1hSUTlHNFBKUksxYVBBYURTVGhzaWdLVGRjSFU0THBtOThq?=
 =?utf-8?B?Um9uaWlCWWxyYWZoOUNqSGVBSVFzMzhOdXdadXVGWjMzYmF4b0M4L2hMVVdV?=
 =?utf-8?B?VWRzWjFuMWswbUFYd0doVmxZYWNzWXc0UEJOYzVMRExQYU1QN3NlU290QjVG?=
 =?utf-8?B?azB6Q1NTcngxN3JzZWdTYURGaXpZWnBYQW5UQVM4L2M0Mk1DNkllc0ZjZ0JK?=
 =?utf-8?Q?l2YHBkkTh70pRexWEY7+q941f?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe624a3-7a81-4515-f9aa-08db67a5c989
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 22:23:15.2957 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h51fxbt+oBLkV4UTAOGjICX66beTLZpA8Cun4E8Z2B8806fmlOsQJNt83t/hoKnwGGlvyA1x8IzVpsAVzqpaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
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
Cc: JinHuiEric.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-06-07 16:20, Jonathan Kim wrote:
> There are a couple of fixes required to enable gfx11 debugging.
>
> First, ADD_QUEUE.trap_en is an inappropriate place to toggle
> a per-process register so move it to SET_SHADER_DEBUGGER.trap_en.
> When ADD_QUEUE.skip_process_ctx_clear is set, MES will prioritize
> the SET_SHADER_DEBUGGER.trap_en setting.
>
> Second, to preserve correct save/restore priviledged wave states
> in coordination with the trap enablement setting, resume suspended
> waves early in the disable call.
>
> NOTE: The AMDGPU_MES_VERSION_MASK check is a place holder as
> MES FW updates have been reviewed but is awaiting binary
> creation.  Once the binaries have been created, this check may
> be subject to change.
>
> v2: do a trap_en safety check in case old mes doesn't accept
> unused trap_en d-word.
> remove unnecessary process termination work around.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c            |  7 ++++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h            |  4 +++-
>   drivers/gpu/drm/amd/amdgpu/mes_v11_0.c             |  1 +
>   drivers/gpu/drm/amd/amdkfd/kfd_debug.c             | 14 ++++++--------
>   .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  |  3 +--
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c          | 12 +++++++-----
>   drivers/gpu/drm/amd/include/mes_v11_api_def.h      |  1 +
>   7 files changed, 25 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 20cc3fffe921..e9091ebfe230 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -928,7 +928,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   				uint64_t process_context_addr,
>   				uint32_t spi_gdbg_per_vmid_cntl,
>   				const uint32_t *tcp_watch_cntl,
> -				uint32_t flags)
> +				uint32_t flags,
> +				bool trap_en)
>   {
>   	struct mes_misc_op_input op_input = {0};
>   	int r;
> @@ -945,6 +946,10 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   	memcpy(op_input.set_shader_debugger.tcp_watch_cntl, tcp_watch_cntl,
>   			sizeof(op_input.set_shader_debugger.tcp_watch_cntl));
>   
> +	if (((adev->mes.sched_version & AMDGPU_MES_API_VERSION_MASK) >>
> +			AMDGPU_MES_API_VERSION_SHIFT) >= 14)
> +		op_input.set_shader_debugger.trap_en = trap_en;
> +

It's probably too late to change the GFX11 MES API at this point. But 
why didn't they just add a trap_en bit in the existing flags field? That 
could have avoided the need for the compatibility checks.

Anyway, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


>   	amdgpu_mes_lock(&adev->mes);
>   
>   	r = adev->mes.funcs->misc_op(&adev->mes, &op_input);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> index b5f5eed2b5ef..2d6ac30b7135 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h
> @@ -294,6 +294,7 @@ struct mes_misc_op_input {
>   			} flags;
>   			uint32_t spi_gdbg_per_vmid_cntl;
>   			uint32_t tcp_watch_cntl[4];
> +			uint32_t trap_en;
>   		} set_shader_debugger;
>   	};
>   };
> @@ -361,7 +362,8 @@ int amdgpu_mes_set_shader_debugger(struct amdgpu_device *adev,
>   				uint64_t process_context_addr,
>   				uint32_t spi_gdbg_per_vmid_cntl,
>   				const uint32_t *tcp_watch_cntl,
> -				uint32_t flags);
> +				uint32_t flags,
> +				bool trap_en);
>   
>   int amdgpu_mes_add_ring(struct amdgpu_device *adev, int gang_id,
>   			int queue_type, int idx,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> index c4e3cb8d44de..1bdaa00c0b46 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
> @@ -347,6 +347,7 @@ static int mes_v11_0_misc_op(struct amdgpu_mes *mes,
>   		memcpy(misc_pkt.set_shader_debugger.tcp_watch_cntl,
>   				input->set_shader_debugger.tcp_watch_cntl,
>   				sizeof(misc_pkt.set_shader_debugger.tcp_watch_cntl));
> +		misc_pkt.set_shader_debugger.trap_en = input->set_shader_debugger.trap_en;
>   		break;
>   	default:
>   		DRM_ERROR("unsupported misc op (%d) \n", input->op);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index 125274445f43..cd34e7aaead4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -349,12 +349,13 @@ int kfd_dbg_set_mes_debug_mode(struct kfd_process_device *pdd)
>   {
>   	uint32_t spi_dbg_cntl = pdd->spi_dbg_override | pdd->spi_dbg_launch_mode;
>   	uint32_t flags = pdd->process->dbg_flags;
> +	bool sq_trap_en = !!spi_dbg_cntl;
>   
>   	if (!kfd_dbg_is_per_vmid_supported(pdd->dev))
>   		return 0;
>   
>   	return amdgpu_mes_set_shader_debugger(pdd->dev->adev, pdd->proc_ctx_gpu_addr, spi_dbg_cntl,
> -						pdd->watch_points, flags);
> +						pdd->watch_points, flags, sq_trap_en);
>   }
>   
>   #define KFD_DEBUGGER_INVALID_WATCH_POINT_ID -1
> @@ -557,6 +558,10 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   
>   	if (!unwind) {
>   		uint32_t flags = 0;
> +		int resume_count = resume_queues(target, 0, NULL);
> +
> +		if (resume_count)
> +			pr_debug("Resumed %d queues\n", resume_count);
>   
>   		cancel_work_sync(&target->debug_event_workarea);
>   		kfd_dbg_clear_process_address_watch(target);
> @@ -598,13 +603,6 @@ void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind
>   	}
>   
>   	kfd_dbg_set_workaround(target, false);
> -
> -	if (!unwind) {
> -		int resume_count = resume_queues(target, 0, NULL);
> -
> -		if (resume_count)
> -			pr_debug("Resumed %d queues\n", resume_count);
> -	}
>   }
>   
>   static void kfd_dbg_clean_exception_status(struct kfd_process *target)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index 0c1be91a87c6..ff0a28760494 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -227,8 +227,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
>   	queue_input.tba_addr = qpd->tba_addr;
>   	queue_input.tma_addr = qpd->tma_addr;
>   	queue_input.trap_en = KFD_GC_VERSION(q->device) < IP_VERSION(11, 0, 0) ||
> -			      KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0) ||
> -			      q->properties.is_dbg_wa;
> +			      KFD_GC_VERSION(q->device) >= IP_VERSION(12, 0, 0);
>   	queue_input.skip_process_ctx_clear = qpd->pqm->process->debug_trap_enabled;
>   
>   	queue_type = convert_to_mes_queue_type(q->properties.type);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index faa7939f35bd..90b86a6ac7bd 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -1863,13 +1863,15 @@ static void kfd_topology_set_dbg_firmware_support(struct kfd_topology_device *de
>   {
>   	bool firmware_supported = true;
>   
> -	/*
> -	 * FIXME: GFX11 FW currently not sufficient to deal with CWSR WA.
> -	 * Updated FW with API changes coming soon.
> -	 */
>   	if (KFD_GC_VERSION(dev->gpu) >= IP_VERSION(11, 0, 0) &&
>   			KFD_GC_VERSION(dev->gpu) < IP_VERSION(12, 0, 0)) {
> -		firmware_supported = false;
> +		uint32_t mes_api_rev = (dev->gpu->adev->mes.sched_version &
> +						AMDGPU_MES_API_VERSION_MASK) >>
> +						AMDGPU_MES_API_VERSION_SHIFT;
> +		uint32_t mes_rev = dev->gpu->adev->mes.sched_version &
> +						AMDGPU_MES_VERSION_MASK;
> +
> +		firmware_supported = (mes_api_rev >= 14) && (mes_rev >= 64);
>   		goto out;
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/include/mes_v11_api_def.h b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> index f3c15f18ddb5..0997e999416a 100644
> --- a/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> +++ b/drivers/gpu/drm/amd/include/mes_v11_api_def.h
> @@ -575,6 +575,7 @@ struct SET_SHADER_DEBUGGER {
>   	} flags;
>   	uint32_t spi_gdbg_per_vmid_cntl;
>   	uint32_t tcp_watch_cntl[4]; /* TCP_WATCHx_CNTL */
> +	uint32_t trap_en;
>   };
>   
>   union MESAPI__MISC {
