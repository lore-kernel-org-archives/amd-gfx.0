Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7018C83F1A
	for <amd-gfx@archiver.kernel.org>; Sun, 20 Jul 2025 14:39:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F2AD10E216;
	Sun, 20 Jul 2025 14:39:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=free.fr header.i=@free.fr header.b="eN76THOa";
	dkim-atps=neutral
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E60A10E216
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 14:39:51 +0000 (UTC)
Received: from zimbra39-e7.priv.proxad.net (unknown [172.20.243.189])
 by smtp3-g21.free.fr (Postfix) with ESMTP id 9DB4F13F8A2
 for <amd-gfx@lists.freedesktop.org>; Sun, 20 Jul 2025 16:39:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
 s=smtp-20201208; t=1753022389;
 bh=4gAcgB92aj2qKHIOa/thrESQeLN0ULPX4Idgr/bmg5w=;
 h=Date:From:To:In-Reply-To:Subject:From;
 b=eN76THOaBI2yuE52HK7BTEcizKHdZIrk+O+7ElnBq4T6/iKrC6e9eyCfqOuqMubc6
 Via3vp049VgIr8YU+l8PJsl1y+E7FdvjxoCF5RQ8en1DcDNk5nfssDkqvSmv2iBBed
 IUiVG8/iWI2Hil/5pW7KLACdNnRJ2YccBsVXrcQO3HTfJfr7FfK6rDGMP1BgPbFZVi
 AOAkAFXW51dT1ppUcdGtOraRsE5LLcyaqqRWoaJQOLytClq3V6WLIManDXjtl7fvcr
 BkbqJiRyBtWCh62ifwgsbrBDTPAJAVeqosdnZ/CRtXMhZuqYmutcU6dHxtS0EZkCmS
 bJZYOhv8jrDnQ==
Date: Sun, 20 Jul 2025 16:39:49 +0200 (CEST)
From: Yann Dirson <ydirson@free.fr>
To: amd-gfx list <amd-gfx@lists.freedesktop.org>
Message-ID: <1835198865.152908048.1753022389600.JavaMail.root@zimbra39-e7.priv.proxad.net>
In-Reply-To: <1183390756.152871261.1753021573282.JavaMail.root@zimbra39-e7.priv.proxad.net>
Subject: Need help to dig into X11 display freezing (Renoir, Xen/QubesOS)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.120.44.86]
X-Mailer: Zimbra 7.2.0-GA2598 (ZimbraWebClient - FF3.0 (Linux)/7.2.0-GA2598)
X-Authenticated-User: ydirson@free.fr
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

Hello there,

For a few months I've been experiencing occasional freezes of the X11 display
on my QubesOS RENOIR laptop.  The setup is pretty much standard for QubesOS,
with both GPUs attached to dom0 and XFCE running there (and the dGPU being
mostly not used).  Kernel is QubesOS' kernel-latest-6.15.4.

Those freezes most often occur while the screen is blanked
by xscreensaver (suspend options fully deactivated here, as suspend is broken
on this platform): in this case moving the mouse does not get the unlock banner
displayed, the screen stays black... except the mouse pointer is visible.  I can
also switch to other virtual consoles and interact with the system, but was
never able to collect any evidence of something wrong being detected.

Occasionally it also happens (like yesterday) while I'm working, and the X11
display just seems frozen, no clue if the input devices trigger anything in
there.

I guess something goes wrong but gets undetected by the driver.  Any suggestion
as to extra logging/debug features to enable?

Best regards,
-- 
Yann
