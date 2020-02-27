Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99FDC4BA24
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:57:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B926024692
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 11:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zuTC8htz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B926024692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82AF16E859;
	Thu, 27 Feb 2020 11:57:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::61a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 374766E859
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 11:56:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hwWHgTtYOnIKDiOljYMIihk1G+MxqOJWyORBsYTQ5MqYuyWd32w1maCfe4fXVtSNCuQ7HKM4zjXm/O4FJLK54xdf5WtUeNpQgNf/p9IHePb9pAUXADmcKQaP8qe7xZobnASnvM6hKqy/NAbt7UQBX40BnzZLvshqM1VEvL2HuWbW0mhuxKl5P96T3Dw9xgcDIIqkJUtIrr/svgiG/41r60SsZx0raK7yKA1vCply+ZmvHx5gqjCJc65ZZ3oTt9cFNDd5UczO79ZrXc4AYZYU9U4qTH8I+kUW5yrVc/Z7A5UsZi3S/511uyxZ0fzXoh7dO+rMvOfVSuJWSv6WABE4Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BckXpabA7ez2KdLmQibUGZr/PD7iXahshlmUK5nnlP8=;
 b=KhNa8OGXCBRszlGJ2+fVUEXjtx90CtqWMsBT4AEvdTTH9U0LeKzdbjxPLqLOqzbXr8lh+GkYUmIlxqKkrqOl2ISRNlgTdi/9hwxXOtElJgBcK9+TcxAxyYQgciMzhsadxl6Mo1SW/+/Ok7QouUUDLnM0LVG74Z3A8/Ll3eoxgPNAYobsRe0mcWfocv7ry6wFBdVcSy6rISHRiQvyHM1pQx86/NGi/aQ/E/Wkr57j6r7+JbuMCCnPpd2NHq1aZdD5JNP3TaWfFH09/UU7iUUe+J2Tyi17FBTsXVCsdsTeT44TFgvt5EWdl2EaS9TV28F7VnETJWubfuofgvHAeKVAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BckXpabA7ez2KdLmQibUGZr/PD7iXahshlmUK5nnlP8=;
 b=zuTC8htzlaVWoK/QUfm5vImXnzmY51F1yjOqwVrByT3LndFQGUepTP98XA74fvrxRFT8g8TQOyGBgNoQKmyj+e39iwHoIea7Q4axklA4eQH5buF6+AQIvCzpDW8aYy1PpdrxWRs83FRWOmnHNGiaeTA9x7uDNCEG34WX8qZQO10=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Ray.Huang@amd.com; 
