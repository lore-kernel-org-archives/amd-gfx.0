Return-Path: <SRS0=IbmW=MW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF601C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 12:21:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0824C60C40
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jul 2021 12:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0824C60C40
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=razorwired.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 811896E215;
	Fri, 30 Jul 2021 12:21:17 +0000 (UTC)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B806E303
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 12:09:00 +0000 (UTC)
Received: by mail-qv1-xf36.google.com with SMTP id m12so4391624qvt.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jul 2021 05:09:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=razorwired-com.20150623.gappssmtp.com; s=20150623;
 h=message-id:subject:from:to:date:in-reply-to:references:user-agent
 :mime-version; bh=235kBkwaCHToGN/UDRO97ueQ6lkFzkew+7Ny1NssVRc=;
 b=guCevi8VIikr9MNl7WZ4wNMp8+blX9YK3hPm41zuGYBgFMt9I9DHqh83Z4Gm+Pk8YQ
 FiH0bjw6aqtSBGQWwYCkm1fwc3uVY6+/hAYxaG2CcXDoDlwTknhJb7EgEXZRIXW12F1T
 H1ofrMpVhNZcshTQrtwIQZnQ9VVbLUZFDB8ct6M5vABHbkj2fxpg7xcQvacFImt/PNvf
 x8hUuNZTQ3E8Q88Du3qQg4LSX812iEu8BHeYIpufsC8MijHEFlKXwPef03JoIuvr0ZB7
 V5ggpOUPP1o4EIuv6+wthEQD9zJAgBW0okcwi1D/Jrkti0AcA+9lclZqgp9Nh0NkN3sd
 YtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
 :references:user-agent:mime-version;
 bh=235kBkwaCHToGN/UDRO97ueQ6lkFzkew+7Ny1NssVRc=;
 b=MRYImok/sJgx1Z+853urtAXyNTzO2Wb+qeRbWd0H5ksmg6N1OfQLrU+t2v9QLroPSI
 segqQKMmu1Fchehb95zi5pEuVIedRM1B2ipjUKMt5UvRTinmy9pPMYdlnCH1bPRztLPs
 kmeI/NCkJH+vgiNssviXn5bqNd1P/Xn1maam0kb5vDeDSqUCruaTmvGavZGQX5r+mGbP
 SpD2InBupTXe8ojsgDtcbaMU/oQEcdzMr5q+U5AbFKe2WtFVclTkb4RlP68FkE3+AC7m
 R1qnZMMIZTAbwbChOaBVAPBHNlFBJxVWvLAuFkKoHNaT4zmQbEaaBsr5Pwfdzxr9DTCh
 NS3Q==
X-Gm-Message-State: AOAM531VcvsZ0Xy6QqyNIWcHEAmikUuwr0J0EenfR48ylPxTQEoG+k6D
 r+hYVlTvIixxcQYqYrE7ttKeAg==
X-Google-Smtp-Source: ABdhPJyyU7oyv9c+Dii/9VZTRNk1Y9uS2EByNKzkFuqw0Iwo1Y+xFSF4OIfGE+/6U/vVqztHVZ7kJQ==
X-Received: by 2002:a0c:ed51:: with SMTP id v17mr2221449qvq.20.1627646939605; 
 Fri, 30 Jul 2021 05:08:59 -0700 (PDT)
Received: from Alpha-17.fios-router.home
 (pool-98-114-101-42.phlapa.fios.verizon.net. [98.114.101.42])
 by smtp.gmail.com with ESMTPSA id o63sm798007qkf.4.2021.07.30.05.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jul 2021 05:08:59 -0700 (PDT)
Message-ID: <527b5f787d2418e51b3232619e9c4754b9cf4644.camel@razorwired.com>
Subject: Re: Linux Mint 20.04 5.11 issue
From: Tim Cahill <tim@razorwired.com>
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Date: Fri, 30 Jul 2021 08:08:58 -0400
In-Reply-To: <d238603ff3d85c40250b8386aa7264b240e1623d.camel@razorwired.com>
References: <3e50d54ee11131494a8dcd75cdff5f366dd90930.camel@razorwired.com>
 <5bfdb04e-fc92-3938-c701-1ceb91782475@amd.com>
 <d238603ff3d85c40250b8386aa7264b240e1623d.camel@razorwired.com>
Content-Type: multipart/alternative; boundary="=-VHHYDZt5PSTsivUZveRl"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 30 Jul 2021 12:21:16 +0000
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


--=-VHHYDZt5PSTsivUZveRl
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Posted the following comment to the Mate-desktop issue:


  Had
 another hang with the same configuration as a youtube video
played via a
 USB headphone (Jabra40). I was able to recover by killing
Firefox, in 
which the video was playing. The video became choppy and
garbled and 
then stopped. The stderr is below:

