Return-Path: <SRS0=QW4G=K4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4517AC4708F
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 20:58:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE1B9613E7
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Jun 2021 20:58:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE1B9613E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 834A76EE73;
	Wed,  2 Jun 2021 20:58:32 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A88FA6EE73
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Jun 2021 20:58:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EDKaqpNa2wVlv4hsYAOnJzdKwHzih32+QakfrgyMHPi2CN6sGVVa91ekhxmhcPOrYPnqwMXyVZOSC6xqEj4INcrEI2YIE6Ik0FIxZZtYgG6awxBfJpF+7NKl95ItcooQC0kk2BsCKYWxwRQi1GxHCBY7+VIEQhCGWZQ/0EmTpeNDMaQy9m8TaFjyBOCDCt+xx/xlIw3+pyxNCon277DvgIiR/c4viGfVyI7FO3XtUVOuyx03JaJ5qgwMIm+SJKFuxQR1obbz4hA3byU65RVTNzyd4tmWpyGXwsOaPOjd60PHZwtW4HcTDitfEvDNrUmYnuhVc0VuOX3iSziLX17xrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19qtRYocXEp5dE5jwqLryBQtLxCaW24jwp4BSoOc15Q=;
 b=CxBKRjznUuJQSt5nkfH2v0EgegNWdEzBplkhQUHr1YAD9RScgjx3xhj+jDy+1+LnHbsKqSjdFaXGDAQePE76+d4ipTHJJ6s9yqwSDNFKRXjb7Q46FfMUxOrY81iPfch47AQWYF3YnVDMSOwgsOWm85aMFstspKT0K8p4vbMDCfKCq342gR/egR2OfOEXctnJ1xb7dj6qi2j0mG6CK3K0hjDnVOpc5QGQpjv3FjFkikQJQWfiqLCsWLMK3HIqx6Ri0RgNJIMn8t0VFGAVtLveKboN/ezalTQCcqeWncFRZW4/FibxHpysbKLYr45TMi0GDaya+VWkZKmxdj2r1W76ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19qtRYocXEp5dE5jwqLryBQtLxCaW24jwp4BSoOc15Q=;
 b=JF0zXFiV2UJ03sY3oNFAOH1PumJh0Nn5mmUGrBCX99S5CqLbcFf49JFMVawAU5zx/C5VMnLHl7t4ZdRmZ6+rN57ydDybUJXDM58vhPz/F64ZdiTbiwHQhPWf7wNBjayKXwL76EoUgQgvwNQ3wVVs1s24q3u2o9K4BAJBheaNrFI=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5410.namprd12.prod.outlook.com (2603:10b6:5:35b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 2 Jun
 2021 20:58:27 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::f455:b0b4:439:2753%3]) with mapi id 15.20.4173.030; Wed, 2 Jun 2021
 20:58:27 +0000
Subject: Re: [PATCH] drm/amd/display: Keep linebuffer pixel depth at 30bpp for
 DCE-11.0.
