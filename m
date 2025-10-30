Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68FDACCF9F0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Oct 2025 15:20:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D39C10E28A;
	Thu, 30 Oct 2025 15:20:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P5C95DD2";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F4910E9E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 15:20:33 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3404904539dso169978a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Oct 2025 08:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761837633; x=1762442433; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4n2ZAbC/7CporyooiQ9y7Oblbi4ys3ElhAZOq431qrQ=;
 b=P5C95DD2vRwUcZ+E+z7IhDrdS+X6e76HdhTtNkjKYGx6eqFxYCL1C2yqOpicztrt2x
 prlQolsJ7oNjdNxKx5IwYB4dAvIWvXKssdI/Sab3X7CUAmcDm0JtQ8vui81P9JN9qRFU
 eI4Ex3B3ONnbmadvL4hxgT62IowoG5xDelZgNKwXazzGJoCS3+GRbWTKuVgqwbmC6xzz
 h1K2lRE335d2+AdyN9MTDFrtby17PcsK4nW0XmJ0UsHbgHJd227mw1KJfycRYJnyPtvF
 ER2xd1x6hmst7iQfEyu8gX/1H64CZciH9B+rEDiOlRq1XhLHjrDdCCh4Z/7cDdXYMDEY
 lxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761837633; x=1762442433;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4n2ZAbC/7CporyooiQ9y7Oblbi4ys3ElhAZOq431qrQ=;
 b=QbUHcFaLcb8AnwWeOYQ9uJ/LTgbs3PmGKW3GgX2/jT49nwDVp8bneerdTgedknolYR
 2Ip3GhZZ0BuY2vsNww9LQivPCHw4Chp9HoUxufWEkSJ4MMwarM0wiwtj2pinzmY7sSm/
 YeHzHjJ/TUOwySWSMujOJVYneg+WjvLroP2t7y/aJITKbFxucDe8PG1CN4HdFxh0+ajK
 SSdkge8Q/QIN8kDcLr8BPngdqJEO7AkhkD0lIT14qMJdlbbyrx8ZK4inVxlknxRC5axJ
 terJv6rOK05mYiEn0KhlFqU4FU9wmk2i+cPTOFS2mW8rdtWAt5/H87pyXLFdxjrRXG5V
 VyOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqHuMqpd7DphWU9P2r6yL4gS53N7EqzHd9+Rt7QDneWqnHbo/UKf6hrrulMT2AUz5ms+AJMqon@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkzQxl+ub+ersFh2/odtk1Mp1FiflfI4oM/vdVsxUy1QKH86wM
 mp77VwG00CD8EBW+U3yb896guV+8FooMVh26k3ffNdFu4iqfB4Mgp8WwiKmAdQRwBcpmlnv+Eoh
 up/BkK/exBI5fqsaP1lgDxlYX8iJuQ8s=
X-Gm-Gg: ASbGncuNlKQ7DzMpCqEe/isWZiJr/kW3Nd+e2KKlCiW8BW30zofhzJ9FuTe183yqtzV
 KtntGQ1mpBetTPNXdn2PubS5booCnurhuWMRz3udu4CVGDTsB8SxGZf0rpkXVHYNiXjKXXITnTj
 yV521DO6aAzfC/5wxwvMQ23xxr2Sv1X42eQ8Y1uh3LzFrLUQb5L1iY4NVCwAOzx9NJ1Y3TubDel
 S1wX6kC851fS5mMWH5/pkeSgTdgx4kRslsOb97GdwvgJGFFhXZiKEv8UnDu
X-Google-Smtp-Source: AGHT+IFb9s2heQmxBOs16F9sJ4fOGsoBxkOFOsxPxU7gqSkUUjW9axA4peKPZGOc6kGJhiEtISZ7fWFZ7zDcJ9fzKU8=
X-Received: by 2002:a17:902:f395:b0:26c:3c15:f780 with SMTP id
 d9443c01a7336-2951a49dd38mr397265ad.8.1761837633262; Thu, 30 Oct 2025
 08:20:33 -0700 (PDT)
MIME-Version: 1.0
References: <20251030143737.136120-1-lukas.bulwahn@redhat.com>
In-Reply-To: <20251030143737.136120-1-lukas.bulwahn@redhat.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 30 Oct 2025 11:20:21 -0400
X-Gm-Features: AWmQ_bmVii5Alx1O5jsx56pQkAEpJlLlfevil6R4SK7ejJJXXuksGVL19-p25ec
Message-ID: <CADnq5_OR72MJvXHTGzzW-oP+z8X=7vQiCpytmuBJNsN7=Tw=pA@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: adjust file entry in AMD DISPLAY CORE - DML
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Austin Zheng <austin.zheng@amd.com>, Dillon Varone <dillon.varone@amd.com>,
 waynelin <Wayne.Lin@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, Jun Lei <jun.lei@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 kernel-janitors@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
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

On Thu, Oct 30, 2025 at 10:46=E2=80=AFAM Lukas Bulwahn <lbulwahn@redhat.com=
> wrote:
>
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
>
> Commit e6a8a000cfe6 ("drm/amd/display: Rename dml2 to dml2_0 folder")
> renames the directory dml2 to dml2_0 in ./drivers/gpu/drm/amd/display/dc,
> but misses to adjust the file entry in AMD DISPLAY CORE - DML.
>
> Adjust the file entry after this directory renaming.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4d739e18aab6..7031ee1e7cff 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1080,7 +1080,7 @@ M:        Austin Zheng <austin.zheng@amd.com>
>  M:     Jun Lei <jun.lei@amd.com>
>  S:     Supported
>  F:     drivers/gpu/drm/amd/display/dc/dml/
> -F:     drivers/gpu/drm/amd/display/dc/dml2/
> +F:     drivers/gpu/drm/amd/display/dc/dml2_0/
>
>  AMD FAM15H PROCESSOR POWER MONITORING DRIVER
>  M:     Huang Rui <ray.huang@amd.com>
> --
> 2.51.0
>
