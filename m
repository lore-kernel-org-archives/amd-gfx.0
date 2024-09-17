Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012E6C35FFF
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Sep 2024 13:06:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6FA510E471;
	Tue, 17 Sep 2024 13:06:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V2OVKpcv";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 814DE10E471
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Sep 2024 13:06:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jgOcw/YvfbGJoIskJ0v0XJ9329l67/LMhe0+Grp5meMZuGNtFswVNCL9kQaTudsPPJN/oGanLKbZfATReH+UVHz7K3mns5gDdiYz/dcWkB546Jsk5keAF6pQGUkYyaCTy0PR8aAfjE0iSqGI1YnR20PU6oMcEXoQDb82FaNC+bn9sDWUWw8i0bnSrfavF6Afc9VAGx5JzavC5o/9N6CIx6oi5NXDkimxTpJx2nteK3mU0qAgTBeD0VoAqwV6rcryQQvfbEU3y2/H2wrb81PCWDZZJmrM1vZvSnIVK71Hadk8Vq0vZZ15AVVZOL7e5ceJkATCE7zyYFvMRrm1Xe4KOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eBXWWvFz9sThwQDTjtm+cAfCQeYNEp4+eHUBgYtchTw=;
 b=TkvURa0Vh2EPphgdWcn/kGxFfqhDTGA15X+khYQkNJasncpydPAoBPi8oSsrMkoHZVnkRB/L0JE7EBgOHPNo84COFonTwn5uqJBXpbqrYEWiUndUPFNPYY++S+jGlfZbLm/Nxhi6OOuSvg9708+x8HaW6tD7YVAvYXmxsCXOXig7n7xs2FDYnVjTEdPDY1KnLKG/aGMsyzNO4HinnwfWBEQvJBPLXfv1UjpbhA0lm0Et/Z1nU0D2Hy/9Vyx7U4W9frsWhK19sHCNL9Evt7SHZnkdqRVH9ElRS9xZgswrbQdSgjVxBqF01u6tnvPR+2sAPB/N2tY3eYjQiKf/kXWXDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eBXWWvFz9sThwQDTjtm+cAfCQeYNEp4+eHUBgYtchTw=;
 b=V2OVKpcvu73E7x9V/FEY6GpaA8Y7jF8u7VFvml1AjaukNfIktFTxIldsa+RQLJeBZJNg/PFVcBvZiqXTF2EGVVlcfxmw/8Qbohaho9OH2YKCuB2mPYHsUxk8k6jgVkZzF+Stj6LrkBe31wuqDyx34jckeJY+/fRU9biDD6ng6WU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CH3PR12MB7692.namprd12.prod.outlook.com (2603:10b6:610:145::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Tue, 17 Sep
 2024 13:06:24 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%4]) with mapi id 15.20.7962.022; Tue, 17 Sep 2024
 13:06:24 +0000
