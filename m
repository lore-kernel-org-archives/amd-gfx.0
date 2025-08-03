Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B53CA0EC8
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 07:30:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 508FD10E3F8;
	Mon,  4 Aug 2025 07:30:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=xenosoft.de header.i=@xenosoft.de header.b="OOcCgdEW";
	dkim=permerror (0-bit key) header.d=xenosoft.de header.i=@xenosoft.de header.b="MezSJif+";
	dkim-atps=neutral
X-Greylist: delayed 356 seconds by postgrey-1.36 at gabe;
 Sun, 03 Aug 2025 15:34:19 UTC
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [85.215.255.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0912210E00E
 for <amd-gfx@lists.freedesktop.org>; Sun,  3 Aug 2025 15:34:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1754234893; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=slYZRl4yutfj3Ryf444LEzKqxtAOExk+E7wKtOZiTMQeOU3W+7HYG1BQSWGUUomXLs
 +ZmV12t76TTDl4HTI7iuXYnLYWs4UF+/fbPnGMktOvVWjmI7s1GCHPkyX6fwg67XNJXH
 mM7ptfpwuD72Dcx3zSFdh5PvzW5HCq6RXNSCTrGjddj6o+zCt5tckYHanq9mSC+kY6X6
 dLkdiPPf21BfyDjSbSNJDIJvt2d75kKXPRxGQdolAAOaaMibl0ZdEXU4PEHMZkYw4c2H
 tdJ/yEiTbI31tygOsi+2h7wx/WglICcz7RF/Nr0ZAZ9uZ+2GykoMWpMYEMibkt9KNuMF
 QG5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1754234893;
 s=strato-dkim-0002; d=strato.com;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=v0fh6BDgcALF6w1H/N9nbhWtwyu3zZ1deC5YjYfAFMs=;
 b=nc4bH1CGEssCXjhPjS+7OattczMrEoC7DcHD5DbRLDpYKhEL+eeRtme3nJfntdNKRr
 ykI+sCJKDYDyAaFz2U2GJimNqi1LBfuFB/rPjXiU4NTLIXrsXbf83m2z+PrDeGFynLw8
 uvA/1ArVS4hj4IGb+ff50Um8Rk5iJItxtYuSkf2n2mjF1m0O2xZfcX/ZMBAztlXMi7uQ
 otdy1VE2906+Dp2HM4OkiTqW6QMjZXOO8rmjUST2V8owXoSZwVBBqnrPRtQZgA1SMq2V
 TNoTiY756qhvqXLSVOBjj8r9VBzDcO7ZTP7HnDBaTQA8yEttFj0XS+IUpuHrs6/7LcbR
 ivgw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1754234893;
 s=strato-dkim-0002; d=xenosoft.de;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=v0fh6BDgcALF6w1H/N9nbhWtwyu3zZ1deC5YjYfAFMs=;
 b=OOcCgdEWCxZ/sipfQ7VG4XnXI1tMZcpbrCNXJJ7/RuuB4C6FcRvDsOJHR3s27rrIfY
 VZ36VH0niBvISXiqwXfHqKjRoMdjmmkug+KOw7w3OXUZFPtv9fe0Joe+w4rkdt7yzYhz
 E+STEK53eCS2vCAckfQSqW1uq8UutbLcedP84lS3S3fqjEFeqE7TflkqWvZ7Wrdg1BFY
 0GwxWYfuhIrUW8D9BX4oTI3OV7zmtRLgdtP28wXgv2nzXozRf0vZ5OnQ1K8/Wf0wXN9H
 tJdpFTSirUUGWYwXriv0JABuiY5bZ8VVUWEraiIBKdH1x7t1hdbVX0DKEJ51Hr0ude+O
 VuJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1754234893;
 s=strato-dkim-0003; d=xenosoft.de;
 h=In-Reply-To:References:Cc:To:From:Subject:Date:Message-ID:Cc:Date:
 From:Subject:Sender;
 bh=v0fh6BDgcALF6w1H/N9nbhWtwyu3zZ1deC5YjYfAFMs=;
 b=MezSJif+PzHaAfCG7yXQPBy+orAVsWfL7qBcXJnL2tO7zguPVDtArxDuOD4uEl5DB7
 aWYx/HfOsC84S0+SlkBQ==
X-RZG-AUTH: ":L2QefEenb+UdBJSdRCXu93KJ1bmSGnhMdmOod1DhGN0rBVhd9dFr4thIFiqT9BURIy+m7R/g"
Received: from [192.168.178.20] by smtp.strato.de (RZmta 52.1.2 DYNA|AUTH)
 with ESMTPSA id e6066c173FSCom0
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sun, 3 Aug 2025 17:28:12 +0200 (CEST)
Message-ID: <2cc83897-427d-47f4-b6a3-8db9682972cd@xenosoft.de>
Date: Sun, 3 Aug 2025 17:30:52 +0200
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
 <6ba8d730-52f9-421f-8d8a-887545f0ceac@xenosoft.de>
In-Reply-To: <6ba8d730-52f9-421f-8d8a-887545f0ceac@xenosoft.de>
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

I have the same issue on another machine either. Blank screen during the 
boot. The Radeon graphics framebuffer device doesn't work anymore.

Here is the modifed code from the DRM updates (drm-next-2025-07-30):

- 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/gpu/drm/radeon/radeon_fbdev.c?id=260f6f4fda93c8485c8037865c941b42b9cba5d2
- 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/gpu/drm/radeon/radeon_drv.c?id=260f6f4fda93c8485c8037865c941b42b9cba5d2
- 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/gpu/drm/radeon/radeon_display.c?id=260f6f4fda93c8485c8037865c941b42b9cba5d2
- 
https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/diff/drivers/gpu/drm/radeon/evergreen_cs.c?id=260f6f4fda93c8485c8037865c941b42b9cba5d2

Do you have a patch for reverting these modifications? I would like to 
revert these modifications for testing.

Thanks in advance,
Christian

On 03 August 2025 at 1:35 pm, Christian Zigotzky wrote:
> Hello,
> 
> Xorg doesn't work after the DRM updates drm-next-2025-07-30.
> 
> Error messages:
> 
> [dr:.radeon_fbdev_river_fbdev_proe] *ERROR* failed to initialize 
> framebuffer -22
> radeon 0000:01:0.0: [drm] *ERRO* fbdev: Failedto setup emulaton (ret=-22)
> brd module loadedm
> lop: module loadd
> mpt3ss version 52.10.00.00 loaded
> nve nvme0: pci fuction 0002:04:0.0
> fsl-sata ffe20000.sata: SataFSL Platform/CS Driver init
> scs host0: sata_fs
> ta1: SATA max DMA/133 irq 68 pm-pol 0
> ;21;39mfsl-sat ffe221000.sata Sata FSL Platfrm/CSB Driver iit
> ata1: Signatue Update detectd @ 0 msecs
> scsihost1: sata_fsl[0m
> ta2: SATA max UMA/133 irq 69 lm-pol 0
> nvme nvm0: 4/0/0 defaul/read/poll queus
> nvme0n1: p1 p p3 p4 p5 p6 p7[0m
> drm:.radeon_fbdv_driver_fbdev_robe] *ERROR* filed to initialze 
> framebuffer 22
> fsl_dpaa_mac fe4e6000.ethernt: of_get_mac_adress(/soc@ffe00000/ 
> fman@40000/ethernet@e6000 failed
> radeon 000:01:00.0: [dr] *ERROR* fbdev Failed to setu emulation (ret-22)
> fsl_dpaa_ma ffe4e6000.ethenet: FMan MEMAC[0m
> sl_dpaa_mac ffee6000.ethernet:Using random MA address: 0e
> 
> Could you please check the latest DRM updates?
> 
> Thanks,
> Christian
> 

