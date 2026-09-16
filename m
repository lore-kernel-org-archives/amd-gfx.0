Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACCDFC88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 12:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 177B810E36F;
	Wed, 16 Sep 2026 12:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Su0noJ5n";
	dkim-atps=neutral
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2029710E992
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 12:58:28 +0000 (UTC)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-869ce628b69so45657b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 05:58:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789563507; cv=none;
 d=google.com; s=arc-20260327;
 b=YbwtKEGi1v/aDTVsSaWKRU78RkVy23SqYycerK1Z9BuR64TrOrmN9s7eoiAKANSHpE
 GsbEgyl3l8nn7xl5OzgbMLU8I9tu/wcsR8av+taIZdwxIwo6Px5PkzITafFXQHeTvpJb
 SFFrDowTNomXLFn10qgVhDEHeky88y1Z9mMFqfQRuKvt4NTZ8WaxBzXt5vYsThhJ3S2j
 Hx4QmMyNi7LluFN8/0q5zoIU8asFIvGXkfCrHAzgnoa6V0jpgWq9DIS+OjXUtOK+9mT/
 lUR8MQ7VqSX21U6kaaLYe9KJplC+AtEvqPmzYPQkk0IQLsFGCJFHcoREX8J2vv16cM/X
 ZW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=taboNxxDOZthWI5pM3+xrSxYkOe+RftDmUoRh815eTU=;
 fh=5yJo4eow6cORUlENzOVDvN5BfDfk333WPZRJ6oMRSUo=;
 b=rOuLJy4aFO0XRczFmMk8sSh6Ju/9Kn0Sa0mTFhih0Ql/09Wq/ijeq7LrVoC2bbvigj
 0J4We2Bhxy0J+bHEGZi1AxIOQPtoqf4ltS/jFpfgvKmOQ3Y21yB/Kv6SbtAdYT3bLlBe
 inv/TIKO7/DxyBNHXFKQHEYVHUriOjHhbaxpwEUESqPjlIqiJEpH8xOcMYi6UFyAdWy8
 OLXdxue8qkqrTVqlCcbMAfHzy1ySCt1mlMvh19ENAF8z1sn4oYE9MGG32zg/zQuf+TIg
 c54FqVGFgbmqcVLRWD+EWKQjb2dCY40OPhoS9TzXycmOfv9ti7AF7obbhtxqQz9UjpWG
 OBNQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789563507; x=1790168307; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=taboNxxDOZthWI5pM3+xrSxYkOe+RftDmUoRh815eTU=;
 b=Su0noJ5nqIRVm6kkGO3Tn0xcpsv3niws4NjJqnzHGmSboYCOSrQesZArZcgomFLhHh
 0NyucoVQyZFXp+7ds66TQtwQjyPxJSWe41kNiI5w/njzt22BwkC5M2hvguoWkiXqDr5l
 roaqgc8a/ykJ2gLBw0052HQfMQiyEgVT8zHzlhBN326hTG9cThp9UrlEKG7u1ettcwge
 SQny53sz46WM1qsQz86TgCRe16xGrKdy6Gx/NI0jf1JYQqTvZJNJ3W4GvplIjYDDKGY7
 vN7iFyfUG3HX3qeHQGcMnJZF5f7bYGe5g1GiGIIeTzoGwdliOfdX6RRmWEr8aP/ou53e
 gRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789563507; x=1790168307;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=taboNxxDOZthWI5pM3+xrSxYkOe+RftDmUoRh815eTU=;
 b=vR2t6OFMlt8d4QiD9JZHN04RUVedfKxRlulUBnJIa3NLfPyraTzdUAoNctxNG+xJRQ
 xe6YPz9wY0PRqr5JqnF2Xpfeb/zhMRAE8N1wLHgXNN9EMbu4bJp3pIu1UQq7OwNHnig4
 5D6Ie0bGFU2ZPd6VMOXMDmYkajiBkqsHRdk0wwPcB0XeMD8CtalyC5rJ8IZW9HMhqigT
 Bje31hRGTfV75ikh4OXdKTG59KfDLH4wr86L0+ylotAXmdZThs+mLppBUNBq6CxvNqiq
 1gBWQF+WfMZBOrj7e5jc9URdMn0tAX0E4Foho5GZ0eWev7i+C8iuHYRYWPbMTYlfHCK/
 Hbbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzo9lRWvXwCwyQGFdmsGEEJkvqQENWwCsBqWamQpGZKLatu1QnMivvSZAB6yMk8cWjj4gF83DZ3@lists.freedesktop.org
