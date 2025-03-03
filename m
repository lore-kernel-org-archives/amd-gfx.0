Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C616C282CD
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Mar 2025 17:06:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AD5410E4AB;
	Mon,  3 Mar 2025 17:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GQbNWJMA";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70FCC10E4AB
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Mar 2025 17:06:46 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-2fe9fd5e7f8so1377489a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Mar 2025 09:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741021606; x=1741626406; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCHOnLZb8OY8RrN7F5E8jHBQMu5YQpAPwX8Cs7G4gyE=;
 b=GQbNWJMAMfHs6wA7oTPt2srHOzU8UjTiAx6vJGBdArIO3Jmop6P1d7CZQULhDWhIW1
 b1nvDEZ+tv5SUhWcEpbQDxiwQX3lGRTJf0OC2St98d6EYLLUpJ8Izznfyz6YJ84IFOzC
 JEv1SfI9BuFn3b0GKjUX0p9j4QgX0jHQ6TDklqF5votttt1wZBsGtXjBv9BTbhyLWZ4G
 F1sDbd8fHmXH4ujj8F7usvvqcgJ66vqHF7jIFzwhMbqTxfCYpkS1SaMlZZz10uVWyLrx
 S1Tc0p5au15pl0uzcZqPdwm46UykFkTx/Ku5Ope1AyWrIGnKrYLHwi2Ks7lourO6Wz/i
 Xh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741021606; x=1741626406;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FCHOnLZb8OY8RrN7F5E8jHBQMu5YQpAPwX8Cs7G4gyE=;
 b=iQUO0mZos1xELkMAXHQ1NWiLjYctSZx+rYz4YOV3wM5HEYX+JjFMPatc6f0T3JtUsQ
 6P3brkCjv4l6/AHHvbPIqfNECaQey7nGznM+/tlHMde9ifbsryH/wG7iE4MeL1Vtapuq
 f0n9HAxmjJAZm9t45xuH8ZVhCm7N2kWkcUtpG71e7iCXgQFGxfYzWXEkeEHXnn3Ar+Vr
 XI5rgm5dITKq7ieOCdjNHdKOfH0Wa0A7v1EIPh81ybm4DUWMfA5/IvVsTDEVGMUz+85K
 yQnasjtJBaNkjGZhWVRTnMF5DzGNhLtqUWES8SrgY+TsOw5WeI7r4KGcxtQ/Lkqj/f/x
 ZGYA==
X-Gm-Message-State: AOJu0YwGKCCyJFL415Q7ukivUOStNE5fC7u8HZLf3CA33uSKAod+x1V8
 yMTUQtF+tivU9s2EXD4waTSky/p6Ineiol6QmWbPPF6iI4iVTMCIhGwxBlas0YxYCZj05q1j4mY
 /i4kJYd+ehP4l1KOskk2w+beuC4o=
X-Gm-Gg: ASbGncu/xg+2lS6Dr/SL/FfywhIq+/SihuH2wUrJx+Ak1+PBRwMlmg4FG3Acaosapwd
 VCOF62nGkvaPUPhgWz9mhWx7pcH1dVOeVUGTqQ0lqppmpBs3F5AMdEB0aLcLe9L0be+ZuyGyE3z
 09ArTe6M0aQqgOIG93zb0CAtogMQ==
X-Google-Smtp-Source: AGHT+IHB/+WEJ40G0gHs/IpsN2zHzkyjqIvZnZVhhkOA4earlV6ZNa/k3j2C1d0/0on0gTlkbsJoVwdYkeSj4Y/CVMI=
X-Received: by 2002:a17:90b:4b87:b0:2fe:b54a:78 with SMTP id
 98e67ed59e1d1-2febabdc238mr8450581a91.4.1741021606027; Mon, 03 Mar 2025
 09:06:46 -0800 (PST)
MIME-Version: 1.0
References: <20250301041121.9661-1-alexandre.f.demers@gmail.com>
 <20250301041121.9661-3-alexandre.f.demers@gmail.com>
In-Reply-To: <20250301041121.9661-3-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 3 Mar 2025 12:06:34 -0500
X-Gm-Features: AQ5f1JoxiKEQHfla4Km9seoU0ZJEnfzDkOwfQr9_EeVALQ5elFBfYNjPdeK7sFg
Message-ID: <CADnq5_Phh-9nqyHDXVutmVoXfbZB2EcissDu1Wd0=r1ycJ9bfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/amdgpu: complete
 dce_v6_0_set_crtc_vline_interrupt_state() in DCE6
To: Alexandre Demers <alexandre.f.demers@gmail.com>
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

On Fri, Feb 28, 2025 at 11:11=E2=80=AFPM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> dce_v6_0_set_crtc_vline_interrupt_state() was empty without any info to
> inform the user.

I don't see much point in adding this.  As I mentioned previously,
this interrupt source is never used.  Would be better to just remove
it.

Alex

>
> Based on DCE8 and DCE10 code.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 44 +++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/=
amdgpu/dce_v6_0.c
> index 2ccb450b35a6..f8a743aade52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> @@ -2968,7 +2968,51 @@ static void dce_v6_0_set_crtc_vline_interrupt_stat=
e(struct amdgpu_device *adev,
>                                                     int crtc,
>                                                     enum amdgpu_interrupt=
_state state)
>  {
> +       u32 reg_block, lb_interrupt_mask;
>
> +       if (crtc >=3D adev->mode_info.num_crtc) {
> +               DRM_DEBUG("invalid crtc %d\n", crtc);
> +               return;
> +       }
> +
> +       switch (crtc) {
> +       case 0:
> +               reg_block =3D CRTC0_REGISTER_OFFSET;
> +               break;
> +       case 1:
> +               reg_block =3D CRTC1_REGISTER_OFFSET;
> +               break;
> +       case 2:
> +               reg_block =3D CRTC2_REGISTER_OFFSET;
> +               break;
> +       case 3:
> +               reg_block =3D CRTC3_REGISTER_OFFSET;
> +               break;
> +       case 4:
> +               reg_block =3D CRTC4_REGISTER_OFFSET;
> +               break;
> +       case 5:
> +               reg_block =3D CRTC5_REGISTER_OFFSET;
> +               break;
> +       default:
> +               DRM_DEBUG("invalid crtc %d\n", crtc);
> +               return;
> +       }
> +
> +       switch (state) {
> +       case AMDGPU_IRQ_STATE_DISABLE:
> +               lb_interrupt_mask =3D RREG32(mmINT_MASK + reg_block);
> +               lb_interrupt_mask &=3D ~VLINE_INT_MASK;
> +               WREG32(mmINT_MASK + reg_block, lb_interrupt_mask);
> +               break;
> +       case AMDGPU_IRQ_STATE_ENABLE:
> +               lb_interrupt_mask =3D RREG32(mmINT_MASK + reg_block);
> +               lb_interrupt_mask |=3D VLINE_INT_MASK;
> +               WREG32(mmINT_MASK + reg_block, lb_interrupt_mask);
> +               break;
> +       default:
> +               break;
> +       }
>  }
>
>  static int dce_v6_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
> --
> 2.48.1
>
