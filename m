Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2DBF99377
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 11:29:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A62510EDE9;
	Thu, 23 Apr 2026 11:29:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WEDeRo83";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013064.outbound.protection.outlook.com
 [40.93.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4DA610EDE9
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 11:29:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tkTwWqA96JqNSRDCeissZNC3E358LryuLZ2u4L4fh+3WLh4OgknejEMIlKfxYwtmwvBtQYG7JnxqQE+ciSO79WdNmR5qZlAUbdZ74Iuja9SkRlT6c1p8zB68xqKmtXr/1uY44K1xB3iPGhgw/mgp2RQiK1nOQ9up2gBbfRH0dJoQ2h1yDGAt5+rSiAYHD0wGs5wi3fF/xriCxjEw6vLawSqZTv2Skrxyba2hzZkDEiGskOlCrQso8aSat3zk4CxPKYT26D2UaNF6HY0t+Z4MfBE+315m7hH989O6ocM6KNFF1vDGkXlZxAsfqJt0EZG+2+fBDjPkrl9iXbMxuZAtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xZ28ivatTG3Zk40eLWIbgYym5Bkhysyle9hoQTsiXU=;
 b=KxrfbdChlvuTyNVHS86T6IG+JW+dic9xCwMbKFJ3kaqKpa6i3FeWi+mIuezcPL4wI7OxJ4VhC0bKeLNkeieY0Z9PLh8tVgh1RJ4x3/H3tq2gIGDGvKWjKU3kH+yIKYpOzNmJ9b0Cl5a4ZuxPJms1KdhfAyovR9MuKxv5m2Bf3Kr4tkdQEbm7Q4fn60vWbvh8oXmq4OUd6JPlCIl52QG7sRjMIL9pWFv+Oy4ZYAUQxbcteKiZFRX74DySbZW4b7yBtXKVAS4G6q3uc+Zot1rocVhHR9eV/RqX2/j2yz7vbcCvIOoUkGLlR8WTXxjPkKfYf3XzwQHjdF0vOEayvIRFyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xZ28ivatTG3Zk40eLWIbgYym5Bkhysyle9hoQTsiXU=;
 b=WEDeRo835tbWQbPQ3dAuQCF24M0YVwgMdiBSt7T/d6fsl3oFy9e8rp+gSPb8SFBg1X7L1oZ32MOKlRby3divILvROQvpRLSyGd5z57cyp2CjMLmJ3TzRb3cujkH8bhGN/mg9LaFiHzJ3OoHOJgGHYsmDqCK+2BSROUwxhy6w5tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB7346.namprd12.prod.outlook.com (2603:10b6:806:299::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 11:29:51 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9846.016; Thu, 23 Apr 2026
 11:29:51 +0000
Message-ID: <ca888c74-54b7-4f85-a557-b9b103a142a0@amd.com>
Date: Thu, 23 Apr 2026 13:29:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] drm/amdgpu/vce3: Fix VCE 3 firmware size and offsets
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 John Olender <john.olender@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
 <20260423011614.309180-11-timur.kristof@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260423011614.309180-11-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0082.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cd::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB7346:EE_
X-MS-Office365-Filtering-Correlation-Id: 4918c4f3-35a3-44b9-d87c-08dea12ba224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 5RXTIefQaclEjJWYzz9QOnv4mvoxKs/1JZZG4S356UGbq5Jg8fHTPCEZIkGZNyoZ+NtC7zyRvS8CNs+xb8gz7qpUQU9A2Md6/I6tolu2dAAZxYn4mb8uRuTpyHdXqHvr6s5gy3oASJEVHFYWlPav403zC/xr2547h4FmpNFb/j+gKPUSbkRdLB1LrfFxXAxFWWD+dUeBHnz2v40lmsm6JKFIq32EEIyUH0OffdvCP3WJrguak23AtY2C04Y2ZQO71gPGJugm1+/kh0knNVzYJ+bfEYp5/mnWB8p64WZzdSBaqb1J32polB1bjjT67NviEDw6FErxwiS1S+0nugaQ+eAaIAXTZhV78YpP59aElxdlCWGZQvlGfhpDtCMtXchmXUGjUjZHSxEBKpNjNOdoYt8Zn0p1s/fcStyDYW60yndT53VLD+qqGyyfvgJmrqtJvu8MgxK74YWJwEXXczGWNrS9rAkEEJLG+Mk/4Vp1PBIZ01wM/p9U0kftVNddCdSVAjXdNU2ZSIC0D12OyRg/fk4yh5I9T3awCKUQUiFCRdxGNDQC48QI/AKAljjkDLMn8sUn6pogXZA/RMCK3LjymZPn5E+LhG/utbX5Oqz5SOLrCzU3nRdtSb2LRVa2HGNiYUl4s6zRkbJgRuR6Q4c6Tyvgkrpsb55P+Xy4rZLzTS+xNPuO2t8CbP4nvzIpimokDRK2Yb6XFnRlOQ1Vz7monHMokZScFZowHaKkvIfAv6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S3JyYjhtUjZ3SXhOZUJ0SzhFQUtMN2pMdC9Ra2NPWkJtbUtBTTVGclNNbUpL?=
 =?utf-8?B?Q3BpR3BkZXJDSlRuV1ZUZ0MvWTd1RVM2dzRDRXNqK3kwbXozMjhjQ2U2cFdN?=
 =?utf-8?B?RXNDREpOSStlUFdPT0QrRVVqdkg3Z3dPMnBNUFVheHNSYmw4L09zUkY2TVdH?=
 =?utf-8?B?WVdzbTVnMHFHSkg1Zm5zYXRZSHQ4V08zYVJSemd2Z3ZMMERNNW1iNVFrVE50?=
 =?utf-8?B?YWF3K2x4WFdVRXNWTkl6L0Y2Q0VJSTJrdDlEZFlmN0lmWWpsUTJDTnkvNG9q?=
 =?utf-8?B?eTVqeDFhSXVkYjRjc0gxWkw3UUFhTmZETndzM3FEOWQzNW9nb2dibWx0Vk9i?=
 =?utf-8?B?SS9WVVZGSXpxSTI4N3lQMGY5NGVzTlVUWTNkNFNuVlUrWnVJdGFXK0k5ajhW?=
 =?utf-8?B?Q3c0TlM4SzVGNU5HTjFxa3M0dXp5TWVwa3VLVC9xZDlaaGhCRFdYQVB1VXJX?=
 =?utf-8?B?b2xUQjlmZU95RXJYa1ZXWllwbkY2elFveHNaU0ZFMng0NHh0NTZJcEM3dWIr?=
 =?utf-8?B?Y0gwNDVGMUhsYURoVi9xVkJnRHRxT0pxUmhoL2I0dnRBQVlaSmlDS0NPN2dv?=
 =?utf-8?B?elJDQ05tYXo1NzdTS0lWTy8rU0cvM0pEOWFrTlplaWlCUzdLbkZnYTNBQTNa?=
 =?utf-8?B?WllQdnR2dmVDY2hiejJhMm9YM1puK3FwNDlPN0poVnE2c250ZmxvNURaakNq?=
 =?utf-8?B?cXRMZmpqTVpOTHhGUmF4Q0huYThhMFhqdnpCODI3cm9xeVFwc0c2KzNlSHFN?=
 =?utf-8?B?QldROTZlVHBmcUhaV0hTUVVWWm5WeWdUMEtpaEtUaWdlaXkxR2ZITXBLQUJt?=
 =?utf-8?B?Q3Rmdm1vc3dOZEcrS3ZFVmJjOGYwQnhjRENRYkhnOXVESzZWTmhWOUI1UEh2?=
 =?utf-8?B?N3g4bWVDRjh6Y2h5SW03UWV5ODZZSzh0L0lXUFAvVTZDc1FZbk1UMm92dWda?=
 =?utf-8?B?eTJvSVBiOHhuclcyOW9oYUtxL0xYcmc0VHpsVnd4RUI1NS85dGZVZDV5eVRO?=
 =?utf-8?B?elIyY1Y0TDQ4U2xzUVB5TmMvNGpFWTJYeUc1cEdtdTdHY21CaDU0TWE4bS90?=
 =?utf-8?B?TkZUVnFjQTRWODJBQ1lDYSt4ckhheTJRK3V0OThGMU1uaTFCTXlUUlhxU0Qv?=
 =?utf-8?B?YXhPRW5TcmdjRkR1OVkyc29LdndnS2FyRGpiaTdJYmIrbFVRbitYaEFNMFhM?=
 =?utf-8?B?YUYzbURDYXVKV2lJa1hsRFZmMG5zNWpVWDRocTJzNnpXVERkNnpITGpoWDZW?=
 =?utf-8?B?QndNRk1DZk15eXVRa1hDaTB2Z1pFQlFweGFXRlZsOHpDMnRJVU5Rb3B6K0dR?=
 =?utf-8?B?dURGakVycWxUT0F0R21RUlFQczZzTzRQekxYVmZmVTg2dFhwM2hTSFluTDRY?=
 =?utf-8?B?Mjg0dlRPbWJhc21MVnZ5N29heGhsTEtUVEI1M0RxS1hxYXp3Y1V6M2VCVGlv?=
 =?utf-8?B?dDJROCtid2hEZGdCQWRFb3BsbXFWWGpWRFBtdGk1QlFpQXJyeTdNM3diL3dn?=
 =?utf-8?B?WlZDNUZzdjN5U3hzLzNBcVg2VWVwc3dBMUZoeG95Qmk3M1VETDJMM05Icm5Z?=
 =?utf-8?B?K002Y2tlTDlWNXVWd2l3QkxHS1RodVB6WnFScFJGbXZCQkFhaHRKcXpSWHZF?=
 =?utf-8?B?SjVwRlVuSjJFRE44blBwN2djQmg1WEYzdE5WTkZ1S25UVWNYSGE4SXYxNWJ6?=
 =?utf-8?B?aU5GNGxMdHhzZGdpTC9pTWpsc0tlWUg5bnlYa21tTms4WHk5V0dMT2FvbEpn?=
 =?utf-8?B?amZMczIyWjJDdEdoU2U5WEQyby9jUUw1MVFEUW9rdktsenpCSllvLzlHcmxk?=
 =?utf-8?B?UllIc1lqZjlZTEJiSDF0elpWN3Jvc2MzeWVsd0xVMXlrWTlHNzl4cTk1U3FJ?=
 =?utf-8?B?TVRkV1M0VDlxRFBsNVNieU5Xbm5XYXprV0IvSEUrNU1oTnpkOWhaakdmSHIy?=
 =?utf-8?B?eE1RS2NGejUwSlJPMS9qM1d0czFGN3o0NlFDNlBPZER6VEwyWVlxRnB5QWRI?=
 =?utf-8?B?OGZhZm9PK2lSZUpvalQxTHY1NVp1Mms2dDdmZmhmK3pCcG5vM3VRZEtOSzZM?=
 =?utf-8?B?azhOVTVvNzY2MS9mUDE4dnY3TUNaQTJXc1VYMnNicGJZdkxBSmR5T2tiQWF2?=
 =?utf-8?B?VVk1UnVjYW9mUVE3ditKTllCNTI5N0E3d1V4S1JvR3NSZ0Ryb2FKN1EycVhX?=
 =?utf-8?B?bVJsN0JDU0lESVMySFdSaFE1YjNic0lWMFRYVVoyNHlMa3FjVmRFTkw5UWlh?=
 =?utf-8?B?c1pVb1dGeDNwYmpUWmo0U0VkME0vRFZORG1jTmRXckg0YkcyN2dleURrN1BX?=
 =?utf-8?Q?m5XCu42HRjnpGk2qhk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4918c4f3-35a3-44b9-d87c-08dea12ba224
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 11:29:51.2790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZYgje2oOYO6q38mYts8tkuH+P39MyPi4IF/7QwNPCwAidqigBIRqI8l8HvsZhfJz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7346
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

On 4/23/26 03:16, Timur Kristóf wrote:
> The VCPU BO contains the actual FW at an offset, but
> it was not calculated into the VCPU BO size.
> Subtract this from the FW size to make sure there is
> no out of bounds access.
> 
> This may fix VM faults when using VCE 3.
> 
> Cc: John Olender <john.olender@gmail.com>
> Fixes: e98226221467 ("drm/amdgpu: recalculate VCE firmware BO size")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vce_v3_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> index 2e97376ff30e5..2b6ddb6bec3b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vce_v3_0.c
> @@ -574,7 +574,7 @@ static void vce_v3_0_mc_resume(struct amdgpu_device *adev, int idx)
>  	} else
>  		WREG32(mmVCE_LMI_VCPU_CACHE_40BIT_BAR, (adev->vce.gpu_addr >> 8));
>  	offset = AMDGPU_VCE_FIRMWARE_OFFSET;
> -	size = VCE_V3_0_FW_SIZE;
> +	size = VCE_V3_0_FW_SIZE - AMDGPU_VCE_FIRMWARE_OFFSET;
>  	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
>  	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
>  

