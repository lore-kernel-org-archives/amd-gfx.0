Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738F606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ANcVz8c1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6982810E699;
	Thu, 19 Nov 2026 20:05:53 +0000 (UTC)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADD8310E699
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 20:05:47 +0000 (UTC)
Received: by mail-oi1-f171.google.com with SMTP id
 5614622812f47-4f8a223a097so4160b6e.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 12:05:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795118747; cv=none;
 d=google.com; s=arc-20260327;
 b=bR+46XsNZOUljwCKFpCy+KzhAorwbaukeRVxFuBm1hrVPYGwol5f9qzQ7Z53+Ybgkh
 yLd3LZ8wAiBHlv8gUHlcI+5OaLOU03xiUGb5blf8AUOvOEMuEbdqEkD3oNSRDbbNqiy3
 p9//zCVN9WBSD1s6TFlQHSte7oltMjb3gF38SbpKiASIcjs+8KwCbHA70uCZpYNOBuYE
 KDspTS1S3nv0n82V9ubLCN7XPNK4RfwmKho9PfFW+wZe+THtEeanDDsqVggnrHkUNwtU
 Qd7hznIae7nH5Vo4sdAF+VeUwMvHDlooQawaQGwNIEB/ReZILc6Y6+XejztIKrhVNRvd
 uccw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EYmG83MVbQeonjuNQdCclMS5e1UaQeEqYzoUyLOu5uk=;
 fh=AaQAxZzbcXGhl8gD4jD3+qP273V64j26XDvwRR0LtnQ=;
 b=qP4Y5mx5/8w5AoFAP0ZhUA/qB1ag+UQ3t8viuDj4ZaUl3wTx5yqdqmXZo4FgNIvlRZ
 BrnqMZX+O5y1E8d3tuXUq+51RWtkQ1XD5ArKwlRXqfAlvtFiMAhTPfMg1zbfW+aI04BP
 E+jxVPa0xdk9CUyTlyOKAUjTdAKx7fKRH/rXjrM5ybdjuGL88hAkhSAW8vWyas5jrWgp
 H9tpamBu3BAJmYHfnlwGG8IOUGl3cojT8bMmPcJY1ZQNvSGgPWe1lcXx933Y/gyPSC6y
 CM3am42MSOw+4lOTH9O6bObtH5xuEZRJD3wUY69pDZ5NON1cSWz1e+b7uxh6OLAmKn3p
 JDXA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795118747; x=1795723547; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=EYmG83MVbQeonjuNQdCclMS5e1UaQeEqYzoUyLOu5uk=;
 b=ANcVz8c1jr9G5OyJkid5kJsaieH2V3EIwoRyjRpBljkEH47AddERNmPv4+NCSk/bi8
 5snLH5cy5STMRpkiaB/sg0YihWBfGoIy3Q8vG6d58hrYMvlMxkI51r4wKTj23VprqW7P
 DmZc60EIgzHGPt0K2uSCKVGU6SZxyWxlB/uGpINIpjYL8Mgtn5KNvwm2O8WLbxg61/E6
 fqXiN47ZsL5ygpofocI+BoZ1NCoi3cEbi9gryny23XJkWQcDrElflw0egDAlw0C97koy
 Di5Dz2yYw4Pon8aqfcaCO8srjiDSJVlKepHQ8uP4gk86auDgnFwp4dwZB7eO4mRrRJlh
 bpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795118747; x=1795723547;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EYmG83MVbQeonjuNQdCclMS5e1UaQeEqYzoUyLOu5uk=;
 b=p0tmolXPOgVAYK4ckWw0IPXxhbRP3VfuMUqBSsZF9064hOrsVUNEARq0MjEzgzfnQg
 nbulNeifDr8myNTerp4kF4jVZ4Bqo0I4egoyKhsJfWmImcXo8z4awrA5VU4ElJvu8CQS
 j7mqSexg4RAgkJce6mnNr95Lofd47m/vY9pGHZR5PfqAMc3zgP/1CRaDzfk1QoFhvcDG
 YYIEI8yhIgUUh+v3Xp8tZzwlPbETPaU+9C/wxKiR/CsKVl4mAwphYgkRAX2EgLEhdss1
 niu/USZfYw1F610XG1Jqsvo87s5tkeMm2xD2/JF1X7TUOuWaIkFkbbwaqAss4n/3tH0e
 dqIA==
X-Forwarded-Encrypted: i=1;
 AL+hErHfBwJxLkYthByaOGH6/Wel9LYHlwdt0owQ4XrSpzEVkXoWi4nCr/BgI5kBwx6PJOPVVi1c7YGL@lists.freedesktop.org
X-Gm-Message-State: APuU4Z87wukSiCNlhTQIlHAVsIyJXfDfOappwhHVh58DvEC6KnmdctD6
 tfXKedW7R39qas3MEyrNUX4/Weuuq3TvP3Sd+rizoPp6PfP7YFQl1CPu6XH/swGPqJSQVaC0En+
 upReqBMoAOD66cXK+cWNELIO5DaI/nmdiNSDH
X-Gm-Gg: AYBFou1zT+BHDTN38+WnM0Blf5UuXy83OlTW7pUfDmzK6MEKGz6cWUMv6UMvW3UrVAh
 0EYKBifOazAL7hntJRYlaj4piNdgxEflhjmHlLrmV0QJYeco43fvQn+u4PtRi5+SbQmkD2vY6eq
 R8I3C2RhIjPE9RGiTMOfR3dvpqzTp9qGM4KIDhiHasAl5R3PeJ2baT8TMrRBqhuBgA2FPpc4gkX
 mPaoyDWGJCZPFdgCZn39y5cRr92v8J86jcx5xp2PoxsOOvzhYesTcyCqoOs5u4CnVfDXwY7fzy0
 uNY74wzo4dzocW1KhKgqQ+g6uJnRsZ380JN6KheJSbWiyoDtAD4+0j1mYbWYbUqbbRueMVdNLLG
 9mkHkm8xZo566iepA2kXyoPt8X2QKMZCm57KMXTqnJi7mJl06Lw7s1iPzGbNbAcdMms2TYCEOVf
 oulxdw1eny2DaD4F/FByIUg8CySFxessq+JlhpOlIgq6LWmSEeHcNpzsz5wdCc0BEsuzfx7fOx1
 +M/thgl
X-Received: by 2002:a05:6808:3199:b0:4e8:b729:3ebe with SMTP id
 5614622812f47-57a0b953d28mr1557111b6e.4.1795118746795; Thu, 19 Nov 2026
 12:05:46 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118080513.1677783-1-srinivasan.shanmugam@amd.com>
 <20261118080513.1677783-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20261118080513.1677783-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 19 Nov 2026 15:05:35 -0500
X-Gm-Features: AclHuK8g0A8GL79GEUPNcbD7SsmvpvYLN8pR_Np1njArdP8aDD-vG5cWnJzxGR0
Message-ID: <CADnq5_PDqt_gve27uMfBhE+AccFjA3Qj8fVVNp_AzpFfKwCYhA@mail.gmail.com>
Subject: Re: [PATCH v6 1/4] drm/amdgpu: Add CWSR and second-level trap handler
 infrastructure
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Lancelot Six <lancelot.six@amd.com>, James Zhu <James.Zhu@amd.com>, 
 Samuel Pitoiset <hakzsam@gmail.com>, Natalie Vock <natalie.vock@gmx.de>, 
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 3:21=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> From: Lijo Lazar <lijo.lazar@amd.com>
>
> Add the core trap handling infrastructure required for AMDGPU user
> queues.
>
> This includes support for Compute Wave Save Restore (CWSR),
> integration with the user queue path, userspace interfaces required
> for trap and save area configuration, and the infrastructure required
> for second-level trap handlers (SLTH).
>
> The implementation provides first-level trap handler management,
> trap buffer allocation and validation, trap state allocation and
> management, save area sizing and validation, and the infrastructure
> required for second-level userspace trap handlers.
>
> The common trap handling implementation is provided through
> amdgpu_trap.c and associated helpers while preserving the CWSR
> functionality required for user queue preemption and recovery.
>
> Suggested-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Felix Kuehling <felix.kuehling@amd.com>
> Cc: Lancelot Six <lancelot.six@amd.com>
> Cc: James Zhu <James.Zhu@amd.com>
> Cc: Lijo Lazar <lijo.lazar@amd.com>
> Cc: Samuel Pitoiset <hakzsam@gmail.com>
> Cc: Natalie Vock <natalie.vock@gmx.de>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> Co-developed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   5 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  10 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  20 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  31 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.h    |   8 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.c   | 764 +++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_trap.h   | 143 ++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  |  24 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h  |   7 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  13 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.h    |  22 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c     |  14 +
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 107 ++-
>  include/uapi/drm/amdgpu_drm.h              |  27 +

This patch adds UAPI.  Can you drop this?

Alex
