Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4716A107BCD0
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 18:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D302710E0C3;
	Fri, 13 Mar 2026 18:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UA8X8fUe";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011002.outbound.protection.outlook.com [52.101.57.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A23110E0C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 18:26:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3Os+Fpz3zxLBgDfBYa5P+A6qAuqGSxlCK0gWGN+ehAGCp/tUKrmhMX761UKlA/BvBFpLeb6ATTVp+N2YlwGmDtI/kBlXiOYF6sTTzt6rJ2cf+6sJY7Z6FG7ZaSphXIEy7h0yusrTpazrO2oZRczE93zTgxwsqdR+LBHC9V/YoETJEWnRip8toW4tbivVmjmE+3POJ6PPDorRzLhlJxiR1UM3s9mtU/U6LgOJjmLQBJTCmiS7sfgB6vRamBI0vYgTf/sa0Jk1R9/afMyylrPlg6SkCmPx/yR0+9ynSvXEtdFYb1ZqtYyAkFUVAS71SpLmn3fEPHHihmBGuIErp4jmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1XhURQjnAaTu9m+ZoGObpNikGOETDp1szmlTPxqtG7M=;
 b=C6GJVb5Bf+tEEyobGpvoG5rDs9hwyuqepWg4fOWXlNrWRnekxnP4JF2cUYJxuY6+xaBMjCrseqzjx7vYESLrb592UWTCHjF0GcRuOsVPSASlFbiDaKnzxAAQ6dqp93o2AfeMbB2Z4whQAX68UmzUY3Gtjnnr2wFcZVm4AUPfCkmDRosyfUkH9Xiw/NvUtXufc4C4YALLu2E0Ko3XavkeFR9Pj5AapctuMjxoz9aPu+iiETFHrEljP4kj0D+mI856UCqDWK1cR59eRiu0N9wQMi1Xy8L30NnTsHUHA4ZgcvOpTGT7l4MiKp6WGRyEwXM2ed9OuiHSn/GqnhD0bwK8Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1XhURQjnAaTu9m+ZoGObpNikGOETDp1szmlTPxqtG7M=;
 b=UA8X8fUeQ/wzm4J6Vg23Ske3CD4xjkp6RkJRnD54q4vtqmtjImpl0Ho7lQbgXQ3SsAaEntMGwkccdOrpFv6ZuLksSGgYiUV/l0z66QGJ1w6ng5VhVz23e4tQ0KKyklKiKkIB7yavJ/A1UOBrWjrbu6zZwMrOlnMk8Gx4/3mPyJU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by CH3PR12MB8934.namprd12.prod.outlook.com (2603:10b6:610:17a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Fri, 13 Mar
 2026 18:26:52 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9723.004; Fri, 13 Mar 2026
 18:26:51 +0000
Message-ID: <24f2f2df-d84c-4da5-9bd8-4438e7fb3081@amd.com>
Date: Fri, 13 Mar 2026 12:26:50 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/atomfirmware: Add LpDDR5x and new fields for
 info v2_3
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Roman.Li@amd.com, Alexander.Deucher@amd.com
References: <20260313182241.171036-1-sunpeng.li@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260313182241.171036-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0196.namprd04.prod.outlook.com
 (2603:10b6:303:86::21) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|CH3PR12MB8934:EE_
X-MS-Office365-Filtering-Correlation-Id: cd09e46a-1f26-44e7-082c-08de812e18ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: h1SBSnm5l0N7hL07j/DnS7+pFa4Mu3K2kdAEeIVt/nzDYgmXblUO0jPGxGOWvsXRZpf2sGuBxC4RYPXkj2/8tGbnr0qSg+sqwPRYoRIv18nefc1bCs/ndnwciswNOM4t8P5ZqJCJAklW65joQJWOzYbE89obCyw23aLbdZAsK9+BUteSf76fXeylz6lwv0gzHPmc5KYDPGINrex+GjH1bql7z1JedzstdoAKW/hFBOLuo1eVOx+WV7Z8nC2pOxnyZoU5Nb8W2uwkqnpHQGfPlRhAN99Mw6BwZx0oYrHoLj+cwnwhf+EebgXiqBwwck0Mi/ZxgCuvE9epvSLUt2QbPUu7yiTfbfocW6+T6gEfFTsb3mDKThCZuGKzsd+THEmGLn1tXrPyYWpjO+IeVXclvN2J2BYWiFwiIiKDo97p1sx5ajenaxrNwJ4Xm68KOUIdvF5jJVqRF8tyaEwuRN5JAOVW4C0Kf3/Try6r9UtmG55g3iMRAy3so6u/gVO3tnmFeZxp4C9QFgqZdwFJaLeFk1SBaodk9S8ALqwqDqGVGhraK6sRc48ZxX/0aAywcQ8MXJ50/rlyPIKQeiEK9h8fhn+7WRLJV93FKAZWSI4mtvAl9F74HdM5czhQ383wtK5c6WdMNeBiyxVm8R8nz57/KgdlSpfUG2TaHaGdqtmD71AxGFgY/6FxV5RGDA8Qo++xSH8U4tuYkZPwv5d3SrxnhZKJuTkrRcNm2izNjB7cdbs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WUl1SE1oOERiTktMYTNQMllpRFQ2UDVCcy92bTYrN0cvang4eFVyUUUyd2Vw?=
 =?utf-8?B?Y2IwNjZRM0hvNkVjN2ovWDZUd0NhdG1wY1FmbmUrQVdWSmxOTSt2K2pYS3kx?=
 =?utf-8?B?OWVUeTJTdStaVWpteGlCN0R1NUJJZHp3WWxlSkluM1g5eG1iOWREV2tBbVdp?=
 =?utf-8?B?a2QxVDlkcnBNZnZlNnJNdFREeE1LVDVYV3dyNXRCRkpScHJyUlNRczJTWUdh?=
 =?utf-8?B?MmRqR1VmMWgyMCtvbU53VVlEdXdqQXJ2YTNvVzBnZUpxajR0YVdkZk1HNEVZ?=
 =?utf-8?B?L1E4NDR5N2hKa3c5ZUxDQWpaRnZHcWdCTjIzaVJEcWJadjBsZzBQT2ZpLzRI?=
 =?utf-8?B?ZmpHcjJDQkJZVERXbHZlcTFxREFxMGlNQTAxWDk3KzdJbjFXemVVNVYyOWx2?=
 =?utf-8?B?Y2w4V0YzK0EyTHBsaVpMblVjWjlRcFFRODJtWWNuSFJOU2ljRkVpdnkxTDhi?=
 =?utf-8?B?N2Z2T3Y4dkpvSG1HNFc1RkhUeVJwMXUycTBSUVdzcStrY283YnJWeG4xUm9n?=
 =?utf-8?B?Ui9OWkZVUk1ScFVjKzRSVWVQbkJ5ODZLZlRTRjdrVDdnaFZQNkNHd29NTmRu?=
 =?utf-8?B?V3h3QU5WWE13UGZxcGFwOW1mZnltR1Fhdk9rZlhMWjBNU0FTZ1Vic2hVR1BV?=
 =?utf-8?B?REtZS3kwKzVNbEZvUll5djVWUkZpT0haTFVWYVR3Yk9SMzBnNW8rdzgwb2lQ?=
 =?utf-8?B?NzJla0p1WGVrU2dtRnhMemFYLzBJVGZ6RW5WcVlmZFZ1TUtadEVZMERURCtq?=
 =?utf-8?B?WE94TEJaVEdLT2tPOVVuSmZsazEyQ2JUTFlabU82YTVYY0g1U0VZeUpCUi9s?=
 =?utf-8?B?dHFxZ1Rjbk00TzFlTzNHWEZSb1p2ZXF1Z0FpQWVUTjcycjdZTktTTGJ6anFk?=
 =?utf-8?B?WTloeW1ndmQweGFZdXZXMi9Zdm8wc0JKRjJ2Qk9IU3JDaUJpOVg5VTRVa1VK?=
 =?utf-8?B?bHZvV0VxMWdDTXhwaXZSYXlKbHkvODVJT2RhVFBFdUlJeU1STEl6eUNtWFI1?=
 =?utf-8?B?MUlwWmZBY3VzT3hFSWZVZWRWNGw4QXZlcm9mMml0UUdsTmM3eHlLYjdoSWQ2?=
 =?utf-8?B?N1I2MCs5WEpOQXhlWHpKVEFacVViVSsvWlZsNVlnMkJmTVVwaWpERnNqS3JU?=
 =?utf-8?B?N2JyMlBLbFhpNkZpOVRvUTM5QkxzN2Jac1h0azA0ZFZaMFVzNGhaYk1YcGRR?=
 =?utf-8?B?cEUvblVFQW1lQk10aU1VS0oyRGVEYllPalVic1o1RSt5K1dTTzd4ejlIc2Nh?=
 =?utf-8?B?eXpER1o3SzMzUUgvcW8wbXNBUlVINXNlSVhteFNqcEtCM3B1SGYyb256cmNy?=
 =?utf-8?B?WUQxbjNHa0IzT2hPNWMrYXZReERQd01SUldqcW1mUEphVVFCeWNFK2pGdU1y?=
 =?utf-8?B?RUJCYkZrY25jZUZZK2hFdFEzTHJXUWlOOEliLy9pMUFObTRsU2ZMZlRmM0Ni?=
 =?utf-8?B?b3FZY2tOUjBDL0FmcXNWaFBqSERzdDZvVlZpMllPaVFPUUozZ0Y2UE0ydWdS?=
 =?utf-8?B?V2RPVFRVL3ZYRDlqdzlVV3NLcUg2ckxyQURSdVhEZ1RTY3g4R2N3ZEEveFp0?=
 =?utf-8?B?S3ZwZlRjVHlEZFFEVVR5L3lDcElUQ0cyTWlZK1RSYVc0ZWlCK0VyazhJeWxE?=
 =?utf-8?B?VW5zNUVGWTJnc0ttY0VmMnMzWVNvZmdwOXZFcGc1WHdqc1UreHRkMkltSkNL?=
 =?utf-8?B?cDZjRThWNmYzR2I5a3gxeElwK1V5dHBKYnBXRXllb2FPTndtRGNlYjBTMVNm?=
 =?utf-8?B?QlJvSXdIVnpEdS82RHV6L1RidUkreE1Lb3JSWWpEZ1JGQll4eW4waE4rWXNr?=
 =?utf-8?B?TmZGWVVCQ2swU2tDenZxUjh2U3hBTnRmS1diQm9aMStxZFJySG9PanVlZlVT?=
 =?utf-8?B?Zm04aEErNEhlR1NSRUtnYzlLQmpiZmpKQVoyTjZFMS9QaldqNkpwZEhDcFZS?=
 =?utf-8?B?aWtzekRPekJyaG8xK3ZpNStXZ0l5S3RCYy8yUUlDajArdkZvWVpodmlhblgv?=
 =?utf-8?B?cGF4ZHM1aFZzUEJDRy9kQk9pS0NlbmNhTENldTdudmErNGptUGlBekNKcFNX?=
 =?utf-8?B?eHEyczdSaEdUL1FiK0JRWG9kRnIzUFErZThpTEt6alFZSjlhckVIeW92Ujk3?=
 =?utf-8?B?TExQTDhNa2MvczlFS1RKdEwwNDlKb0RyKzZHRlR3VERDN2Rka0tpZ0Z1YWhP?=
 =?utf-8?B?ZlkvYzVNTmRkMDFSTlZUZFprN2NVUDRLK2V0dzFDZGlxbVdVeFNVRGF0R3JW?=
 =?utf-8?B?Z244aWkwVW1VMDJ6Qy9YYkV1UzJocWtKRXRCQXFYRFZtc0VqaTQ2dVdOc0Ra?=
 =?utf-8?B?RnpCUEoyczNrNG5jSXVDWjAxeGhGaFlWTHJpMTBhWHBuQ0xPcFBUUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd09e46a-1f26-44e7-082c-08de812e18ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 18:26:51.7443 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtiUexZ9PNNA716aOkj133+AD89zJAwL+oT3BLb5uR4mb8+YoyepKr2w42adY1lJRmIqdqxMqTvLaLSayZmIdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8934
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

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/13/26 12:22, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> Newer DCN bandwidth calculations require new definitions.
> 
> [How]
> 
> Add new fields cpu_id and vram_bit_width for
> atom_integrated_system_info_v2_3, and add a memtype for LpDDR5x.
> 
> Signed-off-by: Leo Li <sunpeng.li@amd.com>
> ---
>   drivers/gpu/drm/amd/include/atomfirmware.h | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm/amd/include/atomfirmware.h
> index 18f9642a42eed..62f7ed0b20667 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -1695,7 +1695,9 @@ struct atom_integrated_system_info_v2_3 {
>     uint8_t gpu_package_id;
>     struct  edp_info_table  edp1_info;
>     struct  edp_info_table  edp2_info;
> -  uint32_t  reserved2[8];
> +  uint32_t cpuid;
> +  uint32_t vram_bit_width;
> +  uint32_t reserved2[6];
>     struct  atom_external_display_connection_info extdispconninfo;
>     uint8_t UMACarveoutVersion;
>     uint8_t UMACarveoutIndexMax;
> @@ -1770,6 +1772,7 @@ enum atom_dmi_t17_mem_type_def{
>     Hbm2MemType,                                          ///< Assign 33 to HBM2
>     Ddr5MemType,                                          ///< Assign 34 to DDR5
>     LpDdr5MemType,                                        ///< Assign 35 to LPDDR5
> +  LpDdr5xMemType,                                       ///< Assign 36 to LPDDR5x
>   };
>   
>   

