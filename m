Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0173F10A62D2
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 13:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2771310E9E4;
	Thu, 26 Mar 2026 13:49:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ppx1QO75";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E86710E9E4
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 13:49:40 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-12736a0147cso75250c88.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 06:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774532979; cv=none;
 d=google.com; s=arc-20240605;
 b=aCOpEKJbcBQ8RIjugYF53DjhHST6zU90LE94R+Y7t2AozKkJzb3yrGN5N6BiEGT+bF
 Lz69dZORaIDJg4kxhAjpx4aT7Cz14DdE0KJN5tHx7hjP/rmvn4vTxYtChCZLMcSMY8Xn
 IoUIMStgoxnMUFkQW11562i+WkZMPej8yUJY2Jt2+NTNWyfZU0pm2tBuqaQ4ETXo7j8R
 laeUb2Mspm8yn6MZodKgynLargL4DKBU0h0B0vVgBuDCQ3NCJO5kU4p/DTAmhP9I+Cnf
 1uw1N33lovcjdFnSx/1LYAC1m/VjHcE+UGpW208FRNaNXrkxGJBJAa6uT8l7KzeFGCmx
 gvmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wfUh7bPyGedeXVq0QvRByx2scv8qgWT1+iSxFB0rUCs=;
 fh=6ZWVLn+f7zVmz+cspPJzDKlDZeQqG6pNHboL9aEq+tM=;
 b=bcCQ1sD1QElA7oyjqtqh4f2qiZv3dBVdNlSew9QpieJhtftKapBrAc23v/7T2M2mHW
 8fTvQwOOd/IwheuH2cbd3JaASnemJ+7ENTD6rJ0GFjn9J6gV1cVu+74vYq2e1WFN/NpZ
 VsTOtu11U8/dOG9Bp2Dz97yZ7g5kJQPliq8H+Z4vu5NVNwUEwC7dvaiNElbVASAQA8NE
 uk2A6UKdRdeoYoJh3HqGO9YTBSp/uSv1a5gxI18+Sc/55XtVBCzLtIJtzc72f0z9V9XQ
 ICWRojb69/XF9IQtM26UT700UMvmnikoR7u4aM5ROy0S2DIZFlbWlSYLYnHucROlHXh+
 ztvw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774532979; x=1775137779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wfUh7bPyGedeXVq0QvRByx2scv8qgWT1+iSxFB0rUCs=;
 b=ppx1QO75+op0LltnXGxozKLZn/4gCLf0TbdqdXWOdQeMxXqsjZhQ/PhCUM9zDCje80
 3k8BtPyYoDY3YBWE4VezOx6bNAcwdt46C1BMiWuokywaKyShmeqWusniQNIoHv14lGOF
 MY0o8PB8lOGriTUcIcA4/qJGtde9vY1telpX/yVSEGf7P+Ucq4v3GPmbCw15G1BTe5w2
 vGK/yxi6PIf98v1Ovq3uwoBZFBKlNiirNkoI9auT3mkjzruM4gOVp/8RM32LBxiyZuUQ
 mcSIwA1BEvxzbRV9tpTZ5UP14nqNZasZlA6TXoApPVYuRTnZM8IdySA7e2G9MYGCPJtl
 oniw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774532979; x=1775137779;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wfUh7bPyGedeXVq0QvRByx2scv8qgWT1+iSxFB0rUCs=;
 b=sd/etpiVMR75x7HTHr0fAmVyyndYWmpirEZlieB8VdElf643sYbtJw1rjOa3YO9aKN
 anHKqIPgYIiWvV1OZVTHUVl5dNi3lsPZ0EM08QXEASzvC7pQKxFOLkaGW/LPzAisd68X
 y3ndsfn7ZcHo5ZhCIhp4y8bgUpkEY5tVlR6SjTv5f2sPVTMLV1sAcb09z3eWjSOwBzx7
 QIMhOV+b2OGu2kxb3rNk2Ak5VpOk4MtGqIZw5c/ZsZ/YRNI0cptdtfhudn+So3AlZkjW
 t0e9/OzGsTrXSvHEFPS8M9VzZKK3O40wPTuHw5DlOzW7oc+92DxDq5Hj3mz75wSfTZZJ
 keWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeS7LDVv27TEg/qheNSF3LW5lO9otzHV46WXPwT9Z6zSBVd/MF7vId2PQLJxQ9lSXk+z1p/VQI@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxgqsFtcREHSMXaAUBq0dn0e1fgkpTNrHpshC70XRj1T8kj+aNo
 yBEgajtRFYQhubPi3o/sbf+xUjBnUwbeHLFM6NN5h/olQWos+0fRfwKw7seCF0xUq0hNCW1p/vg
 2N1OINDrtplplJdDnsZzYNQRFzIWS0Vw=
