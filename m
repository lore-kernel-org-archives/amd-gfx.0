Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4E8C47422
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jan 2024 22:19:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CE4710FF3A;
	Fri, 26 Jan 2024 22:19:30 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A7D10FF3A
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 22:19:28 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-5999f3f6ce9so818808eaf.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jan 2024 14:19:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=umich.edu; s=google-2016-06-03; t=1706307508; x=1706912308;
 darn=lists.freedesktop.org; 
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jx7ou7mA4o/RoHNoKh9YjfAJL3stbiT0dNuFIDE2RSg=;
 b=ISHrI4msdvFFYeRUp0ViVLu80F2DzwUYtXrIirExE+YHTj/zfi/5iSbUG08gi5lwqR
 rRLSZIMmVLnk3wJKOTrVxxmBHiizXbdZwXob9jOvJjD0RDrcNDlGFmXNJVyTT9I9Cdlw
 s7rcDv8S0qhd0wmRqTRSoi/rYg6PZSLV1mr/fuAxH61BWrhXgMhBEg9GwZ3j1ZsVOmIO
 gtK/5KJWNxXAIGdpVVzJtNsxaAZUHGVVQDHmVyxhOLUG0FO2ueOuucIMkW0E6fzStA0H
 taRWxo+LoS9FzuGFXyd8JfxIIVQ28MpkfSIWhsrLjFSV7a2s86XD9FJnyEZ8M14D0u58
 JUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706307508; x=1706912308;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jx7ou7mA4o/RoHNoKh9YjfAJL3stbiT0dNuFIDE2RSg=;
 b=X+tjXGrsEgPvJd/eEaps9gIgbYkEEJVFG2TA6TmdXCRUg9Ni21WXKrp+LA2VISPCaK
 iumD16eJwJGvcKEjymhDiT+uOINxUOKYjYKFFerbLA3uwojOLrggeQ2YxZgVQH8a1dLd
 1Eb610pUGVWaYHuySieAY6sQFtx8BB9vkUSoE9vP/YAe26MuBURZVT1YCkkR1c4t0eoU
 9wVlm49n3dE8u8YsBhLqs5j15xoIKpvD3W5TJv2zsc/KuEs60eLcfZdeZ9pND5OMvtAy
 1HKmSgYbaQlNWOXJKgQC+ql9CgcEZXmptNx2xcYnL9m6+vnzJcN1N8UCxDouzZwyqdbr
 rP4A==
X-Gm-Message-State: AOJu0Yy3RMJ3jdhAFJLUSuW/ECq/bxPGtr35bTrhR7UdeDkTfStT28pU
 pyY9EbwjQlCFLJr0Py9C2fIr/F1caRCtkmG6lUS251RU6OW4qcY4cCheszRM0bc=
X-Google-Smtp-Source: AGHT+IEstpAGQwg2cuAipRBoKETV1h+9VhXnN36+WuBSFjzcM7uju2tRrDTAVpkiJp3tYzo7NrL0sA==
X-Received: by 2002:a4a:d195:0:b0:599:f53f:7d9f with SMTP id
 j21-20020a4ad195000000b00599f53f7d9fmr552058oor.12.1706307507800; 
 Fri, 26 Jan 2024 14:18:27 -0800 (PST)
Received: from localhost (162-232-88-33.lightspeed.livnmi.sbcglobal.net.
 [162.232.88.33]) by smtp.gmail.com with ESMTPSA id
 d28-20020a4a3c1c000000b0059a157ba633sm174160ooa.31.2024.01.26.14.18.26
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 26 Jan 2024 14:18:27 -0800 (PST)
Date: Fri, 26 Jan 2024 17:18:26 -0500
From: William Bulley <web@umich.edu>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Message-ID: <20240126221826.GG660@dell4>
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

According to "Deucher, Alexander" <Alexander.Deucher@amd.com> on Fri, 01/26/24 at 16:28:
> 
> [AMD Official Use Only - General]
> 
> > Unfortunately, the mouse pointer is frozen at the exact center of the
> > 3440 x 1440 monitor, and it will not move.  I don't know how to fix this.  Any
> > help or ideas or suggestions would be greatly appreciated.
> 
> Make sure you have OS mouse and keyboard drivers loaded and configured within your X config?

In my /var/log/Xorg.0.log file I found this line:

   5261.770] (==) AMDGPU(0): Silken mouse enabled

but nothing else related to mouse or keyboard.

I thought those things didn't need to be configured.

Example 8 in the FreeBSD Handbook Chapter 5.1 addressed the
keyboard as "InputClass" not "InputDevice" as below:

   Example 8. Setting a Keyboard Layout

   /usr/local/etc/X11/xorg.conf.d/00-keyboard.conf

   Section "InputClass"
           Identifier "Keyboard1"
           MatchIsKeyboard "on"
           Option "XkbLayout" "es, fr"
           Option "XkbModel" "pc104"
           Option "XkbVariant" ",qwerty"
           Option "XkbOptions" "grp:win_space_toggle"
   EndSection

The /var/log/Xorg.0.log file had these lines after I added two
files: one for keyboard and one for mouose (see below);

[    74.787] (II) config/udev: Adding input device System keyboard multiplexer (/dev/input/event0)
[    74.787] (**) System keyboard multiplexer: Applying InputClass "Keyboard0"
[    74.787] (II) No input driver specified, ignoring this device.
[    74.787] (II) This device may have been added with another device file.
[    74.787] (II) config/udev: Adding input device System mouse (/dev/input/event1)
[    74.787] (II) No input driver specified, ignoring this device.

Here are my two added files:

unix% cd /usr/local/etc/X11/xorg.conf.d
unix% cat 00-keyboard.conf
Section "InputClass"
        Identifier      "Keyboard0"
        MatchIsKeyboard "on"
EndSection
unix% cat trackball.conf
Section "InputDevice"
        Identifier      "Mouse0"
        Driver          "mouse"
        Option          "Protocol"      "auto"
        Option          "Device"        "/dev/sysmouse"
EndSection

I think I need to change "InputClass" to "InputDevice" and add
a Driver line like this:

unix% cat keyboard.conf
Section "InputDevice"
        Identifier      "Keyboard0" 
        Driver          "kbd"
EndSection

After another reboot, still no mouse activity:

[    55.745] (II) config/udev: Adding input device System keyboard multiplexer (/dev/input/event0)
[    55.745] (II) No input driver specified, ignoring this device.
[    55.745] (II) This device may have been added with another device file.
[    55.745] (II) config/udev: Adding input device System mouse (/dev/input/event1)
[    55.745] (II) No input driver specified, ignoring this device.
[    55.745] (II) This device may have been added with another device file.

I don't know how to configure my mouse and keyboard so that X11/Xorg will
recognize them.  Please advise.  Thanks in advance.

-- 
William Bulley
E-MAIL: web@umich.edu
<web@umich.edu>
