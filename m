Return-Path: <SRS0=yGBf=NH=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458DDC4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 12:55:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC63E6328B
	for <amd-gfx@archiver.kernel.org>; Mon, 16 Aug 2021 12:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC63E6328B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E80F89EAE;
	Mon, 16 Aug 2021 12:55:26 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770E889EA6
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 12:55:13 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 c19-20020a9d6153000000b0051829acbfc7so5860806otk.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 16 Aug 2021 05:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=LDKwvscHTDAKtrWditFBBHxISAdSsW3GL+oL2kV+N74=;
 b=lV6ocoB7UlUXPTnOjwRQKv8tsR94qqGzu85Yu+5FYv0UxPSjoqBZI9zUItp4Q1xdWJ
 LSHjUprfst2t542/JOeb36dlqIXSUvJlJy6+LIbN5SEesckSRjU2sYnF6xC8NE1jyOJS
 d1nsFKYqMlK2zCrVUSYNoL8gR6Y1jaDGXQ5lmK04TCjolPBU4V4jIIbcDCV2yXr0CsLE
 5hiuGQBTwTkOWK/dA0kZj1z7Z2CFroMNoAQBOh1r7QUF9nOBPjgX4IHwVctz62Gt/8/W
 +Sa2fls3tv8HD9bte4Xy2Lexgh7omZEJ7kzxU80SbxY64iuVVyuq5zeu7ugchOYYl9Gg
 LTLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=LDKwvscHTDAKtrWditFBBHxISAdSsW3GL+oL2kV+N74=;
 b=g3+1HYUXAFV8jostQNVQNQtTz1QH3QtVDt16VG4aaNUe8gBXR/NDeQURy4CTbDYTNG
 5TBKrKcitjyghGSr20gHIb8gNYGfMiuvMUU9MXH1mP7VrYeJtOeMFVEudiEVnewIsK8r
 SbcZdsMHq5FCPpn/BUCpheyVdpNPFDgODsVEqwFrgwKfFmUv8gmiBdTPXXOvHpOI46q1
 AOky4CXzz2bmVhOJcs2iC+h5uiuqJ1ex8gmiepHk3AexCW1D4Xt0mNMWczgymuDE7UhD
 Ca4MaYf2YWiQ2uqw+2sJjWuwqlpwFN62+OtqzW4jGKn6G0XTwdo/lYsuET9BP2DyHqmN
 t+Wg==
X-Gm-Message-State: AOAM531WSZj1xVRTZ+lUe7L4I/DWXK49CVtLTcL1Y6H/2Lc2Xn7E5U8g
 uXVx7HNKXCv2iVp7ZVDtb58ZOBV1Fab/FqAHWUY=
X-Google-Smtp-Source: ABdhPJyQ4qAMAgGQM8Gmv8aej1UfnOps0WkFLQ8ooVqwwakWRqRkwa0z5B+MFEJHLxknlFyKPCiD5jL+ZIk4KZ1etRs=
X-Received: by 2002:a05:6830:4:: with SMTP id c4mr5659948otp.23.1629118512729; 
 Mon, 16 Aug 2021 05:55:12 -0700 (PDT)
MIME-Version: 1.0
References: <f2a927f0-65bc-8463-e078-501cc8d177a8@nearce.com>
 <d6b523be-a781-10eb-f6d4-bbdd27913c06@gmail.com>
In-Reply-To: <d6b523be-a781-10eb-f6d4-bbdd27913c06@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 16 Aug 2021 08:55:00 -0400
Message-ID: <CADnq5_PYufw=irmZJwf8ONhZg7n+m+20AsTTW7AMCEM8LujPQQ@mail.gmail.com>
Subject: Re: VA-API Regression in Kernel 5.13 for RX 6700 XT
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Wyatt Childers <wchilders@nearce.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?B?Q2hyaXN0aWFuIEvDg8K2bmln?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, 
 amd-gfx list <amd-gfx@lists.freedesktop.org>
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

On Mon, Aug 16, 2021 at 4:28 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Hi Wyatt,
>
> adding Leo as well.
>
> Question is what do you mean with "majority of VA-API hardware video deco=
ders have disappeared" ?
>
> Do you have a dmesg? Or the output of vainfo?

Already fixed:
https://patchwork.freedesktop.org/patch/449342/

Alex

>
> Thanks,
> Christian.
>
> Am 09.08.21 um 04:26 schrieb Wyatt Childers:
>
> Hi,
>
> I've encountered a bug as a user of Fedora, that's also mirrored by this =
Arch Linux bug report. The vast majority of VA-API hardware video decoders =
have disappeared for the RX 6700 XT GPU.
>
> It seems this happened in the 5.13.x branch, and that it's still a proble=
m in 5.14.x (at least Fedora's packaging of 5.14 RC4).
>
> Please let me know if there's any more information I can provide, or if t=
his was the wrong place to reach out.
>
> Thanks,
>
> Wyatt
>
>
