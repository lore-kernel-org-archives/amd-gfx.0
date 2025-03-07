Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692AFC19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 15:05:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11D8110EAF5;
	Fri,  7 Mar 2025 15:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f/t3Vdu6";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE30A10EAF5
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 15:05:32 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fc92215d15so476434a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 07:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741359932; x=1741964732; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6jZKgnhVso6H9ZWxUJ5Ta5egYw+UyDaCnH2fUwokCM4=;
 b=f/t3Vdu6FETc4UYXUhwUhaEPoVRF0StyGWgQr7zKnxKBXCKKMVWDwCnj3YMyAvq1sC
 Mqckkj5szb9o3EfdiX2cfA1YAeZPDzDma/5w6FR9shpJMsPfSJuCDqGUHNDG2LXJqus9
 W/naPWZQfM3N6yYJ57HNXmnBIFf1Vfp8WTrC+vDFiCpUyfR8wYlf+8BUHxW5otroQ95p
 E2qi+5L0Ule/QejgdXHilGT0nr5hL2e43xKLZa9fXH/PVsyCCX0EIaN7yJMk6gTu09Vx
 CQz0Ve+gnwSWw5wUS2W9GewrYJymoJuSu5lnS9tLf/FS8kFbjeQIX1y1oT2dI4e2vwWB
 4ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741359932; x=1741964732;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6jZKgnhVso6H9ZWxUJ5Ta5egYw+UyDaCnH2fUwokCM4=;
 b=HHqzotIkaIQg7w80khHYVRGnePlhlVcs2Mw2nMqahP/ub4OqIcApjb7tM7vs1KokFi
 2GkPBys6zs+YhwBlbMPs34B00WE+XRjWJjVVYGv39WlIK/y1/ewwVWMzsApkUx43ooFt
 LSD4Y+OEYpWe5o+CiIm4tNpgGqgVsBP4Inamj3rrFlnAxr6xubHsYwTP2H4sJO62wAZI
 ITxpFsq+t0HTGd52cIW7y+KKBg3OHS+7aa5h1FHJySDsICBj5H0jmWuiXehMH3kpfNHg
 veZBVgoYBl6YCHPQuwMICygg0AH4EaDoBZW3OwbxF/8pBnWVQ3LDPX8MTqcDsOgMAwRh
 66DA==
X-Gm-Message-State: AOJu0YzsiMe7Eq3f/oL//cmtmuKKFeE2JlDpuRWTVu0JDFRYB7YmAgTd
 Ty6o5KgOsVhIkoyHpHv/w8DA4vFF/K505V5oBXJ4hOnEd3ybDQ+shmgSeKyb7MAMd0vnUZW+gWf
 SybNjIG4d9Eoo4yBEk8SygnApJ20=
X-Gm-Gg: ASbGncvqWH+wjxH74P8ZTZInh+eV0Igfye19V5AHlH3IRQ7AvUU361VUDBgpPmchdJZ
 DtcIocQLgAE9sqfrNt+nTNIIofpLkp79c+SQOQRArmMT5G9muREHQIaub59T5v09oxZX7qx7+Vo
 hGRXMZew3AcDNx2EbuaRTxL20tRg==
X-Google-Smtp-Source: AGHT+IFdHimLtDm7X8QvDGOG3OnBfi6mHhm5/V/LcpKqRROagGI7zK8p2X5QbCFwgvrjeZc+azorTZrOKNAUBwvQb2o=
X-Received: by 2002:a17:90b:3146:b0:2ff:7c5a:216d with SMTP id
 98e67ed59e1d1-2ff7cf40ed1mr2311637a91.5.1741359932226; Fri, 07 Mar 2025
 07:05:32 -0800 (PST)
MIME-Version: 1.0
References: <CAAxE2A5D6Mrd7HSmG778N=ps+o3Cg85XEBCQuKhu+cpQcrVEFQ@mail.gmail.com>
In-Reply-To: <CAAxE2A5D6Mrd7HSmG778N=ps+o3Cg85XEBCQuKhu+cpQcrVEFQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 7 Mar 2025 10:05:19 -0500
X-Gm-Features: AQ5f1JovBdxahOoU6UBUQ01JJ8Vhp4sDFSVTL2sV20R3rtkGPVYawPlf99ew2v4
Message-ID: <CADnq5_OwP_16g7eoSKuipZC4V1Ng4==_jeh55CXRFNXBqmo1Kw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: allow 256B DCC max compressed block
 sizes on gfx12
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Fri, Mar 7, 2025 at 10:01=E2=80=AFAM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:
>
> The hw supports it.
>
> Signed-off-by: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c                 | 3 ++-
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c | 2 +-
>  2 files changed, 3 insertions(+), 2 deletions(-)
