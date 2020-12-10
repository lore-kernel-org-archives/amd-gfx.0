Return-Path: <SRS0=QenQ=FP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118E5C433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 08:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C47B623BF0
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Dec 2020 08:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C47B623BF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B5936ECBB;
	Fri, 11 Dec 2020 08:33:28 +0000 (UTC)
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com
 [IPv6:2607:f8b0:4864:20::542])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098AE6EB8E
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 22:53:08 +0000 (UTC)
Received: by mail-pg1-x542.google.com with SMTP id 125so216633pgf.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 14:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=zBQoi+y+4cg9DRWgUXN6Y3g43b49pmfyTju9GNYCKF4=;
 b=epzIn+GXL2xRZiFKNb83yt/sZKjrnuGozJcvL/k80AHs0PRugs0pGECPcN2D9RowNT
 58Nhmq6dFyetuaMfuzBicYmWEJcy8s0mfzXuOW/y4KiBpODDkzEkx0P3nBscn8ObAc3G
 9tiBswgYOW02zj6RBuiAqE4MxgsJTGInqhGtTCZnYg9iW9Dvifj/6oIFFiZgH2ssgihR
 0GDl7FzdoPwYTxG0vlat13fiwoTgLXqu7kIV6F88i0L9vLd/I9pg//G/Bz8zuciuX8wC
 vV+80IUlysG/MJv8/esb//jT5YiWnCrZwizGwhrGshFrcM5dzoJtuMoyTpL+3b1ChI3N
 4Gsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=zBQoi+y+4cg9DRWgUXN6Y3g43b49pmfyTju9GNYCKF4=;
 b=Chhae2NGXM2nTTPclmU7W7D0u/FdsDTWGgupz7tyjkSBXsMxjwFO8tsKSCW/2ned15
 fhzA74fRY5PXhxyhaokVmBHSxxO/WqsjiKYLlh/bGaM7LQZWkQzgsrmINWBckghgn8Ji
 wHJCKQ74PMHOmMQXna5ElYUEG8tW2Al+/+V2InRDzBLOK5AAcF1+THbIkOhCAAA/o0uO
 zsSXWZhJ2Hf8SSAbfHST0Vlv8fuLXw5buT61GGkDTgZ5LZuJABCxKKqdqqx/fts3enB1
 BM1XGtDLR466QbZuz8rvQ4Z5vP2/ClC1gu+CCaZSdSk3ji7BUrzqP+Bdc/vn0Nl6DmlL
 tvNw==
X-Gm-Message-State: AOAM5336f3mCwbJDKgZtoQeFsR/5+XRlTF4K5OVJE5ra42IWL9M9jhfQ
 r3Jz/E+yW13H1QO8OC3MR9UqMnyNC6PT5ShT3TfM+A==
X-Google-Smtp-Source: ABdhPJzgefMVmMYXcnkmkyw3AtrI8LZGEeda1eBjFypE6N5QaXKz/jj1Uu0Kqqr80kBp5HLmJawUNjuOXvaPX6DFiZQ=
X-Received: by 2002:a17:90b:1b05:: with SMTP id
 nu5mr9889752pjb.101.1607640788371; 
 Thu, 10 Dec 2020 14:53:08 -0800 (PST)
