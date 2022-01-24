Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6401DC433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 18:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FF510E70B;
	Mon, 24 Jan 2022 18:59:04 +0000 (UTC)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com
 [209.85.222.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 066CE10E3D1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 18:55:45 +0000 (UTC)
Received: by mail-ua1-f53.google.com with SMTP id y4so32894251uad.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 10:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ME4XZXZ5PNYvzDH4OmBox2BIuMK+Mc5MwbGfrqjcLBM=;
 b=6qDajmnXy/tbj/5SI7ZZF4egx5cJyugNtUwqT1v5SwUu0qlXODLFHL0VfbrIbx64nA
 d+r1B0rTEAbMlAj5+gHROuFERqyrefzt7vQfUGxaFpMV79O9+JKn3vwvIHIPPtB5RzHQ
 nxjFqOOGCD9Ar9UFDIEbEvL4jg+TwX0pIZNplvyW5G0JOl4UYKK52N/UTyFf/RnvfILn
 7H4M+JX5Da/jBe2Zbcx425decA+fN1geIWpcW3y2hiOtk1FxrSRHiOmWUlLoFUyEAtjv
 LL4J9INi9uCQWOmXUnBUMW7oI0+2xtRmH0S1jJqQbytsHnATekxIz9OsvAqp56VAKorC
 m1iw==
X-Gm-Message-State: AOAM53259TRmeylCmLXLlDfmpR1c+yLalq8Lo4crWcX5nFFbj0q3hjgk
 tJRBL9WGXE4sCkylsNvDa8WRP56AODT0Lw==
X-Google-Smtp-Source: ABdhPJz7rclRMC7tiTQN8itHlT1uW4Kz02UzeJzvej+IwFFHDkiKFlrydr3R11d5pxUvzwqenErKxA==
X-Received: by 2002:ab0:525:: with SMTP id 34mr5975140uax.136.1643050543926;
 Mon, 24 Jan 2022 10:55:43 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com.
 [209.85.222.48])
 by smtp.gmail.com with ESMTPSA id p2sm3311978uao.1.2022.01.24.10.55.43
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jan 2022 10:55:43 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id c36so32804604uae.13
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 10:55:43 -0800 (PST)
X-Received: by 2002:a9f:2070:: with SMTP id 103mr2821729uam.122.1643050543058; 
 Mon, 24 Jan 2022 10:55:43 -0800 (PST)
MIME-Version: 1.0
References: <20220123125737.2658758-1-geert@linux-m68k.org>
 <alpine.DEB.2.22.394.2201240851560.2674757@ramsan.of.borg>
 <CADnq5_MUq0fX7wMLJyUUxxa+2xoRinonL-TzD8tUhXALRfY8-A@mail.gmail.com>
In-Reply-To: <CADnq5_MUq0fX7wMLJyUUxxa+2xoRinonL-TzD8tUhXALRfY8-A@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Jan 2022 19:55:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUWqHYbbavtMT-XAD_sarDPC5xnc3c0pX1ZAh3Wuzuzg@mail.gmail.com>
Message-ID: <CAMuHMdWUWqHYbbavtMT-XAD_sarDPC5xnc3c0pX1ZAh3Wuzuzg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.17-rc1
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 24 Jan 2022 18:59:03 +0000
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
 KVM list <kvm@vger.kernel.org>, Network Development <netdev@vger.kernel.org>,
 linux-um <linux-um@lists.infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, "Tobin C. Harding" <me@tobin.cc>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Alex,

On Mon, Jan 24, 2022 at 7:52 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> On Mon, Jan 24, 2022 at 5:25 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Sun, 23 Jan 2022, Geert Uytterhoeven wrote:
> > >  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: error: control reaches end of non-void function [-Werror=return-type]:  => 1560:1
>
> I don't really see what's going on here:
>
> #ifdef CONFIG_X86_64
> return cpu_data(first_cpu_of_numa_node).apicid;
> #else
> return first_cpu_of_numa_node;
> #endif

Ah, the actual failure causing this was not included:

In file included from /kisskb/src/arch/x86/um/asm/processor.h:41:0,
                 from /kisskb/src/include/linux/mutex.h:19,
                 from /kisskb/src/include/linux/kernfs.h:11,
                 from /kisskb/src/include/linux/sysfs.h:16,
                 from /kisskb/src/include/linux/kobject.h:20,
                 from /kisskb/src/include/linux/pci.h:35,
                 from
/kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:25:
/kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: In
function 'kfd_cpumask_to_apic_id':
/kisskb/src/arch/um/include/asm/processor-generic.h:103:18: error:
called object is not a function or function pointer
 #define cpu_data (&boot_cpu_data)
                  ^
/kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1556:9:
note: in expansion of macro 'cpu_data'
  return cpu_data(first_cpu_of_numa_node).apicid;
         ^
/kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c:1560:1:
error: control reaches end of non-void function [-Werror=return-type]
 }
 ^

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
