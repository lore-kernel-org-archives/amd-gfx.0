Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED576C47DDB
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jan 2024 19:01:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65731112A9D;
	Mon, 29 Jan 2024 19:01:22 +0000 (UTC)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 77F0D112A9D
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 19:01:20 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 006d021491bc7-59502aa878aso1590681eaf.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jan 2024 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=umich.edu; s=google-2016-06-03; t=1706554818; x=1707159618;
 darn=lists.freedesktop.org; 
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sVAei17pjfTODhtrbqbUxVy1LaIM0Y4ieVG/Wsd0LJk=;
 b=FlLs+c1atUAsyp9I+vdCT7VFrCJgbPglWDQJI8jRs6WHImfVILtg+8eK09kufsdpZ7
 4xbWC031FnDTqCnmul+a5LNIYHz+DOcMXYwpikkSkAtUmvLSc85DmWpuq44fJcYzI+bf
 5DZ6QDNahmJXUOg6txjfDRPs8uj7eBmbMZWXwE3bDxF1QDbV8F0hoF2uq37B6akBLxL5
 GPpG83bdQ0eTiZ5DQLQAWlocOfcW1M6BoSbJW5UBBCXa7flxE0km513ybVdxd93BCUVS
 OpmeXKV9cwVqAv4KHWuODiEtHoUucDdfghe1zgPFjP5sdp+OiI5kkTGQqKIp6QLBPyZp
 Y6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706554818; x=1707159618;
 h=user-agent:content-disposition:mime-version:message-id:subject:cc
 :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sVAei17pjfTODhtrbqbUxVy1LaIM0Y4ieVG/Wsd0LJk=;
 b=MC+jdhsoqnK+b6AEJYHq0bPZvr/w3A+vOh/sbaE5j4VJ3G3ZdhBTMl6MrkOp/42VMb
 LKVZ4tLcNJH1lsExEk4X6BmsqV0a1WhcHt2tP6hZXB2nEZe/exDstIcr0Ly+A/LcojN0
 q/9nJY8YBMazNYqWjUEnNkPZ8s7KSl0F3cYzkOCUk+SvYpJD+8+6L90uJ0Eef8ojQjB6
 y7EuWxxdT+2NNscDLv0pTYQoDYQ6dPeGBIzDWPrtiwMyKPCltLxrHvYmPUplscWFC5Fk
 MiOnx1CVSiyVHXljeZYiprJ1DDb7preH1r+Spv5CpFyBbbSCoq1LCIFXuJiLW7uPERFq
 z5ug==
X-Gm-Message-State: AOJu0YwmWOv80Vvf34TkjG4nHVZ74n1lmyz8clEwzz+EXoe7UvghLPsB
 PPUc9zw4K+md/hVx3PZdP6i+9ofp8HtppqsffBBZP9Le2LRfT8mUFXiO+47fi6w=
X-Google-Smtp-Source: AGHT+IExGGzr0Q7PkfPOGeKAA2U8KjDHaf66HOOMW6n7d5+SXEbUqbD9qsA/na0E4Dxkulk70uKWmg==
X-Received: by 2002:a4a:cb05:0:b0:59a:12e7:f26 with SMTP id
 r5-20020a4acb05000000b0059a12e70f26mr4258508ooq.6.1706554818054; 
 Mon, 29 Jan 2024 11:00:18 -0800 (PST)
Received: from localhost (162-232-88-33.lightspeed.livnmi.sbcglobal.net.
 [162.232.88.33]) by smtp.gmail.com with ESMTPSA id
 e9-20020a4ae0c9000000b0059941d2db01sm1250246oot.11.2024.01.29.11.00.17
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 29 Jan 2024 11:00:17 -0800 (PST)
Date: Mon, 29 Jan 2024 14:00:16 -0500
From: William Bulley <web@umich.edu>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: Re: Have WX 3200 Radeon graphics card -- cannot get X11 session to
 work
Message-ID: <20240129190016.GD906@dell4>
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

According to "Deucher, Alexander" <Alexander.Deucher@amd.com> on Mon, 01/29/24 at 13:53:
> 
> [Public]
> 
> Glad to year you got it working!

Thanks!  Two additional things you might be able to point me to...

1) how do I unsubscribe to amd-gfx@lists.freedesktop.org
   (the control page doesn't think I'm a member so I can't unscbsrcibe)

2) see below for my "last" remaining problem:

I have new system H/W running FreeBSD 14.0-STABLE (from January 4th)
and I have x11/Xorg running successfully on an AMD Radeon WX 3200
graphics card.

The configuration for my keyboard on this new system is as follows:

  Section "InputClass"
        Identifier      "Keyboard0"
        MatchIsKeyboard "on"
        Driver          "libinput"
        Option          "XkbModel"      "Chicony PFU-65 USB Keyboard"
  EndSection

The keyboard works just fine, but the arrow keys do not work.

I have these ports installed:

xorg-7.7_3
xorg-server-21.1.11_1,1
libinput-1.25.0
xf86-input-libinput-1.3.0

On an older FreeBSD 13.2-STABLE system (with the same ports installed)
the same keyboard works just fine and the arrow keys respond as well.

The configuration for my keyboard on the older system is as follows:

Section "InputClass"
        Identifier              "KeyboardDefaults"
        MatchIsKeyboard         "on"
        Option                  "XkbModel"      "Chicony PFU-65 USB Keyboard"
EndSection

Note the lack of any "Driver" keyword.  I assume it is using the "kbd" driver.

I can supply contents of /var/log/Xorg.0.log files if necessary.

I would like my arrow keys to work on the new system.  Can anyone help me out?

Thank you in advance.

-- 
William Bulley
E-MAIL: web@umich.edu
<web@umich.edu>
