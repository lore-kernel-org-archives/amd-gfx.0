Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B60CCF9E3
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Nov 2025 13:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9204E10E5D5;
	Tue,  4 Nov 2025 13:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nFiZKLiB";
	dkim-atps=neutral
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA12A10E5D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Nov 2025 13:46:40 +0000 (UTC)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b87171370b5so792782a12.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Nov 2025 05:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762264000; x=1762868800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLqrL0F2Pcm1t2weKty3SGlb89u9hQlrJWeOi8wAgok=;
 b=nFiZKLiB3F+uEluK/bm7glJXODugR7rGe9/NlDcbt3VzWc0ya7Y7jHTl9UXBNcHSfJ
 Pyq6d34S1VdGdVgsvbszOZ4+Tdbdaq43a8ocvQN4IDHszdwmeCa2iv8TZ5/2mTLXlxkP
 wtkGoqTXDIg34WieR/VUTGM7/QAKlAuOGnaHz0Ad6K8KDjelTgl+g8Bor6RLqC3vzTRl
 nhOhvghySkROw7+4eiqUKA7ZPcVkri8wnSHQc+6Ik+NIvgDmPTnl+GjmdPZggK++Xm7V
 knFXDmHPqVOckDVqKGbmeRSCQdkJIt9vwcpuRRMifIvGLSh2a1mP1c5t5nYvwI0hJ6GD
 SryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762264000; x=1762868800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zLqrL0F2Pcm1t2weKty3SGlb89u9hQlrJWeOi8wAgok=;
 b=t14AD25q/FHxgChf5LWlLXjpMf8IaG/HXXFnO+OVyRBBowqgwZtKVxNw5slwinuzf7
 A3iGBVxa8gxSkM2XfuP5XedF94zWRO9MaHy/xHgDwpT6o1AlFr26naRXzLmiWnqA0ETb
 /upmxADcB1bm3r77hA1OsnMK72HlZo5Szxhwi14atGG+JADAOFCKuPNj07fcFYfxtpjQ
 ZPgTxYkjus/DU1teIcPH2NkWoJSCXo8wfbjCGDQiYzJp+rV5S59qEhLNsfNAibLFaCjd
 8/0Nc5HIaikh8ZifM7FiMOMSA7v7D644GAwu78vgrIYWU07lPtiwlDWy8SuT9TfC6wcD
 ca0w==
X-Gm-Message-State: AOJu0YxXVTgepLlB0WCKKHBJTb5OqYMxXSPHDldXsSgKzMOaTOskgYKG
 QGNpksBiZJWO+Cw7hFdoQ2znHZA61ijGqmNbXNI0l4I+yeXbdxSLjg4Utl7puRXUZ254vVkDNCq
 DwZLxLrpPRJQxNGsrtGXhVaZiGwVrh3c=
X-Gm-Gg: ASbGnculs9Tq7JSBsx887k0T17Lagh4QLSg8yBpZVnh/USXQcgw8ZwURelUHFee5MnB
 WKzHecGyID8yEAjYme1aqit8Ziw9GTRjXJsOjyflsAfyTQvgMXujLTkMX0qsZH1CDTOlvmuvv0G
 wEUWvK1cbTV3OWu0p3lMHzV/D7P3MnL6ckEyQHAUVAwsSoqe0N4YkSkKgSCcIzEZ/rhKMF0/i5s
 JDr4yPqlkR7GeiuR8PcFjKfIKcD4VTXiQhlc8KQ22Z3BUbUMQGz1bNG3dlH
X-Google-Smtp-Source: AGHT+IGYuTmqITLUZgffYkepyExuwYWY/Uxh2pUhzTo8qnZoCWd/MBMN7nRPtroHm7x0ve51nC87oBRkKdvpJqYWvjY=
X-Received: by 2002:a05:6a21:398e:b0:342:968e:87a7 with SMTP id
 adf61e73a8af0-348c9f6a688mr11895009637.1.1762264000332; Tue, 04 Nov 2025
 05:46:40 -0800 (PST)
MIME-Version: 1.0
References: <20251104121333.3655721-1-YiPeng.Chai@amd.com>
In-Reply-To: <20251104121333.3655721-1-YiPeng.Chai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 4 Nov 2025 08:46:28 -0500
X-Gm-Features: AWmQ_bkER5PUnJAZrDWBQl9_PjrSJh81rCn7-1OlYZHpkANmhSCDLZBGEGB8Y50
Message-ID: <CADnq5_Oy=o6id7NHu4aQFjrgHqm17FJw3OMbCP50-gyth7M31A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/ras: ras supports i2c eeprom for mp1 v13_0_12
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, 
 Candice.Li@amd.com, Stanley.Yang@amd.com, Jinzhou.Su@amd.com
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

On Tue, Nov 4, 2025 at 7:51=E2=80=AFAM YiPeng Chai <YiPeng.Chai@amd.com> wr=
ote:
>
> ras supports i2c eeprom for mp1 v13_0_12.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c b/dr=
ivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> index 1bb7b7001ec7..3ed3ff42b7e1 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_eeprom_i2c.c
> @@ -85,6 +85,7 @@ static int ras_eeprom_i2c_config(struct ras_core_contex=
t *ras_core)
>         case IP_VERSION(13, 0, 5):
>         case IP_VERSION(13, 0, 6):
>         case IP_VERSION(13, 0, 10):
> +       case IP_VERSION(13, 0, 12):
>         case IP_VERSION(13, 0, 14):
>                 control->i2c_address =3D EEPROM_I2C_MADDR_4;
>                 return 0;
> --
> 2.34.1
>
