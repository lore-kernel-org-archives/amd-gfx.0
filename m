Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B8A0C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 19:36:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 155B710E65D;
	Fri,  5 Jan 2024 19:36:26 +0000 (UTC)
X-Greylist: delayed 351 seconds by postgrey-1.36 at gabe;
 Fri, 05 Jan 2024 19:28:30 UTC
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AA910E67C
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 19:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1704482906; x=1705087706; i=markus.elfring@web.de;
 bh=HUSZWsUiGQOC/YkUR9iqXdqwdp4kixzaBeZcE5ri/Gw=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:
 In-Reply-To;
 b=qJk+Vl3mWD5j4DUcnvJjni4/BVSBpD4N7cCBneKnIDcarbGptZkqlBiEC1+4HG+G
 6RXyBfjx36A2+LnH6YMr9GSNBiYcu3qmM/pB6yF3vT4uxrZlNnc9ZRwOpZq86qg44
 jIKLijMJ/eUOpIANKXDuziHbhK+ccaE1tHgW4WlJsGuKb45dvteu3leqagwGcVHax
 9P8f9Tg+SrX/oGT1hmjtBrJjQaQdDS32m4iWWBIiFjIIllFXjp0QCZ5kH27BPvqrK
 b15kVHJqj8Vuq3J5zLvvYN2ugRNWQfGoD58OuNSCuWuUsWuqnsh05g8CVGiWvy+AU
 BGhaThN+xZ/J+wh/Sg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MW9vi-1rg8aG29tK-00Y4pr; Fri, 05
 Jan 2024 20:21:22 +0100
Message-ID: <34068514-27e5-4faf-9b82-2a25bdce9321@web.de>
Date: Fri, 5 Jan 2024 20:21:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] drm/amd: Adjustments for three function
 implementations
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Alan Liu <HaoPing.Liu@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Bhanuprakash Modem <bhanuprakash.modem@intel.com>,
 Candice Li <candice.li@amd.com>, Charlene Liu <charlene.liu@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
 David Tadokoro <davidbtadokoro@usp.br>, Eryk Brol <eryk.brol@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>, hersen wu <hersenxs.wu@amd.com>,
 Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, Jun Lei <jun.lei@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mikita Lipski <mikita.lipski@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Stanley Yang <Stanley.Yang@amd.com>, Tao Zhou <tao.zhou1@amd.com>,
 Tom Rix <trix@redhat.com>, Victor Zhao <Victor.Zhao@amd.com>,
 Wayne Lin <Wayne.Lin@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, YiPeng Chai <YiPeng.Chai@amd.com>,
 Zhan Liu <zhan.liu@amd.com>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
In-Reply-To: <2258ce64-2a14-6778-8319-b342b06a1f33@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:7BEoYkau02QTSNEGbr+lcjHZLdsk00FLyCbaxSUukTKrCYX15Hr
 J/M0C0rCpFuqzOWWas0eRRHRRo6pz2a0sVdU5glBU5fHOxUsaAQiiJ8oycLsVI+KmBX+V3V
 3IgW3hUvw972A1pyu8KyvOfdI0J9j552K4rahvu9wJEQAr2Q7ivnaZsdXraHkLemcN6y7/C
 PC3hJ3gE78VaioUesvBKg==
UI-OutboundReport: notjunk:1;M01:P0:RyIhR/iOQpQ=;WR/yssHpYKlS5/dBGySTRIvPCq2
 Qt7Q4vrX0GqfeKXy5ciQWw14S0JLD3KVNSLObcqaF6j9udhtDM14QtkV6Z13iyhZDVJYXVtkU
 QWKtR+lUUOtPUu+mM1N/tqd4MgUD979+WneHt/ISR+f+8J/ZzD8hxhElgo9ngcfj4rkMy9x6B
 oRKkSF7Z332cXz1epwOU+N1zcsztg1KwO//LWlv8l49gE1SPENhpvniQkPw7Jvi0xIMT7dOTh
 OmyIuDciTHHQE8hsdJ7j7TZU+qBg0hcYFjkeVOgcOhOQ8bDNkzeK2s5VfPSeJd0Tjl/uhd+xH
 r+z8PnvooiAXtT0JJFnI4W9XR/otR3cmzhzDrX7EA/ykv8yM5fMryPzTM6j0pLykK/IzXLWJu
 QFHHovQ6aSspSmHzGmVvvF2iHXp9AuDr362gtJYhmMzl5TlKTFIwscHtWuDRc12xxYKwZrOfe
 FQC5/pAhyCaQs95QqM0wlhiP8zOaI0UjoQWW5eZytaNROLiRRS6R5kWO5VWUfTQiKEiNb7kex
 pFM19JAr65pYyq9qFdpyXIf3r9tX8S8AYaS3eFGgFFYDH/egCe9M0TsNjMJuQxS7pLVEb/R/d
 MeoxnKsKHbhe9znw91tQbZJY6xD2IB1SIQfiIPIsAaSW9G1prZmDXFc1V15v7UXcjqSaaQF4b
 XX92uANEDxkA4pxUFaHlG0KKgZNEl14H343b/RKhJBS9hQqaapzTdW7eamXuW0jzfuR8+rDnP
 qoHoCRa+nBdXNb2YgewgKYAH2H8LcPbpJYA2UmaM/Ovh/U4vhI7xrcP2v5iATDGClHWXuORhn
 niQ/7o3Nx4CfUu/o8AkEszywUCg1FalP02rmwe30sGhMaloUbQ3hO+U+htxEyBVPyss5cuYr2
 zuOb0TYJZ6uAAIieBblOi+mx/rMjePKx5CQRLOHz8np2RmJ/1p/C1z9z9tHIfw2hbgNptwdSU
 dSP+Yi9xq9/FOgHo5wCzg6WrtjM=
X-Mailman-Approved-At: Fri, 05 Jan 2024 19:36:25 +0000
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
Cc: LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

> Date: Tue, 11 Apr 2023 14:36:36 +0200
>
> Some update suggestions were taken into account
> from static source code analysis.
>
> Markus Elfring (5)
>   amdgpu: Move a variable assignment behind a null pointer check in amdg=
pu_ras_interrupt_dispatch()
>   display: Move three variable assignments behind condition checks in tr=
igger_hotplug()
>   display: Delete three unnecessary variable initialisations in trigger_=
hotplug()
>   display: Delete a redundant statement in trigger_hotplug()
>   display: Move an expression into a return statement in dcn201_link_enc=
oder_create()
>
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c       |  3 ++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 19 ++++++++++---------
>  .../amd/display/dc/dcn201/dcn201_resource.c   |  4 +---
>  3 files changed, 13 insertions(+), 13 deletions(-)

Is this patch series still in review queues?

See also:
https://lore.kernel.org/cocci/2258ce64-2a14-6778-8319-b342b06a1f33@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-04/msg00034.html

Regards,
Markus
