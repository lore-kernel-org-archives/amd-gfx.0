Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64095C36010
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Apr 2025 14:46:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F56910E4CB;
	Mon,  7 Apr 2025 14:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eHda/Ri8";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E99810E4CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Apr 2025 14:46:46 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-30363975406so844251a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Apr 2025 07:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744037206; x=1744642006; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PF9R/S8ZPPO3ZalwcM26aZldQr2EeQ8a3wXsf/caOKo=;
 b=eHda/Ri8l9DU80xMvI0JoH90GlkkIXpHpHE1vbjnV5Rdv0OhVKQyC4NunqsS8L/Pr1
 zl+Y82qaAeW+C4EDYy/IV1EgZVeSYGIOztDq41T0XzSsGc1hNylyvSm/SflzE1HU+bLM
 pFv0pHSC/w03ut7hVWaTw9WLt+NiK93DUKS5NwNMTwGB+hos3IdmaZSfojXX/70sNQK+
 VvJ4f5yhrmLv2yfjAYlFvfOejMYTRLdmFCWZzCN7+NnV0AKxPLQtvkUnK8P7w/ttSP+s
 IuQ1UdgMRU2yxtf/IMdUuqDkMC75RhdZsH3s/WeVGSXC5NoQFXxtDGYJwW3UKpn8+88s
 dUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744037206; x=1744642006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PF9R/S8ZPPO3ZalwcM26aZldQr2EeQ8a3wXsf/caOKo=;
 b=oPbSApes4IeY048n/f10QF1EHu+xLZPQp9EufRPPNfo6H8KGbOZQHg4kB0GpaJn9wq
 ofu9sg3zQ3yLdlcfs120GGR2zurjSiq68bFDdXJbGzLeFp1XvqcqNERjXtVAH8qDVQZR
 V3woGuDUMj6plwwB9IT/a9IE3qoyuBGj1nGFLLUZXRxHHwkDuMI/29SPS/DdoyL9pY7S
 lAxPXPUQpCaCn3dBCuD9UqhvQ9M6RQ7sQofPmbVoNsPw237OrDA4DdAeXh3KFTvZdgWZ
 pvyLpJpI4ZHVKQ9IfeqVSMa/NbOopJXwl3smtDgymhjlQwBbmjZ93Tz2Iz+9t8PkA3YM
 Dvhw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOaedgRl3fQRUiyu5p05YZlff19CzS+nRrn+YHT9wCbU6s4WE5r0qdlfoxbrc7oi7i8FISZcSi@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjC44ehQJYlQeiQStPaOU8xZjlUZU7f490t5+hXWe7vlKiy8Io
 bSbnXi9LX52SufTXed0bEnkrtDKvQX5FkXT59TN8h55Fv+kM60VL0eOuxLgS/MoEh49QdwWCsZ7
 EYRKbYRKxcn9esAOUSCqGHLbkSN0=
X-Gm-Gg: ASbGncv05wM7sEzHWRm5yVHVNoArZ108/vthP5c/X2HXo86xiYi5EKPvKfILkJCZm1x
 uhH0jmIcRB7I1sY2gO21DroHxmZV3r8lExFKspE4B8M18m5QY1dhv/Pm25u8OX1yTXGvJCOU+Ug
 jvsC5mNbKmJjM8FJuWDo1SxL8fLLM9xftaGEFG
X-Google-Smtp-Source: AGHT+IEpKxCcTJ4l0E00ytijgvQ6dGbKbFDtQ/Ut00NQAfzQcU0owitZEvJTNQTo4GxgvjJ2nZdnFNmkLD+Wii+hzSQ=
X-Received: by 2002:a17:90b:3a88:b0:301:ba2b:3bc6 with SMTP id
 98e67ed59e1d1-306a496b929mr6218758a91.7.1744037205586; Mon, 07 Apr 2025
 07:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250406230703.2128148-1-siqueira@igalia.com>
