Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3715CD484A
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:44:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C1610E76C;
	Mon, 11 May 2026 13:44:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QhQZA9N5";
	dkim-atps=neutral
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com
 [74.125.82.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 834C810E73E
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:44:49 +0000 (UTC)
Received: by mail-dy1-f171.google.com with SMTP id
 5a478bee46e88-2ee34d7e55aso432274eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 06:44:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778507089; cv=none;
 d=google.com; s=arc-20240605;
 b=a6LH9hPzSpmneGR2L/2r4iLo4tFu5ID3fEpQZL/EWif/eGXhRqopOv/VP8KRhA7bsi
 P4KBMit7wpYhTFtsYW2PFMSlxMFMgl0nxDCyUy7IZR8+9rBI2ETdko1r4Hwgu8Bs30YE
 DCxfzUoAeolFf0Hx40ySLZLtf44AVQzIeV9FGHDOZDWEkT/+cRYh/VFewNSvYm7ptAWH
 Me41pXq5TI87H5uGsX/yLkOawO47MjAekzSJv5AVBt+KzqHKxIniJ+khdB932iGboB0M
 I0HUxzun+R0t8DrebFfDK3JqN/aCh0CWekjp3poGDbOF/jAEag8CXrTwtnm67oK6JvWm
 jaMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=IPvemzdvNgESlvcfPmQMqjJ2PencxdzZhJEJ3BIaMdQ=;
 fh=lS7UZP0xkUCJrdz47hd5RL68APV0NiAVxlCpdHGPBPM=;
 b=S1MDssoiB5VbwU2MjZ7fL1LxhXkEe/x+Ul8vaFd9PT4JOgFNKmDWz5Lwj4ISCIouNH
 DgokGY+8x8v79Uo7Ltw40KEULAEx/k6ZxSNZQTbFDdurJ9ybOUQo/ZZTftAxh8qGh/rU
 tVXc7K5W1k9/seA1tckojgyeL49jdYb74UZmppq0Na2js7PhFZmIogBozdEYI26LsYAj
 IyTibNSEDBoOx2QpO3t8tpt/ZFKkRqAx3J+z0wVSXMS3YOP2vSsdz6ghFPqNKeSAhNKo
 iy5ZNh5uD4JVVRPbVYOmKjwFoQYFhtDcgydD2n9c3+esU+pauu8+LECHt5XQ+rPOxjLo
 Fdww==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778507089; x=1779111889; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPvemzdvNgESlvcfPmQMqjJ2PencxdzZhJEJ3BIaMdQ=;
 b=QhQZA9N58sj/WevYRB0595HOaQ5kO9YLJEA3l53TDC6JhypWs3LDyNKxi8H7bC0pp0
 La3ypNYUmsjwnxz6iSyzDvKSTOtwdXNrX9Q63XlICJbZxVdDlcCd+0QBv22dGFBQ6pQj
 3Y5y4pZrIyiNSeTboofUjeSAzNP/VW5rVnQoNSTfnMcUJOzNaxi4/MNqm0yPCBPmC/K2
 kY3c90h7NzFU5aLvCCMw4MJl75Y7uoJ/JKkUu2hcVWG4SA/5za2oeo20jFvg7hxnENRS
 Wp7OESRla+mmYz96fikkwXxYAcBnWoazZuDo1S/vLFyVuQLBWxuGCUB7smNdbCkK2iv1
 usgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778507089; x=1779111889;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IPvemzdvNgESlvcfPmQMqjJ2PencxdzZhJEJ3BIaMdQ=;
 b=i3OuwwdcEGmsSvYqir0Yjn5yhedFtQyRweMn0HY9PFw6f5syHztMjOQVGKtneO72f1
 WMcHc3AsmOsVhqYLf3pwZaVbxl+hf3dEtB6XHtSBIaup3TMHI7mBl1L8+k4Tkow6nrE1
 wEc9Kpk/kFdBks/Hpv3q3kCnnpjJEQK3jQBObcPb0zpfC4KWDpNvPXJnBg03hDdV77F1
 r5aA4tI6ppNdx004/UfCKvQh0AMmoPfG1pVPrDNGR/jgo+Fyptwz/BnOZR7ZZJGXU1LZ
 Pbfhn704kJdOAuC2CmNCW/dprmEVr6U4AVtHUQLENQ2V8aI8cP5DGtFQrzxPmWeoZB/2
 8rdg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/SvDzE/EESpP4hrWwxNyWknQdrlaEAbpvWguJSWiLEnDBxYxF54jwj1qgeY+9y/plSZJ6u6VE9@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzx0IBnu+OCdZ2qynqq6qDVW4yCfAfVIkfGCQk2xXt6eqXEizAD
 j9YP8C/rcFdBxLnEQBNHOaJ6YHoZ6Pl7XG16EzBtdGvARu4Ct/oY9qohVJO7r/Bq6rGm0O7BKoE
 g/FvfRMzi7zbglGkcL+smMj8A6RDaBh4=
X-Gm-Gg: Acq92OGZ6FxwZ9MObT4M3AAYLFGDCIkYnnDgetfYREKFtUNoW6ho26mjzsxELVx7ayS
 UyDB+o6nlroYmzwBT+s3A9rwfUdSKXU8Ls/oILCvH33nvnsZeHuUlmKE4GdZWQ4jX4dqfnrQMzG
 OnejnK3xRcKq8zbkL0y/t1txfhJRFCdNrFZLah/3SPlhk/a7i1LaJvEBVq9+vLKfKBX/sVVua6X
 1OoWj8Pek5mAmXBwCKeJ7v4Vzfjq0E2zZR1OSJmGgIlCrzhAwGe9QtdZUg6R8oN5CV4zjFLnykr
 fjbSEHMBNXz3K3iYAi74WKLTW0kGRTbmZ+TC+3qhnP+Clwp3HoQ+ZsCRuH9aWbqc8c+vqPvn6Ej
 tpudr
X-Received: by 2002:a05:7022:6986:b0:12d:ce63:d8c5 with SMTP id
 a92af1059eb24-13203858afcmr5719776c88.2.1778507088611; Mon, 11 May 2026
 06:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260511091326.3111950-1-sunil.khatri@amd.com>
 <16837ea4-4501-4727-811b-430d50fc7b87@amd.com>
In-Reply-To: <16837ea4-4501-4727-811b-430d50fc7b87@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 11 May 2026 09:44:36 -0400
X-Gm-Features: AVHnY4KgVF7FBMCXIuThZuFEyN2eiu2fZLZ1uRlV2PN3OdwO92L3t46FD9bZbLg
Message-ID: <CADnq5_OwZV6YsoQn+BS3mRiBaAnWe7pbhm3xfELNH_8U-AEC8g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/amdgpu: kfd vmid should start after vmid for
 gfx userqueues end
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
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

On Mon, May 11, 2026 at 7:49=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 5/11/26 11:13, Sunil Khatri wrote:
> > For GMC11, when KGD userqueues are enabled we should have vmid for
> > kfd queues start after KGD userqueues VMID ends.
> >
> > Use the variable gfx.disable_uq instead of gfx_disable_kq to check
> > if userqueues are enabled or not. For mode 1 even when kernel queue
> > submission is enabled but userqueues is also enabled at same time.
>
> Of hand that doesn't looks correct to me.
>
> On GFX11 adev->vm_manager.first_kfd_vmid is the first VMID the MES will u=
se and that should 8 when kq are enabled independent of the graphics userq =
feature.
>

Right.  When kernel queues are disabled, all of the vmids (except 0)
are available to the MES for userqs (KGD or KFD).

Alex

> Regards,
> Christian.
>
> >
> > Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/a=
md/amdgpu/gmc_v11_0.c
> > index 16388e3caea3..354cf1c1b93c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
> > @@ -846,7 +846,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block=
 *ip_block)
> >        * amdgpu graphics/compute will use VMIDs 1-7
> >        * amdkfd will use VMIDs 8-15
> >        */
> > -     adev->vm_manager.first_kfd_vmid =3D adev->gfx.disable_kq ? 1 : 8;
> > +     adev->vm_manager.first_kfd_vmid =3D adev->gfx.disable_uq ? 1 : 8;
> >
> >       amdgpu_vm_manager_init(adev);
> >
>
