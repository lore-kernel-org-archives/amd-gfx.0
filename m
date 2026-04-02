Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB0BFE7E35D
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 09:29:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A3D910F487;
	Fri,  3 Apr 2026 09:29:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D/xrCsMO";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B46810E120
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 19:02:05 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-66e36d12a00so613202a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Apr 2026 12:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linux-foundation.org; s=google; t=1775156523; x=1775761323;
 darn=lists.freedesktop.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ePUNrbdwnW/6ontZGK8TOL9te6Vsn2aDppf76uZ2K98=;
 b=D/xrCsMO11ovl8bOUaEK5T4WHHhQcpHxe4wFbzqDTJskBXw+wxLoirgtvKgSZcazw7
 5RzXMm04g4qxDOvP++6LO96a5KUrsN/mXRdrik+JUDVPBHY5gMo31jRyMZLUjJhXXG0p
 fVNHPB1u5AatShVJHgkDFKUFiceRPv2UKo5uM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775156523; x=1775761323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ePUNrbdwnW/6ontZGK8TOL9te6Vsn2aDppf76uZ2K98=;
 b=GWozDgFuDenZuHLSEab7OQfaN9NgU2x0UtgKwFQpa6cXaJWoyqmIX/uPy4eCH4jWq7
 Wb3UzFTPWAtHCOpY4qjzlP3P8zks26/4ufo5j0/7+lL3QIKc8pMZ/TGLZHMNPVjYsu0C
 HAFKPcRtm5Z7IzrIxDmvvNfIVxPQIzbJQV8OYQ3Gy+lq6BkdDpz8X30SqrC0H4T9sBju
 3W7an183P54mvalwhW6rtLCdSmq6NvLbX1htbSGN6o/xiFb1l/yygqE8z4lrSdbpVGi9
 Q3W1vfoxZRrULU7Bdi9kDI1fhpDejtAHs+E+M/5YWwx85kAbMJ23VvqZy3Ev6BMnUAQ9
 X0rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8bJXdy61E/cEs4uloBdIZr/xtjb/C3kfN90RjcUmqsHOSt7KTZ/OWSl7olJSK6WKir0GUG4hp@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzuG/ITfnQz+Os6YQwz06cUXyLFeWasMoKsEoa9Wopr/lLZCCD
 uGJaHhNM14GR+kOMeVQmJk8T6PGOsvMTEx9McMEK7GeviE5q5geUEs6pw7/z1J1E6oTZNSGpa4Y
 9CkD1TUw=
X-Gm-Gg: AeBDievnGYNzoL8NWtbsv8P4uM+ECHWS7SqFLh8GSfeg0jNaJJnFEZQjOZfG+JYHU9R
 9ExETPaDd8l6vDgSb//QnxPAcUZH9XqFM9lyZMsUUCnH3miAPIbvFf1rAEFUJISAF4z2Hj8vSpH
 xOrRhMQO0FrkrjtVLsDNXumEQDkaN0lD5/kfpkpGraqYm1eDp0TvVdYSe+F/J1G1iZVT20/WfiD
 xsUNFSPxlemi8mPs2jOVdpimg0H3GmpTHbYi3xNNrWS4U+xOn8hQp+kkE5iyEV0Fo/kFiDcRUk+
 eSWgZkhCalRgSYTq1DimAbLjryqznU2gFWMiSqIx6EmSSo0L2fbv8m3mwBbwUiEy0CbxJuPgK8f
 eUxxVjwZgTTXjgB2qpR8xJYPVuRGE1hssM74w1Xape5Xfaha9uJKBhW9VYo3MDL19I2IYtHTcn8
 +9xR4oISegFL1vHXSiejR8Hf2Qay4nDPS90sw9By+93s4kWOthhqA1J61t3spoqevcoO/NvEM6R
 kh18RtoWp8=
