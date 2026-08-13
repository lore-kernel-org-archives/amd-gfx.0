Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B09C5CFCF
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 15:28:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76CE310F3A3;
	Thu, 13 Aug 2026 15:28:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RSfP4Dyx";
	dkim-atps=neutral
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com
 [209.85.215.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2C3410F3A3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 15:28:56 +0000 (UTC)
Received: by mail-pg1-f169.google.com with SMTP id
 41be03b00d2f7-cbe437a530dso196083a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 08:28:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786634936; cv=none;
 d=google.com; s=arc-20260327;
 b=DgVclPAqg1n7Zp7sKbnvYsgaYmMDDY1Y592eEV6aC6pb2YXR5vPAbSwPYW33DrMLky
 01Z7YuTdecQD5YtSL8kqZpmGWmY74kkTIcQatwDvGgHxgQmYMGWzaFYX6c6gP7n8RsYF
 5nptyniidlQsoQCFrNxDcRIG7q8lnXWC/M9nZf1jpN/w9yUYaVK4awlo0g3L/BvyVrpk
 bw0UtfBhDr46BZWwuq6i7b/RzusqZtbJqontmRaiYMZzF23R7Az5qIMAUFXM+G/B4BKJ
 jX4D95dvIx+tNvlolzMj9X55sxHuWJEiws8icO5AASMrUhfTkITmEt9YiuzZOZDJdpnT
 +kQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zf4pZ/YTW6aTHH8lPr0fnw1GEcdm1xRmmOQyleQOwg0=;
 fh=/GJltPe39oQcd7x5VZuAocu7g/Uu5Q0wEFcunVY0Hmo=;
 b=ZdDj5+vKryOS6mUYHuBoDpBsykkGaBO9jjVDobS+JNAoNaXbmcQKme5GZYxzvXThe6
 Bzs35kaP3VbMPuqMlOxyFKCuTulEBfUyhvwONTJ5SqW8Qf9Bw2l1wtP/B3Xo+m/3kTaB
 KZg3AjZcssb4t3aX0VmmIqyRBV9FBYBpYu7ul70LbO8XZh5FcwIBK3m7jpQg7jQEkVrs
 MzcmqAWq6NwjIQ+cd3rNMFTC+l47EOKCDqW1lFB8eh3v2Zv18Rh6koDcQP84FqBA8aSS
 I0lTp6Ww3NPu7JDPJNYRKTg58AE/fXMwy8eeu7MQJPZF0I2j4BFDAztm4K6nFlEtcYuO
 Jcwg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786634936; x=1787239736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zf4pZ/YTW6aTHH8lPr0fnw1GEcdm1xRmmOQyleQOwg0=;
 b=RSfP4Dyxe9KNS54WoqJMcK9+jxSLYC7oGwHysGWY1rPkSbRTOT32aVsjZHkElL7l17
 FdiQ36lk90zYF5FbeCev1XHK5CHQzY5QEOoQdqJc2O0K4OMq8UjaqCByWofj9xu0YhaO
 laPghLV+fcnhuH5uhqUkHP69D07GinTHdRR9qxPHhDVgMqbqrduBgzbnEnHRjiMC9L3j
 rAJpVVgYYTCZ/dBXrWcBqqgPUa3d2qCIiMMq35rRVjRptzxDn00wlsSd2oIYw4gycDTu
 CYnDefiazRFuo7E5N2TlxjdzasmBAf/FI+uchf+OfBK9PoSzWgYHyZXjAtKEj5cPNZ/n
 WljA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786634936; x=1787239736;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=zf4pZ/YTW6aTHH8lPr0fnw1GEcdm1xRmmOQyleQOwg0=;
 b=Y+7KgkGuU4A7+sGlqEIIehD4SnfSbr2DcqQRBEj+pR7p4M4pZejjmH4s9p1ad6CCBr
 AXP+7TxTBRe/E5vhNDkjaomuExXdwkFri/B7zX6q80XXA4XclMeDxWwZDuE15DitHCzd
 x1hrWDYAL4xiJLKGoqFUKbyhsAPOrNmLhEoGziXvRh5f0FdpzURV1M/1YGpKLlbIvMG9
 SpP0DKHv/8a5Q7hN5WwoJUEOFqsO+lGMYHAil8uIIMOd9yPG+/7Nd3XaFhSgD570D/uF
 nfN697PvlCAOtz10bIKShnZ4jNB5MhjxkL6N/5CuulgByfbrKP84XdN/bQ31kTErNcZY
 AOxg==
X-Gm-Message-State: AOJu0Yxdx1xkewifRnif05yPaN/dnkmb4lSiOypMJ6RNe3q5M6JC+AfQ
 B28rqi150Vlv8i9uMyINiQy6YAJfm5wOzIaZ7RJETm2Y5k2tySM/PYqBd0kTGa8FKGKHZay+S5o
 TGlqieazRzbXwC5/58Ei0BNpzss0nYDw=
X-Gm-Gg: AR+sD10QCvxfDemKudyR0C3dj+stWLvxcQzx89NHJFMehIg9bNe1DXoZXLIO8OnMMk2
 p3MJkSp9yWYo//NK7PfmcxQ2BJuOkFW+AQK5piCpvIru0U2Faeul28mm0l2S1cfqZ+N0JYXKQjv
 NZVzhb8XMx60kItRxqg1RTdr1ntM0Gh5BPV6/b1XEXZ0haGJfpcuf6FUP5b8neCrFKKp0qljzdV
 kb7z4y6A5QORQ3kioi5NGpylwvWLPO224PIKqSd3ZOjuChlbSlhjwTemNzgpKxQ5QK4vB+R+rQW
 jLiy3ctw0KWUcwyxg2VWYgB16ZNQ6MXVnUcWEIsH2GgFInK5fcoSmhpOR5Iq5DZqwOmDEvLBnfM
 8ntPE5Z6VUUzm3cFA4NOigQCnqPEk65s=
X-Received: by 2002:a17:90b:48c9:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-3931de760demr6354748a91.0.1786634935946; Thu, 13 Aug 2026
 08:28:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260813151043.1206885-1-mukul.joshi@amd.com>
In-Reply-To: <20260813151043.1206885-1-mukul.joshi@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 13 Aug 2026 11:28:44 -0400
X-Gm-Features: AUfX_mzbILyeVKjn4YQux5PkUXI7tVB_7nvngV-wY2D5CHHJ5V2vSD3zVkhqQrM
Message-ID: <CADnq5_PAAhPq=g5PDEqPKcVfVbRmxngzodu3m3JBZSMm0TTdgg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix sysfs ip base addr for 64bit in
 standalone mode
To: Mukul Joshi <mukul.joshi@amd.com>
Cc: amd-gfx@lists.freedesktop.org, mario.limonciello@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Aug 13, 2026 at 11:20=E2=80=AFAM Mukul Joshi <mukul.joshi@amd.com> =
wrote:
>
> In standalone mode the ip_discovery sysfs tree is built from a verbatim
> copy of the discovery binary taken before reg_base_init() collapses the
> 64bit base addresses in place. Decoding as 32bit there yields interleaved
> zeros. Decode base_address_64[] in that case; keep reading the already
> collapsed adev->discovery.bin as-is otherwise.
>
> Fixes: 3ee1065e9830 ("drm/amdgpu: Export ip_discovery sysfs on probe fail=
ure")
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_discovery.c
> index b5bc0d71653d..8745b0a66f1d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -1308,8 +1308,19 @@ static int amdgpu_discovery_sysfs_ips(struct amdgp=
u_device *adev,
>                                         ip_hw_instance->num_instance);
>                         ip_hw_instance->num_base_addresses =3D ip->num_ba=
se_address;
>
> -                       for (kk =3D 0; kk < ip_hw_instance->num_base_addr=
esses; kk++)
> -                               ip_hw_instance->base_addr[kk] =3D ip->bas=
e_address[kk];
> +                       for (kk =3D 0; kk < ip_hw_instance->num_base_addr=
esses; kk++) {
> +                               /*
> +                                * Standalone mode uses a raw copy of the=
 discovery
> +                                * binary; decode 64-bit addresses here. =
The shared
> +                                * bin is already collapsed to 32-bit in =
place.
> +                                */
> +                               if (reg_base_64 && ip_top->standalone_mod=
e)
> +                                       ip_hw_instance->base_addr[kk] =3D
> +                                               lower_32_bits(le64_to_cpu=
(ip->base_address_64[kk])) & 0x3FFFFFFF;
> +                               else
> +                                       ip_hw_instance->base_addr[kk] =3D
> +                                               le32_to_cpu(ip->base_addr=
ess[kk]);
> +                       }
>
>                         kobject_init(&ip_hw_instance->kobj, &ip_hw_instan=
ce_ktype);
>                         ip_hw_instance->kobj.kset =3D &ip_hw_id->hw_id_ks=
et;
> --
> 2.54.0
>
