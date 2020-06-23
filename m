Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E838AC433E0
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 13:26:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE6820723
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 13:26:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="jGB5diQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE6820723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F36D894EB;
	Tue, 23 Jun 2020 13:26:18 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993246E986
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 08:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1592901192;
 bh=HZiR/bETShuZDGICBa76JrORZyMZ5O8UFT+ENDY9RtE=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=jGB5diQ7HCX+M39/Z8zyJ0y0X0py9tlbWApSDRWq83CXsTB5HoeMAjdesc4koElSd
 g04SneJdTsG0Na2tHkov1KVJ0NAVF263cenxvr29ogmomp3XViMI1jhMdkBYcbW8ty
 SWtk4WgOYvJMQhYCS8hIUuOQ6/I9idWCLe5vLw4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N1fn0-1iq8tz1e5Q-011xIT; Tue, 23
 Jun 2020 10:33:12 +0200
Subject: Re: Renoir kernel warnings and crashes with external monitors (DP mst)
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
References: <5142c866-fecd-b344-f650-70930fc4542c@gmx.com>
 <c3bf60a1-852d-de42-b8bc-e439677dd61f@daenzer.net>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; prefer-encrypt=mutual; keydata=
 mQENBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAG0IlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT6JAVQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVuQENBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAGJATwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCXZw1rgUJCWpOfwAK
 CRDCPZHzoSX+qFcEB/95cs8cM1OQdE/GgOfCGxwgckMeWyzOR7bkAWW0lDVp2hpgJuxBW/gy
 fmtBnUaifnggx3EE3ev8HTysZU9q0h+TJwwJKGv6sUc8qcTGFDtavnnl+r6xDUY7A6GvXEsS
 oCEEynby72byGeSovfq/4AWGNPBG1L61Exl+gbqfvbECP3ziXnob009+z9I4qXodHSYINfAk
 ZkA523JGap12LndJeLk3gfWNZfXEWyGnuciRGbqESkhIRav8ootsCIops/SqXm0/k+Kcl4gG
 UO/iD/T5oagaDh0QtOd8RWSMwLxwn8uIhpH84Q4X1LadJ5NCgGa6xPP5qqRuiC+9gZqbq4Nj
Message-ID: <ab81c5d7-7a81-9a2a-9221-aa6dc8f53b3c@gmx.com>
Date: Tue, 23 Jun 2020 16:33:06 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <c3bf60a1-852d-de42-b8bc-e439677dd61f@daenzer.net>
X-Provags-ID: V03:K1:m7XHoJOrZU23pJXrlN8IDZGGprbwWf0LaLu6eHMRNcK5EY5cLD0
 UTnB8WC3uqo3qtNShxq3wr5+dn/UGZjZTBTaGSm18pR0/A8ehWI3wnOqPJKYFZYCC/AnwTG
 sIgmwDh21sDHprpTFbvB2tYnsfBXtDFlY0HKqV6Hx52yI5o0QJ9hI8nF7icN2o8mDrJZfx3
 jr5NCZu5T3sby0ppWGwjQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b/laWbVUfns=:3IEAmE5gfrRuamUadbNQeW
 jCE//u/2diq0RsEnzSORziprAP8NvvhIbJss63Qs8mmJGBsKKsgu38iZKTGJes2x3mT+MRWVs
 F/yrnuG8942xtGMN/j/ndfTVz0uhixgT+yXo8JOKO8oEvIRONuvjkY7ySVdo2TWy8g/QOvkUV
 C9lx+vQZqVfFa0RszQuxQm92ZszH3h4kYQZ+ds0mXpTmYJCRd9+KZhWmjVhx9trs2dZt9b/4m
 aD9Pkoj1aIscq7PfKmXoGi8t05H5/Xam42+AUZPjb1nK1eYaUcanZ23N8MzvB/Y0Qu3lJWh04
 rWMzTsUg4jE7u2kthly+tHz909qE7EgkwOnqOAfvQUFjV+Yw0UZXha4fEn9BzXpITSVvLJypB
 llum+1XRyehlOj7cs4mCVzHDJomke/7LTlNW/57tI3TTGmnfVKLN0GJ20b9sIals60bdYSGvI
 8zfT3p9PsiJe7ye/Dk/OjBGvpPgemTaPFKTYPIhiqc8ieJ/P37zUxpROEldsIkDLe1vT/pbFr
 iRQYpKVwcQWagPUgQhQj2xYpzcOd0B2UpTmiYcGlTn2EWR8J+SVJlaa/ZfWIjA46tB8b4hMDN
 edpUTT1viYKVFW4iqdnYZzdgm6A5WPWozuc1c40Y0DbL9boGIRJ/lmBpbukthmq8Q9RE9pLoy
 appqMZYGQ+fYGhEyGkBamohjzRgtzzOx31POsYb2m6Dk83TNdgUqsgaKds77fSW6Yw+5f9kCC
 NSJ7go07RB9XrJ60b7V+b5fSu9GNAnBFxuoj7F6186gpsfQSImk50++6QhqHa6RgljqQJUpXr
 IfSXfa2hOxkaT0uvyVGsI4aRrNRDTOh8lc6tIb71vQ1GoxyQjBH62+75jc7BwEGz7/K9IzYvT
 8jOhRO/9KYUAiOpdA0LMPVkbVWDAbjGLoiiM2+7IxNbP33uXsZpYkfpp+yFyELHwSjkHG6N86
 OTRbMI9jJI5t9Tsw83VK9s1Dy8DMaPN0Hp6ieOAhsbsEPL/ZkyD3/Rrh8fjnZWC5uH/em1xmN
 yWhd0IGWlp9rIpWx1BobFC05EQgcS+cMowyuNiDWZFObGdDdFi3s+BA+DrXkLpwh3pNLyO6+C
 UuYBlIrKiZ1w886uCAGAkHn5DgDAzpeypkXPGfzTxyv3OSmj3EPJ788guTeLtx80l0X0C3e/H
 wqBD2IAShrywEViDkTGcyZvzIz5iDnhzpOrTXxBiCHVBzq+aiWOo5UQhkFRWG1fg+e/6QTZjc
 yAX+02S5tC+72jbdo
