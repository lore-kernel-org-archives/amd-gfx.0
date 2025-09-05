Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 591DBCA0FED
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 14:08:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18CA10E150;
	Fri,  5 Sep 2025 14:08:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EC/b2Sc8";
	dkim-atps=neutral
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com
 [209.85.210.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA2310E150
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 14:08:57 +0000 (UTC)
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-77240e78306so197454b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 07:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757081336; x=1757686136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ymA1AIM6fJ5mIbhggNAX7Qu+bL/HaQyVg6XI/GzcY04=;
 b=EC/b2Sc8teb9ZrAfDb3s3TEV1ZOMrFpj+lp8UYJqTPkHvwQnjLvgqxlOQvHY20JLPQ
 3N3gKe91WP3taubRbPkMIhK4DrTVDj/20kgh1mwNDUma8iPpchtmbRjHMIowy1XFVXUS
 1ND6cU+iX2lD33YODPZ76fEwSEWKnn86/VoknFHlOpCEysjmhNDEndkKzNJDt0cEtuvh
 +q9T/MsPkPaPEiSnbovF/ZCJHj/kC35HziNkcyPMUX00K2h2Nl5SjlgzOHUQwOMiSXj5
 13B3D7leLykpaMJohV7tb8R6o4NZy2Da+QX9v42SC2HrU0jfQvCH2QHpbNmhfMNH2nIi
 TihQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757081336; x=1757686136;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ymA1AIM6fJ5mIbhggNAX7Qu+bL/HaQyVg6XI/GzcY04=;
 b=LtflIgMp8MKXRI1dNrTWjXgL+XergiuQz3QC/bEz+ZUeNgJ2TRo/S1KR433hUpNyrH
 KmhBGbSxqxJlw5ZYBWoja1ZLcrJg8vgF6CJf9Ud6bOKNo63JOcaKJHmvArj4TGpAgyD+
 0rA49cn0UBjsQEbfMw0nLJienCq/FNpTUiFxDa3QOBQQPljcfvV3aorV2jh1+NnmM5nl
 2V4LBa5HELnOP0tfhO7n2VC8MQoLznVHYYHhnJIgp7hs9N3Ob7Pl8HVUxq4/aZcB6Bzw
 PWD5Mwyaru0ZPRA7WVbE26WRTXeQOSvLZAfbU5YbMpH7mhh5fx0GtgnXPAVUSzlMZZZz
 l3+Q==
X-Gm-Message-State: AOJu0YwqsBBQV74Duhk3x8NeJGZRwT1/bRDECzvpLTYROnDtv+qMdtq2
 d9/vn3BBn+Nn8eIc+NJlSHgCfQ2HjHRl4tUReXDK7Ih/NBT7G8JtnL6G78Ki32eSt4iv3dQnC9D
 QWJfmjNGuZNI34NS+JkpWvogLZ0gBp6KO9A==
X-Gm-Gg: ASbGncuHg+Y4/kujlcETQqKgiYSwNE80yyzhRqux/KF8qWpA/PMua91vI69sBA2+Obk
 zHh57W9IgEnVYYd5/vU0x4sIPFQBimkUS5NSyS6+5ZRWYOK/KzmW0H2K6DFfbgPk6XcLbzvc7So
 NCjBkv5trvKGcrXTgO7/auazS87m/T0j4XRMUvWiE3hZqhJCuNpr8oH72QmNamfxiWg3limHes0
 2m9JA4=
X-Google-Smtp-Source: AGHT+IHt4WuX7Y2yKm7CjIahsQDLhSTqKfK/VLsd9Wqo5yXiFmg+qTqicIEUqFzKe72nTyObrmx0o3YxHXqhMDdUveg=
X-Received: by 2002:a17:902:c40e:b0:246:7702:dfd9 with SMTP id
 d9443c01a7336-2491f113dc2mr199121445ad.6.1757081336549; Fri, 05 Sep 2025
 07:08:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250903164402.4002993-1-alexander.deucher@amd.com>
In-Reply-To: <20250903164402.4002993-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Sep 2025 10:08:42 -0400
X-Gm-Features: Ac12FXw233BUWYAnjC4Gj1JOyzLtXu6MdOXop_hYl8p12-tYgfwjJ4Ue5WIw-_0
Message-ID: <CADnq5_Ov+ziZL=4L74PpCB9z7JteWRR=9A_gdXWHYGx+qN0O9Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use udelay rather than fsleep
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Wen Chen <Wen.Chen3@amd.com>, 
 Fangzhi Zuo <jerry.zuo@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>
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

Ping?

On Wed, Sep 3, 2025 at 1:09=E2=80=AFPM Alex Deucher <alexander.deucher@amd.=
com> wrote:
>
> This function can be called from an atomic context so we can't use
> fsleep().
>
> Fixes: 01f60348d8fb ("drm/amd/display: Fix 'failed to blank crtc!'")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4549
> Cc: Wen Chen <Wen.Chen3@amd.com>
> Cc: Fangzhi Zuo <jerry.zuo@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/dr=
ivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> index 7d24fa1517bf1..cc377fcda6ff9 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
> @@ -955,7 +955,7 @@ enum dc_status dcn20_enable_stream_timing(
>                 return DC_ERROR_UNEXPECTED;
>         }
>
> -       fsleep(stream->timing.v_total * (stream->timing.h_total * 10000u =
/ stream->timing.pix_clk_100hz));
> +       udelay(stream->timing.v_total * (stream->timing.h_total * 10000u =
/ stream->timing.pix_clk_100hz));
>
>         params.vertical_total_min =3D stream->adjust.v_total_min;
>         params.vertical_total_max =3D stream->adjust.v_total_max;
> --
> 2.51.0
>
