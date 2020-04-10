Return-Path: <SRS0=F+/f=52=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C68C2BA2B
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 06:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD14B20757
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2020 06:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CcoTMR1Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD14B20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 215C96EC6B;
	Fri, 10 Apr 2020 06:55:43 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 184046EC6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2020 06:55:42 +0000 (UTC)
Received: by mail-pl1-x62e.google.com with SMTP id ay1so405229plb.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 09 Apr 2020 23:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=2dGegw6ltTfsirqxbkTLKKLb9AV3EyHBXirKOMv7eu4=;
 b=CcoTMR1QcQud19G4GwLdCeIgShb2s+FPkcZ7XfnvGnPA/R83zP0cRztMAuZTIZlSeG
 TFWjTKptOpqwXU5Tu630hqdocRYArw3QhEaQncnTn3CFdev2kU/yD2PXCGOXa8EPWRYv
 0Ww2h8R41B6D3um6rqBmiaD2RGfHiBJSoCkOyKrek5lUmZOmGe7S7OOfwpciDjTxa0wZ
 r+cEhJ0bIdeYrlTvwypFrSnDVIgCu05ZCcW4YvWQ1kNvwEnu1xfIOoP69I+VXA98rwDN
 XiyGt4CgFBySUP0GUGgRRXwPD9V4SbGMmYyWhy5zisGapj4f2/SoV7/h5BeG68+IVhv8
 viIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=2dGegw6ltTfsirqxbkTLKKLb9AV3EyHBXirKOMv7eu4=;
 b=lV+cHVWgs3mzma+60cSGhc01AO7l7xpVCoAPe4aasl6Skrk5hQyLYTWNYlTzH96FVe
 5I9QI4HHzRMgD0Df/IKPpOcEO6nH7D2zizYCyKcrpSfZ3ERtj6eDSSijFpObwW3ySQ7Q
 waCRrOU1HKWUhoMV98xotJMd85yybjB2XHUcni/mSGFkRs4RmI97invJe1hb1KuDEuwx
 mUK0T3d2VHLJUCttaS+/cD79KFit1AoOVNOZD8y3bcPrnos2UxDh+VSuadZ/DdzVLK83
 E6SFhiRGXAauQVN/br4V3u8ycLyGBDe2aBvvlYg4Qb5jBi7B+1J/MLGNvFYys1DEAy4r
 iY/w==
X-Gm-Message-State: AGi0Pub13nted8sn5vgPYyXvJ6aqt5k2dhq2tpNmV7rheJml69j7PzJi
 6dl2U7L/UieGOWht4AF5uCQcCeCvvf8QJaOd6cuv8OEh
X-Google-Smtp-Source: APiQypJTjFX74K6t2bvqEtNagU3tJfOIgLHLJ1vqfoEUEyz5u9zUym5B/gBMSi+vmzgYehzWzo1wO1giXYa6zHveaCA=
X-Received: by 2002:a17:90a:368d:: with SMTP id
 t13mr3581714pjb.175.1586501741332; 
 Thu, 09 Apr 2020 23:55:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAE6bd30xsbCNyyV6bjc7u-4cfLi5Zr4yCWGH=XeX31GKvz_9_Q@mail.gmail.com>
 <CAFvQSYRiYxEOmyxhx726fFNGKy9KX=sE=vmdraW0_PyQvSwq9g@mail.gmail.com>
 <CAE6bd33O_ivJa9kQHAnp-_GZDagena==FZgfYs=_nYJc6m56CQ@mail.gmail.com>
 <CAFvQSYRnfAKCU0MHqwstHqgA4YTWvfCQ1SrsURbee=kEuP7a2g@mail.gmail.com>
 <CAE6bd32OwckMGcKLZvX5StOFqOFNx9nUGdNAJvbSzgUHkjma3g@mail.gmail.com>
In-Reply-To: <CAE6bd32OwckMGcKLZvX5StOFqOFNx9nUGdNAJvbSzgUHkjma3g@mail.gmail.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Fri, 10 Apr 2020 08:55:29 +0200
Message-ID: <CAFvQSYTXiEPCHFGZhMm_cUF1Tix2bQt45eoW+BT=v2R4QS1Dhw@mail.gmail.com>
Subject: Re: Possibility of RX570 responsible for spontaneous reboots (MCE)
 with Ryzen 3700x?
To: someguy108@gmail.com, amd-gfx@lists.freedesktop.org
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
Cc: "Bridgman, John" <John.Bridgman@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Someguy,

