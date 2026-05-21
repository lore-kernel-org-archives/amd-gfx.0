Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5881BCD5BB1
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 14:13:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D198810E528;
	Thu, 21 May 2026 14:13:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="B0KS206S";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60D1710F339
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 14:13:11 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-83ec36a13e9so2957959b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 07:13:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779372791; cv=none;
 d=google.com; s=arc-20240605;
 b=Qaymhs0N17nkjtGoce/yqI/c9SyF22/3y8hDaB8vAR+aL+nkojzX+oBTp6m16XcAcu
 GKnIi+KlrYE5nISlBomZw5xHzJ+tBiL5HeE47HMnI2VvY7HRcjzFAXryyge3eVyCMTvk
 vyM2CbHKhs9ELd70uv2qC9ptM5orfCOdyfwLaPOR8ekW6kor19VrtT4wZFBflJGee2Wa
 QZ8tLgZxbg1gGeQHMmeJlKI+uKOUwyp9KRvVP6ewdAgGy5hWPXUZiJS6rp/CGw45mX12
 KM7yelTiiisb5lTINumn6si03G1/MpxZ1cD0sEm9ofYyrCZDkZYgKq6+emiSvzFEi0/U
 N1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=REP4STaURwNBwYLUxnT2eThrBHI2vGspRNmg6btJygo=;
 fh=RDTDrNVjRALLNKpj2mVzJ3iXBCRtMIt9hq+/E29mivo=;
 b=XnuheWKueg2IdqYKIUTi9cwUifYsiXnR3Ah0jz1Ru99VyaZ4tf5brnFUnhTJsVY2cA
 pCoDZu2SHg4eRdX7z/eTgS4HsyNjF8ODyWXoBsm+4vsSmBfRxoGgFNc+24O/XwvgDWYP
 lnuo3vIVmCquTK5P9PPojH0MXxtknEVhFTLQm0aeOd4I0ZuvEe3G/qdw4052HyOLhtSK
 o7wxnCzhUxd/XqfGdzORM4E2gfCEdmWp/qJOyKzIbbYWtBDFS3vc9UUwO4BxnDoDfLXd
 O+DzaOKw2RpiygBiT+cKMb42xStsAIvPnniBi+Px7rL6XRW1VwZIfFaZ2CuyqvaSWQw3
 mfTw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779372791; x=1779977591;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=REP4STaURwNBwYLUxnT2eThrBHI2vGspRNmg6btJygo=;
 b=B0KS206SJCDMlPBj3enN0FsCW+bO+4qoyBjEbW/roKfA8sJwk/nfyATTMyS+9k1Bsc
 F+j7F9k2ubY32CFqKo+cXnsazki1e1I0ster1uIDj8Kyy4sHYuZuBlDMrUX6BCpQIuSW
 Pgb5txZ6LQ53Be20KEG+ZVZN8Uf6ptBqiZqDxwOGJcu8JMOHGhkvpqFT/FA2jmj0+IHM
 OYywnIpcZYYvDnk7z367KV+anBeBUnuGIVtvFj/8dUDCFqBEwaqhHo1JrWYKDpECAt0K
 z14Hb9qOlw8IkC1saAzEr01e/V8QRYPio5xwP/XNk6oko3d7OY1/B5Baj6BS6QwTnLLk
 6zFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779372791; x=1779977591;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REP4STaURwNBwYLUxnT2eThrBHI2vGspRNmg6btJygo=;
 b=a9NqCSia7JEV00AOvayWczoyfRv8S7LviZw2cGMF3/NmqARSg7evlUjNm9p4DBx/6h
 zZGUjpmJibhkDxDh2k9u0wMnCbyEuSC/RLE2dFKLR5A1eQBIMVBzXNwCu+YagC0Yn9cT
 5EtFpvtagREJk83+zJTX6onC+lx2T72kS4hPsSYkgi8HxznWN+2ra2T9XRTPzz8wN5Mz
 avq9+nBCrmUWOZLEF6VzK54UYr11UbXxdGzA5zCCV7ZxlgMPg/1VifykXwwzuVhjg556
 GD5yX8M9/ezR7Enx4T1+P5vueSz/LYcKg0Fh1tyjAjBPTS3JYDh6pnIPd4LU7+G54cBt
 kMRQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yD+9b8oZ0tAYWG3G5UTSjdsq3wLm2Xzinvey7a6/iJLMptZQZhpmEVj+SJrHzwVZQy04dAb45@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxXdXMSI9RT9N7EOyk+3RCfw/CyiaCL0C1GHusNhxos2BFtqjYO
 Dw9sE2LzU3xYuhFRLxG562DOPD2ixpHTfTYjEUC9tBq5hxF4o/ER+qgL7UguNs3Kp41j5mMlT9s
 PbNvk+uBNojLyp2GjDBVsQ/9idINsuXQXPB3nVSgi1w==
X-Gm-Gg: Acq92OHNBcFbY+/urAwm1pBluJNOBU7XI3EMP3JpYchirTpo38JFU5lT9FbqB+uTdgs
 vSOZVmse20Hv7kJW132YlFckSg3IgBu9o0NYk3Es3XPMAgnTXc5vP7WU1ZrMEtp2AW2b78Sf1v/
 UbqzdqdT/kts0ExFDmzVwOsHJv4gyRuh+lLAA9GJRRF6CzEcVWhFNSefqf41cXXYjEXeGx62Fi5
 jLyYTLmQLVD4XuhOJAiDm0vwe+fIQp4H9Zj89SPU94cYG/oWTfETmdeNkjTaUkvbfbpN+80uSa8
 pGFClxH9Y8nnauOy5IN74LnVBL45W7nb9sqsp38=
X-Received: by 2002:a05:6a00:170c:b0:83f:2568:d45f with SMTP id
 d2e1a72fcca58-8414ae0067emr3410992b3a.23.1779372790773; Thu, 21 May 2026
 07:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
 <20260423-color-format-v14-3-449a419ccbd4@collabora.com>
In-Reply-To: <20260423-color-format-v14-3-449a419ccbd4@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 21 May 2026 15:12:59 +0100
X-Gm-Features: AVHnY4IhuE52xfR4O7ZsBvGU9UxEW_nGPaKeUuOJKbLW6yd-ftNZQIcte9EpFTU
Message-ID: <CAPj87rOgkSAhVzzHyuKEGPxVYeDhJKLGVNrBA2BkG00gvMJjYQ@mail.gmail.com>
Subject: Re: [PATCH v14 03/28] drm: Add new general DRM property "color format"
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
 Andri Yngvason <andri@yngvason.is>, Marius Vlad <marius.vlad@collabora.com>
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

Hi,

On Thu, 23 Apr 2026 at 20:04, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> +       } else if (property == connector->color_format_property) {
> +               if (val > INT_MAX || !drm_connector_color_format_valid(val)) {
> +                       drm_dbg_atomic(connector->dev,
> +                                      "[CONNECTOR:%d:%s] unknown color format %llu\n",
> +                                      connector->base.id, connector->name, val);
> +                       return -EINVAL;
> +               }

Shouldn't this already be ensured by drm_property_change_valid_get()?

Cheers,
Daniel