X-Gm-Gg: ATEYQzwbV0rYVrQXGyRzux3QUQjbIO+UA2JLz6xby6Pf8erOqcu+nR9CgufeqOCGDt2
 lHCemFVsQbMeb2O38obx2tK2K1KK0MGHlkmkhGxc2ziFYveQarPzERw4Ci401pOUQqI++ZEZjcW
 lsplFhaI0jVnbLIA0/9Lcgwa7ZSe01axTrfy5ox1Hn9Sd+eD9iw2gSE37SEYIwqGdq9t1o0DnFm
 xXmFxWoqmtK//MqYZzzkVpYinslmXCj1iTXfBbb7zjaPQwmxrHXzxIQDQMMBtFj2TlcWDjsbjQ5
 8QFczu782q23I3/pZZ/0qXDg1tArxLM/1tsWNndNLliTkTwA8V7cViTDdibYnjlXdKHL9A==
X-Received: by 2002:a05:7022:45a3:b0:127:332d:63e with SMTP id
 a92af1059eb24-12a96f05899mr2013237c88.5.1774532979363; Thu, 26 Mar 2026
 06:49:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260324085130.74534-1-pengpeng@iscas.ac.cn>
In-Reply-To: <20260324085130.74534-1-pengpeng@iscas.ac.cn>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 26 Mar 2026 09:49:28 -0400
X-Gm-Features: AQROBzBVF-fM23YwoE70eri3RB6hBb-a7AhCMxCBVEJA36gooeuIRUMHibK5jKM
Message-ID: <CADnq5_OnYwP6Y9VMy-_587n+HXKgttVfy2nLVcDfwLuPj=JynQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: bios_parser: fix GPIO I2C line off-by-one
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

Applied.  Thanks!

On Thu, Mar 26, 2026 at 9:18=E2=80=AFAM Pengpeng Hou <pengpeng@iscas.ac.cn>=
 wrote:
>
> get_gpio_i2c_info() computes the number of GPIO I2C assignment records
> present in the BIOS table and then uses bfI2C_LineMux as an array index
> into header->asGPIO_Info[]. The current check only rejects values
> strictly larger than the record count, so an index equal to count still
> falls through and reaches the fixed table one element past the end.
>
> Reject indices at or above the number of available records before using
> them as an array index.
>
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/bios_parser.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/=
gpu/drm/amd/display/dc/bios/bios_parser.c
> index 8b3084cc59fd..85c8f5479a52 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
> @@ -1952,7 +1952,7 @@ static enum bp_result get_gpio_i2c_info(struct bios=
_parser *bp,
>         count =3D (le16_to_cpu(header->sHeader.usStructureSize)
>                         - sizeof(ATOM_COMMON_TABLE_HEADER))
>                                 / sizeof(ATOM_GPIO_I2C_ASSIGMENT);
> -       if (count < record->sucI2cId.bfI2C_LineMux)
> +       if (count <=3D record->sucI2cId.bfI2C_LineMux)
>                 return BP_RESULT_BADBIOSTABLE;
>
>         /* get the GPIO_I2C_INFO */
> --
> 2.50.1 (Apple Git-155)
>
