Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EEBCC04FFE
	for <amd-gfx@archiver.kernel.org>; Fri, 17 May 2024 15:52:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A56CA10E1C4;
	Fri, 17 May 2024 15:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CmgIUJR0";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214C510E1C4
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 15:52:57 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-1eb0e08bfd2so13191365ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 May 2024 08:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715961176; x=1716565976; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObbQlGpTB7xl7ByYBsQj2A74YM4jKhwa5hKoRO6ApuQ=;
 b=CmgIUJR0xWvzElexln1oMvCut0wjKAr3Wekg3NHASeZyI4Q7k+Hycfl+xeowcfnNtQ
 wHkQbPPsA5RSh2LOcYsdwxmKWFgE7yFbpf3kS0Mnww7DsiFy6s9ysys5Zk2Kx5KCY5iW
 /AWAGYG+yZAHuXgfHvlIBo8/SD+XgP/DrSGRgL8sW6+VcMZg4SiwX6tfZGdzjA2pE3tw
 saH2/kXBIAq2U2u6jOd3MaLib4vdJezo7N4ajT0VxRnn8ZID+k8Lc/4ILFbzcrpye9BX
 g9hKXT5FNPQsclG7h0G2jbMpShhCDQu2Bd18pG0CZEvlDY5iet/B379NlRt/pr33a/22
 mqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715961176; x=1716565976;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObbQlGpTB7xl7ByYBsQj2A74YM4jKhwa5hKoRO6ApuQ=;
 b=aqJccLORSFEXoGgaAY9WsONk4kBLip+cAEB139HwpQGLtw9TdaGRS0Gz9BXI9gcq9V
 C72NWvfhIiePTwiwZVZHO2zQQrLLSi5tQ/QvDyHEdxkLM5o3tWrpLtXtHRmcVaJkJGqn
 5Hz2rJ2NnfVNatQeedeW47zc92DIqQHKgxVDzGgen9xVke8lRsBjCLsRRhHttbsief64
 H4lNo+D4VJzjjenkJRzR/Fv+XoO6n/Wki60cx8huw+QV/b+LtTlGaXodP8KvukiAZI92
 t1o1Y0F62q3m+KXr2vGvaHUCEKNi/3tBFV4P/B/4G9Jjd664F2nS+dED3vrES7CSi221
 tzNg==
X-Gm-Message-State: AOJu0YyiCI6eJcvMBvJeSHPdRoCKnzjQcyHerqiGWxhpm7RlGwcUdbgq
 OSkdzSrEN3+lPAVavZVouLAgU8MFOovbpLO27ve2hHbuY+hvVLfIhJMSRDjbQ0zBH+bEx5Qrits
 EHrPsOriotLb08X+NDxCMg52a//xfkQ==
X-Google-Smtp-Source: AGHT+IEZ6rDtkH4Mrt2YlStBceg4Ytc90/gJfh7iNd51Jf5MwZRsFqrbKTefMEVx0r0NG+ZsT2b9QpIefkx2bUIfc6w=
X-Received: by 2002:a17:90a:778c:b0:2bb:b23e:14d7 with SMTP id
 98e67ed59e1d1-2bbb23e30c5mr5314226a91.26.1715961176517; Fri, 17 May 2024
 08:52:56 -0700 (PDT)
MIME-Version: 1.0
References: <20240517070011.2253488-1-shane.xiao@amd.com>
 <CADnq5_PXY+nx-RVjxmjpjEFSjGSTQpCp0MYJB8yRJwJKx=CNwQ@mail.gmail.com>
In-Reply-To: <CADnq5_PXY+nx-RVjxmjpjEFSjGSTQpCp0MYJB8yRJwJKx=CNwQ@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 17 May 2024 11:52:45 -0400
Message-ID: <CADnq5_M0f6nSsn=8n82nabMYBjoPJrjPEVZtF8++mLePqn6WCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Correct the GFX12 memory type setting
To: Shane Xiao <shane.xiao@amd.com>
Cc: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com, 
 sreekant.somasekharan@amd.com, Aaron Liu <aaron.liu@amd.com>, 
 longlyao <Longlong.Yao@amd.com>
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

On Fri, May 17, 2024 at 11:51=E2=80=AFAM Alex Deucher <alexdeucher@gmail.co=
m> wrote:
>
> On Fri, May 17, 2024 at 3:07=E2=80=AFAM Shane Xiao <shane.xiao@amd.com> w=
rote:
> >
> > This patch fixes the GFX12 memory type to NC. Since
> > the Memory type can be overwritten by the previous
> > operations, the GFX12 MTYPE bits need to be clear
> > before setting to NC.
> >
> > Signed-off-by: longlyao <Longlong.Yao@amd.com>
> > Signed-off-by: Shane Xiao <shane.xiao@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v12_0.c
> > index e2c6ec3cc4f3..6246d1dc0d30 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
> > @@ -534,7 +534,8 @@ static void gmc_v12_0_get_vm_pte(struct amdgpu_devi=
ce *adev,
> >
> >         /* WA for HW bug */
> >         if (is_system || ((bo_adev !=3D adev) && coherent))
> > -               *flags |=3D AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
> > +               *flags |=3D (*flags & ~AMDGPU_PTE_MTYPE_GFX12_MASK) |
> > +                       AMDGPU_PTE_MTYPE_GFX12(MTYPE_NC);
>
> Maybe we should make the AMDGPU_PTE_MTYPE_GFX12() macro clear the
> current field before setting the new one?  That would align with the
> similar register field macros.

Same comment for all of the MTYPE macros for all generations.

Alex

>
> Alex
>
> >
> >  }
> >
> > --
> > 2.25.1
> >
