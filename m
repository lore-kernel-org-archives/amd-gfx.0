Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C8CC04A95
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 15:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B034010E3CF;
	Tue, 25 Oct 2022 15:41:35 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 260E410E3D7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 15:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AAD9JlhuLIxQ06YOjhqWzSK+Fbfs9UTzsDeHama1xCRFfJec6W291sgQKEAlLJX9LXI0HquuwmJbUMkkfDCY94gP9jtzM2fPtYNUKLAl+Sfz7dI36apRPlxYiL6B9RarxleArzGdOHX97pv/ah3KEFbC9M8i9bnBGK4ClzZO2o/Nli1oLjOz/cEs9sJpxREwkLgHdp8NE2Oo1j/uOIUA8I3dsz91ufK9GdB00fTu31M1E+no+ud5BWX8BmGmRgIhQTIXKYxOe/UduJDeScUwjrcyQuU3MJTe27lzzaT+WSfH+pBjrlfpjNHyjWJE0q6Oa4zQUm1mvyLqeochUR7M6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZY5gthqTzOss1ed9lckN+gJAS9bBQ1M3pAvUfnmEck=;
 b=KmgIFEFeSb5PHbfv+7IEFvZI8df7yhfjnj6nlx2EW0QFSJhBaLHVznthmedIUpfz/YeC0sHdyPHUdI+Y16a79rd3od5RLuRt//E8jxLM5uME86lM26GkPS3a53LKWZCG03Gq4/v57MqvOXYdTtqImWYwuXKK3l2YGko6a0GeU9GLycmT6Vz0kIFzXH6Vt34Dn7wOLiHZJf2z/NDWQnf9rBWdBXibhFyX64jfXlriISHij2OLcL4fdeK4w8eg8boQeWIAiVJfZrXH/vwkqq81C0f8ZzPfaGHnlWSWjGFmYAxkmiTIWWvqE3ZQiPOkU+uEOZ1tfe8c7/cxMyxvAbQmeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZY5gthqTzOss1ed9lckN+gJAS9bBQ1M3pAvUfnmEck=;
 b=OG6auRBvyIgBotCP78DG/l/cNkulaM7DtSxK2Y8CLA3MIfRFgyPTLeQDF4zTDxA/cuyybKIxhhuuJcpLTzYyOMac2zcBT8W7+Q/NxSkRSKRpFe2YcxyFH6qqyEPa3qYZAHM0pmSYG53m/IHveldhKAueFduLgr0vpA6BZW6/Gi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by DM4PR12MB6011.namprd12.prod.outlook.com (2603:10b6:8:6b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Tue, 25 Oct
 2022 15:41:32 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5723.026; Tue, 25 Oct 2022
 15:41:31 +0000
Message-ID: <e4440d8d-61d3-5d71-ba48-79fec268f4af@amd.com>
Date: Tue, 25 Oct 2022 11:42:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH RESEND] drm/amd/display: move remaining FPU code to dml
 folder
