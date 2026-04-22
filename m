Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21772F9EDFC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 15:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9641910E9E7;
	Wed, 22 Apr 2026 15:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RlSp7wVQ";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EC9810E9E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 15:21:25 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12736a0147cso385972c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 08:21:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776871284; cv=none;
 d=google.com; s=arc-20240605;
 b=Px0Ff1XSGpJb9pSTmXgSO3uyjOFdvqKa9+XmxMMdNFNHtkCzkyHatkEVAMTrZ9PsEG
 JHZ+3azLEUlr6/cIRKscqb36iS+JYDmS4ouqk2YiSszIFTosACd5WmKqjYkbdVUtIFyU
 E0kkewwH1JNSy0VlBYuimhcqWt8NqidoMIJ/M/rUJrVGsvjthIh5WKgVD63c/40hpH9e
 yViHEs7Oaj80HZo7Vo6XPWs5gQddu0paOp2UY1zBRPBzBtAoDM6xNx3TWA+g11qx90w+
 iLjv0Zk7NnXaIMnrY5xKmmz18VoUOJmTQmO0REx3Vi7XAqF/s0mMntBonZSjyN57YM/8
 thLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PRVwp2dnScW6r8xUQitR2DStMGtshyNjJneKJxOSVYw=;
 fh=3rVIAhuKppxQxlMp2GxkGDqM88XAFs5jwDFvzGza4N0=;
 b=N2gs0liL1PjN9jLn/gOgn1ShGC3QbQx3Fndev6mnkC3W1/hljkz4O81sKcvLBGqsca
 T1WtRTOICpv1x4bbBFqigW4MZKs7depypqinb+K7O4RCzsls9sv8ynkzKUvSCm9Ec7bA
 1L86yvtdpsP3byP5M2uvgG0nvObHHncCFNUUW16ysXSPhqSR02+8ansnF2uwMue+xqFa
 +kkVluTVopsitlUP/vwmDpgNvVMO40q0zn8l271j717tX1teIQIWunQtNoNBHtyFHJFN
 wp0gn77xIYAUtk9RkodspPybKCJG7ecSSTqRbovdf3opZ66sqWb9/RrKcdhET/XeqiMU
 rd4g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776871284; x=1777476084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PRVwp2dnScW6r8xUQitR2DStMGtshyNjJneKJxOSVYw=;
 b=RlSp7wVQCJ9L/3pPg92GyT+vGkHPtS/JHtl9UVA1SqShgaQJPcIy2LjQ0G1TxKt0zV
 OvuwICxUIxIHIDN4OitsgUjANiMe2cd1rSCrNJq5Y23I2yr/UAQ+wJa7d9ud0quW+mIu
 azMzG44f/X5wFxIMVG8Ncthhlr46w6Czv9dgaY/Bl2T4MBsO0nuG8BUywCHfN1y89Hwl
 3O+59ob8j2iDNTDLKEd1yTovjdBGyKoRHDG+tu5nVp42shErgJ+cFmlfBhtDOiyn/YlO
 kuygzvOLzoPPiXIdtUN3eFs2OjIO7VFQfTYH00UAxfBlh7JlUTBD3Ebs7/wem5Rmr4xZ
 NIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776871284; x=1777476084;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PRVwp2dnScW6r8xUQitR2DStMGtshyNjJneKJxOSVYw=;
 b=nEz6d7XdcTQMUj2dgOVgFxg+W4EF+7Bxnl8SssBH+6fpazhmNIhvv+G1kXCrmfTJ9L
 YW8bVAX1wL922q5JnrjVuIQFz8BTwki5L+8j/LOqAw+ogtekNsvpXGThEZ7Qk0ID416O
 N5qNpas7+p6R2l1/MWAhcodrmKJIKdESdva7Eko3/RvD3vstwtee0eZJfRcAi/pJP9YO
 AcaeuaTrl01CS9GZU6DqSY+9w2BlwHUSsiOMM8F7r30cS4/cyIJ4yNfI5lBba0ZXyqqT
 AfpxQqkVBtG9p5BNLhAChSAkKC/d+7Hh270w22g0Dm+78VdPIJcltkRCj4wqC7TAYug5
 q3fQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+8wNGp98VimBfepmFxawyjWPtksL6aENnvNxcu0k2bkZAwgXCImrXoXRtZjx51hanS84Da0/bn@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6IiI0HJW4wisytLFhXIju0NcbDuHZ858HPb/u+7ouSXJY1fub
 HsjaA6HPt4sGKSnMOCkh4pS/dNAOIJtrIwp5asvRN1XGfoS3h2RnLvQB5Pzk34AZ14UBGlKT/Wm
 9Db9W47Jr6glYOb2i4wCxKBIbdUPSq+I=
