Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4957EC761A6
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Apr 2023 13:52:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4E9710E692;
	Tue,  4 Apr 2023 13:52:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B504B10E692
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Apr 2023 13:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFxPsPJ+P4in47xZ6PgT4/fXWaUrX3XXewbgvEkmhxO8bK+31UZ+FCFIExftYKFwkmZiF7gv+JX/PIco00xjTwLUWRy8kgrxsK2WZE8QdJO82fILaO76eZea6b8/0iep5ehy7wfP1aEdJmejOdqGIz4U9O2ixE8QSZCmnMg+8bQx5ZC5WprNpJszRIFjZK/BIqtKvRXZcMMbEUWd4Fy3d/r4Fy1IOHfOxgjjyCRy58Kvgaf/kn3KthlGDMq4pvkCYtWwGgOROhZ6r+jRKiJOiv2IxizeGN+g7FXeo1tT9F05i4kgaU8ckPfTURaVhP+XBSzggLusInM6UZ8nIHs27w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76sgIi2E3ZQgzLTddcXSOMB7I/UbVHdZk5TeXIF7HEI=;
 b=jQGl5hYF/K8i9+O77Ci58SN5L+kSrjDKuUVq1/6wZbwW85kyg0Oi9Nr8+/PpJbXgt7d3/UzLhMXiBHLwrK4NsDb6RyUcwuejMmLGQarzOyj5INWJw93ucI8FzCKlUg8IKfCL9idVxfItJLYvUr70Q21fJ8XOfy23sNmlwpvIQSjIDYGgxeCQP7QQsfnQ05jOch3/SQw7j9gv9h3aCwuBI/JsrDXeQNHIfpPqHKVKd54//JNimgZR3J/oOEsJhbiJYFt8L7lFymt7WBAq7zMnEUM/19EV/EESaLgefFlnuGsvlJbknv6hJ/oNvaJxsrZniqnAv3gcNppNJibJqR7U2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76sgIi2E3ZQgzLTddcXSOMB7I/UbVHdZk5TeXIF7HEI=;
 b=flEne8LcOs4pSyy9zNIIjTW3j26QH787/1wBkbH4f9sJy67HGUCx90o/XI1G5U7339vugRVbKt042e6y/artPx+wtbcPIfj6vachRYc1WWjx7HAeo/rC+70hIpXUC6RbwpP/1VOqjOKXTV+dGghPWpQ9hUO224/oLqvO7jZK0/8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB6209.namprd12.prod.outlook.com (2603:10b6:208:3e7::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Tue, 4 Apr
 2023 13:52:06 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%6]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 13:52:06 +0000
Message-ID: <ead2bf27-f496-47b0-53fc-7796582d0ab5@amd.com>
Date: Tue, 4 Apr 2023 09:52:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/3] amd/amdgpu: Inherit coherence flags base on original
 BO flags
Content-Language: en-US
To: Shane Xiao <shane.xiao@amd.com>, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com
References: <20230404095640.3277840-1-shane.xiao@amd.com>
 <20230404095640.3277840-2-shane.xiao@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20230404095640.3277840-2-shane.xiao@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0269.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::19) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB6209:EE_
