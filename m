From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
Date: Wed, 2 Oct 2019 14:27:37 -0700
Message-ID: <CAKwvOd=+VeD4xchCAyKeBtTD8+qwS6BTVgM=4ZDY1kBQJq3wMQ@mail.gmail.com>
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
 <CAKwvOdmjM80XP7VH83iLn=8mz6W1+SbXST2FChEnH0LSRRm4pA@mail.gmail.com> <CADnq5_MyUp9OkqM+MUHZ8BpLEe5afBpAqOwQxDwAWgvVvqbpoQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_MyUp9OkqM+MUHZ8BpLEe5afBpAqOwQxDwAWgvVvqbpoQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Alex Deucher <alexander.deucher@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Leo Li <sunpeng.li@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, David Airlie <airlied@linux.ie>, dri-devel <dri-devel@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 2, 2019 at 2:24 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Wed, Oct 2, 2019 at 5:19 PM Nick Desaulniers <ndesaulniers@google.com> wrote:
> >
> > Alex, do you know why the AMDGPU driver uses a different stack
> > alignment (16B) than the rest of the x86 kernel?  (see
> > arch/x86/Makefile which uses 8B stack alignment).
>
> Not sure.  Maybe Harry can comment.  I think it was added for the
> floating point stuff.  Not sure if it's strictly required or not.

Can you find out for me please who knows more about this and setup a
chat with all of us? (I don't want to deride this patch's review
thread, so let's start a new thread once we know more) We're facing
some interesting runtime issues when built with Clang.

-- 
Thanks,
~Nick Desaulniers
