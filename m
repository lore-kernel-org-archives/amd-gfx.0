Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5133FC77B75
	for <amd-gfx@archiver.kernel.org>; Tue, 23 May 2023 16:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA21910E253;
	Tue, 23 May 2023 16:09:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDD0C10E253
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 May 2023 16:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QNSyuRQPKmtpIdxXSsX4AjkDsZXHctwHgCldq2gIlXZzUpyWs3583lgMs3SdimDcjDaWZQy9CWZUNPPzlESY1xsG12idwIo3OEEKEYqwWvt6eik2vT6rmz+edo+UPhxhyTKnDDZV0UG6A9mrtbH4NFHa6D5tEiTpwNF7etHGe37RxHc6amtL+hslC2fCaGfA9AWAU8nJ99oWNbsYjQs68K3RrHbVsGnkbGlpkvPUb5S3a/qJ2Q/sRhyiwMGm50Kb2rT7rBQqTWciouePlnY6GxmHbaibtYIcJ4FMeT2sEej8hwjwuUiAwEdsIKWxc7XS9gR1Qta1WUc2MF16HLPe5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nf+SYiC5LtBLTLwTnULxBWf8NYmzEL2e9I6DjyvGjmQ=;
 b=npQ6IxuqMxJeGumD1KcfN3ke4uKZGRdP4l1f/uz45FIA2xcrN+45pJvJDwvswOVInLniG0xdLI2VQwUkqlJleF9YFHn7BQMhFvAj4GJXrZSjYVeYqwjyCzi9zz9GJxkSguFerJ3v8ikgX+9gDwrfJpht4WlBoW8kMds8zc7ruzO7fXBvUuZiwm2YHYqKpP0jFgHqg1gxee8Wuw5NYQO1hmwXczv7ICZb2lXdDopGaQKrhKf1kNzJRalct6oI0k2rNODsQw1oqsaC6m9rwlZIh8TCWNThoCS2AMc/8Sw/XNiCprg014G6JA5uQSfs+U6Q7E0c6y3h5dZ9R0T/6wCdBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nf+SYiC5LtBLTLwTnULxBWf8NYmzEL2e9I6DjyvGjmQ=;
 b=i5HGG6kAqwI2KDMuSvxU8CdrrADW6kVarPMULLu8ymaM8FCsU+YPss4BYGWzBSSHm9t11t4257C2Nn7wRv8CH8yAGUxoCqngWoqtGed3nTCPLqVSYMe/3+IhVdFfI3xtBGBUZlkae4RHtOPSYO7bMGjM8rwpCZdXIf6NVMtcJqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6280.namprd12.prod.outlook.com (2603:10b6:8:a2::11) by
 DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.28; Tue, 23 May 2023 16:09:41 +0000
Received: from DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1]) by DM4PR12MB6280.namprd12.prod.outlook.com
 ([fe80::fe53:2742:10f9:b8f1%7]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 16:09:41 +0000
Message-ID: <16635e8f-f81e-a731-e81b-3f1c02d24b9f@amd.com>
Date: Tue, 23 May 2023 12:09:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] Revert "drm/amd/display: Block optimize on
 consecutive FAMS enables"
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>,
 Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>
