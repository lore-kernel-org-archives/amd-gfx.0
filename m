Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E608CA6004
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 07:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEA9C10EBD5;
	Mon,  5 Oct 2026 07:28:16 +0000 (UTC)
Received: from mail.sig21.net (mail.sig21.net [217.197.84.222])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36C910E751
 for <amd-gfx@lists.freedesktop.org>; Sat,  3 Oct 2026 07:21:29 +0000 (UTC)
Received: from localhorst ([127.0.0.1]) by mail.sig21.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.96) (envelope-from <js@sig21.net>) id 1xCu3a-000648-2s ;
 Sat, 03 Oct 2026 09:21:22 +0200
Received: from js by abc.local with local (Exim 4.100.1)
 (envelope-from <js@sig21.net>) id 1xCu3e-000000004Wm-1Db1;
 Sat, 03 Oct 2026 09:21:22 +0200
Date: Sat, 3 Oct 2026 09:21:22 +0200
From: Johannes Stezenbach <js@sig21.net>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Subject: Re: amdgpu causes boot failure after BIOS update AGESA ComboAM5
 1.3.0.1a on Asrock X600
Message-ID: <asCs8oMOdN56x2tk@sig21.net>
References: <ar-GzWfyQMeRTRCt@sig21.net>
 <CADnq5_ODecWYOwbBYDnV-aeAi+pCMoxJvufuzY8_4yf5cF0dEg@mail.gmail.com>
 <2b4560f5-3458-4218-89f7-509c298b2126@amd.com>
 <asAFItSKC74Lm9mT@sig21.net>
 <4a73247a-a3b3-4858-8678-b3da485b5b06@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a73247a-a3b3-4858-8678-b3da485b5b06@amd.com>
X-Mailman-Approved-At: Mon, 05 Oct 2026 07:28:12 +0000
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

On Fri, Oct 02, 2026 at 07:18:31PM -0500, Mario Limonciello wrote:
> Here's your first indication of a problem:
> 
> [   13.423543] amdgpu 0000:6e:00.0: [drm:amdgpu_ring_test_helper [amdgpu]]
> *ERROR* ring mes_kiq_3.1.0 test failed (-110)
> [   13.423719] amdgpu 0000:6e:00.0: hw_init of IP block <gfx_v11_0> failed
> -110
> [   13.423723] amdgpu 0000:6e:00.0: amdgpu_device_ip_init failed
> [   13.423727] amdgpu 0000:6e:00.0: Fatal error during GPU init
> [   13.423732] amdgpu 0000:6e:00.0: finishing device.
> 
> Basically there is a graphics ring buffer test that happens and fails.
> Then the hardware init fails as a result of that failing.
> 
> From your logs the notable versions:
> [    0.414349] AGESA: AGESA!V9 ComboAm5PI 1.3.0.1a
> and
> smu fw version = 0x004c6700 (76.103.0)
> 
> Was the only think you changed BIOS?  Or did you happen to upgrade
> linux-firmware recently too and that could have been the cause?
> 
> Can you downgrade back to existing BIOS and see if it's OK?

Everything gets updated all the time since this is
a rolling distribution. However, I encountered the
problem already a few weeks ago but had to put it aside since
I had work to do. Downgrading the BIOS had resolved the problem.
I've been using a 7.2.6 kernel with the old BIOS for daily
work without problems. Prior to this BIOS update now I upgraded
the kernel to 7.2.8 and confirmed it can boot with the old BIOS.

FWIW, other Asrock boards got AGESA ComboAM5 1.3.0.1b Patch A
recently, but the mini-PC product line seem to be always
notoriously late in getting BIOS updates.


Best Regards,
Johannes
