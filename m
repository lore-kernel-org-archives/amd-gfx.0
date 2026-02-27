Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED88FEE4EA
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 09:19:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE06510E278;
	Sat, 28 Feb 2026 09:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="REWOxg4d";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 650D610E1A9
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 23:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1772234345; x=1772839145; i=quwenruo.btrfs@gmx.com;
 bh=5XVPlbFAX3DUfBsLc64lrUlmLEAMMrD3hhu5WjnN6bs=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=REWOxg4d+1ou512zY4Tt+JOyFPxcLMbLj0Eo6qe0uCz192Mx4nB9Uc8J9ZUiSaEM
 ERnWhwjbe16U8zA5o38PGhZWSXExVglMZn1B/jiEltQ32Mlk1ou8oQjLaESui99S3
 nBPSlWs4450EjrlYZrcrhIcjf/O7WNZBSE7B9WuDvUHw/Cri5GcwiK4nd4Dwmi3Vw
 M+GBLPpNBSfFd0bUDiAMOhjdfoExUDd2rkxHgGwYCqQOIeWWIUtjAG1GRiEoXjNhf
 vdFEyG5qvmva5hw4PzOFDvDSz98lZf0Xs90rHA1q6guA6cxdsKG/3DIhnr3UHsP99
 W7Qhce+xd9vCF4ni4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1Mw9UE-1vfoiL1JdE-012bpX; Sat, 28
 Feb 2026 00:19:05 +0100
Message-ID: <a6b5282c-6844-41cc-b5a5-895567af1f4a@gmx.com>
Date: Sat, 28 Feb 2026 09:49:02 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: GPU has a very high load if the monitor is turned off by KDE
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
To: amd-gfx@lists.freedesktop.org, kde@mail.kde.org
References: <ab5b4f6c-f03d-4ca9-a80e-69cd43eb0c24@gmx.com>
 <ebc85e84-abd9-4647-8e79-6925895fa4b0@gmx.com>
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
In-Reply-To: <ebc85e84-abd9-4647-8e79-6925895fa4b0@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2eCfCzVg7AVqSMKQ19S0B9GGyjWGiNV8Tt6e95AFApdoF8ME9RC
 /2bgXe1BiRhR8NupxzGtytz3idANClxxM7/sLv2J6fr0RC7hYNFF1Vc8mK7vOW1DJnlnPjd
 M4VMTBF94p3HwcoltFI9a6HoNkEmwa7wGnc7Vhd0CmB3ivt4BTaCyn7eyBUKystJlQm5j4H
 txUCM0EG8dzX4KqHIRsjg==
UI-OutboundReport: notjunk:1;M01:P0:j34cIowXKpw=;NaMGuiB02JMFsvIp2db1zs242NL
 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
 W0hOrcw4=
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



=E5=9C=A8 2026/2/28 09:26, Qu Wenruo =E5=86=99=E9=81=93:
>=20
>=20
> =E5=9C=A8 2026/2/28 07:53, Qu Wenruo =E5=86=99=E9=81=93:
>> Hi,
>>
>> Recently I upgraded my Arch with the following package updates:
>>
>> - Plasma (6.6.0-1 -> 6.6.1-1)
>> - Kernel (6.18.6 -> 6.18.9)
>>
>> Both are minor updates thus I thought it should be mostly smooth sailin=
g.
>>
>> But after the update, after the monitor is turned off after a timeout=
=20
>> (10min in my case), the fan of my GPU ramp up.
>> This also happens when my system is put into suspension.
>>
>> Unfortunately the behavior is not 100% reproducible, but still=20
>> frequently enough to notice the noisy fan running.
>=20
> Downgrading kernel ruled out the kernel bug.
>=20
> And I have tried 3 times to suspend, and can reproduce the high GPU load=
=20
> 3 times.
>=20
> Another thing I noticed is, previous when suspending, the eGPU seems to=
=20
> be completely shutdown (only the power LED lights up, the work LED shut=
=20
> down).
>=20
> But now when suspension happened, the eGPU doesn't shutdown at all, just=
=20
> with its fan ramping up.
>=20
> Will try downgrading the firmware as the next step just in case.

Blacklisting the amdxdna module solves the suspension problem at least.

I can not hate the stupid NPU/AI thing more.

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>>
>>
>> The involved platform is:
>>
>> CPU: AMD Ryzen AI 9 HX 370 w/ Radeon 890M
>> iGPU: Radeon 890M
>> eGPU: RX 7600M XT
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OcuLink eGPU from Aoostar
>>
>> All monitors are connected to that eGPU.
>>
>> Any clue on what to test next? Is it something related to KDE or the=20
>> kernel?
>>
>> Thanks,
>> Qu
>=20

