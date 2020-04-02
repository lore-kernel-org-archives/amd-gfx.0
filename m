Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.9 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87255C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 13:11:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DCAC2078B
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 13:11:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bl+KjIUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DCAC2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FF7B6EA89;
	Thu,  2 Apr 2020 13:11:24 +0000 (UTC)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B18366EA54
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 11:11:58 +0000 (UTC)
Received: by mail-il1-x133.google.com with SMTP id p13so3180442ilp.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Apr 2020 04:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=FByvmPmS2hfnwA4iOonQ+/pRM9sgV4fwlgr6fSLola4=;
 b=Bl+KjIUeUQHO8NIQ5vzQiOqtNYrZ8h1tQkcwD5Z7IPXvGAcYlWdtPdfNsZ5tUOAIkU
 PHQ00lyaGmECW8fzLobQNUxYKXzYSKu/mDMuliiLwgRDeNgeKKWWTZ2ETkwDqjHkn7jl
 Q95RZ5FsNVea36xF0H9dIwFG5qSbT4Iu47gPPfBgFaMd1PXvVxqNYoLjIqlwrDrlLY/C
 o1nnpcnX8VbQX6Y5ppf2wzDhrlg6Xb/3H/YvnaruV3dSQxxY06MOPiAi/Xm+S0Ghp0kq
 AX0MJEol3ReTanRRjgQxtByZL7NKWuxWilQeMQyHs/DOpLwJHkezRIZP1AuxbLGx7IIC
 ASeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=FByvmPmS2hfnwA4iOonQ+/pRM9sgV4fwlgr6fSLola4=;
 b=OOOLO87X9dZsDX9JMl4pudnQfSiNYR76ZYxFK4pZ/IZ99qpueLLbyJPL5vKATVUiQ2
 5BBqJHQKNB/R7Ab9cgGQPZhQPh6XIdhFTJqmziz0qgYnBlWl5+XDBknBK+MWj/ls4Ha3
 SKGmwWIOddQqIXbox9W+w3QN2Gn1bqxWmnIdwYc+Fu23VaGmrTsmERxQ7Dl1rituo2Ie
 ZsXACx/owOjgzoJEQm8AeuBX2rYM/MthjCxyTtTMstOlF349Lc6dKVVRk4Z3YjJ6a29g
 cLRDj/iqiLULLFfnHLbK8IXQSyM7DwRcXjjvsJPhuVBpnh5pxecuZB+QfIwZvfCaPUvD
 tGUA==
X-Gm-Message-State: AGi0PuYvOnYRUkP7fQ0HJVRUgUepCly57tiy+zYzuAAiOaL2NjLcECv3
 kEu81USKmYqo3CAf3eBrDycGnWQIrf6YIwpAoDLWoFTom/M=
X-Google-Smtp-Source: APiQypLDd2sMNhReIXrrQmebA2vK5IglOIYLTnOHO59YnAYlF+goI/jm1yaRRMLvMpxslh46GM8MdQCcx6podH01h+w=
X-Received: by 2002:a92:d785:: with SMTP id d5mr2606425iln.207.1585825917712; 
 Thu, 02 Apr 2020 04:11:57 -0700 (PDT)
MIME-Version: 1.0
From: someguy108 <someguy108@gmail.com>
Date: Thu, 2 Apr 2020 04:11:46 -0700
Message-ID: <CAE6bd30xsbCNyyV6bjc7u-4cfLi5Zr4yCWGH=XeX31GKvz_9_Q@mail.gmail.com>
Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE)
 with Ryzen 3700x?
To: amd-gfx@lists.freedesktop.org
X-Mailman-Approved-At: Thu, 02 Apr 2020 13:11:23 +0000
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
Reply-To: someguy108@gmail.com
Content-Type: multipart/mixed; boundary="===============1640372378=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1640372378==
Content-Type: multipart/alternative; boundary="000000000000803d8505a24cde14"

--000000000000803d8505a24cde14
Content-Type: text/plain; charset="UTF-8"

Hello! I saw Clemens Eisserer email regarding MCE errors with his RX 570
and 3700x, and I like to add to that list of MCE spontaneous reboots as
well.
This is my configuration:
-Ryzen 3900x + Noctua D15
-MSI X570 Unify (latest agesa as of writing)
-DDR4 3200mhz 32GB kit
-Sapphire Pulse 5700 XT
-Corsair RMX 850 Watt
-Arch Linux with kernel 5.5.13
-Mesa 20.0.3
-Early KMS enabled

I've had this system up and running since November 2019 but initially with
a Nvidia 1060 and Windows 10. Everything was running smoothly. About a
month ago I switched back over to Linux after purchasing my 5700 XT as my
initial plan was to go back to Linux. Since returning I've experienced
multiple spontaneous MCE reboots. All happened while I was playing one
particular game, Warcraft 3 Reforged. The MCE event is the following:

