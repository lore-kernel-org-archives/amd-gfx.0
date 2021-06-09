Return-Path: <SRS0=4Mkx=LD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2A1C47095
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 04:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E36FE60C3F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Jun 2021 04:14:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36FE60C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9591F6EC78;
	Wed,  9 Jun 2021 04:14:12 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D295E6EC78
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Jun 2021 04:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZX2L8SlZJirJ+bemzhI80pNhwrDYIYgIeakcpGmV19w29jdtSnNri/s840zdYY2mdJJCTPK2gHL6rHR9UESnCTNSih6qp0z6SE1nnKK7R5f1lgAAh85vRPfaALjUrC234bO57xFOYzpliQ51BOjIB4fIb2+lSXbBXK3+LZ2SK1oDgoKaPJqihgiJw4gpriVj0VqCQGxUAZkPxzmtgoC0G/2saJkG2CHomT6KEAeLZyCzl/b1osEIRzIxYvORpWmhL7tg7MmbOzMmc2nIRRvtgpEGTEgkhy2uNKnM5brGM8nfup7VRWtXYd5Br/YKj5nKfUs1JnsFPOju8siBhb1OQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nTxfYaZOasCuSDFrLZc+b/cBmU4roe6qCEvAZYI9dY=;
 b=JPKFDtEA/3+8X+DljPLa+21TojEldPX7xjNfXFak6017OGgbmS4DpZLnYlBZGFzmIDNa4MB0O0Ghh23d/OGVNGuJhEaskKRs6XHoB2z/296dnAd1DqvPeUyy8ondSvqRU8mPpzAqlAdajBUlm4e9AeAnpnoW3p7mE/ntYAWa5O5SNctQC/uufZPByfhLtWyjwe1Y31IwqrPxo7yYZ4pyx2O4JrssG4OuGjqmaa5qoKYA9Jtk5tY1OTVwyO7KqaBhYKYlP7LujjcSnzfaAC54ifMcua95ROUPjWnpY1X0+bbfrUHCC7hOMR+mNq+CjF5Gqr06DHpX7LXUJFCPzwVAjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nTxfYaZOasCuSDFrLZc+b/cBmU4roe6qCEvAZYI9dY=;
 b=o+kuFTZDe7EZUkSzbOEPq59YoAwGfat4iJVxtAwCIbBNgyjNqymFuff9BexH5i/HahknuP88qJ0fbS8tCwYDcYO4XfBUtllf7CNy30vk1dKxnbPQdG1nC6EYcCu+T9/keE19wSuAInEFyXf3L3cYySldzGVqV1FBDDJvkT4prpY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5348.namprd12.prod.outlook.com (2603:10b6:610:d7::9)
 by CH0PR12MB5235.namprd12.prod.outlook.com (2603:10b6:610:d2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21; Wed, 9 Jun
 2021 04:14:04 +0000
Received: from CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9]) by CH0PR12MB5348.namprd12.prod.outlook.com
 ([fe80::80e7:eb2e:843d:91e9%3]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 04:14:04 +0000
Subject: Re: [PATCH v6 1/9] drm/amd/pm: Add u64 throttler status field to
 gpu_metrics
To: Graham Sider <Graham.Sider@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210608150810.9679-1-Graham.Sider@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <0fbaa658-88b4-e6f9-1b15-e6a056dea7f0@amd.com>
Date: Wed, 9 Jun 2021 09:43:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210608150810.9679-1-Graham.Sider@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::19) To CH0PR12MB5348.namprd12.prod.outlook.com
 (2603:10b6:610:d7::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.81.250] (165.204.159.242) by
 BM1PR01CA0149.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:68::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.21 via Frontend Transport; Wed, 9 Jun 2021 04:14:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a8e0674-5f77-448a-2e30-08d92afd04af
