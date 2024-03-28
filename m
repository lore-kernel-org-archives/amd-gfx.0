Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D08D2C54E64
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 03:43:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43DE310F4F1;
	Thu, 28 Mar 2024 03:43:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PJ0NiXa6";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BFDA10F4F1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 03:43:36 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-5e4613f2b56so319721a12.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Mar 2024 20:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711597415; x=1712202215; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bcr7yodKGvzHsakGve85ExM2PiRQ/qiFn/FjWix9hY0=;
 b=PJ0NiXa66gfWamSzdfOVqIUCcqcGJ1eaAVpSSPwDo7kmcS1QVJXs1K2lILDIwwHEku
 gT2tTlBEHzipQcZ+qh2pjEJs0GNhWhSgtsY+OyuSw9/B1WvATo30KM0yy378bIbo+/gp
 77cc6xisP1HYtOuksaa6ZUaTSoOp2VUT5WvCgo5PobX8aWuIJEL6M7vLgTkCTDIz6WzM
 XJXP5g+fGDpZ9h6Jqb2cvTpADNMnQDNl4+Edgq9PSN6jF/mb1EKmjjMtwZmSWcT8I6oz
 6RNTUDvOrPI+oD9QyoR3vLs78K6ZPyZ9IqL4fuCLYSGBKzcPe4pmfWSIa7wMwQmKOkWI
 nPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711597415; x=1712202215;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcr7yodKGvzHsakGve85ExM2PiRQ/qiFn/FjWix9hY0=;
 b=hSXpTkfgfoE9WOKum+ccaxZZ+iQGPkP8hjQ5ivN0lWDOcsQJnbt9eAeWQp13OujXvZ
 z/pj8Wq+jHbWCofkC4y5sIzYZ0NJ0Ydwkc+1hA6w6vMjvfSML7XnMDkv43KOePm2spov
 pVgefXV4Kh5PhCcc50041BOfENSOmM5F1tWdWwIWejgjcHU1J+8zftSWPbWAzPdaNHYC
 o1KqDjYuNFEoZJ8JK5w69WznBqO96yLKLxiUpeHhmyP83YGn6ber7K4yk1ajaa9BP7BG
 RY0P2CyLegh6CoAZKTtrHhApJ9MdK4B5D2LGkopwijqeq0yefDGdjU8ukndCuJLz7tDB
 HQ2w==
X-Gm-Message-State: AOJu0Yz08K7q4D+lY5knydhIaiLs8MIS9+lMtXH7EHHoUZMIzgTT4i2o
 cKscKcyYJPGin+E2gEpVZz6YoclQUAafSrYI3lFsj+lSQ7/XtXuXMEvCz1L4Qqq0w7arANbLR+m
 gINjeChKvXTJA3DvoUOm1Bw7GQTU=
X-Google-Smtp-Source: AGHT+IHu4g96WjjtoP1ozoVbfEx5sSaCbcPatsfZCjOWr7g1Fp0Ffaydz2Tcl7B47RIsShUHCz5BkpXJMcf7pKIQew0=
X-Received: by 2002:a17:90b:46d2:b0:2a0:2b14:6d8d with SMTP id
 jx18-20020a17090b46d200b002a02b146d8dmr1562863pjb.1.1711597415507; Wed, 27
 Mar 2024 20:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240328032234.3466383-1-li.ma@amd.com>
In-Reply-To: <20240328032234.3466383-1-li.ma@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 27 Mar 2024 23:43:23 -0400
Message-ID: <CADnq5_OLPgadUZCSVOLFM+V8sdQnK6-pSwsaMnuWJzuZgTmjRw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: add DCN 351 version for microcode load
To: Li Ma <li.ma@amd.com>
Cc: amd-gfx@lists.freedesktop.org, hamza.mahfooz@amd.com, roman.li@amd.com, 
 alexander.deucher@amd.com, yifan1.zhang@amd.com
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

On Wed, Mar 27, 2024 at 11:32=E2=80=AFPM Li Ma <li.ma@amd.com> wrote:
>
> There is a new DCN veriosn 3.5.1 need to load
>
> Signed-off-by: Li Ma <li.ma@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index ef546932f6c9..d98632f37c0d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -148,6 +148,9 @@ MODULE_FIRMWARE(FIRMWARE_NAVI12_DMCU);
>  #define FIRMWARE_DCN_35_DMUB "amdgpu/dcn_3_5_dmcub.bin"
>  MODULE_FIRMWARE(FIRMWARE_DCN_35_DMUB);
>
> +#define FIRMWARE_DCN_351_DMUB "amdgpu/dcn_3_5_1_dmcub.bin"
> +MODULE_FIRMWARE(FIRMWARE_DCN_351_DMUB);
> +
>  /* Number of bytes in PSP header for firmware. */
>  #define PSP_HEADER_BYTES 0x100
>
> @@ -4820,9 +4823,11 @@ static int dm_init_microcode(struct amdgpu_device =
*adev)
>                 fw_name_dmub =3D FIRMWARE_DCN_V3_2_1_DMCUB;
>                 break;
>         case IP_VERSION(3, 5, 0):
> -       case IP_VERSION(3, 5, 1):
>                 fw_name_dmub =3D FIRMWARE_DCN_35_DMUB;
>                 break;
> +       case IP_VERSION(3, 5, 1):
> +               fw_name_dmub =3D FIRMWARE_DCN_351_DMUB;
> +               break;
>         default:
>                 /* ASIC doesn't support DMUB. */
>                 return 0;
> --
> 2.25.1
>
