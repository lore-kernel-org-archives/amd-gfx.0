Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEACDE6BF1F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 15:35:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43EBA10E0E3;
	Fri, 30 Jan 2026 15:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QFC5EkBn";
	dkim-atps=neutral
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4087510E0E3
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 15:35:43 +0000 (UTC)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-1244bce2c17so43605c88.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 07:35:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769787342; cv=none;
 d=google.com; s=arc-20240605;
 b=KipAHRTH4LWCFrGu5oxyqItokzWQ7pwcpCvABftByp0V+UW3aVOVpn+CJ10gGVw0pv
 5lFGftB8wbfZhxiHjx62WDOpICI0rDCfuL6Kq2tp31b9eIRrE1s8ulo0rK1B7n7C31dL
 s+OU2s0X5tklaQGxcwLjFhuBtleIHkCj00sIUJByljg4IEcDUCOYnnAPVo1jySbvEirv
 t09fwS4skayuOOOrMNTBS0yKgC8TmcNHSMQEDY1NMLN2V79KIEsGwMVvUh01AOqf42HC
 wX+Jm6Cvg3a+R0UIwi6mxIcDf+7eYA9GjBOqHD3GPtXR1yfsacIP2oh+IAKJDxNbRG8q
 6nEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=aee1c7/LfegmGXFD+zpVbAYrArpdgNCxbbxY5hZvbkM=;
 fh=apalxpwyR7RiWXbdBftMhuQdUwwwLsjURd1H39azLJE=;
 b=JOdgoAQrrilaCWFtC0hgzCSfYZcZUvJn+kzVSp01enaTY28CZahkLPfi5y+lxfh+A8
 bLP9Vu+lEXK2AZZXr8+EdMLZeEtgVkHJKq9BKxXcNfxxq03SgCzvkzQml6GT0zXejSPK
 kIya8VFDwyiMiVXYf5dEv1WSOLBgc9Gl487JV/ihRAgEkR7VzQA471Dpy6kQAUa/qKAu
 GjN0taNio1VuTmkmEyNHqa+r5K24gw245UPeQTwDLco2T4aNzoFaAvXMDfJdhzX/+X/S
 XUegymMFjTmbgPHiTOIMX3S4Vkj0ws/oVa7I+swKD19DKcCBOdsZB/Ai+9WymK0f6Xjc
 iM1Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769787342; x=1770392142; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aee1c7/LfegmGXFD+zpVbAYrArpdgNCxbbxY5hZvbkM=;
 b=QFC5EkBn9i8t7Ak+jUQ5WBH3j48pdSsrTwaE23EtcJnc5MAg0FEdDpvmvw5a9rRsqU
 llu4zjmeNJ7J323gW6lYdgf3YjqD8ol/fQ77guOfcMwXZZX1MBR8kM+rqmzgxelpjX2A
 PFyTHEKNW4ZbuIA6ZsU3J6xijKBohqFujzjU3Aabe9yAotfufjjcu9cG0MNKnUvBedtK
 92i+7O/8NWsSxH8w55tPccXWXwIMWe/sd2bCsln5oHITBohWZfdlNbBcHeXMuO1cY6Dg
 CrjMZeWT6IrM+bod7mJKwKLsssQFTnVH4gBFFyMTUJAtrbxBG2+6cU7wVCbCNE9du62m
 Wj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769787342; x=1770392142;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aee1c7/LfegmGXFD+zpVbAYrArpdgNCxbbxY5hZvbkM=;
 b=RKQKNTeZKpYjPEDwMjVZWF+PXTRuuYjf9UlzDCCHV37zicKoTjn07OFCd33Qvscp4O
 SKyBOm1yHKkL6fzkF2g8DlPbW329CxJZEsj8St2KVoDj0VHwJpxdPTU4CgKTYxV2D6/t
 jKN5nYT/jYdFmITDJY947Y1kBBwFfy6WHHhTPznAWXzm6gBI6e8VO91DAHYCIDJvTuTH
 9llY5TRNqJHPIDnymM+lk3E5Zq52YKzjWuXOrspbincJXWoC+L40QKDTxAAxQnHcBryg
 v7OCR9S2yW6tsaJ8LUqT+JaOi5ygctYD+VvC9b/rydA2fow5rnQ9QHgU+11CJCR/a6Jc
 zw2A==