ALSA lib
conf.c:5187:(snd_config_expand) Unknown parameters 1
ALSA lib control.c:1379:(snd_ctl_open_noupdate) Invalid CTL
sysdefault:1
ALSA lib conf.c:5187:(snd_config_expand) Unknown parameters 2
ALSA lib control.c:1379:(snd_ctl_open_noupdate) Invalid CTL
sysdefault:2
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
On re-launch of Firefox from terminal window, the following appeared:
[GFX1-]: More than 1 GPU from same vendor detected via PCI, cannot deduce device
On Thu, 2021-07-29 at 12:04 -0400, Tim Cahill wrote:
> I apologize if the name callout is disconcerting. I was trying to
> follow instructions for sending bugs and saw your name listed as the
> owner of this code area. 
> FYI, I'd done some more troubleshooting and tinkering regarding the
> crashing and Mate seems to be at the center of all the issues. As a
> result, I also opened an Issue with the Mate Desktop team (
> https://github.com/mate-desktop/mate-panel/issues/1242). Mate also
> has a power management component, which is probably responsible for
> the excess logging and the confusion over Navil10. However, I have no
> way to vouch for now accurately the Mate PM applet gathered data for
> its instantiation. I have no external devices connected that I'm
> aware would use it since I thought that was via HDMI. I *do* have a
> Jabra Evolve2 headset that uses the TypeC USB connector, but I assume
> that's not using the GPU.
> The issue documentation I left with Mate notes that if I launch apps
> from a terminal that is NOT launched from the Mate panel (right-click 
> on desktop instead to open terminal), the parent for all the apps
> (Firefox, Evolution, etc.) is separate from Mate (at least separate
> from mate-panel). Everything has worked fine (except for the constant
> logging of the wake-up action) since I've done that (and turned off
> the screensaver and screensaver lock). So, I'm not sure what else to
> do at this point. Please advise if I should do anything on the driver
> side.
> Thanks,Tim 
> On Thu, 2021-07-29 at 11:14 -0400, Felix Kuehling wrote:
> > Am 2021-07-28 um 12:10 p.m. schrieb Tim Cahill:
> > > Hi Felix,
> > 
> > I'm not sure why you're calling me out by name. I'm not working
> > onanything obviously related to your crashes.
> > Anyway, I took a quick look at the backtraces. They all point at
> > libgdk.Two of them are segfaults, one is an abort. It's not clear
> > how thesewould be related to the GPU driver. That said, when you
> > boot withnomodeset, the GPU driver and all HW acceleration is
> > completelydisabled. If that makes the problem disappear, the GPU
> > driver is clearlyinvolved in the problem in some way.
> > The abort points at a problem while freeing memory. This could be
> > causedby a double-free problem in some unrelated code, possibly
> > related to theGPU driver. This would be a problem in a user mode
> > component (maybeMesa), not the kernel mode driver.
> > I believe the messages you're seeing when you move the mouse are
> > theresult of runtime power management that puts the GPU to sleep
> > when it'sidle and reinitializes it when it's needed. You have 2
> > GPUs in yourlaptop, an integrated Renoir GPU in the Ryzen CPU, and
> > an externalNavi10 GPU for higher gaming performance. The GPU that
> > goes to sleep andwakes up is the external Navi10 GPU.
> > The OpenGL renderer string specifies "RENOIR". Therefore I'm
> > surprisedthat the Navi10 GPU wakes up when you move the mouse.
> > Ideally itshouldn't be used at all when you're just using the
> > desktop.
> > If you suspect that runtime power management is responsible for
> > yourproblems, you could disable it with amdgpu.runpm=0 on the
> > kernel commandline. That means the Navi10 GPU won't go into the low
> > power mode anddrain your battery more quickly. So this is not a
> > permanent solution.Just an experiment to narrow down the problem.
> > Regards,  Felix
> > 
> > > I'm not sure how to do this as I haven't had to report a bug
> > > before.I've looked to a variety of bug reporting sites to see if
> > > anyone elseis running into the same issues that I'm having (such
> > > as the Mateproject) and haven't seen anything at all similar to
> > > the issue I'mhaving. Since I had issues with AMD drivers with my
> > > distro (infobelow) and some consistent and high volume dmesg
> > > content shows up,I've decided that I should start here with the
> > > AMD kernel team.
> > > I have a fairly new MSI laptop with the following configuration:
> > > [code]System:    Kernel: 5.11.0-25-generic x86_64 bits: 64
> > > compiler: N/ADesktop: MATE 1.24.0 wm: marco            dm:
> > > LightDM Distro: Linux Mint 20.2 Uma base: Ubuntu
> > > 20.04focal Machine:   Type: Laptop System: Micro-Star product:
> > > Alpha 17 A4DEK v:REV:1.0 serial: <filter>            Chassis:
> > > type: 10 serial: <filter>            Mobo: Micro-Star model: MS-
> > > 17EK v: REV:1.0 serial: <filter>UEFI: American
> > > Megatrends            v: E17EKAMS.101 date:
> > > 10/26/2020 Battery:   ID-1: BAT1 charge: 66.2 Wh condition:
> > > 67.0/65.7 Wh (102%)volts: 12.4/10.8            model: MSI Corp.
> > > MS-17EK serial: N/A status: Unknown CPU:       Topology: 8-Core
> > > model: AMD Ryzen 7 4800H with RadeonGraphics bits: 64 type: MT
> > > MCP            arch: Zen rev: 1 L2 cache: 4096
> > > KiB            flags: avx avx2 lm nx pae sse sse2 sse3 sse4_1
> > > sse4_2 sse4assse3 svm bogomips: 92630            Speed: 4278 MHz
> > > min/max: 1400/2900 MHz Core speeds (MHz):1: 4280 2: 1865 3:
> > > 1397            4: 2188 5: 1489 6: 2265 7: 1907 8: 1906 9: 1729
> > > 10: 139711: 1397 12: 1397 13: 1397            14: 1397 15: 1907
> > > 16: 1740 Graphics:  Device-1: AMD Navi 10 [Radeon RX 5600
> > > OEM/5600 XT /5700/5700 XT]            vendor: Micro-Star MSI
> > > driver: amdgpu v: kernel bus ID:03:00.0 chip ID:
> > > 1002:731f            Device-2: AMD Renoir vendor: Micro-Star MSI
> > > driver: amdgpuv: kernel bus ID: 08:00.0            chip ID:
> > > 1002:1636            Display: x11 server: X.Org 1.20.9 driver:
> > > amdgpu,ati            unloaded: fbdev,modesetting,radeon,vesa
> > > compositor: marcoresolution: 1920x1080~144Hz            OpenGL:
> > > renderer: AMD RENOIR (DRM 3.40.0 5.11.0-25-genericLLVM
> > > 11.0.0)            v: 4.6 Mesa 20.2.6 direct render:
> > > Yes Audio:     Device-1: AMD Navi 10 HDMI Audio vendor: Micro-
> > > Star MSIdriver: snd_hda_intel v: kernel            bus ID:
> > > 03:00.1 chip ID: 1002:ab38            Device-2: AMD
> > > Raven/Raven2/FireFlight/Renoir AudioProcessor vendor: Micro-Star
> > > MSI            driver: N/A bus ID: 08:00.5 chip ID:
> > > 1022:15e2            Device-3: AMD Family 17h HD Audio vendor:
> > > Micro-Star MSIdriver: snd_hda_intel            v: kernel bus ID:
> > > 08:00.6 chip ID: 1022:15e3            Sound Server: ALSA v:
> > > k5.11.0-25-generic Network:   Device-1: Intel Wi-Fi 6 AX200
> > > driver: iwlwifi v: kernel busID: 04:00.0            chip ID:
> > > 8086:2723            IF: wlp4s0 state: up mac:
> > > <filter>            Device-2: Realtek RTL8111/8168/8411 PCI
> > > Express GigabitEthernet vendor: Micro-Star MSI            driver:
> > > r8169 v: kernel port: f000 bus ID: 05:00.0 chip
> > > ID:10ec:8168            IF: eno1 state: down mac:
> > > <filter> Drives:    Local Storage: total: 476.94 GiB used: 89.79
> > > GiB (18.8%)            ID-1: /dev/nvme0n1 vendor: Kingston model:
> > > OM8PCP3512F-AI1size: 476.94 GiB            speed: 31.6 Gb/s
> > > lanes: 4 serial: <filter> Partition: ID-1: / size: 466.30 GiB
> > > used: 89.28 GiB (19.1%) fs: ext4dev: /dev/dm-1            ID-2:
> > > /boot size: 704.5 MiB used: 519.7 MiB (73.8%) fs:ext4 dev:
> > > /dev/nvme0n1p2            ID-3: swap-1 size: 980.0 MiB used: 0
> > > KiB (0.0%) fs: swapdev: /dev/dm-2 USB:       Hub: 1-0:1 info:
> > > Full speed (or root) Hub ports: 4 rev: 2.0chip ID:
> > > 1d6b:0002            Device-1: 1-3:2 info: SteelSeries ApS
> > > SteelSeries KLC type:HID            driver: hid-generic,usbhid
> > > rev: 2.0 chip ID: 1038:1122            Device-2: 1-4:3 info: Acer
> > > HD Webcam type: Video driver:uvcvideo rev: 2.0            chip
> > > ID: 5986:211c            Hub: 2-0:1 info: Full speed (or root)
> > > Hub ports: 2 rev: 3.1chip ID: 1d6b:0003            Hub: 3-0:1
> > > info: Full speed (or root) Hub ports: 4 rev: 2.0chip ID:
> > > 1d6b:0002            Device-3: 3-3:2 info: Intel type: Bluetooth
> > > driver: btusbrev: 2.0 chip ID: 8087:0029            Hub: 4-0:1
> > > info: Full speed (or root) Hub ports: 2 rev: 3.1chip ID:
> > > 1d6b:0003 Sensors:   System Temperatures: cpu: 46.5 C mobo:
> > > N/A            Fan Speeds (RPM): N/A            GPU: device:
> > > amdgpu temp: 0 C fan: 65535 device: amdgputemp: 31
> > > C Repos:     No active apt repos in:
> > > /etc/apt/sources.list            Active apt repos
> > > in:/etc/apt/sources.list.d/official-package-
> > > repositories.list            1: deb http:
> > > //mirrors.seas.harvard.edu/linuxmint-packagesuma main upstream
> > > import backport           2: deb http: //mirror.us-
> > > ny2.kamatera.com/ubuntu focal mainrestricted universe
> > > multiverse           3: deb http: //mirror.us-
> > > ny2.kamatera.com/ubuntufocal-updates main restricted universe
> > > multiverse           4: deb http: //mirror.us-
> > > ny2.kamatera.com/ubuntufocal-backports main restricted universe
> > > multiverse           5: deb http: //security.ubuntu.com/ubuntu/
> > > focal-securitymain restricted universe multiverse           6:
> > > deb http: //archive.canonical.com/ubuntu/ focal
> > > partnerInfo:      Processes: 372 Uptime: 2h 44m Memory: 15.10 GiB
> > > used: 1.15GiB (7.6%) Init: systemd            v: 245 runlevel: 5
> > > Compilers: gcc: 9.3.0 alt: 9 Client:Unknown python3.8
> > > client            inxi: 3.0.38 [/code]
> > > 
> > > If I am using it interactively, I get random crashes that seems
> > > to hitelements of mate (mate-panel, etc.) consistently - just not
> > > predictably. LibreOffice applications, xed,Firefox, and Evolution
> > > seem to be more proneto crashing the X session. I can easily move
> > > to tty1, login, and killservices running in tty7 as the
> > > crashesdon't appear to completely kill tty7. Sometimes, I can
> > > kill mate andlaunch a new instance to salvagethe tty7 session.
> > > However, i usually end up having to kill the rootpid of the
> > > xwindows session in orderto re-login. But I think this is related
> > > to the AMD GPU driver becauseevery  time I simply move the mouse
> > > in tty7 session, I get the following in dmesg:
> > > [13164.399550] [drm] PCIE GART of 512M enabled (table
> > > at0x0000008000000000).[13164.399579] [drm] PSP is
> > > resuming...[13164.486593] [drm] reserve 0xa00000 from
> > > 0x800f400000 for PSP TMR[13164.678788] amdgpu 0000:03:00.0:
> > > amdgpu: RAS: optional ras ta ucodeis not available[13164.702624]
> > > amdgpu 0000:03:00.0: amdgpu: RAP: optional rap ta ucodeis not
> > > available[13164.702639] amdgpu 0000:03:00.0: amdgpu: SMU is
> > > resuming...[13164.702648] amdgpu 0000:03:00.0: amdgpu: smu driver
> > > if version =0x00000036, smu fw if version = 0x00000037, smu fw
> > > version =0x002a3f00 (42.63.0)[13164.702664] amdgpu 0000:03:00.0:
> > > amdgpu: SMU driver if version notmatched[13164.746143] amdgpu
> > > 0000:03:00.0: amdgpu: SMU is resumed successfully![13164.768978]
> > > [drm] kiq ring mec 2 pipe 1 q 0[13164.779651] [drm] VCN decode
> > > and encode initializedsuccessfully(under DPG Mode).[13164.779758]
> > > [drm] JPEG decode initialized successfully.[13164.779779] amdgpu
> > > 0000:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inveng 0 on hub
> > > 0[13164.779783] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses
> > > VMinv eng 1 on hub 0[13164.779784] amdgpu 0000:03:00.0: amdgpu:
> > > ring comp_1.1.0 uses VMinv eng 4 on hub 0[13164.779785] amdgpu
> > > 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VMinv eng 5 on hub
> > > 0[13164.779786] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.0 uses
> > > VMinv eng 6 on hub 0[13164.779787] amdgpu 0000:03:00.0: amdgpu:
> > > ring comp_1.0.1 uses VMinv eng 7 on hub 0[13164.779788] amdgpu
> > > 0000:03:00.0: amdgpu: ring comp_1.1.1 uses VMinv eng 8 on hub
> > > 0[13164.779789] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.1 uses
> > > VMinv eng 9 on hub 0[13164.779790] amdgpu 0000:03:00.0: amdgpu:
> > > ring comp_1.3.1 uses VMinv eng 10 on hub 0[13164.779792] amdgpu
> > > 0000:03:00.0: amdgpu: ring kiq_2.1.0 uses VM inveng 11 on hub
> > > 0[13164.779793] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM
> > > inv eng12 on hub 0[13164.779803] amdgpu 0000:03:00.0: amdgpu:
> > > ring sdma1 uses VM inv eng13 on hub 0[13164.779804] amdgpu
> > > 0000:03:00.0: amdgpu: ring vcn_dec uses VM inveng 0 on hub
> > > 1[13164.779805] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses
> > > VM inveng 1 on hub 1[13164.779806] amdgpu 0000:03:00.0: amdgpu:
> > > ring vcn_enc1 uses VM inveng 4 on hub 1[13164.779807] amdgpu
> > > 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inveng 5 on hub
> > > 1[13164.783807] amdgpu 0000:03:00.0: [drm] Cannot find any crtc
> > > or sizes[13170.722306] [drm] free PSP TMR buffer
> > > If I boot with nomodeset, I can operate fine - just without
> > > screenbrightness control, etc. It justseems strange that an event
> > > is generated like this all the time.
> > > I only get sporadic crashes, though. Humorously, I've been
> > > runningonly Firefox, crash reporter andMate Terminal this morning
> > > and it's run fine for over 4 hours. Therewere times when I
> > > wouldn't runanything at all and it's lock up on me. So I just
> > > can't find anycommon denominator for this (using vi in terminal
> > > to type this - going to copy-paste into email client[Evolution]
> > > once I'm done this).
> > > I've attached 3 crash reports that were captured on the system
> > > overthe last couple days. I apologizein advance - profusely! - if
> > > the problem turns out to be somewhere else. 
> > > Thanks,Tim 
> > > _______________________________________________amd-gfx mailing 
> > > listamd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> 
> 

