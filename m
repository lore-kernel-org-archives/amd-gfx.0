Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F36C531FB
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Feb 2026 14:05:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4214B10E7DD;
	Fri, 20 Feb 2026 14:05:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hdHVxH2L";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7185110E7DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 14:05:05 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-1273882d901so140968c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Feb 2026 06:05:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771596305; cv=none;
 d=google.com; s=arc-20240605;
 b=NCaAmzypyGAMoJA+S//XeemKNeTtHztZ7lVJxcDy45e29kiAMn/KdbZ5hpoQxfMsL6
 /9vpNKvuIJ7uoO4YV7QB6lCL5gJooM2u2SnG+Hfxvim/0MDUucYvxItO7xcP4dlM5wbs
 f7Xa9WLifXt8QOo/l76XpWBqDjQF8m+DMMTh/4/EIjtDiIz6ioUEF1DmlELMkE+5U2By
 XHjKh5w9aS9tgr5SII43vlnM9UrII45ENFB5p2paI4kpk9mabG45GNJqkyIuh0xYhDQg
 UtVdvJu47EcSZqJSQPaI58PZj9StZ4k9xyk6nMGsWmZ/NrBKw3CugM3DRSt2YPP0o0Oo
 +rEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=FPvttuVwP/jLQJxHAXWjXp+VadIDdSPJt8bb6QigyBA=;
 fh=AxYD5MC9m8GVqRhBvMZ1pWxSOic938T113E+MfvNaU4=;
 b=Gm0PntA5zgQcg9sDRqMJsQSD882PLo8I94BdUPa2tSEGgwj/yPvEEKc/rAmxZXilhX
 Ew4xEiTi8s4KS9hw8+hnWow5hLZRHkY8yBPLkm+RFh8QA5CdP8aEMGgK2NhLP6cPZN48
 zs6u+aAZkkbzn9spAggy7JYC8Pl70DhWdL5CsDc+xd3qCrm7e2I+2v/CFAQfiLoT9uqb
 AvBDhBC5GF0waNahm52zCZgrTMIREq+yhIlHhEt1rH9BwSZKwUKjOcTaS7J+ZaH8fWdc
 ZtMI1GKXGNvEmWb76VufgaX0yH3lxEnNB/8t95CY1SeGs6lGMCuI2ufMrOFykVLau3T4
 9DkQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771596305; x=1772201105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FPvttuVwP/jLQJxHAXWjXp+VadIDdSPJt8bb6QigyBA=;
 b=hdHVxH2LsMGSXXMenk0cIt4eqxTZPRihp4+jCHglrAJG33u3vEjxBUh5PUGRU+BX1t
 7JqxJEDNQIDmlVtFzHEPCm7N1yOXi8o0aaNoF38UItqVIDvVroT31Fv/MaR/BWVDg5pK
 jBiO06pwdb2dvOf8J9VNeN1RxF0Vkm1cuZhuLwWgbnq2hnBvErN3/Gzr+q8Pp12d4IlC
 HZv6En//P6bIp3pBia4eD6jGVoQDm6+s1AJ80WTcVPhrh56MGbCpHOyjJi/7yqE100N6
 JjOKTXZdFawCk3kQJyicgtLLdtCZJr/fZXiyeDAAcdFd9USCxp5+omnEEmA9qfHVtKUJ
 tW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771596305; x=1772201105;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FPvttuVwP/jLQJxHAXWjXp+VadIDdSPJt8bb6QigyBA=;
 b=E/sQX6f6QyjMjvq1GuUFa5hHY8mAXVn9sSvwIvXc8X+LNuuchbrca3tJxUAUx/zplb
 Nx7dCZw84XPqgQaX36taqj/32MzvclMdr0ExN7tGwQ0VWYucCnibh7KqDN49CXTzJwUZ
 /0fn3zKfJk1f6/qifYrOMe5JKdhb5R4eDztxx7JgxEGNY3RErhAix6O+sQe7qaOgOv/6
 tBMc1zkth2itui/uxOUHM4DcdXTS2IVVXtK6DN7q4Kmqyc4pbsKSKfiIAeV++o9zXbMC
 PM6JuHM/qKBsBxBo8cYB0s9St8gcynH6A+rUJ49ZqpOPX9oYEBA+WHWXlXxTcclJcOox
 1hmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtGPfNJEIgJvu8J9F3MjdMlwUvtA0vhwP+wU53trl0ryurt0zQTD0a+ZdyS1oRSLDYoPKPrPRS@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yya7GB0h4Oru0gUu7kYeDWIX+vV6xi6LJ/4sE+E17Hfddl5uJyM
 +c8WxaI4aK0Yba/r9CX+Gw42S4BPLSvVjg/4Tqb5zRi9uMgGenec6bTxZ01ubF++0+EqYysG6jF
 BPM2qGXLE/m8GkLRqaf/c5K0NiOurLU0=
