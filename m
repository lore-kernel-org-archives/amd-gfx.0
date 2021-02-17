Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F219C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 13:47:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1074664DCF
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 13:47:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1074664DCF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B015B89EB8;
	Wed, 17 Feb 2021 13:47:48 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 646F489EB8
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 13:47:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P0JgYGKbdcb/Hlv5jFf5tGlIR8PEsGa/Od+htsOFMAx3jKqN9H2axgqMR1Ba5BuOpXXEVirhAK67FyZF1MAFIC0KmGaNhDxqVPyddPeGwZ8JcqW13eERuOSDPKxBeJvG3ASTIxejMe41nOz5iSmliljW+WF8qWk1sBOy23Mn1icg4yWkLaP9Lr6NYLw5DhnpdimfHvBJH+/sJ+w9xr2IyzQxx6PihHWeBRpM3APg1qYRpi2cajbRX9cXTOVJeUlTttitNp/DGHthh9nXxvNKSiS1D0YBulJQwaVmtt3BGByYeZ5t5YNaVxbWeikw+XfjE7eeA+SopQOi6HLdYDbwzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajrufg4ydTgYjp/1ZYY1GBFBSSUq3azGdDitjCiQ75M=;
 b=FNCmEPMvvQnUDGPBor1mtj3eL5pzPRmOfGlaKKfgALcVlYkK2Zpns2BNUrFtf2+dguJhi9o+1MNlBxkjfHjY7MCvl7OJYep3w01/xLb0RQ9aO3DLOHle0t8mYaqwHC2UEzKNjD6OcB1vPyj6jlZzywnH3OyFyjXmanZy4EBpsgT2S6K1n0twqRhAlzmWPvs+YpMTClA5A3EyyI/xXifnM9WqQIF2PqWz9qohyeIQWFQMGPWCERBve+x/h9c9cuLGfCE2GfEwgGQzN0y+z+slbEbogExFmWjS678zRzbfc/42N/XpepivzrEKFJIRkKO92mDoJkW+Dv/zwL5PCG19Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ajrufg4ydTgYjp/1ZYY1GBFBSSUq3azGdDitjCiQ75M=;
 b=yVkHJ58WE5kWz/b8yxuFSvIcweRth1iWiS3LlITXeW73amge2u+z0E+2OnhwPK7CO/snRTMgUz3rXTFWig7oLLsBxXwV6Lua9iMcvy2SwwcPGz58vbrclMp4gGOy5CATcvdE3EXRh9GmEMxLL84jldRuWY22NU3sR8AxHaW/N9E=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 by SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Wed, 17 Feb
 2021 13:47:45 +0000
