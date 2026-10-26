Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F253A606A31A
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Oct 2026 23:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kMlaLlet
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76D3D10E060;
	Mon, 26 Oct 2026 23:51:13 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3B3A10E060
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 23:51:07 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a5720b0a57so2725585e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Oct 2026 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793058666; x=1793663466; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mJJ88KthELvwKH1YCQio0NHFc68Qi5oemLUdp0JCP88=;
 b=kMlaLletj8NWIOz+GqXG86Np83wpLrLCRFB0mZY6RKtX6bbFbIqHXx6wuR4CahvAYe
 6YK3aU3MNzFYI9c0EH9zkUeApHPPPXrmAZX2nurukj8lRJSfdKyYJvaYxKU6C6vb9WZh
 5q0MZYEtw4JbqiugQ7lZrWzfkymSrKb5fqL4lf7XJoHv4kPTai2EjCcIe+OrSoOZZobN
 TeOdluPLyMknVZ4fPVfD+dpvRoVG2qBoid3T2XjFVhLafoxLiMS6w8ul9kEMXLAdHgy9
 OF47BB0DxN1onhvHhvvxJstUucrZ26t1V2w8b3rcvkfyE9X/c3M5p9iPotftcKO2TvgP
 nj7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793058666; x=1793663466;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mJJ88KthELvwKH1YCQio0NHFc68Qi5oemLUdp0JCP88=;
 b=ty7vu35VGPuwOGqOX2PfudKwVjhmLQp8TONJ2FleR1oKMRX1vciGyHbZLeZJ7X+JHM
 /ACpCwbykLyWj6zjLVUvXcIWIg2yfoFROc5PI/ChmWH43kwPq3YrOqfrg42Tj44v9JHf
 iFBLCjlqWOtFIEoAq8btGq5bPzmr4X7RAZ2iL9otW/BVNuET4hAEqLJDqF5ba8iCDOH0
 nuuMe+aAutejjHvGV1MDg7k0IjxDGVvc/mzKGB6RyjHdbhIyYqHUTtd8t49mjrpdKEhg
 jkt9TqzwqlzpxYpICm8+YMVQZPj9M2QzHZUX6+qwz+EWf7A55O7BGJdky8gJNvXuQXlv
 PEcg==
X-Forwarded-Encrypted: i=1;
 AKwUvByH37ABtyHCuEABY5GKPT2dJ9zvrR2cr/oE/DCiMoB/dGckS7rsrah5amysMCIlTMtWBweC0NFQ@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKsZWsMR/RfPdGRqLFzMA16Tu9RoUflip7CC6O+EncTxNgMUNv7
 o+jOQi8JhbNR/MUoqlCBl7rrJkQLR/uKxY1n4lnZIAJ5VdorIfZIOr3y
X-Gm-Gg: AYBFou0KI1Kq//KWtThToaKS537wm4deR3x0LG2HAYuKJIYDeiL1YKvmHQcKVBCVgjp
 vaU7Sy7mwGpNAWHII8eHcI2TCzpTpRfA3V0Jg7Ct6UJuR7shkiJM7h6HTfEcBfNu5Tq/1ib5vQH
 RDHsYcXBAEpgxk3YtRK9fHHtDgQ6ILLKHfZoDYlg40wMfxpp+HgsvdM5welZEWgGbYuakeeExRT
 zf9ZBRPZneZGwAj7tcQ7lS+DhW1uVXjZWk6bD4APFsWPuGguTpQxaQj8XG84kpfPt+RcOHSD1ea
 Q1LXh+Cq8QbOrosXGnJ1/7bSj6+q42wo9tZs/ZKWrTB8YqsdaD0ZNz316XfpbO8WN1mmYhco1ie
 Ndfgz7RKlJdWWKCBm/sFk7hiRJKb7sX/Fw9JmZUpTDwqotVMYjDxULrvx8CUwKxf7GKC/e2UECi
 LhVJQtRW+pd/sNzOHhD+ElOS7XH4PRS1WmqxLuNw/huedVoVHDSxG8ZVN7JgIFW1W+n7FlpktgR
 8pcUkODy2tOdyddCpOjeci5wZ7/bcxCBCgOWZEvB5eOwx1puaEMOjeeqV9V2mvsW+ir8idWDrwt
 sR/jYZvxo4gyGrs=
X-Received: by 2002:a05:600d:849a:20b0:49e:795e:ba89 with SMTP id
 5b1f17b1804b1-4a7c3856e2fmr18480965e9.6.1793058666105; 
 Mon, 26 Oct 2026 16:51:06 -0700 (PDT)
Received: from [192.168.1.253] (4E5C1F56.dsl.pool.telekom.hu. [78.92.31.86])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebd4bc5sm19197467f8f.34.2026.10.26.16.51.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 16:51:04 -0700 (PDT)
Message-ID: <62012beac646bf55f09efc83c1b402077e90d982.camel@gmail.com>
Subject: Re: [PATCH v2 03/15] drm/amdgpu/gfx11: add a gfx engine reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"	
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)"	 <Jiongyu.Zhu@amd.com>
Date: Tue, 27 Oct 2026 00:51:04 +0100
In-Reply-To: <DM4PR12MB515270DDDF3DA61E1CAF739FE3612@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
 <20261022082011.331462-3-Jesse.Zhang@amd.com>
 <uwzBcRnwS66upuRrx7Ywcw@gmail.com>
 <DM4PR12MB515270DDDF3DA61E1CAF739FE3612@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-10-26 at 08:35 +0000, Zhang, Jesse(Jie) wrote:
> >=20
> > On 2026. okt=C3=B3ber 22., cs=C3=BCt=C3=B6rt=C3=B6k 10:19:43 k=C3=B6z=
=C3=A9p-eur=C3=B3pai t=C3=A9li id=C5=91
> > Jesse Zhang
> > wrote:
> > > Implement the reset_engine callback for the graphics engine of
> > > gfx11,
> > > as for gfx12:
> > > - halt PFP/ME and wait for the memory requests of the CP DMA to
> > > complete;
> > > - with CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and
> > GFX_HQD_REG_RESET set,
> > > =C2=A0 pulse GRBM_SOFT_RESET.SOFT_RESET_CPF/CPG, holding the MES lock=
,
> > > and
> > > =C2=A0 wait for the memory requests again;
> > > - clear CP_VMID_RESET;
> > > - restart PFP/ME from the start of their RS64 firmware and
> > > restore
> > > =C2=A0 CP_PFP_IB_CONTROL; if the CP doesn't go idle then, fail the
> > > reset so
> > > =C2=A0 that a full reset follows;
> > > - remap the kernel gfx queue through MES from its MQD backup and
> > > restart
> > > =C2=A0 it with gfx_v11_0_cp_gfx_start().
> > >=20
> > > MES resets a gfx queue by writing CP_VMID_RESET, which the PFP
> > > handles.
> > > When the PFP hung, eg. on a bad opcode, the request stays pending
> > > across the CPF/CPG reset, and the restarted PFP then waits on it
> > > forever for queues the reset already cleared.
> > >=20
> > > gfx11 has no helper to restart PFP/ME from their start addresses
> > > outside of the firmware load: add one. A later patch enables the
> > > reset
> > > with MES, async gfx rings and the RS64 firmware.
> >=20
> > I don't think it's enough to soft-reset just the CP and expect the
> > GFX queue to
> > continue. There are other parts of the GFX block which can hang,
> > for example a
> > badly written NGG shader can easily hang the PA. I think we need to
> > use the
> > SOFT_RESET_GFX bit as well.
> >=20
> > I noticed that the soft reset implementation needs to also re-
> > initialize the clock
> > and power gating for the GFX block, otherwise the GPU can consume
> > more
> > power after the reset than before on older GPU generations (and
> > some GPUs
> > just fall off the PCIe bus). We need to check how GFX11-12 behaves.
> > I think it
> > would be best to re-initialize the clock and power gating here too.
> >=20
> > Additionally, as I said on the other patch, I think the cleanest
> > would be to reset
> > the entire GFX block instead of just parts of it, for two reasons:
> > (1) gang submit can hang both gfx and compute at the same time, and
> > those
> > hangs can only be resolved by resetting both gfx and compute.
> > (2) if we choose to reset the whole gfx block, that allows us to
> > reuse the code
> > from the suspend() and resume() functions, which means better code
> > reuse
> > and more consistency.
> >=20
> > What do you think?
> >=20
>=20
> Hi Timur,
>=20
> Thanks for the review. I'm glad you find the idea useful.
>=20
> I would keep the gfx-only CP reset as a separate recovery level. Its
> purpose is to recover an isolated gfx CP hang without resetting
> independent compute workloads.
> Replacing it with a whole GFX IP reset would lose that benefit.

I see your point. I'm skeptical because the GFX7-8 soft reset code was
also supposed to do that, but it never actually worked and nobody
noticed it for many years until I fixed it recently.

>=20
> There are several reasons for keeping this distinction:
>=20
> - The hardware supports this narrower scope through
> =C2=A0 CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET and CMP_ONLY_SOFT_RESET.
> =C2=A0 This gives us an intermediate recovery step when a queue or pipe
> reset
> =C2=A0 cannot clear the hang.

We need to test each code path very thoroughly to make sure it can
recover from all possible hangs on both graphics and compute queues.
There should also be a code path that resets all engines at the same
time if needed.

> - A whole GFX IP reset also affects compute resources and requires
> =C2=A0 recovery of the affected MES queue state and all the KFD/ROCm
> queues.

The soft reset code already handles that for kernel queues.
It just needs to be extended to also consider user queues.

> =C2=A0 The gfx-only CP reset preserves that state and the pending compute
> work, although MES
> =C2=A0 suspend/resume can temporarily pause scheduling. We have successfu=
l
> =C2=A0 HIP and compute test runs across these resets, demonstrating the
> value
> =C2=A0 of preserving independent compute workloads.

Nice! That's impressive.

>=20
> - The locking doesn't fit either: amdgpu_device_ip_soft_reset() takes
> =C2=A0 the reset domain for write. [...]

We can change that.

> It is also reached from the user queue
> reset path, not only from a kernel ring timeout.

I was planning to extend the soft reset code to be reachable when user
queues hang the GPU. Just haven't done it yet as currently user queues
don't yet work well on any supported GPU.

> - gfx12 has no soft_reset callback, and the gfx11 one isn't enabled
> as
> =C2=A0 a recovery step. A whole GFX reset for these generations needs new
> =C2=A0 work and validation in any case.

If we really want to have the capability to reset graphics and compute
separately, then I think the right way to go about it is to make soft
reset more fine-grained instead of introducing another reset type.
I think that would simplify the code and benefit both implementations.

In my opinion, we should do the following:

1. amdgpu_device_ip_soft_reset() needs to be extended to handle user
queues. It should be able to save and recover non-guilty user queues
(it already does that for kernel queues), and it should be reachable
when user queues hang.

2. We should add an IP block function called soft_reset_engine() and
move your engine reset implementation there. The argument should be a
bit mask, each bit representing an engine so that the function should
be able to reset multiple engines at once if needed (when all bits are
set, it should reset all engines at the same time, ie. equivalent to a
full IP block reset).

3. amdgpu_device_ip_soft_reset() should call soft_reset_engine() if it
exists.

I'm happy to help with the code if you want. Can you share what is your
test case and how to reproduce it?

Best regards,
Timur
