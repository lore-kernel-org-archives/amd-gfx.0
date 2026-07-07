Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74464C43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 18:12:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DFA210EE9F;
	Tue,  7 Jul 2026 18:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lyxlzucj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012049.outbound.protection.outlook.com
 [40.107.200.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E39810EE9F
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 18:12:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvW6ByH54WIHE7rEz5DagN8gezpEbwLA68gZPk0s4lmRtIDDBWGBX6CQdOGvufmKskADrpukMTpBoRgh/nfdVB4zARatG9WznmkCtCxLNe8N7ZSaJM51nQVh+Fosw3B2P8meZowA7Jmte53eF7M/RykS/QhVt7uAV9CM3bdxAVihQqhHO+JJliB0ECbZEIS+nkBZtzWcVqv2RNJZMxGRfMbFF2PFpchmd2SHp+OOmI/3D6I7oarfx251rxWK+IaLxPnUJ2kF9Ads+emmn94RK/Erma7pUUiVP1LeP1YKrkMtuXDQpo3iNi45ejRwS3Yd9s99Yv5voLLmg+QqbI/BzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mFoiCtX3Y13geNRULHLiqKRd8uLqGv4/3/Tno3EkCbE=;
 b=wEBDwx3LsUNfOL3ZeDn5lorQjEyFEUx/+NFo/qSOMtIfjaOqfJ5vgL0Fw9PP/tOV74JpADNEdhRo90aYlxcReuW1RF9dZmnyVQeKeSBqg0flT79MObVn/6Hs/VU93MFlcwM2VXtlm/UsPPK+0SI3bMAEHHzYOA6bAUIlhnEr0cct+lr42fnoXIZ/oICSndFQUIm71LO5V3d+GBB03eD774DS2A3CGQIy4s2ac0+G+0F2jg0P+za4bGUrUsVDPN10G5E/4HHsFg0QhFYYCmYJWAx/VJkS3W7TfR5s7mmcuVC4/wKcYFHZNrF9ehqdHhUPNQHBFUnqGsrRzfEgecFhNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFoiCtX3Y13geNRULHLiqKRd8uLqGv4/3/Tno3EkCbE=;
 b=lyxlzucjmE96RXdBTr1yMtkpwN/lH3Gxg1AUaGVBAU95uuKmKXr0lsBkoLah7e5fQBhDfvMbI9VfFITKduFf/WS9dsutpS8tpPEOe8CHI6OajENZIXWTWjJ4SQUipNqRKa+hks6tfI+H+WC+yF+EBPTkx9gEBUvDo/Jr+gD5J4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6425.namprd12.prod.outlook.com (2603:10b6:208:3b4::7)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Tue, 7 Jul 2026
 18:12:54 +0000
Received: from BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74]) by BL3PR12MB6425.namprd12.prod.outlook.com
 ([fe80::966e:7365:702d:cc74%3]) with mapi id 15.21.0181.009; Tue, 7 Jul 2026
 18:12:53 +0000
Content-Type: multipart/alternative;
 boundary="------------vn8UrY0ErjwCgXRf4ZWo0ZMH"
Message-ID: <9cdf7dfd-4c78-48c5-9cd1-d6523b8039d2@amd.com>
Date: Tue, 7 Jul 2026 14:12:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] drm/amdgpu/gx12.1: Add ip dump support
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20260707180021.2642432-1-alexander.deucher@amd.com>
 <20260707180021.2642432-5-alexander.deucher@amd.com>
