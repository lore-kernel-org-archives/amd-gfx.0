Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376D7C30658
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jul 2024 21:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C589B10E29C;
	Tue,  2 Jul 2024 21:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MPNAq3Uv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C49710E29C;
 Tue,  2 Jul 2024 21:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MESlvtfXbQ729zT8sO/kuiEOGD2hkKiKDI3CLSHjPYo=; b=MPNAq3UvUAIQ7J+eR/adP5imXa
 QDPxuaYJB2PM/jsNmCK/eFDMG26a2ERzzOC/SCEHC824Qp5XGWfFjBGKQayE0mstFAalIV7tE0Vjo
 coL15QcpuBcozhGcVHJ2spk4t1T66XgSw7e8eRLCeN0pyPABZY6tdpk4fTnhVvfglPH8ou4B6vvRs
 EacKBGfyc1OfPIJvvHlB6Su8lbYFsFKueejUJb++/OfmMfA/DfpHUL+HCODw7oEAqVD8MVrn7WAJT
 g55cLdbJbQM/IaS5vIVGmPsujtvsFXEQX5oQDOVp0uUcowaDuFOoYPaYO0kGaREjI177Vj7jYxFiK
 WYNyTZug==;
Received: from [191.19.134.16] (helo=[192.168.15.100])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1sOkw9-00ASd6-HK; Tue, 02 Jul 2024 23:21:17 +0200
Message-ID: <435dc750-5123-483c-848b-c71b970096da@igalia.com>
Date: Tue, 2 Jul 2024 18:21:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/atomic: Allow userspace to use explicit sync with
 atomic async flips
To: Simon Ser <contact@emersion.fr>
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com,
 Pekka Paalanen <ppaalanen@gmail.com>, daniel@ffwll.ch,
 Daniel Stone <daniel@fooishbar.org>, =?UTF-8?B?J01hcmVrIE9sxaHDoWsn?=
 <maraeo@gmail.com>, Dave Airlie <airlied@gmail.com>,
 ville.syrjala@linux.intel.com, Xaver Hugl <xaver.hugl@gmail.com>,
 Joshua Ashton <joshua@froggi.es>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240622170951.738735-1-andrealmeid@igalia.com>
 <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
Content-Language: en-US
From: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <E2TvhjtSDwH2ewf7fHTKGQChRCccKteo-t-FYLisImD7vCllDyV4_hcl8LsfKyY28mc5D7_zYSIJ5Qjac8QnENcI12RQHsDj5O3JyPzhiIg=@emersion.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Em 29/06/2024 12:32, Simon Ser escreveu:
> On Saturday, June 22nd, 2024 at 19:09, André Almeida <andrealmeid@igalia.com> wrote:
> 
>> Allow userspace to use explicit synchronization with atomic async flips.
>> That means that the flip will wait for some hardware fence, and then
>> will flip as soon as possible (async) in regard of the vblank.
> 
> LGTM.

thanks!

> 
> Would you mind sending a patch for FB_DAMAGE_CLIPS as well?

sure :)

> 
> Reviewed-by: Simon Ser <contact@emersion.fr>
> 
