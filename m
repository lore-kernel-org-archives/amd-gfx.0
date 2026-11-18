Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D98606A320
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 14:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ti0u3oCP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777BC10FD89;
	Wed, 18 Nov 2026 14:55:22 +0000 (UTC)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BFD10FD7F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 14:55:15 +0000 (UTC)
Received: by mail-ot1-f49.google.com with SMTP id
 46e09a7af769-86156081432so275402a34.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 06:55:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795013715; cv=none;
 d=google.com; s=arc-20260327;
 b=FQFl7llLkvfGsK0TUVTiXrlBvukLaMjTBQ1bZpGjopzyznI91fSvoNSTuckIMgT0CT
 j0+LBeBYAQU7MDARiPVuiU2ChM9+pdMt791RAmdyWAk5yPQsxh9H18hO9m5TPQ5Qx23p
 PD8sZi7JBWVv14XDQprP5hekueXdPNiRrVJ7V5j05EuQnl9Js1ecIEzHFNBlig61XgGG
 MvVjfBEVEQHd2hmRsQZbYr/8WBn++m9JRXE3y8OGNm7mWk+RQqxQzc9FCXTS9GDjLaos
 3ihWtlCxf7d83dPjAhA6stjUIimd4xDoVllSWH8efuUblwhrXO2PJMdh3sGCjrCk23J6
 J2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=U1ksmWxzDVGM3iNAt/5EvAOvVOC66Qy74DTy36/6+4k=;
 fh=6eHqRq1nVfWweCKKiAxcZmohYNQqL+4niU5VXBjZnHo=;
 b=rrwSw5JrtXG0gWZGE86TrSgOOsO6CwkvDWYnteJUmFM22Jt1kILdYihuCkl+rcOdv0
 jhTOEOxRkJuZe9rmI3JkJmOG3qLZlCRer8ooOoqf5yaOA9b5ks7wJnGB+xzM2LTthLWV
 imYT3UK7XnVPW9cuCLaAKkLvOWZPUgE4RlzgwR+tQrakAztb/QGmPMp0TXQlQlwXSXWU
 NGOqwifaLf28Xk9QtzlFL0rxRUNALW0nwH/Jj0N6FixuIdqbZhRgbKq0zUx4lpaPafaa
 o4R3OEhks4L6eQV1pGc3Cvq3LIEs9YxWCM5XcNxkEBD81O/qg2dJA0+p5+myQdmRKypD
 1VXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795013715; x=1795618515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=U1ksmWxzDVGM3iNAt/5EvAOvVOC66Qy74DTy36/6+4k=;
 b=Ti0u3oCPtb8fwptf4ZHRPexWvAGE5yzUpxbhbskkqtlqip4Z74gKCOqMYYio80g4ev
 JTs3vMo6ojTDG0KKFUSu9K6iV29C2bsrSYQ3f26YJRvqRzVf9cufDanlbqhcs0RpKkU1
 GXgpGA4T2k9xjIsIbC7zgEX/y0jvjRyGsSJwvBXVTOIy9Pdk+vNBUGnkv59eaHMljECX
 MKJ1iZL1cztvmYRrKRw9gVTT79ejclK/jVK7UitXJh0QSedK8dolbzDfr41GB9AmsNzw
 CAV+baUWNitzlLjAgQ4EYcPNy6jtGDLgPXTR0nWlpsSNPLZfnUAMPxybKbmgiNWoWYIe
 nejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795013715; x=1795618515;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=U1ksmWxzDVGM3iNAt/5EvAOvVOC66Qy74DTy36/6+4k=;
 b=WH7y2/ujBEfiAwXD+XWGfwuEKQlaj98BsLsh0G4T3IG4mjAY5cFII9o0iUDINTHu4r
 HxbDTmSioMzkF/n2x2Of83B6AeHEwwMn68UfbAk4OLn2zI46KLLNbb6DhsHMH6IG9/H9
 hO11EBfIyvJPAd06OF5mVNyeO7nuGc6x7DFhP7fseqCV2b7k+ZY7io28ebhl07cmKk1z
 wBSkaDKUZGqTRmVS0huDD7V8sDk6j5QBqqh62/avGC6553vewya5QYwZTodhVwZq2uae
 WwTDKP2tmc5LniKLm8Ltrkqw2LhVAYTvPM3umo60tqE/yfzStWwMr6O76F+TOe6Txp8x
 XY/A==
