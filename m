Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F444C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 19:40:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87B2810E4D0;
	Thu,  6 Oct 2022 19:40:41 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A988210E881
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 19:39:58 +0000 (UTC)
Received: by mail-oo1-xc30.google.com with SMTP id
 h1-20020a4aa741000000b004756c611188so2130581oom.4
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Oct 2022 12:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2rfFLTjrQP4Fs05vC2spzCNZmbqViurrXQPntyMULUc=;
 b=YOZJVG6+3eUoB+z47gniaYwRj4q892BGbzsUmXa8JZ749nhmg4i+5R9Xkmj7Teg7Ts
 qUsfZETBoSEUctCMzSHOHnJyiQnagLgha0o6TI8FZi2nYSdju6Q10U7rXsMWGIcI8QfE
 sZdoeav9x+37Lg1XTxyJ0M4yci7/w3Xooven0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2rfFLTjrQP4Fs05vC2spzCNZmbqViurrXQPntyMULUc=;
 b=weJ1monXCnoOhxSzu84yru4CeDYat5RsfIets+z9ClISHBrq/dU17oq/FwX02MC4MW
 PHExCzSu8Zuonim3sDtnQujUXIW7MG5UZzE64im8qC6YvAZAx7lQlsydhJlOraJtvzox
 llZXKoBaAHiPczvX/ocwTe+PrS/C1bo7v4ZNTSCcAEbEQ4BjEjcthVVDLlQz04Oiwwyh
 RucbwxpWHYdbZsGM0O7JGrnbGbCCc6ygBn19ViNxAsu5E/xfuihAgNpv0qKrnUxD8pr0
 tDHCQ6cL7ZzRbNfcMpW1cxAIDy4F9XA9JmV4twsFIqBlSOS1kzD22lrj7xcAwPK/dER6
 J9mw==
X-Gm-Message-State: ACrzQf3gPyJyu2WgzHFCLQphHIWJj/Lvem1DtCE+isXiZn/4WZMC7crQ
 LsjgMkf/YI3pc94MzZPd3lwf9OyfXqQ7wQ==
X-Google-Smtp-Source: AMsMyM4oaRqlJy48puNDQPOvJbZyYAI++8VCdbqyDi890Z/4yy8cIpYbDlecQcL9RTzv8tCrpWb6rw==
X-Received: by 2002:a05:6830:9ca:b0:661:2ba:9b69 with SMTP id
 y10-20020a05683009ca00b0066102ba9b69mr660570ott.240.1665085197623; 
 Thu, 06 Oct 2022 12:39:57 -0700 (PDT)
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com.
 [209.85.161.46]) by smtp.gmail.com with ESMTPSA id
 w123-20020acaad81000000b00353f4c46059sm25704oie.17.2022.10.06.12.39.57
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Oct 2022 12:39:57 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id
 k11-20020a4ab28b000000b0047659ccfc28so2109303ooo.8
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Oct 2022 12:39:57 -0700 (PDT)
X-Received: by 2002:a05:6820:1992:b0:475:c2c0:3f92 with SMTP id
 bp18-20020a056820199200b00475c2c03f92mr493824oob.96.1665085196830; Thu, 06
 Oct 2022 12:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6W+j+l0cJbr5dX@debian>
In-Reply-To: <Yz6W+j+l0cJbr5dX@debian>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 6 Oct 2022 12:39:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
Message-ID: <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
Subject: Re: mainline build failure due to 5d8c3e836fc2 ("drm/amd/display: fix
 array-bounds error in dc_stream_remove_writeback()")
To: "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>,
 Kees Cook <keescook@chromium.org>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 06 Oct 2022 19:40:38 +0000
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
Cc: Leo Li <sunpeng.li@amd.com>, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, "Pan, Xinhui" <Xinhui.Pan@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Oct 6, 2022 at 1:51 AM Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
>
> This is only seen with gcc-11, gcc-12 builds are ok.

Hmm. This seems to be some odd gcc issue.

I *think* that what is going on is that the test

        j = 0 ; j < MAX_DWB_PIPES

makes gcc decide that "hey, j is in the range [0,MAX_DWB_PIPES[", and
then since MAX_DWB_PIPES is 1, that simplifies to "j must be zero".
Good range analysis so far.

But for 'i', we start off with that lower bound of 0, but the upper
bound is not fixed (the test for "i" is: "i < stream->num_wb_info").

And then that "if (i != j)", so now gcc decides that it can simplify
that to "if (i != 0)", and then simplifies *that* to "oh, the lower
bound of 'i' in that code is actually 1.

So then it decides that "stream->writeback_info[i]" must be out of bounds.

Of course, the *reality* is that stream->num_wb_info should be <=
MAX_DWB_PIPES, and as such (with the current MAX_DWB_PIPES value of 1)
it's not that 'i' can be 1, it's that the code in question cannot be
reached at all.

What confuses me is that error message ("array subscript [0, 0] is
outside array bounds of 'struct dc_writeback_info[1]') which seems to
be aware that the value is actually 0.

So this seems to be some gcc-11 range analysis bug, but I don't know
what the fix is. I suspect some random code change would magically
just make gcc realize it's ok after all, but since it all depends on
random gcc confusion, I don't know what the random code change would
be.

The fix *MAY* be to just add a '&& i < MAX_DWB_PIPES' to that loop
too, and then gcc will see that both i and j are always 0, and that
the code is unreachable and not warn about it. Hmm? Can you test that?

And the reason gcc-12 builds are ok probably isn't that gcc-12 gets
this right, it's simply that gcc-12 gets so many *opther* things wrong
that we already disabled -Warray-bounds with gcc-12 entirely.

If somebody cannot come up with a fix, I suspect the solution is "gcc
array bounds analysis is terminally buggy" and we just need to disable
it for gcc-11 too.

Kees, any idea? Who else might be interested in fixing a -Warray-bounds issue?

                 Linus
