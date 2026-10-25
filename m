Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEEA606A31B
	for <amd-gfx@archiver.kernel.org>; Sun, 25 Oct 2026 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Js4QF7zz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F0D10E1BB;
	Sun, 25 Oct 2026 17:14:49 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9A310E1BB
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 17:14:43 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a214af2076so15400635e9.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Oct 2026 10:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792948482; x=1793553282; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7JrC81/JDOyBUDBe9YoZXJ79Yq7IMjS+qhUOLmCOSZE=;
 b=Js4QF7zzcM8vUcr5m3GEoDyE8BAEQmi9EcrT2DoILN/a53d9JuKa/xIOqIHAbnF9b2
 ZO2JRBJz2ll9vLCN4t4UuhU3b3bJTXclYV8MTlJHzJb7br0B64YI3/aUFxkbrrf+zBR8
 bnu2MW1R02ssgiHYqQLb0qhLvRJMoUPwuq6f8e6DOeMEhRYpEF5UfT4SKZ7Rd1lO7U8Y
 a204KPA61NeLAFhZKudyf+J+1y5kAG8/s6OojYttuQsDKfvKdI66RXRARXe/6wR2iG7r
 RAIYE4Zor9fuy7mq6y+0h5NQuU+K8C7uBtcpBTSPYcyNQc4NXKEgkqOXF4arTivg3wip
 mPuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792948482; x=1793553282;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7JrC81/JDOyBUDBe9YoZXJ79Yq7IMjS+qhUOLmCOSZE=;
 b=tfiHKrzJiPLGjirG1tsVxX50Y3JvnP1Jb1BX+wQHpSHWFBpL+3piZ3HyHPUyv0eOoK
 WCTjwh+BKBboqvQ82u4S0ZzvpplqR6PX6Wsa/mE+BBeJKjbc7JeB1g9xH68yF8RBEIdm
 JNYwaiXdT34ZZ/lTqfGl38CCL07QgUn/WniLR1AQTRB5bBIP15YbcojPtj/Lg+1/M6mA
 Zh8xAn88srwaiUde2It5Rz+phn2YjyU9AY0ChQuiuN83mxEIS1R2eV6DWCmj07Mnbgz8
 yysvokJJCpK3CCUbd6ENuQBCO8Q/wWPRD05afLj3ms4x4Sdd86hxDr1vczlo8QYIuhn9
 Tr6g==
X-Gm-Message-State: AFq9FYJ8DMykQ3qwNG0CLxhsfD5EQRHI5R3ardyf/uriOKJfncrbOcgt
 wBF/I6k1r8bXVL32Yud2Lg2qDGJyTv0DBZCDMu86rPBiJyMopJKpq3EmL0UJH1g9YuA=
X-Gm-Gg: AYBFou2XF1EbRfDmrSgpGAyZ7V1Huh8Z2uGn6voXqsj5HXRdnCLEUuqsvEsQ3XRkGMU
 mEcErwFVpReUMQbboa8BtjHosuYv0weDvBuftGDWOnEdOhTMdMnVnXRyW+FwArOqlQ1Q7QYH27T
 BnUA8guPbIDVKvGxW9OuBQEhgSVmd1sVen4zu+viBRRwiCK+1uNOgxk8xZ+102GN/2Uh+S9maUu
 6P4XFs5Px2kW7W5PmitWqzlSfyGnKVJSKi6qH1W3lOL5ZTTh212YhTHN4PZGk08b3Il4dx8kcGI
 eoMC5FxuG4ug8R0vSerjQUiCa/oYy9+QnlcQx0Rwl7uPbzPj2w8pw/9tpy+laoIdFbDEpZsgAjJ
 ECWdH2g0BtPlAvlrXaanu/mxZcXpRiwz4m3REnfHOWiFe3EUEKh1LBNen4/ncULCXKeqTEl7xQf
 aEXjgf5pDtBqmj2LpTXD36l6ZruIkuii7WsP9xcsp7Qa8Rdjlcpe8yOi9g3cQbgJRfsUoTS6/p9
 BlY0by3+uasMmaAW5NsEYPBK/d9Xoks0WKPf2rqHUAzxhtmNAbl3YG4HB6rZ5XHCSQgv0gal8ag
 tDFWvZic6Y+3Cog=
