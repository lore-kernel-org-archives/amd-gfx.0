Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3046A606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 21:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=HoJMi4PA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1F8B10E655;
	Tue, 17 Nov 2026 21:08:52 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB19D10E655
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 21:08:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJkLEgwks9RuYyqGNgFkxocPqyt/6SlccWPhzI4mNcNh2Kun5+MbJXrxX/LOFXrxrqIesDW2ehAgBmnsrv190syl/Zl+kjAtAWgMI7XtaSK5zQHz3R1QBeEWNr/UF52H5ZpI6bZdJR5oi3sL8OcgI1q01O2ZPdfGfOTTm9cqwek/jqrUnEWYYRK/65cHKOI65TYAYoFqrOfcKXbWCsukhCZFx/bKE03Dm26PCX+X20FQm1G5UXQRESZVAh5tDocjmnteWFchaWWEW0eptTbWDSKKsgeHIulVw6pBm6Hn1ASr0pmWtzBavkBvn22/ZscoDnAsq/7sJjZxX9V9PZc8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IOy2qtMx5dLEDSiWLARLT9JXZRTP2MUUtdF1Nw67E+4=;
 b=dRPSs0eJx0yVYHs/WGvAkcinpM5tsGYk5wQaRDa3Pp1g+k8Jt8/KxK6RjPZWtpLycfufBnvlgTAR3TEWpWpBqL8I5qP8k0yjvFJJ+xFZp9DkayKKFQxIJCjFzE3HPzr0/n7Y8lMZSm6WHctgS4WAWfIEUQFXFc/rL235jUt3xgCLm/YqzS5VfEc7sdsqRRK0nWqQXrFRk8lCDCfOjvF+zn15eOGSzszSlZfzRUSmPwAQPcz7WWgm1pvY8Y8gEa1mbWF5ERhb/Zb5HldhTcsjQkAm34spa5LwLBPl5Ir41usLLCRKwchDrHUWMg3qm4FuV+n/ntOxMITn/O2wgPmy7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOy2qtMx5dLEDSiWLARLT9JXZRTP2MUUtdF1Nw67E+4=;
 b=HoJMi4PALhTP7C18+7Vx7CFZnjPdV9vvG0oHTan+449UStb3AJdidcamiYCWpYt8QgQbNCxRwusIEeKKJzJXExvuIxB9pFJD4NcmkL9dpSYg82W1QyQbotqE5f4gAK4UiHlES/MN1qy4mGuy9JPPcrl6W5OGxtVEreZWsmhK0B0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 21:08:37 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::35dc:5b7a:52da:c8f1%6]) with mapi id 15.21.0615.013; Tue, 17 Nov 2026
 21:08:37 +0000
Message-ID: <935678c4-3813-4465-a85b-7a22e041303e@amd.com>
Date: Tue, 17 Nov 2026 16:08:34 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: reserve fence slot within
 amdgpu_vm_validation()