Content-Language: en-CA
From: Mukul Joshi <mukul.joshi@amd.com>
In-Reply-To: <20260707180021.2642432-5-alexander.deucher@amd.com>
X-ClientProxiedBy: YT4PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::21) To BL3PR12MB6425.namprd12.prod.outlook.com
 (2603:10b6:208:3b4::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6425:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 165acb73-164a-42d8-4acc-08dedc535d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|8096899003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: FUw+yTexKQ7HkTjYDd8uGD1YgkrArQKcvF2rEsC7ex+2RA5HKdHvI4f5K4M6MaQh2i72urr/UiY8vXYbQ0Zsl3EgPuW5DjmR5JntweuaPPyJn9YujPWP2dUynU1ZkUR0IUk3jtHhbQZvGRtIhTdYJeKnc0kkl3myrIEO0hAkwj+uzMdCw/RY6kNmjYCzrK3kGH+w9L3lXS44PEGZAbH9+6sOoAFAxNArLgTS4sto3wiHZZg3Q5sStW8sT6a4ZEebvChcRdkfXvT4zHiSmNExPVEmQDXs7WS8md4H4cG3Nxvoq2Se9hPPzGqQscOb+PCmSGGIk6LPLIDSCJXo/6B9bqkwurNDNKZ2UY+au30Ein9haxokMFCM8IGht0L2wBYPYNET8QhemvXRJLpo672QhbBiJ914b9h35XbVGEqK9ZTeERdDo268BsfOs1JzfIoU5NrItiB0fIMyz3wFHZbLHG5l4D2ClTMrv4dHcLSsrIE3GHECKq17mHlm4KumrB5mlq7OS/LulK/C4E7rG3iSil02bly63t/9AlJGonCdMr3WcEHl2VGTEWJRtDfaAjC10CP9NrUOx+BrscIzxvNrLjtnJxkELPlTkPnNYh612LKw+OE+3uLSmGYiApJWB5viYrGRvuISifo/6LEYHovsfCG0XuCWr/CEURmQCxcKyNM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR12MB6425.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(8096899003)(6133799003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0wrem1jeTBiZ3VhZ2J0WWhQemV3VW1EYnBEK09DMWh1Y2VDU3dXVDQrZmN0?=
 =?utf-8?B?Smd6RE1FakVWKy9NMUl3WCtjdHN5bHRmL1FDdVdWNE5WUjFJamhwMnkxVlF4?=
 =?utf-8?B?Wnk4bmhCajVWM0ovaXFEVlIyZkhtb2tiVFhKZXZsUVFnV1lUMkowNEkwTHJM?=
 =?utf-8?B?MUxLS2JVZGFlNXd5TVhRV3YxRldXcFp0V1lZOFhXVkc1amJ6RGdjTjVnRmRC?=
 =?utf-8?B?ME1MUzBiWVdPSGRqY2Vld0IyYjhFUzhJR3IzZ0M0bWdmYmQyM05VNmtZeDJl?=
 =?utf-8?B?VlpuR3FCTzBPZ1R0djR1ak9iZGFVVC9zM0l6ZGdLOHZEZW42NDVuSlc0aWM0?=
 =?utf-8?B?TGkxSXBWUTE4dk1VMS9ranBuQUp3MCtCd2tRTXE4b3VkZ2E4TVc5SWdQYndE?=
 =?utf-8?B?eGlzODF6NGkxYWNFajRsekFEamVyRXliM0JYV2R4NEkxVW91SE9YSVpxd2l1?=
 =?utf-8?B?WlVRSWtSZGJUKzNFVGYyY3ZvdThmbEdUQnFteTZCRXlNbHhjL3JRR2t6MWxn?=
 =?utf-8?B?SmtneTk0eEVUSWlWNUw1MVdsdUMyT01yR012cmVybkhkZ21acDQrRE5Eby9k?=
 =?utf-8?B?ZTEzZkhtK0xCK3Z4MFE5eTY3NnlpelJpVFRGZ0UwbWZEY1dmNmxKbDVrMGl5?=
 =?utf-8?B?Q2pRTHZncTRmelRDZjZ0SGhGdGluUG9ieVA4ZVRRaS9JbmtSbzFyNnh0dGow?=
 =?utf-8?B?VjRBaDVoTXZaOFlEdHJJMExPbnF2TFpzMFQxOGE4ZUhXWFpxSEg1U0E2eTVu?=
 =?utf-8?B?VEpBa1ptQzJPSDJLSDlncVpsSjlwalJFeHVqSkltYlNuV25aTGZnWTM1V3BC?=
 =?utf-8?B?NFpOM3BLdytpbDBEbmtwWThlaUVhNDFENWFkN214N29xVFF1dlJyWjdqaUlU?=
 =?utf-8?B?ck1pUlRDWnNVc2F0S3JkNEtsNWpMd0hkak83eEkrV0RMd1RhUGdqSTRvQzJ5?=
 =?utf-8?B?bjN2Tk9WMUFSNWNzRlZLMFl6c1VySU1RcVNVdmFSbDRpbTZ6SDJJZGgwSVYr?=
 =?utf-8?B?eUJmaTI3R2J4UFdiOUd1MTlIWWg0TXFrc3h3MFpDcEowbzJ0a0Z1UnQzbTZh?=
 =?utf-8?B?eGlWc2d1N3JWc01zMG9GMmMyWE1OMDl0RFNrSGJMMlpYc3UwUzFOMTN4NkpI?=
 =?utf-8?B?bUMya1hYREdaQXM4RXZlSWZoSHdjVFphWUttV3dxZU1oWEplVTg5ZFhqemNI?=
 =?utf-8?B?SFc1UHZaNlRYNlFIeDZkNmJjVTJKTnk3OENQZzQwdkR2alNmVkpZMmJnTmNV?=
 =?utf-8?B?dG12Q0dGbjg5NWVxSmw1YnNhdGJWejJkRHg5bFkzSGhwblNnd2pLOTVWZnJC?=
 =?utf-8?B?RFRldVZLZzRHaWhZZzBPVkkzdGw3UmFhVFNIUmppVk5obEUwdWJqdGhQUElF?=
 =?utf-8?B?dWdEYlBjQ3NLSHpVNE8vakM1Q2tBOVVuNElNcm9vYWx3YngrenAwVU5TbGNN?=
 =?utf-8?B?cGI5NVFwK24xQjRiVE9hUGlmMmdDdHhqVldZNFdjNy9DckVuRUhoVlpyazd6?=
 =?utf-8?B?YUNtOGdjZW5aMnhOWnFPbC9NclpENk5IekFQeWVxR2lzSUI1aGJCWEZhZVZ6?=
 =?utf-8?B?eUlUQTB1YkcwelJPcTdQU2dWMmpMREpuS3FwMEh2WUN3N0FhaitHUXNvYU8z?=
 =?utf-8?B?VW5zUWQ0S1FvRUhOeFZkUHMxdlYxWTc5NThaeEZoNnAwZ3JscUI3M0c0eUc2?=
 =?utf-8?B?OXlVNTZtR21uNkw3MDluWk5ET28rSm11N1N3UnpJMytTNzZXREVvODdmOEIx?=
 =?utf-8?B?THl4bVBMd0hLa29WbmhNNjBNSEdpRGsyYWZvTDMvbTlDczhtaGlNTFhWM0ln?=
 =?utf-8?B?TXBlQXNHQUY0QURYdm5ZZDhlRXpwamMvaWEyZWJOQXQvRW4vSlQvMkFQUU9t?=
 =?utf-8?B?cy9SMUUvL3hyeXpEYnVYRDk3V2VtUjVETWlRbk9ZYnpHR3BVMnFUOEFJbXVj?=
 =?utf-8?B?VG1GNW5SdjlIYzdjc1ZXaTVVeXhKL2I5dnJMVWhsdE1IRitOejVKcEl5WFNL?=
 =?utf-8?B?Umc0eTlKbnRQcjJLSTRiWnJFS1B0SkZCaEZQcDg3Q29ONWJmaURkVFQ1TXAz?=
 =?utf-8?B?WHdIMlVtbXd2T2VCVnRrS1FUUFc4bStkSzAyMzBQeGVkbjZaZHk1a3ArSnE2?=
 =?utf-8?B?bkRucDdldnpDaDB4N3FEQnJwVEl3REM3VjFYaTBEWStlSVlZb0lHU3VsVklj?=
 =?utf-8?B?QVhBVkV6aVJ5dWZRV25sYXNJaVRKQURldlFsNnB0TzNQRTR4VHhsUTNMc3lV?=
 =?utf-8?B?RkpFUjU3N2JmODcvZ2pTOW9wZWdrMDV6TllBTWJwTXorMzhvYUY5eEpLOElz?=
 =?utf-8?B?NEZ4VUo0VFk5L2dMS1JwNTBlcmEwU3VCdGZ2M3NFaXhkNzdMeHFoZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165acb73-164a-42d8-4acc-08dedc535d36
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 18:12:53.8582 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xWNyMa7D4EA6ALGNDX+dr/DFeKGErdd3Z4JOj3wrF0sIMo8hg76Sle1BfDFZTqlCpt/a4r1+5hcz8glpKp0cbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736
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

--------------vn8UrY0ErjwCgXRf4ZWo0ZMH
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Please do before pushing:

s/gx12.1/gfx12.1 in the patch headline

Regards,

Mukul

On 7/7/2026 2:00 PM, Alex Deucher wrote:
> Add support for dumping IP register state.
>
> v2: fixes suggested by Mukul
>
> Signed-off-by: Alex Deucher<alexander.deucher@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 277 +++++++++++++++++++++++++
>   1 file changed, 277 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 408fd23c6bd43..1d09f1771dde3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -69,6 +69,127 @@ MODULE_FIRMWARE("amdgpu/gc_12_1_0_rlc_1.bin");
>   	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 << SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
>   	 (3 << SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
>   
> +
> +static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] = {
> +	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
> +	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
> +	SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
> +	SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
> +	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
> +	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
> +	/* cp header registers */
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
> +	/* SE status registers */
> +	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
> +	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
> +};
> +
> +static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] = {
> +	/* compute registers */
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
> +	/* cp header registers */
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
> +};
> +
>   static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
>   static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
>   static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
> @@ -1148,6 +1269,155 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
>   	return 0;
>   }
>   
> +static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
> +{
> +	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
> +	uint32_t *ptr, inst, num_xcc;
> +
> +	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +
> +	ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
> +	if (!ptr) {
> +		DRM_ERROR("Failed to allocate memory for GFX IP Dump\n");
> +		adev->gfx.ip_dump_core = NULL;
> +	} else {
> +		adev->gfx.ip_dump_core = ptr;
> +	}
> +
> +	/* Allocate memory for compute queue registers for all the instances */
> +	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
> +	inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> +		adev->gfx.mec.num_queue_per_pipe;
> +
> +	ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
> +	if (!ptr) {
> +		DRM_ERROR("Failed to allocate memory for Compute Queues IP Dump\n");
> +		adev->gfx.ip_dump_compute_queues = NULL;
> +	} else {
> +		adev->gfx.ip_dump_compute_queues = ptr;
> +	}
> +}
> +
> +static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
> +			       struct drm_printer *p)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	uint32_t i, j, k;
> +	uint32_t xcc_id, xcc_offset, inst_offset;
> +	uint32_t num_xcc, reg, num_inst;
> +	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
> +
> +	if (!adev->gfx.ip_dump_core)
> +		return;
> +
> +	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +	drm_printf(p, "Number of Instances:%d\n", num_xcc);
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		xcc_offset = xcc_id * reg_count;
> +		drm_printf(p, "\nInstance id:%d\n", xcc_id);
> +		for (i = 0; i < reg_count; i++)
> +			drm_printf(p, "%-50s \t 0x%08x\n",
> +				   gc_reg_list_12_1[i].reg_name,
> +				   adev->gfx.ip_dump_core[xcc_offset + i]);
> +	}
> +
> +	/* print compute queue registers for all instances */
> +	if (!adev->gfx.ip_dump_compute_queues)
> +		return;
> +
> +	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
> +	drm_printf(p, "\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: %d\n",
> +		   num_xcc,
> +		   adev->gfx.mec.num_mec,
> +		   adev->gfx.mec.num_pipe_per_mec,
> +		   adev->gfx.mec.num_queue_per_pipe);
> +
> +	num_inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> +		adev->gfx.mec.num_queue_per_pipe;
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		xcc_offset = xcc_id * reg_count * num_inst;
> +		inst_offset = 0;
> +		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
> +			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +				for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
> +					drm_printf(p,
> +						   "\nxcc:%d mec:%d, pipe:%d, queue:%d\n",
> +						    xcc_id, i, j, k);
> +					for (reg = 0; reg < reg_count; reg++) {
> +						drm_printf(p,
> +							   "%-50s \t 0x%08x\n",
> +							   gc_cp_reg_list_12_1[reg].reg_name,
> +							   adev->gfx.ip_dump_compute_queues
> +							   [xcc_offset + inst_offset +
> +							    reg]);
> +					}
> +					inst_offset += reg_count;
> +				}
> +			}
> +		}
> +	}
> +}
> +
> +static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
> +{
> +	struct amdgpu_device *adev = ip_block->adev;
> +	uint32_t i, j, k;
> +	uint32_t num_xcc, reg, num_inst;
> +	uint32_t xcc_id, xcc_offset, inst_offset;
> +	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
> +
> +	if (!adev->gfx.ip_dump_core)
> +		return;
> +
> +	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
> +
> +	amdgpu_gfx_off_ctrl(adev, false);
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		xcc_offset = xcc_id * reg_count;
> +		for (i = 0; i < reg_count; i++)
> +			adev->gfx.ip_dump_core[xcc_offset + i] =
> +				RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_12_1[i],
> +								   GET_INST(GC, xcc_id)));
> +	}
> +	amdgpu_gfx_off_ctrl(adev, true);
> +
> +	/* dump compute queue registers for all instances */
> +	if (!adev->gfx.ip_dump_compute_queues)
> +		return;
> +
> +	num_inst = adev->gfx.mec.num_mec * adev->gfx.mec.num_pipe_per_mec *
> +		adev->gfx.mec.num_queue_per_pipe;
> +	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
> +	amdgpu_gfx_off_ctrl(adev, false);
> +	mutex_lock(&adev->srbm_mutex);
> +	for (xcc_id = 0; xcc_id < num_xcc; xcc_id++) {
> +		xcc_offset = xcc_id * reg_count * num_inst;
> +		inst_offset = 0;
> +		for (i = 0; i < adev->gfx.mec.num_mec; i++) {
> +			for (j = 0; j < adev->gfx.mec.num_pipe_per_mec; j++) {
> +				for (k = 0; k < adev->gfx.mec.num_queue_per_pipe; k++) {
> +					/* ME0 is for GFX so start from 1 for CP */
> +					soc_v1_0_grbm_select(adev, 1 + i, j, k, 0,
> +							     GET_INST(GC, xcc_id));
> +
> +					for (reg = 0; reg < reg_count; reg++) {
> +						adev->gfx.ip_dump_compute_queues
> +							[xcc_offset +
> +							 inst_offset + reg] =
> +							RREG32(SOC15_REG_ENTRY_OFFSET_INST(
> +								       gc_cp_reg_list_12_1[reg],
> +								       GET_INST(GC, xcc_id)));
> +					}
> +					inst_offset += reg_count;
> +				}
> +			}
> +		}
> +	}
> +	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
> +	mutex_unlock(&adev->srbm_mutex);
> +	amdgpu_gfx_off_ctrl(adev, true);
> +}
> +
>   static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>   {
>   	uint16_t major_ver, minor_ver;
> @@ -1286,6 +1556,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
>   	if (r)
>   		return r;
>   
> +	gfx_v12_1_alloc_ip_dump(adev);
> +
>   	mutex_init(&adev->gfx.mec.reset_mutex);
>   
>   	return 0;
> @@ -1325,6 +1597,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
>   	gfx_v12_1_free_microcode(adev);
>   	amdgpu_gfx_sysfs_fini(adev);
>   
> +	kfree(adev->gfx.ip_dump_core);
> +	kfree(adev->gfx.ip_dump_compute_queues);
> +
>   	return 0;
>   }
>   
> @@ -3914,6 +4189,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
>   	.set_clockgating_state = gfx_v12_1_set_clockgating_state,
>   	.set_powergating_state = gfx_v12_1_set_powergating_state,
>   	.get_clockgating_state = gfx_v12_1_get_clockgating_state,
> +	.dump_ip_state = gfx_v12_1_ip_dump,
> +	.print_ip_state = gfx_v12_1_ip_print,
>   };
>   
>   static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
--------------vn8UrY0ErjwCgXRf4ZWo0ZMH
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><font face="monospace">Please do&nbsp;</font><font face="monospace">before
        pushing:</font></p>
    <p><font face="monospace">s/gx12.1/gfx12.1 in the patch headline&nbsp;</font></p>
    <p><font face="monospace">Regards,</font></p>
    <p><font face="monospace">Mukul</font></p>
    <div class="moz-cite-prefix">On 7/7/2026 2:00 PM, Alex Deucher
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260707180021.2642432-5-alexander.deucher@amd.com">
      <pre wrap="" class="moz-quote-pre">Add support for dumping IP register state.

