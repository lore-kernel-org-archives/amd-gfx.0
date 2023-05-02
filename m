Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF7CC77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  2 May 2023 04:26:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AAD810E116;
	Tue,  2 May 2023 04:26:47 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54BA10E116
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 May 2023 04:26:44 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-50bcae898b2so1963847a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 May 2023 21:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1683001601; x=1685593601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SUJaDOxRbZ3HeQBlL5k0NbCaiph3lc885HP8EQT3Ihw=;
 b=aZAp7UWJ9PkFb10GZOxWtmPzZKRgGhjtYEjbtkGy/sJXzM7RwgrxijIPamgio15S5L
 BW4e/oRiRXKq5JrRoBfxUFi4b8f90bPaNptVXhrvJooqUARQdtETsoCWchhrZBgPRVm4
 mwzehbLNhzK0AEQfZfwXKdM6IkkVET6+qfVHJMWQfF0eKG3LRpT1PQxCA0P6hS5Ki/z5
 s9f2TcUQrAgiCSP/vnoIN61kwDX9COj/gHGBYFV7CQbv7QT4q7GFG00BcvYxARIl4OON
 h+VwLllLOeO4FT/qfzQ4GB6KpwJuigGf2rH2NufWl+xQhYBPgGqqnbVrEtOehJq4x2Wd
 LwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683001601; x=1685593601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SUJaDOxRbZ3HeQBlL5k0NbCaiph3lc885HP8EQT3Ihw=;
 b=dIQzJz/sX4UC6DCUxD0+uvFRhMnFj2t8jXl9nk6snTstVxeBDwrRffU4u0C6VdrosZ
 MMXlpeLSBW+U2ZIBIysI5oph9hWA2flxvy/LMjfaxt72MZTNZ7JC9OyFDL/xGOpnquPq
 xVRr+si4osC6YCZHHsHEjcebAL4e2b5iMPLXzH6MZHKgQ/S2iowxIicTXAvgWvb1zY7g
 4Eu5PuaqPnCtdhq2niMI447u9A6sr3MFO6T97xwK0hkNEQo7fpQjaaDRoyHL1EzlllWr
 f+UmdTeh06xCZwBCiRFVoo2dRbTccFrCcd9O8ZwZ1+SqugRZAE9UvM+OOHmW47do6fUY
 LJsA==
X-Gm-Message-State: AC+VfDyGUJPP2NWgW5sBeUGksj5dPGxJAKWP3nK6TnM+fIgHjhC3y7xr
 Q4+SJN0Czu+jy2WWsVxJSKAB0IX7HuALB65nhz4=
X-Google-Smtp-Source: ACHHUZ5yZ111ITSNpXuz5tWuqeuDVAHz+LeIekEtkd4au31tByMG52itaxSkp1dcPWHpv9aZVUSI1ZeFcfEgwr15uec=
X-Received: by 2002:a17:907:2d28:b0:948:d1af:3a11 with SMTP id
 gs40-20020a1709072d2800b00948d1af3a11mr14832075ejc.50.1683001601013; Mon, 01
 May 2023 21:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
 <1311F54B-10AE-4492-BB7C-F4BEC9676983@froggi.es>
 <CAAxE2A58Wp-2z3CKadQfgGkAZA2emH5Z3Z0_soiZEPNmKhkuBA@mail.gmail.com>
 <CAEZNXZC+qbD2JJgV7gTYdNH-SNKhNBbzQKNDyzje0mPKjhSJYg@mail.gmail.com>
 <CAAxE2A55+Rmdz63P8JETkvsLX6DSLFvpBwNoiE_pdsKjpdpCLg@mail.gmail.com>
In-Reply-To: <CAAxE2A55+Rmdz63P8JETkvsLX6DSLFvpBwNoiE_pdsKjpdpCLg@mail.gmail.com>
From: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Date: Tue, 2 May 2023 00:26:04 -0400
Message-ID: <CAAxE2A7eEBenTiBTBn7QKjSqfCSWvNdw1zWSWV_tVZVDWg+5zg@mail.gmail.com>
Subject: Re: drm/amd/display: disable display DCC with retiling due to worse
 power consumption
To: Joshua Ashton <joshua@froggi.es>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Content-Type: multipart/alternative; boundary="00000000000095bc4f05faae5883"
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
Cc: amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--00000000000095bc4f05faae5883
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We're going to do this in Mesa instead:
https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22771

Marek

On Fri, Apr 28, 2023 at 6:36=E2=80=AFPM Marek Ol=C5=A1=C3=A1k <maraeo@gmail=
.com> wrote:

