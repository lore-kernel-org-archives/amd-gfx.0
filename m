Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0F8FC36010
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Apr 2025 14:10:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2950E10E5CA;
	Tue,  1 Apr 2025 14:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=cardosozeferino.com header.i=@cardosozeferino.com header.b="qErfB1KR";
	dkim-atps=neutral
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7F110E162
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Mar 2025 18:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cardosozeferino.com;
 s=protonmail; t=1743446407; x=1743705607;
 bh=vby18K8YM7W4T4LaxESHy1zGQDgI+JH421HM5JdRfhQ=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
 List-Unsubscribe:List-Unsubscribe-Post;
 b=qErfB1KRo7rUpeJl6x+p7MdAjiu1EcA8M4BuYaEfR6Bh+xNcnxe9ltgtPJjDHi+fR
 gFPfb9pWElsXcvRs6CAL9rd+FbUZ2v0pshBG6bvMZV876ga/eMnbwkULp+6Y5Xku6j
 m5X7Z9NxFDCFukomQWf+Fwipqb+ICmUFzsVQRqyhCnI8SHI37iuHTNoh1MncVbmgjl
 hNq1qkQW0qytsdk2FldEfdljKhi/6l1vFCkCCAcGK7UNyCoOlxyCJwY0h8ovFjNKm9
 NOVrO6y5we5B0lhyyF2VjQwaQLWPs6173sWaztZkR1ir8Qh7raYD7fw73t2yfimcJo
 LfYya6mNYMAAA==
Date: Mon, 31 Mar 2025 18:40:03 +0000
To: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
From: Leo <leo.cod@cardosozeferino.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Felix.Kuehling@amd.com" <Felix.Kuehling@amd.com>
Subject: regression bisected RX580 GPU crash chipset overheating (kernel 6.8
 and later)
Message-ID: <aHeSm_VYiQumMlj0NrCwhY5Fq9C_B26HgIjZDf4Vvd9KuRae3sY3pYng-sr4gzhyf9Ioto7PzIVm6UbXwuGjyCusKT-ldRZREFpfEbKnPtk=@cardosozeferino.com>
Feedback-ID: 79006605:user:proton
X-Pm-Message-ID: 5d8ad78fd21a68f5ff73e5d735dc98d3b4c1a093
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="b1=_TDcze65H0D0s6mbZZuCBSKHWPa6gmKFWhTWzPykWxA"
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

--b1=_TDcze65H0D0s6mbZZuCBSKHWPa6gmKFWhTWzPykWxA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

SGksCkZvciB3aGF0IEkgcmVhZCBvbiB0aGUgcmVwb3J0aW5nIGlzc3VlLCBJIHRoaW5rIHRoZSBp
c3N1ZSBJIGFtIGZhY2luZyBxdWFsaWZ5IGZvciByZWdyZXNzaW9uLCBidXQgYXMgSSBhbSBhIG5v
b2IgeWV0IEknbSBub3Qgc3VyZS4KSSByZXBvcnRlZCBpdCB0byBnaXRsYWIgbGluayBhcyBkZXNj
cmliZWQgaW4gdGhlIG1haW50YWluZXJzIGxpc3QuIEJlbG93IGlzIHRoZSBpc3N1ZSByZXBvcnQg
bGluay4KaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvNDA5
OAoKU29ycnkgZm9yIG5vdCBiZWVuIGNvbmNpc2UgZW5vdWdoIG9uIHRoZSBpc3N1ZSByZXBvcnQu
CgpSZWdhcmRzLApMZWFuZHJvLg==

--b1=_TDcze65H0D0s6mbZZuCBSKHWPa6gmKFWhTWzPykWxA
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0
cHg7Ij5IaSw8L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7
IGZvbnQtc2l6ZTogMTRweDsiPkZvciB3aGF0IEkgcmVhZCBvbiB0aGUgcmVwb3J0aW5nIGlzc3Vl
LCBJIHRoaW5rIHRoZSBpc3N1ZSBJIGFtIGZhY2luZyBxdWFsaWZ5IGZvciByZWdyZXNzaW9uLCBi
dXQgYXMgSSBhbSBhIG5vb2IgeWV0IEknbSBub3Qgc3VyZS48L2Rpdj48ZGl2IHN0eWxlPSJmb250
LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiPkkgcmVwb3J0ZWQg
aXQgdG8gZ2l0bGFiIGxpbmsgYXMgZGVzY3JpYmVkIGluIHRoZSA8c3Bhbj5tYWludGFpbmVyczwv
c3Bhbj4gbGlzdC4gQmVsb3cgaXMgdGhlIGlzc3VlIHJlcG9ydCBsaW5rLjwvZGl2PjxkaXYgc3R5
bGU9ImZvbnQtZmFtaWx5OiBBcmlhbCwgc2Fucy1zZXJpZjsgZm9udC1zaXplOiAxNHB4OyI+PHNw
YW4+PGEgdGFyZ2V0PSJfYmxhbmsiIHJlbD0ibm9yZWZlcnJlciBub2ZvbGxvdyBub29wZW5lciIg
aHJlZj0iaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvNDA5
OCI+aHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvNDA5ODwv
YT48L3NwYW4+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlm
OyBmb250LXNpemU6IDE0cHg7Ij48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFy
aWFsLCBzYW5zLXNlcmlmOyBmb250LXNpemU6IDE0cHg7Ij5Tb3JyeSBmb3Igbm90IGJlZW4gY29u
Y2lzZSBlbm91Z2ggb24gdGhlIGlzc3VlIHJlcG9ydC48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZh
bWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiPjxicj48L2Rpdj48ZGl2
IHN0eWxlPSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsi
PlJlZ2FyZHMsPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IEFyaWFsLCBzYW5zLXNlcmlm
OyBmb250LXNpemU6IDE0cHg7Ij5MZWFuZHJvLjwvZGl2Pg0KPGRpdiBjbGFzcz0icHJvdG9ubWFp
bF9zaWduYXR1cmVfYmxvY2sgcHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stZW1wdHkiIHN0eWxl
PSJmb250LWZhbWlseTogQXJpYWwsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTRweDsiPg0KICAg
IDxkaXYgY2xhc3M9InByb3Rvbm1haWxfc2lnbmF0dXJlX2Jsb2NrLXVzZXIgcHJvdG9ubWFpbF9z
aWduYXR1cmVfYmxvY2stZW1wdHkiPjwvZGl2Pg0KICAgIA0KICAgICAgICAgICAgPGRpdiBjbGFz
cz0icHJvdG9ubWFpbF9zaWduYXR1cmVfYmxvY2stcHJvdG9uIHByb3Rvbm1haWxfc2lnbmF0dXJl
X2Jsb2NrLWVtcHR5Ij4NCiAgICAgICAgDQogICAgICAgICAgICA8L2Rpdj4NCjwvZGl2Pg0K


--b1=_TDcze65H0D0s6mbZZuCBSKHWPa6gmKFWhTWzPykWxA--

