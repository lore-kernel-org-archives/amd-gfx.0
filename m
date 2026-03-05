Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E20F3D32B
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Mar 2026 16:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58E8610E2CA;
	Thu,  5 Mar 2026 16:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y36ipOrS";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BE4310EC40
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Mar 2026 16:23:21 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2be07cafe27so300360eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Mar 2026 08:23:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772727801; cv=none;
 d=google.com; s=arc-20240605;
 b=V7PMjN2lnnpLFf5tC5QVN2yYtoDQ9jCXI9w6aadau28HTC+SSxqOT2oGs3wBWvYDz8
 oXnr24VjQRJkNuKm9pbzfqqytObqJd2Zr6hK/Hu3oW2fzIYhqrccI/j6CrxIqEZBlKkm
 09kwFDTtK/rCwXQHwmo8/hA7eeMPoplGk/esUnxzyWQEwJ3z8MJJpiHPruc8MpSyw1h1
 feBEIxCXkvAEuWRkrXExjUHyeYzKUmp1HvzD5QhaxET3alMF9IYba6cqlSgghZNP/pXI
 jZAZOkzonkWLc1K4BqyCk6BSPy3OUINKLNd9X10SqGpX3jooWJNFQ+9uX9m08rkzW47I
 +o3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=W6F+nfMUPxF4a7E27ABQJs8vgRwzPBeDB+h+6m9Jqk4=;
 fh=Z8KoS9XFs5Oc1amUAun74POtOGZ8gF5xAaz27PMl4Kg=;
 b=PAGrNt/wUVEFL80O0MYiJl8LTPdCsOjXbo0TpYa0LRLrzCbs8LSePIXflgTtsELZ2R
 NtbwHy66seaXtUFfZ4JouDWN1aHEB3WVeLrWFVS9gGdFII8G7+/B3IJo35Cd/NhWXwv2
 rdKD1Wx09WGKGzniANSaPZW8QSfIoU+1NT+fyYC+BOXdKG+AfjzC80l2UD+FCnPawFYc
 p8do8VcFWQxt6JlidNrtX+LclS8bt4JfS9QghVsXAD7bSt8ozOj+Wi2BvJP/a9+pWR79
 3tyXPErIXPRThvt85nTYwQXXnAB58C/Qd6wuK7r+TAIsE6SL204FeQU4nKMenv/k0xpO
 /YuQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772727801; x=1773332601; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6F+nfMUPxF4a7E27ABQJs8vgRwzPBeDB+h+6m9Jqk4=;
 b=Y36ipOrS0vbe0nVkZQFB5D1wlIzGS2MUqh3ZAJCnhBVmX6ub78Y5t9kNfiDq2FvoBH
 ANfgEZ1QhHfVRzvU0argFQGYLftdcrZyrEhbDdrHhnO+XphkYwFQFs9KqqfI1G8Llp73
 qfeSNNe0o4S+E8pphlgPL3mIE0zqB2UOmTMiiHGBOPyQJDdR7cizzbgeRXVSGIlq7jFO
 iHKeAyKaEKrjnmOIpcCtKDuSGJyM1uxhr+mtodkSRKATxE6Fzo6wgerDwrO2u+l0rDV4
 PjG5GBB7iJlchyb6N1lP8CAq+OIlPJr0A4cb1xlho7Hu8wgnwyG9wGePs92UPrco1qe2
 5JUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772727801; x=1773332601;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=W6F+nfMUPxF4a7E27ABQJs8vgRwzPBeDB+h+6m9Jqk4=;
 b=nlbjEM+Pif1FwnveOaCtWXNE+VxCOWh136T41CbJauuemf+7qQUd+2yweFSFAXqpHZ
 lOEey3k7R5JBi/leTG7uoDG+ljSdP0OW/tEI+ULNeUhLXkE5LSwc6+Otf6HZrrElE6Ls
 ZCbYCBTvgPMLHmu8g9Q+zGkmZxYGUynwLTZT863w/5bpRuRZd5fPWC/3HEjog7g7z7nC
 fFhbjuYtkO2kS1HGXg8f4NkM6OmvbsPTBBS0rc1kNlWia3unwlXi2f3ZWSR4Qgs7VdUu
 LX6jaKOyRgCwKXx/4TqWHf/SbKxAJwT9m+aHcD9AXnPJHwOELhcI2i+YGmwdibRxTII9
 4FiQ==
X-Gm-Message-State: AOJu0YxmCAGKjUbdSpU4Y/uC4m+MwF3vVbZgRHsmMsXWJ8V+fFw0e9kX
 vPvP1qAmnVr8BL3wwZO08XUZtib0+yujXh9XQWYn8SLS345a/C6bpT59NWLlExBn1UAjn8cphqZ
 zjcAU21hrwSl5hOpxUeHX6yUtNZdViqersg==
X-Gm-Gg: ATEYQzzpZERJv1cuZcwEOYUyu7D/HDN2o5QQ6i5xosYsg/WRZunKFVIFMsaPVC9RLIC
 rk5Hp2XNmi4L4RIoKUdVJ5I3XO/S584WJ58c19EbBKTDvHj5e/Au/lk7Y2yRlWEyRGWIUlmcGnP
 I5pOS3bPg694C1ma9vtG/CmTuKdgXWDF9LSI3BztRwf2jyrihA+Qn+yAa3xQxbj6aHPtOnpdxmd
 rEvgbH08oYZCpNwr6n93box887pn483x2K5/OIzDwuP8gUOJ0d8fFIkwkFx/rCxzVqdlZFabh4x
 WRDrHZDwDZKY9xEZfK2m3S47KAMy0PHw6w84aspj5wi1CtzAWYMliP3jQQoN1UjU75EPirs6DLe
 VJ02Z
