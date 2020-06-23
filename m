Return-Path: <SRS0=XGq4=AE=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B53C433E6
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 07:49:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1796620771
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Jun 2020 07:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Cid8vqDd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1796620771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C44936E977;
	Tue, 23 Jun 2020 07:49:18 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39D06E1F3
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 00:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1592871824;
 bh=0+MYqNKXdYy0wI31MEcZKFU5aoZnMhAIPdBenhXVf0w=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Cid8vqDdqwt8UXuZKxOG2u4K77/sEIvsQZOqEvjCm4RIsTSigA1Ek8+dhveAYRT6K
 ByCMVnsOUVp+xsdFgP9C2upilBfrGizcU5rJYkHg7g+L4INkbIsZsIjrsbjM6ia5D1
 EOzw1DxFO9v/AnZs3jqxyn1pW136Dsw/OVBqxQfQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.com (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MV67o-1jOkLh1gz0-00S4iR for
 <amd-gfx@lists.freedesktop.org>; Tue, 23 Jun 2020 02:23:44 +0200
To: amd-gfx@lists.freedesktop.org
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Renoir kernel warnings and crashes with external monitors (DP mst)
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
Message-ID: <5142c866-fecd-b344-f650-70930fc4542c@gmx.com>
Date: Tue, 23 Jun 2020 08:23:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
X-Provags-ID: V03:K1:q0VxdZzDhfRbSy8EMLjq4wUz2Q+MDrVLuBrVOmjWBvDgFB4Zwxk
 AfUhqtw3N2HWhb3iT3pXimTS1zqgeV+dIcBcNd7Q9Ul/C3HBIxDavF3dsQ+kohpthZMAgYW
 /AeZDNXWou9Qm2lHwRkXDipNBtOjEz/tZderlvMYgxB1SH0MXoN8mO6cKIlWQCwue8wjdAG
 S2/lvMDfnRky3nXwO/VzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dfgo9dsaKWA=:GZVhNk/7SfW5T63tWAIpDj
 6BdmAGx8Ts71aJT9T8WkfHekqPtJjsY1Q01PIEzKA2FOyJJ0UdI9HIVKEpqOsiQnNAoV7ArII
 zEA2izJBcpX/QjQlJX3rLCC4uQsPFbroLQrv9hXxe111uPzqmRr1Rw9k4/cNUOn5CwreWFiRG
 ONBx1BGggmoOB75FoHEzJUmwm71kt70fDc/oP6RNpsu4yczwxoBUG3EvFwj29X+s6Lw7GAyUT
 GWNdqBPboasldVxaPNg0i6NrOppRUKR7MmpCidoynA2NQkmvO6Wn+2XaozmMPRl6RSZtujfqa
 A0u9cQ+4sWxz1FcbQeXiMCkqHZf/0SPq4A/6wEEnTJDn7VNcLKzSZry3KvNyg6nNIQlc1YVCr
 Cy+Rs2NBK84V20BwsQV0KzMHeLw/4F66pt3Ma5gCQHNOPp1P1SCfXxXLB6rbeRlGzAaU/E+IH
 NSpjfb0E9kFAeep6f9RFNqi2yYzbv3BiR3cGPwmqZy7lk8XO6aMjeL3sI0dM6v89AIpjlwXm8
 TqjohhfE+uqsKOWk1WPoQvj+ij5krdRVLZhtriER8UDF46w5ozLmRPMq2S2yZtyWSOyORB0N9
 gSCaetSYTRAnRFTKgzcxdsx33LLFdAdw7guM8WDkc/6dCc2RLTAwIVmpva7fsg79g1alD1i1t
 J2qqVqPFTFvwLvg7IpaoRDOe6YXzdA0cLmXLl4qYscTgzVFHh1EOq1bShgYUFEwUOw7Oe9QtN
 0JfBIChEIdkuRmOWAARd1WkSOrQgiwX5SCy02ouXOjgmDGPCCqYwWEzr1VAnv0hMPKAjB7oDD
 rLD55vbh6LwqbX5VKnRZX7iU2mqnYEBf58qPz7JvPZlKjphLSp8C+kjn7yMiXbWDVnAYidD3i
 C04GTE7fVsSwmybNUlERBJfeKYeefbIG4pBTScbh2ZPQ3FlypVDPDT+LVPn9GOHgg5qp3mCdE
 NF47k5AKnYy05JKNrQjbOe0GIGbkedepNJUwyf9UtV2jwJj39wT+WcITVCyHcG4oqWC0GXmLQ
 Eklk8y/488qRGQBiPZbHkFm4Ge0u4gH0Clx5SicV+NJXq7MvqRoY86yfIJIyInKOuxZaJhYbM
 8jZ1oIuxsBF4Q+IvZvMDeS/QfqvhaWRoxmmooBTcI2WTxRgEdbMAiIzYC1Y+VoGpaTSjnSnoK
 5D2jtJzuafRUnjjEJFPFl/mYUZ0+fihjDSk9FT80EzglS0laH15E6Of84MTr/t+zQjVUTOJoH
 2UQI/2GHQ2lbuH8e4
X-Mailman-Approved-At: Tue, 23 Jun 2020 07:49:16 +0000
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
Content-Type: multipart/mixed; boundary="===============1332621869=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============1332621869==
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Ll9EuxqJc91rQOv49VBjNoPwIP7AZ3Buj"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ll9EuxqJc91rQOv49VBjNoPwIP7AZ3Buj
Content-Type: multipart/mixed; boundary="K4lqSHLQGLTlXfyGnUDgnhCiu26BBjbTe"

--K4lqSHLQGLTlXfyGnUDgnhCiu26BBjbTe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi guys,

Firstly thanks for the awesome renoir CPUs.

However it looks like there are still some bugs in the Linux support,
especially with external monitors.

My setup:
- Laptop: Lenovo IdeaPad S540 13ARE (Or, Xiaoxin Pro 13 in Chinese market=
)
  4800U CPU, with 5.7.4 Arch kernel. (Also tried 5.8-rc kernels, even
more crashes)
  The eDP display is 2560x1600 natively, but to cooperate with external
monitors, it's
  set to 1920x1200.
  And under my daily usage, the lid is closed, thus the eDP display
shouldn't be involved.

- Two external monitors connected using USB-c dock
  The dock is HP usb-c dock G4, which uses DP alt mode MST for external
displays.
  So not DisplayLink garbage, and all monitors are handled by Vega
internal GPU.

  Both external displays are 1080P 60hz, so definitely inside the spec
for DP 1.2.

- X11 environment
  xf86-video-amdgpu, along with mesa stack.

With such setup, the kernel boots with warning already related to DP MST:=

https://paste.opensuse.org/54293967

Furthermore, under certain GPU load (?), the graphic stack just crashes
completely.

The reproducer is a little complex to setup (involves steam Linux and
CNC remastered collection, which needs to download 15G contents):

- Steam, runtime from Arch repo

- Purchase "Command & Conquer Remastered Collection"

https://store.steampowered.com/app/1213210/Command__Conquer_Remastered_Co=
llection/

- Use Proton 4.11-13
  As Proton 5.x failed to start the game
- Run the game

Then the graphic stack would crash, the external monitors lost signal,
and internal display won't react to any input, have to force shutdown
the system.

Furthermore, if not using the external monitors (disconnected from
dock), the game starts without any problem.
Thus it should be a bug in the MST routine.

The full dmesg (without crash) can be fetched here:
https://paste.opensuse.org/92544722

No call trace for the crash though, if really needed, I could setup
netconsole to try to catch the dying message.

Thanks again for the awesome hardware and the awesome opensource graphic
stack!
Qu


--K4lqSHLQGLTlXfyGnUDgnhCiu26BBjbTe--

--Ll9EuxqJc91rQOv49VBjNoPwIP7AZ3Buj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAl7xS4wACgkQwj2R86El
/qg0ZAf/S1j8Wp+cKvwYBtKCreV3UAwiYTjWcCUSGGBxjvvWxlEQ7UvB3mnw178A
iEW5MDtqVtU2cXeHeTzqKX5pJoDgvwteIiwPINSFThmwhEkRgJjOJdlqD6KwOEE1
tFFRoxoqt0KxhLkp7EdIhXwUngTEJ2A3E6Kx4Hn/L8SCjTPL6okwXFxKtoPhXOY+
c3/tU1Qvrjblq0EpwfXHOpcNtTCzUC2YVWY+vgTJlp/yGaOeIrzsCrpUlt9m7mdp
wDHl42wdxctDYvVkkBZx1YOry+ORtZP9yt2phWbRtSEHrfLEx2Sxf3/5yV6vB/PM
mFYZD4HCJo9K7c78uKynU3h+5qzLJA==
=Tsbh
-----END PGP SIGNATURE-----

--Ll9EuxqJc91rQOv49VBjNoPwIP7AZ3Buj--

--===============1332621869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1332621869==--
