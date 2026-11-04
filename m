Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8BD606A31B
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Nov 2026 22:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZsNu2lGb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB84D10E51A;
	Wed,  4 Nov 2026 22:51:23 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B9110E51A
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Nov 2026 22:51:18 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so7846595e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 04 Nov 2026 14:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793832676; x=1794437476; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=mxWxN9JT8ZG4aG+QqOBe9Nns5h6QDLgoudyZv1qwA10=;
 b=ZsNu2lGbuTdn5VYymbu8B9ujh4+JCrttl9EqqOlrNB8qvd2Yq7I5zzeTEpU9VPkPnG
 SqVj/ojMr/ngH2R8eRGgOt2iXBl+tM8rcD0afJ1XlYDn4dl0T/SM1VRaVbe1M1K/zVW1
 hK7H3Iviqf52c43AaISz6pR066L9PuDOGM3holM6Gpm74FuEhKYv1M7HWsZkdhvS1VVq
 xJtM9jGGWxE5uWAX8rI9DlUFHsY9g8iPUMc8+CP+ATZgDNqfyMFchIVp+chAt1AX0nEo
 dQ/xLhLpNXIHcJnSixagzU1Hk8Obp1BG4ZkporbNuDSj4GUmtuupMB3ekdwm4Q7R2Vq3
 UbPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793832676; x=1794437476;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mxWxN9JT8ZG4aG+QqOBe9Nns5h6QDLgoudyZv1qwA10=;
 b=0Dx+JyAe9gND1/QAdPxeWzdH/Ak1Z0giN8NupEjSkrR839t48VuIubikZB+mpsbwoL
 JsFhpHs7fwwh5Hwklmf1fbU+TD0SjXY10TBaY+touUda7i3fcOGm8f6eoo40MLd1O9tX
 u4tdvVMHMlRd6hjFxiWsYrwvuk1q5uUWWVUsd1EPOrEFAbYhO6+E59lAKTSjSVj6EL3z
 7m/PQ0gN74uDsbFW5hyWwLYEF5vk70CoqABf8xl3RJdDxoDVOoqu8a8Gr+qEdgByRQHf
 9CMqRk/BF5HUDlKOjSOu+tvLkUCwfb2CX55aQ17aMpMPFwxx6G2ztWhqrtwYOT8iiFAW
 yk7Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzBjEis++SDUP/CnY3wPxYT3PP8PK8BdTjS4zUJFv0G3G/lZ/DJhzLN4JCufMjbNf8AU5bQrWuO@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+ZuLFYkfrOQweYgpf4AKM78GMZp5UCQDKbE7eH0xtDssjE3QWN
 4xlLPnuFNI/suONqtdrdf4MEL8oLeBidVc+YRQeDPV1TdWLstLUUbSiV
X-Gm-Gg: AYBFou3XDyZbkcjX/WXWw4aD8ShpGhhhTTCDUQvEO2oetNF1LL2zx+MgsvrfKvCPcMw
 LgHac+VIVdw0S6/GosD3FBYUqaAH/zHPGYgXCa++q6vvW+jbFdzgYatnN6QykY1ehp5ynlIlA1w
 6TKOhh7YaVJBLgarSUs76BEMWi+hAM49a9qkG7LanUPh6B2b/kGXhqI+NHnj2CN8/N++tYR96TP
 fQnT2OM7gJUXuLwp4kJ0opAfPSZvHpcwFZngCutjYw29URYvxMDyaJFDIcsnvyQzAgoARgCsYpA
 73EzShKgUOxvPwW2Nmo73cclh7Q3B3vo012m8utD0won5hu1strWAZOcZy5Tpk/DJtMU7inShqX
 fgPimpRBT2qBG1g+joddkPaJ71mpQgZANlQbR/E0PWDt7hU9izhmHQNR0bRNbsdc9jXRSss44bS
 bz/otZL9w031D+kX4fT70GgHMrkW5mXP6n1lVy8xvzcSwcxktIyR4y7AE56+K9GuK1WcM6tRYvZ
 ATopvxM1q3FpH1bQiPazxjrH0As7UAmfdO5zrWPG2HP6udNxlW70HHiGS8iwhEevxC8C+uaWpSS
 4xTrZInVD+d7EcHoN1Y23hB3N2yOR7Uz1Oaitt7M9sdHls5BkdIL0YZ5T+J3bzaZn7d3LT2+PRD
 S73SxyL+c
X-Received: by 2002:a05:600c:3b88:b0:4a1:cf60:dcc3 with SMTP id
 5b1f17b1804b1-4ac187a6ffcmr413751855e9.29.1793832676480; 
 Wed, 04 Nov 2026 14:51:16 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b57373f7f1sm18320905e9.15.2026.11.04.14.51.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:51:15 -0800 (PST)
Message-ID: <b82125a5c8de04ec6d9cd8c906499335f34bc739.camel@gmail.com>
Subject: Re: [PATCH v3 15/15] drm/amdgpu/gfx11: enable the gfx engine soft
 reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"	
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)"	 <Jiongyu.Zhu@amd.com>
Date: Wed, 04 Nov 2026 23:51:13 +0100
In-Reply-To: <DM4PR12MB515293E412AE38BDF5887340E3682@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <20261028085736.3808569-15-Jesse.Zhang@amd.com>
 <06afbec39afd388120e16d63c74080977a017619.camel@gmail.com>
 <DM4PR12MB515293E412AE38BDF5887340E3682@DM4PR12MB5152.namprd12.prod.outlook.com>
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

