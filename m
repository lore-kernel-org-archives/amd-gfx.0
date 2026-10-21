Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9E606A32A
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=n9Nle2Yk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21E2110FE19;
	Wed, 21 Oct 2026 13:38:45 +0000 (UTC)
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D1EE10FE19
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:38:38 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-35e8253292cso50416eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:38:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792589917; cv=none;
 d=google.com; s=arc-20260327;
 b=MVjgW0Yp660ujKmt4yAKBJx1oXAcSVd+1lsaMrp0Cbg5deO2BsoGVv8qz0AlpZQZWM
 pqw0ayELKXlXv6gcsg8MhX09gnLHp3R71r330kV/QYd8eTdKs6ZbzX2ALdSfkIoHJmPj
 R6uTEQ/B7uZFpDxcfKVIRXzMO7V4piLbZ2iQLM0hSMPK0YtD+1npSyZIq8uzdxkOGqkP
 tz/3XCLCfFrFDZrVseKdnd/4lJM21TgFXhMAcdSifJrgUaMeawQnBKRlETCOqUgbmj8l
 8pVE8D9wEdxgPGTHo6i4Ux/2VxO6Oiwdg6GH5mUgmu8F7WsDNHhceEV6oushSkSOWdp1
 GRIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9KBIwDVjRljfoYY8ykEzS0lIIojLvcnZtZ21HGXYQHQ=;
 fh=lpFZGMGMCMk0E9yvl40VXI2GBQ2v3z7a9jEzCiqlJ3s=;
 b=nEYv7Ku24vneOyFCFd1ifvLG+fnuci1Qk7jE8evpa/ScHPeOm7WJ6rBzDUxAr+e8nb
 OI04FIVHmgHH+zPL3F3C4q4nUu3WNGTFMLeUW2iXn6/GhOEex5QUmEVeT8/gZxS0RvR5
 Asp/RcHO6BiyxwEx2AkHBCuJ7NxreJe0m2TW4oibfkRnhTWh5XAO+8KnSUgvP2M3fhAs
 yoI49HLr12wXAEaN2Gua47+2zIx58Pnu18dkqZUA+UEcY+ZcM+6/uaBqXe1WfhjMyk9x
 ljU7Ss5AS/tCAeOvoU7efzlbPo7HzflRPP4h+fOWz/nwYWerhepNotX7R7lXEaKMnOqu
 Asyw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792589917; x=1793194717; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9KBIwDVjRljfoYY8ykEzS0lIIojLvcnZtZ21HGXYQHQ=;
 b=n9Nle2YkG0lMrY+TUHytGW4FwIqYwukwgF3bSWtYYz0vcchwxdrQ+8IVsiu02jV9r7
 ZiEtFrtXJAJmpnyixluqAQ3ftgfcEvzR6QUKAyZwcz7YkZYbBa/cQ1mQuGizdI86nH5U
 B2S643MK7rvSdBxIzamSHRs03FUOHbp+IGHRHSwb/1CCNIpwq885YMaMUq4UNudT/jLd
 g9nXhXqscvu+wYa0BzquRkyUOzRMU+S5zbkHYMZXZ6/hm1oy1W4ZZUgBJqdYOBzC9gb2
 15aDUS00lfKAnNlaMX7buxyCH8t++4UZKf3VYEO9ll2ISLESFD4zFMmApFRx/a6g/29G
 hcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792589917; x=1793194717;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9KBIwDVjRljfoYY8ykEzS0lIIojLvcnZtZ21HGXYQHQ=;
 b=IT0tymBPwDnkpHWNKhhPFdv97+oOfHN+uOx1CTSu33QkOpfSMULB8YVKxT014ooJLE
 WqX3YAHdq7Fkb4frfUKTBX4m7b1dVY0p5vUiYpnHOQg51Q5SnaC0VgDG2N5eX6GFJa1i
 ZsTMGVJXoqCaqPRCPKu1+l2Ay80f3YFT9tVCEvO9Ct+30vFhM7kEHFfjsVj9RRCjet9/
 KiS43fqXnLzErx0LM+eS+cq0wkDnAV4omTM2gjvwXmoEA7CVWQqGiCGnfpsTKgG3k14L
 bAbw/bb+3Jtc6RyR1m6J21EfYU1cXfxE2iuV26ZDYDTvnXMkLs1B8P97YwbpXhUGgx/c
 a0kw==
X-Gm-Message-State: AFq9FYK4XLs8C9qzOh9D+EgQf8bjzxHgY7chBhcnmdGnCcVfiJe0LiBY
 7NUfYAnrlsRtowQVusjUhWZS42q5qqDGeD01EbqZbCEFqD5dhqIuROfxHdk2oRASpz0QZWDg52Q
 m+Jd3ssTcA90cEBBJgbQP3sKYXefxsyw=
X-Gm-Gg: AYBFou2J3sJu//gITw/2J0L4sWrw9+3dK6jyoZZU6RaH5I/vyYCFGNLM0lcL9tL/fXw
 7rXdTwOoreqTGifA+C/fFy+ML4BVsdJKjENnA1hXQ09YC1RJkhv5bNioFVx8RHj9H/WG1ItRCcL
 jliZ+qmQWPushOI1TD1uWm/RSUFvZ2+XT2168KlVPU57NYRrQ5G2gR2dX5rQJu5H80hDdfVdVr3
 TeH6XSeBoRPM88yXVtPPICjzqlGQOtLIuR+76f095pNwsDSXLNVXI/VONATUQKXUgqpbpjSj7E4
 BUjmW0Lt3QNyDoxdT59q0nVpDwEAiZbQQsE1CA8WsW/92og5GYZ8J9ddhWICAM3E6jj4x+VY2TB
 tvkNKkuk40CrBejw7fBdDcbM0eIl+YpDAos688MO788NfUwp1EcDnI7JzcC77hjDrSNqvmgbf13
 kMYiX8OgEXfa29MCZvy2qNu1Nf4uvT04QLhrDHL+spyMOm
X-Received: by 2002:a05:7022:43:b0:12d:c389:ae54 with SMTP id
 a92af1059eb24-190a465c342mr4907856c88.2.1792589917147; Wed, 21 Oct 2026
 06:38:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
In-Reply-To: <20261020132739.31852-1-tvrtko.ursulin@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2026 09:38:24 -0400
X-Gm-Features: AclHuK-xEA5GF9YlTOkG991kt0C419pX4_C1DSRgj-46tObBDVhw7wxLYQ_sKp8
Message-ID: <CADnq5_PxGHp7YK9auBs+EMNfYzt62OLCHhKvy50hT5a+B8u_8w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Misc amdgpu cleanups
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>, 
 Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Applied.  Thanks!

On Tue, Oct 20, 2026 at 9:36=E2=80=AFAM Tvrtko Ursulin
<tvrtko.ursulin@igalia.com> wrote:
>
> A few tiny cleanups I found while working on something else. No functiona=
l
> changes were intended.
>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
> Tvrtko Ursulin (3):
>   drm/amdgpu: Size the buffer_funcs array by maximum number of SDMA
>     instances
>   drm/amdgpu: Size the vm_pte_scheds array by maximum number of SDMA
>     instances
>   drm/amdgpu: Simplify amdgpu_ring_init
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 12 +++++-------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h  |  3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   |  2 +-
>  3 files changed, 8 insertions(+), 9 deletions(-)
>
> --
> 2.56.0
>
