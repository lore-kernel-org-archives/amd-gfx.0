Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CE3C3DA7A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jan 2023 15:22:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2EB610E2B2;
	Fri,  6 Jan 2023 15:22:36 +0000 (UTC)
X-Greylist: delayed 499 seconds by postgrey-1.36 at gabe;
 Fri, 06 Jan 2023 15:18:46 UTC
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de
 [130.133.4.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BAD810E2BD
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jan 2023 15:18:46 +0000 (UTC)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
 by outpost.zedat.fu-berlin.de (Exim 4.95) with esmtps (TLS1.3)
 tls TLS_AES_256_GCM_SHA384
 (envelope-from <glaubitz@zedat.fu-berlin.de>)
 id 1pDoMP-002xQU-QR; Fri, 06 Jan 2023 16:10:21 +0100
Received: from p57bd9807.dip0.t-ipconnect.de ([87.189.152.7]
 helo=[192.168.178.81]) by inpost2.zedat.fu-berlin.de (Exim 4.95)
 with esmtpsa (TLS1.3) tls TLS_AES_128_GCM_SHA256
 (envelope-from <glaubitz@physik.fu-berlin.de>)
 id 1pDoMP-000ZKo-K4; Fri, 06 Jan 2023 16:10:21 +0100
Message-ID: <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de>
Date: Fri, 6 Jan 2023 16:10:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Build regressions/improvements in v6.2-rc1
Content-Language: en-US
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.152.7
X-Mailman-Approved-At: Fri, 06 Jan 2023 15:22:35 +0000
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
Cc: linux-xtensa@linux-xtensa.org, linux-sh@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-f2fs-devel@lists.sourceforge.net,
 kasan-dev@googlegroups.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Geert!

On 12/27/22 09:35, Geert Uytterhoeven wrote:
>    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_262' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().:  => 358:45
>    + /kisskb/src/include/linux/compiler_types.h: error: call to '__compiletime_assert_263' declared with attribute error: Unsupported access size for {READ,WRITE}_ONCE().:  => 358:45
> 
> In function 'follow_pmd_mask',
>      inlined from 'follow_pud_mask' at /kisskb/src/mm/gup.c:735:9,
>      inlined from 'follow_p4d_mask' at /kisskb/src/mm/gup.c:752:9,
>      inlined from 'follow_page_mask' at /kisskb/src/mm/gup.c:809:9:
> 
> sh4-gcc11/sh-defconfig (Günter wondered if pmd_t should use union)

I'm seeing this, too. Also for sh7785lcr_defconfig.

> sh4-gcc11/sh-allmodconfig (ICE = internal compiler error)

I'm not seeing this one, but I am getting this one instead:

In file included from ./arch/sh/include/asm/hw_irq.h:6,
                  from ./include/linux/irq.h:596,
                  from ./include/asm-generic/hardirq.h:17,
                  from ./arch/sh/include/asm/hardirq.h:9,
                  from ./include/linux/hardirq.h:11,
                  from ./include/linux/interrupt.h:11,
                  from ./include/linux/serial_core.h:13,
                  from ./include/linux/serial_sci.h:6,
                  from arch/sh/kernel/cpu/sh2/setup-sh7619.c:11:
./include/linux/sh_intc.h:100:63: error: division 'sizeof (void *) / sizeof (void)' does not compute the number of array elements [-Werror=sizeof-pointer-div]
   100 | #define _INTC_ARRAY(a) a, __same_type(a, NULL) ? 0 : sizeof(a)/sizeof(*a)
       |                                                               ^
./include/linux/sh_intc.h:105:31: note: in expansion of macro '_INTC_ARRAY'
   105 |         _INTC_ARRAY(vectors), _INTC_ARRAY(groups),      \
       |                               ^~~~~~~~~~~

Adrian

-- 
  .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
   `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

