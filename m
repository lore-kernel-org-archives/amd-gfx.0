Return-Path: <SRS0=1d7w=FG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D980AC6369E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 21:33:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53BBD208FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Dec 2020 21:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53BBD208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0F5E6EADE;
	Wed,  2 Dec 2020 21:33:26 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3DC6EADE
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Dec 2020 21:33:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HGngqLHpcIAFX/mVvDdC+dXhJTfGN31riz+QQJsKzsSrLOoeu6plZ2cEFXJvEbFs4wdsdQBx1s/G138hJCnpdQP5xiC9tZktI6Pr9kUF94pq9JzzKSPKs+Qd02woCdROxM6J8Y7W4Kwa0bKSWnUtZFO7Ez6tWArYzZmIcR5VNtdvFVQjp5Abyo5q7LNJFW7O7hoq9yHtmGxzcHzukykN3O8xxNVcvAfVYz4UvM8HWGxhocVN8K9NgkYzxuflTNm8UbZJdxrcuRUjXQ/1nWNRJY5B/kcwpzpnHWLVNCqGOx+mEaceedWQRs9sCkWTkODLpB0JLl8Opdah/dWHC6oaEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMlCINYdzS12CwrudxkbbYXEz+blIpCY4CGbsILZ/uU=;
 b=UdFBVQSMxDFU3l6/+fbJPf+/int+/VxBsQSlAC3EOJ+T6Te9G1cUhXzMtqIBVMbSoadM1Oe2wTSUIc0Nw6lEQVfeApt7qrfV321RsKC7HzANH/7s6Zc43S6k0ycG6Mpaf4CwYOcisdpN4mnggS9dPzQg8KUCBCFRBg+gMN+ZIlAtPBKu8QS2RZGwCiLliExAu7u/w7WzhkPeZUzZLsVbPL/CyurooWzwU+XhR+B06c/xQmW6VcZ6+1yzWH8d8y3FutcJpibpQIW8GNRObPxRdkkv1+b7Rud12CmtUDCDHbkFpwd7q9a6Dc+FQHmQAiQ+bPvNeIoRb2tJm36I2Bso8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMlCINYdzS12CwrudxkbbYXEz+blIpCY4CGbsILZ/uU=;
 b=0VdWLdGf6SN3cda3u+a+hZVKwHKYNlReSr9kCuj67lAm4e2onSaOoN8dfaoX3wPLeGm9sC0KviWULu27jvf5VNMRaH0qHto6JDKMQRmpxj/Jc6YmXVo+l/UPeC64R62X1yte246NUEPzltT4oLTtJuwHnQOYnX/dq9iug1ZUNRk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BY5PR12MB3969.namprd12.prod.outlook.com (2603:10b6:a03:195::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Wed, 2 Dec
 2020 21:33:21 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e%7]) with mapi id 15.20.3589.032; Wed, 2 Dec 2020
 21:33:21 +0000
