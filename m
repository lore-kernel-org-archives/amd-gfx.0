Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89823C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 14:26:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0D7B10EB91;
	Mon, 24 Jan 2022 14:26:18 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2055.outbound.protection.outlook.com [40.107.96.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A973D10EB91
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 14:26:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeC1LI2Kn9+Ml8jayCw1Tzr706KSTXlvROR6Eg0fAU7I2K6re5Yh+sGBUyIO6WVu5rHobwYsX/lh1rQVMnY/oCP1WJ0TwjFf6zdVEds8fcnoC3q7zY4wUWSPj+O79GRK1+kgc5yh+poMM/uGAgKFgVQz4TyH5NL9mwC5wTX4bni1swQVy8hkiymLCUod6bJrm1tkjGuG9VY7mxhtbjfvgpDOjpzIOO+kqdkqFA+H5QKyywrAimg6N2KY0OHHmWqf7qT/lYzt7EaLS6Vi7MgqEsCb8q8G24ZYTvT2/iQX4CasxfvIw/RV/7HbnfVqf78ylxReHCwaNjai11D32kEjjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1X3waT9LpBUdy8nFJMxvvjuDWZZlCBEZwtbUjyESDY=;
 b=gkKJrOBRxzp04vGvxDLuM79wumoXA+JUkpSzuU8jEQhgt0AWaLtXD+Gq+skVQOUxEYBI0tElX38xtiev7o/c00KElYuW9sCOPHUdi4xhO7wWyB/kFhpmzmOoNLxMOodAkJUprj6Y7pM8460A1jK7pzzlod7Dkp+IcaCCcpzeiqLzJPtgyzpflZZZ5rOgi9FHD30pyQow8XYXFDuBrakBZaCmbvtnOTBJOhRCt3eYxvZvtFgilNn0Nr036H0kDsMb90LYUBbDdrRWeKqGxNLBH6k/De/hLglwCpIjqccJx6NRXiuCHXfXzN/ViV2lzGe648WbhGQTXCAX+AFcp2cuWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1X3waT9LpBUdy8nFJMxvvjuDWZZlCBEZwtbUjyESDY=;
 b=seU4guEx6NHKk7CNDNf8EWWzZHOqDq3j6LO0ozo6hETgqTDH6YXtRI36hXuXtcQdzUpsZmE5CuPlX+z4AExKr3lIaoYk33mdGSGz2gBC9KTKHkpv0YZth7u12D7dsoblw46ADy3J/zZk9NMwC4RHTIYSfACQqgXmG7O5D4ae7WY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by BN6PR12MB1412.namprd12.prod.outlook.com (2603:10b6:404:1b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.10; Mon, 24 Jan
 2022 14:26:14 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 14:26:14 +0000
Message-ID: <8b960068-16d5-f6cc-d326-bbcdda4917d6@amd.com>
Date: Mon, 24 Jan 2022 19:55:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v3] drm/amd/pm: add get_dpm_ultimate_freq function for
 cyan skillfish
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220124141609.395703-1-Lang.Yu@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20220124141609.395703-1-Lang.Yu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::11)
 To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d345d0d8-5577-4874-6092-08d9df4579c1
