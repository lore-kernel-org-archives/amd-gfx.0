Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 398FFC4321E
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Dec 2022 11:46:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AEDB10E6D9;
	Fri,  2 Dec 2022 11:46:47 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A938D10E6D9
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Dec 2022 11:46:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lSr9DItUZ9GelLfM/LVfPe8u52X/PE4oACSofna67mq4RMKafwo2msvElWKHJUWzeKqBWmXK7YpzGLR8njLyVs3Vi9UL8b0PyuOFvnGYPb7kl5I90DEoU99UHcVLqnAXjkxt1LeANb7Zxxcv3qdee5ZwD3+/t/PL7pHy2+vL5Me3hRdiFnRR2vXFmh4rMK98cl53nnQDN0VqsIaWgdOujt1BkmcYq0NISaJgCo55btjmAS2G8G0SMVSeRgOnr4p44q8bLsUA/Yvzej8ITcJ22FO0pu6wUmBKY9AbEl0bK+7pEdAvrdv5xEFi5iri0iipqOx/udpPNuxK2cMRe1CcHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QLF2TmUx8Aq/mjen9m7T3P+z8IrZqzF41HB9gBRFfMY=;
 b=hc9e/9WM+ChdGsU2ZNlZxjV35dMdLUk6oaDTC9gmNSH+gq+KR+Xg5rsoEik63JZ71HYpEdaDRQ9iBgQbnMF2Fht/lLBOncwVm8AQu43U2A6wcfJv5AjQ9uOwF+DdvrJUfsKla9WCyLn7ioyhbyT1M6lhYbyV/lgaScT8DyEQjbWmTTFA6x2D+AJYxCF4aYv4zHq/Frz/b2xBLTQGlz0GgLcezUeWOCCnE/dV5CEUM81TLsgUu8RAq2qf7AXhmQ7kXImsDIfzYGuipEbGZ16ZDN6EQNrV6koF1LVvzFR1lyDn0IHhUHIjgNlopHgG9FyZ0ZH+U8PuN1CpED0Eo2+0WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLF2TmUx8Aq/mjen9m7T3P+z8IrZqzF41HB9gBRFfMY=;
 b=pGQ66RFqlLGqPzqgF05CwkAXXmNhENuskdNBdeLm3B0436B7K4AkHmyiPEbxzLD5AiXnrz9mdblWVqAtvLGc9wDjA6v7CmlOwgUDaImUEmlt6JAR4Fyeb6TtGMDWUy2e7UbV6nfRh80HJeRw6bwQ0exEKKFZksAJWKcRepcxpP0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN9PR12MB5305.namprd12.prod.outlook.com (2603:10b6:408:102::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.10; Fri, 2 Dec
 2022 11:46:40 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::7d43:3f30:4caf:7421%7]) with mapi id 15.20.5880.010; Fri, 2 Dec 2022
 11:46:40 +0000
