Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 595F4C47DDB
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Jan 2024 19:38:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C56F610E878;
	Sun, 28 Jan 2024 19:38:53 +0000 (UTC)
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com
 [209.85.210.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8684110E878
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jan 2024 19:38:51 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id
 46e09a7af769-6e0a64d9449so1421681a34.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Jan 2024 11:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=umich.edu; s=google-2016-06-03; t=1706470671; x=1707075471;
 darn=lists.freedesktop.org; 
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xhFg0euwQd94lKaonX2H8VQfAuu53xHJO2j4YKc7i4Q=;
 b=MZY+8//0gdmuTJOOMFU9K2lXLEvvlCw7nttwgUhrAiS6FCHAZe8fyzd8y2kMSs06Hh
 6uVxHy7HJT1hTzgtx0vAAdVp25Xvv8bUPSaTZJMPlBG0cNbdO1eubhXVFHHMhJOlx3op
 2LJM4hHr59UBcCnPUhXZEfujL6FL3Lg2KS8lH7Ez6QkKdTgkL9Tp4tsNeJUXbcGnm9q7
 ne09fJrlnBd47bV9b2jfE5N2ESi8opmm5bRspNlvo8+QyIw8VB2Cb8H2dQzu4bNwSY4p
 Lw5FnLe3j7D0Xdldw1bjOas1uQakIQTy/24Wpq//crjGelD13bsWnRalfvIuGve2Lh+a
 1XUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706470671; x=1707075471;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xhFg0euwQd94lKaonX2H8VQfAuu53xHJO2j4YKc7i4Q=;
 b=ZP+Kc+aRMQPjXbfYPMGVssbsTtOqNkapP2km6aNqVJQ445hNeHiSx07LsZRbJEGssR
 y69xj9gSAv178rLqzC6z/WqRK31koiKMNLceHVUMeK+QcUljO59WQjEFu2klumJni7aY
 9y7cD3LrjGyMxvbZe41KnlClMKt+QT36L2M/YhWlB+SGItMzuRhxYcVyg4Rd16OqcyUI
 UbkaoldVAnLxncqZXrOwbQem1mKsvdNfzN/xMUCGMJKMH/j22bsFUY8UwIK9S5Mrppt0
 5ilj0sRkkv4f/PHPuxLZZudyVuSyxyQgQxMLxr6AAcTwXSKlPcQczbHDXWb0F7x4AiQc
 Eymg==
X-Gm-Message-State: AOJu0YyAj4eUI3RGc79nrUJT1wFCxMeofH+JFDJcphzXKjY9+CEqfthh
 95cOXhqZfFVDBbH57smN8xh1C8FiB5bjqyus/A6vMkz6GqpFRcY2XMNZ2Emoxo8=
X-Google-Smtp-Source: AGHT+IHEB+A4v0+1QPnGSw4BhUwZyW2rbm+SdwS1NAdowJhfWzGjd+itrfL7exdV1nDFtD2YdgdIPg==
X-Received: by 2002:a05:6830:87:b0:6e1:1437:8a45 with SMTP id
 a7-20020a056830008700b006e114378a45mr2752972oto.16.1706470670885; 
 Sun, 28 Jan 2024 11:37:50 -0800 (PST)
Received: from localhost (162-232-88-33.lightspeed.livnmi.sbcglobal.net.
 [162.232.88.33]) by smtp.gmail.com with ESMTPSA id
 s9-20020a0568301e0900b006d87e38f91asm1253324otr.56.2024.01.28.11.37.50
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sun, 28 Jan 2024 11:37:50 -0800 (PST)
Date: Sun, 28 Jan 2024 14:37:49 -0500
From: William Bulley <web@umich.edu>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Message-ID: <20240128193749.GB17405@dell4>
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
> Make sure you have OS mouse and keyboard drivers loaded
> and configured within your X config?

I got it to work!!!  Thanks to all who helped.

I got the clue I needed from this page this morning:

   https://fedoraproject.org/wiki/Input_device_configuration 

Here is the config that finally works:

unix% pwd
/usr/local/etc/X11/xorg.conf.d
unix% cat 10-driver.conf

Section "InputClass"
        Identifier      "Keyboard0"
        MatchIsKeyboard "on"
        Driver          "libinput"
EndSection

Section "InputClass"
        Identifier      "Mouse0"
        MatchIsPointer  "on"
        Driver          "libinput"
EndSection

Section "Device"
        Identifier      "Card0"
        Driver          "amdgpu"
        BusID           "PCI:41:0:0"
        Option          "DisplayPort-0" "Monitor0"
EndSection

-- 
William Bulley
E-MAIL: web@umich.edu
<web@umich.edu>