X-Gm-Gg: AeBDietEc7/sOTX9QXtNtNtaYeRGAahCEIyAOi4/y2VipRrK9f2lCbdmwv5KCUNpRG/
 u1M/pmlItt9GJeeWZ+2ZXb4LOJLiekvsvCaslyQQVm+hhnD0romW6QX+aIX09wbhbPnaldkKDlz
 OqZ/CcgKDEXJwzjeZK6u5V++qRprqDPLz5DVB+eK0XjjUP/D9fk1o9x6bxkul40/2xNzgzI8er9
 3wHXUOllzRagBCBGi8crT0wNuh5C6MhtATHqXtQY61hb9FWzR6AZ3hHlTyVEp78ex+fFeZNlOxL
 hhkv75enZb+hL45+CB2z7FyoHaYh3ZrMjBDEYsMXhaanwCkQ6H0lZgnVzMS0xoqHz908GsgIfE2
 RxlwAPFXg1n5XxAk=
X-Received: by 2002:a05:7022:459e:b0:127:332d:63e with SMTP id
 a92af1059eb24-12c73f9b5d7mr5030583c88.5.1776871284314; Wed, 22 Apr 2026
 08:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260422123817.1940-1-getshell@seu.edu.cn>
 <879c6e0f-76e3-4eb0-bada-b38230d0d23e@amd.com>
In-Reply-To: <879c6e0f-76e3-4eb0-bada-b38230d0d23e@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 Apr 2026 11:21:10 -0400
X-Gm-Features: AQROBzBgaNCRleXArmeRyzHxy-XR8oh864TQTHE93XoF24lgZ7zJ0UBC0WrRxuI
Message-ID: <CADnq5_PyPfz-Z9Cygy4R50RxLRDt08We5U0X3beW0Ta4KWeVdg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: avoid double drm_exec_fini() in userq validate
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Hongyan Xu <getshell@seu.edu.cn>, alexander.deucher@amd.com,
 airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 jianhao.xu@seu.edu.cn, 220245772@seu.edu.cn
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

On Wed, Apr 22, 2026 at 8:59=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 4/22/26 14:38, Hongyan Xu wrote:
> > When new_addition is true, amdgpu_userq_vm_validate() calls
> > drm_exec_fini(&exec) before iterating over the collected HMM ranges and
> > calling amdgpu_ttm_tt_get_user_pages().
> >
> > If amdgpu_ttm_tt_get_user_pages() fails in that path, the code jumps to
> > unlock_all and calls drm_exec_fini(&exec) a second time on the same
> > exec object. drm_exec_fini() is not idempotent: it frees exec->objects
> > and may also drop exec->contended and finalize the ww acquire context.
> >
> > Route that error path directly to the range cleanup once exec has
> > already been finalized.
> >
> > Fixes: 42f148788469 ("drm/amdgpu/userqueue: validate userptrs for userq=
ueues")
> > Issue found using a prototype static analysis tool
> > and confirmed by code review.
> >
> > Signed-off-by: Hongyan Xu <getshell@seu.edu.cn>
> > Signed-off-by: Slavin Liu <220245772@seu.edu.cn>
>
> Good catch, Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_userq.c
> > index 9d67b770bcc2..fe49108fabbd 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> > @@ -1193,7 +1193,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr =
*uq_mgr)
> >                         bo =3D range->bo;
> >                         ret =3D amdgpu_ttm_tt_get_user_pages(bo, range)=
;
> >                         if (ret)
> > -                               goto unlock_all;
> > +                               goto free_ranges;
> >                 }
> >
> >                 invalidated =3D true;
> > @@ -1220,6 +1220,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr =
*uq_mgr)
> >
> >  unlock_all:
> >         drm_exec_fini(&exec);
> > +free_ranges:
> >         xa_for_each(&xa, tmp_key, range) {
> >                 if (!range)
> >                         continue;
> > --
> > 2.50.1.windows.1
> >
>
