Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA88C88E75
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Sep 2026 14:21:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5ABB10E55F;
	Mon, 14 Sep 2026 14:21:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K9cJBTG+";
	dkim-atps=neutral
Received: from mail-pz2-f26.google.com (mail-pz2-f26.google.com
 [74.125.228.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57BE210E55F
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 14:21:40 +0000 (UTC)
Received: by mail-pz2-f26.google.com with SMTP id
 41be03b00d2f7-cc1e1b51234so139708a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Sep 2026 07:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789395700; cv=none;
 d=google.com; s=arc-20260327;
 b=A7R32Tspe4YPYyw6wA7YtQx3vxmIgy+Np60472G2YxcbtYvHxgpVeHmsCkq3kkMdIZ
 Rq7J+zZPCSCUkxOl2QwWDFrkw+Lz0pjE6K1MLNTiawr4sROwgfGxZYrPmr+Masr4uXLd
 IXZDnBl68H6uq2fapV0veWskJrd2F/s3uD6yWRiGSeGC0azBENj6IMVScpqbXYA2r6YP
 2Fme97kjdnw4LBu8+qs4rtqqxwlv2gKsbVNFiovdxYybMxHYPnYa38AkEIZsQ8Mt8wcH
 5Zu3ZiVbDIEAftfQBkgULa2saft70/6ide1taZW3ijSnelsQwPaKcrR3rsptdH4iVDXl
 kEuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9wBaA/n/TmKjwu/wZ60gVcKCOeMtecNNHVqEiqLighI=;
 fh=pNemPagT3n3MVWnzcqsv2d6cE1urUxdqV9jEYZ0Sq1Q=;
 b=gn68JGd1zfyu1d4Nw2o8fLxuRJB4Dlejp941pGw8ZvvQdQOlMjSOkNsnECb9ljNWKg
 bzb0GkWG7OQM0zIy3SNWjyubcEYOozaEmD8IR5LvTYjetoUp9VZSfE/hzjim9Unyn04B
 fRBKzPgmSIoxqJZGekSrEQxFjb93W8gFpssiYn2Z7EPc+FfUwIjt6O4hDD1Ln9Jjjbg1
 aYB1dHFSRPOAqgFGgyA5esNTWIuZrxvAiqSzZH7bDQZQLKZcDdegbpoOIRb9Qnan4PKA
 dffBaKplAT0UXJAIpq6lkc79QyPKUV1+nAaUEb9IDrtu/xgwwtuM0R/PBvAH8AbcKHsj
 ybCQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789395700; x=1790000500; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9wBaA/n/TmKjwu/wZ60gVcKCOeMtecNNHVqEiqLighI=;
 b=K9cJBTG++WR4YANO3Gd8E7+VM9z8klDUnG41ouf7uRUgNOTNUuBYMNCUkufpEXX9KK
 bUvqqsP2sth4oUMG4yjEnAAvauUX2B8lILEWPcV7AcUtksgMXP3jHKYdlHkvGjNhrGJ0
 imGd64logls0wQUsoqAcOpchRbRpPVSVkTZFrFjeEy6k0WY3SdRBNTeviEGAzccHr3Vy
 PfU4LxWPhFZ8VxANpTF80GjhruE4Cc0U8Yk3z6F0h3gMwk/hbRZjJ32VokhsoDdFppHT
 oG3arbY9tkSEg53pE1zXXmQOdjlUNOpAHsdCh5Ayavb68uS1pOFyVq/EWybsc3HBDjGZ
 QK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789395700; x=1790000500;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9wBaA/n/TmKjwu/wZ60gVcKCOeMtecNNHVqEiqLighI=;
 b=HsKhUi9H2OFpjj9UpQk/F7q8xQjn9lVboEg97R46U5+9WDHSuYfhz5TuIUMKZKINTA
 45RbmFOtbDXmzLnm5vQJHdc6bnWCVx5xmMXURPMsTr3NeT8Hg56vKJjX96CWObObPiY3
 pYSnH7LLtVo9EIMRrK9odASVWIF2YjkDwJvtky1m9SDrCW6emxWn9aMOLosyc69m4KzV
 2yJ6lGbfYl9RgC+7loXqNFHFdAmWztHdwSd6NT3LBnAapdIh9AqLCuvdbiWAofbN9EHV
 Jry/RdscYuKDGo01l5wIu19A3twqNqjsMLfVjr/FiGyTvDZagBjzuyhnclJHOIUfIn8i
 0V3Q==
X-Forwarded-Encrypted: i=1;
 AKwUvByrpsMf81PfsA8BtCw5THK/ftbn1RzyH7nrPZsq+zzwfsDYJ3li5vcSk874W46fJ8h+BM29aPYB@lists.freedesktop.org
X-Gm-Message-State: AFuF++lmq1jWC8YDDp0pDo7WjlmoSZ6H6ZvLGzmLLjJFThb99vZ8Zns8
 jH0iGpVIPJppae+3zyvOY5jII8e9X7NYXq2c5Dh47VJq9/97LpqQDSPFJRbF7UrpX0Jw70nN44V
 iq5ITf1E3rhJdsqoBy4FjibVOPhpN8Yw=
X-Gm-Gg: AYBFou0eRUO9eeCsg8ikItYp3Vh4bKQKXzfUKTOKH9ZScT73X46RTPH99Ry0gk3GChy
 peICQ/HqyPWcTX7AT+s8MpW74v5ERh5LEM7NoH5dbhjNUPOkJIJ8+2laLQ7XAKVllvKN8pCv3jv
 D9P4vmhF5Ja6q4GypXbGmY/2F/S4MD7Y/ZdhvMmSmb5Wfi1Whv3Qk7ciqFNFNrSeM3RwRi11rau
 jybbWx37+zrXuE0q0OF7pBiueNgSy1Y7m8uS/bw7F1SctQdHF5S3ZUl0CbwKRWfv+dcd7jboxvp
 LDRy9ZEkkkVcQGQO4Hdw1gGOGyb5Rue01+nqPZj9U5qoqMPnr3/s5lQWIquoc7XVyrFJn91cCyA
 AUhBIkt9XtGaF5G7Aoo6wZWoExr0dRTd5nhB5tXzK/w==
X-Received: by 2002:a17:90b:2885:b0:39d:e75d:97ee with SMTP id
 98e67ed59e1d1-39dec20812bmr3973206a91.5.1789395699726; Mon, 14 Sep 2026
 07:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <CADnq5_PNt5Huo-bk=tqdCLorUp3BDCtdGmaFJDxfVbcKx-CPoQ@mail.gmail.com>
 <20260913005048.1167-1-atharvatiwarilinuxdev@gmail.com>
In-Reply-To: <20260913005048.1167-1-atharvatiwarilinuxdev@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 14 Sep 2026 10:21:27 -0400
X-Gm-Features: AcwNN1U5A3gc_t-YjPsElm0l5p0KUKIEFT2aA5LkNx_lSR2zyJsX3P4tqP1oEE8
Message-ID: <CADnq5_NyBdPbavmiPVdsHkP_Oi1w7ngX0kPSNce+BWN-YkuAFQ@mail.gmail.com>
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

On Sat, Sep 12, 2026 at 8:50=E2=80=AFPM Atharva Tiwari
<atharvatiwarilinuxdev@gmail.com> wrote:
>
> > Applied.  Thanks!
>
> Hey, so im the author of the original patch:
>
> https://github.com/t2linux/wiki/issues/743#issuecomment-5347204171
>
> The author of the patch mentions this:
> > Combine Atharva Tiwari's delayed-UCLK proposal for 0219 with the Navi p=
ost-init implementation for 0218. Retain the revision restriction for
> > 0218 and the revision-independent 0219 match from Atharva's proposal.
>
> So as the main developer of the patch, i would like you to remove this pa=
tch,
> as it dosent give me credit, and also this is not the solution to this pr=
oblem
> as i have mentioned here:
>
> https://github.com/t2linux/wiki/issues/743#issuecomment-5608044095
>

I can drop the patch if you feel strongly, although it is pretty
similar your original patch, it just keeps all of the logic within
navi10_ppt.c which is cleaner in my opinion rather than pulling navi1x
specific logic into the core pm code.

Alex
