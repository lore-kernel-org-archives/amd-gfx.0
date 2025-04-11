Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F8C8C369A2
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 17:56:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF7F510EC4A;
	Fri, 11 Apr 2025 17:56:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ui/Ag1eI";
	dkim-atps=neutral
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E28B010EC49
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 17:56:34 +0000 (UTC)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-301a8b7398cso350997a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 10:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744394194; x=1744998994; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zq/699aiOhiR8Q9ZTh3kDOD1E+qeTq4F+Q35l4YSaRI=;
 b=Ui/Ag1eIuHpAl/EMsyv/XUThYmoaKu6XCtjGn5g2SXOGngrXXEo8pG6GAZxfzw21jt
 j4XIgu+4w/5WoFE1n/i2t98bdPpj7t/HJaY7udRXbsNR3NL5DEk1wf44duk/zA5wvnk1
 7wYPdKYRYIGhmdGG4YiDqDPPEtr30w951ggwNUbGwiygEti5gQKirsfECtSbqm2A6BKK
 hr14zZZUF/nDVrf3DwPqE4rUBWBmS4m4NaFcdkP1u+BWtDARYQZ91Nk2prGABYA+c0qS
 jDUwTybTFC56ZYeKc+94jQ7zZccZNYSm9LVvoASx45x6OE92KdMezFcfVehFfZr3/oBT
 wqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744394194; x=1744998994;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zq/699aiOhiR8Q9ZTh3kDOD1E+qeTq4F+Q35l4YSaRI=;
 b=DO+uNuUxGoTaIH5vaDTspyH3O6/xjWLcwJnzghnMsuhJBVGOMo3WTsejukcbBQiBuG
 6SFCI5BuCTJgcjs87LudsxWZzIJzAjr2a1NXPBePNPLvqoHjDGdjwOYGYuHd+I5ohsBd
 RDrkL5XD/TwD/brnIZrFNT1xEQtYn6gbK1jy2xAXKZE4jOhSYlyMzCm28gqbpDtzBZW1
 ypLcHlzPXPLUTIcTlE+9tN781WmKc+aDlxYErLRfkChmsRZc0s2gzGwqnRtJBSTKxiJx
 OS3vfIBq6K/PlgAXFZy0jzSsLY+5vwp6Rl2kqxyMiHjrv4tc3uORrf5l9sClbki6Mbhi
 k2aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgX3KXUSYuMvaHSMbu8MZQNLwIFxr2/bH9cx5w2E0oaSs6G9OkEvKKyzG2PcxGzrNp/q4Mhblr@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybYj7nA5qr1qQnBQ914E8bpEnkm4LvWluHRqnA/50CWB5VNqPM
 nRZ2Lgg7qctS+lV9U39uWUZA+juxX4fWyR8FsX0vJYS6krWEVSyNmdWXbOB/7/A2UI5rWO4T5wv
 wu1r79JnHKJRug4OZtf2NoxD9MC+zVw==
X-Gm-Gg: ASbGncsTTK2uPuD40jxl1zccjkSbK+wG6W/Q4KVoeaE/Ju8LBVZaQkv0+aRPp5TabnX
 IQIQ194Dz4XpkaDGqS0yfaDKXxoHp0FIt/EukMvhySh9OityiguEmzHRVxMf3osx7y+99dwJR25
 9rHtVEHPx2/A0o5hdW6h16Yw==
X-Google-Smtp-Source: AGHT+IFRBNL2SXvffRMNVL95X7Tsb9b//oHZjqIoHRXZZzlcaLuFfVWQo5q19HhU0E9FLVurgYMXpLgKO0Gss52WuvU=
X-Received: by 2002:a17:90b:1e51:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-30823775b41mr2030484a91.3.1744394193660; Fri, 11 Apr 2025
 10:56:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250411173942.3324241-1-srinivasan.shanmugam@amd.com>
 <20250411173942.3324241-3-srinivasan.shanmugam@amd.com>
In-Reply-To: <20250411173942.3324241-3-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 11 Apr 2025 13:56:22 -0400
X-Gm-Features: ATxdqUHRfCIkZmF-JxXsO4kzOrKsU0eU-1PivUl4Q6oqw8ObYk-JaradooF5h8M
Message-ID: <CADnq5_MHhVqWdkMdzMBE-juruuP5JNwQcR6HP05=nzPU2=+QeQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: Enhance Cleaner Shader Handling in GFX
 v9.0 Architecture v2
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Apr 11, 2025 at 1:40=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> This commit modifies the gfx_v9_0_ring_emit_cleaner_shader function
> to use a switch statement for cleaner shader emission based on the
> specific GFX IP version.
>
> The function now distinguishes between different IP versions, using
> PACKET3_RUN_CLEANER_SHADER_9_0 for the versions 9.0.1, 9.1.0,
> 9.2.1, 9.2.2, 9.3.0, and 9.4.0, while retaining
> PACKET3_RUN_CLEANER_SHADER for version 9.4.2.
>
> v2: Simplify logic (Alex).
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v9_0.c
> index e62c77b3934a..a63ba6642b18 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -7387,8 +7387,14 @@ static void gfx_v9_ip_dump(struct amdgpu_ip_block =
*ip_block)
>
>  static void gfx_v9_0_ring_emit_cleaner_shader(struct amdgpu_ring *ring)
>  {
> +       struct amdgpu_device *adev =3D ring->adev;
> +
>         /* Emit the cleaner shader */
> -       amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADER, 0));
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2=
))
> +               amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADE=
R, 0));
> +       else
> +               amdgpu_ring_write(ring, PACKET3(PACKET3_RUN_CLEANER_SHADE=
R_9_0, 0));
> +
>         amdgpu_ring_write(ring, 0);  /* RESERVED field, programmed to zer=
o */
>  }
>
> --
> 2.34.1
>
