Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AD0F54AAF
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Mar 2026 13:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75A6010E6A8;
	Tue, 24 Mar 2026 13:19:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShoTM7G4";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6491210E6AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 13:19:30 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-128eb45835cso224076c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Mar 2026 06:19:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774358369; cv=none;
 d=google.com; s=arc-20240605;
 b=fjJo7WAfPcbLGXw3nYARO0VuYR04PIDn0hM4pbOV7lugkKBYyqM52jaedEyR7glnms
 HAC1PjX8IYgdPGgBE4A/dVZUtM82RUI4ahb6S1cQdNgMLq9wXxg5Btn9rt9OV2nsNEU6
 2ESbhCktosvRyTF8xwOLa8TqGWhfF8EBDEzznExWk7Ix7ijAJ0FbhqmMT+B21nLYXvbu
 TLtVOidgMzfiowOSAl8Yph2AYWlSR6kkgQ8QsWWtZDx9yV31i7d8a4jO3dp+/3Yre4Qb
 abGYg86TiY8BWcurzx00wU08CsCRLsxh1a28D47lynUCDk7DDv9w4NwDT+QYg28PLUBI
 6aNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BsRLgUtA5JSsXZ4xXw8vk1eoQqR+UCw1mR7ln0dyj1E=;
 fh=0DU2kfv211GmKLo6p4OtGkNQGb62nWgg9fY5bZv8duM=;
 b=ftCgnZuIgnFOS2oANEI3qMT289g5mpWjpWjyOncORaYUe7ovboUivt7IiiP8UeCK6I
 yZFKyVN3qe6ushAA0F25jYjaWsAHE1haQXvq3nPaXvEHSRpKk59VH/DD982hModdOt4i
 W4vxCRkEI2z45pEA7fV5IgzW4dBD89s1ZOxLbIiTF8Z6Q/p8GKM5wpeft3HTRuzZXkNJ
 1BHrTASozoMWvx3chw5lFXVonVkOdXRbp1ILglABUMteqAT3RzFcECXwo3deB9802LSU
 hFyk/nTuSoPNAnhsuuRQo8LiE0UheJJIm5T/AsAt9bLqCUUqEL+ZQcSYHusA1E0H/5/g
 rHlg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774358369; x=1774963169; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsRLgUtA5JSsXZ4xXw8vk1eoQqR+UCw1mR7ln0dyj1E=;
 b=ShoTM7G40GOcdeRA93SYQ+pyvrjJd8Aavyl5JNHa1v+8h9F7EtVhR9zdGQ2wrZB7JE
 YwNupUct3+AJYa8dDZNLgTAMR3XFFf2XCoUH5pt0DVct1/h+tKFbOhXAzvowSClOfxb7
 6wTAp4ebKs/4sdPo4dUUlUNcwyD30EPqD8MEN4rnATZhf6G0fYbnhO06gszTDSvxy/QK
 jspjBb4VKO2nbFcJnVXrk4LCULJUY9lWTedTnGzvuLSg3n7BEkrAp0bCyW0p8kl2T7kq
 z3b4mKULjq+3yPaERJNv7raOOXY7HgmeTBKYtFYPUFiqlV0LYrUh6zISvEqFrikSRbxt
 TZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774358369; x=1774963169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BsRLgUtA5JSsXZ4xXw8vk1eoQqR+UCw1mR7ln0dyj1E=;
 b=hUOVsJmTI6ObhKCi7aB+/qy1VhVfZWa5PHk17Q7LhFV9D5gkWdlktrt5n9uRc5ymqN
 me4qYzrNyapOou2Q/xa88W9Y40GCb8G3JAyqpvcGILgavCeIPuiX9cXxKFiMAESJV/Kc
 yS9T8ro+KLrSqryDJiOOocqxQDMpsSbLyci3fIc448g000GdhAMim+IJP/emaml1b5fQ
 qnPp0mOY+Qqgp+fI/FQa7QeA/d7y9/CTCfGA8x2nzpUcrG07sOCSYDqxWVlZIMUgqxtx
 EDxECetHJstkdj+O224QjWLvoaaVUUTDYB/WqqlM49RFvTWlR4+GLT1Y6snlv2BmaAeT
 yNaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUDrSGzFeLLXvCcAI2TmGr3h3zBqmyoOvqncmnb6ynXsME/Fr7x6JnCeVG5P98mUXzVP1w4S1M@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjEatSRrfiIrsSHc8h2PfVTkPLJgHi1LlDCvBuvWhBohT6uwzS
 pOXc+YrrYpGLY7f0wJ4wCQHQpeERt+Drg+IBLATc5xCRvvGRBS2WlOk5NpYITLwYYE+5we04RsR
 3lZcs4HyYA5rvyVBsohMciuLPv1uzyjQ=