--=-VHHYDZt5PSTsivUZveRl
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html dir=3D"ltr"><head></head><body style=3D"text-align:left; direction:lt=
r;"><div>Posted the following comment to the Mate-desktop issue:</div><div>=
<br></div><div><div class=3D"comment js-suggested-changes-container" data-t=
hread-side=3D"">
  <div class=3D"comment-body markdown-body js-preview-body" style=3D"min-he=
ight: 276px;"><p>Had
 another hang with the same configuration as a youtube video played via a
 USB headphone (Jabra40). I was able to recover by killing Firefox, in=20
which the video was playing. The video became choppy and garbled and=20
then stopped. The stderr is below:</p>
<div class=3D"snippet-clipboard-content position-relative"><pre><code>ALSA =
lib conf.c:5187:(snd_config_expand) Unknown parameters 1
ALSA lib control.c:1379:(snd_ctl_open_noupdate) Invalid CTL sysdefault:1
ALSA lib conf.c:5187:(snd_config_expand) Unknown parameters 2
ALSA lib control.c:1379:(snd_ctl_open_noupdate) Invalid CTL sysdefault:2
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
ALSA lib pcm_dmix.c:1089:(snd_pcm_dmix_open) unable to open slave
</code></pre></div>
<p>On re-launch of Firefox from terminal window, the following appeared:<br=
>
<code>[GFX1-]: More than 1 GPU from same vendor detected via PCI, cannot de=
duce device</code></p></div></div></div><div>On Thu, 2021-07-29 at 12:04 -0=
400, Tim Cahill wrote:</div><blockquote type=3D"cite" style=3D"margin:0 0 0=
 .8ex; border-left:2px #729fcf solid;padding-left:1ex"><div>I apologize if =