v2: fixes suggested by Mukul

Signed-off-by: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com">&lt;alexander.deucher@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 277 +++++++++++++++++++++++++
 1 file changed, 277 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 408fd23c6bd43..1d09f1771dde3 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -69,6 +69,127 @@ MODULE_FIRMWARE(&quot;amdgpu/gc_12_1_0_rlc_1.bin&quot;);
 	 (SH_MEM_ALIGNMENT_MODE_UNALIGNED_GFX12_1_0 &lt;&lt; SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT) | \
 	 (3 &lt;&lt; SH_MEM_CONFIG__INITIAL_INST_PREFETCH__SHIFT))
 
+
+static const struct amdgpu_hwip_reg_entry gc_reg_list_12_1[] = {
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS3),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_STALLED_STAT3),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STALLED_STAT1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_BUSY_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_BUSY_STAT2),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPF_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_HPD_STATUS0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_RB0_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_CMD_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB1_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_IB2_BUFSZ),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPF_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPC_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCPG_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regIA_UTCL1_STATUS_2),
+	SOC15_REG_ENTRY_STR(GC, 0, regPA_CL_CNTL_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regRMI_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQC_CACHES),
+	SOC15_REG_ENTRY_STR(GC, 0, regSQG_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regWD_UTCL1_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_LO32),
+	SOC15_REG_ENTRY_STR(GC, 0, regGCVM_L2_PROTECTION_FAULT_STATUS_HI32),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_DEBUG),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_CNTL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_ME_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_PFP_INSTR_PNTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_CPC_STATUS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR0),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_GFX_RS64_INSTR_PNTR1),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_RS64_INSTR_PNTR),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MES_HEADER_DUMP),
+	/* SE status registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE0),
+	SOC15_REG_ENTRY_STR(GC, 0, regGRBM_STATUS_SE1),
+};
+
+static const struct amdgpu_hwip_reg_entry gc_cp_reg_list_12_1[] = {
+	/* compute registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_VMID),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PERSISTENT_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PIPE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUEUE_PRIORITY),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_QUANTUM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_BASE_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_POLL_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_DOORBELL_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_IB_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_REQUEST),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_RPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_EVENTS),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_BASE_ADDR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_CONTROL),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CNTL_STACK_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_WG_STATE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_CTX_SAVE_SIZE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_GDS_RESOURCE_STATE),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_ERROR),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_EOP_WPTR_MEM),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_LO),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_PQ_WPTR_HI),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_CNTL_STACK_DW_CNT),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_SUSPEND_WG_STATE_OFFSET),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_HQD_DEQUEUE_STATUS),
+	/* cp header registers */
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+	SOC15_REG_ENTRY_STR(GC, 0, regCP_MEC_ME1_HEADER_DUMP),
+};
+
 static void gfx_v12_1_xcc_disable_gpa_mode(struct amdgpu_device *adev, int xcc_id);
 static void gfx_v12_1_set_ring_funcs(struct amdgpu_device *adev);
 static void gfx_v12_1_set_irq_funcs(struct amdgpu_device *adev);