X-Gm-Gg: AZuq6aJgoTLbMf6PIyuwe7LhpmK1glJw51uDDqngPF+6iPjHfPx+9PdcP5SQBn5QXjQ
 5nuT06RdWiI3C1FVE1FIQ7NlL0IGeb4Baad8bwf4P2Q//m1VK+z46cZqzACnwkzX8nBzLc1SWcq
 m1gXuxLO4E9PBB5mkEOd+Pyd/Wmp/IQE/xNtyWJ9E6B/c+zb7lsdForXYSzd3rt7CdqjoIkcPox
 w/BOn0GupJtBSB8HNK3OyqPEfVmKE7K4F3oiFFdkwDPgF2b20rwV9lGr4yzSx0Or+cgxlDor51D
 2kJgol6cG36d0cyMTBYwxfb/RycKP7KQGblL5SL1uv3ReHOIyv9j9i0h8A2mTNBuPgR3M3tC0NQ
 9WH4o
X-Received: by 2002:a05:7022:ead2:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-1273979e682mr5258287c88.1.1771596304456; Fri, 20 Feb 2026
 06:05:04 -0800 (PST)
MIME-Version: 1.0
References: <20251205134035.91551-1-tvrtko.ursulin@igalia.com>
 <20251205134035.91551-7-tvrtko.ursulin@igalia.com>
 <92caea0a-470a-4b76-b2b2-23f5af0a4d6b@amd.com>
 <e1d8e922-8ad9-48d1-b5e4-d9d8cc2af8cf@amd.com>
In-Reply-To: <e1d8e922-8ad9-48d1-b5e4-d9d8cc2af8cf@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 20 Feb 2026 09:04:52 -0500
X-Gm-Features: AaiRm51XFtBsQk9CNGFGr49AIHUS3jDmUAlL2juUEykUbmOGWWzUUdGSVg9eL3M
Message-ID: <CADnq5_Op9qsUGgmM7J=E7KaEWDV5j371T7DvJbxF3TXbOUJ-ag@mail.gmail.com>
Subject: Re: [PATCH 06/12] drm/amdgpu/userq: Use memdup_array_user in
 amdgpu_userq_wait_ioctl
To: "Khatri, Sunil" <sukhatri@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org, 
 kernel-dev@igalia.com
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

On Fri, Feb 20, 2026 at 8:44=E2=80=AFAM Khatri, Sunil <sukhatri@amd.com> wr=
ote:
>
> Can you please get these two changes merged please,

@Sunil Khatri go ahead and push these to ASDN.

Alex

>
> Regards
> Sunil Khatri
>
> On 20-02-2026 07:01 pm, Khatri, Sunil wrote:
> > Please make sure the changes are made for all memdup_user
> > Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
> >
> > On 05-12-2025 07:10 pm, Tvrtko Ursulin wrote:
> >> Use the existing helper instead of multiplying the size.
> >>
> >> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> >> ---
> >>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++++++------
> >>   1 file changed, 6 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >> index 7aa26e88c8ec..f979e896c714 100644
> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> >> @@ -618,21 +618,21 @@ int amdgpu_userq_wait_ioctl(struct drm_device
> >> *dev, void *data,
> >>       int r, i, cnt;
> >>         num_syncobj =3D wait_info->num_syncobj_handles;
> >> -    syncobj_handles =3D
> >> memdup_user(u64_to_user_ptr(wait_info->syncobj_handles),
> >> -                      size_mul(sizeof(u32), num_syncobj));
> >> +    syncobj_handles =3D
> >> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_handles),
> >> +                        num_syncobj, sizeof(u32));
> >>       if (IS_ERR(syncobj_handles))
> >>           return PTR_ERR(syncobj_handles);
> >>         num_points =3D wait_info->num_syncobj_timeline_handles;
> >> -    timeline_handles =3D
> >> memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles),
> >> -                       sizeof(u32) * num_points);
> >> +    timeline_handles =3D
> >> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_handles)=
,
> >> +                         num_points, sizeof(u32));
> >>       if (IS_ERR(timeline_handles)) {
> >>           r =3D PTR_ERR(timeline_handles);
> >>           goto free_syncobj_handles;
> >>       }
> >>   -    timeline_points =3D
> >> memdup_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> >> -                      sizeof(u32) * num_points);
> >> +    timeline_points =3D
> >> memdup_array_user(u64_to_user_ptr(wait_info->syncobj_timeline_points),
> >> +                        num_points, sizeof(u32));
> >>       if (IS_ERR(timeline_points)) {
> >>           r =3D PTR_ERR(timeline_points);
> >>           goto free_timeline_handles;
