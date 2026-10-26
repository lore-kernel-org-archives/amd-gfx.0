Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F7606A320
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 19:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KQurT9On
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B3C210E33E;
	Mon, 26 Oct 2026 19:11:35 +0000 (UTC)
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8ACAB10E33E
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 19:11:28 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-33bb5afa736so537532eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 12:11:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793041888; cv=none;
 d=google.com; s=arc-20260327;
 b=A9G+ECF7JtKzBWTJy02Re/jLxc3h++9rUqGdKekKCoPjVFScjaN4mAl4TIGHL5ht+S
 BVHvH7RguG1fRjG5lG4BycnCG3Vho08eA9WLhmWx7lxcLgH1UcjlKBPQsCg/jaBNHCNV
 COMIDEHSUBzLQQPlSXA8gV1m0itNAqNafP0E1RmGuPPt0TCxDW60IP176g7gIHYn1/s6
 I2v4i4HF1l2T7A/DJzcuLdYZrxrh4h1+qe+/j2wtSY60zgUOek6sVDwVHkqUNh/er1tK
 9kNM04pWFFMmDgPUvi78277xOdwDy9Q+zODv6WPU4doD3tGtCPbfJbd+RskK42C66wq+
 N4ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=orqDPwO+17A32ruW4JGn/JzkWsBDQ1jQWjcWX/wAJ8A=;
 fh=D9vIMsx9Lw4O67CEMT1pc5hx1VM2Hxgi9zV2gI5Zprc=;
 b=r0uYR8BBc+BMzLC47QOa28T1EHLMXuqssuF9I1tutr3FLvoZquCtSJ1I6kAKHFQOSG
 rR6Y8Vp9MftA8U7usRNcFSMP33aNspq1YoZyuj7Mb/Io814lrHUaWVdQ+X2onocnN19f
 YDYkL7mVyWH5DyMbD1JCUtDr+zh9hntR3/NiuAVztco1LN4R5DZNg1y5EdrDI7zD7oNe
 GsQsVbXpc2LisJTEBYhZQTHiUiHTCUIF1NE2puK0ceO+/S2IZfBmaSWKkp7PGBLE33Bj
 a3aLi7ikPBkO3sMrXeRoXC+iskcHtqp3f5JUHlIfW7F15E/4YDZ+JJl9IM1+QNk7B/Yn
 zOrQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793041888; x=1793646688; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=orqDPwO+17A32ruW4JGn/JzkWsBDQ1jQWjcWX/wAJ8A=;
 b=KQurT9One2ATYIrOVeQnkG9y9VD2+EwyrwHZJNCz3NVcXGDTfBe4eRys+lTLIt0yab
 tVK2E3U2Si5wU5fdTZ9N2tUI4qRWHd0Ol48GDSWnbG0s0gnJsrusq8jUG5y0CzvIfyBk
 plgrje6btQZ8pEolSgX9ybEvZBfY8b7Xk6lkv0XTuCZYwZ9SkNGt3B+9/8IIbs2mWUTc
 RQ3BAjc5eUwl+QF35Z0J60vBueYWIc/vqMdxn+S5Iss29ZtVsqpZvpuj77s4jRZCwcod
 t5YG2TP4rryu4X9RxyoRr0p8ubR5ZnPl57EDfFwesWjp+177bwECXWbvP7dTT4XNVV/6
 hWLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793041888; x=1793646688;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=orqDPwO+17A32ruW4JGn/JzkWsBDQ1jQWjcWX/wAJ8A=;
 b=RN+TOirxhvsYp5MuEfyRRtQbBtQB63ViDGeKS23aSnctUCoF30gCjmbujQnBPwsbBh
 gPFx6pYzlKBa6ZnaBsLGvXbH2KeHTIoTH1joBRthmy0JBN/0H3GP2imxXFWipVKZJhNU
 D4oAQ425Z+v51NpYEdxlZAOrJy19tmS5L7uKcOgFo/CA/YkIYkzoT8okNEqY2abW5Mih
 gV0WzSpXdOTZtt36Gz9/mfHVgiFxsUoCUxee2LrDMVtQKq0kFza16WiK3zO5iNTuiGDY
 vV0n9JjrBnjoRgTG5lf7Ny6VuI2TfrYfc2PbMNaAgVC8c5dYiiRqJKErtOupqzTMBD1k
 n/bw==
