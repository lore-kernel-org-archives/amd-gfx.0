Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F69FF885A
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Apr 2026 15:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB6E810E339;
	Tue, 28 Apr 2026 15:38:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gTZde/yT";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA14B10E339
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 15:38:34 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-12c87f1f8c8so757558c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Apr 2026 08:38:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777390714; cv=none;
 d=google.com; s=arc-20240605;
 b=FY/ZSDq6tD19i7W7g4fiOy3sQ6J9c9seYODmk9SnYih/9Zob4Aj18gK4Mdns3l9jc5
 c85MHQYqmtZNDSkqapBFDTSj0XaHi+clDDNPl3LmSUrghVtUMLvA4WooSPY3rjbMzlJq
 qqIeHOMZiwguWGw9feqkNde+A0IDPKuUohEoawfwBqLCRypaIY5qQiTXnFwAUn6KK/Uz
 W97cG5hun9DJsuI6yISTvfAcoaN2TSHefSVEucgDlid76iS7svVpaIgDnM69MDmnFPR7
 ZCGO0ekAsJ9cHw+4uzCcZTvKptXPzVx9QZyvHsH83cpZE/K7tvS03UrWKIPjU8wgL4eK
 ZDnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=1vlxp0DeZ8GEsmjpDNkyWpeuN9UMYViYowsvdGI/rnY=;
 fh=4EZMVWf3LwlV5EAXNlkE8jHnJbWP8LID0bIrjs8Shr4=;
 b=ZI23fZKeEPfrI9GfZ9AqnjYAaV67KUyUHa6Vuc2MTW7nfbfOQGzAZCjK3/mz12i6/Y
 iQY/bxQPYREPCH8LG1Cwiw5OXnO6tQ/71/bKvaiTXKrdxKkmAp0UdwxyIFh+bN2NMWLc
 RCGs35Vp5xUB/cljtOTyfFDA5vczXviK+9ELPqq8iET50dWAapPqhlTuLdCzGohT7En6
 4E0lUzgX6XqciGt/b01n7tx7J5cSbGzmZz6XnbFJvWzcy7khDzAmlYcN8BcPJAHBpsO8
 OvDCXCVbd/7DrvL+NsPycv7ryEHRiwfC3BsywVSyzulZgeMPZpXf6s9HnX4MLtL5RMxr
 TFwg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777390714; x=1777995514; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vlxp0DeZ8GEsmjpDNkyWpeuN9UMYViYowsvdGI/rnY=;
 b=gTZde/yTQL7o16HDd5pXWj10b2nbLa0FySws567YBsXHgx6HZ1CccJsrcJVyDZtE0+
 lmxReQsa0gThf0E/BEi62kY2izkzAlvjpenfbZj7PUJzSyO9Vbqze9fb6Ju6+m0JkHx/
 zgNnA+aHrztnuSVQiW7nOkH8h1VBNjkE+x+f2RMZgCIlFpkuRCaeCJziGPn5qHfaHsQb
 1fSs+euhD+6WIulc9zG5uOhEFhvjMkoVSQNa+dUl8JOXKkneT9zHJY1WR3VnnjFwoxWv
 g0zmkAzUveT4LScXD5Fjlz5Xd//N0hKcwwVSAXULjXZmCjaFu8uTGbtZXvoztmuSkHeP
 b+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777390714; x=1777995514;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1vlxp0DeZ8GEsmjpDNkyWpeuN9UMYViYowsvdGI/rnY=;
 b=XpAHXJFT0pa4rEdSp1Pi/a9jDDtRZ1m0wfhgVeUJS9nja3aIF91pQ8OquECu4Nyfzi
 IchEbvyD4LzCn0wm2C4JkNvTfsk8iUAITyeyfOJYcadb83u+O6jX4ol3UoJB4YnJLhfz
 gw5pnCri94zkq9t9ccGW1h3Ve912BXCWO+5vGfW+scSs1tdkJqLmIbkUxMTtHA3/PA85
 bbhB3S16zpMeTcSClPJ6vlJmUuJHq8CuNYTcxefDYroabTlU2hM+zNIjlqlEWIt5EjlM
 lWrTaYFVTbQHgMv2GaAO8GcLkdDgRmC2IpkAgvfh/dty4OguK0XxklGlpMnNNPaKtW9w
 Jdaw==
X-Gm-Message-State: AOJu0YzY4X2eFftVQxMCDLuvOg51Bq7OkSs6c3aUBQ2/t1TBBx6GQPXr
 Z/fNAjntrATmYVR0qTJVqxUARLXEYfdv02f2jkNt83CcfOAygNgWfrWDuZKQkyQjjkkvhdQin3T
 yETCX13SnIWg3si2vrYpma/YNVvpsuQg=
