Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F907E94615
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Feb 2026 22:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6462C10E378;
	Mon,  9 Feb 2026 22:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJhfrPWf";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96C7210E378
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Feb 2026 22:10:43 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-43284ed32a0so3366542f8f.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Feb 2026 14:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770675042; x=1771279842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F/vjRwFAaVe2K7jHSLCI92bN2otMBpCwz/MkKTO99GM=;
 b=KJhfrPWfvnu2g02XG+/KMzrwMdHKmg8Slqk9s2jg0/a67OBVden8IAGYqIaCOAfmTS
 dr3iUOYrjM8u5aw+ON63cLstkVS+AKcagF45rQUCoGyELtLBdZSG8LYqRIImthB+1BGb
 FzDu+SoNOixP+aJbO7dhZNOTW1tuTzHA7ZtdBVXDmaAo9Gh7J9/ooZwSPeI+9M7nK6Qy
 cGsc/H4lhpXaAu/th3gr5PEXKu6gnXy4J0ZlHAt1tiDMYeJ3xwMRKrgXuu2zmKrFGwtj
 LTrE0PIu0rAN48LKk9lpSpe2rU92IXI3YIlCq++vBOlbu+QlksyRMZc5oEOaMiNmKD7f
 nLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770675042; x=1771279842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F/vjRwFAaVe2K7jHSLCI92bN2otMBpCwz/MkKTO99GM=;
 b=G9tn/Lp+/uAF8aMF2rswdlm/6/heUP23eIsZLw2ZDGzmw0HxAGQziRealDeyUvlAxw
 zqiWB9ztTRGNgTJdo6sdIjy8iCooYHbUfp4RRe0xeHwpMqIuNqyQjNlRok/GLFYNLiDw
 /t4tEP5zF1epMl6xwfL4BNovHJ5Y7q0ysEMEFbtXMXt9PNiedGuK2bPZMA8QGu9vzNrV
 jRgnq9JV/pIX9oXlJg/8NEg44QOMt37SVzjJ4huo5bIM3/zDsGqNByiUBjFXIM2z61Ns
 IRHIvB0vs8RedklU7kIGVh/famK9/CbXRyNtHzMBLo1oGuCaIyGwtUhrolqRxFIoWwbR
 JEeA==
X-Gm-Message-State: AOJu0YxG78cmtAemLOwUn5YbxsVyvBAhmshENf5IOwrVkG71YwvsRXQj
 SZW3sbg0gJb/4k5o/VtXDlAW9WEysdAa0EdBlfh9813/b5h2xGL6x5U9
X-Gm-Gg: AZuq6aI9AUAgaUzo/iXvp+2pX+R2zfGoZjWSfumvvJODRvDQ5SMxYiA1r8CmRnbKl9e
 UOzhriIQ1MOVOVPQBXBNqaztG1vng8SLU6dZavlVFXkm8zLLr2A42pVoZk7mNRMj2J6q770s9gl
 zibrjXBxlrQS5W94z0JYCyqRVUSuUzOWN1V0zOtn+H0fms0Z+BRVv1hx7Evgq4VpMircsTDthwV
 Qb2S0eA4rx4sYgAeUUSgCmL5ZCEzMCxxuxj/ZwlxYo0BNVmXi5z7rwxrIkh8vKmR47RyV+zCTdx
 eCoKFX7e/Iy09HcTky+63PV0Jmq6oE8DobY1Lo4zvorGy0R4qxKlk1wjNzItQWjJVmfyBQL2+f8
 Rs76dwmdbEDgZzM7GRWnHUD1jhvpTSj6yO/dkhjvBJq9qlwDoxeRCsfpfJkN7/HJqRbvmFN+MBa
 R2i81N2aoJzSwNC22hJYzeESQiO6tBII23NnifD6rOMArO33Nps9QeHXgcg6wDyrJ7m7eY+og=
X-Received: by 2002:a5d:5c84:0:b0:437:719d:a740 with SMTP id
 ffacd0b85a97d-4377a59e618mr152239f8f.49.1770675041885; 
 Mon, 09 Feb 2026 14:10:41 -0800 (PST)
Received: from timur-hyperion.localnet (5E1BC3D9.dsl.pool.telekom.hu.
 [94.27.195.217]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43637e31a01sm20559378f8f.27.2026.02.09.14.10.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 14:10:41 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Rodrigo Siqueira <siqueira@igalia.com>,
 "ChiaHsuan Chung (Tom)" <ChiaHsuan.Chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian.Koenig@amd.com, Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Ray Wu <Ray.Wu@amd.com>
Subject: Re: [PATCH 00/14] drm/amd/display: Add support for external DP bridge
 encoders in DC
Date: Mon, 09 Feb 2026 23:10:40 +0100
Message-ID: <4945608.vXUDI8C0e8@timur-hyperion>
In-Reply-To: <b98dca3d-15b3-4202-94eb-cd4063ec12a5@amd.com>
References: <20260126210837.21885-1-timur.kristof@gmail.com>
 <aYn9dPS0R5lh7hQO@atmagalia>
 <b98dca3d-15b3-4202-94eb-cd4063ec12a5@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Monday, February 9, 2026 7:12:23=E2=80=AFPM Central European Standard Ti=
me Alex=20
Hung wrote:
> On 2/9/26 08:35, Rodrigo Siqueira wrote:
> >=20
> > Hi Alex, Dan, Tom,
> >=20
> > This series is the last to enable amdgpu as the default for all GFX7
> > GPUs. In this sense, could you include this series in the weekly
> > promotion to check whether everything looks ok from a feature
> > perspective?
>=20
> This series was included in promotion test in previous week and no
> issues were found. However, it breaks CI tests and we will figure out
> what the causes are.
>=20

Hi,

Can you say which tests are broken, and on which GPUs?
And which patch of the series is responsible?

Thanks,
Timur





