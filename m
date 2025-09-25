Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 087B0CAC5B1
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Sep 2025 16:09:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2CF310E988;
	Thu, 25 Sep 2025 16:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ag02GAck";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECBB910E988
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 16:09:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C140744C2B
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 16:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3AAC4CEF5
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 16:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1758816581;
 bh=zCtcrsuBl16S6I31ougcBsnGSZmcAbLq4ZcusPx0Xeo=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=ag02GAck+0hOcNvSbDD3t98TIPEmB9zcemvUu3MF3Xn0hFSpxFqeXTaWJS8UaBVqC
 GbLYqkcHmatNfqgQvJTGkTknq9o3a7lXgH7HSGM+mXijnkpCrB/KMjlzy7Rqhc6KmY
 ojBw6Bto1166wxiDdSAJK9tfVS9aWeYq7Vs7fuQSeXHpOH+16P50qAort6cRDq6BE9
 7jvQr72q3eRqm/JNVERMO9DtECwgDLuIiKUYrngBDqrog7As5IKXp0yMeSlUsK61ZR
 a9aVYDthN+k9fa1GafgAsgxUnvjGfBf9JdnX23BHH2ZPcgKN0SoZgMy1tnH1wQwghp
 0CTdMguB004xA==
Received: by mail-oa1-f46.google.com with SMTP id
 586e51a60fabf-3544c64380eso1566507fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Sep 2025 09:09:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUJF/LzG20sQdj7jNBtJFf9PwSjhfoggh8L5vafuotFcIAwsWVKe6WuZtooP3ttwOSLojPHzGSa@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+FLSVubvCePbPXgMDR2/UTA3e1wiGVbbP99TCtaIuUJ1+yadk
 KkajYob5/zMjVwJQpQv7QilReIyT/JjvGv+bktX+6CNCkJoLKE/PmESIStebW6xIljJiHLvGvSS
 BwXYW2z5NJUBJJTJk0kLn88H6ymIjFqE=
X-Google-Smtp-Source: AGHT+IHIN8UrnaqD8qr1Wudy2wO8Ok5pIJHISD78alYXmBu82HeHN3Q+K0AKGLyQGtDsrtLHErvIfF7DXVHzYb9k5JQ=
X-Received: by 2002:a05:6870:8088:b0:315:663f:4056 with SMTP id
 586e51a60fabf-35ebf3edacfmr2060905fac.4.1758816580840; Thu, 25 Sep 2025
 09:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250925155918.2725474-1-superm1@kernel.org>
In-Reply-To: <20250925155918.2725474-1-superm1@kernel.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 25 Sep 2025 18:09:29 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j6dhHRDABa1+c6=oseAsBU9-vqYybo2i0an=LmY4+yxA@mail.gmail.com>
X-Gm-Features: AS18NWBFNpMqasKWvkag2VlE14u7eP65RD0nD1B9kcV676YZr06x8yTnUy-cq8I
Message-ID: <CAJZ5v0j6dhHRDABa1+c6=oseAsBU9-vqYybo2i0an=LmY4+yxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Fixes for hybrid sleep
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Rafael J . Wysocki" <rafael@kernel.org>, 
 Samuel Zhang <guoqing.zhang@amd.com>, 
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, 
 "open list:HIBERNATION (aka Software Suspend,
 aka swsusp)" <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Sep 25, 2025 at 5:59=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Ionut Nechita reported recently a hibernate failure, but in debugging
> the issue it's actually not a hibernate failure; but a hybrid sleep
> failure.
>
> Multiple changes related to the change of when swap is disabled in
> the suspend sequence contribute to the failure.  See the individual
> patches for details.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/4573
>
> NOTE: I realize this is super late in the cycle, so sorry about that,

No worries.

> but I debugged it as fast as I could as soon as I heard about it.
> If it needs to push out to the next cycle it is what it is.

Well, it can go into 6.18.

Fortunately, hybrid sleep isn't too popular with Linux users.

> As it touches two subsystems it either needs to go through linux-pm
> or drm.  Patch 3 has an Ack from Alex, this should merge through
> linux-pm.

Sure.

Thanks!
