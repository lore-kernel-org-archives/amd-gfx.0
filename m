Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E9FC87FCF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 15:59:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCED510E5A8;
	Mon,  4 Aug 2025 15:59:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TNeykQum";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95EED10E5A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 15:59:51 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-31ec977d203so937983a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Aug 2025 08:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754323191; x=1754927991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f4ViIU+L6PJklcBVMDTNpmLuvcBqBMRpyevJ44pjIzo=;
 b=TNeykQumlFk9zeY1eyHY2sTtquMbcX3cpV0dxPubmBlvLtBGeQbwyYW38bqapGdwpL
 E2AP4lLZIKkcUaCUX3BA2bhl57OQ2ZJCfPFPGCOhvOJ+v5ursxaTipUUqbKBojVdY/DC
 QWpSPgDyqyt+zg1tiH/cG3NkPt2SXJJlfYSsWPHJqSo65DgXhck4RK3X9isZF+Qtcz66
 51mYC6Gec0GcL/97bPGHYmWDjJCpHjy9sGwguvDjT+GI9iRPTShwU9/8sWIVt61yqc2I
 jKzG0+yHIYt0Dk/3H0If8EdJPxhWYb2lel+7mxdXb3TfZtKh20WD+VE9Kap9l04bDmHg
 gm2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754323191; x=1754927991;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f4ViIU+L6PJklcBVMDTNpmLuvcBqBMRpyevJ44pjIzo=;
 b=cD6G4iHCb778TGko7G3CkawWw6RZ4aGtQS0nl48SIly9IfG3zhxB6qm9MKnkXarq2x
 AgyutadHt5bNtN1NdUeMufca2QTSQXHdclUv6zlYeaxpAq1Rgf28AGwNYylKklLMTEfZ
 Mq7XV582cFG9O7FGaExEtB72Zyv5hFWP2kvnfht+Aq3G3R5LuTEjFTXXvAimO/rr3SP6
 Z6SD+xDl7TwdWUTlwVMh8JX2jrVVtzWZ2wxRt+7v6lhLRn3BgtWnhKgdeLezGOWpb3T0
 X5jFCpFCQK5K+OUiTmb4s6bl6DFi8AbrkbPi8JABZbYEYmax5mzkTf5EHA3+Nj8paQc6
 XqDg==
X-Gm-Message-State: AOJu0YydBg5YkWKTJcIidqT/Xmz1ue/KtiRHmG/twZMzgQ3keXJOaeLH
 jfvyJGk4irFi1VI3Y4PtDhq71+JUmgWtwRWxkBa3kVj0E3gHKmfzgNHt99lVAwVyJJ2s9044ggK
 3PSQ3lrM77Hgb/eUoAXU/DfxLH9RICds=
X-Gm-Gg: ASbGncsPSbRDwTJ/vbPULshkooolB1w2+DCxRXK6m9vf73xgBI0e16Onf/SIfbAWQ1E
 gycEWKR5dit1aYbUNhy0becvwy8l8dQIiJUy3AOo398gf0+uINDu1+gNG5cQ/MoZzo76WOLkalh
 UxA27SXEAGEGTa8PooNcG4QFpGj2wOm9u40Xaq7w35Foa6/fBIXz1Q8ZqpIOFE99HTX+pubnfpu
 BtPC23B
X-Google-Smtp-Source: AGHT+IFLUopcyIFFQG0/kWK0qObzFzyLxbk9fVEZcb6plRcC8zkAxmnYZTmLW+l4ruS1PNZT5W9iQ3eFUKMqlKwXusY=
X-Received: by 2002:a17:90b:1b06:b0:31f:24c2:16cb with SMTP id
 98e67ed59e1d1-321162cd92dmr5665277a91.6.1754323190922; Mon, 04 Aug 2025
 08:59:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-7-timur.kristof@gmail.com>
In-Reply-To: <20250731094352.29528-7-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Aug 2025 11:59:38 -0400
X-Gm-Features: Ac12FXw-FGNoeEBHGJ6uUbIQTgoUBqtLmE8-bE0OzGlgsdMYRd2IWTe9hAns3Og
Message-ID: <CADnq5_PaGVf9AO1tWVq=UTftp=oLfQ526uUXrKm621Gufk8YuQ@mail.gmail.com>
Subject: Re: [PATCH 6/7] drm/amd/display: Don't print errors for nonexistent
 connectors
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Thu, Jul 31, 2025 at 2:03=E2=80=AFPM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> When getting the number of connectors, the VBIOS reports
> the number of valid indices, but it doesn't say which indices
> are valid, and not every valid index has an actual connector.
> If we don't find a connector on an index, that is not an error.
>
> Considering these are not actual errors, don't litter the logs.
>
> Fixes: 60df5628144b ("drm/amd/display: handle invalid connector indices")
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c |  5 +----
>  drivers/gpu/drm/amd/display/dc/core/dc.c          | 15 ++++++++++++++-
>  2 files changed, 15 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/=
gpu/drm/amd/display/dc/bios/bios_parser.c
> index 67f08495b7e6..154fd2c18e88 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -174,11 +174,8 @@ static struct graphics_object_id bios_parser_get_con=
nector_id(
>                 return object_id;
>         }
>
> -       if (tbl->ucNumberOfObjects <=3D i) {
> -               dm_error("Can't find connector id %d in connector table o=
f size %d.\n",
> -                        i, tbl->ucNumberOfObjects);
> +       if (tbl->ucNumberOfObjects <=3D i)
>                 return object_id;
> -       }
>
>         id =3D le16_to_cpu(tbl->asObjects[i].usObjectID);
>         object_id =3D object_id_from_bios_object_id(id);
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/a=
md/display/dc/core/dc.c
> index cf3893a2f8ce..33d6a5116aad 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -217,11 +217,24 @@ static bool create_links(
>                 connectors_num,
>                 num_virtual_links);
>
> -       // condition loop on link_count to allow skipping invalid indices
> +       /* When getting the number of connectors, the VBIOS reports the n=
umber of valid indices,
> +        * but it doesn't say which indices are valid, and not every inde=
x has an actual connector.
> +        * So, if we don't find a connector on an index, that is not an e=
rror.
> +        *
> +        * - There is no guarantee that the first N indices will be valid
> +        * - VBIOS may report a higher amount of valid indices than there=
 are actual connectors
> +        * - Some VBIOS have valid configurations for more connectors tha=
n there actually are
> +        *   on the card. This may be because the manufacturer used the s=
ame VBIOS for different
> +        *   variants of the same card.
> +        */
>         for (i =3D 0; dc->link_count < connectors_num && i < MAX_LINKS; i=
++) {
> +               struct graphics_object_id connector_id =3D bios->funcs->g=
et_connector_id(bios, i);
>                 struct link_init_data link_init_params =3D {0};
>                 struct dc_link *link;
>
> +               if (connector_id.id =3D=3D CONNECTOR_ID_UNKNOWN)
> +                       continue;
> +
>                 DC_LOG_DC("BIOS object table - printing link object info =
for connector number: %d, link_index: %d", i, dc->link_count);
>
>                 link_init_params.ctx =3D dc->ctx;
> --
> 2.50.1
>
