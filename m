Return-Path: <SRS0=vXfK=NL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 016BDC4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 06:38:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE4746103C
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Aug 2021 06:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE4746103C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44E816EA06;
	Fri, 20 Aug 2021 06:38:22 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2066.outbound.protection.outlook.com [40.107.96.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17516EA06
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Aug 2021 06:38:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBEIQnGl1wk/QmeP8VJdj6Tf+mkTJ7qvs7NdkrNQjK9ELJW/Q6PPddm3SijXzAzRsCpklH3H6+PsMQx9q4vAbpUCprPAST/UgYaYkjsI4IDnnzdEBzIcw6f6pR2jjBzJAF+8kq6bYPH2XYkEYXoH2rk4iHyILRQyzUApWTZnynyq6oSCpRcb1k4hAPTkl1sA5RAE6XAvvJQiM8v9m7kgJ06vrF2V7NwhvnIQNzu7PGG3vmn6icRHRhZzkSIYCjqViNl1ceEOcQu2+k78YJN3sM0eEgfZFQUYktnGkievC36zIuHJKsH92DMkmcsHTAct0gR52aXCQXx+CNt1zt6nVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4iAN4ned/bzV42loXLinZlyctN2rt/8K90HPLc84W8=;
 b=QYNXXBohOiqNRGo+HgDjpXzeH1ZoGptM0Y4TfIUWhh40TsbJukTKIPy/YnpLeGULtKqgfU8OJhYr0NoAQcmi27ipKNwsZmsKToPbL69h8SvFFOGS5s/HUd8r+n2HrtnUm/78lll5XUr1qRsHFsUr95gSgMbFxu71j0xgjihhVxfxwuDUZBAkNG7hiTtrPg3hh9wFfei2hWQHL/GJqtQHXtPw/TYqtoozMiDYCfOfEQ5BUleQGDTmfx1MiomAMMV29r+hSzFiiPeCh+5XGXGGs3JutbSFrrPan6K0/tMDWKZu51G7tv8TE4PWlJuJ2N54XS5gFtOFFkvW6C8rxdpgkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I4iAN4ned/bzV42loXLinZlyctN2rt/8K90HPLc84W8=;
 b=nFgRLXWBPQNYYO+oOtix4fhvRFUnYBV8F5PFrxLjjdd/1Wn1S2N1Ol8+ycsNDXhWPtBXbcUcfg4kIsPwcCzoZRRSKaGYn1nxT8/YWhvnAxko+YCoP6KKx3R7OGSoKvjsS1rUJlJ3AKRKMWkNcrJMSBGrB1C9Npii2SNyH2AmBwE=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB4657.namprd12.prod.outlook.com (2603:10b6:207:1a::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Fri, 20 Aug
 2021 06:38:18 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::dce2:96e5:aba2:66fe%6]) with mapi id 15.20.4415.024; Fri, 20 Aug 2021
 06:38:18 +0000
Subject: Re: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
To: "Sharma, Shashank" <shashank.sharma@amd.com>, amd-gfx@lists.freedesktop.org
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <1d64e5d6-8981-3bc2-21dd-b8eaf7a9333e@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <b71ef8fd-55f7-068b-db64-1aa727cde211@amd.com>
Date: Fri, 20 Aug 2021 08:38:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <1d64e5d6-8981-3bc2-21dd-b8eaf7a9333e@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM8P191CA0014.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::19) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.178.21] (91.14.161.181) by
 AM8P191CA0014.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4436.19 via Frontend Transport; Fri, 20 Aug 2021 06:38:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44eb2582-43de-46dc-44dd-08d963a5185e