the name callout is disconcerting. I was trying to follow instructions for =
sending bugs and saw your name listed as the owner of this code area.&nbsp;=
</div><div><br></div><div>FYI, I'd done some more troubleshooting and tinke=
ring regarding the crashing and Mate seems to be at the center of all the i=
ssues. As a result, I also opened an Issue with the Mate Desktop team (<a h=
ref=3D"https://github.com/mate-desktop/mate-panel/issues/1242">https://gith=
ub.com/mate-desktop/mate-panel/issues/1242</a>). Mate also has a power mana=
gement component, which is probably responsible for the excess logging and =
the confusion over Navil10. However, I have no way to vouch for now accurat=
ely the Mate PM applet gathered data for its instantiation. I have no exter=
nal devices connected that I'm aware would use it since I thought that was =
via HDMI. I *do* have a Jabra Evolve2 headset that uses the TypeC USB conne=
ctor, but I assume that's not using the GPU.</div><div><br></div><div>The i=
ssue documentation I left with Mate notes that if I launch apps from a term=
inal that is NOT launched from the Mate panel (right-click on desktop inste=
ad to open terminal), the parent for all the apps (Firefox, Evolution, etc.=
) is separate from Mate (at least separate from mate-panel). Everything has=
 worked fine (except for the constant logging of the wake-up action) since =
