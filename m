Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C21ECD1039E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 08:58:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3C8F10E550;
	Wed, 26 Nov 2025 08:58:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jnj/rJs6";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E341810E43B
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 19:24:46 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-340a5c58bf1so3974644a91.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Nov 2025 11:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764098686; x=1764703486; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uYYYiZz0SmReM2WVzmDcMMopnoo3fMqatd8Put3Ujko=;
 b=Jnj/rJs6noxtPmSt8odR4aDznvW/jWpXv+D4+8dBAPTDPbWG56fpUruhcQTLIM94lC
 mmV8MtmMHym7xJBvFETF/qlI2DlPS9piNbCbmJ8b8QAMk7IGMGowdCp8VflQh6n+KrCu
 0fQSiC1k0akbGDWfVuSiP0aPjeB8P4MmHMcokI3fQf6ViJW7XKR7zMK1YCRtUSXUTJaK
 rmrAlLrHrSu26r8U22vCXjUem7h1+R3OqDIVadCDhoCoAx0+3BgivJFxk15lD1bJp/Xd
 c/BL/6lID8MCIL+T/ggJ/su2LQMhBydB6tVDo43lmWBYixSyNO4Kydia9mPlMn0vY98M
 hyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764098686; x=1764703486;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uYYYiZz0SmReM2WVzmDcMMopnoo3fMqatd8Put3Ujko=;
 b=XgtyDBzZWXqbLv7Xrr4lEyVYiP1pw5tR6biOwGzmtJVAruZ7mDM5sR5F2Rd72S8vhK
 NBTbPwkHTG/HN2a2SEu9GHKSMhUZ4GaIq+VlUAihLSPB6vitytW+pfti3lhnRduEDOpH
 hM+wJ1VCQwRNuxVdj1lvq1nmlcoOpEp1Jn8zyE+M8nV7QwYbBbcy7aqFb2VXwQWxziqd
 lwxp8WtucE1eJkQvB/moxwMImlkCvGDfu5HJliCkLlzyWTMRXvWLWwjLzvfd8RVqUMtC
 ImM9soPxTYO6kdG865Gchh90c164YdwX7Mys8pqZm86uRKB66THHhoTU2bjjK7tnXnnV
 zTwg==
X-Gm-Message-State: AOJu0YyU4wGPlqFc3FrreDmytR4MTDjB0DLb4lnSVSgU7zcZpMy8Z9UY
 g1/mdKa9pkkCICA+m1tjJrqfHtKZWbQ6WsGxl6HFeKQZNumtB7vfjBPbuKh67e+8h9DllL9G6Fn
 yhZTTKO0LCrmpeYFzi1psBbvlXKPrWTQ=
X-Gm-Gg: ASbGncuYRl0Azk1AN+Ei4G6NV7QT/WeM+crqHJB84fMK/oXwD8z85qBRh3TbCYqSoGG
 bvimv8Ar6WfIqVxd6gzSMBPLrNASpuLZChGoaAT41FZMyuztrOXsTn8ZI4lDR9PsCC7tvocqasn
 /JtVEVrZtCbAgQbznCPJLlPwKVLdCQAYC4P0GKNti0nAjFqL/QDLHT/fyUUHNM0rmxxV2oQQe6L
 F+U5qIIzmDMC09QlI3xVKbJgOuh/a/qWbmuLNTa+L18TR3FFnHzUYLbUFApMH6uROqB16uabpWN
 DIPGFLN1Ana049uUWykkBHGR03GK
X-Google-Smtp-Source: AGHT+IFi6FX0Aj7Dh86T2ZqC6fUXpnJafUh00+wTjghISpwtARH+encD3qZHw3ObJMXlXyLwN9jdrsytZFtW8e7akdg=
X-Received: by 2002:a17:90b:5605:b0:340:bc27:97bd with SMTP id
 98e67ed59e1d1-3475ebf93b2mr3596863a91.9.1764098686174; Tue, 25 Nov 2025
 11:24:46 -0800 (PST)
MIME-Version: 1.0
From: Gabriel Almeida <gabrielsousa230@gmail.com>
Date: Tue, 25 Nov 2025 16:24:34 -0300
X-Gm-Features: AWmQ_bkJAYaB8MatGBN2A7o4LmztyMfxCTBs1MC1IhbIclCreR2jAq-f3YfVu-M
Message-ID: <CALsHKmVcdNJ2jNQ8Y8xuVOCPHo-Bekpam=69SbZqCK9-Dw+_Dg@mail.gmail.com>
Subject: [RFC] drm/amdgpu: Discussing conversion from dev_info/warn/err to
 drm_* logging macros
To: lexander.deucher@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/alternative; boundary="00000000000089c9370644703b7b"
X-Mailman-Approved-At: Wed, 26 Nov 2025 08:58:07 +0000
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

--00000000000089c9370644703b7b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I=E2=80=99m currently looking into the task of converting the logging in th=
e AMDGPU
driver from dev_info/dev_warn/dev_err to the drm_*() logging helpers that
include the drm_device parameter. Describe in
https://dri.freedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-f=
unctions-with-drm-device-parameter

Before starting any series of patches, I would like to confirm whether this
conversion is actually desired for the AMDGPU driver and if there are any
specific constraints or concerns regarding this transition.

If the maintainers agree that this migration is wanted, I can begin by
sending
a small set of patches.

Please let me know your thoughts.

Thanks,
Gabriel Almeida

--00000000000089c9370644703b7b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br>I=E2=80=99m currently looking into the task of=
 converting the logging in the AMDGPU<br>driver from dev_info/dev_warn/dev_=
err to the drm_*() logging helpers that<br>include the drm_device parameter=
. Describe in <a href=3D"https://dri.freedesktop.org/docs/drm/gpu/todo.html=
#convert-logging-to-drm-functions-with-drm-device-parameter">https://dri.fr=
eedesktop.org/docs/drm/gpu/todo.html#convert-logging-to-drm-functions-with-=
drm-device-parameter</a><br><br>Before starting any series of patches, I wo=
uld like to confirm whether this<br>conversion is actually desired for the =
AMDGPU driver and if there are any<br>specific constraints or concerns rega=
rding this transition.<br><br>If the maintainers agree that this migration =
is wanted, I can begin by sending<br>a small set of patches.<br><br>Please =
let me know your thoughts.<br><br>Thanks,<br>Gabriel Almeida<br></div></div=
>

--00000000000089c9370644703b7b--
