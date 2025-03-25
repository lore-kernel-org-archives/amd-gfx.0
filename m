Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3369C36008
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Mar 2025 20:42:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A009F10E5FA;
	Tue, 25 Mar 2025 20:42:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AwliWae1";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F9E510E5F7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 20:42:14 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-2ff7255b8c6so1217403a91.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Mar 2025 13:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742935334; x=1743540134; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mztRM5VIgixX6cPtfkQTRsl39CIqHYhgAyYY3jMq9A0=;
 b=AwliWae1oV4qp6Ds2BhdMShGItSq/22XC94hpQBpPLtVj+qyqzUQwT3UV0+37GhTRV
 3GVrrVlILqKu1qN5XBn6nfOneC9NEJ0eHyNchd3hYb4ZMpHLCowGlph3VqRiV4ACn6AJ
 Ex8OMMKXffDcOLuYa263T9fZluPAWx1jxBTTvRElpnZAGg5Sv7qXRzNQZ4cLJsU6sIyH
 h3w5eowaZx2IicZ8HREsa4fGJQXsNV+EVFYE6DNyViapFz22D9XygSMnjj5lRi23ImNG
 oGpLz9hRwcliv6l8caFsgtxIinCAAhjAmDjfCiZZGQEc2sAKPNbn5+jwvgOOP++9usng
 fevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742935334; x=1743540134;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mztRM5VIgixX6cPtfkQTRsl39CIqHYhgAyYY3jMq9A0=;
 b=ejoPDx1u3FKkpzS06TvcGI3dwNnN3KimAce4Q5VgzaeCJzZMCS5ObJpDLnZ3l+SlZm
 fztRd1l9NrbSjxxEgd+d/dPGb/iLXNWyh+xEiCvxM7l8a/oI4/6qxicGu8XGz/DuDsj6
 AwIzI9Rl7tdNnZfAcvDErV7MTJwZ37G/nE/c1I8VmnFtjuWM0hcr/pGYRk4I/szttqPs
 exj/L/IcgPIOg48+l4U+OVWTv4DI5/zOciinBJLlC6MRhfmmQ7LeGn9TZNdouLsqWpGR
 +m79aqEBcSZyEeXgs167UxQpVAcxdmuhrZqK2l5zRPdHg2eUNs421jdVwf+nFjVzTX6S
 p6aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7wYoaIrZZSInpoLrNmlNz7IhWbvpKztATTDy3zoUMoML51+Zv3Jo8ZvK6JDg1vJJBkVtFmqF/@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzbTXacollB++fQC0iC5u7/frbEnaXjnbveJjuI5hHziA+SSAJB
 r4YXIAqttsOyg07k0S3sxifwqWy/1girN2OoBc4i4rsB5g2L/oQ/35WLbhQHUk7WCJReZEOPAma
 M0SyhKlQZraEogLlOKTGg5GKgqt4=
X-Gm-Gg: ASbGncuCDxBX5B1UDcNdGQpJMEdlnPmxrrkJ1J0CZdDqL1JD3OBajveiOk3LjbFBjaX
 I8yv1sA0nefseNXGD0dbvoHHrbjYtN1cqZOZXEPBtbneXAdczMnPcl2SS3Z2GkIsG668x2Ty//Y
 wCLd2CUISU2x/YCBa8wRAXNKq88g==
X-Google-Smtp-Source: AGHT+IG+OVeKtaYWzePR2kFzH01Gwl66uNLCA9Ucso9ya/f3k/K1W/fzaOcEd4zb6HRRKPWNxQmDEMN04X3ZzJxYxr0=
X-Received: by 2002:a17:90b:1e47:b0:2ff:5540:bb48 with SMTP id
 98e67ed59e1d1-3031002dcaamr10758257a91.8.1742935331939; Tue, 25 Mar 2025
 13:42:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250325141415.424864-1-alexander.deucher@amd.com>
 <cqm7y72s6xsmtty7wogzii5mp5uabpyi5hbsw4x7dioiz3r5gh@5tbbz3roxzow>
