Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8446D5C0C0
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Nov 2024 12:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BB0110E247;
	Fri,  8 Nov 2024 12:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yTziyY6w";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A31910E247
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Nov 2024 12:44:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9NQiIu3x/oQFL2N6h91qzyrB+IkfU9ksgQr7/5qBIVbRf1wNk5fPsoAfW8Hs5F6UDHb7FJbFDU5d+niAshyCHs+XRIjLZNt1UYHdccHDJeK6GU5Bgepqg7tOhxpHDNaqIZdbFB0OPCZGLwAIObWWjaKQKwPJG2YG16RYn2xViu3QeUtfA1EWC8JZE/p+xoWs9wtPtV/ZP95rhudhjUsAAV4dICpsYvgpjBlXM63NO4uMugR7+nwVuY7CXBXH9j/QtArDyVrYDZQgoxh+tXj6IsZIkn36yf+Bq5wE6JJVpGBw1q0iLoz0g56tdpddc2/coSe90l9oBcTwF+M2rI/9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2HKVHp1o2/siwLbQjjc7abatBn298EAoXfLbfg3D9k8=;
 b=Ug9bWS5cZ/AkAh6T/FgHCT7aOmY5SZaIJTjjAQb2QKl4LXhdLgPVJlrcKa4aJLL6buubzclvaFmGnwyr3waaFBeIIQBlhZ79G0UnD2FTrP93lXqPcvnY7ayKjyroV9lJVkzVft5xr0mIcCUqkAZxiQkvlt+aDeuoT4InXGEBECT2LVNI8IjD7cFmA06QZZUh2mUsmY9B3xQbWw/RhlmeSezJhsEwS/suYKi3uN8MAKPKMDa1V8p0gdJXRd13rnTrKtiKreBk1YHtMc+Yr85zaJ+Tvx2iI0O/kQQk7Jo6o0kh43uyqwYsfO7u3ynaPx0/gAt6a0pGI3iUAG6RM71CNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2HKVHp1o2/siwLbQjjc7abatBn298EAoXfLbfg3D9k8=;
 b=yTziyY6wcmS18YfQs2UXmDCl3Fuqrc5fCxUuy0QEbb6cP0U2PY1VvjGZSCW1o/+i7GXiQSsvdxiWRRp5MMV+j9xfg/ZxdmuyiLPkgPUppxQKl54w0PKP9rBO85hiz3ym5TYG+rfyl3CC98f/zN88CL9POCYqMkQiJIuFm/A8qKM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Fri, 8 Nov 2024 12:44:54 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 12:44:53 +0000
