Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB4B4F53D81
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Mar 2026 18:00:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 81BC610E31B;
	Mon, 16 Mar 2026 18:00:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Lwk82HEl";
	dkim-atps=neutral
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9A7C10E31B
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 18:00:19 +0000 (UTC)
Received: by mail-dl1-f47.google.com with SMTP id
 a92af1059eb24-128edc72f3eso328599c88.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Mar 2026 11:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684019; cv=none;
 d=google.com; s=arc-20240605;
 b=lzFKIO831XKpJDbMQfQxy2nO4lXq/S/AnxqbOLbJHOKhAW9knmu7ggF2Q5ZOCklwGm
 IdSL7jXRGCaGxc2E/UAUoon5iPhTFgzn8MQNghv7nB7Vnfgs92+xJ7DqHMtzBjQrzOXd
 cyao+UuVhzRhIrBKoejN+6Gp1Df6l/zP4ihJib9bXXjgsDqL3vUplxRo4aDepq7KztuW
 53SVgVo6XE5KOXIWfcLN8lufnCRKliDvlwCWAt3VgpKRRTx/wipn49pfwwbh/HKk5fjz
 BdBvLemccenwd7OEwoAHhjwwcXcCdI+XY4hQv7k4Iz/n4iV6a+iQP4+xJaXg50TWIHR+
 opig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=wCVh+jLGucUAZIEJyr6KX5h/Eoq3XOf5/lyGBjm164c=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=SfAaE5kWF9DFowet4M7tkJEqHnhSfj7CtVrZbuR+xNu0SS1BWJvgvvYOGX6KvPnpD6
 2ia34GOOUJ1cHd7ioHEEs/Jb5ZJaCM7XNPj4UHakBWRPbkW1Ymx1lXu8fcmHr59uYku1
 1npVab6DIF38bIaBnW4MZ8rUmpRkdm56t3Tqmf3OHartuaQU4hsqYTG21a8d8+kPwghe
 eepbVOw2+1+Q8hIdjfgFxrBXTJg4JX/gl16Ndrdg35VGQg6zCpkGDTkdT3DLo9HbAwyZ
 S8aBRGm2OQlqrhWQVIaPgogSA51ksC7RkHO6FCZs9Rnx5S6nyOTIVbU5rRdz0/OfKT/e
 yeeQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773684019; x=1774288819; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wCVh+jLGucUAZIEJyr6KX5h/Eoq3XOf5/lyGBjm164c=;
 b=Lwk82HEliPKP5O2l6EYEpanzgrN656x59KikgE43/UD1xcWLkDHpdyVXxW97/9CzBQ
 dSmLBmcK4vJmreo5JiSLcIcRqDIlDXH+HgWUKrvGYqTznX46xoDG/r7QHuPZYITlJ2i0
 EaRE6osVRLvEdpOCDCAFxFjuTsPI5nAwUCdMH+cAfD6J01UhWgUNqjvslt8MWvNdG8IB
 ZWRKQFzNXls1hplqh3fB9QO/+S9yQ1R59dZNnldipFeE2jdlQFnrrPhLpePL7JH2Tb+c
 mpqEaLLaZwF1caDN2rSP8psxrZ4u78IR3diBNgrU4WP0vXqKrB64AVYDbCsHTmvLwXTA
 WQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773684019; x=1774288819;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wCVh+jLGucUAZIEJyr6KX5h/Eoq3XOf5/lyGBjm164c=;
 b=YfIJvLPZKg2unIT8uXZqdvnElylxbiwHwV1MiKI/+cqLb6kdxK74oOrnULKmfrL1n6
 IHiHJNkvYdr9oGjmsKPPoYtbY0Jx+de4fgdIQVZ7eSDLp4i2UqIh09dToQ3owmcx0ZUk
 mFXJ2TLibmzkZ3iuhH/6Wq1BeHIBJHkskDdwrO84q1BUJrtbSrsQ41CNxThfCZurVCfP
 POb8ZhCIgmsgLOSwFSoyTjh2s1iSa/9I8KIVaD09sEJiff6816+2nbG651OVEuLg1B1t
 ORep/F9TBkvRX/ZNjL37IPCkbmjmtD9TBLuMFGkITWJYegtx3sEeW6AiYZVBqpymPboo
 D1ew==
