Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8415EC7EE23
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 16:48:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AD7B10E2F7;
	Mon,  5 Jun 2023 16:48:35 +0000 (UTC)
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com
 [IPv6:2607:f8b0:4864:20::c32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28CFB10E2F7
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 16:48:33 +0000 (UTC)
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-557d4a08bbaso3041470eaf.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Jun 2023 09:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1685983712; x=1688575712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8aUOvJY1QxniJd9t3W0eGE7IMfRgTczCW+TrBZogOLA=;
 b=KZ3vP211Ocdasx4ekZvMtZP22tTZqdpV4J1JHtFMUI5HhlLjM7Kzn46agly7YfFyy0
 8d8q5DCztMNL1mvyezvUXvAluUsVnDVgLkzhAJJb2JFwTO2glCWx0mTFGaVUTLk9OcGm
 lIeh5TmZSvj+v/TlLYn10qdKXEvPVHr6ZGt9XNP5sVoI18YxIxTsdT58EolWnXwcAuFn
 6kVQUScJ3g5tN6cFwjNFn3vYGx2xCh2LpzHeA7eMhAdbe90fgzY/ZzAVy4N/OzkoL/ps
 hQ9EsCSj01axjWxy963kqosIJ/eM/X/Yr8L/UcgVW5qatBIjVkQ0u4lz1ueST5Yht4Pi
 o2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685983712; x=1688575712;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8aUOvJY1QxniJd9t3W0eGE7IMfRgTczCW+TrBZogOLA=;
 b=fIpfF7sJT2Geg0p+mmKFLJLjdcgsEugUY5lE7ld1D59b7ES9znAll9yJbIWVUIJoVV
 17Lkc9fcn0Mv28kRqwBAQ1/2Yy0sFg3davXH2FTooWN7w3rEmT1XqGlF7EQpR53Yt4lr
 k38zmGfd/oigJHT+2hJmU35gTioHzc5xqmqfGSdO/iHqTKrVEm8QH0CT9+iMrfG6zhZj
 6Z9Ei0VqlkcjUtFr+UGer1ZS41YmR3Eas/OrrmRajNTAyFd5wQGEWtVWBMcyj3ebriiQ
 5DiIUIftQbK2N43s/qDzxWOHHih3MXmoKs7EvQy7UrSIuGsg+ues/Z3QmClQm02oZiDa
 lfng==
X-Gm-Message-State: AC+VfDz+LWL4TLQJgb1C/TQpswPA7h/BBFQQC5xAhGxbwYw+181qscBJ
 hJCk0QqCmsQry7Fz+xiknpiVxlLO6lP4l83uDTa/sVKIfnc=
X-Google-Smtp-Source: ACHHUZ7HAOM/Dmw0rl/Wlralw2eoDMro+PjzOIpIbYLav0mrcyV72C8tz4ZJWdGwAUSQLswaJVlpI8RAmpehqsHIr90=
X-Received: by 2002:a05:6870:d625:b0:19a:f65:7276 with SMTP id
 a37-20020a056870d62500b0019a0f657276mr185641oaq.43.1685983381122; Mon, 05 Jun
 2023 09:43:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230603051043.211548-1-luben.tuikov@amd.com>
In-Reply-To: <20230603051043.211548-1-luben.tuikov@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 5 Jun 2023 12:42:50 -0400
Message-ID: <CADnq5_OWUbYphpbQkgvAdrA4iVtbfeafzibRZSzxF-Bhfvb1bQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Report ras_num_recs in debugfs
To: Luben Tuikov <luben.tuikov@amd.com>
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
Cc: Tao Zhou <tao.zhou1@amd.com>, AMD Graphics <amd-gfx@lists.freedesktop.org>,
 Stanley Yang <Stanley.Yang@amd.com>, Alex Deucher <Alexander.Deucher@amd.com>,
 John Clements <john.clements@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Jun 3, 2023 at 1:11=E2=80=AFAM Luben Tuikov <luben.tuikov@amd.com> =
wrote:
>
> Report the number of records stored in the RAS EEPROM table in debugfs.
>
> This can be used by user-space to calculate the capacity of the RAS EEPRO=
M
> table since "bad_page_cnt_threshold" is also reported in the same place i=
n
> debugfs.
>
> See commit reference 7fb6407145479d (drm/amdgpu: Add bad_page_cnt_thresho=
ld to
> debugfs, 2021-04-13).
>
> ras_num_recs can already be inferred by dumping the RAS EEPROM table, als=
o in
> the same debugfs location, see commit reference c65b0805e77919 (drm/amdgp=
u:
> RAS EEPROM table is now in debugfs, 2021-04-08). This commit makes it an
> integer value easily shown in a single file.
>
> Cc: Alex Deucher <Alexander.Deucher@amd.com>
> Cc: Hawking Zhang <Hawking.Zhang@amd.com>
> Cc: Tao Zhou <tao.zhou1@amd.com>
> Cc: Stanley Yang <Stanley.Yang@amd.com>
> Cc: John Clements <john.clements@amd.com>
> Signed-off-by: Luben Tuikov <luben.tuikov@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_ras.c
> index f2da69adcd9d48..68163890f9632d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1487,6 +1487,7 @@ static int amdgpu_ras_sysfs_remove_all(struct amdgp=
u_device *adev)
>  static struct dentry *amdgpu_ras_debugfs_create_ctrl_node(struct amdgpu_=
device *adev)
>  {
>         struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
> +       struct amdgpu_ras_eeprom_control *eeprom =3D &con->eeprom_control=
;
>         struct drm_minor  *minor =3D adev_to_drm(adev)->primary;
>         struct dentry     *dir;
>
> @@ -1497,6 +1498,7 @@ static struct dentry *amdgpu_ras_debugfs_create_ctr=
l_node(struct amdgpu_device *
>                             &amdgpu_ras_debugfs_eeprom_ops);
>         debugfs_create_u32("bad_page_cnt_threshold", 0444, dir,
>                            &con->bad_page_cnt_threshold);
> +       debugfs_create_u32("ras_num_recs", 0444, dir, &eeprom->ras_num_re=
cs);
>         debugfs_create_x32("ras_hw_enabled", 0444, dir, &adev->ras_hw_ena=
bled);
>         debugfs_create_x32("ras_enabled", 0444, dir, &adev->ras_enabled);
>         debugfs_create_file("ras_eeprom_size", S_IRUGO, dir, adev,
>
> base-commit: e82c20a87511115677528a5e01e58b7763a42edf
> --
> 2.41.0
>
