Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB55CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 21:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FB2210E556;
	Tue, 26 May 2026 21:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mdlwxqLA";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6375310E556
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 21:02:29 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-1365eb2a773so116507c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:02:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779829349; cv=none;
 d=google.com; s=arc-20240605;
 b=bXEbpJ8Y2TEw2P2Zb+5lvdT0HbrMScKBqZpV7MIBMpSppTtZElpR7y5EVBhQXNX7G4
 S2Dh0BXddwnRiH4IuCCpSl9JGDKBtJbX1NHnDthcevwnnpYkqYK3OIlp6HsvsNk+6fmW
 Epv9mNi4fhQLqlvgOUdW0wUx89TP6DvOY2E5wzV5Q98SJPsOzpjBVHp4us4AdvaMdkWQ
 XmmzB0qr609Rg82kcDuOE0T+viUuP9XmrWd5X7Dzc3g4Y9WJKIHQu387yGioSjJkACYH
 zYYEvlmsYBUnoEvPzMbHk+T2FagKYPhMn75WlBGHlq/shSEbnDl0GOU6VWOXLPmvB6MA
 DTTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xDSN+zAFo3SDyZ1j/OWiBK2mX5qoAAjzuXlq2kenLkU=;
 fh=Qc9u5xWRkg6Jw6KpuSOwNDoiZ5BzvR6wObqd1MNKTP0=;
 b=YCQzVK1ZWeHnp1FvTpHduGmAKTrwl7XNJuKbT+FrP3KXPrlkA4ewM2eHSKdewb6otu
 mw6VO6s8z5q0POkPoZzmmj9/vGSe91SQpn397A6QaR2RIlk87ByTdEq3v+aur/4GimOC
 LFgXHn2MH9b1M6SRmEVwVdrj3LRFCEduka7cy+WyBecUaf16SskjO7rqj6uJSQRDX1th
 wMEFyUT6YTs5sOB8Nnc885i1gxnXy+F7wlZuEm1ige9774r32GSAtZ/1N4Q8UBJ07vxi
 XttB959HivLbYv5cDLTjHUYRBIxvfZh74nikApeMTiCTx5zFxk3J7RhdgL9s4I0FHk8E
 pxDQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779829349; x=1780434149; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDSN+zAFo3SDyZ1j/OWiBK2mX5qoAAjzuXlq2kenLkU=;
 b=mdlwxqLAUk+X/iiMZWsp6A0FRIQTVYJ1947CgwntwH1+nBey7WyYiU+nzseAPWfrnY
 Hz33IYdlZta08VLrOHdMyxgYd6yE8glwkoc2JhwfW7ymgXU7yjvqdG2p9rZmhSBE7N+Y
 nclfU14i7v9S8MnGQdk02nbmBkAFVAq8Dl3Q4DTqMHTCa4i4dyWnMiTj2d3nBCSVrwsq
 6swf8JpdsWi6ilD+Eam/4i3J6ix4iFeX0GydBwXT1HddZX+hoM8Rlajy8xbMMeBByvWR
 sSlZwXQXPTfUMrIkObNh5lvefPRwTCufr188BqvlyqewCpmdqSE1RWtYLtRuiZsp5qXD
 TILg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779829349; x=1780434149;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xDSN+zAFo3SDyZ1j/OWiBK2mX5qoAAjzuXlq2kenLkU=;
 b=Y7HzpoqKcNaK+dWmRNOkuohl0aMUpwlYeyvk6Ypb1DFxD90QlAwPrhgJoBii6Egh2o
 KfHDuJLGmjLPyNGqWaq8o6nF5Dj8x3hc8roKLa3Io7No9pVdDh/joqIGg0C3pn24WK5c
 hcClTMR+IxeFhwqTo6VoqNOukAEZ1yRJcpO+rervmJtlWyhDpC6igG9K2dGoor0V9ECi
 wyGv2pfV4SvV4x0ivWfZoNIsauIeaKi1mc45kI8o5CLoh5X1bctSmNg17hvG1Qz4GazV
 ry272L1bwdE0tv9mZGFnodkqVJX/2gX3Zp8bENdQ0JwkYtVAhpiNvwHLiXaScZ0Tk2I0
 KDRg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Q6pUUBKeyeeOnqSKCRzz2qUQUEsi69DiBNLDhwKCTyayXO0ghgqq/8sldEH0oqJy5h72TVvgV@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxj1ZYw4faoiHQZvuXWfWnELeJAnu5l35p38/2Y9o6Ts4CRmkRZ
 0qCwWohZRdhJqM5Lfr8Soy+UQZoegPViuNh1nCS8DumUs9JRflOLul524VIMsswnAoF5gqNezMK
 b3zlFMxv/tyD/zLveUgWjKU31GTdtUns=
