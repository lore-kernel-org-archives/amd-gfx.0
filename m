Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFFE7C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 10:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3985910E4B0;
	Thu, 13 Aug 2026 10:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oZhqWLwc";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012027.outbound.protection.outlook.com [52.101.48.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B368C10E4B0
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 10:53:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gx52M41M7zOSFhp6YVjjuwL2dn59qfNj0Y7FCYGw+5PHqWsLiJ8kOlws4EAnr3F1Dhpv2xB9FGwGR9kiLkf46xpKyhBFgwP9EbIGLf7B3osyv5Cgo/scm90XY9x70HzX43u+IQ3JNUOCrMu3BaZPcipZ3GzlSx4BdchaOjZ84HwedwE0wxRB21djHPR/eulcMh+uPrxtaTEwl4kMYwyY72tgMj4mC15v22h6qmibxZDuj5jGXpyvUVdZab2AXUEn6oVkdHQz39Om4fvKBPIQ97Gjjn5AwIqpdAx62weCf81xNDo06V/pumn8TBK14iPN7/FvixDDqPtXKE+AMupCxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ue/NqFCFv1ujsxF4KY/VSkBDlMuOhF/f16YoXfJ+bEg=;
 b=aZNxpU+MMDVVzrYXUkmR4CK7KEVFchycZ3Ql5s8ee4LTZRKCGodgoqp+yuxuqmiTiWxH2AoGxujqY6fBkPoe/PmtzNEOYVznoHyK9yIAwCMhuypqPxbMF0a91+5ohsD15NAG0JYIrqpcrp+OvzmM9jDpQeDK9uFX0Uw2rDkhrnkAvZ29JR1iK9V0KP38nysDW2z49PuUOFeFBCl3UyJQV3KsSE9Okzga8zJykp7snlrE5EmoRrA1Yjg7sHO4iD8XVHg4F9VpoReaw7UvnqfDj14jSu0LAHauwi04F1MNHwBysm5hzApHIjEprr+z5jTqMG8sZJdCXwrJIOYg67seFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ue/NqFCFv1ujsxF4KY/VSkBDlMuOhF/f16YoXfJ+bEg=;
 b=oZhqWLwcBYm4Ab7uJxB0fwTB2wnqVCQ80mapc5/lr2n9sv4sfkjz3kr+vW9LEeuATIVrfr7fM3v20rF3zT1jKyxhg1z7QJfsqZdVkAHE27Ljiyfbn7Gbc6nZpe0mCFCgjng5SrT0nOOaae2Tfhxr9ie/qbN66y1oyhotd3nB3a4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ5PPF2CD49510F.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::98f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Thu, 13 Aug
 2026 10:53:08 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 10:53:08 +0000
Message-ID: <99f2ce1e-5b81-4fa7-90be-d3ed251440fb@amd.com>
Date: Thu, 13 Aug 2026 12:53:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: bind imported BOs when they are opened
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com,
 Prerona Ghosh <Prerona.Ghosh@amd.com>
