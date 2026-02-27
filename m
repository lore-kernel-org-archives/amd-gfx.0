Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2EBFEE4E2
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 09:19:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B10D810E271;
	Sat, 28 Feb 2026 09:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZDyKiIgc";
	dkim-atps=neutral
X-Greylist: delayed 333 seconds by postgrey-1.36 at gabe;
 Fri, 27 Feb 2026 23:02:34 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by gabe.freedesktop.org (Postfix) with ESMTP id 808B410E1AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 23:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1772233335; x=1772838135; i=quwenruo.btrfs@gmx.com;
 bh=BXI/cLhra62YaTdUshmEaz5vZVKYRgniRI28Nub5gB8=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ZDyKiIgcU+Kuel9heFNGa3DgiBtw/V6QocN6wtKtJSv+qXq2vreE/c1KW84yVe2t
 BAVzrdA4v1NVhmtWJO7VMoTPcyoXLm+Ob3s0/l6G0oYYP7zd5NmaJRZbGX3eqXGSz
 sQE8vurIp0k1/GfMmbUtx0xrwOcnAepnXyI+HWX92Qfo2JAEi0n4SbDcp8BdsdNkD
 tlbo8NOND+bQ8DJ55G55ocxmDyuPquvzMhBI2JE5OyUtUMTa9Q2xZd7tLpcK4Y47F
 o8wyNeE1FVwvidbYdTo5JYdSpOfsniQAQuji+VnX2OhS7j1jHj8RkFtxSyz5SufA5
 iYlWR8TratDzzzQFvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MdefJ-1vNK2t2qJd-00nwd9; Fri, 27
 Feb 2026 23:56:59 +0100
Message-ID: <ebc85e84-abd9-4647-8e79-6925895fa4b0@gmx.com>
Date: Sat, 28 Feb 2026 09:26:56 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GPU has a very high load if the monitor is turned off by KDE
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: amd-gfx@lists.freedesktop.org, kde@mail.kde.org
References: <ab5b4f6c-f03d-4ca9-a80e-69cd43eb0c24@gmx.com>
Content-Language: en-US
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <ab5b4f6c-f03d-4ca9-a80e-69cd43eb0c24@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HP8aTu0XGXBafYB1B/lDwq1Ymb8qbw/PaF6GoR42wafQN0Xb0Jv
 3esu/mtJxr0OINjcKhnxPlajEPYSKrof5u1MGcVe9CXkoBhFTuNBa1dKpuwoHELj4VMmedB
 97EYPyC8P+2cymxAaWIov0q2x1tcH0sH0J/KGQjKXoK54uHkGol6VSjeDj4naIoAQ7isZMR
 nRCF7/Mjw6wzHyhYNYYjQ==
UI-OutboundReport: notjunk:1;M01:P0:w0iJa5k20XY=;/JymCv0D1qnVa18DShMnUr/TpZv
 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
X-Mailman-Approved-At: Sat, 28 Feb 2026 09:19:10 +0000
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



=E5=9C=A8 2026/2/28 07:53, Qu Wenruo =E5=86=99=E9=81=93:
> Hi,
>=20
> Recently I upgraded my Arch with the following package updates:
>=20
> - Plasma (6.6.0-1 -> 6.6.1-1)
> - Kernel (6.18.6 -> 6.18.9)
>=20
> Both are minor updates thus I thought it should be mostly smooth sailing=
.
>=20
> But after the update, after the monitor is turned off after a timeout=20
> (10min in my case), the fan of my GPU ramp up.
> This also happens when my system is put into suspension.
>=20
> Unfortunately the behavior is not 100% reproducible, but still=20
> frequently enough to notice the noisy fan running.

Downgrading kernel ruled out the kernel bug.

And I have tried 3 times to suspend, and can reproduce the high GPU load=
=20
3 times.

Another thing I noticed is, previous when suspending, the eGPU seems to=20
be completely shutdown (only the power LED lights up, the work LED shut=20
down).

But now when suspension happened, the eGPU doesn't shutdown at all, just=
=20
with its fan ramping up.

Will try downgrading the firmware as the next step just in case.

Thanks,
Qu

>=20
>=20
> The involved platform is:
>=20
> CPU: AMD Ryzen AI 9 HX 370 w/ Radeon 890M
> iGPU: Radeon 890M
> eGPU: RX 7600M XT
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OcuLink eGPU from Aoostar
>=20
> All monitors are connected to that eGPU.
>=20
> Any clue on what to test next? Is it something related to KDE or the=20
> kernel?
>=20
> Thanks,
> Qu