X-MS-TrafficTypeDiagnostic: CH0PR12MB5235:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH0PR12MB523551C2E6F0332AA8731DB797369@CH0PR12MB5235.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NXMzOd3+2AeazMy5lQF0Dn6H8W41rEmG+EV2NwwMg5IcElfTvpMFMNOw5njwhs7P4ieXjQnd0eL0ddZI03VJ/XO1pnw7Um+AzaMP0FuYXNtn+jU5yKctc9AjNPyfXt079vCoHRyajcTbTuMExkzlqD//lkozJus8NWN6wfFlL2md+vJxhyYzEYqhGn4bC/LLQm/fK6lPTe2DxbfhU9cW0EE8L74drJnW1XD4NDcmtFNQu5YY4kHdvj0vv2nqYnf9An0Ka37VmCpNSF8Mz04ynYubEHNg+JWrNvHHZMqz16l8P55O/V1shJWW7fpfemeelGhpI+98xCDPW065XTtQ6KYTgXBioaeWG6XXdXrB29hVEnMlFiSiBmV3ZndqfILUE714Fvwu3YcISLaR9zqJ15s/S7QHXRVahE3IK1xgYKge4SRHE1W3Mq2mLYW7rxK4wy1EYmr2D5WaVZ1Zgvfb8qhrfl8X2lpyx0WbAyeczwdDmJWJk2aUmzyLKng0VrADh94ZnsgHP61GJbC2d/0f4SD1bxSrz4Es5um8XC9KQaPF0LEo7Rgvy4Bg9WnmLW13zolwq8OuNg1Y8TV1sIHvCjJdK9M6vNbKETLY5tgKHFY7ViyLRTA31unE9G4biMcZrCL0YgSBmuWGH0KXqZQO+5+omkbDI1NvUyhmnsZz/h0RxsdnXvFseQzw+8VU3Gyk
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5348.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(376002)(136003)(366004)(346002)(8676002)(316002)(38100700002)(53546011)(86362001)(31686004)(4326008)(956004)(5660300002)(478600001)(26005)(186003)(16576012)(8936002)(2616005)(16526019)(6666004)(66556008)(66476007)(36756003)(66946007)(83380400001)(6486002)(2906002)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky92dnVpMU5OZWczSEZpMnowbUErendRR0pnTW9jbndVR3RkZWZ5K1pwVkR6?=
 =?utf-8?B?bTRoWW1pZmQ0b1BhMFl3WHdTU1BxcXZlS0JYM3h1MHhOYjJHdWxLK2s0NzBs?=
 =?utf-8?B?dVo5TFVCM3d3TFRpQStVcGJmZnpJTnJIZ2NBRGhoZUpjb0MyVEtPVk1OcFRG?=
 =?utf-8?B?Q09BdElnZE45N3J6RmhTMHkxVU5Iazl4bkpGVURBZHRaT2NsUm9IbFhkaEx2?=
 =?utf-8?B?YVpPOG9KNjJvMWwya2RpZEJobkU4YUlRRjUrTUVFTU9GTFF0N04weHYzREVo?=
 =?utf-8?B?UG1tZHo0SElpcTFVeXc4ZU1hQThuVEZaU1pwTGliRmNzY09KS0grcWI5cFgr?=
 =?utf-8?B?SjZITXhISG1TVEd1ekd0aUdXb3VQcHFPcXhkdFNVY1VjYVhmUTRKTGVKekg3?=
 =?utf-8?B?cGloQmIwUVpoNHpvVTBPVHd5d2RvWGdmaWVaQm41SzBsWXpPNkh5ZVVsZi9Y?=
 =?utf-8?B?VjBnUUM0MThtU1BGQ3lVRS9ETnZ5Tjl6Y0J6SFUrS2VmcTlEYWhSZU9Jc2RZ?=
 =?utf-8?B?S0VLVjZVVzlSelMvdjFXTitiTXptVm9mZ2M1MEZBZXd1YkFMSjFaUnRVNXha?=
 =?utf-8?B?cVJuL3RKNWZBbWhocFk4NTFJZ0prWmJRWE9KRmxOTkNPdlgweTVJRGN1MmZn?=
 =?utf-8?B?amtoeW9jaTZWd0Y4U29JSzcveXF0cDhlZGpTSk04QzhXdlRTaFR3aU81WEJN?=
 =?utf-8?B?dG1sL3FqSkpJaFNadklHakNCRFp4VWhFVkxmeVI4UEJ4YXl2Mmd2VnJBNnhS?=
 =?utf-8?B?eUpPQU51TTV1Y0JmQ1Bnb1lHTVM4NnZ6R0pBYWJBWDA1cEFaRFlXQVJlczIr?=
 =?utf-8?B?SDRiU0g5SkJXVUkrQjZuTW1JRlUxalRrdWlaWXp3WmRadUYySUpzQ0hTYWJ5?=
 =?utf-8?B?OHJ5V0YwMU84MStZbU9ERDA3YTZCUW5vL0kwaXZmTXBvbkNGQS9YRVA5S21P?=
 =?utf-8?B?RWFnQkg5dHNZdmJWU1k1d0hpK3NCbG1ld05oR2JpNlM3a1VhOXNINkFNVTFi?=
 =?utf-8?B?ayszTnp0dncrN0Y5MDMxNjd3MVdQMk4yNzNCMXJEcDdnTDkwbmpneWVRWXor?=
 =?utf-8?B?ekdjWm1XckZJeWdiQ3dBR3RHYVJkVnpZV3BEU1M5M3RiUVVUdWdxa3cxb2xi?=
 =?utf-8?B?ODBLVnF5dENmVzZQTzF4a3JkejdtUk1PRGhmbG9ub2U1Z0FHb1lGejJ3bzE3?=
 =?utf-8?B?cTU4N0dIK3pnY0xDL2k5bGxGZUhjL2FQeGN1NlRzVHNaTThwcUNPT1JXRHd4?=
 =?utf-8?B?aXBpdTN3bFJQcm9NcURldDBGSS9KWUVOcVpSK0V0ZDE4MklRY2h0ZFZVeHNL?=
 =?utf-8?B?enZJWjJpeVpoT0pBNHBySGZLZGlrd1A1OWJQMGxnNGFmSGF1YStVaWdNeVQw?=
 =?utf-8?B?V2tITkkzL25lTmNraWhOZlpwZE9GcTM3UUFUMytzZitFVmkrV0JZMS8yR0d0?=
 =?utf-8?B?UU1hN01ib1pEUjB3RGlDMFhEcnp2SHhydU1zbDFoUkF4L1RDaUlvbUtrNzlG?=
 =?utf-8?B?aHBKd2dXN2dsMkFLc1hDd2YrMi9wNTVnN0R6Zm9HS0Q5WmtpZGI2Nk9iTVE2?=
 =?utf-8?B?cTBqbUY3RzNKamFtWlhXby8rQjNpRFIybVU2eXA2T0oyM2Y2UFhyWU9EbUJw?=
 =?utf-8?B?SFA0RGNrcnVuWC9STG1oSDhYNnF3ZG5rWWRQcVNTaGVaM3M0LzRSUUQra2VZ?=
 =?utf-8?B?MjB6eC9zNlVJTFIvb29vckkrOWNyU1pvYUtGaVExUWJPOUVLYmVQVFFBa2Uz?=
 =?utf-8?Q?rNYAylZpq7VEviPn/Uim5QLQ9mSnwvVApb//rjT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a8e0674-5f77-448a-2e30-08d92afd04af
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5348.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2021 04:14:04.5239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+POew5gO8jGWwDltAAKnAWuy/QUemNbb+ZY+gwU0FUeYw9WNQG4LjUIsJLpebOD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5235
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
Cc: Harish.Kasiviswanathan@amd.com, Elena.Sakhnovitch@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

