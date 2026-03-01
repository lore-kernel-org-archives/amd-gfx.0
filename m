Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F3E2EA4E07
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Mar 2026 13:48:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BACB10E4F4;
	Mon,  2 Mar 2026 13:48:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="lhfPaaXt";
	dkim-atps=neutral
X-Greylist: delayed 316 seconds by postgrey-1.36 at gabe;
 Mon, 02 Mar 2026 00:00:53 UTC
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD8110E335
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Mar 2026 00:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1772409651; x=1773014451; i=quwenruo.btrfs@gmx.com;
 bh=bTIGSF5NsPv0G4ks6nGwKYOcvbN6IniMFPE2x9fPKIs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=lhfPaaXtV3hoNdyPIKfTUeYxg582qr4zoCEsOk8Qfg7iwMQ7+izghv6M9+oNVJkL
 lDmUnczrLSyaven6MoooLFxrypBJGNcM2Cngc7dfVMOvvnWNw4Mk7kreDYreW43/R
 Yfa/NEiH/iNB/pqrV+my6RI1QB9LeG0bFhhBGQHg/BdUFZpPlm0zGzuURGRdIMXd+
 pLIGOKmlGYWbhSkd1/BlJIGbfOa0q3N6Tz2etR4gWw51FKblR0Z3P9zSHkHefR2h5
 igE2d6yEeoaRLUGhimY3th4DOfF8FyyE/aImue9d7x0dEnqAuLGKvaJbx4kOzcsgI
 MlnPY4B/Cx1yOyXBnA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MKsnP-1wFlSk0Mzl-00QZH9; Mon, 02
 Mar 2026 00:55:35 +0100
Message-ID: <1dddfae5-ac4f-436e-a191-5dfd1b9e957d@gmx.com>
Date: Mon, 2 Mar 2026 10:25:31 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GPU has a very high load if the monitor is turned off by KDE
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: amd-gfx@lists.freedesktop.org, kde@mail.kde.org
References: <ab5b4f6c-f03d-4ca9-a80e-69cd43eb0c24@gmx.com>
 <ebc85e84-abd9-4647-8e79-6925895fa4b0@gmx.com>
 <a6b5282c-6844-41cc-b5a5-895567af1f4a@gmx.com>
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
In-Reply-To: <a6b5282c-6844-41cc-b5a5-895567af1f4a@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tHrkhm8LdbM06YmG6Hpcv9ALKvHsChtrLvuwpQxryI+UQPyTl/P
 cHk3wBKp2OS8HN7+l25AwlyTIszkZJdgVE5XmHtU17a/zSpCw1n9yMUngXLvr6uQyE6LyKi
 4ncDaOU2iQaZy5QQbKim8p2fvLxLnkA8UcikyIQD6xGw2GxXcyxNUxf2uOWcXsASyC4ny2+
 nMkj7um5VZwZXkoMZBMgg==
UI-OutboundReport: notjunk:1;M01:P0:NP0AmQBFzzg=;3eOznCMIL40EZPfvPrB5aqPAeFb
 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
 XHiYHPiiq2UINSun0=
X-Mailman-Approved-At: Mon, 02 Mar 2026 13:48:22 +0000
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



=E5=9C=A8 2026/2/28 09:49, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2026/2/28 09:26, Qu Wenruo =E5=86=99=E9=81=93:
>>
>>
>> =E5=9C=A8 2026/2/28 07:53, Qu Wenruo =E5=86=99=E9=81=93:
>>> Hi,
>>>
>>> Recently I upgraded my Arch with the following package updates:
>>>
>>> - Plasma (6.6.0-1 -> 6.6.1-1)
>>> - Kernel (6.18.6 -> 6.18.9)
>>>
>>> Both are minor updates thus I thought it should be mostly smooth=20
>>> sailing.
>>>
>>> But after the update, after the monitor is turned off after a timeout=
=20
>>> (10min in my case), the fan of my GPU ramp up.
>>> This also happens when my system is put into suspension.
>>>
>>> Unfortunately the behavior is not 100% reproducible, but still=20
>>> frequently enough to notice the noisy fan running.
>>
>> Downgrading kernel ruled out the kernel bug.
>>
>> And I have tried 3 times to suspend, and can reproduce the high GPU=20
>> load 3 times.
>>
>> Another thing I noticed is, previous when suspending, the eGPU seems=20
>> to be completely shutdown (only the power LED lights up, the work LED=
=20
>> shut down).
>>
>> But now when suspension happened, the eGPU doesn't shutdown at all,=20
>> just with its fan ramping up.
>>
>> Will try downgrading the firmware as the next step just in case.
>=20
> Blacklisting the amdxdna module solves the suspension problem at least.

Meanwhile for the monitor off high GPU usage, even with the xdna driver=20
blacklisted, tried different kernel (LTS, the last working one, the=20
latest) and firmware (the last working one with the latest), all the=20
same high GPU usage when the monitor is off.

So this looks more like something in the KDE part.

Thanks,
Qu

>=20
> I can not hate the stupid NPU/AI thing more.
>=20
> Thanks,
> Qu
>=20
>>
>> Thanks,
>> Qu
>>
>>>
>>>
>>> The involved platform is:
>>>
>>> CPU: AMD Ryzen AI 9 HX 370 w/ Radeon 890M
>>> iGPU: Radeon 890M
>>> eGPU: RX 7600M XT
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OcuLink eGPU from Aoostar
>>>
>>> All monitors are connected to that eGPU.
>>>
>>> Any clue on what to test next? Is it something related to KDE or the=
=20
>>> kernel?
>>>
>>> Thanks,
>>> Qu
>>
>=20

