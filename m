Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E223CA101F
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Sep 2025 13:06:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1005E10E1C7;
	Fri, 12 Sep 2025 13:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DJTicBXg";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1836110E242
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 13:06:19 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-772771b6e0eso242109b3a.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Sep 2025 06:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757682378; x=1758287178; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ckr1nOupG/FHOX87n/x1D8vzmImJQCNO14BvHg2YgKk=;
 b=DJTicBXgUH25m/7/MIxdE90DAmrrZMayG8Dc1oCI2pdbloVZGU6mKnh2W0tdH0XDsZ
 xX93GTxrENlwlKXCsMvuN9kVmWYfLwsZUMdP5nhIjBNIcyksXvZraxbhHQDsmzKCsRlE
 5oOSt++MxM6lUfHzRunHyopvOC8GPQzuTACT8DhkLX64DMpJn9mebqP6wBH6focCYAkx
 LKz50l2riVp4sqr/z0J4rqhw7zx73ANbTPP6NnwJ/AwhGzSdkax51cVotm1tfs4ihCVW
 gNTtC+0raf/Ynv2lJ81QXkPEmwSzJYRF80RW9YGrFpA6oworpzJdIDF0uLj+XC4sJ/R3
 pVLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757682378; x=1758287178;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ckr1nOupG/FHOX87n/x1D8vzmImJQCNO14BvHg2YgKk=;
 b=kdsYtiozLtmOtZjSsdAGphoirz2XiUF81jz6FYtkBGZr+Ru0sIogKiQJcwNuCEv4V1
 1+Fs8O6Rep+ilV1spoVCGDXUqkXFl02GtOi5hlyYC7YPYLKlMD2t+ZnUCo+/JCE89A8F
 FbCuZ2Hb4Nvkqa790KeR2r1obgVRGnvS0wga153ZFbNtLwBtKcTv1tjCdB+fS6lPZp4t
 9iMlbiCxfMZa7XUg0DLbP1mdCnPoW8ghWRr1vcjSDqJPABJBr0Vix7sK20hfi3tqNIqG
 Kxso4OQJ0fBKwSRl2pQCGonEBmcE6kXzMKuwPo7RJ1q9qO0ohvnIoddR0uHOPnLM0jxm
 wDIw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO0NtlqOYnKwe8CPyOemo3wF+ZtnF5Fk2NvwquktmmQYUD7nekNFuPIOh0A0dCecaxEPMlKVpF@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx69Mi63sRA2g4cicpFyPTb332Y3yWh0glbduXNlpkE2gSBTXD/
 fZ3pxTtX+uMwMKNS5wfaxRrr6tCNc4FVwffuu/WI2EzT5bmpQhB+Slq8q/SkS5jDy1JoWp0/eGX
 epxrhzo1BNqT9sVPBAK7VA+msp/iv1dg=
X-Gm-Gg: ASbGncs7JDoSWUC0wl5sCAheXwIa0ukEou1+oLSAtg05wZQge6eWomge1d1yhYobdoB
 vjXY2Tnd4s0Wqv2TRUsWFb+yoyc8qvJOtokTqEuXAUBGeOwFu4kkKVftLNf/OpLY57w0OJiztBv
 iRHgcNF59re48pYAwd163PXLjurxB0w6A1QYiKtWWLU2bAiR8on8nMBSKb2PGParepeb6Kh6+iH
 Qsxo5TqxIdZjjrdRw==
X-Google-Smtp-Source: AGHT+IGTTvtC1IuLrcY8b4AvWUeugef+D6CmgxiovRG+v0ayfpqmLzCTs+HKBKHE/plPyLUKu92jZlW/yTLM+LNCrgY=
X-Received: by 2002:a17:90b:3b84:b0:32b:bc5c:85b2 with SMTP id
 98e67ed59e1d1-32de4e69e6emr2013081a91.2.1757682378471; Fri, 12 Sep 2025
 06:06:18 -0700 (PDT)
MIME-Version: 1.0
References: <20250909151146.760450-2-thorsten.blum@linux.dev>
 <CADnq5_MFDZdJg3XFFw9+tWB=_LP47PwE3HXgPK=sryOx+_0wGQ@mail.gmail.com>
 <FED6FFD1-2C51-45F4-BF34-76484C415C83@linux.dev>
In-Reply-To: <FED6FFD1-2C51-45F4-BF34-76484C415C83@linux.dev>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 12 Sep 2025 09:06:07 -0400
X-Gm-Features: Ac12FXwJwCDZ_BVgzYuq56yoU1VX5uqBys40Ob0J7ZAD0NdiVqJ_P3OSul7PJJI
Message-ID: <CADnq5_NXCEFH6V_m0nvEqHU6tOhjUZ-ExSRb93Hi=7qxDAo6Vg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: Replace kmalloc + copy_from_user with
 memdup_user
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Felix Kuehling <Felix.Kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Fri, Sep 12, 2025 at 8:48=E2=80=AFAM Thorsten Blum <thorsten.blum@linux.=
dev> wrote:
>
> Hi Alex,
>
> On 9. Sep 2025, at 17:35, Alex Deucher wrote:
> > Applied.  Thanks!
> >
> > On Tue, Sep 9, 2025 at 11:29=E2=80=AFAM Thorsten Blum <thorsten.blum@li=
nux.dev> wrote:
> >>
> >> Replace kmalloc() followed by copy_from_user() with memdup_user() to
> >> improve and simplify kfd_criu_restore_queue().
> >>
> >> No functional changes intended.
> >>
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> >> ---
>
> I just learned that calling kfree() on an error pointer doesn't work, so
> this patch should probably be reverted/not applied.

Thanks for the heads up.

Alex
