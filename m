Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8457FC2D0E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF8D020791
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 19:56:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rxKKf6Bh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF8D020791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 708DD6E416;
	Thu, 12 Nov 2020 19:56:48 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 127EA6E416
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Nov 2020 19:56:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FG76Dmm8UElrwLL0GjpUQ8cm/32rftIu6ch0PLp7K49ATU5z2F+0Up5A40moDN1BaQ4xmYWq8jI0pgwR2F7gBLSiHppPitNnhb5L1bLVHUMWU/PRpN4wjfutqX9artmuiYwIlFTAHPVteF7bYn01lw5aspZiLmgi3RDWog0AmDOEBgyBtZPG9/V/qR5wvjtssPnKyBM5fbyannV3aBhA+hqGz95SVQEJPyeZYcQmRDm4JPR0xXTvZ1j19SNpyBXkxGSxNTU7AAN1C6griMwFVAE8alD8I+vxdZS/BhpYqHNsZwlAbsFvOJfxGiKTOsqTg7fk/mHiLfdDwqyfK2f1vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E532OIYO9I0WogaeKCAmEnKFjeYNoGA5zzFZFGQHso=;
 b=NGEoFvxG5y0cqVkuezCV//RM0XUvoNpG3rY2wU8lPeg5A7w8cvEKurwjAClhM0EWOQhxMjUzIkj6qt93MDzkVp9ZamZUcQTUlPInIEjcAROsClWqYBh+Re/oq8BEaseQlqnc1SRLP+u08izoz1empW+aECaWBgLOSw8CiPyowX1IOzgK2Zqs/YZnjm/MSXSHm6g7eo2jj5oNBinuUqjZ1ModVBcDFTFjlw1mLLcw/WYAgtV0rKvj+b6r24uBP/uYO2LVVI/whvgUv8C4LO8EWxo/gWikI9el29dM7dUzQlhFUR5sBMfircD6FIY4IWgsZPpKLBl7ioVJne1g6bS41g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6E532OIYO9I0WogaeKCAmEnKFjeYNoGA5zzFZFGQHso=;
 b=rxKKf6Bhl+wqi6/IqG9bcg84EdDiTibQ82ml38Fji9Q8XxWBsIpgJuJg6wtREZfrJWkNGI0U2lmid8YqEqC/og6iNWtrAnuU1FSSRAqjimfFt8J+u3GotG6FzGC3/1eDTWdoAO3KsVckWrfiJLG0GyNykbPWp1VtBmxLQyX/Ij0=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3288.namprd12.prod.outlook.com (2603:10b6:a03:130::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Thu, 12 Nov
 2020 19:56:45 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::b46f:9253:b0d8:7999%7]) with mapi id 15.20.3477.037; Thu, 12 Nov 2020
 19:56:45 +0000
Subject: Re: [PATCH] drm/amd/display: add cursor pitch check
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
References: <dM9UpdTNt3rJxagA8swvzv6sXdjID2x67yd3tJg6A@cp4-web-030.plabs.ch>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <d791cc9f-7aa5-b453-992d-1f0cf0f2a905@amd.com>
Date: Thu, 12 Nov 2020 14:56:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <dM9UpdTNt3rJxagA8swvzv6sXdjID2x67yd3tJg6A@cp4-web-030.plabs.ch>
Content-Language: en-US
X-Originating-IP: [165.204.54.211]
X-ClientProxiedBy: YTOPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::31) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.19.251] (165.204.54.211) by
 YTOPR0101CA0018.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Thu, 12 Nov 2020 19:56:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 167c5149-6a8f-4979-45df-08d8874514e2