kernel: mce: [Hardware Error]: Machine check events logged
kernel: mce: [Hardware Error]: CPU 1: Machine Check: 0 Bank 5:
bea0000000000108
kernel: mce: [Hardware Error]: TSC 0 ADDR 1ffffad66d6fe MISC
d012000100000000 SYND 4d000000 IPID 500b000000000
kernel: mce: [Hardware Error]: PROCESSOR 2:870f10 TIME 1585120217 SOCKET 0
APIC 2 microcode 8701013
kernel: #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 #12 #13 #14 #15
kernel: mce: [Hardware Error]: Machine check events logged
kernel: mce: [Hardware Error]: CPU 15: Machine Check: 0 Bank 5:
bea0000000000108
kernel: mce: [Hardware Error]: TSC 0 ADDR 1ffffc1196eb6 MISC
d012000100000000 SYND 4d000000 IPID 500b000000000
kernel: mce: [Hardware Error]: PROCESSOR 2:870f10 TIME 1585120217 SOCKET 0
APIC 9 microcode 8701013
kernel: #16 #17 #18 #19 #20 #21 #22 #23

Initially I figured it could be ram so I performed the usual test with no
problems. Also tested with standard JEDEC as well and eventually received a
MCE during Warcraft 3 reforged. After consulting with a few friends I
decided to try a different power supply to no avail. I then bit the bullet
and bought a brand new 3900x. I also cleared CMOS before getting my new
3900x and after. All cpu values are on auto with no PBO or manual
overclocking. The only fancy is the ram. Yesterday, after owning the new
3900x for three days, I had a MCE while I was playing Warcraft 3 Reforged.
I have tested other games but none of them caused a MCE or any crashes /
freezes for that matter. World of Warcraft, The Outer Worlds, Stellaris,
and Counter-Strike: Global Offensive.

As the same with Clemens, using the same decoder he
used, MCE-Ryzen-Decoder, from github, it reports the MCE to be the
following:
Bank: Execution Unit (EX)
Error: Watchdog Timeout error (WDT 0x0)

One thing to note is I haven't received it during desktop usage. Only in
Warcraft 3. I do have desktop compositing in both Xfce and KDE disabled and
always have. Both of which used, tested, and received the MCE's during
those sessions. I have noticed a pattern with the MCE crashes with Warcraft
3. They always happen during a GPU load drop off or increase transition. By
that I mean when exiting a match to return to the lobby, or loading a map
and when it switches from the loading screen to the match itself is when
these MCE's happen. The entire screen quickly turns black, everything is
hard locked, and then after about a minute or so the machine reboots on its
own. It hasn't happened yet while in a middle of a match session, sitting
in the lobby or at the main menu screen. Its consistently been during a
transition. My theory is that this could possibly be a GPU hang from
switching from one power state to another power state. With the GPU
hanging, causes the CPU to stall, and thus a MCE. The GPU hanging could
explain the quick solid black screen as well as all output is stopped. But
I'm really just assuming here form my own observations from my limited
understanding. Possible reason why this triggers in Warcraft is because the
other games have few moments of switching power states heavily. The Outer
Worlds, World of Warcraft, Stellaris, and Counter-Strike Global Offensive
all keep a constant high load on the GPU and the match sessions are long.

From what its worth, I've had no major issues in Windows 10. The only
quirks where initially a few TDR's that recovered from alt tabing out of
most games with Google Chrome running. Disabling hardware acceleration in
Chrome fixed those TDR's while alt-tabing out of games.

From searching, the way I found this mailing list report, I've found quite
a few reports of people talking about receiving MCE's that isn't the
typical first generation MCE's reports from 2017 involving Ryzen.Where
those where fixed by disabling c-states, ram, and changing power supply
current from low to typical. These ones within the past year appear to all
have a AMD GPU in common. I did notice a few with Intel CPU's as well
paired up with a AMD GPU.

Any feedback would be greatly appreciated.

--000000000000803d8505a24cde14
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"au=
to">Hello! I saw=C2=A0Clemens Eisserer email regarding MCE errors with his =
RX 570 and 3700x, and I like to add to that list of MCE=C2=A0spontaneous re=
boots as well.=C2=A0</div><div>This is my configuration:</div><div>-Ryzen 3=
900x=C2=A0+ Noctua D15</div><div>-MSI X570 Unify (latest agesa as of writin=
g)</div><div>-DDR4 3200mhz 32GB kit</div><div>-Sapphire Pulse 5700 XT</div>=
<div>-Corsair RMX 850 Watt</div><div>-Arch Linux with kernel 5.5.13</div><d=
iv>-Mesa 20.0.3</div><div>-Early KMS enabled</div><div><br></div><div>I&#39=
;ve had this system up and running since November 2019 but initially with a=
 Nvidia 1060 and Windows 10. Everything was running smoothly. About a month=
 ago I switched back over to Linux after purchasing my 5700 XT as my initia=
l=C2=A0plan was to go back to Linux. Since returning=C2=A0I&#39;ve experien=
ced multiple spontaneous=C2=A0MCE reboots. All happened while I was playing=
 one particular game, Warcraft 3 Reforged. The MCE event is the following:<=
