Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13599F3C98B
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Feb 2026 14:56:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9906F10E194;
	Tue, 24 Feb 2026 14:56:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hfDN1NVZ";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2A1BC10E194
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 14:56:16 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-1273882d901so285230c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Feb 2026 06:56:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771944975; cv=none;
 d=google.com; s=arc-20240605;
 b=XxTivVm8S9LDKlho7cT09rRutRG8t4UDTwZbwVpI5dMdy3gTQj33tfuiLIW9iLBDVS
 uAAo6a1ZmL6vnnBK4YruQTE6FNyXCPigxLJ7onp8eCp5d+IHgHocRSjBMqIFuzpyIAwg
 QhVoRBWWrN/4VMb9H7X3U+Ro7pgexoPZ7+W0bn7jcFLELhcuU3vArnMmQrcbjS8ddt4J
 hJ7Sr9BTSj69ZbxX6vMznyBDnzWpFBRLMV89g2XlDyek1xFz95d30bkoRhMyDAdy0rYt
 u4bTe4eB0DJhJOynrkWur3c0df+q8l21pTZe9Gm8rhRVj1wuqgsFCdpud/WhIgPWIofb
 Qo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i+aUfl6j0iyUdg8FHTmaS7+nE4Zhy7tH6M8xZwgvbTs=;
 fh=3SOa1bRl6Yq/0jk49CuBhudAeuo/7A/nLP+3nATIQ2I=;
 b=YMRwQpzij74MZkp6NWDptpVQv7hhhHDgS9AsryCEKLql8AjumVJHR34+29sPaif8x7
 ywomI0ZOCudtnYODbqFHARIk6pytEzGLyfv8dD1m8dZ7KUj44kJ9pakRs3+erEJZqcdh
 soP3mjAupeiRgbN6+OpHKYcCYfHAKLWY+5MxnCgk2UHoE+aAX7Yu8LwJiQKxSsoTb9cJ
 nGtguPvxE6IG/a242QEVN748HLO61tfFHQrINvgXvua/aZDQ4QQFCaZw7n7sKjtwrlGY
 fNU41iq/rOqjyRLU8RCvxc8h0ZO/Cvd7RjAPKtkbWsE/XCPaRQewR9lyIIWNcozvxCgo
 7Ong==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771944975; x=1772549775; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i+aUfl6j0iyUdg8FHTmaS7+nE4Zhy7tH6M8xZwgvbTs=;
 b=hfDN1NVZkiAu4JMp3DqOY/wk/W2FFouDlLYVknyCmXmn6uknggNU1mFCvt9GxUG7gt
 e53tCYn4EJIJZ5N8ND9csZhC3TKMyRZFHDvG6KCmBUZvGrQWUIyKqjyqsvVozXu/1Je7
 2yFTHw8cSq+kjJxoczaUq9clseI3MdMdALJVLWSXRuenClJwhSbQ6aw3lxa8LQphHWlw
 sgQv3RXpbsjPR1OAFk/56OGOY9vXhVeoSMm74Rmo4cDNBqgZS45oe5vZE85d9+oiX2QX
 /itXwRU09CS4+SRvSZn7EcLJ8crk/6PLQASiBJ0VLCgnVNOrqWihjbuPryVKlDcEK1Zw
 GECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771944975; x=1772549775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i+aUfl6j0iyUdg8FHTmaS7+nE4Zhy7tH6M8xZwgvbTs=;
 b=OE5ew5UnO84MPNzkYvJPczDlHrdoCoA80AFh6uVEMYRG0Ez4HFbRGvCodYe4vrYk/H
 7sTwfu16WfGWRxkIApEPTyI42qVPVCe+43uW3W3j16ZwHai36CWAj4ZuOwZF+vZBBnwF
 XZWGisIKsagUr5VRhzG4j4OtUBVY9JtziPxlNtcjQTsGEJIob/bpN6t2Q+bDylN9KYp6
 r2VUj5Dr9LM8DV1+gLWGSWHb/+yDoAGLn2cRuO2IulZ8j3fhwSi7A/PcsgtkFrA222R6
 MsNYWjnOKawsTeAtDobr9t00vLaAHKO76URsLaqMqHpOV7MMkKw2l5EwLqzFGiJoUJ9Q
 dzWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeOYLd1nVKelRlepP7tnDCSwluV171f7XHDXnv2l/t3w7Cg03VWdFITI+kC5Q1+NChL6Mx0cOF@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwelpTAzjtYf2+wS1FXB6sp5ymdtdAx4G9222zo6lvJFzvqeu12
 p+fKv+swRG7wQOko2nRPU6Wtlii7GRlb9hyP9JZZfk88PlCJgN/oVKzR3OFUABXMZ4rqgM9OaXe
 L45XK9pR4AP9AtOvPhJAWLITOTTc4uGo=
