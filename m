Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15524CD5BB5
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 14:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FFDC10F375;
	Thu, 21 May 2026 14:53:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="X4Cm0eRa";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 680A610F372
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 14:53:53 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-366375c4076so2457523a91.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 07:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779375233; cv=none;
 d=google.com; s=arc-20240605;
 b=QZrSKz8EY9BRbZd8sQeHpwJ2rrpq45qib/U7ZFbyiXOnb+2M8MgqAx24AjGD+09zZx
 Bf9w01eyGJbVzT0vY4IPyZWaOFxIje98G2WY8Di2XqzcCZi5ZqJEfHRnqkXxf5q0rPfi
 qNZArlRF+PooRDovluAQsAzZ1ByLZh9b2TzSskPKc9m+dQmHXG2jdYKwS7JstmlGWIs4
 E8DyfzxxCzCSbenS9SzR+tQ8LHRUlhEVWWC9/UEFYqEErWodnm/RbA3SO3wg6fp9SIgK
 d6HuT84G148+MqJp7GqKMUUfAk0/Se+f0/zewEczNePNDZEMZkC/YVjMBsYaqmilIhKA
 lSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=bA/ypZiwvOF7bLYV81VPBE2mEbMWo9wKAEc1kqSaHPI=;
 fh=u57OcBc8WSFkMFYUJHcOXBaKhvJ/TXWtRHFzzujK1ZM=;
 b=QaQY4PKJrSSIOvtARCxR4FKM4sp8xRmj2M567+w5OhKYjY9p06tSeK0Wmh6U44agbq
 0R5nynbvfuqxOaL02LpESLOZ+fmsXJ1eDsQPZGyeVjMe+9rkQb80U0ggjiIyO1+/xUuk
 ViCafYIg+XhmLtWSUYzqY7CgHLsKX13XJMF8boIqvg2lyw+H1nTBe9QkDcDlFJEJ2tBH
 k4AaQ9eS//MtFTjIQBVDjPoKo/jvDk5rutXvbF4BoSpauCLCJwAUegAntnAk4kJMAbMH
 /Xsd+haxxo/+XrbAHQVQdqTI3Ox2standvgnIwXg4yJ8Sla9Rj2Z0pve01GNdgXnLq+/
 tf3Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779375233; x=1779980033;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bA/ypZiwvOF7bLYV81VPBE2mEbMWo9wKAEc1kqSaHPI=;
 b=X4Cm0eRalOhD7aPfWdgBAVBQsTDZXCODGprWlAk7HpUnnY+QmW9ikUAQrBoFUV066h
 PDq+nDNKvUEK2MsIIG6juPz1PheewyhtGHPFuPAPBtp2mrTxzoJghs+yb/ppOeUeoZea
 hoO6TCqDTrAq0SopDvvkHIDjNYLqX7sCHKPLZvyHx1qYa4pGVD4MupVlPKM+IVFcW5Sa
 A5qso4bpIuub5uH4u1gwjA3BzgPAxnmrVcCSjEs1Z2bIlIHfGiu9gkCs3B2WsL7cLyyv
 BPcsGzUNRznfDwlBxAoewe/5/5HxNBKViHyx5FnJziIrSFAIAgz48nptWdoERrpqnJYU
 6gwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779375233; x=1779980033;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bA/ypZiwvOF7bLYV81VPBE2mEbMWo9wKAEc1kqSaHPI=;
 b=AamTYItX2sbZjGO6zKeXiSyZAr+2DXk6+oz86wFzn2kTIyfT1yxc5/EMaDPiwuSKnD
 z4IlIJ/k0ikJNBtmiQ/vN7oFDGSO0Lc12dnkNJYUMcuCsS/zEKznrLZcc+e8XChCiL8q
 i25ecEoZ8z4fHeDEL3B+elimUcsTPuYuak9aD6p9m9+BmYYVjIi9ry7hxlc+O0SvlMjS
 89C8P35oFmIxgRmWvZwxR1q5iIkdnwjkXC+gc4dOoXcpuzEZo9PXoSlUmlfgTLe3rDmZ
 HOHeDkoPDhG5UYa4mbCuJOiuyj6V5aXuTaQW5kn3+BujK8AEK1JgKQsOur/FcQaeVVs3
 aESA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/1ab0xZuFgogFs+GDu4HScgloItxn5hh4afC/cc9rteIFFQS3QNCQQ4fSVftIHBuCFa2Z4k9xI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwcHNNtZc8fX8CrMKDg9HPLM9T7+DahGveytKyqYbyb+DcPjbvF
 7uI2EBoqFXvvkisaQC7TS95CTlwOmO1NZX55ujGApTJQBRk/B1FhV3wuvpMOMIGEpcta+evHoyo
 NbJLdeDgn/88Lo9JpWGy47BFfAccLrP+RW+AB3ql2jQ==