To: amd-gfx@lists.freedesktop.org
References: <20261117195457.327049-1-shahyan.soltani@amd.com>
Content-Language: en-US
From: Benjamin Cheng <benjamin.cheng@amd.com>
In-Reply-To: <20261117195457.327049-1-shahyan.soltani@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0250.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::20) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9c21fd-750f-460a-c37b-08df44eef2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|18002099003|6133799003|22082099003|261009223027099003|56012099006|11063799006|261102123227099003|261026121527099003|261021121427099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: N6fiqVP9HHh8i8jvr6blu7of9S5c1sJ3nOYt8JLgUH/edko2NgeKvo/QJNd6mUuIle45ImrK6e/+4Vk2f2+rxhtLwUSFvj46A2aaBzlr/WTtgX90+yZWWg8zz49xPkbsXk/zvKcGmC8iohxr79EHZUm2MAlkqIBy4m9YuVtLuNf7H/bsTWVi/OBVVp5eaTTPGkojW4PVu7crYsiJuJ7db/tRG3OLt3xcT0MTft40WOWqd8ipBqD/eA25RnEy3dVTymdTcBcNvGAq6hrXBFV8QnTUQGINCR53QHMq27QYqXNl9oWcxCFarN5MVFMgguTBnf2eQ0w95AT+UeIGWzmau/XwYzCBy7NUw32zRO+RN1ST4qzFesFjDTtiYYTRgQB9dCWePrseANcpFsXyLOMQw/GpviQDqzQ6DcmIJ/oXqjFRtx0T1+eBcZV9E3oq4wPyon0p4ItrUr1xFIwtdIfoe6xliszQsXpdWSZI1VPjMCfTPSBsU53drQpM8fB+cREv13w3KY9L2/YlpgY4NFmTFEtXL65ub4Y27oRC3TCsxRSxxnoEYDuCuQW1KdTaKERIjRMxCMpHZqUtESbFDv7e0m9FlxFY8Ni7Zmps198H8bC7zIhuVdFAAq5XfUqleSGT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5805.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(6133799003)(22082099003)(261009223027099003)(56012099006)(11063799006)(261102123227099003)(261026121527099003)(261021121427099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1VyUnVQd3gvNnFUTWlvcFVVMFdZWGhzZTlKc1ZmTjVoako1VWVhL2c5SWcx?=
 =?utf-8?B?N2lCOVQ2NHpYU2IxMDJyTnRlZDV4V0Jnd1dLQm1sT1l1RlpWaUM0eVRodXhY?=
 =?utf-8?B?UEVKeEFicHI2RVgwTjNsaE1HZkI3NUVzbUZsUFY0ckF3dzhLaFhLNTJvK0JT?=
 =?utf-8?B?QVI0a0RVUG53WFhaWDEzLzltd0RrTklXWStXQ2RGNFRJSlo5UDRxNXRGSVhJ?=
 =?utf-8?B?ZjUyTmF0a3BGSFRvcnZRQXZqU1lUa1lXWGpUcHZ0NWkwSndRT0dJaGIxTkh5?=
 =?utf-8?B?R2h1QTMza1R5UUlENTJKSHpNdnUwa1NJNmRyS2w2WERHRW5xWmFyU2QrcXQ0?=
 =?utf-8?B?TVpRRTVwNVh6dGwvMHNXV1hucFpLbUtrQy8zK3dYd3BLZDYra3hCM3lBWUQv?=
 =?utf-8?B?OW50YWJmYTN3OGFTcWxkblg1emZMSWdXV1BWdE01VTZvM044aWRtc3dDK0Ru?=
 =?utf-8?B?bDhvMkZ5MVV6bFRQaGN0RlllUndiL29KN1QxbGNmSWtvNjFXcURKRTQ4Nmxa?=
 =?utf-8?B?MDVtVnY4c1NzSGRJbkpBQW9rZUFobmNsUHJGSW9oRG1KSkRFKzl2YnFCdkRM?=
 =?utf-8?B?SmhvVVJnbTVQT2tPbE5jMGIvSm0vSTVtMVQ5cDl1T2h3QVNpdldtanBXMW1r?=
 =?utf-8?B?UDE2aDZub3E5VjRUcUdvK05ZWEV2Q3ZaQ1AzRjREczFKbm82TzdLZDZWSmxk?=
 =?utf-8?B?cnpFWlB3V3ovYXBDYStDSHlkYkhOLzhBb1hTOHo3VUgxWGQ0cGxUM2dmd1hG?=
 =?utf-8?B?T1BjMEVMUGFWOGVZMDU2bFRpTFJPQnVKT1hyanRkTmVWckliWllpQno0Y2hO?=
 =?utf-8?B?QnhhK0RwRDVGMGJ3MjgxSWhZeU5aeHFZdjFFOVZUTkhXbU9GUHU5ZENXaXI3?=
 =?utf-8?B?Ukd5MjgxdmdoN1VWbkN1bkxHdHpNMWlZN0xGdDNnRm05TTNzVUtQUDB3UElz?=
 =?utf-8?B?VmFxVTNzZjJBWGZLVnFTT0xLZEV1R3RVVzF0QVhJNmo4N1ZVazQ4djBOQnZ3?=
 =?utf-8?B?MFdwT3RxTmZiVFd5RTlSNkFkaTRwREZMUW5GdXZFZUhpWnZSOW4zbmNwQ0Zk?=
 =?utf-8?B?Q1Z1ekgxc24rekI5bXRwcUliRC90K25VcGxXZm81Vmxlc0ZUaXFsa3ErQlZB?=
 =?utf-8?B?T2lBWVoyUEFIalJBK09QR3hLSkRYQ0lOYmVaMCtXWmlhSFI1bXp3NmRTR29v?=
 =?utf-8?B?dU1yM1FEMUNzbHJHajUvQS9vRVpIaDJTdnVpZ1ZmanEzOCtnNWlabGt2eDBK?=
 =?utf-8?B?Uks0c3Bpc0szcThreU4yQ09kTllaUXF0bk1qWU5UblByM2lmR1F3RHZwOFpi?=
 =?utf-8?B?SHkxTWtxUlhCM1prbHRsTUhMc2ZTSzlrcSsrOUNSZUxFVm11dm8xSkx6dDN2?=
 =?utf-8?B?Z1lQL1Q2YVE2Z2NCZW83cHRsK1k4eTU1YmFYNE1vdXZ0WU1wak5qTlVzWTFi?=
 =?utf-8?B?bDRKb2Nkbmc3ZkI4M3FPaUYreVpLTTZ3NlU3aHZHaHNRUHZML3FYeXNMNnpL?=
 =?utf-8?B?bzM2NTlmS3FvTzlQVEZlTUFWYmFzelh6TkJzWWtxTVNRUTQ0MEhmbjRGNVVS?=
 =?utf-8?B?UWRCL0owSldVbWJ6UkxjbGlUaUpSWTJFeEZtTUJUMk9QMlRRWis3Y1h0QVJ3?=
 =?utf-8?B?WS9XSlVzOWowK1VIeG1tQ1RLekNGYTRyWklYRWhhdEJtT1JTLzBUNndMQXU1?=
 =?utf-8?B?WnVaWldKWkQ3OVNQNlUzZUc5Zld3YkpaKzR5blp2bkpBZHNmaHJ5RVRCRE9z?=
 =?utf-8?B?WGNpUGJmTTVoUEx3Y1lPVkRqQjkxMWtzMkUvSnhyV2xMaDR1MFNoQVFHZVk5?=
 =?utf-8?B?eDVzZFM4N2NQd0IwaVEzMGZ4Um9XNnBlR2FGUVNkNVQxeWQrOGhnS0thOFh6?=
 =?utf-8?B?N2lDTncxNlhTRE1TdVBUYjN5TUtQd2dGU0VrNVFoU3JHc2ttWUpnbE9XM0Vi?=
 =?utf-8?B?TCtlc2VlVkwrY0tRWGE3YWFlNFB0WlJCNGdpOWlSVlgrbmtGL1pKSis1ZERO?=
 =?utf-8?B?R1RCYitIdUc1dDdKSkEyc0tnUEluZ3hsSE1jTzdwUVRjajJpZThtZDBYMFk4?=
 =?utf-8?B?RkRpYkplUmczM3RqZzJ1Y3ZJcG5aUHZBQkFSSmFxZXJnVnlBdzBKb014NGk1?=
 =?utf-8?B?MkM0cmUvWEsyQkFza0lWTk1pUURtb01sdmh5c3VMNUdSaVRqbE9JOTdPOEMx?=
 =?utf-8?B?M2tHYUNlTzFONm0wc0IrUFU4NnVsR29hcXBIQmRuejdGUDU1d2RSQlNNNVhM?=
 =?utf-8?B?a1Z4dmQwWERvWlBSZXFuRjdnbWI1TitYZ2REbUJ5SWNBMkN4dEs5bWo2NVpN?=
 =?utf-8?B?MGtySWJDVVhPbjVPY2kxajJHYTdhY3dOK3N5VEhETjVvb25vNVdUZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9c21fd-750f-460a-c37b-08df44eef2a3
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 21:08:37.5651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: blN5BazX/Q5baYkd5sPI45foVsq4zIHvXkJYUhx1jk7mk4rlpP2GQQ2Zk13wpQCaGknrvhsRNmc3kOGWX4DHow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-11-17 14:54, Shahyan Soltani wrote:
> Anytime amdgpu_vm_pt_clear() is called, a job is committed through
> vm->update_funcs->commit(). If the GPU is currently using SDMA, this
> triggers the function amdgpu_vm_sdma_commit(), which requires a fence
> slot due to it utilizing dma_resv_add_fence(). Since this slot is not
> provided in amdgpu_vm_validate() a kernel crash can occur.
>
> Reserve a fence slot with dma_resv_reserve_fences() before
> amdgpu_vm_pt_clear() is called.
>
> Fixes: ddc3c87584e2 ("drm/amdgpu: clear vm pts upon a vm->generation mismatch")
> Signed-off-by: Shahyan Soltani <shahyan.soltani@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 3bcfe0f3b35a..d5b758b5eb82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -658,6 +658,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		bo_base->moved = true;
>  
>  		if (vm->generation != new_vm_generation) {
> +			r = dma_resv_reserve_fences(bo_base->bo->tbo.base.resv, 1);

Hi Shahyan,

Since reserve_fences() does increase the capacity (it only increases capacity if it finds there is not enough room) this is insufficient.

We can either reserve everywhere, or reserve everything up front. It seems Christian favours the latter.

See https://lore.kernel.org/amd-gfx/bfc53181-53ac-49f8-b243-95b23999a638@amd.com/ for example. I will be sending out v2 of that patchset soon, and I guess it should fix this issue too.

Thanks,

Ben

> +			if (r)
> +				return r;
>  			r = amdgpu_vm_pt_clear(adev, vm, to_amdgpu_bo_vm(bo_base->bo), false);
>  			if (r)
>  				return r;