Message-ID: <a837a7a6-868c-d883-33ae-feae123ffb52@amd.com>
Date: Fri, 2 Dec 2022 12:46:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amd/display: use the proper fb offset for DM
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221129181716.2442984-1-alexander.deucher@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221129181716.2442984-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0153.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::11) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|BN9PR12MB5305:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b9cc3f1-1dae-4a09-189b-08dad45ae076
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: unH03oWqyP3GkQXVlPUd6wb/zD0W6ZQjHgivkdGOVXYLz8RmrLxQDrQVQOJhvrTS2BjivA9xDgDD2Da2rziBvfcVKwp3zyT8SEaTAcsQO34h/vSx9iwiVXrEekLm2zl3LN1iuAzMaWNkjjLeMOti/nviihRMFt0MudIDo7GtE9su+kACyjWCZBe90WrYGXSNSwEeO9xClw3fwwvzmABQ37WjRX9pk0/tBzp6ZS+USJm8htnkRbo1J1ZPQj+0aoaop2MHI3bPPUAjFNHZB7M700Yo5QHpiT+RUdHDYTbP83ohRvLmMpFHPk/iCVApDRG45h0/12beN7BRYVOBFcDxF4xJjoOFpuNJa8oiTGOavuWjIMmXiuuEid0TkBHWo0ZhvimQ/B/cumWfe3hguseqrAWgkS4lEuO66sDjOfv2wyHNUpiiHm21Iqu7PsfJzN2OpUv2wdOwpsQOXHpH+yA7FSLMhnr5IlF/W7vwTwyvg6Y23U5CVWIsKiopRJNuCb56qMhRcpbRy2E7o6RSjxmcJodwwDzIDUEp6EYKAvaaNFBZzdBnQ88uhWn3Qhse5iZzmchghFc2h/HPZxgBLT9Dd6RHJi5aFgv4MAVti/plfhJr8LkPgXZSNpLpoVjZcANu79EQ/K5Z5vA6OsikIRSKmuZocOK84ArtkJgbDvRRRF4zEuFLSRqtVtrHs1gSG67mbvQPZlxDufgZ8wQ2iayiOeEKw3q2KJcYGkdcc9bIrQM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(451199015)(316002)(38100700002)(41300700001)(2906002)(8936002)(5660300002)(66476007)(66946007)(66556008)(2616005)(8676002)(186003)(86362001)(31686004)(6486002)(83380400001)(31696002)(36756003)(478600001)(6506007)(6512007)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXJJVGJKUW9hM1Z3eU5odkI3T0t0L2xtUEtOVUtLR2JPUnFmK2JiTkluS2cr?=
 =?utf-8?B?cklid1pXclhXWXhzVk11aHh2Tzh5NWY3b1pDUTZaUGdtN0c4NmJManR5Nzlv?=
 =?utf-8?B?aTB5ZTNRZ1p3M295bXpDR1p0cXNDaGt2dU8rOTlsZnBGa0piVWhmWTRFejNs?=
 =?utf-8?B?WnZhNVk1c09pWERVSmNMT3ZwdzBnOTFqRjNYZkFMNm9nR04vNzA5Z01Zb0dh?=
 =?utf-8?B?K3ZGYXI3Uk1GaU5aejMwT0Q0QTV5SGpCdTdkS0kxRHpFV3lnMGxEdjdXSStm?=
 =?utf-8?B?NnVIUityV0ZDVHFQODQxcUlvRmFTSklRUzdxQVZOMXhyQ1IwMy9HRFhDazVQ?=
 =?utf-8?B?VSt6MEt1S2k0WklMVWlPWGhrZytEOFN5R0R5bWV4Z1F5M3pjTWtDaVFHeXZt?=
 =?utf-8?B?ZUhicVMxUHZhaDdXcnRYZ3VES21pRDBCcXcxZGNhMUR4bzNzVmFXRWN4RkRR?=
 =?utf-8?B?aWxab1Bhdlg5NXRrd1RTcWtTTmtDRWc4Umx2b2dlMjNseFk0OUw4R0xGOWdZ?=
 =?utf-8?B?SUY1UUJpNU1mR3d5K3VjSG9OQjZrZmZIYVBGTlg5T2ZaT3gwamRsRk9pQ09n?=
 =?utf-8?B?K3U4cStUTEJ0MHBtM2k2aEFQUVZSdE85T3lOSkN0Ym5nWFBzaFUyUENEa2s0?=
 =?utf-8?B?emtYYmNWbkZCTE1pOVZtMUhMT3ZBb1FiQzBvR0V5di9neXdkUHFHTkZLOHE3?=
 =?utf-8?B?VXJ6STd2ckpmMCtjdjhSODVxREVKOC9VRUhxTEZ6OVJYQStYOW1Oa1pHZGlx?=
 =?utf-8?B?ZU5VV3hRYTZqTEM5dUNhcmN2d1dLb20wZU84eXRFMnQ0ek13amxteG9NdmdO?=
 =?utf-8?B?R3FWWkJHNks2VHFiWFZOLzFTUXd4MnhxcU9UdzFIa3lUS012RG5sdGY3SFM4?=
 =?utf-8?B?bExVZitNVVpLWm41UTExWW90dHo2OFZyWUtxZjZYbTZtN2IweUJ0N09pdFRU?=
 =?utf-8?B?T1J3YlFFS1c2UkxZQ1ROaVdkK0Z6TEhtU24xR3FVeXpLSm5NVHlCV3N6QU1z?=
 =?utf-8?B?THY0N0NtdHI0N09GQ21iS1doRkRKLzVyQnB4b2dYY0FwdW9OdGc3UUZHcXl6?=
 =?utf-8?B?bktZRGlxeHpsMXVtcitjV1NubDhhczNQNnhDT05tbk11NmxOQ1liS2F6SDls?=
 =?utf-8?B?Y2p4UkJIYzlDeUF4SldxaVRMaGhMR2RuUGJwOGZLU1hwTkZ1RGFNOUdSdEpq?=
 =?utf-8?B?QTVkY2Q4MVprWWM3MmU5MDRza2ZlM204YVZlUXRpYnozTEU1Ujc1V3JUS3Uz?=
 =?utf-8?B?ZzFIdjVIeXlndE1pUDluOUhBTStXRHpPSFBSTm8vYWtpTG5Ka0tvQ3FubDIy?=
 =?utf-8?B?SytHOFZQZmRYQ1lNb1dJNVgwREhUZE1TUlN5bmN4ZU1jUk1hRnEvL3FneUMw?=
 =?utf-8?B?bkp2Q2FMSm9jdmtkZ1FhTnFrdHQwS1pPWjlCdEoxdmZOMzVMS2MveTlkSFpS?=
 =?utf-8?B?WEZrdnRQK2RFMzJXa0NQZ1l1alJkeGV1aU9wL09wRytjeTRHN0V0VXlwM29y?=
 =?utf-8?B?bm56enRCdnBZRVRyUENRU1pMZlVFNW5XUitDUFZBUHdSdTlGU0tRRXByci93?=
 =?utf-8?B?TVN1dzFmMER0b1cxdWRySUxpSVFpRWdiU01odGNhUGtzdThaZmFjZmNhSW5O?=
 =?utf-8?B?UEd3VHRQZHJiejd0U1BvcFZ1d1NBbFVwRHpiQVZ2a2dWTUFocVFnZStFWElK?=
 =?utf-8?B?Tk1kZDlESjRpbTNzVmxHbHN5YmtzT1puNytveCtkTVZjU0R0Z1NEaXFuNkcw?=
 =?utf-8?B?TVRtL0ZPSTZNYUZ0dGZZUDZ4Mk14UXJTUTdsd0hKOUU3MmdpNmllTFRTdis1?=
 =?utf-8?B?S3V1UEthZzVuellyMWhPcXI3ZmtEMTJsZXh4eTcvSS9rOGE1TTJWMmJBT0Iy?=
 =?utf-8?B?Y1YwdXhld2ROaUxSZzBNY2I1UGozc3BHMkFEMFN2bGxwLy9oaVg2NmNaRVp5?=
 =?utf-8?B?dUY0dG1jZDRUZEhJL1A0elFTbDZVOHVuWE5kYVNldnRRbm1SN01odlp6VmRL?=
 =?utf-8?B?RzRueGlSaThOdm5MUHY0VDExY3BiQUQxMmRwYkozWEZJOStUYzFDdE5KSDRD?=
 =?utf-8?B?eklWci9GV202bWZhUW5Jay9GL1dGZTdwYjJsS0IvR1Bvd3Q1VFJKUW1aVllQ?=
 =?utf-8?B?UlJ5N2FNd2dzaEpaRjlKRjlCSEdmeEw5YXFNcDNPbFY4N045Wmx3MS9oZHQz?=
 =?utf-8?Q?BDpZcrudkGarYCIToXD6/nCZGVIYsz4iMeUypjXbmFTJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b9cc3f1-1dae-4a09-189b-08dad45ae076
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 11:46:40.6983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DBqOxRReVbrglkiW/S9iR8lmfG0gEgOiwm5JUCtz2Gaed8j+iOvVV1mDwvSWVSmE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5305
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