Content-Language: en-US
To: Ao Zhong <hacc1225@gmail.com>
References: <0115eee0-1384-cd9d-22c8-7dfcc9d754e3@gmail.com>
 <20221021003114.25881-1-hacc1225@gmail.com>
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20221021003114.25881-1-hacc1225@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0013.namprd05.prod.outlook.com (2603:10b6:610::26)
 To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|DM4PR12MB6011:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d4594fb-d220-4cc6-d0fa-08dab69f63b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4vjlkLaLXxZk/JuLIJUfDhYzXNRTAIWyIxKZVnEZBDzIsXrNuX9c8OdoC4K7O8ol0hYwBg1t++i1L6PBUHGs74qdtaJ0/rS0/bu45wGyMrs3BQzcOQcD3G81WkWqKyRVmgaIOQ09OsViUQqYvTsd0lovKZoTlAMo98vGOZwXll0+TCPP9aTOv8Fo5g0fnBsbPoNG1HjEO6Q2Mp1NiYVC4HFtnCtKo1Ls4qJ8fAI6C7KzQSiex900SijaQzNzfuR7I2vBpEkIy9sQWFh64vCwsV/xOJerFLib8+tzOJ8flc4Ox8HgQHKAN96ImfCLbS1bGo06Y8wMhL34Oq9kBpEM7st5knh2cc6dPoOIj2/RR14qXrl8MctiStzRn2SgB01qhFvJc9ADGhDDwq6behpyEHFxnYyQtTRR+0U3vSwCFhR1LgD+A5iFVdAZFaendPzF5hHFKVm4fAhPc6vUOgdJ0K/UbEwYrdqiQIb0s9nib+tlH34kqBiq1PgP3wY2K7hqORGeHws2aUvHBSvcF+UwxYXquJVIIuJlffQkMPn96Kbx7Lx6zIiQDmeH8pnl59p8Fshpm4/WqHpz+4YUibU4wkorosT2go7Z5k65lxayV8b6SGE0eDx2vR0H2v3MhsROa3dCaGswKyC799/mIbkOszR7MjrX0Y+AS0TmWjrkH8/wEZ2JeMLknzfv1NhiDdzPq5Ycr8fvclaUCOTqbKQb6m2BmWSG/X+ersloIECbpGOmNpXC0FhuU4WrOW8LHHlCK3WzmbYlycAHF+1lejEIyaGkvmYFkzVt2Xv1jQ76ILw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(376002)(136003)(39860400002)(366004)(396003)(451199015)(478600001)(316002)(6512007)(2616005)(8936002)(41300700001)(186003)(5660300002)(6666004)(83380400001)(66476007)(6486002)(54906003)(53546011)(6916009)(66946007)(4326008)(8676002)(6506007)(66556008)(36756003)(31696002)(31686004)(86362001)(38100700002)(2906002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWxlZzNQNEJDT0dWWmVyLzVKWkZOWlYvYlZka2ZDMzVPV3BtS3pvdndCSGFU?=
 =?utf-8?B?QVdncTZ2NTVscXlmRXZ0RXBsVXFmYjFaWFpLMHJKWXdsUi9OMjRZNmxseU5V?=
 =?utf-8?B?NnBzYXFDMk1NRzFuS2J6MGozUWh2YzVMSTAwVjB1K3VOSTUvN0hqZFhtZnJ1?=
 =?utf-8?B?aktGWWE1d3VydjY5K09SQ1NhRHcyYlJqbnFxZFl6c3BZclhDY2gwOFdOVktr?=
 =?utf-8?B?OGRFN1gzcDRWZVprOEJydDY4UHN5dTR6SnNrNlZkWU5ndHFSRHJ5UGdWZ2tz?=
 =?utf-8?B?Sjl0ME16QVJyaFo3UGVHNWtkeGtzWk93b042V1Y2WjVRUFZBTWtpWTFzVDlY?=
 =?utf-8?B?WG0yV3hDL2d3WjRaazVrY2h0a0JuR04rc2ZnTWZZbUJRQTNWcDRCaUw3OGJ3?=
 =?utf-8?B?Vi9ISFh2amp2QkxrSDJPcWlpZHJtNU5vdGc2VEZqdEhFaFBUK1hXaHlZZ0tS?=
 =?utf-8?B?S0ZTVUtPclZ0aUhzZGU5NGpPQ002M0dRbkxPcjgvTzdCTWwzMTA2Z1BPQ2pP?=
 =?utf-8?B?ckluWldTdGFEc0s0QXY1RmwxMlZub3lUNVE0bThKdnN1ZVhTQnY0aXIvNStS?=
 =?utf-8?B?NXJmQy9NWHpYOVRQV2FpNVMyMjNKMEk2NVBRdGttRDdIUllZYXhIWmM2Yjd0?=
 =?utf-8?B?ak4rTm1ab1ZRVXV5bGpMVXJYU1hCQWFTNzZyVkxTK0gwd3l6eHJXdjR5MmlL?=
 =?utf-8?B?NkMxTWNya2VsYTAyUmJsNExZWXF4MmtLKzl1aXg2M0ZNQXVMUW9WWlpuWXo2?=
 =?utf-8?B?SXR3RFF0YS8rcms5aFNiRkhyeU41RlE0bG9acWxmOWJEc0VxZ2Nab0RnMUFh?=
 =?utf-8?B?Vk5WQVJvOVpiQXJ6dXZBWjlnM0FKNnV0OTlzMEhsOE9JUk96a0Y0MFQzZXhK?=
 =?utf-8?B?S1Q3TTRVM0FjS1IrbVNraWZQbDdQc0dQM3ZuaVEzOVNXclJYdHJFUC92VWx5?=
 =?utf-8?B?bFliTnFLb3lOQk5lZE5IZGJwaUR5TU1UQzBDTkU3aitmS3VEMUVRVTNqQ01k?=
 =?utf-8?B?MkdmcStjMXBtQS9CZW1DK0c3MHYzYzdnVHpQK1FTdFN1TnRxd2pwWURxUkph?=
 =?utf-8?B?cHo5b0E4VnVHMjlIT0M4eHFTQWJRQWRlV2d1Z0psblc3UnBIWmJtN0t1Umw3?=
 =?utf-8?B?L290d0hHVVo2Z3IwdkY3cjdZbWlFZk15R2FJOGM0bXpLRnAvWXJIRG5wV2Qw?=
 =?utf-8?B?aThGbVZWOHk2SjhSYVlkWExObW82MDdTNUpwWnlXdm5iT1h3MjNLRm5yRmd5?=
 =?utf-8?B?dEFOdHdNekk4MmIzZVlMLzJEekxkaStHVm5td3Q0OVZBbDBoNVlEbWpUb1Ex?=
 =?utf-8?B?UlAvVjhDVnVMM0RIeFFmdkY0OCtQS2NkOUtBaXZnRWo3Uko3MnZ4RmFwS0dC?=
 =?utf-8?B?TUJKYmRUclEva005UDRQdC93TWkwVUh6YWM0MmlaaVBWY0x5N0ErTGQ1V05s?=
 =?utf-8?B?MkxzWDkwRC9ZU0RxQXNnaTJDelNuQ2xqSFBqZHUrS1Mvamh1aGdHQ0tPZFJj?=
 =?utf-8?B?alNkY3NhclRiOUJyUnRVbFJLU1dYZGkyVTFpZm53ck5NbTVXM0UzNURqQmJW?=
 =?utf-8?B?VU1LblFBSXJBbTVDa2tndDFDTmxZbEFEMWJOd2VuTzgxMmxYQUNjUU91Wi9V?=
 =?utf-8?B?UjRoeG9EVVVZbmR3bmJOSDFSZlZJL1UxUnQ1YlBzVVFBRW1oNUprQXZOTHpZ?=
 =?utf-8?B?YWYwMk04aUQ2QXRHbjh6STY5SVJFNDNpcWYrVmM5SGJnbVE0WHlucDZxaktp?=
 =?utf-8?B?QlFjaVp4Q3VTVUxzeU8yY3hJZmxUcjFtaWxEdWhwTnZHWUg1NHVUUTFIeE9T?=
 =?utf-8?B?RWFoTXBYc0RCeVRtRFVwcittQlcrY3dLYnptVjZTakdSNEF5WWF0WERlRGtk?=
 =?utf-8?B?bkowSjZKT2h3Y3YvQm9wVmtWdDZZNmk5ZXM2dXg3UUI2Z0NRVXJleVduUUdh?=
 =?utf-8?B?UGxZSWw3UmQyTklZWjMzVHJKVjF5UFJFL2MvbFZVQkNuNXpET1NMQTNWSEJE?=
 =?utf-8?B?RWRkbkdxYm5mMVRNZytZRVBOTk9VY25xZFNWQ3VWZE5vcG1IRmdCK1lsWTBP?=
 =?utf-8?B?QXhRcHMyZmdodmpZcGZlVkc4eVZNcktGaEwzMHlDZlE3aVc5ZStkbkhRREJQ?=
 =?utf-8?B?TnRqRFRXdVFLcTJNRTFoMGtZVG5DS1Vwa21YZWYxZ3pEV25KWk5qb2FCQTdS?=
 =?utf-8?Q?MJsV/4SBM0a4PJsRczlFEIQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d4594fb-d220-4cc6-d0fa-08dab69f63b6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 15:41:31.7045 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21+/vekT7dB3yiE6ALDucotkwlkTSLdORwcJuMbEwRlErW3W8FnNHW4+2c9T1JZxW+fIODZOrhntn7sJjjaw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6011
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
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Ao,

First of all, thanks a lot for this patch.

On 10/20/22 20:31, Ao Zhong wrote:
> Move remaining FPU code to dml folder
> in preparation for enabling aarch64 support.

I guess you found some of the issues here after you tried enabling the 
arm64 compilation, right? If so, could you expand the commit message to 
describe it better?

> 
> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
> ---
>   .../drm/amd/display/dc/dcn10/dcn10_resource.c | 44 +------------------
>   .../drm/amd/display/dc/dcn32/dcn32_resource.c |  5 ++-
>   .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  | 40 +++++++++++++++++
>   .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |  3 ++
>   .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  8 ++++
>   .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |  3 ++

Could you split this commit in two parts?
One for DCN10 and another one for DCN32.

>   6 files changed, 59 insertions(+), 44 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> index 56d30baf12df..6bfac8088ab0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
> @@ -1295,47 +1295,6 @@ static uint32_t read_pipe_fuses(struct dc_context *ctx)
>   	return value;
>   }
>   
> -/*
> - * Some architectures don't support soft-float (e.g. aarch64), on those
> - * this function has to be called with hardfloat enabled, make sure not
> - * to inline it so whatever fp stuff is done stays inside
> - */
> -static noinline void dcn10_resource_construct_fp(
> -	struct dc *dc)
> -{
> -	if (dc->ctx->dce_version == DCN_VERSION_1_01) {
> -		struct dcn_soc_bounding_box *dcn_soc = dc->dcn_soc;
> -		struct dcn_ip_params *dcn_ip = dc->dcn_ip;
> -		struct display_mode_lib *dml = &dc->dml;
> -
> -		dml->ip.max_num_dpp = 3;
> -		/* TODO how to handle 23.84? */
> -		dcn_soc->dram_clock_change_latency = 23;
> -		dcn_ip->max_num_dpp = 3;
> -	}
> -	if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
> -		dc->dcn_soc->urgent_latency = 3;
> -		dc->debug.disable_dmcu = true;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
> -	}
> -
> -
> -	dc->dcn_soc->number_of_channels = dc->ctx->asic_id.vram_width / ddr4_dram_width;
> -	ASSERT(dc->dcn_soc->number_of_channels < 3);
> -	if (dc->dcn_soc->number_of_channels == 0)/*old sbios bug*/
> -		dc->dcn_soc->number_of_channels = 2;
> -
> -	if (dc->dcn_soc->number_of_channels == 1) {
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
> -		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
> -		if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
> -			dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
> -		}
> -	}
> -}
> -
>   static bool verify_clock_values(struct dm_pp_clock_levels_with_voltage *clks)
>   {
>   	int i;
> @@ -1510,8 +1469,9 @@ static bool dcn10_resource_construct(
>   	memcpy(dc->dcn_ip, &dcn10_ip_defaults, sizeof(dcn10_ip_defaults));
>   	memcpy(dc->dcn_soc, &dcn10_soc_defaults, sizeof(dcn10_soc_defaults));
>   
> -	/* Other architectures we build for build this with soft-float */
> +	DC_FP_START();
>   	dcn10_resource_construct_fp(dc);
> +	DC_FP_END();
>   
>   	if (!dc->config.is_vmin_only_asic)
>   		if (ASICREV_IS_RAVEN2(dc->ctx->asic_id.hw_internal_rev))
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> index a88dd7b3d1c1..287b7fa9bf41 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
> @@ -1918,8 +1918,9 @@ int dcn32_populate_dml_pipes_from_context(
>   		timing = &pipe->stream->timing;
>   
>   		pipes[pipe_cnt].pipe.src.gpuvm = true;
> -		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
> -		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
> +		DC_FP_START();
> +		dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
> +		DC_FP_END();
>   		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
>   		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
>   		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
> index 99644d896222..0495cecaf1df 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
> @@ -27,6 +27,8 @@
>   #include "dcn10/dcn10_resource.h"
>   
>   #include "dcn10_fpu.h"
> +#include "resource.h"
> +#include "amdgpu_dm/dc_fpu.h"
>   
>   /**
>    * DOC: DCN10 FPU manipulation Overview
> @@ -121,3 +123,41 @@ struct _vcs_dpi_soc_bounding_box_st dcn1_0_soc = {
>   	.writeback_dram_clock_change_latency_us = 23.0,
>   	.return_bus_width_bytes = 64,
>   };
> +
> +void dcn10_resource_construct_fp(
> +	struct dc *dc)

Since this is a small function signature, could you add the dc parameter 
in the same line as the function name? Same idea for the header file.

> +{
> +	dc_assert_fp_enabled();
> +	

Drop the extra space in the above line.

Thanks
Siqueira

> +	if (dc->ctx->dce_version == DCN_VERSION_1_01) {
> +		struct dcn_soc_bounding_box *dcn_soc = dc->dcn_soc;
> +		struct dcn_ip_params *dcn_ip = dc->dcn_ip;
> +		struct display_mode_lib *dml = &dc->dml;
> +
> +		dml->ip.max_num_dpp = 3;
> +		/* TODO how to handle 23.84? */
> +		dcn_soc->dram_clock_change_latency = 23;
> +		dcn_ip->max_num_dpp = 3;
> +	}
> +	if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
> +		dc->dcn_soc->urgent_latency = 3;
> +		dc->debug.disable_dmcu = true;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
> +	}
> +
> +
> +	dc->dcn_soc->number_of_channels = dc->ctx->asic_id.vram_width / ddr4_dram_width;
> +	ASSERT(dc->dcn_soc->number_of_channels < 3);
> +	if (dc->dcn_soc->number_of_channels == 0)/*old sbios bug*/
> +		dc->dcn_soc->number_of_channels = 2;
> +
> +	if (dc->dcn_soc->number_of_channels == 1) {
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
> +		dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
> +		if (ASICREV_IS_RV1_F0(dc->ctx->asic_id.hw_internal_rev)) {
> +			dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
> +		}
> +	}
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
> index e74ed4b4ce5b..dcbfb73b0afd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
> @@ -27,4 +27,7 @@
>   #ifndef __DCN10_FPU_H__
>   #define __DCN10_FPU_H__
>   
> +void dcn10_resource_construct_fp(
> +	struct dc *dc);
> +
>   #endif /* __DCN20_FPU_H__ */
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> index 819de0f11012..58772fce6437 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
> @@ -2521,3 +2521,11 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
>   	}
>   }
>   
> +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
> +				  int pipe_cnt)
> +{
> +	dc_assert_fp_enabled();
> +
> +	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
> +	pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
> +}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
> index 3a3dc2ce4c73..ab010e7e840b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
> @@ -73,4 +73,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
>   
>   void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);
>   
> +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
> +				  int pipe_cnt);
> +
>   #endif
