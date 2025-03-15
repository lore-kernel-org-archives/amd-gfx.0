Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51882C28B28
	for <amd-gfx@archiver.kernel.org>; Sat, 15 Mar 2025 17:40:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFBE210E294;
	Sat, 15 Mar 2025 17:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cFgPs97f";
	dkim-atps=neutral
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E217210E291
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 17:40:34 +0000 (UTC)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-2ff6ce72844so167940a91.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 15 Mar 2025 10:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742060434; x=1742665234; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LOk77kqi4lkW0/kdysAwjj2qu3m2pFn+y+VjVbY7SLs=;
 b=cFgPs97fB03LjtIE7XVb7TXj94Si2b3KnhFE6Bu+9s/nHj0yoFtxYBdii2tSXqa0Cs
 tyeKTwcEWUwlzGNaT26xCxWZtuNLUBh4N3xe28IsOs5s5Qv+jyv9yLKLSd+rzwX7wek5
 pbvmNdYtq6aWN2lS1jDvH3qN63ILYOcuPnYI95RPKQal0xAZRf/V5voI1/bMPzkW/7A5
 bp4263g7baR3nJ6GVCY0EtnW0Lp0nIWwibF4CKZBNCr/CVezT2rKC/XgoXEluN3dWbC6
 iVgS+vfUul7Fzj0KZHWMPAPlb5cnmPWCYu7Lqlp3ZafuukV8rSxxupyafBuWb0vpP+HK
 ehZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742060434; x=1742665234;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LOk77kqi4lkW0/kdysAwjj2qu3m2pFn+y+VjVbY7SLs=;
 b=AmyL6d6KRiaubXvszOv6ja7+aCcXOyeEjV5qqAYdbLZdeO9gyvZEhavxGtwdgNdp5Q
 ZB8N9c4/DTfdRbCSO+A0Fn4mRDaG8b0tWgb6gpg/zgKNNN+tea4Q+4mDeUp7HUmDooAv
 oMINXvGEtLIYi6t3HEmN3UAZtNQNM9/GnimvBRQFII6byc9HUE6j2+R/Eu1drYlMJpp4
 v0hREWmPK6SExwcPL4QhW+/9brsfsfWmNeAAbQ7ivyIaGdrUqpYqxsGcK06eViRsvuc2
 cq3EAXDkCQOSLmGTVKVlftKhjjDRkcBZZv5SqbVzZDSC18N/Wn4ypXWvMSfbwg9WCcD6
 XYSA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmO7Llw4lEV1yETlsnJ/RPeX+TNM0fnT+qBTkNrTOxW72f60XRSBCyZAzmt7ys/h42W2WfH5LE@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTJ3n5vJ4P/jcsWpPH6R3kyjRz/D4ijCY3cr3MHkLLJKihHhTq
 b2pjkuP5VH4IZlpMrYnY+LcRqE0Tq+1UyJzqHXpZ2QpPQ9DwljMEQD1do7BoNjK9tYlDSMaNZg3
 ooLqCDsmtwHczspA5G5ZPyESFpW01iA==
X-Gm-Gg: ASbGncuNXn7nwCRyu+5xTp30wZjSSDGNjJAwmeQ7nJDXjxMWMB8CH+pcxr4Q3qV1nK7
 CfeM0IjDXBR2zSrXgFHe1qBVUSj/qVcxb+ADl5UEGPynEMiI49o4iA3tIWLmQpGPlyn/c7IvN2R
 lZjvul/Q/By/FrMTLl8pbV1tG3Jg==
X-Google-Smtp-Source: AGHT+IGbXrWrcmJPxnATtMDNxKyBe1McY0iT1NSSp2Cb8noHkhFTSF1Dx9Jsi52xd48mr+ny3QYYGDaJI+EW2EEFqDU=
X-Received: by 2002:a17:90b:4d8d:b0:2fe:b77a:2eba with SMTP id
 98e67ed59e1d1-30151c5dfd6mr3302403a91.1.1742060434249; Sat, 15 Mar 2025
 10:40:34 -0700 (PDT)
MIME-Version: 1.0
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
In-Reply-To: <551b9797-20d6-4bfe-b54c-84dd7aae7794@nvidia.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sat, 15 Mar 2025 13:40:22 -0400
X-Gm-Features: AQ5f1JqczJSund_yZ9Gc1DJvfi3qHEiMuoBL3Yl78fyXIr_IqcnGk9bdrBiCIdM
Message-ID: <CADnq5_Pvmxa10dJWYjajwxG-0Y_oxhL6wS6NsG2F0dmcJS6o8A@mail.gmail.com>
Subject: Re: commit 7ffb791423c7 breaks steam game
To: Balbir Singh <balbirs@nvidia.com>
Cc: Bert Karwatzki <spasswolf@web.de>, Ingo Molnar <mingo@kernel.org>,
 Kees Cook <kees@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Peter Zijlstra <peterz@infradead.org>, Andy Lutomirski <luto@kernel.org>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Fri, Mar 14, 2025 at 8:42=E2=80=AFPM Balbir Singh <balbirs@nvidia.com> w=