In-Reply-To: <20250406230703.2128148-1-siqueira@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 7 Apr 2025 10:46:33 -0400
X-Gm-Features: ATxdqUFRYbhh5jdyTqp6NeaOuYvgbxBIEPF8apYkole15V3jhrujJaDs1UgB9dk
Message-ID: <CADnq5_PXoWLMdG4a+pHkPn2PipgoNvb92-o8MVqEYxr+PVznKQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] Introduce a generic function to get the CSB buffer
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Mario Limonciello <mario.limonciello@amd.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Sun, Apr 6, 2025 at 7:07=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.co=
m> wrote:
>
> This patchset was inspired and made on top of the below series:
>
> https://lore.kernel.org/amd-gfx/20250319162225.3775315-1-alexander.deuche=
r@amd.com/
>
> In the above series, there is a bug fix in many functions named
> gfx_vX_0_get_csb_buffer (where X ranges from 6 to 11). After closely
> looking at those functions, it became clear that most of the code could
> be shared from gfx6 to gfx11. Aside from the code duplication removal,
> this also improves maintainability since a bug fix in a shared function
> can be propagated to all ASICs.
>
> The first patch of this series created one dedicated file for
> encapsulating common GC registers (gc_common_offset.h); this series only
> adds registers associated with the CSB. In the future, this file can
> keep growing as we identify common registers to be shared in the
> gc_common_offset.h.
>
> The second patch introduces the generic gfx_get_csb_buffer function,
> which has the same implementation found in gfx_v10_0_get_csb_buffer and
> gfx_v11_0_get_csb_buffer (these two functions have the same code). After
> that, every patch is dedicated to absorbing one of the csb_buffer
> functions from gfx from 9 to 6; notice that some adaptations were
> required.

I don't really like the register header changes and moving all of the
IP version specific logic into the common code.  These register
headers are used in other places as well and moving some registers
into a common header can get confusing and may lead to bugs later if
other chips change the offset of these registers.

Alex

>
> Thanks
>
> Rodrigo Siqueira (6):
>   drm/amd/amdgpu: Create a headears to keep some common GC registers
>   drm/amdgpu/gfx: Introduce generic gfx_get_csb_buffer
>   drm/amdgpu/gfx: Integrate gfx_v9_0_get_csb_buffer into
>     gfx_get_csb_buffer
>   drm/amdgpu/gfx: Absorb gfx_v8_0_get_csb_buffer into gfx_get_csb_buffer
>   drm/amdgpu/gfx: Assimilate gfx_v7_0_get_csb_buffer into
>     gfx_get_csb_buffer
>   drm/amdgpu/gfx: Merge gfx_v6_0_get_csb_buffer into gfx_get_csb_buffer
>
>  Documentation/gpu/amdgpu/amdgpu-glossary.rst  |   3 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       | 101 ++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h       |   1 +
>  drivers/gpu/drm/amd/amdgpu/cik.c              |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c        |  51 +--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c        |  53 +--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c         |  46 +-------
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |  70 +-----------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c         |  51 +--------
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |  43 +-------
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |   1 +
>  drivers/gpu/drm/amd/amdgpu/si.c               |   2 +
>  drivers/gpu/drm/amd/amdgpu/vi.c               |   2 +
>  .../include/asic_reg/gc/gc_10_1_0_offset.h    |   3 -
>  .../include/asic_reg/gc/gc_10_3_0_offset.h    |   3 -
>  .../include/asic_reg/gc/gc_11_0_0_offset.h    |   2 -
>  .../include/asic_reg/gc/gc_11_0_3_offset.h    |   2 -
>  .../include/asic_reg/gc/gc_11_5_0_offset.h    |   2 -
>  .../include/asic_reg/gc/gc_12_0_0_offset.h    |   2 -
>  .../amd/include/asic_reg/gc/gc_9_0_offset.h   |   3 -
>  .../amd/include/asic_reg/gc/gc_9_1_offset.h   |   3 -
>  .../amd/include/asic_reg/gc/gc_9_2_1_offset.h |   3 -
>  .../amd/include/asic_reg/gc/gc_9_4_2_offset.h |   2 -
>  .../amd/include/asic_reg/gc/gc_9_4_3_offset.h |   2 -
>  .../include/asic_reg/gc/gc_common_offset.h    |  11 ++
>  .../drm/amd/include/asic_reg/gca/gfx_6_0_d.h  |   1 -
>  .../drm/amd/include/asic_reg/gca/gfx_7_0_d.h  |   1 -
>  .../drm/amd/include/asic_reg/gca/gfx_7_2_d.h  |   1 -
>  .../drm/amd/include/asic_reg/gca/gfx_8_0_d.h  |   1 -
>  .../drm/amd/include/asic_reg/gca/gfx_8_1_d.h  |   1 -
>  30 files changed, 141 insertions(+), 328 deletions(-)
>  create mode 100644 drivers/gpu/drm/amd/include/asic_reg/gc/gc_common_off=
set.h
>
> --
> 2.49.0
>
