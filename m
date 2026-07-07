Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C92ECC43458
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jul 2026 11:44:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F4FB10E4A3;
	Tue,  7 Jul 2026 11:44:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rr8+hXU7";
	dkim-atps=neutral
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com
 [209.85.128.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B683310E4A3
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jul 2026 11:44:11 +0000 (UTC)
Received: by mail-yw1-f182.google.com with SMTP id
 00721157ae682-7fe4808741eso34483567b3.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 07 Jul 2026 04:44:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783424650; cv=none;
 d=google.com; s=arc-20260327;
 b=F4EVGFs3E+Rhk7E1xotlbwwa44cqqaBmNf9M0Zykyh8IXwXoSOZjz2JAxob3e6aqwj
 87/Pm45Q8EUE9soxpY5+yKOPywqFb9eXpHk0eLmqOSOs5TO5uLBUQNy8RWnhphj9+a2b
 /4Mvi2wkCo0LG0Ag9K0jzmajutzpQCukyN/CFjBX+1hrOUC0kf90Ylyr3gNzqYFcAuiB
 MpTdUjP09JUi9BwmJpEUxf3Ekh+DkvX5TDUmzOmDN1sFw7jR2XAESoYDvYlR+Zx/hZKp
 bkn8OdO1VkByuEWtFqip+M0mXI7cWroNGYkG/RQ64qx/zwGOq8Wqn2505Zp8Hq6Excft
 x7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=67hEAJ0W8TbXP17az7LLoVoZORX8tOcszaeupEwlAiY=;
 fh=Kt2E6J8LtiCqH2giR0mPb2sHTwQ8SCM8v8fdem5d20s=;
 b=C1C6+bAPlgpXv7wu+Gm9upm+M4Jaw61Au/AI6/FF8sTe/80xyIUhODm5sxMYeG60EO
 z0kuGzFNcvJCkBwTNEaKfygIew7Y08m08gSrcKAblpTRtW/C5yo3wM8zxQnIVeMfm3Sg
 ZHg3sVO/iuPhNid41eFPQf6VRCauCYYPJY09nGk0FIebvx5ErIXXgQR1aq64Gss6YJBU
 AACVtkPMl3X4PX36L89LPqqD4fGnk0Mne/aa2igVYZ/pdOsw4R7jQe/i+NloSrb6si4M
 iLM0YdF7tJWbbMOs8Ic5LgsqMNby0Z/M7h6xALKzUIrX3YpW2q+i4QNMLQgM3kF9NU+R
 6WYw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783424650; x=1784029450; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=67hEAJ0W8TbXP17az7LLoVoZORX8tOcszaeupEwlAiY=;
 b=Rr8+hXU7S+lgS5WZCwoP8UAO+Y0eaqHuew47ATDCIeGwRSPo8YeqywN+RXfLlzwfNS
 JwkMMU/iqYSmCFMmxwQo1wZaF7qhDv4L6PhgzBsar15c1cNCrCn3IvsvXLAGfcdR3mB3
 VrOQJocMmBYOCp6a1ZA7hgvN6nBzbRVTmnUbpKfD6dPiCiy7TlTMJpY/MPHqqi6GxNKh
 sAwVD9EITRffbM+3CWKbrO/T91O7yrnnJ0RjVQ0P/bRLsUo0Mmfv1qZKNIqaSWG40wry
 qPN8fo/4qgFBo0/Gg4eDBZBDHqVzhZiUFFJqSYv3CDbXwMzYT9wWV282V8YrWOxPn9u1
 o5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783424650; x=1784029450;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=67hEAJ0W8TbXP17az7LLoVoZORX8tOcszaeupEwlAiY=;
 b=OcJGMGtcx0YU0C1uPjIskDzMS2aVPjwjaHchOQpiZ1gyeOUqR5r67HT4cnZe7MOltl
 WPv4LPAkeVi3jlPHxUnhuTgGBz7zNwk8lddQ23VxQgTbZvNJx193dziaOwr3rR+rIcyv
 lKLzQv464zNBrnYZs8rs8uAuJp1DbdnxYKxI66mVg9602hnOugQmZiFniFfmapEU+osv
 WJu0U9EsyXJ7NKiMwfzTI4JryeMf3oe+tqJyiSkfraJ5Lw0l0AqOphgvm6xUKtzog9ab
 TskSwTQSS/4o0Dfzp9Eb4jk1JpKLQDaWuQC1O9lVHR/F64PB9qiqmc5MfTnVVEKQubjV
 L5gQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RqdxYTUVK9hkobhjm4N/lcq0CnqtiwJMATGsBN5Cqv/r+yAEyzmCVRWAPCt6l4IYpnM7P5wBWZ3@lists.freedesktop.org
X-Gm-Message-State: AOJu0YySTzZ3Vlhfcy3utMi+LmiOdDJETc/9harn8hf12Yewt0p8WQwr
 y/y1pQhTW1SalfS9+MiB/XYOdQsRxqP0ig+r1Q6iPyEPDUB/qUU0qbfQvaZPfYOUv0/XxzjsqQu
 xcFb4rellIbHRVWyA4Irp2BiaVY8UQcM=
X-Gm-Gg: AfdE7cnmmxFzYz7n+uRasTdDmE0Ri7Wjv9OveWzl87IJ6hiLd5Y+3kKTULEGoHB2H4y
 n/sap1MgUO6DdoOR0BqATw/fs6kDkCINNDeOn/9io29waVWe0qy4aZvrr0JgCXeH1yP0nWA35yC
 xAnc4m9f1vm3ECdAcn0gcRYjhsCM0XQq10c8sqdBpO09ndbM8pL+UYUrJ577ol5Dd5pOpFbRFpL
 uDij7vxgakfOocZP4jQumdmAtXqwWtEIz9IM4EfwUZNW+FnwKbZayRqI6hM/Oe9GalUut1GYgPc
 5PRYqaUNjFgqTikzB4F+NLzypskUfem17ADi9GQFDDQtuI3SZ8UUMuNB5w==
X-Received: by 2002:a05:690c:47c4:b0:81c:bd45:478a with SMTP id
 00721157ae682-81cbd455201mr8632077b3.41.1783424650492; Tue, 07 Jul 2026
 04:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <20260704084133.122053-1-christian.koenig@amd.com>
 <c575453f-d798-4745-b67d-4476825dfa64@amd.com>
In-Reply-To: <c575453f-d798-4745-b67d-4476825dfa64@amd.com>
From: Dave Airlie <airlied@gmail.com>
Date: Tue, 7 Jul 2026 21:43:58 +1000
X-Gm-Features: AVVi8Ce7O0KwC_YSOIzySDPamgDjtTYnQvuH_iwtOUZsxhnymDAqU3HCRhQKPB8
Message-ID: <CAPM=9tz38o_p--FGjgkcDCV43jwmbx_zYDyc8fyHKBteiHDRrQ@mail.gmail.com>
Subject: Re: [PATCH] drm/drm_exec: avoid indirect goto
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: mikhail.v.gavrilov@gmail.com, dri-devel@lists.freedesktop.org, 
 amd-gfx@lists.freedesktop.org, peterz@infradead.org, jpoimboe@kernel.org, 
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, 
 Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 7 Jul 2026 at 19:11, Christian K=C3=B6nig <christian.koenig@amd.com=
> wrote:
>
> Adding a few more people to comment and review.
>
> Thanks Mike for the pointers, going to add them to the patch before pushi=
ng it to drm-misc-fixes.
>
> @Thomas, Maxime, Simona, Dave can anybody give me an rb or comment?

I don't like it, but I also don't think the thing it replaces was
spectacular, so until we can figure out a nicer way let's go with it,

Like I was wondering if putting the label in a macro would make it
more explainable, but I don't think it would help much.

Reviewed-by: Dave Airlie <airlied@redhat.com>

Dave.