X-Gm-Message-State: AFq9FYLASPq63E4h5SMZ39deW1TnxKG7GXesOfXR228tMhrt7ejOpZ75
 vwFeyvc+t3+hBhj0zR7ghM1rrZBaFteYgELdrVLAp65SZElUWN24e+duh7wdJDnLvKlG0tSxsHX
 qGDuQJkUI49UExoyzW8XEJQhNV2HywSQ=
X-Gm-Gg: AYBFou3cy0itP6ECdaAneAWlQcqg/WoNSUDAWTJWBjOrjWRA+YymGoFRH3q0j2HjjuM
 NYtWGJ3/RNL4M5DaSpF93z2z+6/YDTtYTj50EOMu4C7S/VXSPpkEJHeUhnDWf+/uviO5+yoxwpb
 /agBLvcsfC2e04V2NfaOL1dPZBtNqS8SZv8mLTQVnBR0kzn/joOqStdPL/y5X2OpjBHE+SnLdeC
 tNfoftU6+vQzHSB26LM/Cck/Z4pP5S6fiwxtlZcFAxgahtfhGS8Md05Ms9oUXn7KiGeipeL1HEo
 h3ANqkyVjwMbziIEw/6Pyso+SXuWD/XypZWkd72+KeRRisiWMwBR+TqfwBs40yXF7OEbr37lE7L
 29Brhw5ApjCQSqcLovVKfJAj1fX5luMcczYgATYHIEwdbInHgVTxliSs5QznqlDSwjdLXLnwJ9r
 KICj8/V4O4zKXM0kgA6q3fFqs=
X-Received: by 2002:a05:7022:5f07:b0:146:ffa9:2117 with SMTP id
 a92af1059eb24-1993639e5f7mr16408072c88.1.1793041887670; Mon, 26 Oct 2026
 12:11:27 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022150302.27962-1-tklauser@distanz.ch>
In-Reply-To: <20261022150302.27962-1-tklauser@distanz.ch>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Oct 2026 15:11:16 -0400
X-Gm-Features: AclHuK9pNx1J2PKwUdRJTn0VtWWRmiL5k0s3zeYvmONUc6HGqg6V6pyrUzrX2wo
Message-ID: <CADnq5_Oxgtvnq7AYY7qa=HA+rmRgOaDK-GROuiMB54CL_O50iw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/ras: omit redundant memset of already-zeroed
 buffers
To: Tobias Klauser <tklauser@distanz.ch>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 23, 2026 at 3:49=E2=80=AFAM Tobias Klauser <tklauser@distanz.ch=
> wrote:
>
> Both of these are allocated with kzalloc() right before memset(), so
> the buffer is already zeroed and the memset() is redundant.
>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.

Alex

> ---
>  drivers/gpu/drm/amd/ras/core/eeprom.c                 | 1 -
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c | 2 --
>  2 files changed, 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/=
ras/core/eeprom.c
> index 40430f0b4d2e..cfefbe848033 100644
> --- a/drivers/gpu/drm/amd/ras/core/eeprom.c
> +++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
> @@ -1091,7 +1091,6 @@ static int ras_eeprom_sw_init(struct ras_core_conte=
xt *ras_core,
>                 return -ENOMEM;
>
>         mgr->ras_eeprom =3D control;
> -       memset(control, 0, sizeof(*control));
>
>         control->mgr =3D mgr;
>         control->max_read_len =3D param->max_i2c_read_len;
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c b/driv=
ers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> index 1e83cb5064ff..f021719ff0a8 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_virt_ras_cmd.c
> @@ -298,8 +298,6 @@ static int amdgpu_virt_ras_get_cper_records(struct ra=
s_core_context *ras_core,
>                 return RAS_CMD__ERROR_GENERIC;
>         }
>
> -       memset(out_buf, 0, req->buf_size);
> -
>         for (i =3D 0; i < req->cper_num; i++) {
>                 batch_id =3D req->cper_start_id + i;
>                 if (batch_id >=3D overview->last_batch_id)
> --
> 2.55.0
>
