Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03333C77B61
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Apr 2023 20:14:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 885BA10E038;
	Fri, 28 Apr 2023 20:14:25 +0000 (UTC)
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com
 [IPv6:2607:f8b0:4864:20::433])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C7C810E038
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 20:14:23 +0000 (UTC)
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-63b52ad6311so487159b3a.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Apr 2023 13:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=froggi.es; s=google; t=1682712862; x=1685304862;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=gVvjlYX04ghoIiz4f/Eogrsl+1MfNZuBDjy1sqk8FYU=;
 b=ETM+50nYrYT+WV2bA5LEmww8ccW1WmJu2E01NfkgXMTdQSrntk9YNFYgfi3wnX/3hX
 UZAbwQzwNDjqg66ZDvPtp6PhrYJO5BOsUigi49IMjL2yzeH4+r/iD3+oOjkdbAfxKAzY
 v1lYG/WEqU7fgVaw9EqL5q+wIS9F0TB9XL5Q6mFhk3/iQao3EkxSUaLLhdi4tgjg0tk8
 kg1IAuf0T/12Rx7ZfPIciI6JdMIL5a41J/EMJ7lMns31T+ZOlF6ELy20KXWYBdhrfMO1
 JvOwUAKNlDQgj0uYpdFH9jNabJAw81dO3VXQPpyZlUt+PvLKty6yXibW7XsnaNwUhWn0
 IJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682712862; x=1685304862;
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gVvjlYX04ghoIiz4f/Eogrsl+1MfNZuBDjy1sqk8FYU=;
 b=MgVQV+bIDKQ/lrtr4bbS+zYztORhIjYCBucU/1b26M0wTaUGnTGBPgQq8l3GEEwEhg
 GbK25pLeFI1rC+DAHG5S9wkHkZOfShi2ol1UUznGFT7SXvp78G+k9RuVURo20pA5rDWq
 d1ujmnKoJHhzm36o5za+0VHrggV9eqX6GfTb4NRF/at62/R+8N6VO2KSVOzfXI7vjAHi
 /WkWvj0+PdsA4EG+HM+kkeMtkphPDaZsbFHfpETjuZzl09QJBOXI1BAbT/P5KnypPSo2
 0hP6yjZW2vEG4uae/lZvTEtUUljo27VtXoj2tnfc2L0sl+v+b+SCGkvWH7RKCObF6rjv
 KyQQ==
X-Gm-Message-State: AC+VfDypct6MyhCRw3ybM2i8X4P6mikOO4c0ryMMBRPrbUaWC6DPAFUu
 wx0p/XG6qCM0L7qK9C6gqczNSP7Y5LgZGQxCMmR7aw==
X-Google-Smtp-Source: ACHHUZ7nBrPe+a3mwX3HbAEKFlX8ekx41+sSw91huU0ZFZGWsXDFnlWnJOad5yLOo0pb50l/KkPSDYq70Y9+CmkpRD0=
X-Received: by 2002:a17:90b:1b44:b0:247:4c4b:f4eb with SMTP id
 nv4-20020a17090b1b4400b002474c4bf4ebmr6761742pjb.21.1682712862591; Fri, 28
 Apr 2023 13:14:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7300:642a:b0:b2:10f6:1d2e with HTTP; Fri, 28 Apr 2023
 13:14:22 -0700 (PDT)
In-Reply-To: <CAAxE2A58Wp-2z3CKadQfgGkAZA2emH5Z3Z0_soiZEPNmKhkuBA@mail.gmail.com>
References: <CAAxE2A6hmv1vjTE4zWoomwjSP3ssF-8CGU5t29m-WOBjbtU37Q@mail.gmail.com>
 <1311F54B-10AE-4492-BB7C-F4BEC9676983@froggi.es>
 <CAAxE2A58Wp-2z3CKadQfgGkAZA2emH5Z3Z0_soiZEPNmKhkuBA@mail.gmail.com>
From: Joshua Ashton <joshua@froggi.es>
Date: Fri, 28 Apr 2023 21:14:22 +0100
Message-ID: <CAEZNXZC+qbD2JJgV7gTYdNH-SNKhNBbzQKNDyzje0mPKjhSJYg@mail.gmail.com>
Subject: Re: drm/amd/display: disable display DCC with retiling due to worse
 power consumption
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Content-Type: multipart/alternative; boundary="0000000000006f230305fa6b1e0c"
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

--0000000000006f230305fa6b1e0c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I mean I would also like power and perf numbers for Vangogh given you
referenced 10.3.

Generic "power consumption is better" isn't enough to convince me that this
is the right call.

