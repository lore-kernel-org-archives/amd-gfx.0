Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D61EB7EA0
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Mar 2026 08:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D4110E968;
	Wed,  4 Mar 2026 08:18:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fKyTg+/+";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A78C610E948
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Mar 2026 04:03:54 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-b9359c0ec47so690759366b.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 03 Mar 2026 20:03:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772597033; cv=none;
 d=google.com; s=arc-20240605;
 b=KX72Ognkxt08O93XF7uSyRRqTNrWh2sOtdBxd3HCekNZE6qE0Vw3Jkr3v1wwx8lrli
 nxdHCEzqE+Bydm+SkSpKZCUSqerIVRFmXd9btmxRBwTItDCJ6NxJo6EKuHhmqXtLiFWJ
 ZA+YGwXmHWouQJgZBH0qW16QS+ncGFevG63EXnQ5EakSVHZyW9AfKpdTjwf9EI7oapML
 WAZBHpvxQCmtd3FTfB+Be/rT/4fojkQDfSwa9GUJbpfqjM7n8tbFrBAw89GCh4784K7e
 qJUftF2zfKtp4mFdO/F4eCO0nqEZYx7NZizSByWH0a9Clwhml+X0qUXkYaqxHXt2rzOs
 Avbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6z8M845Y+NpITZKZSzsYEQuXgpy16cvxcX5WIhmq9VA=;
 fh=MGGZhoiy10YD8cFeFY0hS2OGtydbgCDhX1hf8HfFnyY=;
 b=JvFEjaYvtI/DCxN0M5Xv7xsTQdSIswa0jBuai8UiEOj7XmvNl7SSl9q/MKLUxEgB0B
 KkKTe9iKQ2u+WgN+go3ZYiJPKELwKgygLRmdx8Q/0tekdJ6NsVSgQJcSvDSA7VlWx/c7
 UvbHTsZnaah2xH4IKHCLn4QEJRYl6XA7RYOruKm2xi0eKzA3EeBBFr1Ti66jIGMU21eH
 P7vKVh/MOQzeqffagmz7Oy1qP6Z4uYZ58v4yEQoTdZ9dqfhNFJyO+kUb/Mk/JBhl/yoD
 a6471z0hNHaEBDD14I0HDdVN1XolnkQ/iWxTUxUWcPZZrUAqy7uNfiMj66XDkvUhNpX/
 VkKg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772597033; x=1773201833; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6z8M845Y+NpITZKZSzsYEQuXgpy16cvxcX5WIhmq9VA=;
 b=fKyTg+/+K2/0f0AQO7RA9P4GU55qSGunllF++jJxsbGY6tf60VYPtrOjRL0XM01xr4
 pmOX6iVPspVqmIEHKptp7Wj9to87ha30SuiDqSrizf6ZsgTY4Av3pxdGFvDoHoWsZLE0
 6sy3dLv0BI47b/ZUtwJSPf+FBXHyfYLOPEQGAIS/TIghCD0yIEoOr8SWaH/ahUFxpFqa
 vNh0J6u45mjJMrsaHFOkIZkqDnCKThjGCKbjEEV/pjbl8+CmWOGb6AsB7a+ZjlMVYHdT
 Hv4ggacpV2mnaBJSPaVMgSyABcmvLLa3fR0vAJftpWT04mxjjOBoA2dNpEFtOWzgSz9p
 7sGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772597033; x=1773201833;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6z8M845Y+NpITZKZSzsYEQuXgpy16cvxcX5WIhmq9VA=;
 b=f0MNO+oI/lZmGkr65P+ECKsxcPHPyHEpKFVU3Hw5MiTPkA7FTN7ZGg8jL6chKzzHfz
 ml33dHTIxAU4tyIEwTxc2hW6VkqFJdb5xGkwBLHU5FCQ1grUtFE5JACSYp2ODsY1q0Ss
 mGb6NTduj8DqOMY7Rb07pAWf5Htt8SPo0kEVQ+7QLxexPChY88xdCTywVyc0t5mV9mqF
 AM/fqd48xVX0T+bz11NDWGPYug6bSbud1Y+eKF0rlMiKYm2YAABv3EF3d5zdZSkI4ILd
 VJdPZ7eGBMHuCmF+BqaXBl3l1ReZ0vtaMXyINOP1Q5Em5E2swrJUfJxmbWqOIsS0xRbX
 6pUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOKlAzkzZvlnnSnlx13ucyzveVgy3UN1A/DPB2ovpPElW5kBS5orJ/W8PCF8DCQdeMf5C5DMJB@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzR3IyA0JwtCQ8WYAwiYEZ/SVueJvh+jQIIMHPY+sF65lujcCg0
 Tc40JcLmiglGcl2cPFhWE0mv2MFI2GsFkix5fSQcRU7n/OMTePujYJkEh2aioz9wPLdOcOBx24E
 o29uwwGpo3trz9KMWNq8VILrYuDoLNsU=