/div><div><br></div><div><div>kernel: mce: [Hardware Error]: Machine check =
events logged</div><div>kernel: mce: [Hardware Error]: CPU 1: Machine Check=
: 0 Bank 5: bea0000000000108</div><div>kernel: mce: [Hardware Error]: TSC 0=
 ADDR 1ffffad66d6fe MISC d012000100000000 SYND 4d000000 IPID 500b000000000<=
/div><div>kernel: mce: [Hardware Error]: PROCESSOR 2:870f10 TIME 1585120217=
 SOCKET 0 APIC 2 microcode 8701013</div><div>kernel: #2 #3 #4 #5 #6 #7 #8 #=
9 #10 #11 #12 #13 #14 #15</div><div>kernel: mce: [Hardware Error]: Machine =
check events logged</div><div>kernel: mce: [Hardware Error]: CPU 15: Machin=
e Check: 0 Bank 5: bea0000000000108</div><div>kernel: mce: [Hardware Error]=
: TSC 0 ADDR 1ffffc1196eb6 MISC d012000100000000 SYND 4d000000 IPID 500b000=
000000</div><div>kernel: mce: [Hardware Error]: PROCESSOR 2:870f10 TIME 158=
5120217 SOCKET 0 APIC 9 microcode 8701013</div><div>kernel: #16 #17 #18 #19=
 #20 #21 #22 #23</div></div><div><br></div><div>Initially=C2=A0I figured it=
 could be ram so I performed the usual test with no problems. Also tested w=
ith standard JEDEC as well and eventually=C2=A0received=C2=A0a MCE during W=
arcraft 3 reforged. After consulting with a few friends I decided to try a =
different power supply to no avail. I then bit the bullet and bought a bran=
d new 3900x. I also cleared CMOS before getting my new 3900x and after. All=
 cpu values are on auto with no PBO or manual overclocking. The only fancy =
is the ram.=C2=A0Yesterday, after owning the new 3900x for three days, I ha=
d a MCE while I was playing Warcraft 3 Reforged. I have tested other games =
but none of them caused a MCE or any crashes / freezes for that matter. Wor=
ld of Warcraft, The Outer Worlds, Stellaris, and Counter-Strike: Global Off=
ensive.</div><div><br></div><div>As the same with Clemens, using the same d=
ecoder=C2=A0he used,=C2=A0MCE-Ryzen-Decoder, from github, it reports the MC=
E to be the following:</div><div><div>Bank: Execution Unit (EX)</div><div>E=
rror: Watchdog Timeout error (WDT 0x0)</div></div><div><br></div><div>One t=
hing to note is I haven&#39;t received=C2=A0it during desktop usage. Only i=
n Warcraft 3. I do have desktop compositing in both Xfce and KDE disabled a=
nd always have. Both of which used, tested, and received=C2=A0the MCE&#39;s=
 during those sessions. I have noticed a pattern with the MCE crashes with =
Warcraft 3. They always happen during a GPU load drop off or increase trans=
ition. By that I mean when exiting a match to return to the lobby, or loadi=
ng a map and when it switches from the loading screen to the match itself i=
s when these MCE&#39;s happen. The entire screen quickly turns black, every=
thing is hard locked, and then after about a minute or so the machine reboo=
ts on its own. It hasn&#39;t happened yet while in a middle of a match sess=
ion, sitting in the lobby or at the main menu screen. Its consistently=C2=
=A0been during a transition. My theory is that this could possibly be a GPU=
 hang from switching from one power state to another power state. With the =
GPU hanging, causes the CPU to stall, and thus a MCE. The GPU hanging could=
 explain the quick solid black screen as well as all output is stopped. But=
 I&#39;m really just assuming here form my own observations from my limited=
 understanding. Possible reason why this triggers in Warcraft is because th=
e other games have few moments of switching power states heavily. The Outer=
 Worlds, World of Warcraft, Stellaris, and Counter-Strike Global Offensive =
all keep a constant high load on the GPU and the match sessions are long.</=
div><div><br></div><div>From what its worth, I&#39;ve had no major issues i=
n Windows 10. The only quirks where initially=C2=A0a=C2=A0few TDR&#39;s tha=
t recovered from alt tabing=C2=A0out of most games with Google Chrome runni=
ng. Disabling hardware acceleration in Chrome fixed those TDR&#39;s while a=
lt-tabing out of games.</div><div><br></div><div>From searching, the way I =
found this mailing list report, I&#39;ve=C2=A0found quite a few reports of =
people talking about receiving=C2=A0MCE&#39;s that isn&#39;t the typical=C2=
=A0first generation MCE&#39;s reports from 2017 involving Ryzen.Where those=
 where fixed by disabling c-states, ram, and changing power supply current =
from low to typical. These ones within the past year appear to all have a A=
MD GPU in common. I did notice a few with Intel CPU&#39;s as well paired up=
 with a AMD GPU.</div><div><br></div><div>Any feedback would be greatly app=
reciated.=C2=A0</div>
</div></div></div></div></div></div></div></div>

--000000000000803d8505a24cde14--

--===============1640372378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1640372378==--
