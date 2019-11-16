Return-Path: <SRS0=bOP+=ZI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B67EC33C8C
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED51A214DE
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Nov 2019 16:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED51A214DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=online.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A46386E187;
	Sat, 16 Nov 2019 16:25:09 +0000 (UTC)
X-Greylist: delayed 304 seconds by postgrey-1.36 at gabe;
 Sat, 16 Nov 2019 07:19:28 UTC
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89D026E047
 for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov 2019 07:19:28 +0000 (UTC)
Received: from oxbsgw74.schlund.de ([172.19.248.120]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MQdtO-1iH7MG2Mw2-00NgMM for <amd-gfx@lists.freedesktop.org>; Sat, 16 Nov
 2019 08:14:22 +0100
X-Header: Open-Xchange USM Mailer (USM Version: 7.10.1-1, EAS Version:
 7.10.1-1, Build c4987799f06a2514ed4e083183a70d95864e7f2c)
Date: Sat, 16 Nov 2019 08:14:20 +0100
Subject: Rebasing of amd-staging-drm-next
Message-ID: <54001452.28591.1573888462309@localhost>
From: "Babutzka, Martin" <martin.babutzka@online.de>
To: amd-gfx@lists.freedesktop.org
MIME-Version: 1.0
X-Mailer: Open-Xchange Mailer v7.10.1-Rev23
X-Originating-Client: USM-EAS
X-Provags-ID: V03:K1:1rO+KH8K6NBBajvVrjPYO/jq3TYmi0kD2Q/iq4zpHgDIpzdzOa0
 ll/nxHBFhKlKdNrlx4HoPWR6fmcW4xGQ+lBHozgHw11W+PkfeaVetWux/RUTtSO3PYGeuvH
 IRgGC54u1cLTU3v5aik5FHNK5yoH7hxpajNu/s/ga1ch90kFxhQYKcYkAboTDNKeEr+UG3D
 RoytVvzrlAo8FND4kyCHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hTxcb3C7IEY=:mkvZOh9q1WQwd4mA15Q36E
 pfPbF8M12XzthSs65ovrvmyRJW+9nyv1rClZF+lzQmByPWGEJM8THVgNGYQmsP28Jc6pMzPFi
 sOnszZUoJ9J7t6XH+xYRQbIS/FauQOduMdrifwIduglc100INtoN5a1Oc37K7cBSdji7N3P9F
 dxURxY9y2oUfGiF/ZiMwLvZ3Qu6s/FLU4r4LOjct6O/x3ygm1eY0B5DyYVsU8olm4lZXoe251
 Hws1yospnCS8kVFUQ4BK18l1niIFgjELSAmkrqgF3XUzcvnuKawsjuNkly79V+uC4Nna0p1LI
 iMQiqX47V1riy73nNFZf+R69sjUzrcM7wgL8FVAdqFbTjyJ5JwsRkJbEaY17FXLoGjFB+eY5s
 sN0Vn39btHcr0VXqZhGzUZejAwaT76uFKOD1gIYp1gsXN82ohTvpui8FcAO3Gjv+M3Lh+kJxC
 ZpGDNEawMfQwiGobxng/iJ+K7R7OMvnpdmRFYIsK681VqmFmOr7e9TkF8WNfpnc7TxQZdyIE8
 QSRs/TeA2m0x3t2roQDMNBlxrTPqrBGrj53AHroiIWX83YvLyMjhfB7jqXdgc0PJdeYJgHGEe
 fjQzg9L184RCRZXcJDgM0/NbZWLpKj71WDHuuDnqiAF9MVW6n499YIk2zFOkq4oPuZeRjJ61T
 HBhFF6s1p4kF2rER/siiiOB2sXVrbKbD84ZwGZYtt2qEZKZTlMIL2Wvc2UgFJyw0RIT/4y6ig
 ASLtAdvvg7DUZZBsZNJCFOmmnITk9jr2tz7vnW6thPfF6EsxIjk2cVVPPCWA+n7QcbOqDb54D
 KbAElDLiGCD2b7dic1UlK4WBdXFNhslJfdOz3QMUkHsXH7ueF74EZQcrGf2MZKfBPkj+gU1YA
 3Z706a4/ZE539DtoXWsNbExVrCGOca8vWhVQKP558=
X-Mailman-Approved-At: Sat, 16 Nov 2019 16:25:06 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1787265811=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
Message-ID: <20191116071420.y1VA3HfxxwnE7rY7wARQgW65-H2o42j92KqjQ70OgpQ@z>

--===============1787265811==
Content-Type: multipart/alternative;
 boundary=--_com.ninefolders.hd3.email_413646434019270_alt

----_com.ninefolders.hd3.email_413646434019270_alt
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

RGVhciBBTUQgZGV2ZWxvcGVycywKCkFyZSB0aGVyZSBwbGFucyB0byByZWJhc2UgdGhlIHN0YWdp
bmcga2VubmVsIHRvIDUuND8gV291bGQgYmUgZ3JlYXQgYmVjYXVzZSA1LjMgZG9lcyBub3QgYnVp
bGRzIHByb3Blcmx5IGZvciBtZS4KCk1hbnkgcmVnYXJkcywKTWFydGluCgoK
----_com.ninefolders.hd3.email_413646434019270_alt
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGh0bWw+PGJvZHk+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6Q2FsaWJyaSwgQXJpYWwsIEhlbHZl
dGljYSwgc2Fucy1zZXJpZjsgZm9udC1zaXplOjEyLjBwdDsgbGluZS1oZWlnaHQ6MS4zOyBjb2xv
cjojMDAwMDAwIj48IS0tICMjIyMjIE5JTkUgQk9EWSBCRUdJTiAjIyMjIyAtLT5EZWFyIEFNRCBk
ZXZlbG9wZXJzLDxicj48YnI+QXJlIHRoZXJlIHBsYW5zIHRvIHJlYmFzZSB0aGUgc3RhZ2luZyBr
ZW5uZWwgdG8gNS40PyBXb3VsZCBiZSBncmVhdCBiZWNhdXNlIDUuMyBkb2VzIG5vdCBidWlsZHMg
cHJvcGVybHkgZm9yIG1lLjxicj48YnI+TWFueSByZWdhcmRzLDxicj5NYXJ0aW48YnI+PGRpdiBp
ZD0ic2lnbmF0dXJlLXgiIHN0eWxlPSItd2Via2l0LXVzZXItc2VsZWN0Om5vbmU7IGZvbnQtZmFt
aWx5OkNhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZToxMi4w
cHQ7IGNvbG9yOiMwMDAwMDAiIGNsYXNzID0gInNpZ25hdHVyZV9lZGl0b3IiPjxkaXY+PGJyPjwv
ZGl2PjwvZGl2PjwhLS0gIyMjIyMgTklORSBCT0RZIEVORCAjIyMjIyAtLT48L2Rpdj48ZGl2IGNs
YXNzPSJxdW90ZWRfb3V0cHV0X2JvZHkiPjxkaXYgaWQ9InF1b3RlZF9oZWFkZXIiIGNsYXNzPSJx
dW90ZWRfaGVhZGVyX2VkaXRvciIgc3R5bGU9ImNsZWFyOmJvdGg7Ij4gPC9kaXY+PGJyIHR5cGU9
J2F0dHJpYnV0aW9uJz48ZGl2IGlkPSJxdW90ZWRfYm9keSIgY2xhc3M9InF1b3RlZF9ib2R5X2Vk
aXRvciI+PC9kaXY+PC9kaXY+PC9ib2R5PjwvaHRtbD4=
----_com.ninefolders.hd3.email_413646434019270_alt--

--===============1787265811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4

--===============1787265811==--
