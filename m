Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB589FF8875
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 13:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A14510F311;
	Thu, 30 Apr 2026 13:19:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dXPu7ybe";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A33B10F311
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 13:19:36 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so631266f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 06:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777555175; x=1778159975; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BUoDsbeViWLr9vwFmykPyx3UayEstzJxyBLbpoeAz2E=;
 b=dXPu7ybeXNQEWXIS9NuZFhgnCR8Bz4vyKRdinlOI1JOfFzasTOVh7HKimBkSiTMkm4
 Iu2zzxGw1u6JpyCRw8KaLqwmvA7t0fuia5qjHMfrfoiHCOntEdbzyDQ5A3mAVZQN7gNZ
 sjJzeG+bhvY9BoGSYj30laP1yyYVp3wkyZjElVBVLWAK9nxNBgUXOu5CiqdjYSUXTCHd
 n1nVp3xivMcj9eOgaX2J33EHyMBP0VUkZZyPQFgKkhyxfXImWmeOaZn3s0YY62fFg6x7
 f2g5+wPFDpcfvpzi4gdyQpPmwvdXAmPfExQGKnNAM7bWYhvCXmISWojGF+LpU/wCw9jB
 To5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777555175; x=1778159975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BUoDsbeViWLr9vwFmykPyx3UayEstzJxyBLbpoeAz2E=;
 b=cO+C6QogPIT6GJLz1VDqo/3onqUo3fFqbPvT81KON1g7tW/C/bVE3Kf89ka670wfFA
 gBB+JbAIuyywlETMBmoa80FtR04ZC50AH72bO5b5Wcl0qdcVCgHI8wabl4o7h1vZNnvW
 osIOXppVFmW5/lETiCNx48huao0vk5DaLd+RI5ycoSi2eLBAy1yk8EHZKlkhT7AYg2mN
 NjC3wjGVUqkstsNTj5QOfXACzuvPmkBpusbhDGJQVFiAj3Hj1KjMBz6qGA9/OVXW622p
 u4joxnOqMI/JOnzCIzaYlnXle8bKuJZ0Y6KPgwWGqiPO9yBQuzXy7Y4QiPvfQpnjyF5z
 npbQ==
X-Gm-Message-State: AOJu0YxYG9MeluRbDPl1oPginWCC4Zalpv8wZ0RZuG813Sn6hz8gzJcm
 RS0gysMV18E5+QEumTUt1INniCNHFvFlhsYUpUrR27o6I3dxAlZ8sfC7/7+ms9kU
X-Gm-Gg: AeBDiev2JFmhcUg066gRXtJ5MJprQDrwMyvUbzRSJlSUTeTEOPICsJmMOc+/vxkmzWU
 9UzNTGzmSiIC7qqqXMTaFgUCKkdwrW/3RTECHtUoNHCUFihMLOUmHx2iXrsh3XKDRAfWDa+6Vxn
 6kggJtHW9mAFzVohf0vSpW5D3qGMAqULD6VkXVsyyhazGEusRFeg3yNiQRThnLojZQYi8X+0gxf
 Vq+80hG9FuF78zmpYpl+N/GgZBxO5fxLAle82LzZKjmnom2XFQs/C790hzGO7CS/9+Z5r+gsEAC
 B5eVI0AzJbQRE8gJ62hmEBEC1C0BlQtk4aN7bUGRqUp93EiZdOoFy30d3Tc6/71EH20CPWzFyVt
 ugqfftE5th6vIsZH3+ko7P7MdgR0iAVL0TIZ1ct0fcgJO6OLfRIGQwGQUJYfKJqII6CEJpjB5SA
 xydiRP8/cdxAy5BJfDC1XDxFrvwGmIgIPcasECnrw0L3bQqyFmQUjUD0HSFMQ=
X-Received: by 2002:a05:6000:178b:b0:43c:ffee:ee94 with SMTP id
 ffacd0b85a97d-4493d4100damr4861747f8f.11.1777555174852; 
 Thu, 30 Apr 2026 06:19:34 -0700 (PDT)
