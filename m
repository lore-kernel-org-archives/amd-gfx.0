Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C6AFF6E7E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 20:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8978310E159;
	Tue, 17 Mar 2026 20:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lp32T6Nh";
	dkim-atps=neutral
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7BA10E159
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 20:52:02 +0000 (UTC)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-12736a0147cso346514c88.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 13:52:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773780721; cv=none;
 d=google.com; s=arc-20240605;
 b=ddBYj7cfUxef4oGWiz/1+j93ZceL3xCmlLNSUdZwS6th2oQ4GMgTJ4KbJkjotR1sjY
 IUwONOscDOVtrzjjIJr6ENaAzDioVn7pBwRPHbnVPj1pMeEepnU63Tm+M6bbYiKdQOhu
 BFUJhjP64AhRjs22W0inM/bI2gzO6hj0lnFZNiqSMGy67RNalcV0qZojD06xgmeDy09F
 AGHNMtXxG1R6CW77FpZwlR+CnGoht+yY998gYXHoDOZsUg6lERjtVNvhFHaBnnp+FQDw
 89i4l2G11qqQ6xoa5A7nLAaPOjYcG9C/G98rXs9hzqoq+mI3Kn/BPBbngKu2a+TBFZmg
 8iFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=WGO2fCPNMOtW9agiRSU5Mge9f4rmivI8vDi/WH8tpSA=;
 fh=aBAb1Ubey35l1u2DiVmBGuEoFdMLiLOtO9lq3+8xkUg=;
 b=cQryO+7i2ehAhBlMCkYvhhfFHRCHBHkmHMU6gnWaz8YWv9BnSr4DTF9dtUlc0O049r
 s1fd1wCQaS4n6pEjZoaHIxGfZXLsBYHNYdq1sKJkM2XAFj8kmk0TvjA3ItvMQM7cR4HB
 o9+M1uxJ5mGPGkYF7CbiYk6/qeYFe9HX1M4XeRX9QfXJlFfeXCfgHNdDy54WnSrvFIWZ
 IW0R6/9O7NAQXfXvzbJOeNwsSK5UuwxsUmzIeJY65m7kvMXNHg9V1zLW5vHaMyJSK5Zj
 zUAz2ZWEEalsV5jc/Ezr7fvFkT9odjDX7FJvE/YPjjw++TKKrGqO4KtdHcNWdOJW01Pt
 KkVQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773780721; x=1774385521; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WGO2fCPNMOtW9agiRSU5Mge9f4rmivI8vDi/WH8tpSA=;
 b=lp32T6NhdrKjJeizU6OGZi9QuOG3CNyDQZMVPDhnO7D1J34GxECS32WPQ2mUim6kaF
 yATMH36pbqXCQ1YMQCkkRQPYZpDIz4WpVFf7ra9DqO68s+K/st7hBLhVgmpvTC60IlRU
 +OaGwfON3PkNK7nQbo7yXiAtGKbkro8p1yu1YK8q+nuXzD0TPgjSXRbPFlX5tiF2wiAE
 rcjI5K59Be4wv+ugvy68ECDoB/IsMBtqIUlT+Ynwb7zcmE1GE1xoCYxyjRyKkD3CyKtN
 BhFk5pnP0POId0DN+Ht58ld6exBbIVIoFYDPnGJa0piJvP7SeA0lIuM0MIuCcB9IsMh/
 qIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773780721; x=1774385521;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WGO2fCPNMOtW9agiRSU5Mge9f4rmivI8vDi/WH8tpSA=;
 b=beEM86s8DTTs3QM6cdxCVRwjH+iKLtOdQ0iiDMoHaiC1n+m34ripmVjV8hfoOuF65M
 ZoePDs3CGOKn4CLCHiRstrHPo+Y+2b5sH2bSZlc9JmVllS/OJbvRodYmZN04GXeFvZs/
 cD9VrQMkT9mvwpMdChs3zwnHhn6AWoBs4DW4rolT5ez5Tnqn8JzNVt7+0JDUU4wSGSqu
 OdGZbHRmP/crPTs/UzmI/X0HdVEgk1wvQMqmjNI5bfy8PLTLSzDWPXwgUXeJl/NQ3hZJ
 D1ovczp5cTRAnB5gblbCQFHuO6iAzP8G7YdM/Vw7+//+NPn4/BvM8IV5M+fqMX3qPbDP
 PXuA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLD+SFcT4SB/AEoKIZkAbRJyR+0yYmokfSEBgMMWg46NZ+OyS0J1epm4jhDx+4sVuJFBW42Pse@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx49A3bEdM9pSPTf+VamRkM/dP3wO5S3AOxbYxkQFvKUhX1V7SQ
 cBKzt3fRC4oTbZJVfcx/WQa94yx9eWB49R16uhmCuk8nXe7mI3s07FZymSeCaKMy84FtJCOYsyu
 y9WaqVg9MgcsoitXwmToq/wtEzaVFg7U=
