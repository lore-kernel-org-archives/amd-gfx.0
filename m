Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F706EE6B68
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 22:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D560B10E94D;
	Fri,  6 Feb 2026 22:49:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ax4LfYcc";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CED9410E94D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 22:49:27 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso26418095e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Feb 2026 14:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770418166; x=1771022966; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoKHa0gARH78YAqXVzszHdDLaQazlRgVEKZ3masrvGE=;
 b=ax4LfYcc88fxw+U0dugTSEHMGn4JYukFGs7Zguo4Ye3koF5DPCMGFZP/CU+ZPMuM/v
 NbnCizpMtoXw0QgiH6uQldQ0xyWycBS08jhufwghYyLNL/NJTtBYWHcx92q+9daSIVIK
 gCyn8NiTxu/IzDPUMdO+Y6r3BirCNjF9okp+aECGZDgNS9LsKPmOmGSNXAvk0LUEK6sL
 oal6V2x+M1E2p405PStwEqyfozH9D0k9YrwRwVbdFSv0NGX0XnUOc2LrKQUkFtc+FDbl
 tPafNcxhP2pUncIPPKKjucJmpiuX4YlLxUaLe6Z3as/IE99ggoTqG0FZonaXW6hCbp5L
 VaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770418166; x=1771022966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yoKHa0gARH78YAqXVzszHdDLaQazlRgVEKZ3masrvGE=;
 b=aQHfZ9VOR7EKc7YKQTylqj6aFpGAcqcOSPUmNtqMoGLQqhWtuyaAjB1zL0q+Mob+bF
 tlwiuhEaSdzW41K0/eP2CuKyQ9PNbb4jWiKkQemn/qk2yey/eAdzWWJfkEvmFFGKsn4F
 dj8VBZNA2Vt1VtwlnYYJSHQ0EfHQLy4G7U35DH36KYfwtaKmMyHcRarb1GpeMPTODNc7
 nHZLcb92K3sLAhgCtZtNhjbWcYI6EX+mnHUY/iEs+wBWE1u6PLXns+UtTkUxX6x7Oh9E
 5E508DzJlspDq606UIQoxqeevaIwX5KSzwVN1dib8fySDupVFVleXxDfz801+mZtkqoJ
 3Clw==
X-Gm-Message-State: AOJu0YzXm9xXFHUJLxeoWq1TuY0XG/W150Y6eTajIzkeUfg7NHxII+f0
 mmOOd6fE4XONQGzqOf09YIzHKIeeBMykBTvOU506iBqEvNVVinyIFocc
X-Gm-Gg: AZuq6aJwVNpisbyAhYqoFgPcwwYULHCadJxzCQXVM5reL8jp5nIyaDexoz5QMlaY66K
 YqboV9A/W02Agv7Lex6XgDbwCZyawAliLT+2kVv8RRnfLrMt2YNr2VrWXNDCBbPfjimIrgYAkyP
 y66APscHyDhWmKZljAjCIVgi8cq7UwShdfpDKUzBW/pbZLYP8YgVjuRMfMhMa0zFOOOgOukjcf3
 TgDBYjSlFysh4wsJNT8gg5R3xn+BENXHqRTh+AveM1C6QJ7AZNGsQdR8iASfY+FWB4UF6nVNzIp
 ryvwQJxs7H2KR/ziEQjxlF0HkZgYYN4yDR4teuWgqGyT1N1Ee7vkPNF8jKcrnNVTGaC8D70oDkX
 sUmTo5FxSKf+ipIA038RusDLplHAcXmEX3Bvevt1jqTDr7RVj1MlnXrjRSdMUa0lev+Z1br77Td
 T3u8AvcG/vno62CJM5GOFkaX3tODku7PQ0twzsyXC3ew==
X-Received: by 2002:a05:600c:3f0d:b0:479:13e9:3d64 with SMTP id
 5b1f17b1804b1-483203d5f73mr63702885e9.15.1770418166030; 
 Fri, 06 Feb 2026 14:49:26 -0800 (PST)
Received: from timur-max.localnet (185.180.91.41.zt.hu. [185.180.91.41])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48317d2ba61sm244152075e9.1.2026.02.06.14.49.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 14:49:25 -0800 (PST)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Mario Limonciello <superm1@kernel.org>,
 ChiaHsuan Chung <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] drm/amd/display: Fix dc_link NULL handling in HPD init
