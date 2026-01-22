Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60D8D3EE6A
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jan 2026 14:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FD8110E9B3;
	Thu, 22 Jan 2026 14:03:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l5DmuLqw";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0204D10E9B3
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 14:03:15 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1233ad1b4cdso109276c88.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jan 2026 06:03:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769090595; cv=none;
 d=google.com; s=arc-20240605;
 b=izYwEQPiKLZghRezGuQrcgFZker6yaTfQPsJBYrxV0rSggTi+lQ0lFSt47I4ZLxJO3
 rQffUXucLzeEZd4ghuYEhTR0FqB9iiMmDY2EJK3JDm1DYwQdMgWRdH25M32sI5cdbbcG
 cYjuQLRb+vh2MujbtmrjdSdgWSkMqfbl7kgYs4wmSIsqO7yFj9vM1iRn+slbsA9lSv2R
 mnUC7fw+q2UNPPuii4wewBjGI42gzpvVxUf6WB2rkwsIsAq+IQneI+7DdEh/uYGC0NYh
 /bNqJAu51gasqAuGs5IJpzfyEnoJ2iFL2zGo6TY49ejoKNeaTuOq7wnqpwCkNNGlYxe1
 41Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=AhMnfbmMtexumcfGstE9WPwXp5swseeu0kheQA6f8LM=;
 fh=ry6FD0qB02FUodvIGUswpFvKtbtlqnZDa2aAJTNVabg=;
 b=hZWODdV7/x2IKEgy6r1sYPynLiKje8vTD+9PtSge43AcokLFT7X1rAp4S4tJwlcsCn
 fWfWCKK972NmrRiSEd0mfnO9B3YjzDuRJac4/6Z0Ho+D1t+rdGfepu2CUlPd9WsXNbYW
 m7fOUwVAmrP4jVJ0zA1+3VkXe8NzE6FDOsRCT4MqAWa42NLTxC7jf8EAejx6Ie9TbjAc
 bKmXthD5aZjUXMvXd7c1l4K/4zsRv3BcqTFKFyO8sWpa9tgrAouUzwhBM9X7MGrizcNI
 UaoSOyI4VphVhHl47CaNtaxhT1Jak3A144V0sFMGxsHYU7h5NhHzbWeCgLbWeidbkza9
 g2oQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769090595; x=1769695395; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AhMnfbmMtexumcfGstE9WPwXp5swseeu0kheQA6f8LM=;
 b=l5DmuLqwOlwcv1KUy4hSA6bxzVN5rJZ8AHe8vKBOJfWbaFPOJrpX1rhspQUleDVpvi
 h3EclyWw/aR5iNDOVArg2nBoXOn2s6iM1Fu8kGpvkd90LVlcHaDezeKh8QEwI5XlJG1z
 DfFwrSgKKoAhPA1siGykqk1AknJBfZJDcG74+MhfWGVfAHExHL+g555r/arEje+c+It3
 i7tA/gLO/wfGn6akyqYsxgqNLv7xxdMfzizvfVLEqLwwW6a6V3/mFJ1bwAcHjUgAwMMG
 G7fOzVOJqdk65FzRQ6TSljicytznOFsgwzXiT3UWjlTcqly7rGW8uay61XjAeVv/ZLHL
 bWkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769090595; x=1769695395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AhMnfbmMtexumcfGstE9WPwXp5swseeu0kheQA6f8LM=;
 b=GvxfVmL0R0CVzlq9Y9tvNFBjeXYddeSwW/KQ2K6D4p1PB08AIYsr7k3YIMgc/ybl+8
 eBhw0HPqznpbOtEM6apMG9IhqxEtdsD7n5sghu1uQnNniRLZK0lSgIxtcdo8bhPp0nDy
 CX7jUJrhhXBiIMJy3n4jwuPQCnJR/+jzOG8o/aATaHfPMjOmeN73CMB9eVCkGGsfPi+O
 ol7Rf3wn1k4KDVOBe4jHKg1fL8Ga0OPeWHW1Eq1qnuyI3pyH1NpTsTQHA8JKYucDVFPv
 sTIlusJAXA1VAJJXkraOA9TkqS+wANd2d3XD5u4Tj9bx8McGb9GV4T1L2vY8qjfNpJxp
 Dr6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSgWU/K/jquaOkaG64u2Bo1Wvmk/aWHeNIBJacp1Tk3HrwckuZE6Djoe7nWFcHBdk6W89PUHYQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCKPq90q1B8PdhaSHN53Va6DWYdxA48E7jO62TPo6JsUgpgXvO
 aM2V4yd9RcGLBFuAN6mQflHso/zv6yFS5l8i6qCfmA93E0dYabYBxaGR/hHXzaJDBWSVl7/let+
 iK/4lIsWx55XpIpYGJuKt8pawdbm4tFs=
X-Gm-Gg: AZuq6aIyo22W7r4NmSrtc/F0Lm7BCYS0LsJjOynYYWQiAacB5JZN7fblE2ZwwqdVFYC
 yCv8nhxHv8iNuF6wP4cJyzrLh5RGvVqe1u+rA2E4xtMGhp8IZ4dCWNlulJ0OKSDcY3hf7+6TFBQ
 089M68Mqfhx+OGi9Id6wvhpu/upthFrggjHjW/nRAFzWITvJegbvwESXO3gj0aMUVGmzHjNfn4S
 +dqLr1sgDieYtCYcOUk2J36P8NKj2mbd/2noIwF+wV9utj0g2IPPD2qN0+35MxFX0OJIvff