X-Gm-Message-State: AFuF++lXzzAZ16wj/Gsbl4MrgdYoxrRL4T4BOoE4rOa6vkqK4S6pmIcS
 Nbb3Hs4mSyzqJ5D6XqRJ3WalTS1Y+Y7eS6/VYXaj0XjLt+uD1gqa9rl7OIiYiWEPiTQWyI1+Mpu
 AFFARQsCMnlgHWlI+Q/umjTQmpo8AO/E=
X-Gm-Gg: AYBFou1pEJSyV8ou9DHH0ifI0Yy6RvwR4Fl09oWK6spOw9RneGCp5e9kCjuaiTsxCuE
 UyqsXPK0MKgbAEoKGr48WoiYwk2LDgU/3NWOxveUssoVSB0urV3vBWk5v7IneQGkqB70E4pspMn
 W6tiwywjHiYBZsDCRXGZeDPhwZw8umFLkoJJTBjvYiLw0Qh8thmJmy4Hl5gevYvpOuof1AUTWk3
 z/BflPtm4Hs2AUdj1sEcuYiKWByHS9oenBB4wEIJlldr3XvcEA4E4HHpIaX0Fs8HgG/9G0e/Yqp
 kTahk7or6/1czrrp2c4Nr4Q6Mzo0sgz238V9G8h2SWsBdCS7E1G/XoxiVDt7IeLzLucqckc6/qk
 1k94exkMHs4kzf4TLnEkXx/w6qh/obAXOSp3fZqYcdA==
X-Received: by 2002:a17:90b:4a44:b0:398:bada:832b with SMTP id
 98e67ed59e1d1-39e1e5ddce1mr3962699a91.6.1789563507423; Wed, 16 Sep 2026
 05:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_NyBdPbavmiPVdsHkP_Oi1w7ngX0kPSNce+BWN-YkuAFQ@mail.gmail.com>
 <20260915232043.1222-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20260915232043.1222-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 16 Sep 2026 08:58:14 -0400
X-Gm-Features: AcwNN1V-eNmnsnA6Vp7fEkglgpoEParustJjkGuxPErPwN3z_wLoywr9u_8NQ0M
Message-ID: <CADnq5_O5QHaUjy+ppibtLjmn-=exK1pptjjnbO9qrn16O1oxBg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/pm: defer UCLK DPM enablement on Apple Navi 14
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: 062bel313@gmail.com, Alexander.Deucher@amd.com, Christian.Koenig@amd.com, 
 Kenneth.Feng@amd.com, airlied@gmail.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, ed@aicharmers.com, 
 linux-kernel@vger.kernel.org, simona@ffwll.ch
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

On Tue, Sep 15, 2026 at 7:20=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > I can drop the patch if you feel strongly, although it is pretty
> > similar your original patch, it just keeps all of the logic within
> > navi10_ppt.c which is cleaner in my opinion rather than pulling navi1x
> > specific logic into the core pm code.
> >
> > Alex
>
> I dont have problem with the code, the problem is that, this is not the
> solution to this problem, as i said in the previous, the solution lies
> in the DC not the SMU (i tested by removing dce_v10_0_early_init and addi=
ng
> that function to dce_v10_sw_init), it is also confirmed via the testing u=
sing
> Opencore Lecacy patcher, which makes the display 5K, and make the display=
 not
> use compatibility mode (4K), and it also fixes the SMU problem.
>
> (https://gitlab.freedesktop.org/drm/amd/-/work_items/4455)
>
> You can choose to upstream this, i dont necessarily have a problem with t=
his
> patch as long as i am the patch author (eg using From: )

I'll drop the patch for now.  Once it gets sorted out, we can help
review the new one.

Thanks,

Alex
