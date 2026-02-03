Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9C7FE87835
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Feb 2026 14:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7776110E660;
	Tue,  3 Feb 2026 14:09:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U1LnQMyX";
	dkim-atps=neutral
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF4410E65E
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Feb 2026 14:09:52 +0000 (UTC)
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1233608c7e9so320975c88.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Feb 2026 06:09:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770127792; cv=none;
 d=google.com; s=arc-20240605;
 b=PRGzh7TvjLl/E6goNTsWBs4lBc9eo1RE9CyDI7kaKFsaUuMKUp2lgmlaYzzmSoO8Cu
 oPu77gc/pAyo/ovdlGpH3SNuh42sGnjF7SQAij9maN9vyqYWu7KRla1i91ZAtmrW+5nc
 P9PuOhFXFMJbQADCK+zXdosBQLBeYtGfBLcQofflTUD8FtjGNBHb/vd75gsJPIOboWEX
 m0TF2T89cPPiCPrX8KkvanwVguH9QhIX9opR9baoTjQeXINxPLU69pw7lg+XEr3/NfeL
 1zynqAb6nrpFUJ/0AUTR8kLeGQIpnYC0yGtiBdOwY0Bc4cvCgWLaCpY0sLKdOYcqtyps
 p/bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bI720VPwjEpCdcMBu7oRckBF8mcEf2jKo3EjF7vdZFw=;
 fh=eLETJQUWJWAkOM2sXDzFT8JBP8bLYFHao9rHC9tL2hQ=;
 b=gQ5Dvv4MizXU0wXisY/WwARc7xyF5zUZLvgGWZgKhheuRWuW7JmQWY4eHT4k7p3YNh
 rctch9DMmznI3Nvn9ZIJdFa6HAZVupKAsxO6+VhqGD7g1+OeKCalWpq8QnkDpOfCzol9
 y9bv3dkXrzWSEK6gSyqGJpSQf5mxsS8p967DrJzVwtg/yaJL27KlsVx/Syl/LZgffoT8
 laF7+mHVi7jbebIV37da8slYuVCCGZiNvdb9kYSb9VR7Fn/64E/bNs+O+BYmLXHjl/lM
 o86fyh8q5hZU1JMxBhxsZkbGRl0vIKjy3x9byj5IBKSq5phNCac/hNHU9keTfS0QqWTw
 QqSQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770127792; x=1770732592; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bI720VPwjEpCdcMBu7oRckBF8mcEf2jKo3EjF7vdZFw=;
 b=U1LnQMyXPAOjXbpjlmsnhGqUDAx4S+cLJnMnA6AvjgXzU8d77uEapnD9HCOPtLbjLJ
 hdoPiHwrrg4VswZMZMPiMKclfz1cWuJsGf6fs/FD1sMzthsHMF7Cm3NIOTxwaznQeMwp
 O1ftURDD/0cSmq7ohdGx7Y0lz84Q41IsgKAtOCzXPcuneI5/hflqdUfcU0l6sZzwi7uf
 +iF/7jhNiW5wyu68SXWowkgY6Tzkz7iUy4CN6C1fHVITtRi3wtoxUsXayPOnTrbjg4rA
 ANwFpcc7XNBFjS7Xw7Uce0XHJkUFg/KmfNFD9jTnYr8XZKhn0EmUZnKeNoXvW+DnLQ1O
 sUwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770127792; x=1770732592;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bI720VPwjEpCdcMBu7oRckBF8mcEf2jKo3EjF7vdZFw=;
 b=DSuxO2xaeSG5PnGpq3SWjcNOEQFAXavjHdwzA6hnB5giMU+ntUq/cViQ/QeVUWGbo5
 fTggAKdQ5okkuF2clROQvJYadQah20xHJa6kyxTSxJzC4zLBeZiLYuBNpdRJRG9aUhcN
 gaq5aIvIs038Bze/ZycpEiOLDjRm1X8HF81WJlE8eoqhf1iVFLiGqHQUYFZjGiXjrb4G
 6io5C8r8llp0I9q7xssuRt6+H/gOROxQubwBhglzDzUSxxBHetcHkAFjCMAWbyeEYuVv
 TYn2lWsY9s68oCHTPQF2sMZnobqj/pkIMg8PRYyXyni7QDNy/Z7VJxIZMHl6Ml8UePV5
 MuFw==
X-Gm-Message-State: AOJu0YxARZlyyxzcLnUg78T82dPH8Mzw0IKbRhAi3qC2sEeRrdMg0NB7
 rRpKxB8sQTpC3k151O6wd/tl3tH4rzgafuJe5YnksvkZ6wY4sN9rP/nV1qMBXrPGX9t6NCVqiaD
 HT4+ezfJIWl+mk432yNf96oA0KXIFIak=
X-Gm-Gg: AZuq6aImgQgmfJm6o+8KCqe3BNfhrmunnpD9EhI52/UrHL7khTizy1/taCgWEnFLgyK
 KP1A+9G4/N6hwuvuIIAVIKisgwl+bDXmsJcIygkocfKdcJqWJZf0pff2WQqckxyT36aI37nYq2m
 6o993z0lE9W32Sw+efMfP1RzFuzTOMg71BMJ8/unVAWn9mYaf0R/Gx+ynqNQ3AE3ewSqWhKSI1i
 4J9I5ZCofJmQprcblSov6jnGpSfr7SD1RJUczoT8S5DpheA4JpYENvGxthiDtjS8y1JWLx8
