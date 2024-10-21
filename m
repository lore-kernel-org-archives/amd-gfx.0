Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B207AD15D9F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Oct 2024 14:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 496B810E541;
	Mon, 21 Oct 2024 14:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nW05IX0D";
	dkim-atps=neutral
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com
 [209.85.216.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 279CD10E53C
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 14:36:52 +0000 (UTC)
Received: by mail-pj1-f48.google.com with SMTP id
 98e67ed59e1d1-2e5b1aaad96so278305a91.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Oct 2024 07:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729521412; x=1730126212; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sOpjzNyvMpPWbahooa9eDNIa5Uuf0DnXWGc2RnczUaA=;
 b=nW05IX0DPp2yXix3YotIx37Kz/+bMo6vVBKqB/1Siydlv+aOVXwK6fZswh0zWRspVg
 +d/SIgulgJ9sM72YcrUoac/M5vVcgjZEZCh/ZT20qWBc8llatoLOWDlbpVXX5wS+koGW
 KaUVGT6vtSl6QS12rekv/9CjwEYRf13JPgbPq9QyoXzzTB8jGv8SjPC4igjQREbYdUM+
 WQxXjmGzilwliChBC5WbFehOcaUPZ8No7sFc81SDzJxAZwbIUhfoCB7lc6u1mGwWLMRI
 hdgWIBsxLZOu4Ul9XMpQUS9+C/scS/HGTG+hwNV5FMDiThqqG2jkTeC3S5NfEd8hsmV5
 6cqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729521412; x=1730126212;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOpjzNyvMpPWbahooa9eDNIa5Uuf0DnXWGc2RnczUaA=;
 b=VeJWiygEMT0I8voYvZyoDmUyN49iKFWaC8IBXB/vKpgLjIBqZUGe8ZSCP7/wOA5HW7
 pbK2K5SOnGbkyV2PEDoTMcjau+1SqvsEaxgxJv6QiXunPcnWeFMBYb599XegyUf5ditF
 2RqGSdL7Cgh2orULRYw3DPh4W3co/uR+ncIYYdmm4vGR1VSAZ0W4jll/YxlNvN4QoczB
 grCTOrjNs16GeMj13gEGOCuliKtq1hcctAYa4z9OnExwsJnlQQJm22x8ft+WzaMMLgs2
 67p1TLSy/4secZ51lsGGMhzz9/csdihKDfqcH2sO4rryp7FaQdW2r/rw0a2oPIXqbM+/
 nw9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWHzzQQd3PyPYkBRG8I2KFQyJrbiEjTxSlzwswiYx4EUVbV+6QiMbDCnQ0iQ50cHymRgG8ok2LJ@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzkttx9nBKyKr5l37FePa3aipCpV0ehVaQPFvhfAn7TpSCaRqzU
 XYD5EXwh6FhNdofL3USdIyCvcWXzqF91WItHl4TSy4lbmUqiZTiuCJpW9cBRVVAiOAX+VI/h2XH
 rD+xBTFkBHg9kpuLg4KqaoUYPXPjuOA==
X-Google-Smtp-Source: AGHT+IHYlseKLxckhww982k6M9NhVXhBNAQ9vIbCq/N5hCyXk2A1Crd3vqMoVCr0Oaam+1GMy5YNvMkLV4iFBe+0T6U=
X-Received: by 2002:a17:90a:a883:b0:2e2:e545:82c6 with SMTP id
 98e67ed59e1d1-2e5615d6183mr5891623a91.2.1729521411513; Mon, 21 Oct 2024
 07:36:51 -0700 (PDT)
MIME-Version: 1.0
References: <20241018202128.97719-1-kent.russell@amd.com>
 <a0228259-05eb-41b8-96c7-5b604fff0a1d@amd.com>
In-Reply-To: <a0228259-05eb-41b8-96c7-5b604fff0a1d@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Oct 2024 10:36:39 -0400
Message-ID: <CADnq5_OgeR1A=8hsyc00HDU4d=QKarA6d_G0s9Fx0FsCSkWsKw@mail.gmail.com>
Subject: Re: [PATCH] amdgpu: Don't print L2 status if there's nothing to print
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Kent Russell <kent.russell@amd.com>, amd-gfx@lists.freedesktop.org, 
 felix.kuehling@amd.com
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

On Mon, Oct 21, 2024 at 10:13=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 10/19/2024 1:51 AM, Kent Russell wrote:
> > If a 2nd fault comes in before the 1st is handled, the 1st fault will
> > clear out the FAULT STATUS registers before the 2nd fault is handled.
> > Thus we get a lot of zeroes. If status=3D0, just skip the L2 fault stat=
us
> > information, to avoid confusion of why some VM fault status prints in
> > dmesg are all zeroes.
> >
>
> I guess this problem can be avoided if the information is read from IH
> cookie/context rather than from status register.

Is all of this available in the IH cookie?  IIRC, not all of it is.

Alex

>
> Thanks,
> Lijo
>
> > Signed-off-by: Kent Russell <kent.russell@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 5 ++++-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 5 ++++-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 5 ++++-
> >  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c  | 6 ++++++
> >  4 files changed, 18 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v10_0.c
> > index 5cf2002fcba8..5fe7a1c74ff1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> > @@ -175,7 +175,10 @@ static int gmc_v10_0_process_interrupt(struct amdg=
pu_device *adev,
> >                       addr, entry->client_id,
> >                       soc15_ih_clientid_name[entry->client_id]);
> >
> > -     if (!amdgpu_sriov_vf(adev))
> > +     /* Only print L2 fault status if the status register could be rea=
d and
> > +      * contains useful information
> > +      */
> > +     if (status !=3D 0)
> >               hub->vmhub_funcs->print_l2_protection_fault_status(adev,
> >                                                                  status=
);
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v11_0.c
> > index 4df4d73038f8..25a3dee27d81 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > @@ -144,7 +144,10 @@ static int gmc_v11_0_process_interrupt(struct amdg=
pu_device *adev,
> >               dev_err(adev->dev, "  in page starting at address 0x%016l=
lx from client %d\n",
> >                               addr, entry->client_id);
> >
> > -             if (!amdgpu_sriov_vf(adev))
> > +             /* Only print L2 fault status if the status register coul=
d be read and
> > +              * contains useful information
> > +              */
> > +             if (status !=3D 0)
> >                       hub->vmhub_funcs->print_l2_protection_fault_statu=
s(adev, status);
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v12_0.c
> > index e33f9e9058cc..3dee7474c06d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > @@ -137,7 +137,10 @@ static int gmc_v12_0_process_interrupt(struct amdg=
pu_device *adev,
> >               dev_err(adev->dev, "  in page starting at address 0x%016l=
lx from client %d\n",
> >                               addr, entry->client_id);
> >
> > -             if (!amdgpu_sriov_vf(adev))
> > +             /* Only print L2 fault status if the status register coul=
d be read and
> > +              * contains useful information
> > +              */
> > +             if (status !=3D 0)
> >                       hub->vmhub_funcs->print_l2_protection_fault_statu=
s(adev, status);
> >       }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gmc_v9_0.c
> > index 010db0e58650..f43ded8a0aab 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> > @@ -672,6 +672,12 @@ static int gmc_v9_0_process_interrupt(struct amdgp=
u_device *adev,
> >           (amdgpu_ip_version(adev, GC_HWIP, 0) >=3D IP_VERSION(9, 4, 2)=
))
> >               return 0;
> >
> > +     /* Only print L2 fault status if the status register could be rea=
d and
> > +      * contains useful information
> > +      */
> > +     if (!status)
> > +             return 0;
> > +
> >       if (!amdgpu_sriov_vf(adev))
> >               WREG32_P(hub->vm_l2_pro_fault_cntl, 1, ~1);
> >
