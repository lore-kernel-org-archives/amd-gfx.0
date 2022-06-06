Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24137C43334
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jun 2022 14:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F5F10EAA6;
	Mon,  6 Jun 2022 14:11:53 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C613010EAA6
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jun 2022 14:11:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMjZRmEHM8+t9PwRaZpsyD4KvK0mYbsYhZVE/0KpsMkwHEprysZK+Q6S5mk5ocsg7V1QHP4VvtwafDbAMF10NBYDFS8U/5VEOjlmuX2Li0TId0Dq3cA8R5Bh3aw/Xe3u7KXOtEiTYv5snDOeAEU8rtukdTwOHMqz/A1LW5DGzTPwIIDSuWfR24m25SZuod5+SV4AoskGoIlpndpsXpdhNBxjqqpPaszE/6LTkCOJ8VHVbWt7iLA5sV5OMspO/bhnH7s00M57mkSgiXlRqEumaIS46jP6CnjPXe58O9ilF2p0ptkSdviTQWpze6c0Wi34Zd6Z5LCwIY3ZAV16xTIuzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uxA108PIyKSeir6OmZ0F7cjTKf1znfvDrZI/IozxiEU=;
 b=DQhqw1kFXtRk1SrTJsPQbvUDVSescE93EcpFBIOaN1VctOyqxrhbaC43ts8JV8UUM4R7Ry+YUR/cT4dTFyDXFSR0Bg1zfjEr/qcSW5k01ggBuKtDx2pKhzQpLSh4Lpw4BiqqzvuJNBTBrBgKFHFDR8TnSWDXDT5x9rJpYAR+jqH72TWexz5SgAgEqJMbeP4gCmHWFECeqnsH6P/5xh/vjsdWSTRfXKJGtyUHvNrTtGiyUL32mW7Na0RRWoSj8aD3Q/wve750PQoBUu2LBIV/BJbZr+tQvoVDss6NjCp65DVGWCl2MxSQf9glVkd4m6oWs0njIvgbfAa+X7L60HYsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uxA108PIyKSeir6OmZ0F7cjTKf1znfvDrZI/IozxiEU=;
 b=ToU2z9OpjMYIFwpifLIc3golfh1YWv6PKp2zKA/8EFcw6cHGn8iLSPFjMH/6YsKGHUUm3v00CTXZ9IgwDR0KadgCiwApKzGTjgztDQHeSAVF3/YC3tIAq6JP1meziIE3ivo6Ef9t78blBno8O6BicEsEkUskS/f5uljVX0PdqHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CY4PR1201MB2502.namprd12.prod.outlook.com (2603:10b6:903:da::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.18; Mon, 6 Jun
 2022 14:11:50 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%6]) with mapi id 15.20.5314.019; Mon, 6 Jun 2022
 14:11:50 +0000
Message-ID: <a2f385ac-4e05-e40c-b339-e8ba07553aa8@amd.com>
Date: Mon, 6 Jun 2022 10:11:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 5/6] drm/amd/display: Reduce frame size in the bouding box
 for DCN21