References: <20230522130823.769236-1-michel@daenzer.net>
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
In-Reply-To: <20230522130823.769236-1-michel@daenzer.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0221.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::12) To DM4PR12MB6280.namprd12.prod.outlook.com
 (2603:10b6:8:a2::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6280:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbe5aa9-81ac-47a9-b2ad-08db5ba81d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ULIJVTYsctNm97QREvNLhNRjkRKGsfXnH07KbY7npwnyme7Zy1DOCDZ8w8vuWL0gb1fZOHJGZAZtDk+fnaurgh586+7p3DDxujw3IrhWGRJ40CHD9Ineon5NZTr3wq5kN47ZO+4ZYZLI4IgCmOXBNWVAYzDoVMLEPYUGy6P/RcwzNHT3SyieQCUfwsF3gkNyGPAPJ5pPKVXcx6ok2pawYCWZRE618FgwQ7cQnl5HuY9bgBTLeTeOpJ52rd8iJlkyYzbafI/9bE80y4p1QoKzHO1UsuFdmCtD2LRSi42wz+4mOeMJlU3PJhd1/pBdRkmgnYkTM6Z9m5BYaSwy2MuV6R0ByN9UOaWs6jtDPQqJe37PpTzm4YM20FzE2NA3yOSxzkK5KP8gsBqK2N+YY1F/hILOfxlOVIxWMeYlWvCAgh9N4dO+/vvfOvDWZKeZ5gmnFYFZgg/dt/Or1w+7nyUWZ2ZcODRGDsNyVr6LE/2hiYbpunnY7JLQVyEjKv/BKqHCbjzT8J8xeApUnamqxCJiDQjt1TpsJZs7qUovjh5haUU48qhncrqrUX33TuPRamFo75DirsqFsg+jpod84ojT9olVbWSi/STRQJJcscd+HWnl8Mi2C7H8TERmiUMfwoIMVxox6sx2UGCNDBCfA/+lZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6280.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(451199021)(478600001)(66946007)(31696002)(66556008)(66476007)(6636002)(4326008)(31686004)(6486002)(41300700001)(110136005)(6666004)(316002)(54906003)(5660300002)(8936002)(8676002)(86362001)(38100700002)(44832011)(6512007)(6506007)(26005)(186003)(53546011)(83380400001)(2906002)(2616005)(36756003)(66574015)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXdwWmU3L0JFaTV0ZFBDRmdSWXgvQ3o0b0doSGFSZzBkQVJlSzlIbk9BZVht?=
 =?utf-8?B?OHFxWWgrU2wrNUlZeGtyQ2IrUFZ5K1k2cHV5akxZOXV4U3I3RTVBbVluMU1s?=
 =?utf-8?B?Ynd4V3VQMWY2QnlEVXB0TW9YczhQS1hsZVJWOE5GeUtEc2hGT1JyN1BvbnBq?=
 =?utf-8?B?ZlVYeWdqZSt5M1B2akVmc1lsVWRhdFcrWGxJdVNUM0w1dFFTR1B6MkZ6Ukpx?=
 =?utf-8?B?SkszOXZMVThFYWVvVGZDcmYvaERWRktwS051U1VlVTJCaXlVc2lSK2kwTUdQ?=
 =?utf-8?B?VVVCRC9pYXdxL0liVWhER0pjbUh3MmE4V01qRk9uQlFsbjlnMDBqNWtoWWZR?=
 =?utf-8?B?ZFR1elBQdzhoVVpXZUd6RC9xc2EyZDZ1eHJBOXpqakZLU0Q0SUE2dzdkdXZU?=
 =?utf-8?B?aFc2aEZuUlFwV2VmUC9uckhURHpVWi9UMU1xTFkrWk13VG81OUNKSEVxT1dU?=
 =?utf-8?B?ZWw5OTlpOW1BcG96M3NPK2pOeFFjRXRzK3FkK2Z0Yml2bCsyNUVZQ0IweU5l?=
 =?utf-8?B?YkU4SXFvS3d2MERGQkZxS0ZSVkdNQ25MQmlmL3NSMkorb3Y5TFNUWmdxYVMx?=
 =?utf-8?B?NStHUGx6NFU0NWdkdnR6c1JFa09EdjlkL2c1QzhBMkJCYmVjYnhPZjQ5QlJR?=
 =?utf-8?B?UzYxZzBkSXoraHFSVGRsU3I3MEVOUy9LT09RZ1FtOVB6TVFXemJEanRSWUxi?=
 =?utf-8?B?dnhsM0s1Vm9xN0JvWmIreUt2Z0dldlUvYmkwV1dUSjB3bWZsY0FuMkVPWWxl?=
 =?utf-8?B?U3NJVlpJRjJRU09rL2pIVkxVa0x3Sm1iZzNjNVhKSFIxaTc5T1NSUnlGdkNl?=
 =?utf-8?B?S1hTbm0wWHFqbXhuczhrTnBBSlpYb1puYkJyMUJrb0dHZjFiNjNtZFRINVhn?=
 =?utf-8?B?OHdaRGs0VE1yek0wVVc5TkE5SDBOYytzNFRrWWVoeE15SmIwbHhENVFHVWxp?=
 =?utf-8?B?bXQ0ajgxWXRLZGQ4SExBbWJCZ1M1cU9DWjB4a3RLczgrSFUvZGhHcElxTS9D?=
 =?utf-8?B?WVlWSG5Tb21xWHJxMHdMaXBDRkFHRk1zVnBCa3ZCK2tvazFWWHhkOWlZMGY4?=
 =?utf-8?B?RW1HOUJFSVZNTGFqMHFVOGJjVTk2a2VoY01YQ29uaUYxZ010bUtSRWlKTWZ0?=
 =?utf-8?B?MDNmc2hLUnBray8zSW84UGdOQVZzVis2N2dSb2xKSHluVTRRcDhpZnA0ZkpT?=
 =?utf-8?B?ODlINllHN3RoQXBGY0xhMmNXSnViRmdwN1lZUmdDZVBEQzY0ZC9GK05SSUwv?=
 =?utf-8?B?TCtna05GVlpNTnMyR2hVRkMwbzY4ZUwvWHFtZkpyTlFwTXk1a3hkcGVXN3hY?=
 =?utf-8?B?WGVQNjBIK2t1ZEx1OTJXMjhVUDFMNWZaak5JVTJvQkZQWDdSZEtyc2lhRzR0?=
 =?utf-8?B?eVkwTGJ6ZVZ0Z0tTN0VCdk5Oa1dWNUUwdEhKWEEwS1lESEdGZ1Y3czJQUXky?=
 =?utf-8?B?NWtRVXRXcW42d3RIVzRBOTJPSXVtTHdyUER0Q1Z0dk94VXZvYzdXOStmTnNp?=
 =?utf-8?B?SWE3UEt3SXNWWld5VDVTbExPYUlVZjBaYzgzaElMSFlTSmZXNElBVGx1TnhS?=
 =?utf-8?B?N1d5anFxZHAveTVCclZsYVFUdmVDRXRkQ0ZRSDRlMFBYMGlkblROaEViRGdM?=
 =?utf-8?B?OU5wbmRndmFKUnFwbmpQMzh1Vm9wR0tpem1Fb2gyemhOTXlUQjlQUm9HdE1w?=
 =?utf-8?B?Zm0wNERzcGdrM1pzbU96VmlPbkJmMHJFbFZNUDAzLzVFeFBWdkNPRU9acWFw?=
 =?utf-8?B?d0VUOVFpbTFKbEZlWjRwaXF6Z1orRFZOYXRyYysyOEhPcnpqRHg5QUNURHAw?=
 =?utf-8?B?KzNrejhqY2pFZlhZZG0wcy9YbVVCVUtwc09sM0xiaFIyYmFHOHlpeE0rS0Vl?=
 =?utf-8?B?cHBwU3RWV082bys2a1M2dmh5RUhhRmtjTVZ1b0E2bWVIOXhhRW5rUWxJMzF1?=
 =?utf-8?B?N1dONjU3ZWl0dDF6RzBjK2FRbU1EQmUvc21Ed1Y0SGxtZkp4RVZGQWRaMGVy?=
 =?utf-8?B?aXZuVzlYNzlqSnVSS3RlRTUva3lBN0ErZ2tqVVBiZXpoNWlBTElPenNzQnNi?=
 =?utf-8?B?Tm03YW1tSFFuRWxmeHVMaUU1cndQc2crcXBKWW1Cb2J6U2NSaCtCRzhCYnoz?=
 =?utf-8?Q?7ZficKCCLovaIf8UHcUd6GCl/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbe5aa9-81ac-47a9-b2ad-08db5ba81d87
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6280.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 16:09:41.2947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zJGj+7KZNX9UzVCZhmLu1qR/BFCg3GcokdBPPB+cyeg9gOrBtn1tCdQkbSr/7J1HlU0m1gaWlGR0EpwzV7eZLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 5/22/23 09:08, Michel Dänzer wrote:
> From: Michel Dänzer <mdaenzer@redhat.com>
> 
> This reverts commit ce560ac40272a5c8b5b68a9d63a75edd9e66aed2.
> 
> It depends on its parent commit, which we want to revert.
> 
> Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>

I have applied the series, thanks!

> ---
>   .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  3 ---
>   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 22 +++----------------
>   2 files changed, 3 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> index 422fbf79da64..6ce10fd4bb1a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
> @@ -2117,9 +2117,6 @@ void dcn20_optimize_bandwidth(
>   		dc_dmub_srv_p_state_delegate(dc,
>   			true, context);
>   		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
> -		dc->clk_mgr->clks.fw_based_mclk_switching = true;
> -	} else {
> -		dc->clk_mgr->clks.fw_based_mclk_switching = false;
>   	}
>   
>   	dc->clk_mgr->funcs->update_clocks(
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> index 8263a07f265f..0411867654dd 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
> @@ -983,13 +983,9 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
>   }
>   
>   void dcn30_prepare_bandwidth(struct dc *dc,
> -	struct dc_state *context)
> + 	struct dc_state *context)
>   {
> -	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
> -	/* Any transition into an FPO config should disable MCLK switching first to avoid
> -	 * driver and FW P-State synchronization issues.
> -	 */
> -	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
> +	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
>   		dc->optimized_required = true;
>   		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
>   	}
> @@ -1000,19 +996,7 @@ void dcn30_prepare_bandwidth(struct dc *dc,
>   			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
>   
>   	dcn20_prepare_bandwidth(dc, context);
> -	/*
> -	 * enabled -> enabled: do not disable
> -	 * enabled -> disabled: disable
> -	 * disabled -> enabled: don't care
> -	 * disabled -> disabled: don't care
> -	 */
> -	if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
> -		dc_dmub_srv_p_state_delegate(dc, false, context);
>   
> -	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
> -		/* After disabling P-State, restore the original value to ensure we get the correct P-State
> -		 * on the next optimize. */
> -		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
> -	}
> +	dc_dmub_srv_p_state_delegate(dc, false, context);
>   }
>   
-- 
Hamza

