Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C2AE7DEEE
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 15:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB3510E4F2;
	Mon,  2 Feb 2026 15:29:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f0i/ZGmN";
	dkim-atps=neutral
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DA98D10E4F2
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 15:29:42 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-2b807f85e10so115556eec.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 07:29:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770046182; cv=none;
 d=google.com; s=arc-20240605;
 b=NrZ2gz339yCVqnfP4V09yFrveE22g4wY7hbNtr46h6/8E7vDZgLW6wJdd0JykLoQC/
 lNg6zOGepJq6CtdSg0cvGN/BtvdZBqN24LEyBQnOCHG6Uhel/d8pR3JO/J4lhGiwlk2Q
 IeqkGFLNqa08bRUCqQbpzI/Hc8uA5bST6BFj8x0ZGA2lPe4QBDM/ZyS2ChFvwj8y4Esk
 Dtz+u4sC3UcordJDlS+LDjVBM53IHM2nxCs+XrXlpnXf58nY24GEJS/3UgBaD2g9P/1N
 mcwrCT/05o13kM8I008+Z7O4ZvIjL6lSHcS3b6tFY9eA8MdVwrSh0gnQnNmB14b32MAa
 5fsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jIHW5fubiOGjcfj0AG5nGi3RE3BAWrztSPXhX6sFNoE=;
 fh=Kws6D1YXGISdl/juA+kZWX3DSOp447eOUdBiGoTXfgY=;
 b=TOaoSOYVQ1TfCFKaRXECCo1h+lo240NtAWMnbawvAR5QALW2B3I51JoNquYW6qOkmj
 y1JrUeUMNcYkllklRm516PWub/ya4GGX6oWKpnNt+8nD4V3WUSQY8gFY1X3MHJjLO9ZX
 LcGMD4csx3LZcIizk8Kunhv7CA29iwjHHJHrcyGDGgOIwVTzzWRQPhnvqS2kX4ywl3Ze
 P3KzsIwjLcL9odHOwvj/bFRApOY4KsOWpRy9aEIL8aW0kE7Fn84lRf6OH0HhiTgAZoRR
 /To2pPP4/cpmZdKvn14dokOwzPU8ehzMJLgTl5Ae3m3mjNa9yDfDmlzLKzH/F77uNYNt
 cXdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770046182; x=1770650982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jIHW5fubiOGjcfj0AG5nGi3RE3BAWrztSPXhX6sFNoE=;
 b=f0i/ZGmNsErtCj3TLBDjyY4Q/t7ifSxJsFl9SF4QUrMXeXRgDT/uLc9/8oW6GnHPsV
 gheWbL71YpE7Xl0wsl2lBTPrVqDauMit0KqRwZ5Te4RtCBmdV2ZjX72X/lQv0DnPuyig
 CEz1QAzr81P5jsDI6Lr2QK3/ERiIy81P1KZtNGnIaK9BY93Siu9Z3YQCMakKIZBD0+LZ
 TSFeezYdzS+TLNbaTHFN80z9LqvHnjeSggd6XKI8infTVes8Eqe3FhlGVTyL+gYE5kXG
 XLAm7dbnv2ZfzSEHKYLauBEXJHNcvrYwlGtBaeXZ0mrz5vf+Q60BUVdEBSWKD+PQmeTL
 aRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770046182; x=1770650982;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jIHW5fubiOGjcfj0AG5nGi3RE3BAWrztSPXhX6sFNoE=;
 b=h0/T8R9ZS1XhhfZcp5qsgd7BmrO4YtPfDQ2LTESBWSXjRnkf7OcVh7e8UfbtaV6Sdx
 i9xSKl4j6AOnX7kadORnTBkN6Xnjg1wmqFrrP9SNNN4syc6lmYOljORmPAh9+qMtD6iF
 bwfGC5O5Ll8+xfnCWv4sGRjjYmuI+wm/bJ+fCUFsNNx9PXr8KoT5wIg0QFjYn2YmNmP+
 uekVR5tWBXMaYBtcse+75FZAAbgmvrCRXUDbhYf54OxjtXvokazgIbSD1R3IiL0+viQ5
 BgrkI/IVOkjuO9m0deQiFOhmx1m573K4A0InrZrUUSg4KE6EOiw/iNgkIrkLbxtjbxN+
 fG6g==