X-Gm-Gg: AZuq6aIYrVy9TQAovJCIl3ODzi0y69KzWTT/vmmbmUB2jSJUq57mQuom6zkBp48gyh+
 /Sgmonj1VKqX2kgBlIw2GIIutZL6gJreFns4beR5sK7WkDPInw0D+rUxFhCEJ+VHRkEE/t+ak2k
 yklB5nNqLg44ITJedYmBiewtDAFAU5mPoQ86RxQRi8QNLe6AZckTymx5u7M7hGo0nLhvIJYY+lG
 qH6/Zg4nQzWcV1AbgGatkk0m2xKEAt/m8ViR2tkk8YxrW4uO3D2j4R/cP83M9b65AFE9S2wcgIV
 lUNMbMlY9leBV1cGWzk/eQE8Mm1a9WQ8RLa3xzoyMQ5YcECNYZ4+uSg9SDGb0R5A3kiTEg==
X-Received: by 2002:a05:7022:2383:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-1276acad3efmr2638142c88.1.1771944975132; Tue, 24 Feb 2026
 06:56:15 -0800 (PST)
MIME-Version: 1.0
References: <20260223114537.38145-1-natalie.vock@gmx.de>
In-Reply-To: <20260223114537.38145-1-natalie.vock@gmx.de>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Feb 2026 09:56:03 -0500
X-Gm-Features: AaiRm51cXcZtY95BR3KKsGNKEGAquNMI1RXUNYCMVFCpARLt8EwnLScoCBKOJGQ
Message-ID: <CADnq5_PYyDxySN+FjqDd5LXMrYz2VYEhG_R6gY1gSXjYD6dk1Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Use GFP_ATOMIC in
 dc_create_stream_for_sink
To: Natalie Vock <natalie.vock@gmx.de>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
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

Applied.  Thanks!

On Mon, Feb 23, 2026 at 9:34=E2=80=AFAM Natalie Vock <natalie.vock@gmx.de> =
wrote:
>
> This can be called while preemption is disabled, for example by
> dcn32_internal_validate_bw which is called with the FPU active.
>
> Fixes "BUG: scheduling while atomic" messages I encounter on my Navi31
> machine.
>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gp=
u/drm/amd/display/dc/core/dc_stream.c
> index 191f6435e7c64..87c0cf7e290ea 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -170,11 +170,11 @@ struct dc_stream_state *dc_create_stream_for_sink(
>         if (sink =3D=3D NULL)
>                 goto fail;
>
> -       stream =3D kzalloc(sizeof(struct dc_stream_state), GFP_KERNEL);
> +       stream =3D kzalloc(sizeof(struct dc_stream_state), GFP_ATOMIC);
>         if (stream =3D=3D NULL)
>                 goto fail;
>
> -       stream->update_scratch =3D kzalloc((int32_t) dc_update_scratch_sp=
ace_size(), GFP_KERNEL);
> +       stream->update_scratch =3D kzalloc((int32_t) dc_update_scratch_sp=
ace_size(), GFP_ATOMIC);
>         if (stream->update_scratch =3D=3D NULL)
>                 goto fail;
>
> --
> 2.53.0
>
