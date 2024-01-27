Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB7DAC46CD2
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Jan 2024 16:59:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B040B10F2FC;
	Sat, 27 Jan 2024 16:59:12 +0000 (UTC)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEDD210F2E6
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Jan 2024 16:59:10 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id
 46e09a7af769-6e114e247a2so440027a34.0
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Jan 2024 08:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=umich.edu; s=google-2016-06-03; t=1706374684; x=1706979484;
 darn=lists.freedesktop.org; 
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QYFyUKrKbQZpla68OAEdW2ZmpQP/NDEHBMcFoXhuHrU=;
 b=h+9SncfNxKArM5HLkArdDVGxmyIVGgyv5TuObZIJ9yraGRzzkauCmBctSHIs+AOmMz
 NSAh2mF9Z3g0QZb5n0GbaRiy+FoYs8B80KDNWmvd3Q6n0NNIpchfP76cPKIgkNUMziZW
 n+dLHgdvxak/AW3vDs3OkE6HBqzX5T3JOcKQdVAW4F9a1lKb/uc9X3A0saMpmI9yzf5H
 o+7Bsy3fPJR/gV+kxO8EmRkENTW8rKqH5FCgIHWPUpzBuPbmX7vw3PpLLgT5JLueLGeX
 yuikvCi3bdk8Rca27rMyrMlqNdTlCB2teGd+UGDDXYEIYeZ+INxiqjIC+S8EmfSmJEx0
 PHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706374684; x=1706979484;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QYFyUKrKbQZpla68OAEdW2ZmpQP/NDEHBMcFoXhuHrU=;
 b=gGTIRMqczOVT5JRuRgjfRE6LyrymEV6FKokXA2TDYgJ8soACN2DGW3cMvIZGD+UMID
 p0XEi7FNOxzkfZvMq6jf3AxrvWLTIDptbF9v2je5uNrFldK0zGJMTNXcrUKyfv5AfeJQ
 kOqGHd2flV5F4O2Y4QXF5WdA7LG2DciT9rSg+5XxPY6iXE9TjRGmlNtnQB6T+LEr8a1O
 Dm0SNuC+983T1ZNbBsLwegKirJj423tWJ1AB6eRTpDtMITULm4cSVjNgs+YVJ2Pdi5G0
 RRSPfBZ5gZzdup+CnNDqnS1R+hkXrKi08VfdSMCIz8hZPtYCJQrBFH8c06cUE/unhzE7
 4iog==
X-Gm-Message-State: AOJu0YybYi0Oka3TOWANa+yWTuOi9bHhssuKYbJsI+Dajin4w1CxkNG3
 51bddfDEWG4ukWm1sPHIO5mOnus1bQUWDIZxZZ/dgFLnkKpbFnS5TKv55QJOe7o=
X-Google-Smtp-Source: AGHT+IG0lXnGVWe/Ve4O/g76ErKZsS1iuWEGm6nF1kQ0FBGlMINS2DZU7TV3epHmrClmsxTmtN1C8w==
X-Received: by 2002:a9d:6a02:0:b0:6df:b685:1fde with SMTP id
 g2-20020a9d6a02000000b006dfb6851fdemr1940377otn.30.1706374684490; 
 Sat, 27 Jan 2024 08:58:04 -0800 (PST)
Received: from localhost (162-232-88-33.lightspeed.livnmi.sbcglobal.net.
 [162.232.88.33]) by smtp.gmail.com with ESMTPSA id
 f17-20020a4ae611000000b0059a2114326csm272446oot.14.2024.01.27.08.58.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 27 Jan 2024 08:58:04 -0800 (PST)
Date: Sat, 27 Jan 2024 11:58:02 -0500
From: William Bulley <web@umich.edu>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Message-ID: <20240127165802.GA937@dell4>
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
> Make sure you have OS mouse and keyboard drivers loaded and configured within your X config?

Can you be more specific about this?  I have tried (and failed) to bring up a working
x11 session that doesn't have my mouse pointer frozen two different ways.

1) I removed both my keyboard.conf and trackball.conf files from my xorg.conf.d directory.

After rebooting and issuing a startx command, same thing: beautiful x11 screen but frozen mouse.

2) I replaced both keyboard.conf and trackball.conf into my xorg.conf.d directory.

unix% cat keyboard.conf
Section "InputClass"
        Identifier      "KeyboardDefaults"
        MatchIsKeyboard "on"
EndSection

unix% cat trackball.conf
Section "InputDevice"
        Identifier      "Mouse0"
        Driver          "mouse"
        Option          "Protocol"      "auto"
#       Option          "Device"        "/dev/sysmouse"
EndSection

I also tried variant of the keyboard.conf file using the Identifier "Keyboard0" and
again using a Section name "InputDevice" instead of "InputClass", still no change.

After rebooting and issuing a startx command, same thing: beautiful x11 screen but frozen mouse.

[    58.131] (II) config/udev: Adding input device System keyboard multiplexer (/dev/input/event0)
[    58.131] (II) No input driver specified, ignoring this device.
[    58.131] (II) This device may have been added with another device file.
[    58.131] (II) config/udev: Adding input device System mouse (/dev/input/event1)
[    58.131] (II) No input driver specified, ignoring this device.
[    58.131] (II) This device may have been added with another device file.

How am I supposed to specify an input driver for keyboard and mouse if not by
the use of those two files (or similar) in my xorg.conf.d directory?

-- 
William Bulley
E-MAIL: web@umich.edu
<web@umich.edu>
