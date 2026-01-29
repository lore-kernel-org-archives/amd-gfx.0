Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9364D358D6
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 16:53:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49CAE10E112;
	Thu, 29 Jan 2026 16:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OAAiM+Ty";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFED610E112
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 16:53:28 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-124a5810e41so34992c88.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 08:53:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769705608; cv=none;
 d=google.com; s=arc-20240605;
 b=X9uPpWjNzYB1maIPhw9sLGv14f8hI2OKr3pCnns3QqpWhlVmkH97ZdFIzLgnr+ptFq
 9JvJzArzgUiFxSTraJHAPWKBIpVlvHupupTuMvV1JufKF9eh6EDKrsBEf+yP9ZScICGc
 ZjepU2yn8pVNPFCdUY7vGxJLgYLMBsHJpS6NozAFhRnnH5uCXg1RYk+4tiLlDyT4aSDA
 aPNPIzDEc7UaY/47KxTGrpJaBi96zjztZAUlStzqQqUBGjvgmTlWPTVakL5/J9ssuniN
 NIvyJ86KSG1mcNEY3vEVz+zILZfuqGEwRZnwG+TANX8JUhLenld7g7kJNMlm999CZaEy
 ++Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=uSbWu7dXJw7kybPSTwrSNTpox7PxAoJXCpLqSGy60/U=;
 fh=TWw7CjKH/oUmBDR6co52ihjCaPrF1ed6XoUc5ohkm2I=;
 b=i6ZRQnn0GoipWj5ELavk7ZqUwDAegoXE1oWEaNHeY0LomZC97BbvyMA8cd8JFkuyuK
 8B0RZgqxYaI2Et+ZVXQL0QCZDavoURQMLLC1vjR8K475UzPfERaMqlN2SMK3ZSX5UiSz
 f9yqYLFcqrgRYAVWmRgucDEPpk2Wc9pyYjmfgtt8e8P57EcNEoSV3F54Yse2Gyi6RgeL
 prmSwbTGQJ4kXgLMrtktculqdgtVuJJLKOL4AYA9pounNbkGZRB7SkdXHufCIHeaGcKa
 DO0Hhj3nzZFcPSpOAttQHb4NFsQPdVNQz4pSRihc4CCco3f8gVRS2hdKA/4BFK2H4NSb
 JtLA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769705608; x=1770310408; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uSbWu7dXJw7kybPSTwrSNTpox7PxAoJXCpLqSGy60/U=;
 b=OAAiM+TyFrzrDDFLYILw9xDRsxGGb7KaiJxOcnPLCjkRkZLrmaw7ly+K9QPMI8SNXm
 sOVYLksWWinjqVN4gzyoMKelG0fPknOrm4WE9ndU0pV9FJ2RTipPvdKuN88xs7HWbuyK
 zU98zyZEhMhLkoprIindON6kHAVmEktuYTRIOhRRMREAUBr+2YPsjWWssRM1rDan+YP9
 aUig8vgkJLeuwRU6nfwGMGP6EG9qfOr0AeygcBMsB8ccy/MWbsAD0TSO22vD3RLPqlWP
 F30spRwlWTBgvHEZ1iL5B9pWH+CxYHHg2UHZkpKeVCjyWH9dHW+cqPibRwLQvFPzmY0x
 KAsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769705608; x=1770310408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uSbWu7dXJw7kybPSTwrSNTpox7PxAoJXCpLqSGy60/U=;
 b=Q9BDd2AFqdahpaDRu+RZcROxyseIsx/yCmFwytq+FbclYxXChQJbuZMSs5tMxsVJ12
 asste8ja0DrLpds2ITjDjOXZtSa5uRRCdH8nn9oHGbfGZKfxfLp0YgTgMCoxwjlwJIrt
 jHYZkjWGB43knM4vJH0rMvC3ns5EM+zJqWExGudjwlUBzP+s7/5uV4dtjEpfloNImrUc
 Uci1ui/g1SMNe2vedrGF2CF7Fi7P0rkq3pHCQ/eXYUPmT5TNoyeKaNAYGyIKxYeFWWz4
 NnY+tgeJDKd+D00v1EptDCYc8YK9AouC1CQIL3CmpQXxklO6sNSsUGH5GKhJJh/EF1T+
 gDKA==
