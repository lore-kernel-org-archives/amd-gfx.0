Return-Path: <SRS0=5+Vp=CS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8972C43461
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 15:02:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76E6722268
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Sep 2020 15:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DVxiGwbZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76E6722268
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0509D6E28A;
	Wed,  9 Sep 2020 15:02:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53246E28A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Sep 2020 15:01:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOUxB7LoQqK6fxiyAo51yyDad8NUHtACxjnzEwXiu04j7GCa3cMKyGygZEDAmiJRQwImndKoo+HwkxJ1pnfO73EA8D+fxGz28Vtpp+EnUkABGv5EYZ9MZATW/j/19SI3a57Cj6xMOafpoq6VJ9rM27w2xJ2UcK/4uNoLWtDn2n5BJvCoqn1t+1SOL308A9EncsHP9DxZhLAAD5Fy3u6oMiPTHwbDLdyZIDkosEVH307nMpmPtHg+CuaWQXHqsHCaqbn73+ipj0kOPWFYUSU8FqEvoJqiI0OGmvZAG9f1QUfSbBTHXcPLakK5wzPjBpMelowzq9O6WNDwwDMWGd5FaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmzTi6dmk7h4EuUeF+eJdkhi3GGkgtdI9J/vkyKexcM=;
 b=XaEVAvwkAAoKgtfQc84xUiceSsyZeLNwpj7xKJiJiao3wyzKOZzP4GOfC7K8amwpx6flIPF0gVpKpNCz8TWs7BGwu/qrymN0kRxDemGs33C8mBj5nHJLtnhIMpBnHlYX07PdHNSjEgtoXN+pJkNlWYORGdeVAmIYvbvMY5NdRpljVpGAkHXPcKljKNbczK/ntJSA9T03voGGdTeBfOskXF7VSOTtE6hhBB3COa6Yljv0z3sTi43uwbhjHixZNAghy1cnShHICRCZXZPEW8iZbrNoA8bu/mPi29QDGiirOMxrCRd6U9z3ALiZ3t+fTzPyLzEydiJtU5PMCx/1xGwo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmzTi6dmk7h4EuUeF+eJdkhi3GGkgtdI9J/vkyKexcM=;
 b=DVxiGwbZ6qUa72y6J7MQP+HDlXyJFztWQJe7cnr83VZdFM4DKaNQ6EvZ2Pv40uxHMlX31Av+/KXJYG/HTEdzs39PaTN5hEOt319gJFS4tEoeMslJKqbw5g9qM1N1wDG42cU57l/Jy8tZLfetpdwrPawakvlS1s7IZCBxUVsgvCU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3414.namprd12.prod.outlook.com (2603:10b6:a03:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 15:01:56 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::754e:8f27:157a:9101%6]) with mapi id 15.20.3326.030; Wed, 9 Sep 2020
 15:01:56 +0000
Subject: Re: [PATCH 3/3] drm/amd/display: Move disable interrupt into commit
 tail
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200909142854.105032-1-aurabindo.pillai@amd.com>
 <20200909142854.105032-4-aurabindo.pillai@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <18942f18-96aa-7a22-c296-aae68e53a4dc@amd.com>
Date: Wed, 9 Sep 2020 11:01:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
In-Reply-To: <20200909142854.105032-4-aurabindo.pillai@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::41) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.61] (24.212.165.133) by
 YQXPR0101CA0064.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::41) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend
 Transport; Wed, 9 Sep 2020 15:01:55 +0000
