Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC81C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 15:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EF4210E345;
	Wed, 12 Aug 2026 15:41:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HU/h/xe4";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 043BC10E345
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 15:41:18 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-38fe113c792so224034a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 08:41:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786549278; cv=none;
 d=google.com; s=arc-20260327;
 b=Gdz/nG0YnXDFsEy2CdKa0+hDXMZOKFEs51wpKEQlmwfi2zGZ3oVdlFv2wLB6lzcBD/
 xNxCRKj89jCCUgtQBlQt/aeb96y+4aIp5sZdS8uVNmtrvNzZ1S58mUAQFu49NzOq1BVd
 zrAJ+nYK9duXPtpffa+GoUYknMlGT2ev47h1t3o15hmG3Wv7O+xotRKqrpZzUGKamwnm
 9E9XMnBCoW+JV4y6VnFNbDlQJId3L77b+0uY+EgbH8KlVqIAoJj/5oGAYq1/D0LBxZTF
 fq/rkbYpNfbn0/u6tBUy66QwKb+ocx7o7XwSrwTS5f37/WHcc6ehj6JrZJDCtUzOLoFt
 uDJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GoQP0FW7SYuzVtFJC85KKUOsCo8m89YdXS39DHMXegY=;
 fh=vY4DoKpgP8WvW0WzkUnSE+Z2YOk480iNTaHjBK8IShY=;
 b=nkdmINJEqMz6tkiauGOmoV0tfHn/sgQhXfrZ3WKgJmJLAsUnwKJ+ildMdnM/osfGdS
 5c8D+tegv7sz6aRaU6J79csWGFxYe07IROio8UPRs1IyGgNSDaopawERtomMX9mIERcP
 ZuOW4iHrkIWYztbLH+HayZm4zPxtGl3RQ5v0/Gm8VAll/ztF/9wiRtYukcN30apY5frL
 zeZH4//BAiRSiqn8gVjhBEybxt+yd6P2UlrnOm/DTY30mhxNZpQk/90h9g1O//vXP1/C
 jugUT55bIa2gUXlezfo5ubfX73dItN9SlMg+Kp6Mvmzyyt38V4q/+RL2d+qUxWHsjP1v
 0toA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786549278; x=1787154078; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GoQP0FW7SYuzVtFJC85KKUOsCo8m89YdXS39DHMXegY=;
 b=HU/h/xe4uN5zd4DwF2XVLcxIWM1x/+CkUlu/41f9pmHntHLA8hO/tbtV5SOr7FZSmO
 GXCE/D8B77rYNk/MaR6TPxsynwI4J2ybGeerTMcK0j+zcFOiJvKSPvYTENHrUWqfnMJ6
 7t7KpIgy0qU9e/0BaN03avds/OQT1p32rONz33Z3kTm/zjYcUBAvniUYLjjJs+Kba64O
 cfZTmNRRJp7co4FK1FBAtPzzCKgsPSiBf8AuHHBHXJBr0c98KqhBHu1DnHITU8O5oN1l
 /GVaqWk9UwgpMUWWFD6mkRiK4OkVNLdVSQwdZc99ufwp0oGdzwMU+mddfVUCZUgeUhK2
 WnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786549278; x=1787154078;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GoQP0FW7SYuzVtFJC85KKUOsCo8m89YdXS39DHMXegY=;
 b=QiOunuorezkX3iKDFgSoWRFgYk6fDXQ0t77oMsdCoxYquNR+5dVGcHJ/T2Ofyp74ab
 KBeYdr8E/EMiZsPjacuIRbVc5bbDXm398r9DD2VzXs2Y4pK8MSqhjliQDo2irWiSVkQa
 77H3OdYEptZWSydsO9QogKDsZ/LOALZW8oqX6mh6ou2FfWvjRgKBrpsHeb18wdUEdX+L
 X3pbdXfJEbFoV/apxk8c2cD/KuETXTkHagOFb1VzccYYSvo7CBzjpuVyzyHxLeWHkQYl
 e0KfHN4jOu1FUv0uZrtwa+CrG1yXgcoGAYTezm0zgR86Bf+gchd6Y0nmiL77oBOtYhAV
 D/ug==
X-Gm-Message-State: AOJu0Yw0ee0UYmZRiFSk5tL2VikyohgynWNhTGKeQHk5rx3484Gvnxkk
 nafi5TVvKVEoTxrh8NdxqCo5tR/gJYSzJv0sWXKus7XG0jeherWXW2noJQRF4/K3Km2gJBUt/Tx
 x5472beKZFdf2t9TOVA6RG6npld+7x1U=
X-Gm-Gg: AR+sD10DG49XeqzpGRShbUgnwiJQ/t/H7dxxmVdBx0cU4dQNTpAYrbLte4xWWYYsJtu
 W9TF+ml/JloxR6FyxWTFHrx0iFugJ602mk3zJ2SofI/ypUIf4Nk/n/INT83yN05imNxLj4hJIaG
 IfKvnHE4bcWuxL52z/I8EBe/ynSVgAtR/hTM0CzlWUrppmzmANDtcZA8Dj5wjyqtF767lXZab1z
 3Y7LqVEBbfwzZLir3tT10XDnhMEyTy0Ct3L7SYnpRbUvjdgdlAxMF0mHPX2/QI/qj3lvSDY9i+o
 gYT/oigJp2QdfocsfCArAHubHgymplrTzQJ/7i8YSJm3mUW2lpZQnZPmD3DKgHZPgy235H8nGDq
 Yc+D9D3BzNwia/mBylkSAHwJRMlU4IWI=