On Wed, 2026-11-04 at 05:54 +0000, Zhang, Jesse(Jie) wrote:
> AMD General
>=20
> > -----Original Message-----
> > From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> > Sent: Wednesday, November 4, 2026 4:41 AM
> > To: Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; amd-
> > gfx@lists.freedesktop.org
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > Christian
> > <Christian.Koenig@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Mario
> > Sopena-Novales <Mario.Novales@amd.com>; Rastogi, Manu
> > <Manu.Rastogi@amd.com>; Zhu, Jiongyu (Joey) <Jiongyu.Zhu@amd.com>
> > Subject: Re: [PATCH v3 15/15] drm/amdgpu/gfx11: enable the gfx
> > engine soft
> > reset
> >=20
> > On Wed, 2026-10-28 at 16:56 +0800, Jesse Zhang wrote:
> > > Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings,
> > > with
> > > amdgpu_gfx_soft_reset_engine() as the soft_reset_engine()
> > > callback,
> > > when the reset_engine callback can be used: with MES, async gfx
> > > rings
> > > and the
> > > RS64 firmware. The reset restarts PFP and ME from the start of
> > > their
> > > RS64 firmware, and remaps the kernel gfx queue through MES from
> > > its
> > > MQD, which the kernel gfx queue only has with async gfx rings.
> > > Not on
> > > SR-IOV VFs.
> > >=20
> > > The kernel gfx queue and gfx user queue resets then fall back to
> > > a
> > > soft reset of the gfx engine before a full reset. The IP block
> > > soft
> > > reset of
> > > gfx11 only resets the gfx engine then; the whole IP block
> > > soft_reset()
> > > isn't used.
> > >=20
> > > Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> > > ---
> > > =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 16 ++++++++++++++++
> > > =C2=A01 file changed, 16 insertions(+)
> > >=20
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > index a71dae5d0d3a..41ebd2ead99b 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> > > @@ -363,6 +363,7 @@ static void
> > > gfx_v11_0_ring_invalidate_tlbs(struct
> > > amdgpu_ring *ring,
> > > =C2=A0static void gfx_v11_0_set_safe_mode(struct amdgpu_device *adev,
> > > int
> > > xcc_id);
> > > =C2=A0static void gfx_v11_0_unset_safe_mode(struct amdgpu_device
> > > *adev, int
> > > xcc_id);
> > > =C2=A0static void gfx_v11_0_userq_priv_fault_work(struct work_struct
> > > *work);
> > > +static bool gfx_v11_0_engine_reset_supported(struct
> > > amdgpu_device
> > > *adev);
> > > =C2=A0static int gfx_v11_0_reset_engine(struct amdgpu_device *adev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum amd_ip_engine engine);
> > > =C2=A0static bool gfx_v11_0_read_gfx_hqd_ptrs(struct amdgpu_device
> > > *adev,
> > > @@ -1945,6 +1946,10 @@ static int gfx_v11_0_sw_init(struct
> > > amdgpu_ip_block *ip_block)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 br=
eak;
> > > =C2=A0=C2=A0=C2=A0 }
> > >=20
> > > +=C2=A0=C2=A0 if (gfx_v11_0_engine_reset_supported(adev) &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 !adev->debug_disable_ip_block_s=
oft_reset)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adev->g=
fx.gfx_supported_reset |=3D
> > > AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
> > > +
> > > =C2=A0=C2=A0=C2=A0 if (!adev->enable_mes_kiq) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 r =
=3D amdgpu_gfx_kiq_init(adev, GFX11_MEC_HPD_SIZE, 0);
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if=
 (r) {
> > > @@ -6927,6 +6932,16 @@ static void gfx_v11_0_emit_mem_sync(struct
> > > amdgpu_ring *ring)
> > > =C2=A0=C2=A0=C2=A0 amdgpu_ring_write(ring, gcr_cntl); /* GCR_CNTL */
> > > =C2=A0}
> > >=20
> > > +/*
> > > + * The reset restarts PFP/ME through their RS64 start addresses,
> > > and
> > > remaps the
> > > + * kernel gfx queue from its MQD, which needs async rings.
> > > + */
> > > +static bool gfx_v11_0_engine_reset_supported(struct
> > > amdgpu_device
> > > *adev)
> > > +{
> > > +=C2=A0=C2=A0 return !amdgpu_sriov_vf(adev) && adev->enable_mes &&
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 amdgpu_async_=
gfx_ring && adev->gfx.rs64_enable;
> >=20
> > I tried to test this on Strix Halo but it seems it doesn't work,
> > maybe due to
> > rs64_enable?
> Yes. Strix Halo doesn't use rs64, and the reset isn't enabled for
> StrixHalo.
>=20
> >=20
> > Is there any reason to not enable this on GFX11.5 (and GFX11.7)?
> No, will try on these devices.
>=20

Thank you!

I think we definitely need to improve the reset experience on GFX11.5
as well as other GFX11 based APUs. I have seen many failed queue resets
on my Strix Halo GPU.

