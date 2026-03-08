Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35433FCC074
	for <amd-gfx@archiver.kernel.org>; Sun,  8 Mar 2026 14:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D1A110E453;
	Sun,  8 Mar 2026 14:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=marc.alexander.philipp@gmx.de header.b="ceUSDanq";
	dkim-atps=neutral
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F03910E0F5
 for <amd-gfx@lists.freedesktop.org>; Sun,  8 Mar 2026 10:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1772964066; x=1773568866;
 i=marc.alexander.philipp@gmx.de;
 bh=ruMQ/6Fpyiisr9iQHUwWmGpNeJpPcQwKvm0yUefD+RU=;
 h=X-UI-Sender-Class:Date:From:To:CC:Subject:Message-ID:
 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
 content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=ceUSDanq5qgZiDaHirVsXjuGkRKIwy456kWAMpB4hXfWrgo24+SbeuD6MkpKvoBu
 mzADmXXcl+E3djh88KCUjSHLooUVIYnEX2s8SF43O5rUuwBFrMKQvSvSSoVmw08+3
 Q582mdXErBWddEjCxYqjYinIJdrx16z0hMPMv1MlBV7UexXmVnMVw+zb1O4u3vvVC
 iHX3xVzWQHCYkfic8R4ZaneDLHOIlsUesuGlazD55ZRNadGsbH0jtjmPiVCDaL8+X
 YHoGksMqNZXdeoUJhFX+4nY1zdixpiC2CxnPVvRIKExfPF4AzRbkT7dvMLajv0r8Q
 bEmHDNGvze0MTe8fag==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mgeo8-1vREB33R1A-00kKlG; Sun, 08
 Mar 2026 11:01:05 +0100
Date: Sun, 08 Mar 2026 11:01:04 +0100
From: Marc <marc.alexander.philipp@gmx.de>
To: developer.relations@amd.com
CC: amd-gfx@lists.freedesktop.org, support@amd.com,
 Ailina Mettig <ailina.mettig@hotmail.de>
Subject: =?US-ASCII?Q?Technical_Report=3A_RDNA_4_=28gfx1200=29_Compute_Regression?=
 =?US-ASCII?Q?s_on_Ubuntu_25=2E10_=7C_Request_for_AMD_Vanguard_Admission?=
User-Agent: K-9 Mail for Android
Message-ID: <82E6BCA5-155A-4453-8824-38574908185B@gmx.de>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary=----03RMOHF15DNCM1EG8JS11Q82JO9KF3
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:amW9ev4UnrmFkHl1MGj8CzWKtFBWHGTYAQ1Kim+1TuKOqiMy1VV
 /atnlCVHxMoIbQXV+cf6W/Hk2b+o5IFphnmiORiiLfaS7bBqifV8xAwvjVmlKrqKr2P2/lS
 EODXPrX9/zOL6pgtMSDbZ6CRgvytZ4TXLS5H/SDVNthKIPQdHOkc3b4VOm0j9glDz5pBWu7
 uo4gE03xUI2IdxHpgfb4Q==
