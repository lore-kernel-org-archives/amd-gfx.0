Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 221ACC00140
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Aug 2022 20:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78A44D49BB;
	Mon, 15 Aug 2022 20:44:55 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CACC8D49A0;
 Mon, 15 Aug 2022 20:44:44 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-10ee900cce0so9458694fac.5; 
 Mon, 15 Aug 2022 13:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=tYUBnH/MsVRH8/bfqF/s2biQgFrJkgqn5c8u0QHLws4=;
 b=J1dcXg+0hcTPJW/ZFLCExzXkIuscsbapWoMN+oGZ2ujZl4NZ16nqo3WNgPZnti6lTd
 i7o+MTQUVCOUB6pvodzFhmHDJhSxaAY++pPvcG5fEEQXa0a3m0EXlT4/T2pxmF122VKl
 a1618VIaaciGn2grpGWNCl/z9cqvZVtcTaGaMnu3wxNxfYfO+me+b5iLcA05XURxNft6
 t167aLOTrk3vPSXG1PPU6honySFp+qSkiQ8KHU+FFjGQaHUnVnyx0ZpPoOWNJrIeii5C
 Hju9gpxGbCEJnXhSlU+fwOB2AxLmhZ2+xeXcuzRHZ1FGvYOqvUp6LBRnrLjCjMywvrx6
 4w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=tYUBnH/MsVRH8/bfqF/s2biQgFrJkgqn5c8u0QHLws4=;
 b=5PetFOToKq64fwRY37mXtp+PWiI0QjWw60gqKZzEuZcfSaF8p3bqSDX5Wq9EqeVXcd
 pFr67b7VP42KR8gRjrMk0QU7POMyCKDEWtdTreU0xtGjsflv6Hh7aXCbU3uOWsFPuuIu
 SOQhiqoVilfUZdxH+USsrpxFN/bZbWmMcQtBzIqPNhn5gCx5WNVA0WCIFKl09/eEIKWr
 vKHZ9/8N/IpnUWazRbfiwEbtxUoW6XTc4wvxco18Rm+SYo87NWJ8TiGGT6MBd4moO6x5
 EYlH+n/rnsMXoP9XjkN/L644TrIcoHsPlKF7BEbIHBQtEd5PPOOrAK9ZaukZrd5VZnpg
 kViQ==
X-Gm-Message-State: ACgBeo2pLHEqMM+olIBQ6BokHOjju/P0VTJpEhSiF1JI3b016fn6iKY2
 7HmgwTvU/aQPF1Ss62Qh/liN6+Jf1yFk4aqVdjE=
X-Google-Smtp-Source: AA6agR4lTNg/R9bH8fCViZfGEvc6dMFDdsFFr0Vis26Tmv/uGc+ltdRMU8B4hhcEYejU4tKiurv9Q3FDzVnrTQSIoRM=
X-Received: by 2002:a05:6870:e98b:b0:10d:fe5c:f818 with SMTP id
 r11-20020a056870e98b00b0010dfe5cf818mr7668019oao.106.1660596284103; Mon, 15
 Aug 2022 13:44:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220810232858.11844-1-andrealmeid@igalia.com>
 <20220810232858.11844-5-andrealmeid@igalia.com>
In-Reply-To: <20220810232858.11844-5-andrealmeid@igalia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Aug 2022 16:44:33 -0400
Message-ID: <CADnq5_N2EToKQG7xS6NOTvgLrVuzWTtqZgHbF6LEOH3gZdHhgQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] drm/amdgpu: Document gfx_off members of struct
 amdgpu_gfx
To: =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
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
Cc: Tom St Denis <tom.stdenis@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 Tao Zhou <tao.zhou1@amd.com>, kernel-dev@igalia.com,
 David Airlie <airlied@linux.ie>, Felix Kuehling <Felix.Kuehling@amd.com>,
 Pan Xinhui <Xinhui.Pan@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied the series.  Thanks!

Alex

On Wed, Aug 10, 2022 at 7:30 PM Andr=C3=A9 Almeida <andrealmeid@igalia.com>=
 wrote:
>
> Add comments to document gfx_off related members of struct amdgpu_gfx.
>
> Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gfx.h
> index 1b8b4a5270c9..8abdf41d0f83 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -332,12 +332,12 @@ struct amdgpu_gfx {
>         uint32_t                        srbm_soft_reset;
>
>         /* gfx off */
> -       bool                            gfx_off_state; /* true: enabled, =
false: disabled */
> -       struct mutex                    gfx_off_mutex;
> -       uint32_t                        gfx_off_req_count; /* default 1, =
enable gfx off: dec 1, disable gfx off: add 1 */
> -       struct delayed_work             gfx_off_delay_work;
> -       uint32_t                        gfx_off_residency;
> -       uint64_t                        gfx_off_entrycount;
> +       bool                            gfx_off_state;      /* true: enab=
led, false: disabled */
> +       struct mutex                    gfx_off_mutex;      /* mutex to c=
hange gfxoff state */
> +       uint32_t                        gfx_off_req_count;  /* default 1,=
 enable gfx off: dec 1, disable gfx off: add 1 */
> +       struct delayed_work             gfx_off_delay_work; /* async work=
 to set gfx block off */
> +       uint32_t                        gfx_off_residency;  /* last logge=
d residency */
> +       uint64_t                        gfx_off_entrycount; /* count of t=
imes GPU has get into GFXOFF state */
>
>         /* pipe reservation */
>         struct mutex                    pipe_reserve_mutex;
> --
> 2.37.1
>
