Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36B4FC5B569
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 06:42:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B26810E6B0;
	Mon, 10 Aug 2026 06:42:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (4096-bit key; unprotected) header.d=canonical.com header.i=@canonical.com header.b="e9W6Nvy9";
	dkim-atps=neutral
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F92510F52C
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 15:30:11 +0000 (UTC)
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5DE523FC12
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Aug 2026 15:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1786116609;
 bh=7a+7khQkUhHJZzLpcaOaLMIlK4thNph9yCEljZqb0jg=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=e9W6Nvy9sIMoMry8mokSoWMUWL+bIhdU6qmJ3CJp81kIE+tta7SA/+0/xuc7yUhh0
 1FtXnx7uGKICMZJGJH3lHL4W+tpIe4wCANFpIYeVTpYFCVYGXi6YNwS3c6WnmB0wcw
 wHWwsmvdEqkvsFXLpnuUH/iOtOv6yiSY9pVidtAiiwwcOaNoIJmzy6dvqvgJtHpN+V
 bSRml8k5aCh2eDIEsRj4OYBdOp1ftf1rWRvUNmoT6yF1N1QnIMXnJUxqDsx49rXpq7
 n005zSRvhdaI6GH+adtLhMIUMGOHWWt3Q9XqwqSlOmYhwnpOev2Y8PEKBEIkXNB8Ds
 pAqrEtPfsUEtnz0C8dBHQrdB4AbszuQ3HF9zO7s63TFFfMo1RiznIMH3hQYE6RpY4p
 F2zWI+ewYid3fP6ffZXgvWKn96eP3GeH3ejTmNIQm7X2UrXU++rR1oYNOaL883t/uQ
 eyCY+VvEc1o6zUYl806zX6qtEFLOBMyxNR3WY0rJZRa8F6hEjtIKZXZCcxwfH+GTqt
 YbNgPJo3hHwYWJJqqxA29ZDgOTK78BIXWDgUcL3kYVuCAfe+Ar9qFKp+0vaiBgxXXx
 iqlUOrfwW16IDtplzPWMj1yYSPZmxnS5cde5yh0Yh9jpZWow77j1FrGPKxOAJ5hpUh
 BEhYSbG+fKfVQ7tUJ8Bbdrvk=
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-485ebc5706cso2583415b6e.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Aug 2026 08:30:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786116608; cv=none;
 d=google.com; s=arc-20260327;
 b=cTgBNyVwxwl0KShle8Jk+ggzIgdGJ1gjmdeSOc+ZO/Wa+M/scSu3taDmYhRYA2VGXl
 JZ4p/Qa1hgixL6tQvf/IPRqxmQJvEqWgjLl7XtcAnhz9EomPAZFsjuMnSjhKMJheG+vi
 AwfsukNoohjhqeqAWDoDSvvAyZrYmN8YcESuy6jJI+L1ZbUuKf8JLT0fKYeGKq/5212n
 sEdGS/q7exvNK+FYNebkNmCiIStUMyrdD/CRgFRmZjo9pOTlvWjOtrF85QNGwm19EijN
 4lojB37ACiQ1HRL6R07U050OxVWf0PUQ3XjAchODKBbyFcKJ9GFXG4mGDGJhUXKzX71D
 lhqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=7a+7khQkUhHJZzLpcaOaLMIlK4thNph9yCEljZqb0jg=;
 fh=Oq5oSzOQ1XX8U7BYgdltR96ZVeXvHgTh9i0/rblw6l0=;
 b=kOCGbjoHNOVKP4cj+KXbSvskccACIcJHEfoBkcuVWCkQG+h8/slOMvks64pwo3a6yB
 gLeAIVayg15RRaenTpEy7XEJIXWegCQsHeQH5MTEjKdqy8hdukp8Pkq5KpbCYg6OMrC6
 EUrgOXB7wEqEsMyicjQmQXo6tWzoVxqNs1mm4kr2QOWgQXAtGoj+DR1iDisgLvU2DbAL
 ouymPjuTMZ+aZ3oCUd4Ni+uGQiymie8rkYje2Yf5uBHTR4sn3/91VJEnuCNt4Wb0Pg+a
 BX7Bj0t1q9nzsDpxjdr4HLvUbeicOrqh3uktmrGADFqsxVFoD+4FxmlRSqzVZnzDRBhf
 w3Iw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786116608; x=1786721408;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7a+7khQkUhHJZzLpcaOaLMIlK4thNph9yCEljZqb0jg=;
 b=RkOfgl1n5jeNB4F4+iOIC21bFkzytujlWO1CPW5U6eIApsoXv1iIx2seh5xCsWvkt5
 BeMQYSwwgot+/ufqyFWJ1dprX5DQiCtlDGQd7IwVAzXj2VNdsNKT61M6oh4jwtfU0NN0
 fWInHQy5Z88Om3NbP5EH/ZySdCzGRizUAbM10f4bn/SXTBcx8QTYzkdpt9Te2DghSKvY
 uVjzyLr3VkvSIgGBBOZSWaipHiLp+9HqD8kwyqLdUQeltjrmTBAF5ty+YBGzX7LhsV4B
 LEARMdOdn7eFz3wS0TwXM84tUBh3W2cXMrc17dD01QnkuRCj/ZhtlwMxx1zLYuYXAyH6
 p9Aw==
