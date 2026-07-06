Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CD9C43458
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2026 15:00:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D82610E74F;
	Mon,  6 Jul 2026 15:00:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cIy3lGcC";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5005710E74F
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2026 15:00:47 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2cad68425a7so3768095ad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Jul 2026 08:00:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783350047; cv=none;
 d=google.com; s=arc-20260327;
 b=DOgDAzp4sMN1FiRHmLxRIjkLAMwVQnBHfqnO6aNDxRvZ8TuiQK+lANJ0ffnmAY67na
 2XPq6nT+SvTLOz4zLAmeWcmbfAbml/GmcqQKPYOH2At2aUoCdes4OySEN/j4+QdTansL
 fMnKsiDPnedA7CnF6Wkd4/gWEXQrpQE9Rpiriyl8vwMuiygRng+uoPXDuDoeJv87ghl+
 Sd9WS8cY2qLUpcDszuqq6o0bt/Si0te/33XodxQEYUj87b8rJZ7F+bAN0bvJH1x7oaqn
 5kK6Tir42HikNHzOHzSvnKc2xXjDshMXY4hGy8HPveG4f1at8VoyiicpM/nWW7YxFxFT
 a4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xyjIyRxCi3D9346v6yARH/SrhIylYPBEL2eTBsmL/GM=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=QrmRQI4WO8CDtNK6rCe/mA+R4gd8oF1sL9tf3IKYN+uw4AHhZpIQzkWBJvLWjtA8l7
 JrCg8PFBlexdLoWFnX8sEnKilL/oHlNnTZ+UhrO741uWc2fGKVTzWoiXbE2CC5jfeC0U
 hwRxWniOsAzdaAD4Gl6me3ofpgm2yxcZMSArsxgPGEP462u9SswXggN7pTwbwuR/255b
 ++fGSBPXagFi1Sl5lFIiCf471qOBEQfGycmbNiGDX4TnYaMR7s+/7Sd8SzNuSNA1uiwz
 nFOgTCM7PiVY61Aa/v5xcR11ZUu7CVoFgFNh5abKusewLx99qgkQe/G3UneSKH5FtsTz
 hyFA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783350047; x=1783954847; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xyjIyRxCi3D9346v6yARH/SrhIylYPBEL2eTBsmL/GM=;
 b=cIy3lGcCVcZx8uLed8tJTjIqwugdhDDo1JYUecskHcetN/gq8FNapuU/9YfRRQIqHQ
 forfHkueRgCGtEhGH5x7COWzYBgRTKrYh4+L1tRG+r91PZUO3HUxZn9XvuY64G3mR5ou
 siqoaqUJQLXHP7HyRuCbsmXPpkwEucUvPaAZVQgLflpmHHrNTAgrWKkUBAIEXhugzzL2
 2ZVaMwWMrVm0onP6UL+6/8N+HPULypr7bTzQjkuoAKWuIzshbsUfdaDlDQveAtmLKuNN
 fiPIepqlo5YX9y/q+YWQ7WVxcsuvLSDGye71FuntC64HaGGVyS26BgL85F8/fwvprBkB
 OU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783350047; x=1783954847;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xyjIyRxCi3D9346v6yARH/SrhIylYPBEL2eTBsmL/GM=;
 b=ab75J6ULU3V/wZbGdYLy7l9EzIq+ssJ7BIk9fwF7d9XX6+922mBINajrblafkvZP6B
 ox/Rkea9CIroRSLg1AW2cU4W0thg9ziiX4p9EqNTA10BoFtIPuvbDbKxc/hUn9evVQkJ
 ZM1NXGJNni/p95I6Nb7J3jXdhy+CljnR6IkH96xURaWtVrHnA2z2nAD+8Eg+RhqJcPkq
 lB4Z39lU5erRoLJmsF09MwYks1lPsU28ePjflXOI95OcxnLhf9emhgRSynjU4Zfcyxas
 15fFAlkKNGkRLn6iNAkXol40ZI6npXUuYr+6o/d9p40ajTblrXt+2ZQ4WvNfo+Jc8csT
 jKEg==
X-Gm-Message-State: AOJu0YwtZaFrVW+joKCWW4miu4HCAsp2649mEk0TvodX0Lt1APD6Aakd
 CC/F0OxLj7T4we5u2YzQXeC6NdT0jnNr/RtoFlQm+fKHYXLAOf/m3EID05S09muIOGCUSLkZB0m
 D9jMtAcu2VH/KmfyyS9GBA7lLPCZzoRQ=
X-Gm-Gg: AfdE7cmKHtPZQXzE9uR2dG2HT3vdkyE7RuPslTN5g282JTTrh6y2FCtVYXB2CERmnD2
 X56Fo92RBQSrsrFNjRPFGgSuGpipg7Q0sbljIRydanXJDCfuDcs8KjRn5xUQBzwmCodlRTFz5vF
 ONqXOqzNDkuFCSSmdzrMsb1m5jx8B+A5/OwE+SDpwvFJRBsQE2tUvvJDYG/5Hj+W657arlfnKCh
 sjqkWK5cL2SyZPCTyyWWYJhgFThXzRVV/uJOTJHib6yFb9Ap1XqrU9Eki9ahdoNthrUnx4+Fcys
 NYdJSZXYUmHTJPWZC9vhPkfKfxfIVpqdIxaU/aPWyMAnkMVpdgTaXwHgI8o=
X-Received: by 2002:a17:902:e550:b0:2ca:d803:5c8f with SMTP id
 d9443c01a7336-2cbb0eeed8bmr66452525ad.1.1783350046443; Mon, 06 Jul 2026
 08:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260626204101.31172-1-alexander.deucher@amd.com>
In-Reply-To: <20260626204101.31172-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Jul 2026 11:00:34 -0400
X-Gm-Features: AVVi8CeJkZfEAJrfcZRjSQzKIAHzcaE7eDPUaCppQjz62uvkbqn8Jpd_qEzcF3s
Message-ID: <CADnq5_O2zx_fpnvXGOPkzYwiY3K5SU1xQGyyAci846o5dra12Q@mail.gmail.com>
Subject: Re: [PATCH 1/4] drm/gfx10: Program DB_RING_CONTROL
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

Ping on this series?

On Fri, Jun 26, 2026 at 4:49=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> This is needed to allocate occlusion counters across
> both gfx pipes.
>
> Fixes: b7a1a0ef12b8 ("drm/amd/amdgpu: add pipe1 hardware support")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v10_0.c
> index d72ecf5dab09e..6ff7a8a700939 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -5352,6 +5352,9 @@ static void gfx_v10_0_constants_init(struct amdgpu_=
device *adev)
>         gfx_v10_0_get_tcc_info(adev);
>         adev->gfx.config.pa_sc_tile_steering_override =3D
>                 gfx_v10_0_init_pa_sc_tile_steering_override(adev);
> +       /* program DB_RING_CONTROL for multiple GFX pipes */
> +       WREG32_FIELD15(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
> +                      (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);
>
>         /* XXX SH_MEM regs */
>         /* where to put LDS, scratch, GPUVM in FSA64 space */
> --
> 2.54.0
>
