Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0BDC35FFB
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 09:11:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E0DC10E9B2;
	Fri, 14 Mar 2025 09:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=web.de header.i=spasswolf@web.de header.b="e9WBZZnI";
	dkim-atps=neutral
X-Greylist: delayed 499 seconds by postgrey-1.36 at gabe;
 Thu, 13 Mar 2025 22:36:25 UTC
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0ABE810E0C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Mar 2025 22:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1741905383; x=1742510183; i=spasswolf@web.de;
 bh=UZHfDSu598HqL1JYZaRqo0hyksFnTWQ90LTcyrIig0s=;
 h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
 References:Content-Type:MIME-Version:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=e9WBZZnI6rpGVPZPeSN69PvINGVR+uKdFKR9ezxrmufoLefxy9jIzXg9zcRvv5Y8
 gQjjGKc7eioKseXKWNz8FIYRI3QJsyvYy87zme+bFlblZxE7uFvt7LS21wFPPVGdq
 a8KSxlcgs3ea/6CDOeWWjufua9OqAb8V+kjx4gDqA9uG1jdnU7oAtoUm3aOoGvJVY
 0XfBwTV9OwE5VvdeXaRCLNOd4stPQhY4bPNFIR+2tEwQyXNM1ssmSxiEjNwCyxbqu
 pXvi3F4DgkmaF56NmmcZmqMH4sNICLoEnEjC7H0u2Ho8I1ulmne2GdIKTy0MQNrMg
 6lM9LrsxMJEPspveCw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([95.223.134.88]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M4sc1-1tt8Bc3Si7-00G8ss; Thu, 13
 Mar 2025 23:22:07 +0100
Message-ID: <fa8d5e76694918bdaae9faee9648776f298f78ca.camel@web.de>
Subject: Re: commit 7ffb791423c7 breaks steam game
From: Bert Karwatzki <spasswolf@web.de>
To: Balbir Singh <balbirs@nvidia.com>
Cc: Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>, Bjorn
 Helgaas	 <bhelgaas@google.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, linux-kernel@vger.kernel.org, 
 amd-gfx@lists.freedesktop.org, spasswolf@web.de
Date: Thu, 13 Mar 2025 23:22:06 +0100
In-Reply-To: <b63b1de8-7eec-4235-b61e-e654e78543ba@nvidia.com>
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
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.55.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rj5ELexmLntZ+I/BKImxJ2NUsGXQQm8Hq6gR1qO/SPDNeJg8NQ9
 sHM7ffS84LkVEazHXNw2DXtrNrE/Jc/dDttLUOzVz16AToVD8PIJCDZKv7QsOfCpPM4mntg
 cy1yODf++W8vlKldAEhrdFtb0St5LQ+gbKqFJ5Gr9LZ0ZQ+MviyhOznAH8rrgHy1iB7qvlT
 h0/KwB6q8qzqv41j7F4/A==
UI-OutboundReport: notjunk:1;M01:P0:Z23ouQldg8s=;hmr5Ar5ClU3swGNASpm8U5kOWVi
 ttMn/G+SFtvUr3kJ+yce3VfP7haAXuLF2AtF+1o3Ik28K88DnNYz+Y2MPXxDJf252gVaXzJsM
 95nwOs23wD1aAoBJ5Ru3zHHCQsLKRQcXw9zzla6GV5PYRr6b5uJ/dbIMl+g4XE59GCYr5/Kyh
 BoXA23wYFrBbi41KQIeiCu7HIwy/GOvBhHFEroRUyXlK4vXhPDKWgORXBinDsfgmFM+tFYMgY
 s96mtWnKYOqBwLAe15s0Vq3RVNU/ZXmbfbqjO/w1PyXOBTjOXH53lfnHJnYOqUV9zZ2oa+HH1
 6pupF5MFdfAZNVL6f4SUbThl/qQrwcr3Z4rvF9pSxfuGvwbIFaMVQ++xvNqY9sMt8DuoFBfaJ
 WwpxviPhahUAWWO5pawvyK7F4k7P2CfMh4MqEW6lEdJXgRZr5112Z/x77oFJpg7mu/AhbilMa
 B43LWEkoD0t+7w4U4Dn1MPVY3JESadsSjYQ4TPTojNUYByKYeOmfZ3C2wsWiDElW699gCr8iP
 Gh2+2N9P5UG9BKqABMfb4R/iT5y+xJFp1UZmqO3leqZ2YJqyx4+RGVVNYlguxG/YgSsWihqkW
 h+yvmgeuDHKH34u+Y3+Co0fsDnrW6hJZGbTYiSycRXQOG9jdoCEAoW3MeQffV31J6bnsfK0+p
 fOYPdjgL0PUIN2Hga2I0DdMJykt+4S8+2Kl18QO8zAU0QuT99H9xV4ZJZHGSQNwscLOwFRrb9
 hSM13W8iJFFEQouTXSp1QNNjFhQ089dHuLqDfP0r29icZbNtCdL24EBfswsAwLrJwhKVpIQpV
 nq6F/cjM/oE9eua7tvXGlzwIbXRxTMbWYIAgr8ZpnUR2LsXQDGWfMG7B+xEtuFxpkW4tCRs1L
 4IDUdrNYO3hzjjACSzaKAUXUN9YYTRkLghoUvymYagYABvrB7bta2+hFY2JiJgcVc601c+vn1
 p0MEWg3iAihA0JH8gBufZzzrF3CBGPaamNJ3jsByW1ypHnKEqQX8/4Oru/H+wp0n5asRifxDf
 ZmvO/Ag4RYeFTExh1CRZvx+QZSTwmPJ7HFKuon0IFeL56ZgsBOQ3UnfpV3+F1b8JAXm6v/C8c
 IHI15qedWGz4sk5ZTBlD7tLUVYfCkld2vaMl510bH5RNaSOP3P0du202H84MBCroWsMMghcty
 4rozdXrGi4/WQGWIYqob8KURut0cYyTb+bIxXO5Gc8Alrlef3BMCQfQF6nrzwhUVg8LT0u88F
 H4PpaeMuZIYPtyMIy+G0cnz3gONkBQP+rXZxHWgaCWG73KX4QC9+WdbVZmScGNlWls2ZIHilf
 Qfw0O1fGCPtDYXkTyUZTPFDcLlkevZJ35LwY3ZXLT+NUj7TB6rCT5fVJEZRTsPpnq2Tg8p5Bw
 2dDPTTGxtx1DerxG6lMvM94nzTbxuClhCA/GuEXbpFOJpHvMsARZqAoYbNO2iq+YsqSTQ1T89
 cGSpH0Z76FsXtsRRbJ9UocGZHqzU=
X-Mailman-Approved-At: Fri, 14 Mar 2025 09:11:23 +0000
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

Am Freitag, dem 14.03.2025 um 08:54 +1100 schrieb Balbir Singh:
> On 3/14/25 05:12, Bert Karwatzki wrote:
> > Am Donnerstag, dem 13.03.2025 um 22:47 +1100 schrieb Balbir Singh:
> > >
> > >
> > > Anyway, I think the nokaslr result is interesting, it seems like wit=
h nokaslr
> > > even the older kernels have problems with the game
> > >
> > > Could you confirm if with nokaslr
> > >
> > Now I've tested kernel 6.8.12 with nokaslr
> >
> > > 1. Only one single game stellaris is not working?
> > > 2. The entire laptop does not work?
> > > 3. Laptop works and other games work? Just one game is not working a=
s
> > expected?
> >
> >
> > Stellaris is showing the input lag and the entire graphical user inter=
face shows
> > the same input lag as long as stellaris is running.
> > Civilization 6 shows the same input lag as stellaris, probably even wo=
rse.
> > Magic the Gathering: Arena (with wine) works normally.
> > Valheim also works normally.
> > Crusader Kings 2 works normally
> > Rogue Heroes: Ruins of Tasos (a Zelda lookalike) works normally.
> > Baldur's Gate I & II and Icewind Dale work normally.
> >
> > Also the input lag is only in the GUI, if I switch to a text console (=
ctrl + alt
> > + Fn), input works normally even while the affected games are running.
> >
> > Games aside everything else (e.g. compiling kernels) seems to work wit=
h nokaslr.
> >
>
> Would it be fair to assume that anything Xorg/Wayland is working fine
> when the game is not running, even with nokaslr?
>
Yes, Xorg (I'm normally using xfce4 as desktop) works fine. I also tested =
with
gnome using Xwayland, here the buggy behaviour also exists, with the addti=
on
that mouse position is off, i.e. to click a button in the game you have to=
 click
somewhat above it.

> +amd-gfx@lists.freedesktop.org to see if there are known issues with
> nokaslr and the games you mentioned.
>
>
> Balbir Singh
>
> PS: I came across an interesting link
> https://www.alex-ionescu.com/behind-windows-x64s-44-bit-memory-addressin=
g-limit/
>
> I think SLIST_HEADER is used by wine as well for user space and I am not=
 sure
> if in this situation the game is hitting this scenario, but surprisingly=
 the other
> games are not. This is assuming the game uses wine. I am not sure it's r=
elated,
> but the 44 bits caught my attention.

Stellaris is a native linux game (x86_64), the one game (MTGA) I tested wi=
th
wine worked fine.

By the way, the warning
[ T8562] WARNING: CPU: 14 PID: 8562 at mm/slub.c:5028
__kvmalloc_node_noprof+0x2fd/0x360
that appeared in the dmesg I sent you is caused by the upgrade of mesa fro=
m
25.0.0 to 25.0.1. (I'm still bisecting ...)

Bert Karwatzki