X-Received: by 2002:a05:7022:20f:b0:123:308f:667b with SMTP id
 a92af1059eb24-12477022bdcmr1443319c88.2.1769090590451; Thu, 22 Jan 2026
 06:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20260121182447.2434085-1-alexander.deucher@amd.com>
 <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
In-Reply-To: <9d5291d6-9e1f-4df4-ad0b-ba7543d8a2af@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 22 Jan 2026 09:02:58 -0500
X-Gm-Features: AZwV_QgbnbE-PDvO7PMK0J_oadLHi-F2m1UgluKl7pG5JAh8w1dvOWfxv41qH0w
Message-ID: <CADnq5_N3ZKRcXzpheLj81fckJoRkzmWkJ1BYq+VaAcnENs_kPQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer dereference in
 amdgpu_gmc_filter_faults_remove
To: "Lazar, Lijo" <lijo.lazar@amd.com>, philip yang <yangp@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Jon Doron <jond@wiz.io>
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

On Thu, Jan 22, 2026 at 12:07=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> w=
rote:
>
>
>
> On 21-Jan-26 11:54 PM, Alex Deucher wrote:
> > From: Jon Doron <jond@wiz.io>
> >
> > On APUs such as Raven and Renoir (GC 9.1.0, 9.2.2, 9.3.0), the ih1 and
> > ih2 interrupt ring buffers are not initialized. This is by design, as
> > these secondary IH rings are only available on discrete GPUs. See
> > vega10_ih_sw_init() which explicitly skips ih1/ih2 initialization when
> > AMD_IS_APU is set.
> >
> > However, amdgpu_gmc_filter_faults_remove() unconditionally uses ih1 to
> > get the timestamp of the last interrupt entry. When retry faults are
> > enabled on APUs (noretry=3D0), this function is called from the SVM pag=
e
> > fault recovery path, resulting in a NULL pointer dereference when
> > amdgpu_ih_decode_iv_ts_helper() attempts to access ih->ring[].
> >
> > The crash manifests as:
> >
> >    BUG: kernel NULL pointer dereference, address: 0000000000000004
> >    RIP: 0010:amdgpu_ih_decode_iv_ts_helper+0x22/0x40 [amdgpu]
> >    Call Trace:
> >     amdgpu_gmc_filter_faults_remove+0x60/0x130 [amdgpu]
> >     svm_range_restore_pages+0xae5/0x11c0 [amdgpu]
> >     amdgpu_vm_handle_fault+0xc8/0x340 [amdgpu]
> >     gmc_v9_0_process_interrupt+0x191/0x220 [amdgpu]
> >     amdgpu_irq_dispatch+0xed/0x2c0 [amdgpu]
> >     amdgpu_ih_process+0x84/0x100 [amdgpu]
> >
> > This issue was exposed by commit 1446226d32a4 ("drm/amdgpu: Remove GC H=
W
> > IP 9.3.0 from noretry=3D1") which changed the default for Renoir APU fr=
om
> > noretry=3D1 to noretry=3D0, enabling retry fault handling and thus
> > exercising the buggy code path.
> >
> > Fix this by adding a check for ih1.ring_size before attempting to use
> > it. Also restore the soft_ih support from commit dd299441654f ("drm/amd=
gpu:
> > Rework retry fault removal").  This is needed if the hardware doesn't
> > support secondary HW IH rings.
> >
> > v2: additional updates (Alex)
> >
> > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3814
> > Fixes: dd299441654f ("drm/amdgpu: Rework retry fault removal")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jon Doron <jond@wiz.io>
> > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gmc.c
> > index 8e65fec9f534e..243d75917458a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> > @@ -498,8 +498,13 @@ void amdgpu_gmc_filter_faults_remove(struct amdgpu=
_device *adev, uint64_t addr,
> >
> >       if (adev->irq.retry_cam_enabled)
> >               return;
> > +     else if (adev->irq.ih1.ring_size)
> > +             ih =3D &adev->irq.ih1;
> > +     else if (adev->irq.ih_soft.enabled)
> > +             ih =3D &adev->irq.ih_soft;
>
> Faults are delegated to soft ring when retry_cam is enabled -
> https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/dr=
ivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c#L541
>
> That matches with the original logic in d299441654f ("drm/amdgpu: Rework
> retry fault removal").
>
> To match exactly with the logic in above commit, I think it should use
> soft ring only when retry cam is enabled. Presently, it's returning
> without doing anything.

+ Philip

That logic was changed in:
commit e61801f162ddcf8874c820639483ec4849b0fb0b
Author: Philip Yang <Philip.Yang@amd.com>
Date:   Mon Aug 28 14:05:55 2023 -0400

    drm/amdkfd: Don't use sw fault filter if retry cam enabled

    If retry cam enabled, we don't use sw retry fault filter and add fault
    into sw filter ring, so we shouldn't remove fault from sw filter.

    Signed-off-by: Philip Yang <Philip.Yang@amd.com>
    Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
    Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

So I retained that logic.

Alex

>
> Thanks,
> Lijo
>
> > +     else
> > +             return;
> >
> > -     ih =3D &adev->irq.ih1;
> >       /* Get the WPTR of the last entry in IH ring */
> >       last_wptr =3D amdgpu_ih_get_wptr(adev, ih);
> >       /* Order wptr with ring data. */
>
