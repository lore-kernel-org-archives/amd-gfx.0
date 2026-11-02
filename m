Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EF160865CC
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Nov 2026 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0jn4hRWZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2E7410E63D;
	Mon,  2 Nov 2026 16:24:28 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FC310E63D
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Nov 2026 16:24:23 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a35db1f202so34451035e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Nov 2026 08:24:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793636661; x=1794241461; darn=lists.freedesktop.org;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=EzVka6LiqUQDrF/m+UNfxpzpicAcWgQjDLM9NAQGvPo=;
 b=0jn4hRWZNCoAtrI1BYbkNkOPmI7nTULfL8nSunW3T/OnIhfqZyWefmaakqKyd4aX5w
 sFgIAZk57dBfsEtnnx56zD6e0JBqVIhw85J8d+R7l2zTe9eer/nfUITyFlrn13bpxNKm
 AM0tOJrKPbx4Kl8ny3crJYUzVztievglHJIt9j2oRG4avzhoRQEi9K6IRClpcCXFU6p2
 rXuSxAwLQuZM9kEfzT1pJ6GKgvdlsTn4Lgk97FZeSZObgH9cbi48NTcNXH0OKyEGtiai
 Pa9yNbdrldNPoPqY0KJkSuNlu4fgG3rUnAFumjsjOhCzU5VVeqzGNapmDse6I1Hi6ju3
 up6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793636661; x=1794241461;
 h=mime-version:user-agent:content-transfer-encoding:content-type
 :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EzVka6LiqUQDrF/m+UNfxpzpicAcWgQjDLM9NAQGvPo=;
 b=z4OpJj5lBNu0+tpOVdLyXWHt1hepihxwd7wS+8Gl6RwJdVCzsEJoQfQ1zBRx280EWo
 HnwwWpwFslBL2uOHGoR5AG/TAANGltv0qtC7n3+Kp17GWtkIM+mFEvtMf76T9f5CKeXA
 3TvMAcfRA9pOowHSv7YsN5cN/9pB379zeNV7W4pCyezTebxRYWd4MTCwz5MlP+DQVHhd
 jZMpNQdqh5mL4LX5dZWcfHNgO0xZpa2bAZpmMUDKHkTzcad81he3FVYZJlv3SnPdw03K
 TPSE9G9AnYetWSm2R5uEbI7JloYATAKgvh4S2UkcfqjIwhb7QTbYRmlVdgrYNBw4B7WX
 k0fg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz/i5FsWsRvqlcCOOer9ekxKlJXmjAOpcXvMsqSF6HgphLp+cnmfFpAvtnIcywEMWZIzlI31DSM@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJkrWniHFtkDomxX5R26cjjX7xQVsMzVNy4vCoa9k4osLwEV1Xh
 Vw3pEkCKxe0gMUGzX8TDOdEBvlcACj8JkROgcbatIgQSOv6D87Q1rUYd
X-Gm-Gg: AYBFou2Q46peLEkZexxPdw3eHWaxoQ+QTFG3Ps9omGEiUzEGvfeIgW/OT7FD3aZCFcF
 VpUtN1sCtx+BctymbWzFT1dJ7npXqKKRSa1lshlcmEmN4cU9u+YGJ+eWA9UWk1RfMom+Oz7HbQV
 gP660koKCv4xoeJAjMSo94JEw7OUseWnP0sh9ADPbkEmaWNl4QwimSR+HxF6l3eIMkBk1Vm2wJz
 WL1iACD/O6sZpf2q5om4D+LNg2M905RwvikC8MK1C01715daRKU6FM+PpJpMdFqKLo8y9Tq+irX
 wAW1CLAjUbxbjhU5dSg5YOov1A+xAaUXRSY/cu0WTxgeL0byeX15ZNz4iq6e8ZaV3KZCwwAG7P9
 VGoti+dnPYUwWkc4b+uVOcw45zeiFp9w0LV+5ZpTHSALLie14iV2aMMTxnPPC9SJtJmFaWt1IOC
 IH2dgMjXZSkPPjzmaFGnqDQKMUvGmjAj5SnGEGmDz2gkg3dKp3wDGKWF/W2joa1nedvuDD/33mq
 kwmgpueXBBMeDkUDz4N0qXrReeAI7S23fnlVXWc1WtQsxN5D7GmuN+y+8VYlyTad8gwieeUg+At
 gvqVMS3sSLBXJrITZQp0+UjFBgb3wV8p8lD/P7T+Ig4OvXGKhnGa35jqMiaNS1Han8eLWjMsJVz
 VNsLqcMf5pg==
X-Received: by 2002:a05:600c:e41a:b0:4b2:406b:f3bd with SMTP id
 5b1f17b1804b1-4b2406bf3d2mr23875545e9.23.1793636661338; 
 Mon, 02 Nov 2026 08:24:21 -0800 (PST)
Received: from [192.168.1.86] (240.red-79-154-229.dynamicip.rima-tde.net.
 [79.154.229.240]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4abeb77af8csm386470315e9.1.2026.11.02.08.24.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 08:24:20 -0800 (PST)
Message-ID: <c70939e1b39ec752697813c04eb641b21802cbb3.camel@gmail.com>
Subject: Re: [PATCH v3 01/15] drm/amdgpu: pass the device to the multi ring
 reset helpers
From: Timur =?ISO-8859-1?Q?Krist=F3f?= <timur.kristof@gmail.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"	
 <Christian.Koenig@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, Mario
 Sopena-Novales <Mario.Novales@amd.com>, "Rastogi, Manu"
 <Manu.Rastogi@amd.com>, "Zhu, Jiongyu (Joey)"	 <Jiongyu.Zhu@amd.com>
Date: Mon, 02 Nov 2026 17:24:19 +0100
In-Reply-To: <DM4PR12MB5152422F0100100566C3FBBEE36A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20261028085736.3808569-1-Jesse.Zhang@amd.com>
 <DM4PR12MB5152422F0100100566C3FBBEE36A2@DM4PR12MB5152.namprd12.prod.outlook.com>
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
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-02 at 01:28 +0000, Zhang, Jesse(Jie) wrote:
> AMD General
>=20
> Ping on the series ?

Hi,

I'm reviewing the series, just need a little more time to finish my
review and test it.

Thanks,
Timur
