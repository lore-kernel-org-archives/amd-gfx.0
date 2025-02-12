Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F64C02198
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 07:50:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F6E710E261;
	Wed, 12 Feb 2025 07:50:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wzoe1bV7";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A631E10E261
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 07:50:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljtOmncuEuo2xy4g8ODIhLqL+pIZyL3itO4/s0/zj+TM1Im4GM2FUjJRbE26bH9h56NXU3ofI7lt3eVQjD/wFKBU0K9pDD9Yqqya1h61h/SgCvlRmV8xdY/4oHiSKoNs6AVqwWTkvFWfEXd7vCzEk7PI3vuOVyHdxfdaQDEpK94B3PqIQrfmiS1n6YlHN4jtAMt3QW4mkJjxZyeupJ49WtJjf/MdXVIBwfwGvulDEZmzzLYAGPs2XM3/lRM7hamwIj4x60ur7HHKqqRPKhAcfFRP77WLMo9VnA6FtBJlCLc4HepLEnIdQvCnMRs/5wSOOaCP6bm7yrplZW1qMRigNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fXd9FV81Cm4y8ArfFSlxfn8cy7EDGz1btZ16OEQe3CY=;
 b=qgzdViQ5YjeKIAoI1EDgQn6ylHq+0UpbyiOBHyizepdb5KhAhhTkxrvpoxu6DiaFEuj57RZ1+gvp+kZ9ZflJZhXR9OcXnY9Qd+Wde1SQci8b5R5cLCLErQzzIHJoOpYj6huOqL9JMUPmu6EVnq0TsXrYzyaKEVex/M7bt7IcooTsrn8RckRn7LxSoCbgAeDDaY9+/CtIshKV3vyBGQ54llW6lxRxDxTt5nNr1DrqAMTZEjv/IqQxbt4g0BEcA2XHxtR4JvyWMx9YjpzLwjP7H2e6pho6fNh2cguP/uX0rsB5elspXPvItJcvyVnRprFTnZA+o3nAhsX82vSEN3IBOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fXd9FV81Cm4y8ArfFSlxfn8cy7EDGz1btZ16OEQe3CY=;
 b=wzoe1bV7VK4Ja8GSjsD799A6/4bxZZhS8E33jjdpdN9KLYRUDAeAzPqy5CfS4dTEga2+2iXdNlGAd+vQJmq0WenLlxoS1oEtBbLhc9LnM3ZzceqZMpuDx7+ioD2OJGP296UjBvx3cMh7Cv9Crc1ZCxlHLE5DHIzqj7di1C29nzw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 DS7PR12MB5888.namprd12.prod.outlook.com (2603:10b6:8:7b::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.19; Wed, 12 Feb 2025 07:50:30 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%5]) with mapi id 15.20.8422.015; Wed, 12 Feb 2025
 07:50:30 +0000
