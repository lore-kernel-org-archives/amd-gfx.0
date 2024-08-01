Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9140DC3DA4A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 03:24:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44EAE10E883;
	Thu,  1 Aug 2024 03:24:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FJhosiNS";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7853D10E883
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Aug 2024 03:24:26 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-a7a9cf7d3f3so785812666b.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 Jul 2024 20:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722482665; x=1723087465; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/K4BNaqnEzsW7A/474sc9pZ92VwwlKWWcF7ft2em3o=;
 b=FJhosiNShI3DVZ32osph+a5BdRSH43yYlz/uTeOSHQM3wK++KnPcpXaN93cwTndAEd
 0ZoUJ+jo51/BFVIaRqx6RNOxh7NIzcuUe708goHMD+K0mH1qs/ZUiCzp724ZGDT0sdEp
 KNXs/Jw9+2i7D+pMo+4UFyMayWmcg0utXvTMf83DW41hq3eIBM9mYTLAq96tYoYs99h7
 JdB/3kP/a5cHKEkotGVoA1BS3NcrYsEAE0B4S9BumEVCtqSpx1R8f+omJ4Wax26PL3X7
 UGEin0VWK44B3HfA8/qWqFBBpeyBxXuRy2TviSNCNsKu2ODMxn9/5q7M0zqgWuX62STz
 ycjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722482665; x=1723087465;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O/K4BNaqnEzsW7A/474sc9pZ92VwwlKWWcF7ft2em3o=;
 b=Y/NraTwq41e/IETGiucg4s0TWI5fz0hlREnrRqgHgBHVU2BmIhASNx2oHD2iJw9WP6
 Itzr07sokALD5yO49RdeiosE8E0FLzvSX0NGOF/wcRu16L8ORv49bnmNRP77HgDL7hTB
 mMgpn+dBo+vnHnvQ6LEu3P6IkB4gopynTSVPUClq+VF/C7L/n+FpfpMf6BujsBNlifNZ
 XOEhoFPiir/KIBew/L0tiSNoMn9WJQA//chxF0EjEDcR6IjBAzFEseqXX/1jtMTIxV8t
 8sh2W7Glwxt7eCLi4oYizE+RPH+7C6sY9MpjdrjTpVpAM4ejrsBRsRg3RfwdHPdE0FAu
 skaA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6H3bHjX0w7SBBr4k6irlYOjrOISVnnrl3876XmYjwlr9TIsPBmytSzS5I5dO/GVKzsbjCssmireMOv3QwFKLYSivr7R//ESc+BjaPkg==
X-Gm-Message-State: AOJu0YyTGW5fNNOlBNg3tu6rrDuOWS9ZjrhqxWTKDjYZGzGEEhYi8BGI
 qoZXM7vwq0VJjjbfsW96MYMPaxvv0tW4oD2FiiisoOO4GJHkeSYzFYxDHRnMdjcwHlOYFEGfqcg
 0RFsKKzELbca5MN6wRTmy8Wf5hEthb3KH
X-Google-Smtp-Source: AGHT+IErR179YIUbVHeryEzSbf+rB0KwGVPLUmUIKEdLA6ci23wevxweFYul0Cr4t+a93lhcnWb4C1vjAwkTvbn6NCI=
X-Received: by 2002:a17:907:8688:b0:a77:e7b9:fda0 with SMTP id
 a640c23a62f3a-a7daf288c01mr71931666b.14.1722482664585; Wed, 31 Jul 2024
 20:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240731131252.354336-1-sunil.khatri@amd.com>
 <20240731131252.354336-4-sunil.khatri@amd.com>
In-Reply-To: <20240731131252.354336-4-sunil.khatri@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Wed, 31 Jul 2024 23:23:48 -0400
Message-ID: <CAAxE2A7exVXYeUzL19AxGyFyA5jv43RoenC9F0Prgjb7Aqwk+g@mail.gmail.com>
Subject: Re: [PATCH v1 3/3] drm/amdgpu: optimize the padding for gfx_v9_4_3
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Tvrtko Ursulin <tursulin@igalia.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>
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

On Wed, Jul 31, 2024 at 9:13=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> Adding NOP packets one by one in the ring
> does not use the CP efficiently.
>
> Solution:
> Use CP optimization while adding NOP packet's so PFP
> can discard NOP packets based on information of count
> from the Header instead of fetching all NOP packets
> one by one.
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Cc: Tvrtko Ursulin <tursulin@igalia.com>
> Cc: Marek Ol=C5=A1=C3=A1k <marek.olsak@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_4_3.c
> index 98fe6c40da64..c4832a5725c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
> @@ -4178,6 +4178,24 @@ static void gfx_v9_4_3_enable_watchdog_timer(struc=
t amdgpu_device *adev)
>         amdgpu_gfx_ras_error_func(adev, NULL, gfx_v9_4_3_inst_enable_watc=
hdog_timer);
>  }
>
> +static void gfx_v9_4_3_ring_insert_nop(struct amdgpu_ring *ring, uint32_=
t num_nop)
> +{
> +       int i;
> +
> +       /* Header itself is a NOP packet */
> +       if (num_nop =3D=3D 1) {
> +               amdgpu_ring_write(ring, ring->funcs->nop);
> +               return;
> +       }
> +
> +       /* Max HW optimization till 0x3ffe, followed by remaining one NOP=
 at a time*/
> +       amdgpu_ring_write(ring, PACKET3(PACKET3_NOP, min(num_nop - 2, 0x3=
ffe)));
> +
> +       /* Header is at index 0, followed by num_nops - 1 NOP packet's */
> +       for (i =3D 1; i < num_nop; i++)
> +               amdgpu_ring_write(ring, ring->funcs->nop);

This loop should be removed. I explained the reason in the gfx10 commit.

Marek

> +}
> +
>  static const struct amd_ip_funcs gfx_v9_4_3_ip_funcs =3D {
>         .name =3D "gfx_v9_4_3",
>         .early_init =3D gfx_v9_4_3_early_init,
> @@ -4227,7 +4245,7 @@ static const struct amdgpu_ring_funcs gfx_v9_4_3_ri=
ng_funcs_compute =3D {
>         .emit_hdp_flush =3D gfx_v9_4_3_ring_emit_hdp_flush,
>         .test_ring =3D gfx_v9_4_3_ring_test_ring,
>         .test_ib =3D gfx_v9_4_3_ring_test_ib,
> -       .insert_nop =3D amdgpu_ring_insert_nop,
> +       .insert_nop =3D gfx_v9_4_3_ring_insert_nop,
>         .pad_ib =3D amdgpu_ring_generic_pad_ib,
>         .emit_wreg =3D gfx_v9_4_3_ring_emit_wreg,
>         .emit_reg_wait =3D gfx_v9_4_3_ring_emit_reg_wait,
> --
> 2.34.1
>
