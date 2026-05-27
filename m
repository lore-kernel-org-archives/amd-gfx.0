Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC11ACD4F54
	for <amd-gfx@archiver.kernel.org>; Wed, 27 May 2026 20:15:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7055A10E2B1;
	Wed, 27 May 2026 20:15:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PC+z7DxK";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A46D10E2B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 20:15:58 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3042a99f0ceso643932eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 13:15:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779912957; cv=none;
 d=google.com; s=arc-20240605;
 b=ZPrGmdzJXAbyC/ZLOwIVVFaLuGOgiGmGcjA0Vbjg2zUvwv4iuHDGDaJmir08EIKQ1U
 8NeqqBhq42XOeS0wZGVLBAbs30jX5uFP8tOyzydeX7bnCpfkSiL011ZdjeMNnsMNaGmc
 PFjHCfrs1SCWhtEvgOnrsP4xJnZkFCJ/tgzSA90yCsYfVfVofOFJjwB/YxXXCFMSkrST
 gc0JDisryW6tj2T2L3HaRyaIL5xNGrpeb69dPWWqOncPf733zxu9ompITm/v2u3DNXqr
 VT/97y4GBG1Ok7HnXsRdyCy7yeVbWIX4k6drplD2FfApFb2XD5M/xt/wB4bDv0DYd6xH
 lgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HHTL2lW8xBsxHYofChLogKIIcw+GuM7d5qBPyd61uV4=;
 fh=QYTOPa1tuyaAXX9RWsack1ix6tdGANHo7BRVYX4Rg6s=;
 b=aw0SvH6ZWEfL9F2Lsh4KUgCFaDLGyVgdCydF2/xCA2RTUWIezIDf77Nmk3DuqPNRBu
 rDvYoPg296H2mdMsh5ryml0oc6eR4KLGZ8Rs8CWYlNfcrm9QypRrGS1L9af4VrIuKKRY
 DP7zV3lx+Ewt6yrkNFDZw9nq77hh3b3+0SO79MrSvqr2gOcBOcc9dZMOXKCLAQZ89MWd
 roNn23ZOhkBHkOhCH0CdeQbz9Q8JoM60yD9zx3cYa0W/wUxx8+AWZ8d3S7ArFE7zTxmU
 FsnspPX0ZlJoSArTFnm5Kbb5dR0HuxJv2OLGIUnVuwbPrZG/gmzpTpUVAUhgoXSif26Y
 U0GQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779912957; x=1780517757; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HHTL2lW8xBsxHYofChLogKIIcw+GuM7d5qBPyd61uV4=;
 b=PC+z7DxKtKfz/7NgS0Yxnb1d1Hq4aoRafDxTjhDSmXDljk4TcAqUPaAXFQlIDvOpXg
 fGXsu8YzSwf4Qt8xEcRZG/FMF3besTW2v13pwnCMVxHYy2qabKce4XrmWnWLFOUOITKH
 sL1knTMQi87fZ3y2qL4IC/MuivCKUnocZu1MLa1nLm2GU9jcvBomMW1qw+xP5q6JSlrN
 wlyqwUtPvPWW8TksSvD6S4NUvP9kP5cazXuAKQ2S16nlv5NDdI2CLNfWZd5lVUoNxwd3
 q1BwUGOklUAaC18qXtRJtLmWr7NAlP3wW5gycf5F4IOiePIVDGWYCWyTSoEv3j/qiaQU
 Hyxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779912957; x=1780517757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HHTL2lW8xBsxHYofChLogKIIcw+GuM7d5qBPyd61uV4=;
 b=JKMhlNzlJg4FK4S9f6z1YOZBJirx4sDSBqblwfQmbWNVtgoGCynsivz+JViW/up30h
 L+jxDxXC+axBIlrMv+wbMYwn6hQye3Q5T8RBkSMoWVw5Y+6+dmierDXPbcw6t5AW6tCt
 fErpPTRa8MyqJu0O7X3GtwomQnSRYrhM0xqsa5VnAl0LsUrXCvB03O5kZ9p5cvMokVEY
 BjZ2quX6KsEiy7U0VdgSI1c991Bfr+wwHn0AEh4mp0mNxO/mGEgK/P88FRB+nUD3L0pq
 V+o5aNXSvr2PaLvj5tHCp8Kt370IwWsceqsak7O4awmUtpqc62Ru5/M+CXZXleuvXA82
 5ulw==
X-Gm-Message-State: AOJu0YzpEnBnWBwyH7dVsxizBlQN6iJXehWjMV4uu9nAUygrYuwJ9dfM
 WnKBJkrTr73tpNFBEcoQSfPw6mUV5+GpOuUU4QXgOb7Qr3K3U1ZT2dAWMej3y25VzfAtJdzs+ty
 GocC7DdJz0nIpMfVly5epfO8iUl4z6ZU=
X-Gm-Gg: Acq92OEOP7ZQ3ti79/Sgfi15PYEJcpH17v84qt8JLFlZQmDf3mfXl6PyqttOf4fqgP3
 wsgXlv2lSdJ5nFh+DXcqp7abpNX0iGP45S9wRkrWpXqh5daxsCQjCV0dIdboP1sbilSMVmCEtYA
 5F2LnncH4BzFLXAOfSW35NWFpPMyjNF7u+fgHNXnBG2oKm1RnXOF+aOI33t46z4zTajqz/c97Rf
 PXxuMfAgG8jYGFZ24EZRtE7R0Gr7ei6eBVddOqmwJgYte01b43NdXJmI9A5XjyoBHni/I7JB3E2
 sJCK2fS7CUZq2ocKoSC05CKpeHMta53pJDsPV2OsevQf2U2mcgNv/TwCaL3nYOluW7LgzmKd6U+
 bP7vl
X-Received: by 2002:a05:7022:43a9:b0:12c:900b:9dee with SMTP id
 a92af1059eb24-1377c95c89fmr71818c88.1.1779912957122; Wed, 27 May 2026
 13:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260527194151.2253853-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20260527194151.2253853-1-IVAN.LIPSKI@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 May 2026 16:15:44 -0400
X-Gm-Features: AVHnY4JPIK2hBY8QIrGP4xGirBtqxWhsqmqFpPKALIcEi2DeigIBteA6TGFnnlM
Message-ID: <CADnq5_OCM_6B19XQUZr650MNkXR8riaYbdytxdKRK=FF-f-sOQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Add a default case for dc_status_to_str
To: IVAN.LIPSKI@amd.com
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
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

On Wed, May 27, 2026 at 3:43=E2=80=AFPM <IVAN.LIPSKI@amd.com> wrote:
>
> From: Ivan Lipski <ivan.lipski@amd.com>
>
> [Why&How]
> If a parsed dc_status case is not covered by the dc_status_to_str, the
> switch case is skipped, and the function returns
> "Unexpected status error".
>
> This causes build failures when new dc_status enums are introduced.
> Changing the 'return "Unexpected status error"' into default resolves it.
>
> Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_debug.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu=
/drm/amd/display/dc/core/dc_debug.c
> index bbce751b485f..44028ba88f80 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
> @@ -272,9 +272,9 @@ char *dc_status_to_str(enum dc_status status)
>                 return "Fail DP Tunnel BW validation";
>         case DC_ERROR_UNEXPECTED:
>                 return "Unexpected error";
> +       default:
> +               return "Unexpected status error";
>         }
> -
> -       return "Unexpected status error";
>  }
>
>  char *dc_pixel_encoding_to_str(enum dc_pixel_encoding pixel_encoding)
> --
> 2.43.0
>