X-Mailman-Approved-At: Tue, 23 Jun 2020 13:26:17 +0000
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
Cc: amd-gfx@lists.freedesktop.org
Content-Type: multipart/mixed; boundary="===============1076935655=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1076935655==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Oc0zV7460mwDMTfCpyt932LYYIixcSIqN"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Oc0zV7460mwDMTfCpyt932LYYIixcSIqN
Content-Type: multipart/mixed; boundary="VheXZFFwiAoZ9zQQ3KapXMbL1ySrRPW3r"

--VheXZFFwiAoZ9zQQ3KapXMbL1ySrRPW3r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable



On 2020/6/23 =E4=B8=8B=E5=8D=884:22, Michel D=C3=A4nzer wrote:
> On 2020-06-23 2:23 a.m., Qu Wenruo wrote:
>> Hi guys,
>=20
>> Firstly thanks for the awesome renoir CPUs.
>=20
>> However it looks like there are still some bugs in the Linux
>> support, especially with external monitors.
>=20
>> My setup: - Laptop: Lenovo IdeaPad S540 13ARE (Or, Xiaoxin Pro 13
>> in Chinese market) 4800U CPU, with 5.7.4 Arch kernel. (Also tried
>> 5.8-rc kernels, even more crashes) The eDP display is 2560x1600
>> natively, but to cooperate with external monitors, it's set to
>> 1920x1200. And under my daily usage, the lid is closed, thus the
>> eDP display shouldn't be involved.
>=20
>> - Two external monitors connected using USB-c dock The dock is HP
>> usb-c dock G4, which uses DP alt mode MST for external displays. So
>> not DisplayLink garbage, and all monitors are handled by Vega
>> internal GPU.
>=20
>> Both external displays are 1080P 60hz, so definitely inside the
>> spec for DP 1.2.
>=20
>> - X11 environment xf86-video-amdgpu, along with mesa stack.
>=20
>> With such setup, the kernel boots with warning already related to
>> DP MST: https://paste.opensuse.org/54293967
>=20
> See https://gitlab.freedesktop.org/drm/amd/-/issues/1108 .
>=20
>=20
>
OK, that explains the warning.

Although for the crash I still need to setup netconsole to capture the
dying message though.

Thanks,
Qu


--VheXZFFwiAoZ9zQQ3KapXMbL1ySrRPW3r--

--Oc0zV7460mwDMTfCpyt932LYYIixcSIqN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7xvkIACgkQwj2R86El
/qiAOQf+OuO1juhTcKnsPqhmHzhaIATwVhtJFXoFL9ap2up2aF9sNMMIPxhuV9GO
CXlbnW3NyS48IXM9JXAn1GadYtLigWzj6bolLbTJ0MBn8VPBjMjzz0Nzg+jM63PQ
OtkZ+IugneWS+U8A/aaprSywTAj2aS1LCqerUrPk4CuxDGtSwL6SN5DzAFR9TD3B
e1qg+XKKfbJSHK4520h5hYAbkl7Rre5Y6UC32z1qazUFwqV6BfYAa7Je33/TLKhZ
0/l/kvHNVhPfMapnyouEKq4uqA0gGLCEevHcC8JrwqOyuaAkrbOD/QKzLQ+tp+nN
EjyHFzT3G16/gyPomMJVRxLQIUs1xg==
=VlyK
-----END PGP SIGNATURE-----

--Oc0zV7460mwDMTfCpyt932LYYIixcSIqN--

--===============1076935655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1076935655==--
