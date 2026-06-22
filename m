Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CF2CD4F26
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2026 08:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3C6010E9EE;
	Tue, 23 Jun 2026 08:07:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="FWSCwcec";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E86D10E4A2
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 05:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1782107043; x=1782711843; i=natalie.vock@gmx.de;
 bh=V4eeF2b39Ld4bgohXAFNOBWICpZf+cb7+dEGi8HIlIE=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=FWSCwcecCl0xwBG5OziTXE3b58TA6TyOEaneXAOLmuIV8C/Qjs3naG/I/e+MkRfz
 N2DVhZiVuJ5yzB61mV+S1YIVJhtRIHLKfZcEUiiGFQ5dNsDmRqqy65qKY8vVWEdKM
 hGJ4jkhG8qckl8lxVw/aNlfvmT+vA8CdTbwv1TATqTucnbmR3fgSekzIQQIKDC4qh
 R1yz5mH37J/izcc4mdYt9gRRMc9StK4vjO6wFaldj/2mtNucg8eJHsPEq2ps8kDp5
 2DC9wBZ2d8eeHy+rKGUzr2iQAql0NQIZNVu7bfvkU1RlwJtsZvC0nRGWkPlzPh4Sj
 BOu1KSH2vFI4VH9DQA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MKsjH-1wsErG0txd-00HmQ3; Mon, 22
 Jun 2026 07:44:03 +0200
Message-ID: <c084c555-e4f4-48a6-9fad-175932acda01@gmx.de>
Date: Mon, 22 Jun 2026 07:44:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION 7.2] drm/amdgpu: ~275 SDMA jobs per sparse VA bind
 since 4cdbba5a (RE Requiem 90->4 fps)
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
References: <CABXGCsOuCXr4R+WW60KNuWNS2MqzE9w6iv-t_ykbwmhqDSABAQ@mail.gmail.com>
Content-Language: en-US
From: Natalie Vock <natalie.vock@gmx.de>
In-Reply-To: <CABXGCsOuCXr4R+WW60KNuWNS2MqzE9w6iv-t_ykbwmhqDSABAQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0/QIqRsPZJqjDy+IBxH9SWtLNw3ysKmza+JqsC258tsrbp6Niji
 E+vIMi76Qt12PRBIZfCrYHmhUYjLwlOkPbftGdqmtaVT5l3O9FXt9ThqnaAbsxH5enwBzzC
 T/6il34S1C0X2/1jdw8PQXOi6DD2EwULNqMc2JOrhcr7Fm8G7vGBn0y0QX/s61I07t0YAPI
 zQzdIQJBvlMtwrMPdxeBw==
UI-OutboundReport: notjunk:1;M01:P0:GtGJNbys+ZU=;uk+pU/Sbj3Cyby32VZoCQBGleZa
 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
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:07:15 +0000
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

On 6/21/26 22:55, Mikhail Gavrilov wrote:
> Hi Christian, Alex,
>=20
> git bisect points to
>=20
>    4cdbba5a16aa ("drm/amdgpu: restructure VM state machine v4")
>=20
> as the first bad commit (its parent tests fine) for a severe
> interactivity regression.
>=20
> It was merged during the current 7.2 merge window; it is not in any
> released kernel yet and will first appear in 7.2-rc1.
>=20
> Symptom: Resident Evil Requiem (re9.exe under VKD3D-Proton, RADV, RX
> 7900 XTX / Navi31, gfx11) drops from ~90 to 3-4 fps the instant the
> camera moves; still scenes are fine. The previous bisect point
> d352990bcaab is smooth.

I already fixed this in a patchset[1] that should be on its way - seems=20
like it didn't make it into rc1 at least?

Christian, Alex, can you make sure that the first patch from that set,=20
"drm/amdgpu: Only set bo->moved when the BO was actually moved", is=20
included in a -fixes PR for 7.2?

For the record, I intentionally did not include a Fixes: tag in this=20
patchset, because the commit was not merged anywhere but=20
amd-staging-drm-next at the point of writing, and the same commits in=20
amd-staging-drm-next and upstream have different SHAs. AFAIU, this also=20
prevents me from telling regzbot that a proper fix is underway for now.=20
Not sure if there's a workaround for this?

Best,
Natalie

[1]=20
https://lore.kernel.org/amd-gfx/20260529153051.973261-1-natalie.vock@gmx.d=
e/
