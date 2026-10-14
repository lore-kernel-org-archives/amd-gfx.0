Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2AECC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 10:59:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B19B10FCCE;
	Wed, 14 Oct 2026 10:59:31 +0000 (UTC)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013032.outbound.protection.outlook.com
 [40.107.201.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0458E10FCCE
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 10:59:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tl18zLtaUZhC8akJUOF6uJL4ZmMJc1O84cS6KLjjJ0KaemudIeM65Rbcnjvs7tMuchj1xMk+bQmXM/dpEfSvJ6MA+rd3dwo1XPBKmomZEdjosSmcB0y1FBmpSHguaH/V+Q/ryAa9lEGqwCH/1W+pnmOigNBPqq5O17GqvQ+50d8o1Sh3GC4qzpAKF50T++Qz7IQOcx5yJi0ZBA7m4MLt6GdOWSAl7jZDAyTAefY6hJLq02RQIeXcgnLUK5pyLgW0SWoK67g0qPU6/Eddxue2JExQucPa54IzFMpT1kSYsi58E+4/krwoS7XCffZJRr5v6vOJQWHBLBHELgO+8lla6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIEDxGmQao1owWhNerUarMOJ+Kdm1GU9fbNNbywyclY=;
 b=vPzrturoMuxCicRUCJDAJLMFWmN6uZapTDAA9bNgnPzye+FaLfvDH1Oyhs+ZTezGqBGR+SAwdc8K0TjmaY0JZU6bZyJ8nHqBp9Fwb9ZdvE5CqZjGlVowtIZ7mXCoyf528nyQb+QKtFfK09GClE1D+P7+SXxi561B5N+5LZpyUolMMhwO1561Z3B3SLq/ZlM5kQKzrWwVYek7I8sNehvOdDA7174lyyah3eC9a5vk/XG+VLqxbdCY80b+wfhc1rgLqb2Ld8vEjMIsVte48oq3QVuXLfV5u10q7zA8DQ8SBykf9w/GqtV8t+CI/X7k6TfRUdSY6u7AkP7mEh0lRy0qWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIEDxGmQao1owWhNerUarMOJ+Kdm1GU9fbNNbywyclY=;
 b=SdYHKSLMofY9quYxGUSdduPrpQmcCrZsWCGf2MczXnMm7jXfckd+yKVJLah8jE2u1dP7gs5h2dgwFPIAKvIcjbYIPBJuM23qSTYJQ2s+1UCfv0Y1xgUBMlXy3LcK5OHFfP2xF7KWgUFWyIt8pvvb1mmW5y6x7sSt5z5/17/tb50=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Wed, 14 Oct
 2026 10:59:21 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.011; Wed, 14 Oct 2026
 10:59:21 +0000
Message-ID: <d21e8c96-3a86-4d11-b446-d249e65a53dd@amd.com>
Date: Wed, 14 Oct 2026 12:59:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: return copy errors from
 AMDGPU_INFO_UQ_FW_AREAS
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261014092009.2933906-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261014092009.2933906-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:208:32d::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: f4026ed3-e214-472b-c984-08df29e23378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|10067099003|22082099003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: yiqmcWTa7o3NJj+wtFQOiYmrx0FMvGI45TrKlDSXgDUVGbBAbMZkDxuJ1Vme+otwRBTxMdx3RoaFZVjh4b+0iKNiKmy0gwwx++ZqimB44HpbG23qO4zxQJsWTnRXDxyYo8/brUkQ+hqt3t3R4Xm5q2fmlelU6YUNfEuAu0jmSTmgsCiP+M1GAYLtSskinFfp+7hrV/IcVjL8clbl7/53BzrkHcN3YR0qZVV6qDN3d0Jtzouwyn3sZb5+4plZFs4ePJzwWArLuSwT2zwZALCMsk9wRwVt4/BF1e0bB5ePh829UW1uW+Ll1Aw563oJHg2r5CDvebVYqxZBqUNmfQTtLuDcfjtS2YP99OgaBJHIpz6XpKVKcHttx5SE4hSCaU70K7iM/wYuMldC2JYh8ogGZpn5PPeiBu56MoqgOXzndfWaUQSe/nl4Ptvtx70pupiSpvWnZWF6yqBDHS3ymlc60XCXR888oJjaJdVVSuJGxVb7EqAA1rpbluQFQNkmzqZ0vjIMWCcHQhDi3yYKoKVv3dNfosrZxRnyWG86+R6sExOn1DdnDPRBs3kskC642/Ue/C4ID9y6VLuw/FnDIbaTvseLHf3MGq1MihEQkkqZYrBNw6tGS5ChdegQEPz6N99+Vx+ylIlvMi6bFP7yUdkCZXZvfiS5TD4ZPQIetWwW+Es=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(10067099003)(22082099003)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGFiUElkY2Vod1FONVkyZ3RWdHNoSkFGaGRxRFhtRWlxSkVnT1JVdnBnUkFT?=
 =?utf-8?B?TTZEdXd3VWtKRXFYQzBHdGltVy9xWXZHaVBSbzl4SEFHYldCVUwzYmRybm1R?=
 =?utf-8?B?RnlIejF5Q2k3dEovUm1NdEgxekhoZFJqUFFPT1g0Uy8zbXgybzQrYXdZdGVO?=
 =?utf-8?B?OS93ZkxWK1p6b0NnM0FqRXM0Uk9oQmlmQmlmcHl0RFVOdUJzbXRYbFVUNU5W?=
 =?utf-8?B?VHA0QmNqV3lxR0hLQ3lFSW81dm9rTEtIR1A4MXZTVW03VFp1ZFVTN0gvUkVP?=
 =?utf-8?B?eEtiQ2d5MlZTQ3k5OGNaK0ZCSjBDR0tIQ0tlRFMwWkN5UlE3SGl4R3hRVXBw?=
 =?utf-8?B?aThEdTA2NGxIbHJHUjlQaDg0aXZ0dGUvdUZiZ3dPN1hhMGRWd250aUp4ZWlv?=
 =?utf-8?B?WWhVbjhmK3RBeitib2phRkIyei9MQ01tanR0NnFaT3dwZ1F4TDI4VDZzd2U1?=
 =?utf-8?B?Ynp6ZFI0TmVNTkhvYnNjb2poNEljQStvU3Q4WlZGQ0JPREpJdS9CbFloVGlK?=
 =?utf-8?B?SHBmcDJ6VEFlUG5ibWFRWHFlTm94dEEvWmwxUWJTTlNRN1NENTJFZUhDVHpZ?=
 =?utf-8?B?OHQrNExHUTh2NlBtWHhPbkpTWFJoOGpVZkV4bU9FYjMvalBiNWRmNDdCazNt?=
 =?utf-8?B?S1FBNXRzSmQxbFo4N1lWRnpYMGNMU0E2b1c0TUxsd0RkSVFYeCtqM05pUTFI?=
 =?utf-8?B?VjIwUDI1clZRRHVSbzdHdjNRaktDRm1nSExUMzJobkVBY0hYSmxvNFkvaWhD?=
 =?utf-8?B?ZDNMVFg2S3FPQnlKamRRT3NmLzBpQjVjeFZzNHRWRlM3UXUvcFN6akpNZEN2?=
 =?utf-8?B?eUZ3a3dkbEltUkVxdEJ5bUJpSjRXV0ZlVTRwRkgvdk5udXhxbkVzdFQxN1JE?=
 =?utf-8?B?ZDNtenR5ZTJTM01UbGZKSUZ4QUN6RUh1WFYrQTVhM0pwcjlmdDZENGxaRDlj?=
 =?utf-8?B?bXFDWEM5cFgreGFReUVlcHVLcnMwaDdJMWpvUTFsdVdOczJ0UjJKdzZMWmp0?=
 =?utf-8?B?U2tZTzA5MndNRFdqS0NsQWlUdjZNdXFrN2puZlVacjJRZE1nb3prUFJZMVBW?=
 =?utf-8?B?ZUZHT1VFQ2xHNG1oSkFsTzkzOHhiM28zQjEwYkJ0cEcvaUlhU3czMzdXRkRX?=
 =?utf-8?B?N05kdWpVMnVZdzZnQjIxMG5VYlFuNHp2MG5wVWRYS3o3WGVsYlZkTU9CWW1q?=
 =?utf-8?B?SXJGNE5vcG05T2QwL3E0RWVqWmZMdmVtWjN0ejBPd3lRUUl0OTlLK21RZXFC?=
 =?utf-8?B?dnpvZ0F4Sy82ZWFHbEVBQmphWmV3MFJtOWV5V0VrYWU4YVFQNWVtdnlRamor?=
 =?utf-8?B?UkI4Z3Jrc0p4ZW85QWhJemx0bVVwMmVocGo5S1ZWUExlczZ6Mk9RMzZMZEtI?=
 =?utf-8?B?eFU4MW9aNlhYWlZQcmVWQkJQSmhiTGw5NlJ0ZVp4V1F1c2ZnQWFJRFBkSmVS?=
 =?utf-8?B?OXd5TkVFWnFvdkdHeEpCV3JvcE9uMlhIVFFYMVRaRVpmcVptcTNhbEh0ZVlt?=
 =?utf-8?B?MTVSVFBBUUlZM29wZVRPSnowZ09hQWpXYWhuY3cyL0NZdDVMTGFQZzliNnRy?=
 =?utf-8?B?T2YrM3l3SjFDK0plVU9QNGFSWkRjMXlwUnUwTmcwSGFwSlEyMkhVQk9WM1ls?=
 =?utf-8?B?bFJZK05sSnFpOTVrN3ZLNzJqakNaMGhGa01aU2oycFV1OFRVTUtOTFgrdkpS?=
 =?utf-8?B?dnUyOEhTTTdzTzdLejFSZ0JHY0xYdlhKbFRWUmt5a0FRUEJlT2JSS0ZUMm01?=
 =?utf-8?B?M1BHQ2FaakhIR0VGRllLN2FKZmtvRlZ3d1FWaVlVQzROaVBCbmlyWmVpY1dL?=
 =?utf-8?B?Szh1U2JUZ3RPejlFWURuNll3UDdlMnhXdXVWdUFsRzZoRm85VjRuVnJyUEFG?=
 =?utf-8?B?OCsvSitGdUxQYW82am5TK3NJZnN6ekNQaFppR2pxNU5sVG9jd3lSV2RBNzVr?=
 =?utf-8?B?UkJtSXFXUEJrSWZNVlhhRDB0UVBHMytQUkxRNG0vRng0bzhpZXRUbmF5M1VU?=
 =?utf-8?B?eDVCTG5MT21UanZwbkZqb2Rtckx5b0lpQVROdnhMUk9ZWmN3VDZvSDZFdDJV?=
 =?utf-8?B?eVZYcS9YVHlxUGJ1eTRLN09MTWRPMzdkdXhtNXhacjRNa0RvbXBkZC9UVW1Z?=
 =?utf-8?B?bGNZa0N4bmgwRFVCQ3ZqUGI3aTVkb2hmdEZOeXhmVVJJemRzbkRYZnVPUlVR?=
 =?utf-8?B?RHl4dWs1TzgrTEo5UmtKeWNoa0pPRHhSb2xxc3ZlbS8zVTRabzBxMUIwRHdT?=
 =?utf-8?B?ZXdhSVhKQUFGbHU2UmgyeFNnaFBabmhZTFZmemNHL0tEWEdMdUpNLzJxTVZL?=
 =?utf-8?Q?Jw4zBPQH32f9zyMlGI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4026ed3-e214-472b-c984-08df29e23378
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 10:59:21.4340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0On9nYCIwlRBzy1yz87YsqBHo7xwvLwE2KnOqyMC8b1SrmB2FBTujyfV8/hrcThH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967
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

On 10/14/26 11:19, Jesse Zhang wrote:
> The GFX, compute and SDMA branches of AMDGPU_INFO_UQ_FW_AREAS work out
> -EFAULT when the result can't be copied to userspace but return 0 all
> the same, so the caller goes on with a buffer that was never written.
> 
> On navi31, querying any of the three into a read-only page returns 0,
> while e.g. AMDGPU_INFO_DEV_INFO returns -EFAULT for the same page.
> 
> Return the result of the copy.
> 
> Fixes: 90c448fef312 ("drm/amdgpu: add new AMDGPU_INFO subquery for userq objects")
> Fixes: 44b69cf1d35c ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for compute")
> Fixes: 0030595c3e8b ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for sdma")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 084d8517c194..0cf6bbc8c0ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1432,7 +1432,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  
>  			ret = copy_to_user(out, &meta_info,
>  						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
> -			return 0;
> +			return ret;

Better write that like this:

ret = copy_to_user(...);
return ret ? -EFAULT : 0;

Apart from that looks good to me.

Regards,
Christian.

>  		case AMDGPU_HW_IP_COMPUTE:
>  			ret = amdgpu_userq_metadata_info_compute(adev, info, &meta_info.compute);
>  			if (ret)
> @@ -1440,7 +1440,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  
>  			ret = copy_to_user(out, &meta_info,
>  						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
> -			return 0;
> +			return ret;
>  		case AMDGPU_HW_IP_DMA:
>  			ret = amdgpu_userq_metadata_info_sdma(adev, info, &meta_info.sdma);
>  			if (ret)
> @@ -1448,7 +1448,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>  
>  			ret = copy_to_user(out, &meta_info,
>  						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
> -			return 0;
> +			return ret;
>  		default:
>  			return -EINVAL;
>  		}

