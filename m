Return-Path: <SRS0=65vk=FI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3F2C433FE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 14:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB2422B39
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Dec 2020 14:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB2422B39
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572416E190;
	Fri,  4 Dec 2020 14:49:24 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2089.outbound.protection.outlook.com [40.107.236.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 082C76E190
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Dec 2020 14:49:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mvzWEe987izTBOfj5kjT2fVB/fSejR4GtkpjrN15eUhSyn6RKYREQP+9g83gKnZTHZ92umf0bvlo9ySlEBDX0JmBRr1NywVn7zCFBmpziJaPodZNZBFZfForaeNF92KyJBPnuhEuheVzNUJDg2v2D+V6oSAxh46l/7iWMsi0iOz1Ui3kcr37nP2qz3wci1Vgwz0YnF2j8p9dqIr2IZPEQ/WHMU7m10gVQfBH9j1YH5fu8rOXVFD/53fb8RMqCXVSmM6/dIRzJPD9qLPW2gcmgsLQm5rSk3ZC07EGdK1EG1o5DZLDvCnNVubI6u+0lfZOrCDZ8hOvX33GcrthUFm74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAeAd9xL4CChotCY+0QZ4eLrF1SU8J7+xE/jRsJmw0g=;
 b=CYPtiiUv8oudoX1/fNWx9RnoMVuRqaKpHgzqA+mUxEDSyMeZNXyrrZEy2L+G7X510p1qc6iYRUZoxnaEQbahfaUbtJnl2LPvVakUApPsizTRJvMfjqOAcfpYdWyozbRJV6k3xYEDxZMs8PH5yNCw8q1r+cl0c7pOrcHZ74Jai331PMAj0kwYlMZ79BrhWvF6sLj+2Rx9GpdPU+u0KEPLHesHljINuxYqKoAvBIryRoPbYnsXDZ9NbTl9iPWiKnqlSiGnlqj0xBxFwdi/qSUA/dAgUWZBuTjiTHLwY8K5LFey8p0pNTFgg8hXy9URnTvEKuBkDA9leFI7s46V+TU5nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JAeAd9xL4CChotCY+0QZ4eLrF1SU8J7+xE/jRsJmw0g=;
 b=yuGYGWKb0yNPHDaIY9Or//SfsGq4g4B4b3dtCtmCdVICNlEhKtkxt6q/5unALb+Zg1GpdA1y/PmE5rxCYwVVWOttJKv7Sa7Of7caPt0DtAaK+NrwHvzDxXiDVjB5H6I7x2a9rD8w4zsSSU2ezBs42CNQUSxTMfFuhG0km9Lvuoc=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB2918.namprd12.prod.outlook.com (2603:10b6:a03:13c::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Fri, 4 Dec
 2020 14:49:21 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::805a:3c9e:fefa:a95e%7]) with mapi id 15.20.3589.032; Fri, 4 Dec 2020
 14:49:21 +0000