I've done that (and turned off the screensaver and screensaver lock). So, I=
'm not sure what else to do at this point. Please advise if I should do any=
thing on the driver side.</div><div><br></div><div>Thanks,</div><div>Tim&nb=
sp;</div><div><br></div><div>On Thu, 2021-07-29 at 11:14 -0400, Felix Kuehl=
ing wrote:</div><blockquote type=3D"cite" style=3D"margin:0 0 0 .8ex; borde=
r-left:2px #729fcf solid;padding-left:1ex"><pre>Am 2021-07-28 um 12:10 p.m.=
 schrieb Tim Cahill:</pre><blockquote type=3D"cite" style=3D"margin:0 0 0 .=
8ex; border-left:2px #729fcf solid;padding-left:1ex"><pre>Hi Felix,</pre></=
blockquote><br><pre>I'm not sure why you're calling me out by name. I'm not=
 working on</pre><pre>anything obviously related to your crashes.</pre><br>=
<pre>Anyway, I took a quick look at the backtraces. They all point at libgd=
k.</pre><pre>Two of them are segfaults, one is an abort. It's not clear how=
 these</pre><pre>would be related to the GPU driver. That said, when you bo=
ot with</pre><pre>nomodeset, the GPU driver and all HW acceleration is comp=
letely</pre><pre>disabled. If that makes the problem disappear, the GPU dri=
ver is clearly</pre><pre>involved in the problem in some way.</pre><br><pre=
>The abort points at a problem while freeing memory. This could be caused</=
pre><pre>by a double-free problem in some unrelated code, possibly related =
to the</pre><pre>GPU driver. This would be a problem in a user mode compone=
nt (maybe</pre><pre>Mesa), not the kernel mode driver.</pre><br><pre>I beli=
eve the messages you're seeing when you move the mouse are the</pre><pre>re=
sult of runtime power management that puts the GPU to sleep when it's</pre>=
<pre>idle and reinitializes it when it's needed. You have 2 GPUs in your</p=
re><pre>laptop, an integrated Renoir GPU in the Ryzen CPU, and an external<=
/pre><pre>Navi10 GPU for higher gaming performance. The GPU that goes to sl=
eep and</pre><pre>wakes up is the external Navi10 GPU.</pre><br><pre>The Op=
enGL renderer string specifies "RENOIR". Therefore I'm surprised</pre><pre>=
that the Navi10 GPU wakes up when you move the mouse. Ideally it</pre><pre>=
shouldn't be used at all when you're just using the desktop.</pre><br><pre>=
If you suspect that runtime power management is responsible for your</pre><=
pre>problems, you could disable it with amdgpu.runpm=3D0 on the kernel comm=
and</pre><pre>line. That means the Navi10 GPU won't go into the low power m=
ode and</pre><pre>drain your battery more quickly. So this is not a permane=
nt solution.</pre><pre>Just an experiment to narrow down the problem.</pre>=
<br><pre>Regards,</pre><pre>&nbsp; Felix</pre><br><br><blockquote type=3D"c=
ite" style=3D"margin:0 0 0 .8ex; border-left:2px #729fcf solid;padding-left=
:1ex"><br><pre>I'm not sure how to do this as I haven't had to report a bug=
 before.</pre><pre>I've looked to a variety of bug reporting sites to see i=
f anyone else</pre><pre>is running into the same issues that I'm having (su=
ch as the Mate</pre><pre>project) and haven't seen anything at all similar =
to the issue I'm</pre><pre>having. Since I had issues with AMD drivers with=
 my distro (info</pre><pre>below) and some consistent and high volume dmesg=
 content shows up,</pre><pre>I've decided that I should start here with the=
 AMD kernel team.</pre><br><pre>I have a fairly new MSI laptop with the fol=
