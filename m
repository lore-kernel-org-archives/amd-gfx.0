Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8A44C71136
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Jun 2025 16:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DA1B10E296;
	Fri, 13 Jun 2025 16:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bXshBAOb";
	dkim-atps=neutral
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com
 [209.85.216.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CABD10E296
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 16:08:26 +0000 (UTC)
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-313862d48e7so405426a91.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Jun 2025 09:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749830906; x=1750435706; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6vdclgRuRlQH/N+z/oRUGeXg6R7Kna2AN2tXZaf8It8=;
 b=bXshBAOb+3sppT5oVg8ujH0n8pIDW/HgO/f1wXY++nKnzxSm5S3bYXLoy4vl/Zh8fY
 OVSz5APplcuwxr9Y0MX7DDUYAk84D86L+ugfDkjdODzEuoyqRiJTp3L8w/ZYJGEjeGGC
 DaFduWgQqn+utwYDe+TOqscUmmONMFThXsMKujAQxdtwpW3kSPWLk63GhOts6JKrIo2U
 ZgmJYq9Dh4Fh2g1waG5ffxEXZ87kZnVcnQ0a14aeFsppUne13Quawa1oLrYQRRMdrI35
 E1ugRLp85hgP509WmKcMsmGGX1l6IWksfVwwefUOUvXLYheL3YcEdFVStY8XaBf6lyyR
 JmPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749830906; x=1750435706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6vdclgRuRlQH/N+z/oRUGeXg6R7Kna2AN2tXZaf8It8=;
 b=kaaqp4AfPKvOzmyJaNR1tL1Sj9VWWwVAtSQl+/T69VR1TxCybCYQ8YSvhife+e7jAu
 V5ewg+Ty92TpX7aL2UIR6kmQtLrBtYByvnI9OcUsetc3rX/IMpgyzTsosX4wZ85x//pE
 q95QKj5MvdtMCyVoNHrO7Yo6Dq/LF4almZYM/mr+wp+XkhsNDd2r0fXdJH1JkTH1e713
 lZbiWdbcX6AHL0i06DEcjqomnac32gJvr2+sRaUHb6JInWvcgFfpSIj3aD1wpQ76RQIV
 yW3gJ51k8pRPnMS0bKiV7Bk7r+r6zX7x1LUAeum2IGdH7qrig7OeauT/3mVKIgUvC/6C
 ZYuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNQdV8f+X8n8dwF+yZpHKr2m7nShAYzoBcaflBWlPthYfRn1mJ8Ttc3x4oe21AAsBkJItXvMU+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwPyVIehurYWpAogaZixJHdF8jUIpkv6voKdqzrydHSEl7FJgof
 pfZdt2eeLu0E2CoAFDOvf7erkzNUSC+mp4goK/RrSTFiLwt/U4mkHccufBcdSQbrd5K3gSX67C9
 0xFPxL6rQN0qensCnGaCKzEngaNrq0es=
X-Gm-Gg: ASbGncv90dcBgY1ihe6LPpU/yaO1nElQL1ONpCEuSYlca1hl67+Vmjr7K9j+RroO9rg
 9I4HvTZenAa2w9XEUnILmeHPV7hfFYROdPuL0z+JRpC2TWlW5Q+17kICF6KluBtzHqQTpzGczyA
 eAaiwtAPMzUiobbRJXsJQsUwhG7H2GMKPYyB9DSHt9r7WUsdkRN6eDdsw=
X-Google-Smtp-Source: AGHT+IGiB4GLrRWOvnxdnMdGsJqdVEBz+GBwRBHnzLrmE4MisPvijVL6ksDUBokS7add1jbYj2Bg2I6uq+jcFIFxBA0=
X-Received: by 2002:a17:90b:540d:b0:312:1d2d:18f8 with SMTP id
 98e67ed59e1d1-313f1e50e63mr115127a91.7.1749830905308; Fri, 13 Jun 2025
 09:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250613144203.441129-1-kenneth.feng@amd.com>
 <CADnq5_PNf903HaK9eieL3w_tWXOfHzY7sQgivfskyvRwh8L4gw@mail.gmail.com>
 <32b2591e-9629-4f9c-8c3f-233b1bd9ee67@amd.com>
In-Reply-To: <32b2591e-9629-4f9c-8c3f-233b1bd9ee67@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 13 Jun 2025 12:08:13 -0400
X-Gm-Features: AX0GCFtCOfsa6Xo566l5B2JEvui08DpBAatNmmYdjqhw9v8oDoaj2Qidg3WCiRg
Message-ID: <CADnq5_Mh8=J1M+onEfdAq76jH1yHvJdcN9ww64imOHmoB1QYGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amd/pm: move the dpm table setting back after
 featureenablement
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Kenneth Feng <kenneth.feng@amd.com>, amd-gfx@lists.freedesktop.org
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

On Fri, Jun 13, 2025 at 12:06=E2=80=AFPM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 6/13/2025 9:31 PM, Alex Deucher wrote:
> > On Fri, Jun 13, 2025 at 10:42=E2=80=AFAM Kenneth Feng <kenneth.feng@amd=
.com> wrote:
> >>
> >> move the dpm table setting back after featureenablemend due to dependa=
ncy.
> >
> > What is the dependency?  Can you provide more details?
> >
>
> For SMUv13.0.6, there is no pptable. We get all the frequency tables
> from FW during this callback. Those frequency tables are available
> through FW metrics and it needs DPM to be enabled.

Thanks.  Please add that to the commit message.  With that, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Thanks,
> Lijo
>
> > Alex
> >
> >>
> >> Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 22 +++++++++++-----------
> >>  1 file changed, 11 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/d=
rm/amd/pm/swsmu/amdgpu_smu.c
> >> index 824fcc6dd32a..cf4ac3914b68 100644
> >> --- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> +++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
> >> @@ -1687,17 +1687,6 @@ static int smu_smc_hw_setup(struct smu_context =
*smu)
> >>                 }
> >>         }
> >>
> >> -       /*
> >> -        * Set initialized values (get from vbios) to dpm tables conte=
xt such as
> >> -        * gfxclk, memclk, dcefclk, and etc. And enable the DPM featur=
e for each
> >> -        * type of clks.
> >> -        */
> >> -       ret =3D smu_set_default_dpm_table(smu);
> >> -       if (ret) {
> >> -               dev_err(adev->dev, "Failed to setup default dpm clock =
tables!\n");
> >> -               return ret;
> >> -       }
> >> -
> >>         if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT_GEN5=
)
> >>                 pcie_gen =3D 4;
> >>         else if (adev->pm.pcie_gen_mask & CAIL_PCIE_LINK_SPEED_SUPPORT=
_GEN4)
> >> @@ -1739,6 +1728,17 @@ static int smu_smc_hw_setup(struct smu_context =
*smu)
> >>                 return ret;
> >>         }
> >>
> >> +       /*
> >> +        * Set initialized values (get from vbios) to dpm tables conte=
xt such as
> >> +        * gfxclk, memclk, dcefclk, and etc. And enable the DPM featur=
e for each
> >> +        * type of clks.
> >> +        */
> >> +       ret =3D smu_set_default_dpm_table(smu);
> >> +       if (ret) {
> >> +               dev_err(adev->dev, "Failed to setup default dpm clock =
tables!\n");
> >> +               return ret;
> >> +       }
> >> +
> >>         smu_init_xgmi_plpd_mode(smu);
> >>
> >>         ret =3D smu_feature_get_enabled_mask(smu, &features_supported)=
;
> >> --
> >> 2.34.1
> >>
>
