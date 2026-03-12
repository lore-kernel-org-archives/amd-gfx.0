Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E0B106ACE4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 20:44:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E8E110EAB3;
	Thu, 12 Mar 2026 20:44:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c5F1lj/5";
	dkim-atps=neutral
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com
 [209.85.160.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F32210EAB3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 20:44:33 +0000 (UTC)
Received: by mail-oa1-f51.google.com with SMTP id
 586e51a60fabf-4172269edceso76766fac.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 13:44:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773348272; cv=none;
 d=google.com; s=arc-20240605;
 b=dTqC9UFu39I3oss0zF0Mskq3EYOBHW92nSoxz7BE/+sQKXMQY8ZWX2pD4VLt3Y1PMM
 7kl06adTC+kuuxdDbjpK6+mhDb9YzfcErW6XDMl0tP/ukATcOOiqqrLyNxxfa3LskCtc
 MUbsWFNFcJzziMyNg9HHmq5pNyBXdH7kwZmGoBFvhTBZtIY/61cFu0Z75vNLCIQHq3g5
 WhjcwylenM6TIVBHy3WZ88K0XEIVWzr/xPvWeH5GcCGnKBMbPa4BKgHCR38dQUXH1sye
 TyIakvqflxBWsUumtw4WnFKRDlojL8XjFUyHhdyKHb8PbQsYycyPoWLBfC1CWri9/3tC
 7lOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=pNBA3kLHIy0t3IxW/xplXzcmay1Hab2qbZgo6SmXgBY=;
 fh=bsmiZQ/hOuCC8TmxKx+weCDo2M07dKiDPKEJvfYix70=;
 b=lkgI9mrNWwRMfx9/5L+Y6BaYCC0Gdlej2cfG8dFiiSpoK+i3WoQAy5zsLFRgb0rHg4
 6VQre34OeX40FCgutwTMRJOLiJOmBZmjaeF2MQz+WRHJ32fIEpip2BhxYQaFZnTe8N6X
 u67EcsVMYw2tlQ0DoSpqsqTRRCtjXy2ZgROgk/SmuRTObDzGyqFTZP4BCL0CPHEQun5p
 /gqQkLqOePoQuNWme0uyYgQzGV8S0j0WenJ3afiJnQEmOqx1EOL1aXlXoC9r/3dxDE3I
 QzysTEK/AN/ZSGr792trCMvWgZD2ZISXWhLAeQecw/LjWNmKtXAVapqCd+ZntDBxj7C7
 lZOA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773348272; x=1773953072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pNBA3kLHIy0t3IxW/xplXzcmay1Hab2qbZgo6SmXgBY=;
 b=c5F1lj/5aaiVKJGjLMGc7+ch1j7TFNKqM/fxcnFUppAXhd2HZAWxYg9gF2ZH5A7Bak
 w9cv/jS8HWTf3uTohTAcMAJv5HeV3zKMrW0qLnFCEuAzbLRrMvLHXKdyOoNA+9nJ+0jK
 E6Lzjr6owg0SzFRR2jnvZbnKjOva5P4tYEKu/vUJNePnG5YXHygENyU8R0ImY9pO4QM1
 G90XkrypiEzqmbQHXDOMxQFfIC8gjZysi7pjjYOfHnPldvlMBtCCUsB84mWz1v7Mxq6t
 Nz8oFVYYGjniJN0ENlTe69ulzVSaDJwinnE3e4bJqckTuVxI1L4bggsOuA6mMDQGlKHH
 Babg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773348272; x=1773953072;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=pNBA3kLHIy0t3IxW/xplXzcmay1Hab2qbZgo6SmXgBY=;
 b=TIDGmLs5lHz37kp9SRIOKV6jRPOeayuy5dtT4m2jAT7Ss0kPPxH/RH56D7cGZy0GOA
 +PeoqOtrcc1+Hu/s/p03uVDuMJJs5jIdKZMYOo/u+n/0JfBFLIOkSutArll1WQzw1EEf
 vqdI4iRRCGWr2C3OPd2XNJXgxedusb51OHYd6n0zmRlfn5SV29aCaPgPYEfj3cHmPrYD
 x5g1fhNQ1QWGEBob/n7mV4X6gvNaZprxiI9HWddEkhnuYooXvBv5v+8JMLbmA4ngRSmr
 f/oTUd7rnDFuLhRkpOexwXzbAmXjMJqZWdtaEGI0Z2CKc9DDn02q1EnBT4kJ+HUGBdoW
 iOyA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9MagA/GN3CQPGqUhuBgDouXm9czB0I4t797kUIpEOFjNouZgCgcA5UWsXLBRcJTRvK9bBpEPY@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9fSM73UaAd5OhSxC3GVQToV+BTsPDIOm14foji7mOeFZLU0fs
 4YmxqFQXPmoxUaIL4390GRJpGP/+xYLqrGv/7O5YEhqoBG9HlF4rjaVyfZhD7JuOF940rhqTfOP
 qpwGvfn1Nbg98kDgR0c6h2NpW5kzA1BM=
X-Gm-Gg: ATEYQzw7oicLYoUNlrQK8MMPp2C0z0zSq2yiErGv9M7ldJyBMH75gNegsv/82DrQiWT
 LqYWyTSnVnjT4TZIxIrJFrw0EKZUvJhu/u+pvnDuSnXqoG4CQAmERGUQsF9sa5o+IeK1HTbFbFY
 Vad3xdDVtpJ8EbnQ3tiiokRv2AfnTxLPs3E2yfpOj3keblGFA65Lj1ZU1ETuIIcqKhxWLPZ/g8m
 42sCBck6vBfMibsfvQv8QCDJQ/3ig8lnFYrUDrY2O83e2TiDkm4MDLYyCyGgzvAoQ7WPiiPejXn
 Sb0DbdIg
X-Received: by 2002:a05:6871:5221:b0:417:1862:ba10 with SMTP id
 586e51a60fabf-417b9059aadmr400339fac.2.1773348272117; Thu, 12 Mar 2026
 13:44:32 -0700 (PDT)
MIME-Version: 1.0
References: <20260312101334.1500935-1-Jesse.Zhang@amd.com>
 <CADnq5_PXhLYs85cU2FZ6ZYtBBtv1wOmwiJL-rDbYsCFXpTL_cw@mail.gmail.com>
 <d1ef0e7f-ff3f-4012-9074-b87425fa2fc2@amd.com>
In-Reply-To: <d1ef0e7f-ff3f-4012-9074-b87425fa2fc2@amd.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Thu, 12 Mar 2026 16:43:56 -0400
X-Gm-Features: AaiRm53n4ZGmdqvuKwGIwEqYNiyJsW04RCjt5i1dmbtY5AW-BpusKWZx9gDijgc
Message-ID: <CAAxE2A5qX2e8rzZvSdUUbCvz2AN64=HU49pQptkYodOXiv32_Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Limit BO list entry count to prevent
 resource exhaustion
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, "Jesse.Zhang" <Jesse.Zhang@amd.com>, 
 =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <marek.olsak@amd.com>, 
 amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

I have just gathered real data on this and the result is surprising.
Viewperf 13, Viewperf 2020, Unigine benchmarks, and others have been
used to gather BO list data.

The maximum number of BOs that has been observed in the CS ioctl for
radeonsi is 283, even though the actual number of OpenGL BOs can be on
the order of 50k. That's thanks to the slab allocator in the Mesa
amdgpu winsys.

RADV uses VM_ALWAYS_VALID by default currently. radeonsi could also
start using it if the kernel memory management behaves optimally.

Old Mesa drivers might use more BOs, especially RADV which doesn't
have a slab allocator.

Some limit may also be needed for lists of sync objects in all our
ioctls and all arrays in general.

Marek

On Thu, Mar 12, 2026 at 1:59=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 3/12/26 18:44, Alex Deucher wrote:
> > + Marek,
> >
> > This was the feedback from Marek the last time this was brought up:
> >
> > "USHRT_MAX seems too low. Traces for workstation apps create 20-30k
> > BOs, which is not very far from the limit. RADV doesn't suballocate
> > BOs. Neither GL nor VK has a ilmit on the number of BOs that can be
> > created. The hypothetical maximum number of BOs that can be allocated
> > on a GPU with 32GB of addressable memory is 8 million."
> >
> > Does 128K sound more reasonable?
>
> I think so, yes. Event 64k seems reasonable large to me considering that =
only BOs which are not per VM need to be in the list.
>
> E.g. RADV barely uses this feature as far as I know.
>
> Regards,
> Christian.
>
> >
> > Alex
> > On Thu, Mar 12, 2026 at 6:13=E2=80=AFAM Jesse.Zhang <Jesse.Zhang@amd.co=
m> wrote:
> >>
> >> Userspace can pass an arbitrary number of BO list entries via the
> >> bo_number field. Although the previous multiplication overflow check
> >> prevents out-of-bounds allocation, a large number of entries could sti=
ll
> >> cause excessive memory allocation (up to potentially gigabytes) and
> >> unnecessarily long list processing times.
> >>
> >> Introduce a hard limit of 128k entries per BO list, which is more than
> >> sufficient for any realistic use case (e.g., a single list containing =
all
> >> buffers in a large scene). This prevents memory exhaustion attacks and
> >> ensures predictable performance.
> >>
> >> Return -EINVAL if the requested entry count exceeds the limit
> >>
> >> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> >> ---
> >>  drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_bo_list.c
> >> index 87ec46c56a6e..3270ea50bdc7 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> >> @@ -36,6 +36,7 @@
> >>
> >>  #define AMDGPU_BO_LIST_MAX_PRIORITY    32u
> >>  #define AMDGPU_BO_LIST_NUM_BUCKETS     (AMDGPU_BO_LIST_MAX_PRIORITY +=
 1)
> >> +#define AMDGPU_BO_LIST_MAX_ENTRIES     (128 * 1024)
> >>
> >>  static void amdgpu_bo_list_free_rcu(struct rcu_head *rcu)
> >>  {
> >> @@ -188,6 +189,9 @@ int amdgpu_bo_create_list_entry_array(struct drm_a=
mdgpu_bo_list_in *in,
> >>         const uint32_t bo_number =3D in->bo_number;
> >>         struct drm_amdgpu_bo_list_entry *info;
> >>
> >> +       if (bo_number > AMDGPU_BO_LIST_MAX_ENTRIES)
> >> +               return -EINVAL;
> >> +
> >>         /* copy the handle array from userspace to a kernel buffer */
> >>         if (likely(info_size =3D=3D bo_info_size)) {
> >>                 info =3D vmemdup_array_user(uptr, bo_number, info_size=
);
> >> --
> >> 2.49.0
> >>
>