UI-OutboundReport: notjunk:1;M01:P0:D8+zHxE4GcY=;v0e2IaLgi7dGblIhYvx4IfH5Ax1
 o5ak+iw73l9KjLmgv9pHFc5i/OiN73/dCYkyt8MMzIg7AnBmqzRVsLG5LIvQ7a4fzbEWoM3+Q
 3ZjD+bHObqMr8Xk+kOzBC04jRTymGILD3Tw6yA9c1dyIEmxGIaomVOSJUImABpiAL36zEhUP5
 ITIqdrg3on5B7XRQR/Gy2kAFYW+Guk7bivuLvaXAvJeE8TyXynWTgvqmuhIcw/wuEShj8PwHD
 pazAptHnChdl1qcKgXhhJDshd4HDPPfC6O/qKbSt4w20E7MQWrWqQe5vsMzWXTx9QOVPEtyi0
 PheWJUpCvEwhPJPgAfVcH/5Xwy2/EzfVRWqs1FE7HpktRZYGHNcv75+02FT/junzvlXRpdWNT
 u3oJnCszxxhdASFx4e3zqJZQiVVeh6gHJOe6ckTleXSdQK3jjqpVJ8FaKDmXznW1wgBPOWWxG
 EPRQXte7pSkCfyRamar6xXaxz9WocaPENdB+KKv9GU2jN5lbeV3MaKikpqdJtE6yQLEwIs5wC
 Md9BADKXz/m3LfXXz3ri6RKBCru30XK9SqYZMAALJxJNJfKv3AnqaPsHO7p4F0eiEjnNf2giq
 hW6F35MZrgG+M9nwUGFPnNphvGeGxKwOABGKxLz4NwKoEZV4WC8sWc7lbTUFa9DwAltZ7s0S6
 XLXRuuxSaLHiK9EAFe2i890sqByp9YWKDFcM3g5OiuK1WHGMexKBUAt9YEGgZihQLyAww3ANE
 g136yvCLsR3XFbKJ/EzSzJxxuEbUr4fq/VjDHOIn7n2Hjux1FAyoQ2h8TLbhR59d5sJO8CHAB
 Oh8anprEx4dlvhCkZIvkPaDaqgrCH+N/ZyTjnNDRUOv4DD8sujvxVGbeckl49R32P1Mz5LnE4
 JVxmAENAec8FC1dCeOcZ75ksGKLDzdis7cxywaTo4PyCV1cTeSKRTCRNVCPdICQZUgCZdIIgH
 3sGo7zh528Qmr+R53kz739A99caoWW8ReRQzqanpY3oep2p+5lWvnON2dH5b7BtnWLQG0KZVg
 8PTa7nzC8gDuEhpOaIdh3PWO2LsUfKTMVq3FRuxFDAilW19sSrGiCxfO4gAdv7cxmWhSQsbXo
 l0Lkw6CD6wQIwZ4rqDl6RzrLolA3p8s6E4JJsSYtSW7D+pbOFF9c4/ozo+Grz9vLiSIiltxYn
 8Xf6rLpaCVeJ2Mh1H/wssqHSoAUb4N3nEr8DxNhOemTVt2pi5fqkf70uxaAqyRKTuCBS4AD7s
 PoM99MCeETctWkz7z36rzx0/O/R6JFN1g1GqEjDVCevnxIS5R9GE/HVnByWQzy8xM65rNQewA
 kKu/YqdBp5BwaVEzK/46AE9nBexDia4tZCpWCzfqe1eWhm98pKaH69M2GLHSjBzb+Sc74kRrU
 pQ+MYVHe9JRlNNt3yjDoixfnXeEVSuFyDPIEP934TqSBZpDfeH0VDZ15SKdUEhI1zxNfxy6Qt
 87/NyttHymQG7GEpTUoIZMy8yK06tRXPxrw16goB6TemWk2yP3Leg1VD9YsNhaynNREdBB3Yf
 /uwvH9E+1Gy/U+Mqn5jDbssVPKcmu+S3syOvL/JP9lp8FOCh40MN28ILbub3vfmZIBCTvGAf3
 VpvfKYACx4OMgOUmmX+pDmiqgHtM2g00i2zQ8sb+EGg/Td+f1ZhkGe+rlNL6giRQoyu4pKfPm
 NHH0dvn3DVXAVzljwWQ9aeXLE8l4lABj/kstoEhr7rfLfEod/6+kSDmFubqEzdLelaMdKI7X5
 MDerFki4p3SFaXqrn64lPdDjpKlCADwJ+3r+3Mwl9Uioi5tAhLeqpFoPOl0CFbgkv5LEP/HaU
 8N09WmxwlIcOrw89lNBhXoCBgHpQX1qoavMZevTFntq7m+1fAysfPpya3aG+9JyMbAoFItJPA
 7Dp8PAVQiI7bUrBAh3U0k1QiFerwUREKEGn9u4xuq9b77KpUOoaNZjRrxZqgCCGBVB9KCHZbh
 52L5/D8Jnyzjb188p69qaWi4NhuOQkBJKahlNvtO7j01C+Ul/ccjlwE1XpfMoUUBztXBXQOhJ
 s1M08CdWaECO1EqdY4GvyEdW7dz66V4IdLMk4w4ki9e5KXKMQoNE14UbMnoXKtsJzUUqfAU8k
 yJ50Sq5ujlsz44NJVm6OB+an8RSVaCqUb7jWLB1AgTLkq0KU5qtiejQK7MJD1jtn8OPPVAO3L
 u9vDzaqi7jlQ7ZeUNwaiKqeJC6czMR8Wob/b3UheKto8RUzNx4VCi+costd4t19gFpAZmnpTZ
 ZgLCOKX95w/q6A0gxvf4l6LQcYDBk4g86QMnOgyLa76rU/lsAyBCLcvcKu9quwGhj5lJ+kVFC
 H3y2GGatdWcdvW9E0tyxd2NbQXFsTCLwmlhhEMucvQZX9zp3+b4qNzDD7mbzXTpRrJUQoaUM2
 UjhBSKYWaVBbNmybtdB7XyOgmQNSZEc8s/lNuZfI3N2G/79XP6LhkRU469lKDKk8wyDVXLnoe
 htOdT4D9axgDOZwPQhgDiyb8Y9hHwXg51My29dmt0DF9oEA/u+2FovRijkim2WFcXBKIndETL
 ilLGLsQWoPIlYVx10KvJM23uuDzuP5jOY181m1rn0jMkqY2VTEq8vUSxFC2J5a1zh75YdhF9n
 bMcJNXpd4c7VXH6iqk4cjnqtAaqapqzPBoq9YQWtEx+gJGeQiJq5LnGMLzvzwGD+bwEPSTgrC
 XxISgFCHV7mJP91AQoOmcYjulDdHMszBqi5fS6QA2LtG58q4sAPFbj/yXEqtsD6dawbhp3gcE
 BU/p4rXST/gNowPSeQwG8/dPGJzmwmdQh9sHCcKO9xkolHb4yh46XwCZkYoXx1u9ATEvSqhO0
 +Fyb27A1hZ1Ou9CEtkzxZc59ZxGGr+A7JP9n1SCoLsDMPElL6tC16PvEuOrbBfMfETleX44s2
 0sn1pinZGdJQnbppWJOiXWZJ6Ok6ke2GP+O+U4GPRhnqVx2T4Tlj6ckqPwYDItvB9f/0VqjT1
 p4NNmgl+eFcVcYlY8avRkqbMRLRPFMMoofnQ5SbKVENzFFkY75MIVkzbLoYCFy/EQQ5SfV4jq
 ZTCpWV+qXfInQ+3G2kUSYDvo5RSJiAlNmpC9hWD3e46PaHg9PIo4NwE/yoOLBVMWz4BqvaH5D
 AuRN8mlbFO4/QPu8Yuh+2EIH3UwTK9m8xqsikQ90vmRluWLqoHDNnO075AYCkSkWX4rrqRU6k
 vYn1HcUKn9S6pDIa1QllDyGBPfX/VW+3Wb9sVj1cvB4rrS2Ezyr7qfKQ+yyAMbSbR3njPvabd
 TzUO7RxTN0uOjrER9eNL4+Be9/TIshConrlS1ERhcTYvD8iNOUP29ieqb4yAX2QRO/NAfpjmP
 1uROR0u9NzedntbvQXMw8ViY4Wfzjfw7ZqiZ/muQOUTwCCCu1UP1smDHyDZ46/vSuGoD2+Cox
 tzHStIKrcQOslaFVGvwSEQkfq3is0XpC5urz+v+4FxNmJ2YYYjG0PY6eWIg/JLlWhFqnoerUJ
 uHwoVbXsQoYkcslM5jMjdVtAnX00+sl64Hm8yY0wGqxG7AlyJWJqJbpTMOUISqCiXSw5OFtuk
 IQg5w1wudLw66z/V9boBZlzo9IE6E5zhxsqYR9ZG58bRiQLujA2dkyB1Jaw+iykp4hTyrWD25
 XYnCOquHEPAf8lYeblMz8CZvic8V/juMx1nJcuMDpZWGpKmAzydhzrCg9umQultY3Z5PXG7uU
 cyNqo2LIg8ZsL9MfPwxlqPgta4rRvNv2cela/E76EjxM5mk5eUDmVIeoTf4ae5ysgsorbPK4a
 udqemVYfYnd791PvTtBePNJ+9+u0jB9jVuACCZsLmRfhNGERNQqdySJeAf8BrwpsABhJle1gf
 obDZpBgBeRlCMpzhVIu3VCEY7tcTQLSRMuWPlKvnQHYyeAeHjrtd/eW5iP0yVncMjUb0oS3eD
 yDW3s5MgqtTNSu+BeYTGqIt388OWqTdSvkb5reNOChtwF16esWQ5zOEE9wqp0mRmvWT4+WZ3v
 8I7kpt8htN/X7aBVznPYADaIZVf88Hzhm2lD9h+w4DAZoMNPVdZEwKExL8Z1b40Sq6l6d6cSx
 6nGSo8bGdXAg9BlrEw1ym6Mh3iIbpEUA5Fr9KiZyqY8I1bXLLwOkDl8LLiGN0FNPKrcAKysjW
 kRP+3qnjw9ts+baGZAoJwqUBOjScCzfEpp1yRlUT2OajsuTjsy6QdQfIHWopoIatK9qtZTkSg
 wCVMQZY99lk0K50KsNs4Ynk+IfKyGQwg4AwoSLRueXFsyoKiTCCbcCO15g5DL0OP7ysiIIxgf
 gaICHO1qCnaRLH4tO7qPQarXIrqRKsW9rk+jLtA8ii1gq4Mb1v0s0ZuZtRH5QgBfPlhRd+xF1
 eaHDis5dY+p4v9/tNglyiZCKiGmgLJ0b/FoJCZ6blZgC57zIXlS4GKxGuzdJMz78FOvGJttpQ
 2uML1YP7FLWB7CKtDEkQVdtEQRQCVSetkHArz88qPE9afKJLZaERVNCg3xfXFagvHLMn+3tUw
 ozgKeSTMVSAf9+M8v3FupeduzSX7k9CyPyz1gJvN07zphV/rfXXFaVLYYYVO6QC/c9C06Z2xH
 pjWxVpHpg/Nmw0qe71bMb0lq5Ias+qL4OdkkZ77efKf6pUL5o+Rcsf9gjCKeJPM+mrQLVhZT3
 1VGN1n2tBgWFZX+iX8gMGqmmiEHeAENMw9J6Sic/CMwTa6CER0uLIdRGgSE4LH0y52ruYj+mE
 BW23g/NICIZgm18uG6Yv8Gx3UKEoDY42tbGxRyRWl9/WXQuLTtIiCSLDZ6HyCC7/ql2A6Rwzk
 GZj78iieZxCJ8Z+9BA41Aj7lNHES4LYKIUXktMLFJAiJDxXpHHQifIwQsDItabXqi/QcBgYfQ
 ZHHFcAfIbgjYDaa07nEMlhV8nsXzMSfuB2nlh+pm3BYTlmVuSlUH/B96tmMzeNQBfRhsTZe4B
 dsyLF7Vzyr3g0Z+qbQiQspwVLGzwh3KQcX4HcfVFA/mZP0F+/mX+wV3naoGMzK08rc86lOJLz
 cW1s10EpJgpjR/P2HxzFSshOYehqlIHCPV+fB+5l9Nuf1oBfWSZjPvNyn68sNrhoQIfKDnZ+F
 WsAu2ouof8EHtsTlqfSJAY0jhsHqKo1ex8tZthYeXvgNriOSOau7ADB8ORUuNQSvYSFqPVY2A
 yaeZya1+PPsZ5K6uv6vJk7Nksx4Ikq93kYE/TfH+j1I3vZ5hw+4ekMUNYQkJ0rY7em6OqM8xy
 0axNA+cuN8VJxTZZt/ho92zrZWcvI9dRL1QXpQYXVRCStwXuj5oWGoLmhoqO34749ccpFJ2Z8
 gu2yFGQ7MhJQOQRfa1C30Mc5fNHmDJMO7t+HqykbgNKkKsgg2uoXon7qRV0WtK3KmrjLN0tGJ
 bG157B337qq1GA/fyAn87YLoffJYWymFqgK6DlJemS3A62TkNm+tgYggb4kGhkFjy4jdEV8bI
 lCgthZfdDlwoScDE6tiBkGu/6GBEGvk6dds9R0CB+aU9A8Bfc4/H6ck0e1j+X0DgTQf95FVof
 4nSwgJUJxjJ4nGxOxCj0TQnO4Nb+9pvIa1Ko=
