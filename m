Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E336460A2610
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ly2bpeti
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 660561122ED;
	Thu, 19 Nov 2026 11:47:38 +0000 (UTC)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB18112310
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:47:32 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4a1fbd52ab6so16383645e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088851; x=1795693651; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=xyPwvcxiQ6g0Y24FPApDOnJoQC3Htves4+rtajj6sIg=;
 b=Ly2bpetiIzhi54OB+SUrPGkXmUQSCEn+WbGtaqyvNnZ7zWllqtFQ19tkKzdBsEdhJz
 Iku/LwUHbJfqVvVbVQ90/g76GHUUKiGG9oiiJODBoeUxwc22rCt0WHLcUs6vH2Si8YLm
 aQA7x1otjGkzl5nkA/tiDvA+OJpYZ6NA8h7uaMGttQXTQEpGMwP2CmcwcjZUYVOyyJr7
 sp14YkP03OqPh6nIhDqepiPcO10NxUX/00h3UYn0rffz/ewfyneYFBLOK6eRFJWGyTPP
 DI8qudV63/B6SI/8u4rz79Tbv8mfPJG36VcyT+K5oDkbmdzXjbctXd+tjSQLX9kN5gyY
 jFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088851; x=1795693651;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xyPwvcxiQ6g0Y24FPApDOnJoQC3Htves4+rtajj6sIg=;
 b=pHtpMHNjMM6mEf4NFTPbZJhv5mrgkyiInihyewn7lSyOyAnO9DJMCIbk3cxKSd05SB
 QiDrQP7vPZ6uTNGWP+aK0nIkthY/AoRMscLDdo0bP58SDZlQt1HBYoZ3yv7UTUo5w0eO
 kVNZpQBxUaC4Nl+T77U2BkI7vx9sp2bxTNMgoxddLDiTL8LYHXR9yhzlxrU6ucg/vg+v
 h/gjjxIdrk11kTQTJ2/wdX7VIHaBvwQWh0aYK4wkb4Z3KHlrJKZAadHltxk0xayyx+sV
 wqQW8snfGHTgyXBy+jggWqEjqnWMhFoqzTkTFyfeW5LEdgkLMM1zwuewn77rcMJVP2lL
 v8+w==
X-Forwarded-Encrypted: i=1;
 AL+hErEYGJP3PY12LCJ5PWnlTzBqDGVeAimnwD4ESf8B2mJXXb55hsgp6o+2allJMnMgRCblTcUrGawi@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9XXTyKL3IyXVnoG4gS81C6qpY4D1HarAMdaaTkN9XBLdkhSjJs
 UKf2LpvJiEAsWpba84pTN347klLNZTfD0o5OUsE50zEyCfgOMN/bItnr
X-Gm-Gg: AYBFou3Jb/Gb6PTqLrfEtVvd4tSaTw0T8XBexTegcXw5vJi7ysr6yuT0wxHBnp2EZ/1
 DOnmrcjOup+yxWD8QbvJbxfHXFr3KXcsCPH4tZLf4PErJTwSUOKpG6O43qeVq/pP1CqsnCfh89i
 DBTqqeka4X6wpO3akVS2rX4udxU514Hpbi4HPXHpE0XFD5B936yCKv6+0DXTXcg2rSjDS6MNQXv
 LmWMKgH3lXg8Z27pPu7id8NBcb2QB3dKBrgshzTzBbVmuCKePKCqKnbGeDoxe3GN34SUKOUq3NU
 tlz0HS6R52Hnrg3xsDQSsNA4qYDc1nRYeA15QNWXXgKutxOF07b4Nx7VlbRYOXdYAdJx/W9CcXb
 lu4tg4M9vRZzOAyukvs/XuqTy1k1rbXXJZ87FBghuZ9IyTJLTOuwGY5GDtTRUckxtOaJea99mXs
 3ErZgdHjGX4A6qJkSlKDLpENkKkZHE4fED5ZqYyqzGDqnXQVhR9NBJ7oWBuOhPOQTgRy7eZyJbQ
 0OcSaG1xpbEAN2rlG4xm31ag74YxlT9E6oraf3ZYRplMrlfhf/EmCbBYk8/8GKEzDSeKORrpotn
 twwp5Wo+Aa/KhqtpZKWbzoQpsXNzf10KVE/SXkwDcFQ3u3zHAN1saY+m6CzkaEvexz+B+jR70tz
 SxO7/
X-Received: by 2002:a05:600c:4ecf:b0:4bb:60da:56af with SMTP id
 5b1f17b1804b1-4bb7da391b7mr115556295e9.25.1795088850657; 
 Thu, 19 Nov 2026 03:47:30 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a654a8c3c6sm9340750f8f.19.2026.11.19.03.47.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:47:30 -0800 (PST)
Message-ID: <f4128e1b9be5431cea1777856341375f017f6813.camel@gmail.com>
Subject: Re: [PATCH v4 12/13] drm/amdgpu/gfx12: enable the gfx engine soft
 reset
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:47:29 +0100
In-Reply-To: <20261105030612.726542-12-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-12-Jesse.Zhang@amd.com>
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

On Thu, 2026-11-05 at 11:05 +0800, Jesse Zhang wrote:
> Report AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET for the gfx rings with
> MES,
> which the reset uses to map the kernel gfx queue again. Not on SR-IOV
> VFs.
>=20
> The kernel gfx queue and gfx user queue resets then fall back to a
> soft
> reset of the gfx engine before a full reset.
>=20
> v4: The soft_reset_engine() callback is set by the patch that adds
> it.
> =C2=A0=C2=A0=C2=A0 No async gfx ring check: they are always used now.
>=20
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>

> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 5 +++++
> =C2=A01 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 8b96f2a29b1f..55baeda02d6f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1593,6 +1593,11 @@ static int gfx_v12_0_sw_init(struct
> amdgpu_ip_block *ip_block)
> =C2=A0		break;
> =C2=A0	}
> =C2=A0
> +	/* The reset remaps the kernel gfx queue through MES. */
> +	if (!amdgpu_sriov_vf(adev) && adev->enable_mes &&
> +	=C2=A0=C2=A0=C2=A0 !adev->debug_disable_ip_block_soft_reset)
> +		adev->gfx.gfx_supported_reset |=3D
> AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET;
> +
> =C2=A0	if (!adev->enable_mes_kiq) {
> =C2=A0		r =3D amdgpu_gfx_kiq_init(adev, GFX12_MEC_HPD_SIZE,
> 0);
> =C2=A0		if (r) {
