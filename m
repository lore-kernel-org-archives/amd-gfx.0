Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF63CD6E60
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 18:21:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1680C10F364;
	Tue,  2 Jun 2026 18:21:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KnpzOLBN";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E099510F364
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 18:21:44 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-304da3b4508so563541eec.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2026 11:21:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780424504; cv=none;
 d=google.com; s=arc-20240605;
 b=KupzC8EtzHEatrnzqY1m99Vh8Vdbvdr5HXj8hMHYgok1ACgzRWzwURaOQ76OLwEFsg
 p63wRoL4jM7zUyGZa+J8sUpSYsX5MmRqpdDnsbMGHvzQj0IXbTz138+LtyQwTi2rM9LF
 FHzdASEyVRQKrOPOpTDWd9u7Sd+YwUHpKjT15TsOwrIvLFSplCBowkt9BKhN0BCCtw1g
 4rxUfnsMt3pqDwElNMlLPUqM1A5lvEctwpNDB+fpHjZgriCuiQs+n5AR5ll80eTJFrz4
 kgTWCvhv06JTBnBhFIXYqo9v0TeZi1souuQO/Zx1PC6tMBMlRDblMLy+pP2q3Clnzf2/
 vpTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=K4j8xBlriPCiD+JRo9TBWpBLXuE+UxJUNIrUpZLgAvE=;
 fh=gZ/QuQ1El2NU1RRI5pc/CAX4Mv4g4Ez7PWwEsOz7Ag0=;
 b=TNkoglXeHui8SgxAjglPSdp920kKUZ8jx4oo9C+ZTtPTzRELSJO3ISAEqw/PwcGPX0
 mb3nCF6fYmy0AOi8Hu5ja66GhuN9Efm9BdK/K2nBp6iVDwN5WyMnE7Hjs0sYVJ9A2A8L
 c5soB9k/3ZKWESSnjHLms95TlJTxF/fFICOB8PLkOhB+uGeN+jdjbdO7/B0+mc5amcJi
 nRx7b4BY/u87VInan0dKYFwv5Al+l6Z8uExbAR3tHOqu1ZihRrjLOzdb6q2PVxmyYYG7
 /9sGBp+vC5KNL6+KPZcsCrmXN2ZbZqgfwiWBPyN/F3andD5Mea5yfA5xHV0sWYRm4NM5
 a5/w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780424504; x=1781029304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4j8xBlriPCiD+JRo9TBWpBLXuE+UxJUNIrUpZLgAvE=;
 b=KnpzOLBNg7Dcdf3sk7RJLPyckClZIhCFb7tGh4kJmuo4LzR5Xy92G+h3T2gNFikKOQ
 41szFF8axeVWPFXhKX/IXEkHlZKqPnAH8vntXeCVm080k4TGYMDPtL0XyGeGGLUuJZ1m
 hZiya28RJq245uE1T5cYmYUuy7Hs0NC5lns4oc/ciY7QHtQfj8yBmL41CeoNxvDBSVKC
 8HuSVtBxBvOSkcgoPiB7YRBIh2H3Tc8QUb5FckGxTtqwFO8EVgNHQqxUtvew3t8q+tVc
 1kKmUjUuatU3epFbM89DrBJRTj6rB2aRFbS1pkODYiDHY2f7P4vGCMGhHigo/yTh+wRo
 uFQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780424504; x=1781029304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=K4j8xBlriPCiD+JRo9TBWpBLXuE+UxJUNIrUpZLgAvE=;
 b=p9x/4n0Nt2z14HSOqEBIh+HrGRN41FNg/XkNvoBBvYnpMaLeLSE3KUavTLXSxBG7rR
 lNN2rJSmQK0OqOxo/cYm6mI/BIYDK7mHOtAUdjmKz0nJF0heMJDr1d/FUPULx5mDK2sw
 zISTiOyP3LnDWCG/uxl3EMeI7omSkZyMswGVuq6fgmbO5JAIG6tD9SvY/fbzzFVgTHiN
 LGnLoXq4ZkjEKxyAJBpjgtfKPGsnXwu63fhGoxCZYTNwVH/gk4XuzWoaxLTMA7GUmw73
 33WjTkD7YO+b1blPsqNAwbaHy/FowKt4j8Z/QiJV+voDiDFqqxcBbyydTkOdvpB3Ja3L
 pz8g==
