Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A136C5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 17:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951DE10F142;
	Thu, 20 Aug 2026 17:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KADi4HU7";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62C2010F142
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 17:30:32 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-384422b05b5so2448a91.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 10:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787247032; cv=none;
 d=google.com; s=arc-20260327;
 b=lIwTyNWGspZgbHem6hlWerBEEClQwGSV620Gdoyo8DAiApb3WARwKuGMGeC/KQLkV7
 SgvEp2s3sDJrs8a1ufZGjwTCShBjMtA0HDGA22lt6l2vBSbd1g+BAlDQktEAc5KX1ugv
 LG8xHsd51NMhmxY8ddc0e6MjpXrEO2T1FfvTl/pn/PtuRLXiY9IhCxLZ2Rj9JEhrAwKq
 wdzQcsH9slyBlr4phZl8INTU0DEcAA7gKDMx/O36/IH90PO+WDiRfNWeV8ZMEICi5lqg
 BtRVF5xfeNsIsaaFzoJSMtqmflvXvpE//Wu3P+7LzdY7hjUNv+F/Tm7KXBt3Appr6zUP
 Ypjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=CXnMANvJ9eN98YzEYsCcWeGUongdCQIQFEcU/aBU4T0=;
 fh=INgAn3Dz+hp99rlSHGoUboV5nmBkpKulC1yGIax4Mhc=;
 b=EsBxQCTJt/WqlZM1i64LHPiiQ1EILS9W3xI/6aNpNKZxPFLPFOE6tuddMqIBah7HqF
 ILH7dlzPlScQUR/F8sB6KKlBNfKG9wohexaA91YkyiAE5OBY/MbCA8BQ7u4D91+btG9P
 pVkFUJ3sGkNFYYnHEqqrQPYaWoe4m0WzG1lrzLZZc602UB4SWGAPkBM2pUS2e881r9CQ
 L3UCIcuUNR8LRApYtgeYEbfGqkENjqA7kU1lGGNTiYpLwAXQOYQXHoVquy+rY9JJT64n
 b+R07duqOT/IsRyMe8PY6u/7L8cZxLVMfsRL3WB75ULnVRv4JljXt0N74bQg7I3xe8Le
 WOww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787247032; x=1787851832; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CXnMANvJ9eN98YzEYsCcWeGUongdCQIQFEcU/aBU4T0=;
 b=KADi4HU7d15NsCowvzrHicqANIUsah061nU0Ap5dlPlNdKJcrOC6aUwADd/Hs0fPE1
 VPy5U3FTZi4uDE7vsFJaW/WHvj03d/oH5YKrEDKVm0GKQQWpdhPRkSjfC7jlgH/ohEWL
 TZjX9Obt2tBB9MOFxMOtK8Z6mXw79lxIrYgxhrBCwvc3STvRZW3IT+4sPWJSmSzazdjG
 Op63gzvQWWHnYQ7VtrQoSW0xuvhKseChl4HmSV5DI5P7VNjjbQbml093QK2ZQszR9zYv
 ypkP7ovCXMR6EhNqivv27UBcKTPF2y4QHg1KSKT88tyX1yX13uFcQb0YTBv4GUHzZU/h
 B2xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787247032; x=1787851832;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CXnMANvJ9eN98YzEYsCcWeGUongdCQIQFEcU/aBU4T0=;
 b=Dzc3s3SYEK265gbIvU6cH2q4rYBOKKP6U8yHp8nLOBFpyvP5PtSJAtCybAiA10DpOf
 SMS4CKoAcJXPWKGFIVArykflfOUWkPShXgqfrajTrDtv9q66ZCn6xC17X40lILE97+HU
 Q+yTH/u9yNhpQVhREG4F9/5J/jZHdmc7oeZdxcYCk9b5im6feZwFFwCPTtZwaavmXdjr
 hXIRHuiMir90n7EakTjGz6j86U71sFWB+5vEFxvBvSRT5XQD7UR9qEtDncNT/F1ukTRf
 P40fJd/7GSDSkCrxHn02cZGTIAzcDBQG3KqSgYIoC03jSTqdCRIzsPJ+xZc8Jm+SieXh
 NEPg==
X-Gm-Message-State: AFuF++lke4rTAYiX2qJmrqMOFOJKy8LHswW1lLo8cKHngOQR3TpvypqN
 gt+5rxNU6TXXwHzfH/tdkK1mNWdFP/54OnsBuNyUaLFnrdrC1P4DmOFKSvoc1HPJE19IWO4LfGV
 I8SW4/s0BTYxwuVfiOGloTfnaEMH1hqE=
