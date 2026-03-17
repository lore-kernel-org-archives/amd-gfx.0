Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 530CBF33805
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 07:04:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECD110E342;
	Tue, 17 Mar 2026 07:04:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gOTMaHwe";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94A8B10E342
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 07:04:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LlnE2hcyFo/yU90VhHHigIrSIhWCpoPDCj37kWZ42Tz6QnrA2Sz8Oe4bpZoUcUoGIHNUy8tILHohZA1iCn2JGJF5CdkXisSPWvO16tNFa6M83o5htf9V8yexbjU4JOOZABY8b9WB/4giWVaO5p7chooh3C//h7bXYk37jX8H3bEi003ZRwbb311XUsizBuUAFkpY2unFemuCo6ZwnxqYKD/Z4aGABg6JBh6ZhGt3akOHvt+9BMzqaF5pm7N9v5nw8Dd2Y8eIkCfh9NX3UaKET2UmV6Jlye8crxDseYiu3iedph6aUG1n+cA+KRAc7mpdeFgBsQ/VWqfHjZ/aD7VG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pEIvrcu+IvP2JfsAWr2Scb7R0zti2vVdEuw5lP/06Fw=;
 b=lH5AeVGiMo0M++MLJ34K2idBw18Kiyewxa7/PRKeBRRe7WNjrZIhLKGiyzL1Dghoxhb0Yi7ImoEf7bpQHWz96HHOZ3Qc+2izaEY3Fx44jS4D3etB9q0UwsPGF5U+79GTXO/ANza/XVAliUbvqGxXRUuNbHkGJTnncWgYAsubOBXv2N3iWFvSgICqwiJGgHZYdm4QKK4RioKWSCIhen2kK5Dx3XzE+4/hZJHoOFuaAqF/RqSeoTVKb46/O36G91DV0tvl7FusRyl6zBlj9ssALiahj08kfK0jt1uUhXpkXvhOB3+wBvA7QL5r/GULRsXcZlWzUkjQIKwd9c8UT/RgbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pEIvrcu+IvP2JfsAWr2Scb7R0zti2vVdEuw5lP/06Fw=;
 b=gOTMaHwev35BAk72xbvttlnbLHR7LGthX92n5fABWLKTbD5h9GxLfG9+D/x8StRF+LKNSInyM7biBg8+2JgMgJQ8wjEY81ugJ6Hm2XI63/e2UHFSzLqYoyvMrQbbbm9hd51a5P0kpIqh07HTL6vBaL9ab5li4uUwwdZfVOMobtk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Tue, 17 Mar
 2026 07:04:05 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 07:04:05 +0000