Message-ID: <855735f7-cba4-4a84-bdbc-b7d44bd9386c@amd.com>
Date: Tue, 17 Sep 2024 18:36:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: clean up vbios fetching code
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240917125428.2326410-1-alexander.deucher@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240917125428.2326410-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CH3PR12MB7692:EE_
X-MS-Office365-Filtering-Correlation-Id: 930472e7-6989-42c9-c77d-08dcd719880f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWxlN1hsOUNnTTdid09INEJqaVM2dTZDMjgyTG9yV2pLSHY5dWtuNml0VEZ1?=
 =?utf-8?B?eXFUQUh0czVVOG1mbVI0bXdZbkZEekw5YmVEbGFOcWlwbFBLTmZsdlFsSU52?=
 =?utf-8?B?SldZc3ROeTBIbnROTEFDNDg5ZUU3bkVuek5ubWs3OVRJajM1VzVFSGVyT0xT?=
 =?utf-8?B?U0VVOXI4cklGR3ZxcGY0emZoZlg4b211aW9KQTFOWlpFS21JZWVKQkpLN3V0?=
 =?utf-8?B?U1FBSFpTSFRhK2RvTmFDMTJaWHhmNUxuWC9oM3FhdnNWWXAyeVlOZnI0WDJr?=
 =?utf-8?B?N3BkTjU5VTliRnFGdTYvMVk2MlBzNVRWY0wyckhjMHFsZWhnK2RmMERucldq?=
 =?utf-8?B?Mi8xM1NGN2IweEZVWldZNlBlTlg1Zkc4UkdGdW92TE04ckZDSVNLaHhKdlll?=
 =?utf-8?B?YU5kTkl2d3U5czY2MWlEblZlbE5RWGFOOGd4bk1ncm1aeDRwYUk1K1VsNXBO?=
 =?utf-8?B?WjdaV0duamJQMlY2M1dXVGgrL2lHVVNzZzNlVmVzSnJ2a1g5QmZzbEZpY3B5?=
 =?utf-8?B?c0Nrd01SWnBCZFg1ZjlzOUtQK094Q2Y4cUJJSFp5NW52NG9WeFZhd3E3UlJp?=
 =?utf-8?B?L0FQNG9kZ2t4UitBbzNqY3ZkT2EzcXJ4ZFVNV3JPbFhHTUVFMmVGQlpBUUlk?=
 =?utf-8?B?clFMeHpOSy9wVkEzKzF4NDZxVTZUc28rTGM4SHFFK252NklMOHhSbHRRMXBD?=
 =?utf-8?B?ZHhoQXBZWk5QcFRueDU2Y0o0ek5DK3JIT3p5SFA2S0FPM0QrSURUNmJ4bmJR?=
 =?utf-8?B?aGtocVBIbTY4dUpGNXNrVDFZRUg2TXplYXNVOEgxRElVUFhBekRleHZyaFFS?=
 =?utf-8?B?VVhlc1ZrY0NQbTZPdHV4cG00OFlmQ1pwL3hLYUhvd1hxejlmU2YvTGUvNmZl?=
 =?utf-8?B?RmpzMXNaQ1lUZFNrVHdWejk1N1ZPMTgvaVptSVIrUlpTREtBdE1ibjdDVFd3?=
 =?utf-8?B?Nkxjekh5cCt4TlJJWmN3Y0pmRTFHMDRPRXNJK0VzQTVSMkNiWXRlS2EyRG1W?=
 =?utf-8?B?eHhxeVhSSWtYZDZkTTAyMHNIMHlrWnRsVEpvNTUvS3FNODcvL2RrSVVha1Av?=
 =?utf-8?B?OHlWUUVYdEN6U2VSZUhKUkY3eXdNSk5VMVFnR3NtTytRbjRCNDA5Q21TV3Bv?=
 =?utf-8?B?dlVhcjRMc2pwV2hCejFwQmdXdzNEazBJZWZBR2tJVmVPUkl2OFRHV0xiYVBz?=
 =?utf-8?B?ZHMySVlhRkxIQUdUcTBMazJ4RW51OGtFOUNOV3lvSTRMV2VzamdSRHcxY1Z0?=
 =?utf-8?B?TCswcDNQL0lhc1BhZzBESHZ0VHgwTENRUnE2MEY2ZHNleG1NRWNWck9YUGZM?=
 =?utf-8?B?NVpvbnhxUlowVFpnRzhsaEtLTVVYZGdua3pleG9KVjZIVUtza3lVWUNsTlI3?=
 =?utf-8?B?TXY5UkpTSVVOZkdkSGVKZ1ZGMmh2ZUJGZkthaU9Sb1dldFVHaVRsOUZNQTRB?=
 =?utf-8?B?UTJ2UEdKTWgzajdiWjM4VTlWUVl3eFhJMml0Zmk5SjFYZ3pwTjFtT24zOVNp?=
 =?utf-8?B?UitlQmI4eGZveThiRU9oV20rWXhFWG1VY3RhY3pVRkdFL1dncmFuRFBUSFFi?=
 =?utf-8?B?a0U3cysxTkIrZ1NOVHl2N1U2THluYWM5ZkljWDJvYlhwSzFFSkVJOVFRcDhK?=
 =?utf-8?B?NFJMeUl2dHgyNFcwSXpwblUvK0xGc3U0ZVJMWUlZenpPdW4vVFRtTmlabXUz?=
 =?utf-8?B?dVhzR3k1NHpjWmF5YWpreVdDS1cycUlaNE92SndUYWxReUVmalVEOTZwTnpR?=
 =?utf-8?B?VDRudGRlVmczR3VVeW93RXNzUlpyZy92RzBSY2pHYldOa3M1NEtuU2RYbEVP?=
 =?utf-8?B?OEhxZk9HNjVMMVJMWEQrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WSt4ekYzanBSL3pCemtneTBSWjNNQ2FpZmJVN056N1U5QmEweFNrUEN4YjVu?=
 =?utf-8?B?OWNwMU1Gckx2NEVZeERTbVAzY1NlL0ZweHYrejhFV3FjMWpQdXY4emhYMlhS?=
 =?utf-8?B?VDhlWlZlUVRXMStONHNleEdUdE9FUDhHaVc4UXdJRi9BZDI3QWVWZnhVV3Rw?=
 =?utf-8?B?aG1wdTR3c0Rra1VLSkh0MzJiOGhaZTFDRjArSGxvQVBRZW5Lak1FWEE2M0pX?=
 =?utf-8?B?T28yeDVEOTFTNzU3alQ3dFFWcWkyZmxraE5KTWhzT05OOGJqKzJjSlRhRnIz?=
 =?utf-8?B?dlVxR1F6MUsyWVVJaTdaQ1pFRXFOUkFLcFprdlREMDhhZE93eVpmcndReFNO?=
 =?utf-8?B?UFZLTTl0ejR6N0dEVVEvYURVajNLVE5NSERGWGJmWmlsVUNmWGhNVzJEWlMw?=
 =?utf-8?B?ZDB0cXk4blRYTGJwMXdrNGMyWllTbUhnL3BnY2tTendaZ3hwcHNVV3oxODRG?=
 =?utf-8?B?U1E5ZGozNkxzS0VKc3Zla0RueUo3ZTNzM2F1amVPS0FKTnhPemVnUlhTT0ZT?=
 =?utf-8?B?aEllTXY3NGc5VVZmQ0oydnVtblZqOE84UEovZ2QvZ3F0OUlhc1EwN0wrUlc2?=
 =?utf-8?B?REI4bkcrSHAzZFJBSUJnY0prYk9zSUczcVQrRDNBUlQySkZ1NUVJcFZCcGZw?=
 =?utf-8?B?RDlBdjM2YTVFNjEyd3BNRUp5ZDhSYkZuRlQrekpNTVJXdXAxdC8vdTFlZXBP?=
 =?utf-8?B?Nmc1K0k2WW5CT0lseHNMeWUzSlhZUC96aGJZbVRmZEFuVmtqcU12cWNEMG1y?=
 =?utf-8?B?MWpIeGw1eFJZMGV5eUxrVzM4OUM3T3lENXVZSDRrZkgwUksrQXhEb20rUVdT?=
 =?utf-8?B?SVp6YVhGWXNmSFZzeHFJNnV0U2trRzh4ZG4wOE9sSjRwVWFMa2RzTkVobkM2?=
 =?utf-8?B?MExSUWRIZEl1dSt3cEl0cmZXQnRiR1dDRzh2Z0FHeWc2Q2Y0OVZ4T082dGlD?=
 =?utf-8?B?OEhIcmhRRlJuelpzeWZSSnBGZUMzdWRRN2xKNUJpRmFLL25pM1VPU3g1UVVX?=
 =?utf-8?B?eUZRR2o1UEs1NExwVlFyOWt2UER3b1NQS1J6bWg3Mm1xK2FUTVZuNzZ1RUxB?=
 =?utf-8?B?c0srUzU2OHJzV2pWUnhNejZQeTdGOTdKNGJSZVRkUWI0bnIrQlk1YTdqd3Ax?=
 =?utf-8?B?RjZFUE4zNkdwcXRGUWdwNWVFWXhJdlROcnlzbFhPN0V2cVM2L3JhbW9RSS9s?=
 =?utf-8?B?MmFDQlFOZkJMWC9mUmU2d3JRY1RoZFQ0VWR3RDFxbEdJbHdaemxnaEZ3b1hC?=
 =?utf-8?B?SGNIRjVRU01KVU9TbzFDUU9RY052YnI4dlFqWVhrVUo1dTVuS05hSmpqZWNq?=
 =?utf-8?B?ZitPWm1rU01zNVo1SkJjMFBlZDVkZWliNTBwNXlLVXREeSs3NkZiRktqSk04?=
 =?utf-8?B?TzFmcnlQcEpPdzkwN1ZFOXR2cWRCc2JmeGV0VzdRQnVycnprZVgwR3ZyTWYw?=
 =?utf-8?B?dDQ3K0x3SHJsZklKdGFnZGhqNDJieEYrc3lXRkNpcHNQYnZUUWp3WERIdnpP?=
 =?utf-8?B?amdOWjFFNVZaV2p5VHRBOE9iZFdOWmJsTVBpdTNxUk9UTWxiSmZUWU5yc2c1?=
 =?utf-8?B?N2JKWG9EN0FvbTIybHVQajFTd0gvbDBFKzFmR3V6VEE3cHIwSW5PZmNlS1N2?=
 =?utf-8?B?dTg1WTl3clVlbDNRV2hFak1FUjRSVXp2RHQzQ3c4eWsxTnhpRE1aa25mWGFW?=
 =?utf-8?B?M2tvZld4VGNRR0JpY0lVeTV2SDNabThiOExVcTMwR2dsa214MEI1QTQ4UTgr?=
 =?utf-8?B?Q3JxSzNKd0hoTE0yZkNEcHMzVUdkakFOK3RZNUFXcDlNMjRia2FzYmQrRnJa?=
 =?utf-8?B?QzEvVGVFUW5XYmVhb2tuNFF6ZER0UjJyNDBlTUpZWTMrM0NXV1k0OFhjR1hm?=
 =?utf-8?B?Y0FiK015aTNRYWRaMGJmWEl4TmRRc1paUThNT0tmbjBYbVYyVHFibGVNTldx?=
 =?utf-8?B?cTF4eE45bkxlS1FQYUE5dVNMd3ZDZzU3a0VCWlZyamZFUnl3dEUzSHFYL3pp?=
 =?utf-8?B?YnNaUHNwdGp6cjlWZnZaZTNKK2lGOEdDRlIwTjBJQXkrZWFtZnl4Y2l4SHEr?=
 =?utf-8?B?NjNjQWU3WWZrbzJjdVIrTXgySmRRWFNIdjM3L1ZPM2JodnV0UnVhWDNHanU5?=
 =?utf-8?Q?BdHinB6PpWsO6cLwvcSqf/38b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 930472e7-6989-42c9-c77d-08dcd719880f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2024 13:06:23.9756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NAT4SzwdpoGVgCFnMKyRSBc2QvtNN0dILRbdLdXDmx810jgem4MCKmQvdZGd1XKV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7692
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