X-Gm-Message-State: AOJu0YxAvXpMoaHF/N5u3FlfvCZDZ8j4uDPxfPChu7NGD10E9ByGyYxh
 DebdNc6O9asGLpSVMZR03Z7iiR0KXs+HNGeD1F3jut5bDKWG7d5qi5MdlxCEb/ir6UEB+oj1Z7C
 TADolyAS8POgJwrgH7K4ix/rkG8HQyiByQw==
X-Gm-Gg: ATEYQzyBllFQniRZHu5jJWRt7EnTEC37XO8IJN83X8UjGlgpVNssQ6wvjUJw95R2a1c
 0SWHdkOinepvbIQdnuDG1oS/+Y7mVEWZkHaDiso8H6DHKz60ZuuPAbK37VFqGDGN/vInGVmJ84s
 Ryr1xaOIp/SOz3w3NGclnhkA0+pmgN4dx4A0Vu6XdNSlCQ753EOEFlpNdapajW+ONdnHtqlZE2i
 B2o+WuBEVT9Azp4NwJgc+qlME6nTMKN1n/QtE+WvghD6EuF7GLcWDEE6pOXHoczC52zsEjgBpCb
 yFTFosttNdxFYkpJfyxcTZ4QABIZ4dKecabWxlQys7t1YndDhlqDV+YrgN5iStJ3NzXTig==
X-Received: by 2002:a05:7023:a88:b0:119:e56b:46ba with SMTP id
 a92af1059eb24-128f3e1775emr2752846c88.4.1773684019026; Mon, 16 Mar 2026
 11:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260218193416.1474441-1-alexander.deucher@amd.com>
In-Reply-To: <20260218193416.1474441-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Mar 2026 14:00:06 -0400
X-Gm-Features: AaiRm51pLsICtwxZhU-fgM2FkkTMfElIiEmi6W8v3u7KRYgNODZWXOhCr8Ck4SM
Message-ID: <CADnq5_PDBLFCSMof88JUP9KpGweUNQCcKX9nskDGXPtn=fe_Gw@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amdgpu/gfx7: align mqd settings with KFD
To: Alex Deucher <alexander.deucher@amd.com>
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

Ping on this series.

Alex

On Wed, Feb 18, 2026 at 2:34=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Make sure to set the quantum bits in the compute MQD
> for better fairness across queues of the same priority.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/=
amdgpu/gfx_v7_0.c
> index 2b691452775bc..65b8497ad5f02 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -2819,6 +2819,7 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device =
*adev,
>  {
>         u64 hqd_gpu_addr;
>         u64 wb_gpu_addr;
> +       u32 tmp;
>
>         /* init the mqd struct */
>         memset(mqd, 0, sizeof(struct cik_mqd));
> @@ -2923,7 +2924,11 @@ static void gfx_v7_0_mqd_init(struct amdgpu_device=
 *adev,
>         mqd->cp_hqd_atomic1_preop_lo =3D RREG32(mmCP_HQD_ATOMIC1_PREOP_LO=
);
>         mqd->cp_hqd_atomic1_preop_hi =3D RREG32(mmCP_HQD_ATOMIC1_PREOP_HI=
);
>         mqd->cp_hqd_pq_rptr =3D RREG32(mmCP_HQD_PQ_RPTR);
> -       mqd->cp_hqd_quantum =3D RREG32(mmCP_HQD_QUANTUM);
> +       tmp =3D RREG32(mmCP_HQD_QUANTUM);
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_EN, 1);
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_SCALE, 1);
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_QUANTUM, QUANTUM_DURATION, 10);
> +       mqd->cp_hqd_quantum =3D tmp;
>         mqd->cp_hqd_pipe_priority =3D RREG32(mmCP_HQD_PIPE_PRIORITY);
>         mqd->cp_hqd_queue_priority =3D RREG32(mmCP_HQD_QUEUE_PRIORITY);
>         mqd->cp_hqd_iq_rptr =3D RREG32(mmCP_HQD_IQ_RPTR);
> --
> 2.53.0
>