lowing configuration:</pre><br><pre>[code]</pre><pre>System:&nbsp;&nbsp;&nb=
sp;&nbsp;Kernel: 5.11.0-25-generic x86_64 bits: 64 compiler: N/A</pre><pre>=
Desktop: MATE 1.24.0 wm: marco&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;dm: LightDM Distro: Linux Mint 20.2 U=
ma base: Ubuntu 20.04</pre><pre>focal&nbsp;</pre><pre>Machine:&nbsp;&nbsp;&=
nbsp;Type: Laptop System: Micro-Star product: Alpha 17 A4DEK v:</pre><pre>R=
EV:1.0 serial: &lt;filter&gt;&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Chassis: type: 10 serial: &lt;filter&g=
t;&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;Mobo: Micro-Star model: MS-17EK v: REV:1.0 serial: &lt;filter&gt;=
</pre><pre>UEFI: American Megatrends&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v: E17EKAMS.101 date: 10/26/202=
0&nbsp;</pre><pre>Battery:&nbsp;&nbsp;&nbsp;ID-1: BAT1 charge: 66.2 Wh cond=
ition: 67.0/65.7 Wh (102%)</pre><pre>volts: 12.4/10.8&nbsp;</pre><pre>&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;model: MSI Cor=
p. MS-17EK serial: N/A status: Unknown&nbsp;</pre><pre>CPU:&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;Topology: 8-Core model: AMD Ryzen 7 4800H with Ra=
deon</pre><pre>Graphics bits: 64 type: MT MCP&nbsp;</pre><pre>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;arch: Zen rev: 1 L2 ca=
che: 4096 KiB&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;flags: avx avx2 lm nx pae sse sse2 sse3 sse4_1 sse4_2 =
sse4a</pre><pre>ssse3 svm bogomips: 92630&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Speed: 4278 MHz min/max: 1=
400/2900 MHz Core speeds (MHz):</pre><pre>1: 4280 2: 1865 3: 1397&nbsp;</pr=
e><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4:=
 2188 5: 1489 6: 2265 7: 1907 8: 1906 9: 1729 10: 1397</pre><pre>11: 1397 1=
2: 1397 13: 1397&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;14: 1397 15: 1907 16: 1740&nbsp;</pre><pre>Graphics=
:&nbsp;&nbsp;Device-1: AMD Navi 10 [Radeon RX 5600 OEM/5600 XT /</pre><pre>=
5700/5700 XT]&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;vendor: Micro-Star MSI driver: amdgpu v: kernel bus ID=
:</pre><pre>03:00.0 chip ID: 1002:731f&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Device-2: AMD Renoir vendor: =
Micro-Star MSI driver: amdgpu</pre><pre>v: kernel bus ID: 08:00.0&nbsp;</pr=
e><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ch=
ip ID: 1002:1636&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;Display: x11 server: X.Org 1.20.9 driver: amdgpu,at=
i&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;unloaded: fbdev,modesetting,radeon,vesa compositor: marco</pre><pr=
e>resolution: 1920x1080~144Hz&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OpenGL: renderer: AMD RENOIR (DRM 3.40=
.0 5.11.0-25-generic</pre><pre>LLVM 11.0.0)&nbsp;</pre><pre>&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v: 4.6 Mesa 20.2.6 direc=
t render: Yes&nbsp;</pre><pre>Audio:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Device-1:=
 AMD Navi 10 HDMI Audio vendor: Micro-Star MSI</pre><pre>driver: snd_hda_in=
tel v: kernel&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;bus ID: 03:00.1 chip ID: 1002:ab38&nbsp;</pre><pre>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Device-2: AM=
D Raven/Raven2/FireFlight/Renoir Audio</pre><pre>Processor vendor: Micro-St=
ar MSI&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;driver: N/A bus ID: 08:00.5 chip ID: 1022:15e2&nbsp;</pre><pr=
e>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Device-=
3: AMD Family 17h HD Audio vendor: Micro-Star MSI</pre><pre>driver: snd_hda=
_intel&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;v: kernel bus ID: 08:00.6 chip ID: 1022:15e3&nbsp;</pre><pre>=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Sound Ser=
ver: ALSA v: k5.11.0-25-generic&nbsp;</pre><pre>Network:&nbsp;&nbsp;&nbsp;D=
evice-1: Intel Wi-Fi 6 AX200 driver: iwlwifi v: kernel bus</pre><pre>ID: 04=
:00.0&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;chip ID: 8086:2723&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IF: wlp4s0 state: up mac: &lt;filter=
&gt;&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;Device-2: Realtek RTL8111/8168/8411 PCI Express Gigabit</pre><p=
re>Ethernet vendor: Micro-Star MSI&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;driver: r8169 v: kernel port: f00=
0 bus ID: 05:00.0 chip ID:</pre><pre>10ec:8168&nbsp;</pre><pre>&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;IF: eno1 state: down =
mac: &lt;filter&gt;&nbsp;</pre><pre>Drives:&nbsp;&nbsp;&nbsp;&nbsp;Local St=
orage: total: 476.94 GiB used: 89.79 GiB (18.8%)&nbsp;</pre><pre>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ID-1: /dev/nvme0n1 =
vendor: Kingston model: OM8PCP3512F-AI1</pre><pre>size: 476.94 GiB&nbsp;</p=
re><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;s=
peed: 31.6 Gb/s lanes: 4 serial: &lt;filter&gt;&nbsp;</pre><pre>Partition: =
ID-1: / size: 466.30 GiB used: 89.28 GiB (19.1%) fs: ext4</pre><pre>dev: /d=
ev/dm-1&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;ID-2: /boot size: 704.5 MiB used: 519.7 MiB (73.8%) fs:</pre=
><pre>ext4 dev: /dev/nvme0n1p2&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;ID-3: swap-1 size: 980.0 MiB used: 0 =
KiB (0.0%) fs: swap</pre><pre>dev: /dev/dm-2&nbsp;</pre><pre>USB:&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hub: 1-0:1 info: Full speed (or root) Hub p=
orts: 4 rev: 2.0</pre><pre>chip ID: 1d6b:0002&nbsp;</pre><pre>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Device-1: 1-3:2 info: =
SteelSeries ApS SteelSeries KLC type:</pre><pre>HID&nbsp;</pre><pre>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;driver: hid-gene=
ric,usbhid rev: 2.0 chip ID: 1038:1122&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Device-2: 1-4:3 info: Acer HD=
 Webcam type: Video driver:</pre><pre>uvcvideo rev: 2.0&nbsp;</pre><pre>&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;chip ID: 598=