MIME-Version: 1.0
References: <20201204081349.1182302-1-arnd@kernel.org>
 <CADnq5_OmAVZGuz=xHRyST4hE4w1g10wNBQ6iMgfpQD16-9QSiQ@mail.gmail.com>
 <b9d7e33c-4dcd-0075-d0ca-d22b2488c354@amd.com>
 <CAK8P3a09KQS7S5-vJU7ECJh0HXUhwZW9zOOp4c32mtvM5XcU1g@mail.gmail.com>
 <CAKwvOd=-2zoc06EY4R9ZJ0M874bQv3NuT8a0q9=RoYeMMtnXVQ@mail.gmail.com>
 <CAK8P3a0gjPWiRX0yg=i6Qxgyo02AtQVVsw+=w-OvF956Tn=jDw@mail.gmail.com>
 <CAKwvOd=+w6vJvvq9Pwnv1EHHzwCx=o_=PbSozXpqryN6P1yxVQ@mail.gmail.com>
 <CAK8P3a2_0bY+fmUHKjH8XCKpT1BepUGOV0HoKDSPnOvtKjA==g@mail.gmail.com>
 <CAKwvOdmSzf7vFjjxWfvUR1FTeFoPToytQL_enR6CFXPCbUn8Gg@mail.gmail.com>
 <CAK8P3a0ViH90qvr63H4J5Qn0FMfV4r9CeTHurj3N2qO2f=Dq+Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0ViH90qvr63H4J5Qn0FMfV4r9CeTHurj3N2qO2f=Dq+Q@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 10 Dec 2020 14:52:56 -0800
Message-ID: <CAKwvOd=AKjojWfsB6UJKyJNkNZE4duYzGzRHSF1PubxmUazpJg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make DRM_AMD_DC x86-only again
To: Arnd Bergmann <arnd@kernel.org>
X-Mailman-Approved-At: Fri, 11 Dec 2020 08:33:27 +0000
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
Cc: Timothy Pearson <tpearson@raptorengineering.com>,
 Arnd Bergmann <arnd@arndb.de>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 David Airlie <airlied@linux.ie>, Randy Dunlap <rdunlap@infradead.org>,
 Roman Li <Roman.Li@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 LKML <linux-kernel@vger.kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>, Luben Tuikov <luben.tuikov@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, Daniel Kolesa <daniel@octaforge.org>,
 Alex Deucher <alexdeucher@gmail.com>,
 Nathan Chancellor <natechancellor@gmail.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Dec 8, 2020 at 2:18 PM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Tue, Dec 8, 2020 at 7:21 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Tue, Dec 8, 2020 at 6:26 AM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > On Mon, Dec 7, 2020 at 11:28 PM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > Hmm...no warnings for me with that config on next-20201208:
> > $ make LLVM=1 -j71 olddefconfig
> > $ make LLVM=1 -j71
> > ...
> > $ clang --version
> > clang version 12.0.0 (git@github.com:llvm/llvm-project.git
> > 1c98f984105e552daa83ed8e92c61fba0e401410)
> > (ie. near ToT LLVM)
> >
> > I see CONFIG_KASAN=y in the .config, so that's a recurring theme with
> > clang; excessive stack usage.  It does seem a shame to disable a
> > driver for a bunch of archs just due to KASAN stack usage.
> > $ grep KASAN=y 0x9077925C_defconfig
> > CONFIG_HAVE_ARCH_KASAN=y
> > CONFIG_KASAN=y
> >
> > Is there a different branch of a different tree that I should be
> > testing on instead? Otherwise, can you send the object file?
>
> I was on a slightly older linux-next, and the latest version contains
> the patch "ubsan: enable for all*config builds" in linux-next,
> which enables CONFIG_UBSAN_SANITIZE_ALL. It took me
> an hour to figure out, but after turning that option off, the warning
> is back.
>
> I'll send you the object for reference in a private mail, it's kind
> of large.

Got it, thanks.

$ llvm-objdump -Dr
--disassemble-symbols=dml30_ModeSupportAndSystemConfigurationFull
display_mode_vba_30.o
...
   1584f: 48 81 ec a0 08 00 00          subq    $2208, %rsp
...
$ python3 /android0/frame-larger-than/frame_larger_than.py
display_mode_vba_30.o dml30_ModeSupportAndSystemConfigurationFull
No dwarf info found in display_mode_vba_30.o
$ llvm-readelf -S display_mode_vba_30.o | grep debug_info
$ echo $?
1

Can you rebuild+resend with CONFIG_DEBUG_INFO enabled?
frame_larger_than.py relies on the DWARF debug info to know what local
variables occupy how much stack space.
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
