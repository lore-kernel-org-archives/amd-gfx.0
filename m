Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA940C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 15:36:36 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71AF464D9A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 15:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AF464D9A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27EB96E176;
	Wed, 17 Feb 2021 15:36:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062.outbound.protection.outlook.com [40.107.93.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E65D96E176
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 15:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PeWjjpUZY1xNE18HrYMAAUDiqEKJbwU2AMTMSapM0498IGOJJ0wQ9VB9dt+01bMqOLjdHk0JZTsKwLIn/YeEGWeFZ4FXWqfPkOutC53ny11P7Irj3dQKFgYceeyQP/31+wm0yCEE2rN1OtdU805jXO6wXm7nHG+OAF0AtCi6jCz/mVv5GXI9855LEKmiNXA9C63u6YUAwrd5AUCf7AgC9vYGyiBbUkXJHFftWqxOMsUlrbAxpiacscCGjv1a+p0utiho+Z8edf3Y5ESGV78iOyImiIAXZOslZesFbqJkJHnETkoALv73rFv2ER1TphsIQuUMu2V0YWDxb+CXIPOqYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdH4DMGqwsnTR85OJt0bjPh0pp2/qFzq+QmwEW7co58=;
 b=e8Dg9Ych8495ojxkSqKnedL77eCu38sM3l8Z3TmKc1jtekDemcKrZQ04T5849YsfhuSek2AvOOwzn8wKZKqAr2dPnt+6pryjAKeyetgUN/hahxM30ZE4sHk2ub4EZaylX4KQv3eakU3ho4A8KN0kxYTQX0EAlXYp+a+FixFmul9uuXxjG5PV8djNTUYFWc90EwNqvTGucFIZTFhue/gnDRwbAoBvZTgzNLtLMcamOA43CAM7wXjmrs1l0ssT0U+H3j5k4TWjlsE3cZUgu+qImm7BrRkiyy775yuYoZIntyR9vqARHI1/5OJRDdZFla3pKQQVkffb53cXB7aGHFGHng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdH4DMGqwsnTR85OJt0bjPh0pp2/qFzq+QmwEW7co58=;
 b=21GecH+JO7chicpIPmk7uhKHN1d++5pswm/PAV+dvk8xFm4GB80ZjuF0lx1XJOJR69L6obYFkESAlG2FA7kcQLsqc+NFo/PaA+VNepAR9Rko6B2bTEsCLv+4CA7zqJHmO4S12SV4plIYRk2vYo0Ed7p1SBp3L476bo+8/NJAH3c=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.30; Wed, 17 Feb
 2021 15:36:32 +0000
Received: from SA0PR12MB4495.namprd12.prod.outlook.com
 ([fe80::751e:bc35:a13b:7680]) by SA0PR12MB4495.namprd12.prod.outlook.com
 ([fe80::751e:bc35:a13b:7680%9]) with mapi id 15.20.3846.042; Wed, 17 Feb 2021
 15:36:32 +0000
Subject: Re: [PATCH] drm/amd/display: Old sequence for HUBP blank
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <20210216235841.154819-1-aurabindo.pillai@amd.com>
 <20210217134014.4gqi6c2tliba23ze@outlook.office365.com>
 <497e82ee-af5a-11a6-7f42-4197ff449749@amd.com>
 <20210217152910.uyfo5b6xvsrcv4sq@outlook.office365.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Message-ID: <3c152a54-0280-657d-6ec6-4f79a52ede22@amd.com>
Date: Wed, 17 Feb 2021 10:36:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210217152910.uyfo5b6xvsrcv4sq@outlook.office365.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.250]
X-ClientProxiedBy: YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::15) To SA0PR12MB4495.namprd12.prod.outlook.com
 (2603:10b6:806:70::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.29.228.121] (165.204.55.250) by
 YTBPR01CA0002.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.35 via Frontend Transport; Wed, 17 Feb 2021 15:36:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fc5072d-195a-4130-d54d-08d8d359cd66
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB236712B4AC8E3E6F8BDAB3068B869@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zHm7kH+Yawbmp0XQ+TQwz40q4CukmeH49FKfL/XEE6nNLaEzn/WGiOHuaBOLG6BrI1+FOADaSGACWDODa9gUVXBmLeP7L7c4Mo2M5HbixzmGrIJw/8f5GFg3cwMnMJOaIqHo3f/xQ8QRTvqpdP7i3a0mrS02Ow21QfeUsKdRNM1PU/RTSxtXERDnymjpU7y7in0D3t+8TnpAWFsCqv1/OIjGixGaP6+lP0M8Rg+IARiU4Q5D7IdqXd3WEXD61TISwFkn3vPh7pVYfcXL3ANmlLvb6NHKEQoqgmAtCkrO+PhplboxCoVHC/Sr7kysA5mqkox3Ey6iCMgHI5FDS1ouHxQbp1wvM3spJ6biXzKoVWPvC+WLn9VR/N9YZMuH1WfCL3gvLWixWHCUDjT6NZSoRYvWU03El8w4dDsveisb3V4aqNMlofOYQgjZm1AHw6HA0XwOShsHuPyIxMbbJQURRTSkoY0DkjCBFkHUN1MK2EHplIpXEwHA+f+pVJS5Ai94fjBfM7EQVbzL6RuTxFZQNm7j6wWtzHlOgV3nbHU3/WZCO9JKaOXuBLawjdmuO2CzIW3Gq5S4XOLwJf3yvXsvu39VmtVfC77bl2Zqy9smYO0Bl5E7Ll7sXVA8kap61pSQkTvoRkr1wmJR5Zh2LsQyIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4495.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(2906002)(956004)(83380400001)(6862004)(2616005)(186003)(316002)(66556008)(37006003)(4326008)(66476007)(6486002)(44832011)(16576012)(16526019)(31686004)(36756003)(966005)(8936002)(31696002)(8676002)(6636002)(45080400002)(26005)(478600001)(30864003)(86362001)(52116002)(66946007)(53546011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?Windows-1252?Q?4uOZu++s2RPJxnRHndzzzun/kB//MV6Zfm/hK6rPm0kqMaEkjbG2xbKl?=
 =?Windows-1252?Q?NnxdvZmmzL3YE4Qb/HlfucEqj5KUGhYq4F31R/cXgkGcGuS9mbrDsiiw?=
 =?Windows-1252?Q?8O4l1UgkVALzoT9alnxbaFf1zkAMw/gnA3cio3xoM3DfzGXx+WFOwhLk?=
 =?Windows-1252?Q?Gk4r+WsJl2+BlDpBldep/wdxhbObOsu5AZPTztr5QdvrpxPwSmx0883k?=
 =?Windows-1252?Q?kx3ujtNJIlz1vfcuv/D1VU0013BEiOf0Eb3tmz8MztECTK+g/dN94JX7?=
 =?Windows-1252?Q?3x2VrVKG/PKAs/GviWiD5CtjBXpy7TdDrOrWv6V6J8c/p3gq5+yxLNwJ?=
 =?Windows-1252?Q?Fd1RS9ih+xHR+0ElHLng4KTQ47d9b4GFt9JF3VNl2d9U1lFTh1nciTU0?=
 =?Windows-1252?Q?RtqAw7UAfgn7PWt+ASksVeFC73/9yDQF7pJ/8LPyna81P3PRwbmsGDa2?=
 =?Windows-1252?Q?Qq4syYJro45N6EfJRdC7m2cGGe5lDg2p5tV5nVqr35SIktWvMhr6Ma5k?=
 =?Windows-1252?Q?VgwWXmV2oXbRGhVE3eebwR+ABxgz2IA0K89vUhWpxCwbssMdHtHHt7mj?=
 =?Windows-1252?Q?GfuUQuupF8wH0JTyW7Ard8P5VFX6xpKIY74M8HfLUNf9zSt/ss3qpPOq?=
 =?Windows-1252?Q?7AgPdN3uAgphJBBCyAnZv+CaHFYO3qt5wJZIpScglmAzhSrU2C4TDJ3K?=
 =?Windows-1252?Q?7TM8Zq49qRIGKe0Vsv8he3I9zOdwUorXVQzc8EqR2uI8DWaeVejobq83?=
 =?Windows-1252?Q?IRMQP186sctuK+RX9lbeA2bFb1Lh4MQ5jxtBgXMYF/W5kUSfvafAiD47?=
 =?Windows-1252?Q?zMYkqCvra4yc6kopIcdKE8Spr2BG6MT/jYmIodQDiPa6XeaGLGjlVdXS?=
 =?Windows-1252?Q?wEjyRj8qd1ldwRUGetlLASc9Zyf6PhA8WbkTjCWq0WGQYexWJQlQD1j8?=
 =?Windows-1252?Q?THvdYnougDMtAWKDKOV6YjBPGgd7nKiCFLcd07r7QIErwROwvz/Cd8Ln?=
 =?Windows-1252?Q?mVF1rs7l2Ah/M0VUGILNZP8wVrvov2cCXq5MLpfdFp9HqGAgXSAoLsci?=
 =?Windows-1252?Q?zXC2KqyojsfCqFjnUrLJhsavs4QySBSKUUu3C0/TnaNGUUwRW3qt4wxf?=
 =?Windows-1252?Q?eRdXoX9CDld+kuvkZe1kwq6/4UWl+KNZg5f+ZcYtMnOU283sZCWqs4as?=
 =?Windows-1252?Q?MqM5P/sKhTWBVDeiXzmZOO9NRmpNw4ll/Aw4BDfw1CjujENX2rZTGadB?=
 =?Windows-1252?Q?uFH7b1Pg0MQHXfGo1K1HBMhN0KHAMTw4ARJ3IIJIx0I/b+8YClXiWpQ1?=
 =?Windows-1252?Q?5PcC80rUTToZ5363FB5jjAObIh7lANNDLhbSJN6HhyL70by+Z+NyPjWN?=
 =?Windows-1252?Q?EnXeQfjRnvdBNGM0ifuoESR9uVTZ7hq9OF18kYW5q7X8phl39nVwR2OL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc5072d-195a-4130-d54d-08d8d359cd66
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4495.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 15:36:32.7361 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2PZvnNZoUerEn5wM/f7ggZ3UyGnMBhXU/SUbEQTmM1iNXWCPYE+Ht+jLuZNhWTq4Bb2KAi0iz+cbKaFNgBi1Xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
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



On 2021-02-17 10:29 a.m., Rodrigo Siqueira wrote:
> On 02/17, Aurabindo Pillai wrote:
>>
>>
>> On 2021-02-17 8:40 a.m., Rodrigo Siqueira wrote:
>>> Hi,
>>>
>>> Is this commit a direct revert from
>>> be7af780ef3cbb8fe1004db48dc66caf2da595cd ?
>>>
>>> If so, I recommend you to use the standard way to identify "revert"
>>> commits by using 'Revert "Commit header"' and the message "This reverts
>>> commit HASH" followed by the original commit description.
>>
>> This is not an exact revert. It includes two more hunks which were not part
>> of the original commit. But logically this should be one unit, and hence
>> having them separated might introduce regressions.
> 
> Ok,
> In this case, remove the "revert" in the commit description to avoid
> misleading information and add the Fixes tag at the end. With these
> changes:
> 
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Thanks for the suggestions and review!
>   
>>>
>>> Thanks
>>> Siqueira
>>>
>>> On 02/16, Aurabindo Pillai wrote:
>>>> This reverts commit be7af780ef3cbb8fe1004db48dc66caf2da595cd because the
>>>> new proposed sequence for HUBP blanking causes regressions. This change
>>>> brings back the old sequence.
>>>>
>>>> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>>> Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
>>>> ---
>>>>    .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 +++--------
>>>>    .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  3 -
>>>>    .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 -
>>>>    .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 13 +++-
>>>>    .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 -
>>>>    .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 -
>>>>    .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 62 ++++---------------
>>>>    .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 --
>>>>    .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 -
>>>>    .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 -
>>>>    .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 --
>>>>    11 files changed, 30 insertions(+), 97 deletions(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>>>> index 89912bb5014f..361a97edc8ee 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
>>>> @@ -2635,7 +2635,7 @@ static void dcn10_update_dchubp_dpp(
>>>>    	hws->funcs.update_plane_addr(dc, pipe_ctx);
>>>>    	if (is_pipe_tree_visible(pipe_ctx))
>>>> -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
>>>> +		hubp->funcs->set_blank(hubp, false);
>>>>    }
>>>>    void dcn10_blank_pixel_data(
>>>> @@ -3146,16 +3146,13 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
>>>>    	return;
>>>>    }
>>>> -static struct pipe_ctx *get_pipe_ctx_by_hubp_inst(struct dc_state *context, int mpcc_inst)
>>>> +static struct hubp *get_hubp_by_inst(struct resource_pool *res_pool, int mpcc_inst)
>>>>    {
>>>>    	int i;
>>>> -	for (i = 0; i < MAX_PIPES; i++) {
>>>> -		if (context->res_ctx.pipe_ctx[i].plane_res.hubp
>>>> -				&& context->res_ctx.pipe_ctx[i].plane_res.hubp->inst == mpcc_inst) {
>>>> -			return &context->res_ctx.pipe_ctx[i];
>>>> -		}
>>>> -
>>>> +	for (i = 0; i < res_pool->pipe_count; i++) {
>>>> +		if (res_pool->hubps[i]->inst == mpcc_inst)
>>>> +			return res_pool->hubps[i];
>>>>    	}
>>>>    	ASSERT(false);
>>>>    	return NULL;
>>>> @@ -3178,23 +3175,11 @@ void dcn10_wait_for_mpcc_disconnect(
>>>>    	for (mpcc_inst = 0; mpcc_inst < MAX_PIPES; mpcc_inst++) {
>>>>    		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
>>>> -			struct pipe_ctx *restore_bottom_pipe;
>>>> -			struct pipe_ctx *restore_top_pipe;
>>>> -			struct pipe_ctx *inst_pipe_ctx = get_pipe_ctx_by_hubp_inst(dc->current_state, mpcc_inst);
>>>> +			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
>>>> -			ASSERT(inst_pipe_ctx);
>>>>    			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
>>>>    			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
>>>> -			/*
>>>> -			 * Set top and bottom pipes NULL, as we don't want
>>>> -			 * to blank those pipes when disconnecting from MPCC
>>>> -			 */
>>>> -			restore_bottom_pipe = inst_pipe_ctx->bottom_pipe;
>>>> -			restore_top_pipe = inst_pipe_ctx->top_pipe;
>>>> -			inst_pipe_ctx->top_pipe = inst_pipe_ctx->bottom_pipe = NULL;
>>>> -			dc->hwss.set_hubp_blank(dc, inst_pipe_ctx, true);
>>>> -			inst_pipe_ctx->top_pipe = restore_top_pipe;
>>>> -			inst_pipe_ctx->bottom_pipe = restore_bottom_pipe;
>>>> +			hubp->funcs->set_blank(hubp, true);
>>>>    		}
>>>>    	}
>>>> @@ -3747,10 +3732,3 @@ void dcn10_get_clock(struct dc *dc,
>>>>    				dc->clk_mgr->funcs->get_clock(dc->clk_mgr, context, clock_type, clock_cfg);
>>>>    }
>>>> -
>>>> -void dcn10_set_hubp_blank(const struct dc *dc,
>>>> -				struct pipe_ctx *pipe_ctx,
>>>> -				bool blank_enable)
>>>> -{
>>>> -	pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, blank_enable);
>>>> -}
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
>>>> index 89e6dfb63da0..dee8ad1ebaa4 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
>>>> @@ -204,8 +204,5 @@ void dcn10_wait_for_pending_cleared(struct dc *dc,
>>>>    		struct dc_state *context);
>>>>    void dcn10_set_hdr_multiplier(struct pipe_ctx *pipe_ctx);
>>>>    void dcn10_verify_allow_pstate_change_high(struct dc *dc);
>>>> -void dcn10_set_hubp_blank(const struct dc *dc,
>>>> -				struct pipe_ctx *pipe_ctx,
>>>> -				bool blank_enable);
>>>>    #endif /* __DC_HWSS_DCN10_H__ */
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
>>>> index 2f1b802e66a1..254300b06b43 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
>>>> @@ -79,7 +79,6 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
>>>>    	.set_backlight_level = dce110_set_backlight_level,
>>>>    	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
>>>>    	.set_pipe = dce110_set_pipe,
>>>> -	.set_hubp_blank = dcn10_set_hubp_blank,
>>>>    };
>>>>    static const struct hwseq_private_funcs dcn10_private_funcs = {
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>>>> index b79a17f6a9cc..48d1e0e2cf75 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>>
>> Additional hunk 1
>>>> @@ -1576,7 +1576,7 @@ static void dcn20_update_dchubp_dpp(
>>>>    	if (pipe_ctx->update_flags.bits.enable)
>>>> -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
>>>> +		hubp->funcs->set_blank(hubp, false);
>>>>    }
>>>> @@ -1772,10 +1772,19 @@ void dcn20_post_unlock_program_front_end(
>>>>    	for (i = 0; i < dc->res_pool->pipe_count; i++) {
>>>>    		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
>>>> +		struct pipe_ctx *mpcc_pipe;
>>>>    		if (pipe->vtp_locked) {
>>>> -			dc->hwss.set_hubp_blank(dc, pipe, true);
>>>> +			dc->hwseq->funcs.wait_for_blank_complete(pipe->stream_res.opp);
>>>> +			pipe->plane_res.hubp->funcs->set_blank(pipe->plane_res.hubp, true);
>>>>    			pipe->vtp_locked = false;
>>>> +
>>>> +			for (mpcc_pipe = pipe->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
>>>> +				mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
>>>> +
>>>> +			for (i = 0; i < dc->res_pool->pipe_count; i++)
>>>> +				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
>>>> +					dc->hwss.disable_plane(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
>>>>    		}
>>>>    	}
>>>>    	/* WA to apply WM setting*/
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
>>>> index 51a4166e9750..de9dcbeea150 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
>>>> @@ -94,7 +94,6 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
>>>>    	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
>>>>    #endif
>>>>    	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
>>>> -	.set_hubp_blank = dcn10_set_hubp_blank,
>>>>    };
>>>>    static const struct hwseq_private_funcs dcn20_private_funcs = {
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
>>>> index 0597391b2171..074e2713257f 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
>>>> @@ -99,7 +99,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
>>>>    #endif
>>>>    	.is_abm_supported = dcn21_is_abm_supported,
>>>>    	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
>>>> -	.set_hubp_blank = dcn10_set_hubp_blank,
>>>>    };
>>>>    static const struct hwseq_private_funcs dcn21_private_funcs = {
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
>>>> index ab93da667d51..d84164f0000c 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
>>>> @@ -938,53 +938,6 @@ void dcn30_hardware_release(struct dc *dc)
>>>>    				dc->res_pool->hubbub, true, true);
>>>>    }
>>>> -void dcn30_set_hubp_blank(const struct dc *dc,
>>>> -		struct pipe_ctx *pipe_ctx,
>>>> -		bool blank_enable)
>>>> -{
>>>> -	struct pipe_ctx *mpcc_pipe;
>>>> -	struct pipe_ctx *odm_pipe;
>>>> -
>>>> -	if (blank_enable) {
>>>> -		struct plane_resource *plane_res = &pipe_ctx->plane_res;
>>>> -		struct stream_resource *stream_res = &pipe_ctx->stream_res;
>>>> -
>>>> -		/* Wait for enter vblank */
>>>> -		stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_VBLANK);
>>>> -
>>>> -		/* Blank HUBP to allow p-state during blank on all timings */
>>>> -		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
>>>> -		/* Confirm hubp in blank */
>>>> -		ASSERT(plane_res->hubp->funcs->hubp_in_blank(plane_res->hubp));
>>>> -		/* Toggle HUBP_DISABLE */
>>>> -		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, true);
>>>> -		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, false);
>>>> -		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe) {
>>>> -			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
>>>> -			/* Confirm hubp in blank */
>>>> -			ASSERT(mpcc_pipe->plane_res.hubp->funcs->hubp_in_blank(mpcc_pipe->plane_res.hubp));
>>>> -			/* Toggle HUBP_DISABLE */
>>>> -			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_res.hubp, true);
>>>> -			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_res.hubp, false);
>>>> -
>>>> -		}
>>>> -		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
>>>> -			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, true);
>>>> -			/* Confirm hubp in blank */
>>>> -			ASSERT(odm_pipe->plane_res.hubp->funcs->hubp_in_blank(odm_pipe->plane_res.hubp));
>>>> -			/* Toggle HUBP_DISABLE */
>>>> -			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.hubp, true);
>>>> -			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.hubp, false);
>>>> -		}
>>>> -	} else {
>>>> -		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
>>>> -		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
>>>> -			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
>>>> -		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
>>>> -			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, false);
>>>> -	}
>>>> -}
>>>> -
>>>>    void dcn30_set_disp_pattern_generator(const struct dc *dc,
>>>>    		struct pipe_ctx *pipe_ctx,
>>>>    		enum controller_dp_test_pattern test_pattern,
>>>> @@ -994,6 +947,7 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
>>>>    		int width, int height, int offset)
>>>>    {
>>>>    	struct stream_resource *stream_res = &pipe_ctx->stream_res;
>>>> +	struct pipe_ctx *mpcc_pipe;
>>>>    	if (test_pattern != CONTROLLER_DP_TEST_PATTERN_VIDEOMODE) {
>>>>    		pipe_ctx->vtp_locked = false;
>>>> @@ -1005,12 +959,20 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
>>
>> Additional hunk 2
>>>>    		if (stream_res->tg->funcs->is_tg_enabled(stream_res->tg)) {
>>>>    			if (stream_res->tg->funcs->is_locked(stream_res->tg))
>>>>    				pipe_ctx->vtp_locked = true;
>>>> -			else
>>>> -				dc->hwss.set_hubp_blank(dc, pipe_ctx, true);
>>>> +			else {
>>>> +				/* Blank HUBP to allow p-state during blank on all timings */
>>>> +				pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
>>>> +
>>>> +				for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
>>>> +					mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
>>>> +			}
>>>>    		}
>>>>    	} else {
>>>> -		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
>>>>    		/* turning off DPG */
>>>> +		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
>>>> +		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
>>>> +			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
>>>> +
>>>>    		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
>>>>    				color_depth, solid_color, width, height, offset);
>>>>    	}
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
>>>> index 3b7d4812e311..e9a0005288d3 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
>>>> @@ -80,8 +80,4 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
>>>>    		const struct tg_color *solid_color,
>>>>    		int width, int height, int offset);
>>>> -void dcn30_set_hubp_blank(const struct dc *dc,
>>>> -		struct pipe_ctx *pipe_ctx,
>>>> -		bool blank_enable);
>>>> -
>>>>    #endif /* __DC_HWSS_DCN30_H__ */
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
>>>> index 204444fead97..c4c14e9c1309 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
>>>> @@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
>>>>    	.hardware_release = dcn30_hardware_release,
>>>>    	.set_pipe = dcn21_set_pipe,
>>>>    	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
>>>> -	.set_hubp_blank = dcn30_set_hubp_blank,
>>>>    };
>>>>    static const struct hwseq_private_funcs dcn30_private_funcs = {
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
>>>> index b8bf6d61005b..bdad72140cbc 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
>>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
>>>> @@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
>>>>    	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
>>>>    	.set_pipe = dcn21_set_pipe,
>>>>    	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
>>>> -	.set_hubp_blank = dcn30_set_hubp_blank,
>>>>    };
>>>>    static const struct hwseq_private_funcs dcn301_private_funcs = {
>>>> diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
>>>> index 0586ab2ffd6a..613b3e3cb46a 100644
>>>> --- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
>>>> +++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
>>>> @@ -231,10 +231,6 @@ struct hw_sequencer_funcs {
>>>>    			enum dc_color_depth color_depth,
>>>>    			const struct tg_color *solid_color,
>>>>    			int width, int height, int offset);
>>>> -
>>>> -	void (*set_hubp_blank)(const struct dc *dc,
>>>> -			struct pipe_ctx *pipe_ctx,
>>>> -			bool blank_enable);
>>>>    };
>>>>    void color_space_to_black_color(
>>>> -- 
>>>> 2.30.1
>>>>
>>>> _______________________________________________
>>>> amd-gfx mailing list
>>>> amd-gfx@lists.freedesktop.org
>>>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CRodrigo.Siqueira%40amd.com%7C7700f89c242d4d5b837308d8d2d6cec7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637491167330054893%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=uxidmH%2FvP7CIAaeYbJHtqQ1GM%2BZt5zfbNyfCWnSkhR4%3D&amp;reserved=0
>>>
>>
>> -- 
>> Regards,
>> Aurabindo Pillai
> 
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