6:211c&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;Hub: 2-0:1 info: Full speed (or root) Hub ports: 2 rev: 3.1</=
pre><pre>chip ID: 1d6b:0003&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Hub: 3-0:1 info: Full speed (or root) Hu=
b ports: 4 rev: 2.0</pre><pre>chip ID: 1d6b:0002&nbsp;</pre><pre>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Device-3: 3-3:2 inf=
o: Intel type: Bluetooth driver: btusb</pre><pre>rev: 2.0 chip ID: 8087:002=
9&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;Hub: 4-0:1 info: Full speed (or root) Hub ports: 2 rev: 3.1</pre><=
pre>chip ID: 1d6b:0003&nbsp;</pre><pre>Sensors:&nbsp;&nbsp;&nbsp;System Tem=
peratures: cpu: 46.5 C mobo: N/A&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fan Speeds (RPM): N/A&nbsp;</pre><p=
re>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;GPU: d=
evice: amdgpu temp: 0 C fan: 65535 device: amdgpu</pre><pre>temp: 31 C&nbsp=
;</pre><pre>Repos:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No active apt repos in: /et=
c/apt/sources.list&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;Active apt repos in:</pre><pre>/etc/apt/sources.l=
ist.d/official-package-repositories.list&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1: deb http: //mirrors.seas=
.harvard.edu/linuxmint-packages</pre><pre>uma main upstream import backport=
</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;2: deb http: //mirror.us-ny2.kamatera.com/ubuntu focal main</pre><pre>res=
tricted universe multiverse</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;3: deb http: //mirror.us-ny2.kamatera.com/ubun=
tu</pre><pre>focal-updates main restricted universe multiverse</pre><pre>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;4: deb http=
: //mirror.us-ny2.kamatera.com/ubuntu</pre><pre>focal-backports main restri=
cted universe multiverse</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;5: deb http: //security.ubuntu.com/ubuntu/ focal-=
security</pre><pre>main restricted universe multiverse</pre><pre>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;6: deb http: //arch=
ive.canonical.com/ubuntu/ focal partner</pre><pre>Info:&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;Processes: 372 Uptime: 2h 44m Memory: 15.10 GiB used: 1.15<=
/pre><pre>GiB (7.6%) Init: systemd&nbsp;</pre><pre>&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;v: 245 runlevel: 5 Compilers: gcc=
: 9.3.0 alt: 9 Client:</pre><pre>Unknown python3.8 client&nbsp;</pre><pre>&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;inxi: 3.0.=
38&nbsp;</pre><pre>[/code]</pre><br><br><pre>If I am using it interactively=
, I get random crashes that seems to hit</pre><pre>elements of mate (mate-p=
anel, etc.)&nbsp;</pre><pre>consistently - just not predictably. LibreOffic=
e applications, xed,</pre><pre>Firefox, and Evolution seem to be more prone=
</pre><pre>to crashing the X session. I can easily move to tty1, login, and=
 kill</pre><pre>services running in tty7 as the crashes</pre><pre>don't app=
ear to completely kill tty7. Sometimes, I can kill mate and</pre><pre>launc=
h a new instance to salvage</pre><pre>the tty7 session. However, i usually =
end up having to kill the root</pre><pre>pid of the xwindows session in ord=
er</pre><pre>to re-login. But I think this is related to the AMD GPU driver=
 because</pre><pre>every &nbsp;time I simply move the mouse in&nbsp;</pre><=
pre>tty7 session, I get the following in dmesg:</pre><br><pre>[13164.399550=
] [drm] PCIE GART of 512M enabled (table at</pre><pre>0x0000008000000000).<=
/pre><pre>[13164.399579] [drm] PSP is resuming...</pre><pre>[13164.486593] =
[drm] reserve 0xa00000 from 0x800f400000 for PSP TMR</pre><pre>[13164.67878=
8] amdgpu 0000:03:00.0: amdgpu: RAS: optional ras ta ucode</pre><pre>is not=
 available</pre><pre>[13164.702624] amdgpu 0000:03:00.0: amdgpu: RAP: optio=
nal rap ta ucode</pre><pre>is not available</pre><pre>[13164.702639] amdgpu=
 0000:03:00.0: amdgpu: SMU is resuming...</pre><pre>[13164.702648] amdgpu 0=
