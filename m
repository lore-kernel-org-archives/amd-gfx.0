Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1C51C624D3
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 13:10:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3569510F1E9;
	Wed,  2 Sep 2026 13:10:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qfK8Govj";
	dkim-atps=neutral
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com
 [209.85.216.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394ED10F1E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 13:10:18 +0000 (UTC)
Received: by mail-pj1-f52.google.com with SMTP id
 98e67ed59e1d1-38eca09faa2so82229a91.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Sep 2026 06:10:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788354618; cv=none;
 d=google.com; s=arc-20260327;
 b=aI4dQ7kxmvZLBzVR5T8OBpxMZOcz//wle3z2mok8Dkmqs6DZpyWKZbEGxFUXudOTNp
 zIySwlIMohQoVW9IDiJb6KdtnOEYDEnsv00CmFMaNOOr929ytdlww15AC3AJ3NR3Qt1v
 cLpKxcnMU5ti0T68m2j/034izb/+Sj5WbPiGvRXf3E3m1PoVs/JQBh0HFIXHvdAmveNF
 WRNQqLparcud1EYIqMaYtCFc7L9gcRRJX6SBSC7FNZBFVl/6FJWbafg4U9WN1T64+kv9
 dj6Sj8B8WZwK7TK0fcJehJHx4ltvbhVc/2QjtrmG3GelIYMnPSZeR1NOnQMPEyV8az5b
 wjog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=RYbcys8Jad2ZpKsTxnMiBv7jbB7+ucjUmUPg/0WETIM=;
 fh=w2s0+0uwyTzBaCC/ZLCPslNMVNbrIE4QGOHZ/G2bw70=;
 b=ckvPgXnlpP6Ga5sOJvVDkJ1Dh57OmVS2t80adtW5MFJVq3yDZU6mGBkE/ppntVq6HZ
 H0GE2A2n913KQGv34u2/fsmh22ctpZec7G9b6k1bZFBO0aP/EV0qjxPhRZjGfPfoarJW
 DgAmT66e51GGpQfN58lq7m6zbPx0S9dG1iIucADuW/0m3K5KpkLOJQ3gLhqEh6YjG2pa
 pEMuHFCYLDyjZLA8Ul+4lOkg+wYkQaBLiWQxCihTUq70y1Xthz6gFcQFT28QlHb9G48r
 09BMeuP4PgRWXqQUsI4FpA7AVWihkGjV/C39WVN6gCDDEUvO02COl31aT7b0r5BFqN39
 a0dw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788354618; x=1788959418; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RYbcys8Jad2ZpKsTxnMiBv7jbB7+ucjUmUPg/0WETIM=;
 b=qfK8GovjlXP/5O3nS3KMrt8821Xuq3F3FSKC2XXUQZar8ZozKkxVf5PzUglkxKxbNC
 LO2taKtD1ewP45pQTwJg3m9SIZF9gKnO6Gu1JhsVuGbawjReBEYnwX2SSdbpfuHA1EaX
 pUzue8uXH+lpJX87n9Lo7zuyg8tGnND1qj0uVNyiZpBkxNWb3yG/IWzu2IQcK9t3L3Nc
 PquA7jIUAomWr79WDIvcNlRVVryDBkCvj8B7Z/d0PXhuV7E23f0z/OcUZ7mtpIJFBsP/
 S7kHXa++fK/IYsjwCDS/kZ5o89acUC2/rY8H6a53ySxddcvQHqycbgMNsKa2Z1sc2yqY
 bSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788354618; x=1788959418;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RYbcys8Jad2ZpKsTxnMiBv7jbB7+ucjUmUPg/0WETIM=;
 b=EBYgqd2tn1s0MKrhrl2xqbcDFNI90a/c9xZYnhjr258Wvbjx8sxcr6bDKRktZHP7up
 0QfAq2y44jcKivHN7+8xEF4FBx3GMF6WxEzivogOD60sfR9Pm4R7iT2vzIsAk55tyLN/
 6rCkqwrQ4ApI6oRusmfPha1BeWBB+zViB6fuVXQPzGOy6t68cyU1VR6KTW6AlMv/NNSs
 pIH1qpcC/NnvB9NAQSQMNhOoLp18K1oonDfvqQj+Npfwvj403o4HbbL/gFAI9CV2exf/
 u8I+0Wl0EbmSPimCPeozrquL6DzLHhabDSRwZeGOGxc90nbtjEvlOVw3kWTxEt6BsCW8
 cEGw==
X-Forwarded-Encrypted: i=1;
 AKwUvByX7ja98ws9L6FhH08c2wQerspMf5+p4FowpAZM26GnkVhKIzn0qSXULSCpvVPdf4OR+fAnOtbM@lists.freedesktop.org
X-Gm-Message-State: AFuF++k/GnQ4wbIiSAOY3FaqnGCkCgp5Js78VZPW+9YKqo88qWk/iRNN
 KQLsqr80gLevm4o1uqHnd3D+dPJGFVISibV5EnVYQASUyZQrqkql2NuDf9OaUP0yb3NhghfZ5EA
 wYvu01TXBFidpWL07jgjjxwUglV2tB+Y=
X-Gm-Gg: AYBFou2plAVoY5a3SW3TEyUBH825FAhohw+ycojbYwTXN9sY1dbOeStRYpNB7uKcXke
 7YBC4yLAOSunp4s3n+qcw1LSrNEVZRHxn7UGe7HLlO2r5KJSdncz/SALGFOPrutbHeoJs70ZHJa
 w4SFolCG9LfZlQV8Dn+mxYE9gO6W/ksMqKrDQGEbiEmSD7T+msjLSgcBMWBl11T6fEQkYGZVlcO
 BNODMcRFXgIW9UhssfDKyHwuZ2sjvQ8KdoEM4pdtFWeecfShCQ/pAK5L7TptC6DwFwtsDqhH7TI
 pWb930+rDfgzZM8kpp0OzSaDVJrP0Zh5fFUXD933prINOTsshvhebnkZla+wJqQdelICRzLDGjC
 hQPeQuWYh6IEi4voU2A12Cs1dyKymTR0=
X-Received: by 2002:a17:90b:2e49:b0:396:a47f:d38f with SMTP id
 98e67ed59e1d1-39aee105cfcmr4754548a91.3.1788354617379; Wed, 02 Sep 2026
 06:10:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260901201034.2960437-1-alexander.deucher@amd.com>
 <20260901201034.2960437-2-alexander.deucher@amd.com>
 <e9266cee-bf04-4076-8e63-5f1fd497f929@amd.com>
 <CADnq5_P3tHa6EtLyok-+WoH06zHQR2BmqBJUfNXyNFDhuzMy4w@mail.gmail.com>
In-Reply-To: <CADnq5_P3tHa6EtLyok-+WoH06zHQR2BmqBJUfNXyNFDhuzMy4w@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 2 Sep 2026 09:10:05 -0400
X-Gm-Features: AcwNN1WW5oeunaPXWoaMOlWxFSr5WtUzENsTTsQumGxNHfPc8rfbz8uJDIUO33o
Message-ID: <CADnq5_Ng1YFmfjLoP7m_oxMM8uri=9SOzFscxG=mN8HLeSTUYw@mail.gmail.com>
Subject: Re: [PATCH 01/31] drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Wed, Sep 2, 2026 at 9:08=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> On Wed, Sep 2, 2026 at 3:35=E2=80=AFAM Christian K=C3=B6nig <christian.ko=
enig@amd.com> wrote:
> >
> > On 9/1/26 22:10, Alex Deucher wrote:
> > > We need to disallow gfxoff if we touch GC MMIO registers.
> > > At the moment we use KIQ or MES for TLB flushes so
> > > no intended functional change.
> >
> > One reason to use the KIQ for TLB invalidation was to avoid enabling/di=
sabling GFXOFF all the time.
> >
> > So this change here might work around GFXOFF issues, but that only hide=
s the problems we have with GFXOFF and doesn't fix them.
> >
> > The same is true for all other generations.
>
> This was meant to be a short term fix which could more easily be
> backported on the way to enabling SDMA later in the series to work
> around issues like KIQ dying when doing invalidations.
>

Regardless, we shouldn't be touching these registers while gfxoff is
allowed so even with these patches applied, we'd still be using the
KIQ and MES path if those engines are available.  This just makes sure
the fallback case is safe.

Alex

> Alex
>
> >
> > Regards,
> > Christian.
> >
> > >
> > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > ---
> > >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/=
amd/amdgpu/gmc_v9_0.c
> > > index b46b87291c512..80f1cf1f21736 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > > @@ -808,6 +808,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu=
_device *adev, uint32_t vmid,
> > >               return;
> > >       }
> > >
> > > +     /* disabllow gfxoff when we invalidate */
> > > +     if (vmhub < AMDGPU_MMHUB0(0))
> > > +             amdgpu_gfx_off_ctrl(adev, false);
> > > +
> > >       /* This path is needed before KIQ/MES/GFXOFF are set up */
> > >       spin_lock(&adev->gmc.invalidate_lock);
> > >
> > > @@ -873,6 +877,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_=
device *adev, uint32_t vmid,
> > >
> > >       spin_unlock(&adev->gmc.invalidate_lock);
> > >
> > > +     if (vmhub < AMDGPU_MMHUB0(0))
> > > +             amdgpu_gfx_off_ctrl(adev, true);
> > > +
> > >       if (j < adev->usec_timeout)
> > >               return;
> > >
> >
