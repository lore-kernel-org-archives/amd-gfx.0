Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3F9FEE4E7
	for <amd-gfx@archiver.kernel.org>; Sat, 28 Feb 2026 09:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B12DD10E297;
	Sat, 28 Feb 2026 09:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="DfVWCFun";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D2E10EC46
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Feb 2026 21:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
 s=s31663417; t=1772227407; x=1772832207; i=quwenruo.btrfs@gmx.com;
 bh=XYWsHwt7MmWIFs1XrnXwRd+MWvHb6RIA6K58lYp7a5s=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:From:Subject:
 Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=DfVWCFunNvtCEvohQNu9jM6jWk7t0Z58CoZmKqOAqw6OlKntGaIrF4oScu+W5kEO
 6y5dBlYRwvYDzw8FoiuTNLkhBZ43b+55F54nZEY8uKvaeMvUccc8IGb6IitSXIX4H
 yQdfOZ2oRGI3rjq24x0cKeTCs1XkrhKz2qFJ/7mI3SsE3JRc3kFjnuN4n/qGrUYWG
 akwsyqGufkWPA8SYgs4tDbTeFYYXgtX+XO8NGo07yocjYnCxgJOUplmyXt3+KidJy
 yyv50VRhBIGFRsi5Fhalowg7RGZAOVu+TSbIgoFuQdYkeVz4T02SN7xyGAPin49dR
 CG0r7ZMiBVodVnBmuQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MV67y-1w5XU81I4k-00PemW; Fri, 27
 Feb 2026 22:23:27 +0100
Message-ID: <ab5b4f6c-f03d-4ca9-a80e-69cd43eb0c24@gmx.com>
Date: Sat, 28 Feb 2026 07:53:22 +1030
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: amd-gfx@lists.freedesktop.org, kde@mail.kde.org
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: GPU has a very high load if the monitor is turned off by KDE
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pJANBvZ2UkZWmrnqxG393coIvozIvxJV3X+zkzHhzyqzat2dib8
 QJz/6/mySZrIVjfRKYtZrpqFYHWIT17Kb1pv7LWPTM8BuTUx+vgKumNI2ywV/hgbLerBjW2
 SQbVLNGPUX4MOAsH+JnzNAxnUOrzcS6RzFp3pxlAOmPJ7eE+gdkVHfN/DO+DtLU0nWVrunv
 TkfQp2q+/pOytFehsK6/g==
UI-OutboundReport: notjunk:1;M01:P0:xHgkQ4Yceyg=;+2VZnHVevyLbZKk+GzZS4gPgYP+
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

Hi,

Recently I upgraded my Arch with the following package updates:

- Plasma (6.6.0-1 -> 6.6.1-1)
- Kernel (6.18.6 -> 6.18.9)

Both are minor updates thus I thought it should be mostly smooth sailing.

But after the update, after the monitor is turned off after a timeout=20
(10min in my case), the fan of my GPU ramp up.
This also happens when my system is put into suspension.

Unfortunately the behavior is not 100% reproducible, but still=20
frequently enough to notice the noisy fan running.


The involved platform is:

CPU: AMD Ryzen AI 9 HX 370 w/ Radeon 890M
iGPU: Radeon 890M
eGPU: RX 7600M XT
       OcuLink eGPU from Aoostar

All monitors are connected to that eGPU.

Any clue on what to test next? Is it something related to KDE or the kerne=
l?

Thanks,
Qu
