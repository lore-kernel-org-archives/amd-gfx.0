Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C656606A31D
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Oct 2026 16:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PZsZqZbA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8683010E140;
	Sun, 25 Oct 2026 16:48:29 +0000 (UTC)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10B310E140
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 16:48:22 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so2357204f8f.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792946901; x=1793551701; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1M3gjq/8LTzZo7v++YE3JUMPJiThXfcWvCP7W8ZVP2k=;
 b=PZsZqZbAdOHs5g46dGp4z8GtbUh/Saky+l/WNaROOe/8TiMGh1Cdx+f6tWywvOTuic
 b7Wg9CUdJgAuxeH4orEL6Iqwl8FiND63imttPQfFUwwaHTSgGg85NoZC1fMgUYpN3rAP
 bEElEIekwukH4XsvxKeGy7nUIy8t37MHAqkzDIBcgcMM7Z6mTJp5V7AyGAKqV41tQ0EZ
 8qUo9dpoY6wK/E9zs3Xwz5icY/m5Evva+aj6aaMP4ZPklZ8T0U6RMbW9eAm2WrswFo6C
 mbPJPZEFabdCuHTYIBiW35TeL22m4xBQAH06SJuyrfEVljODDIWWAjgP9TgFq5CA6jq8
 Sp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792946901; x=1793551701;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1M3gjq/8LTzZo7v++YE3JUMPJiThXfcWvCP7W8ZVP2k=;
 b=ZZNTM5uyoQjZMWslfLj+kBi1t65CR3vb4TYmaJR4g/gL+yzRCmff3ze621SO3FNEJ9
 bB5V5wEEzsqJ5XLSvNiCzkr6RjtszO5PdnvcHGUUKrzHNwMappkpkYtqdJvApGlL5Uye
 XVK1+l6U8Ax6zrR0Nh5WPiezZLMmbdUcyJE52yH0cLlQHCqOO4TRv1XutTyWZFNeSAHK
 7BlzJc4MJsJ5ZnICfy5Ur2UsbI/sZ5eeWZynooQwLqWQzKOOPpLgDQYyGHd6ebP9bse3
 y93XPBflOqm9nyXqLbZEnve4LU9cSc+uoUxlMuII6MxD5ftseLZLCDuxeIu0WlKYLKqR
 fLAw==
X-Gm-Message-State: AFq9FYJ3TtKo5WSjIGhomBS8exkaM2jmfF4NIvpjh9tShNpWeIdkbSol
 m1uSHOvpSA1ME+0XXleBslViqxPPtr245uvrz79VBF4a5W+NeRKShY/seJvoF9Atvb0=
X-Gm-Gg: AYBFou0B/8Fl2qP63aWuC2KUGo0EFywMXikDPoLJENMcPzAlGsVCmKXNhnNvO1/kXaA
 qV/Xud5vftXy3aXcWYvtVngaordPpfgFS8m+SQB0J1BdnMA+3W2jNAlUqUBvxCpqYt4vOCHPXaR
 djvp5C1Laao59C0JJz8WPGJyjWS4OgBi24ogr/FzjrloEm/JjA/h0Q8oik2B9zW3TcWPa0DPqmQ
 tpgEWs191K8c/PXpBjxxkVyDb74pqSdBKT04QZs86ChxK8vsF0wW+3LCII9oeRLTIY/rTHv/xbw
 JHBTABImd4w9mF4Zd6U7hAZsUYgYFvDwGFG+mwIpN5oZwUBgevUMKhLMpA646Yhy5VHN4XezmUn
 w+7UpQE5UZa3U2LAksK88WKjKXSddNkzHZUmOdqL4kd55MaLTeoJ0jRdF40cABDgED8S0q4DAXX
 d/eLGJrzYKaNrYLuBkl7+6GGzTwVDDXE2+3q9zvwMYrWGvLKtEnCEcVrC7h9doGKX8YdCb/yymo
 2oZGhjf4p19sGu6cqmm7ia67QwaQBX7fDKOUlg/zwugVMnaan0xkCrMXI4Z1S3C8RG9ug==
X-Received: by 2002:a05:600c:a08:b0:4a1:7f96:9b42 with SMTP id
 5b1f17b1804b1-4a35aeab300mr93680945e9.15.1792946900773; 
 Sun, 25 Oct 2026 09:48:20 -0700 (PDT)
