Return-Path: <SRS0=xWtd=E6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8921DC2D0E4
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 08:16:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F67206E0
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Nov 2020 08:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06F67206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lovehindpa.ws
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 323BA6E23F;
	Tue, 24 Nov 2020 08:16:36 +0000 (UTC)
Received: from mail1.protonmail.ch (mail1.protonmail.ch [185.70.40.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3414D6E0DC
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Nov 2020 21:41:11 +0000 (UTC)
Date: Mon, 23 Nov 2020 21:40:58 +0000
Authentication-Results: mail1.protonmail.ch; dkim=none
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
From: Wolf <wolf@lovehindpa.ws>
Subject: Patch for omitted register.
Message-ID: <PkbXNt15p4QVXrLbfU2zPIGAfaKY8MTX8-Fa2xBqZ5V-5LuPkU8XaVtv_p1EUhJBhVOiPIZj4ODK9mnuJkwLMwuLZdk57TcpOQJnRkY6p1Y=@lovehindpa.ws>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="b1_cIFKpgb14N8RFfqLVkemw0uJ2iu25pzgdG1e7cuQ"
X-Mailman-Approved-At: Tue, 24 Nov 2020 08:16:35 +0000
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
Reply-To: Wolf <wolf@lovehindpa.ws>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.

--b1_cIFKpgb14N8RFfqLVkemw0uJ2iu25pzgdG1e7cuQ
Content-Type: multipart/alternative;
 boundary="b2_cIFKpgb14N8RFfqLVkemw0uJ2iu25pzgdG1e7cuQ"

--b2_cIFKpgb14N8RFfqLVkemw0uJ2iu25pzgdG1e7cuQ
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64

U21hbGwgcmVnaXN0ZXIgb3Zlcmxvb2tlZC4=

--b2_cIFKpgb14N8RFfqLVkemw0uJ2iu25pzgdG1e7cuQ
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: base64

PGRpdj5TbWFsbCByZWdpc3RlciBvdmVybG9va2VkLjxicj48L2Rpdj4=


--b2_cIFKpgb14N8RFfqLVkemw0uJ2iu25pzgdG1e7cuQ--

--b1_cIFKpgb14N8RFfqLVkemw0uJ2iu25pzgdG1e7cuQ
Content-Type: application/octet-stream; name=0001-Added-omitted-SMUIO-v11.0.0-register-ROM_SW_SECURE.patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=0001-Added-omitted-SMUIO-v11.0.0-register-ROM_SW_SECURE.patch

RnJvbSA4ZWUyYjllNjJmNDM2Y2VlMzZmZTgyOTVhMDg0OTA4MTgxN2I3MTJmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBYXJvbiBSaWNlIDx3b2xmQGxvdmVoaW5kcGEud3M+CkRhdGU6
IE1vbiwgMjMgTm92IDIwMjAgMTU6NDg6MTMgLTA2MDAKU3ViamVjdDogW1BBVENIXSBBZGRlZCBv
bWl0dGVkIFNNVUlPIHYxMS4wLjAgcmVnaXN0ZXIsIFJPTV9TV19TRUNVUkUuCgotLS0KIC4uLi9n
cHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNfcmVnL3NtdWlvL3NtdWlvXzExXzBfMF9vZmZzZXQuaCAg
IHwgMiArKwogLi4uL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvc211aW8vc211aW9fMTFf
MF8wX3NoX21hc2suaCAgfCAzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvc211aW8v
c211aW9fMTFfMF8wX29mZnNldC5oIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNf
cmVnL3NtdWlvL3NtdWlvXzExXzBfMF9vZmZzZXQuaAppbmRleCA2ODdkNjg0M2MyNTguLjlmNjcy
YTUyZDQ5MiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2FtZC9pbmNsdWRlL2FzaWNfcmVn
L3NtdWlvL3NtdWlvXzExXzBfMF9vZmZzZXQuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2lu
Y2x1ZGUvYXNpY19yZWcvc211aW8vc211aW9fMTFfMF8wX29mZnNldC5oCkBAIC00MzksNiArNDM5
LDggQEAKICNkZWZpbmUgbW1PUEVOX0RSQUlOX1NFTEVDVF9CQVNFX0lEWCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAwCiAj
ZGVmaW5lIG1tU01JT19FTkFCTEUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwMTYzCiAjZGVm
aW5lIG1tU01JT19FTkFCTEVfQkFTRV9JRFggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMAorI2RlZmluZSBtbVJP
TV9TV19TRUNVUkUgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MDE2NQorI2RlZmluZSBtbVJPTV9T
V19TRUNVUkVfQkFTRV9JRFggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDAKICNkZWZpbmUgbW1TTVVfR1BJT1BBRF9T
MCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAweDAxNjYKICNkZWZpbmUgbW1TTVVfR1BJT1BBRF9TMF9C
QVNFX0lEWCAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAwCiAjZGVmaW5lIG1tU01VX0dQSU9QQURfUzEgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgMHgwMTY3CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1
ZGUvYXNpY19yZWcvc211aW8vc211aW9fMTFfMF8wX3NoX21hc2suaCBiL2RyaXZlcnMvZ3B1L2Ry
bS9hbWQvaW5jbHVkZS9hc2ljX3JlZy9zbXVpby9zbXVpb18xMV8wXzBfc2hfbWFzay5oCmluZGV4
IDY5MDVhOTYxODEyNy4uNTA2Nzc5YTYyNTY0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YW1kL2luY2x1ZGUvYXNpY19yZWcvc211aW8vc211aW9fMTFfMF8wX3NoX21hc2suaAorKysgYi9k
cml2ZXJzL2dwdS9kcm0vYW1kL2luY2x1ZGUvYXNpY19yZWcvc211aW8vc211aW9fMTFfMF8wX3No
X21hc2suaApAQCAtOTY1LDYgKzk2NSw5IEBACiAvL1NNSU9fRU5BQkxFCiAjZGVmaW5lIFNNSU9f
RU5BQkxFX19TTUlPX0VOQUJMRV9fU0hJRlQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4MAogI2RlZmluZSBTTUlP
X0VOQUJMRV9fU01JT19FTkFCTEVfTUFTSyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAweEZGRkZGRkZGTAorLy9S
T01fU1dfU0VDVVJFCisjZGVmaW5lIFJPTV9TV19TRUNVUkVfX1JPTV9XUl9BQ0NFU1NfRElTQUJM
RV9fU0hJRlQgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDB4MAorI2RlZmluZSBST01fU1dfU0VDVVJFX19ST01fV1JfQUNDRVNTX0RJU0FC
TEVfTUFTSyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAweDEKIC8vU01VX0dQSU9QQURfUzAKICNkZWZpbmUgU01VX0dQSU9QQURfUzBf
X0dQSU9fUzBfX1NISUZUICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMHgwCiAjZGVmaW5lIFNNVV9HUElPUEFEX1Mw
X19HUElPX1MwX01BU0sgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDB4N0ZGRkZGRkZMCi0tIAoyLjI1LjAKCg==

--b1_cIFKpgb14N8RFfqLVkemw0uJ2iu25pzgdG1e7cuQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--b1_cIFKpgb14N8RFfqLVkemw0uJ2iu25pzgdG1e7cuQ--

