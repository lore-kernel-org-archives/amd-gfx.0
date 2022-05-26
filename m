Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FAE5C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 26 May 2022 14:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111D910E079;
	Thu, 26 May 2022 14:06:24 +0000 (UTC)
X-Greylist: delayed 761 seconds by postgrey-1.36 at gabe;
 Thu, 26 May 2022 08:45:26 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1454C89A0F
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 May 2022 08:45:25 +0000 (UTC)
Received: from mail-yw1-f179.google.com ([209.85.128.179]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1McYTD-1nHVFX41uP-00cy1D; Thu, 26 May 2022 10:32:43 +0200
Received: by mail-yw1-f179.google.com with SMTP id
 00721157ae682-3003cb4e064so8041797b3.3; 
 Thu, 26 May 2022 01:32:42 -0700 (PDT)
X-Gm-Message-State: AOAM531N/HudEZGorq3fKAydNowP3ip64qB7x/YEfHBE1lVlHXbVwT9y
 5RzUumB1vmL99K7ft9JLIubLX5tgcsLFW5IO9+Y=
X-Google-Smtp-Source: ABdhPJzd1Td84PUKl1aMompoBi/CI7Ij8UKcDh3J33F17cieCWlpkBhuvBB90C07npKSjm4gZ1dqj3OUo1L9/csGNzA=
X-Received: by 2002:a81:488c:0:b0:302:549f:ffbc with SMTP id
 v134-20020a81488c000000b00302549fffbcmr1085051ywa.495.1653553961173; Thu, 26
 May 2022 01:32:41 -0700 (PDT)
MIME-Version: 1.0
References: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
In-Reply-To: <628ea118.wJYf60YnZco0hs9o%lkp@intel.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 26 May 2022 10:32:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a10aGYNr=nKZVzv+1n_DRibSCCkoCLuTDtmhZskBMWfyw@mail.gmail.com>
Message-ID: <CAK8P3a10aGYNr=nKZVzv+1n_DRibSCCkoCLuTDtmhZskBMWfyw@mail.gmail.com>
Subject: Re: [linux-next:master] BUILD REGRESSION
 8cb8311e95e3bb58bd84d6350365f14a718faa6d
To: kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:werSax4GIB20B3ktO8sePSa4Uwa9NWb+S1H6SkEJK5Yjs/WCrTH
 jMawQQYUm+Ms+ByahftALaGUx+GDqr8w8MTnGZXFjSPqexH7g/KY8oO4ZJZJAuqcmXEXSJ2
 0yXFST+jUfjXfzMC4bq9CS4BBNfSVywD3i7tP7y80FFtYv8yNtCPh174/6dA6mKBt2l+GOI
 YL/w7fEXvcSFhwbsEl1hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NoHNA3QQIh4=:43Hebz7tPRmN57uKllhmah
 1LaWkvkm/zbuZZnKuL4BxLCZe5BJG+WDAROG0WMvsDJDdHcUKNAQZnkF8eiebYTp6Do3m8awV
 5FR1upAqj/HVKnaEd9zsJ5WbuQWtqjMUDlCx96xmGdjZOg3p+N2dMRH0eh5D03uf/SzOspTV2
 8RdkKWCag7cdB9xz+45QZihWGpYG3Vd4YTFxvCKGgFoK6elDsB3vZ1heM6gj2DCrT+4TUdmvM
 7Erpsg8Bmb0D/jTO50aW0FLwrVfpCki9Ut4JE7QYTPnud1tu5D4ez9c4Arzc6WaLCa0P6yp4b
 RC0SFZVYU2mrXIr9pp79+1XrNa5t4iq4D5a/nX8r1VZ8Wc5l9xt3uZkW9rKitCeZeEbTfJaTm
 LYJP1DxriQnygzYvbJGM8OEFbBJX3G9KG2MDJAnMWcBApRTzlhalPKTXWIijtswgSFLTfEz9C
 8mOfs4kYXd/AUNQh9X0/+zzFUem0f8eAKE8eFXEbA+3ovEzQ3vq5Czy0bV3RDWg6oQ9l36tid
 toN/2K5eJ2yybDV28gWcSD5Yco10ak17CFWuSJu8iTwqFa5eGN+6cKD1clcIWhB5D/ot0VgNJ
 piwKZr6U6dMQHwNnNibb65CQD+oF2IO7/9nOdgZOA7vfsxF7VfqYIA3S/txVLNgYmnaR7U6Rt
 JqP/gv5/wMCE6eOqZ2LHggI1NT5yuOyk7qjFnOZhvwLbe9d0PMSCuN4FCBYC0GW0IrVZel2iN
 nYCfTF+tAOuvftyE7hnVO+4brGGW5BafBq6NRPYi+7sAPWLX7C4sAXGmvtHG8EV+V2D7jFEVq
 e58HJ5pwE8MODm7wAaV5CjjW0OdPTpAfckYYijvhPTZHRpIgB3J8xMrlYwmZFgixm50zobQnC
 RyR8asMYvI4phc87t56BlmOZiZOd/VaCFLbcqQfHU=
X-Mailman-Approved-At: Thu, 26 May 2022 14:06:23 +0000
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
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>,
 Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 linux-parport@lists.infradead.org, kvm list <kvm@vger.kernel.org>,
 linux-rdma <linux-rdma@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
 linux-staging@lists.linux.dev, bpf <bpf@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:DRM DRIVER FOR QEMU'S CIRRUS DEVICE"
 <virtualization@lists.linux-foundation.org>,
 Linux Memory Management List <linux-mm@kvack.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 linux-pci <linux-pci@vger.kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-omap <linux-omap@vger.kernel.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, May 25, 2022 at 11:35 PM kernel test robot <lkp@intel.com> wrote:
> .__mulsi3.o.cmd: No such file or directory
> Makefile:686: arch/h8300/Makefile: No such file or directory
> Makefile:765: arch/h8300/Makefile: No such file or directory
> arch/Kconfig:10: can't open file "arch/h8300/Kconfig"

Please stop building h8300  after the asm-generic tree is merged, the
architecture is getting removed.

        Arnd
