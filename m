Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DAAC61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 15:37:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A166110E00A;
	Fri, 28 Aug 2026 15:36:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QVO+D7ya";
	dkim-atps=neutral
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D046810E00A
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 15:36:57 +0000 (UTC)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-5b4ae0b3308so872939e87.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 08:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787931416; x=1788536216; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sKNZUXSOSxjKcYzHM/C7+TKmOt8daT9YQzxo03e/p0U=;
 b=QVO+D7yaLei9/AWVoUdItCwkHIEgjut2xDjBF6s8dxXOtfBxIiNyMVqsxgqoM4dvWr
 QYCVOfztazSnah1p5777Uyuu88mRnkECJ7/hpyZVDtAXkxq+395F8NWIT48HKCRS5Usq
 n3VPAWGuUt0clj2z87R1Zt0eDadwxmvbLVQ7fWN7jQ0NzPDXgJ76JzGVY+75SZ8UnEoH
 AxofkV2M0l24ZOszaigpG6Kc2+yfQqGlXfmduwKnMdU4r6pAI4d0WSA1nnVqcghJVfub
 MlGI6tJ97FVhIA/yZ7rNwDNXNsN6B5no8YFzJTdEun5lAQAV+BkwZ5HXxEei00nZAMd9
 aAdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787931416; x=1788536216;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sKNZUXSOSxjKcYzHM/C7+TKmOt8daT9YQzxo03e/p0U=;
 b=DHd1kIOxlzfyOKS0PfUPI4uHwhvPcwYCbFFCWS0vUQAnfGd56QJODzZVGUrrQ2gQ/O
 D2gDd16bMPCyJ444h/efyHIpAGibYHD+eYHDqUtKfzrLSVj30T+RRFS578ibC0gP8sF8
 L0o4fQQXreFx7hTWwat7VswQpFHN43HZelWFHIwimupKQNUovA8MO1QwbM/WG2CpnifR
 FnC8EgA/MU+EX2qYeSZa+7FB+B2hrOeNok/NMDkW2FeWqtEsbBFlBmJojuv2GB0l/NXG
 awITQkKrpj+Amsmys6gQJYXZvrjc5enzG3FHTdyR6wDMnl+Cz0ufuZIRTE9pBVjA5ulQ
 2oFA==
X-Gm-Message-State: AFuF++n0JXh2+fEGtCRX1n1MVLUXFifzgH6+oyee1kZDUiKEZ8GlpGRq
 TYGh0wUDg+u7zscXnQ9Uh5kawG1rByNmWDOKWc4h8vfC8wbGuwrMUCxUTYlkxw==
X-Gm-Gg: AR+sD13Rv4gB40pvQJ2sw2gHHIvpVAVdkOw/Zm8qAp62T2Fcvq7Ou0SkjuomzRE2zBd
 i4K0YBcGErHfR7SWdT/YehG/IVtm4Z8UYQO4asNE6Cwqe5un0Q5lDq4Lk4X/S0XCpN7RV6G/lIR
 ESbr7oAU246w+uSBZC8k58lyLJlTaeMa9tkij+LZrNemq9BJLsR3UgS+nkll2FTSVk7nLULHCnp
 RLEffhEOdXoM0ieY9GZxNznvN6fkLE72JefqfHl78XQ4dY8JDr+wp5o0OHpS2/gwrJsjzOncwH0
 sM2Ly3KINC4zD7CzrqiUhN6hw4rEkZNNbqq4IYvcoPlTVtAxgyEjurEU6tesHeXWDjuaY91ghzq
 v0/ttIoJYCuNrvqhwXjnmYsuHP57fLndmmzxz7wAQLbxF9+J6z4EmWtg0QHEkxSPJjwXwJox7Sb
 RVLqFezSEzzEuUqse8nd+XQ2zwi2Z6OvOkXa714Uj4FJIlXEpW0PxkCgg+lIzkjBq6rhg0j50pv
 sKUMMPLmUsModEyejbgpuYkWhv0tzBc/ck=
