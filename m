Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC63CD6E5D
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 18:17:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B58510F306;
	Tue,  2 Jun 2026 18:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JuDb2v+a";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DF7E10F306
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Jun 2026 18:17:45 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-304cf9a02f9so526724eec.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Jun 2026 11:17:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780424264; cv=none;
 d=google.com; s=arc-20240605;
 b=IhE/vmVqB3uMZqsc3pXHFhWTVNi6ZMj41tqG9fKyJARpCmJ7eMMI2kTcXT7IzIZMWo
 GRzAsWPy/jluUbZuO59h8IL/k5JkTdfQxDjvAPs+MdzICdMdFnEyaB4H34pGr8pqNWfO
 kYw3XZ/uqvmicaYS1rkxMG+1U0Q0B5zDUIjsWZdTvYk0oc+MVg4FiQZ0OZQkU4oWOpFm
 Qe9sUo9WnrYV77qUCn91XjBjoSH/UsE8fyU0UaEcmBHwGSoQYP+R2hwr6maKNzt3hHOj
 z6zZ4ReTOGPMox2pQoTjOCVWozzXKqxlKiE5YuI8xj+6vPN6IxYbPJHpi3y7U1KV0180
 PRWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=gPgv5GTGvi0SICOn9onT+W1c8ZZg8GUuHAlKgaNXX9M=;
 fh=gZ/QuQ1El2NU1RRI5pc/CAX4Mv4g4Ez7PWwEsOz7Ag0=;
 b=HVI10rwXvDEpp4OYC1fuEzdlESY9EmAanfKG9tG5jkRJVnP67oZ03WpywfZw8B1HXI
 pcgysQBJknujCKDf+34j9MsFMJqeX/Z4Mz7xzlzK6i1VsYu6guIlW1nrGksuCINfcltX
 gGTsvO9BIQsO6kunk/SzoUWKyknl8rZnw1ckrflHRswANFiK4aIr16LLyHnBoq2ZHhZj
 iuXy9r911g1RyB24bBuhSkJzUS5qu++N2eRJTWUVD781senWGLZwuC/1drHOnUpKAtDS
 sYvsgkKnAiDaRmDcvyG9OaiuwkV247ivphXAp5ftnNPJhi1eCe9XFPDSNEpAOAm8Lh7x
 1UWA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780424264; x=1781029064; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gPgv5GTGvi0SICOn9onT+W1c8ZZg8GUuHAlKgaNXX9M=;
 b=JuDb2v+aPX2GPyNgVRoFuaAIH5eYTP6vc11M+fhfjxATjDq5VIE6oQ3qzcXxRg9iQ2
 nv0eWquj0DfuXwp66T358kNN+SEDaZ4js3Qp5mXeHixcy+/cNPW5Wmqd2b6iRZFCxvdO
 EBD2e8dCg3ctwbG+ZeAjBnMt2VYEmz7ldYQfog6rQUoOnmUZISoOEnwITdMCgF+ojYVe
 UjwniqNlaplR2jpXQJ1tZONEpfp8cshq5dPJtbRnJOTTq7ta1ieog0Fi0K6hx1YPj7dO
 kic2n6IlkCT2ya7WD+rfYkIy/Spr6s+FzrhVgN5E8PL0xlThCjihPbnPMGo4kz3iAPjR
 ncAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780424264; x=1781029064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gPgv5GTGvi0SICOn9onT+W1c8ZZg8GUuHAlKgaNXX9M=;
 b=HnvfBAVtrJj8fkYA43rv0BIx/4zbPjaqKJZlRCUWK5X4aIMsgfFh+EtvPSJEu70MnY
 eicCN97wVFPuQb1P1fCmahQ7vG+96kw6v3tOpPBbj7uf1D0w2yNsKmYJL7eemQbPy0vu
 GWTGjPWkjmfhpE8qT5mIGAosJPTHi93IWNnlI+r3WmlgzCYcYCHD0hh8XxdNioK/YDvb
 N2c437ScVG6HqIC16HSqd7UygWGg7R6tebNXTb9unxEvnSHxXpMRWGESkcPCqboRi4pg
 I12ucj0mvY3GvpmevDGnhEzywE4tLk7awwLOUVPqDhBy3ZR/3eqUxECiAAWcnHdWJPRE
 ouSQ==
