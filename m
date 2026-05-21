Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2786BCD5BAC
	for <amd-gfx@archiver.kernel.org>; Thu, 21 May 2026 14:41:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 351F310F340;
	Thu, 21 May 2026 14:41:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=fooishbar.org header.i=@fooishbar.org header.b="fpPt8P12";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E55C10F35F
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 14:41:01 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-c795f441ff7so4928974a12.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 May 2026 07:41:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779374461; cv=none;
 d=google.com; s=arc-20240605;
 b=CUD/suBtfKfH+wAcsClyoBoBIYabLVeHxI5Q6TvOrpx9VaUeL7OR29sCitn4IsXVfF
 PzyUrrLS0fS1RiiCGfz5gnSM7meMhyjDYgJIXVzlWcb4qdvenvqXO/DwOwqNsjoSiN5Z
 dgrgtdshklYkiItreVPmi1uLMcgISQNtx6Ox3uJKr7t97slGKqWfX6MIrfdwfAsV12hQ
 vD4UDpRuiBRnrPhkqnOBfyOczfXcM4/rfaC6qSvEuVSaCa4l1RdP7p6CaUflj//cLvgh
 BRoLQr50WSmjWRgKOSkK0lQiTZui6z6OXkFMHHRlpClzsPlTO4ktDbS8/T8jgIMQp0G6
 IICg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=RI8RcJrMlrGpgo/P0j5rPAmC/BUqQ0jZHOTebzV+Hvs=;
 fh=ePeeTxdeeILPbLjw/y2KxNVaKkOzjaEgiTISwsMiULc=;
 b=D487kCO85vY33mjCwmunjmQg8lEQR0038RvVXorxVU7Yd1oaWLOiDlMLAGIx5A0dOg
 KWH9JHWlCQze9+IVB+8qgRLYR6XPeH2Zvq+LGxuW7YXm3zgW+Aaw1oFFdPco4AHUnhWJ
 vUcJ+QUegTZnE/3s0fohC4HaQv8rlr2IHPNX8h5KsJaZQrgodzwxDlSeV79Yl8ky2nmJ
 MsR1FDVvWkIfwFqG/RBo77GxGeD4nvc4wvms7AdMOFrHencUFRlmgUSPM+OL7fqBhPIR
 XhSad1v2vK8nYnSwJVJ4NBTtt00IdQ1KrjFx4iBIzEuMfrrK4d4nNhqSiY6m2CDcyPV6
 1tYA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fooishbar.org; s=google; t=1779374461; x=1779979261;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RI8RcJrMlrGpgo/P0j5rPAmC/BUqQ0jZHOTebzV+Hvs=;
 b=fpPt8P12fUNdMUXb8E4v259pENQikVsG8rYsQX6klE1idNU7TA3Wk5GZPOs2b7o7zm
 Xnrpaw0VzDMnV4nBB5dDvF/L41ZV8nclP0R6AE4yfyZPy7LhGft291pLTtSy0bVi8Gd0
 9RWc8Oa7nDq25dIPb8aapdWb9Rdvz2fElhEiGiAh+oTQKyChnTHv+Nrk5ZE80VT9WvPl
 J0IoNIjOB/JFLhjSv0rCuarR1wv0Wk1BfmdY+2gGNRcCrHFTiJGyYhbDyIDw8WP0Ocg8
 BlGJxSS79Cc7MXZ7k0NMtOUM13msZFeKwV9q/NCKE2igzXuQNa2shRDjz95xSWZfCE31
 X1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374461; x=1779979261;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RI8RcJrMlrGpgo/P0j5rPAmC/BUqQ0jZHOTebzV+Hvs=;
 b=RgbTTqA4tZWFEzgx7E8f9EKTOhGBQ9Vj7RKCBugrH1y1QljJSqU4Wtu4k8afy2V5+t
 StQNdkFcsjNlg0Lv/XLoOH36m19X3JcHR32UsYIN7wemyS2/MIyy4e79rK8DkDUomWAE
 2lVEretSRkgCVcQniZRGfI6ChnVLe66ow4aEbkC0p2pTqx7BV6tlDzTOiyYmgheP7Q7l
 sUHlc8qG10OlxwQhh7L+jjzWdqwqCRhTdKOLj/CMM1J/YI/HQBSHlsU8VEN66x1MLJoe
 fkrdX5t1x9MPzziVWHi/YfyIWki2V3L2OFXTl6pYmCjuJ88oho7KGAr5HegrKHaz7W8w
 Czjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JHaRYB6g508QGs4/gaIkmMkip+LHiGF28MGbKAxnLcb82miO00yPfoQuaQA4iqIbMEhmLwFco@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzM50dgdpdNXBds7momNpkcEq+O9Gm88FT0FQlFph5fSWbjvdL6
 PvVWYXqRndCeyEmvquUrdaEgIeFi5Vq6Vg6ha2FBWG3N8FLz5BrRCrQBJMxzdC/NTAnBxIt/52d
 NSkzBQZXm59lyZx1TnhMmvwXwu8Ula/GFBrTcB4d5yQ==
X-Gm-Gg: Acq92OEKJoLGTYlvik0mKccC/3UM7a8NiPel+lGY4yi/e5N2VxnsiK3OQ7W1Knuxg1A
 a65QcyJla2a406wNw35gx02SMkSmuaUZ3vN1URYdZ7+jFK7ntRfYt3ceVciSfsNZWz/B0uGrGzD
 yDpHLdQKOvEgpH9nUvotyiAKvP8N5jDM9W2hw3mkeSTxYSWb+BI7G0F9G8hKg23grxJhgB3JWQW
 sV0bG3i5xhsz6ZqLZ4pe46kYmpb0k0P/+9jBxFm8h50zFY8pVjbMIiyQXPGTykjlfpEPPJ0RsIQ
 qFkQIcMy1Tf5YdfjroHEFhBi2B2fwJuOZvvREsUHj0P9zay5Lw==
X-Received: by 2002:a17:903:1b10:b0:2bc:e62a:979b with SMTP id
 d9443c01a7336-2bea33d166emr36661465ad.30.1779374460988; Thu, 21 May 2026
 07:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260423-color-format-v14-0-449a419ccbd4@collabora.com>
 <20260423-color-format-v14-20-449a419ccbd4@collabora.com>
In-Reply-To: <20260423-color-format-v14-20-449a419ccbd4@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Thu, 21 May 2026 15:40:49 +0100
X-Gm-Features: AVHnY4LM5MR-pydhp54-iciGhQnPfxKOlxWC92SZdhfzMOyTtShVga8wCcjC3D0
Message-ID: <CAPj87rOBvjw4v+PER+6+FMuDRajXNnPSKAke8a=tVgiSRg8QTg@mail.gmail.com>
Subject: Re: [PATCH v14 20/28] drm/rockchip: dw_hdmi_qp: Implement "color
 format" DRM property
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
 wayland-devel@lists.freedesktop.org, 
 Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
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

On Thu, 23 Apr 2026 at 20:06, Nicolas Frattaroli
<nicolas.frattaroli@collabora.com> wrote:
> +       bridge = drm_bridge_chain_get_first_bridge(encoder);
> +       if (!bridge)
> +               return 0;
> +
> +       bstate = drm_atomic_get_bridge_state(conn_state->state, bridge);
> +       if (!bstate)
> +               return 0;

IS_ERR() + PTR_ERR()

Cheers,
Daniel
