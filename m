Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B48CA5FCE
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Oct 2026 21:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79E2E10E084;
	Thu,  1 Oct 2026 21:25:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c9wCVeXw";
	dkim-atps=neutral
Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com
 [74.125.229.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60E1210E16A
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Oct 2026 21:25:29 +0000 (UTC)
Received: by mail-dl2-f42.google.com with SMTP id
 a92af1059eb24-141a5d476abso248436c88.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 01 Oct 2026 14:25:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790889928; cv=none;
 d=google.com; s=arc-20260327;
 b=InEV9OFhlwUgsYRIWN+PGEK0LFBP57UQ5kDVoPr+n80X5vuApl8Yi7M7wyECoZA7uB
 4maoZ2Ev6Q7B9r+XM6HXr5Sg6MqSwZhgV1rdgojdHOX7WoH5q7mSdiMo9xBsoGZiaiP+
 Ng1CAYMbRmVXdrg3s2YA33s84hLvgQ02oT+t/ruclhcarEEQokEJ5LhPk+T+wnjWICpw
 4sE0VjZtBIaj924sX9FEEYnaxO24+R6mH5MaKYUe+Y/mFxLIVFt3Hj9gL7XwVpL347ig
 TW0K+PCrvVKeHo9WjPK8tmmJV2y5oBu8Vj5p6VTDkJXmKjQoR8adCHZsYxevb0hLPjaP
 v/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5GZNCHW/qlhPtXqDEzh3nk1y79tZZcg3UYAAbpf8jd4=;
 fh=C+L5WB1+UElfqfjzmCOq9z2+ZcuWawpnQAdKALFGCqA=;
 b=UztBPX06zWiUPSKmH2zjD8Hb2MuW4aZhNXwBEBJwJ4b61mtkUD8DOTUmRn/XX5CO04
 MB3LdEq4ZGGXqgbc4Zxt+4AIwUXAuSxE27Rm6bE0WJ6GFtewpknNBkMtTu/e8xbvHGum
 vKLDc+bU9nrfDgHYnU/yyaGnlSsgGUeJEwFSb0NBLumFC8R1sTKjtiDfM9M54DojKUN3
 bap29lCw4oipZ3DGWmnNq72SqDIK828Dukbz0XN+Zwvmmj3Xhn6THoWWNpg1Bioawex0
 lyCxu4r5BOvK9cuT9iYLfM23DAweXUJfHoRYG6I/6k6xdy2GafKmdIfm5y1VzRASkbW3
 NEcA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790889928; x=1791494728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5GZNCHW/qlhPtXqDEzh3nk1y79tZZcg3UYAAbpf8jd4=;
 b=c9wCVeXwKPBzqX2qsxitK5a2mLNU3lcT2z5iyV4OGdYb4062D7Wm+OTiqmklG88Q4G
 pOWnJR9dXdHyQt5FqFSUGAo6/hHVBt20GKAYlK+5t0BR/atuUBfvMI0AvleoJ3RX8Il2
 psFuYLiT1/QXHaNezYHp2jmwMLY3ME99mF4ySpQDg5S4K8FQdxvzXEain/oUZI80N0+E
 v8nxhM4cnKh5FmzLudHjb6jyfuU3eV42MfxG2ODJ5MHallWIAfxXEN2BN9JdFR/fttub
 5OxZ3znlVZI2+ALFzHCzWKqAckBrNxPTefu9rv/6or+1D/vOezQA+aSR0GWK1R5j1fV9
 MzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790889928; x=1791494728;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5GZNCHW/qlhPtXqDEzh3nk1y79tZZcg3UYAAbpf8jd4=;
 b=Z6zw+8nEmoEGua0bNrlwhJpzWtcjt4uG53QiSKNsa2lL9lblC/KnWkuNGZFSlpbEte
 I+Gt6BZGREE/cMbAGnFd5McGOGFswx3C6HU4mNtGXqoA+58kykvMrSS4GomFo3IZhvqp
 jubB7E2wBObL2navr8e1PGLQUo2BrvSrgPoDncDoFFgxOAukDoURmSueUSB9LbNeYs+P
 bqZODQ83GpTsJrBj1Iw4+Cd9op0L/01ZO7gEDIM/xiJgmr1KfsGwcKJ8qH0XBlguWuqJ
 0V13/nfkM21680Nl+aHPDSRpSL/YyWwrKkvMLBmkL4xhnxZs5lzpk4w3JvG1rhPk9xas
 v0zw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxMnSiSV5JUacrb71ix2H4nIQHqSaC4MfAJ33d/EREZ0t2HsnVw7asAnDCbgptkMqYpV1sDunv/@lists.freedesktop.org
X-Gm-Message-State: AFuF++nYThMhh44WoeGVyEeU8G1PP+9tirld4EmtSXOOJIlrMD6ypqxK
 6QG14GC50c9VeezYuFzAQswpJppqxxMJ477AZUZCZ8LSgq3AicbCHqprdG54tTLPpIo0t7uqHsg
 0GYV/FnYF1icZ84gQlFOhvWwiybpb2ac=
X-Gm-Gg: AYBFou0KCCKXhGX36dMVZqpcpy5baizVkxQ1SFQfZThDtAJDWaR51GKt2nfTcOc7/oZ
 t9p4L4L9QeYqfnH+Rz+IpX2dPNCqP5zS/d7ljuv6a7qjmQWmlhRQxEeKXVoM3ahZ+9hybfWR6h5
 St+l7AwIpakPabXctcuApkYONu47/apXrxmoFOoXCdyodimoxW6nFsW8pewEvw1VirL9emqpPv2
 SKx/rhT9gIS0WVYt1X9zvEyUQ0KSbnGClFd7phen2IJfeL/9/PouRlyqgOTFdO8pCHfH8x2bgqk
 XEn6VX0bKnGPy2fIL9qpdegDtobm+TY7F8SUEx75p7BL4KEq1hvoDYfa0jQEnpV/5BubyPwwwYG
 mdn8uCiXkI8n7HpD2sV+eHJfXV+O0deqWOAgTLLEmew==
X-Received: by 2002:a05:701b:4550:10b0:143:8212:a43 with SMTP id
 a92af1059eb24-14f5a93aa43mr676637c88.1.1790889928421; Thu, 01 Oct 2026
 14:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260917104234.18858-1-spolack+git@mailbox.org>
 <c5548cd7-c00f-49be-b031-c331bca4eefd@amd.com>
 <17aa0846-f46a-4e9a-a9d0-c32e2064fcfd@mailbox.org>
In-Reply-To: <17aa0846-f46a-4e9a-a9d0-c32e2064fcfd@mailbox.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 1 Oct 2026 17:25:16 -0400
X-Gm-Features: AclHuK9_8NKF8zd9HPiewBn7wQI1aa7TyGAtmHWp7Nk-vAP7bdzpLdd8AFezYeo
Message-ID: <CADnq5_OVbRMwQ1j7j-RV_V5T0y+fXjhZeDLxER8PgpKamv0CtA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix stale replay_events after mod_power
 stream removal
To: Simon Polack <spolack+git@mailbox.org>
Cc: Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, Ray Wu <ray.wu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
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

On Thu, Oct 1, 2026 at 3:36=E2=80=AFPM Simon Polack <spolack+git@mailbox.or=
g> wrote:
>
> Thanks for the review.
>
> Gentle ping on this one - I don't see it in any of the amdgpu trees yet.
>
> Since the bug was introduced in 7.2 and leaves the internal panel black
> after a DPMS cycle on multi-display setups, would it make sense to take
> this through the fixes branch for 7.3 rather than waiting for the next
> merge window?

It's going to -fixes and -next this week.

Alex

>
> Thanks,
> Simon
>
> Am 24.09.26 um 19:25 schrieb Leo Li:
> > Reviewed-by: Leo Li<sunpeng.li@amd.com>
> >
> > Thanks!
>
