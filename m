Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3F0CAC5AE
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 15:13:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2F7010E74B;
	Wed, 24 Sep 2025 15:13:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cukfEwj+";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C3410E74B
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 15:13:10 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-33056307257so1032588a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758726790; x=1759331590; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oT6UJxEiRoCa/jncZSKWAsfyptpM/q4cHBQuGT2+xzI=;
 b=cukfEwj+6PNvUjfG88nvY5Smn6hnfg2vXXnytFqgD9SxMmmXyG2TMeU9QjTwxU0sYS
 ON09ymeFedLOkMT4TYXP+mWMMf3oti7BqUk8/ku7PAK4U0PFPCyxe3c4uJvqYa1lCQG9
 myllzdY+I9mhX2CK8bOcIRYs7cm++ugdOq1CiRa1FSlPCve9+z6FTA7JZ0/DL5fKL0ZJ
 Yg42Wee7IiqCmbivk9prApW4MprU+Aa/S2k5m5EzPcKZMn6JJH6furGsPmyPTLMNdyDq
 /K3X1VQ4CVNw2k7D/MbMfWdU2GzoiawETRl0zAwDWMQt2yjniX+LdtSwNsRkmcRZL3ld
 S2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758726790; x=1759331590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oT6UJxEiRoCa/jncZSKWAsfyptpM/q4cHBQuGT2+xzI=;
 b=FZMN27S40iREJWZjn+pQPZca8faoilh3EnsVefo5tMPWjr1yrncTo2ZbPa95Wz4QX9
 aOsvox3ueO2pAXVJmYGXDoqSkejvM/wkALaQ9pJg0Bta12W/Xq3R13W8yzltdT6uxHaT
 YtSs5X/4Jk4e0FHSjIOwzNAMOOmiEW9tQdDnwLaZRPv3p4wbECULS7mVImqgOrqWwq8o
 cAGsXbWVB7qNDuMVsKOTkPkoH0Ns8Ha2z6T+dKuceoelUHQzYTNIqwdD15q6H1nL4w/3
 nPUian7SRbjNbUxheQ307qzBuIKG1gTdqJ3VAjKN8l0HtJiZPUd4h8S7AFoZrPK7F6JN
 UWRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQUwnC2zwwBI0eCQ1hALqABmnZi9LxFIkFBp7UndqjOx8SXxgt3lpac630uT8aVGwIju/PX1wc@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsWPpCr6CwuJd8JxHE+XoEcH8G1Id0h9eeNjxK7fZxtQdwVEEU
 H9aLjsLLzRoWfsVrgRHLEO6FgwSOcomr6v5UDXI7xgxBYF3VTAcpFzBiAz2PxTlwvgtn70dwseB
 gRsdiX6BjmPb0WpGF+KSIs+7/P4NQXXw=
X-Gm-Gg: ASbGncu562YZ/rEHOD7e7YumtnHiAqA0AZ6csChNMBdbbG2bVW0sYTBTjiL5HopWH36
 09CPnff8aLO+ca1vXFNqNtz75NsXydmlAt3kzPol3KD6MocO+uTcJ3E4sorLvP/F1CFIZhOezHc
 GXaPbm1KE7Scaf+xagQ39ACI8wv/VQ+9LQqv89QG7v6j9BizzA1s9h48DBgbUCiS7G0ih9eAZtF
 rlkY/Q=
X-Google-Smtp-Source: AGHT+IE/6vvT52q1Tq3PbUZ5Sj8H4btfPWdxZWokscp0V9tPaMsPB3mXkUYORcbGigdwWLhn4TOU/pdLW8uuG2+w2q4=
X-Received: by 2002:a17:90b:33c8:b0:330:7e89:7591 with SMTP id
 98e67ed59e1d1-3342a229a36mr56030a91.1.1758726790186; Wed, 24 Sep 2025
 08:13:10 -0700 (PDT)
MIME-Version: 1.0
References: <20250923211216.306525-1-siqueira@igalia.com>
 <CADnq5_Nk3V=7d4m7nCExc8yLhu1Zz7T08wXpM0qJhJSVAVnuaQ@mail.gmail.com>
 <vtbslchbxzsl27unpci2h4e2brloakvjmqggnfakwxnccl5zkq@2lbhfaj3dlyp>
