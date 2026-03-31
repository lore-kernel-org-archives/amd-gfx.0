Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814D7109B46F
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 14:30:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2172810E19F;
	Tue, 31 Mar 2026 14:30:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L5lck+M6";
	dkim-atps=neutral
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com
 [209.85.210.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44BC410E20D
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 14:30:54 +0000 (UTC)
Received: by mail-ot1-f52.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso3205703a34.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 07:30:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774967453; cv=none;
 d=google.com; s=arc-20240605;
 b=AFQpcZk98GaYqz7A6kpV1I0M4019tY2S80FdAbVmDHv2vMflCcDOttAZ0WGFrdFVHO
 hkVFdeJ0fzuCqeHUku7y0/vQRUkCgJfLfnKlfB9SxAz5Fuygrw5UEZc6aEhltWKEksId
 l5y3GEXnFiAarcvxJ5SCoAUgQTSYfvpoWCKz1vWHN43I7WxDqFF/1TE0jy43+9dUFXyv
 D+dp6Ai5gRNlZdjYDnlM8v1A6990yCq2HPImudyj/Q0xvwUUxthM42U2X41I2jg1YwJ7
 RbkhyBc581FGyzCJXjyWdR4NgMlbCXjT21cCsK8f5CDlGv03NwjGjBCqRahJw41nhB9y
 Kc6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2I2GOnwJGHN6Hk1IOfct2T/Z/4LB+r2ueeglPMg3SO0=;
 fh=OnnuHVCWtw7X4tZA08IhoiOlJhNM5b7It0NaHrg4+hY=;
 b=LZYuB/p5/lvK9GTw98Bvj1SIZD6HXeRJZ1gGnUdtzR+CYxbRar/yortJ9d5Zr/slZB
 Pn2sDfOfZSC31+JR3OvbXUNcToGWvmVsW65WTNNqJFHRgX0bdiC3JJ8c2tjvjaB4JXm3
 mKIK/KKsQldaxDxu62sR0tNkuTllJlay1FBPJkFcHF6b8EYDGxuqiEtlqvgBSIPqZxYl
 nMTeG04b0CKgm3ff+fhd6kLHGCtfP5jZ73qlWUiUlBRgxpA67V6tab4AJ+6Ep6Cqqm3s
 m3rRRoAkl+fXinIdhFiraAyYkHWvxabSsxVVb3wuGcMHd7zQzirHSd+W4Pb8EUaPLX5T
 PrQQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774967453; x=1775572253; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2I2GOnwJGHN6Hk1IOfct2T/Z/4LB+r2ueeglPMg3SO0=;
 b=L5lck+M6aNVN1o1d6fRXncHhhLYZZvQsPyZMUvNNnrvTu9KR9Oj/QaCxUkIHm84OV5
 gBUVgilSPSBukhEaz3QUAowyvIFmiSDLPGSuezWwflb9P+GZyU56coM0d5nWosgL0pfm
 jLusrjDP0fg3p6zHTFRLxyWc+w1MTq81WeXph2eOg6r2BOcG3knfgbe6nxFmmHYWTTSb
 +tIVxq69kKYuhtUNJ/9tZPnpclZQYVnSyvx+AHoLzTCAYfkpc1ayp7p/v4aOu26wctDt
 PoAQlADetnc7dlYQR/mKXZsj+Tc+6T/BKDJqnSYy64rZl6eQ457Ci1Fup48VJhNHwYkd
 2L9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774967453; x=1775572253;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2I2GOnwJGHN6Hk1IOfct2T/Z/4LB+r2ueeglPMg3SO0=;
 b=AIcnpDg9hoKpjD1eOWQxWN5xCGw6SlRaYKPGXxkITAmDjVHljPU1Xhd/N0vcdg0K1R
 21OQKxY0pAEdS9d0sWsqIDcwX/V2C7Qa3rUlrwpJPYcUwxIUbuMBFqnVrNLBHkfzxQ2c
 WTBJNVwXLojBrLINIjjdxoUyyrb+TkjxrNRNhiFQii2N2crbYuLDnmNiX+4CzKADksDQ
 Vv6g9vOecjYQCMFV/mNdR/4dOk2eFGqY5EZKeBMvC4muOKnU86qsEfvQFNTCAIo8QjRN
 U0spGLjyjULvE3T0FrdByBDG4067Mw9yp2KIQlW+4uLXbk+YSNcgr+IsziTg1L8BVXYy
 mt2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWonI7eeulweAWgXbIyIFfdUE0634Qm/XN3rgkVK+7xpzNbOuQzxTOSAGM75L5jdR2s1eXFi3VQ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFmysVh5c03A8Hop11Vye2l3n7AcZH3BYY7gfB5116sRNeTt76
 VgVR4k84dKEHrmonpmxF7tHvjziEShEhuod05lXVMmXJjS/kFzRY4/DFRJBTzoSIfGyM/XlVzPa
 NpYv1q65zwBrOwppS6bUDXLrvYSPwRaU=
X-Gm-Gg: ATEYQzwMsP16eE3+TB2/mXeI8FTt8cnfvBJRwNYzjASgOmMWDIBnkkl1NRURegLCxoE
 R8Ghru+WP0gWqrqk0DmXAPb5NRMiSQZbxBavMHXtD/43yV+5sFPXi9Ju/MqYAqt5NeKMAIaCCj4
 sirRf8owQrKJ+IGTrsHIQuNoay5Bu29bQrSwQFvyYO7r0o1XSn3dCwRkA9X/BViDvGt2Dj1N0WU
 7PjmpwzStYo5VG+Paq6cZqJ8eW1kcanuAZwLBf8mF/svtF1P9rA5GnzENtzW0UrksGbDPDEF7nF
 O20aU0+X/Q==
X-Received: by 2002:a05:6830:6f90:b0:7d9:d54c:6fa4 with SMTP id
 46e09a7af769-7d9faddcf96mr9909225a34.11.1774967453015; Tue, 31 Mar 2026
 07:30:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260331111808.16578-1-mikhail.v.gavrilov@gmail.com>
 <2fb67e0c-c7a2-46d6-af24-d67f704cac6d@amd.com>
In-Reply-To: <2fb67e0c-c7a2-46d6-af24-d67f704cac6d@amd.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Tue, 31 Mar 2026 19:30:40 +0500
X-Gm-Features: AQROBzCIHC5-xaM6l3fB1g21rjj0eWZ0uNmbi9Ja_jt4CDwm7N3S2wRYyKkKeaY
Message-ID: <CABXGCsNcutmHieQR7bfw3c3+8ZhLVRHsgtA+EqbCG7xtEBn4Bw@mail.gmail.com>
Subject: Re: [PATCH v6] drm/amdgpu: replace PASID IDR with XArray
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, lijo.lazar@amd.com, 
 Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org
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

On Tue, Mar 31, 2026 at 5:28=E2=80=AFPM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> That should be unecessary. We already replaced GFP_KERNEL with GFP_ATOMIC=
 in Alex fixes pull.
>
> I would turn that around, e.g. if (r < 0) return r;
>
> Apart from that looks good to me.

Hi Christian,

Thanks for the review. I've sent v7 rebased on amd-staging-drm-next
(on top of dccd79bb1c7f) with the inverted error check as you
suggested.

The Fixes: tag now points to e6d765de3d6b which introduced the
plain spin_lock() for the PASID IDR.  The sleeping-under-spinlock
is already fixed by dccd79bb1c7f, but the IRQ safety issue remains =E2=80=
=94
amdgpu_pasid_free() is reachable from hardirq via the fence callback
path while the lock is taken without irqsave in process context.
I hit this lockdep WARNING on an RX 7900 XTX when exiting a Vulkan
game under Proton.  The xarray conversion with XA_FLAGS_LOCK_IRQ
fixes this.

https://lore.kernel.org/all/20260331142127.52796-1-mikhail.v.gavrilov@gmail=
.com/

--=20
Thanks,
Mike Gavrilov.