Message-ID: <8b04fd23-5451-4738-b75c-d5cce000ef73@amd.com>
Date: Tue, 17 Mar 2026 08:04:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/amdgpu: validate fence_count in wait_fences ioctl
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Vitaly Prosyak <vitaly.prosyak@amd.com>
References: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260317011713.1812421-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: d7566226-751e-4690-284f-08de83f36092
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: eWtRI74USMECVxlIXYj9267cxKQMb+DIbaL/WgZ+PfmCuJpVylnNTpqkgdIhJlMjOyPUheSFM29kc04c+rSAEFjiYYUbMBPculD3ckY/nkHXbolbxY6zD7i4VwMrDL7c2vd5HYWytkEk7U/mblNUvtTh1GjgLHxPtiGOemhfQ74gG//mjNxQ6NzlPKS2soxYIec2N9xjwU6NlXBtUUt19o6IEBn4wrrfx0wC1IiShtl17WGu3M5sS6Mi8lhcWJ7gC/Wtyr9Z9038T/M8oNuU5e4Eio1DHt+zJgr4O0riF00hHGfmnXljzhej2snkbowH0VazwGYCHYRMxZKIhqj/9y3BzsGqk3KviKuhxkP5irMsjQOmOekqChUSPLuA47w54yjlDgrR6Cn7mw5ZLmVs/uWiNNE5YyOMJ3zmVmPXIWGB7WMpUZmORBxALoSyXNR3j2XczhImeIpRNI4wAsXn79srCO2T6e8lRN1OC+a4IIWifEYbOCwT6m4xDjozcKy9bek99EMYwTO0BVFKO/S2pgLOWNiYTGEiirFLQ1d8BIXqFZ9VNzG9dgtJlEXUj2VKD90FVGS5CbChsuJ5fHWDogdIMzrCi1/EJDUHbFoeRc8aBPH6gf6TveFSbHwkR8k80DNVwJkx+KdYpvNbmamzNNmBz/b+Yv77l2K966Ce99un7k/grObGlvNmDLj5540VCDsTZ1GYz8NLnCSb3CpGfQGQu23KQHmPI6XPEWkwblM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGVoY1o4bVdhdnBVL3Z5OGxWVkpESllqRC9oT2x1anErbU01VVA2M0c4S0dk?=
 =?utf-8?B?UVVucTBOU2U4ZGVkRmJxZitxc3BwVnVMdWlUOERuZVRnS1puQi84N2JFQXhQ?=
 =?utf-8?B?NGQ2UDBhSEF3dVVFNXU4TDhnRjZHSkx0dTRDMkdnS0Z2RkRWZ2M1TFkvWUFv?=
 =?utf-8?B?MXBYUXlYUklpRE51Zll3VnF3cTlPdUdrL08yK2RpSm5nWmI0OXVFMXF6bllW?=
 =?utf-8?B?VFlzVkx0ellZelFEZGlYY2lzQ3hXMWZpLytTWTV6M2FsZjBHTmwrcG44VEJE?=
 =?utf-8?B?WTR3QUN6WTNSOGx1b0xROERleGtrbHNVS0pWcGpBbUMzVGZWY1g4V284TlhD?=
 =?utf-8?B?N3JKYU1WdHErcWkvbStIS292c0hBNUVleDg1MUxScmJSTVVDdVdNc0NDUW1P?=
 =?utf-8?B?bTI0K09JU3pQempQQkxQVW9WM2JTT3BNbHRYd2NNNi9KK05aUHcvN0pxNmlO?=
 =?utf-8?B?dW05Q0d1MTYzNmQwblVWZXhHNzNiVWhBVFJsOWVvYzdXVFBGUkh5NVYwZlla?=
 =?utf-8?B?THNudnVGZFZPY2pjb1gvbThsMjR2VDVIS3dnWm1yOExQNzlab0U2WlBlVDZW?=
 =?utf-8?B?UGhqdEFVMklmTEtLK0gyZy81czNWaVE3aWxTbDNYb1JLTXhES1A0KzRTNzdo?=
 =?utf-8?B?SmVkczI2QWdGd1V2MytSQWpqNmp0b3BxZHhDdTVDSDRGdEtjUmlNSGFWZkhy?=
 =?utf-8?B?QzdOQ25nVlp5R3VUVTRVZ0tBZzJEKzRHYTZCOUtiTXdISTFKWGl3OGFMMFVh?=
 =?utf-8?B?bU1lTVVZdVhlaEJEWjlHTjY0ZFVGbHBaUWVzVlR5UWdVZktKQWJkRGxYdmJj?=
 =?utf-8?B?bnR3S1dpZTBRd1gvNS9KZ2R2andFdWptUCsrdDNXMlFZemFnelJqcDdSdzhF?=
 =?utf-8?B?djF6aWs4bGdLNTM4eUFKcWpMV0VLSjduS3dwMVhkWHNvV0RXSTF2L3lqcFdz?=
 =?utf-8?B?TmhYUUFUUUR6eUgrY2tiWnkwT3hHc282dHFVYndiN1FSUzRMSDU4ZkNJNHYr?=
 =?utf-8?B?RkxPWlhrS0VqcXVnaUkyeDJtTytBdmxqWExxWDRpTXFDQy9GRHpTU0J1WUlV?=
 =?utf-8?B?ZHhiZWVHWXFmeHBBaFBCdnpNNjBrM2g1amJJYVJMSWh4UDFOYm5kUFpnenRy?=
 =?utf-8?B?NEpYM1hkNEtoZkl4TDhYVEsvTXB2ODBlQ08rekY2YTJIWDNFcVdwKys3QWlC?=
 =?utf-8?B?V2VEalFLcW1oQTFkQWNaMzF3cG5oM2VqTElRSUM3UjF2NHNKVEhHZXIvL2cv?=
 =?utf-8?B?NFFFbzcrZlJKckRuK0huZHRzek5RYVZwbXNZaE5GUGdwSm5LcHFUWkYybVRZ?=
 =?utf-8?B?ay9qMGNQdFdBZk52UDhaRUdORnJ2VGV1QjZmY0loR2dhc0RWcmR1dGRRTENy?=
 =?utf-8?B?Nm5IZnNWYzBqUDlRdGpiZzYrOHJjWHhmVjlTbmY5dElHVlJIOFJNUkFoSFdz?=
 =?utf-8?B?S05acytDSnpMRlViR1Y5Yy8xTmZGVjU2Q1hVNndYaVAwbGNJdVRQU2sxREJ2?=
 =?utf-8?B?am5WbTZ4WE5IRTZlOEdmeGlWSUNidGJpN0RBbDZoTktjM1Nvbkl0eTEwT2sw?=
 =?utf-8?B?K0ZGMXVvVDJ1OWRWZTA0OEVNbVJsVmJNY1J3SGlETTdIdm5uZnZlN2FDT3Fq?=
 =?utf-8?B?Wmh3MUpsa0pYQldNZ0NWVndrZWtKRjhMWHpGV1d5WnRzZEtOcDB5bkFLKzN2?=
 =?utf-8?B?RE43emNxYjljNkZHWStRZTIxRmQ2RlY5aUpoaHRtajF4blVmTzBOQndzN3RE?=
 =?utf-8?B?cTdqMXNNbWZaRG1SMXJmU0pZNmtNYUY5QUxGN3ltV0V0eGt5Q3g3WWhybDNB?=
 =?utf-8?B?blM0MUhHOVRtNEg4ZTdiUis3MWJ4cGxkaTc4L0hkRTB1ZlR6ZTNQWkVWVnpT?=
 =?utf-8?B?ZGhCV2x2RUx3cDd5Zm51V3ppRVdhOWhidVhhT1hacnh2MU5aQk5FWlI1Ym9o?=
 =?utf-8?B?ckk2WDJZcTFhSUxvcEJTWHRVcVNCSHpEWGFRZnBFK2tVSTZYanYrTjk3ZFRs?=
 =?utf-8?B?MEJZcjdhQ2xYL0NQazBEYzJLVmxaM0MrRzI2U3NQMGtXS1Bhc1JUdm1uT2lq?=
 =?utf-8?B?NVhGWmNFMzFDbzRTY3lhMjFSZ1U5cFJNdXh2UFJFNDBBZmVlZW1qVjlHUnBr?=
 =?utf-8?B?UzN6ZGdqL3dxeU9Pc1hTaEU1d0FqdHVGbWRES25RMWtuTTZtb1VxaFpRZkhK?=
 =?utf-8?B?OE9wcUZ2K011RjBoNTVreUx6R0RHemw0OHVPQ2c5SFZONzh3T05PaytqNUpN?=
 =?utf-8?B?Z2xOQU9FZUREaWRpVUdUN1dXMlh2a2pCblJOSk9mdm1KTGZRMjBRN1dBSTZ1?=
 =?utf-8?Q?iuub2E45NdUf02+0RO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7566226-751e-4690-284f-08de83f36092
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:04:05.5558 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +AdhinGMwsgQOt0YggRcAiKaiPEfWtOwAk956lWcLmcRb9uNkzHjmt2xC//pUGkV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
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

