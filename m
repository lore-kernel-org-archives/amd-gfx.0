Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8641606A31C
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Nov 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NWRQWX6/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FE0410E3C3;
	Tue, 17 Nov 2026 14:59:02 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8423E10E3C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 14:58:56 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-8231ccb04a0so537198a34.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Nov 2026 06:58:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794927536; cv=none;
 d=google.com; s=arc-20260327;
 b=jRpNKlJB4hVT0z/aAAhtDI/OR3MXdUtSRpvpB65ieppCKgaorZ3p0StDXGijOWsBrR
 zfQss1ipcvmHztY4ZOn9O83s6ZpHNYs0aha5DaEZNMm6KhD0sV1+GiGDfqoZ8Z8MHcox
 rUWq8hZo8+PEbkMzSpfn5ezNdhlFAFxFxKRcLNqZhaBYAaJAlffBAXgPTBjjngvSB1tl
 v/DmiwpD/D+AxIhDMV0gecPM2fi6VjgCraCSNV7hFyueFYJLFfPaoG32JJ9Ptc0iGVcW
 iOHFLv2hBUip3Qw/ZhgFUkf4wNpwXdSmGLuL9WKM980yh7HAd38RL13aaqAMP8V7A0iE
 Q23Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0MCi9YPjO0BH9Ikbv92ljdt2NAqj/R3GeVfwenVb3fU=;
 fh=N6Sn/5fCLY4oygzoxyFzDxdxMpM3b5tyJ/3/PaiaFtM=;
 b=bMdSjPukQMnXUBsr1LImGylroU1DVPUPNBbzVRpHF+uYeej5yw18miDDZOz2GLUb/2
 NOyugdX0ZM905AiIfnyb/SQjQ+4n4+ivcfBT8mx2giMGd+pk0p4rCPIkbn/2q3wSdgWM
 rzEh2jF2mhMs1qj+chJmp5fG3qCerJgmRK0L1AJTjds33EwkXpYm/9S00H7pTQGkW8j4
 Tg1a8bQCVD1t7AfSK5NgQP9xuEYAfXDQhMZRb43/OJsiabnNeIihaOFfUfuEhZm8KCf0
 j6MVzyf+cPdMjJg3JQ3Zm+nFB4BspzIISx5CFKcsBwB8XIWBsedPri3IxPxxsNKNp2bg
 s8mQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794927536; x=1795532336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0MCi9YPjO0BH9Ikbv92ljdt2NAqj/R3GeVfwenVb3fU=;
 b=NWRQWX6/j25PlSBI0wkr21hukmukGvo6rtBGeAov1lJmilTM1uAsFdNiCeYRRY/PGE
 0FUemTnwxzYD1dtjDlWFLXol0hSZ7UrzLpuA4pf2MKzh5auHxXIutp/O5qJVK3P85wvy
 nora4TVP2I+mGO7lnfZq4v1ZVi4o+J4JzQ+a8kbnEmugamDUE09YjBWKJqC0cKX++YE0
 g0+7vhn89SzRqFrdP7O3X/BGo3Woxow7CMOcFcKuIU1XQ+ZpwzCh1KrlPuwZNDNk4FMj
 6eKhxoZjsx8zaWrECUNpjGVTuOsUfdBUIUz67kc0KghoxFASYRxawoKTMHwNbecgwp7f
 8tCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794927536; x=1795532336;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0MCi9YPjO0BH9Ikbv92ljdt2NAqj/R3GeVfwenVb3fU=;
 b=K83bVV9dK7FrcsIXq1nUPCIff6o1rFt7GARZH21sryKGmuhJO5vayrMiln31vFyL9Z
 XuOO+SFJxnjfNkEq/2kJbY3azpY0Q9p0mZnh5THnjUhybCV/hcBHdHTokZAeAT8TMiLn
 3AitWCWCL/y5lNMMKF44gL81apB1ZwqU8hMaYBKfP8UcI9F7eiSQPFi6xm8F5nr5UIUD
 b6j818EuCDRPwRUgQlKemg/KnHe51b9vCpppmLrGY7aakvhlcnHUrmw9QOxWh1m+QHDA
 bCvQupA7RFgBiCLOmEsT0hnyBjT2DgmfqQADQKPmDt6fLIwXtxsRiAEilDxeVuHSaGc2
 PNxw==