Received: from MN2PR12MB3309.namprd12.prod.outlook.com (2603:10b6:208:106::29)
 by MN2PR12MB3278.namprd12.prod.outlook.com (2603:10b6:208:ac::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18; Thu, 27 Feb
 2020 11:56:57 +0000
Received: from MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a]) by MN2PR12MB3309.namprd12.prod.outlook.com
 ([fe80::f945:5c4c:9c3f:930a%6]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 11:56:57 +0000
Date: Thu, 27 Feb 2020 19:56:48 +0800
From: Huang Rui <ray.huang@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Fix per-IB secure flag GFX hang
Message-ID: <20200227115647.GB13364@jenkins-Celadon-RN>
References: <c062930f-d9bd-bb7b-e75a-3e5b4e0c7de4@amd.com>
 <20200226223903.6088-1-luben.tuikov@amd.com>
 <20200226223903.6088-2-luben.tuikov@amd.com>
Content-Disposition: inline
In-Reply-To: <20200226223903.6088-2-luben.tuikov@amd.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: HK2PR06CA0008.apcprd06.prod.outlook.com
 (2603:1096:202:2e::20) To MN2PR12MB3309.namprd12.prod.outlook.com
 (2603:10b6:208:106::29)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from jenkins-Celadon-RN (180.167.199.189) by
 HK2PR06CA0008.apcprd06.prod.outlook.com (2603:1096:202:2e::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2772.14 via Frontend Transport; Thu, 27 Feb 2020 11:56:54 +0000
X-Originating-IP: [180.167.199.189]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5b754efa-750a-4e61-4935-08d7bb7c2512
X-MS-TrafficTypeDiagnostic: MN2PR12MB3278:|MN2PR12MB3278:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3278F31138C93CE455152A0CECEB0@MN2PR12MB3278.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:270;
X-Forefront-PRVS: 03264AEA72
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(136003)(346002)(376002)(366004)(39860400002)(199004)(189003)(33656002)(6636002)(6862004)(478600001)(55016002)(9686003)(186003)(66476007)(956004)(2906002)(4326008)(26005)(16526019)(66556008)(33716001)(66946007)(316002)(86362001)(81166006)(6666004)(52116002)(5660300002)(6496006)(81156014)(8676002)(8936002)(54906003)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3278;
 H:MN2PR12MB3309.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGZ4geslONX+aGVvptgyXrRnc+6bru3U8i84UpzH3FNZPgYs27POsyfjPvY7Yc5/biA5yZQHSuA7TTePmUKTgmaqAsYu8kTVksvp88c2XymMclKX1BePeBk3qP9fsYTbnYUXtZO2rYzKimGJfZFT1v5zPbPaOlExdsFr0ZvmwSR2NWmsQpe9eOHljNWUiyVkCJDQ8l2NKvFpeGk9zd1nuBvnclqZCyYmS+VsKG8ILphSpAWgc0gFhctof7aTi5+sfEdTChdyOrY8G/hJsG+zCwdqODCEqfausz6+HEm6xh2Am6F0iVfNr7UDw5KjnB+o/NY3VeV4yeRo7xKwctqN/VLl5Hm1lxPW4YHLx588vDh79Zq0nuUpR3ZKCxmbgqsuMTreaha2u75UJi84FAebBLmG/MH5jbItPAUy1FxwOk4/sLsLnlNrA3nuYhlqhCar
X-MS-Exchange-AntiSpam-MessageData: e/uoQ1SEaltX05QHJsJleH1iIP+7psOJVTViPfT/I2IXmAuCDhnVtbooOgWk6YyoXc7Zc69FTRQ3MzgkJoW317I83NzDLs0ZzcZaRrCctPTtBz7o4by1fptrvGWWBEXF+zW+1LY7zBJDZb7tm/nflw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b754efa-750a-4e61-4935-08d7bb7c2512
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2020 11:56:57.0157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KYWxMNTlO9ihOxKMUg9Ys10YBCZfbaXu854OF7Dxk3Ckb2+/FmHZ2GTpcODmfa30fFGy0JQN1xPxc4xvTNjXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3278
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Liu,
 Aaron" <Aaron.Liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Feb 27, 2020 at 06:39:03AM +0800, Tuikov, Luben wrote:
> Since commit "Move to a per-IB secure flag (TMZ)",
> we've been seeing hangs in GFX. Ray H. pointed out
> by sending a patch that we need to send FRAME
> CONTROL stop/start back-to-back, every time we
> flip the TMZ flag as per each IB we submit. That
> is, when we transition from TMZ to non-TMZ we have
> to send a stop with TMZ followed by a start with
> non-TMZ, and similarly for transitioning from
> non-TMZ into TMZ.
> 
> This patch implements this, thus fixing the GFX
> hang.
> 
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c   | 87 +++++++++++++++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  5 +-
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c   | 15 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 13 ++--
>  4 files changed, 79 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index 4b2342d11520..16d6df3304d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -216,40 +216,75 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>  		amdgpu_ring_emit_cntxcntl(ring, status);
>  	}
>  
> -	secure = false;
> +	/* Find the first non-preamble IB.
> +	 */
>  	for (i = 0; i < num_ibs; ++i) {
>  		ib = &ibs[i];
>  
>  		/* drop preamble IBs if we don't have a context switch */
> -		if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> -		    skip_preamble &&
> -		    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> -		    !amdgpu_mcbp &&
> -		    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> -			continue;
> -
> -		/* If this IB is TMZ, add frame TMZ start packet,
> -		 * else, turn off TMZ.
> -		 */
> -		if (ib->flags & AMDGPU_IB_FLAGS_SECURE && ring->funcs->emit_tmz) {
> -			if (!secure) {
> -				secure = true;
> -				amdgpu_ring_emit_tmz(ring, true);
> -			}
> -		} else if (secure) {
> +		if (!(ib->flags & AMDGPU_IB_FLAG_PREAMBLE) ||
> +		    !skip_preamble ||
> +		    (status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) ||
> +		    amdgpu_mcbp ||
> +		    amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> +			break;
> +	}
> +	if (i >= num_ibs)
> +		goto Done;
> +	/* Setup initial TMZiness and send it off.
> +	 */
> +	secure = false;
> +	if (job && ring->funcs->emit_frame_cntl) {
> +		if (ib->flags & AMDGPU_IB_FLAGS_SECURE)
> +			secure = true;
> +		else
>  			secure = false;
> -			amdgpu_ring_emit_tmz(ring, false);
> -		}
> -
> -		amdgpu_ring_emit_ib(ring, job, ib, status);
> -		status &= ~AMDGPU_HAVE_CTX_SWITCH;
> +		amdgpu_ring_emit_frame_cntl(ring, true, secure);
>  	}
> +	amdgpu_ring_emit_ib(ring, job, ib, status);
> +	status &= ~AMDGPU_HAVE_CTX_SWITCH;
> +	i += 1;
> +	/* Send the rest of the IBs.
> +	 */
> +	if (job && ring->funcs->emit_frame_cntl) {
> +		for ( ; i < num_ibs; ++i) {
> +			ib = &ibs[i];
> +
> +			/* drop preamble IBs if we don't have a context switch */
> +			if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> +			    skip_preamble &&
> +			    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> +			    !amdgpu_mcbp &&
> +			    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> +				continue;

Snip.

> +
> +			if (!!secure ^ !!(ib->flags & AMDGPU_IB_FLAGS_SECURE)) {
> +				amdgpu_ring_emit_frame_cntl(ring, false, secure);
> +				secure = !secure;
> +				amdgpu_ring_emit_frame_cntl(ring, true, secure);
> +			}

That's pretty good optimization! I spend quit a few time to understand this.

>  
> -	if (secure) {
> -		secure = false;
> -		amdgpu_ring_emit_tmz(ring, false);
> +			amdgpu_ring_emit_ib(ring, job, ib, status);
> +			status &= ~AMDGPU_HAVE_CTX_SWITCH;
> +		}
> +		amdgpu_ring_emit_frame_cntl(ring, false, secure);
> +	} else {
> +		for ( ; i < num_ibs; ++i) {
> +			ib = &ibs[i];
> +
> +			/* drop preamble IBs if we don't have a context switch */
> +			if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
> +			    skip_preamble &&
> +			    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
> +			    !amdgpu_mcbp &&
> +			    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
> +				continue;
> +
> +			amdgpu_ring_emit_ib(ring, job, ib, status);
> +			status &= ~AMDGPU_HAVE_CTX_SWITCH;

To pull the checking "job && ring->funcs->emit_frame_cntl" out of the loop,
that make the implemenation more duplicated like below, we have to write
the same codes multiple times. I hope the implementation is more simple and
readable. Please see my V2 patch that I just send out. We can try to use
minimum changes to fix the issue.

		for ( ; i < num_ibs; ++i) {
			ib = &ibs[i];

			/* drop preamble IBs if we don't have a context switch */
			if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
			    skip_preamble &&
			    !(status & AMDGPU_PREAMBLE_IB_PRESENT_FIRST) &&
			    !amdgpu_mcbp &&
			    !amdgpu_sriov_vf(adev)) /* for SRIOV preemption, Preamble CE ib must be inserted anyway */
				continue;

                        ...
			amdgpu_ring_emit_ib(ring, job, ib, status);

Thanks,
Ray
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