X-Received: by 2002:a05:7022:6b82:b0:11b:65e:f33 with SMTP id
 a92af1059eb24-128b70664bbmr1490910c88.1.1772727800809; Thu, 05 Mar 2026
 08:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20260303211823.76631-1-jpeisach@ubuntu.com>
 <20260303211823.76631-3-jpeisach@ubuntu.com>
In-Reply-To: <20260303211823.76631-3-jpeisach@ubuntu.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 5 Mar 2026 11:23:09 -0500
X-Gm-Features: AaiRm53O0Gz_IyWjrfwtBJvNGedJNJLK6tD16jvmpNK_3Hj0veX7H5OdrmEZeHM
Message-ID: <CADnq5_MioRPUgwWeRWBQLMVvjPjFLL8Ub+w6dQCkj84xUqu1Tw@mail.gmail.com>
Subject: Re: [PATCH RESEND 2/2] drm/amdgpu/amdgpu_connectors: remove
 amdgpu_connector_free_edid
To: Joshua Peisach <jpeisach@ubuntu.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

Applied the series.  Thanks!

Alex

On Tue, Mar 3, 2026 at 4:19=E2=80=AFPM Joshua Peisach <jpeisach@ubuntu.com>=
 wrote:
>
> Now that we are using struct drm_edid, we can just call drm_edid_free
> directly. Remove the function and update calls to drm_edid_free.
>
> Signed-off-by: Joshua Peisach <jpeisach@ubuntu.com>
> ---
>  .../gpu/drm/amd/amdgpu/amdgpu_connectors.c    | 22 ++++++-------------
>  1 file changed, 7 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index 6336cadad..aabe9d58c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -297,14 +297,6 @@ static void amdgpu_connector_get_edid(struct drm_con=
nector *connector)
>         }
>  }
>
> -static void amdgpu_connector_free_edid(struct drm_connector *connector)
> -{
> -       struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector=
(connector);
> -
> -       kfree(amdgpu_connector->edid);
> -       amdgpu_connector->edid =3D NULL;
> -}
> -
>  static int amdgpu_connector_ddc_get_modes(struct drm_connector *connecto=
r)
>  {
>         struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector=
(connector);
> @@ -754,7 +746,7 @@ static void amdgpu_connector_destroy(struct drm_conne=
ctor *connector)
>  {
>         struct amdgpu_connector *amdgpu_connector =3D to_amdgpu_connector=
(connector);
>
> -       amdgpu_connector_free_edid(connector);
> +       drm_edid_free(amdgpu_connector->edid);
>         kfree(amdgpu_connector->con_priv);
>         drm_connector_unregister(connector);
>         drm_connector_cleanup(connector);
> @@ -873,7 +865,7 @@ amdgpu_connector_vga_detect(struct drm_connector *con=
nector, bool force)
>                 dret =3D amdgpu_display_ddc_probe(amdgpu_connector, false=
);
>         if (dret) {
>                 amdgpu_connector->detected_by_load =3D false;
> -               amdgpu_connector_free_edid(connector);
> +               drm_edid_free(amdgpu_connector->edid);
>                 amdgpu_connector_get_edid(connector);
>
>                 if (!amdgpu_connector->edid) {
> @@ -889,7 +881,7 @@ amdgpu_connector_vga_detect(struct drm_connector *con=
nector, bool force)
>                          * with a shared ddc line (often vga + hdmi)
>                          */
>                         if (amdgpu_connector->use_digital && amdgpu_conne=
ctor->shared_ddc) {
> -                               amdgpu_connector_free_edid(connector);
> +                               drm_edid_free(amdgpu_connector->edid);
>                                 ret =3D connector_status_disconnected;
>                         } else {
>                                 ret =3D connector_status_connected;
> @@ -984,7 +976,7 @@ static void amdgpu_connector_shared_ddc(enum drm_conn=
ector_status *status,
>                                         /* hpd is our only option in this=
 case */
>                                         if (!amdgpu_display_hpd_sense(ade=
v,
>                                                                       amd=
gpu_connector->hpd.hpd)) {
> -                                               amdgpu_connector_free_edi=
d(connector);
> +                                               drm_edid_free(amdgpu_conn=
ector->edid);
>                                                 *status =3D connector_sta=
tus_disconnected;
>                                         }
>                                 }
> @@ -1053,7 +1045,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *c=
onnector, bool force)
>         }
>         if (dret) {
>                 amdgpu_connector->detected_by_load =3D false;
> -               amdgpu_connector_free_edid(connector);
> +               drm_edid_free(amdgpu_connector->edid);
>                 amdgpu_connector_get_edid(connector);
>
>                 if (!amdgpu_connector->edid) {
> @@ -1069,7 +1061,7 @@ amdgpu_connector_dvi_detect(struct drm_connector *c=
onnector, bool force)
>                          * with a shared ddc line (often vga + hdmi)
>                          */
>                         if ((!amdgpu_connector->use_digital) && amdgpu_co=
nnector->shared_ddc) {
> -                               amdgpu_connector_free_edid(connector);
> +                               drm_edid_free(amdgpu_connector->edid);
>                                 ret =3D connector_status_disconnected;
>                         } else {
>                                 ret =3D connector_status_connected;
> @@ -1417,7 +1409,7 @@ amdgpu_connector_dp_detect(struct drm_connector *co=
nnector, bool force)
>                 goto out;
>         }
>
> -       amdgpu_connector_free_edid(connector);
> +       drm_edid_free(amdgpu_connector->edid);
>
>         if ((connector->connector_type =3D=3D DRM_MODE_CONNECTOR_eDP) ||
>             (connector->connector_type =3D=3D DRM_MODE_CONNECTOR_LVDS)) {
> --
> 2.51.0
>
