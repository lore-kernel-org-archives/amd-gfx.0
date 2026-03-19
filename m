Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B32B1075276
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Mar 2026 08:44:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CD2610E91A;
	Thu, 19 Mar 2026 08:44:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XTOg7qAH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B5F910E91C
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Mar 2026 08:44:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dryu7/dbSBPv2+8vMK/uEnkxSEKjaHQ9bOj3yiDIwcPAk2dvPh7WqcYkaXjcgyGZ9lGaJQHCE1/ECEthpp8pyiaRi0lbHsP+9XYCTcLCi+QstcuoVzpQUxiCYcLbEAumiGFj5g9fB7uKnLrK43U0lN8JDUZEhp+BCQaVFIZtmCLJyQVVufcoHS9LIKMQjb2Oycx9kaByRNSu34xYPQ7o/hv/7MxVBYa3ml91JYtSbZYqqgm7ZljBrKXXVOYCMBz/8QXSR7k9f+6VUEAZgvQHPAvG9NqMY53lKirEZGP4uQoXVjdmeRrMcdXs6BuwPd880Pn/GIgwn39ZjV44YYzOlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B7YnbkIyG2PEzuxTGqbT+MiNOAmY8ibm+FjlxjLsdKE=;
 b=FrslTcSQWKvH6KlgcgXH6f6XPwe2tglsBlW5x5a6v4EZp4UX5BNZFXmxKhdXk1wsPfcvbdNkv11D0WtS3fRrrTDvb5ou8kTy3zEjPmLtDOazWzJ05j+GGWjlZzswdQM3BLI3euRusIrk7GCRK+YM2fxOfRzrNX4GexcGihflS7xqHCHZMISR+DcdAfP9amyPl9FxisM+yO9iR4Jy6XmloNA+WCQi4ZlDo2POHgw4UozT2FOCEZyrUFmnoB+aMai5ofBj95LDNl2SVWWbpwPzPNuJn4HZy3jCGNUGY66s7FgLVgHic+d6tONbdfJ1eLKUpDqEly4tV3NXB2Ffa+xsiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B7YnbkIyG2PEzuxTGqbT+MiNOAmY8ibm+FjlxjLsdKE=;
 b=XTOg7qAHD9dvQo4500SJBtHM7dm9x+W/vFVz6aysWU5q1WrFQkyn/7D/5U/2m5a7knRsKqwBiy1ykqTHTFiUcTQkTYt+eEQuME/tkE8a0X3aIVbv7+gH34pJbJSL7hW5F44WsG4MZziDs+gM6U6dlV+BvgPKsZlGxncjO8pABvQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BY5PR12MB4146.namprd12.prod.outlook.com (2603:10b6:a03:20d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Thu, 19 Mar
 2026 08:44:13 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 08:44:13 +0000
Message-ID: <0d6ea5d6-5d6d-4a8e-a782-046fdb1b5655@amd.com>
Date: Thu, 19 Mar 2026 09:44:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/amdgpu: fix syncobj leak for amdgpu_gem_va_ioctl()
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260319082150.3324177-1-Prike.Liang@amd.com>
 <20260319082150.3324177-2-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260319082150.3324177-2-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0059.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BY5PR12MB4146:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b77d5e8-371c-4646-879f-08de8593b22d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: ahyT1ZdcmD2d2hjw0YNTn+6juuyVadle0c79ICwlA9rHlBVyHjWVIlu7b4mF/XIJ+RkjgiNYAZAxaH6/wt3NiEoTPqGPnQwtEI1OLOj+ULSiIQE8vu55NMsCYlEdKuCb8HNA89erb2Uv1iNWsq1DTQFDzN7t2MoIuhHcmxpZ33asE65EqCxcB9XGtfF2/37mUXIxKIUYLDNThyd79pvj+bvFsEqyrPJEz8vRpMK3D1shqwz/EWv5POyHg3ISMNTv4RU1Js6wFg7KEl2ZIo5TgCZ+k58QNxGoQQwCLJAZyRJAq4L65am4lgctroGzvXRbBfJVrur986vTgDXvyiMT5+hruo4g/NrbxIk3LPyawz8WXNn0rNL6bdb9uzgK3dRdxJPlcTWW0iuBXnPk+brIZGD6KQ3isR1Rxv2tUFqpSdXp1BbBuAtdJM4vish1WU92QcjPUQ11V7NJAMiGNQXEqgpw2PlyNo8JmzX6H2AJR2GIVlY95WUvd6whWMOB9z568Uoobo34ZNP4lbcdslAlllxPoJt7pLcRy9r5puQK9r40gI9ae7x2QDvgkw5n6+vuDSCK1EYa+eatHDmP4XFUTC654P+dh3hWwNYl2z2ZFqfJdzgMwnAhZVtD/xizndOrDmwR0HGUWEvnLS4GSox++rgCEPe2Z4aKRQzaEJxR0U9o1UJ8EhLoDn/XtrAl3helrDaEnRn58+FYfCYWXBAgIZ+iN08F1CHPD+nRrHyeO5Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3ZvcTRzY2hPSU1xRUZNdWdEeEJmbnA2WHpETVdVNTFhcUFXdTVDbG1ENUhv?=
 =?utf-8?B?MUwwMS91V3BtSGNhMElpMi9WS012SXYyQ2t4RU9Bd3lMVURZU0E5L2J2czd2?=
 =?utf-8?B?TTA5Uzh0WkpJZXR3eXpPT056VTNBTEh6azdhUWY0bmJ2Y0Fza1BWL2VIZE9w?=
 =?utf-8?B?cFAxazRVS2loY2NkYUNzWHNwc3NUZll3b2RjZ2s3dnBCdmlCOGMyOEpiSkNw?=
 =?utf-8?B?TXF0WW90YmNIODV0clBDWHdaMUZlSm5RNUNWZWF3cDJ2cnNGaGNNS2N1Vytw?=
 =?utf-8?B?S09qb2NPSGIxckNWODl0dXM3ZXBidG40czhwYVpuNjhpVFNmK3ZRTDRXY3lH?=
 =?utf-8?B?bTJyU3dDZVZxNjdwcUdLcjhnYzFEdEJjaGpWemNhdEhhQUxSV0lXeFJreXFH?=
 =?utf-8?B?MjlwZ1Exdk53amljZWJLY3IvbE9BcFI5QkQ5WGhpM2JoYjAxaDcrODZyaXI1?=
 =?utf-8?B?UUFvdllwQTIxdlRlWjR4VTl1eUVyeTlGWGNtWmVpTWNnUTlvR2MwZGF0MjVh?=
 =?utf-8?B?aFZ0RW90VHF5em40cFpQYXRINTBjKzFNZDNnTGdvZENTOFBZRTZuSExRekJG?=
 =?utf-8?B?MUUrVGtIc2VhT3RNcnoyQm43NEpvUjRWVFdFQkNWZjNPVUUzMW00aThncHB3?=
 =?utf-8?B?VWlJU09hZW80SWpqRW1abjVhMFdrSk4zWXNiMjBlUkdWWE44dFBrUTFZTDVq?=
 =?utf-8?B?d1ZqNFVsSG1iN3NhOGZEa3BnazJzbEFmcDUvbW0yMTlpNXZMenZhaTlTZFZs?=
 =?utf-8?B?Q2hmMmpYV0ZCUFhQaE4yUGhNWE16czY5WFBnelNremkzaUNlQU01WXZZV3dK?=
 =?utf-8?B?ZjB2R1VOMjdzanM0Nkd2TG8xVk4zcTA4SE41cjFxTTNyazYvVzAreEY5M1Nh?=
 =?utf-8?B?UC9XeTZDRmJvVVFhV09UUUNvSm1BYjNKZ21sMjlnOVpsUEJrTVdOYUNvRGpS?=
 =?utf-8?B?ME1tM2VsdnBMTTBjR3F4UTBkZEV3SHlTRE9NRFpsMERNWENUb2lEVTJ2Vkl6?=
 =?utf-8?B?eTYyMTRrdHFZelcrVmRUREVhbHQwaktWeVZOUmNjWmdkZExnQVJVNndzZS9F?=
 =?utf-8?B?SlpSeWxTTmdseFpIeTVLUUtuSDFqMG8zQ1dKZ3daK2JLUG40QTkwbWN3UExz?=
 =?utf-8?B?MFBMamlTYWlIMGFpV0ZqSW56cUJ2ZkJ6WFY2MGh5bXI3aDNnZWJ1OU04d0hH?=
 =?utf-8?B?OTdMSG40aldOMnFvUWtia1hzT25ZQStWMHpEU3paczM1ZHRFZExsYkJrM3lq?=
 =?utf-8?B?TDkzbktHbm1mVnZOS2F4MStWQ2hqNThwdzFPZ3pmN3o3bGpYbUdpU2tjb1Ur?=
 =?utf-8?B?N3NDZ05jNkRqSHgrekphdThWdWorZzg4bWFzU01aL3JheTc1bE0wUzNhNmx5?=
 =?utf-8?B?QWwwUFZmYldMMmlpcXpZSG1NRjRlTldySzlmRXl0STR6ekVGT2FHcHIvcEZt?=
 =?utf-8?B?aGhmQ0Rkak1CMHNlUUFPTEQ2aUdEdGZGTUVSYm5qUnJNUHdrczhKQ2NYZ09y?=
 =?utf-8?B?UmVsV3Q3ZTEvSGJjQzZ1cHN2L3ZxcEI2NmtSOTVxeDZqbHZhYkZ6ZTMrM0g0?=
 =?utf-8?B?ai8vQ1hrZXloaUVsMFNtTUdyYzV6Njc3dVcwVXNPTk1acWhvZ0R1bm1OYlpH?=
 =?utf-8?B?YVlrRzJRRzBhS1puS0tnVzZnUzNvRVV5WFdua3lQUmtxb200SEF1eGxsSjBj?=
 =?utf-8?B?ZXRBR1NEVXZOMEhqN0pLUmlURnI2bnprOTJJclNTY0x2ek1IaXAyK0hXelpI?=
 =?utf-8?B?SmhVcmJHdVdVeDJlek5ONE5xd2NEM2hndmVkVWdEM09oV3RTeVd2WGJZamkv?=
 =?utf-8?B?OFNya2NwVHZGQnlrZEVUV0hqZy94MXhOcG5HWEcwMjNSSFNlMys0NWxKNFNq?=
 =?utf-8?B?VC9kMUVOMVJiVkxGSGtmVis3c3BUdktUUGtoay9YMElTOVQzYndHZ091ODV0?=
 =?utf-8?B?eEJyUEdPVXhtRFNuUUkwVFN5elVOTFpaeURJWFVBam1rN1hNc3Z3SGkrV2Er?=
 =?utf-8?B?YlV4WCtzd0VzbzVucC96WWZyZFRyV2F0b1pCYzFPckZRQ3ZvZ2JqK2N1NUEr?=
 =?utf-8?B?WXgrSEN6a3U5QXBzSHRuTlNwSU9McFNhamE1WHB6YlJic1B5MzlzTUpTSHlK?=
 =?utf-8?B?SFJBbURDdGJNTGtJWTl1VHlTSEtNR1pFdGZPU2JpSDZqMlNjd2pHOStrMVRX?=
 =?utf-8?B?N2tRcERYaUdjYzBzWXZEbExmT0FnQjIzdXNFeGNmaWIzR2JRSHV2RlpsM2VI?=
 =?utf-8?B?dmFBeUVjMzFnL2tYOE13V3IxdjgwUDJqRktrUEpoZjExOVRKclNsZDZvbU9F?=
 =?utf-8?Q?43xV72KvnvFKNX4z+d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b77d5e8-371c-4646-879f-08de8593b22d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 08:44:13.1871 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kY3rZgHQpiMS3hWC2sjiu9V5sqXGBCwUYEhlAl/qdnQ/OA1ActQbmX4hyEV+uIy6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4146
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

On 3/19/26 09:21, Prike Liang wrote:
> It requires freeing the syncobj and chain
> alloction resource.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 98276b55ad3c..f54e0fb5cb2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -980,6 +980,7 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  						      timeline_chain,
>  						      fence,
>  						      args->vm_timeline_point);
> +				timeline_chain = NULL;
>  			}
>  		}
>  		dma_fence_put(fence);
> @@ -987,6 +988,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  	}
>  
>  error:
> +	dma_fence_chain_free(timeline_chain);
> +	drm_syncobj_put(timeline_syncobj);
>  	drm_exec_fini(&exec);
>  error_put_gobj:
>  	drm_gem_object_put(gobj);