In-Reply-To: <vtbslchbxzsl27unpci2h4e2brloakvjmqggnfakwxnccl5zkq@2lbhfaj3dlyp>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 24 Sep 2025 11:12:58 -0400
X-Gm-Features: AS18NWDsHzhY_GQSjJN5M4QuAak3ZO6-kxsvQyaBLOb-bCobVpVE18rM2KzSdzg
Message-ID: <CADnq5_PqxEUAHMRPOyocxfKD8da2Tw4TSTCbZ7Rpi9BNkm881g@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is
 reloaded
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Robert Beckett <bob.beckett@collabora.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Tue, Sep 23, 2025 at 7:42=E2=80=AFPM Rodrigo Siqueira <siqueira@igalia.c=
om> wrote:
>
> On 09/23, Alex Deucher wrote:
> > On Tue, Sep 23, 2025 at 5:12=E2=80=AFPM Rodrigo Siqueira <siqueira@igal=
ia.com> wrote:
> > >
> > > When trying to unload amdgpu in the SteamDeck (TTY mode), the followi=
ng
> > > set of errors happens and the system gets unstable:
> > >
> > > [..]
> > >  [drm] Initialized amdgpu 3.64.0 for 0000:04:00.0 on minor 0
> > >  amdgpu 0000:04:00.0: [drm:amdgpu_ib_ring_tests [amdgpu]] *ERROR* IB =
test failed on gfx_0.0.0 (-110).
> > >  amdgpu 0000:04:00.0: amdgpu: ib ring test failed (-110).
> > > [..]
> > >  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous co=
mmand: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
> > >  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> > >  amdgpu 0000:04:00.0: amdgpu: SMU: I'm not done with your previous co=
mmand: SMN_C2PMSG_66:0x0000001E SMN_C2PMSG_82:0x00000000
> > >  amdgpu 0000:04:00.0: amdgpu: Failed to disable gfxoff!
> > > [..]
> > >
> > > When the driver initializes the GPU, the PSP validates all the firmwa=
re
> > > loaded, and after that, it is not possible to load any other firmware
> > > unless the device is reset. What is happening in the load/unload
> > > situation is that PSP halts the GC engine because it suspects that
> > > something is amiss. To address this issue, this commit ensures that t=
he
> > > GPU is reset (mode 2 reset) in the load/unload sequence.
> > >
> > > Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> > > Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/nv.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/am=
dgpu/nv.c
> > > index 50e77d9b30af..1964aa37c499 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/nv.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/nv.c
> > > @@ -543,6 +543,13 @@ static bool nv_need_reset_on_init(struct amdgpu_=
device *adev)
> > >  {
> > >         u32 sol_reg;
> > >
> > > +       /* GFX in the SteamDeck hangs when amdgpu module is reloaded,=
 since the
> > > +        * firmware is already loaded. To avoid this issue, ensure th=
at the
> > > +        * device is reset to put the PSP in a good state.
> > > +        */
> > > +       if (amdgpu_ip_version(adev, GC_HWIP, 0) =3D=3D IP_VERSION(10,=
 3, 1))
> > > +               return true;
> >
> > This will force a reset every time the driver loads.  That will add a
> > lot of latency to the driver load sequence.  I think it would be
> > better to reset on unload or add a check to see if CP firmware is
> > already loaded here so we only reset if the driver has been previously
> > loaded.
>
> Hi Alex,
>
> Thanks for the feedback.
>
> First, I tried to call amdgpu_asic_reset() in amdgpu_pci_remove(), and
> then in amdgpu_device_fini_hw(). Something like this:
>
> r =3D amdgpu_asic_reset(adev); // mode 2

Where did you call it?  It should be after we call hw_fini for all of the I=
Ps.

>
> However, the situation worsened, causing a hang followed by the
> SteamDeck fan to spin really fast, and then the system shut down. In
> this sense, do you have any suggestions on which stage I should invoke
> the GPU reset in the unload phase? It feels like amdgpu_device_fini_hw()
> and amdgpu_pci_remove() are already too late to invoke the GPU reset. Or
> maybe the reset operation that I used was not the correct one?

If amdgpu_asic_need_reset_on_init() returns true, we end up calling
amdgpu_asic_reset() so it's the same code path.  In the init case, the
device should be in the same state as doing it at the end of
pcI_remove because it's the first thing we do at init time.  The only
restriction would be that you need to execute it before we unmap the
MMIO BAR because it requires MMIO access.

Alex

>
> Thanks
>
> >
> > Alex
> >
> > > +
> > >         if (adev->flags & AMD_IS_APU)
> > >                 return false;
> > >
> > > --
> > > 2.51.0
> > >
>
> --
> Rodrigo Siqueira