X-MS-TrafficTypeDiagnostic: BN6PR12MB1412:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1412D4A92224E14A9F6979DD975E9@BN6PR12MB1412.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VYSigYU59syqFEcTZEgyJG7piTYQXbzk5P/jITjDurPM0tOmRSm5WWyk/aA+Mt77+2dW0bjU7FwwjwlbdJVrFHv0B9dLJSCDg1EVfGG/tjwPSboTuEoq6LXpIxWbSyqlLrSl0o4ccbguZSjz1hXZdqvp6UMim3VUKglfjEaDqEsUw/8WnXpFkHRroq6KYzoLkUNaFqh1wsIyKwH9sM9R3bWQNGdbj9EVWpcb4/FxfATB0euJfQSDQHeJRaENrAqgYMfwt/qMMRmW7Hd4exdwvcWgVuihiuslkTHsb8FKVr+mrRjhpT7h3Fvx+1yB6J3pQow8WZhkzSB1ssC69ZQxE6wlvyf4ky1srqnt7NeZyegiWLMLmzmcc/Hu8X7/h2WkfPizT7ijFoupof8SkbVNb6aAQVtKTTh77Es7rYAbhzacet0oyB6hh6O2dQffJHJLQzasI7dau6psw2gDP2UAGJAKRBoP4QoXjpY0bE1aeV6BxD07JjKLXpOVUDjNKrEsagGFZkeFoQdpWOv/4st9o3ZJInFx1qu3nNf2Xh2ATgzYISbhOdDo/x1lp0D6eFXxg5QsDNtinArGsa9FDTBjKs35xQ67gVmB92+s/mz+Bp/9kdt5DeC/Ldvavo939iYueotG4LHPlzPM1VhgcKHhT+lNArJJ4nXa3mQipALMCLbSpY2QWymJR1Mrs2dinnThLWYaAVWT2IMdwEUuSmhA4aJilo/qzkTrYPvNyn82FiCr7V98e6ETXNMeSNzYIxCX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(83380400001)(31686004)(4326008)(6506007)(2906002)(6486002)(31696002)(38100700002)(66946007)(66476007)(5660300002)(8936002)(26005)(8676002)(2616005)(508600001)(186003)(36756003)(316002)(6666004)(53546011)(86362001)(66556008)(6512007)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXpTZy96MHJGRUF0TWpSd2RwZUVHMXN4eUZpb0Z5ejZ2OWJleW9KTnExOUFQ?=
 =?utf-8?B?cGJrczRrbEdpNGFOaHhaZkpSb0p1S1B5OEtXN0U1alcyYzhJOGUxUTZuc1Fl?=
 =?utf-8?B?V085ZUxacU91Z21NdUpOL1RpemVPZkxOcm55cHZmTGhmVFlPZSs1cnZ5YzY4?=
 =?utf-8?B?OU5GRmVzZmhaM1d6WndXeHg5WTd1aG4xRVJ3YTdNS0J4OUNsOVMzYTc1Z3M4?=
 =?utf-8?B?aEtxbkZyK0RzbEhEVlliaUZMdElJcHJnVzhSS044dTUwdU40T2d1SmtJRjhx?=
 =?utf-8?B?OVV5a3FiTC95OFEzNnB2M0o3OTJLVHBaZDZXMGU1blRYUGswOC9yaUpmWUVv?=
 =?utf-8?B?d0lEZllyTkdJa3E1WGNnTkt5OGRkOGZzT1Q4SzZDQlRmSWZZRnZlZUxWcmZX?=
 =?utf-8?B?ZjdmcE90azg0Ym5kV1FsVDhDR2VjbFo3cDg5eE1BN1ptTEVYYVdUd1VMSHNQ?=
 =?utf-8?B?MlZrRXdWaHJJdXRzZUFWTmpKczBhK2JIdkw4RXZGRXBNNVpiSkgybGxzQW84?=
 =?utf-8?B?b3BucUJWd2lxelJxekU3VU9nVmFVOW5VclRuWHlhSnl1bytsdEJWdHpPS3Y4?=
 =?utf-8?B?a2lBQnNkMkxFSXBBMTlTN3h1aFpzTDlBVWdtZ09LZHFIeVNyblE5YUc0OFpz?=
 =?utf-8?B?N3BYOUFrNEhQaFdzb2dXZW5Hb2t2aDN5WDRSOGlZTjZHTzE5eWM0R2liNFhP?=
 =?utf-8?B?bkczUE45aWxiMEF2bGRRM2RKdTVZUEZHaHBkUWg3UmdqY1g4K1JKL0t4NVBN?=
 =?utf-8?B?TTFzKzFJN3dGMDVwY21qb1kwYW5rWW5MYWRhVlJYZ1NwZ0JvQm5zcUE0TWJD?=
 =?utf-8?B?NU1JeGVaM1psVkIwVjJTNGVZN0cvL2pPVU52b1hyQUt5VkhSaE9mRUpLb09V?=
 =?utf-8?B?b25KdVpNNm9IR2ZzRFpZQk93cENORGJabW00eEpxdmNiOWRVSlFLVTd0Y1RI?=
 =?utf-8?B?QXFCN0c3dW9CMzFjT0pNeHZyQ01NMktSd2R5TkdQSVlHZzhrdTdsaWZxd3Zr?=
 =?utf-8?B?MEJqRlB6Z3dFUFpqR2o2VURDUjEwWWZyN2llNFhXR0pBS3daNEFZbXdZMFFY?=
 =?utf-8?B?KzY2bHJXSWFmLzZmUnJIeS9hR1Y3STRpT3FQdjFNTGlYdHU5aFFzN3hrU0pn?=
 =?utf-8?B?Yjc0TklEcTZFSm9QTUR5SDZhRkxtcytVL2NpK2FzN3hYM3k0Z1VWU3pCeTNr?=
 =?utf-8?B?bnVYR1JVZnZ4YlBPK0paYnBFNVJCZlk4bmlxWjFQR1FrWGZta3VVUEdHTWph?=
 =?utf-8?B?L2NBNkxtTE1WWlVQSUhxZkczMkRjWFpZZDRtU2FhN3c5cGFiT1FzRVp6ZEh2?=
 =?utf-8?B?eTBKZmlVTnF0SWkwY1dXblNVNGc3Yis3dEpzK1RVQk1CcWRBYm84S244Y3ZT?=
 =?utf-8?B?Rm1KRE1seENGZW5Sa1FYUjNDbFdSY1oyVmhPZVZlZDB4MnNscU4yeUpldEdO?=
 =?utf-8?B?SGZWc2xGWWVVdnQvdTNMZElnWGZIQnQrOVZldUVrR0hkcjNnYlk0anN6WDFv?=
 =?utf-8?B?cG9GWXIwRkl3YUtKVEtQdno2SGdDWjJIN0lLaGo2QXVrcTltcHFvUDlCd2Zy?=
 =?utf-8?B?a1N5VTVNTUFHZERaV0NOeU9pSGxLS3JkSjd5d2FlRWpIOEdEN1YvVStlcHI3?=
 =?utf-8?B?eUpGZExhUklMQzNIT2tZZys2Z05xYVd2STI2V0MzVUdGOWF1ejE5emJ5eDEx?=
 =?utf-8?B?S0FwVzNKZkxaRUcrcWdjWFdmVmtQaDIzU3Nwdkh4ZkZOSTdvUzJsMzdvbEpO?=
 =?utf-8?B?QUpoY2o4RTd6VkticHZtVXBnSHBtNjlVRmF5YUtoVTROVmJvRFU3UkxWRjVR?=
 =?utf-8?B?NGwvMzhRMDVCTWNJc3phWXFiT293STg4M1ViQWZOOWdoUUJwUnZ5RXhWMGYr?=
 =?utf-8?B?NExMZUpVZmkxWkZ4a21yTXF0dkJYZGlaamxwMHQ5cDZqdGpFZFcvZGYyVU44?=
 =?utf-8?B?TzVGMmxhdEZmdVowTnM4aXVCWnRIemRXUzhQOCtFYkduak9JVyswSndzUWlP?=
 =?utf-8?B?WGorazVkd3hsSDRFU3VTd1F5a2Q4T3E3b2NOL0NWMXd3TWNnM0M0L1U3eVh1?=
 =?utf-8?B?QkhIeUtTY0kwR1oyaDN1NHVWUE8wcXpWbXZNam5xN1V5TzNTeStrYXl0cWFT?=
 =?utf-8?Q?mrgU=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d345d0d8-5577-4874-6092-08d9df4579c1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 14:26:14.1995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SSVZSUvg0V1zcVDwQ0etidXn1C4RdIboCIBcaBbK0s0a+O2mKLhgLpaXeAYuJ2is
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1412
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



