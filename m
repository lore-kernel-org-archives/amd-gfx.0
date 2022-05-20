Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D35DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 May 2022 17:55:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE8EC10EB7D;
	Fri, 20 May 2022 17:55:58 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2089.outbound.protection.outlook.com [40.107.220.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2532210EB7D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 May 2022 17:55:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiVoCIAJHBJPHspMHE+j8NtD26FpRgU7liMlJ86dCyJKdVVZPE+2VaFl7/7dXHUvUKjeQD2IAmRPrQy2W/6todaDKkIUg/ESAEznSGK1oHVjvm2fMdITtJRzMdOqc33IwbwhymYIGQaSnE0T9AVH7cG86+nlfc3MZmji+cLZS5nxz2ZoTgLq8z9PG1HX/Un79ngObPgAqWrP+NbaErW9ZmUkV551AsGBHLhsilcdUrgcjpHsicq2lGHZzlMvaFDDuszkCD2CROpqtUxP++nF2vTfBGx8vzZaTDDZZBDlBb1ic89o/RNQ3yCO387w5P3zEKaXwIHXZQhqdirm5/BZ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFGfX55UaPRh5+ntHd9fcZ+sxaVCBMX44Yc+tz5hRlA=;
 b=ZO91tny3HSkBHCuKnFhwAeF2i6a93+ot/BLXlpHfNZHzRWftpEFsvjJ6zSdIFR994ypfKvj4cf44i6230JUI39H1gpmVRniXmE/N2qAbSO7Lccaa0zcvK/92LcP5VvEptfuHjNFY55a2j1xMhvDVEys8zV63QiXOb5bpQIlNRs3WG3CvwoBqbWbtnvsAYdYBweV4NZOG1bcD/owXF7i+IlLq4WZHspkhOJnmVegjPy+2QqBG28r847CQdm1L0lInAcXJXgzqxxpTBaLkAsD4al9S2dKYK3EdR7mgl8EgIThmPiDQRVurmOC6hMwWUIRsiht3yO29sVHx+i1o2u7lDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFGfX55UaPRh5+ntHd9fcZ+sxaVCBMX44Yc+tz5hRlA=;
 b=E8mF1J0USzU/IWPGRXBXblmeuVlfJxoc4dgpR4Am1ieAOBtzCmSx1z0cq84RKZid06nAZEn88LZS/x1G86b3Cn0VouVbZKm+Fl+AmJ1eqV2BgbCaDD/GBCxkD4EW8/BZG2xCejwk5EaNVXLTSlliWGmquot9sXDDdDXaghTb46Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by DM5PR12MB2439.namprd12.prod.outlook.com (2603:10b6:4:b4::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.15; Fri, 20 May
 2022 17:55:56 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::540e:d76a:bdf0:ed0d%7]) with mapi id 15.20.5273.018; Fri, 20 May 2022
 17:55:56 +0000
Message-ID: <7a95d6a4-bc2f-b0e8-83f8-8cc5b75599f2@amd.com>
Date: Fri, 20 May 2022 13:55:29 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2] drm/amd/display: add Coverage blend mode for overlay
 plane
Content-Language: en-US
To: "Kim, Sung joon" <Sungjoon.Kim@amd.com>,
 "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
 "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20220513202200.4698-1-Sungjoon.Kim@amd.com>
 <8b8c0c85-1d79-5cfd-f0d2-ebc8b732e0c9@amd.com>
 <3bceb02a-45d3-352b-358b-aa0b57e2da5f@amd.com>
 <MN2PR12MB30549D174773BB4F023DEE3997D39@MN2PR12MB3054.namprd12.prod.outlook.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <MN2PR12MB30549D174773BB4F023DEE3997D39@MN2PR12MB3054.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0317.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:6c::11) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eeec137e-2ff1-4423-bf62-08da3a89fd03