X-Received: by 2002:a17:90b:2e4b:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-3930120596amr4843954a91.1.1786549278303; Wed, 12 Aug 2026
 08:41:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260812080841.2936007-1-kevinyang.wang@amd.com>
 <CADnq5_NDBUquX6CgaLEZ3YZMpkUHn757J=FQYTJO-Ld8KW-pqw@mail.gmail.com>
 <BN9PR12MB5211F6BCD471FEB271B1726382DC2@BN9PR12MB5211.namprd12.prod.outlook.com>
In-Reply-To: <BN9PR12MB5211F6BCD471FEB271B1726382DC2@BN9PR12MB5211.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 12 Aug 2026 11:41:05 -0400
X-Gm-Features: AUfX_myhEbn3kc6ZT2tYvGV8hgYW84uRS7dz8Xf9Yg6UStj_4_TYVcb8Y0_kbtI
Message-ID: <CADnq5_MKdA0SY5vSoCdMEe+W73pt1Ut3Cu0+xnp=j+Kh=ndWDA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Disable runtime PM for externally attached
 dGPUs
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, 
 "Feng, Kenneth" <Kenneth.Feng@amd.com>, "Li, Candice" <Candice.Li@amd.com>
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

On Wed, Aug 12, 2026 at 11:23=E2=80=AFAM Wang, Yang(Kevin)
<KevinYang.Wang@amd.com> wrote:
>
> AMD General
>
> > -----Original Message-----
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Wednesday, August 12, 2026 10:30 PM
> > To: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> > <Alexander.Deucher@amd.com>; Zhang, Hawking
> > <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>; Li,
> > Candice <Candice.Li@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu: Disable runtime PM for externally
> > attached dGPUs
> >
> > On Wed, Aug 12, 2026 at 4:45=E2=80=AFAM Yang Wang <kevinyang.wang@amd.c=
om>
> > wrote:
> > >
> > > pci_is_thunderbolt_attached() requires an upstream PCI bridge with
> > > is_thunderbolt set from an Intel Thunderbolt VSEC. This does not cove=
r
> > > the affected ASM4242 USB4 PCI hierarchy:
> > >
> > >   00:02.2
> > >     \- 0f:00.0 [1b21:2421]
> > >        +- 10:01.0 [1b21:2423] -> 45:00.0 -> 46:00.0
> > >        |  -> 47:00.0 -> 48:00.0 -> 49:00.0 [1002:7590]
> > >        \- 10:03.0 -> 76:00.0 [1b21:2425] USB4 Host Router
> > >
> > > The host router is outside the GPU upstream bridge chain, leaving no
> > > ancestor with is_thunderbolt set. PCI core propagates DEVICE_REMOVABL=
E
> > > below the external-facing PCIe tunnel. Disable Runtime PM when either
> > > pci_is_thunderbolt_attached() or dev_is_removable() is true.
> > >
> >
> > I could see BOCO being an issue, but shouldn't BACO work?  That should =
be
> > self contained to the driver.
>
> We reproduced the failure on the affected ASM4242 USB4 eGPU topology.
> Before applying the workaround, the driver selected BACO:
>
> amdgpu 0000:49:00.0: Using BACO for runtime pm
> amdgpu 0000:49:00.0: Failed to exit BACO state!
>
> The failure therefore occurs in the BACO runtime=E2=80=91resume path, not=
 in a validated BOCO or _PR3 path.
>
> We do not have an actual test case to verify the BOCO case, but it should=
 be disabled together for safety.
> Note that the final target state for BOCO is D3cold, while D3hot is an in=
termediate state.
> It could also be problematic if the device cannot fully transition into D=
3cold, (though this is only my guess and not yet confirmed)
>
> So, should we keep pursuing this issue, or limit our workaround scope to =
BAMXCO only?
>

This change is fine for now as it fixes the issue, but it would be
nice to understand if there is a fundamental compatibility issue with
BACO and USB4 in general.

Alex

> Best Regards,
> Kevin
>
>
> Best Regards,
> Kevin
> >
> > Alex
> >
> > > Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 8ebe24d59ab6..a4b4f9645c84 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -609,6 +609,13 @@ void
> > amdgpu_device_detect_runtime_pm_mode(struct amdgpu_device *adev)
> > >         int bamaco_support;
> > >
> > >         adev->pm.rpm_mode =3D AMDGPU_RUNPM_NONE;
> > > +       if (pci_is_thunderbolt_attached(adev->pdev) ||
> > > +           dev_is_removable(&adev->pdev->dev)) {
> > > +               dev_info(adev->dev,
> > > +                        "Runtime PM disabled for externally attached=
 device\n");
> > > +               return;
> > > +       }
> > > +
> > >         bamaco_support =3D amdgpu_device_supports_baco(adev);
> > >
> > >         switch (amdgpu_runtime_pm) {
> > > --
> > > 2.54.0
> > >