On 1/24/2022 7:46 PM, Lang Yu wrote:
> Some clients(e.g., kfd) query sclk/mclk through this function.
> Because cyan skillfish doesn't support dpm. For sclk, set min/max
> to CYAN_SKILLFISH_SCLK_MIN/CYAN_SKILLFISH_SCLK_MAX(to maintain the
> existing logic).For others, set both min and max to current value.
> 
> Before this patch:
>   # /opt/rocm/opencl/bin/clinfo
> 
>   Max clock frequency:                           0Mhz
> 
> After this patch:
>   # /opt/rocm/opencl/bin/clinfo
> 
>   Max clock frequency:                           2000Mhz
> 
> v2:
>   - Maintain the existing min/max sclk logic.(Lijo)
> v3:
>   - Avoid fetching metrics table twice.(Lijo)
> 
> Signed-off-by: Lang Yu <Lang.Yu@amd.com>

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Thanks,
Lijo

> ---
>   .../amd/pm/swsmu/smu11/cyan_skillfish_ppt.c   | 31 +++++++++++++++++++
>   1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> index 2238ee19c222..dfc5d6801f9f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
> @@ -552,6 +552,36 @@ static int cyan_skillfish_od_edit_dpm_table(struct smu_context *smu,
>   	return ret;
>   }
>   
> +static int cyan_skillfish_get_dpm_ultimate_freq(struct smu_context *smu,
> +						enum smu_clk_type clk_type,
> +						uint32_t *min,
> +						uint32_t *max)
> +{
> +	int ret = 0;
> +	uint32_t low, high;
> +
> +	switch (clk_type) {
> +	case SMU_GFXCLK:
> +	case SMU_SCLK:
> +		low = CYAN_SKILLFISH_SCLK_MIN;
> +		high = CYAN_SKILLFISH_SCLK_MAX;
> +		break;
> +	default:
> +		ret = cyan_skillfish_get_current_clk_freq(smu, clk_type, &low);
> +		if (ret)
> +			return ret;
> +		high = low;
> +		break;
> +	}
> +
> +	if (min)
> +		*min = low;
> +	if (max)
> +		*max = high;
> +
> +	return 0;
> +}
> +
>   static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>   
>   	.check_fw_status = smu_v11_0_check_fw_status,
> @@ -565,6 +595,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
>   	.is_dpm_running = cyan_skillfish_is_dpm_running,
>   	.get_gpu_metrics = cyan_skillfish_get_gpu_metrics,
>   	.od_edit_dpm_table = cyan_skillfish_od_edit_dpm_table,
> +	.get_dpm_ultimate_freq = cyan_skillfish_get_dpm_ultimate_freq,
>   	.register_irq_handler = smu_v11_0_register_irq_handler,
>   	.notify_memory_pool_location = smu_v11_0_notify_memory_pool_location,
>   	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
> 