@@ -1148,6 +1269,155 @@ static int gfx_v12_1_rlc_backdoor_autoload_enable(struct amdgpu_device *adev)
 	return 0;
 }
 
+static void gfx_v12_1_alloc_ip_dump(struct amdgpu_device *adev)
+{
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+	uint32_t *ptr, inst, num_xcc;
+
+	num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+
+	ptr = kcalloc(reg_count * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr) {
+		DRM_ERROR(&quot;Failed to allocate memory for GFX IP Dump\n&quot;);
+		adev-&gt;gfx.ip_dump_core = NULL;
+	} else {
+		adev-&gt;gfx.ip_dump_core = ptr;
+	}
+
+	/* Allocate memory for compute queue registers for all the instances */
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+	inst = adev-&gt;gfx.mec.num_mec * adev-&gt;gfx.mec.num_pipe_per_mec *
+		adev-&gt;gfx.mec.num_queue_per_pipe;
+
+	ptr = kcalloc(reg_count * inst * num_xcc, sizeof(uint32_t), GFP_KERNEL);
+	if (!ptr) {
+		DRM_ERROR(&quot;Failed to allocate memory for Compute Queues IP Dump\n&quot;);
+		adev-&gt;gfx.ip_dump_compute_queues = NULL;
+	} else {
+		adev-&gt;gfx.ip_dump_compute_queues = ptr;
+	}
+}
+
+static void gfx_v12_1_ip_print(struct amdgpu_ip_block *ip_block,
+			       struct drm_printer *p)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	uint32_t i, j, k;
+	uint32_t xcc_id, xcc_offset, inst_offset;
+	uint32_t num_xcc, reg, num_inst;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+
+	if (!adev-&gt;gfx.ip_dump_core)
+		return;
+
+	num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+	drm_printf(p, &quot;Number of Instances:%d\n&quot;, num_xcc);
+	for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+		xcc_offset = xcc_id * reg_count;
+		drm_printf(p, &quot;\nInstance id:%d\n&quot;, xcc_id);
+		for (i = 0; i &lt; reg_count; i++)
+			drm_printf(p, &quot;%-50s \t 0x%08x\n&quot;,
+				   gc_reg_list_12_1[i].reg_name,
+				   adev-&gt;gfx.ip_dump_core[xcc_offset + i]);
+	}
+
+	/* print compute queue registers for all instances */
+	if (!adev-&gt;gfx.ip_dump_compute_queues)
+		return;
+
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+	drm_printf(p, &quot;\nnum_xcc: %d num_mec: %d num_pipe: %d num_queue: %d\n&quot;,
+		   num_xcc,
+		   adev-&gt;gfx.mec.num_mec,
+		   adev-&gt;gfx.mec.num_pipe_per_mec,
+		   adev-&gt;gfx.mec.num_queue_per_pipe);
+
+	num_inst = adev-&gt;gfx.mec.num_mec * adev-&gt;gfx.mec.num_pipe_per_mec *
+		adev-&gt;gfx.mec.num_queue_per_pipe;
+	for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+		xcc_offset = xcc_id * reg_count * num_inst;
+		inst_offset = 0;
+		for (i = 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {
+			for (j = 0; j &lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {
+				for (k = 0; k &lt; adev-&gt;gfx.mec.num_queue_per_pipe; k++) {
+					drm_printf(p,
+						   &quot;\nxcc:%d mec:%d, pipe:%d, queue:%d\n&quot;,
+						    xcc_id, i, j, k);
+					for (reg = 0; reg &lt; reg_count; reg++) {
+						drm_printf(p,
+							   &quot;%-50s \t 0x%08x\n&quot;,
+							   gc_cp_reg_list_12_1[reg].reg_name,
+							   adev-&gt;gfx.ip_dump_compute_queues
+							   [xcc_offset + inst_offset +
+							    reg]);
+					}
+					inst_offset += reg_count;
+				}
+			}
+		}
+	}
+}
+
+static void gfx_v12_1_ip_dump(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block-&gt;adev;
+	uint32_t i, j, k;
+	uint32_t num_xcc, reg, num_inst;
+	uint32_t xcc_id, xcc_offset, inst_offset;
+	uint32_t reg_count = ARRAY_SIZE(gc_reg_list_12_1);
+
+	if (!adev-&gt;gfx.ip_dump_core)
+		return;
+
+	num_xcc = NUM_XCC(adev-&gt;gfx.xcc_mask);
+
+	amdgpu_gfx_off_ctrl(adev, false);
+	for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+		xcc_offset = xcc_id * reg_count;
+		for (i = 0; i &lt; reg_count; i++)
+			adev-&gt;gfx.ip_dump_core[xcc_offset + i] =
+				RREG32(SOC15_REG_ENTRY_OFFSET_INST(gc_reg_list_12_1[i],
+								   GET_INST(GC, xcc_id)));
+	}
+	amdgpu_gfx_off_ctrl(adev, true);
+
+	/* dump compute queue registers for all instances */
+	if (!adev-&gt;gfx.ip_dump_compute_queues)
+		return;
+
+	num_inst = adev-&gt;gfx.mec.num_mec * adev-&gt;gfx.mec.num_pipe_per_mec *
+		adev-&gt;gfx.mec.num_queue_per_pipe;
+	reg_count = ARRAY_SIZE(gc_cp_reg_list_12_1);
+	amdgpu_gfx_off_ctrl(adev, false);
+	mutex_lock(&amp;adev-&gt;srbm_mutex);
+	for (xcc_id = 0; xcc_id &lt; num_xcc; xcc_id++) {
+		xcc_offset = xcc_id * reg_count * num_inst;
+		inst_offset = 0;
+		for (i = 0; i &lt; adev-&gt;gfx.mec.num_mec; i++) {
+			for (j = 0; j &lt; adev-&gt;gfx.mec.num_pipe_per_mec; j++) {
+				for (k = 0; k &lt; adev-&gt;gfx.mec.num_queue_per_pipe; k++) {
+					/* ME0 is for GFX so start from 1 for CP */
+					soc_v1_0_grbm_select(adev, 1 + i, j, k, 0,
+							     GET_INST(GC, xcc_id));
+
+					for (reg = 0; reg &lt; reg_count; reg++) {
+						adev-&gt;gfx.ip_dump_compute_queues
+							[xcc_offset +
+							 inst_offset + reg] =
+							RREG32(SOC15_REG_ENTRY_OFFSET_INST(
+								       gc_cp_reg_list_12_1[reg],
+								       GET_INST(GC, xcc_id)));
+					}
+					inst_offset += reg_count;
+				}
+			}
+		}
+	}
+	soc_v1_0_grbm_select(adev, 0, 0, 0, 0, 0);
+	mutex_unlock(&amp;adev-&gt;srbm_mutex);
+	amdgpu_gfx_off_ctrl(adev, true);
+}
+
 static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	uint16_t major_ver, minor_ver;
