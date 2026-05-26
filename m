Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10F34CD5BC8
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 14:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A32AF10E1AF;
	Tue, 26 May 2026 14:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MVc26bQD";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B522C10E1AF
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 14:53:05 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-12db2e9b3bcso342201c88.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 07:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779807185; cv=none;
 d=google.com; s=arc-20240605;
 b=AUZhVBiT60X7EpOQUv6t7XrNJHu3sWaPd4UvhMWJkOQifxEu8PDdHBAcIl6buwtqrM
 mQL75B8LOErapOOvLNs4K9bjCPXoICqQbM5oXvgDe463mf+Qzdb3XOlPh8bFEXhObnzq
 MwVqhuTfqsPWVjuuwynkRRrYXmPi9OatKpGOtEsdy+6iA4pMcl4X9tCfLF2TPUYquAhc
 5fykQL1sjT0LXFR2clRUXq7OLPApE5cR81kg6v7mHfdO3oO+YIXf+PNiBm683AiyuEWf
 SUxArOAe1kmIr7ArI7oYH6ulU3Q6Ci6PSbVWei5h/jb9peV9L/QpQL/1w3ojhA4E48QR
 xSoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kuzpY6XgB0sl9R2wkZih4Zz2Dy5QZS8ND0a9lUvUZwQ=;
 fh=/rtGc6rf8PspTycm3VZjfWvkfqBZxwpogWlPVMaXuoc=;
 b=VO8ttoVtZdJlADYjImzqgLAk7/EP9+DtducB9P9A5akWR08XXR5GIZnY7tTmT40UWA
 Zda8w2qNACXzpQCHlmWrjWz54a7jgcthfqBoYl6HFv+jPac+3ONoDPJAQzvBtJdW1i/t
 s6+DBqIARO2VXR4fxS3j6ERN+Z3dvV1zsSMYAvdNcJdZjlmi3uflAFH+NmadOzBRAnD4
 GIGa1w2OHgbWH7aBbSBgvuiTJicRkSs+pp7KEbVl90cG/0LxJtj/DDhIa8AJhtFqd21S
 E6RuQ5QagVIJwVqKoVrc9AXQQ2ybAuRetekuPppDVocn7b0aLm/ddYzQPqUH2lMtUSJV
 8I/Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779807185; x=1780411985; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuzpY6XgB0sl9R2wkZih4Zz2Dy5QZS8ND0a9lUvUZwQ=;
 b=MVc26bQDm4q0rXKyurX2HyLEwCa/yeFIYFAP8FDXcpKNJVdap7aaSRqLY8IbCru1Hr
 6w/0xdyspfjUqCP31c1AiZfIApCYO3b848HTT4l/CJVUWyJLt/Fw92ASFjxAG/mv2gWx
 BVwln6XFAaXjOtCm6oSIEiogfbM4DV1c3d7TkfzrnbRlXKjzDFR6ZvTG1PY8NqtLxumK
 KLomk7ltzjY1rcpNDNBI5Yjkf9lSdyrtEgsfih5yDk0IEPJoJLLwIbdsmqHVSVvEovWg
 aHbhP4Vri4n0jw3OjnbTn+DS5zU/fIiNCkO7jz1hVMAL+VbiJQ/E69aDqsRffMJU72lK
 2P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807185; x=1780411985;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kuzpY6XgB0sl9R2wkZih4Zz2Dy5QZS8ND0a9lUvUZwQ=;
 b=ZQowuiFdSlu3OGGk22BOzluNqXF7+sWUeupzmYYYmWyIxahR3uHAA/6dCwidTT6s89
 5oEndJ/Sdq9or4qIYJ8BaW3+LFeT5kUOrN2AW0KYY050dyWpMptWd2zU3Yi0oKtjcqsA
 /Auft8z/47jCAFZP2G4qfqHrboKlDtvwLtKElhM7zJEuAPDhJ7d9e7VrMmAkkKNvwlOG
 l8AYSypr7w3FVFR7hZ4EFmzMVaz6xMcReQA2VX9v/jlXGoNf/GKsd5ZXoQOtCo8fb3vd
 bTSMtB6KSQ8b3kv0MBAACjeYQoOrtFH12TPsVmCVfT1YV1OGbWMQqwF1J2v1PP+7ptjE
 lk2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/D5OSQy9Wm8w5f3SQJ+gVwx4+OCt+tHYkAjxbQWu+h1CI/HrSy4diBs/xtp+GewWpeJbnhwnax@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZJxP40rNBFfvYtrG6lvfanDpS+blxYwU/oqCogssEmWFec17W
 zzgRWJE6w9IS+j/0LI7qlpg0ct+jUxbgs56KP/lnF0i62+pCzsTvBbupWQJJRbI+lZzJYxbvd1F
 ZGqr8adYpDuwxVknRsitQOa3o1rGB9jc=
X-Gm-Gg: Acq92OHGIQr056/dM3iUWvEH0cHHhc5SE/CkybSfGUbMZODQSMjHNDI/5j42X3YCTiG
 CpLvsZps5id5BN2L8hADNNJB8PUdOjnPMzh9/ritzcTjQxfUldiZjMqWcAceBWJ53UlgULQ0Wox
 xfjXjxIoORxi+cpucfb+AspwFrbg0rR27qxgNCRQgIX8cCTk5urwk691Nzv3XOR5xjSifBNRBkV
 tQWE//e06t5J15TvZtHKP7o4v3e25RWOzLaIox4yhB+gqM4SyPQjOAUDOxqC9ngLCtlCS9JRn/j
 g+K66VV0uat2T1oGhlv1sJ2gKgkenZbEsL5JQDvITOTS5Ez8fwh4W4s9HV2VRPmYdAKidXJXIpG
 mlwO1