X-Gm-Message-State: APuU4Z/zSFyQvTVZV/ZKKKXhG0GRVmf4Ag4arv75jEukF5G+aHQqhvB8
 nWt/TjoYX46MGXMJH6ms0GqU9BHBQRHKqT+Dap/AmDKPIXhLOU5m5em8F/xqkYsggWNB8iq2o7d
 KctwV0M+CRsq//IsTHHJ59huOdgklYW2N8A==
X-Gm-Gg: AYBFou0Rnjys48R/dWNuk1YAnPVUNhLKqITVBfUrC9kU4kZInM/fXDtHaDlgwrC8F54
 Jmvde/75nmq0TsyQiefHNtL3upvyTzpzarRQlJzqDNEM0YM2RFrRWUm/nGJJQC4cBF/Pv4k+BCT
 bvoOxaJloHiy0+LgisS+RaViu9ytZ4AtNi2QMfAJuJhahkQPhINGxEyfmuNsNjnjFnWYTCjr70B
 uM4xK3lqPaGgbfTFO5elx94/qMpKtRc+VcFLsDxWqCoLRkKuTbW7p6lZrkM33BpJRG/0jLKj/YS
 EdWqfhy8XclyW/WpqCPisx4yxksl1gfCbNlyHXQgO7u16llkO0IG3JNOo4e7ySNpF35JH1U9v0E
 nI68NTie0Mb8Bbn60fCqc+uz2D6/VqckW/+ECEf4xORGk1VMeyWCnd9xyf2NugKkXcUXpFzTP+4
 9fISeDPG1tgYkIPhAtYjIMwfKGaznZRhTXpIHfaKDza7yrgiRyf31541SNfWI=
X-Received: by 2002:a05:6808:2207:b0:4c5:90f1:b9c3 with SMTP id
 5614622812f47-56e61e395b7mr18415851b6e.2.1794927535722; Tue, 17 Nov 2026
 06:58:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261117111310.3042190-1-chongli2@amd.com>
In-Reply-To: <20261117111310.3042190-1-chongli2@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 17 Nov 2026 09:58:43 -0500
X-Gm-Features: AclHuK_rYRoeANyjTLlLNNxfeJDxWiAIaNWQ41hQkYp1NTQgX3lOBT7NTMl1qdg
Message-ID: <CADnq5_MbfN5EN72jTK+d8OducEUnX-LDwq5vVpt2s=YKCKsYGA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: post the ASIC after the reset done at init
 time
To: chong li <chongli2@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 17, 2026 at 6:31=E2=80=AFAM chong li <chongli2@amd.com> wrote:
>
> When the driver is reloaded, amdgpu_device_init() resets the ASIC but
> does not post it again, because BIOS scratch register 7 still reports
> ATOM_S7_ASIC_INIT_COMPLETE after the reset.  psp_sw_init() can then
> read the PSP runtime database before the PSP is ready.  SCPM is
> detected as disabled and the PPTable upload fails with "Failed to
> transfer pptable to SMC!".
>
> how to fix:
> Set has_hw_reset after a successful reset on init, so that
> amdgpu_device_need_post() returns true and amdgpu_device_asic_init()
> is called.  The ASIC init returns only after the PSP is ready, so the
> PSP runtime database is valid when it is read.
>
> Signed-off-by: chong li <chongli2@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index 9fbe1c75897a..b4b149e1ad00 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4105,6 +4105,9 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>                                 amdgpu_reset_method =3D AMD_RESET_METHOD_=
NONE;
>                                 r =3D amdgpu_asic_reset(adev);
>                                 amdgpu_reset_method =3D tmp;
> +                               /* Post again so that the PSP is ready be=
fore it is used */
> +                               if (!r)
> +                                       adev->has_hw_reset =3D true;
>                 }
>
>                 if (r) {
> --
> 2.48.1
>
