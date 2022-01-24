Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EDF8C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 07:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C752E10E768;
	Mon, 24 Jan 2022 07:58:42 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 018A410E768
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 07:58:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jM15sEu1mnShpp+YFEwqBzxB9emVAm0W3H9racSwcN/UCKX+3RHEbYePnol06Z6wdmN/BJYItihXPktJK9GavA4Pr3qSmj5YjM7/3HX2VGWT3s9QeU+7ckx/udxyrti7evUEifaomD2Uv1DA+zgqFhNvYipEWy8MMhIRLSXBCROl0A80YHNDrvfARymOWEAMOMZCIhNodU4wJmoVjFbM6Fni2nRb9HDIR1AuBvp21HNGaFpTwJKSy8Wyv1nb7c0fTdscNOq5OSxptequ0h/sUqZTk3EAGUGVnGWZg6oooadlEuG9J3AMl6U/IZkTm/gi6xst+aFNuMcYgSRvj8QUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icFAh+xM4dH2Aemt9VBNnZ9x5mv+Dfypf6HqHxxJPSE=;
 b=UdgTF/vKNDhGXbQlZVKV92ffMN5tZCff0tGPUYS+kaFw4X5r6unieOvIJ2ytdJ5URZCDOix6cnjYx0rhiIxl/2c9W1kkiittPKG9Vo7TRmDbCwg5GheJo7R635pXIerd4sRf4+bDsDZeSSGnlZoVphDSx0JsiB6r8zGyuhAoCemKL6yK5tl8uxPpAtgnJ72H+j5Wcslouklfo/3bN1AJuUS5q1vnCoiHqj2gqSltwCGhNDDarLcQtH5QfVmbGLaWEiXdZ/CiB1OeGe5cxxBBA16R8a0HzNrjvGtAT/ML46w1GwBoUf2Kdi10bRm7832sjNwwZcjCFY7ABoYaUoAgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icFAh+xM4dH2Aemt9VBNnZ9x5mv+Dfypf6HqHxxJPSE=;
 b=42XIoJHoBLwy6Hl+k1ksMRDi2F887zK54/cXCQ5tmeMMruRGOK9I5VRYgpYvOT8G+2WVVXytSp1EjAHiAhq3OOc7clXfk2mAJb8Nya5hJHnyL9octNvcYOX+QZrjA8hnTmU1vYG1GIx935jK/u1ONCH97Cy3X67g7FHc8XpvriU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Mon, 24 Jan
 2022 07:58:40 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 07:58:39 +0000
