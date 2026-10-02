Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B565BCA5FDD
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Oct 2026 12:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20C6210F824;
	Fri,  2 Oct 2026 12:52:20 +0000 (UTC)
X-Greylist: delayed 1364 seconds by postgrey-1.36 at gabe;
 Fri, 02 Oct 2026 10:49:12 UTC
Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED6810E34E
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Oct 2026 10:49:12 +0000 (UTC)
Received: from localhorst ([127.0.0.1]) by mail.sig21.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <js@sig21.net>) id 1xCaT7-0001CM-2D 
 for amd-gfx@lists.freedesktop.org; Fri, 02 Oct 2026 12:26:25 +0200
Received: from js by abc.local with local (Exim 4.100.1)
 (envelope-from <js@sig21.net>) id 1xCaT7-000000006dD-48mF
 for amd-gfx@lists.freedesktop.org; Fri, 02 Oct 2026 12:26:21 +0200
Date: Fri, 2 Oct 2026 12:26:21 +0200
From: Johannes Stezenbach <js@sig21.net>
To: amd-gfx@lists.freedesktop.org
Subject: amdgpu causes boot failure after BIOS update AGESA ComboAM5 1.3.0.1a
 on Asrock X600
Message-ID: <ar-GzWfyQMeRTRCt@sig21.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailman-Approved-At: Fri, 02 Oct 2026 12:52:19 +0000
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

Hi,

I have one Asrock Deskmini X600 with Ryzen 8700G.
Recently a BIOS update was released which updates
AGESA ComboAM5 from 1.2.0.3g to  1.3.0.1a.

https://www.asrock.com/nettop/AMD/DeskMini%20X600%20Series/index.asp#BIOS

The result is boot failure before any message could be printed
with my self-built kernel, which has the amdgpu driver built-in.
However, a Debian rescue image with kernel 7.2.8 could boot
(in text mode or vesa graphics mode).

Using the rescue system, I installed the Debian kernel 7.2.8,
it can boot but hangs after the amdgpu module is loaded
(no error message or crash output).
It can boot successfully with module_blacklist=amdgpu.

https://packages.debian.org/forky/linux-image-7.2.8+deb14-amd64

If you have any ideas what to try please let me know soon,
otherwise I'll have to downgrade to the previous BIOS version.


Best Regards,
Johannes