X-Mailman-Approved-At: Sun, 08 Mar 2026 14:14:10 +0000
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

------03RMOHF15DNCM1EG8JS11Q82JO9KF3
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marc Philipp=20
Menzelstrasse 25
12157 Berlin=20
Germany=20


Dear AMD Developer Relations and ROCm Engineering Teams,

I am reaching out as an early adopter of the AMD RDNA 4 (gfx1200) architec=
ture=2E=20

My recent efforts to deploy Large Language Model (LLM) inference environme=
nts on Ubuntu 25=2E10 have revealed a systemic failure in the current Linux=
 compute stack that prevents this next-generation hardware from being utili=
zed for AI workloads=2E

I have performed a comprehensive multi-day diagnostic cycle to isolate the=
se failures=2E I am sharing these findings in the hope of assisting your en=
gineering teams in stabilizing the platform ahead of the major Linux distri=
bution updates expected this spring=2E

Reference Environment:=20
AI Workstation

To ensure reproducibility, all diagnostics were performed on the following=
 hardware configuration:
GPU: AMD Radeon RX 9060 XT (RDNA 4 / gfx1200) | 16GB VRAM
CPU: AMD Ryzen 5 7600 (6C/12T)
Motherboard: MSI MAG B650 TOMAHAWK WIFI (BIOS: AGESA 1=2E2=2E0=2E2+)
Memory: 32GB DDR5-6000 MT/s (Micron | EXPO Profile 1 active)
Storage: Lexar Professional NVMe Gen4 SSD
OS: Ubuntu 25=2E10 (Kernel 6=2E12+ / Mesa 24=2E3+)

