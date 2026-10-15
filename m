Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EEECC6B33
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Oct 2026 13:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD28110EBD8;
	Thu, 15 Oct 2026 13:31:43 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BA7E10EBD8
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 13:31:37 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3584f70a5aaso695308eec.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Oct 2026 06:31:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792071096; cv=none;
 d=google.com; s=arc-20260327;
 b=jumkECnGK/K+jQ0l5gkgACBix5u8ZwwjYVDcpB/3KykYdxdwVmu3fgoPDsbFLrsIOf
 11CLM1iwaAqlzZWRlqGfQ33ApxixwwPtFvwlTtifqb6jVmwHVyYbzu00vnlk9qrGESlJ
 +2ddiTTOJwa4bXlfyQov9sECciJlT6b/FUwdzvxf9inaF2syJkqnR2K13QUaQEUzEXLL
 u0JMGGCCQKGArKooi22OJx5iN0bHB5da4fpoLqiHWM1Dx8ouEapLb1ceoGGQr0R0pFPg
 ZSdSlAR7IfP1dfCwoxwlWsUoemrxxkAZBhhJ5cxx3T2gxTEqJE7MTpYnhRIS6Y7avdit
 3cwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=QApmXxg7MwJF7cN9FykhLPyexb+qvhQ5FPRBd4FC7OA=;
 fh=k9l6oN6xMzmOSjS1+OWxxeKdJ9uyoG4HL4j2ohlEZ/8=;
 b=n18El6zMTJ3GAwDGRUHDkviWbq3esLplrSUSdiHdmRQoH56owkU3bqfVg7jnLlRBSY
 QesaNSq1hrCibaffjzE4T/ruZIYq5KN5UXlCDjutm1yvBK/hz2dU/LyVNLppKmpv4MjI
 z/MYAqrOuyzOFuh3iMvLL/CSCAzdrvS//YmX7BslSTu9tTJ4iboOwiNv5EvdLwx+uAgu
 pYDXSv6mqJaWRkLXA8mjQzpB+O6ARTPI/QnmO44huQJXvkbyOvu+0PTSppLK7ImyaY1q
 GmOdneBNeV9gGKR8rbYJDgLLf1jWiboxGE+btMZ0tjmi4RvN1S6K8OUixgKaacDuONsQ
 aXqg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792071096; x=1792675896; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QApmXxg7MwJF7cN9FykhLPyexb+qvhQ5FPRBd4FC7OA=;
 b=auOYTnASjZK9qQb3xPCc5bpoc9IbvdmIrDFIv0IpAJNm41XkFQDz2oNMryt+8iFRul
 XidkWilgtrg3SsowNQES/7M0PONPoMX5cFjpluZ1EGBeGe6mNNhPh+YhDNWBmGKxi7Fu
 6tDbjQOF8fwyV0OTuFnDs4KA2shBFaPJaponDTlTu8APzH7cQljqSIvD3hkqdcXvwvsE
 2q3HM2diusMyyOyYCPnZPJXQcVNMSW369wNcS6Y78MVYdLNEme8U2f9TDEkHWNPcSI2j
 uP+mDwohZro9aV18j1Pmbx3ini3IiKILOaGCbYRy8oJjEUMgxBqYYvv1kO9If0mBSMwx
 yUSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792071096; x=1792675896;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QApmXxg7MwJF7cN9FykhLPyexb+qvhQ5FPRBd4FC7OA=;
 b=coEXD55n4XrlCfx+TAprrFMyetKZfWyA2tfZzkFuZE+w4LYq1u9eWrm6lh9daDmKpw
 FERqLtg7UM1Pcat11v+wF/SLuOwKVCWd7sPjI3Ca4Pt9T7nvm28JOLHtmWTfSJuRObGW
 QZe9u7W5xsjTy/ZZKaCOXoS4aHCAGpkYKsO2EiqPT4ALDYcRlW9IJJdAc0ZckTzl0Qq5
 kBvVRiNriKa0qTwJEoRvoEfSqCYF/ZXBQL4Fn98ewOzXWzA7oZviStGdOR8TzcMyNpED
 QQAZH0dPpY2ckbYhqBP6vGTItRx7LK4xBjYaSBS2gcJ1pDK7GFpwShiWLMGWeFyc8AJZ
 5paQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwQlcouJoOoANLvBo2PkAWg3Xzo4ts5E88Inkyxp6/g8SYCp+Rfi4JrH5LX96RUJaxpkb2BBty3@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJp7DrHG1UKWjB6LJpjoDEhqRqBL0sbKoNft3gxa6TeuIZpwdNj
 zTTD/tbl7zF+/NzDuOxHPiYZOPbLPQi4Ku+lnsNgRdLt4+NnQ6WCkQyxwv+fsUoMgTqAGm9yeOz
 zIj7xl4V4fp6/Vqj2o5FgKvFNr2aUIDc=