Message-ID: <c4179129-6815-4c37-8c5c-d6c8fde1d30b@amd.com>
Date: Wed, 12 Feb 2025 13:20:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu/pm: store power state per instance
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Boyuan Zhang <boyuan.zhang@amd.com>
References: <20250210233132.583035-1-alexander.deucher@amd.com>
 <20250210233132.583035-3-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20250210233132.583035-3-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0233.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::12) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|DS7PR12MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: c940e6f8-f0fc-4aae-ea36-08dd4b39ebe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZWhNaTFtNHVqZm44ZzRQWXhBb0tTN0YyWUpaeVBobytrMFlTMG9YU3NtdzR1?=
 =?utf-8?B?RjFaRTA5bGRtYXlyZ1VvbCsxYjErT1dUZk05Ylk5NFB3TEh6a1d5OWJZRDZX?=
 =?utf-8?B?amllUk5hVkEzZ3RhWGF5eE13Z29vaTA4RTExb0Vob0tRZFA3czdFMGRQbEs5?=
 =?utf-8?B?ZkVUWSsyUTA5TStEMXFkUENKSDUxbnNPMFpTWG5LZUtQNVVYTWFIV0wzMmVy?=
 =?utf-8?B?NlpYd3V4NkhqZ29rR1UweWhQRk5neGR3L3ZpR0IvUHVNUmdxNGxGTkVjT3Zs?=
 =?utf-8?B?VDdJU1hZWEJhNHV0TU16dTdORGJoRFkxY0JROURteDdhQmZvakJMOUFLUmNI?=
 =?utf-8?B?Z2hYNFh6RHRjb1BSdXVMZDJROURjRU5qQ0hwQUM5cHhuY2VKRWt4dXFwWjhJ?=
 =?utf-8?B?b08vdjNVTEMyNW1vVnV2Q0EzSTFKaFVvQndKbmdEY2tjb0JEM3c1b0RuN3B0?=
 =?utf-8?B?MUVMN0tKenhUcmFrejZscFdLUWtQamlILzBqdTVZc0Z2b1cvMEVTbml4dUhn?=
 =?utf-8?B?cDNhazdjSTh5V1o4Z3YvUmZwbHFWUG9yU3NVUnVKMkhvZjRZdEdNZHZTVlZj?=
 =?utf-8?B?djJicWcrblM5S0ZIM1lTRnIzVFVhSnAxOFpnMmNVZmttcjgrbDhLRVNIYjV6?=
 =?utf-8?B?RWd3UFNadldzT2JGeFBhbndXQjBSaURFN08wRUdKcUZWTGtRVnNOUVltYVJU?=
 =?utf-8?B?Y2U3TUZ1WHdxY0M4RXpyano3MFhQZ1h6cjFwMitYUU1vRmxoNFg1NTd5Wmc5?=
 =?utf-8?B?K1pqajY2N21XQ3dNMG1BTjVBdEoremdhOGNiOW9Xb2NBbmJRMzdSLzh6bWlV?=
 =?utf-8?B?OU9NeEFxem1tOU54MHJZQ0daWjdONEZzeVB1NnFCelpwRWpjTkNydEJSUTdn?=
 =?utf-8?B?cUdqZmEwRzl4SEVIREdkQ3VQM2NvanBXMThFekpjdkU4UE45dzA4RDNRN1RC?=
 =?utf-8?B?N1dHWlJWWWxtUENjWmhXYm5tTk5uaE8xWE1SVlJnQUkyM0FvYURhUjl4Skla?=
 =?utf-8?B?dmdqZ1hnOU54NzI4U1poTnhadUYvaW5mS0ZoNW1VVUx0VE1ieE5XUnUyZG9Y?=
 =?utf-8?B?cmozQjA1a01iVUZERnFzT2NiRFMyckV2dVVKb0NFKy9NaXhyOGc0WnVqVXZh?=
 =?utf-8?B?Tnp2eTcvS3JkVGlGeENFTzdqcGJaeUkvRkNQVU9wUEliVzRSOVhkV0lXS0Qv?=
 =?utf-8?B?MTlQNzMyVHJMb1RlbGR2QUJsOS9uT2lsS1ZsdjZWZnM2TytlS0lRaXdqcTZi?=
 =?utf-8?B?RVcxc0ZFVFhDeEtuY1J1UEQzdkpvUnlSMFVONEk3MVVQS2QvdkNkcXg5RkN0?=
 =?utf-8?B?NmY4blBIUjVJR3VvMGJaSytKYTQxNUpYeGJFMU5yL0NLUThkVHhHK3B4VDFZ?=
 =?utf-8?B?RTdxTUdxc2NBWW12YmtoRWJKejhWSmRXUS95RUxrM0pUWUFTY1VJWEVtb2Y1?=
 =?utf-8?B?SjVpSmg5LzBDdkZiQm5VYkwzQkpLdzFYNVg4THV5NlpheUxlYW1FL09FL2ZD?=
 =?utf-8?B?OGU3VDArcytlaTlxZ3BjRzFmaitvWmNvaUR5RnVMM2o4WVR3bzVaQUdIdDc1?=
 =?utf-8?B?aEtseGNNdS9iMFhHNWw4ejVpazBnUnZSdEs0VWVKNjdmNzRtYmpKelVPOGtC?=
 =?utf-8?B?ZFc1NWJnUGc2eVJBSEVuaXdYTkd0UDRCVi9FcHFkYXoyVUtFamRvNVlaWWt6?=
 =?utf-8?B?OVNtRmFmcm80Wm1lOUY2NUtTUlAySUhxUUpxV1lQa2NQZWtoaitJRitOQUZP?=
 =?utf-8?B?U3oyejRtbndmRlcreVMyWDNRNlBzcXc3SThndit4SXFWdzFiaWVFWXYyNEhl?=
 =?utf-8?B?M3BXZmZQSGlZaTdxYUY5Qnd1Qk9HZjc0MVhDZXF0cFhuYmRtckR6ZGdneURS?=
 =?utf-8?Q?tcVdRnO5Vs5ZK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlZtS1hucUE0Y3pjajhPcmRwRW05RTNIeUFZZmJxNWRxdnpob2NydUdzZFAr?=
 =?utf-8?B?d3RWTld3Q2E3ZmUybDFlcEV6UmszWHQ2c2g4VW0xcmh4a3FhZ2VHRXIzbkky?=
 =?utf-8?B?TDVhdXZubnEwUERIaFJxdXoyWXExclFnbWtDYUQyelVvYU1uSGJTYld0NHMw?=
 =?utf-8?B?cTNGRHg1dEYrVXZrYmxOWjdvc1owTG45R0tJZ3Q4VkVNMzd5WVJhRjJwWGxj?=
 =?utf-8?B?VzlLRWdteVRFY2pYNmkrVHBnTVBvVmZmbEk0T1RkaXNBUTRrTDNnbGtwREVF?=
 =?utf-8?B?bWNwRHowWUZBOEViM2NrTk5BWDg1R3F6QVRnRnlUMGtxQzBhME14OVBhb3J0?=
 =?utf-8?B?SHJ4SFVQOW8zekgyRjNpUGxjeG9xRHF1d3dFZjRWR3p1M2s1K1J5MGUwcCtK?=
 =?utf-8?B?ejcyMFhuRnNPUHZWcGlmTWJNVW8zSlBReCtVblVuQm1YM1FIRUdIcVVqdERM?=
 =?utf-8?B?ZEJXSlp2UVBYbDZ5TVZTUmlZbVNldVBnWmRLcUhueFZuOWFHWU4xTnlETzA5?=
 =?utf-8?B?RXdqaEVhUW95RHNmcWt3MW5zTlQ1cU15UGhOOUN5TjExQ0Y1eGdPaU94aGZw?=
 =?utf-8?B?eWtxUTlzaXVNUFd2eXR3VE5XQWUvam9BZUczUGhCcmJvUEZXQUZZUXNLOUJl?=
 =?utf-8?B?NWhqSnVPZUgvQ2tlRWxsSUN3aEdtY0lIOERrc3ptRlZldlh6Tk1wcjMzUE11?=
 =?utf-8?B?ZVVCM2ttMmxjRmtBc09NcU9FRCtMbldwclE3cnNDMXcxRHRwOTQ5Rm1XUUtz?=
 =?utf-8?B?VE44eWVyUFJ6a2hhWXZkVlNSVnRKRFJNRGlxMzF5QlU5NVd6dVBIS0phM2Yr?=
 =?utf-8?B?VkZUOFB3UEdaMHBxMlZ5U2h0aEdESHZHZk0zN1QyZlNPVXpkcGswek5URTR4?=
 =?utf-8?B?YndpVEtDK0lsdkNUWmdlTWNQM3lIUGpxOUxxY0p4MkNLUlo2c1MwM3NVWnBH?=
 =?utf-8?B?S082VlRRZVRwZjI2MVRVckdXR3VFMk82SVk3czhHWE1RemhNenBYZDRwNWV1?=
 =?utf-8?B?L1RMU0QxQmxsY1RZMFp6Q0NVVE5Rd2g2eVQ5dzdqNHQzOUZzRVdSVGVhYnkx?=
 =?utf-8?B?QnF1UjJ6NGh1YTFQdDVPOEhqUFpFNFFpV2k1M0g4MGptdTl6ZVA1R01qeTZS?=
 =?utf-8?B?dTZXRmJwaHBEUERmaUZaTE0ybklncTU5aEMzS0lLeWllM3ZIT25OREdVaVFv?=
 =?utf-8?B?anhZcWJtMWpzRFNPM0dWc0dQWnV5VVcxSTVDQmtMTHNrNm1JME9nOFpISnZY?=
 =?utf-8?B?SkQ2TDhtVEVZRmJnYWtpM0pXUHdYR01GVVhCcGRCWUdkTWlQOVFDWmZ1S1Jz?=
 =?utf-8?B?cGJCdEtoZVpOMU5aZzJXZzlLYnE3RGhweUE5eHQ3VE9pd1RYSHhvRFRpQTFJ?=
 =?utf-8?B?NzdQMis0YmQyU3dqclZ6Tzl0ZWtRSFh2SnBHbElWV0hCakxxbjFuWTVQbzhF?=
 =?utf-8?B?LzdXZFVORzBDMldpdWhEQ0R2ZDU2NVNqNFM3U2UxVnVXNzJmOXdYMzFJVWY4?=
 =?utf-8?B?NmdSbW9QTTZTeit5SlBsemhFcWN4b2hvbTAyMkZNaktBMU1MNkJ4MnIzN1po?=
 =?utf-8?B?OElTL3gvNUVzWjM4ZjZXOEJtY1VxVWhqVkF3YnhZVCtXU2FsRTdvNWpia05X?=
 =?utf-8?B?eFozMytGYUZGc1I1UWJjQVg5VGxGc2RaUmwyOExxdENWWUNBT0EwZ2NGYnBU?=
 =?utf-8?B?cVNaVUxBdjlSN29iMVkzeGw0dlUxditSYXRGWjhLMmd4QVpDV280T0tERk5i?=
 =?utf-8?B?MURJQmE3aTVrTmFjRlovUVA0OURCdE1UUzlxSEk1ZzJGTDd3R1JzUVlIcTlD?=
 =?utf-8?B?NHBHM2VNTmV4d21EcW1wOXhHOVcvVFUzc1JPVkRGSUFqWS9FV3MvOVB1azZM?=
 =?utf-8?B?TWFrcGpCa2FnUGtRaG1GMWUvaURZSTJEU1NVaGFkaWR2VG9Tdk9nc2NKYUtx?=
 =?utf-8?B?Q3VFb1oweGRJaTQ1aS9Ld1REVlptSzNxSE5SR0RMRGkyS0orTHAxZG53Wjk2?=
 =?utf-8?B?Zk00K3ZaOERpa1hoS0hXY2RYRnJsNm9WSFJ0UUZYM1p3Z09oc1hXL2lDMjM2?=
 =?utf-8?B?QTFYQkpraURBZ2RrSzJUbnhHTnpDZUNWeWxYRDYvYzNQWnA2SU9JOFlFVU8w?=
 =?utf-8?Q?+gUL+A2YmTZlLdJoJWgViempd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c940e6f8-f0fc-4aae-ea36-08dd4b39ebe9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2025 07:50:30.2842 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cF6RNpV+coV8smOSKedF2RRcHOw8pZnmJhENqy/PyucMXROFTuJ+K+r+hj0/DdQw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5888
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