X-Received: by 2002:a17:907:25c3:b0:b9c:4a6c:7dc5 with SMTP id
 a640c23a62f3a-b9c674454damr4262866b.5.1775156523073; 
 Thu, 02 Apr 2026 12:02:03 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com.
 [209.85.208.46]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9c3d028831sm117986966b.59.2026.04.02.12.02.01
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2026 12:02:02 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-66ad907833dso2237349a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 02 Apr 2026 12:02:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCU4/EYSW5k3FqJnJNPpGiq5GHfFNUfWuCXZoupE1lHCFL3XCXETO2DqLkGDd4KsCgduMe1h8/Gy@lists.freedesktop.org
X-Received: by 2002:a05:6402:5d3:b0:66d:f536:a63d with SMTP id
 4fb4d7f45d1cf-66e3f3bf8e4mr130709a12.4.1775156521322; Thu, 02 Apr 2026
 12:02:01 -0700 (PDT)
MIME-Version: 1.0
References: <20260401184456.3576660-1-alexander.deucher@amd.com>
 <47c508c3-3424-4e8a-a63c-1f29d13b6ebe@leemhuis.info>
 <CADnq5_MiFOYLP9aUnYw4HFb-xWLZdq245ZB3e6iGn09ywOsY2w@mail.gmail.com>
In-Reply-To: <CADnq5_MiFOYLP9aUnYw4HFb-xWLZdq245ZB3e6iGn09ywOsY2w@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 2 Apr 2026 12:01:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiNdTNNxzRuxXYq1Ebpiv6YF4UMZApoQGnktbMjKFYP+w@mail.gmail.com>
X-Gm-Features: AQROBzAMZbuTN23P8TkIKiMVHa1tHl57TLivKQV-jC6Njhuyf6GRrqJ_sBY0N3w
Message-ID: <CAHk-=wiNdTNNxzRuxXYq1Ebpiv6YF4UMZApoQGnktbMjKFYP+w@mail.gmail.com>
Subject: Re: Regression fix for audio issues with pre-DCN401 chips (was: Re:
 [pull] amdgpu, amdkfd drm-next-7.1)
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
 Alex Deucher <alexander.deucher@amd.com>, 
 amd-gfx@lists.freedesktop.org, airlied@gmail.com, simona.vetter@ffwll.ch, 
 Linux kernel regressions list <regressions@lists.linux.dev>,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Fri, 03 Apr 2026 09:29:15 +0000
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

On Thu, 2 Apr 2026 at 11:27, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> There are always new fixes.  Worse case it ends up in 7.0.1.  If it
> causes other regressions, then we end up introducing a new regression
> in rc7.

This was a regression in rc1, that was reported several weeks ago.
Anything that gets reported that early in the release cycle is bound
to hit lots of people, because the number of people testing early rc
kernels is relatively small.

So why pointlessly delay *known* regressions for fear of a potential new one?

And why point out rc7, when dammit, this could have been fixed long
before and *not* be that late in the release?

The bug was reported a month ago. The patch was posted  ten days ago.

It could have been in rc6 and gotten a bit more testing, but was
delayed for unknown reasons, and now the argument is that we should
avoid the testing in rc7 and just put it in a stable release instead?

What's the advantage of releasing 7.0 with a known problem, and delay
any potential reports of whatever new regressions in 7.0.1 instead?

What is the logic here? Really?

As you say, there are always new fixes. But how exactly does that
change anything?

The fact that there will be new fixes just means that delaying known
fixes will only result in all those fixes just piling up.

Or worse yet, all those known *problems* piling up, where known
problems may then end up hiding even more problems that people don't
even see because they hit the first issue.

So what is the point? Why are things delayed?

The whole reason we have rc release candidates is (a) finding bugs and
(b) GETTING THEM FIXED BEFORE THE ACTUAL RELEASE.

What did you think a "release candidate" was all about if that's not
your reading of the issue?

And if fixes look too scary or uncertain, we *revert* the change that
caused a regression. We don't go "fixing it is too scary".

And yes, we have more timely releases than pretty much any other
software project has, and that is partly exactly so that things don't
build up over time.

We don't want new features to build up over time - long long ago we
had long release cycles that then dragged out even *more* because
there just was too many changes and they all had issues that needed
fixing.

But we also don't want the known problems to build up over time.

One of the points of of "release early, release often" is to find bugs
quickly - and then *fix* them quickly so that we can leave the issue
behind instead of letting it fester and cause longer-term issues.

This "drag your feet because there will always be other fixes" makes
absolutely no sense to me, and it's not how we work.

So  honestly, there are exactly two choices: apply the fix, or just
revert the commit that caused the problem in the first place.

Because no, "let's just have a known regression" is not how we roll.

            Linus