On 3/17/26 02:17, Jesse.Zhang wrote:
> Add an early parameter check in amdgpu_cs_wait_fences_ioctl() to reject
> a zero fence_count with -EINVAL.
> 
> dma_fence_wait_any_timeout() requires count > 0. When userspace passes
> fence_count == 0, the call propagates down to dma_fence core which does
> not expect a zero-length array and triggers a WARN_ON.
> 
> Return -EINVAL immediately so the caller gets a clear error instead of
> hitting an unexpected warning in the DMA fence subsystem.
> 
> No functional change for well-formed userspace callers.
> 
> v2:
> - Reworked commit message to clarify the parameter validation rationale
> - Removed verbose crash log from commit description
> - Simplified inline code comment
> 
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index b8d23a9f6dd3..22aafa969b3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -1743,6 +1743,13 @@ int amdgpu_cs_wait_fences_ioctl(struct drm_device *dev, void *data,
>  	struct drm_amdgpu_fence *fences;
>  	int r;
>  
> +	/*
> +	 * fence_count must be non-zero; dma_fence_wait_any_timeout()
> +	 * does not accept an empty fence array.
> +	 */
> +	if (!wait->in.fence_count)
> +		return -EINVAL;
> +
>  	/* Get the fences from userspace */
>  	fences = memdup_array_user(u64_to_user_ptr(wait->in.fences),
>  				   wait->in.fence_count,

