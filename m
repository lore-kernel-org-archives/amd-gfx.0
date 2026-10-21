Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F79E606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XGBNsliz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B74B10E0D5;
	Wed, 21 Oct 2026 13:48:24 +0000 (UTC)
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com
 [74.125.82.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4FDC510E0D5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 13:48:18 +0000 (UTC)
Received: by mail-dy1-f180.google.com with SMTP id
 5a478bee46e88-33bb5afa736so88564eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:48:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792590497; cv=none;
 d=google.com; s=arc-20260327;
 b=dw/PllSlE9TCnvf20eE+yNtPZXweEddcoeiLnH9sGCwwsAd2hI+ew3mtsjynaKMJDL
 4y5ERmtht8GG4FNMQ1SGEw04xMsgBr8TgjBi5BhcR1HEm5g9U35a0VzDQU4nzJ4uCgI4
 T1HaVsDaJJHV1w1yT0TEzrui9np+z5OrtaybWFCQYoDBCiIPoQSpaeciYVx8mqVDdXmD
 oQKL3mKaa7jC5P0IxMrmYf5L79BYSOmbMrboAJL1uXUZ/u3wk7SGJMXdqmRfWrh4In0a
 Y7aNsV6IyjMCLFRYD4A/6XTVV1GZX/Ms06VYm1Cyw2MJtiuGoMiQbjH6xwhFXZnyL72I
 E2RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xoPHSM7s7dEM9Xe6b18yiWcgnk23NX3wK2HqlbSIszw=;
 fh=X4mUfjZVgvK6OABXLMbrCgBBJmiAn97ZZje7MPVuzbk=;
 b=FV8Qk6JgjKFbTv6t0wFYfLQNndetKO1DW68mwXh/TN27WVwB2EgL68OQQhTPG3/8Yd
 NspOQBcMycARjTEbCOXAPj8nO6l2e2ArVPuolExABkSODnIH/OuL+yAq7f1ElODXrgeT
 ELcYYX0ey7q8GvvzaY30qI+M0m1pd4NUWtfEfwVWmxvH+YoZy11ZJYCs1vuHpenDA11f
 nuA9vR70v8M6Gf4d8SfhhOrpZgsZzu7BcB587DLD5BQELz93zQ/7NNl46Zq+G/NTxBYP
 vcsafYhwuQHINjCVnfsOU2aBsFA3SDwjwf1yHIkSM1KU87BP0RNvO2BiXGTr1+JnZicH
 HWBg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792590497; x=1793195297; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xoPHSM7s7dEM9Xe6b18yiWcgnk23NX3wK2HqlbSIszw=;
 b=XGBNslizIyXeruU7FrWwEuP7qjT8X5I7e1Gw1KRi27eVKY6aEuX2XMlNJzuK6ZOxoc
 /BbFJLJb+bYyjWNKaHpixZyb16bAr/snMRDsc/R1zh6g30iW7PyorCRR45D3Ua9qUdcH
 Z+gO0YPN4SIW1OYuoJ8bSkSD+R2Rqeo36Gcz6CdsaKoWiw2Ea7XTivBpDF57qHiBHYVB
 hcEDnRVZcO/tTpdH9RWTftjHkBevfKvJ+G7HWxuabELYBzi27jLCpLV6/sS7oYM6PTke
 mWjd5hJbHQZlDFEsK58/7+JskGds8/wpppZxlaEXOblF3KCFyTaeX6aPcA3Rch/ZUqbA
 qfCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792590497; x=1793195297;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xoPHSM7s7dEM9Xe6b18yiWcgnk23NX3wK2HqlbSIszw=;
 b=z3Iw07si0I09QV1rje8T9RO9VDqIftWlzrNwSKNwtVMIr+anhSN2kPti/AKDA+g16M
 M2B5pzc8wSPCCiXvrgDpzk6Zg++jcnAtpmouf4HkRmCGbqDrxJa49G+WufLbMX5C9jQy
 HVrUovwUf2KS6rhIt96izB5dF/fcceZVsTI87Afhg+H6hOFWdsi/n0Puzle1mxcU/IKL
 R0QDQmDMHULnXbmf+xl1iSicKwGMmt4BFrKqQOyjgp6/A3Q8cb6pufTg9LuVH41/TDJ6
 c6VABAJ4irJuP1yNtNV0i6APmPcP0Pi7x0YzsBS1amIm8hDFJd1/l55mfRZ4px6Z1J2Y
 lXAg==
X-Gm-Message-State: AFq9FYIK0Lps3cQFz8LBV4wVjoVnzRfHapi56ZxRRuh6tgiYtGTEltro
 A0E084Mu7YbZ4iMgA29sViuPiukVP7Ujq/S6BoxlmjZ41IqenlLmqwnah0dpraKqsbSwLaoxDEk
 YE7+CMVXkgKB80f56ZKzdnIOPT38cNIvBrrIV
X-Gm-Gg: AYBFou1YmGTz+n6mCtL0yVOGXmiP9a/S9rc7AbZzVquZirgP8FPE8i5lv89OH55MSuv
 bOW1pfn/56rdlMeB6PVMsrJYaBr6bFCxxa5Ko0w4VCxO7uB6g3v/Df1OILPkMxZGg2/NGfs5KOr
 g/2JHoRorGq6zCLKwZAxyEdrddX0WQ8Y7VpWAOwTRD6qr8SsD2BlJ+LFztb3H8fosvhsE3gk0pl
 CaYBQCG1SR1ZISWQFktl3H2IPaKmki+IJkn269tc7mhkuTO/vg4towtxNalFHRA2JPXVA57qV/N
 /HtQ82mh3UtxCQMy4N2BuHXJxpxgnsFUUqF8rnwsD3wCcwYZZxIBgacezFf+5TiWS3g7B00D7Yu
 Uwh/WGxK132wwaRkvVn49q5nw1Le4tBdZ2WH2wDAd002el/cyuPyqcA0hI8+OLbz5p3NrBphRN9
 4QwtB3hwVeUE6GsP1ZZ7zkr7s=
X-Received: by 2002:a05:701a:ca0a:b0:165:be2f:c56e with SMTP id
 a92af1059eb24-190a7660dfdmr4544582c88.2.1792590497525; Wed, 21 Oct 2026
 06:48:17 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261016131604.2198664-1-alexander.deucher@amd.com>
In-Reply-To: <20261016131604.2198664-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 21 Oct 2026 09:48:05 -0400
X-Gm-Features: AclHuK_3tYT30qsbdikNTxYsQYay5gCi-eSMzhdkIK1yZ3Ou4q9Q5sFpGz0zYAw
Message-ID: <CADnq5_N20qUbmob=zD0QTurtxPGboR7BRj6dKPsjGKpa+wXqVw@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: allow dispatch tunneling on GFX12
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Jakub_Oko=C5=84ski?= <jakub@okonski.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping on this series?  This just fixes gfx12 to align to previous generation=
s.

Alex

On Fri, Oct 16, 2026 at 9:16=E2=80=AFAM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Was implemented for older gfx generations, but got missed
> on gfx12.
>
> Suggested-by: Jakub Oko=C5=84ski <jakub@okonski.org>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd=
/amdgpu/gfx_v12_0.c
> index 1ac0d33e62e26..c9e091ea8c5e2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3168,7 +3168,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu=
_device *adev, void *m,
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, RPTR_BLOCK_SIZE,
>                             (order_base_2(AMDGPU_GPU_PAGE_SIZE / 4) - 1))=
;
>         tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, UNORD_DISPATCH, 1);
> -       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH, 0)=
;
> +       tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, TUNNEL_DISPATCH,
> +                           prop->allow_tunneling);
>         if (prop->kernel_queue) {
>                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, PRIV_STATE,=
 1);
>                 tmp =3D REG_SET_FIELD(tmp, CP_HQD_PQ_CONTROL, KMD_QUEUE, =
1);
> --
> 2.56.0
>