On 2/11/2025 5:01 AM, Alex Deucher wrote:
> Simplify the driver logic.  We support multiple instances
> now so reflect that in the driver state.
> 
> Fixes: ff69bba05f08 ("drm/amd/pm: add inst to dpm_set_powergating_by_smu")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Boyuan Zhang <boyuan.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  9 ++++++---
>  drivers/gpu/drm/amd/include/amd_shared.h   |  2 ++
>  drivers/gpu/drm/amd/pm/amdgpu_dpm.c        | 16 ++++++++++------
>  drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h    |  2 +-
>  4 files changed, 19 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 32926458d50ce..7325c21d60fc8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4184,7 +4184,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  {
>  	struct drm_device *ddev = adev_to_drm(adev);
>  	struct pci_dev *pdev = adev->pdev;
> -	int r, i;
> +	int r, i, j;
>  	bool px = false;
>  	u32 max_MBps;
>  	int tmp;
> @@ -4338,8 +4338,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		adev->rmmio_size = pci_resource_len(adev->pdev, 2);
>  	}
>  
> -	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++)
> -		atomic_set(&adev->pm.pwr_state[i], POWER_STATE_UNKNOWN);
> +	for (i = 0; i < AMD_IP_BLOCK_TYPE_NUM; i++) {
> +		for (j = 0; j < AMD_IP_BLOCK_MAX_INST; j++) {
> +			atomic_set(&adev->pm.pwr_state[i][j], POWER_STATE_UNKNOWN);
> +		}
> +	}
>  
>  	adev->rmmio = ioremap(adev->rmmio_base, adev->rmmio_size);
>  	if (!adev->rmmio)
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index 6dccee403a3d1..5dee173485c9f 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -112,6 +112,8 @@ enum amd_ip_block_type {
>  	AMD_IP_BLOCK_TYPE_NUM,
>  };
>  
> +#define AMD_IP_BLOCK_MAX_INST 8
> +
>  enum amd_clockgating_state {
>  	AMD_CG_STATE_GATE = 0,
>  	AMD_CG_STATE_UNGATE,
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> index 7a22aef6e59c3..d2f1b27d22d4f 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
> @@ -78,12 +78,16 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>  	int ret = 0;
>  	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
>  	enum ip_power_state pwr_state = gate ? POWER_STATE_OFF : POWER_STATE_ON;
> -	bool is_vcn = block_type == AMD_IP_BLOCK_TYPE_VCN;
>  
> -	if (atomic_read(&adev->pm.pwr_state[block_type]) == pwr_state &&
> -			(!is_vcn || adev->vcn.num_vcn_inst == 1)) {
> -		dev_dbg(adev->dev, "IP block%d already in the target %s state!",
> -				block_type, gate ? "gate" : "ungate");
> +	if (inst >= AMD_IP_BLOCK_MAX_INST) {
> +		dev_err(adev->dev, "IP block %d inst %d invalid!",
> +			block_type, inst);
> +		return -EINVAL;
> +	}
> +
> +	if (atomic_read(&adev->pm.pwr_state[block_type][inst]) == pwr_state) {
> +		dev_dbg(adev->dev, "IP block %d inst %d already in the target %s state!",
> +			block_type, inst, gate ? "gate" : "ungate");
>  		return 0;
>  	}
>  
> @@ -112,7 +116,7 @@ int amdgpu_dpm_set_powergating_by_smu(struct amdgpu_device *adev,
>  	}
>  
>  	if (!ret)
> -		atomic_set(&adev->pm.pwr_state[block_type], pwr_state);
> +		atomic_set(&adev->pm.pwr_state[block_type][inst], pwr_state);
>  
>  	mutex_unlock(&adev->pm.mutex);
>  
> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> index 1f5ac7e0230d2..cbb110f0cb898 100644
> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
> @@ -370,7 +370,7 @@ struct amdgpu_pm {
>  	struct i2c_adapter     *fru_eeprom_i2c_bus;
>  	struct list_head	pm_attr_list;
>  
> -	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM];
> +	atomic_t		pwr_state[AMD_IP_BLOCK_TYPE_NUM][AMD_IP_BLOCK_MAX_INST];

If it's getting refactored, it's better to keep this state in IP block
than in pm.

Thanks,
Lijo

>  
>  	/*
>  	 * 0 = disabled (default), otherwise enable corresponding debug mode