On 6/8/2021 8:38 PM, Graham Sider wrote:
> This patch set adds support for a new ASIC independant u64 throttler
> status field (indep_throttle_status). Piggybacks off the
> gpu_metrics_v1_3 bump and similarly bumps gpu_metrics_v2 version (to
> v2_2) to add field.
> 
> Signed-off-by: Graham Sider <Graham.Sider@amd.com>
> ---
>   .../gpu/drm/amd/include/kgd_pp_interface.h    | 58 ++++++++++++++++++-
>   drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c        |  3 +
>   2 files changed, 60 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> index 7bc7492f37b9..271018ce739b 100644
> --- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
> @@ -579,7 +579,7 @@ struct gpu_metrics_v1_3 {
>   	uint16_t			current_vclk1;
>   	uint16_t			current_dclk1;
>   
> -	/* Throttle status */
> +	/* Throttle status (ASIC dependent) */
>   	uint32_t			throttle_status;
>   
>   	/* Fans */
> @@ -605,6 +605,9 @@ struct gpu_metrics_v1_3 {
>   	uint16_t			voltage_mem;
>   
>   	uint16_t			padding1;
> +
> +	/* Throttle status (ASIC independent) */
> +	uint64_t			indep_throttle_status;
>   };
>   
>   /*
> @@ -711,4 +714,57 @@ struct gpu_metrics_v2_1 {
>   	uint16_t			padding[3];
>   };
>   
> +struct gpu_metrics_v2_2 {
> +	struct metrics_table_header	common_header;
> +
> +	/* Temperature */
> +	uint16_t			temperature_gfx; // gfx temperature on APUs
> +	uint16_t			temperature_soc; // soc temperature on APUs
> +	uint16_t			temperature_core[8]; // CPU core temperature on APUs
> +	uint16_t			temperature_l3[2];
> +
> +	/* Utilization */
> +	uint16_t			average_gfx_activity;
> +	uint16_t			average_mm_activity; // UVD or VCN
> +
> +	/* Driver attached timestamp (in ns) */
> +	uint64_t			system_clock_counter;
> +
> +	/* Power/Energy */
> +	uint16_t			average_socket_power; // dGPU + APU power on A + A platform
> +	uint16_t			average_cpu_power;
> +	uint16_t			average_soc_power;
> +	uint16_t			average_gfx_power;
> +	uint16_t			average_core_power[8]; // CPU core power on APUs
> +
> +	/* Average clocks */
> +	uint16_t			average_gfxclk_frequency;
> +	uint16_t			average_socclk_frequency;
> +	uint16_t			average_uclk_frequency;
> +	uint16_t			average_fclk_frequency;
> +	uint16_t			average_vclk_frequency;
> +	uint16_t			average_dclk_frequency;
> +
> +	/* Current clocks */
> +	uint16_t			current_gfxclk;
> +	uint16_t			current_socclk;
> +	uint16_t			current_uclk;
> +	uint16_t			current_fclk;
> +	uint16_t			current_vclk;
> +	uint16_t			current_dclk;
> +	uint16_t			current_coreclk[8]; // CPU core clocks
> +	uint16_t			current_l3clk[2];
> +
> +	/* Throttle status (ASIC dependent) */
> +	uint32_t			throttle_status;
> +
> +	/* Fans */
> +	uint16_t			fan_pwm;
> +
> +	uint16_t			padding[3];
> +
> +	/* Throttle status (ASIC independent) */
> +	uint64_t			indep_throttle_status;
> +};
> +
>   #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> index 0ceb7329838c..01645537d9ab 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
> @@ -773,6 +773,9 @@ void smu_cmn_init_soft_gpu_metrics(void *table, uint8_t frev, uint8_t crev)
>   	case METRICS_VERSION(2, 1):
>   		structure_size = sizeof(struct gpu_metrics_v2_1);
>   		break;
> +	case METRICS_VERSION(2, 2):
> +		structure_size = sizeof(struct gpu_metrics_v2_2);
> +		break;
>   	default:
>   		return;
>   	}
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
