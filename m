Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131BCE77188
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Dec 2024 14:51:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B776910E500;
	Mon, 30 Dec 2024 14:51:54 +0000 (UTC)
X-Greylist: delayed 902 seconds by postgrey-1.36 at gabe;
 Fri, 27 Dec 2024 22:28:28 UTC
Received: from sender-of-o51.zoho.eu (sender-of-o51.zoho.eu [136.143.169.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D906110E2F5
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Dec 2024 22:28:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1735337592; cv=none; d=zohomail.eu; s=zohoarc; 
 b=FAJyWnQkW3J6gCkDS3wv80v/NWq2U7j1SFQSlfIIexJsBqFNtdjdguENydNjfizgiNBFDqWB/8AMt7HUIcfSPjVdbqmcaIb4USjjl2uD6zWn5HfuZGPISZzl4+a8UR4W5Mj1aixaqCIz4gSigolxFH1QnHOsX2ir3UmTlNLDoPw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu;
 s=zohoarc; t=1735337592;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ZAKQbwWFK/eaUYts22hNPdnUOqBUiP8ihdLJhjDQp30=; 
 b=jhYEIAoF+9y2KCDXYBIta8+sZ2mjjjOg6AEuMaJ3bef3AUCVxtMhwQmKdL0TNFgijEq4gZWp0sEi9tgyq1isztmI8mBp1ElmwvkcOKitqQagK4xS2EYXX/hCszxbwq6LNG9Gcs9trJyW8Aw73fUUrfJTwPIM/llxsQzSH9pgZhc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
 spf=pass  smtp.mailfrom=carl@uvos.xyz;
 dmarc=pass header.from=<carl@uvos.xyz>
Received: by mx.zoho.eu with SMTPS id 1735337588735460.58844910928804;
 Fri, 27 Dec 2024 23:13:08 +0100 (CET)
Message-ID: <d77edb9a57236c0ee4a8b0e0c303504250f1ea3a.camel@uvos.xyz>
Subject: smu11 Uclk behavior on arcturus
From: Carl Klemm <carl@uvos.xyz>
To: evan.quan@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Date: Fri, 27 Dec 2024 23:13:07 +0100
Autocrypt: addr=carl@uvos.xyz; prefer-encrypt=mutual;
 keydata=mQINBGVOCIUBEADDPZFKPwxxb8Bmp/dhm0XBGds917diVc0s7lLNJfu1RMviwbxhaJg/L
 RUOBohrnx60nkvsP1y/CG30n/shrnSjWQaBfQVEjWv/dB85IzDXNdCDooBEyrTkbvCfk+cYUf79I9
 GVUwV6eVttfrYyp7PZ6QyQ9DL1QG5chAd2VwHbPl35kwr5AROW0yDpnPzqpx+reDKoeHLWRzU//t3
 NQTvXQUWzJEPY2Uzz3r8eXkGDEquy7DzZ9WHv7jhpQ6iZGyZniRxXY/cypnOFS4cEd/kwPAXRRKC2
 OHNoTJaiu3sGaVjqTGRaVpbTkMghvnZsi6fuHsdrVgfq6iVulgxtK7BzPG51dRkYvocmLtGZ/b1jB
 uzi2nry2FIsgvOe0m6bxsEzFEaet745PKqkkigLABOeWM5IRj8PSN+kS5PK/gV+hqUXRSV/hFWl0T
 DVVa2i2bHZX7aIUX2dCHOjpRBMhtBbyRxBs4EC/MvseN6+btUyjxbtcnpQ55cIQwCdhLtap4ebzYV
 AikEpAfne7qdYbeUXQKlYqY4RjYaXIRqcdejcjZZ/FuynNgVVK2milxES+ttSw+FoHeH/3sXKJNAS
 Y8W28kew+nAL9qSYHlqt+V7iKCTui7MZm0ybIbwa0QzIJCkh9WmpnMvavUml8MfH8mx+wHDLy+5lc
 HjmmQP9abE4pQARAQABtCJDYXJsIFBoaWxpcHAgS2xlbW0gPGNhcmxAdXZvcy54eXo+iQJOBBMBCA
 A4FiEE0QDoF9wkv7l1UjjCNriuqhoLCrIFAmVOCIUCGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4A
 ACgkQNriuqhoLCrJjmg/8DVY3iKA8I+sB0Bo5EZ0tT1+6NtFaBGe5NBuGGvuGxtlppGwTXHv1Bbzj
 Z2Rp3N1/w6IjSnD5wk5q/dCVNqprSYo21kP1OChtB4WcKMrKK12eOKvqwxpckFB7LfaCnef5meYS0
 +s5h4fmv9xGtUvn6y9liHof25/AtyBiDZeC/mHlcnuepz1wb0XCOpKIaA7Wqetv7zsRvq7GAk/x3B
 IasLKxmDDG9w/Yg0n4sMpF2dS1r9nRlJmSbsFyqQ1TnEthFNvifB6/0U6XXDipMCDjciJ9L19LWyu
 Fry8gcXuHOIXZkQXLYUjfrN0xalANK/woCivhI9jvs5IJe4CXhrXSZSazqBJMh2lUzdrrQUT8cYYj
 +b8haNrmS+kQw2AslqfG8coOf0zJ/542rn8VR/O4o/0zu/l3i8ZvEESmyROuBgv0Pq2gBHTCP1+Em
 pMf87BBA1cgdM8EDJ2Yn8dWc4Z6F8DwCPl3j39G2HHHgG4uZEfkZZ3NHK9TZjaiO7Zq3nWwFM5o7Y
 LgY+9k200k6EOAh+pl4DtNA/MW0CLpAfrWIgYdb0onvRugeAbbmNxlFQc0ta91NrwjLTMGx6Eczjn
 EhizGHwuV7neNCMf4vADep5jNGmw+wCDsK7JZtghCnISglPMz7zURqzW791l5at54XnIi1YVp2ab0
 jTPn2xLgvJU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Mailman-Approved-At: Mon, 30 Dec 2024 14:51:53 +0000
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

i noticed in drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c that
arcturus never reclocks its memory, allways keeping it at the boot up
default of 1200 Mhz regardless of load.

This is despite teh fact the vbios on my m100 devices contain other
uclk states too:
  FreqTableUclk:
    FreqTableUclk 0: 600
    FreqTableUclk 1: 800
    FreqTableUclk 2: 1000
    FreqTableUclk 3: 1200

I would like to inquire why this is so, it seams that amdgpu is
needlesy buring a tonne of power whenever the mi100's are idle for no
particular reason. In difference to some other amd devices that lock
their memory clocks to a high level in some cirumstances mi100 dosent
have to contend with the timeing requirements of scanout buffers,
makeing it all the more puzzeling why the driver is desinged to behave
like this.

Is there some errata in arcturus hardware preventing the reclocking of
the memory? Is this an oversight?

With regards,

Carl Philipp Klemm=20