I=2E Technical Diagnostic Summary

My testing was conducted using the llama=2Ecpp (GGUF) framework across var=
ious backends=2E The following critical roadblocks were identified:
Vulkan/RADV Compute Instability: While the Mesa RADV driver correctly iden=
tifies the gfx1200 ISA, the compute pipeline is currently unstable=2E Durin=
g SPIR-V to ISA translation (ACO compiler), the runtime consistently trigge=
rs a SIGSEGV (Exit Code 139) or enters an infinite loop at 100% CPU load=2E=
 This suggests the RADV compute path for RDNA 4 is not yet parity-stable wi=
th the graphics path=2E

ROCm Repository Dependency Mismatch:

Official ROCm (6=2E2/6=2E3) support is currently limited to LTS releases (=
22=2E04/24=2E04)=2E Attempting to use these on Ubuntu 25=2E10 creates catas=
trophic dependency breaks with glibc and llvm-roc=2E There is currently no =
official =E2=80=9Cinterim=E2=80=9D or =E2=80=9Cdistro-agnostic=E2=80=9D pat=
h for HIP compute on the latest kernels required to fully drive RDNA 4=2E

OpenCL Architecture Mapping:=20

The OpenCL/CLBlast backends fail to correctly map the gfx1200 architecture=
, defaulting to generic or incompatible mobile kernel parameters=2E This re=
sults in compilation failures due to undefined SIMD-group widths specific t=
o the RDNA 4 instruction set=2E
Container/Host ISA Desync: Attempts to encapsulate the workload in an Ubun=
tu 24=2E04 OCI container (to use stable ROCm libraries) failed due to a ver=
sioning delta between the Host amdgpu kernel module (required for RDNA 4) a=
nd the Container libhsa-runtime=2E

