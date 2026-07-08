Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01585C44507
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 07:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3500A10F43C;
	Thu,  9 Jul 2026 07:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gGze/otC";
	dkim-atps=neutral
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com
 [209.85.217.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6974310F184
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 15:35:12 +0000 (UTC)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-737d7440b6eso33532137.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 08 Jul 2026 08:35:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783524911; cv=none;
 d=google.com; s=arc-20260327;
 b=G340wangSWcs0omqa9efvTXiimtjUJ//8RzIZksAqLbZ4n8T70A1XHExLPooxJ/UZg
 wi5mzlbpKHBJnvFxbjPHo0gtijtJYnB56FSTudt/T5NDD4aNSZowQ9gZAqPXw1u6URNT
 cqBiAq6odf50s6Ysxwq7LUtF1ja9lxU22oG985QZXfrfIQrxB9/M09sD/LLwJ0BQnhoG
 8W/6W0O7QwvjzR8KBFr/uAen39b7pRn/Rxeffg3wPfZqqtN3rOCzwqGxjPXpeIxJN6M3
 XYTLX+WDuGd4cEPBmjv3VKtxSqS0ZXK30EvJmYua2jwaKX6UziHzCByC83XrINBYkCGZ
 wDwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7zCGQMgTxRSDwHGNj95VKzrTpGhHUfrTs6Y6MG1mxDg=;
 fh=m0OPkknEIzLQzMA9ZkkpJLted2PHvajb/6Uwte+OLa4=;
 b=pveXSnpJWh3l2VpVQU6PaVGTx4vA+l+GLZJVhAtsCPuTJD7eT8tiH+1Ot0P2j36BVA
 ZwZJdMLWy/kQP7u7I/l0uHmRu7docQ0kt9WZezSjkqJ7MAaRbpnFw4Nwg++ixMRcEvSd
 t93Y9H8xMcRNAmonUUG+dWmEKNheNAoMAiV97sKBrw7X677tuuunpR1z1014Dxigz5Is
 gGQBwJbQR7M/C92IFiXVgUtiaOT8ytG4I3pbSsdro1I6lydqFYDt/mmPtsuJK83xe6Ji
 67L1N4nzBcd8G/PHMs3FjCztZNQTvRlmHzw/TBuuqP2fBRCOAFAaoNV6bq+16PP23RiA
 Ku4w==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783524911; x=1784129711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7zCGQMgTxRSDwHGNj95VKzrTpGhHUfrTs6Y6MG1mxDg=;
 b=gGze/otC61DPC7doYt7foMusPrtNdz7kE+EESGaitxgwGI+rBWAd/tS4/u6azhJLZc
 3Hr+RhlUDe8/Mhw+vToGXaJgv7dxRdw28QTcU9eX9NmgS4UeRC5+EqUHXnWz0C8gh4E+
 nNQvFPr8pfrxxd1D8CNn8nmDLNO1RPxiyK9MOre0cAS3dNPDzvydODh8dHjEb+LhoRkt
 jr7jVIdjcZ/DN00yR7NbSnQSCMZKxSdIwfewzBHOeBTxnBPGRjILH9Mxyp4JBWPUVmZH
 FXiIfE00lieirQPzdL8zz+x02+e9lKcc411S4A1CpTU+d78laJR2gZ9ixuG+Jb+3OODp
 SyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783524911; x=1784129711;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7zCGQMgTxRSDwHGNj95VKzrTpGhHUfrTs6Y6MG1mxDg=;
 b=BTUHKz3lrCTWTOVMP9ABaedKZB+6cQaXwA3bC54s564hnAyYso7lxvw3+Efe45SdQZ
 XxBCh9yfAPHzG7w2m5sh6M/C8/NClNUPfwH+rHjhBilkMvDmygeSZ/wz+ECWvjV5/oIZ
 Dl6IWjVcyhCdKpNeFh7ovtirm4YWVIgFRIx90MRXFoTb1etWiFmo7cWAOxNyy2OId1k7
 7/JuHeFNikGJv2XyaYPIJ0y8EnjNiyUSEvbYBnVMHeqa+SnZw8Tw+Qjsk046L4+YoQcI
 yrZknjm1/QzeHkoX5y7sIbGOC4T8IJHgB0kqf5KN5CEa8QVcpRHY7ZGXw5WdmpD1M14G
 4AeQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsQFHGFsXCExdWcmxYU3cQUP9Zj0HW1zLnm6b+0RzeGE0UV1aEApGwp1f1I/p4TnH4yx7CNMF3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLEEVwqZAWKtKrfIAkpuGBjEUQYWoHHLokGOZr3NDYZ+G4m0Bv
 xoVI0eZcBy3LW+cD7FgdnLF6prADZNiZVM6+ZZghwwYFxaKVk2+ZNiKRrReOQIwwzPPrRnYloYh
 t7KORQj8HRm5NYajvXRN9UmxOdSRCRCo=
X-Gm-Gg: AfdE7clECTg9Gz2iApDxXOv8MZT3kvs1DG2YFQU05sG/lRcGzSwpplNeIBTV++IOmml
 5215HMbcVVPk+hMO/Sz3xauSsECe9nP4AJLSNVGiBvhqUW88ZvNrLHes0YCQsx5mnKxW1Pv5xRr
 SGgS0qycdraqMr1LCnKEowJkXEZkxjc4SCfPrFAJMxiVQllSZVK76rONo3BkJfG6XAmKJyuqvmh
 to5kATkICsws9ecmnYNaoroZIpkKLF1q3Y5nBs7c24pXiXzyRp4IxQkC9ftpdPxVXoUJE6K/no=
X-Received: by 2002:a05:6102:41a2:b0:738:8d0f:72a3 with SMTP id
 ada2fe7eead31-744e038ad37mr647257137.4.1783524911174; Wed, 08 Jul 2026
 08:35:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260624184444.D4A401F000E9@smtp.kernel.org>
 <20260708061835.111986-1-jhapavitra98@gmail.com>
 <CADnq5_NyPb0XDxtJR57P8XNnhbBdpBjFFdq1zRVnzZLoZi9Vgg@mail.gmail.com>
In-Reply-To: <CADnq5_NyPb0XDxtJR57P8XNnhbBdpBjFFdq1zRVnzZLoZi9Vgg@mail.gmail.com>
From: Pavitra Jha <jhapavitra98@gmail.com>
Date: Wed, 8 Jul 2026 21:05:00 +0530
X-Gm-Features: AUfX_mx9zKL5wOtfHcAD-1pDiP_E1ouKJoE4uph3rDbmrtFeOMtdbTxZmhFyQyc
Message-ID: <CALFbBidWOJt34zTtc0TRtUCmNkxBj7iC_PFP76-gkHjr2SLG1g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/discovery: validate table offset before IP
 discovery header cast
To: Alex Deucher <alexdeucher@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:26:29 +0000
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

Hi Alex,

Yes, absolutely! You can keep my authorship on the patch.

Thank you for fixing it up.

Best,
Pavitra Jha

On Wed, 8 Jul 2026 at 20:24, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Jul 8, 2026 at 9:19=E2=80=AFAM Pavitra Jha <jhapavitra98@gmail.co=
m> wrote:
> >
> > Sashiko AI review of the previous fix flagged three remaining gaps in
> > the discovery blob parser, all stemming from the same root cause: the
> > ip_discovery_header pointer itself is constructed from a firmware-
> > controlled offset with no validation before the cast.
> >
> >   ihdr =3D (struct ip_discovery_header *)(discovery_bin +
> >                     le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset))=
;
> >
> > This offset is a firmware-controlled u16 read directly from the
> > discovery blob's table_list, with no bounds check against
> > adev->discovery.size before being used to construct ihdr. Every
> > subsequent read from ihdr, including num_dies and die_info[], is
> > downstream of this unchecked pointer.
> >
> > The other two items in that review (unbounded ip_offset advancement
> > via num_base_address, and num_dies exceeding die_info[]'s capacity)
> > were already addressed in the previous fix.
> >
> > Fix by validating the table offset in amdgpu_discovery_get_table_info()=
,
> > which is the common path used by all callers except
> > amdgpu_discovery_read_harvest_bit_per_ip() (which reads
> > table_list[IP_DISCOVERY].offset directly rather than going through
> > get_table_info()). Add the equivalent check at that direct access site
> > as well, so all paths that construct an ip_discovery_header pointer
> > from a table offset are covered.
> >
> > The check validates the offset itself against adev->discovery.size,
> > independent of any specific downstream struct size, since
> > get_table_info() is shared across ten different table types
> > (IP_DISCOVERY, HARVEST_INFO, GC, MALL_INFO, VCN_INFO, NPS_INFO, and
> > others) each with differently-sized table structures.
> >
> > Fixes: d0c647a6aae2 ("drm/amdgpu/discovery: support new discovery binar=
y header")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pavitra Jha <jhapavitra98@gmail.com>
>
> This patch no longer applies to the current drm-next code.  I've fixed
> it up and attached it here.  It was a relatively large change so I
> want to make sure you are ok with it if I keep your authorship.
>
> Thanks!
>
> Alex
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index b4ee5fc8e..9b55c56cb 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -564,6 +564,12 @@ static int amdgpu_discovery_get_table_info(struct =
amdgpu_device *adev,
> >                 return -EINVAL;
> >         }
> >
> > +       if (le16_to_cpu((*info)->offset) >=3D adev->discovery.size) {
> > +               dev_err(adev->dev, "invalid table offset %u for table_i=
d %u\n",
> > +                       le16_to_cpu((*info)->offset), table_id);
> > +               return -EINVAL;
> > +       }
> > +
> >         return 0;
> >  }
> >
> > @@ -766,6 +772,14 @@ static void amdgpu_discovery_read_harvest_bit_per_=
ip(struct amdgpu_device *adev,
> >         int i, j;
> >
> >         bhdr =3D (struct binary_header *)discovery_bin;
> > +
> > +       if (le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offset) >=3D
> > +           adev->discovery.size) {
> > +               dev_err(adev->dev, "invalid IP_DISCOVERY table offset %=
u\n",
> > +                       le16_to_cpu(bhdr->table_list[IP_DISCOVERY].offs=
et));
> > +               return;
> > +       }
> > +
> >         ihdr =3D (struct ip_discovery_header
> >                         *)(discovery_bin +
> >                            le16_to_cpu(bhdr->table_list[IP_DISCOVERY].o=
ffset));
> > --
> > 2.53.0
> >