Received: from SA0PR12MB4495.namprd12.prod.outlook.com
 ([fe80::751e:bc35:a13b:7680]) by SA0PR12MB4495.namprd12.prod.outlook.com
 ([fe80::751e:bc35:a13b:7680%9]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 13:47:45 +0000
Subject: Re: [PATCH] drm/amd/display: Old sequence for HUBP blank
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20210216235841.154819-1-aurabindo.pillai@amd.com>
 <20210217134014.4gqi6c2tliba23ze@outlook.office365.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <497e82ee-af5a-11a6-7f42-4197ff449749@amd.com>
Date: Wed, 17 Feb 2021 08:47:41 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210217134014.4gqi6c2tliba23ze@outlook.office365.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN8PR07CA0021.namprd07.prod.outlook.com
 (2603:10b6:408:ac::34) To SA0PR12MB4495.namprd12.prod.outlook.com
 (2603:10b6:806:70::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.0.190] (165.204.84.11) by
 BN8PR07CA0021.namprd07.prod.outlook.com (2603:10b6:408:ac::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 13:47:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a51a8dc-4168-4c1a-5756-08d8d34a9ac9
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB236876AB5BC91021FA0570728B869@SN1PR12MB2368.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tRNw1s15JJofiCruM6O5Tsd5YazvfP2YQNK6a3+I2C1EY5kYj5vGFbBzCc8inwyi9ylSJ45psAral4jyT4+S1goOaPVSa27C2hhoNr7UFVaaBb2R34F6ZA9/A5k6C4sOJhbTc/4GbswGwegqJS1/nmYqDSea1jGbaNmBeFkBcBb173pok5tJffkw09pbAQrdiFXSVrS8mjTQn1NvO5ed3H818u+BgncBjK+wILkE8p0QS27K7RsVG0Lc0f/R4GKUWCRFb8fIZSwBjH9pkBbf0cRH/UtAjJnoH7EM+e/ecFRPrVW2EEGWhFKTbmt7tV/KA7e3l9G1ISENf7bVgME4Hoqc8bzEJgUR4Jm80whqf4iDpDw0ACSTcM25gcBNrltF/zNXdwmMDM4uaa3JRdoDGAkwHZjzCKr3ZbVD32ylVMP9sKNveefJOVA/SuDMn12dMVq5o52OrJa++c0rN3tKl1TOxRVO5bF/JHRT6BxBMzFCQp4KRKtYVcJw9IDlY2wmfA9XW2vMK4yde5AkTyFU/MBXAqhpGuuKu6ZJfWX++u/1OdUxP2BoVjtgdGU5y84EJ9d5I1zVCbMOkP0T/P/JdILLtJC1j1d7otEuO7OuDjPp80mv3Jw8gHogjGHdSg+UuY0+JGgT+2MHO5krWhTwYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4495.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(346002)(136003)(39850400004)(83380400001)(26005)(6636002)(966005)(52116002)(44832011)(30864003)(8936002)(478600001)(31696002)(53546011)(316002)(16576012)(45080400002)(956004)(66476007)(36756003)(66556008)(16526019)(2906002)(186003)(37006003)(66946007)(86362001)(6862004)(4326008)(8676002)(5660300002)(6486002)(2616005)(31686004)(6666004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?6fvx/A/2ckIjJQ+9qxVwvKtw/JFbK2at+tZctOKaD+dMVDDdHylBNQaw?=
 =?Windows-1252?Q?O+5fH89DzN4rTIawV1KsaILxhO4O8eTaxtq+OBpztaZozPp0pri4Ars1?=
 =?Windows-1252?Q?dVFTkePz0M92b1vFo6BqCZZZ2/QewTyfj+FjeFgtzRvyVv+S2c9dT8sw?=
 =?Windows-1252?Q?nmOLyffvw/wGtD1AFOiuy1KoRtYLhrFVn7AEoU9ECgBNAmxAILJ3k67j?=
 =?Windows-1252?Q?BdIvHyRCNh0ekr8NnNlPO7gBX6Fo929e5v2ceB9QZUegfffhUpvn/iov?=
 =?Windows-1252?Q?4WzkDBoSW/8/Pbu2Jz6UqC9/WgaH8Er2/is2P7JjnvvBwrM+MqpVbyPz?=
 =?Windows-1252?Q?8pMZGdAI7EOgkc/WkzI4lbDgFWHbLdNk/jCnImEecfwrYjpiipztX4Pi?=
 =?Windows-1252?Q?bs1hASVK3X0f+L9lAak3iUJ5hjohK5omtZHJqZnJTJAhfsB0g89aRsAX?=
 =?Windows-1252?Q?RIMXfHh5zhYvq8vci3O1kWuh9qPm5+Nip0Ygi83aedmbbrUQqLiB5ydL?=
 =?Windows-1252?Q?O3XpnqJ45/MNwXWNfsegAddXcqAdFKCUz1MkCD8YkVrrw/nYSlrOftBe?=
 =?Windows-1252?Q?K+s9uvY9tx5rhMbUTZcfmuBnh7qO5XBCajgymw4Fk9KIN/GJ4QNSkEe6?=
 =?Windows-1252?Q?+NodlqvEWqGPZFV69neib1uqMbhuAMJVwHl5v2EMj7L0yf+Y3L2zGGSK?=
 =?Windows-1252?Q?4mrdxHMYMc8MNwanuLdLN7xBYyKI2KVG6Tzkz6gGJVHqgESW0yrpt5/z?=
 =?Windows-1252?Q?YSJadq40fLsN0XyDMiQltYT3ZpVKEGixQ8ZQRCjdhAYoDIwk239aLkno?=
 =?Windows-1252?Q?1mou72w/fdtXHHOPWN6vlkm1556/2BFGdRQFf8k1YKdIa8ipzRHZdqMv?=
 =?Windows-1252?Q?9TpLxsS9TiKCKWlAgNhopuvSiXJKvfqLXBu7yYvqUVd/PwT642Cv9DU8?=
 =?Windows-1252?Q?r+eFciCN+qqrxSoJuHs9YpYr363wxL0wicsLQt5AFIZXdqAYcigQ4Wjr?=
 =?Windows-1252?Q?MGMF8rvEfeGhu7KIqnNKRNc6K1H06k4sskxrRgGIBxzvlBekkAPoRdsH?=
 =?Windows-1252?Q?RbeYIbSkM7t/6M3fsv4rLGyAI8vYDYjxSFTkBaOkg/IgPLKPTdrTUwPM?=
 =?Windows-1252?Q?pmWplyQ8Nah5u5bkEHtFiTeisCjbDXnGyHo8D20X5SgYJVc+LOihuIQn?=
 =?Windows-1252?Q?rwnl+qccXjHVKO8eBdySrsOW7/BrScFIJQ6/PIDcVAzT7ofI3FMwxf4T?=
 =?Windows-1252?Q?ESiI+TBXbsoHadeT+9u/Fz6y23qFL4O6xS8PNJXrrikQ66oqQ63Stqsj?=
 =?Windows-1252?Q?04OgDMCJzg4h/k+2Zugon0fgh3WjN5tqJD3HywtZOzPX9VE8xOU919mO?=
 =?Windows-1252?Q?VG3AGmy9/gQn2stH7pN1lBng/b8ieGRUZ+mHwAYsEMnrT7ofGZjxM0l6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a51a8dc-4168-4c1a-5756-08d8d34a9ac9
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 13:47:45.3799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jthEJLnXyfbElGTUIyTo+J87DE2PpmFt8PG3cJZl0/CBCQgu3TMgEJd/PMqnSjcLezURjj7Yx32JO5nW++55bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2368
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
Cc: bhawanpreet.lakha@amd.com, amd-gfx@lists.freedesktop.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2021-02-17 8:40 a.m., Rodrigo Siqueira wrote:
> Hi,
> 
> Is this commit a direct revert from
> be7af780ef3cbb8fe1004db48dc66caf2da595cd ?
> 
> If so, I recommend you to use the standard way to identify "revert"
> commits by using 'Revert "Commit header"' and the message "This reverts
> commit HASH" followed by the original commit description.

This is not an exact revert. It includes two more hunks which were not 
part of the original commit. But logically this should be one unit, and 
hence having them separated might introduce regressions.

> 
> Thanks
> Siqueira
> 
> On 02/16, Aurabindo Pillai wrote:
>> This reverts commit be7af780ef3cbb8fe1004db48dc66caf2da595cd because the
>> new proposed sequence for HUBP blanking causes regressions. This change
>> brings back the old sequence.
>>
>> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>> Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
>> ---
>>   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 +++--------
>>   .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  3 -
>>   .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 -
>>   .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 13 +++-
>>   .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 -
>>   .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 -
>>   .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 62 ++++---------------
>>   .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 --
>>   .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 -
>>   .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 -
>>   .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 --
>>   11 files changed, 30 insertions(+), 97 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>> index 89912bb5014f..361a97edc8ee 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>> @@ -2635,7 +2635,7 @@ static void dcn10_update_dchubp_dpp(
>>   	hws->funcs.update_plane_addr(dc, pipe_ctx);
>>   
>>   	if (is_pipe_tree_visible(pipe_ctx))
>> -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
>> +		hubp->funcs->set_blank(hubp, false);
>>   }
>>   
>>   void dcn10_blank_pixel_data(
>> @@ -3146,16 +3146,13 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
>>   	return;
>>   }
>>   
>> -static struct pipe_ctx *get_pipe_ctx_by_hubp_inst(struct dc_state *context, int mpcc_inst)
>> +static struct hubp *get_hubp_by_inst(struct resource_pool *res_pool, int mpcc_inst)
>>   {
>>   	int i;
>>   
>> -	for (i = 0; i < MAX_PIPES; i++) {
>> -		if (context->res_ctx.pipe_ctx[i].plane_res.hubp
>> -				&& context->res_ctx.pipe_ctx[i].plane_res.hubp->inst == mpcc_inst) {
>> -			return &context->res_ctx.pipe_ctx[i];
>> -		}
>> -
>> +	for (i = 0; i < res_pool->pipe_count; i++) {
>> +		if (res_pool->hubps[i]->inst == mpcc_inst)
>> +			return res_pool->hubps[i];
>>   	}
>>   	ASSERT(false);
>>   	return NULL;
>> @@ -3178,23 +3175,11 @@ void dcn10_wait_for_mpcc_disconnect(
>>   
>>   	for (mpcc_inst = 0; mpcc_inst < MAX_PIPES; mpcc_inst++) {
>>   		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
>> -			struct pipe_ctx *restore_bottom_pipe;
>> -			struct pipe_ctx *restore_top_pipe;
>> -			struct pipe_ctx *inst_pipe_ctx = get_pipe_ctx_by_hubp_inst(dc->current_state, mpcc_inst);
>> +			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
>>   
>> -			ASSERT(inst_pipe_ctx);
>>   			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
>>   			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
>> -			/*
>> -			 * Set top and bottom pipes NULL, as we don't want
>> -			 * to blank those pipes when disconnecting from MPCC
>> -			 */
>> -			restore_bottom_pipe = inst_pipe_ctx->bottom_pipe;
>> -			restore_top_pipe = inst_pipe_ctx->top_pipe;
>> -			inst_pipe_ctx->top_pipe = inst_pipe_ctx->bottom_pipe = NULL;
>> -			dc->hwss.set_hubp_blank(dc, inst_pipe_ctx, true);
>> -			inst_pipe_ctx->top_pipe = restore_top_pipe;
>> -			inst_pipe_ctx->bottom_pipe = restore_bottom_pipe;
>> +			hubp->funcs->set_blank(hubp, true);
>>   		}
>>   	}
>>   
>> @@ -3747,10 +3732,3 @@ void dcn10_get_clock(struct dc *dc,
>>   				dc->clk_mgr->funcs->get_clock(dc->clk_mgr, context, clock_type, clock_cfg);
>>   
>>   }
>> -
>> -void dcn10_set_hubp_blank(const struct dc *dc,
>> -				struct pipe_ctx *pipe_ctx,
>> -				bool blank_enable)
>> -{
>> -	pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, blank_enable);
>> -}
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
>> index 89e6dfb63da0..dee8ad1ebaa4 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
>> @@ -204,8 +204,5 @@ void dcn10_wait_for_pending_cleared(struct dc *dc,
>>   		struct dc_state *context);
>>   void dcn10_set_hdr_multiplier(struct pipe_ctx *pipe_ctx);
>>   void dcn10_verify_allow_pstate_change_high(struct dc *dc);
>> -void dcn10_set_hubp_blank(const struct dc *dc,
>> -				struct pipe_ctx *pipe_ctx,
>> -				bool blank_enable);
>>   
>>   #endif /* __DC_HWSS_DCN10_H__ */
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
>> index 2f1b802e66a1..254300b06b43 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
>> @@ -79,7 +79,6 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
>>   	.set_backlight_level = dce110_set_backlight_level,
>>   	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
>>   	.set_pipe = dce110_set_pipe,
>> -	.set_hubp_blank = dcn10_set_hubp_blank,
>>   };
>>   
>>   static const struct hwseq_private_funcs dcn10_private_funcs = {
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>> index b79a17f6a9cc..48d1e0e2cf75 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c

Additional hunk 1
>> @@ -1576,7 +1576,7 @@ static void dcn20_update_dchubp_dpp(
>>   
>>   
>>   	if (pipe_ctx->update_flags.bits.enable)
>> -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
>> +		hubp->funcs->set_blank(hubp, false);
>>   }
>>   
>>   
>> @@ -1772,10 +1772,19 @@ void dcn20_post_unlock_program_front_end(
>>   
>>   	for (i = 0; i < dc->res_pool->pipe_count; i++) {
>>   		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
>> +		struct pipe_ctx *mpcc_pipe;
>>   
>>   		if (pipe->vtp_locked) {
>> -			dc->hwss.set_hubp_blank(dc, pipe, true);
>> +			dc->hwseq->funcs.wait_for_blank_complete(pipe->stream_res.opp);
>> +			pipe->plane_res.hubp->funcs->set_blank(pipe->plane_res.hubp, true);
>>   			pipe->vtp_locked = false;
>> +
>> +			for (mpcc_pipe = pipe->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
>> +				mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
>> +
>> +			for (i = 0; i < dc->res_pool->pipe_count; i++)
>> +				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
>> +					dc->hwss.disable_plane(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
>>   		}
>>   	}
>>   	/* WA to apply WM setting*/
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
>> index 51a4166e9750..de9dcbeea150 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
>> @@ -94,7 +94,6 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
>>   	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
>>   #endif
>>   	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
>> -	.set_hubp_blank = dcn10_set_hubp_blank,
>>   };
>>   
>>   static const struct hwseq_private_funcs dcn20_private_funcs = {
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
>> index 0597391b2171..074e2713257f 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
>> @@ -99,7 +99,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
>>   #endif
>>   	.is_abm_supported = dcn21_is_abm_supported,
>>   	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
>> -	.set_hubp_blank = dcn10_set_hubp_blank,
>>   };
>>   
>>   static const struct hwseq_private_funcs dcn21_private_funcs = {
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
>> index ab93da667d51..d84164f0000c 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
>> @@ -938,53 +938,6 @@ void dcn30_hardware_release(struct dc *dc)
>>   				dc->res_pool->hubbub, true, true);
>>   }
>>   
>> -void dcn30_set_hubp_blank(const struct dc *dc,
>> -		struct pipe_ctx *pipe_ctx,
>> -		bool blank_enable)
>> -{
>> -	struct pipe_ctx *mpcc_pipe;
>> -	struct pipe_ctx *odm_pipe;
>> -
>> -	if (blank_enable) {
>> -		struct plane_resource *plane_res = &pipe_ctx->plane_res;
>> -		struct stream_resource *stream_res = &pipe_ctx->stream_res;
>> -
>> -		/* Wait for enter vblank */
>> -		stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_VBLANK);
>> -
>> -		/* Blank HUBP to allow p-state during blank on all timings */
>> -		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
>> -		/* Confirm hubp in blank */
>> -		ASSERT(plane_res->hubp->funcs->hubp_in_blank(plane_res->hubp));
>> -		/* Toggle HUBP_DISABLE */
>> -		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, true);
>> -		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, false);
>> -		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe) {
>> -			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
>> -			/* Confirm hubp in blank */
>> -			ASSERT(mpcc_pipe->plane_res.hubp->funcs->hubp_in_blank(mpcc_pipe->plane_res.hubp));
>> -			/* Toggle HUBP_DISABLE */
>> -			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_res.hubp, true);
>> -			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_res.hubp, false);
>> -
>> -		}
>> -		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
>> -			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, true);
>> -			/* Confirm hubp in blank */
>> -			ASSERT(odm_pipe->plane_res.hubp->funcs->hubp_in_blank(odm_pipe->plane_res.hubp));
>> -			/* Toggle HUBP_DISABLE */
>> -			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.hubp, true);
>> -			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.hubp, false);
>> -		}
>> -	} else {
>> -		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
>> -		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
>> -			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
>> -		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
>> -			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, false);
>> -	}
>> -}
>> -
>>   void dcn30_set_disp_pattern_generator(const struct dc *dc,
>>   		struct pipe_ctx *pipe_ctx,
>>   		enum controller_dp_test_pattern test_pattern,
>> @@ -994,6 +947,7 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
>>   		int width, int height, int offset)
>>   {
>>   	struct stream_resource *stream_res = &pipe_ctx->stream_res;
>> +	struct pipe_ctx *mpcc_pipe;
>>   
>>   	if (test_pattern != CONTROLLER_DP_TEST_PATTERN_VIDEOMODE) {
>>   		pipe_ctx->vtp_locked = false;
>> @@ -1005,12 +959,20 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,

Additional hunk 2
>>   		if (stream_res->tg->funcs->is_tg_enabled(stream_res->tg)) {
>>   			if (stream_res->tg->funcs->is_locked(stream_res->tg))
>>   				pipe_ctx->vtp_locked = true;
>> -			else
>> -				dc->hwss.set_hubp_blank(dc, pipe_ctx, true);
>> +			else {
>> +				/* Blank HUBP to allow p-state during blank on all timings */
>> +				pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
>> +
>> +				for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
>> +					mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
>> +			}
>>   		}
>>   	} else {
>> -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
>>   		/* turning off DPG */
>> +		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
>> +		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
>> +			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
>> +
>>   		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
>>   				color_depth, solid_color, width, height, offset);
>>   	}
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
>> index 3b7d4812e311..e9a0005288d3 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
>> @@ -80,8 +80,4 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
>>   		const struct tg_color *solid_color,
>>   		int width, int height, int offset);
>>   
>> -void dcn30_set_hubp_blank(const struct dc *dc,
>> -		struct pipe_ctx *pipe_ctx,
>> -		bool blank_enable);
>> -
>>   #endif /* __DC_HWSS_DCN30_H__ */
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
>> index 204444fead97..c4c14e9c1309 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
>> @@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
>>   	.hardware_release = dcn30_hardware_release,
>>   	.set_pipe = dcn21_set_pipe,
>>   	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
>> -	.set_hubp_blank = dcn30_set_hubp_blank,
>>   };
>>   
>>   static const struct hwseq_private_funcs dcn30_private_funcs = {
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
>> index b8bf6d61005b..bdad72140cbc 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
>> @@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
>>   	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
>>   	.set_pipe = dcn21_set_pipe,
>>   	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
>> -	.set_hubp_blank = dcn30_set_hubp_blank,
>>   };
>>   
>>   static const struct hwseq_private_funcs dcn301_private_funcs = {
>> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
>> index 0586ab2ffd6a..613b3e3cb46a 100644
>> --- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
>> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
>> @@ -231,10 +231,6 @@ struct hw_sequencer_funcs {
>>   			enum dc_color_depth color_depth,
>>   			const struct tg_color *solid_color,
>>   			int width, int height, int offset);
>> -
>> -	void (*set_hubp_blank)(const struct dc *dc,
>> -			struct pipe_ctx *pipe_ctx,
>> -			bool blank_enable);
>>   };
>>   
>>   void color_space_to_black_color(
>> -- 
>> 2.30.1
>>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7C7700f89c242d4d5b837308d8d2d6cec7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637491167330054893%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uxidmH%2FvP7CIAaeYbJHtqQ1GM%2BZt5zfbNyfCWnSkhR4%3D&amp;reserved=0
> 

-- 
Regards,
Aurabindo Pillai
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