To: Mario Kleiner <mario.kleiner.de@gmail.com>, amd-gfx@lists.freedesktop.org
References: <20210602204556.17324-1-mario.kleiner.de@gmail.com>
From: Harry Wentland <harry.wentland@amd.com>
Message-ID: <887b4f3a-e609-e288-4c61-e9b12527fe4c@amd.com>
Date: Wed, 2 Jun 2021 16:58:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
In-Reply-To: <20210602204556.17324-1-mario.kleiner.de@gmail.com>
Content-Language: en-US
X-Originating-IP: [165.204.84.11]
X-ClientProxiedBy: BN6PR20CA0061.namprd20.prod.outlook.com
 (2603:10b6:404:151::23) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.254.46.246] (165.204.84.11) by
 BN6PR20CA0061.namprd20.prod.outlook.com (2603:10b6:404:151::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.15 via Frontend
 Transport; Wed, 2 Jun 2021 20:58:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6ae428a-4aab-4e50-8620-08d926092b16
X-MS-TrafficTypeDiagnostic: CO6PR12MB5410:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54101E7B21167F6457988F508C3D9@CO6PR12MB5410.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VkxN4c9S5Wel5Z2jL0lAoNmBudaV5MK+LCjY9LkpPsM+iv2x2vhOTAo5uZHf72yim7JXdkf+KOFz0P/rnDO1KiZfAIOoQm+A6sM0JN1kj5KgIsOGAKnunSwYkdiDzk4FsWA7A8m1xYGlLTbxVK6AIxnQPn8fju6aBhsuEspz4U4xhuLyA9iiygcSCA9wh2ygH5TztjUMkBBvAm1xyncZ+lY3tYFnIBz0sUarzd4W9uHw6MkCFPZM51oGSHEsmxCAdlCqrtjg6hDkSqsRfiDgM3YY630MVsxNi7a+XchrZBNuZwKbSqarC5u8WScvHuYynWJw86h9GLG4OYjZz7KkwsjU8ukocMHF9o2jkLRFLOEU5bKSp4hw7yiXQx5mePREHwgVQ9eTw3bMC1DYl8zoTDnDciuP8ZcaNklyO0V/mYHXg08cwB+S2uiaDZ7BiXkVm5ie30ly+ib2IAhQUIbYANP6/lxnP+shnsWBZ1BjIB0ZV0bkeAMZ49VbWSMzQOgR5y+ON1jL4kfWMw4kTdvrJXWlPZUyZEC94dLGPu+xZRQpfpCcHrKlGgfuDL2ayj32EF4rb0ZZnDSnAPiAoPen1ozQ501G1kfDL6WyxD2Fhaege1jOM5teJPYGjBHadB8NU+mtKRoDwbNTi2zyJg72vPraLAoMvZ2FmGQZe89YEeNwjTbiZ1en4BtnLcKi+kd6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(346002)(366004)(39850400004)(396003)(316002)(6666004)(36756003)(956004)(38100700002)(8676002)(186003)(478600001)(8936002)(53546011)(16576012)(44832011)(86362001)(83380400001)(31696002)(5660300002)(66946007)(31686004)(66556008)(2906002)(26005)(6486002)(66476007)(2616005)(16526019)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YldORkc0ek1GdGh1bU9lU0t6MnhsU1NkdHlISDRrQTREUXA0OUFsbVlmb0tT?=
 =?utf-8?B?OWt5YVNvVzZrUnBTdHFhZHU3S2RIRGpqUjBSZTh4MkV2SjBleUYwSUx4UHRy?=
 =?utf-8?B?QjhxMDY1M1Z5cFFRbVA0dXo3SFl0RDNIT3lkNTFkWG5sZlk4Wmo5cjNtRlBz?=
 =?utf-8?B?eXpWbkdwd1YwckdrcjhXbTA4RVpDVHk0Y2JVOHBVTDF6WUp5RTZxTHlUbzJn?=
 =?utf-8?B?R2w3N09ZdUNrOUtjem5JaHR2cDY4bWprL1ZLdHNYTHRROHdYTUNaU09selZr?=
 =?utf-8?B?dERDeEo5VUJTNk0xNFdVWmdzNU5pdWx3cXgwdTR1Z0JUVWxpOUdPVHY3c0R4?=
 =?utf-8?B?YXRUNjk3U01mRmo4QWdBbVBUZzhIb1MybEJoM0dlWDJXVU1ZUXM0Z2ZVUVRo?=
 =?utf-8?B?ZmhaYmZPQ0o5MXk3eDVVV1RZaTdCaUpTYVF5Njd0UnRobHc4RkU2eG43YTNl?=
 =?utf-8?B?djVYYnZ3Q1JjZEJiZGR5NzFzSFIyeTkvTEtuZHR5VXdBUjZjSXZjdmJwVlRC?=
 =?utf-8?B?Tjg2U3R2ZlNlQlBGYXZENmNjU285aWNhYnBzTUZEZERRVHlYckoxSWVTZVNz?=
 =?utf-8?B?OWdFOFIwYnZXNVZRKzFCMmlsbUsza3ZkR1hYeFhhYjFXRzNDazhVZ3piL2Vo?=
 =?utf-8?B?d0pLelRBMlZBU2t0SnF2dmYvSWdpTE5tNGF5S20xU1FYSHlVRG9BNzVDeTlV?=
 =?utf-8?B?Z0VKN1QxY1dzdkF4ZG5NbE5ZeWQ1eEczN0NFWk1RdVhydCtQR3Z5c3pSTjZ6?=
 =?utf-8?B?QzNtMG5mNlUxTjRFTy9kYXdmSGdiVE1GbDlsWE5HSy9xSENkNlRXQjRZbFhE?=
 =?utf-8?B?eitNRUlSSTJYVFEzV3JMdDJCWWEwMDFIRUNXbE1wWUZld2RaU2NRdTAwTnRo?=
 =?utf-8?B?cDhlRWJCUmFKRXA4ZkNseFY0ek9wQ1JGclhhYS9GVENpaW9PWEdGRUpWWTR4?=
 =?utf-8?B?enlmU2E1TndxWE9Hd1NOTHlWVlhWMGY0cVFhUE5hR29OYVdaMEJ4cjZIWXEz?=
 =?utf-8?B?SzlhYVdVZWQvMXdCemZuSjBSc3BuZzNmWkNjQjhoVi8yV20zazZ2OE1McTgr?=
 =?utf-8?B?VngrSDRSczBuLytST1g5c3VITXJpYkhlNnhiQ3dvbU12aVFBUWRjSENJd0pN?=
 =?utf-8?B?UkQrTFB1aGZpU3BOTWU0ZHByTWNLUE50YzFMdWdSSit3OWFNV1dvZjFzWG9Y?=
 =?utf-8?B?enk5TjJ5UmNIMFBYRlNseE1NbXZKVUE1QVBXYnRxRElKS0pUZmJZWmdaT1Fq?=
 =?utf-8?B?c3NEYWZvQTFnbG5qQlhLZ1hTQXFYS1crL0ZVQ3dNVHJFcXpqTitoUHgzOTRQ?=
 =?utf-8?B?ZGZKMGhNS0lGTDN3bzN5eUtXN3J4Tk5yK0RFUXloRDBGbVI5eW82THN4Rk0z?=
 =?utf-8?B?UFpVVlYyVndwa3E3M05QVmwyUHhRd3hmNnBHN3dOeWQvMEM3dHFNTytlVitR?=
 =?utf-8?B?QWNkcE5tMjJJVVNOazZLQzhTbGdNU3ZpSm9BaHk4ZVIzbkFaNXlvZkN1bjZi?=
 =?utf-8?B?cmpxUkM2ejI0QW14WGp6VXZBT1A0NUx4ZUk3bWdKTllPR0F3Y240OCs5QmNy?=
 =?utf-8?B?V3dyY3dGcTNDTzc5eElLY3Q5WGpYTTAvcHBkQkFMNzllTE4wazBxd04zaDlY?=
 =?utf-8?B?cDRhTGpYZDlOdmRhKzdXVkVoMDhPOTNSN3VBTVFqRnNVZ25FREhQb2p4ajg0?=
 =?utf-8?B?cU05ZnpINGNQM21MQkpseWNjV1hDU2RhZHFQKy9qbzQwN3FDUmtBT2NYVzJq?=
 =?utf-8?Q?TIc1InaeetW7zj6MSsapL0hsORuV2mpUHLLIW/g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ae428a-4aab-4e50-8620-08d926092b16
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2021 20:58:27.1273 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QYRlcxbL9C+ks7AeC71ynys/GL1C3d5xhVkvDl3L6HyelrF2NQkLGiQhhGfOlptxf6eVzFzGUPkRncyijpCyvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5410
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
Cc: Tom.StDenis@amd.com, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2021-06-02 4:45 p.m., Mario Kleiner wrote:
> Testing on AMD Carizzo with DCE-11.0 display engine showed that
> it doesn't like a 36 bpp linebuffer very much. The display just
> showed a solid green.
> 
> Testing on RavenRidge DCN-1.0, Polaris11 with DCE-11.2 and Kabini
> with DCE-8.3 did not expose any problems, so for now only revert
> to 30 bpp linebuffer depth on asics with DCE-11.0 display engine.
> 
> Reported-by: Tom StDenis <Tom.StDenis@amd.com>
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>

Curious now why Carrizo doesn't like a LB depth of 36bpp but 
this should fix the issue.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> index b2ee3cd77b4e..a4f1ae8930a4 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -1213,9 +1213,16 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
>  	 * on certain displays, such as the Sharp 4k. 36bpp is needed
>  	 * to support SURFACE_PIXEL_FORMAT_GRPH_ARGB16161616 and
>  	 * SURFACE_PIXEL_FORMAT_GRPH_ABGR16161616 with actual > 10 bpc
> -	 * precision on at least DCN display engines.
> +	 * precision on at least DCN display engines. However, at least
> +	 * Carrizo with DCE_VERSION_11_0 does not like 36 bpp lb depth,
> +	 * so use only 30 bpp on DCE_VERSION_11_0. Testing with DCE 11.2 and 8.3
> +	 * did not show such problems, so this seems to be the exception.
>  	 */
> -	pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
> +	if (plane_state->ctx->dce_version != DCE_VERSION_11_0)
> +		pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_36BPP;
> +	else
> +		pipe_ctx->plane_res.scl_data.lb_params.depth = LB_PIXEL_DEPTH_30BPP;
> +
>  	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = plane_state->per_pixel_alpha;
>  
>  	pipe_ctx->plane_res.scl_data.recout.x += timing->h_border_left;
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
