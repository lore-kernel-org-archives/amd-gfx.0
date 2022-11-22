Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4F4C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Nov 2022 16:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C82110E416;
	Tue, 22 Nov 2022 16:12:04 +0000 (UTC)
X-Greylist: delayed 2324 seconds by postgrey-1.36 at gabe;
 Tue, 22 Nov 2022 15:39:32 UTC
Received: from sipsolutions.net (s3.sipsolutions.net
 [IPv6:2a01:4f8:191:4433::2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C9E910E407;
 Tue, 22 Nov 2022 15:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
 Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=+NFpLSd8ScOHEVd4DHTztoyZ+UkB3J/9rUIzBb7GyY0=; 
 t=1669131572; x=1670341172; b=k9v/HSIelAbs/W+qToz4dQTNvHMGnsiZQIQuxS6OfKL4fe7
 XN3SoRP2zwCtFLeqpWr7DNkreKGwmU+4n9B55OI0AyoUWIJERoWNlq6xvSM2Yng54CfucAmWF00ke
 wf7D1qwLmm7As8HOKvc/brBKseBg4tmOI+vnq0Hi8qelUcHDMMvGNPPC5qPcVibtpbKw3F1JbOJcg
 D/OOT0n0S7NDxj8qQmjt7FiXlAzZ6UQBCNuLGH7vHpfVyxpOwrnSi1Xpc/LeOkGGgu5NLkpOyaQ1C
 m87clPyZW/z2qasBBy164STPsks0X9uoqOHaj6pW4XCe3gX6//JMQyf3wsUvI53Q==;
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <johannes@sipsolutions.net>)
 id 1oxUlH-006Ngc-2Z; Tue, 22 Nov 2022 16:00:35 +0100
Message-ID: <021efb6c9295402cf05406bb319c441c0b0229b3.camel@sipsolutions.net>
Subject: Re: Build regressions/improvements in v6.1-rc6
From: Johannes Berg <johannes@sipsolutions.net>
To: Alex Deucher <alexdeucher@gmail.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Date: Tue, 22 Nov 2022 16:00:34 +0100
In-Reply-To: <CADnq5_PvouSKugXxJXqkVeZf+kbP8+hhUKFgVALSO=MOW3jzvA@mail.gmail.com>
References: <CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com>
 <20221122105054.4062213-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2211221154280.284524@ramsan.of.borg>
 <CADnq5_PvouSKugXxJXqkVeZf+kbP8+hhUKFgVALSO=MOW3jzvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Mailman-Approved-At: Tue, 22 Nov 2022 16:11:59 +0000
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
Cc: linux-rdma@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, 2022-11-22 at 08:55 -0500, Alex Deucher wrote:
> >=20
> >    + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called=
 object is not a function or function pointer:  =3D> 94:18
> >    + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: e=
rror: control reaches end of non-void function [-Werror=3Dreturn-type]:  =
=3D> 1934:1
> >=20
> > um-x86_64/um-all{mod,yes}config (in kfd_cpumask_to_apic_id())
>=20
> Presumably cpu_data is not defined on um-x86_64?  Does it even make
> sense to build drivers on um-x86_64?

Drivers in general yes ;-)

This driver, probably not.

But the issue is that a lot of drivers "depends on X86_64" or such,
where only "X86" is the arch symbol. You could add "X86 && X86_64" to
really build on x86 64-bit only.

I didn't check this driver, but this has mostly popped up since UM got
PCI support some time ago (which I added.)

johannes


