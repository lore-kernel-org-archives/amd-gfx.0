Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD003CE7A94
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Sep 2023 14:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DC4A10E262;
	Mon, 25 Sep 2023 14:17:58 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A98710E261
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 14:17:55 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-1c4c5375329so3613894fac.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Sep 2023 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695651475; x=1696256275; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dWId3rm9P0/5gVVDQpUZw/9a3+JhcVS7aOQG11Tdyag=;
 b=dC4GXML6aOmB1E7klayBuBV4AQdJOPUPSyAYFaP90a88TckU7uuEErwdU/6cLoj4vW
 ZH7aL9R/4FVtc8r5FyTH0xZK7nD764jgOibk62NwFb1nMJDi5tgEsgjfzKqAeLkODAVe
 LXz2Jd5piLdLKKNGIglQmXU9puOQdZODI+RLUVAiLmalPVlAfy8XFKKZy++w+zR5QBI0
 TUTqZ/vtOSzKnxhn4yrI3E8cdEfVqaxTkHUfblLKQ+mwDadp+jT/FVqXzjT5OtJZ4bn1
 +NRiUf9xEZ/5qDYbPnQR4OXr/KA3ENXcciCH3rG/Fj6RIc2hGVh42cVwU4y9vPdOfKSQ
 25HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695651475; x=1696256275;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dWId3rm9P0/5gVVDQpUZw/9a3+JhcVS7aOQG11Tdyag=;
 b=tp0UNLeu7YxYfq4TuufS8Zxe0hV0krMVUbJX3IjaP2RfvsC4a/EjRtnpe+wBV/dmVd
 a0gFAQdALz+fyFzd/whVADBOKb0/U+yRoMWQOqQ9V/blwDXzZ7b96K3lvQLnn0p+aTgo
 U7RYmv9PJbNBGhTneZ63zfV6iJV1vEndH3lryUkoN1FtAzuwrw+1RuyZYDpuA/ZLWHS+
 fxlVfvFmgr8lJzwIx6H9D4uQXrsvuKZWwXxYAkmmbiPTNaJkIMWsFA4RuH0FMihWYbyd
 PEybzdI+Ow3YWTdazf63NYB+/+IIOJ4VVYZn2j0BQjHt9o0nGYigTLqEThQlR/waWEOZ
 N73Q==
X-Gm-Message-State: AOJu0YwO40m4Jzwe/qDqCKYcVWeuhP4+fv08mSt6/jkVDVJIRZ0ujSHD
 L4zfm3VyCq6MgVmyC10X1E9NRWh23yfg97HUd5E=
X-Google-Smtp-Source: AGHT+IHtVWhrUzL+dX42DCDY3fQM/cdiWxFpRGrfeMYLsEFfutaXa8AluXH62CsOpkH/tA8kcHnKTQvFSMmlg3mKOtU=
X-Received: by 2002:a05:6870:c38b:b0:1d6:266b:e58a with SMTP id
 g11-20020a056870c38b00b001d6266be58amr8342807oao.14.1695651475041; Mon, 25
 Sep 2023 07:17:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230925062225.819007-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230925062225.819007-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 25 Sep 2023 10:17:44 -0400
Message-ID: <CADnq5_PEW6-OX39Ap2DeWciReNS2=+fdzra0uRko7JucvdR8VA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Address 'srf_updates' not described in
 'could_mpcc_tree_change_for_active_pipes'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Sep 25, 2023 at 2:41=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:3928: warning: Functio=
n parameter or member 'srf_updates' not described in 'could_mpcc_tree_chang=
e_for_active_pipes'
>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index c5a74b202bc8..ab403d2d9038 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -3906,6 +3906,7 @@ static void commit_planes_for_stream(struct dc *dc,
>   *
>   * @dc: Used to get the current state status
>   * @stream: Target stream, which we want to remove the attached planes
> + * @srf_updates: Array of surface updates
>   * @surface_count: Number of surface update
>   * @is_plane_addition: [in] Fill out with true if it is a plane addition=
 case
>   *
> --
> 2.34.1
>
