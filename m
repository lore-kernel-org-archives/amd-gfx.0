Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99F7D3B7EA
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Dec 2025 14:05:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8250710E1D5;
	Tue,  9 Dec 2025 14:05:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g8hsIp2B";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0286F10E1D5
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Dec 2025 14:05:22 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-7a9fb70f7a9so411128b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 09 Dec 2025 06:05:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1765289122; x=1765893922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qv/U5KbIfc1u65L2zaNEqu6Eu0xSxL8vlMwo3k3YlnQ=;
 b=g8hsIp2BMTBzFvR+WB5kg9C3RCcbTPdkxVYihuuDJ+KRhXvaqWEUQDKKGhqtjaFY83
 FzSR+27ydYPlp89rZ+C6mT/3JC5516EIu/hlHNIJ/9IMz7AZoma++2F3MXmKvNeET0qb
 vLE+RPdByuaMLj3nKWXfa1EE+YeisJlvn2Z6QsouxXYoY0Q+nAnMu1P2KRpxgnZd0wpu
 fz+Kv1tdYBsdRLEP7+WQX3cx1ltP/hCDs4MBUhd8D8vao6//TnbTRUDXrz1UWobsgp4t
 2rx4N3rABqbnzFq/Fz2OXCZKDaniD1mpLmjMEj6eudkb29VheSSIvnl1/axD3jlIigrj
 FIVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765289122; x=1765893922;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qv/U5KbIfc1u65L2zaNEqu6Eu0xSxL8vlMwo3k3YlnQ=;
 b=paNspq7Bborqb87UahzcP977G/2Y7PmRrYyGRU2lJkb1+zakA6CnLw6sAwiz9L+jcg
 QCZI+w5WbWTBpjBXnO5C+NCF27Ed7F7U60ziEjSwR12ECr35TMoSfbJS04FUzn0dxEua
 V4kcUY7+fizN5/9NYYkZLEt+HGNYQ8+XX9qIiT01Aavf6QDyX6Wmyvmf1FLlGAzdrxPA
 ILPZTudAEpoN6Vubgjhx76/ItFRCu+92gFnQZuE0XzCef7qPGYKrkjw65V5jZ9ZtSvy0
 z1SNJCWz+i5C/k20d9B3kw60LkLOoA/zsWgC54T7KV8Sj7KGWMTG34FOXQYuBX1YdnGt
 /V/Q==
X-Gm-Message-State: AOJu0Yy7IKUFVhJ/4ig0PIQWZP7dEbG0QjFmEDt25Od+7APL5QIZZ0SE
 T0iSp/EqVYGkG2w4ulcfmg3yddGqzCIlT8gPJ71B78BtEdR02SU0gRH0mNs/5IMyzexGXs+2XaJ
 Rwp5dGXPEtzT8ZR7IQwugXxIPi/W/P7dTZw==
X-Gm-Gg: ASbGncv87gicUcEglxe+zEJJx0fj11pEOH5+YKQ1vu1SGFhbyJJcFCoGsW+umOiESlL
 SdBaEeZb6Ky1VLUBR+8I+4IbVQTty6YEL3PfJk0sv/WGlCMvmiC2w/wD3QMj86F5axQNQBbXvOT
 nrc5ETF2tEy0s7GWejcsCEKwkCXSHb4k3wPQhwv9BOFjKVedUUVJLYjrXkw2UdTxk4gt0NGy45z
 P9opuA98pveeFRfluaPggkk52ikD8j6hkrCGEHEvEOgiPPPVDZt193mHc4gVzQLuGpzdHGe7vJl
 kHjQZg==
X-Google-Smtp-Source: AGHT+IFVuLApCmh0u1v7m5LC+GTaz+6jssLJ7nUpAYlYZrtpozw76ONNqSrjUVoZFuJQb+wTCzJS3pv4eV/XUSoc1/I=
X-Received: by 2002:a05:7022:6891:b0:11d:faef:21c2 with SMTP id
 a92af1059eb24-11f22ac2938mr1217166c88.2.1765289122026; Tue, 09 Dec 2025
 06:05:22 -0800 (PST)
MIME-Version: 1.0
References: <20251209044646.345580-1-superm1@kernel.org>
In-Reply-To: <20251209044646.345580-1-superm1@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 9 Dec 2025 09:05:10 -0500
X-Gm-Features: AQt7F2rvjZwmg_KorLsgrQIg4ePjp0BRBEKU1lUypkcQF5uSMH99tSjJmIgKpPk
Message-ID: <CADnq5_M-pQMRATT0TCJv9LsX0Kxay7K8vN=bh=4SQ91yQyeQSA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Fix unbind/rebind for VCN 4.0.5
To: "Mario Limonciello (AMD)" <superm1@kernel.org>
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

On Mon, Dec 8, 2025 at 11:54=E2=80=AFPM Mario Limonciello (AMD)
<superm1@kernel.org> wrote:
>
> Unbinding amdgpu has no problems, but binding it again leads to an
> error of sysfs file already existing.  This is because it wasn't
> actually cleaned up on unbind.  Add the missing cleanup step.
>
> Fixes: 547aad32edac1 ("drm/amdgpu: add VCN4 ip block support")
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/am=
d/amdgpu/vcn_v4_0_5.c
> index b107ee80e4728..1f6a22983c0dd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
> @@ -265,6 +265,8 @@ static int vcn_v4_0_5_sw_fini(struct amdgpu_ip_block =
*ip_block)
>         if (amdgpu_sriov_vf(adev))
>                 amdgpu_virt_free_mm_table(adev);
>
> +       amdgpu_vcn_sysfs_reset_mask_fini(adev);
> +
>         for (i =3D 0; i < adev->vcn.num_vcn_inst; i++) {
>                 r =3D amdgpu_vcn_suspend(adev, i);
>                 if (r)
> --
> 2.43.0
>
