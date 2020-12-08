Return-Path: <SRS0=uNpP=FM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB61C4167B
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 18:26:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3357123B46
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Dec 2020 18:26:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3357123B46
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8946E999;
	Tue,  8 Dec 2020 18:26:12 +0000 (UTC)
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 515AB6E9A9
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Dec 2020 18:21:14 +0000 (UTC)
Received: by mail-pg1-x543.google.com with SMTP id e2so4582438pgi.5
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Dec 2020 10:21:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=69ZxS8NpuBFfq3dMMUK34uoPZnuHxlhCdKz8Q7+H1iw=;
 b=rsSy8DjSjzbDc0sbHQ7S0NMCf5oYMiYPU1VBQbgdqbKdGn3TtkJpjxxS+lP9V2APjr
 h7jqEq9f1oRC2yMDjRk/HPU63urSvYqsDn/+jIBZq82Q1HWBD10YKSJjs1ywgI2wI3Je
 fiBaN4QunaoM65dFCJO0RRbwT8YFddVD9QKUZjcddigxGsOw/5C1CkerOJrshV0LAG29
 z+R7zl2jTmiytq9cKhPpWwZHcaLg5DnzcFKqr9Fvy7sSkspvicup1HEOKC6jiQtzfzHj
 B8176rZyvn4Kwwx5gB+fujIqz0+Kp/OE+TIZs4oPkL3ici1kKHPXzPveOXhlAC6fbhe9
 f2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=69ZxS8NpuBFfq3dMMUK34uoPZnuHxlhCdKz8Q7+H1iw=;
 b=Y5Ry+nSbMTBElX4fbfvAoTnIptq9sVfwzfeJqGVuNrWV3EwfkSLV2Jf4WamvhFPY7p
 CDFvktlB4rgHRg08HoCPkC8Ueig3qKOy14uH7dqRXR/Jcp0YNDbd/YD/mzpE0wfC9XZP
 F5IuKFO5fwprVi6R3gR+f1Dbs+vyj2W+AoUN1ZUUemfh+y321t7zWQsNEa0kAVOnnVGu
 eD1lbP/70SLs7gtPBV/77v34dCbD0CNecnHOpbjGLJXuwHP9shrIDBj4MGRELVB62cwg
 ASC+SnsEEC0Y0mHMccF5lsHkP2oFn1qEps9snqm67Ef98TXJCj2RuODpygwAV+eJPXoo
 gCig==
X-Gm-Message-State: AOAM531wJRtKYlmRdpR8qOoPcbVO0V/q/vp2ZMTM3VeF10Pbqjmv0L9t
 qWyzkz1qwTwSNc4YtDXy2erwfTKW2I6suVT/6pqcjA==
X-Google-Smtp-Source: ABdhPJyjiKco4SfehN0PefCx1HbLYJrQRGQymvgBErwfXLEsvdc+8QV9rBpsch/L4CHfz1zm1S1MDluw9SJJ8GmDeWU=
X-Received: by 2002:a17:90b:1b05:: with SMTP id
 nu5mr5406298pjb.101.1607451673537; 
 Tue, 08 Dec 2020 10:21:13 -0800 (PST)
MIME-Version: 1.0
References: <20201204081349.1182302-1-arnd@kernel.org>
 <CADnq5_OmAVZGuz=xHRyST4hE4w1g10wNBQ6iMgfpQD16-9QSiQ@mail.gmail.com>
 <b9d7e33c-4dcd-0075-d0ca-d22b2488c354@amd.com>
 <CAK8P3a09KQS7S5-vJU7ECJh0HXUhwZW9zOOp4c32mtvM5XcU1g@mail.gmail.com>
 <CAKwvOd=-2zoc06EY4R9ZJ0M874bQv3NuT8a0q9=RoYeMMtnXVQ@mail.gmail.com>
 <CAK8P3a0gjPWiRX0yg=i6Qxgyo02AtQVVsw+=w-OvF956Tn=jDw@mail.gmail.com>
 <CAKwvOd=+w6vJvvq9Pwnv1EHHzwCx=o_=PbSozXpqryN6P1yxVQ@mail.gmail.com>
 <CAK8P3a2_0bY+fmUHKjH8XCKpT1BepUGOV0HoKDSPnOvtKjA==g@mail.gmail.com>
In-Reply-To: <CAK8P3a2_0bY+fmUHKjH8XCKpT1BepUGOV0HoKDSPnOvtKjA==g@mail.gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 8 Dec 2020 10:21:02 -0800
Message-ID: <CAKwvOdmSzf7vFjjxWfvUR1FTeFoPToytQL_enR6CFXPCbUn8Gg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: make DRM_AMD_DC x86-only again
To: Arnd Bergmann <arnd@kernel.org>
X-Mailman-Approved-At: Tue, 08 Dec 2020 18:26:12 +0000
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

On Tue, Dec 8, 2020 at 6:26 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Mon, Dec 7, 2020 at 11:28 PM 'Nick Desaulniers' via Clang Built
> Linux <clang-built-linux@googlegroups.com> wrote:
> >
> > On Mon, Dec 7, 2020 at 2:17 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > On Mon, Dec 7, 2020 at 11:08 PM 'Nick Desaulniers' via Clang Built
> > > Linux <clang-built-linux@googlegroups.com> wrote:
> > > >
> > > > On Mon, Dec 7, 2020 at 1:57 PM Arnd Bergmann <arnd@kernel.org> wrote:
> > >
> > > > >
> > > > > Right, looking at my latest randconfig logs, I see the same problem on x86
> > > > > builds with clang as well, though I'm not entirely sure which other
> > > > > configuration
> > > > > options are needed to trigger it.
> > > > >
> > > > > So my patch can be disregarded, but I agree this needs a better fix,
> > > > > either in clang or in the dcn driver.
> > > >
> > > > If you could give https://github.com/ClangBuiltLinux/frame-larger-than
> > > > a spin again, I would appreciate any feedback.
> > >
> > > I've already tried it, but the tool doesn't seem to like me, I never
> > > get the information out of it that I want. This time it failed because
> > > it could not parse the .o file correctly.

The tool has a dependency on a python library for parsing ELF; I've
been having to teach it about various relocation types for non-x86_64
architectures; I'm sure the failure from that scenario is...gnarly.  I
don't know if my latest aarch64 fixes have been deployed (and it
depends on how the library is distributed).

> >
> > Can you send me a config to reproduce the .o file?
>
> The one attached here should reproduce it on x86.

Hmm...no warnings for me with that config on next-20201208:
$ make LLVM=1 -j71 olddefconfig
$ make LLVM=1 -j71
...
$ clang --version
clang version 12.0.0 (git@github.com:llvm/llvm-project.git
1c98f984105e552daa83ed8e92c61fba0e401410)
(ie. near ToT LLVM)

I see CONFIG_KASAN=y in the .config, so that's a recurring theme with
clang; excessive stack usage.  It does seem a shame to disable a
driver for a bunch of archs just due to KASAN stack usage.
$ grep KASAN=y 0x9077925C_defconfig
CONFIG_HAVE_ARCH_KASAN=y
CONFIG_KASAN=y

Is there a different branch of a different tree that I should be
testing on instead? Otherwise, can you send the object file?
-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