X-Gm-Gg: Acq92OHKPAlo14Wg/4yW/7+rG+YI+pabxdHDIYrrGTpRqOCypE40hidm+M6783gmFNk
 DqYLxK1PhSxuyt71VTKyRChtN5i+ZHB0LijiqG4Xi4YFsSFWf7/iOPBSVQ7FdQhLqTu4fV4qxHs
 GvxJ57WY+vaZOThNi1ArT5gT/AIGJ4tlmaHj12PCETsw/Q7K47w9JupBQw3s0v9QjFOst9Egeaw
 bGZuLjSbhx9LJt/M5gpPNt7ZSLt1+QFmHL7YgHT2JRevIdJtTZs+FbXNxePg4EriXvgw81N3Uxc
 O0r3QmcNrycbyCc49GeBuPHOFWPYU1wFYEl7SCzRY4cBn/gkuYXZLmEQdBlC3beo1UIy02xxNc4
 TIfsF
X-Received: by 2002:a05:701b:4285:10b0:12c:897a:5219 with SMTP id
 a92af1059eb24-1365fd80cd6mr2508477c88.5.1779829348250; Tue, 26 May 2026
 14:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260523142645.39102-1-meatuni001@gmail.com>
 <20260523165646.25645-1-meatuni001@gmail.com>
In-Reply-To: <20260523165646.25645-1-meatuni001@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 17:02:15 -0400
X-Gm-Features: AVHnY4JqZMeWeY53IE6NJ-7vofcMYfgVFqoUhkfR5wacLpNgAvtsXhnZNwnkDGY
Message-ID: <CADnq5_MH_eLM1qeQB4t_uR=T66TuSHCAs5O47Li9_KtatkmgqA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix NULL dereference in get_queue_ids()
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, 
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
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

Applied.  Thanks!

Alex

On Mon, May 25, 2026 at 5:59=E2=80=AFAM Muhammad Bilal <meatuni001@gmail.co=
m> wrote:
>
> When usr_queue_id_array is NULL and num_queues is non-zero,
> get_queue_ids() returns NULL. The callers check only IS_ERR() on the
> return value; since IS_ERR(NULL) =3D=3D false the check passes, and
> suspend_queues() calls q_array_invalidate() which immediately
> dereferences NULL while iterating num_queues times.
>
> Userspace can trigger this via kfd_ioctl_set_debug_trap() by supplying
> num_queues > 0 with a zero queue_array_ptr, causing a kernel panic.
>
> A NULL usr_queue_id_array with num_queues =3D=3D 0 is a legitimate no-op
> (q_array_invalidate never executes, and resume_queues already guards
> all queue_ids dereferences behind a NULL check). Return ERR_PTR(-EINVAL)
> only when num_queues is non-zero and the pointer is absent; both callers
> already propagate IS_ERR() returns correctly to userspace.
>
> Fixes: a70a93fa568b ("drm/amdkfd: add debug suspend and resume process qu=
eues operation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/driv=
ers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index c08ad718dbd7..8488b3a6c2ba 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -3312,7 +3312,7 @@ static uint32_t *get_queue_ids(uint32_t num_queues,=
 uint32_t *usr_queue_id_array
>         size_t array_size;
>
>         if (!usr_queue_id_array)
> -               return NULL;
> +               return num_queues ? ERR_PTR(-EINVAL) : NULL;
>
>         if (check_mul_overflow((size_t)num_queues, sizeof(uint32_t), &arr=
ay_size))
>                 return ERR_PTR(-EINVAL);
> --
> 2.53.0
>
