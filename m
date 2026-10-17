Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CB24CCF2C4
	for <amd-gfx@archiver.kernel.org>; Sat, 17 Oct 2026 17:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A195710E45A;
	Sat, 17 Oct 2026 17:38:12 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC91610E407
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 17:38:06 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-702fd86d674so614086eaf.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 17 Oct 2026 10:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792258686; x=1792863486; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=a07hroGn1zcrz/OXecdL3qHRAZN/vdxJR8dNfk5xJI4=;
 b=kOzlGW8lKKMAJLfMeeavdHXIxax3Q0A8Oe7ka1v56FYz3rtYzZ1EaBGV6jH2bS0cx8
 G2oTOfUQBx3RMIUtY+H2aIlga8lYlZ3zMHx9F5YaBXzfpCUESf8tkna/Izho98qHRyM2
 De0dwC7ourS/MSRd2TPvcD6oT1r3XXWmMzz7QrMqTro7jvoU3zmo1S+wB8uer9aBhyuR
 EMz0Gr19lGW7OGaeqJB9xzxVXe5CogkAwiNjRNzidmDXG4lfmCMtPTCo+PL9j/ygmLGZ
 G1w53WlzQ/8yU5s+hJaqhgUvxeSoXzQhK/LYzXI3YMfrwCO+MPJGpng42103jYZyatB7
 OAiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792258686; x=1792863486;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=a07hroGn1zcrz/OXecdL3qHRAZN/vdxJR8dNfk5xJI4=;
 b=YrULXvcJkPRVRvJ7vuJ48ZpbYeXrKEbBh3vEIl4pLfl9ahJy49m83v7fd5xWwqUZrS
 Xw27SV8Yf2aCrHOkYxt1+W28QvykplQxC5TW/pQi8t3qkC9D+vP4zqfdlX1t7TdPEIyd
 FQAXgdQ6tI6zDJHnOp+SODsV1O1bzJ4pr16M+g2F6jE6UgnBAu1kA8NFDCNJZgAlX25j
 vrlPi9UVmnQxuAG/zPUt7VFjye8Y6rOefu6HAqODuTJtUS2r3KXNqXjv1x9IB4S3Ro6L
 Yot+928AB+1RO6qmiuN1TpkXMzicnOD8/0HKBjpeBs4hPdWIKhc0tKltN7e1nTBEQe5j
 VYwQ==
X-Gm-Message-State: AFq9FYINawhkb6tiTpy3cfToBBbiUFZEqM1wk0EREGC2k+aRawH8GZKv
 sltByH9Bibf5sAZZbcGvATUR8sAK+6dOmIIY6RVlTFjBq0YX6isTa+mD7p94nkQV
X-Gm-Gg: AYBFou2nhNC5JkkGwxKPUiaS0T9Q54eZbMBlzvzE25/jqAzgPlGJMUwmh8VHZgcRvh5
 vbIiiUI9+ll9lFfa3awKk5yn6QbhuKRvDHCGSIA8AhcDb+nTXTtgZrK90Wjde7zDw9CjEltpPOK
 V9g+Iw8Zz/KkAkSFPy0Sx0edZZxAyM2iiXR4IiT4cK6/1wFEiugUIzcfeRP2CJbQ6D7O+RnWbCw
 uU+KVJT1xeFbB/YIoWkQovMe1SSkwTITzZ3AM6Ey139qekD1dlDz60lfndWU94T7lp63QdDBwJE
 xEdQWlhFZSiSShMdWU5RJtw2FLcO1Cnw4lmWc+j284TtHHz1Z+5Rr8UpsbGKszj6kya19mVfMtS
 yQ4fFctSH3vvu4CKaTwzy8ZyEgcFhSZ10UCFqnUFhHkxJHjP/ODFS5u1GZ2ogWA2h1jOCjMksmz
 8o5kLCsDsxtmJ/fzwTuVKp9PEGs5dW8/adu/i+r27+1JYGzQYeThaCVV9+DkZbOhI6g2BgnsgaZ
 +waiDgF5Bk=
X-Received: by 2002:a05:6820:338a:10b0:6dd:696d:b245 with SMTP id
 006d021491bc7-7035738e945mr1599358eaf.53.1792258685915; 
 Sat, 17 Oct 2026 10:38:05 -0700 (PDT)
Received: from timur-max.localnet ([2806:105e:c:e386:8deb:92a3:40ef:908c])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-844d2ffbf71sm2750983a34.4.2026.10.17.10.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 10:38:05 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: contact@mikaelpelle.com
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/2] drm/amd/pm/si: Check AMD_IS_MOBILITY flag for
 PPSMC_SYSTEMFLAG_GPIO_DC
Date: Sat, 17 Oct 2026 11:38:04 -0600
Message-ID: <a2FoeEsiQmiOiZVMEFL_8Q@gmail.com>
In-Reply-To: <000801dd5dbb$2a3de5b0$7eb9b110$@mikaelpelle.com>
References: <000801dd5dbb$2a3de5b0$7eb9b110$@mikaelpelle.com>
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

On 2026. okt=C3=B3ber 16., p=C3=A9ntek 16:10:32 k=C3=B6z=C3=A9ps=C5=91 =C3=
=A1llamokbeli z=C3=B3naid=C5=91=20
contact@mikaelpelle.com wrote:
> Hi Timur,
>=20
> A quick follow-up from the same MacPro6,1 with dual FirePro D700s.
> I have now tested the fixes after they reached stock stable kernels:
>
> - Linux 6.18.57-1-lts:=20
>   both GPUs correctly transition from 300/150 MHz idle to 850/1370 MHz un=
der
> Vulkan compute load, then return to 300/150 MHz afterward.
>=20
> - Linux 7.2.10-arch1-1:
>   same result; both D700s reach 850/1370 MHz correctly under load.
>=20
> For comparison, Linux 7.2.9, before these stable backports, still kept bo=
th
> GPUs at 300/150 MHz under the same type of compute workload.
>=20
> So I can confirm that the stable backports of:
>   drm/amd/pm/si: Check AMD_IS_MOBILITY flag for PPSMC_SYSTEMFLAG_GPIO_DC
>   drm/amd/pm/si: Fix updating clock limits on AC/DC
> resolve the DPM issue on the dual FirePro D700 in the MacPro6,1.
>=20
> Thanks for the fixes.
>=20

Hi Mikael,

Thank you for testing.
I'm happy to hear that the patches are working well for you!

Best regards,
Timur