X-Gm-Message-State: AOJu0YwURb5aYbwU0pbeBTG0FRljhRiiuMWRZdBNfSqMz3W/h6QlfsjH
 YvrwYagE7zTSDzRVz6dDM12KerEG4wXTw+MpVPBot9RuqJ3NaOYmLp9rcKJr+rdoldZsT4bgy60
 8jHJ/mPIe5YkfB3RCiGhtXAyiOeV1FS6qSRFrC7RvB81EwR+dCBtcyTT+V+5iG9PdVSY165b52R
 GncNtjRuBt/NvY41PERvF9JvnK+ZB73PGTRI0785kwW6JGeW8Oufun+O5iHQ==
X-Gm-Gg: AR+sD1248LeBHLZ+a4qip9DR8NJ4nnIyfwjNzYleHutkdiKWJkO2Gc1sY/TNAfRWabj
 8bfqk4ULW9K8AeMVMT7m+hdmlfwHSokaHpRfgddMEZMsSsGHwo4keQsA9XNKUNLCnIQWJS7y6J9
 S6q7ZmkzDlk9KjxrZ1LKzAGgvnvCWqFgWvRRHMMhBuuZz0dWIkb5lBRs28dEOr/Zj/xTiAPwVaN
 MUOzfuKdYfv4eSgOQ==
X-Received: by 2002:a05:6820:a38f:b0:6ae:aa9b:b8fe with SMTP id
 006d021491bc7-6aeb242507emr5954483eaf.12.1786116608125; 
 Fri, 07 Aug 2026 08:30:08 -0700 (PDT)
X-Received: by 2002:a05:6820:a38f:b0:6ae:aa9b:b8fe with SMTP id
 006d021491bc7-6aeb242507emr5954464eaf.12.1786116607742; Fri, 07 Aug 2026
 08:30:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260806143408.979209-1-mitchell.augustin@canonical.com>
 <20260806143408.979209-2-mitchell.augustin@canonical.com>
 <30d3e377-cbf3-4ab2-b7a1-0557b6cdb690@amd.com>
 <CAHTA-ubuVAMn8wnrWpBvnvMd6gH-80cSygbmS5Sy-AhU+Oy0XQ@mail.gmail.com>
 <ed48a0e9-d32f-417f-8066-c74aebc319c3@amd.com>
In-Reply-To: <ed48a0e9-d32f-417f-8066-c74aebc319c3@amd.com>
From: Mitchell Augustin <mitchell.augustin@canonical.com>
Date: Fri, 7 Aug 2026 10:29:56 -0500
X-Gm-Features: AUfX_myXY1klI8VFoEe68XmODa-R1z0JS7KQohjAeIxBHwzxPhgguHBJcNenqmA
Message-ID: <CAHTA-uYkATo+Nw==rioAeQXni5xmUBVw5fMbDikT==YtEkpMHA@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amdgpu: Do not enter PSR if multiple displays are
 active
To: Leo Li <sunpeng.li@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 10 Aug 2026 06:42:02 +0000
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

Perfect, thank you! I will apply those all to my Ubuntu kernel and see
if it eliminates the issue there (hopefully sometime next week).

On Fri, Aug 7, 2026 at 10:18=E2=80=AFAM Leo Li <sunpeng.li@amd.com> wrote:
>
>
>
> On 2026-08-07 11:06, Mitchell Augustin wrote:
> > [You don't often get email from mitchell.augustin@canonical.com. Learn =
why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> >
> > Hi Leo,
> >
> > I am not sure - I have only personally tested the latest
> > Ubuntu kernel based on 7.0.0 (7.0.0-27.27). Could you link me to the
> > relevant commits / mailing list entries? I can read through them and
> > will try to give it a test soon if I have time.
>
> I created a 7.0.y based branch with all the fixes here, see the top 5 com=
mits:
> https://gitlab.freedesktop.org/leoli/linux-asdn/-/commits/lileo%2Fflip_do=
ne_timeout_corruption_fixes-7.0.y/?ref_type=3Dheads
>
> - Leo
>
>
>
> >
> > -Mitchell Augustin
>


--=20
Mitchell Augustin
Software Engineer / Tech Lead - Ubuntu on NVIDIA DGX
Email:mitchell.augustin@canonical.com
mitchellaugustin@ubuntu.com
Location:United States of America (Central Time)


canonical.com
ubuntu.com
