Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B56EC54FD4
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 21:24:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B33910E2A8;
	Wed, 29 Jul 2026 21:24:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JJvquUi7";
	dkim-atps=neutral
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62D2410E2A8
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 21:24:08 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c160420289bso201897366b.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785360247; x=1785965047; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=sf3H+4s5e61yMb1ZbckowAcmT9DvP4lBN4F8AKsli7M=;
 b=JJvquUi7OURxaSSh5pUJ2psaAM1AMn6cfE/6xT/nPNumX3ywPMlMAi5nYl8hmP1Ni+
 FFLHci6zVfPmyezbauQ0H0xLjS/8YruRvAPJNd8EP9hFFZzBUZ4A1VxvAsIUctIyBTky
 AfzrPKgYorS5srcuF9XvTM62Ah4+a4dNMmg9msw1F64sQB/dnQaBvAA5JcXbzXtxbnWX
 6WMpPF/jJcp/q6Cd/sbGYHNfam5GTXjw1uQHXtqrCmWDDtFx1+iWsrPCVvV+z2ArqMkh
 +hztRtd2U8CJdmx7ftUNbUQyVScNzoVOYcb9KG0JMyq+0ijdK3PWzULcGpO+sObwAW03
 LGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785360247; x=1785965047;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sf3H+4s5e61yMb1ZbckowAcmT9DvP4lBN4F8AKsli7M=;
 b=rQ8NAZb6E14YSoHhJ1Dt92ruNbpyQ6dVOXkyPjK/2302cTuOgV+id7vr8ubL5dwTVz
 RvocyVZ8EIJAhA16OsjsDDTPOaYHPx9dGVeDSjFDMS0MOehUnkLuOrnKBvEco/EBD/2w
 iQtsMRrmi/rG27uqqUxvr/8fn//3ercKbL55dWmMs22U0OmVXXBPqsxyejrk1Jedig2Z
 BtwGTZ749tjbKXOz3G/1v7v3KLnup9HJizzG/GQRro6/pCoLwVe9NwvFGeFJ8shlmPSh
 I/1e614lH0s5r+qNi7tRlvDhPbBdVr34uvSepGpHgkIU1rYpKGUiYJA3Fih6pJH26elV
 sBZg==
X-Gm-Message-State: AOJu0YyuSWj18Waq6Sy9Xb8DLkwsUdV2skPRzi+Jz8qPy3m7eF7PGPOY
 KNUDmBw1QsU5m3ewQmxtqclQ33VYvQGAwUPJtdH83AKDRPvzPewNMyPpR+1BTw==
X-Gm-Gg: AR+sD11yKUiLfCZ8iB4I1qxwzfEqj+UfgWfROwhAMQX3LKv5bv3EXJkHcz2m5TrF7i8
 Ce/NHBnZ4BhmcardU+U4iGPh9ePp1uTpA9jEL0s7g3NhUZ7rbKWQlIos6c77l+Fjj+ysoVN0BU+
 EURH/aNcop0S5CrEXIB5pLQjaWPG6Nv0DkT4mk2PhZmS6+8SfbvI+mvbLe9M3YDplGVXSJzKpv1
 /o1QiOB3PDGwbv2IAgJw7cKpGJUdNDufA20jP6daFcXz9uTFdRdXGLPwlbZyKoSTJrjZD1XMrfp
 KDzRH5AkKW47mP5FVIyVHvepTpLHBwJMCjfzf9IhzDbwgkXbGIrqS5kiF27OI/dQ0Bg8Ibd0KMz
 TH7g6Ap+Q0o22UG1J+x64NsQEv4XNgiulBu/sjdu0ppeRheBZpq51iY9nfighpyfJduAECMkrWu
 yn1xbSbZyahdzPHT1bilbEUmEi7lctxXttHFV+ZsGpQUjL8VAjdXWg5CWP/FgvmNiJLrCGJPsj8
 LXlmzIpnYdZu7Mv2pkywD4hebSEuiItjDQKpmnZc4CRhhjNpEm8Wbq/reJx3SQZe9c=
X-Received: by 2002:a17:907:3cd4:b0:c1f:9800:1811 with SMTP id
 a640c23a62f3a-c1fa57b4ab6mr5304666b.63.1785360246368; 
 Wed, 29 Jul 2026 14:24:06 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CEAA0068208F73129E1A79.dsl.pool.telekom.hu.
 [2001:4c4e:24ce:aa00:6820:8f73:129e:1a79])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1f83fb11c8sm155589666b.52.2026.07.29.14.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 14:24:04 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Miles Margetts <milesmargetts@live.com>
Subject: Re: RX 7900 XTX (GFX11/Navi31): "Illegal opcode in command stream"
 gfx ring timeout, worked around by amdgpu.user_queue=0
Date: Wed, 29 Jul 2026 23:24:02 +0200
Message-ID: <W-Y1ZJ98T7SE9aJ4q2i6Gg@gmail.com>
In-Reply-To: <PH8PR20MB519310C4CA59E83241D0C6CED2E72@PH8PR20MB5193.namprd20.prod.outlook.com>
References: <PH8PR20MB519310C4CA59E83241D0C6CED2E72@PH8PR20MB5193.namprd20.prod.outlook.com>
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