X-MS-TrafficTypeDiagnostic: DM5PR12MB2439:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB243981D7C5B9B0816A88A2168CD39@DM5PR12MB2439.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vry01m/23G6wD5LHxcNOB2VYlutegQ9+aDJRCQd193c9QCVmCyfKZJciws7YuFJDerlEmlLPVCnbiAjqpiBpeQOXRegD/fjHUB/ljQDo7riDsP3qawA3M+WjqFAx7uVXFK4MwtDvemC/I8/wuL3zvX7Cd01ClpAkF24gJQisDAurS5O+9/l/dH6YmhSR81eGazRwSTcFFI0Q06vJ6ma+p+AIe71a8wMxWQTeCHgOLq9OHzew0rHFlwq4iD60XcByMSOXp4GwADU3L/K6r0/poUANV83xS8On3Ohfh0AC70UFasYWudchxdQwmG12Hc8EjCgXLf8U8PtPBkFv5q/hOu0n1/jcFJzZtYGfRPUYa2m6jYF6GNQndeUu72+fT77Yo6FC0vxhvKb+R4o9C2IV8tqUURDUXN8vWI3n7uzOi8a+P/CKBBTkRbyuU+q2KT2YS4U0YDtdefcgFbwsTTCosC3xJxiDczTshY6PjDHc6BlBb4NNjUmhlfUWGzbceC907DwF7rkEPPNFqpLA1+fMlk6ObNmCCT2du+Z1O62FIM6eQyrrkGtdIJBpP+oSroT+k5XUy/HSgieUgRJWOqrH1EHPH9pDXdOPiCZ3Gk7B+ozoB9QAvmX8oD/gWC80PRncVjrKlL1Los6xc+HOx4cb+8C+WIRgt2E9ezuxbHWfr3/7NVpgh9xVlkXshMdCaDb095JuYDHG6KPKwQh+d+mg9u3GaxaK8ZFOi1dMqfeF6aMWIO7ocXbvRCZyeSeRQhPf
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(44832011)(966005)(36756003)(6506007)(26005)(2616005)(508600001)(186003)(5660300002)(2906002)(6666004)(6486002)(83380400001)(8936002)(53546011)(6512007)(31686004)(86362001)(921005)(110136005)(31696002)(66556008)(6636002)(54906003)(4326008)(316002)(8676002)(66476007)(66946007)(38100700002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUNjOTJ0N1d2ZS81eWNKc2p6eWx5YS9JNk5hZTlmeWpvQUd3cmhLZ3Zkc2JZ?=
 =?utf-8?B?V0szS2QydUd0aVhuTnQrYzZqUHAydHJya0xLUUd2NFZmVEpzaWFJRG1reDNJ?=
 =?utf-8?B?RE5RQUpBMi9hZncvZW9QMzd0YXNGNXhHM0FteStEVmwwZ3RRd3VyYlZ2Nk9K?=
 =?utf-8?B?MDB5bklsM2pjZmkvRm83bkhtWFZHL2hGSGtNYVdqa0Zzd25rVmhMdFNDcWVC?=
 =?utf-8?B?V2xqa2VYMFpXRVhpNUtJTFdiUWkwaDh4Uy9pUGxoL3lhVnJLS3BwcURrMnN1?=
 =?utf-8?B?L0U0Ty91YUhoYW81K0ZzRjV4c0Joa1NWTnNqMmNDd2xkamlDN2NYMDRZRWtW?=
 =?utf-8?B?RTZzTU1XaGZGWkNhb0hYanpramMzMHZnc0VZdndMUVJ6ZkpPSVA1dVFoNUN3?=
 =?utf-8?B?NWk4ZzVwUHBleUcyYm9wVVNFc01BR0dpK2JsODl4eDRIS2RYeHNhWjQwWjZD?=
 =?utf-8?B?bHJQTEZWOHo3a29SREp3SVJXd0tJYnBEYWViK3pDQXlCaVhvLzlJMTZINWlX?=
 =?utf-8?B?STdxVXBUQ3M1N3EzdC9TcThSY3dyVzhhM0NpNUVlQTV5WG1XYXdhNHZJakJN?=
 =?utf-8?B?aEVsSGduUjg0dnlNWUV6YU83YXQ5RnMrNWsvL3RndVNUQ3IwNFE1UVB4VmIx?=
 =?utf-8?B?NStYV2Jxc3pyRnpRYVh0MUxLL3FLR1ppTktyMURvNTRibE5RdjVSYkcxOSto?=
 =?utf-8?B?WlJ4dWVwYzg2THJOa2tVNi9jY3F1UG4wWVI5OHZUM0wzbENlSWlENHlTWDRy?=
 =?utf-8?B?U0RtOTFaV0ordUZ4Zkk4OXQ2azZvR3pDdTI1Q29BNEZIdFZqSitvSmRJaWZR?=
 =?utf-8?B?bGhLcnUzS0lVSzUwSW1teEpkVk9Va25sbWpqRVlnbUlYeGJYUWIxUjl1M3ox?=
 =?utf-8?B?ZUFWY1o4Z0cvUS81dSswYldDTjNBWVFVeUlmazVXQlNlRi8wdUsrMUdHZ2d0?=
 =?utf-8?B?TkdqbjY3bXJlV2pweTVaV2s3dmJqOUhIRkZuSXdaMG9PQytpV0NTVGRtTm13?=
 =?utf-8?B?UGlDREZGcDFBS0x1NGhURGQ4UU16ck0xQUlReEpXbmFucFZLeFYyb09GSERn?=
 =?utf-8?B?UWt1MDE3RWNpaDJWM3pUVnFWOFdMTE5ZU0pPdjZiWk9nRHZJYXFtMm9SZ1ZT?=
 =?utf-8?B?RlFHN1orYlhyTVlzUjZRaFpsbTFQNkcxMTNiZDh5REVFQy9TRm5VT1c1NDUy?=
 =?utf-8?B?azM4WG51aElxZllTZFJwRzMxRGlIQ0xzL0JLUFViNnFsTGNXSnljaUVNTG5y?=
 =?utf-8?B?NGJzRlBoSERtTTNjY1lHaTdRNmJsYnZHVTlkTEJBa0lPb2FmR2lldjdtQjdm?=
 =?utf-8?B?M0EwTnRWNy9MOHhTS0ZGcHo0YzlRKzVVVWZFVEFyWjZYVERlUDIwdUlDWmxC?=
 =?utf-8?B?dG9KTGoyb0JFcE9laVpUMzhvOHJjWVIydElpNVlmdS9SVGM5QmVwbHB4aUpq?=
 =?utf-8?B?eGpZajZBc0NPZEtPQnV2SVg2S09GT0xHTDBGMnNmbkhVV1RLeVJFQ1h3NUUw?=
 =?utf-8?B?Umh1WmtQRWJUb3EzVCtDOElPY3k4UFQvODZJRU5jekhFY0FocUpvT3ROQmlv?=
 =?utf-8?B?bU1ReTBHSUgzamtrU21zRTBnRzFQUG9RZGNQV1NlSVBZUnczQUVUODlDR0Fa?=
 =?utf-8?B?Y3M0RnBOT0RMRTJTRDdIVVZZY2VGd3hzMHZaTW1PWEFId2VDbGRRbkdkemxk?=
 =?utf-8?B?K2gzbFhwQ0Q5REJBM3YrSlUxVDl6UGhsMFdjcFhPMDBzR09QMUtXTFhCOEtH?=
 =?utf-8?B?ZnV4Vy9NUXFzMzBOVzQ1UXkzMUw4VDBVeld0MXRSS1NVRVFVcHF2ZmVXTHQ5?=
 =?utf-8?B?dWtsdFQvOHpBYVdMTy9yeDhPMUFQc2RBSEFjUXN0ejdiZWswWVpWMmdSV2dY?=
 =?utf-8?B?c0NkNm1NK2E0SnBVMTlXK3dYQmcxcTJ1OXprOEkvSDFVSzJZd0NReG5JMi9t?=
 =?utf-8?B?a01zVkZCalJQK0tKa1NQWEFYYUlIKzlmYTBHVVBTMnArZUl1WEpHUjBjTmRo?=
 =?utf-8?B?WDRHKzVFSWxqaXJTT3BlenNXajNYTFFZN0VyVHVaN0FLdTZiNTdiMEZiQ044?=
 =?utf-8?B?aFVJTU1RV0dSWWp2VC93L3ZrRUo5cmRrWVpSVjMrVXEzblJIVFV3QllVRW0z?=
 =?utf-8?B?L2luajQ5VC9rVG0wdTlDenZDQStxbUtWZ1RRc1NSeldGS2JKLzdyWVlmUUVj?=
 =?utf-8?B?NnR6akVmTDFrWWsxK1dGZ3ZUc0tETXdmVGswcW94amhlWFJlTFZ4WXZadXBR?=
 =?utf-8?B?a1JYc3VvUDdjazZKNGtBcGZQZHAwUlBISmtrQStCdzdlVHE3L0pvS0pkd2w2?=
 =?utf-8?B?UVNhbnlzZDF6ejdpYUx3a1ZXVlF4eGJtZWRUVmQwMUJTWDdhdnpkZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeec137e-2ff1-4423-bf62-08da3a89fd03
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2022 17:55:55.8345 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nheQj5YSH6QV7yTL/7vNpjQYxiOC5UzX4puoeqUwTjEQFiR0ZHwOo91vm04us8PNoDqoLQwMTVoaCplAMTJqHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2439
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
Cc: "mwen@igalia.com" <mwen@igalia.com>,
 "contact@emersion.fr" <contact@emersion.fr>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "markyacoub@chromium.org" <markyacoub@chromium.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


<snip>

> 
> On 2022-05-19 16:42, Harry Wentland wrote:
>>
>>
>> On 2022-05-13 16:22, Sung Joon Kim wrote:
>>> Issue fixed: Overlay plane alpha channel blending is incorrect
>>>
>>> Issue tracker: https://gitlab.freedesktop.org/drm/amd/-/issues/1769
>>>
>>> According to the KMS man page, there is a "Coverage" alpha blend mode
>>> that assumes the pixel color values have NOT been pre-multiplied and
>>> will be done when the actual blending to the background color values
>>> happens.
>>>
>>> Previously, this mode hasn't been enabled in our driver and it was
>>> assumed that all normal overlay planes are pre-multiplied by default.
>>>
>>> When a 3rd party app is used to input a image in a specific format,
>>> e.g. PNG, as a source of a overlay plane to blend with the background
>>> primary plane, the pixel color values are not pre-multiplied. So by
>>> adding "Coverage" blend mode, our driver will support those cases.
>>>
>>> Reference:
>>> https://dri.freedesktop.org/docs/drm/gpu/drm-kms.html#plane-compositi
>>> on-properties
>>>
>>> Adding Coverage support also enables IGT kms_plane_alpha_blend
>>> Coverage subtests:
>>> 1. coverage-7efc
>>> 2. coverage-vs-premult-vs-constant
>>>
>>> Signed-off-by: Sung Joon Kim <Sungjoon.Kim@amd.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

<snip>

>>> @@ -2564,14 +2573,6 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>>>      else
>>>              blnd_cfg.global_alpha = 0xff;
>>>
>>> -    /* DCN1.0 has output CM before MPC which seems to screw with
>>> -     * pre-multiplied alpha.
>>> -     */
>>> -    blnd_cfg.pre_multiplied_alpha = is_rgb_cspace(
>>> -                    pipe_ctx->stream->output_color_space)
>>> -                                    && per_pixel_alpha;
>>> -
>>
>> Could this break color management use-cases on DCN1.x for Windows?
>> Dmytro Laktyushkin added this code 5 years ago. Maybe check with him.
>>
>> Overall I like this patch but let's see if we can confirm that this
>> won't break DCN1.x on Windows.
>>
>> See commit ad32734699da4dd185405637459bf915a4f4cff6.
>>
>> Harry
> 
> I spoke with Dmytro and he is okay with the change
> 

Thanks for checking.

Harry

> Joon
>>
>>> -
>>>      /*
>>>       * TODO: remove hack
>>>       * Note: currently there is a bug in init_hw such that diff --git
>>> a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>>> b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>>> index e1f87bd72e4a..c117830b8b9d 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>>> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
>>> @@ -2346,12 +2346,16 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>>>      blnd_cfg.overlap_only = false;
>>>      blnd_cfg.global_gain = 0xff;
>>>
>>> -    if (per_pixel_alpha && pipe_ctx->plane_state->global_alpha) {
>>> -            blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_GLOBAL_GAIN;
>>> -            blnd_cfg.global_gain = pipe_ctx->plane_state->global_alpha_value;
>>> -    } else if (per_pixel_alpha) {
>>> -            blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
>>> +    if (per_pixel_alpha) {
>>> +            blnd_cfg.pre_multiplied_alpha = pipe_ctx->plane_state->pre_multiplied_alpha;
>>> +            if (pipe_ctx->plane_state->global_alpha) {
>>> +                    blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA_COMBINED_GLOBAL_GAIN;
>>> +                    blnd_cfg.global_gain = pipe_ctx->plane_state->global_alpha_value;
>>> +            } else {
>>> +                    blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
>>> +            }
>>>      } else {
>>> +            blnd_cfg.pre_multiplied_alpha = false;
>>>              blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_GLOBAL_ALPHA;
>>>      }
>>>
>>> @@ -2365,7 +2369,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
>>>      blnd_cfg.top_gain = 0x1f000;
>>>      blnd_cfg.bottom_inside_gain = 0x1f000;
>>>      blnd_cfg.bottom_outside_gain = 0x1f000;
>>> -    blnd_cfg.pre_multiplied_alpha = per_pixel_alpha;
>>> +
>>>      if (pipe_ctx->plane_state->format
>>>                      == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA)
>>>              blnd_cfg.pre_multiplied_alpha = false;
>>
> 

