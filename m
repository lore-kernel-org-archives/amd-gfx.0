Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB3AEA7942
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 19:17:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 713348903B;
	Wed,  4 Feb 2026 19:17:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CDtXQUll";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B088903B
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 19:17:23 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-2b807f85e10so8807eec.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 11:17:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770232642; cv=none;
 d=google.com; s=arc-20240605;
 b=OoKRx57p1jLf/6eTxquVgq7Cs+w43fPZgdr6LjJE0T/gdecunt2uz2+IWQ9kMQySDe
 rHvD5CksXx13rYIC9030VKgkK0bBV52E47shcYRY0dCCxHG/DD57g6TaocGcGehSWqVj
 fkBQfnlgePnLiwbiFjJKKD7zoYtW8fdLaBLtTPnD//8IA3v2KQnBw4H7AcU+vs7X5a7k
 uijDROjJGpk/OZaNaKGrIUPzvLTWn5U6/IruI4QwqXR5Ho9K0ymqzhRcuFHDd3Q8Vm7z
 5CpB7QgPJAwitroRa/kWlsE79AFiJ9QIlhb1LXFeQhFZQRtb4ylR1MZVMvbrR5RjAWhq
 65yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ds9hjX/1kFa/sFXBh6wyGgKsB+DvyIu4lHPiL1CrkBM=;
 fh=naLreuo3ZXHhrP83MX801wwMaLPbXSMZsTpYwMhLm9M=;
 b=Rrm3DGONShcpeu30u3rM48rfBmJbEi4ye6B7e9e7ur1tFPTGr7ONMo/IaBi/jKt0Rr
 2Sci2tW51gNMw9eIpNaK+WHH+XUuexOT6wMZ2990kN8WmZrGgdeReXcApQByoi7LDSQ1
 8gPast+gQBBnMtImzc2mPOYum25Vhz5k92qOcFmpQ1UP/IaPnuBmFo3OPQFC+jUklMLI
 tNEseq+6Ms9iwI/Tbc3+rgq8io7uF18wX/CNmzWzENfECt8pP+KnoCnMtV4DVpL0rj+n
 kK1P6wCKI1v2DPBI03cbZHyjvQG6nfPC1/ETHMogpvae/IL2Acm93iEnSRv9pMh5RP8D
 /lsw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770232642; x=1770837442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ds9hjX/1kFa/sFXBh6wyGgKsB+DvyIu4lHPiL1CrkBM=;
 b=CDtXQUllsp9ku5uXC8cO7IyHyU8jn2nNdeu16PFJfd70jPUxYgMyO49V9YyjjTKmga
 fjCO0J+8VgFK6sJr5MMJUgfN3RHyQ+16xTaTw+vaE9deFp9y7uGdaGoc7uQOTwuFfT0/
 /+FNFbC9ksl19JVsN7GzBe/vyjl5kIIfwE1GHRolZkCkS3JJKl62PlMyT2eMUDXKMLzO
 epNLkAU+JqABcqybPxWwgBtlHLRdiF2xEhHwIAfBvsGG278QRuAKnxpdoNow+RQY78Q0
 QDUG4XmGgvkctqRAd5RdNkNNzZXrtm4xg4AYfHfqk9AMbyfYGdzh9jXsH+3QmQ7ihwqf
 O0nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770232642; x=1770837442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ds9hjX/1kFa/sFXBh6wyGgKsB+DvyIu4lHPiL1CrkBM=;
 b=A0wepng9kiiZhKf0cCVCZQ/2ygtJzBnfB2JaguJjtgpESRICTWlBv9xhc9cKFgMvWe
 2DuaPtVzfkbm3HgDVJlbqOZ5X3suxW9HjvAUKvrfrC4hVwBH0Ty2vtta1XS0cCmz6vyk
 0ZAhKNFuIBbkkgd0zgqINS6NEd5Jt7qr9weAcuDSM6dt4m0oPdatZ1C/vBgKF7bt6KXy
 QjRksN+4BP4bl0fVnYPFXa1bA5GTPApTaDfgLukubG7rLyxHzGxq97toNyDt9Cu1t3lh
 7QmksPWMC2pWahwd2TisPjvTWMbLwm89MseESqtiZ8Nk8YY3tIQB5HkzJeOvG5BYlg0z
 yCGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7n0i0T9V2eV9a4+AV0WhM8OKYg7/Ajae0ES16K8ZwXpRqmrYalRVwFNIwQK0hvTt7+H7IMakM@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyTEzgDbbiKII8nSLhc3+5eZ0pEnAELbpzHSZKRxTAXWeqvR1Kr
 K96qjUi366X9ISsXvh0Jb7K4db779wJ2N2p5O5f35q7CB/6VovOcEnno6UstN9GSnPr5jzGo3ZS
 JBKRjqLxziG70+J7xCiDnzA+Q/2Ky/rs=