II=2E Inquiry Regarding the April Roadmap (Ubuntu 26=2E04 LTS):

With the upcoming release of Ubuntu 26=2E04 LTS, I would like to inquire a=
bout AMD=E2=80=99s readiness regarding the following points:
Synchronized ROCm Support: Will a native ROCm repository be available for =
26=2E04 LTS on Day=E2=80=910?

Mesa Upstream Status:=20
Are the compute fixes for gfx1200 scheduled for inclusion in the Mesa vers=
ions that will ship with the next LTS?

III=2E AMD Vanguard Admission & Compensation Request

The diagnostic work required to map these regressions represents a signifi=
cant investment of professional time and specialized technical labor=2E I b=
elieve that early adopters who provide this level of deep=E2=80=91dive feed=
back are essential to the health of the ROCm ecosystem=2E

I would like to be considered for the AMD Vanguard program to assist in th=
e validation of RDNA 4 compute stability on Linux=2E Furthermore, given tha=
t the hardware=E2=80=99s marketed AI capabilities are currently non-functio=
nal in this environment, I would like to ask about potential goodwill gestu=
res or compensation for developers providing these detailed diagnostic repo=
rts=2E This could include:

Direct enrollment in the AMD Vanguard or specialized beta-testing programs=
=2E
Access to pre-release ROCm builds or the AMD Developer Cloud=2E