References: <20260812071414.1066241-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260812071414.1066241-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0196.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ5PPF2CD49510F:EE_
X-MS-Office365-Filtering-Correlation-Id: 2772ca12-dba2-4155-eb02-08def9290f77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|56012099006|18002099003|22082099003|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: patZiO+4BuelJzaUx3hjZVkv9GCFTWFB0Ml44b2N7vBcWaNe9ageqlEdrgPG70lzw1w0Tjsw2qi716EiaKssZFjKU8XD6maQovy3d5+V1SQxfYq943EQnJovgckmbbqUdxkSSsnUP2mn9rTiPLXd/8b1vuOA51MjLQqMj9GxivkPOpt/5mR0dB3hjJI6YqlVlGK2zKb/6K9LuG19XzdCJl+1xDSvyCki6SWqMe5ldqw43BMYofNKcDe4Il9ey297LG1Ilkfmvf4uH1C3JPwK5kaCTJ9IQ8cW8Ix2t1UUf5VwTrHPuXtoYp9hNMOAlEqFrzjpUWiK3ICRC1/pBRW4i9bTRxGky5CBOhW1QrTKGi7QrANtqgJ6vrikKW5Em4KHBrbIFlTbKlOx6RuMYW6hiYujSzu1mW7Ml2z8DPxaaaIr3t7WkfpcHxtB1laXchTbfOMFm2mrT0clNE2AvEZX5YKYeoPzFijmkA6zg0YDOrekh79rpShZU7DaA77jlim01tDc56QGID50t9rJJfikIRpjfuin+RwZp/TSzL5Vg1R/SC9gL2CbI/cRUUMbSBe4ghymF0/xOZTg0lx3P68thg5amP7hE54y4JckmCLaOR1i1+mAmW1UG/qgfwordIyGHUlURwEeW/eercxt7aWxuQS0WY2M0p3OZyPmBIivN4Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(56012099006)(18002099003)(22082099003)(10067099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdOTWJEcVZ4ekhmQmxhczRZQ215dTI4aVlaL0ZSdUhXZzZqR1d6Y3BWT0gy?=
 =?utf-8?B?dGhMTXlvRkZEd1p0RXU1NU5ORHBFMUJLVkpXRXFNUVJtaG5mT1I3M01qOGJs?=
 =?utf-8?B?MW0xbnlMeU5RU1lEaXRGTUlMZGk1b3R0bXZiZG84OTFqRkV6UnYzZ2RkQ255?=
 =?utf-8?B?Nlc4MnJ0VXF1eDV5TUQ2UXRsRjVYTURObVJxcDJ1K1I5amRpZTVmWTI4Tk5B?=
 =?utf-8?B?QUNqQURBWkJiMzNaZjNSbDlTKzRxR1ZXc1daWjFiQWw5V29UUkZVK1JtUHo4?=
 =?utf-8?B?amNlOHpRa2NaTnZINExZRDB0QWpVWnFUQ0UxVUdpSEMxSXF3Mi9RN1VmTjVj?=
 =?utf-8?B?WkMyOVhnU3BTZW03ajduY2w3OEVSdXFRaDVBUEp4ZGROUVJMakhLdW9Gd0FN?=
 =?utf-8?B?K3VYajNLdE9vL1VPQlU5aXZlRFlTTElzdG55ZE9mOU9KUTJ0Vm5JUXgzdFQ3?=
 =?utf-8?B?eXk4N3FCQzhxZ2NqMFZFZzcvY1M0Vm1LYkZPQTNCL3RrTXk1cTNrSDJibHZi?=
 =?utf-8?B?enErME1RajBlWHBHQlJWMEhBMW9wQkQ3ZUxnbE90MGVuS1VQSERSYlBUVzRS?=
 =?utf-8?B?QmdWZXNicy9STk81WUpWbXBuQlRPRmZmam9reFVvUUM2YjRvS3JGcjZ2YmhL?=
 =?utf-8?B?VzJzaXF5QnIrMTJIY1NhZk9xblQ3LzNFbnJ1dmhERDlGOWJici8wNkc4dlkw?=
 =?utf-8?B?WUxqMzhKSzk0VThXTVdQNkVtandtVE53cVh2QXR0K2NWekNCVS92dnF6RkVo?=
 =?utf-8?B?b2Y0V2R1dWRObG8xek4rSGt4N3htVnBOVVJBbUNSTU1iS0c4MmRWSHYxc1BU?=
 =?utf-8?B?MUxleUlwSEFkaE1KdnpZWVVpODhHOExUTWwwMm10OGJoR0tSNHhZcysyNlRV?=
 =?utf-8?B?YTd3QmlEalJ3RDZ5M2M0Y1E3SG9yTnhYYnBUKzFJWTlzTEc2VTg0OHhBRDZR?=
 =?utf-8?B?MFNCRnBXVEI0MVpkcVhKa2RTSmp3SXQ5eVdqOG54WExudGt4aVN0TDB6RGJ1?=
 =?utf-8?B?clRJdjU1MkZrbElxSnkvSVo1NnQyRUdsT1hTb3F4cUtIWXUxd0dNQk94SHZy?=
 =?utf-8?B?NWJudkNwdHlTVHhFTzZzUXlPbjREUFpHdlFPTHZSNkU2dmlPdDFqQmY5KzAr?=
 =?utf-8?B?c2JwamljL2oyMVNmNmJFNGRRMzBwMXd1RktQY2taRGZQTVpxbFVVc2VWbHhU?=
 =?utf-8?B?Vm1ITTRXb09XUWJiakxsZVdySkNPVGVycjZQUzZJVng0VG5oTVI3cWdCK3RZ?=
 =?utf-8?B?bzBpWHpLMkdKZlp6VkE4d2hCdlovUURSYW5xTDVhMUxrZ3NLMEVTVUVNd1JX?=
 =?utf-8?B?VjVON041ZUtQVmlEcnhVbDJwQlFMeXptSmtCdThqSXVMR2F3L3NONzR0MW9C?=
 =?utf-8?B?Vk51aGxSRU1VWFBlb1FoNFNna0kxcmY0K2RTKzVBS2w5YjNyRXBuN2VCYUhG?=
 =?utf-8?B?c0Ezc2ozbUZPNUc5YjJ0NXkzYjgxajNtcGZQYkFPWmQzQnJ2QS9vTE04Zkll?=
 =?utf-8?B?NTg3MC90UlZtQ0JzbkJVOXorS1lnZmxibExGaDZnbWxCWGFCalk4Nkt4UDlp?=
 =?utf-8?B?WFRtSDlpL2JwNWJ4d3NIZ0E0WWVhWnpHaHpnY29ETHg0M21qQ3h2bEtIdHdv?=
 =?utf-8?B?Q3ZSc281MTBSUjFmUDhTMGpVZXlaSFkwMkI4RXgzSWdjUUdiMUJ3OVJ6Q0Nu?=
 =?utf-8?B?dWtIQlVkWThhOExlQUJtVXh0K1NtcFdidHdUcmZEV284RUF2MFpwT1JvT0pw?=
 =?utf-8?B?QlJpVklHMEpQb1J2aFVwemtyUTVVK201NkVCR2RrRVJwVEZlY2Y3UndLYkc3?=
 =?utf-8?B?ZjdGa0UxMXBxeWlEeDlqcFVsVnA5dmdpMlR0ZjBJTzcxaUVDb0VrTWZzRUxC?=
 =?utf-8?B?SGNJK0Vqck1TTmZOSXRWOUZrMzlyREZLeHhQd2NnRUNOZkFwTDU3NE1hOU1t?=
 =?utf-8?B?cDMzZ2tHWUduNk1tUCtmSzRaODY1Sk1xRXp5NFIzZE8reXRPelRuMkVPR3NV?=
 =?utf-8?B?S2xEOTZXR3NwOEJmOW5rR0JSOW9hc0NjSG5yWk5WQ3VlaEY5U3g1TjlldHl4?=
 =?utf-8?B?b3RlYWZlOGVaN2FveG5kUURjMW1zZU5lL0JNMkliMlg4bFBNaHVlZTk2U2NC?=
 =?utf-8?B?TkFGVThYMHJZcWZtdzdOcGNBUWxRN1JiVE9nbml1bzU2OVNhdkVZWVdUQ09a?=
 =?utf-8?B?NDl5UHZiWFNLRE9sNmFET2pyTnN1Sm9GZHRrcThPc3o3b254NE5mT2xCdHky?=
 =?utf-8?B?ZWRURzl1UnMvYTN4VDllNDk2M1ZHN2hja3ZSRmJrVHk2YXM0K1dCc1BId1Jv?=
 =?utf-8?Q?Zc6TmBGxT1TvWWevja?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2772ca12-dba2-4155-eb02-08def9290f77
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 10:53:08.3755 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: va09NBsII+pi7YqMuIhyVAfaONra3oWGDA9oECfF+ZK66Vkz96uNy7bXteJY3vnU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF2CD49510F
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



On 8/12/26 09:14, Yifan Zhang wrote:
> From: Prerona Ghosh <Prerona.Ghosh@amd.com>
> 
> DMA-buf imports are created unbound and land on the VM idle list, so
> neither amdgpu_vm_validate() nor amdgpu_userq_bo_validate() ever binds
> them. Only the BO list of a command submission does, and a VM using user
> queues never runs amdgpu_cs. AMDGPU_GEM_VA then programs PTEs from a
> TTM_PL_SYSTEM resource, i.e. without AMDGPU_PTE_VALID, and the first GPU
> access faults.
> 
> Validate imports in amdgpu_gem_object_open() instead, while the BO is
> already reserved by the drm_exec context. Graphics and compute VMs now
> follow the same rule, and a BO that cannot be bound fails the ioctl
> rather than handing out a handle that only maps to faulting PTEs.
> 
> v3: validate inside amdgpu_gem_object_open (Christian)
> 
> Signed-off-by: Prerona Ghosh <Prerona.Ghosh@amd.com>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Assisted-by: Claude:claude-opus-5.0
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f754a4a3a1c2..261218cb57a6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -271,6 +271,20 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>  		++bo_va->ref_count;
>  	}
>  
> +	/* Imports are created unbound and land on the VM idle list, so neither
> +	 * amdgpu_vm_validate() nor an amdgpu_cs BO list ever binds them for a
> +	 * VM that submits through user queues. AMDGPU_GEM_VA would then program
> +	 * PTEs from a TTM_PL_SYSTEM resource, i.e. without AMDGPU_PTE_VALID.
> +	 */
> +	if (drm_gem_is_imported(obj)) {
> +		struct ttm_operation_ctx ctx = { false, false };
> +
> +		amdgpu_bo_placement_from_domain(abo, abo->allowed_domains);
> +		r = ttm_bo_validate(&abo->tbo, &abo->placement, &ctx);
> +		if (r)
> +			goto out_unlock;

Taking a look inside amdgpu_evf_mgr_attach_fence() we already have a validation there for the exact same reason:

        if (!dma_fence_is_signaled(ev_fence)) {

                amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
                ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
                if (!ret)
                        dma_resv_add_fence(resv, ev_fence,
                                           DMA_RESV_USAGE_BOOKKEEP);
        } else {
                ret = 0;
        }

So something doesn't seem to work correctly here.

Can you keep investigating why that doesn't seem to work for imported DMA-bufs?

Thanks,
Christian.


> +	}
> +
>  	drm_exec_fini(&exec);
>  
>  	/* Validate and add eviction fence to DMABuf imports with dynamic

