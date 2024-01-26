Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BB35C47DDB
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 21:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F9EB10F38E;
	Fri, 26 Jan 2024 21:20:07 +0000 (UTC)
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com
 [209.85.161.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45FA610F38E
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 21:20:05 +0000 (UTC)
Received: by mail-oo1-f44.google.com with SMTP id
 006d021491bc7-59a1a03d067so100863eaf.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 13:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=umich.edu; s=google-2016-06-03; t=1706303944; x=1706908744;
 darn=lists.freedesktop.org; 
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=icW/6G+lwJD5ar+9Zz6hjtdOZSnyZdwdXBiV1XHLkb4=;
 b=JCudssOm0bQWTQEBFRn0+MYQMC1j9+1W/YT+Q62e/HpGrLufLu/hx6lDrjeu6pB/hC
 Uo+By/p2FTkdJtjpuxKmq1uM5q13eyw05j8wRFXzCh5KRhICTciwnTTuElPtckItIo5R
 SgOU5P0yvEgLYT/w2XQDAnW5HiLIw4EQV8Sp52Pmdxqpg3uk2ZeuTFaeqZIbJAufOU62
 PIP2Pjznn/azU+2gbCPjRsB0WasfxJl78kd+dJbwGtCzaKJnyklF+3FWVZRHg4G1qtPR
 wbmRbx3z0sywVmbG4yiz9bFItqRCFDX7hxWEWAOhfd+5xtSfwxIUlnzosiiJWBFzjHu/
 zYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706303944; x=1706908744;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=icW/6G+lwJD5ar+9Zz6hjtdOZSnyZdwdXBiV1XHLkb4=;
 b=pjJgmOMg+5p1RBCD6n3O/YhnUzuR5ZknsFp9zya2Vel0aEjaLQyloOxxjbFRw8qg0j
 xteuv0Zzznfn81ETQ75wEDSotb6F7J7X69uRRNJtFSiI5KZ53StG7vJpFnJD79sJti6S
 hQDFxjVdL5I93y4P/I1TtEq8Ba3FjRXxwxaCx5eaNMBrfKwAXtcPjZj88tIfRSEIL0ef
 jg0ymDfoPcCOBczvJs0QGMbQfNB9+1MfEA2AdkRwdeVskvEDhqqfSFB3yy6FSGytpRyY
 bcJBD4Xen4bVVZXUUb09nV0rhKnD41+bn0Edsm5oqTU+TnpiKuUg0h1yNRB12GSkKg4n
 yZzg==
X-Gm-Message-State: AOJu0Yx9A8CxAsjoaLWl9JO2K7d053Hzmx6+ymAetM8jUENb2vRobBPW
 7LPdn3oDyNfBj1BP0W9xqvHkq7Fl7uNzaOsEl8tBQ5VC0FyIoQb8r1uVAosdbM8=
X-Google-Smtp-Source: AGHT+IHafhooMOWt41IR1yBf9B3pW8uOkrv9KullO7NVspvUGBXR85ESMx0cVza27DfpX42/E3ReZQ==
X-Received: by 2002:a05:6820:228f:b0:59a:ebe:a256 with SMTP id
 ck15-20020a056820228f00b0059a0ebea256mr335629oob.7.1706303944627; 
 Fri, 26 Jan 2024 13:19:04 -0800 (PST)
Received: from localhost (162-232-88-33.lightspeed.livnmi.sbcglobal.net.
 [162.232.88.33]) by smtp.gmail.com with ESMTPSA id
 l1-20020a4aa781000000b0059997931582sm379385oom.22.2024.01.26.13.19.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jan 2024 13:19:04 -0800 (PST)
Date: Fri, 26 Jan 2024 16:19:02 -0500
From: William Bulley <web@umich.edu>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Message-ID: <20240126211902.GF660@dell4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

According to "Deucher, Alexander" <Alexander.Deucher@amd.com> on Fri, 01/26/24 at 15:50:
> 
> [Public]
> 
> Kernel driver looks like its loaded properly.
> 
> I don't really have much experience with freebsd, but it doesn't seem to be
> able to open the kernel driver.  Perhaps X starts before the kernel driver
> has finished loading?  Can you try and load the kernel driver and then start X?

After sending this and researching the forums some more, I made a few changes
and have had some success, but not quite there yet...

Using what I found in the forums I now have this one file in my
/usr/local/etc/X11/xorg.conf.d directory:

unix% cat /usr/local/etc/X11/xorg.conf.d/10-driver.conf
Section "Device"
        Identifier      "Card0"
        Driver          "amdgpu"
        BusID           "PCI:41:0:0"
EndSection

I got to this point today after learning about this the other day:

unix# pciconf -lv | grep -A4 vgapci
vgapci0@pci0:41:0:0:    class=0x030000 rev=0x10 hdr=0x00 vendor=0x1002 device=0x6981 subvendor=0x1002 subdevice=0x0b0d
    vendor     = 'Advanced Micro Devices, Inc. [AMD/ATI]'
    device     = 'Lexa XT [Radeon PRO WX 3200]'
    class      = display
    subclass   = VGA

I am not loading any relevant modules in my /boot/loader.conf file.

This line was added to my /etc/rc.conf file:

   kld_list="amdgpu"

I felt the amdgpu driver would support my WX 3200 (RS780) graphics card,
and after a reboot, I was proved correct.  Previously I was starting my
x11 session using the "startx" command from the vt0 virtual terminal.

Just minutes ago I logged into the virtual terminal vt2 on this system
as a non-root user.  There I entered the "startx" command and I was
completly surprised by the beautiful x11 session that appeared!!!

Unfortunately, the mouse pointer is frozen at the exact center of the
3440 x 1440 monitor, and it will not move.  I don't know how to fix
this.  Any help or ideas or suggestions would be greatly appreciated.

Thank you in advance.

-- 
William Bulley
E-MAIL: web@umich.edu
<web@umich.edu>
