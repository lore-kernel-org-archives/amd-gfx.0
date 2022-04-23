Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F1A2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Apr 2022 07:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2521310E7C3;
	Mon, 25 Apr 2022 07:33:14 +0000 (UTC)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD10810E489
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Apr 2022 16:31:56 +0000 (UTC)
Received: by mail-lf1-x12b.google.com with SMTP id g19so19314339lfv.2
 for <amd-gfx@lists.freedesktop.org>; Sat, 23 Apr 2022 09:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:subject:message-id:mime-version;
 bh=A+4bwDc/fxhJPoJinnNWLGQDdeldBdMLh6UUu6Sf/Wo=;
 b=I/yETCcU1EWGcca3bru3w6rEyIcL9mU6w9WXZJeUKRFxueETvMonguraWImj7nmMui
 K3pSEyMP/ifEb3mCTcE+N1CUbJ7ZTcLpLZVh1oxcUHwmxVYU0Tl6jeJtXmDymY/nEvSd
 /OG4ecC2OCpF7HmSMPffwEyNwn60EovbCvENQ3uJPgl2vP6guKdXwu/ZXa6AurLb0xsp
 GArRiEHCex9S8TSUQVdBR/nH1s6zCjmxnvjxux2olA37HFvhvJaM1Dysa4mHQyaCUpbR
 QwulnQWuPCc4fuXHi2t8GwZ1zaPbJgqffQ/UnGfRcZt/OfXp+cAwsDirtLqtArs+7o5E
 8HwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:subject:message-id:mime-version;
 bh=A+4bwDc/fxhJPoJinnNWLGQDdeldBdMLh6UUu6Sf/Wo=;
 b=kBb/2cob9uubb3w/NQqXJXvcE2B/aHioYBH+QBCH1iKaYU10bgLk+V7tnu7+sLOsrN
 XgOLYsb3X6y/t1LelH13QR8ajhBFtI1LbCu+eAcBkgetM+uCF9kUbQMrAZTIbv5Bkzar
 J+NFfI5L44aptWzuxhMjni43GzRM5xnCheeqXb7rXxGRFUURvjF3PLXX9XJBLvaT4B89
 mA+eoksHWXIDZnu3/o6pZTTMZFtsuO7kDdYvJXHiZUnBUXiViXC1UOdtmkD0u6A0ax0S
 +2LTdKtgDlM/bhCZkvGJMQDWa5GsQCdWwTJImMuRgh7oTqAfVCK81r3AHwsJbtdOVLqD
 BUWg==
X-Gm-Message-State: AOAM533gKN6WVE4cAmZpGNFSkzv9XPIkiQtSzrypeHJaxeiY8r1S+GLF
 uhuTWdnmRfe8HJUJtnxLbjfZORYtLw==
X-Google-Smtp-Source: ABdhPJykNFrpY+p5YJCA0QcXSLUbwQqWyQo0T+wSZ8IscE4vS4RwvMCJkYT4Eg4Tf0TlP6/pchh+YA==
X-Received: by 2002:a05:6512:1328:b0:445:cefe:f8b7 with SMTP id
 x40-20020a056512132800b00445cefef8b7mr7042999lfu.34.1650731514225; 
 Sat, 23 Apr 2022 09:31:54 -0700 (PDT)
Received: from desktop (ppp85-141-144-80.pppoe.mtu-net.ru. [85.141.144.80])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a19384b000000b0046bbd144dfesm671990lfj.125.2022.04.23.09.31.53
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 Apr 2022 09:31:53 -0700 (PDT)
Date: Sat, 23 Apr 2022 19:31:45 +0300
From: Krylov Michael <sqarert@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: Screen corruption using radeon kernel driver
Message-ID: <20220423193145.3301ed06@desktop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/z0sqPSHN8+i79pqpAS4ynzJ";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Mailman-Approved-At: Mon, 25 Apr 2022 07:33:10 +0000
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

--Sig_/z0sqPSHN8+i79pqpAS4ynzJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello!=20

After updating my Linux kernel from version 4.19 (Debian 10 version) to
5.10 (packaged with Debian 11), I've noticed that the image
displayed on my older computer, 32-bit Pentium 4 using ATI Radeon X1950
AGP video card is severely corrupted in the graphical (Xorg and Wayland)
mode: all kinds of black and white stripes across the screen, some
letters missing, etc.

I've checked several options (Xorg drivers, Wayland instead of
Xorg, radeon.agpmode=3D-1 in kernel command line and so on), but the
problem persisted. I've managed to find that the problem was in the
kernel, as everything worked well with 4.19 kernel with everything
else being from Debian 11.

I have managed to find the culprit of that corruption, that is the
commit 33b3ad3788aba846fc8b9a065fe2685a0b64f713 on the linux kernel.
Reverting this commit and building the kernel with that commit reverted
fixes the problem. Disabling HIMEM also gets rid of that problem. But it
also leaves the system with less that 1G of RAM, which is, of course,
undesirable.

Apparently this problem is somewhat known, as I can tell after googling
for the commit id, see this link for example:
https://lkml.org/lkml/2020/1/9/518=20

Mageia distro, for example, reverted this commit in the kernel they are
building:

http://sophie.zarb.org/distrib/Mageia/7/i586/by-pkgid/b9193a4f85192bc57f4d7=
70fb9bb399c/files/32

I've reported this bug to Debian bugtracker, checked the recent verion
of the kernel (5.17), bug still persists. Here's a link to the Debian
bug page:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D993670

I'm not sure if reverting this commit is the correct way to go, so if
you need to check any changes/patches that I could apply and test on
the real hardware, I'll be glad to do that (but please keep in mind
that testing could take some time, I don't have access to this computer
24/7, but I'll do my best to respond ASAP).

Thanks in advance!

--Sig_/z0sqPSHN8+i79pqpAS4ynzJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEq9zNqT9shXHTn/gRzNfc0dbmrQAFAmJkKfEACgkQzNfc0dbm
rQC5Igf+MRIOJtqUYPUYBwpQmXbOQimRewkuB593yxmHvaObwREFB4lF02UGL2PJ
80gGKdqxnsLIqS6g+nLShHVl3tJHBNBT8shai8DONJxIqqWS1F55cp+i22CWLQej
tpWbxN2+xniLHxFBllmCQljQTO/sHAl6NGNL+kS2EFLmqHUBz44vA7tSkX3YX5Vg
tKSTOIQTDRofpLeQiVfyGp5NhMWR/vpu+XNTXNwh8qU9bR908Z6EG1gHvZAHM1q0
AJrT+kfXZSuBbxW35gnxqWWaY6MksNlE1P2EPY0erSAlpYMfJ9h0Tja/cIQC2oDX
pdxTegJLcq2WiM6xN0Bo4Fzbxdc56A==
=TRlD
-----END PGP SIGNATURE-----

--Sig_/z0sqPSHN8+i79pqpAS4ynzJ--
