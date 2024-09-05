Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BCF5CE7AE4
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Sep 2024 07:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E5010E197;
	Fri,  6 Sep 2024 07:37:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OLnnHmQl";
	dkim-atps=neutral
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59DDC10E95E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Sep 2024 22:25:03 +0000 (UTC)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-6d6891012d5so12628607b3.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Sep 2024 15:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725575102; x=1726179902; darn=lists.freedesktop.org;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=zMkX07JSpF4ZTof1kwdmnFdYzjLU84vys3KyrWxvvas=;
 b=OLnnHmQl2t/nETMW6J6c0boHLUQwqIFEnSZdfe8Ao+d0VxKZjHgsSyCq9zlKIkFbM7
 fAAhpPhg0+fjnLqgFW4vu0H2RpCoj1aZMLM5tF7LthF+cBxRFF//liV/qKSXvW15WOPZ
 dteDTCF2kLBU6w8dOzLB4wzpuE1QNssjV34z6EyvBaNwUZFTtGovc/pSxaiZDydv2eGy
 hyO6S/KF7RYnOHrCI8opS9XQyuBN6gz7vvZpiAwubiL0VCqbpBWSg3EWQp7qcwmXyB+v
 a+eqqqLg1hQikwBb5xdLjjeNPJ9hUN/1LJfnQOgrqcah8e8swnZ44JmAMLv/iXUsrHR6
 h0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725575102; x=1726179902;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zMkX07JSpF4ZTof1kwdmnFdYzjLU84vys3KyrWxvvas=;
 b=ui0Yu3U7BF71l2ixHqU1cyFlnBFYqx8KRzueaSrfSyV61XBFVs0eVEhKQxM7Zjh/Aa
 8e0mygt+49PlmSaWla70PXd0tiNZc/y6z0qIENBWovFSWIMvFSvlJYgv3MBdCDiJBj3Y
 qw1wwl9zq7d/20D+XOsEMfniyImBDgVeSPHM5fp40SU8sq5kuNDacnKVG48FAZmhhoul
 gvaVAuun/Z5WD4Sei9H43P929z83uU78ba3MEspZaHFNWadGSMQdr1Ds85KWYcNTXdAy
 ekpCkMDTR+R6ijZaWEx0oxLNCL/DJ4yNHM70eN5xe+SThbtRiMRkTmb2oo0UnnD7DS7N
 X7YA==
X-Gm-Message-State: AOJu0YzWp2wCsLcVqEf0ZTCH36/0q8OM+AfcJLpUMlFcLApUaEDGQBFJ
 gUOMxF1mduz3nxF9ruJ+qtmKk6oV+trFPLgdQE4cZJny1of5ym2Wz6Ov+WIV1Gf0HDXlC4N0PXO
 XpStIntokgKvo0TKhBLqhzLml3jtdaZLh
X-Google-Smtp-Source: AGHT+IH3HJ73tX9qJmA9FwJdWus9tXtzICtsdrG/HVNJ9pw7oaH8Ur91rsnFLiE2nuEcJCKCXkNXULXnat1pFFkOrlE=
X-Received: by 2002:a05:690c:82:b0:6c7:a120:e10f with SMTP id
 00721157ae682-6db452c394dmr6842367b3.29.1725575102034; Thu, 05 Sep 2024
 15:25:02 -0700 (PDT)
MIME-Version: 1.0
From: __- -__ <isapgswell@gmail.com>
Date: Thu, 5 Sep 2024 19:26:08 -0300
Message-ID: <CAN9WMdMfHkadFwrccv2ucnAjMn1u185=n14WmEFFLQqOiEw7aQ@mail.gmail.com>
Subject: [INFO] multi-gpu scenario
To: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="000000000000fd7c8f062166c266"
X-Mailman-Approved-At: Fri, 06 Sep 2024 07:37:13 +0000
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

--000000000000fd7c8f062166c266
Content-Type: text/plain; charset="UTF-8"

Hi,

I am trying to a way we can have a desktop performance compared to
windows/macos on linux where system is optimus-enhanced (nvidia) focused.

I have read about off-screen mesa. So ubuntu has gl_dispatcher strategy,
why not make osmesa defaults and let gl_dispatcher take care of relative
device (nvidia, amd, nvidia) when optimus-enhanced is in set.

On-demand nvidia-prime profile runs Xorg nvidia's vram, ok?
an alternative config says intel/nvidia as default opengl ...

Maybe osmesa (off-screen mesa) default background, when optimus-enhanced is
needed/set, should communicate gl_dispatcher and decision what device take
control could be set. I think it is a good strategy together with envvars.

We could have hybrid-profile (nvidia-prime on-demand) in addition to
powersave (intel/amd) amd performance (nvidia-only)

For testing i have set:
LIBGL_ALWAYS_SOFTWARE=1
GALLIUM_DRIVER=softpipe/llvmpipe

And desktop lag was terrible

Thx

Luiz

--000000000000fd7c8f062166c266
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,<br></div><div><div><br></div><div>I am trying to =
a way we can have a=20
desktop performance compared to windows/macos on linux where system is=20
optimus-enhanced (nvidia) focused.</div><div><br></div><div>I have read abo=
ut <span style=3D"background-color:rgb(255,255,0)">off-screen mesa</span>. =
So ubuntu has gl_dispatcher strategy, why not make <span style=3D"backgroun=
d-color:rgb(255,255,0)">osmesa</span> defaults and let gl_dispatcher take c=
are of relative device (nvidia, amd, nvidia) when optimus-enhanced is in se=
t.</div><div><br></div><div>On-demand nvidia-prime profile runs Xorg nvidia=
&#39;s vram, ok?</div><div>an alternative config says intel/nvidia as defau=
lt opengl ...</div><div><br></div><div>Maybe
 osmesa (off-screen mesa) default background, when optimus-enhanced is=20
needed/set, should communicate gl_dispatcher and decision what device=20
take control could be set. I think it is a good strategy together with=20
envvars.<br></div><div><br></div><div>We could have hybrid-profile (nvidia-=
prime on-demand) in addition to powersave (intel/amd) amd performance (nvid=
ia-only)</div><div><br></div><div>For testing i have set:</div><div>LIBGL_A=
LWAYS_SOFTWARE=3D1<br>GALLIUM_DRIVER=3Dsoftpipe/llvmpipe</div><div><br></di=
v><div>And desktop lag was terrible<br></div><div><br></div><div>Thx</div><=
div><br></div><div>Luiz</div></div></div>

--000000000000fd7c8f062166c266--
