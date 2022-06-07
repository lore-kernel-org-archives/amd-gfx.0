Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B53FCCA47C
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 18:24:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 018C610F383;
	Tue,  7 Jun 2022 18:24:41 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD4D10F2E6
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 18:24:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDvefkUfiPuh2C2k9veYEjuPENp9GgZRxj990v4Z9OTlWndcc7RPKycVM+gcticIDoxzlITXVOvxIknDzzL1ifpw8m/IZjWfeFLtAKFR7JoWWCKdCEe6Z0GcqMFojKxtBPix9hSSJ2NxWSNEhRHDI5vcb58Ey/49sS/nNHBGZaeqKtfNZKveEpYhLf4J8QlJd/h7GJNoEu7D5TPqLD+k4FnVOgtLyLx/7Qfp+QQJg99TJ24+Tkotgbmh6CORAdwPD+inPLC487aracTQFPm4kLs3g4jr0griUI5d+e1fJjhFmn9w4+cJXEvSnyuYX69qbsJDEdF+tsXy1v25TFxJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bVe6H0C6Vo5zvtUFcG15bXorTGSDaiIZ9gP7nJY8gu0=;
 b=TfSYoWV4l4cOQ5p5YLVUAcG1veIdQokp0PWXd2A6B4WQ77b16Z/5NyXWVqgkPwUlmitilBq1twsj28sXD4FZZpibNu9Ii2r2nmg41Dgeel5XE0Nxr4gm7/R1QxNoh5RfINF0pnZWJyMaaxzE8UARE/3QvaYUh2YvIOB84UQL/21ZAWOIUUvyc/z3k6iNCfKGQgyXGiwcbCTxdkryZfc2nYFVOohKB9V9ztLhqu3mbjSybHadOWxJE/vu1DEJV9VVRPL6V0a4NPNPeZFjrgUhatImZiNIU6/M199C5D68be7HPFFnJ68MVNO9kO6DkihSalNKK5XfVXDs0YaN6wZ2DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bVe6H0C6Vo5zvtUFcG15bXorTGSDaiIZ9gP7nJY8gu0=;
 b=ko55B7UiBD/I+i1PL/uUrBoWp9yXQVo0YMj9mQTQ5OShs1MpJLT84Qe+/8rn9G2p1f9h7+cEIlP5iFDwacTSxR7kLN9+PUsRPe+GknXvVZtOWoaVgnItZAf7AMdYoBPPc5AfDDctKWQ1NmuV0aj+V2+Berk7IbSpGk0e9ux53Ow=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by BN6PR12MB1858.namprd12.prod.outlook.com (2603:10b6:404:fe::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Tue, 7 Jun
 2022 18:24:38 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::71bf:7a78:d4dd:4d94]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::71bf:7a78:d4dd:4d94%9]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 18:24:37 +0000
Message-ID: <634aa5a4-d4d5-7768-e95a-6bfe37447874@amd.com>
Date: Tue, 7 Jun 2022 14:24:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH] drm/amd/display: fix null pointer deref error
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>,
 Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
