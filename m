Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A674E9D402
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Feb 2026 15:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049DE10E6B3;
	Wed,  4 Feb 2026 15:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aXI9MyMt";
	dkim-atps=neutral
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8EB210E6D1
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Feb 2026 15:54:36 +0000 (UTC)
Received: by mail-dl1-f53.google.com with SMTP id
 a92af1059eb24-1233e05c77bso463c88.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Feb 2026 07:54:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770220476; cv=none;
 d=google.com; s=arc-20240605;
 b=LsRvdLmqpec2Vr679r9lvc5SQfgCqMGSiZBcrqZ2Sej0ambCkyjV7kPU7+xVo1ZGht
 /7T8LAj6E3CBxGsFTVfKT+QjJ5m2mX9BBNIgpXGWY3PdevUgh9aFMJA1/REMKwOG5XUT
 defZHUMQnoXzM789UZAUkECqA8SFe3nt+bblWcT+HjiiN3oZ7U0f+xC+GDaFmLo4ySlv
 hEm81JsB6u0rfw++6bdLjGTXB+GwXiRnN7zc+HwB2aLakRulKVwUEEXM7vh/X9lRikDq
 uUrYgONf/RXZ5w2t6dJpBf7N4+19AyCZyjDffVNCB2KqfmXfJcn+LqpxCccVDd+Kyg2V
 /ehg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7wZRKD3Zjs9SwU7VnIZmrURx9dhpk54rTDBjUvnk1A0=;
 fh=tXuiJ5MwZ1BL+bjqCEZO/8OA7cP1UmV+EApVUdakX00=;
 b=MWnrjsTlbPJ7d65hh/XoIPCGN5ucvqMKLc9S/LvSW/RQt552wPU2Y8BrBS33oTrPlY
 rKUXfph0vbjCzf22iAve2MpgozHqbk1jBtHdHZoTF6p4CgbW/cYCrCk+JwCuueLrqxUn
 zgwZKJbenIpAzxuxjmS0lUrIMs+Z1hOaorbWMuCBg/+RARDKlgs32LginDXb0rtDMJIG
 +e2ptpqsxZoxPKFfdfvULw8KynNJM7NN22ABufsP8Hiz2URDP+pOUeUS+zLmLLnBacuW
 MZ0npTEPdPT0f8zqqLF26qRLHG41AKejsu4xp3IjV4YrMq54TBB/nzxdpZp27OYL663p
 dzdw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770220476; x=1770825276; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7wZRKD3Zjs9SwU7VnIZmrURx9dhpk54rTDBjUvnk1A0=;
 b=aXI9MyMtXlVwmpwz7GmYEctQZkd6L2+IrMHJext45sAGebpFFYslDmtnZQouOueaHk
 g6Y4rYfToEFqXeKGFeCTOQbfhjvl8Jz88ojm7k6bHJ3paEn70WkRdJr8zCd0O6Lo5sNO
 qMJVhYyO/Blk9+gjmaH4pj4X46O4SjHo75NXXvca2a46GYLe2ZP7JMtl7EOmQ6UwIgA4
 yVR7RpFleuprNNalY3Sd0MaF1gOQWviR2pVmHLOswHaAOfp82XsMbPvYpDHYdRDh5xMw
 wQywGHvTri0EgS/9D1gtd0+yClGRP0Sbq/h9hgwAY1K6X4/c+UrdTAH91ki6Bd1d+i7C
 MQ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770220476; x=1770825276;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7wZRKD3Zjs9SwU7VnIZmrURx9dhpk54rTDBjUvnk1A0=;
 b=JJBclVmkX/Jv+xXaxT32vNac5occbo39vEYuomfOs9KX8OsQs7EE36LYkq3blyLU1O
 bTshjVBlBtSuT48/Tv1BHT3+TsEQu4x55NCtZIydYu6fIYYALF7mhURzp4RvfKv2DOxE
 khPLmY1GAGxwA2gH9ezEiniyczW/kv8eNzDG6QKL17t4mOSobSu4+IbDSya9uMSjWot9
 X7q1wO0Lr3kmMtD3EwE9R4pmFd0g9D9E5SXVsQw4uxBCoM/PwhW5HX0pb16VqwsneNvY
 HwEISPDSP/O6iZt3yXdzxxn8H6QfVkwJleHqX+iPzIkMnBYk1ctX7Ejc+ovG8/gapBMW
 8uMQ==
X-Gm-Message-State: AOJu0Yzao1twLkVe8wqUd9dFHqVciQiaV94o/cE3lUVEgAY5vRbP3b1P
 G/SVfC6TEQTZKTLp9XcmDTIKijffOOcHe5NdWixBnle40ukd0F32QD4BU5riyGLNErue5KaDRyu
 MEnvizGR/aSwtGUPfXqqsRagHmA0D+BLkzqhi
X-Gm-Gg: AZuq6aI7R9ZuNDFxdECmmRJtg98PhG4YLab44BYCBGPkPmtYlozC7V8wCsUvMmX9ydQ
 D2W5L4mKRyrTvnNMKSOnRt4AHKcMrRISJelkZhZxcfR/CFHubESWw0lNQb9MN2nP4VyhiWPSiYi
 ZfsI9esl4U7yx0+Wkyh3r9Q+AV3cO4UBIzhuQf4VYlT3TeWAp0z/0xdjTnLXfccjWjYUZDxXB8L
 /FpIoBdzAhi5ImysRie7L+hBqA0pxgWIKmcE1DnDzY2t63h0pujLON72QYoOJnuly2t0uVgwuqe
 2rHH+tw=
X-Received: by 2002:a05:7300:2310:b0:2b7:f25b:91fb with SMTP id
 5a478bee46e88-2b83296efbcmr787181eec.5.1770220475776; Wed, 04 Feb 2026
 07:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20260204153828.753680-1-Victor.Zhao@amd.com>
In-Reply-To: <20260204153828.753680-1-Victor.Zhao@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 4 Feb 2026 10:54:24 -0500
X-Gm-Features: AZwV_Qi4oREw_2SjuFwQn9UQUB4Mu1EnO0ukvF3NU7pMsmXebc550ItKRLDRnVc
Message-ID: <CADnq5_MMGUtbCvLavwAbOAhE5TEpnwJaGoxDnE1tqzWYb87Puw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: avoid sdma ring reset in sriov
To: Victor Zhao <Victor.Zhao@amd.com>
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

On Wed, Feb 4, 2026 at 10:47=E2=80=AFAM Victor Zhao <Victor.Zhao@amd.com> w=
rote:
>
> sdma ring reset is not supported in SRIOV. kfd driver does not check
> reset mask, and could queue sdma ring reset during unmap_queues_cpsch.
>
> Avoid the ring reset for sriov.
>
> Signed-off-by: Victor Zhao <Victor.Zhao@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_sdma.c
> index 8b8a04138711..321310ba2c08 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -558,6 +558,9 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *ad=
ev, uint32_t instance_id,
>         struct amdgpu_ring *gfx_ring =3D &sdma_instance->ring;
>         struct amdgpu_ring *page_ring =3D &sdma_instance->page;
>
> +       if (amdgpu_sriov_vf(adev))
> +               return -EOPNOTSUPP;

How about !amdgpu_ring_is_reset_type_supported(ring,
AMDGPU_RESET_TYPE_PER_QUEUE) instead in case this ever gets enabled on
SR-IOV?  Either way:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> +
>         mutex_lock(&sdma_instance->engine_reset_mutex);
>
>         if (!caller_handles_kernel_queues) {
> --
> 2.25.1
>
