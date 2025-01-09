Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B17E77188
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2025 08:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E9410F00F;
	Fri, 10 Jan 2025 08:24:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=w_armin@gmx.de header.b="sgZSDne0";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 984B410EE57
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jan 2025 15:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1736435306; x=1737040106; i=w_armin@gmx.de;
 bh=f8od1lEXfwPOxINOTWonWmKIGVU35VQkrn7TwAGSOwU=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=sgZSDne0AJOVyc17FQfia8sC2zQBDn8oIjykAkj0LhKqgl9JmZTqPuYAzKc1F8t/
 SeI3EUtPPO8R/M7HiD0Tjt7HsNX3Azhynk32PU+wKWw9YBpMEd5NrV9wMgwHPrtw5
 XroC6OHsoWhqNbDP83yHyTFuQwM4exoMp4E/zJ7+JVqtOux1ROjF/quIyLTCjrKFF
 lrp9gCLJcSy+mN6AAqgKNcx6eo9ObxnAl8vBdywUxy17ynJcjAzIlv8CoNvAkUZsF
 6XCgLpWKcBpc1yQXb1HMKET+/CUJu8Ooq6cSsxlZgSVF4IcSo/rahzWHPq8gf1QTJ
 IhrDuZp6WOdtBF/7kw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.100.132] ([141.76.182.72]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N1fmq-1tcGwL3SZM-013PLQ; Thu, 09
 Jan 2025 16:08:25 +0100
Message-ID: <ea8468ab-430e-4336-b1c5-6f6bc566950b@gmx.de>
Date: Thu, 9 Jan 2025 16:08:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: amdgpu 4k@120Hz / HDMI 2.1
To: Mischa Baars <mjbaars1977.backup@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>
Cc: amd-gfx@lists.freedesktop.org, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@mailbox.org>, platform-driver-x86@vger.kernel.org
References: <CA+b5WFEXPJ==vruf-6DHrhS7j3pnTaj_EQE08BimxqyaNvktQQ@mail.gmail.com>
 <d1028755-6a7a-4db4-bd4b-e5a2d682af61@amd.com>
 <CA+b5WFFa4hMeGnN0J2xd=FpU2Cxe_AjapWBpTFjfNhzUSOUAzA@mail.gmail.com>
 <0281e6f7-4ccd-4369-9182-d1580c9e6bc5@amd.com>
 <CA+b5WFEv1Qj3NYcwXaZz1EYW9omj7FmB8FdSKZnixsMNoi1+DQ@mail.gmail.com>
 <ddd7bf09-31aa-4e4a-93ea-b1336ced8578@amd.com>
 <CA+b5WFGDstoJTjgaT+hm4r-78zup1pLa2Ada7PqbTY=wCutSbA@mail.gmail.com>
 <98b3392f-2860-4a32-a769-b4dcd3f5dbbe@amd.com>
 <CA+b5WFGkDJhpRRywQLx2okttXGasBu6K8ScLZyakKrk1+FZWAw@mail.gmail.com>
 <5321c9af-6df7-4bf0-98b2-d6c4b2861374@mailbox.org>
 <CA+b5WFFkhQUcFO_45_6xmC4fk_GEFqbASt9rhGqBBYsothsHxQ@mail.gmail.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <CA+b5WFFkhQUcFO_45_6xmC4fk_GEFqbASt9rhGqBBYsothsHxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x2HjE0F4AFrTLWyaSJpuwbQgpqHxWe/c8Ud0MnoZloGm4L/pewm
 /ZouRqEbUvAijmsciQC4CT36bPZbxNhFXijSQYh2bLfnRNLq+wHKgKm+d6nXroHe3pNKI20
 d/OBTImBCceA4QlliGYLjklYtajYM8Jzrq2ackeJrrjqm2BxZFJelKiuBsYtbskwoxNquNv
 dEL08E24soXMY3Nx4UeAw==
UI-OutboundReport: notjunk:1;M01:P0:ah7sHLqDqLk=;Ti7WNj/5kdz4JGQ3ZnCtVGE1HQF
 AI3HCdwYT3pN4E+tdqE0BtGKM1h2JJOs4BHUEvp8iKjYt4202C4qFBZa34HTctqRzJWNidqYS
 R5MtrASGVxAyxJcjcYBxrwKm2/h1NwUK8TKPVWBzSj6K51GrcdCDQqgIdgbQkPZwr31y2JFA2
 1fiHmFRTV623DXfRKU1VlLjIEhXeVKvgx3oNL+kWTZFu0K0pJy7Lfhz9+nZSqfhwkx578wDCB
 O7uMlnxaLrT2PxT8kmeL2bm6dlqEv8b0Eeec7FBtuvvSUpAy+rtFnVIl9W6BJm97cy6p5zceM
 gJoxOlsnKsGCdKotEHecNsJ6dwaImmCgdldT7BpG8Znr/4DLQaHKzA/99KWz9yFQRg0JVsXOA
 vxE9E56uYR9+w5eYCZ6L30HPxZ1esrlmZPtqJRq2ETexUwqGNEOrScspQ4/YRLcesGUJIMc0E
 q7FYQp+UNt9lZb0p6H5hTPj/6uuePkZYgJQNJrPVZC5BBUPGOqqswnf1B3PF7ya1sI3wyYezd
 nrq7Zd2KxuHheyjctO9YCwORxi5Xh4Q6El/uWJa2oRdvoQcGX+Woi7jLdZ2hvY5i2p+kwYKJo
 YWappXR/xPWIfjjP5x+217N4+SmHJuS8OoXJWz14OXCX4Mxfl9in//Qp6VSGZNTO4czdri3Ky
 kweyqOAYB2dup6gR+HY4ss0XjasHMtew+I6CYstgEwD6BOQyjXgRensu/7UQucAcOFH92GYry
 ZAr3CvlZGGZOnFF5RUlVVWClYXdRyfz+Tuiozv7L6kdHywj6VeNdadlRe6OKfUW2cqRCyqVmi
 5B4fFQXyXE9T9Nf6pQ2I6aq1lX50IqnTBhBgNKuVzVcESfFMFoKdO6+0zoxF7pEFK3S5r80+V
 UZnFhUwFU5iyjva8O/WYg/yNI+m88qbfgVPrQ/hyWFWP5ThaU8RGy7zGrF8ubyX9f/2mY7yE/
 OeflF4ClduCZn51uBVCQmgMmJSsCTmGlBWd1/NZVfHsT5uX2wLYZsAzFOFAL47+Ek2f8FAUPU
 m9wSMYjh3slWVb4AN9reLEJ1SIX3Wbb1tv77Uu1I6P1X3UeOULnhKaQohcwGSlD135k14lnJJ
 0t1luoqzxUSOPZopwwjkhLWRa/m7cV
X-Mailman-Approved-At: Fri, 10 Jan 2025 08:24:13 +0000
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

Am 09.01.25 um 10:19 schrieb Mischa Baars:
> On Mon, Jan 6, 2025 at 4:30=E2=80=AFAM Mario Limonciello
> <mario.limonciello@amd.com> wrote:
>
>> When new specifications are made available it's not like the old one
>> suddenly becomes "open", so I don't see any reason that a new
>> specification would change anything.
> I paid about =E2=82=AC3000 for my new PC, including =E2=82=AC300 for the=
 graphics card
> with HDMI 2.1 output and about =E2=82=AC2000 for my new Samsung OLED TV =
with 4
> HDMI 2.1 inputs, and now you are telling me that I will not be able to
> utilize them fully because the cable specification has not been made
> publicly available?
>
> Did someone forget to pay the people that design the cables? Because
> that is what it sounds like. Why does Linux stay behind?

Sadly the HDMI forum only provides the HDMI specification under a special =
license which
prohibits implementing it in open source drivers.

Since membership inside the HDMI forum costs 15000$ annually, i suspect th=
at the HDMI forum
is abusing its power to force people to join (and pay).

I can feel your disappointment, but there is nothing we can do which does =
not land us in court :(.

Thanks,
Armin Wolf

> On Mon, Jan 6, 2025 at 4:41=E2=80=AFPM Michel D=C3=A4nzer <michel.daenze=
r@mailbox.org> wrote:
>> On 2024-12-31 13:42, Mischa Baars wrote:
>>> In the meantime I also checked the framerate synchronization through
>>> glxgears at different resolutions and framerates. This does function
>>> as expected. Although I haven't yet inspected the glxgears source
>>> codes in detail, the OpenGL double buffering must be functional up to
>>> some level. This means that the problem must be confined to GTK and
>>> the GtkGLArea widget. Using GDK_BACKEND=3Dx11 I do get a double buffer=
ed
>>> context, but the default buffer does not alternate between GL_FRONT
>>> and GL_BACK.
>> Yeah, that's not how double-buffering works in GL. The draw buffer is a=
lways GL_BACK, SwapBuffers doesn't affect that (it just may internally cha=
nge which actual buffer GL_BACK refers to).
>>
>> I don't see more context about the issue you're investigating, any poin=
ters?
>>
>>
>> --
>> Earthling Michel D=C3=A4nzer       \        GNOME / Xwayland / Mesa dev=
eloper
>> https://redhat.com             \               Libre software enthusias=
t