Message-ID: <f9cdd809-0f2a-493c-a1b8-a1b6577795ba@amd.com>
Date: Fri, 8 Nov 2024 18:14:47 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/23] drm/amdgpu: add flag to indicate nps mode switch
To: Tao Zhou <tao.zhou1@amd.com>, amd-gfx@lists.freedesktop.org
References: <20241108111423.60169-1-tao.zhou1@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241108111423.60169-1-tao.zhou1@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::20) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: d6048a91-835d-4de2-11db-08dcfff32444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dFpNaGRjQmlaQVJxWGhKSGdpMFQ0NGNFWU1SOUVFTkk4dmVZWjl4dFh1eU5J?=
 =?utf-8?B?NGZlU083K0RuOG1CS1pBQy8va0NWOFRvQTJLS0p6WlRnc1BJNWRhQlJ0VGRh?=
 =?utf-8?B?M1BTaDdCY2dBTUpqeXI0V2p3TUh1QUVZWGhwc0Evbk1hd09JeUpIOStod2VT?=
 =?utf-8?B?UVo1WGhocWw1NDN1QllBbTZMaG1saC9ZcFhRU3NmbkpDWDZuQUNKR1RaMTVr?=
 =?utf-8?B?T05maWJGOG05QlNCaHdibC9BY25TNVpsTXlkZWxER0NpT2ZQTWN3QnVnZUdm?=
 =?utf-8?B?TXpKRHBvbjNKaXl0T0FKaEFSS1g5M21JY1M5UENCWGpqSGRvSFlneWROWjN5?=
 =?utf-8?B?Z2hmMHdhWXFyMHA2SitVNUxNMHJwZEVBU3RnVklYTDVaU2dyMDJRaGt6aWs2?=
 =?utf-8?B?SnJsV3FJQnYyd1FoaVVzcC8vZlRZY2FCc2ZYaUdmSy8yK2RQL3RjUVJ2aGZt?=
 =?utf-8?B?WmNRd2lpdDJNNnBTQzhXTmVGeXh1eXVISSs5WWFBcGIzVjd2NzV4TEdGS0FN?=
 =?utf-8?B?SWJkOXRTVkNXMGcxK3VuL3NXSm4vd2hFRjdHWVJSRzQzRGdXWHY5c1hBL05h?=
 =?utf-8?B?MDIxZWRhT040bFR0R2dTRzdkck9CLzBFMHFFYThjWWJTTUQzQVBTR3hxUUFG?=
 =?utf-8?B?NUdFUmV2UE43Szlpb1VUZ3lhSnVvOHIwREtmNWx3UGtHNnRuSzZMVWFIdW9V?=
 =?utf-8?B?QnhEdHhNYnVoLzNlNTNpaWRTV09FWGhrSFZzQUFUck1UN0Q3VGVCL05WeDJW?=
 =?utf-8?B?RnhLSjUzMkZuSGF6QU9jOVlGU0tmbWFQTHBxSytSQXFXMEk3Mlc4SVArZTFR?=
 =?utf-8?B?cjVkZVNNOUxKZitGRDJGSm9zaGFqYkxPdjR3T3pyd0YzT01UVXdZUTFJeEJn?=
 =?utf-8?B?YzFKcWIvZ205aXkzQWFaRVpuakNFL2t0KzR1bjZzeWJWOEJWNXVFWlV5QXVu?=
 =?utf-8?B?Ylp6Q0FWU0RtY3pnS1QwV0F0OXgrL0dVeStSRkREVExCQ3dJQ0JyNUpldHRu?=
 =?utf-8?B?eGpwQWl4elBIUWFVVWFVNjVBOFVJN1hrSytvTldpbXlkOGdLditYcGVuNzhD?=
 =?utf-8?B?UHNkQlRxYWdvNlpsTVNocVRycGkxOHF3M3g4dXhpOWlzSWo5aTYxc295U1FV?=
 =?utf-8?B?M0l6aXo2Q2ZnVkl5ZUxFYmxlcWZxTmdMd0Eza1BhZk0rakdnTjhWQTZqamJ5?=
 =?utf-8?B?anhRajlGSlV4VHp0ZHUxVGtTcGJrRmpyeHpmNWlEMFZsOHBOcEJ0cHI2WURT?=
 =?utf-8?B?WDQrZXBQa29rcmxZRW1RZGtzSlQ0akNKYUZGQTdCVkF2SXVKTGttdEk4b0Vn?=
 =?utf-8?B?MTBZdnM5M2RPaFpCa2VWaUFrbE5XQzFVcjNDM3hsY1NUV0lSVXFra0dBaGNG?=
 =?utf-8?B?Q0VoNjZUTWNGdjNmdUxJcnZOUmlIZnRJYkxZQS9PVVF3OVgzbW9lNFdRMWhF?=
 =?utf-8?B?VFVIamRpeGJheXZETEJORVNlNmI2SHgreThyV1pBc2h1WmZJdmhrNlpqd0RY?=
 =?utf-8?B?YlMzTkFQcnp1Sy9XTUNEbjl3T255bzVJa2x6bDVqY2NOWEc0L045NmRqdUNQ?=
 =?utf-8?B?aXVKVlNKMFprSWxvbGRSWjZLS3lKMmI0dHZ4U1o1NGo1N2NCZTV5RGZZMXky?=
 =?utf-8?B?T0QrM3haajZyclM4UEt3dkswcFBHVVBLQ0ZUbStnaVVlN0IwS2l4VFlPbmVO?=
 =?utf-8?B?c1NmeXYxMWhVSHkvS0wxUEp3eVJmblBsYXR6TWNodDlLVWh4cWNSNm9XS3g4?=
 =?utf-8?Q?ONpv5031ndTXkARQ74mOMMP62CLF6Ry1cjQNZIk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGZXNGNaNFp2RnZqbVJLYVNwV3E3S0VNbTJ5VEwvc3pWamR2SUUyYnJUTHhH?=
 =?utf-8?B?Zkh2dXRnQ2o5V1QzVHFwemdROCtqMFlqUDYvY3MwNzFqSU1Za0tRQ2RwcmRY?=
 =?utf-8?B?NVR6ZVpQZGJRRTJNa09ITEEyMi83R3ppaVpORW1mTEFlSEIyV1h4SG01MGtE?=
 =?utf-8?B?dVdKMDVEakllclFIUTArd1NRVDZxQmRUL2FhMHF1WE1tSnB5Ti9ySDVHNEpH?=
 =?utf-8?B?MTZkOWV2MDJMRXhLQ0VyaEVWNVBldlRKL2Z2aDZwQXFRaUwzdnZ6YjJZenJK?=
 =?utf-8?B?M1VoM0h3ZWNqTmRuR3dJVVdkWklIVzVFcGJXZ01WM1BLajdJRnZoOVNHTlhz?=
 =?utf-8?B?V1prdy9nUXJqQmRaTFFCckZkR2x2QmJvUjczdjlkRGF0N0FEWUxpdmFWb2ZL?=
 =?utf-8?B?Z1BrY0hwSmMvRzVXTXJuS3hSS1V0NjdQK3ZvcWFoZHJvU1QwRUJ1OHY5Mnlo?=
 =?utf-8?B?UDlINzZLUDFtcjZYNmhma0tFK1R1YmI4SDB3L0FjOEkvNWttOWNUbUFRQkZ6?=
 =?utf-8?B?djRrNEk2c3JmSDFHSGJ2TjkvSjNscTgyZWNCL2hycFE0elFSbzVvbkphcWtn?=
 =?utf-8?B?MkFKY0hqa210N1hnT1k0aWk5TTBuN2lzSWpyTGhiY0ZhVFdTS1NmM0ZQWlhr?=
 =?utf-8?B?WitpbHNXdEo0ZmErMW8xNUh4T29RMzZmL3ZvMjFwODgzV0kvYTBqTWRhcmNG?=
 =?utf-8?B?N01tWlVFajBYYmVoMitUR2tDbVBHMDVweWdJVEIrRWNScStvVVNmd0NtMVFh?=
 =?utf-8?B?dzlvWk9FMWVvMUVLeUVISmtNS2NLNXFvenJFaXA4TEQ1WTBuVDdhMGtUZ1do?=
 =?utf-8?B?WlRldGZWUndQd2JBTTA3S2JHQkkxby9xY1JqcVZoZFprREJUZ2o1VDRKMUI5?=
 =?utf-8?B?TitjTXpURzNIZHg2NU5TTHl6akNLYk8ycWxpUzQ3Syt2Z2EyanB0RE5oeVMy?=
 =?utf-8?B?MlAzT2JWaUFOTTZtRmRMMlN1K0hXb0ZVUUlVcmJuaDFDZWFKVkt2Z1ViakdW?=
 =?utf-8?B?a3hvUkRYQXRwdGd2MURQT1hxNlBncStHK0gxbnBWNmNGZEgxeGFUM3NTNVZV?=
 =?utf-8?B?MnUvSkh2U1ZpYUdkTEVlTTZmanBmYVdnTVBEcFFBMzZmK21lZ1BaQ1VUVklU?=
 =?utf-8?B?cjQzS1dUQnlKNEs1RWo5cWMzb1J5VzJVbTBGclpWM2NHYTF1NWdIUGVxM3Yz?=
 =?utf-8?B?d1hVNDc3RzRkekw0Zml0UnorcEgyNlEzWEltcmpvNTZQblRPQkdVZG9nbUxG?=
 =?utf-8?B?ODd4UTZac1ZjVGt1a2RFZGJQV3dnaDZGR1FsNjYwM3BranhlWEF1YzhVZk84?=
 =?utf-8?B?L1RtTEMva052K0pEd1B4NDBMVjlmb0ZSTzdFeUJPNitrazk2Ymg4cUVxRzBC?=
 =?utf-8?B?c25NajNXcllPaTc5VjdGYUY5bUtya2dMaWRNdm5XSmlROG1HamNxUDJINnpE?=
 =?utf-8?B?R0FhSHVZZ3gyRWJiS0dRWkd5b2hYTzVJQ2YweFpMZWVQcXNQZ3RyN3MxNzM1?=
 =?utf-8?B?L2FRbjc3Y0U4eW5JdTFJamQzSzRKMm1GUlJWZHhxc29Dd3cxRGZ5NmdyRlVM?=
 =?utf-8?B?MEQyR3pZRG1wVEV4Q0pPbHRtaE1QanZjMWlRb0I0RjdNdW9ueGlQeGpaYm0w?=
 =?utf-8?B?VEFnUTQrcWozM3NRMEpHL3lmRzhFaXpnZlNXTG1YUjNjcGNDNnpxR09NVTdW?=
 =?utf-8?B?NEpBV3ExQWhuVkRLUFpQMkp4NXdWaDBqRzBjemFDbHd5bkFQK0JtWVplM1l2?=
 =?utf-8?B?aFhXVUN4SHhuT3pEZ3Bia1BNNUJNRTRWNHR5d2dGempYK1QxN2xHMTlibkw5?=
 =?utf-8?B?VWI3aENScDBMRVR2a1JqTDZUL1ZycEY1NTlEL3RpUlVld3BrcUFPWGQwYlRH?=
 =?utf-8?B?Nk5OdU1BNE9ObUZLbXg0YU0zM0lkSHdRV0RWaGtOa09WTVlzMUtZOWUyNjA1?=
 =?utf-8?B?YnhGUDN4SnIxSURFNWs3MGRPOFUwa2xkNnd4ckNwSDFUeVJQRVZNT1pNZXYy?=
 =?utf-8?B?ZW5XZXJTU1hmOHd0a3QwWCtLaUFDd05IWUF2b3ZISjI1c2ltRVE3bCtKVjhy?=
 =?utf-8?B?Zm52TTRaTTBBL1ZkU3E2cjZncWJoVlEzYTh2dUJhamo4ZHR5cW85WExDTjM3?=
 =?utf-8?Q?XFOQfMgQBvKS4ltlxrRHtFRPP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6048a91-835d-4de2-11db-08dcfff32444
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 12:44:53.3783 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J89v5Jh3wdAtfO5EwI78XBohmZGUg9Apunq0TW74ckEKyH6FfoSkRRFo209LW/X7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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



