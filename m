Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A641FA1FD7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 16:42:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B0310EA7B;
	Wed, 22 Apr 2026 16:42:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RfduYAdG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010021.outbound.protection.outlook.com [52.101.61.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A4B610EA7B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 16:42:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Depfrxkoe1eFdj2YXUnE/fFocusFHcO5hq23kDQ5SKi6ratryY1RW0xg4JHHa+JHgZme99s5S/P90Ob67X5bvfuxqXijp7c08mLCNoNhCkPWe4DlgNsDFgXFy670qN7sH+mCwYOpsLTJL20XUD35uDL96bcH56FwYMB7/Y99ZzqJFBfN35ISooRqUXm3BPhMxLOIAvYjGrcI0FfIHQqyfrIEE6uRvig5iCPXvw4Egr+H2nqJ9RmIs2GMO1LIzhS1j2AUbE+7bLpexA5c3/cQkw+Bs7+k6NnVHJnC0Wx4fhU48LTaFf6KbSheFCB4N6RumTG8UYTIIzYGj48Do0kbxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ToaNGNrYviQhomPOo9RXO/ntX04R/RdWzn5tlhFKh7c=;
 b=IZT+RV6eLpOalfAljZUVaj4beYOmfwpoyN/pu53LnqXiOD2O5N4FFnmYObZ0E+cEtD5bUmaMLDnW/+nkdgIVC9Gkj0CQlOesmgtRsKcnAvNaTJLI0qRcn/dp3fvnPbwhd+sKZie4HA810yeQGc0rZ3mofsDdFRwYJ/8xNHL3VUdd0yF6ztaC9zD0zLMEdSdQhPWSqYJKh5z+AzQzP1NsVL7jbdYUKFRLyWn1pOtIJ/pNSQsor6Yh1Nualqgee4sXGMT0OX4JDUg5CdYddDOmYjmL8gNuAWqKmspo+vcxLuQo+JzoBtZ5VNtlYJpzOWmXB/Rp5FjiBEKCRonLlGWKAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToaNGNrYviQhomPOo9RXO/ntX04R/RdWzn5tlhFKh7c=;
 b=RfduYAdG3ZjqNRYn+G2mrlQzHKs2L1q039CQzSra7ryLVrOQgw2qvaBixh8MihPbBkXS9zWtg5b/qM18XcMGiNlJIz+dteKSD9VgctxVBQ9yu0WJWWJN0SQBY6P3U5QW3z1nVW8fZKfNPITxYa3snYy4IfdapCcLEDRK3OsYFL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ2PR12MB8806.namprd12.prod.outlook.com (2603:10b6:a03:4d0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 16:42:21 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 16:42:20 +0000
Message-ID: <6b404b52-c5e2-4192-9c22-629f64ad2dc1@amd.com>
Date: Wed, 22 Apr 2026 11:42:17 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Restore 5s vbl offdelay for NV3x+ DGPUs
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Aurabindo.Pillai@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, stable@vger.kernel.org
References: <20260422162956.620362-1-sunpeng.li@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260422162956.620362-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR16CA0001.namprd16.prod.outlook.com
 (2603:10b6:610:50::11) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ2PR12MB8806:EE_
X-MS-Office365-Filtering-Correlation-Id: c20ce2f7-6d71-4619-cc50-08dea08e1f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: lYcJPmX5KOk1r+AZcrFdA3MQ7Durm6Ce+FoZ/cAQ2Yl+dRktt67g9yOd5eT2vDac6DBCp1wRWCziCfvopU1L3sbgmf1wnszl/HQMHPsnBo/G/KZokuNP+7ZfhseBgXknuiyXMuUInP7KwJptbgGzIvhgatPjcII4aHb/7+t1dDEOCSew7Ln1cLrWqDOS5LeWlOSqKIJByTum7Vyk86pZJwUpyjvYE+GqLY56QcW74SjmHboQwY3fStM5EHuyWK62xbL4/AOCK9CI4zbM3+rLt30M6ujFtVVQyvM+jZdne3ipQFnd1IQ1d36VNmQxn8rJNDFtIGqFsRde4PQ/Si4akF1Bqbo10pei3Ca6ChSVqgd+0aoa5hC1xIcgtLBHt2irh/zdYumN4R6FwRAwxqzqGpRKVKshbYYSgqX2Y91pgi3aWZ+cGVmhzAYPlPiFXscfCc0P3Vqwsc6DUutNkmHHrRRYVMWZMwOoczCL16zE4wwYSOD3o1P3PHTK/K6ZMyMxypZ7FTARz1rB3JByL2ZF05sYZ4ixEPlyUTS5IXExZs7De9L+3Yr9p8CKbMD6ypIUUC/qJ+S/nmUf+ood80QmlMoE/vjeoeCa1KEnzDUDFxnnCEmX14lHc8IIlG3twjEyT1cCoMAY9IXvsIUeWraq9cMlqTxeM6h1xBJIdzfiVJZGMzMpDj8eBEC8apnqFtl6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWdLODFLSUtFbTZLamY5WGZYZFJwUldudlF5amM4ZU04ZDNTNnQrVFBON25z?=
 =?utf-8?B?TFQ0dTVjalJPcUNzK1l2dzdLNzA4NzNJQWtrTDNkMm40VHlZZ1cvOUh4RnFC?=
 =?utf-8?B?K3JleDMvVUZCQS93QjZ0eEtEL0dPVThBdDk4YythYnlvdUNiY2h2Z0FEQ2RM?=
 =?utf-8?B?YTVSQm1PVmJXeFpxTkVUY0VkV2hUYVMrWVZRbzRPcGkyVVA1OG9XZ2lhbjMx?=
 =?utf-8?B?U3hsU0ZtUDVybU1YWEZKaHZXSUx1WGRWNG5zRXQxa04vdWVkK3IyeWZJVlRn?=
 =?utf-8?B?YUJQUVBOa0pWSmtic3pQakRlTUJhYkpwZk9jL1ZLNFpNL3p3dm4vWk54MGR5?=
 =?utf-8?B?amlhcUluZnBjMnJJMXNmUVh5VXFxQ3pnbnhOM1dCNEQzTnJNalVOSHVCK000?=
 =?utf-8?B?cVJLRUxZc3dXLzVsWXBqNmVwelc5SDBRWUZneTNIMU5jbC9hcTdoYjlaQ3Y2?=
 =?utf-8?B?OGlWQVBxSjg2Mmg1eVRmOVhCQzI1akhDZTIzYkxGQWRZTUs3ZFppMFFWbkdG?=
 =?utf-8?B?NWpCTHJBZEN4TmFuTmVPM1lkVmRqOXlkZVJvR3pwb3NrSGFQeWM3OEEyQ1Vh?=
 =?utf-8?B?ZE1uNjhjd2lLR1pnUXZNdUcwOWE0czBOTXBnVEdwWUh5bFdqWEpZOVJiQ255?=
 =?utf-8?B?eGJibk9NZUptRDFBSVd3N0JGM2o2bmkrQ3J3L3dsdnh6MzBaNXNqYnIzMHZz?=
 =?utf-8?B?YnpQWllKMTVWb1VwRFJqaGZ2c0tCTFdJK2JRWFViRllWK3Voa1Y3MTAxV0ZS?=
 =?utf-8?B?TDNGOSthSXNjekN0OUlhRW0xSzdVeE9KVzVJbHdKdGkza093ZFdveWU2bmp4?=
 =?utf-8?B?VC9tRjZVd0h5UXAzalFpMlk0V01MS1ZkQ3Q4QUI0QS9YTXQ4SHdrNkpnUlNy?=
 =?utf-8?B?K3kwNlBMMXRaYU9SOVhzVldJbDRFczNybWpud21wckM3VW16dEY1YXI5VUVm?=
 =?utf-8?B?eFdydDV1bVRXby9ZYkpGUVZKenJ4K1krektFMWwxbFpjMkRGMTlKSUN5OXU2?=
 =?utf-8?B?cWdSNzhGTGFKcVZqVUl2WC8rckI3ZDMxZEhEcDc0ZGtidkhtOTJHZ21kNmVn?=
 =?utf-8?B?aU5acUxYQlJuaHF0YzB1RThOcER5bEhzWVVScXorZkhTaTN5dGsyUGNhMkky?=
 =?utf-8?B?eGJXUjZVa2w2Y29EZVJKSWJzRU9hVUtuMWcyZU9XZmNpdXJQM0N5VTUxR25K?=
 =?utf-8?B?ZmlkdEhnblpsSWpwZTJyUmxXYWRxSmtyRytWcGcrNy9ZblpDWTYzY0k1SGh2?=
 =?utf-8?B?cysyaVphdkFDdkE1b1dmbEk3TEZWQmN2VzF5RHdEUzRlVWdTOW1FWTJDUlhk?=
 =?utf-8?B?RFovaWI4ZlcwUGpqRmdTKzVQNUtIVlZpQys5S29qNUNtaHF2b1BuV01XTDdF?=
 =?utf-8?B?L04vL1Z2L0Y4R3dOcFpCZVBMRjBNbGxZdzAyTVM4d1pUanQ2RGRoR0h4K3U4?=
 =?utf-8?B?WHZyZFdkb3NyWFRJK1dWRCtHSEF2L2NnN1BZOTgrU2lFNTBlWUloZmdCdVNt?=
 =?utf-8?B?NVU3RWxDMmJHc0psNWZGeDVneEJwL0NDeDBBajNRSFE5VDJRODVXNVZaWjND?=
 =?utf-8?B?bkxtWE1xdmR6bUZmTGtySTRrdXoyUytXbEgwRThQb01LT1Rxc08ydGVIVHNC?=
 =?utf-8?B?Tko1MEVaMmcvMkMyN3Y3V3krUzh4eDJhckE5OXRiSG5pMWxsUHhDVmg4YWtz?=
 =?utf-8?B?NUJpQy9lbTFRNXJXYlVMUFcwUzFrWDExUnlGN2pBSm9KbEwwL05ncnNVMDND?=
 =?utf-8?B?bmx2UDVia3ZFMThoZVROczN6ekRwcEg5VnoybEpPZmlwNFFqbTZRK0prc2pa?=
 =?utf-8?B?UHBPZHhMd3JVVTZnT0t3OTJycFZmdVZsb0lzUmxXaHlXR0Q3eUlTeU55VTU4?=
 =?utf-8?B?bXhTU0sxdTY2RUlLK3U0UHFEalUyem5RM0JQa1dta3JHcFc2Q3dtSEVwRjlj?=
 =?utf-8?B?Y1cyN1B6L08zT1FoUVdmTS8rTFJjekhyYklNUlB6NDRTd3JuZnZtckM1MmRn?=
 =?utf-8?B?K1FYSk8xNEdmUGxwZi82ak5RRTZqWjA3TVFxQUhhTW9JVEpvYjRWK0NvVWFZ?=
 =?utf-8?B?QjEyUXJtMVVKWXU5K3BYY0Njb3RnWUpLaVI2bHlMZzNXSDZWbm16WkJPdWk1?=
 =?utf-8?B?QmdtVEZnWStZTHVwNGFnNXdqMm15ZE5sbFZkRzRaYy8xaHFFQVFZdEp5Vzgw?=
 =?utf-8?B?T3lGZ1ZPRTFFRlB6RVRCNytENDBFK1JWVlFlampGMm04OS9WaU9tbzNDK0JO?=
 =?utf-8?B?WnRmWXVRU1YxYU9DMkduYkJIdSthaEI4SC9MNmk5OHBIL0g2blVTdml0R0Fo?=
 =?utf-8?B?Y3dUczh0bjNYY1NZUy9oV1lyYXdNdjJYenU5V2JqdEVHQlFWcS8yZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c20ce2f7-6d71-4619-cc50-08dea08e1f45
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 16:42:20.6332 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NHnYk+/KVQHWHNNxXcdPBr7QX8EX0RhFyeASDsyk+wxAOSVcyRKBR4tOUJm84SxtaJpfF4z8POUBPZiFsAnOJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8806
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



On 4/22/26 11:29, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> Rapid vblank off is causing flip-done timeouts for NV3x and newer
> family of GPUs that support more idle optimization features.
> 
> A proper fix requires further investigation. In lieu of it, let's
> workaround it for now.
> 
> [How]
> 
> For NV3x and newer family of DGPUs, restore the old 5s vblank off timer.

Why would it be dGPU only though?  I thought we have various reports of 
flip_done timeouts for APUs too.

Is your theory they're different root causes?

> 
> Fixes: 9b47278cec98 ("drm/amd/display: temp w/a for dGPU to enter idle optimizations")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3787
> Link: https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> Tested-by: Michele Palazzi <sysdadmin@m1k.cloud>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  | 18 +++++++++++++++---
>   1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3fa4dbda4517c..ce5063928413c 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -9511,9 +9511,21 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
>   	if (acrtc_state) {
>   		timing = &acrtc_state->stream->timing;
>   
> -		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> -			   IP_VERSION(3, 5, 0) ||
> -			   !(adev->flags & AMD_IS_APU)) {
> +		if (amdgpu_ip_version(adev, DCE_HWIP, 0) >=
> +		      IP_VERSION(3, 2, 0) &&
> +		      !(adev->flags & AMD_IS_APU)) {
> +			/*
> +			 * DGPUs NV3x and newer that support idle optimizations
> +			 * experience intermittent flip-done timeouts on cursor
> +			 * updates. Restore 5s offdelay behavior for now.
> +			 *
> +			 * Discussion on the issue:
> +			 * https://lore.kernel.org/amd-gfx/20260217191632.1243826-1-sysdadmin@m1k.cloud/
> +			 */
> +			config.offdelay_ms = 5000;
> +			config.disable_immediate = false;
> +		} else if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
> +			     IP_VERSION(3, 5, 0)) {
>   			/*
>   			 * Older HW and DGPU have issues with instant off;
>   			 * use a 2 frame offdelay.