X-Gm-Gg: ATEYQzw9UaYClPFz/ZjLOdvoAt9MkH6K8+1t4eMC5R4LoLGl+78dw8OH+OGx9JsN3wV
 LGPZxak56Z7y3oZ+gdt2PTAErb5XryFLYQGOdp/Pg9ZHBiCaJBOe+ZC/bCIsVK2lqk1izSHyjun
 MWVJ+bcwifaAOda4xMnZ/Cm+0ukBjyvt9LtTdJBTRWGyUaDvAG74FSwQap3xkHUjTQpwT8zeyNM
 CzxYW2sZqdbHV2UopfBEregC5gjIAvixhVuSgjrIsDxW59/LBqwSwn39LkNIO3K+lMP14dHKJLa
 x0cQolH7i58r1V5OUAssIPbepyoxDNu6rd8hzv+KyZSOk7RPDiFotiqMDAieoy4mQ5nyaDjwTmC
 pzXTCHA==
X-Received: by 2002:a17:907:96a6:b0:b93:8460:4af with SMTP id
 a640c23a62f3a-b93f14cf1afmr27445366b.56.1772597032896; Tue, 03 Mar 2026
 20:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20260228045356.3561-1-rosenp@gmail.com>
In-Reply-To: <20260228045356.3561-1-rosenp@gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 3 Mar 2026 20:03:40 -0800
X-Gm-Features: AaiRm50svINP7hvFX0utAndkOyARkkDlnOGgjjSGoekSn-A5-l-P6oFmN6TdzZE
Message-ID: <CAKxU2N_FbB_d6ntXEOFzE2u-sfu9sRRFwaDnb3P=RfTwE5yuDA@mail.gmail.com>
Subject: Re: [PATCHv2 for 6.112 and 6.6 0/2] amdgpu: fix panic on old GPUs
To: stable@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kenneth Feng <kenneth.feng@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Alex Hung <alex.hung@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Lijo Lazar <lijo.lazar@amd.com>, "chr[]" <chris@rudorff.com>,
 Sasha Levin <sashal@kernel.org>, Wentao Liang <vulab@iscas.ac.cn>, 
 "open list:AMD DISPLAY CORE" <amd-gfx@lists.freedesktop.org>, 
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Wed, 04 Mar 2026 08:18:12 +0000
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

On Fri, Feb 27, 2026 at 8:54=E2=80=AFPM Rosen Penev <rosenp@gmail.com> wrot=
e:
>
> Because of incomplete backports to stable kernels, DC ended up breaking
> on older GCN 1 GPUs. This patchset adds the missing upstream commits to
> at least fix the panic/black screen on boot.
>
> They are applicable to 6.12, 6.6, and 6.1 as those are the currently
> supported kernels that 7009e3af0474aca5f64262b3c72fb6e23b232f9b got
> backported to.
>
> 6.1 needs two extra backports for these two commits to be cherry-picked
> cleanly. Those are
>
> 96ce96f8773da4814622fd97e5226915a2c30706
> d09ef243035b75a6d403ebfeb7e87fa20d7e25c6
>
> v2: Add Signed-off-by.
Do I need to resend?
>
> Timur Krist=C3=B3f (2):
>   drm/amd/display: Add pixel_clock to amd_pp_display_configuration
>   drm/amd/pm: Use pm_display_cfg in legacy DPM (v2)
>
>  .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |  1 +
>  .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |  2 +-
>  .../drm/amd/display/dc/dm_services_types.h    |  2 +-
>  drivers/gpu/drm/amd/include/dm_pp_interface.h |  1 +
>  drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
>  .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
>  drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
>  .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
>  drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 65 ++++++------------
>  .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
>  10 files changed, 101 insertions(+), 60 deletions(-)
>
> --
> 2.53.0
>
