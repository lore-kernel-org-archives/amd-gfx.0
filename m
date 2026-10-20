Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EBC606A325
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Oct 2026 17:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=sniRTQ02
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 723CD10E56A;
	Tue, 20 Oct 2026 17:31:59 +0000 (UTC)
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com
 [209.85.217.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C813F10F21C
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 17:31:52 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id
 ada2fe7eead31-7cc1848192fso116600137.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Oct 2026 10:31:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792517510; cv=none;
 d=google.com; s=arc-20260327;
 b=M2LYJiQvmRAn2e63lgLK0yjXfzsWZxJ1p/igY81QgpTavthjjqXXJAwNbz1T0agJGa
 qdBjmuCIO2Y3mbyuAciBkD0TRKYxNOqZE6W2Lxyuf5Xw5fluSunkjwD23+P91gojEztX
 gHtBAn7sF3/4P2sp1fqDokjnwVynrxROYLA1Vkeu8yMNvPB07rgcj1BERLCN5PI9/6e5
 Jp3Cxy2Hcu3aBpx/HfkaeWU/BeMAp9WyL34A9Sk5lnNMSxt2uAOC3g9Uj0s5m5r71GDf
 /mWrcGh6bSXw5IY5/Aukjq8CLQnT4sbzzI+UTbp1HoGsq2qeXmJUVkWI+bRDIhr5Yn3E
 sAOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TrpktKH4TQcbMNvdEfyf5Wmj9nMPZl3e4y1McpAm30c=;
 fh=siVP/8MjXKUtOiCy0dRkKsXKM6wYcHUGTxpVXots8KU=;
 b=YMYd4wcwLHCB+UmDh+zEffMjjiP51lH8BeF01uIiQOz81QwWjhDGnX6biBmHVbo+LV
 ALdCAxy3fnBBxIn2LysQl36RHTadTw38KF/JOPMqC7po1YX6NIzDv1A3hCFt+9w7qWqn
 vrW2dpPS5ue5aU1kMtBRIWWU3GQqzIrwFjvP80iSgu7M0+0bwJMeqw5+iYCiPcsNGALE
 9Dg8jAPelYOekJ2lz92vHZ/O6LQU4gwNXXk2u9rmHzUTbNT3YbmeFhYX8vWczZIggivx
 cl0SKfurtDoPOHiEw76onjlAHMD6xUCqrPgDanGonA53bONDvXTeD7RBc+6Ul/OG3DJ2
 3HbA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792517510; x=1793122310; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TrpktKH4TQcbMNvdEfyf5Wmj9nMPZl3e4y1McpAm30c=;
 b=sniRTQ02F5hRDdOSP7kjkfBl0kj8mFvl/0SZTgmCBAB2myMWd0PZluEvgEhYLRxA5m
 u/Wby5jiYZrPTCc7V+kPnLqxjiP5aeJ2YF/0dZrexHb/kA5Iq3MvYqudijwk7k6LLy9j
 pUTnAkIL3iB4o3JjsPHL/W//8+GyyjzplJ/TZ2VLNp+yhQtTj0qb1svabLpP02AbAlZ2
 /TvHazsQjwoQzenqC+fU9YkcEBRW8wVwaAb3/iKlpU7SBMzDGIWSvh4FhvpGiqGBcmTF
 QXOveZ9ugK3A4eESTgJVIoq78yyLwvuHuYs11j6QQIEvI1lyS7MxwctR/ItaKlse1nED
 bnYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792517510; x=1793122310;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TrpktKH4TQcbMNvdEfyf5Wmj9nMPZl3e4y1McpAm30c=;
 b=BApIea3MSnsX4I9JfvS3MaKKhEZH3wThtPuJcLCAYSJ7bAo8tTktL8obx/EqxFusE0
 ZVBWhA9BEhiQeTl0P7zfr+Zl9kREgcQT+XOeqo+f1Dd3uerlp8IGAcJpVCD7KY9zoF5d
 8i4yKairc4FWExcl+jkjg5RLc3icW9nE/Ujyxl+92q4Fwe3LzFRpBJW4zWuS270uUYH7
 kTn1NJA0j2FE1VCPNkv2d9wMZM1LrhZNTNPQRue18R1CCUT29vWChwIEKg3HEsBj8hKE
 7smw9TgywOnqOxWjijuQsWeMYtH0wAflraTR6m1ow4CT7Bt0vt186G2f+EHaH8GZDNW4
 XMAg==
X-Gm-Message-State: AFq9FYLD+Thv5KuvgoPiY+20QE47DUwTUQoTJ96ehAWNBL5MIfNnBQRI
 C+MiQ9qIpp/3JaTVB1vSyBQmSXKuAC45ks4BE+5vdg0MdCQmVRmU4gwXyA62XoeM61RbQWNbXNO
 M33tBLE5FT2Gk8y0Q0YjZdHit+qOegiw=
X-Gm-Gg: AYBFou3eJanfRI0lkvj7t6ua+m897MUAhE0NBjXA5TXrn+REr62H9JnCfN64vmAjr/k
 OdGNIm/FsDy9W6orm4vo9YhJD1FOcFI2VELNBTsLdho/vSETP4KYnlgU4E6cmQEQNjnUGHiZeO6
 OfiVlfVdCzhfhPAZu+CQts4q2bWYwrak4OJKR5CYIHd2bVmra8DTprz08ogxsLUTriaP4qEHrS6
 Hj+MBnt6ifKadUeP43ifFus8wGxDHlDV87kVM3cd3agwvWl+u60m7tWCoUNv9FpBVRhltmyeAkO
 CFhAu4zXCOQq90TvfY5T0X/v8vhUkGSKht/JXKgy6UzBzZLpCTy/90DUpQpRUeDpVfcTOtfG62B
 gY8cGXYb1iEMnUb4Rv9vHTttrdzAGd5GObJGe24wqxw==
X-Received: by 2002:a05:6102:2907:b0:7c8:3b8c:82ae with SMTP id
 ada2fe7eead31-7cc368e81e9mr1830826137.2.1792517510460; Tue, 20 Oct 2026
 10:31:50 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261020160316.2411569-1-harkirat.gill@amd.com>
 <CADnq5_NQst-5DeGcNpEV=s4Lsc7QKyq1Dtx3VMWPYCJig4qJfw@mail.gmail.com>
 <DM4PR12MB5165DEE300531C7225770574E3672@DM4PR12MB5165.namprd12.prod.outlook.com>
In-Reply-To: <DM4PR12MB5165DEE300531C7225770574E3672@DM4PR12MB5165.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 20 Oct 2026 13:31:38 -0400
X-Gm-Features: AclHuK87SPjIlBlldxlf3NK4irpWkpEeQGk4dF6Kx6r-lh4n6XUYTqs_OoNB3D8
Message-ID: <CADnq5_OcTEezW+Ku=Dp0eDGKVbMXr1EDXUw0DLHp2qPSWr9TcQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: re-enable GFXOFF for compute on GFX12
To: "Gill, Harkirat (Harry)" <Harkirat.Gill@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Feng,
 Kenneth" <Kenneth.Feng@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 20, 2026 at 1:22=E2=80=AFPM Gill, Harkirat (Harry)
<Harkirat.Gill@amd.com> wrote:
>
> AMD General
>
> > > Commit 2affe2bbc997 ("drm/amdgpu: disable gfxoff with the compute
> > > workload on gfx12") disabled GFXOFF whenever a user-mode compute queu=
e
> > > exists, as a workaround for an OpenCL test failure. The MES firmware
> > > issue behind that failure has since been addressed, so the workaround
> > > is no longer required.
> >
> > Do you know what firmware version this was fixed in?  It would be bette=
r to add
> > the firmware version check like was done for gfx11.
> >
> > Alex
> >
>
> Don't have the specific fw version this was fixed in. Kenneth mentioned i=
t was resolved in a very early version during bringup so the MES version ch=
eck wasn't necessary.

OK.  if it was fixed prior to the firmware being upstreamed, then we
should be ok.

Alex

>
> Harry
>
> > >
> > > Without this change, idle inference servers that hold a context for
> > > hours never let the graphics block power down, costing roughly 3-4%
> > > reported GPU activity and ~3 W per GPU at idle.
> > >
> > > Measured on gfx1200 with an idle HIP process holding one stream and
> > > two resident KFD queues:
> > >
> > >   before:  VDDGFX 695 mV, GPU load 2%, ~9-10 W
> > >   after:   VDDGFX  35 mV, GPU load 0%, ~8 W (idle baseline)
> > >
> > > The resident queue count is unchanged in both cases; only GFXOFF
> > > availability differs. The ocltst runtime suite (40 tests) passes with
> > > and without this change.
> > >
> > > Fixes: 2affe2bbc997 ("drm/amdgpu: disable gfxoff with the compute
> > > workload on gfx12")
> > > Signed-off-by: Harkirat Gill <harkirat.gill@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > index 121282dd30c1..34573cef3393 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > @@ -746,9 +746,8 @@ int amdgpu_amdkfd_submit_ib(struct
> > amdgpu_device
> > > *adev,  void amdgpu_amdkfd_set_compute_idle(struct amdgpu_device
> > > *adev, bool idle)  {
> > >         enum amd_powergating_state state =3D idle ? AMD_PG_STATE_GATE=
 :
> > AMD_PG_STATE_UNGATE;
> > > -       if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=
=3D 11 &&
> > > -           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 6=
4)) ||
> > > -               (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =
=3D=3D 12)) {
> > > +       if (IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP, 0)) =3D=
=3D 11 &&
> > > +           ((adev->mes.kiq_version & AMDGPU_MES_VERSION_MASK) <=3D 6=
4))
> > > + {
> > >                 pr_debug("GFXOFF is %s\n", idle ? "enabled" : "disabl=
ed");
> > >                 amdgpu_gfx_off_ctrl(adev, idle);
> > >         } else if ((IP_VERSION_MAJ(amdgpu_ip_version(adev, GC_HWIP,
> > > 0)) =3D=3D 9) &&
> > > --
> > > 2.43.0
> > >