Credits or discounts toward future AMD compute/accelerator hardware=2E

Conclusion:

RDNA 4 is a remarkable achievement in silicon, but the current software fr=
agmentation on Linux is a significant barrier to adoption=2E I am eager to =
help bridge this gap and am available to provide full system logs and core =
dumps to your engineering teams=2E

I look forward to your response regarding the April roadmap and my potenti=
al participation in the Vanguard program=2E

Best regards from Berlin, Germany
Marc Philipp
------03RMOHF15DNCM1EG8JS11Q82JO9KF3
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><body><div dir=3D"auto">Marc Philipp <br>Menzelstrasse=
 25<br>12157 Berlin <br>Germany <br><br><br>Dear AMD Developer Relations an=
d ROCm Engineering Teams,<br><br>I am reaching out as an early adopter of t=
he AMD RDNA 4 (gfx1200) architecture=2E <br><br>My recent efforts to deploy=
 Large Language Model (LLM) inference environments on Ubuntu 25=2E10 have r=
evealed a systemic failure in the current Linux compute stack that prevents=
 this next-generation hardware from being utilized for AI workloads=2E<br><=
br>I have performed a comprehensive multi-day diagnostic cycle to isolate t=
hese failures=2E I am sharing these findings in the hope of assisting your =
engineering teams in stabilizing the platform ahead of the major Linux dist=
ribution updates expected this spring=2E<br><br>Reference Environment: <br>=
AI Workstation<br><br>To ensure reproducibility, all diagnostics were perfo=
rmed on the following hardware configuration:<br>GPU: AMD Radeon RX 9060 XT=
 (RDNA 4 / gfx1200) | 16GB VRAM<br>CPU: AMD Ryzen 5 7600 (6C/12T)<br>Mother=
