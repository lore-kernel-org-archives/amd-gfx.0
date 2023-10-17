Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E15C46CA1
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Oct 2023 21:17:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AD7010E32D;
	Tue, 17 Oct 2023 21:17:02 +0000 (UTC)
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com
 [IPv6:2001:4860:4864:20::32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC6AD10E32C;
 Tue, 17 Oct 2023 21:16:57 +0000 (UTC)
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1e12f41e496so3800325fac.3; 
 Tue, 17 Oct 2023 14:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697577417; x=1698182217; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DQG8MtBQiSnRV8n69T7HmV5t8yhCaq2M9pMbaLDDzpc=;
 b=bUXETrsE76QhWjOIC16GbnaLLSOOiSpMr3PJ3jiNCVgesuLruDaQG/F2Jum4MCEF78
 xpcTgx6uUOPxjZcAE8fPxbqPDFvlD7T1oIKRC2KGrUSvZs1/2KtNKoQEMaho8/d7RwEZ
 nKqO6/R0AzO32DbNeCZ0lAShdlY8cefUNgZkXxw052G/iXX2TiOQrXMKVmy6Zwj9Oy1g
 ihdwB8Qo/H8MYqGz1jYMCczoW9be8sPPXjvS/w+reCHkoY0aWlVUrPoDRiE65p4S7HrT
 5TcUjjFtyamDkBNxrwaiq//uZn5ZMejOc5AqeoXlEvlOXkdQnVTUnRj7Uuu/7Rscn0PL
 6iIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697577417; x=1698182217;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DQG8MtBQiSnRV8n69T7HmV5t8yhCaq2M9pMbaLDDzpc=;
 b=ahUCvusxopXKekqdnD5APZEMXPee3Jp1HNxxyszRd3wp6z979NZBxY5cEPmeqWgaZW
 1sOzzOo9DPtrAjMN2dk9I16tEXEaYhEqTpWbbzxkMRkAccwO7/qeDqLKmAqGkQQJ/rYy
 taqXLkeebAA3vL42X1e8Dvazt4Zq6d5C0MwhRuYP8bnrDxITe/GATR8xuwGtULikD3ys
 TQVDVr2WdGjVNEmoihwouXQlY4XxPkDRIE1HnsClStYwIsiLA3d8zpkXoBnZUION/Riv
 FqbKT6xktWncLSK3XU+TCquSuMBO7SMxNEa1EIZlyXwVF2WjGcflG6g4SVQhKOqXiPcD
 GlSQ==
X-Gm-Message-State: AOJu0YyPNXSvaUDOip7y8g66Ba9fN4qcc1HylVcrl9p1aUFHZnndtHI3
 I2vhH1n/v7pEW0meYHwpTzDsxvQy1JZK76dysB8=
X-Google-Smtp-Source: AGHT+IFIdnup1Pui0Ph3Sx3b6dyIUwP7KU7y+C7Voyy0lzypj5Ks7q5EsuqaHmjprmGcgrekVDP+pKHvrpPbrGFNJuA=
X-Received: by 2002:a05:6870:1314:b0:1e9:9f9b:eb80 with SMTP id
 20-20020a056870131400b001e99f9beb80mr3731834oab.46.1697577417041; Tue, 17 Oct
 2023 14:16:57 -0700 (PDT)
MIME-Version: 1.0
References: <20231017080616.18970-1-colin.i.king@gmail.com>
In-Reply-To: <20231017080616.18970-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Oct 2023 17:16:46 -0400
Message-ID: <CADnq5_PemQtG4CeeDm4QvNMWF_O69AXD5k66R2C3OhWe8L6sdA@mail.gmail.com>
Subject: Re: [PATCH][next] drm/amd/display: Fix a handful of spelling mistakes
 in dml_print output
To: Colin Ian King <colin.i.king@gmail.com>
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
Cc: kernel-janitors@vger.kernel.org, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Xinhui.Pan@amd.com, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks!

On Tue, Oct 17, 2023 at 4:22=E2=80=AFAM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There are a few spelling mistakes and an minor grammatical issue in
> some dml_print messages. Fix these.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c b/dr=
ivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> index 851db026f251..218c355a97a4 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2/display_mode_core.c
> @@ -1507,7 +1507,7 @@ static dml_bool_t CalculatePrefetchSchedule(struct =
display_mode_lib_scratch_st *
>                 dml_print("DML: Tvm: %fus - time to fetch page tables for=
 meta surface\n", s->TimeForFetchingMetaPTE);
>                 dml_print("DML: Tr0: %fus - time to fetch first row of da=
ta pagetables and first row of meta data (done in parallel)\n", s->TimeForF=
etchingRowInVBlank);
>                 dml_print("DML: Tsw: %fus =3D time to fetch enough pixel =
data and cursor data to feed the scalers init position and detile\n", (dml_=
float_t)s->LinesToRequestPrefetchPixelData * s->LineTime);
> -               dml_print("DML: To: %fus - time for propogation from scal=
er to optc\n", (*p->DSTYAfterScaler + ((dml_float_t) (*p->DSTXAfterScaler) =
/ (dml_float_t)p->myPipe->HTotal)) * s->LineTime);
> +               dml_print("DML: To: %fus - time for propagation from scal=
er to optc\n", (*p->DSTYAfterScaler + ((dml_float_t) (*p->DSTXAfterScaler) =
/ (dml_float_t)p->myPipe->HTotal)) * s->LineTime);
>                 dml_print("DML: Tvstartup - TSetup - Tcalc - Twait - Tpre=
 - To > 0\n");
>                 dml_print("DML: Tslack(pre): %fus - time left over in sch=
edule\n", p->VStartup * s->LineTime - s->TimeForFetchingMetaPTE - 2 * s->Ti=
meForFetchingRowInVBlank - (*p->DSTYAfterScaler + ((dml_float_t) (*p->DSTXA=
fterScaler) / (dml_float_t)p->myPipe->HTotal)) * s->LineTime - p->TWait - p=
->TCalc - *p->TSetup);
>                 dml_print("DML: row_bytes =3D dpte_row_bytes (per_pipe) =
=3D PixelPTEBytesPerRow =3D : %u\n", p->PixelPTEBytesPerRow);
> @@ -9323,7 +9323,7 @@ void dml_core_mode_programming(struct display_mode_=
lib_st *mode_lib, const struc
>                                 if (mode_lib->ms.policy.ImmediateFlipRequ=
irement[k] !=3D dml_immediate_flip_not_required && locals->ImmediateFlipSup=
portedForPipe[k] =3D=3D false) {
>                                         locals->ImmediateFlipSupported =
=3D false;
>  #ifdef __DML_VBA_DEBUG__
> -                                       dml_print("DML::%s: Pipe %0d not =
supporing iflip\n", __func__, k);
> +                                       dml_print("DML::%s: Pipe %0d not =
supporting iflip\n", __func__, k);
>  #endif
>                                 }
>                         }
> @@ -9376,7 +9376,7 @@ void dml_core_mode_programming(struct display_mode_=
lib_st *mode_lib, const struc
>         if (locals->PrefetchAndImmediateFlipSupported) {
>                 dml_print("DML::%s: Good, Prefetch and flip scheduling so=
lution found at VStartupLines=3D%u (MaxVStartupAllPlanes=3D%u)\n", __func__=
, s->VStartupLines-1, s->MaxVStartupAllPlanes);
>         } else {
> -               dml_print("DML::%s: Bad, Prefetch and flip scheduling sol=
uation NOT found solution! (MaxVStartupAllPlanes=3D%u)\n", __func__, s->Max=
VStartupAllPlanes);
> +               dml_print("DML::%s: Bad, Prefetch and flip scheduling sol=
ution did NOT find solution! (MaxVStartupAllPlanes=3D%u)\n", __func__, s->M=
axVStartupAllPlanes);
>         }
>
>         //Watermarks and NB P-State/DRAM Clock Change Support
> --
> 2.39.2
>