X-Gm-Gg: AR+sD13b6kQZ4PG+h3MVu9L28Fjm38SBYJK+ODgjFZtGqVx1s/Yv0s9JDCU+7HPnyok
 CwWnjoGVJAcBjGqRQMyvzeW8ti+1vgwP6Pt4Er/VdJYMxi5DtfJzQiYoLHB4DyzDdSBr+nkN0VQ
 XCTrf5JPkLjN8A6BMQ+0EigQUwHI2IpGaQzRIe+Dv8n3ZR7jUBeGzY4KiZCShwm2NLcP66ajoey
 sjHRjeCIF19UdNb2s5k89uKVNG29EOR2mATpgIRTcV0npIb6vODHCphiAntkMxFE9famjg30H18
 /nlDtuu/QTZ0+Bm2zSnhuwer+LoEiWjxyNKpqu7boxXkAqeB6DfYW0zbEK7GLl/LNEcGYRCwnZp
 +zlKjNLP9o4UG26CqDqSBRj1SjVBCTYw=
X-Received: by 2002:a17:90b:2687:b0:38e:6a7c:abbc with SMTP id
 98e67ed59e1d1-395c37238dbmr71890a91.3.1787247031544; Thu, 20 Aug 2026
 10:30:31 -0700 (PDT)
MIME-Version: 1.0
References: <20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com>
 <CADnq5_MNFZfbvkgQ6JYjBZOb5+E+kezXDphFHshaaw7h7yVk0w@mail.gmail.com>
 <CH0PR12MB52689AE98C9044860F3FB914FFA42@CH0PR12MB5268.namprd12.prod.outlook.com>
 <CADnq5_NL1vec9Xp=6EjUupmJb8DkkUu2dz44URLL5gf+f9bKxg@mail.gmail.com>
 <CH0PR12MB5268E3922230EB424FAEB36DFFA42@CH0PR12MB5268.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB5268E3922230EB424FAEB36DFFA42@CH0PR12MB5268.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 13:30:16 -0400
X-Gm-Features: AcwNN1VrtAXXCcg9-bjeQ4YY42Zn2Ju-OkqLNAsePKhLTzqJbl0ysPMnLg7V2ks
Message-ID: <CADnq5_On3OffA8-eqe7wmuhxmqafw_hd-uWN_DTttefyt8ATVg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device
 padding for 32bit compile
To: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
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

On Thu, Aug 20, 2026 at 11:28=E2=80=AFAM Mohan Marimuthu, Yogesh
<Yogesh.Mohanmarimuthu@amd.com> wrote:
>
> AMD General
>
> Hi Alex,
>
> I am not changing the layout.
>
> For 64 bit gcc, default alignment for __u64 is 8bytes.
> For 32 bit gcc, default alignment for __u64 is 4bytes.
>
> For 32 bit gcc, I have manually padded 4bytes so that it is 8bytes aligne=
d for __u64. This will make 64bit kernel compatible with 32bit mesa compile=
d using gcc.
>

Won't this break 32 bit kernels?

Alex

> Thank you,
> Yogesh
>
> ________________________________
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, August 20, 2026 8:51 PM
> To: Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device =
padding for 32bit compile
>
> On Thu, Aug 20, 2026 at 11:18=E2=80=AFAM Mohan Marimuthu, Yogesh
> <Yogesh.Mohanmarimuthu@amd.com> wrote:
> >
> > AMD General
> >
> > Hi Alex,
> >
> > In 32bit mesa, I did not get the correct userq_ip_mask value.
> > I checked for variable alignment and tcc_disabled_mask was not on 8 byt=
e alignment. This patch fixes it.
> >
> > Can you please tell how it would break UAPI. What did I miss.
>
> You are changing the layout of the structure that existing apps expect.
>
> Alex
>
> >
> > Thank you,
> > Yogesh
> >
> > ________________________________
> > From: Alex Deucher <alexdeucher@gmail.com>
> > Sent: Thursday, August 20, 2026 7:23 PM
> > To: Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
> > Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuc=
her, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Ko=
enig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> > Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_devic=
e padding for 32bit compile
> >
> > On Thu, Aug 20, 2026 at 12:55=E2=80=AFAM Yogesh Mohan Marimuthu
> > <yogesh.mohanmarimuthu@amd.com> wrote:
> > >
> > > need to pad before __u64 tcc_disabled_mask variable.
> > >
> > > Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
> >
> > This will break UAPI.
> >
> > Alex
> >
> > > ---
> > >  include/uapi/drm/amdgpu_drm.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_=
drm.h
> > > index 0a113529b..5beef3eaa 100644
> > > --- a/include/uapi/drm/amdgpu_drm.h
> > > +++ b/include/uapi/drm/amdgpu_drm.h
> > > @@ -1517,6 +1517,7 @@ struct drm_amdgpu_info_device {
> > >         __u64 high_va_max;
> > >         /* gfx10 pa_sc_tile_steering_override */
> > >         __u32 pa_sc_tile_steering_override;
> > > +       __u32 pad;
> > >         /* disabled TCCs */
> > >         __u64 tcc_disabled_mask;
> > >         __u64 min_engine_clock;
> > > @@ -1541,7 +1542,6 @@ struct drm_amdgpu_info_device {
> > >         __u32 csa_alignment;
> > >         /* Userq IP mask (1 << AMDGPU_HW_IP_*) */
> > >         __u32 userq_ip_mask;
> > > -       __u32 pad;
> > >  };
> > >
> > >  struct drm_amdgpu_info_hw_ip {
> > > --
> > > 2.43.0
> > >
