Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1012C3601B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 14:10:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2FB10E5CD;
	Tue,  1 Apr 2025 14:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=cardosozeferino.com header.i=@cardosozeferino.com header.b="putsS8Ts";
	dkim-atps=neutral
X-Greylist: delayed 756 seconds by postgrey-1.36 at gabe;
 Mon, 31 Mar 2025 18:52:47 UTC
Received: from mail-4317.protonmail.ch (mail-4317.protonmail.ch [185.70.43.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B96AA10E030
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 18:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cardosozeferino.com;
 s=protonmail; t=1743447165; x=1743706365;
 bh=YpJ/l5PEOCB5cv5FlFtDLSWABAvqyqE8nyFvX4SF8E4=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
 b=putsS8TshpP3237zlq2+sazrkYBltcD5fg+SISwGlPy0Brjv5e+WP6/Iev9MZ18v+
 HMzBtsEyEqn49+gMoWPhp52PErhrYBIrR7S3ZXkEHtCfepd9Kw6MrKMDUStFyNW+p8
 E7NB1EobJZ3hacHUVf+4BA5e1Qsntshb0llFYsDcRd5BUGMxoB0D7YzLdbcM3yBtC5
 rl2X6A4Kr/V31ULp9Ia/fyk8PAyUKD2/Jd57zxtEVzx7Uge1BlII6w4VNKc7yc3Z+p
 /v14gMJEn4TDsh+30YiLwr4weaGfkJhhvGfHv8OS0GMKSI4yG/7hpCeyMV7M5bTZHD
 WKOTwI3itvPJA==
Date: Mon, 31 Mar 2025 18:52:42 +0000
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From: Leo <leo.cod@cardosozeferino.com>
Cc: "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Fw: regression bisected RX580 GPU crash chipset overheating (kernel
 6.8 and later)
Message-ID: <oSrvMpqcjQyRXhuYMJUBDZxjdZGRvZoJKzz7S9t679c-MacrTC0ByUoLJYZ9Dk0y9j8jcjYczkQChnuipFHjj_3SD1e2UYTjeW0quKkhrcA=@cardosozeferino.com>
In-Reply-To: <aHeSm_VYiQumMlj0NrCwhY5Fq9C_B26HgIjZDf4Vvd9KuRae3sY3pYng-sr4gzhyf9Ioto7PzIVm6UbXwuGjyCusKT-ldRZREFpfEbKnPtk=@cardosozeferino.com>
References: <aHeSm_VYiQumMlj0NrCwhY5Fq9C_B26HgIjZDf4Vvd9KuRae3sY3pYng-sr4gzhyf9Ioto7PzIVm6UbXwuGjyCusKT-ldRZREFpfEbKnPtk=@cardosozeferino.com>
Feedback-ID: 79006605:user:proton
X-Pm-Message-ID: 3f7014c18f54e414896c4aedf4a5737b957d199b
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1=_jTF5BhlPPxnPRstgXz2O5nAKhWBcO6Xr1F6r0U3QtY"
X-Mailman-Approved-At: Tue, 01 Apr 2025 14:10:13 +0000
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

--b1=_jTF5BhlPPxnPRstgXz2O5nAKhWBcO6Xr1F6r0U3QtY
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksCkZvciB3aGF0IEkgcmVhZCBvbiB0aGUgcmVwb3J0aW5nIGlzc3VlLCBJIHRoaW5rIHRoZSBp
c3N1ZSBJIGFtIGZhY2luZyBxdWFsaWZ5IGZvciByZWdyZXNzaW9uLCBidXQgYXMgSSBhbSBhIG5v
b2IgeWV0IEknbSBub3Qgc3VyZS4KSSByZXBvcnRlZCBpdCB0byBnaXRsYWIgbGluayBhcyBkZXNj
cmliZWQgaW4gdGhlIG1haW50YWluZXJzIGxpc3QuIEJlbG93IGlzIHRoZSBpc3N1ZSByZXBvcnQg
bGluay4KaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvNDA5
OAoKU29ycnkgZm9yIG5vdCBiZWVuIGNvbmNpc2UgZW5vdWdoIG9uIHRoZSBpc3N1ZSByZXBvcnQu
CgpSZWdhcmRzLExlYW5kcm8uCgpPQlM6IHJlc2VudCBkdWUgdG8gcmVmdXNlIGJ5IHJlZ3Jlc3Np
b24gbGlzdCBmb3IgY29udGFpbmluZyBodG1sIGxpbmtzIHRoYXQgSSB0cmllZCB0byByZW1vdmUu

--b1=_jTF5BhlPPxnPRstgXz2O5nAKhWBcO6Xr1F6r0U3QtY
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij48ZGl2IGNsYXNzPSJwcm90b25tYWlsX3F1b3RlIj48c3Bhbj5IaSw8L3NwYW4+PGRpdj5G
b3INCiB3aGF0IEkgcmVhZCBvbiB0aGUgcmVwb3J0aW5nIGlzc3VlLCBJIHRoaW5rIHRoZSBpc3N1
ZSBJIGFtIGZhY2luZyANCnF1YWxpZnkgZm9yIHJlZ3Jlc3Npb24sIGJ1dCBhcyBJIGFtIGEgbm9v
YiB5ZXQgSSdtIG5vdCBzdXJlLjwvZGl2PjxkaXY+SSByZXBvcnRlZCBpdCB0byBnaXRsYWIgbGlu
ayBhcyBkZXNjcmliZWQgaW4gdGhlIDxzcGFuPm1haW50YWluZXJzPC9zcGFuPiBsaXN0LiBCZWxv
dyBpcyB0aGUgaXNzdWUgcmVwb3J0IGxpbmsuPC9kaXY+PGRpdj5odHRwczovL2dpdGxhYi5mcmVl
ZGVza3RvcC5vcmcvZHJtL2FtZC8tL2lzc3Vlcy80MDk4PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5Tb3JyeSBmb3Igbm90IGJlZW4gY29uY2lzZSBlbm91Z2ggb24gdGhlIGlzc3VlIHJlcG9ydC48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlJlZ2FyZHMsPC9kaXY+PHNwYW4+TGVhbmRyby48L3Nw
YW4+PC9kaXY+PGRpdiBjbGFzcz0icHJvdG9ubWFpbF9xdW90ZSI+PGJyPjwvZGl2PjxkaXYgY2xh
c3M9InByb3Rvbm1haWxfcXVvdGUiPg0KICAgIDxiPk9CUzogcmVzZW50IGR1ZSB0byByZWZ1c2Ug
YnkgcmVncmVzc2lvbiBsaXN0IGZvciBjb250YWluaW5nIGh0bWwgbGlua3MgdGhhdCBJIHRyaWVk
IHRvIHJlbW92ZS48L2I+PC9kaXY+PC9kaXY+


--b1=_jTF5BhlPPxnPRstgXz2O5nAKhWBcO6Xr1F6r0U3QtY--

