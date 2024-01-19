Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFD9C4725D
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jan 2024 14:39:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5818B10E195;
	Fri, 19 Jan 2024 14:39:54 +0000 (UTC)
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com
 [209.85.160.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1546710E195
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 14:39:53 +0000 (UTC)
Received: by mail-oa1-f44.google.com with SMTP id
 586e51a60fabf-210dec2442eso252119fac.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jan 2024 06:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705675132; x=1706279932; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mmm/nAqf1mxeb/ePw174BwMXvzBXD3KAiTlzBYxndrE=;
 b=Up9TqdalejVO4jGGwvejNU2ql/XyhM/Wg9wT4LBB7T362FKtMQktrxheyC6bWjh/C3
 D6Z82ZzflNqVQ1k2ZUmbPV7SnhMfW3kOhseiX5sGCd17QFXFEqWt43Z+wF2CE3TQDJ29
 T/Xv0PHklLTHPCMBgq4idonpxvTRUEpkJaUBodpBj/Y7KRKHJfAN+wyDlo9gc9Q7ltxj
 LulK9Fpy3mAcF+MgbtKpenT90Qi7YtMviDdzHl73yH+HVbJ9XRT09yS1kIN6tD2umpCs
 xUo0QlfI1VeNz5IJvjfNDMfonfGmD2OgOvA+EwPgUuKNDVHzPOWCkfoyylBHOqCbbo0G
 PdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705675132; x=1706279932;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mmm/nAqf1mxeb/ePw174BwMXvzBXD3KAiTlzBYxndrE=;
 b=IXc7qkWMhC9qXbe1u+s6uYau4+y2gei0jfgaMtg9oeBl+FD9VQkrtwc3K6FZprmogC
 EgefP10/F5HXzHJ1Chxd0F+5NrLJVv5aFj+TArmgOG8X7j+T2vxB85SVi68PZiLuixa3
 lBRFrU5NZaxZ2OtcTAl1rbMUszF+nwCoMENSueW1BKC8mp3rhiV664jbIBwzIeYEieFK
 FrriYUx88E3IVRP4GcgM5JkeUeN4+DyCiidT/zWgSHUv9EqmWhuoLEiTebW8JgYfCtwK
 yubfM+tlPAQH1YnKa9R4rGoM4XhsdLS4MdT0I4msW0O45W9vrcmBUyH1eJmrwLFfRJid
 EJ1g==
X-Gm-Message-State: AOJu0Yw/U03maEfUIrCIwF4HX9Zy6Um/qqjwdwCUd+4+MV8RaY6I++tp
 6i6NcGQ/cN9w7B4ncAbznYAU/ChRJ+iPyR6bRrfP8BT+jSp9Wgh9O4trvue0pq2qufcQaGIKyaZ
 wRn5K5rVCL+9wZUm773jGodSu7L8=
X-Google-Smtp-Source: AGHT+IHldIW2TxR1GeACuCnJQpPWtqtzyzyCYj/UP+1e5Fvo4ivyRbO0ndTFuhLE/yqB2PB4XS4obH8nfT2JSiEvc/M=
X-Received: by 2002:a05:6870:5693:b0:210:7f14:e5c1 with SMTP id
 p19-20020a056870569300b002107f14e5c1mr2324345oao.35.1705675132370; Fri, 19
 Jan 2024 06:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20240118185402.919396-1-friedrich.vock@gmx.de>
 <c3d81197-a2a6-4884-832c-d0b8459340aa@amd.com>
In-Reply-To: <c3d81197-a2a6-4884-832c-d0b8459340aa@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jan 2024 09:38:40 -0500
Message-ID: <CADnq5_O6U8DSGJOUk9_sfL2bEUGgLej-nLsVH_ep-2BKZL_Bng@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Friedrich Vock <friedrich.vock@gmx.de>, Joshua Ashton <joshua@froggi.es>,
 stable@vger.kernel.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 19, 2024 at 3:11=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
>
>
> Am 18.01.24 um 19:54 schrieb Friedrich Vock:
> > Allows us to detect subsequent IH ring buffer overflows as well.
> >
> > Cc: Joshua Ashton <joshua@froggi.es>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> > Cc: stable@vger.kernel.org
> >
> > Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> > ---
> > v2: Reset CLEAR_OVERFLOW bit immediately after setting it
> >
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h  | 2 ++
> >   drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 6 ++++++
> >   drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 6 ++++++
> >   drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/ih_v6_1.c    | 8 ++++++++
> >   drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/si_ih.c      | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 7 +++++++
> >   drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 7 +++++++
> >   11 files changed, 71 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_ih.h
> > index 508f02eb0cf8..6041ec727f06 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.h
> > @@ -69,6 +69,8 @@ struct amdgpu_ih_ring {
> >       unsigned                rptr;
> >       struct amdgpu_ih_regs   ih_regs;
> >
> > +     bool overflow;
> > +
>
> That flag isn't needed any more in this patch as far as I can see.

It's used in patch 2.

Alex

>
> Regards,
> Christian.
>
> >       /* For waiting on IH processing at checkpoint. */
> >       wait_queue_head_t wait_process;
> >       uint64_t                processed_timestamp;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/=
amdgpu/cik_ih.c
> > index 6f7c031dd197..bbadf2e530b8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
> > @@ -204,6 +204,13 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *a=
dev,
> >               tmp =3D RREG32(mmIH_RB_CNTL);
> >               tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> >               WREG32(mmIH_RB_CNTL, tmp);
> > +
> > +             /* Unset the CLEAR_OVERFLOW bit immediately so new overfl=
ows
> > +              * can be detected.
> > +              */
> > +             tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> > +             WREG32(mmIH_RB_CNTL, tmp);
> > +             ih->overflow =3D true;
> >       }
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/cz_ih.c
> > index b8c47e0cf37a..e5c4ed44bad9 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
> > @@ -216,6 +216,12 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *ad=
ev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32(mmIH_RB_CNTL, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32(mmIH_RB_CNTL, tmp);
> > +     ih->overflow =3D true;
> >
> >   out:
> >       return (wptr & ih->ptr_mask);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/=
amd/amdgpu/iceland_ih.c
> > index aecad530b10a..075e5c1a5549 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
> > @@ -215,6 +215,12 @@ static u32 iceland_ih_get_wptr(struct amdgpu_devic=
e *adev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32(mmIH_RB_CNTL, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32(mmIH_RB_CNTL, tmp);
> > +     ih->overflow =3D true;
> >
> >   out:
> >       return (wptr & ih->ptr_mask);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd=
/amdgpu/ih_v6_0.c
> > index d9ed7332d805..d0a5a08edd55 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
> > @@ -418,6 +418,13 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *=
adev,
> >       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c b/drivers/gpu/drm/amd=
/amdgpu/ih_v6_1.c
> > index 8fb05eae340a..6bf4f210ef74 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_1.c
> > @@ -418,6 +418,14 @@ static u32 ih_v6_1_get_wptr(struct amdgpu_device *=
adev,
> >       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> > +
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/a=
md/amdgpu/navi10_ih.c
> > index e64b33115848..cdbe7d01490e 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
> > @@ -442,6 +442,13 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device=
 *adev,
> >       tmp =3D RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/a=
mdgpu/si_ih.c
> > index 9a24f17a5750..398fbc296cac 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
> > @@ -119,6 +119,13 @@ static u32 si_ih_get_wptr(struct amdgpu_device *ad=
ev,
> >               tmp =3D RREG32(IH_RB_CNTL);
> >               tmp |=3D IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> >               WREG32(IH_RB_CNTL, tmp);
> > +
> > +             /* Unset the CLEAR_OVERFLOW bit immediately so new overfl=
ows
> > +              * can be detected.
> > +              */
> > +             tmp &=3D ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
> > +             WREG32(IH_RB_CNTL, tmp);
> > +             ih->overflow =3D true;
> >       }
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/am=
d/amdgpu/tonga_ih.c
> > index 917707bba7f3..1d1e064be7d8 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
> > @@ -219,6 +219,13 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device =
*adev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32(mmIH_RB_CNTL, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32(mmIH_RB_CNTL, tmp);
> > +     ih->overflow =3D true;
> > +
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/a=
md/amdgpu/vega10_ih.c
> > index d364c6dd152c..619087a4c4ae 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
> > @@ -373,6 +373,13 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device=
 *adev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> > +
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/a=
md/amdgpu/vega20_ih.c
> > index ddfc6941f9d5..f42f8e5dbe23 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
> > @@ -421,6 +421,13 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device=
 *adev,
> >       tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
> >       WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> >
> > +     /* Unset the CLEAR_OVERFLOW bit immediately so new overflows
> > +      * can be detected.
> > +      */
> > +     tmp =3D REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
> > +     WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
> > +     ih->overflow =3D true;
> > +
> >   out:
> >       return (wptr & ih->ptr_mask);
> >   }
> > --
> > 2.43.0
> >
>
