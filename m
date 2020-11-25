Return-Path: <SRS0=2cAG=FA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355CFC56202
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 08:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD00E20872
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2020 08:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="WifNdkif"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD00E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFB056E855;
	Thu, 26 Nov 2020 08:26:50 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E887E6EAAB
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 22:09:19 +0000 (UTC)
Received: by mail-pg1-x541.google.com with SMTP id j19so3631337pgg.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2020 14:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=u18D3LcbSYuoMMQXGcZuOSSHQ97aqFAj6PSwZPKzyfI=;
 b=WifNdkiftaOaD4ZZckvIqaLo1oDpErEfQOeEaPPqC9ugBqwKDiWX7cyNX9NNokqABc
 3rs8Xkh/xt0eSkb8xVKJLxbZ9ctD9N09POwkigNrKsLe837qPjgVNlPjii1YQ7Ys5fEN
 J1ztqI2SdAxczb+fxW5+t1BuuInt0J3EnKhYhGXUx/Ycs4OeMqDUGayCvZ/rK/2hwzHv
 fvNTfM4yxqfrW/W8EGBwEJD3ef8E6CIFveHPM/2Vwj3USBV6V1sXpGOaikzNc+dcQTTs
 sQr+N2RUFmFahGpkDJgGJRdpjSZFKGXDT4Evw9946EQKZvU8LN7QRJCs+4k3wXo2GKBl
 nncg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=u18D3LcbSYuoMMQXGcZuOSSHQ97aqFAj6PSwZPKzyfI=;
 b=DnOnninTNV7RV22pc8GqC/XhELiXjvoorwwFCxtjcz2ran0wApl3V/M2hlR9/xqGhg
 97WM0KpiPe3Ayaue8r6liVnEN0Yem6YeBMrJRiIR9DwJ/3zNNifeFau9z0SZmD5Kn3+U
 Ae5+z6Qc7e3YeAseRz+HT2DWSV3XiF/fOrrORkolhDbFHVU9WItxdyj6g1xObS0xYI4h
 a3IRmmXC5NKCS1NdRW/qoeV8s9n2iHb0oIcOepMEVexgLdesT0+ozle7S1aRN3Ahk+NH
 BG8UrYUt+zWPhEKQJjN/51e4mDNbmJAPboFnmaeOLGjTOSTypm0PEvdmver1cM5iJTCu
 nZuQ==
X-Gm-Message-State: AOAM532IcgoLl2jM0ZLk6XPP9x2plR9pt5MMRXbukhczZw7JZTDfVpmo
 4PY7b3bo6XE45cIlN+n+X06/TnYXhdSl7dyIDQwfRg==
X-Google-Smtp-Source: ABdhPJxX4YdX/dgPSH4qNW13nZ+NPFnsWrpBgteZRS2UfRF2x25a9zmwdzqZA/h0sTtapVP+ZBS7Enbowp+5Zxn/Mxo=
X-Received: by 2002:a17:90a:d250:: with SMTP id
 o16mr6463569pjw.25.1606342159332; 
 Wed, 25 Nov 2020 14:09:19 -0800 (PST)
MIME-Version: 1.0
References: <202011201129.B13FDB3C@keescook>
 <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook>
 <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <ca071decb87cc7e905411423c05a48f9fd2f58d7.camel@perches.com>
 <0147972a72bc13f3629de8a32dee6f1f308994b5.camel@HansenPartnership.com>
 <d8d1e9add08cdd4158405e77762d4946037208f8.camel@perches.com>
 <dbd2cb703ed9eefa7dde9281ea26ab0f7acc8afe.camel@HansenPartnership.com>
 <20201123130348.GA3119@embeddedor>
 <8f5611bb015e044fa1c0a48147293923c2d904e4.camel@HansenPartnership.com>
 <202011241327.BB28F12F6@keescook>
 <a841536fe65bb33f1c72ce2455a6eb47a0107565.camel@HansenPartnership.com>
 <CAKwvOdkGBn7nuWTAqrORMeN1G+w3YwBfCqqaRD2nwvoAXKi=Aw@mail.gmail.com>
 <20201125082405.1d8c23dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20201125082405.1d8c23dc@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 25 Nov 2020 14:09:08 -0800
