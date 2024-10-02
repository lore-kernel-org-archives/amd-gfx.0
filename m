Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FE1CF6D2E
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Oct 2024 13:34:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED1FB10E756;
	Wed,  2 Oct 2024 13:34:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=johnrowley.me header.i=@johnrowley.me header.b="GOtv1Im+";
	dkim-atps=neutral
Received: from mail.vapourmail.eu (mail.vapourmail.eu [5.75.183.223])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3191110E066
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Oct 2024 12:35:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E8E67C2572; Wed,  2 Oct 2024 13:34:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=johnrowley.me;
 s=dkim; t=1727872497;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=WA3wCUNPjgEZhdS+Uchp76uA2Ad3sgauFet9X7Tip24=;
 b=GOtv1Im+gTM+bpEdIg8YDI/RJ1ux48D5Gj6Sg+OUNolAOgyexuryPxVxp6v8GDQsXyJkLk
 KSsut6kh5/0nWld251k6MPqvAsHCb5CLnnYcWSRM8lhupAx4EXcwNxALSIMKfkm46WBmKS
 /GVuccSCbs+58I7ma/nB7LeupiJosM6zPI5HTsSE3CQ5Rx9FBsEqExQP1jUGMeeDEsD2CU
 B8xlSsnBVSE4E95Pw33C6kkTPrAh6398RDMHGEwhcumK+vvNov8RFowU8ZHo6socTEDIZf
 ue1WsNfPlLSVPFwcnimL07iymNMZqIUO4BunPL5/l6Yjg1vDp7Eywg2to46yTg==
Date: Wed, 2 Oct 2024 13:34:52 +0100 (GMT+01:00)
From: John Rowley <lkml@johnrowley.me>
To: Christopher Snowhill <chris@kode54.net>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 amd-gfx@lists.freedesktop.org, regressions@lists.linux.dev
Message-ID: <11202dc3-ac11-4043-9592-c50bc3f237b6@johnrowley.me>
In-Reply-To: <D4L9LH0XT9OL.2RUPJNHCEX3O@kode54.net>
References: <9b80e957-f20a-4bd7-a40b-2b5f1decf5a4@johnrowley.me>
 <925cd47c-8f1e-4b74-aeff-6d13ae5f0753@johnrowley.me>
 <95c575a3-100c-4808-b451-b92f14598188@amd.com>
 <836c2c82-4dfe-40f4-8d50-5e7bff04c38c@johnrowley.me>
 <7ed81635-3872-463c-94e5-e4972da9d014@amd.com>
 <bcc97e4e-ffe0-47a7-bd29-c993e5404a33@amd.com>
 <9c562132-64a0-41f5-80ad-8492d1039692@amd.com>
 <3c0dfd3a-9549-4afa-94b6-80041f498436@johnrowley.me>
 <25eed927-fe69-4005-8c0d-c5f3052e662e@amd.com>
 <92af8678-2b45-409e-82d1-f273fe907a36@johnrowley.me>
 <D4L9LH0XT9OL.2RUPJNHCEX3O@kode54.net>
Subject: Re: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <11202dc3-ac11-4043-9592-c50bc3f237b6@johnrowley.me>
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Wed, 02 Oct 2024 13:34:49 +0000
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

If you're referring to the Freedesktop DRM issue then sinatosk a separate p=
oster. I'm not involved in that thread. =F0=9F=99=82
----------------------------------------

From: Christopher Snowhill <chris@kode54.net>
To: John Rowley <lkml@johnrowley.me>; Mario Limonciello <mario.limonciello@=
amd.com>; Leo Li <sunpeng.li@amd.com>; Hamza Mahfooz <hamza.mahfooz@amd.com=
>
CC: Harry Wentland <harry.wentland@amd.com>; Rodrigo Siqueira <Rodrigo.Siqu=
eira@amd.com>; amd-gfx@lists.freedesktop.org; regressions@lists.linux.dev
Date: 2 Oct 2024 11:57:12
Subject: Re: [REGRESSION][BISECTED] 58a261bfc967: choppy GPU performance

> On Tue Oct 1, 2024 at 2:32 PM PDT, John Rowley wrote:
>> The attached patch seems to improve rendering performance a lot; animati=
ons and desktop performance are generally smoother again.
>>=20
>> But it doesn't seem 100%, e.g. if I let the laptop idle for 10 secs befo=
re interacting with the touchpad, the desktop cursor seems to stick in-plac=
e for 100-200ms or so, before becoming responsive again.
>>=20
>> This 'sticking' problem doesn't seem to occur with PSR disabled.
>>=20
>> My testing isn't exactly scientifically sound I'm afraid, if there's a b=
etter test or benchmark I can run, please let me know.
>=20
> May want to also tell the list that you mis-applied the patch on the
> first go by misreading what it did and editing manually. I'm eager to
> hear whether the actual patch worked out better.
>=20
>>=20
>> On 01/10/2024 22:16, Mario Limonciello wrote:
>>> On 10/1/2024 16:14, John Rowley wrote:
>>>> Disabling PSR as per Leo's reply seems to have done the trick!
>>>>=20
>>>> Stock 6.12-rc1 (without revert): BROKEN
>>>>=20
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_=
state:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 6
>>>>=20
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_=
capability:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Sink support: yes [0x03]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Driver support: yes
>>>>=20
>>>> With amdgpu.dcdebugmask=3D0x800: BROKEN
>>>>=20
>>>> With amdgpu.dcdebugmask=3D0x10: FIXED! Performance is as it was on 6.1=
1.
>>>>=20
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_=
state:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 0
>>>>=20
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 /sys/kernel/debug/dri/0000:c1:00.0/eDP-1/psr_=
capability:
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Sink support: yes [0x03]
>>>> =C2=A0=C2=A0=C2=A0=C2=A0 Driver support: no [0xffffffff]
>>>>=20
>>>> I have the older Framework 13 panel (BOE 0x0BCA, 2256x1504 @ 59.999 Hz=
) so I assume PSR isn't supported according to Mario, yet psr_{state,capabi=
lity} above seem to indicate otherwise?
>>>>=20
>>>=20
>>> PSR and Replay are two different things.=C2=A0 But from your above anal=
ysis it does confirm it's a PSR issue.
>>>=20
>>> There's a patch that Hamza attached to https://gitlab.freedesktop.org/d=
rm/amd/-/issues/3658.
>>>=20
>>> Can you try that?
>>>=20
>>> Thanks,
