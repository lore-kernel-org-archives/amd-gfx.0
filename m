Return-Path: <SRS0=wRAp=4H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A14C34047
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:07:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A36CF24656
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Feb 2020 15:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nuvKjjW/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36CF24656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D276EC1C;
	Wed, 19 Feb 2020 15:07:57 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FB86EC1B
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 15:07:56 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id y11so941275wrt.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Feb 2020 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=y9ywMlRID8tFJL0XTHw8n2Qxp9uoRNf7tf5oI2yIrDE=;
 b=nuvKjjW/GC4h45nrUd8IAEIcGUGZqxEcjnaImxY4qOVXpSoj0qyphCfcllDPzpj1A0
 WNyKVtVMHPdpMzRZCgKbFgRJX2Wgd9//nRRB4C5eEZ7Z/hNO2mzhpKYboKcxDeNdtjHV
 85W4H6ueP8yL+qIow5Pv4QfcZ1Y0gSFJSmqihrdWyLClwnznPfQPSklRxnfIdzt2f12h
 XMvrrO8cRyB0Z075HroAdVPPZp3NBHWSzvaX7dXlIU1QH8DgCAD8TbF9qomZLn4hMcQi
 jEMHmuI2YmYXuEEUJgS6Tojh8XNNBeFGN2jnK3Q+TYKhIO74h8qhj/jYIWjaZcJEyIr8
 rTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=y9ywMlRID8tFJL0XTHw8n2Qxp9uoRNf7tf5oI2yIrDE=;
 b=tDngshEBDnOsDoUT8tAZw0XZE0fWyTpUlSoY5PAiy1bNc3oE04DUWe8SsW49bB758o
 UHPG7SrZGSGGp5+CZTiVV4oggmRYTcJpNO14dA21gdY0Ky9LGMLYJKEwJ7RyCrPSpvfj
 erb+VPQ7jecgIRFO7lkb+jjU6plez1RzyNGm40bfQ7UxGQoEQIRwFqNmODltrJMUNjX4
 qDa1BEwvaA+snRj1q6uT3xteznPhZVtV/v/Q/gF8bvtIa+W9aD7wCuoXNDGmM++qSBny
 fK864TO8RBvQduUEVHfO3jUx5JYVv6oKnKQE+ffb2BGS7Fg8lTl0MHS5t6ou/QzBFQPB
 bH0w==
X-Gm-Message-State: APjAAAUCyMd9mWqfUAGYF2pR+KfC2RKrqPz11Sk5QkUYKAsw3o3umO8A
 dcx/DIQxv+FCRCrJJ56EUsUpkjZ/pNWvHmDVR4g=
X-Google-Smtp-Source: APXvYqwbTntyrrPxeJMBf+6GkORieE9APJItdZbT2kqNNH3BAZeWeDPT6/HxFq4KcsIV8UWc37+Vui7KrnvuBrVqIiI=
X-Received: by 2002:adf:ec4c:: with SMTP id w12mr38232743wrn.124.1582124875144; 
 Wed, 19 Feb 2020 07:07:55 -0800 (PST)
MIME-Version: 1.0
References: <20200219150417.510884-1-tom.stdenis@amd.com>
In-Reply-To: <20200219150417.510884-1-tom.stdenis@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 19 Feb 2020 10:07:43 -0500
Message-ID: <CADnq5_PaR2a4UCwQFF6y1A1MCqaDAbPbFJZSzdBcTMkRnREw5g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: disable GFXOFF around debugfs access to
 MMIO
To: Tom St Denis <tom.stdenis@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Feb 19, 2020 at 10:04 AM Tom St Denis <tom.stdenis@amd.com> wrote:
>
> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>

Please add a patch description.  With that fixed:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 7379910790c9..66f763300c96 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -169,6 +169,7 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>         if (pm_pg_lock)
>                 mutex_lock(&adev->pm.mutex);
>
> +       amdgpu_gfx_off_ctrl(adev, false);
>         while (size) {
>                 uint32_t value;
>
> @@ -192,6 +193,8 @@ static int  amdgpu_debugfs_process_reg_op(bool read, struct file *f,
>         }
>
>  end:
> +       amdgpu_gfx_off_ctrl(adev, true);
> +
>         if (use_bank) {
>                 amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, 0xffffffff);
>                 mutex_unlock(&adev->grbm_idx_mutex);
> --
> 2.24.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