X-Gm-Message-State: AOJu0YzlVw8OOfW91bAcHkQnrDL1dhAlC+N4eF3HLOSov2sa2c/Om6ue
 DHT+LMhUVKN9LjaANUcYuWfgGvqBMzbNzqlh5xypa9VfU9KbrD6bWuNl4zPfnuwQ9BC1kq7My4Q
 ULrC5Ozp+tWjRroWN1OWctaB9B3/SNj8=
X-Gm-Gg: AZuq6aL0j3xizZpfv9jQPffR5/ksAYcR0mS8TypK1uejxgS+OVZ8MDWEl8Rfu1XkAlz
 aTdj9YiQ5vlpi/vfRpJ6jE6njI39k+OIjTpF2u7ROXc8R4pBOlzQCPDyZ7bzOyJ7ENfXQlpeivk
 vBp7hHBZor/NlZxuzQe2iUlp57fUniw0f1dxr+SG0Eq7js/uH0/KQMkIpc974bhcNYuqDIQg3LG
 Kdy46pXo/XSkqVnn6b0A9XQ9H/O4XOStvhja+b8QBv3BMA+yONcTeyywXVi93J898FaEMEA
X-Received: by 2002:a05:7022:610:b0:119:e56b:46b6 with SMTP id
 a92af1059eb24-125c0f1359emr48585c88.0.1769705607814; Thu, 29 Jan 2026
 08:53:27 -0800 (PST)
MIME-Version: 1.0
References: <20260129043936.33607-1-alexander.deucher@amd.com>
 <2769950.lGaqSPkdTl@timur-hyperion>
In-Reply-To: <2769950.lGaqSPkdTl@timur-hyperion>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jan 2026 11:53:16 -0500
X-Gm-Features: AZwV_Qjty0VYiKLxEVu-I3Y4aIEUOPURrDg3XifMlesqGTBXeQY4-pecJRkhwXk
Message-ID: <CADnq5_NL_GZKtL_z=hR7CpqnjDGqi8qHP5a-MUXSBuWV4L8L1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu/gfx11: adjust KGQ reset sequence
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
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

On Thu, Jan 29, 2026 at 4:52=E2=80=AFAM Timur Krist=C3=B3f <timur.kristof@g=
mail.com> wrote:
>
> On Thursday, January 29, 2026 5:39:35=E2=80=AFAM Central European Standar=
d Time Alex
> Deucher wrote:
> > Kernel gfx queues do not need to be reinitialized or
> > remapped after a reset.  This fixes queue reset failures
> > on APUs.
> >
> > Fixes: b3e9bfd86658 ("drm/amdgpu/gfx11: add ring reset callbacks")
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4789
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> The series is:
> Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> (including with Jesse's suggestion if you choose to implement that).
>
> I notice that gfx_v10_0_reset_kgq() also calls gfx_v10_0_kgq_init_queue()=
,
> should that call be removed as well or made conditional?

In my testing, gfx10 seems to require it, but I plan to look into it
deeper when I get a chance.

Alex

>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 12 ------------
> >  1 file changed, 12 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c index b5a2d09fc3469..489edf517=
f91c
> > 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > @@ -6854,18 +6854,6 @@ static int gfx_v11_0_reset_kgq(struct amdgpu_rin=
g
> > *ring, return r;
> >       }
> >
> > -     r =3D gfx_v11_0_kgq_init_queue(ring, true);
> > -     if (r) {
> > -             dev_err(adev->dev, "failed to init kgq\n");
> > -             return r;
> > -     }
> > -
> > -     r =3D amdgpu_mes_map_legacy_queue(adev, ring, 0);
> > -     if (r) {
> > -             dev_err(adev->dev, "failed to remap kgq\n");
> > -             return r;
> > -     }
> > -
> >       return amdgpu_ring_reset_helper_end(ring, timedout_fence);
> >  }
>
>
>
>