X-Gm-Message-State: AOJu0Yw9p2Pt6AltnwgskTFA9JOrN7kzulCsDQois7MJKaFO1mQi2Okj
 WSGKrvf6NDxIPFPUXqsugBapt3tSO8BluKpAJGVF+yeCLnIT6XZCMr5Zdi+rOY88f5nfVnjnszy
 DJYo+eNjxdFdv3ZJhoWhd39OmRWgNtm0=
X-Gm-Gg: AZuq6aLcD6aMjTAyVdXmWIP2Y8Iysbh8AqT39IxSybHdtfVRp2/Q9Yek0fdRCot9vLL
 oX93koD4XAQOPQDXBcrb3laUyVxUuv2SCfbMTfvJ+0DNbo8M3ig9i2CcIvQSMYF+NdzZTAfP01J
 tl/reF4Uzg6qutTQIu4H7hIwQq/8/4RkbS2taw7oPX5ZJoPO/q5X93LaMwDc0fqwje8SPlhqP48
 WDD4tpNZb2XxbFCzu9StmEzqG5ru8Erf+DR9DmbdhvJ8cW/VE6UbC0BaO1jMjKPcEUbyMJl
X-Received: by 2002:a05:7022:2395:b0:11e:3e9:3e98 with SMTP id
 a92af1059eb24-125c101b534mr802639c88.7.1769787342377; Fri, 30 Jan 2026
 07:35:42 -0800 (PST)
MIME-Version: 1.0
References: <20260126061921.1886410-1-yifan1.zhang@amd.com>
In-Reply-To: <20260126061921.1886410-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 30 Jan 2026 10:35:30 -0500
X-Gm-Features: AZwV_QhPCp3x5qEp1Kr-sgBR0jbJgprWNn7G4ULHvv30hAjm2_c1UJDF62I3-kA
Message-ID: <CADnq5_PJ=O+HY1PbP5Yj3iuSrhQLzkooaBmrV4vFsVLcZ4P_Vw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: disable gfxoff in amdgpu_irq_disable_all
To: Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 perry.yuan@amd.com
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

On Mon, Jan 26, 2026 at 1:37=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> =
wrote:
>
> amdgpu_irq_disable_all touchs GC registers, keep GC awake inside
> the amdgpu_irq_disable_all function. Otherwise IMU may be stuck due
> to invalid GC regsters access.

I took a look and there appears to be two cases where things are not
protected, amdgpu_irq_disable_all() and amdgpu_fence_driver_hw_fini()
in amdgpu_device_fini_hw().  amdgpu_fence_driver_hw_init() also gets
called in the unwind paths in suspend failures which look to be
handled correctly.  In amdgpu_device_fini_hw(),
amdgpu_fence_driver_hw_fini() gets called after
amdgpu_irq_disable_all() so the interrupt should already be disabled.
So patch is:

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_irq.c
> index 82bc6d657e5a..85e5399fccad 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
> @@ -162,6 +162,7 @@ void amdgpu_irq_disable_all(struct amdgpu_device *ade=
v)
>         unsigned int i, j, k;
>         int r;
>
> +       amdgpu_gfx_off_ctrl(adev, false);
>         spin_lock_irqsave(&adev->irq.lock, irqflags);
>         for (i =3D 0; i < AMDGPU_IRQ_CLIENTID_MAX; ++i) {
>                 if (!adev->irq.client[i].sources)
> @@ -184,6 +185,7 @@ void amdgpu_irq_disable_all(struct amdgpu_device *ade=
v)
>                 }
>         }
>         spin_unlock_irqrestore(&adev->irq.lock, irqflags);
> +       amdgpu_gfx_off_ctrl(adev, true);
>  }
>
>  /**
> --
> 2.43.0
>