@@ -1286,6 +1556,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
+	gfx_v12_1_alloc_ip_dump(adev);
+
 	mutex_init(&amp;adev-&gt;gfx.mec.reset_mutex);
 
 	return 0;
@@ -1325,6 +1597,9 @@ static int gfx_v12_1_sw_fini(struct amdgpu_ip_block *ip_block)
 	gfx_v12_1_free_microcode(adev);
 	amdgpu_gfx_sysfs_fini(adev);
 
+	kfree(adev-&gt;gfx.ip_dump_core);
+	kfree(adev-&gt;gfx.ip_dump_compute_queues);
+
 	return 0;
 }
 
@@ -3914,6 +4189,8 @@ static const struct amd_ip_funcs gfx_v12_1_ip_funcs = {
 	.set_clockgating_state = gfx_v12_1_set_clockgating_state,
 	.set_powergating_state = gfx_v12_1_set_powergating_state,
 	.get_clockgating_state = gfx_v12_1_get_clockgating_state,
+	.dump_ip_state = gfx_v12_1_ip_dump,
+	.print_ip_state = gfx_v12_1_ip_print,
 };
 
 static const struct amdgpu_ring_funcs gfx_v12_1_ring_funcs_compute = {
</pre>
    </blockquote>
  </body>
</html>

--------------vn8UrY0ErjwCgXRf4ZWo0ZMH--
