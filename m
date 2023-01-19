Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4905DC00A5A
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Jan 2023 07:57:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA8B310E8CE;
	Thu, 19 Jan 2023 07:57:19 +0000 (UTC)
Received: from mailrelay2-1.pub.mailoutpod2-cph3.one.com
 (mailrelay2-1.pub.mailoutpod2-cph3.one.com [46.30.211.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E3E910E8CE
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Jan 2023 07:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ravnborg.org; s=rsa2;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=8RmU549DZV3sHG3j8ZTm4NBHjfrkUuiCrcyrCec7K+A=;
 b=wEt0EBBgU5LTcly3GFA+lxNYbutTTL9rmFz42LPrI2ituqBW14ZLnsy1H8VvCbCiw6kfUjqqy+tfC
 aIGRH7WASsKmiPaFJ8grY1YCEg260L6KG1Y6tum7gAIKA7dzf8lTdXVTiVIbQir3FA0Mm5mdp+1fKx
 kZr9+cEqc08k/cScYIMXXujvP6DrhbDCGvvJXY7Z0P3x3x+nkblXYQn4jFv4xSM1Jus+xKEka0STTh
 zJqWFA+hVXvVU5Mr8JB0TVk7Y6c0igi1vhY9mcXk5NRBt/EeXLkIkxInXtxG4As4w2YUfkfm0+F0ID
 HfT9UEtKfKI0K7eKe7fCuwdL5ws0ZeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=ravnborg.org; s=ed2;
 h=in-reply-to:content-type:mime-version:references:message-id:subject:cc:to:
 from:date:from;
 bh=8RmU549DZV3sHG3j8ZTm4NBHjfrkUuiCrcyrCec7K+A=;
 b=SaU3lMRsEzNGi8t6uNHk4w7+8ItLIdpaZNrMjFwmcsGiEXF6zT1TS1q7Rtp82tGw4zQZgVrKm/vJj
 DJoIFTVAg==
X-HalOne-ID: bd85b07b-97ce-11ed-94f6-93f0a866dfbb
Received: from ravnborg.org (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
 by mailrelay2 (Halon) with ESMTPSA
 id bd85b07b-97ce-11ed-94f6-93f0a866dfbb;
 Thu, 19 Jan 2023 07:56:13 +0000 (UTC)
Date: Thu, 19 Jan 2023 08:56:11 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Nirmoy Das <nirmoy.das@intel.com>
Subject: Re: [PATCH v2] drm/radeon: Do not use deprecated drm log API
Message-ID: <Y8j3m6Y5tROJMIMf@ravnborg.org>
References: <20230117180417.21066-1-nirmoy.das@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117180417.21066-1-nirmoy.das@intel.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Nirmoy,
On Tue, Jan 17, 2023 at 07:04:16PM +0100, Nirmoy Das wrote:
> Replace deprecated DRM_DEBUG_KMS_RATELIMITED() and DRM_ERROR()
> with proper APIs.
Thanks for working on this!

Also thanks for Christian to take care and apply the patches.

	Sam
