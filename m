Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E98C43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 21:35:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B5CF9BD38;
	Wed, 13 Jul 2022 21:35:50 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 920BF9BBDA
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 21:32:30 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id l23so21865ejr.5
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 14:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=eiO9zeEKuffwwO1qFa2qtw+jOEgErpUu7Im0rIo+TAI=;
 b=HSdqrPacMhIs7Xx4ZvJuUh0uqgC/8AgZmNQWYOOs0tQjPr2+ACT1nhPCLzwsATVSE8
 EXmBrgxKI05sSa8T7/qexXyv5guVcihHfiCO7XsvDyyOLF/pOdbggNoSUChkPDiWHbHT
 MyhV2onY3BoW4S1IzBpt84ZnGOF1d5CHKpBeg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=eiO9zeEKuffwwO1qFa2qtw+jOEgErpUu7Im0rIo+TAI=;
 b=kUWKkP5IVBQhjYxuEpgVfh31u2yXBIEsyUUap97H9OJSRvf0Us+Wnb7nUcoQCpET9a
 OB/tLNVjejB9+Ri/znEqv4aEPS2dGgxedYUeWkZvwhWJQypDfYm7VeLaHaOePyQ9dPpM
 Gz+mgpoUzv1S18H+6aJKgbtRBGz6Jyv8nxLgV/PyyyvRVXrzZ63Ix4vSPuFXBiCXRLse
 +Z0mBcGdB4y//+KvG537zbmyXkkxMTei6nvSEdQ08o/zIt0+xn13V+h4xkP+d9nwt3yk
 C6CcjqYqEt37PSkr8f1QcFStkOXXMqEz5KeMzCk4ZYnaODIn8KnbEXVP1RLQ/2rQaAQe
 CW6g==
X-Gm-Message-State: AJIora/vL0+hYo/e7r2vnTtb2M0bN2pMR7NWfQh5B/IumStfxsys/+Yu
 jUH8IYHiJlmp2AtJnXtpeWCsR8lImY14+Bb55FQ=
X-Google-Smtp-Source: AGRyM1sHPe5GwoTGZrJGzrOP3zrJOOKVEIjlByvu6RMtaVYnQuJgbNspOlHI76sZ0izpSleAXsg+QQ==
X-Received: by 2002:a17:907:94c9:b0:726:9747:edbc with SMTP id
 dn9-20020a17090794c900b007269747edbcmr5370816ejc.698.1657747948660; 
 Wed, 13 Jul 2022 14:32:28 -0700 (PDT)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com.
 [209.85.221.50]) by smtp.gmail.com with ESMTPSA id
 fy12-20020a1709069f0c00b0072b7d76211dsm2397717ejc.107.2022.07.13.14.32.26
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 Jul 2022 14:32:27 -0700 (PDT)
Received: by mail-wr1-f50.google.com with SMTP id q9so17278389wrd.8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 14:32:26 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr4964406wrb.442.1657747945994; Wed, 13
 Jul 2022 14:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgTmGaToVFdSdoFqT2sNkk7jg2rSWasUYv-tASUZ2j_0Q@mail.gmail.com>
 <20220713050724.GA2471738@roeck-us.net>
 <CAHk-=widUqghhXus_GCM9+FESa5vHqMb_pO3=0dGYH8C+yix2w@mail.gmail.com>
 <a804b76e-159f-dbc2-f8dc-62a58552e88d@roeck-us.net>
 <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
In-Reply-To: <CADnq5_O6Tp2QPXyDCvpWuRXhDr6H1PM50Ow5YG2WeukqUd-GnQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 13 Jul 2022 14:32:09 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
Message-ID: <CAHk-=wj4+BSj2SPMRUr-TZ4Qg2o9HGOBWiJQE336YcF_U1sVNQ@mail.gmail.com>
Subject: Re: Linux 5.19-rc6
To: Alex Deucher <alexdeucher@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 13 Jul 2022 21:35:49 +0000
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, Leo Li <sunpeng.li@amd.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Balbir Singh <bsingharora@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Paul Mackerras <paulus@ozlabs.org>,
 "Russell King \(Oracle\)" <rmk+kernel@armlinux.org.uk>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Daniel Axtens <dja@axtens.net>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Jul 13, 2022 at 2:01 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> If you want to apply Guenter's patch original patch:
> https://patchwork.freedesktop.org/patch/490184/
> That's fine with me.

Honestly, by this time I feel that it's too little, too late.

The ppc people apparently didn't care at all about the fact that this
driver didn't compile.

At least Michael Ellerman and Daniel Axtens were cc'd on that thread
with the proposed fix originally.

I don't see any replies from ppc people as to why it happened, even
though apparently a bog-standard "make allmodconfig" just doesn't
build.

I'd try it myself, since I do have a cross-build environment for some
earlier cross-build verification I did.

But since my upgrade to F36 it now uses gcc-12, and possibly due to
that I get hundreds of errors long before I get to any drm drivers:

  Cannot find symbol for section 19: .text.create_section_mapping.
  arch/powerpc/mm/mem.o: failed
  ...
  Cannot find symbol for section 19: .text.cpu_show_meltdown.
  drivers/base/cpu.o: failed
  Error: External symbol 'memset' referenced from prom_init.c

this cross environment used to work for me, but something changed (I
mention gcc-12, but honestly, that's based on nothing at all, except
for the few problems it caused on x86-64. It could be something
entirely unrelated, but it does look like some bad interaction with
-ffunction-sections).

So considering that the ppc people ignored this whole issue since the
merge window, I think it's entirely unreasonable to then apply a
ppc-specific patch for this at this time, when people literally asked
"why is this needed", and there was no reply from the powerpc side.

Does any of that sound like "we should support this driver on powerpc" to you?

                 Linus
