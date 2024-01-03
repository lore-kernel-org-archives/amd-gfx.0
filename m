Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801CBC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 14:33:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3329010E31A;
	Wed,  3 Jan 2024 14:33:52 +0000 (UTC)
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com
 [IPv6:2001:4860:4864:20::2d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0DB810E31A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 14:33:51 +0000 (UTC)
Received: by mail-oa1-x2d.google.com with SMTP id
 586e51a60fabf-20503dc09adso3368283fac.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 03 Jan 2024 06:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704292431; x=1704897231; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DZbnrG8ykpIvGnqfjui6ihL9mDzBnToSPk0Pdw1ozwo=;
 b=HDKKMqgUtJb9HUAGwLf1nGYiIfIyuRHpD6Usbb9qWef7JtAMhWM8WuWYXLdNDSzsLe
 DbmK1Vqfgef7DqVX8PwrXn87wVE8sx5yGf4VOmRlivVqKIw/VWQX0Z/i+o2KPWPPpV1z
 yN1W60WvNIbL4NYULMktmrztshBMX6I2d3TQV0VBndui5HI4j2PJZE4vKGNWrxA7lkB2
 /s9REyFMkIktjokI4IxabFhwWlZ7QaTQnUfOBSgjysEgv6JnN6I5x0May611lE1vL/tX
 JJKSAq0A1aqhyYi5Hcy0wJvqo3AwSb0JoCD/yhlSGSVdVn4HIJd5D9eJTJezlA7gHzX4
 MY2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704292431; x=1704897231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DZbnrG8ykpIvGnqfjui6ihL9mDzBnToSPk0Pdw1ozwo=;
 b=j4+dtMQeYO+7PVfIB9B0oY5BFy/9TERyCLk7zG9Lq3tHSmjTBXy1fNAJMRFNJqGGY1
 4LFhgElQ5HHB78rc+6mNM21s+WvgiQZbvnNLL8ZobXuzRBHVPE9mD4XE+gKmFsOLekku
 0evjUib/MhEtSFb5cI21vnqTrzjZCP7fzTiY0m+GqMAVCLjzjIhqiaY/JtwWJxbfsAi6
 +3/LV7z5WVPk1MxtzvkrTeOOu0Kfw90AhUr7u05Qn/rrQenVRPD+3ZCibTLlk6Pod3DM
 NCxFZgpkWTO/8TxHYjRNIijdolWPfoudHB9yrNH8gJcwJUbmyhSHL2lBEAc+xlCZyDMg
 vgTQ==
X-Gm-Message-State: AOJu0YwX8dp/nHQcVATXjj7VIGlP4tRGXLDman2eYkcU5CgSVQgg86Zs
 Nj94GLCKAUKy155raVo1u27h5t5gOjXnEUCp37Sg8yla
X-Google-Smtp-Source: AGHT+IGEM1M3gNOnLH7fIDI76AyZ5+AMeCLkI8VhghGTZkZMwdNbXybbgg3lHv0ofKhQjvWuzskTAcraUl3hZ5r2O48=
X-Received: by 2002:a05:6870:41cf:b0:203:f52b:4fc7 with SMTP id
 z15-20020a05687041cf00b00203f52b4fc7mr25137767oac.108.1704292430909; Wed, 03
 Jan 2024 06:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20231229174156.1800-1-marcelomspessoto@gmail.com>
 <20231229174156.1800-4-marcelomspessoto@gmail.com>
In-Reply-To: <20231229174156.1800-4-marcelomspessoto@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 3 Jan 2024 09:33:40 -0500
Message-ID: <CADnq5_NMDV7u7dR3C=GqA876MaFtv7j6tEGyaMbq146KJjY3WQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] drm/amd/display: Fix freesync.c codestyle
To: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com>
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
Cc: sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, harry.wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Fri, Dec 29, 2023 at 12:43=E2=80=AFPM Marcelo Mendes Spessoto Junior
<marcelomspessoto@gmail.com> wrote:
>
> Remove braces for single statement if expression for freesync.c file
>
> Signed-off-by: Marcelo Mendes Spessoto Junior <marcelomspessoto@gmail.com=
>
> ---
>  drivers/gpu/drm/amd/display/modules/freesync/freesync.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/dr=
ivers/gpu/drm/amd/display/modules/freesync/freesync.c
> index 47296d155..3955b7e4b 100644
> --- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> +++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
> @@ -81,6 +81,7 @@ struct mod_freesync *mod_freesync_create(struct dc *dc)
>  void mod_freesync_destroy(struct mod_freesync *mod_freesync)
>  {
>         struct core_freesync *core_freesync =3D NULL;
> +
>         if (mod_freesync =3D=3D NULL)
>                 return;
>         core_freesync =3D MOD_FREESYNC_TO_CORE(mod_freesync);
> @@ -278,9 +279,8 @@ static void apply_below_the_range(struct core_freesyn=
c *core_freesync,
>                 }
>         } else if (last_render_time_in_us > (max_render_time_in_us + in_o=
ut_vrr->btr.margin_in_us / 2)) {
>                 /* Enter Below the Range */
> -               if (!in_out_vrr->btr.btr_active) {
> +               if (!in_out_vrr->btr.btr_active)
>                         in_out_vrr->btr.btr_active =3D true;
> -               }
>         }
>
>         /* BTR set to "not active" so disengage */
> --
> 2.39.2
>
