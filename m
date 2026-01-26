Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9257D13C11
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 14:21:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ECD310E224;
	Mon, 26 Jan 2026 14:21:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W3FIVHHI";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0904410E224
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 14:21:08 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2b7063004daso254521eec.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 06:21:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769437267; cv=none;
 d=google.com; s=arc-20240605;
 b=PSyXzc5fNEALtTHnOxXE3MgJzzkq46YhnVc3mrpN+wfdFMzw4yBAzcyyiuGO0edtR8
 VQhhcw3VTH7y5XIRnXgYzxzp2AdyXxWTOxDm3q7A8y9so3V1NjkPrPZlVWqW3WKzL5JU
 zjNOJeuS9as844GbJd7zZTMVq67zzOqDHrkem6CyRPX1z7HKhSlQBKTm4ryLKmDy+lCh
 xj9UBgzQhi0RIjDX6WQo47TQYZEn8iTNfM7yk+FJRdKrHuqoxnzBgnJXJm3J6eDOtkHy
 3zrzBOsD6J9fuC0lqLesvBPFixf3o+K7ULnilqO04IQgNf/uZjo9FACH+iBCnzisYiZp
 cb2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Tto4FmdVik1l4FkS8WldjHtZI0UABPRursXto4Nd10I=;
 fh=cUMrWo6zUgzQ2mQC9KGfYxwKzy5F/rZ05v1pqRROWcI=;
 b=fGjJd/3j8Asna6nwg8USExBEajFjIGTE7XDd5yfNG/8PRamNKiRrFR5B8pmopScbWl
 Sj2abvlLjtVdhiRzCgqocxAAGS8AG8HJ7bTwLSIFZX6r0sbm2R3yBkHGhjJ0cbu9TP3D
 ZH6Q18qwCJn4wtRHSJOjYN8WiM/eAK4sune2kvEb9SlXWCxp+0WowAttpTu92Qht0ULt
 wAWPM+4v1Hfqyj4dgnlGxZIvLuQl9YSm53QPHcs/ZmMvXyGEfRqJvAuZJbyOKiXQtKzN
 LkZSRdKXa6XVIM7Jpi08QrEZ3nGTqhRZf96fF1981GyTd1qLxt3E4BGCaHNB2mxgS/n6
 FGgg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769437267; x=1770042067; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tto4FmdVik1l4FkS8WldjHtZI0UABPRursXto4Nd10I=;
 b=W3FIVHHI6rzgwplR7Rm8R6Y1VPey3Zg3XdBsVm5beyq8Y2yO2PKPax2wthZz15Qkey
 YFKh88WVxkA0AokVaQnHmmiBRBl7s2RsXPf/jp0HjC0Rqah/DSEX8HjoDPSI68+v1hR7
 /4o4Kw3PsYiz1VC6gUnS8ijCaM763PI4i8j/mz4cSVjB0D+IPOxMWE/eh2Hi8U4khVES
 0Qi+Hu8n1GGyKoLQ7Ey0MdJWc4zawbtI5gxkCU7AoWuRkz+QYAET02vKu0jUTByJgDtm
 Yy0sEnnld69DkECZRpSoEtwH1hcdDn8h2h4qCuFdsse3yZo7IGq0M/EA+u0rP3SV2fFC
 YG9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769437267; x=1770042067;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tto4FmdVik1l4FkS8WldjHtZI0UABPRursXto4Nd10I=;
 b=PSLpIyLRdQrAcbwimsKQBtQAAva8pkr8fXCy+w97II4WQQRQjkYZpo6RwIl2/um+ZM
 q6GgtW5bkSGPRYL7lvlNDDOrExcvtaPFXQBu7NVYijXTbBJj1QeA4xPU0W0I2iqbsXB6
 glHwAaH61XhMm9NFqHEMzuydIjhRKdEHdlSVGZqfmaQscBGYTK/MJl3RrQjX/z+oK75x
 7Dn7U4kMO3eFki6EqJYwoQ5ZRqO9663vdtCDamoVolrgTWT64LEhggvNLhtUiYxMLE1x
 37m9T+M1L89C+XS3GsfX+uC/nB/1nsAmHpD7uLxn6rBhSZavknXXC7pp1B67mynK8UKF
 G12g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW/Asaaqa/B3jRvpqhHdM7H24NRhFfRiYlgmmYay5SBf5jPuCOpgNaYEM9XNb5fImBFFvKMB/sj@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxrt0NvxntXSYrjxXI/wU79HKl1Elt9HMwKoHQJgHLxr1CAKo+A
 srMuJA16gXe0jlltw8+o1fTTE8K5pGCi2xmqVNaCSxlw4ASv7XGyreAGtdL5HLIP8Jg5Mrwy0M+
 dn98+OmxMGIx5y5XAbXSdu1BUDMclBVE=