X-Gm-Gg: AYBFou0uQXqVPtlpMeVxcGomn3HHVk99gEqWMTscyJ/0NtoN2/kf/pzIib5PnvbycOH
 UBsAxf8Alob8RUVnHP2NXXGtvLNnSVm2xipWSDa/mygxwG7b+4HwGBs+d0sgFRPOAJQKrnAdHKg
 kW/QPficeQWB9Gf3q01K0qudQ1kBjUFEkfawZDWT8oXM2o+ikQ8swfGKvqT+KbEgTtQSksc++28
 iWiuwZ6VC0/dbDjZxVksTHssWU2Zj4mh5ebprAttCpAsSGeJzkEeZMNakD1WMTsxyTd5hTJAJbB
 03GDFW+khEQxDKYwdj4t5CiiLGOCj6RABuNBjuj+s5ejSzxYUvnRb1Vq5utEpkuBVtaa9XDhfds
 kIFoyQpac5wni7aYEckR0165uEA+pcrhub0xIYIjrtw==
X-Received: by 2002:a05:7023:a5b:10b0:147:d430:7322 with SMTP id
 a92af1059eb24-16a5bc5bd84mr37714816c88.1.1792071096077; Thu, 15 Oct 2026
 06:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_O=kVgSZoqe_ZVQDmVTWNb+OZ2XhmVx=0CPQQfCaf2idg@mail.gmail.com>
 <20261015002344.98683-1-williandossantosdeoliveira287@gmail.com>
In-Reply-To: <20261015002344.98683-1-williandossantosdeoliveira287@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 15 Oct 2026 09:31:23 -0400
X-Gm-Features: AclHuK9ZmUn4FKK7SEAciymXYIUH4N4bcGFcrSo8pT-xgjBou-x7Yj183erpf3s
Message-ID: <CADnq5_PnCPpWsDDWBD4RicjxHQKTV+_MALbpzx28BoVej4qiyQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu/gfx7,8: remove redundant RLC cleanup
To: Willian Oliveira <williandossantosdeoliveira287@gmail.com>
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Wed, Oct 14, 2026 at 8:41=E2=80=AFPM Willian Oliveira
<williandossantosdeoliveira287@gmail.com> wrote:
>
> gfx_v7_0_sw_fini() and gfx_v8_0_sw_fini() already call
> amdgpu_gfx_rlc_fini(), which releases the RLC objects used by these
> IP blocks.
>
> Remove the duplicated explicit frees of clear_state_obj and
> cp_table_obj.
>
> Signed-off-by: Willian Oliveira <williandossantosdeoliveira287@gmail.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
and applied.

> ---
> v2:
> - Keep amdgpu_gfx_rlc_fini() and remove the explicit RLC object frees
>   as suggested by Alex Deucher.
> - Apply the same cleanup to gfx7.
>
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 8 --------
>  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 9 ---------
>  2 files changed, 17 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 5fc19fefca81..7c56e36665c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4454,14 +4454,6 @@ static int gfx_v7_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>         amdgpu_gfx_mqd_sw_fini(adev, 0);
>         amdgpu_gfx_rlc_fini(adev);
>         gfx_v7_0_mec_fini(adev);
> -       amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> -                               &adev->gfx.rlc.clear_state_gpu_addr,
> -                               (void **)&adev->gfx.rlc.cs_ptr);
> -       if (adev->gfx.rlc.cp_table_size) {
> -               amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
> -                               &adev->gfx.rlc.cp_table_gpu_addr,
> -                               (void **)&adev->gfx.rlc.cp_table_ptr);
> -       }
>         gfx_v7_0_free_microcode(adev);
>
>         return 0;
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v8_0.c
> index 7f91186ef1d1..27fbb5b59645 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -2060,15 +2060,6 @@ static int gfx_v8_0_sw_fini(struct amdgpu_ip_block=
 *ip_block)
>
>         gfx_v8_0_mec_fini(adev);
>         amdgpu_gfx_rlc_fini(adev);
> -       amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
> -                               &adev->gfx.rlc.clear_state_gpu_addr,
> -                               (void **)&adev->gfx.rlc.cs_ptr);
> -       if ((adev->asic_type =3D=3D CHIP_CARRIZO) ||
> -           (adev->asic_type =3D=3D CHIP_STONEY)) {
> -               amdgpu_bo_free_kernel(&adev->gfx.rlc.cp_table_obj,
> -                               &adev->gfx.rlc.cp_table_gpu_addr,
> -                               (void **)&adev->gfx.rlc.cp_table_ptr);
> -       }
>         gfx_v8_0_free_microcode(adev);
>
>         return 0;
> --
> 2.47.3
>