X-MS-TrafficTypeDiagnostic: BL0PR12MB4657:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB465768F69F49EB49DBD7A96083C19@BL0PR12MB4657.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DJFZtf6sJ7nO3O1yQKX8Co+uaVz1Ph19gTsKbj/YCgXuwYaldQrepEiNexiW6CsngeOKW85qKospY6mswIbJfy5Tktx/w4jEMySTQ2vtKuTBEkDpY+L3L0784JegVeNASecbjka+y+Ypkf62IpQsP3MTMkMjMx92zKLJnBt0odI2cSI2rIftPCS7fg73PRkn3rYZR2IZZs10LHSU9GJXj3kNcYrpx6YF6ekExLBiDudvL5uczvCT20mq9TLp9f3g+L28AO9DDZR9tNRUZ7fkPDnHWmPjJa8uPYJNVVUg0Jam2mMasLgF2cavRjf6OSHX/Z/9erFVo961x08dDiKKc8LYj7GmB1MtVkMw9ly2k/u0ctum9u4Gm70r25gPgINe1gm825Ye4MsmPE+fcPzmh95Cc3QxOCERFmKzMF6g+uvRZM3gm9Lh0cHGZ5fDFYD2LUmRxsEVGkqMJIERXkuMg6gU8+Au9PAAyhkvISGkpvCvbBv8AlpEzsjHWqmOQGNUjK9RIJAwqY3tkshpxXZEcsE/HJudfH+T2dm+QjeWoQ40MkLuqIbQODGwJk+aVWp5M2iJv52CM3zRJC076wQgMK6B/P5B/pXApSvuWI5GNtyph3SrVmJUWZSRa0ioPTuz8zFBXnM6DMkR7CC5TogFgZvSmyMbPHd3kPi7jstlZYcVojavu4mjOWMND7HKzGZxyAOWq29eJ+Fisup1rNNZPShiwIkSPYc2V6Vgux4aYDxUzFclR9LUg12CZ3DL4fVCNSpa65AAL1scLZWF0FaJfU4QFyHLUSEzkNlNJ4dxsJJ+SGc9MlTZeNFkvDoImHC2
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(8676002)(66476007)(53546011)(956004)(31696002)(66556008)(38100700002)(6486002)(66574015)(66946007)(2616005)(86362001)(6666004)(36756003)(5660300002)(4326008)(8936002)(186003)(966005)(508600001)(26005)(16576012)(31686004)(2906002)(83380400001)(316002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjYyZDNiV2FDZWd4VnQxMk9IU3Nkd0I5SzJEdHAxUG9WVURScUFxK0RIZk9K?=
 =?utf-8?B?WEtvaUN5bXpESGM2ZlpURjFsdDJWVnZCZEtveGlaeTE3NDRzQklCUjBqSUZr?=
 =?utf-8?B?ZGNlM2xFQXJPOGlVbngvcmlQZnFsR0x2YmgxMllwZUNMSElqMFhUQklOeUFh?=
 =?utf-8?B?VUpQYkJtZjJSYkhqZlJjQlFJQWYrVTEzMXVNY2hHVFVheFhwTFpyNXdrdzE2?=
 =?utf-8?B?bE1hOEZJNUpxMEtjc3VqNXpmWVJDVnNlQXNXa0lUWHMxNjNyQUtsWmV5VnpB?=
 =?utf-8?B?M0ZrMzhGeWlYamJIbDRMU3RoMmlHLzR5dnZlSHNNelhsN1RuRzJaTDR5eUky?=
 =?utf-8?B?QXF3YWFKMm0vSVBSSWVIbHlaUDFHZStHR3hxcUhkWk9vT0N2Unk5ODFOQ0JM?=
 =?utf-8?B?VGtGcnJyT1IxaE5wSjc3ajhCTzFSQzlCait1VndMUGRHZUd0ZW9uKzlVN1Fj?=
 =?utf-8?B?VzlXUHpCbllNK25naHcrMFR4OVZtNkN4MmVIVDNCUzFOOWUyQXhreGNtY0w4?=
 =?utf-8?B?ekRPeVdyK045VnZTckc3c3ljVE1DYUhmMnhTdG5iVktiSUt2RHV3N0JMZGNn?=
 =?utf-8?B?eVRtTCtmVm1SbEVBZ1NoTDhPbVIwMFNUb1pVUjM0cDJmaFBYQVBubVg2UUc3?=
 =?utf-8?B?MnJYSEV6Ly8wa2tJZG00cEoyRktWeDYvNEMyUGZSY05OalRFOXIwZXZFYXR2?=
 =?utf-8?B?WTE2NmR2UEtibTgrRXFaZ0FmUjcrMklMNTRzY0l6STNFNU9SQ0g5cmdPaG5x?=
 =?utf-8?B?OTE0VGwyRFJjZjRqbmFLYXZoeUJnRnBONVJRaWdwSjR1SFNKeTdQaUZTOHhK?=
 =?utf-8?B?Ynp5Um1EU3BtYTEvcHhHM1hDUXViQ3lSME1OSHQ5eU93clNMOFE2ZUZiQmxR?=
 =?utf-8?B?a0NWODhRYzJVV3dvSWhsb1VMQ3Jtd0lnTjVRL3FpM0JvMkl1UU5FYzdGaks0?=
 =?utf-8?B?WC9iS21ialVJc1E4UzZodUN6NU9LT3R6SE1CMzh0Y25RdDhFOFhtMlBLZUNU?=
 =?utf-8?B?akt3K0IraTJ4dnlicjNmSjVMZ0tkaHVsSHUvUEUxeHRiUFFDQndEYy9aaFpw?=
 =?utf-8?B?TmR0TDFvd2drczFnN3VUdWJKQzVpcWljMmE5d3ZDVm9EVXlWcmQ3Qldya0tv?=
 =?utf-8?B?eDgwTXlnN2VUSTBZSWxhUllLWDZERHBMV0R2ZStlT2dGblBXQUVEd2lVZDVE?=
 =?utf-8?B?N0g2ekphRTh3ZTgvTWY2eExtaEdGeDl6UDV1YXc4QnFrVlFSdnRaQVkvcmpO?=
 =?utf-8?B?VXY1bkVyS0FnNjVFMXY1NWJqaDZ6Tyt6WW8rNEkwekZRVUNmREdnOUl6UWxY?=
 =?utf-8?B?ZHA4QTFYUXBCYUM1QlNUUkVLOE5IL0xHM2t6aUh3am43aGp2ck1RaHhqVkdv?=
 =?utf-8?B?WHhncTdjMU5zeVo2YWk4VjMwVHQ1MU9GakV3M1NoRkJYT2Uwa042VTI2Z2ty?=
 =?utf-8?B?N1VUNXJRTzRpSlVUM3hlODU3dHRzbzZjRVArTzlDVlBHSG9kejJPOEZ4YTVE?=
 =?utf-8?B?SFdUdDJBckREMCsyUDJENDBEdVFSYjlnY1dPbWJ6R09USzFOd1g2enZScE1N?=
 =?utf-8?B?TEdnVDhtUU5EWU1iQnhDRXdLTlQ2amZnM05UekJNWXJKamtUMkZ5VmdNOUNl?=
 =?utf-8?B?U3daSDhxdzcxRU5IRTY5OCtNclhXelBNNEZTQU4yUkc0UTc3RjNwOU5JQzJR?=
 =?utf-8?B?TXZrd3VZTkF6T2JzUmQ2MlZRK2hHRTZXQjEzWnc2aG9RU0xLamoxck1rZDBm?=
 =?utf-8?Q?UStuLtjst5VRLlixjbw6K2CgXwmtzRAVO+6FoAe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44eb2582-43de-46dc-44dd-08d963a5185e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2021 06:38:18.7116 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaxryVY3huW9U101Mu+x0715yqdTPmuehmXn60KPrliPW5p5ZLecViAOoUvTdeKN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4657
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Sounds like a good idea to me, but I would limit this generally or at 
least for the whole generation and not just one particular chipset.

Regards,
Christian.

Am 20.08.21 um 08:05 schrieb Sharma, Shashank:
> From 4841e5ba60e33ff798bde6cb69fbd7e137b6db9c Mon Sep 17 00:00:00 2001
> From: Shashank Sharma <shashank.sharma@amd.com>
> Date: Fri, 20 Aug 2021 10:20:02 +0530
> Subject: [PATCH v2] drm/amdgpu/OLAND: clip the ref divider max value
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> This patch limits the ref_div_max value to 100, during the
> calculation of PLL feedback reference divider. With current
> value (128), the produced fb_ref_div value generates unstable
> output at particular frequencies. Radeon driver limits this
> value at 100.
>
> On Oland, when we try to setup mode 2048x1280@60 (a bit weird,
> I know), it demands a clock of 221270 Khz. It's been observed
> that the PLL calculations using values 128 and 100 are vastly
> different, and look like this:
>
> +------------------------------------------+
> |Parameter    |AMDGPU        |Radeon       |
> |             |              |             |
> +-------------+----------------------------+
> |Clock feedback              |             |
> |divider max  |  128         |   100       |
> |cap value    |              |             |
> |             |              |             |
> |             |              |             |
> +------------------------------------------+
> |ref_div_max  |              |             |
> |             |  42          |  20         |
> |             |              |             |
> |             |              |             |
> +------------------------------------------+
> |ref_div      |  42          |  20         |
> |             |              |             |
> +------------------------------------------+
> |fb_div       |  10326       |  8195       |
> +------------------------------------------+
> |fb_div       |  1024        |  163        |
> +------------------------------------------+
> |fb_dev_p     |  4           |  9          |
> |frac fb_de^_p|              |             |
> +----------------------------+-------------+
>
> With ref_div_max value clipped at 100, AMDGPU driver can also
> drive videmode 2048x1280@60 (221Mhz) and produce proper output
> without any blanking and distortion on the screen.
>
> PS: This value was changed from 128 to 100 in Radeon driver also, here:
> https://github.com/freedesktop/drm-tip/commit/4b21ce1b4b5d262e7d4656b8ececc891fc3cb806 
>
>
> V1:
> Got acks from:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> Acked-by: Christian König <christian.koenig@amd.com>
>
> V2:
> - Restricting the changes only for OLAND, just to avoid any regression
>   for other cards.
> - Changed unsigned -> unsigned int to make checkpatch quiet.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Eddy Qin <Eddy.Qin@amd.com>
> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c    | 20 +++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h    |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/atombios_crtc.c |  2 +-
>  3 files changed, 16 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> index f2e20666c9c1..6d04c1d25bfb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.c
> @@ -80,12 +80,17 @@ static void amdgpu_pll_reduce_ratio(unsigned *nom, 
> unsigned *den,
>   * Calculate feedback and reference divider for a given post divider. 
> Makes
>   * sure we stay within the limits.
>   */
> -static void amdgpu_pll_get_fb_ref_div(unsigned nom, unsigned den, 
> unsigned post_div,
> -                      unsigned fb_div_max, unsigned ref_div_max,
> -                      unsigned *fb_div, unsigned *ref_div)
> +static void amdgpu_pll_get_fb_ref_div(struct amdgpu_device *adev, 
> unsigned int nom,
> +                      unsigned int den, unsigned int post_div,
> +                      unsigned int fb_div_max, unsigned int ref_div_max,
> +                      unsigned int *fb_div, unsigned int *ref_div)
>  {
> +
>      /* limit reference * post divider to a maximum */
> -    ref_div_max = min(128 / post_div, ref_div_max);
> +    if (adev->asic_type == CHIP_OLAND)
> +        ref_div_max = min(100 / post_div, ref_div_max);
> +    else
> +        ref_div_max = min(128 / post_div, ref_div_max);
>
>      /* get matching reference and feedback divider */
>      *ref_div = min(max(DIV_ROUND_CLOSEST(den, post_div), 1u), 
> ref_div_max);
> @@ -112,7 +117,8 @@ static void amdgpu_pll_get_fb_ref_div(unsigned 
> nom, unsigned den, unsigned post_
>   * Try to calculate the PLL parameters to generate the given frequency:
>   * dot_clock = (ref_freq * feedback_div) / (ref_div * post_div)
>   */
> -void amdgpu_pll_compute(struct amdgpu_pll *pll,
> +void amdgpu_pll_compute(struct amdgpu_device *adev,
> +            struct amdgpu_pll *pll,
>              u32 freq,
>              u32 *dot_clock_p,
>              u32 *fb_div_p,
> @@ -199,7 +205,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
>
>      for (post_div = post_div_min; post_div <= post_div_max; 
> ++post_div) {
>          unsigned diff;
> -        amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max,
> +        amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max,
>                        ref_div_max, &fb_div, &ref_div);
>          diff = abs(target_clock - (pll->reference_freq * fb_div) /
>              (ref_div * post_div));
> @@ -214,7 +220,7 @@ void amdgpu_pll_compute(struct amdgpu_pll *pll,
>      post_div = post_div_best;
>
>      /* get the feedback and reference divider for the optimal value */
> -    amdgpu_pll_get_fb_ref_div(nom, den, post_div, fb_div_max, 
> ref_div_max,
> +    amdgpu_pll_get_fb_ref_div(adev, nom, den, post_div, fb_div_max, 
> ref_div_max,
>                    &fb_div, &ref_div);
>
>      /* reduce the numbers to a simpler ratio once more */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> index db6136f68b82..44a583d6c9b4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pll.h
> @@ -24,7 +24,8 @@
>  #ifndef __AMDGPU_PLL_H__
>  #define __AMDGPU_PLL_H__
>
> -void amdgpu_pll_compute(struct amdgpu_pll *pll,
> +void amdgpu_pll_compute(struct amdgpu_device *adev,
> +             struct amdgpu_pll *pll,
>               u32 freq,
>               u32 *dot_clock_p,
>               u32 *fb_div_p,
> diff --git a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c 
> b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> index 159a2a4385a1..afad094f84c2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/atombios_crtc.c
> @@ -851,7 +851,7 @@ void amdgpu_atombios_crtc_set_pll(struct drm_crtc 
> *crtc, struct drm_display_mode
>      pll->reference_div = amdgpu_crtc->pll_reference_div;
>      pll->post_div = amdgpu_crtc->pll_post_div;
>
> -    amdgpu_pll_compute(pll, amdgpu_crtc->adjusted_clock, &pll_clock,
> +    amdgpu_pll_compute(adev, pll, amdgpu_crtc->adjusted_clock, 
> &pll_clock,
>                  &fb_div, &frac_fb_div, &ref_div, &post_div);
>
>      amdgpu_atombios_crtc_program_ss(adev, ATOM_DISABLE, 
> amdgpu_crtc->pll_id,

