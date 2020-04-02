Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0234C43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 14:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29F2206F5
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 14:12:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hOkdHO/y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29F2206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7888E6EA95;
	Thu,  2 Apr 2020 14:12:13 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E36D6EA95
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 14:12:12 +0000 (UTC)
Received: by mail-pl1-x62b.google.com with SMTP id w3so1383637plz.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Apr 2020 07:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :content-transfer-encoding;
 bh=Oyb2vXydKfkbdy3JahkXd6y1f9JKCUunVrxrutuAJzU=;
 b=hOkdHO/ysTA3CAps7AMcQFpPny0FKxPv2PRL1oX5v4ctAuyxMoVq1tDxELJb7oZ7I1
 xUREjhD0FhMaaM6tSf93Fwg8Zyb9HpPoNz2VbUe4q9A6PXYck3kHKNIX0lRJi58uyEXG
 MT8IoZR5Uq2h/Z3iZh12z/iGLavzthbaWKHOwMxqMQ/NuhprjKx1+lhfUN8zErOW84Jy
 uYPzQK0dggEyh1rFgqMF/9My5dnI2rBnxu7pu7s5r1pSO212nJrIttrhk8RnvR3n33jt
 G8EVszMs8PSt+z4ukLri3EBjdMK5J8Qgu6k0DPJKMfXAS313UsQ/k9aIXUzQNLd3gNuk
 qzrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:content-transfer-encoding;
 bh=Oyb2vXydKfkbdy3JahkXd6y1f9JKCUunVrxrutuAJzU=;
 b=nRTCN3vJKVOwdXlOAp/AJAectSLvq4PJH4ggPSTYPCibWnDqfVwA6xlYbOZPrXOUNq
 Dvd0myZOyjl4LpnkplEA3g3LM6BcQHXzCLcit1ZHDEVhhbq0raChl8jlg0TK+/KemnqQ
 xwuoLXPulmq0/K/EVZYq02KeiHMCrVtSuX1aZrZEHc+yxreeCn73eEkpr9CtnTnDbBb6
 fKpditdGVEyuGOWMN+uzFJGiWTGuUYaWdqSIYATCc+ErIa9oYjb7uguFku2Qb8Wv4H08
 ldROHpc9jqjGziVc7KMBcLfR+tmlZpYO2gdeGd64ri6AGXJ72YZfY01jmqgXPXJ87rjv
 Uk+Q==
X-Gm-Message-State: AGi0PubbjKKaOK7NTl7Wz9XHTK/FrJmsjJZDokDFDseUeIlRQKTVAglu
 boCO42ITndtzSns2ZwQvUnGJRxzeZL0YrhLVRGY=
X-Google-Smtp-Source: APiQypLBSmvBfS0wkegVY/dg2R++sfjfmD6Tt7EJV1fSRmwaS3yKGVRSBstJh6AMAtrBBHlrxqXa4Sb/mc1CrnimWno=
X-Received: by 2002:a17:902:7082:: with SMTP id
 z2mr3168169plk.43.1585836731282; 
 Thu, 02 Apr 2020 07:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAE6bd30xsbCNyyV6bjc7u-4cfLi5Zr4yCWGH=XeX31GKvz_9_Q@mail.gmail.com>
In-Reply-To: <CAE6bd30xsbCNyyV6bjc7u-4cfLi5Zr4yCWGH=XeX31GKvz_9_Q@mail.gmail.com>
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Thu, 2 Apr 2020 16:12:00 +0200
Message-ID: <CAFvQSYRiYxEOmyxhx726fFNGKy9KX=sE=vmdraW0_PyQvSwq9g@mail.gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Someguy,

Your findings sound very familiar, my machine is also rock-solid
running Windows-10 - most of the MCEs happened for me with low-load
situations but firefox playing youtube in background.
First I didn't care that much - but now having experienced corrupted
firefox profiles and lost spreadsheet work it starts to get annoying.

I've filed a kernel bug regarding this issue:
https://bugzilla.kernel.org/show_bug.cgi?id=206903
I would appreciate if you could report your findings there to give the
issue more data / weight.

Thanks, Clemens

