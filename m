Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01159606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 22:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ynasXluX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F97C10E27D;
	Wed,  4 Nov 2026 22:49:22 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87C4310E27D
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 22:49:15 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a35d5d4a20so13514735e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 14:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793832554; x=1794437354; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=c39sstVWDvOONifS3J1/5es+j9wNzsk7tcXkPe6uo6U=;
 b=ynasXluXLI7GekMhAISSIAmjEJcVxdqEg5UpQPG1id05XmlwtT8C0NN0GtBUaZBA/Z
 glnE3nrQcjmj209u6bVQyp+4mbTXKAsTcyh4LP3Z7Mo9jC27Xvl4Tn1bZGlRqpyqVEcx
 xlu0fGB1WNQp6CvBK5aMaJrTU5ConuHUJr8tYUQ1E5bl8RLyiQbiBW8fCZv9z3YhPwBk
 XtQASl/PlNH1LYCEHzXK0OjW3toFlsp7BnMjQJmjYeLKB1QT6bV4zNVOgbQ5inlrZZY9
 kQCMenU78LEbewQbyOvw1Llu35PvvdhvFHkidBrZSWgJ8HPDlU4LHbaHy5WqqKgGM+wY
 6R3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832554; x=1794437354;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c39sstVWDvOONifS3J1/5es+j9wNzsk7tcXkPe6uo6U=;
 b=KxROb3cQdj7X+zQKZL6naMyQVBjdxqovlt5oeiYxle7kX/ql3pMH9yNyUiIvw3l0qR
 psukaL/RiHpr/W4G+3qwvJQhtXNfeaNFnIECZVcBK0anlJq3CFYktUAHIcI5OQM/FsYr
 92Cxialcygvdxk/nYL2iVhK4dLaoxBW7WmG+ysG7MKgpSgadjOD1Qi763aNJtekidYZn
 lWY9+cweSc5YoeWom6Q1dCLecsoDi30df3kk0Ja68HjaG4iVnjQUhl6JmmIdeXXPj1C2
 UnulZC3KoHbjNxyJStUEhdJHm+B7TqruVg8+eQ3vBwRIludlWzOQHFKV/ks/wzLplpKJ
 XdWg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwXgkrdtiBKdkoleo0dOe83PdH6aIPNOq7+2oxviHIidOuO/1IVCAY67hyMJpKfgdfE7gc1BoyB@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9bA3bs31zZO5vSwu8+w0YaBEBsVuHPafvWfN7gG3LtFmKba8U3
 Rr0gYMQ8nhVSmSFPQFR8JRS1DPsZDq+SYKxaH2aWbRwvthapZhW2Sy86
X-Gm-Gg: AYBFou1ahpYjYa3AYByc3VOEo2bgxHz61W3MDVr2IZ/kv28q8X2M3/bhYzTJmTcnNKo
 iShZquqD+aocn4kQgyTCewOg7w508NrtcenLLlu794Li+ng4Nlm3pLJxlzozqakityiT0RqDq2W
 9vP8r44r5hKpqVXUA5ikLRRxySzOCXed2ATiTc2j/zgMfKO7X5V2C7O6ru/7nVUKtP7aJ9waJUD
 GFI/jTaxHuxBDoMlGDUL+f1X9AHl2W6ltydZyEkYxKf+8dT7ZRh0D45HpXlHbNhemupnvRnzv+N
 gsw7djXaAid7skWTWNq5x4zCD1C8au893U8LW+I3PnK5ftDVzckPyGzIFCW0MLNC3hiwb0PrTU1
 /ay188PLDr3JEjmn95mnSwFyDlqmitXceOxqKaBv+q5oHmEqi82FmDCROS9a6kBLU/6Zj/ChlPx
 80Fw3qi+LwB7ry6X79S5vpuVCTDv7jadWJqIFLf7B/r9Pxaka0VZQBYikCV2TsjXh1lKF4j9Yr1
 85tjTxQS+MUM0dzk9pvOVai5rB2kyQKVFDlS9TkTVnG/Y6Zj7Lspwd9OHg4BtwP0WxKmfqBX71G
 2/Us3DCB45gWL5zUxpFfGxZ/QG0DMegb8kqkaoppZIUdU7rFouTeJ1RhKMve9k7+S2ys+BN2s+J
 auvB9a6jomOiLn6UH8Ol7SejbKNaHAw==
X-Received: by 2002:a05:600c:34d6:b0:4a2:1364:252a with SMTP id
 5b1f17b1804b1-4ac150b2192mr397045885e9.3.1793832553636; 
 Wed, 04 Nov 2026 14:49:13 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b56fca22e1sm20497255e9.14.2026.11.04.14.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:49:13 -0800 (PST)