Received: from timur-max.localnet ([62.245.128.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a59d998sm139175175e9.15.2026.10.25.09.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 09:48:20 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>,
 lijo.lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com,
 Jiongyu.Zhu@amd.com, Jesse Zhang <Jesse.Zhang@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>
Subject: Re: [PATCH v2 01/15] drm/amdgpu/gfx: add a reset_engine callback
Date: Sun, 25 Oct 2026 17:48:19 +0100
Message-ID: <SoyYXquqRq2ehHt61k0aVA@gmail.com>
In-Reply-To: <20261022082011.331462-1-Jesse.Zhang@amd.com>
References: <20261022082011.331462-1-Jesse.Zhang@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026. okt=C3=B3ber 22., cs=C3=BCt=C3=B6rt=C3=B6k 2:19:41 k=C3=B6z=C3=A9p=
s=C5=91 =C3=A1llamokbeli z=C3=B3naid=C5=91 Jesse=20
Zhang wrote:
> Some gfx hangs can't be recovered by a queue or a pipe reset, eg. a CP
> front-end stuck in the middle of a packet. They currently end in a full
> GPU reset, and VRAM is lost. Resetting only the graphics engine is
> enough for them, and leaves the compute engine running.
>=20
> Add an optional reset_engine callback to amdgpu_gfx_funcs that resets
> only the graphics or only the compute engine. The split is specific to
> the GFX IP, eg. CP_SOFT_RESET_CNTL has GFX_ONLY_SOFT_RESET and
> CMP_ONLY_SOFT_RESET, so it doesn't belong in the amd_ip_funcs that all
> IP blocks share.
>=20

Hi Jesse,

I think this is a very good idea, in fact I wanted to implement something l=
ike=20
this myself.

I notice that there is a lot of overlap between your engine reset and the p=
re-
existing IP block soft reset. I would prefer that the engine reset be=20
integrated into the IP block soft reset instead of adding yet another reset=
=20
type to the driver. I believe this would make the code overall better.

My suggestion is the following:

=2D Instead of introducing amdgpu_gfx_reset_gfx_engine(), use=20
amdgpu_device_ip_soft_reset() and add the missing user queue handling there=
=2E=20
Note that amdgpu_device_ip_soft_reset() already has a more sophisticated wa=
y=20
to minimize collateral damage to kernel queues, so the new GPU generations=
=20
will benefit from that as well.

=2D Instead of introducing amdgpu_gfx_funcs::reset_engine(), use=20
amd_ip_funcs::soft_reset() and fix that up for each affected GPU generation=
 as=20
necessary.

=2D I think the cleanest solution is to reset the entire GFX IP block (incl=
uding=20
both graphics and compute) for the sake of consistency. There are some hang=
=20
cases such as gang submissions which cannot be resolved by just resetting=20
graphics or compute.

Please let me know what you think. I'd be happy to contribute to this effor=
t.

Thanks & best regards,
Timur

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h index 5939e1fb3b24..8dc669e89db5
> 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -345,6 +345,13 @@ struct amdgpu_gfx_shadow_info {
>  	u32 eop_alignment;
>  };
>=20
> +/* The engines of the GFX IP that can be reset on their own. */
> +enum amdgpu_gfx_engine {
> +	AMDGPU_GFX_ENGINE_GFX,
> +	AMDGPU_GFX_ENGINE_COMPUTE,
> +	AMDGPU_GFX_ENGINE_NUM,
> +};
> +
>  struct amdgpu_gfx_funcs {
>  	/* get the gpu clock counter */
>  	uint64_t (*get_gpu_clock_counter)(struct amdgpu_device *adev);
> @@ -376,6 +383,9 @@ struct amdgpu_gfx_funcs {
>  	/* find the gfx HQD slot (me/pipe/queue) for a doorbell */
>  	bool (*detect_hung_queue)(struct amdgpu_device *adev, u32=20
doorbell_index,
>  				  u32 *me, u32 *pipe, u32=20
*queue);
> +	/* reset one engine, leaving the other one running */
> +	int (*reset_engine)(struct amdgpu_device *adev,
> +			    enum amdgpu_gfx_engine engine);
>  };
>=20
>  struct sq_work {




