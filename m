Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AF15E8536F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 14:03:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BD6F10F343;
	Fri,  3 Apr 2026 14:03:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="an/JASwh";
	dkim-atps=neutral
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com
 [74.125.82.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 020A210F343
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 14:03:50 +0000 (UTC)
Received: by mail-dy1-f170.google.com with SMTP id
 5a478bee46e88-2cc43ca447aso31400eec.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 07:03:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775225030; cv=none;
 d=google.com; s=arc-20240605;
 b=PY5Ma8yFbI3XIuxhkokZId5hxCndUAynZLg9gXHXuGnqFrmParnezt/5kMIj5utS3X
 0C456AznFzTd8qvbPpv0C/2yTZtaMlz2iXPsE7MrDOOTu6t9HM3GE3Q/Q+Ht+OHTfZPB
 WtEXMutOjL/bVRoRNAkWstyVgTwMrjlX3Iu++zC9H/FRkd+Qkb8AlcLD157CPp+GSgW6
 gNO3XENRABwjflCSm0bcYLBI12AnleykVmw5TuakznQDg4ZP/fHtY7kNtfs4UK2L/SHQ
 16j7bZ9fo0g3yT77nsO1+RJPcfaoV/Kl0MjBrAmSXj4sMXMTa+NuvlCGTlygUcm+37l9
 5QwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=2RbGCOMK3zsscx3aEh2E5n3wLAtL4Rv2v3+JpQCKp58=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=a+jjkYDspUF8SEj2d1UV/a4iUy7eNJgJJHdxRKaKjXI62h6RyVrpg2RUgm4JudSoX+
 mqYmJwLL2HPc/M2fd3STx54S+6lSOmDwUPqkEArzz91hH1qSKD+m0B+ssnsqQ3jRZaVT
 NGtyYa9ycOWb95gsTSCza9Puim8ZkzwEuDSKPzvvceMy+7f47ttFYbzZRxvN/5ieUkQt
 whXrn3whfeYTdO5DoEk/Nptce52rIKJcsAXxDJL7nX4CVkKFgWkzmKY8T8vksVmcvTIp
 Z1wOE/09af2J3gv/ldTuNLON4W+YPiSmJqgzhO5U7/IvFBMu3S+zkNPdcqpOnSY7vUpO
 VKxw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775225030; x=1775829830; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2RbGCOMK3zsscx3aEh2E5n3wLAtL4Rv2v3+JpQCKp58=;
 b=an/JASwh0yLRAeHFgvK7ZSlSL2jNeBd93cEuTslYGqk1AFoo0bU8IxJn59B8Zs4ytU
 7vzzgl7Qn9R2rE66dzGGsOnFtzzaB60lMyLQcqQ1DLnb0vyhnAz2dbfjfk2ctu69xLZi
 I5Pw4PX/4/gr8ItwjKuDwjQwsfmkgCtQ/KPmv86OC+LZNGgBzJEhdiYPf3s0X44KHZe5
 b2CFYOOEKgjLczyG0uwh/Z3Q7DUs1dd4mWxWnS8znAdVso1rsWEul/ymUHHraQyI3q46
 0/Jm26fBRXresLsWY1glHuAL2eC+RilVt+fE+MeNZbNRFaPVfYbYTTfiX7siFXhB4Nui
 r3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775225030; x=1775829830;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2RbGCOMK3zsscx3aEh2E5n3wLAtL4Rv2v3+JpQCKp58=;
 b=SAnXvGcgEJWP22V55e2C0Maug7zdnMlGnZjgaXJj7A/j3hRKEBKsM58wYLL4R3O4iI
 J4YBxNTia1uM2PNmtlD2XygxLIXEnVweyr5E4WBdWo7MIlflwkd5lyskKZzohdeONypn
 YYBS0P6NoxC0Y6CsTuhJByUUFmNbfiv/1EZgbxLpZWh+oNaXTLxv7zhN5R/NvTAn/3vB
 cI3dc7wNUtfnH1P3isrCr5i2B3qSA0Lf1lI6dSIgqYqqXcF/899C32IKKRktfjSktJM4
 F3GvVhEl7W/inaSPoVZAOL0s7yTk+ctuYM80RQ2DoQqd1aJhb4cI8cxuMuAK65p/Xi7m
 65lw==
X-Gm-Message-State: AOJu0YyEORI7W28kp1tE5YDobnKV2iHKblGexsQ91BGsw7oGp5sTmvSE
 H4/3atwdhjjV2c9NwFPsCR2tqAFeunR5yZmGAOpS1WdckOwATgeJ2QV3MW97QBRxSc96Kxr8Udd
 wz1IMjwQINy+1oqGfgLrV0hIr8//HJu0Dyg==
X-Gm-Gg: ATEYQzxFq6hRHLAyBmItrsYZlL9BK91Ar2XHIcJaOLR8bFM2dV5du/yLLuCBSn3rT/Z
 KzFYgXzt0BIRFeeyeVngrzt39LcVaX+Spfji/HOQe3hk87C9d9h9whQ/vfJv03L9WcgdVaw/blx
 +k3YFQi8FeQ+lpj1saI3rYgd3bGiQ/LaKMgytKcg4Q95BJkJlZa7Q8t9wbFMuoPwTq6s334leTK
 EdaXq28F14Qqzc61ZdDJ9B87Xv/Dl53txD5fK0We2j/E0oO9rqz4vOAt0xBY2eVh64VvONYuWBX
 aYPWlVJq3SXG4NlCljLWyPL27EQk6g1vOAHT8yAUglf9qFWlWVHfY5ii1+TW3SdH/TZQPA==
X-Received: by 2002:a05:7022:b81:b0:127:332d:63e with SMTP id
 a92af1059eb24-12bfb76050dmr570798c88.5.1775225030035; Fri, 03 Apr 2026
 07:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <20260318140837.582776-1-alexander.deucher@amd.com>
 <20260318140837.582776-8-alexander.deucher@amd.com>
In-Reply-To: <20260318140837.582776-8-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 10:03:37 -0400
X-Gm-Features: AQROBzA3-A31Oqk1Ma5BgiXkrVU7Za3JZ29TfPx-TigDxDuAdKQIl2AohOqYGpQ
Message-ID: <CADnq5_N-b61C4=n_L87J6Pyf_Tv7UCGse317qYzECPtK_OgnZw@mail.gmail.com>
Subject: Re: [PATCH 08/16] drm/amdgpu/gfx12.1: align mqd settings with KFD
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Wed, Mar 18, 2026 at 10:19=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Make sure to set the quantum bits in the compute MQD
> for better fairness across queues of the same priority.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_1.c
> index db49582a211f7..98dc6582b7aa6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -2246,6 +2246,11 @@ static int gfx_v12_1_compute_mqd_init(struct amdgp=
u_device *adev, void *m,
>         mqd->cp_mqd_stride_size =3D prop->mqd_stride_size ? prop->mqd_str=
ide_size :
>                 AMDGPU_MQD_SIZE_ALIGN(adev->mqds[AMDGPU_HW_IP_COMPUTE].mq=
d_size);
>
> +       tmp =3D REG_SET_FIELD(0, CP_HQD_QUANTUM, QUANTUM_EN, 1);
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 1);
> +       mqd->cp_hqd_quantum =3D tmp;
> +
>         mqd->cp_hqd_active =3D prop->hqd_active;
>
>         return 0;
> --
> 2.53.0
>