X-Gm-Gg: AZuq6aIS/vMLWhgtzjsw6GQRdNqiqyhjKzKtCmZanr5mmqH/sBuEE8KnrlrjB5GMRFF
 /swqJ7g5ZYDCUwUpHn8pWzG5Lrna4DbWfkfh9vAEg0jEjkHpvysu4PNuEYDzsu7R0evhuCuPVBd
 gkapJ0T3uBeJ1X2WYZdlvDuz+xEQfKJvsrxO/TyLq1/kjCbaWK+u0hhhPB7/MeQvmBoSGmLh7BR
 oYeiY+MRG22w9rc3dNNjmV6Q0k/BdNCkGPFl7J3VIya2fUR0CJEww/AHaktwCc1Gnovn+7g
X-Received: by 2002:a05:7022:f009:b0:119:e56b:c3f1 with SMTP id
 a92af1059eb24-126f4781f80mr1056512c88.1.1770232642405; Wed, 04 Feb 2026
 11:17:22 -0800 (PST)
MIME-Version: 1.0
References: <20260204030621.33369-1-Pratik.Vishwakarma@amd.com>
 <91d64450-96dc-4d3c-af8d-3891647eeabb@amd.com>
In-Reply-To: <91d64450-96dc-4d3c-af8d-3891647eeabb@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 14:17:10 -0500
X-Gm-Features: AZwV_Qj-4gulFv8PkkhH87HfnbbL6g4J4uWAHvg_2IAX4PX_vnshIw1kToCqdw4
Message-ID: <CADnq5_NMFsbB7kfD9oCipksMwhDxZP+sz7Kq9aLuTf=QARRxpQ@mail.gmail.com>
Subject: Re: [PATCH 01/13] drm/amdgpu: Skip SMU init for backdoor loading
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, Alexander.Deucher@amd.com,
 amd-gfx@lists.freedesktop.org
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

On Tue, Feb 3, 2026 at 11:12=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 04-Feb-26 8:36 AM, Pratik Vishwakarma wrote:
> > Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
> > ---
> >   drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/dr=
m/amd/pm/swsmu/amdgpu_smu.c
> > index 9f52b7b24198..fc68dffdea98 100644
> > --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> > @@ -1909,7 +1909,10 @@ static int smu_hw_init(struct amdgpu_ip_block *i=
p_block)
> >               smu->pm_enabled =3D false;
> >               return 0;
> >       }
> > -
> > +     if (adev->firmware.load_type !=3D AMDGPU_FW_LOAD_PSP) {
> > +             dev_info(adev->dev, "Do minimal SMU init for backdoor loa=
ding case\n");
> > +             return 0;
> > +     }
>
> This doesn't hold good for all SOCs.

Yeah, I would drop this one.

Alex

>
> Thanks,
> Lijo
>
> >       ret =3D smu_start_smc_engine(smu);
> >       if (ret) {
> >               dev_err(adev->dev, "SMC engine is not correctly up!\n");
>
