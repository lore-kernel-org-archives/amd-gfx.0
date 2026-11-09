Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33576606A321
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TfwalAi8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2683E10E8A5;
	Mon,  9 Nov 2026 20:35:12 +0000 (UTC)
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com
 [209.85.217.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EBC210E8A5
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 20:35:05 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id
 ada2fe7eead31-7cc074a653cso49103137.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 09 Nov 2026 12:35:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794256504; cv=none;
 d=google.com; s=arc-20260327;
 b=i+P4m45oUTkeSV4vpUpuPTUuIfOkuqzvczdeTkUYhWIcknXuoBXTMh3K7Z+uZ/MaCA
 00wQRRoCK5isUGon9UzzOwGhmCDGl6pg7Wnlv3k5tX4MszVVrC5pA7DT56TZs9LnlKzm
 TZSU9/M7bQFlNFJDw4bj+KZ+prhJGtB4upeOk6MUWLLQTilLPwV+oYryCBZk/RCkoENo
 5c5U+/9OqMSZSW/n77eXkH0348Ju9NvZAf3aoh7fkvsV/7OoZtV6saflikWaF0NFVA6n
 IpNEYKoKTvzLNHqKI5iP+BpFPFwnc5guXuQJwCI6mKibNthY9+3xVJ8LBMGfQAsIaZLh
 XamQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pfwLw9rBCjiBO9BkSejRs0pLl7ihPFNRSexH8P18xG0=;
 fh=Cm1/F7ESem6NxbFglEXRtZYC9eHozMEAds5QshQ4FU4=;
 b=ALfyi9dQNuaxSpjzNfz5NDC8ltYcO3iiNdbraAlbM3Np3ZwofciIL5qcyWYofDgB0o
 coeS6nPr7QG+1HH053tjFolhPKvSWyCefXUl7gu42+JtdyNnWrZnJUFBHmdGVi9ucyXQ
 SY7YG8HTzN5bipyw4Tbn7brPLioFcccaxQL2714GxScVg8pUqR17I6PxC+/4LQBPUXHq
 sLrqkAEYm6BP5YIgQCTvscWlVaZtDYUlnQJNvloE5YPDqB5qYavNoD0v6gDvADHhUo/o
 mOF4xtaXkEhRsna0bZhpEhdHbGrmHLMUUvrLYmcIdezui1t0k/yfJ3WWOxr2fS1IGHgO
 yNLw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794256504; x=1794861304; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pfwLw9rBCjiBO9BkSejRs0pLl7ihPFNRSexH8P18xG0=;
 b=TfwalAi8eOaZkw2viUx7KgwcJWro8EoXbSTaW4k2A98bFavlo6uxehomr7yRZI5V6T
 KuClJvEfmrrdw4x4q13Fjn31SUIypoc6jSwg+GtyaGCUUFRwQjg1RUeOA/dbGrjSORbV
 x6lcsYGe3k2oAkSw5PAJpYAfnF29xaPqOHjSw12P0urnKyhMEAsDwhScMxnTOVLhPY2m
 WupEMoCJcsuDZwc4ylvUDHU0Xnv8JJVWMZFozb6zhzRiiz/SsKVtHv7rd+bpGoZ9xej0
 X7bY1WYu/PzGK9Cg1P2sUA40qrzmXUz29BXEseH8D0U52dHsvVqevaPzR6BxRnUtE8fu
 Rypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794256504; x=1794861304;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pfwLw9rBCjiBO9BkSejRs0pLl7ihPFNRSexH8P18xG0=;
 b=p1tm0DculFgUlo5/woLBo07hVfEi9BEshKmGjcGXvdrAhP+BkSoSBTsurokZTPa9wa
 h7Ct7XAbjuki9/bU1zBC+rboGMH50ZZI/t3jAMl4Rs3ucsSAfeyGda7KKJbUru2DWGBT
 wJiJWqjW9yjPh/oaehFQErqY5eT4t+TsqGJhId3UerJCJx8gr4tHkc0csHioS8h0PBNh
 5bAMUgmDQtbUrjdYZ2qVd3jY8Tt4AQmizHE6dSUFUK2fm0bMvILkYaBTl78uA2lZ2gq4
 fiUxZS/X6katytnqb4c8ep1lZOE4NDXW5f/4fjjTob7gnyvZwcrbem4ef+2tR9J7RBUV
 cDZw==
X-Gm-Message-State: APuU4Z9jlTZMt6e9Ls3BQEROpjc/FYFrpwXHMJmM0nfc4Fc2UPLKPmLP
 vF/awV14uBklgBWz/2n2rfVJDY/pvNwZ6bSZaTCNkKutRpGX7OMlBWbZa3cq7tzpABP6ucZsFOb
 EoB6tUfM/xRuyiMvY/v5Z+CD2WoDZyuc=
X-Gm-Gg: AYBFou2liHXUVoEUqsYB2UOtpoDBI9qUSW5l05FGl0cbSjjOWoKyAUWNny9OaiIiGi+
 57fb0paK3O/KBqkEJMMaseuHExdsRNbyJzv8TbDu1tNiTNGvscBoQRijvGzAa1Qzgk4KAS/Xe/D
 6sKVjUqukjYtxnirHOGgjpVKn6B6coHqUvFFgQn7AEYhxg4zzblG/zewkPqH/uKBy0YJI/5zrW7
 8chnnXTNadard4xAcwA/5Thbp8qyfXskNB2Xw6u3Bsmz9kKkUzPS8ygn5CFJ0PQ7l2ZqP4SRaod
 Or+qCJSz1mFMYW2MIqxCmRoAECSSFelP5RX2ibswMpMHyXfPqKODwxYDAunUpYKfd6GHYy/jFw1
 0b7SfvJxjcqRvMxhZOKjGdd/Adzm1+TAknBiPIpJT9i3uP5ZAgFdsLrg6YXdawU3DIV5aq1jWzN
 peaiIuUocMFXmk2HpmKWp5mbOT3ag5Z4D3feGmQlRQu3sA/11j2X0MDQvhrWM=
X-Received: by 2002:a67:f80b:0:b0:7d2:a064:aeda with SMTP id
 ada2fe7eead31-7d301b8b63cmr193657137.3.1794256504228; Mon, 09 Nov 2026
 12:35:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
In-Reply-To: <8eb61179-c5b8-41df-a466-8b5c388b6b41@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 9 Nov 2026 15:34:49 -0500
X-Gm-Features: AclHuK_TD2z4jCOaoy6VhUcvF5q3LaXcr9adQrWeNzozi9jR9qfmBoEWs4Stl4M
Message-ID: <CADnq5_OrGuMJT4Tvt+wktPzTYEopdkCjyqq8sSdvJou40-HoKw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] drm/amd/display: report synced displays to
 PowerPlay for MCLK switch