X-Received: by 2002:a05:600c:4746:b0:4a3:59c9:a744 with SMTP id
 5b1f17b1804b1-4a35ac8bb3fmr87648485e9.7.1792948481674; 
 Sun, 25 Oct 2026 10:14:41 -0700 (PDT)
Received: from timur-max.localnet ([62.245.128.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a0a9cafsm142731345e9.5.2026.10.25.10.14.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 10:14:41 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
Cc: christian.koenig@amd.com, Maciej Kucharek <qchcio@gmail.com>,
 stable@vger.kernel.org, Maciej Kucharek <qchcio@gmail.com>
Subject: Re: [PATCH v3 2/3] drm/amdgpu: reset CIK ASIC on Apple boards with
 VRAM at 0
Date: Sun, 25 Oct 2026 18:14:40 +0100
Message-ID: <0lACxgrfQz2H5tv1x9Ohww@gmail.com>
In-Reply-To: <20261015181837.41690-3-qchcio@gmail.com>
References: <CADnq5_NXGqXy7_Ntcv0aGSQt8Ax48-SgWpSv4rTzNjDL-H_8_Q@mail.gmail.com>
 <20261015181837.41690-1-qchcio@gmail.com>
 <20261015181837.41690-3-qchcio@gmail.com>
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
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026. okt=C3=B3ber 15., cs=C3=BCt=C3=B6rt=C3=B6k 20:18:36 k=C3=B6z=C3=A9=
p-eur=C3=B3pai t=C3=A9li id=C5=91 Maciej=20
Kucharek wrote:
> On MacBookPros with switchable graphics, the firmware puts VRAM at MC
> address 0 when the iGPU is enabled.  A later post (S3 resume, GPU
> reset) moves VRAM back to the VBIOS default.  The SI fix resets and
> posts the ASIC at load, so the driver uses the VBIOS layout from the
> start:
>=20
>   "drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0"
>=20
> No MacBookPro has a CIK GPU, and no affected CIK board is known.  Add
> the same test to cik_need_reset_on_init(), so that SI, CIK and VI
> handle this firmware layout in the same way.=20

Just a side note: some old iMacs have a Bonaire GPU, which is CI.
Not sure if those boards are affected or not, but it definitely won't hurt.

> gmc_v7_0 reads
> MC_VM_FB_LOCATION once at init and does not reprogram it.  A CIK board
> with VRAM at 0 therefore has the same problem as the SI boards.
>=20
> After the reset, FB_BASE is not 0, so the new test does not fire again
> on a module reload.
>=20
> Only compile-tested.
>=20
> Suggested-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/cik.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/cik.c
> b/drivers/gpu/drm/amd/amdgpu/cik.c index d29991a4a..e1029239b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/cik.c
> +++ b/drivers/gpu/drm/amd/amdgpu/cik.c
> @@ -1927,6 +1927,16 @@ static bool cik_need_reset_on_init(struct
> amdgpu_device *adev) {
>  	u32 clock_cntl, pc;
>=20
> +	/*
> +	 * MacBookPros with switchable graphics put VRAM at 0 when the iGPU
> +	 * is enabled.  Any later post (S3 resume, GPU reset) moves it back=20
to
> +	 * the vbios default, so reset and post on load to start with the
> +	 * vbios layout.
> +	 */
> +	if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
> +	    !(RREG32(mmMC_VM_FB_LOCATION) &=20
MC_VM_FB_LOCATION__FB_BASE_MASK))
> +		return true;
> +
>  	if (adev->flags & AMD_IS_APU)
>  		return false;