On 9/17/2024 6:24 PM, Alex Deucher wrote:
> After splitting the logic between APU and dGPU,
> clean up some of the APU and dGPU specific logic
> that no longer applied.
> 
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> index e8f62d718167b..46bf623919d7c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
> @@ -284,10 +284,6 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
>  	acpi_status status;
>  	bool found = false;
>  
> -	/* ATRM is for the discrete card only */
> -	if (adev->flags & AMD_IS_APU)
> -		return false;
> -
>  	/* ATRM is for on-platform devices only */
>  	if (dev_is_removable(&adev->pdev->dev))
>  		return false;
> @@ -343,11 +339,8 @@ static inline bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
>  
>  static bool amdgpu_read_disabled_bios(struct amdgpu_device *adev)
>  {
> -	if (adev->flags & AMD_IS_APU)
> -		return igp_read_bios_from_vram(adev);
> -	else
> -		return (!adev->asic_funcs || !adev->asic_funcs->read_disabled_bios) ?
> -			false : amdgpu_asic_read_disabled_bios(adev);
> +	return (!adev->asic_funcs || !adev->asic_funcs->read_disabled_bios) ?
> +		false : amdgpu_asic_read_disabled_bios(adev);
>  }
>  
>  #ifdef CONFIG_ACPI
> @@ -455,11 +448,6 @@ static bool amdgpu_get_bios_dgpu(struct amdgpu_device *adev)
>  		goto success;
>  	}
>  
> -	if (igp_read_bios_from_vram(adev)) {
> -		dev_info(adev->dev, "Fetched VBIOS from VRAM BAR\n");
> -		goto success;
> -	}
> -
>  	if (amdgpu_read_platform_bios(adev)) {
>  		dev_info(adev->dev, "Fetched VBIOS from platform\n");
>  		goto success;
