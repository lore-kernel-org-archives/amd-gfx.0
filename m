Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A93C4332F
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Nov 2023 18:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FFDF10E148;
	Sun, 12 Nov 2023 18:10:32 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DD5F10E148
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Nov 2023 18:10:30 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-1e9bb3a0bfeso2444745fac.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Nov 2023 10:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699812629; x=1700417429; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PZ4msdo8hjkAOngMra0anrRMo3QEhsiuohbiItzDD1s=;
 b=J1DUMO5GBznuZ43mx2obWJGFVqs2YeAs0COzh4cWk0kbJAWezXPt9hnleVukbyCC/o
 r1vrdBMkX1tZ/Dle0lJQnB5GAzjoC69cBcNWunoAFDMbxy70DypwIK+TSzIcuV31ilBM
 hpZ48Lut9wGZTw3ucRht93EW2gH2uFwBjh8MsPAvwOhopr7HIo8Jxeoo/c48kXwrpIgw
 FqGgzBjPujExY0qJBGt5NxuG2Y1oqbMq+z23e/l0BMxvwL2xFsyaIIoo5IVBacwLRrNd
 YJvUGTX8h3EuGUQMIkjha5Ruu3HM6/8f2TV1DHDzLcXwe7pyxCivO4i91wTkXKXktz1R
 C2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699812629; x=1700417429;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PZ4msdo8hjkAOngMra0anrRMo3QEhsiuohbiItzDD1s=;
 b=b/ljohso16nny0nApprst1oCFkQ0l0wIvmGGoI05ZUS7Ilv5TaJU+lCUt1XyagIc+g
 TC++SqqyAA12Ejpi6LBJVpDIw29E8ktpdO72Wb90sFCsltJugpHS6PvYrxF+e8xuN5aB
 RulTHj5PFbtEQ8JAYNtHZJQMd5UJ1pEiQtH8b834BWkel0RWrhx+A6UaUArnWIx96Tga
 Bv0ipnQjOGusyhZZ35lT+Qalzef/rj5aV8gyaj7sRagPx4yG+2HgsOvatTu0VQu8qldY
 tv/hckG8rftkA/oTu/HQyjCh9MGVWD1qVBOKIn8umbiVqPBEBVZMjLA1VMNHLEWE6BIw
 tgOQ==
X-Gm-Message-State: AOJu0Yy2hiVCpEBKvIL6fhEiPd5YBCXeiHVFztrJC9o4fFCFoY6de+Uf
 34JwZBgtj+kXuwtY4fT7y5x18NQSFcU4fpuoKGw=
X-Google-Smtp-Source: AGHT+IHLaieSHt7tqcfWc9yCPTP70JXOgsAJ/BGTb333hMZ4TcmGpwwO3v5/zKQaE52OSokdtMtEAeZ0x1Bs3jr3ev0=
X-Received: by 2002:a05:6870:c1d1:b0:1e9:b3f6:12de with SMTP id
 i17-20020a056870c1d100b001e9b3f612demr6742650oad.31.1699812629364; Sun, 12
 Nov 2023 10:10:29 -0800 (PST)
MIME-Version: 1.0
References: <20231112042559.1631414-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20231112042559.1631414-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 12 Nov 2023 13:10:18 -0500
Message-ID: <CADnq5_OfKMXb8d8bkWbt0-TrDC5p30bgF9SxYLG93roJhtVVsw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Address member 'ring' not described in
 'amdgpu_ vce, uvd_entity_init()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Sat, Nov 11, 2023 at 11:32=E2=80=AFPM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c:237: warning: Function parameter =
or member 'ring' not described in 'amdgpu_vce_entity_init'
> drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c:405: warning: Function parameter =
or member 'ring' not described in 'amdgpu_uvd_entity_init'
>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: "Pan, Xinhui" <Xinhui.Pan@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_uvd.c
> index 65949cc7abb9..354317c9e47a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
> @@ -398,6 +398,7 @@ int amdgpu_uvd_sw_fini(struct amdgpu_device *adev)
>   * amdgpu_uvd_entity_init - init entity
>   *
>   * @adev: amdgpu_device pointer
> + * @ring: UVD scheduling entity on ring

amdgpu_ring pointer to check

>   *
>   * Initialize the entity used for handle management in the kernel driver=
.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_vce.c
> index 0954447f689d..578c5c90448f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
> @@ -230,6 +230,7 @@ int amdgpu_vce_sw_fini(struct amdgpu_device *adev)
>   * amdgpu_vce_entity_init - init entity
>   *
>   * @adev: amdgpu_device pointer
> + * @ring: VCE scheduling entity on ring

Same here.

>   *
>   * Initialize the entity used for handle management in the kernel driver=
.
>   */
> --
> 2.34.1
>
