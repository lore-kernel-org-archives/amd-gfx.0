Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C9FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jun 2022 15:27:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D561910EF32;
	Tue, 21 Jun 2022 15:27:40 +0000 (UTC)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D03810F0B1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 15:27:39 +0000 (UTC)
Received: by mail-io1-xd2a.google.com with SMTP id n11so14605623iod.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jun 2022 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=Kpsk6t7byF0Wefcv3WDRoOBLZsTnqCGH43ttikkBli0=;
 b=diEDXlL4V5gzIPX49G2vAqqwGRgWZ6slJC0goYyw3QOvCihM+IodGR/ht3T8TWbDPd
 ivqcrz8tb/pv+djwgPMz2pduRQrwOHNhGpmOH0IhDRpWj8CUZCXEiqRufEIAwUDfFSo0
 UMHn2sX4xk6FwWEUlMMFkxsvL8hRx4iXtFzXW767UfMpXPu0tJjhAuw1FWSXU1XiaemQ
 4wssDsaQ6V/aerGvaTqCSlexDePsEaUWWUwzRVUDxY27fWijampUbZIa1fdkvxK5N/7+
 dDQJI08X27TTom3j3FCnTU5V0AhD1swUMRkO53bRamKjAMguygpg/KHUC0kGhIteD+e1
 a6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=Kpsk6t7byF0Wefcv3WDRoOBLZsTnqCGH43ttikkBli0=;
 b=RCpyx2pBLbAO4khEbe9OIMLfdcreRjcpcZJmpiKIgMes9SHxXFlRVgNLcsbmP0wLZJ
 KtVF6Za/fPSf5ViQrrIu2iouXq/Lk/2Ld/QTXwKohdQVCQ5G1cO8UKpMiNJqAK5WlkhO
 9yyYSCTpVH2hD62r5+sNruqa+gkY8eV0VWISu4QgciqhBeCETki6jJfd05KNVRqzCug5
 5WZs5KqiWJKWSLWfdnqe5ztlvXE2OwGgUMoekF9V4XGQFfLaE0FVNQ8sEDVcJo77e0j7
 ikQ0PXmhptGd8x1YCWGUyWE+o+3y0QPDx/TZ0eVZSISBBbZ49Nik0BE+tG4pEuyTri/c
 GYng==
X-Gm-Message-State: AJIora96JabZg4BaG3/zNWdKwwVgi2zT3WsztI4Y9q6ulGplDStCW8Xf
 heqQFUVJ6djvNfTRLCcL4D1DK/qUiWD59dgb4Qc=
X-Google-Smtp-Source: AGRyM1sj8DA3Go524KZ+JYb/qgy/gAH5DnEJ7tsR/9AEH6eXTwGJblPJ5Crf7j65Pbur15EGiTUj9tnf+rgYlH4AyEY=
X-Received: by 2002:a05:6602:2f05:b0:66a:381e:1754 with SMTP id
 q5-20020a0566022f0500b0066a381e1754mr14535968iow.144.1655825258649; Tue, 21
 Jun 2022 08:27:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220621152340.2475484-1-aurabindo.pillai@amd.com>
 <20220621152340.2475484-2-aurabindo.pillai@amd.com>
In-Reply-To: <20220621152340.2475484-2-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 21 Jun 2022 11:27:27 -0400
Message-ID: <CADnq5_Ox00B4PQrcBFyp4F69_DxAQvUyLuPqY6fxdzpvfOF0YQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/amd/display: fix incorrect comparison in DML
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
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
Cc: "Siqueira, Rodrigo" <rodrigo.siqueira@amd.com>,
 "for 3.8" <Stable@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Series is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Jun 21, 2022 at 11:23 AM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> [Why&How]
> GCC 12 catches the following incorrect comparison in the if arm
>
> drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dml/dcn32/display_mode_vba_32.c:=
 In function =E2=80=98dml32_ModeSupportAndSystemConfigurationFull=E2=80=99:
> drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dml/dcn32/display_mode_vba_32.c:=
3740:33: error: the comparison will always evaluate as =E2=80=98true=E2=80=
=99 for the address of =E2=80=98USRRetrainingSupport=E2=80=99 will never be=
 NULL [-Werror=3Daddress]
> 3740 | || &mode_lib->vba.USRRetrainingSupport[i][j])) {
> | ^~
> In file included from ./drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dml/disp=
lay_mode_lib.h:32,
> from ./drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dc.h:45,
> from drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dml/dcn32/display_mode_vba_=
32.c:30:
> ./drivers/gpu/drm/amd/amdgpu/../dal-dev/dc/dml/display_mode_vba.h:1175:14=
: note: =E2=80=98USRRetrainingSupport=E2=80=99 declared here
> 1175 | bool USRRetrainingSupport[DC__VOLTAGE_STATES][2];
> |
>
> Fix this by remove preceding & so that value is compared instead of
> address
>
> Fixes: d03037269bf2 ("drm/amd/display: DML changes for DCN32/321")
> Cc: Stable@vger.kernel.org
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32=
.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index c920d71fbd56..510b7a81ee12 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -3725,7 +3725,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(st=
ruct display_mode_lib *mode_l
>                                 && (!mode_lib->vba.FCLKChangeRequirementF=
inal || i =3D=3D v->soc.num_states - 1
>                                 || mode_lib->vba.FCLKChangeSupport[i][j] =
!=3D dm_fclock_change_unsupported)
>                                 && (!mode_lib->vba.USRRetrainingRequiredF=
inal
> -                               || &mode_lib->vba.USRRetrainingSupport[i]=
[j])) {
> +                               || mode_lib->vba.USRRetrainingSupport[i][=
j])) {
>                                 mode_lib->vba.ModeSupport[i][j] =3D true;
>                         } else {
>                                 mode_lib->vba.ModeSupport[i][j] =3D false=
;
> --
> 2.36.1
>