Am Do., 2. Apr. 2020 um 15:11 Uhr schrieb someguy108 <someguy108@gmail.com>:
>
> Hello! I saw Clemens Eisserer email regarding MCE errors with his RX 570 and 3700x, and I like to add to that list of MCE spontaneous reboots as well.
> This is my configuration:
> -Ryzen 3900x + Noctua D15
> -MSI X570 Unify (latest agesa as of writing)
> -DDR4 3200mhz 32GB kit
> -Sapphire Pulse 5700 XT
> -Corsair RMX 850 Watt
> -Arch Linux with kernel 5.5.13
> -Mesa 20.0.3
> -Early KMS enabled
>
> I've had this system up and running since November 2019 but initially with a Nvidia 1060 and Windows 10. Everything was running smoothly. About a month ago I switched back over to Linux after purchasing my 5700 XT as my initial plan was to go back to Linux. Since returning I've experienced multiple spontaneous MCE reboots. All happened while I was playing one particular game, Warcraft 3 Reforged. The MCE event is the following:
>
> kernel: mce: [Hardware Error]: Machine check events logged
> kernel: mce: [Hardware Error]: CPU 1: Machine Check: 0 Bank 5: bea0000000000108
> kernel: mce: [Hardware Error]: TSC 0 ADDR 1ffffad66d6fe MISC d012000100000000 SYND 4d000000 IPID 500b000000000
> kernel: mce: [Hardware Error]: PROCESSOR 2:870f10 TIME 1585120217 SOCKET 0 APIC 2 microcode 8701013
> kernel: #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 #12 #13 #14 #15
> kernel: mce: [Hardware Error]: Machine check events logged
> kernel: mce: [Hardware Error]: CPU 15: Machine Check: 0 Bank 5: bea0000000000108
> kernel: mce: [Hardware Error]: TSC 0 ADDR 1ffffc1196eb6 MISC d012000100000000 SYND 4d000000 IPID 500b000000000
> kernel: mce: [Hardware Error]: PROCESSOR 2:870f10 TIME 1585120217 SOCKET 0 APIC 9 microcode 8701013
> kernel: #16 #17 #18 #19 #20 #21 #22 #23
>
> Initially I figured it could be ram so I performed the usual test with no problems. Also tested with standard JEDEC as well and eventually received a MCE during Warcraft 3 reforged. After consulting with a few friends I decided to try a different power supply to no avail. I then bit the bullet and bought a brand new 3900x. I also cleared CMOS before getting my new 3900x and after. All cpu values are on auto with no PBO or manual overclocking. The only fancy is the ram. Yesterday, after owning the new 3900x for three days, I had a MCE while I was playing Warcraft 3 Reforged. I have tested other games but none of them caused a MCE or any crashes / freezes for that matter. World of Warcraft, The Outer Worlds, Stellaris, and Counter-Strike: Global Offensive.
>
> As the same with Clemens, using the same decoder he used, MCE-Ryzen-Decoder, from github, it reports the MCE to be the following:
> Bank: Execution Unit (EX)
> Error: Watchdog Timeout error (WDT 0x0)
>
> One thing to note is I haven't received it during desktop usage. Only in Warcraft 3. I do have desktop compositing in both Xfce and KDE disabled and always have. Both of which used, tested, and received the MCE's during those sessions. I have noticed a pattern with the MCE crashes with Warcraft 3. They always happen during a GPU load drop off or increase transition. By that I mean when exiting a match to return to the lobby, or loading a map and when it switches from the loading screen to the match itself is when these MCE's happen. The entire screen quickly turns black, everything is hard locked, and then after about a minute or so the machine reboots on its own. It hasn't happened yet while in a middle of a match session, sitting in the lobby or at the main menu screen. Its consistently been during a transition. My theory is that this could possibly be a GPU hang from switching from one power state to another power state. With the GPU hanging, causes the CPU to stall, and thus a 
 MCE. The GPU hanging could explain the quick solid black screen as well as all output is stopped. But I'm really just assuming here form my own observations from my limited understanding. Possible reason why this triggers in Warcraft is because the other games have few moments of switching power states heavily. The Outer Worlds, World of Warcraft, Stellaris, and Counter-Strike Global Offensive all keep a constant high load on the GPU and the match sessions are long.
>
> From what its worth, I've had no major issues in Windows 10. The only quirks where initially a few TDR's that recovered from alt tabing out of most games with Google Chrome running. Disabling hardware acceleration in Chrome fixed those TDR's while alt-tabing out of games.
>
> From searching, the way I found this mailing list report, I've found quite a few reports of people talking about receiving MCE's that isn't the typical first generation MCE's reports from 2017 involving Ryzen.Where those where fixed by disabling c-states, ram, and changing power supply current from low to typical. These ones within the past year appear to all have a AMD GPU in common. I did notice a few with Intel CPU's as well paired up with a AMD GPU.
>
> Any feedback would be greatly appreciated.
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
