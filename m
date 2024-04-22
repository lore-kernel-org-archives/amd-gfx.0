Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38427C4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 20:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B43F310F7DF;
	Mon, 22 Apr 2024 20:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZLX8dGpr";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D723F10F59E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 20:14:36 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-602801ea164so467759a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 13:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713816876; x=1714421676; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nPAXQszxN57HbDLnVFqAdFedPC2yb9g/bnt0sZXrE7w=;
 b=ZLX8dGpriDrTMO9g2TScw6yOrzLJJ/VY6bPr81JiXQBydkZjexb0dUXAYetdWl3ajr
 Z3fvZyl0i7HThneTOozod4dRYUQk2VvWDWKHL5JiYHJZCcm+N0MMUth2MCfXHiT05dS5
 bvYoR6PILB6+5ytB9UN0Y7FxY1MIm0ER8hKUx3rlKv+CFohJDfbdVhzIshgakbUoczVA
 rc7MQkA/phydVVdYGmEG8i7YULuoTfT3sWpBX+3LKDqFMRW7FgdICq4LrN81VJTPItBZ
 GSJ1zD/TdJMpQhckFNPsMqHr/B0fdiNcPXcvAJHN3M/mt6bAz9i1GjXtBLfyDYMwodBv
 CJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713816876; x=1714421676;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nPAXQszxN57HbDLnVFqAdFedPC2yb9g/bnt0sZXrE7w=;
 b=p3c6oBcI1pUBO2g2pF0Kya+VomgdlCSIrFH1DAvNuVug0Zi3HA6Y899+AjJFyOMxPQ
 iC4O4q6eUM6DumbkB+ykiZta0jhpJRWtFcInOiLxtABk3O2PT6vHx53eslKbmagr2Ria
 P6YAs3L7NDwod8C5z1uaxDpGmFmfKy/xgH10UhIgLK+oLTYp8xP6oxaxVlAPkK+Tstyc
 vgdapRFWowhptz/EVFctt72vZSt2QpfTT4LA4LtZGGCZZz+Gt+8/c2xaVhiDWor2BbuC
 b8cw3Cpz+PjZFD9mF+qKSqtjMUXFtmPpWRIGL3aCf1D+TF88tgEne3tciTY+7SyG+Nhu
 7CyA==
X-Gm-Message-State: AOJu0Yy+Gtnp4cAvyax0VbJvVsKKdym/dpwm6hXTJ1HvPyD2B0E7ziK/
 oG11kK5zntaNjcIm6Rznef5rKQuN7/RuObgTqc1pMGcOB/fLx9YjdYFfbZuuxxX6hkC+p79Hdt0
 CV00fIdZzomggfJyy/zMHqjRK+jV0pg==
X-Google-Smtp-Source: AGHT+IGe0mOAGucllmsOk8cO8I54u8MlMoRpgRnJ/UNX/XphBPUrTKNYUifmqpRXY9aS0xYwznEoSpFbJi8EG4bw6CU=
X-Received: by 2002:a17:90a:540e:b0:2aa:70a8:e5a with SMTP id
 z14-20020a17090a540e00b002aa70a80e5amr10792886pjh.9.1713816876208; Mon, 22
 Apr 2024 13:14:36 -0700 (PDT)
MIME-Version: 1.0
References: <20240422194550.26148-1-Yunxiang.Li@amd.com>
In-Reply-To: <20240422194550.26148-1-Yunxiang.Li@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Apr 2024 16:14:23 -0400
Message-ID: <CADnq5_N=KG_8bZ4k-f-LOOazH2CtkQ0O4sQ9Ge3CpzxcGjMZLA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix two reset triggered in a row
To: Yunxiang Li <Yunxiang.Li@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 christian.koenig@amd.com
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

On Mon, Apr 22, 2024 at 3:52=E2=80=AFPM Yunxiang Li <Yunxiang.Li@amd.com> w=
rote:
>
> Reset request from KFD is missing a check for if a reset is already in
> progress, this causes a second reset to be triggered right after the
> previous one finishes. Add the check to align with the other reset source=
s.

Acked-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Yunxiang Li <Yunxiang.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_amdkfd.c
> index 3b4591f554f1..ce3dbb1cc2da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -283,7 +283,7 @@ int amdgpu_amdkfd_post_reset(struct amdgpu_device *ad=
ev)
>
>  void amdgpu_amdkfd_gpu_reset(struct amdgpu_device *adev)
>  {
> -       if (amdgpu_device_should_recover_gpu(adev))
> +       if (amdgpu_device_should_recover_gpu(adev) && !amdgpu_in_reset(ad=
ev))
>                 amdgpu_reset_domain_schedule(adev->reset_domain,
>                                              &adev->kfd.reset_work);
>  }
> --
> 2.34.1
>
