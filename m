Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 346B2C36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 18:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C936410E2D0;
	Mon, 24 Mar 2025 18:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LFF96/Xk";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F2F010E2D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 18:22:54 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-22792ef6215so7008205ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742840574; x=1743445374; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OqzhAhDr70hDNrfUR8C+K0RdJFzglDHPmkUBq2OM/9c=;
 b=LFF96/Xk/kii87uivxVexe1pPyzmmuOVhIg9Nk36Wv82M2gRO9obvsjMbcG/rhdRcr
 67BYc0HVefa1WaUH0NIHLF4Zeb2pWAxb5G8JX60yd/HPsO5X8eWGj3vdkptzL4+q+z/U
 Uw/Ib5hJLw/AwqkPv1bmhWgKARjHEFkb1E3gDX538+kZmdYJru1LBJ0mU/O4x9tqlG6I
 sbr4BXXWDrEgoLOnqE40JJgKa/ZQxPLPsA9KkTOKh3R42WiYrzDve9duyijtmgS6Zt5+
 abTBeA85zAG2KjaAgB+83VN8UBc718X33usuDQSO4bbbN6KBh4rFFCAusMW/zG6aGcIe
 p/bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742840574; x=1743445374;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OqzhAhDr70hDNrfUR8C+K0RdJFzglDHPmkUBq2OM/9c=;
 b=PPp4Idqt3KObQBsUkln8AggxwwmUDvgmaC//OIkOZUalFeDE961bwXM1y/iByDCFMY
 ydEHxg6pRttLv/MoK5hu68tqbFqBGtIEkbl4hrsWCiqtSnb3RyZNnbAbSqebyHNa+DYm
 71N2x2leXgReQvigqaZVIyK6LZfcIXxvK+5gKzZ8J7X7ni2BUoL9+K00iQVIIr6Yc7Zv
 UvV3Ok72+g3XsqM639lfEQ32DZ3alibR+f1y5ym6antPMjxI9ts0L/0VFBsGbj+VqM/J
 5hMRoQ4RuHIMEzXNHU42ZrkQIPnOE4/GP3UW+3PLsoYKZBatqZuPuucJo/4uvRqWkZX4
 CQdA==
X-Gm-Message-State: AOJu0YzG5LuRoMVhxC91oOLL++eJVJ5OdklGn1GOuGOKbPXytwwNtLmT
 Y6R9EfCSAr+IW21TWiGVTGmRZKi3pxpBn2vWVYOuEIsuoNmyVmJLom5YQ75lSah2Do9a8mDwYUg
 sc23q4/6y3yv4Nt4aVszHzO8ST3o=
X-Gm-Gg: ASbGncu6LRTLx+EOCBgZtOTLKthuZMrCC2w19VsSpcLIRh2B1P3nYxJxKviKhH2cY41
 MdKd4dbJMRZWq/xbfm9sbQeB1sV5zv9zAHQRUoQEtLfEaPyMX6MugYXkPK8JOnyRQxGIqkO5MlF
 VISLEB8MAbbhyqasiNtmXDfXDocg==
X-Google-Smtp-Source: AGHT+IF2HRd02jatlQaDflqGXInKborlKg9hjRSmApleqblHKlPOdfhZ2cN3ozPtYa0PmwAq+9rH+218/0C5lr0QSXk=
X-Received: by 2002:a17:902:dad0:b0:223:f9a4:dc25 with SMTP id
 d9443c01a7336-22780e359acmr82130085ad.14.1742840573792; Mon, 24 Mar 2025
 11:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250322183900.86061-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20250322183900.86061-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 24 Mar 2025 14:22:41 -0400
X-Gm-Features: AQ5f1Jqq6RDl9lkBI_JvWJjnQWfWYeO-yx37a0v_hXN7cDLRs1aVLlASi3hknAs
Message-ID: <CADnq5_N1-OeMNuXUj3fKq5=DEcp+tRh02uY7Lv-a9f8euStqEg@mail.gmail.com>
Subject: Re: [PATCH 5/6] drm/radeon: fix MAX_POWER_SHIFT value
To: Alexandre Demers <alexandre.f.demers@gmail.com>
Cc: amd-gfx@lists.freedesktop.org
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

Applied.  Thanks.

Alex

On Sat, Mar 22, 2025 at 3:03=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> While I don't think it is being used anywhere, if it were used, it would
> be wrong. We can base this assumption on MAX_POWER_MASK, where the shift =
is
> by 16 bits.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/radeon/sid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/sid.h b/drivers/gpu/drm/radeon/sid.h
> index 65a911ddd509..f9267b026f8d 100644
> --- a/drivers/gpu/drm/radeon/sid.h
> +++ b/drivers/gpu/drm/radeon/sid.h
> @@ -1109,7 +1109,7 @@
>  #define                MIN_POWER_SHIFT                         0
>  #define                MAX_POWER(x)                            ((x) << 1=
6)
>  #define                MAX_POWER_MASK                          (0x3fff <=
< 16)
> -#define                MAX_POWER_SHIFT                         0
> +#define                MAX_POWER_SHIFT                         16
>  #define SQ_POWER_THROTTLE2                              0x8e5c
>  #define                MAX_POWER_DELTA(x)                      ((x) << 0=
)
>  #define                MAX_POWER_DELTA_MASK                    (0x3fff <=
< 0)
> --
> 2.49.0
>
