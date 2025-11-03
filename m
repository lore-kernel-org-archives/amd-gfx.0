Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D486BCCFA00
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 08:30:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B5F610E549;
	Tue,  4 Nov 2025 08:30:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="CoFfnFQO";
	dkim-atps=neutral
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9EF710E417
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 15:01:27 +0000 (UTC)
Received: by mail-lf1-f54.google.com with SMTP id
 2adb3069b0e04-5943421baa6so32584e87.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 07:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1762182086; x=1762786886; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wFTnq7/AvjAJd1O0uQ5fE6zbW25tzv8iQUb4vGr8AYI=;
 b=CoFfnFQOQ38Px6/jNvdeIJ7BAndsI3OEzt165V5c+23UL2DffWCogf/djaQohRyilB
 uTqVOl7s7TRReNhq+AriWvjM96r1JpQSfOo97v/UR8oHbLdPr1swAQ8h7xkKX/GDDq5O
 fBDthlc7nMa7WdF5x8WdsrSD2UWeZ7a9x3U+5fZNfhx0cDCaSNLj6aassCASpxZTLxrD
 cvvN/nckAkKD+akIg18ntEGxZ6V7fwrdx0hBhklsZa5C7pz2SAb0xACYpj3NjZ2MV/vu
 S9SDUJK3Tpvtywn4V6iZ/UUHsd4Aqbn7g/+7wfmuXWkRcWMpus1EZ+yOPrDmvS0Uf1TB
 Zy5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762182086; x=1762786886;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wFTnq7/AvjAJd1O0uQ5fE6zbW25tzv8iQUb4vGr8AYI=;
 b=QQeZyPPvCl0Bz/XburS8bromfvu1z7373A2h26oyP1DrDcirQmpwiPjKxz04N+OhB8
 CR47fJqLxD0W+02N8zgSDbdU6lab8pfIItixuzMalN1Djwtlhvy8k1W5xUDqnF+E9Vxg
 zv1XQd2jNUYWrj3u3TKN1zIODLrQ5grFT4u2lWdsYEvZinSbbR/EmfMR7Lfe1a7v2hMC
 kZcBEXyn4LsoGNevjg0dPUf+JJZ9uv3UGa/Q4k1Sodonst2/RfFALOnCm/t1kyXOjErK
 w8+a0YDHhvxgYnCS27kBbVpwHgj/rC0mpEgOEkPphvlrvtPSj4y8U8hWUZhskDSQw8LQ
 Jx2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVppKcQpZkUTjI74MJfdRwj92wwl3iyYMs02kQSVi53kWHzLh0Wrc93u5XJVPNLjITS70rU05tD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzU1UgKFYz+3vh5fRDfShWumSL2A0zC7YVA2IZC9cvSNlzLtmDK
 MZZCxk1L7o6aiUjGl04N+2H2g0mfbs6IHVAGKgfIZZasHI1yqANOWbLjIJOyxvQNfHTvQ34SPig
 t9JGbssafYdawiY/dAWUFa9IZp6Aj4ifNh3p9aobeEg==
X-Gm-Gg: ASbGncshbNT2bHOlHoE0lWY440JgTLXxY6tgSe5pNE/WSvwd79TPzCc1XW1us/lO+g2
 7wdJtfyCaC0puT0GB7gyNFpueygO/Ia1J3TfjX77hBmHkucVI9i6oW8R2aRmaWlgEJYdHl8Osya
 pBgR4cVatQYpMoIWn5kbSG0/cbAIicN+ipOMhQHbmGDmFx7jdgWvagnAM1h9EvLceQBUAGlCYh8
 UWJBIWtIqwmsnRQC2DR5mlHlvJPv5cQ5E/YMfm38DQUjfakGRiQw/El3rMYxnzvZNklTNWCfaxr
 A3WXTKAExuCTDulNP2CrstXw6LEn
X-Google-Smtp-Source: AGHT+IFa4Mg43fDyhq8XGqcAaXzT3DThyrNii6w4o7OGlqUmCCShlNd2QaVTebvbSElp7vVfURXPMK55scLnEN7av9g=
X-Received: by 2002:ac2:4e0f:0:b0:55f:7328:f6ae with SMTP id
 2adb3069b0e04-5941d554d76mr5114757e87.51.1762182081490; Mon, 03 Nov 2025
 07:01:21 -0800 (PST)
MIME-Version: 1.0
References: <20251030161011.282924-1-marco.crivellari@suse.com>
 <20251030161011.282924-4-marco.crivellari@suse.com>
 <690b3fd0-20a1-4245-8fc4-4e8b40695c98@amd.com>
 <CAAofZF4V7gN=AqgLwcva+zhJyROYfSjzJ2uLxoNeS2KLuytW9Q@mail.gmail.com>
 <42c631c7-7773-b029-6d59-a54112363a71@amd.com>
In-Reply-To: <42c631c7-7773-b029-6d59-a54112363a71@amd.com>
From: Marco Crivellari <marco.crivellari@suse.com>
Date: Mon, 3 Nov 2025 16:01:09 +0100
X-Gm-Features: AWmQ_blJWZ1gR4hPVHrfeQXQvGwYLwKy_C2JeMo72mgp-bqvi56gDubAhgPoPh4
Message-ID: <CAAofZF4Q6MAg0ob4nJEGXkHd0KnDPgOsATcguER6mAmD7CD6Vg@mail.gmail.com>
Subject: Re: [PATCH 3/4] amd/amdkfd: WQ_PERCPU added to alloc_workqueue users
To: Philip Yang <yangp@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Tejun Heo <tj@kernel.org>, 
 Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, "Yang, Philip" <Philip.Yang@amd.com>, 
 "Kuehling, Felix" <Felix.Kuehling@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 04 Nov 2025 08:30:34 +0000
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

On Fri, Oct 31, 2025 at 2:12=E2=80=AFPM Philip Yang <yangp@amd.com> wrote:
> Hi,
>
> WQ_UNBOUND is more appropriate here, to execute the KFD release work imme=
diately as long as CPU resource is available, not specific to the CPU that =
kfd_unref_process the last process refcount.

Hi,

I will do what you suggest.

Thank you!

--=20

Marco Crivellari

L3 Support Engineer, Technology & Product
