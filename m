Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F742CAC582
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 21:35:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD3D10E5E6;
	Mon,  8 Sep 2025 21:35:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Azl0oP/y";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFB0710E5E6
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 21:35:17 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-24b150fb800so12763935ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Sep 2025 14:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757367317; x=1757972117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7SxqITHQ1DgZhrU1JRlTS/mRF1uxDhbu/UrUP5EQD8o=;
 b=Azl0oP/yrfg/4k7BykTeZ041PRxdKErEXcJ6dhooT2QtLOWk0OAfJczTtbT1b8awh3
 bOaN/k1+cdrjIHbxonThgpe6by+cfmGLEZkB9Kovp1hJa2WbsqqoH2CXLPTb2dKfa88Q
 TwAzgemtpksAAhtHlSFET03mGtI7bv6Jn5UyiXTR0ztYsL9uwWsGmY/GWNZnJkMu2RlN
 AArSERN2zqu1fXChOgfQEUpxwR4fyO8UEHLBKU2BzX7o7rqvUhet13UuEOfUTAfxPPnC
 GTENXBZ33kjXMOaXIwjKp9xFHmJa3rjbnf/oxkLnU8+97sWaFmp6t9oNjXvGa90rUoE9
 X5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757367317; x=1757972117;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7SxqITHQ1DgZhrU1JRlTS/mRF1uxDhbu/UrUP5EQD8o=;
 b=FIesHaddMlfq9klFYY1M/MdvphszcNR9rlz5QuGmWJLhDQprmNhKe0czn5gB9Ooepx
 8ZK63l+uIVRqjWHtra0hy4GAwNWpYAPXp8cSKT0kyVLNpO95+z1bafvdEDhFABgQRGgr
 oy46Yf5l2MMYVarxYmpHGhyScMRXNcd0jOhTAuxAEBUgW40CiAD+gcYp0HPM2L1tK03L
 QwZAhkUSXQWdjppy8qoTCfZ5wzKJ4rl3Rpt+WL1QZ3YuymmTNWMhawVqjudNdhMyqEzY
 lwqW+mynta/piCIzTi5M+aXzvNivTQB8YC4CekFIkaXG8GWtZCm6Q6BjWWd7aYtyDBEY
 ku0Q==
X-Gm-Message-State: AOJu0YzMsUnf/uEF0BKtwjmGbOHZV7+khCx+Zd3ZcfCvVdxJKMt/pIVU
 o60lO5TThhR2pBzR52oaJceo/M/QElj3aXnuI2e6PWEYJdjg3RXiQ5pVIQrYLX8RFF8Aw3ulZn/
 76FmoDCD/SF4ZVOrGDUWEnP7qIRJ7gUM=
X-Gm-Gg: ASbGncu9UVuT56rON9q+p54CA22jdT6LyUkidfVuBC1gfP0/cWKT935ETW0uD+lsCDy
 6LKoS1/1ySUnW9GHLHPBOBpcedSEttKD3T8Gz5UqhczbrritPckMkKY/lJLoefyxJVZtdlC82Zg
 PsLUFBXPjtOfbIUt/BFXIz09KaROKeOjkvH2Huy2MgHmPIo6s326r1hpKeYKT7NValyNHfPidUN
 U40dek=
X-Google-Smtp-Source: AGHT+IGZ7VGuDyc07RZHG2R4PtYJcvvhyXZ3YD5wuROHI0fbJFCzi1AZvWRpGcGyYm3vOvK7bEC2QwbwE7N7/d8umbM=
X-Received: by 2002:a17:903:18c:b0:24c:cc2c:9da5 with SMTP id
 d9443c01a7336-25173ea24a3mr70360725ad.6.1757367317214; Mon, 08 Sep 2025
 14:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
 <20250908084846.1873894-10-Prike.Liang@amd.com>
In-Reply-To: <20250908084846.1873894-10-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 8 Sep 2025 17:35:04 -0400
X-Gm-Features: Ac12FXym4YyqwNNi4xklCaDnRGUTZyKr_v5bxdPErmmLZk4GC7JtiVZjRR4Hr-s
Message-ID: <CADnq5_N_PjOzgF3+V7MkX6nbfcFdDyNdWPJcpt3FXmzh+BCs0w@mail.gmail.com>
Subject: Re: [PATCH v10 10/14] drm/amdgpu: validate the userq va before
 destroying
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
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

On Mon, Sep 8, 2025 at 4:59=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> wr=
ote:
>
> The user queue object destroy requires ensuring its
> VA keeps mapping prior to the queue being destroyed.
> Otherwise, it seems a bug in the user space or VA
> freed wrongly, and the kernel driver should report an
> invalidated state to the user IOCTL request.

You can drop this patch.  If the queue is destroyed, you won't be querying =
it.

Alex

>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 85df04e9ec3d..98b6b3761a0a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -520,6 +520,13 @@ amdgpu_userq_destroy(struct drm_file *filp, int queu=
e_id)
>                 amdgpu_bo_unreserve(queue->db_obj.obj);
>         }
>         amdgpu_bo_unref(&queue->db_obj.obj);
> +       /*
> +        * At this point the userq obj va should be mapped,
> +        * otherwise will return error to user.
> +        */
> +       if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue))
> +               queue->state =3D AMDGPU_USERQ_STATE_INVALID_VA;
> +
>         r =3D amdgpu_userq_unmap_helper(uq_mgr, queue);
>         /*TODO: It requires a reset for userq hw unmap error*/
>         if (unlikely(r !=3D AMDGPU_USERQ_STATE_UNMAPPED)) {
> --
> 2.34.1
>
