Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32B7C43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 15:05:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B54310E4A1;
	Fri,  8 Jul 2022 15:05:28 +0000 (UTC)
X-Greylist: delayed 1189 seconds by postgrey-1.36 at gabe;
 Fri, 08 Jul 2022 10:31:24 UTC
Received: from ppsw-42.srv.uis.cam.ac.uk (ppsw-42.srv.uis.cam.ac.uk
 [131.111.8.142])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8EF9C10E313
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 10:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk; 
 s=20210802.ppsw;
 h=Content-Type:MIME-Version:Message-ID:Subject:To:Reply-To:
 From:Date:Sender:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rZU2Bk0qaxdfqk0JB7OO/w6IBLLR9w429lO5ZbL6V1E=; b=l8lrYPl3AQzuGUmAed7hvVCmJA
 WqtTFnP4PfB8zdoNcTEI5HY3rzu6H98oNUPG58S6iFu8oU2/48Wns+R4wYgBymqJVwEsaZrOtoiOA
 POfZIFmaRE8670hv9BPL1AQ+IWIA1n5Wlp6z2mnmmiP7Yf6vIYKguNx57ts6OW2aoW8Q=;
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: https://help.uis.cam.ac.uk/email-scanner-virus
Received: from hades.srcf.societies.cam.ac.uk ([131.111.179.67]:52262)
 by ppsw-42.srv.uis.cam.ac.uk (ppsw.cam.ac.uk [131.111.8.138]:25)
 with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 id 1o9kxN-000mK0-EA (Exim 4.96) for amd-gfx@lists.freedesktop.org
 (return-path <mjr19@cam.ac.uk>); Fri, 08 Jul 2022 11:11:29 +0100
Received: from [192.168.1.67] (host31-54-145-234.range31-54.btcentralplus.com
 [31.54.145.234]) (Authenticated sender: mjr19)
 by hades.srcf.societies.cam.ac.uk (Postfix) with ESMTPSA id 1F1001FA84
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 11:11:29 +0100 (BST)
Date: Fri, 8 Jul 2022 11:11:31 +0100 (BST)
From: mjr19@cam.ac.uk
To: amd-gfx@lists.freedesktop.org
Subject: Radeon Evergreen/NI, power modes & DL-DVI
Message-ID: <625b6eec-6ecb-cd97-3061-408ebfb7539c@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailman-Approved-At: Fri, 08 Jul 2022 15:05:26 +0000
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
Reply-To: mjr19@cam.ac.uk
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Most Radeon Evergreen and Northern Island cards support power-saving modes 
with Linux and XOrg well, and have done for years. But if a dual link DVI 
monitor is in use (e.g. a 2560x1440 or 2560x1600 screen), the card will 
refuse to transition out of its high power mode while the display is 
active. I believe that this is because transitions are not supported when 
multiple displays are active, and dual link DVI is counted as being two 
displays.

If so, this seems wrong as the main issue with multiple displays is the 
difficulty of arranging to change the mclk when neither is mid-way through 
a scan line. With DL-DVI the two links are perfectly synchronised, and so 
this issue does not arise.

Unsurprisingly the cards do enter their low-power state when their output 
is off (e.g. "xset dpms force off"), but more surprisingly on awakening 
they remain in their low power state. The slightest provocation then 
causes a permanent transition to the high power state, showing that 
transitions with the display active work, and are invisible.

One can force them to run in their low power state by

echo low > /sys/class/drm/card0/device/power_dpm_force_performance_level

when they are already in the low power state. On many cards this provides 
adequate performance for most office-type applications, but it is hopeless 
at supporting any form of video.

So would it be possible to permit the high power to low power transition 
even when a DL-DVI display is active? (I believe that the AMDGPU driver 
gained the ability to do power level transitions with multiple 
synchonrised displays back in 2019 with amdgpu.dcfeaturemask=2 but I am 
unaware that the change was made to the older radeon driver, and DL-DVI is 
hardly two displays anyway.)

(Why do I care? I am responsible for several dozen machines with these 
cards, as, if one wants a cheap, passively-cooled card with good support 
from the free XOrg drivers, they are still quite good. I believe that the 
R5 230 is still in production too. The sort of office applications these 
machines display would allow the cards to stay in their low-power state 
most of the time, but not quite all of it. In the past most of our 
machines tended to have a single 1920x1080 monitor, so this did not 
matter, but now 2.5k monitors are becoming more common. AMD's habit of 
launching new CPUs some months before the corresponding APUs means that 
our need of simple passively-cooled cards is still quite current, as our 
programs do like the latest CPUs.)

Issue present on X.Org 1.21.1.3 radeon module 19.1.0 on Ubuntu 22.04 
x86_64.

Regards,

Michael

-- 
Dr MJ Rutter, TCM, Cavendish Lab, JJ Thomson Av, Cambridge. CB3 0HE
Email: mjr19@cam.ac.uk  Ph: 01223 337386  https://www.mjr19.org.uk/

