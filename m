Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22CDCCCA464
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Oct 2026 12:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B3CF10E13C;
	Fri, 16 Oct 2026 12:14:06 +0000 (UTC)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D307310E13C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Oct 2026 12:14:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0GbFLane1yeDzBBRzmTOXKWYsFmgssECrxu4ayo3KsMIMCZwJkERcQAYRG+XUtO9Vra5hkePlq/ogsXGPMG5I/aXUwRvZGcfBvUMRvFAQ/66XQEDH5tU70cCKbBDZupScoMWqdzB0gQIwaPz2laqDofw4lGHUcbKh+vRcbcfjn+58zeNozzNuidJzPx8WQigUAXojtLU8w94xgL+DXBYZlVFz9RIj+eMJSxLyz9sZO6SIWWhiQAvAzd8kj70UDpub/WjfYOLIhEs09JEMBAnfoubf6TRQVOQe1WfDWBxYM4C5cJOy6hddB+DnyWO800jTaxcfkGqC72aaYZl+ijew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCEu1olsntzBbGFpCj+G88ZdB4+7wmoXjDoUvoM1glU=;
 b=boGK1mZjQS3hSv9Fdfse48OYKYVqg4+b3yI5+BQ2ofUh3swtA3BPKzkuFAlBo24wrua/Ka8tg/7CYS63vHwuBqosPxpLoT3SImvyEbuNkf5OkZ/VTO/PiuL+0YiCnKQbP89mp4toPFY4eigue0hq9iB1mP93JL7WFCogk84W+31W8RDetJK+FOvYPpWAgbp+ov+tio0NhRWXMIJxMt2IadaMsd3p+T9mXWs/R2BHWr1adSGVVRQ9bgNQqefhkLrW4ZbNBKTAdQSmAN6oepbzwIcnF+EkDBLgGMxdxnbXaaqqkOvogoIe5lLG3Fg0zY9qO/SxRO7YjVlm0jODVkXYFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCEu1olsntzBbGFpCj+G88ZdB4+7wmoXjDoUvoM1glU=;
 b=jeAMh/TctNInyI7RzQTl8idWc3jnOGzLO79EE06uQaIycRkzTQPerzfEE5ypMunXRkFp0M0qLEG2Y1icEzTZBVmeoihRg3ccQt7eH3brH8ddMbpwuQjvKod/LQ6sG+OluFmdzNpVdicFX/xOVlya7h59gWSdxiDMi8IzG6IUC3o=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB599680.namprd12.prod.outlook.com (2603:10b6:8:507::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 12:13:58 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Fri, 16 Oct 2026
 12:13:58 +0000
Message-ID: <7717333c-e2e1-4d50-9fee-1bcafdad067e@amd.com>
Date: Fri, 16 Oct 2026 14:13:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: fix amdgpu_vm_bo_insert_map to let bo
 gets update
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20261016120935.1348285-1-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261016120935.1348285-1-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: IA1P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:461::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB599680:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a573bc1-f1af-421f-e964-08df2b7ef4ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|261009223027099003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: vZxddJ+Ru05r1DRS1GWDMyazufoAUNzM+Cg8sFMS5oErxffdUFArY4xQAHVIdCMhfJl6cU2ZM6k/xdQriHZPWsfowX9M42BkC0P3yGGIMloAkV+hodFIB752HhoLDXMNjFtvMCqhGDdCPHk6Z2BdToe0ZNc+8ohwyLu7bwaCiOoNE9D/z5F2qkntfGgtQz/uzkueJHTg8aYH3FrsO6yA5PF/VBMFNz9Ull2UmC/KwlMAnhzv5H9dhYCkUH+6c0p9dJQ+MDbqvI5O/28/KvpAS+P2MOUsfVUolNkNLQXCPxHOZTM3UqdfTxUN8n0a0+T/M8+R4D9hSEjN7CrRkFIC98KfJTj/XZfH5dcsQjL1OSSy5BtSZWsKeuBm14dmn4WoLRIFSdtpq/NCGHOcmmdEbqJ5yF8Nk1vAzc5H0CreU3tG6770xWDFoeGN+i4li2RRGA12xMFXIRoMZ+14BSS5+kUrzl/sva8wzVG/9866Xyz2UPDYRSzJihqUrmBPBZKy0m0AO6i9y5prcC0yIlRZO20UbRG+dxIDbe2WQqUeDaEJg+hWDNxcQG4k75auuhXxqS4z25g42IlT8MOnjm5qLX1WpO7M73CP8BCmV+59vt4ZkuZeZLIP/ifx6Jbp6WAhiDs0SWwqfsz9vP9JZ/tKat7OJtxtPLdo2wEkSHPJM98=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(261009223027099003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enRPRGhJTWhrRlk4UEFiV25iaVlsOE1rL3crVFRQa29ZMUxIM2xwZzBpNTNT?=
 =?utf-8?B?dTRKeXB1RzZvdERIeWJRc2ZObkJ2bTFBV2hMeTRMeS9jTzBQc3VQVmZJdHY5?=
 =?utf-8?B?dk95cTVFS0RCNzZCNUVlU0xsb3BFMFYwZUF3ekVIdFZ6dXBLK3JMbXZBMmpm?=
 =?utf-8?B?SndNcWVlREpSOURKQTFLalhpM2hoQWNUYnBlcVZiNnUycGlpaU1aU3k5bG9S?=
 =?utf-8?B?bjh5Ky9iVXMvU2swWWlmTzFwSWw1YXVjQkJwL3IxQTNEUTdJc29lZC9kc1cy?=
 =?utf-8?B?SUJhLzdYa2pUdFg3Y2JyLzFYNUpjNUJxWURuNUpJSGRkZlp4WjdCU0FFcnpw?=
 =?utf-8?B?T1kwYjhpcUNYd0lESFN5V2ROWmhKS2VyWHNDZVE5RTIyOGlGbFl6SnJtR3V3?=
 =?utf-8?B?amVRVFdiUU5ha00ydVlzVmtESHdvTjN4Y0tlRHkvbzVaSkJyOFVxS2s0T1B6?=
 =?utf-8?B?UVZvMEc4Q1d3ejZwS1VnR1BYRXV5c0dzdHkrZjZ4SjFVVVJTeDJycnFnNVJa?=
 =?utf-8?B?dTZGWFgzekcycEpBUjN1WHhJUXFuN0FTS1IwM1VqMG5wMmhFak5QeUd0Vjg2?=
 =?utf-8?B?UlkxSVdBSE9aaXpCem03bkxuMUU1dGhOMHRyMUZFQWpXRnR5K2IwNWs4Zk1y?=
 =?utf-8?B?elB0bXdkNDZuZWxGcThTTFZHUVBoS3AxQVBKUm5ZVnNWcmdEL0tGZTNzM0xH?=
 =?utf-8?B?V3RJdnM4VUFnSENtZ3BzaHpQZVo5NmdkZUFqdmNjS2h2YjRKcE1mbWptNERW?=
 =?utf-8?B?SDNSNUtYc1g4Q3VySERDa2tWMUNvMHl3NzJzWEZKSllmRFdMcmp0R0praS9a?=
 =?utf-8?B?UUFWVk9WRDliZ0JUbnd4Y0dRTzVuR3VhbCtBcndyb0pSdUxML3pwMFlwYnRk?=
 =?utf-8?B?bFpGbkhCZ2lBV1Q1NDI0Y0dBMUhmZ3VZcEVjY2UrTzBSOU1Ed08zWG15alZL?=
 =?utf-8?B?YmZST2hhODJEQitWOHVGWkJEQWZpSHRpdU9EYUVqQkdPWVFZeGRUZW00UldM?=
 =?utf-8?B?WitSSTVGV0hpSzhOczAyeDlLM3hxZG1UNG5ob1BwTFZ2M2pkZWtZOUs4Vk11?=
 =?utf-8?B?SHhLMG1HV1dka0gwT0dZQzVZT29wTXZGcEc4ZVBxVE1abHVRNitKN3JscTdO?=
 =?utf-8?B?VElNMVRKUzYvRlIwZThTLytSL05jUnF6c2VvVVRHNlhLaTBsa1JDRW9uMzVH?=
 =?utf-8?B?TkFGdXJhNmRlVGw2SWZPTFd3VFBxVDV3cjdHem1oREFkdktSNHQvTTlmR240?=
 =?utf-8?B?eW9QWFZESHpwa0tJSWhPRHhZVzdxZmVnZUpLaXh2WWVyeFJaU2NRQi9Vbi9G?=
 =?utf-8?B?NVJMZjJXVlkrb2UydE1ScDE0UjlHMWhWY0hHVmlWZ25GRnpPa1gyUnQ3NzQ5?=
 =?utf-8?B?NkswM3ViT2lRWmNYK3FhM0VjMFU1azQ2aW5oVWIyRno5Q2srTTFjQ0twSVRu?=
 =?utf-8?B?VUt0dDcxaEZTRklwT1UybFZGVVR4VC9kM1ZDYXpCbDRLSnA0T3F5K1BPV3py?=
 =?utf-8?B?bUdYU2lSVGdaakhzemhUVDlmZ3VNS296bFVDNlg2YWxyWnNmNzVuMkRwU0t1?=
 =?utf-8?B?R215Z3hRaEI2a3FxUUNKeHpmY3I4N3NwYXd5NzM5M0dFeDZ5c2h6TWYyaTUr?=
 =?utf-8?B?aG5tSGJmS1lsMzArSjU3UjlIL29aVnJ3bVI0R0UzQ0VxOFFnK3o3bnBnTmhH?=
 =?utf-8?B?dk1USy95Y004TW1MRDdKSUdQWTM1Qk5RV3FYc1ZFYkp2U2h0K0xOMTNOTDdC?=
 =?utf-8?B?R3RzZ1VMNDFLUzJCR2tlNGdrejR0dFJ1eFNabGtQbFh1emJlRm5vVWdvVS9o?=
 =?utf-8?B?ZW9nY2xidThGUGplbHFwaFBIQ3FVY3RaUmZzZnFCMlU5OFRvb1RiNFRpUE9E?=
 =?utf-8?B?SE8vMVAyNFB2dkFBQ0JSa1l5WVZpTFZkdGJZMTlVWGhEZ3lhaWtqSlBtb3pv?=
 =?utf-8?B?WG14Q3UwbzNLOHp5NTg4RXB1MTd5dzFjNVkxdGJ0V1dDM0g2ZzBEelRYaXUz?=
 =?utf-8?B?TEk0ekIyY21IbysraWpBRm5mT3NVUmM0WFpGS29jemhWMFdIdkFDblRTeWtK?=
 =?utf-8?B?MUFkVUtsYnRJaHdBMjg0S2J2TmdCUDJYR291Nk5oandDcUVEM1FSd21WTWhh?=
 =?utf-8?B?RGJzSDFKbjI0S3VqRTZSbVd3SFo1bTZ5b1c2dzhIQ0d3RHhPZ0dMeURtalZ0?=
 =?utf-8?B?eVlydVhyTCtxOHE5NzFyVlF2QWpIZmpXY01SRGtNa3hJQUt2S0YrN3QyUnUv?=
 =?utf-8?B?SENkVXJNVnZFaERLaHNKMU1lR1VEeDcrY01LTDh5UWtRUGpzTlRPNWRVMlBs?=
 =?utf-8?Q?ZLrx1qB+HbnzmVj2gJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a573bc1-f1af-421f-e964-08df2b7ef4ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 12:13:58.2616 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qpThh0gZFXhdfgDalOjJdeZHqbf7zbZf1nk3MjmTbP6+n+8j7vLTY3K4Bs9mDjqN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB599680
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

On 10/16/26 14:09, Sunil Khatri wrote:
> In function amdgpu_vm_bo_insert_map, amdgpu_vm_bo_needs_update is
> skipped due to amdgpu_vm_is_bo_always_valid but it should not skip
> for bo's which are allocate have it's own dma_resv object or NULL.
> 
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for both.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index de992405ed718..3eb778add39be 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1798,7 +1798,7 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>  	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
>  		amdgpu_vm_prt_get(adev);
>  
> -	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
> +	if (!bo_va->base.moved)
>  		amdgpu_vm_bo_needs_update(&bo_va->base);
>  
>  	trace_amdgpu_vm_bo_map(bo_va, mapping);

