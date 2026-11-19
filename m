Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921D606A320
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Nov 2026 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=urGOPUIc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06F161122DC;
	Thu, 19 Nov 2026 11:34:40 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E5A01122DC
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 11:34:33 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so15815145e9.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Nov 2026 03:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795088072; x=1795692872; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=RFLh2mSUFRz87oiSetfw5vnjim+LiSJSlSUWqTbCIW4=;
 b=urGOPUIcHhteH9qngBdT/Jn5tM72b/IvUzKwDWYWQHBXbz2mMiufZWDk4Z9x1IeN+5
 JTrtxxqszwQnzIG0DE4bSYnc3bAyJ28X6wiFL0dMOiAIMVZMxVJWMCerd8ON+OMJ67e5
 5gVQNO7vwyZI+89h5KEZ4JJ8mzhedDyUGxIYeE99+iFSrFC2Qk6CT6WwtuyMMP26YYnM
 t2PV9UmfdVNHr8y5OJRqWRpo8G1nVVcQFr4KqbwiG3QAEPN5baBeoKeI4FTpWAcFbn77
 0lr/tvH9KNpCcjkjqgnAjRUMBZaTC8O4wDEi4lvtVSouJOmw91ZrV82z3EyfBm6MhwqP
 GqKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795088072; x=1795692872;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RFLh2mSUFRz87oiSetfw5vnjim+LiSJSlSUWqTbCIW4=;
 b=cAFmy1zTVI7ghM5emsWftyplp8Vvui51++fKRBv+yA3f6ttzSfNqXsPAt4JJMks43p
 FbWm21BQwPiTJ92smOXsMKwxMG81/uDJqtfDm30H71kU+kq52Sb5E7XHkQQTzquIv1wQ
 nkLD+nHar1nETzrEiNSy8Td+mrGeA7kOi22zGu9ZlBHKNC5UPNl7JgijElj1nFFvBGdJ
 qAm0qPVUCjFvaqJIL1GFbvZyK+1ohHmIkJL+WG3hrpUteXSj9UN8+scyaOLIQQ+e9R5D
 3qJ4IaoCCLL5eCyD+pw5EXS/cFEueKra/1KXrTF7b6REidSIeOqX6AmZY4HyyjozsM+P
 DPyw==
X-Forwarded-Encrypted: i=1;
 AL+hErFoxVsakngCkothvIidvKJbJ/2EJ8FAvNYVliJu6x/Z2Av9Br8DSRznFtfPrUm2xbmoI4YnKi52@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/HEzxxw+UFFoDrjFy3B6rWFjXk4emKR4ofNtudCPtV1z59HL9N
 UYyleS6SudNpx0EiXHdv3K8MzgHyTslnRd/FYgU8nFeJeSZNyab+IYnM
X-Gm-Gg: AYBFou1fStTPDwhmNfOfMhW5XJ2PecjPBdSuscaR3fU9eUovugTZ8/0NDiGuRnfbgJx
 ZbDxshfYHNLbnvH7LnAlHv9C5tD6ZDheluMX38e/e7DzQZSIGNpvpTXtXJWgoAEQLQ/kd1/jRT7
 i3HA1ACv+EjIVfj9gooF45uIOFdy1ddYf+aOmpeIAnKxz4gF9ehV/dDYLpSLPJK22FGWrIIyBt3
 i7XGhs2W2m0d9pivDN3Gw8OD/z1zdrb70YggzFXlv/z6QAR5CoPI61wnzHsAJprZQ6s0jtW/F3I
 luaO/ABJzoCV2AX5Ssaklr7M98xVRTEKTpyTVs7/CyjQFyBFBtVeS6U+7LfAaR6UUU1MbZzkFXJ
 fgSpFdNrk6LrMdQHWUIIIZ5+WchyAbrkpkP94pNQdqhCkv+sEouu2PEMITFZIpkHDGiPbnFU7N5
 WQjTg+8NCo0FYGvM0EdDI73mvRDjuVdwwh3DBr0FVuWKA43pj0C9vUQtV4b8GwnyCCTHpcnU+Dj
 wUOI7/+UpAThm9jz8p/f9UPuwS1/iTSrrW/7sasmCCFD+7aa6p3T3QgJ/RLq0vMB/m1eSh7tmkT
 Fxm+Kijl6bj9YYN/bUKPAhVFnpH6lxZuZRN4yIalkVCnaCxlcCCshQO8Emp6KWT/fh8NWNpBESn
 PrH4fIOHcMRngX4LhvszMBdKEaQ==
X-Received: by 2002:a05:600c:4f4e:b0:4bb:7033:c92f with SMTP id
 5b1f17b1804b1-4bb7da0f671mr131205775e9.11.1795088071567; 
 Thu, 19 Nov 2026 03:34:31 -0800 (PST)
Received: from [192.168.1.71] (115.red-2-136-224.staticip.rima-tde.net.
 [2.136.224.115]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb8532f1a9sm27377875e9.3.2026.11.19.03.34.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:34:30 -0800 (PST)
Message-ID: <fff55a7457f9ee34c66f6f009bfaeb0f1c7323c0.camel@gmail.com>
Subject: Re: [PATCH v4 02/13] drm/amdgpu/ring: During multi-queue reset,
 only call begin helper if needed
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Christian Koenig <christian.koenig@amd.com>, 
 Lijo.Lazar@amd.com, Mario.Novales@amd.com, Manu.Rastogi@amd.com, 
 Jiongyu.Zhu@amd.com
Date: Thu, 19 Nov 2026 12:34:29 +0100
In-Reply-To: <20261105030612.726542-2-Jesse.Zhang@amd.com>
References: <20261105030612.726542-1-Jesse.Zhang@amd.com>
 <20261105030612.726542-2-Jesse.Zhang@amd.com>
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
> From: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>=20
> This is necessary to make soft reset work after a failed queue
> reset. Otherwise the ring reset begin helper would clear out
> the guilty fence and the backed up ring contents.
>=20
> v2: skip the begin helper only for the guilty ring already backed up
> by
> =C2=A0=C2=A0=C2=A0 the failed ring reset, and keep backing up the other r=
ings
> (Jesse).
>=20
> Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>

Thanks for including this patch.

Considering that this fixes a real issue with repeated soft reset, I
recommend adding a Fixes tag to this commit:

Fixes: 1fc76380c6ce ("drm/amdgpu: Add IP block soft reset as a GPU recovery=
 method")


> ---
> =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index edae764eb0c4..c71e1c3b6d7b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -1027,8 +1027,10 @@ void
> amdgpu_multi_ring_reset_helper_begin(struct amdgpu_device *adev,
> =C2=A0		 * Backup current contents of the ring.
> =C2=A0		 * The helper takes care to only reemit unsignalled
> fences
> =C2=A0		 * so we don't have to worry about that here.
> +		 * A failed ring reset of the same job already
> backed it up.
> =C2=A0		 */
> -		amdgpu_ring_reset_helper_begin(ring,
> ring_guilty_fence);
> +		if (ring !=3D guilty_ring || ring->guilty_fence !=3D
> guilty_fence)
> +			amdgpu_ring_reset_helper_begin(ring,
> ring_guilty_fence);
> =C2=A0	}
> =C2=A0}
> =C2=A0
