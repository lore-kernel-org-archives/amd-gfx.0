Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AA99C36003
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 10:53:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 55CDE10E3ED;
	Mon, 17 Mar 2025 10:53:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="jek7b5wP";
	dkim-atps=neutral
X-Greylist: delayed 328 seconds by postgrey-1.36 at gabe;
 Sun, 16 Mar 2025 20:12:06 UTC
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E9310E06F
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1742155922; x=1742760722; i=spasswolf@web.de;
 bh=8/Kj3I2BsLN/9FJ15gJzCZJpW8LAFDEU+8nDaf03+30=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=jek7b5wPRsAUKksrckyQgKodyP4n2/xMi4e7cg6xEm3w7hl17pi6KZkOsmD5q6ev
 QpmEIl8dtiRGUhWUFEEiFor7mxvnfh9Hj3TyDug1V0m0TlqB7iUfA8KgVz9e2lXbb
 CCV0alkP8CdZD7CJZpTnycvJG6Detqsbmn/jfqd6fMKehSM9MyQ4jszw7ILBfSZ8T
 DpWwa+65fYvngJRyOJDG6EyNvsrApEHgCHDiK718W15eIgFWS0NvnKi5s+6r3zIdl
 hQepNXO/FneZhWRYFCroKTB5hdL211jMpRCwWnXOKh69LZ32zv9/0igTFrwjB6Qo7
 5qFu66al+LEid7qx8w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MF2kU-1u0ToP2Ney-00FgaU; Sun, 16
 Mar 2025 21:06:09 +0100
Message-ID: <6b0c9a4d840757ee54b141ed26f4e81c3e4eaacf.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexdeucher@gmail.com>, Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Sun, 16 Mar 2025 21:06:08 +0100
In-Reply-To: <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
References: <20250310112206.4168-1-spasswolf@web.de>
 <951f9d13-72e4-41c3-9ace-8639e2a9485d@nvidia.com>
 <ce940e2a-632d-41be-9f13-e5b11d49b0db@nvidia.com>
 <09131c563332c892284ec7fb4ce706996131db8c.camel@web.de>
 <9a5df5627d3d72b2a97f501dfb7d944cc1e9920f.camel@web.de>
 <fdea59fe-f570-489f-bf88-1ffd47119cac@nvidia.com>
 <414f4deb8c7670a159854006b0c410ce05a6049e.camel@web.de>
 <12d950ee-4152-4ad6-b93e-7c5b75804b1a@nvidia.com>
 <705e95cec3dc5181ca2aa73722e6b84f63f3e91d.camel@web.de>
 <20b5823e-247a-456a-bb55-d50f212a9f5a@nvidia.com>
 <a34a1ae0b1d226b1bac7d73daa24da8e5899cb3e.camel@web.de>
 <c7bb0bd1-529d-466d-9cce-abbac4b480ab@nvidia.com>
 <146277bb0ecbb392d490683c424b8ae0dfa82838.camel@web.de>
 <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
 <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
 <7866593f-0322-4fb3-9729-82366940fc85@nvidia.com>
 <a168e78b-ae27-4675-8821-0b1a2499b2b2@nvidia.com>
 <5d34bfc5109b8d104fd4f8550dd17945344f9d07.camel@web.de>
 <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
 <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
 <9be36dfab79b17e108f71d51a6ebf39073e110c6.camel@web.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2WxrHgAC6bEVnLbwBH6tFrQmLNqoXQheJCWpa4ZuAV8+PHMjCek
 U5iuuKMB7muZ/40tSSLu4wT5kJrA1CJ6B8+bPXU44R3adxIzMDlj+CNNqGzFXN/gxuYyCai
 oHIzEHRhFYSD+wVghIdbkWxW+Aljua5M7AGHp/6pQGCyAg5JEB/izuuIjEWcOPA5333XyET
 cwDLYkks5VtXErG0jBFMw==
