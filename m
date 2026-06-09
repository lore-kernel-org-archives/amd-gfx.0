Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 857B8CD8CB2
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 20:12:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1245A10E37B;
	Tue,  9 Jun 2026 20:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="Io6GWpt6";
	dkim-atps=neutral
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C67410E625
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 20:12:02 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-36b903567fdso6042228a91.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Jun 2026 13:12:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781035921; cv=none;
 d=google.com; s=arc-20240605;
 b=Mom/KmM3G8mYPSyCJVVgV5OY6tCP4b53GME70Q+0lsa3g7xWqLXk7eRhZF2/6H2RlX
 Cu/15O4iq6keURI2BxTbab873xNAEYi4OmAD2oRlOaTPPgvdyn7abYP2jA6XuQj60P5a
 n0kLRs4y8nRVDzoQC85CPVNWhMrRx0UJAjcvukgvEuM6OkEx1W/itvtbTHg4PbSG6wPz
 QrFIXCFrDRY2XFCyQ5r5BdHxbn7ViKE0BcznlbM1CDMs8y3wrCXCBfWC5E+kJD+pSAJT
 nSzmXSEz2S+1Bmy1vOqMHXgxvZLnmYz6iE8dRwG3uFz0qe+dSY47KlPQs3CI6FO8VWPS
 jOzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1TP2hUiA2w4UiubJG1d5nR2maW5WDwIWjpRzO+M+ax0=;
 fh=UJQ5dqDaY/dgX5B2o6OUIepspuQtBC3jeTFXwHqDqoQ=;
 b=CXQPNAPas/98GfBseIvMJXHalTyve7Pgo13qxXx06JqA2UsJKVYiHz4wEIelbkcW1f
 q22MrwsQE5lnetERO3jF8OztkPC32cf1bs/SQGu3x9cOZWz+ESY+dbEEuVXoGLvvsVgc
 LuUNA5SzJ4rMGZIDjZQByffanNyTQ157MJuLUGqEdfHgv2J3PyNvlSQPM8kzE/XsVysD
 S4CnJJCwJz7HGmuZxjhNQUc6nmmHhIm/O/uI+8iYOhwYSEhpdfHJnjNxXT1zxzu3WN6x
 xLUVtKT1zL++rFMwBr6ZCck4Zp4CuysNaZxutSlIFfaERqSpwPpxHEX6pl3ztbArOLzd
 wNiA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1781035921; x=1781640721;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1TP2hUiA2w4UiubJG1d5nR2maW5WDwIWjpRzO+M+ax0=;
 b=Io6GWpt62/Gv/hyGboRumqyDPBqmK48RMS/LWQjoe3l1/+gg0mPwtFR9RZrYo5zrMF
 dTHM7QPQvj2OCdN8wF9jDgVSd8skMH9J50XOyWbjVJkdybrgmS7t4Gb9KClxygrdkO1F
 Fb0hfjjjguTi1bdiMnBUARPpimPf238PplHHiGjzC0MH+Vbvt0kYoWtU9c+/AfFIaO4C
 AzAeG6aM7LnU1/ndPe5pSjvVEX8Fho9hHIZQICq+eeUlcDEZUqry93r+N3BmnmQ+kYNp
 7W6Gjxl61cghxZi1rL0VU9OTjhofVrRSzstptUIzNhPBVPw+nIp7jwFMET7tbMzcwbw9
 EGSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781035921; x=1781640721;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1TP2hUiA2w4UiubJG1d5nR2maW5WDwIWjpRzO+M+ax0=;
 b=R7bOFtCSCF2mi99kueZ+tfmr5QZwlvDhRDFDpsDZS0t1tv5fR1XGygbw3rx84dhAxc
 HKXZINmd7kzJcwpU2U8GD2KUmIYjtlkkNP++iWlprtViZCr4L0+Za9WW2suyYVTn9BD0
 BN8X7MBYe/oYhlZ4xU1HWQtQuCIUTHvO6sdGNM4UfiRetewDd2aoQo4F27cYpcq5GT9S
 q0mmGY+uLPCRXCPIuiP34uTpY4llu2li8TcRMU2v35S5KVZYxyHdeGr8/qgK4BQrBRX7
 MKJJSYeG3K0Zf5CsPKOUxCfG+A63EhuI9fpwTlwRKfr7nW4dbhFrbuxZFJ9H2s08Pciy
 RV3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ93etamSWVt+QU7U9D+lVuoMnd7Mell5uViOwC7WCYYFJPWeWGFwI4pN2Pa9D6YcJhirgOGZb2T@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfiUFqx8eV6QLLBt8rEQqiqSuAWpyEJVFHS6Ivaf5TKs0bxkK3
 BMUEPB+20MpXaWR+huviaRzQbg3+SgZjzAKilY7wF1DxVCNPWqC7rjtnogJ+bxlqUc/ySiTK1ZD
 qBOuOxCuhdBR3e4Xk/NyWrU+KIzetD7SCaL98AqJyAw==
X-Gm-Gg: Acq92OHj/WWiplUPh+2hCKybR6iDw8C1npOXDdppmwH8addM3nF3mWxr5i8YvVN2O1S
 p0Gu0T/cUOVGeVyc3Dtf+IQoeOyn7MFPQSRNEL2Jw+RM5aqrCDiSABq71L86NFdu+Lo5UcIRL0/
 gEvSVW3yVmEr8hzv+qc/mhYhGIPOOAT7q8Jy9lXzYnilsXm01KAc2TwenmuVe8rAgoDk7cAJyjY
 zcV7Gy2IP2racLlQksNGr1/zSFsxRzOrTBLGqWcATIlzU1gBjxJRzmtF/7I5n8bfEkxKY9ypGDf
 WcsBSNgkYJ35QJEZhg==
X-Received: by 2002:a17:90b:3bcb:b0:367:cb53:7435 with SMTP id
 98e67ed59e1d1-370f1525ed1mr21923499a91.24.1781035921449; Tue, 09 Jun 2026
 13:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260609-color-format-v17-0-35739b5782cc@collabora.com>
In-Reply-To: <20260609-color-format-v17-0-35739b5782cc@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Tue, 9 Jun 2026 21:11:46 +0100
X-Gm-Features: AVVi8Cf7R-IrVdYhsGfa6ARvQUl6VjYbn-pxlLXZ6UvxdCSIBKSlKWHfn1zLb40
Message-ID: <CAPj87rNhTViuff5qWeoGkPgyRvP0uOAcUGpcJJPTkPR2b8fJcw@mail.gmail.com>
Subject: Re: [PATCH v17 00/28] Add new general DRM property "color format"
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

Hi Nicolas,

On Tue, 9 Jun 2026 at 13:44, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> this is a follow-up to
> https://lore.kernel.org/all/20250911130739.4936-1-marius.vlad@collabora.com/
> which in of itself is a follow-up to
> https://lore.kernel.org/dri-devel/20240115160554.720247-1-andri@yngvason.is/ where
> a new DRM connector property has been added allowing users to
> force a particular color format.
>
> That in turn was actually also a follow-up from Werner Sembach's posted at
> https://lore.kernel.org/dri-devel/20210630151018.330354-1-wse@tuxedocomputers.com/
>
> As the number of cooks have reached critical mass, I'm hoping I'll be
> the last person to touch this particular series.

Thanks for seeing this through!

I've pushed this now, minus the Intel patches which they can merge
through their own tree. The AMD tree required a pretty trivial
conflict resolution which seems to work OK here.

Cheers,
Daniel
