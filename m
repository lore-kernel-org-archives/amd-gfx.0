Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E738FED2E5
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 07:48:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3B5810E989;
	Thu, 12 Mar 2026 07:48:12 +0000 (UTC)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com
 [209.85.217.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7457010E1FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 13:21:30 +0000 (UTC)
Received: by mail-vs1-f54.google.com with SMTP id
 ada2fe7eead31-5ffa277c115so4957550137.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 06:21:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235289; x=1773840089;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=34DR94e/1PAvLLEaib58vFA4GW0m5SGe6jvxchEhMek=;
 b=ClI5TnDFkoQKugjxhkWxEt090+6sD0SHJjc21i9GQVJMkUMx6VyiaO3jIhRrtABc3T
 Q/RMYNxJY61tMwc8IqG2jy2ZdwlaWxnQeXC828JTOirw2mtwzexKZQMvcvrwIpToT6UA
 k1LhmrGt7S5CB3bYhO59IatPbnfnlVRfo0V9dAsqM+oAIzF5msisth885X8N7W+Ln+Sy
 X7R1ugQkD9rVJKO7x4xIdF5YyspJGhbBIiq8/qCfFi6Lw7XPZL1X/ePcf+xuDz1YLqAY
 J72G5Y/jhs7BxewdAWzu/OSgUIk8YtaDdZT0Nd0X+xwB5R/Y9g5GoBoXQMkkTR7MrIyA
 zoEw==
X-Gm-Message-State: AOJu0Yw+4M9QBpu9sFPjCCrl5LO+E6E8lewyYVqCNHbULu2ryrsANv3K
 u4x7LjyRD127o9HR7tluMH1u/rwO1Zp4ge1k3Tv2IBPGsndXC+YkUL2o7aBSBrfdZoI=
X-Gm-Gg: ATEYQzxkuVpbMb9uO8n8hait07BiDK3Iq0arxShywNf+wuug0ZGgaOZP1nyLICgsVZW
 ChYQBpK+bzoiK7zvJ8tl67jsLNs5BsTcUPQl7a7EDq1uGKCXHpMmWZ3VdYMzxg2YoYFIAzNRTmf
 6gyJ3OWEhiiax1m3ndQLlK8l27a0XM5nV2b0FzH6CxbUeF+LzjYPDuzIK5tiKjmtGiJX3aSRBTJ
 u/Wtb2lRI0lZCOiQ7fD8hRhBn41NczO6XDRKMJ8V7gge3YC8z4jGwr7OsEgSHfmbY/We1kQO5Q0
 jKRtpF5Oy/bvt/tdXFvS6hZhkVuAMmABRMITL+YALEgx1LIoBESfVp2oitLj6Cq+Io/+Dvnh2XL
 3bw7DJqFtp/D7Df3yUvcway6jW2N0X+7GL2PG8xNHa58U8Fzizvt3hyk5SD0CYI0+kQ3LDjyw+g
 JK5PwCj6MuzCvH5v1h7IHNCTVeCiayL1tsXkHxe9R56cwJyX3QZ3TYqDiVisjm
X-Received: by 2002:a05:6102:5127:b0:5e5:6eee:8adb with SMTP id
 ada2fe7eead31-601debc4075mr1016053137.4.1773235289272; 
 Wed, 11 Mar 2026 06:21:29 -0700 (PDT)
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com.
 [209.85.217.42]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-601de6c9c9bsm718623137.3.2026.03.11.06.21.29
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Mar 2026 06:21:29 -0700 (PDT)
Received: by mail-vs1-f42.google.com with SMTP id
 ada2fe7eead31-5fff18d44fbso3420746137.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Mar 2026 06:21:29 -0700 (PDT)
X-Received: by 2002:a05:6122:1d05:b0:55b:7494:177b with SMTP id
 71dfb90a1353d-56b4752d806mr922396e0c.10.1773234967338; Wed, 11 Mar 2026
 06:16:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
In-Reply-To: <20260310-b4-is_err_or_null-v1-36-bd63b656022d@avm.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 11 Mar 2026 14:15:56 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
X-Gm-Features: AaiRm52J84H77ROK64ZWWtJfaiCpnFeKyoSRmPbi-NC8CN6Ju1TJEFxJU9gZQQ8
Message-ID: <CAMuHMdXQ8Q4jvkgFRJYhghz2BZRDC-9Mk6DbXxuaOc6C9DFHZQ@mail.gmail.com>
Subject: Re: [PATCH 36/61] arch/sh: Prefer IS_ERR_OR_NULL over manual NULL
 check
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com, 
 bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr, 
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org, 
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev, kvm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, 
 linux-bluetooth@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-cifs@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-erofs@lists.ozlabs.org, linux-ext4@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-gpio@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, 
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org, 
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org, 
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org, 
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, ntfs3@lists.linux.dev, 
 samba-technical@lists.samba.org, sched-ext@lists.linux.dev, 
 target-devel@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
 v9fs@lists.linux.dev, Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 12 Mar 2026 07:48:09 +0000
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

On Tue, 10 Mar 2026 at 12:56, Philipp Hahn <phahn-oss@avm.de> wrote:
> Prefer using IS_ERR_OR_NULL() over using IS_ERR() and a manual NULL
> check.
>
> Change generated with coccinelle.
>
> To: Yoshinori Sato <ysato@users.sourceforge.jp>
> To: Rich Felker <dalias@libc.org>
> To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
