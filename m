Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69356C43334
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Jul 2022 19:43:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB7A48B3B2;
	Mon, 25 Jul 2022 19:43:30 +0000 (UTC)
X-Greylist: delayed 558 seconds by postgrey-1.36 at gabe;
 Mon, 25 Jul 2022 19:43:30 UTC
Received: from raptorengineering.com (mail.raptorengineering.com
 [23.155.224.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358DF8A345
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Jul 2022 19:43:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id E1E9237CDA30A2;
 Mon, 25 Jul 2022 14:34:11 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id VnwW3Pumlutw; Mon, 25 Jul 2022 14:34:10 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 657C637CDA309F;
 Mon, 25 Jul 2022 14:34:10 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 657C637CDA309F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
 t=1658777650; bh=C6eQ56WoqflhVshYvw4eSCbTOWmWQugcnRK1KwC4InQ=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=HUXCmnoHrk+82zDVSN5TwrZtJv5I32HBsm1W/0ygtdInl+yif0P4tia7Sd5JAJRPU
 yulkymOoGGK7dA9UI8YmyA5VSuDRN1JJjoR3zzEIZDjsweTlVG5bWsddAOn3MbNmWo
 OfLJgjUHcP5wIl4ettt6QsLNsTiDjIz4SB4rD9wA=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
 by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id DNoUORfc-qsk; Mon, 25 Jul 2022 14:34:10 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
 by mail.rptsys.com (Postfix) with ESMTP id 3BA9737CDA309C;
 Mon, 25 Jul 2022 14:34:10 -0500 (CDT)
Date: Mon, 25 Jul 2022 14:34:08 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Message-ID: <1446417444.13111032.1658777648586.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
References: <20220725123918.1903255-1-mpe@ellerman.id.au>
 <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC103 (Linux)/8.5.0_GA_3042)
Thread-Topic: drm/amdgpu: Re-enable DCN for 64-bit powerpc
Thread-Index: bYJinp50nUzyW/1gBugq0G+Et27Ikw==
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
Cc: Dan =?utf-8?Q?Hor=C3=A1k?= <dan@danny.cz>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 amd-gfx <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexdeucher@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux@roeck-us.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



----- Original Message -----
> From: "Linus Torvalds" <torvalds@linux-foundation.org>
> To: "Michael Ellerman" <mpe@ellerman.id.au>
> Cc: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Alex Deucher" <alexd=
eucher@gmail.com>, "amd-gfx"
> <amd-gfx@lists.freedesktop.org>, linux@roeck-us.net, "linux-kernel" <linu=
x-kernel@vger.kernel.org>, "Dan Hor=C3=A1k"
> <dan@danny.cz>, "Timothy Pearson" <tpearson@raptorengineering.com>
> Sent: Monday, July 25, 2022 2:19:57 PM
> Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc

> On Mon, Jul 25, 2022 at 5:39 AM Michael Ellerman <mpe@ellerman.id.au> wro=
te:
>>
>> Further digging shows that the build failures only occur with compilers
>> that default to 64-bit long double.
>=20
> Where the heck do we have 'long double' things anywhere in the kernel?
>=20
> I tried to grep for it, and failed miserably. I found some constants
> that would qualify, but they were in the v4l colorspaces-details.rst
> doc file.
>=20
> Strange.

We don't, at least not that I can see.  The affected code uses standard dou=
bles.

What I'm wondering is if the compiler is getting confused between standard =
and long doubles when they are both the same bit length...
