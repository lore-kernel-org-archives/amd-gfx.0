Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470E4C88E75
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 14:12:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D01DA10E2B3;
	Tue, 15 Sep 2026 14:12:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T+AgKdn1";
	dkim-atps=neutral
Received: from mail-ua2-f12.google.com (mail-ua2-f12.google.com
 [74.125.226.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6690710E071
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 14:12:53 +0000 (UTC)
Received: by mail-ua2-f12.google.com with SMTP id
 a1e0cc1a2514c-982a76f0cebso74603241.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789481572; cv=none;
 d=google.com; s=arc-20260327;
 b=Zo0/lNt8nIbmR/FUMXTUSednb6IZxYbvVMaCgzcQ6kXwAyHGddomhtJai0LnLfaXH5
 e84myIl4+A6QmR2suWGQbmGMr/P4DPTLvymkMwO19PteYVykCQ7umuGnr8Y2eNY0P4vI
 Bnn7WAvCQv9WLXZWDSd1aloEGjvKXSFfui6J1+NpGwF4rAe+E1MwoggLDo+F8g+VO5WD
 yHKLRCrM9uxwPxsWz/LXEevt6imBIe7wAzwh7cGtEE14i8ITOdHDdWXolA6e285Uywok
 f2g8eVdNzaRjfBdnHfo0fGgaZXboHR3wWe3/d6S+Hk9poILQPpIEpjq+hT+vzcpNk5ZX
 PjQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=i7cn65EbAp0IbKb7n2Q/NZmcE6NpExnNj+DKsdNyhwk=;
 fh=UfYXf3I/yoGPSzccjqLrG8P/tM67FnkEbmposq8HHKs=;
 b=cTeSPyVSIs6MHtJjJQNUHbtTMiCh/fRjGJQXsnF00qAdRsmV+eT7BS1po/wUwOYLOe
 QDC8CYEs/a4EjJqHdP/8ZmYtuTQFWFXfxvFslgttax2ab0ZwYSqS2hAoA/QPs3iAF0lb
 35i3HFq6LB9/VKs9fKHMTMNeKYfRkJz972XSq/znFCM5EETPbAgi0tO2IB2ta6mmWW51
 iZXWTvkz54Wj/WuCYJ/bjoK+aanbzgqN8QEM3xK80VBrEF1z5OuLWa1dKGuGaFCme+mA
 YmBDXFOYkg1D05xkVHopOgFbspu8Ap9YsGXEHKAo1wvIueM+UgZ1FqC8tebdSSHyJ/LW
 ySAA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789481572; x=1790086372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=i7cn65EbAp0IbKb7n2Q/NZmcE6NpExnNj+DKsdNyhwk=;
 b=T+AgKdn1AIXXYJgYyBtaGwMXBFvVpBIzhJd05eSEtIqh5dRTK0nJpHcsaSe316738F
 r9jeEkvS50bc/b5VtEUaaei+a2rLlWLwFaRA63EJTEhD2BpvQSv8mNxblAorSlB97Ruj
 0OpP40C/GncwVFZo5MeiB+FTUQ07TQ1YrumuaLHxSs++SfxKV/z1T/igZlMuq2bWDF/m
 gdAa2FS16dTrEgCX46ac9E4d6QKjpHuDGpAiF1bRSEHGYt7QiCywc0al/GNOF1oXSY9Y
 2uZv2q9Y0evKsXQl27hnOOBpQbLzba3wIlpIowPoQVGhGJnwDZ5O/7MkNEGn1rVk0mdb
 6YEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789481572; x=1790086372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=i7cn65EbAp0IbKb7n2Q/NZmcE6NpExnNj+DKsdNyhwk=;
 b=UiQmKy7oV4Bczv+j+CRh3Wfqyvwznyxm48ZyWq/kGLJxBMBeqDtbIoIUt2D4oEjZJa
 G6UqLn+bXWd37lsoaa+895Y5EwthW4Eo0EdQ0o8geX5O2JCFtITSK4LRnyt5SBvt2Twf
 grBIwJE3oiQJVhIFtxQYXyofpPF8SCgIi7YP5qkMoXnxSVeQv7ctcbAQyoVyT4uFaAu2
 3tbyJcud6Z9ZeVzWCYLGSESsrMLYBtuo32Hf6Pm6OPtL0WLXouRJx+woC2FUqVur9wf9
 rTcMd0iEWRG7mrWDI12/p+doZW42pOYwd9WUZJ+7AuzAuCKqQ5badpfMxWF5YLSjkly0
 uARQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByWmHjAW0PDlr5Q3B7ht9u4wG2kc9ECTAOspUXXHZwIVCVKfgqPzqSED8TLecffaTGY3UFCqVBP@lists.freedesktop.org
X-Gm-Message-State: AFuF++l0v0f/WoQCI2g7n0v7JJP8NBJR1OIMzNBlUPskOeMIiLR6TP42
 MijplBKKdtPmNlOLV4OHbd2lvFvoyHe7JNfA0WD2PdYW8K9t5wO3M/XDbtwJAD7V7fmaTbphAwa
 5ICqERd3q4Wbh1EzEfqf5aFy9LheOuV4=
X-Gm-Gg: AYBFou3dTnqM1gGT5Uea/ngvPK3OLg7Cn4CAZIPxvqMIPLHHBjqNMwTsjNkwqOkxkp6
 /xG+RMVgRNpvU78HBodHefHfFaYqHMK3WaNpjsZKrbaNXpz3IEVY6GwBvgYatGwzZEh0jt+FgpS
 Fp4yGcx8LlI11YFcrjbQRVMhWa10eirm/YZzj3xR0uzAT7xOjjwQnPsLNM00Fs6sgjnIDAnPrqZ
 A1EBgfdeRSSr+z5Nel4gEE/BhrsYgWdISapYob8ee1v4sDXMcG89jn+t7S/+MhKot0JR74EnHun
 xKzCprpzkBZhatH4DmFkLSSFfjqHkqNRWfYQFc6HpwpND/bFsr/vNxmOcmA4Lruurvw0EK8gyfA
 LJQa1ZcLCVLrE0O1wQIQxnbOi4SA6xL0iSAAfjQYxLQ==
X-Received: by 2002:a05:6102:c54:b0:786:d38d:f7c2 with SMTP id
 ada2fe7eead31-79b5b676f93mr2335600137.1.1789481572122; Tue, 15 Sep 2026
 07:12:52 -0700 (PDT)
MIME-Version: 1.0
References: <20260914143303.90614-1-Dmitry.Chumachenko@cyberprotect.ru>
 <CYYPR12MB8729B5365277A22CAF0E3481B0BA2@CYYPR12MB8729.namprd12.prod.outlook.com>
In-Reply-To: <CYYPR12MB8729B5365277A22CAF0E3481B0BA2@CYYPR12MB8729.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 10:12:37 -0400
X-Gm-Features: AcwNN1WacDhZlbvZYTvJ0gfbBPuwD2uIMCbwq3aGupmgwVj9oiTKkaVVd5BP55s
Message-ID: <CADnq5_MKk5eQnZDTMepVtnAgEjWy84M_3ZPDkELyC5onnsAb2A@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: check ras and obj before dereference
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>
Cc: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, 
 "Zhang, Hawking" <Hawking.Zhang@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
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

Applied.  Thanks!

Alex

On Mon, Sep 14, 2026 at 11:15=E2=80=AFPM Zhou1, Tao <Tao.Zhou1@amd.com> wro=
te:
>
> AMD General
>
> Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
>
> > -----Original Message-----
> > From: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
> > Sent: Monday, September 14, 2026 10:33 PM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: Koenig, Christian <Christian.Koenig@amd.com>; David Airlie <airlied=
@linux.ie>;
> > Daniel Vetter <daniel@ffwll.ch>; Zhang, Hawking <Hawking.Zhang@amd.com>=
;
> > Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; dri-
> > devel@lists.freedesktop.org; linux-kernel@vger.kernel.org; lvc-
> > project@linuxtesting.org; Dmitriy Chumachenko
> > <Dmitry.Chumachenko@cyberprotect.ru>
> > Subject: [PATCH] drm/amdgpu: check ras and obj before dereference
> >
> > [Some people who received this message don't often get email from
> > dmitry.chumachenko@cyberprotect.ru. Learn why this is important at
> > https://aka.ms/LearnAboutSenderIdentification ]
> >
> > nbio_v7_9_handle_ras_controller_intr_no_bifring() dereferences ras and =
obj without
> > checking either for NULL. Both amdgpu_ras_get_context() and
> > amdgpu_ras_find_obj() can return NULL, e.g. during the window between
> > adev->nbio.ras being set (early in amdgpu_ras_init(), by design, to
> > enable the fatal-error interrupt as soon as possible) and the PCIE_BIF =
ras object
> > actually being created in RAS late_init. Any interrupt in that window c=
rashes in hard-
> > IRQ context.
> >
> > This is analogous to commit d190b459b2a4 ("drm/amdgpu: the warning
> > dereferencing obj for nbio_v7_4"), which fixed the same issue in the
> > nbio_v7_4 handler.
> >
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> >
> > Fixes: 7692e1ee2446 ("drm/amdgpu: add RAS fatal error handler for NBIO =
v7.9")
> > Signed-off-by: Dmitriy Chumachenko <Dmitry.Chumachenko@cyberprotect.ru>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> > b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> > index 8e401f8b2a05..2b3a1b9f8efc 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_9.c
> > @@ -518,7 +518,7 @@ static void
> > nbio_v7_9_handle_ras_controller_intr_no_bifring(struct amdgpu_device
> >                                                 RAS_CNTLR_INTERRUPT_CLE=
AR, 1);
> >                 WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_DOORBELL_INT_CNTL,
> > bif_doorbell_intr_cntl);
> >
> > -               if (!ras->disable_ras_err_cnt_harvest) {
> > +               if (ras && !ras->disable_ras_err_cnt_harvest && obj) {
> >                         /*
> >                          * clear error status after ras_controller_intr
> >                          * according to hw team and count ue number
> > --
> > 2.49.0
>
