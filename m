Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A25D41C27
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Nov 2024 09:44:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6253910E0B0;
	Wed, 13 Nov 2024 09:44:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0vlrV4Gz";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B53C410E0B0
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Nov 2024 09:44:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BL7hT8HRAJ1X1fU/Nx0GHESWsnPZmu2QstcYLG3D71Nf81CmDxzBPyykvgUg8dAM0Hzj1phGoqLItg7VWWUeODl6UGkUwC4Nf3W2LIvicDlmRLMv5thQUznGmYl+poFf3WZ/uoGfxcgMOpGvlrkRjwl7bK5YquU78Yqlps+Ot+mUpUmZIqloKrQAUofyN8kgqEMHc4mGJ3DNneH3oY3xXnN6KEGUYR6runkpB3J1H49i6RGieWwK3+umlZu9eOvwSB8r9zIxohIxje4g7UCUx4BMs4zJxUeu/7IkpjuyYp6P2rd3o0301tEKytl624Uz0pp1QjA7IzZ9c9HG/7QhtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R1ptVHS1lpvHaXo9jpjyOYkl0LJ6N4HOY2Ci7H5fP7o=;
 b=Gk1JwxAoZaHxwlE7a34YR0RJG0DHDzMZap8YLorgb/IYAVQ46PVtJsGcpfgtj2zKMlofx61AxarW3FjeV0TqOPJxLEfrgWiXI3ZmGcZXePsts7gboI18/2JZ2iBL2Ew0w6ntqTap2siL/e5TyMkHyRGI3N1erM3dwOxtN3n87zaNxFlsH9pGP5eBiIQZ//zLe8n/xpNvawx15rB/LMGGT+lkKV3w/Bgm6GSb08RM8LeMMg8DEGR7S/FpdWj/Q27F5nst4f4otlSX40TxE18J+9FCZ9LFlDp9wzagnGSJBA0RPPw9RZOmIvFgIxbJe/ay2TI2YvSxMWU0vAGQ0sGTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1ptVHS1lpvHaXo9jpjyOYkl0LJ6N4HOY2Ci7H5fP7o=;
 b=0vlrV4Gz5VorKUuhdbre60aK3AKb/xtGoBWAR2oNrS3YZaCdcKnv+5hAeBfTb0clI66BxdVbRsqtEDWgfOgl0kBm2xlCKxO2ORwBB4Mr3OaFU2LYlaOuCU9B+g86D+QBbiNoKQVH26DRJSFdRXdscGfnKr/MKOYsE+UwTvCMlxc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 MN0PR12MB5809.namprd12.prod.outlook.com (2603:10b6:208:375::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.28; Wed, 13 Nov 2024 09:44:36 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::8327:d71a:ce21:a290%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 09:44:35 +0000
Message-ID: <988aaf4e-57f6-46b8-bbb2-5005d567ba88@amd.com>
Date: Wed, 13 Nov 2024 15:14:26 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/pm: Update data types used for uapi i/f
To: Asad Kamal <asad.kamal@amd.com>, amd-gfx@lists.freedesktop.org,
 kevinyang.wang@amd.com, hawking.zhang@amd.com
Cc: le.ma@amd.com, shiwu.zhang@amd.com, charis.poag@amd.com,
 donald.cheung@amd.com, sepehr.khatir@amd.com, daniel.oliveira@amd.com
References: <20241113093043.1313004-1-asad.kamal@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20241113093043.1313004-1-asad.kamal@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0168.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::8) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|MN0PR12MB5809:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ad30fd-7eeb-44ad-af5d-08dd03c7c879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ODIzbkR2cU00N1FsMGxGbGlOcXd3d2xRMGQvbFg2ZGcvbU44UXdRei9nUSsx?=
 =?utf-8?B?Rk9zWnR5NzNEQVNGbHlSdkZHR29BSWhiWFdPMHJKTDJEVTY0UFZDTFZJeTdK?=
 =?utf-8?B?R25yK2tRejlCUHErQXdmdW9FRUNlVHI2Y1dITTVNcGxiZW0reE1wR1RHRVcv?=
 =?utf-8?B?c2tEcGRyVXlCTk8xdlR5eStLYURQdENJN0RKVDI2VnJLOUNWY290RWlBNThy?=
 =?utf-8?B?YXNvcmx3OGpYaklIcEtCL0NobWluMHNGZHJ3aklmZFdlQ25qcVMrdC9YZlIz?=
 =?utf-8?B?eFdJQm5LMkdRdThsK25QYjUwU29vaDNoMHd1bWNHZW82Vm1uQm1XRld6MDdt?=
 =?utf-8?B?bFhaZlFOQWUwS2RYQTdpcnZMcVd4SS8xY0ZqWmhPWUxYcjBZWjd0ZlpTQzVl?=
 =?utf-8?B?UkxEOUFyWHFqelUyek1nRmx4VVRhVktvekIzR24vdGNZRXY3NzQ4RTZjcmdw?=
 =?utf-8?B?bkN0Z2l6UTJVaUg2OU5zTEt1SEpuWitjSVQ4UXNwazl3a1hacDFxMTJmZDhX?=
 =?utf-8?B?ZHdlN0h0MWo1OEpiMlRTbzdvcjQ1UTY0dFlGOHJvaTd1Qnc3eTczOXFvb2Zt?=
 =?utf-8?B?c2JpRVd0ZDJUcVBMYzlKb0s5SFpUS1Yvb2lqcFk0UDVkU011aXRNaTdHaG5K?=
 =?utf-8?B?Z1ZLbk9TTHFlajZSTHJwRk5VQmpYbVVPWXlYS3M4Sk9qTUNkaG10RERPZDNm?=
 =?utf-8?B?cUpQb0RvZldRR0NESHFob3pIMG1kRFFZc0VOZmE2U0UwQmN1YndSeE5xOGR5?=
 =?utf-8?B?RmlraVV5OUx4TnlsVEY3N1hTdWdKTS9qajdyTHdmc0xSVzc0ZGZRSG9xSjRq?=
 =?utf-8?B?M2xhSXV2YWZMSCtCcVlFYU1nQ3ZDOEFhN1pwSXBib0tZWVBYOFRGbVRySmRv?=
 =?utf-8?B?OExqWkpsblV6cjZqN1RJWE1odGhmenhjWTE0TW5zd3NnQnFSWTY2QVdGZXla?=
 =?utf-8?B?Q2ZzMEJIcndmZEwrMkJZbWRlYmhrSlBTSFF4OU9QMkVwWllOKzRNYjNiaFU3?=
 =?utf-8?B?bTB5N2F0d3FCQm5VNFBiMlFsQlJpWVhQZXNqYXEyUDN4c1RUMVQ3dk41dktF?=
 =?utf-8?B?cmFmY05rMjI2TzdHWXRkQ21WQVpMRm1ud2lMQTd0ai9mblFsZk81WEJLc1JP?=
 =?utf-8?B?NEVSczExN1dhcEc2RTdvV1RsUzZXenliWGNpMjExMHNsYWpySjRsUkhSNkVW?=
 =?utf-8?B?N0lGZkd5elZySkZMOSs0dTR5QU1qc1VINlp0UEQ0c1YwNndRK094YmRLS2ln?=
 =?utf-8?B?cUI0M21iMTRMbWN5YlZZZHM0RFB2b2FDbG91aUhlRG9HeXI0bFZnemRFRDlm?=
 =?utf-8?B?RGplY1kzL3h2S3FqZXUxTlVNZXRRSkhQRUN4Ryt1SjFVQUxFQnViWnNCd1FF?=
 =?utf-8?B?QmRodEpxcGlkUGtaWVhyT2wzMFF2cEgyYisyUGRUTk1TVjIxOTRsenZJR05o?=
 =?utf-8?B?Z3lVYS9vY1dzR0JnS3lFNk9Kenh2TTRaZjZPYk8zUndVMklJd2MxUHZDV0x3?=
 =?utf-8?B?dXVOYkdZcmtBSzA0bUNyQnlMVjcxVnpjV2J3bEpKcUZOTm12Zzk2NVE0K05Z?=
 =?utf-8?B?WitobU5lK3ZZSUJDYUl3VFp6bm4rNFBKUFlTa3NxMTJKdFZaNGx4cEZidC9T?=
 =?utf-8?B?aXVhZEhzTHpIamt0MkI1VGtxQlMxeWNhQStIZHo4c2Ezb0pFelFKVi85Z2cy?=
 =?utf-8?B?SHNWUmhpM0hoRXdwVXZSNnhHajVldWFOaUtLN0h1ZVdhQkJjS21UVW5KYlB4?=
 =?utf-8?Q?OFNkJV5xr27YBnuMjy2NuBulHw3r+5hNcDCUFtY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTg5c1d3d0paT1BQaUV1NnllTzl3c251RldKVzRoRmtmTWY1bUo0bWVaR1lF?=
 =?utf-8?B?dTF3M2l4c3FodDB1U1JzM0krcWFxaWdGM0dhTldna201dkcyVE9QclUvWm9x?=
 =?utf-8?B?MzU5Z3lEeXpjYmo0YUx1YzVEWVRldXVmaDlzWXJjbGU3aFIzejJ4Y2o0bGow?=
 =?utf-8?B?YjA3TTMrSzlhSmg4UXhqazZaUzdOS1JFR25rRXhxT0h0Ly9kZ2FvQTVobUU1?=
 =?utf-8?B?Ukw2enNPTzlGT2JhZjNWVjMxdWxqcUxVcEd6R01BdjRLS2JVSTJ1aTQzTkVB?=
 =?utf-8?B?ZnoxUExFc1VZai8wNHRnWVFYMXYrb0RPeEZTNDZNNXVlcHhlaE5FMnZUbFdO?=
 =?utf-8?B?RXR1UzZQVlcrTWlnVEZ0cGN6Q2JHZ2x1YUhub1EwQ0ozZHhCVGlmU2pCU1lY?=
 =?utf-8?B?UkFhME1XeE1adkV4OG8zQm8rOHVDSkdtZW5TNVByZXlEd21NbUFzYnY5SUVE?=
 =?utf-8?B?eDVISmVQdEk2akw4N2MxdnYzK3pURk9hWVk3RzJmRElGTFQwM1BWMG5UQVZE?=
 =?utf-8?B?UHlvdTlac08ySXJRamRSeGRMUmc1UmhycmdUeDBkNFMydmoxUkFPUVNndHd6?=
 =?utf-8?B?RXFsUmFYdS9jaVJRWEMrbEtnb2J5SzdmT1hhVTluREplRXk5NFhHbUlSZ3VO?=
 =?utf-8?B?cDZZS0pHMDdWbC9KUThJY2VCNnh2aEwrTG5sNjZDQUV2UmRnbHY1SXFTVGNT?=
 =?utf-8?B?amp6ZHRDUm01b0ZDdjgzTTIzQ1J2UDZCTm9KQzVxLzhYcFpvWlJNQmdDeGlO?=
 =?utf-8?B?Mm5kN3BPT0tWRktZbUtBV25oaGhqc2hyZVYxQUpnYVE5MmdpSlZWVlNuQjZD?=
 =?utf-8?B?cUNFQ0pXMndrZ0pMN2tRUVJOQTdHNm5HNThZUlNzUnFISXhoc0NhaWFMK25x?=
 =?utf-8?B?L0JBZzM5K1NMaXhnTnd1OHdPa2Njdkk5eXYyWUlNMjlaNFZ0MSs2S1RteWtL?=
 =?utf-8?B?U2lWUVdJRXZmTkd6L3FrWWM4UEx4dWRRb2VYekt1UWRHWW9xTkIvSUFxNldS?=
 =?utf-8?B?M3Rnd0pBcXJBNUxYd0UxbHlJaWt4b01XamlaREFuWTEyOXY1TDZtM3RWSTZ1?=
 =?utf-8?B?dHZXRzRtb1N5cGlPOWNSNGhwOGg4Y0Q2cCtlVzFOajZMOWhGUVZCNFlHSmdJ?=
 =?utf-8?B?UGdkQ1BJQm0yNGY0L0FnSG43NnJGLy8xWkZ1OFVmZHhtang2OXVWRi9wcnVs?=
 =?utf-8?B?S2FQQWxmdnlYamFIT3lPaWV6L21WYm9BVnBPWS9BbnhVZ3FhQjZJVHVCWFhU?=
 =?utf-8?B?elVaWHlsQTZqMEpzcmIvT3hJK2VXc3B5T3B4cmVnd01Fd2t4eE1FVlk1NWxQ?=
 =?utf-8?B?RFBHZUZBdCs5ai9sOG5aNkRTK2pUKzl6UW1GUHZ6VEhwRzdwYmxLRzByMGFo?=
 =?utf-8?B?Z1JCWGVWeHp2d2pxYzRyakZiR21iWTMvbzIvTkRGT1UySENMTFJqV2RYQ2VR?=
 =?utf-8?B?L2hhc1c4eVJjcEhJL2liWHN4SlhaUnJIaW9LTlNkdjdCNFVkNSs5MkZxb2w1?=
 =?utf-8?B?K2VsY0l3ZXhkVk55eUVEaFEzdkUwSjJsSnBGZnY4cVZkbG5kTTVLMXZrK0pB?=
 =?utf-8?B?bzJacFVJREhlemZBRUQyQm5PMXRCN1N1aUZGd2pVY1ZneXgrMTc3YmtBWU8v?=
 =?utf-8?B?Y09BNVZhSUUya1JGYTl5NTVSamFsV0VNMndFd3hNbnVvVmN1TXpncG5rT0hm?=
 =?utf-8?B?ZTJxK1hyTU5GR253bGo5NDkvRFdSaGVNWExOcCtaLzFMcmZYd2t4STdUbXdv?=
 =?utf-8?B?TDhJcHdvb0sxR0xRdmM2ZDlGRUFBa3hvRW9iQXNKT1RYWHd5ZUNWVjV1c3pU?=
 =?utf-8?B?dERsUjF0NFZqRi9jYTZvT3V2b2pCVlBwRUtuU2h3ZXhIRk9QTWFvb2pFZytD?=
 =?utf-8?B?alJlR0xkaVRrcERLRCtQZFRRb1ZsR21ZNnVKVWREWSt1cGFRY1ZRZ3RWQlpw?=
 =?utf-8?B?UTJ4SmdxaGpEVzBiRytIVWdzbDluSVcya0dhZ2ZPSHlmVk9ZbmlHY2hyWm9a?=
 =?utf-8?B?WXdsZ09wQVE2SUlmaWYrSmlsaGRVMFdzU0VGNUJobVRxdmNoMDFZdnEzd1Nt?=
 =?utf-8?B?Z2NmSlA4Y3BheGl6dmRDbUw1OHRIZEtSeXAxTmRyRTJFZDJEOWUzaTQ4YnI5?=
 =?utf-8?Q?wXJn5ebL5VpUoeEE/CurioD6p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ad30fd-7eeb-44ad-af5d-08dd03c7c879
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 09:44:35.6742 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Du68lhlinCypgEDq5HyzytuEipea79RUSCJ96n7E/Ma3ZVV/HWapJiqQbQKMCepX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5809
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



On 11/13/2024 3:00 PM, Asad Kamal wrote:
> Update member's data type in amdgpu_xcp_metrics from linux specific
> to the ones compatible to uapi interface
> 
> Fixes: 155fa7ced39b ("drm/amd/pm: Add gpu_metrics_v1_6")
> 
> Signed-off-by: Asad Kamal <asad.kamal@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>  drivers/gpu/drm/amd/include/kgd_pp_interface.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index ee8170cda1d7..80f7afc5c959 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -357,11 +357,11 @@ struct dpm_clocks;
>  
>  struct amdgpu_xcp_metrics {
>  	/* Utilization Instantaneous (%) */
> -	u32 gfx_busy_inst[MAX_XCC];
> -	u16 jpeg_busy[NUM_JPEG_ENG];
> -	u16 vcn_busy[NUM_VCN];
> +	uint32_t gfx_busy_inst[MAX_XCC];
> +	uint16_t jpeg_busy[NUM_JPEG_ENG];
> +	uint16_t vcn_busy[NUM_VCN];
>  	/* Utilization Accumulated (%) */
> -	u64 gfx_busy_acc[MAX_XCC];
> +	uint64_t gfx_busy_acc[MAX_XCC];
>  };
>  
>  struct amd_pm_funcs {
