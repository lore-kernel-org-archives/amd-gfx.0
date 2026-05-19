Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A007CD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 16:21:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 165DA10E3B8;
	Tue, 19 May 2026 16:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XoHWkeeO";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 903DA10E3B8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 16:21:27 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-12dc1c0b724so124869c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 09:21:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779207687; cv=none;
 d=google.com; s=arc-20240605;
 b=D1U3Yw/M02gjpa+HrNl33Whltdjzwq5VJ6Eb2/OUlz++xGsP/yjRCB73Qmwi0Vo8bl
 VCTUpEqvJJNt85MrwCMuEZz+NkRgXJT7ssyLV/Zqb8jwKRunrZ7cXGJCS90gM9Sb+XzQ
 d38dK800FQiq2y3CZTRpHqtknza/qY27Q04VHWoFgFJy3YMa9xmmqxQ4iGYPtAjvQ4cc
 9mJAGPmSOgWwXdcw5Vzgp7tLM08NISIlehVW9WSBPc4a0n85cLhpnK72rNVL7uoEcgyL
 0TJpOFF4NrWNxn5p+fPtUH+/oj668D3z3Ig5qXLa2rqPSTKbgjgFEyKnXCjnLXSEzWh3
 TYzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=I2ayHD3/ZfYeNPZK5j/sFZV+P7L6fxNXe23iAOBkRZA=;
 fh=328T9GRFRZ0Ry2IYaUGQb2Y6Pxk1+sxW1A/L2dQeS2g=;
 b=V/FerGMLBf4k9+a0LKjZ+JYod0Qbg4sTh2kYyc2fCaUiQT0kHA02m17db7xmADFCWN
 xIZbzdRqdYaKzsyCspVuAJcvIN3ve8RCN/dD57MJ6kfDR2a9uAZcS+DmRSj+h7T7feGi
 8vfgQdbZzjdI4BcYJ1pKbz7QkxPR6AJrq8X/QZBeSbOVAjIPU1pkyeu+ghKICKHi0AEG
 +Mha54NzRQmttkDo5eAuvnyg7rpU0q+LY9SHweI4vhuTfVDVECSBM9IAGXv5u0LKSHbJ
 HWS7/fLIic+268FjAmJC1pIGP4v/NJJkhiemH1gsHTQSYOEosbIG3aZsrSCnJq0FLOuV
 Z40Q==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779207687; x=1779812487; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2ayHD3/ZfYeNPZK5j/sFZV+P7L6fxNXe23iAOBkRZA=;
 b=XoHWkeeOe1LMkvVRa/nq25T2GMEwEGzo+DHiKKM+pFdh+Fc3NF2hzSXoI4uEixv4ly
 ONHuvAO/2WgHhwpj4yMZKfFc0aaOu9OCVy/O5Pqe9ush4DC9C+g93qZDNOuWuV7mlWIS
 wcfq4tEyu3E6X2wvRbJTJ/Vrxt3fgi8MNg/Phc2VMCPqJSIVWb8UCUMzPCPMh3ECeQTq
 tt0nhHhRupe8luTWUm7SGmVOO0KkMk2q07axGrEQkzBU8YJc3D64jS9wt+SguFaEnfXR
 EViD72ikd7gZgoyUL+ocTn/rVqZ5Tjh2AZedvFHeQSyNnqyImfim16aQa9L0katccUUw
 wMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779207687; x=1779812487;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I2ayHD3/ZfYeNPZK5j/sFZV+P7L6fxNXe23iAOBkRZA=;
 b=J1wOikSGWLjMHww/EevH1DZlJDT7l7cNqyKvOFataM91P/DQERV3xyljvsev1uA1kY
 /b0zLSZFtdbwKDt3ydl1InrbOCPkTQDN9aiYoqcDQpKLt6py+VC09zp+LVu3eeUkuHY0
 hAya+5VAv59H3skBjbZISBZEB+XnD5ja3DCXDNDbYo+ofycoeFDkscvdx8BImFk0693N
 Y4S+mwkTvkXH+TjliH6+uzJuXkzF79IQk/ynKMAXNb3+vML6pPwFgwXzJdToxblAky1S
 upll03XJD+pcwpOAmDVeljcWQamhOh/DYhTOIWOBxnqUsjrsiQ7Y31GG772gfp45+3ND
 ttPA==
X-Gm-Message-State: AOJu0YzKG4RFrYJ4cI8RGPUYKNBYYLkjciTn+CHA6DsNR9GaZZcMAx5q
 yFUsc3HdNBH9veB5Tt0NKZtKrvet8O4b57gK60qAYrfDZny6MhcAWcG9hIFNsIZxTApx8+iP/rB
 j7ajVeaUdjdW5O/xCwVryalZPOIkjmN4=
X-Gm-Gg: Acq92OEp9/TOCvkE5YNi65+751y+Yu4kxBpPPmHefLSstfA60ShgenI0Y6QBud0yHuw
 2Kk+d/RSOy1a+Ft5D63bVCiIN3HDLd7msT4uPCQArgIiVrjuvRMRT5+nqaR0u9OLjnUVEnp+QhM
 I4k8Dg0StgkYZ+nnQXxNdTa3u8RPH2CXQNTyuXXlbVWt6qKYc0lSsHIz6j+tLeqOcBxDQ0BOw3s
 lXkqS/jNjxGUHxA5hlMCnvXwYP9ltmbePBf+VF69c3yKq9QpjdZjptOGa7xjhWmwAR35YfJRH+t
 hBhjGFyeabT+hf7ULpPiLiAA0BOWzJukou3nCNLLfmbAE5zoPFoLN6MnfRfj+f5jSN4nyV0tFt6
 zCV5v
X-Received: by 2002:a05:7022:689f:b0:12c:8862:368d with SMTP id
 a92af1059eb24-13504943b3bmr3592808c88.4.1779207686739; Tue, 19 May 2026
 09:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260507200408.208219-1-jinhuieric.huang@amd.com>
In-Reply-To: <20260507200408.208219-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 19 May 2026 12:21:15 -0400
X-Gm-Features: AVHnY4Kswwri0TWyrGwT42Qsq523oeHqm8mO6l8KZu6-pILthAQqGQdoW4Qq9VA
Message-ID: <CADnq5_PQY2L0vyngpCmfT5j2ZgKOkvQnXqQj+EmSt=hqemK=YA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix NULL pointer bug in svm_range_set_attr
To: Eric Huang <jinhuieric.huang@amd.com>
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

On Thu, May 7, 2026 at 4:24=E2=80=AFPM Eric Huang <jinhuieric.huang@amd.com=
> wrote:
>
> The process_info could be NULL if user doesn't call kfd_ioctl_acquire_vm
> before calling kfd_ioctl_svm.
>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/a=
mdkfd/kfd_svm.c
> index 25b3ecf85f30..72cfb4a6ab3e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3732,6 +3732,9 @@ svm_range_set_attr(struct kfd_process *p, struct mm=
_struct *mm,
>
>         svms =3D &p->svms;
>
> +       if (!process_info)
> +               return -EINVAL;
> +
>         mutex_lock(&process_info->lock);
>
>         svm_range_list_lock_and_flush_work(svms, mm);
> --
> 2.34.1
>
