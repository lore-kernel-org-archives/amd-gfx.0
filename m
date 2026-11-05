Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ABD606A32D
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 08:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QJwBEbK1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8743010E067;
	Thu,  5 Nov 2026 08:54:41 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F81510E067
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 08:54:35 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a4dc547987so8625575e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 05 Nov 2026 00:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793868873; x=1794473673; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RL7e77v9mAIgCy+ZiQj1hxRyRrXrej7pZfEkNWOWOV0=;
 b=QJwBEbK140kcqkaVsPaGRAlKKlVonAOhCHvQJEzHYCGzKYiHHulfRYsfJxhl7CQiJz
 LafxKMFLr/t+bsVm9uVxPPQJG6HrG06fBkv6nR1z2fCCgDIj9FegFzQzILonp78+pZyK
 wbhEKjTAgBcMlpPC39d2wBnlFL/EFs7+yWPveupmVY205xOyKnzelEmIB0o0lYvuRlty
 aDNxFaUMvt9EmGLnSQQstKGU2flQ/XIllP9p2DNpWwEPdCr8drZ3KlPhMpfD1ZI2aMxD
 JDZnrfJ2WpNKKYIuxgvvLX5yB3UBAbIpntvPYDPZUd7Zwig1LOefRsCw3hYZLNbE5KKB
 Y1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793868873; x=1794473673;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RL7e77v9mAIgCy+ZiQj1hxRyRrXrej7pZfEkNWOWOV0=;
 b=P+aRaAef2llnRk2DcA7Q9MWrZR9JxhOEIFfqwNBzyQnXJ1H7J344Pht3tkHqrwP9dI
 W6wE2pMhkC7uwlK3z6k0iiIxcUX7GZshDIQsV3vsMR9P2r0pzULteN7CvP+34mmmhYda
 niEDkRxyoBxgdVE8C21I6qa27KmEPYKf4joQl3PCp4coneXkJnfzCD9CvK6eSYFIvNLB
 OKZoPuBT5pBqiPTACSoqNONNIzNQKU9rux02dLHBDjCwDqHgIHF3qo/vhbcToSoUQXOD
 wSoqLKWIHCZ7k+Gg1uJQxD0X+nDZRaDNIVqYMQKfaLFE/HMUQdL+kGcHTi5MBYi0KM5I
 wWVA==
X-Forwarded-Encrypted: i=1;
 AKwUvByjawZ4BKNNCJqVPTc5y2Ms2V/CZgETQhZrJFI8xobqZUPWlv+VmkJcrAaYrbBZeLZOkp56TA+v@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/6NlaLEuyHFYDzmEZAOBUGUhMDmEj6i2sicAGCVOH8+QhQ0O6L
 3Upj+H/Zgd7u9kuwkfqYdebuyiWhRQKlo7LsQlJs/8NvZt/oMTZ180Hb
X-Gm-Gg: AYBFou2gMovTXqTp+f7/5AVEQHyfgFKNrCI+XGqoBFEctZwhB9MjAKmAoi3IR1UcPL/
 9SaIC788amTF8WZ3ZIlvFZoVZ8XlVkcXbeazzh0SsM6Ge98Uh7lpUImB+56qMePGn02QF5wRKLF
 Dl0HQ0tYA4HZ4P7oa33izv708cM0ngrRxpc/OhNwMdZaJyjPrUokX5vZFkrx3RP2gJbHWeRcXuA
 CsfX2R7qTRCvXZXz7yDM64bG4ZDfIuwRA1ygpxioQTFFHr+M1VMa2s7QMAdjddGHMHTbPCIe+65
 te50Xgyovt2x9vZLDUZnbNcWzTPKWtDlQmmFhfdbmIh76KQzvnOruCDcXrvsKHOUQq/0GwxWBLi
 7e/qyg3xRW7cZU0WVyw0bjA/lcFnbzO8PG39g1erj+9BiNeDP1j93ESqWEloQ4Pw94KmRSdCTeI
 TXnyg+b4nO2yem1vBl3N3q/8kU4Ruai50zxUp2CEmRyZPdvrMlPmODTd8BLVGlTpIwG07lsdvYX
 YICR/PLkFmh/Rg33i8SQuq//EwTnGhUZk//brXthdqgAF9NiarzJdICKSrgjaXwAwtAPAt1pt3j
 Dtll0A+KQskQm4G2fa4iM/wYx7jL2aC+5GEWpkGxn7Up2K+HLI3Ij9E7vg+bhbslwmKAI1VZsQF
 MtqEHKA/U
X-Received: by 2002:a05:6000:29cf:b0:48d:faa4:5b66 with SMTP id
 ffacd0b85a97d-48e6e500917mr28780005f8f.36.1793868873365; 
 Thu, 05 Nov 2026 00:54:33 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48feea5d4e4sm8447140f8f.57.2026.11.05.00.54.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 00:54:32 -0800 (PST)
