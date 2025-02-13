Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D13C021A0
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 22:55:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FF8F10E00F;
	Thu, 13 Feb 2025 22:55:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="PApAhFl+";
	dkim-atps=neutral
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com
 [209.85.208.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9837E10E139
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 22:55:52 +0000 (UTC)
Received: by mail-lj1-f169.google.com with SMTP id
 38308e7fff4ca-308f32984bdso12293421fa.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 14:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739487350; x=1740092150; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/24JPm7Fd6JZXHQpZIKrpL+icINzVWbUkAHKK0IjNBo=;
 b=PApAhFl+WAJBbDRiuIMDGfSxZs1NyNlXtLIGaUH9frMFOCKzIrOlqpi5qpjCVAik5H
 Of5xw4GPIBaxTYtuHe0Hm9UK+6yYE0kfMb9RDZSfGsnKBxRuoO+1nan5hFoMnjnxGhBg
 tpJcLEJbw2ZZOGM2Pgw/iSU6w6Q3AHX6WP3IGwn+NROLIZ66xCQDQtXTjTAOAYqGnT+O
 FvGOycb+TcAOhadR+l2tRiZTM423DsYDYByqXF41/5BvCd59fyLGBR4tCnOP/dquGgKT
 6dyEuZE6qSjnkz5kGmKYQ6tZ7AWLt5/G/bUgYIAXcsrTbbtebh1tYy7QSMlzL3kc8Tpg
 LMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739487350; x=1740092150;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/24JPm7Fd6JZXHQpZIKrpL+icINzVWbUkAHKK0IjNBo=;
 b=ge6E+xh45fQNqdws/K9RvY28SKuMDiadUTAunpcJlNWtqwudwy719cIoX8aEbNXEo3
 FIsXt7VAiI54gXTY7920BAHfHDUTssv/oAlwiCo/+GYCYCV9TjnQjsLQH2qghrMceJim
 o0lPFY8QyRQqmqn+A4hLo4zTfkHxeXqnrNaZwJU7Koepw0CO+END8WetrrT0bP/kPfsw
 qYUwiHSL1YGnW5EFc5tKPFKA0t6gI3uoJdVzXeN2f1SNrUFUC42m/YK0HU897PCZQ8sO
 Iw7rw/hJa9mrIxfXFydkIFFEfWtCfadl4ioa2RaZRZYjpCKkYQpz9UGtEiazxtvyK2In
 PWdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0ycv1FS6+Bg4Pz3McaDbgZFzS/myRsS6S6MB1FKG+/kXunLrH8iy2pxXYcr8HoTwjbaZjPutB@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8a3xgdrXSXjprQVFwKM8VZOmn9DyW9DCTrwObFcINNTFZe5CI
 LWbCCCQcEUxlJuE0AaKMERbmnmaxmneIGvCdXlP6Q2lSeM5rNyT7/KvaubzTtnE=
X-Gm-Gg: ASbGncv8SLJ75Jk33NQIG915I68R7oB2Cse6Uah0lW9JIC3j59P3Iozy14C2PRE6V0C
 TpxZZTRl1RpJA55PC7bYe1xXFWNtZQZm046OQ5Sa3P0qXHjQIOkkmFDgiu02pHK9DPkwzwIc7es
 YTv6AlzDRgDpKmO9n7ORRwQTG7/KGb6prKR1+zlbYUcqhe27148Bcl1RGdxVy8KomwH6vhWJZUO
 Q/yyEajpvWZ6IVfCSWCOVpxKtU398L8/yAv0qdEfehQVDPu46T5EQcGG0Unm0/HRrp6ikOFwk/V
 K64n3Hg3VqEEKcC8xJh+QDrAYG6vnMbPCZB0Jb26fFRYuqXYsMD5fs6ogT0=
X-Google-Smtp-Source: AGHT+IEZ1626++5xMDHpo0WMOzC0N7lgwh+1qvbo5fUuwYvi+B3DfqXZdqPho8NHik66LI3m5T0N+w==
X-Received: by 2002:a2e:be20:0:b0:308:f6cf:362e with SMTP id
 38308e7fff4ca-3090dc65edfmr18377611fa.4.1739487350464; 
 Thu, 13 Feb 2025 14:55:50 -0800 (PST)
Received: from eriador.lan (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi.
 [2001:14ba:a0c3:3a00::7a1]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3091011d566sm3377011fa.46.2025.02.13.14.55.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:55:49 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, Simon Ser <contact@emersion.fr>,
 joshua@froggi.es, Xaver Hugl <xaver.hugl@gmail.com>,
 Daniel Stone <daniel@fooishbar.org>, ville.syrjala@linux.intel.com,
 =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Christopher Snowhill <chris@kode54.net>
Subject: Re: [PATCH v12 0/2] drm/atomic: Ease async flip restrictions
Date: Fri, 14 Feb 2025 00:55:45 +0200
Message-ID: <173948734065.719858.7405160715916126757.b4-ty@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250127-tonyk-async_flip-v12-0-0f7f8a8610d3@igalia.com>
References: <20250127-tonyk-async_flip-v12-0-0f7f8a8610d3@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Mon, 27 Jan 2025 16:59:38 -0300, André Almeida wrote:
> The goal of this work is to find a nice way to allow amdgpu to perform
> async page flips in the overlay plane as well, not only on the primary
> one. Currently, when using the atomic uAPI, this is the only type of
> plane allowed to do async flips, and every driver accepts it.
> 
> This patchset re-uses the per-plane function atomic_async_check() to
> this purpose, so drivers can allow different plane types. There's a
> `bool flip` parameter so the atomic_async_check() can do different
> decisions if it's a complete page flip or a plane update.
> 
> [...]

Applied to drm-misc-next, thanks!

[1/2] drm/atomic: Let drivers decide which planes to async flip
      commit: fd40a63c63a182aeea1089a343e2f729de7e514d
[2/2] drm/amdgpu: Enable async flip on overlay planes
      commit: 41129e236f14c6c54145c722da06f6793e9fd13d

Best regards,
-- 
With best wishes
Dmitry