X-Gm-Gg: AeBDies07T//aOY2ZHc4z93yNcc7Jv4IjeEQzuQFo32UXyfOdapXb1+Ufs9uci0U251
 bh8UpGyjysfZ+u2KXTKPoGEf3MXQI8VX5rq1M4GqRrhQWKu/zQVcOf95iQHP0jYZLcWRfsB+zZO
 uKe7IERcCu7fokFbj1kE7XqLk6umMu+ttAjP8eGMUM0tq9ONuidaCm3vTmmDpAqZZJuD2uWFKV2
 uZCNepA3yp/mXcJ6FSBtYDf+GXJvEkDwxWxNViGQU3KysEHMRW3fxkgHHSp1Usg+QvZEyP0NLJQ
 WYLEZdnknaO9GZHNWXnH4SAmW7PmVbPIQsvV7CBLqnlrV/HiluOfbIhEDWJMte2Ggrt8ABFRKI4
 TzPol
X-Received: by 2002:a05:7022:f8c:b0:12d:b4e2:f566 with SMTP id
 a92af1059eb24-12ddd539d5cmr797006c88.4.1777390713829; Tue, 28 Apr 2026
 08:38:33 -0700 (PDT)
MIME-Version: 1.0
References: <20260428114045.40710-1-timur.kristof@gmail.com>
 <20260428114045.40710-7-timur.kristof@gmail.com>
In-Reply-To: <20260428114045.40710-7-timur.kristof@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 28 Apr 2026 11:38:21 -0400
X-Gm-Features: AVHnY4JcdkVLSy6WQhKwW0YjE7dxwsny9-4AjjahpuQELnTsnXUakPyQ9tTCr9Q
Message-ID: <CADnq5_OQotcyrffGbo+ThzUmzkBjJYnSSYvfBucnytRPmU+R3g@mail.gmail.com>
Subject: Re: [PATCH 6/6] drm/amd/display: Use EDID from VBIOS embedded panel
 info
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, 
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>, 
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
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

Applied the series!

Thanks,

Alex

On Tue, Apr 28, 2026 at 7:59=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> When an embedded panel has no DDC, read the EDID from
> the VBIOS embedded panel info and use that.
>
> Fixes: 7c7f5b15be65 ("drm/amd/display: Refactor edid read.")
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5192
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> ---
>  .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index c53230cdfdc57..c491af21a34c6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -1032,6 +1032,45 @@ dm_helpers_read_acpi_edid(struct amdgpu_dm_connect=
or *aconnector)
>         return drm_edid_read_custom(connector, dm_helpers_probe_acpi_edid=
, connector);
>  }
>
> +static const struct drm_edid *
> +dm_helpers_read_vbios_hardcoded_edid(struct dc_link *link, struct amdgpu=
_dm_connector *aconnector)
> +{
> +       struct dc_bios *bios =3D link->ctx->dc_bios;
> +       struct embedded_panel_info info;
> +       const struct drm_edid *edid;
> +       enum bp_result r;
> +
> +       if (!dc_is_embedded_signal(link->connector_signal) ||
> +           !bios->funcs->get_embedded_panel_info)
> +               return NULL;
> +
> +       memset(&info, 0, sizeof(info));
> +       r =3D bios->funcs->get_embedded_panel_info(bios, &info);
> +
> +       if (r !=3D BP_RESULT_OK) {
> +               dm_error("Error when reading embedded panel info: %u\n", =
r);
> +               return NULL;
> +       }
> +
> +       if (!info.fake_edid || !info.fake_edid_size) {
> +               dm_error("Embedded panel info doesn't contain an EDID\n")=
;
> +               return NULL;
> +       }
> +
> +       edid =3D drm_edid_alloc(info.fake_edid, info.fake_edid_size);
> +
> +       if (!drm_edid_valid(edid)) {
> +               dm_error("EDID from embedded panel info is invalid\n");
> +               drm_edid_free(edid);
> +               return NULL;
> +       }
> +
> +       aconnector->base.display_info.width_mm =3D info.panel_width_mm;
> +       aconnector->base.display_info.height_mm =3D info.panel_height_mm;
> +
> +       return edid;
> +}
> +
>  void populate_hdmi_info_from_connector(struct drm_hdmi_info *hdmi, struc=
t dc_edid_caps *edid_caps)
>  {
>         edid_caps->scdc_present =3D hdmi->scdc.supported;
> @@ -1052,6 +1091,9 @@ enum dc_edid_status dm_helpers_read_local_edid(
>
>         if (link->aux_mode)
>                 ddc =3D &aconnector->dm_dp_aux.aux.ddc;
> +       else if (link->ddc_hw_inst =3D=3D GPIO_DDC_LINE_UNKNOWN &&
> +                dc_is_embedded_signal(link->connector_signal))
> +               ddc =3D NULL;
>         else
>                 ddc =3D &aconnector->i2c->base;
>
> @@ -1065,6 +1107,8 @@ enum dc_edid_status dm_helpers_read_local_edid(
>                 drm_edid =3D dm_helpers_read_acpi_edid(aconnector);
>                 if (drm_edid)
>                         drm_info(connector->dev, "Using ACPI provided EDI=
D for %s\n", connector->name);
> +               else if (!ddc)
> +                       drm_edid =3D dm_helpers_read_vbios_hardcoded_edid=
(link, aconnector);
>                 else
>                         drm_edid =3D drm_edid_read_ddc(connector, ddc);
>                 drm_edid_connector_update(connector, drm_edid);
> --
> 2.53.0
>