rote:
>
> On 3/15/25 01:18, Bert Karwatzki wrote:
> > Am Samstag, dem 15.03.2025 um 00:34 +1100 schrieb Balbir Singh:
> >> On 3/14/25 17:14, Balbir Singh wrote:
> >>> On 3/14/25 09:22, Bert Karwatzki wrote:
> >>>> Am Freitag, dem 14.03.2025 um 08:54 +1100 schrieb Balbir Singh:
> >>>>> On 3/14/25 05:12, Bert Karwatzki wrote:
> >>>>>> Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Singh:
> >>>>>>>
> >>>>>>>
> >>>>>>> Anyway, I think the nokaslr result is interesting, it seems like =
with nokaslr
> >>>>>>> even the older kernels have problems with the game
> >>>>>>>
> >>>>>>> Could you confirm if with nokaslr
> >>>>>>>
> >>>>>> Now I've tested kernel 6.8.12 with nokaslr
> >>>>>>
> >>>>>>> 1. Only one single game stellaris is not working?
> >>>>>>> 2. The entire laptop does not work?
> >>>>>>> 3. Laptop works and other games work? Just one game is not workin=
g as
> >>>>>> expected?
> >>>>>>
> >>>>>>
> >>>>>> Stellaris is showing the input lag and the entire graphical user i=
nterface shows
> >>>>>> the same input lag as long as stellaris is running.
> >>>>>> Civilization 6 shows the same input lag as stellaris, probably eve=
n worse.
> >>>>>> Magic the Gathering: Arena (with wine) works normally.
> >>>>>> Valheim also works normally.
> >>>>>> Crusader Kings 2 works normally
> >>>>>> Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
> >>>>>> Baldur's Gate I & II and Icewind Dale work normally.
> >>>>>>
> >>>>>> Also the input lag is only in the GUI, if I switch to a text conso=
le (ctrl + alt
> >>>>>> + Fn), input works normally even while the affected games are runn=
ing.
> >>>>>>
> >>>>>> Games aside everything else (e.g. compiling kernels) seems to work=
 with nokaslr.
> >>>>>>
> >>>>>
> >>>>> Would it be fair to assume that anything Xorg/Wayland is working fi=
ne
> >>>>> when the game is not running, even with nokaslr?
> >>>>>
> >>>> Yes, Xorg (I'm normally using xfce4 as desktop) works fine. I also t=
ested with
> >>>> gnome using Xwayland, here the buggy behaviour also exists, with the=
 addtion
> >>>> that mouse position is off, i.e. to click a button in the game you h=
ave to click
> >>>> somewhat above it.
> >>>
> >>> So the issue is narrowed down to just the games you've mentioned with=
 nokaslr/patch?
> >>>
> >>>>
> >>>>> +amd-gfx@lists.freedesktop.org to see if there are known issues wit=
h
> >>>>> nokaslr and the games you mentioned.
> >>>>>
> >>>>>
> >>>>> Balbir Singh
> >>>>>
> >>>>> PS: I came across an interesting link
> >>>>> https://www.alex-ionescu.com/behind-windows-x64s-44-bit-memory-addr=
essing-limit/
> >>>>>
> >>>>> I think SLIST_HEADER is used by wine as well for user space and I a=
m not sure
> >>>>> if in this situation the game is hitting this scenario, but surpris=
ingly the other
> >>>>> games are not. This is assuming the game uses wine. I am not sure i=
t's related,
> >>>>> but the 44 bits caught my attention.
> >>>>
> >>>> Stellaris is a native linux game (x86_64), the one game (MTGA) I tes=
ted with
> >>>> wine worked fine.
> >>>>
> >>>
> >>> Thanks for the update! I wonder if there are any game logs. If you ca=
n look for any
> >>> warnings/errors it might be interesting to see where the difference i=
s coming from?
> >>>
> >>
> >> In addition to the above, does radeontop give you any info about what =
might be
> >> going on? I am also curious if
> >
> > This got me to test stellaris and Civ6 using the discrete Graphics card=
:
> > 03:00.0 Display controller: Advanced Micro Devices, Inc. [AMD/ATI] Navi=
 23
> > [Radeon RX 6600/6600 XT/6600M] (rev c3)
> >  (with DRI_PRIME=3D1) and here the problems do not occur.
> >
> > This is the CPU-builtin GPU, which I normally use to play stellaris as =
graphics
> > aren't very demanding, here the problems occur when using nokaslr
> > 08:00.0 VGA compatible controller: Advanced Micro Devices, Inc. [AMD/AT=
I]
> > Cezanne [Radeon Vega Series / Radeon Vega Mobile Series] (rev c5)
> >
>
> Aaah.. this is strange, because the only movement in iomem was for the di=
screte GPU
>
> From your eariler message
>
>  fee00000-fee00fff : pnp 00:04
>  ff000000-ffffffff : pnp 00:04
>  100000000-fee2fffff : System RAM
> -  3a7e00000-3a89d2f56 : Kernel code
> -  3a8a00000-3a8e31fff : Kernel rodata
> -  3a9000000-3a912a5ff : Kernel data
> -  3a969c000-3a97fffff : Kernel bss
> +  d32200000-d32dd0f56 : Kernel code
> +  d32e00000-d33231fff : Kernel rodata
> +  d33400000-d3352a5ff : Kernel data
> +  d33a9c000-d33bfffff : Kernel bss
>  fee300000-100fffffff : Reserved
>  1010000000-ffffffffff : PCI Bus 0000:00
>    fc00000000-fe0fffffff : PCI Bus 0000:01
> @@ -104,4 +104,4 @@
>        fe30300000-fe303fffff : 0000:04:00.0
>      fe30400000-fe30403fff : 0000:04:00.0
>      fe30404000-fe30404fff : 0000:04:00.0
> -3ffe00000000-3fffffffffff : 0000:03:00.0
> +afe00000000-affffffffff : 0000:03:00.0
>
> I am hoping someone from amd-gfx to chime in with known issues of the dri=
ver
> and nokaslr or help debug further.

I'm not aware of any problems with nokalr off hand with AMD GPUs.

Alex