X-Gm-Message-State: AOJu0YxqauU1Q337mXbkPUNEFPuPnTuoPDhUvcpJM64qgMxoMz7svPx0
 EIL+NdEudyDyMmTIcqNs8clHYrTSkQqH7Y3R176npsxv3mHEUbQ/bco7MmJ3NjOSd7PQjdlURNC
 Y4q4M6+tF4/1+wAoqh8zoXr3hIoZcmCrKnoSm
X-Gm-Gg: Acq92OFF+HWoVi/9w5mBWwv2vw5q7h59vadeNqFfaTsLPzPuEfF5tSlLTzhwePgnQAd
 UkOzWRS2mkTCslaG93pyPk3pdHTd0z3hJLvxBp1ogSwnKJGqIdx85yhuG1cTVD0bm+z3c7BkkT1
 4KZKvDlnbvHCJJJsjktlZKITp4PY/LxLcNaXMWikSuajQNmnxpCl7MhUonlOurQyFoxnjpShnN/
 GOw0gKpxEqVJ1Xe63GS5ram7o0+FCEyF9419gSSqYQxUndOXRV12mYt43KSdhXJyzdZ7RvGZhiu
 V1Rorx5GBaEvBlqGA5JgYIbDFJngJ4HL7bxuyBK663uSwuRCRWuH5Td1cod1H8/R4/iVXeUGOU3
 6kK5J
X-Received: by 2002:a05:7022:e0d:b0:137:e3d8:b575 with SMTP id
 a92af1059eb24-137eeb4d16fmr917994c88.4.1780424264422; Tue, 02 Jun 2026
 11:17:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260601195358.226233-1-Yongqiang.Sun@amd.com>
In-Reply-To: <20260601195358.226233-1-Yongqiang.Sun@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 2 Jun 2026 14:17:32 -0400
X-Gm-Features: AVHnY4Kx2yFZXsP2DMRR1TCNeampp2m_udzogd5telYn4-z9Qb5yE8UQm-rQA0A
Message-ID: <CADnq5_PJZbwXxO_0_Cko43=Mf=GNecDZtETwwt0jWZhcF0i9jg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix sysfs topology prop length on buffer
 truncation
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

On Tue, Jun 2, 2026 at 12:49=E2=80=AFAM Yongqiang Sun <Yongqiang.Sun@amd.co=
m> wrote:
>
> sysfs_show_gen_prop() accumulated snprintf()'s return value into the
> offset. snprintf() reports bytes that would have been written, not
> bytes actually written, so a truncated sysfs show could over-report
> its length. Use sysfs_emit_at(), which returns only the bytes written.
>
> Signed-off-by: Yongqiang Sun <Yongqiang.Sun@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/=
amd/amdkfd/kfd_topology.c
> index f57da088f1f8..0ff793a17857 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -198,8 +198,7 @@ struct kfd_topology_device *kfd_create_topology_devic=
e(
>
>
>  #define sysfs_show_gen_prop(buffer, offs, fmt, ...)            \
> -               (offs +=3D snprintf(buffer+offs, PAGE_SIZE-offs,  \
> -                                 fmt, __VA_ARGS__))
> +               (offs +=3D sysfs_emit_at(buffer, offs, fmt, __VA_ARGS__))
>  #define sysfs_show_32bit_prop(buffer, offs, name, value) \
>                 sysfs_show_gen_prop(buffer, offs, "%s %u\n", name, value)
>  #define sysfs_show_64bit_prop(buffer, offs, name, value) \
> --
> 2.43.0
>
