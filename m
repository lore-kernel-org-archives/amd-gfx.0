Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF86EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 21:31:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BECAC10E4F5;
	Fri, 30 Jun 2023 21:31:02 +0000 (UTC)
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com
 [IPv6:2607:f8b0:4864:20::c36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3515110E4F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 21:30:59 +0000 (UTC)
Received: by mail-oo1-xc36.google.com with SMTP id
 006d021491bc7-5634db21a78so1639689eaf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 14:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688160658; x=1690752658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFp1Jo9Cm2aYbyxAt1CmOZ7y+HuTtn1FyIvvpvvHhec=;
 b=pUhMIn64plBdWUTKxBTBJH2N2cd8be1QfLaRn8aMOXc6X4fbPoSWGJqATgEwZ/17Y1
 uaAsiiQbIqJi5cAEHyLJFfce1HXnk3sZMJIeFsvihJ3G8FlX+8QnfsErkZUaXbTJLvZ5
 J1vKmIvIi900qhfx74njO8E/WXW9QuXNOG7qt7tUpFwFoO/2nnFssSkYPF472S0brquH
 m6Z9/y6d0f/X/K14qWdRKM/R9xUMVIVxp3YLQy7l21oRZM2oP1uIviypIpyoRrY8FVPM
 RQhSv6qgfyiSRhAocE7m0qFPM8Yo8Dm7Vwph99uYIkKLhdzRw4qmw/27N5wVg0ZNvRTA
 48Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688160658; x=1690752658;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OFp1Jo9Cm2aYbyxAt1CmOZ7y+HuTtn1FyIvvpvvHhec=;
 b=jT0RlhWDItnoVCV4xVRfTtZmW7qED04svVYHrIC2+ftiwjlG4bzhA4g9C5Xmd9Aw3T
 ZyF81L4pFgaZJd6h8qjMoMu4gJbYUFJlWNtWDGaHqf56IPpGrI1cG2S6C2YGOhc0f1E7
 4xZLjzRsqT1bKi0RI261MUx69ImgdK55vCdA69LpwgtzIVY0h6oVdK8RirvbxEjweLBt
 pKU9TsTVrjM4cOl3InAHlX5Uu1N9oTY/EiksMiC3un2joFnBs/HB6ntUxqbdKXCnW9qV
 vmCTThCQH2mmCi8K0yG6IqSCozm/B/r65AX1n1lOoGuQkFE+VBTUJA96Uueyqt2YSRtw
 h4FA==
X-Gm-Message-State: AC+VfDyXeBwjCahI+atTfgd6Q3BbHM7Lpowanc2H7IhuFbG3zD50IKGr
 5q62Rh6ge2s1bCOJD7fpxmJ3Hm2bzoxnqP3y3F4zpzVU
X-Google-Smtp-Source: ACHHUZ52w95cVTrPWL8ufuUcHkXkb3VevXRmJk/bp/s+bpFTXL2mEI3XPwQrM6oD3xjH03XW62TuJz4MsL7zpPuhjkc=
X-Received: by 2002:a4a:4f0f:0:b0:562:f5ce:6632 with SMTP id
 c15-20020a4a4f0f000000b00562f5ce6632mr3401411oob.5.1688160657903; Fri, 30 Jun
 2023 14:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230630212708.19954-1-mario.limonciello@amd.com>
In-Reply-To: <20230630212708.19954-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jun 2023 17:30:46 -0400
Message-ID: <CADnq5_P0uizeU4C7p935KAbr46Zi6HE+K_MwYgyuUPzVzc4=uA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Restore flashing support for PSP 13.0.10
To: Mario Limonciello <mario.limonciello@amd.com>
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
Cc: Likun.Gao@amd.com, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jun 30, 2023 at 5:27=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> This was accidentally lost by commit e6e3bee0bc9a3 ("drm/amd: Use
> attribute groups for PSP flashing attributes")
>
> Fixes: e6e3bee0bc9a ("drm/amd: Use attribute groups for PSP flashing attr=
ibutes")
> Reported-by: Likun.Gao@amd.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_psp.c
> index 270b5b5a3a6d1..c2508462e02f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
> @@ -201,7 +201,6 @@ static int psp_early_init(void *handle)
>         case IP_VERSION(13, 0, 3):
>         case IP_VERSION(13, 0, 5):
>         case IP_VERSION(13, 0, 8):
> -       case IP_VERSION(13, 0, 10):
>         case IP_VERSION(13, 0, 11):
>                 psp_v13_0_set_psp_funcs(psp);
>                 psp->autoload_supported =3D true;
> @@ -214,6 +213,7 @@ static int psp_early_init(void *handle)
>                 break;
>         case IP_VERSION(13, 0, 0):
>         case IP_VERSION(13, 0, 7):
> +       case IP_VERSION(13, 0, 10):
>                 psp_v13_0_set_psp_funcs(psp);
>                 psp->autoload_supported =3D true;
>                 adev->psp.sup_ifwi_up =3D !amdgpu_sriov_vf(adev);
> --
> 2.25.1
>