Subject: Re: [PATCH 2/2] drm/amd/display: add cursor pitch check
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
References: <7UvPE5okTSEaIRnrg3TJcnkyIBhPPRXCCuMa5wwC18@cp3-web-029.plabs.ch>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <e1f8e29f-138f-9e1d-0ba7-ce10059f87d0@amd.com>
Date: Wed, 2 Dec 2020 16:33:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <7UvPE5okTSEaIRnrg3TJcnkyIBhPPRXCCuMa5wwC18@cp3-web-029.plabs.ch>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: CH2PR18CA0034.namprd18.prod.outlook.com
 (2603:10b6:610:55::14) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 CH2PR18CA0034.namprd18.prod.outlook.com (2603:10b6:610:55::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 21:33:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d1f72cd-76b4-4d1d-8fb4-08d89709e3cb
X-MS-TrafficTypeDiagnostic: BY5PR12MB3969:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3969984035A77B67392F5F79ECF30@BY5PR12MB3969.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MW8wVXBDlR3iJDuPD4WELHLqPtceQJiPdFovW8ZHU3qWGjFUFH74WtszUkfiJMtr8qRVpt64xHkMJUQYVwC/gZEZ0bd5J+wqpJLl6E+mhDAwavAk05bfoErzPkSwD+gJiDswj4KIH3SWEIqmqRKyXF3Rwr0aGiazxzLQDU+oDb1iv2YTbp+oEJBY0nc088RmEVERSPl/tZFWlNJEXG/q31WlaJfrB9xhcLCZ+el7vSfzygitsA20Vih8jr9iSWensN/zChfUJlTpwQE4jRYfc2I6NAW66X9/F+MfV+6rm9HtCIjXqzsFWUXdyzFK/NoDDDwAk9Pyumc0l5na4Y69J/a/LNPd465KKIqfXlxbfGfFpsUI1iJTzEI4vSdyN+sRsdi0YwO0ljXOLIHMKGkZWBt0YvsRlZSi02Hfw3PbEg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39860400002)(136003)(4326008)(16576012)(86362001)(36756003)(66556008)(66946007)(478600001)(66476007)(83380400001)(26005)(6486002)(8676002)(31686004)(5660300002)(54906003)(16526019)(186003)(31696002)(2616005)(52116002)(316002)(53546011)(8936002)(2906002)(956004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?YWpXUUZJOFZYdW9CTUxuRjhoYUtIQzYzamJ0RStlbmplUmVXQy9MdzR0a0xj?=
 =?utf-8?B?c2cyTlhpTENlS3BVb1FOL0JmcjkvbmJKYWNydVI3OFZINVhCMElFdkRDQXox?=
 =?utf-8?B?S0swclBRNGdRUnFFTy9TbHRYRGh1MFlzK1ZGUXJzN2laRFBiU1IwRTBBcEgw?=
 =?utf-8?B?RWhzbmtraGNTN3QxTTlnOVBIVmExMjAyTDU5bXB0MFMwTnNGTTA2UjJ5RjFO?=
 =?utf-8?B?dnZiaVZycjJ1dDJFd1huUklzT3V6L1UrQ3ZBOGhhWjhWWnliMi8rY3JqNjBU?=
 =?utf-8?B?WDVFL0p2Y3dpVFBDbklQK0hIejdSTmZBVU5DeERWOHBmYjdZZjRaeWZDRlZ6?=
 =?utf-8?B?UU9XajY3STVQZUlpVkVKMmNFcldDeWpiVmdiVWlTNk9WdWVZWWk4ZzZpY25j?=
 =?utf-8?B?L1U4bGV5K3ZSK2xqeW5WSmFPSVJhNTh1VjBpbWFLSGVkckNtaEFNOUwxVFpq?=
 =?utf-8?B?aWtPWEV3TmxwYWR0bXFPQitCUFFxdCtBTHZ2WXpKUytUaitQemJJT3BBc3lK?=
 =?utf-8?B?c2F5NDl5Slo4WW8wZ1dHV3RMRURJRVlSWHlqbElCbWlQQlBFOThLNmpHcUNx?=
 =?utf-8?B?ZUJ2Q2pQRXhUQ1BPcUdPZWJTNTlRRlk0M1Ntak96NTIxWU41Y1FUc3BrOW9n?=
 =?utf-8?B?dGVSUEdHcG1VVklINFRSb3o2aC9QdTlWbXNqdWszKzA5SU8xZjk0SE5LVGRs?=
 =?utf-8?B?UHczUE1PZzMxV3VoWVUyQnF0cVlVL1Nsbklydlgxa292SEduTm9TMHFRNmhx?=
 =?utf-8?B?WFA1NEx6RFRkSmJqZ3hySmllUTBDbzRsZUxCS0VYR0FzanlxcGF0di9hRk5R?=
 =?utf-8?B?cXBVT2pHelc1MUZkZjRqSkV5VzlHRGNoNUJhYkhRRVhjWFd5U3UwZndoZTFt?=
 =?utf-8?B?S2hjWGUwT2JvclMxU2NhdWQvMU1qYUtyK05MOXFzN3hjRzQwWUVSbVVaQTBi?=
 =?utf-8?B?d2ZXRlpIb1Z1bURZdmluOFoydW81SCs3K29FWjN1NUllZVFmRExMdE9VTnd5?=
 =?utf-8?B?SG00bFgzb0lWbTdnNW1EUjdNRmJpUkIzZnZWalB3Rk5SL1pxcjFXRCtmUTBD?=
 =?utf-8?B?Q2NiQ1V2dGNreHVKMHN6K05sRkZXRTVRSFltSElhb1J6V0V4S1k5V0wyWkty?=
 =?utf-8?B?bmtQQUdWNWVxUEpiYkZWdTdzanhveW93eDZ5ODdwYkxpYXZobkJGbmhWOGU4?=
 =?utf-8?B?SzlMK3k2WFNiSmtxbjViOFkrSXdaMjFoTXR2QVYveVhMMGhPZHBwdU9Gdkl4?=
 =?utf-8?B?YVI3cmYyMytLbFlFbG1lK3h6ZUJXSG82SFJ5VmJLcmQycERSUTkvVk1McTR0?=
 =?utf-8?Q?KJet8Si/NvoRE6ejX8DpQfW9beLfdhtuYo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1f72cd-76b4-4d1d-8fb4-08d89709e3cb
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 21:33:21.0540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W+0oT9FzlJ+8wqLZbRp6NnsnsOI04oi//4czcr+940U8yofW2RgqEws61tGzqefEUQLjtnLF7SBORdLrQwKQ9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3969
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-12-02 4:09 p.m., Simon Ser wrote:
> Replace the width check with a pitch check, which matches DM internals.
> Add a new check to make sure the pitch (in pixels) matches the width.
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Series is:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++----
>   1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 9e328101187e..862a59703060 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8988,6 +8988,7 @@ static int dm_update_plane_state(struct dc *dc,
>   	struct amdgpu_crtc *new_acrtc;
>   	bool needs_reset;
>   	int ret = 0;
> +	unsigned int pitch;
>   
>   
>   	new_plane_crtc = new_plane_state->crtc;
> @@ -9021,15 +9022,25 @@ static int dm_update_plane_state(struct dc *dc,
>   				return -EINVAL;
>   			}
>   
> -			switch (new_plane_state->fb->width) {
> +			/* Pitch in pixels */
> +			pitch = new_plane_state->fb->pitches[0] / new_plane_state->fb->format->cpp[0];
> +
> +			if (new_plane_state->fb->width != pitch) {
> +				DRM_DEBUG_ATOMIC("Cursor FB width %d doesn't match pitch %d",
> +						 new_plane_state->fb->width,
> +						 pitch);
> +				return -EINVAL;
> +			}
> +
> +			switch (pitch) {
>   			case 64:
>   			case 128:
>   			case 256:
> -				/* FB width is supported by cursor plane */
> +				/* FB pitch is supported by cursor plane */
>   				break;
>   			default:
> -				DRM_DEBUG_ATOMIC("Bad cursor FB width %d\n",
> -						 new_plane_state->fb->width);
> +				DRM_DEBUG_ATOMIC("Bad cursor FB pitch %d px\n",
> +						 pitch);
>   				return -EINVAL;
>   			}
>   		}
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
