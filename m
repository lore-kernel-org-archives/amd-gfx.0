Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF54EC44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 19:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B74910E23B;
	Wed, 15 Jul 2026 19:38:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fdwt+duP";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73B5B10E23B
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 19:38:30 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493c2c0b9a8so16744535e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 12:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784144309; x=1784749109; darn=lists.freedesktop.org;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uh5vpGQCZ/gpvdZ5t8PcF6Jkue3Cnhkh9plBmjTf53M=;
 b=fdwt+duPK79DcHND49ai+bmPLM57fq4XzIb4DtRei6ahV5jKIisc1hv6DhJNrL+z0K
 svkip58PkPwlwly0PztwlfLuZAO/W9M3GfTyywa3c0BerWaNk5je6fbS4m8rVh7uAJsq
 OLhZes/eSq+WPa6bBTpZPcs3tKC5YhA41RvYQDllzBa4rLBLLsxhcwfbKClCb1h4aebe
 ARLyx1FiFj/PEMioFhjKsqvSDZYkNeyhxgE4YDcLtGKu35VnF5Ijcuuu/VO1UbPJxhvr
 f8/o7xwoXwpPV6nJbWG8WPRGIWcwwRvkP/Y7mewdOssI4AVuE8tjlRoFo1MvS9yjabGq
 ORLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784144309; x=1784749109;
 h=content-type:content-transfer-encoding:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Uh5vpGQCZ/gpvdZ5t8PcF6Jkue3Cnhkh9plBmjTf53M=;
 b=VkvN24SkTp4R1h6W3f3/mebNoenvnEvwHHc8/9OpRp/byj2dtaYOtyDdcV9WdrKc25
 DEd/ZauZ2g+t3U/yiUb7Y6FhecTwKxLGs3BHiJsteKEDC/iNT2nrwYCTZ0qrCNW+bvlC
 dbUxFNo5Jj3/+QjOh/K+Wrx1BUvKftuQRspgFlHFhjAnS2Ea4JxXs9mSpxSR5eh4/LHu
 zeoMWhMQP33fFIajj9+bPX3qXu9wkPp86vvLzXlRH+AtLOR2rT3yXSqdlzSSBBv0Bst0
 p8tpnYEHh9wUZPkSVY8vfXeUzojlZ7GqDqlSURKRxn/e47C3V7AX1Q6++jAStVEDuFSX
 BVtw==
X-Gm-Message-State: AOJu0YwHnMsQZJKXFDrDFEFWGBoR5luXjOXl/W6y3+u/b7ausDihHAE5
 EigHK0Z8MZIua8D+CcjfJHlWCnYDIa4v6T4/NLiAH4KG59ecukmo0WInJTapYxkH
X-Gm-Gg: AfdE7cnjrM09kasqZeMTgd2BdmEoZoipRRuwdONYXouCEwxUgaxuL2tWMhcdObLujtK
 8vZybhEcHXuylwuSXvAdDkx2+R3nutLMdLVgI78oHUDxIGacz/ReXJEenf9PNh4VIZwI2cOKGfQ
 gL2M5UqFUGwlU3E2V5vnqMiQ4gR225oDh6ddawS8n6l5bZ5hXW4zhEEqKckKGD7w/ZNXJpIieWR
 3yxZX3bvH1wCldd5NzPTd9Xk1iXaKS+zjL+s7Qa0J02ad0GpaRykDsOxzdT88Jpmv5fsuI8HqSv
 r7ZDW34v5k3WI+XsQRz7YAc5yWzVhNFA/0JsIW1Ht+cat8ipoH24PYUmr1nEnbEOkegQIHoVJ5q
 kBkRHs7TwKZ8RN590s0Fg6eVta0636XSfEl5qTDojoSFd/e8xC4o5AwHky72PINcC0MHob1fmoD
 +squZ8uAyhqe6FGSDfGF3BjB2G9MDcmXnA8kCYUM1ZYH7ktymMF3PFuP+WHBsKT+d5Gw/zyxtM3
 XrPLbWFBQDlLE+j2dg=
X-Received: by 2002:a05:600c:4ece:b0:493:f8b8:7ebf with SMTP id
 5b1f17b1804b1-493f8b880d5mr182316645e9.32.1784144308719; 
 Wed, 15 Jul 2026 12:38:28 -0700 (PDT)
Received: from timur-max.localnet
 (20014C4E24CD7200F6BBA872344E1A32.dsl.pool.telekom.hu.
 [2001:4c4e:24cd:7200:f6bb:a872:344e:1a32])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464bbb0esm18858573f8f.28.2026.07.15.12.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 12:38:28 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>
Subject: Re: [PATCH 2/9] drm/amdgpu/gfx7: Refactor MQD initialization and
 finalization
Date: Wed, 15 Jul 2026 21:38:27 +0200
Message-ID: <7840022.W097sEU6C4@timur-max>
In-Reply-To: <0613d385-648a-4ef1-be31-a1174fd838b9@ursulin.net>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
 <4566110.UPlyArG6xL@timur-max>
 <0613d385-648a-4ef1-be31-a1174fd838b9@ursulin.net>
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

On 2026. j=C3=BAlius 15., szerda 10:26:53 k=C3=B6z=C3=A9p-eur=C3=B3pai ny=
=C3=A1ri id=C5=91 Tvrtko Ursulin=20
wrote:
> >=20
> >> Anyway, it looks plausible to me so assuming you were able to exercise
> >> both paths
> >=20
> > What do you mean by "both paths"?
>=20
> The two paths in gfx_v7_0_compute_queue_init. But you must of had since
> one is the normal path and the other is on reset which you specifically
> add and test. LGTM in this case.

Yes, I tested both paths. I wrote this patch because I noticed that all=20
compute queues hang after a soft reset without this.

Timur


