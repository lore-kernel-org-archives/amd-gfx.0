Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE3BC282EC
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 18:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD6AF10E190;
	Tue, 11 Mar 2025 18:25:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NzFLV8xf";
	dkim-atps=neutral
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCB7A10E190
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 18:25:07 +0000 (UTC)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-2ff7cf59a8fso1287126a91.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 11:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741717506; x=1742322306; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epk4YrmC4PSVax2HYKYtUsBFtl46uXijw+yt9cRlitg=;
 b=NzFLV8xfNTCyVPNRXcZF8vU4RIcXFIm6sA2c750JluIEo30FPUP6Ft1mJwTJI6bO6g
 IS4CNsVTf18dTyf3xqzVtsW7ra5joPbNZ2qcYapimXZoaWxiXg0vOA8YRiXQJyJ3VqfR
 SZTQzjAMImkwDV+5SJOj1nCX16V2vJp4Cc95yve3Z1Cjx+LvV9MheWTb8IqNs4mZMi44
 br8v0TnQcqVDfjBg7n7tpPpZ81U3yeBZioiFokQxq/9xoYsqXNKFHXoJaodUvwT+z8JE
 qZCzvVCDK3l0g6SQ1jtTCOMRGCARPLofheDpDmhNO3qQNAL/808sgkzQvdYG3coJPMJA
 aGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741717506; x=1742322306;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epk4YrmC4PSVax2HYKYtUsBFtl46uXijw+yt9cRlitg=;
 b=XZ86Zm7iejHaX//JUC2GkgU8hdC7gV9itSd//I8CjNiLrBlbZxmSruLsjXFmydymuH
 3GBbNEH4+rbJLXyyxeMUoKVDhS57p1paz8Uo1OzRPie6By+onnal7c05z+vojYsQxeee
 kGrq2CSIpxAIItraBEJOkPbKmytaXP6gqAytppidlnZZUWp+EbDBoxldmH2LrI3oTe2f
 +DbIM2AEv0mTgH6jnmgr0zHasG4fpgIOAP2kU7TEqD4iO35wMXjELg+exxjfeZe/Tnvd
 vtbS5TK78vxzhCqHt5rNst1t6veNX5Mxa5rYyNqHmRuYmVX5R+o0gXce05hjaPjZW1gA
 gcoA==
X-Gm-Message-State: AOJu0Ywetd4uEqvLF8nFNLytQXQd4wInBLzB9opEfL0/5ZxXGK9MxYj5
 PrjxzCcPa4feSwPfONX5uxYyk8a69p+KrHdgH73PQUtn3muDdhKZVKUnobFyj0MOPkhsuhhM5/C
 LDdr0E2j6pM8JkCwDcreMeGbxFLo=
X-Gm-Gg: ASbGncvVWObEBO9AU4DRlme94GzO9dnRUPnigRKtPPx6Xca0zauZD1ErkmFAoaXSqJF
 wfApZdaOzM2qOwyhNxkCmSyW9v5gfySA2Fxyr4RCVm+VduBHUeBMFeH/ouqVvGOPzTtIpAheza0
 q5ZEuxqMFXEtFxaG2d5+1WzAXX0w==
X-Google-Smtp-Source: AGHT+IG65WPJfqtFpBcEIjrGLv5TWveQ4x3ZzzYWFojj3VmP7zdsbKLUvh/K92Zncd3GZrf86hog9IqZBBuyRLr0H4Q=
X-Received: by 2002:a17:90b:4d8d:b0:2fe:91d0:f781 with SMTP id
 98e67ed59e1d1-300ff724478mr2239080a91.2.1741717506368; Tue, 11 Mar 2025
 11:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20250311181649.114559-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20250311181649.114559-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 11 Mar 2025 14:24:54 -0400
X-Gm-Features: AQ5f1JqwYctpTqJBaNWUQ-9suxCPpNHkUPPZw5ZUXQP8FqhH7W5Ad7i0OTBQrss
Message-ID: <CADnq5_O+ZhWZcQNxsE-XdFJwxGqwxutfSk7dhrZQJemttGaZiQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/pm: add unique_id for gfx12
To: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
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

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Tue, Mar 11, 2025 at 2:17=E2=80=AFPM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> Expose unique_id for gfx12
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
> ---
>  drivers/gpu/drm/amd/pm/amdgpu_pm.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/=
amdgpu_pm.c
> index 1d04f1b79ded..2179344e78d9 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -2341,6 +2341,8 @@ static int default_attr_update(struct amdgpu_device=
 *adev, struct amdgpu_device_
>                 case IP_VERSION(11, 0, 1):
>                 case IP_VERSION(11, 0, 2):
>                 case IP_VERSION(11, 0, 3):
> +               case IP_VERSION(12, 0, 0):
> +               case IP_VERSION(12, 0, 1):
>                         *states =3D ATTR_STATE_SUPPORTED;
>                         break;
>                 default:
> --
> 2.34.1
>
