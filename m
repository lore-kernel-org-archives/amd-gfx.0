Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9966C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 17:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8887710E7F5;
	Fri,  3 Feb 2023 17:05:37 +0000 (UTC)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FC6A10E7F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 16:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1675443212; bh=vEirr8Rre0LvMnF/AWtvcOSyrfRMsFe2mH4N/XoW3Jo=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
 b=gPGwhr92GWgAPMqQY3d29bs7ivOPObwZmYPIhpKU237XyfbMTLZtS+x6UJ7oJ77m+
 BLvBP7fO/V1ZQ8BjXjIVeDaPLS3fbeY3GJDUXzCjkBW5DBPLLu3zecqzQg2WboHxFV
 g4BV/gemTsLqc+Ohb27KCW5qFXUW37qr+yqufL1WMYgAdMCJ2MF/RuYprFlB4WJaUk
 S5cTyZZNKFrMGWbqOqHDGfdLodtrJiykLpIVjaDzmbclyTPmOTliFYuKbeL8Mme9HJ
 0+xuUJF5chM8utWFnEzGxGzMidM8EcqGReGJx8wkUBm+u0X9PXf7dzWYfsvdmIYZhW
 RnBt/0W9O5A/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.0.101] ([176.198.191.160]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1ohTd50VPL-00hsSf; Fri, 03
 Feb 2023 17:53:32 +0100
Message-ID: <799644ff4daab0ac75f571870db2950c091300d7.camel@web.de>
Subject: Re: [PATCH] drm/amd: fix memory leak in amdgpu_cs_sync_rings
From: Bert Karwatzki <spasswolf@web.de>
To: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 03 Feb 2023 17:53:31 +0100
In-Reply-To: <CADnq5_N97JdMT_yk-X+RgMuO_=P3FNaYFN7URvNc38icGkjxWQ@mail.gmail.com>
References: <905de6ced5f1798deb21a523910a05cf9ff691bc.camel@web.de>
 <CADnq5_N97JdMT_yk-X+RgMuO_=P3FNaYFN7URvNc38icGkjxWQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Provags-ID: V03:K1:2KglpHx+F3nvQIg31JEXM7OsPHLMaKXaSMZsu9aRYBAGnkrzCSY
 Km1dGAYSflnKQp2p9qWOwQClSugZbujY4Q3hIUrv5tJfOPHFDSmbaa0Gy2xG0A8Jgdi/AA0
 R2HPm0VtKCuinody0BjGZQf28fObXqfqARZSEXuvMHicyGY7qr+1i7E032Gu6RwyODpgw8u
 eHlHeFoxL4gttMptfbPcw==
UI-OutboundReport: notjunk:1;M01:P0:f/YtJCZxJ9I=;aXiv+ZVffkbj8kVgGl7SJkA8/jH
 rwOgxSQEcsGdrrbrRbHaK5Lrzb5AM5ab5FHmuRagolNM8UZ8vKYun0UYWAmZHLOLdrLaWjw9/
 cXg5qmB+yaCaaP3dcJjbJKBaCATt1ZTY73nyFR2Ixq4Mn8KkLmtd2Q4YhaOpfa9KnCOB0gPK8
 nByPyIpx3aVQDZWXX3tLwPlMW8f825OlqJdElWwnjx8ZZDvLHLgGHJSZn75KEBbclauDd4Oaw
 tbK9ABPQDNwWdRQPrN+uCaAQloqjTA8krK22g3jChIpaCCRGR7dQR4/b0QrsmFvvKtxcRUDmc
 hv83VepZac7ttG0q4N27wlcxndgOLHwdf0lBiE8OvIWLA0djhEdUYlIa2NR5CKY0/2sjxc5wG
 JTf2sA2SKdVntma8tYIpHP04l/H3aTWsn9yctmVqbqcBHaWFwOvGPp4c9IuomzliZolFzKuGU
 VDXLW+s/SV2ivSq7Xl0YVmxRFrBIqPY637aXpbMhyIUhCDPTKHX7t9usxBzaLT5wmhcA1JjIG
 ZcSFJKb4riB236CXlCS0Xhet7iFuDpo9PqK4wDPHLXGSHYRrjfnnzrGRuRjynp7ex5GCNAIqC
 y+Fb1wlFzUZ9S18PGDVTY5qSV6b60Fs9kjhewQlwk1HhgItWZcQrqkocRo3Udlja0xyFXSu8g
 71EnbVQo39SaFQo7FSRfgL06qe5KCFzBx9pCuL2RSG0lJt5cD9CunYalViZ2ZfZmicausSADb
 w7tUTcf3mlARCBGnZazVwo01qMIcM5OSisypPUT/rwEKhCAGM/bYuSqC0bDPE12Z6Ykye2ZNg
 itSVjcFgj5Ib+QgDiGnSDywWi/+q9NB+7EGDXXTkP7j8Fav7I/MWb5znhjuu2mktcaq6CeW3E
 gkDMOSopiwX+SZ7u26Yy4aE3F3+tFZjVgEJpAPI6Tl8JTVG1dNjunk2QcwKQYXXSrKBXV+Any
 xcDGzin43ofMlnoWcsZxLbnrqgs=
X-Mailman-Approved-At: Fri, 03 Feb 2023 17:05:35 +0000
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

SGVyZSBpcyB0aGUgZml4IGZvciAoc2VuZCBhZ2FpbiB0byB0ZXN0IGlmIEkgY2FuIGdldCBpdCBy
aWdodCB3aXRoCkV2b2x1dGlvbikKQnVnOiBodHRwczovL2dpdGxhYi5mcmVlZGVza3RvcC5vcmcv
ZHJtL2FtZC8tL2lzc3Vlcy8yMzYwCgpGcm9tIDZlMDY0Yzk1NjVlZjBkYTg5MGYzZmNiMmE0ZjZh
OGNkNDRhMTJmZGIgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxCkZyb206IEJlcnQgS2Fyd2F0emtp
IDxzcGFzc3dvbGZAd2ViLmRlPgpEYXRlOiBUaHUsIDIgRmViIDIwMjMgMTk6NTA6MjcgKzAxMDAK
U3ViamVjdDogW1BBVENIXSBGaXggbWVtb3J5IGxlYWsgaW4gYW1kZ3B1X2NzX3N5bmNfcmluZ3Mu
CgpTaWduZWQtb2ZmLWJ5OiBCZXJ0IEthcndhdHpraSA8c3Bhc3N3b2xmQHdlYi5kZT4KLS0tCsKg
ZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2NzLmMgfCA1ICsrKystCsKgMSBmaWxl
IGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCmIvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvYW1kZ3B1X2NzLmMKaW5kZXggMGY0Y2I0MTA3OGMxLi4wOGVjZWQwOTdiZDggMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9jcy5jCkBAIC0xMjIyLDEwICsxMjIyLDEz
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X2NzX3N5bmNfcmluZ3Moc3RydWN0CmFtZGdwdV9jc19wYXJz
ZXIgKnApCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogbmV4dCBqb2IgYWN0dWFs
bHkgc2VlcyB0aGUgcmVzdWx0cyBmcm9tIHRoZQpwcmV2aW91cyBvbmUKwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKiBiZWZvcmUgd2Ugc3RhcnQgZXhlY3V0aW5nIG9uIHRoZSBzYW1l
IHNjaGVkdWxlcgpyaW5nLgrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwotwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFzX2ZlbmNlIHx8IHNfZmVuY2UtPnNjaGVk
ICE9IHNjaGVkKQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgaWYgKCFzX2ZlbmNlIHx8
IHNfZmVuY2UtPnNjaGVkICE9IHNjaGVkKSB7CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgZG1hX2ZlbmNlX3B1dChmZW5jZSk7CsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGNvbnRpbnVlOworwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgfQrCoArCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHIgPSBh
bWRncHVfc3luY19mZW5jZSgmcC0+Z2FuZ19sZWFkZXItPmV4cGxpY2l0X3N5bmMsCmZlbmNlKTsK
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRtYV9mZW5jZV9wdXQoZmVuY2UpOwrCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChyKQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcjsKwqDCoMKgwqDCoMKgwqDCoH0KCg==

