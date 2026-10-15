Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91D4CC6B34
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 08:19:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 166EE10EB91;
	Thu, 15 Oct 2026 08:18:55 +0000 (UTC)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE8F10EB91
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 08:18:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNxSRakF3a/f6zDbnBndD6NccO9xCFDyHAxfbVtMkusEqr1eVTBzXasZBpHfivMQBBqxm4lpVOttjl3XYbpHgY6phhxyfax5bbDvHxGUN1mwj4bRDZS9MI1TkB0MyF5+BsrkR2ksq4eWNsBQ7Rbwr9JEadCUoqbkFTM/gf4rSGTsY9/ZJLPqpKY3ZhUcjwHKC8r2VqGLNWwz0uJ3aW7oQwb5iAzndkz6ickWYINSHOpGc7SJlO058u4YUCjPy71G0QDUbU6Z5UDc6NlP/Ae5qjgOOfmyjaK0WCifyII9TOqO2A3Xnyf/y8Pc7qm6xYWKq882TtPmFg+fl893JodT8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axmiSjMAs4Ugm11fqChtZywjof7pl8qnFxw6O2G6EWo=;
 b=TZq6dNVhX9OlJQh7HiOwgBo0eFa7eDl9U44h4gdLlHrVSkRSYi7zoQ1vBJQSdCUIIRe8gYhzuBSXeF4g0sWqZGiVe2Vui82n13yiDtNU3tszW/jYZuhBp6ARcvjU1MX4KjxNNBZ29e1k4nXBmBQgTBgEKsOK4RuNfDQ9p5veQqcX4zgLrFhNazIJkV0H8+XkfqfjqD5NP1kC66p3mD5kdHIWBCgx5Lpug0hNVSL+RF10GLenaXrFwuJrXDwwIFNg8hvwoFE22T6BMwO+uufjBPaqwZr3KYC/IQisAhJinHdyzaWq70v0ZIEGr2aisjEvR7vPIsmThy9XTqVLhzbBCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axmiSjMAs4Ugm11fqChtZywjof7pl8qnFxw6O2G6EWo=;
 b=sV5gdrNj/R18kBzVv5LBLnmlN0vYosFFxFDcz8H+zV348ZwsNah13Ow2u9YXeycgS7++LjHdDS6WWzYMOAk9CJ8xXbTot4ET160/zNqPHo5peBEW5Oe6nBH0KrOk4fs2o1QCcSLd1U68Dvd2gfJhelbxxF4gCLcXqKOQj1BJCds=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9574.namprd12.prod.outlook.com (2603:10b6:610:2ae::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Thu, 15 Oct
 2026 08:18:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Thu, 15 Oct 2026
 08:18:47 +0000
Message-ID: <f5c1211a-a4a7-415c-b3a0-21e636d28548@amd.com>
Date: Thu, 15 Oct 2026 10:18:43 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: return copy errors from
 AMDGPU_INFO_UQ_FW_AREAS
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261015021011.3221624-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261015021011.3221624-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0320.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9574:EE_
X-MS-Office365-Filtering-Correlation-Id: 471a6ba5-0d9b-45f1-e2d1-08df2a94ef61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|261009223027099003|56012099006|11063799006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: Qo7omQhGp7tiFfK4eLYWjk3cO7t3US+jt3DJ8wlJiNNohHVkPO0NTmpsD/VI9xJTT2slo3l1xGWGqTGbytxJFhvhCpLis3arBULfyrILh3/c33o7nmSEobwtMp1uAwJoSLELB2tBGV0dD+eM1cF0zAKWKVF6luunlyazOjbUAwRkblGNX1wghq+HG3OssV4uxP26cZhVc8fBHJSZ/hXIahlTaZIDjMsa6c0D86YLT9dmLxxcsgkYcZ3/lFS82TVxVDZDEg6A2IxgU+OaegeNXJa0xifdj4d2F93lqczl2QPILFkyj8kuU21oLEU8vBJUHLVskv/UN/ot9vBqMV5U1IVAXB5deHuljkHFbPyPrqi9F+IAfRFCGG2zLQSu2OXy9gw9uuqcKnYjM6WwTC+4gYMWyiHuUiqh1U5NHnx1zP9uhcmu07KmwMu0dE49yesUUoeH0Vmn9m8GPzXsZIUYZBCKmHeXhKyHYkPOmhJssCTtTQmHmy550oLbcXFcWPCXDS4F5QZWQKeudnTsLRJ7Fpf5n4WYqYqz5Ix10grvSLfPu0n0Pmws6b2p0T2rkAtHyVBeUh8D3Eh1Bc2LWQyej+ib8dj6QBRAJJbDTXxQ5ezdiZtzrADXxsXYJj44+JHSrV3Jd2vzKidJ+nVbZ5lannNVoJLcOEKuWVLhNAYGy/I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(261009223027099003)(56012099006)(11063799006)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUpVay8vSFh4Nng0VlBSMWdVRjFsVy8waUJ3bkM0THhXOEF5QVJldU1qU2s4?=
 =?utf-8?B?QXQxaXJDMzZUaVpPL2loUmxFN1Q3dkNJeGNMQVFnQkhxdXBicUlLMkI3ZjJq?=
 =?utf-8?B?N0lMcGVEMzdJR2lMczUzU0pCN1JRWVVvclpPTUcrMVJmWHFuVmxaU2VhMmhE?=
 =?utf-8?B?NU51blgrNGdOM2Q2aVk1SWpRTHVnY0Z0WXNwdVZnSmhUbnI5bC9ZVDlxc1Zj?=
 =?utf-8?B?bkVyZFhtaklNNHc4VkY0Tzg2Z3RuYXAwNHJRcnlTL3krcFhSM1g5ZlZ3Q29O?=
 =?utf-8?B?OVJRR0tnbmpLdEwwL3pOMlpTTy9DWjRmWmEybzdXL3hxdElnUHNwNzk2ZFAz?=
 =?utf-8?B?VDlEYWk4bzJvMG5TWHlnaWNrOStrNnNDb3JDazVSdGxvVkE5VDRRLytpenNt?=
 =?utf-8?B?blpWUUNCYlBXN3NUa1h4cWxvRUZScmVGK0M1NGR1Yy9Pd3g5Y2VsMlhtbFRi?=
 =?utf-8?B?Wm9FeTJBa01RV3RGek9nRmo4K3pzdlVCMW5ZbTFqRDliWFJGMVRXUDBLWnB3?=
 =?utf-8?B?QnZRSFFubGJUdmMwUHpkWVRMSXlObVA4S01CSFNnOE9PRjNiYmxpYksyNGNs?=
 =?utf-8?B?UkVjVUF4UzM5L1pZVVJaMTNmQ0trSXlyUkxZdkJNV1FCZCtvdDZ2Uktja0RS?=
 =?utf-8?B?SlhWWm5DTjlMQVIyeTlGWU9TYjBObWUxLzQvdm1KVEg3aWdTUTg0Vnh3NHda?=
 =?utf-8?B?cURXREkxSFJqMWFOREpIYkNubTNELytnSTdZY2xXOGJvelBwVmRGNERKL3FQ?=
 =?utf-8?B?SnAzOWZydk0zcnpGWXVNdndsZEJ5MUF2V3RNSERCaFlkSFAzTXpkNEMwUEl0?=
 =?utf-8?B?ZzNxR3VXWHB6NTlzYzN4dEJWdTVEY1VQK0FNTG5rb1hBVFN0ai9GWEkwMWpZ?=
 =?utf-8?B?VllzNmZpc0Rsc2Y2aWd5NlJPK05WM0kvaGszajIwQzBKcHRSK1hSbkRLYkFN?=
 =?utf-8?B?bkEyN1Jwc2xudkwyWXBDNXFNenNCRkU2cUp0b1hVZDNmNnY0bDdYa2dJV29y?=
 =?utf-8?B?MDRiM2FpUHg3N2ZxaUdlZ29QcUhtTWk2N0twc1pvMnJvcVRUVzBENm5sZndL?=
 =?utf-8?B?RVFtSTlrcU5IbytRaDNtNGd6azAwS1Q4ZW5zaXZtVjRsemJ3aDNmTXYxalJs?=
 =?utf-8?B?dzd4eUpnd2ErUXcrb2NxMXpqYVFUbC9ka1RWandPNVJHbTRKRHVTWExEaCtl?=
 =?utf-8?B?Q3o0YzVNeVY3ZERGZHdpQ21IZEZaRzJkSWtiaXFSZndpMEVMK055Smw5QnNS?=
 =?utf-8?B?cnNzSzlMRERBWndXZ0VzYm9nVFVPeEMxUjE2RUJvMWQwS2FtV1k2cmF5TVdX?=
 =?utf-8?B?cjR4K2FMbVpIWkEvSTFQQ3JJUlp4cXFIbStvbTlhdkpMSVpGeWJUUy8vOERD?=
 =?utf-8?B?MmRuOWgzWUZSLzZpdlZBRjNOVW1lUld1UklsSFpUUVpmMWtZSlpENTVYdERr?=
 =?utf-8?B?eFF0TFVib1RkZ1NTU1QxQThkQUthdmpGOHQ1OVNzbUM5ZlRzYlM3azY3MlBP?=
 =?utf-8?B?a2Ftb0E3S1I2THowT2crY3R2aWtYUC9IU3U0Rjk5dEtWOHo1aGVmRGlMcWx6?=
 =?utf-8?B?Y0hoemltQitIVXhIQVZid0ljTU5ybXhQRzFvS2VEQThiQWRBTnYzaHZQOGpN?=
 =?utf-8?B?ekFRZnlIZTlTb1pFVHdod1d1N3dVQmpqelFJZjM3SGlOSzZVNzU2czRWajFD?=
 =?utf-8?B?N2l2dnVHQmpOQkZZcit1U1RVT3FzVUljOEhxWE4rUGM0ZytUTTc0T0U4eDBL?=
 =?utf-8?B?ekJLZGxZc2VZMG1JSG5aZEVjNXNZZWt5QnhVNzNRNUdmWDBvcnZpZEJkdHJx?=
 =?utf-8?B?bmFMUHVqdkdwNDhqQ3JidVA3aDZzaFJNUWVCUDZTWWZMU0N2VHJibFIwQlhM?=
 =?utf-8?B?MXl1S1hwU0QwZE9zZmtlZWY5VkJGMkcvZ0wyRzdMYkt3dWVaUWEwejkrcW5T?=
 =?utf-8?B?RGFlb3phUE1tU1BnWkNCWHFHbHozODNoSTR1VlJBUzhuZ3dQbTNwTTh3aTVM?=
 =?utf-8?B?UE10OUZDT0c1TUFQQUJEZ29ZTDBmWWlBOER0bnJWdnJGSG1Oem1MZE04QUtK?=
 =?utf-8?B?R2J0UENrSHRERDVKRjc3RWJXdStvcWwrT0NnQ1lkVXhoakFFZElSclQ3ckdn?=
 =?utf-8?B?SW9MaithSm1LYXlpYm11aS83QzFmTHZ4SWwvbUZRdUpHMmNFdE5DWkZJOWxa?=
 =?utf-8?B?dk5jclg5Y0o1bzROME5vd3AzNVZjL0g0NEpmbGViR1ZIVU4yZm03c0VrUXpZ?=
 =?utf-8?B?aEtxQ2h4K1kwTTQvZ2dYUll6YWJzcHdXNFpCeVVwWEtZQ2FuTy9pZEdoTDdF?=
 =?utf-8?Q?bzlknQipwJjpC10oeJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 471a6ba5-0d9b-45f1-e2d1-08df2a94ef61
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 08:18:47.1403 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YFc9LhUNEcVmeUErfq0EVYyXyJh+xsXWVY1JHB1hvjhq1RFPq5FVuyVoyEaVfFSV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9574
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



On 10/15/26 04:09, Jesse Zhang wrote:
> The GFX, compute and SDMA branches of AMDGPU_INFO_UQ_FW_AREAS work out
> -EFAULT when the result can't be copied to userspace but return 0 all
> the same, so the caller goes on with a buffer that was never written.
> 
> On navi31, querying any of the three into a read-only page returns 0,
> while e.g. AMDGPU_INFO_DEV_INFO returns -EFAULT for the same page.
> 
> Return the result of the copy.
> 
> v2: return copy_to_user() ? -EFAULT : 0 directly (Christian)
> 
> Fixes: 90c448fef312 ("drm/amdgpu: add new AMDGPU_INFO subquery for userq objects")
> Fixes: 44b69cf1d35c ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for compute")
> Fixes: 0030595c3e8b ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for sdma")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 084d8517c194..54e3cd04e7ee 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1431,24 +1431,24 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  				return ret;
>  
>  			ret = copy_to_user(out, &meta_info,
> -						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
> -			return 0;
> +					   min((size_t)size, sizeof(meta_info)));
> +			return ret ? -EFAULT : 0;
>  		case AMDGPU_HW_IP_COMPUTE:
>  			ret = amdgpu_userq_metadata_info_compute(adev, info, &meta_info.compute);
>  			if (ret)
>  				return ret;
>  
>  			ret = copy_to_user(out, &meta_info,
> -						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
> -			return 0;
> +					   min((size_t)size, sizeof(meta_info)));
> +			return ret ? -EFAULT : 0;
>  		case AMDGPU_HW_IP_DMA:
>  			ret = amdgpu_userq_metadata_info_sdma(adev, info, &meta_info.sdma);
>  			if (ret)
>  				return ret;
>  
>  			ret = copy_to_user(out, &meta_info,
> -						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
> -			return 0;
> +					   min((size_t)size, sizeof(meta_info)));
> +			return ret ? -EFAULT : 0;
>  		default:
>  			return -EINVAL;
>  		}