On 2026. j=C3=BAnius 14., vas=C3=A1rnap 16:11:11 k=C3=B6z=C3=A9p-eur=C3=B3p=
ai ny=C3=A1ri id=C5=91 Miles Margetts=20
wrote:
> Hello,
>=20
> I'd like to report a reproducible GFX11 GPU hang on an RX 7900 XTX,
> along with a workaround that seems to point at the user-mode queue path.
> I'm not submitting a patch, just flagging it in case it's useful and
> asking whether a devcoredump would help narrow it down.
>=20
> System:
> - GPU: AMD Radeon RX 7900 XTX, Sapphire NITRO+ (board 11322-01-40G),
> Navi 31 / GFX11 (PCI 1002:744c)
> - Secondary: Raphael iGPU (1002:164e), not used for display
> - CPU: AMD Ryzen 7 7800X3D
> - Kernel: 7.0.11 (CachyOS, Arch-based)
> - Mesa / RADV: 26.1.2 (vulkan-radeon)
> - Session: KDE Plasma 6 on Wayland. The failing client is Xwayland: the
> affected app is the native Linux build of Baldur's Gate 3, which runs as
> an X11 client under Xwayland.
> - GPU tuning via LACT: Overdrive enabled, core clock capped at 2600 MHz,
> voltage offset -20mV, framerate capped at 71. NOTE: these were unchanged
> across both the crashing and non-crashing states, so they are not the
> variable (details below).
>=20
> Symptom:
> Intermittent full GPU hang during gameplay. The gfx ring times out
> immediately after an "Illegal opcode in command stream", the ring and
> MES resets fail, and a MODE1 reset recovers the GPU but loses VRAM and
> wedges the display, requiring a reboot. Representative dmesg:
>=20
> amdgpu 0000:03:00.0: [drm] AMDGPU device coredump file has been created
> amdgpu 0000:03:00.0: ring gfx_0.0.0 timeout, signaled seq=3D38937911,
> emitted seq=3D38937913
> amdgpu 0000:03:00.0: Process Xwayland pid 1063 thread Xwayland:cs0 pid 10=
71
> amdgpu 0000:03:00.0: Starting gfx_0.0.0 ring reset
> [drm:gfx_v11_0_bad_op_irq [amdgpu]] *ERROR* Illegal opcode in command str=
eam
> amdgpu 0000:03:00.0: MES failed to respond to msg=3DRESET
> amdgpu 0000:03:00.0: failed to reset legacy queue
> amdgpu 0000:03:00.0: reset via MES failed and try pipe reset -110
> amdgpu 0000:03:00.0: The CPFW hasn't support pipe reset yet.
> amdgpu 0000:03:00.0: Ring gfx_0.0.0 reset failed
> amdgpu 0000:03:00.0: GPU reset begin!. Source: 1
> amdgpu 0000:03:00.0: MODE1 reset
> amdgpu 0000:03:00.0: GPU reset succeeded, trying to resume
> amdgpu 0000:03:00.0: VRAM is lost due to GPU reset!
> amdgpu 0000:03:00.0: GPU reset(1) succeeded!
> amdgpu 0000:03:00.0: [drm] device wedged, but recovered through reset
>=20
> Reproduction:
> - Occurs only in Baldur's Gate 3 (native Linux build) when playing
> multiplayer as the CLIENT.

Can you please write how to reproduce this?

> - Stable in single-player and as the multiplayer HOST, with identical
> settings in the same session.
> - Onset varies from a few minutes to longer stretches of client play.
>=20
> Things tried:
> - RADV_DEBUG=3Dnongg: no effect, so it does not appear to be NGG-related.

You cannot disable NGG on the 7900 XTX because it only has the NGG pipeline=
=20
and no longer has the legacy geometry pipeline. So RADV_DEBUG=3Dnongg doesn=
't do=20
anything on this GPU.

> - The undervolt/clock settings are not the trigger: the system is stable
> as host and in single-player with the exact same tuning, and -20mV is a
> mild offset.

Overclock / undervolt related instability is usually non-deterministic, so =
I=20
would feel more confident in this finding if you could reproduce it with=20
overdrive disable and putting the GPU in "profile_standard" mode.

> Workaround that appears to resolve it:
> - Booting with amdgpu.user_queue=3D0 (disabling GFX11 user-mode queues).
> Since applying it, client sessions that previously hard-froze have been
> stable.

RADV does not support user queues yet, so this is not doing anything for th=
e=20
game. Are you running anything else on your system that may be using user=20
queues?

>=20
> This seems to point at the GFX11 user-queue path (queue evict/restore /
> MES queue handling) rather than RADV shader codegen, but I have not
> root-caused why the malformed packet is emitted.

As far as I know the "Illegal opcode in command stream" refers to packets i=
n=20
the command stream and not shader instructions. So this doesn't have anythi=
ng=20
to do with shader code gen.

> I can provide a GPU devcoredump from a future occurrence (I have a
> capture hook in place to copy it out before the ~5 minute expiry) if
> that would be helpful, and I'm happy to test patches or gather
> additional data.

I recommend you to open an issue here:
https://gitlab.freedesktop.org/drm/amd/-/work_items
Please give me a link to the issue you've created and let's continue the=20
conversation there.

Thanks & best regards,
Timur



