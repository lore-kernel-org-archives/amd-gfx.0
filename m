Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2870C25B7B
	for <amd-gfx@archiver.kernel.org>; Sun, 19 May 2024 10:46:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3123D10E15E;
	Sun, 19 May 2024 10:46:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Vi5TTRYP";
	dkim-atps=neutral
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com
 [209.85.221.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED75110EF31
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 17:27:03 +0000 (UTC)
Received: by mail-vk1-f181.google.com with SMTP id
 71dfb90a1353d-4df97a50d1aso380729e0c.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 10:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1715966822; x=1716571622;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZcxVTcFh7NO1RmeggMzvCad9BHQKhjKuD/Oz3pjme8o=;
 b=Vi5TTRYPdDcDbEpTz3HufKCCjcL9f9ywv1PvuQy5xnXDEemvLozmW8Ls/zI8X6B6nt
 bSnGExaA7LDG9FnokD3k6q0ItVhAlSqD+Y1FCrczj4ZV6bBrYJocYPXc/eWLbDgxcRY9
 0IDtTY6qcKDo5X3FS+rFHKhoTbBE77bV2fSFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715966822; x=1716571622;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZcxVTcFh7NO1RmeggMzvCad9BHQKhjKuD/Oz3pjme8o=;
 b=D0uBY44iQiO/MrNbK9MHBKfmVmnZFxwvHVOGd1mBOOhlL2HelDbS2NZ5v88k4/qbys
 MLynwx3EKgT9J//7VudWvFXO3Z/Z/T6jZI+yK1g8ABRtcdp6FgzCpw+flzdTGUeezXml
 CCiSZqo0U64Xb35/texNQieloJBcY4ioeo+lnUaBLBR0d+sr3cjR6hzTr/DyZ113GfNg
 hZRVnXbXE2RKA3wIVLZdn6kQf2YlQEDQX3qD9Oz83GTRlBFpoecOAg8TO+GqTINGBC9m
 16irRbeHrj2SdBdj5JSUljHHlH4TKtiwz8TIpsKUiWiKOd3TgAFfjOpw+LRW9OeoB9Tw
 9Xng==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQCim+nCXF+jmHc3sRdO6IapCZ8EHI3lx8S3rFrceA6/nQBLsOzIBqgxVlsGxRQxivwXitvna8azHxZ50M7nFa6y9k9WPpdClgCj/6fQ==
X-Gm-Message-State: AOJu0YxNuScX37JtXsGBrIvTmi3tmGj8QFUE8+/aBmdeaqtisTXMnwns
 qluBBzIMX9phH1OBSk63pusyqRkJ/oxlcLCl6T/tCCo8WmJjFcAkjnaif1ce9rUdHY/JEgV192b
 flHeLMhJd8xJaddhknaT4AGbt4Oqxbcli2dGD
X-Google-Smtp-Source: AGHT+IElyxDzLSoeVKTnHsADhpEMO/j0Y0exiEY0s5o2jQhNssuaMk0JL5QwXxOtxjka7wlQqKZ7P260uLD752jOyqw=
X-Received: by 2002:a05:6102:14aa:b0:47f:2c10:24e2 with SMTP id
 ada2fe7eead31-48077e5bfaemr26084771137.28.1715966822410; Fri, 17 May 2024
 10:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240516115721.1.I8d413e641239c059d018d46cc569048b813a5d9b@changeid>
 <9dd1cfd1-fe13-4434-a7cc-e14113dcaf53@amd.com>
 <CADnq5_NGLrrFmFHFX2bC7naByJGofEiYQyWvRP6CO4BDFo52TQ@mail.gmail.com>
In-Reply-To: <CADnq5_NGLrrFmFHFX2bC7naByJGofEiYQyWvRP6CO4BDFo52TQ@mail.gmail.com>
From: Tim Van Patten <timvp@chromium.org>
Date: Fri, 17 May 2024 11:26:51 -0600
Message-ID: <CAMaBtwFQxeARGyhVxo+WsYCHgmJNJ7ThjtPcFv=LZqRNJtVxsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Remove GC HW IP 9.3.0 from noretry=1
To: Alex Deucher <alexdeucher@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 LKML <linux-kernel@vger.kernel.org>, alexander.deucher@amd.com, 
 prathyushi.nangia@amd.com, Tim Van Patten <timvp@google.com>, 
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Ikshwaku Chauhan <ikshwaku.chauhan@amd.com>, Le Ma <le.ma@amd.com>, 
 Lijo Lazar <lijo.lazar@amd.com>, Mario Limonciello <mario.limonciello@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Shaoyun.liu" <Shaoyun.liu@amd.com>, 
 Shiwu Zhang <shiwu.zhang@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Sun, 19 May 2024 10:46:43 +0000
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

> Fair enough, but this is also the only gfx9 APU which defaults to
> noretry=1, all of the rest are dGPUs.  I'd argue it should align with
> the other GFX9 APUs or they should all enable noretry=1.

Do you mean we should remove all IP_VERSION(9, X, X) entries from
amdgpu_gmc_noretry_set(), leaving just >= IP_VERSION(10, 3, 0)?