> On Fri, Apr 28, 2023, 16:14 Joshua Ashton <joshua@froggi.es> wrote:
>
>> I mean I would also like power and perf numbers for Vangogh given you
>> referenced 10.3.
>>
>> Generic "power consumption is better" isn't enough to convince me that
>> this is the right call.
>>
>
> Raphael and Mendocino have worse power consumption with retiled
> displayable DCC and modifiers, and that can also be due to how retiling i=
s
> implemented for modifiers.
>
> Marek
>
>
>> - Joshie =F0=9F=90=B8=E2=9C=A8
>>
>> On Friday, 28 April 2023, Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wrote=
:
>> > I thought the same thing initially, but then realized that's not how
>> modifiers were designed to work.
>> > Mesa should expose all modifiers it wants to allow for 3D and it
>> doesn't care which ones are displayable.
>> > The kernel should expose all modifiers it wants to allow for display.
>> > With that, Mesa can still use theoretically displayable DCC, but it
>> will only be used for anything that's not the display.
>> > We can, of course, disable it in Mesa instead to get the same effect.
>> > We would need perf numbers for dGPUs to be able to tell whether it's
>> beneficial with the cost of DCC retiling.
>> > Marek
>> >
>> > On Fri, Apr 28, 2023, 12:11 Joshua Ashton <joshua@froggi.es> wrote:
>> >>
>> >> I really don't think the kernel isn't the right place to do this.
>> >> Is there any reason to not just disable it from the Mesa side?
>> >>
>> >> We can already disable displayable DCC there, so I don't see why you
>> are even touching the kernel.
>> >> It makes it infinitely harder for anyone to evaluate perf and power
>> tradeoffs if you disable it at this level.
>> >>
>> >> The whole power vs perf trade is also not a big deal on dGPUs compare=
d
>> to APUs. Probably needs a better heuristic either way to avoid regressin=
g
>> perf.
>> >>
>> >> - Joshie =F0=9F=90=B8=E2=9C=A8
>> >>
>> >> On 28 April 2023 10:47:17 BST, "Marek Ol=C5=A1=C3=A1k" <maraeo@gmail.=
com> wrote:
>> >>>
>> >>> Hi,
>> >>> It's attached for review.
>> >>>
>> >>> Thanks,
>> >>> Marek
>> >
>
>

--00000000000095bc4f05faae5883
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>We&#39;re going to do this in Mesa instead: <a href=
=3D"https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22771">https:=
//gitlab.freedesktop.org/mesa/mesa/-/merge_requests/22771</a></div><div><br=
></div><div>Marek<br></div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Fri, Apr 28, 2023 at 6:36=E2=80=AFPM Marek Ol=
=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com">maraeo@gmail.com</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div =
dir=3D"auto"><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmai=
l_attr">On Fri, Apr 28, 2023, 16:14 Joshua Ashton &lt;<a href=3D"mailto:jos=
hua@froggi.es" target=3D"_blank">joshua@froggi.es</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">I mean I would also like p=
ower and perf numbers for Vangogh given you referenced 10.3.<br><br>Generic=
 &quot;power consumption is better&quot; isn&#39;t enough to convince me th=
at this is the right call.<br></blockquote></div></div><div dir=3D"auto"><b=
r></div><div dir=3D"auto">Raphael and Mendocino have worse power consumptio=
n with retiled displayable DCC and modifiers, and that can also be due to h=
ow retiling is implemented for modifiers.</div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Marek</div><div dir=3D"auto"><br></div><div dir=3D"auto">=
<div class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><br>- Joshie =F0=9F=90=B8=E2=9C=A8<br><br>On Friday, 28 April 2023, Marek=
 Ol=C5=A1=C3=A1k &lt;<a href=3D"mailto:maraeo@gmail.com" rel=3D"noreferrer"=
 target=3D"_blank">maraeo@gmail.com</a>&gt; wrote:<br>&gt; I thought the sa=
me thing initially, but then realized that&#39;s not how modifiers were des=
igned to work.<br>&gt; Mesa should expose all modifiers it wants to allow f=
or 3D and it doesn&#39;t care which ones are displayable.<br>&gt; The kerne=
l should expose all modifiers it wants to allow for display.<br>&gt; With t=
hat, Mesa can still use theoretically displayable DCC, but it will only be =
used for anything that&#39;s not the display.<br>&gt; We can, of course, di=
sable it in Mesa instead to get the same effect.<br>&gt; We would need perf=
 numbers for dGPUs to be able to tell whether it&#39;s beneficial with the =
cost of DCC retiling.<br>&gt; Marek<br>&gt;<br>&gt; On Fri, Apr 28, 2023, 1=
2:11 Joshua Ashton &lt;<a href=3D"mailto:joshua@froggi.es" rel=3D"noreferre=
r" target=3D"_blank">joshua@froggi.es</a>&gt; wrote:<br>&gt;&gt;<br>&gt;&gt=
; I really don&#39;t think the kernel isn&#39;t the right place to do this.=
<br>&gt;&gt; Is there any reason to not just disable it from the Mesa side?=
<br>&gt;&gt;<br>&gt;&gt; We can already disable displayable DCC there, so I=
 don&#39;t see why you are even touching the kernel.<br>&gt;&gt; It makes i=
t infinitely harder for anyone to evaluate perf and power tradeoffs if you =
disable it at this level.<br>&gt;&gt;<br>&gt;&gt; The whole power vs perf t=
rade is also not a big deal on dGPUs compared to APUs. Probably needs a bet=
ter heuristic either way to avoid regressing perf.<br>&gt;&gt;<br>&gt;&gt; =
- Joshie =F0=9F=90=B8=E2=9C=A8<br>&gt;&gt;<br>&gt;&gt; On 28 April 2023 10:=
47:17 BST, &quot;Marek Ol=C5=A1=C3=A1k&quot; &lt;<a href=3D"mailto:maraeo@g=
mail.com" rel=3D"noreferrer" target=3D"_blank">maraeo@gmail.com</a>&gt; wro=
te:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Hi,<br>&gt;&gt;&gt; It&#39;s attached f=
or review.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Thanks,<br>&gt;&gt;&gt; Marek<br=
>&gt;
</blockquote></div></div></div>
</blockquote></div>

--00000000000095bc4f05faae5883--