X-Gm-Gg: ATEYQzyB9FtFZXDnluqq7xqr+seEz/AcHhe9Db+MONPgyq1S0RlrjRBRAO8t58n13fv
 dpNhvKlAfgpn741JWik15fx1vpz3g5wN1FBvDQtU2r4j7yEfH+//4zSImnelocFrfbKRXJP8aL+
 uABqWbKxoaaRYo5+1BRrNIMS4z9PslBjkOjW9O0mw+Z3V+ZH/Xse/dfhzJFr93Huz2fQQOpGmTY
 rLMTCk6ZzQprXI1Ny2kOk7QTqV6KEu+RF5gdhPM+sNnr88slsg4Jp7fFow0zbFORf1njaZUY6Mb
 ZoLEkyh0YlWfA4nJKr+a9TxenD+vy/3K16jVCbfQJp9QZf2jg6nxo+IKzRQ00P46YPNxnw==
X-Received: by 2002:a05:7022:f8d:b0:11e:332:1e01 with SMTP id
 a92af1059eb24-12a726a9b6amr3506204c88.3.1774358369493; Tue, 24 Mar 2026
 06:19:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260321105728.6304-1-kexinsun@smail.nju.edu.cn>
In-Reply-To: <20260321105728.6304-1-kexinsun@smail.nju.edu.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Mar 2026 09:19:17 -0400
X-Gm-Features: AaiRm526BG_rM9muwvFrczqMS3-tFt9tDF8XTVojFBAC5700mXENfyNJwBxRyIg
Message-ID: <CADnq5_PO_Ns7=48ZOKa+08gwO038BzJm8K_KqE1Zz7XTa+M5uw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: update outdated comment for renamed
 amdgpu_fence_driver_init()
To: Kexin Sun <kexinsun@smail.nju.edu.cn>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, timur.kristof@gmail.com, tglx@kernel.org, mingo@kernel.org, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, julia.lawall@inria.fr, xutong.ma@inria.fr, 
 yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
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

Applied.  thanks!

On Sat, Mar 21, 2026 at 7:44=E2=80=AFAM Kexin Sun <kexinsun@smail.nju.edu.c=
n> wrote:
>
> The function amdgpu_fence_driver_init() was renamed to
> amdgpu_fence_driver_sw_init() by commit 067f44c8b459
> ("drm/amdgpu: avoid over-handle of fence driver fini in s3
> test (v2)").  Update the stale reference in the
> amdgpu_fence_driver_init_ring() kdoc.
>
> Assisted-by: unnamed:deepseek-v3.2 coccinelle
> Signed-off-by: Kexin Sun <kexinsun@smail.nju.edu.cn>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_fence.c
> index 1054d66c54fa..37534f66c755 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -458,7 +458,7 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring=
 *ring,
>   * @ring: ring to init the fence driver on
>   *
>   * Init the fence driver for the requested ring (all asics).
> - * Helper function for amdgpu_fence_driver_init().
> + * Helper function for amdgpu_fence_driver_sw_init().
>   */
>  int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring)
>  {
> --
> 2.25.1
>