X-Gm-Gg: Acq92OFEy1nocFFMRuavNTadXalefffRqTPfDJ/BWxp3LQExlnRQHdnJSqB12EBjslD
 skgDwkOYWJruR3lM2y7Kr4W2Ue0tVxZEza9MyCoOW8Ku3jOJYpWDi5Y4d7xLmnv1xT4vUOq8r7H
 pt72xFouoi6AAEtPT53w7B1lk3DzaEgISQUPNPsGY/lDm6a9MbQaa0cObAU9aqP7KcFSIVfkmfu
 UUSRSX14WUTmszF6x5j2TUIipalBVnTgsUoYteBLYCsl104FwiGzatDE6tA310/y1ZCNZa09sQL
 yo85Nh/jOIMy6+aBnPREoAbGUd3HhCfeeG5o4Po=
X-Received: by 2002:a17:90b:2d50:b0:368:78da:803 with SMTP id
 98e67ed59e1d1-36a451816e0mr3680773a91.12.1779375232901; Thu, 21 May 2026
 07:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
In-Reply-To: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 21 May 2026 15:53:41 +0100
X-Gm-Features: AVHnY4KPQYYiaRNDiAsU-wmS8JuOZnjSnShN4CXgg2DHzWx0LVSgQ_nHQROoprA
Message-ID: <CAPj87rOFnB+csoswOOSBR2-=abtCDbsKq2uJ_PgYKPWh-G8m9w@mail.gmail.com>
Subject: Re: [PATCH v14 00/28] Add new general DRM property "color format"
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, Dmitry Baryshkov <lumag@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel@collabora.com, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-doc@vger.kernel.org, 
 wayland-devel@lists.freedesktop.org, Werner Sembach <wse@tuxedocomputers.com>, 
 Andri Yngvason <andri@yngvason.is>,
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
 Marius Vlad <marius.vlad@collabora.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Andy Yan <andyshrk@163.com>
Content-Type: text/plain; charset="UTF-8"
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

Hi there,

On Thu, 23 Apr 2026 at 20:04, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> We have an implementation in Weston at
> https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/1825 that
> adds support for this property. This patch series has been tested
> against that MR on i915 (HDMI, DP), amdgpu (HDMI, DP) and on rockchip
> (HDMI).

This MR is R-b me.

> General notes on the approach taken by me: instead of silently switching
> to a different format than was explicitly requested, or even worse,
> outputting something to the sink the sink doesn't support, bubble up an
> error to userspace instead. "color format" is a "I want this" type
> property, not a "force this" type property, i.e. the kernel will respect
> the limits imposed by the hardware.

Yes! If userspace wants a fallback chain, it should encode it itself
through a series of test commits, rather than adding the sequential
logic to the kernel. Doing that might work for one axis, but pretty
quickly disintegrates when there are multiple parameters to perhaps
fall back on.

I had minor comments on 03 and 20, but they're Rb me with the obvious
fixes. 11, 12, and 19 are Acked-by me, as I don't quite know the
hardware specifics well enough to say. The rest are Reviewed-by me.

I suggest you merge the common code and VOP2/DW-QP implementations via
drm-misc, leaving Intel and AMD to merge through their own trees
whenever they're ready. We'll merge the Weston implementation when it
lands in DRM.

Thanks to you and all prior cooks for all the work, and to Maxime and
Dmitry for the help and review as well.

Cheers,
Daniel