I've been running with accelmethod=none and llvmpipe for opengl now
for over a week (more or less using only the display engine of my
rx570) and haven't experienced a single MCE during that period.
However, statistically, it will take 1-2 additional weeks to be sure
this is not a coincidence.

This seems to confirm your observations (as well as the reports in the
reddit thread) that the GPU seems to play at least some role when it
comes to the MCE caused reboots.

@John: Could it be the 3rd gen ryzen has some issues which are covered
by windows driver workarounds?
Are CPU errata data sheets publicly available?

Best regards, Clemens

PS: While it does seem to solve the reboot issue, it causes degraded
desktop performance as well as tearing when playing videos.
So I still hope I don't have to live with this forever.

PS2: AMD support respond after some delay stating the MCE actually is
caused by the watchdog timer.

Am So., 5. Apr. 2020 um 04:41 Uhr schrieb someguy108 <someguy108@gmail.com>:
>
> How has it been going since you limited hardware acceleration? Any improvement?
>
> On Thu, Apr 2, 2020, 11:13 PM Clemens Eisserer <linuxhippy@gmail.com> wrote:
>>
>> Hi,
>>
>> I also had the impression this issue triggered by power-state changes.
>> First I suspected CPU power state transitions, but now more and more
>> reports pop up mentinioning exchanging the GPU solved the issue (or in
>> your case it started when switching to an AMD gpu).
>> However I've already tried to limit power-states using the
>> /sys/-Interface as well as custom feature masks provided suggested on
>> the kernel bug report.
>>
>> Your theory regarding firefox and compositing might be right, so this
>> is what I did:
>> - Switch from Glamor to "none" acceleration for Xorg (glamor
>> translates 2d drawing commands to OpenGL)
>> - Switch Firefox from WebRender to Software-Rendering
>> - Disable KDE composition manager
>>
>> Only time will tell...
>>
>> Best regards, Clemens
>>
>>
>> Am Fr., 3. Apr. 2020 um 03:39 Uhr schrieb someguy108 <someguy108@gmail.com>:
>> >
>> > Hi Cemens, I responded to that bugs report about my findings! I do
>> > wonder since yours is happening at desktop, do you have compositing
>> > enabled with your window manager? If my theory, as noted just based
>> > off my limited understanding and observations, is correct about it
>> > revolving around power states, having Firefox playing a video with
>> > hardware acceleration enabled and desktop compositing could be causing
>> > back and forth swings with power states. Which could be the culprit
>> > with the hangs.
>> >
>> > I also formed some of my theory from the long debacle of AMD's Windows
>> > driver quality. As these hangs sound awfully similar to what Windows
>> > users have been enduring for almost all of 2019 and some parts of
>> > 2020. As noted with me, I had TDR's in Windows while alt-tabbing with
>> > games until I disabled hardware acceleration in Google Chrome. And for
>> > good measure I disabled most animations and compositing effects with
>> > Windows UI. As I like to play most of my games in a Window. Like no
>> > more shadows under windows and such. Though I do know some are Navi
>> > specific.
>> >
>> > On Thu, Apr 2, 2020 at 7:12 AM Clemens Eisserer <linuxhippy@gmail.com> wrote:
>> > >
>> > > Hi Someguy,
>> > >
>> > > Your findings sound very familiar, my machine is also rock-solid
>> > > running Windows-10 - most of the MCEs happened for me with low-load
>> > > situations but firefox playing youtube in background.
>> > > First I didn't care that much - but now having experienced corrupted
>> > > firefox profiles and lost spreadsheet work it starts to get annoying.
>> > >
>> > > I've filed a kernel bug regarding this issue:
>> > > https://bugzilla.kernel.org/show_bug.cgi?id=206903
>> > > I would appreciate if you could report your findings there to give the
>> > > issue more data / weight.
>> > >
>> > > Thanks, Clemens
>> > >
>> > > Am Do., 2. Apr. 2020 um 15:11 Uhr schrieb someguy108 <someguy108@gmail.com>:
>> > > >
>> > > > Hello! I saw Clemens Eisserer email regarding MCE errors with his RX 570 and 3700x, and I like to add to that list of MCE spontaneous reboots as well.
>> > > > This is my configuration:
>> > > > -Ryzen 3900x + Noctua D15
>> > > > -MSI X570 Unify (latest agesa as of writing)
>> > > > -DDR4 3200mhz 32GB kit
>> > > > -Sapphire Pulse 5700 XT
>> > > > -Corsair RMX 850 Watt
>> > > > -Arch Linux with kernel 5.5.13
>> > > > -Mesa 20.0.3
>> > > > -Early KMS enabled
>> > > >
>> > > > I've had this system up and running since November 2019 but initially with a Nvidia 1060 and Windows 10. Everything was running smoothly. About a month ago I switched back over to Linux after purchasing my 5700 XT as my initial plan was to go back to Linux. Since returning I've experienced multiple spontaneous MCE reboots. All happened while I was playing one particular game, Warcraft 3 Reforged. The MCE event is the following:
>> > > >
>> > > > kernel: mce: [Hardware Error]: Machine check events logged
>> > > > kernel: mce: [Hardware Error]: CPU 1: Machine Check: 0 Bank 5: bea0000000000108
>> > > > kernel: mce: [Hardware Error]: TSC 0 ADDR 1ffffad66d6fe MISC d012000100000000 SYND 4d000000 IPID 500b000000000
>> > > > kernel: mce: [Hardware Error]: PROCESSOR 2:870f10 TIME 1585120217 SOCKET 0 APIC 2 microcode 8701013
>> > > > kernel: #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 #12 #13 #14 #15
>> > > > kernel: mce: [Hardware Error]: Machine check events logged
>> > > > kernel: mce: [Hardware Error]: CPU 15: Machine Check: 0 Bank 5: bea0000000000108
>> > > > kernel: mce: [Hardware Error]: TSC 0 ADDR 1ffffc1196eb6 MISC d012000100000000 SYND 4d000000 IPID 500b000000000
>> > > > kernel: mce: [Hardware Error]: PROCESSOR 2:870f10 TIME 1585120217 SOCKET 0 APIC 9 microcode 8701013
>> > > > kernel: #16 #17 #18 #19 #20 #21 #22 #23
>> > > >
>> > > > Initially I figured it could be ram so I performed the usual test with no problems. Also tested with standard JEDEC as well and eventually received a MCE during Warcraft 3 reforged. After consulting with a few friends I decided to try a different power supply to no avail. I then bit the bullet and bought a brand new 3900x. I also cleared CMOS before getting my new 3900x and after. All cpu values are on auto with no PBO or manual overclocking. The only fancy is the ram. Yesterday, after owning the new 3900x for three days, I had a MCE while I was playing Warcraft 3 Reforged. I have tested other games but none of them caused a MCE or any crashes / freezes for that matter. World of Warcraft, The Outer Worlds, Stellaris, and Counter-Strike: Global Offensive.
>> > > >
>> > > > As the same with Clemens, using the same decoder he used, MCE-Ryzen-Decoder, from github, it reports the MCE to be the following:
>> > > > Bank: Execution Unit (EX)
>> > > > Error: Watchdog Timeout error (WDT 0x0)
>> > > >
>> > > > One thing to note is I haven't received it during desktop usage. Only in Warcraft 3. I do have desktop compositing in both Xfce and KDE disabled and always have. Both of which used, tested, and received the MCE's during those sessions. I have noticed a pattern with the MCE crashes with Warcraft 3. They always happen during a GPU load drop off or increase transition. By that I mean when exiting a match to return to the lobby, or loading a map and when it switches from the loading screen to the match itself is when these MCE's happen. The entire screen quickly turns black, everything is hard locked, and then after about a minute or so the machine reboots on its own. It hasn't happened yet while in a middle of a match session, sitting in the lobby or at the main menu screen. Its consistently been during a transition. My theory is that this could possibly be a GPU hang from switching from one power state to another power state. With the GPU hanging, causes the CPU to stall, and 
 thus a MCE. The GPU hanging could explain the quick solid black screen as well as all output is stopped. But I'm really just assuming here form my own observations from my limited understanding. Possible reason why this triggers in Warcraft is because the other games have few moments of switching power states heavily. The Outer Worlds, World of Warcraft, Stellaris, and Counter-Strike Global Offensive all keep a constant high load on the GPU and the match sessions are long.
>> > > >
>> > > > From what its worth, I've had no major issues in Windows 10. The only quirks where initially a few TDR's that recovered from alt tabing out of most games with Google Chrome running. Disabling hardware acceleration in Chrome fixed those TDR's while alt-tabing out of games.
>> > > >
>> > > > From searching, the way I found this mailing list report, I've found quite a few reports of people talking about receiving MCE's that isn't the typical first generation MCE's reports from 2017 involving Ryzen.Where those where fixed by disabling c-states, ram, and changing power supply current from low to typical. These ones within the past year appear to all have a AMD GPU in common. I did notice a few with Intel CPU's as well paired up with a AMD GPU.
>> > > >
>> > > > Any feedback would be greatly appreciated.
>> > > > _______________________________________________
>> > > > amd-gfx mailing list
>> > > > amd-gfx@lists.freedesktop.org
>> > > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