On 11/8/2024 4:44 PM, Tao Zhou wrote:
> There are two types of gpu reset, nps mode switch and normal
> gpu reset, add a flag to distigush them.
> 

Reset for NPS switch is a subcase of Reset on Initialization scenario
(reset the device before use). If RAS routines need to be taken care for
that in general, this needs to be more generic.

Thanks,
Lijo

> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 +++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c  | 13 ++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h  |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   |  2 +-
>  5 files changed, 23 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 9365b43c0055..ba9b0d322b33 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1681,6 +1681,7 @@ static inline bool amdgpu_is_tmz(struct amdgpu_device *adev)
>  }
>  
>  int amdgpu_in_reset(struct amdgpu_device *adev);
> +int amdgpu_in_nps_switch(struct amdgpu_device *adev);
>  
>  extern const struct attribute_group amdgpu_vram_mgr_attr_group;
>  extern const struct attribute_group amdgpu_gtt_mgr_attr_group;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 286f0fdfcb50..d69fcbb28b0e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5862,7 +5862,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  	/* We need to lock reset domain only once both for XGMI and single device */
>  	tmp_adev = list_first_entry(device_list_handle, struct amdgpu_device,
>  				    reset_list);
> -	amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
> +	amdgpu_device_lock_reset_domain(tmp_adev);
>  
>  	/* block all schedulers and reset given job's ring */
>  	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
> @@ -6343,7 +6343,7 @@ pci_ers_result_t amdgpu_pci_error_detected(struct pci_dev *pdev, pci_channel_sta
>  		 * Locking adev->reset_domain->sem will prevent any external access
>  		 * to GPU during PCI error recovery
>  		 */
> -		amdgpu_device_lock_reset_domain(adev->reset_domain);
> +		amdgpu_device_lock_reset_domain(adev);
>  		amdgpu_device_set_mp1_state(adev);
>  
>  		/*
> @@ -6579,6 +6579,11 @@ int amdgpu_in_reset(struct amdgpu_device *adev)
>  	return atomic_read(&adev->reset_domain->in_gpu_reset);
>  }
>  
> +int amdgpu_in_nps_switch(struct amdgpu_device *adev)
> +{
> +	return atomic_read(&adev->reset_domain->in_nps_switch);
> +}
> +
>  /**
>   * amdgpu_device_halt() - bring hardware to some kind of halt state
>   *
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> index f4c08fa83756..1becf8fbbc71 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -301,15 +301,25 @@ struct amdgpu_reset_domain *amdgpu_reset_create_reset_domain(enum amdgpu_reset_d
>  
>  	INIT_WORK(&reset_domain->clear, amdgpu_reset_domain_cancel_all_work);
>  	atomic_set(&reset_domain->in_gpu_reset, 0);
> +	atomic_set(&reset_domain->in_nps_switch, 0);
>  	atomic_set(&reset_domain->reset_res, 0);
>  	init_rwsem(&reset_domain->sem);
>  
>  	return reset_domain;
>  }
>  
> -void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain)
> +void amdgpu_device_lock_reset_domain(struct amdgpu_device *adev)
>  {
> +	struct amdgpu_reset_domain *reset_domain = adev->reset_domain;
> +
>  	atomic_set(&reset_domain->in_gpu_reset, 1);
> +	/* The life time of in_nps_switch is longer than
> +	 * amdgpu_device_nps_switch_needed
> +	 */
> +	if (adev->nbio.funcs && adev->nbio.funcs->is_nps_switch_requested &&
> +	    adev->nbio.funcs->is_nps_switch_requested(adev))
> +		atomic_set(&reset_domain->in_nps_switch, 1);
> +
>  	down_write(&reset_domain->sem);
>  }
>  
> @@ -317,6 +327,7 @@ void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain)
>  void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain)
>  {
>  	atomic_set(&reset_domain->in_gpu_reset, 0);
> +	atomic_set(&reset_domain->in_nps_switch, 0);
>  	up_write(&reset_domain->sem);
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> index 977b2dd2205a..c74a1f88f0ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
> @@ -97,6 +97,7 @@ struct amdgpu_reset_domain {
>  	enum amdgpu_reset_domain_type type;
>  	struct rw_semaphore sem;
>  	atomic_t in_gpu_reset;
> +	atomic_t in_nps_switch;
>  	atomic_t reset_res;
>  	struct work_struct clear;
>  	bool drain;
> @@ -158,7 +159,7 @@ static inline bool amdgpu_reset_pending(struct amdgpu_reset_domain *domain)
>  	return rwsem_is_contended(&domain->sem);
>  }
>  
> -void amdgpu_device_lock_reset_domain(struct amdgpu_reset_domain *reset_domain);
> +void amdgpu_device_lock_reset_domain(struct amdgpu_device *adev);
>  
>  void amdgpu_device_unlock_reset_domain(struct amdgpu_reset_domain *reset_domain);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index daa69dfb4dca..8387e075c385 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1540,7 +1540,7 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
>  
>  	tmp_adev = list_first_entry(&device_list, struct amdgpu_device,
>  				    reset_list);
> -	amdgpu_device_lock_reset_domain(tmp_adev->reset_domain);
> +	amdgpu_device_lock_reset_domain(tmp_adev);
>  
>  	reset_context.method = AMD_RESET_METHOD_ON_INIT;
>  	reset_context.reset_req_dev = tmp_adev;
