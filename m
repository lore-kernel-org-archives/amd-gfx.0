Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A766BFED2E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 08:22:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41FB910E191;
	Thu, 12 Mar 2026 08:22:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nvv96KjE";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012020.outbound.protection.outlook.com
 [40.93.195.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E49310E191
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 08:22:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dQ9J0FqvVUHhLHeiWDcZ2gdSaieN9w8EFfGJHlmucJM1EEeDpbXia1goJ9oHRaU5bLLadvBRuY7avKdVtq+VHF0qKJn3pEZKcg3fzMbfsQgA85WP4BHOXxIn65zqeHnR0GTk/GHnuQJHI8OcmBMQwqZMJR3JKOfn1pSeYxfdXai/etBp4NMWNR9mEakyhyoEmfptezZG/Hv3Fj6tegWJyGWULwSpajrNmXEAIUsnvrxbJJMr0TMtzbiU8noSZhm3wyeioRn5plzXzWyyU8b+JxSBOENLPd0ZfgJwbRK2CAPx5LOM697vWywTKNS2lN+HzG1XMCBIGI4bdYnAi7mjDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE0bnM/Zriue3vU3oX8l2nyDdRtszS1QyeaEtMdKtPw=;
 b=lstQRLoqMSLLl1wEyC7m+NUSAQMw3gn8vG4hCAGxM7u+4lvSxweQIBo9DA+MjnUH6y5U9iyT4MZaYnq00+DGrBtk9K2HxePwI8OVUR2PQi/6kdcuR88JpdWSFAUD8IuXg0vIiex3qHu/Gs4AQ7gdig/sAEInSZaRCG7ye22EJtVjbvN8pIFdu1jqqKoUjfTCosJIedwX+vu4Y4VGXguxBM5WZzpCnOQcqfm/0h5OuJ/FfL4jSUp6PVdU8uNWW4VCW2cKFrgkU+6r3MOJvDKtewNVWx4BOTqNBHiO9QA+E8xJ2OwmV/nYrWmyMrBmNDaSXITJEcjoNEC8yApJfqtSdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE0bnM/Zriue3vU3oX8l2nyDdRtszS1QyeaEtMdKtPw=;
 b=Nvv96KjE3LHNRkmTBgl2RvDvpUVuzlSUg7ql/UIx5QbZD9DN8of/iUu2t0ObysIV4JkXdvqAIwKszQCXu3JCDyX73iuUMLDuSLLSgxlUC1FSGJH7i5gTGIhR6h9dEb+MkOCKzV+WzteIqnHFXDoXSwYayjJXq5gO2ls64D7TX34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB8353.namprd12.prod.outlook.com (2603:10b6:610:12c::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 08:22:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9700.010; Thu, 12 Mar 2026
 08:22:53 +0000
Message-ID: <ff117d6b-943a-4555-834c-96b53bd20057@amd.com>
Date: Thu, 12 Mar 2026 09:22:49 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: add overflow check for BO list array
 allocation
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260312081827.1484742-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260312081827.1484742-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0442.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB8353:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e1fc3d-2519-4768-b5d8-08de80108e47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: MalhjyENJlWh4k65sMJf9LDm7utR5r9/jRZzAiKnIBS69ML9Xgfx0XzOVRw81rhSvLU+vk0QkRI0WRoP7Qe2Nsn16wtL1CpgAx2i1XfeGok8c0mX5Po15gTrrA5ERhuyPFs0ozMSu/fEy1fkwjxhumYUnCI9HPtxNHGNjpKhxVylVqjyqghvvTe+yIRA61hAVEG7AoTQRto0/m1EMZ9861Mtz2nZVILeYNNXAOFjXCwRixYmLeiNVxpEr44gUJPBR/3eZwU7g3F6657NNfcymwPBTb1aZedZ9mPv4TvbgJnK/ucKBwOwtMav2tti6iEifZFKOtMc8nIwmogjAJxfW0MFFA4ODbhvkFj0coizkscGJ6gP7VY6V5lXaP7Q3cEFfYHX8iASduHdboa5Wkyglk3cJng3qKcLMucfukMVEo6X2Y91IRU7wIk4waY3YebdkH8lUAZzT7sWo4mcjfTveSxpyqfJkMj0B8Gx59Xe7OrzqO5cHYPxU/RjWPoFdkISMqt+dLIaDQxjWJtn+ivJKNVg91oV6r6Kh7xPTL7871/4LoeBFu7bv6mu5hVIFJU9TWA/2dQDt0agaWE9Lqt58BaPVXJ7U02QyY0ebscHXl6y15P2vQerQbygDUZml721vHFtBLm6Pc8HA3qxTGj8ryZ2elSFmHJtGA4eaC3L5Dy4WpwU27DuTlF7BJjM5+dr4o0v6tBP+hZgKV7RonySykc3Pugd8A8KsP44hveVXYM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2tyOTBoRVdkQk1uNlE4SU51OUZiVCt5clN2VDZQZjUzM0VQRWViN3htbnc3?=
 =?utf-8?B?Z3hlTU9tRlVJRGRxcHQ0eVN3N2Y2SW15bWNjWWlHbVZXbnZ3VDJ0QUtIYmxK?=
 =?utf-8?B?d044d2VKN3NUNThBcWk5QnhZanVCcjVCeHpyRVVwNEZoaWxVUTFrWWNMUk9F?=
 =?utf-8?B?Qk9wS0lMNlpVY3AwMytGK3FOaEJDa00zd2hiNUpac3ZCbEd3ZmtEbWY1VllT?=
 =?utf-8?B?d1N5MHREVUlhWGJITVNOd3lab0pRSFRRclhPLzlYaFJVRXlFUWhkNTljTHZR?=
 =?utf-8?B?T1Arem95M3QvdWM2TmtRUThCd2w2YUFEazRTa216YjhYWkNDMHcxZm1TenBR?=
 =?utf-8?B?RHdJRVpKbkV4MEJnVU5TRlZLN0ZSVWlFOEZjUzBhcFBPREU1QnV6Yks4NW9i?=
 =?utf-8?B?OXFpbjBjM3Jxb3ZMc0VOR1BITEZva1E2aXYvS3VLWHhLK25SMmRiK0tzc1By?=
 =?utf-8?B?MWlpK1BRMURtdktnRFhqbjhGUFZJaVllRGFBMDZQOG5kN2cxR0w3citscWVu?=
 =?utf-8?B?RWE2RzY1UXZianZzUDRmVUg2S2U5ZU96RTlPdFpWVkRkRWJrWWNVUnRUNHpS?=
 =?utf-8?B?WEYzeG50UW9mT2NkQ0lnTm90QzZ5S0xKOWx5T1ljS0FBNUhlR2NvZnRIT2hI?=
 =?utf-8?B?b09lY3BqeWJyV3ZJdm5rTDRxSlpCUjEyd2NNQmtvanJOVEtidHpPZlhqc1Fp?=
 =?utf-8?B?dFBra0Jhc1diaVgvS3FYQ0JFaGh6N1l2ZWNJdlUyRlFwclJBc3F5RENlUFl5?=
 =?utf-8?B?OWVHdDVhbUwvZnVDWnczaEVpT1NNVHV5MDl3eXFtSnBjSG9hUWpjdmhadkZV?=
 =?utf-8?B?NE5wRnFidFB5S0RZRDJSenRYR0VtTFZqVTZmWkZSbkxaU1lpa2x4TkxaYWUr?=
 =?utf-8?B?T3dUcHpvSnJOdU1ObmRrK1NJNXI5MzRNQ0d5Z3VadGJ0dEt1RC9hYTExL253?=
 =?utf-8?B?ZkJRbDR4UUdJRkw3MU5NUDF0ajBITVZ5QlIzNmxnOVZBSmxDNTlMWFpiUDRD?=
 =?utf-8?B?UUl4dEVNUEdBOXZ5ZUdqdzZzV2FCQmJCY2pmaTVqSXo0MWNWOExOK0NTbnJN?=
 =?utf-8?B?ei9pWEtJaVdDWHo1NDk1TVhSWnFEY0VQNTdhRXpqQ1dFSlhVeFhndXl2aUFZ?=
 =?utf-8?B?aDNLUC9BTGVlWVhNL2xyUzJiWXk3amM3ZWo5V2RIRitqWnBGOElldGE5WVlj?=
 =?utf-8?B?MlA4Z0Z4aisvdFRFZExrVXpuL0xEOCs5OW45NG5ZYjFlZkM3cjhwZWp3bTlQ?=
 =?utf-8?B?YVJrbEUzY3MwUno2WGxDcEVyV2N6b0szeVp5bThQNHdNN3FqMlBaT2lyZ0pL?=
 =?utf-8?B?MEV2dm5xTTJDYmx6bk9CYjVWbnR2RXNuRitES0U1WkFTcnVaZjhYckFvZEYr?=
 =?utf-8?B?dlhyU1JleEdBUmxxN0tKZWlmTTFKMlpUUnBGVkJZUktNVG9sZTRzYnl5TTNN?=
 =?utf-8?B?RW9CamVWUDhnc2lOYlQvNm94b3ZuaHJpUm9nbFZIb2ZQUVN4Q051blhtVndV?=
 =?utf-8?B?TmloS2psMjZCKy9FU3dPUGMwUDN3eFhUWld0TDRVSjR3VDFGbXV6VVFOb0xN?=
 =?utf-8?B?WllwM3Y0a2ZUMTg3Y0U0OTZUWEdrTHlaTjhUcXJ5SHZzV3pLMktxMk5kZEd1?=
 =?utf-8?B?d0RaMzJJZnRrUXdlV2pKanhiZE1vTC9zMCszd01rVExaMkV4cjk2K1hNaHVU?=
 =?utf-8?B?NllGeEJqTVpud0hldnlzaWo2YUJHbUo2VDhRT29nUGQrVmxJcDl5ZnlxMnN3?=
 =?utf-8?B?cTdOcGpMV3ZsYlBuMXVwN25KcTNmS0J0S05iOEdGQjA2WGd1aWdNblVCdTdE?=
 =?utf-8?B?Y1ZiTjZCSTArQ2tKdUQ0Tm05ek5ZenNDQUtFUDVsUUFSWHU3TnN0MEVLcnBV?=
 =?utf-8?B?bm9rSUtiWngrbEF0NXRXb0JxU3VyTGgrNFBYVGVtejJXbDEzckJPUXFOcEt3?=
 =?utf-8?B?MFRyR0EvbnBYNDY2Z1VyT3lNdTVUNzAzTGNEUWtuRUV6Um1sQWRrcUp0Nm5E?=
 =?utf-8?B?WW81QmZweUZUQWJnRkV3VWt0YzBTdTZKQlZqakwwRnpMeW5ENm1aN00zY1Vp?=
 =?utf-8?B?WkhHTDUxQkROQVEvSll5emFMQ05EZDhKZGZ4STBvVncrMnBmYzcwODJjeXpZ?=
 =?utf-8?B?aS9XcG5VVjhUSWQrN2Vad3Q5VnZXZW1ZYVFiWHdxd3FLbGJEMm9tN3J1K0gz?=
 =?utf-8?B?UmNMWU1uZm1Cbkx1dGtDNmZJRUh6ZmgrU2VnWkcwS1AxT2F5cnNYekx2NkJq?=
 =?utf-8?B?aXFxTGk3dnRNZUp6SHJPM0FONXl1R01JTmJpWm1GZEgyR2dtckgrRmxxTFkz?=
 =?utf-8?Q?4GmL5AGTp2BsE4fB14?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e1fc3d-2519-4768-b5d8-08de80108e47
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:22:53.0841 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 44HTWZ9UeX5q5WzR47ASWyBI/KAsI3ah1Ego7jtQZ93JNyYDeOihcHEewfZnd9rv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8353
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

On 3/12/26 09:18, Jesse.Zhang wrote:
> When allocating memory for a BO list array, the multiplication
> bo_number * info_size may overflow on 32-bit systems if userspace
> supplies large values. This could lead to allocating a smaller buffer
> than expected, followed by a memset or copy_from_user that writes
> beyond the allocated memory, potentially causing memory corruption or
> information disclosure.
> 
> Add an overflow check using check_mul_overflow to detect such cases.
> Also ensure the resulting allocation size does not exceed INT_MAX,
> as the subsequent user copy operations may rely on this limit.
> Return -EINVAL if either condition fails.

That is completely unnecessary, vmemdup_array_user() already does that check.

> 
> A crash log illustrating the issue:
> 
> [ 2943.053706] RIP: 0010:__kvmalloc_node_noprof+0x5be/0x8a0
> ...
> [ 2943.053725] Call Trace:
> [ 2943.053728] amdgpu_bo_create_list_entry_array+0x42/0x130 [amdgpu]
> [ 2943.053947] amdgpu_bo_list_ioctl+0x51/0x300 [amdgpu]
> [ 2943.054277] drm_ioctl+0x2cb/0x5a0 [drm]
> [ 2943.054379] __x64_sys_ioctl+0x9e/0xf0
> 
> The overflow occurs in the allocation inside
> amdgpu_bo_create_list_entry_array, leading to a crash in
> vmemdup_user (via __kvmalloc_node_noprof).

How and on which kernel can you reproduce that?

Regards,
Christian.

> 
> Signed-off-by: Jesse.Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 87ec46c56a6e..efab39ba7f51 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -29,6 +29,7 @@
>   */
>  
>  #include <linux/sort.h>
> +#include <linux/overflow.h>
>  #include <linux/uaccess.h>
>  
>  #include "amdgpu.h"
> @@ -187,6 +188,11 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  	const uint32_t bo_info_size = in->bo_info_size;
>  	const uint32_t bo_number = in->bo_number;
>  	struct drm_amdgpu_bo_list_entry *info;
> +	size_t alloc_size;
> +
> +	if (check_mul_overflow((size_t)bo_number, (size_t)info_size,
> +			       &alloc_size) || alloc_size > INT_MAX)
> +		return -EINVAL;
>  
>  	/* copy the handle array from userspace to a kernel buffer */
>  	if (likely(info_size == bo_info_size)) {
> @@ -201,7 +207,7 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
>  		if (!info)
>  			return -ENOMEM;
>  
> -		memset(info, 0, bo_number * info_size);
> +		memset(info, 0, alloc_size);
>  		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
>  			if (copy_from_user(&info[i], uptr, bytes)) {
>  				kvfree(info);