X-Gm-Message-State: AOJu0Yyy6B+GjgTb454qO6ecwdTCIwFxoYjcNQ2TRZ2ATamHPXx0ubmG
 fP/HLBZJGOS6RCESH7lPWh46U6a7A2LUwQemaa4MaYg6LVTCDhIyD7khIngfDoRJ5xUuJWoLBW9
 TRVAOoVFGeBfMtZRxFIM6B6s5ohAJbskK5g==
X-Gm-Gg: Acq92OE51X20es0YLlnM3IpzsK+gmBqXhzHT1ZdGnTprWeuHaTRRfBZawnhgGm8L+T6
 deYtNxyiYOlPPrnY4WTyrZD9nKYANHn+vI8RzWL3HioZheMMbLqUhtSOQLTAN2TTXymptRfMEVQ
 JcjnfBx7eff5UDk63gLk2MTd5hFTT26zz/HcF4ck2sp1VBLBkA93S0MwRil/0xKLL67Fvf7eFri
 H1q/J7mM1hd8ctP3Ej7ncwWtaM16ARZmsPlyR487yRnQenmmIxts/LT998Btl3OGivo0l7I5nY5
 ZSDR6TiDy9cgEbDj9uaN3OmmUSU1fRxoey8T2ha/SWtccYp8VIoXiSjFkOfKWmS2wlM3DLG2B/R
 OHGCW
X-Received: by 2002:a05:7022:fa0b:b0:136:b71d:a90b with SMTP id
 a92af1059eb24-137d39ccabdmr3210142c88.0.1780424504172; Tue, 02 Jun 2026
 11:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260602141422.4982-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20260602141422.4982-1-Yongqiang.Sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2026 14:21:32 -0400
X-Gm-Features: AVHnY4JUQvkyzMGQhNcUtcll3h_dyMVcn5eaiuTf-Bn5Bm9yNGRVCej5VDiunZk
Message-ID: <CADnq5_PGhAVLHGEBU9CgnSLg65GHburXhZbZFC6qCQsjV1sAFA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Unwind debug trap enable on copy_to_user
 failure
To: Yongqiang Sun <Yongqiang.Sun@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

On Tue, Jun 2, 2026 at 10:24=E2=80=AFAM Yongqiang Sun <Yongqiang.Sun@amd.co=
m> wrote:
>
> If kfd_dbg_trap_enable() fails while copying runtime_info to userspace,
> it had already activated the trap, set debug_trap_enabled, taken an extra
> process reference, and opened the debug event file. Return -EFAULT withou=
t
> unwinding that state, leaving inconsistent trap state and a refcount
> imbalance that could break later DISABLE/ENABLE.
>
> On copy_to_user failure, deactivate the trap and undo the rest of the
> enable setup before returning.
>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd=
/amdkfd/kfd_debug.c
> index 0f7aa51b629e..0dd1fd448059 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -832,6 +832,12 @@ int kfd_dbg_trap_enable(struct kfd_process *target, =
uint32_t fd,
>
>         if (copy_to_user(runtime_info, (void *)&target->runtime_info, cop=
y_size)) {
>                 kfd_dbg_trap_deactivate(target, false, 0);
> +               fput(target->dbg_ev_file);
> +               target->dbg_ev_file =3D NULL;
> +               if (target->debugger_process)
> +                       atomic_dec(&target->debugger_process->debugged_pr=
ocess_count);
> +               target->debug_trap_enabled =3D false;
> +               kfd_unref_process(target);
>                 r =3D -EFAULT;
>         }
>
> --
> 2.43.0
>
