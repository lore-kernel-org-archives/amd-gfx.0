Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F908C021AB
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Feb 2025 14:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110AF10E8AC;
	Wed, 12 Feb 2025 14:08:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=markus.elfring@web.de header.b="B2CafJ+1";
	dkim-atps=neutral
X-Greylist: delayed 316 seconds by postgrey-1.36 at gabe;
 Wed, 12 Feb 2025 13:40:11 UTC
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6C7C10E276
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Feb 2025 13:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1739367610; x=1739972410; i=markus.elfring@web.de;
 bh=IJpXWBH0NGGKrYEeXnn9LivG+hfjpqHbcrFfOBiO3zs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=B2CafJ+1luU11w3HZ2HH23wX92ULWfxxPd55w4dfFRGaCera/yRosZDMFbIti7KD
 l/v+TW53ILwN6DUbPGJNM2E7yXiIhxBbFOKNWNjRBfWwolGk/mo5f4Bdh89NtAOCK
 +Mj3mZakwGtEqvJQcaGnzPVOqjkYr9SxkjfU8MO4GjCbpHeQMYenH8rClDSy9ibqg
 f89Z/gbXBoH9L/2kcLzZfuVsRnp7eOxNiHBcnMhRzVJawxpiVZ4tPk/em4tG+UXoE
 5XyJNgzDrYLra5flkRIW1cN02hiLY2OhxrNzBzh5fYQMGnzTVOIEpLMuGOl5Y03Xs
 JTc71BgaHokdIksX7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.11]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N79NA-1tIprg0n9A-012ZCp; Wed, 12
 Feb 2025 14:34:40 +0100
Message-ID: <82e2c0f3-6cb7-425e-bc68-923f6d0d5b35@web.de>
Date: Wed, 12 Feb 2025 14:34:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tao Zhou <tao.zhou1@amd.com>, Xinhui Pan <Xinhui.Pan@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>
References: <20250212070302.806-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH] drm/amdgpu: Remove redundant return value checks for
 amdgpu_ras_error_data_init()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250212070302.806-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cWJedd82uv0Epg92CPpPp3225yjZ//OUtDWkiqg6LCifP3RO6n1
 pDnGZyjNHVPzcH/A88Rv3MTYzodPxsoqf9/vmfxrHdJxe+uR6w0wCfDgV4X9HXkiBzRG+am
 Ujo0JA2ERuQ3e58QjEtuGWmY/DQFDVgWS6ipBod3AS5VIXWJFDtu7VMyoAC9Y/WdyLse4ta
 rv6wTzLJSggGYUSuzVg1w==
UI-OutboundReport: notjunk:1;M01:P0:Kfvatd2RIoA=;kCADDR+mlLHzCixM98sVyy7c2/C
 WhWB8GRcp2Q34pSAcfQ9EyDT22LsYqRlUHBfNBKSuWFjU0CWDhr1atMuwr9tEnW1Gqt325msQ
 CBTXY7WlVzPof2RPtFLiykmGtvA9QE/Kj/B0C9f4KgZZmC8yYB1m0Sjp5i69SyAh3S+2LwGEb
 nVYtm3Zo0Ui1R/fs9CxGJzqO/xMVhNeGHTCMvUxsqAL3pEzPXWpxWFCsWU2MsgslsCyPt7+Ax
 jGP6SEaAGVuBkSzu1wZg/NgoPM7XhTcjU7IKYwx83UOoJr7+Nhot2WCsdPql+aT4SI1j86PsF
 UogSgy9hwpSaqo2AU1Ia1K0eVhvsMsEZV7jYZynVKGpHJ/Qw6M5+pbds7I4TuOmh9t61hNmye
 fr3eYmCnD3InPdOucrq70QwtpqutK1Iysk+dfpxbuHQeRnn69t9Zp8v6uEt5HVp6nZ+gz7MPD
 CADHuaZnmI8jWSgMk19GUw1RYZV3GPxi9tANO5jHMhb9gUiTSxnwSTKFwSoECCsWw60tDsgxw
 w/lkYvkByRDWsM9GMIbmGotgO4QQThVf8Nh/fBf+BHsgwbzzt7hXNW4oHQne/8svpIluTf38K
 Ff6D5umYwE6x4jFzF2pRBFVCAmKQJjoeacoO9iSFtcPOkUPDLjYSrsCjIkTFv5oI6RNGSUelS
 in5gMlAiOBp0KmE62JyI/u5Yx1/BNVJbMlJDkWAgViD/bFhxxn6Njv/nGhGFHmo2JMd92rfJZ
 xXhnQVcfD1BY2UFcuk1r9VuGHHdni8CTltPe6EhzmSvBVDGYeZ8KxkV/fysume0GKSd0JEvix
 8JLwRwMUMdzVRhkaipM1ymcA2NTy4UlU8O7sFB7FgjlRiQVDw9ENt0J2r3ag3Z/tj8WKO3kX/
 Ur0x/IfRV5CsFhaGjGl8g3aoFXJXVuhEdPgi18Wn2WkAXqQ3GrY4QJQvp8p1WT1CTeUtEpCfc
 XofUe2H+Hgl6l6aYC/2UMkTqFwFtfN4Ydk5KIvfDTgYbD9BWzO+/DdZ/12bb/yt3Ke5Dakp1z
 hbHG6Du3mNv5Igm2b80PyS3LEcb0t9rfZso4VNiGTHQwW46jZo2S1JQH3vm1X5U1YYQFearyx
 j3JQ5CyDHLV2B0fSWVo8+rn6e6XTB+4oJWwsHWXmDnhhHPDy67lXDO0Q9o2t8rsibdRTbtx0G
 AcxugwljmYj/oGrHqljVOiuLA7bzVwHQZ9eMnK5sfNeXBfE4WGHpftY02j8Kmgn1uPMTARXMV
 bRR/sNIzGO2UNs3ipaU6H8PdYhj/PtPGe82t9BHsQXhWf8eB9ZdqWY2f6HjqiIDRbog/cJdL5
 /ch/bO5rvduUY35ZuNg6kVcEo+cmntS47bGRE17MXk2DwEbZAnghC/V+jQRC1R38I+pLE+nP7
 AG/h3Tz3xpxL3JdsJ42HFNM7+aZGPI8+hHFdZc2V1N+7nCyOi1bqYn6fD2SI7gEqN25MQw6d5
 P8q3JBIQtJGvCyJY5BZCf4qZe4kQ=
X-Mailman-Approved-At: Wed, 12 Feb 2025 14:08:23 +0000
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

> =E2=80=A6 This patch changes its return type =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc2#n94


> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>

How good does such an email address fit to the Developer's Certificate of =
Origin?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc2#n440

Regards,
Markus
