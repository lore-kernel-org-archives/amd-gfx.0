Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0049109C055
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 18:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B56810E831;
	Wed, 25 Mar 2026 18:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CB5ANvA7";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE6310E82E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 18:33:46 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2c151551a6eso6730eec.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 11:33:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774463626; cv=none;
 d=google.com; s=arc-20240605;
 b=LLmeC5Y/XZpcG8Pj0/GkiWPSmMc5HmHW5CURXGR+vdNmwiOOkKRTAOesQe5iLb5SRq
 UhGmGSQZmk86IXpmKkh/mFC7uXGbGn8lbZFTaetU3nmlJx2sbAMn27+aFGR2PCYaPhF9
 0BsDwYmv7wXgPVbuioR9bBAdgsAvg4wTtsQjw/od4g4HV3c+OPNG/hMiQVJzxs+oybKi
 do5Kq3F6IA2guTDzhDXKJE+HPmGcrjtRuPyf8apyX32SbrR+m4oXQEvymiLQddyKh/z/
 rV4pZoWg23OZ8Onibo1l6jviAJ22vGVRBzhqNsfTdyAWUCA+tvfdJba3/UVj701m+fjN
 UyBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3n/9cNi5BV7ms77TfpMg3lmwylRhhGCcghML/DtKpn4=;
 fh=EfXU9e2Dsv1YwR9eSZqtxYZDo3g1+kfwAF/WSZRAHnE=;
 b=en4Ofdz2NCrP1ZM41Ysm7fSpLkuvtA8DvKaNpM+ZJzc5LjpcQ+lJNzFfhqVkdRWUo7
 DR7f8oPSAjpFmQIf6BDYYj1WmdsJCY0yFNBpG1UhYosf8YRa5Eihlno2q2+uLShK1zPF
 0xLLWM7Dl6izwz64td0T9MrU/bg8uncPNVmizDlWiZfLKQQIkLy3f3PRBKP1IBJiy4xE
 yu6aZm0jinj0Oaf56/gGgF0gcJwkqfVCvk98rkCvgkWxxaqTG6bRegWYq/03vBLT81kL
 D4s8cvMrldBMoEEwQF4GxGw4JO+9pHxQGxQqYQ3KArKTq2WC+zjd/y3xkriPRBXnpM0y
 +MMA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774463626; x=1775068426; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3n/9cNi5BV7ms77TfpMg3lmwylRhhGCcghML/DtKpn4=;
 b=CB5ANvA70ApuSND5sWqt0h1pTg5CB7lRDNNG4/2mVTTyWYMsUW69Br8c1wW0BwCLki
 KrmKaWnzrlDD6om/fInDso9Hfa5l1svpj4Dq0234UV7TS4m9PPNIiGnA6Hr08dSH05NP
 dkwmyu4DiZpnMWpplDV61vS4Xu9vJpADyPYM3SHbPjhLESC1mQASvGcHTgYPINk2UvaX
 aUb7OGHR7TXFMq6IbUCVyu05xp+OMtRIyd8F1MbDhKLP3V1hmY4uA/uc87M9w5ueyBRM
 ouUgDnfCucifnHsXqJYxLnkSWN6c13p+1P0h04Gzg/feJdLIDBZvHVy4v+YV7uloyJMk
 1t2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774463626; x=1775068426;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3n/9cNi5BV7ms77TfpMg3lmwylRhhGCcghML/DtKpn4=;
 b=VfrEV5mfjpQx22XdJfMyF9mnvMgA1hjp5Prj3zc7b3lz+qmSddUmBBoxp8+y2NDWn5
 2RT6jTnjpXDygLVJvFvVNuSKUw/YVtSXY79pwTH19MEbq2WMDLYXBrUclJ0qUVM+0sEY
 T1+FrppNJXrw0X7XvG9GlEYipYvRbt3hPCmP9FzCngwoPrLtXENkvler1AsKSsOtdYBf
 Z2toSzi3LOBth/7mZiGQ4h77O/4N2Cpin7QN1ZKslcNKevy9D7IgrPpg/Y2ctesBY7mD
 0BlPhaQ5V5RkKwyNDF5PcBJ7CD8/GnGM+7pB9XXBt4aYN4mlocWZf9PIzRV9eI3cOEGt
 6ZUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQahRh9AIUZusJ1ztkRFNLrBGwY3GYhbzTlwUArIy7i3QqKUcDbiH0JP/7s5fR38ibtBKQjm3O@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIvoOSmX569DpP7s6iktJRwwFIwULDj7Ntex5nH3BmBa9G19AE
 ABt18vtJ043Iu523YnrQDrAQe2NG6sq5fWy6eKR0LI6F5CuAWbuylmuCIf5VsvaUFxF3pF/AHDu
 TVUttPxEbEy9YTkLpEy5RPIohtrB5SmA=