000:03:00.0: amdgpu: smu driver if version =3D</pre><pre>0x00000036, smu fw=
 if version =3D 0x00000037, smu fw version =3D</pre><pre>0x002a3f00 (42.63.=
0)</pre><pre>[13164.702664] amdgpu 0000:03:00.0: amdgpu: SMU driver if vers=
ion not</pre><pre>matched</pre><pre>[13164.746143] amdgpu 0000:03:00.0: amd=
gpu: SMU is resumed successfully!</pre><pre>[13164.768978] [drm] kiq ring m=
ec 2 pipe 1 q 0</pre><pre>[13164.779651] [drm] VCN decode and encode initia=
lized</pre><pre>successfully(under DPG Mode).</pre><pre>[13164.779758] [drm=
] JPEG decode initialized successfully.</pre><pre>[13164.779779] amdgpu 000=
0:03:00.0: amdgpu: ring gfx_0.0.0 uses VM inv</pre><pre>eng 0 on hub 0</pre=
><pre>[13164.779783] amdgpu 0000:03:00.0: amdgpu: ring comp_1.0.0 uses VM</=
pre><pre>inv eng 1 on hub 0</pre><pre>[13164.779784] amdgpu 0000:03:00.0: a=
mdgpu: ring comp_1.1.0 uses VM</pre><pre>inv eng 4 on hub 0</pre><pre>[1316=
4.779785] amdgpu 0000:03:00.0: amdgpu: ring comp_1.2.0 uses VM</pre><pre>in=
v eng 5 on hub 0</pre><pre>[13164.779786] amdgpu 0000:03:00.0: amdgpu: ring=
 comp_1.3.0 uses VM</pre><pre>inv eng 6 on hub 0</pre><pre>[13164.779787] a=
mdgpu 0000:03:00.0: amdgpu: ring comp_1.0.1 uses VM</pre><pre>inv eng 7 on =
hub 0</pre><pre>[13164.779788] amdgpu 0000:03:00.0: amdgpu: ring comp_1.1.1=
 uses VM</pre><pre>inv eng 8 on hub 0</pre><pre>[13164.779789] amdgpu 0000:=
03:00.0: amdgpu: ring comp_1.2.1 uses VM</pre><pre>inv eng 9 on hub 0</pre>=
<pre>[13164.779790] amdgpu 0000:03:00.0: amdgpu: ring comp_1.3.1 uses VM</p=
re><pre>inv eng 10 on hub 0</pre><pre>[13164.779792] amdgpu 0000:03:00.0: a=
mdgpu: ring kiq_2.1.0 uses VM inv</pre><pre>eng 11 on hub 0</pre><pre>[1316=
4.779793] amdgpu 0000:03:00.0: amdgpu: ring sdma0 uses VM inv eng</pre><pre=
>12 on hub 0</pre><pre>[13164.779803] amdgpu 0000:03:00.0: amdgpu: ring sdm=
a1 uses VM inv eng</pre><pre>13 on hub 0</pre><pre>[13164.779804] amdgpu 00=
00:03:00.0: amdgpu: ring vcn_dec uses VM inv</pre><pre>eng 0 on hub 1</pre>=
<pre>[13164.779805] amdgpu 0000:03:00.0: amdgpu: ring vcn_enc0 uses VM inv<=
/pre><pre>eng 1 on hub 1</pre><pre>[13164.779806] amdgpu 0000:03:00.0: amdg=
pu: ring vcn_enc1 uses VM inv</pre><pre>eng 4 on hub 1</pre><pre>[13164.779=
807] amdgpu 0000:03:00.0: amdgpu: ring jpeg_dec uses VM inv</pre><pre>eng 5=
 on hub 1</pre><pre>[13164.783807] amdgpu 0000:03:00.0: [drm] Cannot find a=
ny crtc or sizes</pre><pre>[13170.722306] [drm] free PSP TMR buffer</pre><b=
r><pre>If I boot with nomodeset, I can operate fine - just without screen</=
pre><pre>brightness control, etc. It just</pre><pre>seems strange that an e=
vent is generated like this all the time.</pre><br><pre>I only get sporadic=
 crashes, though. Humorously, I've been running</pre><pre>only Firefox, cra=
sh reporter and</pre><pre>Mate Terminal this morning and it's run fine for =
over 4 hours. There</pre><pre>were times when I wouldn't run</pre><pre>anyt=
hing at all and it's lock up on me. So I just can't find any</pre><pre>comm=
on denominator for this (using vi&nbsp;</pre><pre>in terminal to type this =
- going to copy-paste into email client</pre><pre>[Evolution] once I'm done=
 this).</pre><br><pre>I've attached 3 crash reports that were captured on t=
he system over</pre><pre>the last couple days. I apologize</pre><pre>in adv=
ance - profusely! - if the problem turns out to be somewhere else.&nbsp;</p=
re><br><pre>Thanks,</pre><pre>Tim&nbsp;</pre><br><pre>_____________________=
__________________________</pre><pre>amd-gfx mailing list</pre><a href=3D"m=
ailto:amd-gfx@lists.freedesktop.org"><pre>amd-gfx@lists.freedesktop.org</pr=
e></a><br><a href=3D"https://lists.freedesktop.org/mailman/listinfo/amd-gfx=
"><pre>https://lists.freedesktop.org/mailman/listinfo/amd-gfx</pre></a><br>=
</blockquote><br></blockquote>
</blockquote></body></html>

--=-VHHYDZt5PSTsivUZveRl--