Am 29.11.22 um 19:17 schrieb Alex Deucher:
> This fixes DMCU initialization in APU GPU passthrough.  The
> DMCU needs the GPU physical address, not the CPU physical
> address.  This ends up working out on bare metal because
> we always use the physical address, but doesn't work in
> passthrough because the addresses are different.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Acked-by: Christian König <christian.koenig@amd.com>

Have we also addressed the ACPI/power management problems for that use 
case now?

Regards,
Christian.

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 3792a181253b..850432e220a8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1096,7 +1096,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
>   	/* Initialize hardware. */
>   	memset(&hw_params, 0, sizeof(hw_params));
>   	hw_params.fb_base = adev->gmc.fb_start;
> -	hw_params.fb_offset = adev->gmc.aper_base;
> +	hw_params.fb_offset = adev->vm_manager.vram_base_offset;
>   
>   	/* backdoor load firmware and trigger dmub running */
>   	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
> @@ -1218,7 +1218,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
>   	pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
>   
>   	pa_config->system_aperture.fb_base = adev->gmc.fb_start;
> -	pa_config->system_aperture.fb_offset = adev->gmc.aper_base;
> +	pa_config->system_aperture.fb_offset = adev->vm_manager.vram_base_offset;
>   	pa_config->system_aperture.fb_top = adev->gmc.fb_end;
>   
>   	pa_config->gart_config.page_table_start_addr = page_table_start.quad_part << 12;