X-Originating-IP: [24.212.165.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1d7351d0-a464-4962-af9b-08d854d14b4d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3414:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB34145516C99703F1554EA203EC260@BYAPR12MB3414.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XM7gUCroyJ7TsAPUzF05N8OCMaH7YFZysiernBsiA9TQKwdx8Kwx04BJDJCSB9wMZR9xKJbTmnDFfVpUDN4n/DRlqcJvZFSTpNVywdC7DsHsznaf9v0Y+W8/BwRe2smEQuJ84+VUJxnXUca/siYdCxOJ0VpVsrk8ACFdacZh6aV3vrD5DahqXMJDa6PuLGsc3BAl6+N38QQm5Dik3/9ScKMJmnqVq6BWaPAaloAuJcwx6CweVO2oAI6lIfdFAKga2XMlVVG9iKm663EOVrdEU50DWQFi6ichqQt/otJIaabUinKuP/Hs2cqyvCaVryLZx7Lp/WGVxgOQPXEdqINYYGNBNU1I5cld0ez7dvJfxQtkSKszN9BcmJ/uyUCdWYBh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(52116002)(316002)(16576012)(26005)(31686004)(83380400001)(53546011)(6666004)(36756003)(8676002)(5660300002)(6486002)(66946007)(66556008)(66476007)(16526019)(2906002)(31696002)(478600001)(86362001)(2616005)(8936002)(956004)(186003)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 3mz1uvJzI7lNeCkp1GafqBO0A4nzxDGODCGy33YCd+5vOPrTEV99WMQ3xuquGS34YsEYmhwJjmZGKleP863lFPMqpa8awyASS2zyar9afJr62RQyTq2FM24UlEPdEWeBO4mFvUs5SUkMUX5fCzgK7gQ3HZktOEjcTbSt81QmrzAkS2E0qpS5+O1DfYn/49Vw/3+kQfXcBvbI1ngpXo1/fzejevDJLz6bQjTMBXdEC4Gk2GWAQ01PkCRKi4CTG4/PBwaLog9Ftk1ieJJ7uC1V50nd/5h5Dg7OBMnw88RC/tHo3PNf7dnibeUTJuv5cDT4SwJFs4uqsrg1ilmPOOEKUMWwcH1dpYacaxAGfQVT2RhiErdkqXhm2QGhTJH4sN8leoklEUdjMHZhlzBYMtjBHarJUrMk8IGgg1nEuWarzI5Fsq+ZGf21mcOJwJg5D8LCD4C+9EXuo269EJp7IHtm5TRbETWyGc7rFRNHbJBu8lQ0aYEQYUnQNP2LBl4UcXO3SilJNKIIo5fvUcU8155LitiZS8wIrEGs1dPSC6uEBf48clogovdrYbDM7+LQxCgzw0e1XeJmcy/8KRlz2TwTyf2qlvYqggypyFFki1MDrHqgT0g71mwIqNKaqPxa2cqoJvp8xOaEXlUSlM/COXtB4Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7351d0-a464-4962-af9b-08d854d14b4d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 15:01:56.4743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CU54EAjoK2rLc8Q58RMymkttCdBxH78LTefNw+l57jV+rvfUN8UWr1VM0d2U5OY1wdwTeSIZBYF++sBULXqCgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3414
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-09-09 10:28 a.m., Aurabindo Pillai wrote:
> [Why&How]
> Since there is no need for accessing crtc state in the interrupt
> handler, interrupts need not be disabled well in advance, and
> can be moved to commit_tail where it should be.
> 
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

This patch is fine in idea, but it'll need the reference counting fixed 
in patch #2 first and be adjusted after.

Regards,
Nicholas Kazlauskas

> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 +++++--------------
>   1 file changed, 10 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 0603436a3313..a40de242e04a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -7488,34 +7488,6 @@ static int amdgpu_dm_atomic_commit(struct drm_device *dev,
>   				   struct drm_atomic_state *state,
>   				   bool nonblock)
>   {
> -	struct drm_crtc *crtc;
> -	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
> -	struct amdgpu_device *adev = drm_to_adev(dev);
> -	int i;
> -
> -	/*
> -	 * We evade vblank and pflip interrupts on CRTCs that are undergoing
> -	 * a modeset, being disabled, or have no active planes.
> -	 *
> -	 * It's done in atomic commit rather than commit tail for now since
> -	 * some of these interrupt handlers access the current CRTC state and
> -	 * potentially the stream pointer itself.
> -	 *
> -	 * Since the atomic state is swapped within atomic commit and not within
> -	 * commit tail this would leave to new state (that hasn't been committed yet)
> -	 * being accesssed from within the handlers.
> -	 *
> -	 * TODO: Fix this so we can do this in commit tail and not have to block
> -	 * in atomic check.
> -	 */
> -	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
> -		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
> -
> -		if (old_crtc_state->active &&
> -		    (!new_crtc_state->active ||
> -		     drm_atomic_crtc_needs_modeset(new_crtc_state)))
> -			manage_dm_interrupts(adev, acrtc, false);
> -	}
>   	/*
>   	 * Add check here for SoC's that support hardware cursor plane, to
>   	 * unset legacy_cursor_update
> @@ -7566,6 +7538,16 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   		dc_resource_state_copy_construct_current(dm->dc, dc_state);
>   	}
>   
> +	for_each_oldnew_crtc_in_state (state, crtc, old_crtc_state,
> +				       new_crtc_state, i) {
> +		acrtc = to_amdgpu_crtc(crtc);
> +
> +		if (old_crtc_state->active &&
> +		    (!new_crtc_state->active ||
> +		     drm_atomic_crtc_needs_modeset(new_crtc_state)))
> +			manage_dm_interrupts(adev, acrtc, false);
> +	}
> +
>   	/* update changed items */
>   	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>   		struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