In-Reply-To: <cqm7y72s6xsmtty7wogzii5mp5uabpyi5hbsw4x7dioiz3r5gh@5tbbz3roxzow>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Mar 2025 16:42:00 -0400
X-Gm-Features: AQ5f1JpqLTMMgF8w7NSzDzDmYW97WiP0L3_-lz2_KKJJWdL3sr1bemLhkdLRzy4
Message-ID: <CADnq5_NV99c_v-6hs8qL3f3cgcRgh+ah4HzUfXT7AJQM=i1KBQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: drop some dead code
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Tue, Mar 25, 2025 at 3:54=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 03/25, Alex Deucher wrote:
> > Drop the cgs smu firmware code for SI, it's not used.
> > The smu firmware fetching for SI is done in si_dpm.c.
> >
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 61 -------------------------
> >  1 file changed, 61 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_cgs.c
> > index 525e53c94f4f5..004a6a9d6b9fa 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
> > @@ -252,67 +252,6 @@ static int amdgpu_cgs_get_firmware_info(struct cgs=
_device *cgs_device,
> >
> >               if (!adev->pm.fw) {
> >                       switch (adev->asic_type) {
> > -                     case CHIP_TAHITI:
> > -                             strscpy(fw_name, "radeon/tahiti_smc.bin")=
;
> > -                             break;
> > -                     case CHIP_PITCAIRN:
> > -                             if ((adev->pdev->revision =3D=3D 0x81) &&
> > -                                 ((adev->pdev->device =3D=3D 0x6810) |=
|
> > -                                 (adev->pdev->device =3D=3D 0x6811))) =
{
> > -                                     info->is_kicker =3D true;
> > -                                     strscpy(fw_name, "radeon/pitcairn=
_k_smc.bin");
> > -                             } else {
> > -                                     strscpy(fw_name, "radeon/pitcairn=
_smc.bin");
> > -                             }
> > -                             break;
> > -                     case CHIP_VERDE:
> > -                             if (((adev->pdev->device =3D=3D 0x6820) &=
&
> > -                                     ((adev->pdev->revision =3D=3D 0x8=
1) ||
> > -                                     (adev->pdev->revision =3D=3D 0x83=
))) ||
> > -                                 ((adev->pdev->device =3D=3D 0x6821) &=
&
> > -                                     ((adev->pdev->revision =3D=3D 0x8=
3) ||
> > -                                     (adev->pdev->revision =3D=3D 0x87=
))) ||
> > -                                 ((adev->pdev->revision =3D=3D 0x87) &=
&
> > -                                     ((adev->pdev->device =3D=3D 0x682=
3) ||
> > -                                     (adev->pdev->device =3D=3D 0x682b=
)))) {
> > -                                     info->is_kicker =3D true;
> > -                                     strscpy(fw_name, "radeon/verde_k_=
smc.bin");
> > -                             } else {
> > -                                     strscpy(fw_name, "radeon/verde_sm=
c.bin");
> > -                             }
> > -                             break;
> > -                     case CHIP_OLAND:
> > -                             if (((adev->pdev->revision =3D=3D 0x81) &=
&
> > -                                     ((adev->pdev->device =3D=3D 0x660=
0) ||
> > -                                     (adev->pdev->device =3D=3D 0x6604=
) ||
> > -                                     (adev->pdev->device =3D=3D 0x6605=
) ||
> > -                                     (adev->pdev->device =3D=3D 0x6610=
))) ||
> > -                                 ((adev->pdev->revision =3D=3D 0x83) &=
&
> > -                                     (adev->pdev->device =3D=3D 0x6610=
))) {
> > -                                     info->is_kicker =3D true;
> > -                                     strscpy(fw_name, "radeon/oland_k_=
smc.bin");
> > -                             } else {
> > -                                     strscpy(fw_name, "radeon/oland_sm=
c.bin");
> > -                             }
> > -                             break;
> > -                     case CHIP_HAINAN:
> > -                             if (((adev->pdev->revision =3D=3D 0x81) &=
&
> > -                                     (adev->pdev->device =3D=3D 0x6660=
)) ||
> > -                                 ((adev->pdev->revision =3D=3D 0x83) &=
&
> > -                                     ((adev->pdev->device =3D=3D 0x666=
0) ||
> > -                                     (adev->pdev->device =3D=3D 0x6663=
) ||
> > -                                     (adev->pdev->device =3D=3D 0x6665=
) ||
> > -                                      (adev->pdev->device =3D=3D 0x666=
7)))) {
> > -                                     info->is_kicker =3D true;
> > -                                     strscpy(fw_name, "radeon/hainan_k=
_smc.bin");
> > -                             } else if ((adev->pdev->revision =3D=3D 0=
xc3) &&
> > -                                      (adev->pdev->device =3D=3D 0x666=
5)) {
> > -                                     info->is_kicker =3D true;
> > -                                     strscpy(fw_name, "radeon/banks_k_=
2_smc.bin");
> > -                             } else {
> > -                                     strscpy(fw_name, "radeon/hainan_s=
mc.bin");
> > -                             }
> > -                             break;
> >                       case CHIP_BONAIRE:
>
> Is there any specific reason why the other ASICs in this switch
> (Bonaire, Hawaii, etc) are not using a similar mechanism like si_dpm.c?

Not really.  Someone could move the firmware set up into the relevant
SMU code for those chips.

Alex

>
> Anyway,
>
> Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
>
> Thanks
>
> >                               if ((adev->pdev->revision =3D=3D 0x80) ||
> >                                       (adev->pdev->revision =3D=3D 0x81=
) ||
> > --
> > 2.49.0
> >
>
> --
> Rodrigo Siqueira