X-Received: by 2002:a05:7022:626:b0:134:d037:aca3 with SMTP id
 a92af1059eb24-1365fa3ef8bmr3010059c88.3.1779807184983; Tue, 26 May 2026
 07:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260519030624.51613-1-leorize+oss@disroot.org>
 <20260519030624.51613-2-leorize+oss@disroot.org>
In-Reply-To: <20260519030624.51613-2-leorize+oss@disroot.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 May 2026 10:52:53 -0400
X-Gm-Features: AVHnY4LcPsiYYQmh-1BOJDsIdKpDtx2NbLr3E_yI9k27EGP0u5MvvjHIjHnWQ-Q
Message-ID: <CADnq5_MrUaLRP70hwb5YGawjfft9qUaH4h_t4TQ17AEgAwj3ww@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/display: set MSA MISC1 bit 6 when using VSC
 SDP for DCE 11.x
To: Leorize <leorize+oss@disroot.org>, "Leo (Sunpeng) Li" <Sunpeng.Li@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>
Cc: linux-kernel@vger.kernel.org, Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

@Leo (Sunpeng) Li
, @Wentland, Harry

Can you take a look at this?

On Tue, May 19, 2026 at 3:19=E2=80=AFAM Leorize <leorize+oss@disroot.org> w=
rote:
>
> When BT.2020 colorimetry is selected, the driver sends information using
> VSC SDP but does not set "ignore MSA colorimetry" bit on older GPUs with
> DCE-based IPs. This causes certain sinks to prefer colorimetry
> information in DP MSA, resulting in terrible color rendering ("dull"
> colors) when HDR is enabled.
>
> This commit wires up the MISC1 bit 6 for GPUs with DCE 11.x based IPs to
> correctly configure sinks to ignore colorimetry information in MSA,
> resolving the color rendering issue.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4849
> Assisted-by: oh-my-pi:GPT-5.5
> Signed-off-by: Leorize <leorize+oss@disroot.org>
> ---
>  .../drm/amd/display/dc/dce/dce_stream_encoder.c   | 15 ++++++++++++++-
>  .../drm/amd/display/dc/dce/dce_stream_encoder.h   |  3 ++-
>  2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/dr=
ivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> index ed407e779c12..2c3a20d35fe9 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
> @@ -271,7 +271,6 @@ static void dce110_stream_encoder_dp_set_stream_attri=
bute(
>         bool use_vsc_sdp_for_colorimetry,
>         uint32_t enable_sdp_splitting)
>  {
> -       (void)use_vsc_sdp_for_colorimetry;
>         (void)enable_sdp_splitting;
>         uint32_t h_active_start;
>         uint32_t v_active_start;
> @@ -334,6 +333,16 @@ static void dce110_stream_encoder_dp_set_stream_attr=
ibute(
>         if (REG(DP_MSA_MISC))
>                 misc1 =3D REG_READ(DP_MSA_MISC);
>
> +       /* For YCbCr420 and BT2020 Colorimetry Formats, VSC SDP shall be =
used.
> +        * When MISC1, bit 6, is Set to 1, a Source device uses a VSC SDP=
 to indicate the
> +        * Pixel Encoding/Colorimetry Format and that a Sink device shall=
 ignore MISC1, bit 7,
> +        * and MISC0, bits 7:1 (MISC1, bit 7, and MISC0, bits 7:1, become=
 "don't care").
> +        */
> +       if (use_vsc_sdp_for_colorimetry)
> +               misc1 =3D misc1 | 0x40;
> +       else
> +               misc1 =3D misc1 & ~0x40;
> +
>         /* set color depth */
>
>         switch (hw_crtc_timing.display_color_depth) {
> @@ -499,6 +508,10 @@ static void dce110_stream_encoder_dp_set_stream_attr=
ibute(
>                                 hw_crtc_timing.h_addressable + hw_crtc_ti=
ming.h_border_right,
>                                 DP_MSA_VHEIGHT, hw_crtc_timing.v_border_t=
op +
>                                 hw_crtc_timing.v_addressable + hw_crtc_ti=
ming.v_border_bottom);
> +       } else {
> +               /* DCE-only path */
> +               if (REG(DP_MSA_MISC))
> +                       REG_WRITE(DP_MSA_MISC, misc1);   /* MSA_MISC1 */
>         }
>  }
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h b/dr=
ivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> index 342c0afe6a94..88d6044904d1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
> @@ -96,7 +96,8 @@
>
>  #define SE_COMMON_REG_LIST(id)\
>         SE_COMMON_REG_LIST_DCE_BASE(id), \
> -       SRI(AFMT_CNTL, DIG, id)
> +       SRI(AFMT_CNTL, DIG, id), \
> +       SRI(DP_MSA_MISC, DP, id)
>
>  #define SE_DCN_REG_LIST(id)\
>         SE_COMMON_REG_LIST_BASE(id),\
> --
> 2.54.0
>