Date: Fri, 06 Feb 2026 23:49:24 +0100
Message-ID: <2483344.vFx2qVVIhK@timur-max>
In-Reply-To: <20260206143730.1477825-1-srinivasan.shanmugam@amd.com>
References: <20260206143730.1477825-1-srinivasan.shanmugam@amd.com>
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

On 2026. febru=C3=A1r 6., p=C3=A9ntek 15:37:30 k=C3=B6z=C3=A9p-eur=C3=B3pai=
 t=C3=A9li id=C5=91 Srinivasan=20
Shanmugam wrote:
> amdgpu_dm_hpd_init() may see connectors without a valid dc_link.
>=20
> The code already checks dc_link for the polling decision, but later
> unconditionally dereferences it when setting up HPD interrupts.

Please remove or adjust the "Fixes" tag here. It should be:
=46ixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")

The dc_link was already unconditionally dereferenced since the beginning of=
=20
DC, since the very first commit that introduced DC. The commit "Only poll=20
analog connectors" did not change the way HPD interrupts are set up.=20

With the Fixes tag adjusted, the patch is:
Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

>=20
> Assign dc_link early and skip connectors where it is NULL.
>=20
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c:940
> amdgpu_dm_hpd_init() error: we previously assumed 'dc_link' could be null
> (see line 931)
>=20
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_irq.c
>     923                 /*
>     924                  * Analog connectors may be hot-plugged unlike ot=
her
> connector 925                  * types that don't support HPD. Only poll
> analog connectors. 926                  */
>     927                 use_polling |=3D
>     928                         amdgpu_dm_connector->dc_link &&
>                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^ The patch ad=
ds
> this NULL check but hopefully it can be removed
>=20
>     929                       =20
> dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id); 9=
30
>     931                 dc_link =3D amdgpu_dm_connector->dc_link;
>=20
> dc_link assigned here.
>=20
>     932
>     933                 /*
>     934                  * Get a base driver irq reference for hpd ints f=
or
> the lifetime 935                  * of dm. Note that only hpd interrupt
> types are registered with 936                  * base driver; hpd_rx types
> aren't. IOW, amdgpu_irq_get/put on 937                  * hpd_rx isn't
> available. DM currently controls hpd_rx 938                  * explicitly
> with dc_interrupt_set()
>     939                  */
> --> 940                 if (dc_link->irq_source_hpd !=3D
> DC_IRQ_SOURCE_INVALID) { ^^^^^^^^^^^^^^^^^^^^^^^ If it's NULL then we are
> trouble because we dereference it here.
>=20
>     941                         irq_type =3D dc_link->irq_source_hpd -
> DC_IRQ_SOURCE_HPD1; 942                         /*
>     943                          * TODO: There's a mismatch between
> mode_info.num_hpd 944                          * and what bios reports as
> the # of connectors with hpd
>=20
> Fixes: e07945681dfe ("drm/amd/display: Only poll analog connectors")
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Mario Limonciello <superm1@kernel.org>
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: ChiaHsuan Chung <chiahsuan.chung@amd.com>
> Cc: Roman Li <roman.li@amd.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c index
> e7b0928bd3db..5948e2a6219e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c
> @@ -919,16 +919,15 @@ void amdgpu_dm_hpd_init(struct amdgpu_device *adev)
>  			continue;
>=20
>  		amdgpu_dm_connector =3D=20
to_amdgpu_dm_connector(connector);
> +		dc_link =3D amdgpu_dm_connector->dc_link;
> +		if (!dc_link)
> +			continue;
>=20
>  		/*
>  		 * Analog connectors may be hot-plugged unlike other=20
connector
>  		 * types that don't support HPD. Only poll analog=20
connectors.
>  		 */
> -		use_polling |=3D
> -			amdgpu_dm_connector->dc_link &&
> -		=09
dc_connector_supports_analog(amdgpu_dm_connector->dc_link->link_id.id);
> -
> -		dc_link =3D amdgpu_dm_connector->dc_link;
> +		use_polling |=3D dc_connector_supports_analog(dc_link-
>link_id.id);
>=20
>  		/*
>  		 * Get a base driver irq reference for hpd ints for the=20
lifetime