To: Richard Lane <richardlanedev@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Mario Limonciello <mario.limonciello@amd.com>, 
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

On Mon, Nov 2, 2026 at 3:31=E2=80=AFAM Richard Lane <richardlanedev@gmail.c=
om> wrote:
>
> When driving multiple displays or tiled panels with identical timings
> (such as the two 2560x2880 tiles of an Apple 5K iMac panel), Display
> Core's program_timing_sync() aligns the CRTCs into a timing sync group
> in hardware during dc_commit_streams().
>
> However, on DCE < 12, Display Core leaves
> pp_display_cfg.all_displays_in_sync unset. Because PowerPlay is not
> informed that the streams have synchronized vertical blanking intervals,
> SMU7 prevents MCLK switching at idle or causes modeset underflows.
>
> If all active streams belong to the same timing sync group
> (timing_sync_info.group_size =3D=3D params.stream_count), report
> all_displays_in_sync =3D true to PowerPlay after committing the streams s=
o
> SMU7 can safely downclock MCLK at idle.
>

Looking at this a little deeper, the function bw_calcs() in
dce_calcs.c already calculates all_displays_in_sync using the helper
all_displays_in_sync().  Can you look into this and figure out why
that is not working as expected?  My concern with this patch is that
DCE and DCN have different logic for handling mclk switching so I'm
not sure it's safe to call dm_pp_apply_display_requirements() directly
from common code.

Thanks,

Alex

> Signed-off-by: Richard Lane <richardlanedev@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 74cd88d8d580..b4531383437e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -4777,6 +4777,16 @@ static void amdgpu_dm_commit_streams(struct drm_at=
omic_commit *state,
>         dc_exit_ips_for_hw_access(dm->dc);
>         WARN_ON(!dc_commit_streams(dm->dc, &params));
>
> +       if (params.stream_count > 1 &&
> +           dm->dc->current_state->stream_status[0].timing_sync_info.grou=
p_size =3D=3D
> +           params.stream_count) {
> +               struct dm_pp_display_configuration *pp_cfg =3D
> +                       &dm->dc->current_state->pp_display_cfg;
> +
> +               pp_cfg->all_displays_in_sync =3D true;
> +               dm_pp_apply_display_requirements(dm->dc->ctx, pp_cfg);
> +       }
> +
>         bool frl_stream_found =3D false;
>
>         for (i =3D 0; i < params.stream_count; i++) {
> --
> 2.55.0
