Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3069EEB56E
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Sep 2023 20:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8834910E954;
	Fri,  8 Sep 2023 20:46:08 +0000 (UTC)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BEDB10E954
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Sep 2023 20:46:06 +0000 (UTC)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1c26bb27feeso1880523fac.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Sep 2023 13:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694205965; x=1694810765; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPcRT/0yOc2U7/2eC6UrKCmk/UaMc+dQg01yT8hyN14=;
 b=qvdimy/D6l51AC21BLHhjKIX8hPXkydwTKRLGMxr0h0wKH4vkrm2ceFvfkjHdz+QmP
 jPTpaoQJX83w1O9QKVr6NsjRQmUR1Qsg1sgJy5nSVHqRLvtZnf7bYtMDcjmxtEGWadnl
 7paQ8PhbW1AUwWJojqlMGchOnlvxqrMJZUKPpgX2mQrUAibgIg+Rk+XSAuZM0vNa9jen
 /qwHuYu0iWhEcsx6VC35fLrV1qtfWK4AxMEXvoLBOqDYKqd0Vjya6IODCQriL29y3H1v
 5HzaoyVX3uhprm3qH+hamkqcRsuQ+YNOxZQskI1FnGSuAbUUWAC0WGP7Kv4f7sB/ZNyN
 yG6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694205965; x=1694810765;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPcRT/0yOc2U7/2eC6UrKCmk/UaMc+dQg01yT8hyN14=;
 b=JBmOwdGYP7kzIMwvsKLNFV8y15Brpqvts53CeyTMEw6wPYyuxNyTM/hbCxZa/TkYli
 Oz4LKqYvA+gAxnqNcql9ZmGcmzUBRMmF53og42vtEah4cB4uX4uINiXhi/R1nz0eQP0r
 1MDcFSHs3uF17xQZmrw8D5Ze+iDY4biBGCARGtJj7g8uoBiy6SbsCQNPBCYPnh0yvW8s
 oT1+UrvYeFR3EUe1RhuokzXvd/F7q++rZuoWlBUt+WDF4NuIMtzQXoOBr0+4u4JoKDZW
 ddMvjD6Ot+GVUnhPYPgSjogPBF0rupzbeTV0hQ534wfYIzNam6YBmF/bdN08aArgrn3n
 9EdA==
X-Gm-Message-State: AOJu0YxUL8AcANH3uJkuMr5Dh3Py45YSGtywtN/a7cEfWmnI2VlwbiS8
 K44YreEiJ5HgfYk1lgltahnzYih6J9eXkWLLoo43cv3g
X-Google-Smtp-Source: AGHT+IHL9+qc+lnyOg1TeTx2GGzpkqVFMiigtnO8lN2pprDHtLhJcv4b//WuO6u/XVvPJCbnFBkZxryeqcLyNSqAuy0=
X-Received: by 2002:a05:6870:6112:b0:1bf:ec67:f2c6 with SMTP id
 s18-20020a056870611200b001bfec67f2c6mr3697432oae.17.1694205965380; Fri, 08
 Sep 2023 13:46:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230908202950.117169-1-timmtsai@amd.com>
In-Reply-To: <20230908202950.117169-1-timmtsai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Sep 2023 16:45:54 -0400
Message-ID: <CADnq5_M7A9disfTUo9LJ5UPngq2DP9N+CxpqtwvAAQiAjc8yEQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd : Add HDP flush during jpeg init
To: Timmy Tsai <timmtsai@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Sep 8, 2023 at 4:40=E2=80=AFPM Timmy Tsai <timmtsai@amd.com> wrote:
>
> During jpeg init, CPU writes to frame buffer which can be cached by HDP,
> occasionally causing invalid header to be sent to MMSCH.  Perform HDP flu=
sh
> after writing to frame buffer before continuing with jpeg init sequence.
>
> Signed-off-by: Timmy Tsai <timmtsai@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd=
/amdgpu/jpeg_v4_0.c
> index 3eb3dcd56..02b8eca91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
> @@ -468,6 +468,9 @@ static int jpeg_v4_0_start_sriov(struct amdgpu_device=
 *adev)
>         table_loc =3D (uint32_t *)table->cpu_addr;
>         memcpy((void *)table_loc, &header, size);
>
> +       /* Perform HDP flush before writing to MMSCH registers */
> +       amdgpu_device_flush_hdp(adev, NULL);
> +
>         /* message MMSCH (in VCN[0]) to initialize this client
>          * 1, write to mmsch_vf_ctx_addr_lo/hi register with GPU mc addr
>          * of memory descriptor location
> --
> 2.34.1
>
