Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78652C021B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2025 14:32:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E5A710E820;
	Wed, 19 Feb 2025 14:32:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cr+kS2tC";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30F1B10E493
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 14:32:26 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fc317ea4b3so1099559a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2025 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739975545; x=1740580345; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fRHFtDCP37LH+n6nWKAbDq8mgdnBrOyAGYqEJuuyfZU=;
 b=cr+kS2tC5Uaj8H7Jkei8j9RtgGZH04zENizjJVGzds55IxFNTthBZsfmA6hIt4DIKw
 8zPsFbDxyMkqFquSCoQbbdeJ2wHs+ny70vL68aqGRsPSrLMsplozEK2tqKVc0/fYktw1
 C8E41tKtj/+yypUd1ftxna7o/YkDkEGSSn3x6LfrupCa9V97O+6zsGGJzfP8G2xxResd
 3CSxvfz3qgdy0tQliLacvS9F8OWzH70o2Eo66b+17/A1P/Tq64nDICOdeNMbg/IyZGxb
 K5K6mxJwkkfKS/MLfe0njf47ySZH0z1IyEchGl8QB1vaO/VehHZOcg+WTc3xY3PWBq/S
 pxDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739975545; x=1740580345;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fRHFtDCP37LH+n6nWKAbDq8mgdnBrOyAGYqEJuuyfZU=;
 b=DgiOXC2m8Z1cXQUCjMmms6teqINAGAXYxpR44XK2e1nNJ1s4i7OqKx0CfwgVAD8Wmq
 dGV9RGoBHdhYqLRY8rHlJucJME6xQlw/5+KroEbwWIZC9GL4+EgSl0TJ25eIqC3LLjKL
 qiqxvJRtVGeNIVi+vRIJDnM2B6tppfwTr+pW/u46i1ygsZe2VSpS1IVYR6Yd+m3jNm9J
 rwemFK5OYHCiu0C7XTJEgfJvG/Icay0prcweih26oiKASkh7umamS7LkDu4VM6lY5GKZ
 1qFSG/VVZwLPybqTDBHHBV02+gT+uyrXDVSb2RPOjrzyZimgXZsq3iqXvYjUb82lL6te
 QBEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUW6sUxDwg4mIh4cPMuBmhXTeP2O4PJkLW+uunApM0HD4DroDawTpi8peIcRqxuuJjH2/DcLmBO@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhY8MQSHDicd6dXctJEgx86++2AjKLKtn2EkZe9WF93ICbkXTy
 KZU2WQ64zzY2YjHsvLlSo+i8GbcrfBCJ8vmVVCeu97JXhiaAF5dWLm5/sCmtYfgGyGcvEjjGlEJ
 Qm0zqeliBF08VrSKninmjuHA2flc=
X-Gm-Gg: ASbGnct1GxHrWbXsDCRoXVjN0zUUtFV+WvuooG+GWln+wV9PQb5IJS5PxehGgxrp16y
 WV+tcxeyQEOPDSuw73wj67W7q65Jg/5adUB0VMpngqbuROS+hKRXam6TXMNn2EKXZbggiAwzZ
X-Google-Smtp-Source: AGHT+IHEHIu1RxvMXg3u77F1XBxEXuAZOBGjPVMlSMHQclhdjoEGhvSZS6YOlzDOhdUy7IqN6/mi6hyEdyjAeniqQ9E=
X-Received: by 2002:a17:90b:33c6:b0:2f4:465d:5c91 with SMTP id
 98e67ed59e1d1-2fc41174806mr10886881a91.8.1739975545389; Wed, 19 Feb 2025
 06:32:25 -0800 (PST)
MIME-Version: 1.0
References: <20250218150829.2710795-1-alexander.deucher@amd.com>
 <c3626b4c-ce7e-494d-8c56-6d55869524b2@amd.com>
In-Reply-To: <c3626b4c-ce7e-494d-8c56-6d55869524b2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Feb 2025 09:32:13 -0500
X-Gm-Features: AWEUYZlW0fpsGdXCUuFt5WKUIaaLS5-i50fv5EwSEmBjtdG-PucVhZFTYiYytC4
Message-ID: <CADnq5_MZAuwCOBSfmLL5tddM0U-CmVN7Ca+nRSdKzAaZkC=dWA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable BAR resize on Dell G5 SE
To: "Lazar, Lijo" <lijo.lazar@amd.com>
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

On Tue, Feb 18, 2025 at 11:05=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 2/18/2025 8:38 PM, Alex Deucher wrote:
> > There was a quirk added to add a workaround for a Sapphire
> > RX 5600 XT Pulse that didn't allow BAR resizing.  However,
> > the quirk casused a regression on Dell laptops using those
> > chips, rather than narrowing the scope of the resizing
> > quirk, add a quirk to prevent amdgpu from resizing the BAR
> > on those Dell platforms.
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/1707
> > Fixes: 907830b0fc9e ("PCI: Add a REBAR size quirk for Sapphire RX 5600 =
XT Pulse")
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>
> As per the issue thread, issue happens when dGPU resumes from runpm. If
> so, can't we disable runpm as the workaround (IMO, the current patch
> also is a workaround)?

This seems like a better workaround than disabling runtime pm.
Leaving the dGPU powered up all the time seems worse than limiting the
BAR size on this platform.

Alex

>
> Thanks,
> Lijo
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 512e642477a7e..56fd874a22de8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -1662,6 +1662,12 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_de=
vice *adev)
> >       if (amdgpu_sriov_vf(adev))
> >               return 0;
> >
> > +     /* skip resizing on Dell G5 SE platforms */
> > +     if (adev->pdev->vendor =3D=3D PCI_VENDOR_ID_ATI &&
> > +         adev->pdev->device =3D=3D 0x731f &&
> > +         adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_DELL)
> > +             return 0;
> > +
> >       /* PCI_EXT_CAP_ID_VNDR extended capability is located at 0x100 */
> >       if (!pci_find_ext_capability(adev->pdev, PCI_EXT_CAP_ID_VNDR))
> >               DRM_WARN("System can't access extended configuration spac=
e, please check!!\n");
>
