Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8796CC38145
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Sep 2022 07:27:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC7710E598;
	Tue,  6 Sep 2022 07:27:39 +0000 (UTC)
X-Greylist: delayed 301 seconds by postgrey-1.36 at gabe;
 Mon, 05 Sep 2022 07:51:05 UTC
Received: from andre.telenet-ops.be (andre.telenet-ops.be
 [IPv6:2a02:1800:120:4::f00:15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D5F210E1E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 07:51:05 +0000 (UTC)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed50:8960:eb4c:1eb8:b03d])
 by andre.telenet-ops.be with bizsmtp
 id G7m12800c4gmfJk017m1gw; Mon, 05 Sep 2022 09:46:02 +0200
Received: from geert (helo=localhost)
 by ramsan.of.borg with local-esmtp (Exim 4.93)
 (envelope-from <geert@linux-m68k.org>)
 id 1oV6nx-0042ve-J4; Mon, 05 Sep 2022 09:46:01 +0200
Date: Mon, 5 Sep 2022 09:46:01 +0200 (CEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
X-X-Sender: geert@ramsan.of.borg
To: linux-kernel@vger.kernel.org
Subject: Re: Build regressions/improvements in v6.0-rc4
In-Reply-To: <20220905071915.2312316-1-geert@linux-m68k.org>
Message-ID: <alpine.DEB.2.22.394.2209050944290.964530@ramsan.of.borg>
References: <CAHk-=wiqix9N5P0BXrSSOXjPZxMh=wDDRJ3sgf=hutoTUx0nZQ@mail.gmail.com>
 <20220905071915.2312316-1-geert@linux-m68k.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Mailman-Approved-At: Tue, 06 Sep 2022 07:27:23 +0000
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
Cc: linux-s390@vger.kernel.org, linux-hardening@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-sh@vger.kernel.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, 5 Sep 2022, Geert Uytterhoeven wrote:
> JFYI, when comparing v6.0-rc4[1] to v6.0-rc3[3], the summaries are:
>  - build errors: +3/-16

   + /kisskb/src/arch/sh/kernel/machvec.c: error: array subscript 'struct sh_machine_vector[0]' is partly outside array bounds of 'long int[1]' [-Werror=array-bounds]:  => 105:33

sh4-gcc11/sh-allyesconfig (-Werror)

   + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: error: the frame size of 2144 bytes is larger than 2048 bytes [-Werror=frame-larger-than=]:  => 3768:1

x86_64-gcc8/x86-allmodconfig (in function dml32_ModeSupportAndSystemConfigurationFull())

   + /kisskb/src/include/linux/fortify-string.h: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]:  => 258:25

s390x-gcc11/s390-allyesconfig (inlined from 'copy_process' at /kisskb/src/kernel/fork.c:2200:2)

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/7e18e42e4b280c85b76967a9106a13ca61c16179/ (all 135 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/b90cb1053190353cc30f0fef0ef1f378ccc063c5/ (all 135 configs)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
