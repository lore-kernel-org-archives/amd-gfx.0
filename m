Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37859606A32D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pqBKx+nT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BE5210E920;
	Wed, 25 Nov 2026 16:03:25 +0000 (UTC)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com
 [209.85.167.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D11010FD72
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 16:03:19 +0000 (UTC)
Received: by mail-oi1-f181.google.com with SMTP id
 5614622812f47-4bd3984f529so128881b6e.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 08:03:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795622598; cv=none;
 d=google.com; s=arc-20260327;
 b=SQQrdqaCIXblrVxqeTNUTPXjOqYJZch+4MIt9uDqUWudqkthntaEIK5yE1AwzlNI+p
 Fdo3lFqRSKjv6egVccVLzJj7NgAiugkTVXPYYOb8HNEwH9cpjXuN47Nv7qvIZQ6DPoh7
 chF9T3W6aBieH6+VQoU1QHsc7E2tyus2ShvynSXYnAq7e4akt5fW7OMBE/EvhpGD1uKY
 VcimdvdN+tvEMujsFPSxMTV++bMTvVQUiGsdf9xiDZTjlrV7ce5vg4RUSpdnAOIh5Yly
 2UFti93nwvxLTwlAKn6N4OwZlVDNorAJjokts891Wk0kgoheE5e8CbIyJY1YgLOiORMs
 X2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zvOYpSiI4JN7rhg2jjnLiWS4bn/Qk4/KwjA5k/SLG5w=;
 fh=X4mUfjZVgvK6OABXLMbrCgBBJmiAn97ZZje7MPVuzbk=;
 b=R7ynA0nYa2lkp7FuW/kCoIZQU9Por5WdOn6PamPLOTm1uiHVJZJuCxd0okJcVlCRXd
 318aPUi/6cSANHxnCqNB0/EYiT1NGuYiz1lT5nTtYnUwoj3intrgyCOym0Ni6snpWfy2
 aeduKIkUgPvPuVpTztrok0cZ0amVDx2zuUcDWbzbfIIkhCBeOmXvkygZ4I3FK5iSBcgf
 +IKpEx7HU7jzNvmEoGg/jE15P2mQWoQzH3lFAhdIToXxA6wtjKXTowlp8b9mt3LEqdJ5
 dWCJZCdg0f3MA/1Vzm9WTCg/HiLAAoKn8hbNlY8w0SZX+Y4E0Ed6YGKsXedks/umCyGy
 uTQg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795622598; x=1796227398; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zvOYpSiI4JN7rhg2jjnLiWS4bn/Qk4/KwjA5k/SLG5w=;
 b=pqBKx+nTQ6JQ2JPApzXXFPUpSfuhMpVfA/SwPlgs32l+eD0KUWSxuKQaTR5HmKBlR2
 7W+csW0trX6Jt6qozpc2/3cbPlNyVtB0XdqGVEmc8a3hUi0SI6x4iXGzH4HmsHGSCvvX
 UZxqBnvLsIHzMitpGWg0H8DqWYIcD/3zKgMFYsOvXBSgCxF9hjuAniL2iBR9OngWIwbO
 xbVmPFnS0VHuoz/CtnHzkZasEfRXD82EZPNx33lZJpG0yWYnHUqjnHL8nOOJTvHO07qF
 NCZvV/3Zrd18mmAMIJMQ6Nz9bA5vlsfRn4Moo6NfwId2nUeYKmJ5VWKQ1OgfFwPVRGIR
 8B3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795622598; x=1796227398;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zvOYpSiI4JN7rhg2jjnLiWS4bn/Qk4/KwjA5k/SLG5w=;
 b=Agc7gbjzwcsy+ebiej65SzH62ozQgVRgaJkmnz3esCGh62EXn1wmneAf0RV6GHnJGn
 ll7W+wxRfGeHdHnnxL2tuXdT8lTlDwW+PFqKPRo4EO39asEzXBtLRbqt1wexLggibTn4
 w4R2RD+EV3VrrSdv6nDvXI5JyjVJ7Ve3rwt78eYEEB7w9PC2L/9IA0NIoW5W+SJRn02q
 o14OSDkeV9NPSw2Xqsk1fFTit3wLTooKDDov6JmmMy+kwI63HvOL/Fjjatlk6hwe+SzO
 49RAo6oEwnI7ZldAUm/bW87eaGdWfrVD76CaKp5jMvk4yz0S5jA9RI+Ac0A7IHrMTBgL
 jTnA==
X-Gm-Message-State: APuU4Z+78lUPl/S7vd79Y9HvlZ59EpYSZVRZVAynYBWebBhNwvewlwVz
 Fsip+wg7t5Su776MQV1fwfDtdKQlsFiyYo8rhrY8Xk3uR7crYa8g2u3YQqSoc/zTQYFA08PYcUM
 wQ6m+3d2ak2BAIPnBPCb/pduLEYbZLMc=
X-Gm-Gg: AZFdTZcZ/rdQaJlIalbfiBNv8L4cM2Xgv9QNEpYtVgPv875yDxz7UYbmkYfjetr4gkz
 TdVcSTQHiy+7/UHNkb9VaN30le3YoSf1Fw2UlscPJYMh+NMHZRpFKr0+Qb+zmyUREJ8aQAhQ1kD
 U7+9WC+deoAZvto85iAVvwQG+T1W4NQfDCl98MgmNxu/RkoTuXtKL4eySDzG7submWvRdy3Ul8N
 OGMKgnNQXWEn4Uxp3wppfVQ5cTVd4KenSb4i4pu3ACBTGVUOYwRXMxsjLGhwEjvxhmAXOLQMEZc
 1QwOKoAX+326Z9NsFZeJf3YMw/BnlAuWy7Vu7K8tZY1/enj7MIGwJghGWD+LWFX0Yy1CAbXsOHB
 ss8wXNZgyuEsI1FhlrQAUpM6HIvWvSeu2z89v2HQBxU9KRQ8AIesk6/V/DIgwsp+5fhgzQI9eZL
 YXIV9wpcN56yQUgf8q/PTvuk8Z72JaTJinsQM5lwql4l5F8sDCNEGgTWV0W7U=
X-Received: by 2002:a05:6808:17a3:b0:573:8745:a99a with SMTP id
 5614622812f47-57a0ac32ae6mr27284413b6e.5.1795622598250; Wed, 25 Nov 2026
 08:03:18 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261111173146.3157865-1-alexander.deucher@amd.com>
In-Reply-To: <20261111173146.3157865-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 25 Nov 2026 11:03:06 -0500
X-Gm-Features: Aa3M54rq6Ww2V0p2K-HT7q8GN1_xfwsBEsC533-DoCkJ0hrHZCpEjrE4WKOwc1w
Message-ID: <CADnq5_MUGNxUAfLh2EXxV8zySRNdXNUhjqXK240_SBmzw2G-7g@mail.gmail.com>
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Ping on this series?

Alex

On Wed, Nov 11, 2026 at 12:51=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
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
> index 8569c371916ec..1fc74e53feffd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -3181,7 +3181,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu=
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