X-Gm-Gg: ATEYQzyiaD/xONQXSdepcxkhyz6GjIJBRc6OF3ssSlBTG1EGW4cc9t6EZLA3OSKglkL
 93HWj1gsQmunmuoVk9cnRHBoOpzILJ/voyTR53SRPYQyeAlWw7jAj4GzrO7MZ+POxYhKRZ4W4Oa
 /oat45xSx1WHPY+aLz1yseqidEPP29+5VQqH/3HtpEbCdCot6m6UVAiuqb+o4eJB9wA+En1RA3Y
 sphM0JJjdSjWo8/aWGe49YINNuJu20rKtYbEQp+2vroFJpzQkLrm4DkddoMBLuT6WLs5xYXVXFs
 he/kmSDnup/iC4XUnTEsnTf3VzAupFPjZCIy5S8uL/msrYnXwGyfnEz4G0D3btjuB3apEQ==
X-Received: by 2002:a05:7022:425:b0:12a:6cde:fd0c with SMTP id
 a92af1059eb24-12a96ef3ed1mr1002074c88.7.1774463625963; Wed, 25 Mar 2026
 11:33:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <1afca38f9d8b7d8ce16694f37edd006c15c9bd2c.1774239489.git.donettom@linux.ibm.com>
 <08ad0b48-72a9-4f44-8f48-28a00e96286c@amd.com>
In-Reply-To: <08ad0b48-72a9-4f44-8f48-28a00e96286c@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Mar 2026 14:33:34 -0400
X-Gm-Features: AaiRm506SvNF0AIR6k2GV-Ui33W9ZcNjOc6GpgiIXa-vLOQPG6p0Ogrv33UcX0U
Message-ID: <CADnq5_Orehx8bWYBnHuFTBrs9Q=U+O5YmfUKAUHfAjQkypARBg@mail.gmail.com>
Subject: Re: [RESEND RFC PATCH v3 2/6] drm/amdkfd: Align expected_queue_size
 to PAGE_SIZE
To: "Kuehling, Felix" <felix.kuehling@amd.com>
Cc: Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org, 
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, 
 Philip Yang <yangp@amd.com>, David.YatSin@amd.com, Kent.Russell@amd.com, 
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>
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

On Tue, Mar 24, 2026 at 10:28=E2=80=AFPM Kuehling, Felix <felix.kuehling@am=
d.com> wrote:
>
> On 2026-03-23 00:28, Donet Tom wrote:
> > The AQL queue size can be 4K, but the minimum buffer object (BO)
> > allocation size is PAGE_SIZE. On systems with a page size larger
> > than 4K, the expected queue size does not match the allocated BO
> > size, causing queue creation to fail.
> >
> > Align the expected queue size to PAGE_SIZE so that it matches the
> > allocated BO size and allows queue creation to succeed.
> >
> > Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/a=
md/amdkfd/kfd_queue.c
> > index d1978e3f68be..572b21e39e83 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
> > @@ -249,10 +249,10 @@ int kfd_queue_acquire_buffers(struct kfd_process_=
device *pdd, struct queue_prope
> >           topo_dev->node_props.gfx_target_version < 90000)
> >               /* metadata_queue_size not supported on GFX7/GFX8 */
> >               expected_queue_size =3D
> > -                     properties->queue_size / 2;
> > +                     PAGE_ALIGN(properties->queue_size / 2);
> >       else
> >               expected_queue_size =3D
> > -                     properties->queue_size + properties->metadata_que=
ue_size;
> > +                     PAGE_ALIGN(properties->queue_size + properties->m=
etadata_queue_size);
> >
> >       vm =3D drm_priv_to_vm(pdd->drm_priv);
> >       err =3D amdgpu_bo_reserve(vm->root.bo, false);