X-Received: by 2002:a05:7022:ef14:b0:122:33e:6ec1 with SMTP id
 a92af1059eb24-125c0f0dcf8mr3306250c88.0.1770127791821; Tue, 03 Feb 2026
 06:09:51 -0800 (PST)
MIME-Version: 1.0
References: <20260203085706.450079-1-Jesse.Zhang@amd.com>
 <20260203085706.450079-3-Jesse.Zhang@amd.com>
 <CADnq5_OxS6_LmZTNS41TzDz8kJA6QkdZpmWMvynA93hNceR9sg@mail.gmail.com>
In-Reply-To: <CADnq5_OxS6_LmZTNS41TzDz8kJA6QkdZpmWMvynA93hNceR9sg@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 3 Feb 2026 09:09:40 -0500
X-Gm-Features: AZwV_Qh7qwIVeivCm8kpNUoFUTXfVp6gM57ojIpTuVMf467_N0TcAsL_hOy8P_U
Message-ID: <CADnq5_MtCRXbspbqndRuaqzvHutJdVcjJfAbL0WYZzPUAuaNHg@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amdgpu/sdma_v5_0: Update per-queue reset fw
 version checks for 5.0.x ASICs
To: "Jesse.Zhang" <Jesse.Zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Christian Koenig <christian.koenig@amd.com>
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

On Tue, Feb 3, 2026 at 8:43=E2=80=AFAM Alex Deucher <alexdeucher@gmail.com>=
 wrote:
>
> Series is:
> Acked-by: Alex Deucher <alexander.deucher@amd.com>

Since the HW team said there is no firmware requirement, I'm also fine
with just dropping the switch statements and just doing something
like:

+               if (!amdgpu_sriov_vf(adev) &&
+                    !adev->debug_disable_gpu_ring_reset)
+                       adev->sdma.supported_reset |=3D
AMDGPU_RESET_TYPE_PER_QUEUE;

Alex


>
> On Tue, Feb 3, 2026 at 5:07=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.com> =
wrote:
> >
> > Tune SDMA 5.0.x per-queue reset firmware version thresholds for specifi=
c ASICs:
> > 5.0.0: Require fw >=3D24
> > 5.0.2: Adjust fw threshold to >=3D30
> > 5.0.1: Add new check with fw >=3D38
> >
> > Signed-off-by: Jesse.Zhang <Jesse.zhang@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c | 23 +++++++++++++++++++----
> >  1 file changed, 19 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/a=
md/amdgpu/sdma_v5_0.c
> > index d72bd3adfccf..72492692f680 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
> > @@ -1432,17 +1432,32 @@ static int sdma_v5_0_sw_init(struct amdgpu_ip_b=
lock *ip_block)
> >                 amdgpu_get_soft_full_reset_mask(&adev->sdma.instance[0]=
.ring);
> >         switch (amdgpu_ip_version(adev, SDMA0_HWIP, 0)) {
> >         case IP_VERSION(5, 0, 0):
> > +               if ((adev->sdma.instance[0].fw_version >=3D 24) &&
> > +                    !amdgpu_sriov_vf(adev) &&
> > +                    !adev->debug_disable_gpu_ring_reset)
> > +                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TY=
PE_PER_QUEUE;
> > +                       break;
> > +       case IP_VERSION(5, 0, 1):
> > +               if ((adev->sdma.instance[0].fw_version >=3D 38) &&
> > +                    !amdgpu_sriov_vf(adev) &&
> > +                    !adev->debug_disable_gpu_ring_reset)
> > +                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TY=
PE_PER_QUEUE;
> > +                       break;
> >         case IP_VERSION(5, 0, 2):
> > +               if ((adev->sdma.instance[0].fw_version >=3D 30) &&
> > +                    !amdgpu_sriov_vf(adev) &&
> > +                    !adev->debug_disable_gpu_ring_reset)
> > +                       adev->sdma.supported_reset |=3D AMDGPU_RESET_TY=
PE_PER_QUEUE;
> > +                       break;
> >         case IP_VERSION(5, 0, 5):
> >                 if ((adev->sdma.instance[0].fw_version >=3D 35) &&
> > -                   !amdgpu_sriov_vf(adev) &&
> > -                   !adev->debug_disable_gpu_ring_reset)
> > +                    !amdgpu_sriov_vf(adev) &&
> > +                    !adev->debug_disable_gpu_ring_reset)
> >                         adev->sdma.supported_reset |=3D AMDGPU_RESET_TY=
PE_PER_QUEUE;
> > -               break;
> > +                       break;
> >         default:
> >                 break;
> >         }
> > -
> >         /* Allocate memory for SDMA IP Dump buffer */
> >         ptr =3D kcalloc(adev->sdma.num_instances * reg_count, sizeof(ui=
nt32_t), GFP_KERNEL);
> >         if (ptr)
> > --
> > 2.49.0
> >