X-Forwarded-Encrypted: i=1;
 AL+hErEphp7QQMAJHsfW9wM1DgUY3bojg03XqhAq+XAhKR8ewU3deuL8FdESClUHSti0jrmhLcGB73Pt@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+n0UwtsNVVukTxyGOLWKnviNkp+aQ1yb1Cvt2As/FWLizuOLdZ
 9vLM09kC3uf21DeuQZ5r0vggugPddnqMqGvhpeOnVgxqG5r0ImHy3b8J8Tl78mjnOmzaoZZFNmY
 G1ngykHoWZtMx3bdU9zg4Utq/prTpXOY=
X-Gm-Gg: AYBFou3kuQfWB6zeyZk+RRxI2pzKS6YgNPo58iWzPHLXIxcDgNULPHtHWEtF0iooFAP
 rwwLq+LLsAFgdc4oXO72jS1G0gHlvLDpMxyHO6WyCleUsRSbNJe2eXfDh7C7lpEyIlg7dlFlLnQ
 NHWEUn1UIsIcIUQNe1KZm4G3HLrpS16pMwW91xESps5yLEq3vxor1XB3I+YSemeKalQhtOzqtkL
 eJdvLmDsHaSV69H2SfER8oKd5OH4FVEZYWzoKFKTZ0oEh1Aq6MDBAe3TS9LSer7JhK+RDxXbc5T
 9MsWXvwFoUjO7BBml/Xfn5IGfnLrcf2P5ROlzUwgM08iZ/aVm7wJDUYfflEcn6ddClfrFynuFzs
 7Xdi60OTfUrperRIGRc+4FZXWKZ8Ivhy2Hi7uT3N+NANOEcrixMqCac+BrBZau53OfotnqT8wZU
 KXv1J03M8uY7L5JyhulBL/RhKEX9xAJQo3KH94nUADPbCwMuElYms7Pjt8HooAB743ebDi1H6zg
 5i+kdIg
X-Received: by 2002:a05:6808:50ab:b0:4e8:b729:3ebe with SMTP id
 5614622812f47-5773cf28fa9mr4891107b6e.4.1795013714673; Wed, 18 Nov 2026
 06:55:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118144923.1100-1-pierre-eric.pelloux-prayer@amd.com>
In-Reply-To: <20261118144923.1100-1-pierre-eric.pelloux-prayer@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Nov 2026 09:55:02 -0500
X-Gm-Features: AclHuK9S-4vVMS6uriyFTd2kN7_cTAz3DiLGyu1_3jE2ITmklct8mvSQoJDun6g
Message-ID: <CADnq5_PM+gdgDfBQGdYLOYZ3OV_ka2+1SPrNCh0YLTUwvzQSRQ@mail.gmail.com>
Subject: Re: [PATCH v1] drm/amdgpu: use a single clear entity on some chips
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 9:50=E2=80=AFAM Pierre-Eric Pelloux-Prayer
<pierre-eric.pelloux-prayer@amd.com> wrote:
>
> Workaround to fix failing tests until the root cause is
> understood and fixed.
>
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd=
.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ttm.c
> index 8dfa92967b63..d5c1d044403e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2411,6 +2411,13 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_=
device *adev)
>         sdma_ip_version =3D amdgpu_ip_version(adev, SDMA0_HWIP, 0);
>         if (sdma_ip_version =3D=3D IP_VERSION(7, 0, 0) || sdma_ip_version=
 =3D=3D IP_VERSION(7, 0, 1))
>                 num_move_entities =3D 1;
> +       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 1=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 2=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 3=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 4, 4=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(9, 5, 0=
) ||
> +           amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(12, 1, =
0))
> +               num_clear_entities =3D 1;
>
>         adev->mman.clear_entities =3D kcalloc(num_clear_entities,
>                                                 sizeof(struct amdgpu_ttm_=
buffer_entity),
> --
> 2.43.0
>