References: <20220607170647.217574-1-aurabindo.pillai@amd.com>
 <a4d82dce-784e-03ca-52aa-abe57b4e5448@amd.com>
 <CADnq5_PgLGiNFiLBTSACdLi9f+3pg_EK=OXXs+BDe=9GuQJnGA@mail.gmail.com>
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
In-Reply-To: <CADnq5_PgLGiNFiLBTSACdLi9f+3pg_EK=OXXs+BDe=9GuQJnGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0014.namprd13.prod.outlook.com
 (2603:10b6:208:256::19) To CH0PR12MB5284.namprd12.prod.outlook.com
 (2603:10b6:610:d7::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfb2f31b-6afb-4134-5dce-08da48b2faf2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1858:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB185855186695597F04811D968BA59@BN6PR12MB1858.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LDTVJ5Ja30lO8skf+dCufHvnM4tDIs4u9q7symrL5C+BektWP0bihHtzEBd69xpsgvNFLGwSlB+q7Xme0yfGFRU6szSWHgWvyyvlvXV163k1Odk+KpBOyYODHWUzBi210sQJx5weQ1fbeOg5lM4xGlsH99n1fsziaGvdSEhvpItxYyT7guFV0WVr8QRMP1EuR/cJpIw87YPV+G/ooDSJwTgEvCnxIKOmg7TSGE+qJckqW06/M7h4OSF0vaQBy3FenF6WwZQAc8iw1RV1VcnG6lF9I5O44Eig4DFytxwEd/zQlqA8gs0OopAWcfK+g33LiodrUWhJ6iG8uLOtVvzXVa7Ys9wa6R8HD4GNR4MFK++m1s8h2eVQYFjRUTC47LxP3xaYtX/VLIpGM6WkC6+KZBUn1FD67uPiC2FsS7qvSbma2kmHMrlJGIokGEAVUoCws+3G3qrFE5hyxiaRadVZ7/JnMz2W4nIGwx41L+f46TMhbkZpOEGuXqm0OhCb3NbdX+AIPIahUilmTZ2yniD9XXhP850eajBmhaOKjyioTwM+lYHEZMs7K9p3GbQmNiGUbeuia7eQT2qbiVa/PslwuFH3IDyrPqTqqPQDvsmdStH8u6vqUTpNYufrS3EXkIr5JMPYWwj1KrbKCpcgP7bwjglS9HJqDyw8spGQftIoXu7OJDkv+krG1dxpnL/TERPLb5lfRMdL2Dh8ZwIYT3zHKxBTrZrNmwxsarmqqABcnskp8i9DG4w5qXQ5xQjLqK8u
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31696002)(54906003)(36756003)(2906002)(66556008)(316002)(31686004)(110136005)(2616005)(66946007)(86362001)(66476007)(53546011)(6512007)(26005)(6506007)(83380400001)(44832011)(38100700002)(8676002)(4326008)(5660300002)(6486002)(186003)(8936002)(508600001)(6636002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MGdIdFQ1SDBWdzdSZVNqZlV2OHpIMFZVNmwrSmpEbUJmdksxUkdNaVdHZmRp?=
 =?utf-8?B?SWI3bFJUcWN1MXFhdXp0RElQWk1taElGcUp3aHp1cEhlUHFWTUxkb3FNclVY?=
 =?utf-8?B?aVpuZ2pCbVRmYmNSNUJTcm53ZzljQTVnUmZNVGtCajRaLy9mWkp2WVdGeDZN?=
 =?utf-8?B?czkxeHNSb2haMktSakh0TTJxNTBiVVFINjl3bW5QZU96a2dIUmdMajJZUUZW?=
 =?utf-8?B?NjZlZFN0UjdiMmdoOVVid01NT0xBcjRmQVhCaVRuVXZrRG9KOXluRVFYTllo?=
 =?utf-8?B?VmFuQXpzNFpxamtxNkxoSC9XYWhrR1dNYjBuRFNhWFVqNTFFRTlrMWtGb1hT?=
 =?utf-8?B?OUhTSmI1VW5KNG9LczdEU1QxMnpYNkxpZXdFajBsTjg2NGY0M0hza1VJODlJ?=
 =?utf-8?B?YUdTWWFpT2J2RUQ5S1d3UmFxTDNpWnR1QysveHhkM0dnZVI2b3NVQjUzQlY3?=
 =?utf-8?B?TitvL1BpRThkZmhWdFVGN3lYRFNMOTIrWEZFNWJGemlFM1RPNzR5cHRpOUls?=
 =?utf-8?B?NzROcG9DVHRZdVp0WHIzL0h0OTIvazM1VVhDMWNKd1lScVNGVGRva0RzMXcw?=
 =?utf-8?B?bDc2SlFyU0FFd2ZtRyt4bGM4cExsRnh4blBhREJaWnY1cmR3RHpwMUdjMVR0?=
 =?utf-8?B?bW1kaFhWa0xUaTREVnRsdWV1WHVENEVkVlh4OUZPTjUwVjBVNEtzd0Q0amJE?=
 =?utf-8?B?dVpFY2VHZGZ2eHFCWnZJaXRMZVdyWTU4VFpFUThVclJOYi9RRnJaZmNPYks5?=
 =?utf-8?B?eEZ6NG96eksxc2Uyc0tCWmFQc1FEVnZuSmJWQmVuaVZYMHBrdW9pcmxiV0VC?=
 =?utf-8?B?dHRqN201aEsvbit4ckZ3MS9mdmVPVFFPRCs5MkVHTmVSbWVPQ0U5Z1FYdG5Y?=
 =?utf-8?B?cHhGK1JxdUthKzdaR2pyalA5NWFlRnpYM3h4aDZxYjkwQjIvVkV3OWV3dXB5?=
 =?utf-8?B?RlpuTktxVmNlL05USkp6RTh2U1d5cXE4MlhKVGo3djdma0RZZGNreXZOT1N5?=
 =?utf-8?B?QUtTY3o5U2JXeTJZdFlRc0xKYkFmWnU5bFJHQVZjdUpXdTN6Yk9taGJGbTNw?=
 =?utf-8?B?Qm1MOXZrUlJuMmxad1JsN0lnUFZGamxmMVBVT3AzQk9vZURaZXRLSGhsVnVJ?=
 =?utf-8?B?SFJGS1ZUa0NKZkQzWHVJS1ZoSEc2MTg4dzdpM1hpRFFFQzBOOHBJTmhrVzNn?=
 =?utf-8?B?TFA2OWhzcnE3MDVkWm1lbWl4aUtFMW5MUUthZGkvUlZrTER4dnBBNlgvcUdC?=
 =?utf-8?B?ekQ0dUtMUmdqOTFjTXZVSU45ampUdEZxa3gxVjFYbDBXV1VqK2tTcFUvdGZM?=
 =?utf-8?B?WXc3QmIxTWtNL2w0dm1wQ09rajRPWThyUUpBOVc5YTlnWk93K2hlK1JHbnBS?=
 =?utf-8?B?UXZPa2xSYVl6OU9NeDJRMzdQelp1QmsxTlBoQ2FQNHAySnBsUzBtZksxVkk4?=
 =?utf-8?B?eWw0M0pweTRNT3BtVEJuOGhpSVREdUVUL2lNQ0oremNleGxRRm1IbXBEdDRr?=
 =?utf-8?B?N01lRU82S3Y3NjdpZldRUE8vYVNScndFVGhaTGRObUR6UWxmeEUxeWtndTZX?=
 =?utf-8?B?aG5iQnNCL0NEc0toM2QvcU94R3FwU1BtaFVkNlVqZDhJSjMvNFdsYkMxYm5N?=
 =?utf-8?B?VjIxNWRHdHl0UjVkdW5KUUFkdmNhZm1yYllydXdLbGxLT25pWnFGTi9Gd0JJ?=
 =?utf-8?B?U2tQVU0vV2RYSjZ6VWRXYW5EbU1MZUJZRHhsS05LWW54c2VNNlI1aVZvVVpE?=
 =?utf-8?B?UkhXMEJpb3IvZER4N3NMSFpvWVd2TFVySVlMYWx6ajZMSjZnakpYQitMZGpj?=
 =?utf-8?B?MEg2SndBYlpzR2FIeWtoOEhyUmQzL1BwWW5ZcEdBZ3U4QmdDQlhPclVLMFJ4?=
 =?utf-8?B?QmJxa0dwUTl2ejhRS2g1aXJZMkM5WU00a3pZRGQweXY3MTVMTmltUUExb2w3?=
 =?utf-8?B?bmZJV3lXb0RsOTZtTENRR0ZPY3VGYktQWkYvV2FScTdOODBEb00xendWQnJy?=
 =?utf-8?B?MXRTUitnTE9aeE82UHBqYjJPalBPN1BnTkt3RkNXcVVOdC9WdzNkMndTbGxB?=
 =?utf-8?B?aWlhdlVqSVFzU2hVdVVwWXlHbVRzMlZvZ2NIdzJXMUUxL2VWT2tkOVVkcjRJ?=
 =?utf-8?B?WjNLcWxJUlNVb1pHYjFDeXB3c3gxOEF4dUd5M0p5cDJlbDRTbUp0VC82Q3RZ?=
 =?utf-8?B?Vk41RWtyVXRZOEZKOFoycnQyY2lsT3pGWTVSSmFMVU0weGxLWlF0b0RQZ3d4?=
 =?utf-8?B?QjRBUGZRQ0lQVi9wQjZsdDJkQXgwajF4ekNya2FDODVHRjg1MEY3ZnF0bEhm?=
 =?utf-8?B?eWNHcXFMK05QdW9NcWpzTjkyUnhVdU9SanVJa2FKTlZ1QWpldmF3Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb2f31b-6afb-4134-5dce-08da48b2faf2
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 18:24:37.9162 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZoVEQtDRvcSfMM9/cK3spIvWx4YmZfa+VFtOrrS3+7iejN7+ltH01tQW/JdO4VeO9kCFnJJkzQUkAgG64CfdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1858
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
Cc: Jerry Zuo <jerry.zuo@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-06-07 13:41, Alex Deucher wrote:
> On Tue, Jun 7, 2022 at 1:40 PM Rodrigo Siqueira Jordao
> <Rodrigo.Siqueira@amd.com> wrote:
>>
>>
>>
>> On 2022-06-07 13:06, Aurabindo Pillai wrote:
>>> [Why]
>>> 0 was passed in place of a pointer which triggered null pointer
>>> dereference.
>>>
>>> [How]
>>> Pass in a pointer that contains nullified parameters instead of null
>>> pointer.
>>>
>>> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
>>> ---
>>>    .../gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c  | 9 ++++++---
>>>    1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>> index 631a8a2f9fc3..e7944c881148 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
>>> @@ -2191,15 +2191,18 @@ static void dce110_setup_audio_dto(
>>>                        build_audio_output(context, pipe_ctx, &audio_output);
>>>
>>>                        if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
>>> -                             /* disable audio DTBCLK DTO */
>>> -                             dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
>>> -                                     dc->res_pool->dccg, 0);
>>> +                             struct dtbclk_dto_params dto_params = {0};
>>>
>>>                                pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
>>>                                                pipe_ctx->stream_res.audio,
>>>                                                pipe_ctx->stream->signal,
>>>                                                &audio_output.crtc_info,
>>>                                                &audio_output.pll_info);
>>> +
>>> +                             /* disable audio DTBCLK DTO */
>>> +                             dc->res_pool->dccg->funcs->set_audio_dtbclk_dto(
>>> +                                     dc->res_pool->dccg, &dto_params);
>>> +
>>>                        } else
>>>                                pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
>>>                                        pipe_ctx->stream_res.audio,
>>
>> Maybe it is a good idea to add the Fixes tag that points to the commit
>> that introduced this regression. Anyway, I'm ok with this change.
> 
> Or at least explain in what case you might hit it or an example backtrace.
> 
> Alex
> 
>>
>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>
Thanks Siqueira & Alex. I'll push with fixes tag and backtrace.