X-Gm-Gg: ATEYQzw0nsNnOXnSUcMH+l0n7XxmUs5J9xJqc1P8vIHcPOH1odELNoahEHrrLRZwkhx
 PCbpn6OZE4bt933dB4+fyC3adYXvsl4ruTcS62FJR4250UsGmPqn9ebPD5bTQksZziDPxetMr+o
 n1H7/qRcuZ0MflmbF5j7099DQv1WzHJYp18aIRr6kqCmsVVQGNlRbsYLHMPKzN35j8/oUgS+sQe
 5pizaUkQION0eqGAdd1pQ8ZZRISq29wi1UBut4NzsEMS0HYIxY/68BBQxsbelztAHOwcr2G6/Zi
 Yfeaqo7piRFPbR1KZIjIl+nhOibdAdiaoQYsclbagw1965G+CNSwTLutd/zFJrjcCXzBiTiRceM
 3RPza
X-Received: by 2002:a05:7022:e2a:b0:127:3480:7ca5 with SMTP id
 a92af1059eb24-1299ba66068mr289014c88.2.1773780721109; Tue, 17 Mar 2026
 13:52:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260317183943.43849-1-ruijing.dong@amd.com>
In-Reply-To: <20260317183943.43849-1-ruijing.dong@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Mar 2026 16:51:49 -0400
X-Gm-Features: AaiRm50CjwB1iiJ7DPDT0FYXlNQ73H_IXZTsh5039qE8QCA7BFBNu2qchHgDy34
Message-ID: <CADnq5_Pn8neXStN8PPLnC5J7SZoqVYGPhz-B6pLoG=7CvF3d-g@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: fix strsep() corrupting lockup_timeout on
 multi-GPU (v2)
To: Ruijing Dong <ruijing.dong@amd.com>
Cc: Christian.Koenig@amd.com, Alexander.Deucher@amd.com, 
 amd-gfx@lists.freedesktop.org, leo.liu@amd.com
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

On Tue, Mar 17, 2026 at 2:40=E2=80=AFPM Ruijing Dong <ruijing.dong@amd.com>=
 wrote:
>
> amdgpu_device_get_job_timeout_settings() passes a pointer directly
> to the global amdgpu_lockup_timeout[] buffer into strsep().
> strsep() destructively replaces delimiter characters with '\0'
> in-place.
>
> On multi-GPU systems, this function is called once per device.
> When a multi-value setting like "0,0,0,-1" is used, the first
> GPU's call transforms the global buffer into "0\00\00\0-1". The
> second GPU then sees only "0" (terminated at the first '\0'),
> parses a single value, hits the single-value fallthrough
> (index =3D=3D 1), and applies timeout=3D0 to all rings =E2=80=94 causing
> immediate false job timeouts.
>
> Fix this by using kstrdup() to make a local copy before calling
> strsep(), so the global module parameter buffer remains intact
> across calls. A separate pointer is kept to the allocation start
> since strsep() advances the working pointer to NULL by the end
> of parsing.
>
> v2: wrap commit message to 72 columns, add Assisted-by tag.
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Ruijing Dong <ruijing.dong@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index dcae77b6c272..97ebcc5bb763 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3498,7 +3498,7 @@ static void amdgpu_device_xgmi_reset_func(struct wo=
rk_struct *__work)
>
>  static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *=
adev)
>  {
> -       char *input =3D amdgpu_lockup_timeout;
> +       char *input, *input_copy;
>         char *timeout_setting =3D NULL;
>         int index =3D 0;
>         long timeout;
> @@ -3508,14 +3508,25 @@ static int amdgpu_device_get_job_timeout_settings=
(struct amdgpu_device *adev)
>         adev->gfx_timeout =3D adev->compute_timeout =3D adev->sdma_timeou=
t =3D
>                 adev->video_timeout =3D msecs_to_jiffies(2000);
>
> -       if (!strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))
> +       if (!strnlen(amdgpu_lockup_timeout, AMDGPU_MAX_TIMEOUT_PARAM_LENG=
TH))
>                 return 0;
>
> +       /*
> +        * strsep() destructively modifies its input by replacing delimit=
ers
> +        * with '\0'. Make a local copy so the global module parameter bu=
ffer
> +        * remains intact for multi-GPU systems where this function is ca=
lled
> +        * once per device.
> +        */
> +       input =3D kstrdup(amdgpu_lockup_timeout, GFP_KERNEL);
> +       if (!input)
> +               return -ENOMEM;
> +       input_copy =3D input;
> +
>         while ((timeout_setting =3D strsep(&input, ",")) &&
>                strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH))=
 {
>                 ret =3D kstrtol(timeout_setting, 0, &timeout);
>                 if (ret)
> -                       return ret;
> +                       goto out_free;
>
>                 if (timeout =3D=3D 0) {
>                         index++;
> @@ -3551,6 +3562,8 @@ static int amdgpu_device_get_job_timeout_settings(s=
truct amdgpu_device *adev)
>                 adev->gfx_timeout =3D adev->compute_timeout =3D adev->sdm=
a_timeout =3D
>                         adev->video_timeout =3D timeout;
>
> +out_free:
> +       kfree(input_copy);
>         return ret;
>  }
>
> --
> 2.49.0.593.gd86a19f485
>