X-MS-Office365-Filtering-Correlation-Id: 292db948-4e61-49f2-326d-08db3513c72b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHa4y0zcoQTbF5TJd5W8zDTqUAoCJAkN/Vxp7sUXt/ItQW74KpnteI6dzOrQDHpaR1O6lCB8ggW3MnzfiEMISKFQpr72oYaqRXAo/Glc1CxZ1pSHc24zu8yyKepG9PnjAzvuIW9+eSHTEpOXDHdPPuvjb0KHCmz70rjf6XzTP3YEUuUuVJAYsf5p7i+vkkkCTBAUj0jj2phiLKzuxZvdOHgBzmHnZWon616d6zkIjYbfKlOtCltlvQogq3kUZbjhViHyq+56u3S1EVDC9vteNbcYMm3aLsBfvCGingC3I9/sahoLuQSmP3SHo4foWVa3XvlvpDYJpKztnwzUwt0XRPhaQz90u0wSFYpxVzON1mB8ol3T87Es8/X/y79PUeC5PWF6X0uvpRFdUchL4CnbEbxKMZ6qRWkRgCefvYtxKm7lFgEBPuBtDF8rDJheduhaOuliqNp4Lpsqv40YlCl5KBWWFPQaSlbY8GmiLUaAB4mpJ6YX6DMog3r1oDZHY34EIzyZUHoCC9bXbj/hMC+f/mhMvfBKyEoot4ds9mprxMtJ1iDXj1b4IqB0TdzLm1nA0LUUzcSEIOG8Kl+IgPEeyP6z8/pp7v091Z2TJhZ6wQo9kJ2UxIzpKUpZ+ELuFVqUO/icstoLBoDiKmP03u8yFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(396003)(376002)(136003)(39860400002)(346002)(451199021)(5660300002)(31686004)(316002)(6636002)(2906002)(8936002)(41300700001)(186003)(478600001)(4326008)(66946007)(8676002)(66556008)(66476007)(44832011)(6486002)(26005)(6512007)(6506007)(83380400001)(2616005)(36756003)(31696002)(86362001)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmQ3SmxMQW85UUNqTGtlVUQzbE5BR1hnQzR2bWQwSGZ1T1dxc1dIYmVEM2ZI?=
 =?utf-8?B?ZW1JZ0ZrTUNhWWVrZ2daVU5CK1ZQNnBsMW4vQjhCU2M3UmtyaG9nNWc2Q3Fw?=
 =?utf-8?B?REZjZElQdnMxNS9lL05EWkl0ZUR4Q2F1OFNZOWJIanNuYU1xdTQ3OHB0TDdQ?=
 =?utf-8?B?QWdJS2pEcmdCaHMxaXRod1hjZnRFUk9lZ2lPZjM4R3ZCV2hMdE51Zk1TVE5Q?=
 =?utf-8?B?U241djkvOEV1Qlp1dzhla3VGUFo2dG5iYkZleWdFOGF1VWZTQW1BQmV1akl0?=
 =?utf-8?B?aWJjejluSzY2eHZIdm5uQW1ENlVXUk9ib3lGUnF2aFhrZ0VuL0ZQZmtFekpO?=
 =?utf-8?B?R1QwbWZQcFZDN1FrUStzak9lSzJLb0p6TmpMWkZCd3cxRU0rMGk0cDBtYm54?=
 =?utf-8?B?Z3d5bFRya0owZzN6VU5ZcUFKVnpoWHdRSURwOGdMZ2hxMHdHQXhZTmhRUU1Z?=
 =?utf-8?B?aklhcERaTmdlckZzaDhBSCtRQnpJQWsyUHpDbzR0NFovZEVwNHJXdE9CdTEw?=
 =?utf-8?B?ZktZeFlBZzZjTnN6eHMvWC9GaFlsY0dkbVgxWk52WDU0eEtuZzdTQWdLeURE?=
 =?utf-8?B?NVpHVThMVlBOZ212SmIrU050Vm16Ulp4OFo5amtDSjJHd2IxOXFqTTRoQURU?=
 =?utf-8?B?OFJIMW9acUcyYlJuemdEZEwzb1dDKzVrSG85SUVnN0FtdEJ2RklyTHBHVENo?=
 =?utf-8?B?dUo4STdWYUYwbjJyRU93SEV3NEN0dmV0U3VQUDB1ODJYM1E3OGMyeTkrTmhs?=
 =?utf-8?B?SEh5VS9UNDI0TlJycWhUbHBrRjZLRmEwc3BaVmVsMkRjZGo3c0ViaSs1akl0?=
 =?utf-8?B?T042T1k0S3gwWER2ZU9ZY29FVlhDbThKOG94WG4xYXhxR24rWGhWMzVuaWpU?=
 =?utf-8?B?cno4RnZGMHhtQVB1SjRyTzI5OWp6WERmeUozT3FuZHE1MHNjV0dhRndIM2M3?=
 =?utf-8?B?NWQ1V2tPaUVnbjNjTDIrdEpIdTEvQ3JIeEVNVCtzRmVROURGT01XZmxoRXlh?=
 =?utf-8?B?bDEyTDF3ai95KzlpL2J0ZnJ3N0hmTEpIRlRxZVd4QkVJOTRtdjJub3JZM3Bm?=
 =?utf-8?B?ZFdMMGZTMWUwODdVTW1IL1pKQmREUE5wSSt0ZmJhVFlkNmRpaEt4N3N5b1E4?=
 =?utf-8?B?YWpVWno0RitTYWZCTHdmK1RVamxvT2w3K2YxM2dqVFhQazBmdC91UktGa1BZ?=
 =?utf-8?B?cUZOOXZvMXJrS2pBdXQ1eXM2NzRJR3Fmd1BVZUFEdUdOTWI3MmVlTmY5SlR5?=
 =?utf-8?B?VjlXT1E0cWdXa0dQZVpxTHJTNGxqYVVLZW1HMUpiRDUwcjIyQVcwN0RtUndo?=
 =?utf-8?B?RGo5cU1sOE4zeWRWbHlGTW54YU8yT0djckdmWHRRd2pSZGNEK21RcEZ5R3dN?=
 =?utf-8?B?K1NZQ2xoY0E5YTEzS0lIMU4vVUo0VXZ4aTVqZ1htNExVeGczMTJqWVlFR3k2?=
 =?utf-8?B?SElYNCs2RUVENlRJVjNjTlhkaHgzUTE0NFdXdGU0cWQybkdYU2pMNHB1K1M2?=
 =?utf-8?B?SkIrMERxcmw1TjFWUng4TU56R3JoMTh5a3dJYVkrYWRQbTN2YWkrcUlaTjRU?=
 =?utf-8?B?Q1RaWlBXZGVUWFZ0eWlRcE9HUUhkVjJmNmNnYUdxaXZjNjBoajZSbFN1L3ZK?=
 =?utf-8?B?bmMxdHcybFYxaDhyR1FjRm9NUDN2NTNUY1V2NDJHMC9KaTRvZnFuM3hwaTFt?=
 =?utf-8?B?cnJXQzlHRy9zZjQwUmI4U2hIeG9qdlVUMWZmTStXaU5tTXRBQnJKcjNrZkt6?=
 =?utf-8?B?b3BtcTdoUHlkWDNvTGZyRW5qWjIwVVdNZGZmSlNEYkcwcmZPL1VjSHd2Vzhy?=
 =?utf-8?B?ZmJUY0t3RFNvWlBjanh6SXZZY25zTjdVWmM5Q3NaWlYxeGNJY2lNRFhNZDBm?=
 =?utf-8?B?RmdQNjNzUHc1Mmh2enFjdXBwbXVOTzc3V2d2OHUrd2ZTRmEwQ042eUEvR1Zp?=
 =?utf-8?B?dHptb3NDRGNWc1lxeG5NSHJCYnorUGNBRXNIZFI3Rk9EbXhWdlkxNm1VbFlX?=
 =?utf-8?B?N0FFNk9FTlJnSjVabmxrK0FVSFlTYjhxMUU2NGhHM1R0dUhDc2c0RlVpWkVi?=
 =?utf-8?B?MEJCQm52SmdIRzhoNGd1TGZ0dWZycGZhanREZitmQ3krRjJJS1pVdmdpbVln?=
 =?utf-8?Q?uo3KZRYdr1xXXDQ4v2Sbpr5VF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 292db948-4e61-49f2-326d-08db3513c72b
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 13:52:06.6631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hldqetJyVlNOeg8fuGm7NPKMw/c8CmOUzy2dtTHmJF7EbR3wpZAlP24mvFYzur8yCOcfApIhF8wvTugSBX2e4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6209
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
Cc: aaron.liu@amd.com, shikai.guo@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2023-04-04 um 05:56 schrieb Shane Xiao:
> For SG BO to DMA-map userptrs on other GPUs, the SG BO need inherit
> MTYPEs in PTEs from original BO.

Good catch. See two comments inline.


>
> If we set the flags, the device can be coherent with the CPUs and other GPUs.
>
> Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 33cda358cb9e..bcb0a7b32703 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -253,14 +253,22 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
>   {
>   	struct drm_gem_object *gem_obj;
>   	int ret, align;
> +	uint64_t flags = 0;
>   
>   	ret = amdgpu_bo_reserve(mem->bo, false);
>   	if (ret)
>   		return ret;
>   
>   	align = 1;
> +	if(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_USERPTR)
> +	{
> +		flags |= mem->bo->flags &(AMDGPU_GEM_CREATE_CPU_GTT_USWC |

I think userptrs never use USWC because the pages are not allocated by 
the driver. You can drop this flag.


> +				AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_UNCACHED);
> +		align = PAGE_SIZE;

Isn't a page alignment implicit anyway? I don't see why we need to use a 
different alignment for userptrs. If PAGE_SIZE is needed for this case, 
we can use the same for all cases We don't even need a local variable 
for this.

Regards,
   Felix


> +	}
> +
>   	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, align,
> -			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE,
> +			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
>   			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj);
>   
>   	amdgpu_bo_unreserve(mem->bo);
