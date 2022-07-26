Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD873C43334
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Jul 2022 12:54:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 097E58FB5A;
	Tue, 26 Jul 2022 12:54:45 +0000 (UTC)
X-Greylist: delayed 525 seconds by postgrey-1.36 at gabe;
 Tue, 26 Jul 2022 00:56:09 UTC
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754FC10E128
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Jul 2022 00:56:09 +0000 (UTC)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsJPh01Psz4x1T;
 Tue, 26 Jul 2022 10:56:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1658796968;
 bh=XM/sSLZCdmxU7N0ibsdjeo384f6+QLdmjSl5hrtE3HY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=kWgG78BPwfOqjitCUhFJ1j7aQuatzG1Kzsf+7936A1WLUoNMph3bVIxIlABiTDJEJ
 hIIcGB/y8AFSlwe/+vhMtJcBEakfJHeQb/EPEh1G7QM8Fj1g7kmD4E4rDvBAscAEEQ
 Y9m7YoapBqwumAnrkXpPVFp4iTJcszdtuCXUjKZ3zAyIkxhYTxrIpZQ+9viWvCIJZN
 Lo+0ODKIoi8+wOoWZGyX2w81RnbtPvoDX+kaetTWOCl8t08KBgIfEZU4r9ji6GmqBD
 XC9xzCTHZvgPJML2QJUKrzkpJdrABgL2gtRQwE/S/p+qpY1A+EQDJrveHxPMK7Qwkp
 zoGf02DW07bSw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] drm/amdgpu: Re-enable DCN for 64-bit powerpc
In-Reply-To: <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
References: <20220725123918.1903255-1-mpe@ellerman.id.au>
 <CAHk-=wihON4Ytte5zLHWNQtTapUvCpkToxY06OjX-_2B+Gq6Gg@mail.gmail.com>
Date: Tue, 26 Jul 2022 10:56:07 +1000
Message-ID: <87k080bsk8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Mailman-Approved-At: Tue, 26 Jul 2022 12:54:21 +0000
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
Cc: dan@danny.cz, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 tpearson@raptorengineering.com, alexdeucher@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux@roeck-us.net
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Mon, Jul 25, 2022 at 5:39 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Further digging shows that the build failures only occur with compilers
>> that default to 64-bit long double.
>
> Where the heck do we have 'long double' things anywhere in the kernel?

There's one or two uses, but not in any code that's relevant to this
issue AFAICS.

> I tried to grep for it, and failed miserably. I found some constants
> that would qualify, but they were in the v4l colorspaces-details.rst
> doc file.
>
> Strange.

It doesn't seem to matter if you use long double or not. It's just that
if the long double size is 64-bits the linker refuses to link a mixture
of soft/hard-float objects.

The 64-bit ABI says long double is 128-bits, so the compilers that are
using 64-bit long double are either not built correctly, or we are not
passing the correct flags to them.

There's an -mlong-double-128 flag which we can pass at build time which
seems to do the right thing, I will probably add that to the kernel
CFLAGS, but I want that to get a bit more testing.

cheers