X-Gm-Gg: AZuq6aJpfgs4iyebet8PNInN04rSMO4D91ek7/1Qtw4xWlBNpLWeztBLcyiu9N8noaF
 2P2z+gzPvE6DQ5rbbg2P3CmjMjZbI3e24XeqCsBZMhofXYG7J0shXZ8FIslNvXz7ghVvPUKxkH+
 BC/0OXK+H7o6ldzOLQvozC7fWLVkcG08ty2wTbst3nRicBTX4aoU3DHA1zlIbHwnUPnxao5xrUN
 8vnc7A02zwRomh0+vbJcvUrOatr3Xrvb0jsg+ChB/Gx6/btjtvJoGake30qN7MVExRPYz9W
X-Received: by 2002:a05:7022:4394:b0:119:e56b:46b7 with SMTP id
 a92af1059eb24-1248ebc8ad8mr1289343c88.1.1769437267030; Mon, 26 Jan 2026
 06:21:07 -0800 (PST)
MIME-Version: 1.0
References: <20260123000537.2450496-1-someguy@effective-light.com>
 <2de6d428-b997-4ba8-8766-a211e5612e72@amd.com>
 <2349754.vFx2qVVIhK@timur-hyperion>
 <a8b972be-7265-492f-9855-cdec94a0e0dc@amd.com>
 <aXUQKSJGkz7nzHJ4@hal-station.localdomain>
In-Reply-To: <aXUQKSJGkz7nzHJ4@hal-station.localdomain>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 26 Jan 2026 09:20:55 -0500
X-Gm-Features: AZwV_QijZbfDm80LvfOz2KOV1eORQnBB63BRHrSGLChaoas2MT3UbMiWqTiW85s
Message-ID: <CADnq5_Ob8yiivco+szanSiXuRwdAu4xHMe=8OQSk+Ufqykgobg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm: introduce page_flip_timeout()
To: Hamza Mahfooz <someguy@effective-light.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 dri-devel@lists.freedesktop.org, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sunil Khatri <sunil.khatri@amd.com>, Ce Sun <cesun102@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>, 
 Kenneth Feng <kenneth.feng@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, 
 Alex Hung <alex.hung@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, 
 Melissa Wen <mwen@igalia.com>,
 =?UTF-8?Q?Michel_D=C3=A4nzer?= <mdaenzer@redhat.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, amd-gfx@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org
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

On Mon, Jan 26, 2026 at 3:09=E2=80=AFAM Hamza Mahfooz
<someguy@effective-light.com> wrote:
>
> On Fri, Jan 23, 2026 at 04:30:12PM -0600, Mario Limonciello wrote:
> > Hamza - since you seem to have a "workload" that can run overnight and =
this
> > series recovers, can you try what Alex said and do a dc_suspend() and
> > dc_resume() for failure?
> >
> > Make sure you log a message so you can know it worked.
>
> Sure, I'll try something along the lines of:
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 492457c86393..bc7abd00f5f4 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -579,11 +579,28 @@ amdgpu_dm_atomic_crtc_get_property(struct drm_crtc =
*crtc,
>  }
>  #endif
>
> -static void amdgpu_dm_crtc_handle_timeout(struct drm_crtc *crtc)
> +static void amdgpu_dm_crtc_handle_timeout(struct drm_crtc *crtc,
> +                                         struct drm_crtc_commit *commit)
>  {
>         struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);
>         struct amdgpu_reset_context reset_ctx;
> +       struct amdgpu_ip_block *ip_block;
>
> +       ip_block =3D amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYP=
E_DCE);
> +       if (!ip_block)
> +               goto full_reset;
> +
> +       ip_block->version->funcs->suspend(ip_block);
> +       ip_block->version->funcs->resume(ip_block);
> +

I suspect just calling drm_crtc_send_vblank_event() here on the
relevant crtcs would be enough.

Alex

> +       if (drm_crtc_commit_wait(commit)) {
> +               drm_err(crtc->dev, "suspend-resume failed!\n");
> +               goto full_reset;
> +       }
> +
> +       return;
> +
> +full_reset:
>         if (amdgpu_device_should_recover_gpu(adev)) {
>                 memset(&reset_ctx, 0, sizeof(reset_ctx));
>
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_at=
omic_helper.c
> index 7175294ccb57..b38c4ee2fc95 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -1961,7 +1961,7 @@ void drm_atomic_helper_wait_for_flip_done(struct dr=
m_device *dev,
>                                 crtc->base.id, crtc->name);
>
>                         if (crtc->funcs->page_flip_timeout)
> -                               crtc->funcs->page_flip_timeout(crtc);
> +                               crtc->funcs->page_flip_timeout(crtc, comm=
it);
>                 }
>         }
>
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index 45dc5a76e915..47a34a05f6de 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -616,7 +616,8 @@ struct drm_crtc_funcs {
>          * and can be used by drivers to attempt to recover from a page f=
lip
>          * timeout.
>          */
> -       void (*page_flip_timeout)(struct drm_crtc *crtc);
> +       void (*page_flip_timeout)(struct drm_crtc *crtc,
> +                                 struct drm_crtc_commit *commit);
>
>         /**
>          * @set_property:
