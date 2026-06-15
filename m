Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BCAECD98C5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 14:59:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F21AF10E4D0;
	Mon, 15 Jun 2026 14:59:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NC4/CzHu";
	dkim-atps=neutral
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6944D10E4D7
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 14:59:30 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-304cf9a02f9so203528eec.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 07:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781535570; cv=none;
 d=google.com; s=arc-20240605;
 b=CJxG7hsh6iWgpGFQJaWe3VjUIh1XZ8JFtfFyflJA7Yh536nfcN2ZO2aqoYEnA/Axof
 JnJqkgFzkEivl8X+dPNRy18LjKlwugwDeHKyECmC0SRQkYZ65zuxV/KUstuNv040BCyo
 /LF19OE+S3+gNMxTZ3aTt9AmH/VPQjz7IjJCS7MmgQqyXFi/xFIcNQZ8TS3eAmV45/Jg
 3gztbRjbXVpugiAwd8K4B8aTpY1xEEI0Eyn+p5PPW9yslGuyJWq2Qcxqbg51UxDt+5S0
 fPyO7vSi3M4Plcwf8NwtyaeoOh+Mu/ElTUK+d2NrOU46q+dN/yXfHjtQLbBBL6wJD8zX
 nw7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=seU9lJSpoj7b36nU9J3WfkpYoqgZYKZylfk9jL0IY4o=;
 fh=tHaW2Dnoj02vwIx2N49MV9LA78qZTpeHLM8fBIf8vts=;
 b=DyYmi3xko03lZ2/UtgX6/chjlcdJ//wBPKuUY3UEO6PM/KRZK4pi+3cB/3GO4tgBHB
 ClMMVJoSMTDrck3RTsEFtAQ26Xesczn5hzpGZ3Rpw33oQwEeWZBYAmFw1iSeEYYYkpQB
 RuOZh64H9VKYBObWn2dLhF1DuQKyQMytyGyZqeLf+vDenvCwB7Ed87gCNblrMycduHKm
 gA/ORRb6BQAMDgMa2NypjhO8TYKAyzx64WdJ9btMk95jn3JtyuEEpPMQX4ANnN3EvfZe
 P7sN+dMpDEIhlnkL98imiLulQ2ayfuOllNJzNQegTt+PdLRS2obb0YrKtvKM8a3yjVsb
 iPSg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781535570; x=1782140370; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seU9lJSpoj7b36nU9J3WfkpYoqgZYKZylfk9jL0IY4o=;
 b=NC4/CzHuzGV+Ce60dBSDRHTMBUyHCBM6ek16dstX0XXQNmbU9Sxa8ANm6/WsYm7Qxg
 r5jtMVztel/5l+d+NXyd4iqitaONkW5yVWV0cK+lzXi2JdT9TcKFgKbAZN1YT23u2zUZ
 lRfjqyldwDbmgwWvj0B7CEC8HCB4ddgo8ksqW29NqiEYvsf0sH03F+ychhDhOUIGvzFb
 /S5zTll31F9Q/TKBcxGmxbRh5De7uTUvCgQ1VFIpaPEpM+u3oiRKHs6YlSXhRpqZWd23
 RnP61En6Jbla7vxm5GmB/TqTNnhKn52wnMoHnndy1T5u+3LCiNZFQJAYpQU3sNYHMrCM
 pD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781535570; x=1782140370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=seU9lJSpoj7b36nU9J3WfkpYoqgZYKZylfk9jL0IY4o=;
 b=VomXXecOO3DR8rl0mvYcLeeBwq0uexOfSQ96vqkFEegEw6Osg1jjJ3Q67OeVourTiV
 TA1pPEjqP/WW941tgK8rDutu9gMtS4zxhnEPakRjM8xDYnc2uFTL1BcuQJVMbjSTIptV
 rVQGAqiAk4bs3hMQlTfPdBmdKh08zt8hyVqQJEhXXSOTPjwYP7VT6eHrYHyXYodY40Qk
 aUJmkQZMIEPms/f2LmTAjyDg3SI7NLTTf+fJPdqZqhYgn6nbb24bJDYUpYivh2Q+DnYs
 W79DgnBgmHkv4j22vmHL8C/tIhqQQ64WienYygcx9ke+SMEK48vLHcISY+O0TzplDNoC
 73UQ==
X-Gm-Message-State: AOJu0YwehefFBBKT7Athl2wtm/kvZalI/J6WfzQZL0J/qYb4g0J9C0q2
 zRjVytd9zZHGVHmbnDxKg3VDjSw5N+G4e2keU9Ry6GnEzZyJgtI2wCge7A4KDf4YcWt8TlEAvX7
 dntUH0n92vHkrw3NEbfU1q2qYq12+1vc=
X-Gm-Gg: Acq92OFiXpz4mwQ/1bpQS8yFpMUFLU4Em3mtbsPqEc7eZopRJ8rN1mFGZRF4diIyzHX
 MqiVDHebXNwr/YeNIMCT8g1aqoYJHJbtQpMZXuJonW2V5Kbz03cPcdFB6VGYy7ItT+Elh/DyCed
 8dGvWfU+ILaIH1SFD+1CrF6e2G50OaP4TfdzHCCyeKdrfq9YU1tOOTy6eQx5rHLejTP0NPBbVyV
 au7FVWaRgwz0Aaej9eAQA9GdtyIzZhGaqYt8+ImeDC9XvD9EpayEQfTQqb2pSbk2PzFtTCK3zBc
 0E3PkogJKRa26KfaG1VzRtJSK0CTbH9yyXCERiagytCfjIvjfYPXLbTTCvOFDYeQYsewyg==
X-Received: by 2002:a05:7301:fa10:b0:2f0:ddce:8468 with SMTP id
 5a478bee46e88-308200e51a3mr3523187eec.8.1781535569630; Mon, 15 Jun 2026
 07:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260608185234.503799-1-Harish.Kasiviswanathan@amd.com>
In-Reply-To: <20260608185234.503799-1-Harish.Kasiviswanathan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 10:59:17 -0400
X-Gm-Features: AVVi8CeM9Lqg1HPnNnpDFDFi0U_NoUCPpDF9upBC87DC09U5OXBtBkXv56NzmlY
Message-ID: <CADnq5_POg5ZdksW1Qp+uDNKt-R2njSL04A8gMKPtELiJ8Xo0Cg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fix kfd_is_locked under VF
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

On Mon, Jun 8, 2026 at 3:09=E2=80=AFPM Harish Kasiviswanathan
<Harish.Kasiviswanathan@amd.com> wrote:
>
> kfd_is_locked remains locked, if the guilty job fence signals during the
> reset sequence. In this scenario, hw_reset is skipped and
> amdgpu_device_reset_sriov() which calls amdgpu_amdkfd_post_reset()
> doesn't get called.
>
> In bare metal, amdgpu_device_gpu_resume() calls amdgpu_amdkfd_post_reset(=
)
>
> Call amdgpu_amdkfd_post_reset() under this condition
>
> Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index dc8c650fc341..cefe1e5dd946 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5888,6 +5888,16 @@ int amdgpu_device_gpu_recover(struct amdgpu_device=
 *adev,
>         if (r)
>                 goto reset_unlock;
>  skip_hw_reset:
> +       /*
> +        * For VF, gpu_resume skips amdgpu_amdkfd_post_reset (normally do=
ne
> +        * inside amdgpu_device_reset_sriov during actual HW reset). Sinc=
e HW
> +        * reset was skipped, we must unlock KFD here to undo the kfd_loc=
ked++
> +        * from pre_reset, otherwise KFD stays locked permanently and new
> +        * process creation fails with "KFD is locked".
> +        */
> +       if (job_signaled && amdgpu_sriov_vf(adev))
> +               amdgpu_amdkfd_post_reset(adev);
> +
>         r =3D amdgpu_device_sched_resume(&device_list, reset_context, job=
_signaled);
>         if (r)
>                 goto reset_unlock;
> --
> 2.43.0
>
