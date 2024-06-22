Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6D2CC27C53
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Jun 2024 15:01:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 641BA10E141;
	Sat, 22 Jun 2024 15:01:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="GqA3nY9a";
	dkim-atps=neutral
X-Greylist: delayed 323 seconds by postgrey-1.36 at gabe;
 Sat, 22 Jun 2024 14:32:54 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BAB10E0A7
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Jun 2024 14:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1719066773; x=1719671573; i=markus.elfring@web.de;
 bh=OU3x5Yr/XJbHSekpCJjHsOQ0enVAT5S79Ev31+LNqlc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=GqA3nY9akprB5IWR5uRtfZsQqzKM+/mw3t0MkOmBAIZ8rZr3mlJbXq4Sv0KIsArw
 t9nJxY/aot52AY35NZwbEU8whmWLqHRl8e91ouBtI1FHkj4hALA8L056w0BtDkt+I
 Op5knoGvfczh0UW6LVx2Eul8u/Gz/g9msJLMOy+72sdKoItGQkyG2ICVsYCpHwPky
 /Mr3kM25YMn6PS/nNJLQIllHCAFOonshuGD+VKjzzPuPz58BgEFFEg47OP+Y8n4js
 VJ0mOFG69UhZB8Z7xHcB0svhShUSZn9VON4ZdSu3qddX5crONv6sBj/au1RwWqRbl
 ywNgR5igE35GzvLsWg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MdwNW-1ssQmY0mBS-00lnt8; Sat, 22
 Jun 2024 16:27:08 +0200
Message-ID: <0032d02a-b5ae-452e-b26e-14dc7f091e6b@web.de>
Date: Sat, 22 Jun 2024 16:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Chen Jiahao <chenjiahao16@huawei.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 Guchun Chen <guchun.chen@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <20240622082219.1876200-1-make24@iscas.ac.cn>
Subject: Re: [PATCH] drm/amdgpu: fix a possible null pointer dereference
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240622082219.1876200-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:UEl50w9SKYfEiP4nvrpAPA/v1Qhr4FoGAsA/ycA54SOmxbzGd/H
 axwN+KFtDoIptrKRtu76J2DyX5IDAGzPlrG89mVteXjbymSd4zMntXERGDnV4agdj3ynHeL
 Wh0P1qvUAjv3fR3A6UMsfroWT60pkAR56evrkpxSvzRDNpQNxGMqcMuw5ixWPr0SS6+LLDh
 ymINEHB7UHz5sEgWogZ4w==
UI-OutboundReport: notjunk:1;M01:P0:d90mcyrlDTM=;QL9yX7Juzi1ez2MObGYvgYtfnY2
 DHHFdwzIqsmKe9xFNlEctQHgAqTlr69oTyW+IBbohOjeGFsXBCGvGUyDrgKNhzIPU2JTeH719
 JJ6x/LRmI18EgppsT+q4Su74bxhJJ/ZVlO3il0VwEFXFJx8Xq4gEO5UbMhTmx+wKnXb+eTodt
 TN1NzHSkCmeP/HI6vTHNtqg+U/ZTH8/M81RLUpm1FWGpT5dllY2+jFUuUkSJbhYaao4ewXMfX
 1N9gi2dhGfFGx3WownTApMhk7uLMMricxwlkAkRZBrWkiS9Lgsbs32uU9fEuqt1cyXNMERis1
 C5jViInxhf0a4V17VCBlCwDeV5+OwOdvlwBZCEn/j8ElNM/2T/mzGweq1VqQeUzTcM/FdTsh1
 vko7yT4lbSqSNIpd4VUy+yGhW1iClcXVOQbNaSWYIhwEvgpH8SZKlTQPz7PedIhlxOfwJBoJM
 vQi7nX033i6rsaC4ocAxUMzjeTWKmLC7flooSijQ/IR2/O1THJzaYWW+1kNjGtc4W1/yIXsc4
 nEbV2CYQaRzqEMxNGcKEeEmt2I9OEgAH4dEgLCptGdbJkv4fdDbRJIru6jDaRDt0o0a4B2hkc
 e566Nq6PUwHsuyZfLza2S8sC4PxnDbhgJ34nWTOIUy8lJTgbu2qUD0/DPzt9REGzyfT6KR4JO
 Yu9S/YlSFcop4jPoCKfx0UY9g7p/Fbbk7rd0CvbtjI+EP3MThrlptN1JwhfdoHBaWBgKkN2bB
 L07mGrnLP3kleQO4mlBfkRwGaOX3IkfOPtUBI62LOOf1z0yvhfEnv5RYVFKGial1/9l9lTy14
 25PXXoBOLnI6KDIQCNcZtzw07yVGVOMgCGb5GaPB/jOO0=
X-Mailman-Approved-At: Sat, 22 Jun 2024 15:01:11 +0000
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

> In amdgpu_connector_add_common_modes(), the return value of drm_cvt_mode=
()
> is assigned to mode, which will lead to a NULL pointer dereference on
> failure of drm_cvt_mode(). Add a check to avoid npd.

Can a wording approach (like the following) be a better change description=
?

   A null pointer is stored in the local variable =E2=80=9Cmode=E2=80=9D a=
fter a call
   of the function =E2=80=9Cdrm_cvt_mode=E2=80=9D failed. This pointer was=
 passed to
   a subsequent call of the function =E2=80=9Cdrm_mode_probed_add=E2=80=9D=
 where an undesirable
   dereference will be performed then.
   Thus add a corresponding return value check.


Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D) accordingly?


How do you think about to use a summary phrase like =E2=80=9CAvoid null po=
inter dereference
in amdgpu_connector_add_common_modes()=E2=80=9D?

Regards,
Markus