X-Received: by 2002:a05:6512:3d02:b0:5b5:e86f:3550 with SMTP id
 2adb3069b0e04-5b5e86f3641mr1947636e87.9.1787931415349; 
 Fri, 28 Aug 2026 08:36:55 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B9A5E.dsl.pool.telekom.hu.
 [94.27.154.94]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b5e8a0d143sm455024e87.63.2026.08.28.08.36.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 08:36:53 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>,
 Marek =?UTF-8?B?T2zFocOhaw==?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, "Lazar, Lijo" <lijo.lazar@amd.com>
Subject: Re: [PATCH 4/5] drm/amdgpu/sdma: Use common SDMA legacy queue reset
 on SDMA v4.4.2
Date: Fri, 28 Aug 2026 17:36:52 +0200
Message-ID: <INK-tdebRIGg60kuZ_quww@gmail.com>
In-Reply-To: <5158d162-f60c-4ef2-b2a2-cc544e1915f5@amd.com>
References: <20260828120729.25908-1-timur.kristof@gmail.com>
 <20260828120729.25908-5-timur.kristof@gmail.com>
 <5158d162-f60c-4ef2-b2a2-cc544e1915f5@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, August 28, 2026 4:16:15=E2=80=AFPM Central European Summer Time =
Lazar, Lijo=20
wrote:
> On 28-Aug-26 5:37 PM, Timur Krist=C3=B3f wrote:
> > Besides sharing code, this additionally adds support for
> > restoring queue contents after the reset.
> >=20
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > ---
> >=20
> >   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 18 ++----------------
> >   1 file changed, 2 insertions(+), 16 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c index
> > 72ea9db939b4..023821848531 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
> > @@ -1655,20 +1655,6 @@ static bool sdma_v4_4_2_is_queue_selected(struct
> > amdgpu_device *adev, uint32_t i>=20
> >   	return (context_status & SDMA_GFX_CONTEXT_STATUS__SELECTED_MASK)=20
!=3D 0;
> >  =20
> >   }
> >=20
> > -static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
> > -				   unsigned int vmid,
> > -				   struct amdgpu_fence=20
*timedout_fence)
> > -{
> > -	struct amdgpu_device *adev =3D ring->adev;
> > -	u32 id =3D ring->me;
> > -	int r;
> > -
> > -	amdgpu_amdkfd_suspend(adev, true);
> > -	r =3D amdgpu_sdma_reset_engine(adev, id, false);
>=20
> The common one passes true, so this doesn't look right.
>   	amdgpu_sdma_reset_engine(adev, ring->me, true);
>=20
>=20
> Thanks,
> Lijo

Can you please elaborate more on what you are suggesting here?
The caller of the queue reset is amdgpu_job_timedout() and that function=20
already handles kernel queues.


>=20
> > -	amdgpu_amdkfd_resume(adev, true);
> > -	return r;
> > -}
> > -
> >=20
> >   static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
> >   {
> >  =20
> >   	struct amdgpu_device *adev =3D ring->adev;
> >=20
> > @@ -2133,7 +2119,7 @@ static const struct amdgpu_ring_funcs
> > sdma_v4_4_2_ring_funcs =3D {>=20
> >   	.emit_wreg =3D sdma_v4_4_2_ring_emit_wreg,
> >   	.emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
> >   	.emit_reg_write_reg_wait =3D=20
amdgpu_ring_emit_reg_write_reg_wait_helper,
> >=20
> > -	.reset =3D sdma_v4_4_2_reset_queue,
> > +	.reset =3D amdgpu_sdma_reset_queue_legacy,
> >=20
> >   };
> >  =20
> >   static const struct amdgpu_ring_funcs sdma_v4_4_2_page_ring_funcs =3D=
 {
> >=20
> > @@ -2165,7 +2151,7 @@ static const struct amdgpu_ring_funcs
> > sdma_v4_4_2_page_ring_funcs =3D {>=20
> >   	.emit_wreg =3D sdma_v4_4_2_ring_emit_wreg,
> >   	.emit_reg_wait =3D sdma_v4_4_2_ring_emit_reg_wait,
> >   	.emit_reg_write_reg_wait =3D=20
amdgpu_ring_emit_reg_write_reg_wait_helper,
> >=20
> > -	.reset =3D sdma_v4_4_2_reset_queue,
> > +	.reset =3D amdgpu_sdma_reset_queue_legacy,
> >=20
> >   };
> >  =20
> >   static void sdma_v4_4_2_set_ring_funcs(struct amdgpu_device *adev)




