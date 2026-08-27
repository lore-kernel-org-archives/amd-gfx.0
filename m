Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00553C61DB9
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Aug 2026 16:31:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4520110E426;
	Thu, 27 Aug 2026 16:31:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l+DoBl4r";
	dkim-atps=neutral
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com
 [209.85.222.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4314C10E426
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 16:31:55 +0000 (UTC)
Received: by mail-ua1-f41.google.com with SMTP id
 a1e0cc1a2514c-97c8db9129aso1633241.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Aug 2026 09:31:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787848314; cv=none;
 d=google.com; s=arc-20260327;
 b=Vd3y5D6QdgVtG2pgscUxuCAqoPJ2ZXyC+G5qKBoPZ/X7PzDj0WjFKBDBLSFWAQ93Cg
 DiGULhAW/IbaEZqtAR9QZLCwbDfZbGth1O0AfwAuyq6MTPq5I9l84Wgit2BqbM0+mcxi
 f1CUGIWJw8svoFeEyP0ofvsUuIX/WwNbi/VHf3GIpWuLJQmXFcbVppq0AqK4D4wNRTJv
 S+IubHJ/oWlAS6VhUCqgoAyFAbGGwGiJFU1sOFV3H5X6iKO7Xy5w3m5C1fiDtLtQnARy
 rYDmfmeYJ2Od8bZaRAvpZ7wRXJzceXVtQQXuiLv+GDM3DJqonnTkTLPHbUbVwZaB056t
 tq6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qT33g6rvZvPJM7cbPR+B0YHC4AGweMPsloyJPicfmEw=;
 fh=oDQjOK26XaiRWzLH/TLVEgfss9AYRvBsS8gAKUZNFpo=;
 b=WsSCfKohZ60VBwxc1PtoLz+F8T1y/RRMkdpW70lettFdBTssET+acauGX6mvyO+7ur
 gEO8L6X2a29ubyWAsYQzp1tkqHyxTSwqXdQ1G7cmoIgzik4qckbuPD9KVhbijKT+jBhh
 JnkIQbmyylAvuTv7z5AxqyB3p7lMErMro1oTmMx8ph0dDzSbTkbjlK9KmpZsYJ3SJMUk
 Ko4v4qYcDz9j5BQAxQ9x4YNnPRCOX+L9dVxWVBVEULCTDsCEZdzixxZbJ6HVPMwsEd9j
 Q6e+FQscn/+S2NlnhMbcY6o94ncZaqgemkDq3ifI6kFQ++Fu8A2WfqiP5t/AyYNUXRMv
 Ct9g==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787848314; x=1788453114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qT33g6rvZvPJM7cbPR+B0YHC4AGweMPsloyJPicfmEw=;
 b=l+DoBl4rML9kG9nQ34pb0NiSDDCZO9G7/CpTmzPeyImyxwiYAJAnk3fQNtzgKfSjeT
 AyRASe1nMORrUABPWsBYSlKY/LfC24CkDwMPzCfIMgD01Az/dJEXSMjuHbPDsR1N0LL7
 ygzBRPaSd7kIwwvPVWdZatE+jwWOVx7xQxV3GyHtDXQNG0f71AyciOBfYmQTX0Zp9Q3t
 M6i9YoHptwDL7ZK55TcrcNCIvQ3q9nhISWlU+Z8d/9K1PFxBFsOK3f1GZQW/JFF79VCX
 11VJV/OoFyV9baN9QnjzemomMOJLs1GouTYEMFUMcZiThBPOyN+xio66WFK6HLCNzffO
 YfoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787848314; x=1788453114;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qT33g6rvZvPJM7cbPR+B0YHC4AGweMPsloyJPicfmEw=;
 b=N4voN3b4TBTHZOTMKTNv3LrjXEZUOr50hCUeK+zSvkZLTvw7eoZ9/u5j9TYY76vj4K
 R/azOReHCErffdwmWFm3w3ZTSUbmF4N9Q8cLh7ynUQC7a+IV3aX9cpfJqBCHKCagIeAm
 JqztRW8rrPmlHGX2vG9qeBXsGMYl/fqFtk1fBDpyCYdjbcjsKGjzBwElO3tazDl68UXu
 OkKe4sW4Z2FYI+2bgyw7PrIIs5YS5umHEjagu2ijZtpjAD1YfoUMkCfK9cr7Wg4mYP9S
 RYwnyKW72wmVGJBXv9QxgCcBGP62LM6AYf8WLoXAd/YEdb7J+asa0IQT78LB70G9pXZQ
 Af1Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RoEgByXSF16X1ckxFrU+3Bz5kFtW9mmJRmH2YY8t9vS1a8Fbx28IpwgGk1yGv/RetYuHi0szfn7@lists.freedesktop.org
X-Gm-Message-State: AFuF++mznorXQG56gNGhUqN52VsT//550i5uWC1ZLKq1gaPqDsCkPUYn
 qFCIIvPh/4GfNRUN3g1dowq0h88QX4hSMvIJrw1+kzuEfJFPDWIN19VPQH7oc8MkQU3B97zVfXi
 DMw7s4AEWpqGfUIYPqIZ5ftqVJSSq3mg=
X-Gm-Gg: AR+sD102g3KAeoJSI8cikxzUM4MMf8q4qSi/6RMWXL8YZhMZ3LWRMemNTUOijJJp7pc
 zy6Oa8GoRg7KSUFBXStuNFNYj8iqchGNtv0o1uCOemUt9aLlqLhisu/NOD/P+peOX2hSFWVNHJ2
 zIbquicQVKhu4t2ojlZ46KrjgMqNfL9+vLtlRg1gh6B58us0AkEhLYOXDdFKzmG1yknHz3OZIRp
 8Q+gSPIZolduR2bbzTmz7T8QTcMl+r4WKxr6DahGayZ4ZCKnTn7G6VsReQeVB3A7ewMFidB/vgu
 gp6WbWI8kiZHwdNupbHiIp0pPNyS0wiB6NDA+FvBB1r91/jVbh5eW5W/7h+GAoahdk/ipY4txM2
 semRuwy1Z5cwvNY4lUe847viemLrW4rr1VJMycxgZyQ==
X-Received: by 2002:a05:6102:5486:b0:779:7d3b:1398 with SMTP id
 ada2fe7eead31-783f946a099mr1725147137.0.1787848313610; Thu, 27 Aug 2026
 09:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260827154849.1021013-1-sunil.khatri@amd.com>
 <20260827154849.1021013-4-sunil.khatri@amd.com>
In-Reply-To: <20260827154849.1021013-4-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 27 Aug 2026 12:31:40 -0400
X-Gm-Features: AcwNN1UErAJXX7ywcdfysMSMTIst7naHPnOLnyELKXgNr8QkFLHHWChHuhaklOw
Message-ID: <CADnq5_NMmcga5OZiU1pAThhio8s0n_g6pW+8ON46PEaxuEvrAA@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] drm/amdgpu: fix Idle BOs list in VM debugfs status
 info
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Aug 27, 2026 at 11:49=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com=
> wrote:
>
> amdgpu_debugfs_vm_bo_status_info() prints the "Idle BOs" section by
> iterating lists->needs_update, the same list already printed just
> above under "Moved BOs". struct amdgpu_vm_bo_status has a dedicated
> idle list, populated whenever a BO's state machine settles, but it
> was never read here, so genuinely idle BOs never show up in the
> debugfs output and the "Idle BOs" section duplicates "Moved BOs"
> instead.
>
> Iterate lists->idle for the "Idle BOs" section.
>
> Fixes: 4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd=
/amdgpu/amdgpu_vm.c
> index dbdcd57e5b6b..24113bf4d276 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -3121,7 +3121,7 @@ static void amdgpu_debugfs_vm_bo_status_info(struct=
 seq_file *m,
>
>         id =3D 0;
>         seq_puts(m, "\tIdle BOs:\n");
> -       list_for_each_entry(base, &lists->needs_update, vm_status) {
> +       list_for_each_entry(base, &lists->idle, vm_status) {
>                 if (!base->bo)
>                         continue;
>
> --
> 2.34.1
>