X-MS-TrafficTypeDiagnostic: BYAPR12MB3288:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3288634DB3575FFEEFE6960CECE70@BYAPR12MB3288.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +x01LKCuhWaxhGPubzQJVXh3ZufwTLKIB3W+EO6fQ+Mll7PvMcsq98EVTEf77fJaTAQZWH7OK1hyaSC6oQqGeVox8wlukmGbHkeaROxkCWAdPnq0Un7lqXV5tW/gK37vJzkgQmgNZdDrTtTUQ24pZaEPM7zQ2RP4A+gzlK9ufv77fIaFjMoSBaWQqQwZwl/1O++oByRn4cpQY3aCaRecKipyU7giQoQsXGiveVA6ybkEhtyPYau/na0lflTpR2IaS4Wqo7D4+8XETLigEgBdwWHK2kpQo09O+br4qHFEQxkyfDP9bKxJUsUuvvK6/UJBZwIpJhuQCA814Rj6pcdvqpBGzr5pUBG7fvzXk6LEN5nZCSM9QmCT0Zyv/9plgGUA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(2906002)(8676002)(16576012)(5660300002)(86362001)(478600001)(6666004)(16526019)(186003)(66946007)(83380400001)(66476007)(36756003)(316002)(26005)(52116002)(956004)(53546011)(31696002)(4001150100001)(2616005)(8936002)(66556008)(6486002)(54906003)(4326008)(31686004)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: RgAMQ81WkNWULJDy6UJA8CTaf5Zm74DhusQg8mScwnIh9b9y7I6L7NEEBG4uNa5bepyacwU9PEq3o4jaXSJi+rjO/GyFexoUQPS93Y+sDfr5Ao5wXFnPngFw5Jxeq066BcXOH7ZIkBqjgWnFeiXwvtKSn943LlHV7NnruacJ8BJM68BLHpvLDFu7mUlN9K59HQNphF3rtvaiQerNVwlu/tG997pmcrKY1NmeF/yUbvCtqyL/nxzvq48fNHO99XrcvE0evQY5Z/QRu2AFQgqby3thgdBgF1YISupzXfRPKkZxqe14YTwdI0Q5f1Uy5ZSNaxnKPtYzDpNSU7Pbqc1Qq7UmemIzxa/pD6aQfyIDOggAmw7Mxs5JaUswlCYXkpZYx/h0DOj9PbpBYs0cMCGRg9S9aS+sAOCCiwjaOjz+kzxQAGLQTlFnh712xCHAJoOdHYl12BODiBiD7WNlN8owJG3nlriYa1CxK8TcY6O2JbtJSeVSJ0tsnHCN0UAUcs6KwfBU/xEuNytljaaGczOeQyEWJOvzrhmkEs9FMBO/vYUlel2mZahhfIhIQuF+tn7k60ZTjB62kosalAtDNw2g02gWgMDTavUVfUw2Wbx2Cg2QFtd8LpswpzbNxftUv/ahVfFXqHT5Xnoxlky32WUi+A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 167c5149-6a8f-4979-45df-08d8874514e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2020 19:56:44.9489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UakGp2738GPc/jRJqlU1k8oWkVMuE9JFy43mXrFGmOwWrLSE1enwJzOfs1dWPGh/VZ44WdecDQJSLoNl03MZlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3288
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-11-12 12:37 p.m., Simon Ser wrote:
> This patch expands the cursor checks added in "drm/amd/display: add basic
> atomic check for cursor plane" to also include a pitch check. Without
> this patch, setting a FB smaller than max_cursor_size with an invalid
> pitch would result in amdgpu error messages and a fallback to a 64-byte
> pitch:
> 
>      [drm:hubp1_cursor_set_attributes [amdgpu]] *ERROR* Invalid cursor pitch of 100. Only 64/128/256 is supported on DCN.
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Reported-by: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

But with some comments below:

> ---
> 
> Couple questions:
> 
> - This implements a single check for all GPU generations. Is my
>    assumption correct here? It seems like this check is OK for at least
>    DCN 1.0 and DCN 2.0.
> - We should really implement better checks. What features are supported
>    on the cursor plane? Is scaling supported? Is cropping supported? Is
>    rotation always supported?

On DCE and DCN there is no dedicated hardware cursor plane. You get a 
cursor per pipe but it's going to inherit the scaling and positioning 
from the underlying pipe.

There's software logic to ensure we position the cursor in the correct 
location in CRTC space independent on the underlying DRM plane's scaling 
and positioning but there's no way for us to correct the scaling. Cursor 
will always be 64, 128, or 256 in the pipe's destination space.

Cursor can be independently rotated in hardware but this isn't something 
we expose support for to userspace.

The pitch check of 64/128/256 is OK but we don't support 256 on DCE.

Regards,
Nicholas Kazlauskas

> 
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 2855bb918535..42b0ade7de39 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8902,6 +8902,20 @@ static int dm_update_plane_state(struct dc *dc,
>   			return -EINVAL;
>   		}
>   
> +		if (new_plane_state->fb) {
> +			switch (new_plane_state->fb->pitches[0]) {
> +			case 64:
> +			case 128:
> +			case 256:
> +				/* Pitch is supported by cursor plane */
> +				break;
> +			default:
> +				DRM_DEBUG_ATOMIC("Bad cursor pitch %d\n",
> +						 new_plane_state->fb->pitches[0]);
> +				return -EINVAL;
> +			}
> +		}
> +
>   		return 0;
>   	}
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