Message-ID: <CAKwvOdkWGE5qdFZUuMzcL63LDOu_iZQJOGbeBNjcPi8sJPMkag@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 000/141] Fix fall-through warnings for
 Clang
To: Jakub Kicinski <kuba@kernel.org>
X-Mailman-Approved-At: Thu, 26 Nov 2020 08:26:38 +0000
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
Cc: alsa-devel@alsa-project.org, bridge@lists.linux-foundation.org,
 linux-iio@vger.kernel.org, linux-wireless <linux-wireless@vger.kernel.org>,
 linux-mmc@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-ide@vger.kernel.org, dm-devel@redhat.com, keyrings@vger.kernel.org,
 linux-mtd@lists.infradead.org, GR-everest-linux-l2@marvell.com,
 wcn36xx@lists.infradead.org, linux-i3c@lists.infradead.org,
 linux1394-devel@lists.sourceforge.net, linux-afs@lists.infradead.org,
 drbd-dev@lists.linbit.com, devel@driverdev.osuosl.org,
 linux-cifs@vger.kernel.org, rds-devel@oss.oracle.com,
 linux-scsi@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-rdma@vger.kernel.org, oss-drivers@netronome.com,
 linux-atm-general@lists.sourceforge.net, ceph-devel@vger.kernel.org,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 linux-stm32@st-md-mailman.stormreply.com, cluster-devel@redhat.com,
 usb-storage@lists.one-eyed-alien.net, coreteam@netfilter.org,
 intel-wired-lan@lists.osuosl.org, linux-input@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, xen-devel@lists.xenproject.org,
 linux-ext4@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netfilter-devel@vger.kernel.org, linux-media@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, selinux@vger.kernel.org,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>, intel-gfx@lists.freedesktop.org,
 linux-sctp@vger.kernel.org, reiserfs-devel@vger.kernel.org,
 linux-geode@lists.infradead.org, linux-block@vger.kernel.org,
 linux-gpio@vger.kernel.org, op-tee@lists.trustedfirmware.org,
 linux-mediatek@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-hams@vger.kernel.org, Nathan Chancellor <natechancellor@gmail.com>,
 linux-can@vger.kernel.org, Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-hwmon@vger.kernel.org,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 linux-watchdog@vger.kernel.org, GR-Linux-NIC-Dev@marvell.com,
 Linux Memory Management List <linux-mm@kvack.org>,
 Network Development <netdev@vger.kernel.org>,
 linux-decnet-user@lists.sourceforge.net, samba-technical@lists.samba.org,
 LKML <linux-kernel@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 linux-security-module@vger.kernel.org, linux-usb@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net,
 =?UTF-8?Q?open_list=3AHARDWARE_RANDOM_NUMBER_GENERATOR_CORE_=3Clinux=2Dcrypt?=
 =?UTF-8?Q?o=40vger=2Ekernel=2Eorg=3E=2C_patches=40opensource=2Ecirrus=2Ecom=2C_linux=2Dint?=
 =?UTF-8?Q?egrity=40vger=2Ekernel=2Eorg=2C_target=2Ddevel=40vger=2Ekernel=2Eorg=2C_linux=2D?=
 =?UTF-8?Q?hardening=40vger=2Ekernel=2Eorg=2C_Jonathan_Cameron_=3CJonathan=2ECamero?=
 =?UTF-8?Q?n=40huawei=2Ecom=3E=2C_Greg_KH?= <gregkh@linuxfoundation.org>,
 Joe Perches <joe@perches.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Nov 25, 2020 at 8:24 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Applying a real patch set and then getting a few follow ups the next day
> for trivial coding things like fallthrough missing or static missing,
> just because I didn't have the full range of compilers to check with
> before applying makes me feel pretty shitty, like I'm not doing a good
> job. YMMV.

I understand. Everyone feels that way, except maybe Bond villains and
robots.  My advice in that case is don't take it personally.  We're
working with a language that's more error prone relative to others.
While one would like to believe they are flawless, over time they
can't beat the aggregate statistics.  A balance between Imposter
Syndrome and Dunning Kruger is walked by all software developers, and
the fear of making mistakes in public is one of the number one reasons
folks don't take the plunge contributing to open source software or
even the kernel.  My advice to them is "don't sweat the small stuff."
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