Subject: Re: [PATCH 2/2] drm/amd/display: check cursor FB is linear
To: Simon Ser <contact@emersion.fr>, amd-gfx@lists.freedesktop.org
References: <JrpTBOVYpzRt8W1KDK3aNwqf6dwNpfPQKZOEnJgND0@cp3-web-020.plabs.ch>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <2db0bec7-a476-070c-95ab-f71777c224a6@amd.com>
Date: Fri, 4 Dec 2020 09:49:17 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
In-Reply-To: <JrpTBOVYpzRt8W1KDK3aNwqf6dwNpfPQKZOEnJgND0@cp3-web-020.plabs.ch>
Content-Language: en-US
X-Originating-IP: [165.204.55.211]
X-ClientProxiedBy: CH2PR08CA0028.namprd08.prod.outlook.com
 (2603:10b6:610:5a::38) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 CH2PR08CA0028.namprd08.prod.outlook.com (2603:10b6:610:5a::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.21 via Frontend Transport; Fri, 4 Dec 2020 14:49:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 383de668-736c-4aa9-7134-08d89863c887
X-MS-TrafficTypeDiagnostic: BYAPR12MB2918:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB29183A3B6819037DC7F7C0A2ECF10@BYAPR12MB2918.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wprnqBANDjMjXEnJ7yGr0gYvNz2ZATF5SlFfO1xtpjs0P/jYmwrZYcA2H2hr9z+GaRJ9/AG/GG6DaFYvgSbJwx3CCwaRGHufqyyCGuDIdX2HSkvXlfGLTAvCUfvPkI+RG90dJmj1qLwVayr2fE97kHDwbOm1GCElZ36JNm3KyJtKFMot9+godgmmTzhZuz53IH1cz6hP47ZTbGvdIYh0QS+PwQMkVcFOSjxfYEUdHsLxM/zxzUgxoGlgbv6jAMEESIt1jDFtGvCfIZqXsZM8fbUht0iPI1BmmapVoB+BvEfYfBuMVQ0nLZVgOhaqAy/dxZVbBr0U+wxr45NCUQGgxlVDbz3O8aAumgkNSaRqf72vfH4rmMpDr2yVX81ax5J0JNgSAIgGlhbXrLQ8MkGEtNjSkajSJOT2jXcQBeTj6u/dDVP4U/8S4PHX2qA0s+Mo
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(186003)(66476007)(31696002)(66946007)(4326008)(8676002)(8936002)(66556008)(6486002)(5660300002)(2906002)(16526019)(26005)(2616005)(53546011)(6666004)(316002)(956004)(966005)(83380400001)(52116002)(31686004)(86362001)(54906003)(36756003)(478600001)(16576012)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SXMrODVCenk4d1creFJTMEE3TVM3U0hySGxGampVUFk5enIzRGVFZjNYVW5E?=
 =?utf-8?B?V08wdmFtRDhxWnhaRjlrbTE1V2F5Y0RRVHVBUk54b0xWckkwbU1VTXRSWHph?=
 =?utf-8?B?UlJub1hnUU4zV2RJMjJqdlc2VkJzT25ETFo2UjUwVHVVTyt3WG5ndFdMZlFD?=
 =?utf-8?B?Rnp3V2Z1UDNuR1BPNFNPMk4rZGlLTm1renpCcWZycDhnNjgvMjYxK3NGWC8r?=
 =?utf-8?B?RFlFV3dEVVFSamJaeWpleUltbHhxMnIyejhpQk44akFCTGthZ0xHWTdFRHJq?=
 =?utf-8?B?bjBKVzdzSHNpcmhRQmh1YWwyeXJpbGp2Sk9qVFhvejBVVGRaazk3OWRSNlJJ?=
 =?utf-8?B?d2o2T29henpjTyt0T01GK2pPdFV4cmZnbXliR3ByWXgreVFnSm9YNWNXMHhk?=
 =?utf-8?B?d09NSmx2VVNYVjRRZEN5QTBiN2dMRm5rUnZaNzg1V0xDRWhpSmNMOHFHMWtY?=
 =?utf-8?B?WTlPSGUrMlhFSHowRnFLQzcrcHlxZU5DWEV6VHVmKzk5YmJVRTVsUjVGUHVO?=
 =?utf-8?B?RWlKVXpkaUd6U2lPcnFsT3dDMk1uK21OdXQxQzhhNTZ4cjYxYTIvR29EZ3Ex?=
 =?utf-8?B?QnZxM1BXcTU2Vjd5TzVTYTVJZmVkUm9Vb2ZDQ2wxY2h6amVqcjF1aHNNZHNL?=
 =?utf-8?B?bkdOTEpLd2FXdllFaSt2dXJWRERyRy9KUEh1ZTJxTUkzOVRwd0orUnRobUJ3?=
 =?utf-8?B?ZU9DekM3eC9UMGZ0TGY3cGZoS0U3ekZjSFF4cXhrYVRsa0xWS1F5eXo4cFJH?=
 =?utf-8?B?Y254dzluWUkvRyszVmQyY3h6ZnlRMjRlc2kvVVUvdEFGbHFYamtHR2xPU1ZV?=
 =?utf-8?B?ZmhGTDRtM2VEekgzR3ZraGFEVkdIU1ZwaTJJeC9WUlB3QldoRk9YdDcxOFVM?=
 =?utf-8?B?L3NiR2dzNlFZOEhOQWQzWVlhNFNucXg0R2RxUjR4NnVraCtlcHJpeGx4Zm03?=
 =?utf-8?B?aUR0RlQvNGd5YVo5Y1pVY2ZEWHZqTmJmbTAxU1JCT3dFZTZWS0lJQm9yOHlC?=
 =?utf-8?B?TnYrQ0dZSjFXcUFUSVdFV3N6bEVyZHIxQlJKVTN5NEt6ZWFRcVdOdXRuNWFY?=
 =?utf-8?B?cG4rUTRLUG44SWlXL29TRHpvRUcvVWJoYTNkUzBFNXdSRTJwTUt2QnNCUm82?=
 =?utf-8?B?MkRERlhIWnRQb3QycVdpaVVMdTRXTWo4WU04MWJjY09TUm5Db2c1eldWejdB?=
 =?utf-8?B?TE9VcUNhTzhRZ2tzcDRLcDJWSUFrNWFpWHB6aXZKMVJ0NHZ5MGIrZG9QRFdD?=
 =?utf-8?B?cXhqT1Rnc1ErU1gyYStxOVJucXI0bUtIejV3RnJLWWpEWk5qSzFpN2tSUzRl?=
 =?utf-8?Q?26Bjmo8oQSpV3g8Yo3NgUHIHg1moS44cRt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 383de668-736c-4aa9-7134-08d89863c887
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2020 14:49:20.9886 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOi+hZvSMcyi6hgWtFoSWyomkjUAIZxcK9BOrxh5mz92fSRnfm44GxRbOw4R1VYdVEJoloVasqI9zhz9tHUWsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2918
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
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-12-03 3:19 p.m., Simon Ser wrote:
> Previously we accepted non-linear buffers for the cursor plane. This
> results in bad output, DC validation failures and oops.
> 
> Make sure the FB uses a linear layout in the atomic check function.
> 
> The GFX8- check is inspired from ac_surface_set_bo_metadata in Mesa.
> The GFX9+ check comes from convert_tiling_flags_to_modifier.
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> References: https://gitlab.freedesktop.org/drm/amd/-/issues/1390
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> ---

Looks good to me, series is:

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++++++++++
>   1 file changed, 19 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 070bb55ec4e1..b46b188588b4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -8978,7 +8978,10 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
>   			      struct drm_plane_state *new_plane_state,
>   			      struct drm_framebuffer *fb)
>   {
> +	struct amdgpu_device *adev = drm_to_adev(new_acrtc->base.dev);
> +	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(fb);
>   	unsigned int pitch;
> +	bool linear;
>   
>   	if (fb->width > new_acrtc->max_cursor_width ||
>   	    fb->height > new_acrtc->max_cursor_height) {
> @@ -9013,6 +9016,22 @@ static int dm_check_cursor_fb(struct amdgpu_crtc *new_acrtc,
>   		return -EINVAL;
>   	}
>   
> +	/* Core DRM takes care of checking FB modifiers, so we only need to
> +	 * check tiling flags when the FB doesn't have a modifier. */
> +	if (!(fb->flags & DRM_MODE_FB_MODIFIERS)) {
> +		if (adev->family < AMDGPU_FAMILY_AI) {
> +			linear = AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_2D_TILED_THIN1 &&
> +			         AMDGPU_TILING_GET(afb->tiling_flags, ARRAY_MODE) != DC_ARRAY_1D_TILED_THIN1 &&
> +				 AMDGPU_TILING_GET(afb->tiling_flags, MICRO_TILE_MODE) == 0;
> +		} else {
> +			linear = AMDGPU_TILING_GET(afb->tiling_flags, SWIZZLE_MODE) == 0;
> +		}
> +		if (!linear) {
> +			DRM_DEBUG_ATOMIC("Cursor FB not linear");
> +			return -EINVAL;
> +		}
> +	}
> +
>   	return 0;
>   }
>   
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
