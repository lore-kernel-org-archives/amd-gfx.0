Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA814CCF2DE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 14:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46D2610ED39;
	Mon, 19 Oct 2026 14:14:33 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA2C10ED4B
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 14:14:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RWDARacKal3j6vzi+Z37uD1b/bqb4ikuPb6TcR3JxblcyRVG1eLiTq8ejn6vDVYBBlLlRbGPz36/SecSzuo/pMLpYNTjXLgA87mzd1b5Usgq4SDzQbIsG6fFoPIdD0AZlisTAY6/yO80FHtdBuphM92k+17Sa6xT7ae2Gju0NPEAmegJTNRePzJErlqEHwNrFAK5iPdJY8lgf7q21q2ZZF8De73OqeeepkNP6wjaTKAwtCb+X+l0h47Jz37obUWJyiDniGsIAmXGilmHrH4zZVJdMjHyjvXu2F4ZO3WS0N2C4n/Ab+ybV3LhUpWbExRqHegypm6pPI2w/5fVWJqPMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AGhRwZd0vXfdKPUgnc+q5bBuRwI0jbzQ3brsD/GZf5U=;
 b=V7bcKpHq73H5/ykTYYsMaXHX5LfupOa5FcwGsa0u5FnuvdX3cfhlUUZ37FOH7zFZE8UcaNtww8neEM+3iaQ5cHCkErzv+5lWxUdtwUD68AtmaAFwOyn9EYjdyQBFasbWCR0zkeDS9KIHojbaDeJUg4YGb+wEyGQJjVQyBqkmmGmpPlAZwdENGTE+E8MKP52thT5Zl5jjDzeUWq5cVYlk6PgXdKruE29SV4KJYBMc6vPbnS40ySPR6VUackwAlaRUMGr4rGVTJYynCLkU9f9AT7IqrWEplxww75e6L5FO38fKZ49rzYo4Tz3JSKQNEZJv3E+B5x6fuUGXeYUtMv4e9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AGhRwZd0vXfdKPUgnc+q5bBuRwI0jbzQ3brsD/GZf5U=;
 b=tlL4I6sM7qDV8+dmCatVajiMAAxc3+05wAqmkGWFtzFPEJ58xtnTlhq0qotdgPhM/H5CR5nR3swfxKcoQvHngZO5UaO5AOAuxPxBmJE3xQU5lgvEdSbhZOKfD4wo48mzazrYqRaJ5yXwM7xZdiGL0iR6yJ/+6AZRCm3ptfvdgNk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHAPR12MB999224.namprd12.prod.outlook.com (2603:10b6:610:302::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:14:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:14:23 +0000
Message-ID: <ea34abe3-0d4e-4754-ae81-e9e46c0be86d@amd.com>
Date: Mon, 19 Oct 2026 16:14:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: keep PRT mappings off the VM state lists again
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Prike Liang <prike.liang@amd.com>,
 Sunil Khatri <sunil.khatri@amd.com>
References: <20261019014711.1486757-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019014711.1486757-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0077.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHAPR12MB999224:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ec84101-8da6-44db-0d0e-08df2deb4650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: d1G4LowcDCiTequJABLvJnQjJChksY8u2hP9OLcxmTPYrYrvzJdygs5eFP/eG7P4DRFZPRUBQp4+4OnTEw5tDqoVyfoqYY2nQzE+Op+gySymvwJZBpa4XhDpGo7x6V0Wu6r/jDtGfSRQ238qIZrwmuQES5BJ3PbvaD+SZs5xm8hvIewJLoLflKbDJBAFfBNG5FIQOMtSHQUDbnGgzoRrjNfZqZ3YLDw9f30swWPAd3+ph6sqB8otkUjZAIMw+IxpAo/ebDnZe7jwzIj/GqK0dbn9JQ0sFQA+KBRno41rA3quX8d72y07k6djETuc+1MTw0PrtgB1nAExyoldyWTIE5EoZV1QI8tF8oAiC39XhICb4TbT/Sy9Cx/8gwxp4NVk6UTcG2H01ZkuOF1XpZUwPaaV3VSEuzh1tTBwwVhmA0LTO8zlKP0h1BmC9276M5sbnuWSsgBFP0l83VRqmIRLU3m4UtuocqbVpStrRU8D+KqQhwJwa1UVVSf3jfZi7989sSOT49/abo+feOB25QROCfP7jbbcFJxPGdR8d0K0JepVPbVPMgzTYBO7oJQe0fnOoQ+yQvLW1IY55unzu71KBI8FCaFcsy/tZwpvPeB+tkluRaKA6isZTHb38PW0tY+65WqipPi2UJqaYtDFapRy1e5gpKETxAc7U9tJOFj/B/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OS9YeXVxaDdscXpQVGlVaFRDbER2a2grbnByRFZ4ZllVT3F2M0pYeERabmIv?=
 =?utf-8?B?ZXZkMWN1MjF2NU5ycjNGdEdZL0UrTUhSQXpPSTJXalBYYW81TUI2NmtVZ3VY?=
 =?utf-8?B?TXJBWTF0dnFBZWo5RnkwRUpKWVM4bG83UUEyeGozelJubXBoRFdTbkhFSVFj?=
 =?utf-8?B?Q0twWi96RTJnVlV1cDlmTnpiUnovWWhoSE84V3NWZWFtYTlMdmNyV0pKUUdD?=
 =?utf-8?B?TWZ5NXB0YTBhdzMzWHQra1ZTSk1IWk94eTg0NEU0djFVNHZQWEh1MG9aMHZI?=
 =?utf-8?B?WW83Z2greW0rRjRtVVI0cWMyK21kRGZvaXp4eGtrWEJMVUI1MzQ3TGh0Z3N6?=
 =?utf-8?B?RThIVXVXdTNuR2xiQXhxSTAvL0FUWUFycDVabXRwaHJ3TTlRc29lWlFKUlBa?=
 =?utf-8?B?bkNsaFNBbzZWbVlEOHBTZ0FvSU1LTGJGRDliWHAwTjFLZW5tdFEwVWR4YklY?=
 =?utf-8?B?RmhpRUhhaWQydG9LUkw3eG5penA2Mmw0WjNDV2JPYzZLazFnN2hRN1ZZalp0?=
 =?utf-8?B?dGpSamczekpzOXV5WVBWT09lbUJnRHJCbDNLVzZqMWxibmYvekFaV3cvRTVD?=
 =?utf-8?B?M1lmZW1ROTJxY3BpYThYQitpL0hEcGNBQXpWY3p5SUw1Z1BucmhmUjhXQUpi?=
 =?utf-8?B?UXVveGF5N256SVZPWVdYUGZuQzR1dUZpaHliY3ByZGxMcG1uOUROVnozL2JK?=
 =?utf-8?B?RGRSYitwcFg3SlBuMHlHREtBUUFMWU9EaTVVeW1jeFRhZGFBbVpST0dxY2tN?=
 =?utf-8?B?ZHZFQWRDQlY4amhHZGdrek1MSHVwaUlDK2VZNGJJMDJxRmtaOGdPeEZCTGNp?=
 =?utf-8?B?d1krMUtzWkp1Y2hRTHFHRGVZZS9UN1UzaDkzaGRZOEh3UDk4M0xUeUs2L3pO?=
 =?utf-8?B?SkoreCsrKzdpVzlIaDNVc3N4dFpDYm8rN0hMdUkrRk5mcks4SUhYOE1nZ2gy?=
 =?utf-8?B?N2k2YjR1WmpqbzY4Sm5tcElrRm9ndDhpaEdGb25HSHlyMzhrakYvRzhKN01W?=
 =?utf-8?B?U3hBa2V5d0NCRHZLSjBUbFIzRGdSZnBvTWNvQklLYVJkRmdTLzlvTzU1Z2Iz?=
 =?utf-8?B?TVNNcTJJUzU3V0xKQ2owZDVzbksycW1iSTM4UCtaRmNJcUJWS3VyYzVsWDhY?=
 =?utf-8?B?UForS3d5dGlqd214RkZQc0wxTXVZWElPRE0rbEVsaWF5REg4R3l2Q2YwK3Bn?=
 =?utf-8?B?VzZYQmhhQTViT3QyRkhBTzduYjVHeVlhSXg4ZUhuZHZZV0FSMlJSeEVRZ3d5?=
 =?utf-8?B?dVJIdjI3UUpkVFBMQXJ1ZXFZZHU2cUdaTW1Hc0lnQjArTmhvZGV6Uk1NYXBz?=
 =?utf-8?B?QzRsRjZnVU84enJaWXVrNkV5cVhNb1RNVnZQbGJDOTBsUk1QS2Jkak1nbGZa?=
 =?utf-8?B?UVZRL1p2cGc1QXdHN296d1czRVAyeXhIN0lPSG9nR1MwS2IzQWZPM0FaUm1C?=
 =?utf-8?B?QzJMNXE3TnB1a2U5dzR6cFovWEtwWWIxT2NzaUhPYU9tc2FRLzErVUtRblZp?=
 =?utf-8?B?MGM1TzJkaXkyTWt0bSs4ckI2aDdINHZmcVAwSGFYMDVpTkxRVHdia2Q4ek44?=
 =?utf-8?B?b1grMzJDTk5ibi9pTmpHVVRmOWp1NEt1MzEyZ0JhV0lBWGJvQVd4a2dRS1da?=
 =?utf-8?B?WUhHbWgyVGMvLzRubFh0U3N5VUM4NHJDM2RGRVFMSFFGM2V5K1BlR0pZb3Ra?=
 =?utf-8?B?SVJZSzVINXVIMHpuK0lRbFFTWmhFV1VOZFplRW45Vk55d05MSURPTWR0VXhW?=
 =?utf-8?B?QURESUhXdkpwK3EyZ3B5emtuYnZiTkdNTkJ5VC8ySTJLOVFOeFZjNDMyYmtH?=
 =?utf-8?B?WGRLZzl6QlBZSnpGRzB2YUxpQ2NVS3JzT2NaM3VrUzNWeTlZMURoUlJtT2d0?=
 =?utf-8?B?Q0N0cGM0V05ncTJ5Y3l4ZDBGWnMzdnB1ejFLVTA0c3UzcE9FNyt5SFhUc0RX?=
 =?utf-8?B?MGNQQUJmM3FmY3IrY1pKdi83KzNHOFBWYVBVNThjaERKQkRBMy9jWXU3K3pz?=
 =?utf-8?B?Z3JwQjZxSDkreitIR2FjVHFDNmpvWWxmOGtycDBGOEFGTTVCUWVwT1V3eHky?=
 =?utf-8?B?dGdVekFXSlpQZWVnZ3hlYTNOQkk5L3pHZnR1NnVPOFo5QnZQOGZXSWpLTmZs?=
 =?utf-8?B?dWhnUlBoU2RrUm83K2tRWWRBMXdURzlaV2NOajhjWmdhVzUxK2I0ZkpoeVBF?=
 =?utf-8?B?M3orM1pqMFVLbldQdTlwcnBKWU5LOUxGMEtWTEJBTEJhSEF0emYyejhpK2N0?=
 =?utf-8?B?clNoTFkwZGJjVGVPa0g3Z1hnMHo1eER2ZE1wQXpETFJSL0dQS3lxejg5RDli?=
 =?utf-8?Q?O2IdhdGbb4qvK+L2cL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec84101-8da6-44db-0d0e-08df2deb4650
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:14:23.1639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UVmnrjeaETrj0r4TaEq/Y5SHUtuECoIRINs/JeE4gyIhvzA2jHDK73l/a5wujR0d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999224
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



On 10/19/26 03:46, Jesse Zhang wrote:
> Since amdgpu_vm_bo_insert_map() moves all BOs to needs_update, it moves
> the PRT bo_va, which has no BO, there as well. amdgpu_vm_bo_update()
> leaves it there, so the next amdgpu_vm_handle_moved() dereferences the
> NULL BO.
> 
> A CS after mapping a PRT range:
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000158
>   RIP: 0010:amdgpu_vm_handle_moved+0x17a/0x200 [amdgpu]
>    amdgpu_cs_ioctl+0x1579/0x2510 [amdgpu]
> 
> Only move bo_vas with a BO to needs_update.
> 
> Fixes: 3a1abd9743c2 ("drm/amdgpu: fix amdgpu_vm_bo_insert_map to let bo gets update")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index c79a673d9d2e..9d6f93d4ff38 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1832,7 +1832,8 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
>  	if (mapping->flags & AMDGPU_VM_PAGE_PRT)
>  		amdgpu_vm_prt_get(adev);
>  
> -	if (!bo_va->base.moved)
> +	/* PRT mappings have no BO and are kept off the state lists */
> +	if (bo_va->base.bo && !bo_va->base.moved)
>  		amdgpu_vm_bo_needs_update(&bo_va->base);
>  
>  	trace_amdgpu_vm_bo_map(bo_va, mapping);