Received: from timur-max.localnet (netacc-gpn-7-154-214.pool.yettel.hu.
 [176.77.154.214]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b4216675sm13184655f8f.11.2026.04.30.06.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 06:19:34 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Subject: Re: [PATCH 07/14] drm/amd/display: Delete disp_clk_voltage from
 integrated info
Date: Thu, 30 Apr 2026 14:30:57 +0200
Message-ID: <22508251.4csPzL39Zc@timur-max>
In-Reply-To: <2c83c16b-7e5c-4d1d-93f1-23109ee52a59@igalia.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-8-timur.kristof@gmail.com>
 <2c83c16b-7e5c-4d1d-93f1-23109ee52a59@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On 2026. =C3=A1prilis 29., szerda 22:35:16 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Melissa Wen=20
wrote:
> On 23/04/2026 16:15, Timur Krist=C3=B3f wrote:
> > Only DCE 11.0 relies on this information and even that
> > didn't use this field, because it queries the information
> > from the pplib. It also filled the field incorrectly on
> > that version.
> >=20
> > On newer GPUs, the VIOS integrated info no longer contains
> > display clock voltage dependencies, so we don't need it.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   .../gpu/drm/amd/display/dc/bios/bios_parser.c | 36 -------------------
> >   .../drm/amd/display/dc/bios/bios_parser2.c    |  9 -----
> >   .../display/include/grph_object_ctrl_defs.h   |  9 -----
> >   3 files changed, 54 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> > b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c index
> > 25c94962e1415..298a70852c1a8 100644
> > --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> > +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> > @@ -2348,15 +2348,6 @@ static enum bp_result get_integrated_info_v8(
> >=20
> >   	info->dentist_vco_freq =3D le32_to_cpu(info_v8->ulDentistVCOFreq) *=
=20
10;
> >   	info->boot_up_uma_clock =3D le32_to_cpu(info_v8->ulBootUpUMAClock)=20
* 10;
> >=20
> > -	for (i =3D 0; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
> > -		/* Convert [10KHz] into [KHz] */
> > -		info->disp_clk_voltage[i].max_supported_clk =3D
> > -			le32_to_cpu(info_v8->sDISPCLK_Voltage[i].
> > -				    ulMaximumSupportedCLK) * 10;
> > -		info->disp_clk_voltage[i].voltage_index =3D
> > -			le32_to_cpu(info_v8-
>sDISPCLK_Voltage[i].ulVoltageIndex);
> > -	}
> > -
> >=20
> >   	info->boot_up_req_display_vector =3D
> >   =09
> >   		le32_to_cpu(info_v8->ulBootUpReqDisplayVector);
> >   =09
> >   	info->gpu_cap_info =3D
> >=20
> > @@ -2499,14 +2490,6 @@ static enum bp_result get_integrated_info_v9(
> >=20
> >   	info->dentist_vco_freq =3D le32_to_cpu(info_v9->ulDentistVCOFreq) *=
=20
10;
> >   	info->boot_up_uma_clock =3D le32_to_cpu(info_v9->ulBootUpUMAClock)=20
* 10;
> >=20
> > -	for (i =3D 0; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
> > -		/* Convert [10KHz] into [KHz] */
> > -		info->disp_clk_voltage[i].max_supported_clk =3D
> > -			le32_to_cpu(info_v9-
>sDISPCLK_Voltage[i].ulMaximumSupportedCLK) * 10;
> > -		info->disp_clk_voltage[i].voltage_index =3D
> > -			le32_to_cpu(info_v9-
>sDISPCLK_Voltage[i].ulVoltageIndex);
> > -	}
> > -
> >=20
> >   	info->boot_up_req_display_vector =3D
> >   =09
> >   		le32_to_cpu(info_v9->ulBootUpReqDisplayVector);
> >   =09
> >   	info->gpu_cap_info =3D le32_to_cpu(info_v9->ulGPUCapInfo);
> >=20
> > @@ -2648,25 +2631,6 @@ static enum bp_result construct_integrated_info(
> >=20
> >   		}
> >   =09
> >   	}
> >=20
> > -	/* Sort voltage table from low to high*/
> > -	if (result =3D=3D BP_RESULT_OK) {
> > -		int32_t i;
> > -		int32_t j;
> > -
> > -		for (i =3D 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
> > -			for (j =3D i; j > 0; --j) {
> > -				if (
> > -						info-
>disp_clk_voltage[j].max_supported_clk <
> > -						info-
>disp_clk_voltage[j-1].max_supported_clk) {
> > -					/* swap j and j - 1*/
> > -					swap(info-
>disp_clk_voltage[j - 1],
> > -					     info-
>disp_clk_voltage[j]);
> > -				}
> > -			}
> > -		}
> > -
> > -	}
> > -
> >=20
> >   	return result;
> >  =20
> >   }
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> > b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c index
> > b4dd8219b8f09..0e7250f1d3f73 100644
> > --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> > +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser2.c
> > @@ -3023,7 +3023,6 @@ static enum bp_result construct_integrated_info(
> >=20
> >   	struct atom_data_revision revision;
> >   =09
> >   	int32_t i;
> >=20
> > -	int32_t j;
> >=20
> >   	if (!info)
> >   =09
> >   		return result;
> >=20
> > @@ -3125,14 +3124,6 @@ static enum bp_result construct_integrated_info(
> >=20
> >   			DC_LOG_BIOS("driver forced fixdpvoltageswing=20
=3D %d\n",
> >   			info-
>ext_disp_conn_info.fixdpvoltageswing);>   	=09
> >   		}
> >   =09
> >   	}
> >=20
> > -	/* Sort voltage table from low to high*/
> > -	for (i =3D 1; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
> > -		for (j =3D i; j > 0; --j) {
> > -			if (info-
>disp_clk_voltage[j].max_supported_clk <
> > -			    info-
>disp_clk_voltage[j-1].max_supported_clk)
> > -				swap(info->disp_clk_voltage[j-1],=20
info->disp_clk_voltage[j]);
> > -		}
> > -	}
>=20
> I see in `get_integrated_info_v11()` a big portion of very old unused
> code guarded by a `#if 0` that uses `NUMBER_OF_DISP_CLK_VOLTAGE` but
> probably doesn't make sense anymore.
> How about removing it too?

As far as I understand, the VBIOS on newer GPUs doesn't have this informati=
on=20
in the integrated info. I don't know what was the intention of that "#if 0".
I can remove it if there are no objections from anyone here.

>=20
> >   	return result;
> >  =20
> >   }
> >=20
> > diff --git a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
> > b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h index
> > 38a77fa9b4afd..130d377f4f1d2 100644
> > --- a/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
> > +++ b/drivers/gpu/drm/amd/display/include/grph_object_ctrl_defs.h
> > @@ -269,7 +269,6 @@ struct transmitter_configuration {
> >=20
> >   #define NUMBER_OF_UCHAR_FOR_GUID 16
> >   #define MAX_NUMBER_OF_EXT_DISPLAY_PATH 7
> >   #define NUMBER_OF_CSR_M3_ARB 10
> >=20
> > -#define NUMBER_OF_DISP_CLK_VOLTAGE 4
> >=20
> >   #define NUMBER_OF_AVAILABLE_SCLK 5
> >  =20
> >   struct i2c_reg_info {
> >=20
> > @@ -298,14 +297,6 @@ struct edp_info {
> >=20
> >   /* V6 */
> >   struct integrated_info {
> >=20
> > -	struct clock_voltage_caps {
> > -		/* The Voltage Index indicated by FUSE, same voltage=20
index
> > -		shared with SCLK DPM fuse table */
> > -		uint32_t voltage_index;
> > -		/* Maximum clock supported with specified voltage index=20
*/
> > -		uint32_t max_supported_clk; /* in KHz */
> > -	} disp_clk_voltage[NUMBER_OF_DISP_CLK_VOLTAGE];
> > -
> >=20
> >   	struct display_connection_info {
> >   =09
> >   		struct external_display_path {
> >   	=09
> >   			/* A bit vector to show what devices are=20
supported */




