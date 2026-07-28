Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24CACC53209
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Jul 2026 00:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A04E610E307;
	Tue, 28 Jul 2026 00:52:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DgbG3aoz";
	dkim-atps=neutral
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com
 [209.85.167.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D421110E307
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Jul 2026 00:51:58 +0000 (UTC)
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5aeba09900bso2168692e87.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jul 2026 17:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785199917; x=1785804717; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=YyiWxM0l+pV+N+P60T/IcxD0yZfdk4dsxpPoSCJ6HvA=;
 b=DgbG3aozMdLOMX3AFw9LBr/AVv5jJeYu6BnpO89xtgu4C8vlCTGykJk3qzTzEpM4Yb
 QBFVKYnaJA13Lvs7rznSAsWjnDj+eDF/THF8w/xoDrodszNx+heT6U4+Sy1FgZfBIAYz
 dSDbAA2vd5dLcpbdquZfP/xHsf8FbyshSpuASTV4MIYTI1NlbbXQk2Nosh/QKC0tzoMF
 YGD7m6s8czbOYAb9SLwP+cgHF/xdIUdANvLu7iyqxFkF/L1uE0WfrPu/YbLQwC55oIp7
 /mx8M2a6pNQUp7NMhFCHuX2Uzf321Z7oIXtGTyPvEaNhlyx4GYTgLOgSwD+/1CuDOQAb
 dJRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785199917; x=1785804717;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YyiWxM0l+pV+N+P60T/IcxD0yZfdk4dsxpPoSCJ6HvA=;
 b=tDtC3jyO16Yh4yXUW3Epd5O9g5NkvJxg47e8igN8Wzy1ZRJOcgqk3CsqNsv0kBDfKH
 HCG8r9ZGhbSiVs1EP9P/IIZWL2zLaciU3fHozPKJoAtkMmUQ9kVBbFiMQNXqAVDWOwUO
 5yGmacmVkAGOecykDwEi0KAuBUmpFZOe/+ym4T6i5PIVSl6D7vzHJsFX70fda8To9yqT
 pfPlnrYy+XvR2xjpiE43+JFYPDLfh/2Rd3PTZECyS2Zl8BeaEyMkjROtTSnDTw1BKYbM
 MYpzvqvq53q7FrvrUEjik3/Fd5+dnbzZMZqvS9g0wCJSTCkZ7gtew7/g4QvfnThF2DqM
 IulA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrOZZD5v1Lz4/jFfAOFXJe1D3C0a4FfdJkZD5QQNr05UaO19CHiwpi1ywqNuRuPeWlLIrxZaisV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxAIFbQ0Hyjobb6DlShO8MasJqoWG8YESr7r4qCWh/aF2mR4OZg
 RTDdSNC+SfGYfqukDqfBh1ZIHbdWjVLU8mP4hJktDJxVdvbZOBNoKyb1
X-Gm-Gg: AR+sD13epKPXtx1aCjEyK1Nfd5lt+zTtZDRWbqmj77ELni37raCx5wDxYpwX5tJum7U
 sLL9uI2WbJy0qHxoO6AJfNLxcfMJeelW9sZTeM9XzS1evsqonhIj54/dm0Gx/tvHevvZwKNuIMZ
 0WRyO0kA/+uBk+4nvJd30VttnT/dzlKdwWAnQCUr1NLGKpsS8XdezbhvD+7zM7qSVgJUk9P2LbZ
 317hcWIIPnixUFjKou1eR5D5WEo8w+LZC+KK79hAiPvas66gjOK+t9rzKLpKQkeuiFIBbCdz54r
 jYt0uYmpEyhaVciH05vJwKWioZMYLX64tcm3BbrZjwpFp3KSAAIleJJcQEI9sjgsXA/i/O9YTmJ
 UyA9D2DHV/5171wQSHSAd7yWaxf3ljGZTS3nJhufEQS2BGYI2Njc5CR122A06+3zJZaBfc74JRQ
 /6OciHpGgLXY977mC7hlg3
X-Received: by 2002:a05:6512:3407:b0:5b0:197b:9811 with SMTP id
 2adb3069b0e04-5b2d023bef9mr31905e87.53.1785199916589; 
 Mon, 27 Jul 2026 17:51:56 -0700 (PDT)
Received: from primary-ws.local ([188.234.148.119])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2be077c14sm1758822e87.1.2026.07.27.17.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 17:51:55 -0700 (PDT)
Message-ID: <ef1bc3d070c4156f1811c0c4a567ec98ac8fadaf.camel@gmail.com>
Subject: Re: [PATCH] drm/amd/display: fix usage of DC_FPU_{BEGIN,END} with
 PREEMPT_RT
From: "mikhail.v.gavrilov@gmail.com" <mikhail.v.gavrilov@gmail.com>
To: Bert Karwatzki <spasswolf@web.de>, linux-kernel@vger.kernel.org
Cc: linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
 amd-gfx@lists.freedesktop.org, "# = v7 . 1" <stable@vger.kernel.org>, Alex
 Deucher <alexander.deucher@amd.com>, Rafal Ostrowski
 <rafal.ostrowski@amd.com>, Mario Limonciello	 <mario.limonciello@amd.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,  Thomas Gleixner
 <tglx@linutronix.de>
Date: Tue, 28 Jul 2026 05:51:53 +0500
In-Reply-To: <20260727105059.75716-1-spasswolf@web.de>
References: <20260727105059.75716-1-spasswolf@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.61.1 (3.61.1-3.fc45) 
MIME-Version: 1.0
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

On Mon, 2026-07-27 at 12:50 +0200, Bert Karwatzki wrote:
> On PREEMPT_RT kernels kvzalloc_obj() can sleep because spin_lock is
> converted to rt_mutex. dc_create_plane_state() can be called while
> inside an FPU-guarded region, resuling in "scheduling while atomic"
> errors on PREEMPT_RT kernels.
> =C2=A0Fix this by calling kvzalloc_obj() with
> DC_RUN_WITH_PREEMPTION_ENABLED().
> Also fix the error path in dc_create_stream_for_sink().
>=20
> Fixes: 3539437f354b ("drm/amd/display: Move FPU Guards From DML To DC
> - Part 1")
> Link:
> https://lore.kernel.org/lkml/20260723123449.6494-1-spasswolf@web.de/
>=20
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
> =C2=A0drivers/gpu/drm/amd/display/dc/core/dc_stream.c=C2=A0 | 5 +++--
> =C2=A0drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 4 ++--
> =C2=A02 files changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> index dbc12640b01c..4ac835777b58 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
> @@ -233,8 +233,9 @@ struct dc_stream_state
> *dc_create_stream_for_sink(
> =C2=A0
> =C2=A0fail:
> =C2=A0	if (stream) {
> -		kfree(stream->update_scratch);
> -		kfree(stream);
> +		if (stream->update_scratch)
> +			DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream-
> >update_scratch));
> +		DC_RUN_WITH_PREEMPTION_ENABLED(kfree(stream));
> =C2=A0	}
> =C2=A0
> =C2=A0	return NULL;
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> index 88e825a6582c..d5c6427796b6 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -85,8 +85,8 @@ uint8_t=C2=A0 dc_plane_get_pipe_mask(struct dc_state
> *dc_state, const struct dc_plane
> =C2=A0
> *********************************************************************
> *********/
> =C2=A0struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
> =C2=A0{
> -	struct dc_plane_state *plane_state =3D
> kvzalloc_obj(*plane_state,
> -							=C2=A0
> GFP_ATOMIC);
> +	struct dc_plane_state *plane_state;
> +	DC_RUN_WITH_PREEMPTION_ENABLED(plane_state =3D
> kvzalloc_obj(*plane_state, GFP_ATOMIC));
> =C2=A0
> =C2=A0	if (NULL =3D=3D plane_state)
> =C2=A0		return NULL;

Hi Bert,

You may not be aware that the same allocation is already wrapped once,
at the dcn32 call site:

  183182235f6d ("drm/amd/display: Wrap DCN32 phantom-plane allocation
in DC_RUN_WITH_PREEMPTION_ENABLED")

That one only covers the dcn32 DML1 path, while your trace goes through
dcn401_validate_bandwidth() and dml21 - so wrapping the call site could
never have caught your case.  Which is a good argument for guarding the
allocation in the callee, as you do: dc_create_plane_state() is reached
from every DCN and both DML generations.

On dcn32 the two wraps now nest.  That is harmless, because
DC_RUN_WITH_PREEMPTION_ENABLED() is conditional on dc_is_fp_enabled():
once the outer instance has left the FPU region, the inner one expands
to a plain call.  But it does make the dcn32 wrap redundant, and I
think it should be dropped in a follow-up now that the allocation is
guarded in the callee.

One thing that may be worth adjusting in the commit message: this is
not only a PREEMPT_RT problem.  183182235f6d was needed on a plain non-
RT x86 kernel. There DC_FP_START() takes fpregs_lock(), which disables
local softirqs, and dc_plane_state is around 335 KiB, so kvzalloc_obj()
falls through to the vmalloc path and hits BUG_ON(in_interrupt()).  So
on RT any allocation inside the FPU region is illegal, while on non-RT
it is specifically the large ones - two failure modes, one root cause.

About the FPU register question raised by the review bot: as far as I
can see it applies to every existing user of
DC_RUN_WITH_PREEMPTION_ENABLED(), 183182235f6d included, so it looks
like a property of the macro rather than something your patch
introduces.  An answer from AMD on that would be useful either way.

I have dcn32 hardware here (RX 7900 XTX) and can test the patch on
non-RT if that helps.

--=20
Thanks,
Mikhail
