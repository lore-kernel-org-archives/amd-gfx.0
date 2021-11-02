Return-Path: <SRS0=itHt=PV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82911C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 14:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7B060524
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Nov 2021 14:01:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4C7B060524
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=net-c.es
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34F4472D2A;
	Tue,  2 Nov 2021 14:01:13 +0000 (UTC)
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27DD72D13;
 Tue,  2 Nov 2021 14:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=net-c.es; s=mailo;
 t=1635856506; bh=86oBTMpnXN2rssnmOQ7LA61tTu8gU4eFEfOZP78RisE=;
 h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
 MIME-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To;
 b=arAXsp3pJle1r6nOqeqtDf2GduQBJSJKdxquDfPAglkotW2p8bd9ev6Y1hBR3zQtg
 IuyMT4zYDmmlvKXOVjKcAlGccOqgCOyTr7jvZCiwWUwgT/UAfqSpkdsL+5jWMX7OiY
 9iniW7IyoDqfGYNxRqVLIjAV6dqoTLdd5QORxuSQ=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
 via ip-206.mailobj.net [213.182.55.206]
 Tue,  2 Nov 2021 13:34:38 +0100 (CET)
X-EA-Auth: FKr0z78nEI7fK18kQiJqc8cm6AQzx1MLFVMzYMgk3A7ptvyPhNNicmEOsJfefFwiU43Mj4ZkxeU8iS9dGsGDy7tpZekUHCqR
Date: Tue, 2 Nov 2021 13:34:35 +0100
From: Claudio Suarez <cssk@net-c.es>
To: Inki Dae <inki.dae@samsung.com>
Subject: Re: [PATCH v2 06/13] drm/exynos: replace drm_detect_hdmi_monitor()
 with drm_display_info.is_hdmi
Message-ID: <YYEwWwZY/D7ylVuN@gineta.localdomain>
References: <20211016184226.3862-1-cssk@net-c.es>
 <CGME20211016193513epcas1p4e354183520df0aa4c381b19eb2863262@epcas1p4.samsung.com>
 <20211016184226.3862-7-cssk@net-c.es>
 <ee6b3bac-4762-fd8f-c12a-c0a7ea7b56e9@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee6b3bac-4762-fd8f-c12a-c0a7ea7b56e9@samsung.com>
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
 amd-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Ben Skeggs <bskeggs@redhat.com>, linux-arm-msm@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, Jani Nikula <jani.nikula@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 linux-tegra@vger.kernel.org, Sean Paul <sean@poorly.run>,
 Jingoo Han <jingoohan1@gmail.com>, Pan Xinhui <Xinhui.Pan@amd.com>,
 Sandy Huang <hjc@rock-chips.com>, Robert Foss <robert.foss@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, freedreno@lists.freedesktop.org,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Oct 27, 2021 at 07:28:45AM +0900, Inki Dae wrote:
> Hi,
> 
> 21. 10. 17. 오전 3:42에 Claudio Suarez 이(가) 쓴 글:
> > Once EDID is parsed, the monitor HDMI support information is available
> > through drm_display_info.is_hdmi. Retriving the same information with
> > drm_detect_hdmi_monitor() is less efficient. Change to
> > drm_display_info.is_hdmi
> > 
> > Signed-off-by: Claudio Suarez <cssk@net-c.es>
> > ---
> >  drivers/gpu/drm/exynos/exynos_hdmi.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(
> > 
> > diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
> > index 7655142a4651..a563d6386abe 100644
> > --- a/drivers/gpu/drm/exynos/exynos_hdmi.c
> > +++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
> > @@ -893,12 +893,14 @@ static int hdmi_get_modes(struct drm_connector *connector)
> >  	if (!edid)
> >  		return -ENODEV;
> >  
> > -	hdata->dvi_mode = !drm_detect_hdmi_monitor(edid);
> > +	/* This updates connector->display_info */
> > +	drm_connector_update_edid_property(connector, edid);
> > +
> > +	hdata->dvi_mode = !connector->display_info.is_hdmi;
> 
> Thanks for correcting this. Yeah, we should use drm_display_info.is_hdmi parsed from EDID.
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/gpu/drm/drm_edid.c?h=v5.14.14#n4725
> 
> Signed-off-by: Inki Dae <inki.dae@samsung.com>


Thank you, Inki.

Best regards
Claudio Suarez