UI-OutboundReport: notjunk:1;M01:P0:ycxGwPMauIo=;ExP72BVsC3lkDJRoaGA7YOYBehm
 nc9S39aAC6xKy7w10kt4fiF2HuobijsfmddjqgaoTd7rOZONX5Ygdf9zR8zj817f5KqToqURn
 AuG6QgDLvWARDI6BtU3i5wrv3k3248CtL1zebD3EprIs3T9Jso1jqWYTdlAGIdjEoFFqiJOfd
 2KpIzTn+6xjexBDcSzlZvbF0jIVkoDlT8D8XkEuvqHKYZ4ThzOUMylbRUtW3uJjeH1ShdI5Lv
 YO3/jXcMJwF/kHr+2Ymx1F0IS2ScYglikimgZ9pkwJHG8JX9wAkehApAUPL3/ObZjlrwrI49C
 5z/Z+s8J7BoYePnHQZDVYEt+ma98pKS0woLHfIMbp7mKETQ4HnR50dJiz9/ZArdS4oQegJ7hl
 XBbMCKcxrFSOr1UTPRJhn5q1HFRS4Uh14jpxXZfR+BDqM0g2+J+6aI7g/sS5oGr8+zjX5NqFk
 sB9H4ZxPrdAJQgrNz41t70ZfiF9YKFopqnhAscqqtxMY/3kNiodRwtGGGYCF8o/taGSZCoCZf
 6M+5rT8mUd04ZmRXhJEmMgrL+ejWGMmhIPKi6GtI7bGSQaMM400PeFk/4f8rPmPGjrjiOeOV6
 7FPyGAU5Z5XXlwJ2qP6BFDUVvifnPeffLQldZRSrRIgojxTiMTwb7aHnyiZhrXMahrF5Bpc4A
 PmGfQK3D5vy/01vkVCD4U/BaBt7gK/guf62TNZLYDmJgSZggvZsNkfON+jl8EzbmMTKzORh3M
 AK1+4WEZ1KZRv9pH8hyj728emFPVtRAG670Y5/dMVxoz12IDHGF7kY09WenwJPuA7Wr2Ts8fq
 7hJk/2kyQ5cy01ubaXPvEXagsPXAGjw7MemXs1EfhgWW3BHio8N4FTbDG8IKudLnbhV/OPvEr
 wdiecIsI78CMQ5OoOtgpfXtVUs4gT+5uxGFUTi41G1pIiPe9GIZXvElY5K0+OaPNqe8UrzGec
 /EARd58LEWUWhRZOxKhYyztv4szRp54XQlu4FGU9yc2EU12Yad1a50KeLf7OMjsksr6xVkxY6
 0GS6bpGeyAZyDw4GrDF+NR4LNRf90NEu4eLFjZvI9hOcqDDEX/SNfzfjhCosvAnOoCbO3rtuI
 Vdu7AN94MxvsDVyEafuXC1as4PeiODljiHjVAHKGCYlDSx/HhOZMCnF1K82kGNCAcj3pTwaEP
 NtPDjm+TSpoIIRGLQW2nHdJpa//0Eb7UFrf3ZWqH8z9WeO4yy5H434WZzunO40qYI5h5n1D5i
 2T1SoirMcA6QXk0YBxwdRVqL4ZiQ7GmvK0l/rabL1K1nAg6BHIS8jhpeu8Ve0Pwrf5SGNq+fK
 aspAXry/MeHEC5OrpzrFXSw86Fjn2naGfFCsviKfcKeIfpZH3vPIi2cQteDlJCCGWQPBYdTm8
 LHcilIcoVYFZio9wwsqVx1lmsIzD9JpNEBGDy1UFJ84sy8aKOFGOnEM40Gd+Vcnm8JaCWsi+S
 4eZ9yLQ==
X-Mailman-Approved-At: Mon, 17 Mar 2025 10:53:32 +0000
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

Am Sonntag, dem 16.03.2025 um 14:09 +0100 schrieb Bert Karwatzki:
> This is related to the admgpu.gttsize. My laptop has the maximum amount=
=C2=A0
> of memory (64G) and usually gttsize is half of main memory size. I just=
=C2=A0
> tested with cmdline=3D"nokaslr amdgpi.gttsize=3D2048" and the problem do=
es=C2=A0
> not occur. So I did some more testing with varying gttsize and got this
> for the built-in GPU
>
> 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/ATI=
]
> Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
>
> (nokaslr is always enabeld)
> gttssize   input behaviour
>  2048		GOOD
>  2064		GOOD
>  2080		SEMIBAD (i.e. noticeable input lag but not as bad as below)
>  3072		BAD
>  4096		BAD
>  8192		BAD
> 16384		BAD
>
> As the build-in GPU has ~512 VRAM there seems to be problems when gttsiz=
e >
> 4*VRAM so I tested for the discrete GPU with 8G of VRAM
> gttsize   input behaviour
> 49152		GOOD
> 64000		GOOD
>
> So for the discrete GPU increasing gttsize does no reproduce the bug.
>
> Bert Karwatzki

So I was thinking the reason the bug does not show on the discrete GPU is =
that
it has too much VRAM so the GTT memory is not used in this case.
In order to test this I booted with amdgpu.vramlimit=3D512. Unfortunately
initialisation fails in this case:

[  T291] [drm:amdgpu_device_init.cold [amdgpu]] *ERROR* sw_init of IP bloc=
k
<gmc_v10_0> failed -22

But using the parameter amdgpu.vramlimit fixes the problem for the built-i=
n GPU,
even when the value is larger than the VRAM of the builtin-GPU (i.e. nokas=
lr
amdgpu.vramlimit=3D4096 does not give the buggy behaviour)

Bert Karwatzki


