Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E84CD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 07:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E37E110EAD7;
	Tue, 19 May 2026 07:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="F36ZVhw6";
	dkim-atps=neutral
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A24B810E896
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 14:34:14 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5a858881ad2so3236080e87.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 May 2026 07:34:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779114853; cv=none;
 d=google.com; s=arc-20240605;
 b=brrLE04o9M6ax1JnmQfzr5dbB5cMOaKqw5YsJivmSSDESAUM0obDRjJS5BjulSO58a
 Yfozl2yWv/Yw3zhehSSv8odWlkBF6xJwEaBLrbDF3aDgZAwkjwC8oTirtqpfJLwuwCK2
 cPkUI8lzCGSwrzwxNMLddkOqWM4eKKLJti+xCDG01uatswnWhozDRSNGrxn+y0BlfzKE
 HV3A4dhvmE86qVHKz8Ase3un5vPimd3gMz2GuK4mVeZro8YUkvenWmc8yXK62qGHPmx6
 aJ7YFGQQo6miUZ0O4cvrwUimoRd4x9LOS07gMyOKoeaneGFPlLE87v0DTSiVuAj+Btid
 Oe6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oqRnCaOYWjwDT5cGUR3SD10/guhtfL7tCTBSlh/U3DQ=;
 fh=vz2bWcM9yj3AK4pzEaKoy+QNSDkpZDKQMXbvw22JqHM=;
 b=fVeCqueXUvMsx3TIIHXdKzlBm7H4RMSi6fs/m4F3zj18ngCmG4upC05FYMyMvqNjXA
 EXkSLc3V6mvwQ5ABwym5ZGpY8Z085FOs1UufdmeHOMiCTwwRxgRQz0FzD720iM8DXxjO
 zR0mfMJHykw2Sn+2XASeqdNkRnbvzjdZF/iholBZfNk94Pl6JUxsuhqtsWGGiJrmIS+9
 zEajloi9sXbG5H60Xkbc1lKkaLrbppQsfBHw96jJj0/Fletn287SZyiApwIqzJPyVgAA
 I6VGWBm9WwHtu1WWHGKq1o3If2tpiSfGx92juHDeea9XoJM/H/RM5vqTclNhk18KdODW
 suMA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779114853; x=1779719653; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oqRnCaOYWjwDT5cGUR3SD10/guhtfL7tCTBSlh/U3DQ=;
 b=F36ZVhw6xg24CIwXeGT2xj88RxabskxttZtAPCClxOVgEME3w7F7MsoA++ifwYBAAZ
 9Kl2Dl/toBbChL3luov7kk62Qycd9FS90O2vFYC6OpiBdU7RVSFe53eD+gMVOyYX5OcF
 g5J62gNmNA2nHTd9v0/Pc7oYHlqP7b0PQ6bGYXLDEYA0k9MVvxqTOdYWFThwJF3XRnvw
 O/kx/WvNdTohRU4fYP1Qqst7WwoeG9UjCWjkzplTbc5Ar8BXolM+MDd1BPovL2lVtikV
 mnnF5nmZDodlHQpR6SPbLUo0mslJPXE4p9aN83JTKh3a6B3D6EJaS/AdGHFi3n5tEWvS
 AnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779114853; x=1779719653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oqRnCaOYWjwDT5cGUR3SD10/guhtfL7tCTBSlh/U3DQ=;
 b=nxu3LiP3R1tttZ4FYrFVK/REGlQXiVtG5/Xl3Mg8lcOeEhDQ9lFa5tBdTdqlnfGAwl
 Am8EFPNkCiC2TmOe5FJPb3lfB7woCelgfrWDkvMgiRIFrcYPcZd6BrvhqKM581wAc8Fs
 Sa1liE5Os5UEFW7x5oAOZ2G/Lh4tNgrlL+cdQmB2nJz+JILJw8NuHXGA+aEiMJjcnXiv
 JirSQ6wcKBmlfR1o0tzhD4Llmq91BBMKmC3CSQmzF4Z22COPqYyW4Od/iIWk0jz9JZ6O
 S++iVWeBRUasO4mRqUafHRfpPrWHVbO4CVHz9f0ujTbdQ6N+EN3Pm6jhkgTyrCaCM9gb
 hVdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+6EqSyqxso/RU94LrjTRhFDpXrsVpOo6Pmss3Ip4VvzF6fNY11SQGx/91Zt2/qnDlsL51QGWsG@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyi+0ywUHEwZ4EXftQpMx0+aA+uGqP6bDjZzbc6yGSzLMjakoWf
 5qDfiMKs2Qbn5zg5NbjLxxvRqlt+CBh/WZh9tL7t3aZ0YxEkHPKpLZoT8nTVq52neqLDTl23ez+
 OMORVT9Q5G3c2gQzFliIEkRDPtx7tEemAczgmP4ODfQ==
X-Gm-Gg: Acq92OHaSt6hfFjlZVg/Bt5b9PR5c+sqKj0nqsnAEnyqwYjYSn4qaEWn2TH3EsO0q/b
 4ldwIEwBQkAJha5TDV/4ZS/yMEhHQm3ank1pQbWjoZoLr9PU/IguTopnxUSQZO7cGOzXmErKbhB
 QBsbNFEyrQMIijMrUzNxUAeNa+8Lyv48cW/NMFoTDIVpnrbxrgHbq4UmnWIzKJKk9S3f1nQuTpb
 uC1CKAEtWsxiZMOaE57lbFGwGDCBcbA/kXVY2iAgGSmCdD4N6euFZ0EMPvvcX9wVpK0/nCdhwoc
 +5KVLzhS
X-Received: by 2002:a05:6512:1188:b0:5a1:38c4:4247 with SMTP id
 2adb3069b0e04-5aa0e600127mr4228575e87.1.1779114852958; Mon, 18 May 2026
 07:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260514103815.190628-1-marco.crivellari@suse.com>
 <20260514103815.190628-3-marco.crivellari@suse.com>
 <CADnq5_OZG_vsEuUWgTPJtz-4zf4s=bA9Q_r9-w+KMQVa4RkMzQ@mail.gmail.com>
In-Reply-To: <CADnq5_OZG_vsEuUWgTPJtz-4zf4s=bA9Q_r9-w+KMQVa4RkMzQ@mail.gmail.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 18 May 2026 16:34:01 +0200
X-Gm-Features: AVHnY4K214WNU2hBJ6vCTO-QsPeLak87wQZy7EGptiTlpMvsh_X5QK980jqHruw
Message-ID: <CAAofZF62w01GpNOQoSunLFboC=FXihb05rKNtZ1S9hQL4zEuGg@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Replace use of system_unbound_wq with
 system_dfl_wq
To: Alex Deucher <alexdeucher@gmail.com>
Cc: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Alex Deucher <alexander.deucher@amd.com>,
 Christian Konig <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 19 May 2026 07:27:26 +0000
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

On Mon, May 18, 2026 at 4:26=E2=80=AFPM Alex Deucher <alexdeucher@gmail.com=
> wrote:
> [...]
> Applied the series.  Thanks!

Many thanks!

--=20

Marco Crivellari

SUSE Labs
