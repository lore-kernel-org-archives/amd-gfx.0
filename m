Return-Path: <SRS0=eq4R=4Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD234C10DCE
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2020 13:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E7B3206D7
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2020 13:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZsZTyQO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E7B3206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 321C66E291;
	Sun,  8 Mar 2020 13:07:10 +0000 (UTC)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 808436E291
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Mar 2020 13:07:09 +0000 (UTC)
Received: by mail-pf1-x429.google.com with SMTP id b72so6964pfb.11
 for <amd-gfx@lists.freedesktop.org>; Sun, 08 Mar 2020 06:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=ujUipbFKdCHlRfEwwd6k50H2joQOI9+8/DzgMgwSoCc=;
 b=PZsZTyQOQ0Oh0R1J9rqL24VjuOiOKXEuiu1c+zgF+7bxMjyGx0rhUHfM50FXOVCHcM
 TJmI75opDj9SNeBiwX1ITnDO//qYenroP6oqQtIuc2uxgEa+WwTj8S3VErCimPiLGl2a
 K/2ji/XbpMa1Ltkqu7+ozFobRZtLmZi9+fe1l9ERwfwBTSRWGcEAE+fKlqHUG0ig0VAk
 OeI2pHRCVUlZ+Z8gVjUw/XJumCM7NO5uRegpUZoP8xRpi84mqEJpGk1PoG1VmYBQ5GGh
 9v5BGEh+V+Eboi9FSK0jxd7gj50aCm5IKc0+ReU5Ejo7fBQcDozTS91y/A26BJuu75JS
 QiBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=ujUipbFKdCHlRfEwwd6k50H2joQOI9+8/DzgMgwSoCc=;
 b=NtSHMzg3h4mPnfs7H+X9SS2yqLzIzaP6JcjsfS9AgFJ1eahlk3LDK8pvbVlwsp96gt
 FULwWAYwQazYAfphnpVzkea8uUHUzN86XDoGWWGli9KjPqk5AsrzMzCCTee9Uu/NSb9Q
 6l6OWK3BGrmQy7/AETzG0E4+mxUW3rA8s5c5uxVrpXDwvpn4yuE+wEp5v/PXKV72Edpq
 djg96FuNZJLoDePUY48R90nYomt6691A1OyiItXfBUdXBle5dVfrwPc+qrsCCEfcMaG1
 VRj5f3+JPQfusSddqq4nGGxmIbbaiEqr4J4GB99NiuY7FyaeaKrwg0Az0/K6OwwA6KiK
 KOgg==
X-Gm-Message-State: ANhLgQ29coEzzaMS9akyTbUrX4jwiuBOWPBsSF0CzVZwT3OmW4eO8fyH
 DLki/9/5a62fCn/uisD+8T1sj3yp59XuyPeg9w//C8nh
X-Google-Smtp-Source: ADFU+vvoy25cPW4QO7rq21v/wSpOxIUoYJqqnPcNoJNusW8mvNsb4pxs0Sgut4dBP/RZFs95k5M6zDPF1BqPBy+zgt8=
X-Received: by 2002:a62:dd10:: with SMTP id w16mr12479312pff.16.1583672828707; 
 Sun, 08 Mar 2020 06:07:08 -0700 (PDT)
MIME-Version: 1.0
From: Clemens Eisserer <linuxhippy@gmail.com>
Date: Sun, 8 Mar 2020 14:06:57 +0100
Message-ID: <CAFvQSYQqneGVka+uyZjs1RsFNFkXZqYmz9pTP6=8uhUP0ddHAQ@mail.gmail.com>
Subject: Possibility of RX570 responsible for spontaneous reboots (MCE) with
 Ryzen 3700x?
To: amd-gfx@lists.freedesktop.org
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

Hi there,

Right after Ryzen3xxx was available I built a new system consisting of:
- Asrock Phantom Gaming 4 X570 (latest BIOS 2.3)
- Ryzen 3700x (not overclocked)
- MSI RX570 4GB
- Larger CPU cooler, high quality PSU, etc...

The system runs stable with Windows-10 (no reboot BSOD in months) and
runs memtest86 (single/multicore) as well as various load-tests for
hours without errors. However running Linux I get a spontaneous reboot
every now and then (2-3x a week), with always the same machine check
exception logged:

[    0.105003] .... node  #0, CPUs:        #1  #2
[    0.107022] mce: [Hardware Error]: Machine check events logged
[    0.107023] mce: [Hardware Error]: CPU 2: Machine Check: 0 Bank 5:
bea0000000000108
[    0.107092] mce: [Hardware Error]: TSC 0 ADDR 7f80a0c0181a MISC
d012000100000000 SYND 4d000000 IPID 500b000000000
[    0.107167] mce: [Hardware Error]: PROCESSOR 2:870f10 TIME
1580717835 SOCKET 0 APIC 4 microcode 8701013

I've tried a lot of different CPU-related things, like disabling C6,
disabling MWAIT use for task switching, etc without success.
I tried two times to contact AMD support only asking them to please
decode the MCE hex value - but as soon as they read over the term
"linux" the basically abort any communication. And to be honest, I had
the impression that they did not actually know what an MCE is in the
first place.

Luckily I found a decoder on github which prints:
Bank: Execution Unit (EX)
Error: Watchdog Timeout error (WDT 0x0)

I was rather hopeless until I found the following reddit thread:
https://www.reddit.com/r/archlinux/comments/e33nyg/hard_reboots_with_ryzen_3600x/

The users there claim to experience exactly the same problem (even
with the same MCE-Code logged) but where using R600 based graphics
cards - he is even using the same mainboard. When he swapped his
R600-card with a new RX5700 the problems vanished.

I don't have the luxury to simply try another GPU (my RX5700 is the
only one properly driving my 4k@60Hz panel), however the whole
observation makes me wonder. How can a GPU be responsible for
low-level errors such as the machine check exception in the execution
units like the one mentioned above.
Could DMA transfers gone bad be the cluprit?
Are there any "safe mode" options available I could try regarding
amdgpu (I tried disabling low-power states but this didn't help and
only made my GPU fans spin up)?

Any help is highly appreciated.

Thanks, Clemens
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