Message-ID: <577fce74b1cceb88b34c9e1b45049ad5bb2bfb33.camel@gmail.com>
Subject: Re: [PATCH v3 03/15] drm/amdgpu: add an engine scope to the IP
 block soft reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"	
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)"	 <Jiongyu.Zhu@amd.com>
Date: Wed, 04 Nov 2026 23:49:12 +0100
In-Reply-To: <DM4PR12MB5152718433FC9012B8C69D02E3682@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-3-Jesse.Zhang@amd.com>
 <7010c51113110bce484a2d232bbd90c0b40d250d.camel@gmail.com>
 <DM4PR12MB5152718433FC9012B8C69D02E3682@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-04 at 03:32 +0000, Zhang, Jesse(Jie) wrote:
> AMD General
>=20
> > -----Original Message-----
> > From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Sent: Wednesday, November 4, 2026 4:16 AM
> > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > Christian
> > <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Mario
> > Sopena-Novales <Mario.Novales@amd.com>; Rastogi, Manu
> > <Manu.Rastogi@amd.com>; Zhu, Jiongyu (Joey) <Jiongyu.Zhu@amd.com>
> > Subject: Re: [PATCH v3 03/15] drm/amdgpu: add an engine scope to
> > the IP
> > block soft reset
> >=20
> > On Wed, 2026-10-28 at 16:56 +0800, Jesse Zhang wrote:
> > > Some IP blocks have engines that the hardware can reset on their
> > > own,
> > > eg. the graphics and compute engines of the GFX IP
> > > (CP_SOFT_RESET_CNTL.GFX_ONLY_SOFT_RESET / CMP_ONLY_SOFT_RESET).
> > > Resetting
> > > only the engine of a hung ring leaves the work on the other
> > > engines
> > > alone, which the IP block soft reset can't do, as it resets every
> > > ring
> > > of the IP block.
> > >=20
> > > Add an optional soft_reset_engine() IP block callback, which
> > > resets
> > > one engine of the IP block, or all of them, and recovers the user
> > > queues on it, and amdgpu_device_ip_soft_reset_engine() around it.
> > > It
> > > only stops, backs up and replays the rings of that engine, and it
> > > is
> > > also reachable without a guilty kernel ring, for a hung user
> > > queue.
> > >=20
> > > For a single engine, it only takes the reset domain for read: KFD
> > > only
> > > try-locks it for read before it adds or removes queues, and would
> > > fail
> > > those calls with the write lock although the other engines aren't
> > > reset.
> > >=20
> > > amdgpu_device_ip_soft_reset() uses it when the IP block
> > > implements it,
> > > for the engine of the guilty ring.
> > >=20
> > > v3: replaces the separate engine reset type and helper
> > > =C2=A0=C2=A0=C2=A0 (Timur).
> > >=20
> > > Suggested-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c=C2=A0=C2=A0 | 116
> > > +++++++++++++++++++++++
> > > =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ip.h=C2=A0=C2=A0 |=C2=A0=C2=
=A0 6 ++
> > > =C2=A0drivers/gpu/drm/amd/include/amd_shared.h |=C2=A0 18 ++++
> > > =C2=A03 files changed, 140 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> > > index 2eea18965fd1..e95f69dd3142 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
> > > @@ -418,6 +418,111 @@ static u32 amdgpu_ring_mask_from_ip(const
> > enum
> > > amd_ip_block_type ip_type)
> > > =C2=A0=C2=A0=C2=A0 }
> > > =C2=A0}
> > >=20
> > > +/**
> > > + * amdgpu_ring_mask_from_engine() - Find mask of ring types of
> > > an
> > > engine.
> > > + *
> > > + * @ip_type: The IP block type of the engine.
> > > + * @engine: The engine whose rings you are looking for.
> > > + */
> > > +static u32 amdgpu_ring_mask_from_engine(const enum
> > amd_ip_block_type
> > > ip_type,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const enum =
amd_ip_engine
> > > engine)
> > > +{
> > > +=C2=A0=C2=A0 switch (engine) {
> > > +=C2=A0=C2=A0 case AMD_IP_ENGINE_GFX:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
BIT(AMDGPU_RING_TYPE_GFX);
> > > +
> > > +=C2=A0=C2=A0 case AMD_IP_ENGINE_COMPUTE:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
BIT(AMDGPU_RING_TYPE_COMPUTE);
> > > +
> > > +=C2=A0=C2=A0 default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
amdgpu_ring_mask_from_ip(ip_type);
> > > +=C2=A0=C2=A0 }
> > > +}
> > > +
> > > +/**
> > > + * amdgpu_engine_from_ring() - Find the engine of a ring type.
> > > + *
> > > + * @ring_type: The ring type whose engine you are looking for.
> > > + */
> > > +static enum amd_ip_engine amdgpu_engine_from_ring(const enum
> > > amdgpu_ring_type ring_type)
> > > +{
> > > +=C2=A0=C2=A0 switch (ring_type) {
> > > +=C2=A0=C2=A0 case AMDGPU_RING_TYPE_GFX:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
AMD_IP_ENGINE_GFX;
> > > +
> > > +=C2=A0=C2=A0 case AMDGPU_RING_TYPE_COMPUTE:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
AMD_IP_ENGINE_COMPUTE;
> > > +
> > > +=C2=A0=C2=A0 default:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return =
AMD_IP_ENGINE_ALL;
> > > +=C2=A0=C2=A0 }
> > > +}
> > > +
> > > +static const char *const amdgpu_ip_engine_names[] =3D {
> > > +=C2=A0=C2=A0 [AMD_IP_ENGINE_ALL] =3D "all",
> > > +=C2=A0=C2=A0 [AMD_IP_ENGINE_GFX] =3D "gfx",
> > > +=C2=A0=C2=A0 [AMD_IP_ENGINE_COMPUTE] =3D "compute", };
> >=20
> > No need to add a new enum.
> > This is redundant with amdgpu_ring_type.
> Agreed. In v4 the callback takes the ring type of the hung queue.