board: MSI MAG B650 TOMAHAWK WIFI (BIOS: AGESA 1=2E2=2E0=2E2+)<br>Memory: 3=
2GB DDR5-6000 MT/s (Micron | EXPO Profile 1 active)<br>Storage: Lexar Profe=
ssional NVMe Gen4 SSD<br>OS: Ubuntu 25=2E10 (Kernel 6=2E12+ / Mesa 24=2E3+)=
<br><br>I=2E Technical Diagnostic Summary<br><br>My testing was conducted u=
sing the llama=2Ecpp (GGUF) framework across various backends=2E The follow=
ing critical roadblocks were identified:<br>Vulkan/RADV Compute Instability=
: While the Mesa RADV driver correctly identifies the gfx1200 ISA, the comp=
ute pipeline is currently unstable=2E During SPIR-V to ISA translation (ACO=
 compiler), the runtime consistently triggers a SIGSEGV (Exit Code 139) or =
enters an infinite loop at 100% CPU load=2E This suggests the RADV compute =
path for RDNA 4 is not yet parity-stable with the graphics path=2E<br><br>R=
OCm Repository Dependency Mismatch:<br><br>Official ROCm (6=2E2/6=2E3) supp=
ort is currently limited to LTS releases (22=2E04/24=2E04)=2E Attempting to=
 use these on Ubuntu 25=2E10 creates catastrophic dependency breaks with gl=
ibc and llvm-roc=2E There is currently no official =E2=80=9Cinterim=E2=80=
=9D or =E2=80=9Cdistro-agnostic=E2=80=9D path for HIP compute on the latest=
 kernels required to fully drive RDNA 4=2E<br><br>OpenCL Architecture Mappi=
ng: <br><br>The OpenCL/CLBlast backends fail to correctly map the gfx1200 a=
rchitecture, defaulting to generic or incompatible mobile kernel parameters=
=2E This results in compilation failures due to undefined SIMD-group widths=
 specific to the RDNA 4 instruction set=2E<br>Container/Host ISA Desync: At=
tempts to encapsulate the workload in an Ubuntu 24=2E04 OCI container (to u=
se stable ROCm libraries) failed due to a versioning delta between the Host=
 amdgpu kernel module (required for RDNA 4) and the Container libhsa-runtim=
e=2E<br><br>II=2E Inquiry Regarding the April Roadmap (Ubuntu 26=2E04 LTS):=
<br><br>With the upcoming release of Ubuntu 26=2E04 LTS, I would like to in=
quire about AMD=E2=80=99s readiness regarding the following points:<br>Sync=
hronized ROCm Support: Will a native ROCm repository be available for 26=2E=
04 LTS on Day=E2=80=910?<br><br>Mesa Upstream Status: <br>Are the compute f=
ixes for gfx1200 scheduled for inclusion in the Mesa versions that will shi=
p with the next LTS?<br><br>III=2E AMD Vanguard Admission &amp; Compensatio=
n Request<br><br>The diagnostic work required to map these regressions repr=
esents a significant investment of professional time and specialized techni=
cal labor=2E I believe that early adopters who provide this level of deep=
=E2=80=91dive feedback are essential to the health of the ROCm ecosystem=2E=
<br><br>I would like to be considered for the AMD Vanguard program to assis=
t in the validation of RDNA 4 compute stability on Linux=2E Furthermore, gi=
ven that the hardware=E2=80=99s marketed AI capabilities are currently non-=
functional in this environment, I would like to ask about potential goodwil=
l gestures or compensation for developers providing these detailed diagnost=
ic reports=2E This could include:<br><br>Direct enrollment in the AMD Vangu=
ard or specialized beta-testing programs=2E<br>Access to pre-release ROCm b=
uilds or the AMD Developer Cloud=2E<br><br>Credits or discounts toward futu=
re AMD compute/accelerator hardware=2E<br><br>Conclusion:<br><br>RDNA 4 is =
a remarkable achievement in silicon, but the current software fragmentation=
 on Linux is a significant barrier to adoption=2E I am eager to help bridge=
 this gap and am available to provide full system logs and core dumps to yo=
ur engineering teams=2E<br><br>I look forward to your response regarding th=
e April roadmap and my potential participation in the Vanguard program=2E<b=
r><br>Best regards from Berlin, Germany<br>Marc Philipp</div></body></html>
------03RMOHF15DNCM1EG8JS11Q82JO9KF3--
