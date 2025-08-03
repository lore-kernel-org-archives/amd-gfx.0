Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93311CA0ED9
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 07:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD4510E3FE;
	Mon,  4 Aug 2025 07:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="ccy9CSRv";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="S9UHsKiX";
	dkim-atps=neutral
X-Greylist: delayed 355 seconds by postgrey-1.36 at gabe;
 Sun, 03 Aug 2025 11:38:46 UTC
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.166])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F04010E009
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Aug 2025 11:38:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1754220760; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=coGiJ2glh+WFSDRY2Rz4qXmCrRMeU1StWuSyTYpuL2liePIHN6PAkg//hzJU4JRc59
 AghTVr0QvAtDX6MvT3fNr4it1DoQBRnGnOgpZL80Gv+b7/iyYYklBqTBcok1SO7zKQLu
 EOL306SDqjHrTENu7RJNH63M74he4M96bxc8pAKrhGoLEt5pWWARnxCaIyd1CZee0uA0
 cv9168n4+2jBZrSmHyqvpjFSKbCbZSg+K+B2CSlGDEbudk7VDEnnpzVd0uCQHd6r70QZ
 rFkrtXxXLMOLSzP+wegpQcb+bYM4oxDwqTdiyBQTe3/ki5eG1q3ImyQziOK7VY/x23e6
 yY9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1754220760;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=SNEoyn7T9Jf3eY4s0gy6qI079kIQlXQ2LEXIgvF5lX0=;
 b=URDBeuBUOXe3gbCBtKXLTvZ91lfCGaP4iYZOgVuU2n2mO7hNXagdaDechonOnatK1g
 D1AuiU74N1Q+B37AZYXFlfFDFaCvXpL2hCjsIQFd45ZjFrIutfcsJiArMaRCXn5lIeCY
 BMx5sFKqcoXBTS0UWyl/YIR+vfvCJUwhH6hXvuRsjOylmZVFK6p9zBI7e8PdilMZ8Gbo
 okeL8U4pWKeCovgaBd7BR9iQ1JMRj0CShdPVIddGpQeeuMpJzgSJgU2ltI3/QloKvJgu
 jq26V8k+FvhlMSMOjv4bA2T3WtyZpSh3fap6Av4mm3j1xgidVVflzEvoMtvUTJzbTFvn
 gxBA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754220760;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=SNEoyn7T9Jf3eY4s0gy6qI079kIQlXQ2LEXIgvF5lX0=;
 b=ccy9CSRvcwfsag+0pITwPYYGpp6vVQ9Kx1Kej905OLWneUOI6Q2nu0WdWB1ag0ci6G
 SCVcofRfa4AJ6teMPpBLpBlhNnS2EXqgWntNiw0SCizeP49sINy83xrremtlzSdVD0Ir
 0yu1MjkeH8YmZ+HVIoU+VKTSVIcNY91UTgQXSy3qbTCI5IaUaIKda3npL9BHXcno21gT
 xU9evMe6lJEll7w6e4++0Dz2kHXjbF1KU/WG/lLIeFYNO41smf84KXB/DhcxX2uVnlOG
 nhxbKikovko0qN3MjvjG73E6jte+rPpgA1eJxYZtLuZiBHLjw/JGV7dqaZVyvpTqbFzW
 DwhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754220760;
 s=strato-dkim-0003; d=xenosoft.de;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=SNEoyn7T9Jf3eY4s0gy6qI079kIQlXQ2LEXIgvF5lX0=;
 b=S9UHsKiXOIs7LMgGBI9lHMLzpYD7+0vw6ZKc1re/8nQbdt/uWvBpWcu7nhRkhesgDb
 fr5ehCMPaFEuEa8Bm2CQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr6P1rfO5KiO55fErqxOiEafo+kdhkEpPpx41Heyt0x3tq7WaTEcs/"
Received: from [IPV6:2001:16b8:50d5:5a00:c7b:b07e:8953:b246]
 by smtp.strato.de (RZmta 52.1.2 AUTH) with ESMTPSA id e6066c173BWcoUF
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sun, 3 Aug 2025 13:32:38 +0200 (CEST)
Message-ID: <6ba8d730-52f9-421f-8d8a-887545f0ceac@xenosoft.de>
Date: Sun, 3 Aug 2025 13:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: radeon_fbdev_river_fbdev: failed to initialize framebuffer and setup
 emulaton
From: Christian Zigotzky <chzigotzky@xenosoft.de>
To: Alex Deucher <alexdeucher@gmail.com>, ville.syrjala@linux.intel.com
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, "R.T.Dickinson"
 <rtd@a-eon.com>, mad skateman <madskateman@gmail.com>,
 Darren Stevens <darren@stevens-zone.net>, hypexed@yahoo.com.au,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christian Zigotzky <info@xenosoft.de>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>, Wu Hoi Pok <wuhoipok@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <CADnq5_PUi_2+kDYX8R_eanNF4iYN79MdXJ_PLcQbZKi6e4S8tg@mail.gmail.com>
 <87F47F04-EBAC-48D6-AD0A-4BBE39DF43CE@xenosoft.de>
 <1115cce7-cfdc-4c5b-b017-69cd32425650@xenosoft.de>
In-Reply-To: <1115cce7-cfdc-4c5b-b017-69cd32425650@xenosoft.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Mon, 04 Aug 2025 07:30:11 +0000
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

Hello,

Xorg doesn't work after the DRM updates drm-next-2025-07-30.

Error messages:

[dr:.radeon_fbdev_river_fbdev_proe] *ERROR* failed to initialize 
framebuffer -22
radeon 0000:01:0.0: [drm] *ERRO* fbdev: Failedto setup emulaton (ret=-22)
brd module loadedm
lop: module loadd
mpt3ss version 52.10.00.00 loaded
nve nvme0: pci fuction 0002:04:0.0
fsl-sata ffe20000.sata: SataFSL Platform/CS Driver init
scs host0: sata_fs
ta1: SATA max DMA/133 irq 68 pm-pol 0
;21;39mfsl-sat ffe221000.sata Sata FSL Platfrm/CSB Driver iit
ata1: Signatue Update detectd @ 0 msecs
scsihost1: sata_fsl[0m
ta2: SATA max UMA/133 irq 69 lm-pol 0
nvme nvm0: 4/0/0 defaul/read/poll queus
nvme0n1: p1 p p3 p4 p5 p6 p7[0m
drm:.radeon_fbdv_driver_fbdev_robe] *ERROR* filed to initialze 
framebuffer 22
fsl_dpaa_mac fe4e6000.ethernt: 
of_get_mac_adress(/soc@ffe00000/fman@40000/ethernet@e6000 failed
radeon 000:01:00.0: [dr] *ERROR* fbdev Failed to setu emulation (ret-22)
fsl_dpaa_ma ffe4e6000.ethenet: FMan MEMAC[0m
sl_dpaa_mac ffee6000.ethernet:Using random MA address: 0e

Could you please check the latest DRM updates?

Thanks,
Christian

