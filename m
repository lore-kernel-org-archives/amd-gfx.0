Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D47C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 12:59:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4807610CA
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 12:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4807610CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net-c.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE3986FD13;
	Tue,  2 Nov 2021 12:58:54 +0000 (UTC)
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFF786E42D;
 Tue,  2 Nov 2021 12:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1635857790; bh=CxtE17YE8bTxc2OZMsovWXK3+dSK0SB9WZtSH2RbPug=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:In-Reply-To;
 b=aXtmxAY1SH2wPjJvfHmAvgVeCVrMuJ6syrBNDNUerpV/YLeEqhs5miXhGUOqDZG5t
 r7lWYCaq7pBEeKveN4Tu42NfydGmsF5X4KWqaHj++7GbM27PJqfoCESSq5WX5BOVWK
 NNx4WNbtT4n3PE7H+vgLavkHmkcW2dCaKn8zDZ+Y=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Tue,  2 Nov 2021 13:56:30 +0100 (CET)
X-EA-Auth: YdEHunKGztPDVs0BRuuYltTcf81Ut8uI6tAipFjzxRq1G8jzqA4E913inzbs1+c4T8oxY2G5RSvtViKvlHZ3omj5ufd2PEoZ
Date: Tue, 2 Nov 2021 13:56:27 +0100
From: Claudio Suarez <cssk@net-c.es>
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Subject: Re: [PATCH v3 13/13] drm/i915: replace drm_detect_hdmi_monitor()
 with drm_display_info.is_hdmi
Message-ID: <YYE1ezTN/O+4S/vt@gineta.localdomain>
References: <20211016184226.3862-1-cssk@net-c.es>
 <20211016184226.3862-14-cssk@net-c.es> <YW8QYsmkm3ZrBAx3@intel.com>
 <YW9L6d7e+RO29VJu@gineta.localdomain> <YXFwB7rN4bvR0Z+m@intel.com>
 <YXKRnUHWuboQKBF1@zorro.micasa> <YXKoMEF/gU98cL9n@intel.com>
 <YXKtIUDk+f2Bnn++@intel.com> <YXXbgWNHts9CMJXD@gineta.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXXbgWNHts9CMJXD@gineta.localdomain>
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
Cc: heiko@sntech.de, Emma Anholt <emma@anholt.net>,
 Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>,
 nouveau@lists.freedesktop.org,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>,
 amd-gfx@lists.freedesktop.org, Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Chen-Yu Tsai <wens@csie.org>, Ben Skeggs <bskeggs@redhat.com>,
 linux-arm-msm@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 Jani Nikula <jani.nikula@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, linux-tegra@vger.kernel.org,
 Sean Paul <sean@poorly.run>, Jingoo Han <jingoohan1@gmail.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, Sandy Huang <hjc@rock-chips.com>,
 Robert Foss <robert.foss@linaro.org>, Rob Clark <robdclark@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 freedreno@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Oct 25, 2021 at 12:17:37AM +0200, Claudio Suarez wrote:
[...]

No new comments about this, I suppose everything is fine.

I'm going to send the patch with this changes. Thanks to all and
special thanks to you, Ville. Hope this helps the kernel.
Don't hesitate to ask new changes if necessary.

Best regards
Claudio Suarez