Sounds good, thanks!

> >=20
> >=20
> > > +
> > > +/**
> > > + * amdgpu_device_ip_soft_reset_engine() - Soft reset one engine
> > > of
> > > an IP block.
> > > + *
> > > + * @adev: amdgpu device
> > > + * @ip_type: The IP block type.
> > > + * @engine: The engine to reset, or AMD_IP_ENGINE_ALL for the
> > > whole
> > > IP block.
> > > + * @guilty_ring: The ring which is guilty of causing a reset, or
> > > NULL.
> > > + * @guilty_fence: The fence which didn't signal on @guilty_ring.
> > > + * @guilty_queue: The user queue which is guilty of causing a
> > > reset,
> > > or NULL.
> > > + */
> > > +int amdgpu_device_ip_soft_reset_engine(struct amdgpu_device
> > > *adev,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_block=
_type
> > > ip_type,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_engin=
e engine,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_rin=
g
> > > *guilty_ring,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_fen=
ce
> > > *guilty_fence,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct amdgpu_use=
rmode_queue
> > > *guilty_queue)
> >=20
> > Please don't add a separate function.
> > This duplicates a lot of code that shouldn't be duplicated.
> >=20
> > Instead, I suggest to just add the new functionality to
> > amdgpu_device_ip_soft_reset(), for example like this:
> >=20
> > if (ip_block->version->funcs->soft_reset_engine)
> > =C2=A0 ip_block->version->funcs->soft_reset_engine(...);
> > else if (ip_block->version->funcs->soft_reset)
> > =C2=A0 ip_block->version->funcs->soft_reset(...);
>=20
> OK, I'll fold it into amdgpu_device_ip_soft_reset(). The separate
> entry
> point was only there for the user queue caller (patch 13): a hung gfx
> user queue has no kernel ring, and amdgpu_device_ip_soft_reset() gets
> the
> device and the IP block from guilty_ring. So the signature would
> become:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int amdgpu_device_ip_soft_rese=
t(struct amdgpu_device *adev,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 enum amdgpu_ring_type
> ring_type,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct amdgpu_ring
> *guilty_ring,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct amdgpu_fence
> *guilty_fence,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 struct amdgpu_usermode_queue
> *guilty_queue);
>=20
> amdgpu_job_timedout() passes (ring->adev, ring->funcs->type, ring,
> job->hw_fence, NULL), and the user queue reset passes (adev,
> AMDGPU_RING_TYPE_GFX, NULL, NULL, queue). The body stays the same as
> today. When the IP block has soft_reset_engine, it uses that
> callback,
> only the rings of that type, and the reset domain for read:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (funcs->soft_reset_engine) =
{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ring_type_mask =3D BIT(ring_type);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 down_read(&adev->reset_domain->sem);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (!guilty_ring || !funcs->soft_reset)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -=
EOPNOTSUPP;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ring_type_mask =3D amdgpu_ring_mask_from_ip(ip_type);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amdgpu_device_lock_reset_domain(adev->reset_domain);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_multi_ring_reset_helper=
_begin(adev, ring_type_mask,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guilty_ring,
> guilty_fence);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (funcs->soft_reset_engine)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 r =3D funcs->soft_reset_engine(ip_block, ring_type,
> guilty_queue);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 r =3D funcs->soft_reset(ip_block);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =3D amdgpu_multi_ring_reset_=
helper_end(adev, ring_type_mask,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guilty_ring,
> guilty_fence, r);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (funcs->soft_reset_engine)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 up_read(&adev->reset_domain->sem);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amdgpu_device_unlock_reset_domain(adev-
> >reset_domain);
>=20
> Does the change work for you?

Yes, that sounds good to me.
I just have one question about it:

> the user queue reset passes (adev,
> AMDGPU_RING_TYPE_GFX, NULL, NULL, queue)

Wouldn't the user queue reset still need to pass the guilty fence from
the user queue? Or is that not possible?

Thanks,
Timur