- Joshie =F0=9F=90=B8=E2=9C=A8

On Friday, 28 April 2023, Marek Ol=C5=A1=C3=A1k <maraeo@gmail.com> wrote:
> I thought the same thing initially, but then realized that's not how
modifiers were designed to work.
> Mesa should expose all modifiers it wants to allow for 3D and it doesn't
care which ones are displayable.
> The kernel should expose all modifiers it wants to allow for display.
> With that, Mesa can still use theoretically displayable DCC, but it will
only be used for anything that's not the display.
> We can, of course, disable it in Mesa instead to get the same effect.
> We would need perf numbers for dGPUs to be able to tell whether it's
beneficial with the cost of DCC retiling.
> Marek
>
> On Fri, Apr 28, 2023, 12:11 Joshua Ashton <joshua@froggi.es> wrote:
>>
>> I really don't think the kernel isn't the right place to do this.
>> Is there any reason to not just disable it from the Mesa side?
>>
>> We can already disable displayable DCC there, so I don't see why you are
even touching the kernel.
>> It makes it infinitely harder for anyone to evaluate perf and power
tradeoffs if you disable it at this level.
>>
>> The whole power vs perf trade is also not a big deal on dGPUs compared
to APUs. Probably needs a better heuristic either way to avoid regressing
perf.
>>
>> - Joshie =F0=9F=90=B8=E2=9C=A8
>>
>> On 28 April 2023 10:47:17 BST, "Marek Ol=C5=A1=C3=A1k" <maraeo@gmail.com=
> wrote:
>>>
>>> Hi,
>>> It's attached for review.
>>>
>>> Thanks,
>>> Marek
>

--0000000000006f230305fa6b1e0c
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I mean I would also like power and perf numbers for Vangogh given you refer=
enced 10.3.<br><br>Generic &quot;power consumption is better&quot; isn&#39;=
t enough to convince me that this is the right call.<br><br>- Joshie =F0=9F=
=90=B8=E2=9C=A8<br><br>On Friday, 28 April 2023, Marek Ol=C5=A1=C3=A1k &lt;=
<a href=3D"mailto:maraeo@gmail.com">maraeo@gmail.com</a>&gt; wrote:<br>&gt;=
 I thought the same thing initially, but then realized that&#39;s not how m=
odifiers were designed to work.<br>&gt; Mesa should expose all modifiers it=
 wants to allow for 3D and it doesn&#39;t care which ones are displayable.<=
br>&gt; The kernel should expose all modifiers it wants to allow for displa=
y.<br>&gt; With that, Mesa can still use theoretically displayable DCC, but=
 it will only be used for anything that&#39;s not the display.<br>&gt; We c=
an, of course, disable it in Mesa instead to get the same effect.<br>&gt; W=
e would need perf numbers for dGPUs to be able to tell whether it&#39;s ben=
eficial with the cost of DCC retiling.<br>&gt; Marek<br>&gt;<br>&gt; On Fri=
, Apr 28, 2023, 12:11 Joshua Ashton &lt;<a href=3D"mailto:joshua@froggi.es"=
>joshua@froggi.es</a>&gt; wrote:<br>&gt;&gt;<br>&gt;&gt; I really don&#39;t=
 think the kernel isn&#39;t the right place to do this.<br>&gt;&gt; Is ther=
e any reason to not just disable it from the Mesa side?<br>&gt;&gt;<br>&gt;=
&gt; We can already disable displayable DCC there, so I don&#39;t see why y=
ou are even touching the kernel.<br>&gt;&gt; It makes it infinitely harder =
for anyone to evaluate perf and power tradeoffs if you disable it at this l=
evel.<br>&gt;&gt;<br>&gt;&gt; The whole power vs perf trade is also not a b=
ig deal on dGPUs compared to APUs. Probably needs a better heuristic either=
 way to avoid regressing perf.<br>&gt;&gt;<br>&gt;&gt; - Joshie =F0=9F=90=
=B8=E2=9C=A8<br>&gt;&gt;<br>&gt;&gt; On 28 April 2023 10:47:17 BST, &quot;M=
arek Ol=C5=A1=C3=A1k&quot; &lt;<a href=3D"mailto:maraeo@gmail.com">maraeo@g=
mail.com</a>&gt; wrote:<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Hi,<br>&gt;&gt;&gt;=
 It&#39;s attached for review.<br>&gt;&gt;&gt;<br>&gt;&gt;&gt; Thanks,<br>&=
gt;&gt;&gt; Marek<br>&gt;

--0000000000006f230305fa6b1e0c--