X-Gm-Message-State: AOJu0YxPiKkqrZhDaJpIbcrMa8g875jepPqBa+N/46vKUlODqbQJvMdQ
 DFbHJdiCWrl1vAsPvo+WdyXZQPcIBoNKKhvyva1oxOp8NYrjz7LwThXaQMbeilSFvWZt9D/Ttq+
 cPOmE/BK6wKAKmtZsvVsWxKWdHMBzUic=
X-Gm-Gg: AZuq6aIBO+IwKhU68oZQuzSi2HmN9MFWShEWfYqP0OZBCmpppCTPi3Jsj2GcOxUckUx
 keXTiEUHnVMrqD/md2oy1xQxm1O3Ccs6UwMxjFOfCn7LaNV4K23V6BOTYVrVs4vUudspuAf+Ohi
 7RGlZGXJLm71y2tzOtfGEqVLvduOOkS6FIMseUG1QeN/wR6xrtuS9w+r8OHPweNMZ597/y4oAf9
 rgwJHX9gvMmB+KG6COr/+fGTyoJRAURKtVpo9d5K8iTFxETqy7NMd0P7FmDZiRXh/3t3ndh
X-Received: by 2002:a05:7022:f009:b0:11b:acd7:4e48 with SMTP id
 a92af1059eb24-125c0f89eabmr3423711c88.2.1770046182194; Mon, 02 Feb 2026
 07:29:42 -0800 (PST)
MIME-Version: 1.0
References: <20260202072452.2364233-1-yifan1.zhang@amd.com>
In-Reply-To: <20260202072452.2364233-1-yifan1.zhang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 2 Feb 2026 10:29:30 -0500
X-Gm-Features: AZwV_Qj-IoLR4OgBrV6TQ8eQYo4d_3M1HKSxhbwZSdve6zSoI5gHFjVwhAiSbZc
Message-ID: <CADnq5_PYTMHUhcwnyhtaU6a+X2TA+9zZZKL-2Mt4cP-SR3bvTw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Protect GPU register accesses in
 powergated state in some paths
To: Yifan Zhang <yifan1.zhang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Lijo.Lazar@amd.com
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

On Mon, Feb 2, 2026 at 3:22=E2=80=AFAM Yifan Zhang <yifan1.zhang@amd.com> w=
rote:
>
> Ungate GPU CG/PG in device_fini_hw and device_halt to protect GPU
> register accesses, e.g. GC registers are accessed in amdgpu_irq_disable_a=
ll()
> and amdgpu_fence_driver_hw_fini().
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e69ab8a923e3..095730c7ef8f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3506,9 +3506,6 @@ static int amdgpu_device_ip_fini_early(struct amdgp=
u_device *adev)
>                 }
>         }
>
> -       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> -       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> -
>         amdgpu_amdkfd_suspend(adev, true);
>         amdgpu_amdkfd_teardown_processes(adev);
>         amdgpu_userq_suspend(adev);
> @@ -4904,6 +4901,9 @@ void amdgpu_device_fini_hw(struct amdgpu_device *ad=
ev)
>                 amdgpu_virt_fini_data_exchange(adev);
>         }
>
> +       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> +       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> +
>         /* disable all interrupts */
>         amdgpu_irq_disable_all(adev);
>         if (adev->mode_info.mode_config_initialized) {
> @@ -7362,6 +7362,9 @@ void amdgpu_device_halt(struct amdgpu_device *adev)
>         amdgpu_xcp_dev_unplug(adev);
>         drm_dev_unplug(ddev);
>
> +       amdgpu_device_set_pg_state(adev, AMD_PG_STATE_UNGATE);
> +       amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
> +
>         amdgpu_irq_disable_all(adev);
>
>         amdgpu_fence_driver_hw_fini(adev);
> --
> 2.43.0
>