Message-ID: <d313dc4855779e4337d60a2642e81da0c102a3c8.camel@gmail.com>
Subject: Re: [PATCH v3 02/15] drm/amdgpu: complete the guilty fence at the
 end of a multi ring reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"	
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)"	 <Jiongyu.Zhu@amd.com>
Date: Thu, 05 Nov 2026 09:54:31 +0100
In-Reply-To: <DM4PR12MB5152D797B071B435A47CC599E3772@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-2-Jesse.Zhang@amd.com>
 <d744c7dedfc32ba6f1a66731eb9aa196f46af941.camel@gmail.com>
 <BL1PR12MB51441296195645049FBB4763E3682@BL1PR12MB5144.namprd12.prod.outlook.com>
 <837f5db76982c9d84f45bc5ecd04e0bd9de16a4d.camel@gmail.com>
 <DM4PR12MB5152D797B071B435A47CC599E3772@DM4PR12MB5152.namprd12.prod.outlook.com>
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 2026-11-05 at 02:09 +0000, Zhang, Jesse(Jie) wrote:
> AMD General
>=20
> > -----Original Message-----
> > From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Sent: Thursday, November 5, 2026 6:47 AM
> > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > Christian
> > <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Mario
> > Sopena-Novales <Mario.Novales@amd.com>; Rastogi, Manu
> > <Manu.Rastogi@amd.com>; Zhu, Jiongyu (Joey) <Jiongyu.Zhu@amd.com>
> > Subject: Re: [PATCH v3 02/15] drm/amdgpu: complete the guilty fence
> > at the
> > end of a multi ring reset
> >=20
> > On Wed, 2026-11-04 at 02:46 +0000, Zhang, Jesse(Jie) wrote:
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =
=3D amdgpu_ring_reset_helper_end(ring, ring =3D=3D
> > > > > guilty_ring ?
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 guilty_fence :
> > > > > ring->guilty_fence);
> > > >=20
> > > > Can you help me understand what was wrong with the line before?
> > > > I think guilty_fence =3D=3D ring->guilty_fence when ring =3D=3D
> > > > guilty_ring
> > > > no?
> > >=20
> > > Usually yes, but not when the soft reset follows a failed ring
> > > reset
> > > of the same job.
> > > =C2=A0amdgpu_ring_reset(ring, vmid, job->hw_fence)
> > > =C2=A0=C2=A0 -> amdgpu_ring_reset_helper_begin(ring, F)
> > > =C2=A0=C2=A0 -> amdgpu_ring_backup_unprocessed_commands(ring, F)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sets ring->guilty_fence =3D F.
> > >=20
> > > So by the time the end helper runs, ring->guilty_fence no longer
> > > equals the guilty fence: the begin helper cleared it.
> >=20
> > I think I see the problem.
> >=20
> > I re-read the queue reset code and the helpers. During a queue
> > reset, it makes
> > a backup and saves the guilty fence but if the queue reset fails,
> > it doesn't
> > restore the contents, and on a subsequent call it clears the guilty
> > fence and the
> > backed up contents.
> >=20
> > Unfortunately I think this commit doesn't completely fix that
> > because the reset
> > begin helper will still clear the backed up contents on the second
> > call (sets
> > ring_backup_entries_to_copy =3D 0).
> >=20
> > I think the correct fix would be to make sure we don't repeat the
> > ring reset
> > begin helper:
> > https://gitlab.freedesktop.org/Venemo/linux/-
> > /commit/86f2bf222caee0da267f9d9e12362513fe4f7f9e
> > Please take a look and if you agree feel free to take that patch in
> > your series.
> Right, the second backup also drops the commands of the other jobs on
> the
> guilty ring, and skipping the begin helper is the better fix. With
> it,
> ring->guilty_fence also stays the guilty fence, so 02/15 isn't needed
> anymore.
>=20
> I think the condition in your patch is inverted though:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (guilty_fence && ring->guil=
ty_fence =3D=3D guilty_fence)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amdgpu_ring_reset_helper_begin(ring,
> ring_guilty_fence);
>=20
> calls the begin helper only for a ring that was already backed up
> with
> this guilty fence. The other rings, and the guilty ring of a soft
> reset
> without a failed ring reset before it, aren't backed up anymore. The
> latter would even replay a stale backup. The guilty ring after a
> failed
> ring reset is the one ring that still goes through the begin helper.
> I
> think you meant:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* A failed ring reset of the =
same job already backed it up.
> */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ring !=3D guilty_ring || r=
ing->guilty_fence !=3D
> guilty_fence)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 amdgpu_ring_reset_helper_begin(ring,
> ring_guilty_fence);
>=20
> If that's what you meant, I'll take your patch with that change in
> place
> of 02 in v4.
>=20

Yes, thank you for the correction.