Message-ID: <88fe897a-4866-7275-62c4-bdd027789f2a@amd.com>
Date: Mon, 24 Jan 2022 13:28:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 1/2] drm/amd/pm: add get_dpm_ultimate_freq function for
 cyan skillfish
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220124064342.273055-1-Lang.Yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220124064342.273055-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1::24) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ec97956-f1b7-48eb-77fc-08d9df0f5516
X-MS-TrafficTypeDiagnostic: CH2PR12MB4215:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB4215E30C0E635BE4C4832A0A975E9@CH2PR12MB4215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:238;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1D2QYo48X6PdaM/WM79JUUvKB27OTMNQlHSd5OtVrBqoouNJyRwzg5y02wMQWlLSMy5H7RW20uEu2jS/QVQ25b7CjAVQQnOCj/o4Gcwb8G7pjJb/wvFOdldP68ytJr9+LVQmudelleLf2PtblX9H7AGYO0Oo95Tfvzi6fH1k2GKYJWf+yHiOAPt6c5BM3+5tqiSvZvcRf5HYiYepXnKwXRhYRv0PB7N+hrIEE5t5+enjCufCald2KLZORJcAu8Jr34s8I6aQ7TnFt+e+Bn6mzdOobZzRJNcOoFiAk6oTySgRmA0+adITqx2lcdprqOvZIHwVkhOSSO4zDrm1mdyXTOr4cwqWywPUQMh8Wr5v9bszsC5IcZpdmQtefU+z6IIu8DR8dTECsG6G5iyoxkykdWsEpwCT3XO2O2nvNXAYo2EzWGTKLHufP0ZDLX1nszpTllusO8BF71sWRIjqObyqaGxrj58IyyXhnTcmESAb/2ruY1pWzFvXc94ajCtodg/eDKczGfsaMVl/FL3C2rgnk3lDH9kcONcFaZd0iC7tcwrSAM9RYMJFqYbgHx6NLZSrM/+DFih+MzXp/i8NOkWv+x0I6zsKNgq/GPQ3Fm1k4n06NqHJAhdxu0KbK55g400jvzsqf7rxlNsSodESfpsjPcixpY+NbF2l0alRVSoXGssaWpcZmNO3ZXVPfvvDVLYfc3dZ1HxQ+av19DOvPbH08Ej1dAJ5LkBU9oQfYU+Regtuq7LxtCRRw+Koc6M4oUrq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(53546011)(6512007)(6506007)(4326008)(186003)(31696002)(26005)(31686004)(6486002)(508600001)(66476007)(66946007)(5660300002)(66556008)(86362001)(2616005)(54906003)(8676002)(83380400001)(6666004)(2906002)(36756003)(38100700002)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjQzMGFsczhsazdJcHI4Y0VnYUR3cU9pV2NCc2thRXpveXN6ZHZNSWlxQmpx?=
 =?utf-8?B?cHYrRHA2ajJDQSthUUJ4Mm53V3FWTW1PV0pnQ1dPZHFPc1hMSWh3dnNmOG5F?=
 =?utf-8?B?dnJPNGYxVlo0VGhBSVJEVU92bmNEc3Q4VnRjb0VEdXB4QXMyKzI3MHhuQjNx?=
 =?utf-8?B?Wk13NEp4MS9jeHRZZnpRRGVrSUtqeUdDeXJ3eG43azlBTGRxMVIxOUljRmp5?=
 =?utf-8?B?ZGZvUDRRalRFSWgrQUszaGt4OVVhSWxFakxuZ2xFSEFpazdPdklZb0Q3djM1?=
 =?utf-8?B?Wk1FdnlRc2kzeTA4eEFhbDRncEVtTEI0aG5KNWYyckxzWlNYUXJTc3JzZUts?=
 =?utf-8?B?OVJzbEU5eFBtSktwczlsampzRktYMUVaU1pDUTRCT3lRbHo5N0x1UFlMWEZB?=
 =?utf-8?B?TDU2MkVIRklhaW9nZGdLUW9lS0wwbWd3VmJteFk4U1ZWeGdJb2N2RnFwVU4x?=
 =?utf-8?B?UUVzclBkSGlsQ1E0N21ldXdiMmk2VFZjYkovb1VpemNQd2JtaS9LOUI2Rlk0?=
 =?utf-8?B?blQ5RnNydUd0U2FXQ0xwRzZ1bHJjNTlsWHB1VTc0SzVnRWxrcEtxUisxZVRB?=
 =?utf-8?B?YlBOL1FuazRCb1orVTZ4K2tsSUFTTXVSZEhrbFcxemhKcWYxWnZJZ0wzYUNR?=
 =?utf-8?B?UVk4c3htbFM0NmNYRnRIRktTSkFwZG9ZUFk3V3UrZDgxRVNzZGkrMEFMaURx?=
 =?utf-8?B?ZitEenhFYzZxRnNyWkFwZytVOFlaemlUcW80bGxEbUZuZXlKaXF2MGFtY0I5?=
 =?utf-8?B?MGE1OGZLRjFMT3RPUE8yWlc3cWdHRE9NT2N0cHdhd1R1M0Z3UUhHN0NLZFlu?=
 =?utf-8?B?UlVxdDN2YTczaldHOTgwdTJacmtrWkk3ay9mcVNrcVBpOEtGdWpuNXBBMWVm?=
 =?utf-8?B?U01sUytDS1N6TVUvenJ3NHhoOEg3Q3pOcGRjSng1eHlMeDU2dkwwRXJvcUJI?=
 =?utf-8?B?elZRZjBZNDFIM3NzRDdkbGFTdHFiSnFDL2ZEZVc5RVozQVJWTENpN3hzWlBK?=
 =?utf-8?B?U1NSZE12U01YWTlxOGQ3MW1HSS9hL1d1Nk54cE5xZld6V0E0N3JCRWtKYjJv?=
 =?utf-8?B?VnJZRHpWN0hWYnc1bUl1TnZFUEo2enJFczZwSDZHakRjUU0xYWMrdWlFbUtC?=
 =?utf-8?B?c2ppL1REZmVITnRHTmdseEdhUURPUVlUMnU4bnFGWFZZTDN4cUZZYmU3dHht?=
 =?utf-8?B?ejE2djB6bGg3SVlkRmpJem52bnJsNVRZdER6ajVLcmFiTE9uUWIxa01mVUgz?=
 =?utf-8?B?aENDbGJLSm5zek8zc1VMaWpBL1ZvcWFaMVFoSXd0OEkwRVkrK3BsL2Z6NFY5?=
 =?utf-8?B?YTkxM1RmcDVaM1k1QzlhV2FybEFDUHBOd3h6ZXgrT3JUY3duWWM5a2RURHMw?=
 =?utf-8?B?NlBVZ083aGxUTFAvcS9BTEhpL3QvMlNRQ1FSaVcrVjdoMG5DNUdpMHA0Skt1?=
 =?utf-8?B?Q0ZrZTZITmZvM1B0Q3dlTm5qcUdKMkxQS1o4NExUVS9rNTF6LzhvaVFpME04?=
 =?utf-8?B?WktqMjFKRWcxYTlHWGVnUVJtNm1ueW53RzdkbWtmRTY1ZlBJbCt2NUcrOFZX?=
 =?utf-8?B?c2h1WGNUaklxU0ZGRVppUEw3ZGN3bXhSWkh5MXBsU2RHbFpmM1h6MTNEL3pU?=
 =?utf-8?B?bXMzQm55eG1TR3hNaWEyNkN3NnRlNWxzdXRqa2pIZ2RtYjhEZHRCczhLdDFr?=
 =?utf-8?B?dG1SbFI0UHZxUzU0VEZtbzF5ZnphU1FlS1dNZnZ3Snc2SEFOSVBwek9MOXJz?=
 =?utf-8?B?bzRYN0hHdXVTTkd1RWZUYkk5QTBYbDFQMDAwSUFrT0RVNDlCVXp3R0xVcTZK?=
 =?utf-8?B?eGd1YW1XZ3hBNlpaVnNFbGpFakJmemRIZlJpNGdWbExwbDhEczJMdGlJczZT?=
 =?utf-8?B?c1Z1NnBhY0wvaUtkQjZCSDZHVGVaRnpEeDdWSWZWUHJqZHA3M2dwVTBJVmJv?=
 =?utf-8?B?clVFWFpkQTNVNGp5TDlqa21iZGNESmwrb1Arb1pGd0dhR0hnaENLNXYvY0FH?=
 =?utf-8?B?QXJrU1pPNDNZaGtzV1dqTWo3QzEyajFtYlArZ1diYnErNndsS2tnVVo4cnBU?=
 =?utf-8?B?Vk1Kc1pVRXd2MFFwaWtFSlVHelVWMUkxVTUwZnF1Y1NzQTdTYVdDbEtuM0Zt?=
 =?utf-8?Q?sE2k=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ec97956-f1b7-48eb-77fc-08d9df0f5516
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 07:58:39.8424 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6O+/ip7ubQ3OuO1YFNn3qNcEHBuNgASir9SwjBtZfIvy3NFAiTwKVthutlh9mQXZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4215
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 12:13 PM, Lang Yu wrote:
> Some clients(e.g., kfd) query sclk/mclk through this function.
> 
> Before this patch:
>   # /opt/rocm/opencl/bin/clinfo
> 
>   Max clock frequency:                           0Mhz
> 
> After this patch:
>   # /opt/rocm/opencl/bin/clinfo
> 
>   Max clock frequency:                           1500Mhz
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 2238ee19c222..665905a568eb 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -552,6 +552,14 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
> +						enum smu_clk_type clk_type,
> +						uint32_t *min,
> +						uint32_t *max)
> +{
> +	return cyan_skillfish_get_current_clk_freq(smu, clk_type, min ? min : max);
> +}
> +

I see the below logic already there and this patch doesn't match with that.

         case SMU_GFXCLK:
                 ret = cyan_skillfish_get_current_clk_freq(smu, 
clk_type, &cur_value);
                 if (ret)
                         return ret;
                 if (cur_value  == CYAN_SKILLFISH_SCLK_MAX)
                         i = 2;
                 else if (cur_value == CYAN_SKILLFISH_SCLK_MIN)
                         i = 0;
                 else
                         i = 1;
                 size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", 
CYAN_SKILLFISH_SCLK_MIN,
                                 i == 0 ? "*" : "");
                 size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
                                 i == 1 ? cur_value : 
cyan_skillfish_sclk_default,
                                 i == 1 ? "*" : "");
                 size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", 
CYAN_SKILLFISH_SCLK_MAX,
                                 i == 2 ? "*" : "");
                 break;


Thanks,
Lijo

>   static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>   
>   	.check_fw_status = smu_v11_0_check_fw_status,
> @@ -565,6 +573,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>   	.is_dpm_running = cyan_skillfish_is_dpm_running,
>   	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
>   	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
> +	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
>   	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>   	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
> 
