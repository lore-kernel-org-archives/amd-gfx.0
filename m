Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18099C982E6
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 13:59:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AC2010E791;
	Mon, 21 Sep 2026 13:59:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yuwYo8ML";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC6610E791
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 13:59:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9ZngzDf1iJ3bK7qb1FCWKWdM9pT/Ysa0tEiP1kbO+snI7DikX9lukxyZ7iFELA+ka/9+9kgBZ4ud397MxJBd4f9TCgJR/ZIlUwzG4Fw+4cWS5i8bvVGmWAZmfxlIMNSHznPqO2UnJHAukKsj6pl294lFgbjtAv142yb9V3L4900T5m3Ng/i2H6BaGlteKKjOFq2bHYF8XIedoYtArksCH5tSSjA8phrv9ay8+fc5N6K6hUW4zuQ8dQR8iqgGFvO9Ae//rcacSNL0jAAR6wqzsUULEuiLlDJiR9E9Xbms3wBA7kFOKBCqt602Ont5nyMAwo5gzRrB8AmJ3ivEBxsAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfE0btJKkkq8vEqJTxTz71Qadf7zpr3beCrKwPb2AbE=;
 b=yOLbqOinTA/BHqKtF8cVHTKh63Q97JTQiKgZDKFX0cgBidScsMbh/orQax8kcV33g7Qcqxk7uflKGIfatQW21i65a/yAxqKgxH2LCDVTfrUVzLT/WMBOl/FdK9xmoM6OF30T5sEggxw/T9iypH+qnWRzTL/iaD6g6SUd9fwaonD5zVVcwPePrLTl5R0iD9uIaD9RJKErkmXMzf2TlolynhRgDK2Bx+Bk0PrN81QFkV/yRNg4ijojXnQaUiUV92X0O3sySegWXpO/EMWMypgbtfEak34PpGXqm70c1jT7hydkx4W10QxhRLrZbKevIy6Ap0vXBSAK2XpNU+c5IJXypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfE0btJKkkq8vEqJTxTz71Qadf7zpr3beCrKwPb2AbE=;
 b=yuwYo8ML5UqL0p9/fFmC99bgKk6HB/CjMJcGbR2heJmM6EHPUJ+1cpxV0IvO4a2ngI3x2NgstpSxGahpne8sFrdomslVWdg7I5gUHo57eBo6XE08QofbeXt9GDkUjm0PIZSD7KsBhiE9JgzKQ/C9NtaTCCMumAy2tfb8wt9IL/M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17)
 by SA1PR12MB5657.namprd12.prod.outlook.com (2603:10b6:806:234::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:59:16 +0000
Received: from SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc]) by SA0PR12MB7091.namprd12.prod.outlook.com
 ([fe80::ec33:1213:cfd8:63bc%6]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 13:59:16 +0000
Message-ID: <f76638fa-3697-42ac-ac4b-fb3034e85bed@amd.com>
Date: Mon, 21 Sep 2026 19:29:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu/userq: reserve the VM root BO around CWSR
 param validation
To: James Zhu <James.Zhu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 SRINIVASAN.SHANMUGAM@amd.com
Cc: alexander.deucher@amd.com, Christian.Koenig@amd.com, jamesz@amd.com
References: <20260918200444.450067-1-James.Zhu@amd.com>
 <20260921134538.3673161-1-James.Zhu@amd.com>
Content-Language: en-US
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20260921134538.3673161-1-James.Zhu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0142.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b9::17) To SA0PR12MB7091.namprd12.prod.outlook.com
 (2603:10b6:806:2d5::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB7091:EE_|SA1PR12MB5657:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b7cfd57-6078-4eca-1302-08df17e885dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|10067099003|56012099006|18002099003|22082099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 2j8gVsrwnTc8wyzTEf0YnZpvsyq8FhZhnfhiCYHM0MAoiqVmMGf0c3gYqHyzTuxEKkwIzyD2UvYlkpezJZc5PvMCbIgR6hO8CJy/rIbstDdTHmNpbZqUOCGAaUFK1Fhxc+PFiBAp8Y7msQuo6cg2XO2gRQkRYBSaNqWA9K7+DIUpGBwYWb5gzAPpCyMAwf3KgRRkCHvDocDSHQy3hGkBvjbX/ex9ZeteJmWzzy2oUwmstVSKWFi685ZaT9JqWBZSeWv26Oqcl+MGNic6Iyh4OB5EzOgDbb0nAppkI+eCoqkVFp1deIuIY+cEOSyXiKeXgvsNPfDnXGNaYSHwVUlyMkENxIsZWAcUav8R4VZV/pgsPdW7+//MF41sbLCqCPkLlehcVfvFAtcJl26MJceMy5ovgzg1GrQ9RjU+WD4svWzifLTt8EvPvRbrnrCkz+tzj/BqHfClq2H4jMC4ww7Nmp+v9yST1cbLE+DKGcZWbxfD+HOOJBeAdi1M2ojY/1MrnNG9ghIKS9ddCIWiN4xiWuVL8ItFF/oWYwfwnbWgjdMf+hOPI86On7W36DlXfQRn9HFOYG1N0rk2dGdhDF0HpKz53d75+2eRNxO2KufE2B3jUqmatEWW37mYNEbpPPOD6xa1yby5ttNJqlTm9Vam1GxkP3yczmU+LauYjncWibw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB7091.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnV4UUFBOVlmejl5bUZvaUJEdDE0Y2doYjNuWVo2S2tsZE9SYzNrUjVEUDFy?=
 =?utf-8?B?UngxZHZ2OTBkbE1zbFdTR1pkbldhUjFrODczcDJ6OHZkNUNIdWhBWDc3SGs1?=
 =?utf-8?B?VXMxc2toU3dnQnJyVWZCc0w5NnkyeWZrRmdGN09ZWVJuVTAxUWhZVFN1S3Nh?=
 =?utf-8?B?eXN6dThpNno2M0ZyRm4wc042Z1VaNHA2VTVucGk0dUFzbnVxOXVwZ2VEUmxY?=
 =?utf-8?B?ekIwaFQrMUx1Q1ZTaW1QbVYwQjdVaUpxOUdyZnVhK09YeUJxMDR5c25zMk5M?=
 =?utf-8?B?bGZXL2JsVnI1REJlVWs4U3JTTmVvcmkrWkVicHB1OGpRYSsvRExEK0xtWktW?=
 =?utf-8?B?dTRGNXk0Q3J2L2lCMnZFU3Rqdkh5QUtCSHpRWU9zdDM0SEk3WHRiMmhWYmla?=
 =?utf-8?B?YkJJRXdvMm5HN1FSMWNsbVFjQ205R3IrN0NmRzRMZFJpSzA2U1A2MmxHQXVS?=
 =?utf-8?B?WElvcXdGeEtDcXZXNHIrSG0zSm9mUzVTdkkvbnpMck9XeWtvb0JwMGRjanY4?=
 =?utf-8?B?bSt4NG5iZ0dBeXpXVEdRTVNvNlR1cHJ4MDdHVi9FNVd3NWtDR2NZOWR0TUJR?=
 =?utf-8?B?ckRwVTlYa3VGVWgwQnpsT1JBdDVyNGsxallmV1RQS1FhenBzWGpMa2RkVE5D?=
 =?utf-8?B?NUd3WDVQeXlFNmt3Ykpnd0FqZG5Pc0pVbTRFY0hCNHNxRVQ0Yy9SZmYwL1dT?=
 =?utf-8?B?OG1HSG9Pck9PYWdYeC9xdEpoUk5kVkpNYTkyeFEvVHNUOTIzbjRVRzg3eXh1?=
 =?utf-8?B?YXlyelJIUU5qV0xFdHBtMzVPb254Mnp4WXUyZ2ZkM3pZYjJBUWhnQzk5ME5v?=
 =?utf-8?B?RmpYdXcxYkozWnBGcW8xVFZJRjAxOWhrT2MyUjI3SnVPeFhJQ1pZci90dnVv?=
 =?utf-8?B?TCtnQnZmWlZlSEkyZUU3QjYrV3MrOFE2RDl5SGErU2VCWlZxcm5RemcrWEFD?=
 =?utf-8?B?S2pVd3Q3blFQeW1nekVKRXhUbEJVQXdXR3oveVlQSzVEVWdtekttTGJPSEt0?=
 =?utf-8?B?TWVyTWRFdDRMWmg1Ry9LUmx3bVN5N3dXbG5IM2IvaXlnbEtHWitxbkpvSTZ2?=
 =?utf-8?B?NC9naXgrNWpjbWpTejZPajAxNnBPOW9VR0lORU5zTGczYkNhdWtaRU5xTHBM?=
 =?utf-8?B?TkRob0VWbTBRTTlKcjhlNTlzRE15Mm84N1RZaEd5YnB2V0s5a2F1NWZlMklp?=
 =?utf-8?B?UnYvQy81WUJ6LzQ1TzQvUlhWNncyRjJYcmNJL1lvaXFtU0hzdkVkTjhnK2ZP?=
 =?utf-8?B?Q0JLdVNXbmFicU5oeGxxTG9KZDA3MWRIenQyVjVUeDZEc2J1MkxtMitFcW9q?=
 =?utf-8?B?cGZWcEFPcC9Xb2pVUWY4QjlOK3lBTXVYdWtvS01udWpOU2dDTTRNTTVVRzFr?=
 =?utf-8?B?U2JRaHpKUFh2Vlk3ZlEzS2ZFUStQemdJN1F4am9jSzdSWFNtdFFJZW41ZW9F?=
 =?utf-8?B?ZHE1TjBuV1NoUFZqUGJ6SDczL1AzRG03Q3o5YlFiUitCanlER1FJaW5oR3pN?=
 =?utf-8?B?YW5ENWVlUWc1QXE3VG85L1RWVzA1Z2tTL1JkZG1vb1pxTkxpekFwMW5ycFBa?=
 =?utf-8?B?ejRNYXB0SmhaNDJIb0FuOWw5SWNZNHBtSTZleldNckgya0tTNzdWK1ZYbnZs?=
 =?utf-8?B?MFhNVGpMYU5OaUtvajBRWWNwNmNTT0RQdEI4aEV3NTJ3TVhSYmpCcDJoeE1s?=
 =?utf-8?B?RW1ta05XT1J1R3phUzZTc2lxSWxEN2hCKzhtSVJMdVpTcUtpY1kzcWNTU1ZC?=
 =?utf-8?B?T1lRcm9xTVBnakZmbGxWam5ER0podlBPamVxMUFFTjVibGRlT0laQUpma25k?=
 =?utf-8?B?OXRKTUxmZVhOR0o3bCtXOTQ0SDY0dGRZQ0dUbDNUNkNXUVMvSm82WDErczV4?=
 =?utf-8?B?cXJ6QXp4ZkVBODJaVzlHS1VwVjFtYm1HMGRydUw3R2t2eUx0V0R3Sk5tMnVO?=
 =?utf-8?B?TlRkSWFxRkRKSG5WYS8yeUZRUFVPRncxeXExU2Y3SDJvQzZlaDRwWk9wem9M?=
 =?utf-8?B?b2Z4M0tEdFV3S2wxYmwyMVVwWWdMWWp6QXV1Ulp1cm9ZZEg1ZGJnNjBCWTIv?=
 =?utf-8?B?aFU1WGlRazhGQU54dnZLbVF4MXVoK1M0dDZtUlcxUWkwRnJ3UDNrUmVJWGha?=
 =?utf-8?B?ZWpyaXlNTGg0c2VwMy9qYVBjblYrYjgrektWbElUenVxeXpOWFhiU2t0ZElH?=
 =?utf-8?B?d08rUmVKTmRBN0dXOTh0MW42dllnYVFRaFI2Vkw3K1BEUmpiakFzcG9WL2tF?=
 =?utf-8?B?L2YvRGRDWmE4Qmd2d1NoVWpDb295NlJjaFlUTXZ3a1hHS0ZFMTlxUjg2Zlk0?=
 =?utf-8?Q?JSq+DYxcuxEMQn+Oqu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b7cfd57-6078-4eca-1302-08df17e885dc
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB7091.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 13:59:15.9098 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW1BwzAEWdJSwR66oojpCVcTKW7SkXiBuZK+L3at+E2XfQntgWWdbOovJP3ikV7R
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5657
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



On 21-Sep-26 7:15 PM, James Zhu wrote:
> amdgpu_userq_input_trap_params_validate() ends up in
> amdgpu_userq_input_va_validate(), which walks the VM mapping tree and
> updates bo_va->userq_va_mapped, so it requires the caller to hold the
> vm->root.bo reservation. The CWSR branch of mes_userq_mqd_create() called
> it without that reservation, tripping the dma_resv_assert_held() on every
> compute queue creation when trap handling is enabled:
> 
>   WARNING: drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c:232 at
>   amdgpu_userq_input_va_validate+0xb9/0xd0 [amdgpu]
>   Call Trace:
>    mes_userq_mqd_create+0x49c/0x9e0 [amdgpu]
>    amdgpu_userq_ioctl+0x935/0x1070 [amdgpu]
>    drm_ioctl_kernel+0xb3/0x110 [drm]
> 
> Bracket the call with amdgpu_bo_reserve()/amdgpu_bo_unreserve() like the
> other input VA validations in the same function.
> 
> Fixes: 7ca9abf4ac38 ("drm/amdgpu: Add user save area params to mqd input")
> 

Hi Alex/Srini,

Which branch are these patches based on? I don't see any cwsr patch 
upstream yet, probably that makes Fixes irrelevant.

Thanks,
Lijo

> -v2: add Fixes tag
> 
> Signed-off-by: James Zhu <James.Zhu@amd.com>
> Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 2150973b947d..16aa22b25098 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -508,7 +508,14 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>   			trap_params.ctx_save_area_address =
>   				compute_mqd->ctx_save_area_va;
>   			trap_params.cwsr_sz = compute_mqd->ctx_save_area_size;
> +
> +			r = amdgpu_bo_reserve(queue->vm->root.bo, false);
> +			if (r) {
> +				kfree(compute_mqd);
> +				goto free_mqd;
> +			}
>   			r = amdgpu_userq_input_trap_params_validate(queue, &trap_params);
> +			amdgpu_bo_unreserve(queue->vm->root.bo);
>   			if (r) {
>   				kfree(compute_mqd);
>   				goto free_mqd;

