Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096FBC0015E
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Jul 2023 18:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EDE810E07B;
	Wed, 26 Jul 2023 18:29:13 +0000 (UTC)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC82610E07B
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 18:29:11 +0000 (UTC)
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3a3c78ede4bso125376b6e.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Jul 2023 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1690396151; x=1691000951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ictiSePRO4wZJtCdIutsdJCYAbYDx9K3F8Wh0KBfK6Y=;
 b=dTfGqj/y1Oo8SvZSkLw+eKmTdMs5rGxFCcge8fllnjBa/a6ROr4z9nTiE3uE4+8dkn
 jpIDXGVutIvuj+WFkCa+3FHB3ZG6N0erMX6G0PBoXrWGzs72S5FyhUy4sAJZ3WeuN3o7
 Aw3qGtX74DmAEJk0o3E+Ibs3FEt6fNcmL75K8iDM5PepYbYfh/WrarD0zXcKe07tLoMR
 Hg8RmxUPckYyLIPC2weFqjvhi0c8sTxP0zbI+5cylRgfIkBuSXALUm0gqrW1BBVNcSrf
 feo3WmpaL0ITpMuatgMHHkpSmUIjtxGnrLV7YXW2814Lu9/jRN9IJ18xj7fHCZONb6b4
 tVcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690396151; x=1691000951;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ictiSePRO4wZJtCdIutsdJCYAbYDx9K3F8Wh0KBfK6Y=;
 b=ZVA1kRIFfWx472kNBu3mOc6AoXhZx32FGK08ZcLTTXR6a+m4VOZDdO2OUGBzvqW+m+
 bsIDFsBfQR9WDWGM94z99GZst75j+Mw8yltGitVQhFfSaDYIEdcc/cnrAN/IxZ+cwx2j
 yls5UAQpqon05ftyO8Mnrg+H5IEQdgdOeXvo15nO18uvvE3bzkaMLIUpmdN/5uUNC+kK
 q6xgG3e3SBtkbCCC4kLBH2u4f9IVzImVGEtAsX2njeeZixnzaeMWDYYz6cBJ0yYykzr9
 TvmKP2utARiEmUG7myxe2o+QWF2VHlCICu6uAPMGoKOWCrC+PM8dwq/Zv1eMF8gg+GZX
 idOQ==
X-Gm-Message-State: ABy/qLa5BorYdJTf8It+O7R+sO5ubhbnS9mzPOHfjmgFmHQveMIhVK6s
 YAmBbbKnJ6BIOL/Cj6X7CrCsbdbj+hKE8crvbFxc7Ut34zA=
X-Google-Smtp-Source: APBJJlGkaLsML4/Yjb7G+bKTYehiOBC2PgotKsfnpgyOp9Npxpya77aoZadLx3VeqSy/qw1WYLlHhIwZCWe0lmPr8yA=
X-Received: by 2002:a05:6808:1529:b0:3a6:7557:d838 with SMTP id
 u41-20020a056808152900b003a67557d838mr386909oiw.40.1690396150902; Wed, 26 Jul
 2023 11:29:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230726162357.2499855-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230726162357.2499855-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 26 Jul 2023 14:29:00 -0400
Message-ID: <CADnq5_NToa2t77nQpLY66qbQHsJita7cspm6nKoY47HTUQ5WZQ@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Remove unnecessary NULL test before kfree in
 'radeon_connector_free_edid'
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
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Guchun Chen <guchun.chen@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Wed, Jul 26, 2023 at 12:24=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the below:
>
> WARNING: kfree(NULL) is safe and this check is probably not required.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/radeon/radeon_connectors.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c b/drivers/gpu/drm=
/radeon/radeon_connectors.c
> index 4ceceb972e8d..d2f02c3dfce2 100644
> --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> @@ -333,10 +333,8 @@ static void radeon_connector_free_edid(struct drm_co=
nnector *connector)
>  {
>         struct radeon_connector *radeon_connector =3D to_radeon_connector=
(connector);
>
> -       if (radeon_connector->edid) {
> -               kfree(radeon_connector->edid);
> -               radeon_connector->edid =3D NULL;
> -       }
> +       kfree(radeon_connector->edid);
> +       radeon_connector->edid =3D NULL;
>  }
>
>  static int radeon_ddc_get_modes(struct drm_connector *connector)
> --
> 2.25.1
>
