Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153C6C43458
	for <amd-gfx@archiver.kernel.org>; Sun, 12 Jul 2026 17:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A12C210E2F5;
	Sun, 12 Jul 2026 17:44:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MqbbY26x";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7633310E2F5
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jul 2026 17:44:35 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so13235645e9.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 12 Jul 2026 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783878274; x=1784483074; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ts2/Ui2RA7r5jQzEKYw0O8Cs+J08h0WmcXc6RVOw9DI=;
 b=MqbbY26xLBTJmNBlOCaLcuPeULwKKO3ilq6TReewyiZpe6WaHmtTj2mTqZpTeRRy9W
 moMRVtwkPFr6fScljOQU1YgEu433oGoXYuNG9Uf2P0Yx5GNTu1V2zg6qbe9G6qsnv+Cw
 hpomKsyQMoijAsTrKqUp+yK41UAxkD3nOeLErJ2IdsjLfagJ3wyscpZXzVhEuNWHG4tt
 mc9IpMalGcHytvZAEFCdoArgcxXUXbu4pnG2Y3xm5zLSRlTz4Mi7DqYyuTmtsIdQpDnP
 Ex43fIkawyO37xh/ugghx3bVOLNfTALbQ9YhXUHvEI9hHuHfIPkISCwMYkCgZp3/5qC/
 rsSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783878274; x=1784483074;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ts2/Ui2RA7r5jQzEKYw0O8Cs+J08h0WmcXc6RVOw9DI=;
 b=DX3D11wRTeQiB2+SQe/cPkIgyeLzXdGaXolZhD1tvCCA0kFjc90X+To2t2ErXL/GaG
 xWoPEVpIY5Z3cy9zRN4SLwDHprW2brkPx/K4pXFVqOfEjtYu5aPZQhmwHKrUj+VT/+Ze
 nutZcUQ64UbuWLCYpqi7MQd7X7P5r8YX0LppjOsbHarNxcs0jnB8XZMm0En0zyYwyzn6
 r3ebGKXgsldSXwTr9xHuPpG4mNUHj4dow5Chy+oEuXYo8mGg+BwtInwoK3yhwODSMeTb
 yO6oVQtIR/viaJKP6y3dN4xPzo5q0f1J1xDwbqxZW0TBg22385uNgZKE5xn5rC/PBuYy
 sUOA==
X-Gm-Message-State: AOJu0YyMhKjOm1A5mnzvBGO6OFf/rqnMd0O+gUv1LMBA6XF7or3uvzzf
 G0zAAbvh4hQD4CZNkG7RLbwsDzz81LsjsnwvyvWPNkXyODFM+shrFwrm
X-Gm-Gg: AfdE7cm0weVz6d9nrfL5DFrQemfaOwxlmKZOswV84Sk9YM9y2RWRXe2dEVBlvBMH/aJ
 syMVpQg6Bo3D8SyfdnnsT8CKM8IbnThNUZAiqBrir+HpjxsZzGDpuCJ6eOeV6Z2b7KlNOdRZVEE
 U3InbB4kgJgolDIvM5ey9Zp0jKA7LAkUnDDVjqDnPkkYyvN5xL1AXjzsVVDs7MpdCTWUH4tM/CK
 IWnvz5sxwhZ+Ng6TpHfpHxjBbXpt46p1kMVmSf9vZ7IBZBsBB+JNi9aE2H2fTAMKd2qJfOQjQhe
 eB3L+h9pJNmQJDdgt4yq7JAMUy1c6KR80g78zRwKP+/Nq6iXC54GqZeqsDWiLaEW5yW8Wdx+T3/
 2Ak+6HQE7EK/3y/GdXTh7Dm8jbEZRSrNBlMl3tVlpQEjaaCorWi+QqH2U7x6Cd+HmBx+NHQCNwx
 z5wCc2bDck+RT3TBlO0dI5dd6oILXu3H//CiBDwRxAdaiEO9duAp/1/sTa59AkRK3OmVeNM7rhX
 YL4wH8R6yzEIA1V
X-Received: by 2002:a05:600c:190c:b0:493:b91c:6bf with SMTP id
 5b1f17b1804b1-493f8818dedmr62779825e9.18.1783878273785; 
 Sun, 12 Jul 2026 10:44:33 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24E4950000951480CE1AD54B.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:9500:95:1480:ce1a:d54b])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb670a41sm288828895e9.0.2026.07.12.10.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Jul 2026 10:44:33 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 Lionso Alejandro Pacheco Vacacela <lionso@murena.io>
Cc: amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>,
 Wenjing Liu <wenjing.liu@amd.com>
Subject: Re: [PATCH 1/2] drm/amd/display: Fix preferred link rate for NUTMEG
Date: Sun, 12 Jul 2026 19:44:31 +0200
Message-ID: <2230825.9o76ZdvQCi@timur-max>
In-Reply-To: <178379850751.8410.12007342378134020217@murena.io>
References: <20260529090909.13206-1-timur.kristof@gmail.com>
 <178379850751.8410.12007342378134020217@murena.io>
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

On 2026. j=C3=BAlius 11., szombat 21:35:07 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Lionso Alejandro=20
Pacheco Vacacela wrote:
> Hi,
>=20
> I independently hit this regression on a desktop Kaveri system and can
> confirm this patch fixes it:
>=20
>   - AMD A10-7850K (Kaveri, DCE 8.1), MSI A68HM-E33, VGA monitor on the
>     onboard output (NUTMEG DP-to-VGA bridge)
>   - Debian kernel 7.1.3 (amdgpu.cik_support=3D1): VGA monitor receives no
>     signal from KMS takeover on; dmesg shows
>     "[drm] enabling link 2 failed: 15" (DC_FAIL_DP_LINK_TRAINING).
>   - Applying just this patch (1/2) on top of v7.1.3 restores VGA output
>     with DC enabled: the link trains, the CRTC comes up at 1360x768@60,
>     and the fix survived three consecutive reboots.
>=20
> Tested-by: Lionso Alejandro Pacheco Vacacela <lionso@murena.io>

Thank you for the testing!
I would appreciate if you could verify that the second patch also works wel=
l.

>=20
> Two notes:
>=20
> 1. The Fixes: tag references b74322eea36b, but that hash does not exist
>    in mainline =E2=80=94 it looks like an amd-staging-internal id. In Lin=
us'
>    tree the offending commit is:
>=20
>      a62346043a89 ("drm/amd/display: Fix coding style issue")
>=20
>    It would be good to correct this before the patch is pushed so the
>    stable tooling can resolve the dependency.

As far as I remember the regression hasn't made it upstream yet when I made=
=20
the fix, so the hash didn't exist in Linus's tree yet.

>=20
> 2. Since the offending commit shipped in v7.1, could this be annotated
>    Cc: stable@vger.kernel.org # 7.1.x (or nominated for 7.1.y once it
>    lands in mainline)? Every Kaveri/Kabini/Mullins system with a VGA
>    monitor loses display output on release kernels.

Agreed. Alex can you please backport this to 7.1?

Thanks & best regards,
Timur