Content-Language: en-US
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220603185042.3408844-1-Rodrigo.Siqueira@amd.com>
 <20220603185042.3408844-6-Rodrigo.Siqueira@amd.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20220603185042.3408844-6-Rodrigo.Siqueira@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT2PR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::7) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62bb1b1a-28d3-4f07-17e8-08da47c67feb
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2502:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2502325CAF0E6F56F51C5B7C8CA29@CY4PR1201MB2502.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AWZZs9E9DZf3LRLfinTiacG4+sRMXwKDB4LiBCe0IyQ0RD7c6gq4ScD6QsoiO5r7dNG9luioSkxAx9d7Cfy+ISfS+BVoB0AsTfjqmxFC+3ImtPo5mIUQo6ckIWNUre61OkMwVawWjhOYCzuYWAnoazz6yR7DwKEzVflHPQbc0CQBTDUuBZhqeTDRrnHXUXvcegUZhynWZcIGzP1Cdv8MMgPiKRs/GlBiTzqZd5VdBcdVzpuZtOlcVopjkHq66ZpF5Yj3oaGEKd9jVaxCuk6MaGeCXNrbwASDjER5JewGeslXUCIgF+2GP7hrkgGluYM0TcfhTMZG9fLNnQwtAsZw91Umh/ODxBJNPjsoNMn7sDjXmTWZB4hMULFzRFGm7xqpH3zoTeHwXwjr1dwbvzSGl4eyCRVuouoqlQ7okHDpaUVNWuRoaWqV0/gyGftL49t+yo4Lhc3CZ5euZppTifUCfTHY+tRXTbvxh1wvLvEmV3ueIkhRyAhBHtrybs5LZAf4s46OkSja0Aw9dwFnlkBQpbZTFfWmi+2EF+L25egMUodznXvwvZA72wnonNy3iw7T6jRlfmLRIrRQPn8pCzrgivmaJEocAM8Y0cdARQoFcU9gcxjQB2pXYqgxmwdyflZLLSkQgozuuU1W8k8R+pgXGCaMI5nfN+bsX+/5njexWiHPVY1JE7PusFdTwBZ/KtyC4gBqMgyG9uo6wtMilQA3TuNQYpHSYLlzRqyTRO/x+azcPwEde8lJpjv/VA6oj+vK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(86362001)(31696002)(36756003)(8936002)(38100700002)(6486002)(6666004)(31686004)(508600001)(8676002)(44832011)(4326008)(5660300002)(66946007)(66476007)(66556008)(54906003)(316002)(26005)(2906002)(186003)(6512007)(2616005)(53546011)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnU5RzNWWEJJVWtpV2JuY2FyWUdVQXZmUGtISnV4UktXNSswQXhTZCtjUHVp?=
 =?utf-8?B?K3VoWHJ4eWlVVm44L1Q5ZDRLK05uMGFad2RNQmVoYUVOek0rN3BrUi9JQkg4?=
 =?utf-8?B?TnR1LzdWNlVJRy9CZEJEMWVsZFJMOHVMSS9lUlhLTXIrT3dSUEd3UnJFVm1s?=
 =?utf-8?B?S3c2YUhwVWU5YUgxaVY5ZHdEczhIODQ1WGxuTnNveEZsdE5mTE8yQmhvU1pC?=
 =?utf-8?B?K2w3L1hUZTZ1NGN1WkgvK1lJc01rNzlvWnBwSzlYL1JSNEtWRmRGbExUbks2?=
 =?utf-8?B?SDJzY2tTN2dQajVhWXpMYzBjQ29xTExOUDB3Y0NkaWxkZ21TSUtiaXdKVUJh?=
 =?utf-8?B?Tk5WSGE4YUYwYytucTBtYlQzQjhkeTdaN1lHTEtwK25STGYwSjd3Y0pCUHY1?=
 =?utf-8?B?bkdzbkg5ZWVaSXBJVlhWcDBySkJkcWs4cVY2eHFacGtGYWc2S21JV2FtWG4x?=
 =?utf-8?B?ZUFVckpNM2hLKzBJZzdWOHVZK1hoTSs4M0EvTjlvTHNybzdCLzh4eEM2OEJu?=
 =?utf-8?B?YmJwKzNzclBYNHViSGgvL0J2TFBrdTdIdkZhSHl0OVRJNnR5UVFGNnMrRWFZ?=
 =?utf-8?B?dGkzdTZueDJ1UjYrdit2Q3pKdm5OK08yMFdwY0xCbnQ1WGNWMzRPZnkxNWVS?=
 =?utf-8?B?dnQxbTRVY1dnNzBMcW9kdElVRnA1anZ6ODJsR0RaVW1iMmxwWERvaHBjd29l?=
 =?utf-8?B?TFg1R1JjSUkxZUVRWDl3YXVHbDFyaG8xQWRubnQ1Y0t5VDFTVVA3QWJZYWsw?=
 =?utf-8?B?UUxuR2JKZlg1UHVYVEJDcDhrdldZT3p4Nlh6N0NyV1pXL3pyVmt0Nm42WWEw?=
 =?utf-8?B?QjVOTHlmaXd1Wm5zZGpnZnlhQ3dNUDd3VXN1dDBQYW01dStFSXhMQ2lGR3h1?=
 =?utf-8?B?NjI2ZG4vSjNYekhOeHRwRThqVmd3a3pMaTJScHpTWllvQXlzbHNORXFYYjJC?=
 =?utf-8?B?MUU5eEZGbmFHeGx1bWRIbWswV2pCaUZzUjdtTVdzTTNwOS9nNG8wY0M2NWM2?=
 =?utf-8?B?Q2Q4a1ZLZHhuVlFCL1V0ZUFjLzIxdytPVUpQTEdlb3VkVmFyODFHdENZeHpX?=
 =?utf-8?B?UTBQS3RBK0F3NzlscVlpZjUxRHRGSU9LN0NLN2FPeWhKdHRGVkYzT1lVbURY?=
 =?utf-8?B?Nm4rYXdMalRYMkdMZWdxVW44V20wMVdmUzJSUkxOZ1VVaGp4VDNqY1l5bDJO?=
 =?utf-8?B?b3BObVl2ei9jQmhHaVd0Tit0SmhPbHp1ZkJJSzFMZVk2U1FXRDZESUJTL0ZO?=
 =?utf-8?B?UnpnWjFoM0tsbzllUmRkYTFYUjZQL1F2cTY1elZBSWlPQnFLQWJBaGFyVzZq?=
 =?utf-8?B?K0lZT1lxeExIKzNhRHNyOVp6cUtNVkFabkNRL0Yxdjh6ZVRSeEpwQ0Z0Zzlv?=
 =?utf-8?B?cUszZFZBa3g2Q2lZcklzRHZCVW8yODEreE8zcUtOYkpxSU5OUFNSVFArcE90?=
 =?utf-8?B?NnZEVGt0UCtFaStRYllnQS9SQnY2MEU3VVVoZzRsNE9BSUNvejVZSCtURVQ0?=
 =?utf-8?B?dVlhWExwd3QySnpwczBqbTk1RTJyVjI2NVhCMmpGWWs5NkxNa2dXT3RWRzNj?=
 =?utf-8?B?dnlEZlphR2puNzQ2NUZ1ZitnR1ptM0QrYzNtcjdHaVltajlvaVRIdnRDZ0pV?=
 =?utf-8?B?cjhsYmpGYUx4TGl6eFAvV3hmb3lYdTE5cVZtQkdpL2ttL2xWMVJSenNGYnla?=
 =?utf-8?B?VzZuemN4MmJTRFZPc29zK3ZTL1RoRnZvcXN2aXl1NThvZjluMFhwTTMwY2Fz?=
 =?utf-8?B?b1Y4ZGplR01qZzJGOWJJMVBCdnZxRVdOSUpLVUd3c0p6YTluS0xIV3RjUy9N?=
 =?utf-8?B?U1ZrZ1B2ek1zalVxRDliMHdIQUNEQjBLaGxtWnZDU3p6aWRYWnVaZ1FBcTBD?=
 =?utf-8?B?WnJXMmZvWHlYVDdtUGp2bHEvYThSb1g5TmZRVUpjZnJpZFEvVUdRdmZvajFO?=
 =?utf-8?B?S3ZtcFlzNktKeFVPNHE5MUE5TnJtbVczN0FPYXVsQ0crZ3RxZTJFSFBHWDlL?=
 =?utf-8?B?c251YU53c3BuL0hTS0NyNndEMjRkdU1EV0grTGNHcTlqZXl5Zy9rL21uWmZt?=
 =?utf-8?B?TWl2UnQ1YXF1OEg0MXdzNTNIczlOdEh6Ry9EckkvVXB3bVhPMzV0d2RYektW?=
 =?utf-8?B?WU5nbzhXUEtxNXRvNGZlb2FvMGx0NjJKQkZCREttL1hSazZNb3RNVnNIMnlr?=
 =?utf-8?B?L2ZMRnVlNHUxcTBxMFlIZ09VTXpRSFgzM3g3QS9NTzFkMTJoTzl3RENGNG5D?=
 =?utf-8?B?czhHVlk1YTdyMTVNWUF4NU56ejMxeXY0K28wQ1dWb2NJWHlxVmZsUk5iK3dl?=
 =?utf-8?B?S0htOXJxTlc0Tk83K29OdUxYRWsvYXdOaUg1NUVCVmdSdEVDd2hrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62bb1b1a-28d3-4f07-17e8-08da47c67feb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2022 14:11:50.4681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBGWa1LmrPlr1JdBgtGHCqqG8HTAJPEbRinxuF0B5SeinuW/mDqZSAkWsfT10FGmUqAkReO3jJ6gETFk3OBNFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2502
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-06-03 14:50, Rodrigo Siqueira wrote:
> GCC throw warnings for the function dcn21_update_bw_bounding_box and
> dcn316_update_bw_bounding_box due to its frame size that looks like
> this:
> 
>  error: the frame size of 1936 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
> 
> For fixing this issue I dropped an intermadiate variable.
> 
> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 29 +++++++++----------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> index d9cc178f6980..c2fec0d85da4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> @@ -2004,7 +2004,6 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>  {
>  	struct dcn21_resource_pool *pool = TO_DCN21_RES_POOL(dc->res_pool);
>  	struct clk_limit_table *clk_table = &bw_params->clk_table;
> -	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
>  	unsigned int i, closest_clk_lvl = 0, k = 0;
>  	int j;
>  
> @@ -2017,7 +2016,7 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>  	ASSERT(clk_table->num_entries);
>  	/* Copy dcn2_1_soc.clock_limits to clock_limits to avoid copying over null states later */
>  	for (i = 0; i < dcn2_1_soc.num_states + 1; i++) {
> -		clock_limits[i] = dcn2_1_soc.clock_limits[i];
> +		dcn2_1_soc.clock_limits[i] = dcn2_1_soc.clock_limits[i];
>  	}
>  
>  	for (i = 0; i < clk_table->num_entries; i++) {
> @@ -2033,24 +2032,22 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
>  		if (i == 1)
>  			k++;
>  
> -		clock_limits[k].state = k;
> -		clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> -		clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> -		clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
> -		clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
> +		dcn2_1_soc.clock_limits[k].state = k;
> +		dcn2_1_soc.clock_limits[k].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
> +		dcn2_1_soc.clock_limits[k].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
> +		dcn2_1_soc.clock_limits[k].socclk_mhz = clk_table->entries[i].socclk_mhz;
> +		dcn2_1_soc.clock_limits[k].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
>  
> -		clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
> -		clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
> -		clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> -		clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> -		clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> -		clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> -		clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
> +		dcn2_1_soc.clock_limits[k].dispclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
> +		dcn2_1_soc.clock_limits[k].dppclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
> +		dcn2_1_soc.clock_limits[k].dram_bw_per_chan_gbps = dcn2_1_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
> +		dcn2_1_soc.clock_limits[k].dscclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
> +		dcn2_1_soc.clock_limits[k].dtbclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
> +		dcn2_1_soc.clock_limits[k].phyclk_d18_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
> +		dcn2_1_soc.clock_limits[k].phyclk_mhz = dcn2_1_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
>  
>  		k++;
>  	}
> -	for (i = 0; i < clk_table->num_entries + 1; i++)
> -		dcn2_1_soc.clock_limits[i] = clock_limits[i];
>  	if (clk_table->num_entries) {
>  		dcn2_1_soc.num_states = clk_table->num_entries + 1;
>  		/* fill in min DF PState */

